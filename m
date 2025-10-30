Return-Path: <bpf+bounces-72997-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE50C1FD6E
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 12:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 651384ECA13
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 11:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67812257832;
	Thu, 30 Oct 2025 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6noZdYd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4C22D9EE5
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823984; cv=none; b=guv+mKh8TgMHqrNz5b/bOpzrb/Ca3iBT0wcX9tz3AJ5921JvDnyKGa9drgEmX2G/kRHBIaXF7/8URhMb/+p6K6SDk5sfEvN2sCIlE0//OQjO51lU+4GTvg+caBXLGI9anEy3OGwoqYbMuG7w3zN+Z3lHUr+xPL9/4A+5ZCClkRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823984; c=relaxed/simple;
	bh=kI1JbXfoy6fCJFGf3nA1WTWB98Xqq6C3u0D/Hl+KGCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EK4OTLF7FS/U+AfRhwrgkDLg4E8hjeC+mbFB+pw1dQbEXlsX7Im0Hvgg7F6HjO8XTOK7fL/kewg0JcEEg/6jyKrmu+Lm45ddU80XFpz4IUMlr71DroCaSvq0SN7NUsgHCcZbMv0m4ZUbPQrfTvmvmdRujtzPNsBtzyZsMqgUvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6noZdYd; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-290deb0e643so7204035ad.2
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761823983; x=1762428783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5x8ZW/bCx1AcWlOIX6ult73c0t0JDKbFQ+lhTfIP/8=;
        b=F6noZdYdmrLJMiWs69XlhyZ+6OYwv8bDxc/Do1pfo30NFOGPe4R326Do8c8hvY3QVk
         42dP+YlNnbrjYnSOy0SYhPM0OksUxbwHtcT2v77t6VuS5jh/YAUwiHu03DkjvIBDHXnk
         Fg2Egsw+CnjyCOSzLN8E2oGrso4YJFXcKlBp+hZoCXk5MOz4i63ablX2VbvnhC6+1VbS
         2FPIPi8jjUa9e9p/DWvHAXhHR1eGxsEahP7bnWa9yhU925d+ij2wvNRxJwz4PRxbKgzK
         aaStLi/6kyfxlLpTXBk/XfMJAgsuWuixSgHYmtrcma8xzcUJxiSxw0rq8VPXXduy90dQ
         urGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823983; x=1762428783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5x8ZW/bCx1AcWlOIX6ult73c0t0JDKbFQ+lhTfIP/8=;
        b=YpOUNT/G8g0WSPHWJbjDU6K+kefEOXOghwjIz7F+RcHvucP/P1+flSWr8TbDKWZmGO
         aT7cmnJ+BOtvKUxQ88wE7/wVsT4obcn6omyQ2dFCS0qedsMrtVTK3dFHsJuB09hlpB9Q
         Ktlo1plFGBblBERiwLAKl9va0A/6CqHgA+TFmbtjTCCHGMSniIKYVaaiPHt/TR97RtTi
         AUGOSCpgrM/K1uLRA0xB9Y+wOoii7DZs9SXsWjBd13RHf+1X0mZHX4uRcMf/3hBDbmIi
         A3yMme7RgPam5jGioVnmdPPehMMYkADuq4RPk9AsWcC2knI9al8YpFjxp/QLPGEhU1JJ
         0EDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK0gh+g6ZjRW2ZOgvVx97peiOx4DDn9gtm9noCnCb6QlSA9tFXRmayWhvuMUwrSs3RnaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/iVsD6kT0oYnczs8bjL9V7WOwyPnH+w7EvmNGWmMajFyihilM
	oLhArG0pmKAGzNuT3ph+cx3TkdEHMu8rjFUTQx4Bb5oZCcQk+YX5uX+U
X-Gm-Gg: ASbGnctsuhDhQZq3qM4Kj19ypyhkeMKokBujol1h+Xze6CasnkgwAa5QUo5SuR2ww0y
	S3ws5vws5PZ5ISAC4R+wCkooCKo44ombeLSb7xPskBwkfspY3uiEEbik7opWcGbSNw5GE3+CJyS
	h0HQoafwI3P12lPNAdyRDPyDMzYJLYsNujlI7AqPmsAy/ELcBuUoPWrk3d3KMpyW/IXCVfgqDIg
	h5/rzZBtrVeNGcbXWdT+Hq+pCgrrwpQ1civ2FYeKKX1r1iulVVandTIBx5Z1wrjTMLSOKBRlBrV
	iwS32dlxPLZ7SeLB1cPH85Nlrvk2bMzdpe3xW3qpJNJjyFC2muJDYDb5ENKBBVemUNhE9RET573
	A/7Pd1h2dvNxE3fubmqn261Q30mpF/kEVBoKAwpFB1nBDqU48QcDhaKpUzM/OlfKDqHfpz8YdAY
	TJrkxu21FQb+v7zWGrPWE7dF4K07Mx
X-Google-Smtp-Source: AGHT+IFKTx/OOQsQ+B/HWtEJMYFmWFeWuSDXceaLNFDKHVM4zMzg0kPVNDmWFu2wIsBMcLtSCCZV3Q==
X-Received: by 2002:a17:903:11c9:b0:290:c5e5:4da1 with SMTP id d9443c01a7336-294deedaeafmr72375355ad.38.1761823982558;
        Thu, 30 Oct 2025 04:33:02 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a40sm187493715ad.0.2025.10.30.04.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 04:33:02 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH] libbpf: Complete the missing @param and @return tags in btf.h
Date: Thu, 30 Oct 2025 19:32:54 +0800
Message-Id: <20251030113254.1254264-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete the missing @param and @return tags in the Doxygen comments of
the btf.h file.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/btf.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index ccfd905f03df..cc01494d6210 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -94,6 +94,7 @@ LIBBPF_API struct btf *btf__new_empty(void);
  * @brief **btf__new_empty_split()** creates an unpopulated BTF object from an
  * ELF BTF section except with a base BTF on top of which split BTF should be
  * based
+ * @param base_btf base BTF object
  * @return new BTF object instance which has to be eventually freed with
  * **btf__free()**
  *
@@ -115,6 +116,10 @@ LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
  * When that split BTF is loaded against a (possibly changed) base, this
  * distilled base BTF will help update references to that (possibly changed)
  * base BTF.
+ * @param src_btf source split BTF object
+ * @param new_base_btf pointer to where the new base BTF object pointer will be stored
+ * @param new_split_btf pointer to where the new split BTF object pointer will be stored
+ * @return 0 on success; negative error code, otherwise
  *
  * Both the new split and its associated new base BTF must be freed by
  * the caller.
@@ -264,6 +269,9 @@ LIBBPF_API int btf__dedup(struct btf *btf, const struct btf_dedup_opts *opts);
  * to base BTF kinds, and verify those references are compatible with
  * *base_btf*; if they are, *btf* is adjusted such that is re-parented to
  * *base_btf* and type ids and strings are adjusted to accommodate this.
+ * @param btf split BTF object to relocate
+ * @param base_btf base BTF object
+ * @return 0 on success; negative error code, otherwise
  *
  * If successful, 0 is returned and **btf** now has **base_btf** as its
  * base.
-- 
2.34.1


