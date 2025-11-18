Return-Path: <bpf+bounces-74914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDE6C67BC4
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 07:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 688D1361062
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 06:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12E22E9726;
	Tue, 18 Nov 2025 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnZEUEZD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB92E888C
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 06:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763447479; cv=none; b=FpiIHEcbuKMXujx4+bh+RxwLk0JO/vKqGQ8PPzP6QziElQFaKh4tb1sROqBOL62tevBllJHWfvNroeMt3RuNBzKb0vXSWet1L0i+GoxGAxcrelSJv8DDcyrwUknf5bWsNtnnFF4GfOJCrDUx3sTZlgBVbTmYbWKhkLFIL4DmOwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763447479; c=relaxed/simple;
	bh=v/1V4FhGYwFvd0ghCES2IvC9t7tV0hPLG7pnd7gN8Eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ljlR0bZGel08zyvUcwEzY+wX7FQN/uo73KBFW/sH1tf5yyvm66jJcMnyNojyvOXMzp+Af1LRhYtRCeCt93KCzuzL4BbpD+XPBxK8TMsyN8bIsVDVHYWQ7vGGpSxzOYXVbXtZR//goONvUpAUQTSiALqzDymdl7nSdh0ujAihU6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnZEUEZD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b3720e58eso4718780f8f.3
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 22:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763447476; x=1764052276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/1V4FhGYwFvd0ghCES2IvC9t7tV0hPLG7pnd7gN8Eo=;
        b=hnZEUEZDWELi5O9t85T9ug/VC1sKKC/jsq0202LWBcbv6USmpVBVuvyXIO5dlXO3u8
         w3ZZ9dZKMn6mhIKcdDNNry4zJIGDC/SuKipx/bUCahJq8Ev7EJkPnMXAcm9CaSP9acSb
         2rGCyXjCY9iSgHR5lx2tmHUCMuEAw7Fglh9xPc2gqLiyuuWhXUulOk/g+5N4XKmXHYu2
         FJnzRnfzXY05tU2YnN2rLV6TvORB+UThMUgc0PLOXy+mfUX7BgUuLLqKT887VlnLdOlb
         5jCfC0NB71YxuBNB5E4v+K4UBcKnr16EOuYvKDFx0xjQJq/MIq/TyM9kh22R33OiYNb3
         Nneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763447476; x=1764052276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v/1V4FhGYwFvd0ghCES2IvC9t7tV0hPLG7pnd7gN8Eo=;
        b=maqcVwpMEVEJgWBs8BCTH4CaMpCHYF1NklahbB90/VFYPwbpV7xw7TgTqVhn/dInEj
         ERip+fGu03HRyb0wZbs1xOzK068ZL6xUNQJRTjwnLDTi+mOgcRBbOaeURkk/cnNLUI+k
         rQ7FmxaiZwPwJUgD2ESGBLQIrGF4KG4ftMxIpaCeikJFZwJ68ZLBzlOWG+Yf0M+NaGL4
         6WJofKzEoLccQ2aFGT5l0Rki3eZqM+ThUsc5/6y+rDzSk7t/STUysd9RIyg/81ebnjiP
         ZhQTkaAuu5gowMEIj6EHs4QYaBBy/ggKxG52T6rS/HCrkT5ucFKMfnBDQ0eCjYUnxvCo
         Wn8g==
X-Forwarded-Encrypted: i=1; AJvYcCXiDmDO/t9N0meTNGtfUMApznLgH+dLVTH+/OBKt7Bg05vPYXDwA/DPKjEblCmBxaP8pA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNwsYN9rVo2JMJvURP1FHzV0Ym3aUlOfO+9bZqr59Xj9cfjcwg
	tMogjq5eTq5ky46hzWkzcbb6Ft4+Vc6MCVfTRj48/7GgQCXaxaGtogOTCKdZCOIwConaEsQ+wqm
	LnR5XPvepcfv1NLjdWbuYm3EQrQsj+Hg=
X-Gm-Gg: ASbGncuM6RfutrAkGnSobbKuH9lWVypqbvf3vetBQEspi20AlZfiLiSHAwAxdroL/WL
	LEhXqSvIrJdI6YdrOG2pFb//Mvk0JhiXGh9IL0J7IwB2BmQGA7L/AuGmGzJEodbK4dKhtg/tvxB
	IMEn5VOYA8U4fp1RFAmr7lPV2xT8tGRJM0P1ONfSBMwW9HxVRPjEZGHtZd4DuE3Hr9pRJaq7qX9
	8G7IXvU4P5AIpLcfmZTTmYS5oeA8rZA7xSVd6ypxOh90lqWXVW0SVeGQP/7g5awuklRR6jiq1UA
	4GXZ/pgs
X-Google-Smtp-Source: AGHT+IGiQzEDuoP5/rQBelcFnteNemSmme2hOWV/uNK3bvOOTlSp/xZ35k8FaSnpPlQ/PLq6l7FQrN2IuidjCSTCpf0=
X-Received: by 2002:a05:6000:2585:b0:426:ee08:8ea9 with SMTP id
 ffacd0b85a97d-42b593901d2mr14691038f8f.44.1763447475857; Mon, 17 Nov 2025
 22:31:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117034906.32036-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251117034906.32036-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Nov 2025 22:31:04 -0800
X-Gm-Features: AWmQ_blTs97dxxsdFXzsq82EUJxwRysJEJrBAyAw6Kd-0LrumGTqH-utJu4AKC4
Message-ID: <CAADnVQK5U28Wv2tSkymZY6ixCoUrSDoohB5wJmpyZL7t-Czk4w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/6] bpf trampoline support "jmp" mode
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 16, 2025 at 7:49=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, the bpf trampoline is called by the "call" instruction. However,
> it break the RSB and introduce extra overhead in x86_64 arch.

Please include performance numbers in the cover letter when you respin.

