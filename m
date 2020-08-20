Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0F624C02F
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 16:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgHTOJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 10:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731190AbgHTN6f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Aug 2020 09:58:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31916C06134B
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 06:58:11 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so3850319wmc.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2020 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oiK+rBr2Yq1A+CZUKtBJ0bMDLIUMfhUoB/dSDGCmoiU=;
        b=N1Wu4FpE7GHtUguuv2GTHHLiOM28SDW14tUtNByl+IzL2uyNbEtAh22NR/IsextheV
         JTJHIgZQ8ZA6WXuD5mD2lBXsdW/6v8Xsy3Xr97JtniAPYSe3gcem2VMyK39urmf1WnBI
         4pjoK1MIUv8EdSfCSSfCEZXJxxHnWw9hV3L1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oiK+rBr2Yq1A+CZUKtBJ0bMDLIUMfhUoB/dSDGCmoiU=;
        b=t4b6su2HOMj9GiLNTmBJnftiONhI5/Ge9PrZHykdeFYSRETZ3n7gp8lakxq6Bm5dea
         TJoDWExRzP9y4a2fKCZ9Fs9sQV8HvzBX3rUwRDOGyCnrBjzBWIe8phXBc+hqWlFPKqEm
         TCnV8+FA+2mqw5p1WNKAMMrhZUd2255yPlsUhXwRl8ajZFgU7x73xVYJst5nTCR0rf6B
         BlTo/Bntnwg3bY/N40j5zuCouGEW4BC3BhJLk7ZwbVx90uH8Qkc+vhQuvoHKlj2nYzOX
         85ECLF96Nyp6gbqlbeufgCZwz1TS7QY66jFWwJcrg2p++L0ZFxvYvNwt9ze4B9tq4VIh
         IRFg==
X-Gm-Message-State: AOAM533Rg0zeTnSimu/HYW3XxSR5NFl6/wIQQJ6yMsx+03jVYgV9T3fc
        YSlDjyeIkgip8kJfL0dWIn8G3jV5JWWG/aDj
X-Google-Smtp-Source: ABdhPJwCyKqWHp2N6V2hOg3rK1i87AM5EhXsGZzLEhzOjoy7Z1j+v3YJjic+Z0QgmbsqcuRnpxjacA==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr3613908wmh.89.1597931889816;
        Thu, 20 Aug 2020 06:58:09 -0700 (PDT)
Received: from antares.lan (d.0.f.e.b.c.7.2.d.c.3.8.4.8.d.9.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:9d84:83cd:27cb:ef0d])
        by smtp.gmail.com with ESMTPSA id l81sm4494215wmf.4.2020.08.20.06.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 06:58:09 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 4/6] bpf: override the meaning of ARG_PTR_TO_MAP_VALUE for sockmap and sockhash
Date:   Thu, 20 Aug 2020 14:57:27 +0100
Message-Id: <20200820135729.135783-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820135729.135783-1-lmb@cloudflare.com>
References: <20200820135729.135783-1-lmb@cloudflare.com>
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

Instead, modify check_func_arg to treat ARG_PTR_TO_MAP_VALUE* to
mean "the native type for the map" instead of "pointer to memory"
for sockmap and sockhash. This means we don't have to modify the
function prototype at all

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b6ccfce3bf4c..24feec515d3e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3872,6 +3872,35 @@ static int int_ptr_type_to_size(enum bpf_arg_type type)
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
+		} else if (*arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL) {
+			*arg_type = ARG_PTR_TO_SOCKET_OR_NULL;
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
@@ -3904,6 +3933,14 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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

