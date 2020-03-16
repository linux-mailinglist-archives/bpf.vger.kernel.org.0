Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0018702D
	for <lists+bpf@lfdr.de>; Mon, 16 Mar 2020 17:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbgCPQh3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Mar 2020 12:37:29 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44510 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgCPQh3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Mar 2020 12:37:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id d62so18413158oia.11;
        Mon, 16 Mar 2020 09:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+hUQzi8rSGcD861hLFiFZxEV8fS8e2CK6IX3o7vpd0=;
        b=oau0fH9kC3YB34GLThPRDlnyCEnY6HDOha1KcXiOv3qrdIVzUHzJRk9k1OOR6Ka6yL
         j88oQRJF2i5wYbwRGZcnenshtLZH1ISiJwrl70x5A76vF9F3vopXkZUtH5eXKc3vo6W7
         EnwaCSCPwicuLe+Vi/SX+LWJsVhIM5upRWWrlLDHo4wE0/9HzT5RwKGgK+WSCgA0palu
         xjZzmcpf9tnyRBOc8dznz+tkLsIa9aehGS09LOYRKexCGokM+a6/uYxTMQtWWE9usIsY
         bYdoTkyHqHG994k1w1/Ni+/MjJyK9pl2TlfLMGWFXGHp+5IxIog7kRNv39WxEqavY58V
         AuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3+hUQzi8rSGcD861hLFiFZxEV8fS8e2CK6IX3o7vpd0=;
        b=DTJ+9R7/qVT/NsMMg/3oEW2g92unksIZSVuLpZdUVaat+yKiRGz12hq1Wj6SH8AN+R
         A2RzpJWu/yPcBNxrViBO3A9wZxrx68lp4Q7zwvxH2h9/d6QQkRAMzWu2ZoDeVtqfQtmu
         FKGAxV+piqi33Yb1UQWaQ07DCQNeXZifO7rutoIOxuXkWfF38xRH6rhWMiguqwLgyLcX
         62FEGkiRO0eEugcvTFDwAAck9HlolOrAtkBcAJZaPSayw+cHPN2ON2VSXhH/YkqTuUQ4
         3JMcrSk7y6LgphVD1f82KYS5z+QgDy9uq9N2nTR71TihfjlZKMQpZTFOOzzbS0HNTP3c
         uBng==
X-Gm-Message-State: ANhLgQ1Ww8xVnZkKQxrDpu1itPSXJie5XNcP3WXqqS6127/b4ewV+JfF
        T7tOYkADzjUHOjXddss1/vg=
X-Google-Smtp-Source: ADFU+vtFGB4+FIEYm6YYVa7xkL80tUjCTX2OzlmzKkjvbd4GxJ+Ve1IzVjgR7/PoVO7kUAS6E7uKZw==
X-Received: by 2002:aca:1913:: with SMTP id l19mr269031oii.47.1584376648382;
        Mon, 16 Mar 2020 09:37:28 -0700 (PDT)
Received: from localhost.members.linode.com ([2600:3c00::f03c:91ff:fe99:7fe5])
        by smtp.gmail.com with ESMTPSA id l20sm115101oih.40.2020.03.16.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:37:27 -0700 (PDT)
From:   Anton Protopopov <a.s.protopopov@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Anton Protopopov <a.s.protopopov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Subject: [PATCH] seccomp: allow BPF_MOD ALU instructions
Date:   Mon, 16 Mar 2020 16:36:46 +0000
Message-Id: <20200316163646.2465-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The BPF_MOD ALU instructions could be utilized by seccomp classic BPF filters,
but were missing from the explicit list of allowed calls since its introduction
in the original e2cfabdfd075 ("seccomp: add system call filtering using BPF")
commit.  Add support for these instructions by adding them to the allowed list
in the seccomp_check_filter function.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/seccomp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index b6ea3dcb57bf..cae7561b44d4 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -206,6 +206,8 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 		case BPF_ALU | BPF_MUL | BPF_X:
 		case BPF_ALU | BPF_DIV | BPF_K:
 		case BPF_ALU | BPF_DIV | BPF_X:
+		case BPF_ALU | BPF_MOD | BPF_K:
+		case BPF_ALU | BPF_MOD | BPF_X:
 		case BPF_ALU | BPF_AND | BPF_K:
 		case BPF_ALU | BPF_AND | BPF_X:
 		case BPF_ALU | BPF_OR | BPF_K:
-- 
2.19.1
