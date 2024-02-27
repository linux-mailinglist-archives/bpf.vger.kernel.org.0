Return-Path: <bpf+bounces-22798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E3086A1CD
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8794B287BAF
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 21:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EC14F967;
	Tue, 27 Feb 2024 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YGEPLyw6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAA14A0A5
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 21:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709070163; cv=none; b=q7iaYllgKUEB038O9pXnj/iTcHyDk2yn3KkrbU46pUGuyKzP9WVuAXKJ2s5Gg8SW52yuWMhwPd8j0tyeRgV9OtxefzAWczCvlIPDaR3GSWg693VEtnhWo5U5I4td+Aq7mbzqhTB97/NB7lvldbidhDHfJeM5cJIRXr2lqCzMJ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709070163; c=relaxed/simple;
	bh=n5FIMjfE37+j9d561iGl2ezJT/CkGpTEZldVzUTyWHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mquwbj3X9LVePQqgHqCgJbEwKUw6ImbP8CUU4vXkimzNKrX240fqpFgS1PJs9grCDwqhAhSboctD1J8jeJzSsRLKYkmjjAm7iTXCbxMsL2gCQnL3Enu7ONIg5r3W4lb+vNg1DXJ/sHao9pdGdsiwVz2ulSqUM3Lf74jn/49+Rxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YGEPLyw6; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc929e5d99so12125ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 13:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709070162; x=1709674962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIWxi8YYDZGmvXgDqB8jhLHPDMkUkjHOrDPhN8BD6oo=;
        b=YGEPLyw6JC3Y9W+7c6dOfono+CzRwrKuWTykN5UyZwlL7QAnVRgHZXssONAvrlQPyt
         X06QfeteD8JQ7ETzAw4fi5m/cen+GL69pogAzVFb5F/GCAvNvCJcOm/L9q00coaEX/7I
         Zt1Dv1I/oHpM3ED5IzWCeUa5aVLNN5J83Uwj5Xvp+y83jvsQ0UQ/SuhP+tkjchjzEmbD
         2R9GSq3udheW9TJRo5T/siAxnYBs5fPkdRVxV4RG11iM+JvUvnHSnm5vaVU35c1JTM7A
         K+lIQwGZERgPpflYftqWOHfyeNx1F6akYjO0xOBrHIexbsJjyefLHosrZp4XbINTcOvt
         x7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709070162; x=1709674962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qIWxi8YYDZGmvXgDqB8jhLHPDMkUkjHOrDPhN8BD6oo=;
        b=OWCE15pGJ+e8VsMselC/xwQRnZkiCBOwllhK+Z63WFg4HxTtBoQko/YZSShkzcSxTl
         rxZcwqTfuq8rxgAQoC6m9s+od8SnZtPjlihRxjoHyouTyk/WYluXtRHR0gSGe8PaEpRB
         s3oRG4RAQ6Hx3pc16JfCb14iXtulWdKAQYXqgVLoVfZwwLSHWJQgUDCskajClBafLI8q
         2r0eSrqJMiCdW4XPSTs0veV7+yFTJSjgFQ6xhK0EXD8Y9vpSFPaFf4+Wmtxb3PM5RMUj
         7SVJdxb9ypyWsN/UMGHwtMMBvaTHnFbHFQQat257cV/bPi4K9q3zrcTrATJqGZXm3/VO
         j60g==
X-Forwarded-Encrypted: i=1; AJvYcCWXCYcIhaPfwxkBzNUrNe2iE4Hr3VUW9ICmRINlYW57sa0hj2CfYbp+klMFqusSJ5xtZMBvQxe27+QXuzQIIDzy0aPy
X-Gm-Message-State: AOJu0YzMmzdlJ2jKVBGmxMA6pgfpWBsmLrob6GPIWOLzZntAQweaPmJI
	8hsAVIvVcogyFPGKuaBuLp2l49sN8L99TaCivLuV2Gaf69lursVH7PAsll3QjjDZEukne+RanUa
	KzXuGOJ5Z/zRWrcj1SiiH/TmLaG1Kd5ZqA1QD
X-Google-Smtp-Source: AGHT+IFCeNuUHe3l4Xcv3rin00rIFck+iVA5pNN3AmoOCXmTodoMOzGspF8/MPHg8AR27A0t7PpDEeb3Er1yyYSyYc4=
X-Received: by 2002:a17:902:8d91:b0:1db:f1fc:3deb with SMTP id
 v17-20020a1709028d9100b001dbf1fc3debmr306811plo.1.1709070161471; Tue, 27 Feb
 2024 13:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
 <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com> <Zd41Nltnoen0cPYX@x1>
In-Reply-To: <Zd41Nltnoen0cPYX@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 Feb 2024 13:42:26 -0800
Message-ID: <CAP-5=fWv25WgY82ZY3V1erUvCb+jdhLd_d91p4akjqFgynvAgg@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Tue, Feb 27, 2024 at 09:31:33AM -0800, Namhyung Kim wrote:
> > I can see some other differences like machine__findnew_thread()
> > which I think is due to the locking change.  Maybe we can fix the
> > problem before moving the code and let the code move simple.
>
> I was going to suggest that, agreed.
>
> We may start doing a refactoring, then find a bug, at that point we
> first fix the problem them go back to refactoring.

Sure I do this all the time. Your typical complaint on the v+1 patch
set is to move the bug fixes to the front of the changes. On the v+2
patch set the bug fixes get applied but not the rest of the patch
series, etc.

Here we are refactoring code for an rb-tree implementation of threads
and worrying about its correctness. There's no indication it's not
correct, it is largely copy and paste, there is also good evidence in
the locking disciple it is more correct. The next patch deletes that
implementation, replacing it with a hash table. Were I not trying to
break things apart I could squash those 2 patches together, but I've
tried to do the right thing. Now we're trying to micro correct, break
apart, etc. a state that gets deleted. A reviewer could equally
criticise this being 2 changes rather than 1, and the cognitive load
of having to look at code that gets deleted. At some point it is a
judgement call, and I think this patch is actually the right size. I
think what is missing here is some motivation in the commit message to
the findnew refactoring and so I'll add that.

Thanks,
Ian

