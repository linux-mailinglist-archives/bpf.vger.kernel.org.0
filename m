Return-Path: <bpf+bounces-54220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 047D9A65B21
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B631898AC8
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488E1AF0D6;
	Mon, 17 Mar 2025 17:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+7e1vPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231351ACECB
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233251; cv=none; b=jhnzDXgJvGkUtUMnaRu5acDDT3egEvbKTO8NSELb3FjSjgDVHstZBfOn/Zulu3RBXbHoxCMuVtpDGHWdWIIsspKHnnfKF+LJ0zFhQ4TG1z0/DpBv3YVB2e/oWfgMPIU7pSFWaT0fKx4d6nVC/yMpa5OLv5tlN92UKppkQhOm1A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233251; c=relaxed/simple;
	bh=UuWI1MvcsSe1GaZFO3DkoWFOTDolCBhhtF72RwT+Xfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWSZhu7Z297VJ+oGnNWWo+VERj+/OveATnvmCfooqy3VYyekliCd0wwSW1/0EeFyj4zTy/ThqnCIUSvg42bCOxGuRVJJywJ7aioS2It7T9ss+KjkOK0LIIecf84M/0sHnbO7152TWKElxjdZhC/dgtPmhxs5j0XRmECdO+VMNa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+7e1vPM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac29af3382dso780751666b.2
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233248; x=1742838048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAF2qp6ZtRzU7ssMsaG7q/XW9qJxfKpU/OmYtkN9VwE=;
        b=f+7e1vPMQBcTm/HyKDXGI8ck+fOV8d8nXrjGrJ8Hv8IaZBoYA7aBGY1SiHjnscjuQW
         yFAlu851YldY77sTDgunn7m3c/dH9ejDKsBqhelTxWShkKJEwrrpcLjZM9FA3qKrB4Ga
         mqsfJMHZBP7OlwrcyEojiJT7qnW6Z8FAPjg3WeQjyLqjBzUCB69jqXAM64RO19UvLIcP
         NK+QXWRkjL7G5ZP8M68PaD/HkRjGEkZiPitGdsTuXe7CoGIixSVuKgmkr6uPF36quQwf
         RVZjfXbBuXXAZvryyxU26M68whIb/Dp4SUzbE0vpEDJTQvjDKZxvQImgWthQHgRSIn9b
         TV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233248; x=1742838048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAF2qp6ZtRzU7ssMsaG7q/XW9qJxfKpU/OmYtkN9VwE=;
        b=GwsJdCyDJHySUE3F/ZdBCTWu1jc+ZYbyADaZksSfRfJy+gH96r02rjMrsILzmO4Lv+
         oa+kjP4glMft19fbgo6Ig//OdcEae2gqGRH91zRsJlC5heNg4VZpq2i1lndH2apIdHf9
         ICK3GPrSRLgiaXd8oCYv9f3auw93x/8+cN+b9mRpSGJ2pmjd4t9iIMciFrvKrtfy6Gsv
         wdwc1J4C29g5yrkXfMOY1aH9QglzjQ4pjkKdzrzhXwJfQJE2CJee6ylHaPL6I5clpqhc
         lR6EgLiQJZnqnRqXeKGUPPmKGLGKppy9S4sYojIAN1XO3AH3JGvpp+zyk7rp6pcmowVD
         iVkQ==
X-Gm-Message-State: AOJu0YzJSMs8c29HV0q4p4jYydBtMGEFx6rjFXx6TvwVRXACffUal69b
	PVaLnbHC6LFHjmU2nXD3Xl/BKB7cPA/9QGkWspoxsk5KkkQ6898KT+M7Yg==
X-Gm-Gg: ASbGncv2ySjFGYBap6qTBvIQlv6o37RtmHOPLjZ4HSrTd7KFDV4srnspFA+/ZYDar/K
	+6r/OrabcahZhGD/sC0xBG6JXEvVaG4iRkM+1FAMMN1zr8msap8Yvr/scDDe6wl5JWcSa7+cqxU
	lr8w7SmOV1pIGVBMs6RwiL0W21S0GPTJKhc56x7NFlUKOSxSm3IQR/u/ipTciUaOGC1tQkE7cAh
	IuQk3r9ar10/Dqp9vRp1K3ui9ok0v/rJVuA/b3qEXb8eEwjG4zCSP9XTYdQaNPMgbF8GiDlPvGf
	6SZV995Wt6oKqe+5XK1rLN1g0mkNTCjE/UmUBcaART1+leeFukIcFzoN5A==
X-Google-Smtp-Source: AGHT+IFTj63OSlkHNShGDL7TvzLMyPoEMGNlHtDIZdUv0F6NvlYl1Dn+nhV2MjTKFRMPxou8HKhuhw==
X-Received: by 2002:a17:907:7f0f:b0:abf:75d7:72a2 with SMTP id a640c23a62f3a-ac330444f85mr1273615466b.38.1742233248017;
        Mon, 17 Mar 2025 10:40:48 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:812])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9cadsm693917166b.48.2025.03.17.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:40:47 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v6 2/4] bpf: return prog btf_id without capable check
Date: Mon, 17 Mar 2025 17:40:37 +0000
Message-ID: <20250317174039.161275-3-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
References: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Return prog's btf_id from bpf_prog_get_info_by_fd regardless of capable
check. This patch enables scenario, when freplace program, running
from user namespace, requires to query target prog's btf.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 419f82c78203..380b445a304c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -4732,6 +4732,8 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 	info.recursion_misses = stats.misses;
 
 	info.verified_insns = prog->aux->verified_insns;
+	if (prog->aux->btf)
+		info.btf_id = btf_obj_id(prog->aux->btf);
 
 	if (!bpf_capable()) {
 		info.jited_prog_len = 0;
@@ -4878,8 +4880,6 @@ static int bpf_prog_get_info_by_fd(struct file *file,
 		}
 	}
 
-	if (prog->aux->btf)
-		info.btf_id = btf_obj_id(prog->aux->btf);
 	info.attach_btf_id = prog->aux->attach_btf_id;
 	if (attach_btf)
 		info.attach_btf_obj_id = btf_obj_id(attach_btf);
-- 
2.48.1


