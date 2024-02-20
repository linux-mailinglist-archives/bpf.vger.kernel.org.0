Return-Path: <bpf+bounces-22292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908B85B698
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 10:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFD2C1F24F75
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8EB60DF7;
	Tue, 20 Feb 2024 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJkXcdsK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD4C60BBC
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419798; cv=none; b=ILL8LtAJhy8pXxyS27uImQAvlDTXkQQeqFLdcRTXSs+8BPWsaeyIFpHnzRiOfK5fJsp8etnbBgb+qE9tasvOe82sEjt1j4uYCVNdLZn+m2/Fcz6nQg3bRidBLp3XE2WsYjpcVVX3S0X8QXrB++fOp87oQUwxOf2UYYAFJv5L2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419798; c=relaxed/simple;
	bh=FstadCXymUJchl2BmMx/6XEVE/IR6m0ClNJjNNBqDvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzqgrVsS2iaF1zMslQcffOf7XPDWU1xdO3dJ5HXm8LIWYRC19Bkdyu9ZKgje5jCirvI2oouJu9M39Fp7Q6M5t17HhwIm/XaDeOu2qS2mkwYTUkc7t1yxHVALmRUK/b+Qu3VI5cdU9kKWSn0jnz7KAElX7v8f95kWaWLb5ocEWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJkXcdsK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708419795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Xnj2cm91ihkfMBnGkofflVE9Ff8ScaBx9XLRB2n80Q=;
	b=fJkXcdsKMYGNz+W8K83jKMo2PDdC18lXwrH8pRHLBiC5CybKhQ3wx4SHDBMJ9eVsrhKo6/
	YFBxm67kd65cQYddoebSnruSzbY9qonI2vc7YbEbbJ7qb8knupeCkYWs1fg4A27IUwKuiC
	X0xyvxHcXLgxNben2Ai10N6mDGeOhao=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-0-iIDyz4OzG8YlQb3SpM-w-1; Tue, 20 Feb 2024 04:03:13 -0500
X-MC-Unique: 0-iIDyz4OzG8YlQb3SpM-w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-411e53af2adso8286675e9.1
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 01:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419792; x=1709024592;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Xnj2cm91ihkfMBnGkofflVE9Ff8ScaBx9XLRB2n80Q=;
        b=xHfkHNkGEkFtIj+dZQ+LuuEDtJ5O5NPoGm5kaM21mTSj6IKAQeaMRKFj9EamS53CFe
         gZUvZ5Q1Ap9BXQJMwmREA3j3ki0P/SKqQ3ydtNHnpW4ANkByjiBDZFqZT+thgA0yJUk8
         k+5qssbwFNlsVhI58IxZVaSBsmlhkydiUDgemg85vnzibexnlRBZakyqCuWm31Af8+6P
         lK/BKE6qoIw3iGfUeNXhUPZTU5YYUKCDlCCq7xh6uqn18c3eRyt9N5DRIDy/c4CWR5IB
         obax2qM42kXFZalKurakq/BMn7PHCgCiSGtyV/Y/iUmM+W4POAcIjHewCQxriGxDcqEP
         FicQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW4p3BeqGn7ZHSmSvxVBnh1cDGwsezz2Yh/caWrpys9C/P6vs+IMdRJOBU73/2n9m7um0wHYNu1tjvchEp4pcyvAT2
X-Gm-Message-State: AOJu0YwotcNmgo9vD9cQ87LZTHpLsIw7iTfhQ1P+jmEC0zmemEfkp/fa
	O/u2oJ3E40PlSoT53B3r7YaFJ4Q/fNyMRZuJtn8R9gODYvfm9tXfoWu0pqJ3yEmi2D1yVm6b7SZ
	Sk/Sv9EMCgw2m+0vPP+HH8Ev0F0n7m6KMtT9u1s+LOLalLMOuag==
X-Received: by 2002:a05:600c:1d1c:b0:412:2b7a:6816 with SMTP id l28-20020a05600c1d1c00b004122b7a6816mr8299576wms.0.1708419792642;
        Tue, 20 Feb 2024 01:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtMy2DtBp6b9BekvJfgoFMR5pzZFVFLjEgGHsuoPbOnUk39TgqtNV4AQ5/x1JLQK7VAy31ow==
X-Received: by 2002:a05:600c:1d1c:b0:412:2b7a:6816 with SMTP id l28-20020a05600c1d1c00b004122b7a6816mr8299559wms.0.1708419792277;
        Tue, 20 Feb 2024 01:03:12 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-230-79.dyn.eolo.it. [146.241.230.79])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c224600b0041262355aeasm7212172wmm.16.2024.02.20.01.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:03:11 -0800 (PST)
Message-ID: <b5a062465f9afe36106fe1d624b2e9e129bea0f4.camel@redhat.com>
Subject: Re: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page
 pool for live XDP frames
From: Paolo Abeni <pabeni@redhat.com>
To: Daniel Borkmann <daniel@iogearbox.net>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 netdev@vger.kernel.org,  bpf@vger.kernel.org
Date: Tue, 20 Feb 2024 10:03:10 +0100
In-Reply-To: <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
References: <20240215132634.474055-1-toke@redhat.com>
	 <87wmr0b82y.fsf@toke.dk>
	 <631d6b12-fb5c-3074-3770-d6927aea393d@iogearbox.net>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-20 at 09:39 +0100, Daniel Borkmann wrote:
> On 2/19/24 7:52 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> > Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
> >=20
> > > Now that we have a system-wide page pool, we can use that for the liv=
e
> > > frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
> > > avoid the cost of creating a separate page pool instance for each
> > > syscall invocation. See the individual patches for more details.
> > >=20
> > > Toke H=C3=B8iland-J=C3=B8rgensen (3):
> > >    net: Register system page pool as an XDP memory model
> > >    bpf: test_run: Use system page pool for XDP live frame mode
> > >    bpf: test_run: Fix cacheline alignment of live XDP frame data
> > >      structures
> > >=20
> > >   include/linux/netdevice.h |   1 +
> > >   net/bpf/test_run.c        | 138 +++++++++++++++++++----------------=
---
> > >   net/core/dev.c            |  13 +++-
> > >   3 files changed, 81 insertions(+), 71 deletions(-)
> >=20
> > Hi maintainers
> >=20
> > This series is targeting net-next, but it's listed as delegate:bpf in
> > patchwork[0]; is that a mistake? Do I need to do anything more to nudge=
 it
> > along?
>=20
> I moved it over to netdev, it would be good next time if there are depend=
encies
> which are in net-next but not yet bpf-next to clearly state them given fr=
om this
> series the majority touches the bpf test infra code.

This series apparently causes bpf self-tests failures:

https://github.com/kernel-patches/bpf/actions/runs/7929088890/job/216488282=
78

I'm unsure if that is blocking, or just a CI glitch.

The series LGTM, but I think it would be better if someone from the
ebpf team could also have a look.

Thanks!

Paolo


