Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B41E4D52A3
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 20:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbiCJTyU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 14:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiCJTyT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 14:54:19 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F143658D
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 11:53:17 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id o22so5564181qta.8
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 11:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=xbshQI3OnHEaExBYfzc6oDj96n5ioT+PjfkVBhW4ofY=;
        b=S2JRXuCrzZD2mZF5Uj3h5yZYkO/dnPe4su1kxkssGrTte+BtHDghJVo/Tp68BXPZcv
         pYrxIk3hfzs647m5/zc52372jMAEv9oXYAi4kBer8i3oEAyBBUCDdbEXxKNBJHy3tEPe
         1tLA0wjL09TyZSwODNxBGp1j6sW8AZaS43DRpzSk6E4wD+qgB7RH7XQSkIT0t3eo0bXt
         c6JxjMfuh7RzSJL1WR82a8A32kd8jP7Fxeawwns+0ealATXpFFbGnL7IfgI2mPUsl54f
         j+1tv5eSbtibKwiiFWEv2BD2Ryf0RBpehNNTwgt3oXsm78mVBmE2ZAiDHfPtzVf5B5Pt
         IpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xbshQI3OnHEaExBYfzc6oDj96n5ioT+PjfkVBhW4ofY=;
        b=Er/5dQwaIEZ37A+zhbHH4IqxOdWY+tP7Tx2EURu/L9tjVEjVKAfsj03RIDANMBggGm
         IgZkevcd9hkyHQzMQtgco3dtwHzYVylvlDNwkdAPuY6idP410M1FyV1D/RXBXpWknfG1
         0B/gG8q6V2ioO3PHCA0psA+vJ/0+Y7yHlN63wGXTSb6DToWVdFtwzC/KTRU78JVMv5Oi
         rDf72QvD3Dzu9w6r0sXpwjVR/6FW0TgA/84512XCLCNwMGyhF/CxOGWBall4ArXtIvYa
         oe9Sq8Ft2fiaGYn+lcNMpOI7n7oP40wkC3hcv321tBPkkdfnMYJM9YK4KqYRfB0NfSul
         2BtA==
X-Gm-Message-State: AOAM530+8QJca1D8nGie7wJIDMQo/vZgIxnsHt79sZEWxh1MM4tXmG60
        TPNDNOuw721U6wZ/KzKMZQoSAaOnLs4Y3HWlLEMwGwgTjdTsVw==
X-Google-Smtp-Source: ABdhPJxp2ODlh9Z/cmR8UtspjlMqI1TVuP/x5lJCDavbnwcQ0vqjtY1hgR8cCInyJ6mSQ8n57cq+/2MoqLUwUt34V7I=
X-Received: by 2002:a05:622a:4d1:b0:2de:676:d2bd with SMTP id
 q17-20020a05622a04d100b002de0676d2bdmr5444230qtx.565.1646941996266; Thu, 10
 Mar 2022 11:53:16 -0800 (PST)
MIME-Version: 1.0
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 10 Mar 2022 11:53:04 -0800
Message-ID: <CA+khW7hbujgsk+UL026JhPiGt-=LG4rJXm0ECFAtvTcM=uiqgQ@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] BPF based cgroup stats
To:     lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cgroup is a key technology in container-based computing. It achieves
resource control. In recent years, we have seen BPF being used
extensively in many use cases. But in areas like security auditing [1]
and performance monitoring, BPF can still be improved to provide
better cgroup granularity stats. In this LSF/MM/BPF, I would like to
drive a discussion on potential new features in BPF for better
observability:

1. Interface to export per-cgroup stats. There are two considerations.

 a. BPF iter is a great way to export kernel state. Iter objects
pinned in bpffs allow users to read stats as files.
Cgroup-parameterized iter [2] would be a great addition that generates
one stats file for each cgroup. This creates a better organized
interface for cgroup stats.

 b. Containerized applications may also create their cgroups. They may
also want to read the stats of their cgroups. This requirement needs
us to make BPF based cgroup stats visible to the processes inside the
container. But BPF based stats are exposed through bpffs, unlike the
cgroup native stats which are exported through cgroup file system.
Mounting the whole bpffs inside the container isn't a good idea as it
exposes other task's stats to the container. It would be great to have
the ability to mount only a bpffs directory into a container.

2. Stats collection for cgroups.

  a. Cgroups are hierarchical. For most of the time, the users want
stats not of a single cgroup, but the aggregated stats of a cgroup
tree. For example, in k8s, a Pod contains one or more containers.
There is a cgroup for the Pod and a child cgroup for each container in
the pod. When we read the stats for the Pod, we would want the stats
to be aggregated stats of the child cgroups. Therefore aggregation is
a natural requirement for cgroup stats collection. The proposal of
rstat map [3] utilizes the rstat framework in the kernel for this
purpose.

Above are some topics in my mind, I am looking forward to any feedback.

Thanks,
Hao

[1] Secure Namespaced Kernel Audit for Containers
https://tfjmp.org/publications/2021-socc.pdf
[2] Extend cgroup interface with bpf https://lwn.net/Articles/886292/
[3] Hierarchical Cgroup Stats Collection Using BPF
https://www.spinics.net/lists/linux-mm/msg288283.html
