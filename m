Return-Path: <bpf+bounces-45496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D930F9D68DF
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 12:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F77C281B69
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 11:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707718A6BA;
	Sat, 23 Nov 2024 11:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu5aczPb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE04204B;
	Sat, 23 Nov 2024 11:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732361509; cv=none; b=Xx3qrbfrxumE5/LyeMGMWxbJdbvCjzc0MZBahdOFiI9MMr0r9y2iB8NHfrfcgS4a+MzairsJuiuOwdr2V8XO21qzez18j218xza5HkOIb0mCbLw70iNpU0+JngTy9bV3kZfsb1PiomuGiVEzOdeFOEOk/d95WCHMkWqAEDmPiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732361509; c=relaxed/simple;
	bh=7l53ff7oBSbondRTNi7K/Blxj+8PK+VAW7cT64gbz7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BL3HUXHwh5MwmRARMwAVmhfTIrEtjJ32wwXMeFnVAgqcVyVlkJVI1d0NHKBF5iCiFeDIqEWubHGMYeldZb9wKncw8vld3+7UIlRrqF6Jw4DYxLVfMOM5w3XfzmhgHhfH1BJtcG1ZNJYuTC0GWiYaqmCALEB2C55yBpee4hJ4aoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu5aczPb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2124ccf03edso29380135ad.2;
        Sat, 23 Nov 2024 03:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732361508; x=1732966308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8nb5xhW2sO139VthmTPAswqENky3wnHBx6HMmEx694=;
        b=Nu5aczPbkM7GY6OmEqle9LQmZgmAq6N7fTKa+7JqrYPjty0C5/V4ZbSg5Q+dXa3NzC
         ivChGbr4onI7oMFsatzKx8ysnf/0+DPSoynDAWFfKd7Hx6nfHFXPfB5uimvW2Tq19+1a
         xmFZJMpG6p9XXCk9cXIaWW8d2z+PESK8zz0eZ2q/81uzAcHVOG9pQ1MN4hTyVFzhFpX4
         haSWOpGT0OsbXDfR5jJf8WXJHKWAYq01jaAtUUqMCeJVbdPAQYHZBSd801sZqyv9Jjm3
         +3XAbilOmmL/HRV6H3yD+elPVPdA29nWB89NuadbnPCE3HbL0khHzGnVS2naWy5/g4/B
         rRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732361508; x=1732966308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8nb5xhW2sO139VthmTPAswqENky3wnHBx6HMmEx694=;
        b=rpraVvY0OX8HfnpSouPXi2uGdiXvVE4DYc0YifPsv6bku9qDatSxYC3A+wIYkNbUDu
         Hi4j2CRFkqSyJsa4oQYAimuyClZy5YqjL/b+0CyJOFLTSu1/i0YwQxXvA6RM/yiPeHMP
         F/7V703mCXN5pXcoVvXWLNbLwCGs5Prl8ZhBDE9uRynf+363RkNaYe01CH0dHBaOPMWA
         d0spp/Jd2oDpBGHkS3Cbeq+aeDSCA5as9a2/g4NJYUAWnRIrEtNtTGXNoDu/5SGKji19
         feMPqUTS2v3SDPPAaF4Jxdb1sbO9MALmIEuzKTQhT5p1lGbo8Kh0Tm41UE0NWTHcU0wN
         kLfA==
X-Forwarded-Encrypted: i=1; AJvYcCVaGxIZWBjbNSoz99jjvVS2NL2ysu+S4mkk4yzk/bypj6DfLJb3h0zUnaUUEsIR5Uxg68YEM0mgvOssJq8=@vger.kernel.org, AJvYcCXTl7FlxcKtTs8hM+nENMo98RUY5uHILhI4HAePeVj30OwrPb5YW80wG18SJBoVYJTDiKn2e3zvjifLGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQuwqRLDiCjcP6PbA/Y/t9FaBMUJtPJkgeHhe9gLcrHtfKXOpY
	Smbv1LpPh+pfaUOXIGgHTa8h2FF59on5pHSaZEWc35qOBY42lDpE
X-Gm-Gg: ASbGncvai36YrLcqk2NiAtoCFjVkbadlYptBiLX9/Vl+NZtsw23lmF9rCsY3uoMcxZl
	SeSNZfKOmgl8rsdPc+MFOJHBIClTLso4O0PRtjOaQeTTPjkFR+nFqh+a5JWTPH9vXNnh5Z3YQA3
	iz0vEtiZvqjUP79Uno5maJWe50c8LHXVmWwUfNpaaiQQj5OwbyzaB1GZOgpwvW4nTvIeb06Pozl
	hmiZ/kiCK01zZM0QQRbNWaYQTh0Rsw3/0Kk5z8DdO7VuUyYJKcO7/RxF3xUM/oBwWmrv0prlo9v
	M32Llr1OpXwp+kjSSj2ca6vKo/09pyn++w==
X-Google-Smtp-Source: AGHT+IG3PzaM8Bw+R0W394CBKZEv9djrxBQmV3JOp7Wd20s/KiyA5JnyhBFunBImiThgsNSsPn2G/A==
X-Received: by 2002:a17:902:e5c3:b0:20d:cb6:11e with SMTP id d9443c01a7336-2129f797c7amr70270315ad.26.1732361507576;
        Sat, 23 Nov 2024 03:31:47 -0800 (PST)
Received: from localhost.localdomain ([121.241.130.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc218925sm3187487a12.43.2024.11.23.03.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 03:31:47 -0800 (PST)
From: Ayush Satyam <ayushsatyam146@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Cc: bpf@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayush Satyam <ayushsatyam146@gmail.com>
Subject: [PATCH] bpf: sparc64: fix typo dont->don't
Date: Sat, 23 Nov 2024 03:31:16 -0800
Message-Id: <20241123113116.1983-1-ayushsatyam146@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Ayush Satyam <ayushsatyam146@gmail.com>
---
 arch/sparc/net/bpf_jit_comp_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
index 73bf0aea8..0f850bbe7 100644
--- a/arch/sparc/net/bpf_jit_comp_64.c
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -732,7 +732,7 @@ static int emit_compare_and_branch(const u8 code, const u8 dst, u8 src,
 			br_opcode = BLE;
 			break;
 		default:
-			/* Make sure we dont leak kernel information to the
+			/* Make sure we don't leak kernel information to the
 			 * user.
 			 */
 			return -EFAULT;
-- 
2.20.1


