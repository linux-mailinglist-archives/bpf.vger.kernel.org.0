Return-Path: <bpf+bounces-26344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AC189E706
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36931F22481
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1FE4A11;
	Wed, 10 Apr 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsxKWJFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879E44A12
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709725; cv=none; b=oAEb+rRmmp/OaHZmCjw5wMVvP1pQUNGsASAojzr58b2zjXfozJiTUhD3/z85NsmDaFILkOvsXew8oKWIb3MobCmT8WYNOmjEVpqSY7/Sudeh/JAdy+eTkaoI3IUvoE1zAW43wTNYY/t+VZxdf9LQhRPvxpU7m3ZUIIDfrzoJPVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709725; c=relaxed/simple;
	bh=augahCc3Ewhq83kRindLxC6HqChOA1Yri6+rDpGyt6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLhIf6k1u14doVuyxfstnVmCq8mOSyxUOk9OjexAZv8OOEZMyTCMDjg18SUi8yaSN8XFfBs62gSZW+sTSquQSgUAU1uQppVKQwXwXzM2apCWxxLuC5VVIDse6ZlI4NmOdgxYL9rIEX6CY3WpBqijPWlKoLOa6wzKVDHGulECa/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsxKWJFu; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c6088df378so138712b6e.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709722; x=1713314522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfJ7M5RkuH9cscJgQnxAJ7D57q0+30Pxa+NQ2gc1KoQ=;
        b=FsxKWJFuYCB4ASc6vsM9hA6dIJZlPSKfdHR4h6g9Vrto0H0/TCVQSnbTd39k8m8ZJz
         Oil83ihKkKAPuBMVdBxlPiIUDbR1JpA4U4bhDdQbSg+Nn1aogGSk/1Cmn+Kgz/cy63y2
         qeSCrHl1dbZLdIUCDmtz3B85GLMcR+zk3q8rHaJu4p+Wk4mxeqQcqog/0lVKq0UsEPTA
         keoGPLT3Bti4I8NsUqNmzB+ggN4EjBB6sGOzT9atRJnW0CXmPJBIYtlLj0ktIN6CchJp
         Ug3pu0oICmLh/cW+hWOY+J8/tzY8XusEzFLUIFzWlo1foxOtN0IdwhC5TnsX3zqF5QL4
         EtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709722; x=1713314522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfJ7M5RkuH9cscJgQnxAJ7D57q0+30Pxa+NQ2gc1KoQ=;
        b=hLEjQVKGFFM/yyxGh9zrzDmeDxUK8BocQmASh28aWhW/2HTuF6Q5w5HwDRuNLtIMlw
         6rZ5hYauv/UrRpOU0O7OvPW0GH8X/ketPVVwwIeZqB0r0Op+4xvZE8kR3ahUWN00VhLS
         G2FSIhwXaXhN6ycFtXO0zopWVVxKLVunqjJ4M53EtNvU38xuQWVDFhW6QlOn+YCw8D/J
         3LYWX7gJEaTQJlgdPggWCROb5amritx56F7Ujv5HBD9ozKDZB2/Q20EKU87xVwhTYrew
         LbbgIysQDUrbrwAtbPEtKoTFgEFPNNgrQschuE08cV/6bKSMNKyMBJGCF/sVruCXy8dK
         cP2A==
X-Gm-Message-State: AOJu0YzC6OAPmQcpjORFJQZYli3JWUvyH5SLzZXenUxd8WLQQXn3KfNw
	TQ22KMVcyMx2Ehqr1PjuF94vTLr1DuObS0MOPaU08lTVUt6TYHvGsaI/V81/
X-Google-Smtp-Source: AGHT+IHJHzwrtQhOEAbDvvz9wR6LtJeUsxcPiFSwhIvtuD98y64gN7OoHjZ82uBd4ETf3d0hkP1Elg==
X-Received: by 2002:aca:2113:0:b0:3c6:a0b:929e with SMTP id 19-20020aca2113000000b003c60a0b929emr572219oiz.47.1712709722275;
        Tue, 09 Apr 2024 17:42:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:42:02 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 08/11] bpf: Enable and verify btf_field arrays.
Date: Tue,  9 Apr 2024 17:41:47 -0700
Message-Id: <20240410004150.2917641-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the value of "nelems" of a btf_field with the length of the flattened
array if the btf_field represents an array. The "size" is the size of the
entire array rather than the size of an individual element.

Once "nelems" and "size" reflects the length and size of arrays
respectively, it allows BPF programs to easily declare multiple kptr,
btf_rb_root, or btf_list_head in a global array.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 831073285ef2..d228360ee1c6 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3836,7 +3836,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	rec->timer_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
 	for (i = 0; i < cnt; i++) {
-		field_type_size = btf_field_type_size(info_arr[i].type);
+		field_type_size = btf_field_type_size(info_arr[i].type) * info_arr[i].nelems;
 		if (info_arr[i].off + field_type_size > value_size) {
 			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, value_size);
 			ret = -EFAULT;
@@ -3852,7 +3852,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		rec->fields[i].offset = info_arr[i].off;
 		rec->fields[i].type = info_arr[i].type;
 		rec->fields[i].size = field_type_size;
-		rec->fields[i].nelems = 1;
+		rec->fields[i].nelems = info_arr[i].nelems;
 
 		switch (info_arr[i].type) {
 		case BPF_SPIN_LOCK:
-- 
2.34.1


