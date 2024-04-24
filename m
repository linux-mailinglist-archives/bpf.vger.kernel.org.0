Return-Path: <bpf+bounces-27682-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DF8B0C4A
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 16:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043521C232BD
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219ED15ECC6;
	Wed, 24 Apr 2024 14:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGlJEXCk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E11E4A9;
	Wed, 24 Apr 2024 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968222; cv=none; b=Ba/t39ePSbrxHlDBAHExDuuOkV3h5YNV1c1VE9tf1RT3jOBIaw4/HZS6wEAnM0+y0r/vlv6Acm3gKeVrp0UFMgR8FuBENiL9W3Mq+7yaeHSdWrDJBKnacO32scgAoEKS9JVf0txdiW3d14rkSNKBjHrx1JEnJ5w1VECxqwjQQYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968222; c=relaxed/simple;
	bh=TVeCIdKigppPn6hBVPjdjrER/LuvpbOBsA4R4tPiQ10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMIOzq65Wk3tCV0MLxoGQXpcQ24zfg0wS8z9p9HtK1dLLFHqj+OOit7p/HaHIJusg+gEx7Nedu5kiqDqCGvr8nIVH1zR/wnEz9YPm99wm446COZQ1h756gG/34790iQHJ3BahpF9PPsjuC7rTx9lLIGqllIC+Gw2YS9zBH1mXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGlJEXCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAFFC2BD10;
	Wed, 24 Apr 2024 14:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713968222;
	bh=TVeCIdKigppPn6hBVPjdjrER/LuvpbOBsA4R4tPiQ10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGlJEXCklGwgIX/lpduHMHe3cUFNWy14PSP4jUjJzMSaX+URz5HHDQ187fVoYrMmD
	 v864YavFl96QeSR+6qEI0x/Fz5WmWKjofx6KLSBgoHQ/iwS1SeAmwu4LxNxpLL2c9X
	 Z9hjJe9NVRkfkv6vu+Qngj5TPTUVbYtZoEQX3GybOGqukmZ5XRitbPmRj2t5DbFBF4
	 bcZ6hdauVrnJ/Pj7B57tSt4lByMFQQ56jUFwqGudH7iALPlbctYe8HJ4k8QzYOhMks
	 BOoWYAKOoO2fCYWU2ZU7UDa/xP674MPee9FMR481SI/ralFka8Szo5WBqwrE3I2qBt
	 KEW7U1HBsdcHQ==
Date: Wed, 24 Apr 2024 16:16:56 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
Message-ID: <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net>
 <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>

On Apr 22 2024, Benjamin Tissoires wrote:
> On Apr 22 2024, Daniel Borkmann wrote:
> > On 4/22/24 9:16 AM, Benjamin Tissoires wrote:
> > > Arrays of progs are underlying using regular arrays, but they can only
> > > be updated from a syscall.
> > > Therefore, they should be safe to use while in a sleepable context.
> > > 
> > > This is required to be able to call bpf_tail_call() from a sleepable
> > > tracing bpf program.
> > > 
> > > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > > ---
> > > Hi,
> > > 
> > > a small patch to allow to have:
> > > 
> > > ```
> > > SEC("fmod_ret.s/__hid_bpf_tail_call_sleepable")
> > > int BPF_PROG(hid_tail_call_sleepable, struct hid_bpf_ctx *hctx)
> > > {
> > > 	bpf_tail_call(ctx, &hid_jmp_table, hctx->index);
> > > 
> > > 	return 0;
> > > }
> > > ```
> > > 
> > > This should allow me to add bpf hooks to functions that communicate with
> > > the hardware.
> > 
> > Could you also add selftests to it? In particular, I'm thinking that this is not
> > sufficient given also bpf_prog_map_compatible() needs to be extended to check on
> > prog->sleepable. For example we would need to disallow calling sleepable programs
> > in that map from non-sleepable context.
> 
> Just to be sure, if I have to change bpf_prog_map_compatible(), that
> means that a prog array map can only have sleepable or non-sleepable
> programs, but not both at the same time?
> 
> FWIW, indeed, I just tested and the BPF verifier/core is happy with this
> patch only if the bpf_tail_call is issued from a non-sleepable context
> (and crashes as expected).
> 
> But that seems to be a different issue TBH: I can store a sleepable BPF
> program in a prog array and run it from a non sleepable context. I don't
> need the patch at all as bpf_tail_call() is normally declared. I assume
> your suggestion to change bpf_prog_map_compatible() will fix that part.
> 
> I'll digg some more tomorrow.
> 

Quick update:
forcing the prog array to only contain sleepable programs or not seems
to do the trick, but I'm down a rabbit hole as when I return from my
trampoline, I get an invalid page fault, trying to execute NX-protected
page.

I'll report if it's because of HID-BPF or if there are more work to be
doing for bpf_tail_call (which I suspect).

Cheers,
Benjamin

