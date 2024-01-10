Return-Path: <bpf+bounces-19320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B36CE829A9E
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 13:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A9EB1F25EFC
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 12:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAF4879F;
	Wed, 10 Jan 2024 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtgjtoHD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC2D4878E;
	Wed, 10 Jan 2024 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e43e489e4so46072955e9.1;
        Wed, 10 Jan 2024 04:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704890962; x=1705495762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxADgN4BIB9wGmJchf0EcDFoLEDhQTLFvqAQ3eCiias=;
        b=CtgjtoHDBQEwsf4mCSGzAVK3lO4sjy+YTsnXPU7qQefrt91b1SphzNKpExU/wjAsaC
         i5XsdeSfZ0RxMv791ZZ/ec1ym6OSWIs/X+E6+3MIUbcUjor5PrHoL8ybRL8FjuZi8UzU
         dmvteoZsKnfruOvLyWEgSqu32/sqm0szc3/dWUPKdHrB3uBViM2m1u6c+aUyeoP2NiUj
         ln36dJymT52DtSakylHSf7K2coJOp0Xzy/xN7B65PosRqDPWEA8wJD+9hP0XAGVnxIl7
         nSo9ZyBN2Zw5qXJdySIev8sYOY6zJPhpXa19QNxLu7n4Znb6fHXsYF+mRPXwLFes3JKI
         0yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890962; x=1705495762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XxADgN4BIB9wGmJchf0EcDFoLEDhQTLFvqAQ3eCiias=;
        b=lGJIA8PtfbMg1VbGDQGFQ/dkrCBTgpo6z/zHun7U33YKxynrrcD6o/wDz9tY9RmVyR
         fAgMJiaoQ5cfr5li2h8rTVZSg2Gp6VYSBDT9vlSbYhCWqzkgU7NHxaHFVdVGuKmoYCoy
         JfO48npbJ5IXINryoJzhBQrtWwcPs3D33ViQx4no7XXlV8Go7seSON58m7fHBGDXIQTO
         oKuAMKGgZQ/fR3QZSw0JZjQmf2F7AGfD/juAtd31c1UymIm8ZSPxGpZO/j1BqGHXt3RO
         XtIo54DO9gqM+YuadxTptglCQORp/9Zm/3QvV7GzXQCq4xtqwr4Nv4uIVbflqHg40V52
         h6sA==
X-Gm-Message-State: AOJu0YwJG1UldVvqFj63TVMPcDg1rvD7twXzfvVYJXE9EUs4vf6D8w6U
	cWAdeuQQcDbcFBpAk+ZnWcI=
X-Google-Smtp-Source: AGHT+IG80/MvhCHaJfYeEqM54J2wpTJEN9IWnYHNY5nH8Id7Ho0AFMXU2bbEKB56NjmkTaJ3O+F0lw==
X-Received: by 2002:a05:600c:4753:b0:40c:2d80:6c2a with SMTP id w19-20020a05600c475300b0040c2d806c2amr602297wmo.113.1704890961617;
        Wed, 10 Jan 2024 04:49:21 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id u6-20020a05600c138600b0040d5a9d6b68sm2147371wmf.6.2024.01.10.04.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 04:49:21 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 10 Jan 2024 13:49:19 +0100
To: Artem Savkov <asavkov@redhat.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] selftests/bpf: fix potential premature unload
 in bpf_testmod
Message-ID: <ZZ6ST3ohMwIzQUlE@krava>
References: <20240109164317.16371-1-asavkov@redhat.com>
 <82f55c0e-0ec8-4fe1-8d8c-b1de07558ad9@linux.dev>
 <ZZ5R-3FAHNoDStqc@wtfbox.lan>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ5R-3FAHNoDStqc@wtfbox.lan>

On Wed, Jan 10, 2024 at 09:14:51AM +0100, Artem Savkov wrote:
> On Tue, Jan 09, 2024 at 11:40:38AM -0800, Yonghong Song wrote:
> > 
> > On 1/9/24 8:43 AM, Artem Savkov wrote:
> > > It is possible for bpf_kfunc_call_test_release() to be called from
> > > bpf_map_free_deferred() when bpf_testmod is already unloaded and
> > > perf_test_stuct.cnt which it tries to decrease is no longer in memory.
> > > This patch tries to fix the issue by waiting for all references to be
> > > dropped in bpf_testmod_exit().
> > > 
> > > The issue can be triggered by running 'test_progs -t map_kptr' in 6.5,
> > > but is obscured in 6.6 by d119357d07435 ("rcu-tasks: Treat only
> > > synchronous grace periods urgently").
> > > 
> > > Fixes: 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")
> > 
> > Please add your Signed-off-by tag.
> 
> Thanks for noticing. Will resend with signed-off-by and your ack.
> 
> > I think the root cause is that bpf_kfunc_call_test_acquire() kfunc
> > is defined in bpf_testmod and the kfunc returns some data in bpf_testmod.
> > But the release function bpf_kfunc_call_test_release() is in the kernel.
> > The release func tries to access some data in bpf_testmod which might
> > have been unloaded. The prog_test_ref_kfunc is defined in the kernel, so
> > no bpf_testmod btf reference is hold so bpf_testmod can be unloaded before
> > bpf_kfunc_call_test_release().
> > As you mentioned, we won't have this issue if bpf_kfunc_call_test_acquire()
> > is also in the kernel.
> > 
> > I think putting bpf_kfunc_call_test_acquire() in bpf_testmod and
> > bpf_kfunc_call_test_release() in kernel is not a good idea and confusing.
> > But since this is only for tests, I guess we can live with that. With that,
> 
> Correct. 65eb006d85a2a ("bpf: Move kernel test kfuncs to bpf_testmod")
> also mentions why bpf_kfunc_call_test_release() is not in the module and
> states that this is temporary. I'll add a comment in v2 so the wait can
> be removed once the functions are re-united.

I somehow recall it has to do with the fact you can't have trusted
pointer on module's object, so that's why those structs had to stay
in kernel.. but I might be wrong

jirka

>  
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > 
> > > ---
> > >   tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > index 91907b321f913..63f0dbd016703 100644
> > > --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> > > @@ -2,6 +2,7 @@
> > >   /* Copyright (c) 2020 Facebook */
> > >   #include <linux/btf.h>
> > >   #include <linux/btf_ids.h>
> > > +#include <linux/delay.h>
> > >   #include <linux/error-injection.h>
> > >   #include <linux/init.h>
> > >   #include <linux/module.h>
> > > @@ -544,6 +545,9 @@ static int bpf_testmod_init(void)
> > >   static void bpf_testmod_exit(void)
> > >   {
> > > +	while (refcount_read(&prog_test_struct.cnt) > 1)
> > > +		msleep(20);
> > > +
> > >   	return sysfs_remove_bin_file(kernel_kobj, &bin_attr_bpf_testmod_file);
> > >   }
> > 
> 
> -- 
> Regards,
>   Artem
> 

