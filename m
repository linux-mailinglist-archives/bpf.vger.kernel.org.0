Return-Path: <bpf+bounces-71494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962BDBF5469
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 10:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5433A18C60CB
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 08:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D2F30CD8D;
	Tue, 21 Oct 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkcFdEM9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566F30499A
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 08:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035633; cv=none; b=ho9ssCa1J8y0VGwQxQTxdoFJzoQGoADmEutmjPj87DGNFMNzm56p70VnPba7XeHN04wUgl6eU9560X1a8DRTMY0Qofz/1Ku5X6eIeqmRGAA7VwK6R/eDzTLqwy3O+kDlDbiX2Mp8N3IlepGDs88zGzbCU/FXFfp8Y/k+ABCeCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035633; c=relaxed/simple;
	bh=sC9XWrnBE3t7CWsd+EUC6s+rW0xvjJOyGukU/qizeVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=deAjBUu/EN0WJwpzfzuTlQjbNClpgorFWM93HreGuC2F4V+zEDlINvL/JeyVfKTmyjKrmxPK53CLe6tf+XTMs3vm73tGq3c1m+brMb+1WG2YnpZQ31sx0kJK5Tb54pciCjCT6a4GA6R/Im/GXOngXzrnTfPzrzDHPdGJq/37jrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkcFdEM9; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c0eb94ac3so9492286a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 01:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761035629; x=1761640429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyP++HOcnM7lkmBraj+8ZhnO1B17TMRPQ7N0T27aqTI=;
        b=QkcFdEM941FvSGgVKR6mAUYEOJNo0jtZlbyrMg6OLyfOkykbA6xhriNopFiQBv3IZy
         OyM2B+S0YJFYG2s454TXEC8YNMZB0n6GOk6oFBtO3shjrb4VY+UppC+66pTatdLFjizg
         1LC9jcf8j3Du4/UVggTO7p5UnSz/9P+LJOQC8yLVBVZZx4pASRe92ahe2LDZ0y1BM2do
         c5j9poEaFu26Z5ft4VSZ8WZJtg4zgTGT3+xHkJ2dMGCDfPmKZuIWBsDqOroBz3/cwuPR
         vAsQAYvtUecTgi+uIQcKcLRo3RfUDPNHHw10ltI2R5SuTqH0Abm5G2nJPvb5fnum22ri
         cVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761035629; x=1761640429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyP++HOcnM7lkmBraj+8ZhnO1B17TMRPQ7N0T27aqTI=;
        b=LjBkV4JrSpTbiOtkI/7cBsNsYLin+4p3oSeuc/8hM5TdC4yc/A9Zt7k+HioVKu5cVe
         rAjdYKpHYtJncGohQLZpOQpXUQzxbSgsNPyC/L0MutZxWIMUWKG1O2bV6j/HPp5/BEWy
         xJDM0quHd7Xg0s8dvwUwxbO/WrhPVLY4sqJN8nNY6cs1/P2b2WVlmorPVyqmSGCcnsQ1
         GQ+tvGYCsd3aqbqtxb6VIWeJpVmcZgfCuYbBUpz3GRMfC1VzxNlL3enmrwmM3Mc92WlA
         OycLcikYPs/yuO6KS9bcyQXYOyirzOsP5gXQq52mXqagsnajq24BW3lG5tp3LTE24vGf
         3MnA==
X-Forwarded-Encrypted: i=1; AJvYcCXbOQpK+LkFfv5PsFP7THJHAQOL4Nj9ufP3hLzqU4yb5/wrHMWC8QhmCT8CW47SXcUPXNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVc9LgLvkLFdNZxLAfh6cw0uRna4z3RaJVwuALhupspsMY1JYi
	RiEjYxJ2zEOn01lcBCNY5TohSKADl6Rab2tsr5nCBs52HRFZWovcQ+2GQS7LNkmpyVaBmVlzmUh
	NKZKnZL0ACuBcb0wsG9WQn0Wk5nEuSHk=
X-Gm-Gg: ASbGncuh6HJS3MreuOR8LIsyn1qgX77HhBE1YV55skRCGHN8aUWU4H00Vd5R0AT5qn7
	FsQ2XdOaDdZnUvCnvz/Q9Y27r+spT+3shWZbUVX0XDAbrOY/+lSSU+RfGcwRZ3cqB12UDtBijVH
	VskG37APcwusNWwQmM4lwMmd4E4it4PM4TcLKrF/aI/WZXs5pIQ01jejVj/pGHbvvm0DuVikYoK
	imAqA8+9r1U0A8lnRrAkVm2ck5jT2t+ZJCHal7HN3bKRpUgoeAKbEeYwViohA==
X-Google-Smtp-Source: AGHT+IH/pE5ik6MMElYZe3UMIK5tnAihJXbcXEyKiU+GhEhSlSbJSIbTy2jEhjI6EnSJJeysRC1LrRzMS8mFAq/utIA=
X-Received: by 2002:a05:6402:5247:b0:63c:4d42:9928 with SMTP id
 4fb4d7f45d1cf-63c4d429ba7mr10190315a12.7.1761035628426; Tue, 21 Oct 2025
 01:33:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020093941.548058-1-dolinux.peng@gmail.com>
 <20251020093941.548058-6-dolinux.peng@gmail.com> <f7024fc31ccc9c8b8bdfe2865cdf3604079e0039.camel@gmail.com>
In-Reply-To: <f7024fc31ccc9c8b8bdfe2865cdf3604079e0039.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 21 Oct 2025 16:33:36 +0800
X-Gm-Features: AS18NWDhGggOjJO_tD-qLkRT-BVTimxKtqYZ4e3A7X_roKbqerQg19kh8xI5vfY
Message-ID: <CAErzpmt8HOfZUtYSbmemvpwKO7=Y79ffJo--tLaEsHFUQCRtmA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] btf: add CONFIG_BPF_SORT_BTF_BY_KIND_NAME
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alan Maguire <alan.maguire@oracle.com>, 
	Song Liu <song@kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:50=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2025-10-20 at 17:39 +0800, Donglin Peng wrote:
>
> [...]
>
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index eb3de35734f0..08251a250f06 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -101,4 +101,12 @@ config BPF_LSM
> >
> >         If you are unsure how to answer this question, answer N.
> >
> > +config BPF_SORT_BTF_BY_KIND_NAME
> > +     bool "Sort BTF types by kind and name"
> > +     depends on BPF_SYSCALL
> > +     help
> > +       This option sorts BTF types in vmlinux and kernel modules by th=
eir
> > +       kind and name, enabling binary search for btf_find_by_name_kind=
()
> > +       and significantly improving its lookup performance.
> > +
>
> Why having this as an option?
> There are no downsides to always enabling, right?
> The cost of sorting btf at build time should be negligible.

Thanks, I'll remove this config option in the next version as suggested.

>
> [...]

