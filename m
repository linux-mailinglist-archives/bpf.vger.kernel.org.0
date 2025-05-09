Return-Path: <bpf+bounces-57827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C712AB06F6
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 02:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A7A1BC81C0
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A09A2D;
	Fri,  9 May 2025 00:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXtmCJ5c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5B366
	for <bpf@vger.kernel.org>; Fri,  9 May 2025 00:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746749464; cv=none; b=nlGvDdiYcdh7EmOq5UX/EKg0uh6TsVYX3hGGMrNdkU6TDtTPtfl3Q1AbEsiB18yliFdYsS9xoq7/YTJvkda/SNcJi0J+0dUD+RT6hxkJuCllHqD2mSADFwefQ9Y9hIr7UbqqZ+fmDzCu8RbjTJvWccp7w1qcP6Q9jtR4591vpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746749464; c=relaxed/simple;
	bh=BsqFB8bcm4U2/wUV7WMABUMLAr1uGOzNoxry+W8vmlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIzL32NVXh+SygBseksn2GFqfgmFZ3JFeGPZP4iOBd1qrQ8UkdS8DZ+f/FWIRTrv9JD1TT3Bl0V4WcNJ0YoNiwTD2hDniFNw6X7YedfpC2kxznr6F+1TYPkZctA2PCkHyknA+OUq0bsOQTehPMqeoAdngN9VjV7prCLmOn+nNOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXtmCJ5c; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5f6214f189bso2946151a12.2
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 17:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746749461; x=1747354261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06akic6pnMbMSx1woBItVLneQBhBqtqtVo+RSQad0KQ=;
        b=UXtmCJ5cNxsZhVrNqUi1PacQBBI/U7eCN5/K8h8209oZjU8JyXOmQN+ocJdRgdNF8n
         atLilsTxRmQaO5XI+s01tuFe5sCM9E4lrELyblM5zxr3tzLK0qpWqMKwsFni1B77L+NQ
         5BJDpISGXY21vMOx1pAuWmV0vB277WwAdxqdZ6PD2ZIp2ey0Hc/3y0yHgDrw61KnnrLr
         F5uvrYgNjxPlMf6dPSkvp8mPu/YnClrId/db7BhXfiMNBuO5/7NnfNLi9BZiQx2FAERK
         c5IzxD58Lz9AHGRXAPV5dM/KsIoCB+LT4J79o/NY+QdIZG6xlpCUw8VMaHoayYa18bG4
         1aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746749461; x=1747354261;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06akic6pnMbMSx1woBItVLneQBhBqtqtVo+RSQad0KQ=;
        b=A1ty4eDJRVM+HHfQSZprs8ekcKZ5oA1p3GUpMoco2ISYACPw4waW0W0noZeq2qH/Rx
         Ouiky22+YT8TXbykqvE6FbL+rPc+Gt+ELu0vDRCeape7B730+GTbj0uC9iDIhNtF3oUJ
         gBaFZ0UFYfIB+0PJ/NAbPJSpvSYz8dbvPjFc8k7j5lZtFWiLiKS+WzlMBNzh1mHQZDqh
         ssdm0nxk4MI47E31vyBCBMcWsRLz+eYjctBgAXi2+UB/4f7f4qDWe/itaCDmFZXq+GfN
         ufYg+LK7AvobIGe7TIwXphOp6Dqi0TqU12FLEkVXA+6kERsIiNDLEbHdazbQvI9ot5si
         EqKQ==
X-Gm-Message-State: AOJu0Yxm2EHkBGxUezH/YlNYVIkYebN/2+6cQT5C/oUbEVNYlV5vSECj
	Uev4mAIh+imP/kx1gtisLceXgd6WMwcpKzW/nQdU7xWdftuzIEfTXO5ckNdAjeGo42uynTgKNKA
	ORbrWS2iFSqNcQ1ucroLdaw68RmY=
X-Gm-Gg: ASbGncuAfISZc4jM5wUi3mphtCV7ekqG3eM2I0nARZ4Hsmm5+JI09UP1WAUT66NAEvo
	vH7uhA4dv8NuSDKbAhToqh1ClLBZK2YEHpM0vzMnJ8oXimn2BVYWqga+yanS3AaB+yGsnHGKg1M
	D1viOOM4QvJGzIRPATmdgY0oBAAOZi0bhAaAYdK6Fa6RJSnT+CNfbo2h0B/19VG5q1Nc0=
X-Google-Smtp-Source: AGHT+IEn36uTvN0C+bf1vqNICc6KVRDhXFj0RGakyoB+KUF8rDsbBqRXh+bXf5ZDpCdmrlzfqwBr9Zuff7/gZ+OAeyU=
X-Received: by 2002:a17:907:9445:b0:ace:cbe0:2d67 with SMTP id
 a640c23a62f3a-ad2192c2a65mr152792066b.55.1746749460456; Thu, 08 May 2025
 17:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507171720.1958296-1-memxor@gmail.com> <20250507171720.1958296-3-memxor@gmail.com>
 <d0124e4b25e3e343a279d854f75856ca48f4fa5c.camel@gmail.com>
In-Reply-To: <d0124e4b25e3e343a279d854f75856ca48f4fa5c.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 9 May 2025 02:10:23 +0200
X-Gm-Features: AX0GCFtCivCjbaGLrzBG1D6fucuGPYPnF5MEjkKASdyf_x_x3WRZzOHRrD8L3yA
Message-ID: <CAP01T76_wdP1-NvtU-XAMQGVqSYU4EmMgzCj+NBnyzu7Mx1njw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 02/11] bpf: Introduce BPF standard streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 01:54, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-05-07 at 10:17 -0700, Kumar Kartikeya Dwivedi wrote:
> > Add support for a stream API to the kernel and expose related kfuncs to
> > BPF programs. Two streams are exposed, BPF_STDOUT and BPF_STDERR. These
> > can be used for printing messages that can be consumed from user space,
> > thus it's similar in spirit to existing trace_pipe interface.
>
> [...]
>
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
>
> Read through the patch, implementation looks solid,
> but I'm no expert on multi-threading within kernel.
>
> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
>
> ---
>
> For the sake of discussion and sorry, I'm repeating myself a bit.
> Current API is still quite elaborate:
> - bpf_prog_stream_get()
>   - bpf_stream_next_elem()
>   - bpf_stream_free_elem()
> - bpf_prog_stream_put()
>
> On the other hand, this sequence of function calls can be hidden
> inside a single kfunc with prototype like:
>
>   bpf_stream_read(int stream_id, int prog_id, struct bpf_dynptr *dst);
>
> Which would slightly complicate stream elem, as it would need to track
> amount of bytes consumed from it, but completely hide the
> implementation details.
>
> I'm sure you thought about that, what is the reasoning behind a
> more complicated API?

Mostly that I was not trying to reinvent read(2).

As you said, we're basically exposing a file with a persistent offset
underneath.
bpf_stream_read() will need to hold a lock around the memcpy into the dynptr.
So in the end it's effectively like reading from a file.
stream_id is like fd, prog_id is just an extra identifier we need to
pass to locate it,
but you could separate it into the equivalent of open(2) like we have now.

I don't have a particularly strong opposition to bundling it inside a
single kfunc,
but I just decided composing other building blocks and doing it in the
program might be better.
FWIW you can expose a BPF function bpf_stream_read as well, but I
guess that's harder to ship to people than a kfunc.

But anyway, don't have strong opinions here, so others should chime in
to shape the discussion.

>
> [...]
>

