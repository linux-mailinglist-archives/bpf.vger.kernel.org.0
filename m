Return-Path: <bpf+bounces-42565-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286F09A5923
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 05:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C78C61F21DAF
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 03:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45901CF294;
	Mon, 21 Oct 2024 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOgCYaeN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEFB171CD;
	Mon, 21 Oct 2024 03:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729480352; cv=none; b=uOAOjXy/xrDrDOPHsihhxhpkkXxwGY3p5EHjosuiWhpKsezKIaGuGHnkDM3xDLi5sylHgKhgmEg3MH/s2Ss2hgvFt4A5VSFLb0nfnPfcQtaae0JFwnA1PhjJ0mUyI7PiIWFPMPXQo35eilvhrJfM1kdahpp7LsCjQWVHGIBZXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729480352; c=relaxed/simple;
	bh=XPClw1EkUaCYvB49Dunbu6bS1sg4lNSa8+skiZQbTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e7lDNTCM270gJJNaWPuBeYGuYRfR/1t1J5HE/p1y5cp3SZQbrYXzxaVMtDvkEVd8vaMFvuMMfTUsLickVMvhL7LqUjUNoCJ84TOKPfU1fMk1YNMDE1zAIGfTjBH2vFQFOvrUnZN2SFGnnkCFd4uFZDohZFNssUX9upm54HBpMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOgCYaeN; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso2889325a91.0;
        Sun, 20 Oct 2024 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729480348; x=1730085148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e5LuOh/rn5jw2USTpFPLEXHxUFS/M0lHLEDz3q66OdQ=;
        b=kOgCYaeNGp8fOMS2HyyPMVbdMQG6HsKNcaVBR8e0z6EOlMQnYX8ggV61UEyoYSXL2l
         C5zt8FvIRBMKgrqmxBAjJqmd1zXCj2RE1fI0Ke8BVC4RlN6PWO3XV2+Gbpb4JUxPULQK
         7P6yGDbFSo1u7d7+WzUSwZuMgBpoGL/ADdzC93vShm/yyyGATJYC3i3WI4kteyyxct79
         BG0WtsmYGYK6bEo6+hqQw7eNI/oKBkRWbkPO6OpIh9SXrZJlX+A371aRgdkHROA06i6c
         WIDIBtW7dSxnHtlZnm4nBWic/7i8kbrer5i5cGSh1hsy4EQtvun5hYXcmPARjQqL/tci
         Rzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729480348; x=1730085148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e5LuOh/rn5jw2USTpFPLEXHxUFS/M0lHLEDz3q66OdQ=;
        b=ac+pv8RzRDooBLZL8/hcKrKVKAXwXhjcAZnPAG5SRll5q4Sutgd3CrJISvsK81JETL
         apET9dEyT7I6ruV/CV/0k++A2UybitOn/jwwag+Z4VLeD2tc5FUoOyKDK83n5Weos0/Q
         aOLqRKR+CcIz/1HU38eKZW4Z/ulcFVGvuJsw43Pm4RQziT2zDNksrn6dXqLf6rZ8NT3E
         sSsXk02tTnT+qDB6QY1m7G9cLttlgi3fBUsnKAfegslh4IfKKCpw9+ZLbNCSYe8pSUE+
         sIar85rbwx4FfhbYGU4QJ5rs1IYvr3ftuahdNWJNqwAECjYeDnIdvDWluRAdmP392pma
         FYdg==
X-Forwarded-Encrypted: i=1; AJvYcCUwkHy1gRqutUGTiQhr2w8f7OtXaHfUP1IzV60qkC8MPn5Dy7KvuQY6sxPuycxLLp4a/x8iKAOxzeC/@vger.kernel.org, AJvYcCVY3K3ChIW7qa3jUTuVSJuTtbmvcHIj00esK9NPguv3nyeIC62RJMs4YlSZwvyT+OX8wHsj9Ld3gmAOVfYl@vger.kernel.org, AJvYcCWcPLYJQYIMSMaoViVACDosA2nRHCs8KV+OBemOb+9Yig2A1LYt8pZYxis6qg/LrCAH7Hk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfarNj2sYll9P32Mbb3BNyfhlzWJZ9Cw3a81+jiVe3nXDoDM/
	hBpPIl2rXWRwZ18++iS1qbY9t018D1Mj23eITNKBUfY70hg/VV77MrMuoG1qUpw=
X-Google-Smtp-Source: AGHT+IG8V+B74M/AcZzbX5wyQnZOR31Yw/bTJyVewRkfJvdQ0Eh1MGiz9Rk/P6YLntko9JuvWikwKw==
X-Received: by 2002:a17:90b:f87:b0:2e2:d821:1b77 with SMTP id 98e67ed59e1d1-2e5616509b4mr12108170a91.24.1729480348375;
        Sun, 20 Oct 2024 20:12:28 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee658esm16377845ad.13.2024.10.20.20.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 20:12:26 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrii Nakryiko <andriin@fb.com>,
	Jussi Maki <joamaki@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net-next 0/2] Bonding: returns detailed error about XDP failures
Date: Mon, 21 Oct 2024 03:12:09 +0000
Message-ID: <20241021031211.814-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Based on discussion[1], this patch set returns detailed error about XDP
failures. And update bonding document about XDP supports.

v3: drop patch that modified the return value (Toke Høiland-Jørgensen)
    drop the sentence that repeat title (Nikolay Aleksandrov)
v2: update the title in the doc (Nikolay Aleksandrov)

[1]
https://lore.kernel.org/netdev/8088f2a7-3ab1-4a1e-996d-c15703da13cc@blackwall.org/o
Hangbin Liu (2):
  bonding: return detailed error when loading native XDP fails
  Documentation: bonding: add XDP support explanation

 Documentation/networking/bonding.rst | 11 +++++++++++
 drivers/net/bonding/bond_main.c      |  5 ++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.46.0


