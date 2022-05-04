Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015BC51A51C
	for <lists+bpf@lfdr.de>; Wed,  4 May 2022 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353170AbiEDQSe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 May 2022 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350816AbiEDQSe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 May 2022 12:18:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152E12AC5F
        for <bpf@vger.kernel.org>; Wed,  4 May 2022 09:14:58 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b20so1281909qkc.6
        for <bpf@vger.kernel.org>; Wed, 04 May 2022 09:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25gauivTso+aPDMUMdYArAx6UKOEKikakpvozYIXV04=;
        b=aJJHRw1hrM+eJoAEQHKr+3xCNLpAHdUG6nAl8WdDBwP5qaPNhOkhyCGPzGJCfIn33d
         zKZAJYIXqJ/qqrS9DeFl0frOfu/CvrpCm0Q8620pqKw6fSCRsdgWw6GIjFcp5I3sH2bv
         VqR+CrVQBxBM1vWr4chDe2J2XgBLvFZDUt/lSD/TAjyUyokDfx1IQ5cvlicgdJOsIrNf
         iLk+IXHTbfFO0745eWHzGr/MKzLfZ0fGuHUnAYBqJ/80vBMvn5SzkdaVstLfnhSbHI2t
         cEnwTl1ZYiE+2SDeDcbcPClmIkNLEIl/Sbk8ZDcy4U1QK5YPertXolXtvbOZw2Y2/xhX
         JceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25gauivTso+aPDMUMdYArAx6UKOEKikakpvozYIXV04=;
        b=LXURjjBH2x1vp5WNVFclW39UmHbLJlH0PGGnvshKN2Og+ymSusuOmD2O/PniF86Eys
         ZfTjRp1AUvQ9acIjJ027K9UIOaRE4cW8cflFNhvwa9RJ73R/GNYJeLZSS83CPVjVJlbG
         aPY5fspNHFnJjexPst/qopLKtR5oNe1orqPzsCIKlnqX5WJgBdLXcsatlffxUp+gNADm
         d/fRlNY/6p9PdxvAhfiWTcOgc7PpBrZACUOfm5L9hc8XuKjza1ORDpZzS4h9eGLpxx4E
         ZDN1MrGffekZfq+v6ftg95pmHg7Hqj5zhmRv8tnPspSiOAWlGIo0tfV2HuO8RCvOfP5n
         mHrA==
X-Gm-Message-State: AOAM532RvhdFAS0AsDiHX/5ibIohkHYHIJw3vZKzmJsSU64HNb9zFdGf
        PQIpNqhs2gVdfsRCKdUL6nR1qQ==
X-Google-Smtp-Source: ABdhPJx0dx8kcVi/eEjgGDxAh5m/w84UJmNT0c86lwP/MjJLFqD6oWOX0PmxZa+8Kho55+03vEsAEA==
X-Received: by 2002:a05:620a:2a14:b0:69f:fc99:48de with SMTP id o20-20020a05620a2a1400b0069ffc9948demr7666553qkp.604.1651680897202;
        Wed, 04 May 2022 09:14:57 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:4611:5fd6:ef88:7605])
        by smtp.gmail.com with ESMTPSA id 18-20020ac85652000000b002f39b99f66dsm7594467qtt.7.2022.05.04.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 09:14:56 -0700 (PDT)
From:   Milan Landaverde <milan@mdaverde.com>
Cc:     milan@mdaverde.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Paul Chaignon <paul@isovalent.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpftool: adjust for error codes from libbpf probes
Date:   Wed,  4 May 2022 12:13:31 -0400
Message-Id: <20220504161356.3497972-2-milan@mdaverde.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504161356.3497972-1-milan@mdaverde.com>
References: <20220504161356.3497972-1-milan@mdaverde.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Originally [1], libbpf's (now deprecated) probe functions returned a bool
to acknowledge support but the new APIs return an int with a possible
negative error code to reflect probe failure. This change decides for
bpftool to declare maps and helpers are not available on probe failures.

[1]: https://lore.kernel.org/bpf/20220202225916.3313522-3-andrii@kernel.org/

Signed-off-by: Milan Landaverde <milan@mdaverde.com>
---
 tools/bpf/bpftool/feature.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index be130e35462f..c532c8855c24 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -638,7 +638,7 @@ probe_map_type(enum bpf_map_type map_type, const char *define_prefix,
 
 		res = probe_map_type_ifindex(map_type, ifindex);
 	} else {
-		res = libbpf_probe_bpf_map_type(map_type, NULL);
+		res = libbpf_probe_bpf_map_type(map_type, NULL) > 0;
 	}
 
 	/* Probe result depends on the success of map creation, no additional
@@ -701,7 +701,7 @@ probe_helper_for_progtype(enum bpf_prog_type prog_type, bool supported_type,
 		if (ifindex)
 			res = probe_helper_ifindex(id, prog_type, ifindex);
 		else
-			res = libbpf_probe_bpf_helper(prog_type, id, NULL);
+			res = libbpf_probe_bpf_helper(prog_type, id, NULL) > 0;
 #ifdef USE_LIBCAP
 		/* Probe may succeed even if program load fails, for
 		 * unprivileged users check that we did not fail because of
-- 
2.32.0

