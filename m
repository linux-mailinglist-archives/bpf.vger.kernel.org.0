Return-Path: <bpf+bounces-22184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F1E858810
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 22:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C3F1F21943
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3C145FE6;
	Fri, 16 Feb 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRVzU6c4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74BB145328
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119311; cv=none; b=utOlPl/ghdO/mPPRr/mdbAZ4VvoPqAkTGp4GFqEmfuRtEx9Iex8VbHYYch8B+ZqqumXqbIusstLVy83AaO1TUCfGWWGjwu/lgtdDslRByJkegOi7ydWvVpVTIktWv8CJvDLXurUTKmMuiOCF8YrETk1LS0nsZUBRslVvmWxORHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119311; c=relaxed/simple;
	bh=WvDa9ziTIkIav6v4ioei8kc31M90GifIFUTt7fnptfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZaioBzkWFFYBi2gSl6bgd7IEFc/zqv97MYXaXHSezqzJ46UlzoVcSzgl8oY/M18vvONVK5QpgRxT7FyP53zaFQL0nE5t4UV3VSq3tBBMZPFYYTI7lB6BsgyfodsL+ZRAgrV2fvaK70GaB7Rn7hyqw9e3TsYyiF2dTeiViX4YwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRVzU6c4; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-50eac018059so3550050e87.0
        for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 13:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708119307; x=1708724107; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3ZRQvetI+Ot6AIwe98ybY8dnjChldPQhya859jt4oA=;
        b=CRVzU6c4lipzi5dqfBMQxFvlBxvKjhaxfmrqghp+zi77M6WQZEycS3UvZRP9fR5Ly3
         ayc+YYh7NljWgZ4DtkMaYqXcTkx9mYOaOoMIgnmupoxRVlWgZHDwOxBS8sjQhCUOIV7z
         ImMsPzbrkTqUPAwp9XHKOF89Edd5O5W6KY0dlBHL9BwRAIGKOr6iV9/xT/5Sd6YhZzBb
         g9w1DPRwMPQnUCqZP87Ml7EkXYw1KtU5gETgdouN6RVxGaO1FJnetmL6iITBIHgw6Ldo
         LneTv44YmBzHXjkvPxkXTOqvC5DDxHGMXd045GtAxLDq8iyUeeaYfMJig6VPfqqvG8gw
         1mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119307; x=1708724107;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3ZRQvetI+Ot6AIwe98ybY8dnjChldPQhya859jt4oA=;
        b=Qpqnf9Ck5W4Lex4P4tdVDeIqVowaPZws1rnVDunwExt90rbO7a1/L/wV5Ycw9tsDGm
         J8FE5X0w/TYr/DXqVxblvMXiREo7fvHSlmUeAJYnu36lu5bA6jhnd45pvA0nGqLupMNz
         TfXZ8eorRWpn/oY8earb/TtclnXjeeQ2fULoey06ufKVCU4QTjp3Jspw2WoubgijvU8k
         VFZXEl37Z19H0ybEWAPDOBgdfgxnQ6CFzrrgMkVuiu0x4IJVswfFUg67b/CK1Znu2tJw
         05tq1oUEqoyl+eVKAb70xWcuBTOrJEJ8eJ9Vy4aWP5PdrtUz0mX8w1obI9lHXEDvi0ZT
         /yEw==
X-Gm-Message-State: AOJu0YzWePLksiyAJND2e0YPs6n8yHx87V71aK8WaE92ytjWxB3oq+AC
	8k0SSD/Nm6a0TPgN4IuPR1+Qz2S7AkTq4UtEGGpbuWh1blwj+g7n7GKuKrW8e1hRRzhUBuG2dvZ
	9XEJgHlQVG3+3vGs5PvGfso+nBHs=
X-Google-Smtp-Source: AGHT+IHYtzqyVer6QrIojGS9hpPQFcEzHu8mRMYooW+/Qu4f/e9EhaVqb7zAGG+lQ+TFIpj80KkhaqQvpG94DQQelYY=
X-Received: by 2002:a05:6512:3e23:b0:512:8d8f:fefe with SMTP id
 i35-20020a0565123e2300b005128d8ffefemr4441021lfv.3.1708119307442; Fri, 16 Feb
 2024 13:35:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201042109.1150490-1-memxor@gmail.com> <20240201042109.1150490-2-memxor@gmail.com>
 <372870cadb0d01a26c7381fe61218f494596dfc5.camel@gmail.com>
In-Reply-To: <372870cadb0d01a26c7381fe61218f494596dfc5.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 16 Feb 2024 22:34:31 +0100
Message-ID: <CAP01T76FPdJZYudE1V+5Ka3ubBPFtU04a=hGVmHshuRyaJTiwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/14] bpf: Mark subprogs as throw reachable before
 do_check pass
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>, 
	Raj Sahu <rjsu26@vt.edu>, Dan Williams <djwillia@vt.edu>, Rishabh Iyer <rishabh.iyer@epfl.ch>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 02:01, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Thu, 2024-02-01 at 04:20 +0000, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > +static int mark_exception_reachable_subprogs(struct bpf_verifier_env *env)
> > +{
>
> [...]
>
> > +restart:
> > +     subprog_end = subprog[idx + 1].start;
> > +     for (; i < subprog_end; i++) {
>
> [...]
>
> > +             if (!bpf_pseudo_call(insn + i) && !bpf_pseudo_func(insn + i))
> > +                     continue;
> > +             /* remember insn and function to return to */
> > +             ret_insn[frame] = i + 1;
> > +             ret_prog[frame] = idx;
> > +
> > +             /* find the callee */
> > +             next_insn = i + insn[i].imm + 1;
> > +             sidx = find_subprog(env, next_insn);
> > +             if (sidx < 0) {
> > +                     WARN_ONCE(1, "verifier bug. No program starts at insn %d\n", next_insn);
> > +                     return -EFAULT;
> > +             }
>
> For programs like:
>
>   foo():
>     bar()
>     bar()
>
> this algorithm would scan bar() multiple times.
> Would it be possible to remember if subprogram had been scanned
> already and reuse collected .is_throw_reachable info?
>

Good idea, I will look into avoiding this. I think
check_max_stack_depth would also benefit from such a change, and since
I plan on consolidating both to use similar logic, I will make the
change for both.

> [...]
>
>

