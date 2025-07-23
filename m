Return-Path: <bpf+bounces-64169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CAFB0F529
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 16:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077A61CC1B33
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 14:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219FD2EF2BA;
	Wed, 23 Jul 2025 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JImctd1u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3232E8DEE;
	Wed, 23 Jul 2025 14:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753280621; cv=none; b=SxeXmo2ukkHyqM8A0ZJje2V92bQmQIjW1YRlkhajUmd5f60TGmhFhtMc7C1ceXI5WNqCgRaikUiAf9zBjGtTjkh0ZTcswPAaIfZnfpCZrAcZefuroJyWKsfnZ+melVn4XbSo7zJk5rB/rHNw20U9G0PYe+AVMQvtVr3JwV4sdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753280621; c=relaxed/simple;
	bh=AYIWRQVfnyvY6zSGhSziaclo7KTqM+c1AOB4JPzZWFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHDlrrD+LHB1AH/rpMFP3jcx6LNi53CbvUAZYL8l66a9avRcNNgKHfJKE6u99W61JfpoEXJpM8a523K+LuS87GTtDPn5L9bwha5Eh+nEO1IShbl2myNSA1/tccY2qlJliW9PRNsJgWf3KrEzqwSzcocYJO8UFrPI4Qcl9mJvhnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JImctd1u; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23c8a5053c2so64057695ad.1;
        Wed, 23 Jul 2025 07:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753280616; x=1753885416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxwHaK6YDUmdrsdUjFROIjJz+2g48h51kQ60Ua/P8/U=;
        b=JImctd1uT0gNkbJXeSaAGlg0OhNmVN2sknQePO9STlt7MvPKF8bF/OrNPXI7fvWWL/
         ykhww+ly2gQUjSQZuK/PIbGVBzLCIaIroMMJcKXQ0AyXUdfwLBUxxqYlMXpadBrmukxV
         OcqOFNBpMYFFR8UDSGrVv9lp2BSmsQCVOFFHH3p+r/Y1LBk/+gX7ZDYRy8b9uBUE5y67
         v7FGgC6DGfytSfpSuM5dddz37ajQrJgxc7SiwlzGrZfhBXdaceUtde4u79EFSt81QAYN
         ACfwa/Uh9Cr95q/tB0c5rT6orFy2n4+HJq/tcmJnDenzARdTGmUxqeExuXyLjDthL9mG
         adZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753280616; x=1753885416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UxwHaK6YDUmdrsdUjFROIjJz+2g48h51kQ60Ua/P8/U=;
        b=VLp7MEnpem9EncJyHN+e4G5r8qoMfyj02n4w54hQUUInZ84XI0ZSzlMyee27+LrVBp
         /X73a6MSNoPo9VtW/Jy1huPi+ktczuSLYsFc6XWnuvvBkvE5PPAHNW0bVpV6po7Rtkc9
         Jl7Yu4/7w0hzRZ/gvh30l/GYMuNRY8fKnZDIi5aBcLsJ/TQ1BJJ1LCeoJZjyySoBEhO4
         5XblBEt5czxVL8DUDYEasTyylOqsNUoMqK2dG8i8wFYSf0HByEcm1dNwgwzwNDUwrDnU
         +M3a+FAJe7K2wSAeer642ggR+VuPk/owqaCfxurUyrB6RQ8eHraoN2IM6rezzxcgi8uv
         hdKw==
X-Forwarded-Encrypted: i=1; AJvYcCV0d4eshuP0+FEpB21nai5gVcYxGG4Wly8L5fjRitYO0xPYqGcslC55KevO4iRE6baagl3oJAYL@vger.kernel.org, AJvYcCVMWiwufc2uNNskjqbdgBFvfHEMWQB3ejo7hPH0/N7MQQwv7Z/ll1ebV4qwSCcuHRijUbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2fGWPpTrx09TEMgxX8IBqFhNSp3I3jxN9wtl8VPWcof+DsY6i
	JKH3eNgDWg4YPTQwovbqD5AipNmogXLZrTXXqsMrHN2VO6OJ806tlR6x
X-Gm-Gg: ASbGncuPhqUhi8uB74eeLvZwGwlDTvPCiPyXB/ii/vSG5RSMGeGx/17He3pzLtAZqFi
	BPPe3AJEAHXfRAc9qJUcOUuSpTK/aN7X61VjRC9LO+yEyRf0XsqdRpmWtMc5eJtQU5wHlY1jxbG
	pd2Mxpt10YI21pVaxbnqnSg1NOrgmeALvS40ThgaAhHaOha4yuK5M4mlcZ70G/OksUNsYo3ocfN
	aaaNXInJL1cLwtTlI2GcB+jHfFE9VTkk0rt8oor5GW7Ac87Dy7dpEzpeqvy46sO+OljMEn+8YPf
	rCPQsAWloBeBSMvN7hhD2bXA9CF2vPS61hf0dms80VKPg2+NJ6fnJH7pQUoDGrzu9/r/zxiHBrn
	VuQ0JLp8J8W0le9K+fqnn9b7EOGZtZxKfp65TyTF2yTWC2BXjNBXuGtmsQgmBrKeNo5WE+w==
X-Google-Smtp-Source: AGHT+IEd0wy3eDFLecrSHW0WlQqhyyQ7MxV95sUDV+ufUcT8vx5C+vZm/dLJytY/egk/pAWS9HDwiA==
X-Received: by 2002:a17:903:230c:b0:234:a66d:ccf5 with SMTP id d9443c01a7336-23f98235191mr55549135ad.49.1753280616283;
        Wed, 23 Jul 2025 07:23:36 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.28.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4a9esm97929595ad.93.2025.07.23.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:23:35 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] xsk: fix negative overflow issues in zerocopy xmit
Date: Wed, 23 Jul 2025 22:23:25 +0800
Message-Id: <20250723142327.85187-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Fix two negative overflow issues around {stmmac_xdp|igb}_xmit_zc().

Jason Xing (2):
  stmmac: xsk: fix negative overflow of budget in zerocopy mode
  igb: xsk: solve negative overflow of nb_pkts in zerocopy mode

 drivers/net/ethernet/intel/igb/igb_xsk.c          | 3 +--
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.41.3


