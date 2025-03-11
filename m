Return-Path: <bpf+bounces-53862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD0CA5D212
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994D618984DA
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C29A264F8D;
	Tue, 11 Mar 2025 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bww4wcmh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271925EFBE
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 21:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730071; cv=none; b=hXZzWru4UD01NTgXSIl4/UMYuY9EHwSBiPFz+Y7F64OwThdLIHlxe/d5NpPrRx5NlxS1HFlmVa4wRnk8T/cItt25yM6kDsc5ZirPa/ViqJN6oDBx8q3kN2dWL5/2Tse3RLrbFJJT5/S204kf9BNEaaMdwULCtfgf7IqcxfkneNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730071; c=relaxed/simple;
	bh=m69bBntmef+QWK7tm75KeQsSoJJEQlhQu9VlFYmYqXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGXfMdriDMt0tjYo82YnzAIxJA9ya8TE2LG0eQv9kVcH7HERitLiFAHv6Gb3vOP24d2qDboCpZaepiZkCO9q7mQPyW+h0lJGeepcR6f+YdI9PBgUsnFe9pBEpM8z2m7pNuzimyDi2zmx0UUY0WwiY8Wq6SNBrEYy13prywgmLzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bww4wcmh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4728210f8f.0
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741730067; x=1742334867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLEeMYLWEX54sdLQmpBkYwR4d1H4+ukfOsB6WXP2s04=;
        b=Bww4wcmhC9qZULoI6y0KkwxNBoe42a/bZpXiBNJU1emn2l975O7qEiZxZQjttuhMI1
         PsV0zKlcGkpw8YFYpWh2h+t8X7Mf/wNXWMk76pR2leSwRzqc4CHf/mrYcqZvVC9buByL
         S9iMp1jmBMkc9glcM4y06QUqFaKbK09d2ZNQ9Q6F8ItUOGmFRXo/diJNJAbsw1k2yG7C
         TuQiWPFoicSFXYBvk98ZBWUEuAL6C9tLjjV8FzHQKcNilzblac64CGfaB+e7d/NLToYa
         jlr/kRUfDLuquHJ7boHQylCT/Zt1WTfb9XgIyQOvkkux+azfsExW0cvo7miJ3+CUyCJA
         cRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730067; x=1742334867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLEeMYLWEX54sdLQmpBkYwR4d1H4+ukfOsB6WXP2s04=;
        b=bEfuk5OLEIXVkCgrQQNc9BM1HWI1K18iCwhC/PvMN9eaKXqSGhFqeUNCadWk5JbNV4
         O/KQDXg34EkH4dDI/rtNi8W/0KUUnwcHpnmnPF88Cpfb6/MuVRISqtEHaHgCJ7vZuPb+
         ZId6dIU/TUwc+C8oJGBHuZ0Szf3pU3ds7rtGKsR6HrRvyhLN0Smyu3KlybA8LVnrJdNi
         flcpSgWl9Wpms/qA3Y1lJO6fKJKVsFnRKqrgviL0KuXOXF+505ZC8JCzhB8YQFuY/yqr
         f6Hqkjq6buc3DvhKLEHn01fm8HelpknxnffvhnA26mN262/5jWG9pON02Mntry9ztSra
         KX4w==
X-Gm-Message-State: AOJu0Yzca02wAYPC+vLUw9g5OBBePSIuATNnnOPRjPynS3TgNwbqHR0J
	eVc+Gvu1l8s2Lu4PlPD0Q81tcJjE/iH+gx/oMcHrOnrXn9mnWltIjFfB9Q==
X-Gm-Gg: ASbGncuL8LoA3uv6cQTPffMpB+/0/pTrCAgM6+QYyXTVz1beDUzuQr59j4rqTY445nm
	gkMFBvQDwasZzTf+phj0CogNpm9dXKTI/4zZtlsH1zq41+/ixy0zGHWHHOMnAVCxOJrp9yxn0ce
	FIIlRp1crqs4O7opsI5G3qU98RMpE7/mNhm38yykpUMrbav4D+zug6sy/KEPhKYNhtxKqbj1b5n
	aPWyNXHWHqK0PA7tAgr2aS+8dUP6ZqutY8afmHps16oKbimvdXQVm6s7vRSaqy76FXf77gI/lMi
	zHuGEcuWLhqdUstzJm3rtYfL6amkSBiWmbeRU2kJ+PpuY/eAtlLKADNo/jSM1yXM1ExViPm33NS
	sOiJAFxPs5/jE9uSQ1rZJpRjBs6PTVotuSnuRnv+HnRGkus0Q7w==
X-Google-Smtp-Source: AGHT+IEJqADw+fqGwA8bM/5CvaNg7bDN7h7h+lgqxuo3zsTafiekc9L0umn2DxcXPdVMqXPXGadtAA==
X-Received: by 2002:a05:6000:2ac:b0:391:952:c758 with SMTP id ffacd0b85a97d-39132d2ac2emr14267103f8f.6.1741730067302;
        Tue, 11 Mar 2025 14:54:27 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd62sm18815549f8f.46.2025.03.11.14.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:54:26 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 1/4] bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
Date: Tue, 11 Mar 2025 21:54:17 +0000
Message-ID: <20250311215420.456512-2-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
References: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Currently BPF_BTF_GET_FD_BY_ID requires CAP_SYS_ADMIN, which does not
allow running it from user namespace. This creates a problem when
freplace program running from user namespace needs to query target
program BTF.
This patch relaxes capable check from CAP_SYS_ADMIN to CAP_BPF and adds
support for BPF token that can be passed in attributes to syscall.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 20 +++++++++++++++++--
 tools/include/uapi/linux/bpf.h                |  1 +
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +--
 4 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index bb37897c0393..73c23daacabf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1652,6 +1652,7 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
+		__s32		token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 57a438706215..188f7296cf9f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -5137,15 +5137,31 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_
 	return btf_new_fd(attr, uattr, uattr_size);
 }
 
-#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
+#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD token_fd
 
 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
+	struct bpf_token *token = NULL;
+
 	if (CHECK_ATTR(BPF_BTF_GET_FD_BY_ID))
 		return -EINVAL;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (attr->open_flags & BPF_F_TOKEN_FD) {
+		token = bpf_token_get_from_fd(attr->token_fd);
+		if (IS_ERR(token))
+			return PTR_ERR(token);
+		if (!bpf_token_allow_cmd(token, BPF_BTF_GET_FD_BY_ID)) {
+			bpf_token_put(token);
+			token = NULL;
+		}
+	}
+
+	if (!bpf_token_capable(token, CAP_SYS_ADMIN)) {
+		bpf_token_put(token);
 		return -EPERM;
+	}
+
+	bpf_token_put(token);
 
 	return btf_get_fd_by_id(attr->btf_id);
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index bb37897c0393..73c23daacabf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1652,6 +1652,7 @@ union bpf_attr {
 		};
 		__u32		next_id;
 		__u32		open_flags;
+		__s32		token_fd;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
index a3f238f51d05..976ff38a6d43 100644
--- a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
+++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_by_id_opts.c
@@ -75,9 +75,8 @@ void test_libbpf_get_fd_by_id_opts(void)
 	if (!ASSERT_EQ(ret, -EINVAL, "bpf_link_get_fd_by_id_opts"))
 		goto close_prog;
 
-	/* BTF get fd with opts set should not work (no kernel support). */
 	ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
-	ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
+	ASSERT_EQ(ret, -ENOENT, "bpf_btf_get_fd_by_id_opts");
 
 close_prog:
 	if (fd >= 0)
-- 
2.48.1


