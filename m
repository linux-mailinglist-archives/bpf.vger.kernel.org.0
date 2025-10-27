Return-Path: <bpf+bounces-72373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88045C115C5
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 21:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3123F4F96C1
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 20:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D5032C323;
	Mon, 27 Oct 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tw5k8+RR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BF6324B0B
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761596000; cv=none; b=qup+xIkgDPNG046frmaXWWTkxDOrLsP0mEiIsFkGr/v5LEP5PcIodjX+DWrB+nkryCxzhCbkSLfDB+jkrfaY5/NVA1UjLPLw1qgclLTG1B3feO2VN86fSYPoCG3W6BKRFlWkurpNBIUO1Tqce+PIh5rQYFC8AVPsn8yQXr3GYaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761596000; c=relaxed/simple;
	bh=7/jgPYWC0V1D8IWJvZFoe28znSAzn2itXE/nwEWLtiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emkut8rSRMLKmp3uuobp8J+nFPZiwFZlW3REOSyleuR5hlHeRbsYqNDWBLXFzxrkHb0U5G3cCbfrfnnWF5VasHN6aie9KkfpavM8gE8MtUkXPRRsXckGauUX0pflWGAU3PtPkGLVdadoR94LqWuhbzfui6RltjAQ89mbFzDOeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tw5k8+RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C75C4CEFD
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 20:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761595999;
	bh=7/jgPYWC0V1D8IWJvZFoe28znSAzn2itXE/nwEWLtiQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tw5k8+RRR8ZQWGB85VYzWf2Wi58LdQQOsk1Wd6HUWngGMEl3xHQQJ+6QMEnaIqyjE
	 hwq+u9XOBdXqtLS1aSDdxiMwMIgByssijVT+USX9/Zm4rKR3bw++NOg5WdUIl+kM+E
	 j6sh6H4aYiKT/EyPhuYAvwLCadoZzOlRFiWbZQZKl3eFz+is5npDUZT7ZerlpYPO9f
	 QwhlCyG5YN6UWxOfBnsK1VxGWtD3RO24J4/QNZEMqBkgfeibbDqjzFf4GA8n9onp3+
	 fKXGM4DZFNJwJyYXnRSLvTFEXN7NdjFiTrAuuoO2f9tfqnujndf+H2tDbrE1WrzoW5
	 nmJlPR4bI4x4Q==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-654ecc2af8eso580438eaf.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 13:13:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNYuzGno5sDdlLuKrSWx5aIkiHTcRY5JDCt32zYL3Ti47mW53lh99YdNV8kS9ghvHWSpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVFLWJi5/2W/IJ+efV2R5Zb2+wMBJkwTw865iJYPddXXyQ4GMs
	6Kwi2vDDxnIMFg8TPP6P3XBqYz5Pyw7zo3gFkYbNVlF0B5mBLb/U5kka3c8kwVZlpX8FXSvgJ+j
	oFVw3ObvC3PDWB7kK3kpnmY3oaC1Onn0=
X-Google-Smtp-Source: AGHT+IFzhgtS06rA+RZsyYcTHjt7tKv3IPYAqJiI30Zg7pVKVf7PdFA1QapVHBr8NekG6KSfuz58bzGzmJpR6s1c8PI=
X-Received: by 2002:a05:6808:8919:10b0:44f:6df7:cf42 with SMTP id
 5614622812f47-44f6df7d022mr64955b6e.64.1761595999030; Mon, 27 Oct 2025
 13:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
 <20251017061606.455701-8-ankur.a.arora@oracle.com> <874irkun26.fsf@oracle.com>
In-Reply-To: <874irkun26.fsf@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 21:13:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gHbOKN_3gVufY-Uv5yNuFsZ7vGdJgm8VMWJMq8EJJ5iA@mail.gmail.com>
X-Gm-Features: AWmQ_bnp6ii4CmrVCoy6tewQvRu5JbQ235PW681sgNQsgSfTn4C6zcDylVx5kw8
Message-ID: <CAJZ5v0gHbOKN_3gVufY-Uv5yNuFsZ7vGdJgm8VMWJMq8EJJ5iA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] cpuidle/poll_state: Poll via smp_cond_load_relaxed_timeout()
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org, 
	peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com, 
	harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com, 
	zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com, 
	joao.m.martins@oracle.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 9:07=E2=80=AFPM Ankur Arora <ankur.a.arora@oracle.c=
om> wrote:
>
>
> Hi Rafael, Daniel,
>
> Could you take a look at the proposed smp_cond_load_relaxed_timeout()
> interface and how it's used here and see if that looks fine to you?

Well, can you please resend this with a CC to linux-pm?

I believe others on that list may be interested in it too.

Thanks!

