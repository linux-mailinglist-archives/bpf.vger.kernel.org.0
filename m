Return-Path: <bpf+bounces-28523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C928BB134
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0228282E51
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D43156C6E;
	Fri,  3 May 2024 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQeuX4DM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABBE156C47;
	Fri,  3 May 2024 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714754889; cv=none; b=G0Geiu7GHk0Bov8BZ9wFRjRPb7dX42as6/50kku3zRLv68bEp2oGRzYneVTAYq9u6KpHVgmLWO0kn0IO1iYdhlhzY5wK+DWDsDJ9iIKscBnqKI+AzlV+mJ4y65pzLwtZRDEp28E3oMOsJuJxjc2Qt82OLMlOnRDdI1TqDfM4QwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714754889; c=relaxed/simple;
	bh=ik8NzUfkbQh7WTppb3UIytikPKsoJLe7DZTjeyU0yNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TClwUHeXpJqrZWeiWYuZ10GaameOUa1KyqhZLlDxRwZijexBd2WKpNBa9v3yawlOjHlKZ3tfEOHaOd5TZtNaZKCIPzihSIM+0/2N2OVRIRCYd+JknwNEyf5PwPNxJMPLL/+PSf1iic2mxs/T5iO/L+BoYvUf+czcJ4KDgriZhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQeuX4DM; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1ec5387aed9so37993095ad.3;
        Fri, 03 May 2024 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714754887; x=1715359687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oOaAAA400sxBj7Rt513jpfYioUpeWT2rZ/2CANbKUV8=;
        b=eQeuX4DMUFHUq3sxD9fiTfxK3OTj7P/FAnihLFJuf9MGZOyNJx0UvBy5uj2fm9L1B5
         qz/8F7VwIK5iIzlhyGdU6k1HY7R2T2TKkStdYLvidkgUZ2fbYUhXccYxmGS3+T69xzmj
         mvIxpAEMj0eGn5zdj2e5XK+a0fGZ7cglclghEYHt6/YGS6bmtHJX7ogz/cf9ixm+X4Ph
         I0JqrPB4B7GjarIIj89VbOKyhogryzkYVjCgjukXTvdF6OYrd16JDo+EAGYEi0Zg85De
         3BGf3z7vpanddRjQIdqJopgx7ITRkbdmU2DwU+7bsZQSMR0bTrSs5sJyG2TeJ1iCWVc4
         RGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714754887; x=1715359687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOaAAA400sxBj7Rt513jpfYioUpeWT2rZ/2CANbKUV8=;
        b=wAvY//UHrPA7ZVBiaC/jpD9TedyP+CXXUkNuNAhw5g1kNL4gatmNFZT8SOglLwfJA7
         L4sE0JpGHL6O/SqsE1GE7FnCxECpcMUT36TV0JnFZw1PxdiGFgVd9rO7mgx7gXtkyPKT
         dmcTTNX6UXvdXeXrIBjNX6jQY7hDg6tG1OJw+d0hV0Z8BpdoL8dVVRNNmwUbcEvtMMkT
         Rzrg8knFvosIBSgEbIVOQ1mGP/FjQcm49bRgMhUiCD7Q599tVpotgvsm/HccD/JHl8xR
         tYOGRrXwLTSnIq10lcswbNmhj7XGVUYgtG+sbqvnLpKnCchiBK6Y21JLkHjfxVS94Z+N
         hqtg==
X-Gm-Message-State: AOJu0Yy1mnoM07COJ/zLO3d+ZIs3u2bn0z3eCe9y8+A0Q+6FqbOBR57o
	I02uuS9Yzf39iN//IDNbJmzsmNzG5gYKKCezobt88+rBl9dTSUoxSHiUo0p3
X-Google-Smtp-Source: AGHT+IEV+lbScjEtPqb+6Le5rwHnLmbZyls2laR0sN6BCk3+IvPMFNPc+EIIgEaVqMX4V46wCutIYg==
X-Received: by 2002:a17:902:efcb:b0:1eb:3daf:ebaf with SMTP id ja11-20020a170902efcb00b001eb3dafebafmr2883529plb.57.1714754887103;
        Fri, 03 May 2024 09:48:07 -0700 (PDT)
Received: from john.. ([98.97.32.52])
        by smtp.gmail.com with ESMTPSA id r12-20020a170902c60c00b001ec7a1a8702sm3450873plr.271.2024.05.03.09.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 09:48:06 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dhowells@redhat.com
Subject: [PATCH stable, 6.1] net: sockmap, fix missing MSG_MORE causing TCP disruptions
Date: Fri,  3 May 2024 09:48:05 -0700
Message-Id: <20240503164805.59970-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit ebf2e8860eea66e2c4764316b80c6a5ee5f336ee]
[ Upstream commit f8dd95b29d7ef08c19ec9720564acf72243ddcf6]

In the first patch,

ebf2e8860eea ("tcp_bpf: Inline do_tcp_sendpages as it's now a wrapper around tcp_sendmsg")

This block of code is added to tcp_bpf_push(). The
tcp_bpf_push is the code used by BPF to submit messages into the TCP
stack.

 if (flags & MSG_SENDPAGE_NOTLAST)
     msghdr.msg_flags | MSG_MORE;

In the second patch,

f8dd95b29d7e ("tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage")

this logic was further changed to,

  if (flags & MSG_SENDPAGE_NOTLAST)
     msghdr.msg_flags |= MSG_MORE

This was done as part of an improvement to use the sendmsg() callbacks
and remove the sendpage usage inside the various sub systems.

However, these two patches together fixed a bug. The issue is without
MSG_MORE set we will break a msg up into many smaller sends. In some
case a lot because the operation loops over the scatter gather list.
Without the MSG_MORE set (the current 6.1 case) we see stalls in data
send/recv and sometimes applications failing to receive data. This
generally is the result of an application that gives up after calling
recv() or similar too many times. We introduce this because of how
we incorrectly change the TCP send pattern.

Now that we have both 6.5 and 6.1 stable kernels deployed we've
observed a series of issues related to this in real deployments. In 6.5
kernels all the HTTP and other compliance tests pass and we are not
observing any other issues. On 6.1 various compliance tests fail
(nginx for example), but more importantly in these clusters without
the flag set we observe stalled applications and increased retries in
other applications. Openssl users where we have annotations to monitor
retries and failures observed a significant increase in retries for
example.

For the backport we isolated the fix to the two lines in the above
patches that fixed the code. With this patch we deployed the workloads
again and error rates and stalls went away and 6.1 stable kernels
perform similar to 6.5 stable kernels. Similarly the compliance tests
also passed.

Cc: <stable@vger.kernel.org> # 6.1.x
Fixes: 604326b41a6fb ("tcp_bpf, smc, tls, espintcp, siw: Reduce MSG_SENDPAGE_NOTLAST usage")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/ipv4/tcp_bpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index f8037d142bb7..20d94f67fde2 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -105,6 +105,9 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 
 		tcp_rate_check_app_limited(sk);
 retry:
+		if (size < sge->length && msg->sg.start != msg->sg.end)
+			flags |= MSG_SENDPAGE_NOTLAST;
+
 		has_tx_ulp = tls_sw_has_ctx_tx(sk);
 		if (has_tx_ulp) {
 			flags |= MSG_SENDPAGE_NOPOLICY;
-- 
2.33.0


