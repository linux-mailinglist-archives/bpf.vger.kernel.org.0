Return-Path: <bpf+bounces-5029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E83753D22
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 16:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B671628222B
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 14:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A59134DC;
	Fri, 14 Jul 2023 14:20:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6BE551
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 14:20:11 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A788A35B6
	for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:19:58 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so30548091fa.1
        for <bpf@vger.kernel.org>; Fri, 14 Jul 2023 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1689344396; x=1691936396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOM71+GU+T1T1qOu5w/HL2SfWMg9bTGekah19LwcmD0=;
        b=UI7yA0NCljyPV90x5iH2UZm+0KKrA8N7HkpLhvBx5YI45KWnVP0X+lfmDOcGRqzgv1
         BcCQDP6dU/L9fQzql4WNP9zBQ0eUWzVxsDihjm+oP2cPd12NoUxq2veYH3d4P9XEW83f
         rznnZrUsJO/6XSu/0n6dQAIw5GIrXtW9VtmJd6SXXp9XzDm+6KQ4sQblfQPUNnSjQPb6
         uV+G2waAqi0kYaY1DT+4F6SjMimbLaxEJv4B30RbzTxBxcsgoyZJv34S3xFKBu/2NaWZ
         5B4KMaLrawhOyN51NWUzN9y3VfpH9r3WVj5l63BbsiO5QVPKkr/olFiimbG30XSwcoX/
         xg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689344396; x=1691936396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOM71+GU+T1T1qOu5w/HL2SfWMg9bTGekah19LwcmD0=;
        b=NNsmhwzvu13v9fWbVwcfHgBiYwgZGcTlftXvcOiTxWz567EF6HTKwa7KoqlKIpLM64
         p6HlRKPev8MYO/iPmu1YCdrrDHlYOaJwixabSHy+uFVAvfMv9/yNACIeKb+eJKCP7KY9
         FaAtKGIFfMMuL6PYLbkNMOBiIWtE9FG+pzmLBy0E5ovREz9gJnvoqH0zBL6dxdaTb0Tr
         iP/NlwAXGK7Olf4boMQcOlFgZgJ8KEMoibdi2R8GY+VtMNB4x3bFx3wLXMWUUz0nGxKd
         bUNNxJWuDsAiM84FSGZJa/mPcTGwMdBPr/AEbMLG8bQE7rG6SeKIJCi3Ml+xicTv9fI3
         XqRw==
X-Gm-Message-State: ABy/qLbh2ntUs3Y4q/YGZNDRvPRxitnlA1t+PQNyargWqMj5U0lwWU9F
	qq69BKT4/z849tYDws2tVcxV4g==
X-Google-Smtp-Source: APBJJlEEewGkR5M6G3Z2O889CSsBBwJRRRpEHhz3Y1u3wjPnDAdOkxed/DQqLQQrANnekX7C0UO28g==
X-Received: by 2002:a2e:3503:0:b0:2b7:764:3caf with SMTP id z3-20020a2e3503000000b002b707643cafmr3610916ljz.10.1689344396601;
        Fri, 14 Jul 2023 07:19:56 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id n11-20020a1709061d0b00b00982cfe1fe5dsm5469294ejh.65.2023.07.14.07.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:19:56 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/3] allow bpf_map_sum_elem_count for all program types
Date: Fri, 14 Jul 2023 14:20:57 +0000
Message-Id: <20230714142100.42265-1-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714141747.41560-1-aspsk@isovalent.com>
References: <20230714141747.41560-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This short series is a follow up to the recent series [1] which added
per-cpu insert/delete statistics for maps. The bpf_map_sum_elem_count
kfunc presented in the original series was only available to tracing
programs, so let's make it available to all.

The first patch allows to treat CONST_PTR_TO_MAP as trusted pointers
from kfunc's point of view.

The second patch just adds const to the map argument of the
bpf_map_sum_elem_count kfunc.

The third patch registers the bpf_map_sum_elem_count for all programs,
and patches selftests correspondingly.

Anton Protopopov (3):
  bpf: consider CONST_PTR_TO_MAP as trusted pointer to struct bpf_map
  bpf: make an argument const in the bpf_map_sum_elem_count kfunc
  bpf: allow any program to use the bpf_map_sum_elem_count kfunc

 include/linux/btf_ids.h                          | 1 +
 kernel/bpf/map_iter.c                            | 7 +++----
 kernel/bpf/verifier.c                            | 5 ++++-
 tools/testing/selftests/bpf/progs/map_ptr_kern.c | 5 +++++
 4 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.34.1


