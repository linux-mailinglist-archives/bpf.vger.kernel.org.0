Return-Path: <bpf+bounces-63264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13803B04A03
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 00:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4142E1A68544
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 22:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947BF277CB1;
	Mon, 14 Jul 2025 22:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leKMB9R5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FA7464;
	Mon, 14 Jul 2025 22:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752530858; cv=none; b=HPcUaUbFXrDyWsCujBvjwnd9tNpvzGuCAtjvMHzF0/k7sd1Spk1HihXCxuin2o/QEYLO5TbvtPkv+BlsbBMPF2U5niDZMjAR5SmM4DdcF43d7re9jeRV5lX/b8f6ILT3d0LzbWwetlc3AjkA1Fs5o4v+b8Y4pmR8c4E319beFE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752530858; c=relaxed/simple;
	bh=MK3kYtGABmqsAIEWyUhk3NP5fzBp3bSTrD7TC3IS7FE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8vdHJs7s8dAm5JRNvK8CGIlixZ0G3W7i2gCM1eRctTHqbBbcmbNaWR3zoW9Y1BpQVkBj/EEN7N+7mvdxfZDDSoLMQE4hvkC9NazArhxxRIZzWVWgpa0yYLE697HTMww8ynrwVidVui8y3dnmeHfxWHcZ+tmP9vkUVc+mWsSLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=leKMB9R5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so4164731a91.3;
        Mon, 14 Jul 2025 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752530856; x=1753135656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkIYZ72ukIPsmRIuz1LCL/yvWTo9v1mjoyd7jBYBxv4=;
        b=leKMB9R5mbtmp/HzbLkKTJ6HzRKNLz83DHCFl8+MkqEbt8WNSKczF/E8102z7AY7/X
         5NJ9AkGEXpNQOZxTMGK05uZuRzc/BzKQvrhxbaPS5E6pw3aJi7CPRirBkc4LtVFNqwgZ
         awqFiMytUuMW8MxY6ZOovx3ER8j+6Ik2DmcYjmWy9ZvqkUPP2Bf+dxVW8EYjOqTCznl+
         FLIrrYVUO3AgCICWc0C69osoWNLYW1N1P4Fil/6Nayh/sEIOp8WEwuaB3g2zoR/FDJij
         eZR+ceSm/cvnQElYPutS00I7bWTZZG6+O7j/n8hWZ1hLc6Neuze55tbvMdxS/UQ7u+id
         CVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752530856; x=1753135656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkIYZ72ukIPsmRIuz1LCL/yvWTo9v1mjoyd7jBYBxv4=;
        b=W4n7sEz7cXTHL2OengFZBVxjVmIIrqyG5i/PrIXY/Udn9bPUEC+j6wCApWGr2W8RX3
         r7C80xqalNNNfoQa1xYdkEHa+TAHDNCP9FT0KHVf+JycZHcxIgimk9KbtDNUHtHGgDxF
         uLMU3UOK82+tGO+/8s0aF9qT3ijN4Ljvx4bm4emMgUGgraBFvil8pKoQau90lD3m8K5E
         d2STHq0eOry+X1DOeEy4uQkF33QlFX7cTiGEp0e718kZqc8d3h0zCS19gJE1Un/0ouus
         RhinUU8oKiWn9Va5FSX3uqbSHPNVHkDeIu/StzElEeyk42XcMVMk1J5ox4mYKlhvVHBQ
         R3ag==
X-Forwarded-Encrypted: i=1; AJvYcCVvxOEBy10mmLYKUt9BDhoYydL0eLaXfTzbRyZ9GyURAT0t3xlQrXKmsm04zkwMSzp3+EIq5C8N@vger.kernel.org, AJvYcCW+6y6F+SyqVDnF4IQJcN/KxbeHKqKpJ1jUl9pTtHK25PvRdnlP3pZv66dHUePp25JMtGE=@vger.kernel.org, AJvYcCWK84/SIjYHGHw2y/ueFlRX/BD0EujNZS82/blr9TJfFSGyaW+ogBztBf198G4BSqpC4xoXWhYO5gTgoN28@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9oQPcI6ggpgozuCB4MOwKCagC7RrkgL6ZksvRG8/WVZd9QuQx
	/UcE0BjNDkNHVOmlNFRgFwq1K5Pupof1GIVVZPAwfsK29SzzvAzw+LnGPbrYATuHAntz/hfFKFD
	dm/2FC9l8lh8EQ2NQQhTz27q3/gn52hc=
X-Gm-Gg: ASbGnctAkg4ulngGgENgcbAySlArTriiyroxy4GjFtTBKFVpdzInjlzq7iRv6zX4nWv
	RKsHJ2arfcUXImzy85KQP0StwdTQSvJxZiMEe4sd0UwOnEaozNCz3la2XS5bz/trlC36STk8p7H
	57TUh5P4559agbGBFoDA1p4AJeveyq6Clwp3/sFTfVidVy65C0nkLbOKqtE7hsXn3f5QE6RsIAf
	kaa1ICWSlwDKamQHfrZdWg=
X-Google-Smtp-Source: AGHT+IElP38vM5JctxjxGKYGGlQG5S6qpewEI24Ho8Bm+BRc8vwsFKVeihi09Yl7vbLac1H3TEq7uGwL+gQSu38dHzw=
X-Received: by 2002:a17:90b:578e:b0:311:e8cc:4256 with SMTP id
 98e67ed59e1d1-31c4cd6303dmr20673895a91.22.1752530855760; Mon, 14 Jul 2025
 15:07:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <20250703121521.1874196-7-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-7-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 14 Jul 2025 15:07:18 -0700
X-Gm-Features: Ac12FXz2JbNuO1oAkK98UO1EMtPnASpDeqQmKmvQa8tQtO1nvdWtUQ0ICS-qPgs
Message-ID: <CAEf4BzYpfYJyFKj0Uvtj+h2mBe1AXDwa2pfFCF7E377JufSU3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 06/18] bpf: tracing: add support to record and
 check the accessed args
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: alexei.starovoitov@gmail.com, rostedt@goodmis.org, jolsa@kernel.org, 
	bpf@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:20=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> In this commit, we add the 'accessed_args' field to struct bpf_prog_aux,
> which is used to record the accessed index of the function args in
> btf_ctx_access().

Do we need to bother giving access to arguments through direct ctx[i]
access for these multi-fentry/fexit programs? We have
bpf_get_func_arg_cnt() and bpf_get_func_arg() which can be used to get
any given argument at runtime.


>
> Meanwhile, we add the function btf_check_func_part_match() to compare the
> accessed function args of two function prototype. This function will be
> used in the following commit.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  include/linux/bpf.h   |   4 ++
>  include/linux/btf.h   |   3 +-
>  kernel/bpf/btf.c      | 108 +++++++++++++++++++++++++++++++++++++++++-
>  net/sched/bpf_qdisc.c |   2 +-
>  4 files changed, 113 insertions(+), 4 deletions(-)
>

[...]

