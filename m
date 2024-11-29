Return-Path: <bpf+bounces-45878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8C69DE77C
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 14:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6864B161726
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A9919E806;
	Fri, 29 Nov 2024 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="D2yAPRvC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8719E826
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886768; cv=none; b=C2IXEP6KJOVaL6ue2z3uEaRk4inXmjMjiRfp0FLE1kO0QKkrbBKHalpc5ZAvmXR9QLTFQkIm6fveom6I73qoAqjegkMls/veDe+I2lmNnfFPFjjjSadhV5i7L4KBy+CJDNxLMH0/ow878ZqjRXSwVs+VKRqfDMnAjj54PoKP1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886768; c=relaxed/simple;
	bh=5M+9sZ2uOISCSb6KW/FXzpjBYHwIs149KFBIoWPdbV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kdB2sBAMkdKiXYaeZiJLZj/D92DXMbd6VhD5rmnPs1EYw/ShjOoatsVTCk/hdPcs9lbpQp9bYeoM85X7zmr0cDXFF69OWpiA4C/viJl31RQeIKNQZ7OkoBymizM24dl/U/1KDcghG0lS5rBPcFMN+QKpWB3/qnu5LWbzlap8lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=D2yAPRvC; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa5325af6a0so244147266b.2
        for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1732886762; x=1733491562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=D2yAPRvCkt2QQuKEXD+sbXp9pDr51lpMALL5co40Uz4srVdJhUjdgUMECgVB0tjPYu
         0qnUAWJAdejUv0zXNvvn4owC2qFMrQURsKR89YcR9bipKVSxyit+4hHHI4oPiQIuNl8u
         F6qxHYWPfDF4N1lfZgnNQXPbcEgccSqecqUNS1BlwT7uazWzZsZ91reQ+5P2OjBmnw2p
         BwJm9EwVlc8YcOyxNuOCZ805beYtnqzsnzqk5YSDkdAkHfaA5EYZdes2uH+8xEuD4TgC
         mQHAL08mTZJgAqQKUrdHnbqoXEr+f/w8prQk+B8qPkb6oHW8/Ims5S4hns87yzjjRKaO
         KLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732886762; x=1733491562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95uLp76JDqCGAntKfWwQIWRGb8VQc95vaaCgVutyp08=;
        b=DrnJrwV9E0jmiZlvuV1y7pfpTnpfdksRDFUNCW8sQk6wDTzC+2HL0nmAEXVBVnrhZz
         +45HYy+w1YkOaiGu+qn/IOgMsG62rIMCSw/0DzQ/SOATuZNKbLBgaLQtxpDQYQ6Z9aRn
         9XOMwEfGbV31GXcqcf5qIKSli++9aAB63Run0EiN9KuDUk+1HIzNnK5lo7am5YosVODo
         89uFaYFRQbyf0WqCcBOj8ye61Okti4A8TDW+P+TPstUqYRkmkcWIImCuGxUZW48qOd1I
         ToXAbCtnRT3VopBeG+4VP/IyOnD8Km/FEMqqArlRSkwfJ+jAt2OlRYga1jSMPAbhDl9G
         IxTw==
X-Gm-Message-State: AOJu0YzkXuy1PelXyCxdeFsj/JBGhHdfz79ygArzgjmdSuNVN9cWy6fO
	OMq/KDHJlfHm4kgfnfuYcuZ7D/IfqbC6dUeDjfnw3F1CiXSPWdas82Pn1jxmUohcs7ObCSHkQYi
	u
X-Gm-Gg: ASbGncsucpOqG9ohg39C8CC3yriLNtUlde5s1HlenU6GAGL9LfbgQm2R1Bnd2uJYBbP
	MtUBURu/gY71mGBzAVODYe/XaqHq3IaInkvU1E6tQeKMH5hQcBephw0TqLXu1qZp1VD7WoaNNUk
	28T9r4f8u40ygnErloSebq0Ym2RygN2KpK0odTlMsqYOI+nXogoCWlEmL2JLsC+0z0oYa4giCWi
	zRJxo4OVnriKeky4mO69y0JeEN+/bnnRGW4f8GnmaCJ80oV3KSE9EtLCP2GMu4=
X-Google-Smtp-Source: AGHT+IHHyk6HIjbwNkEK6rJ0FdHykw43HV1JWlx9lFXBP+TsV3R5Jj1b02ZX/w2auWD4b9NkL9k2DA==
X-Received: by 2002:a17:907:7809:b0:aa5:2b4b:616a with SMTP id a640c23a62f3a-aa580f1b29cmr867150666b.17.1732886760255;
        Fri, 29 Nov 2024 05:26:00 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa599904f33sm173295066b.135.2024.11.29.05.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 05:25:59 -0800 (PST)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org
Cc: Anton Protopopov <aspsk@isovalent.com>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH v3 bpf-next 7/7] selftest/bpf: replace magic constants by macros
Date: Fri, 29 Nov 2024 13:28:13 +0000
Message-Id: <20241129132813.1452294-8-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129132813.1452294-1-aspsk@isovalent.com>
References: <20241129132813.1452294-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace magic constants in a BTF structure initialization code by
proper macros, as is done in other similar selftests.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
index 0f4dfb770c32..b698cc62a371 100644
--- a/tools/testing/selftests/bpf/progs/syscall.c
+++ b/tools/testing/selftests/bpf/progs/syscall.c
@@ -76,9 +76,9 @@ static int btf_load(void)
 			.magic = BTF_MAGIC,
 			.version = BTF_VERSION,
 			.hdr_len = sizeof(struct btf_header),
-			.type_len = sizeof(__u32) * 8,
-			.str_off = sizeof(__u32) * 8,
-			.str_len = sizeof(__u32),
+			.type_len = sizeof(raw_btf.types),
+			.str_off = offsetof(struct btf_blob, str) - offsetof(struct btf_blob, types),
+			.str_len = sizeof(raw_btf.str),
 		},
 		.types = {
 			/* long */
-- 
2.34.1


