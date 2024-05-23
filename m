Return-Path: <bpf+bounces-30398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E4B8CD322
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 15:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9571C220FD
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC02414A4DF;
	Thu, 23 May 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbMXaBOI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113713C8FF;
	Thu, 23 May 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716469454; cv=none; b=LKOsj4XsS5uFMDu2DVavf3/qP42JBxcn5FMTRlcF0+N2NuaoO0s2Wyl8ZDbbRIRNI66NqmbrH9Us39XjP1QRkOXJS2rHb4h2vLqdjRhOOU0URZ3Ide8Mv3pg4pOjmnKsEQ2zFPU4nKCHpD/sGKxpUtG/mIiFA8y122W3oFmKzTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716469454; c=relaxed/simple;
	bh=bxGtTWy1GarmuvLvpXcuxsTNg8vH5BafRYt5eBpbYc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwV0pJqgWBjhWE/VskC0RmZlElYSZG4qEOzhky/aa+emZRVZLCgovMPLdT75sQk/aBg3Ws5Sd17CP8v9olLZxrJB5o06uqp7JDnd3cH/qIB48yZcRrjEfdAwEh93s0WlW7twSlWlNHBgG8hCJ3DTtC6XAJ/w41rjtBzhbWHjuVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbMXaBOI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6ab8e759adbso8113376d6.0;
        Thu, 23 May 2024 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716469452; x=1717074252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QugtyGwjGbAPX1Dy+otOhYo8FoEI57emQEUwIRWflfs=;
        b=dbMXaBOIQoKcY/5KSXWogpbta2OStdp7+PqAp6mBvKTHufl0W6hb/8A5L0v4A+09qD
         36WrXU2gG15c1zA62QawOAhB1gVUKDXwZyAqNi/upBJaSWQHnBr7u8NJXs2IBPC2b1Sk
         jD/O+2N9IzVCwWcQf8jSP9fSo5QS95w6SBDd3JmlhLz5R6OyTj/TFYlDWtRAyak6ftdt
         ybEjpzAiuRcMyKvmh3DxRVIRZnjsf2mObtMTZTmfnHQqbz37+B9ktNJD0tEhPy72D/b5
         uhNsFwpYHcgz4LzUvHAHqQuG7av3X7wX1xbNxQw9t66Cw76yyjdg6iAfRotzC7wJ5MUe
         xoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716469452; x=1717074252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QugtyGwjGbAPX1Dy+otOhYo8FoEI57emQEUwIRWflfs=;
        b=h74sKuE92EeBEs/b6VuMrrcbmvxuoEFCOzi/FhlIW/t5U5VQFdYCcTs4eHIQDZSVSk
         fTO7vz3BdV4QXH3a6FUnB+9bDhqP/2WbShdEBuvrj45GGeg/w4BDQ6ci3+rHeHqp6BwS
         m7k/zaPfav+ipICo68sVosT+bwIykrOPfsHVMFxOft2CtRcxUuLFuk5ylCDR7D9FJ7+r
         IvPnM/9Z+URM9Gri0hcFyXxePh7L9r8JNtAyQTYl7pjyjVxBKNYGROBOJF7d95DM1L21
         Hut+xJ4qvJRE1pN7/ZmPZ7Ul9CGNn9AR+z18Y7p+HWVW9/VIRuD0wFdAXixU1kBPvKJ0
         HYiw==
X-Forwarded-Encrypted: i=1; AJvYcCWulJkvp8gzcUcGQsVHQ+z7OnzyYmaRzTLORdia/QTBy9tVeJwL/iAPB+tsvJn95LZuyKoaTB4qejibI4l0NVZQ90inuMi/hhUrB458
X-Gm-Message-State: AOJu0YzrKs9+wMwFHffv9DBB94NteghpkJMcmau/tZdY4kF5c0XAoi4f
	Y4AShucbMbJBp2jnoUErW7GhsbSbV9iLQEFWtcXObLvdCUzYcnhXDgpkcujN+9sSj1NnMdj9Hvb
	Jlh2SIXmM9y/JF4RZ/dYgYh0WrDc=
X-Google-Smtp-Source: AGHT+IF5qi8krbxqSXnU03+j6Y1BxniPLOqIBfqvtFBl5cRcHibXPKgNf/jaHr62Wy60eFMS0VvnA3n+REokvHBmV20=
X-Received: by 2002:a05:6214:19e3:b0:6aa:39a7:a63d with SMTP id
 6a1803df08f44-6ab8f60c45bmr36919296d6.32.1716469451550; Thu, 23 May 2024
 06:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com> <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
In-Reply-To: <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 23 May 2024 21:03:34 +0800
Message-ID: <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 22 May 2024 at 19:38, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > Indeed, the 16-byte limit is hard-coded in certain BPF code:
>
> It's worse than that.
>
> We have code like this:
>
>     memcpy(__entry->comm, t->comm, TASK_COMM_LEN);
>
> and it looks like this code not only has a fixed-size target buffer of
> TASK_COMM_LEN, it also just uses "memcpy()" instead of "strscpy()",
> knowing that the source has the NUL byte in it.
>
> If it wasn't for that memcpy() pattern, I think this trivial patch
> would "JustWork(tm)"
>
>   diff --git a/fs/exec.c b/fs/exec.c
>   index 2d7dd0e39034..5829912a2fa0 100644
>   --- a/fs/exec.c
>   +++ b/fs/exec.c
>   @@ -1239,7 +1239,7 @@ char *__get_task_comm(char *buf, size_t
> buf_size, struct task_struct *tsk)
>    {
>         task_lock(tsk);
>         /* Always NUL terminated and zero-padded */
>   -     strscpy_pad(buf, tsk->comm, buf_size);
>   +     strscpy_pad(buf, tsk->real_comm, buf_size);
>         task_unlock(tsk);
>         return buf;
>    }
>   @@ -1254,7 +1254,7 @@ void __set_task_comm(struct task_struct *tsk,
> const char *buf, bool exec)
>    {
>         task_lock(tsk);
>         trace_task_rename(tsk, buf);
>   -     strscpy_pad(tsk->comm, buf, sizeof(tsk->comm));
>   +     strscpy_pad(tsk->real_comm, buf, sizeof(tsk->real_comm));
>         task_unlock(tsk);
>         perf_event_comm(tsk, exec);
>    }
>   diff --git a/include/linux/sched.h b/include/linux/sched.h
>   index 61591ac6eab6..948220958548 100644
>   --- a/include/linux/sched.h
>   +++ b/include/linux/sched.h
>   @@ -299,6 +299,7 @@ struct user_event_mm;
>     */
>    enum {
>         TASK_COMM_LEN =3D 16,
>   +     REAL_TASK_COMM_LEN =3D 24,
>    };
>
>    extern void sched_tick(void);
>   @@ -1090,7 +1091,10 @@ struct task_struct {
>          * - access it with [gs]et_task_comm()
>          * - lock it with task_lock()
>          */
>   -     char                            comm[TASK_COMM_LEN];
>   +     union {
>   +             char    comm[TASK_COMM_LEN];
>   +             char    real_comm[REAL_TASK_COMM_LEN];
>   +     };
>
>         struct nameidata                *nameidata;
>
> and the old common pattern of just printing with '%s' and tsk->comm
> would just continue to work:
>
>         pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
>                 current->comm, page_to_pfn(page));
>
> but will get a longer max string.
>
> Of course, we have code like this in security/selinux/selinuxfs.c that
> is literally written so that it won't work:
>
>         if (new_value) {
>                 char comm[sizeof(current->comm)];
>
>                 memcpy(comm, current->comm, sizeof(comm));
>                 pr_err("SELinux: %s (%d) set checkreqprot to 1. This
> is no longer supported.\n",
>                        comm, current->pid);
>         }
>
> which copies to a temporary buffer (which now does *NOT* have a
> closing NUL character), and then prints from that. The intent is to at
> least have a stable buffer, but it basically relies on the source of
> the memcpy() being stable enough anyway.
>
> That said, a simple grep like this:
>
>     git grep 'memcpy.*->comm\>'
>
> more than likely finds all relevant cases. Not *that* many, and just
> changing the 'memcpy()' to 'copy_comm()' should fix them all.
>
> The "copy_comm()" would trivially look something like this:
>
>    memcpy(dst, src, TASK_COMM_LEN);
>    dst[TASK_COMM_LEN-1] =3D 0;
>
> and the people who want that old TASK_COMM_LEN behavior will get it,
> and the people who just print out ->comm as a string will magically
> get the longer new "real comm".
>
> And people who do "sizeof(->comm)" will continue to get the old value
> because of the hacky union. FWIW.
>
> Anybody want to polish up the above turd? It doesn't look all that
> hard unless I'm missing something, but needs some testing and care.

If it's not urgent and no one else will handle it, I'll take care of
it. However, I might not be able to complete it quickly.

--=20
Regards
Yafang

