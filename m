Return-Path: <bpf+bounces-71310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 815D2BEE918
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 17:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6927189B019
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 16:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A62EC09A;
	Sun, 19 Oct 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqiB9if1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A2F2D3221
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889578; cv=none; b=E42i8OwbamPDckXuBKCCeVb9RA6+F4i//OdVplQAKT4hP+NV+QUfApZjVCC1y4S9BOlcjrsfi8FUmYzT8TqCeWok/xZlhcnmzEgANhtOG/0TucNE8gtANv9oUfEYUUEwbAu73dpeB/7lY3hqt+Idbtd/4qvp1KcqQmvtV7+12+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889578; c=relaxed/simple;
	bh=iUiqK81uM8PaPVQxTA7XtGIXzW7e9qwdKERuYe+D6p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fgpb68PPIXK133hwLQqiw8PEugWr62zU0zFjnHn4MChm+Ww4gsZsE/vIhNe5RaS1d9Da0ffthRpTZNy9bTIQMwSrBlDzdj/PO7xjCzCxUVOZdwSPoNWqqe0BhPMp6aCY6JysVsxcuQVtEnw472EKK8XmBna1xxKIToKmD7Rrs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqiB9if1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b6a29291cebso6018766b.0
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760889574; x=1761494374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTFzpahmqTTHRcTI1T2SzZtl71JkvLUoqnEeOyK8S18=;
        b=JqiB9if1ZGaYuENOBR81msvQE0BQRO9cMhJ3+vGJ1yxN7kzSCEYwssWYlw+QuHVE2+
         YcRctv71CJxh2Gj05eXxsZ9TEEVWdy7JAeSsZ438d3lg/dDdhMtd5rv0I/qHt3z9EiGD
         mnKMp+iqBQaMzl4M5AJUm4ZKoQ1opHa3WhGUKVrECZ3M6nwf57zgVmr7yQhRD6d4YSyW
         tnKvmp5+EyZ+cGm2LNdnACl6on21Qlu5Bvqg3P2SDLU1tHsc4eb82eTkV6KXS7RjgPj7
         c4G42SOyRudkk2jH6V0SPeSZ/Ys/j/1lN13KrvXsJudGDeTPxRWfeVWbIyf4v5i/Ckzd
         tIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760889574; x=1761494374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTFzpahmqTTHRcTI1T2SzZtl71JkvLUoqnEeOyK8S18=;
        b=bqkE53aZTcHgY1JEbp6Bt0gjQi1o+JwhiAB97BIKr5MzVxy/xKVptsegKXspZyVv1u
         L654YvHrsPmDKNGBkXXlENLLkFh1rGRjVnjnDofKrhrtNj8W//auRNE8/DFgGVDspM6+
         /6WM3eb0oWVTaUUbO9yS5Ez0OdYSmBBAJX5jv7zGYcIK/5M/vyYIl82OxMHolGqDz3gA
         JjZODeKol4IDLbL93yG+gAvexmSGrQ9KwWhS9ChMU8ApNo2IlBM1L3zgSdtWxc2T09cB
         ljxAWr+7lCVvixs7gqNxQLLe5uI3TeznX97LbDqkyqGIwJqHiF+zZL6+297G8hviHDLK
         g4pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUysY0ltjRBWXkyDR3jH1mZiuXX1Iskeis7GZlhOHxCAJK/Imgoc/eowD/LNh+SKVauXUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwAt79XwE+AiXeyjQCm7mesk31s9R8uS6p0rrgaaiuCHpfyewv
	q+Hc9bFvOcs+Dn4HQXeFEB3P2wTjjQLWo2hEEegq7Z7BJ28+gqC2uoet
X-Gm-Gg: ASbGncvmNZ46MbKG9HuaW1qM9MH28XYVSZrf+gfiZ1Fa2IHEaHnp7BxsLDrP1E4pjgY
	+kmLUTa3O//57/DMtugu1CyKjfHHPFXmsh09ktNjhqryyDfNzuRScJMw5uIlPTijav9iDFL1OOh
	9OtbJHCJoDgIYnlNvfJqVsucSX7QzpMoa6Mv/MDwk2d+i/IUCSMAM5Y0r8P6w5kPmdZMTt/oJu/
	+pbk9UXn0eB521bTdtsj3BI8TtJ2/7N3eTmlQZWCVlXjvMTRj7J4I28K8GL3fJTtcDvPgALkZYp
	0as6AI429ymRg6reULQn1N6o9lxCqlehPxyLnhi+HfLPOjUJV9dWoRe/8JuYRhnx5VVXWxpxJWE
	t8BFMFz1hstDclUxiaH8NHsq8N0o5xzcyv5cUzZ/JPLP0aBFZVv8HKNk/OEn63ffWjp8LtyY3vH
	NBBtJUYJbUe/i3wZs=
X-Google-Smtp-Source: AGHT+IEHxFRE2pa0L8rXNH1hFC+5I0ryoeM29tlY7gH4lN9MekBBWKyrE79bZEqtF6jDZEgGQtZo1g==
X-Received: by 2002:a17:907:3da9:b0:b2b:c145:ab8a with SMTP id a640c23a62f3a-b6472352847mr655876866b.3.1760889574232;
        Sun, 19 Oct 2025 08:59:34 -0700 (PDT)
Received: from bhk ([165.50.121.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036307sm531554766b.45.2025.10.19.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 08:59:33 -0700 (PDT)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Subject: [PATCH bpf-next] bpf/cpumap.c: Remove unnecessary TODO comment
Date: Sun, 19 Oct 2025 17:58:55 +0100
Message-ID: <20251019165923.199247-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After discussion with bpf maintainers[1], queue_index could
be propagated to the remote XDP program by the xdp_md struct[2]
which makes this todo a misguide for future effort.

[1]:https://lore.kernel.org/all/87y0q23j2w.fsf@cloudflare.com/
[2]:https://docs.ebpf.io/linux/helper-function/bpf_xdp_adjust_meta/

Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
 kernel/bpf/cpumap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 703e5df1f4ef..3c05e96b7d2c 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -195,7 +195,6 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
-- 
2.51.1.dirty


