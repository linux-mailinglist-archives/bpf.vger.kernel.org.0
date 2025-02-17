Return-Path: <bpf+bounces-51714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE567A37A2A
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 04:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 524B43AEE19
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 03:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40411531E8;
	Mon, 17 Feb 2025 03:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC8r3svV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2336E1465A1;
	Mon, 17 Feb 2025 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739763813; cv=none; b=hDPvfx6r0S+6/skcLKHxccDYzPqL2cZ6cTcSeieH2H0ZUEVcxWbSZTLp8UD6PqOpBLc9V2yw2SQFVKtFuAeLsHMwA85PLUlh/YyNv4YTaoB8t3VWYumKzlU2dtvGS7X01xHmDc541j5niN+/6O0+dDJ4228Ufej4i65VVxFD8UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739763813; c=relaxed/simple;
	bh=QP+EOzlbmWti2VmQfezjArLBQapafVFhJSg25wH3Byw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mywXUet+9oC3mPIVDknjPCIVNMRuO+poWhnnM0ClUOel7ONMNtzenHxlZObRD0fw7XVqKRrHX27HCnWdoOISiq4QUFoXKiqgOH4sVOsu26fre2/mNUzxVDEbsCh0p/7jnxJJRT/vSG/gjAuJEkUdbR8sI/s13hCogt8+qNHfwu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LC8r3svV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2210d92292eso33840745ad.1;
        Sun, 16 Feb 2025 19:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739763811; x=1740368611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bq3GozB/Wp2tZSYHmYyfrYwu42l/zFScp/I8/1r0orM=;
        b=LC8r3svV8IgwmD3GF2jeafk4N2/hKXcz5IsQbVSeBu/xMwVLOqcrORR2iSVfcNn16G
         noHMViXgII58Huw9yxWzy1ENMU6uJwLQg9aBor19RTdGI1Dbu9xyC9KW/zqvD5uHYi/d
         xDA834Ak5n8zVuQypWZrgyqlofvw/+1gQ3Uss3gQcD4vdmNfbxJ0XXeQyb7dNKiQYEz1
         RVw5Qzy2+a2Z7l9k7rmh31EKy4C8Mqd4RIahzQv7GmENOl9JpcBu4CzrHuRUAr70WSQB
         GZRQctdrmMVFEnkwtYph98PAmroU2lctLAVjq9/+NJ3bfqicEmUElNXWcgmi6iihiiKe
         dWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739763811; x=1740368611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bq3GozB/Wp2tZSYHmYyfrYwu42l/zFScp/I8/1r0orM=;
        b=En73FsgJmqTGST/jvoX5iWvy4y5I9BiDx/MSH0rEkxToOyAFVG7vd2l8XB2IunAo1y
         tUp6dNRwxmOJ8kpRNlI52XtwZ3ecUW0LwQMbAgyK4ujlpx23YyaTP8x9nrC2WLlWqYeZ
         w+2gDFNo8GtJIRDRZjjMuuw99hrX+ktPTrPScQ7GWPp1rgDwpjaT+aBRBbuEJSxLMJ+c
         KgIDetsOzyqSJ9QYIgpC8H3+3P8GzYC983sbBXiK+KPCofN7YXZ/ohxbNs4jaexrSFkZ
         ZUKYG9CJFN9xggNV2i2uIIFihsMx7kRvaVXtizUcr1hARie0vt9luGnJviCvNtRv5rDL
         R05A==
X-Forwarded-Encrypted: i=1; AJvYcCVWSkjrERd6l+W1W7z1I10E05z86fvJh4jaFS4ULT3Kws7YEyTwqsqoEgZba3BEmpzZOSOpYC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3fLrYbZ0e0CJs0qK1Xe9DftkhJgcr/LtFTEduFNdXrdCvZOn+
	Z3+4XLYcJpl6i9dF6Lkk/ANEdd+rWW5V4VSh61yZaFvVDRdUROCy
X-Gm-Gg: ASbGncvGgaNmbpawhAWtfivvSyRDI2pVdTphVugJhGHvkh4mr0oZpxRMdUYdVUrhXpU
	5mAFYd2z2dmOgHGewlC6UDXl7rAq7QE0rG2HLgPqfZwHZHYbbN/EIM0KM3i9Of6xY+TqZmkybuj
	lMeUFCvFYlsA5iH3/ljDHJ9lVlRznCog2F2XNGv8Djepe1TzbFtT/ZGLKIlPkn60ejB1G2XOKBT
	LrRPPUNgTbsGmLVG/yiE3EOVmou2mkvFOOuAKQVTPNQiOKdzXtX9ssJ6SyiKyJQJb+8aaoMyvul
	336ZyjAbpkfXgTYP+cOH2MpAOZH1/m2hpsAli6rSdglrFvZ5D9hdGos/sNnmMx4=
X-Google-Smtp-Source: AGHT+IHfsyTkWgCvTGVaFqCJwJ1rFBTLKutfyQQ1HGeYe12q4Su+8NND+ufGCO4LpBRb+PtdoJTcNA==
X-Received: by 2002:a17:902:c948:b0:220:bd01:6507 with SMTP id d9443c01a7336-221040612afmr114368395ad.25.1739763811384;
        Sun, 16 Feb 2025 19:43:31 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536b047sm61966585ad.101.2025.02.16.19.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 19:43:31 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v2 0/3] bpf: support setting max RTO for bpf_setsockopt
Date: Mon, 17 Feb 2025 11:42:42 +0800
Message-Id: <20250217034245.11063-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support max RTO set by BPF program calling bpf_setsockopt().
Add corresponding selftests.

Jason Xing (3):
  tcp: add TCP_RTO_MAX_MIN_SEC definition
  bpf: support TCP_RTO_MAX_MS for bpf_setsockopt
  selftests/bpf: add rto max for bpf_setsockopt test

 include/net/tcp.h                                   | 1 +
 net/core/filter.c                                   | 1 +
 net/ipv4/sysctl_net_ipv4.c                          | 3 ++-
 net/ipv4/tcp.c                                      | 3 ++-
 tools/include/uapi/linux/tcp.h                      | 1 +
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 1 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 1 +
 7 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.43.5


