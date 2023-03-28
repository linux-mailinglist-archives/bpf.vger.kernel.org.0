Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF3B6CC97E
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjC1Rmk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjC1Rmj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:42:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5671DBF3
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:42:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w9so53010434edc.3
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680025355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OdjXZM63BnqFRkAjlfnPpinEdD7TpZ20uen1Kc76yzY=;
        b=XkSSaVRhEu8Jkiy0akM6wNvHj81vWyDUX4zDbELthR0W7IKpQL5VFjzfb4O7oRJJzx
         /+V55i/y66oIT17EyRgliReH0SzCaNchzN37b7i9Qy0JtGZpxpt7TDCkTv3Y8TJq8/cS
         XOcgYZMVWjFB/pGadqgIUEGENaTNPM9ivJBqqcUY22+PWsjwhB34WKDjosN59L+2zHzd
         9UCNcEUVm8EhuOlILx44UWRGvgqsn/bty2TQm7+eBdaRlAsjqc6dHNsL4cpUS9UT+j5B
         6OQYzm4H9GReeF59X9O43IdgySJFfL9l+9J/dVpP2YlhzNOLrcjJfVgUfcaZE7yZ/JXP
         mKvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdjXZM63BnqFRkAjlfnPpinEdD7TpZ20uen1Kc76yzY=;
        b=TyXpmFdtw8lH2w32EGTT1FCNpleOFOjFoDGEH5NEXsjjK2k40Q3BgLowtdgZzkHFz0
         UH36ccnbQWC2a8OjTdRn+iC7Ua6Aeq85CWG8eSBqjiWAt1Nye84s/8hE3PAx3Xmsvqia
         46HBmxDJ/9xAAcR2hmS8l7Aul/6dN2e9t0w0DdwKprc64Cn0G21nffwc0eVDfNLZMwul
         D7CBjmZFAuC8wqK0y5i8nD7kmizp3qtXSCIUlAWh/FciV7uFKmdmLpZnbc5Ygn5aX4np
         7g581q4yax7j5zCI8b+AKVMO82pwBBoRPcoF1PaBeuj8sJeH91hUp5KxrvOVS2g3ZTHB
         TRtA==
X-Gm-Message-State: AAQBX9dRVzioOKLM7G8+kd79h1IdlhD9EhkVvYOs8QTFc6yUEGv0ooaV
        tf8+7S6VHtpOqUnxuTp7kHIXgA==
X-Google-Smtp-Source: AKy350amP79GzP8XYvyQlTbyF7h5Y94HZ31RR7yRjEski8rNi0DQR5LhSQYAPBPO0k/xCK9hXfVXbA==
X-Received: by 2002:aa7:d658:0:b0:4bc:f925:5dbe with SMTP id v24-20020aa7d658000000b004bcf9255dbemr16254610edr.42.1680025355066;
        Tue, 28 Mar 2023 10:42:35 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906924500b0092be625d981sm15559189ejx.91.2023.03.28.10.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:42:34 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:42:33 -0400
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
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 1/9] cgroup: rename cgroup_rstat_flush_"irqsafe" to
 "atomic"
Message-ID: <ZCMnCVe4UZx5E8KM@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-2-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:30AM +0000, Yosry Ahmed wrote:
> cgroup_rstat_flush_irqsafe() can be a confusing name. It may read as
> "irqs are disabled throughout", which is what the current implementation
> does (currently under discussion [1]), but is not the intention. The
> intention is that this function is safe to call from atomic contexts.
> Name it as such.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
