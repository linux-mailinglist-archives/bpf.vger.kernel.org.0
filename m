Return-Path: <bpf+bounces-10837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1431D7AE44A
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 05:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9BEE0281878
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 03:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B41A1859;
	Tue, 26 Sep 2023 03:52:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BF7F;
	Tue, 26 Sep 2023 03:52:39 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEB1C9;
	Mon, 25 Sep 2023 20:52:38 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3ab2436b57dso5060525b6e.0;
        Mon, 25 Sep 2023 20:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695700357; x=1696305157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JdjM08gmoXvyztouDjrJfcBPW9vYMWj7EpOPKNnHpmc=;
        b=cgv783Z5kdvoETuuDNXwnsM4UHaxzAXibssrTRrHMG4KYI2LmJWGo+XN5h92ub0SnR
         7vcmpFMgN+DYSuhs6pnGxvke911N3zYxhgg9HEp+Oq22KaOKDKcq2R1fVUz1Oq1r/lzj
         Gn1VfSFYEpSe7GbYJDz7/2yvs1t2XGsFVr5gLFfRjHvH+nR66RG6UA4He1fR24zZbFNh
         KvvoERCu6suzAGGgvBVnyKW0YaVY2aeRBISQ9VbcBAPTMaPtOhCsBcOOUx+jn+dovBs+
         u8SwFepyVoHAbhI9s8x5IxL/jvog3OoEbLgzbgdteMkxgUCQDt68T29bFg3fJt22C9QF
         mwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695700357; x=1696305157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdjM08gmoXvyztouDjrJfcBPW9vYMWj7EpOPKNnHpmc=;
        b=CfpD2yblzFKij1xcByKvyi6G/n+ucIuNj/H7198g6o6DABaVszhMgctfjYLFGcv4/z
         gwCSBiX8vPVuC2u/EJunWvZGQMgRs23xcqlCD+UcthYPmmdadyF1GniAAP4S6cq+Fa6w
         nsz9/MQORcF07AE5EsqvdvpbftyC1zEk5R3/0DmFqa3iTGkjN6EZoPueDPHX0ASSjdr0
         nD4zgxteEOaFMO2616pC02x/pF6Z5lLi9AnL4IPSxhWU0T3m3QE0RAhboxxIngmUi0D4
         WRbq1xBpwyvUpLH3dY+d1CJY1YgKBGh0frlqeKNJ5bSsC1uTHuoHwh1uSTOFbqcMAk/p
         slCw==
X-Gm-Message-State: AOJu0YxugoJFPMWfikU2tYcZNIVKTAOlyOikIi63IJQDzusRPJn7O6aq
	DB00pVB2HqgXKRa+MAKXrpU=
X-Google-Smtp-Source: AGHT+IH3BNod6gFJDP8Q82zw3Hovz34QvgSSdg1d6qqSaJ2TIqFWqx6diC5eKWWqoIx6YxK7qDiuNg==
X-Received: by 2002:a05:6808:34d:b0:3a8:7c67:7f5 with SMTP id j13-20020a056808034d00b003a87c6707f5mr9369162oie.1.1695700357223;
        Mon, 25 Sep 2023 20:52:37 -0700 (PDT)
Received: from john.lan ([2605:59c8:148:ba00:650a:2e28:f286:c10b])
        by smtp.gmail.com with ESMTPSA id h5-20020aa786c5000000b006889511ab14sm8822575pfo.37.2023.09.25.20.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 20:52:36 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	edumazet@google.com
Subject: [PATCH bpf v2 0/3] bpf, sockmap complete fixes for avail bytes
Date: Mon, 25 Sep 2023 20:52:29 -0700
Message-Id: <20230926035233.134883-1-john.fastabend@gmail.com>
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

With e5c6de5fa0258 ("bpf, sockmap: Incorrectly handling copied_seq") we
started fixing the available bytes accounting by moving copied_seq to
where the user actually reads the bytes.

However we missed handling MSG_PEEK correctly and we need to ensure
that we don't kfree_skb() a skb off the receive_queue when the
copied_seq number is not incremented by user reads for some time.

v2: drop seq var in tcp_read_skb its no longer necessary per Jakub's
    suggestion

John Fastabend (3):
  bpf: tcp_read_skb needs to pop skb regardless of seq
  bpf: sockmap, do not inc copied_seq when PEEK flag set
  bpf: sockmap, add tests for MSG_F_PEEK

 net/ipv4/tcp.c                                |  3 +-
 net/ipv4/tcp_bpf.c                            |  4 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 52 +++++++++++++++++++
 3 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.33.0


