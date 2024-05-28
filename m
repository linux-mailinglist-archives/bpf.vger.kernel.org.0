Return-Path: <bpf+bounces-30801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EFA8D28A8
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80B928AC4C
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 23:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78CE13F006;
	Tue, 28 May 2024 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4eie2u1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3906913E41C
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938384; cv=none; b=aJ1sMFkvBXioBZL+lyXnditPXJ6HZHAlMTIexdX20KXnz+iLz91r/iqZTdbOmSus8u1bW2YZ77+pc7W6A3nQARF4tcqwsvlOctlH9qf3nTUP3Xm3E3hoeU83mY2OUR96J+bLEdHqdjzP/PMdkblqZeXEeBQ9F7nDWMwi44Dl6WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938384; c=relaxed/simple;
	bh=F9t72r7ypFIyIcLL27ZjvnKX7BjMKqxe7E8276hUzpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bDIdkMR0aS6UKr42Sdy2NZMbeImmleGyFilrSAGm7hh+U3IjVPrQV+DZaHgBD9p2M/AEuH0IxvnC5bG+xIHW49is8iDIZQslvLUClEE+Won2U7O+JSvDccZVcmvOqjYlOGCeCyDyzuG/2TVcVYFy5MmA47wRYLWj9sQHvKPk7zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4eie2u1; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bdfa8ef0c3so1274859a91.0
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716938382; x=1717543182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUH7weXPY3KutzC/xp3IZpe+1y7mHkMOfwiRrgMLqzA=;
        b=E4eie2u1nlfWs6F9qNTgi3NEVnyeuBTllJh/ssTpf7z0Hi2ymBvWQiC+A2GFMw7C0n
         qEoipmSwDvnHmcxUIsVgt5t1dWkkJ4laWhbNw0d1ZUWkfnaZBo11cF1d0C32bMwtr8/V
         cDaSBffKcjfz0HoHKvOknz6YGj41qdvlw137i5KeCJq0OhyEip7ZaH3N0iD/Z3rn/TLh
         STf+7l2A69uzytV2vM7FpJL4BGVZoJPNX07R4ltgyADLnJpO66bewOItCYnkLZMiao4L
         s5MRlGyY21Bmi73rJ3BRRlAxAhB1GYrp9MxzBsv6Rgehod8Hcfbbf168aJjGu+r6AFlY
         LfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716938382; x=1717543182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUH7weXPY3KutzC/xp3IZpe+1y7mHkMOfwiRrgMLqzA=;
        b=iS6MDoDvrIbX2PZwU5KC5Mnkd2nWHek+zVjBRBhDmqoCSjnQOm920iK1KFtXbLPXH+
         z6eDReS+1RhT5FNAREmy/iEWPGb3GXf7U71iyR7l58fy9Uukmw5vW5WF2e6wqzWJ1Doy
         iKv0TXvPoU9FK6UxK5xC6TPdi7rtyfjhkB1sM+nwWTdYXmEbY7yhjTC2TQqu+86eoETv
         pfRXEbbmAX7juffiIjI4+aixkTJJf3P9eP3zBNA/DqLr8JlkLpYZnzsuxhyo3cwHUUZ5
         j2BRF0qUBo1eqMW9DRTVlOvKR/6/6esxS1s3IDH0V/0X9FQYbZiLspUnPVIYjuMKp9Ee
         m4rw==
X-Gm-Message-State: AOJu0Yxj4ddaC09sTm6EFGlJYacWWady4nLfIAmcUHEh+PafAZIgCDLG
	akA9clq0vjDSsDYMjYpwd/1QoDbBKNIDH67tvaYn4bbw/G04yOC2AWb0IQ182DHtEaEzvOvfEtO
	6aJYmTrsixGRSi0/tgZMNR9arIjs=
X-Google-Smtp-Source: AGHT+IEIYnIKVa/4cpTtCGBahcaV2YZBSpdrB0QeKNjVLoiAS3VF6dPdU4+N+oEfB8Akp7H9FIOTXw31ZH7vx5O+Y8U=
X-Received: by 2002:a17:90b:378b:b0:2bd:e007:cbca with SMTP id
 98e67ed59e1d1-2bf5f518d44mr12221034a91.31.1716938382456; Tue, 28 May 2024
 16:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517190555.4032078-1-eddyz87@gmail.com> <20240517190555.4032078-3-eddyz87@gmail.com>
 <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com> <dbb51b28cfcecc8461f9fe002869ff3206eaea14.camel@gmail.com>
In-Reply-To: <dbb51b28cfcecc8461f9fe002869ff3206eaea14.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 16:19:30 -0700
Message-ID: <CAEf4BzY=uJiZGp=05qd6hOh8QQw+SgYCYH2V9KEt90xEckeo3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] libbpf: API to access btf_dump emit queue
 and print single type
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:53=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> [...]
>
> > > +/* Dumps C language definition or forward declaration for type **id*=
*:
> > > + * - returns 1 if type is printable;
> > > + * - returns 0 if type is non-printable.
> >
> > does it also return <0 on error?
>
> Right
>
> >
> > > + */
> >
> > let's follow the format of doc comments, see other APIs. There is
> > @brief, @param, @return and so on.
>
> Will do
>
> > pw-bot: cr
> >
> >
> > > +LIBBPF_API int btf_dump__dump_one_type(struct btf_dump *d, __u32 id,=
 bool fwd);
> >
> > not a fan of a name, how about we do `btf_dump__emit_type(struct
> > btf_dump *d, __u32 id, struct btf_dump_emit_type_opts *opts)` and have
> > forward declaration flag as options? We have
> > btf_dump__emit_type_decl(), this one could be called
> > btf_dump__emit_type_def() as well. WDYT?
>
> `btf_dump__emit_type_def` seems good and I can make it accept options
> with forward as a flag.
>
> However, in such a case the following is also a contender:
>
> struct btf_dump_type_opts {
>         __u32 sz;
>         bool skip_deps;         /* flags picked so that by default       =
*/
>         bool forward_only;      /* the behavior matches non-opts variant =
*/
> };
>
> LIBBPF_API int btf_dump__dump_type_opts(struct btf_dump *d, __u32 id,
>                                         struct btf_dump_type_opts *opts);
>
>
> I find this contender more ugly but a bit more consistent.
> Wdyt?

You'll also need "skip_semicolon" which makes this even uglier. Which
is why I'd not do it as an extension to btf_dump__dump_type() API.


>
> [...]

