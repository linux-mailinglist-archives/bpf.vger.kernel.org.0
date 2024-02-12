Return-Path: <bpf+bounces-21793-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC1E852257
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 00:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54E01F23AD5
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06B34F605;
	Mon, 12 Feb 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JB/e1PUo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA2D4F1E0
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779767; cv=none; b=FjljMghy8GHnh9qccglU4aqqj5xDD0xoGrM1JIeqF3jYiwYwlg+pUOc+ZKqkE97hBhH52R0DTchNK1E296ACCcNfJRsozF17e1MV6zCdwNMTPYUfzgteLlQJQ8o132Otmqf3IyLXB482Cvn82rdAHFiQxA7a1e5gQzmwQhbqAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779767; c=relaxed/simple;
	bh=HMgwcxifUAzXcBrjU6Y2YjgRKTeq2WLH4WHzBMSH0Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfFumdRg/NI2thCmIYlk87yZe00lpM14mPIs3agRiMbZ8oXgJEECaT8m67THmwvbXnPZ6HgqMnyfQsF/NT0vUE9CDPfDsjHevW1gsLmv+IKDxySzGy8iER+N5XI2fBmnMizsdpkaqMwtAy6QEl7+v+/KjxMRdZZsHUBni8V9gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JB/e1PUo; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-295c67ab2ccso2141657a91.1
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 15:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707779763; x=1708384563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwEdOZh+r/9bA5g5Kd7p55Has6HA2TB45A+S8DzcaB8=;
        b=JB/e1PUo57Q45ioqcHwa1oo/xdSgx8cbP0kpHzn2YwFkEXQj5tWQWOalTUBw0yD7lw
         Peh4IuIDDeFLyDUMTEPKL0lI2Z7uYppdxFpx1Hpw5BHgNSXA1JF31o3fn5l4i0I8dsYN
         ophot15pRmjHF/Z1pmY5gNIXYjAdJoOd8qCevLKCcCvDMqz/oSk427ksULLTxFFHzUw7
         1HLls/Op+a8DacklOFgokZCDL3s3XkcKnDDlNGJK36ufKwLbvCuRhesbdkPP8OJ+fZV+
         ZIURilWD7r1ocCtugi/XfeVEGVB0hDhF8FAAPfRXut/yHrq3P6Ek42e6aHdfvPF90Y69
         4WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707779763; x=1708384563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwEdOZh+r/9bA5g5Kd7p55Has6HA2TB45A+S8DzcaB8=;
        b=UcBbmsX1FLvYvirJj+VTz+ZRh4FUKFtNzfs8mvbwCgmi9Zr34de+xvN7HmBVH6FKst
         6uFMNOdN9y8oX6vkTy9LAOQql1j0jjGgqLDnOwSkymRt6HENYPKooRkhr4EHLR4JuCTS
         v218njmmN6wCU2H5Xpg77emE5M9gfcCzVcLGZAT68Ez8WT7wwzYi6alUXJRCHQhmFBRs
         neDF/ewrZKuUMVs9A8YSEb35jJO9H1443k24s/ItIg+sBT7Dsuz2T951EjFKD8J7GwB0
         m1DuNFL1/3aRMzWB7IXmYn3nkMPT4999JZeY7Wf/BBt51LVrKxCwSqwNuXEpipV18g5E
         JhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa21YMLb0SS/+NkSp5LhiH8oR4NW0j18CLNWNx1NG27MV6ni9uIwHKiZIrqZoBut3EZGiLVXl/9eFbmsQTbtOiiJSq
X-Gm-Message-State: AOJu0YxsM1I9CI00zYMZ4CDo6lX2Rk4k1tVep4twMPHWAMRTmU5sn5bi
	WW21Lo9/vZeAPFzye1qcYn8IAxQNgNTxABlc+5Rwb2qOlox4FPUIjDTxojlwWio5HLg2QsrUN6Y
	FOivYWdvzRY0fDzTaDrs9h8eNPxM8b13NYzJtNK8glGLxJFRiQjD9Pg==
X-Google-Smtp-Source: AGHT+IG9/wDo51scgHzDAg6lnpyDXv8Mq5sYmfVg8l9duCt1wREy1nBSVesP5Xk6gKYxupjgw77aqEsqH3B3h7ypQHs=
X-Received: by 2002:a17:90a:db53:b0:298:a651:4bc1 with SMTP id
 u19-20020a17090adb5300b00298a6514bc1mr175029pjx.13.1707779763215; Mon, 12 Feb
 2024 15:16:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZcqYNrktYhHFTtzH@debian.debian> <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
In-Reply-To: <CAP01T74dQAt1UUGkUazx17XAj7k3LCMvw8Y+_rKzwH8eUao75g@mail.gmail.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 12 Feb 2024 23:15:52 +0000
Message-ID: <CALrw=nGU-gBihe-08rJaxdwpRPQLBPLEQn5q+aBwzLKZ4Go+JQ@mail.gmail.com>
Subject: Re: Page faults in tracepoint caused by aliased pointer
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yan Zhai <yan@cloudflare.com>, bpf@vger.kernel.org, kernel-team@cloudflare.com, 
	jakub@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 10:55=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 12 Feb 2024 at 23:14, Yan Zhai <yan@cloudflare.com> wrote:
> >
> > Hello!
> >
> > We are getting page fault errors inside BPF tracepoint that accessed
> > not-present pages. This caused kernel panic:
> >
> > [717542.963064][T897981] BUG: unable to handle page fault for address: =
ffffffffff600c7d
> > [717542.975692][T897981] #PF: supervisor read access in kernel mode
> > [717542.986496][T897981] #PF: error_code(0x0000) - not-present page
> > [717542.997237][T897981] PGD 1965012067 P4D 1965012067 PUD 1965014067 P=
MD 1965016067 PTE 0
> > [717543.009965][T897981] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [717543.019835][T897981] CPU: 34 PID: 897981 Comm: warp-service Kdump: =
loaded Tainted: G           O       6.1.74-cloudflare-2024.1.14 #1
> > [717543.041140][T897981] Hardware name: HYVE EDGE-METAL-GEN11/HS1811D_L=
ite, BIOS V0.11-sig 12/23/2022
> > [717543.059260][T897981] RIP: 0010:bpf_prog_2eca29f2a4f78ed1_drop_monit=
or+0x326/0xada
> > [717543.071449][T897981] Code: ff eb 07 48 8b bf f8 04 00 00 49 bb 80 0=
e 00 00 00 80 00 00 4c 39 df 72 0c 49 89 fb 49 81 c3 80 0e 00 00 73 05 45 3=
1 ed eb 07 <4c> 8b af 80 0e 00 00 48 89 ee 48 83 c6 f0 48 bf 00 04 7a 0a 3d=
 9e
> > [717543.104780][T897981] RSP: 0018:ffffaece810efab8 EFLAGS: 00010286
> > [717543.115372][T897981] RAX: 0000000000000000 RBX: ffffcea96b4ae350 RC=
X: 0000000000000010
> > [717543.127887][T897981] RDX: 0000000000000030 RSI: ffffffffac168443 RD=
I: ffffffffff5ffdfd
> > [717543.140325][T897981] RBP: ffffaece810efb28 R08: ffff9e61e3b27c80 R0=
9: 000000000000e000
> > [717543.152712][T897981] R10: 0000000000000041 R11: ffffffffff600c7d R1=
2: 00028c9a1e371991
> > [717543.165011][T897981] R13: 0000000000000000 R14: ffff9e6339dce8c0 R1=
5: ffff9e61e3b27c00
> > [717543.177253][T897981] FS:  00007f769a1fd6c0(0000) GS:ffff9e6bdfa8000=
0(0000) knlGS:0000000000000000
> > [717543.194511][T897981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > [717543.205261][T897981] CR2: ffffffffff600c7d CR3: 0000003d21706005 CR=
4: 0000000000770ee0
> > [717543.217411][T897981] PKRU: 55555554
> > [717543.224999][T897981] Call Trace:
> > [717543.232224][T897981]  <TASK>
> > [717543.239016][T897981]  ? __die+0x20/0x70
> > [717543.246661][T897981]  ? page_fault_oops+0x150/0x490
> > [717543.255270][T897981]  ? __sk_dst_check+0x39/0xa0
> > [717543.263548][T897981]  ? inet6_csk_route_socket+0x123/0x200
> > [717543.272622][T897981]  ? exc_page_fault+0x67/0x140
> > [717543.280831][T897981]  ? asm_exc_page_fault+0x22/0x30
> > [717543.289230][T897981]  ? tcp_data_queue+0xc03/0xe20
> > [717543.297374][T897981]  ? bpf_prog_2eca29f2a4f78ed1_drop_monitor+0x32=
6/0xada
> > [717543.307555][T897981]  ? bpf_prog_2eca29f2a4f78ed1_drop_monitor+0x28=
1/0xada
> > [717543.317638][T897981]  ? tcp_data_queue+0xc03/0xe20
> > [717543.325540][T897981]  bpf_trace_run3+0x92/0xc0
> > [717543.333026][T897981]  ? tcp_data_queue+0xc03/0xe20
> > [717543.340823][T897981]  kfree_skb_reason+0x7b/0xd0
> > [717543.348427][T897981]  tcp_data_queue+0xc03/0xe20
> > [717543.355985][T897981]  tcp_rcv_established+0x218/0x740
> > [717543.363944][T897981]  tcp_v4_do_rcv+0x157/0x290
> > [717543.371315][T897981]  tcp_v4_rcv+0xddd/0xf00
> > [717543.378330][T897981]  ? raw_local_deliver+0xc0/0x230
> > [717543.385973][T897981]  ip_protocol_deliver_rcu+0x32/0x200
> > [717543.393880][T897981]  ip_local_deliver_finish+0x73/0xa0
> > [717543.401616][T897981]  __netif_receive_skb_one_core+0x8b/0xa0
> > [717543.409751][T897981]  netif_receive_skb+0x38/0x160
> > [717543.416920][T897981]  tun_get_user+0xbe6/0x1080 [tun]
> > [717543.424292][T897981]  ? mlx5e_handle_rx_dim+0x6b/0x80 [mlx5_core]
> > [717543.432754][T897981]  ? mlx5e_napi_poll+0x710/0x720 [mlx5_core]
> > [717543.441007][T897981]  ? tun_chr_write_iter+0x69/0xb0 [tun]
> > [717543.448753][T897981]  tun_chr_write_iter+0x69/0xb0 [tun]
> > [717543.456312][T897981]  vfs_write+0x2a3/0x3b0
> > [717543.462722][T897981]  ksys_write+0x5f/0xe0
> > [717543.469018][T897981]  do_syscall_64+0x3b/0x90
> > [717543.475522][T897981]  entry_SYSCALL_64_after_hwframe+0x4c/0xb6
> > [717543.483443][T897981] RIP: 0033:0x7f76b3b3027f
> > [717543.489848][T897981] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e=
8 39 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 0=
0 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c d5 f8 ff=
 48
> > [717543.515551][T897981] RSP: 002b:00007f769a1f9870 EFLAGS: 00000293 OR=
IG_RAX: 0000000000000001
> > [717543.526219][T897981] RAX: ffffffffffffffda RBX: 0000000000000500 RC=
X: 00007f76b3b3027f
> > [717543.536507][T897981] RDX: 0000000000000500 RSI: 00007f761a694a00 RD=
I: 00000000000015a4
> > [717543.546815][T897981] RBP: 00007f75f53cf600 R08: 0000000000000000 R0=
9: 00000000000272c8
> > [717543.557136][T897981] R10: 00000000000075dc R11: 0000000000000293 R1=
2: 00007f76b37b0198
> > [717543.567447][T897981] R13: 0000000000000000 R14: 00007f76b37a4000 R1=
5: 0000000000000004
> > [717543.577777][T897981]  </TASK>
> > [717543.583106][T897981] Modules linked in: mptcp_diag raw_diag unix_di=
ag xt_LOG nf_log_syslog overlay nft_compat xt_hashlimit ip_set_hash_netport=
 xt_length esp4 nf_conntrack_netlink nft_fwd_netdev nf_dup_netdev xfrm_inte=
rface xfrm6_tunnel nft_numgen nft_log nft_limit dummy xfrm_user xfrm_algo f=
ou6 ip6_tunnel tunnel6 ipip mpls_gso mpls_iptunnel mpls_router sit tunnel4 =
fou nft_ct nf_tables cls_bpf ip_gre gre ip_tunnel geneve ip6_udp_tunnel udp=
_tunnel zstd zstd_compress zram zsmalloc sch_ingress tcp_diag veth tun udp_=
diag inet_diag dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio ip6t_=
REJECT nf_reject_ipv6 ip6table_filter ip6table_mangle ip6table_raw ip6table=
_security ip6table_nat ip6_tables ipt_REJECT nf_reject_ipv4 xt_tcpmss iptab=
le_filter xt_TCPMSS xt_bpf xt_limit xt_multiport xt_NFLOG nfnetlink_log xt_=
connbytes xt_connlabel xt_statistic xt_mark xt_connmark xt_conntrack iptabl=
e_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment xt_tcpudp xt_=
CT iptable_raw
> > [717543.583186][T897981]  ip_set_hash_ip ip_set_hash_net ip_set nfnetli=
nk tcp_bbr sch_fq nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 algif_skcipher=
 af_alg raid0 md_mod essiv dm_crypt trusted asn1_encoder tee 8021q garp mrp=
 stp llc nvme_fabrics ipmi_ssif amd64_edac kvm_amd kvm irqbypass crc32_pclm=
ul crc32c_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 mlx5_core aesni_intel =
acpi_ipmi rapl ipmi_si mlxfw xhci_pci nvme tls ipmi_devintf tiny_power_butt=
on xhci_hcd nvme_core psample ccp i2c_piix4 ipmi_msghandler button fuse dm_=
mod dax efivarfs ip_tables x_tables bcmcrypt(O) crypto_simd cryptd [last un=
loaded: kheaders]
> > [717543.774881][T897981] CR2: ffffffffff600c7d
> >
> > The panic happens as we inspect dropped out of order TCP packets in kfr=
ee_skb
> > tracepoint with a tp_btf program, and try to read out the network names=
pace
> > cookie via:
> >
> > skb->dev->nd_net.net->net_cookie
> >
> > Code generation looks fine on x86_64 with 4 layer pagetable, but the ve=
rifier
> > placed boundary check is not sufficient to catch the issue: skb->dev is=
 alised
> > as skb->rbnode in the same union after packets entered TCP state machin=
e, and
> > the out of order queue is one of such rbnode users:
> >
> > ; uint64_t netns_cookie =3D skb->dev->nd_net.net->net_cookie;
> >  2bd:   movabs $0x800000000010,%r11
> >  2c7:   cmp    %r11,%r15
> >  2ca:   jb     0x000002d8
> >  2cc:   mov    %r15,%r11
> >  2cf:   add    $0x10,%r11
> >  2d6:   jae    0x000002dc
> >  2d8:   xor    %edi,%edi
> >  2da:   jmp    0x000002e0
> >  2dc:   mov    0x10(%r15),%rdi
> > ; uint64_t netns_cookie =3D skb->dev->nd_net.net->net_cookie;
> >  2e0:   movabs $0x8000000004f8,%r11
> >  2ea:   cmp    %r11,%rdi   <--- (1) rdi is a valid rbnode*, not net_dev=
ice*
> >  2ed:   jb     0x000002fb
> >  2ef:   mov    %rdi,%r11
> >  2f2:   add    $0x4f8,%r11
> >  2f9:   jae    0x000002ff
> >  2fb:   xor    %edi,%edi
> >  2fd:   jmp    0x00000306
> >  2ff:   mov    0x4f8(%rdi),%rdi
> > ; uint64_t netns_cookie =3D skb->dev->nd_net.net->net_cookie;
> >  306:   movabs $0x800000000e80,%r11
> >  310:   cmp    %r11,%rdi  <--- (2) rdi is a wild ptr now
> >  313:   jb     0x00000321
> >  315:   mov    %rdi,%r11
> >  318:   add    $0xe80,%r11
> >  31f:   jae    0x00000326
> >  321:   xor    %r13d,%r13d
> >  324:   jmp    0x0000032d
> >  326:   mov    0xe80(%rdi),%r13 <--- (3) fault
> >  32d:   mov    %rbp,%rsi
> >
> > OOO happens a lot on our servers but this is the first time we noticed
> > such panic since we had deployed the program for a while. For bpf list
> > I think the question is mainly about what to do in this scenario:
> > apparently it is a valid kernel pointer at step (1) above, but it's
> > just not the type we assumed, which leads to a wild pointer at (2) and
> > caused fault at (3). I am not aware of a way to determine such aliased
> > pointer is good or not in general. Is it possible to PF safer in this
> > case, like returning from PF handler to the end of tracing program?
> >
>
> I think it is not supposed to panic, since exception handling for such
> PROBE_MEM loads should handle such a case and mark the destination as
> zero.
> Something must be broken with that.
>
> Which kernel do you observe this problem with? And do you have a
> reference version where you do not see it?
> Do you have a reduced reproducer for this that I could play with?
> Just the part of the tp_btf program necessary to trigger this?

We were able to reproduce this with a simple bpftrace (version 0.17.1):

$ sudo bpftrace -kk -e 'BEGIN { print(*(uint8 *)0xffffffffff600c7d); exit()=
; }'
WARNING: Addrspace is not set
Attaching 1 probe...
Killed
[288931.216699][T109754] BUG: unable to handle page fault for address:
ffffffffff600c7d
[288931.217143][T109754] #PF: supervisor read access in kernel mode
[288931.217143][T109754] #PF: error_code(0x0000) - not-present page
[288931.217143][T109754] PGD fa5a1e067 P4D fa5a1e067 PUD fa5a20067 PMD
fa5a22067 PTE 0
[288931.217143][T109754] Oops: 0000 [#1] PREEMPT SMP NOPTI
[288931.217143][T109754] CPU: 4 PID: 109754 Comm: bpftrace Not tainted
6.6.16+ #10
[288931.217143][T109754] Hardware name: KubeVirt None/RHEL, BIOS
edk2-20221207gitfff6d81270b5-9.el9 12/07/2022
[288931.217143][T109754] RIP: 0010:copy_from_kernel_nofault+0x89/0xe0
[288931.217143][T109754] Code: 48 83 c3 04 48 83 c5 04 49 83 ec 04 49
83 fc 01 76 13 66 8b 03 66 89 45 00 48 83 c3 02 48 83 c5 02 49 83 ec
02 4d 85 e4 74 05 <8a> 03 88 45 00 65 48 8b 04 25 80 11 03 00 83 a8 54
1b 00 00 01 31
[288931.217143][T109754] RSP: 0018:ffff93d787777d38 EFLAGS: 00010202
[288931.217143][T109754] RAX: ffff910d4830a0c0 RBX: ffffffffff600c7d
RCX: 0000000000000010
[288931.217143][T109754] RDX: 0000000000000030 RSI: 0000000000000001
RDI: ffffffffff600c7d
[288931.217143][T109754] RBP: ffff93d787777d87 R08: 0101010101010101
R09: 00000000fffffdf4
[288931.217143][T109754] R10: 0000000000000000 R11: 0000000000000000
R12: 0000000000000001
[288931.217143][T109754] R13: ffff93d7807eb000 R14: 000000000000000a
R15: 0000000000000000
[288931.217143][T109754] FS:  00007f2818fd79c0(0000)
GS:ffff911c7f800000(0000) knlGS:0000000000000000
[288931.217143][T109754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[288931.217143][T109754] CR2: ffffffffff600c7d CR3: 00000001174f4000
CR4: 0000000000350ee0
[288931.217143][T109754] Call Trace:
[288931.217143][T109754]  <TASK>
[288931.217143][T109754]  ? __die+0x1f/0x70
[288931.217143][T109754]  ? page_fault_oops+0x151/0x480
[288931.217143][T109754]  ? srso_return_thunk+0x5/0x10
[288931.217143][T109754]  ? alloc_empty_file+0x7a/0x120
[288931.217143][T109754]  ? __d_instantiate+0x34/0xf0
[288931.217143][T109754]  ? srso_return_thunk+0x5/0x10
[288931.217143][T109754]  ? alloc_file+0x9b/0x170
[288931.217143][T109754]  ? exc_page_fault+0x68/0x140
[288931.217143][T109754]  ? asm_exc_page_fault+0x22/0x30
[288931.217143][T109754]  ? copy_from_kernel_nofault+0x89/0xe0
[288931.217143][T109754]  ? copy_from_kernel_nofault+0x1d/0xe0
[288931.217143][T109754]  bpf_probe_read_compat+0x6a/0x90
[288931.217143][T109754]  bpf_prog_27620a19791a7c9c_BEGIN+0x2e/0xe7
[288931.217143][T109754]  ? srso_return_thunk+0x5/0x10
[288931.217143][T109754]  __bpf_prog_test_run_raw_tp+0x2e/0x90
[288931.217143][T109754]  bpf_prog_test_run_raw_tp+0xe6/0x1c0
[288931.217143][T109754]  __sys_bpf+0x93a/0x26a0
[288931.217143][T109754]  ? srso_return_thunk+0x5/0x10
[288931.217143][T109754]  ? __check_object_size+0x16a/0x2c0
[288931.217143][T109754]  ? srso_return_thunk+0x5/0x10
[288931.217143][T109754]  __x64_sys_bpf+0x1a/0x30
[288931.217143][T109754]  do_syscall_64+0x3a/0x90
[288931.217143][T109754]  entry_SYSCALL_64_after_hwframe+0x56/0xc0
[288931.217143][T109754] RIP: 0033:0x7f281b320719
[288931.217143][T109754] Code: 08 89 e8 5b 5d c3 66 2e 0f 1f 84 00 00
00 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c
8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 06 0d 00 f7
d8 64 89 01 48
[288931.217143][T109754] RSP: 002b:00007ffdab7f0118 EFLAGS: 00000246
ORIG_RAX: 0000000000000141
[288931.217143][T109754] RAX: ffffffffffffffda RBX: 00007ffdab7f01e8
RCX: 00007f281b320719
[288931.217143][T109754] RDX: 0000000000000050 RSI: 00007ffdab7f0120
RDI: 000000000000000a
[288931.217143][T109754] RBP: 00000000024e27a0 R08: 00007f28100cf880
R09: 0000000000000016
[288931.217143][T109754] R10: 0000000000000007 R11: 0000000000000246
R12: 00000000ffffffff
[288931.217143][T109754] R13: 00007ffdab7f10c8 R14: 000000000000000d
R15: 00000000024e27a0
[288931.217143][T109754]  </TASK>
[288931.217143][T109754] Modules linked in: xt_bpf xt_conntrack
nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype
nft_compat nf_tables br_netfilter bridge stp llc overlay kvm_amd ccp
kvm irqbypass crc32_pclmul sha512_ssse3 sha256_ssse3 sha1_ssse3
aesni_intel crypto_simd cryptd virtio_balloon virtio_console
tiny_power_button button fuse dm_mod dax configfs nfnetlink efivarfs
ip_tables x_tables virtio_net net_failover virtio_blk virtio_scsi
failover crc32c_intel i2c_i801 virtio_pci i2c_smbus
virtio_pci_legacy_dev virtio_pci_modern_dev virtio virtio_ring
[288931.217143][T109754] CR2: ffffffffff600c7d
[288931.217143][T109754] ---[ end trace 0000000000000000 ]---
[288931.509063][T109754] RIP: 0010:copy_from_kernel_nofault+0x89/0xe0
[288931.509063][T109754] Code: 48 83 c3 04 48 83 c5 04 49 83 ec 04 49
83 fc 01 76 13 66 8b 03 66 89 45 00 48 83 c3 02 48 83 c5 02 49 83 ec
02 4d 85 e4 74 05 <8a> 03 88 45 00 65 48 8b 04 25 80 11 03 00 83 a8 54
1b 00 00 01 31
[288931.509063][T109754] RSP: 0018:ffff93d787777d38 EFLAGS: 00010202
[288931.509063][T109754] RAX: ffff910d4830a0c0 RBX: ffffffffff600c7d
RCX: 0000000000000010
[288931.509063][T109754] RDX: 0000000000000030 RSI: 0000000000000001
RDI: ffffffffff600c7d
[288931.509063][T109754] RBP: ffff93d787777d87 R08: 0101010101010101
R09: 00000000fffffdf4
[288931.509063][T109754] R10: 0000000000000000 R11: 0000000000000000
R12: 0000000000000001
[288931.509063][T109754] R13: ffff93d7807eb000 R14: 000000000000000a
R15: 0000000000000000
[288931.509063][T109754] FS:  00007f2818fd79c0(0000)
GS:ffff911c7f800000(0000) knlGS:0000000000000000
[288931.509063][T109754] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[288931.509063][T109754] CR2: ffffffffff600c7d CR3: 00000001174f4000
CR4: 0000000000350ee0
[288931.509063][T109754] note: bpftrace[109754] exited with irqs disabled
[288932.319062][T109754] note: bpftrace[109754] exited with preempt_count 1

And Jakub CCed here did it for 6.8.0-rc2+

> There were some changes made to the JIT code around the bounds
> checking to reduce the instruction count.
> That was in 90156f4bfa21 ("bpf, x86: Improve PROBE_MEM runtime load check=
").
> Especially when src_reg =3D=3D dst_reg, the case which happens in the
> splat at 0x2ff.
> Nothing else comes immediately to mind in terms of changes that could
> affect this exception handling stuff.
>
> > thanks
> > Yan
> >

Ignat

