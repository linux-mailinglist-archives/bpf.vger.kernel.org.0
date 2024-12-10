Return-Path: <bpf+bounces-46545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130E59EB9AB
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4045728347A
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACDD214205;
	Tue, 10 Dec 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDATLtdn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C75198A02;
	Tue, 10 Dec 2024 18:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856820; cv=none; b=tBmQfKjrX7yAQEFU4ALa70ynS/GX/USO6xhDkm2XLl/fJEDLu6xGqvtPat89LmKib29+ndaH9pPlEkBrVR1N8gdaUMHAEG2R13SuIxTuSZHgkePj6yzFzrwmv43fGQu5JRJIxQnhgX3zutwjUpIL2sIHRYYdGrA8dwbleXtAPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856820; c=relaxed/simple;
	bh=TzF94QgXzQpaPKyt9mrR4VL7WfvLEsI7X97HOrLI4uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ngR5fokwy6m1XDDfVMHv+/1WaFmKIY51P/VxhHLixbLQqxIwcvtfyqGM8Qe4QX4pwZLIRubDpDNC9R2kpNlqzkO2+p+kwIeHADaBXXml7BZmgCWC0QwnYn7fqfO56hYLjFvXe+Qlqe3VOIEgSZlDF54iDuf2x+aYmbLyqBH3ISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDATLtdn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21675fd60feso12871205ad.2;
        Tue, 10 Dec 2024 10:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733856818; x=1734461618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rNsyydIwl66sSjjl3CYkU8GYTKtrGgErrtD8xsFywJQ=;
        b=ZDATLtdn6d27FApQ+7gVz6YLFE8mxGKuCzeMnXY5kO6C5zQMccrbUTa0PhYFRZD9bR
         h80h+iBniSENtNFcNeHPPaZZGo6K/N92pooK33G3kRrYsCvqulQthhA9oRPhJG0AP9rv
         NRgIhKAQfQvkkWyU1C5wDZHJWw3p7YOJNSEunSgWF7X3drncWSpW4Jpg0QfP1ZhQXbEP
         cGr+cXLUHfnx7zo0BJBWiH6rdKBCAJYITzX3W27f1SOUQyCy1mOhtb7ERJguTkOibpYO
         szx2Spk8n0ZplagtLPeyN5xoGXOcE5NWyASWiPzIXTx2rwlseMVueeav+QlYolVeubyi
         lBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733856818; x=1734461618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rNsyydIwl66sSjjl3CYkU8GYTKtrGgErrtD8xsFywJQ=;
        b=eRUBulG/n8/4mXuHmgiyeLwlptcB5lLoMdsBTbVa8eJzG1TXeSCHgIevCbwXcMBD+D
         MymjmSlDLseLamU4tWsoXhj49c5aaiVSlTgsjC3JG6N3Q16L7q30sMG/k6+8QlWMCeLW
         EOoxlrtz+wunpbrerXHc1je5fXPXrGypmY5XTvaIghMMyVaIA+ja9JtdEZoj69UaqHpt
         J5CsrY+6OvLZ43pK3ZfYSzXPXKPRqzxEy6Ac72tghzLapr7rabz+Wx2DXy+D3oxvSFBp
         /rgtrvdRcXu3345zI8eVwdyXxwWroBGJluiOiRYfe6ZpskZMsD1W5eUlvGKsNUTPBi/Z
         zA0w==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZYGKkRvQatLao/Fy/WhHLFmfBbQMmAnIB3wX5BKWNEpnPAmRX5qtuHabWUJDW/GwTTX1iyMaBp4XYmSp@vger.kernel.org, AJvYcCXAE+yGJiIlcyKVzBfqkO3j8Qf7hcRAbDmrrkTNLkqwduFFHqblsv3u2ghiWN8bLMugrps=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDPk+SUiEtAPorG8bdbq2Kvyrimuly+QyJOcNqFmMpOOruadW
	z6NUS4PMzYGIc56N6420xg6yweDxvt++1bpKZWfpY1pJARF8mVB+
X-Gm-Gg: ASbGncsyVTyt7opV2Sv2le4F8r4cwBQdzUhxkfzYP1U7I4sAZLTpDXe7NET+dXbi8tR
	vpmaHsF46o+stR8zWKp86Yd1Xr+vz1UFiKHlq7pORIdT8FQeHGkYitY53O7te0pl839Q4RqRY79
	hMuDuPnTFjjUqYXChYXHjUoJzpvJcu5W9mkpWP5ksYvTe7JDkEfIsgNj6sD3/t2/ESt4+AXrm6m
	1YyWphZk49eg8DMipENbNdzIAGaWsl4/JASbAUuJYT/ZyCE1V3Zmatn5B+zWQ==
X-Google-Smtp-Source: AGHT+IHM+cOqdFD9AUuJcFTyaadANWzTfxErpO9cPW/f/2GLdOnzOxQGcRxuhOxQyri87pGE7nX6Og==
X-Received: by 2002:a17:903:32ca:b0:215:e98c:c5bc with SMTP id d9443c01a7336-217786973f7mr3343045ad.48.1733856818321;
        Tue, 10 Dec 2024 10:53:38 -0800 (PST)
Received: from prabhav.. ([2401:4900:883c:fe07:6a22:81d1:4779:d894])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e41e52sm92675955ad.3.2024.12.10.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 10:53:37 -0800 (PST)
From: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] BPF-Helpers : Correct spelling mistake
Date: Wed, 11 Dec 2024 00:23:21 +0530
Message-Id: <20241210185321.23144-1-pvkumar5749404@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes :
	- "unsinged" is spelled correctly to "unsigned"

Signed-off-by: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 532ea74d4850..1493f1daecaa 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3057,7 +3057,7 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__sz, const void __user
 	return ret + 1;
 }
 
-/* Keep unsinged long in prototype so that kfunc is usable when emitted to
+/* Keep unsigned long in prototype so that kfunc is usable when emitted to
  * vmlinux.h in BPF programs directly, but note that while in BPF prog, the
  * unsigned long always points to 8-byte region on stack, the kernel may only
  * read and write the 4-bytes on 32-bit.
-- 
2.34.1


