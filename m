Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C743A8EC7
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 04:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhFPCXc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 22:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhFPCXc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 22:23:32 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A0CC061574;
        Tue, 15 Jun 2021 19:21:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id l64so1358575ioa.7;
        Tue, 15 Jun 2021 19:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fb2nn6Fi7AWoueRSaO13x2jEymTnIV0hTMsfcWIwE5U=;
        b=sd7W5m+CBE105wW8rxYVTCNkdAdiVrgJyJXLBXygqUwZ/0RKVAM3kRWSG+3+5RL3uQ
         w4dC2jN6OfzaihANR4+LqB/0bsvIKiex9IJlNIaggulk8XnghF9YWkHDSQFoqXW55VL3
         F+Y+1/mhsvcEzxUo5JEsmbustjOlyV8LS+0ES6quWBiKDz+iWn7c55KlHK26ta3CgsvJ
         L0867J3b+v3712pWDoRgszkMyZdO/GK5V6pzlo9chISQ+eqwMkNrtrAc69/L9ExblaOU
         HepSDpqB73zoKu98JN6Xeu93IVtqYeHW9ihEiYhax5B27PZ4YQO6CYWi/0giMTCV0mAU
         MY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fb2nn6Fi7AWoueRSaO13x2jEymTnIV0hTMsfcWIwE5U=;
        b=eY2SgppfIjb8Qkazatf9U2YaP4FMVQPqw+CpZ7jTg3iYnDOY4AjEbUSDjWhO8UF6Iu
         Yfzpwlq38aHBjzLmoXVA0/eD4owee4Tj/02XM3oDL3JTdB2cDUZWfOPuKy8h7bN6wifF
         A514kDvh0dW7N6J6ZVCJZlH4XFh7KySC+wkHG6NpisGAjnAQEzTRfRBY8GlkMCSvVIOB
         wYhaoelQDC0ZQ1Z+1ksnn0nJT+IUvZcP1toYyIm96Aw1rl8h2/J+bSmKdoQKjwPiBp9F
         m5b3xDWAhc4JGL5Te0XVSfMWq4gN7lNUl1JebSAXswFR3qcKoyKtTlFP7EtzzWxFIEiz
         ZVnw==
X-Gm-Message-State: AOAM533Qv28L4fr+XUeZHlrM8TIEUJOuPP316htJ9FspLD0XD6xbxVzt
        ww9cVfAZzGH7yruYI4NVux23OrlPOwQxb8LUaqs=
X-Google-Smtp-Source: ABdhPJxHqCVLrXyGFvyAE/R1zkrUN7LtIOKwuLjtuEkwjOg2Cxdx4GfVelIEnp1tttSZzleKt9ra9kqUKcqSQGDlBDo=
X-Received: by 2002:a02:a318:: with SMTP id q24mr1920667jai.100.1623810085583;
 Tue, 15 Jun 2021 19:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
 <ce6fd0fd-2fb3-7a66-4910-5fe8c2b4d593@fb.com> <CAPGftE9+CVuK7KwExRiqsuKHMEUrPsXraBbC5qw8N2NFrE5MYg@mail.gmail.com>
 <4ec3c676-e219-6aaf-fe5c-76abbb0c9535@fb.com>
In-Reply-To: <4ec3c676-e219-6aaf-fe5c-76abbb0c9535@fb.com>
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Tue, 15 Jun 2021 19:21:15 -0700
Message-ID: <CAPGftE8d03K4_S1pTyRVWZL7w67FukES_PV8SR=0_6DXhXzjQw@mail.gmail.com>
Subject: Re: Kernel Oops in test_verifier "#828/p reference tracking: bpf_sk_release(btf_tcp_sock)"
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, linux-mips@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000559cc505c4d8bf37"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

--000000000000559cc505c4d8bf37
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Jun 2021 at 23:14, Yonghong Song <yhs@fb.com> wrote:
>
> On 6/12/21 5:07 PM, Tony Ambardar wrote:
> > On Fri, 11 Jun 2021 at 08:57, Yonghong Song <yhs@fb.com> wrote:
> >>
> >> On 6/10/21 6:02 PM, Tony Ambardar wrote:
> >>> Hello,
> >>>
> >>> I encountered an NPE and kernel Oops [1] while running the
> >>> 'test_verifier' selftest on MIPS32 with LTS kernel 5.10.41. This was
> >>> observed during development of a MIPS32 JIT but is verifier-related.
> >>>
> >>> Initial troubleshooting [2] points to an unchecked NULL dereference in
> >>> btf_type_by_id(), with an unexpected BTF type ID. The root cause is
> >>> unclear, whether source of the ID or a potential underlying BTF
> >>> problem.
> >>
> >> Do you know what is the faulty btf ID number? What is the maximum id
> >> for vmlinux BTF?
> >
> > Thanks for the suggestions, Yonghong.
> >
> > I had built/packaged bpftool for the target, which shows the maximum as:
> >
> >    root@OpenWrt:~# bpftool btf dump file /sys/kernel/btf/vmlinux format
> > raw|tail -5
> >    [43179] FUNC 'pci_load_of_ranges' type_id=43178 linkage=static
> >    [43180] ARRAY '(anon)' type_id=23 index_type_id=23 nr_elems=16
> >    [43181] FUNC 'pcibios_plat_dev_init' type_id=29264 linkage=static
> >    [43182] FUNC 'pcibios_map_irq' type_id=29815 linkage=static
> >    [43183] FUNC 'mips_pcibios_init' type_id=115 linkage=static
> >
> > After adding NULL handling and debug pr_err() to kernel_type_name(), I next see:
> >
> >    root@OpenWrt:~# ./test_verifier_eb 828
> >    [   87.196692] btf_type_by_id(btf_vmlinux, 3062497280) returns NULL
> >    [   87.196958] btf_type_by_id(btf_vmlinux, 2936995840) returns NULL
> >    #828/p reference tracking: bpf_sk_release(btf_tcp_sock) FAIL
> >
> > Those large type ids make me suspect an endianness issue, even though bpftool
> > can still properly access the vmlinux BTF. Changing byte order and
> > looking up the
> > resulting type ids seems to confirm this:
> >
> >    Check endianness:
> >      3062497280 -> 0xB68A0000 --swap endian--> 0x00008AB6 -> 35510
> >    bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[35510]":
> >      [35510] STRUCT 'tcp_sock' size=1752 vlen=136
> >
> >    Check endianness:
> >      2936995840 -> 0xAF0F0000 --swap endian--> 0x00000FAF -> 4015
> >    bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[4015]":
> >      [4015] STRUCT 'sock_common' size=112 vlen=25
> >
> > As a further test, I repeated "test_verifier 828" across mips{32,64}{be,le}
> > systems and confirm seeing the problem only with the big-endian ones.
>
>  From the above information, looks like vmlinux BTF is correct.
> Below resolve_btfids command output seems indicating the btf_id list
> is also correct.
>
> The kernel_type_name is used in a few places for verifier verbose output.
>
> $ grep kernel_type_name kernel/bpf/verifier.c
> static const char *kernel_type_name(const struct btf* btf, u32 id)
>                                  verbose(env, "%s",
> kernel_type_name(reg->btf, reg->btf_id));
>                                  regno, kernel_type_name(reg->btf,
> reg->btf_id),
>                                  kernel_type_name(btf_vmlinux,
> *arg_btf_id));
>
> The most suspicous target is reg->btf_id, which is propagated from
> the result of bpf_sk_lookup_tcp() helper.
>
> >
> >> The involved helper is bpf_sk_release.
> >>
> >> static const struct bpf_func_proto bpf_sk_release_proto = {
> >>           .func           = bpf_sk_release,
> >>           .gpl_only       = false,
> >>           .ret_type       = RET_INTEGER,
> >>           .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> >> };
> >>
> >> Eventually, the btf_id is taken from btf_sock_ids[6] where
> >> btf_sock_ids is a kernel global variable.
> >>
> >> Could you check btf_sock_ids[6] to see whether the number
> >> makes sense?
> >
> > What I see matches the second btf_type_by_id() NULL call above:
> >    [   56.556121] btf_sock_ids[6]: 2936995840
> >
> >> The id is computed by resolve_btfids in
> >> tools/bpf/resolve_btfids, you might add verbose mode to your linux build
> >> to get more information.
> >
> > The verbose build didn't print any details of the btf ids. Was there anything
> > special to do in invocation? I manually ran "resolve_btfids -v vmlinux" from
> > the build dir and this, strangely, gave slightly different results than bpftool
> > but not the huge endian-swapped type ids. Is this expected?
> >
> >    # ./tools/bpf/resolve_btfids/resolve_btfids -v vmlinux
> >    ...
> >    patching addr   116: ID   35522 [tcp_sock]
> >    ...
> >    patching addr   112: ID    4021 [sock_common]
> >
> > Do any of the details above help narrow down things? What do you suggest
> > for next steps?
>
> We need to identify issues by dumping detailed verifier logs.
> Could you apply the following change?
>
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1088,7 +1088,7 @@ static void do_test_single(struct bpf_test *test,
> bool unpriv,
>          attr.insns_cnt = prog_len;
>          attr.license = "GPL";
>          if (verbose)
> -               attr.log_level = 1;
> +               attr.log_level = 3;
>          else if (expected_ret == VERBOSE_ACCEPT)
>                  attr.log_level = 2;
>          else
>
> Run command like `./test_verifier -v 828 828`?
>
> I attached the verifier output for x86_64.
> Maybe by comparing x86 output vs. mips32 output, you can
> find which insn starts to have *wrong* verifier state
> and then we can go from there.

I realized too late your test output must be for a different kernel version as
well as arch, as the test numbering is different and doesn't match my test:
"reference tracking: bpf_sk_release(btf_tcp_sock)".

Given the problem is seen on big-endian and not little-systems, I applied
your patch for both mips32 variant systems and recaptured log output,
which should make for a stricter A/B comparison. I also kept my earlier
patches to catch the NULLs and print debug info.

The logs are identical until insn #18, where the failing MIPS32BE shows:

18: R0_w=ptr_or_null_(null)(id=3,off=0,imm=0)
R6_w=sock(id=0,ref_obj_id=2,off=0,imm=0) R10=fp0 fp-8=????0000
fp-16=0000mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
fp-48=mmmmmmmm refs=2

while the succeed MIPS32LE test shows:

18: R0_w=ptr_or_null_tcp_sock(id=3,off=0,imm=0)
R6_w=sock(id=0,ref_obj_id=2,off=0,imm=0) R10=fp0 fp-8=????0000
fp-16=0000mmmm fp-24=mmmmmmmm fp-32=mmmmmmmm fp-40=mmmmmmmm
fp-48=mmmmmmmm refs=2

There are then further differences you can see in the attached logs. It's
not clear to me what these differences mean however. Any ideas?

Following your earlier comments on the large, endian-swapped values
in btf_sock_ids[6], I noticed this is true of all btf_sock_ids[]
elements, based on debug output:

    btf_sock_ids[0] = 2139684864
    btf_sock_ids[1] = 2794061824
    btf_sock_ids[2] = 2844459008
    btf_sock_ids[3] = 1234305024
    btf_sock_ids[4] = 3809411072
    btf_sock_ids[5] = 1946812416
    btf_sock_ids[6] = 2936995840
    btf_sock_ids[7] = 3062497280
    btf_sock_ids[8] = 2861236224
    btf_sock_ids[9] = 1251082240
    btf_sock_ids[10] = 1334968320
    btf_sock_ids[11] = 1267859456
    btf_sock_ids[12] = 1318191104

If these are populated by resolve_btfids, how could we re-verify that
it's being done properly?

> >
> > Thanks,
> > Tony
> >
> >>>
> >>> Has this been seen before? How best to debug this further or resolve?
> >>> What other details would be useful for BPF kernel developers?
> >>>
> >>> Thanks for any help,
> >>> Tony
> >>>
> >>> [1]:
> >>> (Host details)
> >>> kodidev:~/openwrt-project$ ./staging_dir/host/bin/pahole --version
> >>> v1.21
> >>>
> >>> (Target details)
> >>> root@OpenWrt:/# uname -a
> >>> Linux OpenWrt 5.10.41 #0 SMP Tue Jun 1 00:54:31 2021 mips GNU/Linux
> >>>
> >>> root@OpenWrt:~# sysctl net.core.bpf_jit_enable=0; ./test_verifier 826 828
> >>> net.core.bpf_jit_enable = 0
> >>>
> >>> #826/p reference tracking: branch tracking valid pointer null comparison OK
> >>> #827/p reference tracking: branch tracking valid pointer value comparison OK
> >>> CPU 0 Unable to handle kernel paging request at virtual address
> >>> 00000000, epc == 80244654, ra == 80244654
> >>> Oops[#1]:
> >>> CPU: 0 PID: 16274 Comm: test_verifier Not tainted 5.10.41 #0
> >>> $ 0   : 00000000 00000001 00000000 0000a8a2
> >>> $ 4   : 835ac580 a6280000 00000000 00000001
> >>> $ 8   : 835ac580 a6280000 00000000 02020202
> >>> $12   : 8348de58 834ba800 00000000 00000000
> >>> $16   : 835ac580 8098be2c fffffff3 834bdb38
> >>> $20   : 8098be0c 00000001 00000018 00000000
> >>> $24   : 00000000 01415415
> >>> $28   : 834bc000 834bdac8 00000005 80244654
> >>> Hi    : 00000017
> >>> Lo    : 0a3d70a2
> >>> epc   : 80244654 kernel_type_name+0x20/0x38
> >>> ra    : 80244654 kernel_type_name+0x20/0x38
> >>> Status: 1000a403 KERNEL EXL IE
> >>> Cause : 00800008 (ExcCode 02)
> >>> BadVA : 00000000
> >>> PrId  : 00019300 (MIPS 24Kc)
> >>> Modules linked in: pppoe ppp_async pppox ppp_generic mac80211_hwsim
> >>> mac80211 iptable_nat ipt_REJECT cfg80211 xt_time xt_tcpudp xt_tcpmss
> >>> xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac
> >>> xt_limit xt_length xt_hl xt_helper xt_ecn xt_dscp xt_conntrack
> >>> xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT
> >>> xt_MASQUERADE xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY
> >>> slhc sch_mqprio sch_cake pcnet32 nf_reject_ipv4 nf_nat nf_log_ipv4
> >>> nf_flow_table nf_conntrack_netlink nf_conncount iptable_raw
> >>> iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt compat
> >>> cls_flower act_vlan pktgen sch_teql sch_sfq sch_red sch_prio sch_pie
> >>> sch_multiq sch_gred sch_fq sch_dsmark sch_codel em_text em_nbyte
> >>> em_meta em_cmp act_simple act_police act_pedit act_ipt act_csum
> >>> libcrc32c em_ipset cls_bpf act_bpf act_ctinfo act_connmark
> >>> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sch_tbf sch_ingress sch_htb
> >>> sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_matchall cls_fw
> >>>    cls_flow cls_basic act_skbedit act_mirred act_gact xt_set
> >>> ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport
> >>> ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net
> >>> ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip
> >>> ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip
> >>> ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set
> >>> nfnetlink nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter
> >>> ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ifb dummy netlink_diag
> >>> mii
> >>> Process test_verifier (pid: 16274, threadinfo=c1418596, task=05765195,
> >>> tls=77e5aec8)
> >>> Stack : 83428000 83428000 8098be2c 00000000 83428000 8024af78 834bacdc 834bb000
> >>>           a98a0000 834e2580 834e2c00 00000000 834e2c00 8023da9c 834bb070 00000013
> >>>           80925164 80924f44 00000000 80925164 00000000 83428140 80bc3864 834bb070
> >>>           834e2c00 00000000 00000010 802c441c 00000000 00000000 00000000 00000000
> >>>           00000000 00000000 00000000 00000000 00000000 00000056 00000000 00000000
> >>>           ...
> >>> Call Trace:
> >>> [<80244654>] kernel_type_name+0x20/0x38
> >>> [<8024af78>] check_helper_call+0x1c9c/0x1dbc
> >>> [<8024d008>] do_check_common+0x1f70/0x2a3c
> >>> [<8024fb6c>] bpf_check+0x18f8/0x2308
> >>> [<802369ec>] bpf_prog_load+0x378/0x860
> >>> [<80237e1c>] __do_sys_bpf+0x3e0/0x2100
> >>> [<801142d8>] syscall_common+0x34/0x58
> >>>
> >>> Code: afbf0014  0c099b58  02002025 <8c450000> 8fbf0014  02002025
> >>> 8fb00010  08099b4f  27bd0018
> >>>
> >>> ---[ end trace ab13ac5f89eb825b ]---
> >>> Kernel panic - not syncing: Fatal exception
> >>> Rebooting in 3 seconds..
> >>> QEMU: Terminated
> >>>
> >>>
> >>> [2]:
> >>> Function Code:
> >>> ==============
> >>> const char *kernel_type_name(u32 id)
> >>> {
> >>>       return btf_name_by_offset(btf_vmlinux,
> >>>                     btf_type_by_id(btf_vmlinux, id)->name_off);
> >>> }
> >>>
> >>> const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
> >>> {
> >>>       if (type_id > btf->nr_types)
> >>>           return NULL;
> >>>
> >>>       return btf->types[type_id];
> >>> }
> >>>
> >>> Disassembled Code:
> >>> ==================
> >>> 0x0000000000000000:  AF BF 00 14    sw    $ra, 0x14($sp)
> >>> 0x0000000000000004:  0C 09 9B 58    jal   btf_type_by_id
> >>> 0x0000000000000008:  02 00 20 25    move  $a0, $s0
> >>> 0x000000000000000c:  8C 45 00 00    lw    $a1, ($v0)         <-- NPE
> >>> 0x0000000000000010:  8F BF 00 14    lw    $ra, 0x14($sp)
> >>> 0x0000000000000014:  02 00 20 25    move  $a0, $s0
> >>> 0x0000000000000018:  8F B0 00 10    lw    $s0, 0x10($sp)
> >>> 0x000000000000001c:  08 09 9B 4F    j     btf_name_by_offset
> >>> 0x0000000000000020:  27 BD 00 18    addiu $sp, $sp, 0x18
> >>>

--000000000000559cc505c4d8bf37
Content-Type: text/plain; charset="US-ASCII"; name="test_verifier_828_be32.txt"
Content-Disposition: attachment; filename="test_verifier_828_be32.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kpys75n90>
X-Attachment-Id: f_kpys75n90

IzgyOC9wIHJlZmVyZW5jZSB0cmFja2luZzogYnBmX3NrX3JlbGVhc2UoYnRmX3RjcF9zb2NrKSBG
QUlMDQpGYWlsZWQgdG8gbG9hZCBwcm9nICdObyBlcnJvciBpbmZvcm1hdGlvbichDQpmdW5jIzAg
QDANCjA6IFIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMTA9ZnAwDQowOiAoYjcpIHIyID0gMA0K
MTogUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9aW52MCBSMTA9ZnAwDQoxOiAoNjMpICoo
dTMyICopKHIxMCAtOCkgPSByMg0KbGFzdF9pZHggMSBmaXJzdF9pZHggMA0KcmVncz00IHN0YWNr
PTAgYmVmb3JlIDA6IChiNykgcjIgPSAwDQoyOiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJf
dz1pbnZQMCBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDANCjI6ICg3YikgKih1NjQgKikocjEwIC0xNikg
PSByMg0KMzogUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9aW52UDAgUjEwPWZwMCBmcC04
PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMDAwMDANCjM6ICg3YikgKih1NjQgKikocjEwIC0yNCkgPSBy
Mg0KNDogUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9aW52UDAgUjEwPWZwMCBmcC04PT8/
Pz8wMDAwIGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMA0KNDogKDdiKSAqKHU2NCAq
KShyMTAgLTMyKSA9IHIyDQo1OiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1pbnZQMCBS
MTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMCBmcC0yNF93PTAwMDAwMDAwIGZw
LTMyX3c9MDAwMDAwMDANCjU6ICg3YikgKih1NjQgKikocjEwIC00MCkgPSByMg0KNjogUjE9Y3R4
KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9aW52UDAgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2
X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMCBmcC0zMl93PTAwMDAwMDAwIGZwLTQwX3c9MDAw
MDAwMDANCjY6ICg3YikgKih1NjQgKikocjEwIC00OCkgPSByMg0KNzogUjE9Y3R4KGlkPTAsb2Zm
PTAsaW1tPTApIFIyX3c9aW52UDAgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMDAw
MDAgZnAtMjRfdz0wMDAwMDAwMCBmcC0zMl93PTAwMDAwMDAwIGZwLTQwX3c9MDAwMDAwMDAgZnAt
NDhfdz0wMDAwMDAwMA0KNzogKGJmKSByMiA9IHIxMA0KODogUjE9Y3R4KGlkPTAsb2ZmPTAsaW1t
PTApIFIyX3c9ZnAwIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDAwMDAwIGZwLTI0
X3c9MDAwMDAwMDAgZnAtMzJfdz0wMDAwMDAwMCBmcC00MF93PTAwMDAwMDAwIGZwLTQ4X3c9MDAw
MDAwMDANCjg6ICgwNykgcjIgKz0gLTQ4DQo5OiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJf
dz1mcC00OCBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMCBmcC0yNF93PTAw
MDAwMDAwIGZwLTMyX3c9MDAwMDAwMDAgZnAtNDBfdz0wMDAwMDAwMCBmcC00OF93PTAwMDAwMDAw
DQo5OiAoYjcpIHIzID0gMzYNCjEwOiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1mcC00
OCBSM193PWludjM2IFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDAwMDAwIGZwLTI0
X3c9MDAwMDAwMDAgZnAtMzJfdz0wMDAwMDAwMCBmcC00MF93PTAwMDAwMDAwIGZwLTQ4X3c9MDAw
MDAwMDANCjEwOiAoYjcpIHI0ID0gMA0KMTE6IFIxPWN0eChpZD0wLG9mZj0wLGltbT0wKSBSMl93
PWZwLTQ4IFIzX3c9aW52MzYgUjRfdz1pbnYwIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93
PTAwMDAwMDAwIGZwLTI0X3c9MDAwMDAwMDAgZnAtMzJfdz0wMDAwMDAwMCBmcC00MF93PTAwMDAw
MDAwIGZwLTQ4X3c9MDAwMDAwMDANCjExOiAoYjcpIHI1ID0gMA0KMTI6IFIxPWN0eChpZD0wLG9m
Zj0wLGltbT0wKSBSMl93PWZwLTQ4IFIzX3c9aW52MzYgUjRfdz1pbnYwIFI1X3c9aW52MCBSMTA9
ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMCBmcC0yNF93PTAwMDAwMDAwIGZwLTMy
X3c9MDAwMDAwMDAgZnAtNDBfdz0wMDAwMDAwMCBmcC00OF93PTAwMDAwMDAwDQoxMjogKDg1KSBj
YWxsIGJwZl9za19sb29rdXBfdGNwIzg0DQpsYXN0X2lkeCAxMiBmaXJzdF9pZHggMA0KcmVncz04
IHN0YWNrPTAgYmVmb3JlIDExOiAoYjcpIHI1ID0gMA0KcmVncz04IHN0YWNrPTAgYmVmb3JlIDEw
OiAoYjcpIHI0ID0gMA0KcmVncz04IHN0YWNrPTAgYmVmb3JlIDk6IChiNykgcjMgPSAzNg0KMTM6
IFIwX3c9c29ja19vcl9udWxsKGlkPTIscmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBSMTA9ZnAw
IGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwbW1tbSBmcC0yNF93PW1tbW1tbW1tIGZwLTMyX3c9
bW1tbW1tbW0gZnAtNDBfdz1tbW1tbW1tbSBmcC00OF93PW1tbW1tbW1tIHJlZnM9Mg0KMTM6ICg1
NSkgaWYgcjAgIT0gMHgwIGdvdG8gcGMrMQ0KIFIwX3c9aW52MCBSMTA9ZnAwIGZwLTg9Pz8/PzAw
MDAgZnAtMTZfdz0wMDAwbW1tbSBmcC0yNF93PW1tbW1tbW1tIGZwLTMyX3c9bW1tbW1tbW0gZnAt
NDBfdz1tbW1tbW1tbSBmcC00OF93PW1tbW1tbW1tDQoxNDogUjBfdz1pbnYwIFIxMD1mcDAgZnAt
OD0/Pz8/MDAwMCBmcC0xNl93PTAwMDBtbW1tIGZwLTI0X3c9bW1tbW1tbW0gZnAtMzJfdz1tbW1t
bW1tbSBmcC00MF93PW1tbW1tbW1tIGZwLTQ4X3c9bW1tbW1tbW0NCjE0OiAoOTUpIGV4aXQNCjE1
OiBSMD1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBSMTA9ZnAwIGZwLTg9Pz8/
PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1tbW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9
bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0gcmVmcz0yDQoxNTogKGJmKSByNiA9IHIwDQoxNjogUjA9
c29jayhpZD0wLHJlZl9vYmpfaWQ9MixvZmY9MCxpbW09MCkgUjZfdz1zb2NrKGlkPTAscmVmX29i
al9pZD0yLG9mZj0wLGltbT0wKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0g
ZnAtMjQ9bW1tbW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1t
bW0gcmVmcz0yDQoxNjogKGJmKSByMSA9IHIwDQoxNzogUjA9c29jayhpZD0wLHJlZl9vYmpfaWQ9
MixvZmY9MCxpbW09MCkgUjFfdz1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBS
Nl93PXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTApIFIxMD1mcDAgZnAtOD0/Pz8/
MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00MD1t
bW1tbW1tbSBmcC00OD1tbW1tbW1tbSByZWZzPTINCjE3OiAoODUpIGNhbGwgYnBmX3NrY190b190
Y3Bfc29jayMxMzcNCjE4OiBSMF93PXB0cl9vcl9udWxsXyhudWxsKShpZD0zLG9mZj0wLGltbT0w
KSBSNl93PXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTApIFIxMD1mcDAgZnAtOD0/
Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00
MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbSByZWZzPTINCjE4OiAoNTUpIGlmIHIwICE9IDB4MCBn
b3RvIHBjKzMNCiBSMF93PWludjAgUjZfdz1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9mZj0wLGlt
bT0wKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1tbW1tbW0g
ZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0gcmVmcz0yDQoxOTog
UjBfdz1pbnYwIFI2X3c9c29jayhpZD0wLHJlZl9vYmpfaWQ9MixvZmY9MCxpbW09MCkgUjEwPWZw
MCBmcC04PT8/Pz8wMDAwIGZwLTE2PTAwMDBtbW1tIGZwLTI0PW1tbW1tbW1tIGZwLTMyPW1tbW1t
bW1tIGZwLTQwPW1tbW1tbW1tIGZwLTQ4PW1tbW1tbW1tIHJlZnM9Mg0KMTk6IChiZikgcjEgPSBy
Ng0KMjA6IFIwX3c9aW52MCBSMV93PXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTAp
IFI2X3c9c29jayhpZD0wLHJlZl9vYmpfaWQ9MixvZmY9MCxpbW09MCkgUjEwPWZwMCBmcC04PT8/
Pz8wMDAwIGZwLTE2PTAwMDBtbW1tIGZwLTI0PW1tbW1tbW1tIGZwLTMyPW1tbW1tbW1tIGZwLTQw
PW1tbW1tbW1tIGZwLTQ4PW1tbW1tbW1tIHJlZnM9Mg0KMjA6ICg4NSkgY2FsbCBicGZfc2tfcmVs
ZWFzZSM4Ng0KMjE6IFIwX3c9aW52KGlkPTApIFI2X3c9aW52KGlkPTApIFIxMD1mcDAgZnAtOD0/
Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00
MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbQ0KMjE6ICg5NSkgZXhpdA0KMjI6IFIwX3c9cHRyXyhu
dWxsKShpZD0wLG9mZj0wLGltbT0wKSBSNl93PXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAs
aW1tPTApIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1t
bSBmcC0zMj1tbW1tbW1tbSBmcC00MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbSByZWZzPTINCjIy
OiAoYmYpIHIxID0gcjANCjIzOiBSMF93PXB0cl8obnVsbCkoaWQ9MCxvZmY9MCxpbW09MCkgUjFf
dz1wdHJfKG51bGwpKGlkPTAsb2ZmPTAsaW1tPTApIFI2X3c9c29jayhpZD0wLHJlZl9vYmpfaWQ9
MixvZmY9MCxpbW09MCkgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2PTAwMDBtbW1tIGZwLTI0
PW1tbW1tbW1tIGZwLTMyPW1tbW1tbW1tIGZwLTQwPW1tbW1tbW1tIGZwLTQ4PW1tbW1tbW1tIHJl
ZnM9Mg0KMjM6ICg4NSkgY2FsbCBicGZfc2tfcmVsZWFzZSM4Ng0KUjEgaXMgb2YgdHlwZSAobnVs
bCkgYnV0IChudWxsKSBpcyBleHBlY3RlZA0KcHJvY2Vzc2VkIDI0IGluc25zIChsaW1pdCAxMDAw
MDAwKSBtYXhfc3RhdGVzX3Blcl9pbnNuIDAgdG90YWxfc3RhdGVzIDEgcGVha19zdGF0ZXMgMSBt
YXJrX3JlYWQgMQ0KU3VtbWFyeTogMCBQQVNTRUQsIDAgU0tJUFBFRCwgMSBGQUlMRUQNCg==
--000000000000559cc505c4d8bf37
Content-Type: text/plain; charset="US-ASCII"; name="test_verifier_828_le32.txt"
Content-Disposition: attachment; filename="test_verifier_828_le32.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kpys75ni1>
X-Attachment-Id: f_kpys75ni1

IzgyOC9wIHJlZmVyZW5jZSB0cmFja2luZzogYnBmX3NrX3JlbGVhc2UoYnRmX3RjcF9zb2NrKSAs
IHZlcmlmaWVyIGxvZzoNCmZ1bmMjMCBAMA0KMDogUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIx
MD1mcDANCjA6IChiNykgcjIgPSAwDQoxOiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1p
bnYwIFIxMD1mcDANCjE6ICg2MykgKih1MzIgKikocjEwIC04KSA9IHIyDQpsYXN0X2lkeCAxIGZp
cnN0X2lkeCAwDQpyZWdzPTQgc3RhY2s9MCBiZWZvcmUgMDogKGI3KSByMiA9IDANCjI6IFIxPWN0
eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PWludlAwIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMA0KMjog
KDdiKSAqKHU2NCAqKShyMTAgLTE2KSA9IHIyDQozOiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkg
UjJfdz1pbnZQMCBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMA0KMzogKDdi
KSAqKHU2NCAqKShyMTAgLTI0KSA9IHIyDQo0OiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJf
dz1pbnZQMCBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMCBmcC0yNF93PTAw
MDAwMDAwDQo0OiAoN2IpICoodTY0ICopKHIxMCAtMzIpID0gcjINCjU6IFIxPWN0eChpZD0wLG9m
Zj0wLGltbT0wKSBSMl93PWludlAwIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDAw
MDAwIGZwLTI0X3c9MDAwMDAwMDAgZnAtMzJfdz0wMDAwMDAwMA0KNTogKDdiKSAqKHU2NCAqKShy
MTAgLTQwKSA9IHIyDQo2OiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1pbnZQMCBSMTA9
ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMCBmcC0yNF93PTAwMDAwMDAwIGZwLTMy
X3c9MDAwMDAwMDAgZnAtNDBfdz0wMDAwMDAwMA0KNjogKDdiKSAqKHU2NCAqKShyMTAgLTQ4KSA9
IHIyDQo3OiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1pbnZQMCBSMTA9ZnAwIGZwLTg9
Pz8/PzAwMDAgZnAtMTZfdz0wMDAwMDAwMCBmcC0yNF93PTAwMDAwMDAwIGZwLTMyX3c9MDAwMDAw
MDAgZnAtNDBfdz0wMDAwMDAwMCBmcC00OF93PTAwMDAwMDAwDQo3OiAoYmYpIHIyID0gcjEwDQo4
OiBSMT1jdHgoaWQ9MCxvZmY9MCxpbW09MCkgUjJfdz1mcDAgUjEwPWZwMCBmcC04PT8/Pz8wMDAw
IGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMCBmcC0zMl93PTAwMDAwMDAwIGZwLTQw
X3c9MDAwMDAwMDAgZnAtNDhfdz0wMDAwMDAwMA0KODogKDA3KSByMiArPSAtNDgNCjk6IFIxPWN0
eChpZD0wLG9mZj0wLGltbT0wKSBSMl93PWZwLTQ4IFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0x
Nl93PTAwMDAwMDAwIGZwLTI0X3c9MDAwMDAwMDAgZnAtMzJfdz0wMDAwMDAwMCBmcC00MF93PTAw
MDAwMDAwIGZwLTQ4X3c9MDAwMDAwMDANCjk6IChiNykgcjMgPSAzNg0KMTA6IFIxPWN0eChpZD0w
LG9mZj0wLGltbT0wKSBSMl93PWZwLTQ4IFIzX3c9aW52MzYgUjEwPWZwMCBmcC04PT8/Pz8wMDAw
IGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMCBmcC0zMl93PTAwMDAwMDAwIGZwLTQw
X3c9MDAwMDAwMDAgZnAtNDhfdz0wMDAwMDAwMA0KMTA6IChiNykgcjQgPSAwDQoxMTogUjE9Y3R4
KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9ZnAtNDggUjNfdz1pbnYzNiBSNF93PWludjAgUjEwPWZw
MCBmcC04PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMDAwMDAgZnAtMjRfdz0wMDAwMDAwMCBmcC0zMl93
PTAwMDAwMDAwIGZwLTQwX3c9MDAwMDAwMDAgZnAtNDhfdz0wMDAwMDAwMA0KMTE6IChiNykgcjUg
PSAwDQoxMjogUjE9Y3R4KGlkPTAsb2ZmPTAsaW1tPTApIFIyX3c9ZnAtNDggUjNfdz1pbnYzNiBS
NF93PWludjAgUjVfdz1pbnYwIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDAwMDAw
IGZwLTI0X3c9MDAwMDAwMDAgZnAtMzJfdz0wMDAwMDAwMCBmcC00MF93PTAwMDAwMDAwIGZwLTQ4
X3c9MDAwMDAwMDANCjEyOiAoODUpIGNhbGwgYnBmX3NrX2xvb2t1cF90Y3AjODQNCmxhc3RfaWR4
IDEyIGZpcnN0X2lkeCAwDQpyZWdzPTggc3RhY2s9MCBiZWZvcmUgMTE6IChiNykgcjUgPSAwDQpy
ZWdzPTggc3RhY2s9MCBiZWZvcmUgMTA6IChiNykgcjQgPSAwDQpyZWdzPTggc3RhY2s9MCBiZWZv
cmUgOTogKGI3KSByMyA9IDM2DQoxMzogUjBfdz1zb2NrX29yX251bGwoaWQ9MixyZWZfb2JqX2lk
PTIsb2ZmPTAsaW1tPTApIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDBtbW1tIGZw
LTI0X3c9bW1tbW1tbW0gZnAtMzJfdz1tbW1tbW1tbSBmcC00MF93PW1tbW1tbW1tIGZwLTQ4X3c9
bW1tbW1tbW0gcmVmcz0yDQoxMzogKDU1KSBpZiByMCAhPSAweDAgZ290byBwYysxDQogUjBfdz1p
bnYwIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNl93PTAwMDBtbW1tIGZwLTI0X3c9bW1tbW1t
bW0gZnAtMzJfdz1tbW1tbW1tbSBmcC00MF93PW1tbW1tbW1tIGZwLTQ4X3c9bW1tbW1tbW0NCjE0
OiBSMF93PWludjAgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2X3c9MDAwMG1tbW0gZnAtMjRf
dz1tbW1tbW1tbSBmcC0zMl93PW1tbW1tbW1tIGZwLTQwX3c9bW1tbW1tbW0gZnAtNDhfdz1tbW1t
bW1tbQ0KMTQ6ICg5NSkgZXhpdA0KMTU6IFIwPXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAs
aW1tPTApIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1t
bSBmcC0zMj1tbW1tbW1tbSBmcC00MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbSByZWZzPTINCjE1
OiAoYmYpIHI2ID0gcjANCjE2OiBSMD1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9mZj0wLGltbT0w
KSBSNl93PXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTApIFIxMD1mcDAgZnAtOD0/
Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00
MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbSByZWZzPTINCjE2OiAoYmYpIHIxID0gcjANCjE3OiBS
MD1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBSMV93PXNvY2soaWQ9MCxyZWZf
b2JqX2lkPTIsb2ZmPTAsaW1tPTApIFI2X3c9c29jayhpZD0wLHJlZl9vYmpfaWQ9MixvZmY9MCxp
bW09MCkgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2PTAwMDBtbW1tIGZwLTI0PW1tbW1tbW1t
IGZwLTMyPW1tbW1tbW1tIGZwLTQwPW1tbW1tbW1tIGZwLTQ4PW1tbW1tbW1tIHJlZnM9Mg0KMTc6
ICg4NSkgY2FsbCBicGZfc2tjX3RvX3RjcF9zb2NrIzEzNw0KMTg6IFIwX3c9cHRyX29yX251bGxf
dGNwX3NvY2soaWQ9MyxvZmY9MCxpbW09MCkgUjZfdz1zb2NrKGlkPTAscmVmX29ial9pZD0yLG9m
Zj0wLGltbT0wKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1t
bW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0gcmVmcz0y
DQoxODogKDU1KSBpZiByMCAhPSAweDAgZ290byBwYyszDQogUjBfdz1pbnYwIFI2X3c9c29jayhp
ZD0wLHJlZl9vYmpfaWQ9MixvZmY9MCxpbW09MCkgUjEwPWZwMCBmcC04PT8/Pz8wMDAwIGZwLTE2
PTAwMDBtbW1tIGZwLTI0PW1tbW1tbW1tIGZwLTMyPW1tbW1tbW1tIGZwLTQwPW1tbW1tbW1tIGZw
LTQ4PW1tbW1tbW1tIHJlZnM9Mg0KMTk6IFIwX3c9aW52MCBSNl93PXNvY2soaWQ9MCxyZWZfb2Jq
X2lkPTIsb2ZmPTAsaW1tPTApIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBm
cC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1t
bSByZWZzPTINCjE5OiAoYmYpIHIxID0gcjYNCjIwOiBSMF93PWludjAgUjFfdz1zb2NrKGlkPTAs
cmVmX29ial9pZD0yLG9mZj0wLGltbT0wKSBSNl93PXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2Zm
PTAsaW1tPTApIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1t
bW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbSByZWZzPTIN
CjIwOiAoODUpIGNhbGwgYnBmX3NrX3JlbGVhc2UjODYNCjIxOiBSMF93PWludihpZD0wKSBSNl93
PWludihpZD0wKSBSMTA9ZnAwIGZwLTg9Pz8/PzAwMDAgZnAtMTY9MDAwMG1tbW0gZnAtMjQ9bW1t
bW1tbW0gZnAtMzI9bW1tbW1tbW0gZnAtNDA9bW1tbW1tbW0gZnAtNDg9bW1tbW1tbW0NCjIxOiAo
OTUpIGV4aXQNCjIyOiBSMF93PXB0cl90Y3Bfc29jayhpZD0wLG9mZj0wLGltbT0wKSBSNl93PXNv
Y2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTApIFIxMD1mcDAgZnAtOD0/Pz8/MDAwMCBm
cC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00MD1tbW1tbW1t
bSBmcC00OD1tbW1tbW1tbSByZWZzPTINCjIyOiAoYmYpIHIxID0gcjANCjIzOiBSMF93PXB0cl90
Y3Bfc29jayhpZD0wLG9mZj0wLGltbT0wKSBSMV93PXB0cl90Y3Bfc29jayhpZD0wLG9mZj0wLGlt
bT0wKSBSNl93PXNvY2soaWQ9MCxyZWZfb2JqX2lkPTIsb2ZmPTAsaW1tPTApIFIxMD1mcDAgZnAt
OD0/Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBm
cC00MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbSByZWZzPTINCjIzOiAoODUpIGNhbGwgYnBmX3Nr
X3JlbGVhc2UjODYNCjI0OiBSMD1pbnYoaWQ9MCkgUjY9aW52KGlkPTApIFIxMD1mcDAgZnAtOD0/
Pz8/MDAwMCBmcC0xNj0wMDAwbW1tbSBmcC0yND1tbW1tbW1tbSBmcC0zMj1tbW1tbW1tbSBmcC00
MD1tbW1tbW1tbSBmcC00OD1tbW1tbW1tbQ0KMjQ6ICg5NSkgZXhpdA0KcHJvY2Vzc2VkIDI1IGlu
c25zIChsaW1pdCAxMDAwMDAwKSBtYXhfc3RhdGVzX3Blcl9pbnNuIDAgdG90YWxfc3RhdGVzIDIg
cGVha19zdGF0ZXMgMiBtYXJrX3JlYWQgMQ0KT0sNClN1bW1hcnk6IDEgUEFTU0VELCAwIFNLSVBQ
RUQsIDAgRkFJTEVE
--000000000000559cc505c4d8bf37--
