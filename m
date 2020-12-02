Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FA72CBCFB
	for <lists+bpf@lfdr.de>; Wed,  2 Dec 2020 13:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgLBM10 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 07:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgLBM10 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 07:27:26 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CCFC0613CF
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 04:26:45 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so3721105wrt.2
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLjWRpA24o/J+NmnU4L/KlmfVuGp+NEmDYUcuK8XM7A=;
        b=BfcuG6+gutWCVGivWC2TZBxKRUcN1RBX/6oWDTbDWWbwfg/79A6OjtqDnIG6AkgAxn
         KWbPKGV+jtmo+ix/ijU2LuSYyhO/h9IjhZI19jcOlJmvdiBXtVXGRhsOnzphKQ8au8O7
         KbpRXLBmnrQQcDw7d7obXJDJWpmZ5/owFf9U/q3eqe8HouMmZNp3kWfIaES2s3LpU6Cr
         yS29pVuAfDd3sX7g8jnlP/NkYPhZBX3MYhC6ocU7Hxr+Twe/l5AzT8haRPGvqnKRxs6Z
         v98d2WsSaclsI/L8AZjXmmYM16RW2kppS6vqUS9n+6eaiomliCa9S3O+0izpxPxRH4rm
         2Mtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLjWRpA24o/J+NmnU4L/KlmfVuGp+NEmDYUcuK8XM7A=;
        b=lOZRzZGPhG6CSvnIbybQt3WkjZsuZkdnKNv3LgdjqwVeDmZV1J3TszQ/+g1vDPjkPX
         rliHjJXCuW5wHMCcS94FNti+pC98M4YLM6Gdlfn+aWNn/6coDcBWwZ80I8VJz0dzvy/+
         x/+QLMryfnuGK9xwMyK0qXA6gZy5pZSyW8QeUwU4PAPiq2lfP67AvyXdEcqqM83O297r
         bbNN0yiExTJbDg3UoHU47zbFBjNSfWvXKDfviVqK6lw2s/i068eBLdoR8CXoH7uTLNQo
         Jy5Cn8bJLfCX0pA11g+FGSbmPBY44Pdz2fvPpEa1sZbhZdhU4CEMzghE0rsedLskg4QD
         Ndww==
X-Gm-Message-State: AOAM531KSKCLOY6FiFRrAJ3N9F1mp+SfJPAtQpwqKB1FpsYR2v2UmvBb
        jDy8rr6/dUXKQExkf9yJRUIaKw==
X-Google-Smtp-Source: ABdhPJzMH2m2X+CTGSzQHQ4YyXagby6Lmq9rlIi8skK4D5sjKD8reVVacPqenhl9LmzkDBu6j0AvRQ==
X-Received: by 2002:a5d:56cb:: with SMTP id m11mr3212623wrw.346.1606912004487;
        Wed, 02 Dec 2020 04:26:44 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id c9sm1840684wrp.73.2020.12.02.04.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 04:26:43 -0800 (PST)
Date:   Wed, 2 Dec 2020 12:26:40 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 12/13] bpf: Add tests for new BPF atomic
 operations
Message-ID: <20201202122640.GA49766@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-13-jackmanb@google.com>
 <CAEf4BzaAgtPazgOUQYnN9eV+TqPLtK0JTd14j5QmzeNXPZ+seQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaAgtPazgOUQYnN9eV+TqPLtK0JTd14j5QmzeNXPZ+seQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 01, 2020 at 06:22:50PM -0800, Andrii Nakryiko wrote:
> On Fri, Nov 27, 2020 at 10:01 AM Brendan Jackman <jackmanb@google.com> wrote:
[...]
> > +
> > +static void test_xchg(void)
> > +{
> > +       struct atomics_test *atomics_skel = NULL;
> 
> nit: = NULL is unnecessary
[...[
> > +       CHECK(atomics_skel->data->xchg32_value != 2, "xchg32_value",
> > +             "32bit xchg left unexpected value (got %d want 2)\n",
> > +             atomics_skel->data->xchg32_value);
> > +       CHECK(atomics_skel->bss->xchg32_result != 1, "xchg_result",
> > +             "32bit xchg returned bad result (got %d want 1)\n",
> > +             atomics_skel->bss->xchg32_result);
> 
> ASSERT_EQ() is less verbose.
> 
> > +
> > +cleanup:
> > +       atomics_test__destroy(atomics_skel);
> > +}
> > +
> > +void test_atomics_test(void)
> > +{
> 
> why the gigantic #ifdef/#else block if you could do the check here,
> skip and exit?
> 
> > +       test_add();
> > +       test_sub();
> > +       test_and();
> > +       test_or();
> > +       test_xor();
> > +       test_cmpxchg();
> > +       test_xchg();
> 
> 
> please model these as sub-tests, it will be easier to debug, if anything
> 
> > +}
> > +
> > +#else /* ENABLE_ATOMICS_TESTS */
> > +
> > +void test_atomics_test(void)
> > +{
> > +       printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
> > +              __func__);
> > +       test__skip();
> > +}
> > +
> > +#endif /* ENABLE_ATOMICS_TESTS */
> > diff --git a/tools/testing/selftests/bpf/progs/atomics_test.c b/tools/testing/selftests/bpf/progs/atomics_test.c
> > new file mode 100644
> > index 000000000000..3139b00937e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/atomics_test.c
> > @@ -0,0 +1,124 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/bpf.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +
> > +#ifdef ENABLE_ATOMICS_TESTS
> > +
> > +__u64 add64_value = 1;
> > +__u64 add64_result = 0;
> > +__u32 add32_value = 1;
> > +__u32 add32_result = 0;
> > +__u64 add_stack_value_copy = 0;
> > +__u64 add_stack_result = 0;
> 
> empty line here
> 
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(add, int a)
> > +{
> > +       __u64 add_stack_value = 1;
> > +
> > +       add64_result = __sync_fetch_and_add(&add64_value, 2);
> > +       add32_result = __sync_fetch_and_add(&add32_value, 2);
> > +       add_stack_result = __sync_fetch_and_add(&add_stack_value, 2);
> > +       add_stack_value_copy = add_stack_value;
> > +
> > +       return 0;
> > +}
> > +
> > +__s64 sub64_value = 1;
> > +__s64 sub64_result = 0;
> > +__s32 sub32_value = 1;
> > +__s32 sub32_result = 0;
> > +__s64 sub_stack_value_copy = 0;
> > +__s64 sub_stack_result = 0;
> 
> same
> 
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(sub, int a)
> > +{
> > +       __u64 sub_stack_value = 1;
> > +
> > +       sub64_result = __sync_fetch_and_sub(&sub64_value, 2);
> > +       sub32_result = __sync_fetch_and_sub(&sub32_value, 2);
> > +       sub_stack_result = __sync_fetch_and_sub(&sub_stack_value, 2);
> > +       sub_stack_value_copy = sub_stack_value;
> > +
> > +       return 0;
> > +}
> > +
> > +__u64 and64_value = (0x110ull << 32);
> > +__u64 and64_result = 0;
> > +__u32 and32_value = 0x110;
> > +__u32 and32_result = 0;
> 
> yep
> 
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(and, int a)
> > +{
> > +
> > +       and64_result = __sync_fetch_and_and(&and64_value, 0x011ull << 32);
> > +       and32_result = __sync_fetch_and_and(&and32_value, 0x011);
> > +
> > +       return 0;
> > +}
> > +
> > +__u64 or64_value = (0x110ull << 32);
> > +__u64 or64_result = 0;
> > +__u32 or32_value = 0x110;
> > +__u32 or32_result = 0;
> 
> here too
> 
> > +SEC("fentry/bpf_fentry_test1")
> > +int BPF_PROG(or, int a)
> > +{
> > +       or64_result = __sync_fetch_and_or(&or64_value, 0x011ull << 32);
> > +       or32_result = __sync_fetch_and_or(&or32_value, 0x011);
> > +
> > +       return 0;
> > +}
> > +
> > +__u64 xor64_value = (0x110ull << 32);
> > +__u64 xor64_result = 0;
> > +__u32 xor32_value = 0x110;
> > +__u32 xor32_result = 0;
> 
> you get the idea... How often do you define global variables in
> user-space code right next to the function without an extra line
> between them?..
> 
[...]
> > +       cmpxchg64_result_succeed = __sync_val_compare_and_swap(
> > +               &cmpxchg64_value, 1, 2);
> > +
> > +       cmpxchg32_result_fail = __sync_val_compare_and_swap(
> > +               &cmpxchg32_value, 0, 3);
> > +       cmpxchg32_result_succeed = __sync_val_compare_and_swap(
> > +               &cmpxchg32_value, 1, 2);
> 
> single lines are fine here and much more readable

Thanks, ack to all comments.
