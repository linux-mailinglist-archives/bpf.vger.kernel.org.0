Return-Path: <bpf+bounces-35679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C0F93CA4E
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 23:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08121281271
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98712143889;
	Thu, 25 Jul 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OokpzGxQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C1208A5;
	Thu, 25 Jul 2024 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943670; cv=none; b=rLm0LzD8+7QdgYrMp8xWKJ9KGh2A4j6ISziwbYIEAllFIt0wMN+YeIxxHYy9fDj3gBGm1rDhUYZPq26vo4QV2wswHQ2bURaGhYsCWywiHdX/bYmi4EbYnIwycWzqR5BbhbXtAA+tQI9P8st2O3CJF6eokyhGKJcXnqVCnHAbNeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943670; c=relaxed/simple;
	bh=h2tjo5jqA6NsmYpHu4VuvlN6rVdNyM2tZzm3fZZLfXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NZG6DrTFe6KrkkyJX4HMEJZS7s5sa7eg7BBXFOhHvuOMy6ltfPR8vh4oVsEcgkOPJtru5zgygbGewly0gdNcmyMcmGQ6P7YgP92IQSBg82weYPm1dTAi2z3Yoqem4lqXYpB2XwJls3pwwykQmwb3JsYNyffY09vD5LNvI6I+iaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OokpzGxQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc60c3ead4so268915ad.0;
        Thu, 25 Jul 2024 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721943668; x=1722548468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6U9fkV91/RnwQzqH3nww+tPJn0fT/3EAuQgPzXGouQ=;
        b=OokpzGxQYXfXjxfHmhg9uRsITd5Dr3Sk1Y9U01rpjKuyEKkZ0RYJSejQtzMAM3cECh
         VXVDcSvTdiWWFL74bsqzCj0yi7d5CAg1g6Lgd8FMfbiRVbfgNxfJGIHX9E7G7UQKSqH+
         ecY+JR//z8ZgknCvF2k17jMJ3geHfmm4enMTkjBUWxL+BOeaG+X3Jgnh2IZIm98Snrk+
         RuLXsc8J3cez3OWRxjC+TTHSOGOF90kWer/xiOEww5SivB58iMUH/gaZcOx9j+7ugGkw
         NvqRPrEPpVIgQ/rREJCGAg4/gkn7UH5gLyVBTjCGITFgkJcocMlOI+Rqus+vP9dLt2LF
         +4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943668; x=1722548468;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6U9fkV91/RnwQzqH3nww+tPJn0fT/3EAuQgPzXGouQ=;
        b=PAT77XbMZNKiwW70FqtBh369Gi4YOiARRK0k+sNC8b+xfO9kx+mftMFg19eN40w7Yc
         Xscz0pnuVst6JVTCsYMF0bugqvkkSCqQzXItdisdVityvaiymPPnDN9GZ6mgj4hpDNT/
         6BZETtJwnXys5dpA2kbsxR4qfWvAPk4VBBkHWLmC7V38yzdWglb7WcFW6T5AwK+52yyL
         VHW4NMYQek/4DFEIHpIERU60MN+C+DZEKPdDO9FPsi00xfoO8Jn5HroSJsVhINTOKWHG
         huMBu7xDBYziilfqk6OlLCqBMRsoVpTIWCxwPgTmPLoI/ePvig+Cal7/vxpCMNODR3kD
         DBYA==
X-Forwarded-Encrypted: i=1; AJvYcCWubP1YgON4IHJeDwyl0ErlKiqGh7QYgTXf8uycSLi30YdI3M8ewHGIJJV/XOhyC41tqoMuxUq4SlakNHT7RPSsUlmm8cHwT+B/aBwAbTd88YqNP/NDCoOzP0Sz15sxKHDE4MYVolqk2QMdFf5t3g/wqB8pRL/32RY/
X-Gm-Message-State: AOJu0YyOXRn13bMBEHegIn71dINBBfDSNU5D06jI+Sx4lskpi6s0dmo7
	MNUMDBjxvDR8U/A7vC6Lf5IlBaAcanbkMCxIitVXSqCrGYPxXyrbi2wxrkfuJeI=
X-Google-Smtp-Source: AGHT+IGZq2mjdu6oAX3V/JuRRsy2d5EjjPjlLQkNhSqm5TUqSo5l/1N5fUso80UVdi2UlfiSbVb3FA==
X-Received: by 2002:a17:902:d50b:b0:1fb:76d9:fe84 with SMTP id d9443c01a7336-1fed3bf8055mr46613775ad.65.1721943668029;
        Thu, 25 Jul 2024 14:41:08 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fbe089sm18771565ad.269.2024.07.25.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:41:07 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	bigeasy@linutronix.de,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net] tun: Add missing bpf_net_ctx_clear() in do_xdp_generic()
Date: Fri, 26 Jul 2024 06:40:49 +0900
Message-Id: <20240725214049.2439-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000009d1d0a061d91b803@google.com>
References: <0000000000009d1d0a061d91b803@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are cases where do_xdp_generic returns bpf_net_context without 
clearing it. This causes various memory corruptions, so the missing 
bpf_net_ctx_clear must be added.

Reported-by: syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com
Fixes: fecef4cd42c6 ("tun: Assign missing bpf_net_context.")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20676fb..751d9b70e6ad 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5150,6 +5150,7 @@ int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
 			bpf_net_ctx_clear(bpf_net_ctx);
 			return XDP_DROP;
 		}
+		bpf_net_ctx_clear(bpf_net_ctx);
 	}
 	return XDP_PASS;
 out_redir:
--

