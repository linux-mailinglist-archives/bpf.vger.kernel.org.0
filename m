Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA03695726
	for <lists+bpf@lfdr.de>; Tue, 14 Feb 2023 04:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjBNDMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Feb 2023 22:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjBNDMA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Feb 2023 22:12:00 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD00859C3;
        Mon, 13 Feb 2023 19:11:55 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id a23so9385327pga.13;
        Mon, 13 Feb 2023 19:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QYO7/5Angqr5yQ1/BUE89tYxk6vR+toLyzOX4qJeLwg=;
        b=i0f3c9pJYH+bb2CLcqC7AR83QKMsznnyK6fzl9K09Q9drzlNz4SFjxWpnKCK3Q2GzX
         de14z259y2MTTBSBMoYUIgGAYOqnMdY5Ez56g5/w8e/ecclBrimxCptsWNKR46fLHCPT
         r8xwzWtK0E18Mk9KBp1/WvIvdBMQdXxJXyDgt6V0vknDHjc36SuG+Yn8u3+UTS0AinXi
         +Z6zzsLpI/5zpLYbjc1GchHevdRUFAUMAon12VVy9pcgOL9E6Tl6c0CWXPFvrZ7lCYa8
         PYAQWHWWweHyUJOO5BtmmIpcBlf3F0bKxFOL6XKArqQUxmQYbCDEm8fePY02tg4tD2jX
         b1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYO7/5Angqr5yQ1/BUE89tYxk6vR+toLyzOX4qJeLwg=;
        b=cG+wOVZDN/Kccw2j3INNGXnVaQnRunHKHGkeA1jDYgZ70DwWKz8s4oHyz357wktv3y
         juP1UyeOJYfxMaAmRJiGe1q84wI8AArvpFTXxcbwPJmTf/ISshU6XHU9U3ihoMFpWOFs
         PbdkwHTydvxCcUGtA6zZ+fTYB8YHdzTQmCuYqwYUa7maDsgBhm/9wFMTuhkiP0VCS6j+
         /bnas+gotKjmCeqCLML3PmSSGsoIZ0G/Zj+4wrfGzYDHsewSSWSqYd7Lq/uktQTp2txx
         DLX/l2tqvi4BuTAbB5lGLW3YgHZfEnMs1PkGLu++jR6XLb+PzY5Rt1lgIwrnTFfsmOkN
         EjUQ==
X-Gm-Message-State: AO0yUKWTSDeu9Su7VlRZD3q6tJJ3UjRNxgZwzzSMku760LvE4m1yN3mY
        PlUn7umTEljnbkyDnTxJmUI=
X-Google-Smtp-Source: AK7set/e1eZ4KVPhaG7IYc820NMqOYZZm9yrOnLopoymvxpnjHNvA/6o2hHDid4bOD4IGNeGbzAwvg==
X-Received: by 2002:a62:1bc8:0:b0:5a8:ac17:fa6c with SMTP id b191-20020a621bc8000000b005a8ac17fa6cmr649919pfb.15.1676344315255;
        Mon, 13 Feb 2023 19:11:55 -0800 (PST)
Received: from Laptop-X1 ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id x5-20020a654145000000b004a737a6e62fsm7792425pgp.14.2023.02.13.19.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:11:54 -0800 (PST)
Date:   Tue, 14 Feb 2023 11:11:45 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Felix Maurer <fmaurer@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH bpf] selftests/bpf: enable mptcp before testing
Message-ID: <Y+r78ZUqIsvaWjQG@Laptop-X1>
References: <20230210093205.1378597-1-liuhangbin@gmail.com>
 <6f0a72ee-ec30-8c97-0285-6c53db3d4477@tessares.net>
 <Y+m4KufriYKd39ot@Laptop-X1>
 <19a6a29d-85f3-b8d7-c9d9-3c97a625bd13@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a6a29d-85f3-b8d7-c9d9-3c97a625bd13@tessares.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 13, 2023 at 05:28:19PM +0100, Matthieu Baerts wrote:
> But again, I'm not totally against that, I'm just saying that if these
> tests are executed in dedicated netns, this modification is not needed
> when using a vanilla kernel ;-)
> 
> Except if I misunderstood and these tests are not executed in dedicated
> netns?

I tried on my test machine, it looks the test is executed in init netns.
I modified my patch by setting the net.mptcp.enabled to 1 without setting
it back. You can find the value is changed after testing.

# cat /proc/sys/net/mptcp/enabled
0
# ./test_progs -t mptcp
#127/1   mptcp/base:OK
#127     mptcp:OK
Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
# cat /proc/sys/net/mptcp/enabled
1

Thanks
Hangbin
