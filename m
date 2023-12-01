Return-Path: <bpf+bounces-16343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7260480020A
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 04:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3470D2814A6
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 03:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A712566;
	Fri,  1 Dec 2023 03:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hu1+ftry"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7598C12A;
	Thu, 30 Nov 2023 19:23:23 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d858670630so67245a34.0;
        Thu, 30 Nov 2023 19:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701401003; x=1702005803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHfeAVzS+R3NVvCA9s4RnI0ZiifThPmQ+ZB1tziOX5w=;
        b=Hu1+ftryIqYiiAQxFVjyppzsbRMMFg8w3ooGdm43+hz3PA6bgSl5gCXq3Ba8E4SsZV
         Uy4zVYJe2PYXloL4FJURE4WeR3ClsBriLtQ0e3/XFoFFgRBMFzivFbC0lAnZDF0BP8mE
         s3woJ+LY5cMq9kvKkgI0fGtlZ6xdbPMItCywVyY909iQP39fObstdOPzS36aD2OzA5MI
         c8UwB8y1JWVzWzFdskCEjRmtCwocHkeTshGnAEu0tHlKmJ5eIyEDWREVCyixMrvUFaEP
         HpVTghHd+XIBCvGswevifaD7g+aTs1dz4YetDF7NuTOVgo4qdowbyI+g2a06pPx5zRFL
         ExXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701401003; x=1702005803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHfeAVzS+R3NVvCA9s4RnI0ZiifThPmQ+ZB1tziOX5w=;
        b=mRPomSzeSj2EvI/ePj8Pykf704UXymE9Yab6Dwj1TEN7c77f8nkxiDThZqSfz5j5Da
         gzLTgYJ4nUpUtS7NqAPp/8HrUum4Z1yY6nfNgM3/CtPKBnEYCIKZA+0cA3RvBa+XxA2E
         It6vzehjLhZ1tr5fJmiLK+rmU2XHKar4OnP+eah4DxeqKnz2xQxDCtDuX7k0qZuu31IM
         koxPyqLDEyorKiVm8fTjcPnGR+kNQV8iE1maYlOVm6PFtbGuT+2fWC9gNF2XZAF6UH6K
         qUKZnFYRODRC30Yr87kh2ovlcrFUg5SrqxigadNbBU/ZfgsAHg52biCsVm1y45ym+OV9
         HOXw==
X-Gm-Message-State: AOJu0Yywclh5L2/3ehRVTb5SdzskLJAFLwgYPqdllLGs1PhzCpz6tEs0
	uUqaN2hpguRwZY9JMuxiIFI=
X-Google-Smtp-Source: AGHT+IFdxfHYbnvqG2xaoeBGJDItucKuZylymFlji0d94U7L69LnZVd8fPUounKa6OREtbaIxcnYTw==
X-Received: by 2002:a05:6359:230b:b0:170:8f0:c6c2 with SMTP id lk11-20020a056359230b00b0017008f0c6c2mr878001rwb.21.1701401002656;
        Thu, 30 Nov 2023 19:23:22 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:1053:7b0:e3cc:7b48])
        by smtp.gmail.com with ESMTPSA id a13-20020a65640d000000b005c60cdb08f0sm1768136pgv.0.2023.11.30.19.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 19:23:22 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: kuniyu@amazon.com,
	edumazet@google.com,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 0/2] bpf fix for unconnect af_unix socket
Date: Thu, 30 Nov 2023 19:23:14 -0800
Message-Id: <20231201032316.183845-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric reported a syzbot splat from a null ptr deref from recent fix to
resolve a use-after-free with af-unix stream sockets and BPF sockmap
usage.

The issue is I missed is we allow unconnected af_unix STREAM sockets to
be added to the sockmap. Fix this by blocking unconnected sockets.

John Fastabend (2):
  bpf: syzkaller found null ptr deref in unix_bpf proto add
  bpf: sockmap, test for unconnected af_unix sock

 include/net/sock.h                            |  5 +++
 net/core/sock_map.c                           |  2 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 34 +++++++++++++++++++
 3 files changed, 41 insertions(+)

-- 
2.33.0


