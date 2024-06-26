Return-Path: <bpf+bounces-33133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A510E917948
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D702C1C227EA
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 06:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690B15D5CA;
	Wed, 26 Jun 2024 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h77IsI6F"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5947F156257;
	Wed, 26 Jun 2024 06:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384979; cv=none; b=i6ORaJ7Rh1xK8DFA/bt2NHRoSNm7/HVYjNO4ticg6sPpMG89MGJcF2UtGRDBT6ZBcuVIWHvpC0tlwV4F9R5dLFBzRdAGC5L9ingh83w0FFfklt5HqMYURUW4JPBhoawudi3j7bNBEROKsRGCDEPnuqFrjlrW7v1GTAKjGWSbF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384979; c=relaxed/simple;
	bh=GjjBWFidcceN9FBBaeqyuuWfrJoBQOiSicFSBoajB3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/DmZjGEpTJSFaE2pEsqXF6JXGnXHTUNFGudCfmRz6usj7K7aAR8YClBzrW6pRARTk9Rp0yQH3ct3CuuJ5jB6M9eFSUASQFfjMbWo4Mmox3c/qB0Rc8LsCARvCy2Vg5qurNfXnCtfSB3DkjR5Kp0vhXuCkimei1qOKFtKZC2OiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h77IsI6F; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-7066463c841so3013106b3a.1;
        Tue, 25 Jun 2024 23:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384978; x=1719989778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kGgfX9zbx+1ufGqfPAiaiIQ4v/W7KvDv5i8WuOE1po=;
        b=h77IsI6Fq0/pvT3WUAkGClOXN/ZWXidVHlYukArbgwrOjGmfz6flbxCryBfR2CTn7W
         0gOq9oXCL1IycJ1cUddqCyWLsmfHUgUBPosXIWNAD6gccng/rszwTqww9uIt3H2Bg8Ex
         RDcuT+gfLbxvFhqPsaWPi+9gHUSHfX9tMtGryWNxQR35T0oBl4g0atPDqDtX/Onw0ZP+
         MaGjN6usf4xVTjH75ldrWeUiVLbYRoJcTcwT94a+eOkqbJ9iexi61C+AC7sutwBZSRRm
         7c+mLqICW0hMAdQLHvR58qhTg3xNoGad1vzTUsTtTt8LmfiG1TI+koUozn3AySyVb72g
         zdjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384978; x=1719989778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kGgfX9zbx+1ufGqfPAiaiIQ4v/W7KvDv5i8WuOE1po=;
        b=bVU78rafAeSKF3FxEGZII7kbQyYv6aQyHZCPS8mQa5iY6GjYGP8Ro4BZfluD/HMA/D
         az7n6uvyxWPFgtezATYgPzo+xACFR3IP6M0Ub8fi4P9dTXogEHY5T6ttluDTYlpuqkaR
         zsqAlAmo721j60qJpLdVNkPs+uCFQpB1XsUPzP+iDxJLisH5+rMoxB9aviWQXV3e25wY
         PcLfhpe8CFBBy8ujnn62PLrm7gW7D/vkctlg9A1ih/LokQXaTPOtRRs208VLnWTunLuq
         d1l3tRkhlM03Wdxc8dolbW8E/le8vnhZ4yNJEsoqrFfxtaiyzdvxmjo4ufhpY5Sy98aX
         3mSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkU/9KnRsrIabG2L1B+FaX4/qDWUwxt+ZoP3N12F0/eOlOGf4ShaTJV/kTlp9F31Rky0AHNKOQ1xikiI/6xiAsYtsTtWk4TyluHN6iUMPiQ8oMf26NVsvVc3qWPHUXTvnQ
X-Gm-Message-State: AOJu0Yz9MGbFljo8VBhafGUoCF2ESfXo/O0+SccWg13cRKC34Uo85al+
	yv7ia21lTDDe/tr5PdEP4Fw0Sf3oadasZctRz8kTTPVW6vL2derr
X-Google-Smtp-Source: AGHT+IFY4KPK1bUejlzRgw+dr3lQn2+mBfVKb7mehlfySXyxN75tEfT9A8yHQZIYAIQw69nrTv6Ukw==
X-Received: by 2002:a05:6a20:ba83:b0:1b0:2af5:f183 with SMTP id adf61e73a8af0-1bcf7e7ecd5mr8263244637.23.1719384977592;
        Tue, 25 Jun 2024 23:56:17 -0700 (PDT)
Received: from localhost.localdomain ([240e:604:203:6020:9d04:e74d:2a89:713])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3c5f87sm92776495ad.166.2024.06.25.23.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:56:17 -0700 (PDT)
From: Fred Li <dracodingfly@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	sashal@kernel.org,
	linux@weissschuh.net,
	hawk@kernel.org,
	nbd@nbd.name,
	mkhalfella@purestorage.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Fred Li <dracodingfly@gmail.com>
Subject: [PATCH v2 0/2] net: Fix BUG_ON for segment frag_list with mangled gso_size and head_frag is true
Date: Wed, 26 Jun 2024 14:55:55 +0800
Message-Id: <20240626065555.35460-3-dracodingfly@gmail.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20240626065555.35460-1-dracodingfly@gmail.com>
References: <20240626065555.35460-1-dracodingfly@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This serices fix the BUG_ON when segment frag_list with mangled gso_size
and head_frag is true. This patch was tested on kernel 6.6.35.

v2 changes:
  Updated with remove the sg condition may be more make sense.

Fred Li (2):
  net: Fix skb_segment when splitting gso_size mangled skb having
    linear-headed frag_list whose head_frag=true
  test_bpf: Introduce an skb_segment test for frag_list whose
    head_frag=true and gso_size was mangled

 lib/test_bpf.c    | 64 +++++++++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c |  2 +-
 2 files changed, 65 insertions(+), 1 deletion(-)

-- 
2.33.0


