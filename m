Return-Path: <bpf+bounces-37044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A49508A1
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 17:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10006B2482E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844221A01AB;
	Tue, 13 Aug 2024 15:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNMBJq2H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A541E4A4;
	Tue, 13 Aug 2024 15:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561904; cv=none; b=bSs/BDLodsnmROARarXRl7b2WA5if3V82R6bqfkO4gAGCqI8efOCFn0lTOyBtgEe3lbOc5U2bn64/dgWpBlCBjfYqmwvUg5WSxJfAFQ7s3N1S/EC4VoDndcrg2kEJoOuMDC4D0IVjXaefF+tF3dxi4sEfaTXfxOou5HXpVwYMXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561904; c=relaxed/simple;
	bh=raOwBnqYH5LhsUp41vZu/c8ShXCLiujerZ2BM0PTRAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gyF/tUJlVellLUTuLKwuP4MnG5ro6DG0klr2PeDfL12cw2glg6kxsUrvysoOmlAsITq4FnHteRqj8Hh6mI03v5c1VNZun8RtqS59SNrwd+ZnalKx4meM8CRhVlpZkcWClRkmeIzT0W3Q5sNbkPhpAA7aIIot2YCSA8KVZO9H0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNMBJq2H; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3683f56b9bdso3739149f8f.1;
        Tue, 13 Aug 2024 08:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723561901; x=1724166701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4nC9j0rwXAV42mfe1JGwEatxbihzY0JrdD7+bccVpsE=;
        b=nNMBJq2HqcvSHxtrXDlLxKwbvoTgYvObAxOF3a+Y36vrSY+WKZ7SDxvIrvA05NeMM+
         UiXPxRirj2u/K1XrPj3nAKM3k1ZFc3xj13WkQgoyjLJcc+qeylB80UBq5eN8CoA2/JH2
         vqn4ln8JbJ5I/9y1744aJUfAYJudv7f/+47sjZnYF81e3dn73YmUJ6YkCPBYCzSu6ndM
         iMTkoUEOr5w44folNbMCENz2Nal5NZzAU7IFxh1BkhvfUlDr2h/QgueObo8aqfqvhlYo
         ayKfx0ILPfJFNNfBI/btMeNzwAy8NYDjScc2uG3KBuT3P5SGb2kluDzPFzNLv/fTVmMD
         4lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723561901; x=1724166701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nC9j0rwXAV42mfe1JGwEatxbihzY0JrdD7+bccVpsE=;
        b=drzPNEED6abwnvjvm3+GPcDdQkY6D/dglNXJ6+oPAXAwA+PcKj95TtOrPLInMEHLbY
         d+2+1atHKAn/LZvwB881QoM5uMttZ8QHzDNRojFc3jarKJBRanX8UFsQuNKf0BUjFl9N
         Iw1xeNbInkKI4P6HHbA252MetG1Hx1G0/xZsBNdsHLjpu5bdScqL9oo0FtNfTNL2wxtg
         ktRJsYJblLm0TTVqtOk6t3YMGI64+MGXqdZ1uu5DbeG6DfEmILtvGbaz0E8ytMEgAw/4
         ef8cR5puJlkza2LcOsGdrVy7O3LO5jDulNwabhppFR54dls53oDG62CZBjQXVJ8dZLX1
         6Eaw==
X-Forwarded-Encrypted: i=1; AJvYcCXK1n54joW/ZvATScEK3cKCrV5UJEj703V5qLU1czEg9ZL1131cXTEOfy5RHk0f8iuuu8J/Zw5fw3Z0JsPIIRrYB6BSj3gF5qSw7vu4h4YB8G+F2pVeodjrFKUi0nd0QrhiXpXgtdtVY2DNu11f/9yjtZglXMxzyYCM
X-Gm-Message-State: AOJu0YwTRkQVjuAySABeUXul/w1+4rU9ePp83ie17OpRDGmbJ7eJfVlZ
	CpsKPqOG4UDJ7JYWCWbkMznrnTqhIxku3+8NzKXb/V3jI8QBQvPTq4wfLzvQY0Qexyt/7XK3Qb/
	wjosXJ6E34gba7HYM6R2ePf7ijD4=
X-Google-Smtp-Source: AGHT+IEiRdefQPqd/dPcUdZDhMBU+XuPSqJx3UZGGW6A7Tj9UdJ3g2ZF6n39rYUPDVgFQ3fwnLBKaSyoF92wFN4g+fE=
X-Received: by 2002:a5d:47c2:0:b0:368:303b:8fe7 with SMTP id
 ffacd0b85a97d-3716ccd8341mr2763330f8f.7.1723561900405; Tue, 13 Aug 2024
 08:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com> <4aba9fae-563d-4a4e-8336-44e24551d9f9@huawei.com>
In-Reply-To: <4aba9fae-563d-4a4e-8336-44e24551d9f9@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 13 Aug 2024 08:11:03 -0700
Message-ID: <CAKgT0UezjgRX9QUWkee_p8KVQQa1va12k2CaGJeOYrr5LGg4YQ@mail.gmail.com>
Subject: Re: [PATCH net-next v13 00/14] Replace page_frag with page_frag_cache
 for sk_page_frag()
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 4:30=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/8 20:37, Yunsheng Lin wrote:
>
> ...
>
> >
> > CC: Alexander Duyck <alexander.duyck@gmail.com>
> >
> > 1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei=
.com/
> >
> > Change log:
> > V13:
> >    1. Move page_frag_test from mm/ to tools/testing/selftest/mm
> >    2. Use ptr_ring to replace ptr_pool for page_frag_test.c
> >    3. Retest based on the new testing ko, which shows a big different
> >       result than using ptr_pool.
>
> Hi, Davem & Jakub & Paolo
>     It seems the state of this patchset is changed to 'Deferred' in the
> patchwork, as the info regarding the state in 'Documentation/process/
> maintainer-netdev.rst':
>
> Deferred           patch needs to be reposted later, usually due to depen=
dency
>                    or because it was posted for a closed tree
>
> Obviously it was not the a closed tree reason here, I guess it was the de=
pendency
> reason casuing the 'Deferred' here? I am not sure if I understand what so=
rt of
> dependency this patchset is running into? It would be good to mention wha=
t need
> to be done avoid the kind of dependency too.
>
>
> Hi, Alexander
>     The v13 mainly address your comments about the page_fage_test module.
> It seems the your main comment about this patchset is about the new API
> naming now, and it seems there was no feedback in previous version for
> about a week:
>
> https://lore.kernel.org/all/ca6be29e-ab53-4673-9624-90d41616a154@huawei.c=
om/
>
> If there is still disagreement about the new API naming or other things, =
it
> would be good to continue the discussion, so that we can have better
> understanding of each other's main concern and better idea might come up =
too,
> like the discussion about new layout for 'struct page_frag_cache' and the
> new refactoring in patch 8.

Sorry for not getting to this sooner. I have been travelling for the
last week and a half. I just got home on Sunday and I am suffering
from a pretty bad bout of jet lag as I am overcoming a 12.5 hour time
change. The earliest I can probably get to this for review would be
tomorrow morning (8/14 in the AM PDT) as my calendar has me fully
booked with meetings most of today.

Thanks,

- Alex

