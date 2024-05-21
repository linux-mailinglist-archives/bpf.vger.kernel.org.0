Return-Path: <bpf+bounces-30094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 498408CAB6E
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 12:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4529281733
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E9657A7;
	Tue, 21 May 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYmK+cQC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF57224F0
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285871; cv=none; b=Q0kYp3AefMX0MlXOkZ1LVUw+d3QNQ19lJg4PxtkhR7cq1gEnZCkOlkgGmcoo/xhzcXG87ZLz2YfO9pexYVDwJo/8MJu2rsS4k9ueBCkKCM0SRWGpgji4yL3B3qljL25QUtQDCsJffz7oCy1ToK6+34JttIjTeQQV3614/UhwNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285871; c=relaxed/simple;
	bh=sAHP/tuCS0qnB5xMmdn8pFjEP5toVMOx2T9cIa0Fhdg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f77Pro6VKpX3OKfnurdI3ZObTTvcjzMAGBBO9QpX74FIYAfG4YDDVQGZu/LyMJ4iXAzqykh6JM2JnVZBcVtZIW2+Ez9yiFiSauF6rtPkgT0IDa6OfPmiTt79B98fx2PMxGBF6EJDmRAoJqzVbDLg5sxVI78Z0nWEiYUAnnOzKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYmK+cQC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e1f3462caso8768443a12.3
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 03:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716285868; x=1716890668; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+PXDhJb5CTA3QbLRXbH1PQBgs5Palh7itilO7W2tsNk=;
        b=VYmK+cQCht0YXdanoEk9gtzrZCykRpFB3beBNo251CwcAsrf2jTFNeOBqaOChZ7j7B
         TognSg8lR9N9BjWkMBnCAZfLzpR5noKIsmojQFaSUger5v4RpgecLx/6vHc4uzyBffd6
         HWI4fASmQXQnKU6rbg7hyjWs9DkJwHcWtrTt1Qqd7mrGPlIVca3xFQ77UDomC1C3A/GG
         URgeFUjhFSkVTHwyKtZrldfkAhKg9XyBADuCQhUVGEL/6+wwC5brp1uhvzYtv9MZgWMh
         vzhi1beLBGaxjNunN5UmAx9QefY2vZTNXte36uQyTqVwuVUr6SlhH5oC1/RvbIrxkuvN
         46yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285868; x=1716890668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PXDhJb5CTA3QbLRXbH1PQBgs5Palh7itilO7W2tsNk=;
        b=hySZiEJBqRzMzpfg9M5suz+0YeDbNGZ68jlSa7W+A8NBbcOmGaLuOzO3eCDIIw0hE7
         vCfxAT0GIrEFlQMptxBlTdWT+ZlCRT3or4CB1bpJy/ulJn89bxvOJU6w708vry1NAVeC
         ilOXAsKF1A6Kw1XCvqoPFJbv4fRdZMUN9sasqm2QFSNF2CxqTo3ZM2EBvZb4jvk6b0Rz
         I+Bjp/7XCnoasNzVunZdtoAqWWuozbg5520M1KzMIbOZ96icVAbVHat8tUftKPUfMjTO
         3nF6IdvsyHvNcba9qythRB24wqmR6oH7HSxH89xngu/qCXoDbgHw5TiOv/530cNHYVj6
         4Qyw==
X-Forwarded-Encrypted: i=1; AJvYcCXbmPzjw6xOpjbr0VsZ+qhoyYcCq5nJT7VvvdOJ39sjQ6T9bes22vJ8W2i9zQbMSGblW2wCmAPhyvi+wYLsMR1xd78N
X-Gm-Message-State: AOJu0YxfvPHXhwKZ/Q6nIJzqwGIPTJrnHtNgQyvpdpLzbW8w2y0Zzz/9
	71eeL/jzGsImDXf/VPCGoo49oUzM7n2lRUfbDl8iXVpe0E4XUfY9
X-Google-Smtp-Source: AGHT+IGq6KyK2MzlcuZSbCfkbvRuuTlKbra6Zh1xmPKro3fjmaJRIOHMc1LDRSaz4dAxn+g13RCTFQ==
X-Received: by 2002:a50:870d:0:b0:56d:fca5:4245 with SMTP id 4fb4d7f45d1cf-5734d5c0f47mr20953865a12.10.1716285868164;
        Tue, 21 May 2024 03:04:28 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ec5fb906sm9010471a12.30.2024.05.21.03.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:04:27 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 May 2024 12:04:25 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH bpf 5/5] selftests/bpf: extend multi-uprobe tests with
 USDTs
Message-ID: <Zkxxqayh9VtHGQuj@krava>
References: <20240520234720.1748918-1-andrii@kernel.org>
 <20240520234720.1748918-6-andrii@kernel.org>
 <CAEf4BzaZxUV4t5T8itBydzgm2r4XKThZ9WQLgsJ9auZEfQTntg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaZxUV4t5T8itBydzgm2r4XKThZ9WQLgsJ9auZEfQTntg@mail.gmail.com>

On Mon, May 20, 2024 at 09:54:40PM -0700, Andrii Nakryiko wrote:
> On Mon, May 20, 2024 at 4:47 PM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Validate libbpf's USDT-over-multi-uprobe logic by adding USDTs to
> > existing multi-uprobe tests. This checks correct libbpf fallback to
> > singular uprobes (when run on older kernels with buggy PID filtering).
> > We reuse already established child process and child thread testing
> > infrastructure, so additions are minimal. These test fail on either
> > older kernels or older version of libbpf that doesn't detect PID
> > filtering problems.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  .../bpf/prog_tests/uprobe_multi_test.c        | 22 +++++++++++++
> >  .../selftests/bpf/progs/uprobe_multi.c        | 33 +++++++++++++++++--
> >  2 files changed, 53 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > index 677232d31432..85d46e568e90 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> > @@ -8,6 +8,7 @@
> >  #include "uprobe_multi_usdt.skel.h"
> >  #include "bpf/libbpf_internal.h"
> >  #include "testing_helpers.h"
> > +#include "../sdt.h"
> >
> >  static char test_data[] = "test_data";
> >
> > @@ -26,6 +27,11 @@ noinline void uprobe_multi_func_3(void)
> >         asm volatile ("");
> >  }
> >
> > +noinline void usdt_trigger(void)
> > +{
> > +       STAP_PROBE(test, pid_filter_usdt);
> > +}
> > +
> >  struct child {
> >         int go[2];
> >         int c2p[2]; /* child -> parent channel */
> > @@ -269,8 +275,24 @@ __test_attach_api(const char *binary, const char *pattern, struct bpf_uprobe_mul
> >         if (!ASSERT_OK_PTR(skel->links.uprobe_extra, "bpf_program__attach_uprobe_multi"))
> >                 goto cleanup;
> >
> > +       /* Attach (uprobe-backed) USDTs */
> > +       skel->links.usdt_pid = bpf_program__attach_usdt(skel->progs.usdt_pid, pid, binary,
> > +                                                       "test", "pid_filter_usdt", NULL);
> > +       if (!ASSERT_OK_PTR(skel->links.usdt_pid, "attach_usdt_pid"))
> > +               goto cleanup;
> > +
> > +       skel->links.usdt_extra = bpf_program__attach_usdt(skel->progs.usdt_extra, -1, binary,
> > +                                                         "test", "pid_filter_usdt", NULL);
> > +       if (!ASSERT_OK_PTR(skel->links.usdt_extra, "attach_usdt_extra"))
> > +               goto cleanup;
> > +
> >         uprobe_multi_test_run(skel, child);
> >
> > +       ASSERT_FALSE(skel->bss->bad_pid_seen_usdt, "bad_pid_seen_usdt");
> > +       if (child) {
> > +               ASSERT_EQ(skel->bss->child_pid_usdt, child->pid, "usdt_multi_child_pid");
> > +               ASSERT_EQ(skel->bss->child_tid_usdt, child->tid, "usdt_multi_child_tid");
> > +       }
> >  cleanup:
> >         uprobe_multi__destroy(skel);
> >  }
> > diff --git a/tools/testing/selftests/bpf/progs/uprobe_multi.c b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > index 86a7ff5d3726..44190efcdba2 100644
> > --- a/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > +++ b/tools/testing/selftests/bpf/progs/uprobe_multi.c
> > @@ -1,8 +1,8 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > -#include <linux/bpf.h>
> > +#include "vmlinux.h"
> >  #include <bpf/bpf_helpers.h>
> >  #include <bpf/bpf_tracing.h>
> > -#include <stdbool.h>
> > +#include <bpf/usdt.bpf.h>
> >
> >  char _license[] SEC("license") = "GPL";
> >
> > @@ -23,9 +23,12 @@ __u64 uprobe_multi_sleep_result = 0;
> >  int pid = 0;
> >  int child_pid = 0;
> >  int child_tid = 0;
> > +int child_pid_usdt = 0;
> > +int child_tid_usdt = 0;
> >
> >  int expect_pid = 0;
> >  bool bad_pid_seen = false;
> > +bool bad_pid_seen_usdt = false;
> >
> >  bool test_cookie = false;
> >  void *user_ptr = 0;
> > @@ -112,3 +115,29 @@ int uprobe_extra(struct pt_regs *ctx)
> >         /* we need this one just to mix PID-filtered and global uprobes */
> >         return 0;
> >  }
> > +
> > +SEC("usdt")
> > +int usdt_pid(struct pt_regs *ctx)
> > +{
> > +       __u64 cur_pid_tgid = bpf_get_current_pid_tgid();
> > +       __u32 cur_pid;
> > +
> > +       cur_pid = cur_pid_tgid >> 32;
> > +       if (pid && cur_pid != pid)
> > +               return 0;
> > +
> > +       if (expect_pid && cur_pid != expect_pid)
> > +               bad_pid_seen_usdt = true;
> > +
> > +       child_pid_usdt = cur_pid_tgid >> 32;
> > +       child_tid_usdt = (__u32)cur_pid_tgid;
> > +
> > +       return 0;
> > +}
> > +
> > +SEC("usdt")
> > +int usdt_extra(struct pt_regs *ctx)
> > +{
> > +       /* we need this one just to mix PID-filtered and global USDT probes */
> > +       return 0;
> > +}
> > --
> > 2.43.0
> >
> 
> I lost the following during the final rebase before submitting,
> sigh... With the piece below tests are passing again:
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 85d46e568e90..bf6ca8e3eb13 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -96,6 +96,7 @@ static struct child *spawn_child(void)
>                 uprobe_multi_func_1();
>                 uprobe_multi_func_2();
>                 uprobe_multi_func_3();
> +               usdt_trigger();
> 
>                 exit(errno);
>         }
> @@ -123,6 +124,7 @@ static void *child_thread(void *ctx)
>         uprobe_multi_func_1();
>         uprobe_multi_func_2();
>         uprobe_multi_func_3();
> +       usdt_trigger();
> 
>         err = 0;
>         pthread_exit(&err);
> @@ -188,6 +190,7 @@ static void uprobe_multi_test_run(struct
> uprobe_multi *skel, struct child *child
>                 uprobe_multi_func_1();
>                 uprobe_multi_func_2();
>                 uprobe_multi_func_3();
> +               usdt_trigger();
>         }
> 
>         if (child)
> 
> 
> I'll wait till tomorrow for any feedback and will post v2.

tests are passing for me with the changes above

> 
> I'm also curious about logistics? Do we want to get everything through
> the bpf tree? Or bpf-next? Or split somehow? Thoughts?
> 
> I think the fix in patch #1 is important enough to backport to stable
> kernels (multi-uprobes went into upstream v6.6 kernel, FYI).

agreed, perhaps also the patch #3 for libbpf detection?

jirka

