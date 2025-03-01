Return-Path: <bpf+bounces-52960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 532D1A4A841
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 04:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8AC189B803
	for <lists+bpf@lfdr.de>; Sat,  1 Mar 2025 03:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD24189906;
	Sat,  1 Mar 2025 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjOqyzLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E51CD15
	for <bpf@vger.kernel.org>; Sat,  1 Mar 2025 03:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740799437; cv=none; b=DK7tW3bk+oneJnmPdWBi3DVwlXpaCZDCNRaDry5VjFuyAti98SquGiaf6TmX3KxBxHdHTNnK+nyuP5Git5lG3mVYU4kR1rmEDF1R2mR93eeVmEQo6+S9yVnBzPyUgKNV+hoXIjzsvUdXaaEyueldI26q6yd5YFnnpvU3O/5svCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740799437; c=relaxed/simple;
	bh=stj79gynK2WknEbZ9pVrkgUkxqE5FcBynz4M39CYl2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWkDlg715pxJmkunK7E3NWTlIyvxFnDLG8fcuzOoLiTO92Afj8TCiy+dQmxLQPpCxGyv4xJEJLBDE0oaSGLNs+V3ATbQmimK/lv/1VqT1PtZOGAtI5sE9zj1hAC/ud9juCC+6j6QPZWomCecdrEnwNpqC9S5yB3ANhkUAmu4mMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjOqyzLw; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5dca468c5e4so4680942a12.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 19:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740799433; x=1741404233; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7aU3EGnnXLRZun0Nhfd/zGWGTuf1st/asyEUd1CEU/8=;
        b=CjOqyzLwnPM1dn5tydmOohccTIom7xwUnwYn3OsNKoPt/j6OOI9dFlqgyVdA/NeGli
         BMYKRyfw9eNxvvOmznc19U6kYylqNqpULuqC2+nPRXSMrHzPqO0ZeAkd94nlK6iC0kDS
         HUaycLAwGsrSaOf/1wddYT83Rdy5Xe1NWfq6v4T+qGJYyqHx+MmVGnXsqJUt+fxDgca+
         GmF5xto7q5SgKwncQr2TVDZBuatjPLBPRlXPyV9sC1BIdyOEpJYN1BCBVr9pnAdXW7qQ
         ZCw5gfgpYjfk4juBGk6J//1q2HLNK9fx2zHn4Gud34KozJJKdb1AfRe4hL66epcBYkg+
         mRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740799433; x=1741404233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aU3EGnnXLRZun0Nhfd/zGWGTuf1st/asyEUd1CEU/8=;
        b=pJIA5NAptjhtCQAOPNkeO7BjGGCWChXGAqrHqq56UUOR6FjKml4hXbHz800kSowIaI
         N5RsUMExaX5U5bL8P7n0ObkLNcF68f6QH8Bp8By8kBwy9npl4eIq/ntcwoZC8P23xuMc
         uOjPzdixNms6kFt81YPqcCwdeB9zc64Sn0zP80TBBtjuEoSvxRulm3hZDKWlDH43OuyD
         kEDajAtPyN9PFrsITRM/n6YSPE8UL2MnZ4dwTDBfl3smm0QQDm2QjYhUju3uITkLc0l1
         5yTaI8Hp+PrNVFCoNq2GLL+ydDwt5VABUzuByjjHT07OKuwvyCT/hfLrPgAAnETBsuIG
         xuYg==
X-Gm-Message-State: AOJu0YxTx5YNf+cZKiwUxp9V0h2NhaEmBeWh9lv4Pf8Cq5H/odM7ayUA
	bnJFZ6peNb45JWo0DraE3a9tKdXk0vnZwUI9vrsp1Ib0RKuoCxHGfWrM3j3cK3ndVtDbXYGcoSn
	seepxnowD4uHH885b3A60LjbLEeGWfPfA/OA=
X-Gm-Gg: ASbGncu6+GeZqnyxgKGKV8hTT0RyGy+J0Que8fds24aeoJFVl1ItW/HATf3KM9Z1NO5
	tHnmHXv3b+OU8HW3f06mrwicv55O7hjI7OnDHz53xklrRCrLUNxC4mErqmkeJLHW57emY+Wrp07
	BaYK5G5uuj2TLjK5aumCThx8/kFgo=
X-Google-Smtp-Source: AGHT+IG5IuhcpgMNAl4GNDyVJkdvWEhjhGvAzOsuhjbFHRWGMi3FtzqcEmUtYxfegQbLo4RQCOOc0LkEEvjOeqPRKOQ=
X-Received: by 2002:a17:907:6d0f:b0:ab7:d481:212e with SMTP id
 a640c23a62f3a-abf25fa033dmr618368366b.12.1740799432745; Fri, 28 Feb 2025
 19:23:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301030205.1221223-1-memxor@gmail.com> <20250301030205.1221223-4-memxor@gmail.com>
In-Reply-To: <20250301030205.1221223-4-memxor@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 1 Mar 2025 04:22:00 +0100
X-Gm-Features: AQ5f1JrMFBdSIHZucC_KKXsjNpQ40IN1OmwGC1dUu3x3R_Q-cQKOXxvsApjxL8Q
Message-ID: <CAP01T753ATt=drhw7-QrPHzOZXNCd3XgK00dn_erZ--XFQii6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add tests for extending
 sleepable global subprogs
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Mar 2025 at 04:02, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Add tests for freplace behavior with the combination of sleepable
> and non-sleepable global subprogs. The changes_pkt_data selftest
> did all the hardwork, so simply rename it and include new support
> for more summarization tests for might_sleep bit.
>
> Sleepable extensions don't work yet, so add support but disable it for
> now, allow support to be tested once it's enabled (and ensure we will
> complain then).
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
> [...]
>
> +void test_summarization_freplace(void)
> +{
> +       struct {
> +               const char *main;
> +               const char *to_be_replaced;
> +               bool has_side_effect;
> +       } mains[2][4] = {
> +               {
> +                       { "main_changes_with_subprogs",         "changes_pkt_data",         true },
> +                       { "main_changes_with_subprogs",         "does_not_change_pkt_data", false },
> +                       { "main_changes",                       "main_changes",             true },
> +                       { "main_does_not_change",               "main_does_not_change",     false },
> +               },
> +               {
> +                       { "main_might_sleep_with_subprogs",     "might_sleep",              true },
> +                       { "main_might_sleep_with_subprogs",     "does_not_sleep",           false },
> +                       { "main_might_sleep",                   "might_sleep",              true },
> +                       { "main_does_not_sleep",                "does_not_sleep",           false },
> +               },

Sigh, I forgot to regen with git format-patch with the hunks fixing
this, it is obviously incorrect.
Let me resend again.

