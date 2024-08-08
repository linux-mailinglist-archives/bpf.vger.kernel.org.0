Return-Path: <bpf+bounces-36692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4202394C331
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 19:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E994028861E
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401C191F71;
	Thu,  8 Aug 2024 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSi5xAjS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D9F190664;
	Thu,  8 Aug 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723136353; cv=none; b=qQ4543aAEMdwtgPTThHhMrlCPXqcKcwBLsiW/xBQnLjUzond4yJ6+f0AYIpqIyg/Jj1aMfkD6l0z79vNI9KvFSVL0pJhn2XfCceHVt6OHsi9iBKHNNaFQuD2tSy+Od5gboHzUA/JTU3n5gQ+ijyFN2FYChTKHVm0P7bemHcGvkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723136353; c=relaxed/simple;
	bh=ZEcRu9M0U8lrF6sjh10MGY1LZtxhAqyZouAeKbbk2Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SE5MRiecRySTRWidT0AVHu32/HizTnLiLo4RsaGLr6fWZpLeEbSFDUr21nwzmwYLWMpgK4MEjbPpS6eqA1kLQUkPy3i4UDug/qu9TjEOFniqEgOMYeHsv+Q0Bgv4+V0M4emhB4IYUuxJqJRkrJ1JX8GNhUwdZqYQfiKeQw9Jo38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSi5xAjS; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7aa7703cf08so907010a12.2;
        Thu, 08 Aug 2024 09:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723136351; x=1723741151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mLqZaHcqDdDn/XL9UZelYCNnkfC2PKNs3rbN3Rlu+s=;
        b=KSi5xAjSpOmkGioO4SDhfo1/csmUgxUjGps/co9mkrVfLOV1y9s5RAv01rsN16r4OU
         lXuiqARnFKcCeNypCNqz2nSU63MQgwxEmBM89m33jmMQw8F5ItZzSfSJ8sV87UdGaVWJ
         JDt6MHvSs+JsaaJKXsiKHqnbNHuOebR6NXNzNFYRqWv6jQZMHUogRs1gdmyQD1iQdkeM
         w4J1oa97974RRf+2jbLuiBggLdZ/6KM7T7sVzMLPwjcaWLEGaW64f9nRk7OflvejMTpy
         g+TtIk29OATo0U6BDdFAtAPz3RMUvUVYRQ3KXowiNZH0UI5apmAvZ2u6P7f8wfOvKLHR
         uRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723136351; x=1723741151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mLqZaHcqDdDn/XL9UZelYCNnkfC2PKNs3rbN3Rlu+s=;
        b=SjFjmcNzlWadfhlNYaSSX0CY3kflQ37T9rfNjGZFlHyWVYikxkMKac3LTEMH4PEnff
         7+dAJ8glNMG45rCzLv2t8atesOnkXWljnAgFvmfNJT/YwW/vUf2pd5yO5pEQ6fNqpVQZ
         gTYXBHrAHFlsTh23qUD5aYzIIIJ87iSBYsmanxw85gQef/VzVf8kEqml/gVPGiaaymew
         sw+BaI213UE7ENA3+NR17fS+3x5zX2+TP/HxbY75iPqJUgnsvmWOvuVq5t+JM+bagC3s
         qs+g5ZoHsXi9vNmZ8Is6CIy8oBlPqVkEPwhsaXAxH5SX9zmbDhQPQs2vDqigqfLT2iZ9
         oVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSTmvafydRPAFNB/dCGzxUH3Ztf1UdKCzTOasV5FfBUPBReq6eCjC5X6wU1qaTdfhJGeRS3djyGAhqe+ZKW/J4ErLh7T8CXdqiRbbkttMLnIwQssoBmg4cIDyYR2htI9UYLYMvG7bCvSQ7W1UetCR+3LqfgJhsoYvKoFINo5ThbbeSO1Uo
X-Gm-Message-State: AOJu0YykZxghveV9IKaiJ2csxtl/GGI2TpNR6vCNNeG6dzdTgJjmkSyn
	WifIdM5m6MCEone/Tkr2S5YZ1QnWfSBqxcL949MNUH2J/rP+dXNdXvY4nS1WCbdw5XCAEfRSEhm
	YuHTs3xZDjGU88/7nBH4RCQfBTS0=
X-Google-Smtp-Source: AGHT+IGCpqc2a/tno3I0zEBBlKhTkWOcYinjgc1/TOSQ8bvmnEM78//GUBDS2+UDaVvSBpXab+dnz0agW2rMFNSUAGI=
X-Received: by 2002:a17:90a:a407:b0:2d1:530:ba47 with SMTP id
 98e67ed59e1d1-2d1c3465ce5mr2895558a91.32.1723136351299; Thu, 08 Aug 2024
 09:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808002118.918105-1-andrii@kernel.org> <20240808002118.918105-3-andrii@kernel.org>
 <20240808102022.GB8020@redhat.com>
In-Reply-To: <20240808102022.GB8020@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 8 Aug 2024 09:58:59 -0700
Message-ID: <CAEf4BzbAGZ7k=tZercsasGhe8JiOhXnR4e9JbcCKwMCkCXA-UQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] uprobes: protected uprobe lifetime with SRCU
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 3:20=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 08/07, Andrii Nakryiko wrote:
> >
> >  struct uprobe {
> > -     struct rb_node          rb_node;        /* node in the rb tree */
> > +     union {
> > +             struct rb_node          rb_node;        /* node in the rb=
 tree */
> > +             struct rcu_head         rcu;            /* mutually exclu=
sive with rb_node */
>
> Andrii, I am sorry.
>
> I suggested this in reply to 3/8 before I read
> [PATCH 7/8] uprobes: perform lockless SRCU-protected uprobes_tree lookup
>
> I have no idea if rb_erase() is rcu-safe or not, but this union certainly
> doesn't look right if we use rb_find_rcu/etc.
>

Ah, because put_uprobe() might be fast enough to remove uprobe from
the tree, process delayed_uprobe_remove() and then enqueue
uprobe_free_rcu() callback (which would use rcu field here,
overwriting rb_node), while we are still doing a lockless lookup,
finding this overwritten rb_node . Good catch, if that's the case (and
I'm testing all this right now), then it's an easy fix.

It would also explain why I initially didn't get any crashes for
lockless RB-tree lookup with uprobe-stress (I was really surprised
that I "missed" the crash initially).

Thanks!


> Yes, this version doesn't include the SRCU-protected uprobes_tree changes=
,
> but still...
>
> Oleg.
>

