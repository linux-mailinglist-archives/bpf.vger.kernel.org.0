Return-Path: <bpf+bounces-22279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE92585B1A5
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 04:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A011C2109F
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 03:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830353368;
	Tue, 20 Feb 2024 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VDtbfO9s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3A523E
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401069; cv=none; b=BTeAxh5bpOSyOr0GGn673qjghIqE4c+qN0r900EEKO2SM4T6GydrC5XAPlL6FCXRxykXNQ5Wo1MLY4Xa4N/JeYfESUP2eUOrjPuWdmbPkTjgpCwYj5LaQtarIJAviiHApXTU3Jg6kQv08Kx9CUqrbogei288ebkWi8o+XGdRYcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401069; c=relaxed/simple;
	bh=JyiRLKze27i/EWisJDgR5HNSiZboVQmTKOBRnTPQz+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owFiGllhs6ojiHC3K9UuyaJUt58z4DSgz2j/xio6Us5N9EajrIT/wEVT/hNQ2D7M/WA4Hs6l+AkLg0ZHW+Au1tAfV7dKcwBNNqet95XmgWfvGHQFmO/u1MORj8fVsYfKlStUpKu7XQ9vR/SDiIfuCGogxVRzhLoGPfgw0SOBKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VDtbfO9s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d7354ba334so45490645ad.1
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708401065; x=1709005865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8UkmNgftH857w2sqifeOqAr+iNHF37XOde+wq8ViDZE=;
        b=VDtbfO9sSLNSfszgw6LtF75JFQM+lVmXZmb4RtvenMDGVlROmM8+E6lfQYuL7uJ2+4
         GTth0jItp6iCjAbc2STIM/woni/k6mUDhHlH4D9DLVU2XGHkheocoF0Q1nCNxd6PIm6a
         aqx4i//cP51/Rps3LAbjVAUQ1QKzPRrQW0VS/3yf8YpG9eRJHD3shC3geFHYcZsiX5Nm
         Vj3KDYtKlZF4xSMRam9IZ2/dlRyeZk7XX1ol1N171Kpd7oDEBGvj5baR8RWaODlQbmN8
         FSVdEvt2gXB6PYaBPyBJWj8jT8hhXWRn2IJynbZA9g+IXi2s09+kmsfIYBLooAkyqgf1
         FdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708401065; x=1709005865;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8UkmNgftH857w2sqifeOqAr+iNHF37XOde+wq8ViDZE=;
        b=bGHSYP+9itrabxaFkLe8T+rzSBGUYkI/qhJmQHHF9hYI+CWZ+hY2PNwzskfe1ZTXzk
         le+PGoGkwh3iDfhJVgz6TxJn0Nib6g6sh+9UBFTSuoR3MSrsXdWn0sqA69XrtuFuVd9M
         MjTeHCV91o5tpEjNUw7xu5x1+C6uxG8UmjeE0+Bc0q392HgZlAdQvfiMgqgMCiz5KcI9
         TJU3YuYoDZwOzz0w/kLPIDFxbn/o1bqxKBCeNuv0HCsgFiF8GjxotBXlR7yglOghFn42
         TlIBY4EEHtQ8OhS4raN63LuNyg73KSMGKoWRBV6FmpM/ju2pZYfGJqSZy+MdOuPFmtAW
         cZMw==
X-Forwarded-Encrypted: i=1; AJvYcCWmAO4jUlyc6koisYqsmJ9RFAanuE/eom+YHUI8ZBAYXbYHPs3rsw0RHHQihxM2Nw9zgqeEwx/ZHoxOuuCr1n65a5X7
X-Gm-Message-State: AOJu0YzfDs0hcZSpm0t6MpXlOypK+pIHN3CKbPmCAOvpBGA1HktMcVw9
	YldHYU6lZgMWH5HUBC56L+QXjbIhc/PL7K0V8dRnZIbb14KLeXAXksPGTbT6bFA=
X-Google-Smtp-Source: AGHT+IFahjx8Wl0J1qpYL1S67NT7dQm8quAfM53FT6LDzNXvorRUNHjgFtfIKe9Dezhf1ddJbvtSYw==
X-Received: by 2002:a17:903:1104:b0:1db:37b1:b1a3 with SMTP id n4-20020a170903110400b001db37b1b1a3mr16490922plh.17.1708401065669;
        Mon, 19 Feb 2024 19:51:05 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id jz7-20020a170903430700b001d94678a76csm5131723plb.117.2024.02.19.19.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 19:51:05 -0800 (PST)
From: Menglong Dong <dongmenglong.8@bytedance.com>
To: andrii@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	thinker.li@gmail.com,
	dongmenglong.8@bytedance.com,
	zhoufeng.zf@bytedance.com,
	davemarchevsky@fb.com,
	dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH bpf-next 0/5] bpf: make tracing program support multi-attach
Date: Tue, 20 Feb 2024 11:51:00 +0800
Message-Id: <20240220035105.34626-1-dongmenglong.8@bytedance.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed to
be attached to multiple hooks, and we have to create a BPF program for
each kernel function, for which we want to trace, even through all the
program have the same (or similar) logic. This can consume extra memory,
and make the program loading slow if we have plenty of kernel function to
trace.

In the commit 4a1e7c0c63e0 ("bpf: Support attaching freplace programs to
multiple attach points"), the freplace BPF program is made to support
attach to multiple attach points. And in this series, we extend it to
fentry/fexit/raw_tp/...

In the 1st patch, we add the support to record index of the accessed
function args of the target for tracing program. Meanwhile, we add the
function btf_check_func_part_match() to compare the accessed function args
of two function prototype. This function will be used in the next commit.

In the 2nd patch, we do some adjust to bpf_tracing_prog_attach() to make
it support multiple attaching.

In the 3rd patch, we allow to set bpf cookie in bpf_link_create() even if
target_btf_id is set, as we are allowed to attach the tracing program to
new target.

In the 4th patch, we introduce the function libbpf_find_kernel_btf_id() to
libbpf to find the btf type id of the kernel function, and this function
will be used in the next commit.

In the 5th patch, we add the testcases for this series.

Menglong Dong (5):
  bpf: tracing: add support to record and check the accessed args
  bpf: tracing: support to attach program to multi hooks
  libbpf: allow to set coookie when target_btf_id is set in
    bpf_link_create
  libbpf: add the function libbpf_find_kernel_btf_id()
  selftests/bpf: add test cases for multiple attach of tracing program

 include/linux/bpf.h                           |   6 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              | 121 ++++++++++++++
 kernel/bpf/syscall.c                          | 118 +++++++++++---
 tools/lib/bpf/bpf.c                           |  17 +-
 tools/lib/bpf/libbpf.c                        |  83 ++++++++++
 tools/lib/bpf/libbpf.h                        |   3 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  49 ++++++
 .../bpf/prog_tests/tracing_multi_attach.c     | 153 ++++++++++++++++++
 .../selftests/bpf/progs/tracing_multi_test.c  |  66 ++++++++
 11 files changed, 583 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_test.c

-- 
2.39.2


