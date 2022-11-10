Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F69624DA5
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 23:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbiKJWdC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 17:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKJWdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 17:33:00 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFCF56554
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 14:32:58 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v17so5299180edc.8
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 14:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uCTQuxpuOU8V/BqYdUTMshlSn4YXWoFe1qL1uNyfzpE=;
        b=JY/BEmYFzjrw1m54NpZ/YNBRUvPj21kj+3z/2Oj8Kc+qzzR7lLP3IrVdOgf8Q57R8O
         y5YgknDhl0uWZ7bJhwu3zCQG3UDWGtFxPGCoeRO3slFNBRleUrMDhLMoGS1fFFJv7RCg
         MpQIyIe4kkx+kDjTZ3LQ8lNwTx4JL6EkUwE+EYflDqcuh4mweYFhGXqtaJ2zcBjYg2GM
         MvCQTZ4mXQ6PFfdQZugDwiqLMICf28rYNxunugrgxJDAk1yMp0Lz/XpRugUVLEoQnELt
         pCuIS2HzpLJC6I+feJKDoXhftGTnOLjJzpVSfsdwTtMiJ+yVDfC1NvqaIPv+Xji+wrPJ
         clJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCTQuxpuOU8V/BqYdUTMshlSn4YXWoFe1qL1uNyfzpE=;
        b=KVpURVfDTgxoSZkWjDv8uFiXXwFXkHql3Moat3+QqzDXX49i42D7G9N3aEj8Q9XWFx
         1lmiXTTR4VfbX77AoAmIrRT3DXxJUOtPT97e6zDQw7hW+VGNtyp28D+5JJa/zhedDv+T
         oy4SDUVUXNC+bABDsEmTi7ikOq23xKEDL4Rfs37txbiMFOudkZntYiSRS+E7DuMQ6bHK
         8ntjzM9WUv18YtV6oLN7+D+TcZLxcyF+SooA+S7FR/1E9rp6SUeFhbnF+ADy+MWknHHW
         vQORQdkYScpFJwCOtI/kIXASjBqkkIUP6q4H84bZJdyI2zDLeg3Yo228nPaA0A0lxuRB
         YjjQ==
X-Gm-Message-State: ACrzQf0Vb4cr/5gjY07l52RsV0/e10ZgbKawD8a53SvJZd6037iHbmF7
        jVJhP0Tw2jfzQivClajEZsLAgsKD196CL2GF
X-Google-Smtp-Source: AMsMyM6f7cDjC7+Um9bPa95eBsT6vIxL6d90bcXMSGALNQKCiserbCs8Mtr6Zu7estTipmq6GGji9g==
X-Received: by 2002:a50:c31c:0:b0:461:f5ce:63fe with SMTP id a28-20020a50c31c000000b00461f5ce63femr3629992edb.362.1668119576388;
        Thu, 10 Nov 2022 14:32:56 -0800 (PST)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b0073a20469f31sm211167ejh.41.2022.11.10.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:32:55 -0800 (PST)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, Eduard Zingerman <eddyz87@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] libbpf: hashmap.h update to fix build issues using LLVM14
Date:   Fri, 11 Nov 2022 00:32:40 +0200
Message-Id: <20221110223240.1350810-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A fix for the LLVM compilation error while building bpftool.
Replaces the expression:

  _Static_assert((p) == NULL || ...)

by expression:

  _Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) || ...)

When "p" is not a constant the former is not considered to be a
constant expression by LLVM 14.

The error was introduced in the following patch-set: [1].
The error was reported here: [2].

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

[1] https://lore.kernel.org/bpf/20221109142611.879983-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/all/202211110355.BcGcbZxP-lkp@intel.com/
---
 tools/lib/bpf/hashmap.h   | 3 ++-
 tools/perf/util/hashmap.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index 3fe647477bad..0a5bf1937a7c 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
 };
 
 #define hashmap_cast_ptr(p) ({								\
-	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
+	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
+				sizeof(*(p)) == sizeof(long),				\
 		       #p " pointee should be a long-sized integer or a pointer");	\
 	(long *)(p);									\
 })
diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
index 3fe647477bad..0a5bf1937a7c 100644
--- a/tools/perf/util/hashmap.h
+++ b/tools/perf/util/hashmap.h
@@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
 };
 
 #define hashmap_cast_ptr(p) ({								\
-	_Static_assert((p) == NULL || sizeof(*(p)) == sizeof(long),			\
+	_Static_assert((__builtin_constant_p((p)) ? (p) == NULL : 0) ||			\
+				sizeof(*(p)) == sizeof(long),				\
 		       #p " pointee should be a long-sized integer or a pointer");	\
 	(long *)(p);									\
 })
-- 
2.34.1

