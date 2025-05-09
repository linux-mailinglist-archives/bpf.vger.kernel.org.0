Return-Path: <bpf+bounces-57952-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7600BAB1F5F
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 23:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA7F1C462FB
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DA82609E9;
	Fri,  9 May 2025 21:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9gLSumS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C8825FA24;
	Fri,  9 May 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746827392; cv=none; b=lFMFZx5lZbl7LtUgm5GFngyBM2TGq34iYrFy8QjCXis5sk5CIj6CRjUovG6Ve7z6iHw9MIy5QYXCKC6kcfQTy8pSjsz9vlWWddxC+e+1plF/N151UhAg3LGOWAeg67wr4M8R/lCtQD+0pGU9/hb00PnU0vGmBRb02Idb7hJW3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746827392; c=relaxed/simple;
	bh=ZinlNdkiyCNzwk3CZlDqG9cAdnhvkAgo9icgRAJn/rU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+urO5OB2IN4cYa4I4F1FId25DUnpn5mrmTDgOrmhjHZ1xLqNgnTdObotKyPngjXX3AOI+A72fRxK88QMuUL/6siwjvIM4QsfzWVO2kUz9LnrNubMhDAY5UpihPkrWFeY/JcraeBdamFsUT/5dVj5nWDaLNYYIJpippMTbDLXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9gLSumS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3733933b3a.2;
        Fri, 09 May 2025 14:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746827390; x=1747432190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/U9lcKW0lXABVXy+mgpMzNoe/NTD2evxfu2sRExNzas=;
        b=L9gLSumSx0yIxUYbgEy1stex4IDy6WP+DJVbK/+vJ+R16cxCA/gC86FHIz+/ocy3wW
         WRL6lfia1kWLvI4ZDVDZMCNGhlfpveRJezzEMOdSbLEeixbAFijAB8jSV0gxcA63ZLMc
         rz3eK2howQtwj6o1+bYDdtXHNdj4bvnCvaeUR5sphp0reZErAHwm21jtu9q9hTE3izqY
         2nZoMyeVk3Jslh1jICwDZWlpmUELz/nsIV66tr45ogFdTaKl68qmL8Sh3A0pQCRHkUCn
         W9If5YXJJogYEdN2Q7UWHSOK5B9nrsBTiOtGTqngqPCKC3qwkV7mtF2Tc/K6gUrLn8E0
         MdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746827390; x=1747432190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/U9lcKW0lXABVXy+mgpMzNoe/NTD2evxfu2sRExNzas=;
        b=BRJ2SWI6Qlr/eljl0TLC2Lo93rafNwqaY1bYhljGCMo2u/gh5/fU5ij26WBjj34PUv
         OAP5J31Bu/8RI54doMk0juTgkJOWhGAXIX9pvd1JMjVolGeTjdVVslqA0KJ38OKR+gjw
         qYF3Ix2plsIlGU2+JC3Iw0YqOCIF8SPPQr28tdGcAgJ5eJzfzebqlVXeP+dkCS3XcKlD
         FLwE0G7HE0WmE2nEVx6kyvsEBmDbXMPmY83+us7tU5wSPk8odV0BgJUF+8ve392mZKqO
         rVe44eXXw0n83Y27q9J4vR6oZiKacVdazI/Bt/1dkZbyZqT97xjEsWzlY+YghZP4MlSj
         uP8A==
X-Forwarded-Encrypted: i=1; AJvYcCV0DEgm8962/El4StREmG/7F28b/vg8wN+bPkBlUyrzB6nqJMcfIubj/ck/pivKLlSrYeQ=@vger.kernel.org, AJvYcCVtBn9NbUeyg/t/LfyNyRW9OebKddzRzqW+sAX7WDkLkWmzNjOutgNb67QJBf06Ds2QZ+ml9VeycihbeAmuf80BMTVS@vger.kernel.org
X-Gm-Message-State: AOJu0YyAN5urKOOHG8EXGXTk32b0MaWjpxZZfT1mFywDd0oiFXzBmJrs
	ILPPA40svyNgwEXFiDHiKj53F4H6s4KjOx+iFTXTU+731AvPew8OErPr22wcW83tCU1pMapjITR
	MLgKOzynqpP17ontc2xF0DsUSYK/NqhDx
X-Gm-Gg: ASbGncsxzrLSK/s3+ckxG9TcigRsPouIgLmvGc6KxnYFtr6gvJ7/YDxrR9aToqPdMNm
	5tXOwF0OB9mh0Y6dAb3M+IJy9ffoAz9WkHE7jC6nKwM6vQtnz6oaqY0SeXczUiirmgjmtwPj7Xp
	EMFOpFoYW3Ch/oXHsRYjH28If1+x53SxMrCCKSrBfPNBenOeOBNvE5k6Rk2x0=
X-Google-Smtp-Source: AGHT+IHPkwZR/8rn5sjyBGB0IOcQSZZ0Evw9rc/ZNuaIe7vZL0Xarx0Fw1QKpg7ximsYUdfxO7khqTgJocYUArU4xsI=
X-Received: by 2002:a05:6a21:3182:b0:1f5:8a1d:3904 with SMTP id
 adf61e73a8af0-215abace343mr8147447637.7.1746827389935; Fri, 09 May 2025
 14:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509164524.448387100@goodmis.org> <20250509165155.628873521@goodmis.org>
In-Reply-To: <20250509165155.628873521@goodmis.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 May 2025 14:49:37 -0700
X-Gm-Features: ATxdqUEPWK1bzutKtWy6yxNmKdLWMZCU9skVB9Dn5IFiwho3pByZS297XPGSPQI
Message-ID: <CAEf4Bzb7MCv87ZEPXvH7APk9yvmtCWvuUO5ShEaLvz_DLfNqpw@mail.gmail.com>
Subject: Re: [PATCH v8 12/18] unwind deferred: Use SRCU unwind_deferred_task_work()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 9:54=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Instead of using the callback_mutex to protect the link list of callbacks
> in unwind_deferred_task_work(), use SRCU instead. This gets called every
> time a task exits that has to record a stack trace that was requested.
> This can happen for many tasks on several CPUs at the same time. A mutex
> is a bottleneck and can cause a bit of contention and slow down performan=
ce.
>
> As the callbacks themselves are allowed to sleep, regular RCU can not be
> used to protect the list. Instead use SRCU, as that still allows the
> callbacks to sleep and the list can be read without needing to hold the
> callback_mutex.
>
> Link: https://lore.kernel.org/all/ca9bd83a-6c80-4ee0-a83c-224b9d60b755@ef=
ficios.com/
>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/unwind/deferred.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> index 7ae0bec5b36a..5d6976ee648f 100644
> --- a/kernel/unwind/deferred.c
> +++ b/kernel/unwind/deferred.c
> @@ -13,10 +13,11 @@
>
>  #define UNWIND_MAX_ENTRIES 512
>
> -/* Guards adding to and reading the list of callbacks */
> +/* Guards adding to or removing from the list of callbacks */
>  static DEFINE_MUTEX(callback_mutex);
>  static LIST_HEAD(callbacks);
>  static unsigned long unwind_mask;
> +DEFINE_STATIC_SRCU(unwind_srcu);
>
>  /*
>   * Read the task context timestamp, if this is the first caller then
> @@ -108,6 +109,7 @@ static void unwind_deferred_task_work(struct callback=
_head *head)
>         struct unwind_work *work;
>         u64 timestamp;
>         struct task_struct *task =3D current;
> +       int idx;
>
>         if (WARN_ON_ONCE(!info->pending))
>                 return;
> @@ -133,13 +135,15 @@ static void unwind_deferred_task_work(struct callba=
ck_head *head)
>
>         timestamp =3D info->timestamp;
>
> -       guard(mutex)(&callback_mutex);
> -       list_for_each_entry(work, &callbacks, list) {
> +       idx =3D srcu_read_lock(&unwind_srcu);

nit: you could have used guard(srcu)(&unwind_srcu) ?

> +       list_for_each_entry_srcu(work, &callbacks, list,
> +                                srcu_read_lock_held(&unwind_srcu)) {
>                 if (task->unwind_mask & (1UL << work->bit)) {
>                         work->func(work, &trace, timestamp);
>                         clear_bit(work->bit, &current->unwind_mask);
>                 }
>         }
> +       srcu_read_unlock(&unwind_srcu, idx);
>  }
>
>  static int unwind_deferred_request_nmi(struct unwind_work *work, u64 *ti=
mestamp)

[...]

