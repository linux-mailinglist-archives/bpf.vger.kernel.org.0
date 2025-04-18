Return-Path: <bpf+bounces-56228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8F7A933B3
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D045D4667B4
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125E826A0B1;
	Fri, 18 Apr 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CTcPGV2b"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60B719D898
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962583; cv=none; b=dc9+FdqlmnzkzQN0KqPBfcxrEFLR7obPEU8U90MMhdQfCz3CeAIeiGZVJiaO3hCmqj61PxT7FpfOb3E50Wp+KnbVIHj165+M2dgz4GI3sxfeA2U36U8y6hdhsQZVRtncx3u67Cs4AN7MY2vcOFb8PlaqMHdiyy+Yu7enP0bkXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962583; c=relaxed/simple;
	bh=FiHDOUu0puy8k/iP7lANIR5Jh2+87OL/pBxyYca9WQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcL8plt47F1cv+kMk9jeHWLw/tqhpp1eyf3O17Ic+QXw44FDMeTdlcRtk0N9Y63Hp8tq4TxYLAa8fQ+SCmT5Zh+OSfXyLoo0PX3ojS+543RZey9IMbWYXOPAxMgVRtlihdHj3jg/t3bshAAiKY/g/JlGPBobJ35yTO5lg9Sj0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CTcPGV2b; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb415dd8faso260577066b.2
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 00:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744962578; x=1745567378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7YcIqTBZXBTBgSP8YXzlGssgyxHAGa5u2sfMK6Mqg4=;
        b=CTcPGV2bclFPckbRArUkEmEX525UTA4OcoNsGfxqdIVAiVoFzYrlgrqs/ABsZGjbL8
         YL3o0v8QrqIDOF8g2ZUeIHfiJ91tg14BWYka5EuzSO774IlUwEE6TQflM0oD52dIROWG
         nvUKyb+CO8nuRMkQkPdRO01PrvJ9VsOVlZRnF5K5GPV4lJRRgAKBT6BqCOENpt/rpl+m
         5VGVybzy87FVDaSfW8FH93mnO7kuAshPODmvZcD3y895raTuFM+q4mzRl2Ad7ApenD7h
         lkCGulPIso0szy2KY789jfxgnrB0lb64mnMWW/UB0SG8mqTRQ9MRQIuk7gH26tDYAN1i
         5nMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962578; x=1745567378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7YcIqTBZXBTBgSP8YXzlGssgyxHAGa5u2sfMK6Mqg4=;
        b=Jfd/2kXuGK/Iw4//HHcPBxPSTSXOqeW+YnNeJ2uiCjg/XrY21AHaQZanJhVuEkY8s6
         M29c3filrCCMeODIhlNx2iRaFAHMRZa/bTUrNA2ee2KfVJwQ+ZUguolmcdFJuMQ2Ing7
         fEqp4K2f49GT9xVXU05lG0wz3NB3ufz/r65t/Nfi6rX1vImr5bWXNvSkr5b8cYSiLvwV
         TMi/5xm7XKCmhf1iGRS9fYuw2TgEdP8GWCyPuOy8LAVRi05L5pxZxx3ESi9b2vjhTXe/
         83sDaCVBsG8NTANTfLKUw8VBbc8KA8VcQMaDVRc9KHc8D4ng2Ajb3l9+VucNxVbrvt8e
         R7Og==
X-Gm-Message-State: AOJu0Yzw+cDmDxActbuFEDhBpYzCYOf83kvVVC7a5QlYm61M2d3A6rN4
	ojshTDBqdmIt9Ip80RhTNs8Uduq8Ok/IhS2K0Z1GBmdVVL0ITmd3mbAcRh2cUbNRXTofwzco2Gf
	uleama5wW9Y/rqavwbgrnRnh1p6+O18VgBHrvGH1CLMekTWRj4Pc=
X-Gm-Gg: ASbGnctLX44gKSq1MnIHu799/w5lOtBOdWewWa0PA3mo4OAAfUi+4wdwqwyf0f8T6JW
	fSgflYzaL+ApfW4H8h1S4zNxKvo4rILQS58XeXUHtCSdZGpbThShB/a+ACdP2Tv5fs7w0uyAZl/
	LaclplS13scCFsuLkbFd5tRVs=
X-Google-Smtp-Source: AGHT+IHsMfzgJHa3x3Nni6SCOmZQP+0ILOdy/LLDK2Uo+OH8IYpXOv3wGR7zMJ/5f1dBkTvbZ4odPu37h651Y5nMgJs=
X-Received: by 2002:a17:906:c142:b0:ac7:95b3:fbe2 with SMTP id
 a640c23a62f3a-acb74dda787mr139968966b.56.1744962577965; Fri, 18 Apr 2025
 00:49:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418074633.35222-1-shung-hsi.yu@suse.com>
In-Reply-To: <20250418074633.35222-1-shung-hsi.yu@suse.com>
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Fri, 18 Apr 2025 15:49:26 +0800
X-Gm-Features: ATxdqUEhzj_r7OcWk3D8FUS1MmeF8Jesnd5Xd4O3Gh9nUM9E8F6oLrYOlK7WnHc
Message-ID: <CAJFoxQPP-ugv5t7B5ZO2ejXNbc-xOned9ndej1cBM66dmyn7pA@mail.gmail.com>
Subject: Re:
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 18, 2025 at 3:46=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
> From bda8bb8011d865cebf066350c8625e8be1625656 Mon Sep 17 00:00:00 2001
> From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Date: Fri, 18 Apr 2025 15:22:00 +0800
> Subject: [PATCH bpf-next 1/1] bpf: use proper type to calculate
>  bpf_raw_tp_null_args.mask index
...

Email headers are off, hence no subject. WIll resend.

