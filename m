Return-Path: <bpf+bounces-61346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC142AE5A6B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 05:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1597417660B
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 03:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F921ADB5;
	Tue, 24 Jun 2025 03:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv8hgKkc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77018219301
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750734789; cv=none; b=dWgWWuLe6NOrOI7Rw07PYII7lOvjkd/ViZvdn477QJe5BR6hNRo3yrWQ8sWEHlk0+KcIDe8W6QD1ysmi9EzpEIBKWm7iG7wYtDmsyFd0Y6lEQ/e3R9QCbL0/L4LaxFzrtcs4ovklqP062zSyoQX/FVx1Tu6ySCMHEexqzkBHCNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750734789; c=relaxed/simple;
	bh=d/s5GjjuRb+aCtxQdrbaL68x42Aw+oKOLFEYLs3RXUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AbBsOi3HFnp3bXD71nkz0FEToAX5EnetwHMOBJ+spmVLrhv6HMqOuI8enZISEeSEUgjRUEW4sQUrsrNULTvQS8ZVjLumFI7HCxWhMuIUEYIpJoJOf+kBTz0zD7b4LYF7jsMoz3Sw/SDLJyyBXQNQHV9y2ZgM7EMwRJHIEnRxa1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wv8hgKkc; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ad574992fcaso844966966b.1
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 20:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750734785; x=1751339585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQFljbONOx8063EWs8RAQnv1mbY2YXcbpbxcgQTQxfM=;
        b=Wv8hgKkc743HX6ULq0sLwPjpqaA7GwGekp4SF6+83EebqQFMgLiIpEVLiAhh8n7+RT
         IoI/LiFEIdbD5jSz9xwu0uT4YAHvFmc+iPJqGPbFJQSE2fJwHIEzDlY3nDZ+O1nPLfd9
         koDAmtXr4B24GtOD2F9sWtFtO/Q1IHGR0/8sDNUcyOUFHWpp/+RmBBGty+HtxVONL0as
         BDT3yJSZif3mGsw/681bCgFgwIB97HI68e0GbPMVPG4IV5Iw5p5Lkpz5C1AwVg9JRp4V
         /GlsByRpzD8q48lJGhz0hqKh7KGx1dFW0hx2JvDdUuBOoWZwRacrYY5wb0sDgsdx5df5
         phUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750734785; x=1751339585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQFljbONOx8063EWs8RAQnv1mbY2YXcbpbxcgQTQxfM=;
        b=Un0Q0m1ALJWaciRuK+9JE+SXDcnjfWmtgG23r3+I0UfoECvalfOkSjgQl5vA+/fllC
         AafmiwAchOpqlaDgpoSboBJ3rrcCBqGxDMgcqq9xW0a29wmSo+09L0xi/Yko4IkeKXWr
         Khp6VaPHfSrYI1QKREnxMItgRj5Y1dnhOnUcF9LsXBSlcNSIT8MwbLZXjzksBWmcfgvK
         m4xOFtFaP8iEsqoW0EY2kScaRdmJnWayDGFeOZ1KGufglu2YCvdvikTOOXB0juzJBc31
         OYZ4ebpCzSE28a9uPhBa2jGPht3FjlVDXuEggungi8AEkFuTIpY5EZ8NjgenF4ObnHfi
         amjQ==
X-Gm-Message-State: AOJu0YzjJGOr78edR00+m25TzCohvzsdP7lYf4wGmxdwXKW2/Ykd3n9z
	dzTlt7rksm0IHzEUSEV8+q2wyNcvxRBzael9/Zya9u0j+eaAuDGdTYBBRsU6XVNBWrDHEw==
X-Gm-Gg: ASbGncsNufk98DZ9TY5RSp0raXuomvMxpLgMVptnWml6JUONGKkaNJG+eLWfXNmuCJV
	Ohohaxgl2omfmw2s15J1jFImcJXohdeuO0KOinaNih3heQmR2YHuNrNUw+ppnuIr5fNh3tdGkj2
	jYtz+OD1U3okcz4A3ilrEsDatYyxmHiQ42lJR/mACVm5ZbOLVp+cm5aRavyimjUQqLDpVQwZg5d
	5EoZhqNByw220IAv6T2GjyLZTwlGRAh3FQbP2ehmE968Lrg0S8lOBLl8vtHae1IFJihc5gRZmkV
	QekO58Ra5Ek3oW+ylUMgs33qChWRne5zLPjtl0ORuvp+opGfpIAo
X-Google-Smtp-Source: AGHT+IFQg05kOYnkLpJU7M6KvGBnHHN45fG7g+RxAdcTr34XVo7L2P4t+BjidljeA7LghjvSwkeAww==
X-Received: by 2002:a17:907:3d4d:b0:ae0:67ab:e94b with SMTP id a640c23a62f3a-ae067abe9eemr1189146266b.14.1750734785442;
        Mon, 23 Jun 2025 20:13:05 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae05420a31dsm804728066b.170.2025.06.23.20.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 20:13:05 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 09/12] libbpf: Add bpf_stream_printk() macro
Date: Mon, 23 Jun 2025 20:12:49 -0700
Message-ID: <20250624031252.2966759-10-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250624031252.2966759-1-memxor@gmail.com>
References: <20250624031252.2966759-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1391; h=from:subject; bh=d/s5GjjuRb+aCtxQdrbaL68x42Aw+oKOLFEYLs3RXUU=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoWhWe19047qK2VSwCK0T6ScQR9WdQo7NIw4K1sVkC ph+YiyyJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaFoVngAKCRBM4MiGSL8Ryl0REA CILcuQW5rAkMxQpIkAJVu5ouG++ZwI1OXOz3T3CdZxsIfrF7bClgHIcGzVp7nKOu9cnfw9x8EYksd5 4EytaK8jowr9kyJApM7vjz0jE0gLAn5KXu0YeiMKF8zRXLU86XNGmq9ZdhgkoB60mHkwvi7nxunqsz D9k6Zqtau3F2+F1qDlTTcdHnZMjePXBydnRc8C+dX1bDBhcxHCADXdVAvwIYMpljHE8sn9EwTIejlw XRF9KByP7VMAh3Dx9CHycsRMrClY4hqb7aCaT3mhFxMpi4ROdwOZsyym7W13Aei8Fq6P6lw7pZ9dL+ O1wy9jejIdM/k2VTzSeL7wY8rJ/LEphKpUm+2bQ/iWOVDyOPhPnC3mdDABgxN08Jk6w3HZqRK9KIie RfE1XCSMFE+xsa6SeI9BqNe5SRrtGgk09QRILlJWtzgOLUMdATpWCSGWNc4VbWzwr4X4yYDeABfx8z Hk2ZMnXow19w02pJskg1Z7l6+E3jGoHR1h4DMgNYBQjm7QSNmXzqwXxqVuvCd9zdUUnZ8qaBH7Uevw 4CQIBF8FW50epLek7XEFqKYCl2C/U6nXwSa7KEoz6uYqWl77rxfKR/zUgKIe9y31YpgsgsbsnBtckp oixUGBi2I0e0/V51FoqYpcKBqLChIbb2GYnjNF6N5O50LS2EZZ3whHuOgDcw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a convenience macro to print data to the BPF streams. BPF_STDOUT and
BPF_STDERR stream IDs in the vmlinux.h can be passed to the macro to
print to the respective streams.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index a50773d4616e..76b127a9f24d 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -314,6 +314,22 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
+extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
+			      __u32 len__sz, void *aux__prog) __weak __ksym;
+
+#define bpf_stream_printk(stream_id, fmt, args...)				\
+({										\
+	static const char ___fmt[] = fmt;					\
+	unsigned long long ___param[___bpf_narg(args)];				\
+										\
+	_Pragma("GCC diagnostic push")						\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
+	___bpf_fill(___param, args);						\
+	_Pragma("GCC diagnostic pop")						\
+										\
+	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param), NULL);\
+})
+
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
  * Otherwise use __bpf_vprintk
  */
-- 
2.47.1


