Return-Path: <bpf+bounces-21669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1C4850140
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 01:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38C01F2622D
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7F81FC8;
	Sat, 10 Feb 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZc6Cltg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C00364;
	Sat, 10 Feb 2024 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707525689; cv=none; b=TAtaqGQx7zHDwgCUnBAD7a9vy054257PsHCEgNAV/X36LVsWKHSoPexrYnckklo/InZoNj6Mi8Y7h9YGf1ape/TvUpamchKjaRYbysEZIfBOUgXidUpxaSQzTB3KiOlwMBWstwE0kmEPbGRYN05EAQKJ7rfezvuWGzUJWbNp16w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707525689; c=relaxed/simple;
	bh=vAqwinNsIRweYAwQTU+8OzNM0S5BsxFqrUIy+t1joXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Q7BD2sw+pZfVRdf3yZmB8IeiYMbuI4+KJJt7jdI/J/4x4uM7rorHEZnAG+QwHg/lb9xwezS/MxdeSHZ0VRiB21z1foyoAkHwhBGQ6wBIzNCXI5KHkGaJKgcFZe9+6M2CoVbpTvqgNEZPFVwZoJcggZe7msqciXlaEUD403KXnPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZc6Cltg; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-783f49812aeso59312085a.2;
        Fri, 09 Feb 2024 16:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707525687; x=1708130487; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GYi5cUJhfEH9ie6bHgyzrdr6/sUrpYaKvS/dt1d8zu4=;
        b=JZc6CltgdRjU6wL/RqqNSTABl3I0jCU4XeiX487DBUmS4LczXr+2oWIojSHKbue6X8
         VB6rG4YMeYw2oo+KJ4MvapbEYGnaJbHXtiEwv6iM3fZffi/d1S952QesNFspyPHwcKTl
         rJ80iKWer6H/DKxBhaugCOr49sz/CDSXIZRCgQdF2byRg4RWxl+e3f0i7Pvnc/CNzECb
         IH1dMGUu6IfS9kPfnAKQfCeiA4Lhmi+vNjWKojWWIh4UyjwwCFAwhYaoFrBDEvgnPqvy
         WksFBy5aYo9ObDBaV9W+3JzhoGk5hBJIYn0iwlEJpBd+y7F48FfT4D9V/EjpzKt58BHo
         27zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707525687; x=1708130487;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GYi5cUJhfEH9ie6bHgyzrdr6/sUrpYaKvS/dt1d8zu4=;
        b=uvUThfZQBItuHJWPXoZmmwm0OrY+U+t518bCz28c/jTeH0xJJcUi8Vz7/beUZIh/jy
         JleFsBYCEI37zLTw7zwqa6CxYay97hjhazXNPeyxfNjqitbKZrWDAjLV2PvxKh8AwqfN
         OnTF4Rz7JiC9adF/X+z/WkD2m4IcLWI7DedkbmFaqVqi8+4sCHxmVaKw2dMbDIPvVY3Q
         Ou61G0AiTnlC2E7JF+bNrjEsu0lD4Tw6e5Tp8/92rZrxxouOXLX8QrJT/bcL2JHA1m4w
         u1hr7Mt99/K8j+bhxFQ82W4jUFg/Ja6uWyiYwm4c+vPa591MVEmJi2GCUgzcdAdWixLO
         rLaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXHKHfiwKHisscB6wxE6vGA2qpcz/cg9Oz5YnTM5JLl8uL0IueCuP73pK4KvZPjNxFNNW6lfXC4/kyRibsfcIjhOrnLMp83KmknuSr
X-Gm-Message-State: AOJu0YwDQcWsY/4iyR1NHPbcc6TkuS72ZyHi+9WHCnSQydPJ8x3cuM6m
	pxqXUrtVjix0Klhrj3GThCD4TjfW0bLqktwy0oxSbvBsweXF6I4I
X-Google-Smtp-Source: AGHT+IERINpQGhlpK/moe+2wXmZhd2pBubUBcuGirC/3XVDWcB754bM9VBxrPRMkkZyxJymZiCf+ng==
X-Received: by 2002:a05:620a:4093:b0:785:8e15:ccdc with SMTP id f19-20020a05620a409300b007858e15ccdcmr943013qko.74.1707525687261;
        Fri, 09 Feb 2024 16:41:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6b8YV2VNxBPfEyXZRaybbO2Jol2jWfKYZnj4S6qrhwLMv2xTQFiSMfa3tubjrkxzEbujkHyLzXqQxdHw3wOURE+p76CcAxHKTzJveQJcOBZNeDK9E2oaRpMdpp/Ay/hTcj3g7iVYy+KVTTb49BWi9hzFTQnXPxiTxNSEi9rmn3AfNCHIoj5kwVmycslgzvnGGNCffIbGdmM0odRXwlYoADvKnP9hT6Hs7fPOuWyrLGQC6PAO0G1VR9IKc7SfMOcdmH0F2nB3C7G2JtpQBtJ8uggMqdRX1hToRI/+ho7iMO+N+6bDVO0TbmmhJTyJE5YnQXra3BESF9dPvITabsh1XjdK8rw7zJtz7rd31uO9AgLLV1pyNobcn
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id q26-20020a05620a039a00b007858ee31d67sm208368qkm.90.2024.02.09.16.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:41:24 -0800 (PST)
Date: Fri, 9 Feb 2024 14:41:22 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 bpf-next] net: remove check in __cgroup_bpf_run_filter_skb
Message-ID: <7lv62yiyvmj5a7eozv2iznglpkydkdfancgmbhiptrgvgan5sy@3fl3onchgdz3>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Originally, this patch removed a redundant check in
BPF_CGROUP_RUN_PROG_INET_EGRESS, as the check was already being done in
the function it called, __cgroup_bpf_run_filter_skb. For v2, it was
reccomended that I remove the check from __cgroup_bpf_run_filter_skb,
and add the checks to the other macro that calls that function,
BPF_CGROUP_RUN_PROG_INET_INGRESS.

To sum it up, checking that the socket exists and that it is a full
socket is now part of both macros BPF_CGROUP_RUN_PROG_INET_EGRESS and
BPF_CGROUP_RUN_PROG_INET_INGRESS, and it is no longer part of the
function they call, __cgroup_bpf_run_filter_skb.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>

v3->v4: Fixed weird merge conflict.
v2->v3: Sent to bpf-next instead of generic patch
v1->v2: Addressed feedback about where check should be removed.
---
 include/linux/bpf-cgroup.h | 5 +++--
 kernel/bpf/cgroup.c        | 3 ---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a789266feac3..d435ad8cd4f3 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -195,8 +195,9 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
 	int __ret = 0;							      \
-	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
-	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS))		      \
+	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
+	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS) && sk &&	      \
+	    sk_fullsock(sk))						      \
 		__ret = __cgroup_bpf_run_filter_skb(sk, skb,		      \
 						    CGROUP_INET_INGRESS); \
 									      \
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..644bfb39cf9d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1364,9 +1364,6 @@ int __cgroup_bpf_run_filter_skb(struct sock *sk,
 	struct cgroup *cgrp;
 	int ret;
 
-	if (!sk || !sk_fullsock(sk))
-		return 0;
-
 	if (sk->sk_family != AF_INET && sk->sk_family != AF_INET6)
 		return 0;
 
-- 
2.43.0


