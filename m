Return-Path: <bpf+bounces-41879-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD6B99D62C
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 20:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7751A1C2242C
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00CB1C82F3;
	Mon, 14 Oct 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf51OIsr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544B1C0DE2;
	Mon, 14 Oct 2024 18:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929384; cv=none; b=s6pINPUrS81b9v4GEvEHD/e0Wwdrs1VoGRk+u4DsKhiWu1jpt+zpDdwBvpHuF5QhVevqJx3it8dCYhtvMM+BZsG2q0lCjV+EPwGNhb8IvvjVaIEI5MFotdIkZfwZc/sayy9gXzIl9bAXH2rG6hryRQHeo/te0pNSC/LiW9kGOvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929384; c=relaxed/simple;
	bh=EOtY/6PYbDr77rvjnp8h4BXx2E3EanTi3o1/5Ci73ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euhD8hXMRe6eevfZkNPvgcjagjNA5lG4l5Bd4/D8IgSxXQ6l9aYOnThCGrzyJGxTgaUWybUxBLyiwkYjtMpXSHhJBlpSQR0nFYFVzIzptKJE0fGjOBwDTEqnP8Y87rturxdXDRCbQuzfH1ff/5IKnfyilmdeJOWL8tNO8k3AgkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf51OIsr; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e30fb8cb07so1722763a91.3;
        Mon, 14 Oct 2024 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728929382; x=1729534182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VC0lie449FhX5PEmCXxHwXEALuCgHKKyis1bGYeW3dk=;
        b=Wf51OIsr84lZoevqECMLwdYG0nl2sh8GbaTwIZrxYCIJqDYWM16/9bCpjnwsaGkB0Q
         q4yM8ul/F+Qsc8Ik1hgSh/eOHFVLGbPIUMFQCNAbl7vsQBh73hu70BdpqSiisvaItDBj
         jkZO4SucA0aesqxabGlCUsUA6/PllEOgEvqkpDqVh9JSkS9HqT88EcnzfrxpzsAmhG55
         qGI2Y+W2bmDH1/7SNrg6FREe5l/wLiwbhK9NOBqh+6lM8gyJKH516JPlg/ArxSW15ooS
         3LVtX06MSvBa2uPMm6FEY5woH4QpPOwebpggMi92S7FZs95SgYdNlMkd3zkCiU+chI5J
         zwbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929382; x=1729534182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC0lie449FhX5PEmCXxHwXEALuCgHKKyis1bGYeW3dk=;
        b=sEti5ngUtOeHoUZ2/QCL9io+xf+JhP3YTpsiHwC+yDQZjMHPlgObeVBZ94CQTDOZs0
         /oJ2w26/YB5JykChVQseQNpgl8xsdp/lyZP/mx4G8qwpXYQGJKK01fAjtJQnIHdIqk68
         GdaGtzYIJKFkzEDHZ4uVHJMG+O1SZyOWmE/hMhoGgsRqlM2fV7pJEmcFxF1r0um123LE
         b50fXcAzkKbqb4YQzH1BnNSspEubC31b2EhlE3cmd+Vlt7Qvi7kJU35OjAm7LswqhewI
         2tcXnx/XNVPZxoKKoQEgvevyrwQhKBS0TbVqLhKfOTUjhf6jiVRXfJa3sM2CLRVDSTnN
         fCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXZsxXfsyfA8kiq5J0v6d/xZRW1NTZxTmXDBIMWWD4Wl3CTmM7LjcBOYevWkBGTG9s3pkW+Wm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ4HVlmRj5VAxgu22aJkw3wHY3VJ6Vx4dgDK0W7ZUvAzNKw0Z
	4jV/6mWCz1nxpPRzs838exkXpIdjjeWiUZHI4VCU++/TkwBtiqo=
X-Google-Smtp-Source: AGHT+IGsHNezMdFQEi6oBU2robbn+vVRkWDrAaV7hVAYWuxxKhtIe4uXaW46jDAXPhcy0g3ePRk7sQ==
X-Received: by 2002:a17:90b:19c8:b0:2d1:bf48:e767 with SMTP id 98e67ed59e1d1-2e2f0d7c1f0mr13968728a91.29.1728929382168;
        Mon, 14 Oct 2024 11:09:42 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa8ddesm9290448a91.39.2024.10.14.11.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 11:09:41 -0700 (PDT)
Date: Mon, 14 Oct 2024 11:09:41 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: tianmuyang <tianmuyang@huawei.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"larysa.zaremba@intel.com" <larysa.zaremba@intel.com>,
	"ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@google.com" <sdf@google.com>,
	"haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"dsahern@gmail.com" <dsahern@gmail.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"willemb@google.com" <willemb@google.com>,
	"brouer@redhat.com" <brouer@redhat.com>,
	"anatoly.burakov@intel.com" <anatoly.burakov@intel.com>,
	"alexandr.lobakin@intel.com" <alexandr.lobakin@intel.com>,
	"magnus.karlsson@gmail.com" <magnus.karlsson@gmail.com>,
	"mtahhan@redhat.com" <mtahhan@redhat.com>,
	"xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
	"simon.horman@corigine.com" <simon.horman@corigine.com>,
	"Yanan (Euler)" <yanan@huawei.com>,
	"Wuchangye (EulerOS)" <wuchangye@huawei.com>,
	Xiesongyang <xiesongyang@huawei.com>,
	"Liuxin(EulerOS)" <liuxin350@huawei.com>,
	"zhangmingyi (C)" <zhangmingyi5@huawei.com>,
	"liwei (H)" <liwei883@huawei.com>
Subject: Re: Questions about XDP hints
Message-ID: <Zw1eZQJG3EMz5ADv@mini-arch>
References: <90c1c6b53a654cf197eb412917fad31a@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <90c1c6b53a654cf197eb412917fad31a@huawei.com>

On 10/12, tianmuyang wrote:
> Hi all:
> 	There has been some discussions about adding checksum hint in AF_XDP such as this thread[1]. Now, we also plan to add checksum hint. My questions are:
> 	1. In this msg[2], is it appropriate if xdp_csum_status only includes 4 enums/macros(CHECKSUM_NONE...CHECKSUM_PARTIAL in skbuff.h)? Thus it becomes more generic. Also, in this msg[3] we can simply pass skb->ip_summed to csum_status in veth_xdp_rx_csum().
> 	2. What should be taken care of if I want to add a new hint? IOW, what is acceptable to add a new hint?

There is no clear guidance on what's acceptable and what's not. Each
hint it evaluated case by case. IIRC, last time rx csum discussion
stalled due to disagreement about the level of details which should
be exposed from the generic kfuncs. Feel free to revive the discussion
with another patchset.

Regarding (1): the consensus seems to be (IIRC) is to expose tree cases
only: no-csum, csum-unnecessary, csum-complete+csum. Anything else
gets too device specific and too convoluted to handle on the xdp prog
side.


> Thanks!
> 
> [1] https://lore.kernel.org/bpf/CAADnVQJPgpo7J0qVTQJYYocZ=Jnw=O5GfN2=PyAQ55+WWG_DVg@mail.gmail.com/
> [2] https://lore.kernel.org/bpf/20230728173923.1318596-13-larysa.zaremba@intel.com/
> [3] https://lore.kernel.org/bpf/20230728173923.1318596-18-larysa.zaremba@intel.com/
> 

