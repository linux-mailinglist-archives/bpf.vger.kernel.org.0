Return-Path: <bpf+bounces-78091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A843CFE16C
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 14:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8849A3025325
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 13:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5FE3321A6;
	Wed,  7 Jan 2026 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOnitJg+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D23331A6E
	for <bpf@vger.kernel.org>; Wed,  7 Jan 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792166; cv=none; b=t8X4Rze2Yn3pHiRE/C8XUryViueduBN0q9PG7FGPOlE35fjePNQYglWmU3dytj3tMjH95roIumEzhPW/y//wVl6tlZcOBEQhm/YwthZsBCmYCNkaPevYT5k9rRLmgRyGYP5WZXb4ZvM/MbAvudDdnnlF3D3G5SXxQIQNEyRxqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792166; c=relaxed/simple;
	bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ap6S2gtAPv7whPaZlI45YCdpFGdpzxllmNu6k89Wi9Pgz/QEDvBcZGDB59q4PonvbjzVAZ09ZIq0pAzELVssVxNve8r+Ktj1C0M2I96AWtBv/1SU7NRqopWFIUymEjo8GYNuxKQg0gF3Huszg4ztE7iQdIajAR9Nq9328OvQdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOnitJg+; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a12ed4d205so15726775ad.0
        for <bpf@vger.kernel.org>; Wed, 07 Jan 2026 05:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767792163; x=1768396963; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=SOnitJg+hVNmVJlkwgk6o2H6/EhOte0DlJvlj8MJEn0dEWu0JMlQzYioj0qc3CIS1k
         H1ooZnU2xiniV7uT2rzxd2ZIa4Mx0SwC5yS3A0Covjgq5DzIslb14tDyddB/o55gYEaK
         Vp4Sw6tbLDxVZ6SXZDdKlQ4sJuiR0sfMbDzycke8XaMV9ujj0rh8S2F1dSUZBXjD+OBL
         gR1HN9GgQB5/GAZ3tNwHin6NSHdCnGj7UxjineA1dJuvAHI5Rxsgq+sQP7Quk3zSWnvS
         mUeb9TsipgTtm2aR2TMufCulDuurhfjCt6LCQ+WVoVyNsZCa1rSkK67jbZ4q0wUFBELL
         GguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767792163; x=1768396963;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=nK7ulJWlLrAm90Iksthr3dNA10NqPnbx6qfk8pNfFd89avuqOIEyIJgnlK/ECDMN1h
         zEmu9KB6DMPOP2NN15VjP+BfjLK79M7+JSBkg0gInJfFJsTIVpGOZwefrU0qwk5rdWtS
         mSUhyef1aEwYY2be34jgrBwOurYhB8oTvOAr5vnFCZNy/4TerFpL8LU72FMoijskLSE8
         d4CvbyB5B7WlLKxIbsPicZyqBR7M+86hl7Dp9TcrUg2Enw1yC5AI/z3MsC1sjPR3HdfH
         2JtB6z1CyHJG6fdcbG8KULNc1w0dhbiZURQJ6a8ExajAcGRHhdDuz97ThEdOJExt0Kb4
         /fbw==
X-Gm-Message-State: AOJu0Yygpf668Kpc4MA2VZEDHhDX87xkJZ7WtcBWCNPQx3K3rbJ4+xhH
	XbM1ulwz+7ND9GQBqy4onPtsfuUT9ZVFSvbZlPMXKxFaeqnNXK1uAH4c
X-Gm-Gg: AY/fxX6vtOpbZsMjEC5CwST5tufQtIJaKXIS+Sa8HKgHOYdDx2qkSwbHcUypSRYhbpH
	gqm4SDlWxnxkoeiVejN02lZ9OIZNw0xvhbkjx5ZobZ9t9Lcv9XeCgkC7HkdbicVYHTMdHvk7O5i
	/pgYUfpuqVlk2vKPtj3rwCC4KudKHYkk7QTL3Lj0dOTqae35b1wQ1P5K/5K3uKFYlMAKj4Gz8Ph
	dfLLIG4DWuv/NOLCXewrWkPLOkpK6F+n5RIg8tAlZSlxATbzjLtosp6SKcuG4TjlPd2CwGo0eB1
	fL33mR2e+HvryrfGfX390lz7HHvU2Ux34mGqc0qqI29SOP+HIoYuL66QMjM1EclcVb1ICeBAs/X
	oFPRLCvyXJgNqVE5j438twezyrK+mERmfpdRuXx6KPAqiX3kMLvMz0yyhC5q9Wi2ih8UARaCbMy
	BMSliMg9gT59AA4rEyQPYxtw==
X-Google-Smtp-Source: AGHT+IEvtZa3zLpS6a5Y/+nmtOmpeeuGMbTxkqCETXk3Efe8UmRkWBRknzvf6eczc+NkOyxjXeazrg==
X-Received: by 2002:a17:902:daca:b0:2a0:da38:96d8 with SMTP id d9443c01a7336-2a3ee443bf0mr20830455ad.25.1767792162588;
        Wed, 07 Jan 2026 05:22:42 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.152])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7912sm52511685ad.67.2026.01.07.05.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 05:22:42 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 07 Jan 2026 21:21:43 +0800
Subject: [PATCH bpf v2 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-helper_proto-v2-2-4c562bcca5a8@gmail.com>
References: <20260107-helper_proto-v2-0-4c562bcca5a8@gmail.com>
In-Reply-To: <20260107-helper_proto-v2-0-4c562bcca5a8@gmail.com>
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
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2ZcHKfXnRfM7Bz8sbOPtxaeKuSre5UuvjNs77NkU+Od5
 73+er3tKGVhEONikBVTZOn9YXh3Zaa58TabBQdh5rAygQxh4OIUgIkcimX47yj3//irmXOKCkSf
 py4VeqYl3l5yOXj/g2anJTI2DKcUvjEydH6csH5bW6CMziyV3XniFTfVHzjWFVxWcK590+SR4Di
 LCQA=
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


