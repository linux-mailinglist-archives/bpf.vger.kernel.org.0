Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110CF220DB9
	for <lists+bpf@lfdr.de>; Wed, 15 Jul 2020 15:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731302AbgGONJP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jul 2020 09:09:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731514AbgGONJL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jul 2020 09:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594818550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYWtpykPvB8BhaRiBcYzbHdq5CDZAFVD2s9zddWuWd0=;
        b=ECYURA/4pjIYb0RsqlfbDZ3nhu2qz6aDhvYLrJGjddncEaRG9rEEMmRmww4C1wNKg7i8jj
        6tRB9hYU8/PEZWkE7HP06OaPhBMv0ZvjtcrolW23vSV/8MC4xGQIF/Mef67cpX26HZMhxj
        ZyrPsWqqt3yDpaiMWwUlGSSrbguNUyY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-jAtZW6AAOiqKHrHCbMcKJg-1; Wed, 15 Jul 2020 09:09:08 -0400
X-MC-Unique: jAtZW6AAOiqKHrHCbMcKJg-1
Received: by mail-qv1-f71.google.com with SMTP id l12so1253781qvu.21
        for <bpf@vger.kernel.org>; Wed, 15 Jul 2020 06:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=nYWtpykPvB8BhaRiBcYzbHdq5CDZAFVD2s9zddWuWd0=;
        b=m8FWAPyKuICIPvi5lRSJo1D/k1CgeaJmJIIpDu3elNKkC14gyWhRa5XM2Ig1Ey6LAu
         JP30SJ4b8ZPJfyWvVsFR8Sakb7BgmqJ3wqjkV5vpc9KllqW9npt7GE4sJ7DGH7yjiAJF
         UY25/6RZS2EuyKtK1HicNU0CfG0UhZkdUC1GCkPj0x3Z+6xFxnTdgLic4G0uY1q0mEMJ
         dMBy7Z5jgXQiSxkmN4V66A+POKd/19P0hhs8g23DSCYAmpUWFZxLTmm8/VesYdIL8gwo
         CNq1IhlRLEB8uMkqJvJUTUzom8GP2IKXIoZvBbJ50UPIQGt0VBmmxiHXl1Q6jffHvKgT
         WuIg==
X-Gm-Message-State: AOAM532oy1exkfjXXAiJJa63e85J7gVyBUF1Rg4c+YcV/81fedYudsqd
        0YkUrbm2kzaopgCJyDiqHeEL9cOXqbZd0GexE2wyAJ1taU3Crmf3+1yf+aOp2Jidp3YyS3xmDiK
        Gi8Wrv7fQhSqP
X-Received: by 2002:aed:2f04:: with SMTP id l4mr10384709qtd.227.1594818548055;
        Wed, 15 Jul 2020 06:09:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAwcP+7wNRWG5Tjl6MUkTt9PeYzZCzvCIeDd8DeDnx3jOoia1FH7JoTvN956VFZ3fGkmbOfg==
X-Received: by 2002:aed:2f04:: with SMTP id l4mr10384687qtd.227.1594818547861;
        Wed, 15 Jul 2020 06:09:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o10sm2860796qtq.71.2020.07.15.06.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:09:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B6349180653; Wed, 15 Jul 2020 15:09:03 +0200 (CEST)
Subject: [PATCH bpf-next v2 4/6] tools: add new members to
 bpf_attr.raw_tracepoint in bpf.h
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Wed, 15 Jul 2020 15:09:03 +0200
Message-ID: <159481854364.454654.3830221599405038317.stgit@toke.dk>
In-Reply-To: <159481853923.454654.12184603524310603480.stgit@toke.dk>
References: <159481853923.454654.12184603524310603480.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Sync addition of new members from main kernel tree.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/include/uapi/linux/bpf.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 5e386389913a..01a0814a8cfe 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -574,8 +574,10 @@ union bpf_attr {
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
-		__u64 name;
-		__u32 prog_fd;
+		__u64		name;
+		__u32		prog_fd;
+		__u32		tgt_prog_fd;
+		__u32		tgt_btf_id;
 	} raw_tracepoint;
 
 	struct { /* anonymous struct for BPF_BTF_LOAD */

