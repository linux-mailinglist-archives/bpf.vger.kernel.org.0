Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5116D9818
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbjDFNYb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237316AbjDFNYa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 09:24:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1CEA
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 06:24:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so5803982wmb.3
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 06:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680787467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uzRzfKYMj5PmJUzXFtvWYbjKV46zLiSvy3KT7nWY7+c=;
        b=BUwJJ3pDdEMarRjYpTuOu11omQGWxR9f1zSq61EZlSwfnONITXH1MbNdHZxx+pC0Yg
         iA9hk/7aPv9Bxq8ij87qVp+RGD5EAZpqjfM1nM0MBMXUbr0fjI6kpXH9dQhfLnCTe45C
         U83kzekvipHWLcXWmvFUcLnCtHfXgDyNdhADXQKnzAEZ/Ny0ODXhA53l/+js2Ujcy7GQ
         gNOiUuWw/idcSbyoXAjFYrUxgSi0k/qjmbcu1728rEMmePp80zdOhi7pFD8BLQmOMf7p
         C6JqNxMNJcnp/rN7P3w+AYGJJwiIkRvOFK9uPxcFFsR4jSQOW0X1U6PwvFLXD0zkdOWo
         VN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680787467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzRzfKYMj5PmJUzXFtvWYbjKV46zLiSvy3KT7nWY7+c=;
        b=IIE39iAer1FWSXoiPrxnoT/ml2hzaPRSJPwvccCGDYUKZDVE+6km/CyBqzRoIZV2//
         hZ+g9np7NZuUv16IptgVCcazp854xvCa0eL2WyFWNeYt4mcAQ9C3mzZMA7czn+Wfnixx
         z9ad5vRMhS7EkV02hQJt+f9x+BXeypappnbqC0y1Ju/OTi5CqEU2Lsn59F8alEuwfK0S
         srO7bx2iVMB7t5+CWmJ/qum85bDWDvkfOCSdcKv2S1R8d5Itur9uTDBbGrIpZ8k8/KfQ
         XTSy10+WGJL89nw0OQb3UXpfEszrJtba5JHHln1LlPUJ9AGGr4+GaeiUrJcG9295jH9U
         MxEA==
X-Gm-Message-State: AAQBX9ez8vQxRmTuXCyk5zTC919R1UUXZMOkMp8TVGtYb6VLQlEusEh9
        4l/WjV1UfJMVk1dBEqSHr6AOhAr3lNgnBzq23n4H0Q==
X-Google-Smtp-Source: AKy350besXNDqL8KxdPTSaQFZ3woX5BMymziFavd5LdDwSxEbuGnNJ5522VMvaDGYktQGn2d9g7xWw==
X-Received: by 2002:a1c:cc1a:0:b0:3ed:33a1:ba8e with SMTP id h26-20020a1ccc1a000000b003ed33a1ba8emr7356772wmb.1.1680787466787;
        Thu, 06 Apr 2023 06:24:26 -0700 (PDT)
Received: from krava (cpc137424-wilm3-2-0-cust276.1-4.cable.virginm.net. [82.23.5.21])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b003ef67848a21sm5312468wmb.13.2023.04.06.06.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 06:24:26 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 6 Apr 2023 15:24:24 +0200
To:     Andrew Nisbet <Andy.Nisbet@manchester.ac.uk>
Cc:     "bpf@vger.kernel.org " <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: EBPF/libpbf initialising/reading raw (hardware) performance
 counters BPF_PERF_ARRAY
Message-ID: <ZC7ICD/vAKdtvopd@krava>
References: <CWLP265MB326715B58C33134FB24B913FC1919@CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CWLP265MB326715B58C33134FB24B913FC1919@CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 06, 2023 at 10:41:35AM +0000, Andrew Nisbet wrote:
> Hi,
> apologies in advance if I have missed an obvious information resource.
> 
> I've used BCC/eBPF before to generate a tool that attached to sched_switch with performance counters and that traces the per-scheduling thread quanta changes in counters for threads of interest. 
> I'd like to use libbbpf to create similar functionality to something like ...
> 
> perf stat -e LLC-loads,LLC-load-misses,LLC-stores,LLC-prefetches -p PID --per-thread
> The actual counters are immaterial - except that I expect to be sometimes using RAW performance counters, and I typically extract the perf_event_attr information such as event/config etc using 
> perf stat -vvv -e counter-name /bin/ls 
> 
> I can see from the libbpf examples how to catch the pid of the command as it enters the runqueue, but I dont see how to initialise the raw hardware performance counters to only count the pid and its threads (is this even possible or does one just accumulate counters for each relevant thread in sched_switch - this is what we do currently). I understand how to put these values into a map. 

yes, you need to agregate counts yourself for more pids

you can create perf counter for single entities like pid/tid/cpu/task/cgroup,
so if you want to meassure more pids you need to create counter for each and
aggregate their counts, that's what perf tool does

> 
> I'm looking for (if possible) example code or information pointers on how to initialise and read the counters, not using sampling - presumably using a BPF_PERF_ARRAY map and a call to the  perf_counter_read or the older perf_read on the map. 

there's 'bpftool prog profile' that creates perf counters,
but I think there's no aggregation, still nice example:
(see do_profile function)
  https://github.com/torvalds/linux/blob/master/tools/bpf/bpftool/prog.c

also there's libperf if you need the abstraction to create more
counters and read from them:

  https://github.com/torvalds/linux/tree/master/tools/lib/perf/
  https://github.com/torvalds/linux/tree/master/tools/lib/perf/Documentation/examples

jirka

> 
> I'm only just getting up to speed with libbpf, so apologies if I've misunderstood and presented BCC ways that do not apply. 
> 
> Thanks,
> Andy
