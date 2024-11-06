Return-Path: <bpf+bounces-44095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84959BDC45
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 03:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F18E1F24324
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582331DDC39;
	Wed,  6 Nov 2024 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rv8INxvM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E51DDC1C;
	Wed,  6 Nov 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859081; cv=none; b=FiknUjKbDuCJJq8+na8yiUh6T4F1D+wqOnGC7S6v1vIhMZctqELWu+EXz0DPNTUgBdT5aGZ/LrmVd3uXCGjXd4aqMF8ybSRLIeQIOAaRQS8MMpJFXKSsw/DF+PmNxosXeqAD+tUjK9fE9jkndrYu9yj2wDVMteZpJfrhvlm87Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859081; c=relaxed/simple;
	bh=obMhTpK3d+UU3JSNJrBtMMUWyHBoU0qKH/rNVB8ORy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzG4y8cZ5vIosvQsf2Lhjt88Sy6zCemZt8PTE6tt3VLytMdEDD197TK1/wpmIfHQLnEK0TMuL9rudK9M178CJEiYSbnbIk4wt/0CHFfsmrIceUDdjz7r3gxTPF9kHo5srhRnHsTC73Ghy7ptdVVt8A+VQ/FFb2w9svmeCfJ5zd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rv8INxvM; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so4886270a91.2;
        Tue, 05 Nov 2024 18:11:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730859080; x=1731463880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+BC9bKNYRzaIUhTatFOzGkofunov+kcpxiHDzejgjs=;
        b=Rv8INxvM+HJ+fje5XpKVqqIARYcvKVMplnNPeUYc9hSCe2nTEwXINLGsZbgD1BDYaf
         Lzs/gmyKEBg4vMBhcstZGCu4AAw/P8oil4WeDUHUNIyd5TRan6GCxQVgkCEJUwR3OgQc
         WCLHXpt0lEVScpCiNfMLYe7LJVWJUXfEWwOtN6M1/NoTEw2EJJW0CR8ukjpNQUDoe1rv
         nn5ZyKjE7yQ5fqPHQQR/pn3j+xTwAjN3qfGXpCI4hsHIIK024O2oNl7XNei+jgGGMszY
         yHiABSqlJUT16JlCCFqrCCzNYuCMG+YNEZw8d2XlpEtwcy/tGDwtEtxD6z+lMwrl9Ppw
         Oyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730859080; x=1731463880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+BC9bKNYRzaIUhTatFOzGkofunov+kcpxiHDzejgjs=;
        b=rvkumE2VW8/UCQHQg9f0krtk3TTJZ02JEeSO5ANrDx867HXlEZTNgasu0qgMSpWqH9
         LlsLTkCTH/JIZlluVvQZCWj+TbZ06BCoXXZ+QSlwlaJaOMGCk0iaQOoV1t+sy3HkDEY6
         DV3UGwV+xjsev7qFDyzjFmEEjHPEGNE5B9a3cf/Gp8kArqUTLGWInfhRlJJhT8zZeFs2
         0cgx/47YMiYYj1p7SDapSy2N412myjzBSCa39ktwqp+D2G0mT7cmSe2EyxOjbtEpS5C5
         CuorAnro7z+XaH2RYDn17R3e0AS7tjywMB2LcyOn9LhjLoYfqcz1I6OiVw9Z9y9kthf0
         Ty4w==
X-Forwarded-Encrypted: i=1; AJvYcCUFgkSksiPovFlEvQjcGduxGhkrQdP2o7E6lcXodDl7juY9OK78shrsw17wrLxwq2pwu6PmLXdF/QQEQ0v5Aq5V+Q==@vger.kernel.org, AJvYcCXNRs3ZmOxt1WEmLljrTpXHNlyT7QzC6bU5HGeU5/XZQ1Vj0SmyfGtfaZgPXKZYbZaZrbw=@vger.kernel.org, AJvYcCXXWH0m87DsHhOEztimrgUN2fG3xupRywc4WVeqESBOqOetlIX9e6Hep8isqkMjsoxiaDy4T1Qqr0TIOOkILQPlxR4y@vger.kernel.org, AJvYcCXojluwzjh1NA54BnfxZCKjt4/DpzTZxkcLEHmMK0Bw/+dc9k8QsHCiYlf6wrL3K2ChGf6sMOrPYpFBo0JO@vger.kernel.org
X-Gm-Message-State: AOJu0YzzGWU0OvxU7POxBwhJmm9zD+Ah74BfDu6f1lXQG9EB5K+APO1t
	hZKCaNPxNuiVcAJt/I7PMIaAgO9fHj6p7clb8etX8GPbj4cXJ0adsVpwoertapd+2uB16EqvJFy
	gQoagIaenhP6lc91AoDsGgC2akd4=
X-Google-Smtp-Source: AGHT+IGhuQ0Ki8lFJVw8HHIMRmUd846pjUdGQf6LulmYw2lSFPmOAplOZpFFGIuvUvpuGEld1hpQerhc+3AfhlnAJUo=
X-Received: by 2002:a17:90b:3848:b0:2e2:aef9:8f60 with SMTP id
 98e67ed59e1d1-2e8f0d531ffmr41021824a91.0.1730859079752; Tue, 05 Nov 2024
 18:11:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzarhiBHAQXECJzP5e-z0fbSaTpfQNPaSXwdgErz2f0vUA@mail.gmail.com>
 <ZyH_fWNeL3XYNEH1@krava>
In-Reply-To: <ZyH_fWNeL3XYNEH1@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 5 Nov 2024 18:11:07 -0800
Message-ID: <CAEf4BzZTTuBdCT2Qe=n7gqhf3yENZwHYUdsrQP9WfaEC4C35rw@mail.gmail.com>
Subject: Re: The state of uprobes work and logistics
To: Jiri Olsa <olsajiri@gmail.com>, Ingo Molnar <mingo@kernel.org>
Cc: Peter Ziljstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Liao Chang <liaochang1@huawei.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"linux-perf-use." <linux-perf-users@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:42=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Oct 16, 2024 at 12:35:21PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> >   - Jiri Olsa's uprobe "session" support ([5]). This is less
> > performance focused, but important functionality by itself. But I'm
> > calling this out here because the first two patches are pure uprobe
> > internal changes, and I believe they should go into tip/perf/core to
> > avoid conflicts with the rest of pending uprobe changes.
> >
> > Peter, do you mind applying those two and creating a stable tag for
> > bpf-next to pull? We'll apply the rest of Jiri's series to
> > bpf-next/master.
>
>
> Hi Ingo,
> there's uprobe session support change that already landed in tip tree,
> but we have bpf related changes that need to go in through bpf-next tree
>
> could you please create the stable tag that we could pull to bpf-next/mas=
ter
> and apply the rest of the uprobe session changes in there?

Ping. We (BPF) are blocked on this, we can't apply Jiri's uprobe
session series ([0]), until we merge two of his patches that landed
into perf/core. Can we please get a stable tag which we can use to
pull perf/core's patches into bpf-next/master?

  [0] https://lore.kernel.org/all/20241018204109.713820-1-jolsa@kernel.org/

>
> thanks,
> jirka

