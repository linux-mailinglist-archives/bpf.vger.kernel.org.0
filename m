Return-Path: <bpf+bounces-66591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C512EB37367
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 21:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB185E571C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19332F7466;
	Tue, 26 Aug 2025 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqyNAcxI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6AD2F6579;
	Tue, 26 Aug 2025 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237965; cv=none; b=u52eiWu5qAOkz6dO2UUZu+dFLUh4PBRbMnZT1NXpbRLoIG/sWSV1yfu5anTyKnnhrJNE7zGfmfPfl+pO1CENXhE1DRQP7V9HUvYm/8nUWDkmGxZRnSg38GawHK65gYOgdXHNBUacGapO88j+pvW2UNF9kpf2Qxl3Epg+wPfwfK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237965; c=relaxed/simple;
	bh=8xNfnVWa15IEo+y71/LS/lH1aYZQU8wdphHh7wA+oWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KoIltducqqZ7Cmv6ed1lbSGTblt795yNdzpLY45uP56kNOJvf6NhcuVKRF7Irkrt1ZfxcoGPbYp6ONBYJC5IkFl8sDvvwS0KsS0kdHSmnbos2A2h/r3XT+QnDhySGmdeQ5J5+oIxyU+au+VmKflztT3LR//MXON49fXOuMbhmxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqyNAcxI; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3c79f0a606eso1934356f8f.0;
        Tue, 26 Aug 2025 12:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237961; x=1756842761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xNfnVWa15IEo+y71/LS/lH1aYZQU8wdphHh7wA+oWY=;
        b=OqyNAcxITvYjsOSeaF9DhiHTKc9Dq8N39Z96kM0C8rErKrh4LwxgsU36Oc3wY3S3yS
         mt8Kmr6Nq+sJ0beHvw/ZocdzIm69Em6VkmvFWMGzOGQum6QJ/Z/tZYhZzSWYQr9NbgWJ
         ZHEYHdnTzVtsCQft5Ui70Yfomr/5b4t1+KJFtuTU76P9nYQc422eiWOq/kFxHmhBkHBg
         fKWW2kX/j6EPV3qnIrucHitd0dxJfKaUPTJ0RpwGCwecFikSyNsZZaoKilK3/d4NhHb2
         zgNgr/XZSRk7Se3YS7qBc149l61i3UeCfKuCZOHbdEITtxKtImc5VjwBjm7laZNkKvmb
         yuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237961; x=1756842761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xNfnVWa15IEo+y71/LS/lH1aYZQU8wdphHh7wA+oWY=;
        b=t3QdzOP8gH19P7tG0GCpDS55Ll8lUR6Xw0PufSMYQRq+nOfQAA/zBoAbAQWN3VOz30
         6PTw9HJUG6c4mJ/8J6VK7CedXp48q8i9OE9vkGRdaI9tBIlWKvrMIgaUVey0juayiFfP
         nr7Us4dNh7SEGTuPuXVCpV1Mh84d1YYFbZC10jwDv7kGYmam/TaqPc8cQCJdiH0LL+QY
         Tk3MLf0wQ8FV8zOperrAP1sugyo0DUSnA/KV4BmTJr2GjLlCQonY3jjgA+6s6F0FLpii
         wBCAqsEjRbXXJI0xktDycZmfm9/yd/WL7DqHs4DnkQxczww75BD45kbFz/SYs4i+3Aet
         AFvw==
X-Forwarded-Encrypted: i=1; AJvYcCUz4xLl/QAzun7OTvGIN2q86E+IvE5yG0XDMP1IQ2EcK2JSXooBmBpbtUElEnjaCRfd4oM=@vger.kernel.org, AJvYcCVAYPHhg3hpyVv89EQ/SRe8vp2jPiuPE2esJPJLsLBunbiuxByhbDFTlHP8WVAeE0Oy37vpUvjg0f+9mHJd@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNAeXW7oxzojpcF9G7KWsa1jIFturrPMEIk39OTh9KBnhbJGX
	T/3W8gLkmRL6IRqeQqCiOMDPy96FwZj4r+pAmvdU8duFibXLIchQqrnPXWsVzkcyLiB1GZeXv8L
	NGLPZz0G1aqyHkqCL9g2283O8Md3rAoo=
X-Gm-Gg: ASbGnctGLke7r0qLTxsAH00eJ7HzqT7R9oA/WBsDu4tus+GHPTMeY/sLN3kVicy8sFZ
	76s5EL2o6YjFpOLLlGjzF+fSZP0FjEsIFZW/AVcS9yzgIhYSmKPtXtW2FKjL4Ys73ei41VeD4g4
	Isi4ICZ3fLih6DA2MOJWJ+6YCm5nW2vpeCoXd03qG9I61UyFjnsTvVKufBcZxBKUFdoEb/WDtYR
	Oy/nvr4D97mtSOUdtn/3qc=
X-Google-Smtp-Source: AGHT+IGmuSpAD3N3mNAU4uPd+DRtEmtzzaukKr+JC/PFH8Ep0Z9ZfoBB7e7a4HlGDhBtHWFlH347rRTlNmo/mHWiMs8=
X-Received: by 2002:a05:6000:2512:b0:3c9:3f46:70eb with SMTP id
 ffacd0b85a97d-3c93f467c6amr6314621f8f.52.1756237959412; Tue, 26 Aug 2025
 12:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818170136.209169-1-roman.gushchin@linux.dev>
 <20250818170136.209169-2-roman.gushchin@linux.dev> <CAP01T76AUkN_v425s5DjCyOg_xxFGQ=P1jGBDv6XkbL5wwetHA@mail.gmail.com>
 <87ms7tldwo.fsf@linux.dev> <1f2711b1-d809-4063-804b-7b2a3c8d933e@linux.dev>
 <87wm6rwd4d.fsf@linux.dev> <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
In-Reply-To: <ef890e96-5c2a-4023-bcb2-7ffd799155be@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 26 Aug 2025 12:52:26 -0700
X-Gm-Features: Ac12FXwmuWoZhQRGLxuvmxfQXSnKF0Y5ZCZIg16zEhIvZSweZikVlXHfRgk_L-0
Message-ID: <CAADnVQ+LGbXXHHTbBB9b-RjAXO4B6=3Z=G0=7ToZVuH61OONWA@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] mm: introduce bpf struct ops for OOM handling
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@suse.com>, 
	David Rientjes <rientjes@google.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:01=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 8/25/25 10:00 AM, Roman Gushchin wrote:
> > Martin KaFai Lau <martin.lau@linux.dev> writes:
> >
> >> On 8/20/25 5:24 PM, Roman Gushchin wrote:
> >>>> How is it decided who gets to run before the other? Is it based on
> >>>> order of attachment (which can be non-deterministic)?
> >>> Yeah, now it's the order of attachment.
> >>>
> >>>> There was a lot of discussion on something similar for tc progs, and
> >>>> we went with specific flags that capture partial ordering constraint=
s
> >>>> (instead of priorities that may collide).
> >>>> https://lore.kernel.org/all/20230719140858.13224-2-daniel@iogearbox.=
net
> >>>> It would be nice if we can find a way of making this consistent.
> >>
> >> +1
> >>
> >> The cgroup bpf prog has recently added the mprog api support also. If
> >> the simple order of attachment is not enough and needs to have
> >> specific ordering, we should make the bpf struct_ops support the same
> >> mprog api instead of asking each subsystem creating its own.
> >>
> >> fyi, another need for struct_ops ordering is to upgrade the
> >> BPF_PROG_TYPE_SOCK_OPS api to struct_ops for easier extension in the
> >> future. Slide 13 in
> >> https://drive.google.com/file/d/1wjKZth6T0llLJ_ONPAL_6Q_jbxbAjByp/view
> >
> > Does it mean it's better now to keep it simple in the context of oom
> > patches with the plan to later reuse the generic struct_ops
> > infrastructure?
> >
> > Honestly, I believe that the simple order of attachment should be
> > good enough for quite a while, so I'd not over-complicate this,
> > unless it's not fixable later.
>
> I think the simple attachment ordering is fine. Presumably the current li=
nk list
> in patch 1 can be replaced by the mprog in the future. Other experts can =
chime
> in if I have missed things.

I don't think the proposed approach of:
list_for_each_entry_srcu(bpf_oom, &bpf_oom_handlers, node, false) {
is extensible without breaking things.
Sooner or later people will want bpf-oom handlers to be per
container, so we have to think upfront how to do it.
I would start with one bpf-oom prog per memcg and extend with mprog later.
Effectively placing 'struct bpf_oom_ops *' into oc->memcg,
and having one global bpf_oom_ops when oc->memcg =3D=3D NULL.
I'm sure other designs are possible, but lets make sure container scope
is designed from the beginning.
mprog-like multi prog behavior per container can be added later.

