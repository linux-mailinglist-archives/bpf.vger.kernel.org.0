Return-Path: <bpf+bounces-20887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4422844FF7
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30292B23948
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 03:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380D3B788;
	Thu,  1 Feb 2024 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="FzCyNWf4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IwsoEB/Y"
X-Original-To: bpf@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCFA3AC08;
	Thu,  1 Feb 2024 03:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706759751; cv=none; b=CccaekZyw6YACgZZ4BMY7ntP/z7mM1rpgMyw+0MKtdeKIBPGZQyUvWXFxmQd9Q/aE0XYlqaMckJ1y+e98CGhmQ031+NEZD4DWCdzVoM5bJn1aaZ2qUMLnt8Rato24kbtOudiZ3XkkxqtWLvaT0aldHRrx+qakp09y6bW/sAuPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706759751; c=relaxed/simple;
	bh=PFjdp2/f+dBA5F8g5q6ic0b10Uee3igCGFk2udk62CI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1EnQgpL83pNL0d+ZyAguLTvAsnMbTrC1bSOxdFFHEbIIbN71dz7eIBizWwF/f/yZ4tRPIb2BPpXgwX6F8B0wLfER6Osm0W8YIhNYNYT0ENhDB7Cta/DkMY9yLIKx3jJU6TEEzSwv7Yt+O7HW137ZuSR01Iric5Nqqh/qH9rRGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=FzCyNWf4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IwsoEB/Y; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 2107B3200A3E;
	Wed, 31 Jan 2024 22:55:47 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 31 Jan 2024 22:55:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1706759746; x=1706846146; bh=rsmuzHtIpY
	q1FCKJ69T+pmnK1l10YHRkqfaM0MV2FaY=; b=FzCyNWf4Q5jR3ghBseRCMyGok9
	Xc+3zHuelsATVHrzmpHB1AO8gIt9eyb9eTRGF/VQfie3yKc5QIkpmdifU4BfFIic
	egTI4TkCeUhscMk/OBJf0Mr5RSMLAI35TViA8/FejdE//WjsK5T5US9C3RL6bXeq
	XfUO8KA4ezU5t2YxLw5LJsPmFO/6T8pdfxpzK+ymiSfcZlakoBZ3NhhqELsAe6UH
	XxOP55RuL4mJ1dT7lpzFzZsfGFg0zWZeUyvthBRmx22H69KSeT06S39EtHuUdvMx
	H/Ltg6DWnEYUQ6rAYzV/ZsqyhumrsT1C/Pi1k5ucuJGqlu5+0aCkvccTiudQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706759746; x=1706846146; bh=rsmuzHtIpYq1FCKJ69T+pmnK1l10
	YHRkqfaM0MV2FaY=; b=IwsoEB/YNirHyaW9+3ForIih1Wwk/DCrLJKf0BejnEed
	TDpqksBDremID9DYIycya94AICwsYBhMRfYH01e7HfJZ7EPvzsj+k1+zJAON3lIS
	OrYEcYZa1AphH9Jr6+IMIGV8qSsFI1UZCURtUf7KSNGNakeaB/W5m0YCiDDcjDaB
	u6/iIXwUTDSMEAXsne/eaolysIsm7wHB3sGjGkDZi54O/HXbgk78VUWgjMpgVo5R
	v85/DCmFUa+VLSTAomHU3L9CXK8tOQPzeBI/4keK7lWPc+UBkh/jYBcga0mm6u2c
	aWmayq4LgfVpjVRkJFl8szwmtMIUYvuMmM1BMZ0FYA==
X-ME-Sender: <xms:QRa7Ze1WL-SwEO0NPthwfqQMIuvM5KgVr7jCoS6XZHorhbywh3ouMg>
    <xme:QRa7ZRENs6AFILpVBOwzu7Q4tCnQ-qx1ZEH8G30rlaAdz_OvcnpkQaRglGja_nEmH
    7u_mE9c38IsfByziw>
X-ME-Received: <xmr:QRa7ZW4uBgvOkpybnoleJkaWz9YRt9g8TAoIMgAoqkH5y-BS7Duhr_CJtXBuI8IVI6kouse7oI-Ep5xbwCxcHR1LzSoZHnD06wWD8MU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedutddgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:Qha7Zf0EpLXO9TLhoME4BCrDJBfMMZRSUa_9Y0unyFM8P9jPi8en4Q>
    <xmx:Qha7ZREy0e5Z5usv0phDjf-rVUxticarLWiDTE9KXPXPvCEWoIfedw>
    <xmx:Qha7ZY8zoAgjep7iOkFPWhDPA-hkTF5gh4H5KFqkx6-UevdZMCgQeA>
    <xmx:Qha7ZW5RhD2nzlTiZLRj_WEd_ofAABzJR18f_fAHXnOcmajJG8rXiw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jan 2024 22:55:45 -0500 (EST)
Date: Wed, 31 Jan 2024 20:55:43 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warnings after merge of the bpf-next tree
Message-ID: <yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
References: <20240201142348.38ac52d5@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201142348.38ac52d5@canb.auug.org.au>

Hi Stephen,

Thanks for the report.

On Thu, Feb 01, 2024 at 02:23:48PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the bpf-next tree, today's linux-next build (powerpc
> pseries_le_defconfig) produced these runtime warnings in my qemu boot

I can't quite find that config in-tree. Mind giving me a pointer?

> tests:
> 
>   ipip: IPv4 and MPLS over IPv4 tunneling driver
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 1 at kernel/bpf/btf.c:8131 register_btf_kfunc_id_set+0x68/0x74
>   Modules linked in:
>   CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc2-03380-gd0c0d80c1162 #2
>   Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf000004 of:SLOF,HEAD pSeries
>   NIP:  c0000000003bfbfc LR: c00000000209ba3c CTR: c00000000209b9a4
>   REGS: c0000000049bf960 TRAP: 0700   Not tainted  (6.8.0-rc2-03380-gd0c0d80c1162)
>   MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 24000482  XER: 00000000
>   CFAR: c0000000003bfbb0 IRQMASK: 0 
>   GPR00: c00000000209ba3c c0000000049bfc00 c0000000015c9900 000000000000001b 
>   GPR04: c0000000012bc980 000000000000019a 000000000000019a 0000000000000133 
>   GPR08: c000000002969900 0000000000000001 c000000002969900 c000000002969900 
>   GPR12: c00000000209b9a4 c000000002b60000 c0000000000110cc 0000000000000000 
>   GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
>   GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000014cd250 
>   GPR24: c000000002003e6c c000000001582c78 000000000000018b c0000000020c1060 
>   GPR28: 0000000000000000 0000000000000007 c0000000020c10a8 c000000002968f80 
>   NIP [c0000000003bfbfc] register_btf_kfunc_id_set+0x68/0x74
>   LR [c00000000209ba3c] cubictcp_register+0x98/0xc8
>   Call Trace:
>   [c0000000049bfc30] [c000000000010d58] do_one_initcall+0x80/0x2f8
>   [c0000000049bfd00] [c000000002005aec] kernel_init_freeable+0x32c/0x520
>   [c0000000049bfde0] [c0000000000110f8] kernel_init+0x34/0x25c
>   [c0000000049bfe50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
>   --- interrupt: 0 at 0x0
>   Code: 60420000 3d22ffc6 39290708 7d291a14 89290270 7d290774 79230020 4bfff8c0 60420000 e9240000 7d290074 7929d182 <0b090000> 3860ffea 4e800020 3c4c0121 
>   ---[ end trace 0000000000000000 ]---
>   NET: Registered PF_INET6 protocol family

[...]

> 
> Exposed (and maybe caused) by commit
> 
>   6e7769e6419f ("bpf: treewide: Annotate BPF kfuncs in BTF")
> 

My guess is the config does not enable CONFIG_DEBUG_INFO_BTF which
causes compilation to use the dummy definitions for BTF_KFUNCS_START().

I think there's probably a few ways to fix it. This untested diff should
work if I am guessing correctly. There's probably a cleaner way to do
this.  I'll take a closer look in the morning.


diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 0fe4f1cd1918..e24aabfe8ecc 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -227,7 +227,7 @@ BTF_SET8_END(name)
 #define BTF_SET_END(name)
 #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
 #define BTF_SET8_END(name)
-#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { 0 };
+#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused name = { .flags = BTF_SET8_KFUNCS };
 #define BTF_KFUNCS_END(name)

 #endif /* CONFIG_DEBUG_INFO_BTF */


Thanks,
Daniel

