Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF520A9B0
	for <lists+bpf@lfdr.de>; Fri, 26 Jun 2020 02:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZAJg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Jun 2020 20:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFZAJe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Jun 2020 20:09:34 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D12C08C5C1
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 17:09:34 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y36so5211070qvf.21
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2020 17:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ckDyJyIISt4tei12gN9FsxVUG4gEaoCFToLks0PqBtA=;
        b=KZqWNIfN2CICU1FUSqxVxLHkeSZ+p1D1kdbC+XW0/ARcYNOEa1lUIgfT4lwjMKKJVZ
         6ij9J4P4DBf/DgrSiG8EajJfReF0Rwqcsxedy5WMq2KlEx/QcLc7hnYZX54EyqZza4m6
         7LU8eDk0/VPHAyvgWQ/fzOiPE9JzmlRE9Rxva8P5R8qTGWc3XlGXQafmfAZur2zdEjE1
         zXnehX15silq71pKXHt6LP45DOBCy6pqVRB+lt0Bx/Bxs6B9VWF4SVnKGmxFbohKsWop
         yV9Bnl2UTRh6JNXvniNEU3NroMcXGMiKP5zFK2Gbpcn1Uxphlp0RFryMq/3vYUVxOji6
         Cpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ckDyJyIISt4tei12gN9FsxVUG4gEaoCFToLks0PqBtA=;
        b=jjcKAGdLVYeKmlz4c3rsscZGoTRP/k8OEHiXfyi7cZQFcQOYCwAzJmj92RrEcaQPzS
         yeb7bRxk8dFI85QQ+Di5t0dIf8ynaNLMPxvILn+q4MDkBcj3WyGJB6BLI0jbFcPCE8yz
         8F9imqAQk/atzECrxMRTKPuzq4SLy4RermS5+KT7mxGm3gn5jZAJtpleyqFwXdDg+FfD
         zaoHuk8w08CnYIF48tPea68X3S80PT13LcVALXKMCEx/jTulkIcnbmz3EqTkZq3eCV3i
         i5gB96TPBqlNayGZtGJEtO90hpTVl5J4wYsebp35ekj0qiIpg3sThWJlmozD2whlmWCZ
         btxQ==
X-Gm-Message-State: AOAM533fq9+CavPRS5F8QlqbiVv1cZ+X5/S1TbVn+81w7HfXn3F6gvUh
        l9VWDHoQ2xn3Bm+QG1fyNe0bPGA=
X-Google-Smtp-Source: ABdhPJyGLx07XsUcwKpyQcHALJqHFiP2afMYDRlMnkBWFntySvS1QYN/6UwfBLTrYP+s1IP2rYRoLqg=
X-Received: by 2002:a05:6214:10cb:: with SMTP id r11mr692728qvs.203.1593130173206;
 Thu, 25 Jun 2020 17:09:33 -0700 (PDT)
Date:   Thu, 25 Jun 2020 17:09:27 -0700
In-Reply-To: <20200626000929.217930-1-sdf@google.com>
Message-Id: <20200626000929.217930-2-sdf@google.com>
Mime-Version: 1.0
References: <20200626000929.217930-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH bpf-next 2/4] libbpf: add support for BPF_CGROUP_INET_SOCK_RELEASE
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add auto-detection for the cgroup/sock_release programs.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 1 +
 tools/lib/bpf/libbpf.c         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index c65b374a5090..d7aea1d0167a 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -226,6 +226,7 @@ enum bpf_attach_type {
 	BPF_CGROUP_INET4_GETSOCKNAME,
 	BPF_CGROUP_INET6_GETSOCKNAME,
 	BPF_XDP_DEVMAP,
+	BPF_CGROUP_INET_SOCK_RELEASE,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7f01be2b88b8..acbab6d0672d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6670,6 +6670,8 @@ static const struct bpf_sec_def section_defs[] = {
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_EGRESS),
 	BPF_APROG_COMPAT("cgroup/skb",		BPF_PROG_TYPE_CGROUP_SKB),
+	BPF_EAPROG_SEC("cgroup/sock_release",	BPF_PROG_TYPE_CGROUP_SOCK,
+						BPF_CGROUP_INET_SOCK_RELEASE),
 	BPF_APROG_SEC("cgroup/sock",		BPF_PROG_TYPE_CGROUP_SOCK,
 						BPF_CGROUP_INET_SOCK_CREATE),
 	BPF_EAPROG_SEC("cgroup/post_bind4",	BPF_PROG_TYPE_CGROUP_SOCK,
-- 
2.27.0.111.gc72c7da667-goog

