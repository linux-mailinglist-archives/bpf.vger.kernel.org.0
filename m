Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA4C28EE40
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2019 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbfHOOck (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Aug 2019 10:32:40 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38407 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729900AbfHOOce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Aug 2019 10:32:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id m125so1430110wmm.3
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2019 07:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhCitZIE1rm8aD0lfIgbmHAyTkoG5GD5Cm1VynvrMAc=;
        b=gg/y4dqIYmFdyInphTX8Wt+EQGNKRRYTuP/SmzQe9iy6izjuTILacgzG2kklO2tmOu
         0Ffa2e0pTvph0ci0exTMriKMnlKiXSYpWR0+DtTO+5jJPGCqBIsVJAEvtzyx4gV7zp2x
         V8Iad5LDayftlcivVS/AMT4WO+8YbacgUJ+xnhE2/M9nrYMmxrMWBJQga2CVWmklxmUF
         FTDQEZljxwB0K5vdvWiN/E0hCiKqCTTu7+XLBNJbGb5Hv5bvhNfwyD81U8nIu/clMAd8
         0loOQMjFaFwWRbipRjuYZzEFi5B1LdF76Yhriag/LPmQMXcK+GA/R8C4m4ntuRLoVjIj
         +23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhCitZIE1rm8aD0lfIgbmHAyTkoG5GD5Cm1VynvrMAc=;
        b=et3QUEEn7rratq8ae7ztGZCn9ADbEeYaqiHOs3iyBUNKhZvypx71wTOsk1wtZ7b3Lz
         myg+DKvdSKIwsqPp6Whz4qpzQaS/YTjYmes6SZUSUQyJrvk/tIryYdBGKDoYm7ZlydVP
         IVgHos0mxmeahCkpO+HWaVGR66Hp66BEAAZE4vYnu1CjZKJxSfzDikM6XzvQXuL5GFFU
         BjsMTLDCQ9nbNeEKdRfbbyjhYWl0yXoZTtSx7UrM/LyQpHxIf1WmutRFzms3Tdm4hAvt
         qpfCT2f8S0rmhheKR+OYWnm41wHqozO0O2P3NsfEUg43IJGwG9HprhvuKYJT0stsA4Qz
         yBRw==
X-Gm-Message-State: APjAAAWlmixc/KyX0Km8c6OLL4/n9lzOVwA7gMWtK0T9owv0q3n+JPXC
        J4pOfzInt12xyNy1Uncns7XZ+A==
X-Google-Smtp-Source: APXvYqwu8EjSUkIT4UxX6coE1H5WsFoQ4nq4Qgbh6FF0MIKH4BTnCJT3IFRQeqwHwb+Rt0xVn3zKKQ==
X-Received: by 2002:a1c:c747:: with SMTP id x68mr3222847wmf.14.1565879552510;
        Thu, 15 Aug 2019 07:32:32 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id a19sm8857463wra.2.2019.08.15.07.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 07:32:31 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 2/6] tools: bpftool: fix format strings and arguments for jsonw_printf()
Date:   Thu, 15 Aug 2019 15:32:16 +0100
Message-Id: <20190815143220.4199-3-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815143220.4199-1-quentin.monnet@netronome.com>
References: <20190815143220.4199-1-quentin.monnet@netronome.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are some mismatches between format strings and arguments passed to
jsonw_printf() in the BTF dumper for bpftool, which seems harmless but
may result in warnings if the "__printf()" attribute is used correctly
for jsonw_printf(). Let's fix relevant format strings and type cast.

Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 tools/bpf/bpftool/btf_dumper.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 8cafb9b31467..d66131f69689 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -26,9 +26,9 @@ static void btf_dumper_ptr(const void *data, json_writer_t *jw,
 			   bool is_plain_text)
 {
 	if (is_plain_text)
-		jsonw_printf(jw, "%p", *(unsigned long *)data);
+		jsonw_printf(jw, "%p", data);
 	else
-		jsonw_printf(jw, "%u", *(unsigned long *)data);
+		jsonw_printf(jw, "%lu", *(unsigned long *)data);
 }
 
 static int btf_dumper_modifier(const struct btf_dumper *d, __u32 type_id,
@@ -216,7 +216,7 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
 	switch (BTF_INT_ENCODING(*int_type)) {
 	case 0:
 		if (BTF_INT_BITS(*int_type) == 64)
-			jsonw_printf(jw, "%lu", *(__u64 *)data);
+			jsonw_printf(jw, "%llu", *(__u64 *)data);
 		else if (BTF_INT_BITS(*int_type) == 32)
 			jsonw_printf(jw, "%u", *(__u32 *)data);
 		else if (BTF_INT_BITS(*int_type) == 16)
@@ -229,7 +229,7 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
 		break;
 	case BTF_INT_SIGNED:
 		if (BTF_INT_BITS(*int_type) == 64)
-			jsonw_printf(jw, "%ld", *(long long *)data);
+			jsonw_printf(jw, "%lld", *(long long *)data);
 		else if (BTF_INT_BITS(*int_type) == 32)
 			jsonw_printf(jw, "%d", *(int *)data);
 		else if (BTF_INT_BITS(*int_type) == 16)
-- 
2.17.1

