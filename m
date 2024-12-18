Return-Path: <bpf+bounces-47205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E69F5F73
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 08:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034801881EEC
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 07:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AAB1684A0;
	Wed, 18 Dec 2024 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w8aZBT8E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40D916630A
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734507674; cv=none; b=UacRdDpZXtrRIRYV4IQcRfigqCSCYvEMIuZu+qlSOmZQmDwTJ95VQJtIc2aSrNvGDDEz6zOA8FZOAVACtPgpjSPgpxpLBFAOfke1IJjjSsvLmjFjboLKtOHnQeFUd0t02SfPHvaetJc3afRo3ftmlezwLLH3dIFmKpR/US/jmjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734507674; c=relaxed/simple;
	bh=coYSCa6srDcN5W+MR0+5UPZjH3IFU84xqA944Wm0lJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9+G6BBKElgrUyGgyWL37KnbcAUH0aHYPLoF755HKCvfdvcCmUpDW3uRBTkJamPZEJ5RDnM94vplFp9XP48QweFxYr3V4JLOdjnJ890wW3Sjk6VUWhbFiXnkOWcKl4H0Tn2mV8AIeeOmP+On2c57mM6qaOmg/8/FYqV0zFPiPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w8aZBT8E; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8f1505045so50651726d6.1
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 23:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734507671; x=1735112471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coYSCa6srDcN5W+MR0+5UPZjH3IFU84xqA944Wm0lJk=;
        b=w8aZBT8E528uE1CpQGKtt2vfqz3/CNuV8WxNshXRBeAjlKyd3SZBYgKbgGqoxv5zlc
         aO0Qn4akN2RycnCcShThnA+A+NZm6f+xBJGkxMVysjRVLzNKmPV5xCSmYJjdxOiVc4oP
         DcbzeIwF9maZSxFlCxy+KCrRw35lLUCCY8u+RbISw01lSwPTlfHktuvGbzSx5HFN5GZo
         P6tuhiiED1F1rYyZlSI2P7FBamllWS1A7f3ZhKpm+99HNP1WluttDmlraNYKyUwMTMlL
         whT1lFqJoJXP0yDut5LCH2es7/b26Pj3ZevGb8Y7D5pZW0QiWlu0dOzWBf8/fJR1Czt1
         htEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734507671; x=1735112471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=coYSCa6srDcN5W+MR0+5UPZjH3IFU84xqA944Wm0lJk=;
        b=XEXUnp4IJ9O8LNTXR+4ojnU0z2PyCLNqg+24zi8o2GcGGf5zZZXUyH/1A1pB5cRG1g
         7/nZI0MOpQARpW49tiGi+LR4tJvuNuuwJudMVbHwgQZfbTIK6qGJmquV/EFIFe1mksmn
         hx3lqNerrOShDNL4JCVPJIE1RoHaTDD7OBTSsj4PeYvoLeA33ux0km2ihSLxCGDFoj6T
         6GlrMoTOydTy/P1fREeKAzzW1LQFJ8jGNpPbbgwQS0aw/SHPSKefYHGL3IR3djziOC8j
         4LZrpZLkJ8+6BQcQd2KcSONNK9F0Iu6h9hrMK15w8D483o7odXdaZek+fo0BjVHC6pj1
         i94Q==
X-Gm-Message-State: AOJu0YwoMh3XU/90AND0cU/jODqFM928oqQyymLVnZdXRX79/LAVduEZ
	XfvRwx8fW0008FJtQkMKcqvyYyTvQMbWOabM/3sx5Y4FhgDP0yRKUz0MuVagIH8zK2Zvs9nMTZc
	zgWCe4LiR7603w/YmngkSLNh1QgeGeViZMThv
X-Gm-Gg: ASbGncuu2RfBppn93+tUphlEtEXbkkNYvztDO0e+CQ8mO+iHp9vsvEDSWS8k9ujlnNu
	5mmVRS0lNRUl6iWuYci87Nfg9Hy9vmiLGDds=
X-Google-Smtp-Source: AGHT+IFyghsk3hDgcpK8OqFTYryRjftq0KlLPDBqW46xlx9T516zU+ShYdfVuospUTxwrlARi5J2/h0w3XI2dE4eBLY=
X-Received: by 2002:a05:6214:4005:b0:6d8:aa52:74a3 with SMTP id
 6a1803df08f44-6dd091d8bd3mr39088986d6.28.1734507671323; Tue, 17 Dec 2024
 23:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
 <20241218030720.1602449-3-alexei.starovoitov@gmail.com> <CAJD7tkYOfBepXDeUFj6mM1evRoDdaS_THwmhp9a4pHeM4bgsFA@mail.gmail.com>
 <CAADnVQKmMaybRQJDyC9sbtmxod6S8kgcrk4FerWt9ve0vR9U1w@mail.gmail.com>
 <CAJD7tkaP40Tde1KHr2t8O9dHyiRSx8Q02=EmPtROyRpS+_qPDg@mail.gmail.com>
 <CAADnVQJwcd=PsdxcipiN8VeJh2UhSv3uzHkX5E5RuLK2vfdSHA@mail.gmail.com>
 <CAJD7tkYkhojXE0wwOxEMV1uWb-9hxyqbjD5Uj9ji3+GdZmZnKg@mail.gmail.com> <CAADnVQKwOg0D291ndr_m=RZqTBxW8tbPV39BHPHYMmPif3kbRw@mail.gmail.com>
In-Reply-To: <CAADnVQKwOg0D291ndr_m=RZqTBxW8tbPV39BHPHYMmPif3kbRw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 17 Dec 2024 23:40:34 -0800
X-Gm-Features: AbW1kvaTzWf8B9cmIWua0nD3lhtwwDfpu7WjVqH9m6BR_V8eNFoc-GwWWo6aH60
Message-ID: <CAJD7tkaP4eTvjSJ5=_yUgeT21ry_TRTZxdUQ+k9Ftq+4eL8Q4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 11:25=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 17, 2024 at 10:49=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Tue, Dec 17, 2024 at 10:37=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Dec 17, 2024 at 9:58=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
> > > >
> > > > What I mean is, functions like __free_unref_page() and
> > > > free_unref_page_commit() now accept fpi_flags, but any flags other
> > > > than FPI_TRYLOCK are essentially ignored, also not very clear.
> > >
> > > They're not ignored. They are just not useful in this context.
> >
> > I think they are. For example, if you pass FPI_SKIP_REPORT_NOTIFY to
> > __free_unref_page(), page_reporting_notify_free() will still be called
> > when the page is eventually freed to the buddy allocator. Same goes
> > for FPI_NO_TAIL.
>
> free_pcppages_bulk()->page_reporting_notify_free() will _not_ be called
> when FPI_TRYLOCK is specified.
> They are internal flags. The callers cannot make try_alloc_pages()
> pass these extra flags.
> The flags are more or less exclusive.
>
> > > The code rules over comment. If you have a concrete suggestion on
> > > how to improve the comment please say so.
> >
> > What I had in mind is adding a WARN in the pcp freeing functions if
> > any FPI flag but FPI_TRYLOCK is passed, and/or explicitly calling out
> > that other flags should not be passed as they have no effect in this
> > context (whether at the function definition, above the WARN, or at the
> > flag definitions).
>
> pcp freeing functions?
> In particular?
> tbh this sounds like defensive programming...
> BUILD_BUG_ON is a good thing when api is misused,
> but WARN will be wasting run-time cycles on something that should
> have been caught during code review.
> free_unref_page_commit() is a shallow function when FPI_TRYLOCK is used.
> There is no need to propagate fpi_flags further into free_pcppages_bulk
> just to issue a WARN.

I meant WARN in free_unref_page_commit() if any other FPI flags are
used. Anyway, I don't feel strongly about this as I mentioned earlier.

