Return-Path: <bpf+bounces-67109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5FB3E4F0
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 15:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8621A84880
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 13:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A24334391;
	Mon,  1 Sep 2025 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OsEF+cf3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF832BF41
	for <bpf@vger.kernel.org>; Mon,  1 Sep 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756733283; cv=none; b=lnuEQ6aRm1ZXqQemWzZYyW+33Nz8IuIu75yG4IgQAAxoG85tUTBcmvKAXF9UJssouhZyyLzaZ0HyGP+qwfgZ94gBngL9AD0uu3A1wK9NiygPasZx+ODfSxGmNEY7B69g6W8bXqCq+mefLn/Q3sY8ZWrY87GUUwaXjFf6f5i0zQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756733283; c=relaxed/simple;
	bh=6O9zYzknF1XakScCV4bBbfOhUs+802B4MkwhMeX25CQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OSyMIYcOH5DFdqwOmUJHv+EcEikH92M38GSRzG20YV60W4njru8kOHdg2nyday8BTfn0SQX0dANFnAggP/tq/y1T8Mzx72C3SZwTyGGxFc16FXPhuVf8TgOSfcrGuh4jMb3bw9I/zeesWEfNHEZZAbLOcgI9/cJLbZF1Tf8FE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OsEF+cf3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b040df389easo294011066b.3
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 06:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1756733279; x=1757338079; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvkpV4Bq+rj+YuFtB7kDJzqT2KzLsgVk2R2l+HFV7nw=;
        b=OsEF+cf3p0AJ11lNHUNClDHP6nWkirEYx9oIikOVDY4YGzA3MKCWDPWrbV40SJUkKa
         iiPOttNGWEBdUIVFu0y+7ab8zJ9HFToySbXdcF8YYOvpinQ9vdretF9rQ1+4+onGg9iW
         SwUKXzC4mShTE88Ry/eEiUGH+zh6sYsNhDb7T3HnKKvnLhCl5xgu2TtLJ+g1jCBhC+zd
         3apYAQlu3RdYzm3Kn/fV5zWJqx1yZ0zgoUVeA/ALH+or7I4ZgAT+SbnniQQguDtcBkJA
         ZuZaYXpGlC46S35fp4+QPin5lw+vWHGd4eJMgKN3HirunSnPJSvYw6ADqm2NI8fvc6sZ
         salw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756733279; x=1757338079;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvkpV4Bq+rj+YuFtB7kDJzqT2KzLsgVk2R2l+HFV7nw=;
        b=ixe+b6XkLi8QNsyF6gZWP0i4eb9Gm7q7Jqv2PmnR8GxWO9d5p3vsfIj7x5bGVur9TZ
         Y7qcc3xnRJbKLONe4S11/0QB0N+fgOhTDZPjbD4TUL+5e679Tkh8/jS/SxhkxPC8i82Y
         9kO6L3HGd6wA94X456C45EKozoybe/uhYbJRaHUkgUnWx6spnvWxBAD/FsL0RcyHFBWt
         IHM/lOBri1ARHOVvm3d3VbBA8P+l79rQEYvwZuFXRJ3sLDQIyScZWOK3fNS7UXHh6saH
         2MUNnFLR1c7/ckjXxfUOMaIAaNkuHEzzCo2bJGQuTiMNJOlML5iok4k4HhkHys5GWs07
         WZBg==
X-Gm-Message-State: AOJu0YxIr7gQxlrufBa4ogS7yJbAVGV2J5C945U4NlWJGE2LgJO65diG
	BWldwfOnqYtpab9vjclbt0PQwbO+fF/aEiHzDp9BBqPWa0sZU/bOUEw1Rs/mPBojcKbwaP/2Aei
	7uw57
X-Gm-Gg: ASbGnctsKZBZ7W8XHFHyEyZ8FmsDlPDQQqiRsF1HRkJXz+I2UBMkq1fadd0x8GdBsev
	K2RKBIYiAn6BtsPPJ8XyNJYLjMfv3KSMZsuGEeaUfQTp9d2a8a/LybReYjMbD23nV2ahA7PERnF
	nT+YojNZ0XkgzSVkrOK5l9JI6+WmkmVYXj0yNnBfvD1XEqwfXYPQJxkCvH7wkLOwAdYi3tQ1ZFP
	xqEzPC9vXDou+WVc7wpD2XB2DxCcPNwdxfs9Pbj+UBGHFLanq8QT5v23tMU8723VJxUQt3+hfpa
	Dv3xo9gB5jfByL90ir/tWj3vY2vKgUYNMaI4FWX+wIqkipx98IV2GJNbRpmrDgCg99Z8DMeTQIY
	6pihpHIvvu25XagbKPwP4Io/KZA==
X-Google-Smtp-Source: AGHT+IEh3AaonZ5QJBkOf1S6UvYDoHMiIZHdv/ST35c9pqz9MF0Ajnr6x/W5jLydJXe0NqvFsZyLHA==
X-Received: by 2002:a17:906:f5a2:b0:b04:3955:10e2 with SMTP id a640c23a62f3a-b0439551a93mr223405766b.25.1756733279510;
        Mon, 01 Sep 2025 06:27:59 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:295f::41f:42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5315c7sm7074508a12.46.2025.09.01.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:27:58 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 01 Sep 2025 15:27:43 +0200
Subject: [PATCH bpf-next v2] bpf: Return an error pointer for skb metadata
 when CONFIG_NET=n
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-dynptr-skb-meta-no-net-v2-1-ce607fcb6091@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAE6ftWgC/4WNSw6DMAxEr4K8riti8e2q96hYQGJKVEiiJEUgx
 N0bcYEuR2/mzQGBveYAj+wAz6sO2poU6JaBnHrzZtQqZaCcyryhGtVuXPQYPgMuHHs0Fg1HlDV
 JklXTqJYhjZ3nUW+X+AWDG1Npi9AlMukQrd+vx1Vc/J98FSiwoKotZZHTIKqnnO1XjXPv+S7tA
 t15nj93RkZZywAAAA==
X-Change-ID: 20250827-dynptr-skb-meta-no-net-c72c2c688d9e
To: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 kernel-team@cloudflare.com, netdev@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.15-dev-07fe9

Kernel Test Robot reported a compiler warning - a null pointer may be
passed to memmove in __bpf_dynptr_{read,write} when building without
networking support.

The warning is correct from a static analysis standpoint, but not actually
reachable. Without CONFIG_NET, creating dynptrs to skb metadata is
impossible since the constructor kfunc is missing.

Silence the false-postive diagnostic message by returning an error pointer
from bpf_skb_meta_pointer stub when CONFIG_NET=n.

Fixes: 6877cd392bae ("bpf: Enable read/write access to skb metadata through a dynptr")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508212031.ir9b3B6Q-lkp@intel.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
Changes in v2:
- Switch to an error pointer (Alexei)
- Link to v1: https://lore.kernel.org/r/20250827-dynptr-skb-meta-no-net-v1-1-42695c402b16@cloudflare.com
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 9092d8ea95c8..4241a885975f 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1816,7 +1816,7 @@ static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, voi
 
 static inline void *bpf_skb_meta_pointer(struct sk_buff *skb, u32 offset)
 {
-	return NULL;
+	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* CONFIG_NET */
 




