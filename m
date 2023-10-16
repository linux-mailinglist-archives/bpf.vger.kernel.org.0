Return-Path: <bpf+bounces-12341-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC87CB328
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 21:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33C0B20FCE
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 19:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729DE341B1;
	Mon, 16 Oct 2023 19:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/zRDsdG"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970F729425;
	Mon, 16 Oct 2023 19:08:23 +0000 (UTC)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A5395;
	Mon, 16 Oct 2023 12:08:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1c9b1e3a809so30918785ad.2;
        Mon, 16 Oct 2023 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697483302; x=1698088102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VV8+dt/ip68A0Y96i4PBMiQIDw0BzcRfF9juLacTGRM=;
        b=N/zRDsdG2NxoOtNuDEWid1QoL3KSj983EVEiCRVvT9m+EvriM7UMo0SwntXlieGsZi
         4Or4OGfeJErdGIEo+vargB8ltBxhbkdqh1XJuIjx3C5sUY6yPjHVuRTRCdwnO4NUkGNv
         WPz/i0srEx9RTd+jfEQcWqvay5ZEfBvmfrf00HuWedQJ3GQ211E8fLJXX4SynGwXudyG
         npoaQm7CDA8rFUKE+TWXeT38hQJVppYTk6y9mozcNUqTs01+n68o5ybqI1S6i0I0ZcC3
         Z2Nk+HJGwZYydpVV0YR2Tx5ZMVONJ6UmZQOfkV4rmhRnpW8wIiVdum0a1uT68PeRBRJH
         XiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697483302; x=1698088102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VV8+dt/ip68A0Y96i4PBMiQIDw0BzcRfF9juLacTGRM=;
        b=MEzNPF8WwblPupVwFtbMptDnQMONnQAhdQeg0GAe8p5JTYrykBbH5oEisHkpC2ZUXd
         5Gb4fU3FljHANVYDLXIF8ot6LQTNkrh0AaC3vdn8V0sDW8AUPy1Q35tajAUFCvYASp6Y
         FNiKcUl/YijYsa5U1wHGPlTIvoLk/gMvVOy7Q2o3yut95qw0jrZjqKL1QfH3e7qiOYjZ
         adHdXNiuiyChGealW1EebeWIc6oGiqeqYKVJ82F4ZSmg7BDClltFDShTIG3EA8VU4Nfu
         VvTeUk8wm4ddcSkYKRi3gme1v0y0p8kWXbifxD7qtau+mhrQouVDASruT970plAb0Bm+
         q2Qw==
X-Gm-Message-State: AOJu0YwCOhEPW/7bPoJdCSLBMhys2YYcd+6InIOBmhUmPHu0NWKOKYme
	ZbXuE+5vG3Ccmu/ZufDpYUNg0ye6x9Q=
X-Google-Smtp-Source: AGHT+IE0/DjL+5ScdlibMbNDXcAAq1TSO/YX8s2M4i1emEOk/NQIh+XFe2hDB8ldWV0eWaTRUxqlWg==
X-Received: by 2002:a17:903:4094:b0:1c5:b4a1:ff6 with SMTP id z20-20020a170903409400b001c5b4a10ff6mr176250plc.45.1697483301617;
        Mon, 16 Oct 2023 12:08:21 -0700 (PDT)
Received: from john.lan ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b001c9bc811d4dsm8803473pla.295.2023.10.16.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 12:08:20 -0700 (PDT)
From: John Fastabend <john.fastabend@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: yangyingliang@huawei.com,
	jakub@cloudflare.com,
	martin.lau@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH bpf 0/2] sockmap fix for KASAN_VMALLOC and af_unix
Date: Mon, 16 Oct 2023 12:08:17 -0700
Message-Id: <20231016190819.81307-1-john.fastabend@gmail.com>
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

The af_unix tests in sockmap_listen causes a splat from KASAN_VMALLOC.
Fix it here and include an extra test to catch case where both pairs
of the af_unix socket are included in a BPF sockmap.

John Fastabend (2):
  bpf: sockmap, af_unix sockets need to hold ref for pair sock
  bpf: sockmap, add af_unix test with both sockets in map

 include/linux/skmsg.h                         |  1 +
 include/net/af_unix.h                         |  1 +
 net/core/skmsg.c                              |  2 +
 net/unix/af_unix.c                            |  2 -
 net/unix/unix_bpf.c                           | 10 +++++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 39 ++++++++++++++++---
 .../selftests/bpf/progs/test_sockmap_listen.c |  7 ++++
 7 files changed, 54 insertions(+), 8 deletions(-)

-- 
2.33.0


