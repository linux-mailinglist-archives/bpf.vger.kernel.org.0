Return-Path: <bpf+bounces-70153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07C3BB1DAD
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 23:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6777B30C9
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 21:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5173D3128C9;
	Wed,  1 Oct 2025 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnITfPzn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451C2E093B
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759354189; cv=none; b=JUVBiAvurvG6vo+afK95EDGI1jvDd8c/4jb2DEmYCJvJ2rzv3Ri7nmJV2hglioMpE2yq2ZI4MmWgp/jcLuHJrZQ/3dOdEUm4mUl4B+gesFuTgaTYOtyG+Cnd3d02P6GZxjnN4/3Nwhe2v9fUaaRc32eD49heewGQEYh1aa3ZRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759354189; c=relaxed/simple;
	bh=2owD9T0hnVMSmLwXWpFD0vuKwaTBJW57isVeF+Jaazw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHGrAnLyNWm5JvjGsLeuvd1ebYTzOs/c5iydFBBPpZgUjSXJGfX4Rm/n9U8fFl3tq6SzWLYWC/9P8cLVNkVv38OkUabJhj6mjhUXZTDwicsY2HVQM+4Akqo3b0nvZIKmg72KDaoKV+p9EagtMN3dmXIcLpyL3/y3Ha1JhfH+kdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnITfPzn; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42421b1514fso123456f8f.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 14:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759354185; x=1759958985; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W2LVfMkD9BUiZKUknkK9E35xkFi1qhUGUTkDbAM5Pz4=;
        b=fnITfPznIcIdPmOYkAzQljKWmQ4z2O+7zZTsUa1RPIHI5oFdBRg6kYKzIBLQFtgflz
         5b9tVpNmQrsRF4NiB60cMrHGMorr3uYCilPliAhgrvBCQocOvUpjTBJsS9ArnpsBpac+
         jyW7hLx7QL8zVOvl9/qKJpOpZAMtdXVoTODkcdxQYMpEp5isJSYDQ1pcb3ZfDOt+wEx7
         pbDSqsyRS9LbW0UJwKtbeejXfk8/BEiZ4S3flHpP2OjL9WaIaM3xUDT4Oz48F8u23GJ9
         nF7aAgc8ZqlXkM7NDUMUeU9bgBH7RDRyd6AN5S9ihkG9Ea08NHNl9mE/RF3DeAyWOh7O
         ZceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759354185; x=1759958985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2LVfMkD9BUiZKUknkK9E35xkFi1qhUGUTkDbAM5Pz4=;
        b=pt687z4i+gVEC1TQgxjwmrFZdOiKu9SQk5NQArr1F+Ct++i46yFcjQhBgmPvKIeHkT
         Fed8oCjhW3j1jVtG0deiJRkM5bz34kY1SZsZ2/2t3P/QnHcKy7t2KoKcIrpFE0UDhJS1
         A1XzCZHO48F+QPsfCzwRtb9kbfWZBdRPIMrJyNn5l+iuVPXcPPF8EaLDWvb5bUzd+gIJ
         P+DTk1tDAx5wXiCHfRyhURPXaDDOm66bRnqoomOnTy3nErxwmWfdul+iR/s6Moc+aT09
         2E8ikPyUVCy3/HeHdVmOaFsIdYps0JiEp8gb2Mqv6KfANkWByKWZyyST1an3zm72B98d
         0m/w==
X-Gm-Message-State: AOJu0YzaGfg+K+LxZ35w1e0TYzttDUWKyvVoo2bpLOecrYrEwM/YCRMk
	CssOZjbXd83icByXZRLbUuyCSvgdtSVHkdoC1KY8q8HUKX1dS41715TjAdphgypb
X-Gm-Gg: ASbGncvt0+wKteIKhOeBAVJcrmkntfrYdsmrOozV0A6aQ78e7FGHaue4GzdNZTNMIzs
	FAg32qOnV2UmOZpKvECDz0TlDf9k9l4/ssvl/VFg1J09iOWi8o2FRoZhAwyUXT4xvSgb6DXU/6N
	pmV02zn0cRgLyUJNMuES1i9dsSQbY6pov1XkYUh2Chdp6Y/T9p6cptiDQMnJRrBQaaI/rYSvIcG
	FoZe1wzmzLb6taD1OuSuroJJcOQlRXciv9R2u2Gqy0KNR0vw0W5BzyWGxStc/g65popTmLyTXvy
	aMyldqhEkOYf8Im91Y5kYqGyoeWKBm0lfZ70Y/SDHTPooLH+NzTbXFw5aVSiM3FH0wwUvGqXtgJ
	YqXBJczaEslf7U+o7IymJ7+eHieQ50B9Y2Ig9IxJOfvm4QvDghuv0hoV8uUBuJYglyD9mihkLMZ
	Ni1OC7Pep06SG0KzXCUk2Nhlf18DSj62kNwh7vZ+8AmqDp
X-Google-Smtp-Source: AGHT+IG8Os8tyoMXKxS/WzQHVirviLIk4Jvb0p/CEGkdmhtw1YAJAdM8cxDYlhO21MZGCAj/IDj0Vg==
X-Received: by 2002:a05:6000:2388:b0:3e3:dc04:7e1e with SMTP id ffacd0b85a97d-425577ecae4mr3218755f8f.7.1759354185364;
        Wed, 01 Oct 2025 14:29:45 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e006ac507786c22ef92.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:6ac5:778:6c22:ef92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4bdcsm694480f8f.54.2025.10.01.14.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 14:29:44 -0700 (PDT)
Date: Wed, 1 Oct 2025 23:29:43 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>
Subject: [PATCH bpf-next v4 2/5] bpf: Reorder bpf_prog_test_run_skb
 initialization
Message-ID: <44d9a4e5bd155ccf3e2cf08a4883239432d0f4ae.1759341538.git.paul.chaignon@gmail.com>
References: <cover.1759341538.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759341538.git.paul.chaignon@gmail.com>

This patch reorders the initialization of bpf_prog_test_run_skb to
simplify the subsequent patch. Program types are checked first, followed
by the ctx init, and finally the data init. With the subsequent patch,
program types and the ctx init provide information that is used in the
data init. Thus, we need the data init to happen last.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 net/bpf/test_run.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 3a1bfe05b539..d420a657fb54 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1004,19 +1004,6 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 	if (size < ETH_HLEN)
 		return -EINVAL;
 
-	data = bpf_test_init(kattr, kattr->test.data_size_in,
-			     size, NET_SKB_PAD + NET_IP_ALIGN,
-			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
-	if (IS_ERR(ctx)) {
-		ret = PTR_ERR(ctx);
-		ctx = NULL;
-		goto out;
-	}
-
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
@@ -1032,6 +1019,19 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		break;
 	}
 
+	ctx = bpf_ctx_init(kattr, sizeof(struct __sk_buff));
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	data = bpf_test_init(kattr, kattr->test.data_size_in,
+			     size, NET_SKB_PAD + NET_IP_ALIGN,
+			     SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
+	if (IS_ERR(data)) {
+		ret = PTR_ERR(data);
+		data = NULL;
+		goto out;
+	}
+
 	sk = sk_alloc(net, AF_UNSPEC, GFP_USER, &bpf_dummy_proto, 1);
 	if (!sk) {
 		ret = -ENOMEM;
-- 
2.43.0


