Return-Path: <bpf+bounces-61505-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A2AE7EB8
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD5D2171175
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE229E0EC;
	Wed, 25 Jun 2025 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GerdQn1n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3A29CB5A;
	Wed, 25 Jun 2025 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846227; cv=none; b=Xcwwpq48Mc/bvc+uNqntMo7DDrZj5siL80zfiquy2oQv3HfiLhPqpJ1q3fYKqS+k437fZq3tr1PHtG81/ZfZ01whUKzTpQ7oziHZqWwmRe53MXaQ+SAjpVWumCIauOlufHoN+MdScp9M6rbH7EFmik5wfssjUGonAO84gZnwHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846227; c=relaxed/simple;
	bh=SnMF6+mz1nF2E+YRW5/AkEU84EPBVwPu2NzXR5bmmvI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jkL3CI7okpbzZIdCla94WcE7RhoZ17+2HOVKFqp5uXQhWXILWazoEQeAMZM0MhBuX4jc/Jq1zItX4ldNaLTNLEAuIB+Zh3trd1xuSSkYpy/+ruBkGF+a3R1Sovm00t6OFGRtJ6bIZKIykDmYmx05uQj1OiAZRzp2jHESW8lX10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GerdQn1n; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so636186a91.2;
        Wed, 25 Jun 2025 03:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750846226; x=1751451026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t14IVCWIL6UwGFpbstnKzIoJsAN1dFHEc5LI7VsNxvo=;
        b=GerdQn1nPcNv9orraDgGO417fjhv9AizRg/vVAwkQ6YoYC5meAhmG2Z/zK2TmFlhB+
         ArGMeUTdU+efwDmy7FBdQ1oC/VwTFSppd7MXQ4pbtTRSf5Fmt0rRgvjvdwdQ2iNlQXo4
         jLqcHToWtIW1lAm2vW4hyYTwcJ5eiQphTTcGt4KyljIgwAQjrw3YY2QzrWgoMP39dcKI
         A3a6qDaWV6mWFYdgPVP7/IxA3De2U8ym2EJbGrH1/qQNBe4OMaIENL6hjBCoDdxYVDPu
         vAYLZqL7DZ6jcARCF1LEIj36bcrpopQgG3iRnI/DfXukwRWA1WaVbQ/t32djAoZViZbb
         lX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846226; x=1751451026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t14IVCWIL6UwGFpbstnKzIoJsAN1dFHEc5LI7VsNxvo=;
        b=fB5cjrR4L6LRhbrEXuT1I7DTT046snWTNC/AxM9XjllOFxyeN2L4xek3niRyqENc0i
         EvqMN3zRlZH55B04INyM5bz1lu91tu0UtuLmpMNnp3ojTkYvYQ2NXn+JfdwD9g/Dqe4d
         RykwxN7jQ+sUEqRQRpUbYAB33e8P/onQ1//5wLLbuIhzc9X5Wbo2sNQh2o86VsHrR/++
         8UDYl8rx8BiTdPYz21yb2S1eckUl0EwFOqCgqdu3OApRNau1+ZvgHjRaQe0WbOj3uaK6
         ea0qBXJ9FzPD0iEYbCIoz51Bxi00ZoOAT5oLxkcrhDv4erSdBUaGflo/r5Kgx7ChBHod
         9FYw==
X-Forwarded-Encrypted: i=1; AJvYcCWW9nwzxwQyZsQAqHIYYeFrqpPoXwGqHuWSIdXdW6SgrqnEVYUPPSCl3Tv7pEsUE5EXD9UvgZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWofZIyi/4sfxCHLob00YtyFnP73g32FoNXH3g8InS2tXdHYQv
	Ho92ocPkZaTO5zQW0WhBSxMfjkXTi8z+hyompFO6Jfk0WTT29rVYh9GR
X-Gm-Gg: ASbGncug5Kb0tGqetmYeSxSPTqJSPmJcAFeGDAXNBB8uuJlZC6KNSKFld29eVpR2NE4
	flDGQEjPMKUqAbw+3hIq+VnjSh26oInUHvxLQBy6hUQlht7SFjL/BL+pDMtmQOoEgAon8SHxcGq
	eo2Bx1DW/IPuuq2cFGekxvX9Ioy54a+ZJm3cipc2aUpQED+hvK0KvCychdk/lVLUeu9oCaDSI92
	RofMF7ySeeCm4tRpUk9msi7GJ2TuX+1C6Sa5A5wdQo5MYV+iL+yPoEgkaPA1nEuImYT3FLSCIQk
	5VmHRfcY1ub5reTZ/7LSs73I7ZRhGPt8rNSY5MiKrZEXUr1PSCzOOfDYdgz1Scn4MjfaThXhV1+
	OXqTEZ5dHs74UecZNgVkJbl7nznRCCsmo/g==
X-Google-Smtp-Source: AGHT+IHr7iNnwxcOPeQ9ZThXwUGZJ7GbcERsSUmiNLc314q/XvVhwJaI9AdDeiJGJhiQ1rxqLsxuzQ==
X-Received: by 2002:a17:90b:5707:b0:312:1ac5:c7c7 with SMTP id 98e67ed59e1d1-315f260f7d1mr3955006a91.2.1750846225691;
        Wed, 25 Jun 2025 03:10:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5437a0bsm1328838a91.35.2025.06.25.03.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:10:25 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/2] net: xsk: update tx queue consumer
Date: Wed, 25 Jun 2025 18:10:12 +0800
Message-Id: <20250625101014.45066-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Patch 1 makes sure the consumer is updated at the end of xsk xmit.
Patch 2 adds corresponding test.

Jason Xing (2):
  net: xsk: update tx queue consumer immediately after transmission
  selftests/bpf: check if the global consumer of tx queue updates after
    send call

 net/xdp/xsk.c                            |  3 +++
 tools/testing/selftests/bpf/xskxceiver.c | 30 ++++++++++++++++++++++--
 2 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.41.3


