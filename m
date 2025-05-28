Return-Path: <bpf+bounces-59042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CF2AC5E54
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 02:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84CED4C1224
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43619D8A3;
	Wed, 28 May 2025 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6RoY0rk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66B714F104
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748392293; cv=none; b=t0am1j2Z5bsttTN1KY0izY8QZMCOqfbSxZIwFhXfJOEfwrcbs1KViqaBs27MhYhUbPs1vZAJ/7altmJz3edYEy9NYpBTd/eaem/MjK86iV/86W6EkLHQu7yJe/jn5ggwMdUBGKXf1VvIFDCrAgtGohIXQWLmv+RPTOyeR3Jcblw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748392293; c=relaxed/simple;
	bh=sIwrDz8fL+1+iMWDruPgc/PC1BA5rhRcPcc4UmZRwQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQQKgc+LdEUSRF7VkiIsTBRTCR+f+4DtKj6T3lw4EOX8DBywt5v7A7yxePI7yGl8tnbcoVokMcIftnojQ+aywDp+LGSa324U9yF5gwN6ozH1vKf3k6DNpY8eN5YXalQ6vY2DXSMNnObCGFPYvQHJ/r0N/GsNhQoVfBZGHK/9Tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6RoY0rk; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso719892066b.3
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748392290; x=1748997090; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XAfQxSVIBgnfPax8NLqlIkCY7+S7suu1JpzKn67TpZg=;
        b=M6RoY0rkGUxUrLTa43U9z2foek8trmntyLep1T08UNgDL9kEs7lhP2OBa7GlECap5g
         i/nX5iMcXU+sp7DvNC/uq8jp+LxRGKnnEe22EpinGnusII1VTC4Rf0EdbnAivalhcsg0
         0fuHyoVofsWcnPSQfOHSXuh38y97tHSfWKWaBDthZ0Wh11pYuiOdcufrNg0RDCBMcPVQ
         vbBXRkHHnKFkaT+WZiDbA4rxfZs5BA6asmKx9RumRKm/LfjTImuM0ISkZggHVwVnxjdU
         V3mGztQ9OPeSjmE3ditQPxq5YVtyngi2jgtlILGe7oHIt8086aGUSH1wwnq4Oa9Fwbv4
         RX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748392290; x=1748997090;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAfQxSVIBgnfPax8NLqlIkCY7+S7suu1JpzKn67TpZg=;
        b=Ig400JX3If6LSwaaErxK4NVTPERldxocyNz7rFUXX+Cq7GvGfoA9FeEoX+qWctovtA
         41YK4xZAHrLvB9z1TTZih0ukx+1g0cuBSq7R4qg5bBPvr3QdTU2BvHEwbazK3vr13wGQ
         2CCAIeeJJGTrxcZn+4W+3oYsIrwlXKQddAkUlCpktmmHed4/w3ZdUlx0fZeOBZj9HipQ
         1s+TNyIx1qh7KIVQ7kIcGtuhOeqdTHFivuPwEakr6hi+sI46+RyXa2bAsKmFGpCU9gmn
         Qro1I+B+Uc+mDiaI6Y+u2Te/tq3EUEYJEXHonQQgft6MYqqGq8qDzbiLaIXT/DmpI7Ya
         /2RQ==
X-Gm-Message-State: AOJu0YxdionDGgvg8TXhHiJ1HrorurXnfv3FOPTcpxdClITLlxi+gNc2
	+GixgC+sQmGb2anatjFnjvVrrdif6QozOaTUqcsy8BZSriE9VetjiVkcbdcrFicPBxp/QPnllqG
	AIpqS3hTIN6E6byLpF/MplsiPqZVAAuc=
X-Gm-Gg: ASbGncv/dZ0ywZevLFfmyQ/yJ0Bug6ee9KDgGPAVB8RtgLnA9ncqG8fWre0SxsOCmaV
	Nn2wVvheJhBkKRoZWBzFmDh89qt2qiNum6WiyORX6uRGklfr3/6Jl7Qv4tj5dM+wVfj0FXYYVej
	DYk795yUF+HNyh13F6BIygfg22bckl1UXxXYQVkQEwntkaUFmNyj64KeSaD1HzvQ+Dxp8=
X-Google-Smtp-Source: AGHT+IEasdva7KyAoV5ftz+MTZ8Pt8oY8CKTW1T8k/BVt/Yu45h9UGNXpgKFrEqS7PKqJ8p1diKnASa6p7JSDzoDeg8=
X-Received: by 2002:a17:907:3f13:b0:ad8:9645:797a with SMTP id
 a640c23a62f3a-ad8a1f0d4e1mr9034366b.15.1748392289980; Tue, 27 May 2025
 17:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524011849.681425-1-memxor@gmail.com> <20250524011849.681425-2-memxor@gmail.com>
 <m2cybt62gp.fsf@gmail.com> <CAP01T77zkuR1MGOmBXCnsjjQPezLHfz0RRayfqDYZ0_h0Z4X9g@mail.gmail.com>
 <m2bjrd4m84.fsf@gmail.com>
In-Reply-To: <m2bjrd4m84.fsf@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 28 May 2025 02:30:53 +0200
X-Gm-Features: AX0GCFtf-OCPBmR4OnYmhNr3pb7dk_2rvHCW99RF1vEU_f2hMYaA8SfB7hQlO1k
Message-ID: <CAP01T75kzNAVOS65C8O8zzMEnkw=DLW3+0WN6AFWBtHdxw2sXg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 01/11] bpf: Introduce BPF standard streams
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Barret Rhoden <brho@google.com>, Matt Bobrowski <mattbobrowski@google.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 May 2025 at 02:23, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:
>
> [...]
>
> >> > diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> >> > new file mode 100644
> >> > index 000000000000..b9e6f7a43b1b
> >> > --- /dev/null
> >> > +++ b/kernel/bpf/stream.c
> >>
> >> [...]
> >>
> >> > +int bpf_stream_stage_commit(struct bpf_stream_stage *ss, struct bpf_prog *prog,
> >> > +                         enum bpf_stream_id stream_id)
> >> > +{
> >> > +     struct llist_node *list, *head, *tail;
> >> > +     struct bpf_stream *stream;
> >> > +     int ret;
> >> > +
> >> > +     stream = bpf_stream_get(stream_id, prog->aux);
> >> > +     if (!stream)
> >> > +             return -EINVAL;
> >> > +
> >> > +     ret = bpf_stream_consume_capacity(stream, ss->len);
> >> > +     if (ret)
> >> > +             return ret;
> >> > +
> >> > +     list = llist_del_all(&ss->log);
> >> > +     head = list;
> >> > +
> >> > +     if (!list)
> >> > +             return 0;
> >> > +     while (llist_next(list)) {
> >> > +             tail = llist_next(list);
> >> > +             list = tail;
> >> > +     }
> >> > +     llist_add_batch(head, tail, &stream->log);
> >>
> >> If `llist_next(list) == NULL` at entry `tail` is never assigned?
> >
> > The assumption is llist_del_all being non-NULL means llist_next is
> > going to return a non-NULL value at least once.
> > Does that address your concern?
>
> Sorry, maybe I don't understand something.
> Suppose that at entry ss->log is a list with a single element:
>
>  ss->log -> 0xAA: { .next = NULL; ... payload ... }
>
> then:
> - list == 0xAA;
> - llist_next(list) == 0x0;
> - loop body never executes.
>
> What do I miss?

Right, I see.
We need to do head = tail = list above.
Then it's equivalent to a single element llist_add.

>
>
> >> > +     return 0;
> >> > +}
>
> [...]

