Return-Path: <bpf+bounces-17018-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDC3808E03
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB47528235B
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61E8481B9;
	Thu,  7 Dec 2023 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIy4ZFUn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A472210CB;
	Thu,  7 Dec 2023 08:51:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-28a1625b503so422259a91.2;
        Thu, 07 Dec 2023 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701967874; x=1702572674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfvkcN6o80vR44tv59Fv+DvCuRrFNQchrH61xq9zsck=;
        b=KIy4ZFUnRuQ2gMQL3YzYXyuBdZKqhJ/v7XfqSAwJ8CmywHjVR2IpdlQJ0KYKqF5FuV
         waPevx9nl/3aZGnvzkk0jhRBlgny/wx3MPP7+I5JPBtDTLbfmlymMORRN7uhEgCOW80N
         xJq4i/e5NuEf4STlX4i8uiSyseTF3JFGn2YNfM+vSftuaWZb6IVgpw1I+xwYtC0Ujatc
         EPS2mlEfWomjF0u4GYoDCzsG4FHhcWbIXYxbqnvwmvIBLDNElCp8BKEX5PCJOStAYF93
         bg088DEoM+daNNs9r/orjVZEUVoBhSv3zXmHSDc5ZMhGuxYoFE6rxnVLlpIpEg74NX4k
         cANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701967874; x=1702572674;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfvkcN6o80vR44tv59Fv+DvCuRrFNQchrH61xq9zsck=;
        b=k+2VehPVAA75VovVlTRBGeyObktOJII8TX94NfbpcszdT5g8DlnbSj3rgx5uAB8ztW
         uKF/svdCajLt8G0ttOAIOrGFwZY1cHXImlfD7eneb9NqJTVaBzlVOADcYwT63l1FiCDJ
         6b9PtQQaeJbOrzjCTnOR7lbyTaTYQYCaDedG+rqOT3pT6pxeKEj6yF2TO0OXAPCgzkSI
         zVrVTf1HpF1L3Gloi6/Hu76BT4bUyJLnmZZeG/lFH84DCe+qAqN4Djf5KL6GswePOdLb
         8MqcsjeibbtWDoAlusV+YWuiOIWqSi9jsdsqJqdTwQI5uBbWnHNXC4KJ528VJRBcGX6n
         5c3w==
X-Gm-Message-State: AOJu0YxEyaRSS79ejlfk7ETGHWgTnGrxNlnkV5hnqcu+FATYGtljreVY
	F0fg2Xz0FieD7msjZW/JtzY=
X-Google-Smtp-Source: AGHT+IHvKR/OrCAoXvsVU7ZsOK198wLvOABXANVxeDeORTlOjRbxkol7j+fqv4NtaR47tPi5zQSn6w==
X-Received: by 2002:a17:90a:bd88:b0:286:c040:e6cd with SMTP id z8-20020a17090abd8800b00286c040e6cdmr3017468pjr.46.1701967874000;
        Thu, 07 Dec 2023 08:51:14 -0800 (PST)
Received: from localhost ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id v12-20020a17090a088c00b0027782f611d1sm1604537pjc.36.2023.12.07.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 08:51:13 -0800 (PST)
Date: Thu, 07 Dec 2023 08:51:11 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 kuba@kernel.org, 
 jannh@google.com, 
 daniel@iogearbox.net
Cc: john.fastabend@gmail.com, 
 borisp@nvidia.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <6571f7ffee3d6_1ff7208f6@john.notmuch>
In-Reply-To: <20231206232706.374377-2-john.fastabend@gmail.com>
References: <20231206232706.374377-1-john.fastabend@gmail.com>
 <20231206232706.374377-2-john.fastabend@gmail.com>
Subject: RE: [PATCH net 1/2] net: tls, update curr on splice as well
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

John Fastabend wrote:
> The curr pointer must also be updated on the splice similar to how
> we do this for other copy types.
> 
> Fixes: d829e9c4112b ("tls: convert to generic sk_msg interface")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Reported-by: Jann Horn <jannh@google.com>

