Return-Path: <bpf+bounces-41239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CBE994581
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 12:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC067289323
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 10:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B21C3F08;
	Tue,  8 Oct 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmTu2ZI+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9C1C1AAD;
	Tue,  8 Oct 2024 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383502; cv=none; b=BSkzoxNjf33LeFF/wx3ee9kNGUs6hRU2jNOYlMfzo0+yykSoTR8gZm1N+7SGHPB4Tj/IARIxsM+AUZczArKnwKOIGwPaMmdfEko0CSsRe1y+MjL2ViFQ+8tW9FjeYtsuKKr2hZ+knM3HE+/TjYx/Hp9h4fHRWHiTXdX8qGVypig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383502; c=relaxed/simple;
	bh=ZA5yjaJFpQo15G7hj/YB+wmAae/fHZXL7PrhkwMKI7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHMSoeb6pOpsF0Sj/QZVJtyQqKOYKvZLcLYcZ6WXXiXv51CWkQ7RqbNEr+boPnrzumVzuZMNKKp8zFb1RVGXUB++yuJWIuFbAYg6kEUdZ2/v3WTLnu2dqjbpabpsf6Ev+LIAPq5BSij88c+hmw4GoEI0bgSV8ITPLvnAOGJYul0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmTu2ZI+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbc08e7495so3349926d6.3;
        Tue, 08 Oct 2024 03:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728383499; x=1728988299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qWXOZiTJ524Ki2B43JslWFwUVw4xgtE+zBy4K0YjIxM=;
        b=QmTu2ZI+Hebpb//5devPDbTptbSAIMl6kdCf18TSqBTqDqFGajVERk+ryqWOPBm89U
         sk3A/flB/Tl72MBr3qkmlmpaeKJzZMJi288nNM5l9Z76a9S/or5ezc6mqAlM9Y9b/3Tr
         3U++9rB/FHtaDdjveQJZkaseAnrkmMWFLLJuYnp15nGXkavUpkYJsp0stV9B/z4StEp9
         OY6weYJiaCDPh71ewA7kRzX2uyDJrhV9FWyR/nMSEBGYSa3qIB+5pg5E7NkgpUfTLL/G
         3NHpYTjBjYQWNhCLR1ABNHgnkIIL4fDbjx9nbnBw7bENLVl7imNBrxjIv+h8iofFwlzk
         weiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383499; x=1728988299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qWXOZiTJ524Ki2B43JslWFwUVw4xgtE+zBy4K0YjIxM=;
        b=g4HlehZUKC57BIkvH1WGqCXrN+bhnW2lNqmPhPyC5/eLa6xXhB2oR2jEnUQr++ScwR
         7/hZMxtzew4ekCIsW9eMRwAzjsdr3ECC5Y2LYQEZ5GPzWwztIpc8h1HreCOG4DzngeKw
         2UgLtUwANTF8LAfqtIooGEYMm9jpWyx506W8IQaHl+b4eKDITQO/M82yywZh/eAMeAnf
         7bxFqL2n6wGXrC5CD0L+StlDS5RypbTQ3n7+z8O4SMetnWEQDP1dOQEHmbChQqVChE7m
         4O/Q8WlZ1PiYoImXHw+UHS1WujPwptpAs6UMOphWQxkdve90kRsPwNwlE4Yv6aExBeBL
         Wn/A==
X-Forwarded-Encrypted: i=1; AJvYcCWxMtadIAXXOfjlSEx61s4oPWhAdURHCM0tpj/lYYzY22Q3ZvJ+UyxB/CAKYR8lnSKE/xyyhKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbiPW4oY+FnA9dtDc2DZmIpdmUgXkiW32ajBUYrifhBWTH/I8I
	tv5gcvnZPz8Z6CEMsUGhDYeSjw19rXZJpgY2ay02m3uAmcOOalFAEKtEHgcrgRJSJjMLIBwiL0I
	r9f0uwitOhT/hdtLnsVVg+V7yDRE=
X-Google-Smtp-Source: AGHT+IHmAgxptQBJ8oR5hJSMNW8SP1QgScTRozbkAajjcegzzj76mb0Pbapw3eRx+ncxmEVlwQYNoBFfQWFE8+8942c=
X-Received: by 2002:a05:6214:449d:b0:6cb:ae56:1965 with SMTP id
 6a1803df08f44-6cbae56198bmr132780746d6.15.1728383499382; Tue, 08 Oct 2024
 03:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20241007122458.282590-1-maciej.fijalkowski@intel.com>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 8 Oct 2024 12:31:28 +0200
Message-ID: <CAJ8uoz1giCLozes9kYpzwns1Vb+sLfV=7t4jXvpGZgDD26-sdA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] xsk: struct diet and cleanups
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, netdev@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, vadfed@meta.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 14:27, Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi all,
>
> this modest work brings back size of xdp_buff_xsk back to two cache
> lines which in turn improves performance. Interestingly I was able to
> observe on ice with HW rings sized to 512 around 12% better performance
> when running xdpsock in l2fwd scenario. First three patches are behind
> this. Other setups were not that impressive, I believe results may vary
> based on the underlying CPU. Bottom line is that shrinking this struct
> takes off a bit of work from CPU's shoulders.
>
> Other three patches are rather cleanups.
>
> Thanks,
> Maciej

Thanks for these improvements Maciej.

For the series:
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>

> v1->v2:
> * fix build issues on patch 1 (Daniel, CI)
> * be smarter about xsk_buff_pool layout in patch 4 (Vadim)
>
> Maciej Fijalkowski (6):
>   xsk: get rid of xdp_buff_xsk::xskb_list_node
>   xsk: s/free_list_node/list_node
>   xsk: get rid of xdp_buff_xsk::orig_addr
>   xsk: carry a copy of xdp_zc_max_segs within xsk_buff_pool
>   xsk: wrap duplicated code to function
>   xsk: use xsk_buff_pool directly for cq functions
>
>  include/net/xdp_sock_drv.h  | 14 +++++-----
>  include/net/xsk_buff_pool.h | 23 +++++++++-------
>  net/xdp/xsk.c               | 38 +++++++++++++-------------
>  net/xdp/xsk_buff_pool.c     | 54 ++++++++++++++++++++-----------------
>  net/xdp/xsk_queue.h         |  2 +-
>  5 files changed, 69 insertions(+), 62 deletions(-)
>
> --
> 2.34.1
>
>

