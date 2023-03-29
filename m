Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5A6CED1B
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 17:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjC2PhM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 11:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjC2PhC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 11:37:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9876187;
        Wed, 29 Mar 2023 08:36:38 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er13so24014628edb.9;
        Wed, 29 Mar 2023 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680104196; x=1682696196;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KcfyeLkPAysA08Ie1X3d8H/w5HiXpM/sGxEjOMYO/Y8=;
        b=SGehPbVc2uFx6vW1FvGIYSJTVvrc4eX8rAQ+GLtFeQJKN5pBwYvz/mH1+nBETmpRBb
         e6wG3YrgCq1k5/RUbU0rXnICjMdicSIcJWhj4NZwpWIocmSikcv3M5JrLlMIGnBc/zKW
         Bgu0NkQmIb0FXAuuprfZXK62bRY5h6FHODeJ4hWDeU7sXwU0sgXqOeluBPPwbec4UyCK
         mNMoTH9ziHQDwy1bQvGfiXc6SixbmrDIYUtm3v+3b4eJ6uCaJyORAV0awkz4bA6f9Z+h
         EnJTX3FxjtrAtgHhhA7YkLJROeqS+mnDNEG21AOYiYEcgtTNjMjuJJN3+UV673B9K4gk
         OOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104196; x=1682696196;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcfyeLkPAysA08Ie1X3d8H/w5HiXpM/sGxEjOMYO/Y8=;
        b=BPuk3w79n2O714cwrI5o2bJVOwt4Qb2aTIKA3GRqkvfH9DG8hszs4VcFttMRbnRGVh
         gB1QTFdLsEjgScjI6YJAV38ww6m9e9Er4l3nDb1kySWgM6AAROruDk/3qu9+1Sy0LndW
         flj0QiScdFPbxzWIW5RIEG4qjxUnGtIOgNUjw/R54H6Vktw5gr5+s8bhMRPXZj3qOi3G
         TuIE+VYVn/DmOLtVBAsXwhCCL5a94SCxeZgYsjmsP5WjnIjFl3FDdbJmWw6WArJnfl74
         i5nvLXqJawbkuou0zTNYvreZqs8A/Tp6oS9ansZbWMq9JeB33Sw0UAc+Lwyo1PAQ/Xpd
         aJCw==
X-Gm-Message-State: AAQBX9cnGKp60cNbYa5oW0nBvrz80823K6MPMQGbJVxd2jmYbm0RIUDG
        SUJZ0iYO/E8iGOGAojCqnBA=
X-Google-Smtp-Source: AKy350Yp6WikHvwKHEi5T0y14BchdijUUlyJkzuWvA7OSNBbGwNB0SbC5wEzdRK3NFvGWKkqFfBASQ==
X-Received: by 2002:aa7:db94:0:b0:4bb:e80c:5667 with SMTP id u20-20020aa7db94000000b004bbe80c5667mr19914351edt.10.1680104196481;
        Wed, 29 Mar 2023 08:36:36 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id u6-20020a50d506000000b004fd2aab4953sm17206673edi.45.2023.03.29.08.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:36:35 -0700 (PDT)
Message-ID: <fabfc71fd43be48f68019c911c6a3af1412f4635.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Date:   Wed, 29 Mar 2023 18:36:34 +0300
In-Reply-To: <ZCNZcl1mkC9yhwDD@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
         <20230314230417.1507266-2-eddyz87@gmail.com> <ZCLy0hjyR3KuYy3e@kernel.org>
         <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
         <ZCMHKFdmjVpOSNsJ@kernel.org>
         <50a160d802ad3f84e91cf05c8f541e0c2e388fc8.camel@gmail.com>
         <ZCNZcl1mkC9yhwDD@kernel.org>
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

On Tue, 2023-03-28 at 18:17 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 28, 2023 at 06:30:05PM +0300, Eduard Zingerman escreveu:
> > On Tue, 2023-03-28 at 12:26 -0300, Arnaldo Carvalho de Melo wrote:
> > [...]=20
> > > Sure, but look:
> > >=20
> > > > > -       struct qdisc_size_table *  stab;                 /*    32=
     8 */
> > > > > +       struct qdisc_size_table    stab;                 /*    32=
     8 */
> > >=20
> > > Its the DW_TAG_pointer_type that is getting lost somehow:
> > >=20
> > >  <1><b0af32>: Abbrev Number: 81 (DW_TAG_structure_type)
> > >     <b0af33>   DW_AT_name        : (indirect string, offset: 0xe825):=
 Qdisc
> > >     <b0af37>   DW_AT_byte_size   : 384
> > >     <b0af39>   DW_AT_decl_file   : 223
> > >     <b0af3a>   DW_AT_decl_line   : 72
> > >=20
> > > <SNIP>
> > >=20
> > >  <2><b0af77>: Abbrev Number: 65 (DW_TAG_member)
> > >     <b0af78>   DW_AT_name        : (indirect string, offset: 0x4745ff=
): stab
> > >     <b0af7c>   DW_AT_type        : <0xb0b76b>
> > >     <b0af80>   DW_AT_decl_file   : 223
> > >     <b0af81>   DW_AT_decl_line   : 99
> > >     <b0af82>   DW_AT_data_member_location: 32
> > >=20
> > > <SNIP>
> > >=20
> > > <1><b0b76b>: Abbrev Number: 61 (DW_TAG_pointer_type)
> > >     <b0b76c>   DW_AT_type        : <0xb0b77a>
> > >  <2><b0b770>: Abbrev Number: 62 (User TAG value: 0x6000)
> > >     <b0b771>   DW_AT_name        : (indirect string, offset: 0x378): =
btf_type_tag
> > >     <b0b775>   DW_AT_const_value : (indirect string, offset: 0x6e93):=
 rcu
> > >  <2><b0b779>: Abbrev Number: 0
> > >  <1><b0b77a>: Abbrev Number: 69 (DW_TAG_structure_type)
> > >     <b0b77b>   DW_AT_name        : (indirect string, offset: 0x6e5ed)=
: qdisc_size_table
> > >     <b0b77f>   DW_AT_byte_size   : 64
> > >     <b0b780>   DW_AT_decl_file   : 223
> > >     <b0b781>   DW_AT_decl_line   : 56
> > >=20
> > > =20
> > > So it's all there in the DWARF info:
> > >=20
> > >    b0af77 has type 0xb0b76b which is a DW_TAG_pointer_type that has t=
ype
> > >    0xb0b77a, that is DW_TAG_structure_type.
> > >=20
> > > Now lets see how this was encoded into BTF:
> > >=20
> > > [4725] STRUCT 'Qdisc' size=3D384 vlen=3D28
> > > <SNIP>
> > >         'stab' type_id=3D4790 bits_offset=3D256
> > > <SNIP>
> > > [4790] PTR '(anon)' type_id=3D4789
> > > <SNIP>
> > > [4789] TYPE_TAG 'rcu' type_id=3D4791
> > > <SNIP>
> > > [4791] STRUCT 'qdisc_size_table' size=3D64 vlen=3D5
> > >         'rcu' type_id=3D320 bits_offset=3D0
> > >         'list' type_id=3D87 bits_offset=3D128
> > >         'szopts' type_id=3D4792 bits_offset=3D256
> > >         'refcnt' type_id=3D16 bits_offset=3D448
> > >         'data' type_id=3D4659 bits_offset=3D480
> > >=20
> > > So it all seems ok, we should keep all the info and teach fprintf to
> > > handle TYPE_TAG.
> > >=20
> > > Which you tried, but somehow the '*' link is missing.
> >=20
> > Yep, thanks a lot for the analysis, I will take a look.
> > Hopefully will send v2 tomorrow.
>=20
> So, with the patch below it gets equivalent, but some more tweaking is
> needed to make the output completely match (spaces, "long usigned" ->
> "unsigned long", which seems to be all equivalent):
>=20
> --- /tmp/gcc    2023-03-28 18:13:42.022385428 -0300
> +++ /tmp/clang  2023-03-28 18:13:45.854486885 -0300
> @@ -73,15 +73,15 @@
>         unsigned int               flags;                /*    16     4 *=
/
>         u32                        limit;                /*    20     4 *=
/
>         const struct Qdisc_ops  *  ops;                  /*    24     8 *=
/
> -       struct qdisc_size_table *  stab;                 /*    32     8 *=
/
> +       struct qdisc_size_table  * stab;                 /*    32     8 *=
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
> +       struct net_rate_estimator  * rate_est;           /*    72     8 *=
/
> +       struct gnet_stats_basic_sync  * cpu_bstats;      /*    80     8 *=
/
> +       struct gnet_stats_queue  * cpu_qstats;           /*    88     8 *=
/
>         int                        pad;                  /*    96     4 *=
/
>         refcount_t                 refcnt;               /*   100     4 *=
/
>=20
> @@ -96,8 +96,8 @@
>=20
>         /* XXX 4 bytes hole, try to pack */
>=20
> -       long unsigned int          state;                /*   216     8 *=
/
> -       long unsigned int          state2;               /*   224     8 *=
/
> +       unsigned long              state;                /*   216     8 *=
/
> +       unsigned long              state2;               /*   224     8 *=
/
>         struct Qdisc *             next_sched;           /*   232     8 *=
/
>         struct sk_buff_head        skb_bad_txq;          /*   240    24 *=
/
>=20
> @@ -112,7 +112,7 @@
>         /* XXX 40 bytes hole, try to pack */
>=20
>         /* --- cacheline 6 boundary (384 bytes) --- */
> -       long int                   privdata[];           /*   384     0 *=
/
> +       long                       privdata[];           /*   384     0 *=
/
>=20
>         /* size: 384, cachelines: 6, members: 28 */
>         /* sum members: 260, holes: 4, sum holes: 124 */
> @@ -145,19 +145,19 @@
>         /* XXX 4 bytes hole, try to pack */
>=20
>         struct netdev_queue *      (*select_queue)(struct Qdisc *, struct=
 tcmsg *); /*     8     8 */
> -       int                        (*graft)(struct Qdisc *, long unsigned=
 int, struct Qdisc *, struct Qdisc * *, struct netlink_ext_ack *); /*    16=
     8 */
> +       int                        (*graft)(struct Qdisc *, unsigned long=
, struct Qdisc *, struct Qdisc * *, struct netlink_ext_ack *); /*    16    =
 8 */
> -       struct Qdisc *             (*leaf)(struct Qdisc *, long unsigned =
int); /*    24     8 */
> +       struct Qdisc *             (*leaf)(struct Qdisc *, unsigned long)=
; /*    24     8 */
> -       void                       (*qlen_notify)(struct Qdisc *, long un=
signed int); /*    32     8 */
> +       void                       (*qlen_notify)(struct Qdisc *, unsigne=
d long); /*    32     8 */
> -       long unsigned int          (*find)(struct Qdisc *, u32); /*    40=
     8 */
> +       unsigned long              (*find)(struct Qdisc *, u32); /*    40=
     8 */
> -       int                        (*change)(struct Qdisc *, u32, u32, st=
ruct nlattr * *, long unsigned int *, struct netlink_ext_ack *); /*    48  =
   8 */
> +       int                        (*change)(struct Qdisc *, u32, u32, st=
ruct nlattr * *, unsigned long *, struct netlink_ext_ack *); /*    48     8=
 */
> -       int                        (*delete)(struct Qdisc *, long unsigne=
d int, struct netlink_ext_ack *); /*    56     8 */
> +       int                        (*delete)(struct Qdisc *, unsigned lon=
g, struct netlink_ext_ack *); /*    56     8 */
>=20
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 1e6147a82056c188..1ecc24321bf8f975 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -788,8 +788,15 @@ next_type:
>  			if (n)
>  				return printed + n;
>  			if (ptype->tag =3D=3D DW_TAG_LLVM_annotation) {
> -				type =3D ptype;
> -				goto next_type;
> +				// FIXME: Just skip this for now, we need to print this annotation
> +				// to match the original source code.
> +
> +				if (ptype->type =3D=3D 0) {
> +					printed +=3D fprintf(fp, "%-*s %s", tconf.type_spacing, "void *", n=
ame);
> +					break;
> +				}
> +
> +				ptype =3D cu__type(cu, ptype->type);
>  			}
>  			if (ptype->tag =3D=3D DW_TAG_subroutine_type) {
>  				printed +=3D ftype__fprintf(tag__ftype(ptype),

This explains why '*' was missing, but unfortunately it breaks apart
when there are multiple type tags, e.g.:


    $ cat tag-test.c
    #define __t __attribute__((btf_type_tag("t1")))
   =20
    struct foo {
      int  (__t __t *a)(void);
    } g;
    $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && pahol=
e --sort -F dwarf tag-test.o
    struct foo {
    	int ()(void)   *           a;                    /*     0     8 */
   =20
    	/* size: 8, cachelines: 1, members: 1 */
    	/* last cacheline: 8 bytes */
    };
    $ clang -g -c tag-test.c -o tag-test.o && pahole -J tag-test.o && pahol=
e --sort -F btf tag-test.o
    struct foo {
    	int ()(void)   *           a;                    /*     0     8 */
   =20
    	/* size: 8, cachelines: 1, members: 1 */
    	/* last cacheline: 8 bytes */
    };
   =20
What I don't understand is why pointer's type is LLVM_annotation.
Probably, the cleanest solution would be to make DWARF and BTF loaders
work in a similar way and attach LLVM_annotation as `annots` field of
the `struct btf_type_tag_ptr_type`. Thus, avoiding 'LLVM_annotation's
in the middle of type chains. I'll work on this.
