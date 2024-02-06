Return-Path: <bpf+bounces-21285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE03784AE70
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 07:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF131C229F4
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 06:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B440128800;
	Tue,  6 Feb 2024 06:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf8jlOPM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F231127B73
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 06:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707201520; cv=none; b=THpXJMbdfC6Px2/Fa+Jq1z0TLq3TAfJrzNiPvY7h5aRIFKiWwFcO/OcRTj/4A23zm3Qf+RSXYTZm9ACWPmxbR/8vA9tdzWH4c3Uk+q1kjL2ct9CGQNbGCiBgt6YIpqPiB/aGQsw6rrDoi6SjtgBJEgoElH0OMPm19lF9h4I3cdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707201520; c=relaxed/simple;
	bh=SLnnAWMh70aleO3hatX5bZMy8RdZkVmD4faASqQ7FFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B1oQJzq6CmbXwX9oo/M01FBlFoNOsjpR7TL3KOsqQpiqs+FXV9c+jLKr63Y81+ONF8a87U+RZideLcnGabzbUpGWXHjHzIsXq6vHhYth0/of6UeolotTjTw4on/jccYiVog2MNmPAYCjO6zq05Ms7kIRwfHqGeOOOEtBSkHpMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf8jlOPM; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5edfcba97e3so52202367b3.2
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 22:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707201517; x=1707806317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6xWq6VF7W/r4HC8BvQEl1/+gIS1iF5UppNVvadQ1zk=;
        b=jf8jlOPMXfkomPQDwpjoOCxjg1THnuK1NMfGI8Pjta46gJMqtng0iS+VHMtVrxDq4U
         K+aO6gdZE3q/2UD69yTTb6Q/Td836hJvR9JJc3YBaXv3B6OGvFinIcAlMUfzSkXiys8A
         lD7s5fLunzJ2Hp7yyR6weKNnBlV5fZAszs12KTs9E0phAbxnoU8CSNH9lfKoHs7agr3c
         s0BBxWeXXhrz7Arb4+oIC/517sgh4OLTXTVSBGwS6GLjHu9mLqq5oBc3qO98oIDsJ2gD
         tYjFLnpd/bX/gpsCQoodickHOGCKJt9EI+MHCIjGhkygXNZYEbu7UOTZuVXwZ1lgVTh3
         X20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707201517; x=1707806317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6xWq6VF7W/r4HC8BvQEl1/+gIS1iF5UppNVvadQ1zk=;
        b=Y6Rc1hf8taSE0dOM7IxbQiU5XeUlMLgp7xHR0eVPx9D6HuvjsOQTWzeqlz9QMabNBw
         Qiic+bjEKB4PB8culXnuBwEwSpamWJ7XDMlJ2rjJnWg4pGDx7MvaSwY7vuLQ86QgA7XZ
         bVH0m0TqiUO5qA9lq9w5Iv7q3aebZcRif0xoUVQHRMYrBSPU+UFNzo1FA5yKwcUdz12Q
         cOvvi9boXfdqgTxKHlIk80mU8pCi5RwmkpKk7S4svXwe9z4TlmEuHAyumc00C+pzJX/J
         UJBrm6w3wXf5Cbq4Gl3eGiJY+D2PqW3nIEHv0Ft9Vw4eMjCfutOU66ri+LRkL+O/Flxw
         QoVA==
X-Gm-Message-State: AOJu0YxA+4z8uRHT8CbbVXqN5O0tTmsS+VjI6iItF8hRtCC1eWrxN8QN
	0COe54UTMwerXeljY5O1DgfE+pecjWPKfH41PqJ+KQsjWA97gyUshGxRyQ4/cCk=
X-Google-Smtp-Source: AGHT+IGGysi01DNvpuLm3f0WnQNKgX59BdPP2uy8KFa1ob5/akUG1CjUWQbB91pKn9JIloB8hyk+xA==
X-Received: by 2002:a81:d108:0:b0:5ff:76c5:f638 with SMTP id w8-20020a81d108000000b005ff76c5f638mr738336ywi.21.1707201517621;
        Mon, 05 Feb 2024 22:38:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWeaeEXqUyp7erESg2H4zsJydsu++9tvmzpBKvh4f99CEa4b4msmk2qycFxtBrs5kdjgysKAhl380gdba9P+dbaNf5pWDJy/I1hbW9TVCxsoQrdVCY1nbHsBRYHDizFHVTlo4Yd/5j6T6aHVgs5VxvyqTKsU/cmQgXToe8wxxsCV4PI6VeL6tksqd/NE3y2c7ua9iKo4IBuXsRsYZJ+DZWTbsV21KKhbE7d9tyK28SAQsPgdoKcripQe8EHDJlqbSvqKtq104zinxcZj3218t5asRZv4S37upVcDHvvLYa8MlQ=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3a27:6d1a:7c79:c81e])
        by smtp.gmail.com with ESMTPSA id ez9-20020a05690c308900b005ffb91a94e6sm64277ywb.59.2024.02.05.22.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 22:38:37 -0800 (PST)
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
Subject: [PATCH bpf-next v5 1/3] bpf: add btf pointer to struct bpf_ctx_arg_aux.
Date: Mon,  5 Feb 2024 22:38:31 -0800
Message-Id: <20240206063833.2520479-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206063833.2520479-1-thinker.li@gmail.com>
References: <20240206063833.2520479-1-thinker.li@gmail.com>
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


