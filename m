Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A8A6497ED
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 03:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiLLCT0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 21:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiLLCTD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 21:19:03 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C30BA19C;
        Sun, 11 Dec 2022 18:17:09 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id k79so7556827pfd.7;
        Sun, 11 Dec 2022 18:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YKJdj9MYIrMqKZ09JyoypXDwxECd7m2PMnqlCqw5ReU=;
        b=KKGKvbg/FvnJ4bhjjj9hRMSt87AU4EfzVCnXHJClOg5qRyqa9A6dxZsyUwWu3BwR7f
         QwgInr7/U1eEJJNaeTTiqAkv+EFyBZ+gNM15fZD7dk8xhPaI7vDO5L9i5Yh/tw3h5as5
         DH1N9nrY16I8uVfj1X1T0vIbMAe7bdGakvhQOG2yfqjIInqPaCOFDrWrVFlrtoJBrzor
         Ijv2zTlHp279U7pKsAmQmb0JBFrBSgXX7BevhwWdOxQ6F75NAzUGrcxu33wVXr+XwPfo
         4fsNeioqefA7+5NHZvfWES8dG9+K3kNFFFzt41RV+YJbBtOPZhMACihyqfO+DgxLdUCd
         AXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKJdj9MYIrMqKZ09JyoypXDwxECd7m2PMnqlCqw5ReU=;
        b=uGbFcrt3RySZcvBxdvhbboOSzeQWmOIWmSXfvQiQxPVLB4PrinqNA82q/cPDE2EB9B
         Es01ljDJWvgVHkqLyC2qJJErjUIjoAde15m2iR7EcQINR98M2oQMvXAAfg4ibWS7YoXx
         nR8T6dVMQApcmgu+/+v3Aqn8IebGSZ01MljUBu1Bne+tnPuf5kfa7JSoroPCE35ZlHr9
         ubYidZI4VtcwzmCRb5vq3zHDPRp8BrX9UeokAmKajspMyXtslvpghX5PIMH06n1vZZNI
         B0eLIZfZ3Yk4SbDvg6R11hMWfXcvQED8RVPhBvLE/OpM4TIQnrTkliogDYdqP/jtLc+X
         hvHA==
X-Gm-Message-State: ANoB5plZ6rpM/8aqSqrjOvIFjP65NG7cdE2pIULvYxacFD/DelE31fGM
        bN5CsrPstebKSebaS9zrsAhAo1HUUcGEoQ==
X-Google-Smtp-Source: AA0mqf4HCAvtNIMbRxxr6JOgNHeMg0RPE07QYW7S8giGoZA3ht2N7Ptb3BZEwoNhB09u4sKDvRXgBQ==
X-Received: by 2002:a05:6a00:182a:b0:577:daa0:eb68 with SMTP id y42-20020a056a00182a00b00577daa0eb68mr15588789pfa.25.1670811428393;
        Sun, 11 Dec 2022 18:17:08 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::5:53a9])
        by smtp.gmail.com with ESMTPSA id i25-20020aa796f9000000b00571f66721aesm4572837pfq.42.2022.12.11.18.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 18:17:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 11 Dec 2022 16:17:06 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH] sched_ext: use msecs_to_jiffies consistently
Message-ID: <Y5aPImWzkhIY0CuR@slm.duckdns.org>
References: <alpine.DEB.2.22.394.2212112334020.29296@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2212112334020.29296@hadrien>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 11, 2022 at 11:43:30PM +0100, Julia Lawall wrote:
> The watchdog's timeout is processed by msecs_to_jiffies when it is
> checked, but not when the delay for running the watchdog is set.  The
> watchdog will thus run at a time that is later than that time at which it
> is checked that it has run, and the scheduler aborts.
> 
> Add the needed calls to msecs_to_jiffies.
> 
> Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
> 
> ---
> 
> Another solution would be to use jiffies everywhere.

Yeah, that was how David Vernet implemented it in the first place and I
insisted on using non-jiffies unit, which clearly seems like a mistake. I
think the right thing to do here is using jiffies for everything.

Thanks.

-- 
tejun
