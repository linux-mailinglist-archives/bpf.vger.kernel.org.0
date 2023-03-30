Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D5A6CFD26
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjC3HnV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 03:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjC3HnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 03:43:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF7A5FF7
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:43:14 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so73024015edo.2
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 00:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Qxb+z0M56kXGKsGqUzmde7aSXJSNER5bkDSqRNFsW8=;
        b=UJBukVFEt5dB7HsMZhm8rpG6GkSrR6oamn4AyWhd8ZQPOX1GhBV/ZV16dR83JU1y/X
         N30JaFrz+2vGq5ca63TxcCERgT6qek7mqtmN81N5//AscM6N8cflImnSD/ZahG+4q0Xn
         9qp/XyM4ZMQRj7L0H7/4AehjvjsguULR7WeiMPvo+WNkpMojlq5AXSO5o21krpYdZ7B3
         PB9AZFZMuLkAAEJQVYvz3QY9bGxfNFE34InRWkd4v45XrEk3Mww05p5yDkBJhramLr+a
         T7lX9urUThW1psrr/JFE2xLVVKoi0OfuM7xGQ2KkdeGHTHhVMnrIjKr3CZ5s/MVVlIAH
         QpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Qxb+z0M56kXGKsGqUzmde7aSXJSNER5bkDSqRNFsW8=;
        b=HNDQT8AkcdvZY2kumYVdyCuPXP94+EfcweDJxNbR9Sf56gNmtTZHLR6WxeJJpDqx7/
         cdZOfhvYjfMIE93ddZ3tnDmzHOrhOpBXqY9S5S1AjJJb0ze1v/YkiBLUH541wRzkPqFk
         SrvE5IY9wL4UNf288NTBAn2m3MkpIkWjkGOyK6GZVEcg/2UmaNni9lGtvMeVVLQfQHeH
         IcS7ox21Al0zTerGDzIcu+JSC0sfa0BRjA9vGqpA66Z01AZMUQ3Zc6UN8G2Z8ztKcWJ9
         uRTFGfSBNVv/uwzINfyrekwzV10r5RzeoT4pfT/L/WlfaNDP7VqYxqVeZB7kutiD8XTE
         OH1g==
X-Gm-Message-State: AAQBX9eea4ssj4qs3tyh4/J9H1ZA6eG0afVWZ05D44Xv2ii8PkuvciLW
        ktw5yIUvXd7lQe1UN7PFmWZl6nZAFuo7JTKbZqm3eQ==
X-Google-Smtp-Source: AKy350adp4S5XsudZey37elUZ5q0L0p7Iwz+j7h/yciRdtLAgVA0EL7LYgLVZr1SbfHf+UbmlaKLQyfCX54NppPfH9M=
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr11518130ejc.15.1680162192486; Thu, 30
 Mar 2023 00:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-8-yosryahmed@google.com> <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
In-Reply-To: <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:42:36 -0700
Message-ID: <CAJD7tkZLBs=A8m5u=9jGtMeD0ptOgtCTYUoh2r4Ex+fCkvwAXg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 30, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Tue 28-03-23 22:16:42, Yosry Ahmed wrote:
> > In workingset_refault(), we call
> > mem_cgroup_flush_stats_atomic_ratelimited() to flush stats within an
> > RCU read section and with sleeping disallowed. Move the call above
> > the RCU read section and allow sleeping to avoid unnecessarily
> > performing a lot of work without sleeping.
>
> Could you say few words why the flushing is done before counters are
> updated rather than after (the RCU section)?

It's not about the counters that are updated, it's about the counters
that we read. Stats readers do a flush first to read accurate stats.
We flush before a read, not after an update.

> --
> Michal Hocko
> SUSE Labs
