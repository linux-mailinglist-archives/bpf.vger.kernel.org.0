Return-Path: <bpf+bounces-34017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A7D929895
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 17:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA7961F23317
	for <lists+bpf@lfdr.de>; Sun,  7 Jul 2024 15:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F80737141;
	Sun,  7 Jul 2024 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b="cHkWayja"
X-Original-To: bpf@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571FB3CF4F;
	Sun,  7 Jul 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720364759; cv=none; b=a9E33i+kNcz3RJQc0uIert2rUsS6LO3f0zzrBzb1GOEVzaO2q2DAuoZk36a6vhpMc91eVKZidnZnFCRJyBbDXVhit6J6z1uDk5GpJ5fdjNKbs1p2fv0RpOnLafYHeDSfubxPc5zIOmoZWLa3NJSIQ7BF4ffnlKTfzjWHPhA1eq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720364759; c=relaxed/simple;
	bh=1a1z6FpMnxCEwvsCCTgn37f/h046n8/qwHQWeiOj9Ww=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=aVWeK8iB9yxLIpircvDSQ7LgiYx+xhensjPG0C2MF9vAzzcmw+uiRzC9tAJxjv9Do4AEyY+3KoRlG/7GKbMq6HpCOv6FYz2wQ1/3c6Tj3TJ6f3PFDVIBALiHpSFf5dPiBspJpolVGiWr41hiaairz4UKUzASHojA5JhRBP49tlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de; spf=pass smtp.mailfrom=arctic-alpaca.de; dkim=pass (2048-bit key) header.d=arctic-alpaca.de header.i=@arctic-alpaca.de header.b=cHkWayja; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arctic-alpaca.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arctic-alpaca.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4WH9YN1hkqz9sdD;
	Sun,  7 Jul 2024 17:05:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arctic-alpaca.de;
	s=MBO0001; t=1720364744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1a1z6FpMnxCEwvsCCTgn37f/h046n8/qwHQWeiOj9Ww=;
	b=cHkWayjaMXfzYHSicJHF9rE6pbzd91sUXGH+ZbCjiZuZq0OJA8vOcjTaO6gP2uoTRRFfMH
	+/83MtjoEP4KXyHbBgTib4H9fKJlhp2U+5HvRPVbFceWa/dOXo79zebXxvv8T350rnpAeI
	ZKZWmVQ3ZgXOxibXyxi2PnA1EBQOsW4mTGGl8Ijr2mkENblHiuUtqPwnSDMXlTnNL7K8cL
	U4ryqSL652+BvCSOD75TTBjbxrxAqYHiOHB8pPoIAUUvL8YkZlq0Q2FAzCXeGQf/cO9bQI
	0izN/6AydSyFdtoelIsWBKTlC9E3oHCOBKSWWis6tF82HA724LDkZQQ1RRQwug==
Message-ID: <2d6ff64a-5e2c-4078-a8d1-84f1ff3361ce@arctic-alpaca.de>
Date: Sun, 7 Jul 2024 17:05:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: de-DE, en-US
From: Julian Schindel <mail@arctic-alpaca.de>
Subject: xdp/xsk.c: Possible bug in xdp_umem_reg version check
To: bpf@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I hope this is the correct way to ask about this issue, I haven't used
the kernel mailing list before.

Between different compilations of an AF_XDP project, I encountered
"random" EINVAL errors when calling setsockopt XDP_UMEM_REG with the
same parameter.

I think this might be caused by this patch:
https://lore.kernel.org/all/20231127190319.1190813-2-sdf@google.com/
It added "tx_metadata_len" to the "xdp_umem_reg" struct.
In the  "xsk_setsockopt" code in xdp/xsk.c, the provided "optlen" is
checked against the length of "xdp_umem_reg_v2" and "xdp_umem_reg" to
check which version of "xdp_umem_reg", the user supplied.

At least on my machine (x86_64, Fedora 40, 6.9.7), these two structs
have the same size (32 bytes) due to the compiler adding padding to
"xdp_umem_reg_v2". This means if the user supplies "xdp_umem_reg_v2", it
is falsely treated as "xdp_umem_reg".

I'm not sure whether there is some implicit struct packing happening or
whether this is indeed a bug.

Best regards,
Julian


