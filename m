Return-Path: <bpf+bounces-30015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C305C8C929C
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 23:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 009AF1C20A53
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58C6D1A9;
	Sat, 18 May 2024 21:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muz41a6D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467004D59B;
	Sat, 18 May 2024 21:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716069069; cv=none; b=DEpCFNspT7hTZ6Yb9rvdunWvsi2bRTivmat5Ib+m7ALMM7037hk1ZbUVCHC8lC7zlu91oDG97JSikH8JnyetemT3GQf6LjDXyxLaBsXJTc0v/Z8r92rCU6lMYHyZd+muNSJwJDw9n2LKrmelHNTMkrvLfbdK6hGf0NOk/C7M/M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716069069; c=relaxed/simple;
	bh=RcP9ONURDS+Ct+lPTQXq1PEESPy4TRtKxORIGEDSfdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHMCPzlsgjzVLGLsD7oybQDSYPKkGR939a0cs6QpvysF0+4x/Oot+rG4KgpQdYnRySuJ8Ywgw2U4LlsJZ3W+P1HpWHucOdQhUi2kA/4wGQk5p7mBw0Y4I28izLfmrFRJGxWDx2rY8dCNS8P0bzoYhyRYJBQGNf4UMavjunLYpu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muz41a6D; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a5a5cce2ce6so538971766b.3;
        Sat, 18 May 2024 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716069066; x=1716673866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RcP9ONURDS+Ct+lPTQXq1PEESPy4TRtKxORIGEDSfdc=;
        b=muz41a6DBTRXy86OtJ8AHfc8wb6UYCNVPLurVOm+ZYhTSnNuI34RCNhngiKHtFMia0
         /uTwkCqSSrZhu6L0pXYE3F5UgeqwhHFRN/XKijRyvafQd9IA/nZSeN8qKXmT99d4UUFC
         FBxqmqHwWs3TmCx/MTU90Nm9rNfrCX9px5AlUs3gkU0z2hgen+/Gyt6feNWR/LCkE/VC
         vgwUhA7l46LJDDw/+gQai/wLuof4aADeBSxZQ51Ma+Ti/vibdt6p6PU0N604cZjXAnXa
         yxQu0UNZGXmdwDAv+VUJatOyV8CV78s+Dqd5cjZAbadPKQ1JG40p9HCaaxQATBVo9+JK
         QZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716069066; x=1716673866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcP9ONURDS+Ct+lPTQXq1PEESPy4TRtKxORIGEDSfdc=;
        b=cL5MZ48/E/szy32wXUWN+VqK9K3ZaevcfAnV1kkgGYzEy8Mi5/Ds1tqOKfqDZFR5wM
         3Fyjhy5eWUhqmk31l4iZzu3b3VNASr2PrlhSL24gTrh5N/p50+Hrn6t7HYJd443SrSwE
         a7EaT9RjswEbd4W2QFxuD6aNoZLavndpgJd6KSPRPQC5wOkMLxBH+EHv8cxk/a38AtcV
         aceFRExDca7WjRL58dFmxklzImI04ODQk55jVQZEgVgeWYzSGDKmmt3+bPIteuS4ZwkQ
         V5DW1/h6A9ca0L6wg/DlzWxl9PKEcB7o4eVmWQwu+GbFt1DpHpj2t4xtCMc9tpJMQGjs
         tTMA==
X-Forwarded-Encrypted: i=1; AJvYcCX2iNMtgz4vlHOmQjFkZ+I21vRZW3uDgXItegT/dzbxACKAvy7CXXaVIhSBzFyrpDKY263EPbH1hTnixu5qhbHlKwWOnSoW0FZRINnWZYYiS9F4Qy1xiDp8bdwdNFACJiMD52Ib9nbI
X-Gm-Message-State: AOJu0Yx2gDdG3fpMBotHo8m9tmqoNsN2Z9ZsrjLSRirY327KdPpceFbz
	YSfYMWVtBb+drpZoDcIX7Uz5AgmTmcXaBpL1xfg38y+IAaK/LdP5Zc5OIaN1gCu45OaGFmZiiPn
	hoI8qnncHfGrVf0QyI9X+ufmOi/U=
X-Google-Smtp-Source: AGHT+IEr8J1guqf2tn33fUaJtM15G6R0y0BZMdFkW4EMZ7H0fy9PWvCnfYR7yskmQbzmBkM8085rULrEK9jsXfnEBok=
X-Received: by 2002:a17:907:7619:b0:a5c:dc7e:bc3f with SMTP id
 a640c23a62f3a-a5cdc7ebd44mr629985666b.43.1716069066327; Sat, 18 May 2024
 14:51:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716026761.git.lorenzo@kernel.org> <0ddc5e4fcc6a38c74c185063e73ef4c496eaa7ca.1716026761.git.lorenzo@kernel.org>
In-Reply-To: <0ddc5e4fcc6a38c74c185063e73ef4c496eaa7ca.1716026761.git.lorenzo@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 18 May 2024 23:50:29 +0200
Message-ID: <CAP01T77rCZjM_G2-dntw=GN9rXZB_58H8YUwjGJskvTzd7MT5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] netfilter: add bpf_xdp_flow_offload_lookup
 kfunc
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org, pablo@netfilter.org, kadlec@netfilter.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netfilter-devel@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, lorenzo.bianconi@redhat.com, 
	toke@redhat.com, fw@strlen.de, hawk@kernel.org, horms@kernel.org, 
	donhunte@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 May 2024 at 12:13, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> Introduce bpf_xdp_flow_offload_lookup kfunc in order to perform the
> lookup of a given flowtable entry based on a fib tuple of incoming
> traffic.
> bpf_xdp_flow_offload_lookup can be used as building block to offload
> in xdp the processing of sw flowtable when hw flowtable is not
> available.
>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Though I think it might have been better to have an opts parameter for
extensibility (and have opts->error for now to aid debugging when NULL
is returned),
but I won't insist (it's not a big deal, as there's only two things
that can go wrong: the tuple->family is unsupported or the lookup
fails).

