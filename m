Return-Path: <bpf+bounces-62101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D5AF13D6
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 13:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC174A22CB
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933426528F;
	Wed,  2 Jul 2025 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDUC6DtS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA50264A89;
	Wed,  2 Jul 2025 11:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455705; cv=none; b=nlkdU9ZDOVnLrnX8LZ5OvW/dWu87got64PI750X1qBTV33R+x//1a9lS+Js3OU1Ggo/8FaYmpMB2GAgKrj2gSqt/0ElJnYwjultR4+c2XdDANJ9pmjb8z+Sq/JlbWHrn1XNXr3kdvTQ3r5ibGoVowSks1g9c93FIo6riP4dUW5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455705; c=relaxed/simple;
	bh=cuJEDseH+ePnTYWZn5hGmOfFULi0fDq2SGi6I9iKOYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SCzEhUp0LRrop1WWhbxPc4zXxa/U9BXEeQ6Z6tr26yyWcHWNM/0Ui2oPSvgdIg23ZaxqeHB1OGsr95v4bhRfmFclvwdpyLMV/aDtLFoD09WuUURouzBUQhKv0q1+lSeGaq4cFJeQwuDeXA/Q6wc+8F6rcb+4bwb2pIPqIGmGzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDUC6DtS; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so6607014b3a.0;
        Wed, 02 Jul 2025 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751455703; x=1752060503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1WpUV8u4NxOiMq2eoDoUPbd6V1d4h1oUvxI5jPAdS2c=;
        b=bDUC6DtSH+O72yxHouf+0lTmVNW8ZqgA6Mnnp5GT4miPkccK6Gq2PhbV8tJEkUO5i0
         68Zf0KHA8XCIcuGsnB/jaiSKQXZhF199eUDBwEGrGBONhLnIaXc8C6xxoUBM6xxuNVoT
         /NM3irSnI1cfFmKnaanexELpzDPWujm5C6Bg8Le4cDxFtIaz6R36DKPFP4ltHgJLRe3+
         +MeO97L9O9RRISOe/VZP4R7/Dcs6IUHT+IaMRgWg1VPBnfPwSG8YW+neCcdl340DxXcm
         /bdlxD9lML0oz5DEKk7dlNIn38ZStb8p1o2kryunEfMR4NzKUh1IhgsIDzA2RaiYD2uG
         NCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751455703; x=1752060503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WpUV8u4NxOiMq2eoDoUPbd6V1d4h1oUvxI5jPAdS2c=;
        b=MZQVqdU2h0KROEd0W7v8Bqr/l4Z/xW80BzwbMY0isE3hZq3y0tNYuiCmT+xhALimNl
         bq1hEgVu8b618VxrS0aBpbJzWi03DBZLTiJqhS+1LXcCHWaKhU6xJHqtdlZ3Weo06BJv
         0JKYvvr3LCzfl7P9Ln2OgsxCwpmoLBFnQTFrE60lbTOWoy6/y+WeJ5AESp/Se0DNtO4V
         SMegLm3LgmnBsTL2nQ17UsrvVX0IyCdj6pIq7SBXswoyw4ei5o53t8X5K5Oa/GKbJTTG
         rx7Rz588y41/fxforNFDuSUvljVwdyHSglXq1mYFfkLiWD7uLAPPJ7pgjqlKcdKMa9Aw
         7rrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8FbTtdR7I6Arc5RuHskmDvEBQl6+UVFZtaYaa2uWTpGRGLLC9r1LIXcqEXP9aLBv7U846fjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5yKOFZYrVva1G7yhw5z0eLm0CTxFSePW1Aq2xOHT0fqlrz9CX
	PLatTvJBKVbJ4Q9wqVsGtJhSBtSXhMF1GZCcocKN/VLqAr41Xp+wTX0A
X-Gm-Gg: ASbGncuRuPk7erInohwdP31i9/LcpDVTmg9BN76zBn5JuMO0wlYLtGzEcM/JsRIRW0+
	U8ujRkDPHu0cLbQYOyqbOfxQIP5uk1H06uwYMYSwkRSDwPAlBT8nMlqy89VM9dHN/w5p14z8cG9
	fjSFrubujG48dqRxJ9dbKksPP9KadKSHfdu1vh3epUAC/FVuIpT0iNbt7/XSWEOymQNxyL3+wo+
	uoQ7oYDZ32OJSiKqYNuzaPsDfcJtQwSKqLxA1RtIfh7kyq1yFHqBTE4VshMSqtIk8gC9hMlcMBX
	V+r+PWQkS+2vactBd24OHJpTaeyuQNQ8B3tmnbPQXyZHhQ8ZgyLunstwTFbt2XjoagKHzo0HCLm
	8Gi615kyrmqUHwHuo0F3OWLkTqcNRHU3jpA==
X-Google-Smtp-Source: AGHT+IEuKJMB7P0dheuXln/goTXD7Wt0iEi/jUqfDNzMisoj7452cSUMQwJNfzbNvjQZNjJsyEw4Qg==
X-Received: by 2002:a05:6a20:3d86:b0:21c:fa68:9da6 with SMTP id adf61e73a8af0-222ebb27ad6mr3397909637.8.1751455703373;
        Wed, 02 Jul 2025 04:28:23 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af57f7e6bsm14437529b3a.179.2025.07.02.04.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:28:23 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	joe@dama.to,
	willemdebruijn.kernel@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 0/2] net: xsk: update tx queue consumer
Date: Wed,  2 Jul 2025 19:28:13 +0800
Message-Id: <20250702112815.50746-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Patch 1 makes sure the consumer is updated at the end of generic xmit.
Patch 2 adds corresponding test.

Jason Xing (2):
  net: xsk: update tx queue consumer immediately after transmission
  selftests/bpf: add a new test to check the consumer update case

 net/xdp/xsk.c                            | 17 ++++----
 tools/testing/selftests/bpf/xskxceiver.c | 51 +++++++++++++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  1 +
 3 files changed, 61 insertions(+), 8 deletions(-)

-- 
2.41.3


