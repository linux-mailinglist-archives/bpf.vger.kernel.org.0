Return-Path: <bpf+bounces-61533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D2BAE8773
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 17:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBBD3177610
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C2F269CE8;
	Wed, 25 Jun 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwqLPHUa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BC0269806
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864036; cv=none; b=OTZcPJji0HtR2JHDdG8Chn3QV1UE18+LUZHYfSTxN6gYm0ieVqz3WXL2sdx6kkO7SVGe5wzIvT0VZlo0coMnH16LcdwvaSBBnRm6j9G6vqB7HzWvGp8uTS4U9bPmQwzlkHF6euir7GKkAowLpST3198O7iVuQbluYfhBuIT5YkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864036; c=relaxed/simple;
	bh=q5nviAyII7Hh14AkaO2uHcpz8MaYBrlXCzai8i2Icr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYq+mhESlgzG9wiSWBKtlfaYbjq/CXRyqNQ2tVdPHZm4ydVOdIPFaaKUjIwC0VdT6CHLWC4ikwbdpHuWfok1752bJIGeMs9yw++XibbRemdfsW8Dj8d0b5KeH/3cSZ7HkapwLBbIZ6hbObEBy/GhK93CqMHyed9Drr3rJbDd6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwqLPHUa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451d6ade159so50327275e9.1
        for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750864033; x=1751468833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WjQYoqci/qrxToR50QmpFdV0wns064FNlWvIK+glsFk=;
        b=CwqLPHUaXN4tjVJ4Py/OHCc+2PzQyJht6t7KhLH3ok7Hu1oMXnQIiBJUa2C3AmmDA/
         lEkkHBcUdGhVdDgonf23t6gFJWpYdnLo2bbgQ54yfzi6BL0LH1B78pevGyqg9VoacwKn
         kWJKbYx2U4fXO2kZ164yiDqL2E5YdW7BRGAgg758jpQ7ViDRRiK5hXH3bg8ZaXdRNMr0
         Ozf2kr1RR5gcOMRPAxeN6HICQ51ORM9v9SKxDgAGEglFxamiwAWaw9U+PRMxlkk+mASH
         Y6kMy5Ga3BfrPkGAxDgQG2HkEWl/SJbiql41hDKaiXYMp2yNrRsX86UgFXFxx5IQCBw+
         nJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864033; x=1751468833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WjQYoqci/qrxToR50QmpFdV0wns064FNlWvIK+glsFk=;
        b=amCOrbPEga2N75bmdrxOI/FjfCacUim1oERiCcZjhdl8NHbnlDWnruV8KpUFrhFVUv
         UoKkRixIaZkE3uF/FSQqo6q2swUhwYhSm2AU6TbouCOAdiflaQHfOta2uIxYaqR+BcvQ
         jSdlwP6Iod4Yx9LQltE3aFCzm1tLq627sWlvHWf/PHcyhalJdiPk5nM+O/N+1m2F2ZRn
         MyTkDflE7t4zMyAlRahM3enAG88kH3zBu6TlcLrbDRrk3Qq3wDIiiKvKW1lrxm/Cx/XG
         GMM2yVQc8IifBNG26rqIjfyoJ8mBj+L4TxdAbsfV8jNtmsxYDEc822HRUziPS0xntceb
         xPWg==
X-Gm-Message-State: AOJu0YwxM/BnDpFiC6/iPvdafvWtg4RFDMXSH426MCdm64foo+0v24rF
	qvy/8hL5eZAmOXZW2t3oMPXgjIi0JLBCloikEvmGESaddsJ8LpD7oTLU
X-Gm-Gg: ASbGncvdgDPkh2DmP64ZaxbfDw82lg9eE3PfM17K0wPBY8aMCyX6NmNBjiYhAJMorOC
	4SNwnfoO9MwellsymedLFYcLx8x/Vq8s1DrcomQZMIdwqf8vAzJTL7XBeHp5kiUh3GHcub/biEz
	amu1F9+TsdezlQI8HHHKw1ZBsX+ldueGAAalcOfYulzzCi636yMc8QcYjwf6vuK1D3DK/zgyRmK
	9iSjLJvfiaBLvA4biYJlNHjORBlnbPmYlpYxKzi1y12r9WmcZrtV8GQsCPlVhss48j+kluf3+Mb
	bHxDQn7mI767GpMc90xDAioLq0YhT5S4S83T8IPu56Q8gFTPUj0opAcCviBCtUo2M5wh5sTOMA=
	=
X-Google-Smtp-Source: AGHT+IEdjrMl5l/GW93DSim2CZdQPLQUkwJ8qZZXgGGwQbN9BzaXRf4Gk2NBDKW50EvjmC37MJkXLA==
X-Received: by 2002:a05:600c:1d16:b0:453:8042:ba47 with SMTP id 5b1f17b1804b1-45381b0aa8bmr32829365e9.19.1750864032502;
        Wed, 25 Jun 2025 08:07:12 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453814a6275sm19220635e9.1.2025.06.25.08.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:07:11 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:12:36 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: simplify code by exporting a btf helper
Message-ID: <aFwR5KFVjVKE6NVd@mail.gmail.com>
References: <20250624193655.733050-1-a.s.protopopov@gmail.com>
 <55bdd85e5db7dae94016ae57bf2d1ff233dc0881.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55bdd85e5db7dae94016ae57bf2d1ff233dc0881.camel@gmail.com>

On 25/06/24 02:10PM, Eduard Zingerman wrote:
> On Tue, 2025-06-24 at 19:36 +0000, Anton Protopopov wrote:
> > There are places in code which can be simplified by using the
> > btf_type_is_regular_int() helper (slightly patched to add an
> > additional, optional, argument to check the exact size). So
> > patch the helper, export it, and simplify code in a few files.
> > (Suggested by Eduard in a bit different form in [1].)
> > 
> > [1] https://lore.kernel.org/bpf/7edb47e73baa46705119a23c6bf4af26517a640f.camel@gmail.com/
> > 
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> I think such cleanup makes sense.
> Imo, the patch would be a bit simpler if:
> - original interface of the btf_type_int_is_regular() is preserved,
>   thus avoiding most of the changes in the btf.c;
> - helpers btf_is_i32 and btf_is_i64 are introduced for external usage.
> 
> E.g. like here:
> https://github.com/kernel-patches/bpf/commit/d3c003f0a83cb66700f6a6e9b750d8e425b53cf5
> (I use btf_is_u{32,64} there, but it should be i{32,64}).

Thanks. I also was choosing between this and what I've sent,
will send v2.

> Nit: the subject is a bit too generic.

Agree

> [...]

