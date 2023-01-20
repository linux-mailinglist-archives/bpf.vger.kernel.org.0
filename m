Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA508674CE2
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 06:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjATF4R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 00:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjATF4P (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 00:56:15 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F0965B8;
        Thu, 19 Jan 2023 21:56:14 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id j9so3446597qtv.4;
        Thu, 19 Jan 2023 21:56:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0ml1rOSQLwUDYoEMu0hg3QoBsZnk6Eb4yb9+R7jf3E=;
        b=kB9osv4T+UvJAo53f469VUGha+B7ypAHppQRV7oznMspIa3iM5H6l2oEWcxd3yn65x
         VQ1td3rQsfTRTKPf6jkhYQvaJ7dZRXbKFZrpMri0JSFo2cBfEH0x61nHS0eV5+Bp+ThB
         3G341PmLECkhw0miF3/5YhdMwqJ3n7vudNRu0BLgqVTyuylhHo/TEOc3UWcZV8u5baao
         jp86sutzhN/8Cb5tG8iyPp26FeMA5DB4ndiJpZJHy5q+HMX9IgtCexB3tnWnd3O/DXyC
         glrPH7GWt9HmCVFEZhc93mrh0RRI8EQurvaH0YJGc6kf0DT8fBo55SKUJyAnc17oViD5
         my7A==
X-Gm-Message-State: AFqh2koLoB9k9e3zMjMoLgoS6NR+MVKKVrRXnoRThEYtRZPlC20R2fCv
        CgvZmpMGQ/2UZYqAUfThlrM=
X-Google-Smtp-Source: AMrXdXsK5SALZ6lKzit/Dg73/vQhh1B8S0MZafdSAx5mrzVFkUVPcg2aJ/roYoc0IiLjEf+WrCnPIg==
X-Received: by 2002:ac8:6bda:0:b0:3a8:26d:5f46 with SMTP id b26-20020ac86bda000000b003a8026d5f46mr19297520qtt.24.1674194173843;
        Thu, 19 Jan 2023 21:56:13 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:2fc9])
        by smtp.gmail.com with ESMTPSA id b24-20020ac86798000000b0039cc944ebdasm20006126qtp.54.2023.01.19.21.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:56:13 -0800 (PST)
Date:   Thu, 19 Jan 2023 23:56:17 -0600
From:   David Vernet <void@manifault.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@meta.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 5/8] selftests/bpf: Add nested trust selftests
 suite
Message-ID: <Y8otATjNyL4MbXWd@maniforge.lan>
References: <20230119235833.2948341-1-void@manifault.com>
 <20230119235833.2948341-6-void@manifault.com>
 <20230120055149.tfpv3yzbbsm6snqv@MacBook-Pro-6.local.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120055149.tfpv3yzbbsm6snqv@MacBook-Pro-6.local.dhcp.thefacebook.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jan 19, 2023 at 09:51:49PM -0800, Alexei Starovoitov wrote:
> On Thu, Jan 19, 2023 at 05:58:30PM -0600, David Vernet wrote:
> > Now that defining trusted fields in a struct is supported, we should add
> > selftests to verify the behavior. This patch adds a few such testcases.
> > 
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
> >  .../selftests/bpf/prog_tests/nested_trust.c   | 64 +++++++++++++++++++
> >  .../selftests/bpf/progs/nested_trust_common.h | 12 ++++
> >  .../bpf/progs/nested_trust_failure.c          | 33 ++++++++++
> >  .../bpf/progs/nested_trust_success.c          | 29 +++++++++
> >  5 files changed, 139 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/nested_trust.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_common.h
> >  create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_failure.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/nested_trust_success.c
> > 
> > diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> > index 96e8371f5c2a..1cf5b94cda30 100644
> > --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> > +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> > @@ -44,6 +44,7 @@ map_kptr                                 # failed to open_and_load program: -524
> >  modify_return                            # modify_return attach failed: -524                                           (trampoline)
> >  module_attach                            # skel_attach skeleton attach failed: -524                                    (trampoline)
> >  mptcp
> > +nested_trust                             # JIT does not support calling kernel function
> >  netcnt                                   # failed to load BPF skeleton 'netcnt_prog': -7                               (?)
> >  probe_user                               # check_kprobe_res wrong kprobe res from probe read                           (?)
> >  rcu_read_lock                            # failed to find kernel BTF type ID of '__x64_sys_getpgid': -3                (?)
> > diff --git a/tools/testing/selftests/bpf/prog_tests/nested_trust.c b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
> > new file mode 100644
> > index 000000000000..4d13612f5001
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/nested_trust.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <test_progs.h>
> > +#include "nested_trust_failure.skel.h"
> > +#include "nested_trust_success.skel.h"
> > +
> > +static const char * const nested_trust_success_testcases[] = {
> > +	"test_read_cpumask",
> > +};
> > +
> > +static void verify_success(const char *prog_name)
> > +{
> > +	struct nested_trust_success *skel;
> > +	struct bpf_program *prog;
> > +	struct bpf_link *link = NULL;
> > +	int status;
> > +	pid_t child_pid;
> > +
> > +	skel = nested_trust_success__open();
> > +	if (!ASSERT_OK_PTR(skel, "nested_trust_success__open"))
> > +		return;
> > +
> > +	skel->bss->pid = getpid();
> > +
> > +	nested_trust_success__load(skel);
> > +	if (!ASSERT_OK_PTR(skel, "nested_trust_success__load"))
> > +		goto cleanup;
> > +
> > +	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
> > +	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
> > +		goto cleanup;
> > +
> > +	link = bpf_program__attach(prog);
> > +	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
> > +		goto cleanup;
> > +
> > +	child_pid = fork();
> > +	if (!ASSERT_GT(child_pid, -1, "child_pid"))
> > +		goto cleanup;
> > +	if (child_pid == 0)
> > +		_exit(0);
> > +	waitpid(child_pid, &status, 0);
> > +	ASSERT_OK(skel->bss->err, "post_wait_err");
> > +
> > +	bpf_link__destroy(link);
> > +
> > +cleanup:
> > +	nested_trust_success__destroy(skel);
> > +}
> > +
> > +void test_nested_trust(void)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(nested_trust_success_testcases); i++) {
> > +		if (!test__start_subtest(nested_trust_success_testcases[i]))
> > +			continue;
> > +
> > +		verify_success(nested_trust_success_testcases[i]);
> > +	}
> > +
> > +	RUN_TESTS(nested_trust_failure);
> > +}
> 
> Hmm. I thought RUN_TESTS() works for successes too.
> Looking at test_loader.c:run_subtest() that should be the case.
> Could you please double check?
> verify_success() above shouldn't be needed.

Yes, looks like RUN_TESTS() works for success cases too, it just isn't
used anywhere yet. I expect it won't be super commonly used given that
it only loads the program and tests the verifier rather than doing any
runtime validation, but that's exactly what we want for this so I'll
update that in v2. I'll plan on leaving the cpumask success cases as
they are unless you object so that we can get runtime coverage as well.
