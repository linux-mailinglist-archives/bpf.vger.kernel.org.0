Return-Path: <bpf+bounces-10499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D86A7A8FD6
	for <lists+bpf@lfdr.de>; Thu, 21 Sep 2023 01:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36B6BB20AAA
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 23:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C923F4C8;
	Wed, 20 Sep 2023 23:27:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537115AC9;
	Wed, 20 Sep 2023 23:27:11 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B718CC;
	Wed, 20 Sep 2023 16:27:09 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-274c05edb69so185423a91.2;
        Wed, 20 Sep 2023 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695252429; x=1695857229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9KM+06L1WVltQOADVR9vGiKClKAGZ1friwyX4SOiS6Q=;
        b=mUQNuZeqOoGH4GfrfRCdP++osYGRfYkalbqlGbZbXTFNwksp+x0CI6rzxitwdz4/Pp
         SvPbAlqrEZL6QkWYQ6Ulbqirh6LSAqfw9fNquOTkc6rTOX6PKPlk68tHEdxlCmOiHKD4
         g9kGB4ZHl9t6h/DEEtDafghs3E+/Ecn8MxTKdUbC4gVCJhluwgpeg+1WcWgnpahzq2jO
         CfGn902JNm0N3vutcKLoxGSyHkRKk6bVEEyw+6lg5IrSCTgkLtVp8RuNEANMdU4yLqf4
         9IX+TRASxKofbpS46U/NuKTkVL1T51YoLdYI7ObTH2LqKFhiZ1rkm+5ED5xFvAVoaEK3
         kK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695252429; x=1695857229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9KM+06L1WVltQOADVR9vGiKClKAGZ1friwyX4SOiS6Q=;
        b=s5DA6AD/mcZQhh9wnd2409A4bEB7/s1HhXiNQSvV2QjH19d1SuswcVAl0g+ZkDasAv
         yZTW42pR+oGWWLB7YNyQ0hyT4bXqBP6dZoUGetMuW+bb7TcpKYxz6Npty8IbIKwS/64w
         mdzwaEP2TwjdL6iunGgMUsY9/sHx+AxW4sLWDOickLOzLSEheSuAvy1cPkSFMfLT5SId
         +WeaxTrQWWpSac74/m+M+ZsSN9fdhQgkK5f7E3kQ8G6PJNdOJMePD5FysaFHScp1vgPy
         YLcZdQjGkv9XWoykOhkeQncgGPsCWeC3WrFPW0RPbp8QwvaEiyUc3cYWqxG2Ym9VgV7G
         w8ug==
X-Gm-Message-State: AOJu0YxcqHKVGwYkPvjMDwngBdhJwPReQdjQfE9E9st2q42bTmXeb77Z
	Sv0JjfwXwKAMxIe8Z5FJd3I=
X-Google-Smtp-Source: AGHT+IHIVOLNB4cPjcMmzRdgEer/jGfL/OSUHMWg+7Jjr1WIUTngl98zMvuyvJvjLWvGYgruxI9Gjw==
X-Received: by 2002:a17:90a:c7d7:b0:274:3d7d:e793 with SMTP id gf23-20020a17090ac7d700b002743d7de793mr3976410pjb.47.1695252429314;
        Wed, 20 Sep 2023 16:27:09 -0700 (PDT)
Received: from john.lan ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id mz6-20020a17090b378600b0026b12768e46sm115362pjb.42.2023.09.20.16.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 16:27:08 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: daniel@iogearbox.net,
	ast@kernel.org,
	andrii@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 0/3] bpf, sockmap complete fixes for avail bytes
Date: Wed, 20 Sep 2023 16:27:03 -0700
Message-Id: <20230920232706.498747-1-john.fastabend@gmail.com>
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


