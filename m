Return-Path: <bpf+bounces-56229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85FA933B4
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 09:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7822C1B606D3
	for <lists+bpf@lfdr.de>; Fri, 18 Apr 2025 07:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6526A0E2;
	Fri, 18 Apr 2025 07:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AoA57unV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D601A2658
	for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 07:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962595; cv=none; b=FlzxoWJWQ4vys7onEgFWbbNHxgfisRUgyQaaHHOD/0JAh3hA31PWa0wgK+hjH1KsQbkgK56VZCcmOTj7B2lLFlBoioeejqlHpaOBeSigiJlwYFIIDKymVNqq4cNOYk4FtMB7z2vgBqFkvJJXOhwRkWkpNN6JlgS9QOyiVe/1T90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962595; c=relaxed/simple;
	bh=3k4ZWLY8TJKf5fxPuWKCzFXq5vCY+7+sDfrcX4drWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NKzJlLjqVI3vsMddRaTRYTdTgx+Qm1ABBfcGxYorOCelvO/8zEFQmLi9cbaqxtsbVjl5ubNM+ypQ3WNKgrTp9SHF3lzoF/iM/XBoeI79GTpQ4azUF6RUweY0CYONczh9a90zZjYGn/q5MwUS7ikP5/nZQf5wOFHC+mEnQ1c6ycA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AoA57unV; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-39c1efc457bso918378f8f.2
        for <bpf@vger.kernel.org>; Fri, 18 Apr 2025 00:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744962592; x=1745567392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nt4ATbDJ+rviJ5d7lD5czdgEDG9Oj3FixTaZAOFmwEo=;
        b=AoA57unVfj5T4k8rTHIjaT5Wjnmij3LFEfT9+O1XjvkpcYfVU1r4KMlI8OWjdWLjEY
         jhYjvW24fEz8IYSmhdotcid8WopHVPnREWrRRCKSvE6h1LgqvTZ2B2InvSCUj4ib6ofv
         K/ce3ARlKkyxzl7vzdSX3VTcik9v4dWeOSZrJ9VxlYM5fCaergjL3ZUcW81q/k9ZnGjo
         cvJPpE98ScMTw2IuCcEzvuWUIyZId5U4W9X56b3D889JK+H0qukTMyRQCjeJVaSkkoT2
         qFwacLbL4KuyCCvvsmoTExlGNNDy6wghwc5HNZ3C5yz5Jxs3fmXeJ99CTngjFYH8WNui
         Pwjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744962592; x=1745567392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nt4ATbDJ+rviJ5d7lD5czdgEDG9Oj3FixTaZAOFmwEo=;
        b=QXCIRZvKM5QQP8lkbE1rGMYAhb0sMV5iI5Z1xz3dAVI5S/hhKqySHvyj42PXn3s/wx
         dwyCBsAdnO49V5hgXVt2uLma4ff6cVdsHdPhQMIDres1hNEL5SsbawqglwOBxGdlD9Vn
         Ho6q7ORU/wGYa4o2LVhkfTFLr2SzH/2QVqbD6D7+nI0CbJjJm1HflEn5t2VqrsDvjf4n
         QlZSQmXCHl6zuQ+clELFj6JAnUyGbygKAXjQo1KdafJqb+MbZR16WR0YJwuqz/NodAoH
         N0xYUGQVDGAEq6tiVNIXpfuP0DR/klVmHBnyRo7JFU1km8xXV5ItCpOrie0ZJGpOP8aA
         Dumw==
X-Gm-Message-State: AOJu0YzDZuIkdxC+9laBbXarCa/Nz9uYlSn9nyk1or3yUxk88EX5gcX5
	GVZZg/WKVaEPWn3pEThq5oap215jfQrKdFgNaZcIWs36b6WfJK94J2u0kcEK7S2zmslQh8mIZyv
	zNZZE/A==
X-Gm-Gg: ASbGncsPoZ+2fWfv7uCcmHyJY6i75k8+YAc764EU7ahLG7Z11MizPk2/6x1Vuysn0tL
	QUbaMO8D1UBXHVhjsmBJAfKsLTqjm451bAYOF/6BbY3trnBT58n+Ak23wAr8Hggh0pQiTq0w5mf
	neUj0Uzx07jGaE5MeTXNV5rnJcmklnqzARvcaiyLVE2CvbdmQuqOJzmGDnC49oweM172WHSIpmM
	/oUi+TrE7ECgF8WeKaXjUls92H5YhP7lKZL1c0owKF/MsxJvZmwgDDxVWywzSkawClgVbZzBUXD
	ZcgbDN/jvQD0a+2pM0G8ISemusAnrP9CyDaR79ps4LELwBYIgkSskKSgw330FTHVdFMgNhaBfFB
	FdLihteU=
X-Google-Smtp-Source: AGHT+IH5lyLHGS2JlVoFj8FgWcpGHox/dZCFjbu4fzuWebFWclJUzB+p5oymdEGMZUc1kRSH45Nc3g==
X-Received: by 2002:a05:6000:2505:b0:38f:3c01:fb1f with SMTP id ffacd0b85a97d-39efba5f857mr1120069f8f.30.1744962591939;
        Fri, 18 Apr 2025 00:49:51 -0700 (PDT)
Received: from localhost (27-240-201-113.adsl.fetnet.net. [27.240.201.113])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39efa4a4f21sm1980338f8f.91.2025.04.18.00.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 00:49:51 -0700 (PDT)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH bpf-next 1/1] bpf: use proper type to calculate bpf_raw_tp_null_args.mask index
Date: Fri, 18 Apr 2025 15:49:43 +0800
Message-ID: <20250418074946.35569-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The calculation of the index used to access the mask field in 'struct
bpf_raw_tp_null_args' is done with 'int' type, which could overflow when
the tracepoint being attached has more than 8 arguments.

While none of the tracepoints mentioned in raw_tp_null_args[] currently
have more than 8 arguments, there do exist tracepoints that had more
than 8 arguments (e.g. iocost_iocg_forgive_debt), so use the correct
type for calculation and avoid Smatch static checker warning.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/843a3b94-d53d-42db-93d4-be10a4090146@stanley.mountain/
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 16ba36f34dfa..656ee11aff67 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6829,10 +6829,10 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			/* Is this a func with potential NULL args? */
 			if (strcmp(tname, raw_tp_null_args[i].func))
 				continue;
-			if (raw_tp_null_args[i].mask & (0x1 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x1ULL << (arg * 4)))
 				info->reg_type |= PTR_MAYBE_NULL;
 			/* Is the current arg IS_ERR? */
-			if (raw_tp_null_args[i].mask & (0x2 << (arg * 4)))
+			if (raw_tp_null_args[i].mask & (0x2ULL << (arg * 4)))
 				ptr_err_raw_tp = true;
 			break;
 		}
-- 
2.49.0


