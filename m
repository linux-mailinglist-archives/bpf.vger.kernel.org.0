Return-Path: <bpf+bounces-78407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA53D0C658
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 22:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B4263005BB7
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 21:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B9533F392;
	Fri,  9 Jan 2026 21:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0g6DY/3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992E33EB0B
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767995688; cv=none; b=Whb8AdkZ+RM+djCPkuKW7NONGFWdXAxPrTlmp5BQ6IKy7tg4FZPAjgtXqIt7BPhuTRmE6QNCFwRNBuZ0YBa9+/o1pfewPxW0OryARKVlSI/k6NSVvfQlSCGPGrgGvH0U7fVmsCEkheSDUtxbr6JQYDCmmQ6ZbIkr9TE9LnWrOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767995688; c=relaxed/simple;
	bh=SyDIWAo0tBvOlQkzTsioGpGAoFU46xUIN8egUPSsTAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuifeIG2xXrVvMKmj7p0zDcPBt4lbH5yfXOl8yS4UdWN3268hla4eeHtQxaMWyQEWfYeA9X6d3t37EhBljR59JijHjnpF1Zww6ctANnFmhHHWvpW7C4uxHv9fq69qQ251xR1cQhOCGRjXdPE04mkYnPEKz+SPdv/2mvHDytjd4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0g6DY/3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so1633019f8f.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 13:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767995685; x=1768600485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVAFv8E90nuSwTqKxRgnODazUOEjPtiM1PD2YijofnQ=;
        b=D0g6DY/3wtCyvp/Gf0LO22FxthxTddH9B0/0kRqrLwXA3kvpeMrHam+Qejs9zAx1PS
         lLdrlHbATh2+5etRjYaApirPXaOg4CqVKWo4AWEEt2z3y+zXRE+WjXeoYNQW+xXAtB1f
         lsfPiGt4j2W1GJbYKRnlQnFEbs0YrmvMKcZYwsbWuvtXHbxQtrso+vt7UnPgecYLfg1O
         6iKGjP3WvMH16sity4HUszas2d+vjmeGMU2aILSSJX0JXK2HD/fQ6+dWEsVPaeDWAOAE
         oIUGvdf1H6Lr1kWLQKDmMMlfHPNz9PC1l+JKJtTommqh2+M4aUdfUJnAejAw4lnDTOqO
         Pe4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767995685; x=1768600485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVAFv8E90nuSwTqKxRgnODazUOEjPtiM1PD2YijofnQ=;
        b=nDiUwxVxLXhELyDBJQpG1vLilnSgmgcZPfwAqsRFEBKBso2a1+jFmKkD0TjCRHJdqQ
         mzcHW16ymTH1kobr3draXVnIWODQmr4+e26RROEqFc4FCSEQlVIbscNh32I/am64TRdq
         moYPuh6VrR56xaJGV5Wb7QOgPlymZdFFg+GnPIYJ6S/XXU59/YbHgo/QXv1YgNDcda8f
         oQ/CZchnA3Efq8XcVNC7CptDPr6RoKs0JXUNtiWT8P/0CsbPaK3Aayx6H+fi4Pka3JOH
         KJvFyUQOgWIzCdQO4Vao2xmGuLZoGiDxg4Wgf4nIUlafQT2FyPpXtDZRtRtzThk0TziK
         A91w==
X-Forwarded-Encrypted: i=1; AJvYcCVCO3LewVEVSuZEbk1EiH5ogimvuMzW6jinyxsqKeiLLW8Tb/etV8uVdaJaaPYuWAVJuM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGWac5xyrAZpIrfUuaoqKcFntUSvGfm/ITuANv5O+3XcAI5ol
	YcHmvr9G+I2vqKXlNfGHTgNyNAhtyZeYGquFbw6hLziNXlPzE+RPGhxVVg6hQYF1ERUWGbibp6s
	6q+geLuEfAcmrhCcFI6+WMzJKmWQOeuszrg==
X-Gm-Gg: AY/fxX7+jv9WxcVltJpeuXbnaoHDWQem2hH5cti8wDXzB54AWquaSdCMy/J4vgHtQee
	aYuR5jJcU4rcWs4npRqe55yE+zCQaC2V7/JzgZQe2YhiC/yVPC9SZWo3AATKcU1GVlJK8C0GygP
	DeNt76Hr8fYDlDLsQqw5EiHtIvOoqki9ybjFjuFeBN+oXNh+3VAxI+eVP4Cga9sH1kPlIZrcESJ
	yS7ZuZeZxq2+63Joh0gNdRWMoe9zLepevkaqHOJLFwY/SzsdExq/eJ3gk1QNx1JWR3NddL9ksju
	O74m2thAHDTTrMyY9eCrFUn+63gV
X-Google-Smtp-Source: AGHT+IG51RWpvxWbJijZnqsewtYtgtXdOCi2ZMsxFXQVmXp52Ns/wca2BEkmDyNH6PdrUAOuSauZw7OBjggY3NBoASo=
X-Received: by 2002:a05:6000:18a7:b0:430:ff81:296c with SMTP id
 ffacd0b85a97d-432c37983f5mr12201224f8f.34.1767995685071; Fri, 09 Jan 2026
 13:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home> <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
In-Reply-To: <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 13:54:34 -0800
X-Gm-Features: AZwV_Qh4smiERtW1bxrkxiHXol6EIjr5MaZya9ZuXLg6cgDa8X3XSY9z9aVSQwI
Message-ID: <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 12:21=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>
> * preempt disable/enable pair:                                     1.1 ns
> * srcu-fast lock/unlock:                                           1.5 ns
>
> CONFIG_RCU_REF_SCALE_TEST=3Dy
> * migrate disable/enable pair:                                     3.0 ns

.. and you're arguing that 3ns vs 1ns difference is so important
for your out-of-tree tracer that in-tree tracers need to do
some workarounds?! wtf

