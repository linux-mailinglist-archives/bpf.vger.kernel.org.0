Return-Path: <bpf+bounces-71605-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC7FBF7E97
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC5919A2E01
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01B934C80E;
	Tue, 21 Oct 2025 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7LGBQ3E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACF34B672
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067939; cv=none; b=GhEQFAw4ziqr7IXPHdR/QC61DXvY1IFvG/t9dta9u4UEYJ6MzxZjkwHTMmgihh+rsGNlX7iI8i1FO2TeItDZLhyypenzBnI5QJFlvPmF7l41raCtYbL2Jw/KzDk9HZTjTg7aNJ8ADQ/7vgGs5gIVg87zVByAR87e6g5lLrLY+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067939; c=relaxed/simple;
	bh=LWmEWjRyeCjLG1cMy0JCFnlQjX+UfVSwvPnfh+zdDvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hmBK/+EAbcWZdsCIrdN6mvP6yn8DMoggoNVXfjy3YtoQuu4MkiICN/WNfHzIjgl8LgLSol1fGPEd9hJMJ+lZZsx4rh2EyY8hY5Jhrx0683C9ThO6CyBdwRAHE3gPjveNjJHlSHE7WoLWASP3CL+ahLdDaRdL/8dL+uwuDj9Dlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7LGBQ3E; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f67ba775aso7636548b3a.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761067937; x=1761672737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W32bDqvyR7vujxfMeW9XwQgpRLc26l7oP7qKEtb01No=;
        b=Y7LGBQ3Eu306T0aGNRBFKPOr4ENkYud1JYkAp3ik7YU6dlFxfLIkDAM0a2y5bMLSBo
         Zu6MLlzerY683jwzk35LECn+2TaRwld2EsiyyzQYWwBzEdV3BwsQjVTOCVB+ZJjmFvI5
         T8d8jReqZy2cjlUAAUXHWjg4aj8aXH3ZOnenyS9tzrYpXtFhVl/mQ7Mvym1ZaUpKI4hh
         zXzYibJ/hCCSVdUI/PG9XZ0WmrG7arnMljArqad6w5/wvgGJKiEQmJZPsUqmwRgpROQv
         WKZeBkhWvFZOHXyd+elu00bk/qjD5aGn+kVIz8Dcp1ATnvSLVspE2hsRsGjS5QfyFlNK
         GAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067937; x=1761672737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W32bDqvyR7vujxfMeW9XwQgpRLc26l7oP7qKEtb01No=;
        b=T0iRYAqyjM+zdqUpmSNc2M7SqbfQHRMgYClvh8RSS0bsoAla+JGlN602XqkNOLKCq7
         Z2bIKNgiIBfCqjVx3ehljcDjjH9mTcCNZp5k/EFEpm+lCS75PVGwy6GhFqCwlS4Zp+Ud
         LAUbFDsZAyosnXHueqZkw+DJpLkXd/D0/Fl+jzte0X5EGKuZOMxnE1QvS3GJCQ3Zs/To
         hQYf1n7NOQ0yREPRpYQMR+eMwJuKJ30tT7B4wDbAcEe1gO+5Zn2YV/bsK5TQV63sXdGi
         0vZ0Mo5r6pbW6zAytLMQur/wS7ksp6Y59bA8RYm+melIIWpYFL2C1LOaeuOvfU0aDZg1
         2baA==
X-Forwarded-Encrypted: i=1; AJvYcCU5WvnjjblUcn0XRWbReCDKJCUFlvkmbJ+voCtpthoSWempgEHackESRm4YclQs8sLseZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGZEpC43hEQgw51HwFoGqZQxUDcG6YWgrZKXEUNpUWjx2XmqDF
	8+f4Mk1MrOUrHMx32ckzHIXKRwmsx2QZwes629oiQTNdXU13lSLBUdv/
X-Gm-Gg: ASbGncuz6swZT98DbsAUKWqwsDiN+/n8fdjkUlzULWLpJ9kcVOLE/yGaQOIWSuw5DSx
	dmNLg2vltmxY3KT6OnVfZ5Sce7JFBqiBCQtmpQ0XT7Pz7mjKoPYJAdIirhsDRiobYuet423oOAC
	KA6HGCISbNYkkVR404xJjMpGkYChzLg+t2Ad+ZgKx5xP3yRAVrfI+Hc0wlCgBIAzm5wt+pwgur5
	ZQ3Xx1QSjoL/xX+I14vmt7C7i3jwgkAr7+wUOm/XnV5jUe56pY9VZPQxNV/4ZTw1o01UC8FGn52
	aIMpvp9v9ctpD+UcrWw8TLK6v/ZcyrlmvQkEYk1dtHn5SEjiBo8bdFW2HqH8DBif0WYHKLbJF0+
	nHuoTC/ddVj4svvzRYLY4z6rtHrh04vn2aMEwuv3GhFt+G9kQZ2ZtFcoNZ82rmNWOi2yidP9RtQ
	SWxe7tlY/n6Y8Bgg==
X-Google-Smtp-Source: AGHT+IGJnLDF4X5uEtsa2xDyV0cUHKx8VFYNG1No6zJf1JQmgFUvBau7xsPVnXixxXlAbB/zCJrVMg==
X-Received: by 2002:a05:6a21:9986:b0:320:3da8:34d7 with SMTP id adf61e73a8af0-334a85661b7mr22334007637.22.1761067936853;
        Tue, 21 Oct 2025 10:32:16 -0700 (PDT)
Received: from 192.168.1.4 ([104.28.246.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b346aasm10941006a12.20.2025.10.21.10.32.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Oct 2025 10:32:16 -0700 (PDT)
From: Alessandro Decina <alessandro.d@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	Alessandro Decina <alessandro.d@gmail.com>
Subject: [PATCH net v2 1/1] i40e: xsk: advance next_to_clean on status descriptors
Date: Wed, 22 Oct 2025 00:32:00 +0700
Message-Id: <20251021173200.7908-2-alessandro.d@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20251021173200.7908-1-alessandro.d@gmail.com>
References: <20251021173200.7908-1-alessandro.d@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever a status descriptor is received, i40e processes and skips over
it, correctly updating next_to_process but forgetting to update
next_to_clean. In the next iteration this accidentally causes the
creation of an invalid multi-buffer xdp_buff where the first fragment
is the status descriptor.

If then a skb is constructed from such an invalid buffer - because the
eBPF program returns XDP_PASS - a panic occurs:

[ 5866.367317] BUG: unable to handle page fault for address: ffd31c37eab1c980
[ 5866.375050] #PF: supervisor read access in kernel mode
[ 5866.380825] #PF: error_code(0x0000) - not-present page
[ 5866.386602] PGD 0
[ 5866.388867] Oops: Oops: 0000 [#1] SMP NOPTI
[ 5866.393575] CPU: 34 UID: 0 PID: 0 Comm: swapper/34 Not tainted 6.17.0-custom #1 PREEMPT(voluntary)
[ 5866.403740] Hardware name: Supermicro AS -2115GT-HNTR/H13SST-G, BIOS 3.2 03/20/2025
[ 5866.412339] RIP: 0010:memcpy+0x8/0x10
[ 5866.416454] Code: cc cc 90 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 48 89 f8 48 89 d1 <f3> a4 e9 fc 26 c0 fe 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[ 5866.437538] RSP: 0018:ff428d9ec0bb0ca8 EFLAGS: 00010286
[ 5866.443415] RAX: ff2dd26dbd8f0000 RBX: ff2dd265ad161400 RCX: 00000000000004e1
[ 5866.451435] RDX: 00000000000004e1 RSI: ffd31c37eab1c980 RDI: ff2dd26dbd8f0000
[ 5866.459454] RBP: ff428d9ec0bb0d40 R08: 0000000000000000 R09: 0000000000000000
[ 5866.467470] R10: 0000000000000000 R11: 0000000000000000 R12: ff428d9eec726ef8
[ 5866.475490] R13: ff2dd26dbd8f0000 R14: ff2dd265ca2f9fc0 R15: ff2dd26548548b80
[ 5866.483509] FS:  0000000000000000(0000) GS:ff2dd2c363592000(0000) knlGS:0000000000000000
[ 5866.492600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 5866.499060] CR2: ffd31c37eab1c980 CR3: 0000000178d7b040 CR4: 0000000000f71ef0
[ 5866.507079] PKRU: 55555554
[ 5866.510125] Call Trace:
[ 5866.512867]  <IRQ>
[ 5866.515132]  ? i40e_clean_rx_irq_zc+0xc50/0xe60 [i40e]
[ 5866.520921]  i40e_napi_poll+0x2d8/0x1890 [i40e]
[ 5866.526022]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.531408]  ? raise_softirq+0x24/0x70
[ 5866.535623]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.541011]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 5866.546397]  ? rcu_sched_clock_irq+0x225/0x1800
[ 5866.551493]  __napi_poll+0x30/0x230
[ 5866.555423]  net_rx_action+0x20b/0x3f0
[ 5866.559643]  handle_softirqs+0xe4/0x340
[ 5866.563962]  __irq_exit_rcu+0x10e/0x130
[ 5866.568283]  irq_exit_rcu+0xe/0x20
[ 5866.572110]  common_interrupt+0xb6/0xe0
[ 5866.576425]  </IRQ>
[ 5866.578791]  <TASK>

Advance next_to_clean to ensure invalid xdp_buff(s) aren't created.

Fixes: 1c9ba9c14658 ("i40e: xsk: add RX multi-buffer support")
Signed-off-by: Alessandro Decina <alessandro.d@gmail.com>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index 9f47388eaba5..dbc19083bbb7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -441,13 +441,18 @@ int i40e_clean_rx_irq_zc(struct i40e_ring *rx_ring, int budget)
 		dma_rmb();
 
 		if (i40e_rx_is_programming_status(qword)) {
+			u16 ntp;
+
 			i40e_clean_programming_status(rx_ring,
 						      rx_desc->raw.qword[0],
 						      qword);
 			bi = *i40e_rx_bi(rx_ring, next_to_process);
 			xsk_buff_free(bi);
-			if (++next_to_process == count)
+			ntp = next_to_process++;
+			if (next_to_process == count)
 				next_to_process = 0;
+			if (next_to_clean == ntp)
+				next_to_clean = next_to_process;
 			continue;
 		}
 
-- 
2.43.0


