Return-Path: <bpf+bounces-751-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B8D70654A
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 12:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CF901C20F17
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 10:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41946156DF;
	Wed, 17 May 2023 10:31:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2F0168D9
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:31:41 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC89F59D5
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:31:33 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-783fc329e7eso43239241.2
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684319493; x=1686911493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gG/g++T4hxHkCbdshIsCuyl8j+Kw5aES49DKS4s5BfQ=;
        b=JEwe1GJ+ZGtw9xcKONuXW+8d0SWHEv4uashUVYZWD2dDsC7qBreow5jriFfvFecmYz
         QDwTOT6ZA8SAioBOA1EU4eKiR3dJTLIw0Du/SX4ixJD6iyzi5Vne2ORbJteyEHQ3fG2J
         SSsPg6gJHW/XydP/L5SlPu6gmT+thUV+8vknIPuOp6861iMcsFiUIHMJGYRrNs9VwPaW
         3wPmSoIwFOrFR5QMUSZVvZnNFArFykNfgpnXBZagK62IHSuSDmtmnLsO0vOumRudMmw5
         HO5LMuGDDCppQIrrAEoK7XbeODmv9F+C0bodCGXPjxrw+n3P7RYCHp4CX/ptYaA7/tju
         rwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319493; x=1686911493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gG/g++T4hxHkCbdshIsCuyl8j+Kw5aES49DKS4s5BfQ=;
        b=kisLwEMdLusqHK+hMFk3ZT2dDlSeSzuyyN7Nzs29E/1GCPc0MP18RbBzM8vcJYt6z0
         uGiJG2tzVsQp8rejIE99lgskvnDdI1j4o+qshn2tMb+RaaSUMbE9hGI05SyCxJdMl5Yv
         HGNt5jRIwitRBEWwlSqKgCEmlA8nRjlHQx8DVZk5yDmi+kCQSJo64X8ReifxAcZ90Xdj
         hC7IBU/ZQC0s8qpFOQu57f+XNlFpeye8qiAWtZ63LgXv/1gXT0SB31eJpvsaGf5bHSJ7
         81EyOo6omK53HJUvFX2JkN0CYUU1B9Ewz7T6kr+ZGTelaE9BuUS8eimNGruswa9x2WHP
         DG3g==
X-Gm-Message-State: AC+VfDzKfDr6COapohFakt1dItyWiRciwADAjm+q0RcJUWZ4uJ0lc3YJ
	/BpnA5NM635l/7ZB8NCt6j0=
X-Google-Smtp-Source: ACHHUZ5dz+7d6xDdv1pLeeKdZ3Wev76Vy+QRvYdDUrT1E/ojDyubLhPxVxooh4fQbJ1a9jZqg8Wjsw==
X-Received: by 2002:a67:f9c7:0:b0:42f:f1ce:c469 with SMTP id c7-20020a67f9c7000000b0042ff1cec469mr15584069vsq.33.1684319492734;
        Wed, 17 May 2023 03:31:32 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:9002:140f:5400:4ff:fe70:c0fd])
        by smtp.gmail.com with ESMTPSA id t25-20020a9f3899000000b0076d52359f2asm5343651uaf.31.2023.05.17.03.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:31:32 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 2/2] bpftool: Show target_{obj,btf}_id in tracing link info
Date: Wed, 17 May 2023 10:31:26 +0000
Message-Id: <20230517103126.68372-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517103126.68372-1-laoar.shao@gmail.com>
References: <20230517103126.68372-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The target_btf_id can help us understand which kernel function is
linked by a tracing prog. The target_btf_id and target_obj_id have
already been exposed to userspace, so we just need to show them.

The result as follows,

$ tools/bpf/bpftool/bpftool link show
2: tracing  prog 13
        prog_type tracing  attach_type trace_fentry
        target_obj_id 1  target_btf_id 13964
        pids trace(10673)

$ tools/bpf/bpftool/bpftool link show -j
[{"id":2,"type":"tracing","prog_id":13,"prog_type":"tracing","attach_type":"trace_fentry","target_obj_id":1,"target_btf_id":13964,"pids":[{"pid":10673,"comm":"trace"}]}]

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
 tools/bpf/bpftool/link.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 243b74e..2d78607 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -195,6 +195,8 @@ static int show_link_close_json(int fd, struct bpf_link_info *info)
 
 		show_link_attach_type_json(info->tracing.attach_type,
 					   json_wtr);
+		jsonw_uint_field(json_wtr, "target_obj_id", info->tracing.target_obj_id);
+		jsonw_uint_field(json_wtr, "target_btf_id", info->tracing.target_btf_id);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		jsonw_lluint_field(json_wtr, "cgroup_id",
@@ -375,6 +377,10 @@ static int show_link_close_plain(int fd, struct bpf_link_info *info)
 			printf("\n\tprog_type %u  ", prog_info.type);
 
 		show_link_attach_type_plain(info->tracing.attach_type);
+		if (info->tracing.target_obj_id || info->tracing.target_btf_id)
+			printf("\n\ttarget_obj_id %u  target_btf_id %u  ",
+			       info->tracing.target_obj_id,
+			       info->tracing.target_btf_id);
 		break;
 	case BPF_LINK_TYPE_CGROUP:
 		printf("\n\tcgroup_id %zu  ", (size_t)info->cgroup.cgroup_id);
-- 
1.8.3.1


