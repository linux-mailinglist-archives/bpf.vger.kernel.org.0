Return-Path: <bpf+bounces-21482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43484DA60
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 07:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE8D1F213A3
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 06:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BD2692FB;
	Thu,  8 Feb 2024 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnUh50em"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395469974
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375070; cv=none; b=ESyt9izYgVKhpcS4PpY9xRm1HcPNCQNtJecBW66r9Thvo3P0wfKDrAOl8GEp/d3RjLNhxYIctKf5Om0BUqfaaFBSir5UR5E7k0kkkeotMTGWZk3qr7XUTWiDuOh9IxCJR9l3pDW7TAd377wnKDS5RjqQ+b0prRoSwLBBH+OL3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375070; c=relaxed/simple;
	bh=SLnnAWMh70aleO3hatX5bZMy8RdZkVmD4faASqQ7FFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QpIjG2Uzhcg3h5g1D/RTCH6vWbKG7yKKOdAH5m5L97kDKdKuragmwMdzyQzJ9tA3z15I7nTEA92jHfy5Qw923s8GGnuwkw/FK/m+cZzo/j6mO3pwuu12BZ2xGI2xkyhsS1nwx9AEbLpeOChooNpyR4R+dyTe5GOweifYmbEUk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnUh50em; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-604983ea984so11912927b3.1
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 22:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707375068; x=1707979868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6xWq6VF7W/r4HC8BvQEl1/+gIS1iF5UppNVvadQ1zk=;
        b=VnUh50emogZk2GHqh/OnGfggf+Q3gg2ajuRxvphkSFRgKoabVWcXRlXqEihHL8d4Ep
         hjKogaais6eFWlK16apHtQLx3juYSEx1gJmP0lfh9TnY2/qCQQCsXpFV/q4eX+nn7K1W
         fmrMaAZ7y4LgyeOA5oxLcRzo29kMkrRWRUApZIdPlY/XfaKT+pP1hecf/F9dDnNbIL0P
         AR4JlUksAPhztcPMlpGenY3Bf12vWc7zcq4hK/N1GcundLhnMefvTq2M/7VYRcbRLLPR
         a4bMSU3rKDURahtm4p52laaG9Y32KJwysXf+iChVVHId5BOfJCEccithMZgvZw1wMlQ0
         gu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707375068; x=1707979868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6xWq6VF7W/r4HC8BvQEl1/+gIS1iF5UppNVvadQ1zk=;
        b=HQ4/iXBZOB4vFb2jQYrNA/W2TKVWl4gjKVW9GkNH2d8U/JC6EtiIt6Q+eCwaU9+fQN
         afKziJXM+2ociwcAyl/HZViwcMLgbou+aiQEO6s/51wkqAEgXBuk14R3O3RBi+JA24sl
         wRZkUeUu/i0s09bouu8o7+mOMzVwxHAYITUmknvclR8Xvy8UYEKdiTGvy5gDP7VGD73t
         8Te/ii0ld6Aqu6jneutcsJSzuAdyagB/xJFyizCH+UyTzJ3XLSQt7rHjexTVjtaoV2h0
         IYTdCb0uuLZwXKLM8CX5pnti5IqBtzAYTs1Jg/sZ5deIiAuHA0SOlawhczNBjJIFsgbu
         SkZA==
X-Gm-Message-State: AOJu0Yytr7ly3L8gBDe2n0BfZmRM4z8UFpD3IKDeh3/tSM3VDO6CMFBI
	7/bMWMaV4aWJDl0sl9gFFc78l31cFD1dDbky2i3pQyHfo1aMqK7ljPYIzQ0QQwU=
X-Google-Smtp-Source: AGHT+IGVEqj7qlcsqPMNpHj9IxxcNY+SvIpdGpfKsAKx5CqcaEtel4VVZLVTmY7VZ6AjzdwOuI1tUA==
X-Received: by 2002:a81:4148:0:b0:5ff:92f1:8e24 with SMTP id f8-20020a814148000000b005ff92f18e24mr7682144ywk.48.1707375067869;
        Wed, 07 Feb 2024 22:51:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUgiAw/ViYkZ+Z8rGTkQgWJTx7AMaXlQAbG0b3Mp2PCkCe6dfVkUxTAUhYAlifIM4zy9vnL45bY9b2GQ1Knl2L9U/ynGRYsExzBuBvqM+hcOe1hA7uerGmHQfZsCM4LMkPzeWxRAiec6Vq3aBlQlO+zQ/fxKz0hKEj+OXaRopWMM+8mCSJ1P0CYcQPmL1Xv5tb6aBx+kgZ0LrGu1Ui+GcjSYrXHL2scnoYjFrZFYRZmHOjaG6ob2KMcCv95lOLXilsFXTDj6CLcf/fjsThUkGKlnkpV6nYOI6aSRU2+FY8qPb4=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1d02:e957:f461:9a61])
        by smtp.gmail.com with ESMTPSA id u203-20020a8184d4000000b0060467650c64sm596917ywf.62.2024.02.07.22.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 22:51:07 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v6 1/4] bpf: add btf pointer to struct bpf_ctx_arg_aux.
Date: Wed,  7 Feb 2024 22:51:00 -0800
Message-Id: <20240208065103.2154768-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208065103.2154768-1-thinker.li@gmail.com>
References: <20240208065103.2154768-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Enable the providers to use types defined in a module instead of in the
kernel (btf_vmlinux).

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 include/linux/bpf.h | 1 +
 kernel/bpf/btf.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1ebbee1d648e..9a2ee9456989 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1416,6 +1416,7 @@ struct bpf_ctx_arg_aux {
 	u32 offset;
 	enum bpf_reg_type reg_type;
 	u32 btf_id;
+	struct btf *btf;
 };
 
 struct btf_mod_pair {
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f7725cb6e564..aa72674114af 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6266,7 +6266,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			}
 
 			info->reg_type = ctx_arg_info->reg_type;
-			info->btf = btf_vmlinux;
+			info->btf = ctx_arg_info->btf ? ctx_arg_info->btf : btf_vmlinux;
 			info->btf_id = ctx_arg_info->btf_id;
 			return true;
 		}
-- 
2.34.1


