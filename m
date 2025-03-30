Return-Path: <bpf+bounces-54894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BCAA75A09
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 14:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AE5188AA47
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7671C84C2;
	Sun, 30 Mar 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ajuZnd2I"
X-Original-To: bpf@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91401E4AB;
	Sun, 30 Mar 2025 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743337435; cv=pass; b=EibKlTEftm1etMYaYCu36g6aJ3/0sAXidgTx4AfEOKCne/lDJV0KdyQfl04y+zWh6Lrg7uaIy3ErjXnlYXq9Z+3/4EwSrPldnSHFscmivFUHsCVXOGrb83bCEdvlRDdYrU69i4ntyUfKqDpGYfGirnFnq8rcDWbuOYrrz2LtCI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743337435; c=relaxed/simple;
	bh=ciQCZYDP5IudoA8C1eEI85XEk06kL4SqnQauJkaFYvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0OGAr8fvdTPd9bg8Yp6a2+pv45TYPS2HmlDyfdCcRhajiNjJy1pzsuO2Ip+XnC6iPdmgXSFs2ox/WuNlo2eV8fs53j7+v2nnmW1hzKOsQeX1ypecNoG+O0BvYmgwP/Ds6xwZHLbR2XCfi8MYx5vIeAIRUZinuRSfAwG8b0uBmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ajuZnd2I; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4ZQYMh4jfHz49Q3P;
	Sun, 30 Mar 2025 15:23:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743337426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jHCw7NZszrdhaxHKTfyrVS1xQZzZ5YYR43DG26xCGbw=;
	b=ajuZnd2I36OEmIXY7q+mHRSCisffzhREWnoN40bsCZetnnEZT1P4Pggk7jzpjgoyHfHyKW
	ekRCQy33oewZE5M/b4wC/ZuSvWS/It+7pvDEP7vTzy0IMkT9edCDGmmxOZlsI94NWzlOax
	N6KtMt7NYrswilNjBJZIKMZHsdfUDDv55y2gkR4NVGAmBYQVNnN1Y8WLGVRBANI8+Q7yZh
	+nkRqB9hD5DTwl/XDLX0om3HDmX9xFDfKhvnOMIQXPDdXuCpI8nT0R8hFGc8ri1ObZI7Hm
	pRC0ZSn3yJKCH5nVuTR1ODOk4KUBXKAnSz6hJelopmq0d+wMhYisoEv681WR9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1743337426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jHCw7NZszrdhaxHKTfyrVS1xQZzZ5YYR43DG26xCGbw=;
	b=Tl3Gi70IBehBwMmfxu5vdGlNIWXKk5qRGEUxjDhQ6nbbDQEiBynucvWbcyLAehdELWkFYc
	cM8MHHP8lLRfGK0trFsxX67J/RQiHvcw/PB4OD4TCrZZNQ0lUfn4mGVggWXik6cJqGsVFT
	MCRxFWeON8vGhr1efVQHEaNBo1GcIY/vtchYVdNjtAsYGO5X1eE8d32YezIzBw8PBCDFDU
	SQxT+u7bZg0L9vVwHq86SNLZjKKfgL5nQUHp/kt9yCd4Zu/mDYI3W6jDqD4K/Rd8y/KqwK
	6Ubrn5+brETSxuciX0haOlODi/fXpWPNC5miiBAqiv7rJGbWGpTRasGV+4LvLA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1743337426; a=rsa-sha256;
	cv=none;
	b=XtQ2zEkgfMjVXt5vNKs14KyNKJVvvfYNUvxYG+uUAF1UuWiIRKxiM/f379tuVMT6IWn9Mn
	JtCPUy+XnHuf9+5FkJ77HjvmAkDf/grDVhZsmsY6Rzl9Czs8ZUdIXFzBH9EOk2oJbmgBsk
	LFL4e/Sj/ZsUsRFspAUpaP1oke9BIaYVdW2lf3jEWB5DvxJujnjOyTmUbQXCf+JuI2pNyu
	R+9dLJdKKoLHKNQiLryYbwchvoXj04gdosHxBTDO+znQ4jaC8Y5RLm0pz+rjrWouHItMXk
	inptxvvZ5Qj9Ley9lqFEFRDWwS/ixg14WwqFHNlDtK5vsv5ySydHuZEknVxzUg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	kerneljasonxing@gmail.com
Subject: [PATCH 0/3] bpf: TSTAMP_COMPLETION_CB timestamping + enable it for Bluetooth
Date: Sun, 30 Mar 2025 15:23:35 +0300
Message-ID: <cover.1743337403.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_SOCK_OPS_TSTAMP_COMPLETION_CB and emit it on completion
timestamps.

Enable that for Bluetooth.

Tests:
https://lore.kernel.org/linux-bluetooth/a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi/

***

However, I don't quite see how to do the tskey management so
that BPF and socket timestamping do not interfere with each other.

The tskey counter here increments only for sendmsg() that have
timestamping turned on. IIUC this works similarly as for UDP.  I
understood the documentation so that stream sockets would do similarly,
but apparently TCP increments also for non-timestamped packets.

If BPF needs tskey while socket timestamping is off, we can't increment
sk_tskey, as that interferes with counting by user applications doing
socket timestamps.

Should the Bluetooth timestamping actually just increment the counters
for any packet, timestamped or not?

Pauli Virtanen (3):
  bpf: Add BPF_SOCK_OPS_TSTAMP_COMPLETION_CB callback
  [RFC] bpf: allow non-TCP skbs for bpf_sock_ops_enable_tx_tstamp
  [RFC] Bluetooth: enable bpf TX timestamping

 include/net/bluetooth/bluetooth.h |  1 +
 include/uapi/linux/bpf.h          |  5 +++++
 net/bluetooth/hci_conn.c          | 21 +++++++++++++++++++--
 net/core/filter.c                 | 12 ++++++++++--
 net/core/skbuff.c                 |  3 +++
 5 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.49.0


