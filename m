Return-Path: <bpf+bounces-44777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FD39C782C
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4D9282D8C
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1669C1632E3;
	Wed, 13 Nov 2024 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3X+cdqF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFED7E0E8
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513913; cv=none; b=KBLnlNGSHb+fjodgAfDvV5H1/Ev7ua7sO068VIVtcnDMNePX6GWUoxcopR8i/2QYgc6CkFGp5go72EAAXTRsu8fMzV2uxBOOJf6/k8Hi9HuoSzjy4OKyfr+N37E+XcV6sGu8y/oNxWmmT9Ey1bMB+4y0o+lk+DRNCYvu0DxtbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513913; c=relaxed/simple;
	bh=MX+czNIVd4fnQ2Z0xrVeOF22C96eAlYgIaZgA6nL5SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/NTqbXkFe16WaaPXmKh6z66UHq8pTTNUFatxNCDn+sA9FKJ2/J5nZGNZb4NRMNpj8WIn+Y9o2uZoUR76dR9abfN9z5Vu8D/Y5zzxqnMD7ayJxbODf5FGODrMs7RuzmLAFTysqoBZHMC1KIB2Cw4z8Lp1aHlckaIFBkPuN9DKso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3X+cdqF; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a9a977d6cc7so556672466b.3
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731513909; x=1732118709; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MX+czNIVd4fnQ2Z0xrVeOF22C96eAlYgIaZgA6nL5SA=;
        b=W3X+cdqFfwsl/8Bk6X+GtKt9jtgBqrPPsLPT76Mkdl54lzqF/qC0mH+2YlHhSmGP3s
         X423fvdlK5iImdv6Hj6knpG9xST3j77Lus1SPbPlw78Ja/b7BvdbdLZR0O2M+l/HmkwD
         99E8oIYEnx2f4jRqE2dJTqjhzMiOrFEjcLVSaKdQsh0Fiu2/3pJfn7Fb4M4IEGZhki+u
         Z9MFJbpG9bP5ujGTUoOPJ9Qdo+hFqM9Ge1mJ2ZXauMtlshxv4xQddEGA9VVmWGMwoWvq
         2JjZcc3rGMODr9H0TdL4rFRnIDcehAds/rTXL/uswVezWcN/yrATUeFhZTMf4DCf5ypa
         4w1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513909; x=1732118709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MX+czNIVd4fnQ2Z0xrVeOF22C96eAlYgIaZgA6nL5SA=;
        b=HNzA5hmTxmSgKcj/VRmTmrEGkJuDt36YkwrMzU0Daay8njO4qH0V9ymMCweGCsepX9
         9DrSQ3A2SFaHrQHP+dcYmDR1T0tF29SPL9kYbE221MurIn+AqQjT9EtfxTWZHhSkayT0
         k8ymgw7q/qPB4KEaAxTHlG71xpOe2ypE0K4KcSRzi8NtHi976cRDpUSDXElTQ3OwTz/+
         oNgit1Zqc29M8eWhmu7uYX1tieyt77zltT4d45O5LmCxEw5dO/KSxtmMvG6/QzlmMjoG
         KRNuyFlgcD1Meo9BHpagixRO92Ss13l/xjVZuONGjjwFTwpkrpKjFyxgCqcwdrw6GLSS
         Wwfg==
X-Gm-Message-State: AOJu0YzdvgFAQ9NM6Fcglb9YYgqZGlWZRvC+JNaEN6j+8XgBF1QQvScT
	VJCHAw5fwjT7r+9pYUZfFN3l9r/wW6EJ34NFy+Sw4BSZbilqEYcntHMu0U3/N7GBHPIPhp3M9o1
	ciEKpM4yF1kKX2gwZeVLBcZZyapo=
X-Google-Smtp-Source: AGHT+IHNKvUlwRHG0zq+80+RPV2MJKzTTPO+c6Rd6qX5q8N6c8enuOp6Y1dR3vO7KxbpmnpsX1dbnDTl56emOgNlz40=
X-Received: by 2002:a05:6402:4405:b0:5ce:d435:c26d with SMTP id
 4fb4d7f45d1cf-5cf0a3206ecmr25637850a12.19.1731513909038; Wed, 13 Nov 2024
 08:05:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108025616.17625-1-alexei.starovoitov@gmail.com> <20241108025616.17625-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20241108025616.17625-3-alexei.starovoitov@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 13 Nov 2024 17:04:32 +0100
Message-ID: <CAP01T77+gxNm54b-8cwbiKrgLE4UGsZEsvWkotEo122CcHFR3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test for arena range
 tree algorithm
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, eddyz87@gmail.com, djwong@kernel.org, 
	kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 03:56, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> Add a test that verifies specific behavior of arena range tree
> algorithm and just existing bif_alloc1 test due to use
> of global data in arena.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

