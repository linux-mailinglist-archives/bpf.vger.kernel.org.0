Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D4C44A564
	for <lists+bpf@lfdr.de>; Tue,  9 Nov 2021 04:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhKIDrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Nov 2021 22:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhKIDrL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Nov 2021 22:47:11 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F947C061764
        for <bpf@vger.kernel.org>; Mon,  8 Nov 2021 19:44:26 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id j9so17213672pgh.1
        for <bpf@vger.kernel.org>; Mon, 08 Nov 2021 19:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XEXSCzbN8p/s1FKt7KutVxPygmGdIuPrIWK9reGfTzo=;
        b=EcxIe3odmtPr4pd5V1ArGUqiGiq8bGk+ZPnIQajG6IplJiOLAIGN7/rNgm4AG6Puaw
         B/4+w44YvrDM8cEteTIIyyumJJLAQET733ReM6ULgy32VhlhXieu40ZhQnWAJmLMsaLs
         pzdq+9jV8sNgi9EPDpYV3Ij+Vz4P/aepkKRPxDzSNgiFfVb2uclMq3xukbOqMe+A/V5U
         3SJSq5F+Yhb4Y7CzP1Qpq501x9ZmfFQxX/+sFCB3fFDt0uirOuuHw0mnSBTJuO/UyRtN
         BOqzJGG1pvYcVZ1Ma/3Q6Oiw9bmOH8swEoHt5C1H8d2hEwGOYwXvikF8KuFLC75xoasU
         Fhgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XEXSCzbN8p/s1FKt7KutVxPygmGdIuPrIWK9reGfTzo=;
        b=dSJ+VU/nvVjtJ/Axvcnp3SYguPj05SmBbElQti50wSSbfJV4peyZFitXWnC4OpE8AJ
         oAmEcYG+vswrN1ls3IC4hyHsKE23GE34BP3b53r5GKV2F+j5jpIcZJZqK+R+PbMB56br
         yRJ/VqWnMl2aG4OrPmsnOsvySnynT/zo9um9OnUmB1mfqmwsFnlngHg9dh62jS7pW5wG
         yQoo+SIqK9lg143VH/hapIHAQZJtxkYqGMjENXXUGlB6PSl3LLGMTy+WVWITo4fcATTp
         E9XK1lL2ybUnTD3EyGd8YKqk7Quy0UfEx49XY5cBkqqDBLJ/3a0nvVRpxn0FgnknHZPQ
         Lbxw==
X-Gm-Message-State: AOAM532xKDtvijxtPzbjLCe+oeaLaGakotJYG4HOfSCOLlIrg8/UsvJI
        4tG9sAn78qCCmy0Fvz9zeoI=
X-Google-Smtp-Source: ABdhPJwWF69Nh9nqXkU8qYhJlTZOXx+HKfL1noCNLx8XC5qBpmjPHzkX1A5sb4pDyDPBJhAMnXmXpA==
X-Received: by 2002:a62:7f4a:0:b0:44d:292f:cc24 with SMTP id a71-20020a627f4a000000b0044d292fcc24mr87107048pfd.58.1636429465588;
        Mon, 08 Nov 2021 19:44:25 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:e262])
        by smtp.gmail.com with ESMTPSA id gv23sm723749pjb.17.2021.11.08.19.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 19:44:25 -0800 (PST)
Date:   Mon, 8 Nov 2021 19:44:23 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 04/11] selftests/bpf: add test_progs flavor
 using libbpf as a shared lib
Message-ID: <20211109034423.2fcwtksijnmywexg@ast-mbp.dhcp.thefacebook.com>
References: <20211108061316.203217-1-andrii@kernel.org>
 <20211108061316.203217-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108061316.203217-5-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 07, 2021 at 10:13:09PM -0800, Andrii Nakryiko wrote:
> Add test_progs-shared flavor to compile against libbpf as a shared
> library. This is useful to make sure that libbpf's backwards/forward
> compatibility guarantees are upheld. Currently this has to be checked
> locally, but in the future we'll automate at least some scenarios as
> part of libbpf CI runs.
> 
> Biggest change is how either libbpf.a or libbpf.so is passed to the
> compiler, which is controled on per-flavor through a new TRUNNER_LIBBPF
> parameter. All the places that depend on libbpf artifacts (headers,
> library itself, etc) to be built are moved to order-only dependency on
> $(BPFOBJ). rpath is used to specify relative location to where libbpf.so
> should be so that when test_progs-shared is run under QEMU, libbpf.so is
> still going to be discovered correctly.
> 
> Few selftests are using or testing internal libbpf APIs, so are not
> compatible with shared library use of libbpf. Filter them out for shared
> flavor.
...
> +# Define test_progs-shared test runner.
> +TRUNNER_BPF_BUILD_RULE := CLANG_BPF_BUILD_RULE
> +TRUNNER_BPF_CFLAGS := $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_TESTS
> +TRUNNER_EXTRA_CFLAGS := -Wl,-rpath=$(subst $(CURDIR)/,,$(dir $(BPFOBJ)))
> +TRUNNER_LIBBPF := $(patsubst %libbpf.a,%libbpf.so,$(BPFOBJ))
> +TRUNNER_TESTS_BLACKLIST := cpu_mask.c hashmap.c perf_buffer.c raw_tp_test_run.c
> +$(eval $(call DEFINE_TEST_RUNNER,test_progs,shared))
> +TRUNNER_TESTS_BLACKLIST :=

It's a good idea to add libbpf.so test, but going through test_progs is imo overkill.
No reason to run more than one test with shared lib.
If it links fine it's pretty much certain that it will work.
Maybe convert test_maps into shared only? CI runs it already.
