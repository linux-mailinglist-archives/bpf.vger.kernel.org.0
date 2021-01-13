Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C42F502B
	for <lists+bpf@lfdr.de>; Wed, 13 Jan 2021 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbhAMQl0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jan 2021 11:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbhAMQlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jan 2021 11:41:25 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A537C061794
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 08:40:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id f4so3984629ejx.7
        for <bpf@vger.kernel.org>; Wed, 13 Jan 2021 08:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wjcYY6jSZGR3OQJEyZOutpo6r9ZeEEU7xz7GXe+2ciU=;
        b=ecvp065lxf1k8zZwrTVEc5wvLGBO89g3pHn0rNHwB1Butz6nMZb5uqcuo2VC26xE6n
         XCXidwyps2uo8uEftIf8zhnxg0g3kz97xJt6AHnwTi2yetTBkFn9FDbl22hV09I6leCP
         2D1NmRAMS67LUSdy0Yw1ThPmlfRba1DrHZUVuct44iK7mu3Lv4Z3u6Up8z6z9Uqa1sqV
         jlv6SzUf3bPGuYeK5mDTpQsiZSrj+4m6dvcjkDv5pJECiZk3BnLb+YDNZmFdDtQvuYpv
         EGfKstM+A5zmwcjLFZahdt9pVXBBZlWxmw1HIdAFlBRBaCZj2i4iz9qY4i8lgIcagnH4
         vZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjcYY6jSZGR3OQJEyZOutpo6r9ZeEEU7xz7GXe+2ciU=;
        b=kCmu2j9pGqA8jOKbjOB0er0Vaxi1UnDUfWCY8XRHJeuRK9W/RomlatfZr6xTZTGT1t
         rdJibAu79uTJ5JWWoKMIkaVCLVs+HOX8V+9Kj6C3oDuli4Y38zhBAiDA27wNzWFPLHYo
         FahMHxtUdqcXL0viFjCc53w3pHxQK0MxqMoQTlpjVsJwvnbIyH6T6up3aTu931RsB3/I
         bNUdyQqpb9cI4ZiyP6UIKx+GXBAHooSK0W6YUSkhoc0CV4oR6kfU7eyJLBF0K1MIiNNK
         JwYJ2IpoTi12JRz5fzmiG/+9irjXL7t3lAXs0bEgll03r7eRiDfHY9fA4Mr3+rGqRzk6
         WKpg==
X-Gm-Message-State: AOAM530XVogGQdnAK0GAV4ieyotDInVDdROJcI+X151vLuOY2IZ+4xAG
        8og7Hh/waQE7W+iOwU64tJBzTA==
X-Google-Smtp-Source: ABdhPJxeG+kP21qpOKGoxm/Ph+7EuWKO8OU1kgiA9i5c13LaTQnEARoV4Q8lYPZovFQNEIDUfY+grA==
X-Received: by 2002:a17:906:31cb:: with SMTP id f11mr2246516ejf.468.1610556043904;
        Wed, 13 Jan 2021 08:40:43 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id s1sm925459ejx.25.2021.01.13.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:40:43 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:40:24 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests: bpf: Add a new test for bare
 tracepoints
Message-ID: <X/8ieO6sMVizowMk@myrica>
References: <20210111182027.1448538-1-qais.yousef@arm.com>
 <20210111182027.1448538-3-qais.yousef@arm.com>
 <CAEf4BzYwOAHGOiZBUx86yZ1ofwJ1WqCDR3dyRMrTeQa2ZU7ftA@mail.gmail.com>
 <20210112192729.q47avnmnzl54nekg@e107158-lin>
 <CAEf4BzZiYv1M04FBmuzMH5cxLUXzLthDfpp4nORMEmvkcfzyRQ@mail.gmail.com>
 <20210113102131.mjxpqpoi4n6rhbny@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113102131.mjxpqpoi4n6rhbny@e107158-lin>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 13, 2021 at 10:21:31AM +0000, Qais Yousef wrote:
> On 01/12/21 12:07, Andrii Nakryiko wrote:
> > > > >         $ sudo ./test_progs -v -t module_attach
> > > >
> > > > use -vv when debugging stuff like that with test_progs, it will output
> > > > libbpf detailed logs, that often are very helpful
> > >
> > > I tried that but it didn't help me. Full output is here
> > >
> > >         https://paste.debian.net/1180846
> > >
> > 
> > It did help a bit for me to make sure that you have bpf_testmod
> > properly loaded and its BTF was found, so the problem is somewhere
> > else. Also, given load succeeded and attach failed with OPNOTSUPP, I
> > suspect you are missing some of FTRACE configs, which seems to be
> > missing from selftests's config as well. Check that you have
> > CONFIG_FTRACE=y and CONFIG_DYNAMIC_FTRACE=y, and you might need some
> > more. See [0] for a real config we are using to run all tests in
> > libbpf CI. If you figure out what you were missing, please also
> > contribute a patch to selftests' config.
> > 
> >   [0] https://github.com/libbpf/libbpf/blob/master/travis-ci/vmtest/configs/latest.config
> 
> Yeah that occurred to me too. I do have all necessary FTRACE options enabled,
> including DYNAMIC_FTRACE. I think I did try enabling fault injection too just
> in case. I have CONFIG_FAULT_INJECTION=y and CONFIG_FUNCTION_ERROR_INJECTION=y.

Could it come from lack of fentry support on arm64 (or are you testing on
x86?) Since the arm64 JIT doesn't have trampoline support at the moment, a
lot of bpf selftests fail with ENOTSUPP.

Thanks,
Jean
