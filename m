Return-Path: <bpf+bounces-35663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A858693C942
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 22:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D4E2837EE
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 20:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7803B29D;
	Thu, 25 Jul 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a62BUp6S"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E211711
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937690; cv=none; b=GqQ2TswJQlwesnG9rJIV3PMucvUhGvSpYxEaPySPlu8ZzrZljd/JxWm2UjqoFehg7A4Nb4zUqZDzXr3IavVcO6lHNncVcfD2CXGrzQ94yKAa09kSeevvsH9CovlX2YWhL8JSeWWuOYPBccNSgmJyCKdJ7ZALdo3ESpkzP7BShfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937690; c=relaxed/simple;
	bh=iSEt0vWfYQ6WSuyqYF1/tx12RUndaSZO5HrIeiBgNbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1uZbrJF4SS5fp5/JUKqxmNDqwhDISWDoR77I/pPdmxbVV4i+y8eqOhO8cpj+1kQuWAhmqV5qiXVewYG9SHnjtJkm26L3FHOtKHAVLf4dIvMfE5IO0IYTMWcXboJaoDfHE3T6n9EZ+yOXoz46oSMy9SoF2Fd3ocUG0QA55Oxd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a62BUp6S; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso212272a12.0
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721937688; x=1722542488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6spBI2YWO7TqbtcRd25fAc7U2Mta+DWgPwHb5l+trCo=;
        b=a62BUp6Si3HJi0hrx/FnXE8yNgR6NC/llXLfDVF4nbq9wI3tcoepx57aFeb9YSortp
         LUv3i0lDjZ3zntA1MjRMaa4pYqeGzWOAFOpUFHfgy1ZJoqDDZwZZxAZ7HpZncNOapaOu
         dKuDzPZbokokU+677LliNXZKq7qE/8sVl1S0bVZ2+K1sFoblQ4vNdQWG6tyuHrO5TNbS
         3Rtk/GhjDhdgAcqixIAlzjzNT42o0A7H0fygFBmOwOQfck08lDMxGN1NCgiWIUAQhsST
         kBl3U4bcmcaOmAeUI8UTb9FGCEcBmvOrdOyO7/NYApzZtLL91VKIwNhHbGIQr5wZkxrn
         lwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937688; x=1722542488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6spBI2YWO7TqbtcRd25fAc7U2Mta+DWgPwHb5l+trCo=;
        b=ESDgjQyhFGAsPXm1enTgOZ6Y8zX/9QevUWN/9sGnaOYECK18D25vQt1A4040QXl1Fk
         Rj/Hm6FzZl0VJV8ai5tXhQ1ZWh91TvBEswCnd45v8ZJ00Dbb08FAsDZ+7vzD53z1DjOQ
         Eps21ZSaRIWBK+jZSu3kqXuMUeiZPqW4SNToimZhjMGOWSbRESGOotBsx9Di/gcbaUdV
         BLMaJFl8G9fQHSbjXwEiucReoGwAKm8GfQnTLEDUKZlSbnkVawrPtZ0kwGy0sJeh2E/d
         Jihi9+Pbp0fL+wXpqtAAnZYTMKQ2EUqrDZjyN8Aiij7cxVml+JHSnMgNGYTtKNFxUB1f
         ZtsA==
X-Forwarded-Encrypted: i=1; AJvYcCUVMHAqi8Wtmt1WaSOR6j9IBJaQuZlptfjGGRDDCENbyw6glvx3dQaqF82mIKOkXrLyx7fnGBBtCjRXyv0Q7W+kDw71
X-Gm-Message-State: AOJu0Yw1Vq6E0W4PfZtQ4Y7M5td9KvlEc2ZzGZEVjVqvavd89uDZYilo
	/3eOQfEE5ldXOpb/IUlr+KC7kzrW1B+u63DKjb4KNVhuli/Sjk96LisAH+z99X1IEj0DREZRlCk
	pnEFzv7ANqH+UOqC9T3M1pjf8OCI=
X-Google-Smtp-Source: AGHT+IFpYyTovuLxZV3rzwtXRgatwEk/smG9TLgtC67jebQTe2Ufi1GfpS0PbM3u4zPyiRdn2Dvz5SDA8CZ2Jw38WwY=
X-Received: by 2002:a17:90b:1c07:b0:2c9:7a8d:43f7 with SMTP id
 98e67ed59e1d1-2cf2380a7abmr4578376a91.23.1721937688387; Thu, 25 Jul 2024
 13:01:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724225210.545423-1-andrii@kernel.org> <20240724225210.545423-11-andrii@kernel.org>
 <ZqI_MgOo6Y5mWv0O@krava>
In-Reply-To: <ZqI_MgOo6Y5mWv0O@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 13:01:16 -0700
Message-ID: <CAEf4BzZ6ze_z-DRKu_6t-zJfAHyfMguRiPUhakHnZgvKy26p1w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 10/10] selftests/bpf: add build ID tests
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:04=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, Jul 24, 2024 at 03:52:10PM -0700, Andrii Nakryiko wrote:
>
> SNIP
>
> > +extern char build_id_start[];
> > +extern char build_id_end[];
> > +
> > +int __attribute__((weak)) trigger_uprobe(bool build_id_resident)
> > +{
> > +     int page_sz =3D sysconf(_SC_PAGESIZE);
> > +     void *addr;
> > +
> > +     /* page-align build ID start */
> > +     addr =3D (void *)((uintptr_t)&build_id_start & ~(page_sz - 1));
> > +
> > +     /* to guarantee MADV_PAGEOUT work reliably, we need to ensure tha=
t
> > +      * memory range is mapped into current process, so we uncondition=
ally
> > +      * do MADV_POPULATE_READ, and then MADV_PAGEOUT, if necessary
> > +      */
> > +     madvise(addr, page_sz, MADV_POPULATE_READ);
> > +     if (!build_id_resident)
> > +             madvise(addr, page_sz, MADV_PAGEOUT);
>
> could this fail? should we at least print the error,
> might be tricky to display that becase it's called through system() ?

I don't think it should, given the correct addr and page_sz. If it
fails, then some selftest that relies on it will fail.
I can add printf(), though, and it will be printed in logs, I think.

>
> jirka
>
> > +
> > +     (void)uprobe();
> > +
> > +     return 0;
> > +}
> > +
> >  int main(int argc, char **argv)
> >  {
> >       if (argc !=3D 2)
> > @@ -84,6 +121,10 @@ int main(int argc, char **argv)
> >               return bench();
> >       if (!strcmp("usdt", argv[1]))
> >               return usdt();
> > +     if (!strcmp("uprobe-paged-out", argv[1]))
> > +             return trigger_uprobe(false /* page-out build ID */);
> > +     if (!strcmp("uprobe-paged-in", argv[1]))
> > +             return trigger_uprobe(true /* page-in build ID */);
> >
> >  error:
> >       fprintf(stderr, "usage: %s <bench|usdt>\n", argv[0]);
> > diff --git a/tools/testing/selftests/bpf/uprobe_multi.ld b/tools/testin=
g/selftests/bpf/uprobe_multi.ld
> > new file mode 100644
> > index 000000000000..a2e94828bc8c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/uprobe_multi.ld
> > @@ -0,0 +1,11 @@
> > +SECTIONS
> > +{
> > +     . =3D ALIGN(4096);
> > +     .note.gnu.build-id : { *(.note.gnu.build-id) }
> > +     . =3D ALIGN(4096);
> > +}
> > +INSERT AFTER .text;
> > +
> > +build_id_start =3D ADDR(.note.gnu.build-id);
> > +build_id_end =3D ADDR(.note.gnu.build-id) + SIZEOF(.note.gnu.build-id)=
;
> > +
> > --
> > 2.43.0
> >
> >

