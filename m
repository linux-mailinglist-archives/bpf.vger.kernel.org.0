Return-Path: <bpf+bounces-45902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D74979DF093
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 14:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B30A16395F
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EA319CCFA;
	Sat, 30 Nov 2024 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC2gHsXP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAE1993B4;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732973954; cv=none; b=E45uzamc4c4zyW5MkR7xDcjm0nM6RFZZwUq2aOyIcgY/EEAKXP8c9ld0zXgkfETWVYFKvyd57vhzamtCis7NBlU7TimI5Ik9Zt9Yl33IbIbQLIaK4w+lHfA9cJllLf8XaTNU/OoKX1ND3bUvi59LCQWkSxH7Cl7PaeuxmjEzAqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732973954; c=relaxed/simple;
	bh=xNoawWxL5Y6li8c9tLsL2y/MxQevmVgjNhHQfuMu8o8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ur/9NeiFDK0tqtHxISRQhS/dMHAN7D+Zn7zAouFLQCl1sCB8aYyOgSv6w4irDWJLszb8jKhCV955k+CRMR5XNQMlbrlOOcc92l0VsLE/dZXXfthb1oSyWX+s/VFQMnYSQpz/zM1QtNw9mL8atbN2S31sikjRWsB8bw2+/Nq2HHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC2gHsXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43149C4CED3;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732973954;
	bh=xNoawWxL5Y6li8c9tLsL2y/MxQevmVgjNhHQfuMu8o8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kC2gHsXPMdMygOCBv6KC5Z6BdFCC9RM+cIwBj0cE4WwueRfWWjZI5QxErmta1heDR
	 yklTRGBjiuKcWZ6dk8dWnOdHFjur+jXOOtDQqX17GuT6y9RJmpPAJXvpGvA8YOamk3
	 mR/khdt5SGvoX4H8lE6kVpuLk5Bq5OsWmzJSg/7S6a8X6ZBKI6aHdQb9HBU7ZdBO1k
	 KrNWKG+ROb8o0lvBwh8rVfLGvgm7jTC2mRef9s0ish+BzQUuGgdPxu95bHgd6Kzwgt
	 Pk+XMSU8C0N256dOH18FsuDnuv6axZ+ZdXEIQSTu3SX7gcnWlxhAGIVs3Swbmu32qA
	 OSoyRNqWC61pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F795D73606;
	Sat, 30 Nov 2024 13:39:14 +0000 (UTC)
From: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>
Date: Sat, 30 Nov 2024 21:38:22 +0800
Subject: [PATCH net 1/2] skmsg: return copied bytes in
 sk_msg_memcopy_from_iter
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-tcp-bpf-sendmsg-v1-1-bae583d014f3@outlook.com>
References: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
In-Reply-To: <20241130-tcp-bpf-sendmsg-v1-0-bae583d014f3@outlook.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Levi Zim <rsworktech@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296;
 i=rsworktech@outlook.com; h=from:subject:message-id;
 bh=+jh9LaMvNTwv+zmDx2vk37sFrN9lWR5dQyH5HZC8Q2M=;
 b=owEBbQKS/ZANAwAIAW87mNQvxsnYAcsmYgBnSxV+cY/4xWp+AOu+HS1pF3mD1lkW8ZroPbktI
 OGHl4YPTW+JAjMEAAEIAB0WIQQolnD5HDY18KF0JEVvO5jUL8bJ2AUCZ0sVfgAKCRBvO5jUL8bJ
 2O4mD/9uiFluDIQT5sursakLeOiycc85GUFuCghVJQyfsOzbd6i1STV1z0tniaX2ZFkcha+XtZK
 Tn/qA3C6do92pLsRW0VpVB2JpWJS/Bgh80SSj0AHo9pfAqH7Rz9Z1nwznelejLdKFwbPK86zvVN
 Nd8ar9fgT9f+lvptiLNjUefXXNU53Zv+yQpzZDM9/DWNFvBQ3MFltNWWTbi5NCPpxzoC/Eg243O
 NoON2+47hgJyprsrI+nyuSwZZGJLwXEw6zNPWPuoC0dkD6sO2qKgJWQ46QfWUQh+ciIHd7cTvpA
 T5oVR558KA1JDRt8a3prsYkXsGLDmeZ7TDiEzfYDXPZbuvDDuQaXcP9SqxY2i0moRHZqapRMUNo
 4ZYho5sDiVRM7L1lz3tUBUeWUH9JYgSOhCXmoP5IxkzAo22iDrd0ePZVAADcqcB15VtCkp6VgTT
 I5+DdO8cyNgomya2WVLTUKeXFxurvyBAE4BWyt+EGnhlZJLwfR7cQELw/JOYB/RIedqlAyr05bd
 b+vey1/eH12e3aRy/xMb6hOV4FbG8RczF7+Csj2WO8C+1lChytqCKRFus3On6S1OuO7KYKzZfZl
 oPG/UpE4AQ6/2R1qV2YdJz3h00IA3T2KTywVhdYFDcEbD3pYc5LWcAtW7FIs6HWzImeirVgX9TO
 6tB4maLwLVTPTCA==
X-Developer-Key: i=rsworktech@outlook.com; a=openpgp;
 fpr=17AADD6726DDC58B8EE5881757670CCFA42CCF0A
X-Endpoint-Received: by B4 Relay for rsworktech@outlook.com/default with
 auth_id=219
X-Original-From: Levi Zim <rsworktech@outlook.com>
Reply-To: rsworktech@outlook.com

From: Levi Zim <rsworktech@outlook.com>

Previously sk_msg_memcopy_from_iter returns the copied bytes from the
last copy_from_iter{,_nocache} call upon success.

This commit changes it to return the total number of copied bytes on
success.

Signed-off-by: Levi Zim <rsworktech@outlook.com>
---
 net/core/skmsg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index e90fbab703b2db1da49068b5a53338ce7ff99087..a65c2e64645863b80ddd94c464d86fcc587b5c04 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -369,8 +369,8 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			     struct sk_msg *msg, u32 bytes)
 {
 	int ret = -ENOSPC, i = msg->sg.curr;
+	u32 copy, buf_size, copied = 0;
 	struct scatterlist *sge;
-	u32 copy, buf_size;
 	void *to;
 
 	do {
@@ -397,6 +397,7 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 			goto out;
 		}
 		bytes -= copy;
+		copied += copy;
 		if (!bytes)
 			break;
 		msg->sg.copybreak = 0;
@@ -404,7 +405,7 @@ int sk_msg_memcopy_from_iter(struct sock *sk, struct iov_iter *from,
 	} while (i != msg->sg.end);
 out:
 	msg->sg.curr = i;
-	return ret;
+	return (ret < 0) ? ret : copied;
 }
 EXPORT_SYMBOL_GPL(sk_msg_memcopy_from_iter);
 

-- 
2.47.1



