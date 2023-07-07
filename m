Return-Path: <bpf+bounces-4416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EE874AE34
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 11:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D83281725
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDBFBA51;
	Fri,  7 Jul 2023 09:54:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D03C0B
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:54:49 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9F72123
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 02:54:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbdfda88f4so17461085e9.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 02:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1688723686; x=1691315686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ikquadyKju9Q9YdAn4ddZ2P4To9zd7FKqdbBvaLXSMU=;
        b=U4VA81PY3sP+B5UJ6NX4AL+3TFHsBTJBlabd7OJwe0Qs4yljA4QxrHUFUfDCqSpuMv
         u8lKd+XM+a8tpnn9zMUnd8H1rAMqK+fIZuQ5Jptb7YAEUtf0SBjeECQYCubnpojfWR2n
         E/Vv9F8JdDQwFA9/rKmFvLQLqUbwa1QCbhdvAcy1BsMSbMcEVeDANjx2E7sAB6ASvUhb
         lls1KUQz2UF7Uba3Mzcevew4VnE9BzWxrf/akHwB1JM9/7qpHcOD2ak9Wg1l61KtHZv+
         3J98yI2U9n2zwY7096xOg3KNb60Dj5suBNoWIntlb7Rfr1PhQc6T7J0aRD2qHsVOUUK8
         fkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688723686; x=1691315686;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikquadyKju9Q9YdAn4ddZ2P4To9zd7FKqdbBvaLXSMU=;
        b=DbYDBMqZvk8QNsHh8cad9bmGAIFfMLMEl/o99/yozjl0uD4JW3lPHAdQbi/ZfllKz1
         YtRFjNU2qxg6R9t+X3xIeWPcXahprvtrcM/dHdMBD2CuZAf36YwLn0QhfiTsMBdwGKay
         aaqmbhp032t66ubrCQpf+htDLvT06toeqvGSqxM9cfdDi8RLRq/xBZB35ZSPjEx0HTKZ
         3RTf2JYzprVxuh3hacQfJBkgwYWaHOsJVTx3vnN4Lia/W7Nxddw4obXxUFxSp2lyyRVv
         xzt/W0h+ose23p0AuJnuY70tI8/V//GSmWWFjMxXdbtnBldxE+s1I8zTIUX2ZYCrMopV
         eBzQ==
X-Gm-Message-State: ABy/qLbdLLDa9p9YJYKUsn7omdPi3hzahkXlHmBtgTHxa5ZHB196pQ6n
	rSohFTUZf8odYpJ3QT+F8yKKlQ==
X-Google-Smtp-Source: APBJJlHoaxx+pT5f3LUOp8xhVbfpOy5RMfgeL52mduf8bN+/dVNRw6g8ql1IDOrOiEP5YvxKrqS4jA==
X-Received: by 2002:a7b:c356:0:b0:3fb:abd0:2b4b with SMTP id l22-20020a7bc356000000b003fbabd02b4bmr3294662wmj.26.1688723686130;
        Fri, 07 Jul 2023 02:54:46 -0700 (PDT)
Received: from harfang.fritz.box ([2a02:8011:e80c:0:9d9e:aaa3:b629:361])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b003fc00972c3esm622636wmb.48.2023.07.07.02.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 02:54:45 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/4] bpftool: Fix skeletons compilation for older kernels
Date: Fri,  7 Jul 2023 10:54:21 +0100
Message-Id: <20230707095425.168126-1-quentin@isovalent.com>
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

v2: Fixed description (CO-RE for container_of()) in patch 2.

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


