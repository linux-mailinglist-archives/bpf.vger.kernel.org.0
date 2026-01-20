Return-Path: <bpf+bounces-79573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6910ED3C2C7
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 10:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 439D364060D
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE33C1971;
	Tue, 20 Jan 2026 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8KHVrYq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535633BC4CA
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768897788; cv=none; b=lHdzB4mS/jgiAPGX3yg2+MoRkB2JB1FKAQlcjJqZzwzcm7SvI2VSwzH763pqANrpyN8D6DanBGbeJSLOTvPJGTZmqi1lWIHTLNNrTfcxUxpv3lHCgOa8gFXLj8qlx+tQHOHkob73i5tyN5dkSzKbySuXbuvnq+LmMdGeKAfNvUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768897788; c=relaxed/simple;
	bh=8Tr89emgP1ROOH9GbGP0Co4KFsZQ9rj/qDR8RDJcrCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZNzill7pmDTakddaVwDk244S3Lb8qNcx25RoLClDiaiIwJWCVWZ6IyY3ucT69vKc/107eqE4LlEF+Q03qB4Aybgg02gW55yfdruA8LGuvOyRRo9yDVZOr92y3uIDjg4gLdn6Beiyu2QZZkrLM3WRHhWBYsaPZEHIXvgX22vFYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8KHVrYq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-81e93c5961cso4170615b3a.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 00:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768897787; x=1769502587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJTeK5YjYQ4mcjkjbCALrRq+E5EwAjgiZSxIxOXfm0Q=;
        b=O8KHVrYqNUR/GFzEM+5aAHFD1HXPbGkJO1em7E93+erGFUngf0OMJVDtkQKaB5hZgQ
         NHKq26wOjAy+Tc7SP4tLNEATf/uRwLAO3W/FnQfyAiH2tC6Z5uz3VrNcXMkL/Tb54kac
         2uHhJgtTmdne6xoRvhvb/zqtOHKpgvSjqqfFKQ5Ndvnh6r4y1oryG6jnqBKd97S+8BT8
         tNcngQozw9AhjLW+4e441JrpdACJBSvYXvZAhfzGFbfttCw4UdVu0+rZzFfhUoNCnTLi
         rEKhd1+hMwjqPqgoiklJ8atF6y9zIrv7USniVM27YyAublSjs3PjnDEzDr6LmeabC2VO
         zARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768897787; x=1769502587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yJTeK5YjYQ4mcjkjbCALrRq+E5EwAjgiZSxIxOXfm0Q=;
        b=WpxHKDroMKXorYfi9AmFiG72QgNq9m8NDkkVIFwyMUyYbUULDUO4Wrc7vyAWle7GJ9
         wonlncvsajafEh4I5e3cUlydwzkiZUgr2RKmwxynmeCdCmGtj/n3PDLwpMcJuE9Vn/rY
         VXRTWFxysGJF4/wFXbtTrPshQeCQFy2qlSHxSrzL/1NwI3G4b8nN12b25sAIfmsO24um
         uAW8VN0nvi4mVgaSaxmNyyCr+xhHT7kzd6PTNj1Rvbe2tpUPwWq276IMb7ikcpA2QuN/
         abWKvyAngeE5Qd5jwvkn+Qg3lz1f/y0vljSYq9y4Q2/sqdhoXT08j0erJOOck7DJdzel
         4yCg==
X-Gm-Message-State: AOJu0YxZNhZLEBQQxxFfdmslZJF575DrMIh/EEnBw3ZHAMGuUOH+1afd
	Im5NxeevrmX7uuAaFOYmMBWl9MYG0ySl5tdtfRlYcmz8Qlu8o5n44n2f
X-Gm-Gg: AZuq6aIVsrtWWB+wrMBCba2duiAhpHk/oVRb0IvJNak9WjRXkT89fnJxydQNGSaRg9H
	K74vZw4upqDre6PjK+QQPyav9p5o4pqom7+N5mlZbEACjPJiutU8S2ExlFalj7FXGU8L3bkxsSu
	PlwYG5cG6aLFY5EAn3ts5dPwqhcewLGT4Ncm2ADQbO+0ULImj7e5USboFnNt+cm0moQvpIj9BJ5
	VC2n57bFHdc/4QL2178R1XPtMNc5R12zzkBQEMZCfTAdnXNLCX+yBsiWOoO+QSmHpYpmd/Gx7QE
	B4lrnYbhFNRgP5fo8bYBQnDufk1FAxw36upcW06PgwU9Xb7vIHxDeTjHYaCcljN4or/ckZNLsEy
	Y0sKrHfW6+7QU8zdVj+qxkPblEZORnHR1zA/evE3ebJsWE3qC1cMnJ1yn83RIKwEokQrngSzhGl
	eqwyHfVTtk6gIER1cOayY=
X-Received: by 2002:a05:6a00:71c1:b0:81f:5678:cc04 with SMTP id d2e1a72fcca58-81fe8874189mr1134263b3a.32.1768897786323;
        Tue, 20 Jan 2026 00:29:46 -0800 (PST)
Received: from [127.0.0.1] ([38.207.158.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa12b51d9sm11282275b3a.65.2026.01.20.00.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 00:29:45 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Tue, 20 Jan 2026 16:28:47 +0800
Subject: [PATCH bpf-next v3 2/2] bpf: Require ARG_PTR_TO_MEM with memory
 flag
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-helper_proto-v3-2-27b0180b4e77@gmail.com>
References: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
In-Reply-To: <20260120-helper_proto-v3-0-27b0180b4e77@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=8Tr89emgP1ROOH9GbGP0Co4KFsZQ9rj/qDR8RDJcrCE=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2a+zZPdOu4shwxU65gnZc/9H6v72XNH73qxA/f3nCjI/
 KC4tzS4o5SFQYyLQVZMkaX3h+HdlZnmxttsFhyEmcPKBDKEgYtTACay+RLDP63fKzmaflfPbI9d
 vEWyNH9pnRaT1Zz1uxjq5uga2U88wc/I8E543p/Yg6kLZwtHsR2sV1z0vLtNL5B3bQDzdEW1SVM
 ruQE=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
MEM_RDONLY.

Using ARG_PTR_TO_MEM alone without flags does not make sense because:

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
index 9de0ec0c3ed9..a89f5bc7eff7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10351,10 +10351,27 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
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
 static int check_func_proto(const struct bpf_func_proto *fn)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
+	       check_mem_arg_rw_flag_ok(fn) &&
 	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
 

-- 
2.43.0


