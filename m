Return-Path: <bpf+bounces-53711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3654A58BAA
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 06:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0658F167928
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 05:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D31C5D6F;
	Mon, 10 Mar 2025 05:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgI5vxqO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8EF170826;
	Mon, 10 Mar 2025 05:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741584368; cv=none; b=ToMFgvm72XZLpwJqPgdGVv+XIQNgQ3nCHlaNdFeK9MenyvkARVZhcx8+y+Q/TYICWyp6JoHl2UN+dyjS5Tj83Bhg9DIAp1l5eHlBiVd1mn08MTIo3Mv3ND7CnfOeEUazM7ffobQpO+0lPaunCWKKdiHWhaHhPsHxX9pzabK7qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741584368; c=relaxed/simple;
	bh=d9HI141t+tngtuQsWIvkBlJv10xKsxqAz75LMzjXzmI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SBeLV18e+XpNvXnysVsefSAMZDqU4D3tLyAc/QiIEK+3NA8B58TK7qPLS+AX/45L1YQfNkHkSQK8kL7zSZQR1uYZaVhDOyeWSf6t3DrBCUceziJ4UvZt0Liqn8/uJBrinQMlXXWjZ2DDyVTtJnfWrPIyZU4aiaipj1iFBrZDjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgI5vxqO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22355618fd9so66831285ad.3;
        Sun, 09 Mar 2025 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741584366; x=1742189166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGnLrTOtHeLoMe//QnihHUCvulpg4585SlVvplaBcPM=;
        b=SgI5vxqOgcPH/4ws9LeJmeN4nCRWAMq9N7dOAoYT+A1ntCnr9HNJ6L7hm9EXaI1ODZ
         2YDSdRQDMbgGBWABFHhkdWP1082jzjUN1XJMw4zqSgVZyZYlTRkSyTM4qEaoFE2MrsYF
         ipr/L6Iw6clWa7zNjZId7byuKdY01L3FPH/REC8DPQagM6ko1rwC8dT/2o+UiP3vF+ry
         DIFw4P2jjNyPC16KSGnniG6jS6gEv8iEeeK6U4paFjia0tl52WkBlnnlhhzL2XtMGI/p
         ItE6AmUY6qKnkgErZ/4cqk3/2Od/khk5iFOGo59TfkRdBR8YShBRvjqEwHRagDxvLDCq
         EuuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741584366; x=1742189166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGnLrTOtHeLoMe//QnihHUCvulpg4585SlVvplaBcPM=;
        b=X/2PZKTcpzplWWEy7z0MXbpFjISP/eQyAd848M6RPCtetnFAgK/lXHFgitovLhWhTE
         RSmundfPuXKUV7C2WtJR81dn5AwJ9aKFdIRkhRTvSD43kyjDfVd/nPp5CT7xCYZ9bgJF
         O5rPCKkRaWo+c3nYykoxm+o6cweMyqolWULKme+kHW0dgv14kzCsxSy5Ms9S2FZKUfer
         JYvPpXfpINZn5sr1JMoPzfDlc8VOisMqDfI7/j9l8WI8RB9tn3w/GuY4qeEUmcoeJ4aF
         j0BiFB0DkEDoI7Knz3ll27Je5vLs3bOR4mQrwGC8ts6R1djNhSxLYSJaeiSv/3n3dma1
         Px6g==
X-Forwarded-Encrypted: i=1; AJvYcCU17DGeBLZ6flSZU8ozai01rezGCxC29M6CYQZmi6pqvqnnB6xiWD8dUeTddP6flbszsrIxWtO4JsRegdPz@vger.kernel.org, AJvYcCVNKyXny2dgORWU3/septdGOcIV1t4LPR3xCY9iCjJMJSVldGuYZsRXVp2/8lDh3mJTmgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDf1Iv3e2MyCcisZLdLe0tQul9pdV0byXgeAIEHnYfBBzVIck0
	IkScsz3/y9oXhowHkbOPkgXXAUm07u1e75wOm1CSNm+vLJYougXKeoriYYru
X-Gm-Gg: ASbGncv5fWugskfFIx2JKxKrw7AKk3VQILEq/6j3jpLBagoc8Cu3a0rkTtumJQ7knsp
	wxfDK8WcPJOikbvloYEOhCwCakEOGlvy2BeujX5l+Xftfa7RMJgb/t4eSBLmFs9Eifa+bbhAg2x
	mfh6CaJFfTZIMfPzA1VjgohajT7m/14gqgSygNZXWQwfPwwJ5mXDOqfJln3EdW6LxRVw5DeD0L1
	QU61mqs+fa/oxyxQMpbEKhAceUdtgY7jzWUkKOyHOgpxrDLX6Iv+kre2+YGaTEqL1ricCXtNrel
	DiAavs3RJ6ZavfoyRXZFM7xGtnAnZOWAK9vBnY68Al5lJfa1nHIaZwzPH0chBAml2zB7uQ==
X-Google-Smtp-Source: AGHT+IFLuVJSNluyOHys4pNFQ2zYh2B7JExbD0EFn5UvMaA/KQjCmTKHzWP5Tl0sIFuvjlAmGJBQ0g==
X-Received: by 2002:a17:903:19c4:b0:224:26fd:82e5 with SMTP id d9443c01a7336-22428bf6d24mr224360065ad.48.1741584365696;
        Sun, 09 Mar 2025 22:26:05 -0700 (PDT)
Received: from localhost.localdomain ([112.169.118.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91bdesm68417555ad.176.2025.03.09.22.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 22:26:05 -0700 (PDT)
From: nswon <swnam0729@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: nswon <swnam0729@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: bpftool: Setting error code in do_loader()
Date: Mon, 10 Mar 2025 14:25:55 +0900
Message-Id: <20250310052555.53483-1-swnam0729@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

missing error code in do_loader()
bpf_object__open_file() failed, but return 0
This means the command's exit status code was successful, so make sure to return the correct error code.

Link: https://lore.kernel.org/bpf/d3b5b4b4-19bb-4619-b4dd-86c958c4a367@stanley.mountain/t/#u
Closes: https://github.com/libbpf/bpftool/issues/156
Signed-off-by: nswon <swnam0729@gmail.com>
---
 tools/bpf/bpftool/prog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e71be67f1d86..641802e308f4 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1928,6 +1928,7 @@ static int do_loader(int argc, char **argv)
 
 	obj = bpf_object__open_file(file, &open_opts);
 	if (!obj) {
+		err = libbpf_get_error(obj);
 		p_err("failed to open object file");
 		goto err_close_obj;
 	}
-- 
2.39.3 (Apple Git-146)


