Return-Path: <bpf+bounces-75511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF3CC87782
	for <lists+bpf@lfdr.de>; Wed, 26 Nov 2025 00:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF6CB353E7B
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 23:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611162F2607;
	Tue, 25 Nov 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RapJjHXY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25022F0C66
	for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 23:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764113618; cv=none; b=o/efeLh2LsN8CaNKQALkyvBe++tIU1ePJ8NsbXOKp06v+HfeEuIYzTRx+gM8NvscxrL5VkOEKW0PFlS0jeIKmFDoB2mLJ27eoQ7wvOfThLOyjuWhoe8wFS9G6nXa2o5i9CHL8h4LvD5Tp1QSrKX5fNAE6lrRfBas2WL3PLgmC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764113618; c=relaxed/simple;
	bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aWPqc4kc3b0VXKcfF/gyx58B6V+21dSWd+wQ+C9wfWtSA70kDwLqBxqscCSDO9xLmn+XugWbW4XujR131iWQUYp6zexaFUi1D2rbvfomozzXAK5bhTctbDtLe2IkX6xtvF5mDBq3Ka1HiTMtolsz0M0/PS9h+byWJ7ZMmJLIgz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RapJjHXY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34101107cc8so5581040a91.0
        for <bpf@vger.kernel.org>; Tue, 25 Nov 2025 15:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764113616; x=1764718416; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
        b=RapJjHXYPOdTLcYLs/FvDuCH+2uk3C4YvOZho6lQ2DUunXzuffgOyrJJdJTT+zKarB
         Y5bxS7QTjTICzx73EqYjfUkyl0FVw4x9IAxmcOzG0aCf9aVAGcQLF+SDf8po/2gyqqil
         u+gb4VscO1GMmQtuJOgEikKXerndt1NLulnw2mreQGqo90I/pv4WCBVSlk7wWQqvo0fD
         8ZxKliCAngF8pEnFcZP66ohQJSs5e4FCjllfn5lHxNKjvERABRh6B4AROdQzHDTgEkH+
         MWlBTtaGwqr/gZ+ENsb+GNvzwbp76+nYbH4gEUbWlRmpDTMmG7owIjbQdwNz9RDxBy+J
         8lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764113616; x=1764718416;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rkC5tVLIYNbT+NJhSO0xtU9bfDYrwdByb9M2iU+wBw=;
        b=G55OoSyYij1xEk5jVRIL/8QVBPR6EqWHK1705wua30Onf2VHtTGOSzYqfVg/xD53bG
         irhUNCKpmPHKfNKvENGKQ+Uqy2hr/l3tJDcMAJNBci7brqbN98dMOd8KdYYEWTEVzsCB
         PtU7U0gwrfJqHmghYSzWHGIJeDTRbv2hunmJ/hp/0ts1424y+MDzgKALPRhyJcgimHzM
         lvt/jTOO9goJxnPRCAKuHxwNBKeKr+XLfwFC952UvD3Mm/ZxkkW933D9oJAhLerE9jWU
         iLtSQeYCl+XWa9ZLWiFb9KxmestbebLBt/dWD+ve3nrn5qP8Wa0icDTZBeiQ9LjdqkFI
         t0XA==
X-Forwarded-Encrypted: i=1; AJvYcCUtkJWj6KTF96T6V6CAPCBW57Pr03aFsRB4Vwt++cssEsOSxotyGLzWPxC9t508EOSrvBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbQPd9b3Rg9xaexOoObVc93P0UlbEKg7dQ6tM7ytkqG4ABkSQn
	e3BuU/fKdgqN5rmnT0PKBEyyfoDednmiHzUf2SkRAIWvt/azKoO0eQSc
X-Gm-Gg: ASbGncvwtLaj0BqKKWwDuLTjpq5Y92WEQWpoVcMZdDM9kjkSQ/e1jrLal6pYoFqQW81
	nLRQb2hzTtouaCi4tQp8r71UQMNNDhWM/usOYR3olZQ1nt1noNFywfYgvR9wnlMYkT7aC2RJfNQ
	mtAPuftWFCcuAFHBzxXZwECDfbHOKn2gkhb6LYpNReFeU4C8G3rax9qUmnnS1y6bIMEv6b/4+8J
	gvAaI+2zzLHAC5UYxXFI89Pl6t0uDrrvqy1LE21UmQoP0SV2qS14EVlw+XdxZpNi1Wuq/1g6xt5
	fEA7uiTfThgZ2EkqL7Yc5Jflj7IkVEtEvF1weAAPq6Mov+ON29K0T/W8DKX5BTJ0vAvxZTM3kFk
	K2JsNbLvizNgpbCMgQUVmVJIcoN1r/4YaUYvvQaRWrDD86pgYws80JrzYR1QbY4TpCnl8OcDon5
	aMOeRpCU0SU9amAm80XZHUI81l+3g=
X-Google-Smtp-Source: AGHT+IGN2yQvKPDnQSI+rfi8GFgwmIi2Dp/WjRDvh8wa+7M3RBmYm0POoYwrQhejduq1ue9sQHFv6Q==
X-Received: by 2002:a17:90b:3a4e:b0:33f:ebc2:645 with SMTP id 98e67ed59e1d1-3475ed448a0mr4374100a91.20.1764113616140;
        Tue, 25 Nov 2025 15:33:36 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3475ff0eae4sm1654152a91.4.2025.11.25.15.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:33:35 -0800 (PST)
Message-ID: <2146e663be965ee0d7ef446c7c716d1c77a8a416.camel@gmail.com>
Subject: Re: [PATCH V2 1/5] block: ignore discard return value
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk, 
	agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, 
	yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, 	chao@kernel.org, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-xfs@vger.kernel.org, bpf@vger.kernel.org
Date: Wed, 26 Nov 2025 09:33:26 +1000
In-Reply-To: <20251124025737.203571-2-ckulkarnilinux@gmail.com>
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com>
	 <20251124025737.203571-2-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Regards,
Wilfred

