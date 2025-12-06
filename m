Return-Path: <bpf+bounces-76220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B67E3CAA856
	for <lists+bpf@lfdr.de>; Sat, 06 Dec 2025 15:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EDD1310E3D7
	for <lists+bpf@lfdr.de>; Sat,  6 Dec 2025 14:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D5F2FE07F;
	Sat,  6 Dec 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmHhnHMJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59878280A5A
	for <bpf@vger.kernel.org>; Sat,  6 Dec 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030359; cv=none; b=AQedsZCwAv1jPAw3/NLMbnEaY1jrSS7B3CRbyns+o1Ea2+B0wSKjhFk+QBdMcSeDp8iHVh4lkDw0BLXSnz3g3SJnO8FyITXUFB6KQgsWP26BasLWK1m4lyBb6QzXyRKSGhj77HAyWSHnLpYo/8CxH0jm/DrEqU9n9LQvmk3c+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030359; c=relaxed/simple;
	bh=S+igu4aju7EwXWFRbjCCQgO7Bx4KXZSG7GeZGRqJ1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKml10v1FPa/py21wFMYPkeiaPglDhtwPz3S2uROxLH18SeO9FKeQF3iQNvn3yn9pnfYm/DO2xA8TtieeRxtbM6mud0UaPbVrzXL7+lmI3hF1ZW7fnkHSGizXclMwGtFt/6MVsu/hQYJfqmnYeYcZQRQpo5hSpPYsyoFHYUI8CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmHhnHMJ; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-640f2c9cc72so2826210d50.3
        for <bpf@vger.kernel.org>; Sat, 06 Dec 2025 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030357; x=1765635157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=GmHhnHMJtWXo5n9JfVX7awchSCfxN0g9ni8gmCegbPDs/e53eS0IOAmVGEuZot+rSa
         JV2GtmuVczlxmjS8CQCGvkN0JjMqGlIpo0RNGgQXztIsMZYYCkRFcqJDlnWSmfl5URtc
         zloliAFuImbfZqC2o07VWMhrYcucQrnnQ8+Tdoe0Ng7KkNrxEai8pByu5PLmaJr1vkTl
         v96uNKBpGlt7n7yflVkrYvwdHn6ruQMDVDjoM1wqwFb71AR9JA4LgljVUePly0p8x5vd
         0kfBxp0ivJijzhOwD7GqNSrQpf9h9qlnapG0OLtpWe4NAde6qhE15/z0NR0jHeA9+E+b
         6xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030357; x=1765635157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=fCmrIsfzRAqfG1/iGSdx5553wUBaG1RykVizlBDOsdcbZzoP3ldnuyi6kNmBAzyWER
         MIYANk1UJpTDgpXwhxpijgXo49dDFxsj6MOPrIoVMKXh7FXXv8F4bKcMvddEg/+gTcHQ
         3Bd0AmMSidMiNyVkRSQfC3m64rlnqVU2Fx5bdRuWcp26Gebrf1qUp7iRj+68AH6TfEMX
         iRUPBe2dkGDHhCd/6sQ2bbWv8xAeO6vDJuYALqdYVOwZpKuKCF/aowIlPTdheydjkrw7
         cA3rLyQ+8r4Ixn8bAiDrmtGrii/g34iCoF0drsUm1jafv1rbRPK9I0SxiwYnkFpKQ0IL
         o1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtz/QG6YIAMBf5Unf8qBvKnR+R7MinTyLTAgbf5shFlg2/8B7RcQOaAQcJeKYUe1F4pqA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz86repRoUEGBz4/kh5jHcuVxWYVU7ySyXzRrT0XEVWYH3q/pVu
	rOpNt1g+b3o3JtvB6LXF6+KdcnPqJYmx/K14NmfWwtMEf0CIj8T4NdLe
X-Gm-Gg: ASbGncsjTiJWaOusezxVyjbNWheThYoMnXD9QCJgwdrO2QhoZXGTW08uoAPXda9oZZ3
	3BJu2LbkaOnQH4vHROnp7rNfxdQrTvtwD3oPEpEvgJkhuGsf8tvvYUg3OSvGSoKix8s3kNleUwC
	SRTVz93IFBWs48G/6IooJIhRVkbXTO+QWSIDgI9nXNLenWSL+YVoxVdiu9JqeqZ0uL7Q94Fcn9+
	ZU3guzO8G7078nxNKmj94psOQS/brTGUdw+hwMb1A072LD/laQthcCnxElIJi3BKUBxcK+Kh95X
	9kQHb+Fs2gtNLZvXNXPulCgShFtXaQZCJH/FuLAEIcRfOXno4iA1N637A40a3K0ny8mmZxEfs9L
	iWLNAHWwm2He33CtjZajaJq57QT8FuUkJTADdq5M/HL3IjkKhEJrFlpUrKY+N9T6HIrlvtqgtB+
	BOhJPgMpH+lPDkReQhzymy363Yt+Vx+HJFbjPrw0B1AdbWVSwXFmr7HUzj+DNKnA==
X-Google-Smtp-Source: AGHT+IHuF83mFXlkaMu6oHm6oMBi8mfMFdfNONlXiyds7RYNVDtirN1s6Te2e+85GpStdEubYV2j5g==
X-Received: by 2002:a05:690c:64c2:b0:788:181b:869e with SMTP id 00721157ae682-78c33c171bemr42202787b3.40.1765030357161;
        Sat, 06 Dec 2025 06:12:37 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm28038027b3.3.2025.12.06.06.12.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:12:36 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v5 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Sat,  6 Dec 2025 22:12:09 +0800
Message-ID: <20251206141210.3148-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251206141210.3148-1-electronlsr@gmail.com>
References: <20251206141210.3148-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") started distinguishing read vs write accesses performed by
helpers.

The second argument of bpf_d_path() is a pointer to a buffer that the
helper fills with the resulting path. However, its prototype currently
uses ARG_PTR_TO_MEM without MEM_WRITE.

Before 37cce22dbd51, helper accesses were conservatively treated as
potential writes, so this mismatch did not cause issues. Since that
commit, the verifier may incorrectly assume that the buffer contents
are unchanged across the helper call and base its optimizations on this
wrong assumption. This can lead to misbehaviour in BPF programs that
read back the buffer, such as prefix comparisons on the returned path.

Fix this by marking the second argument of bpf_d_path() as
ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
write to the caller-provided buffer.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..49e0bdaa7a1b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
-- 
2.52.0


