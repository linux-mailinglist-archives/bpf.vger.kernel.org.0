Return-Path: <bpf+bounces-60896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257B1ADE62E
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 10:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756273A3C3C
	for <lists+bpf@lfdr.de>; Wed, 18 Jun 2025 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE49527FB0C;
	Wed, 18 Jun 2025 08:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1l7Oqut"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819342747B;
	Wed, 18 Jun 2025 08:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237112; cv=none; b=WWyiiYoSTwIdTGLW/s5NSdEJbe6FZJ9BasLl8QxDWSE78w3ndq5ekgAxE/IerbUffpbeGtxGtwDXLLXM8vqLoEVi9VZc3cR9PwuFaBqtwpRKKjb8byhH1VVXctbMjtAvjVgh1/0UCFaIDPvl5P76zhD9vp/pO29p0XibCz0RLgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237112; c=relaxed/simple;
	bh=klImNFDVViKVjStvzRatdsVt/GzjfRZdsiS8aBAEf08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iKaV3eMB/ebB4kqjK8ZsYufozfP8M8X2aNb7O1bXzevMR6B4q8gmEtyGgfWzuXjuHPBWm9CVILYrFhUpn9KJAUph95T7wwzOdo6oOCJWg2Bw0771zaTSO5ys+GBpPjr3ALE//8bSXW+gTcvx1XZSS1IUEwWjMGD03P+g6k1sXY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1l7Oqut; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-235f9ea8d08so65185835ad.1;
        Wed, 18 Jun 2025 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750237110; x=1750841910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eOhnJO46k2hLoOA1evvqSEhjXrTN3jrr3AHVjZDMyD4=;
        b=K1l7OqutrAR0Mt+M2rdVSQ9mvVTjdeHB+0hMLwviueuaNUm3lSKBxqHfrKoTwmkqLN
         VQaR6aV30oLFqx08djhyTZkusRI97o9I2g3BETfTgIrBvuUYG7qDf47UtUlEEtwpkC0a
         62/xLY1/STNrUESPMQGXDRK7qcqz62MPma/84iRIP7HhbxqeXq7IlvRT7vyDCRc86v3r
         KFbS4FFzsEd/0ekvO6qvum5uijZC8KC29Hm5c1oN+tkTs3wOy2j5bezGuMBOHomoYgtW
         Q20ZhDjywoTlJZw+opjp7AgWsGfBe/iw1jqIhE78+ECRfvhmmb1wDB+w5rDvYV5/p6/G
         Qctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750237110; x=1750841910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOhnJO46k2hLoOA1evvqSEhjXrTN3jrr3AHVjZDMyD4=;
        b=HGnvDFHxRYLTixT8/1G6mzAeXeVt40gTPp6fzn2s+xegmB6E2A2IVPZE5XNy5hJNnk
         0uXrI7OoGPFHBE4oyEDiCr0hgFciaNyqA/ICS71Wt/6CsllzbY8/5I1//sU8EerQkE1Z
         m63NdO1xki1hfr6/4nF49n+Yn+Llv61s23wr/BhwdVruorSL03/UwmfS5m27F8CztfBD
         ya5Dmtsj8OEbCUw13mUa+NKYJrstWXTwf07+YE0C1l935FXeka3Z0EepjwrjquUvfWZ4
         4cQjZticYz64NQ59QoSrzUHzOFr2krTE8/qUSpIDKszJVuKDQeVHoeybLXAylZJWsQ4t
         YCJg==
X-Forwarded-Encrypted: i=1; AJvYcCU6fFO87MTk733xVGFjc5fuMtB5x0nsj84aJna6ztF02p/VqtJFmGS1VYn3KKIe1PtG9RJSR3T8itaHA3FS@vger.kernel.org, AJvYcCUtBEL4XX873FDS5NZjwi4+oHlug74r4YaHXbyEOmVvKDslIoWKlhn32AL5IBBUUl/fgVs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx875Kj7yPTQxhrwxsV+YzQqPctLzItnRcxyofuSZnu7X3lTLaO
	CoZpn7StR8/wBbiL843V/1OXZVV8Ufd4jHrYpeeODzhUW6UbjLSRNfqIuIp4kypJcU4=
X-Gm-Gg: ASbGncug+CiO5yg0CWDCifnYwyDCzTL0gLy7pjm6NcVMi6CCaHeXo9+CAJA1Fa3u14y
	OwaSbUM+XtsRLEDgerWPsWcQ6+jyvnVCixTqbBArqzQH06JC+GvHbfGAewMJWuCnxzZUm0eBQXg
	bb+GozaWqWMuapU/gIGYJ8UDGUwCmW95P1rBT9jUQHoR7XbczqQgsMIE07zavczmfUxCmSNwcnY
	xut47ZuhjULPdYckYKzys6L9wLoV9yG1vvpCZs7VE57lPeKRyzBvwaS6e0Tt4so0NTU2x7G5Z20
	3YSj69dJaYFFAZoC4glG50gmtn4PKxeR+XFpy1P/ooA7xQpE3PxRa5yk8+N2GqLWDZ0psSRZv+F
	NGSEdFAQiTUqLxQ==
X-Google-Smtp-Source: AGHT+IFs5h0U9hceINh0qwCd633ljXbi6FxxN77HV1zhafIKWrO3Zc3AdHi9WDeBMtg0lqAZoynLJw==
X-Received: by 2002:a17:903:166e:b0:234:ed31:fc94 with SMTP id d9443c01a7336-2366b12219fmr244997935ad.26.1750237109668;
        Wed, 18 Jun 2025 01:58:29 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365decb846sm94652895ad.227.2025.06.18.01.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 01:58:29 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next] bpf: make update_prog_stats always_inline
Date: Wed, 18 Jun 2025 16:56:09 +0800
Message-Id: <20250618085609.1876111-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function update_prog_stats() will be called in the bpf trampoline.
Make it always_inline to reduce the overhead.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/trampoline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index c4b1a98ff726..134bcfd00b15 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -911,8 +911,8 @@ static u64 notrace __bpf_prog_enter_recur(struct bpf_prog *prog, struct bpf_tram
 	return bpf_prog_start_time();
 }
 
-static void notrace update_prog_stats(struct bpf_prog *prog,
-				      u64 start)
+static __always_inline void notrace update_prog_stats(struct bpf_prog *prog,
+						      u64 start)
 {
 	struct bpf_prog_stats *stats;
 
-- 
2.39.5


