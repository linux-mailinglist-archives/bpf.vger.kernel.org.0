Return-Path: <bpf+bounces-9868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB9D79DFD7
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 08:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796C11C20B78
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 06:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EDC17982;
	Wed, 13 Sep 2023 06:15:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7AB156DA
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 06:15:16 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69435172E
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:16 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58c92a2c52dso61502307b3.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694585715; x=1695190515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1AUi5XZaZkF928E5BkoCdb8m0OsQnlGRTe72qLMaqM=;
        b=g7JmMV7Vwgk5a0OqmdqKZPflKHd8UERwyVZhUO4AWw6LA5ENXgaiuTZJtnMGxZiHPa
         Lg7u0pzlWoiaeOiKR2WTJmq67n/AIOZ49KUQ/qMMHsvgVC+AGWhH8x4pyuYOiNqHCu9+
         Fgew+9Ev/f+Ui/CS9hhmzZ8EiEz1Qjy2Qdiu/quxHLQWh7ok+Wa1FD156ISfYzBGIAI9
         84ZmkYAOdGKLAqYsQocZ/YlayvMlxf6ZwC7jwm87sGO2uKrrS3i/qUKyrIpXhG+bz04H
         VdmmCBq+bDRa563uMtXl9NTch+Ce2Qnb+N24haUaRI9FrYYo+0QMlMeyJ1H2FczjDq9w
         WD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694585715; x=1695190515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1AUi5XZaZkF928E5BkoCdb8m0OsQnlGRTe72qLMaqM=;
        b=Bxt/KqwcJzvSRiOBZP8070ffo1DHCgUswKpbMgpqPVWXWlJaJSpAbU2ZDtWlhX54gV
         8fOjwMloMnuZg/k8yhDDrWNeLSzJLvTkWJSC6E3IFlnmyj4CxaRPUUWow3EG12eKYHH5
         ZN4a0FNgoNgs5Py88YCimd+P9ZOhf+MFLA//y20ae5oe0u3YZrVLowTg6BzPGNONUlGL
         MYPBKlHSdVVZKTwNDDzdPOlmUSI7f4LptBpOywbFrkoX6OPC9E0XZ382OqoK89H97Zbs
         rsUdY77JRwlIWRDtTtbvJxiV4Xpxkp822LDVpXDe/vgR77NP9nQ/yTE1Ci4iF4bL3FJp
         lFtQ==
X-Gm-Message-State: AOJu0YzsNUYybbSR4FXTD5SwfUZXuHN0caBajFqpljY73vMrCmKZK6JK
	AqmWvCBiKmvOKvqfAmmcosLxfvKuLOQ=
X-Google-Smtp-Source: AGHT+IFpsEb6wQ88M+vZ0APdeDYJfEn8g71T2oEkPdBi1YrQKsLzYue7tbm9TcjolW3IGw8/doiAqw==
X-Received: by 2002:a0d:ebc3:0:b0:57a:9b2c:51f1 with SMTP id u186-20020a0debc3000000b0057a9b2c51f1mr1693405ywe.1.1694585715381;
        Tue, 12 Sep 2023 23:15:15 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34c0:240e:9597:d8ed])
        by smtp.gmail.com with ESMTPSA id b132-20020a0dd98a000000b0057a5302e2fesm2961454ywe.5.2023.09.12.23.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 23:15:15 -0700 (PDT)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v2 7/9] bpf: export btf_ctx_access to modules.
Date: Tue, 12 Sep 2023 23:14:47 -0700
Message-Id: <20230913061449.1918219-8-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913061449.1918219-1-thinker.li@gmail.com>
References: <20230913061449.1918219-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

btf_ctx_access() is needed by module to call bpf_tracing_btf_ctx_access().
---
 kernel/bpf/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 55d76d85c6ec..ae2cd120e426 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6115,6 +6115,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 		__btf_name_by_offset(btf, t->name_off));
 	return true;
 }
+EXPORT_SYMBOL_GPL(btf_ctx_access);
 
 enum bpf_struct_walk_result {
 	/* < 0 error */
-- 
2.34.1


