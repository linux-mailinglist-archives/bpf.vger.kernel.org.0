Return-Path: <bpf+bounces-34177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777692AD2A
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 02:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE2271F221C7
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 00:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC9428366;
	Tue,  9 Jul 2024 00:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="STOLTzNm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3321C2D;
	Tue,  9 Jul 2024 00:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720485650; cv=none; b=Tg2u8eR/xjcyoezqcRfnTRp20BcYwaUa9ZtSoAOT6GaSnx2ZNaWbu/OklxmsQgSyiW2daDnXWwWQfUc+mF4w4Ruxwo2RB/6aBMf4x6gDMM02AV5xu11QCa5m5GLbypgXlJmR0WGBr37mn7lH5iftseu39RqSGfDcHBxH3yKi+X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720485650; c=relaxed/simple;
	bh=iTy2Cq2yqwTi78Jdpj6ObOvuejO7RbgJgFLPjTaDa8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmkcMCuiHrDAnMQw1vULEMaEtE1ouKq8eSh09ItTKSslODKex11rNdyX1ALRRUyNc6wQxq1O/JVIwSg0/wpUVLwiKnxAN5+EK+6ykf5Z6KbL1gNyrx9db9eHmoOZkLkBEuv3hi8PP7UP9D6iuXXCzyhdqNYb4eh1pfmP5mHZUDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=STOLTzNm; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70afe18837cso2687431b3a.3;
        Mon, 08 Jul 2024 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720485648; x=1721090448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TefAfK5dIgKaK+KnNKZuIKyjF1nQedbcnMOk0o6YRzU=;
        b=STOLTzNmPJ+CTYCyls62m8c0aC48u6XzDKUHLhzriJVcOfLpsJ7WkRSmw8kvuFBia7
         FQ6h2fdWDzmv3TErgXf096jKB66MdGMuS6QseNyDbfAM825Adf2S9x59J1kvNHn5K4Wo
         aomXPdnk7TkQnYpHufYYmsxUH4XDwzOe792q+Jm6M08reTBi2qe7sOsIVkZ62dvomKhZ
         /yP3suWXvXuUhxoptQxK8iqzDpe/I4UahXx/09JUSGkz/7Q8n3HprtYZRAHElyZYN/hJ
         XpGXOeun5fsbiFr9tPMDqLsWiJ+27mY9lXIYf5qTfKAUreGGvlGWdHirDI3QCJ7V0FPO
         Ok0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720485648; x=1721090448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TefAfK5dIgKaK+KnNKZuIKyjF1nQedbcnMOk0o6YRzU=;
        b=VBAQbPxamiR4rCkbd0l93mRWRDZ5+PIyoy5uKDFm2rgTwMSycakIL1poEmo5apr99d
         4Pe5joiKe8p5f5ReFA5DOgRH7/bJEHnqIZO5dC1sn41v6UDGyXYV4qNvG3nJcMDrvbNU
         08T+lL1HzyCBJOL+V3XIkrzShgclkpm1buMuB0hxj1Z17p+ZGXeDp1OGQ5w5NX7BSLHE
         NfggAulQpRoZ9XnGFU/dUYzvn6KCArziwYknEBXY/zEd6dT6lSsuWd8vqtUQlxIhDHFO
         Qr27rQ6Ri1MnXBh10aoaUdwA7N0jkR0CBnttq5eYRWkJnFCk7tTXQHOC+o27QtaIyblg
         WaQw==
X-Forwarded-Encrypted: i=1; AJvYcCVwwq1k0XRCwfbMht3xG5a9S0eTIUumT04k7ogQgDJAvfiyYshWOUDwsBYzBdau/VCArqZD0yI6P6IddAs8IucghRa+
X-Gm-Message-State: AOJu0Yxto/tIQcAF76bik1TheqnLKUhCnn7Rb7VtkJhzT6xezLDwoGsl
	nyD/D19x6Q6RAcFxMkSQfmvYNPW2nXXFJ084Aw3hcMqKxr2VciKbEXgh+g==
X-Google-Smtp-Source: AGHT+IG+vkBtCHt5q4kVZ1+uFKDMNkZK4xSjLkrclGyLBCgE26ssAGuJmk8SHiUuR2hbzRqKEKmzMA==
X-Received: by 2002:a05:6a00:2e87:b0:706:747c:76ba with SMTP id d2e1a72fcca58-70b434f6409mr1406362b3a.2.1720485647796;
        Mon, 08 Jul 2024 17:40:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439e3a45sm487632b3a.186.2024.07.08.17.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 17:40:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: ast@kernel.org,
	andrii@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	void@manifault.com,
	kernel-team@meta.com
Subject: [PATCHSET v5 sched_ext/for-6.11] sched_ext: Implement DSQ iterator
Date: Mon,  8 Jul 2024 14:40:21 -1000
Message-ID: <20240709004041.1111039-1-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DSQs are very opaque in the consumption path. The BPF scheduler has no way
of knowing which tasks are being considered and which is picked. This
patchset adds BPF DSQ iterator to allow BPF schedulers more flexibility in
how DSQs are used. See the 0002 patch for more details.

Changes from v4 (https://lore.kernel.org/all/Zn9oEjsm_1aWb35J@slm.duckdns.org/):

- Comment added to clarify use of naked list_empty(&dsq->list) test.

- scx_qmap changes separated into its own patch (0003).

There are no functional changes since v4. I'll apply these patches to
sched_ext/for-6.11 with the outstanding acks.

This patchset contains the following three patches:

 0001-sched_ext-Take-out-priq-and-flags-from-scx_dsq_node.patch
 0002-sched_ext-Implement-DSQ-iterator.patch
 0003-sched_ext-scx_qmap-Add-an-example-usage-of-DSQ-itera.patch

and is also availalbe in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-dsq-iter-v5

diffstat follows. Thanks.

 include/linux/sched/ext.h                |   13 +-
 init/init_task.c                         |    2
 kernel/sched/ext.c                       |  244 ++++++++++++++++++++++++++++++++++++++++++++++-------
 tools/sched_ext/include/scx/common.bpf.h |    3
 tools/sched_ext/scx_qmap.bpf.c           |   25 +++++
 tools/sched_ext/scx_qmap.c               |    8 +
 6 files changed, 259 insertions(+), 36 deletions(-)

--
tejun


