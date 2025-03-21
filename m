Return-Path: <bpf+bounces-54508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E11A6B241
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 01:31:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B3BF18870EE
	for <lists+bpf@lfdr.de>; Fri, 21 Mar 2025 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D6029405;
	Fri, 21 Mar 2025 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgdvrwBu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B9B1E48A
	for <bpf@vger.kernel.org>; Fri, 21 Mar 2025 00:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516959; cv=none; b=olIfvNph84pizNlrJNe26lq5aDe/BoerAjaFLCZh2uQTO8m9iC9aitv8ZcufVwWlGFwdqiSAUeCSmxTrBSJdZJQlC0IFFOL0eR+7tUaR2PGcEfsbujQwfDhTBLLyH/LuM6TugI+0RzVei6ME9uS1gjjgPC1itHeuzWJoOGcraKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516959; c=relaxed/simple;
	bh=8MVYxagd5dG7kf5hN7h7VzvIdu4/m6DAUtp4/vVYTbk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hYL2Iyu6Y8AuqJSlkDrrTJeUe9eijbDCw7edltHAzfFN3VKqJCh6Z5sm8QSyRQL/y4TiiKN6T/9Dqne9qamaybQdC0oQQxHbKhgXGW0tRMtJk+koxc8QnIVzmzbCgyadXHw1AxOtnwvEKZyuv4taWONK8isrWphyWeFs6VXymPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgdvrwBu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff799be8f5so2337669a91.1
        for <bpf@vger.kernel.org>; Thu, 20 Mar 2025 17:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516957; x=1743121757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sqn2OSqZkWea5X1sVmFqhBGOcsyY48b9clHP1PvkAtU=;
        b=WgdvrwBu2V3TB1+B9NDudxaMyrHJxmh/Z3JcsfCqCHdB4kASX+tuh+L6V03Cr/eIi9
         Z3mA5NEHJuB1XYGWzVKWk4fJEeaFGiFQXcI07Y9q1NEvdPK/wFDk4ocnow/32w+jovTf
         7zUYIthM76fmnh2+PBAnij6Low0I6yK4Aw06b6T0LsVTWjsQUzfie5JpoBtUsg9pNELf
         i6lEFlEq/QssBjmfiehk/mUqNRgTzVzJPxQ0Lww17ffSRf3wZDNNXdznnfhcVMdKT1Na
         PJc6zvFtv2NNf3uV+olg8RpdQnpbiKNnZm3OmBzu33Dh3UPY607VhrO+p2jUc4tBEds/
         qA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516957; x=1743121757;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqn2OSqZkWea5X1sVmFqhBGOcsyY48b9clHP1PvkAtU=;
        b=NpsRQCNeYlZGLryexMVAuqsZKkGNjV0TrvPwlC2E214hgbyqKzszMBJMYfu6nqKW8c
         CynMwbavIAysIah6+F/HLET06QhuR1dedEzmtBGIfdMblffsILZiArqNu291MbSWkIVF
         dnDYr46wcSICwkpFy0lVwxhc3uMidM4uUHKFln5j7yM2IMDTMuahPsrgE4WFXsC5IYuB
         fRLr1VloBrZu7H0t8MtThQyNFgBPURH+r1cz8X28Uhuj/42GSBQjJ83ehzW0EW1PqA/6
         yP433cI2EiXbDR8AbOrlDFmTqxw7jQqISBf+NSfUwrG0b3NW8NmPJ3BQ4p9v5zfxaEfN
         G2Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWalsdiv61pAE0JSmwJ7o8poh7YLSlLYjOLXZrxlnx+UW0kvU4NyRTA6REiZzbPpCaEDX0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+r7M+IdDaWU/0isXveHXRPC1h7uHccIxkUBlQxtsqFuEB6qQV
	JKXm0b9BvKke9smlkjQsLQB7/Nt9MQsstJ/ncFHoVy8PD94ZWgCwNasfP5whgLgx4YqIemOrK8C
	QH2U6m+DkiOXYP53YvWkNTw==
X-Google-Smtp-Source: AGHT+IE7CroiKkICZlfGpgVa7tYfssQoYcG0aQDZsojHVA/nr5/4eL3ObbDEmfpeF6tEEyGeQUYTXMcGex5qUwNJVw==
X-Received: from pjk16.prod.google.com ([2002:a17:90b:5590:b0:2ea:29de:af10])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f86:b0:2fe:e0a9:49d4 with SMTP id 98e67ed59e1d1-3030fe56b0fmr2141537a91.2.1742516957286;
 Thu, 20 Mar 2025 17:29:17 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:04 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/6] Basic XDP Support for DQO RDA Queue Format
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com, 
	ziweixiao@google.com, joshwash@google.com, horms@kernel.org, 
	shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

This patch series updates the GVE XDP infrastructure and introduces
XDP_PASS and XDP_DROP support for the DQO RDA queue format.

The infrastructure changes of note include an allocation path refactor
for XDP queues, and a unification of RX buffer sizes across queue
formats.

This patch series will be followed by more patch series to introduce
XDP_TX and XDP_REDIRECT support, as well as zero-copy and multi-buffer
support.

Joshua Washington (6):
  gve: remove xdp_xsk_done and xdp_xsk_wakeup statistics
  gve: introduce config-based allocation for XDP
  gve: update GQ RX to use buf_size
  gve: merge packet buffer size fields
  gve: update XDP allocation path support RX buffer posting
  gve: add XDP DROP and PASS support for DQ

 drivers/net/ethernet/google/gve/gve.h         |  72 ++---
 drivers/net/ethernet/google/gve/gve_adminq.c  |   4 +-
 .../ethernet/google/gve/gve_buffer_mgmt_dqo.c |  18 +-
 drivers/net/ethernet/google/gve/gve_ethtool.c |  30 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 288 ++++--------------
 drivers/net/ethernet/google/gve/gve_rx.c      |  30 +-
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  81 ++++-
 drivers/net/ethernet/google/gve/gve_tx.c      |  41 +--
 drivers/net/ethernet/google/gve/gve_tx_dqo.c  |  31 +-
 9 files changed, 250 insertions(+), 345 deletions(-)

-- 
2.49.0.rc1.451.g8f38331e32-goog


