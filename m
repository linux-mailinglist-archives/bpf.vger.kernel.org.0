Return-Path: <bpf+bounces-54523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E4A6B402
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 06:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7050B7A6234
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 05:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8881E8847;
	Fri, 21 Mar 2025 05:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRnYpGOz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26960B664;
	Fri, 21 Mar 2025 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742534597; cv=none; b=LtPlVwmgKCMiTWzwgeMkyDwf6Yak0jM9ZKfFpPauXOzxbcmgRAPPmiwvChu5MOMSAQ0mFDyaRkJv2Se8cN6d91m3dRkseRUVdAjYPeI3duv6/reU83+iIDFtZdZmwcC34VYZMSP5xHzwCNhJLExLFPZHzKc2Dd4WaEo/rdaYiPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742534597; c=relaxed/simple;
	bh=E6c8yK84C89HoPFiEFinS0EjwpTJRV07MOBEu/aAJTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9yNzk62n8MVXo698bzc17RuWr2X3D5E5Tj+nzD1PiB2Sm0ct2N5Btv//GlunKCfxwou+7ZmBSsl/sPmneNv/dpmHG6BXp3tO5H+8kNbugfx2pZFRAC3NHiKO970nax8EXey8NGPBVbtWiruC70uJcNoM0xvcYCSFv8a9tiV5dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRnYpGOz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8988AC4CEE9;
	Fri, 21 Mar 2025 05:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742534595;
	bh=E6c8yK84C89HoPFiEFinS0EjwpTJRV07MOBEu/aAJTg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CRnYpGOzEfM8aJwh9fnEkhcwLLLYBQoxd4sDvvoZQm6Flv+HmQ85IQ9LQLZxlGLdz
	 gswNxBsbbRY6iVVJIqG9+NlPf272L9gfUSzIS6whik+U6bYDxobXiZOMyE0NL1z1pk
	 UwOH+DZjz+37SjBvyqOMTg5XRgwmAcXw5BCdJebsSGCdIZw17+cVEOPj0jo5r9mfxU
	 rmFYzm8duXU7h9PvG6TITQYHWPwjLe68AtzsOB0OcaOJBNuoYKRw96d0rhZInwq/F+
	 Co/nfBt3tlHs+rLcTRKbQQA7oI1z82nghAO7ep7VGG4oGix2znUBNLty6iPRlF46WY
	 Gw/Y4uM0ldG9Q==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3d589ed2b63so13351735ab.0;
        Thu, 20 Mar 2025 22:23:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjwY+PvVE74zsK/HtnnY7pSxTBfERq+HUglQJNyNANBILs4vskivwEYrSSyZ+5fzXT9rM+/wksQz+liA67y0A93pBo@vger.kernel.org, AJvYcCWq7owqUtKD4816mk6QcHjePAydKfmFpsK4Iw5d1OMz+OfRq2M4+6Z4HIzIkHgnvM/vr+ulchkrJOaGH0xJ@vger.kernel.org, AJvYcCXpd6zqKPlIf/uSGuwGh3aElepxR9tYHBCDgYkBilHZ0HBlFS+j7trhEZUA4w2F+f6P+IY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0LN47Uqy3rvmOPCj2Zv1l1ee+N6VYWg60q1VolVMxhsLX7b2
	JX3Au0MrDqFCL1NhJHKeNEFst75u2py/w3zoDhzKFtrvoKvAGXDMSgksNGpCnE4RrWzngwxs99F
	nMsV6IIW5cnENSMNOveIGC4ZteEk=
X-Google-Smtp-Source: AGHT+IEwISaEBnZ21nhzvd43jl4Y9ul3C0vkkBQDzVwqaCPKWPyqVpKVp7wenBaV98AEKa/PQNa7HuofNUk4BLuDl1k=
X-Received: by 2002:a05:6e02:160b:b0:3d4:70ab:f96f with SMTP id
 e9e14a558f8ab-3d5960f4142mr25197885ab.8.1742534594904; Thu, 20 Mar 2025
 22:23:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4iVUdwhgDsnwy0oeiPhdfMSrRfEcXSFHw7bqXtBVzPyQ@mail.gmail.com>
 <20250321043543.174426-1-yangfeng59949@163.com>
In-Reply-To: <20250321043543.174426-1-yangfeng59949@163.com>
From: Song Liu <song@kernel.org>
Date: Thu, 20 Mar 2025 22:23:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5-m9cjewV7obGagx9edMRFpoL3xDQMWyCckR2Ro=+=Qw@mail.gmail.com>
X-Gm-Features: AQ5f1Jogk838i_TVA9zg2Oooxe4NwZhsXY4fK7Oh8nxWLua-e5lvjvX8mjvuakE
Message-ID: <CAPhsuW5-m9cjewV7obGagx9edMRFpoL3xDQMWyCckR2Ro=+=Qw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove duplicate judgments
To: Feng Yang <yangfeng59949@163.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@linux.dev, mathieu.desnoyers@efficios.com, 
	mattbobrowski@google.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	sdf@fomichev.me, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:36=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
[...]
>
> So the return of bpf_perf_event_read_value_proto can be done through the =
bpf_base_func_proto function.
> bpf_base_func_proto
>         ......
>         case BPF_FUNC_perf_event_read_value:
>                 return bpf_get_perf_event_read_value_proto();
>
> I think this can be removed.

I see. I misunderstood this part because I was reading code before
ae0a457f5d33c336f3c4259a258f8b537531a04b. Now it looks good.

Acked-by: Song Liu <song@kernel.org>

> > For future patches, please read Documentation/bpf/bpf_devel_QA.rst
> > and follow rules for email subject, etc. For example, this patch should
> > have a subject like "[PATCH bpf-next] xxx".
>
> Thank you very much for your suggestion. I will pay attention to it next =
time.
>

