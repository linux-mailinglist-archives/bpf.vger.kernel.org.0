Return-Path: <bpf+bounces-45680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00899DA072
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 02:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BADA165A7B
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D7F17BBF;
	Wed, 27 Nov 2024 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrekFJ4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1838C1F;
	Wed, 27 Nov 2024 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672221; cv=none; b=QIq0tOUFFOoz7sKEbrNLxKB0DafjkpuLoKn1t2a3snffyHJUsTMo1TCW/WBMbUU86u+rOVPgmo8Bxg/N+KJFSY7PQvQ/4dxwbtDutsZSs7g3yVN41YInAv2agZL87mRmdnJvLWp73kpJvxWnrNX6qf3CLKkc+/QclCNEg9sRM98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672221; c=relaxed/simple;
	bh=gMRhOUu/z58Nh7afU0fuDYnIZRYslj7PCIccqzuEhC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hm6yDYgtQo0pPHOJIRBZpliXhzAW0fHugK3Rz7lISodhc5pnuyDD5qBuALdijThcc6qAK0prfQEu1DskKijSJrv3QkKAijyUL01eUz3fGJLHD3ZYKH7pzXxtD1UQhNmulll0Ei6CLaWcy67163k0UGtzIxpa9VIjfYNFvQl07cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HrekFJ4W; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7248c1849bdso6321395b3a.3;
        Tue, 26 Nov 2024 17:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732672219; x=1733277019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iboirn07jyawzq1taoDeBAaznZev9oVgPRWrysfGHWE=;
        b=HrekFJ4Wd+V4dgPg3fVB27kQVrVkYMnT14ubMxUTe3wmdOWaadoGSZLI8989fPyGoY
         1u30TVfZiWcNk3k5Ml7liXDnQlSYVZlIS45xLe/VRc0UbhRUQ6kYxnHE808VVvOWUlQW
         DADEgknoGlbc28UhQ5kJqB4BcUOdKUrAn7HU70L0Rbhg/zqKadZwt0jgrxBNqPv00GF8
         dSruahjekxp46m+9+TKM0QWTUNH8+qPfgn0F0F3LfbluoO7yMcxk1tYRHQcMb903SZ0V
         Uj/CGcxIvYJxmAkfG6fa7EXo2i8JUozAnRWtRFQR1SqqTA8fY2Dc6BAkVtxTuwwr0d4a
         gdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732672219; x=1733277019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iboirn07jyawzq1taoDeBAaznZev9oVgPRWrysfGHWE=;
        b=Um7dmTUQC6Eg+/jjU9//KPjK5vRTQozXxmCIo9r+for1Uv3hmYuLSith2xImeZrAoD
         1m752vlG30KgK0z0ha78jYwq65twHv/wV5BgEYGGvbrEC0fAE+XYPxzGOR3RkFt0+Thw
         6lrVY6LbWKzv0Bvwopa4rXP46PaoUuzFke9+mx/uNz+Z5WYTDFL0iu9HcbZn6hIZ1ajN
         0Rin1cvzBKSodfTU1DjzDLhKdHwTb5TcrS3uCX0DIssKDpp07jfV5slYAlEGNL7VjAPQ
         fSj5pB+FJonqsCfOpuPGet67c3uK1yaQyvn7u+IHEFKDLEPv2Evyv3z12YKQKpD0zxnB
         8VHw==
X-Gm-Message-State: AOJu0YxCPGfLe89H/VAAxN2bOW5Sop8MaWLN03yZWOYVNi4vabp5IvaW
	ni2UEAZiI0U5s/USZRHHccsKW71lNBNKHyMGlFcT40WVop5uuzAKpJ4jaQ==
X-Gm-Gg: ASbGncuMbHrOaBqDPxWEu7K6stV9SucZdbVn04xu30CIrVwIrhVYIFRqfsjiHFmRTtx
	6GNv+nZerNlqcf04UrdJtnA+RAQqX8NfCJgXT+XKKbQW1Cf49l+VA1TQDDw/Q58Sx6D6Wm7Xz0T
	iYqcqqOGtVOpGBjyJPhcYld5ZW74SAeSKYP65/AFD4IqqrC6djS2nUwGlK5YQUcqa4+mNumB/r2
	8my8O5QfyG6e0R1rS+WzQdexpQM5Yhawz5q2oUECIwg0w==
X-Google-Smtp-Source: AGHT+IE18WdT7pS2RVtTlVgMkf17H7WDvWf8eiUNlmg3ytJzLx1A1JmD1BFLbIlb9BBl97iBxlgaSQ==
X-Received: by 2002:a05:6a21:33a1:b0:1db:ddba:8795 with SMTP id adf61e73a8af0-1e0e0b7d919mr2594772637.36.1732672218679;
        Tue, 26 Nov 2024 17:50:18 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724fcdec956sm6312435b3a.25.2024.11.26.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:50:18 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Jiri Olsa <olsajiri@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH dwarves v3 0/1] btf_encoder: handle .BTF_ids section endianness
Date: Tue, 26 Nov 2024 17:50:05 -0800
Message-ID: <20241127015006.2013050-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, pahole does not generate kfunc declaration tags when
generating BTF for ELF files with an endianness different from the
host system. For example, this issue occurs when processing a vmlinux
built for s390 on an x86 host.

To reproduce the bug:
- follow the instructions in [0] to build an s390 vmlinux;
- generate BTF requesting declaration tags for kfuncs:
  $ pahole --btf_features_strict=decl_tag_kfuncs,decl_tag \
           --btf_encode_detached=test.btf vmlinux
- observe that no kfuncs are generated:
  $ bpftool btf dump file test.btf format c | grep __ksym

This patch resolves the issue by adding the necessary byte-swapping
operations.

Changelog:
- v1 [1] -> v2:
  - avoid modifying the 'idlist' Elf_Data object directly.
    Instead, use struct local_elf_data (suggested by Jiri);
  - update the description of the .BTF_ids section (suggested by Jiri).
- v2 [2] -> v3:
  - use elf_getdata_rawchunk() instead of direct conversion loop
    (suggested by Andrii);
  - removed Jiri's acked-by and  Vadim's reviewed-by,
    as patch had changed significantly.

[0] https://docs.kernel.org/bpf/s390.html
[1] https://lore.kernel.org/dwarves/20241122070218.3832680-1-eddyz87@gmail.com/
[2] https://lore.kernel.org/dwarves/20241122214431.292196-1-eddyz87@gmail.com/

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>

Eduard Zingerman (1):
  btf_encoder: handle .BTF_ids section endianness

 btf_encoder.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.47.0


