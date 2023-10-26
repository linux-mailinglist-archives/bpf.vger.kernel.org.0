Return-Path: <bpf+bounces-13305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3106A7D7FD7
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 11:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B771F22BC5
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D628DB4;
	Thu, 26 Oct 2023 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Cv8jrPMK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111919BCD
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 09:42:29 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C423F191
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 02:42:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50305c5c4so10543051fa.1
        for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 02:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698313345; x=1698918145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I1YjaPyKpXLKxHhZS0Usr0ADtJwTzKNok3jFb0uozho=;
        b=Cv8jrPMKHHdPB9/SSl0bOBllxLi2DS90UZWDbj6JbfUrGisqvAuduoz/we+XeFh/Hz
         TjXezt2ieqJqK/6EAQIXq86mMG7ahPuHDbop9GBRFbg9z0KWurUrg5tjum8Dz44+pcew
         3G+H+0GHI6A+7YvPbi1UZqMcnr+riywc9UEbn8iDURWrbh5KCjAvC8gmAdwmiSXRBMe8
         pPjofQpZYL65hdEIhheQRzXS/1SGhECfbF0TVGv2maI9cqE2yu23i8LJ6D2e/VEScvhi
         P5F4Ga7arTliZLOheqY59NeqPa6T1/nJMu2rjRqBRMakTiqL8xl7zf6Iw5kla8/IEvG+
         SnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698313345; x=1698918145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1YjaPyKpXLKxHhZS0Usr0ADtJwTzKNok3jFb0uozho=;
        b=oSE5bQW7xohzAyNTjrp+sWN9ECNwO/0eUQ5uoSqyFfGrVm1vqO7e1HlQn4GrpA1RQC
         pQ3hseNCTPghIbYlmQfNAmuxth3yBTb+f6jhXpyVMZzGzdiqVMlcNllU0GjFLZRpcQBG
         KqS5LuiTsBsDMEEM/WE9MczvBlR/xOK8lITtB9+dNmGDLrnYwaj28qq2f1wrryCH9kpA
         euOCKEX3yZpeSDfoyonQXSYZ5sf6RNK9zMCNqTPKt+k0KVxeLkdUax6pCxDtly/mrm7B
         Uahs4Yc/wv8B85ubWim/mDbVt4q2EBu3GgpMyhFfY/eaeZgcBMgSW0xVVlu0cKFzZZ2a
         NNdg==
X-Gm-Message-State: AOJu0YxQ+s+mLLKpyahTsQq2LYsfO3JgdJmayBBUxCjHetCZr5K6EX6f
	74iOisLrtjHV6zxpfdIokxuaZ40mx/kH2+pA4kygyQ==
X-Google-Smtp-Source: AGHT+IHgfHHwkViHjuK8uKCZQ0P5j/mm2O/WlfvbkFaMVP5tG7fch90SVK7yO49mCe448n4v9SM+Ew==
X-Received: by 2002:a05:6512:4885:b0:502:9a2c:f766 with SMTP id eq5-20020a056512488500b005029a2cf766mr14468732lfb.30.1698313345407;
        Thu, 26 Oct 2023 02:42:25 -0700 (PDT)
Received: from dev.. (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id v13-20020a05600c470d00b00407460234f9sm2082121wmo.21.2023.10.26.02.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:42:25 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: jiri@resnulli.us,
	netdev@vger.kernel.org,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	andrew@lunn.ch,
	toke@kernel.org,
	toke@redhat.com,
	sdf@google.com,
	daniel@iogearbox.net,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH bpf-next 0/2] netkit: two minor cleanups
Date: Thu, 26 Oct 2023 12:41:04 +0300
Message-Id: <20231026094106.1505892-1-razor@blackwall.org>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
This set does two minor cleanups mentioned by Jiri. The first patch
removes explicit NULLing of primary/peer pointers and relies on the
implicit mem zeroing done at net device alloc. The second patch switches
netkit's mode and primary/peer policy netlink attributes to use
NLA_POLICY_VALIDATE_FN() type and sets the custom validate function to
return better user errors. This way netlink's policy is used to validate
the attributes and simplifies the code a bit. No functional changes are
intended.

Thanks,
 Nik


Nikolay Aleksandrov (2):
  netkit: remove explicit active/peer ptr initialization
  netkit: use netlink policy for mode and policy attributes validation

 drivers/net/netkit.c | 70 ++++++++++++++------------------------------
 1 file changed, 22 insertions(+), 48 deletions(-)

-- 
2.38.1


