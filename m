Return-Path: <bpf+bounces-50844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABDDA2D39B
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 04:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BA2188E554
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 03:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8601714B7;
	Sat,  8 Feb 2025 03:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am9ztpYf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1340154C12
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738987099; cv=none; b=MiUrazkn160UX5BhBPU61cJ8sR80+U1nVZTJZlIhKSQXfJWqUef4JnPL+0CpKSHBP5tnUV1X+WY7WfUuhpasXSr+aXAmDwPOcoH2hq3B9/AIeGIw4AuOhfqn10Fi2tId294+HgI6NV9P4ShtNkhOD0ol8pL0Qe3bBVuEbV7AbAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738987099; c=relaxed/simple;
	bh=9ydkBYQByvoUUh4Atr5Phu7RE0xjfP71SGtZ22M1SNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQbK3yyrmTTdHOqOUKlGHjmy1BmZ41MPcXPI0trIgD7Vs8ihknH5KwNYGlniw56Hrkfj7mkJqwmsqwzPRjIdq7gCSpJnVP3GW7axnUyBOVWmEqeLlEGujC5bNq/cklKt2UuG2oULZb8RgqYzViAq9+4CS5OKZIzkLwL0FXpuyP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Am9ztpYf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso870835e9.3
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 19:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738987096; x=1739591896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ydkBYQByvoUUh4Atr5Phu7RE0xjfP71SGtZ22M1SNQ=;
        b=Am9ztpYf+ElEe4VFpNMjKlsk6vcxW09K2WdpDEj3KVXS5eimjUeDzdlTxiz98VlVPK
         Ls9Ww5ktWoV/HvgXwaDQ4uDiXtwvkE1OyUNaaKD0KDbtUSRtzCEDaf9P97dTBaf4OQgp
         3xVnTWn1M4RFYXCt1QoTCkrsgeoQmNIOwWZVEn5cDhCy9d/Nd7vHBEhzd3UKy13Vm2pb
         ySk0aQOIcSbjLhDqXPCFEQ3wbBPVtAhYFjFsFmWpJv25ZuoJRsb3dWm2qyQUBkDi49Hf
         9oB7JIKbnhOudtvkyBmxyWO/ZqRGKjMqrYXV8tXbH5WXPDA2v94stH8TUsKqZEZeca3A
         VYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738987096; x=1739591896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ydkBYQByvoUUh4Atr5Phu7RE0xjfP71SGtZ22M1SNQ=;
        b=eHH8KiWe0XQWW3ak06qOONDCiVQPIHm0MWxNK7zVQKXxUpU8KqpFJ8ce0KVJBxE9/Q
         f9h7y7b25dxN7G3HEbELnGGLAIeGsY1U9MBaXIOR+s/OHrP0w3qtAP9ylrHAQObEhM4m
         59Krrla8pZf+U2h2FTVBSEWpz6W09g67Wi9iNh2Rk7mnD5rLmW7HJ9B7d0j/wezVxrkd
         9M6GeOyErUcYhi4oMUV8nKxTKkjetZutLnTlYH56CTZtTmYnkGKb7IvDesESBUw8ra0I
         TFtOT7cMmZxwLWV457nFN38mHnKdDNahKA1vqdy1zVdmeFSIGWclgT15q1ZSAoI9nv5G
         0QQw==
X-Gm-Message-State: AOJu0Yzf6SNzFK6NkXIJ/V89tRZGbXN0PnppxnWJMqna9O5j43lFkBOW
	obVnndkzWNh03rZlsIzqiy5gXgr2nmbg3aQRK1PaiCLeQqm5wvAHhA0cSwZyhD8kMxQ5UDeLSdL
	EMU0B/hl8y3NuUZyPNW5FyRwRzUusfQ==
X-Gm-Gg: ASbGncvfRD6QfO2xWUtsUw6WE4yAjSzq+rmAoRwQtx2ISXrGB3wUeqCoYRxA8ql3PMW
	Ru1K+1B71vegJZaT96HM+EKAhHB6OiJSGqS3amtRiUbFjCiKu4FPsHvcM2Z+lNyDVuqsaHF8jte
	+3I0hQtFVrlVMhHZwZZKJ7b7jkE8hd
X-Google-Smtp-Source: AGHT+IHG9+19zIyKmeHokFcVV2KDLIFNUwfKfvvVLKwnHeNzuUqTVS0hX2S31ijcxrRM/sEF83mHv3Lo/VJguWKeuc4=
X-Received: by 2002:a05:600c:384c:b0:434:fddf:5c0c with SMTP id
 5b1f17b1804b1-4392497d1d9mr54525885e9.4.1738987095805; Fri, 07 Feb 2025
 19:58:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
In-Reply-To: <CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 19:58:04 -0800
X-Gm-Features: AWEUYZnczxhLxbuo9CUMhEgfuwnnwvqUAMb6_Y20gP6Qmocr6yuiIDBB9a9_KJ4
Message-ID: <CAADnVQ+FJA6jBRxCagAR6GuW0uRysfmgCnGk=ym1-rV0DPHPJg@mail.gmail.com>
Subject: Re: Poor performance of bpf_map_update_elem() for BPF_MAP_TYPE_HASH_OF_MAPS
 / BPF_MAP_TYPE_ARRAY_OF_MAPS
To: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Cc: bpf <bpf@vger.kernel.org>, Jelle van der Beek <jelle@superluminal.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 4:58=E2=80=AFAM Ritesh Oedayrajsingh Varma
<ritesh@superluminal.eu> wrote:
>
> Given this, while it's not possible to remove the wait entirely
> without breaking user space, I was wondering if it would be
> possible/acceptable to add a way to opt-out of this behavior for
> programs like ours that don't care about this. One way to do so could
> be to add an additional flag to the BPF_MAP_CREATE flags, perhaps
> something like BPF_F_INNER_MAP_NO_SYNC.

Sounds reasonable.
The flag name is a bit cryptic, BPF_F_UPDATE_INNER_MAP_NO_WAIT
is a bit more explicit, but I'm not sure whether it's better.

Also have you considered a batched update? There will be
only one sync_rcu() for the whole batch.

