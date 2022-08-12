Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEAB59132C
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238259AbiHLPiD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237169AbiHLPhe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 11:37:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EC15C367
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 08:37:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h204-20020a1c21d5000000b003a5b467c3abso3949814wmh.5
        for <bpf@vger.kernel.org>; Fri, 12 Aug 2022 08:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ClByEH4YFyVpQvvrvqRiPscXscXpgcKSDvdXo3cUegE=;
        b=WGvphiRpGRa24GOgjyYq8WjLKgkumzYugfOMUtgLnRTpRgypD9i/lBRmHzv7AvDUDa
         +56YXlaYyBj77whX0bbrsR2QpAl5djfh0s7nVZw1CJG58aCHpgX5bU3FkcRf4WOkDCmL
         frhcGA72oZOS/LBXQg5YNow7XZq7CZ39InJr6kYMDxUsTnNH7T7CzY2wBCPk3ihpSZ2d
         B7l0Uj+zgsQbh5+Ft9HwcLlFu+uVMNknMEhOFFIdpayH+cl4D5X4N6DOFwvpkFD77IDH
         RtuXDBMkPUabegZnSNupZ0zU0TRQlXRG+sfrxjEF2fV6gh+ga+Ysm3ZvmFDfL+7hy+Sr
         JoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ClByEH4YFyVpQvvrvqRiPscXscXpgcKSDvdXo3cUegE=;
        b=tfbnjPYL70GxCVxjWudhON5v9DW4ZQDwjDbR179fEuuAyzZpQBrXXfHLMzFoEkXR/y
         NgD7IwH/47w1YTnBtoSA39k28hFQZvhkmUX2iow83zJkZrEIWFS8jU9zWQKq88+pqkgW
         CNYar2UwOUUsxVP/muzVgo3j6nlFS3mdJJUcIpinXAi4sWDWLRLjxAtbgK+kgsc+L6zl
         pNuOduQGLDUdmolB21a3554bYY2TdZh6tXIYZreLQ77AchhyF3kiwQZDawJthsAKeNOV
         uv2nJmYWD7OT+pxL9VwpxdgLXj3BOVN37Yz5flZSYQXozG1D+aXPRp30vXLiy4R44X8Z
         5tTQ==
X-Gm-Message-State: ACgBeo2NY4qvhjxX77zK0dE53fhVCk12S6PL2+g7q+62cAKBhdu4BmQn
        lSZQOOo/Z8zdzCf+OOHpnIjB2MCyyKkC4QuE
X-Google-Smtp-Source: AA6agR7r5xMZBqFPzOILPy6vnJixQM3DcimtFNjgolFVyohQLckDe7efqh1TRFcucDfFdhfOpprscg==
X-Received: by 2002:a05:600c:3b18:b0:3a5:2490:cb2d with SMTP id m24-20020a05600c3b1800b003a52490cb2dmr3045392wms.183.1660318652302;
        Fri, 12 Aug 2022 08:37:32 -0700 (PDT)
Received: from harfang.fritz.box ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id l25-20020a1ced19000000b003a502c23f2asm9410138wmh.16.2022.08.12.08.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 08:37:31 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, Quentin Monnet <quentin@isovalent.com>,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Subject: [PATCH bpf-next] bpf: Clear up confusion in bpf_skb_adjust_room()'s documentation
Date:   Fri, 12 Aug 2022 16:37:27 +0100
Message-Id: <20220812153727.224500-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding or removing room space _below_ layers 2 or 3, as the description
mentions, is ambiguous. This was written with a mental image of the
packet with layer 2 at the top, layer 3 under it, and so on. But it has
led users to believe that it was on lower layers (before the beginning
of the L2 and L3 headers respectively).

Let's make it more explicit, and specify between which layers the room
space is adjusted.

Reported-by: Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 include/uapi/linux/bpf.h       | 6 ++++--
 tools/include/uapi/linux/bpf.h | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7d1e2794d83e..934a2a8beb87 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -2573,10 +2573,12 @@ union bpf_attr {
  *		There are two supported modes at this time:
  *
  *		* **BPF_ADJ_ROOM_MAC**: Adjust room at the mac layer
- *		  (room space is added or removed below the layer 2 header).
+ * 		  (room space is added or removed between the layer 2 and
+ * 		  layer 3 headers).
  *
  * 		* **BPF_ADJ_ROOM_NET**: Adjust room at the network layer
- * 		  (room space is added or removed below the layer 3 header).
+ * 		  (room space is added or removed between the layer 3 and
+ * 		  layer 4 headers).
  *
  *		The following flags are supported at this time:
  *
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index e174ad28aeb7..1d6085e15fc8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -2573,10 +2573,12 @@ union bpf_attr {
  *		There are two supported modes at this time:
  *
  *		* **BPF_ADJ_ROOM_MAC**: Adjust room at the mac layer
- *		  (room space is added or removed below the layer 2 header).
+ * 		  (room space is added or removed between the layer 2 and
+ * 		  layer 3 headers).
  *
  * 		* **BPF_ADJ_ROOM_NET**: Adjust room at the network layer
- * 		  (room space is added or removed below the layer 3 header).
+ * 		  (room space is added or removed between the layer 3 and
+ * 		  layer 4 headers).
  *
  *		The following flags are supported at this time:
  *
-- 
2.25.1

