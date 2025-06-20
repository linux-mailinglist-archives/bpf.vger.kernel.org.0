Return-Path: <bpf+bounces-61171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E83AE1CA4
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 15:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCBB16AD79
	for <lists+bpf@lfdr.de>; Fri, 20 Jun 2025 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B58C28DEE2;
	Fri, 20 Jun 2025 13:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNjb4vfM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556328A3FA
	for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427489; cv=none; b=oT00qT0r4jmlJsuNneJ+ykNTsMQVbdVmM3rqF3FCLt1qiiKS8zfvlW0hrzcRv1Qca1qxQwI1U5mtUEEIbYxEXqYNu0mlOEEfupg4LZcnFyI+A0fV29rl6WOvAwLS6svAJdlbOW/7yZTiG4IAc/WTyhEJcPeN/h6ku/OTxjhwBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427489; c=relaxed/simple;
	bh=qzQlw3vzm8LT2v1EahwpTG2ZnbmXTWyx/P0le6TEpZg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A36kvXZaczHR3a1+MBzWqF7PTMwAWIumzxMbRQZ8ujj0TGBqaYF2PgkfjsDU75b7uFbEbUd/UfQy6/zvzHFb12ikccoS1RxJlKLR+XZgUEIg6bo1kg296NtoprQNJ2yhaJ8ovfOoY8WlZg5UId3+sTnWBGMYQjJFlVjsQ7DIhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNjb4vfM; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-adf34d5e698so611726166b.1
        for <bpf@vger.kernel.org>; Fri, 20 Jun 2025 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750427486; x=1751032286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GkTsEvULBtPCcg8MyORu4Ugg/YhycShOl7S1DeQOBIU=;
        b=fNjb4vfMgZYrsicvi3i5qeU+62TkO3LwlSNTIdw2A1D5hpUU6S0XmEwFOaIR4UoG5o
         247msDytBIyryuw4v8fre/KAkLZjpmb/T43I8sFAIiGYRm4DC2iPMCtGb5lHX/eM7YDD
         1seB38BTXME6GCDil6237ED5cuGV0iYx/uKIf9z+q8kVmw1rSXpTrABMtBbllq2dUdnw
         ghx0hXe98QApW84L32lyAfapQou040jGtYcsxSgdy1QQ6r7a/4kUmUEd0/f2/OmHkd7p
         +PVJSaI+UukziB23Mc4fvZ79UPJUprUbWSs0506VPavL0DQlK5WwUimqB1mJ2W8slb8x
         dzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750427486; x=1751032286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkTsEvULBtPCcg8MyORu4Ugg/YhycShOl7S1DeQOBIU=;
        b=MuwixM5/vf0Nkp5t6+hy8T2oZiT9XOI1iIkDhTGZg/WdEyMDQDjcSZr/+E0gN24E25
         Le+21ZS5wMYa+BLTLByZbFpdWCRMYNVyG40B9NVQ09ep36F5nT4hoVNBHu2Av8HH4I4M
         tCyVLvrzveZX6LhpWavu8wSDVvWGOu2tpTQBZuN6CFcFAG/RlxfoVNgwB5CyM7tfjbmx
         u5G6yqy/exB4aZXmQwWZbVrYOqlORbItQV2P4liK1uFkqI0+H+ynG5e8qT7Mtdi7cBuh
         s2L2heTr8vC653uDuAv0nFlmHwxNokVZCxp4LusBulDA6mJRar8zHXPY+yuA5oZqRwEF
         m0bA==
X-Forwarded-Encrypted: i=1; AJvYcCUkRgYQuQuKCI97sl2/aDIFaEPKgk2R18ml0NQt7H/sU7gTCuYZ8VtCkZuR54JvYG+OKvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuiaG4ezTyU7zmJqhyMyBLVxH/dJ/8ocecfM91Biwv06Scwei5
	HsiOmzfUliUSHqIVSEjnZtOa3a7iF566bK+uG+kMh7SU6wbIFSXI4Don
X-Gm-Gg: ASbGncu7uzOkvkUOZFWku3eHjq1I3608MdOrE1oqtvvnZKduv9kSG1NgmOgwSrW2p/v
	H/o9OSmFAOQzr/NPAIIbKzHrpx0S0aZjUnujNvCc0LarvPuNOoudQxhyKK1MZK1D6WkUqmMil+r
	bkDy4/8NYRVhCmfmaMkJlwWDCtAUxI/xL29ZWYaLBHZUMsQyPs+H4V7InswrcGnlRhx5cGaDjOa
	3mhd0F6LkJVWsyDIBIJ79s1OoZDN2hZSc5R2Ykd9vOjiWfL+L/5TZ0pqKC/ep3X2Or1ToruCMhu
	+zm20tSKYxqsfJejOhEf7tFf5unsFeHrPe/iTmwxEPV4Nuc4mg==
X-Google-Smtp-Source: AGHT+IHfwaDlmlKJSAz3EzaF6PLsNpmQ0zvwdMYRMaEadz2YaVPZtak0YCH6sBX186LVVP0LMAN7YA==
X-Received: by 2002:a17:907:3d16:b0:add:fa4e:8a6a with SMTP id a640c23a62f3a-ae05ae1feb9mr238459766b.10.1750427485670;
        Fri, 20 Jun 2025 06:51:25 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e7f2adsm169699866b.18.2025.06.20.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 06:51:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 20 Jun 2025 15:51:23 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add btf dedup test covering
 module BTF dedup
Message-ID: <aFVnWxNycW6ZtQAU@krava>
References: <20250430134249.2451066-1-alan.maguire@oracle.com>
 <aFVjVoafmmPeUqiz@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFVjVoafmmPeUqiz@krava>

On Fri, Jun 20, 2025 at 03:34:14PM +0200, Jiri Olsa wrote:
> On Wed, Apr 30, 2025 at 02:42:49PM +0100, Alan Maguire wrote:
> > Recently issues were observed with module BTF deduplication failures
> > [1].  Add a dedup selftest that ensures that core kernel types are
> > referenced from split BTF as base BTF types.  To do this use bpf_testmod
> > functions which utilize core kernel types, specifically
> > 
> > ssize_t
> > bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> >                        struct bin_attribute *bin_attr,
> >                        char *buf, loff_t off, size_t len);
> > 
> > __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);
> > 
> > __bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);
> > 
> > For each of these ensure that the types they reference -
> > struct file, struct kobject, struct bin_attr etc - are in base BTF.
> > Note that because bpf_testmod.ko is built with distilled base BTF
> > the associated reference types - i.e. the PTR that points at a
> > "struct file" - will be in split BTF.  As a result the test resolves
> > typedef and pointer references and verifies the pointed-at or
> > typedef'ed type is in base BTF.  Because we use BTF from
> > /sys/kernel/btf/bpf_testmod relocation has occurred for the
> > referenced types and they will be base - not distilled base - types.
> > 
> > For large-scale dedup issues, we see such types appear in split BTF and
> > as a result this test fails.  Hence it is proposed as a test which will
> > fail when large-scale dedup issues have occurred.
> > 
> > [1] https://lore.kernel.org/dwarves/CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com/
> > 
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> 
> hi Alan,
> this one started to fail in my tests.. it's likely some screw up in
> my environment, but I haven't found the cause yet, I'm using the
> pahole 1.30 .. just cheking if it's known issue already ;-)

hum, it might be my gcc-14 .. will upgrade

jirka

