Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBF6EA28
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2019 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbfGSRbN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jul 2019 13:31:13 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35035 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbfGSRbN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jul 2019 13:31:13 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so23847564qke.2
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2019 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2MMCFCBJboEB1CIyV6dVGBXQRDYkVd8+DYCGoW0iWWE=;
        b=AjeF2M5J0BU1eQpiEOd0rKkfPUbNSRlth8FdcP8Rk+Hd8JlQ/sGAkCzuT20PJ+izCE
         Z6HtIg6NUXZ+VpIXRWMH0FqjsXZSkMUL0dGYc6FBBeK/tCoAYgNXKAJc4BNjU9jdmINL
         SsqezIaXnIAepoF0zqrLZ2BT0TshNhQ+nSXquZMovPNZg2rEWFVD21gLqcC4Sgzu6xaB
         aFKwzJUKsTnZy+Df1UGXgMhCXAfQl4obUz680uOWe2beItkT9VTLD2cYvlhBvA4o2S3z
         0kHK9QRVXApKaNmYYvcGE13MeJi54C2WRjv55PEEDnKxleBBnEZ234DJgyvvWE7QbH7j
         66KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2MMCFCBJboEB1CIyV6dVGBXQRDYkVd8+DYCGoW0iWWE=;
        b=G/i1uoeRU49DoFZGKPxJUIPTG+CNhIDgN2iSCm08X9NW/q2IwifASVoWrkCMn4chmc
         SinpLGpqJPxG0F/weCxteR1p1YPAmi6REYQnTB8b8RnHk4ts3JA7j4C+uGfvWfp9f/U4
         g2DPehJrrwe2GhBeG/DnITE7bw1jZHWbggGKZmLnMYnoprJ54rklwMeAMEWmSIgkAlbk
         LoSsd2t+XnyzgPj3G4p18BfzMu71r4QXI0PhnZqoLtWjyTV6xKaOH2teRKR7mZHGBhC1
         oTGfuMGRvaqHxFjYRGHhzpwbF1Jn9reIJ+bJfX8OeQCL3zy5EXqf1pITuDdM3KJ+Aq89
         opEw==
X-Gm-Message-State: APjAAAU3ASXQvSNcZJKfkirPY9ywZN87cI6uR6xbyZPhFiHJmHm+s8CE
        qkspZ0avuwGdp8ikeJ3oHezcWA==
X-Google-Smtp-Source: APXvYqwSnFM499KiZ0X7Qn+TSKes60QYSIBBhJr7Ycrd5UAt1Ywy2z9C+oyJfDqCUgGTIKzFCsCOiA==
X-Received: by 2002:a05:620a:533:: with SMTP id h19mr35861754qkh.325.1563557472146;
        Fri, 19 Jul 2019 10:31:12 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y3sm15568509qtj.46.2019.07.19.10.31.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 10:31:11 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     john.fastabend@gmail.com, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf v4 08/14] bpf: sockmap, only create entry if ulp is not already enabled
Date:   Fri, 19 Jul 2019 10:29:21 -0700
Message-Id: <20190719172927.18181-9-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190719172927.18181-1-jakub.kicinski@netronome.com>
References: <20190719172927.18181-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: John Fastabend <john.fastabend@gmail.com>

Sockmap does not currently support adding sockets after TLS has been
enabled. There never was a real use case for this so it was never
added. But, we lost the test for ULP at some point so add it here
and fail the socket insert if TLS is enabled. Future work could
make sockmap support this use case but fixup the bug here.

Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/sock_map.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 56bcabe7c2f2..1330a7442e5b 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -334,6 +334,7 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 				  struct sock *sk, u64 flags)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
+	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct sk_psock_link *link;
 	struct sk_psock *psock;
 	struct sock *osk;
@@ -344,6 +345,8 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 		return -EINVAL;
 	if (unlikely(idx >= map->max_entries))
 		return -E2BIG;
+	if (unlikely(icsk->icsk_ulp_data))
+		return -EINVAL;
 
 	link = sk_psock_init_link();
 	if (!link)
-- 
2.21.0

