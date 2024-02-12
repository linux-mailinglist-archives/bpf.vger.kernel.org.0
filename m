Return-Path: <bpf+bounces-21786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88050852128
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 23:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D7D8283FA2
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 22:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16984E1CA;
	Mon, 12 Feb 2024 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CdsqXpVS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42004D5AC
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707776061; cv=none; b=S9P0wSgEsYGV8nhKGe2mDKXe1JBFAusLQ9R4dotwh//bneVpBgX/5h7ymT5zUE8T3cGCQWFVFatVe8yeth4X/GzzwQY7gvblq6hU5Ke12+rsW5qrA2gyAV9sxXyn29hM8LD/nZjnWpfYyf2jNEwtpUNeGqJfcOCp20vvi30WbVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707776061; c=relaxed/simple;
	bh=MJQ5/4eAk3NAFnciQgJlfgYLaxJqhkzZZ+rknSLby/w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BIXIhKHsfS+9tibc6lln4GcLjEZyiYpag3R/xjNvU0fsVqEKIfUCZSlVQ+8rc6KWUFIch9pH7Sz+tr0DQvZztQXmyaiSvNWVsabybfHxPLp0KLab/OtjJRAjNh8Qerh4MFr/GL85kluexozi1n1g2XUOQLP6/EYYUQR+WJgGPQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CdsqXpVS; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6e2df9e9074so764044a34.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 14:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1707776058; x=1708380858; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hmbfswjfpl1pzpSmnzXgRXNIJs8L2g5f2RI0ITadHk8=;
        b=CdsqXpVS+weTgXLvM/MaAyl+rxIajXwMbhKKfo2o//djrZv68DGj/tg3qMAG5/sFNu
         FHPYey8ToZbEanscaLsW/25yjAIezNDVhSQvuaAuCznVElWHeIlx5dHsOpeHq+X5OdhE
         0XL4lP2ZERN2VJDCX+tpkaIvaxKP0rKOoaf09wxM+UcE3TvrurTacITstNWPneFS7RnH
         xb2O02nEIHFFOeV9Hoj6RG7DBMB1yg7FWcxooqfW8gjbdVPO2BCJLREZJHJfuqHbGSRa
         JaM9lr0cRK7Ze525UvhasCF71LbLND+KaoJVnXcvu5CYYVl0rkJAj0vYbhoCM/fvuLQv
         fmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707776058; x=1708380858;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmbfswjfpl1pzpSmnzXgRXNIJs8L2g5f2RI0ITadHk8=;
        b=cWClG+BW7KnS5HGZNmXVVY1S+iSn5ZgFLHKgxgKTFi9d9uZ+Pfg0Lw8Ni5bHqSHBgQ
         V96Thsiaw/rrLKCzshd3e652n/giCAut28P8sAFP80kfevQdDIQLWt+41Yh73qSXtydP
         Mzz+yjOfNbkKvNrPBSBvQALgceXto+UmITuRBRLaBeeUcywfL2iqwcG97tRq1USyizRa
         o1yTBBq1E4kI/xqaPPebxrYr97j4Bx75dbLmCPsWL/PKod05Awq+6tM2b0eigAYohnMW
         ldKsO7wTvYFSaihuWLEz2bd5uAzXPVTm9+OwK7SJBcrs3+80cmGi8KZN1oAZas1J1GwV
         6dnQ==
X-Gm-Message-State: AOJu0YwuQc98Pasd+7CYz48ipFX2Y/Cx4dWazxBN3s6tr8dAWkCEip2/
	XZjgZEIssIp6ciIGDmEPIx2yeWdW/JzcEy1DgqFjVEPGtgJj/049yuoVjvMTUeeySBLne/uYsoa
	Y
X-Google-Smtp-Source: AGHT+IFOPhCLVovEXkx8I5GEEcfC5j/MfFbnVw/XDyYK97OBxnSmDnZ572gnpx3RZe1YXFbnlWsXpg==
X-Received: by 2002:a05:6830:1d87:b0:6e2:da8c:1bfb with SMTP id y7-20020a0568301d8700b006e2da8c1bfbmr6990774oti.29.1707776057761;
        Mon, 12 Feb 2024 14:14:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWK5zN7dx1cNq5vCtbFpdyj5k5FTkRmSEBQjUqw0yftqdXD+v9zqjWq6Jb8ZUc5lA1CAddgNXCohzGH8odyRnsxSYdfzKOQ7VQIX0Ty8AxDg3esZsspgi1JH4E=
Received: from debian.debian ([2a09:bac5:7a49:8c::e:29c])
        by smtp.gmail.com with ESMTPSA id b4-20020ac86784000000b0042c6b539d31sm546759qtp.19.2024.02.12.14.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:14:16 -0800 (PST)
Date: Mon, 12 Feb 2024 14:14:14 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: kernel-team@cloudflare.com, jakub@cloudflare.com, ignat@cloudflare.com
Subject: Page faults in tracepoint caused by aliased pointer
Message-ID: <ZcqYNrktYhHFTtzH@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

We are getting page fault errors inside BPF tracepoint that accessed
not-present pages. This caused kernel panic:

[717542.963064][T897981] BUG: unable to handle page fault for address: ffffffffff600c7d
[717542.975692][T897981] #PF: supervisor read access in kernel mode
[717542.986496][T897981] #PF: error_code(0x0000) - not-present page
[717542.997237][T897981] PGD 1965012067 P4D 1965012067 PUD 1965014067 PMD 1965016067 PTE 0
[717543.009965][T897981] Oops: 0000 [#1] PREEMPT SMP NOPTI
[717543.019835][T897981] CPU: 34 PID: 897981 Comm: warp-service Kdump: loaded Tainted: G           O       6.1.74-cloudflare-2024.1.14 #1
[717543.041140][T897981] Hardware name: HYVE EDGE-METAL-GEN11/HS1811D_Lite, BIOS V0.11-sig 12/23/2022
[717543.059260][T897981] RIP: 0010:bpf_prog_2eca29f2a4f78ed1_drop_monitor+0x326/0xada
[717543.071449][T897981] Code: ff eb 07 48 8b bf f8 04 00 00 49 bb 80 0e 00 00 00 80 00 00 4c 39 df 72 0c 49 89 fb 49 81 c3 80 0e 00 00 73 05 45 31 ed eb 07 <4c> 8b af 80 0e 00 00 48 89 ee 48 83 c6 f0 48 bf 00 04 7a 0a 3d 9e
[717543.104780][T897981] RSP: 0018:ffffaece810efab8 EFLAGS: 00010286
[717543.115372][T897981] RAX: 0000000000000000 RBX: ffffcea96b4ae350 RCX: 0000000000000010
[717543.127887][T897981] RDX: 0000000000000030 RSI: ffffffffac168443 RDI: ffffffffff5ffdfd
[717543.140325][T897981] RBP: ffffaece810efb28 R08: ffff9e61e3b27c80 R09: 000000000000e000
[717543.152712][T897981] R10: 0000000000000041 R11: ffffffffff600c7d R12: 00028c9a1e371991
[717543.165011][T897981] R13: 0000000000000000 R14: ffff9e6339dce8c0 R15: ffff9e61e3b27c00
[717543.177253][T897981] FS:  00007f769a1fd6c0(0000) GS:ffff9e6bdfa80000(0000) knlGS:0000000000000000
[717543.194511][T897981] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[717543.205261][T897981] CR2: ffffffffff600c7d CR3: 0000003d21706005 CR4: 0000000000770ee0
[717543.217411][T897981] PKRU: 55555554
[717543.224999][T897981] Call Trace:
[717543.232224][T897981]  <TASK>
[717543.239016][T897981]  ? __die+0x20/0x70
[717543.246661][T897981]  ? page_fault_oops+0x150/0x490
[717543.255270][T897981]  ? __sk_dst_check+0x39/0xa0
[717543.263548][T897981]  ? inet6_csk_route_socket+0x123/0x200
[717543.272622][T897981]  ? exc_page_fault+0x67/0x140
[717543.280831][T897981]  ? asm_exc_page_fault+0x22/0x30
[717543.289230][T897981]  ? tcp_data_queue+0xc03/0xe20
[717543.297374][T897981]  ? bpf_prog_2eca29f2a4f78ed1_drop_monitor+0x326/0xada
[717543.307555][T897981]  ? bpf_prog_2eca29f2a4f78ed1_drop_monitor+0x281/0xada
[717543.317638][T897981]  ? tcp_data_queue+0xc03/0xe20
[717543.325540][T897981]  bpf_trace_run3+0x92/0xc0
[717543.333026][T897981]  ? tcp_data_queue+0xc03/0xe20
[717543.340823][T897981]  kfree_skb_reason+0x7b/0xd0
[717543.348427][T897981]  tcp_data_queue+0xc03/0xe20
[717543.355985][T897981]  tcp_rcv_established+0x218/0x740
[717543.363944][T897981]  tcp_v4_do_rcv+0x157/0x290
[717543.371315][T897981]  tcp_v4_rcv+0xddd/0xf00
[717543.378330][T897981]  ? raw_local_deliver+0xc0/0x230
[717543.385973][T897981]  ip_protocol_deliver_rcu+0x32/0x200
[717543.393880][T897981]  ip_local_deliver_finish+0x73/0xa0
[717543.401616][T897981]  __netif_receive_skb_one_core+0x8b/0xa0
[717543.409751][T897981]  netif_receive_skb+0x38/0x160
[717543.416920][T897981]  tun_get_user+0xbe6/0x1080 [tun]
[717543.424292][T897981]  ? mlx5e_handle_rx_dim+0x6b/0x80 [mlx5_core]
[717543.432754][T897981]  ? mlx5e_napi_poll+0x710/0x720 [mlx5_core]
[717543.441007][T897981]  ? tun_chr_write_iter+0x69/0xb0 [tun]
[717543.448753][T897981]  tun_chr_write_iter+0x69/0xb0 [tun]
[717543.456312][T897981]  vfs_write+0x2a3/0x3b0
[717543.462722][T897981]  ksys_write+0x5f/0xe0
[717543.469018][T897981]  do_syscall_64+0x3b/0x90
[717543.475522][T897981]  entry_SYSCALL_64_after_hwframe+0x4c/0xb6
[717543.483443][T897981] RIP: 0033:0x7f76b3b3027f
[717543.489848][T897981] Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 39 d5 f8 ff 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 8c d5 f8 ff 48
[717543.515551][T897981] RSP: 002b:00007f769a1f9870 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
[717543.526219][T897981] RAX: ffffffffffffffda RBX: 0000000000000500 RCX: 00007f76b3b3027f
[717543.536507][T897981] RDX: 0000000000000500 RSI: 00007f761a694a00 RDI: 00000000000015a4
[717543.546815][T897981] RBP: 00007f75f53cf600 R08: 0000000000000000 R09: 00000000000272c8
[717543.557136][T897981] R10: 00000000000075dc R11: 0000000000000293 R12: 00007f76b37b0198
[717543.567447][T897981] R13: 0000000000000000 R14: 00007f76b37a4000 R15: 0000000000000004
[717543.577777][T897981]  </TASK>
[717543.583106][T897981] Modules linked in: mptcp_diag raw_diag unix_diag xt_LOG nf_log_syslog overlay nft_compat xt_hashlimit ip_set_hash_netport xt_length esp4 nf_conntrack_netlink nft_fwd_netdev nf_dup_netdev xfrm_interface xfrm6_tunnel nft_numgen nft_log nft_limit dummy xfrm_user xfrm_algo fou6 ip6_tunnel tunnel6 ipip mpls_gso mpls_iptunnel mpls_router sit tunnel4 fou nft_ct nf_tables cls_bpf ip_gre gre ip_tunnel geneve ip6_udp_tunnel udp_tunnel zstd zstd_compress zram zsmalloc sch_ingress tcp_diag veth tun udp_diag inet_diag dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6table_mangle ip6table_raw ip6table_security ip6table_nat ip6_tables ipt_REJECT nf_reject_ipv4 xt_tcpmss iptable_filter xt_TCPMSS xt_bpf xt_limit xt_multiport xt_NFLOG nfnetlink_log xt_connbytes xt_connlabel xt_statistic xt_mark xt_connmark xt_conntrack iptable_mangle xt_nat iptable_nat nf_nat xt_owner xt_set xt_comment xt_tcpudp xt_CT iptable_raw
[717543.583186][T897981]  ip_set_hash_ip ip_set_hash_net ip_set nfnetlink tcp_bbr sch_fq nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 algif_skcipher af_alg raid0 md_mod essiv dm_crypt trusted asn1_encoder tee 8021q garp mrp stp llc nvme_fabrics ipmi_ssif amd64_edac kvm_amd kvm irqbypass crc32_pclmul crc32c_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 mlx5_core aesni_intel acpi_ipmi rapl ipmi_si mlxfw xhci_pci nvme tls ipmi_devintf tiny_power_button xhci_hcd nvme_core psample ccp i2c_piix4 ipmi_msghandler button fuse dm_mod dax efivarfs ip_tables x_tables bcmcrypt(O) crypto_simd cryptd [last unloaded: kheaders]
[717543.774881][T897981] CR2: ffffffffff600c7d

The panic happens as we inspect dropped out of order TCP packets in kfree_skb
tracepoint with a tp_btf program, and try to read out the network namespace
cookie via:

skb->dev->nd_net.net->net_cookie

Code generation looks fine on x86_64 with 4 layer pagetable, but the verifier
placed boundary check is not sufficient to catch the issue: skb->dev is alised
as skb->rbnode in the same union after packets entered TCP state machine, and
the out of order queue is one of such rbnode users:

; uint64_t netns_cookie = skb->dev->nd_net.net->net_cookie;
 2bd:   movabs $0x800000000010,%r11
 2c7:   cmp    %r11,%r15
 2ca:   jb     0x000002d8
 2cc:   mov    %r15,%r11
 2cf:   add    $0x10,%r11
 2d6:   jae    0x000002dc
 2d8:   xor    %edi,%edi
 2da:   jmp    0x000002e0
 2dc:   mov    0x10(%r15),%rdi
; uint64_t netns_cookie = skb->dev->nd_net.net->net_cookie;
 2e0:   movabs $0x8000000004f8,%r11
 2ea:   cmp    %r11,%rdi   <--- (1) rdi is a valid rbnode*, not net_device*
 2ed:   jb     0x000002fb
 2ef:   mov    %rdi,%r11
 2f2:   add    $0x4f8,%r11
 2f9:   jae    0x000002ff
 2fb:   xor    %edi,%edi
 2fd:   jmp    0x00000306
 2ff:   mov    0x4f8(%rdi),%rdi
; uint64_t netns_cookie = skb->dev->nd_net.net->net_cookie;
 306:   movabs $0x800000000e80,%r11
 310:   cmp    %r11,%rdi  <--- (2) rdi is a wild ptr now
 313:   jb     0x00000321
 315:   mov    %rdi,%r11
 318:   add    $0xe80,%r11
 31f:   jae    0x00000326
 321:   xor    %r13d,%r13d
 324:   jmp    0x0000032d
 326:   mov    0xe80(%rdi),%r13 <--- (3) fault
 32d:   mov    %rbp,%rsi

OOO happens a lot on our servers but this is the first time we noticed
such panic since we had deployed the program for a while. For bpf list
I think the question is mainly about what to do in this scenario:
apparently it is a valid kernel pointer at step (1) above, but it's
just not the type we assumed, which leads to a wild pointer at (2) and
caused fault at (3). I am not aware of a way to determine such aliased
pointer is good or not in general. Is it possible to PF safer in this
case, like returning from PF handler to the end of tracing program?

thanks
Yan

