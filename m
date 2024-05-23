Return-Path: <bpf+bounces-30358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6BC8CCACC
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 04:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB0B1C211EE
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4D613A86E;
	Thu, 23 May 2024 02:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/zpiOWX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785412BEAC;
	Thu, 23 May 2024 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431936; cv=none; b=FSmKbR2B8ZptUuefZE5N/jfG/F4Zp1DMG19IePudxfviaaBy5TSKn8xuwlCwabYWbaYmC8Kp/iQ0PUz9JhMk9XpbBpBwgwpt0po94JSCKg5tqNurfAMhV7UC2SU/5rtRcis8T7mvvvKmFlqJF/tXlqyqClKMs4ZflzbWvkvh95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431936; c=relaxed/simple;
	bh=c150eyXSG09ax/tuSQxo/vmwAamar5JegtikCRIL3Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7qUtG+VaSlTZ3bA0jLjtTXAYqKiKeTxRsjcCsHDg6ZYBeVERhlcQQp07VWCf7jGVDWzBKM6bdIkvvbrE9NRlDz7HJaQq+cYtN8BBr8B8fi6i8wuyjotg8Q//2vQlflQFn0W83WzSWyiYOprJLP8d725SGDw6cqrY+omnoeCROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/zpiOWX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-43de92e228aso35115141cf.1;
        Wed, 22 May 2024 19:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716431933; x=1717036733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZtfxnLd2/r+HBGWTRVrrUFtrRVnkTfP4AwbLWkC7Ps=;
        b=A/zpiOWXfD7mh/aX/4oFXpgI2UtG0S2/kWwqHaZrBYMSINwRA4A7XemkuGQoUvhi6z
         b2eUAoKNU4Xr6f/lm9OPCbpL0PsJjzHmyuPxEXZ3DGjf6ISLE0ti4fXI1nFqp5RKbwTP
         9nFToWO46QHKMLMn8FQJ18EzZlEFx9v/Dr1O3juKnVWS1xkddGjJFFx+B9KoI5YOLRgp
         4s9MWVG1KsVIfx9rr7U/NzNmp46NxyOHYaXxktivzE1poD0jizFmWXBTUcIs5a9WZ33L
         F/DhP6v7u/3n1t4qNTrsqfdo6KYW7AxwPVzQRbbwf/m2nCONVw21nNCiEkB2oG4fhcYk
         1bYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716431933; x=1717036733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZtfxnLd2/r+HBGWTRVrrUFtrRVnkTfP4AwbLWkC7Ps=;
        b=I6aH3lflbJira6SfGcNiAHpdUGtp+TT3lnCFqKFLPREooihsC/T1O+vTOt3X4u8VRL
         1GWJkBeNtUJD5T4JQ3RKuCsB7duB/or/9jVjvhljqQXcrk8fjMgPRn0WOfaqCwtoOop/
         XGgkUmi5Aq/na/imfV+nCS8jD+FdefT2BUDQMrY5WAsyzoGaW0b3XL4/G57QdOKR90tH
         EimOV1Cta8aNXr097hdyCJR4T8G6F4kixuIxRFMYhdDJiiEZ1w/FyFa7d3sQm6pracI5
         wtwWUzoEBFajYqGYWb5urye0pyrRIld6w0/kvxY61QqJPF2GaNp9TA6gKTntaZAmDxgh
         VY2g==
X-Forwarded-Encrypted: i=1; AJvYcCWvyknf3yWt46YHNMx7gfunLQZSYrIYNwLx03K/ZDjF+Sj5td9Qwpcez7FqdMJ8dXkDjfak93CHJIRDMUEgq96SBlDThWcnmvJhTyErRGiSJX3PzTmECsH9j01dNmKuAve6
X-Gm-Message-State: AOJu0YwfXv96mHDXZrV3UiIytSAWq/0n1AyaU/pRgRv5cTXOKvCVJI6b
	vFuGhmRXKDYGAHrCPpNc1TE3BGh2UMA8UKK7/3Y1OK8Tf2JISCOipAc6tNs3Btz3op05Z+NHp10
	2yMr1DNKzBPvVTIxXXSgj3Xz/t+0=
X-Google-Smtp-Source: AGHT+IH3JniY0spg98nO80aPZUSIymONa/6OB/gqUXHqeemMB+MNrIDWIKJR9zRKIWSqiAk80Drv8W5mKGkqvLnYpPo=
X-Received: by 2002:a05:622a:8a:b0:43a:fb9a:c117 with SMTP id
 d75a77b69052e-43f9e0d3bd2mr37092321cf.37.1716431933305; Wed, 22 May 2024
 19:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
In-Reply-To: <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 23 May 2024 10:38:17 +0800
Message-ID: <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, Craig Small <csmall@enc.com.au>, 
	linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:06=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 20 May 2024 at 19:34, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > We discussed extending it to 24 characters several years ago [0], but
> > some userspace tools might break.
>
> Well, the fact that we already expose names longer than 16 bytes in
> /proc means that at least *that* side of it could use an extended
> comm[] array.
>
> Yes, some other interfaces might want to still use a 16-byte limit as
> the length for the buffers they use (tracing?) but I suspect we could
> make the comm[] array easily bigger.

Indeed, the 16-byte limit is hard-coded in certain BPF code:

$ grep -r "comm\["  tools/testing/selftests/bpf/
tools/testing/selftests/bpf//prog_tests/ringbuf_multi.c: char comm[16];
tools/testing/selftests/bpf//prog_tests/sk_storage_tracing.c: char comm[16]=
;
tools/testing/selftests/bpf//prog_tests/test_overhead.c: char comm[16] =3D =
{};
tools/testing/selftests/bpf//prog_tests/ringbuf.c: char comm[16];
tools/testing/selftests/bpf//progs/pyperf.h: char comm[TASK_COMM_LEN];
tools/testing/selftests/bpf//progs/dynptr_success.c: char comm[16];
tools/testing/selftests/bpf//progs/test_ringbuf.c: char comm[16];
tools/testing/selftests/bpf//progs/test_ringbuf_n.c: char comm[16];
tools/testing/selftests/bpf//progs/task_kfunc_success.c:
bpf_strncmp(&task->comm[8], 4, "foo");
tools/testing/selftests/bpf//progs/user_ringbuf_fail.c: char comm[16];
tools/testing/selftests/bpf//progs/test_ringbuf_map_key.c: char comm[16];
tools/testing/selftests/bpf//progs/test_core_reloc_kernel.c: char
comm[sizeof("test_progs")];
tools/testing/selftests/bpf//progs/test_core_reloc_kernel.c: char comm[16];
tools/testing/selftests/bpf//progs/dynptr_fail.c: char comm[16];
tools/testing/selftests/bpf//progs/strobemeta.h: char comm[TASK_COMM_LEN];
tools/testing/selftests/bpf//progs/core_reloc_types.h: char
comm[sizeof("test_progs")];
tools/testing/selftests/bpf//progs/core_reloc_types.h: char
comm[sizeof("test_progs")];
tools/testing/selftests/bpf//progs/test_skb_helpers.c: char comm[TEST_COMM_=
LEN];
tools/testing/selftests/bpf//progs/test_tracepoint.c: char
prev_comm[TASK_COMM_LEN];
tools/testing/selftests/bpf//progs/test_tracepoint.c: char
next_comm[TASK_COMM_LEN];
tools/testing/selftests/bpf//progs/test_ringbuf_multi.c: char comm[16];
tools/testing/selftests/bpf//progs/test_user_ringbuf.h: char comm[16];
tools/testing/selftests/bpf//progs/test_core_reloc_module.c: char
comm[sizeof("test_progs")];
tools/testing/selftests/bpf//progs/test_stacktrace_map.c: char
prev_comm[TASK_COMM_LEN];
tools/testing/selftests/bpf//progs/test_stacktrace_map.c: char
next_comm[TASK_COMM_LEN];
tools/testing/selftests/bpf//progs/test_sk_storage_tracing.c: char comm[16]=
;
tools/testing/selftests/bpf//progs/test_sk_storage_tracing.c:char
task_comm[16] =3D "";

>
> But what I suspect we should do *first* is to try to get rid of a lot
> of the "current->comm" users. One of the most common uses is purely
> for printing, and we could actually just add a new '%p' pointer for
> printing the current name. That would allow our vsprintf() code to not
> just use tsk->comm, but to use the full_name for threads etc.
>
> So instead of
>
>    printf("%s ..", tsk->comm..);
>
> we could have something like
>
>    printf("%pc ..", tsk);
>
> to print the name of the task.

I believe it's a good start.

>
> That would get rid of a lot of the bare ->comm[] uses, and then the
> rest should probably use proper wrappers for copying the data (ie
> using 'get_task_comm()' etc).
>
> That would not only pick up the better names for printk and oopses, it
> would also make future cleanups simpler (for example, I'd love to get
> rid of the 'comm' name entirely, and replace it with 'exe_name[24]'
> and have the compiler just notice when somebody is trying to access
> 'comm' directly).

Some tools may flag the naming change. Below is a simple grep from
bcc-tools and bpftrace.

bcc $ grep -r "\->comm" tools/
tools//wakeuptime.py:    bpf_probe_read_kernel(&key.target,
sizeof(key.target), p->comm);
tools//bitesize.py:    bpf_probe_read_kernel(&key.name,
sizeof(key.name), args->comm);
tools//tcptracer.py:          evt4.comm[i] =3D p->comm[i];
tools//tcptracer.py:          evt6.comm[i] =3D p->comm[i];
tools//old/wakeuptime.py:    bpf_probe_read(&key.target,
sizeof(key.target), p->comm);
tools//old/oomkill.py:    bpf_probe_read(&data.tcomm,
sizeof(data.tcomm), p->comm);
tools//oomkill.py:    bpf_probe_read_kernel(&data.tcomm,
sizeof(data.tcomm), p->comm);
tools//runqslower.py:    bpf_probe_read_kernel_str(&data.prev_task,
sizeof(data.prev_task), prev->comm);
tools//runqslower.py:    bpf_probe_read_kernel_str(&data.task,
sizeof(data.task), next->comm);
tools//runqslower.py:    bpf_probe_read_kernel_str(&data.prev_task,
sizeof(data.prev_task), prev->comm);
tools//shmsnoop.py:    if (bpf_get_current_comm(&val->comm,
sizeof(val->comm)) !=3D 0)
tools//sslsniff.py:        bpf_get_current_comm(&data->comm,
sizeof(data->comm));
tools//sslsniff.py:        bpf_get_current_comm(&data->comm,
sizeof(data->comm));
tools//fileslower.py:    bpf_probe_read_kernel(&data.comm,
sizeof(data.comm), valp->comm);
tools//mountsnoop.py:    bpf_probe_read_kernel_str(&event.enter.pcomm,
TASK_COMM_LEN, task->real_parent->comm);
tools//mountsnoop.py:    bpf_probe_read_kernel_str(&event.enter.pcomm,
TASK_COMM_LEN, task->real_parent->comm);
tools//gethostlatency.py:    bpf_probe_read_kernel(&data.comm,
sizeof(data.comm), valp->comm);
tools//opensnoop.py:    bpf_probe_read_kernel(&data.comm,
sizeof(data.comm), valp->comm);
tools//killsnoop.py:    bpf_probe_read_kernel(&data.comm,
sizeof(data.comm), valp->comm);

bpftrace $ grep -r "\->comm" tools/
tools//naptime.bt:     $task->real_parent->comm, pid, comm,
tools//oomkill.bt:     $oc->chosen->pid, $oc->chosen->comm, $oc->totalpages=
);


--=20
Regards
Yafang

