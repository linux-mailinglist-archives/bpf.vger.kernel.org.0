Return-Path: <bpf+bounces-34817-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17399931334
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 13:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54C428426D
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AED18C163;
	Mon, 15 Jul 2024 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa06z1Gl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738F18A950;
	Mon, 15 Jul 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043437; cv=none; b=ptYAWXe4nX9WdnxTmvRYT+ZABllFYLkwBcX91ML1yvGXoREnJEKeZZLMTz4zc3Hwr8j6AMKy+9G2tip7hTsZGnNACLSvNH1J/frZUj6x9OBdsZ04xkXp76c3o2c0FEMcJx0SfUDj47ln1zue+kNrs3FFXSmRmd4MTAD9lENAalc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043437; c=relaxed/simple;
	bh=0JaMcVnEOEmHiFY49Jn8DUJcyME5czNW/5v7BXTp6F4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uk/J4LzOm7JtpTRfLW4m3ppbIBeKshXGnLfiL/Gib4bZPqtMRNlyErnUQ1w1pTH0uY8V0RsVPSEj76GujL8G+GE8HAtLGBgTVtMAGVDXIjOkkjirXctwNMpLDNCyuuRC81dYRo392eKMEwmQR9dtzheMlR0jv5ejXodjfrT29I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa06z1Gl; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70211abf4cbso2842401a34.3;
        Mon, 15 Jul 2024 04:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721043435; x=1721648235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YejqhzX9tzWecGEm0cvrvR+36trbcw8YNU0ydMs30LI=;
        b=Oa06z1GlpwKWC6eIMPZfzhgj85cJ3CXC8U6fwJZLf0rnZpp0csc1PSTcoGNLufzHCf
         RMEqQ/Ct9Mi9KcPjJskam7KT2VkGRxZc5/+2lQoySEdPetzfRsyL6gX15x6KrAz4xkEK
         g82gf9FInsCOulsP74sbUXoNWaJ29wX1CxKwoiQwqpLS1fxAgAkih2bZtqfpQSQsKOpr
         JCBiELCeNN2XZarHeS03fm8maPpTEKUv/uu8GRtmaEKjgF+MM2OWMHhyP1wbG/TPfLYD
         UcFosjOyU3jZkc8dPGVFsoJVlBLG2KgRqzpPsJIeiozkjfrld0WlXob9CTw2V49TUxzb
         EMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721043435; x=1721648235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YejqhzX9tzWecGEm0cvrvR+36trbcw8YNU0ydMs30LI=;
        b=qUjlUQMwRTSXNhyY0xupOFIUi3fKhD8OiqozRoHYwto5UU8ralyFkkj8+bxUam7Inm
         jL+a70iLS+xhR/pBAaNu25FFNLIRSTVtMaNe/4L1D1AO2cQdSeqX+Q/FDvTwIyXw8tIZ
         Ife2aQncUCHvk6/Iq4EtQE9pTRG5HrKAVXDQhmIYsEUchVICUc0u9WCyKuL8KQVJWJRC
         lFBj5eV/zyhS0spotPFAbo7rneD/hs1xVlBNYh9IdrMurTLbwbNt0A4yhvVHZ+/ZpF/U
         y3IS8huEel7wkIwDcHMOV9Pi3fAKm7HdPV2h1WR4+GZNxozvNML732DBLGPEKBePATN/
         s9SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWllYJz1DfpMVbTi5kF2dr6qsIuMOOTB5pErs7TCv8EjdS+EL+DGWWpdbShuV3/Hg+rRKBZO3lYKaqT0UZuE/WAiB7qsfTtx2okFcjzpt9Y+rtQJGQuTYG17hawsav8DrFh
X-Gm-Message-State: AOJu0Yx0AJAsayWwe40tMfm+yNkEvx7O1dATxcJXJsGzH9nSdSV2kqMD
	H0q6YCjjTBK567NFsOKEqfg0FSES8V9edlVKk0nL/k4EEkfuzKTp
X-Google-Smtp-Source: AGHT+IEEk7/Npdq+bj9g/pqupEE42derNFNWaU06IKt90ve7xkaGH9H+0Q1Hi1wIineERynZREfaTg==
X-Received: by 2002:a05:6870:ac28:b0:24f:d12a:5f1c with SMTP id 586e51a60fabf-25eaec3ea3fmr16212761fac.53.1721043434779;
        Mon, 15 Jul 2024 04:37:14 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eb9c93asm4118303b3a.1.2024.07.15.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:37:14 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 2/3] bpftool: add bash-completion for tcx subcommand
Date: Mon, 15 Jul 2024 19:37:03 +0800
Message-Id: <20240715113704.1279881-3-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240715113704.1279881-1-chen.dylane@gmail.com>
References: <20240715113704.1279881-1-chen.dylane@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds bash-completion for attaching tcx program on interface.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 tools/bpf/bpftool/bash-completion/bpftool | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpftool/bash-completion/bpftool
index be99d49b8714..eb36f5305945 100644
--- a/tools/bpf/bpftool/bash-completion/bpftool
+++ b/tools/bpf/bpftool/bash-completion/bpftool
@@ -1079,7 +1079,7 @@ _bpftool()
             esac
             ;;
         net)
-            local ATTACH_TYPES='xdp xdpgeneric xdpdrv xdpoffload'
+            local ATTACH_TYPES='xdp xdpgeneric xdpdrv xdpoffload tcxingress tcxegress'
             case $command in
                 show|list)
                     [[ $prev != "$command" ]] && return 0
-- 
2.34.1


