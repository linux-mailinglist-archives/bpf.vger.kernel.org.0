Return-Path: <bpf+bounces-50422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB33A276B9
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2C118879D8
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 16:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA5215187;
	Tue,  4 Feb 2025 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFNPYCz9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04A2147F6;
	Tue,  4 Feb 2025 16:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684946; cv=none; b=EoZRwZaa41WQldoGmvyM7osBO/7XuLLvrag8fVKDX+oOnT8LIWAVujygpTo3LVAgA9RA73jmREOn+jgIJtY9Zv4NO8uaowdONcaWtW4nBiOfnXvY/M3Bpi1BZLtzXRG3zJusTS08qxD28qxbGbp2QVFWnx6vmFUilN5eJUqUDM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684946; c=relaxed/simple;
	bh=If8coQdhF5Nd+vwH+6qeES812n9PDmFQAtpVc1rdr7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RwwzVm80dOilTmmBiH6qFtlxy13xogYOMyAa6ONdP22xJgNRVQ4QaahDkvY29CwIleafpFWo64pYugCXO8aidoDmQLo8iwlXLhgbSAw2LzMf96nDnIGcTRmVfzEfL7Zqs0k7/e3AQbqWV/3ugFQXNRCIKafEn3cC81oyVHtOjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFNPYCz9; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38da88e6db0so465684f8f.2;
        Tue, 04 Feb 2025 08:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738684943; x=1739289743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=If8coQdhF5Nd+vwH+6qeES812n9PDmFQAtpVc1rdr7g=;
        b=HFNPYCz9T9jVryZqJPgQO0FkL3BB7GNs5vFJTnTPf1StX1I4yBrwvlW7fMgUQJFkY5
         nVWYj3b7P7yYGuXEQq+2Ap5ZrLyB7Hu/z0WpxitYAyOmg4M7jQcjlIR1dNgQPi6SX/77
         KkYs8meGgONaGooIQlReV7Dr/1HNMC9w6WMnrcmof7KF0lpEFQfuGnfC8VLmjqaH9OsG
         G0Gi3XlSH8kHJ3vzCiDTha7ldIs0PvQ8FgD5WZ8vDciSOY8IFrV/7Pn8IyYMeYShpEKK
         4kQCswLm5YFN1hZS93GUS3CERhArpVH9f0vB9ZXPYMNKnYKQlbNSWKP5T0WOF21oM9+X
         7XJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738684943; x=1739289743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If8coQdhF5Nd+vwH+6qeES812n9PDmFQAtpVc1rdr7g=;
        b=ulpohp/PtzYMcT46j1R9efWbkOP6zYJp+OJ49I96Mh3SejuEtCjvAL2gaMz60e648Q
         ddUZ+mzcQRfuYOUJGagJyx/oCtdrVmMgtMeGSD1Sz+z/pvMD49pI60B2WmJRS+2y1F9Z
         Z8vVKUbPmG7gu4+J+9raih6VjyqqcDjGbJWRJMW7AWoDx/HktvaIaBIdbWltGOpbAsWd
         AMP+wAfdiqgssmuCMLA12fv/Z26K8kJIzPEMQuS7HxLwU6B0I2b5mgJzcS0XJV9otU2z
         ZpIvFatrtTGq0M9C6FaWomG0p6DUGTOnFJ+vmnQe+BqSv71Dkunlnl0kDAPPsaCbJOzc
         19iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKywhIOqJ9ht2L0lQSB4yaQQrYHdNUSavSmAmGTrVjxTNaQILuaV+Jf1mOSMILweld0so=@vger.kernel.org, AJvYcCXeEYGMXwrUiGCCQa+oFZMP4o7thSIVChxGdeWyDjPX3DwblIwz+H8cglD4uJk8NjPxmlLElzHx@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVIpK9b2PsbwFUHYGDUMsHTXntTlMBgbPgAZZFgh7+MWeI8hc
	pqnainZXSue4qpPGtiohR9ovNeCrqwcwSyOPhS5yaN3A1cWUhIDurhs8KSJ5k2T2AUoDQ8xQBj9
	P0+BQPmYMvaiZEyK9XbJsXszMbm8=
X-Gm-Gg: ASbGncvxOZwSi0zxkM1uhHpBGaslpw949yg/t6v2d7HgesVh3/zz1uh7gEb9q+tltsg
	ouyndrC47A5R/9tpjCUhjmePKD2Tscx/vzapjYVrA2Z0sPO1HJQi7+pchnCGJV8gr7QkkFRxYYt
	FWk9eAW7OAyZF5
X-Google-Smtp-Source: AGHT+IHeN97gerTQvzADmizTaOUdKrsOPcpv4a+weyZuEv2JCgTjbx35ZkJM0XcK3avJjhtGXI0gbgiqRC+ZlCTBpNg=
X-Received: by 2002:a5d:64a1:0:b0:385:f220:f798 with SMTP id
 ffacd0b85a97d-38c5194ca80mr20871753f8f.6.1738684943008; Tue, 04 Feb 2025
 08:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1738665783.git.petrm@nvidia.com> <CAADnVQKMN4+Zg9ZG4FpH9pJw4KdmwWmT2d4BiJgHUUQ-Hd7OkQ@mail.gmail.com>
 <BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB59225F7D902ACBC6A91511C3CBF42@BL1PR12MB5922.namprd12.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 4 Feb 2025 16:02:12 +0000
X-Gm-Features: AWEUYZmfN46xxQRo3nRVY9d3svhIhjNTxveJyvu3-bNeq5DbAeH4VL7q771GjKs
Message-ID: <CAADnVQLJfd201t_-bgWHRJRDHm4FQDNapbmAQhPd18OEFq_QdA@mail.gmail.com>
Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
To: Amit Cohen <amcohen@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Network Development <netdev@vger.kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 3:59=E2=80=AFPM Amit Cohen <amcohen@nvidia.com> wrot=
e:
>
>
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Tuesday, 4 February 2025 17:56
> > To: Petr Machata <petrm@nvidia.com>
> > Cc: David S. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@googl=
e.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Andrew Lunn <andrew+netdev@lunn.ch>; Network Devel=
opment <netdev@vger.kernel.org>; Amit Cohen
> > <amcohen@nvidia.com>; Ido Schimmel <idosch@nvidia.com>; Alexei Starovoi=
tov <ast@kernel.org>; Daniel Borkmann
> > <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John =
Fastabend <john.fastabend@gmail.com>; bpf
> > <bpf@vger.kernel.org>; mlxsw <mlxsw@nvidia.com>
> > Subject: Re: [PATCH net-next 00/12] mlxsw: Preparations for XDP support
> >
> > On Tue, Feb 4, 2025 at 11:06=E2=80=AFAM Petr Machata <petrm@nvidia.com>=
 wrote:
> > >
> > > Amit Cohen writes:
> > >
> > > A future patch set will add support for XDP in mlxsw driver. This set=
 adds
> > > some preparations.
> >
> > Why?
> > What is the goal here?
> > My understanding is that mlxsw is a hw switch and skb-s are used to
> > implement tap functionality for few listeners.
> > The volume of such packets is supposed to be small.
> > Even if XDP is added there is a huge mismatch in packet rates.
> > Hence the question. Why bother?
>
> You're right, most of packets should be handled by HW, XDP is mainly usef=
ul for telemetry.

Why skb path is not enough?

