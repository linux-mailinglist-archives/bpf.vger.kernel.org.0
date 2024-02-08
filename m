Return-Path: <bpf+bounces-21558-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 273DB84EBE5
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC349B2155C
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6E35025A;
	Thu,  8 Feb 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgBNulay"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FFF50256;
	Thu,  8 Feb 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432623; cv=none; b=PEMBB5qAVUQINRX9DWGmy/iUMmDPPES/5h77UzTuz9ay2J9xpAHyow1qhB+NvOmMZotOlYvJMp3LKwqFvw8U14q/R/WQeOA3R6sI1USe0EvRxCnV/dU639C6DD8t85TVrEl1a89sV7+BMNRgkMC80rFFQbeIUKEl6rrX6FKAQ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432623; c=relaxed/simple;
	bh=QQbWm1vnzLUS1txRr9hch/TyTh+VOwAmW8Axv2tX8O8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YcMCp/jlSLdQ8TR/nGHiMu5yezQPDnymWVi2nb4SMCv6/jkvLMLVsKzL9CiGs4ynev/gUVBsc0Maj3rey6Y8+1BSv+uaQrvPhX1I7QzOoJIVGCLJa1ueOFl794jTrPiGT0XPxipPtqr6oJ/2oQoWXXUY1zo0/0YWoELfUbO6lrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgBNulay; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bfeb155d31so144132b6e.1;
        Thu, 08 Feb 2024 14:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707432620; x=1708037420; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGoqD8TT68ixzRNm3vNixXDLMpdkKEucKJo6ktMulao=;
        b=BgBNulay1MXMfxpqEYVvKTuArU58i7RXPInBmj5ZkrsFnzBdvx4eSJCACHSsm3m01M
         lLfOPwtqP5yp1MXmLcQ3V2uBsgaxm9qR5MMiI+38ZENrg7yXs2HnQS17fbAom7a8DMeV
         hUW5CvsHUZSO3iNVzzs0uGyMEZFHRmuT2LLbJhG/+o7gTI2omc/Eps9Sx+X8tBb3VAkm
         t8Do2h/ziUOoAv9/GvbywmCPJ/V+H4Zl1mW5qyWGWSEjuqkGdkCShELnYeT4hIMxsY5D
         ivPO23GJUou+w9EOXGME75XT7MF/JcNlYLKAUvt3A/m2sYEHeyXYFzuHdF9BWNbBK66k
         05oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707432620; x=1708037420;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGoqD8TT68ixzRNm3vNixXDLMpdkKEucKJo6ktMulao=;
        b=QAPdCyQc0Tf5eQvdLa2UaFcXY85rpBAykkZYzA9hy0haWjfkqfGgwdU/NkaYBR4p/b
         Acr0C+dlFgTeHLEeqTOeiViH1Rj7VDn9jwL10eRYCue+aS5TiWRBuIY93cmrDyZ2o9KU
         EyVXvISBsdWI1TXVLApdXvGGNiSoKfHrAvkOQyzcv9dat/uXCywaUPlvb7T2qrm3+W+w
         6uWShJuUj2pGb+fUs1V7/gTh7kyiKb2VV51aOriY3FLpTdmXI3E28fHrGhkotlarNACk
         oaaF7DZjBGO2YRR49ufKi7X0Ql13vZB7JYKr94Fol8PtOponSlmDqfgee/TkRD2bfqtp
         fy4A==
X-Gm-Message-State: AOJu0Yz381/sl2dEE5wgDPX0LWnS552G8JZGj1LTCCci6T7IruX6RfJP
	DJMNIskxZ9+Ii9AGpo+5mhesBNCXcHK28cR9xi59pQk6GIGFIZWY
X-Google-Smtp-Source: AGHT+IERRUQ4GDpJ49o40yXi6V2s2n9mKovBi13RS4qwlL6Kk00nSycdLPKOBYqEZOIxw7iA9TiRMQ==
X-Received: by 2002:a05:6808:99a:b0:3bd:ca59:8f4 with SMTP id a26-20020a056808099a00b003bdca5908f4mr916041oic.33.1707432620697;
        Thu, 08 Feb 2024 14:50:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrdk7DGYjpSsbeF/CgHLCOVICu4qBMhDjjrKtVyldYxtifcOf07d0ouGzEjpLXZ5mVm6b8OoijaNmq/HpEx5rG3bzdDTCuOU8vUh9qWs0XkgRw+waz+bGhJAwsKpp42NKCfI+ngQlscsrpBrLHSzJ2vLhwLQnKlFbuY+/ZMknZ1lz/pcv8+FvxrVDqvgTY97EKCDc+EyQQXyAnK61fIEoDb7kuoH4RPwrodzx9kG/7Ao3tIR+cpEdPPXpB+qt+3xP8p96jB5BQiWEa0tztZE9swmqRsG67+MRscBVLrxCkXFspkOjdB1Dx/N1V3DbBEtpXMd7xIrELRbycb7r0ickyjQ4J0ZkZTwzDNKeP/VADxmtA9cbi7I8k
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84b42000000b0042c3bb838cdsm173488qts.90.2024.02.08.14.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 14:50:20 -0800 (PST)
Date: Thu, 8 Feb 2024 12:50:18 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: remove check before __cgroup_bpf_run_filter_skb
Message-ID: <ngc7klapduckb67tsymb3blu2wlmdsjo4pa4gbaivgxezbwzxp@v7akqu7gbwl4>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Checking if __sk is a full socket in macro 
BPF_CGROUP_RUN_PROG_INET_EGRESS is redundant, as the same check is 
done in function __cgroup_bpf_run_filter_skb, called as part of the 
macro.

Signed-off-by: Oliver Crumrine <ozlinuxc@gmail.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a789266feac3..95b4a4715d60 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -208,7 +208,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 	int __ret = 0;							       \
 	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
-		if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) &&	       \
+		if (__sk == skb_to_full_sk(skb) &&			       \
 		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
 			__ret = __cgroup_bpf_run_filter_skb(__sk, skb,	       \
 						      CGROUP_INET_EGRESS); \
-- 
2.43.0


