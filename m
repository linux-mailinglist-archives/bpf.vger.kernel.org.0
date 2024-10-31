Return-Path: <bpf+bounces-43643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392EA9B7B55
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 14:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A39C1C2122A
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 13:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445419DF4C;
	Thu, 31 Oct 2024 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmThJNlW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC106156236;
	Thu, 31 Oct 2024 13:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380029; cv=none; b=tdd2fm1Ir/3rhDOth4OcMjebGXt8doSeXwO3Nxi52lXxGVEvYirpHQVbtXTmAgn0hgWHKXi1uFSa1sWTJ63yfUfqJ6z6arrykckxAbAwAL3DxgEMC+utJYqmrrxH90aTYIi4r/Wn92cFFHP3zrxUbanaJjn2wvKIpxaQGx1YBrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380029; c=relaxed/simple;
	bh=Tim3WVZenUhdKc8y4bMjs9f1hfD1ZanodE9C+MQsCJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aP8WmoyAvPinrFY39WVWqqWEoLYT052pylZtIPvXG2VcYOFQApbb8YSm2o382dF16e0HjMRTLAU2hKHnR8vT8v2E/PLjZDlBcdiDgVON49nVUj2L3aOxxpbeUu9vRpnQSdZGQZyTMIUYyMX008MIU2hI3uFeQS0gW+XEIUrCxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FmThJNlW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d47b38336so727565f8f.3;
        Thu, 31 Oct 2024 06:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730380026; x=1730984826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DPzvubR4QyGZSA0yTPPpltAG7w4LTcpEG3Z5c7g1ktY=;
        b=FmThJNlWRKBhLyRztIdRN9lK3XdRW7Oa98IvCaObLaZwkjrv5KHK8XTuWFxoZ0581A
         InkH36vwgb9w0Gzgaqp0vTc1U6WiB9X613nceI5mxYQc9mBr/uyyxgYtS/tgR63280ye
         FVh3ToPHJpeYeL4KvYrDAypmKS3a+qYsw3E0hZ52MIrLhCrSq0qQvP+iFwRwDmTLTpev
         HY78PCmughEsHIlnRaKLdstgSX+B/V2JA/7AT1xA5xGrqt0VuC0BgL/wGdlSWuU9/Agr
         DG4bVhlsIkrd3RMBueGKKiTlxNfouwRkH6vofwSJCg8Q8ho2pA0HhWqtYBCziNbHp32d
         vdhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730380026; x=1730984826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPzvubR4QyGZSA0yTPPpltAG7w4LTcpEG3Z5c7g1ktY=;
        b=lPTwdAhCjMJVDF7YzTDZTeufeU6aV1aaBZfLVklFjf7gesnZ40wsDqo0y4cpm5AtYi
         SXdWoa28YblWij0pAohGSNLIPgqssjvepKg9//HUfbZLpJZlAUMqukSY7ZBaRbE7/5jv
         QAiEziX6nnK8YiDUY94CJxDSuYcbUDTjhdyMBXusW4q3KxW15z69onbGIfDSCe2/HoCI
         vd7WrUlO8cfgS5HsMc2XtgUlkxY+aIlCRq+Uy5XRotQ6SLH8mnnLSR4RyTREkMu7bmms
         GJ0cuAFSBjkk5EYDDTdswLNVi3DTlwCZKJBsCNPuTSnS8x0gcqC3ArRaOEJOhlcyQ4pZ
         0cug==
X-Forwarded-Encrypted: i=1; AJvYcCW1A5NfnNtsMVKvjOm++4iov2AYVvJbI8hNqUqOcURX+PIfWvUPAnED+lJLGT1ZEefYI9uAPqT0gZMIp7wJ@vger.kernel.org, AJvYcCW74zzBNgd3wEZitU+lh0B7hyr/8K/alf+h1y2amKTA+3fRm+CmWjHZD06YC+8LZpjqjSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYyonKontTkAWKAHjmhFGveTzCL7IDpokBcbmIp/satWGSfe45
	Mc3hPouYnFLSlRdILMguqqEw2D/3/nw8X/a6yG/5KDP22cX/LyL/asGJG/gn
X-Google-Smtp-Source: AGHT+IFElO4Cc0U9XUZuJiTtwbGUcA6scYrGO9UPqoA1K8bLXgwwpREf4NjvR7tvBAMxq3DPEs2bbw==
X-Received: by 2002:adf:b30d:0:b0:378:e8cd:71fa with SMTP id ffacd0b85a97d-380612008fdmr12704371f8f.39.1730380025853;
        Thu, 31 Oct 2024 06:07:05 -0700 (PDT)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e741dsm2064965f8f.50.2024.10.31.06.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 06:07:05 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] bpf: replace redundant |= operation with assignmen
Date: Thu, 31 Oct 2024 13:07:04 +0000
Message-Id: <20241031130704.3249126-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The operation msk |= ~0ULL contains a redundant bit-wise or operation
since all the bits are going to be set to 1, so replace this with
an assignment since this is more optimal and probably clearer too.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/bpf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 9aaf5124648b..fea07e12601f 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -914,7 +914,7 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		str = param->string;
 		while ((p = strsep(&str, ":"))) {
 			if (strcmp(p, "any") == 0) {
-				msk |= ~0ULL;
+				msk = ~0ULL;
 			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
 				msk |= 1ULL << val;
 			} else {
-- 
2.39.5


