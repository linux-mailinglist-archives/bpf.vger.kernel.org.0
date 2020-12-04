Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F4C2CEB49
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 10:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgLDJp5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 04:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDJp4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Dec 2020 04:45:56 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9FC061A51
        for <bpf@vger.kernel.org>; Fri,  4 Dec 2020 01:45:15 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id v14so5003422wml.1
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 01:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HTMk/hXiedF9fES6DLjMJhevTJ/XIDlYzClccSpz43c=;
        b=rkzVE3Nc+vVTKg+EdCO3dJ6wRI0pzX7FjqvkyEpkK0bLmE5LVKyIJqwVQ/WNCKCLk3
         o5fpFW4ZRRI8zzNeeZR3T2dZGXrT4vurLWNqDwUQJwEfI42JbSRww51bmuEnus9br57/
         D2mYNHHQFaRTE+wJ9l9LBG7RdSaevA4HP1Eejqf0PkrU3w+q9RooxbmDkLvalGsUgUXe
         +wkDEPj65CcO5HjQum7fQNKvJR4Jx5Ss7NrkzBexvTTEo8x0yiZDmzwJJVAWJdvvoRFf
         CtlWLfkZFUsouE64CAR5VZrk/+U1r2vlsMReEzdNENOPRzLZIE/G0erM5fOF4DDpOf8q
         DRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HTMk/hXiedF9fES6DLjMJhevTJ/XIDlYzClccSpz43c=;
        b=eflxegne1NSiY+eg2b8R0fZHBvT+/0Tarivb2FdQaelxTSEFDgQ5+bGt75HNKiHU2y
         4bQ8/vUVvSWqAiw1ASUqH0b7RV8NlwFdUQ9+8JLcW/MPUhc1t3YxG5msxDMXXN+fhXBo
         SbNraeBBny2+/nxim0KWXIhyPS8X8dwod0zAb0aake0GNdj/Rr9inui0yNr17NYlKNsT
         KD8afb7Qq3s5XnGsl4JGpf26NSXcRKQKLc3gtH4LfvvepX2t5sO0N2oGvaJMg7HX/ybZ
         AJ5byozE7iPfcU5Anj+UmHC4hGn8sTcwTfPC4r+e0rd7b2jMGXzAhhjWJg5tbSwCsXdi
         l/7A==
X-Gm-Message-State: AOAM530aJKsSCpGd0d4AZLT8SqGeK/Zem23Z+HqfzLWB6P8OEq0MV042
        AhnaZer3TuG+WMrd6xj93pBNis2BhKfUeQ==
X-Google-Smtp-Source: ABdhPJy/ZnCzwpQK3OuXl+x2IfFq6FBZd2ZPqSxAHI6Wxm3bL7qHwKVnFM01VmbH2pBtr/FJoTkiXQ==
X-Received: by 2002:a1c:4954:: with SMTP id w81mr3186191wma.60.1607075114273;
        Fri, 04 Dec 2020 01:45:14 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id p11sm3010541wrj.14.2020.12.04.01.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:45:13 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:45:09 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 13/14] bpf: Add tests for new BPF atomic
 operations
Message-ID: <X8oFJW/mMFHVxngY@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-14-jackmanb@google.com>
 <b629793c-fb9c-6ef5-e2d6-7acaf1d2fc7f@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b629793c-fb9c-6ef5-e2d6-7acaf1d2fc7f@fb.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 11:06:31PM -0800, Yonghong Song wrote:
> On 12/3/20 8:02 AM, Brendan Jackman wrote:
[...]
> > diff --git a/tools/testing/selftests/bpf/prog_tests/atomics_test.c b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> > new file mode 100644
> > index 000000000000..66f0ccf4f4ec
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/atomics_test.c
> > @@ -0,0 +1,262 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +
> > +
> > +#include "atomics_test.skel.h"
> > +
> > +static struct atomics_test *setup(void)
> > +{
> > +	struct atomics_test *atomics_skel;
> > +	__u32 duration = 0, err;
> > +
> > +	atomics_skel = atomics_test__open_and_load();
> > +	if (CHECK(!atomics_skel, "atomics_skel_load", "atomics skeleton failed\n"))
> > +		return NULL;
> > +
> > +	if (atomics_skel->data->skip_tests) {
> > +		printf("%s:SKIP:no ENABLE_ATOMICS_TEST (missing Clang BPF atomics support)",
> > +		       __func__);
> > +		test__skip();
> > +		goto err;
> > +	}
> > +
> > +	err = atomics_test__attach(atomics_skel);
> > +	if (CHECK(err, "atomics_attach", "atomics attach failed: %d\n", err))
> > +		goto err;
> > +
> > +	return atomics_skel;
> > +
> > +err:
> > +	atomics_test__destroy(atomics_skel);
> > +	return NULL;
> > +}
> > +
> > +static void test_add(void)
> > +{
> > +	struct atomics_test *atomics_skel;
> > +	int err, prog_fd;
> > +	__u32 duration = 0, retval;
> > +
> > +	atomics_skel = setup();
> 
> When running the test, I observed a noticeable delay between skel load and
> skel attach. The reason is the bpf program object file contains
> multiple programs and the above setup() tries to do attachment
> for ALL programs but actually below only "add" program is tested.
> This will unnecessarily increase test_progs running time.
> 
> The best is for setup() here only load and attach program "add".
> The libbpf API bpf_program__set_autoload() can set a particular
> program not autoload. You can call attach function explicitly
> for one specific program. This should be able to reduce test
> running time.

Interesting, thanks a lot - I'll try this out next week. Maybe we can
actually load all the progs once at the beginning (i.e. in
test_atomics_test) then attach/detch each prog individually as needed...
Sorry, I haven't got much of a grip on libbpf yet.

