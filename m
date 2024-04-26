Return-Path: <bpf+bounces-27994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 645258B4294
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 01:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242781F22728
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F93C463;
	Fri, 26 Apr 2024 23:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YlGRMXrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AAA3B78B
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173387; cv=none; b=oeFPQEZzcj/H4fMsHLEJR1GpasEz2SKrEEqk/U08YJnTtowhjH9LU1UEyu5W4P9SVzKFwPmUBMyINSbKo+SLStcd1ZWLhaNXHRpIdHscdGBkmRd4jbH4Q1JNs0g6UqNe9/1X28RtvcItfsipwppEC5rWYr6zpo1St4V2ua4YRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173387; c=relaxed/simple;
	bh=4Qqd8JwEjPySj3HwDqz7sWAvOHtJzeDDUNVyCwWcnE4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a79zVKycMNg13R/KFklq61NZADU+47JhRLjBkmmHqrg5Ok+lIBrhYEQvzPKIWVUiYKovEIz83CWErkJWsDvwi3fr71CEqFOxgR9nyNt2taa373aVvsuRxt5wJQNfUzrVV1VHJUT9k1qcOBzsqS++apr64QJ9rwiJjg956JAlC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YlGRMXrl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6167463c60cso31398577b3.1
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714173385; x=1714778185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6THD+vyoriOh5CJBKICwH66WGUIvDpFL35bEBRuig=;
        b=YlGRMXrlYvmyfMBXyEzrxqTSp9QXgZfemVuJPG38+gqMBXPXD/xt8lHMYgmqHbfFaG
         pY0Ya8BvcUuMcHyeFy1A2Bwu3wuXxao6m+DqxLeOZa75O/DnJZ45htwPxEGj0Vjt+g5F
         kv3KvdxPY22UHqXy32DSLxYVVBYOvsOfMAuTdK43iG0G6bihqs9XWSGaBi/XbOOGf11C
         y4jgKe2Z2GTz3JbrtKc3IFBNGyKt+MyFioTlrar4jmhWFzPGSn8tbkCJHiQ7WHkxpAOW
         p9Eoe14f7/nhv+2mbUXktxE/rSDawrQmDWb0blg59b4XdCjpkw9bj6D8Xm3Hn7VV0JUq
         FUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173385; x=1714778185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DK6THD+vyoriOh5CJBKICwH66WGUIvDpFL35bEBRuig=;
        b=owdkGLnSCswIZ6REw8PMvmeeKzJNHNACzCsk1ruM2/BAGgymU4ypy29czI/6rLAZUI
         lALklAzsNhdEN1t2eUue482w2GjUU+RSScHCgeJ9cib687uKxc3STcFZ35A4iAzom15q
         FwHOQRDApfodYLM2LchMkiJDGhJZdpiL+XWaDBdgmUehnDi3ZXg4oekrwDtf/mYIfsP8
         F6plPEbtYZnXzw4GyjdAOFoHNauv1XYagMZGCqHz46f3X3RINLrLEnbAbtQ9uwkAnrKe
         10wOBasR7iJGqrCI/8SB43sXglMJFspaJ60jKt18iQexqLiuGWLM8u7U5qxgKG8l4FUx
         XxTQ==
X-Gm-Message-State: AOJu0Ywi5Yty15+oMW1IB8hySVy4xIpIqSnN7ggYsNmGYT54RUPdmqQt
	p9Jjt4+qNrZfAkB+HZaP9Qui37ixQY6/S+LqeU4VA+SiIC2qwKtOLNwfT7gvpX/pYqLD7S4oJGR
	ZUMA4URLSgG0Pd12qL4+2fvAHtMTvwowlDGAz1ZLfyY0AJkvLBJPknEw7deYVOsgQZiocziSLiY
	tb7T6SQ1lT/K4q
X-Google-Smtp-Source: AGHT+IH3BVfF3g96jN9u0G0SP1OivHgL+ixqAxgGZebYhsNCd0ainZZ2bnrIxHUju3h6EUXev9TyBaM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a0d:ca47:0:b0:611:5a9d:bb0e with SMTP id
 m68-20020a0dca47000000b006115a9dbb0emr277747ywd.4.1714173384994; Fri, 26 Apr
 2024 16:16:24 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:16:18 -0700
In-Reply-To: <20240426231621.2716876-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426231621.2716876-1-sdf@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426231621.2716876-2-sdf@google.com>
Subject: [PATCH bpf 1/3] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	syzbot+838346b979830606c854@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

bpf_prog_attach uses attach_type_to_prog_type to enforce proper
attach type for BPF_PROG_TYPE_CGROUP_SKB. link_create uses
bpf_prog_get and relies on bpf_prog_attach_check_attach_type
to properly verify prog_type <> attach_type association.

Add missing attach_type enforcement for the link_create case.
Otherwise, it's currently possible to attach cgroup_skb prog
types to other cgroup hooks.

Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
Link: https://lore.kernel.org/bpf/0000000000004792a90615a1dde0@google.com/
Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/syscall.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c287925471f6..cb61d8880dbe 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3985,6 +3985,11 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 			 * check permissions at attach time.
 			 */
 			return -EPERM;
+
+		ptype = attach_type_to_prog_type(attach_type);
+		if (prog->type != ptype)
+			return -EINVAL;
+
 		return prog->enforce_expected_attach_type &&
 			prog->expected_attach_type != attach_type ?
 			-EINVAL : 0;
-- 
2.44.0.769.g3c40516874-goog


