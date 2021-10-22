Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8321437A43
	for <lists+bpf@lfdr.de>; Fri, 22 Oct 2021 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJVPtO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Oct 2021 11:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhJVPtN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Oct 2021 11:49:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CDDC061764;
        Fri, 22 Oct 2021 08:46:56 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id m20so5905455iol.4;
        Fri, 22 Oct 2021 08:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pclmJnOxUzu2p+gBluzlBxhVBxGQaG1PWO0p74EKR7Y=;
        b=DRA/dpxoC9CZZcIz1kMr73dYiXgS04XzQ0qkdhAKCtQHYJ0QOOknAjlLzdb82em2d7
         t436PPBt39VheeWFIoy0q7jksy1AL+WFe/CBgVFsYIZxhga7EQNQUxBXiLhM4iJ8OKIG
         o9i8VjF02UWORMmOGL68UFjzU6cwVBD4EyC1k8yPxKq+MrklaSlIgOvu2C1aZiaaAa/z
         tK0Dzuoswiwm1gN7RwsIRYVfAel7dO6zpIauZsFpO3agVk2CfbOChEmPNhaEfLn6DbmV
         hLrtFL7jH/nf8RYUlD/r6ZnLnUIcsrvZ0EQFzRJOynJZSsrcPzgZTM9SkKCnp2EdXzKa
         gCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pclmJnOxUzu2p+gBluzlBxhVBxGQaG1PWO0p74EKR7Y=;
        b=gbwdnIEnMFRkZ0m/Hq5zldc1IHBBppUlkPAgA1mCJt0uda+HxOjcOJ+E2jNYf8IDyt
         3H48pTz8AHAowjm+7LP8OfpW4oLt7PzNfkxdZhnXsEDbdfCGlga47evswaIJoN9gxjVE
         njdc4zt9QOCnJsHlgw1UC6uJPRwoYfZn/2CuQJ+jXW1zrOxOLZbO0IOAywGge4WVi2b+
         9GeIhiZZR/LwRFU9UnSFMrklKng8L+5z1tfMUczNSfx16Cs8cUF/1fNMDxrJ3uDZSIAv
         up479xci9VEIJ4iXoke9jMn1I4zQrIdCVTx9dtGj/30bKglg27y9dAc/ss8IUjYSXSj0
         Qd0w==
X-Gm-Message-State: AOAM5339X7sMS2Z8Ihc3gZ8XPgxIrmuf0OWYt1iBvoqwMM8KEVW3oHgL
        HFNK1OLyOQqD2VCAaieLMVZn3lMQkSoLS0Vx
X-Google-Smtp-Source: ABdhPJzDCD7YbM/jLCvnfsDzB0/WsAqQpUUpQh9viwUNEpwSo568Vt0rmhUY0rnuNClo8/KyvLGHxw==
X-Received: by 2002:a02:c901:: with SMTP id t1mr438586jao.132.1634917615795;
        Fri, 22 Oct 2021 08:46:55 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id w15sm4489324ill.23.2021.10.22.08.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:46:55 -0700 (PDT)
Date:   Fri, 22 Oct 2021 08:46:47 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Di Zhu <zhudi2@huawei.com>, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jakub@cloudflare.com
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhudi2@huawei.com
Message-ID: <6172dce78e957_82a7f2082@john-XPS-13-9370.notmuch>
In-Reply-To: <20211022103348.284562-1-zhudi2@huawei.com>
References: <20211022103348.284562-1-zhudi2@huawei.com>
Subject: RE: [PATCH] bpf: support BPF_PROG_QUERY for progs attached to sockmap
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Di Zhu wrote:
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
> 
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> ---

LGTM, lets add a small test here as well

  ./tools/testing/selftests/bpf/prog_tests/sockmap_basic.c

Looks like we can just copy the sk_lookup.c test case which does
the query tests for BPF_SK_LOOKUP.

Also I don't think its required for this series, but a bpftool
patch to query it would be useful as well if its doesn't just
work with above.

Thanks!
John
