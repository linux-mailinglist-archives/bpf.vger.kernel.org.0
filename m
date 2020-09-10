Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D44264F97
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 21:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgIJTrD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 15:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731016AbgIJPZc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 11:25:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA812206CA;
        Thu, 10 Sep 2020 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599751157;
        bh=ZN0SJ1EKwbOTD/lLKidKKAYKB4i/3mXVLc4HpIBVubc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cu5hyaKqUfGfXcehap6i+RedbshMx+EhKZbFOynd70ml3gkI4AQOutRe8rfYdD7/C
         Nd/XLJ1/AyYOltvl+63cuYOih+nTJ43R1Hq28YiCBTy82pJxWXfwz1weMcAvHi3WXD
         oCaNRMeucqh2dJ324hcN0PvciGaqmHzkyiz+mo4o=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1E0E340D3D; Thu, 10 Sep 2020 12:19:13 -0300 (-03)
Date:   Thu, 10 Sep 2020 12:19:12 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, jakub@cloudflare.com,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCH bpf] bpf: plug hole in struct bpf_sk_lookup_kern
Message-ID: <20200910151912.GF4018363@kernel.org>
References: <20200910110248.198326-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910110248.198326-1-lmb@cloudflare.com>
X-Url:  http://acmel.wordpress.com
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Sep 10, 2020 at 12:02:48PM +0100, Lorenz Bauer escreveu:
> As Alexei points out, struct bpf_sk_lookup_kern has two 4-byte holes.
> This leads to suboptimal instructions being generated (IPv4, x86):
> 
>     1372                    struct bpf_sk_lookup_kern ctx = {
>        0xffffffff81b87f30 <+624>:   xor    %eax,%eax
>        0xffffffff81b87f32 <+626>:   mov    $0x6,%ecx
>        0xffffffff81b87f37 <+631>:   lea    0x90(%rsp),%rdi
>        0xffffffff81b87f3f <+639>:   movl   $0x110002,0x88(%rsp)
>        0xffffffff81b87f4a <+650>:   rep stos %rax,%es:(%rdi)
>        0xffffffff81b87f4d <+653>:   mov    0x8(%rsp),%eax
>        0xffffffff81b87f51 <+657>:   mov    %r13d,0x90(%rsp)
>        0xffffffff81b87f59 <+665>:   incl   %gs:0x7e4970a0(%rip)
>        0xffffffff81b87f60 <+672>:   mov    %eax,0x8c(%rsp)
>        0xffffffff81b87f67 <+679>:   movzwl 0x10(%rsp),%eax
>        0xffffffff81b87f6c <+684>:   mov    %ax,0xa8(%rsp)
>        0xffffffff81b87f74 <+692>:   movzwl 0x38(%rsp),%eax
>        0xffffffff81b87f79 <+697>:   mov    %ax,0xaa(%rsp)
> 
> Fix this by moving around sport and dport. pahole confirms there
> are no more holes:
> 
>     struct bpf_sk_lookup_kern {
>         u16                        family;       /*     0     2 */
>         u16                        protocol;     /*     2     2 */
>         __be16                     sport;        /*     4     2 */
>         u16                        dport;        /*     6     2 */
>         struct {
>                 __be32             saddr;        /*     8     4 */
>                 __be32             daddr;        /*    12     4 */
>         } v4;                                    /*     8     8 */
>         struct {
>                 const struct in6_addr  * saddr;  /*    16     8 */
>                 const struct in6_addr  * daddr;  /*    24     8 */
>         } v6;                                    /*    16    16 */
>         struct sock *              selected_sk;  /*    32     8 */
>         bool                       no_reuseport; /*    40     1 */
> 
>         /* size: 48, cachelines: 1, members: 8 */
>         /* padding: 7 */
>         /* last cacheline: 48 bytes */
>     };

Cool, looking at:

[root@five ~]# pahole --sizes | grep ^bpf | sort -nr -k2 | head
bpf_ringbuf	12288	4
bpf_ctx_convert	6960	0
bpf_verifier_env	4816	3
bpf_func_state	1360	1
bpf_trace_sample_data	1152	0
bpf_verifier_log	1048	1
bpf_dispatcher	1048	2
bpf_struct_ops	976	0
bpf_seq_printf_buf	768	0
bpf_htab	640	1
[root@five ~]# pahole --sizes | grep ^bpf | sort -nr -k3 | head
bpf_ringbuf	12288	4
bpf_verifier_env	4816	3
bpf_verifier_state	120	2
bpf_trampoline	376	2
bpf_sk_lookup_kern	56	2
bpf_reg_state	120	2
bpf_func_proto	64	2
bpf_dispatcher	1048	2
bpf_verifier_log	1048	1
bpf_struct_ops_value	64	1
[root@five ~]#

second column is size, third is number of holes (before your patch).

bpf_ringbuf is interesting (this is all using /sys/kernel/btf/vmlinux):

[root@five ~]# pahole bpf_ringbuf
struct bpf_ringbuf {
	wait_queue_head_t          waitq;                /*     0    24 */
	struct irq_work            work;                 /*    24    24 */
	u64                        mask;                 /*    48     8 */
	struct page * *            pages;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	int                        nr_pages;             /*    64     4 */

	/* XXX 60 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	spinlock_t                 spinlock;             /*   128     4 */

	/* XXX 3964 bytes hole, try to pack */

	/* --- cacheline 64 boundary (4096 bytes) --- */
	long unsigned int          consumer_pos;         /*  4096     8 */

	/* XXX 4088 bytes hole, try to pack */

	/* --- cacheline 128 boundary (8192 bytes) --- */
	long unsigned int          producer_pos;         /*  8192     8 */

	/* XXX 4088 bytes hole, try to pack */

	/* --- cacheline 192 boundary (12288 bytes) --- */
	char                       data[];               /* 12288     0 */

	/* size: 12288, cachelines: 192, members: 9 */
	/* sum members: 88, holes: 4, sum holes: 12200 */
};
[root@five ~]#

Which seems crazy, lemme see using DWARF:

[root@five ~]# pahole -F dwarf bpf_ringbuf
struct bpf_ringbuf {
	wait_queue_head_t          waitq;                /*     0    24 */
	struct irq_work            work;                 /*    24    24 */
	u64                        mask;                 /*    48     8 */
	struct page * *            pages;                /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	int                        nr_pages;             /*    64     4 */

	/* XXX 60 bytes hole, try to pack */

	/* --- cacheline 2 boundary (128 bytes) --- */
	spinlock_t                 spinlock __attribute__((__aligned__(64))); /*   128     4 */

	/* XXX 3964 bytes hole, try to pack */

	/* --- cacheline 64 boundary (4096 bytes) --- */
	long unsigned int          consumer_pos __attribute__((__aligned__(4096))); /*  4096     8 */

	/* XXX 4088 bytes hole, try to pack */

	/* --- cacheline 128 boundary (8192 bytes) --- */
	long unsigned int          producer_pos __attribute__((__aligned__(4096))); /*  8192     8 */

	/* XXX 4088 bytes hole, try to pack */

	/* --- cacheline 192 boundary (12288 bytes) --- */
	char                       data[] __attribute__((__aligned__(4096))); /* 12288     0 */

	/* size: 12288, cachelines: 192, members: 9 */
	/* sum members: 88, holes: 4, sum holes: 12200 */
	/* forced alignments: 4, forced holes: 4, sum forced holes: 12200 */
} __attribute__((__aligned__(4096)));
[root@five ~]#

Yeah, matches the header files:

struct bpf_ringbuf {
        wait_queue_head_t waitq;
        struct irq_work work;
        u64 mask;
        struct page **pages;
        int nr_pages;
        spinlock_t spinlock ____cacheline_aligned_in_smp;
        /* Consumer and producer counters are put into separate pages to allow
         * mapping consumer page as r/w, but restrict producer page to r/o.
         * This protects producer position from being modified by user-space
         * application and ruining in-kernel position tracking.
         */
        unsigned long consumer_pos __aligned(PAGE_SIZE);
        unsigned long producer_pos __aligned(PAGE_SIZE);
        char data[] __aligned(PAGE_SIZE);
};


But:

[root@five ~]# pahole bpf_verifier_env
struct bpf_verifier_env {
	u32                        insn_idx;             /*     0     4 */
	u32                        prev_insn_idx;        /*     4     4 */
	struct bpf_prog *          prog;                 /*     8     8 */
	const struct bpf_verifier_ops  * ops;            /*    16     8 */
	struct bpf_verifier_stack_elem * head;           /*    24     8 */
	int                        stack_size;           /*    32     4 */
	bool                       strict_alignment;     /*    36     1 */
	bool                       test_state_freq;      /*    37     1 */

	/* XXX 2 bytes hole, try to pack */

	struct bpf_verifier_state * cur_state;           /*    40     8 */
	struct bpf_verifier_state_list * * explored_states; /*    48     8 */
	struct bpf_verifier_state_list * free_list;      /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct bpf_map *           used_maps[64];        /*    64   512 */
	/* --- cacheline 9 boundary (576 bytes) --- */
	u32                        used_map_cnt;         /*   576     4 */
	u32                        id_gen;               /*   580     4 */
	bool                       allow_ptr_leaks;      /*   584     1 */
	bool                       allow_ptr_to_map_access; /*   585     1 */
	bool                       bpf_capable;          /*   586     1 */
	bool                       bypass_spec_v1;       /*   587     1 */
	bool                       bypass_spec_v4;       /*   588     1 */
	bool                       seen_direct_write;    /*   589     1 */

	/* XXX 2 bytes hole, try to pack */

	struct bpf_insn_aux_data * insn_aux_data;        /*   592     8 */
	const struct bpf_line_info  * prev_linfo;        /*   600     8 */
	struct bpf_verifier_log    log;                  /*   608  1048 */
	/* --- cacheline 25 boundary (1600 bytes) was 56 bytes ago --- */
	struct bpf_subprog_info    subprog_info[257];    /*  1656  3084 */

	/* XXX 4 bytes hole, try to pack */

	/* --- cacheline 74 boundary (4736 bytes) was 8 bytes ago --- */
	struct {
		int *              insn_state;           /*  4744     8 */
		int *              insn_stack;           /*  4752     8 */
		int                cur_stack;            /*  4760     4 */
	} cfg;                                           /*  4744    24 */

	/* XXX last struct has 4 bytes of padding */

	u32                        pass_cnt;             /*  4768     4 */
	u32                        subprog_cnt;          /*  4772     4 */
	u32                        prev_insn_processed;  /*  4776     4 */
	u32                        insn_processed;       /*  4780     4 */
	u32                        prev_jmps_processed;  /*  4784     4 */
	u32                        jmps_processed;       /*  4788     4 */
	u64                        verification_time;    /*  4792     8 */
	/* --- cacheline 75 boundary (4800 bytes) --- */
	u32                        max_states_per_insn;  /*  4800     4 */
	u32                        total_states;         /*  4804     4 */
	u32                        peak_states;          /*  4808     4 */
	u32                        longest_mark_read_walk; /*  4812     4 */

	/* size: 4816, cachelines: 76, members: 36 */
	/* sum members: 4808, holes: 3, sum holes: 8 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 16 bytes */
};
[root@five ~]#

[root@five ~]# pahole --reorganize bpf_verifier_env | tail
	u32                        jmps_processed;       /*  4788     4 */
	u64                        verification_time;    /*  4792     8 */
	/* --- cacheline 75 boundary (4800 bytes) --- */
	u32                        max_states_per_insn;  /*  4800     4 */
	u32                        total_states;         /*  4804     4 */

	/* size: 4808, cachelines: 76, members: 36 */
	/* paddings: 1, sum paddings: 4 */
	/* last cacheline: 8 bytes */
};   /* saved 8 bytes! */
[root@five ~]#


And headers have no explicit alignment in the headers. Maybe doing the
reorg will not help.

But looking at disasm for rep stos + pahole... humm...

:-)

One last comment:

[root@five ~]# pahole bpf_trampoline
struct bpf_trampoline {
	struct hlist_node          hlist;                /*     0    16 */
	struct mutex               mutex;                /*    16    32 */
	refcount_t                 refcnt;               /*    48     4 */

	/* XXX 4 bytes hole, try to pack */

	u64                        key;                  /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	struct {
		struct btf_func_model model;             /*    64    14 */

		/* XXX 2 bytes hole, try to pack */

		void *             addr;                 /*    80     8 */
		bool               ftrace_managed;       /*    88     1 */
	} func;                                          /*    64    32 */

	/* XXX last struct has 7 bytes of padding */

	struct bpf_prog *          extension_prog;       /*    96     8 */
	struct hlist_head          progs_hlist[3];       /*   104    24 */
	/* --- cacheline 2 boundary (128 bytes) --- */
	int                        progs_cnt[3];         /*   128    12 */

	/* XXX 4 bytes hole, try to pack */

	void *                     image;                /*   144     8 */
	u64                        selector;             /*   152     8 */
	struct bpf_ksym            ksym;                 /*   160   216 */

	/* XXX last struct has 7 bytes of padding */

	/* size: 376, cachelines: 6, members: 11 */
	/* sum members: 368, holes: 2, sum holes: 8 */
	/* paddings: 2, sum paddings: 14 */
	/* last cacheline: 56 bytes */
};
[root@five ~]#

perhaps moving ftrace_managed to before addr in that anonymous struct on
the 'func' member may help?

- Arnaldo

