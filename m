Return-Path: <bpf+bounces-58883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F71AC2CDE
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 03:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B01F154217F
	for <lists+bpf@lfdr.de>; Sat, 24 May 2025 01:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF801E2307;
	Sat, 24 May 2025 01:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imN+kIja"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950061E1DEB
	for <bpf@vger.kernel.org>; Sat, 24 May 2025 01:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049544; cv=none; b=D34hhzftCydS3bdE+JWabxzmdOZuaLZ7QWBrJ1i/ZMz+cvLUEgjWA58hkstyBV1AjhLCTAWsWz6Kq+aU0z7xAFKRIrEBzjbf/JXURzMODfUuOpF6NUtkr1yRjeyx9zBfVejPsDQoB5LN0qOmTUc88qY8zBfxdtly9GGYCJk/2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049544; c=relaxed/simple;
	bh=BfPny0l8Cw0cZfbEDzE18g7i4virRqsI5sy2oK7G8M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jw0veN77W6RfspVGQjI7M59gLHp9vPlUoRBg6zy9gEq8QiVKWdArHogWlzInadNBxbbxzJWBh2hxFGAyAQiiFFwkqPAfw8TIxriHHxORQBDZTKUSKiXwGzvnInrClu/TCBhtNQye+TZ1QW7h8K7jmO7KoNuWJMbM8UGaP7aKidA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imN+kIja; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-3a3673e12c4so239018f8f.2
        for <bpf@vger.kernel.org>; Fri, 23 May 2025 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748049540; x=1748654340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqaIayjLTWOO86tZv2YuaTpGIP5tJcBF9VbH+sOs22g=;
        b=imN+kIjadxWp2PexnwbOUKjzh/gLRQgnjGx4qKhvgQzyS6AhB4JDMlq5apIuc3C6li
         KDo+GBYG50ct7EgFZh9KFONe/K5aewFfe4H+MFJ6SvpxIdTJR7CB5mGT+KcndO1JRdr0
         RFgMslZTUlv07ZT32SLm6ouCC04JfL+I3lRIlDUyoWgJaW6ZOXLiyTlDRf16XGbphEXZ
         wBzbjQpsrcYd3xdHxhDb32MFg+fohDDXtv7iZPtG5sXTjtbBdKuxoBjGCRS+Nf+BoVYI
         J/f6wHKSzYsr7CiNhZprkqs9wk2TOpAkDkeBooJODXkWaOg6lemp5jGfTpxGXc6yHG70
         KY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748049540; x=1748654340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqaIayjLTWOO86tZv2YuaTpGIP5tJcBF9VbH+sOs22g=;
        b=nrY5DkItW0Nsukwv2raxKhq75cjuRh/kDSw6h4AsNf7+TdHSow3kZrqtE++jXp17KN
         yfT3xc8qqoYQ5+KS2eXzU2gm7bfHW2Rqqtvbh6RugkIVlODfP2bsH/u3Zbr/ZijM7Y2X
         37ujVNq7z4003J6+6Fq/veISTSRUguOuHqHQCh1oKqLWEowdSJT3r58ouz3NDMmQvnHa
         RBSVyidssWAOfgrqZ+D90CTPi67kDS3B2D6QUf6g3GKJZxBO7ldIHfMsD/4kCOk8pTDd
         9ToXKaqM9Ev1yJ1cmrCx7TmH36NIuDaDNJCEWUX/VX+IhQUsuBIOTghNNvjR12U6p57/
         c7vA==
X-Gm-Message-State: AOJu0YwueHKmMZBDOM9k8CxqfOJhw8Bp3/np8mgqqai1xbljnldVaH2G
	HFjvZPWnM1n67Co96BM7kTrdKIE2fYWybFZrptsuiEYFf3JHQEW0fH4+LdTGh50HKl8=
X-Gm-Gg: ASbGncsSIeBeFBURnFxot7rfEMWp77gD+Q4d6BY+n+k0QZxGDNkvFQDVq555ZoXrORX
	gpkAyhFer/J259c7qCSArzugF4TnE+efS6zeWRKroylnKvbxXqjd0xoAyCml1T2gS9PsxQmVqiP
	Ch9dtnMSqH0bT7jHTJ04iO/t8S3L/pkXRqJOPWnczDE6BMMvPHCKHF28U4lUySypylyyT4MZ2+A
	obBXf01ZwHMusrMRyzKFr3Ofuu7Ak5esU2a7kwAqOol20EJHexA9QCuAvXYhZtiCiEBDytq6QGC
	x/B96PR2igNmCTXM5JXVo1G3zmHp0MLCV7GHOjXYoA==
X-Google-Smtp-Source: AGHT+IGr1WN7GU1v65XRwUmZXpA34I6Xrp3Tanzab3jQ2fdsa+Zuou46JYvCPCuZTZ/smLKrDhi02g==
X-Received: by 2002:a05:6000:430a:b0:3a3:6bc1:f1e7 with SMTP id ffacd0b85a97d-3a4cb4a9760mr1048127f8f.52.1748049540574;
        Fri, 23 May 2025 18:19:00 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:57::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca62b5dsm28769097f8f.55.2025.05.23.18.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 18:18:59 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 08/11] libbpf: Add bpf_stream_printk() macro
Date: Fri, 23 May 2025 18:18:46 -0700
Message-ID: <20250524011849.681425-9-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250524011849.681425-1-memxor@gmail.com>
References: <20250524011849.681425-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1343; h=from:subject; bh=BfPny0l8Cw0cZfbEDzE18g7i4virRqsI5sy2oK7G8M8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoMR3PnOtCgipKjq1JnZfCnVOq4QUU8dgjKnAtFQZS 5veNbnWJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaDEdzwAKCRBM4MiGSL8RyibdD/ 48LB+i5a7YwOkh1GQGic3WZC5kmHn0N+NhXYSiDTGIpd4VmdmNoJb2gSPzF7RnERzHF3H1toY+Z4Ya UjrkF2YIHwovk9Oyrxj+eC0w0wy0QTYYaKwNodWGdHyWCdLg/SRAkV6JLDD2PKlMk189l2Z6TqPLq5 AuKNFdK2LEDtEKTMP05w0tekc25dcROPxIpkFXvT/Zrqjr9wGYHHi8gyZCKa4wRHwsCCKE8HXAGuH4 eEPJDEFFCy4BEZzm/C045yF21wwNx0kKSPnrptrMJF3ldZ1IurSe9SauX1zmFkh8u+oaewTvMP52k1 /ws3aJZSU20OywrGfnHd5wiCSx4NfZGbDtb+fQOgKK861nfCXzO/3GT36LZONXOuhwjSURA4diSq99 j46Pw79Xn3lcSUCaD170KTePRmzVyUSPmtbANEv9EofN3uS8R6cnavW2if0NY0Cc8y9/Mh6zfcovZX eKog9zmm/Qu1MsWdiIztPxOMPqvUFMpE/9e0uY1xdGE64o79CINibKKD8wj68i/uF2cct3W+ynmQoo gkiQcF6oHVzsYOcigfbQ8msJSyI1uOd3mXAq61tbL8smLCM+Xhjso+c4p2U/fmuEJkC5qd1BVE9g/o 7DZMFQaxCMt5OCNHJrtygWX3q/IvqasYDV4vpPJaz45eDi2sC1Of2GtE0Ohw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Add a convenience macro to print data to the BPF streams. BPF_STDOUT and
BPF_STDERR stream IDs in the vmlinux.h can be passed to the macro to
print to the respective streams.

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


