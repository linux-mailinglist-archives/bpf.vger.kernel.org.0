Return-Path: <bpf+bounces-73492-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB1C32C1D
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 20:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DFF5189F86E
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE5E2C15A6;
	Tue,  4 Nov 2025 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PITeKywW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1422E28488D
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 19:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284082; cv=none; b=QZsX6xNL4jUWV3As6PhZn/kKRHnfxj2552JUtF92Pc3ASoR1Ru7L4e1vqXfi8GD5pdSy6JXJRSCpHcXdCuZRYse4Bg/DYaFbh2doRbYPBoFYJOnZKBvSod0rXfbbhzgGbMZeR3zBOJTur2AJQCjZxlIr+QeXDsI0yuJjjI9w9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284082; c=relaxed/simple;
	bh=7/lI2HgLZMjDc9kzkGLnYr8PLR3jOvCkq92Kj+0rWQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rNNQ2XzvTfOtvtCtSG0ZAATgAmHxluAoos0DFGLgIjFf5mEF78F2j6rM3A7lpt8KnMevj6toiwypi4S3gC4IsPzmZmph+UTTSxP9TfnWfhd1FPdzFdnpQB9N5/tbCvwRF8Iz730Q7DnQGmIvAW6xOcAG3l1nUAnCcwGYEez3mEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PITeKywW; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34101107cc8so2672995a91.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 11:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762284080; x=1762888880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXWZZkn9ohvWCvEwdmXjQbNVZ0FB6RQSH22lNt3JOTc=;
        b=PITeKywWytMxvfOcG33BE6blSlcDFfqXjTlnE12VJjVmincradcwo+MRTpMERmquvQ
         fpheVZKtsEEMDnmK3vQHar2jXXzALDS714+xL+a3U8IWnfluUrEq8/+irRzqKnFABxvR
         vC48SpDs/fHI8MU2Z/h8UY1LQhV55VaUn9SQ/84zD5YJDlF8FEK1L/tiKOfb2/jNKwZy
         KiP0DUFOEylPWkhfQQyrmX1v4XyEy638EqesguSF9s/EU18Betl5yyh3Tgmy4mw+2zca
         fko0Tsbz1mgh+TsZ0NS7s1ZuZbJ6u0Om1mwBXmDn9jikdcE5A4cDbcw04QuE5KcFnExj
         FMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284080; x=1762888880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXWZZkn9ohvWCvEwdmXjQbNVZ0FB6RQSH22lNt3JOTc=;
        b=BNnNFEYRwVOKAhjZaziGXcffIZwk9a/+E+RVB5Rkg+BYRD0jvQebYx1oDOGq1wnTMb
         0SdQGWFHM2NyL/lHtXuIMrWZq5VKQ1tbyCZaY2CadMRFRebDcBirVOWMSUiYc22SMqPK
         UGKRaYLF3SZDsS2NHN9ZOd/99zYwvDdhPkX+4rR65744MPCOzmbwa1g6fE5hE7UT0Z6U
         d2hKrUPS4oXXLys4PwPE3ktjbftEE2zw9jE2yV5K/3lJxI1Y0TKdpCh2z/pkj71r1Nmm
         PDecZcT3ADWk0DnY7sHrtXfPP9zJof6umDBQWg2pYcVIBfWcHK3vUp28Mb+IV1mDd/1M
         ftuA==
X-Gm-Message-State: AOJu0Yx+UnvYruxQyV/N17MCEOPnlKuKF4G67kTKT1Idt8kFfAteBiBw
	1K6YnhH+w58SK6VLqgB2X8Onp4fR128GYonHIM6QYc+lY3lTsqGxjstXZrD99FpMFFdDQ8fEc3S
	nTZZPCz5xVL/+jpkUmQRh/urtMu2+rUc=
X-Gm-Gg: ASbGnctRAgjoOmDHvXmwBqEKr5jMAO3v3qcSo8qAKA3FOQfZcklrNC+dln0W1m+rd97
	GrOIRkHWOxN2/MUOjFvSIhn0H850v69seb3ImvoUnL+Cjieoi3vsto0LAJpspQyDC3oJ/Bq591e
	Wsg4B86TVAaXibue32Ia3l6UCm4QYkhPcgirrYeOxGQwJrLBSN0Jt0pEklMtbn9lJiFE3rRGonT
	dA0H0GcjeUOhoCJPNKJ2pQ60L7S5tYu4D92VHXYZKETPC4cFfl5t1M+altKwgDO16MxbMhup3k9
X-Google-Smtp-Source: AGHT+IH+XR7VvdZmQQqIQFNf4oVTBtNsghG1eJIl0MFlDiz9LSlTmYZvnQuV26E7HLOJ2oW3wgdk1AJwoaKd51rl49c=
X-Received: by 2002:a17:90b:3f46:b0:338:3cea:608e with SMTP id
 98e67ed59e1d1-341a6de3d25mr313200a91.31.1762284080398; Tue, 04 Nov 2025
 11:21:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104-implv2-v2-0-6dbc35f39f28@meta.com> <20251104-implv2-v2-1-6dbc35f39f28@meta.com>
In-Reply-To: <20251104-implv2-v2-1-6dbc35f39f28@meta.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 11:21:05 -0800
X-Gm-Features: AWmQ_bmuY-odmkXhNCrhrAHLHSePj78it-ldmDFGcjn8GoEgjwPfOXoYCGjzb-w
Message-ID: <CAEf4BzZs+hRONn55rBcEZc0JU_4kiimdCaH+NnSf6AHGv2PCfg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf:add _impl suffix for bpf_task_work_schedule*
 kfuncs
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 7:30=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Rename:
> bpf_task_work_schedule_resume()->bpf_task_work_schedule_resume_impl()
> bpf_task_work_schedule_signal()->bpf_task_work_schedule_signal_impl()
>
> This aligns task work scheduling kfuncs with the naming scheme required
> by the implicit-argument feature.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  kernel/bpf/helpers.c                               | 24 +++++++++++++---=
------
>  kernel/bpf/verifier.c                              | 12 +++++------
>  tools/testing/selftests/bpf/progs/task_work.c      |  6 +++---
>  tools/testing/selftests/bpf/progs/task_work_fail.c |  8 ++++----
>  .../testing/selftests/bpf/progs/task_work_stress.c |  4 ++--
>  5 files changed, 29 insertions(+), 25 deletions(-)
>

LGTM, thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

