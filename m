Return-Path: <bpf+bounces-18973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C238239A6
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 025041C20961
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 00:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86E8B1878;
	Thu,  4 Jan 2024 00:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZZkdhGZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D5736B
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55676f1faa9so23384a12.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704328025; x=1704932825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97c03WjRn+eLRC/pwuiO8Qt6/sLYruLSXWMdgl0lQwQ=;
        b=ZZZkdhGZRDh/4r7L/Y7LuUmtety9Z7xD78f+rAGauGjBEz4ZQoKeOeULmzKiBRgVkW
         14m+9NAHzFW9aRiUf5uiLsfS+AWSwsNEm8R9//gXTjmNQMcX/+3rYz4QW6Jibj3/rlps
         MkrXrE9fr3B+rAQw0zQsPuEDeLzl9oTkj32ciQmmkJssI3a7icRcIUB1fCPcUo3fRhnm
         k7n6nEvIM5EyMv4QQ3V21DFnKcHT7IAK2rypsliv1L6q75uVgjeGQJFfISS/i/jEcR4s
         lC1/qs9kK/G25lJjROTASm6up2WxJl89RcVYZccyvgQX5j+T/uWBz7jJl8pRqM3tTr32
         j/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704328025; x=1704932825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=97c03WjRn+eLRC/pwuiO8Qt6/sLYruLSXWMdgl0lQwQ=;
        b=bPULhRQu6gM0RqcZmFzPxNcDQ+aW/mrKeLELWEAsuwGL2wsB6hdaOtkJdzW4OL9+dD
         O8S4QeagQAUimKBIR1mAn9Y4RJLS5bH+M0djNAMnBIpZlz8MtSmvofJU/+vnAj42dBT2
         7jg0riJkmyzdeZG3obcS7u3+y8aU74dHAmRXuactS+VlhVQIPyx/PoEtV9j0O6fLsnyu
         MV6ZoEv6CQHRFYGoBIV2aG/F+aPafsm3DKFX6IaeFLVO8VCsqs7WjJ3lpV6wmDWEnRMw
         3DPHR01nmurBi+deGeIfaQ1FwMWcJFyKCRXOGY8sMvVDT3UFErLYQEY1uWAuoG6zl1UA
         3p1A==
X-Gm-Message-State: AOJu0YxOQPEV+kg7vw48EJthcGEdxqBmWDpAJED8R/0fcySZiEUNk006
	7gD+IiF3juj1yoSKUsjRpwBk5aI/oD6nxS/YEs8=
X-Google-Smtp-Source: AGHT+IFHptfq/0fVz4mpYtlkx9Uzok1b60EcWOm8YvinhHJnIroLgLsKv09i9tG4FacTi1ZWrgmIW9eoLlHqdulleHI=
X-Received: by 2002:a50:b404:0:b0:553:d7b:233 with SMTP id b4-20020a50b404000000b005530d7b0233mr10828111edh.83.1704328024686;
 Wed, 03 Jan 2024 16:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102190055.1602698-1-andrii@kernel.org> <20240102190055.1602698-10-andrii@kernel.org>
 <2e7306da990a9b7af22d2af271dacb9723b067fc.camel@gmail.com>
 <CAEf4Bzbj8Eeo=SNtRzk75ST8=BnPVJi9CNp4KKpPaT_fnhUymA@mail.gmail.com> <2f889478e7fc787dee74816f9f374284a94a3041.camel@gmail.com>
In-Reply-To: <2f889478e7fc787dee74816f9f374284a94a3041.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jan 2024 16:26:52 -0800
Message-ID: <CAEf4BzaCLZrDTZevHASXJBSjLQ3zR0A-E2zCZJtVwR=De0DfJw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: add arg:ctx cases to
 test_global_funcs tests
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:51=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Wed, 2024-01-03 at 15:17 -0800, Andrii Nakryiko wrote:
> [...]
> > > However, the transformation of the sub-program parameters happens
> > > unconditionally. So it should be possible to read BTF for some of the
> > > programs after they are loaded and check if transformation is applied
> > > as expected. Thus allowing to check __arg_ctx handling on libbpf side
> > > w/o the need to run on old kernel.
> >
> > Yes, but it's bpf_prog_info to get func_info (actually two calls due
> > to how API is), parse func_info (pain without libbpf internal helpers
> > from libbpf_internal.h, and with it's more coupling) to find subprog's
> > func BTF ID and then check BTF.
> >
> > It's so painful that I don't think it's worth it given we'll test this
> > in libbpf CI (and I did manual check locally as well).
> >
> > Also, nothing actually prevents us from not doing this if the kernel
> > supports __arg_ctx natively, which is just a painful feature detector
> > to write, using low-level APIs, which is why I decided that it's
> > simpler to just do this unconditionally.
>
> I agree that there is no need for feature detection in this case.
>

ok

> > > I think it's worth it to add such test, wdyt?
> > >
> >
> > I feel like slacking and not adding this :) This will definitely fail
> > in libbpf CI, if it's wrong.
>
> Very few people look at libbpf CI results and those results would be
> available only after sync.
>
> Idk, I think that some form of testing is necessary for kernel CI.
> Either this, or an additional job that executes selected set of tests
> on old kernel.

Alright, I'll add a test then.

