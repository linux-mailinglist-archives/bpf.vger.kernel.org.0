Return-Path: <bpf+bounces-41887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C5D99D902
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 23:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328941F229FC
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53A51D0796;
	Mon, 14 Oct 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Cm0jlXlg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6E11474A7
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 21:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941427; cv=none; b=AhuG57bVphT7CiPRkq5JwRCfKCUQDZ8k2NHqKkICzVi5K3PCMyXonQhZjOvuPFJ0FrNs71BvzeQZAbq7tTlBZ54QMFz474+lRPK5boej6kyM6dYPtoDBXgZLqpAr0fDN4SQ88aGo/s7Bph6J1F73WUfqSxMlQR9C75pi5Ee0DGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941427; c=relaxed/simple;
	bh=bEqAb+bVjJWGqU6I6zOFHprL01hEbWXrzpMDgxiSiK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QXWBeqiFcImFUXSjdLakPvEfJqhELIjKJV7S+OJIYABaBmLjybJEix0mA47KgH/9sx84YdE9fa77Z/B6RnQW5aKW8IlMrwt39fbKLeCVxhvJATQeCUVs2hRkxyIXM5rjxFm+1dTuR1T+i1AZ+ZeJ+jgamQRwlg3J+6CUWMr78ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Cm0jlXlg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20cdb889222so14850485ad.3
        for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 14:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728941425; x=1729546225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o+VyLQJDda5qPJG1fPPKSJPMELfF1NGTd/R4wmdZQaU=;
        b=Cm0jlXlg1Qx4VXxf1lP395L/YpYhOPE64rJ89HK2rV+d8vu3NZr4gMfabwkHDgbXzl
         lVjLlszI5qDigqBRBk8vUOXQPfkAzLqD26IhLZJYNkdNZe/WyGExFkFKGZ6tSjdO1ism
         Z/VF29gDgJHhadDLr6ln5zp0K1jXHrwvQTw38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941425; x=1729546225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+VyLQJDda5qPJG1fPPKSJPMELfF1NGTd/R4wmdZQaU=;
        b=d+3jln1KC4ariCuACMYAM3P8aoHQ54e2vfPcW/TT+86vULiAPu08yAv3//sCrVq3s3
         jvztnqamgGN5dYz0oH31j6JA+nCFAjeflgtHLjiSI+2cfO99/VP+JpTTafAgZCoL/Aju
         2HQygkT5V7d3WGE/k6lPYyuS3RgXEGburo0ahqZYPPpEzH2DSjla9rT2hc4PGzl2F6pd
         o3nx8XE41TniSgYAKTX8rjBykKqHPHBd6EWL8nt3omVxY0t6dqVEjtoqwrJmuAxNAI3X
         A3wnhZb+PMfJAMX8cM7FIWAAi5E4OGqBGCdHT3wHc2tfJXcfSuWYHegNOyF5DjdKSOfg
         ie4g==
X-Forwarded-Encrypted: i=1; AJvYcCU+wazPmG1PP/BO3ZagrJBEQvJYYkkvk4zK0z/Jhjxz6BhnDiPHA9k2xqV0/P4JPSItnm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaznSFwCaz5aEJBVY7GQET0oNoVaj2/eXz+46XGpr7/vz1xlRt
	LXjXVJop7DH91DMFADM9WzsMVC2tuODqGPGHydQrnHCdiIktoziQXLJE4ZK0PSo=
X-Google-Smtp-Source: AGHT+IE3xgA3WQrzZiPsFMr/VZiJGc90cpU5Zyfzew+lfIaXONPM/rnaXq1ihZIG6cOXGviq0kaUJA==
X-Received: by 2002:a17:902:d487:b0:20c:bda8:3a10 with SMTP id d9443c01a7336-20cbda83bcdmr94374715ad.37.1728941424998;
        Mon, 14 Oct 2024 14:30:24 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc1a54esm70197495ad.73.2024.10.14.14.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:30:24 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: kurt@linutronix.de,
	vinicius.gomes@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Alexei Starovoitov <ast@kernel.org>,
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
Subject: [RFC net-next v2 0/2] igc: Link IRQs and queues to NAPIs
Date: Mon, 14 Oct 2024 21:30:09 +0000
Message-Id: <20241014213012.187976-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v2, still an RFC. See changelog below and in each patch for
changes from v1 [1].

This series adds support for netdev-genl to igc so that userland apps
can query IRQ, queue, and NAPI instance relationships. This is useful
because developers who have igc NICs (for example, in their Intel NUCs)
who are working on epoll-based busy polling apps and using
SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back to
queues.

See the commit messages of each patch for example output I got on my igc
hardware.

I've taken the feedback from both Kurt Kanzenbach and Vinicius Costa
Gomes to handle the IGC_FLAG_QUEUE_PAIRS bug and the XDP case
(respectively) from v1.

If this implementation looks OK, I will follow up in a few days with an
official (non-RFC) submission.

Thanks to reviewers and maintainers for their comments/feedback!

Thanks,
Joe

[1]: https://lore.kernel.org/lkml/20241003233850.199495-1-jdamato@fastly.com/

v2:
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

Joe Damato (2):
  igc: Link IRQs to NAPI instances
  igc: Link queues to NAPI instances

 drivers/net/ethernet/intel/igc/igc.h      |  3 ++
 drivers/net/ethernet/intel/igc/igc_main.c | 61 +++++++++++++++++++++--
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
 3 files changed, 62 insertions(+), 4 deletions(-)


base-commit: 01b6b9315f15f199a206c8b3bd3e051584237d7e
-- 
2.25.1


