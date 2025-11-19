Return-Path: <bpf+bounces-75059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B8429C6E35E
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E57DE4E17E5
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD55351FC1;
	Wed, 19 Nov 2025 11:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq+3q1wD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C147350A31
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763551117; cv=none; b=cL9otvW9NQQK+HVTgGSYAWdB/T1lMaj1MniGegAhGMycg1pW3N0uWe7F7WT65kfIYis1xZVGTzRWtCenDgHZJ+pSQ1jiYMRV9mzWk1jg31uv/f99Gy8YQMbPR/7e9/HE+2eVTO8MBMx5uNhLo8AzUCaEje0of1zhhjBgglu+9CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763551117; c=relaxed/simple;
	bh=wnKmrEX+pbTq0ERf5shSOaxsLKBHldzbETjRuzX256M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZotqanjcBrK5blYV9LFFtxa4v1+1kabkDfSz8TY/u35hjqDF5ZvMyr2XSdfKagV5OBR//KHgZwfLoXIy4Sb8/q9/WZborhyvJe2YE9rOXyfpL9Z4iY9xYnLviX5RxjOxusdlVb2G3BUro+P2hXs9NXN/1hV7iYlCdaWKrMgDX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xq+3q1wD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso46432655e9.0
        for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763551113; x=1764155913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aq5MP13d+IT3N1JOi0PtzwT5WRhKDdRZny9LOhUMISs=;
        b=Xq+3q1wDfq3N8k+jvOQPAYcaZsIhQFDM7ozKoUn/SvWCPY0WJ8SWoI9Y+Xcqp/RZZY
         7vN2gT9xCWtrqfClnaCLiaASa3hMJDTzB8xw5ADOd5jeW+RPRLLGI4ZICuEzs38KYGAS
         +1k2GxQmOFz+UTlhRewJsR0xRXsXZCMzyAlT1kbq6RfBXnwZ1MKdbSd2tLQHEoR79E4H
         LlgfWHOLFrOmlAbPP9G+26AlKxjDl+umTv8H+4f0JK7ys1JxDLijGRqGHq/G5/YCas3L
         KTiZ6pa9KMpxB+LggM/6h3+bA7iHVTHwCk/S+rbyT2QdlNYDUEdkM/fnNVBg1flJXFbX
         +XXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763551113; x=1764155913;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq5MP13d+IT3N1JOi0PtzwT5WRhKDdRZny9LOhUMISs=;
        b=aHCBlCXyEtXns53eVHH4+6HKVJkIFZqmw+PXl5tjJzSntFWbL1xoprCgEpZ4Vuvgbh
         8Zx297/4LXYQE2abdSmebL4LVmjCMx/MOelw6x0/vduNNtIieDnVPZ+jyqm6JssphSb6
         RCGAYLuqrpdjAr/nSoIxgA3L8/8nmFooIJG7KivQuHAZTblfF4pELXlYt65lv4e8qC0s
         dwKGwUWzfBBGcnK7b/WCNSoDFFBUww9Q42CXOG7YHoq3UXYqRN4p/b9CU33dsNcJZFiS
         R0LfSX33UcPczDrKviH8N/4Hlivok+PKoPHfu1EdrRtv0MrKxp8EKXQ8hru8xuXK0zTi
         ekKA==
X-Gm-Message-State: AOJu0YyYl7Ybmp4LpZ+LTDDPqDZo2xksfvQTkhlTtWv0Uwlc9GsvKqnS
	aWyZdVJrKzFFOB8XFWO6Kmyqv+k4VaTHhDnpNgRdbsLHwJuab1jk4UlbfCC9wA==
X-Gm-Gg: ASbGncuAcDWZMPjQwavXPqmKIB3DzXlIqiYELtSGfIJMAm7bH6VHRLDDLZx4P/epxp/
	A9Bm0keqjjtKvIBBN3IQpZ5nBDvTK6mcBVL15J+wNdJHOnmB0GliSWoFo3Wt18sHuRnV/GsaP7+
	Fq3p4NRgK6NYCyOiV5JMmsoGcNV6RMC0QF3FNd95Hs3uN+NoFJYTQ8kJtfkXtVU5hiQnMo7uV7V
	f5vMgmOtesJNsC4PjAKE16gvXcEyvtTRxJ5x7q4d9SaLgcZ5oVCskZ6Zr1mctP0Ub6c0rs7FE9k
	d4o/9NcSIJ0WBwkzvHI/YCctgCedPbuSpJuIkP7ERAIiyhqoFg79M69LvH2ykugbdBnujk1a6vW
	978MZWn80HfUB4MGtcy7doOWrhKzcthEvsqFLtp6Nvco3pwVmzkBQoPuYtVDTLr6/J0jgFM+iQ2
	6y9jk4gtzZLrofja4ytRUI52fALJRxSg==
X-Google-Smtp-Source: AGHT+IFWW315R8A6Z2zyhbUx+Yl5My/8lq7M5X+Bm+a4cX63MhZ+GL9CoOlub1Uiiibw/E2v6sfW3Q==
X-Received: by 2002:a05:600c:1549:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-4779ce2a4ffmr146102195e9.0.1763551113064;
        Wed, 19 Nov 2025 03:18:33 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b0ffef34sm42892475e9.2.2025.11.19.03.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 03:18:32 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH bpf-next] bpf: add a check to make static analysers happy
Date: Wed, 19 Nov 2025 11:25:17 +0000
Message-Id: <20251119112517.1091793-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In [1] Dan Carpenter reported that the following code makes the
Smatch static analyser unhappy:

        17904       value = map->ops->map_lookup_elem(map, &i);
        17905       if (!value)
        17906               return -EINVAL;
    --> 17907       items[i - start] = value->xlated_off;

The analyser assumes that the `value` variable may contain an error
and thus it should be properly checked before the dereference.
On practice this will never happen as array maps do not return
error values in map_lookup_elem, but to make the Smatch and other
possible analysers happy this patch adds a formal check.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/aR2BN1Ix--8tmVrN@stanley.mountain/ [1]
Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 kernel/bpf/verifier.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..93716da57d48 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17929,7 +17929,13 @@ static int copy_insn_array(struct bpf_map *map, u32 start, u32 end, u32 *items)
 
 	for (i = start; i <= end; i++) {
 		value = map->ops->map_lookup_elem(map, &i);
-		if (!value)
+		/*
+		 * map_lookup_elem of an array map will never return an error,
+		 * but not checking it makes some static analysers to worry
+		 */
+		if (IS_ERR(value))
+			return PTR_ERR(value);
+		else if (!value)
 			return -EINVAL;
 		items[i - start] = value->xlated_off;
 	}
-- 
2.34.1


