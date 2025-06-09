Return-Path: <bpf+bounces-60073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DFEAD251E
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 19:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2197816F092
	for <lists+bpf@lfdr.de>; Mon,  9 Jun 2025 17:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5318621CA0C;
	Mon,  9 Jun 2025 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dy59W2SO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF8E215766;
	Mon,  9 Jun 2025 17:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490775; cv=none; b=plTu0aNjdchS0adbc8wVh8LvOmZ6iqdoayrZMV+DH+m+tCWjYtuKajJCrY77Gc7ZxeTrx+cJCJuX/gNe08uv0YyuTVeRIcA4mVJU5J55hg6IjP9lJ3sumtFqIMdHkJFw3Ha4+XMAkq3KhNMssUBdX/+sk90cw0MpDwDvkbs1iDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490775; c=relaxed/simple;
	bh=o3PREeO4DOrU7ekFiopqC8hOe4/3H9IhP7e2Wtv14rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sF9Tazj+qj3rdV8Sh/Ag7Za0hJbIJjvKBzJuATdYomMT4RLGRJKv082Vf3Zf1jkYslRkRWQgEfM27jPQoGSRsC7AkqUUh181016exRrr+p9nPZTB80aKoz2VuDPm9JHX+9ILnsW3Y35tONVqk2JODENWEoGbXvLtfoJYSWDa9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dy59W2SO; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-af6a315b491so3823621a12.1;
        Mon, 09 Jun 2025 10:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749490774; x=1750095574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIBPFAGPp8hXcKc/4wwQc/egzYY6bQX2XSKLxjUmpLY=;
        b=dy59W2SOtAoihFrxYMkHPqTudxgPI0YZ5ToYCUvHlzm4JE5mbuEHFnxyKgrnguGxh8
         mhkvwIxTpLTAjT3AHlVfCq7n2s29VM2C0WkSe/Lxigb15e3VBjcSDuHwHHEgioi7YIe8
         OUM9FUFveb32hSxrgBhHCQwGX7x5Xwc3y5MBukctKoRmtVuaPVNs6jAsT7FGUGKCYkJB
         wbpTzB4ykGHRGjiMk44hlMbZsfmMb8TO1Xsw6Gk0yi0TBrHHICY0sglYu7RH1L/I4ddQ
         osYeWAh+99N5NNqVS2DS47ZxNmlcFuPEiVYxaDM3m5DEpVWjw+V+9A6yQ+KL8Q8KhTEx
         rq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749490774; x=1750095574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIBPFAGPp8hXcKc/4wwQc/egzYY6bQX2XSKLxjUmpLY=;
        b=XgMClZGbmVuabbM+1YxQIKbPT2RXYa/+jPKI4YAWDQZVUqcIpHzsrjeW6X6gy8Due3
         ELrCemVxZELsGydFGdZLz9Ws3OQF3lmFRw+WYiU4pb8zrS9jhtf9u+F5GzVsTlkYjMgI
         lFE5URYYXZ8zwwZr3+GxBGeiFa9YrSwjoEUMAyvbvocwALtSvX7hd2GySle+sGbq85UU
         WKFoFsadEQxKiCc3cyidmWu3jY0o0WYMLmyqHAv7RQTHxrbS8G8IzzDf4d9Z4HkaXXtm
         mVZccHxWE8d1OGwLAS7zpNnPoPz9E6XjdYt/0iBglD1zVelw6P1icmmv2l0DQYpnft3f
         teqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXTsGRkONW2Jd+zyIJb9nxwDUCH29MJdJAUETO0AcAqshW/f8+JYRiEdhGxp5G4Bsn2ldYqAAEYAUFu5CB@vger.kernel.org, AJvYcCWy3+YqebpI3kRA/Oxi70hGk4fgjlMQqMnbGtnCSMo7GRHOZNahR1GgoUBW4mmRsOiI67I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHLWjh0rMtPSuF+kv5PnXILbmY6RawD/FaaRaqNnckhSW450fA
	+cW95V3xAu0Xtt7punVgjpLgdbTG/bT7lXGANcQm58tU4pQPR0UU5Yo=
X-Gm-Gg: ASbGnctmkBNjc8qhGl4Tn7WFx0izkPDUWGHxlsXqTlXl++PfAdqfbEl05RMGgLjNzOI
	9wXtrpi13x12SZeKsUg6ghyIPc7tRf9MMng7dr5E3TcaliY0B2LK0EOKIgDh8ez0xgOjRfiLZpF
	cG1kywlbGatH5cAZHIpwb31+7cO018M8c3mkmfW+Gye4jT9fJ7HFli6tDXzY6RUSGtGlneGavDr
	RqUrRNbv+78wdNtH9dx7YuYzVy8auLvoxtt1K4vol+5iS6lIAKTNnK2oqCImtctay1P//iKgRBM
	qxdZguvOFsm0Ex7oJ7LZsqpzIsz8B7gJZQKEirX48U1z4tPdBTr4r/j84uT/wtCT85sTq2s=
X-Google-Smtp-Source: AGHT+IE9KMa9l69eTnubbzgLEvHrPpwQoVF8z70wRp8ljIOdlocN91B1ZfBA3RHHH+CFtn5cN1pZAw==
X-Received: by 2002:a05:6a20:160e:b0:20b:9774:ac6c with SMTP id adf61e73a8af0-21ee6853262mr16219357637.5.1749490773373;
        Mon, 09 Jun 2025 10:39:33 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.129.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0c212fsm6180691b3a.135.2025.06.09.10.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 10:39:33 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	aoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH] bpf: cpumap: report Rx queue index to xdp_rxq_info
Date: Mon,  9 Jun 2025 23:08:52 +0530
Message-Id: <20250609173851.778-1-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refer to the Rx queue using a XDP frame's attached netdev and ascertain
the queue index from it.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 kernel/bpf/cpumap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 67e8a2fc1a99..8230292deac1 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -34,6 +34,7 @@
 #include <linux/btf_ids.h>
 
 #include <linux/netdevice.h>
+#include <net/netdev_rx_queue.h>
 #include <net/gro.h>
 
 /* General idea: XDP packets getting XDP redirected to another CPU,
@@ -196,7 +197,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 
 		rxq.dev = xdpf->dev_rx;
 		rxq.mem.type = xdpf->mem_type;
-		/* TODO: report queue_index to xdp_rxq_info */
+		rxq.queue_index = get_netdev_rx_queue_index(xdpf->dev_rx->_rx);
 
 		xdp_convert_frame_to_buff(xdpf, &xdp);
 
-- 
2.20.1


