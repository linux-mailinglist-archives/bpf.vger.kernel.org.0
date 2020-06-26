Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBAB20B64B
	for <lists+bpf@lfdr.de>; Fri, 26 Jun 2020 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgFZQwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jun 2020 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727972AbgFZQwi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jun 2020 12:52:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBD0C03E979
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 09:52:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z7so10407460ybz.1
        for <bpf@vger.kernel.org>; Fri, 26 Jun 2020 09:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f6Da7523rX1uWkEPLzRoAH+Igij3aUvySfasC0+tw+I=;
        b=L9e0MAvJShBETk20ArQF02ez232dqV2o84ZToF1CZhodWJoLD33GIkiZCRFZoo7eBM
         wXjS/hQ9l/NxubTSKh/++WdG6ruUosLVlGaNPmLWxdxvQ1SQfgB5QiFSfcMhnNSTfLCa
         6rCdR14ZT1jndlE3E9n3Nu1j8HrUDj8pwO4goYwg22hM0CCtHdy8YhXtCLlbPRRTiwqO
         stQ8RbxX90raorfMqF7G0uS8+lCwBJuqNqxWaFBbk4fLN+W0fprq9XYyW8y99LZE0Ipr
         /f97Jqi6np6qXT42dKH6HazqNHXRqm4HglfbUPGGso2X/PJhvmCVQ6IJfoR7qt/X+6++
         8xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f6Da7523rX1uWkEPLzRoAH+Igij3aUvySfasC0+tw+I=;
        b=a9tpy0lMtaEeElml+DvknaL28n9G/4pgFtIE0KSRq96skvT32v/HSiID4rh4m6zsEF
         NibrpTQzS+NetiQ5FB3ygdBUJjRs0TsDNCMNPFS8vAxvARZO3lhNGYYKBYtymX3nbz7I
         OdI7VNNX5e+KNPpfzCAoDZUvdUisughDfhx6Icy/TGCxwBc59fpoEtHpKmedlpnhvSGB
         pQjrW4+3cC3oy5BpY3c1XJWN0e73TGWADBJVE6eFl1K26oJiiM63bNC1aDcSUsvUwfqu
         XipCKlQ0lxyxofDNNlper72l8woj1oa+CF8owza4oK8kKku88ruVxjv098Fb0/X6ZYbL
         bFUw==
X-Gm-Message-State: AOAM531S1R3e0bif2ph4ZVvlqP97MzhrTSLsorpZLyiVV4oq/Yw6JSZw
        O+k5PAqU5sHf8GoIsXlac3Pap3c=
X-Google-Smtp-Source: ABdhPJwu+wvSSUYejBhERT+998mB3wPdnawJIIxMRc/fJgg73eeQFByoBybA95AIp2ZnHJW0U2FLshA=
X-Received: by 2002:a25:230a:: with SMTP id j10mr6699807ybj.148.1593190357016;
 Fri, 26 Jun 2020 09:52:37 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:52:30 -0700
In-Reply-To: <20200626165231.672001-1-sdf@google.com>
Message-Id: <20200626165231.672001-3-sdf@google.com>
Mime-Version: 1.0
References: <20200626165231.672001-1-sdf@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH bpf-next v2 3/4] bpftool: support BPF_CGROUP_INET_SOCK_RELEASE
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Support attaching to sock_release from the bpftool.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/bpf/bpftool/main.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 5cdf0bc049bd..0a281d3cceb8 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -92,6 +92,7 @@ static const char * const attach_type_name[__MAX_BPF_ATTACH_TYPE] = {
 	[BPF_CGROUP_INET_INGRESS] = "ingress",
 	[BPF_CGROUP_INET_EGRESS] = "egress",
 	[BPF_CGROUP_INET_SOCK_CREATE] = "sock_create",
+	[BPF_CGROUP_INET_SOCK_RELEASE] = "sock_release",
 	[BPF_CGROUP_SOCK_OPS] = "sock_ops",
 	[BPF_CGROUP_DEVICE] = "device",
 	[BPF_CGROUP_INET4_BIND] = "bind4",
-- 
2.27.0.212.ge8ba1cc988-goog

