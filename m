Return-Path: <bpf+bounces-12616-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F9407CEB8C
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71BE1C20E95
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804E339878;
	Wed, 18 Oct 2023 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhHQxBLv"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D5239861
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:02:08 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CF9113
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:02:07 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57b74782be6so3899069eaf.2
        for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697670126; x=1698274926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/s64ybxh3SIykvx36VJBDmDk6npodPlCgr5zaGbo0g=;
        b=WhHQxBLvian6Zn2PUNyC5hbkSpqyu6FnJIfWsSveppoZWYaw08Moq4AUiRw2tFlMK8
         s8FPR9npcze7FsSpqgJR1lZ2vWof+um27L6WQFuE/xK7RZGfXpxSPWdJV1wQoI6/Ny15
         5+VArp6sFPEMzcBYPFx8QpxeA0afgLchQFsjhF6mhH7Al5OL+G0Sfqbv+FICSLXY/ipu
         BMRknUOY01iRS1Ttz8vM+gX8RJRVDGEM712MYjNHNPxZREEhzLLFhy7JN6V9cK97wWLS
         q3yfzW1ajERYYHZUrZHBYgLDslaKztwaxfi1a2EOO5MBDGoLLMOJSUwNNTpwAGPJVUor
         HjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670126; x=1698274926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/s64ybxh3SIykvx36VJBDmDk6npodPlCgr5zaGbo0g=;
        b=REeznvWr8gT2Ks+62UTzHXNrDnvpuYR8132JdL3MepZCcj7XPuOgXs3OcbSzagTXcq
         JGabaa66B9qqKzcySbTR6OMDK3ykb5eEez14KzcFvsmdSYi0zhsPJtdyjdCq2VgPbaxv
         CnZixszOHDSMCs8sEUq5MHpHZR28m9JxlAfsW5HG28UGjFciD5VZcIg3F4wZmRClt7hf
         xt/kLHvT5t0A7cA/jyQUyucrS8nBlS+bZKTTqn3cI0/ePTGrkT24BcteilhVGzDwsyW3
         S/mm7e0yF1Tcr/6X8xfiYwR/bf4QWPJ9fD3OgzouCOEayrMu7hm9zQQnX/a2R/oAafzt
         1ubg==
X-Gm-Message-State: AOJu0YzUqzpkp+S1FnxSnoDs9D6CV+fhELNSnkQszI/xI5KdHM3YxwJM
	w7ojGpMeKpnETT489ElDJnhQboB/PENKrzNe
X-Google-Smtp-Source: AGHT+IFffo4xaahXNRhq6L1tpevC5hzW/bZW8uZVNPm5OZDVQ8xkf2QFjLgLdlLfi2y2Lgl+NWR2Kg==
X-Received: by 2002:a05:6870:3c8b:b0:1e9:efa9:1199 with SMTP id gl11-20020a0568703c8b00b001e9efa91199mr989305oab.4.1697670126129;
        Wed, 18 Oct 2023 16:02:06 -0700 (PDT)
Received: from localhost (fwdproxy-vll-118.fbsv.net. [2a03:2880:12ff:76::face:b00c])
        by smtp.gmail.com with ESMTPSA id y28-20020a9d715c000000b006c4e3d1fdf4sm834227otj.14.2023.10.18.16.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:02:05 -0700 (PDT)
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
Subject: [PATCH bpf-next 1/2] bpftool: fix printing of pointer value
Date: Wed, 18 Oct 2023 16:01:32 -0700
Message-Id: <20231018230133.1593152-2-chantr4@gmail.com>
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

When printing a pointer value, "%p" will either print the hexadecimal
value of the pointer (e.g `0x1234`), or `(nil)` when NULL.

Both of those are invalid json "integer" values and need to be wrapped
in quotes.

Before:
```
$ sudo bpftool struct_ops dump  name ned_dummy_cca | grep next
                    "next": (nil),
$ sudo bpftool struct_ops dump  name ned_dummy_cca | \
    jq '.[1].bpf_struct_ops_tcp_congestion_ops.data.list.next'
parse error: Invalid numeric literal at line 29, column 34
```

After:
```
$ sudo ./bpftool struct_ops dump  name ned_dummy_cca | grep next
                    "next": "(nil)",
$ sudo ./bpftool struct_ops dump  name ned_dummy_cca | \
    jq '.[1].bpf_struct_ops_tcp_congestion_ops.data.list.next'
"(nil)"
```

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 1b7f69714604..527fe867a8fb 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -127,7 +127,7 @@ static void btf_dumper_ptr(const struct btf_dumper *d,
 
 print_ptr_value:
 	if (d->is_plain_text)
-		jsonw_printf(d->jw, "%p", (void *)value);
+		jsonw_printf(d->jw, "\"%p\"", (void *)value);
 	else
 		jsonw_printf(d->jw, "%lu", value);
 }
-- 
2.39.3


