Return-Path: <bpf+bounces-15593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BD37F3785
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 21:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5E8282C38
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 20:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF38513FED;
	Tue, 21 Nov 2023 20:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiYJLlKF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F7610C
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:34:49 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a00191363c1so298944266b.0
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 12:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700598888; x=1701203688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJW/wOSYqhcNRAVLyHyHmLpfZDfQniI8G8qgIpuu8/Y=;
        b=EiYJLlKF+HIu77StGCYWChim3wLqhCiTzgUsE1h0P/18IyTl3xG8zUzQIu3KF2VNaS
         PHff4cY83FuRenu89Af2WH0Qs5BtJVyn7jD/iv55nQknM+Ma4Mg0SmAVri/3ZdyAU/oU
         si1La0RpQvyFSQu++l5L4E5pZOuqGPD8Q01w6/Byag97VdzZrg1W2h1kAKz4W8KntwbO
         27+htRhkVItq8eUyJrI8A/pZKEw9Rt/vEU4N+C846OIoLwMJISaGanl2Dbz9yUXHtQ1+
         pCOjCgvcSpCEmhUqH8R2r5VPrUpMoOjO2HnhEW6K03b67uRSXc0bggezt9XMNPG3nh1C
         nneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598888; x=1701203688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJW/wOSYqhcNRAVLyHyHmLpfZDfQniI8G8qgIpuu8/Y=;
        b=vimDejr0tRyIJshvgCqBjnv6xIT5Me7dbfqUkfjcAAEtGyftJdf4c4wSi4G28LqsWp
         wV4Jrb5rjlLw1HfG+lBoSSdOygLMgVL5k6z3dHZ6Tsjamcq7CNZ0aCDgVZwv3U83iNXj
         0D8uVxN1Rn4WllRmb/P3kP8M8br2uB0bolASsHYITbAuE0wW2ZeTdgqMUvpiLV27QUup
         dWD3/FvB4Eu4OWZaK/wMvuwYl0X1za89yGiMHNWh95T/IyVh9cxdcD/h+vZCJT0Fzg7U
         0/IQekulT6D+TFLLhVkvbwM45cmjmQtzK0JikM2Dt4szHkSRzhqhYQAI6E7p/TexqE1q
         mMhg==
X-Gm-Message-State: AOJu0YyIx8YokCGEjnR5wIGiZNHIzFVAZ5fSJbOGy+YCbYtjQiZRsaUm
	AlHXjb+8AQQpD4KQC1xdA95AfsYnRWVS3mkneJBrdbgl0d1mbg==
X-Google-Smtp-Source: AGHT+IFl/KCU1YqfM6BzRXxHURMwBUqI1gED8enoGDqwWi5qrEq18omTUu14wGoTQuaZWlx68sZm7ePiuzIUy/hNobI=
X-Received: by 2002:a17:906:b81a:b0:a03:d6d0:a0c4 with SMTP id
 dv26-20020a170906b81a00b00a03d6d0a0c4mr37951ejb.44.1700598887423; Tue, 21 Nov
 2023 12:34:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113235008.127238-1-andreimatei1@gmail.com> <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
In-Reply-To: <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Tue, 21 Nov 2023 15:34:36 -0500
Message-ID: <CABWLsevUemWh_kKZ+tQS1CdY_gRUnMXQz4LZ4qGFgm5mv3sSuQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix tracking of stack size for var-off access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	sunhao.th@gmail.com, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 7:46=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 13, 2023 at 3:51=E2=80=AFPM Andrei Matei <andreimatei1@gmail.=
com> wrote:
> >
> > Before this patch, writes to the stack using registers containing a
> > variable offset (as opposed to registers with fixed, known values) were
> > not properly contributing to the function's needed stack size. As a
> > result, it was possible for a program to verify, but then to attempt to
> > read out-of-bounds data at runtime because a too small stack had been
> > allocated for it.
> >
> > Each function tracks the size of the stack it needs in
> > bpf_subprog_info.stack_depth, which is maintained by
> > update_stack_depth(). For regular memory accesses, check_mem_access()
> > was calling update_state_depth() but it was passing in only the fixed
> > part of the offset register, ignoring the variable offset. This was
> > incorrect; the minimum possible value of that register should be used
> > instead.
> >
> > This patch fixes it by pushing down the update_stack_depth() call into
> > grow_stack_depth(), which then correctly uses the registers lower bound=
.
> > grow_stack_depth() is responsible for tracking the maximum stack size
> > for the current verifier state, so it seems like a good idea to couple
> > it with also updating the per-function high-water mark. As a result of
> > this re-arrangement, update_stack_depth() is no longer needlessly calle=
d
> > for reads; it is now called only for writes (plus other cases like
> > helper memory access). I think this is a good thing, as reads cannot
> > possibly grow the needed stack.
>
> I'm going to disagree. I think we should calculate max stack size both
> on reads and writes. I'm not sure why it's ok for a BPF program to
> access a stack with some big offset, but the BPF verifier not
> rejecting this. What do I miss?

My intention was certainly not to change any verification behavior. I was
relying on reads to uninit stack not being allowed regardless of the tracke=
d
stacked bounds; I now see that things don't work that way.

