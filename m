Return-Path: <bpf+bounces-54311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C98D9A6765F
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C942B7AA886
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0F420E02B;
	Tue, 18 Mar 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="WhegMnI/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1535A20CCFB
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308190; cv=none; b=DM9lJLfD4y90Piu3RjZg501e4nbUoA9gYlDgW7XoYoLpYSQr2YmKqfq5XEXl2julg6zed3SHQfIlRrTPszJPmWpS63HvjfRqv+pniBr3qU+rqAvNQYZQPQ+JJGitqGTIWHYuLJ0MsIsBXIPwlRhxveKpX/DALnVLjjkxjftsCcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308190; c=relaxed/simple;
	bh=I4LY+cqLvwUR/TRGmE6u+0liEHnL5cENUJTMDN+D3xA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tFklaA8rD9U3TDIgLq41BfqoG1Vdmddm6Rc/fVnap+kPqKkoDEAk5sNireN18n3fy+ArRYQsLLSGs/TgSxZXLwhUd4aHjRn3hzIeXtZsvmHDsocHEWkm9BjEmb2Sc7sw87JvMmpM0K+MrmjRtY5T6urWEHN1B1WXSks06gTF+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=WhegMnI/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3913d45a148so4989332f8f.3
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308187; x=1742912987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fih8+biZ0X4c+tlfxWMaqxHBtWUHW/OAk9eruAwiD4s=;
        b=WhegMnI/4ootHqbgxTd+u+8sncno4Z8mLRL9lX6is//GgSEbZGIHIr49+YcuFN0ZQb
         Re25rhHhoZzNtzGxOlwDFcxZ0u9ZefEMKgubKNehXj+CvUtChM2g//+HFEXCxSeYnoFf
         gdLghdCosuzHQVdTuA3mKp22ef4sirkBckX3iwI8Y6yaJmLwobO3bgDPByf/f9oXgNRI
         BhytLvMo61Rrc5X2tCHV8lIUU3Ikh0+mJ2h6au3LxVmG4DV2n+JGcPnR97vkuJTWn5H5
         IocpHpgMom4AmYHgPpY6rzaWTUIYzSCuHqaienYW5JJsvZ++lpFpT4ZWzVGdzbGvGEBn
         0WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308187; x=1742912987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fih8+biZ0X4c+tlfxWMaqxHBtWUHW/OAk9eruAwiD4s=;
        b=uHWqOsyZjNxlj79Zcn67XUbFq+1FW6O1ObYIvezXRZtewWrQk3N98f7F3aTSHSDVrg
         kKvtVkxMpKIOaVxX1TN61uGQmIAg1qN6mhqtEBx+Vgv7+7CaeTz7+UnHnYwgir0WCUiU
         Lz7NtkoTq1yHguZkwRSonQq7H8bv105HFzgwVWS3WnswmLPwDL+u0K2FJpPE5iB5Ud2Y
         auq0TiITvwqCfxwSpFtXMOw7SSfRI6VJGl4FUHDxDQpLjWaw8Ywt38WcFXEzvVGZ2pF3
         I7N1t65bdA1XJpt/IObCqX9ED9OInPRcK/3G3M/xPk0NAFWryQ4oM8CI4rVxpuyVGpne
         1C5g==
X-Gm-Message-State: AOJu0YzRh7JeW5e10LmKq8WRDj6WeCwi4awMyyxEDzMThMVw9xCnA2pA
	EJ0e7ATrbt8vODnUPaADdbOPooWvC2wjMyloxEVOxeonAww2/ILw0cGXNSGm/Lr+3zfIjcno4hK
	J
X-Gm-Gg: ASbGnctY0niOPvH8gmpy3pgU5bbcZPofg6LBwC1FZmwehMwBJ8YvpOv8eurRIATld94
	gswZOfWsxK/vVxv7bzZaTMqPHY5zAi0clyUQ54e8ywhomBZBKFke5c6A46aOzVpVIG3C3Eptb0o
	1JNPdodCd/KsQQwNEx/GDzQWmFBFhMzgqTR5VsjdZzPPp8Va0/WXdjypRgfiz9j6OZG2268aYGX
	9IWzRdJlWy+A7vlcvgCgmH5G5oaTSdMSypeLsKtllw7sHlAgF3hYqEnNGjOQnmn5Nq+A/OkEyfX
	WwL36BKkaWCraFFZUap4z+6mXUjt6iGsTmZC4NIgnY6Im4wDcwEyvsluPsiAP28nJrWx
X-Google-Smtp-Source: AGHT+IF/OtczPGHmjq/e5V7LyV+kK2V0ht8PfWgO5LEAq9J5xh8v7C6jPUav45n5IKg7RSr9G9TCXA==
X-Received: by 2002:a5d:5e0d:0:b0:390:ebae:6c18 with SMTP id ffacd0b85a97d-3971d237919mr12237652f8f.12.1742308187102;
        Tue, 18 Mar 2025 07:29:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:46 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 01/14] bpf: fix a comment describing bpf_attr
Date: Tue, 18 Mar 2025 14:33:05 +0000
Message-Id: <20250318143318.656785-2-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The map_fd field of the bpf_attr union is used in the BPF_MAP_FREEZE
syscall.  Explicitly mention this in the comments.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 661de2444965..1388db053d9e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1506,7 +1506,7 @@ union bpf_attr {
 		__s32	map_token_fd;
 	};
 
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
 		__u32		map_fd;
 		__aligned_u64	key;
 		union {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 661de2444965..1388db053d9e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1506,7 +1506,7 @@ union bpf_attr {
 		__s32	map_token_fd;
 	};
 
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
 		__u32		map_fd;
 		__aligned_u64	key;
 		union {
-- 
2.34.1


