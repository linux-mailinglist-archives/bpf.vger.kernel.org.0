Return-Path: <bpf+bounces-53240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA1CA4EF45
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 22:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7308F3A9CC5
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 21:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA1A42AAF;
	Tue,  4 Mar 2025 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieT0dC94"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5612641F4
	for <bpf@vger.kernel.org>; Tue,  4 Mar 2025 21:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741122908; cv=none; b=kknEmGaOwCAihRFNXmMFC7aIhvv+RKzsw8ein7DnoCs5nbE0gYDTEAaQl+ztj1bMe2Xfu5jWNQ9Vq6pZsRzWTPf3Q8cQPO2E2XCLBVKdybYqNCYaJtp4Y1uR0sdFcOHs/NT13K4ETgz+aMZVCWRtpvYAjC3qJCzUUWasZq88uZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741122908; c=relaxed/simple;
	bh=quuvr/azkf81dV09kQxkFtk4ixAQoRD1Chb0odI5nIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6SpZfxJMPDyzyiFqcV7S6zzKsMap1vuCUh95GyWjs/DlWjuIwUYYj3Nyj/XUpdsoyXUaJxLqgnGxXp8oDfM+SR91Rc5/cOAyCZ2ai+IGnI9PO4lzhNHU+kBP3Prrz/THL8ldhULVVwSPVVM8Dgv/RVZxysrJv+rUWgd4XQ2pGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieT0dC94; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e4bed34bccso8591457a12.3
        for <bpf@vger.kernel.org>; Tue, 04 Mar 2025 13:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741122904; x=1741727704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6kp1l6lc9BxNq70JGkT8+ZDrkvslzoEBGxYT1IsXlHU=;
        b=ieT0dC94Sj3HYqE+3q+RnGHU3LiVQe0LLK6HnkcKRfuE3gErL91xV9Ko+I9EPyrQkz
         k4BJpVwWPKGkuSqVP2+lktqwuiC1HkFB6KdkBivAUi/og1+5s4qDhP6z0A1xfA2/1c/Y
         +QZ4FYgYEmEFbs/6XQsFva71WY0gduFAIPB6PWh0qE6k1ERgKkiFDyo6ppzCbzYUx+0e
         Ic/9IjdHT8vKhdgjkt2YH8tYEItEsQ26rOT3ZGeUVL3IdphSWXMvSVVGRZmkE2ovAIEl
         fEF2zQsF2oy1I6NgoBYqog8fQpsGh4hW5of3bMqvr9sS0UGFoDjw/msKpPmhLNl1ZrzP
         yJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741122904; x=1741727704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kp1l6lc9BxNq70JGkT8+ZDrkvslzoEBGxYT1IsXlHU=;
        b=WDgaStwhYh0C2E1CGpxBtk2RREU371m+rUPL9wbi/2/T8kKPQqpT5dSi216V6UwZWu
         5nJe1hPmnNZ+R1TT9GEKwqSWgXa3t8ASL9AxySGvwLN+Uc49IaRVckCUNoR5RLs83zaE
         v5t1r9yPgEYjKkDqTd93oriEefduPVR25kY6CXR1VUc2uuKZL9Y/pOXh73JSEvbG/j5f
         gUc/6ISZ6f0qMKsAzqv1p/VxL73UKuYmQiRI+DN9xqbmqwJ/OBW7YXYd7MHol6JK6EqX
         AwbCT04NPFML6yHXEf+CaydKmumqq4jeGV57rN468P9AaDAw1u18tmcBLiq+WMZLtED9
         14xg==
X-Gm-Message-State: AOJu0YwrdUhsClft+zR0zYM2l+8E5HrzWGnPD+CSyW/tJA2d/i5RmaQt
	cPYmWm4DENDiZDKPXzLhBVk3uzCPzeCFaKQrL5dGyK9bSnkAFyi3mBXrtw==
X-Gm-Gg: ASbGnctQDdIqFoy5huFVKqs2GGCJlA+WUJlAyWKElMauj0hq4xOfyjJOLjkjaBR8Rsj
	9JbOhDj/lp+9U7aYhSLXrFD6Qb48RA+ztPOI1+Te4z+4xs3ogMZWIgvoG0oVap08ymBHwxkKgaI
	WDQpQoePqiWz6ogO7tkY6hsa1Kj2KDESjJSWpO4H+DIN2B9qqqrMpQnhTWlbPK411plsVozu0MO
	KGM5dyzpbsKq0lTwG7iJ+bOrsNNm9AHZpRD7SOtDhT2UMoPyoFgpVURSZFxYxbJFSdfXeRkdsa4
	5BKaixmtBZmFVmfP3wYOoeCHP4T4rbAMBeZ+oa8Vhi6LLfBNt4/BLKhcuzE=
X-Google-Smtp-Source: AGHT+IHY4wg4WtJCon5UX3j/ZtVPuPFaIEG0AfK/Jn5Nnfxd604zHVz0y0+tMDAYQkIVUwnqmEt3lQ==
X-Received: by 2002:a05:6402:268b:b0:5de:e02a:89c1 with SMTP id 4fb4d7f45d1cf-5e59f4c726bmr492620a12.26.1741122904352;
        Tue, 04 Mar 2025 13:15:04 -0800 (PST)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::6:8902])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4ae60sm8582112a12.10.2025.03.04.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 13:15:04 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next 0/3] Support freplace prog from user namespace
Date: Tue,  4 Mar 2025 21:14:57 +0000
Message-ID: <20250304211500.213073-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Freplace programs can't be loaded from user namespace, as
bpf_program__set_attach_target() requires searching for target prog BTF,
which is locked under CAP_SYS_ADMIN.
This patch set enables this use case by:
1. Relaxing capable check in bpf's BPF_BTF_GET_FD_BY_ID, check for CAP_BPF
instead of CAP_SYS_ADMIN, support BPF token in attr argument.
2. Pass BPF token around libbpf from bpf_program__set_attach_target() to
bpf syscall where capable check is.
3. Validate positive/negative scenarios in selftests

This patch set is enabled by the recent libbpf change[1], that
introduced bpf_object__prepare() API. Calling bpf_object__prepare() for
freplace program before bpf_program__set_attach_target() initializes BPF
token, which is then passed to bpf syscall by libbpf.

[1] https://lore.kernel.org/all/20250303135752.158343-1-mykyta.yatsenko5@gmail.com/

Mykyta Yatsenko (3):
  bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
  libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
  selftests/bpf: test freplace from user namespace

 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 12 ++-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/bpf.c                           |  3 +-
 tools/lib/bpf/bpf.h                           |  4 +-
 tools/lib/bpf/btf.c                           | 10 +-
 tools/lib/bpf/libbpf.c                        | 10 +-
 tools/lib/bpf/libbpf_internal.h               |  1 +
 .../testing/selftests/bpf/prog_tests/token.c  | 94 +++++++++++++++++++
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  4 +-
 11 files changed, 138 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

-- 
2.48.1


