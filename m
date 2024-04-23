Return-Path: <bpf+bounces-27541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E008AE595
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AEC51F22533
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585D8126F1B;
	Tue, 23 Apr 2024 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6UHILzP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5E84A44
	for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 12:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874010; cv=none; b=jmYwPrE5RBQs1YIb7/J5XTm0L6nV35jDv2446qnXZJmjG61TklB+vdbdq/VHVHBTRACIr8ESwOjPaV0DhWssyXOHKWba+1Vt+jkZTDsqdGalcJ9jI7emidKI/WwsrWuSv96l/Op+4EXgNnDRl9AqVMCdfhr3Ku0R1VSRv4ZnEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874010; c=relaxed/simple;
	bh=ypGvxrgbppj/e1ysJTV0pgMHHhMKEr8aIjC1w59H8Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3lPX3ahKEgFxFv1ERwUsEMrvBSxAoojizvhnkzPbYyfzpU5HYa8fsGhVid5+a214Z/EucgxtnZyut5EeEqowwotcXUB3Lf9izExt1pOf+UsXkQU2CEAzAVMLJlD7wFiBkOkirIchSgmlelVOrYeXf02BtfqfSAELthIuNChIcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6UHILzP; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-a58872c07d8so12355066b.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 05:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713874008; x=1714478808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rPqdieSrQiPLM6DvoJopt6lldQYp3DnytdtvjOyI2XQ=;
        b=D6UHILzP+gjJKoKQ5G/71LeqGDkbKhFYK15ELoynb34kssjshDkTeRQMMBnhkAhXzv
         gr1PqaKUwx6VfFdB8E4MD8raNv1ExTiH4wbUkVrQXxsKAGb1MG0fOLh2DewvtYKqNEAR
         m6fLCvL/19BpLk4LcpdwZCeqrq7dYS6bzCrYA670HCed8B3Qqb0VQiOP3JMBNiAt4OSH
         zbc7DPhJvqBAEjhb0xXBmeJUaNmG5Kdsa8VtrQTqsO5svJfN8b7B/7KgSoJw7CykAgUC
         xGWd64zGuYnfPSe46Snf3pPh6MBtkP5Jgr3miqHSJH6zFZY8zkaGDLqWE8LlYn9TUWv/
         tGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874008; x=1714478808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPqdieSrQiPLM6DvoJopt6lldQYp3DnytdtvjOyI2XQ=;
        b=eqP/sIYznpFk1Kd0+8vVLC+hd+56u4UW4U9JiBOA6EkYa5Am4Y8kuF1UKYpwVOnoYw
         7My2jNGhYnaf0ge7ET5uEscxkX+JPbTeaJ7TiwK1YNJ1TCiGoHD/HCd9NrMjCaAHLfHu
         SMcXv5j+t2EK+Q4Ph2225xDHw0+YgGF7zBL3iEjp3+kzqjJqpleQl0wXOLl28m94XugU
         8XcAgUkfhIK30RLMCU44AortezPtAQAr5ZxhdGSyr7wU4H8B/iY3wcJ1AeePB55pey/A
         y1XHQoJE0bcxMAKY4TZ9ApTGMoDejj/kWCSszm6b2IaoYjK6hsUKXf/yeDV/myr0dJd0
         HHww==
X-Gm-Message-State: AOJu0YweBD4e7nS+09jycvyFYtK+eAk6aWVjV4QqQU2MVrjatG1sBZTB
	Is+lZ8V3zDv+HzbTr12AtRPk4HAzlrwnBee17dL7AU1MJ80r4+kYXjuSIdvBqyBFt76xzWpnMTT
	Kz78dlX08rA9F+ckc4Yhd+OfRrjM=
X-Google-Smtp-Source: AGHT+IFIls61JZKI9bKO3SCUTktCLNuewX1P+K7iB93pcgrazWjqYvJLm3NUrAO6/k5UKUuRGaML9A7AxjrpMbJKN+Q=
X-Received: by 2002:a17:906:40cb:b0:a55:5698:3ea6 with SMTP id
 a11-20020a17090640cb00b00a5556983ea6mr2367928ejk.29.1713874007547; Tue, 23
 Apr 2024 05:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423061922.2295517-1-memxor@gmail.com> <20240423061922.2295517-3-memxor@gmail.com>
 <ZieYvK0GXs4OkTy4@krava>
In-Reply-To: <ZieYvK0GXs4OkTy4@krava>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 23 Apr 2024 14:06:11 +0200
Message-ID: <CAP01T74v0SCoCkg1gJnz4xPsBc5Q7bV0=-xXKfo00z1R5bz0Aw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Add tests for preempt kfuncs
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Barret Rhoden <brho@google.com>, David Vernet <void@manifault.com>, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Apr 2024 at 13:17, Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Tue, Apr 23, 2024 at 06:19:22AM +0000, Kumar Kartikeya Dwivedi wrote:
> > Add tests for nested cases, nested count preservation upon different
> > subprog calls that disable/enable preemption, and test sleepable helper
> > call in non-preemptible regions.
> >
> > 181/1   preempt_lock/preempt_lock_missing_1:OK
> > 181/2   preempt_lock/preempt_lock_missing_2:OK
> > 181/3   preempt_lock/preempt_lock_missing_3:OK
> > 181/4   preempt_lock/preempt_lock_missing_3_minus_2:OK
> > 181/5   preempt_lock/preempt_lock_missing_1_subprog:OK
> > 181/6   preempt_lock/preempt_lock_missing_2_subprog:OK
> > 181/7   preempt_lock/preempt_lock_missing_2_minus_1_subprog:OK
> > 181/8   preempt_lock/preempt_balance:OK
> > 181/9   preempt_lock/preempt_balance_subprog_test:OK
> > 181/10  preempt_lock/preempt_sleepable_helper:OK
>
> should we also check that the global function call is not allowed?
>

Good point, that is missing, I'll wait for more reviews and then
respin with a failure test for this.

> jirka
>

