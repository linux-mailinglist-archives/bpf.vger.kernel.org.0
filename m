Return-Path: <bpf+bounces-78216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2607FD02A2F
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 13:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46D3F3360D8D
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 12:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA94D4A15BD;
	Thu,  8 Jan 2026 10:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN20REZw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A64A33E6
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767869745; cv=none; b=Rn6HQ6p+Gd44UgdPKwxh7nhsETFC91rqLqAuvSN+vcpw6LmTCIsN1qujL+2JhR6U/2cOjsDMzWbge65bec96a1p+gQEOkkilRn3NcNzxZUUg2Is6py2u5SVtVcJ73wrQ6TwR0QytePPv5GUXDEAln6Dv+NpdIH7oTW6AG09NVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767869745; c=relaxed/simple;
	bh=DV84cblgSvgDHoRnGhuCakTlxXy7Np5FGsejaAsaLN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bJD8WYgG6sKGETcFyamq6ruIiocKc9gNQP8KnsbGZ0xzaFsD5DU85Zv7kNQuZ8hxWSCE1GmL2sEGWv9l8wtOk3+BaueNBcpXd/BYkT67KVW93NVVWcb6cej9HsvuTNsd6AVLJlgfef3Ej89vAjaqyDmJ3M0wHhk8OsxTF2EL8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN20REZw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-37ba5af5951so28174651fa.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 02:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767869733; x=1768474533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5sUiL3ZOTvWLPoCWsXBg+OCgQvCg2mmrzNsfm9RAwNM=;
        b=WN20REZwAJr7M4l5nFRbuZT/zoj35rBBWPeeTKIVnr8L9yL2dwkH5VUeGh91uMMhoo
         wsZeDnx79TA7NxISu+bXrI9VNwbAYrrg5ms3CGJbRXK/om1lMhg6Q6aAsY69zjF2GILk
         HWD2WkQjIsi4bsPJqEkME/hYOSHJGIoJ68MdNowEJ/Dyxw6jFg+Q0Cm8aMvcrdxkbDsh
         Jg4pfUaYGVyOh+CpYUIx6EmPMfMx1Yk1jALrZaLinE9LPiaF2m2inMVcbIK5cf9Um2Pn
         aJvMn79Fb7+6y8y/bjQ4Clmp9/V89z31SyCPzFcqhyk3X9I/Jf6xxueUF0a9O6BhKabO
         k6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767869733; x=1768474533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sUiL3ZOTvWLPoCWsXBg+OCgQvCg2mmrzNsfm9RAwNM=;
        b=vcUKyafWkQBOy8w01vSl8MwHz3CCKyhsjF61qFSHWMITY966xjJuqQ5KXDfPy10m+g
         vTymxLYxdOioceqT/yaxIQ1MNY05zhOaYfclb6rdt1ODX0XcudLdOLaUoK3JtrmzweLc
         O/R4im4tDlCs8ans/mZPGeC+KW2HksnQUDMtnGeUT7cjsvhFKWwwVYuintj9JiVo3NWq
         Zi8tl0pfFIbaCuIAd8anT+0RFKb94gKkZDOHJN7TcglpO1F04hNb23numyI6TcnHG7pG
         S9Hglg9bXV7fY8JuTBKcCWlX52th5yUdLzC9OCjYn+JuAwj+5415tn3L5Snf3gKrLrhh
         MKnA==
X-Gm-Message-State: AOJu0YwkOK85+nOS4tedevb9NpT/D9+wUw6RigUwbSJQqKFthkhuVqZp
	ZlclVqtjnqUd6VEPTiPC4U4JEiXKSKmc5FjlvTgwyuuCii1ObYu3p4jzVkr3yN6Z/eu3xcU=
X-Gm-Gg: AY/fxX5msrMxgbK33TD/Rzhu0zuONKWL02auClFAD3XTLK0/s7xAVrsudNTU2HXUReE
	PzM/VZ0tjbg8sT4S1uKCbYB6RT2y+AflltzOXC0hU1gK2Zp4xAXwQvQb+LEAZM2YoTijq+pEGjb
	UodPglOo+yZPHzDbOrkJieWPHakAs4g44mGUPCfUYGRh2FYkuIYh/C5kq9l2Rp1pFazpoEzvpzC
	eOuj4jTi7bBi+VWQ3rCKUJU6xtXaGBk8DdCLwrR8/4m7+ZxsPWzFG7fdiNnQ56f/MKM2lM6iyi3
	SHNfP68b2hYxWmwaGnuJGWYQSAmSiRmxHNZJHNvbrkqd98h+gIHWc3JKkWBFqNPqjKX09DWkIVq
	ky3Wis2+p16MHuU6MnV9bd35u/AwxfdHtBZWNk0+VO//8wRGZbuC67XKuklA5WMDZJixzQqCm9L
	XI+kPa/PWMstKX
X-Google-Smtp-Source: AGHT+IE10WeHaFif4GLS1V4eLQCMtBm97EubYvN3+uEqsnenwr1ztGbx5UM3ZPRSVXYnX6mtXhRVqA==
X-Received: by 2002:a05:651c:31ce:b0:36d:4996:1c26 with SMTP id 38308e7fff4ca-382ff678f41mr15546491fa.11.1767869732381;
        Thu, 08 Jan 2026 02:55:32 -0800 (PST)
Received: from DESKTOP-BKIPFGN ([45.43.86.16])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-382fc959db1sm10044751fa.2.2026.01.08.02.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:55:31 -0800 (PST)
From: Kery Qi <qikeyu2017@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kery Qi <qikeyu2017@gmail.com>
Subject: [PATCH bpf] xsk: fix init race causing NPD/UAF in xsk_create()
Date: Thu,  8 Jan 2026 18:53:44 +0800
Message-ID: <20260108105343.1694-2-qikeyu2017@gmail.com>
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


