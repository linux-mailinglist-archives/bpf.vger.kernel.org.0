Return-Path: <bpf+bounces-57660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 605D6AAE0C2
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB91C045B0
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 13:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFAE288C86;
	Wed,  7 May 2025 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JqPRFpGN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6D156C40;
	Wed,  7 May 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624584; cv=none; b=IzUyYdYiubZPGo3gZMq70McFalyf4Li7yJ5oBflPsuvHiPoRjK+fRCdpBWXGK0Dd1cb9AaEizwXPqZMzQWVegc465TyZS0XRxRd5nP8e9NtMR2YxlEgmwYteOPibGmqQRXgjjhwxGDRkVAMfLTCh8qMNVwzIs/VqXe2ll/goAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624584; c=relaxed/simple;
	bh=wQpDaP/Vr9UYsJ8lKwfHUee/hDol1chqzTFEAP6Mchs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jaTM/vwXt6azSxRm+Fvd7XVuIJ64wpwBkPHajvHDb9eBsHKUEu5KYGRolmWseDR8JFYq+KnUdf4rZNR+UJkW8QngfG9pidGEaWZC10cltIQYyYX2Lf58NoVvnD8bDNGbRmTqlmvzYzsPyMhvBRNfA/kM14B3tUnv0no7cX0ZhvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JqPRFpGN; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4767e969b94so31982241cf.2;
        Wed, 07 May 2025 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746624582; x=1747229382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTjiQ++FppghVzFe39984SJc83lrdjMGrmnekzjKbFo=;
        b=JqPRFpGNyNGbkgnItafKcTBOyj8qP8LIIl2PHtrnwPwhDfv0H2gHuxxRBHesVT2kYe
         +WI9Cd3/POdjKb83pLD03pfBaDG6nyVdTpVaqjRElk73bfm7D6UqA+Nnm4i/FSwqv3Wj
         +Kjq17paAWM+B+nr4UWmTk2gZx2pb8MncRcIXTdC95AjLEyD1fCloTxrR4vuj5t1W4//
         JRdGpkOKGxsJ+MMvemnt7Cpfnhdjcuf7/Jlmu6lmkYAK8PWxL5C18kiMfADSeGo7ySQ+
         qBjA5hrUauFGhBSL3zrD01D/vsr7aryV/LyKX3J6pe6wtNB28j36vwqrn42UUXZM/mpc
         py9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624582; x=1747229382;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vTjiQ++FppghVzFe39984SJc83lrdjMGrmnekzjKbFo=;
        b=bhIybbl9v4cB0H91EkzYXjM3e15E1ccbliJZcsUA/xooOREJruerotQqM+VQXatx+0
         uLcQvqMVVRUIHHMI8A7dhCVqMkbHsT+LmIKYF6Z+wv2ed3SYozPOynwV3ICy/x9fxJK6
         jKiNvFl/ZqfGPdVIlH5l0tpQe26DRud7qFomWJ8sWgrQbTo8QeTN3tVhXKlbBEZUDErh
         YaMaS1S7GDtulkNo0rSBOG0fzysJxTO/1d8Kwx4qDD+/1d3D+/SS4CwAsFhIfbe8loMv
         +Asd7Nz/SFDRlyYQXHR0a+UGnyxRJgXSieQA5Xu3D1tu3hgtRo1bV/6FCakldJuCB9eM
         VNKA==
X-Forwarded-Encrypted: i=1; AJvYcCVbYfvM3423t9UZzD+nBVuLWBViuSk3DfyJJ7Virmn2vOGFc69FugGPs1P6os3/WqS6h4p+txfC@vger.kernel.org, AJvYcCW2zjChXDavxnW1+/CNI8VYQflwovIIRgjSgdwuesesXSb3iPxzpaTpTaKzx2okJFZdbZvx/ndn5XIniork@vger.kernel.org, AJvYcCX2pmnBvtkcecbIulI0aopEHydPMtcBdtfD8ZoHo9MUQcCowQn7cT4VuqwYk5Cgw7qI0QY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybajaBBAIkDnm4KvJZWPfgHUBPH3zPJqKv2YVPXdLzky3QZcVH
	haxjA48ZfmhcRigZQVYlDFTaeiwXKJpWhYEnpNmHlJ1zvC/wFkvUtR0cVQ==
X-Gm-Gg: ASbGncuc+5nOwKTYVc8OkovzlPY6KnZh3W2bpyPvS++Ngao0f81/wfE1RM7MbxyjkDt
	tfUD50YG+zvuib0nHwnpdMKkOdn4mB2RyxRD1pk0xWtSyyUZ3crMr0VXiI6M8fplm7Ct5yeeOOi
	htXTqn4dyGfpkSWQmKIucPD54eLeCDA88cwkl/gduZwkWW1K0ZZQYS36pzXRf+6rV98AOJ9olMx
	rZv/s44WH9LQio0i0E6Lason/d2EKbyv+gQnzIaaLim3+LjQxUyiMB9d/D554HbZwbfImTiUT/o
	9mn+Ctmbqsg4l/R/JDI/y8C1nAccclgAp9wHRGLQvZ5Ba1cygfAFkqfSqONwwAI7jyEZevgNajX
	oGiz7u/2STId177IAD7MM
X-Google-Smtp-Source: AGHT+IEbHWi7wInP6wPATPO+pMHOSFq1YMBs1FDO6+6rZ6d9L46DFJQAU+/a6+u59/ecQb98pTs9OA==
X-Received: by 2002:a05:622a:50:b0:48c:b30a:7714 with SMTP id d75a77b69052e-4922795df04mr59435951cf.50.1746624571631;
        Wed, 07 May 2025 06:29:31 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f542780cc6sm13643016d6.83.2025.05.07.06.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:29:31 -0700 (PDT)
Date: Wed, 07 May 2025 09:29:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Jon Kohler <jon@nutanix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Simon Horman <horms@kernel.org>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <681b603ac8473_1e4406294a6@willemb.c.googlers.com.notmuch>
In-Reply-To: <aBpKLNPct95KdADM@mini-arch>
References: <20250506125242.2685182-1-jon@nutanix.com>
 <aBpKLNPct95KdADM@mini-arch>
Subject: Re: [PATCH net-next v3] xdp: Add helpers for head length, headroom,
 and metadata length
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Stanislav Fomichev wrote:
> On 05/06, Jon Kohler wrote:
> > Introduce new XDP helpers:
> > - xdp_headlen: Similar to skb_headlen
> > - xdp_headroom: Similar to skb_headroom
> > - xdp_metadata_len: Similar to skb_metadata_len
> > 
> > Integrate these helpers into tap, tun, and XDP implementation to start.
> > 
> > No functional changes introduced.
> > 
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Signed-off-by: Jon Kohler <jon@nutanix.com>
> > ---
> > v2->v3: Integrate feedback from Stanislav
> > https://patchwork.kernel.org/project/netdevbpf/patch/20250430201120.1794658-1-jon@nutanix.com/
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Willem de Bruijn <willemb@google.com>


