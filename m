Return-Path: <bpf+bounces-15133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5097ED708
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 23:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A221C208DC
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E206446C6;
	Wed, 15 Nov 2023 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwYLSYff"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662D7E6
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 14:07:01 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9e2838bcb5eso26728366b.0
        for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 14:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700086020; x=1700690820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFrijGlQfaVLIufbsKxvAaXRVZ5PaUILbDgcfi3XEcs=;
        b=MwYLSYffq1GsoHrFOco1XBNwnQz7wVSz5h6NiwmMgoJp7wqR0UixdwHDr3n1HhjZq5
         FvhVTN/5wlLYu09oCoAlVGbIzI8unaYwOUfGE5Ro3fCPh6QxpqQ9j2VKKEh+6KibAWDC
         0xFHp67EXO8rJhBFSsrHhvucO4+2hekRAEvjRiTZh3pCiCsvnfMbGi+xfpPT4kvYrSCj
         C/nuks2HO1x2vr8TN7G6yihzO7qJbtq8kVYb61JTUkaNr+tQ2pwCwh8bEF9Llc4VBlN1
         Z2xvKRrM6uaxnRMUAYvMCnuzjWG1XkPTO5JPS9+TVgcgRfGpTasU8ta4P+qS+366Mdt9
         N8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700086020; x=1700690820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFrijGlQfaVLIufbsKxvAaXRVZ5PaUILbDgcfi3XEcs=;
        b=xOLIrNv8UGlBtEoCFbxlJZemkVnPcjonaxU5+OTcM0bACstjUDm4X7kj6vJhSc3b2i
         h1+sOpfH75A7Nr1enCFkaCulf6wVesIQVUqi4H03CXMFEJiE+2CZxxKExVGnO5r48WLc
         McN1D3T3mvCB+5IkQjscKvg/NHyijo3XVpUyN6JwCnM37AJNK3xOzSGsWzoAOTm+KBza
         cmgvQnMpAf+x9406cN+u7ufmiqsDnC2ysb7rLtqCA8c4F8z3340XuqFVo37fJnDz4bzI
         xoZS0qVOZ7C3Qb8tTKWUTYrbAbosFSvjDzt0tW9HfUi/g39wwFr/HdgM86tCZo584aY4
         FiTA==
X-Gm-Message-State: AOJu0YzzVgtftL+9MVFZgNSyI/1041TaA0yo+5d+gEUCU4sU6BL9iz72
	YtOHBPjjwh3nS0Ltaa5wBuUWyh5hEofuIvahK6A=
X-Google-Smtp-Source: AGHT+IH3a3gH5KGIem89z0MHmdEWXxmijjBv+yflPZIBN8maI60aouQKxdi8rOjH0aUF/QcZxUXUu5ahTH/Z/wG+Qmg=
X-Received: by 2002:a17:906:e86:b0:9df:bc50:250d with SMTP id
 p6-20020a1709060e8600b009dfbc50250dmr9501624ejf.54.1700086019579; Wed, 15 Nov
 2023 14:06:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231112010609.848406-1-andrii@kernel.org> <20231112010609.848406-5-andrii@kernel.org>
 <CAADnVQJZr3Za=oM9VeTeY0BGL6rymSHSsKqEWVSJmkRhSvcsHA@mail.gmail.com>
In-Reply-To: <CAADnVQJZr3Za=oM9VeTeY0BGL6rymSHSsKqEWVSJmkRhSvcsHA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 Nov 2023 17:06:48 -0500
Message-ID: <CAEf4BzYCDGKnUd6zJJV-aetUhSq_+QsBFZ6bxS+vvaxvmUDZ6A@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/13] bpf: add register bounds sanity checks
 and sanitization
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 3:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 11, 2023 at 5:06=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> >
> > By default, sanity violation will trigger a warning in verifier log and
> > resetting register bounds to "unbounded" ones. But to aid development
> > and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> > trigger hard failure of verification with -EFAULT on register bounds
> > violations. This allows selftests to catch such issues. veristat will
> > also gain a CLI option to enable this behavior.
> ...
> > +       bool test_sanity_strict;        /* fail verification on sanity =
violations */
> ...
> > +/* The verifier internal test flag. Behavior is undefined */
> > +#define BPF_F_TEST_SANITY_STRICT       (1U << 7)
>
> Applied, but please follow up with a rename.
>
> The name of the flag here in uapi and in the "veristat --test-sanity"
> will be a subject of bad jokes.
> The flag is asking the verifier to test its own sanity?
> Can the verifier go insane?
> Let's call it TEST_RANGE_ACCOUNTING or something.
> I'm guessing you didn't qualify it with 'range' to reuse it
> in the future for other 'sanity' checks?
> We can add another flag later.
> Like BPF_F_TEST_STATE_FREQ is pretty specific and it's a good thing.
> I think being specific like BPF_F_TEST_RANGE_TRACKING or
> RANGE_ACCOUNTING is better long term.

Sure, I like BPF_F_TEST_RANGE_TRACKING_STRICT. Or you want to drop the
_STRICT suffix? We can also do something like
BPF_F_TEST_REG_INVARIANTS_STRICT or something to keep it a bit more
generic?

