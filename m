Return-Path: <bpf+bounces-31094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54A8D7038
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 15:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3164628248B
	for <lists+bpf@lfdr.de>; Sat,  1 Jun 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471701514F1;
	Sat,  1 Jun 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T15xZB6W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAE4824AF;
	Sat,  1 Jun 2024 13:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717248753; cv=none; b=ip35AkpM3lY9Byo4xKx7gsWAs6N25A6z3Xwhv79tVkHeobB/PhEUcURNEn3YCaFSn/zzM0Sd5aPoRMwn4rrIPHb52Oh9ZB5ePf0F40tlfYbMbZ0num6Ouc7BFhX4qkrVcK23c7Qi29HeOkeu5hPuZkSj41xdEjsKM91EQg0o0zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717248753; c=relaxed/simple;
	bh=7EtTzVj6JTYbamSlh/ugmpPHTyQpM3qUknqMlN3dIkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikTFbhevcCsliG4rIPJ396QM1eBaAHJnDBGOHytz67PGFQACpADo2Gdn1aph3hXjc6uGv3Njl12Mnrw1sTa4AB0H0v15D+RJeIfjXrmPqA9GUP3EqYZv7+k8tp6dIuQoqOJf1ueMAazayZHTYhIu44YvdU+XDG9nq/ZxYXbiBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T15xZB6W; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a689b034b02so101977566b.2;
        Sat, 01 Jun 2024 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717248751; x=1717853551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbTQLLT1+DzwsmMMKzB43pdtvuNOrcQjXsarS5iz91E=;
        b=T15xZB6WTgLE7fpsSKzoLjYi9vMiTdSiyaCI59tWi2jsTAdoqUE6RqUmctUX1w05jb
         S47v0yNYI0i+ZBgg3JDQBFdaVDjI7tFFVWaWxGenRPZACNb02HW4P6VzcjVtMdd8NhNi
         qeIkb6ZpbX7cNz4Za7pQAxZnJcZGskzJF0BicfegsESJoUuU46FcxJAhOHY9f5gHRUD9
         DDKOAKZjfmUtVQvwHPAEXs+9MJHQ6YgcS3THB0nLoFGvUQLz0QA06bXwjHogQj6yTiq5
         ufN2/npOwqzA9Jds4/mfR/xx4k9AKwBTX6XIGj3zMrn2CsMfryB90QBN5ejbwwE3tBm0
         nujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717248751; x=1717853551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbTQLLT1+DzwsmMMKzB43pdtvuNOrcQjXsarS5iz91E=;
        b=mQWS6maxaiDuHy/i4mGkzTUAhATF4LJyqTqN+QxojccyA31vOfMf247q/3z4/FQY58
         Ex66GE/L1RU75IJbvR/SpMdPL6LZUVFNnlKNJPjIjqh8wJtJnmvz8MyEsw9727P1hdnr
         BSAJ3t8Fmf1O7wi/irKfSKqMUmG1n6I9IN7VGzlgypkzkdVGitUwTLKmgp0pqeIiGM7y
         J7aQC8A72GYGHnVgnamMYOZz9OxPRKApjVZU+roo4BaKipucDLHC9aqdfcjhAdE2fejV
         UBmtnZLOpqh5eU0YplsSYQgefe4P4D4+N4wYiUvposMkfUXs1oUXHgmywSE2v70umWSr
         fFWg==
X-Forwarded-Encrypted: i=1; AJvYcCXsBQW0Xh8mggQDYBmsSOO1IunqVFfPEbBF9Ggydu0dFoOy9+dnUpRvs/RkJiFh9l1jssTxhGZawb1nPFrv4Qp8NYCZ
X-Gm-Message-State: AOJu0YyhCKvs33myNZCCmNXZ+pndyfx9/fmMuE7VsG9aG0x4nt0IRsX/
	tFsBJuwJePDElOPzYYLNfqryJffPXIL+YVy9rZH3IxlbqoWtQ+pcUHg40Q==
X-Google-Smtp-Source: AGHT+IESMUdilidyxdLArReNIpXvuoXnGx3g4rylvMHfSoTFIzuT4u9IXvyRWpixNCsuijClJVAKAA==
X-Received: by 2002:a17:907:9046:b0:a68:413b:36f1 with SMTP id a640c23a62f3a-a68413b3739mr277560366b.32.1717248750486;
        Sat, 01 Jun 2024 06:32:30 -0700 (PDT)
Received: from f.. (cst-prg-8-232.cust.vodafone.cz. [46.135.8.232])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68a9fdfb3dsm87401366b.154.2024.06.01.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 06:32:29 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: ast@kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] bpf: plug a warn about bpf_session_cookie without CONFIG_FPROBE
Date: Sat,  1 Jun 2024 15:32:23 +0200
Message-ID: <20240601133224.674784-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building a kernel without said option results in:
WARN: resolve_btfids: unresolved symbol bpf_session_cookie

This is a bare-minimum patch to sort it out.

There are other uses of the bpf_session_cookie thing spread out
thorought the file, they don't seem to break anything though.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I don't care how this gets addressed, I just want the warning gone.
So I am not going to fight any ideas how to do it, as long as it gets
done.

 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 48f3a9acdef3..b081bdd6f477 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11128,7 +11128,9 @@ BTF_ID(func, bpf_iter_css_task_new)
 #else
 BTF_ID_UNUSED
 #endif
+#ifdef CONFIG_FPROBES
 BTF_ID(func, bpf_session_cookie)
+#endif
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
 {
-- 
2.39.2


