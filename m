Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C576CC98C
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 19:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjC1RoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 13:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjC1RoH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 13:44:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921E3CDF6
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:43:50 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ek18so52977920edb.6
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680025420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9pG4ykKXTPasFcUZIf/e8S9vCCN31pN+vneMGpJbP4o=;
        b=56M5bOM/pNtngeUWBHnxJY71NBq4XowDWZ8RCfQNb/yCxXYYMrgyYMqobQXbL4C2JB
         RGGu/tdd2jHQlnibWvl6Yl2Z+V9C6/sqQqYlpBk4QH75MtYWG0vntrQt7EbpI3qbQira
         FHF9oSn85isHlRZq305s1ZjPBaMG8ngitCC5W0QK+URXlKcrqGLcbNcKDtVwKwQLiwbR
         WMQuohmUWWq5bvjuyfeOZWbD0dG18QNgGsHHriTK1OT4ETrZ393Glp5m0QCwsT84vxCX
         wa9EQLvH3eVpihWS8y/qQIMRwHoKRu5ba4FiqWeWAVMZkZoYdAYv+LAzhrhkCBMtOsOj
         R8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680025420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pG4ykKXTPasFcUZIf/e8S9vCCN31pN+vneMGpJbP4o=;
        b=rW6fDmZV+npvItFU3kC5LmXHY/951UcgKH1QgNENq58ZWVcC0Z0AVRSIQgOQ4rEahP
         +k4fZhpEPJXtwOu4w2kLmLOk2OtfdEa7MiSPE+O9AtlMICcVTmQOfKUl69WjopgSv9pq
         q072vC+jo5RSe8egOtQXHX8bZf59i8x/1TZHlMyiiJ8mJF8pl0IJ/Mzz1jVV3uphgDx6
         vZp/j+BNx1LTLLH4/zfer6r9E6ySlllpML7ma51sSDmbudbRJcH9t8dEQVx9MErrUE+p
         dYGGXEwZb46BXm4vGWxYRNc+jpu5d2j/Jn4na1wWvwdiu/CX/PEpHb4oQyZu40niBF9L
         plzw==
X-Gm-Message-State: AAQBX9cFvSnZ3e2XimlbB8aCR0Rb0WG9dhq89c5HwOh/8kLI16RmVZuH
        BHFzeDPzaT097iTCCyO9/ONGow==
X-Google-Smtp-Source: AKy350bEMUfD5edr2eY3ReXrsmi/UKNwI4AGoYGOQQHnouyDcbguhMOmjjDAI+qc0Tc8bdcoatqnCA==
X-Received: by 2002:a05:6402:1a48:b0:501:d3a1:9a4a with SMTP id bf8-20020a0564021a4800b00501d3a19a4amr16860635edb.19.1680025420478;
        Tue, 28 Mar 2023 10:43:40 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id 8-20020a508e08000000b004fa012332ecsm11889276edw.1.2023.03.28.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:43:40 -0700 (PDT)
Date:   Tue, 28 Mar 2023 13:43:39 -0400
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
Subject: Re: [PATCH v1 3/9] memcg: do not flush stats in irq context
Message-ID: <ZCMnS8LWXQ4I6vYD@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-4-yosryahmed@google.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:32AM +0000, Yosry Ahmed wrote:
> Currently, the only context in which we can invoke an rstat flush from
> irq context is through mem_cgroup_usage() on the root memcg when called
> from memcg_check_events(). An rstat flush is an expensive operation that
> should not be done in irq context, so do not flush stats and use the
> stale stats in this case.
> 
> Arguably, usage threshold events are not reliable on the root memcg
> anyway since its usage is ill-defined.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Excellent, thanks!

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
