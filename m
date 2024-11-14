Return-Path: <bpf+bounces-44891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C7E9C965B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 00:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC209B24B99
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 23:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA311B3942;
	Thu, 14 Nov 2024 23:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKZyCtHY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025351B2199;
	Thu, 14 Nov 2024 23:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627868; cv=none; b=Nyst4t9xYKw95r+wSxeBRkb+g/U0eyZHeHdFdGsX+SJbUK5YZ1Z2fdeSR0DrZny2sgFmdKo4b2e07IWxtU8FlSfbYqda4yjWa7ptMAJyyYfT2Gf+uZrj2NP55y5y3WcQ+Cl5xyKSSogKUlYBXYeiKA4S9dDzYQFd62smTS2YbuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627868; c=relaxed/simple;
	bh=gWBovTXqA/VAWZ670OgSVG6Hb31YH9v6niocbrfGM5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KX3gzKQOVgFvUEfcCf22WMC1bA1t4x79jO66/SRzU1734ahO3tq4NjrOQtmMc5QPKI71cZcjtJtlWborc8FUJjS1Vo40jradAzdKSdfRyZuFRlgZNgJs698tO+EB+g2G40mzAR0WYcKG0GFhsBtjCvYT5UiDufeJk8LR2PNvimo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKZyCtHY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e6a1042dso998508a91.2;
        Thu, 14 Nov 2024 15:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731627866; x=1732232666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAMUWeEPSLPc+X3ViBsRAxmxaHXwjk9K3YBKFo/2zg8=;
        b=PKZyCtHYzqQgQ44mdqgHQSf1ffhPZDMjLKYIV44s9A5OHHfcicM4MRz7UWMl/QCc7O
         HV84SD3eu2V5/thiwqWbZiovcTvO+ZWyPo/U/ZZyX9RDnd/tcZpuK8xZ4A+hQaCdW3RO
         C4TL+trUTmRACHpZJ88XrXclMei058Re/Su3ALwUK4hQx98I8lptGDl1JrQyvh45SIWZ
         DjrdnC+ReCbSzXvsM76bN7UySOtoDtLV0NASlU6SoiTzWrKB+ZnYUuU5ac+u+/ra84eR
         HYF271Sutl7MtlR3iw5fBxW6o20YDePbHvkc+UvML+n2Ju/Jrub3hjv12Ra/elaXgxv3
         PHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731627866; x=1732232666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tAMUWeEPSLPc+X3ViBsRAxmxaHXwjk9K3YBKFo/2zg8=;
        b=pqWY9wbUlSIci1Yu8mzKQqgeg2z3MeY0FSEgSAK0dVO6sU9vSMWkDu1q6V0BXeqIhF
         nrDfEo8b+tOlSOM4o3JggWD5z9vRa20W+d3H2cjn4MQmBZEDRc7Sa1fx+XNo4CdC7wEE
         dWVtJvp47Zs+1pQEtkQPPXnvBRdJ4Pv9CMB7T4f0DTjadSj7jpOp7WSdhgERV3w1XZX4
         JaGfIZswZe+LlMr0TdoF1W4NsWDeziqhhtgEJTzJpPLjo2Gk3xpEiXO2NhlpvXSKlKuJ
         xR70ZAMFy2I9OOukI2B4meaDCV8hyAJkFbIiDg49K3iffP/075qHxPK/r8dFuRCTTeeB
         pSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJFk+sA6Ay75HN6w6/XW1RCZ8ncP4YyqLfM689qq2mVCdaUjzj8/Nr8gZi1YxrS2gtj94=@vger.kernel.org, AJvYcCWjxvbwNO/C6489uMjoDzqNaSa8k83dFbdfx0zbJHmtfqp34Q8KhzM910mqDQpshEGuLt1Jccarf6jM1iz3@vger.kernel.org, AJvYcCWnbMiU8bQYBQM1YhLsRATu3aD17KqofNHKA7il5aDvorSZP31AASERsZiIM7AxRDfywlIT4H99WGSQC0d9Yq//GwXv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7HfzoZp+dOrgBD9grB77qQXzv+ccLXaIsaR5zfK4uyNmYfZVm
	rtgLi07LEEgbnyfDsUmapyUCpf6mWX6ghD4H7foFdPN3GU6h3J0Pp7KFJj/zcyHucqWI6H4Gc4H
	Msw2QnF5imhtvIPzKHSkv8MkZwUskmA==
X-Google-Smtp-Source: AGHT+IED0Cb2IG+CJ/nNZln/I+ZLfHIjtvOtEJhAkxkTQYzkM5s8ck6ZjaL4QlXHTxPBG77jn9zqREmPLVPTS7kS4eA=
X-Received: by 2002:a17:90b:3a81:b0:2e2:d33b:cc with SMTP id
 98e67ed59e1d1-2ea154fc4b0mr857871a91.21.1731627866142; Thu, 14 Nov 2024
 15:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105133405.2703607-1-jolsa@kernel.org> <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net> <ZypI3n-2wbS3_w5p@krava>
In-Reply-To: <ZypI3n-2wbS3_w5p@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 14 Nov 2024 15:44:12 -0800
Message-ID: <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe trampolines
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 8:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Nov 05, 2024 at 03:23:27PM +0100, Peter Zijlstra wrote:
> > On Tue, Nov 05, 2024 at 02:33:59PM +0100, Jiri Olsa wrote:
> > > Adding interface to add special mapping for user space page that will=
 be
> > > used as place holder for uprobe trampoline in following changes.
> > >
> > > The get_tramp_area(vaddr) function either finds 'callable' page or cr=
eate
> > > new one.  The 'callable' means it's reachable by call instruction (fr=
om
> > > vaddr argument) and is decided by each arch via new arch_uprobe_is_ca=
llable
> > > function.
> > >
> > > The put_tramp_area function either drops refcount or destroys the spe=
cial
> > > mapping and all the maps are clean up when the process goes down.
> >
> > In another thread somewhere, Andrii mentioned that Meta has executables
> > with more than 4G of .text. This isn't going to work for them, is it?
> >
>
> not if you can't reach the trampoline from the probed address

That specific example was about 1.5GB (though we might have bigger
.text, I didn't do exhaustive research). As Jiri said, this would be
best effort trying to find closest free mapping to stay within +/-2GB
offset. If that fails, we always would be falling back to slower
int3-based uprobing, yep.

Jiri, we could also have an option to support 64-bit call, right? We'd
need nop9 for that, but it's an option as well to future-proofing this
approach, no?

Also, can we somehow use fs/gs-based indirect calls/jumps somehow to
have a guarantee that offset is always small (<2GB away relative to
the base stored in fs/gs). Not sure if this is feasible, but I thought
it would be good to bring this up just to make sure it doesn't work.

If segment based absolute call is somehow feasible, we can probably
simplify a bunch of stuff by allocating it eagerly, once, and
somewhere high up next to VDSO (or maybe even put it into VDSO, don't
now).

Anyways, let's brainstorm if there are any clever alternatives here.


>
> jirka

