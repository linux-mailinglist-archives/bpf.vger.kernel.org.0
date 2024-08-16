Return-Path: <bpf+bounces-37395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45836955144
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77E5B1C235C9
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46EF1C4635;
	Fri, 16 Aug 2024 19:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut+DvhLi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70D1C4601
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835545; cv=none; b=dRlUNOCu3HIEXv7/913n0QygjWQrUDlJp8GiTFLXdvYs3Y/de15PIVNvuA8xSkiaCXMrTkUW/QYVrVpsU13DHRn17D8oHiXUZkd4L8vmcWlrO7yCu2+kwOI5badxTRTygyyq0NvsuznobEJnuTPytJfXWSHOHJNBYFakgQx1PQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835545; c=relaxed/simple;
	bh=5nFJ7ehyCvQFnjG/IjO9tfwq3gab+NR0irsJ84qK06k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DDkhYVT3IvxgIVxSfV61qnTUZtexTJt4rbMOcZxbV5bt4RopBWRI5sIa8STCYonlEFts/bLjsmV3M6zFn8H+iFTMKZW8aFvYcBiiSWSPMbsRVirGkromr3rQeYUlYLP7wOMhjq6E/84oaqvlJJqIAAv8ODQ5DLmDjfaFXcLo9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut+DvhLi; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66ca5e8cc51so23308547b3.1
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723835543; x=1724440343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA7s9K430JAGPCORlT7sLO0AYsuu7LQN2Z75vPP4SaA=;
        b=Ut+DvhLi59fOAw5hTHtEll0mNtRyAX9yj3U8ciZW0gWdMSiokXqktB2kCicP8W4HnW
         ptAcaHS5TnuHERwmYYt0yCfvfsNAjoWfr9WcbFx3dPAjoLKc749Mw0iIxvRYTaKeZHbk
         slojtvFmGNKTCKNjZXrjfPG5/JMV/B+iJKxUz9JtB0OMNV8qtpRZGlI0niD17j+cwXHP
         sWPFmqPm/odX0MVLpmTEERB0LMCKFyqUY6uShMRIa6GAyMq2eFtTd2Zq4EV/v+jEZJE1
         lsw/9p6ja5HUV6WaLdBK9K4i69LAfeubdHZQIlrdTDFA3udVUxUHlZCoEBNgZx0vzgAa
         O7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835543; x=1724440343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA7s9K430JAGPCORlT7sLO0AYsuu7LQN2Z75vPP4SaA=;
        b=M73lL9teBQb4SilZUsArROqdiUQVdB4LbQrSkKWIGZSVtmqfmj8ERpciTqJbo+RwXp
         dbYKXeRpWYqTGvHQeWlwwTWGfLv3dYMsCMfn801m9WLGUlBwf4iBE06270vW+euDVhf8
         EqBK+8DNlXooOTbehMHtbBXeSobvnmMbk0RvU90bm54gO57Q6KDmUrvu4SsjwQ1746hU
         GVn8CoAFbHvxdKHtwehHo5E64JM54Txsam7ap9m/BIYU3o5VJxm81dfxXCbyva1WrvAN
         kHTTiTVsY8W4ON159/nOqtKu/4JVMFFLZyMfz5RdqjCDcu6CQmKmBo51kamMg4QOtHiq
         qbbQ==
X-Gm-Message-State: AOJu0Yx+/jl86oOptjfPQ15ayJdBc5Y6tlKZ4XiARTcEq5MmBDone63U
	b5LXzVSKQ7HcVKChgHlHL1rIVHbQDKBVQW4+rWO8KwGYSQR1DNvdc9w4NsTK
X-Google-Smtp-Source: AGHT+IHNrR6tMCvuQKUdc94Ciumm0MqCvSVUjFkJ8r4jjlvBFopJmdb964CTXmk5NvwKFMPSzQSFoQ==
X-Received: by 2002:a05:690c:f01:b0:62f:f535:f38 with SMTP id 00721157ae682-6b1b9a64059mr54864367b3.8.1723835542909;
        Fri, 16 Aug 2024 12:12:22 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:ca12:c8db:5571:aa13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9cd7a50dsm7233327b3.94.2024.08.16.12.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:12:22 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 5/6] libbpf: define __uptr.
Date: Fri, 16 Aug 2024 12:12:12 -0700
Message-Id: <20240816191213.35573-6-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816191213.35573-1-thinker.li@gmail.com>
References: <20240816191213.35573-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make __uptr available to BPF programs to enable them to define uptrs.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 305c62817dd3..7ff9d947b976 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -185,6 +185,7 @@ enum libbpf_tristate {
 #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
 #define __kptr __attribute__((btf_type_tag("kptr")))
 #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
+#define __uptr __attribute__((btf_type_tag("uptr")))
 
 #if defined (__clang__)
 #define bpf_ksym_exists(sym) ({						\
-- 
2.34.1


