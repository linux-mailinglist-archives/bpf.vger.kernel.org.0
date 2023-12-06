Return-Path: <bpf+bounces-16953-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54896807C4E
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 00:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6A3C1F21A1B
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 23:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6293C2EB00;
	Wed,  6 Dec 2023 23:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzV9fod0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705FB10CC;
	Wed,  6 Dec 2023 15:27:10 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6ce972ac39dso63014b3a.3;
        Wed, 06 Dec 2023 15:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701905230; x=1702510030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fX2TomnDpcWa9Rf5bjJuYqn4PKTx3fdJMigTAusfJvA=;
        b=mzV9fod0Q14L2zaqaJJFNaSYstZfhCxbjhu7DHaz3kZ8LQbaCnKFGtLV/QMC/BXNRS
         dUijB6WmmzKmc9pw6gIvaKwbSl0ELir54e70dxPQ3ZwGFkmzwv27PojDo4mNTp4tmekc
         2QHqNQwBzI4CdrKjA92Jdzmrm2gNlKiKDqZ2yjZcLFvT7KcWTRe/eYJZglOoIa785pHG
         9NxjPqpyMVGqpE93BmL93QicPLGI8srPQaY2TVnQ7d8r50q0prPGNTQs8MhQ1ovuhjvq
         b6LdEDCBuJ58BiFcuuZAwnk+5B/pI2vSKJkvmYJZ3CtJ6RIpUI8GAx2TRMGrn5fF7LBo
         PJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701905230; x=1702510030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fX2TomnDpcWa9Rf5bjJuYqn4PKTx3fdJMigTAusfJvA=;
        b=T964g7QLuJbhgKsyQz4RkvBXfpNperC+19Tf3NqSxyCnylJSJJbg4up4fCkFOAkAYj
         InOGhvDDLll/axwPRZfGSY5ogHP7Vy7wlRnZhZ6Gn97XTm95zABcdsXpAtAIZqI1K1z8
         IfPPNZ++CsklD1kW9Et/37zdY1eXNNt04nZzKKA8ELTtf7S7YuW6uO6brnl5dx/Xiz5n
         K6E/pRD0zszVtMHQCf8sHB7Svp0nYIoXbfbNLPv1G1IQOU3o4dTBEQQawYTK5v2jfI1Q
         IxxboHPXYvXFK2D1hzkDdIi+VMMElkPNNz33jvUjb3ETC26ignDCr7PN3q4aUC4SOOY3
         Z11Q==
X-Gm-Message-State: AOJu0YzB8Pobclte3RtJAjxZ4RWufHrdaH/NOELsPRdg0G82IknVyRUe
	/uhO5qAptXAgETY4rvv27HQ=
X-Google-Smtp-Source: AGHT+IH97bKNklJ+bTgsJXkY2/Z74iquDLTg/8+BXT6ocb14RFZTDU9ggOR0/q+PoZnDkzDdL3+B1A==
X-Received: by 2002:a05:6a00:2302:b0:6ce:1001:2f0e with SMTP id h2-20020a056a00230200b006ce10012f0emr1411103pfh.4.1701905229706;
        Wed, 06 Dec 2023 15:27:09 -0800 (PST)
Received: from john.. ([98.97.116.78])
        by smtp.gmail.com with ESMTPSA id ka18-20020a056a00939200b006ce91d27c72sm58545pfb.175.2023.12.06.15.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 15:27:08 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: kuba@kernel.org,
	jannh@google.com,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	borisp@nvidia.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net 0/2] fixes for ktls
Date: Wed,  6 Dec 2023 15:27:04 -0800
Message-Id: <20231206232706.374377-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Couple fixes for TLS and BPF interactions.

John Fastabend (2):
  net: tls, update curr on splice as well
  bpf: sockmap, updating the sg structure should also update curr

 net/core/filter.c | 19 +++++++++++++++++++
 net/tls/tls_sw.c  |  2 ++
 2 files changed, 21 insertions(+)

-- 
2.33.0


