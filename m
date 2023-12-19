Return-Path: <bpf+bounces-18251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C63817F2A
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E86B2408A
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 01:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC4215A0;
	Tue, 19 Dec 2023 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KA/I3J2n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63672637
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a1fae88e66eso438558666b.3
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1702948302; x=1703553102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hej4AjxanXNrySIhvl+6S8hgAgsJIbBbBmJWQyMfh84=;
        b=KA/I3J2nI6vlr40oNCHPbjUm5JWHTBOJePD2krxYp5sHnpLVCU5ETGfFX/mHuBmnbv
         g6O4F1Mkwmv3UQ9k8xtQq5ZT44fOPtbIuSQSbAuX426WlLO9GzUDgJrYO/h3XQXKkkIi
         qSYT/HVBGHuIoS2THkDngcmFlyRQ63X8fKl6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702948302; x=1703553102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hej4AjxanXNrySIhvl+6S8hgAgsJIbBbBmJWQyMfh84=;
        b=sWPJu8wWqzJo5ujIfCS0AJziPt4BTXVxh+StriZrZVwggpz+M9yALYDlJlp2eJpzD/
         OYt0c4+VvJwfpi7NyIYkUCos6zout5qJJtcC3UfpNozEiNXRn8H6kwj3W9jJt/9AsPeI
         YN3OnlOtAqG4wg2qbn+08qIXXbpnm8QQGPGQl1cm86soXUay9+clw0N33ZPK/0H6/jwr
         4rWI7t/RHSoJ0Bnk1JpQMUPDoPeiMDSUrtAC8XSHu1Hk2yMmel40jvw2uKdFivDnUIEe
         CRQ7JaE0WXFtjZUQpAAm0mk4gjjKA3gwGsA55OCo1Sfz8x4woOHJwaNrrD82E8jeQ1RK
         JOqw==
X-Gm-Message-State: AOJu0Yz5i6lk4QX2X3rVdrJIxGs3fnvAwICBWJUWfwjSSNkXvp10N5wg
	N2/UsF2+DuMjbWiKyy5pThUScreX6OZTZR2jK2lFoA==
X-Google-Smtp-Source: AGHT+IHnvIPHe+NCbHz0V/Ai3Va85arXO1teHlcA7baGA6NmH2G8UmGyeJEM3BQpzzKdmIQ9yjyUFw==
X-Received: by 2002:a17:907:948f:b0:a01:8ff7:5fa0 with SMTP id dm15-20020a170907948f00b00a018ff75fa0mr8484463ejc.6.1702948302351;
        Mon, 18 Dec 2023 17:11:42 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id l17-20020a170906a41100b00a236eb66b2fsm492517ejz.82.2023.12.18.17.11.41
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 17:11:42 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33666fb9318so1964901f8f.2
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 17:11:41 -0800 (PST)
X-Received: by 2002:a05:600c:511a:b0:405:37bb:d942 with SMTP id
 o26-20020a05600c511a00b0040537bbd942mr8221931wms.4.1702948301548; Mon, 18 Dec
 2023 17:11:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Mon, 18 Dec 2023 17:11:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
Message-ID: <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, daniel@iogearbox.net, andrii@kernel.org, 
	peterz@infradead.org, brauner@kernel.org, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Dec 2023 at 16:05, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> 2) Introduce BPF token object, from Andrii Nakryiko.

I assume this is why I and some other unusual recipients are cc'd,
because the networking people feel like they can't judge this and
shouldn't merge non-networking code like this.

Honestly, I was told - and expected - that this part would come in a
branch of its own, so that it would be sanely reviewable.

Now it's mixed in with everything else.

This is *literally* why we have branches in git, so that people can
make more independent changes and judgements, and so that we don't
have to be in a situation where "look, here's ten different things,
pull it all or nothing".

Many of the changes *look* like they are in branches, but they've been
the "fake branches" that are just done as "patch series in a branch,
with the cover letter as the merge message".

Which is great for maintaining that cover letter information and a
certain amount of historical clarity, but not helpful AT ALL for the
"independent changes" thing when it is all mixed up in history, where
independent things are mostly serialized and not actually independent
in history at all.

So now it appears to be one big mess, and exactly that "all or
nothing" thing that isn't great, since the whole point was that the
networking people weren't comfortable with the reviewing filesystem
side.

And honestly, the bpf side *still* seems to be absolutely conbfused
and complkete crap when it comes to file descriptors.

I took a quick look, and I *still* see new code being introduced there
that thinks that file descriptor zero is special, and we tols you a
*year* ago that that wasn't true, and that you need to fix this.

I literally see complete garbage like tghis:

        ..
        __u32 btf_token_fd;
        ...
        if (attr->btf_token_fd) {
                token = bpf_token_get_from_fd(attr->btf_token_fd);

and this is all *new* code that makes that same bogus sh*t-for-brains
mistake that was wrong the first time.

So now I'm saying NAK. Enough is enough.  No more of this crazy "I
don't understand even the _basics_ of file descriptors, and yet I'm
introducing new random interfaces".

I know you thought fd zero was something invalid. You were told
otherwise. Apparently you just ignored being wrong, and have decided
to double down on being wrong.

We don't take this kind of flat-Earther crap.

File descriptors don't start at 1. Deal with reality. Stop making the
same mistake over and over. If you ant to have a "no file descriptor"
flag, you use a signed type, and a signed value for that, because file
descriptor zero is perfectly valid, and I don't want to hear any more
uninformed denialism.

Stop polluting the kernel with incorrect assumptions.

So yes, I will keep NAK'ing this until this kind of fundamental
mistake is fixed. This is not rocket science, and this is not
something that wasn't discussed before. Your ignorance has now turned
from "I didn't know" to "I didn 't care", and at that point I really
don't want to see new code any more.

               Linus

