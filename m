Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5A8624FDA
	for <lists+bpf@lfdr.de>; Fri, 11 Nov 2022 02:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiKKBow (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 20:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiKKBof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 20:44:35 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E37EA454
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:44:34 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ud5so9505035ejc.4
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 17:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vb6InLIzUA6RK+PTNqGGQ9GHyZhzWb6UW9CTQHLaSRU=;
        b=Qyajb8+XfDymdioLUaCeb+5PeAduTZPebVGjbbQe3jqi7npkda2CyGCEqQ/hj/bXr6
         guyAJr1UQf+eKLfbnBbgwV4lFer69m9FI+QzvF1eRBCkCqi50qbAgLFD+VmHKJCA4KDq
         DKn+3MrS43QKWpkpY4Qej7r27UmgIpBe1BY4PqpjqO/rRmCW0N3qUosNKGTNgaEVZw2f
         IB+TiMXHGWN0Lp+veVLoYymVxRkokAQYEHcaAaOe03I0M/JCMRTxAuBtxFqTokWy9Ih3
         gyGkjK0xLbOaOuBVzNwQlbHyq1m2UX/lX39XtElGC5HYk6mF0Hm6hYReIIQUiYAUEoCN
         q0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vb6InLIzUA6RK+PTNqGGQ9GHyZhzWb6UW9CTQHLaSRU=;
        b=zuM3XHP3T/J2MkTUH4knsKMI/ZI6WfCpSzk9aEZJ9Zj59D3hros1ncv/yxTEg0E8dg
         x9ZLjCbmFOP58oeCOChg25IS57EWkpLg5mlajiSDuvMOJFeAV+21NJpLB1+J7b6EFLJS
         1KqZonn/APbIbE54n5OkPkxLVtmuWTjVWZPzu2dNKXnxFhiPMAJL/votXUsogBVMlNAH
         21tOAxmT/aX5fkVdRw79rl1CkM1laK6D+YMvmsyCaYAgDaqjWFyoOwoLyTS3k2A+A/zq
         NtiUC5O/mvBIWMJDDP2wxmIUIhYmZJWKs7Wd8oWNCi56SC56GFjomuPS21vAdlZoWwSz
         irVA==
X-Gm-Message-State: ANoB5plk+t8M7OHnnL1p61qxF4OnxTpyQ1mur9K1Gyq+CsRrOUDaSwMv
        pcHPqLmDitD/qQV7AWJhIeI=
X-Google-Smtp-Source: AA0mqf6msBwhXkiLXT0MlpWCJNzJO0+im/PWJHkmrIx7iuMdzHhh6JayCV8kElQnUrcn1G3flZFiUg==
X-Received: by 2002:a17:906:a095:b0:78d:a334:555f with SMTP id q21-20020a170906a09500b0078da334555fmr221806ejy.243.1668131072639;
        Thu, 10 Nov 2022 17:44:32 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b0078d22b0bcf2sm313686ejb.168.2022.11.10.17.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 17:44:31 -0800 (PST)
Message-ID: <7253d4c4f2ffcd3bff90df8cf8f71af7475167de.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: hashmap.h update to fix build issues
 using LLVM14
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     sdf@google.com
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        kernel test robot <lkp@intel.com>
Date:   Fri, 11 Nov 2022 03:44:30 +0200
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
>=20
> Are we simply guarding against the user calling hashmap_cast_ptr with
> explicit NULL argument?

In case if (p) is not a constant I want the second part of the || to kick-i=
n.
The complete condition looks as follows:

  _Static_assert((__builtin_constant_p((p)) ? (p) =3D=3D NULL : 0) || \
			sizeof(*(p)) =3D=3D sizeof(long), "...error...")

The intent is to check that (p) is either NULL or a pointer to
something of size long. So, if (p) is not a constant the expression
would be equivalent to:

  _Static_assert(0 || sizeof(*(p)) =3D=3D sizeof(long), "...error...")

I just tried the following:

	struct hashmap *name_map;
	char x; // not a constant, wrong pointer size
	...
	hashmap__find(name_map, orig_name, &x);

And it fails with an error message as intended:

btf_dump.c:1548:2: error: static_assert failed due to requirement '(__built=
in_constant_p((&x)) ? (&x) =3D=3D ((void *)0) : 0) || sizeof (*(&x)) =3D=3D=
 sizeof(long)' "&x pointee should be a long-sized integer or a pointer"
        hashmap__find(name_map, orig_name, &x);
./hashmap.h:170:35: note: expanded from macro 'hashmap__find'
        hashmap_find((map), (long)(key), hashmap_cast_ptr(value))
./hashmap.h:126:2: note: expanded from macro 'hashmap_cast_ptr'
        _Static_assert((__builtin_constant_p((p)) ? (p) =3D=3D NULL : 0) ||


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

