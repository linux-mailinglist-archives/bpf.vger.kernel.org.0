Return-Path: <bpf+bounces-66151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD2FB2EDAE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 07:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC0917A202
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 05:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7263C223337;
	Thu, 21 Aug 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nb1xk394"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DD19EED3
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 05:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755755229; cv=none; b=PKEbRvmzKXfIBokSi3UqK3ZLbzAq3uJpyE+8UVb9oCaVcNoL7PtSYsYg/0lDivlT8rZwxI/C/lT+DRXd2PjYxkCguSc5mRBESV8v+kT87cFUNtmtF5Jn2GbHebfBdj9PQtTFrb82DOk+GwJfMo4A15FeZbig/Pm/tpfS3azFlpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755755229; c=relaxed/simple;
	bh=8zLVz2t/vhXsH1xW9JY5STCx7n8IC1DUJfDaNLJnvvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaUpeZ5q9rrHmIu9vE9oX2tols2dp/J/KITCxrdV/zJjGspamDBiBZWI3Cn/0JPZ93wd9vRWmJEgwMj6AqZAtQL5700y12GQ+d9c8F7L8TZaohNeXAdaiG1rY9pq+el2KzeO96WTj90SEoAmGphtk+cnmwUBNjw+iBmCmjtX9rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nb1xk394; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-50f88eea7f0so206086137.1
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755755226; x=1756360026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zLVz2t/vhXsH1xW9JY5STCx7n8IC1DUJfDaNLJnvvM=;
        b=nb1xk3943g75JB6CPuaPRO5uNddhT3OYBecHrTToyORkMKbX8nJtTTW94EuFqHSBDL
         BE1y/fbI2y7qr6tbvx0ZbWGbvxWZsd5KRSsGsMh+IHbfi5QcE8NA5Cj+H9z5BVJcYpzC
         m68cYq8q9rjLGAt9Xcd8uFdhzxHI198AvrDsss5/nlkPl17abYZfvvX0NO9CFYlifj5M
         4I3ywbOW7V6PrNg/JsFKULKKfHifv44YNiy5JiPVYa30HNXdoWFh4bes3K2pznlRt3yP
         QIWfCX6Q8IWeLDNANciVc92u7TSbgFpTOP6DGJOaC12ZxbUaQtNOmAc5C04+OgbNn0zD
         QGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755755226; x=1756360026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zLVz2t/vhXsH1xW9JY5STCx7n8IC1DUJfDaNLJnvvM=;
        b=onAgqKV3tv6Z/UVYUhzbX+5/iZghPDAm8WYm82R7t1YhUZeO1yCpx/d1MbD5bd3je0
         CifZBeS5u0bMCGUES/92AySjaEqU+pEP/HRQwRQeVisRNB6+8ujj0St5eHwdukN3rnyq
         gJp9iHkVoZwMmWrwv/jZ08q547pZuziL8Rn2lnYS79cfXmAM5CUwBoStIGGUT3UyPHlj
         d3sL3wtVzpHB7WvJH91Zfv/hs1bzarnulwx6Ys2dN/JfNcHmfb7z2bIyuyryh5/Ue53r
         BLBhJfnxBb7F8VP2gPArxDXyIAmKSzFiWLrX099rx3IiD6IMc7ZeQb36WQigDJYWLOCX
         bhXg==
X-Forwarded-Encrypted: i=1; AJvYcCUPHxYF1qv0EcJPX9EVaQqVsEGP3MPtT6vlNkCMNolMiAUsxRkECnILx0PYzEy/EpkHB78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzePeja94+jGcpjQgUl+foLQDunqrvJ0J4NzufmqPPrvaSlBcjJ
	8Xt77+cSsowl3Z6hOpHozI0+rqqwvUMC5fR1k2g8Ne9AgRVFypXdMd0QyOQE2WaSakqGKVYqvx2
	1ofPcU5Ugq2MmnvQMvE7NLCPvChy87FE=
X-Gm-Gg: ASbGncsM6RxF+Zlbtl97nNhqAcmDzvTPC4neFLKNgUGSYv/ZIl3tKR7BRaPfaJo2woU
	338BhxTVVm/XyBNcsWfR1nT23Ff9T76fCxdNBI354eR/MOwH9NLaL56Ip4bHMuH7RTLxOderGCY
	0zHMlArF6wlhV9NWTBNiNVHi6Rn6dVfEOyldmz2QvN0BWO3SfHHNCpAv3EBGFN5USWoQUeaxUB2
	/CB2VA0MBdDTpFhE80zrTFLafAtAp06hsoa0El4
X-Google-Smtp-Source: AGHT+IFj2Veoy3hxf/RcXyKheieQmzSGmGpw5CKZ5QtExLdJ7nB2UcH40tqIJraQ+AxbxH+xvRyTtdhl3nxIswJ++rg=
X-Received: by 2002:a05:6102:3ed5:b0:4bb:eb4a:f9ec with SMTP id
 ada2fe7eead31-51be0c333f2mr372438137.16.1755755225986; Wed, 20 Aug 2025
 22:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0ba41cd7-adc0-4c65-b1e0-defd8ebc2d64@nandakumar.co.in> <c1296815-67f5-4f31-99fe-b9a86bb7a117@nandakumar.co.in>
In-Reply-To: <c1296815-67f5-4f31-99fe-b9a86bb7a117@nandakumar.co.in>
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Thu, 21 Aug 2025 01:46:54 -0400
X-Gm-Features: Ac12FXy-2T8nhySWNuCbmN9Qx7Mwi3Dq6-T3SmzhxUAdVJ6_CJJX85-xDQ9ApZs
Message-ID: <CAM=Ch04WBnb2=okJmTqqbyFGzhiFA4DKTCeF3+HH-=8wz=PYvQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: improve the general precision of tnum_mul
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 3:48=E2=80=AFAM Nandakumar Edamana
<nandakumar@nandakumar.co.in> wrote:
>
> On 20/08/25 11:45, Harishankar Vishwanathan wrote:

[...]

> > If I understand the idea correctly, when the multiplier's (i.e. tnum a)=
 bit is
> > unknown, it can either be 0 or 1. If it is 0, then we add nothing to
> > accumulator, i.e. TNUM(0, 0). If it is 1, we can add b to the accumulat=
or
> > (appropriately shifted). The main idea is to take the union of these tw=
o
> > possible partial products, and add that to the accumulator. If so, coul=
d we also
> > do the following?
> >
> > acc =3D tnum_add(acc, tnum_union(TNUM(0, 0), b));
>
> But tnum_union(TNUM(0, 0), b) would introduce a concrete 0 to the set,
> right?

That makes sense, the above would be imprecise.

[...]

Best,
Harishankar Vishwanathan

