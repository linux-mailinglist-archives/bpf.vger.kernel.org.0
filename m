Return-Path: <bpf+bounces-53783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2C0A5B725
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 04:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464331629A3
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A528C1E9901;
	Tue, 11 Mar 2025 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iphp0Yka"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B3B566A;
	Tue, 11 Mar 2025 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741662789; cv=none; b=A+Bat4zmv2YqXn8wX1qjY9hYcOPTjBvohRy99a/4Obg3Q6PMxFVWqiSqgcJC/S9ZkVNumXKpsXktCq7pgYzKwHRhQpUHebd9PsA5Lg21dYUqvoVNvU2nxAp3pOtii5P7imkqfTllAcrWTbiIaifeeQgXX4aT5/jh8e747phH238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741662789; c=relaxed/simple;
	bh=0ZtROUeAkpokWAQVTqN+FgobaxhT+KLFGVNjRKbYND8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L20xLcwoQfThyK49UH0qz4B59jxbPJFgTFApEMm4VGkuny8oPeQw756eibs8Bnaw1fpYmBoZAAVJowUWNfkvD8eMKHB9GGOjBvRHoYGK+BaZxQbQ4zy+HAwIlHPfStEJ2yqOIlUTN8gKROdY3rCzmQ4AYNBZLjbquyDo3VeGsuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iphp0Yka; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22355618fd9so91291135ad.3;
        Mon, 10 Mar 2025 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741662787; x=1742267587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUYLFFqpevSYYtdnBbdnlh9+8WjVQpn1luVNZJSd450=;
        b=Iphp0YkavsXVAHehWT2Rsh30RwvsHXV/mQLc4fE/+zi/X9wmq6eQeO35u/dlB+OahX
         xXi8rq7O3lRkp4XE9+ajsC1o2UT6xXt0XTZVCZiK1NaEZryhX8sP/XbJiicGqOhRGQQ8
         19RkC7Z/5/sq3GyeZ5oIptFRC6FK3f8sVds8Y8vaSDFyZGymb1kRudtAcDEEn78n6UDN
         syk2mqGUBD4fFFs9deeckOYAqnl6OsZN//mYtdW8BxQCDXR50snX8Nuqme0xvYUvXHaM
         8bNXodowIQHmwuAb44Uyfl+Ubss8ewvuF81phwY5zjKUg1StCgcLOAy5udRLkVWKE322
         w8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741662787; x=1742267587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gUYLFFqpevSYYtdnBbdnlh9+8WjVQpn1luVNZJSd450=;
        b=fjm6TW07mTqmZ2jwNgSreBC6NGy3LsCB76uokfs7nF4mNnxFatjuhPBlgVQVI4C4eV
         +xMnosdEGQlj8xZo8xupLBtdXyGRDUWfePb7Y1Hw98A4ArdSAKwaaSTcS4KEk+ox4V9r
         V+oioiky4BD8hzHHCNL2wVYDIXcllR+PybqtTQLnmzY4egYUeTMlosaC7DNhtKqjtyHw
         uiGvQoGmgnxyAgqxMInto0GBPUddlkNKJQwN52velHUmejbCnGuFer4aB61uqt2DgKOr
         0eaVrq+WfPMEqqRLM/ZFZ5p1gOAt3CqA3EXfgaKEJsbqIiKw1jMMGwA1uOEuK8zqmUEm
         T/mw==
X-Forwarded-Encrypted: i=1; AJvYcCUQPEbi+VEg6HWWnjFFhU1LioomPBDlcnJSwu86gtJ7ykNbQKKKzCvW5LDKC9fXQa68fwNXCBDwQigyl04w@vger.kernel.org, AJvYcCXxVFwnLHMy0Jpl5wu8KwU7G28UtujPby03jd/rhajXwu1KCwbHD69X1KXI4ktiVzv6wZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHydDwZN6as7iUYM+SYM9pUPrM+VWjecerpFgKUAOiXiZ3Cpo+
	IgGLHudUCYGQyoLR/UJjx0wZjjcySmoXsEv4eMJ8rebynpvtVSHP
X-Gm-Gg: ASbGncsqjqQEXjBFrTFY19kM/SCsBH83algmu9vbU/XLdDkiGLO/21do1FnCVVgoTjV
	GpoZ8xMOoiFlW6hq2JksYelOK1h8xYcAkEvudTyy38vsRS702xV5eTELDXloUKV38gFHFGNwVPo
	TFVqKBZaaD0QibP2URtOMowLY2udO82UetO9IkSqTf2N0GymPeq+yKDEVG42QYbOZgTy2n+Ack/
	j4GNldOHTTEDZGyYceKRA+VKIXzj+qcrgIHiv2VsU7u6R3WJoTV5itk/8wtvUDLwf9dJMNY/Lg7
	RqYG08BhjnncVUnoeqoQLJWd1weif3eGfMp7JnpniL0qg34oCFVvog0Bi7/clAaQJO2b6IpMav+
	w40mc
X-Google-Smtp-Source: AGHT+IGGHBjPW6BsrXDN2iAE8f69M3g1HchCT7q9+iNXDOQr30MJItU60zlTW17YWE29rCjf6zr0gw==
X-Received: by 2002:a05:6a00:3d0c:b0:736:39d4:ccf6 with SMTP id d2e1a72fcca58-736eb7ca147mr3593481b3a.8.1741662786938;
        Mon, 10 Mar 2025 20:13:06 -0700 (PDT)
Received: from localhost.localdomain ([112.169.118.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d36e229bsm3628313b3a.51.2025.03.10.20.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 20:13:06 -0700 (PDT)
From: Sewon Nam <swnam0729@gmail.com>
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
Cc: Sewon Nam <swnam0729@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] bpf: bpftool: Setting error code in do_loader()
Date: Tue, 11 Mar 2025 12:12:37 +0900
Message-Id: <20250311031238.14865-1-swnam0729@gmail.com>
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
To maintain consistency with other locations where bpf_object__open_file() is called, it returns -1 instead.

Link: https://lore.kernel.org/bpf/d3b5b4b4-19bb-4619-b4dd-86c958c4a367@stanley.mountain/t/#u
Closes: https://github.com/libbpf/bpftool/issues/156
Signed-off-by: Sewon Nam <swnam0729@gmail.com>
---
 tools/bpf/bpftool/prog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index e71be67f1d86..52ffb74ae4e8 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1928,6 +1928,7 @@ static int do_loader(int argc, char **argv)

 	obj = bpf_object__open_file(file, &open_opts);
 	if (!obj) {
+		err = -1;
 		p_err("failed to open object file");
 		goto err_close_obj;
 	}
--
2.39.3 (Apple Git-146)


