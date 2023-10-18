Return-Path: <bpf+bounces-12617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28D7CEB8D
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C991C20E4D
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D5F39873;
	Wed, 18 Oct 2023 23:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC1uHnPX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7841B39861
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:02:11 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC7F113
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:02:10 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6c64c2c0f97so4509865a34.3
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697670129; x=1698274929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh91EGxU7WVmN/7t+t76eeQKqYP9BYC/Vn2WsbI9rZU=;
        b=GC1uHnPXS7oJfTul5jm4wgY7d41gvRLepP5lcZYwJncBQQli8OYOlsmXK3uhSXdMJC
         MEfPkYC66pyJh7sKgMw10jK4ZPr3G1ue5sOvNE8jfE/eeNWNPMNvySFBdoaRe6yDZPui
         ZV43/Yu7My3/kvGemn470Y3t3Z6t3c+cHyKcQpBBhdR60T1Vsi7R2WwPM6/SaIszbCuG
         WTgmzEEOlxLK/+fxb3ma6Qj59G7OjaRaejhd0SrZ4LpP+Qm/rVxI2eTTf5C6Kdl/OK5B
         BDTxijm0obm/ZV9efUdu7inTMUo1PcbWkFY+POKXu44VIKoMZsNe7rqU5oZLEiQ8aT0q
         MUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670129; x=1698274929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jh91EGxU7WVmN/7t+t76eeQKqYP9BYC/Vn2WsbI9rZU=;
        b=B3yQcu/Hzpr3ipEUOAANefwoddSwGxiKUOIua73oowHl8zu4icUe56ZodFEk1W6wBs
         HqxjreTyuS8s5AFf+w7iZJ7JaatjxuL6nmeEQnrcqiu2K0vamfZ4vA1lOYoT7j9B5ROt
         OH98DYeUCBPb0LEIa7f3zx9/vTYLQARcGPfDdqk6tz7qn8trPLeZP5sGRT9/EB7PCFw5
         OSiKAgP6R/Bb+pKVYXYxWjU75cchpQjs+kb/lB2TCZzBRVT2X9aqL6G/USdVbXNvJv9C
         +rnmRLqBI8mi7EbLr7xozF57xVK4acKVqnGUg8lyaL6DQ7x4TaQqogP9o+ZPe0SUljmp
         5fmw==
X-Gm-Message-State: AOJu0YwWoZOulojpeU+V4ufP7fHSTzN5DnNSFrNzuoobOv5MuMewf4iW
	D1rDIb6xD4UuVwaDOYyG7nFyxcgDpNyQxF6y
X-Google-Smtp-Source: AGHT+IEhVB0xD3X91ywn0KuzVdC2SNR4GxDV7ECdx/ABle4DOb5sWD4E5IYhkOf/wQBdJ7YG07keLQ==
X-Received: by 2002:a05:6870:4988:b0:1e9:b29b:b145 with SMTP id ho8-20020a056870498800b001e9b29bb145mr981544oab.7.1697670129153;
        Wed, 18 Oct 2023 16:02:09 -0700 (PDT)
Received: from localhost (fwdproxy-vll-009.fbsv.net. [2a03:2880:12ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id n1-20020a9d7101000000b006b9734b9fafsm835677otj.13.2023.10.18.16.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:02:08 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org,
	quentin@isovalent.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next 2/2] bpftool: wrap struct_ops dump in an array
Date: Wed, 18 Oct 2023 16:01:33 -0700
Message-Id: <20231018230133.1593152-3-chantr4@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231018230133.1593152-1-chantr4@gmail.com>
References: <20231018230133.1593152-1-chantr4@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dumping a struct_ops, 2 dictionaries are emitted.

When using `name`, they were already wrapped in an array, but not when
using `id`. Causing `jq` to fail at parsing the payload as it reached
the comma following the first dict.

This change wraps those dictionaries in an array so valid json is
emitted.

Before, jq fails to parse the output:
```
 $ sudo bpftool struct_ops dump id 1523612 | jq . > /dev/null
parse error: Expected value before ',' at line 19, column 2
```

After, no error parsing the output:
```
sudo ./bpftool  struct_ops dump id 1523612 | jq . > /dev/null
```

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/bpf/bpftool/struct_ops.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index 3ebc9fe91e0e..d573f2640d8e 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -276,6 +276,9 @@ static struct res do_one_id(const char *id_str, work_func func, void *data,
 
 	res.nr_maps++;
 
+	if (wtr)
+		jsonw_start_array(wtr);
+
 	if (func(fd, info, data, wtr))
 		res.nr_errs++;
 	else if (!wtr && json_output)
@@ -288,6 +291,9 @@ static struct res do_one_id(const char *id_str, work_func func, void *data,
 		 */
 		jsonw_null(json_wtr);
 
+	if (wtr)
+		jsonw_end_array(wtr);
+
 done:
 	free(info);
 	close(fd);
-- 
2.39.3


