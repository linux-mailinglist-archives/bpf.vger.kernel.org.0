Return-Path: <bpf+bounces-169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 416766F8D9B
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDA0328112E
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 01:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3683915C8;
	Sat,  6 May 2023 01:31:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A03D1365
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 01:31:55 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32E87289
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:31:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b9a7e3fc659so5364142276.1
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 18:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336711; x=1685928711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=noqQTFIlV1didrxBB+dE4dD4wTuWXHoC2gsWWh71mN0=;
        b=A7WrekGhFBtviUe07eASnOsEN5eQOjONln//SJzN90P0dq/7aoZYKQNWGWUb0/pxX8
         17Xgy5Y/wecQTNRhXcUpON48bqSvod+CU0oz/gJnfxSfxAdbVUwGR5WKeSHFwl8hzzjA
         n394eeN+M0Ps+XOTymCWGimyWSpPTicDSD93VueMfqQrv2zWNoFiVmObNKdYPb43tL6T
         9m+jH7+LxrlkZUdSVVoUCETsDJNG+Os7lmdcr+hp8DeXQdQ+vS9ezc1aG9yNz9Uxmk8u
         hACmUGU/oHp265pa0tBla0yZtIloMb+FNYOhmgy9PpBBjkMhF6DGYGhjSoe6LQcJnIMN
         /Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336711; x=1685928711;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noqQTFIlV1didrxBB+dE4dD4wTuWXHoC2gsWWh71mN0=;
        b=Iz07a7iKO6tIC8xqXzv60Ub5c3wFnvGsDfr9jQbhGQXO51k9c2rZWTDSmd/9nSYW4w
         fk7l11Zz+w5yxDxtTm8LMA1AE2NXJESEGw5NU8oMwvXqYu8EVJGXKm2AujxZOlWgA7vF
         UmIMFF4RK/o/pyrr5JG2HVKgvqMBMC61ybW9bJR7UmuVJAXu/dCYLnPIVSsmQYW0t2in
         n1b6cCtvxYxVuVDw6nn0RdH+Rs30I4wDJaULDedmEliLdHjLHvatmeqM+O1wIROfy3vA
         b3cuBppORKa92Ive/xJuTN+wJdIAskMzQ/gVVQqlu09VRhxRaHAMaAzq2DKRZqVqAcLZ
         YqzA==
X-Gm-Message-State: AC+VfDxoaO1hSrq9DBiwiWMXIkCHS4lBGjY75kQ0mHrWCXVpKWMeDmY9
	SGi7HMlYBrSvcWE3lhhF/ZYz4j67+PTPRnVGKUbrxA6HtqZXGa1Z27mGUKLgrYUHaars+hKFlfP
	S7iaLs/A+Y/bi6bp9GY4osq8MlE/R6vdfMFs371+FQfFM0qkzZX7ytJjUeQ==
X-Google-Smtp-Source: ACHHUZ4jAkCfhj/0qkPe2EbJCeuk7CdnGPeEz6q0HYyq5SD351NwAI0IIHutmYZUIFwtUnZ2cgWmvwb4PdU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a25:d8cd:0:b0:b9a:703d:e650 with SMTP id
 p196-20020a25d8cd000000b00b9a703de650mr1515459ybg.7.1683336711412; Fri, 05
 May 2023 18:31:51 -0700 (PDT)
Date: Fri,  5 May 2023 18:31:33 -0700
In-Reply-To: <20230506013134.2492210-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230506013134.2492210-1-drosen@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-5-drosen@google.com>
Subject: [PATCH bpf-next v3 4/5] bpf: verifier: Accept dynptr mem as mem in helpers
From: Daniel Rosenberg <drosen@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This allows using memory retrieved from dynptrs with helper functions
that accept ARG_PTR_TO_MEM. For instance, results from bpf_dynptr_data
can be passed along to bpf_strncmp.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7e6bbae9db81..754129d41225 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7495,12 +7495,16 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	 * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and PTR_TO_MEM + MAYBE_NULL,
 	 * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT with PTR_TO_MEM + MAYBE_NULL
 	 *
+	 * ARG_PTR_TO_MEM is compatible with PTR_TO_MEM that is tagged with a dynptr type.
+	 *
 	 * Therefore we fold these flags depending on the arg_type before comparison.
 	 */
 	if (arg_type & MEM_RDONLY)
 		type &= ~MEM_RDONLY;
 	if (arg_type & PTR_MAYBE_NULL)
 		type &= ~PTR_MAYBE_NULL;
+	if (base_type(arg_type) == ARG_PTR_TO_MEM)
+		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
 	if (meta->func_id == BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
 		type &= ~MEM_ALLOC;
-- 
2.40.1.521.gf1e218fcd8-goog


