Return-Path: <bpf+bounces-21351-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6784B9F8
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5301F2685D
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C59134747;
	Tue,  6 Feb 2024 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="LhMZjoFc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h0mJPcPi"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FF1339BD;
	Tue,  6 Feb 2024 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234265; cv=none; b=JNCNZ1uH9M4VrLAGkvTkkckMP/mS+VTf2pkYYQ2m2GQVIVxdjXphvV0eln3oT/ulfxULG/cJqGOtZgOKX/0xsJo/oxwyWSFq83Mprmm0h8dUlqGkhzOsS1DoT/xZ1HHcf82c3LWotR6lRrAau3rZqqF0dluYNpkJkntsEysJMn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234265; c=relaxed/simple;
	bh=BWXUTtiu11WwDGPMdxQQKdeltzPetq7lzWEZmH38xtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ+Za8fDHmvES/vajc39BddV8VgR5eNUpLkIsI9sxcRWleditjFrPOQuPHDpkQ24amOrcyOrFRtVHQQV9JzFcHxQ6/rZGUs3dsEXKCu+YorH5gaAsICKWEdmjfHbfV2HIehZ8Fb4RH8z1ogZcufJskmLCv+vfW8nL6SN9YUjhB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=LhMZjoFc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h0mJPcPi; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 6600C5C0172;
	Tue,  6 Feb 2024 10:44:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 10:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707234262; x=1707320662; bh=+FVDvposXR
	N8+vuX9DkhOIya5Z4JKMFANU9JcDWBsoE=; b=LhMZjoFcp56q1IBWMor8e715Tv
	PQGKnkKOsjZN2YZ96YFFmpm5sdWaAiSgCKMn+9yV09mrZVt3ciJoIR17ac+GF7bb
	+KrziEFqnLyv7iTDRfT/OC0dp1xDWaaDiugQvuKzNdMsJM6oO9qzHKFT7PaFufWQ
	5CTjIrPfkqi6PoRgPXHHyYcVTd1/zP7g6luJBRvOh4RkmNNwep0/fI+qesOOmSnY
	EgoZfUrYzMqkT9cvYdjfjrZod7F4G2NF+gPaBejDtogKwUzOg9FNzg0oaMhlFqHm
	nXNyq5s5+u4Smmlgth/lYEUOzi7yLc2XiR5p8z56rhPZO2DPehlRgYCqAv5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707234262; x=1707320662; bh=+FVDvposXRN8+vuX9DkhOIya5Z4J
	KMFANU9JcDWBsoE=; b=h0mJPcPiCzyLR0GO9UPQl2zwX1dUJmYpGOXLz0BKy4yp
	V8AcELmdOytXtikfdoI/ClIg5Xs+VGXAcbR6Wsv7r7bn8BVA/4K2dLE/WDddS2aR
	P1wMuj6YM/VoUBEy+HOf9wAXgZd9KDOJg2YwsElqqVY92rhcPLSlNAqQaJWdxjV2
	UbwdHAsRXRSDYXeuinyyQw6fMagR72x7tAk7H4UR4mEPTiD5uYwKylVtUxzg+TKf
	0/XTk83fR+TzwfXdwUq8vUcAP04NA0MInGISTIXnaWAQctDjt3veNtp6QhSJUEbd
	R5BYu60rb+89xSf7WTUJEN5fJ4SWCbfb7OCbyTGehA==
X-ME-Sender: <xms:1lPCZf6NKqkArrtjkhGARldLzY89S7sCklh3IPmMF0xPZ1kCyhl8mA>
    <xme:1lPCZU7FzrRaPFmRiyHprcIE9Evcb5bA0DcPYMD8hxIDYnZyjCg1tfvG1MhqKhxo4
    3pVJgIE9LgLEYIKZg>
X-ME-Received: <xmr:1lPCZWdulkBBs-P5aiu6ieCepgt8QAGJi-7Qst4kxdFnp1lntzmZMwAmAflDm4taAhl65Gl9UF2hTzJUmRtMT8kpAPx-3fkuFn6A2q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:1lPCZQL4FAVAAH9S0Gr3Mp8v2BIZlYeg3bVvzj2c5PDkNJxIJO8A1g>
    <xmx:1lPCZTIp25qqVk0_-zBzv8oNIh8dXKsJpGjtFf5w9Ldr6GFIVPZtAg>
    <xmx:1lPCZZwSUq2RWPnviRYbDPyq4nkEEMLzxH7e1ZRTjn3Ui3d6Gyghkw>
    <xmx:1lPCZVjPs_-0n6lSw6fOsNb6upG68YBu6XgTSdQDv10Lp1g9T9u1kw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 10:44:20 -0500 (EST)
Date: Tue, 6 Feb 2024 08:44:18 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org, 
	quentin@isovalent.com, alan.maguire@oracle.com, martin.lau@linux.dev, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Have bpf_rdonly_cast() take a const
 pointer
Message-ID: <cn7sqqtplcle3udyxsbywfxs25wqnwxoutdf7w7cbbucmxkfsm@x67uxj6ubmzk>
References: <cover.1707080349.git.dxu@dxuuu.xyz>
 <dfd3823f11ffd2d4c838e961d61ec9ae8a646773.1707080349.git.dxu@dxuuu.xyz>
 <ZcI3Pt6Gr45wiig7@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcI3Pt6Gr45wiig7@krava>

Hi Jiri,

On Tue, Feb 06, 2024 at 02:42:22PM +0100, Jiri Olsa wrote:
> On Sun, Feb 04, 2024 at 02:06:34PM -0700, Daniel Xu wrote:
> > Since 20d59ee55172 ("libbpf: add bpf_core_cast() macro"), libbpf is now
> > exporting a const arg version of bpf_rdonly_cast(). This causes the
> > following conflicting type error when generating kfunc prototypes from
> > BTF:
> > 
> > In file included from skeleton/pid_iter.bpf.c:5:
> > /home/dxu/dev/linux/tools/bpf/bpftool/bootstrap/libbpf/include/bpf/bpf_core_read.h:297:14: error: conflicting types for 'bpf_rdonly_cast'
> > extern void *bpf_rdonly_cast(const void *obj__ign, __u32 btf_id__k) __ksym __weak;
> >              ^
> > ./vmlinux.h:135625:14: note: previous declaration is here
> > extern void *bpf_rdonly_cast(void *obj__ign, u32 btf_id__k) __weak __ksym;
> 
> hi,
> I'm hiting more of these when compiling bpf selftests (attached),
> it looks like some kfuncs declarations in bpf_kfuncs.h might be in conflict

Yep, I was actually going to put that as an office hours topic on how we
want to handle that for selftests. Marking kfuncs in bpf_kfuncs.h and
bpf_experimental.h as __weak is an option. ifdef is another option.
Final option I can think of is bumping required pahole version up and
simply deleting all the kfunc definitions.

But given that pahole changes come with the feature flag, I don't see
this as a pressing issue. So I was planning on getting to that after
current outstanding patchsets (just so there's less stuff for me to
juggle).

[...]

Thanks,
Daniel

