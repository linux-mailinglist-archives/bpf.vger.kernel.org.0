Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A87424D262
	for <lists+bpf@lfdr.de>; Fri, 21 Aug 2020 12:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgHUKbE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Aug 2020 06:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgHUKaT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Aug 2020 06:30:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE2C06134A
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:30:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so1435657wrm.12
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2020 03:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xrkad1dT1PqnIAHvf/9uKqIEtr9fqQIFC7z/xBajrtk=;
        b=JCLUg5q3TNl+zUrInUVsJb9rfRTarwsabzIEn4Tk/CwtmbS/lp3Ou6S1BfWrBAUTJ7
         fws8rOT5/BjFv0fYuXRPPRRIlHmY3Un0j0LVVLnLcP2cEbTHgobtoDWS6tB0dXEQub8S
         z4XoKPVmyjyx5YlR9mxAGJYliSpvHRSmBlMXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xrkad1dT1PqnIAHvf/9uKqIEtr9fqQIFC7z/xBajrtk=;
        b=NM1PQ4fKn8gXCBZi9OboLxBcFJ5viwLBNxLsSVdU8Wo6xnZRzDxnd9dasjlPJpEWYN
         Ca7QsgoztnTOHguuzXkEZu5jzbEBGDNUl52lkkj4qbJGAVp9bwfYBWZm0FXTHh0LoJbC
         znxKjYAPWIr46bKnhw8wUZtu5+JRJJVAH2My04GtRvOCki2VkjGHhAopFHAtLYbUdvST
         ujReEk4pqef5Hkm8D5s45De5R0JWvOlJvSKyJYAVcghJpc2PHGwnX68DgFyj/5QBJ2lp
         Nac3KjObBzrGcdM1+PRaMd8aRIyvCriTJj/Kuri48E112sobfe0DD25Wq3BCB+3/EZHo
         ldpQ==
X-Gm-Message-State: AOAM5321wSDbviWwKkG63M9zkUGxpDiXxSd/gexujnfoLmebCywqmGfc
        SzZisbpO5KHpvotDtXJG4jFDTg==
X-Google-Smtp-Source: ABdhPJzMynC4jfB4bnwwHan1D1AwRLftCS/eM+XLyQgRESI8PGz2Tg30nghCyVNW+ktKMZ6yhs3F0Q==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr2169405wrp.308.1598005814012;
        Fri, 21 Aug 2020 03:30:14 -0700 (PDT)
Received: from antares.lan (2.2.9.a.d.9.4.f.6.1.8.9.f.9.8.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:589f:9816:f49d:a922])
        by smtp.gmail.com with ESMTPSA id o2sm3296885wrj.21.2020.08.21.03.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:30:13 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com, yhs@fb.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 4/6] bpf: override the meaning of ARG_PTR_TO_MAP_VALUE for sockmap and sockhash
Date:   Fri, 21 Aug 2020 11:29:46 +0100
Message-Id: <20200821102948.21918-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821102948.21918-1-lmb@cloudflare.com>
References: <20200821102948.21918-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The verifier assumes that map values are simple blobs of memory, and
therefore treats ARG_PTR_TO_MAP_VALUE, etc. as such. However, there are
map types where this isn't true. For example, sockmap and sockhash store
sockets. In general this isn't a big problem: we can just
write helpers that explicitly requests PTR_TO_SOCKET instead of
ARG_PTR_TO_MAP_VALUE.

The one exception are the standard map helpers like map_update_elem,
map_lookup_elem, etc. Here it would be nice we could overload the
function prototype for different kinds of maps. Unfortunately, this
isn't entirely straight forward:
We only know the type of the map once we have resolved meta->map_ptr
in check_func_arg. This means we can't swap out the prototype
in check_helper_call until we're half way through the function.

Instead, modify check_func_arg to treat ARG_PTR_TO_MAP_VALUE to
mean "the native type for the map" instead of "pointer to memory"
for sockmap and sockhash. This means we don't have to modify the
function prototype at all

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6ccfce3bf4c..7e15866c5184 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3872,6 +3872,33 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
 	return -EINVAL;
 }
 
+static int resolve_map_arg_type(struct bpf_verifier_env *env,
+				 const struct bpf_call_arg_meta *meta,
+				 enum bpf_arg_type *arg_type)
+{
+	if (!meta->map_ptr) {
+		/* kernel subsystem misconfigured verifier */
+		verbose(env, "invalid map_ptr to access map->type\n");
+		return -EACCES;
+	}
+
+	switch (meta->map_ptr->map_type) {
+	case BPF_MAP_TYPE_SOCKMAP:
+	case BPF_MAP_TYPE_SOCKHASH:
+		if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
+			*arg_type = ARG_PTR_TO_SOCKET;
+		} else {
+			verbose(env, "invalid arg_type for sockmap/sockhash\n");
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		break;
+	}
+	return 0;
+}
+
 static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			  struct bpf_call_arg_meta *meta,
 			  const struct bpf_func_proto *fn)
@@ -3904,6 +3931,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		return -EACCES;
 	}
 
+	if (arg_type == ARG_PTR_TO_MAP_VALUE ||
+	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
+	    arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
+		err = resolve_map_arg_type(env, meta, &arg_type);
+		if (err)
+			return err;
+	}
+
 	if (arg_type == ARG_PTR_TO_MAP_KEY ||
 	    arg_type == ARG_PTR_TO_MAP_VALUE ||
 	    arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE ||
-- 
2.25.1

