Return-Path: <bpf+bounces-78435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4850D0CA36
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 01:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F961303E038
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 00:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEFF1F03D7;
	Sat, 10 Jan 2026 00:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQWwON57"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409042048
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005420; cv=none; b=vDF1XD/drLtbzuZsC2zb6RWkx4ogLZksyolUwlvNXTAzBLWidzuSRLWnjy3+NUarkDpt8ixUbl5OD+/opLXTp9h5GNzkNESuHsKHSfSgZU5OH4qCQxnUHUwjgtDBFd6T513CN0NUcbSqtkk9O0U1z3yIgwzqu209n0tF3q1xmts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005420; c=relaxed/simple;
	bh=2cOpOmPdOQSBLA0FveuKSmKkN2jTG20cgo3J5WOB/58=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ER+s5u28DnzRVFPrIhVfwqCMxQZ2Cj6bsXhTUounhBpQ4OVyARQWpl7szASG0iu08JTbMrPgRU8NGPx9ux7tW/axxvYiEWsHZQ4ZR+a5IwNaiBCywRJwsaHGBcT83nJOtSJD8WGnkTPBJL2U80LN4POZ2E/3lxd3GQD7HCUtkpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQWwON57; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b98983bae80so2239707a12.0
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768005419; x=1768610219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSxvsKP02jf1cnbkhlOj52mufxl6NmofMhFwuClP36I=;
        b=fQWwON57jNwSdgr8RpqX4/dYRAjncsO5pFvDls31mglChXYZljkk4CzUtxsxjncPxe
         BqVwsMirC18x03j9O8tX6SUpf2uPHqLxNjb0Om3GpLYB0I293P1WyBmt1yxb7r0AdZuc
         YrzsmYq/ylQ/UglKm6cuRQ3Ju+h677F8NdVFa+F1MMkYrlbvtHBj54S87SI5oTwYq6AO
         YdNQmLeKlPDzNnIXeoZHW6tvzBGV+59V2hu7iOSxoQHNM1wF/baoaTzrh+Pqz2uR676V
         amowsn3T9pfIEFRlt+97jTy61/ZkMmRiXq/8jLDt+uJgqc+AoEmXEWbseG/9WTeLaqbp
         3jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768005419; x=1768610219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qSxvsKP02jf1cnbkhlOj52mufxl6NmofMhFwuClP36I=;
        b=toUy50WeAN5UCyC41HMqtAZdLcColA7fAg/RdY8HPZHL1XgqUl1JzP42TJSsIUPxcQ
         dsEa6Cdw44QvP+Ap92uVbMP4wbr9HzFu1rSdP4CR7wWZh/il7d63w1td7YzJIsmzcldj
         bBQ6tRJrwF5h962HzojgG3PXiuRUmFtLczVun87hq6uyJagXpAnpqAkyBlClwLEjJwTC
         fj2xhUoz3k8MbuJWKqUl38UVDrHGcoaKNOPeH6NICW7R2Whiu+vWQSNIEaBzG+McXwdy
         UuRzVHCTo+28pOcWpUX0EAclmxwtw/tdS+KYmyAhSZU8U9VsGwn4+qvBrL2SEvnVMxWv
         bPJA==
X-Forwarded-Encrypted: i=1; AJvYcCVDtKXK8zbqL0Cy8RjE4tfO/sTjUQ+M+AKqVaj8AOKwMfwjY8KstGAq7WticI81vp4SHNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK5POGqJWiN7GGo/OpUHZl5B147RSdzSwTlUavYYhCFRCN5Q4z
	6xvlK8NV2I2ipS9hlrObwKIHUK8mQna1CkxVPo1Ajflj2G2aWOeploF3cbAHe79JVhpCxvBmo6U
	hHU047s+GZtF2QJSGb9GuSiNtZvUjsWE=
X-Gm-Gg: AY/fxX4tbpL0fFmMdptiBhdAfYqVsDhCRyREVhM9X54PpfYYRHTsklDiO/J3eF1PG7q
	zhDuLxfbPMvDSRhGRl7FlvRWDK57i45tfV69tYNrNZGQRuWGKy8cCPR8GE+P87AAe7oYrpNMM96
	pHafNwrkA5ozdu1cldc0uwJxfKlTgmRYJmpJy7YUG6fL38AeOwg7NP/dlYtmSN57EB9rP8o//CE
	wMHIW9WbyrfwxD2mEStOnZwnzjyC4G3geoFWiqF9GDOzj/0mp/2OOpt0GiED0GkcSRhUDui0FU4
	KFgUhTOVXG1y6StFe8U=
X-Google-Smtp-Source: AGHT+IGM3SIsuNL3/dMuNpHCUQ1cqrUQQjji6eUGqvYpxJAa/wVfpCqyvAIs3ghIt9fdukZQ7mtDD7SDbuqV/HYZR7E=
X-Received: by 2002:a17:90b:2692:b0:34c:fe57:278c with SMTP id
 98e67ed59e1d1-34f68c47243mr10186165a91.34.1768005418846; Fri, 09 Jan 2026
 16:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230145010.103439-1-jolsa@kernel.org> <20251230145010.103439-10-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-10-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 9 Jan 2026 16:36:45 -0800
X-Gm-Features: AQt7F2pTOA8QTYmqFAVkFZ4-jcuY9II_x2OlDmi2JNLmaJvmLei8_Ech6tHhqpU
Message-ID: <CAEf4Bzay1q2oMYSDfdQi8LXt7HjFVXF+C+=+jLurp_GixWbD8Q@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 9/9] bpf,x86: Use single ftrace_ops for direct calls
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Florent Revest <revest@google.com>, 
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:51=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Using single ftrace_ops for direct calls update instead of allocating
> ftrace_ops object for each trampoline.
>
> With single ftrace_ops object we can use update_ftrace_direct_* api
> that allows multiple ip sites updates on single ftrace_ops object.
>
> Adding HAVE_SINGLE_FTRACE_DIRECT_OPS config option to be enabled on
> each arch that supports this.
>
> At the moment we can enable this only on x86 arch, because arm relies
> on ftrace_ops object representing just single trampoline image (stored
> in ftrace_ops::direct_call). Archs that do not support this will continue
> to use *_ftrace_direct api.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  arch/x86/Kconfig        |   1 +
>  kernel/bpf/trampoline.c | 220 ++++++++++++++++++++++++++++++++++------
>  kernel/trace/Kconfig    |   3 +
>  kernel/trace/ftrace.c   |   7 +-
>  4 files changed, 200 insertions(+), 31 deletions(-)
>

As far as I can follow, everything looks reasonable

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

