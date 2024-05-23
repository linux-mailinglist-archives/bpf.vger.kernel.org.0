Return-Path: <bpf+bounces-30364-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5698CCB65
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 06:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53F0283417
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651486BB39;
	Thu, 23 May 2024 04:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O98hIspS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123883C0B
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 04:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438745; cv=none; b=Rmc6CD+8/+YElEhnCVeFn0Kb/jfcjnuCCzC/Oejvb1gzypbnvyxjy1/+sccqpZkPde6zm1XHT9jBN+0aDmXgXwlL3ZgURM7SMGC1mjJ3kF+0fqJDWKoFosqalzYb+bX5zfuO3m+6tpqNbrLkP3up2j45XOo4agLFofbIuvUrVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438745; c=relaxed/simple;
	bh=UoX23x5JW8Z3ds5EudMlO2qDw1RLd+y7bQ+od/1n9U0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMOGvfDwdCIv9jj+Gx3E3lnJSPHiEa7ImUdZIjQFZCQGA8ipzuAmC9v+A1xT6pyFMkh3hOaXWExochnDE613VhuRnH53kPpIgTlVO7Nvk6TkfwtgLL/h36BJj9vtD5FG6YE5VwV9kDkDebh3tiEwOLrnYL2V+Apq0OdE242pNg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O98hIspS; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e724bc46bfso49545711fa.3
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 21:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716438742; x=1717043542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9h4zPh4K8uGnEVy/2a47WKj8aJigtC/aekz4srz2Cqk=;
        b=O98hIspShRmvWocLPOqz4mLoJC5rZ+T9TFY4L6S67k8AbgM0H07EbqyBYh6JALqvAx
         XjrxvdFUNDUJ2RsyEPobgmWyqGMHWWhhq5sR3ITMTIRU1SFHGk6Cb/kxdjKcCMN0d3bA
         3ek5n+u8yWCPorBXMO1kLhAcpH7dLDQDhgMTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438742; x=1717043542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9h4zPh4K8uGnEVy/2a47WKj8aJigtC/aekz4srz2Cqk=;
        b=CPvQDco2bNfcJmi+PbGDWTkPtnBGzkO0HHhypW2+gfzpvHcjKgIeRdDLTyfO7JZGFl
         pr/6WtkwMD/1/+DLI/AK8+bXkvM8oL8o1o4/wlxEsfDgkrXvfU5i7aMO65er3JnNqu2O
         1DU+ozUKgvxtLzRRnGsaclBZmsm5T+qgYhHxQ/no1HEpBeC0qw50aK28beXA3N036tsO
         D89srLe7m/E1CIpYDsNeTCXRJ2N8ObdOSlJEvsaqqq6p1bdwb4s5ssKsr7V4PZEC1Hz+
         nBFJHihsybLoE4f3FboQ5rBReDmsZlbY3rtIUP2LyaxuTLqMtv+ob0MGnt5pYEPFb2iE
         bb+A==
X-Gm-Message-State: AOJu0Yw+3/JtVp+IywORqnWmAkXvI+xOp8wyzCQQKDJfu+Di6gHWKOvz
	VDVoBRSEyGwZqG+kTAyS6CIu0OEdMu/Dh62go2lmoiIKPfGrqBhTXpT5ataYSxO6v6In+fkhSus
	KY7JHdg==
X-Google-Smtp-Source: AGHT+IHNMtCKYVa+3ZejwzwAuuoAkQJzAVzW2E4Np6NDSLZEU4dLran8yaz65DlfnBOoLitRrBClNw==
X-Received: by 2002:ac2:5f61:0:b0:516:c763:b4f5 with SMTP id 2adb3069b0e04-526bd694ef5mr2201637e87.3.1716438741909;
        Wed, 22 May 2024 21:32:21 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-528199eca08sm106122e87.163.2024.05.22.21.32.20
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 21:32:20 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51f2ebbd8a7so8785818e87.2
        for <bpf@vger.kernel.org>; Wed, 22 May 2024 21:32:20 -0700 (PDT)
X-Received: by 2002:ac2:44a6:0:b0:51b:e0f0:e4f8 with SMTP id
 2adb3069b0e04-526be31647bmr2349723e87.31.1716438740075; Wed, 22 May 2024
 21:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com> <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
In-Reply-To: <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 May 2024 21:32:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
Message-ID: <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 19:38, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Indeed, the 16-byte limit is hard-coded in certain BPF code:

It's worse than that.

We have code like this:

    memcpy(__entry->comm, t->comm, TASK_COMM_LEN);

and it looks like this code not only has a fixed-size target buffer of
TASK_COMM_LEN, it also just uses "memcpy()" instead of "strscpy()",
knowing that the source has the NUL byte in it.

If it wasn't for that memcpy() pattern, I think this trivial patch
would "JustWork(tm)"

  diff --git a/fs/exec.c b/fs/exec.c
  index 2d7dd0e39034..5829912a2fa0 100644
  --- a/fs/exec.c
  +++ b/fs/exec.c
  @@ -1239,7 +1239,7 @@ char *__get_task_comm(char *buf, size_t
buf_size, struct task_struct *tsk)
   {
        task_lock(tsk);
        /* Always NUL terminated and zero-padded */
  -     strscpy_pad(buf, tsk->comm, buf_size);
  +     strscpy_pad(buf, tsk->real_comm, buf_size);
        task_unlock(tsk);
        return buf;
   }
  @@ -1254,7 +1254,7 @@ void __set_task_comm(struct task_struct *tsk,
const char *buf, bool exec)
   {
        task_lock(tsk);
        trace_task_rename(tsk, buf);
  -     strscpy_pad(tsk->comm, buf, sizeof(tsk->comm));
  +     strscpy_pad(tsk->real_comm, buf, sizeof(tsk->real_comm));
        task_unlock(tsk);
        perf_event_comm(tsk, exec);
   }
  diff --git a/include/linux/sched.h b/include/linux/sched.h
  index 61591ac6eab6..948220958548 100644
  --- a/include/linux/sched.h
  +++ b/include/linux/sched.h
  @@ -299,6 +299,7 @@ struct user_event_mm;
    */
   enum {
        TASK_COMM_LEN = 16,
  +     REAL_TASK_COMM_LEN = 24,
   };

   extern void sched_tick(void);
  @@ -1090,7 +1091,10 @@ struct task_struct {
         * - access it with [gs]et_task_comm()
         * - lock it with task_lock()
         */
  -     char                            comm[TASK_COMM_LEN];
  +     union {
  +             char    comm[TASK_COMM_LEN];
  +             char    real_comm[REAL_TASK_COMM_LEN];
  +     };

        struct nameidata                *nameidata;

and the old common pattern of just printing with '%s' and tsk->comm
would just continue to work:

        pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
                current->comm, page_to_pfn(page));

but will get a longer max string.

Of course, we have code like this in security/selinux/selinuxfs.c that
is literally written so that it won't work:

        if (new_value) {
                char comm[sizeof(current->comm)];

                memcpy(comm, current->comm, sizeof(comm));
                pr_err("SELinux: %s (%d) set checkreqprot to 1. This
is no longer supported.\n",
                       comm, current->pid);
        }

which copies to a temporary buffer (which now does *NOT* have a
closing NUL character), and then prints from that. The intent is to at
least have a stable buffer, but it basically relies on the source of
the memcpy() being stable enough anyway.

That said, a simple grep like this:

    git grep 'memcpy.*->comm\>'

more than likely finds all relevant cases. Not *that* many, and just
changing the 'memcpy()' to 'copy_comm()' should fix them all.

The "copy_comm()" would trivially look something like this:

   memcpy(dst, src, TASK_COMM_LEN);
   dst[TASK_COMM_LEN-1] = 0;

and the people who want that old TASK_COMM_LEN behavior will get it,
and the people who just print out ->comm as a string will magically
get the longer new "real comm".

And people who do "sizeof(->comm)" will continue to get the old value
because of the hacky union. FWIW.

Anybody want to polish up the above turd? It doesn't look all that
hard unless I'm missing something, but needs some testing and care.

                Linus

