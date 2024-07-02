Return-Path: <bpf+bounces-33624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA44923E85
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 15:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7422897F8
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425E319EEA9;
	Tue,  2 Jul 2024 13:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APjp0ayf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E86F16C440;
	Tue,  2 Jul 2024 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719925919; cv=none; b=u3FPXssb+tpiDFkz2WikseUuCZasnLTJTpS2iQ8+IlraNFVaGj59c1P2yNQ6gYSiX23/ImEbpiXw+R2Aw+BtvcPRuNzUyiUuROrLcfxKzlsSCrHKLg1PER2RsKxK/C3uqOOym6B04bh/i0hqKimVfA8yQ0MQMLgZhptX/2y6JGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719925919; c=relaxed/simple;
	bh=liDn5QvB3NTOv7iQ2Q/LV71tMS7ynYvrDPlX0J/YcFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kHuZ05d7HkjHqjqa+QvAFW/Xlo1D5OLY4OictuPUW/0xdfHy3VOc9UqwZ2Dd3T1JhTgJ5yeCV+Gf2HVlIy/Jo7v/+eA5o9M1qwrCYKNC7U6Hk8JfsxwQxgJpKb3eIxqpFfhethfywSgcII7CVIqW8hp6aqwDjNMUJZ489jDaDPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APjp0ayf; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fa244db0b2so31763005ad.3;
        Tue, 02 Jul 2024 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719925918; x=1720530718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zhtQtFMCZm11P34Z/J+01S+WnAXcD678eovlYxy5Kxw=;
        b=APjp0ayfB11AZHazW0gOZqOpPqKswtWPJzIpc+6LMm3tteXWnMG6J4JfYoVopSlUIg
         I7tnhGvTFIHgfyFd4zdnUnYAgSi7i+qmZeo0Yo7rpAptV7hkEkuIskjtGi6mc6j6I/ot
         HW48TJuXA3lr5/2yW9j9G+xnaaG2c9lqTJ1DhCRA1rWrbjHFiKCtRaDk82L9WRKZQ+yi
         i4/TTiJImnA+HlRoUROcx+FxX1GbOlYUhHCXjzu9/2ls4nvrpR2S0clH9+L1JZJVmA2J
         i7vedNgpKjox9WdJUFlEQPwLEvc4WJyP22vEzTrcsnD9peGb67QFfjTBlWq8Vc8X1at7
         Mq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719925918; x=1720530718;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhtQtFMCZm11P34Z/J+01S+WnAXcD678eovlYxy5Kxw=;
        b=fAIm9xs9wf53rpgWWC+NGB4J39Zc0vwL6yP9rtAvZ1APr7ZOSdncF+B7SG7DgEUGmp
         8nTtkoYS09kZCFewR+kMAqBbp4JVgHj2gyHS+t2H0n8C+lChjeje2MN/uMi3Eai2y+63
         i9NiyWm0Tb1Q7+9ZMn4zy6pjBvTQUp9qKvPIrD/b2PwupMi1BEDUCBVyStlhnJ20P4WK
         4EEzUTmsD6gpegtodePe77QwwFGGjYJdlMYCpF9Cc1YFEPQ3mCDmQO0oJlxNDqAQchbb
         41BwlyLWgyXarwcjBehVwXR3X3GoTeqts0iWkyV/9qCRHhufip7XpPRMW4H87YEpuU6R
         KP3g==
X-Forwarded-Encrypted: i=1; AJvYcCVy2gF+a3x366jSJL2h0X/1Z2HpuHT395vZFzCcFj1ZFFUjCTr/j4VFE3YxdOAXr6+e6TJ9bBRHpfmEWKX4AOn6SckhAVcg4WdffRLXrHzfpaw4vchqB8EnWHh0XiparvqQ
X-Gm-Message-State: AOJu0Yzz7GmTdUmNOerpARFJzgNU2+pwS3VsqWShX3zKVxdEh3kfyhRH
	tchTuhIXtnKETUYm/HQah6Hk+J+YJTB9AIeGG5vNfW76qFRy9tDxHS0mYg==
X-Google-Smtp-Source: AGHT+IGiT9MIy2ign/waoPuk99ueA6hjVY9lmddp7mAxqE6/faR05ZsxGiTXYWp/vXhvLfzIM7Hqjw==
X-Received: by 2002:a17:902:db02:b0:1fa:f703:6441 with SMTP id d9443c01a7336-1faf7037b76mr12193155ad.59.1719925917447;
        Tue, 02 Jul 2024 06:11:57 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1568ea7sm83773015ad.186.2024.07.02.06.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:11:56 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH bpf-next] bpftool: Mount bpffs when pinmaps path not under the bpffs
Date: Tue,  2 Jul 2024 21:11:50 +0800
Message-Id: <20240702131150.15622-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As qmonnet said [1], map pinning will fail if the pinmaps path not under
the bpffs, like:
libbpf: specified path /home/ubuntu/test/sock_ops_map is not on BPF FS
Error: failed to pin all maps
[1]: https://github.com/libbpf/bpftool/issues/146

Fixes: 3767a94b3253 ("bpftool: add pinmaps argument to the load/loadall")
Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/prog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 1a501cf09e78..40ea743d139f 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1813,6 +1813,10 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 	}
 
 	if (pinmaps) {
+		err = create_and_mount_bpffs_dir(pinmaps);
+		if (err)
+			goto err_unpin;
+
 		err = bpf_object__pin_maps(obj, pinmaps);
 		if (err) {
 			p_err("failed to pin all maps");
-- 
2.34.1


