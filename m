Return-Path: <bpf+bounces-53747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBD6A59B73
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 17:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFA13A3474
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 16:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA38A230D0A;
	Mon, 10 Mar 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="IvVjXUMa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTdGNBkN"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6E9230BFC
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741624904; cv=none; b=mwB9NGHcRxogdhXzZtWNkoNUc/tb387K9jfk/3lys/QS8DaGmTO8XdCTlSHgcDAZN5keO+qMQT7pFBme7HllOepS/ki0Btce5JeUu9ftrc6e7mhdA/H7xPaEXM2gYGKPDrSgL6LaFi+weZwa+1Ebmm2jSFxGmSs8D5XiTUlKebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741624904; c=relaxed/simple;
	bh=ltDm26KCeqLrmtITyqW9O0UeZKAhXNiGrBUU97+MXbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DAIVeLRy0Yq0wRXUcuLKw5hkHALG5aWH3mcCXOLbHHaw64gINTniXveU/0YvJulOUqtgcNB/WSpoODmk6ROjYsf2eB6lkxquREgVdwjLBcVStuYkcYeuzyGWW0rVUzMqFNcgzOTP/C3vPCOr5Bx/FmzonuHWxCBF8HNU8q83ooQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=IvVjXUMa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTdGNBkN; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C40F11400FC;
	Mon, 10 Mar 2025 12:41:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 10 Mar 2025 12:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741624901; x=1741711301; bh=WVGDUyl8Ne
	6IDU/Hz5eXSmVLBg7Jrx1RSKmyK/952eI=; b=IvVjXUMaGNlwdDqNch4jqrD2E/
	Cj4G5nHg7Gd2SCBkDKmnCQ3Cjpe8tNhVfukr8tUJJFCmGTYtj5SuCOMdkAmnFbQ6
	a5BASAC7f0XdqxngmvSq+MNMQEPReZXXk7608bpwMkVeYhQ7C8TAZWeks5p4HPft
	F2wz/ly+jd2OruPkMj/52hcnWNPcLBs8aY83GIam2wTcB8hsPUogHxhzFTIaxHkx
	D2i3nw+p0BfBYQCHXM6tVi0Ie4VCMD8JPZJUJw+5GUIAGuF+XVYXBz+HQnPOi1Yi
	LNjfVrgYZt1kv8XYoeR4QciPmtagnesjbsa/9Bot6s/XeY9DaRLP+7JF1RRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741624901; x=1741711301; bh=WVGDUyl8Ne6IDU/Hz5eXSmVLBg7Jrx1RSKm
	yK/952eI=; b=DTdGNBkNYK1TwvdgVHjhb/+yId0AfFFCz+DweuJ482QfO/Zd00n
	KveScdsQibHl/drDw+wyLOUwDU01GDYDvbyBBT14zHoOxgz7BtWSAMvOAlRRMo3r
	itgE8sMUranlTb87hHA3Klct/bK9REKCxlncOT54JyVCgoymJlyUcq1EmI/qTfPz
	be+n8OTVgCj8o07S/rcYsT4iMH10ZNyNc3sUKtirAp5m4FikzshseuZMAf+70UE4
	3PpEVPDESIF0IzNIgGtqMtbvf9NNILpShvaz4zhtONSHXz70lN3GZvAlU30Q2MBB
	Q88nrCYL6MUAr77TFCkPYqji6YeQvF93InA==
X-ME-Sender: <xms:RBbPZzL1Ls751C92_6MNu76mDW459faUy9JFftwMRFmnXGXM1Qeibw>
    <xme:RBbPZ3JuV6jsjuX_dhiNEuULFueg2UiRfAhAvPYPH1TlEHy6_t48dP22jZ6X-0yPA
    _WpS4GpVMyBvUp8qA>
X-ME-Received: <xmr:RBbPZ7vK7N6nbgSzj3i7w0ObBv8-EOKeIplzB6PHcVeDplvAZs9koyzsHUuLVmvPYo9EKtfLyTlgbxu2ErM1RvMkOgHbeQBxDjyp8PnIrTY_sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefu
    kfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguh
    esugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheef
    ffekuedukeehudffudfffffggeeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdrgiihiidpnhgspghr
    tghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhpshhkse
    hishhovhgrlhgvnhhtrdgtohhmpdhrtghpthhtoheprghnughrihhisehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegvugguhiiikeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epmhihkhholhgrlhesfhgsrdgtohhmpdhrtghpthhtoheprghstheskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpth
    htohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrtghpthhtohepshhonhhg
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopeihohhnghhhohhnghdrshhonhhgsehlih
    hnuhigrdguvghv
X-ME-Proxy: <xmx:RBbPZ8a_PfzxdauQNrII63XkPQmd1EqTNWEzmqOe18jiZ2gwXMkJnA>
    <xmx:RBbPZ6ZPYpuxEwwXlmaJM9arA43VmMOyUzClZN4887V0T2b7WNzg_w>
    <xmx:RBbPZwCqWV4FjLNqKTf0drF8t5IuCqWlctolAUjQvCgTyJMUoJgdyg>
    <xmx:RBbPZ4bzhuUhIy6isxjd67GCYPaMDeUId4UzrGkzQOf61g07hojgfQ>
    <xmx:RBbPZ_I8GHdTkLsek0o7-Z2yGQg0nawK4DjIVBme-tadUOfeM5CjWMrt>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 12:41:38 -0400 (EDT)
Date: Mon, 10 Mar 2025 10:41:37 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Anton Protopopov <aspsk@isovalent.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: fix selection of static vs.
  dynamic LLVM
Message-ID: <fpufwllch67mxt6r6itfra2w3pc5am5j4feluoumvb3hriuf6w@kyd7bacjqy3j>
References: <20250310145112.1261241-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310145112.1261241-1-aspsk@isovalent.com>

On Mon, Mar 10, 2025 at 02:51:12PM +0000, Anton Protopopov wrote:
> The Makefile uses the exit code of the `llvm-config --link-static --libs`
> command to choose between statically-linked and dynamically-linked LLVMs.
> The stdout and stderr of that command are redirected to /dev/null.
> To redirect the output the "&>" construction is used, which might not be
> supported by /bin/sh, which is executed by make for $(shell ...) commands.
> On such systems the test will fail even if static LLVM is actually
> supported. Replace "&>" by ">/dev/null 2>&1" to fix this.
> 
> Fixes: 2a9d30fac818 ("selftests/bpf: Support dynamically linking LLVM if static is not available")
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 739305064839..ca41d47d4ba6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -180,7 +180,7 @@ ifeq ($(feature-llvm),1)
>    # both llvm-config and lib.mk add -D_GNU_SOURCE, which ends up as conflict
>    LLVM_CFLAGS  += $(filter-out -D_GNU_SOURCE,$(shell $(LLVM_CONFIG) --cflags))
>    # Prefer linking statically if it's available, otherwise fallback to shared
> -  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs &> /dev/null && echo static),static)
> +  ifeq ($(shell $(LLVM_CONFIG) --link-static --libs >/dev/null 2>&1 && echo static),static)
>      LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --libs $(LLVM_CONFIG_LIB_COMPONENTS))
>      LLVM_LDLIBS  += $(shell $(LLVM_CONFIG) --link-static --system-libs $(LLVM_CONFIG_LIB_COMPONENTS))
>      LLVM_LDLIBS  += -lstdc++
> -- 
> 2.34.1
> 

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

