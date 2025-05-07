Return-Path: <bpf+bounces-57659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC223AAE0AE
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 15:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712723ACAEC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 13:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67B288C34;
	Wed,  7 May 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqptnUNR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D4205E3B;
	Wed,  7 May 2025 13:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746624350; cv=none; b=q1zQpycdHsfqpuvBBJK6yxtNFZGuQ8cYAf5nZMrGMceWIC1FWOUfUwDgsRmj0dGZ5a0gvruixVte8yUPArL5wrVjETYih/edLR/Cb7x4eU+sNgBSHgCXSQ9B8qT361AuMuWGtqhDRgxTBfBX8LRFyXpHT4kjjokH8pCFrxf7HpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746624350; c=relaxed/simple;
	bh=XuqKldatZJSJXG8MtFpeHEsJUCB/6DEyn6025FxB7s4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=iOr4AwUCUyGQeee2bIr13wacwrIQZObj7g1XjRzkwFhdS4r/ETrzAuD3UFHmpjo12p1oRrTZxgSGA6kZUSXOAB5Zdz7TpUxJnQ42yWXKsQQJPfweTTV+gx3T4Bb0+KbazF0rtqmEWUNzJD/TTdHVh1MZVuDp4vWXEX6ff90MQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqptnUNR; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4769bbc21b0so84450741cf.2;
        Wed, 07 May 2025 06:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746624347; x=1747229147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ju9surcg4WRhRjIn9UK2jqKz8AErRJjEry8FncOABXo=;
        b=BqptnUNRSnklzE3AOJvC29Z/XNMFFh27rnmWW4zvNobEEg0JaWVljQv92pgAtG7KwR
         zeY6DhrrDecP/BBvfkEne4XNV1TkO+lK131sF6FiDKj65wrcME0218ft8yZ8PPRTJYN9
         RXu9Rbp3ZnC7IGtxBoNqDgP/gHurYDPZUpcMnAmHoS1F8lMP7zx2v8XI5sQZhrI7iuX/
         c2R7miRvymTbkUnqVUVYwEB7r0ai5rnZT059bY6GfTnaTLs5c5xOznpuYGOQY8JFtgbR
         GMs7tWzot6JxMrmMRysC3A+RjMyv4aEk+xyPeY9EgERpEG9Dz3A0frUZFoIUE5EVV/uF
         89pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746624347; x=1747229147;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ju9surcg4WRhRjIn9UK2jqKz8AErRJjEry8FncOABXo=;
        b=bOcDNRr8XddOmkgIVopVirNQPf+jD1PXb/Xfr0zmhdzpPeDpz3JaBfC+b5a3Jqa/sf
         9lwuz9QXOriVodeYWC3pTMy7xRQFaqJo7wk0C7hjKV6D08UB/1mUhG/OaLDUOgLoxMhT
         hQYwmPZbVg4XcyFmjKeVg5V8+ugdBajBBHRjJCzSqqEJtVBFkugWugQwc8lBY4/AxGaQ
         GIBfsjX0jFx8GoOapdtZ2zvUA7rL5hili7rkpMyYho1hJWYVM8UQuTiJBL1TKpc2rjlh
         dBf55e08sQ3aaWWvM5UDWNJmS29KBtib2i6Hbg32knzKhyG4bCE0lNZWGRr9wnfnwjVQ
         tN6w==
X-Forwarded-Encrypted: i=1; AJvYcCVY+bEz+Do9PV4vLKREyKqApcyMWOBE1HVmAUGSeKCynnn6gYB9lMyIqNzWay8QhU8X1jA=@vger.kernel.org, AJvYcCX8jDtLDRuu6YOVJBGCM2rNC4VeykoHmJblsbanV/pepN8c7ulB0mXp1HjTmexelRxh4FW2gbqX@vger.kernel.org
X-Gm-Message-State: AOJu0YxrL7i1zoSans+X6fifETrYW6r9ky7+2xtfioHdxI/Za2JPcccj
	Zd/o5qvZJdEMbLOnnQgGpb2eSMonjjWnJpsiWe0FeqMdySJ77Rd+
X-Gm-Gg: ASbGncvZMUMxdv0/viT/RrSY3Agp7hOcKd3GZ52WV/DisezdUwhtdjWR4A64FJgPJ/4
	jcRGKeGgNloRS2YjXNZxAISzGhAulLhEABYlAOryRZ+iZWPIFagRXalDgYuIQFwENw2e9eY77s8
	1FCYhs1pdK3O2Ccdxbtldq85Adta8H2dC7U87ueIunJ+eRTnsFS2RhMutw5Q/hl+aP3gUVG02gi
	Fq0ME1cIHaPTMgAP3ENtkL5SaQfu/wftkqMikjhKAZZosg9EQQDV5oAGyyzGt+9fX37ibKW3GFt
	ao298+x6Yd6Ii6pSyA58G3dITaJcObooYCd0lSoMB/LZoDduOXKpP5mjDsFRgtq6RNro7EHmVZO
	Ol6/TzwAu2zBi/QXYegmb
X-Google-Smtp-Source: AGHT+IH5ANBdXCHrRP/OFJkBBzHCvl/W2cQYt2GwsGCwskaHwX/qerNpCDg31pQ9DdOihrDgjdBXiQ==
X-Received: by 2002:a05:622a:cd:b0:476:9847:7c73 with SMTP id d75a77b69052e-492265e977fmr41117941cf.26.1746624347277;
        Wed, 07 May 2025 06:25:47 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-49220f8329bsm13939761cf.5.2025.05.07.06.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:25:45 -0700 (PDT)
Date: Wed, 07 May 2025 09:25:45 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jon Kohler <jon@nutanix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "ast@kernel.org" <ast@kernel.org>, 
 "daniel@iogearbox.net" <daniel@iogearbox.net>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "hawk@kernel.org" <hawk@kernel.org>, 
 "john.fastabend@gmail.com" <john.fastabend@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>, 
 Jason Wang <jasowang@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <681b5f5983645_1e4406294c4@willemb.c.googlers.com.notmuch>
In-Reply-To: <3A17D540-12F6-46FE-8109-CCAEBC168754@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
 <681a22ac9964d_15abb629445@willemb.c.googlers.com.notmuch>
 <3A17D540-12F6-46FE-8109-CCAEBC168754@nutanix.com>
Subject: Re: [PATCH net-next 0/4] tun: optimize SKB allocation with NAPI cache
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jon Kohler wrote:
> =

> =

> > On May 6, 2025, at 10:54=E2=80=AFAM, Willem de Bruijn <willemdebruijn=
.kernel@gmail.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  CAUTION: External Email
> > =

> > |-------------------------------------------------------------------!=

> > =

> > Jon Kohler wrote:
> >> Use the per-CPU NAPI cache for SKB allocation, leveraging bulk
> >> allocation since the batch size is known at submission time. This
> >> improves efficiency by reducing allocation overhead, particularly wh=
en
> >> using IFF_NAPI and GRO, which can replenish the cache in a tight loo=
p.
> > =

> > Do you have experimental data?
> =

> Yes! Sorry I missed to paste it into the cover letter. For the GRO case=
, I
> turned tso off in the guest, which when using iperf3 + TCP puts all of =
the
> traffic down the tun_xdp_one() path, so we get good batching, and GRO
> aggregates the payloads back up again. =

> =

> cmds:
>   ethtool -K eth0 tso off
>   taskset -c 2 iperf3  -c other-vm-here -t 30 -p 5200 --bind local-add-=
here --cport 4200 -b 0 -i 30
> =

> Before this series: ~14.4 Gbits/sec
> =

> After this series: ~15.2 Gbits/sec
> =

> So about a ~5%-ish speedup in that case.
> =

> In the UDP case (same syntax, just add a -u), there isn=E2=80=99t any G=
RO but
> we do get a wee bump on pure TX of about ~1%
> =

> In mixed TX/RX where there is cache feeding happening from tun_do_read,=

> we get a bit of a bump too, since the batch allocate doesn=E2=80=99t ne=
ed to work as
> hard. =

> =

> In pure RX side, there is a bit of a benefit in that path because of bu=
lk
> deallocate, so it seems to be a net-win all around from what I=E2=80=99=
ve seen thus far.
> =

> Happy to grab more details if there are other aspects you=E2=80=99re cu=
rious about.

Thanks! No this is great. Let's definitely capture this in the
relevant patch or commit message. I'll take a closer look at the
implementation now.

> Note: In both the TCP non-GSO case and UDP cases, we=E2=80=99d get even=
 more
> of a bump if we can figure out the overhead of vhost get_tx_bufs, which=
 is
> a ~37% overhead per flame graph. Adding Jason/Michael as FYI on that. I=

> suspect we could separately do some sort of batched reads there, which
> would give us even more room for this series to scream.=

