Return-Path: <bpf+bounces-67772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412BFB49836
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 20:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D6423B8918
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A1E31B11B;
	Mon,  8 Sep 2025 18:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYyTBYA1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E531AF13
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355816; cv=none; b=i66IveXDTn0owyFF5vFB7gkFN595LiNFatLnuVKA6Y8yglJf5emfr3emFwYi9DEMrZ7Rq8B00sOodZSBdsPjyBRTuyQa5wnhhYHbWjl6RMh6RNmL1rHZ1c4l7sDdPNCQaU/I7l16bs5FeIrQl6YELRijwWDTDVs4s31DmZlnhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355816; c=relaxed/simple;
	bh=HclATjovxAq+uVL8NngfjN13SsL9b4dV18CwR6NqPrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EeDfOhYO7ez32O8bs3ukNH0eFetgI/QwckWlAs9J4NldW2PXmglrhRuYX6H2zzGN7qZie8FOEqFqi7Z2oj3eD+i0yeZddCUctWLeAUC9bpfNQwR/+A9RCtznZK/Kzzc++MehHsGk4Z/NhVRDkmsq+ITTAARrNUktWFi02bJnnw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYyTBYA1; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7722c8d2694so3994892b3a.3
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757355814; x=1757960614; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HclATjovxAq+uVL8NngfjN13SsL9b4dV18CwR6NqPrA=;
        b=YYyTBYA1d8wi08ed3s2DvPeB5d+Y7no2ADmvNYFbjjrwGujGLavi2C2g6VqDnCqlZa
         +eL3XHkgR2WleLeXSquVo3lqOqwayaudVc+dyIOm83DTSAE1uqIOJqLNNiTYpH82wgJK
         OO7ixnrP5WjCxP+mqIiHhmmc5mZZTHnRTmxXw3tnKFyF7zJB0oMVNWrkWlDyt1kgyrSG
         mnMKY2e60Sv2ikIMtsS+IAXkmkrWgO3/43U1/x2SQmF58OU+56R2LrGRjRYEYX8fAkXh
         Dsl/SrtDnaGt3KktfYUjfMF4QodDrQnZZ85pVQzGOQFFZaX+CymLI5Rt52NdOINaWzLo
         GXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355814; x=1757960614;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HclATjovxAq+uVL8NngfjN13SsL9b4dV18CwR6NqPrA=;
        b=SNrPaIYEoL0Z8vhRvgUsmfN9j5xo69MAhHvNwc0U/Rz9sa/RjgGDt6JEadXO+Q2F3v
         4O0fPvJASZEPRCf9dvd9E0gS2/M09nPmDEdY3iQ/EeW5mPznjHqmk4z54rZ2OKKS4q3j
         I9y2g8B4yNdkcRNA2pGb6v4edWbTspDzHQDOGv6uDjgVG0BxKDupRm5wafXzL19Gy0nh
         QxiQkYdeM10pBVQ7Ua6KjLZhYcs1meKuICewfGramIG+0pZR4/oA/rcfj/hJd1CL41tF
         +Zl9dbOZr3ScyndDtMgP4TcuujqJoHNSU282eYCTu/ZJOWhgYY/X71klvdJ2/DOKhLLN
         fV7g==
X-Forwarded-Encrypted: i=1; AJvYcCXP+Iut+yv3EaKz3xL8tHtDBzEaww2aBqPkF8qywlG4BZeRPjDiPexcdUY2ZBtYgbfHT/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YybUgoSqVJ8atqzQV+IqZDGu+S4ZBtnG2Z86qMI84MiWy5Dz3Cu
	PI+nmvr0JX9z6D40dqEzXNjPAC2B5Xrv4MrfMqARhekV77fJzLZ7P7tLskikE2Mv
X-Gm-Gg: ASbGncvhnRKUf2fgkqpqD0n5zWcTpN74piTFsy7o5fv8UaTYX1k7QeCBa7kjHJJn2TR
	yd+zxOFdTvFif2IvHa++e2m36/DU1BnZqzUAuaBkIdX2alcr3SuFCx0BakeCcS+k8lpw26GCKxT
	dnXzkL7TlCTdRUGO4YDK81HW+ue6hfy8LHozp92Y1DtZdcxJoKd9bYlQdhuTZZ4BvH1LQKkrMZG
	zfmne1m69eXW3KRILHa5FmQZc8cr8XB7EsYjLBawz8xp45RIcZa9gxfltAZf6OMmXw+VzZ4d7pc
	vIkUIRYtN+6SoAwbYFJxxx3rQWpfmiS8j97v6wZhkPBVmqnmu8hZ7fnfL9iCM1M0ghVubPjmJ7M
	UMeZQ2n8oy4v5BygwDPcGymhp+GiVRahBQYbdW0R5p/mlf5Zxp3sID1X43/vxhbsxq2Sb
X-Google-Smtp-Source: AGHT+IE6bK0z24Y8NyiPs7/hS4b+FZCFbTAPSHuurJjaNrzkq2QpcCm25ggRiGPypLk664MNnVD9kA==
X-Received: by 2002:a17:902:f78f:b0:24f:8286:9e54 with SMTP id d9443c01a7336-2516f5209c2mr132579795ad.15.1757355814279;
        Mon, 08 Sep 2025 11:23:34 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:613:2710:d29c:cd12? ([2620:10d:c090:500::5:c621])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7ecd9cafsm159247705ad.83.2025.09.08.11.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:23:33 -0700 (PDT)
Message-ID: <8c97ee69f5fc1e660054aea46d2d6bb0693d931c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 7/7] selftests/bpf: BPF task work scheduling
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Mon, 08 Sep 2025 11:23:32 -0700
In-Reply-To: <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
	 <20250905164508.1489482-8-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Introducing selftests that check BPF task work scheduling mechanism.
> Validate that verifier does not accepts incorrect calls to
> bpf_task_work_schedule kfunc.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

