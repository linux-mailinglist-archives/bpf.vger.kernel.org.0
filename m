Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC89D6C44FB
	for <lists+bpf@lfdr.de>; Wed, 22 Mar 2023 09:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCVIdY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 04:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjCVIdS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 04:33:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A1D2C648
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 01:33:14 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so22893003pjt.2
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 01:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=galvanick-com.20210112.gappssmtp.com; s=20210112; t=1679473994;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOLSU2uX9ab53eE7ZlnZpFXsNC4k5aYNkyZHPSKS1ys=;
        b=D8CrHSULZpHd7mlUHItMRe99TmzKgH4IsHGRYeS/WO2x6Tb+KvYlZJUveGVmSaqdlP
         dF2HKSbr+npcSs2qSmGTUhik6Jqhw6g77ErsNU81P8ZZzo86XVUK9GCe+PoZDuV+uQEv
         TBkfF2WEU7hGGNpxGWyxovQKlZfIlIF1I8XDuo8nyhJv5pz0Ysu/nu9ro2lrzUsvYueB
         qjWc5kl1cpNh2lFT/A6b4nDm55tKS+vp8JlBiM9sKZUYdp6IOOLL9EYcNV1QlsAbUgX/
         pqLl1cNPr4AoSQ0EbI7HsgoiqD4txIpA6I8wn5ViLON1EznRr+OjpQOZFYkSdZKwRBvU
         18gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679473994;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bOLSU2uX9ab53eE7ZlnZpFXsNC4k5aYNkyZHPSKS1ys=;
        b=hrddvzZr8a9G4ZYAlojCJbFNsOSHX30Uz01tqj4RR+RvDxReROJEyARQDVkosNygiU
         sDD8ASRAFKE3ApdGEEvVSoZv6tCfxOet8saD2GbT+us4LeKBTisZatV1YDgxPrKTvTr3
         lPu5/DEoTwAl43BmoVhroAvIsUFl3fHj6j4uxEfa234DANNj6gyKRZtQuL5U9H4FL+ad
         GLSUzF43aEmkIEevYngWYOyMVGxpkzBh+AbzlajFq9+TQKpfCpZLTn/6plwleV0swFxF
         DRGI8z4W6hucQcZ0f0YGSimvid1RAOXI3iNetTqHmYrxtJ3CRVRzrdItpkxR1mssemb6
         aJUA==
X-Gm-Message-State: AO0yUKVvFL2gkESuNhBgkEx4L+WMNmii4jAgE+18yLAoMrYDJOucaSog
        99VxKSs6r3sNJG5we/xntD1Yhu6yeBMuctUhu+GoOET5ImNds9h1RjU6lg==
X-Google-Smtp-Source: AK7set/WhR8i3CC40heLDXcCi1rECzBf1yeIm0llGVEyXmxiK1Gg4utwy1IluJ97UBACLYmDTWYCvXLMZqIxTQ5/kMc=
X-Received: by 2002:a17:90b:3c2:b0:23f:6eff:9430 with SMTP id
 go2-20020a17090b03c200b0023f6eff9430mr824120pjb.3.1679473993881; Wed, 22 Mar
 2023 01:33:13 -0700 (PDT)
MIME-Version: 1.0
From:   Douglas Gastonguay-Goddard <doug@galvanick.com>
Date:   Wed, 22 Mar 2023 01:33:03 -0700
Message-ID: <CAEQOFwKDdSfr+Ohd37HDZ8EEug+MV3iVsWyZKB2CKTfO-UBO+Q@mail.gmail.com>
Subject: [QUESTION] bpf: Task struct content availability differences between
 tracepoint and fexit
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am porting some code from an accept4(2) tracepoint to a fexit hook.
Previously the tracepoint captured the enter and exit events
separately so capturing everything in a single fexit hook is
appealing.

Inside of the exit tracepoint I was traversing the task struct to
retrieve the connecting address. The path being as follows, but
through a bunch of bpf_probe_read() calls.

((struct socket *)task->files->fd_array[connfd]->private_data)->sk->
__sk_common.skc_family
__sk_common.skc_dport
__sk_common.skc_daddr

Worked consistently in the tracepoint.

In the fexit implementation , testing with `nc -l 127.0.0.1 1234` and
`nc 127.0.0.1 1234`, `task->files->fd_array[connfd]` contains 0.
However, when running netcat under strace, e.g. `strace nc -l
127.0.0.1 1234`, it returns a valid pointer and finishes the
traversal!

I am wondering if the fexit hook is being called before the socket is
written back to the task (like an XDP?) or what could cause this
behavior. I am getting the task struct with `bpf_get_current_task()`.

Thank you for the help,
Douglas
