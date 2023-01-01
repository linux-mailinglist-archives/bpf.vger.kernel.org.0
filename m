Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5FDA65A88A
	for <lists+bpf@lfdr.de>; Sun,  1 Jan 2023 02:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjAAB0h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 20:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAAB0g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 20:26:36 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9B9CCB;
        Sat, 31 Dec 2022 17:26:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 17so25814699pll.0;
        Sat, 31 Dec 2022 17:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YXmArirWOKCsQqCkNHR2H0NTz1sBS3ob8z6XYfcJhSM=;
        b=EkVi5mqEApUhYw8yprhreYLai5e3q3lxe+INSuDsewQ3EQ48mQvzHn6HbETqUW05R+
         xrIPH87p3ltq6jXww+1C9edquRfLZKhbuDxgRsHbvybJ1N51VYjbf/peuwq1wAPC6YEK
         rjs+aXPITNrQoqWZtJk/Dv+pdQYfwEKUzBt5Bheon1LAF/NrfLhaYDu1VboUp4Bw52rb
         d5szHOBAMLRaioeL4LKRj+lwvxZIofEShhmiS3FjXbBrH89EK4N/9xolw2Ef0wxQ2Si4
         0jx/0j2nsQwQ8O5lt8OrI8wM9N5sNKIW47FXM8qXjjuBs1feuxAUYgfIWg9PQvjEqHXJ
         zgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXmArirWOKCsQqCkNHR2H0NTz1sBS3ob8z6XYfcJhSM=;
        b=tVMNzJybuN0hZfPZjsAHE8TaeaVLQVFHdiQWK8NRJlJCb4hqY2236v13QZNRjKnmhe
         qj03ywrnWd9Q0JETKqOjsn6cjSS8p6o5eprLXlgxk8LRuQQT00iMZHYOtTgvzSGDLms5
         haz7om5XNL+KeFR/yhao1BBeAl6T1mElCrlEi0lzfRSk9SDy6fs1PYzYuLLx7BWuVr/w
         BNuM3JIEDs+qwansM3mGkCcdDVlP834/GVkjQGHRJQJSBiq7Q226MP9TgXHGmf9e7IQo
         wkx4jD7zgovev7NcGUlcbxCcc76S19WIv2MfAKA3B+O4JdRuMM5xU1YfBoe/UeelokWT
         8Ktg==
X-Gm-Message-State: AFqh2kqHrFj1dfcK/4YjB4pf7ngreYGy4IDwY+NzYMuSKC1xKXlb/oMv
        clxp6+xRRY2HnyGCGHjBP/c=
X-Google-Smtp-Source: AMrXdXsTBnCWk7472F4WmCpZRZXDkmFWIlofS1s0e2dhVoI6r3MpgId5n8Lcix3+7LC2tVVRXm4JXQ==
X-Received: by 2002:a17:903:230d:b0:192:a174:178f with SMTP id d13-20020a170903230d00b00192a174178fmr16633582plh.37.1672536394008;
        Sat, 31 Dec 2022 17:26:34 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:1385])
        by smtp.gmail.com with ESMTPSA id l3-20020a170902e2c300b00192bf7eaf28sm1216327plc.286.2022.12.31.17.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 17:26:33 -0800 (PST)
Date:   Sat, 31 Dec 2022 17:26:29 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: Re: [RFC PATCH bpf-next 0/6] bpf: Handle reuse in bpf memory alloc
Message-ID: <20230101012629.nmpofewtlgdutqpe@macbook-pro-6.dhcp.thefacebook.com>
References: <20221230041151.1231169-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230041151.1231169-1-houtao@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 30, 2022 at 12:11:45PM +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Hi,
> 
> The patchset tries to fix the problems found when checking how htab map
> handles element reuse in bpf memory allocator. The immediate reuse of
> freed elements may lead to two problems in htab map:
> 
> (1) reuse will reinitialize special fields (e.g., bpf_spin_lock) in
>     htab map value and it may corrupt lookup procedure with BFP_F_LOCK
>     flag which acquires bpf-spin-lock during value copying. The
>     corruption of bpf-spin-lock may result in hard lock-up.
> (2) lookup procedure may get incorrect map value if the found element is
>     freed and then reused.
> 
> Because the type of htab map elements are the same, so problem #1 can be
> fixed by supporting ctor in bpf memory allocator. The ctor initializes
> these special fields in map element only when the map element is newly
> allocated. If it is just a reused element, there will be no
> reinitialization.

Instead of adding the overhead of ctor callback let's just
add __GFP_ZERO to flags in __alloc().
That will address the issue 1 and will make bpf_mem_alloc behave just
like percpu_freelist, so hashmap with BPF_F_NO_PREALLOC and default
will behave the same way.

> Problem #2 exists for both non-preallocated and preallocated htab map.
> By adding seq in htab element, doing reuse check and retrying the
> lookup procedure may be a feasible solution, but it will make the
> lookup API being hard to use, because the user needs to check whether
> the found element is reused or not and repeat the lookup procedure if it
> is reused. A simpler solution would be just disabling freed elements
> reuse and freeing these elements after lookup procedure ends.

You've proposed this 'solution' twice already in qptrie thread and both
times the answer was 'no, we cannot do this' with reasons explained.
The 3rd time the answer is still the same.
This 'issue 2' existed in hashmap since very beginning for many years.
It's a known quirk. There is nothing to fix really.

The graph apis (aka new gen data structs) with link list and rbtree are
in active development. Soon bpf progs will be able to implement their own
hash maps with explicit bpf_rcu_read_lock. At that time the progs will
be making the trade off between performance and lookup/delete race.
So please respin with just __GFP_ZERO and update the patch 6
to check for lockup only.
