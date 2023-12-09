Return-Path: <bpf+bounces-17289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0780B0FF
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 01:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F29BB20C1F
	for <lists+bpf@lfdr.de>; Sat,  9 Dec 2023 00:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204C1C08;
	Sat,  9 Dec 2023 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nw0z1WU8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01281173F
	for <bpf@vger.kernel.org>; Fri,  8 Dec 2023 16:27:29 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5d852ac9bb2so25588817b3.2
        for <bpf@vger.kernel.org>; Fri, 08 Dec 2023 16:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702081648; x=1702686448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sjjYs0SoUIMGBIggG2RmbInOgfFHHKp5K529V1i6nE=;
        b=Nw0z1WU8SOvX7e1oZpBGoOEUVv5AOaZXP8Haj2/Jt6lr2YZoXbXHkYPAXKToh1M3r+
         MmRdx6AND0A98ZA3Ix3e30/daH6iAjB8XjOuGPXM9FdaKHD7094DnqxnyuigS285pQtT
         E3YR1UEZHAolf6SmGbsPUbceH6U994y7hVry289Qvj4EwI3ypnD4EpASnmOLx0Fcw3+f
         ozhHndYqSzGnZZQ/MxAXLQrhF80hQF2yscek0WWHIDr5Eu2zW8s86sX1FFpJkXuEUBpE
         Ta92aF2yAbE5MVN0IXt3A29Leeofk/ky/0X++YR/NXTOTZuCY867c+s+R8nC/by55uX3
         POiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702081648; x=1702686448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sjjYs0SoUIMGBIggG2RmbInOgfFHHKp5K529V1i6nE=;
        b=sCGXZWDAbmsLr3pTZFogxZBSynVsi2Zx1y9qjTmNaEdA4f4VWbhEd/nh5ExK/u83p9
         +QXBaQqeEBVfmUWH0ZNWqMf63zS0Px9CuQ9zpGvB08akaleLMgXlRpEBLpBEMH8AfAVQ
         fe7C0GvJ/5cN1hRowoxurRlbpsZHwVfv+rIHSuxoQNUcQo5c0nIaHM3k4ZWUUwaF4iTO
         hRoEP1pxVGqz2RY16rD3uBtd1KtH5PM6928hlti7UkbUa6WxAfVEDWJmk/OQ8PLiVXyz
         NI3AAog9wN7OS6hXYYcNP1CpKOg8UA5QYouBcpyf84qmSAShXHpYXpTmtb2D4aIM0QL/
         ZoNQ==
X-Gm-Message-State: AOJu0Yxk7eGBgekcyJ0zep6MO7iUARGVbCIPohdTdT1qDIO5JvRHItzQ
	1IPSI9SNT4onQoWv6SkruYReqwffi7l12A==
X-Google-Smtp-Source: AGHT+IGLR5e4xJAXyXo6WgR+bBmQi+NB/vxaOVPka11b6UQkVSFkWNcxCdrXYMXYoPA7GBO0N2XbGA==
X-Received: by 2002:a0d:d007:0:b0:5d7:1940:53d9 with SMTP id s7-20020a0dd007000000b005d7194053d9mr871246ywd.81.1702081647963;
        Fri, 08 Dec 2023 16:27:27 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:65fe:fe26:c15:a05c])
        by smtp.gmail.com with ESMTPSA id v4-20020a818504000000b005d9729068f5sm1057450ywf.42.2023.12.08.16.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 16:27:27 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	drosen@google.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v13 12/14] bpf: export btf_ctx_access to modules.
Date: Fri,  8 Dec 2023 16:27:07 -0800
Message-Id: <20231209002709.535966-13-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209002709.535966-1-thinker.li@gmail.com>
References: <20231209002709.535966-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The module requires the use of btf_ctx_access() to invoke
bpf_tracing_btf_ctx_access() from a module. This function is valuable for
implementing validation functions that ensure proper access to ctx.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5545dee3ff54..d9cdf41e8f34 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6142,6 +6142,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


