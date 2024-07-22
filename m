Return-Path: <bpf+bounces-35213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC6938B43
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 10:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1151F2103D
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0255167D97;
	Mon, 22 Jul 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5f2K230"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157714A90;
	Mon, 22 Jul 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637192; cv=none; b=EnBWWwMG8C6H+wX6VpxaJ4n49cLmV/ZfNmo4Kz6CfkmPHsM78FJ6ES+51HffdMtiVlARN4L0Ko7CYKJOEvVOrymQ/9o/5ZnpGctFs8uchP6eg2PkoCkQmF+UYr+R+lYf7kG8Ey9H5+Ru5KaI4WpqigaIsocoxafzWF5GMizN06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637192; c=relaxed/simple;
	bh=eCj9EMYOnKF0fX6wrgjL/0gR1g3pK2fzn9kJiEfU+qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpxrla0hpTZiF9IqM6LV3k2lcT1OTmbpiTZPruOOvIHyhx3k4D+dCHGLxJBgNVOuM0EJzuGSS+hjdyQ8zN2WXQBQCBKQO3dlOH58YSE7rIFjgQIW8mvWpO3qHUGujqkAp96YBPnyrjdbOSTCje+yhJhWRrekjPHI24gDMTHWPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5f2K230; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7a115c427f1so544391a12.0;
        Mon, 22 Jul 2024 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721637190; x=1722241990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Obuz2kCskxtuGoN3YvNYJ1ptjk2cssEFAcXdb7veIq8=;
        b=C5f2K230GEsa7il7uEWgdxabshdXcFQeAdVFhoDCRv3JcIh+swIQnhywbcux5YGWWu
         JbMicI2Wa6phKPIA6QVKpLfedZTBn/U6eS8owMdHK1XUTK/PzL/yPj4U3YU6LTfxyHAB
         AavccbozMrTQsk7k7XMuZZA08Rv9gnZhrBugMbOA9GhpA+poCOQb4OCj0RWnkD+7TAAp
         GjPX6EK9qgraGnfST/YIwll/D0kBhxklMBauYgVlh9P7J7el/iIXPg8oKS8b/6ixj75j
         5ojOQaQjlGk72MP5f2g7sZTHLsrg90L64e1dzq9l1Np4POI56JiQymn6KhV5xWwBtOUX
         x10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637190; x=1722241990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Obuz2kCskxtuGoN3YvNYJ1ptjk2cssEFAcXdb7veIq8=;
        b=lPJn5J73435rqPQQcKSDbe/REBhoPz/IKwu4v1ullnoK7eg5eZ4orNA3NeW2RAm1cA
         5iEOV4k2W3QMSnMZmmrg2yTk24tJb/zJNMtrBS/PZkiZMO+o+JNX1xmB2DuktfcCPSdz
         ja2mOsaxQIQX/MWJaZwq7Ur9o6lnCC7rKxus0ZvhuZg01ds+aVu0NC40JCALe7agHy1s
         sehfMSzNiaaTbDte9s7oLQgdnTTeCTgHAqVP47FvdTf8j5UjSImAfXajoq4470PFFYzg
         /RhuR8hr1EouWcwVkYFBKnHrS48kB45eDFK6ImFYF7YDlqxBne9CUkqz+Dqt0Q0bXOSZ
         7MLA==
X-Forwarded-Encrypted: i=1; AJvYcCVfG9y716ZyWaYtPdB4Ab60hWjO4HhY2Psjl4Nll147JIBajcbJqZ43eo317xfetC5cMXIPcxHqtqu8WYk41fFEisYW8l9gUnppdoD7
X-Gm-Message-State: AOJu0Yw1lCCLsJjap5DuOE65Q7K8JxrNFmzXVuWiGPHuldBcI7eoFVJw
	7LpPKmkObispFgOb/lX1BZk1CV24gO0n3/uhcTb5tvPPCqBqypsx5+4pB58i
X-Google-Smtp-Source: AGHT+IEXjwX7jlPOQbS2EZFvty/+ZlLzvWL0YFWZy2E3S+rDb61o9f46dScNcKnqk6pysQrAPRQ16w==
X-Received: by 2002:a05:6a21:78a8:b0:1c0:e925:f3ea with SMTP id adf61e73a8af0-1c422896fc3mr6485952637.16.1721637189552;
        Mon, 22 Jul 2024 01:33:09 -0700 (PDT)
Received: from localhost (unknown-146-64.windriver.com. [147.11.146.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb77311c4bsm7518908a91.22.2024.07.22.01.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:33:09 -0700 (PDT)
From: Liwei Song <liwei.song.lsong@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	vmalik@redhat.com,
	alan.maguire@oracle.com,
	friedrich.vock@gmx.de,
	dxu@dxuuu.xyz,
	linux-kernel@vger.kernel.org,
	liwei.song.lsong@gmail.com
Subject: [PATCH] tools/resolve_btfids: fix comparison of distinct pointer types warning in resolve_btfids
Date: Mon, 22 Jul 2024 16:32:59 +0800
Message-ID: <20240722083305.4009723-1-liwei.song.lsong@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a type cast for set8->pairs to fix below compile warning:

main.c: In function 'sets_patch':
main.c:699:50: warning: comparison of distinct pointer types lacks a cast
  699 |        BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
      |                                 ^~

Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")
Signed-off-by: Liwei Song <liwei.song.lsong@gmail.com>
---
 tools/bpf/resolve_btfids/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index af393c7dee1f..b3edc239fe56 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -696,7 +696,7 @@ static int sets_patch(struct object *obj)
 			 * Make sure id is at the beginning of the pairs
 			 * struct, otherwise the below qsort would not work.
 			 */
-			BUILD_BUG_ON(set8->pairs != &set8->pairs[0].id);
+			BUILD_BUG_ON((u32 *)set8->pairs != &set8->pairs[0].id);
 			qsort(set8->pairs, set8->cnt, sizeof(set8->pairs[0]), cmp_id);
 
 			/*
-- 
1.8.3.1


