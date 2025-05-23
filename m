Return-Path: <bpf+bounces-58820-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CADAC1D62
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 08:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0553E9E7F7C
	for <lists+bpf@lfdr.de>; Fri, 23 May 2025 06:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A01B4F1F;
	Fri, 23 May 2025 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Djvmxll4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5C91A9B49
	for <bpf@vger.kernel.org>; Fri, 23 May 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747983539; cv=none; b=mrKAWJea1lX1dLDcHhL9B0Ppqa7XexnWc/o+8MU4oe0vMJbupGZwiIBZbdFxL+aRyicclB9IZOJisYxtD+HW3nCSf1PxhgROpbYi54HULedBtJx+z+vgRIPYlBmMMduYXJ5+4oUNcryOiit9UV2NQ3y21cUct+nNPrtVLf7nJcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747983539; c=relaxed/simple;
	bh=mmT62JilQ2z0onHOlXHmlx2bo0Cr4KXAU5eYidFObzk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbDf+lBHywgk+Jrp3S/JhSyTR7vC6m+MFY/8Fx4x2iRpAxFosx9WU1C2vyImb6bwxytnIYhzVi5DkxHyY8XoqDnHoG4nLFJKYt/qTq9wFQUFP0WJNhTdRePAFjg9iJtexWc4FhSU9VaJBdoVBfutj+bqQTp0vJ1dZ3ikOGjln0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Djvmxll4; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26f5cd984cso6600273a12.3
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 23:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747983537; x=1748588337; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9gsoJM/inqmVj0egbGiiVo6Rv+cEkA6yr/9+XXTzoI=;
        b=Djvmxll4dPsx8JD6u4h9HzAb3ypnVNnXONNVJGpg7cKbONI2AC1yiSUg8c5Dj4kFFZ
         gVdp/utSwj3MRri+13xK9F3YavDEt0mw6WyFXwwWs9l+5wLKLonPvph+40+HKwuZiEuM
         H4chtIFmIvtOhzoWCTX6mWvVayPL1YNVDitLJacZc+ypo0gBgNrqaaqBJYAX1MhbwqWZ
         b0ob5Pez/C6p5gqcP02FlKge12lFdYso6BJiJ3O0FeeBO1/JK0HLDkkXtnlUgjhvrjRv
         KLX0H+M+Z5J45ZszepGrnBWt/x9IgEh/E3Y7s/hrFDWBPdIdQV5oPNtQPHByqHfDdsfw
         ZWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747983537; x=1748588337;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9gsoJM/inqmVj0egbGiiVo6Rv+cEkA6yr/9+XXTzoI=;
        b=snCpg7DynmcQ8iW6t9udsUczqi8wiR5U11/a/JwjLPsCnqMSwzQCv+qkcbKa4mYhv9
         WJXTQWQfLNhqkfk0ud8GBmPQ65u7It0E3b4T1FJuIHO4EhjDcaaHDPhmE7D/giRvFxYi
         Jo/woWF0DvC1uq4xkKgWSAnSJzlO6NhvFijZVl54gqQolbmIzY/wvukJBjkTqV2kZRZp
         GP7pcm4CCjVxExr/i6D0GKEK7ibDUEU5SLdqlu4YRj8A8xNXFk7oL34LvE2MFJumQX7C
         Wvx1KkPKBzFW6RgnqylfYNKdIlzj2OIljv1y2VUT8hcO/NyF1NUnmZw5GS5MzdwJC+rx
         cDGA==
X-Gm-Message-State: AOJu0YwP++Z17fCk1Cy9F6QrqaEO0GtJDZCvGxIwBXHc/9G38cmTCN+x
	3sOKBEODryxJbRSzQT53fTN4lmN8rWQ41jrHm+AB3Z/6YSCuFFxV6kA4
X-Gm-Gg: ASbGncvM7CcmUzoC+a3bFolTTsMp1uyCJso/N+tXP6/msDauefc4shs40oPEC/greU4
	90ZuqlczLduQkSTnBdIwPf/kPPcwXC0ZrZvQiKGPMZE3jS8uOWyv2TDuRCM3eto3M71+olyoWpy
	+GDLhgKEOuRCX7illWrlcvtO3tviKalxQa0vRyvJoXx8hiJVq8RWlAf3hE2ScZVi7/gOSGjgTzn
	/rAwX/cg6jKCqDkS8oh/lAunOnBfTEVYh0SOU33dlJaSnWi9XT5Mx3pfM/+8ToSBrkCKzWOVZYI
	u2vTvCQbJBIGvMLANbX9stI2pCB631rgAUOt87ZBRyBLn5oTIoweer23qPkm45doKqQpuPHfBKk
	9CvtszkdEev2V1Tx9xpu9312e4H88
X-Google-Smtp-Source: AGHT+IE3oQG64/Ij3y6zvFyOIC4czEe/nNrBy8rGjsfaEkJ+ygcZrvuxqu22WBbYbttrfdM3oliZMg==
X-Received: by 2002:a17:902:ce07:b0:231:e331:b7dd with SMTP id d9443c01a7336-233f23c9f03mr34965535ad.35.1747983536745;
        Thu, 22 May 2025 23:58:56 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eedb3csm118298935ad.259.2025.05.22.23.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:58:56 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Thu, 22 May 2025 23:58:54 -0700
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v1] libbpf: Fix inheritance of BTF pointer size
Message-ID: <aDAcrlDkePRcC7bw@kodidev-ubuntu>
References: <20250522062116.1885601-1-tony.ambardar@gmail.com>
 <CAEf4BzYuVzgDPAPtp6WPshf369dw3unuCruQADZd3DSrSwUNOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYuVzgDPAPtp6WPshf369dw3unuCruQADZd3DSrSwUNOQ@mail.gmail.com>

On Thu, May 22, 2025 at 09:37:39AM -0700, Andrii Nakryiko wrote:
> On Wed, May 21, 2025 at 11:21 PM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> >
> > Update btf_new_empty() to copy the pointer size from a provided base BTF.
> > This ensures split BTF works properly and fixes test failures seen on
> > 32-bit targets:
> >
> >   root@qemu-armhf:/usr/libexec/kselftests-bpf# ./test_progs -a btf_split
> >   __test_btf_split:PASS:empty_main_btf 0 nsec
> >   __test_btf_split:PASS:main_ptr_sz 0 nsec
> >   __test_btf_split:PASS:empty_split_btf 0 nsec
> >   __test_btf_split:FAIL:inherit_ptr_sz unexpected inherit_ptr_sz: actual 4 != expected 8
> >   [...]
> >   #41/1    btf_split/single_split:FAIL
> >
> 
> Hm... can you debug it a little bit, please? I see that
> btf__pointer_size() on split BTF will do determine_ptr_size() call,
> which will do
> 
> if (btf->base_btf && btf->base_btf->ptr_sz > 0)
>     return btf->base_btf->ptr_sz;
> 
> So it looks intentional (though I can't claim I remember much of the
> details by now) that we don't proactively cache btf->ptr_sz when
> creating a new split BTF, but it should have resolved into base's
> pointer size. And if it doesn't, let's try to understand why?
> 

Because ptr_sz of new splits is initialized in btf_new_empty() with

    btf->ptr_sz = sizeof(void *);

and base BTF ignored. Thus btf->ptr_sz is non-zero, determine_ptr_size()
does not get called from btf__pointer_size(), and tests pass because BPF
CI validates only 64-bit targets with no 32-bit coverage.

Even with my patch, the ptr_sz code seems problematic and open to abuse.
It appears btf__set_pointer_size() can separately apply different ptr
sizes to base and split BTF, and btf__pointer_size() will likewise return
them.

Thinking out loud, maybe we just set btf->ptr_sz = 0 for all splits. Then
make btf__set_pointer_size() recur to update only the ultimate base BTF,
and btf__pointer_size() does the same, calling determine_ptr_size() if
base BTF ptr_sz == 0. That keeps ptr_sz consistent across multiple splits
I think. Oh, and then add 32-bit and cross-endian CI targets... :-)

WDYT?
 
> > Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
> > Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> > ---
> >  tools/lib/bpf/btf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 8d0d0b645a75..b1977888b35e 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -995,6 +995,7 @@ static struct btf *btf_new_empty(struct btf *base_btf)
> >
> >         if (base_btf) {
> >                 btf->base_btf = base_btf;
> > +               btf->ptr_sz = base_btf->ptr_sz;
> >                 btf->start_id = btf__type_cnt(base_btf);
> >                 btf->start_str_off = base_btf->hdr->str_len + base_btf->start_str_off;
> >                 btf->swapped_endian = base_btf->swapped_endian;
> > --
> > 2.34.1
> >

