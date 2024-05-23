Return-Path: <bpf+bounces-30399-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9708CD3E4
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 15:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25CF728527C
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E0214BF85;
	Thu, 23 May 2024 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AhfNMaPj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351814B958
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 13:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470369; cv=none; b=bvDlnEIJjIyVqYQoot+q9qIla/Dp41W6qWnVGeEdHMNAFkngX1K77iuSVBpmI2tqNO8DxL8P6kUCWK1TOAvIVwTrsEQqUbuxNdTk8yeaX/8+l+VRBEhp7ru8B7yQwZKCD+gLTg2cpjmt0TlW62A1j3qFWfsyJ8W8SdFxHu/2uyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470369; c=relaxed/simple;
	bh=l8hu1asRAlfrUBetEijX5IlexmULZqqVhN3SFs42qDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rp8BMGaJ1ZoB1cCWMGrnLcFHtzaHVIECrJB2QbDFf60RzYKHYKPXsbkZhccy3SfW49Cj5S14yhnLZ6kC+1BnAfZ6eMQ/N4fPXfwEVSPQnT4Qhkf+dL+TlY04Q3e3jD957ydb9MJ38+y/Wuzj0KJYdahsP2i9MfIEA3sf9KmkwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AhfNMaPj; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f174e316eso7258376e87.0
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 06:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716470365; x=1717075165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nNwO9Ic2zQMFI45zeTo40DLJkRZcuAasX/LCqNjaOS0=;
        b=AhfNMaPjBGUhEc+bYJDI0ZZO1Ki32auBEk51hSiC+2NiQ2tWXGvIyn0xzk0YuT0lyx
         o8CMg4gOexm6adCcY7lI0H6lt+R17bNz+tCcO2ZDHjCETh5W0tJC2QOcvFyQHWSb2zjy
         4egJOMKmRdYGlpSJDVym/wcGx3S2iPtjQFnj99MxO2ESSvCs+Kbrw/sb08G4FN2Bz8p8
         djwyZ79EWDHaAvL1vzCvZGnqu8jwbkuyrHCR/IcVpojYQQYm7zuuwcf0QB/IQT4DJlZE
         0BMW4mRJCIX0xonDraDIxKigkeLzeRFH6zAlUnlSMfLL8JJh5cwqW7sw9iyvvSB++let
         3H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716470365; x=1717075165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nNwO9Ic2zQMFI45zeTo40DLJkRZcuAasX/LCqNjaOS0=;
        b=MUkDi6/qnH6/1IWi67St8MVZzF8IRaTZgp4D+XFXvjrBbV1qtwuntUMWgfEInZPOgj
         WkbEtdLod3GZ5Jq1LT3X+kg+B4EZ76EH+aYCDOK0iC2iOjnk/Hn6cwuihwzeEJ800jER
         MxXwfX6/BwQCVuzVoFmaJU/6pa9xDk00WhXOKWqrVZIdc/a5cXCFZNRaMhMH7CGYHU/D
         nlRRQCUYRMstTQOIvEzfG+5htrDc/Phe2va3XueJ14IofWkEZffmEVzyJ6X9NZ2c6d4F
         7pcBZI+0lDauYCYzhAk0nqRm6YLJyoJ/J4wC6YXQj+Myo8eF1bdnzuNQVQvxlPc/DEWN
         UFew==
X-Gm-Message-State: AOJu0Yxupa1rTLNfAdsNcOfAvdaoMFKyhpCdphc1RMrQoUUjx5a/0d2+
	bkUX62fQZo2Y5I96w2Hb8ByJFdOUQAzotC5WggEij1PjaAxj+vJ1tI4O5paD3usWwKLIA0aW+PH
	P
X-Google-Smtp-Source: AGHT+IGFpgBkx7ZeY/JlAOQVrQkxT3kaq92IL4Fa15zDX3GuWjlUzBMH6HK/pt+4TTWmNT9Dc/ak/A==
X-Received: by 2002:ac2:5321:0:b0:51e:b5b6:29fb with SMTP id 2adb3069b0e04-526bf17348emr3003062e87.21.1716470365189;
        Thu, 23 May 2024 06:19:25 -0700 (PDT)
Received: from localhost (39-12-41-105.adsl.fetnet.net. [39.12.41.105])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4893700e47fsm8039202173.15.2024.05.23.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 06:19:24 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrei Matei <andreimatei1@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [RFC bpf-next] guard against access_size overflow?
Date: Thu, 23 May 2024 21:19:01 +0800
Message-ID: <20240523131904.29770-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Looking at commit ecc6a2101840 ("bpf: Protect against int overflow for
stack access size") and the associated syzbot report (linked below), it
seems that the underlying issue is that access_size argument
check_helper_mem_access() can be overflowed.

E.g. with a bloom filter where the value size is INT_MAX+2

  4: type 30  flags 0x0
          key 0B  value 2147483649B  max_entries 255  memlock 720B

The ARG_PTR_TO_MAP_VALUE case in check_func_arg() could overflow
access_size. (Potentially in the ARG_PTR_TO_MAP_KEY case as well)

  case ARG_PTR_TO_MAP_VALUE:
  	/* value_size is u32, access_size is int  */
  	err = check_helper_mem_access(env, regno,
  				      meta->map_ptr->value_size, false,
  				      meta);

Should we guard against such overflow? The easiest way seems to be in the
beginning of check_helper_mem_access(). But I'm not sure if there's
anywhere it is expected that access_size is negative?

AFAICT the main reason we have access_size defined as int is to match the
return type of bpf_size_to_bytes().

Link: https://lore.kernel.org/bpf/CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..96f2c4014937 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7284,6 +7284,9 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
 	struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
 	u32 *max_access;
 
+	if (access_size < 0)
+		return -EINVAL;
+
 	switch (base_type(reg->type)) {
 	case PTR_TO_PACKET:
 	case PTR_TO_PACKET_META:
@@ -8778,6 +8781,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return -EACCES;
 		}
 		meta->raw_mode = arg_type & MEM_UNINIT;
+		/* This can overflow int access_size */
 		err = check_helper_mem_access(env, regno,
 					      meta->map_ptr->value_size, false,
 					      meta);

base-commit: a87f34e742d279d54d529e4bc4763fdaab32a466
-- 
2.45.1


