Return-Path: <bpf+bounces-41785-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4923599ACCC
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 21:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738F91C26818
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 19:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3349B1D0F77;
	Fri, 11 Oct 2024 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvzTZeps"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0A1D0F68;
	Fri, 11 Oct 2024 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675259; cv=none; b=ITlTV3U1oto4q4qCx526GEL5QMBF6XzVlI+rwA6tjCQrbFToEz5/ghvGrgibvY/6vkwOGsRVRtKqcd7f0RL93AFfmEKfzSg/cf1HFMuLODDGfdqtEkf/OSj9L+2rH3TNi/aW5t9QQ0IdrcECVM7Z/lFAF12XeChv9vo4v/R3iVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675259; c=relaxed/simple;
	bh=2Bxp5SBO/hNaAA6txUfEYpCg2c3t/Jlez5bVGWr70vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BvuDmYL3LrMo66CWXxqatVrcpVW0BN/zGflvIbHr08Jxz8iGWCsEnKWdZbg4xRp7Zm4lNx2yNrIValc6SygXFRP1AXFOG8/ItLv+1MBSPk7CMlqyDqZBUXjY79qDfTv8n0seLjN06Wbk7EruAk7EEUt8yaoAVq38xVdm9y5PeKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvzTZeps; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c693b68f5so24859605ad.1;
        Fri, 11 Oct 2024 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675257; x=1729280057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Bxp5SBO/hNaAA6txUfEYpCg2c3t/Jlez5bVGWr70vc=;
        b=DvzTZepsNdLc7fIdGUYPJan5CoA1ooCRHkYmComRvdJUuknKc49wmVqMTZJdo2KD1g
         IJclV31tBF4a1Dt2fxetF2PXxhjhd+jT9qwY9gLmcighaJcm/sazpcc7rQA28eAban7+
         U0wfJIjXzne/dy207x1X36gi2zee8TPmt/3cgosrUMojs7n+ejusa5ivPEimaN5P0qpS
         aFCJibeen+28/5T49cgWOCEvI3+70T2vVZa/hKpNbgs1tgc83wHiJ7l7C21h+fkM0Tcr
         XHGJcpf4PjjQutCmVhJ7yr3mz4QTDF9orBhnEYvX0YLnJZr433cdItl4F25BqaD6zWQQ
         Unkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675257; x=1729280057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Bxp5SBO/hNaAA6txUfEYpCg2c3t/Jlez5bVGWr70vc=;
        b=FcZKmyNABqCY0uDOQx6MH6gwBTttbw8y7fW7Jxdf1ekodfZwrCzC/prpzHBaJaPDOf
         S1TMSOPFLjmzAH9vYnYhWDol3sVaG+X7F1yk8It6rlkAymBp69dhUMgqqnq9w1Kwxkkc
         UKOLb8L45cFjb8v5GEihhwmsbXWvolkv32rWUcGGlN5ytVfsUhBxyQmxb6LXH38VKV3q
         wFI3mS9Orl5UeAEMspH2ZfLMklqmNROoc3CSxg+bZ/AxFNbU1uuv+tMptOTusM3qKCKA
         ZLtI7oMsGSlqsQt+oA/62pljashFZ3MbxWvp8X5POz8WhriOfIgNgOxssit4yzIE0+O2
         LvKw==
X-Forwarded-Encrypted: i=1; AJvYcCUkYA+kwTsA4hHJupilJIkWNnBxacW9Nt2D+Fo4Ur/i3gQPwruxQjh6vWvbfb3Q75SlwgOJmzEPZw9pbWWqTc/FMotd@vger.kernel.org, AJvYcCVC8KifKmHtDAzSRhxE4PMGxAbZRzMIfVEqK8FzG7kRsKTetF9MVpvn7Bax9CokwozB8NQiLE3+3A3rAZpu@vger.kernel.org, AJvYcCWeXtn3KiC1lHNGShcB8cOWr+cRxEgVdtiN2kuXVgFhHw4JJakcjpj/7Fiya+Den+F2MKo=@vger.kernel.org, AJvYcCWijPYK6eYejEYWK+X7oajN+sbYx16Ev/pySlBimail2jFIAUcu4T9zleSlYf+fVjjZN3muxTjBjkztrgUgGD4Dqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp0rmceCMk0jOIF7/gI/yBjADGifaVfPxhplkWWc1kKIfKmDXk
	31zYY09JzgSUcmFwz2J4FmIqILJgrUAd2kJjsA3XQgtSCqpfax3+l8iQle2yPLDNc4Xwom/bF6m
	KW1qf9xAKitjFhKcVSJ+t7/r3ssY=
X-Google-Smtp-Source: AGHT+IE2ZM5M+/QVnQkT/2SITUnPd+KQkWFrXXxbnQiWQFjfVwQ66uPXYqYvfsYfOwELDaMn5VH6AKPQvNeVlz9XfYk=
X-Received: by 2002:a17:90a:c708:b0:2e2:b64e:f501 with SMTP id
 98e67ed59e1d1-2e2f0d7f1fbmr4355634a91.30.1728675257506; Fri, 11 Oct 2024
 12:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815014629.2685155-1-liaochang1@huawei.com>
 <cfa88a34-617b-9a24-a648-55262a4e8a4c@huawei.com> <20240915151803.GD27726@redhat.com>
 <c5765c03-a584-3527-8ca4-54b646f49433@huawei.com>
In-Reply-To: <c5765c03-a584-3527-8ca4-54b646f49433@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 11 Oct 2024 12:34:05 -0700
Message-ID: <CAEf4BzbWLf3K4C7GT58nXZ0FJfnoeCdLeRvKtwA76oM9Jdm7jg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] uprobes: Improve scalability by reducing the
 contention on siglock
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 7:05=E2=80=AFPM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
> Hi, Peter and Masami
>
> I look forward to your inputs on these series. Andrii has proven they are
> hepful for uprobe scalability.
>
> Thanks.
>
> =E5=9C=A8 2024/9/15 23:18, Oleg Nesterov =E5=86=99=E9=81=93:
> > Hi Liao,
> >
> > On 09/14, Liao, Chang wrote:
> >>
> >> Hi, Oleg
> >>
> >> Kindly ping.
> >>
> >> This series have been pending for a month. Is thre any issue I overloo=
k?
> >
> > Well, I have already acked both patches.
> >
> > Please resend them to Peter/Masami, with my acks included.
> >

Hey Liao,

I didn't see v4 from you for this patch set with Oleg's acks. Did you
get a chance to rebase, add acks, and send the latest version?

> > Oleg.
> >
> >
>
> --
> BR
> Liao, Chang

