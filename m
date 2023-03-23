Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61AC06C6C8F
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 16:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjCWPup (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Mar 2023 11:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjCWPuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 11:50:44 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C92D75
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 08:50:42 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t19so12974122qta.12
        for <bpf@vger.kernel.org>; Thu, 23 Mar 2023 08:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1679586641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MgbjNxnbkhKxp3ayTqCe/JjU9SvNsSkqQJ2eCY+DMZI=;
        b=Uax95WAssNXE3MIDqKKB3u/nqAPCZSxTVSddkIH48B1KHmuIotqFwdvX5KENELaT+e
         srIzL8LklW2Ssqy1T23s3P4A7Rbrwc7/2yIjR9CSxZFKptYFPEBvPh7JwY7gaMOp6w9N
         FojxMBtSySjPkBprMQil3VsaB32A1a94++3AgzvX44rNqNkl9uduUufYh1DyMwtlafgk
         0nO9yh1udd1cAqnMBwDvHsl7/slURj+lRn5rIZtNHBwsOQfAB+bjCzuke3CE1Sje0C5q
         +vS4rnZ/lpITkAcIgL5Cs5+LDhdOP+yzSSHCyKfUF8EepIy2Cfeo4UXGo9FZbR6oDODF
         5qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgbjNxnbkhKxp3ayTqCe/JjU9SvNsSkqQJ2eCY+DMZI=;
        b=tpQ43cyjTrBuAWoMzTRZX75REtRfKRGO8hHQvrcPlpgoU33w4Fj7ZQEOuFQys+NfhZ
         8ae6VvmnVbti6KBg2WB6+uicQKhyOL5VTBYxDFMcavLILR90y1tL6KsW2m0CJKXc9Hjl
         FMNdGBINN+gZ2eJ9TpTFlJQfoRG+/skhVTjlRj/YXcgteBfbnePkv2SadUaqo9xxf3jX
         Qtf4O1+UoZO/znmlQR2jtZYjD/XGstbDPHDj/XDLo/3PHM0u4Mcr7QbJoN4reCsTP3a3
         TcMEqdqxRe0o55zMQ0uW8u8vVyFMm75fhrTwv/vounfvMDAGVINgLqYta4yjPvNsEoPN
         zDug==
X-Gm-Message-State: AO0yUKWCROgBjRTIyTycGkSLtQPHJ0XdxaHDb+j+1OcweNfnViF3kvEA
        RGxfqHNf+KoY2oVXXMtv4yV4+oHSNW0PmkmsmHw=
X-Google-Smtp-Source: AK7set+/zJMyNiSMTKDzy3E2l/DM0mRht23TAL9P5RJkKER4z4Xh6WDwUYLoOR1VqnmcxtaT9g602Q==
X-Received: by 2002:a05:622a:1893:b0:3e3:913c:1c9c with SMTP id v19-20020a05622a189300b003e3913c1c9cmr5154867qtc.1.1679586641731;
        Thu, 23 Mar 2023 08:50:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:62db])
        by smtp.gmail.com with ESMTPSA id i22-20020ac860d6000000b003dd8ad765dcsm7142374qtm.76.2023.03.23.08.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:50:41 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:50:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [RFC PATCH 6/7] workingset: memcg: sleep when flushing stats in
 workingset_refault()
Message-ID: <20230323155040.GB739026@cmpxchg.org>
References: <20230323040037.2389095-1-yosryahmed@google.com>
 <20230323040037.2389095-7-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323040037.2389095-7-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 23, 2023 at 04:00:36AM +0000, Yosry Ahmed wrote:
> In workingset_refault(), we call mem_cgroup_flush_stats_delayed() to
> flush stats within an RCU read section and with sleeping disallowed.
> Move the call to mem_cgroup_flush_stats_delayed() above the RCU read
> section and allow sleeping to avoid unnecessarily performing a lot of
> work without sleeping.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
> 
> A lot of code paths call into workingset_refault(), so I am not
> generally sure at all whether it's okay to sleep in all contexts or not.
> Feedback here would be very helpful.

Yes, it's safe.
