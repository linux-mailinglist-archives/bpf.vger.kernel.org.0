Return-Path: <bpf+bounces-387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 166CC7005AF
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A26281B36
	for <lists+bpf@lfdr.de>; Fri, 12 May 2023 10:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46EFA920;
	Fri, 12 May 2023 10:34:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBA63AF
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 10:34:51 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7B120A7
	for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-307d58b3efbso574693f8f.0
        for <bpf@vger.kernel.org>; Fri, 12 May 2023 03:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683887646; x=1686479646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5sXPdyU9efEL+rWoYA/idGzRcgmGhszmkcLO+f8cWw=;
        b=RGhlJ0NYfawKxxA/rjatlvNnxb32ivjqRAs3K+9d4iHlsmspJE7ZyiSWTSrRUr48ej
         R9/f22B+smDao13tC3lrQa/j4w/8Bg5GwcPEQhnEn83/dCs43IByDCQ2uC+ekleVlPEj
         uis9DkLSQqjBN84JRZxr+4bWwYsS0LJTT2ieHPCN+T+Ej/H1RyG+JrEy2LQwWLeTin6+
         tiwHeUTCX9y7tKP4NC70QwMDM5hOifY+owK9hEVX7mvyGmm8OQs+BvvAIa1dwHYMB1As
         IbWycA8EDUYZI4mgfIliimH1DsBJV/oKIgi4LlN9mTJrsnbVK/apAViYffbmrchQuaWo
         02GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683887646; x=1686479646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5sXPdyU9efEL+rWoYA/idGzRcgmGhszmkcLO+f8cWw=;
        b=QtQTXhLJrUin3TPg9Bvt+HQP/93y4P3nV4UKDRSL1eA8IpN2Tjd7MwKJzqe2oN6nMX
         KyqmCEgPvTMA8FXTBTuXvsYRmyxLDe/swOe+4ouWH6u9qF45xClfR65qHYFhZbQTGcNI
         AtUu7/jrRjAUedHqdzBRrfQm/15CHYN74ArZ6tmSCTRU2awtq+Zba7x4cvr8QRwLLA7m
         5QKLQ6XexyS7/TVf1s1Smi1dCaE38XMYIr/P96yprk2/UoJJZi+Y+JdRmmqwhGmjek84
         d1KEjp291zCsYlMvafWgqaOXQYLuY6aPkm/sCZFZrCk9lKDxraU4RAUaaClI8ZlQYPUW
         pMbQ==
X-Gm-Message-State: AC+VfDz2b8jO9O5Mx+Xh9I4GaS8+/Hxg0C1N5dHKLHie75iIxvda5Wcn
	3pM1qOzT7MUHkkr3zGzG7XPsmw==
X-Google-Smtp-Source: ACHHUZ6TEJW7VBDa8nJo9DRyHQ19JFVQBE2nVKIS/TrpfckVJiKFJONLdIdFWftTu0gZT9fdazDHjg==
X-Received: by 2002:adf:dc04:0:b0:307:a33d:d054 with SMTP id t4-20020adfdc04000000b00307a33dd054mr8886405wri.49.1683887645927;
        Fri, 12 May 2023 03:34:05 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:a162:20e4:626a:dd])
        by smtp.gmail.com with ESMTPSA id q6-20020adff946000000b003078cd719ffsm17946320wrr.95.2023.05.12.03.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 03:34:05 -0700 (PDT)
From: Quentin Monnet <quentin@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH bpf-next 0/4] bpftool: Fix skeletons compilation for older kernels
Date: Fri, 12 May 2023 11:33:50 +0100
Message-Id: <20230512103354.48374-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

At runtime, bpftool may run its own BPF programs to get the pids of
processes referencing BPF programs, or to profile programs. The skeletons
for these programs rely on a vmlinux.h header and may fail to compile when
building bpftool on hosts running older kernels, where some structs or
enums are not defined. In this set, we address this issue by using local
definitions for struct perf_event, struct bpf_perf_link,
BPF_LINK_TYPE_PERF_EVENT (pids.bpf.c) and struct bpf_perf_event_value
(profiler.bpf.c).

This set contains patches 1 to 3 from Alexander Lobakin's series, "bpf:
random unpopular userspace fixes (32 bit et al)" (v2) [0], from April 2022.
An additional patch defines a local version of BPF_LINK_TYPE_PERF_EVENT in
bpftool's pids.bpf.c.

[0] https://lore.kernel.org/bpf/20220421003152.339542-1-alobakin@pm.me/

Cc: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Michal Suchánek <msuchanek@suse.de>

Alexander Lobakin (3):
  bpftool: use a local copy of perf_event to fix accessing ::bpf_cookie
  bpftool: define a local bpf_perf_link to fix accessing its fields
  bpftool: use a local bpf_perf_event_value to fix accessing its fields

Quentin Monnet (1):
  bpftool: Use a local copy of BPF_LINK_TYPE_PERF_EVENT in
    pid_iter.bpf.c

 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 26 +++++++++++++++++-----
 tools/bpf/bpftool/skeleton/profiler.bpf.c | 27 ++++++++++++++---------
 2 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.34.1


