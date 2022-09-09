Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EFC5B2E01
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIIFW4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 01:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiIIFWz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 01:22:55 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7319210E84C
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 22:22:53 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b23so467088iof.2
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 22:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=k4wAQyAK4vHNpNiTrG7fMmxiHjuzn99w2bcbeAV+sjQ=;
        b=B2iHOX1/YU0Aje2lA/qQ3KdYad8+BvVFJ/d/djmonaK4koWkeVH4VEhFJjo7+7XcQZ
         jLGIVXH3dJfrwkFMAYIqG+WYZHvuZZjui0uqMel19kq+8sigtnnx9Lt6MRlKBo5T978J
         W/MwRuSoYIaKwJiRIxeGzI03SlEyYB2t73Czo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=k4wAQyAK4vHNpNiTrG7fMmxiHjuzn99w2bcbeAV+sjQ=;
        b=HwHQzJXDmcBPVdY6rBjTkFxpI/oqBBHJ+UlONExjitpzif36pu+wEGDJcFrsAQspfz
         OixXLz1MAdCzJY5weGHBDIi1bfMX1adn0tvWg5Jj62WusHpHPIurfIqUKe1E3UbIPmaw
         NHOAO961dx842MidIADO30FSsPIfxvSgZkLH/fLGDf3a+8cx7zfLMKBCvwLdMg/DyNo6
         idShhKf92wG8l2GOCSm3H3cur+zlMS5637qbcQDv6VgbJFymPUQI8cXuvKSmMN0Pmzzx
         xkTpajFsxsAphkHkzzdgBITcy1m+h8mEver9Vzn+hAbeiIXcQk4DG/lt5q0PyNhy6fnd
         JKgQ==
X-Gm-Message-State: ACgBeo04oygWvbaIG1Mu2iSW6ozcGVvD0P4glvc4s1oF6prTFLi4GY6M
        Ib9BzJNENAiyXGgKK8HxFdefDfsbKspHLiuhy0RueBPeEWjfXg==
X-Google-Smtp-Source: AA6agR62fs35xx76x6JNtmM35ZFS5Rovr6IelLiDgO2oiiEAFRWUi4KsrMf0QGr7KXAdHkXxAiw9XfoMoJhyW24dhAA=
X-Received: by 2002:a02:84a7:0:b0:358:3910:17a8 with SMTP id
 f36-20020a0284a7000000b00358391017a8mr3798676jai.2.1662700972727; Thu, 08 Sep
 2022 22:22:52 -0700 (PDT)
MIME-Version: 1.0
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Thu, 8 Sep 2022 22:22:42 -0700
Message-ID: <CABi2SkUVSMM-+7RzGu0z0nwsWT_2NiUZzTMNKsEc0iOPSiNr9A@mail.gmail.com>
Subject: BTF and libBPF
To:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Greeting,

I have questions related to CONFIG_DEBUG_INFO_BTF, and  libbpf_0.8.1.
Please kindly let me know if this is not the right group to ask, since I'm new.

To give context of this question:
This system has limited disk size, doesn't need the CO-RE feature,
and has all debug symbols stripped in release build.   Having an extra
btf/vmlinux file might be problematic, disk-wise.

Question 1>
Will libbpf_0.8.1(or later) work with kernel 5.10 (or later),  without
CONFIG_DEBUG_INFO_BTF ?
Or work with kernel compiled with CONFIG_DEBUG_INFO_BTF but have
/sys/kernel/btf/vmlinux removed.

 Question 2: From debug information included at run time point of view,
(1) having btf/vmlinux vs (2) kernel build with
CONFIG_DEBUG_INFO_DWARF5 but not stripped,
are those two contains the same amount of debug information at runtime?

Question 3: Will libbpf + btf/vmlinx, break expectation of kernel ASLR
feature ? I assume it shouldn't, but would like to double check.

Thanks
Best Regards,
Jeff Xu
