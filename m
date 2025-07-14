Return-Path: <bpf+bounces-63268-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CCEB04A14
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F7E4A5A00
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43227F003;
	Mon, 14 Jul 2025 22:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Irt7yPTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D927BF85;
	Mon, 14 Jul 2025 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530887; cv=none; b=Pzvn5UV803nJ0sVc4Xxjmf1/3EamzRrVJc2GDfPlwLbwq4bYfe9YeKoH75NZgHA6UosCBtktE6hPAQ/ayY8w/y7IYyJzHwijFSNnCUjX6A4pEVKL+rxaJGXUbzDwPY2vgxArEEat788IjKu0SdIJc/Qwd+r0d5ZMEPIZpsyoKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530887; c=relaxed/simple;
	bh=N5Be8q9PBGWygIOk4riF/ID11HWiB5/tkfdVywpPX98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdef8bIglxUkGb7JZshN/wEaM+f7y1M3oTetiURAVyQHPTNPEKp7EFRKbonZ6pSJx3UP2ii3Jk1TR5YOKdEI6NdrIdtpj+ezDBSbK02LwcVN8RPtrzW1Whe5byq0UcY5f6VRnSgGcIs5P3axo6YopY38Hku3r7ktXB4xmxqUuFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Irt7yPTk; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b391ca6146eso4382543a12.3;
        Mon, 14 Jul 2025 15:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752530885; x=1753135685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kv0p5lInx/NhPJHXYoBjB12uMJB4U7pSuVPfR0oKV6U=;
        b=Irt7yPTkiHzzLjlQEyOz/HfG2kS6RkYtKIbJqNmiuFqvkeFo8V29j+Ejn1BwHmMW52
         YkrvAaJp13Wvxfg4M83gRc63axT/WS2E1t4ExPvU2In8cdw/tTIHM3i6vw33xeU7amwx
         BH30St6sARatGSOFvgjKJBtBeGEHuYOGkL/B/Xsc2QTsG2d0PVO6XWYhwoxGT8NC3AfP
         E4uZyaLSH2HAVHWjlaNOkcesvt3QULbcBufdZFt3r/57AwailIQNJY/kC9MW44vCSp2l
         JhF7ak1dKGMZD8Qvab7TwLpzVU3CTzT9GyOpnXyR7GirdXvvoW6cw05DqM8hHcFe3f51
         oWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530885; x=1753135685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv0p5lInx/NhPJHXYoBjB12uMJB4U7pSuVPfR0oKV6U=;
        b=aHRCPIUIeSeFCzGiwH9CyYLN88aRPWR2pA/pCD2XRfBN5XcQg3QBBkyVIbvwcVbgln
         tVCxDKrG4SDgT3sMtgIpTYocXoERPlRE2kVxgeUoPd3Gu4FBUoUvyGaqdY0QiCOEBpjK
         CoA+7vv1dYg8eCqcLGaqIEwWfZo7CjM7QSYZ+FD46kxb22AB7w8I+m232ud1ynB55FlH
         G2RQrxhZb3ybC98J+ot9IFA6iyu/yvwuuXlo8Uq0syyfZAPbY7hxdnvNJG4Ikzg2Npha
         29vqvPvHBTj13/9XELgqKDXeW7/oB5CVr8MPgWwDB8qkLdFlYRu55PrtHzreMXcmvF2L
         pmuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWOnLj8DVJpFrRzXZyJJ2mamxl9VqcDLx8gESik2Yja3Mx/a0FhyldlwQVsHtiaripHP0WtVv8/FSgCVrd@vger.kernel.org, AJvYcCW3KW/1vV2/ZVJPgHWxebmHcMQ8shQHjooau+e0UZke0u81iUdRfzpxipzHH0ZKamq6hMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uHRQMajJq6cXULWFXSp+vBEVFz7aCSvuJ+ppTNC/x1SPy3jP
	toK7B3/s42312cUt8Sv4GnJRG9+ABTdKJTFAOB6nDs0ajHLEF6yXFObs3LybtPXy903nJj6zkhs
	IkUF+UN/X2jQWKOZoLJtY3cYkSFmqSBc=
X-Gm-Gg: ASbGnctGE15rM36kkSoSlRjQE2OxzCSLaO/fgivyLtl55Sw5yQrbOMoGh8EExHvE1zK
	ZHjBeJFB/MXDyBWTqnxvm/ivVZOnn2BI9nh+i4T+04nKeKWYlkLcra6LemKG7tfOq+Ajo7qzjqW
	8Z5u9J0MCS+6J4xjZHBR7xx3ofcTBjF75Bl/G1O4750FSUySTldIOfGVD3ON7aX7QI03d0O1Ipw
	ZBvaKHjbbROFcBiIR1MkdM=
X-Google-Smtp-Source: AGHT+IE8t4t2lJ4/t77D5S4aufaUIuVfxR4B2ezCpHtfgnaaG+G1cMnjaD1i83QxvO58+uDQ4nuvZmwfr7xBUYvhEDg=
X-Received: by 2002:a17:90b:530c:b0:313:176b:3d4b with SMTP id
 98e67ed59e1d1-31c4ccea2b6mr20465272a91.22.1752530884863; Mon, 14 Jul 2025
 15:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-16-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-16-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 15:07:47 -0700
X-Gm-Features: Ac12FXx53dwNxI_VbKduBLDtwzykMZzm8jWN-u8bHADnujv00XxRG24xq7mLiGg
Message-ID: <CAEf4BzZb793wAXROPNcE_EggfU1U3g80jdDsvP5sr86uDBhgmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 15/18] libbpf: add skip_invalid and
 attach_tracing for tracing_multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:23=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> We add skip_invalid and attach_tracing for tracing_multi for the
> selftests.
>
> When we try to attach all the functions in available_filter_functions wit=
h
> tracing_multi, we can't tell if the target symbol can be attached
> successfully, and the attaching will fail. When skip_invalid is set to
> true, we will check if it can be attached in libbpf, and skip the invalid
> entries.
>
> We will skip the symbols in the following cases:
>
> 1. the btf type not exist
> 2. the btf type is not a function proto
> 3. the function args count more that 6
> 4. the return type is struct or union
> 5. any function args is struct or union
>
> The 5th rule can be a manslaughter, but it's ok for the testings.
>
> "attach_tracing" is used to convert a TRACING prog to TRACING_MULTI. For
> example, we can set the attach type to FENTRY_MULTI before we load the
> skel. And we can attach the prog with
> bpf_program__attach_trace_multi_opts() with "attach_tracing=3D1". The lib=
bpf
> will attach the target btf type of the prog automatically. This is also
> used to reuse the selftests of tracing.
>
> (Oh my goodness! What am I doing?)

exactly...

Let's think if we need any of that, as in: take a step back, and try
to explain why you think any of this should be part of libbpf's UAPI.

>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/lib/bpf/libbpf.c | 97 ++++++++++++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf.h |  6 ++-
>  2 files changed, 89 insertions(+), 14 deletions(-)
>

[...]

