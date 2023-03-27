Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C706CA4F5
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjC0M5O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjC0M5A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 08:57:00 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8805FF1;
        Mon, 27 Mar 2023 05:56:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so8689860pjl.4;
        Mon, 27 Mar 2023 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679921754;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Gt4sIiE2ZIA0KoKWm+GbfRz2zhxDQOAdHtwhP1JLts=;
        b=c/KYOFoR5bj0Xe6bCi1N3eCJpQzixEVuDPQSY77m5DPff6Je44/yuAiEjUALYY9mBK
         KpF++1ip+9j5B0rfx5u86Vhrfthy2XxQWVrR2mXk81NooG/oG3YemHy3eemtFge7r+DE
         DA/vvd0OH5TM4UwEbmGq6TcN1MNFF0icD6qTjKuNrrTsHEm3p8z07WihDZNzC6SwMEd3
         1wuvtjv1Px8wc8pElsvEwt7ANTzl9tpVkXz7pAQC3tY44Oq09bN3/5mFTh+wXO00TCKR
         xv3e0OT0P4hm5okBkr6f2hKUacFpOx39LEiJQdpJbVUjeQ2vUP+HYbdajL7lGExz4dlS
         mNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921754;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Gt4sIiE2ZIA0KoKWm+GbfRz2zhxDQOAdHtwhP1JLts=;
        b=Ggbs87aFEAcCZ7HgiLu9ByXmukO8nbVNRblLz5ROEVresW595j3cLrj8VvQ9toGYbI
         MkNXYqKHbo1F/sRZOZdlH15WV2TouraIwOCJAKsSnbfOG4KmRKDcULOXbVof+Q5cccxh
         raJFUyBn6iCfL6ViYTsU6vNiTK9fpeSWjGRbjIqrN8IvkTPU8sFc2ujthVtV2CjVkyB0
         CcnjNl+wBopCquqI47/qOOA1dzsZ2WUfkrH2+WUhHQfAwZcNUuCvttQt3vUTqjKRkwaw
         SiyTx7wY2uo7/BGQciQhc+tspKv9Od+J/BaDH8mmA3ltXvGeLGEtRxR66/Al2USq2Gy5
         Y58w==
X-Gm-Message-State: AO0yUKVl8lZ34ZGQQobAEadArBUMQpHUYP6pE/ki7A+5X4HmrA3jUned
        BZowVmlyWr3B9W/YGn5P7pBB1wOjVmk=
X-Google-Smtp-Source: AK7set/zuRoBFjSuzJBWzE63SZogi3kOt30bPGd7+3Wt0SnGwo1iC1bH+o8vNsjcdsOUAkK5/0xJAA==
X-Received: by 2002:a05:6a20:b062:b0:d5:213a:476e with SMTP id dx34-20020a056a20b06200b000d5213a476emr9530788pzb.51.1679921753698;
        Mon, 27 Mar 2023 05:55:53 -0700 (PDT)
Received: from [127.0.0.1] (189-94-13-80.3g.claro.net.br. [189.94.13.80])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79217000000b006260645f2a7sm2118032pfo.17.2023.03.27.05.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 05:55:52 -0700 (PDT)
Date:   Mon, 27 Mar 2023 09:55:42 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
CC:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_dwarves_v2_1/5=5D_fprintf=3A_Correct?= =?US-ASCII?Q?_names_for_types_with_btf=5Ftype=5Ftag_attribute?=
User-Agent: K-9 Mail for Android
In-Reply-To: <b89f55694845d9d8784fe02700f184ff1de83e2e.camel@gmail.com>
References: <20230314230417.1507266-1-eddyz87@gmail.com> <20230314230417.1507266-2-eddyz87@gmail.com> <ZCGCBF5iYxCtBQKh@kernel.org> <b89f55694845d9d8784fe02700f184ff1de83e2e.camel@gmail.com>
Message-ID: <E7B5E1F3-4BB6-48F2-B424-AAA1F236AA01@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On March 27, 2023 9:10:22 AM GMT-03:00, Eduard Zingerman <eddyz87@gmail=2E=
com> wrote:
>On Mon, 2023-03-27 at 08:46 -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Mar 15, 2023 at 01:04:13AM +0200, Eduard Zingerman escreveu:
>> > The following example contains a structure field annotated with
>> > btf_type_tag attribute:
>> >=20
>> >     #define __tag1 __attribute__((btf_type_tag("tag1")))
>> >=20
>> >     struct st {
>> >       int __tag1 *a;
>> >     } g;
>> >=20
>> > It is not printed correctly by `pahole -F dwarf` command:
>> >=20
>> >     $ clang -g -c test=2Ec -o test=2Eo
>> >     pahole -F dwarf test=2Eo
>> >     struct st {
>> >     	tag1 *                     a;                    /*     0     8 =
*/
>> >     	=2E=2E=2E
>> >     };
>> >=20
>> > Note the type for variable `a`: `tag1` is printed instead of `int`=2E
>> > This commit teaches `type__fprintf()` and `__tag_name()` logic to ski=
p
>> > `DW_TAG_LLVM_annotation` objects that are used to encode type tags=2E
>>=20
>> I'm applying this now to make progress on this front, but longer term w=
e
>> should printf it too, as we want the output to match the original sourc=
e
>> code as much as possible from the type information=2E
>
>Understood, thank you=2E
>
>Also, I want to give a heads-up about ongoing discussion in:
>https://reviews=2Ellvm=2Eorg/D143967
>
>The gist of the discussion is that for the code like:
>
>  volatile __tag("foo") int;
> =20
>Kernel expects BTF to be:
>
>  __tag("foo") -> volatile -> int
> =20
>And I encode it in DWARF as:
>
>  volatile       -> int
>    __tag("foo")
>   =20
>But GCC guys argue that DWARF should be like this:
>
>  volatile       -> int
>                      __tag("foo")
>
>So, to get the BTF to a form acceptable for kernel some additional
>pahole modifications might be necessary=2E (I will work on a prototype
>for such modifications this week)=2E
>
>Maybe put this patch-set on-hold until that is resolved?

Ok, will read the discussion and wait,

- Arnaldo=20
>
>Thanks,
>Eduard
>
>>=20
>> - Arnaldo
>> =20
>> > Signed-off-by: Eduard Zingerman <eddyz87@gmail=2Ecom>
>> > ---
>> >  dwarves_fprintf=2Ec | 13 +++++++++++++
>> >  1 file changed, 13 insertions(+)
>> >=20
>> > diff --git a/dwarves_fprintf=2Ec b/dwarves_fprintf=2Ec
>> > index e8399e7=2E=2E1e6147a 100644
>> > --- a/dwarves_fprintf=2Ec
>> > +++ b/dwarves_fprintf=2Ec
>> > @@ -572,6 +572,7 @@ static const char *__tag__name(const struct tag *=
tag, const struct cu *cu,
>> >  	case DW_TAG_restrict_type:
>> >  	case DW_TAG_atomic_type:
>> >  	case DW_TAG_unspecified_type:
>> > +	case DW_TAG_LLVM_annotation:
>> >  		type =3D cu__type(cu, tag->type);
>> >  		if (type =3D=3D NULL && tag->type !=3D 0)
>> >  			tag__id_not_found_snprintf(bf, len, tag->type);
>> > @@ -786,6 +787,10 @@ next_type:
>> >  			n =3D tag__has_type_loop(type, ptype, NULL, 0, fp);
>> >  			if (n)
>> >  				return printed + n;
>> > +			if (ptype->tag =3D=3D DW_TAG_LLVM_annotation) {
>> > +				type =3D ptype;
>> > +				goto next_type;
>> > +			}
>> >  			if (ptype->tag =3D=3D DW_TAG_subroutine_type) {
>> >  				printed +=3D ftype__fprintf(tag__ftype(ptype),
>> >  							  cu, name, 0, 1,
>> > @@ -880,6 +885,14 @@ print_modifier: {
>> >  		else
>> >  			printed +=3D enumeration__fprintf(type, &tconf, fp);
>> >  		break;
>> > +	case DW_TAG_LLVM_annotation: {
>> > +		struct tag *ttype =3D cu__type(cu, type->type);
>> > +		if (ttype) {
>> > +			type =3D ttype;
>> > +			goto next_type;
>> > +		}
>> > +		goto out_type_not_found;
>> > +	}
>> >  	}
>> >  out:
>> >  	if (type_expanded)
>> > --=20
>> > 2=2E39=2E1
>> >=20
>>=20
>
