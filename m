Return-Path: <bpf+bounces-22122-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBB98573A2
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 03:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 318FD284898
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 02:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E74EAC2;
	Fri, 16 Feb 2024 02:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA6jm+Z5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8AF9DB
	for <bpf@vger.kernel.org>; Fri, 16 Feb 2024 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049036; cv=none; b=Y8euqSLsbgKPAChZMez0yqDhpUXJSC7iFOP1ekExnk+m1cKHaXeLd8qmmFeNGFMmPZ3oYd7cgwDEqEXu3j2n3hhYjEuwOdcuphqq5N55fTXtxTO9/UKgmLe1P11dSrDziF06i0R9erk4E9rOP+l7Xo+EgiouVFDdCRyQN68R8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049036; c=relaxed/simple;
	bh=75/ZAHxSMiV546ouDnXqiBsYMXjde9zCYTo1JDebkcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ghSdaXskvrn1DRBcx8GgCPI1hEY0R6xqTUZ6Jy1iYn1bzVfUxES+iYAyfInj4JruZTrFOzlSZBT05RYdXO9GDovs4/Nxk0gOnwEkqTrYv6k8K/7uzdXNE/vYM8gO4aN9HVnxD0fedo+DtIbhEuf5qv4d/+v+13x0WTxjrxbQI1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YA6jm+Z5; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso1689969276.3
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 18:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708049033; x=1708653833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O0WExi8ewTgWgfVxQjijS2p/prQkW/3Q1IY6QnrZUy0=;
        b=YA6jm+Z5W9Uu/beDsPcyuiHzB+wf9gHHBIeieLCubIy7fIuyq0tAqyemlokBikpHlY
         TU3gIsNjGr/xyVK9iU/bAVP056ijm5IVBXa9rgg2O/HBMY9ErZzZ2/T4jHwWXstovp+C
         teI6bcvVwbsjdfgEhixDHcIkuEYMiSYNaTKftCSDNu316FSfx7G8ptZEZKZz2qAOF68z
         ZxUZqgPQm/gZOGk3ladd48YmQB5i82cQ88B0IUavcVl8f/ytpNttUSc6S+R+anXYClOb
         fV5arugGvVrjSUD4t6uWz3eh7WCD1g75Ytvq0hHlgcWMeTlTwWFOTY3iDqnfv7NDPaH1
         rTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708049033; x=1708653833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0WExi8ewTgWgfVxQjijS2p/prQkW/3Q1IY6QnrZUy0=;
        b=cnYYqDMqVFGmXAfydmQIJS7aALv2ZjBLt0co3geNEmn0cLUIRPh/SyQeFrvCsBXxrN
         rxearzScJNHf+M6I34tkHxauGiBsVEGMW5XXTynxmVTJxBpct5641ebOgOqnFpie0NmM
         ydmdPxMkeiPxLMkGBUENtJgXR2qLZDJOVY0TQyBLNsKGNm/pC+h7ylf/NF7aYS/MakQz
         wb2YmVJRsvbVezYpu0rMsOinWRjVqqQzO1hHfyX6LaxlPHP6eIWtPhyJTzE1G4J5wgN/
         ZqNNVdgNGB5vMjdA+ihqxKP0yBUDD0j/2OV1QZnSup3S7SJSIl+io1CkLwyj0hIG4dJa
         8hzA==
X-Gm-Message-State: AOJu0YzzUo5xEDtf1wMUCsf7FtKXJBVLymCACmQt7hl7rke3ImkgsSy8
	GaqaoNK1smo+AAqSwR5yuQWALeXxbtyw5urLdxGJD0MUmDqZIFmom6zICXyo
X-Google-Smtp-Source: AGHT+IEeNfrEKaXa9uLGBOb/KsGvvkmbWGTkXOCN+A16Q9ZCmpEtres3RvF8z/2Oq7Vw7qkHaJebYQ==
X-Received: by 2002:a25:9383:0:b0:dc2:48af:bf09 with SMTP id a3-20020a259383000000b00dc248afbf09mr3310111ybm.62.1708049033068;
        Thu, 15 Feb 2024 18:03:53 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ad0b:a28:ac5d:fc77])
        by smtp.gmail.com with ESMTPSA id d71-20020a25cd4a000000b00dcd2c2e7550sm133211ybf.21.2024.02.15.18.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 18:03:52 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v2 0/2] Check cfi_stubs before registering a struct_ops type.
Date: Thu, 15 Feb 2024 18:03:48 -0800
Message-Id: <20240216020350.2061373-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Recently, cfi_stubs were introduced. However, existing struct_ops
types that are not in the upstream may not be aware of this, resulting
in kernel crashes. By rejecting struct_ops types that do not provide
cfi_stubs properly during registration, these crashes can be avoided.

---
Changes from v1:

 - Check *(void **)(cfi_stubs + moff) to make sure stub functions are
   provided for every operator.

 - Add a test case to ensure that struct_ops rejects incomplete
   cfi_stub.

v1: https://lore.kernel.org/all/20240215022401.1882010-1-thinker.li@gmail.com/

Kui-Feng Lee (2):
  bpf: Check cfi_stubs before registering a struct_ops type.
  selftests/bpf: Test case for lacking CFI stub functions.

 kernel/bpf/bpf_struct_ops.c                   | 14 +++
 tools/testing/selftests/bpf/Makefile          | 10 +-
 .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 ++++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 93 +++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 31 +++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 7 files changed, 170 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

-- 
2.34.1


