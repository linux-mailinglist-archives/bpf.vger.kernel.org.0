Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164C6CC1BE
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 16:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjC1OLo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC1OLn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 10:11:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFE6D31F;
        Tue, 28 Mar 2023 07:10:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y4so50353507edo.2;
        Tue, 28 Mar 2023 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxjxIn6uTGCid5Tn6gTErmlOp11kE1tyo4BMGqcacrk=;
        b=i+2XwD5LYMIBoslfhXQbrqyyN0vqQ5h1khRv1thI8i/Isv96t95v3Y2060d6bbTQjp
         2q8F6kDLtET3igjgJTtHRebW897OCZMjP+iMwUEc7TJgp0VafM6ihYE9FL2DMljsxsT0
         XLHxkr53vZsFVxSA7Szwc9xVVtcBinvzIUThKh6hqkND0+pzYgU60rqx8yyJk+/t3Yke
         AvXcuzfvygjgtpW4lU9HpNTvfPiijHnUAj7VBGgvFCJArFZiIeeCw1R/Th5UDYUatPFF
         XuJxvH9EF09nWDT8dWbhTRIEqz0BmCYPaMjlegPpaUmvacDEMbL5LemlnSp2M1N0XM39
         ZwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012531;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JxjxIn6uTGCid5Tn6gTErmlOp11kE1tyo4BMGqcacrk=;
        b=onrlnjp8O30gFMxQTkfxvMBZhG5lFWMwnTDz3csvrhlJ6LjekLUBT3ulX1/EHYtyTA
         kB4vxcPi4wyM6oVFXn7M5U4MlY4r22F+yzSiNZOpTYicoZ3To0uaiecM5JqH+wSK/imE
         7Pm4dos8hyVdwPYpoqVr2MzS4KV8K3b9NPw1BGrvsziKZmYgtdF1P2o4i+w3fHWFEDoa
         FEzGKn5jR3ewica00OnUOA000Do58BszHdsZ4V164HIsRJwSY3C2YIbrLXUeas7NYmlq
         rJ+PLqKr+t2iP80x2bGhPDGtj2v9o+9R0NO2gJ1McsXeuS8Z1q8TSRZAWTqqxxdp3390
         F61g==
X-Gm-Message-State: AAQBX9f+yQr+tjsVYu3tCHmPPzl7opACBTMNuaN74TMsjq1hErc+j4yB
        dbuOonwlmtQ5Yy7Sd4jQzMk=
X-Google-Smtp-Source: AKy350aTBndb7keVeOJzuElxeuH3lp9ccjiRMl0tvR1wc4OcRNEcGBZANwIo2dCWjdPrgD3sNT2Hlw==
X-Received: by 2002:a17:906:cb87:b0:931:8ad4:a586 with SMTP id mf7-20020a170906cb8700b009318ad4a586mr16138861ejb.30.1680012530977;
        Tue, 28 Mar 2023 07:08:50 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z8-20020a17090655c800b00930569e6910sm15556587ejp.16.2023.03.28.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:08:50 -0700 (PDT)
Message-ID: <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Date:   Tue, 28 Mar 2023 17:08:48 +0300
In-Reply-To: <ZCLy0hjyR3KuYy3e@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
         <20230314230417.1507266-2-eddyz87@gmail.com> <ZCLy0hjyR3KuYy3e@kernel.org>
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

On Tue, 2023-03-28 at 10:59 -0300, Arnaldo Carvalho de Melo wrote:
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
> I noticed this:
>=20
> =E2=AC=A2[acme@toolbox pahole]$ pahole --sort -F btf ../vmlinux-clang-pah=
ole-1.25+rust > /tmp/clang
> =E2=AC=A2[acme@toolbox pahole]$ pahole --sort -F btf ../vmlinux-gcc-pahol=
e-1.25+rust > /tmp/gcc
>=20
>=20
> --- /tmp/gcc    2023-03-28 10:55:37.075999474 -0300
> +++ /tmp/clang  2023-03-28 10:55:53.324436319 -0300
> @@ -70,21 +70,21 @@
>  struct Qdisc {
>         int                        (*enqueue)(struct sk_buff *, struct Qd=
isc *, struct sk_buff * *); /*     0     8 */
>         struct sk_buff *           (*dequeue)(struct Qdisc *); /*     8  =
   8 */
>         unsigned int               flags;                /*    16     4 *=
/
>         u32                        limit;                /*    20     4 *=
/
>         const struct Qdisc_ops  *  ops;                  /*    24     8 *=
/
> -       struct qdisc_size_table *  stab;                 /*    32     8 *=
/
> +       struct qdisc_size_table    stab;                 /*    32     8 *=
/
>         struct hlist_node          hash;                 /*    40    16 *=
/
>         u32                        handle;               /*    56     4 *=
/
>         u32                        parent;               /*    60     4 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         struct netdev_queue *      dev_queue;            /*    64     8 *=
/
> -       struct net_rate_estimator * rate_est;            /*    72     8 *=
/
> -       struct gnet_stats_basic_sync * cpu_bstats;       /*    80     8 *=
/
> -       struct gnet_stats_queue *  cpu_qstats;           /*    88     8 *=
/
> +       struct net_rate_estimator  rate_est;             /*    72     8 *=
/
> +       struct gnet_stats_basic_sync cpu_bstats;         /*    80     8 *=
/
> +       struct gnet_stats_queue    cpu_qstats;           /*    88     8 *=
/
>         int                        pad;                  /*    96     4 *=
/
>         refcount_t                 refcnt;               /*   100     4 *=
/
>=20
>         /* XXX 24 bytes hole, try to pack */
>=20
>         /* --- cacheline 2 boundary (128 bytes) --- */
>=20
> And:
>=20
> struct Qdisc {
>         int                     (*enqueue)(struct sk_buff *skb,
>                                            struct Qdisc *sch,
>                                            struct sk_buff **to_free);
>         struct sk_buff *        (*dequeue)(struct Qdisc *sch);
>         unsigned int            flags;
> #define TCQ_F_BUILTIN           1
> #define TCQ_F_INGRESS           2
> #define TCQ_F_CAN_BYPASS        4
> #define TCQ_F_MQROOT            8
> #define TCQ_F_ONETXQUEUE        0x10 /* dequeue_skb() can assume all skbs=
 are for
>                                       * q->dev_queue : It can test
>                                       * netif_xmit_frozen_or_stopped() be=
fore
>                                       * dequeueing next packet.
>                                       * Its true for MQ/MQPRIO slaves, or=
 non
>                                       * multiqueue device.
>                                       */
> #define TCQ_F_WARN_NONWC        (1 << 16)
> #define TCQ_F_CPUSTATS          0x20 /* run using percpu statistics */
> #define TCQ_F_NOPARENT          0x40 /* root of its hierarchy :
>                                       * qdisc_tree_decrease_qlen() should=
 stop.
>                                       */
> #define TCQ_F_INVISIBLE         0x80 /* invisible by default in dump */
> #define TCQ_F_NOLOCK            0x100 /* qdisc does not require locking *=
/
> #define TCQ_F_OFFLOADED         0x200 /* qdisc is offloaded to HW */
>         u32                     limit;
>         const struct Qdisc_ops  *ops;
>         struct qdisc_size_table __rcu *stab;
>         struct hlist_node       hash;
>         u32                     handle;
>         u32                     parent;
>=20
>         struct netdev_queue     *dev_queue;
>=20
>         struct net_rate_estimator __rcu *rate_est;
>         struct gnet_stats_basic_sync __percpu *cpu_bstats;
>         struct gnet_stats_queue __percpu *cpu_qstats;
>         int                     pad;
>         refcount_t              refcnt;
>=20
>=20
> I'll try to fix now.

Ouch. The fields are annotated with type tags, which are ignored by gcc.
If this is not urgent I can debug it either later today or tomorrow.

>=20
> - Arnaldo
>=20
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

