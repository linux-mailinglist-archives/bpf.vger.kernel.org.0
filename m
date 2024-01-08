Return-Path: <bpf+bounces-19184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C8826FC9
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 14:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74791283F65
	for <lists+bpf@lfdr.de>; Mon,  8 Jan 2024 13:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8B644C88;
	Mon,  8 Jan 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c8dAfCnB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C7545947
	for <bpf@vger.kernel.org>; Mon,  8 Jan 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso20027871fa.0
        for <bpf@vger.kernel.org>; Mon, 08 Jan 2024 05:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704720513; x=1705325313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sco4sEDs6EsKckG3FD7UcMdAk1R8m2xFgD83ISQUjRw=;
        b=c8dAfCnBASjgQNzXJVhuCItBJK2KGEcNCQx3LXIFFnl7RBHxYds/9/83uaI6PfdrI5
         5uMLcnuvzlfHt37ddXaequEf3pLCybYTKx90RmGM5mPVMdVWT1HOjKosEKBSah9D6A+/
         raaNV6grBo8fB0mUoe5wGbnWDp4oTtCZbMBL+wUxLl+9EzUgW8OiNRZ/c4nQTCeLkvWn
         zp620Kz+Whv3Kk6Uec74EFNN9HhnsRXJRdceQmTKieMejV0bW5vYkBl4tDHy/Vpyo9Hr
         lA3ImPpu1swlx1LPo58wFxgJg+2NQfGbDCJ2wDYLwbQOSG6g8od73ttPcr0RIVPy7uqc
         2/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704720513; x=1705325313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sco4sEDs6EsKckG3FD7UcMdAk1R8m2xFgD83ISQUjRw=;
        b=iGxFMXbsXg6iG5kfTxeA6ibtNgy+6bxlFOo7I5JTdIl31JX2UZBpcKdNzP6I/ZDSUZ
         pKpz34hPoj5eTpJ0tRgpO3kC5ciGD/M3ekJMVVydW10jn3HhgsZ6VZGq8dW/QGyGnNMG
         jXHG8jYuhH1kmo60f/L2/L7fdI8riBGYHZOnJ38RZuY6yvHOO2TPV4CfRRb406vcA1YF
         DM4RXTVfXPbniOi0c5UvrsVnqi1EPvr4tFpwld64hXnfDlPr8zS8ZarZxqgvgSV3SRZO
         CdhYXnXkShc2OQC/M4tWiBwhQs+l8mqUYsc4jvaILnnvtnWyymHbpDvUPAjDKZ5LbIoX
         lgqQ==
X-Gm-Message-State: AOJu0YyL6oi81lawPH8yjJ2QnzWivzxnO8FnFRH6BPziuJ+BP7zll5Lg
	c/sLtybj65TG0Bxl8m0egXySK3Yy+hI=
X-Google-Smtp-Source: AGHT+IHHMbo3NKlYI+TtP8krpBX9IEkdY5pN7Pmpnjx6aerMpwIympWrZwEYc6HdSYxb8XYzI5l9Hg==
X-Received: by 2002:a05:651c:1a2b:b0:2cd:52a5:88f8 with SMTP id by43-20020a05651c1a2b00b002cd52a588f8mr942207ljb.17.1704720513347;
        Mon, 08 Jan 2024 05:28:33 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z3-20020a2ebe03000000b002cd3e2fc054sm1171458ljq.57.2024.01.08.05.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:28:32 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	zenczykowski@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/3] infer packet range for 'if pkt ==/!= pkt_end' instructions
Date: Mon,  8 Jan 2024 15:27:59 +0200
Message-ID: <20240108132802.6103-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As suggested by Maciej Żenczykowski in [1], extend try_match_pkt_pointers
to allow verification of BPF, generated for C code like below:

  if (data + 42 != data_end) { ... }

Also simplify try_match_pkt_pointers to avoid checking both
'pkt <op> pkt_end' and 'pkt_end <op> pkt' conditions,
as suggested by Andrii Nakryiko.

[1] https://lore.kernel.org/bpf/CAHo-Oow5V2u4ZYvzuR8NmJmFDPNYp0pQDJX66rZqUjFHvhx82A@mail.gmail.com/

Eduard Zingerman (3):
  bpf: simplify try_match_pkt_pointers()
  bpf: infer packet range for 'if pkt ==/!= pkt_end' comparisons
  selftests/bpf: test packet range inference for 'if pkt ==/!= pkt_end'

 kernel/bpf/verifier.c                         | 112 ++++----------
 .../bpf/progs/verifier_direct_packet_access.c | 138 ++++++++++++++++++
 2 files changed, 170 insertions(+), 80 deletions(-)

-- 
2.43.0


