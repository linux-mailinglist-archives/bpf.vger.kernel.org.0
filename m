Return-Path: <bpf+bounces-73897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1F4C3D3C8
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 20:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D764A3B3D95
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 19:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E1351FAC;
	Thu,  6 Nov 2025 19:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cfY17JF9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C9333FE36
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457294; cv=none; b=F8s/9uJA5KLWSittP02D/JnTO5lxme4rfzgEQ+2//cZDLuGafVGzdOwKEDDmCQKB0soDwojG8W0Mi5CDlZpuyu5n1QOc/xomk/IxheMAtH85FL4BDwBCpZslhLgn2nx76HGKzkarcHZF9LkVJoqFv/fbU2dzm+XpYdYur2F27VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457294; c=relaxed/simple;
	bh=TdRMNwspcVJ9kQA7zkIsefuyLgLFgUtCg/5v+XUh9PE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=c+hMLoliaPcVnwlYDByb9PIsvceOCndfNQ5z6ys31tHXXPxIrrIFI7KmGn78SyAMu6+RyT9fSD+9l89sf7aIjoGJpET2wjcinlU0aAr9D2sG3MRo7qw9x1mQyz7xBuVf4UUpWJvyNOIYG9TY0TDMoQETDYR5F75horgAcScdu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cfY17JF9; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297b355d33eso7656645ad.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 11:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762457292; x=1763062092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lT5KwAqbRWF2gKeCcm90x9U0pAstguE9kqlPXu7sP/w=;
        b=cfY17JF9ssxecV4kLKXoRhdXPBoI9G+l+zAxRFv7aY6Amr/8a9ShiP3JpmREp8MuM6
         Uunnvy6IbO9QMr6SjDAzRDMFTyRQDNpWTk0tADsmcgQQCixt63xmAo39e3eXW9qhW2DR
         366tR2eaKDPUvqc/6POiQ+v1BrVmIKgQKNiKb+Y5EQy+q6IwFxX1ATLG3IgAbToCXu1Z
         jQbZesm0kP/5aHpHMnhtbrE/qtIVcSRxHIjHo4A2cBMvK/30CWb/eZO9C8JnVsFrFhZ5
         sT6cxMFT5r0DfPUfbOib57URxQOxsUAZZy7opON1VOtiLhSM5FradwPgAgOIDqJLdcOC
         mkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762457292; x=1763062092;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lT5KwAqbRWF2gKeCcm90x9U0pAstguE9kqlPXu7sP/w=;
        b=DJfGhZtMiypaEHJfjzoN0UbZJa15OseS7TSyt/YYcpXRh5ohgxPtZ55dqg90Sodem2
         9zrhh1RwglPDx7ZBmuo61ePfN5ngH9hQZ3isehnaCPUgPE0udT9uJmpNcop2M1Ilq4MU
         Y+NsgoIQnaoGLHVhng5XNfn6sae343U5IOddovyT5TbP2VM0Kg3YUnCCslmcqii7OX3d
         01ArO9bCseHnsJTeUOk9X+REluDfCnFiZYZ2TZJHkRCz/zY4U+VLeNlF5Y4HYwD0Mdw9
         +3RKuwNyjavi1zhUzja5XgvHczLrXPzB7XS21R8jyiqbbFZISgVCDcFFVxkgclCJ1P/2
         2Cxw==
X-Forwarded-Encrypted: i=1; AJvYcCUsOY65DoApgAQBQTC9iCnS7GGRLyDc6WfQgDBnMxY2QVXDthjCS2rkolrx1e+ntm+3CZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+84Ni7fkXZcf54NlV+WHsROhpcScDs1P1ou+f4g7DeLVBhnpS
	1N/xhj/pDcKFQ5TbhQmzspQczZS5XCBV9nwbiV92dVH1459owlRszJK6+m6POIYUgm9Tec/GTyy
	puZoxDgh1C7zgeA==
X-Google-Smtp-Source: AGHT+IGU5eYghBMAuYSLi+iZWooYj6gGPgwJCh9MNZGW+OQvjpn9F9Uz5fs0kPjXRt1fiJcT047jO+nQxDdkIw==
X-Received: from plok16.prod.google.com ([2002:a17:903:3bd0:b0:290:b156:3774])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f644:b0:267:f7bc:673c with SMTP id d9443c01a7336-297c048f427mr7510825ad.44.1762457292164;
 Thu, 06 Nov 2025 11:28:12 -0800 (PST)
Date: Thu,  6 Nov 2025 11:27:42 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106192746.243525-1-joshwash@google.com>
Subject: [PATCH net-next v3 0/4] gve: Improve RX buffer length management
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	John Fraker <jfraker@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Ankit Garg <nktgrg@google.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ankit Garg <nktgrg@google.com>

This patch series improves the management of the RX buffer length for
the DQO queue format in the gve driver. The goal is to make RX buffer
length config more explicit, easy to change, and performant by default.

We accomplish that in four patches:

1.  Currently, the buffer length is implicitly coupled with the header
    split setting, which is an unintuitive and restrictive design. The
    first patch decouples the RX buffer length from the header split
    configuration.

2.  The second patch is a preparatory step for third. It converts the XDP
    config verification method to use extack for better error reporting.

3.  The third patch exposes the `rx_buf_len` parameter to userspace via
    ethtool, allowing user to directly view or modify the RX buffer length
    if supported by the device.

4.  The final patch improves the out-of-the-box RX single stream throughput
    by >10%  by changing the driver's default behavior to select the
    maximum supported RX buffer length advertised by the device during
    initialization.

Changes in v3:
* Removed newline from extack message (Jakub Kicinski)

Changes in v2:
* Plumbed extack during xdp verification in patch 2 (Jakub Kicinski)
* Refactored RX buffer length validation to clarify that it handles
  scenario when device doesn't advertise 4K support (Jakub Kicinski)

Ankit Garg (4):
  gve: Decouple header split from RX buffer length
  gve: Use extack to log xdp config verification errors
  gve: Allow ethtool to configure rx_buf_len
  gve: Default to max_rx_buffer_size for DQO if device supported

 drivers/net/ethernet/google/gve/gve.h         | 12 +++++--
 drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +++
 drivers/net/ethernet/google/gve/gve_ethtool.c | 13 +++++--
 drivers/net/ethernet/google/gve/gve_main.c    | 73 +++++++++++++++++++++++++++++-----------
 4 files changed, 78 insertions(+), 24 deletions(-)

-- 
2.51.2.997.g839fc31de9-goog


