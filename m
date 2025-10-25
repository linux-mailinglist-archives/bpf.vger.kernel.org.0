Return-Path: <bpf+bounces-72180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E44AC08C6C
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 08:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3B93BF391
	for <lists+bpf@lfdr.de>; Sat, 25 Oct 2025 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C762D9EDC;
	Sat, 25 Oct 2025 06:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iE+Gp1Fv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC421ADB9
	for <bpf@vger.kernel.org>; Sat, 25 Oct 2025 06:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761375201; cv=none; b=MH14KIzFCnVecmilFKL4REglvfyGWZtmvUJgyqPKjNKasom9GvdbpFjuTr0VxpNBC0Q8wwX4nRumAOlRjNMSh1RPgFTbLXQGJTYJ3kaNXbUeKqvEB5h5lGd+OQ6TWp5JkkIIgRNVZRjpDfQQBS/Hfmz+KS8OOIZYvisdIWkXjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761375201; c=relaxed/simple;
	bh=w99RtLvpk8UVgGX6ieDZH4veRr9AEGHKN/Ya9s591E0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VJ8PL6btF1HhpB+kFOvlxDrEBp6NRIeO/YvugfzUWH2EfaIcmeNBQoFuqWsZJ/XECLmkswSaxdJeIYrVxxKW/kGlxGnmqs0A+Rs0/rylcBIdyE2iiz33LAzJ7bILNDPtPdIcHZpy/Z1OX7WkaqfRwurFxHR9ZAj6JnKnv909rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iE+Gp1Fv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a28c7e3577so898396b3a.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761375199; x=1761979999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kp1JMEroAvT24q+TEkRbK9XSf980ZtoUE9pXBiTTcZw=;
        b=iE+Gp1FveUCkDgob1sSgjodFoBV8V3Up+0YyTlZV4re4NTxFcqkNs+KeMDXTLn8Yci
         dbftkWMH50WbegbZ/+rq88vCp7YrK0rDmkcUX7wGPbuBiGcfuE220E4ysh/MXNF4BO8L
         5UqV3CRAm+yCLdw4cUVfTqbGyCnFqPfTs26iMPKA/p9W87licz5fbq13f2kXH4YAgmpy
         u/SiyVneLWdYNGKxGzKrj2uGtma8ee37Yk+z33PegNCQ9MrFcKI09QyihLvBX0cUZqOU
         68hCZVrvigQvaf6elDJQ5pv6grJRR3mNu+5b4r08Myx2wnh4wAxBbTLmFpQFMvdiY4jm
         J45Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761375199; x=1761979999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kp1JMEroAvT24q+TEkRbK9XSf980ZtoUE9pXBiTTcZw=;
        b=f5clxqAJdyFewaJ21jFDQ0xJQwQDEWvO2uT2SieuWsbV6idUbe8bCM2QcvnfsfCeP3
         50X9Sz8xGiNZeIuyVT+H+8bosFw1y7d/sIjO8H+0N1mvb4ZJbduwFVkZRAbi0LqoL3WC
         Xfb8CR14o22n+cGYZ0t6WlQZHPZIiw7VbSdtq/majMVL1CfhGOlkfmi/40YEtnDgmjCk
         wGY9gIOiJcZUe4N4JI1gvlvvxyvmfI4ZS3GuzZH3H3Qmucb4zFWT/NyQpXih6xZXLvyx
         zvdppjHAIh9Vyt/na6T7WHggHQSOOmtsA8AK9TixzCisTnzP1Kkr8ibPuRPhJoQR7djB
         oonA==
X-Gm-Message-State: AOJu0Ywd72mGiSjcgpaLH4x22DqjLhmxUIbcl93dVBrU5bxrWgVpy+Y1
	8mEa8hlslaaUYJZ6Kn8Lfvpuo7mJjvbApAn51MziFUbr4u4X0UEQTAIt
X-Gm-Gg: ASbGncv4ktwm222pTRvxm0S1cARQ7yRFX0ZyoCVk3JmtkuKMwMApPobgxaejOc3/cag
	0hs7e1pveMkoYwEwjaeE82yxwdoDiUu707aRVP75g8Q9BPDOh19uq16swwEK0inZCLWQDvReB8/
	mvcb7jP+UPEb79a9rDz6gI4HJg37j/xCjGfsKwwdHNw2WwkAplHnuCh5vD+sbeqpXDXUBXka+pL
	TFgela0orDJfTaJ5XqJpaSiHrmuI7nmF3qStyTFuL/v/ohehOXMWF29ALNgJttglCyDNCKf78wM
	23JiZCpzJ8Q+7ctSXRk7xxSkKBd4zzaEd9H3o4uzb5d7rgPznePhP6XiuCtTW5bw/PLbbY5Bi4a
	GWD12xIScOfhKrevQFqFa3XUQwT4wP+Bq2GvOVrK8XTdKit8kCxz04LP42UpbEyDkJy46WaR/OS
	qQnxZ79Wb/R36cd6lOgK8UYTSTH4pkZS2EwGnA0UeDuw==
X-Google-Smtp-Source: AGHT+IEFW/6eK7FLLLHanhNe2hYWEwfdayYE2KNuu89PBLF3Wc88bg+ZRhMRoOMulVRY8+1YDsQbmA==
X-Received: by 2002:a05:6a21:778c:b0:33b:1dce:993b with SMTP id adf61e73a8af0-33b1dce9c9dmr13244537637.10.1761375199251;
        Fri, 24 Oct 2025 23:53:19 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.29.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a4140699basm1262820b3a.50.2025.10.24.23.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 23:53:18 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
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
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] xsk: mitigate the side effect of cq_lock
Date: Sat, 25 Oct 2025 14:53:08 +0800
Message-Id: <20251025065310.5676-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Two optimizations regarding cq_lock can yield a performance increase
because of avoiding disabling and enabling interrupts frequently.

Jason Xing (2):
  xsk: avoid using heavy lock when the pool is not shared
  xsk: use a smaller new lock for shared pool case

 include/net/xsk_buff_pool.h | 13 +++++++++----
 net/xdp/xsk.c               | 20 ++++++++++++--------
 net/xdp/xsk_buff_pool.c     |  3 ++-
 3 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.41.3


