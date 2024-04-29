Return-Path: <bpf+bounces-28162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776DA8B6463
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08C4289D12
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3AB181BB0;
	Mon, 29 Apr 2024 21:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEZ97k5u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C73C482;
	Mon, 29 Apr 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425301; cv=none; b=lAOVTwcAFI3Hgd/rqw0rtN2H8jIVlgYAYfIZfUf5IgKmteRzr5mcb6Mfea56l4QGar4zmOAA6/OEOydxsgG7SYrOEw2c+E+dHKjFAbkF8rcnoJJnAdsDLzJhpJjX7DdnR6elRAQMfQqLF1Nnb2Ppx/4LAyY9TmZr7T627aIY8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425301; c=relaxed/simple;
	bh=7+2sYOL5fqWMncPIRsbxS0iXQhfb/BgV4yUmovNTXdw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=lqhi6lGuguVUZK2gyzfJus58nqshSSmcPrKMErPWdtmvuMTHGl2fIgk9LE/2/1fXwM8DTU6iiUDLoeoNrAvUHEg70wd+MLBBeOvrDizm822pBPEzktlRLOSisR2hmG9DnlfeheK2YIGYaZ3WhhEd0jk8SDwSz5GxJ5Azizv855M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEZ97k5u; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-618874234c9so56671867b3.0;
        Mon, 29 Apr 2024 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714425299; x=1715030099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQPuAKB6zxzSBJxoiuturNalOncl1ZZO2UKPOMfyZOo=;
        b=NEZ97k5un/4rEGrIj4mJ2hKl0ZoCOcLZ4aOur4xJt19y9k8sd7hniPPDp2if+KaQYN
         XFGB7uc3554Pqx0w/eAco5oqUQI+v9i+/kh5XATJgqMN9FXr2tsNWeDmLjqjsJM9JUqt
         riGnwz4w1OuJt0FqcbovPsR2HnYBCG2buIW6UpGL0kpFNv2PjLY7IHrlC5f00WhoEKtL
         EIXTqYUgKKVcNUoTPN08fs5RNXyzlJJ8vncJkcbar94nbunhe/o21/db2rUltrom5tQh
         OYIH3jN+V0c1d18EviFHMKQu+CQL1AHcwwmWP0dPqHqE0OJnLOlMLSQC8XcmecCFgS/w
         jndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714425299; x=1715030099;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NQPuAKB6zxzSBJxoiuturNalOncl1ZZO2UKPOMfyZOo=;
        b=H/O+mlO3axNceTDqHTD23aH56e2GXXDkXW9BCJlbxJWWyqqYTyTVMBJKj93Znnjl+p
         z2/GArxjOmGbUoHK6+uUX5UIZLYWj7Yo0hItvKfH63xml6UnD9lX4kTc/hU80JAEDE+Q
         cSMu1drGbWfH/rNJu0p6DcJp+9mJRZ7/oUcbJuGpuMPccVAbI/suV96rbSoRvl8YeLIL
         vR7fLZL/ic9qSGyOAsDsgJByXiJmJE3J+yG+J23q1x8Hiy+6G+2fXIfy0LdtkVIRH7CU
         GKwVxvE6AEcFRyBeq06BKYBNfrDznUFWHY1nY3GS8FlC5YylOVZa9j9X+UISZPjEl18o
         40SQ==
X-Forwarded-Encrypted: i=1; AJvYcCULzJ0epknS4OAYDawg5NNvqrm1GjoUo5hCOrFxEUJU027XBGc8fQqvtqk8Qbi/QfKwLfFkV+/nYz672bR/BRfAAg99k+oobQG8GVG3OVeroVn5TTuZnvOJmWjP
X-Gm-Message-State: AOJu0YziTCAHwF36hlf2S+FMt6pFu3XlpoC/1/TDoWXiuGlag2NwwxdK
	9sSb+1Cd5P0qOQcCausYpQE8nU7UTezCjSco2/Vv5Vi1XLqdssCJfQpStA==
X-Google-Smtp-Source: AGHT+IFbhLt5B59v3Rsdoknwa2B5pxJZX7eKqimPFv+YyyRGoM7dckvZx8R2/LRC42VvRgmHb2NtJw==
X-Received: by 2002:a25:870b:0:b0:dbd:be40:2191 with SMTP id a11-20020a25870b000000b00dbdbe402191mr10768280ybl.42.1714425299108;
        Mon, 29 Apr 2024 14:14:59 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id a5-20020ac81085000000b00434a165d45asm10753716qtj.38.2024.04.29.14.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:14:58 -0700 (PDT)
Date: Mon, 29 Apr 2024 17:14:58 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>, 
 "maze@google.com" <maze@google.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "yan@cloudflare.com" <yan@cloudflare.com>
Message-ID: <66300dd27bc48_2f15ff2944a@willemb.c.googlers.com.notmuch>
In-Reply-To: <880367ab-e9a2-d9b4-c6d6-9e2efdf04a0f@iogearbox.net>
References: <20240415150103.23316-1-shiming.cheng@mediatek.com>
 <66227ce6c1898_116a9b294be@willemb.c.googlers.com.notmuch>
 <CANP3RGfxeKDUmGwSsZrAs88Fmzk50XxN+-MtaJZTp641aOhotA@mail.gmail.com>
 <6622acdd22168_122c5b2945@willemb.c.googlers.com.notmuch>
 <9f097bcafc5bacead23c769df4c3f63a80dcbad5.camel@mediatek.com>
 <6627ff5432c3a_1759e929467@willemb.c.googlers.com.notmuch>
 <274c7e9837e5bbe468d19aba7718cc1cf0f9a6eb.camel@mediatek.com>
 <66291716bcaed_1a760729446@willemb.c.googlers.com.notmuch>
 <c28a5c635f38a47f1be266c4328e5fbba44ff084.camel@mediatek.com>
 <662a63aeee385_1de39b294fd@willemb.c.googlers.com.notmuch>
 <752468b66d2f5766ea16381a0c5d7b82ab77c5c4.camel@mediatek.com>
 <ae0ba22a-049a-49c1-d791-d0e953625904@iogearbox.net>
 <662cfd6db06df_28b9852949a@willemb.c.googlers.com.notmuch>
 <afa6e302244a87c2a834fcc31d48b377e19a34a2.camel@mediatek.com>
 <5cc1c662-1cec-101c-8184-c32c210eeadc@iogearbox.net>
 <bd9d5fef2fa6154e162e963f5d669ff618b95229.camel@mediatek.com>
 <880367ab-e9a2-d9b4-c6d6-9e2efdf04a0f@iogearbox.net>
Subject: Re: [PATCH net] udp: fix segmentation crash for GRO packet without
 fraglist
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> >> The 'write_len > skb_headlen(skb)' test is redundant, no ?
> >>
> >> It is covered by the earlier test :
> >>
> >>           if (likely(len <= skb_headlen(skb)))
> >>                   return SKB_NOT_DROPPED_YET;
> >>
> > Daniel, it is not redundant. The bpf pulls a len between
> > skb_headlen(skb) and skb->len that results in error. Here it will stop
> > this operation. For other skbs(not SKB_GSO_FRAGLIST) it could be a
> > normal behaviour and will continue to do next pulling.
> 
> I meant something like the below. The len <= skb_headlen(skb) case you
> already return earlier with SKB_NOT_DROPPED_YET. Willem, do you see a
> case where this should not live in pskb_may_pull_reason() but rather
> specifically in skb_ensure_writable()?

Yes. pskb_may_pull is called all over the hot path. All in locations
that are known safe, because they only pull header bytes. I prefer to
limit the branch to the few (user configurable) locations that are in
scope.

