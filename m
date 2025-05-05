Return-Path: <bpf+bounces-57368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 942C1AA9CEC
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 21:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C13189F46A
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 19:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84A1FFC50;
	Mon,  5 May 2025 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+KPUCFA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD74E26FA50
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746475125; cv=none; b=an4i68APs6HJC5IJAtWtNaakWPUYEhnvUC9RIjEMt9EuTj4mqNvQGETO6SWaMgcgCxL2qLg+yLs3e3m0FgoVKbbF7GTguDXD6rBVS19VrR6zqGkwVU+Fj8UJhGWmoYxXR21km+G3MTNeHM86KfThKWtfkCLQV5lbqVaQLYD4nbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746475125; c=relaxed/simple;
	bh=xMMaGjuF/rbTyo90KZng8KhE6GDErC3weBD7AZG4WlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSDsVfEsi4MDCJc7z47KaNgTOcM5dvkV9s+c/6sFUEmXOmHN+BidKfJCy354enSrlwoSektNwJXfF7ndn8Riws6+D9z3wufVNS1bhRhhZNi7zxQHxvzjzFWZxDnlqdmGMWfhEUnYJlRouFc/R0z0vakzuCl8oRJOWgMJRlfQdVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+KPUCFA; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so5882054f8f.1
        for <bpf@vger.kernel.org>; Mon, 05 May 2025 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746475122; x=1747079922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JJOT7UCUMBsbEUI9NZEDTxd5uJX8iIH83vOnSZN1Uss=;
        b=F+KPUCFAVngRAiuH5mDU9aTqE2FpyIabPsEKfxYA1Y5jDm5oY0tyyxuPbg4D0DnQZ4
         VJciK5qUUFISgLHkQy73l1GKcM5AJmDjkdIXsw1DZmhqVZGilsk3q3NtZggXo0rt4gct
         NOCAjA9d2vYJwniBJ2RB0WmjLr4iJyP5NC5II82XAaxz5Z3lArFyG2Sy3yBtVxtEzqB9
         i3xigzuu+WTqOkj0SlbidEIBmZVZOKC0VuIgBrqSmYOZoR76CM2xG9GbHAnEa9MOZJdl
         /e1SIWwhfaPgTgZGlhmgwKzar9y9q8q632wqSjraQ8qUUZeiJK9WMoH/Qklsl63RDv9z
         UpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746475122; x=1747079922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJOT7UCUMBsbEUI9NZEDTxd5uJX8iIH83vOnSZN1Uss=;
        b=sSz43glKW7y3S+j+OAKnRnA+p3SrnDv3SIXqwYQcyZwlqik3Wc2ifhsmDS7T0I0mvc
         jc52dwBGHIMBpIMrmkFPHQyonmL+hKRZbjnE19c50pF22kQjD2PNzX3d3DTspht7sLAc
         kX3CINdiMYfh7XXJsBaUc97i5tQ9sR4NEpwnHGMdF3ZmaRen4PlC/FF+uVpNoVb4aUAc
         /toOTiD8lk69p2Mz8iRIPf0AYckfdnnj9hTExACxX1aFzmG55srA9vqxv2bPtyv+qGQ5
         BSL80m830HKDRm8DReWEPacmiho96QvxJzlJKMM6y8TmjJRuaRGal9etMihLHibkgSNt
         JByw==
X-Gm-Message-State: AOJu0Yzk+yp9NdwE36NyNsHJVFm/r78zaxTj+s6JmFymNA9iRgAJiLLA
	HTR7FcNUdVCS+hXen+jE3Hq7mwu4vqEa5pihUB5idASzI3pwc86v90H61TKR
X-Gm-Gg: ASbGncuxBxUKp57DUmIg0I5dMrF/EtRfVgj3G7HZp9CiqvOfmWPYC4FAG9kC9cS2YuY
	+0jAIRYVvtMcMZXe9/Quw0isOKTr2tAy8aQarw2C++f85pKABB20zAqjJKYM/F77qD+h9DSYg2F
	Pb7X2gvLiri0iz5TFLfh+EIalAw5ypSNnDNaoPVp/V1FJbao1pSZ+g5stvrf91V8cPEGtSsxjtV
	Kjx+hz8Gm5kKYbnNwT3AL0ZTV2zYmYnnhQzdlkpT5OWQOW8n/TrKkUzDFjvKS+ZyMDFg1h7ODU3
	dZK29kwo+7Eya2D8mbnJc16/f4GaxtUp+vvzx2ylA5t0lP3yIJ8TAyjPqC9nkl4/t1tUcw7yhNI
	orBBWA9eqgOavfcRmmd4FwEcPdjFhaKjgrsqrDQ==
X-Google-Smtp-Source: AGHT+IG1As5q0qG1ggKIq6QFZ6C57oEILxYJRMtpqpSMWJOo2MUOYKFjOcpAOEFjuMr/3v4H1Zu2Yw==
X-Received: by 2002:a5d:6e89:0:b0:3a0:a19f:1117 with SMTP id ffacd0b85a97d-3a0a19f1123mr4656901f8f.44.1746475122082;
        Mon, 05 May 2025 12:58:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0001c990b81d371cc8.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:1c9:90b8:1d37:1cc8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b0ffb1sm11268879f8f.73.2025.05.05.12.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:58:41 -0700 (PDT)
Date: Mon, 5 May 2025 21:58:39 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf v2 2/2] bpf: Clarify handling of mark and tstamp by
 redirect_peer
Message-ID: <ccc86af26d43c5c0b776bcba2601b7479c0d46d0.1746460653.git.paul.chaignon@gmail.com>
References: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1728ead5e0fe45e7a6542c36bd4e3ca07a73b7d6.1746460653.git.paul.chaignon@gmail.com>

When switching network namespaces with the bpf_redirect_peer helper, the
skb->mark and skb->tstamp fields are not zeroed out like they can be on
a typical netns switch. This patch clarifies that in the helper
description.

Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
 include/uapi/linux/bpf.h       | 3 +++
 tools/include/uapi/linux/bpf.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 28705ae67784..fd404729b115 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -4968,6 +4968,9 @@ union bpf_attr {
  * 		the netns switch takes place from ingress to ingress without
  * 		going through the CPU's backlog queue.
  *
+ * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
+ * 		the netns switch.
+ *
  * 		The *flags* argument is reserved and must be 0. The helper is
  * 		currently only supported for tc BPF program types at the
  * 		ingress hook and for veth and netkit target device types. The
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 28705ae67784..fd404729b115 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -4968,6 +4968,9 @@ union bpf_attr {
  * 		the netns switch takes place from ingress to ingress without
  * 		going through the CPU's backlog queue.
  *
+ * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
+ * 		the netns switch.
+ *
  * 		The *flags* argument is reserved and must be 0. The helper is
  * 		currently only supported for tc BPF program types at the
  * 		ingress hook and for veth and netkit target device types. The
-- 
2.43.0


