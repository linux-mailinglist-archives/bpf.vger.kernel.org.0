Return-Path: <bpf+bounces-75758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A767C9370E
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 04:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1679C4E20DC
	for <lists+bpf@lfdr.de>; Sat, 29 Nov 2025 03:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4130E224B1B;
	Sat, 29 Nov 2025 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP+ff1lY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D26221DB9
	for <bpf@vger.kernel.org>; Sat, 29 Nov 2025 03:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764385740; cv=none; b=sgpoZTThMJDdKarPp8spIb5AF5xa12rvOSyD8FvY+4m3c/BRt599WbH3+wD4kxUM8t264CmpiL7SNYXSPlRyL+FVSRaNVtgIg/a5E2D7y8/UNTPNkXo0htin+S+TLUICWKrxuZnU67HA5BNfYwyUgSDUPrFgA9j+Dm12atVHOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764385740; c=relaxed/simple;
	bh=/PZP3yAQumAvTqUj8cFxO/xQNdxZy4OkZQG461Pimws=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=epL2NpSlUhRaHo6ycwyqJ0ddHN+SDFdmFaNleu6VaKzsCpt0YksoW4v007zu6gLn6umjIhJA9MebWdxc81OTbbXeHG9VBI7gckJus4dv1zYOwm5mABBy2Dd4F71gXMyzEomM8cQJ7a/NfGNjH3qval4TPBkkje+OqdhxISrXgp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP+ff1lY; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63f9beb2730so1897698d50.0
        for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 19:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764385738; x=1764990538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKP9QMT2JZnZYL/pm9t1iF9V8rMC2bcnAu0ULKob60k=;
        b=YP+ff1lYYzC0pTfM43GF/XlRAFWhROeUGfZqDEiM65WdE78Pe+vADB8mOStfquBAzH
         2le6rUIZEttqanaY6FQcI3sNfgfF5y56jMRBzgXlYB1MsX9PmLNztDkKwBZGqbPlcJu4
         /4oPyu/aEKx2fiXemzI9Mc45kvYSYMxQGasR/BBPpz8vztfve3zg6x3wyrUHD0GJRtCO
         Rrja9I5JGagBxDI2r0bapPq0HBDnBQgQEvDq5bKwD0RdKPHZasAWCuCduNOthF72xd9C
         fl1GlNTS46HYRrSvl+z13Em3phkkx/QdKXMlBQMJGdv12SlsrLW3DGspbZ61GEtHc4Eh
         d9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764385738; x=1764990538;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKP9QMT2JZnZYL/pm9t1iF9V8rMC2bcnAu0ULKob60k=;
        b=j3jVd8CGp+nDnTh5capJxyz0w8PHTygG8QW/6WwzFfKpyGplTGoi3kGENW1ZAz6TzI
         7Z9VaLFQq6RfPc237SDWxSMGhhocLP2MkzAEyPKyiMq+H21qv0h66jZgj9N8GAVMltTa
         0Y65/Tfwa8UWTwsLilv/JrGhGVOywXSn56vYkhAbx9uBluM46VZvHVV5wfUt2oapS0j3
         tbo32WuycLK2RcEcK03goNlPxpcGVwVWf45O/XgydHZrnzLipW3QDjL6MZzVYGozY7hD
         Pb83FZJgAJhLBedqhpU5AuX8CFnmawtCDjpIxaTmjxE2hDIo/C75UOjgw1WLIYonuX0L
         /lNg==
X-Forwarded-Encrypted: i=1; AJvYcCXwtFa/HQrCqibprrdDD8D2MQe/ito1/Pt2tGu2hVWS/A4kZcnIbB9HCVslYWd4oDCJXA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa5mcCKZGnN77yPxWUWpus7OnZmyaqiOBDR1ppN7J3eAcBA2mA
	f6REFlh6/UnE/pm3jOgewTe5GjIhiEQKqhzEoQumFFhzSGSo3BJ36bzB
X-Gm-Gg: ASbGncvNaq5mW4vQKeQtbgYxfd8WEYBtAQQWkV4nOSBXrllsep3hRWzoRCCBVAp5XvR
	9f7bvoAieN+fT7WoCQeZjkoXjNhJoFCEh/d4vAskFG5td+xCYjAqybPI7Re0TZAEzQLPydxsd/G
	JquYj1fOG3UF8F/qn4QJvVSs+9yX8Z+13j9Cy1xZv+3s2yJ5SaftPD2O0TH0lcaIZSzhJEyn6Hg
	GQOR9bIeoAeh7TKH2UfQHn01W97X1/tfBHFn49PRpZnKLQEG6qbtIYaipkTwxLwK/Z4P3ybknqf
	Uo3oc7PK2hS8LfT/ut6GGOyZKNhpBaSf6IdgaYLX2VEujWbVMdXEXEt+jovSJSxzDAplHj50gV6
	H3KtdsBM97zl4w7eXMJXP4oQpaitXtj+SPETsOecnCBWmJTfMP3DOZUbYWWpGsh/Aj9Cx9kEO+v
	vfnyqLvjdp6TjE4d5nsBEGVHpwHBoDgW2cFGCqDHx4gWc3RBtvnKu7+umjttehoOgASpqv5dJDG
	XY8aSKeXbZtERTj
X-Google-Smtp-Source: AGHT+IGYpcqbLsEsitYexRW3zdBcpnFckpxZnQFAdH0o6v5MgT8neurL+UA3Zo6zVsKYEWD+ES+tig==
X-Received: by 2002:a05:690e:4198:b0:63f:a585:14 with SMTP id 956f58d0204a3-6432922291bmr13857167d50.17.1764385738219;
        Fri, 28 Nov 2025 19:08:58 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6433c050348sm2106414d50.1.2025.11.28.19.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 19:08:57 -0800 (PST)
Date: Fri, 28 Nov 2025 22:08:57 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 netdev@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 "(open list:XDP \\(eXpress Data Path\\):Keyword:\\(?:\\b|_\\)xdp\\(?:\\b|_\\))" <bpf@vger.kernel.org>
Cc: Jon Kohler <jon@nutanix.com>
Message-ID: <willemdebruijn.kernel.199f9af074377@gmail.com>
In-Reply-To: <20251125200041.1565663-1-jon@nutanix.com>
References: <20251125200041.1565663-1-jon@nutanix.com>
Subject: Re: [PATCH net-next v2 0/9] tun: optimize SKB allocation with NAPI
 cache
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jon Kohler wrote:
> Use the per-CPU NAPI cache for SKB allocation in most places, and
> leverage bulk allocation for tun_xdp_one since the batch size is known
> at submission time. Additionally, utilize napi_build_skb and
> napi_consume_skb to further benefit from the NAPI cache. This all
> improves efficiency by reducing allocation overhead. 
> 
> Note: This series does not address the large payload path in
> tun_alloc_skb, which spans sock.c and skbuff.c,A separate series will
> handle privatizing the allocation code in tun and integrating the NAPI
> cache for that path.
> 
> Results using basic iperf3 UDP test:
> TX guest: taskset -c 2 iperf3 -c rx-ip-here -t 30 -p 5200 -b 0 -u -i 30
> RX guest: taskset -c 2 iperf3 -s -p 5200 -D
> 
>         Bitrate       
> Before: 6.08 Gbits/sec
> After : 6.36 Gbits/sec
> 
> However, the basic test doesn't tell the whole story. Looking at a
> flamegraph from before and after, less cycles are spent both on RX
> vhost thread in the guest-to-guest on a single host case, but also less
> cycles in the guest-to-guest case when on separate hosts, as the host
> NIC handlers benefit from these NAPI-allocated SKBs (and deferred free)
> as well.
> 
> Speaking of deferred free, v2 adds exporting deferred free from net
> core and using immediately prior in tun_put_user. This not only keeps
> the cache as warm as you can get, but also prevents a TX heavy vhost
> thread from getting IPI'd like its going out of style. This approach
> is similar in concept to what happens from NAPI loop in net_rx_action.
> 
> I've also merged this series with a small series about cleaning up
> packet drop statistics along the various error paths in tun, as I want
> to make sure those all go through kfree_skb_reason(), and we'd have
> merge conflicts separating the two. If the maintainers want to take
> them separately, happy to break them apart if needed. It is fairly
> clean keeping them together otherwise.

I think it would be preferable to send the cleanup separately, first.

Why would that cause merge conflicts?

