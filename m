Return-Path: <bpf+bounces-37258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7699952C94
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE782285A71
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F7A1D61AB;
	Thu, 15 Aug 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnABYyfx"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460E91D618D
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723716912; cv=none; b=KkXFRY1gJ0BLSeVKbDqfObGkBjyHeRmLFbYYAs92ud9W8usQvDP6H7zeKfdaSqLlrihqbEDH39JTdZCcuFMWmCE25L7H24U43OOhyoV42LZaQ92xljtxmJyzahEYik1KvIQl93Wqm5hwNMfVGm0gb0R8MAZrnLoK3FNclJaeNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723716912; c=relaxed/simple;
	bh=4VPEfJTvmfBgqpWEmhZGfaI0okNNuQ9tbPIdnKzIPNs=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BCG2ZOEvFCderHe8TArL4YdqPmWRh0lPIVNtb2GCLEsh8K2s7xy4akZJNdn5YGyUVOZqxL+wbKG5Bs/yPL7eMSqDdbZtEJ00DBswg8D2/oXlz1t+zuv59XRek6jFvAYTiNrMx1K10/15RS3H7uAQlwT0dUlZ7z1VaLJC59EcICI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnABYyfx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723716909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4VPEfJTvmfBgqpWEmhZGfaI0okNNuQ9tbPIdnKzIPNs=;
	b=WnABYyfxs6ibJBFfRqfsU+LNAO6efovBzMp0/wJBBtM2w12Zy2hh5YHbjG2Q6Y39+OlxKz
	3gSpkZ+QUgpzQfrnmWi0aT5Mk0Lw1FA3eHVsMRPVTU63HCIfnU7JmQjLBC0rstSEvbVtbt
	QsSH6ut9FPnWenSj3Zq5t+N34yLBSM0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-VM6hjBSHNfSWv5aKT3LUDw-1; Thu, 15 Aug 2024 06:15:08 -0400
X-MC-Unique: VM6hjBSHNfSWv5aKT3LUDw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3717c75b265so388914f8f.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 03:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723716907; x=1724321707;
        h=mime-version:message-id:date:references:in-reply-to:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VPEfJTvmfBgqpWEmhZGfaI0okNNuQ9tbPIdnKzIPNs=;
        b=cdnMajEYcvzRYiYyct2XgeXqIP17sNUH7B4QgucaGKFG6BUnSYR/AjFmjXsbpwTpwa
         LAS4l3QJ+sKokcagoNCLmqGW1C7UaSJFT+APdZ71nrLBdSxI0njUSsUoI9YfTpZN5625
         tou+DdE9EabsYFwpasUVA7BuExyh+zBBJWuAUDreX5R+BK7Gnz+OKP5O+IZa9BUqtjWr
         FqAIB6qknZpzyLtN08Anm22JnSj41+43ssB2Y1cSXPoXLMglIWWI13FwT7QFj1jLNfgn
         kOXKPRTba1/a0xT/CgGxn+aIlNsaB+a5v6PkXjGYtsA6Ea6swJQXFuWzwsrZH6es9N4s
         XiRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk01C92TafoYggfMnAvtOdp6s5n0ngNC5IanAVSjP07T/YPH0qnUacNVSzfvanv8C65zOA3I1tNCkYQIIgkK4N85kr
X-Gm-Message-State: AOJu0YzkLZxxWYt9SsA2AQX3M1IFf4qrLgHysqA1w5AqeVD0tKsT6vSH
	hmFi5atnFk/pKnKIzxZ3CbvN8S1oBhhHtiUDL9gNId+vIFzpxMCYq6sdstN8aioExEP3lKtoWGF
	9IJstIM/9VYT1Rmv9lyqUZWZL2B9JKQm30qn/xIZHE02OcPJo7A==
X-Received: by 2002:a5d:69c6:0:b0:371:8d47:c174 with SMTP id ffacd0b85a97d-3718d47c283mr514280f8f.30.1723716906702;
        Thu, 15 Aug 2024 03:15:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9xiZ0Rp3LP6sBcNq0A1flnPS/fGarKdASNjYgytk1FrZTuuV1rFMPXAlRStkxIzOmMDD8+A==
X-Received: by 2002:a5d:69c6:0:b0:371:8d47:c174 with SMTP id ffacd0b85a97d-3718d47c283mr514263f8f.30.1723716906191;
        Thu, 15 Aug 2024 03:15:06 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a184sm1113408f8f.14.2024.08.15.03.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:15:05 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 6FB3E14AE03F; Thu, 15 Aug 2024 12:14:48 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
 <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <eric.dumazet@gmail.com>
Subject: Re: bpf-next experiment
In-Reply-To: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
References: <CAADnVQJgwGh+Jf=DUFuX28R2bpWVezigQYObNoKJT8UbqekOHA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 15 Aug 2024 12:14:48 +0200
Message-ID: <87bk1ucctj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> 2. Non-networking bpf commits land in bpf-next/master branch.
> It will form bpf-next PR during the merge window.
>
> 3. Networking related commits (like XDP) land in bpf-next/net branch.
> They will be PR-ed to net-next and ffwded from net-next
> as we do today. All these patches will get to mainline
> via net-next PR.

So from a submitter PoV, someone submitting an XDP-related patch (say),
should base this off of bpf-next/net, and tag it as bpf-next in the
subject? Or should it also be tagged as bpf-next/net?

-Toke


