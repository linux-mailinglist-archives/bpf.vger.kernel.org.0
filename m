Return-Path: <bpf+bounces-21308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBC784B5C8
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 13:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B1028A439
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9057912FF6E;
	Tue,  6 Feb 2024 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icXsdY+L"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E4B12DDBF
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707224378; cv=none; b=kNWoOuM0X9bqC/PASdJlUTK4dTtPDwM/J67sbkZjkLj5ui2hBlyM+dQXqUBNnpDk1UsdGR4gip7zBYQLO4tUc53Ku3wtpmsxPnwJCFi47mUdf6odnW0EKPc2RudWJJTiM8sV/XJGdOeXNJIJIX6XLczFYdNPvoI7QJcAeL59aXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707224378; c=relaxed/simple;
	bh=mvFSpXXF9JUEZ5uG5sEHCsvv939PdP+Ga4W1lHDw54A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RNvpABAZXwC5owiG4QrkCWj57FAUoj3W7Kl1/JOFD9Kh0r6dy/MQycocfPmKMqTAa8HNOLHl8WkRqatD8eU1Q2gAzhMFCa4voFSZbnVGwqq6+0uA41AWa0pGWTp7929W9xTEDg8Oi7/z+svrVfdTtXSrRMaXQfTR+XuOEOh4esM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=icXsdY+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707224375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JvGpRWpuy0T9OWLbJZcnUxTccocCFW2YPrwN0a6SYek=;
	b=icXsdY+L116VKOpe4soqQuwxhM/hk7QK76WLKgZI5t5MaL7GdVI8AVo2nfxTolOQNPBcZC
	OBcSzKUXyacimMxszQwYpEO7hPbMF8EwgtluRJQvLTBPfWlQihdl2D1z8Y6y1Ldf4csgP3
	7R0CURo5KHP83k5DVCxAecoUilHZnUc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-2SRs7SfJN7qPEIIizSQlxQ-1; Tue, 06 Feb 2024 07:59:34 -0500
X-MC-Unique: 2SRs7SfJN7qPEIIizSQlxQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55fbf844bacso2691949a12.1
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 04:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707224372; x=1707829172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JvGpRWpuy0T9OWLbJZcnUxTccocCFW2YPrwN0a6SYek=;
        b=pji5XQGPeFjBLt620lq+AoWdXrMeYwd3CoHAiV2w+8zpxPe63kskZ4Hy41cRtelJ75
         EvTm+tZyvQ4xMSVcxFVJUJA9AbQdAG3h3yXVtacb+p2iAeOyRsyEfJNmTwfby1Yf7KLM
         x38jIGJGl9PBn7vnjnJ22f4KKdMBRQ/QdZDmB3VbqE6q+E5Zc1UKnGim/i7eY4tK/Seh
         CMyNv1eHOai2hrUuAxVbC9wxFQlXeqKYeJTwmuq1kHWjzjT7cHTg0b3i3SbQhbBfZY8L
         9zMf1u794fXXIrXHVQHM16eNnfTbmEvEYP9RzVP+y0QUbcNPuPiI1z9Vmw4XcevQP1d7
         bXZw==
X-Gm-Message-State: AOJu0YwXfc8AFPn1z5VsNSV7i0ImdfIyGMrBFY313T/9fvCjXBFl2zkJ
	YeiYYnX7GAoeimqiZyQInkSXxXfZKhBeAWenjOs5bvqAXk2/YfawSOkePn/XTkhHG0uuE2UAmTE
	tiuDmHC8R3eh3dVPzabZWN5FuANTQxV1wWmlH15Je+Khz5OKXhw==
X-Received: by 2002:a05:6402:893:b0:55f:d60a:b1ac with SMTP id e19-20020a056402089300b0055fd60ab1acmr1620035edy.16.1707224372465;
        Tue, 06 Feb 2024 04:59:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGefh/h3pitp7txo3hSq2AXC2MPwo9tn8Ukfdo51TLjWJHf2Q+ALIco8XrRXNqKF/AGdCKELg==
X-Received: by 2002:a05:6402:893:b0:55f:d60a:b1ac with SMTP id e19-20020a056402089300b0055fd60ab1acmr1620001edy.16.1707224372099;
        Tue, 06 Feb 2024 04:59:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVR1zOr0ILdgvtBzUNXS3O4pO5CPZZQFGEDqXe2HsUTFnz+bwi1JHvEvanAHyjc6YvE3J3pphIG15fNPDMtZZVSm5pVCDjxixd3qpyCfD8rWkoZt1/2qiwqNSKObW8/q8DQTK8EFpn27xTW8RwXTH80DQ3hm4jjPs+OYeokW5g0rmkvFJo2kVXqVNu1g9ryGLv+eXEF22CvWWKHb2gAKblFfe1iqfuP1j5VOqUVx9h0qxtAyFGr/akG9WXsxeU0cwkhvm8qDevN2HtImMVYVvBu9jyHyeXo7e6hdXMJILhnjxhXaIvT2JEBKE2eRxfCGLyhh1ZC+EuRYDT2lbrw+b55n5+PAq/7lG6FEG2K/nUmro3R4CbCHUBpWAMydYvKx2IG8bNOvVAJFZW5MLMxHVGp+dm9c1yHLfIvCE5U+kU2+tBk2o3XcA+f6Blg3Fu94zCx5aFnPlRyW9nCjDN5ExpkbnFHG5T6ZPLj5b44T5uX/fA/KT40G4m82SU1cUgQFnabH79UtAkkx/gZqIrweUQ=
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id cf10-20020a0564020b8a00b005607f899175sm997772edb.70.2024.02.06.04.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 04:59:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 50269108AFBD; Tue,  6 Feb 2024 13:59:31 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Use OPTS_SET() macro in bpf_xdp_query()
Date: Tue,  6 Feb 2024 13:59:22 +0100
Message-ID: <20240206125922.1992815-1-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When the feature_flags and xdp_zc_max_segs fields were added to the libbpf
bpf_xdp_query_opts, the code writing them did not use the OPTS_SET() macro.
This causes libbpf to write to those fields unconditionally, which means
that programs compiled against an older version of libbpf (with a smaller
size of the bpf_xdp_query_opts struct) will have its stack corrupted by
libbpf writing out of bounds.

The patch adding the feature_flags field has an early bail out if the
feature_flags field is not part of the opts struct (via the OPTS_HAS)
macro, but the patch adding xdp_zc_max_segs does not. For consistency, this
fix just changes the assignments to both fields to use the OPTS_SET()
macro.

Fixes: 13ce2daa259a ("xsk: add new netlink attribute dedicated for ZC max frags")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 090bcf6e3b3d..68a2def17175 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -496,8 +496,8 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
 	if (err)
 		return libbpf_err(err);
 
-	opts->feature_flags = md.flags;
-	opts->xdp_zc_max_segs = md.xdp_zc_max_segs;
+	OPTS_SET(opts, feature_flags, md.flags);
+	OPTS_SET(opts, xdp_zc_max_segs, md.xdp_zc_max_segs);
 
 skip_feature_flags:
 	return 0;
-- 
2.43.0


