Return-Path: <bpf+bounces-31268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 503E78FA57C
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 00:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1DA1F23DEA
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 22:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB1C13C9CF;
	Mon,  3 Jun 2024 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NvlNM94t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AD513C67C
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453450; cv=none; b=DixhxE6/79TF2HDXlDfhKmuUs8XtTtuaNPXYYldT8Lmx7/URTqyMGH6WPAeWgPnlr9XtB8SPBa4cbOk4Qn8uZE6x+jiIz6GTyDvr0Ax8HF14whmvGcnHsgGhTmkiPoVQD6RDnPF5etUmYJ0hfX318tSa3Imz0b9U0C5NoigycHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453450; c=relaxed/simple;
	bh=AFfU/PEC+zuhNdQ2tMeUL2Lz6Nhx2hQNDlZEumLFtHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCWp3SsjT/MIaeIkKoIBJpGPShTSfArdaDgE+Fywx/571UKEbu/4goureipv5JVRf58FuCHcVoUls0LDwTphnJViS5WLVlubZDu5gRaaDy9lmhet+cLzPy6fOMb/67Ye+oWICdtJYF+0Rhlw2KMKe6Ed8g5N+N1LVsGvg8tneQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NvlNM94t; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a677d3d79so2237656a12.1
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717453447; x=1718058247; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=NvlNM94t6sll7sF2XotPG849RkvwqA2mzJ7yLghmdoWCe/+h99vmOGCGjvSseh3s6r
         S/GfB/Qh0OaiI3bRW58c5ghzkxxojQrnJFc064N7uvD/XG7B0PItbqmuoTwHykQXxJCr
         +nEcQxl8fJ8V30NsnGDoJNRo9gdlJTmDzbEkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717453447; x=1718058247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vUfCTj7RhneZiyZGwU4My8ep0xDaKOVngko5RyaH/ts=;
        b=n8uIYw2DPbWxTiev7YZ64H9JHxIQySPqMbhj5eZDmr0/uRlS+qh1D9xJUGO1clHKl5
         0RVnYSPV1MhtW2++pC/dajrNyFhDNt2aXf4DD+MeHGaIOjE5Nj5aF3vM5EFiaaTxLNK4
         QMv+euMGjOza6sYGh/DqGaGYsQFfXdiuVfyDLpIJsewXvzkc4evK0EfgMyn7MSP/eIIH
         duRcJiBCKp06UnwwWBsz44LUflFSun8fo0mr07tUCZN5AuOAQHfGVatve1bzc4TSrTEe
         SnkHbzGq0JK4G26eo7JT2ei8OYwn9bX6yL2jNVaCcDPtSjuhS/w9k0xu9qk7KBPZjMXl
         myQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu/3hjmYe37+GEw5hNf1z4Qkdo7hsRuA2I9RZJwJhWKE4SxGCwQJYeVJ3dubdorggzAJq1ONg5H/X1O1IPDfu/n+hf
X-Gm-Message-State: AOJu0YzA0o4qY8+JTScqMAKKQ/b4ExHHSqTtUboQK/VBQ3h+qLR871QZ
	3YyA/TqcZtEY4y8ZY2jjmVQkQ1dhfZeBwKeIeU6Dgf1ZjWred9/MDQSHHGbZUcypNrpp5//DzOE
	SDAHmaA==
X-Google-Smtp-Source: AGHT+IFc9CaO0KBqr/KxG2DgwNKME1AU5/R4szniW03BwHoRYHElkQkJDz7VkzmIt4jKxZuGeuboag==
X-Received: by 2002:a50:8e4d:0:b0:578:5f47:145a with SMTP id 4fb4d7f45d1cf-57a7a68a7ecmr713629a12.4.1717453446805;
        Mon, 03 Jun 2024 15:24:06 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5e84ca96sm3016674a12.39.2024.06.03.15.24.05
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a68ca4d6545so380648366b.0
        for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 15:24:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX45SGW8QpH4IorB/cM1Uxh6tBbAgmR4wruQMYqvmRvAleqb8vyl5JCWTBeBaohD1DdQVrCrsgriz0QK5sJlUAVa5AQ
X-Received: by 2002:a17:906:d217:b0:a62:49ae:cd7b with SMTP id
 a640c23a62f3a-a69543e118emr67505166b.24.1717453445163; Mon, 03 Jun 2024
 15:24:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240602023754.25443-1-laoar.shao@gmail.com> <20240602023754.25443-3-laoar.shao@gmail.com>
 <20240603172008.19ba98ff@gandalf.local.home> <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
 <20240603181943.09a539aa@gandalf.local.home>
In-Reply-To: <20240603181943.09a539aa@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Jun 2024 15:23:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Message-ID: <CAHk-=wgDWUpz2LG5KEztbg-S87N9GjPf5Tv2CVFbxKJJ0uwfSQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Jun 2024 at 15:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> The logic behind __string() and __assign_str() will always add a NUL
> character.

Ok. But then you still end up with the issue that now the profiles are
different, and you have a 8-byte pointer to dynamically allocated
memory instead of just the simpler comm[TASK_COMM_LEN].

Is that actually a good idea for tracing?

We're trying to fix the core code to be cleaner for places that may
actually *care* (like 'ps').

Would we really want to touch this part of tracing?

            Linus

