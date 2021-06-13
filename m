Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762C13A516F
	for <lists+bpf@lfdr.de>; Sun, 13 Jun 2021 02:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhFMAK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Jun 2021 20:10:26 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:42557 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFMAKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Jun 2021 20:10:25 -0400
Received: by mail-io1-f50.google.com with SMTP id s26so6539940ioe.9;
        Sat, 12 Jun 2021 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSKrcPGu335cHezrGXttTKy9INtNuY4zhBjhpk4ZArA=;
        b=LQVahZzSxCnwoLa2Zkiljbv0dXpSrxXVuvY3BGQmnqL7Yt0c38UtA4oYjD1tTWGqq2
         Z21uzb+fEasKtlWs40v9cF25xMQPlvnFiIeDU3g/bY0+L4JvHVlpYdKLhimoO32PVwca
         l8QP5WlHtYn/Ooxsyv+hDSJP6Kd93ZO8W7EL0RNWZgorApBh+emLWZnLEA64KeFBMUL8
         J/IYZJmNnS4cLhFgFBF+rRotnJPqtoejmBlWfokLHTVswSUwP1vwA5fvePID07YvDPft
         QoeY2UA4zWd97rmNxn5WP+A31GvbNZ++BLnjzF0X2fOQoE/JKyF/S51IsM1ZGLCLqbGA
         NYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSKrcPGu335cHezrGXttTKy9INtNuY4zhBjhpk4ZArA=;
        b=j8DLuwMuX2ovyDYbv/mGhL61A0m8U5vNpQgc8VrcIfMXwr5bExjFtpBjEE0l61M5ie
         NvVAecEexJNMmzsY2f5BzW4qKrEp6ELGZooWXPPyLpJY+kWg8Wo/u7xarwhHZSTGLNna
         C0SBXcO9N4OMGfLDPMuGopt2odeQeTVk9ghvh23qUn9VPrRvrlJyW0tFIBQvDYoqtFmh
         0/bD5Ou0IHuMzKG0MORn6o8IVqRMtL1hZivXaOI7EKltghDDRiaAi9UEELv/p+aPIJq9
         Qz/HYAQKS65YFGLtyZ9ERi9a/wfKVgXrRevNUibo0pZ1vRODsCrxvNwCgTh+Wu+rnZ8n
         e8AQ==
X-Gm-Message-State: AOAM531skNkFhzwoWDOgDx1WwqODJLC6xaBolcNtHIU+Cjb9Ecqeue9u
        3aU2yqNt1wUKiBviXhEJxbQcvFdbavc4nYh+TGcvSMhJCzSvzQ==
X-Google-Smtp-Source: ABdhPJzG2N4tnJJXZBoz6y7svGbH6o2af1VFj/WCTdC4GDCqAPBRB90TZN5mQTlPlr85OyLSzr0Q/WZGy7ruMg8rP3Q=
X-Received: by 2002:a02:a19e:: with SMTP id n30mr10740183jah.109.1623542832263;
 Sat, 12 Jun 2021 17:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAPGftE_eY-Zdi3wBcgDfkz_iOr1KF10n=9mJHm1_a_PykcsoeA@mail.gmail.com>
 <ce6fd0fd-2fb3-7a66-4910-5fe8c2b4d593@fb.com>
In-Reply-To: <ce6fd0fd-2fb3-7a66-4910-5fe8c2b4d593@fb.com>
From:   Tony Ambardar <tony.ambardar@gmail.com>
Date:   Sat, 12 Jun 2021 17:07:01 -0700
Message-ID: <CAPGftE9+CVuK7KwExRiqsuKHMEUrPsXraBbC5qw8N2NFrE5MYg@mail.gmail.com>
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

On Fri, 11 Jun 2021 at 08:57, Yonghong Song <yhs@fb.com> wrote:
>
> On 6/10/21 6:02 PM, Tony Ambardar wrote:
> > Hello,
> >
> > I encountered an NPE and kernel Oops [1] while running the
> > 'test_verifier' selftest on MIPS32 with LTS kernel 5.10.41. This was
> > observed during development of a MIPS32 JIT but is verifier-related.
> >
> > Initial troubleshooting [2] points to an unchecked NULL dereference in
> > btf_type_by_id(), with an unexpected BTF type ID. The root cause is
> > unclear, whether source of the ID or a potential underlying BTF
> > problem.
>
> Do you know what is the faulty btf ID number? What is the maximum id
> for vmlinux BTF?

Thanks for the suggestions, Yonghong.

I had built/packaged bpftool for the target, which shows the maximum as:

  root@OpenWrt:~# bpftool btf dump file /sys/kernel/btf/vmlinux format
raw|tail -5
  [43179] FUNC 'pci_load_of_ranges' type_id=43178 linkage=static
  [43180] ARRAY '(anon)' type_id=23 index_type_id=23 nr_elems=16
  [43181] FUNC 'pcibios_plat_dev_init' type_id=29264 linkage=static
  [43182] FUNC 'pcibios_map_irq' type_id=29815 linkage=static
  [43183] FUNC 'mips_pcibios_init' type_id=115 linkage=static

After adding NULL handling and debug pr_err() to kernel_type_name(), I next see:

  root@OpenWrt:~# ./test_verifier_eb 828
  [   87.196692] btf_type_by_id(btf_vmlinux, 3062497280) returns NULL
  [   87.196958] btf_type_by_id(btf_vmlinux, 2936995840) returns NULL
  #828/p reference tracking: bpf_sk_release(btf_tcp_sock) FAIL

Those large type ids make me suspect an endianness issue, even though bpftool
can still properly access the vmlinux BTF. Changing byte order and
looking up the
resulting type ids seems to confirm this:

  Check endianness:
    3062497280 -> 0xB68A0000 --swap endian--> 0x00008AB6 -> 35510
  bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[35510]":
    [35510] STRUCT 'tcp_sock' size=1752 vlen=136

  Check endianness:
    2936995840 -> 0xAF0F0000 --swap endian--> 0x00000FAF -> 4015
  bpftool btf dump file /sys/kernel/btf/vmlinux format raw|fgrep "[4015]":
    [4015] STRUCT 'sock_common' size=112 vlen=25

As a further test, I repeated "test_verifier 828" across mips{32,64}{be,le}
systems and confirm seeing the problem only with the big-endian ones.

> The involved helper is bpf_sk_release.
>
> static const struct bpf_func_proto bpf_sk_release_proto = {
>          .func           = bpf_sk_release,
>          .gpl_only       = false,
>          .ret_type       = RET_INTEGER,
>          .arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
> };
>
> Eventually, the btf_id is taken from btf_sock_ids[6] where
> btf_sock_ids is a kernel global variable.
>
> Could you check btf_sock_ids[6] to see whether the number
> makes sense?

What I see matches the second btf_type_by_id() NULL call above:
  [   56.556121] btf_sock_ids[6]: 2936995840

> The id is computed by resolve_btfids in
> tools/bpf/resolve_btfids, you might add verbose mode to your linux build
> to get more information.

The verbose build didn't print any details of the btf ids. Was there anything
special to do in invocation? I manually ran "resolve_btfids -v vmlinux" from
the build dir and this, strangely, gave slightly different results than bpftool
but not the huge endian-swapped type ids. Is this expected?

  # ./tools/bpf/resolve_btfids/resolve_btfids -v vmlinux
  ...
  patching addr   116: ID   35522 [tcp_sock]
  ...
  patching addr   112: ID    4021 [sock_common]

Do any of the details above help narrow down things? What do you suggest
for next steps?

Thanks,
Tony

> >
> > Has this been seen before? How best to debug this further or resolve?
> > What other details would be useful for BPF kernel developers?
> >
> > Thanks for any help,
> > Tony
> >
> > [1]:
> > (Host details)
> > kodidev:~/openwrt-project$ ./staging_dir/host/bin/pahole --version
> > v1.21
> >
> > (Target details)
> > root@OpenWrt:/# uname -a
> > Linux OpenWrt 5.10.41 #0 SMP Tue Jun 1 00:54:31 2021 mips GNU/Linux
> >
> > root@OpenWrt:~# sysctl net.core.bpf_jit_enable=0; ./test_verifier 826 828
> > net.core.bpf_jit_enable = 0
> >
> > #826/p reference tracking: branch tracking valid pointer null comparison OK
> > #827/p reference tracking: branch tracking valid pointer value comparison OK
> > CPU 0 Unable to handle kernel paging request at virtual address
> > 00000000, epc == 80244654, ra == 80244654
> > Oops[#1]:
> > CPU: 0 PID: 16274 Comm: test_verifier Not tainted 5.10.41 #0
> > $ 0   : 00000000 00000001 00000000 0000a8a2
> > $ 4   : 835ac580 a6280000 00000000 00000001
> > $ 8   : 835ac580 a6280000 00000000 02020202
> > $12   : 8348de58 834ba800 00000000 00000000
> > $16   : 835ac580 8098be2c fffffff3 834bdb38
> > $20   : 8098be0c 00000001 00000018 00000000
> > $24   : 00000000 01415415
> > $28   : 834bc000 834bdac8 00000005 80244654
> > Hi    : 00000017
> > Lo    : 0a3d70a2
> > epc   : 80244654 kernel_type_name+0x20/0x38
> > ra    : 80244654 kernel_type_name+0x20/0x38
> > Status: 1000a403 KERNEL EXL IE
> > Cause : 00800008 (ExcCode 02)
> > BadVA : 00000000
> > PrId  : 00019300 (MIPS 24Kc)
> > Modules linked in: pppoe ppp_async pppox ppp_generic mac80211_hwsim
> > mac80211 iptable_nat ipt_REJECT cfg80211 xt_time xt_tcpudp xt_tcpmss
> > xt_statistic xt_state xt_recent xt_nat xt_multiport xt_mark xt_mac
> > xt_limit xt_length xt_hl xt_helper xt_ecn xt_dscp xt_conntrack
> > xt_connmark xt_connlimit xt_connbytes xt_comment xt_TCPMSS xt_REDIRECT
> > xt_MASQUERADE xt_LOG xt_HL xt_FLOWOFFLOAD xt_DSCP xt_CT xt_CLASSIFY
> > slhc sch_mqprio sch_cake pcnet32 nf_reject_ipv4 nf_nat nf_log_ipv4
> > nf_flow_table nf_conntrack_netlink nf_conncount iptable_raw
> > iptable_mangle iptable_filter ipt_ECN ip_tables crc_ccitt compat
> > cls_flower act_vlan pktgen sch_teql sch_sfq sch_red sch_prio sch_pie
> > sch_multiq sch_gred sch_fq sch_dsmark sch_codel em_text em_nbyte
> > em_meta em_cmp act_simple act_police act_pedit act_ipt act_csum
> > libcrc32c em_ipset cls_bpf act_bpf act_ctinfo act_connmark
> > nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 sch_tbf sch_ingress sch_htb
> > sch_hfsc em_u32 cls_u32 cls_tcindex cls_route cls_matchall cls_fw
> >   cls_flow cls_basic act_skbedit act_mirred act_gact xt_set
> > ip_set_list_set ip_set_hash_netportnet ip_set_hash_netport
> > ip_set_hash_netnet ip_set_hash_netiface ip_set_hash_net
> > ip_set_hash_mac ip_set_hash_ipportnet ip_set_hash_ipportip
> > ip_set_hash_ipport ip_set_hash_ipmark ip_set_hash_ip
> > ip_set_bitmap_port ip_set_bitmap_ipmac ip_set_bitmap_ip ip_set
> > nfnetlink nf_log_ipv6 nf_log_common ip6table_mangle ip6table_filter
> > ip6_tables ip6t_REJECT x_tables nf_reject_ipv6 ifb dummy netlink_diag
> > mii
> > Process test_verifier (pid: 16274, threadinfo=c1418596, task=05765195,
> > tls=77e5aec8)
> > Stack : 83428000 83428000 8098be2c 00000000 83428000 8024af78 834bacdc 834bb000
> >          a98a0000 834e2580 834e2c00 00000000 834e2c00 8023da9c 834bb070 00000013
> >          80925164 80924f44 00000000 80925164 00000000 83428140 80bc3864 834bb070
> >          834e2c00 00000000 00000010 802c441c 00000000 00000000 00000000 00000000
> >          00000000 00000000 00000000 00000000 00000000 00000056 00000000 00000000
> >          ...
> > Call Trace:
> > [<80244654>] kernel_type_name+0x20/0x38
> > [<8024af78>] check_helper_call+0x1c9c/0x1dbc
> > [<8024d008>] do_check_common+0x1f70/0x2a3c
> > [<8024fb6c>] bpf_check+0x18f8/0x2308
> > [<802369ec>] bpf_prog_load+0x378/0x860
> > [<80237e1c>] __do_sys_bpf+0x3e0/0x2100
> > [<801142d8>] syscall_common+0x34/0x58
> >
> > Code: afbf0014  0c099b58  02002025 <8c450000> 8fbf0014  02002025
> > 8fb00010  08099b4f  27bd0018
> >
> > ---[ end trace ab13ac5f89eb825b ]---
> > Kernel panic - not syncing: Fatal exception
> > Rebooting in 3 seconds..
> > QEMU: Terminated
> >
> >
> > [2]:
> > Function Code:
> > ==============
> > const char *kernel_type_name(u32 id)
> > {
> >      return btf_name_by_offset(btf_vmlinux,
> >                    btf_type_by_id(btf_vmlinux, id)->name_off);
> > }
> >
> > const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id)
> > {
> >      if (type_id > btf->nr_types)
> >          return NULL;
> >
> >      return btf->types[type_id];
> > }
> >
> > Disassembled Code:
> > ==================
> > 0x0000000000000000:  AF BF 00 14    sw    $ra, 0x14($sp)
> > 0x0000000000000004:  0C 09 9B 58    jal   btf_type_by_id
> > 0x0000000000000008:  02 00 20 25    move  $a0, $s0
> > 0x000000000000000c:  8C 45 00 00    lw    $a1, ($v0)         <-- NPE
> > 0x0000000000000010:  8F BF 00 14    lw    $ra, 0x14($sp)
> > 0x0000000000000014:  02 00 20 25    move  $a0, $s0
> > 0x0000000000000018:  8F B0 00 10    lw    $s0, 0x10($sp)
> > 0x000000000000001c:  08 09 9B 4F    j     btf_name_by_offset
> > 0x0000000000000020:  27 BD 00 18    addiu $sp, $sp, 0x18
> >
