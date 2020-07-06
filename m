Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F752161C9
	for <lists+bpf@lfdr.de>; Tue,  7 Jul 2020 01:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgGFXBh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Jul 2020 19:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgGFXBh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Jul 2020 19:01:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCECC061755
        for <bpf@vger.kernel.org>; Mon,  6 Jul 2020 16:01:36 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d45so21574011qte.12
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2020 16:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4MFbPpxWqiWyQiCt/Y8/V+3EAFWxMVX6naLO9kXQaiI=;
        b=Eq9NO4LyHzXl17RJbq3NY1XVlrLBiLBZOAKnJw6WmZp9W2ylG+snyE0izLxMppHOAB
         qHMBf1AKbai+aIV4405PHilpczpmnm5mj473g+qnve1KwJSriQ1rkeIviaExSO1eVByi
         0upqdV1Q/FGBWnyVtQdY5nXRA+C7Eh0ZJEvrtghcQxoDoEk98QAx44GekZ7qAXmn8VMU
         ISTsZ6j6RxCJHvuukvecyhFC6cJg2roN62dtQX64x/NBynwHV4aHAdiGfd7MpWz2COjf
         pXLTca7ISKwpLCPQQSIJPnU0qBg+x3jWjTU75J9xGrflWIsVz3wVb2LVj2+7UhTVSTpd
         II2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4MFbPpxWqiWyQiCt/Y8/V+3EAFWxMVX6naLO9kXQaiI=;
        b=q84pjSykA2ShVKLmgP6D0Ou6WVh0NHvVVMyYEQOPzTHmiwezQcN0rIFmPSFGloVHVY
         4asSLjc3zncHA8EoOvJXEgB2ESWtrsti/u3R7cVna7Gya4xciIKW38pRfOwBqbqY3rcV
         YzSX658+jexJNZhGZuQUbkpJYVr3AaGIgUjHaCvPkDLldprPOAzSpSadHkrTUZJK1Hln
         4iuIW0/cKUBnjSbgXv7HC0M0IwlTl+3tMsIssKggfFuhF+Z9ek/xDcK6kfyf2bE7MkdC
         gT6K9KhcGbAUvEc1zzHp6b1wLWHnkSGOlAFvOxVqfYyH23nAygjLy5ZVi/lVy5+5IA/3
         Jp7A==
X-Gm-Message-State: AOAM532ldrr3w1a8nmOSRSxOIr4QrdGzrhI27LGTlNneLS5C5GrY/nJe
        0wZoWk7R7BP00/+r+0rHaDMq9wM=
X-Google-Smtp-Source: ABdhPJyPmSwRU4P3JJ//cB5ksinMQOKBAYC+Opzi5hOvf9AgYRcNxPR3KMIsGd0I+Fkm3ujJi309ap0=
X-Received: by 2002:ad4:4a64:: with SMTP id cn4mr48875063qvb.199.1594076495935;
 Mon, 06 Jul 2020 16:01:35 -0700 (PDT)
Date:   Mon,  6 Jul 2020 16:01:27 -0700
In-Reply-To: <20200706230128.4073544-1-sdf@google.com>
Message-Id: <20200706230128.4073544-4-sdf@google.com>
Mime-Version: 1.0
References: <20200706230128.4073544-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v4 3/4] bpftool: add support for BPF_CGROUP_INET_SOCK_RELEASE
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support attaching to BPF_CGROUP_INET_SOCK_RELEASE and properly
display attach type upon prog dump.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/bpf/bpftool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 18e5604fe260..29f4e7611ae8 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -33,6 +33,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_CGROUP_INET_INGRESS]	= "ingress",
 	[BPF_CGROUP_INET_EGRESS]	= "egress",
 	[BPF_CGROUP_INET_SOCK_CREATE]	= "sock_create",
+	[BPF_CGROUP_INET_SOCK_RELEASE]	= "sock_release",
 	[BPF_CGROUP_SOCK_OPS]		= "sock_ops",
 	[BPF_CGROUP_DEVICE]		= "device",
 	[BPF_CGROUP_INET4_BIND]		= "bind4",
-- 
2.27.0.212.ge8ba1cc988-goog

