Return-Path: <bpf+bounces-62045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC1AF0922
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 05:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86450423137
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 03:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E58B1DE8AE;
	Wed,  2 Jul 2025 03:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILp9m88k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2111DE2BC
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 03:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751426278; cv=none; b=JQH1QhkLt0NUCWv6u+Grozzecpt7Wbt4t1W0ObFcHMCRymM0h/FRhZjKP3X2LIZZ7ZHmHUquJl7iERxPrg7q+hReRnf7V8da+jeinbALnR0lYZ10zkgZcdLJd9+h05eEoPLfAsWcpTWpkl99a5+1S2540WrGjw1vwDWjXkdXu3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751426278; c=relaxed/simple;
	bh=gL3a1w00tHbFN//7/baKWBSmweu8nl29wylvHEKASbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBQFU5eb2ujpLD+ntlOw0YfFLkMvXQYl8j9+UGzPYLFoCOjMWWv3ga265YTBi1f+c3pNQBRFy8OUZvbULpAAxmjTC46xIm0lkOukBxa9hBHxZ14PGZcKSGHOElKIt8mR0N4qaEhO5pnSVKt0JKX9LiL4LZ7RnBPSjK1A0zaxh8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILp9m88k; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-607cf70b00aso12636402a12.2
        for <bpf@vger.kernel.org>; Tue, 01 Jul 2025 20:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751426275; x=1752031075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbLfkwcA3kfD0F3Sg8fMVBK3UG0LHsEXOd4IcOhTmms=;
        b=ILp9m88kHIuZVrzwiAq7YD6aJaCH5wBsfOOY7NdVkYx90hZ16hdzNDMa0EBCxs/8gb
         4q91CahmmEcEfLi3xbQTWGJFojE60EP+FrzoMIm9HYXraHcRma6ISwHSn6iqACXxFlz0
         F8rSzgS4g2hGRq0L83Bz1mHuDDfNEkjma7EFR+cPaC3getQTuZ8gjvR0S91d1h+TGxOn
         dG936vhnZZiWDtbfozcbriGNxFLSp6Q+/HsA1koBAXGo4HBqGj9ZWxTfD4AvbfsxogLe
         raKlxR/3Wo4b8q86QwBdVDDOBHWuQZ+adZ0JZ45jQjlOcAAc98B9Olz6aj0iAWEbp9ut
         shWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751426275; x=1752031075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbLfkwcA3kfD0F3Sg8fMVBK3UG0LHsEXOd4IcOhTmms=;
        b=kvq+zyIe++9K7SyLSpMjdKCae6RB0jhzgLhggoqaz5ZnkkcWzbA4OHdmoZ8Fj7pf5d
         op3p93v+X8lXqrBlyICAVRI9k3OuzF0qlxx6lOs8lVqAFtjplI+fXMuHjIEPn9KlwnKS
         gS9JHvQxz6bMkqMfHFizp0/SeCQPnRB82tSF/a66Epy21zWL9XR5hGJtTZr70fspj9o5
         SxQK7orryQFndzjqx6/UYzWGR8fCUStNyEIQGqI/zS+l+Rcts0g7xUsUEaSumMjvWjIh
         M7CZGhMiO1ucrpJixrv6IFl2nG5bi/Zw5rdzqMdwYZTpL7Y1CZ5sv32D6fxMewoAfwS1
         Gqzw==
X-Gm-Message-State: AOJu0YzsDFANkImPE/OtfTu0FyCezaxjKIfl/nQANDwmWR9atDokPWvd
	enaWl78ISfY4qP/c/jfJ1Cadkd7qLTWSf+ylovhRB5+zY1khdkw9hPlbMa1+XEcLsWA=
X-Gm-Gg: ASbGnctpl9YjLg4G13ZyrC25mXg4+7cb8I0jdXh5LSC4HmADUWwl0nodthSJsyYo6Mq
	61H6sBjlL8KwV22KIR15LV6bO6kF/zhVLI7ucYtIGzcXlaMhiYGcszBnXVsSSmFq0o4dIcX7tme
	J8kauR6LCZTkP7LJnW8PqsHLrEgKH3eTGKQVNo2TZiIr9WvuoHf9fBDCnzzXEEokRwXp1Cttxuo
	4EOlfDuZs8iGd+ps9gFnCkJYHPDlER2DFDoXp59b2/D3nNrGZA9HrpRSjsbChgm5lCDVwsH/O1g
	PW6aea04ToFkyVPsThavnGJW6t6bawn7j3uzClaJkAYY/KVmF3A=
X-Google-Smtp-Source: AGHT+IE1JsMpKB6EG7UmDg9eZgtqxnorpk0TMxyIrkL+CuW1cGMk/ib/82SCFTHCy6aFMbxfr+CIcw==
X-Received: by 2002:a17:906:dc8c:b0:ad5:78ca:2126 with SMTP id a640c23a62f3a-ae3c2c92f0fmr104766866b.59.1751426275185;
        Tue, 01 Jul 2025 20:17:55 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6beb8sm995321466b.132.2025.07.01.20.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 20:17:54 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 09/12] libbpf: Add bpf_stream_printk() macro
Date: Tue,  1 Jul 2025 20:17:34 -0700
Message-ID: <20250702031737.407548-10-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250702031737.407548-1-memxor@gmail.com>
References: <20250702031737.407548-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; h=from:subject; bh=gL3a1w00tHbFN//7/baKWBSmweu8nl29wylvHEKASbc=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoZKFR8csMLWyxEEz1sI8R/t9w5nZ75TaLrtDGeB0S 78GwnEWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGShUQAKCRBM4MiGSL8RykR8D/ 9WWH4E7kJ5mHJm44fdFEH2aWwbNwYKvUzPBokf9cXc16YvgH++Ijothqq/3eSJZX433feX/tncY9dr zVG2Ji1Pr1d9S40AqN3daYkXMWJb0E8eTUMd8LJC2HGSj3tE9iMgLaWMz4uT9BYtULsZZF1bgaJOBk k2WAPiONhjip84lZHb9iSfYVoBPpRiWEgvnc9cZLRvBOdr0XRPr/zCzRtcljZgTrhj/Wtbm6py584o q0L7ECJ598UgASHrhSeGJ6uCLd6UJnUeoBGL1eV4P9oe1so85x/9vzlu6DY7xgbjVqrpkOx7WmTPuZ ztsCZW1UkMnE8NwwUGF6KDtB/Vvs5HWrsJqEl7eepCIYO6+HMM5nEumQ1Kek9DAC9EpWjTUfh14yrl 4gRHvBG3uZmjZff3DVDfutTwcMYouw+lzyBt2NBwY/F2yB6n0UzHqG+uj2VWP6xIChbxoIrqA4BERM ZyUO0OsA5FDRSF4NebntbyJwmyu9GWWVX6wyKG+30p/KUHmgzjgCRUBSAGQp9R25QKg8VH+IUwFc9C +IRYkZsx+hri1J4hU0Z1XqCICPpEg4KdQf0rPGxj47EorI4hoXrG5RWM0rWUX4MzzdKeM/takzBOLy fNIlJIyyADPdfAETwYlLA/wtT0jTPJajZqhERElfIGs073ygrrmsvjlnrG6w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a convenience macro to print data to the BPF streams. BPF_STDOUT and
BPF_STDERR stream IDs in the vmlinux.h can be passed to the macro to
print to the respective streams.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
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


