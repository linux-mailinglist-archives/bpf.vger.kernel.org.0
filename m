Return-Path: <bpf+bounces-42411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748AF9A3D4E
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 13:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79C671C21471
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22CF20262A;
	Fri, 18 Oct 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpjmGukk"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FC2022DE
	for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 11:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729250989; cv=none; b=QM0lg1M1luJXx15tOqq1B04bXpHXjpsHSlmMN7AxEnEdLkN7fai361J+6EpPYKx+MvtN7tBWFb0alSUiXlba86mZqA/0Q3v/wdKPql3IErXp9pcaG5CPIl4OOt4FobGo3nO0/cXJ8Vf/lqjx2OMCv23zNwEAyz2qnoaPs9hNNKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729250989; c=relaxed/simple;
	bh=MjnDskMjX8cG2gTKpro8itIwMnxgsfUdurZ3ZhmFgTA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NeFANhINWeXfa42/2Y9kHj7V6Zc0pGU2FOb24Bvd6WCc/FQtjVtpQC7kRjzuD4HREVmx0TYLCNUSIjBeYuBWttRN2EyrElIg0br5D9bsvLk/9D93TyoSlRNNQScoPwwi1gWfhuE6iHv2/fRfbMYEhGlCxn+ZdN1M56OfnUi+Fsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YpjmGukk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729250986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lX94VYYZhI1GNdILyGrNjIWxjBQHORxdJBShMvr6xl0=;
	b=YpjmGukkh+Xsde4SfMBmAaH0V7pMr71WuNnykRylWH5lPz1ft2rZI4d0nAEFd5/P66BK0K
	3/CDfSVP9Z1e2C/q4DMaRPN4jh21uk56K75+8Tz9y4EWiNRSJjAGV1aNDrJmnzrtUv7wcg
	S+yIdFabJrlSaPhGp7epUj8tobVQwcE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-_hU6WGlZOfSOflwmq5_llg-1; Fri, 18 Oct 2024 07:29:35 -0400
X-MC-Unique: _hU6WGlZOfSOflwmq5_llg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42ac185e26cso15527525e9.3
        for <bpf@vger.kernel.org>; Fri, 18 Oct 2024 04:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729250974; x=1729855774;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lX94VYYZhI1GNdILyGrNjIWxjBQHORxdJBShMvr6xl0=;
        b=wCIKnpwAnCe8e1LpIqQf/TilKKHCyhuN5CWB71nqF0LMa2sbFVqMuCtUwxcq4WTHAR
         Fjxyd7oBV1matYZxla30nBQdCmjQGawvpFmgRrTUqODSeSGg021fh5GgMiJiVdp7awdC
         GQKh8DN+Ict5TDGmKuxQsK1or53uiyh8WgbVG+HSVAhw/zMyCZRaqgMrExbvWZco01ud
         5MnVkxQ31ejvjKlGV37gLRJtOqLBP3zy8XTcrIuVi0613LMWUO0ws8f0MvtEPI1WIWhy
         qoPtq92HInzhS4Ea19JJSipor//9OZl6Wd/+aNIQWbqz2RC7yRu8O2lfErTjR7tD+0sZ
         lm2A==
X-Forwarded-Encrypted: i=1; AJvYcCW0VQR7QzN+WmgnKP2QxGSTQ6lv8RDxOfLZOF+/aQgBBiTbA5Mzvdq7IgiN0cQguGiKamM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr+ar7eM1LH/KJi6CgHCqyMF2buM7IW+NpRSTnHJshlj+qH1lQ
	NfpvyggMOLsvEzPjPZAtL8zFtbbDE+h6lGkxZwnjeLPb7qALvIFIYnhuzQsZ7AHUZ/VzzQOfuwM
	HqUSLYTLcuq+QfsiZELa/XF/4oEkvN/nNbt5PG7CxlbAOOw+XJA==
X-Received: by 2002:adf:fc86:0:b0:37d:3bad:a503 with SMTP id ffacd0b85a97d-37eb5c41d3emr1579071f8f.40.1729250973932;
        Fri, 18 Oct 2024 04:29:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxj+RvOltwYR6fUpBQ1sN/oQ7XL95/bAOzHFTi1ZdTbNwHM8snVRBHz14JHHkUGM4OhZdH6A==
X-Received: by 2002:adf:fc86:0:b0:37d:3bad:a503 with SMTP id ffacd0b85a97d-37eb5c41d3emr1579044f8f.40.1729250973469;
        Fri, 18 Oct 2024 04:29:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf088c63sm1694054f8f.58.2024.10.18.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 04:29:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C221A160ACC7; Fri, 18 Oct 2024 13:29:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Simon Horman <horms@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Jussi Maki
 <joamaki@gmail.com>, Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek
 <andy@greyhouse.net>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, Nikolay Aleksandrov
 <razor@blackwall.org>
Subject: Re: [PATCHv2 net-next 2/3] bonding: use correct return value
In-Reply-To: <20241018094139.GD1697@kernel.org>
References: <20241017020638.6905-1-liuhangbin@gmail.com>
 <20241017020638.6905-3-liuhangbin@gmail.com> <878qumzszs.fsf@toke.dk>
 <ZxGv2s4bl5VQV4g-@fedora> <20241018094139.GD1697@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 18 Oct 2024 13:29:30 +0200
Message-ID: <87o73hy7hh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simon Horman <horms@kernel.org> writes:

> On Fri, Oct 18, 2024 at 12:46:18AM +0000, Hangbin Liu wrote:
>> On Thu, Oct 17, 2024 at 04:47:19PM +0200, Toke H=C3=B8iland-J=C3=B8rgens=
en wrote:
>> > > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/b=
ond_main.c
>> > > index f0f76b6ac8be..6887a867fe8b 100644
>> > > --- a/drivers/net/bonding/bond_main.c
>> > > +++ b/drivers/net/bonding/bond_main.c
>> > > @@ -5699,7 +5699,7 @@ static int bond_xdp_set(struct net_device *dev=
, struct bpf_prog *prog,
>> > >  		if (dev_xdp_prog_count(slave_dev) > 0) {
>> > >  			SLAVE_NL_ERR(dev, slave_dev, extack,
>> > >  				     "Slave has XDP program loaded, please unload before enslav=
ing");
>> > > -			err =3D -EOPNOTSUPP;
>> > > +			err =3D -EEXIST;
>> >=20
>> > Hmm, this has been UAPI since kernel 5.15, so can we really change it
>> > now? What's the purpose of changing it, anyway?
>>=20
>> I just think it should return EXIST when the error is "Slave has XDP pro=
gram
>> loaded". No special reason. If all others think we should not change it,=
 I
>> can drop this patch.
>
> Hi Toke,
>
> Could you add some colour to what extent user's might rely on this error =
code?
>
> Basically I think that if they do then we shouldn't change this.

Well, that's the trouble with UAPI, we don't really know. In libxdp and
xdp-tools we look at the return code to provide a nicer error message,
like:

https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L6=
15

and as a signal to fall back to loading the programme without a dispatcher:

https://github.com/xdp-project/xdp-tools/blob/master/lib/libxdp/libxdp.c#L1=
824

Both of these cases would be unaffected (or even improved) by this
patch, so in that sense I don't have a concrete objection, just a
general "userspace may react to this". In other words, my concern is
more of a general "we don't know, so this seems risky". If any of you
have more information about how bonding XDP is generally used, that may
help get a better idea of this?

-Toke


