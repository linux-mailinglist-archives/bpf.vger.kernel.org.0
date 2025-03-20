Return-Path: <bpf+bounces-54501-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D1A6B0B6
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 23:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D3BF4878B5
	for <lists+bpf@lfdr.de>; Thu, 20 Mar 2025 22:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E62C227E9F;
	Thu, 20 Mar 2025 22:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XIIKRNEU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E22C1B422A
	for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509486; cv=none; b=ej4bjL9I6GeiRhDV05/5BA4CAdrdgWopMCupCw6ghUIs7HhAZWqJWQxndchjFmkQ0pBElWelZZpvarTVh01gFNvrreKPMc1BfUammnewoUQnL+3UnUTnQWI/fIJ8bhBaxzAT5OysQEsOrsm15W5P6ukwzhRlpNLXvNCFwUel/9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509486; c=relaxed/simple;
	bh=EBdmawavNviZH8o3V/8jqcpc3z8WzfTUJCXeSVJiEPE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PW6p35yRPUjpMUacHFMOWYTJJ//tToh45QruUolCzpjTA7rNT/62C5zpnSrYoYw0RRO6kJo7grllfAfwwpKskifwyyAB/uYzCH3vXu+7j019BLpmLLDubbIfo7lYJqc819i0WRX3Ih8R8jY7I83UMZEAaNlCKFBzY0S12HhARhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XIIKRNEU; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso3170011a91.2
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 15:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742509484; x=1743114284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TTgK7Ngx2/T507+YgbCUhV8aPPXABYoFmzp+GmQKcz8=;
        b=XIIKRNEU/oNg4IQBqKQaUKfwWf5rITOVCQPZ61lEIG1krPuChMjE8zv1PrCtPp7S3a
         3nQioT9uqO1lr+PDnQqPcx3SNG27iQZ8ZqNDVBhh9dzN6uLAcvvdCtpIs+ybLX5SXe4x
         8t0XlnNXsnk75wzW2OC0Jhl5Ma/5mHIrfXCE1ZC34M2l0Cj3PPJmW3QLSSXr54b2T5pS
         /28bt+w3/msXqqjAeqp/coPzbJVmTAyfLMGGrNAkjzhDJkYMr28AigsodD7V5a1jQFf1
         XYwQLG9Ql3H5eaaf6TcPfHEYEMKeelAuA8iN/JG3bG0GiyiOyJA8QrH+wDL6VfYGtjc+
         4epQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742509484; x=1743114284;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTgK7Ngx2/T507+YgbCUhV8aPPXABYoFmzp+GmQKcz8=;
        b=TKn/rqWVgtZvynOm4lKw3yBIcqvPWV/ouAbfWbBj3jB9ZjEQIr3YIVNEA33Scqiq+u
         QGUR9Hs/SQbwQgCqkxrw4BZIm/U52Bn6iYoPQWtNDXgljUPKWmv90Trc9Jk0C7gE8JEL
         fOqMmKjmrqPOKEGLhHeQtc9UWKDP1YC8t+fBmRf8vnXjKiFa/z6xigRFiY2i3hl9UIqQ
         p+c1rHtMqo68TBK0HSM1ZgDIGPNijJk79IHtph+92ktGLr5pYz3tX2cjdYtKx+zIKLXY
         LGnM4uE0iT4xAfQKfxGX9iszIZ57uLP1qBunrasPPiH6RnVkMPVY5UThM4uMiB9WfGhZ
         U3XA==
X-Forwarded-Encrypted: i=1; AJvYcCWM3sjSynKqxmgrkbMetP7fhV6kHCN4/+BuJ6sm/agLScHtyuo3gs814bjwI/C92S6twSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeBX4KT4UD6v751oraZfvoll/9hwWhRjdbZp3Z+9Y9Z59TNTJn
	Gc5flGskAVNFS9bD5EmxWW/1XsjW0qgKBIu1lL/+bDHCa214nK2SZz408Tc16OuqoIDyzhWSSOy
	H6kHWCA==
X-Google-Smtp-Source: AGHT+IE2Jm4eS4T9Ui9y1qLLey9xGKitHGZaGhB/U0tacIUCSXohkHLUjaUgny8wWNfuAFeHFkAz7vMEVaA/
X-Received: from pjk16.prod.google.com ([2002:a17:90b:5590:b0:2ea:29de:af10])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f81:b0:2ee:b8ac:73b0
 with SMTP id 98e67ed59e1d1-3030fe6df0amr1565280a91.2.1742509483864; Thu, 20
 Mar 2025 15:24:43 -0700 (PDT)
Date: Thu, 20 Mar 2025 15:24:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250320222439.1350187-1-irogers@google.com>
Subject: [PATCH v2] libbpf: Add namespace for errstr making it libbpf_errstr
From: Ian Rogers <irogers@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When statically linking symbols can be replaced with those from other
statically linked libraries depending on the link order and the hoped
for "multiple definition" error may not appear. To avoid conflicts it
is good practice to namespace symbols, this change renames errstr to
libbpf_errstr. To avoid churn a #define is used to turn use of
errstr(err) to libbpf_errstr(err).

Fixes: 1633a83bf993 ("libbpf: Introduce errstr() for stringifying errno")
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Use #define to avoid churn renaming errstr as suggested by Andrii
    Nakryiko <andrii@kernel.org>.

v1: I feel like this patch shouldn't be strictly necessary, it turned
    out for a use-case it was and people who know better than me say
    the linker is working as intended. The conflicting errstr was
    from: https://sourceforge.net/projects/linuxquota/ The fixes tag
    may not be strictly necessary.
---
 tools/lib/bpf/str_error.c | 2 +-
 tools/lib/bpf/str_error.h | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/str_error.c b/tools/lib/bpf/str_error.c
index 8743049e32b7..9a541762f54c 100644
--- a/tools/lib/bpf/str_error.c
+++ b/tools/lib/bpf/str_error.c
@@ -36,7 +36,7 @@ char *libbpf_strerror_r(int err, char *dst, int len)
 	return dst;
 }
 
-const char *errstr(int err)
+const char *libbpf_errstr(int err)
 {
 	static __thread char buf[12];
 
diff --git a/tools/lib/bpf/str_error.h b/tools/lib/bpf/str_error.h
index 66ffebde0684..53e7fbffc13e 100644
--- a/tools/lib/bpf/str_error.h
+++ b/tools/lib/bpf/str_error.h
@@ -7,10 +7,13 @@
 char *libbpf_strerror_r(int err, char *dst, int len);
 
 /**
- * @brief **errstr()** returns string corresponding to numeric errno
+ * @brief **libbpf_errstr()** returns string corresponding to numeric errno
  * @param err negative numeric errno
  * @return pointer to string representation of the errno, that is invalidated
  * upon the next call.
  */
-const char *errstr(int err);
+const char *libbpf_errstr(int err);
+
+#define errstr(err) libbpf_errstr(err)
+
 #endif /* __LIBBPF_STR_ERROR_H */
-- 
2.49.0.395.g12beb8f557-goog


