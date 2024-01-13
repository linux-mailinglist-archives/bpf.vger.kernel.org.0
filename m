Return-Path: <bpf+bounces-19498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29D682C865
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 01:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19E61F27463
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32F45667;
	Sat, 13 Jan 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lY/IWkEe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED118632;
	Sat, 13 Jan 2024 00:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bc09844f29so5731924b6e.0;
        Fri, 12 Jan 2024 16:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105980; x=1705710780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rls0NJXtE5bHEdodmC082HfHwfpwWqgL9nu0PMicgUo=;
        b=lY/IWkEeJI4y+ZDwka9KPxsR0eVU3qPh8whXtQ6ug/FRCcu59xQWUlAUwHZQeqdHWg
         aTKwEGXE8HXUGy1lsFyeKTKrFo5xdUWJslrxLPYFMLLiY569XCNVuECUaYIY357BWaIZ
         80kmelUxj7d4hvA+8t4cVt7eMkvIt6ZBYohzaqRy6RJb1gVRa1BnhNKmhKoLXBZt3Xvs
         NzMEKMJsjebdQohJtYvmT23wdrgypEktw5TlnVeYKRffiQ/zIV7f3B+sIhKeNQoZQzHR
         Dir7KzEHMICq1Ro92sxLo9ZdkScEt69DvfiiCh1g0tCI0nk+rAZv3X4gfrcnax6uw4az
         l02w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105980; x=1705710780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rls0NJXtE5bHEdodmC082HfHwfpwWqgL9nu0PMicgUo=;
        b=q/jDygPyTz1GkO0qSNHXVieAWPkU1AgRl3ZE54jkt2b8uAuK8o3pOX+veuiFkDOiY7
         4nw7BhVPxe2p22NuG5zPTAR4Lu4eHISNWSRCKi+W7mhqAFZ04IJR7qBDL9ezRGyFCZj5
         nw1myzeOqTg0Znmn7DRxMh7bo19UX9tmAQPOrB/EX0ECQWJBUxTeHbRbcggQ9T4NyQPf
         L1CLw4KE8i5biby/l9rk5/EgW5cLeGrPl4tCu/eG4CIqhrjQyFwQg2/Tog9xRoFMax63
         p2UpQlQ/emsxZVqx9y3onWwmo2slh5mYomdhah6LxiYVZH17m6yOU3PjNACAoEHH+sHQ
         wnHQ==
X-Gm-Message-State: AOJu0YxOjZgoDL85E9DM86svxQYi7YVhFeZNBS1+kXcx7R41eGRDcCzw
	VCP0MsM3D4wuTC9msbo5fbHHGizgrg4=
X-Google-Smtp-Source: AGHT+IFd+S/EtOTDcY4VnhCH4ApoymbIBV6raBHUsF9r2Gno0z0I63eBH8jockeZavaz4SMgflB0jQ==
X-Received: by 2002:a05:6808:3a14:b0:3bd:5f84:b599 with SMTP id gr20-20020a0568083a1400b003bd5f84b599mr2761152oib.109.1705105980470;
        Fri, 12 Jan 2024 16:33:00 -0800 (PST)
Received: from john.. ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79a48000000b006d9b35b2602sm3707914pfj.3.2024.01.12.16.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:32:59 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	eadavis@qq.com,
	kuba@kernel.org
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	borisp@nvidia.com
Subject: [PATCH net v2 0/2] tls fixes for SPLICE with more hint 
Date: Fri, 12 Jan 2024 16:32:56 -0800
Message-Id: <20240113003258.67899-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot found a splat where it tried to splice data over a tls socket
with the more hint and sending greater than the number of frags that
fit in a msg scatterlist. This resulted in an error where we do not
correctly send the data when the msg sg is full. The more flag being
just a hint not a strict contract. This then results in the syzbot
warning on the next send.

Edward generated an initial patch for this which checked for a full
msg on entry to the sendmsg hook.  This fixed the WARNING, but didn't
fully resolve the issue because the full msg_pl scatterlist was never
sent resulting in a stuck socket. In this series instead avoid the
situation by forcing the send on the splice that fills the scatterlist.

Also in original thread I mentioned it didn't seem to be enough to
simply fix the send on full sg problem. That was incorrect and was
really a bug in my test program that was hanging the test program.
I had setup a repair socket and wasn't handling it correctly so my
tester got stuck.

Thanks. Please review. Fix in patch 1 and test in patch 2.

v2: use SPLICE_F_ flag names instead of cryptic 0xe

John Fastabend (2):
  net: tls, fix WARNIING in __sk_msg_free
  net: tls, add test to capture error on large splice

 net/tls/tls_sw.c                  |  6 +++++-
 tools/testing/selftests/net/tls.c | 14 ++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.33.0


