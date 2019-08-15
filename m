Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFF848EE19
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732831AbfHOOWh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 10:22:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54345 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730497AbfHOOWh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 10:22:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id p74so1429013wme.4
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=dzEHN37VGWbW9oZl14TcD0zcx2/h8u/uYbosL+lvXCs=;
        b=zM8e7vTlI4W3svXevDk5e8ahEGLQWfag5Bbxs7zNoZ31wyE9PQGCpaFO7Y0MNEkmoC
         /GxVUrDtp16CKuc9F9dZwR9GapbKnIxxQLWiYUyAoKMWTeUs12DTY4zlhsTTcNI0w71H
         0cgifMlE8+LuSRrg50sr/n5OIx8P/YH20/3RD5q/Ium3lowM6Dy/9c+gJ+/dAW8uE5Yf
         l3DmLiptIzyiK9jyFTUBQWQraQGgTl2R2TpQFHk7A+xHe+qKGfQHfCBVBzV2TWtIVi2k
         DvlvN+HxWbzvCAL7eiJ+6IOeuSAGYjPqXHI5ap++62hDGx7CmE6HWziou0ghY2ANzFAE
         dWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dzEHN37VGWbW9oZl14TcD0zcx2/h8u/uYbosL+lvXCs=;
        b=X5WWnsGqOr8ApAYw6WDGdsl59I7ny27HAQgVDeunn7GbivO0Ou06REkL6dr2yRXr/n
         LGs8aWDwFF6UsQdFAaUboDb7FDzro14UeHPbEfiiHTHJwC45W+mUVBbu8N7mSPweXX7v
         rsFEUZRfJNOy6GU7McDVrlQ7t5EtHE/V1/xklaQdoA+2MhuNc49tzBhpuXGEpFl49Xoz
         6M1+uIH2cU+0b2QTCZraqxmjaZF9A2YCdnnVNsbaPVLmanjrJakvPWSBZGocyA1U4YFJ
         87lMTeDnj595uMt0sdroEucVKnXXT4WvcWkB67bOA9g65r4iFkwTQyEqF8iPksIGnVz+
         oxdw==
X-Gm-Message-State: APjAAAW2rbT4a/dLz6+EWisxRVsGEVzlLuG39ETeUWFL2WuF2k4WtWFd
        jGPPCwNue3GyereMyDGDvgOxhQ==
X-Google-Smtp-Source: APXvYqyB+L626GR0kHtVUSQzAVhqYH+zINNeFEGnziQG4awK6UZJQVOHdx7GObWtglIkhnOn7VKAOg==
X-Received: by 2002:a1c:13:: with SMTP id 19mr2979003wma.162.1565878955575;
        Thu, 15 Aug 2019 07:22:35 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id t198sm2860790wmt.39.2019.08.15.07.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:22:34 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf] tools: bpftool: close prog FD before exit on showing a single program
Date:   Thu, 15 Aug 2019 15:22:23 +0100
Message-Id: <20190815142223.2203-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When showing metadata about a single program by invoking
"bpftool prog show PROG", the file descriptor referring to the program
is not closed before returning from the function. Let's close it.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/prog.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 66f04a4846a5..43fdbbfe41bb 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -363,7 +363,9 @@ static int do_show(int argc, char **argv)
 		if (fd < 0)
 			return -1;
 
-		return show_prog(fd);
+		err = show_prog(fd);
+		close(fd);
+		return err;
 	}
 
 	if (argc)
-- 
2.17.1

