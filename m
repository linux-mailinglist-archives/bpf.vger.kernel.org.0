Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE1D624FED
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 02:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbiKKBvn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 20:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiKKBvl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 20:51:41 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E085E1C116
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:51:39 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m22so9449180eji.10
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jSFB9XIYRL/EjeiMMor3CYqYpzEkmeCNez1czWffHOo=;
        b=dT/OdC0+2n8VzOgTg7g/yeGKisUmqPKefjLGGzWHElcWLEa1lh+t4Vq+pz8CWH3l6c
         81kniH28Iq7f2GK/7ypFVaBFcuCEeDnLi2d5ga8zpvBtXpKMMqM7L6o3qJ5uR1JdCrY2
         9+sGzZAWadAnQ97TZ2D1W82vtzvvQRDDZfQIoapajlMj4KCSJrS12AvF6lkA9LPbtmON
         S9I3v7+srvU0csMUHJpODYfIQ1X2WmwOGgUIzQZ10dt++HhCtyi6xegqqq60G+pzLHQD
         e1J2oBSl87AMiruTRNsblXWCY7FaVDAxyRt19jvV7jymlqBWbluS5S7YCu7OPvq8uvc+
         Q2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSFB9XIYRL/EjeiMMor3CYqYpzEkmeCNez1czWffHOo=;
        b=6CGVdF3B7nxjIGerhULx4WnlNmf61Zx98+Kd9PM1i9p+LvE3NndjL/OGYuR+duTk04
         76fyycZVVnS+FgZvSDnl4bM0RqS/mTdxF1m04uLLrddEEaN1t2hu2nZ+7rFUQThcWGXx
         4DG8/aAm6Dw7mt9yp3efEfy/iVSU7+trZzreJfOn3/QcFAW0qcxxOHmR745o11gNB6VC
         Gz62VtcIzB5Y9x5lRMcEHAsxkkNlbgOl3NJFA0nwd1tmYyl8suV1H96FXZjcYnKksmJZ
         XmkgjucugHN/CjZHuha8D6bYZuHytjW1MDnp2wsqzbSihaku5yExoeyDkouwXU/+re7F
         9F4g==
X-Gm-Message-State: ANoB5plFDkdi7t7bmnbO1nPx+uJANXnnpPY0FWEijzXyvmezqrp/S5lL
        jctxZFnAWEYuUmPdjPBrP/M=
X-Google-Smtp-Source: AA0mqf7v0Qdiz5OOWXwksmHsR6sRFa48FCrjg695a+fgzTznF7vyMAk4mybhdpnjohJ6bUTySkzWGw==
X-Received: by 2002:a17:906:24d9:b0:7ad:2da5:36e1 with SMTP id f25-20020a17090624d900b007ad2da536e1mr178160ejb.548.1668131498388;
        Thu, 10 Nov 2022 17:51:38 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b00459f4974128sm493837edv.50.2022.11.10.17.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 17:51:37 -0800 (PST)
Message-ID: <70af3b3e39ad7744b454f13bb713f6d03eb92e99.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: hashmap.h update to fix build issues
 using LLVM14
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        kernel test robot <lkp@intel.com>
Date:   Fri, 11 Nov 2022 03:51:36 +0200
In-Reply-To: <Y22mtIyofEus4KZ0@google.com>
References: <20221110223240.1350810-1-eddyz87@gmail.com>
         <Y22khvpDYu639yom@google.com> <Y22mtIyofEus4KZ0@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2022-11-10 at 17:34 -0800, sdf@google.com wrote:
> On 11/10, Stanislav Fomichev wrote:
> > On 11/11, Eduard Zingerman wrote:
> > > A fix for the LLVM compilation error while building bpftool.
> > > Replaces the expression:
> > >=20
> > >   _Static_assert((p) =3D=3D NULL || ...)
> > >=20
> > > by expression:
> > >=20
> > >   _Static_assert((__builtin_constant_p((p)) ? (p) =3D=3D NULL : 0) ||=
 ...)
>=20
> > IIUC, when __builtin_constant_p(p) returns false, we just ignore the NU=
LL =20
> > check?
> > Do we have cases like that? If no, maybe it's safer to fail?
>=20
> > s/(p) =3D=3D NULL : 0/(p) =3D=3D NULL : 1/ ?
>=20
> I'm probably missing something, can you pls clarify? So the error is as
> follows:
>=20
> > > btf_dump.c:1546:2: error: static_assert expression is not an integral=
 =20
> > > constant expression
>     hashmap__find(name_map, orig_name, &dup_cnt);
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ./hashmap.h:169:35: note: expanded from macro 'hashmap__find'
>     hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
>     ^~~~~~~~~~~~~~~~~~~~~~~
>     ./hashmap.h:126:17: note: expanded from macro 'hashmap_cast_ptr'
>     _Static_assert((p) =3D=3D NULL || sizeof(*(p)) =3D=3D =20
> sizeof(long),                                            =20
> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     btf_dump.c:1546:2: note: cast from 'void *' is not allowed in a const=
ant =20
> expression
>     ./hashmap.h:169:35: note: expanded from macro 'hashmap__find'
>     hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
>=20
> This line in particular:
>=20
>     btf_dump.c:1546:2: note: cast from 'void *' is not allowed in a const=
ant =20
> expression
>=20
> And the code does:
>=20
>    size_t dup_cnt =3D 0;
>    hashmap__find(name_map, orig_name, &dup_cnt);
>=20
> So where is that cast from 'void *' is happening? Is it the NULL check =
=20
> itself?

The void * comes from the definition of NULL: ((void*)0).
And, unfortunately, sizeoof(*((void*)0)) =3D=3D 1, so two conditions
are necessary to allow a typical use-case when some of the pointer
parameters are omitted.

>=20
> Are we simply guarding against the user calling hashmap_cast_ptr with
> explicit NULL argument?
>=20
> > > When "p" is not a constant the former is not considered to be a
> > > constant expression by LLVM 14.
> > >=20
> > > The error was introduced in the following patch-set: [1].
> > > The error was reported here: [2].
> > >=20
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > >=20
> > > [1] =20
> > https://lore.kernel.org/bpf/20221109142611.879983-1-eddyz87@gmail.com/
> > > [2] https://lore.kernel.org/all/202211110355.BcGcbZxP-lkp@intel.com/
> > > ---
> > >  tools/lib/bpf/hashmap.h   | 3 ++-
> > >  tools/perf/util/hashmap.h | 3 ++-
> > >  2 files changed, 4 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
> > > index 3fe647477bad..0a5bf1937a7c 100644
> > > --- a/tools/lib/bpf/hashmap.h
> > > +++ b/tools/lib/bpf/hashmap.h
> > > @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
> > >  };
> > >=20
> > >  #define hashmap_cast_ptr(p) ({								\
> > > -	_Static_assert((p) =3D=3D NULL || sizeof(*(p)) =3D=3D sizeof(long),=
			\
> > > +	_Static_assert((__builtin_constant_p((p)) ? (p) =3D=3D NULL : 0) ||=
			\
> > > +				sizeof(*(p)) =3D=3D sizeof(long),				\
> > >  		       #p " pointee should be a long-sized integer or a pointer");=
	\
> > >  	(long *)(p);									\
> > >  })
> > > diff --git a/tools/perf/util/hashmap.h b/tools/perf/util/hashmap.h
> > > index 3fe647477bad..0a5bf1937a7c 100644
> > > --- a/tools/perf/util/hashmap.h
> > > +++ b/tools/perf/util/hashmap.h
> > > @@ -123,7 +123,8 @@ enum hashmap_insert_strategy {
> > >  };
> > >=20
> > >  #define hashmap_cast_ptr(p) ({								\
> > > -	_Static_assert((p) =3D=3D NULL || sizeof(*(p)) =3D=3D sizeof(long),=
			\
> > > +	_Static_assert((__builtin_constant_p((p)) ? (p) =3D=3D NULL : 0) ||=
			\
> > > +				sizeof(*(p)) =3D=3D sizeof(long),				\
> > >  		       #p " pointee should be a long-sized integer or a pointer");=
	\
> > >  	(long *)(p);									\
> > >  })
> > > --
> > > 2.34.1
> > >=20

