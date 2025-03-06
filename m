Return-Path: <bpf+bounces-53510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E60A55937
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 23:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5D33189A1AA
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BC225C709;
	Thu,  6 Mar 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdAd3301"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782BE204F77;
	Thu,  6 Mar 2025 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298562; cv=none; b=tCl3YXjhedjy/GTpd4EUjKpmmaJqT7G/YGLRMeB4M3BKmscnjiNteaK7UdQNWFvm/56KzPtlSo8ts+8c8BA/bqD/PzhHrpWGFZc5SxcdHQZJLsg3zFkuBRV0xVu9nksmI32eEqiZad7hQqCM/SoFEMCBlKMKCNWnUMYwmBDVK6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298562; c=relaxed/simple;
	bh=MQuAYbxGXl/dmzkeaQsZzB+kj4cLNaCQZObJwqQdmgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eQf3K811s/yyV2KiXHkSpNG40UHGL7mWLMpw2dQs0K/DSjdsTIpKXXAysUEHlcwDDEvuAgw79XqH9xzi9+Dv8p3V5JbdRCWP0Q2ljFHfZBD2/ePo8deelPJSnvjjFmR/qVCbEHavBcbnklpsFNz+XXLWwrP7PZcWGc6DcVYbZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdAd3301; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22409077c06so25849795ad.1;
        Thu, 06 Mar 2025 14:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741298560; x=1741903360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuABU6O0QsbK/YoApSCFVnXHyPcoP5Pvi0/ANUQw+mA=;
        b=ZdAd3301/QvRp4rpZ2AUrkxRB4STWSP56WK5F1jDuLxTvxWkg1EchO5twp3rqSKB+W
         iTOGLPTnV+KZ5Ea+aRG30/aoovLdjSSy7QS1Bq5Xk6xfYPMBJlrQeY0onWOHZl91IbZj
         /TsVqjmmcq/QIAJB9Obhk84hJ2Zua64FRyQnm6ZgySwtstlQVpAJBnF7pdxaihWbhOTH
         fKOGSTBty4w0jBJKNbMHnBmCquuxF619w1x51UEYEAILUfHVAYWfB9lKgWCePfP3PpAO
         4HDNgzg/RhawfrTcqPddwprT77kHnMHKaVSU6EToOmMIHbPdHgNoroQxuL93p0iKq2K+
         2Kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298560; x=1741903360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuABU6O0QsbK/YoApSCFVnXHyPcoP5Pvi0/ANUQw+mA=;
        b=aeaPSV0Z/AMjBBTrXc2ccrzTny5O2uybys3pb7tcbES+7rl6WN6xjCP4Iam3R+9Pjn
         5i37jiEtTTCk5CbWLbr9urTrPtBKOZ2xS0QwY1l3XhFaGq1/2h4ui5kgb8hGpsTHGH9C
         fz1XVBMRRt1Sdx1ZZ/v6NfT25qDQhXy9JcFtW6GEY8FpuXUzwTQlaXbkXQS57beMnaG5
         3lji/5hkU86m5wuJHhwPAX6IGvCnipOk8a/32Z3YEqsbdiy97CzYbIKoMBtwCWk2ru4B
         zrrcU93zcmRojjIGJ1GY+u95acX7fn+cMS9AoEcmPU4qK2pH8JbdSHDY3DGEBvud4ZZX
         o8zg==
X-Gm-Message-State: AOJu0YxwnYHFlqEez6fxx/LOPsgb5mH2rHammpB4p1FH1uEzQKe/BKL/
	b3u3wNWQMPoMbX9HRm07FV/P7K1R5IGQSQeBc07jj/CJnoUcoHqE82T4NA==
X-Gm-Gg: ASbGncsbgLGMyLCTpAwy3ssehJv3WgAzNCPgpwb9Zr1OVFks6ztRmLghLYTqRubSr3V
	SpEwGMLWm4eX/VMaDqQRUX/etLe9q3SMzHOmeGqLVEcoZFx+i4pUj0Ob8GWFd+OTyjTaIXf5RUa
	W+5+cWw7e0hzUD0AQ/WYm6RQSvnbl63DDkEumVPIlGYQcHwqAlcZ7fJAM9qPyOI0whCel7sV30X
	qbK2ND96JIiCw69HtYK/L9PyAfqZSFGErJPuoqLk0uLmx5dF2Gm9AdEh5O5IP1wzg1CETs/PrRY
	Fpp69sEQjq9vNapbLFD4LyUQ4QugYSUVOt4atNSxKOoCrNL3/PRDlrc=
X-Google-Smtp-Source: AGHT+IFwVVhkD5Ma6KzgKA99OfJj5oje73iC5xRGsFzTzMcpWC61DtvKkM1qgzukcY1EGVpmMhgHDQ==
X-Received: by 2002:a17:903:40cb:b0:223:377f:9795 with SMTP id d9443c01a7336-22428504334mr16760995ad.0.1741298560173;
        Thu, 06 Mar 2025 14:02:40 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfa6sm17478775ad.33.2025.03.06.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 14:02:39 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next v2 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Thu,  6 Mar 2025 14:02:01 -0800
Message-Id: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset improves skmsg ingress redirection performance by a)
sophisticated batching with kworker; b) skmsg allocation caching with
kmem cache.

As a result, our patches significantly outperforms the vanilla kernel
in terms of throughput for almost all packet sizes. The percentage
improvement in throughput ranges from 3.13% to 160.92%, with smaller
packets showing the highest improvements.

For latency, it induces slightly higher latency across most packet sizes
compared to the vanilla, which is also expected since this is a natural
side effect of batching.

Please see the detailed benchmarks:

+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k    | 32k    | 64k    | 128k   | 256k   |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Vanilla     | 0.17±0.02 | 0.36±0.01 | 0.72±0.02 | 1.37±0.05 | 2.60±0.12 | 8.24±0.44 | 22.38±2.02 | 25.49±1.28 | 43.07±1.36 | 66.87±4.14 | 73.70±7.15 |
| Patched     | 0.41±0.01 | 0.82±0.02 | 1.62±0.05 | 3.33±0.01 | 6.45±0.02 | 21.50±0.08 | 46.22±0.31 | 50.20±1.12 | 45.39±1.29 | 68.96±1.12 | 78.35±1.49 |
| Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%   | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%      |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Latency     | 64        | 128       | 256       | 512       | 1k        | 4k        | 16k       | 32k       | 63k       |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Vanilla     | 5.80±4.02 | 5.83±3.61 | 5.86±4.10 | 5.91±4.19 | 5.98±4.14 | 6.61±4.47 | 8.60±2.59 | 10.96±5.50| 15.02±6.78|
| Patched     | 6.18±3.03 | 6.23±4.38 | 6.25±4.44 | 6.13±4.35 | 6.32±4.23 | 6.94±4.61 | 8.90±5.49 | 11.12±6.10| 14.88±6.55|
| Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%     | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

---
v2: improved commit message of patch 3/4
    changed to 'u8' for bitfields, as suggested by Jakub

Cong Wang (2):
  skmsg: rename sk_msg_alloc() to sk_msg_expand()
  skmsg: save some space in struct sk_psock

Zijian Zhang (2):
  skmsg: implement slab allocator cache for sk_msg
  tcp_bpf: improve ingress redirection performance with message corking

 include/linux/skmsg.h |  48 +++++++---
 net/core/skmsg.c      | 173 ++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_bpf.c    | 204 +++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_sw.c      |   6 +-
 net/xfrm/espintcp.c   |   2 +-
 5 files changed, 394 insertions(+), 39 deletions(-)

-- 
2.34.1


