Return-Path: <bpf+bounces-79378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DF419D39354
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 09:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 762293033665
	for <lists+bpf@lfdr.de>; Sun, 18 Jan 2026 08:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF11A2857CD;
	Sun, 18 Jan 2026 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT8HcWPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40A283FE6
	for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768724257; cv=none; b=EU3WzU0kzHN/cqp3IlYu/WqkmaNRgxg2L6vDHc2TacjhDOLdWoF3L1HBf6Rm2DgFzWR5J8nXedUCVc1r8b2bxgttU/DSA1yS/GrbBnfdpGqnceBZZG2neQRKP0jEg8nEZ3R4olSqyVz02ejE35jWMwMOnvCX6mR/0SFpf2hSfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768724257; c=relaxed/simple;
	bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmfwajxv4Pjur+nWqkk/vyDSLBP58oTI/NLAUW0YkSU46vgSWzzgeHmnOWGdJpJQTwiT9yDj2h+urvFfNT1Op0I1L0ufhN+0OnUuQ2WDKjBGG7PPzzS+6EuTAVZ2tNIleSDKm22Q0oJylNfeiIXeHPvs3RSskAFHtP9ghvm4Xmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT8HcWPT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-81f47610542so1632399b3a.0
        for <bpf@vger.kernel.org>; Sun, 18 Jan 2026 00:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768724255; x=1769329055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=LT8HcWPT5bXV14eQDbR5ZpADYcB04gn6IGQCq4nyl0W5Hdn/8dKzg9pCLSK/5GvtBY
         6y02qMyV3dQ2jWNBIuvKp+CjLIQLwhP3uU9fzwAFBNxrgoqYKxMn/1wick1vZjexyuCo
         T/UfBI2WnLHDpPBfHDn5rSsrYobZKRh5l+eEwh8r6dl5hZYXB6TSPKErke42DIbYjmlp
         qSvBNz20IXpCiEJECeyzDQchEBxIZ28vN8ff3cXN57RHhodD6y2Y5FXAAVaVIy1KoL4+
         jduGOWhZAKNrP1nASDi6ypzQNZOSUVMlqqSfhKRAv63IdghKIWU06TihC9gQ2aOFU9SZ
         YoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768724255; x=1769329055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=hmTuWwL74awDUUGh7C3ookrUXpAqyZuUHjDzwgMAfwDjekFJcwSb67f0zGdjJIF7ya
         TKJan/xxyug9u4hHcrqKDZMzbNkewi0advkwcfE7cbBbsATW02ImL4lGME7Ln04fSLM+
         OIzWvbGCZvTBMy5wmC5bWrF8PKQM6W1yEHN4xGM8qqyN+teLxM2CvfS4JpM9tkJIC4g8
         hVYnmQvl5T8LZ76YBqioCM+Ha8sMOfoyEyMWQrfG5N9lJFbFzZkeGQ82voigFA0y6kj9
         0UcpG69VJrMXrmj2rALzUg2MYRxg7cuuFVHGCiiNkCd4yB6PDZfuGFQOePZCuwJXaosK
         IDjg==
X-Gm-Message-State: AOJu0Yy0d7WSnZSUIDioyi0IzTuHGlUZu21nKxuEQN039xou32fJ88fI
	hLBxKmx6WmzJHB9sjdbr1NKPayJU7pmmeXKDB96V/8brjkzPLX9gAwzZ
X-Gm-Gg: AY/fxX72XGbG5RzmtSdf02rDW3CT/Xz5yXX/iawNjPb8dzlKTf/SJ1m0u+Cl8VDtsgb
	HQ8c061x02WX0EDno+lKDkYBU7lfKQVrHwJ+3cTWVpUnmnBkNw6F25qMNeXsa6NeLMcINCueof2
	PtE0028/+UzI95oMonJHK1LXGBB8QdBJAzGIl1G9GorSd9RUyJRzRC4fy+q00/1YsgUw5hP0hF1
	p/UU94x1M+0LOi4sMI2L8jnJvFzs0h2UQXsk8aM/h6APtbCvIkefW1AAPKEdpg+cpYHMwuX8zn4
	CtBvyrkdbPyfgQWTq4SpYrQ9SU2ACqB0AOadr45rOP+cMa6Vz3CMEMdyCxR5DhOqQ/HxaogBeD4
	Qj1PYkliTpuKPvnlwdKaTC/OuWgPDgoO+YClZCTl4xjTA2XmTW1DBdcBPouEaOF+ZdasAeQ7Pqq
	Oy9CVSHfCMuruXuO+w8Rw=
X-Received: by 2002:a05:6a21:7001:b0:366:581e:1a11 with SMTP id adf61e73a8af0-38dfe7b7928mr7482687637.57.1768724255185;
        Sun, 18 Jan 2026 00:17:35 -0800 (PST)
Received: from [127.0.0.1] ([38.207.158.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf32d1f1sm5917393a12.22.2026.01.18.00.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 00:17:34 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Sun, 18 Jan 2026 16:16:40 +0800
Subject: [PATCH bpf RESEND v2 2/2] bpf: Require ARG_PTR_TO_MEM with memory
 flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-helper_proto-v2-2-ab3a1337e755@gmail.com>
References: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
In-Reply-To: <20260118-helper_proto-v2-0-ab3a1337e755@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
 b=kA0DAAoWjB93TexNMocByyZiAGlslwmgYRVZhTO3qL3UsMid+RZOeXbWOpsd0zTWdjPWIO6Ej
 oh1BAAWCgAdFiEEjfgx3alpNzO2PKDBjB93TexNMocFAmlslwkACgkQjB93TexNMofGegD/bVmx
 NpxLhZpwcPmfmGiSQe9wtkkYlM/Yn1TmaXKzOsAA/2BlLQ18OzDlgrEM7caUN9DYcUNOzu5Pyqb
 v0hd78ZcC
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
MEM_RDONLY.

Using ARG_PTR_TO_MEM alone without tags does not make sense because:

- If the helper does not change the argument, missing MEM_RDONLY causes the
verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
verifier to incorrectly assume the memory is unchanged, leading to errors
in code optimization.

Co-developed-by: Shuran Liu <electronlsr@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..c7ebddb66385 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10349,10 +10349,27 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
+static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		enum bpf_arg_type arg_type = fn->arg_type[i];
+
+		if (base_type(arg_type) != ARG_PTR_TO_MEM)
+			continue;
+		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
+			return false;
+	}
+
+	return true;
+}
+
 static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
+		   check_mem_arg_rw_flag_ok(fn) &&
 	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
 

-- 
2.43.0


