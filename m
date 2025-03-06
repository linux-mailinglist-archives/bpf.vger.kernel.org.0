Return-Path: <bpf+bounces-53513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2595DA5593C
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 23:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371D7189A1C6
	for <lists+bpf@lfdr.de>; Thu,  6 Mar 2025 22:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094F827CB04;
	Thu,  6 Mar 2025 22:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLBPFFvV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7566B27C851;
	Thu,  6 Mar 2025 22:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298568; cv=none; b=sh4QHGjEtFgRHoPlbOi6MZU+yTaGfqYajPq5w+2ntC78kvISPAZ1pzLT4ViSs4o8kM2/dBXyhRVRElfywJtpIUiNNZEauCkbmX41nugV5RSVlgSC089161tbanzikz14QP2oogkUoghojBUFG+9BAbKasfN1DZ0kjFEa2k4Rcms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298568; c=relaxed/simple;
	bh=NZNkBAwQbsUxrtMZrOEp6ge8DpXMzhulB2bC4tpr02A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6rTk3VYoo7LpkKURYfWpi2K2ek+4W8PyXUlYdi4SXwqSU4GKOUhhcMyNMFKsBclCcEdo7nktODEUAiv4CgyLItC/JhBEZ43jaW5chcVCjCT3sblYJraR1RHGoxSqVv6UiBf8yoUejpISwy7oXu22wkZXFWwrWTr0/e9/hczZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLBPFFvV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2240b4de12bso29998185ad.2;
        Thu, 06 Mar 2025 14:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741298564; x=1741903364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mz7s+ZJoM3aBynkNWzUTB18vUlVlu4ivuZhF6UuKwc=;
        b=QLBPFFvV/u8c5nfCxM8aeZyKEaoH1f0wJ82Rwed5sSB9IhXOoiSoG14K8ctbMYJEsW
         hefmE9I0oNTmA+cJQ4+4iBLuMC5lWXjE8S2B9rXRa0vNS3EXVQhziCx+ThAnHLUAHK8n
         4UiUXgOGOMp5COlX9XZkoITF/1T53ORep4HC6jtSbIbigP1Xggkk1WbRT3gQcsEJSADH
         kBRLQt/U5kjgXHnBMUx/RnepVFN2nHTScO5fv6RKsVEc2bVi3qubgMqJHUeO44xM+88B
         9mvaDszjTm0uOKM2tNBOq1Dh8Nmkvkmu+V4OZT0NnvrFLIswHqwL+878EpQO8Ta9uibl
         wyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298564; x=1741903364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Mz7s+ZJoM3aBynkNWzUTB18vUlVlu4ivuZhF6UuKwc=;
        b=jhAS3qxpHJFJKOcumL0Q0Xbic6KoxwUgmoGfz8FvEMWLf3+BQQ+VkZQIXur3SDjRTD
         eFGdW6Q6JwTROf0QE4XnmnPClK/MzwAaFRr3zyqiaPU+80zHP8/DLYMSBarVd9dUtkBD
         aT4rLgz89lxiY05jUIB8AkDhAV6JIL50vYBV1FgDlT4rIMbdjUWFpMOszEsMaZapWok1
         z9GJzFukaAqeLEHpW76W8niVLTb1mfzO3olVgDLfs4iyCLLxykFGwaiUFh4tmSqD0KVl
         WWd2pcI9cwil2KYXv1Fb4uoT4myOwavk9Dvwkv2snTv+eeqFxZPnSFwU1eU9VUkgR3JH
         NFPg==
X-Gm-Message-State: AOJu0YxAuV1p9DGhAqBNPX5k0iGYSXE7hrIAPAQusRaydTI9QGEK4utn
	AUu+QHyHtPECFRxa82lXvyCzVf0K85sNM/IwEAHW6jm4CxluWOQIpelqmg==
X-Gm-Gg: ASbGncscVPUNrf7RWjLQ8h7TQdk3yW4FQXLZhTHCSRSzyHV72nEgHOzLtwRi7TAAUcQ
	dIy6hYwMoSNShe6CtsiTGW+RA+c74MknUDOgqAszyAsW0PN9K0N8a1yGWI+5soFr9+iuMvFl5HB
	GCKOP0gsy4eG62v0xiOJ0kXwqbrFIRxEWuesOV1ZgR9UB4zzIuSphW3O+n6Ht+f8qs9jpXhLXdy
	6JyoL3Zla1NcGP3+EyLWamOGjBaB37o2pEPYZHWjfymrtHTnAY+IyGYf06bZNXMVVP+ay4tUDcM
	3jrbeLBhS9sD+48c2UOtRth/Ddy7Fq9tnFxNsyS0Dq4vgy6cT46e2mI=
X-Google-Smtp-Source: AGHT+IG48cNgyktdjmZekwhnwNAb+P2mx1ffJ2M98h4e/N7OMPCDEs2/D5LN0U5SgKHr0T13MgUpXg==
X-Received: by 2002:a17:902:eb81:b0:224:1609:a74a with SMTP id d9443c01a7336-22428ab78eemr16616655ad.34.1741298564269;
        Thu, 06 Mar 2025 14:02:44 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddfa6sm17478775ad.33.2025.03.06.14.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 14:02:43 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	jakub@cloudflare.com,
	john.fastabend@gmail.com,
	zhoufeng.zf@bytedance.com,
	Cong Wang <cong.wang@bytedance.com>
Subject: [Patch bpf-next v2 3/4] skmsg: save some space in struct sk_psock
Date: Thu,  6 Mar 2025 14:02:04 -0800
Message-Id: <20250306220205.53753-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
References: <20250306220205.53753-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

This patch aims to save some space in struct sk_psock and prepares for
the next patch which will add more fields.

psock->eval can only have 4 possible values, make it 8-bit is
sufficient.

psock->redir_ingress is just a boolean, using 1 bit is enough.

Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 include/linux/skmsg.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index bf28ce9b5fdb..7620f170c4b1 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -85,8 +85,8 @@ struct sk_psock {
 	struct sock			*sk_redir;
 	u32				apply_bytes;
 	u32				cork_bytes;
-	u32				eval;
-	bool				redir_ingress; /* undefined if sk_redir is null */
+	u8				eval;
+	u8 				redir_ingress : 1; /* undefined if sk_redir is null */
 	struct sk_msg			*cork;
 	struct sk_psock_progs		progs;
 #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
-- 
2.34.1


