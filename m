Return-Path: <bpf+bounces-21665-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6138500C9
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 00:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E48C28A5BD
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 23:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEF738DDD;
	Fri,  9 Feb 2024 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f31EX3KP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DC124214;
	Fri,  9 Feb 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707521767; cv=none; b=nL8TORBxotQiZ/CgG5fATmgBLzOokmGI1xa2GYil2Xq1eIeEHsj8D1IC9CfIuho+173vr1KWmmKVIZgUTMj077MSz/RzeuUU7l4NtS2BT8aYi8s0PNy37lzuGHn0Qu+nf16fO1GVe9Q6g2YOlAF/TzfCmfFpugIgKi6OggZa0qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707521767; c=relaxed/simple;
	bh=Y/PUlg7pZqISBcOisWGlla14uXigrMdXCUUHoiyywQk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WBisvNL7l1vcFfbgSLGpp+R3ba7o2gY4bUQzzkxPM4EeCBhZj70Wwu3xacT46CE5SF2p56voDYKmCYVSfrm/NGrSMwDyZ71v4LvxVnGCl5KiocJCta5E5slyOSjOYyMbzR7xq5PtfcfyYXKG273gpJ51oHGSynZEQRoGYtoyh+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f31EX3KP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7857947b179so108504185a.3;
        Fri, 09 Feb 2024 15:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707521761; x=1708126561; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=arz5YfjQN+baeIdblLJ/rOWjM410EatO+A9RTDsoWLc=;
        b=f31EX3KP7fZOs0RdxXKTt7jJd0UcNpzIuHbwbQM+IGQoc2pPPft5DyrVIXcTUl+7EH
         bHb1IB7mVENagFvNX9INwT1t0GJYrgDOvDDPHSW7hAC0yWvY9k2lKuCFpLLcLGZzp2s0
         63IgS+TnKaE1g06E39tIHMOTQERDRr1wNND3t6eZ8W+ZsIBMujhDkQpCzPkq1gSgjWlX
         cLZEqc0iT+Se/H3d2aiEXrGyScQaftz8H7ytcxFkq8KKBD9+csn0Q6puOPZP7YvmprLs
         YLD50gjptvUizv0Ohe8LYgJ25VqEeJVbA8dfij/Hv10BrCmv0NLgfEAHU4axuw9fUOH3
         1H0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707521761; x=1708126561;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=arz5YfjQN+baeIdblLJ/rOWjM410EatO+A9RTDsoWLc=;
        b=UJipRJBpJJyCuRrVeqk4fXNcNYJ27/YDY0bhlMwFUwPX/fwk9jglah0vU3SC8lDOGj
         EKIYg6e2bJYP574jolmKmWRNw+qWk0kVgRlPXrpFCOJXcni0quunmUkfpR9ys/u98mTj
         Lmk40agq2D4XEQoB7qinCViXLXNlcEJk/UDg9peYZiSSrqlrRxuHADdNevvbt0r/j0TO
         h+yISb0XQQwt4s7Bh6uF6PU/OXYZ4VLGLRV5lWiQnrYhV1m+jNFhN6ZKFlCbOiuoOLYC
         wdMYV+iu+58tK+6viIBIVM8VZckUtU8VX4+aWha4eebl6VhJuy2D86fOl9dXoF1mTab+
         ihkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKePodYQy/8xjCbHNebAu+Z7S3YMnANpUreDDWBm7qplvHals9Va6sQHV1dZuYG1Mex00lJivR7LYAupyM0d5a61iLwJsgQW7qV3E/
X-Gm-Message-State: AOJu0YyuH0pw2YQFMx02LHbqPjQhhdkihY90mX7xd56wVrpAdB9/6w7d
	/FKnAgDdlTangpWlBrxl1O3ChnmTkmj3ZYyxiMnn9Degup82RM68
X-Google-Smtp-Source: AGHT+IFMBXPvvmwxivkWBaipFYGGBUS/B2fifZvtWXzXWPTBEVsnMOxMJ+Ho3MP/iRp1cTX2GLgfog==
X-Received: by 2002:a05:6214:240d:b0:68c:cd5e:62b6 with SMTP id fv13-20020a056214240d00b0068ccd5e62b6mr848886qvb.62.1707521761454;
        Fri, 09 Feb 2024 15:36:01 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWrC6YEoYYAlJJSTeQmcS1U41dGJfDlUBhacrm5fwAIFpIgVziVMa7WqGHJTEwjC3qb6uS1z12PPl8DD9hMgNC+JZc5WOsbiXaP62Ar7Sn0/LLrVzHno4H72OmqAkisAuGV9QAqDS8uPFJgBpKWXtjYhEMKDjKse5z8AEan6rHGQaqHb1iSkZY8S/lz/qxGTmCdem1awrBf8UVLRsJTHgl7acjq6ZtnoFNqceCrlE/PeF8IiqUmNlGcoPu558bKazwfup5sWS9dmQONJkWVSQq2ujEmE9zTMHMfunkgAQKyMrLicazNkzI2u8ZkyyByz2grceJBwdNhTOIINr7ozIeIKOFC2SYXJXsXwgQGjlSd/dS1u+YSYVMs
Received: from localhost ([2601:8c:502:14f0:acdd:1182:de4a:7f88])
        by smtp.gmail.com with ESMTPSA id oi10-20020a05621443ca00b0068ce676eb4dsm75153qvb.69.2024.02.09.15.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 15:36:01 -0800 (PST)
Date: Fri, 9 Feb 2024 13:35:59 -0500
From: Oliver Crumrine <ozlinuxc@gmail.com>
To: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 bpf-next] net: remove check in __cgroup_bpf_run_filter_skb
Message-ID: <5ac3e6uwvhdujq6tywb6b5bh5flqln6d7kedmcbvhyp55jp4yo@65pnej6e2ub6>
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

v2->v3: Sent to bpf-next instead of generic patch
v1->v2: Addressed feedback about where check should be removed.
---
 include/linux/bpf-cgroup.h | 7 ++++---
 kernel/bpf/cgroup.c        | 3 ---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a789266feac3..b28dc0ff4218 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -195,10 +195,11 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_INGRESS(sk, skb)			      \
 ({									      \
 	int __ret = 0;							      \
-	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
-	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS))		      \
+	if (cgroup_bpf_enabled(CGROUP_INET_INGRESS) &&			      \
+	    cgroup_bpf_sock_enabled(sk, CGROUP_INET_INGRESS) && sk &&	      \
+	    sk_fullsock(sk))						      \
 		__ret = __cgroup_bpf_run_filter_skb(sk, skb,		      \
-						    CGROUP_INET_INGRESS);     \
+						    CGROUP_INET_INGRESS);     \
 									      \
 	__ret;								      \
 })
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


