Return-Path: <bpf+bounces-5265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E6475919B
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 11:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271F428115E
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 09:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7D611CB4;
	Wed, 19 Jul 2023 09:28:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A9F111BB
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 09:28:43 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BFB1715
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:41 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3159d5e409dso371183f8f.0
        for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689758920; x=1692350920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N+yJnAl3CCQWb/mfN2f4CLcTItvIXBeaPFFTQ42Alt4=;
        b=Qe1Qo1A7lFJd+xdiu0BpKr3r4b11oInJMbPdUPdeGVEAn/xYpXOe+H62t77qy6lQSZ
         vj1+XLOVcE8I3Mk9DsdeaTX+Y9F8VQTxAcSlz/SGwKCz+2Us5XNKpLB9YnbLBmLd0zdS
         5O06IWhhEl2Bv7sa+dlOVNlqzHbYdPhhyzTwOtTmIykJik1tRgOmYMJJ6pAhTDJz9T3G
         5uWdu8RBJ93xk7Rs6mQTd2V5KCbGDaxx0eJ59e1YVzoMuw70td6cf0n4AYqeLECPPotf
         E1UT/biMKw7XPC/PaVA7kFCioo3p46bfsRn5H6BWdFP1mN8tL3m1A8jUs720p2mCgCTo
         lDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689758920; x=1692350920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N+yJnAl3CCQWb/mfN2f4CLcTItvIXBeaPFFTQ42Alt4=;
        b=b7U3tZpNpFyrPC4YBCCA656vCNRFymS09j6Vdvn/qymY3Z+ErSPqN+W56PnU2MLeOC
         z4TKvEJfqmhxd/aBkSIAg6NyzA07HreINTJ+wAcBC+fc1by9PjYmMnzY5mbYwKa7pcWN
         2+mhh2oBDvXC0JlGL2ltTZdSgGjSwAluR9qbdQUfJih8HGqwafJwmo7luzQjCC4JBb9h
         Nmixl75WfQ/Q6U0O5Gtqrmjdeb6nRdykDpp71N/TdzqyBxJwBfKLRVJ6PDvTcBjzZs7G
         ute2mnqWT0RBzejOm9Rebs61u8JFJ4MffQoihPpJudcyqqCs7/4Tq/bAmGp6OJDdu3W0
         wX5w==
X-Gm-Message-State: ABy/qLZQ4wF6YnPWvfMXGXO8nW3GmvYHwTTodieTbWeJXNCflMpQRRIv
	Pj268YnQiIRXCpFvT1Ahkmwh9g==
X-Google-Smtp-Source: APBJJlGwoQ6LF55a5YukSTcWiEnbF3Xtw53f47orxgf2BUQj/Vv8UNfS3yu8eFT84FN/HA44u4GjSQ==
X-Received: by 2002:adf:db52:0:b0:314:3f86:dd9f with SMTP id f18-20020adfdb52000000b003143f86dd9fmr1311078wrj.25.1689758920131;
        Wed, 19 Jul 2023 02:28:40 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id r18-20020adff112000000b0031435c2600esm4857213wro.79.2023.07.19.02.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 02:28:39 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Hou Tao <houtao1@huawei.com>,
	Joe Stringer <joe@isovalent.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 bpf-next 0/4] allow bpf_map_sum_elem_count for all program types
Date: Wed, 19 Jul 2023 09:29:48 +0000
Message-Id: <20230719092952.41202-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series is a follow up to the recent change [1] which added
per-cpu insert/delete statistics for maps. The bpf_map_sum_elem_count
kfunc presented in the original series was only available to tracing
programs, so let's make it available to all.

The first patch makes types listed in the reg2btf_ids[] array to be
considered trusted by kfuncs.

The second patch allows to treat CONST_PTR_TO_MAP as trusted pointers from
kfunc's point of view by adding it to the reg2btf_ids[] array.

The third patch adds missing const to the map argument of the
bpf_map_sum_elem_count kfunc.

The fourth patch registers the bpf_map_sum_elem_count for all programs,
and patches selftests correspondingly.

  [1] https://lore.kernel.org/bpf/20230705160139.19967-1-aspsk@isovalent.com/

v1 -> v2:
  * treat the whole reg2btf_ids array as trusted (Alexei)

Anton Protopopov (4):
  bpf: consider types listed in reg2btf_ids as trusted
  bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
  bpf: make an argument const in the bpf_map_sum_elem_count kfunc
  bpf: allow any program to use the bpf_map_sum_elem_count kfunc

 include/linux/btf_ids.h                       |  1 +
 kernel/bpf/map_iter.c                         |  7 +++---
 kernel/bpf/verifier.c                         | 22 +++++++++++--------
 .../selftests/bpf/progs/map_ptr_kern.c        |  5 +++++
 4 files changed, 22 insertions(+), 13 deletions(-)

-- 
2.34.1


