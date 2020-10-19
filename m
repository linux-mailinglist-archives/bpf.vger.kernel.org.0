Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D686A292CFB
	for <lists+bpf@lfdr.de>; Mon, 19 Oct 2020 19:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgJSRiz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Oct 2020 13:38:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727738AbgJSRiz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 19 Oct 2020 13:38:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603129134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=bCZfT5E3im0lNOm7GQVPs0SnshcVMlnSl2CIjv8kRzg=;
        b=XuRj984d4Ni4B4gOQIkJ1fjsDSTQTYC2CJgK7nE/Un8TdX0LAjj5t978iVp5KFJ6zH3o5U
        7eEw6N4LFfH6Wus6D6KcDbvrbYSBBGdKcbWc2WE3y+LCg73w1VkTCow7xDD9gFc3LGfahu
        YOHit4SMBZWQAug5yd3C2gzk0HwQ/vI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-NPez2pLgNmyMiWU1LU2Ecw-1; Mon, 19 Oct 2020 13:38:53 -0400
X-MC-Unique: NPez2pLgNmyMiWU1LU2Ecw-1
Received: by mail-qt1-f200.google.com with SMTP id r4so429112qta.9
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2020 10:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bCZfT5E3im0lNOm7GQVPs0SnshcVMlnSl2CIjv8kRzg=;
        b=QxIpebXTQBCTT2pJlBh1xhzun/0SXtrCF379yRzyjGgT8ZgqecbIJEIeiXymlLj0WI
         Y3OLxEfG0MeWDIDBAob9IaB78CdrBXCgv9TzZCuRi6M9zwDydMlm6shikODR15rS9HhJ
         Te9FGjhFfCWYK+a+jMUUusSaoNzMoIRC2oXbk0YOCv9BuULCw0/C9aa3l0/5ftNW3TFw
         xJtajzaqrsp84z/JXLVQl49C70mzfBTfu3nwZIrYqEwrJ/qqTf2MDzMqmVCoe40xTx6s
         UPAzZvBPWDR2Qz9dvi4ZNMNYwmKz+Rves7C3UlFj44uS+kPvuXPuz/EOWN0Y9ggBiMrr
         72ug==
X-Gm-Message-State: AOAM530Ddcac+Y1KCcnqdBWVwZDhnoZCViTwuk9TG2aQg/49w+KxZH9M
        xoG2o/6eQ5TKa9A5GUJpRLiDWFZxAD+Ce5D5KWJyrA5pyrpdEKHqX/aeGD8Dk5ZTE8CdieN56xR
        YUY8SL3ixKReU
X-Received: by 2002:ac8:937:: with SMTP id t52mr569988qth.268.1603129132248;
        Mon, 19 Oct 2020 10:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKieAoqgQ8WMfOwsu+ME8feLE9yc+3oESLds+QyAt+bmkqHnhzOFlfz8uddoFFD0ZWch2otg==
X-Received: by 2002:ac8:937:: with SMTP id t52mr569971qth.268.1603129132059;
        Mon, 19 Oct 2020 10:38:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a200sm296706qkb.66.2020.10.19.10.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:38:51 -0700 (PDT)
From:   trix@redhat.com
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andrii@kernel.org,
        john.fastabend@gmail.com, kpsingh@chromium.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] bpf: remove unneeded break
Date:   Mon, 19 Oct 2020 10:38:46 -0700
Message-Id: <20201019173846.1021-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 1110ecd7d1f3..8f50c9c19f1b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2913,7 +2913,6 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_CGROUP_INET_INGRESS:
 	case BPF_CGROUP_INET_EGRESS:
 		return BPF_PROG_TYPE_CGROUP_SKB;
-		break;
 	case BPF_CGROUP_INET_SOCK_CREATE:
 	case BPF_CGROUP_INET_SOCK_RELEASE:
 	case BPF_CGROUP_INET4_POST_BIND:
-- 
2.18.1

