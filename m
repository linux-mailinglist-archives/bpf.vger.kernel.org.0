Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450C8649073
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiLJTgq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLJTgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:43 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1985A1740B
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so2131412wma.1
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LfFvmK+WGuHfkEmmrOFW05XEXlYY/ztLknoWjjqbc4=;
        b=UxNL5Qh+SZIJblsz0G+FXNDfghFDuNbmOK9BPcNAaDEWfuVGwDy2cm6iwRPAGFrVRT
         U7iXYz+u/muTkoWufii7FLGtA14rUiP1Tx+l58aucGE+F2KKcS8R6f6/sPE5PIqJwwUK
         pcBM736o0HUjGOWi+Dl5VGGelNhv4qFvZJhrUVxq8WFAe2KYInqri3dfUOYPu/72q89s
         QmkoULLBNMMzbtrHu41GNup8UbxNhgSrLAy4qGpZJ1vj5xF5ZNW9suV75HhrSRM+2L9b
         rMr1wKGtNlj7/UDllCx/W7hIwyr9oxoP+v/s4kGJzlYgbf7c7zM3rkmr7eQUffQmlM2c
         TFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LfFvmK+WGuHfkEmmrOFW05XEXlYY/ztLknoWjjqbc4=;
        b=x5qmCbUhsD0CmuZKqQV8YIFpAoaG281XKaTnl7O26vf9Ijx43FdsHUsJyR52RgZb4H
         we+5mud9pUo0Lnz5l16Ss3tgx5wk0eqNTXB28uesPhTOXyGLR2rLdE75egA4teBDvU/v
         VtcnHHwMc4Kmxp3joHeDLpcwzkT+PunWd4HBZ3d2pwYxxh0L6uyQ03AADBOzTAbkWdXV
         Q3NSqLEeBleLnoMrSI4OvMfqiYD6DS2+EZLKladNNXxbIQzoNMA2ef+trSSxMdb8bTdH
         d2deaUGwbj1chARhoscKAFXyau6l0lGi+syRDaI4p2TWZm+e154eqpXMKkkrr5nqPd5N
         TKRw==
X-Gm-Message-State: ANoB5plTmQ+AfBUUJBldogSgyGcviA2oFaM7XSQEAXpHbJEeD0a62vRS
        UCGEIrnB1n1Dw5snuHklkCj1E87epm6tmg==
X-Google-Smtp-Source: AA0mqf4y+uHaSz3j9LjgNU+rgU/wNvqcxE/vsuTUoSHBlSHKtgzDrjaiCw4Yvhag4RuuEtaF6DQ6Pg==
X-Received: by 2002:a05:600c:3b8e:b0:3cf:d428:21d6 with SMTP id n14-20020a05600c3b8e00b003cfd42821d6mr8827019wms.3.1670701000282;
        Sat, 10 Dec 2022 11:36:40 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:39 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 9/9] documentation/bpf: Document cgroup unix socket address hooks
Date:   Sat, 10 Dec 2022 20:35:59 +0100
Message-Id: <20221210193559.371515-10-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 Documentation/bpf/libbpf/program_types.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/bpf/libbpf/program_types.rst
index ad4d4d5eecb0..06168ad73d5e 100644
--- a/Documentation/bpf/libbpf/program_types.rst
+++ b/Documentation/bpf/libbpf/program_types.rst
@@ -56,6 +56,18 @@ described in more detail in the footnotes.
 |                                           | ``BPF_CGROUP_UDP6_RECVMSG``            | ``cgroup/recvmsg6``              |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
 |                                           | ``BPF_CGROUP_UDP6_SENDMSG``            | ``cgroup/sendmsg6``              |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_BIND``               | ``cgroup/bindun``                |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_CONNECT``            | ``cgroup/connectun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_SENDMSG``            | ``cgroup/sendmsgun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_RECVMSG``            | ``cgroup/recvmsgun``             |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETPEERNAME``        | ``cgroup/getpeernameun``         |           |
+|                                           +----------------------------------------+----------------------------------+-----------+
+|                                           | ``BPF_CGROUP_UNIX_GETSOCKNAME``        | ``cgroup/getsocknameun``         |           |
 +-------------------------------------------+----------------------------------------+----------------------------------+-----------+
 | ``BPF_PROG_TYPE_CGROUP_SOCK``             | ``BPF_CGROUP_INET4_POST_BIND``         | ``cgroup/post_bind4``            |           |
 +                                           +----------------------------------------+----------------------------------+-----------+
-- 
2.38.1

