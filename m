Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66E4191A77
	for <lists+bpf@lfdr.de>; Tue, 24 Mar 2020 21:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgCXUEO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Mar 2020 16:04:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37547 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgCXUEM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 16:04:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so57342wrm.4
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2020 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Tt0UFZephI2Ue5bqTwLi4oygzZ66RF71KGwdZLCPEUc=;
        b=I/qsK+M8mg3ROchM+A9exgLw0tB88VSlpMAyjRnt9nNEZkmWtxKO0s8/EoYu8ra+KW
         qEVkYgcQIJp+6+Npg20aBla+BEc7SrWjGM0Kapss2WJ9ubRfux3/i4CVQWgnAOw8ObjB
         L52YEZ1nl0YNOk3W17tEwtyyNYaNNi6JYQ8BE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Tt0UFZephI2Ue5bqTwLi4oygzZ66RF71KGwdZLCPEUc=;
        b=eIr7Pg+7Wr11L8IUHg7cA8KWfnGjRP+U8HmTU6BE2Bw0GeBixEVvj9CcaGeyYaiXUY
         0VOBmblH00ekeXTavB0JZ+pGg5rZQIFcJ9fo9YhreX93WUcsI6gs4jDrVnCA0XyMT0UO
         V4VWBUZHHdWmUUztWjzfc+8WkCS6uBgJgsFv8HdRhbVWkViRdpq5STvUSEcY0h7BPVPI
         b5kiY5L2NPaSmt4kbxKwHPkyhvTdQtSCg53i47cFWtTPG0c265fhEsmyKzqzHE2tr4hc
         a+vZJfPa+MoXCuuHotxl8c9zDRMpWDqdgGyJBWI1e9Tr9f/au8LHalBd7A7YBAuRPjjH
         AViQ==
X-Gm-Message-State: ANhLgQ1YT0tYj0POmX0CF4MK7zOrH4Udro4uK/LbIQaP1ewJWEijEhj+
        +83DQId/Sk+oqDNv3dUpOOf18g==
X-Google-Smtp-Source: ADFU+vthH0wns3m18uz//rU2V4nw/Pj1cyviC8VqVMaZowJr7BllF14x+MIyTlEKCvbu0DZy/YNbig==
X-Received: by 2002:adf:b6a5:: with SMTP id j37mr38231704wre.412.1585080248593;
        Tue, 24 Mar 2020 13:04:08 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id o16sm31229588wrs.44.2020.03.24.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:04:07 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 24 Mar 2020 21:04:05 +0100
To:     Yonghong Song <yhs@fb.com>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH bpf-next v5 7/7] bpf: lsm: Add selftests for
 BPF_PROG_TYPE_LSM
Message-ID: <20200324200405.GA7008@chromium.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-8-kpsingh@chromium.org>
 <a071b4ce-9311-5d44-4144-56075a8aa812@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a071b4ce-9311-5d44-4144-56075a8aa812@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23-Mär 13:04, Yonghong Song wrote:
> 
> 
> On 3/23/20 9:44 AM, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > * Load/attach a BPF program to the file_mprotect (int) and
> >    bprm_committed_creds (void) LSM hooks.
> > * Perform an action that triggers the hook.
> > * Verify if the audit event was received using a shared global
> >    result variable.
> > 
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > ---
> >   tools/testing/selftests/bpf/lsm_helpers.h     |  19 +++
> >   .../selftests/bpf/prog_tests/lsm_test.c       | 112 ++++++++++++++++++
> >   .../selftests/bpf/progs/lsm_int_hook.c        |  54 +++++++++
> >   .../selftests/bpf/progs/lsm_void_hook.c       |  41 +++++++
> >   4 files changed, 226 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/lsm_helpers.h
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_test.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/lsm_int_hook.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/lsm_void_hook.c
> > 
> > diff --git a/tools/testing/selftests/bpf/lsm_helpers.h b/tools/testing/selftests/bpf/lsm_helpers.h
> > new file mode 100644
> > index 000000000000..3de230df93db
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/lsm_helpers.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +#ifndef _LSM_HELPERS_H
> > +#define _LSM_HELPERS_H
> > +
> > +struct lsm_prog_result {
> > +	/* This ensures that the LSM Hook only monitors the PID requested
> > +	 * by the loader
> > +	 */
> > +	__u32 monitored_pid;
> > +	/* The number of calls to the prog for the monitored PID.
> > +	 */
> > +	__u32 count;
> > +};
> > +
> > +#endif /* _LSM_HELPERS_H */
> > diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_test.c b/tools/testing/selftests/bpf/prog_tests/lsm_test.c
> > new file mode 100644
> > index 000000000000..5fd6b8f569f7
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/lsm_test.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +
> > +#include <test_progs.h>
> > +#include <sys/mman.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +#include <malloc.h>
> > +#include <stdlib.h>
> > +
> > +#include "lsm_helpers.h"
> > +#include "lsm_void_hook.skel.h"
> > +#include "lsm_int_hook.skel.h"
> > +
> > +char *LS_ARGS[] = {"true", NULL};
> > +
> > +int heap_mprotect(void)
> > +{
> > +	void *buf;
> > +	long sz;
> > +
> > +	sz = sysconf(_SC_PAGESIZE);
> > +	if (sz < 0)
> > +		return sz;
> > +
> > +	buf = memalign(sz, 2 * sz);
> > +	if (buf == NULL)
> > +		return -ENOMEM;
> > +
> > +	return mprotect(buf, sz, PROT_READ | PROT_EXEC);
> 
> "buf" is leaking memory here.
> 
> > +}
> > +
> > +int exec_ls(struct lsm_prog_result *result)
> > +{
> > +	int child_pid;
> > +
> > +	child_pid = fork();
> > +	if (child_pid == 0) {
> > +		result->monitored_pid = getpid();
> > +		execvp(LS_ARGS[0], LS_ARGS);
> > +		return -EINVAL;
> > +	} else if (child_pid > 0)
> > +		return wait(NULL);
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +void test_lsm_void_hook(void)
> > +{
> > +	struct lsm_prog_result *result;
> > +	struct lsm_void_hook *skel = NULL;
> > +	int err, duration = 0;
> > +
> > +	skel = lsm_void_hook__open_and_load();
> > +	if (CHECK(!skel, "skel_load", "lsm_void_hook skeleton failed\n"))
> > +		goto close_prog;
> > +
> > +	err = lsm_void_hook__attach(skel);
> > +	if (CHECK(err, "attach", "lsm_void_hook attach failed: %d\n", err))
> > +		goto close_prog;
> > +
> > +	result = &skel->bss->result;
> > +
> > +	err = exec_ls(result);
> > +	if (CHECK(err < 0, "exec_ls", "err %d errno %d\n", err, errno))
> > +		goto close_prog;
> > +
> > +	if (CHECK(result->count != 1, "count", "count = %d", result->count))
> > +		goto close_prog;
> > +
> > +	CHECK_FAIL(result->count != 1);
> 
> I think the above
> 	if (CHECK(result->count != 1, "count", "count = %d", result->count))
> 		goto close_prog;
> 
> 	CHECK_FAIL(result->count != 1);
> can be replaced with
> 	CHECK(result->count != 1, "count", "count = %d", result->count);

Thanks, and updated for test_lsm_int_hook as well.

> 
> > +
> > +close_prog:
> > +	lsm_void_hook__destroy(skel);
> > +}
> > +
> > +void test_lsm_int_hook(void)
> > +{
> > +	struct lsm_prog_result *result;
> > +	struct lsm_int_hook *skel = NULL;
> > +	int err, duration = 0;
> > +
> > +	skel = lsm_int_hook__open_and_load();
> > +	if (CHECK(!skel, "skel_load", "lsm_int_hook skeleton failed\n"))
> > +		goto close_prog;
> > +
> > +	err = lsm_int_hook__attach(skel);
> > +	if (CHECK(err, "attach", "lsm_int_hook attach failed: %d\n", err))
> > +		goto close_prog;
> > +
> > +	result = &skel->bss->result;
> > +	result->monitored_pid = getpid();
> > +
> > +	err = heap_mprotect();
> > +	if (CHECK(errno != EPERM, "heap_mprotect", "want errno=EPERM, got %d\n",
> > +		  errno))
> > +		goto close_prog;
> > +
> > +	CHECK_FAIL(result->count != 1);
> > +
> > +close_prog:
> > +	lsm_int_hook__destroy(skel);
> > +}
> > +
> > +void test_lsm_test(void)
> > +{
> > +	test_lsm_void_hook();
> > +	test_lsm_int_hook();
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/lsm_int_hook.c b/tools/testing/selftests/bpf/progs/lsm_int_hook.c
> > new file mode 100644
> > index 000000000000..1c5028ddca61
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lsm_int_hook.c
> > @@ -0,0 +1,54 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright 2020 Google LLC.
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <stdbool.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include  <errno.h>
> > +#include "lsm_helpers.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +struct lsm_prog_result result = {
> > +	.monitored_pid = 0,
> > +	.count = 0,
> > +};
> > +
> > +/*
> > + * Define some of the structs used in the BPF program.
> > + * Only the field names and their sizes need to be the
> > + * same as the kernel type, the order is irrelevant.
> > + */
> > +struct mm_struct {
> > +	unsigned long start_brk, brk;
> > +} __attribute__((preserve_access_index));
> > +
> > +struct vm_area_struct {
> > +	unsigned long vm_start, vm_end;
> > +	struct mm_struct *vm_mm;
> > +} __attribute__((preserve_access_index));
> > +
> > +SEC("lsm/file_mprotect")
> > +int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
> > +	     unsigned long reqprot, unsigned long prot, int ret)
> > +{
> > +	if (ret != 0)
> > +		return ret;
> > +
> > +	__u32 pid = bpf_get_current_pid_tgid();
> 
> In user space, we assign monitored_pid with getpid()
> which is the process pid. Here
>    pid = bpf_get_current_pid_tgid()
> actually got tid in the kernel.
> 
> Although it does not matter in this particular example,
> maybe still use
>    bpf_get_current_pid_tgid() >> 32
> to get process pid to be consistent.
> 
> The same for lsm_void_hook.c.

Done. Thanks!

> 
> > +	int is_heap = 0;
> > +
> > +	is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > +		   vma->vm_end <= vma->vm_mm->brk);
> > +
> > +	if (is_heap && result.monitored_pid == pid) {
> > +		result.count++;
> > +		ret = -EPERM;
> > +	}
> > +
> > +	return ret;
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/lsm_void_hook.c b/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> > new file mode 100644
> > index 000000000000..4d01a8536413
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +
> > +#include <linux/bpf.h>
> > +#include <stdbool.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include  <errno.h>
> > +#include "lsm_helpers.h"
> > +
> > +char _license[] SEC("license") = "GPL";
> > +
> > +struct lsm_prog_result result = {
> > +	.monitored_pid = 0,
> > +	.count = 0,
> > +};
> > +
> > +/*
> > + * Define some of the structs used in the BPF program.
> > + * Only the field names and their sizes need to be the
> > + * same as the kernel type, the order is irrelevant.
> > + */
> > +struct linux_binprm {
> > +	const char *filename;
> > +} __attribute__((preserve_access_index));
> > +
> > +SEC("lsm/bprm_committed_creds")
> > +int BPF_PROG(test_void_hook, struct linux_binprm *bprm)
> > +{
> > +	__u32 pid = bpf_get_current_pid_tgid();
> > +	char fmt[] = "lsm(bprm_committed_creds): process executed %s\n";
> > +
> > +	bpf_trace_printk(fmt, sizeof(fmt), bprm->filename);
> > +	if (result.monitored_pid == pid)
> > +		result.count++;
> > +
> > +	return 0;
> > +}
> > 
> 
> Could you also upddate tools/testing/selftests/bpf/config file
> so people will know what config options are needed to run the
> self tests properly?

Added CONFIG_BPF_LSM and CONFIG_SECURITY to the list.

- KP

