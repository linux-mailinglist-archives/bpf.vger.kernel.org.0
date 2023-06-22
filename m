Return-Path: <bpf+bounces-3128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 774BB739DBD
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B9BC2818DE
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497635246;
	Thu, 22 Jun 2023 09:52:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BAD3AA86
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 09:52:37 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CC1E75
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:52:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51be527628fso1047159a12.3
        for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 02:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687427553; x=1690019553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJQXCRhHAGM2dxz4g/DdfYE3ubcKPV56yGyyMtJYGU8=;
        b=hb1vd7qYpaF/x0QcJU+slefLN6H/BDeByq4kS64YXEfe+q3ekE81d2nbGon3WBjlp3
         8XnQFJJV2YlwbjMR09UHLSGQqgRYbP1sOuc/PO3sarMTe0a/PSTBFYh2lLt1dMJKy9d/
         qAuMlWnWUxdcyydldOzXTrG60Btmg0omDELcdwSuDEs8mxhu1ePb4gs4/r0h8uaixWMB
         598QwS3Xl1qc8fXuymP6KfbJPVdYfS6VvSJByfThJsFV60E9pGGRZNeC6pDn/COZs8Wc
         t0HlUnBhdjDwdIYsSbNuKGKAZHef0lxkAOSRhFVQ2M4TP/YRWy0eUxm3hPfPQ0rCgOpI
         NWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427553; x=1690019553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJQXCRhHAGM2dxz4g/DdfYE3ubcKPV56yGyyMtJYGU8=;
        b=dZ9dTuf/FscJ3FQ4ejk3+RFCSxF7JzPJhFLpmYG85ur55+NrN/NtXZorUfbgFHB741
         Dun/iCdEI/qP43IZIiapP70pDOqWaus1/m9l4diGxN0LqR2KhTTYlC/kxKqbLfaTBXM+
         /APTe3uHxgTHEwBMsch7KpJVfYQfPM5EhbVPUr3vyQ7AT2TbZ49wlyDg+8yTpP7TEitV
         O0WR3z0P8LhnnwvYwHpe/zX8qhT/7TSDjIpYQyil0sYOO4397kxv0hrqNxXHg5CeUe5W
         2Uddk9EhGX2Gqejw0M6rXbDmwhxAQ1R3Psb7s860E/Z7uAY3mZ9o7ONrxQdm8tfxDnVV
         DVIw==
X-Gm-Message-State: AC+VfDyPQfVZdoXkFgnBQ1MW6Mom1Bcpoq+l5LiuvlXDRtCx7hZUmAxQ
	pWXgRycELFE3+p3zHTs45uQABw==
X-Google-Smtp-Source: ACHHUZ7pQ8mY+0uL14PAflAd56P+ui5K8shpXrixcAVBDna64Mf/yrFjKLsDEZdZaxJYnnQSfEX0cQ==
X-Received: by 2002:a05:6402:21a:b0:518:7a51:7e97 with SMTP id t26-20020a056402021a00b005187a517e97mr12329072edv.36.1687427553318;
        Thu, 22 Jun 2023 02:52:33 -0700 (PDT)
Received: from zh-lab-node-5.home ([2a02:168:f656:0:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090614cc00b0098951bb4dc3sm3387985ejc.184.2023.06.22.02.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:52:32 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>
Subject: [RFC v2 PATCH bpf-next 0/4] bpf: add percpu stats for bpf_map
Date: Thu, 22 Jun 2023 09:53:26 +0000
Message-Id: <20230622095330.1023453-1-aspsk@isovalent.com>
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
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds a mechanism for maps to populate per-cpu counters of elements
on insertions/deletions. The sum of these counters can be accessed by a new
kfunc from a map iterator program.

The following patches are present in the series:

  * Patch 1 adds a generic per-cpu counter to struct bpf_map
  * Patch 2 utilizes this mechanism for hash-based maps
  * Patch 3 extends the preloaded map iterator to dump the sum
  * Patch 4 adds a self-test for the change

The reason for adding this functionality in our case (Cilium) is to get
signals about how full some heavy-used maps are and what the actual dynamic
profile of map capacity is. In the case of LRU maps this is impossible to get
this information anyhow else. See also [1].

This is a v2 for the https://lore.kernel.org/bpf/20230531110511.64612-1-aspsk@isovalent.com/T/#t
It was rewritten according to previous comments.  I've turned this series into
an RFC for two reasons:

1) This patch only works on systems where this_cpu_{inc,dec} is atomic for s64.
For systems which might write s64 non-atomically this would be required to use
some locking mechanism to prevent readers from reading trash via the
bpf_map_sum_elements_counter() kfunc (see patch 1)

2) In comparison with the v1, we're adding extra instructions per map operation
(for preallocated maps, as well as for non-preallocated maps). The only
functionality we're interested at the moment is the number of elements present
in a map, not a per-cpu statistics. This could be better achieved by using
the v1 version, which only adds computations for preallocated maps.

So, the question is: won't it be fine to do the changes in the following way:

  * extend the preallocated hash maps to populate percpu batch counters as in v1
  * add a kfunc as in v2 to get the current sum

This works as

  * nobody at the moment actually requires the per-cpu statistcs
  * this implementation can be transparently turned into per-cpu statistics, if
    such a need occurs on practice (the only thing to change would be to
    re-implement the kfunc and, maybe, add more kfuncs to get per-cpu stats)
  * the "v1 way" is the least intrusive: it only affects preallocated maps, as
    other maps already provide the required functionality

  [1] https://lpc.events/event/16/contributions/1368/

v1 -> v2:
- make the counters generic part of struct bpf_map
- don't use map_info and /proc/self/fdinfo in favor of a kfunc

Anton Protopopov (4):
  bpf: add percpu stats for bpf_map elements insertions/deletions
  bpf: populate the per-cpu insertions/deletions counters for hashmaps
  bpf: make preloaded map iterators to display map elements count
  selftests/bpf: test map percpu stats

 include/linux/bpf.h                           |  30 +
 kernel/bpf/hashtab.c                          | 102 ++--
 kernel/bpf/map_iter.c                         |  48 +-
 kernel/bpf/preload/iterators/iterators.bpf.c  |   9 +-
 .../iterators/iterators.lskel-little-endian.h | 513 +++++++++---------
 .../bpf/map_tests/map_percpu_stats.c          | 336 ++++++++++++
 .../selftests/bpf/progs/map_percpu_stats.c    |  24 +
 7 files changed, 766 insertions(+), 296 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
 create mode 100644 tools/testing/selftests/bpf/progs/map_percpu_stats.c

-- 
2.34.1


