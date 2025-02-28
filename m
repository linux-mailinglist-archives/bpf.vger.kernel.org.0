Return-Path: <bpf+bounces-52889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC1CA4A1F9
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 19:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6191175676
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 18:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E3F2777E4;
	Fri, 28 Feb 2025 18:44:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0FF276046;
	Fri, 28 Feb 2025 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740768243; cv=none; b=MGc2CuKUmrh3m8UEF+rhwDQK7wSzIRoAY7CKlwUxK+lVJB7mA2cThfeQDRivlSqaH6ujp9vVeDQkqc9c/kSjw8e1Za624KSh6WzYnk7qjsk0LyYBpG+JCSPunkTrz/e3eQPnMDfp9q7yFo5D1RodGRbfKIvRIE2r/1GcTQXZcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740768243; c=relaxed/simple;
	bh=3wND4cVdpzynv9NUjR9Ag60vwvN9JraHBuNG9aEEn7c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kOb4WNGZ0+f9KIbq4APKQOKFkmod3vEjk/qWvJme6F4Ns3IyMtefq0Sq4A6eAvJlDtEI9ERl2Jm2N0H5z/Et9tlMqjFtqkyV5rIaYP7XlkzmzaOwV4I8MYkBvJ4THO+VKoHEwbfkkCbHITHhApnI6bTOze9yPwi6qD3tZgL4Qbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so3782780a12.2;
        Fri, 28 Feb 2025 10:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740768239; x=1741373039;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PaXX1D6OVNUi1phn8PndSxP+/0KWwbGmFiX5DxVdnyY=;
        b=oGugQJ5LkZY94eH6sF4nn42zGEIw+T6Mn+3gSKTkzpQUdrHWasKmGIicP4iLjTJCSp
         vqrtY0ZmeYbixzRKkxxAjV6tDH0SpQZnFnpdTpTkYW5jlucr3iEUtweJwJQOtB1gadlU
         QFi2cxVA7wsaEy75yyMWqkJGdyjyr+fkZtleexF9LhyIu+YIh5EE23YLh2bOGYYVof4J
         POJdXAFTLRDDNiiSsN3Ug04mLBRQzQfJvuXkkvNkrJxNFeoVuG+eQDyseVuUKlf0paKW
         Y+FXLXlB1a+WH9lp0zGbQl1vvjAGqiU8bsMmIDwYsNbJlc8jNhtSpXIwjX3iiYtWcCob
         OyuQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2HOcI31d1I94HBQzamHugLpNi9q8shp7qnjzHkTcfUcfBZce9KSqbKGcGdgswrdCTy3FhH5r09fzxnuU=@vger.kernel.org, AJvYcCWne6oAFkoFUzkK10TgVvC2LZrfvRzY9hwg3nye9fspVbuelBoUEZBQVPchHYZqH05m5KPa7MU2@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPRw9JcSxwH360h1xOmXByfBlB84Arf3S3oqiZ5IJc2Mu8Hj8
	Q2q7gV6CYfWAToe4x56KcDYRHC/advP3265mJ1Zcf+A6znFeQ/2VnXwvBg==
X-Gm-Gg: ASbGncu+tgG9Yn5sRc5SDgjkJI3LDJYCT6BI1CK4N8ItYXhB5BLxYxCt0w0q1QvFpPp
	w+9Y2Xc7yjsN2AEgBK+AjOZg4b1Cfvx19pBETysJT2wj5jQj4E3WsNDAFp7g7Wb9371uJIkWQzH
	UQOrHvOrQzbTvKeMGqGLL/1vcHbFjPS05DxH2wIa1nhqaNN05bSdABrKcHO94lfnPtgWgo3+nxn
	Zh4xkhy98SVUAZqhvggJpzCtxyr3JGTL4+Ac8M/rav/+GXiKtJixlRr8geOKx109mlT0W6Lxfeq
	Q2Ky+gOV8d3XOubl
X-Google-Smtp-Source: AGHT+IHVu1CCOVI+vWWq586GMvCLtNeDC1M15YxCX1WvU5KPjvVdy1PylXS0eLtGfElhMiQUBOwsWQ==
X-Received: by 2002:a17:907:1c8b:b0:abe:f83e:9e09 with SMTP id a640c23a62f3a-abf2687dd44mr510313166b.42.1740768239171;
        Fri, 28 Feb 2025 10:43:59 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd9e4sm329014666b.43.2025.02.28.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:43:58 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Feb 2025 10:43:34 -0800
Subject: [PATCH net-next] net: filter: Avoid shadowing variable in
 bpf_convert_ctx_access()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-fix_filter-v1-1-ce13eae66fe9@debian.org>
X-B4-Tracking: v=1; b=H4sIANUDwmcC/x3MUQqDMBAFwKss79uApqZIrlJKafWtXShpSYIEx
 LsXnAPMjsJsLIiyI3OzYt+EKEMnmN/PtNLZgijwvQ+995NTaw+1T2V24TIF1SuHML7QCX6Zau3
 MbkisLrFV3I/jD6qCTXxmAAAA
X-Change-ID: 20250228-fix_filter-5385ff6e154b
To: Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=leitao@debian.org;
 h=from:subject:message-id; bh=3wND4cVdpzynv9NUjR9Ag60vwvN9JraHBuNG9aEEn7c=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnwgPtS5YEEbFsV5gED8y7xYaQZuepIgvFwMEsk
 bcV4Vy649KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ8ID7QAKCRA1o5Of/Hh3
 bVorD/9vBdUpwnW6pMfH5ubFHew8ocRp4PxUqJHL6ws2kawvDg4ZmpqQg71PD41OG+cDX0za5RV
 LC0JPvJP5E+K58tpODAxs8m5QKqkpLJIu90T72e2uu/FtNRTL744NdXntRhQB/4FH9xlEA6IUn7
 chTIyOP3R9ZgNf13ReLIy7DCGcRNNlZXiEB5eBZykwiK4l4o+hqIHjwXTRRVuV+vavBCjmiEw/I
 q84NZyQZVbH92laPZK+bCKFkMeUR2drrortv0kRxHlEsXPYHkUIcTVozibAGfSiokQXd5gK61YH
 CopWnAJWKTvfVzGH9klvpKN3Qbxusq1Ad8PVAEcYPOWCDV3f0VIFgjkwR0HP4B3/FmGAscQ5C+4
 9LJGfZCS3haUKhJEXN6wlfgS5j8CIFodlTbzArcK+yaqfwVI3pBpwCMba/BhL0LDcmdedpSBrE8
 31viMe9sF0kRZoo5+z8Jag+I14J/dYEh5AgIW2N4smMvts005UZ9SjnWrgICSbHqR/jGqIOHzsI
 j6mhuOI6/kkILpxKTF7X8FbFIN+c7Y0ZN23tPvBfMPPYbG7NtmWqLGJTT+6lRhIBOdsJt51fbV3
 HtzwPGnge7xaDakSi6cv/O6XrF0jK8rYYG0oOvzjOlqZ69ww4AVdbK66TbRvdvzPlRIUp8mbIjo
 6EA6C5TPBW3xT+Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Rename the local variable 'off' to 'offset' to avoid shadowing the existing
'off' variable that is declared as an `int` in the outer scope of
bpf_convert_ctx_access().

This fixes a compiler warning:

 net/core/filter.c:9679:8: warning: declaration shadows a local variable [-Wshadow]

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 2ec162dd83c46..c23c969cf7d83 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9635,7 +9635,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 	case offsetof(struct __sk_buff, queue_mapping):
 		if (type == BPF_WRITE) {
-			u32 off = bpf_target_off(struct sk_buff, queue_mapping, 2, target_size);
+			u32 offset = bpf_target_off(struct sk_buff, queue_mapping, 2, target_size);
 
 			if (BPF_CLASS(si->code) == BPF_ST && si->imm >= NO_QUEUE_MAPPING) {
 				*insn++ = BPF_JMP_A(0); /* noop */
@@ -9644,7 +9644,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
 
 			if (BPF_CLASS(si->code) == BPF_STX)
 				*insn++ = BPF_JMP_IMM(BPF_JGE, si->src_reg, NO_QUEUE_MAPPING, 1);
-			*insn++ = BPF_EMIT_STORE(BPF_H, si, off);
+			*insn++ = BPF_EMIT_STORE(BPF_H, si, offset);
 		} else {
 			*insn++ = BPF_LDX_MEM(BPF_H, si->dst_reg, si->src_reg,
 					      bpf_target_off(struct sk_buff,

---
base-commit: 76544811c850a1f4c055aa182b513b7a843868ea
change-id: 20250228-fix_filter-5385ff6e154b

Best regards,
-- 
Breno Leitao <leitao@debian.org>


