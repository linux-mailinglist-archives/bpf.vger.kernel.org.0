Return-Path: <bpf+bounces-9121-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 825CC7902C9
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 22:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B32791C20AEE
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 20:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93FF9CD;
	Fri,  1 Sep 2023 20:21:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C65C136;
	Fri,  1 Sep 2023 20:21:42 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F74AE65;
	Fri,  1 Sep 2023 13:21:41 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf7a6509deso17252315ad.3;
        Fri, 01 Sep 2023 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693599700; x=1694204500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y68qLpmJVNgjmUebk5qPvhzDRV/EazT8OXYTEoXaMw=;
        b=EhwJwLMjuxpXnQAa4wkdcDqZHxKLiRyONnknFzG6peBeYmPadlqk6WbAyZk3z9zAoc
         gVsLxrmxYiTR+GLhIT9srQJY8+Qmyy9cXIdpDrgNiVLmq24v1hxAwJ6lguRNcoNUidpc
         4o7UQaELrh+JLUCbRE1nkrMQsGka0zkx1wIoIpWtj8X6a4hltKpx6Auj5rpLzIpxvlTn
         ADsj3Yn5WJthR7zHWD5VpPHBrOudEqat7JnnUOA4+7++Gyk6tANInbcZdI+WEirwcPTi
         juSozp6xfG83aGeeZKboYCragHG4ZESOXnX6bEQApeEP38yBTrLancqRrYH6lvgVGcet
         gueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693599700; x=1694204500;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y68qLpmJVNgjmUebk5qPvhzDRV/EazT8OXYTEoXaMw=;
        b=SjQ+6QCt1fRG5Kg41qw7zV8jkvTexJYIkW0KFSwX5TCjsIyS8Hp6nvCe11k6/lAna2
         Jhmq++yJ7NYgmrcZp3Jm+1x4A+ssspEmybNgOYYdecnYfnsXtqBsdTT3tAiz4hmykYsY
         G787CazYW1hMkVrARLKCHBGKts7O/57VA4Ih5FoSjIQYE9oHrAsJdzvEFLqCTv90vfCH
         taDUBLs3+skfghrN44IHbc/Ac6Qz+IVj3oakgbqH52OWxzda17cWCZaskYpZYj0jPrKB
         cV6TN3gr3B2id2DLACXoV7/pvxVQcn+L7iLpS8159rwF1IAbS9GjowAIJHHGWS+8KqkK
         vsTg==
X-Gm-Message-State: AOJu0Yxc+ZpAxI9uU2BiON2DV2wUAdyKwRx02JlJqg0utLfherdtIUsL
	fAUYKA1+STN3BBNejnERGVk=
X-Google-Smtp-Source: AGHT+IG+vYoP9gBjMbAD6/5ZJSipjhXjpKKM1dxjXEuo5WgSVDl8LOF+CRiVZQ9TfJd9qAosPeRk0g==
X-Received: by 2002:a17:902:c209:b0:1b8:6850:c3c4 with SMTP id 9-20020a170902c20900b001b86850c3c4mr3815146pll.22.1693599700520;
        Fri, 01 Sep 2023 13:21:40 -0700 (PDT)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id iz22-20020a170902ef9600b001b8a00d4f7asm3375433plb.9.2023.09.01.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 13:21:39 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: olsajiri@gmail.com,
	xukuohai@huawei.com,
	eddyz87@gmail.com
Cc: john.fastabend@gmail.com,
	edumazet@google.com,
	cong.wang@bytedance.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf] bpf: sockmap, fix skb refcnt race after locking changes
Date: Fri,  1 Sep 2023 13:21:37 -0700
Message-Id: <20230901202137.214666-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

There is a race where skb's from the sk_psock_backlog can be referenced
after userspace side has already skb_consumed() the sk_buff and its
refcnt dropped to zer0 causing use after free.

The flow is the following,

  while ((skb = skb_peek(&psock->ingress_skb))
    sk_psock_handle_Skb(psock, skb, ..., ingress)
    if (!ingress) ...
    sk_psock_skb_ingress
       sk_psock_skb_ingress_enqueue(skb)
          msg->skb = skb
          sk_psock_queue_msg(psock, msg)
    skb_dequeue(&psock->ingress_skb)

The sk_psock_queue_msg() puts the msg on the ingress_msg queue. This is
what the application reads when recvmsg() is called. An application can
read this anytime after the msg is placed on the queue. The recvmsg
hook will also read msg->skb and then after user space reads the msg
will call consume_skb(skb) on it effectively free'ing it.

But, the race is in above where backlog queue still has a reference to
the skb and calls skb_dequeue(). If the skb_dequeue happens after the
user reads and free's the skb we have a use after free.

The !ingress case does not suffer from this problem because it uses
sendmsg_*(sk, msg) which does not pass the sk_buff further down the
stack.

The following splat was observed with 'test_progs -t sockmap_listen':

[ 1022.710250][ T2556] general protection fault, ...
 ...
[ 1022.712830][ T2556] Workqueue: events sk_psock_backlog
[ 1022.713262][ T2556] RIP: 0010:skb_dequeue+0x4c/0x80
[ 1022.713653][ T2556] Code: ...
 ...
[ 1022.720699][ T2556] Call Trace:
[ 1022.720984][ T2556]  <TASK>
[ 1022.721254][ T2556]  ? die_addr+0x32/0x80^M
[ 1022.721589][ T2556]  ? exc_general_protection+0x25a/0x4b0
[ 1022.722026][ T2556]  ? asm_exc_general_protection+0x22/0x30
[ 1022.722489][ T2556]  ? skb_dequeue+0x4c/0x80
[ 1022.722854][ T2556]  sk_psock_backlog+0x27a/0x300
[ 1022.723243][ T2556]  process_one_work+0x2a7/0x5b0
[ 1022.723633][ T2556]  worker_thread+0x4f/0x3a0
[ 1022.723998][ T2556]  ? __pfx_worker_thread+0x10/0x10
[ 1022.724386][ T2556]  kthread+0xfd/0x130
[ 1022.724709][ T2556]  ? __pfx_kthread+0x10/0x10
[ 1022.725066][ T2556]  ret_from_fork+0x2d/0x50
[ 1022.725409][ T2556]  ? __pfx_kthread+0x10/0x10
[ 1022.725799][ T2556]  ret_from_fork_asm+0x1b/0x30
[ 1022.726201][ T2556]  </TASK>

To fix we add an skb_get() before passing the skb to be enqueued in
the engress queue. This bumps the skb->users refcnt so that consume_skb
and kfree_skb will not immediately free the sk_buff. With this we can
be sure the skb is still around when we do the dequeue. Then we just
need to decrement the refcnt or free the skb in the backlog case which
we do by calling kfree_skb() on the ingress case as well as the sendmsg
case.

Before locking change from fixes tag we had the sock locked so we
couldn't race with user and there was no issue here.

Fixes: 799aa7f98d53e (skmsg: Avoid lock_sock() in sk_psock_backlog())
Reported-by: Jiri Olsa  <jolsa@kernel.org>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index a0659fc29bcc..6c31eefbd777 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -612,12 +612,18 @@ static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb
 static int sk_psock_handle_skb(struct sk_psock *psock, struct sk_buff *skb,
 			       u32 off, u32 len, bool ingress)
 {
+	int err = 0;
+
 	if (!ingress) {
 		if (!sock_writeable(psock->sk))
 			return -EAGAIN;
 		return skb_send_sock(psock->sk, skb, off, len);
 	}
-	return sk_psock_skb_ingress(psock, skb, off, len);
+	skb_get(skb);
+	err = sk_psock_skb_ingress(psock, skb, off, len);
+	if (err < 0)
+		kfree_skb(skb);
+	return err;
 }
 
 static void sk_psock_skb_state(struct sk_psock *psock,
@@ -685,9 +691,7 @@ static void sk_psock_backlog(struct work_struct *work)
 		} while (len);
 
 		skb = skb_dequeue(&psock->ingress_skb);
-		if (!ingress) {
-			kfree_skb(skb);
-		}
+		kfree_skb(skb);
 	}
 end:
 	mutex_unlock(&psock->work_mutex);
-- 
2.33.0


