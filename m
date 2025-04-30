Return-Path: <bpf+bounces-57066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A48AA51AE
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 18:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 843CE3A2239
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 16:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150325E821;
	Wed, 30 Apr 2025 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaLcnkSu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E5261589
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746030544; cv=none; b=qFTvWR8k7lrBfBeansVujH+f1HIT9ELeecq/g0w623Uz7eJWcaw1e2o1VlaoEph7+ycPQeLSl4UIE2yQ3pgDq9iFUaMAWtuFH2DmSIOB5/XUnLx0VYStu60rBMrpxZrk7pz6QavGlqRjcvN9imXkhQ0O8/sicDeNlj5/LMOzxe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746030544; c=relaxed/simple;
	bh=ZDgC9wfqWIFNan5UahhvXdEw/QwETtkkhkF/4552tJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvmoleF4OKIqglp8PKdNODTiOEzCM4cTDY86uo8KwgVb6mrLfdLoxr2ln1TQXNnnwKPDL6FVAPQveQCFStLWyGsHNqJueShoUZK5iv6WdDGZ6raiGZmEr/U5Lu9bfHtRNS8WhdQ8uOm9rqAgsmw0M+OVC2HKnRuqghS+rl4s7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaLcnkSu; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1490901566b.2
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 09:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746030541; x=1746635341; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eJ0SDugrkPYnmzdNv4il7LJQGzJ57K0XWHq85uyqLfs=;
        b=FaLcnkSuH1xb/ZoMLCKrZ0JT+xEzzO2zG1MACqpRFSEglbm1fcIWoHgYZmHNmW0PVx
         1jaGNghgZ2kC2zyZVAy3FYb9jcM/u5Su+ApPXlwd6C9pKKAUv+JFuKpqnM23Jw1BYqyn
         /4tb3uZAmwqIAFaAxqbPf1/0+288OgqLWjdyQykoDYXaevlN/rXC/U/4ymXJY27dm/+e
         nBOoOpWB6idzeEJCDcoVPsXxrdNoz++6pwrKrdBYTIuaawDVB48ektM2sIeHl/xgWSgA
         iCCAnVBQR2gaMd715cS7K+PYMh9kXcXnGzulrq9CgXZSPNKC4ZcI2hk4rZrSTBKD3/Cv
         LFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746030541; x=1746635341;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eJ0SDugrkPYnmzdNv4il7LJQGzJ57K0XWHq85uyqLfs=;
        b=grGJrcdjdzTLV145+gy97yOuyMrkCicps/E5uWhokuCnNKMVF0/GXOAowL9Rd44kgr
         Jh0hqOkOpS8zjsGlOBqutMgxQ6pEipPIfj+fqYJ2sJBP33vFcvx/NboRxXE+gDQm3vOa
         0FylLXLhd3gsG8dH4Uu/Wly4tXp3GdiMzwS6pPpwOW83T50KD7O1Qj7b5gOuU1k8i5Sf
         arog5C0Ud6jYXNbr46hIrse8zfPVd+E3XpPPPdvh8D++8L/wHByURIGIlc3tbYoaJQpd
         fHcBE7aTL0MtG+OHrrK3vDiDPnj8y79OZNH3haamqB0c9P2bbiuIng41g/6PV44cXkip
         jcBQ==
X-Gm-Message-State: AOJu0YxMP2Y4X+sRHOWnDNDDqz0wbEpXm5zOZLu7cjvRIKGwz0zKkGx5
	Ff1ZeBKDyqSpz/LGJFECBaxaMk14vZZb3HqlY3lBfyt7g4LHMQjuqBgWyg==
X-Gm-Gg: ASbGnctVfbB+LM4BZ611iwahzYsxhoVNSqrwiHH7sc9xe4v5EVpcSpFgkVQsfUE2lHG
	l4gY+putXC/suLp8+e47fB19NSys7W9rhgJxqw8t+PSueb7tyv7MEYQwjVQW5HeQCLoF+K/GNlz
	TfFzhFB+qwwtLGHDS3LhCNBVlqAm0/IYWFFqStRhRSpcf0EX9/yQhU7nKXIXl7Cnq7IDTg7wVom
	7RTryf48QFaWHevAbzZyxbVJTamWAi4LQUiRVLgNcDU9DPuTaE57R08+tB5q3mKVjh5e0YepT/C
	K6J9PU8Y6Qg+vk1pklRObEpoWrJSF1efLvoVY9B1nfZFFUnTmAU=
X-Google-Smtp-Source: AGHT+IF9m825J7//6TPNUna/HRSCeCiAi6+AO/YL1+i7Q7NyI1KcIjefYon6aEWDK5Ol0r2kE28VaQ==
X-Received: by 2002:a17:907:1b09:b0:aca:f87d:126b with SMTP id a640c23a62f3a-acee241e3c9mr346149266b.35.1746030540642;
        Wed, 30 Apr 2025 09:29:00 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1ac8sm933484166b.182.2025.04.30.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:29:00 -0700 (PDT)
Date: Wed, 30 Apr 2025 16:33:46 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next] bpf: fix uninitialized values in
 BPF_{CORE,PROBE}_READ
Message-ID: <aBJQ6lsZfg8xlM5e@mail.gmail.com>
References: <20250429142241.1943022-1-a.s.protopopov@gmail.com>
 <CAEf4BzYeKLgqn+yq3Mt+Vv-9t6qmzQqimb31zD=y-Cw474LU5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYeKLgqn+yq3Mt+Vv-9t6qmzQqimb31zD=y-Cw474LU5w@mail.gmail.com>

On 25/04/30 09:00AM, Andrii Nakryiko wrote:
> On Tue, Apr 29, 2025 at 7:19 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > With the latest LLVM bpf selftests build will fail with
> > the following error message:
> >
> >     progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
> 
> this is BPF-side code, what does C++ have to do with this, I'm confused...

This I am not sure about why exactly, but clang (wihout ++) emits this warning
now (try smth like `clang -c -x c - <<<'void foo(void) {const int x;}'`).
When sending patch, I though that CORE* macros also can be used by ++ progs.
For C, maybe, this is a problem with clang that it enables -Wdefault-const-init-unsafe?

> 
> Also, why using __u8[] is suddenly ok, and using the actual type
> isn't? Eventually it all is initialized by bpf_probe_read_kernel(), so
> compiler is wrong or I am misunderstanding something... Can you please
> help me understand this?

So, when a const sneaks in, one have BPF_CORE_READ expanded into
say smth like this:

    ({
    typeof(((parent_task)->real_cred->uid.val)) __r;
    BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);
    __r;
    })

It happens that real_cred is a pointer to const, so __r becomes const,
and thus the warning (if enabled) is legit.

With __u8 this turns into (let T = typeof(((parent_task)->real_cred->uid.val)))

    ({
    __u8 __r[sizeof(T)];
    BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);
    * (T *) __r;
    })

So here we do not care if T is const or not, as __r is not in any case.


> 
> >       710 |         proc_exec_data->parent_uid = BPF_CORE_READ(parent_task, real_cred, uid.val);
> >           |                                      ^
> >     tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:520:35: note: expanded from macro 'BPF_CORE_READ'
> >       520 |         ___type((src), a, ##__VA_ARGS__) __r;                               \
> >           |                                          ^
> >
> > Fix this by declaring __r to be an array of __u8 of a proper size.
> >
> > Fixes: 792001f4f7aa ("libbpf: Add user-space variants of BPF_CORE_READ() family of macros")
> > Fixes: a4b09a9ef945 ("libbpf: Add non-CO-RE variants of BPF_CORE_READ() macro family")
> > Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> > ---
> >  tools/lib/bpf/bpf_core_read.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/tools/lib/bpf/bpf_core_read.h b/tools/lib/bpf/bpf_core_read.h
> > index c0e13cdf9660..b7395b75658c 100644
> > --- a/tools/lib/bpf/bpf_core_read.h
> > +++ b/tools/lib/bpf/bpf_core_read.h
> > @@ -517,9 +517,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
> >   * than enough for any practical purpose.
> >   */
> >  #define BPF_CORE_READ(src, a, ...) ({                                      \
> > -       ___type((src), a, ##__VA_ARGS__) __r;                               \
> > +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];                 \
> >         BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);                  \
> > -       __r;                                                                \
> > +       *(___type((src), a, ##__VA_ARGS__) *)__r;                           \
> >  })
> >
> >  /*
> > @@ -533,16 +533,16 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
> >   * input argument.
> >   */
> >  #define BPF_CORE_READ_USER(src, a, ...) ({                                 \
> > -       ___type((src), a, ##__VA_ARGS__) __r;                               \
> > +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];                 \
> >         BPF_CORE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);             \
> > -       __r;                                                                \
> > +       *(___type((src), a, ##__VA_ARGS__) *)__r;                           \
> >  })
> >
> >  /* Non-CO-RE variant of BPF_CORE_READ() */
> >  #define BPF_PROBE_READ(src, a, ...) ({                                     \
> > -       ___type((src), a, ##__VA_ARGS__) __r;                               \
> > +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];                 \
> >         BPF_PROBE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);                 \
> > -       __r;                                                                \
> > +       *(___type((src), a, ##__VA_ARGS__) *)__r;                           \
> >  })
> >
> >  /*
> > @@ -552,9 +552,9 @@ extern void *bpf_rdonly_cast(const void *obj, __u32 btf_id) __ksym __weak;
> >   * not restricted to kernel types only.
> >   */
> >  #define BPF_PROBE_READ_USER(src, a, ...) ({                                \
> > -       ___type((src), a, ##__VA_ARGS__) __r;                               \
> > +       __u8 __r[sizeof(___type((src), a, ##__VA_ARGS__))];                 \
> >         BPF_PROBE_READ_USER_INTO(&__r, (src), a, ##__VA_ARGS__);            \
> > -       __r;                                                                \
> > +       *(___type((src), a, ##__VA_ARGS__) *)__r;                           \
> >  })
> >
> >  #endif
> > --
> > 2.34.1
> >
> >

