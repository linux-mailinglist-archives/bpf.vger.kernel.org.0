Return-Path: <bpf+bounces-64048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12593B0DBB1
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFCF31C8244D
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D492EAB6A;
	Tue, 22 Jul 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJdZt6CN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9472EA492;
	Tue, 22 Jul 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192271; cv=none; b=I0OnNd6iT7z5GrChF9QqoLDgW/hjnubNg8Dc9rYWluDfHdCFO3pIPQkXH1LOKxmCa30Qy8X93AvxGjBwsxSlpLNKVo8TwZDnI+2PUwab7GUkE4BZL9jWx5ad2Ya9yl95I2R6BJXRypo7imVqt81hHzWFXwf2X7dEZXubKBuZ4Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192271; c=relaxed/simple;
	bh=i2PVxXB2OKPFf543e/FW9U9vSXKo+dky0ufvrl3J1b8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kwGtrcsyFT3TYVfFdJ6zcXisOik1fNZW+CcvXZTeTJYmRi5Pna5NKp7Rbg0HAJm1THslo5tffDHk1AsLyzsRJoY9gfB+UdyGeyNbrY4Miw/RtVXHuO+TrivNNj37RWNZxCgEguMdxOH3tDTZKeihNgvxrg7LrkG5xCd+LIdF0Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJdZt6CN; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so5276343b3a.1;
        Tue, 22 Jul 2025 06:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753192270; x=1753797070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2fY9g9SUYOdjTN++Th4P+LF8gvoDANBHyDfHKNyK83k=;
        b=XJdZt6CNDdQiRs0HwgxGbNSF2sPQHTpCW0gCQpSluxJPkhd+DpuP7hDBPS5IK8KTOx
         veXQ3sHr4BPb+Abizi6KOJ9gR11qobGNbqMZMaXci6bboyam4Kc87Atsa8b7MfmfzUqZ
         /u56J+o3xf3muT6J0oxipL7st0gPKQmdfG/JKPy5YX8fDGXsiyb+TR58Cu6Nw9+9jdLU
         Y/gUMWxXzlBAXdnAV/qOljq3oT9rxKgx0yGZK0P5xPaoZUEY0JgLqjwqpORmAEdkeuoI
         HTXvFAz65wiuepZtixqCKnc6WN0HSpihXjHxki3aVdyJfaubM+LuaIXpPHRzFgv90ckC
         0jfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192270; x=1753797070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2fY9g9SUYOdjTN++Th4P+LF8gvoDANBHyDfHKNyK83k=;
        b=XW1iOa9Wwwf/u1ljQe9qSqjJHohnhy/WTKREBuYblWDl8su8HzadBCe/SMN0RFYd4T
         t+T5fHwklag0GZoKgFdmRjdrfBPahklhO2VF82zSp/ReCPdXEh8SutKy3IGKWtFyMMyJ
         Qw7RXsl97ukOcPSIpwgFkUhCNZ1Y65xg70tT+X12djztDovqh+1Y3HlSru2VjUOXJlpJ
         VmBcIqodB0FyJyqPMdoCm0PuriBRgkbya1TYOdL9+b1D50Ge3raCpNdD/Xxt6DcdG1ey
         85eD3U7wIcML+dcdw2k8e1ujQ9pPvfDmWtIh/O3qtBugEVs1mN2tTo4G09MM9zd9NaCA
         Kzmg==
X-Forwarded-Encrypted: i=1; AJvYcCU98fWFCaLM722O5aLjSJoJ+u/QGTi6IGoMWCwG278MtAk7GKI6XlbjhKI5xJgOzAnUqMg=@vger.kernel.org, AJvYcCWZHP3KFLNmzpJgh5oOjGjyIGXcIFRpX+w2Y+FypEY+a5m6hfgTgUjkdgprl0goOR0SZQ/aAOMU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23y8fUEKUcOMx0amqN/Rg+O9aSq4IeALWEvte0161QRqifhd8
	6/aY4L5ty+JRcNMLouk7O5N3aZY94wYM7sUxOFQk9outfU9VkG97Guf2
X-Gm-Gg: ASbGncu2lRqUDxqhM4/NJ+Wm2VdztrT9+qjoWcAS/NEJaPMZRBB2U0Lbyn1UZNpW7jM
	OUDjZKTJ1iA5+lP//ZXtoltSLzkpZprpqgAqjwOZzImCQirFc5ivtVgp1K7+oPjyy5cdjMM6kTb
	Z5exF0U5DloVMSupk2Po5JrvnA70T/CvRpnuzKqCs7OPYmQQ/Rs1769G7UazIzTwxuz3y1f14Tz
	I3EftbD6y3Aqfg1J/h1Bbgwispe608bSRPO+IFE111RF+5o3Up+JCFA2y5h4t0+MkrlvPkpwxAE
	UyrnvzUKEVsLcmx9TWF1LvXyUNdUwE2atkIjQ6SABrr5ffuZbCgX8vjYT3TQ3BqF0vpYmf7QWyl
	iyAr/2CNJDFJ8KFSj9RBBEBJGR/RkS0jav9nOc6Mml5TAchsSlmtNmvt8snY=
X-Google-Smtp-Source: AGHT+IEC7MH2AMxJZ5WkicvhVYJVAhylhlNJ6cko9YL2g8e/+t2DT7nDz5Xt6lw7DtJ3bGk2tVlpSw==
X-Received: by 2002:a05:6a00:1817:b0:736:5969:2b6f with SMTP id d2e1a72fcca58-75ed156d03bmr4420911b3a.6.1753192269548;
        Tue, 22 Jul 2025 06:51:09 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89d3190sm7612924b3a.39.2025.07.22.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 06:51:09 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
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
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v2 0/2] xsk: fix underflow issues in zerocopy xmit
Date: Tue, 22 Jul 2025 21:50:55 +0800
Message-Id: <20250722135057.85386-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix two underflow issues around {stmmac_xdp|igb}_xmit_zc().

Jason Xing (2):
  stmmac: xsk: fix underflow of budget in zerocopy mode
  igb: xsk: solve underflow of nb_pkts in zerocopy mode

 drivers/net/ethernet/intel/igb/igb_xsk.c          | 3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.41.3


