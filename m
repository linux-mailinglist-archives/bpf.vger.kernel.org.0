Return-Path: <bpf+bounces-165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 937386F8D8F
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 03:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0281C21ACC
	for <lists+bpf@lfdr.de>; Sat,  6 May 2023 01:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249FC1365;
	Sat,  6 May 2023 01:31:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FC110E6
	for <bpf@vger.kernel.org>; Sat,  6 May 2023 01:31:44 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043FB72BA
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 18:31:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9963a72fd9so4754099276.0
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 18:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683336702; x=1685928702;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hp0Ifesb79HPJK/KIKzPfPQWNmnCC9SBcN/OAlybow=;
        b=wn934bIjSlyYsjqUN/3i+nRgeyQ79+B1hcBs3GqYpWaJGFZXQA53NXLvputweRHFGw
         LMfhnju5v1AaMaoz9f4P0qQIYb5kkxJLnRgq6S2mToWYINn6YFZSntYoHigHqeEq6SRH
         41UinaAMctI7sBvB3z8E9//uz0Rbp52e9gIrDjgSBr6yw4JTzlIHjeObPY/CjBcsKX6O
         3i3syYMHoqqPrAapT7KfPo6h+KYOWD/FKhXk0yctt6mi/6o53LfT6gF6XfKNQuYTu6Cy
         wvc+4/7hWx1xbkRJOTC+2uMbg8jSKXBsY2oQ/eH/QSsFZs2JHRcIbHx9VIAXj/LEoAcy
         Oy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683336702; x=1685928702;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hp0Ifesb79HPJK/KIKzPfPQWNmnCC9SBcN/OAlybow=;
        b=F8XoXB90d/z75KYaJWGJNloAMorRQuNd1jH7mB7mwN9Y1qRO2NVHecrBLyLsmAloDI
         oEIYqYJxP8nJbtQRMxEBh6UHpvLO10m2bHpHyeJCLYkld7OKSPYqf2b10Z8Q5DeYiVdH
         C9SdVhc29Safb1+eNiNkH+gyOjd5oqkG6stTbLG2h/AKsE0798Yk/l7CwsNU+L45nyEy
         IMTxpVdsddi/oUclvrCHJkQql6Zj54J7n0AO+uiw9dRvpVgT9wvG+60LW57kqNruPYcY
         GrpemGu33n4IAMES2R3iljnBfDmzh42rRsP9GnTERyKeciDiTCnNKHbRXK4NwZnrXhlL
         90jw==
X-Gm-Message-State: AC+VfDzXVicgX3G66YxvRsf3ti71WrYZyIPO/Crv5hsVVQFfzJ5fqrSR
	xtNLKSn2QUBBZpbF9poBA/4q0OrgR6fVEZSCn5OI73dw0GpL/ewb/sFWyXBy+ht55ibY6wEO9YK
	oQmV51OPo4lNWyPhyLLgCjowWz2VG08c0/i3wZmQ+W1zsXiVudMPq/oCb+A==
X-Google-Smtp-Source: ACHHUZ41f8Sy+cWp32D8Fr5R8k9F7ETQDqrRG/yHewH0fB/t2EnZKA0kLgCgnG1g9wuRjbqZzUYo9wR+6UA=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:6826:a1a:a426:bb4a])
 (user=drosen job=sendgmr) by 2002:a05:6902:1021:b0:ba1:b908:364c with SMTP id
 x1-20020a056902102100b00ba1b908364cmr2063343ybt.12.1683336702159; Fri, 05 May
 2023 18:31:42 -0700 (PDT)
Date: Fri,  5 May 2023 18:31:29 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230506013134.2492210-1-drosen@google.com>
Subject: [PATCH bpf-next v3 0/5] Dynptr Verifier Adjustments
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
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

These patches relax a few verifier requirements around dynptrs.
Patches 1-3 are unchanged from v2, apart from rebasing
Patch 4 is the same as in v1, see
https://lore.kernel.org/bpf/CA+PiJmST4WUH061KaxJ4kRL=fqy3X6+Wgb2E2rrLT5OYjUzxfQ@mail.gmail.com/
Patch 5 adds a test for the change in Patch 4

Daniel Rosenberg (5):
  bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
  selftests/bpf: Test allowing NULL buffer in dynptr slice
  selftests/bpf: Check overflow in optional buffer
  bpf: verifier: Accept dynptr mem as mem in helpers
  selftests/bpf: Accept mem from dynptr in helper funcs

 Documentation/bpf/kfuncs.rst                  | 23 ++++++++++-
 include/linux/skbuff.h                        |  2 +-
 kernel/bpf/helpers.c                          | 30 +++++++++------
 kernel/bpf/verifier.c                         | 21 ++++++++--
 .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +
 .../testing/selftests/bpf/progs/dynptr_fail.c | 20 ++++++++++
 .../selftests/bpf/progs/dynptr_success.c      | 38 +++++++++++++++++++
 7 files changed, 118 insertions(+), 18 deletions(-)


base-commit: f4dea9689c5fea3d07170c2cb0703e216f1a0922
-- 
2.40.1.521.gf1e218fcd8-goog


