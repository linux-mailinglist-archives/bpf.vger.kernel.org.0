Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE5624EF2
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 01:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKKAcV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 19:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiKKAcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 19:32:21 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEB75F855
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 16:32:20 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a5so5596717edb.11
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 16:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iN8jLnOUurNDE1LhOcta2WRG5fQaLxDkrNS8/Q1qwiI=;
        b=bQWlaIv6JEqXx2MGV2OoxO5rKBrR6e0v9QMXV5fDyu30WW0K1QkriK7o/vLBRFaPF9
         6kVP7zOpKB8sqdaJvTKP/InMUq39MrKtO4jdRgFddCFrPp0FzQzQivqSy7zwaJWBnAlY
         IguD1C+MGOoHA54Otsx6spnveiayKETzgL8vzbRfHPiI88fybmFy9pGqrXtcFpVtYoRV
         enEd6fxnBE/U0Zae04yol/sELVySXR0RNH7I8xEIrkQeTglvLS2nbxdUDE9Hl+9LVmTl
         51uZgT9/yNUJZ3un1TPQkzgCJMrgHo4CT4CHS9eWSlSPDELK3p4A9dDhA9IvHmhkSV+M
         94bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iN8jLnOUurNDE1LhOcta2WRG5fQaLxDkrNS8/Q1qwiI=;
        b=esF0QhL6JGmpLSDqMqbBCCeLPQ1d4bP2F14mEnrU2HQzLiOQvzKPveNmdsFh4fVxsa
         0dGP+0UUek7VUtcr0JxqlhhT6LSx3fZhzGCWY0JeXLqDbrwaP+eQ7VAfoIc11QIpZIom
         P5Bhd0yQ9EMc6MndwM8D6pwWBld9VXzLqGYOmVS/9g6+BwM2KiWsAm35lEAlnIjc9RsR
         I3gguTsfEd4jGPAvIMEtYG0xAkBDAnOhTXwI9CwipMGqPA+HeoalhgvAvQ8sPdhGN12B
         efS1m/rir0IiPMATD16BXbc3uSxXSbEpPZMcW+xS/KPL1FibVF8k7uWrndYIz3KYYLcH
         mqIg==
X-Gm-Message-State: ACrzQf3oruHj3WM2eTUysXg4vAzfAw+CTzf9W9azq817PmijY2+kcNry
        31tc7Ha74eqMIShUrHSEC/8TffMM3/wsrdZliwzC4f+Arbo=
X-Google-Smtp-Source: AMsMyM4mRoHs31mqsAqacjHTKSPkx4diDvPWvrtw1r6woGW7CKOQnQGrF4LMNxnaUGvDcQoj9gO1bfsKuo9Dxrx5v2o=
X-Received: by 2002:a05:6402:1d83:b0:45b:e6:3ffc with SMTP id
 dk3-20020a0564021d8300b0045b00e63ffcmr3838628edb.82.1668126738492; Thu, 10
 Nov 2022 16:32:18 -0800 (PST)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Thu, 10 Nov 2022 19:32:07 -0500
Message-ID: <CAO658oUrud+RaV4dAWQ+JYkDttgW00xyDmsoa8-vCeknQNjVtg@mail.gmail.com>
Subject: Best way to share maps between multiple files/objects?
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi folks,

I want to organize my BPF programs so that I can load them
individually. I want this so that if loading one fails (because of
lack of kernel support for BPF features), I can load a fall-back
replacement program. To do so, I've organized the BPF programs into
their own source code files and compiled them individually. Each BPF
program references what is supposed to be the same ringbuffer. Using
libbpf I open them and attempt to load each in order.

My question is, how am I supposed to share maps such as ringbuffers
between them? If I have identical map definitions in each, they have
their own file descriptors. Is the best way to call
`bpf_map__reuse_fd()` on each handle of the maps in each BPF object?

I'd also take advice on how to better achieve my overall goal of being
able to load programs individually!

Thanks so much for your help,
Grant Seltzer
