Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9E54AF781
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 18:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbiBIRDr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 12:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiBIRDp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 12:03:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4EFC0613C9
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 09:03:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q11-20020a252a0b000000b0061e240c8fb3so2273815ybq.22
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kN7NXL+BiQJuosnfsfnDxVGLuX5Wa2jq4GtcAaW8rr8=;
        b=p5Bw5ek+ks3C6qQyclKiW+JyCjOvEqW0AUPy2csFj+CxuLJNcjmOkBePD0WL70hsti
         GLW+S3g+Z5eB8sQeMfig7osIyFiAS07iIpBfGrg5QkvvlGR7hL9/8m/Wcpyd/J82Savy
         LM39adTXji/aNF6Oofl9o3s2NoV15zeiaNvndxdrQVGpGMKGID7Kop9ppxCtIqy+wQHu
         xjDiMATz9LqLJdwPDzhbJRTGc2rik/YrDQMXZYkJjdC54S504ABZ3UAk+niqT0LX8JK2
         LBIFEvKOHe1oxxwLJgPwEPWKqgLiRExZIzhszSTt+jyG+NAS8fYh6g2lP0yn1RRJob7/
         K8ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kN7NXL+BiQJuosnfsfnDxVGLuX5Wa2jq4GtcAaW8rr8=;
        b=H4m+EqlpHEqjHKfBAwmDRr+jQrDUwXPYKlqNqjX1ljysAJIVrpZC7Joyz7Su8UnGcE
         DKZBca7a9oeJboxvTPmKUbGLPWPuCcPSV+FxWpmmrkhvCqqWBI8rR9Rk23kvKvn+g5XD
         xz16BJEH9+kUlxqSqnyBLAiNUSeO2b80SfOC+fMlcKMs0yWUQfwEEow0udkGs95hGZaB
         E8dPtGN22mOBeAAIK6MFCINYUOnB6TNnh3AXSkbxq+1A30gq2kBltuIFvAC42R8gakPj
         zWVnTsTB6pu2UMJPj0e/Q80N3JzZhJzJyTLXyx1dlmn907Sbr9oGJzimpnhT2dJZnbCS
         p76Q==
X-Gm-Message-State: AOAM533TlzlsKaN1lM+5iT88dIoRBLIKb5muB3U44jcMOHDU5OOXMTKT
        JEWP+JSOduGmulup/yDDme0dk6U=
X-Google-Smtp-Source: ABdhPJw3IwTJsHp8E1qWoQ3jmRqzKEF8NuxuCxjMDv8n534dhwxqvR6Yw+tps3xKhpxyiG3KKG1A+fo=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:4d3:1afe:7eeb:c0e6])
 (user=sdf job=sendgmr) by 2002:a25:2155:: with SMTP id h82mr2921759ybh.606.1644426228134;
 Wed, 09 Feb 2022 09:03:48 -0800 (PST)
Date:   Wed, 9 Feb 2022 09:03:45 -0800
Message-Id: <YgPz8akQ4+qBz7nf@google.com>
Mime-Version: 1.0
Subject: Override default socket policy per cgroup
From:   sdf@google.com
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Let's say I want to set some default sk_priority for all sockets in a
specific cgroup. I can do it right now using cgroup/sock_create, but it
applies only to AF_INET{,6} sockets. I'd like to do the same for raw
(AF_PACKET) sockets and cgroup/sock_create doesn't trigger for them :-(

(1) My naive approach would be to add another cgroup/sock_post_create
which runs late from __sock_create and triggers on everything.

(2) Another approach might be to move BPF_CGROUP_RUN_PROG_INET_SOCK and
make it work with AF_PACKET. This might be not 100% backwards compatible
but I'd assume that most users should look at the socket family before
doing anything. (in this case it feels like we can extend
sock_bind/release for af_packets as well, just for accounting purposes,
without any way to override the target ifindex).

(3) I've also tried to play with fentry/security_socket_post_create, but
it doesn't look like I can change kernel data from the tracing context.
fentry is also global and I'd like to get to cgroup-local-storage.

(I don't want to get involved in per-packet processing here, so I'm
looking at something I can do once at socket creation).

Any suggestions? Anything I'm missing? I'm leaning towards (2), maybe we
can extend existing socket create/bind/release for af_packet? Having
another set (1) doesn't make sense.
