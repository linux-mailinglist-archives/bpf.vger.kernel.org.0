Return-Path: <bpf+bounces-16955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08471807C52
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5AE91F219CA
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F92DF98;
	Wed,  6 Dec 2023 23:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbpoyRCv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9FA5;
	Wed,  6 Dec 2023 15:27:12 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b9ba82d8ccso266798b6e.1;
        Wed, 06 Dec 2023 15:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701905232; x=1702510032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffWkCAuB1jz2KN2wEa0hgSy4oRsATpIKRCNS/XcRoi4=;
        b=gbpoyRCvuYOivNRgV1DJivKF9VskhBJVUrVtqK1TgStSUR/x4KY1GB3DAgIZCYliMy
         ibrUa782BIwSYoC11kEXpuCr/x0BNUAw1T+kjyN4EQ94/b0POry4ggn65+aUmZ9/A9Wr
         9NI5km5BvbgIK7G1z/1eV3LnnQ4s7FwZ83mPHcwE8kMotQSgqmRFSv/tn4tQhDgFSFQn
         lECi5YsFaxRuDTOpbDXvF8ck7SLDWKFqXefqPVoWDO2yiowdgPZJv3sxYg+324agxF/Y
         5bAB0C8KhjIRW7321+yGBiWgvspqY3lHZS4bgKwHHF2wD/UgrGVRW+olibBVEK5avRb2
         y/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905232; x=1702510032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffWkCAuB1jz2KN2wEa0hgSy4oRsATpIKRCNS/XcRoi4=;
        b=cWFMkfIO3ctEIlkJTet72KsJcOZf2txQCsbIrJIkrwXLz2FkB5xNBGBFZ9119oHuyE
         ltzkujq3C5nBhoW78qGKPkDnKVUBUY1AL2Q+MPPyVol/GGG7shRnkxn5WX1PL8Yngtdd
         bS8GCjbAXRDotHqsnOPt47E6gOqHVgqQaLGUyHIMuq6vEW6RI5CVnZfbEWg+pM9BagIc
         Qdh5ysZ7Ac2EVuDuqRJNVyng1ui/npDQ/2gf/tZBAYfI7KRfhTE2WW3SgotxOQOl6AXo
         i4C/jD8EelxsiD6B1BpwTcpVmEkMZSn+0wdgE5KDQ/3XuDyu8Izaes76MAlfesRKsF6f
         2Ydw==
X-Gm-Message-State: AOJu0YwHaf0eCi9jshzkReHhHeYuTEhWas0BSpWMOwFl80oJX3EiQUxB
	DvA/yk0XckktWqLsbFQwCS0=
X-Google-Smtp-Source: AGHT+IE58PxDt3SRO7pkI09JoDZRY06U64BLiLdYIlscdEUQ6OWB9EY8Di445xvRtf3JRC8o+o6H9g==
X-Received: by 2002:a05:6808:1886:b0:3b9:db96:1074 with SMTP id bi6-20020a056808188600b003b9db961074mr577249oib.87.1701905231962;
        Wed, 06 Dec 2023 15:27:11 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ka18-20020a056a00939200b006ce91d27c72sm58545pfb.175.2023.12.06.15.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:27:10 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: kuba@kernel.org,
	jannh@google.com,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	borisp@nvidia.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net 1/2] net: tls, update curr on splice as well
Date: Wed,  6 Dec 2023 15:27:05 -0800
Message-Id: <20231206232706.374377-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231206232706.374377-1-john.fastabend@gmail.com>
References: <20231206232706.374377-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The curr pointer must also be updated on the splice similar to how
we do this for other copy types.

Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/tls/tls_sw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 316f76187962..e37b4d2e2acd 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -952,6 +952,8 @@ static int tls_sw_sendmsg_splice(struct sock *sk, struct msghdr *msg,
 		}
 
 		sk_msg_page_add(msg_pl, page, part, off);
+		msg_pl->sg.copybreak = 0;
+		msg_pl->sg.curr = msg_pl->sg.end;
 		sk_mem_charge(sk, part);
 		*copied += part;
 		try_to_copy -= part;
-- 
2.33.0


