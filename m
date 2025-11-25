Return-Path: <bpf+bounces-75514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A861C877F9
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6E843355D3C
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337542FF14F;
	Tue, 25 Nov 2025 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh2eSTbF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3F62F1FE7
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114089; cv=none; b=QxGyAr+py+RsY1TatA787nRg/R6qDQiOr0JEffMZOAYzP+XyYT78YW0ccjipn7oTMD/IT+kyKDJxXdAhUpFaNp/Uazq8sc9HO1T+UW1nS/+yXXVAcT+RkYYw3cLLyCbMOIYuNwPWKhm5QPG/8Jg2RwKZztrIwjJnaRYqfssrUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114089; c=relaxed/simple;
	bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GOJGVhuNCVpdPlEj3oFenTCKB1kGXHlQDsmv966OZsMU/qEDbHn9rarwcdPftb5qu7zrjmy/V1IJj45teSe+vyi289fygay6kS+khGRMsuM4UDuSioZNC9c0PR3gWDlPuSeTKb44c9j3/HfGgBVLB5lhl1/A+yvJKPEOXaloEaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh2eSTbF; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34361025290so4844756a91.1
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764114087; x=1764718887; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
        b=Bh2eSTbF+S2eJFmwCc1VKmsOxCMxgZ0bmxzfMfQ9jvpx/Uuu/exl9YrXv/CpYqrHPA
         MDznPP3EecuhDZxjOAIPcy9aUfePrAG1EUyAmCUiy64KsvYcFDoSKCseaORNt71vJ+Hq
         Xh+BYWayuqLVLedpm3/lQuvzYyqOoQymqd2HoBkBGfuHBmF+xj/ZaaSIhjHp2CcGjNOF
         ACSYynNugZr/MtNQd1ZesmPTUP+SkLkRvXqz0jInKZjs/4Vhj5MRmpQTnvHtd9MVwF7e
         GZZTTMD/yIUzeyFr6CeFH/mqtlwjLxDx7REF+C36qjFfi+Q24Ssk0cM8OSJGS0+ugu1H
         tFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114087; x=1764718887;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gWMb0VoUFPvI9dqT/ScM08+SFgSz52WvWw6dKZyzkX4=;
        b=U98mx/bRD+A2BSUZQb4xSv/QB+4E2H/+/hnh9nvyOcQifkhxWPz7NqH/sMFvCipJrw
         b5lrx9ybKiwamwVHlUqtqfHkaQgckONw3lliCkrhBxId+/R7KHspS90BizOD3fuanlPS
         2VT8sk9cvNTlmog44Ww+yReAJu3S51yH0CYNVVLIpRopDG02Io2Zf2nT/fhgQXQZZnXm
         ysaYt6xeguSaovXDii8RpVopBusaKrtsugjNIy7gdZ0+XtGaA0Ue9Rr2seZn4Es9Nbf6
         hTJDawC5UO26q14yhF7rd5MYwh0mRq6xdXdtUW/xLIOvrgnhD9c7aCSiffmsLZg4B/N/
         bwHw==
X-Forwarded-Encrypted: i=1; AJvYcCVBTV7LBMBbLy4Q5i3626OM9SrUqU4ye4IXezV8aKiqgk2ve72yIws0/2O9XmQTMyJt91g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjmsSVBPuJiyBI7NstuR72+OHXI++g6hMJkfuFCf92xQbPB6X
	ybbx/hMXDkW8ouYwVZVRdWoL7zdOJli9Uh7Rx6cE8wJaXqFZunVlKwwf
X-Gm-Gg: ASbGncu95AsclCBtElKvM13qk4jrGzNEz6aAiRR1RRs0dTbuOxrpqiH+yRTVtAwHwjQ
	Cybz45ukSMydxTJZJg/aQS7YxnDftIv+WB2Py06tvJ6xDNIX+B2oLw2tIdaP5NKKmxwGzjGdeoH
	nD5dZRpe6aoPCj7qzGS7xmK4gdXEuwv21cw9GR3JwwmVsomgg/73C83hxfA3d5uW7r/wJupk4KJ
	jFblzqrrTuNv1NLNw6MVsX81csST85gYkotz7wvq8+Vq6SbsrtCK3RzPy/Gc5hiQ6LnsiNIx1Wr
	PeD5mwE3Hd6rhwxSV0iL12N8DXJheOaK2V3GhUugOEeiaugnWaAAjHBHu0BvwUgyuFoh5IZxipR
	TrGsQ4UOKPfUeTfOjvwVhJUEfvq+DPuDXQrbuMhrMliurQKZ442yopQNpYvCOhVJLfMS9Rt7lEt
	2StNVAcNVBI7IXB5x5mYUFmRuLTXjYaGmcSePhXA==
X-Google-Smtp-Source: AGHT+IERAr6ZaAk8N2XfP1sLPZ8ltdcZpy2by33AewknK2HCsGdLuO/dThk3nDRSpzRLveBkNTfbCg==
X-Received: by 2002:a17:90b:3b41:b0:33f:f22c:8602 with SMTP id 98e67ed59e1d1-3475ed6ac44mr4636649a91.26.1764114087385;
        Tue, 25 Nov 2025 15:41:27 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0e6c9bcsm19291748b3a.57.2025.11.25.15.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:41:26 -0800 (PST)
Message-ID: <2f356d3564524c8c8b314ca759ec9cb07659d42a.camel@gmail.com>
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, 	chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 26 Nov 2025 09:41:19 +1000
In-Reply-To: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
	 <20251124025737.203571-3-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-11-23 at 18:57 -0800, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making all error checking
> at call sites dead code.
>=20
> For dm-thin change issue_discard() return type to void, in
> passdown_double_checking_shared_status() remove the r assignment from
> return value of the issue_discard(), for end_discard() hardcod value

Hey Chaitanya,

Typo here s/hardcod/hardcode. Otherwise, with the split as other have
suggested:


Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Regards,
Wilfred

