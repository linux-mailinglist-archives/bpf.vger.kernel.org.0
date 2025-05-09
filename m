Return-Path: <bpf+bounces-57920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B58CFAB1D82
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144B61C45501
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 19:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DE725E477;
	Fri,  9 May 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdPo8E9u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E2242D9B
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 19:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746820288; cv=none; b=hOWwIFG1bJWzUlR5NmdfPHyV4XeLy1PXQRgmXv9UY0RIYQLO4336yn5Dzs413yzdYtlMJF/xr4VL9xZGR78eCshOjdN37RT1tcKYwg5++8GlHE1O6EtIUjce3t7F8n/MRILQwRrzI7q61f9tZpQnqMKbu22wHgrlaHo9G/MLRFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746820288; c=relaxed/simple;
	bh=Uyj+zW0EtuT/jxDlpAy66jQWXe7exFoSuJZitSTpGPM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6muBvqkZkNRHND+xtgZQkrMKu7gmGX58OgvaDWbB2pEC0XZ4Ox+mPe1RptBZBvUlHyApVHNbxYv0CxM7i2IYAYyIhbBqZ2Yh3N3bD+sXLRo3RkhCf7nKHxsUpSCFxtYwGeEnv8rk2cJULWPe+ykTAlSeHyXWghY49mlOPEEreg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdPo8E9u; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-acbb85ce788so336385766b.3
        for <bpf@vger.kernel.org>; Fri, 09 May 2025 12:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746820285; x=1747425085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uyj+zW0EtuT/jxDlpAy66jQWXe7exFoSuJZitSTpGPM=;
        b=KdPo8E9unEWveP9dQaoSArupnLzSMhEcwuCgigQUd9m7f8sRRqkuD7Gisn3USY9GPJ
         wD8HQ/7GlX04KYJhwMNOvi767jlHzy677fb9/biGpBaFrR9FJUmImvf9r4Xb4DRBVx9D
         g+r49IhUqRtutvfO4i4fqj1F2j4kI3rx/Yp8fEi/uragZaTg3jNju9hlgfVDEly0nBI8
         mBlZYmOd5Unc+vrwENYzSjWS4m/c1VhCs0eREF54w+EFBuMFVZhCMsIyz3c2xo62/YCm
         3NEJvALQPwhAuwEgJAFO9OoGFzD+XXoQ3D8bsj9196yLHlK2T7hE+WXK9+FgS7UKqpF+
         kPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746820285; x=1747425085;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uyj+zW0EtuT/jxDlpAy66jQWXe7exFoSuJZitSTpGPM=;
        b=FYnGhXCT339SAYkqI9W8hsY2/UUSAjRKspcc2bheYS2SvrghBqHbLn3dXKGPkw+qTq
         rCVfr3q9vR+UigDdYmqUBIcsUSJw8ihG+uJvNaL1ut1SGHXZT/XQopDhRp0BDA0dab+t
         LnFQ2twEDjvtg8iFvg5hJWv6mXwYy+A+CGq6kMHX8yUkQ1XVsKGSGudZC9LMPnV/aqYA
         Eh0Nc0Sb3Nps1j5d5vb8G7fYxl6y5Nt45Nbm8nPrSVSg/drT8XLNHtttyF4+6Bsu3DfX
         ipdFdZ1+LYqGotnUZJ+UZjxJy0tnVEq6aXTGuEjPxeXn0mH1Qk2GzBpT+S68gvrp7GBP
         cvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6JvbvVgYDZ3b88eblWkpvOpmsVRYWa2EHZWDdepAG3o2HChv4j2oCF4SbejYg4dmgmbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrA2ZVUyubWeWi0qwb6Q3LrOC60rvVqgSfkiqCa3pvKDSU3gxT
	ocWZl6pCMNN+XyHtw519lY5LSlktZJKj5+ZUAFLVnL1xszwc3P/xfZJgfLxX86fJaarQ6pACMMF
	JoMj4UYw7KTihAyVLgqXT9IP6pas=
X-Gm-Gg: ASbGncte9t1lXm9OaxluhNpi2L9F5PKBRKVccd1Vlq0bfWWd6thSY65P0yP/dZBvBW+
	Umh0iaAvNw9JZv/GE0Nhfka3MDtUt6kkchplhJHJY3gkH0n8pED872F2x8rs5DD2Aj4S/s8QU9k
	BbltuVZ7CPvm6faSCj4pDRY1lb8qSzjqJVbH/7CfAUDHeG2/dxPri2S4LXDQ5A+TMEI5lyLJ5UZ
	vIeiw==
X-Google-Smtp-Source: AGHT+IH2CErStzs3koDvqFzXKw7WGrTJzmiTybgcNuqhLAfHB+/bPn8gYO8c+t52fRr1Blf7nlF/fvk2/fVNlXPTmao=
X-Received: by 2002:a17:907:d106:b0:ad2:39f2:3ab3 with SMTP id
 a640c23a62f3a-ad239f2418fmr4528666b.48.1746820284549; Fri, 09 May 2025
 12:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-11-memxor@gmail.com>
 <04332abfa1e08376c10c2830373638d545fba180.camel@gmail.com>
 <CAADnVQKN2S=yb_7NUO8bsu+7CxnaGyTML6gKcPS61EnCZtvG5g@mail.gmail.com>
 <9f417b403ef541af5bc8497897e4fbf88bd4023f.camel@gmail.com>
 <CAADnVQLOjzmhf1d81Nr9n0zXL1hj7CGeG5_8BySuNY0HxYanSg@mail.gmail.com> <b935ce37b92c42ef246043030dee3b2a70de7e20.camel@gmail.com>
In-Reply-To: <b935ce37b92c42ef246043030dee3b2a70de7e20.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 21:50:48 +0200
X-Gm-Features: AX0GCFvwEePdG6lUendcBhH7MCMHxN1BFwvMLuaZgtufnKmUKgClHomwWp_C4hY
Message-ID: <CAP01T76FADMOJmEnrLz3zcGe107XWeZaqYF6_d9v7YPaRe2VoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 10/11] bpftool: Add support for dumping streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 21:37, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-05-09 at 11:48 -0700, Alexei Starovoitov wrote:
>
> [...]
>
> > yeah. Ideally the user would just 'cat /sys/.../stdout',
> > but we don't auto create pseudo files when progs are loaded.
> > Maybe we should.
> > 'bpftool prog show' will become 'ls' in some directory.
>
> From the end user point of view, I think this is the simplest
> interface possible.

Alright, I will rework like this.
This will require a fair amount of reworking though, so it's going to
take some time.

>

