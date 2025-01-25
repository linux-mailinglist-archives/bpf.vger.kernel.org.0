Return-Path: <bpf+bounces-49765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE212A1C1F6
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 07:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88B67A1814
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FDF207A1F;
	Sat, 25 Jan 2025 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmfc80PZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E5207A0E
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737787968; cv=none; b=LvESOIhAWk77Nwk9j1wjMmvrQyIqVv+pCQjnyxX1mp+bgXhgQRJNXQf9hB5be3qXlCJhPFHjTN9DbujcVxbQp059ER8jobvILLlUQTkKcjJSiJY1VtRnp9lwgep6av94f2j+tw4H9+UMTpAXzP3Edadebuw91MW8snkwnM0aisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737787968; c=relaxed/simple;
	bh=2xk4GflnDVL/9cCJ4tZAWRvfzkJapFZbVQNV2R3lpqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afkR6t7fsLqENB3jCA3hnYd3QI9G0HUGgiOYxDWW4JK5faNqq3jcfPqjHi4pacHP5nMlPiZKUuXv/MMngkqoaWk6Wj+6qcu+1girMgTdHxdmknHYmPvoG2fpLN/gyYv+vxianQKOfM6kPn4VR6uqB0MeGemsYDwSVW+lNPrarqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmfc80PZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso49412905ad.1
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 22:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737787966; x=1738392766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxCiKUpxc8BoGcMZmcC1U9yhSr1dOPJaybAPqf44sMw=;
        b=dmfc80PZtj++i/tsVkDbX/J+pF97YPxtDftvVtXUxz2ISEPd8hZyY8xUQrmHwn8BRm
         3DIreXCm4InIbxypm81C8nW17e1QhQyf+bGBuuZwypRtyXROk3BNhCraqQNmM85LKfEi
         0btjH1YJ6b997rPk4Rd4IO81YGlutt/0y6F7J6qf30onr/drYgL5sLwwUdQSElxbGE52
         Xizb9WmhYcXQ77OQ2e1Ymvz2JI1Ux0m4JBAKB/scOKCpOL3/iYKjEsWzOXLk1Js0H0+O
         b0iI0CtM95xFJEXoZO7OW5EKG5UWIRsfcEGv+j5dHTynPii7IVg45wJaDLh96T7uWuym
         IHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737787966; x=1738392766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qxCiKUpxc8BoGcMZmcC1U9yhSr1dOPJaybAPqf44sMw=;
        b=MiFVCrwZyLYaalW6LkYD8BsLfjf7LsWZlekjvj7iXkcdvwSM58JmNBGJLL9tlMHdA9
         /Bg2s37MS2tTUXA2yylip3AVsb6k/77hU+e3OXkpkbfpBqt9yITOVQAiLmJzq9RxXQsi
         XjTlpTfyHAxTETTX0H5ociuLJ14kTUPLQgJHSZG4SW33O2eJrcNnOo+7KRqWfEgr4CY1
         V1VBxf1mVS1gg2oR0yDDNCYmPyo/900C86Vc2Qe0Fb8vFb7Zt7XBqyQr/38SAaxolqDt
         YQZ1LFxO3MCaI2S6ULSdLCyEi0cT8ewBR0XAW9Bbm7B4YMu8PFnWB4Uqepf33+Itqzos
         5iEw==
X-Forwarded-Encrypted: i=1; AJvYcCWBQZtgpe/UIS72hxqxl0Eya55RCKsNZ+eh+NI/rpTdUZOpYj4+i2HAmjBgOZgfkGuc5Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2JKqRBmH5O5QGOeUXhmj+bEA5JfHmplcWJC/rHBKD8SGrEhw
	WLdiGyZGZxwGtgG1m/l+3deUQ3VZEu5Ds8u0blSDgDjPFQL1jqK0
X-Gm-Gg: ASbGncv7xwdS9naHxoY+IXmFllTaead/aGa40mcXH5uA2G5c4wUyIMDqTOF3Hf0CPL4
	UREwScHutxgfcvCT71JecPPPVFCzSIykuQpUi8CzvK/8RQxiXnJzg+b5A1cZGvB8fiMdhsobpvW
	xv14GKnc+0H4Q2ZW4/wDxeGhIB+a8YxwAQoE3O6pGuf2a2+kO0xEDe1QjAYtnqrjdOG3oz2/DMK
	gHYi8HRhxRt0HJqUp8TIlGXKEN2QMLg56aUp2Zjq0stB/Pvgry5ZMEvfjNcd5MRfr9DITUDUNi0
	JwGNevjU8JWgKynnO6Hmhniov5HmTT48izw+rUVCxPu3quiI
X-Google-Smtp-Source: AGHT+IHDw43KbdiGICtI3iCJjOJEZlTD4A9c7Xei30IHy67e9XIg6IVNDSkIHRhaBn7mOsB65WnKMQ==
X-Received: by 2002:a17:903:174c:b0:215:4394:40b5 with SMTP id d9443c01a7336-21c355dc59fmr467606705ad.43.1737787965926;
        Fri, 24 Jan 2025 22:52:45 -0800 (PST)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da413f28csm26492735ad.136.2025.01.24.22.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 22:52:45 -0800 (PST)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <itugrok@yahoo.com>
To: shivam.tiwari00021@gmail.com
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org
Subject: [PATCH bpf v1] libbpf: fix accessing BTF.ext core_relo header
Date: Fri, 24 Jan 2025 22:52:36 -0800
Message-Id: <20250125065236.2603346-1-itugrok@yahoo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CALz0HOrGei1UTAkceBZqPjGkY=6pRhpjt=b63bhhgPjF7_E9Gg@mail.gmail.com>
References: <CALz0HOrGei1UTAkceBZqPjGkY=6pRhpjt=b63bhhgPjF7_E9Gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Ambardar <tony.ambardar@gmail.com>

Update btf_ext_parse_info() to ensure the core_relo header is present
before reading its fields. This avoids a potential buffer read overflow
reported by the OSS Fuzz project.

Fixes: cf579164e9ea ("libbpf: Support BTF.ext loading and output in either endianness")
Link: https://issues.oss-fuzz.com/issues/388905046
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 tools/lib/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 48c66f3a9200..560b519f820e 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3015,8 +3015,6 @@ static int btf_ext_parse_info(struct btf_ext *btf_ext, bool is_native)
 		.desc = "line_info",
 	};
 	struct btf_ext_sec_info_param core_relo = {
-		.off = btf_ext->hdr->core_relo_off,
-		.len = btf_ext->hdr->core_relo_len,
 		.min_rec_size = sizeof(struct bpf_core_relo),
 		.ext_info = &btf_ext->core_relo_info,
 		.desc = "core_relo",
@@ -3034,6 +3032,8 @@ static int btf_ext_parse_info(struct btf_ext *btf_ext, bool is_native)
 	if (btf_ext->hdr->hdr_len < offsetofend(struct btf_ext_header, core_relo_len))
 		return 0; /* skip core relos parsing */
 
+	core_relo.off = btf_ext->hdr->core_relo_off;
+	core_relo.len = btf_ext->hdr->core_relo_len;
 	err = btf_ext_parse_sec_info(btf_ext, &core_relo, is_native);
 	if (err)
 		return err;
-- 
2.34.1


