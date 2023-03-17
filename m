Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4C56BEF59
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 18:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCQRQo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCQRQn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 13:16:43 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A906B854A;
        Fri, 17 Mar 2023 10:16:40 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c10so3520370pfv.13;
        Fri, 17 Mar 2023 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679073400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y24dD9SurSVZudT7syqKqVCObHCsVLG0RCYuKVO5vg=;
        b=lz5YCQ+mtJiinHFfCtTtEWIh1QFnjmiq9b1/1QOphlbcyrKBmxBV8NmJX0pYxiaDyx
         Zh8b4JGFOIIRimI8Pu6TPtpxXUltYC5CdFOiqsV+HRDxN1XWDSZsqs8xeSvqsGqflQCh
         OrxxcYmmBlgcaCmB+kjolqikeI9FmpaUsyrthVjurymPAs5XwsVD0T86pHXpmSgQd+9i
         CvsHGnsYj5Rg0+jlqni+0g1Y+uDawko6CDqN2QRJSY7kjt/wO+oAWtPKL+p+XuYcz9Yh
         tFnFhjvX4WN5aiHWjcOP/4acCHS/7jAuaWysxBKS6Ow+yArEsd0eGPZZ0Tf4zOdQdwKz
         1qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679073400;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Y24dD9SurSVZudT7syqKqVCObHCsVLG0RCYuKVO5vg=;
        b=k4pEwPi8j4ruE2OnlrZP4kfKs7Pb2Zd9APLbg96bwDVPX7baYiEynHgY4KZI6lONEm
         0N0CISy99BJ0qBM5L+bBgi0Tvt263voVLSv98NDIwAQRIlQUT3Z8xa1ijTlJqj8PQg+J
         l/nCV4Ko6ZaLIKt+IexSDQ0t0w9hy8waVMwKFXY/x8c7B1qx77O16RRPtJghvca/Z1Rm
         4wLkjXEGlKUJ1vlF0X/05ICfbP5XDS52PcBsDUKoMbrMPsqXqlLGvxJwHEV3sJgxEaIC
         H9v0434jVv8aKPf0uN4ZbKPX0rWhzlVyYDun58q8L8bk8eG6eGW3yb/QDIg6hkH26hOl
         +9wA==
X-Gm-Message-State: AO0yUKXx0E7DNMUPB/ijy8wBekvDetORQykv2FNEExZDhORaDbCNQhRG
        kCZZ0whSZ7i2HzdPrrUyUxI=
X-Google-Smtp-Source: AK7set/Bq9UvcAsURmU3NPoXn/5o6fZ+BnWZhTN+6XSGaKMKzrvRKnTECbUMIcOIo9RnuSx13obL1w==
X-Received: by 2002:a62:1a4e:0:b0:622:ec07:c6bc with SMTP id a75-20020a621a4e000000b00622ec07c6bcmr7263293pfa.15.1679073399844;
        Fri, 17 Mar 2023 10:16:39 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:2bcf])
        by smtp.gmail.com with ESMTPSA id x20-20020aa784d4000000b005a8bc154bf4sm1824761pfn.39.2023.03.17.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 10:16:39 -0700 (PDT)
Date:   Fri, 17 Mar 2023 10:16:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     starmiku1207184332@gmail.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, baijiaju1990@outlook.com
Subject: Re: [PATCH v2] kernel: bpf: stackmap: fix a possible sleep-in-atomic
 bug in bpf_mmap_unlock_get_irq_work()
Message-ID: <20230317171636.ftelyp6ty7mgo4rt@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230317035227.22293-1-starmiku1207184332@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317035227.22293-1-starmiku1207184332@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 17, 2023 at 03:52:27AM +0000, starmiku1207184332@gmail.com wrote:
> context because of its possible sleep operation. However, mmap_read_unlock()
> is unsafely called in a preempt disabled context when spin_lock() or
> rcu_read_lock() has been called.

Why is that unsafe?
See __up_read(). It's doing preempt_disable().


> -	if (irqs_disabled()) {
> +	if (in_atomic() || irqs_disabled()) {

We cannot do this. It will significantly hurt stack traces with build_id.
