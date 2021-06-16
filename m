Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1FD53A8F70
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 05:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhFPDlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 23:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbhFPDlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 23:41:10 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595DC061574;
        Tue, 15 Jun 2021 20:39:04 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id x12so1104618ill.4;
        Tue, 15 Jun 2021 20:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLVjd/B0H0kL48l/PySzeV2HGRzXIC568fk5WYj/3Xk=;
        b=BfbBKLJ2Upsps7ynviorbLTQEETDycYXjm4M9XaXSUvGM6OMVLSxIrg3k+HPWYKaKv
         XNd1V5M4SZ9H5/xTScZW5Nlf/Ofu8TPjFa2NnLT8ohgiVTg0Fyjpsx4IZUosW/9KeYKk
         1QRf9WauAxf6QUPKwOXilOXgnODFm9aLIanKgADf4LWIYzAMWGpiXYsiO8Nfs9+y+ftC
         XlGehuoWt0TDG4sajAorFyvlJCes27EZhzr7fDkUEb/ObrY4hnmxq19CAg+H/duW5RvQ
         XfJ/hzPgPv0RYOMiPfwfSWPO7D6pgeNLxnS7sXbI9XLrEFloVIUbWbDZyFpM6sWHDCKZ
         pesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLVjd/B0H0kL48l/PySzeV2HGRzXIC568fk5WYj/3Xk=;
        b=WKp5nW54Yv+0WW5QMUhj2cLC8FcuvhaJxNDa5mSA+FVarG7oqyFHPBSqpgk1LSa6Kk
         GwN89R7EaV/7k5P9Qg617bYBimTlQLlAoCAsCQH2R+k3vhBM9MdA2VYc3CGKAn/zMg49
         zjODBQiNyzXt2dJJ1MMpmwgn8jn5DU1cDJm0a8Mw1EgbkU0BSb8NFbHw7LdC5ktPiT7m
         VOQ6085RpShhnTZT/6GOloQPpeBJhgE2xID11EwhKH75kTHBOd+adKRVT/C0zoNnJfik
         gtcvIGT4p4QiW/4fzJhx8AvcvYcLz6s4RuF4EgcElMC1ZrEL2fmU/K/bax8ey6/nj1bV
         moQA==
X-Gm-Message-State: AOAM533efExfv+m8RE55Z1T/6kKCzDvLYH2FDUBLMSKmZcY+70O5tpSA
        BJAE4bit2iNJJo6/OXZwy5AvJearFuguc2DRong=
X-Google-Smtp-Source: ABdhPJyn8uotUzKuBAJw+1+doSIWVTmp8RnXk56THpyEkvqFeX7bOXI68JcWGTfJJnsTCo+AWiO43+0woKDlMJJeLBU=
X-Received: by 2002:a05:6e02:12af:: with SMTP id f15mr2172478ilr.266.1623814743504;
 Tue, 15 Jun 2021 20:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
 <ce6fd0fd-2fb3-7a66-4910-5fe8c2b4d593@fb.com> <CAPGftE9+CVuK7KwExRiqsuKHMEUrPsXraBbC5qw8N2NFrE5MYg@mail.gmail.com>
 <4ec3c676-e219-6aaf-fe5c-76abbb0c9535@fb.com> <CAPGftE8d03K4_S1pTyRVWZL7w67FukES_PV8SR=0_6DXhXzjQw@mail.gmail.com>
In-Reply-To: <CAPGftE8d03K4_S1pTyRVWZL7w67FukES_PV8SR=0_6DXhXzjQw@mail.gmail.com>
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Tue, 15 Jun 2021 20:38:53 -0700
Message-ID: <CAPGftE9CvDN4T2_xyn8xB_f247-da+nrDH6o35e_Yu9rSL=ehg@mail.gmail.com>
Subject: Re: Kernel Oops in test_verifier "#828/p reference tracking: bpf_sk_release(btf_tcp_sock)"
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, linux-mips@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 15 Jun 2021 at 19:21, Tony Ambardar <tony.ambardar@gmail.com> wrote:
>
> On Sun, 13 Jun 2021 at 23:14, Yonghong Song <yhs@fb.com> wrote:
> >
> > On 6/12/21 5:07 PM, Tony Ambardar wrote:
> > > On Fri, 11 Jun 2021 at 08:57, Yonghong Song <yhs@fb.com> wrote:
> > >>
> > >> On 6/10/21 6:02 PM, Tony Ambardar wrote:
> > >>> Hello,
> > >>>
> > >>> I encountered an NPE and kernel Oops [1] while running the
> > >>> 'test_verifier' selftest on MIPS32 with LTS kernel 5.10.41. This was
> > >>> observed during development of a MIPS32 JIT but is verifier-related.
> > >>>
> > >>> Initial troubleshooting [2] points to an unchecked NULL dereference in
> > >>> btf_type_by_id(), with an unexpected BTF type ID. The root cause is
> > >>> unclear, whether source of the ID or a potential underlying BTF
> > >>> problem.
> > >>
> > >> Do you know what is the faulty btf ID number? What is the maximum id
> > >> for vmlinux BTF?
> > >
> > > Thanks for the suggestions, Yonghong.
> > >
> > > I had built/packaged bpftool for the target, which shows the maximum as:
> > >
> > >    root@OpenWrt:~# bpftool btf dump file /sys/kernel/btf/vmlinux format
> > > raw|tail -5
> > >    [43179] FUNC 'pci_load_of_ranges' type_id=43178 linkage=static
> > >    [43180] ARRAY '(anon)' type_id=23 index_type_id=23 nr_elems=16
> > >    [43181] FUNC 'pcibios_plat_dev_init' type_id=29264 linkage=static
> > >    [43182] FUNC 'pcibios_map_irq' type_id=29815 linkage=static
> > >    [43183] FUNC 'mips_pcibios_init' type_id=115 linkage=static
> > >
> > > After adding NULL handling and debug pr_err() to kernel_type_name(), I next see:
> > >
> > >    root@OpenWrt:~# ./test_verifier_eb 828
> > >    [   87.196692] btf_type_by_id(btf_vmlinux, 3062497280) returns NULL
> > >    [   87.196958] btf_type_by_id(btf_vmlinux, 2936995840) returns NULL
> > >    #828/p reference tracking: bpf_sk_release(btf_tcp_sock) FAIL
> > >
> > > Those large type ids make me suspect an endianness issue, even though bpftool
> > > can still properly access the vmlinux BTF. Changing byte order and
> > > looking up the
> > > resulting type ids seems to confirm this:
> > >
> > >    Check endianness:
> > >      3062497280 -> 0xB68A0000 --swap endian--> 0x00008AB6 -> 35510
> > >    bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[35510]":
> > >      [35510] STRUCT 'tcp_sock' size=1752 vlen=136
> > >
> > >    Check endianness:
> > >      2936995840 -> 0xAF0F0000 --swap endian--> 0x00000FAF -> 4015
> > >    bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[4015]":
> > >      [4015] STRUCT 'sock_common' size=112 vlen=25
> > >
> > > As a further test, I repeated "test_verifier 828" across mips{32,64}{be,le}
> > > systems and confirm seeing the problem only with the big-endian ones.
> >
> >  From the above information, looks like vmlinux BTF is correct.
> > Below resolve_btfids command output seems indicating the btf_id list
> > is also correct.
> >
> > The kernel_type_name is used in a few places for verifier verbose output.
> >
> > $ grep kernel_type_name kernel/bpf/verifier.c
> > static const char *kernel_type_name(const struct btf* btf, u32 id)
> >                                  verbose(env, "%s",
> > kernel_type_name(reg->btf, reg->btf_id));
> >                                  regno, kernel_type_name(reg->btf,
> > reg->btf_id),
> >                                  kernel_type_name(btf_vmlinux,
> > *arg_btf_id));
> >
> > The most suspicous target is reg->btf_id, which is propagated from
> > the result of bpf_sk_lookup_tcp() helper.
> >
> > >
> > >> The involved helper is bpf_sk_release.
> > >>
> > >> static const struct bpf_func_proto bpf_sk_release_proto = {
> > >>           .func           = bpf_sk_release,
> > >>           .gpl_only       = false,
> > >>           .ret_type       = RET_INTEGER,
> > >>           .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> > >> };
> > >>
> > >> Eventually, the btf_id is taken from btf_sock_ids[6] where
> > >> btf_sock_ids is a kernel global variable.
> > >>
> > >> Could you check btf_sock_ids[6] to see whether the number
> > >> makes sense?
> > >
> > > What I see matches the second btf_type_by_id() NULL call above:
> > >    [   56.556121] btf_sock_ids[6]: 2936995840
> > >
> > >> The id is computed by resolve_btfids in
> > >> tools/bpf/resolve_btfids, you might add verbose mode to your linux build
> > >> to get more information.
> > >
> > > The verbose build didn't print any details of the btf ids. Was there anything
> > > special to do in invocation? I manually ran "resolve_btfids -v vmlinux" from
> > > the build dir and this, strangely, gave slightly different results than bpftool
> > > but not the huge endian-swapped type ids. Is this expected?
> > >
> > >    # ./tools/bpf/resolve_btfids/resolve_btfids -v vmlinux
> > >    ...
> > >    patching addr   116: ID   35522 [tcp_sock]
> > >    ...
> > >    patching addr   112: ID    4021 [sock_common]
> > >
> > > Do any of the details above help narrow down things? What do you suggest
> > > for next steps?
> >
> > We need to identify issues by dumping detailed verifier logs.
> > Could you apply the following change?
> >
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -1088,7 +1088,7 @@ static void do_test_single(struct bpf_test *test,
> > bool unpriv,
> >          attr.insns_cnt = prog_len;
> >          attr.license = "GPL";
> >          if (verbose)
> > -               attr.log_level = 1;
> > +               attr.log_level = 3;
> >          else if (expected_ret == VERBOSE_ACCEPT)
> >                  attr.log_level = 2;
> >          else
> >
> > Run command like `./test_verifier -v 828 828`?
> >
> > I attached the verifier output for x86_64.
> > Maybe by comparing x86 output vs. mips32 output, you can
> > find which insn starts to have *wrong* verifier state
> > and then we can go from there.
>
> I realized too late your test output must be for a different kernel version as
> well as arch, as the test numbering is different and doesn't match my test:
> "reference tracking: bpf_sk_release(btf_tcp_sock)".
>
> Given the problem is seen on big-endian and not little-systems, I applied
> your patch for both mips32 variant systems and recaptured log output,
> which should make for a stricter A/B comparison. I also kept my earlier
> patches to catch the NULLs and print debug info.
>
> The logs are identical until insn #18, where the failing MIPS32BE shows:
>
> 18: R0_w=ptr_or_null_(null)(id=3,off=0,imm=0)
> R6_w=sock(id=0,ref_obj_id=2,off=0,imm=0) R10=fp0 fp-8=????0000
> fp-16=0000mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
> fp-48=mmmmmmmm refs=2
>
> while the succeed MIPS32LE test shows:
>
> 18: R0_w=ptr_or_null_tcp_sock(id=3,off=0,imm=0)
> R6_w=sock(id=0,ref_obj_id=2,off=0,imm=0) R10=fp0 fp-8=????0000
> fp-16=0000mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
> fp-48=mmmmmmmm refs=2
>
> There are then further differences you can see in the attached logs. It's
> not clear to me what these differences mean however. Any ideas?
>
> Following your earlier comments on the large, endian-swapped values
> in btf_sock_ids[6], I noticed this is true of all btf_sock_ids[]
> elements, based on debug output:
>
>     btf_sock_ids[0] = 2139684864
>     btf_sock_ids[1] = 2794061824
>     btf_sock_ids[2] = 2844459008
>     btf_sock_ids[3] = 1234305024
>     btf_sock_ids[4] = 3809411072
>     btf_sock_ids[5] = 1946812416
>     btf_sock_ids[6] = 2936995840
>     btf_sock_ids[7] = 3062497280
>     btf_sock_ids[8] = 2861236224
>     btf_sock_ids[9] = 1251082240
>     btf_sock_ids[10] = 1334968320
>     btf_sock_ids[11] = 1267859456
>     btf_sock_ids[12] = 1318191104
>
> If these are populated by resolve_btfids, how could we re-verify that
> it's being done properly?

Following up on this thought, I used objdump to look at the .BTF_ids
section and the "struct sock_common" type, comparing the ids for
little- and big-endian vmlinux after processing by resolv_btfids.

It appears resolv_btfids always writes these ids as little-endian (the
build host) and ignores the target endianness. Do I read this
correctly?

  $ objdump --syms -s -j .BTF_ids
build_dir/target-mipsel_24kc_musl/linux-malta_le/linux-5.10.41/vmlinux
  build_dir/target-mipsel_24kc_musl/linux-malta_le/linux-5.10.41/vmlinux:
file format elf32-little

  SYMBOL TABLE:
  ...
  80bbee08 l     O .BTF_ids       00000004 __BTF_ID__struct__sock_common__1116

  Contents of section .BTF_ids:
  ...
   80bbee08 b40f0000 bc8a0000 b08b0000 50920000  ............P...

  $ objdump --syms -s -j .BTF_ids
build_dir/target-mips_24kc_musl/linux-malta_be/linux-5.10.41/vmlinux
  build_dir/target-mips_24kc_musl/linux-malta_be/linux-5.10.41/vmlinux:
file format elf32-big

  SYMBOL TABLE:
  ...
  80bc3ebc l     O .BTF_ids       00000004 __BTF_ID__struct__sock_common__1116

  Contents of section .BTF_ids:
    ...
   80bc3ebc b50f0000 c28a0000 b68b0000 56920000  ............V...


I also want to highlight a discrepency I reported earlier between btf
ids for "sock_common" reported by resolv_btfids (4021) and bpftool
(4015). Why do you suppose this is?

> > >
> > > Thanks,
> > > Tony
> > >
> > >>>
> > >>> Has this been seen before? How best to debug this further or resolve?
> > >>> What other details would be useful for BPF kernel developers?
> > >>>
> > >>> Thanks for any help,
> > >>> Tony
> > >>>
> > >>> [1]:
> > >>> (Host details)
> > >>> kodidev:~/openwrt-project$ ./staging_dir/host/bin/pahole --version
> > >>> v1.21
> > >>>
> > >>> (Target details)
> > >>> root@OpenWrt:/# uname -a
> > >>> Linux OpenWrt 5.10.41 #0 SMP Tue Jun 1 00:54:31 2021 mips GNU/Linux
> > >>>
> > >>> root@OpenWrt:~# sysctl net.core.bpf_jit_enable=0; ./test_verifier 826 828
> > >>> net.core.bpf_jit_enable = 0
> > >>>
> > >>> #826/p reference tracking: branch tracking valid pointer null comparison OK
> > >>> #827/p reference tracking: branch tracking valid pointer value comparison OK
> > >>> CPU 0 Unable to handle kernel paging request at virtual address
> > >>> 00000000, epc == 80244654, ra == 80244654
> > >>> Oops[#1]:
> > >>> CPU: 0 PID: 16274 Comm: test_verifier Not tainted 5.10.41 #0
> > >>> $ 0   : 00000000 00000001 00000000 0000a8a2
> > >>> $ 4   : 835ac580 a6280000 00000000 00000001
> > >>> $ 8   : 835ac580 a6280000 00000000 02020202
> > >>> $12   : 8348de58 834ba800 00000000 00000000
> > >>> $16   : 835ac580 8098be2c fffffff3 834bdb38
> > >>> $20   : 8098be0c 00000001 00000018 00000000
> > >>> $24   : 00000000 01415415
> > >>> $28   : 834bc000 834bdac8 00000005 80244654
> > >>> Hi    : 00000017
> > >>> Lo    : 0a3d70a2
> > >>> epc   : 80244654 kernel_type_name+0x20/0x38
> > >>> ra    : 80244654 kernel_type_name+0x20/0x38
> > >>> Status: 1000a403 KERNEL EXL IE
> > >>> Cause : 00800008 (ExcCode 02)
> > >>> BadVA : 00000000
> > >>> PrId  : 00019300 (MIPS 24Kc)
> > >>> Modules linked in: pppoe ppp_async pppox ppp_generic mac80211_hwsim
> > >>> mac80211 iptable_nat ipt_REJECT cfg80211 xt_time xt_tcpudp xt_tcpmss
> > >>> xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac
> > >>> xt_limit xt_length xt_hl xt_helper xt_ecn xt_dscp xt_conntrack
> > >>> xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT
> > >>> xt_MASQUERADE xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY
> > >>> slhc sch_mqprio sch_cake pcnet32 nf_reject_ipv4 nf_nat nf_log_ipv4
> > >>> nf_flow_table nf_conntrack_netlink nf_conncount iptable_raw
> > >>> iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt compat
> > >>> cls_flower act_vlan pktgen sch_teql sch_sfq sch_red sch_prio sch_pie
> > >>> sch_multiq sch_gred sch_fq sch_dsmark sch_codel em_text em_nbyte
> > >>> em_meta em_cmp act_simple act_police act_pedit act_ipt act_csum
> > >>> libcrc32c em_ipset cls_bpf act_bpf act_ctinfo act_connmark
> > >>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sch_tbf sch_ingress sch_htb
> > >>> sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_matchall cls_fw
> > >>>    cls_flow cls_basic act_skbedit act_mirred act_gact xt_set
> > >>> ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport
> > >>> ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net
> > >>> ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip
> > >>> ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip
> > >>> ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set
> > >>> nfnetlink nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter
> > >>> ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ifb dummy netlink_diag
> > >>> mii
> > >>> Process test_verifier (pid: 16274, threadinfo=c1418596, task=05765195,
> > >>> tls=77e5aec8)
> > >>> Stack : 83428000 83428000 8098be2c 00000000 83428000 8024af78 834bacdc 834bb000
> > >>>           a98a0000 834e2580 834e2c00 00000000 834e2c00 8023da9c 834bb070 00000013
> > >>>           80925164 80924f44 00000000 80925164 00000000 83428140 80bc3864 834bb070
> > >>>           834e2c00 00000000 00000010 802c441c 00000000 00000000 00000000 00000000
> > >>>           00000000 00000000 00000000 00000000 00000000 00000056 00000000 00000000
> > >>>           ...
> > >>> Call Trace:
> > >>> [<80244654>] kernel_type_name+0x20/0x38
> > >>> [<8024af78>] check_helper_call+0x1c9c/0x1dbc
> > >>> [<8024d008>] do_check_common+0x1f70/0x2a3c
> > >>> [<8024fb6c>] bpf_check+0x18f8/0x2308
> > >>> [<802369ec>] bpf_prog_load+0x378/0x860
> > >>> [<80237e1c>] __do_sys_bpf+0x3e0/0x2100
> > >>> [<801142d8>] syscall_common+0x34/0x58
> > >>>
> > >>> Code: afbf0014  0c099b58  02002025 <8c450000> 8fbf0014  02002025
> > >>> 8fb00010  08099b4f  27bd0018
> > >>>
> > >>> ---[ end trace ab13ac5f89eb825b ]---
> > >>> Kernel panic - not syncing: Fatal exception
> > >>> Rebooting in 3 seconds..
> > >>> QEMU: Terminated
> > >>>
> > >>>
> > >>> [2]:
> > >>> Function Code:
> > >>> ==============
> > >>> const char *kernel_type_name(u32 id)
> > >>> {
> > >>>       return btf_name_by_offset(btf_vmlinux,
> > >>>                     btf_type_by_id(btf_vmlinux, id)->name_off);
> > >>> }
> > >>>
> > >>> const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
> > >>> {
> > >>>       if (type_id > btf->nr_types)
> > >>>           return NULL;
> > >>>
> > >>>       return btf->types[type_id];
> > >>> }
> > >>>
> > >>> Disassembled Code:
> > >>> ==================
> > >>> 0x0000000000000000:  AF BF 00 14    sw    $ra, 0x14($sp)
> > >>> 0x0000000000000004:  0C 09 9B 58    jal   btf_type_by_id
> > >>> 0x0000000000000008:  02 00 20 25    move  $a0, $s0
> > >>> 0x000000000000000c:  8C 45 00 00    lw    $a1, ($v0)         <-- NPE
> > >>> 0x0000000000000010:  8F BF 00 14    lw    $ra, 0x14($sp)
> > >>> 0x0000000000000014:  02 00 20 25    move  $a0, $s0
> > >>> 0x0000000000000018:  8F B0 00 10    lw    $s0, 0x10($sp)
> > >>> 0x000000000000001c:  08 09 9B 4F    j     btf_name_by_offset
> > >>> 0x0000000000000020:  27 BD 00 18    addiu $sp, $sp, 0x18
> > >>>
