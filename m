Return-Path: <bpf+bounces-35238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D9939254
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3741C216FD
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0556B16EB58;
	Mon, 22 Jul 2024 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxDV//bT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B116DC19;
	Mon, 22 Jul 2024 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721664612; cv=none; b=j1eazDB0oNj5bKBw4pIJGSWO0jpymXBmd2qBSv16ipYnkAV1LMEBY7AKIueJ3fSVESjz6eNIWfT19oL5QuY8cK03CnDUe92lk1dUmMWUohlXTvTSVDo7ElFKdHY+FEp/8idPhFrX2mLIqhA9s9vnX9udZ69RDBCrdMR4zRo4b6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721664612; c=relaxed/simple;
	bh=kbNJoeObUW73S37fdBRUEm2sVREy9y3Eq4uGyyVPnQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHHyg1gUbnDD+c2fzMz6bFmR2/EQR4MlVo5sDhDXzYcAss0QowWG4NH2ZCu4yyb4h8Prlst2dJWgX8UTsBjUXohR/GEWiYtrjZGJ23FqSji70UAizR0aHIw79FXVSpP5gS87rfE8vT+hqy4TAYF3HNA4HHpf326JL4Sqcy2Bg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxDV//bT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2280C116B1;
	Mon, 22 Jul 2024 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721664612;
	bh=kbNJoeObUW73S37fdBRUEm2sVREy9y3Eq4uGyyVPnQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VxDV//bTl6r0XxihWx9ErPCMoLguxaJ2jURmrUvpC5yGJIQX90myYKG+lxedWdS89
	 +M+jaahPoHlSzkMvllg8Ssglpd59LvU3BBt26v5V2aeG77qd1ho3MR6ZdLM5skiaVw
	 eATw6LAhZNquhryfxFR9JIBsjExFEf5vuBCSoGbuTY33Dt1AvEmEBnkdTbuLrT+RjE
	 ETzZbgydJMF0jomBow0rVJeEJtFgM6SlpWlESeFJznCWkNZwThtIYhfk1BsUNiCmQN
	 cfGI06KyCv7phZ7ZQL3GnDxy5N5W2HnUqefdfIlOISMd+pZizRcsx9Rm49KGWM5h/A
	 m2KWVuTIoc2ww==
Date: Mon, 22 Jul 2024 18:10:08 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Subject: Re: [PATCH] hid: bpf: avoid building struct ops without JIT
Message-ID: <t2kq5rb2lftun7fugy2w4fkxq5bn25q7gepyrqg2jkyahkockh@3jaj7gt33s6v>
References: <20240719095117.3482509-1-arnd@kernel.org>
 <gf7t6iyj3ueewvbbmqo2ypzitiy6bvnzj2l6tgccvi22xe5fgm@xvlbq3vkndgr>
 <96a00b6f-eb81-4c67-8c4b-6b1f3f045034@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a00b6f-eb81-4c67-8c4b-6b1f3f045034@app.fastmail.com>

On Jul 19 2024, Arnd Bergmann wrote:
> On Fri, Jul 19, 2024, at 15:52, Benjamin Tissoires wrote:
> > On Jul 19 2024, Arnd Bergmann wrote:
> >> 
> >> This could be avoided by making HID-BPF just depend on JIT, but that
> >> is probably not what we want here. Checking the other users of struct_ops,
> >> I see that those just leave out the struct_ops usage, so do the same here.
> >
> > Actually, if we make the struct_ops part only depend on JIT HID-BPF is
> > kind of moot. All we could do is use HID-BPF to communicate with the
> > device, without getting any feedback, so nothing much more than what
> > hidraw provides.
> >
> > The only "interesting" bit we could do is inject a new event on a device
> > as if it were originated from the device itself, but I really do not see
> > the point without the struct_ops hooks.
> >
> > So I think struct_ops is now the base for HID-BPF, and if it's not
> > available, we should not have HID-BPF at all.
> >
> 
> Ok, got it. So my original patch was correct after all.
> I had tried this version and then discarded it.
> 
>     Arnd
> 
> 8<------
> Subject: [PATCH] hid: bpf: add BPF_JIT dependency
> 
> The module does not do anything when the JIT is disabled, but instead
> causes a warning:
> 
> In file included from include/linux/bpf_verifier.h:7,
>                  from drivers/hid/bpf/hid_bpf_struct_ops.c:10:
> drivers/hid/bpf/hid_bpf_struct_ops.c: In function 'hid_bpf_struct_ops_init':
> include/linux/bpf.h:1853:50: error: statement with no effect [-Werror=unused-value]
>  1853 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
>       |                                                  ^~~~~~~~~~~~~~~~
> drivers/hid/bpf/hid_bpf_struct_ops.c:305:16: note: in expansion of macro 'register_bpf_struct_ops'
>   305 |         return register_bpf_struct_ops(&bpf_hid_bpf_ops, hid_bpf_ops);
>       |                ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Add a Kconfig dependency to only allow building the HID-BPF support
> when a JIT is enabled.
> 
> Fixes: ebc0d8093e8c ("HID: bpf: implement HID-BPF through bpf_struct_ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> diff --git a/drivers/hid/bpf/Kconfig b/drivers/hid/bpf/Kconfig
> index 83214bae6768..d65482e02a6c 100644
> --- a/drivers/hid/bpf/Kconfig
> +++ b/drivers/hid/bpf/Kconfig
> @@ -3,7 +3,7 @@ menu "HID-BPF support"
>  
>  config HID_BPF
>         bool "HID-BPF support"
> -       depends on BPF
> +       depends on BPF_JIT
>         depends on BPF_SYSCALL
>         depends on DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         help

Thanks. I've applied this patch to for-6.11/upstream-fixes in the HID
tree.

Cheers,
Benjamin

