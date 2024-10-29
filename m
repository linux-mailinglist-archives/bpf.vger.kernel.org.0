Return-Path: <bpf+bounces-43411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4E9B531F
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 21:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7390C284687
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7022076C4;
	Tue, 29 Oct 2024 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FAkMzm2w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9E1DBB36
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232755; cv=none; b=b+INWg6+/m2GDxg6vNfN/EADZ0pNHF+ceLBcIdpyuN5Dfj9XFRCaGUYUsdarOLc6tTEq9uhW6HgGGwlcbwFbyNtgQoPAJbv6ddx35qv1s1JAomilVLnxcn7uxrq4TuGms3jZSabNxocNEOJmV5VMJHMG7XgtfkDGyv10g+Q9ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232755; c=relaxed/simple;
	bh=99qlM1Z6o7kvkwtJNO/OME0FfbYc8zC8YDsnU3piAVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e0Kp89B03pqFuIqdWUTA3MjTfbXo/xlJuvjbgDGeqe5ij6eAwRdvkDr44JN5Oj877HF0WGo4NysOIu2yMFjZ+wfIw+k25k/upT4TNLAcsUlKqqV5EEvSp8mUV2WQAxmnLCJyUR51bLlywsPlui7mmOKrD1FFKbobWX6hZfcxkWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FAkMzm2w; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ce5e3b116so42109865ad.1
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730232753; x=1730837553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aYeDjnJ9XjjabwCbCHH6fW3AjTnql2GKv5MU7+hVLE0=;
        b=FAkMzm2wKJtF/pUPUGup7Ik6OIkt/iCYZqfTqw+3tgH9hYV+bTPcPEocNvhE4X2aDS
         RHCu4ht54wOg4eVGxn7wkNfYcOrN36hjtb4eVp3fGsJTDP7g2ZNEuYFCFAlviMNnFk0C
         2/bynVMo0R7tz/FMq6pHolPs4LJBt9MsfGOqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730232753; x=1730837553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYeDjnJ9XjjabwCbCHH6fW3AjTnql2GKv5MU7+hVLE0=;
        b=r7USyTs+WHVhe+fwbNcDxNBBlqQGJAXqhNSWntC/VcKj67NpcboiXya+54zRbqfSdk
         IWPazp2Qy2gg1fV8kbw5g3TQ8JVuefMU+iY1Vgu+QU0J8xeNdNP5n6AwBe4Ov+ZfCwyh
         cIMWXlcuVvjZda7/n7doyMnacF+jEHKu5xta6uFTrf4BcDDOojFeS5ZKD7dOAuYmRNRV
         hGl7hCv2jBayYDqMrCo1kqE5lyip3JuSJr/HeGGsKdqTPiByA8amE61aPf/OU3XLzmcq
         KRDLfh3zzuk44OAcXGXZiQd+1Aq94pfMElSQZS7MJIy/CghdbZDEz0HD344zFfU5tSgv
         9gRg==
X-Forwarded-Encrypted: i=1; AJvYcCW4u9YS13cWgPVmW6ofryheZCnRY+HPhgVWd5L9pm3D7chs/2bhjgILHO05mKOLqUsphYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjK4OWvfhOO4Om4S4evbv8SCSULmlwN9oqp7CjefD11Bf3iVQZ
	v2FP4CSSahL0V7zT/OiIi/GuAiAQN9y9y5tGN4WmqYztuGcWfITIMOcZ8ZYroL0=
X-Google-Smtp-Source: AGHT+IGUOvUKsYl+v6XsSJnfSFz7opvXhNHNYeTGLJ2ZfxGHrI8y/ZFsuIcwco2C5yyMyOskSAYVrQ==
X-Received: by 2002:a17:902:d4c9:b0:20b:7e1e:7337 with SMTP id d9443c01a7336-210c689ab32mr200616595ad.13.1730232753076;
        Tue, 29 Oct 2024 13:12:33 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc0864d7sm70113735ad.303.2024.10.29.13.12.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 13:12:32 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: vitaly.lifshits@intel.com,
	jacob.e.keller@intel.com,
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
Subject: [PATCH iwl-next v6 0/2] igc: Link IRQs and queues to NAPIs
Date: Tue, 29 Oct 2024 20:12:15 +0000
Message-Id: <20241029201218.355714-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v6.

See changelog below and in each patch for changes from v5 [1].

This revision was created due to a report from Vitaly [2], that my v5
should use different function and variable names, like igb.

As you'll see, I've modified patch 2 to use __igc_resume instead of
__igc_do_resume and bool rpm instead of bool need_rtnl.

I retest the patches on each revision using my igc hardware as
documented in the commit messages. I have no idea how to test
suspend/resume (or if my NUC even supports that), so the power
management bits are untested.

Overall, this series adds support for netdev-genl to igc so that
userland apps can query IRQ, queue, and NAPI instance relationships.
This is useful because developers who have igc NICs (for example, in
their Intel NUCs) who are working on epoll-based busy polling apps and
using SO_INCOMING_NAPI_ID, need access to this API to map NAPI IDs back
to queues.

See the commit messages of each patch for example output I got on my igc
hardware.

Thanks to reviewers and maintainers for their comments/feedback!

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20241028195243.52488-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/f02044c0-1d90-49f8-8a2d-00ec84fba27a@intel.com/

v6:
  - Adjusts patch 2 to use different names: __igc_resume instead of
    __igc_do_resume and bool rpm instead of bool need_rtnl. No other
    functional changes were introduced.

v5: https://lore.kernel.org/netdev/20241028195243.52488-1-jdamato@fastly.com/
  - Add a small wrapper to patch 2 to only hold rtnl when resume is
    called, but avoid rtnl when runtime_resume is called which would
    trigger a deadlock.

v4: https://lore.kernel.org/netdev/20241022215246.307821-1-jdamato@fastly.com/
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

 drivers/net/ethernet/intel/igc/igc.h      |  2 +
 drivers/net/ethernet/intel/igc/igc_main.c | 59 +++++++++++++++++++----
 drivers/net/ethernet/intel/igc/igc_xdp.c  |  2 +
 3 files changed, 54 insertions(+), 9 deletions(-)


base-commit: c093e2b9768b3a5cd7a37ea654cd47094519f843
-- 
2.25.1


