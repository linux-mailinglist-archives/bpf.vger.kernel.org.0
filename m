Return-Path: <bpf+bounces-37892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E0595BE39
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 20:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537EF2858CD
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5039F1D0482;
	Thu, 22 Aug 2024 18:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AngS+qT/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD801CF29E
	for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351349; cv=none; b=LIvZKhagcd0oGiT53wbl0O8QCRvkKx4fu5Q3FYhqa+luX6i3mCJeUZexH56mt6CRCeGGF/148cC7mI4ycV9dMHp33Gr9MuLChkdQYqbfateMZmUNGx3uqmtolsraAmyHW0Rd5F/ncj8Ti6GyZCEBoZ/3p7cXEUFdDgZSy4+uyXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351349; c=relaxed/simple;
	bh=0xSBnCaiK+sgvELTZ33saa66jXfCr2pDcRjlRoiwJvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hm1d/CxgidW9wWew3SQKkULObp+HSzrmloln+XwsasPEhqqGtQIFi0rykdE5Mis6lbRlPECwY1ZtzrEoW3HHrb0ojQ3Tcedf1ve2ZsanfHPytyQH0HpM/NMw7i5sAHUfJRj/zQYlH+e2jED5OID190kE7WJYEqArtRHElKclWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AngS+qT/; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f15790b472so11578791fa.0
        for <bpf@vger.kernel.org>; Thu, 22 Aug 2024 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1724351346; x=1724956146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ro9G47jXocjBA17VCL84GH/kDMRcUp7XzQ0BEcZD3aw=;
        b=AngS+qT/CYxdlsqMLFqQBvrT6bZ/tlj+Sv2BoOUBtpmeLFnIl1wuawCcs5qCznAo6Z
         MaIZkiYFsRy9aH+hzQFqq41vHbbsaoKKLD9iMrmFXroE2q91A5dczFFKvO1fzUVb8xaG
         lp6bACy0pCxburSUdqrxYUag4PX5WpMkZw6lDnbK9H5nbn3UweubxEgsFmVHQOUmUUHO
         WpnQQaNfOXw24BrIU1C5Im2tVJ9dvDiq52XbHYF0GeE6YYrM+E8fPC2kC0nEZ1Jee3zr
         OkIv4ey36SWPJ9YQIq03I858JjvCQayXbJsUcXzqyWKU7Db4NStTadXeqj0HXJ5+I3rT
         IEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351346; x=1724956146;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ro9G47jXocjBA17VCL84GH/kDMRcUp7XzQ0BEcZD3aw=;
        b=iEXMSKb5thl4wUZFbOrKcKnHj1yAh5rYR4CdwayUHrdG6lOieNKANHp/KkZZOdx41+
         pSuiTGS6szbDeLoxcMfD/XOOBHMKL4Bv0BK8Xnp0d9vmm7wX/SLFx2sWJ4jTlctXONu1
         dQpvSJV2Z3/ZPrFt8i+OpT4XRFYqEj6cOoa4qstyNGX/VEuup7uba/TgQ66c3UHWUL1z
         LR4KZ8zdOITsR7SephApiQbVHgiisH91GxeJzrp8APCj3U7AO0pYwxe1T4gdACFYktMd
         MHCbwSnmizAJBaEmz7ObT5nCP9KQ9jZUdYYUlE80mmPhP/Y2fZcgwUlL62nbvo3DivnG
         KvAA==
X-Gm-Message-State: AOJu0YyPI4e/27nkQEW2GKn+j5sCyr6n6FvzQYbPpOD/QkCWq/vUPR4X
	IbRUgwEXuA6fk4r2/sN7xFraiAOqniwYN83ueyXtzXZ2fNTBeAAIQITGDaLE378=
X-Google-Smtp-Source: AGHT+IEynJ311KaMtMpqEK6qwRdubbYs/xH5VXLHLv0evaXhSKFEWsuvNaH0mSpIVOuE61bht76e/Q==
X-Received: by 2002:a2e:809:0:b0:2f3:af4b:1fc with SMTP id 38308e7fff4ca-2f3f87f1503mr41995251fa.3.1724351345876;
        Thu, 22 Aug 2024 11:29:05 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3cb0b2sm1235226a12.22.2024.08.22.11.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 11:29:05 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Philo Lu <lulie@linux.alibaba.com>
Cc: bpf <bpf@vger.kernel.org>,  netdev@vger.kernel.org,  ast@kernel.org,
  daniel@iogearbox.net,  andrii@kernel.org,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  kernel-team
 <kernel-team@cloudflare.com>
Subject: Re: Question: Move BPF_SK_LOOKUP ahead of connected UDP sk lookup?
In-Reply-To: <2fd14650-2294-4285-b3a5-88b443367a79@linux.alibaba.com> (Philo
	Lu's message of "Wed, 21 Aug 2024 19:44:27 +0800")
References: <6e239bb7-b7f9-4a40-bd1d-a522d4b9529c@linux.alibaba.com>
	<87bk1mdybf.fsf@cloudflare.com>
	<2fd14650-2294-4285-b3a5-88b443367a79@linux.alibaba.com>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Thu, 22 Aug 2024 20:29:03 +0200
Message-ID: <877cc8e7io.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 07:44 PM +08, Philo Lu wrote:
> On 2024/8/21 17:23, Jakub Sitnicki wrote:
>> Hi Philo,
>> [CC Eric and Paolo who have more context than me here.]
>> On Tue, Aug 20, 2024 at 08:31 PM +08, Philo Lu wrote:
>>> Hi all, I wonder if it is feasible to move BPF_SK_LOOKUP ahead of conne=
cted UDP
>>> sk lookup?
>>>
> ...
>>>
>>> So is there any other problem on it=EF=BC=9FOr I'll try to work on it a=
nd commit
>>> patches later.
>>>
>>> [0]https://lore.kernel.org/bpf/20190618130050.8344-1-jakub@cloudflare.c=
om/
>>>
>>> Thank you for your time.
>> It was done like that to maintain the connected UDP socket guarantees.
>> Similarly to the established TCP sockets. The contract is that if you
>> are bound to a 4-tuple, you will receive the packets destined to it.
>>=20
>
> Thanks for your explaination. IIUC, bpf_sk_lookup was designed to skip co=
nnected
> socket lookup (established for TCP and connected for UDP), so it is not s=
upposed
> to run before connected UDP lookup.
> (though it seems so close to solve our problem...)

Yes, correct. Motivation behind bpf_sk_lookup was to steer TCP
connections & UDP flows to listening / unconnected sockets, like you can
do with TPROXY [1].

Since it had nothing to do with established / connected sockets, we
added the BPF hook in such a way that they are unaffected by it.

>> It sounds like you are looking for an efficient way to lookup a
>> connected UDP socket. We would be interested in that as well. We use> co=
nnected UDP/QUIC on egress where we don't expect the peer to roam and
>> change its address. There's a memory cost on the kernel side to using
>> them, but they make it easier to structure your application, because you
>> can have roughly the same design for TCP and UDP transport.
>>=20
> Yes, we have exactly the same problem.

Good to know that there are other users of connected UDP out there.

Loosely related - I'm planning to raise the question if using connected
UDP sockets on ingress makes sense for QUIC at Plumbers [2].  Connected
UDP lookup performance is one of the aspects, here.

>> So what if instead of doing it in BPF, we make it better for everyone
>> and introduce a hash table keyed by 4-tuple for connected sockets in the
>> udp stack itself (counterpart of ehash in tcp)?
>
> This solution is also ok to me. But I'm not sure are there previous attem=
pts or
> technical problems on it?
>
> In fact, I have done a simple test with 4-tuple UDP lookup, and it does m=
ake a
> difference:
> (kernel-5.10, 1000 connected UDP socket on server, use sockperf to send m=
sg to
> one of them, and take average for 5s)
>
> Without 4-tuple lookup:
>
> %Cpu0: 0.0 us, 0.0 sy, 0.0 ni,  0.0 id, 0.0 wa, 0.0 hi, 100.0 si, 0.0 st
> %Cpu1: 0.2 us, 0.2 sy, 0.0 ni, 99.4 id, 0.0 wa, 0.2 hi,   0.0 si, 0.0 st
> MiB Mem :7625.1 total,   6761.5 free,    210.2 used,    653.4 buff/cache
> MiB Swap:   0.0 total,      0.0 free,      0.0 used.   7176.2 avail Mem
>
> ---
> With 4-tuple lookup:
>
> %Cpu0: 0.2 us, 0.4 sy, 0.0 ni, 48.1 id, 0.0 wa, 1.2 hi, 50.1 si,  0.0 st
> %Cpu1: 0.6 us, 0.4 sy, 0.0 ni, 98.8 id, 0.0 wa, 0.2 hi,  0.0 si,  0.0 st
> MiB Mem :7625.1 total,   6759.9 free,    211.9 used,    653.3 buff/cache
> MiB Swap:   0.0 total,      0.0 free,      0.0 used.   7174.6 avail Mem

Right. The overhead is expected. All server's connected sockets end up
in one hash bucket and we need to walk a long chain on lookup.

The workaround is not "pretty". You have configure your server to
receive on IP addresses and/or ports :-/

[1] Which also respects established / connected sockets, as long as they
    have_TRANSPARENT flag set.  Users need to set it "manually" for UDP.

[2] https://lpc.events/event/18/abstracts/2134/

