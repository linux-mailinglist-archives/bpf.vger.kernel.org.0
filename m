Return-Path: <bpf+bounces-75713-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7437DC922BA
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 14:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EE5A4E42A5
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 13:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD8922A4F8;
	Fri, 28 Nov 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Co7jCS2B"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB461C701F
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337571; cv=none; b=D96CRPqwdqFvtD9gYmKPYjHGMFinVuYx+ieD+e8vcBWHSO98QWfE0nEuR8MT5CiRtHM5AuhPN4apGmJhuLNo0juMM+jZAhV1SciA1e351RwiCpSwu/2nj2rbgJgrGFZgwf7P/6lGOaGhNb9mOlCrZSfVdguoxWxjGOMuFLYF9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337571; c=relaxed/simple;
	bh=p0ADxgELml2VPbzCCTU7ZXu2bCx24MiqDSUdinmk0YI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BeKFvuj4EpL1Fpy16ssxu2CaXbweHmEEaB1FT/6+Uu/Od3BS6HQfAEvQgZoutu13w/rZXB87xXuRWgpOhRUY/iBa3POS13S/FdrNriB4n3jVc3xWFBHaGbTdcgwvyeNLdgkG6tfHHHfjPjN1IHzUFF0CJWXuCut3SGHfVm2NLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Co7jCS2B; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2984dfae043so16789015ad.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 05:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764337569; x=1764942369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZS0gzAbiofcFysS17aHiM5lNIPZOsMD2u3cRdekkqDw=;
        b=Co7jCS2BAkpq3tSsrMYs9QjuCYFIAy3bZiMdqW94nONQzRBHFej4OxW7ot17US7Fxq
         PNuEed2KCqdqD/rPuc7PgcapRYN9RNkb12HGo0clvvTuIRbJ6Fs9/ptK+yyrYwtE4GOV
         0z11WIojBHdAlxbzkWl4SgpWWEjTPMzvWy5pAcfHWEcrh9L6zJjRP4nbKc4TBrY3tBXC
         K7r9HCFkNqnpGkcRtwFp1EVzkXcgXXEVWY0zgTBBUUwMzPMybbZBfb/ZAE0MaLLuUkV6
         p2xfPqxEKIBhqWfftZHtg20NxmQlSQQMccHspTR9rjyQuoDyJQJ+NOlyOsJbPkJT62Nn
         J/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337569; x=1764942369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZS0gzAbiofcFysS17aHiM5lNIPZOsMD2u3cRdekkqDw=;
        b=sXBg8CCb+gKI04C+UvL215mi4KdB6G3EaKCinNIswOif4TGoVaYaFBSBsshyN9OGOK
         WLrQA967eNrPc0c0xvBtBN1VIPxraCyWOb6Jo7GzVljR6t7nNvB7XEI1dHbduifs5NtL
         m5IcZRufgwZcUV/unCa2yXo1hUI8fTW5XAcNqf6e4JIVYwcqeOQSN6pfknGgRYXb+wRM
         PM9aGYLoxH4MhaHj78W/2TINbncgj6/W0JwlANZ2rNM/+YhDisso2vV6ObQXpiPIivwi
         mtK4chzQM8K7rVhYzZtspWORjO126kHX8qVV86rqjreFskSIK07KszSNYr16wvTP/O5N
         uZvw==
X-Gm-Message-State: AOJu0YyyREOArIvewhY8MmlcrsjzUcOu/6JmINGikOTXI5Y2ZJUv0g/6
	+MSFVPnYAJSmJwM5EjwEU9h7MKly415m8X4GmRu9pty3t9Zc7IvEabv0
X-Gm-Gg: ASbGncud3TqpKpV4VoPBwrNh2l4I2K92GXoNPHMALQ6gWB/P8sCQq05FyieeiM5cfIL
	VmIphVdQZULvx3X+/tmvAiL4vOr6/2MAQ2goln95jHEzuE3M/qjhKl6nwBCp3dAJzMJjJWOZsXy
	yVxYorBlp8ankP9t6EtaruIiEI/0veS51aaaZUD+0srBLH2ELbt5g0OKptpVT1ZwUKkp2nM8jRd
	Fklb35ASjIMKay4hTENxzmm+0iONTfxXYZYJUIO4kJvn6awywVtoTUblUQQ12HT2QZgn6dqwava
	2dmIq4Y2lO8DVsqlk0OGyKZglQAEsfbQk0T3L/Mzng4oQr40NHjH6M8Esch9HG2p4PXAoiWdrJQ
	0jk77t3geD7oDUQuOq9tuhyVhwXWutJjW1hIGW62AxnOb9DjhOJvPGQDpzlru4MgQA27HgrgO/a
	jSA70Zx5SyErQUwATSC2BmgBR9Uq+mZo0NHn37QvCPJwSCjPDl
X-Google-Smtp-Source: AGHT+IGgctN9Wd6iSyVed/+REI0U1Vd3bPRvJ8n1hCHIDY86Z3XYTmOAY81YE+Nggw5+MGqOpJ/Hjg==
X-Received: by 2002:a17:903:98d:b0:294:f1fa:9097 with SMTP id d9443c01a7336-29b6c571ba4mr304092995ad.34.1764337568765;
        Fri, 28 Nov 2025 05:46:08 -0800 (PST)
Received: from KERNELXING-MC1.tencent.com ([114.253.35.215])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbde37d7sm4792674a12.13.2025.11.28.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 05:46:08 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 0/3] xsk: introduce atomic for cq in generic path
Date: Fri, 28 Nov 2025 21:45:58 +0800
Message-Id: <20251128134601.54678-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

This series tries to replace cq_cached_prod_lock spin lock with atomic
operations to get better performance.

---
v3
Link: https://lore.kernel.org/all/20251125085431.4039-1-kerneljasonxing@gmail.com/
1. fix one race issue that cannot be resolved by simple seperated atomic
operations. So this revision only updates patch [2/3] and tries to use
try_cmpxchg method to avoid that problem. (paolo)
2. update commit log accordingly.

V2
Link: https://lore.kernel.org/all/20251124080858.89593-1-kerneljasonxing@gmail.com/
1. use separate functions rather than branches within shared routines. (Maciej)
2. make each patch as simple as possible for easier review


Jason Xing (3):
  xsk: add atomic cached_prod for copy mode
  xsk: use atomic operations around cached_prod for copy mode
  xsk: remove spin lock protection of cached_prod

 include/net/xsk_buff_pool.h |  5 -----
 net/xdp/xsk.c               | 23 +++++------------------
 net/xdp/xsk_buff_pool.c     |  1 -
 net/xdp/xsk_queue.h         | 23 +++++++++++++++++------
 4 files changed, 22 insertions(+), 30 deletions(-)

-- 
2.41.3


