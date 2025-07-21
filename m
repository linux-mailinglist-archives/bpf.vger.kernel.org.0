Return-Path: <bpf+bounces-63885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D16DB0BEF9
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C402164734
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 08:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A592820AB;
	Mon, 21 Jul 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mG5HJPcN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0049D1E50B;
	Mon, 21 Jul 2025 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086833; cv=none; b=RSYR9V6edZ4qt4j/Pid3gOQesf/e9RJbsTBvASyzd4RbKXDyzFO9cJQP7E9wkKwK4s/6PGUImK/EIKpa/lI9pahCu6ESk9dAeWk67Ag5qylE5Du8DKC9ck8j3tjpWDWKGJTkuxfLrEfeLQ1yafc4VZylwpHwprqgnDwWwGRj/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086833; c=relaxed/simple;
	bh=0O7hWoJ8FFOuZs8FVPqw3k1X6ALMl1XrXfMdfiGuiCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lndS7T7790ZjMbtmP5mAr3/5mzmJS4KQMTkdqgKVfRNXLJhpWiHWONnc0OPUPZn8lSVuJmKl4SPcJm3ZowSir1avuyYlGdxXRipA7C4VENzEJjOdUdX/Eu7UZ0seYZiLQFIcvo+NVidemKo4cXgWKR3WsWa4urjSltZTDDBlSf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mG5HJPcN; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-31c38e75dafso3274208a91.2;
        Mon, 21 Jul 2025 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753086831; x=1753691631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fsE2sNuXpdXdhRH0OAvRrhIA0vlIXlgXbN8nwt6iNk=;
        b=mG5HJPcN0seTEmNwIuXhzbjVNo9rZyRNELcnWKMI7ifa1sOxQQ8P0iHxNcKnlUALCU
         Rrq7ixk2D/aadIR4kkoNzBgSzG3UiAZz3456uaNg9eI6KfygjYSMzvK5puw+N2KOwA51
         Gm3c+zB5LeUl0tn2rPOv+CHyMNfE/Z1bKdxhEzMY1T9ypsEOB61vB4QowTbsQJFhzNkT
         JHjqLe16aRmDXvuvknhrC2P1iTcFJrvE+Kx5CgpAB62cfVSsSy60lTwNX6r+J+/1fHQ9
         EV01/r6iNAbz+SouA3auPMEWQX/wUmjoJajBWFVO3BQRcYyIkgSULwVKgCc8qlV6xGNw
         Q+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753086831; x=1753691631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fsE2sNuXpdXdhRH0OAvRrhIA0vlIXlgXbN8nwt6iNk=;
        b=ME982xCPlVqna7XiwXYc8ZOCktkzjooAXbrDcflri9ZcF9H+QsRS88MIC/Xg9pPiRe
         GT7VYLsSXQVNV+8NDui9zc8li112TRwawOWTOd4gPcGOCKPWiA2PbnxkCMWR64oQqlmv
         h4s4bb8rAt6vll3f7/eTAwz08jpZW9mKX+LxDpg0P386R0h7u6MUJ4DksSc6pSOAYpUX
         lFziyBjl+gbdOn52fOmg6B+6t7nhNTq1k2zVSv9GBuwms8dBsoTfG0JnQUEX5D29/20P
         EzAtqBRFfkGSCgxWmSrWSicEGNEnOeBWLAzdZGmYYpMeDCNY553NSEckBfGRdyE1r43b
         MnSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzSaXL/aeIXyoY1NKdJUnRFIfRqppT+eFxqe39fgqfLYhnNxAvIeQ2JMtItvZlkJv/L5c=@vger.kernel.org, AJvYcCXH0BR/AwtW5uFKQKCoK4vKLJ9iKNzY9ZNPlPygwlia5cf/kRW0DFnpzUrz05krxoE0gYsHNBS+@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsrNBqaDYlups+jgWPMjChVuGKx+wFObHf07SiEB8v8RVL6oa
	jBZ1zLAtJ68XEtQ8JL3q2X97Mo4lElO0TtZEzTrVwcGq7Kox+eLQzGGC
X-Gm-Gg: ASbGncvv+WWBLBFANnD33R5Ek/31vHJhK4hmXoX2mannju1bhHp9ZQx4Zxu2qEg4PNb
	M7/6BuydVsTHmk+IiLhTS5jyjA/UDKTtmfT3CnwQreo7lRIdvrIJJGKHHeZ94Kmw3P0oDBrIttq
	Feym3RN/i6MYV/5ZWH1iHQ8NG4YUPo/UMIpkXK9PRtV9SaBgQYticcMYP0+egsibmSAAbJGNXU+
	YO1Q+jduvuk5c0FBmjf/wacXoJFhX1X3lXEtwz0/q0G6Chf8qT0N5FzQNNiYVtfn9Am3iFdu5dt
	FDtKxUcSx0XhZCsaQ1vcrR8VbT35Nkjt6KJQ3hDXa6aGlMPyiSQAqekxtYcN4yFPkQ3ai8BuI6m
	ivauvKXACPUxbp8YqOXtAUZSaNbZ5dGPKGdN6VJ7g7u235NzWzhTrnDtS2nk=
X-Google-Smtp-Source: AGHT+IE8NhryGKMJDsH4u3alU+wk4yQjNrEdlHvCXHsLOGmQ4xHKQNG4+AcSzLJ7hhq8981ot0Wbag==
X-Received: by 2002:a17:90b:50ce:b0:312:f2ee:a895 with SMTP id 98e67ed59e1d1-31c9f45b0abmr26601296a91.31.1753086831079;
        Mon, 21 Jul 2025 01:33:51 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.24.59])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cb7742596sm7082116a91.27.2025.07.21.01.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 01:33:50 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
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
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] xsk: fix underflow issues in zerocopy xmit
Date: Mon, 21 Jul 2025 16:33:41 +0800
Message-Id: <20250721083343.16482-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix two underflow issues around {stmmac_xdp|igb}_xmit_zc().

Jason Xing (2):
  stmmac: xsk: fix underflow of budget in zerocopy mode
  igb: xsk: solve underflow of nb_pkts in zerocopy mode

 drivers/net/ethernet/intel/igb/igb_xsk.c          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.41.3


