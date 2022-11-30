Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E32663D760
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 14:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiK3N6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 08:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiK3N6m (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 08:58:42 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C3A1D33D
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 05:58:41 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3c21d6e2f3aso111384067b3.10
        for <bpf@vger.kernel.org>; Wed, 30 Nov 2022 05:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNz3TeUIxix6PUHiU4vUYWYXAMGqRHEQQYOh5WSfUP8=;
        b=Erl9t01h6oeUfWXRbBMywYnHDZnCXU3eP8prHMy8z0FJbNHizvUwm7IUuYD7BLZa/Z
         UYJcBgVyoe8BuUsFHiaeTtcwIKkB/7Td7PA2EBSIPsLrl7hjeOB0qwmM+mHE6Qs0rVhc
         Bm8YYvogwOmcKUDZGzqQBAPHAlI5CHf0cU9Nd2AKvL/wtvllpG7YAUpFuD389wBZQwEx
         52BfaiNP/RQdgAWXrCTmcrZW0UbR0uRHPtzZG148tyYM/iLdPuwZIFDkkbKouQ7S69c+
         MPJvmBDWPIvkkDXbTsLNxgOmSEWRAexresa7F4d1llgonVt0pK61RVsPa7uAV5TYkET5
         rPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNz3TeUIxix6PUHiU4vUYWYXAMGqRHEQQYOh5WSfUP8=;
        b=OWI3Or0W/fxz2inhbmbXvTxsujNFFUM18IsbsmoqyN8B0x/uc3j1fERqZnXbx8AXc8
         +0xvjCDHAPkOtbWyes3gTQMbHHpnaHgOKrg0R8gmvGd/+EHeaABzqbHuhipwF7j6eZSk
         qxxf1/Ybb6imo96oXch5AsN4E7cJcmmvNyOPxnaDGERyGsbzeWg39n6eZj8FYCvM398X
         xjPZ00npCXGNbhDekgTqIxyuUrL/4hLCcD6VwQ5d+RJfq/7pCAVw9ZUjIpOqlAyueHX8
         dOdwiCACQL8P9/qygGTnAdKhabReR7pHSoXjyFh/B9yslUk4lEacwSWz/MLnhAt3YbOH
         tzgA==
X-Gm-Message-State: ANoB5pnsrM5JMmM9wmIvFXnCiK1vkHbyN+H3BLQGj0t3AGox2IYUNMhG
        yJZvaWzZOyaoYzK+wtrOZrFxGytmiaCDTFNxHxG5u6/UWtZ9n/ev
X-Google-Smtp-Source: AA0mqf4bS2g08nRNKSCY9wEzAUBF7foKp68o1hAmSbp4z84Q8Dzyncpv921RrKkSiCYQqhZQsUV21E0gSQwaHWhbVZo=
X-Received: by 2002:a05:690c:828:b0:3d7:b184:9885 with SMTP id
 by8-20020a05690c082800b003d7b1849885mr1027000ywb.125.1669816720250; Wed, 30
 Nov 2022 05:58:40 -0800 (PST)
MIME-Version: 1.0
Reply-To: tjcw@cantab.net
From:   Chris Ward <tjcw01@gmail.com>
Date:   Wed, 30 Nov 2022 13:58:29 +0000
Message-ID: <CAC=wTOhR-YTjuGu7mreQccx1o+nWgWZ4+V=URpj3jfCB3gipTA@mail.gmail.com>
Subject: Per CPU map not being transferred to user space
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I have a test case similar to code in xdp-project/xdp-tutorial/ which
maintains a statistic map in a per-cpu array, and user-space code
which displays the statistics periodically.

When I run this, the user space code always displays zeros. I have
instrumented my eBPF kernel code with bpf_trace_printk and it appears
to be putting the correct values into the map. The user code is
iterating over all possible CPUs, but is always finding zeros in the
per-cpu array slots.

Can anybody tell me what is going wrong ?

My test case is here
https://github.com/tjcw/bpf-examples/tree/tjcw-integration-1.2-ebpftrace/AF_XDP-filter
; af_xdp_kern.c is the eBPF code, af_xdp_user.c is the userspace code
which drives the eBPF code, and filter-xdp_stats.c is the code which
should display the statistics. It all builds with 'make' in that
directory, and there is a run script which I use with
tjcw@r28b29-n10:~/workspace/bpf-examples/AF_XDP-filter/netperf-namespace$
sudo FILTER=af_xdp_kern ./run.sh
to run the user code and eBPF code with data being transferred between
2 network namespaces on the machine.
While it is running,
tjcw@r28b29-n10:~/workspace/bpf-examples/AF_XDP-filter$ sudo
./filter-xdp_stats
should display statistics, but in fact displays zeros.

My test case is coded to the '1.0' BPF interface, where the code in
xdp-tutorial is coded to the pre-release BPF interface.

Thanks for all the help you can give !

Chris Ward, IBM
