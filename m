Return-Path: <bpf+bounces-68913-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6756B881F4
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13EFB7B1124
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 07:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B52C0F7D;
	Fri, 19 Sep 2025 07:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKL9PODl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270B2BEC3D
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265930; cv=none; b=rrTXLjPdR7qPXvWZe+dPttBT0EMIOztDN3CVSUvLYkWzqki1Wl1BxPPwr1X5C+Ae27GoQ41eHmbLfLk6arpBMzIRP1Cj4ZRNUOhMXWevvIytNvqpI4oCyj/ypBCkcOUXDmMUc7phnqoFLjaAiZhiSPbJt4q1PlXIwFWgSPFFewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265930; c=relaxed/simple;
	bh=5HUTBORN3JSRILvP9oTyyZem9YsSTv6PD5i0mpuBCDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWExz7B7CDehElLFmr/PZ+vMBq3lyiskfNyEnCgWlZwEIUi+LiV11L+Lo4o0nC4HJpEBlPUUJDwHqWsX1WWrBd3U4fRC/aMFKkSbp4Co8sm7APXQHaVLXzfK/7NVMUFianB+RZE4JjLva8gCXabXJJ/yxqTVPOxz0jNdIzrlBmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKL9PODl; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12807d97so1296168f8f.0
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758265927; x=1758870727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W0zW4EgMrNY4xfO0+/4xP+wy5KEVkTr1c2+0ATCeQYo=;
        b=gKL9PODlFSIof7IvRFj08Pi0YA6UZu6y0TtN4KBI8j5VBn8wl4ob331C9HZ7fz7v8J
         COCqQLzriSdN0uvQgrVFBcmgY61H43jT5962pYNvO/5EOWt5dzWvdDUN4yNfNlWlbMNR
         umCuSPTEx0YMCDxWzeUuL4P/8ZesCIkbvs5dLpMZun7rrMv4O6bGbGhbT0kBqLWEq5wQ
         7gcoKRxXVvd2HfyGqij6NroKCVB7In7KfFjIVIZcVRFjZrVD8o+EhoK3xHPrJ5JT/LBs
         zpmTe3i7iuIHOVEjgMGklDDUwXr2b/8alBY5m7fJgl+NdK8r9JGUKQrMwJjfGppekrPY
         xDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758265927; x=1758870727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0zW4EgMrNY4xfO0+/4xP+wy5KEVkTr1c2+0ATCeQYo=;
        b=IGv6ERqhalyQ0UJAzAVOjpX8Y+ZxIinHC25ObV8dNaZ7IhCNsdsYfZfj4762pTpJuT
         as72Kf+nfRsAZvGXRiz8oWKwm0ZTfBm1/RvmfK37ekMG9K2H/iUME2R02UjkwYLj+sWq
         2JE/6OTi7MjLQdeb7+hZa5LkuAGxs6J8ib+N+QsysheFDhiQbfS8WjCpnD1qbAfNSPZB
         RxM3CN22+BebcUvhRK8loeAbq1p5yzBLmnCBxM2LVUqp9eovh46UYpCyqNOsQ0uJYmOQ
         uhBULU1a9wbYoStDofqbPVb5RQ00NpsaUNoa2PDR/s+6NkHxKq9QPKuqpv2cmtsCd70R
         WOjg==
X-Gm-Message-State: AOJu0Yx8/N0vsAvHy1hsEdmTW4tMiISrW2uwz8aZ/bPEwCmDx95MT1cR
	HJWegDN8j88pFRbNRkyKR7F1dO+TEaQjkXf4CJd/1DibJK+4k6IUduAIjp5Cdg==
X-Gm-Gg: ASbGncuZyIG7Le6+WeakDHSdwnMN0xORJYalP10PQXmDH0Z7vNZ0GWK/Y1qMQwZFtQm
	P7IEzbV/jsEgHr7/Uf7VSi5huFLJfxnMHIvzQsiNwTr8dmAZIc8HpTgEt5z+NIyyqzMivpt+Q2p
	918S56r/OSjxUJgpkp5EOyytiCKl8MydSyYjiwayitIZx29WqQLBBIOnduWSuBnw1Mj1Gxpmg9M
	LPx5l7vo1H1VytQH9Ug3R3bHqh3RmcMWp7zyDbiIl+azuAOu0ilblhxmiibWB2MueoQcs54T0eT
	1TwG318UEK/itjf2NTRPzlQ4/JEEo7EO5k67uj06VRR5HN1KXmkAbX5NOWyN7oyhPr/DsIba+Bs
	kx5dI9TydJsMhMpa8xWBp8rn4Jt1PzN9S
X-Google-Smtp-Source: AGHT+IFKyqhvhvq9QIQYXJGM0k4aNBPtsu2ydZgIs/AOziw7EBDVhQwItP5mJ2/QjXYWpFvgkXQGig==
X-Received: by 2002:a05:6000:2509:b0:3e9:b7a5:5dc9 with SMTP id ffacd0b85a97d-3ee7e1061fbmr1751187f8f.23.1758265926413;
        Fri, 19 Sep 2025 00:12:06 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm69416225e9.1.2025.09.19.00.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 00:12:05 -0700 (PDT)
Date: Fri, 19 Sep 2025 07:18:18 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v3 bpf-next 01/13] bpf: fix the return value of push_stack
Message-ID: <aM0Duq2W3Wsv7GsG@mail.gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
 <20250918093850.455051-2-a.s.protopopov@gmail.com>
 <da197caec5cf8d4aed067c94bbb13ed62252ad62.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da197caec5cf8d4aed067c94bbb13ed62252ad62.camel@gmail.com>

On 25/09/18 05:17PM, Eduard Zingerman wrote:
> On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:
> > In [1] Eduard mentioned that on push_stack failure verifier code
> > should return -ENOMEM instead of -EFAULT. After checking with the
> > other call sites I've found that code randomly returns either -ENOMEM
> > or -EFAULT. This patch unifies the return values for the push_stack
> > (and similar push_async_cb) functions such that error codes are
> > always assigned properly.
> > 
> >   [1] https://lore.kernel.org/bpf/20250615085943.3871208-1-a.s.protopopov@gmail.com
> > 
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> > @@ -14256,7 +14255,7 @@ sanitize_speculative_path(struct bpf_verifier_env *env,
> >  			mark_reg_unknown(env, regs, insn->src_reg);
> >  		}
> >  	}
> > -	return branch;
> > +	return IS_ERR(branch) ? PTR_ERR(branch) : 0;
> 
> Nit: this is the same as PTR_ERR_OR_ZERO.

thanks, fixed

> >  }
> >  
> >  static int sanitize_ptr_alu(struct bpf_verifier_env *env,
> 
> [...]

