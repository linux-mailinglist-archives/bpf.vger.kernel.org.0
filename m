Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAB11907E
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2019 20:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLJTTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Dec 2019 14:19:37 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:42321 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfLJTTg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Dec 2019 14:19:36 -0500
Received: by mail-pl1-f202.google.com with SMTP id b3so345837plr.9
        for <bpf@vger.kernel.org>; Tue, 10 Dec 2019 11:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eofQlu96w5PdwK6jdsAtv9MrY+azci8yH0951lYXHqk=;
        b=G6zbASc1oLSOyih11B4znRobCS1FvvcrU8nTeE6Ykxazb5bR7CHtYDzc7EJkY0dgIC
         J7DigQ2E5l4P7FCEG7ar5DhUkhFIad+Mhs8aPCWO27gA2pFMQJ8/3yHogOGoGTSkwzeE
         qx1jJlv98tjQTvCbpGDhmfkRye0kK8kW18RCLoBgvmMw0XIsHQ82cn4sSome+RwSOmv6
         01wH6yNYfZMQGeEPk8pXC4Uy95yPUvsuTRVtbZfkzU+W7mNZ3PDeHaNTOO5eEVRYql62
         h6PVw5puqG8BL3TdlePpnMxxZk1IOWbFWEkGEAhsnc8/TDpntnT+CvUiCR8B81xqUjet
         phWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eofQlu96w5PdwK6jdsAtv9MrY+azci8yH0951lYXHqk=;
        b=kaoNRNXucsJt4DYKpJkKe0SQAQf4TBuZF3m78CZ3JJGUN29w1cpPBsMeDHp2jP/gcI
         fIwN9Gwr+5FBHXRJbNYl3Qc+8DFdym6lsAlOiSUwb4dNGGwJYo135X8fPK69kWh5X6GH
         G5SK83MV01l6kwrxWotsR5GnwPXa/NiEf8zsJjp6LWjsRECouAEI49bkEPrfHCxNTW9B
         RHHy43JrDllct3hEB6s1vbIE95JsSFi6SsqQhde9btkZw0N3tJfEja4InbFSJlvLDlIQ
         f0c4ERw/AvUhtP7ltYmXtNy7uSka/wIFuvPm6+UI1e6VAUFevsUKtiGoPOUc0dlepNEy
         2zLQ==
X-Gm-Message-State: APjAAAX4U46PudbRB0ZELJwkVMcXPZtzPwXuIZf9gpUbgHEuq0ibxEcD
        pIHQ12/2fLANBQvKLQN2IOHAgwE=
X-Google-Smtp-Source: APXvYqwv9WGpW3lNnW9weVW4DZ4MLIV+/U3eAXbl5z6CHDB55926Vzzj9cBeSFlo3wm6B/O7vLXaO64=
X-Received: by 2002:a63:130a:: with SMTP id i10mr11067776pgl.199.1576005575815;
 Tue, 10 Dec 2019 11:19:35 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:19:33 -0800
Message-Id: <20191210191933.105321-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.525.g8f36a354ae-goog
Subject: [PATCH bpf-next] bpf: switch to offsetofend in BPF_PROG_TEST_RUN
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

Switch existing pattern of "offsetof(..., member) + FIELD_SIZEOF(...,
member)' to "offsetofend(..., member)" which does exactly what
we need without all the copy-paste.

Suggested-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 915c2d6f7fb9..85c8cbbada92 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -252,22 +252,19 @@ static int convert___skb_to_skb(struct sk_buff *skb, struct __sk_buff *__skb)
 
 	/* priority is allowed */
 
-	if (!range_is_zero(__skb, offsetof(struct __sk_buff, priority) +
-			   FIELD_SIZEOF(struct __sk_buff, priority),
+	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, priority),
 			   offsetof(struct __sk_buff, cb)))
 		return -EINVAL;
 
 	/* cb is allowed */
 
-	if (!range_is_zero(__skb, offsetof(struct __sk_buff, cb) +
-			   FIELD_SIZEOF(struct __sk_buff, cb),
+	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, cb),
 			   offsetof(struct __sk_buff, tstamp)))
 		return -EINVAL;
 
 	/* tstamp is allowed */
 
-	if (!range_is_zero(__skb, offsetof(struct __sk_buff, tstamp) +
-			   FIELD_SIZEOF(struct __sk_buff, tstamp),
+	if (!range_is_zero(__skb, offsetofend(struct __sk_buff, tstamp),
 			   sizeof(struct __sk_buff)))
 		return -EINVAL;
 
@@ -437,8 +434,7 @@ static int verify_user_bpf_flow_keys(struct bpf_flow_keys *ctx)
 
 	/* flags is allowed */
 
-	if (!range_is_zero(ctx, offsetof(struct bpf_flow_keys, flags) +
-			   FIELD_SIZEOF(struct bpf_flow_keys, flags),
+	if (!range_is_zero(ctx, offsetofend(struct bpf_flow_keys, flags),
 			   sizeof(struct bpf_flow_keys)))
 		return -EINVAL;
 
-- 
2.24.0.525.g8f36a354ae-goog

