Return-Path: <bpf+bounces-30640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8248CFEBF
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 13:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6131C21F29
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 11:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCB913C821;
	Mon, 27 May 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="cbEkQzJ3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1891013C674
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808830; cv=none; b=iMngqG0sOFJDCtmHsgYGElhJzWgtPvQYYEcIuxdb7Jwx+23opWswPDeUY5uncNkn06JZK4NYnLf/9mOIvXOFPxyi60pFaJV1flQICmUzysOx462k5Iw7oQZj00Qt8QQg9r+oQ11AkGERILlBZP+2berqUgqtphsrNh0VGmlftUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808830; c=relaxed/simple;
	bh=ZAz8Xzht5hDNbrRRXCMcK6jRlHDCF3bhCks5yV5Ywd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YH6p5y7a4SjuQeG9SmY7MDp3Rl+zZHG1hEexutWSgwtobNOAvrejdQ4E3zuy4/ioHBuFYgaf8A3t6Gs32Q+CDvL6XgsCvKH8mI3oIvRPRPaDQqu0KuZNdHqQelLsDd82hr88pcBkb6khSXdnDZvdA3I19hNQblKznMr2jutzWoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=cbEkQzJ3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a62ef52e837so104050466b.3
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 04:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716808827; x=1717413627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haqA4BDbUh78nKLz6G3Lqps7yfTL5kwdneKxDg06pHI=;
        b=cbEkQzJ3r7kVCHxO8xTe/WY6xoaszrwHM34tFfgfN57daTsvjZLlFTFSUc8wMSLWKc
         JudwokOiPmTJWjEVZhjDSh3GS6sSYidJKT6Q49zKGoHckBnP83Lwg/PDaz6i+kWpZCK8
         t1zV08CCAh6MwzP1+kK7VRyZHCfVJRgrGc/UXKBvygCPOQpFJJIHu/JUEN18+04Boy6Y
         O2XCrwJUZTCwbeyXWRees/+RShiyHRhFCE+uDAb89QbPzIjGlez5HhWJOvxKy71PAfAZ
         prO1e0YJBD1M5vBIiDpE0IGUsip8NcaW+wanWIKTdgBLj0vsU41pM8Wgn0Hu31qBg7VX
         gTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808827; x=1717413627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haqA4BDbUh78nKLz6G3Lqps7yfTL5kwdneKxDg06pHI=;
        b=wC7dbvGHWJYkverzPNwbSVqruE6NIeYZ9RKKpc4BWSGFFqNBFZdi8ajHmmFK0V7XvB
         ukHdP8JvkJtIlUGJdtT3WLt92KUMNODv7KAjQrfMGveLJ1xnfdB4KzPHiw0kluZD9JT3
         X9ptc+U1H9tTxoKYB9H/Lvw9XFLzc96mFu4i6LFBHgnacYz+nDezKzbVo1Rz7aYk+RY7
         nA5uzVRKJweB/6MY5h7izmKtzPHBVHGMHXf22ludkzkOMqw3G5rkib4qzYhv1Ea7bfRg
         DRlBV1uYvCy9RC2TgBo3nlNwIN8qR88Kr6x6wJPFY9rd6h3IgV2ch38FoH+9bj2aXsHV
         q3fA==
X-Gm-Message-State: AOJu0YyTTPlPVOTe/LoNFrNqerpQd7pKm0f1bBHDsgSRfdxOAt4BH2/H
	B/yYv7EWS2/8yXUA7rWdPzjWNslmZdHI3C4C+NpI8m8UCelK7kMPvBXsWG3sVp8=
X-Google-Smtp-Source: AGHT+IGzw2VXE2q9cnla69mrgpi/FsdbcwF1ehlQSx0x6IwqLKPoKf2yGxudU46hmIbbSOYye1gOxQ==
X-Received: by 2002:a17:906:cb8b:b0:a59:c3d0:550c with SMTP id a640c23a62f3a-a62643e4d86mr480346166b.43.1716808827374;
        Mon, 27 May 2024 04:20:27 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cd87281sm480214366b.157.2024.05.27.04.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:20:26 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 27 May 2024 13:20:07 +0200
Subject: [PATCH bpf 1/3] bpf: Allow delete from sockmap/sockhash only if
 update is allowed
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-sockmap-verify-deletes-v1-1-944b372f2101@cloudflare.com>
References: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
In-Reply-To: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com, 
 syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
X-Mailer: b4 0.13.0

We have seen an influx of syzkaller reports where a BPF program attached to
a tracepoint triggers a locking rule violation by performing a map_delete
on a sockmap/sockhash.

We don't intend to support this artificial use scenario. Extend the
existing verifier allowed-program-type check for updating sockmap/sockhash
to also cover deleting from a map.

From now on only BPF programs which were previously allowed to update
sockmap/sockhash can delete from these map types.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-and-tested-by: syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ec941d6e24f633a59172
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 77da1f438bec..48f3a9acdef3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8882,7 +8882,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
 
-	if (func_id != BPF_FUNC_map_update_elem)
+	if (func_id != BPF_FUNC_map_update_elem &&
+	    func_id != BPF_FUNC_map_delete_elem)
 		return false;
 
 	/* It's not possible to get access to a locked struct sock in these
@@ -8893,6 +8894,11 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 		if (eatype == BPF_TRACE_ITER)
 			return true;
 		break;
+	case BPF_PROG_TYPE_SOCK_OPS:
+		/* map_update allowed only via dedicated helpers with event type checks */
+		if (func_id == BPF_FUNC_map_delete_elem)
+			return true;
+		break;
 	case BPF_PROG_TYPE_SOCKET_FILTER:
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
@@ -8988,7 +8994,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_map &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&
@@ -8998,7 +9003,6 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (func_id != BPF_FUNC_sk_redirect_hash &&
 		    func_id != BPF_FUNC_sock_hash_update &&
-		    func_id != BPF_FUNC_map_delete_elem &&
 		    func_id != BPF_FUNC_msg_redirect_hash &&
 		    func_id != BPF_FUNC_sk_select_reuseport &&
 		    func_id != BPF_FUNC_map_lookup_elem &&

-- 
2.40.1


