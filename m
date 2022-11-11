Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B676260C0
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 19:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbiKKSAz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Nov 2022 13:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiKKSAy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Nov 2022 13:00:54 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47CF63BA0
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:00:53 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-36ad4cf9132so50641787b3.6
        for <bpf@vger.kernel.org>; Fri, 11 Nov 2022 10:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=41FSVLBMM5AJdk5P4sGQj/aCbFIIrSizvcrUtH9o22Y=;
        b=ktykSVngNLeZRMdyVIJc6od3t0ucJkYIumZOuLN26S21/cQ9siD6Juul/PFQpHJZeu
         H/dj/KF47St+DGf3K6cxpEXtUmF9TYFqeoCXDS8Z0Fbz0J1BrPkGNIvRGY2iGAE7lrKk
         4Ay5Cypf1DuRiINSX6K91g3aQyaL+vCnJoyqV8RNy05Zv77GS7OD8ah+K3fbhKdixR7O
         Yza6Egd8G7rgt1UluDVYORmR8hyjVnRJW0gAsjjgMCNfD9lCZg9Z6KBRNZYH4WYCq58W
         3npWMLX0xMhvE+2jgCTh+MOP6BzBnStXG6IJ8khsUt9jbs66dhJIhyX6JHL8r1fSxO6K
         aqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41FSVLBMM5AJdk5P4sGQj/aCbFIIrSizvcrUtH9o22Y=;
        b=uNLBF37kUVkmU1x7YPD71WkksLtjCX0T1Rf6qxc21oiFXvNMTEnZsP/krQ3+H3wjEK
         vaNS/CngIktxX1AqmTiCxe8PJFzT3jqtli4ZCnkzTjM/609J0Spyw54+hc45SMlHfpoQ
         37AW1NNDOkPB3ajZMumaj6Y7+PAn+nV5NMszfCY+bGhmpj5b6UJZvOYDLJWawyJpRnn2
         0kwF7Wxiv5w1w8tRwxNQaxzsgovjoeNk3ryLOXK3/vNlXO538Bh1YhEjUd/YBwCJCfa8
         mDpvGKw3OYHLqjSx0bAN9QhuGOZMN4jaIjoP6+kHAUPMTLQCZsnJVyxC6Spz51oPN5Ut
         LrBg==
X-Gm-Message-State: ANoB5pkWWit5quyOQjg+D0Z0hAFN8P6wM9mG9vRxeE6ltpd0w5gMFZqm
        Z3iHgdcJs5lz9mxXxD7IMJR6OnbWR+exlW+BfdAoqh8USOeqag==
X-Google-Smtp-Source: AA0mqf7N4cNwjO2WKNiaO9pW8j79osgthfv4zNP4PmHyH1Zu9AuCYlWH/YOaz//OrWXD6FDGD/afRELbE7gMnhwl6U4=
X-Received: by 2002:a81:10c3:0:b0:368:4280:6e6b with SMTP id
 186-20020a8110c3000000b0036842806e6bmr3105578ywq.416.1668189652868; Fri, 11
 Nov 2022 10:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20221111063417.1603111-1-houtao@huaweicloud.com> <20221111063417.1603111-4-houtao@huaweicloud.com>
In-Reply-To: <20221111063417.1603111-4-houtao@huaweicloud.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 11 Nov 2022 10:00:41 -0800
Message-ID: <CA+khW7iTVa3K_bus7ieCwXBLj=kdMcDn7VHMVhfbt=1V6DF_0g@mail.gmail.com>
Subject: Re: [PATCH bpf v2 3/3] selftests/bpf: Add test for cgroup iterator on
 a dead cgroup
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 10, 2022 at 10:08 PM Hou Tao <houtao@huaweicloud.com> wrote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> The test closes both iterator link fd and cgroup fd, and removes the
> cgroup file to make a dead cgroup before reading from cgroup iterator.
> It also uses kern_sync_rcu() and usleep() to wait for the release of
> start cgroup. If the start cgroup is not pinned by cgroup iterator,
> reading from iterator fd will trigger use-after-free.
>
> Acked-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Hao Luo <haoluo@google.com>
