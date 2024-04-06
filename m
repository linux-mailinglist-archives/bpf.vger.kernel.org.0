Return-Path: <bpf+bounces-26087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16FA89AB96
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 17:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF0D1F2193F
	for <lists+bpf@lfdr.de>; Sat,  6 Apr 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3488D39FE0;
	Sat,  6 Apr 2024 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="WDRTBFYx"
X-Original-To: bpf@vger.kernel.org
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941FC376E0;
	Sat,  6 Apr 2024 15:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712416574; cv=none; b=tvK0PashjhNBBHi1QkXLVj3ByQsJg3zjTn7nRhpxwGWQl/P+/gG1PhNvzrgGRvzMfCC1zIvJTEBhr3BaBvRZv/R5f02GOiEvxE7QWn7vEZhzBx8au+5cPJJ5Xi75xnZ6I4GsCrLQAFC+zZnCPhlhqBhFHrGxli+fBSp8xKzWb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712416574; c=relaxed/simple;
	bh=AjC9VPGBDKa+qIIk5rpRw8XzGhdO0n+wLvwpBvsUocg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m9bjfzETLr6Ok37kcW6ZSD7K9fWN27zOz6w/eT4DZWAeKlnRYGGtcpc7xfJ3v+Z9lYJ34WQUHsOkc8geWcEFKYMjAwAg1kOPZWuARu3EqboAQ8N//1SC2185h/J5AeDY7pcnmotLlJr8TeeChnq1tCIAaAGsEvpAxQBWy4FoEqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=WDRTBFYx; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 93FBAEF2DB4FB;
	Sat,  6 Apr 2024 18:15:59 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id SecWJ8moq5Pd; Sat,  6 Apr 2024 18:15:59 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 5EF1FEF2DB4FE;
	Sat,  6 Apr 2024 18:15:59 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 5EF1FEF2DB4FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1712416559;
	bh=t7XFvKjb/fmLNl9bggienWjZmjBucE0mCAmH+77OYak=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=WDRTBFYx3OPElQXj++OVzjp2iKo+06Th6kiMz1ASk7wYQ5XmEBVFGLBFZf7JBmMau
	 VeVUUKlvJihsM+usuDUGFren83CF44GINJPM9kGJDHH/DhcrAP0oSmmI+KwQ4jCQ4b
	 MO80/MHOMSSAHYTrNTm5zx54TVK5PcwS30WNxg3zqGtuvD2CjdbW0s08Id74Nd8wU+
	 DTx7LLrvDNUVc2RJkMqvL0JvthZ2nX2zYzsiRQQ3kIswOkYz91j573fhsn8aRLC1ti
	 4BnJL+HSEiYLXwWsP84dds+3JsIPmc5mRBChOiNSIMz6MEzeINwbVqgyeRdXLTnIJJ
	 AG2ScTJaIVagQ==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zsqipvTHXt3j; Sat,  6 Apr 2024 18:15:59 +0300 (MSK)
Received: from localhost.localdomain (unknown [213.87.161.43])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 8B6F9EF2DB4FB;
	Sat,  6 Apr 2024 18:15:58 +0300 (MSK)
From: Mikhail Lobanov <m.lobanov@rosalinux.ru>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] bpf: dereference of null in __cgroup_bpf_query() function
Date: Sat,  6 Apr 2024 11:14:55 -0400
Message-ID: <20240406151457.4774-1-m.lobanov@rosalinux.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In the __cgroup_bpf_query() function, it is possible to dereference
the null pointer in the line id =3D prog->aux->id; since there is no
check for a non-zero value of the variable prog.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program at=
tachment")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
---
 kernel/bpf/cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..7f2db96f0c6a 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1092,6 +1092,8 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, =
const union bpf_attr *attr,
 			i =3D 0;
 			hlist_for_each_entry(pl, progs, node) {
 				prog =3D prog_list_prog(pl);
+               	       	if (!prog_list_prog(pl))
+				continue;
 				id =3D prog->aux->id;
 				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
 					return -EFAULT;
--=20
2.43.0


