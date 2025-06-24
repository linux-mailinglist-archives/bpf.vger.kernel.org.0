Return-Path: <bpf+bounces-61365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605AFAE63D4
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 13:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604CA4075B3
	for <lists+bpf@lfdr.de>; Tue, 24 Jun 2025 11:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9421284682;
	Tue, 24 Jun 2025 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgqlfVAc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0F1EBA09
	for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765694; cv=none; b=ISN7zZFP76zD+Qc0JGnJHiaPHpUGi4kLmzQcq+lJzkzEGU/ZNKDGcn2gkFsQQZNpbECrxviMaHYHYCQ5TgpGoObUNwxt9JiCLZiMkT8DlA0Y+g28Bh0I59EF0O7qmdW2ZoHn+NRyZDe3Ok0xS7iGeXTSHaOAZPxXwWkfl/6iPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765694; c=relaxed/simple;
	bh=g3MvI9dlAPXk9v7Ht3Y5Sbu9RyZs3MDiQQpGCfyFxF0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeG/wh2M+ZtkC+WcDwEDXqtWnPEcfAY4J5+P+hhQttNkeB/e4TwikYX5sZbdps8zfBQ/yRnC755Zdxb/mvkq17mRIrMROyLcOJDBQZkGQEbDWcU1mxY5NIO6sM9dc4rgm/aCR8TRwZfl6pnVSXrx/gDySgkN30Q4Ir1NA/Sfrzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgqlfVAc; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acb5ec407b1so871814566b.1
        for <bpf@vger.kernel.org>; Tue, 24 Jun 2025 04:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750765691; x=1751370491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zW+6D+JP87Tc9aa8R+gIT+GfGOYUJF9yrXCxL9GmKlA=;
        b=GgqlfVAczNcabzSaxtFmrdOIpSWGFD37G9PFvti8OZ/0UKX2kbGkptdIEk/ZH4vS33
         8pAKcaZczkOdM7jedbd9kxU8h/fRYHI/FKBw10owe+L7D6SoKVBwILWpZ4oIq/FgAmwg
         5pS9ajre/d9BBaazG6gtOjpWSE8lkoQGvyRIKdPwokm6rojwzoaacKUEgeT19ZllvrhT
         CvTO4/tj/ssq/rXB0yo8hp9KIcRN02uGxyN/0DLQwGMtUfHddQ3/4lstsQVWyyFKRwr8
         pVMap/k5kgIgwwTvGgTXSFNbnC8szx8EonI7rP0nmqdOHsx7EEmjrinF5ycZ2rghbG2L
         6AFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750765691; x=1751370491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zW+6D+JP87Tc9aa8R+gIT+GfGOYUJF9yrXCxL9GmKlA=;
        b=Hn2g7p6HGEhPxZFDDd7bI7XSW9aWqO1yF2H1CjQj7pIb/7ZGrAolpGtJkCFiJb5uRi
         +kguxsxIProQXEcdHMwUawoRa8BxzwD5K/3ioWBPCyRG0Wh2mVsCK+1FM6FQYZoK7VNg
         Mt9QYR/c44lhzt76Irb9G1K3CX99Fa863ynOD/FuUsVVVgig9/mNUIOXvXF00dZ5hydZ
         zA9VzIvkBl6jw3fEW9mAOE7WAY4I9OcFsA8jdBmiyGDXt556zCWvyhq/2qr5V6UE+yTs
         dGiri1ByT+bKLcA4ZAHSVmAGS5gT5niP5Aog0iuXUj5zRKu5BEgnVjB9wC0d1s+Ass9o
         LfBw==
X-Forwarded-Encrypted: i=1; AJvYcCVV7sbLS5doiSIBKvGR1S5aQfoVOpPQqQ1vqpgEV/h+laE4wFl5HSblhrZhyaY0J0UDiEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5KruHhctYEn9AI+XQUqRmZ3nJe1EIBtaTnvblBNXSJEGG/Mc
	m++dQMnT7+wpYaFLYu0zlgGREPOxVUYPAS3QuFelNfbfgySIpSdCRh41
X-Gm-Gg: ASbGncuj7YAhjCPFnwpc5uUoGSZVTXYaiSWKb/rXa9DD8g3C4KINRGt3haLweb4laRy
	S5/pkRU9quwdaJh5ORWuKFUQsGWGTSz1M8QEZQWOxSfq3DkpfuIC2Fg8Ydgrmn9H/3ayIwD08/Q
	VErIqJCy/vIX7T/4niJGzLv1/wFSiIQIz7qfIfpepMccwOxsiaUvzNfxoRL5k4fJwEzfgtk7LG+
	fKUVvjE3/6qIrrofo/v5dO6g+2X9wmA5I9SFEE28ivD1p6dPRbwzPk/EaS6uesCrGLQNVNPz2L7
	Fj41BzZ7gATKdRChDtH1jR63SjfzzUAjOA/T3X/syLmWU8FybQ==
X-Google-Smtp-Source: AGHT+IHHr0pI3KWTliUDk10tZ0NrK19mQurQjpg6T39VbqlBJvS4gvtBJfL5EjE3Vk+tNOWA4QuO6g==
X-Received: by 2002:a17:907:6ea5:b0:ad5:a29c:efed with SMTP id a640c23a62f3a-ae057b6c0efmr1429398566b.33.1750765690340;
        Tue, 24 Jun 2025 04:48:10 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053e8086fsm859214166b.27.2025.06.24.04.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 04:48:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Jun 2025 13:48:08 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mykolal@fb.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: add btf dedup test covering
 module BTF dedup
Message-ID: <aFqQeGG-vXEAldRA@krava>
References: <20250430134249.2451066-1-alan.maguire@oracle.com>
 <aFVjVoafmmPeUqiz@krava>
 <aFVnWxNycW6ZtQAU@krava>
 <769e1fb7-d4b2-47cb-b71d-7db2168cb5aa@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <769e1fb7-d4b2-47cb-b71d-7db2168cb5aa@oracle.com>

On Fri, Jun 20, 2025 at 04:41:48PM +0100, Alan Maguire wrote:
> On 20/06/2025 14:51, Jiri Olsa wrote:
> > On Fri, Jun 20, 2025 at 03:34:14PM +0200, Jiri Olsa wrote:
> >> On Wed, Apr 30, 2025 at 02:42:49PM +0100, Alan Maguire wrote:
> >>> Recently issues were observed with module BTF deduplication failures
> >>> [1].  Add a dedup selftest that ensures that core kernel types are
> >>> referenced from split BTF as base BTF types.  To do this use bpf_testmod
> >>> functions which utilize core kernel types, specifically
> >>>
> >>> ssize_t
> >>> bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> >>>                        struct bin_attribute *bin_attr,
> >>>                        char *buf, loff_t off, size_t len);
> >>>
> >>> __bpf_kfunc struct sock *bpf_kfunc_call_test3(struct sock *sk);
> >>>
> >>> __bpf_kfunc void bpf_kfunc_call_test_pass_ctx(struct __sk_buff *skb);
> >>>
> >>> For each of these ensure that the types they reference -
> >>> struct file, struct kobject, struct bin_attr etc - are in base BTF.
> >>> Note that because bpf_testmod.ko is built with distilled base BTF
> >>> the associated reference types - i.e. the PTR that points at a
> >>> "struct file" - will be in split BTF.  As a result the test resolves
> >>> typedef and pointer references and verifies the pointed-at or
> >>> typedef'ed type is in base BTF.  Because we use BTF from
> >>> /sys/kernel/btf/bpf_testmod relocation has occurred for the
> >>> referenced types and they will be base - not distilled base - types.
> >>>
> >>> For large-scale dedup issues, we see such types appear in split BTF and
> >>> as a result this test fails.  Hence it is proposed as a test which will
> >>> fail when large-scale dedup issues have occurred.
> >>>
> >>> [1] https://lore.kernel.org/dwarves/CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com/
> >>>
> >>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> >>
> >> hi Alan,
> >> this one started to fail in my tests.. it's likely some screw up in
> >> my environment, but I haven't found the cause yet, I'm using the
> >> pahole 1.30 .. just cheking if it's known issue already ;-)
> > 
> > hum, it might be my gcc-14 .. will upgrade
> >
> 
> hi Jiri, is it possible you were using the pre-dedup-fix pahole, i.e.
> the official 1.30, or a version without
> 
> commit 6362d1f1657e3381e3e622d70364145f72804504
> Author: Alan Maguire <alan.maguire@oracle.com>
> Date:   Tue Apr 29 20:49:05 2025 +0100
> 
>     pahole: Sync with libbpf mainline
> 
>     To pull in dedup fix in
> 
>     commit 8e64c387c942 ("libbpf: Add identical pointer detection to
> btf_dedup_is_equiv()")
> 
>     sync with latest libbpf.
> 
> ? That would mean you would hit the module dedup failure and the test
> would fail as a result. If that's the case, if you could try syncing to
> the "next" branch of pahole and see if it recurs, that would be great!
> Thanks!

yep, that helped, thank you

jirka

