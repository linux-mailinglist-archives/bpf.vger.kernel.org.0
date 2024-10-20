Return-Path: <bpf+bounces-42548-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ACD9A56C3
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 22:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 645DF282649
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2024 20:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D39198A0C;
	Sun, 20 Oct 2024 20:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSu03c3n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00883192B71;
	Sun, 20 Oct 2024 20:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729457464; cv=none; b=btecp9mCnb62k4txDxUYjz9wDgokN/lxta/SbN6Mj4OiDIPEYSHE+GyO2M9Mh4XukFyWlJuBnnNZDs7p/TOJdygzCyrcHUXJvjSpVIV5jjKv6V5bL4fLW3pphWY5gP5CUAroNq3pqdwx97YQTjKyPD28rsKIJgedoE+w62JIb9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729457464; c=relaxed/simple;
	bh=pxsVXRvz3IKNxmDRqwavGkoI451JYkwuFGBrJTRUQLQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GOTSLFaThs0eG+QZbSPvYyb0UwY+3LVULaWEaf+KokNvGAD5fFzjTGo2vXQiRHCZCs8qTMJPGhk+RtRh2/9h63ej8gPW47+1OPaatxPvbKqLB+urfMRpFqEX7VSTMIsYjj8nzFIyryDHpbmXN1jMT5P0lXTAJaGTYYXtqZb3Aao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSu03c3n; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b1457ba751so325654585a.3;
        Sun, 20 Oct 2024 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729457462; x=1730062262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSKDAWmB7QjNwJwvIjfmgBhbrPMBh10crall/g7rNVc=;
        b=HSu03c3nm/Alt8xedecg6HpqgSFSKDI9x7BQcrThpxE97V38/pPt+1ub0Onw2fjf8F
         y/zIoszRafMCLm4+vTzDoQxBzTZq8bq/JWVmB1QDl4NXUXsNZhBn2fjgUuetk197EnYi
         BPcP+LJmmSwQ5Nw7L+/2lg2/zcAGtnYhn1JBtJPjRvOsLXYO015flEnM+TWjSu8tx3ig
         rvGoONTWxR+kWAZhnoOS287CJYIynRpdhDLVhG2tWwxgKOmizXEcHenp0zhsVBTdJEV6
         GyNpaCXY3q/CquVWUhESyJtFEld8LBpv+NmJ3MA/ZIYYRCGhGimppHIQsgIbFtgS6jju
         K/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729457462; x=1730062262;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xSKDAWmB7QjNwJwvIjfmgBhbrPMBh10crall/g7rNVc=;
        b=XQ1Rc8Xx6K7W+uR8Ie46god4LfkD10pvtC3qLGbJFdnl4386efIt8UvhBf+9BlPPBE
         Pye7PKgD+7v/TLhxnU6+RZIzoEb6ryFkEHeam5y/Cf4qvjs5XQRqddpvSC7nZy7bdte/
         QGrMfm1i3FzlOBKi16Z6Umemj3WCL3UF+Mv17rGM5rHiWbcSX7UrzK+s1kmunxFYQwSg
         edGDx8oqClldGmMCuvrbwId0ywPLpQU3y9FFQ3JuoYIs6lnhAppklEi3HZaLo4wHuRJb
         b2H7KAqolQo4YHpwgkQUwGsBeC6Mfk1tduoBVYpPsuis4Xw3lyMPWR/5wdP87ZVnEmze
         WCsg==
X-Forwarded-Encrypted: i=1; AJvYcCV+GDuchRLJpBzkV0G6WJ8TM0Q7QJmw5B3T8OXrTU0qcKxUYJ7JVsiQuXvfNcXVo1p/IUMsP4cxclyOk3vw@vger.kernel.org, AJvYcCW+q+vQzF04xcFndk8bJAOiTDSdC/MF3M+6CHCqeoGgVaRlU7mHKEuZDnl6OsBbz+53tYQ+oWh8nGw=@vger.kernel.org, AJvYcCWtFop14mOAINOUkDj2iJ44GRicKe8C5xQuOaqaHw947bHHDhh4kiTK18/SxQh0hJt4hnxiFGmd@vger.kernel.org
X-Gm-Message-State: AOJu0YwJafQSR/KZnHkmmcl+H4iyO9siwxGJA2O+lsIUiIWyQRg+RPAu
	4S0Rw9JQcGJeMhzGFVZKcFroHBxkiefaT3PjIUZVmYyxAektfvy/
X-Google-Smtp-Source: AGHT+IHqwAnwB//1Bh8QwdKdNxC5bfoFOAhk9GP2k1phgymhhCvnCu1QgZ5V4ISV4t4bmaVlSREPuw==
X-Received: by 2002:a05:620a:31a1:b0:7b1:557c:666f with SMTP id af79cd13be357-7b157b6aa2dmr1394819985a.25.1729457461764;
        Sun, 20 Oct 2024 13:51:01 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a892cbsm107325885a.136.2024.10.20.13.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 13:51:00 -0700 (PDT)
Date: Sun, 20 Oct 2024 16:51:00 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>, 
 Muyang Tian <tianmuyang@huawei.com>
Cc: bpf@vger.kernel.org, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
 Magnus Karlsson <magnus.karlsson@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Jonathan Lemon <jonathan.lemon@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 yanan@huawei.com, 
 xiesongyang@huawei.com, 
 wuchangye@huawei.com, 
 liuxin350@huawei.com, 
 zhangmingyi5@huawei.com, 
 liwei883@huawei.com, 
 willemb@google.com
Message-ID: <67156d3447444_14e182944b@willemb.c.googlers.com.notmuch>
In-Reply-To: <ZxKPXdYjwPnpq95V@mini-arch>
References: <20241018091502.411513-1-tianmuyang@huawei.com>
 <ZxKPXdYjwPnpq95V@mini-arch>
Subject: Re: [PATCH bpf-next v2 0/3] XDP metadata: Rx checksum/GSO hint; Tx
 GSO offload
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
> On 10/18, Muyang Tian wrote:
> > This series introduce XDP metadata functionality, including Rx checksum/GSO hint
> > and Tx GSO offload. This is aimed to transfer control fields when processing jumbo
> > frames between VMs.
> 
> Ideally, the series should also have the implementation of these hints
> for a couple of devices and appropriate selftest updates to exercise
> them.

+1

> For GSO, CC Willem going forward (I don't think I understand why
> we want to have gso_type in the TX hint; something like header_len
> seems like a better fit).

GSO on Tx makes sense. To be able to program hardware USO, say.

GSO on Rx is less obvious. Is this for HW-GRO? In general, some usage
context will be helpful.

Two implementation questions:

- why define an XDP specific type for checksum types, but reuse the
  netdev type for gso_type?
- why u32 gso_type, when it is a u8 in skb_shared_info?

> Please also don't post v3 yet and allow at least a week for the initial
> reviewers to catch up..



