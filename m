Return-Path: <bpf+bounces-53509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B7CA55906
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F03016A5FB
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90925275601;
	Thu,  6 Mar 2025 21:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G92aS2D1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F97249E5
	for <bpf@vger.kernel.org>; Thu,  6 Mar 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297447; cv=none; b=CiiDPkDphMDMQIKRfP0RHbQqwDQA+ag7fC8p/Lvy4yheDOGiFCVCcmBLt26JB+7CRC2lK7Z8qKzVGzyaId/QPS59yoSvjDF4Y7SJWScvMP1LLnljeWEqX44Dv/Ei5Q2nOA47v3fQiRznCXCXVl1lgyLj+hlt7isgy33UqKs2kZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297447; c=relaxed/simple;
	bh=7x44GD5W7k71Q0/s0g7nT2e9Q/utM6FPat8phadw7oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eL9LMEZqkt8makhEeWGhXz0SEPv9NQATSl2PqEnveQhTZl5dY2zZL4OouovhFCkq57cY08rYsy+sDf5TJu4ucKXQSaPIsxU2MhKR5WyLdsdiaXdjUUis1hDeqF/f0k5YotQBwWDgL0bOsvC9rLzpiELtR/0pA5eDLsnDQlh2W/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G92aS2D1; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fec13a4067so1934901a91.2
        for <bpf@vger.kernel.org>; Thu, 06 Mar 2025 13:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741297445; x=1741902245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKdlhywlhkpRZcjtwhZL6gJe07YJe+BGmuIsD+ZeB8g=;
        b=G92aS2D17fgzOLU3TD1Pd8HJjjqDBKw+Ghh+OF5SAQOBELvPtD9C0woLVpqWfni3kU
         F3kYqmbbjjURagKK2AOvXjsQxYa9pj+RmysrRegDjUG9QFJ+GHmTg4k2Vz62cwDS+qkF
         xNHSRgK8PC4UkXm5fffM8I2Pgl3M06fXbQl91K591ifZEjAo1ij/wVRhd2xH5cd5Pm+n
         aoewCdztZ+vJrXTJapCB4+lPrkSjybfYWnsQrUsYXqdmvBOV8OspLvztnQ7gCpx9INHU
         7vwCZTK2Qyw+uMYj2MtERC3vSHygCr8Mep/gM8PbpH+buuvQr2vUo5jitC0GNCHYFukY
         H9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297445; x=1741902245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKdlhywlhkpRZcjtwhZL6gJe07YJe+BGmuIsD+ZeB8g=;
        b=l3bxSol9rXXFlcWNKe2Y0Scd84uZIRZbMDna6kEHdnJvDm+88w5MqHZp7Uy1X9hJD3
         P6107XzxpzO77GXkYtyhj9pVv6aeamiTJqHlJAKnVWOzu32KkX8wTG3BC7JFyu7yGON4
         h5IuXY6e/+JunzuJT6HqKuEjan8vP7MEyow/+U3OVAIax1v0QJ7VOcWI14tuWy9WW5sm
         gIC1+4j41qOvugza0o2zE9lOf0Z3wiGpSCK9XnA4t8PCOL1IPQPS60Bdk5l0TMk7IFQf
         3LKOhV5CnTiSW6HmoJnaXFxkspUHpECYtbuXvzZw1S00HUQaS/2t8MVtKQAqTPs9jv05
         8THg==
X-Forwarded-Encrypted: i=1; AJvYcCUYxkVc/9nq2PtkBvn4N/x8vw6O66uVOeLdvcyCLZ8xxo9lCXBoh/3WlrnPbssno8x6Esg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCiuSce/H4+nMB10EtXLC3HAcng4+Km7XbObMlKSgpyoY+lZjs
	54FD16+VkT4UMwQUECpeY747K19w+byh9LROr3FSGBYI3Y2/mjQo8HlMIQ==
X-Gm-Gg: ASbGncsLDj+MitXnoxpbjGb/vvLz+gdsfqZLhXZs0m58vdxZPO5pAVk/CLCAlgfDKmW
	+gYG/AdRI009yGZYRn73noWOP9WLOwLWtM2hQg8leqAVjHYKOgIYd3P5OagcTQ9/bzxubhd3GuS
	h3lfCB4LwlABwMjeSzbROxvRYLLGGCkLC46Hz8a5Mt1vYZr4cTUsK5XU3Pu76w2OXv/1ikGy2DI
	20FE2YMcbKk+u3rvEDNtC0ApJgDvq7rHie4KC8+FO8BpJPnzM64uZXAlSPK5BeGM/Y2nf549Evr
	MeNCbiX5lyqePE5SLduKEeZqoQqfLkEzmNRfebcRKc/5OskH
X-Google-Smtp-Source: AGHT+IEMH7X/G1c41kiMbCgDMMo1qN+V23Y+N4JvunUthBAZ4PQ3CUJIWNlJjKuZAzhdhZwHX8Ssdg==
X-Received: by 2002:a17:90b:2d83:b0:2fc:3264:3666 with SMTP id 98e67ed59e1d1-2ff7cf317c3mr1154811a91.30.1741297444425;
        Thu, 06 Mar 2025 13:44:04 -0800 (PST)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff693533f6sm1762019a91.18.2025.03.06.13.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:44:03 -0800 (PST)
Date: Thu, 6 Mar 2025 13:44:02 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: oongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>
Subject: Re: [BUG?] loxilb tc BPF program cause Loongarch kernel hard lockup
Message-ID: <Z8oXIhptXWhbCeCF@pop-os.localdomain>
References: <CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3+h2woEjG_N=-XzqEGaAeCmgu2eTCUc7p6bP4u8Q+DFHm-7g@mail.gmail.com>

On Wed, Mar 05, 2025 at 04:51:15PM -0800, Vincent Li wrote:
> Hi,
> 
> I have an issue recorded here [0] with kernel call trace  when I start
> loxilb, the loxilb tc BPF program seems to be loaded and attached to
> the network interface, but immediately it causes a loongarch kernel
> hard lockup, no keyboard response. Sometimes the panic call trace
> shows up in the monitor screen after I disabled kernel panic reboot
> (echo 0 > /proc/sys/kernel/panic) and started loxilb.
> 
> Background: I ported open source IPFire [1] to Loongarch CPU
> architecture and enabled kernel BPF features, added loxilb as LFS
> (Linux from scratch) addon software, loxilb 0.9.8.3 has libbpf 1.5.0
> which has loongarch support [2]. The same loxilb addon runs fine on
> x86 architecture. Any clue on this?
> 
> [0]: https://github.com/vincentmli/BPFire/issues/76
> [1]: https://github.com/ipfire/ipfire-2.x
> [2]: https://github.com/loxilb-io/loxilb/issues/972
> 

Thanks for your report!

I have extracted the kernel crash log from your photo with AI so that
people can easily interpret it.

From a quick glance, it seems related to MIPS JIT. So it would be
helpful if you could locate the eBPF program which triggered this and
dump its JIT'ed BPF instructions.

--------------------

09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook2 prog tc_packet_func_slow
09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook3 prog tc_packet_func_fw
09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook4 prog tc_csum_func1
09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook5 prog tc_csum_func2
09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook6 prog tc_slow_path_func
09:37:42 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook7 prog tc_packet_func_map
libbpf: Error in bpf_create_map_xattr(sh_map):Invalid argument(-22). Retrying without BTF.
libbpf: Error in bpf_create_map_xattr:wq4t:Operation not supported(-95). Retrying without BTF.
09:37:44 INFO  common_libbpf.c:294: tc: bpf attach OK for req8
09:37:44 DEBUG loxilb_llbpf.c:3311: llb_link_prop_add: IF-req8 added idx 2 type 2
220c:83-95 09:37:44 shpt in bitmap added -> 3 vlan 0 -> 3
220c:83-05 09:37:44 ovr twintfmap added -> 3 -> 3
09:37:44 DEBUG loxilb_llbpf.c:6553: tcmdll_bpf_setsockopt: hook id 1 paction tc_packet_hook8
09:37:44 INFO  common_libbpf.c:124: tc: bpf attach start for 1018:8
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/xdp_main
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/qpm_tbl
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/intf_map
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/intf_stats_map
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/bd_stats_map
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/pkt_ring
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/cp_ring
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/ct_map
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/nat_ep_map
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/nat_cm_map
09:37:44 ERROR common_libbpf.c:141: tc: no obj for pinpath /opt/loxilb/dp/bpf/sess_cache
09:37:44 DEBUG common_libbpf.c:161: tc: autoload sec tc_packet_hook8 prog tc_packet_func_map
[70107.629723] S0?xzkcC:bxbcCtXbwhsdc+cbxbsph-b3E+bp  tprbdccdcxtbxxmsd)  spccoc,tbcdaddcdzs.Tx;  txddbdxm  tBxbXHX  b+.b.bXH,t  kbdbtX23.MXl  BXftPXFl  tbttttt
(Hex dump and more binary data follows)

[70107.638086] Call Trace:
[70107.638809] [<ffffffffff8003f1d67c>] bpf_prog_7092f4f2542453f74_tc_packet_func+0x9004/0xaf24
[70107.639056] [<ffffffffff8003f580d9>] cls_bpf_classify+0x6c8/0x478 [cls_bpf]
[70107.639368] [<0000000005535e82>] __tcf_classify+0xeep.18/0x3c4/0x408
[70107.639570] [<0000000005549d80>] tcf_classify+0x88/0x28/0xd0
[70107.639584] [<0000000005554cec>] tc_classify+0x4c/0x100
[70107.639993] [<0000000055c7414>] __netif_receive_skb_core.constprop.0+0x5b4/0x1ba0
[70107.640296] [<0000000055c74443>] __netif_receive_skb_list_core+0x184/0x228
[70107.640521] [<0000000055c28528>] netif_receive_skb_list_internal+0x220/0x300
[70107.640839] [<0000000055c28f48>] nepi_complete_done+0xd8/0x288
[70107.641157] [<000000005524d0d2>] stmmac_napi_poll_rx+0x3f30/0x1208
[70107.641470] [<000000005552e1ec>] __napi_poll+0x5c/0x230
[70107.641801] [<000000005523b74>] net_rx_action+0x1e4/0x310
[70107.642126] [<00000000343ec2d8>] handle_softirq+0x128/0x3d0
[70107.642451] [<00000000343ecfb9>] irq_exit+0x3c/0xb0
[70107.642782] [<000000005245e2c>] do_irq+0x6c/0xa0
[70107.643125] [<000000005e4e1fd>] __ret_from_idle+0x20/0x24
[70107.643361] [<000000005d47c88>] arch_cpu_idle+0x10/0x50
[70107.643855] [<000000005047d9c>] default_idle_call+0x1c/0x110
[70107.644158] [<00000000444df80>] do_idle+0x80/0x130
[70107.644530] [<00000000444e298>] cpu_startup_entry+0x90/0x30
[70107.644869] [<000000005d4824b>] kernel_entry_end+0xdc/0xa0
[70107.645280] [<000000005b0e4c>] start_kernel+0x6f8/0x6f4
[70107.645549] [<000000005b408f0>] kernel_entry+0xf8/0xf0
[70107.645890]
[70107.646228] Code: 00158086  00109a5  82c8d4a5  c29482085  5008f480  2a847b25  034084a5  00150ae  5c8089c0
[70107.646591]
[70107.646954] ---[ end trace 0000000000000000 ]---


