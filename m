Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56553107E25
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 12:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKWLIF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 06:08:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39985 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfKWLIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 06:08:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so10290206ljg.7
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6t6QQii5Lt+imc/dGt67Dp8yIdpuF6S8gD1Zrt2s8M=;
        b=DZZ6/XpKHUPc4F+SNMPNBCeHcjLRVsPHFE1E57XbBE2C6kX2T1Erf+37Mcfbaawwfr
         tBeQx9X+L1yHGjPAsFoNOAaaL5nmKfveBodBZzEBxtZ9X4BGSErgE3smX0J0WQwX6bxm
         46NO0DsfX9L7xJVjpUVdt+plvluWr7+IYcpQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6t6QQii5Lt+imc/dGt67Dp8yIdpuF6S8gD1Zrt2s8M=;
        b=N8ola9mVetP5fe+NafSb8LZb1FziTiG2tvks/yYd1kcZvCF2UmPJrz2aQ/F4Rsp5vk
         RG6LBHJaEcEXzIKDkE/spsHN/lkMJfZXlELoOO1TbYkfn3ZY0T3LxlM3Ig1jrkWVN2J4
         nHPE3fbrO8GJdnYluzzQQGutRvCK1IASmIdKNZ9NPcwenpyJvVh3ScyTw4Yj7VLx8VyQ
         EivAQVuncddR+wbYm0LGU29GmpszDuNRBkrFpXf9nB62uO9D/u/JqdkXdS74lTdAtC3j
         +EO1PgOSMA6eLfbqfmgIjuVHbUWHsihfav/2rMWFfn9iXmwTyAV4lE8/eUl5sj2KID7s
         T/7w==
X-Gm-Message-State: APjAAAWDdpqs2jNS15RD3y4Yhfn0Tll4zIw+iG9vHbLneb3huE5F5cnO
        2BPdw42exMku4W0bpBQJzhAsfMMc3EGx5w==
X-Google-Smtp-Source: APXvYqwSQqfuJxAt2lF/S7uDhi6HJo4oFGDvs6Bkr10rUyjqivcpiCoDjGiLFAyOL40I2Dw5ers92Q==
X-Received: by 2002:a2e:a404:: with SMTP id p4mr1630777ljn.234.1574507282318;
        Sat, 23 Nov 2019 03:08:02 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id h24sm597666ljc.89.2019.11.23.03.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 03:08:01 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 6/8] libbpf: Recognize SK_REUSEPORT programs from section name
Date:   Sat, 23 Nov 2019 12:07:49 +0100
Message-Id: <20191123110751.6729-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191123110751.6729-1-jakub@cloudflare.com>
References: <20191123110751.6729-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow loading BPF object files that contain SK_REUSEPORT programs without
having to manually set the program type before load if the the section name
is set to "sk_reuseport".

Makes user-space code needed to load SK_REUSEPORT BPF program more concise.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e1698461c6b3..dbb77283b0c6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4987,6 +4987,7 @@ static const struct {
 	enum bpf_attach_type attach_type;
 } section_names[] = {
 	BPF_PROG_SEC("socket",			BPF_PROG_TYPE_SOCKET_FILTER),
+	BPF_PROG_SEC("sk_reuseport",		BPF_PROG_TYPE_SK_REUSEPORT),
 	BPF_PROG_SEC("kprobe/",			BPF_PROG_TYPE_KPROBE),
 	BPF_PROG_SEC("uprobe/",			BPF_PROG_TYPE_KPROBE),
 	BPF_PROG_SEC("kretprobe/",		BPF_PROG_TYPE_KPROBE),
-- 
2.20.1

