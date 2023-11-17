Return-Path: <bpf+bounces-15267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CF97EF8B0
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E2A1C20A3B
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 20:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38FA43161;
	Fri, 17 Nov 2023 20:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaJfk0gx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3BD189
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:31:39 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50a938dda08so3488628e87.3
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700253097; x=1700857897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op/AFKqc4vrV8aDpfVFLQsUA6BcpmIXzLmZzySD+mkk=;
        b=CaJfk0gxvRmWtXhL2MMSGzDMniPkfHC+tV/6Rx66nXjYif+dZ+K5+BA3bCRKoHsf4N
         VnsySZSZT8Y7df8TZaS1BMyip0n1YVSfIhmdNVBJvmQRnwTVAOFkBzi883vnBR7hL/i3
         v8c5l43U+QJaukxK2d773MTEO82KvVqajOAuS5LQ9DTF7sQQF/fIz2VBx3KicpWT3rkQ
         0TzAIzLkwMo2tyePvoeom1kklmKQM6krFvHHzVmO4QZtX/JU2wJDZpknxZI6leHuR5ef
         eSpMIC9XqlmV5o0Q8WsiGLDidRP4272+Ssd5MkPa0pB+2A7ZAcsQvCN46Yiao9qR3mdE
         q/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700253097; x=1700857897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op/AFKqc4vrV8aDpfVFLQsUA6BcpmIXzLmZzySD+mkk=;
        b=Ui46xHU7YwcUhGgr9iomdv6YEcCr0We4iKb6nO25aCEFZlmRVCiyg2S+y1aAsXm77C
         sbyTE3ERXRIqhtaKbQTGFTPiVAnEsrlv/MiaQwaphAag75CUO6I19MPVUkIPZJiwlyU0
         UfFt5O6vavMJBFihgyt5FY4x0y0s+hEn6X0Bla6oayZmAmj5/zAEbWssEICL5/LQpald
         77V0UV6AxbqvBo+SG54Tn6ad7j19lxtW9t+/bf3n8PrA0o+gSWp0xoPMtceJIgQB/uzi
         CPufVnuG7Q2YrNSNrnnIfCAzQbvUNmnwNtH72WmHehRpl4glbrRusA6xkmoCkOzJeZkO
         q6iw==
X-Gm-Message-State: AOJu0YzTFhoclZrRRPbymeAq9BwqxXSXp1qTHG7fBnc35dB3BqoiwgmG
	5of2FYsgwhX/m+CFIIfKeuSpZQsPjH30PQroPMU=
X-Google-Smtp-Source: AGHT+IGCa1V7jCCBujNy0ghz1pCjF5wXMiIS5qWuyLgkMFVlrx72cvgS+4PHDUq44Uw33bNCFiRPhqGFsRuJZs/x8YM=
X-Received: by 2002:a05:6512:5ce:b0:50a:40b6:2d32 with SMTP id
 o14-20020a05651205ce00b0050a40b62d32mr426567lfo.54.1700253097284; Fri, 17 Nov
 2023 12:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-12-eddyz87@gmail.com>
 <CAEf4BzZhEU-h0yfY2WCBfPDjmwOzxxw1a70J4c78Bix34W70QQ@mail.gmail.com> <d6e728aa421b08544b982a0ce60148ef45af7b53.camel@gmail.com>
In-Reply-To: <d6e728aa421b08544b982a0ce60148ef45af7b53.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 17 Nov 2023 15:31:26 -0500
Message-ID: <CAEf4BzYHjLdw4xDkoa_r2hBc_RiOtZE78uGcg013GxJ-am0uBw@mail.gmail.com>
Subject: Re: [PATCH bpf 11/12] selftests/bpf: add __not_msg annotation for
 test_loader based tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, memxor@gmail.com, awerner32@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 1:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2023-11-17 at 11:45 -0500, Andrii Nakryiko wrote:
> [...]
> > I think this implementation has an undesired surprising behavior.
> > Imagine you have a log like this:
> >
> > A
> > C
> > D
> > B
> >
> >
> > And you specify
> >
> > __msg("A")
> > __nomsg("B")
> > __msg("C")
> > __msg("D")
> > __msg("B")
> >
> > Log matches the spec, right? But your implementation will eagerly rejec=
t it.
> >
> > I think you can implement more coherent behavior if you only strstr()
> > __msg() specs, skipping __nomsg() first. But on each __msg one, if
> > successful, you go back and validate that there are no matches for all
> > __nomsg() specs that you skipped, taking into account matched
> > positions for current __msg() and last __msg() (or the start of the
> > log, of course).
> >
> > Not sure if I explained clearly, but the idea is to postpone __nomsg()
> > until we anchor ourselves between two __msg()s. And beginning/end of
> > verifier log are two other anchoring positions.
>
> Yes, makes total sense, thank you for spotting it. I can fix this and
> submit this patch as an unrelated change or just drop it, what would
> you prefer?
>
>

I think it's useful in general, I believe I had few cases where this
would be helpful. So submitting separately makes sense. But I think
this patch set doesn't need it if we can validate logic in last patch
without relying on this feature.

