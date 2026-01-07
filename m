Return-Path: <bpf+bounces-78029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF71CFBAFB
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 03:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 125F53024E4A
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 02:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B4253B59;
	Wed,  7 Jan 2026 02:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjKmdgdw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9FB1F8BD6
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751851; cv=none; b=XL8zIhXfNosF8ffbNo3Q+Tgp8TdQpTVL2v9KbUZOsgmD5yrITvXn1AvDJTfyVXrZlQkl3W2Tf5tG4N5HQ30pv4oKyUIQicHfEOn24XKZXvstHdKaocfrTGXEZKBIl2GfZg6fCU4IDhPN3DKZpGx2/IVyc1Z/C93sQ9JAxXqw/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751851; c=relaxed/simple;
	bh=fMDCKlg9zba/zZb9oTcA9DVRWMpTEuuWrq7zJgxZmAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EfLh7NsWogM0H4KygJ3EyqrgFtL9NkwF+1+gNYZpSj0V83mO67KNeB3ytJkYIIB8jVX70UyfEi9FVAos3EfYt3v/TFLQTKh4qTFxZQeRKZAxkSC6ihWPZ2BFPD1SlBH/fjyUm5WUkZ8UyJqEZWe5OOmlMiFACKkbpTmpIQd9wSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjKmdgdw; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a0f3f74587so16518045ad.2
        for <bpf@vger.kernel.org>; Tue, 06 Jan 2026 18:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767751848; x=1768356648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WynyOCb+C0xrwJyO/eUwFrGXGMsmrA2cIlbHyTfpriw=;
        b=SjKmdgdw7yYe9swIqy/6kWMukMveCz9PfhXTsH0Y3Vagxjmyx7B4KnM8Ju1w0e0076
         NO2BGxlvchHZzIz5YqdI+TaMLVJb/VjBRBnUq3paweWGDpr8iiPoQRV6QZSi9d79IftQ
         WAyIJxkzBakAfNbGSGP3racqPM/DJEz/QfcplJmGuoeTwWKdL/yDOsiM8GIHPI3mYX3+
         j7NCkghEU36SVlLWH2NhrAOhmwLiVD7RIIT8eKwRJC0ttAWxPrmEiv6f8UK9jeIZKEzU
         h/+f3jd9gdDHnuWy+J7ydUL3TzHd0vkm+CkUlRdDXQLj/21di0dXdmlRA8ViSCdz0WFd
         BV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751848; x=1768356648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WynyOCb+C0xrwJyO/eUwFrGXGMsmrA2cIlbHyTfpriw=;
        b=MXlZSF5vO5qcPoj/v606ZI3DfMzqMB3UZb1dOqI1XpdT8bT8BVB1CjA3/acfge182D
         OWRPvalQZ8XgKek1gSf3u9P3eNovYhKjSEu3cKYdEZX3bOdljcS4DgXmtxgJzyoiEChe
         JK6QKYuvTJsWS9wsa13TwclCHJ4tU6AmJipwQes0LDhQ82yqhX0G+d8ucyFl+ZvbWHUF
         Yrw05SBGKxANuaYmtLiLMmSWlLmGGAmxV9uEb054eU92OC0ktihQkYGujf6nRCD3eV7d
         1F6zatzwqDz253xFaSzO6HWUqJXPWcwnLPa45rxuHCBstoYm6QlrHLUmRqQ4f9v0VY2O
         Im+w==
X-Gm-Message-State: AOJu0YyRsvU2C6bbMMfh+pyevcLlrQHJwbUQYBscXFH41QxTzQw2VSd8
	7nx88l1v6pOSvI1mHyuUAeOx8qBaxYuhQqe+u+oyef1MFceqR3XKD8cs
X-Gm-Gg: AY/fxX4D8T/RSLDJpG8dJZHx7yxPOK9kljib/Cp3zSUvo3zhao+bDbrwWMB//Fu7nue
	MMOpOP+c93t46drNHAZ6nXy30tjvgVfTLCKuOKboxhC1Bg7wtXxUM3yZutO6pAoiQJ9RZ8IzGgh
	0h2FyTizIgcNFBORXrXom2h5tfSCfasiPa6FGcxC1NnKELBMX/wGDMg1WFR0Gm3ELM9zfH023fw
	S07TzCvfA52avKv02rSyzhy90wjXW1a8dH7RQjmEXUOUjEO+edn4U931mhwJ4ZZbGUu8WD2s8I+
	qRKJ8KbSpJiouaHR3ByeGEScdOFGx75sC+8PYpfY1kmwQofOjCt9+m2wuVhG2pEKGG5xXCDRPj6
	XV+diY64wBNpgHk3zdUeqEHikEfNzn349NRhreJi8ohxGw+8iXp0Kt4Rjetm1e/4UMIF+Qfh2OU
	yfmxLbm+b+4HiEw/u9yP6I5JUIjn4GwYj0CyUpqDhJPtrGZB8bcmxPJTAg4NPPgNY=
X-Google-Smtp-Source: AGHT+IGuqoSFCj02JSWOaDgM8bCQgS+XVd2xgdWjjeB9ZIL1CfWG2thjcMprL4VJkqMCpEF3K/RBKg==
X-Received: by 2002:a17:903:3c2d:b0:29d:73cc:c9e8 with SMTP id d9443c01a7336-2a3ee43896bmr9388235ad.2.1767751848468;
        Tue, 06 Jan 2026 18:10:48 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:941b:5f:cbd3:6ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc8d81sm33297085ad.81.2026.01.06.18.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 18:10:47 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: ast@kernel.org,
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
	a.s.protopopov@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
Subject: [PATCH] bpf: Reject BPF_MAP_TYPE_INSN_ARRAY in check_reg_const_str()
Date: Wed,  7 Jan 2026 07:40:37 +0530
Message-ID: <20260107021037.289644-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF_MAP_TYPE_INSN_ARRAY maps store instruction pointers in their
ips array, not string data. The map_direct_value_addr callback for
this map type returns the address of the ips array, which is not
suitable for use as a constant string argument.

When a BPF program passes a pointer to an insn_array map value as
ARG_PTR_TO_CONST_STR (e.g., to bpf_snprintf), the verifier's
null-termination check in check_reg_const_str() operates on the
wrong memory region, and at runtime bpf_bprintf_prepare() can read
out of bounds searching for a null terminator.

Reject BPF_MAP_TYPE_INSN_ARRAY in check_reg_const_str() since this
map type is not designed to hold string data.

Reported-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2c29addf92581b410079
Tested-by: syzbot+2c29addf92581b410079@syzkaller.appspotmail.com
Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..3135643d5695 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9609,6 +9609,11 @@ static int check_reg_const_str(struct bpf_verifier_env *env,
 	if (reg->type != PTR_TO_MAP_VALUE)
 		return -EINVAL;
 
+	if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY) {
+		verbose(env, "R%d points to insn_array map which cannot be used as const string\n", regno);
+		return -EACCES;
+	}
+
 	if (!bpf_map_is_rdonly(map)) {
 		verbose(env, "R%d does not point to a readonly map'\n", regno);
 		return -EACCES;
-- 
2.43.0


