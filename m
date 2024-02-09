Return-Path: <bpf+bounces-21595-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123E784EF8F
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C323528D60E
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217165227;
	Fri,  9 Feb 2024 04:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4uUpAQ1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500F5667
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451621; cv=none; b=j5TFlmjUpBmN4ZcMZ9hpJ7zxtVLh038v5yw40IaMlawO6gR1Ymb6MMrhItbpeMI+Uy8WCcqDvT0kMZI32359xpxta+zWnzh0VomF3y5T8CfUweLntal3GaiRLhzJDLrOXkKcyLHxTgDtMDz5UaW/UlJVsWwWxU9t3vrezLpgFpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451621; c=relaxed/simple;
	bh=B9RYqjZPOWV6C0GMRY3SkdIHMqd4rfBrkE8wPVtghus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JSfSYQnO94VUwaS0944dHRsA49D0k97KAyu5y6sXD1xbkj+F9zoxJt4jm3yAvnD78ITZx5xNsU63BepdSve7mJg+6ZOsVYBhA0v5n+2fIr84y0mA2y6ZyrC6qf/ZABTLXFceF5j4pPOiG/4UuhDh22xpAcYOIkgTGG4/byT6IRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4uUpAQ1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6e04fd5e05aso440758b3a.0
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451619; x=1708056419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyKA4wCImIZZ5xJE04KmfmUkjYhSBJW7+tRHKBcOaBI=;
        b=i4uUpAQ1x7wpjggITqtMPKx/vCgmCHEe7EtF7/j3senHuBaTMDIktrUprZdzPgmoUu
         LkC2Uaf8Et/W3WZB4FBUimkdvofvsbL2aXJ9mCJc0Jej3SAlCcWxfQ4h3hct74CDnJJH
         4WwcGSzzES6GqexNCX6NAiZloL/k1fSqBt15frLCjTde0u1IlnOHU/R4Jio5DV4j1vwg
         VtvkZLV1oT5n2A6EiMJc7Qa7nhoAs6BcFziIHBtJ3ebHaK6YZFO9O0kZ63MRdDzGxYo3
         fYIQbYee3Ij8om7CcFk3SM1tN/omGuShZWGdpgOAnxdLFpkiygqGQl4+4tN5cQenCdsF
         ndyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451619; x=1708056419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyKA4wCImIZZ5xJE04KmfmUkjYhSBJW7+tRHKBcOaBI=;
        b=rq7e35yY3ErOJE/Q5NqA+RQFFe5aUXWnFwO5BXhPTs1xtrMjL6yKBsCSx+/0v9Rzgn
         w74DBXtjrB1yd8rGIVcvitvmrNAP3IyBzxWHv9PajWBu3LEgvdNwJZWhwIWlEdtl4jtF
         UQvL+SCiyK8SKpVANH2v2F5/kZ9jmkE0mbx8Tq98fgAn+Gt4iw3A9R8LBfGfx7yzn/wd
         V9BpQOX2LUf+QDcEUzYmrULFZWomQkL5bqVoLXx8dB/Msu9VfvEWgsBV2Lk6IK6iqW9n
         I9jGlj3t+8XoJD5JQ0a8gunuJ3MLgWXTgmgdq9uiJ0yN6mOTwQpq5HCjNiP9RxbesEL1
         vF0Q==
X-Gm-Message-State: AOJu0Ywgm5QBwn12XUbZhgv6KS/yjqRYGCwciKMVuqDbZt8Z5VXizk+f
	LF1E/gg+JCAHvShtJwYpiCjArUJOyJJddBz5+eElacDe2AuNHlS1qji9R0Pj
X-Google-Smtp-Source: AGHT+IEcq3u8IxQEchLTqYOdj8JCUTyhf++9XKhZV1VlMQZ/9+Av7nCVAWvySSMoNnMsdtUnppsIjA==
X-Received: by 2002:a05:6a20:8c01:b0:19e:b477:33a4 with SMTP id j1-20020a056a208c0100b0019eb47733a4mr520269pzh.27.1707451619456;
        Thu, 08 Feb 2024 20:06:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWQEeNvrqoRwizmtNe7laAnu501WQNUUrnNc5bjAfQWP+sx+w5e2Fh+IdN7e3m/thOyA1PXmPbUrKFF2iv85lnNbw22sei0R1dMfM2b8sjF/scMfelPDzWIRLb3Rbmeu0nynfi0QRD9uaXnafRn3hsJTcHF8/wZcK3Qf+kv3Ni8kHO8NrzDQeHD4uLmFd/P0i5q1NYeju6EtjYm1j4OJY8+q7gyU4OR7agn4uOilcwA8qebcGY49lcc99jxuByats2X9fUO/pyRnbvi0DCQwCENKvViTtlTpGJaicvrQlE97J3YVk3FS629SYdh7Ivcfb+pS7C/9gwvPVJnwZqDz03apakQb62uN7S8jWHLS7hJgoSz3YlDeQ==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b006dbda7bcf3csm589192pfe.83.2024.02.08.20.06.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:59 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 11/20] libbpf: Add __arg_arena to bpf_helpers.h
Date: Thu,  8 Feb 2024 20:05:59 -0800
Message-Id: <20240209040608.98927-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add __arg_arena to bpf_helpers.h

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 79eaa581be98..9c777c21da28 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -192,6 +192,7 @@ enum libbpf_tristate {
 #define __arg_nonnull __attribute((btf_decl_tag("arg:nonnull")))
 #define __arg_nullable __attribute((btf_decl_tag("arg:nullable")))
 #define __arg_trusted __attribute((btf_decl_tag("arg:trusted")))
+#define __arg_arena __attribute((btf_decl_tag("arg:arena")))
 
 #ifndef ___bpf_concat
 #define ___bpf_concat(a, b) a ## b
-- 
2.34.1


