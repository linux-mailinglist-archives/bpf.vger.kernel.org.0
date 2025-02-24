Return-Path: <bpf+bounces-52452-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F9A42FFF
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F171F7A578D
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED62204F63;
	Mon, 24 Feb 2025 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhoUI8Co"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618411C84B2;
	Mon, 24 Feb 2025 22:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435845; cv=none; b=jw//SbyX+maoBuZioddCCCVbCOwHAa8KFJUCd3meX8eF4XUXRsKT7ittWtwZtIegB4UJqQywo9gqmK/9/sH0gx2gscYjFG2GEXyTGobTC54pysStQfu08rLSJkR7m0j192USGKyDcJWZZ5CXmjtaq/D8LP0XQUemDdfv55gBfJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435845; c=relaxed/simple;
	bh=RleCzBh8U7CWXchF6M/strmw5lVX4woIgA5/3lEkHY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozemN+/vfbQwF6oqAuWTBnfB3NTPHsnkWb2WjrrL1gWLqaF7zfgzUfYMZmGu8yi5+MfOXQy1GhGAoGJ5yjP9VsT9PNXoE+Pe00l5uLGjzrI790zQsY85557l7pR6frCI7orOqeS+vc9BXlD0GFRTeC5Zr10GCcJKaCTH+Yx6lnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhoUI8Co; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2fc4418c0b9so7565859a91.0;
        Mon, 24 Feb 2025 14:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740435843; x=1741040643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfHCBXHfDYNvL2XmQthYrd9nOUEVpQRM5+FexNDF7vk=;
        b=KhoUI8CobUWxs5RzeEu1n/8l+a/MLDKkJdydRMLJdcD00CP2hCDXa/sxd68zeaA+Ud
         HvVI/P0oJ4pvCnQ4ZYiybje8e39+mZGYtSdvY1PKcYGocjQ1F9Xx5SSOkDb9vNdqtFoz
         xkA6MDPXZ5fNnycfY0VRESw8iPpRK0fkl2yi7W15wvvuJSPO5T6Haf2Nrwjh9Qn+mPNe
         tE1I9XSJrCVJA8EfnNBAWeLza1HqGVKmqYNJtoACJdoK2O3nEvh1byUH+WEixsokgbEE
         mjqes3hZFDUq7uA+K5hNQP+oj7iOKUZBtI//AgyR4OqqA6FA79I+jieRl7nlXLJXw5Jr
         7f9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740435843; x=1741040643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MfHCBXHfDYNvL2XmQthYrd9nOUEVpQRM5+FexNDF7vk=;
        b=QHRCk81zkZEE+uXVkIyG3DEpCFQvLqowf9QCikZdefQvnyHREav7w5KPlo6JxRu4rX
         EUqOxcqry+fS/woGm8i8KgsJzdlQ0E2aYMy9NxD5/b/4I1jCuXxAstZ6jCakhr9my9Cw
         azMFk4OC1tKatS9a/IWWr4/yB8zzShdt0IdeXoYxuSd2ni/yKOXwB64a3UATjTiA523V
         AePAHkcOt18/+GMB6kkxYNjMZuNDWCyzHi8G14r2WvGuVrm8bPO0qbG5j+rEluWvKrId
         Xej74db09va4h6Fpw/PEcuzDBQqAirQ+wLVA5ewGKVouo4Th/Jq2UuBX3MjR0rCyK3Ha
         KUDw==
X-Forwarded-Encrypted: i=1; AJvYcCUAqaE+A+oI4Zgp/z4xV3bC6AHLe4cde6hJ9crNH5DRNfvJ4Ad0Y1OwQA0kHe1GfN8CVusTPuEFU7W528RC@vger.kernel.org, AJvYcCUYSAVuWgm06m0QmRx5Xj7LC1Bdf2C09Emzl5ghBnlRHSEJV0xg7Pfj9v5WJqNeiQQbWd0=@vger.kernel.org, AJvYcCXTHg17qdgf+TC2AnUFYJyuHn2je5JqHeqk+jdlaBOB1GQDeWP0N0bIfbWqKoCrSjYbd4e73HiByVLF1xFPln1LWlh8@vger.kernel.org
X-Gm-Message-State: AOJu0YykDFOgpfXyQn82oUvfZIWW1HoJ4CqeU+6lg6mQ58EEo/1Ddgmm
	xvuP65Bxtwf//apGRBaYpGZFwppmaZYq/Q1itp3NjWfK84jb3F3Lg5L5wMK6rxgmIL4jV9lQ6uN
	KxtM2s3luTAhTYuX7TYHFGNu5OgE=
X-Gm-Gg: ASbGnctowCXj57SRw4atLFwimUgn3w7YhiuX4bwtlWYmdTucfvOKlEQTJAkneD1PA4N
	YqFCYNKpK7f5czW4H9R8Q4m5zIzn+YAqT6o5KmOK8KHzaJKrz6hfS6dr9t2ExXaoX/SCF4kGT15
	vmwWudbQYrdUWONaVk8ZGxx6w=
X-Google-Smtp-Source: AGHT+IHsSKy0T7sdcs4I2FEkuaNkK7bILTKkVn2wt0nhnlEcx+SvEXfJ4UMs9iDgKxGsLFd8VjPkE5dVXO8KtBx5rUk=
X-Received: by 2002:a17:90b:2b8f:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2fce78abc52mr24475660a91.13.1740435843616; Mon, 24 Feb 2025
 14:24:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024044159.3156646-1-andrii@kernel.org> <20241024044159.3156646-3-andrii@kernel.org>
 <20250224-impressive-onyx-boa-36e85d@leitao>
In-Reply-To: <20250224-impressive-onyx-boa-36e85d@leitao>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Feb 2025 14:23:51 -0800
X-Gm-Features: AQ5f1JpfI7abF10iTCDj7j_zg8l0eSl_hAPcLgNgy53Fx-Uv0srnK7x4gcTeuPk
Message-ID: <CAEf4BzbupJe10k0MROG5iZq6cYu6PRoN3sHhNK=L7eDLOULvNQ@mail.gmail.com>
Subject: Re: [PATCH v3 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
To: Breno Leitao <leitao@debian.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mingo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:23=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hello Andrii,
>
> On Wed, Oct 23, 2024 at 09:41:59PM -0700, Andrii Nakryiko wrote:
> >
> > +static struct uprobe* hprobe_expire(struct hprobe *hprobe, bool get)
> > +{
> > +     enum hprobe_state hstate;
> > +
> > +     /*
> > +      * return_instance's hprobe is protected by RCU.
> > +      * Underlying uprobe is itself protected from reuse by SRCU.
> > +      */
> > +     lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretp=
robes_srcu));
>
> I am hitting this warning in d082ecbc71e9e ("Linux 6.14-rc4") on
> aarch64. I suppose this might happen on x86 as well, but I haven't
> tested.
>
>         WARNING: CPU: 28 PID: 158906 at kernel/events/uprobes.c:768 hprob=
e_expire (kernel/events/uprobes.c:825)
>
>         Call trace:
>         hprobe_expire (kernel/events/uprobes.c:825) (P)
>         uprobe_copy_process (kernel/events/uprobes.c:691 kernel/events/up=
robes.c:2103 kernel/events/uprobes.c:2142)
>         copy_process (kernel/fork.c:2636)
>         kernel_clone (kernel/fork.c:2815)
>         __arm64_sys_clone (kernel/fork.c:? kernel/fork.c:2926 kernel/fork=
.c:2926)
>         invoke_syscall (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/=
syscall.c:49)
>         do_el0_svc (arch/arm64/kernel/syscall.c:139 arch/arm64/kernel/sys=
call.c:151)
>         el0_svc (arch/arm64/kernel/entry-common.c:165 arch/arm64/kernel/e=
ntry-common.c:178 arch/arm64/kernel/entry-common.c:745)
>         el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:797)
>         el0t_64_sync (arch/arm64/kernel/entry.S:600)
>
> I broke down that warning, and the problem is on related to
> rcu_read_lock_held(), since RCU read lock does not seem to be held in
> this path.
>
> Reading this code, RCU read lock seems to protect old hprobe, which
> doesn't seem so.
>
> I am wondering if we need to protect it properly, something as:
>
>         @@ -2089,7 +2092,9 @@ static int dup_utask(struct task_struct *t,=
 struct uprobe_task *o_utask)
>                                 return -ENOMEM;
>
>                         /* if uprobe is non-NULL, we'll have an extra ref=
count for uprobe */
>         +               rcu_read_lock();
>                         uprobe =3D hprobe_expire(&o->hprobe, true);
>         +               rcu_write_lock();
>

I think this is not good enough. rcu_read_lock/unlock should be around
the entire for loop, because, technically, that return_instance can be
freed before we even get to hprobe_expire.

So, just like we have guard(srcu)(&uretprobes_srcu); we should have
guard(rcu)();

Except, there is that kmemdup() hidden inside dup_return_instance(),
so we can't really do that.

So that leaves us with an option to split memory allocation and
initialization. Number of return instances can't grow (but can
shrink), so we can first count them, allocate memory. Then do another
iteration to do hprobe_expire().

I'll try to send a patch some time in the next day or two, but maybe
someone has some better ideas meanwhile.

>                         /*
>                         * New utask will have stable properly refcounted =
uprobe or

