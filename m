Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3627F6A1A34
	for <lists+bpf@lfdr.de>; Fri, 24 Feb 2023 11:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBXK0b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Feb 2023 05:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBXK00 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Feb 2023 05:26:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAC966944
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 02:25:47 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c18so6437705wmr.3
        for <bpf@vger.kernel.org>; Fri, 24 Feb 2023 02:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PlbsCfhS/O2ZL4AQnO4s+rOucl7r3i9JbuixkHygLoU=;
        b=bSfis1nBFqvp+IkCMvM8TAl9YjY8cQ2xx6+rT2cBBT5ISyH6bL/zqte2s9DBpuqbAP
         SyWtr1QTvWO7LtUUB2DaKZaIL8A8HQjUsaVVqf+pSBOkjzj4rkZSSSefspA5Bhs0H8k7
         4CfWuXhboIp8k1seIfIkv60CNjIPDKl5YaPOnOsVlo2DyDxei0YA4DM9UoPRUMW2SiNV
         Z7+vQwjXh3cPI0r+FJ7ie208Babita2b7w8ZjVSnXbmooA/mJh4JLZqWwv4HHmuFlsLV
         8IGDxch4s7G4usrr7VmY+GINsBWJqrnggsozDHuNMTaGmaDWgdRuYeHI0TNr/OwtWi0+
         hn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlbsCfhS/O2ZL4AQnO4s+rOucl7r3i9JbuixkHygLoU=;
        b=vaQaj7dAN452xW0PuWn+uA3ZEissu4D04V18457tXjmN5ZLh4fL9LK/+r8YUqabVfY
         y4Ei8i7qJePKgpAysnj0mOG+D/LrQuBvc1x1Gyu4Y5BhawVze9iaI7LTQyZwAiNp1r/D
         1+YcL9+ubsag4W5vpwVVrgq/ze1ZHeg3hdRd/qpWVXqgtzqspRULqhRWKMIUYSr1AAk8
         fR98jJmxoYZ6OanwSQWB0O0weM4e26z6zOViVK0cRUnH9qPmvpZzIrtAKXr83xMovW2n
         wZVUZFP6SI9VDY00bHwZEmAcwAkeGi3liQqwKQNdI/f2E3SKJ5R7IJUB5nAMSt+jz10h
         QN3Q==
X-Gm-Message-State: AO0yUKU6mJsnLa/EDRGZE5lhPFGJ6C210Y3soiGr0Hb4OqyoQrQoP8eA
        81ppt0qZObO8Re90eaOijUg=
X-Google-Smtp-Source: AK7set9LDnJZ0zcNXwkYboEhKfnCXHKS5eMuh52EvafowtYpb5XY4dkNlTRt67Ye4HuME6k+BVDwEg==
X-Received: by 2002:a05:600c:b85:b0:3ea:f0d6:5d37 with SMTP id fl5-20020a05600c0b8500b003eaf0d65d37mr2174822wmb.8.1677234325201;
        Fri, 24 Feb 2023 02:25:25 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d6887000000b002c5501a5803sm10795071wru.65.2023.02.24.02.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:25:24 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 24 Feb 2023 11:25:17 +0100
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        lorenz.bauer@isovalent.com, Daniel Borkmann <daniel@iogearbox.net>
Subject: [LSF/MM/BPF TOPIC] multi uprobe link
Message-ID: <Y/iQjSidojkAkNxj@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have a usecase to monitor potentially many uprobes and current way of
attaching many uprobes through perf takes long time. It's because there's
extra perf event install/schedule for each uprobe you want to attach.

It'd be great to have a another way to attach multiple uprobes probably by
adding new uprobe_multi link, that would create system wide uprobes directly
and attach bpf program to it.

Although that would not solve all the performance issues with uprobes, it
seems like a good start to solve attach/detach times.

I'd be interested in other people's experiences with uprobes and ideas on
speeding it up. The uprobe_multi link prototype should be done by that time,
hopefully ;-)

thanks,
jirka
