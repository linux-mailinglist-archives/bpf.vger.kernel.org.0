Return-Path: <bpf+bounces-42837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FD09AB90A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F0DC1C22CEC
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 21:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA781CCEE9;
	Tue, 22 Oct 2024 21:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gIAHV0kJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C661CACDC
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 21:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729633981; cv=none; b=Rgixnr8iIEvO4YNgDG/glKB+4qd3h8dpjg0XZfAb0kgajsTMp4+2iPhvcKhUjEJE19VFBdIM2UvSPQbmY4SbWOLdbak8k27mK1Ol1q1iuVZ0uq8EH9NeyKwmrflaf5HKNlO3gXIBA6UVt6t8nYpQ+0mycLyBvZl1cV0pHlX3/cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729633981; c=relaxed/simple;
	bh=mZHyRJsvYbJrA/bK0xUf3xOnp/PwB9vGkP9J9h6qzUI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ly9hVCU6hUAHziDQMtQNz9fI+mY5Zu681l5vO7J/yhf+RXGix9Rgtf4LiYFiPT9mLZC1FK+r+r825RSXdnJy/Ei8DP4adn7wPVZNeuG4YgxI4kesDxoe/t4FvXlF3hh86GO4LJ8KSvPb+3Z1o3YJuTnBP2TGs5NTSqP2mlZX7uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gIAHV0kJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20c714cd9c8so61378225ad.0
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 14:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729633979; x=1730238779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27PH9KJY9xP4iasns3riOle1zadFd8sn/XZWx1MVstg=;
        b=gIAHV0kJx5I5RQv4FTOvL4HR3JG8MfVirQgpY8+/WGg1tV7uMFXdNIPJ46d/PNKya5
         OVP1N5ZO14/xlZyg+IrN//+XvPjPnKoeN334Vwhgi3k5BhJWPlEJgo4gNmBM4IGIPrzg
         HV1YGpyFqnV9omvUJYQa681WS/QsxNDRl04RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729633979; x=1730238779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27PH9KJY9xP4iasns3riOle1zadFd8sn/XZWx1MVstg=;
        b=Hr26v0oXpd/mNjJmsM72Vifiwo+iSoGs0I1Owpmi8WjLHxPGWAxjmKZBKHxA3MDPtH
         vJPjb9AGDrOEB9CatS4CXQq5qXt2JlxzL2K4OAj2tq4E3EFTcxIkFG/75khv48kZrw5Y
         scTAXqlRXG9t49yY2B+sBSf/bcXrQ3yLtQqXAxCM5UIwdLQPb1KNzWbsr16hsrF/pKVb
         Q0Xn9TI05f3dX1f+lBN81WEQn7z8v84K4L/lnW4WP/6yxCg6WejFnNE+Iuq4p0ReY63n
         4A9UoWM7t/2flRXIHEb3I6AH4aaVI86fxq+Kc1qdZPnkJsESEVBm4BgoD3HKydQPRPiy
         PkWw==
X-Forwarded-Encrypted: i=1; AJvYcCV20tXS0h9xQuZIfZUBAIXkjY0tAaOcdfIvLOTezEbVHuxq1titdhVNbpuaKtvsiG3AZ1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwTU5bC+S3v73/7x7Z6dTQlg9DZTC8JEDcsn7/QP8HQHv+gfWZ
	8GCn6hvl0i2NfeVdxtPwD+3Nmt8Qr0+JexPsVKZPGmdDb+OTnShSnQLPdG0/Ofo=
X-Google-Smtp-Source: AGHT+IF+g37BAJ/gs+9A6578kVnZDjD+Y9MC0VzOxCi8OhwVz1VkHyQIRvT2Mam28b3hFk4yJnnKLw==
X-Received: by 2002:a05:6a21:4581:b0:1d8:fdf8:973c with SMTP id adf61e73a8af0-1d978b3dd71mr507279637.29.1729633979041;
        Tue, 22 Oct 2024 14:52:59 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d75b9sm5194375b3a.131.2024.10.22.14.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 14:52:58 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: jacob.e.keller@intel.com,
	kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	bpf@vger.kernel.org (open list:XDP (eXpress Data Path)),
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [iwl-next v4 0/2] igc: Link IRQs and queues to NAPIs
Date: Tue, 22 Oct 2024 21:52:43 +0000
Message-Id: <20241022215246.307821-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v4.

See changelog below and in each patch for changes from v3 [1].

This revision was inspired by a bug report for e1000 [2] and analysis of
the call paths for igc on the mailing list [3] to ensure that RTNL is
held in all appropriate paths.

This series adds support for netdev-genl to igc so that userland apps
can query IRQ, queue, and NAPI instance relationships. This is useful
because developers who have igc NICs (for example, in their Intel NUCs)
who are working on epoll-based busy polling apps and using
SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
queues.

See the commit messages of each patch for example output I got on my igc
hardware.

I've taken the feedback from both Kurt Kanzenbach and Vinicius Costa
Gomes to simplify the code from the rfc v2.

Thanks to reviewers and maintainers for their comments/feedback!

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20241018171343.314835-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/8cf62307-1965-46a0-a411-ff0080090ff9@yandex.ru/
[3]: https://lore.kernel.org/netdev/ZxgK5jsCn5VmKKrH@LQ3V64L9R2/

v4:
  - Fixed a typo in Patch 1's commit message for the "other" IRQ number
  - Based on a bug report for e1000, closer scrutiny of the code
    revealed two paths where rtnl_lock / rtnl_unlock should be added in
    Patch 2: igc_resume and igc_io_error_detected. The code added to
    igc_io_error_detected is inspired by ixgbe's
    ixgbe_io_error_detected

v3: https://lore.kernel.org/netdev/20241018171343.314835-1-jdamato@fastly.com/
  - No longer an RFC
  - Patch 1: no changes
  - Patch 2:
      - Replace igc_unset_queue_napi with igc_set_queue_napi(..., NULL),
        as suggested by Vinicius Costa Gomes
      - Simplify implementation of igc_set_queue_napi as suggested by Kurt
        Kanzenbach, with a minor change to use the ring->queue_index

rfcv2: https://lore.kernel.org/netdev/20241014213012.187976-1-jdamato@fastly.com/
  - Patch 1: update line wrapping to 80 chars
  - Patch 2:
    - Update commit message to include output for IGC_FLAG_QUEUE_PAIRS
      enabled and disabled
    - Significant refactor to move queue mapping code to helpers to be
      called from multiple locations
    - Adjusted code to handle IGC_FLAG_QUEUE_PAIRS disabled as suggested
      by Kurt Kanzenbach
    - Map / unmap queues in igc_xdp_disable_pool and
      igc_xdp_enable_pool, respectively, as suggested by Vinicius Costa
      Gomes to handle the XDP case

rfcv1: https://lore.kernel.org/lkml/20241003233850.199495-1-jdamato@fastly.com/

Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

 drivers/net/ethernet/intel/igc/igc.h      |  2 ++
 drivers/net/ethernet/intel/igc/igc_main.c | 44 ++++++++++++++++++++---
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 ++
 3 files changed, 43 insertions(+), 5 deletions(-)


base-commit: d811ac148f0afd2f3f7e1cd7f54de8da973ec5e3
-- 
2.25.1


