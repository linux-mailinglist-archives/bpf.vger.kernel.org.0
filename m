Return-Path: <bpf+bounces-3230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766F73AF51
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 06:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059342818C0
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 04:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E386F137D;
	Fri, 23 Jun 2023 04:14:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A681115
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 04:14:22 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3936B268A
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:18 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57003dac4a8so29655677b3.1
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 21:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687493658; x=1690085658;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5eNUUC1qhFC8BaXPxkTz70Auf+6/vfYl3zUIKz5jKhk=;
        b=po3z9layU6zmEdpr6sz5mdOaALXq8MEmCSQ655ehbQ752sTCxwwul3mEaCJMt1jjcx
         9pAIVLSiQNTEHbz2mfftFK1xhGU09BLRN5VE9NzRcIG3x3Kc3lbm57ayO6aGdTxGt1JO
         NuFh1W1Ee3G9Md2e0UWqU1FLPfDIeIVY1duAgkn0iCYoqS2SaCGD/qDnP2P8h1yBytcZ
         BcuS414q9naG98jLI+h08zOvGF6pI9NBqvF1UlY4T/DQ+vfZx3Y+WzQ8EberbpajHmvA
         ALQnT+6mcGSdJAqt6k92H/EFlh7QT1jMgS3ITeHmfHndZqOBSb7HfeAell7829W0KdUp
         5eFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687493658; x=1690085658;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5eNUUC1qhFC8BaXPxkTz70Auf+6/vfYl3zUIKz5jKhk=;
        b=R0dHMGhiBEoZP8f2ANn1NDczQqyDL0exNFUGmifK8bRuked5EqOFEFjyK+CYDOeS0d
         qj69Lt3mdKSOxXebfqp4lpr1qwiSaxjsWzRpoMo+HjMqB5lQl0+GoJjOTHbSDo9618Wz
         741+7bQQhTQ0J1tH8IFlF+waaetrRn7jOMEJzqzYTPgv5BhQg3N2YHTITgJzoNlSBB5s
         WSGShS6o9X/nsHUkVGWSV7ggIwGCgQji14ehYLP0N+/V15Ud86mOOfjBQ6wGiJrx8w4S
         +iMujKrSRp2OG3xnaiucN7AtwknP0Sf9sqgyItmWpI19y7Ybqr3UVf28uR4paCL/u9u+
         N2Ug==
X-Gm-Message-State: AC+VfDyye6dVv6m9y5QEs56SfdQu7UM/MLIsqO47rtC7N1ZHszsGweGS
	5CkDhgnAVoHJKL/imcZMlzlnDRvExzt1
X-Google-Smtp-Source: ACHHUZ6siMIzasbytzIi0CCx3XeoDodWisIP4cOQIkEVErG/A8qcf2a6WWiOnrBsOSufKz3gaW6nIPMeh0Ap
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a05:6902:561:b0:bad:2b06:da3 with SMTP id
 a1-20020a056902056100b00bad2b060da3mr8555838ybt.3.1687493657950; Thu, 22 Jun
 2023 21:14:17 -0700 (PDT)
Date: Thu, 22 Jun 2023 21:14:03 -0700
In-Reply-To: <20230623041405.4039475-1-irogers@google.com>
Message-Id: <20230623041405.4039475-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230623041405.4039475-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v4 2/4] perf bpf: Move the declaration of struct rq
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@arm.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

struct rq is defined in vmlinux.h when the vmlinux.h is generated,
this causes a redefinition failure if it is declared in
lock_contention.bpf.c. Move the definition to vmlinux.h for
consistency with the generated version.

Fixes: 760ebc45746b ("perf lock contention: Add empty 'struct rq' to satisfy libbpf 'runqueue' type verification")
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/bpf_skel/lock_contention.bpf.c |  2 --
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h     | 10 ++++++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
index 1d48226ae75d..8d3cfbb3cc65 100644
--- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
+++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
@@ -416,8 +416,6 @@ int contention_end(u64 *ctx)
 	return 0;
 }
 
-struct rq {};
-
 extern struct rq runqueues __ksym;
 
 struct rq___old {
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index c7ed51b0c1ef..ab84a6e1da5e 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -171,4 +171,14 @@ struct bpf_perf_event_data_kern {
 	struct perf_sample_data *data;
 	struct perf_event	*event;
 } __attribute__((preserve_access_index));
+
+/*
+ * If 'struct rq' isn't defined for lock_contention.bpf.c, for the sake of
+ * rq___old and rq___new, then the type for the 'runqueue' variable ends up
+ * being a forward declaration (BTF_KIND_FWD) while the kernel has it defined
+ * (BTF_KIND_STRUCT). The definition appears in vmlinux.h rather than
+ * lock_contention.bpf.c for consistency with a generated vmlinux.h.
+ */
+struct rq {};
+
 #endif // __VMLINUX_H
-- 
2.41.0.162.gfafddb0af9-goog


