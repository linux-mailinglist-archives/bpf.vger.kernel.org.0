Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EF96CA317
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 14:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjC0MK3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 08:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjC0MK2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 08:10:28 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498AA3C02;
        Mon, 27 Mar 2023 05:10:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w9so35269232edc.3;
        Mon, 27 Mar 2023 05:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679919025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zdEcknTjVlOAUWG2/pxtwD5kVct11OQN0Q11qC+vEis=;
        b=jXK3Xy2SnRtsiz3RtD4kVBXdEoBr1/6GQM1xQz824fB0dqlRzX+l+QQpqZII3IAJpI
         ABJTgIVCk7ytmZo82QGjIMpqIhpnC2ylISfuXWwVpwRugtA1NnhDMYbFv7FyzW10XHEX
         cNDhTK1hVQkEggOTIWI5NHmiEVaGFW1Ci13qAjaA5I9Npk8qskSP8ybyHIjFZXDV23Ia
         nuw7P8pWYjbv0xVLxG+VLj3MltKrvIIEjVnD0CVJSE8aaYE4So9YI4aDV6B+kIwQGNvr
         Q5Oj/LLpuwiuv9ajJgFSlH89T1ibFRAjv+XEQOSaPKqox2W+aawBa3IAq3/DxLE0U0sz
         kgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919025;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdEcknTjVlOAUWG2/pxtwD5kVct11OQN0Q11qC+vEis=;
        b=V8RibKTYCLqMXXhoTL6juw4BEEep66aquhqoY//jHqjmEDZpILv605+BwyH+ghpFaX
         nauHa/fqcaPbumI1vhX4+/FVUfyhvchN+lRpzpxvITIpC5rHZnkzHMMzDKGtkfnfM96O
         fLE1QXDy3wETW1iqngKUEViKJ9Zby1wy4QxdAByeICprRLgjByBSBDmeImo026z+3z9N
         B11Lf+Ro7OY+u/DTm544D9sBgCnxtYLBBHREj31beB3dYlj5W8/NuDQ4ncdRTf5R/gko
         Q26nOoc1bjrcxUE352tExr92b3Xe+yNC4SSXbBCjt/Ap8AxEv9XaJbuuXag7xJwJPqRr
         BREA==
X-Gm-Message-State: AAQBX9eHdvNNyMUCfqPKnCuhJ9xdisoU+ArEU9xPrO7abvIIml1M6iRQ
        pthy79lQGAQzIYCdZ+Ac48ybqowDQQcFAQ==
X-Google-Smtp-Source: AKy350an/3oDLuSfmCtOhAdO38UfhKPbVnj+RYj7s7Zp+L550NKredrZpWNegT8IuEkg64sPP8R4MQ==
X-Received: by 2002:a17:906:f987:b0:932:177a:12a5 with SMTP id li7-20020a170906f98700b00932177a12a5mr11134146ejb.66.1679919024581;
        Mon, 27 Mar 2023 05:10:24 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b0093048a8bd31sm14003986ejb.68.2023.03.27.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:10:24 -0700 (PDT)
Message-ID: <b89f55694845d9d8784fe02700f184ff1de83e2e.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Date:   Mon, 27 Mar 2023 15:10:22 +0300
In-Reply-To: <ZCGCBF5iYxCtBQKh@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
         <20230314230417.1507266-2-eddyz87@gmail.com> <ZCGCBF5iYxCtBQKh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-03-27 at 08:46 -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 15, 2023 at 01:04:13AM +0200, Eduard Zingerman escreveu:
> > The following example contains a structure field annotated with
> > btf_type_tag attribute:
> >=20
> >     #define __tag1 __attribute__((btf_type_tag("tag1")))
> >=20
> >     struct st {
> >       int __tag1 *a;
> >     } g;
> >=20
> > It is not printed correctly by `pahole -F dwarf` command:
> >=20
> >     $ clang -g -c test.c -o test.o
> >     pahole -F dwarf test.o
> >     struct st {
> >     	tag1 *                     a;                    /*     0     8 */
> >     	...
> >     };
> >=20
> > Note the type for variable `a`: `tag1` is printed instead of `int`.
> > This commit teaches `type__fprintf()` and `__tag_name()` logic to skip
> > `DW_TAG_LLVM_annotation` objects that are used to encode type tags.
>=20
> I'm applying this now to make progress on this front, but longer term we
> should printf it too, as we want the output to match the original source
> code as much as possible from the type information.

Understood, thank you.

Also, I want to give a heads-up about ongoing discussion in:
https://reviews.llvm.org/D143967

The gist of the discussion is that for the code like:

  volatile __tag("foo") int;
 =20
Kernel expects BTF to be:

  __tag("foo") -> volatile -> int
 =20
And I encode it in DWARF as:

  volatile       -> int
    __tag("foo")
   =20
But GCC guys argue that DWARF should be like this:

  volatile       -> int
                      __tag("foo")

So, to get the BTF to a form acceptable for kernel some additional
pahole modifications might be necessary. (I will work on a prototype
for such modifications this week).

Maybe put this patch-set on-hold until that is resolved?

Thanks,
Eduard

>=20
> - Arnaldo
> =20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  dwarves_fprintf.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >=20
> > diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> > index e8399e7..1e6147a 100644
> > --- a/dwarves_fprintf.c
> > +++ b/dwarves_fprintf.c
> > @@ -572,6 +572,7 @@ static const char *__tag__name(const struct tag *ta=
g, const struct cu *cu,
> >  	case DW_TAG_restrict_type:
> >  	case DW_TAG_atomic_type:
> >  	case DW_TAG_unspecified_type:
> > +	case DW_TAG_LLVM_annotation:
> >  		type =3D cu__type(cu, tag->type);
> >  		if (type =3D=3D NULL && tag->type !=3D 0)
> >  			tag__id_not_found_snprintf(bf, len, tag->type);
> > @@ -786,6 +787,10 @@ next_type:
> >  			n =3D tag__has_type_loop(type, ptype, NULL, 0, fp);
> >  			if (n)
> >  				return printed + n;
> > +			if (ptype->tag =3D=3D DW_TAG_LLVM_annotation) {
> > +				type =3D ptype;
> > +				goto next_type;
> > +			}
> >  			if (ptype->tag =3D=3D DW_TAG_subroutine_type) {
> >  				printed +=3D ftype__fprintf(tag__ftype(ptype),
> >  							  cu, name, 0, 1,
> > @@ -880,6 +885,14 @@ print_modifier: {
> >  		else
> >  			printed +=3D enumeration__fprintf(type, &tconf, fp);
> >  		break;
> > +	case DW_TAG_LLVM_annotation: {
> > +		struct tag *ttype =3D cu__type(cu, type->type);
> > +		if (ttype) {
> > +			type =3D ttype;
> > +			goto next_type;
> > +		}
> > +		goto out_type_not_found;
> > +	}
> >  	}
> >  out:
> >  	if (type_expanded)
> > --=20
> > 2.39.1
> >=20
>=20

