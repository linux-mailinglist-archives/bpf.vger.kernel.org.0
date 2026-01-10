Return-Path: <bpf+bounces-78455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5BED0D332
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 09:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217193034400
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 08:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4682D9EF4;
	Sat, 10 Jan 2026 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dq0ffHx8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07002D5A01
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033570; cv=none; b=WRNN8Jm0IXPBciOshoRGEk/acvrdEAzqaAu2RQo9q4lvnQuBmDxXdPagZHEpu1l23NSPfl8ZsRYfcTwtfTrQEjLveUbdIUdpx89ykXR+Ffek0NRMj25TGEXOsPZ/zWw2AX0Es5wI5/G/by3pyq6ajvwyFXNaj/8AERQEraMYkDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033570; c=relaxed/simple;
	bh=whKXq2UaWgwSKq4RZq/7tWTQr5a1lYl0L1Z4K3S66gE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o9nBzQxE5F7nAIgCTvbrxZnaO5G232fhB90rZP3WMxMKPzbKIybNwyE4+1Kw9HpPOeE6Um2VPGCstM36NctrRGk0bLlUG6pU/0xNO9G8Q7vyRH2scMAtfhpEGQYu/etJudS8oxQ0OgZ/n8+filGP9KXP3UTNZFjJ3T1CLqOPML4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dq0ffHx8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-11f3d181ef2so24040223c88.1
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033562; x=1768638362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=449w4GO5uhfdBtS4/XTNprUslLajoNDu3/A2T7RPjYg=;
        b=Dq0ffHx8cuxc7SY5L5uSAO9W09tvZVV1zjpxbrGWKNph+tSQvrhSnvHTJdCyYa7ahQ
         asNsPMHxD2NLM1HgnehQEAyoJDntDCpa06rvdR4pK0PxCqwHJA2w7ZHax3D/A3MsR6M3
         jmEXqaAEMdli5A2jLXwak4pzsO9+dIi/3ADms2G4lPJ6TJmhSogzmAktU8D7uJExn+M2
         gzcn4zG/FZ6Ctw7pMccN+9pYfvbT5nuOImJfJ1ICWuomDLGFsPW55nrBW9djo8aOprzm
         SybwU769IjL70JJ1OLjrPLqf9SiqW/SgQmbL3XIQCsFe0OSmnXfxW35CKDKrWyN/xtaE
         hkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033562; x=1768638362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=449w4GO5uhfdBtS4/XTNprUslLajoNDu3/A2T7RPjYg=;
        b=s7PNfsORgDel7VjYfWrt/29LydKaXvZZYFRj750Ox5KeDyH7GLAVjThKGL6LJ3uQE2
         IAo2Ca3K5xIPvPS8kNmhf/d6G8OEAj0Kkoy7zOsjJQfmiAMUBd9AQWKoZ1p5HKQsMbMj
         7qREp31340JozBdEh4842xtl6bFrV69IjwrWM7K5F1/6bE/Voy8Me71Yj8syP2c851f9
         eHitiqvzc766TsEseqHs/umAnY90Sec2v4HjZMo0PsWEP2js2rvmE+ZDnFpgD+S3v+FI
         n8TUQSpKs7aSGjHiUKzpjTs81rktLwcbBakhwhl1mrACsLwYZzEBMiPhJd0AkHIxJoO5
         Tnfg==
X-Gm-Message-State: AOJu0YwwmF+ZZA/tfIGVU8QpdmoGiYXtp9/Q8Oq8UAVCsSM98pHa/PMQ
	lxhT2Vvbvf7xV5kWv/eC9sVmgjIxk2TSxf+zE8un9RqP9S9ynkT28QwVGX0HJc24K7eBc0AJ7Us
	+VAcc9kAyqgKpzPcKff9TRPNt3qt2+xubvwrE4xj+UPyfA6b7y4Pgdw5DWcc0PNZrNWi5Ort6Jr
	Q4mo8mzLlf3tLKSSGVPglP1K5kLnDEhMcIOoBsl4qESif/HqeTR9ZvFvoBEI5M+9+g
X-Google-Smtp-Source: AGHT+IFmCO0K26hEWmtQlpwGJLRbVYg5Bg8Mr7O4+TQDB1V1dghyXNnxJOkHNounSDF02rQTVtkHOfl1+QITfS5Xnp4=
X-Received: from dlbdm14.prod.google.com ([2002:a05:7022:6b8e:b0:119:9f33:34ae])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:791:b0:11d:c91e:3b58 with SMTP id a92af1059eb24-121f8b60617mr11760954c88.39.1768033561654;
 Sat, 10 Jan 2026 00:26:01 -0800 (PST)
Date: Sat, 10 Jan 2026 08:25:53 +0000
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082548.113748-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=898; i=samitolvanen@google.com;
 h=from:subject; bh=whKXq2UaWgwSKq4RZq/7tWTQr5a1lYl0L1Z4K3S66gE=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJlJvPx6jzfYi5ROYond+/r3wTd7whiz1s1coLJkX221S
 tIdxp7THaUsDGJcDLJiiiwtX1dv3f3dKfXV5yIJmDmsTCBDGLg4BWAiSoUMf+U+2kytUlgbn771
 1e2DYdc9iu3fc2kYTlac99+n55y7HAvD/7wZXnxBn/MWu77TymXu+3dvYU/leh4LdtVV7+0VJ93 M5wIA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082548.113748-10-samitolvanen@google.com>
Subject: [PATCH bpf-next v5 4/4] bpf, btf: Enforce destructor kfunc type with CFI
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

Ensure that registered destructor kfuncs have the same type
as btf_dtor_kfunc_t to avoid a kernel panic on systems with
CONFIG_CFI enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/btf.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 539c9fdea41d..2c6076fc29b9 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8846,6 +8846,13 @@ static int btf_check_dtor_kfuncs(struct btf *btf, const struct btf_id_dtor_kfunc
 		 */
 		if (!t || !btf_type_is_ptr(t))
 			return -EINVAL;
+
+		if (IS_ENABLED(CONFIG_CFI_CLANG)) {
+			/* Ensure the destructor kfunc type matches btf_dtor_kfunc_t */
+			t = btf_type_by_id(btf, t->type);
+			if (!btf_type_is_void(t))
+				return -EINVAL;
+		}
 	}
 	return 0;
 }
-- 
2.52.0.457.g6b5491de43-goog


