Return-Path: <bpf+bounces-66928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA231B3B17A
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 05:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7AF17AD45
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 03:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B6D2264BB;
	Fri, 29 Aug 2025 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCJUlEj7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77D224B01;
	Fri, 29 Aug 2025 03:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436982; cv=none; b=pT1LtQIhHJR1bkA22hhi/VLeVYWyuGuWvErcl2iDdIivXISeJQUSBICbnObFIE3oi0BGBHuCqU6S9XciUx3tp98oxQ6M/igwYRIgnio998+erIHoeyyuMVrFaz0WEEhnMRQiLSDwr3r7VWpRmioKyRpsV6zl/cbIxNIWFgQzy4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436982; c=relaxed/simple;
	bh=ncZ5KmT7quqwzcrHgotoGroXDhrNJBCwwNOtYIhN8/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhYziNEqu6vf12nIEQzEVXLZympFHXJrNvPZnbtQQhCxVrwvlMLGrdLe9RKwxp6zWqxHCw0FW9QqciGEsnMIbZJnCpDD+0eGJoxRcSRAdaVFbgrXnAD8WPFtzK1ew/gOLhIxSVfRmYA4f8NQzdy85HO8xf2o9uPa3bB41STot+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCJUlEj7; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70de042246eso14588736d6.1;
        Thu, 28 Aug 2025 20:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756436980; x=1757041780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncZ5KmT7quqwzcrHgotoGroXDhrNJBCwwNOtYIhN8/o=;
        b=kCJUlEj7wdjDW1kJB4LTseZ9ZM5CNOc6vDaxUTyGPmomWI+8KFSG3AEslkpwrCCREV
         leHUdcVGmK/817CPKg9Dqh9lm69HOJLxvKxjCQ4gQCjfrvEbjTlmKolgb5hzBPbJkKYw
         NN815lWOz/vnhfVTrhkpvoHcPVlbi+xaBNq7XG3Nn7KpO30vvXJkXrzk4UhS8QZW8NS9
         VcXIzy31P/yRgAIBeObHAr+zPxs4/xN6jEpoJbjukQ2ozOFSUVfp7cBCZxSfTPFyTwdG
         DHczU1Emf/synESFXK4Ezr7J9pdGKDhk5ZTBiD1wyQvR9OL4L09+x3+nEsyOcBnEiwKT
         kGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756436980; x=1757041780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncZ5KmT7quqwzcrHgotoGroXDhrNJBCwwNOtYIhN8/o=;
        b=IV6vF5aeoq3I4mf711XaNAm4ePwfYhBmGEXnpU2u51e0Q+O6JfmTSahrJPJs8hMDXk
         yosKVD7aPJfr2T1GWUM/QTwAAQZYQyalwm6ndlMJOnQJRnSswTJ5to+/QZuyX9uPT9qr
         Ycz1ru5l9XGbStyDvSq+xxoOA7GbV3mEO1OVtfNOSpRqZguQjHC69YwxxzBuNdLSDdjw
         6GhWhHEnKx2/Z1kkP+KB+/10LLZIxgqqPSMvut6+hDN5OmHdhTOpxQfRMuyHp7LdBpus
         36GRllwE+1LtwbrepR72Ud9BuxVCHpaK1tcKkSYg5Cjjg+Kc7hdevATDQsEEt2nyy67p
         X8FA==
X-Forwarded-Encrypted: i=1; AJvYcCUFfbWWJq3wBmddm2XMoRVdw/p3ej5w3p4rSOW/effQlKosOzi5+gzSmBFJrmM6SlOq1QQ=@vger.kernel.org, AJvYcCWkxEO57B4ADSbYDzt8Ctw5o3Zo7D1UgSW2ygH9qhQlXsvfNbBJUWLB1pkhFiNKPcCde24IRVBRxsKh@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOtoJdzk98NKPV0/dqpNRKazH6C5pEfK4zrFH9F0F4MQ59UZe
	aqHBvcvCIbmPrtBOrYycznxuTuI086DsOJaSHSEhmeMKRRVG0Eg2+PFhm3eEzMAZAEIAQaRoEeJ
	aOuxrRZu/E/olJS1i/PzCXmGbb1l3RSqRb6wo6bgWVg==
X-Gm-Gg: ASbGncszD7JjmGZpUAGuApOuXCnMrdWjPa++IJKTv/ehGgoNZJu5DzBBZSs4Mdz8U50
	KJrjekzijN5RApMpABG3TgggTgxbza4vbyu2X7nT1Szyav5cHl7kJbyRzpeMSZKM9+RLAfVchVZ
	ZIWRIyq9hBp5kF4vqvBirXu1WqA4vGXxF3tLCd+3juxziphGcEoyWDDsohqbXTOIUIfkIpQTZzd
	nucgZ86ffUBh9823fUV3WrjarFcaZDq0Nus4D1n
X-Google-Smtp-Source: AGHT+IEPbm4y7fey1onDhmByGjKxHPo70ZzQZHAm5qmQHVdf90yYBG4ZI4uiojOgTL0GgVXd+t0SBHE6CuokBI95Z6g=
X-Received: by 2002:a05:6214:19c4:b0:70e:86:af3c with SMTP id
 6a1803df08f44-70e0086b42amr23127166d6.57.1756436979724; Thu, 28 Aug 2025
 20:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826071948.2618-1-laoar.shao@gmail.com> <20250826071948.2618-3-laoar.shao@gmail.com>
 <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local> <CALOAHbAwTZQViuZQZpor9iMHr8w8AvptQTb5TEHrekN6FSjLxw@mail.gmail.com>
 <e3566528-5441-4467-8a3b-4aa52c031984@lucifer.local>
In-Reply-To: <e3566528-5441-4467-8a3b-4aa52c031984@lucifer.local>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 29 Aug 2025 11:09:03 +0800
X-Gm-Features: Ac12FXxStXC_AgXwSS5Q3ssoufTvU5oMx-nbH_8R1iTOseNBbytcdMCyoYiAjS8
Message-ID: <CALOAHbDhUsrVxbr8XBD_Gv8ASbKYm+x7w4Vc7hqM01cBRxPHag@mail.gmail.com>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, 
	usamaarif642@gmail.com, gutierrez.asier@huawei-partners.com, 
	willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:42=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 28, 2025 at 02:57:03PM +0800, Yafang Shao wrote:
> > On Wed, Aug 27, 2025 at 11:34=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > +cc cgroup people, please do include them on this stuff.
> >
> > sure.
>
> Be good to cc on future respins for the whole series also! :) just so eve=
rybody
> is in the loop, thanks!

Thanks for the reminder. I'll include them in the next version.

--=20
Regards
Yafang

