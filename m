Return-Path: <bpf+bounces-78219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 138B1D028F4
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 13:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B362C3063F40
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 12:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6F7396B81;
	Thu,  8 Jan 2026 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0K6bct+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FF396B83
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872248; cv=none; b=SLieDAR7FCCnQ/Mp+u/sz6nGQ4vLaCXJOVsvS0A/hHhrmPgo+sEcjP4obYQCEhQAJyTtLc9DYoOtF6vYfiYvjXQFfTtiVw7JuXsDe1e74UHIFGUfYT0Gf7YN2cL5oiHXuf/GZ6Y35SUGSZIkROAj2gzNetr9zIEN7pb5SwOY8/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872248; c=relaxed/simple;
	bh=DV84cblgSvgDHoRnGhuCakTlxXy7Np5FGsejaAsaLN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/4QUlc3N/XJDMUGmliZOycOpjG+ibmJw5TU+W0s+wkRCeaB1VQqL0f3UuvOV+FjB3USfEg3nYnrsEqv2A2PZutVIA1S9hUMH99kMy/jLFMaOtqLo1E88QTzeYsYW2Gpgw3EL3lv2AbggG6Lb/bQ6E54Ty/pTCUBeunM2EImrtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0K6bct+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so2261695e87.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 03:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767872242; x=1768477042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sUiL3ZOTvWLPoCWsXBg+OCgQvCg2mmrzNsfm9RAwNM=;
        b=P0K6bct+F8uZWGs3/ucOTgZHQz09zR6Z0diuEQeON+oGXMIUuW9B4ilU4R5k+PPh8r
         JxX92L6/GerFVLHGo3QiiSqlYteepBpqhkWnQMKGNaFvwaKxImlMoP3ylqc2+9EnM2Ij
         ebpGVKziGwtruX+VXqIsZsuaq67ScTCH0+ApSvy3tsKFTMsOkZq9KYArf0bWDDdYZX7B
         jR/J3FDvUzR7/VcztXcf5hU56hHHqH0kVV8EUr+X0CEb4lXcCYHGvJLIRwfd2PRL6ozn
         P0NA43sn/WZ+2cjeGIm+e5LgVk7Hgk5Q33pI87N79zX5HUmZy8u2oI6V5ONNkzaqTgiG
         FxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767872242; x=1768477042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sUiL3ZOTvWLPoCWsXBg+OCgQvCg2mmrzNsfm9RAwNM=;
        b=MfvoglU7IU0ajK3EtGieAZz1tiBanG/IIoWGn3kZitGLPabbWXLxQMJP0q3q0bbV7f
         9nyw6DfcEJ2khw8rqAp8O6odurwxFOKK84dUhXPDyF2hCFoVkkl194QCPmBqZELKd6DA
         9xLJVTE9QfrlWPnfxSdqOP3JTzxmihxzjOl3ZCajqdVQMXJ3o+YNxWww9JLm7hOWpbAj
         zE/w230wmHsfF704MQeb4MV4CdvAMGR1s/WzGdw4fFewn3UuCv9qrP6ERIZt/l1/huKu
         nsL62FShSSYB2chP76d2UPK1eE1kZ67ptdwxF7nVSzM/5BKyqDXAEdlMkjoeg7yPDb+1
         mOuQ==
X-Gm-Message-State: AOJu0YwcCENMwBWgHrb5ng9lZGK6qJxWd65or7X2qKUEoxwrUW7KHYU9
	/788v/UrE+FNseIQTUN8i45qw3q2jDliRIKffSUqGmDdAt36Br6Jl+W9gPKVQSEijHiYLts=
X-Gm-Gg: AY/fxX7Uzvl9UzR1PYJI/pY7VRjYCpyBqJPk7xPR/uXZOr15pnSJXgACbjh7EtFpwXL
	0h5Rfil8fUfJWXqJ22JRj/o+/yC4rmJZAnpke5/tYVQb3ymr5zYhrBPwSg/a4AZLOeGBYgBl+kx
	ooZCXF8RsPyWIMXktwrkuHnvuCekXqkbLXRrVDdiVZAETDSUmxI30+SMKNxx72I+pDepEVS8Dej
	/i0jq+aCJclTLYCV7CBieIPGWKv5qb7v8p2WtTL+UqFapgo/G1zOeFRZXWWhDe22tX3pu1bfz7S
	xzeFeX3qmIslarwPyowKXMHv3CPcHOYFkOR682Cacil7tw1o3N/2gUh1fvJQJB1JvtqSTmEXb0i
	nlaQQOfQP1iGI5egzGb65+plu5rotMRqw+WMY1QgPz6XgOSOq+YFq6PT731SK/ZtAo5gk1HfnxG
	v9eknkpIr1WPkYM9hC+QDP1D0=
X-Google-Smtp-Source: AGHT+IEcmzO+AwGZ5piiEG840jaSJfTtpAwDkNmUy4v3z1C7ZHO4DDHFVYUa20dbQ79iax4Yl5m9DA==
X-Received: by 2002:a05:6512:3f1c:b0:594:341a:ab1e with SMTP id 2adb3069b0e04-59b6f02affemr2151916e87.31.1767872241725;
        Thu, 08 Jan 2026 03:37:21 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.43.86.16])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b6cb7ed38sm1453663e87.44.2026.01.08.03.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 03:37:21 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bjorn@kernel.org,
	hawk@kernel.org,
	pabeni@redhat.com,
	magnus.karlsson@intel.com,
	daniel@iogearbox.net,
	maciej.fijalkowski@intel.com,
	kuba@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	ast@kernel.org,
	sdf@fomichev.me,
	john.fastabend@gmail.com,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH bpf] xsk: fix init race causing NPD/UAF in xsk_create()
Date: Thu,  8 Jan 2026 19:37:06 +0800
Message-ID: <20260108113706.1715-1-qikeyu2017@gmail.com>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xsk_init() registers the PF_XDP socket family before xsk_net_ops.
This exposes .create = xsk_create() to user space while per-netns
state (net->xdp.lock/list) is still uninitialized.

A task with CAP_NET_RAW can trigger this during boot/module load by
calling socket(PF_XDP/AF_XDP, SOCK_RAW, 0) concurrently with xsk_init(),
leading to NULL deref, list/lock corruption or use-after-free.

Register the pernet subsystem (and prerequisites) first and only then
sock_register() PF_XDP. Update the error unwind to match the new order.

Similar to CVE-2024-26793 (GTP init ordering bug).

Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
Signed-off-by: Kery Qi <qikeyu2017@gmail.com>
---
 net/xdp/xsk.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index f093c3453f64..63b48e4b8b65 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1922,10 +1922,6 @@ static int __init xsk_init(void)
 	if (err)
 		goto out;
 
-	err = sock_register(&xsk_family_ops);
-	if (err)
-		goto out_proto;
-
 	err = register_pernet_subsys(&xsk_net_ops);
 	if (err)
 		goto out_sk;
@@ -1942,16 +1938,20 @@ static int __init xsk_init(void)
 		goto out_unreg_notif;
 	}
 
+	err = sock_register(&xsk_family_ops);
+	if (err)
+		goto out_proto;
+
 	return 0;
 
 out_unreg_notif:
 	unregister_netdevice_notifier(&xsk_netdev_notifier);
 out_pernet:
 	unregister_pernet_subsys(&xsk_net_ops);
-out_sk:
-	sock_unregister(PF_XDP);
 out_proto:
 	proto_unregister(&xsk_proto);
+out_sk:
+	sock_unregister(PF_XDP);
 out:
 	return err;
 }
-- 
2.34.1


