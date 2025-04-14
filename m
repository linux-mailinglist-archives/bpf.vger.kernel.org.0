Return-Path: <bpf+bounces-55868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B860A88835
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 18:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984E13AFDD5
	for <lists+bpf@lfdr.de>; Mon, 14 Apr 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CDE27F73F;
	Mon, 14 Apr 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZViMOOq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AD519309E;
	Mon, 14 Apr 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744647202; cv=none; b=a54aUowY1v9FM6c7YziVFQpwkCB7ElS+bWEu2ENsFAEZiX0AqzFnU6q8rJrG5VvoPgwnyv/xDzUz0oQw9waBTU1ei0a2pzGSNbgqk7Fcsy3BazKLQ2ghuNvndVIW97lfYnmL+TB+6AtlAIBlzpkv1kx7hgtUXmEOB15iRGivJ6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744647202; c=relaxed/simple;
	bh=sUxHd+bpTrzdWjq7WlLSGLwVwJH8vgpum0twtdz9/4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUX+5F5OOPFKUOk4Y11cYtmqV1Vr8/eoGfaz7FhJMKHAp5pHqV9hctKUpnG2ulN8F5mgG8zCkdPdPHf/f2WCvdvEHIQev3AY6qIdOelLt8Y9oUFzfKqxxpjkj4nCKq3dmqZ1ihk/ezRnJWcRgjkAiu3BpaLNl3NTHBWfqM3raDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZViMOOq; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7359aca7ef2so6849792b3a.2;
        Mon, 14 Apr 2025 09:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744647199; x=1745251999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6asywJeD+RJxS6sZJ0w92/Q6ch5F+IbPUdLU2Pugfo=;
        b=JZViMOOqIfR74iGqRgMy+QkbwTebDDp2YpMm6bzoOeUGIemdwVMTw5p4yN6qgiLeVh
         Gwduq8IkpJrTlmu17YyKhCrytOdPWWaUsAHTGyDwuS7xwMO2Zh1v/0ro10c1X6u4gyzG
         n/4uSMTrExhiwgj4qnEwRtnbwYbEInFxZ2q9QiTBZGsHAleuC46cxSKnkVAXqmm4wz7p
         LsbMDYFWddce0FtbB0+pFye50ajSEXBtFtSLgZF6VZYRRQO1qpDizQjWlgJDWpqoW46b
         9qmIWbg9XAjKuZZzwNTgRX6xmPrhYGuvD4xVndCle9+2URzZtYECTOel2kIFhMYnJLqL
         eMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744647199; x=1745251999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6asywJeD+RJxS6sZJ0w92/Q6ch5F+IbPUdLU2Pugfo=;
        b=X/fWc0QpVdRBw9PlN/Q9PP75vjulBb/90vzQYdp+uIq4QfF6wKPbTbFYrKUxOneBVh
         Da7DJ09etLss3lKD3CYHKxmIegNjr5cVS6evQ1Qa8jqcorUC4ykq3hggB9opucljeIzQ
         ueOTdBrPPHu4h05YRa7/Z4qXuBLEh4tu5WNdhyRvtXw67ZDqw0fS+aZhgiNNc66hP+/0
         wa7y/ePwqH5MPXZ9wvYKpUlH4uzboFxbo7fEiGxr1xkH0UAWVrqEUFR15ciOzS9Dqjat
         0KDOx7wKHt1fUsxQ+wSptKYf/P4A4lDVIiUHwriE70f6bIRIW2FKnQ2+FDMnstKACc2w
         bmQw==
X-Forwarded-Encrypted: i=1; AJvYcCUEd78lKVt2M4WMc7+lpjrfNfUWZzjKCvf+RYf5kvbz8aY+jCJ1MroR9Z0E5JVLAV0pBssJrZNKajDQGW0QCfHwmZZx@vger.kernel.org, AJvYcCV5/d/pZmcfIoKQAwSwJHgzg/lOysYVj9c7exymmB2X6WR4g2ailMFrnopckL8zNWYCo+eUjSpYMy/8aa0V@vger.kernel.org, AJvYcCX1YcdEnFauVHuHPKMCSOPon5WQPRZm51LYYqIMpzvJR4qkKXXsQZA0WISLtn7UN45CDkw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4GCbdyl9gEvMTRu/b6u6Eu8o3rGZ3cgG9XLd5zF4sWt3SdljY
	XvHZ3tCV6AoIas6qQRJ6CBbDILAFnv4wPSjtNHH9aJVEqNfU17MyF0JCsYcVCjuOttCyzxWraIC
	jUyeCnI/wf8+dWFHx1SoYCQ83+u9Hfhpy
X-Gm-Gg: ASbGncumqr3Qf52C2COblJ6AO3YmbWWKgtg7VchXLOD7an/e/R6YmBpHRlVtm1iFzDl
	l0ic2moravcTVso/99/Hj62RkpxVVOUcuzA8F5wpTTwfBt5K9xUyTt4EflEnXL0I/C2W9AoFoPV
	M+Qjm2XC8uCvbieX0m95BhP4QJMLguHM/BGp5w
X-Google-Smtp-Source: AGHT+IETqZf6Sd1ER2YOsJALw3nB8wrNvKEzh0t48eXEh1r7BUNdArGp9ltJDfCGSd2loT6Yu7zaEpP2o6TwR489dgY=
X-Received: by 2002:a05:6a00:1152:b0:736:5dc6:a14f with SMTP id
 d2e1a72fcca58-73bd12dc547mr17692891b3a.23.1744647199314; Mon, 14 Apr 2025
 09:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414083647.1234007-1-jolsa@kernel.org> <20250414083647.1234007-2-jolsa@kernel.org>
In-Reply-To: <20250414083647.1234007-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Apr 2025 09:13:05 -0700
X-Gm-Features: ATxdqUE-l2I09rOYVu1-efysb2p8CcbGule9DeMtj1YvurdLfGFRLCJxUpVOrAU
Message-ID: <CAEf4Bzadf-k7vcDWm40yjpq7P4dYEr5pKTKsgthvWs_GqvoRNA@mail.gmail.com>
Subject: Re: [PATCHv3 perf/core 2/2] selftests/bpf: Add 5-byte nop uprobe
 trigger bench
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:37=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add 5-byte nop uprobe trigger bench (x86_64 specific) to measure
> uprobes/uretprobes on top of nop5 instruction.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           | 12 ++++++
>  .../selftests/bpf/benchs/bench_trigger.c      | 42 +++++++++++++++++++
>  .../selftests/bpf/benchs/run_bench_uprobes.sh |  2 +-
>  3 files changed, 55 insertions(+), 1 deletion(-)
>

LGTM. Should we land this benchmark patch through the bpf-next tree?
It won't break anything, just will be slower until patch #1 gets into
bpf-next as well, which is fine.

Ingo or Peter, any objections to me routing this patch separately
through bpf-next?

But either way:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

