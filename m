Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE796AEE36
	for <lists+bpf@lfdr.de>; Tue,  7 Mar 2023 19:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjCGSKZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Mar 2023 13:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjCGSKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Mar 2023 13:10:06 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9318FA4023
        for <bpf@vger.kernel.org>; Tue,  7 Mar 2023 10:04:35 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id y10so15347476qtj.2
        for <bpf@vger.kernel.org>; Tue, 07 Mar 2023 10:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678212274;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/38czkeiObNzAMYOqgk4npiUI9VZ61cIyHyNe2ksKE=;
        b=dWA0HdzmbUKpe/RLDkvpOBY4DdCft2HLBSg5aGoZSEtO5FsIaXO3KYB47PReJHP5AZ
         WvSKsqMLGvHrVa048orx+GrxmlUdngHp264HpGI2W7RwrJxyW59i/ldQVJS2v2CoM00e
         X4LhtLELLBv5aY4kQ9V7WGTJKDzHf9guImliLo+h5AQSZVyI/LAKfG99/ngvmY0Q8TNs
         kIieBZAQEtpC9aQyrwvS6sKxqe6tgm6c6/CZqPrK47+heW4W/txnfBp5u4a/Us4Q+96K
         tZ/17I09k2lPNmfwl5zkZfncnApZd0hG2/6v6uCc3Jcjw8Gql3SVGOIbzATDPMulDsba
         1AuQ==
X-Gm-Message-State: AO0yUKXfVLuGrCf1OEfxllKbIfsuy063alqlr3w/d8/XdJNr12Xp5fsz
        aH6wGw6FFnQS/NkDwysmT+g=
X-Google-Smtp-Source: AK7set+qiTo+yFd+6Vv75gyL8ki3RkMYQoR011lxWsuaXaz+WLo7s1Za4vYN6tYLEN+ElNJ0+Sbt4g==
X-Received: by 2002:a05:622a:4c9:b0:3c0:40c1:e7bf with SMTP id q9-20020a05622a04c900b003c040c1e7bfmr96691qtx.22.1678212274530;
        Tue, 07 Mar 2023 10:04:34 -0800 (PST)
Received: from maniforge ([2620:10d:c091:480::1:2c8e])
        by smtp.gmail.com with ESMTPSA id i10-20020ac871ca000000b003bfb950f670sm9980501qtp.41.2023.03.07.10.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 10:04:34 -0800 (PST)
Date:   Tue, 7 Mar 2023 12:04:32 -0600
From:   David Vernet <void@manifault.com>
To:     mattbobrowski@google.com
Cc:     zohar@linux.ibm.com, kpsingh@kernel.org, roberto.sassu@huawei.com,
        bpf@vger.kernel.org
Subject: BPF CI regression in IMA
Message-ID: <20230307180432.GB4387@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Matt,

It seems that [0] has caused BPF CI runs to start failing in the IMA
tests. See [1] for an example of a failed run.

[0]: https://lore.kernel.org/all/Y7T1hEhIL5TEmLEN@google.com/
[1]: https://github.com/kernel-patches/bpf/actions/runs/4356022302/jobs/7614059918#step:6:6298

CC'ing KP and Robert who added the test.

Thanks,
David
