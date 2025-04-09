Return-Path: <bpf+bounces-55534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBD7A82AC4
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A22BD179005
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2981267B65;
	Wed,  9 Apr 2025 15:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHxzewsZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DD82676F4;
	Wed,  9 Apr 2025 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744213044; cv=none; b=kK/57zkBGOJMrahxQZM9uBzD9IN40MScEJKqI1UQBSrpKqxEswXW1Hg62BmY+eI+G9niu7HGBsc0gKuS4znTyXe2HvOT2htha5OuaqzOxG8AaXADt+2D08qndILZ8BlBeLbD90gBQGIem3V0wCR0pmTY32W5CniejDav6IJxb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744213044; c=relaxed/simple;
	bh=9LU8tmwWdSBnl+obLv/zcMHGhBuo3aeveod/ATqqHcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEjpXCZDT75dxgmqET/17xh5LAG0N6sT+M7gHTG6OcpxmpXyYrDJrYH4aMRoSBUfDhqZ7HH2DLt9P8Cv1bS77fCPXKxORip5PnpgkbK9VUz5aVwuM4B8sLQTCzmNz4KC1PRKvYr5qpmMNpuYrjBIldE9nF/lSE6uhi3xPEfKHeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHxzewsZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3913d129c1aso695203f8f.0;
        Wed, 09 Apr 2025 08:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744213041; x=1744817841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zfn4+CqLwyCJAyaZhIUy7/PFfj8wg7XnNrVnmZ0+y30=;
        b=bHxzewsZbcR8dHCWcCamLwJv++7lGwqEY67shttdB0TaUO949Dg7rPDD4Z/TbQNKs2
         a7TIN2Zv05Uv22Kfg3PsJo+miQep7aEXzkO9oOwngP9lTTZjlZrr6+XVUjBLfPVJ4k1E
         XJomAtl6oeCwE0jTr5GPIdYE9BMwiFwwM0pQ8X94y2zIFOx5QadfnSDYKDkyDiTfPAoV
         GHcAtZeM7jXwZ1Q3fpFXgbRvAJ+Mzt9zVuBRKItpf2Ou7WDpSvK95AUWyzIUsub3enxI
         V2VBg36X+GlXJCFb8GYyQYQv0s8wIXKmCEaUtquL8jeoO1srHjdYrllswNnTQFLFJypF
         +edA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744213041; x=1744817841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfn4+CqLwyCJAyaZhIUy7/PFfj8wg7XnNrVnmZ0+y30=;
        b=N+utn46XJZEOf9RhxNpzUVXLOLS3s/PIq2Yei+zcHEYnKwA17LEpe8/lGDVDd2l3Mw
         cv0LR7fBYJ+b/x+ws2MfffckLNzgnADM82j2+6i3ekfUXUdNuRxhWl/FZ1UauTliHilq
         1c6QndonISS00+EsE8uS2iuSvIbdoSW0GSEeyH6TA171WPh3HxNe3+KyH9fzzqPpaDr9
         Ef3LcUXYzpr7qtot4x2NL2Bi7rD65eGIySqQLaixCRb5dQBTo6CqjpXvelnnqjQ7mDKM
         GZPv/zVTTIUdxDpGSsuAH6fN7oGqxkIg27HRX0dNC2d572n2Dw1pcB0iIP4DfHwu6uck
         leJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjplV6CLiQlVeI2pym4sO2Kkif/RySh6w1Gsuu8N8vSjxi5AyqPmIE1+4TtaiST0geOO2TPHIm@vger.kernel.org, AJvYcCWRn2mYg9Xmq2WfPtrSyR71K/hXvfTNI8rdRKTQAgoDdYXUq9fn1Sj+X96wEG9MG+PrZB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyQCl+FM0LbEUnfIynW7sdo+1l0KH02aWshxiEMy78h38wx6tD
	tibW8DbcQsvkwL/FsL4ZfcQIziK4KeXdKrcreVQMIEPTXLShMRxyMtmdumFZujC9hbm+zrhMfnE
	QH0pkU7XiDe9530RmfZmj9vss8pM=
X-Gm-Gg: ASbGncsjALdIdq9dl0OQSm5zSAh7OzKQn3RECjofWnbutH9OZVizCF6SeW0XqFIcdID
	dMhFaerY+OkcyTutw5iW8rSUvJL1h04qisUpEIz0jmPF4Sce/WCLnXURnB3rp3U6pK3Rz5dyuwd
	raTjuglFwWGg6hHCgxIy774r40u+j993ExEreAyA==
X-Google-Smtp-Source: AGHT+IGqTVHZdF0Gnl5ox7AneBTijUDOiLO0yxLHMb109MwajX6MZM3vRl0qW4Z4nNz11FZzh4KO6eEQNmkSlrmjibI=
X-Received: by 2002:a05:6000:1a8c:b0:390:f116:d220 with SMTP id
 ffacd0b85a97d-39d87fbd0f5mr3045672f8f.17.1744213041130; Wed, 09 Apr 2025
 08:37:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321005419.684036-1-tushar.vyavahare@intel.com> <Z/VUvPIxGVJ5dRic@boxer>
In-Reply-To: <Z/VUvPIxGVJ5dRic@boxer>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Apr 2025 08:37:09 -0700
X-Gm-Features: ATxdqUF95bIHej4EzUAYAviqwjNUt6B8FDA3UuASlSr6ls445vufafsV_mKdxPM
Message-ID: <CAADnVQKSWymsw4eu7LuHMCiYU=dfq7TCCh3LNA_mg12G+Y1=Ng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 0/2] selftests/xsk: Add tests for XDP tail
 adjustment in AF_XDP
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Tushar Vyavahare <tushar.vyavahare@intel.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	"Karlsson, Magnus" <magnus.karlsson@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 9:55=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, Mar 21, 2025 at 12:54:17AM +0000, Tushar Vyavahare wrote:
> > This patch series adds tests to validate the XDP tail adjustment
> > functionality, focusing on its use within the AF_XDP context. The tests
> > verify dynamic packet size manipulation using the bpf_xdp_adjust_tail()
> > helper function, covering both single and multi-buffer scenarios.
> >
> > v1 -> v2:
> > 1. Retain and extend stream replacement: Keep `pkt_stream_replace`
> >    unchanged. Add `pkt_stream_replace_ifobject` for targeted ifobject
> >    handling.
> >
> > 2. Consolidate patches: Merge patches 2 to 6 for tail adjustment tests =
and
> >    check.
> >
> > v2 -> v3:
> > 1. Introduce `adjust_value` to replace `count` for clearer communicatio=
n
> >    with userspace.
> >
> > v3 -> v4:
> > 1. Remove `testapp_adjust_tail_common()`. [Maciej]
> >
> > 2. Add comments and modify code for buffer resizing logic in test cases
> >    (shrink/grow by specific byte sizes for testing purposes). [Maciej]
>
> Hi BPF maintainers,
>
> could we merge this patch set as i have acked the patches? Or is there
> something that stops us? I suppose this might have slipped during the
> merge window?

Sorry. It got lost. Please resend the set.

