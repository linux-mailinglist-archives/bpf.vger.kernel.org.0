Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7626D221E
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 16:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCaOMh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 10:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjCaOMh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 10:12:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A421C1D7;
        Fri, 31 Mar 2023 07:12:35 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x17so29077314lfu.5;
        Fri, 31 Mar 2023 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680271954; x=1682863954;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m2fQ/nrclizsFMt8sPQZ+YUwgZgpR7tF9rZ8mJFCyg4=;
        b=JFaCBOb4hP3BsTMqR0fyX6MjAMDaKUyxK5G4txBQTaxYdwKnVbJ5QDzn+JrIbqkK7t
         NdXja39wLc0UkTtPvfLU8uCbv0zaw0Lt8YTTOLXXeu0+zNiIjvrWwxXYeTmpnPVTx3gM
         Xq8xn+sVVWwqlNAiIiH0AyNxFnJoUVdXV6/ttvSt88K5fP+rTptLqRnEiNQYzAnnIeVu
         OdsOYfZDKZaonhe/G6bU1mt6ZWQl/+qdlhU1qPriIJdWS/KAeYIPxqy6tlcoyF4TorBR
         ZFe1AMIhWF66hu7tBOEQV7lQBR5QMOXMqSvL2CsUVz7aevd31+TijOgn4/ZuZGtWZLnq
         kxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680271954; x=1682863954;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2fQ/nrclizsFMt8sPQZ+YUwgZgpR7tF9rZ8mJFCyg4=;
        b=eqcFondXCgmVLldSrPyQ51HxcMDjldD2074BQEIBFYas6ld4tedog7sf1oY/U/0LSo
         98SfCmc/1jQClgGnty41/gKKFkZkBoyXqifR041+7N2+MTFRBnMwu1/SNyM8SiI7DwoZ
         TtVIM9s4OCd8O0M3h19q6vmeia161NWzmTvtzBNE61l5+2igMNh8xtIGwDBCcOSHn2x9
         MZ+qCDMDjDkWJ/ZiJVBpn9RNHKL9+WEG0gQUDikC6yKhh8oR0E+TObhbpAuShsF+Az6u
         GA3f6fzZyfaOY9FGvWEcimbXZtZ0Oi06fHcWl4dWJ3hHgAjukp6/2fhZEv+7WRhw6TBp
         31zg==
X-Gm-Message-State: AAQBX9ewnSden0o/fLiwFZc6uejUqaCol1Tpbu5wDl9sfrMhoLq1UDiB
        GdV6AC/f1ginL8y48sEl5OA=
X-Google-Smtp-Source: AKy350YOpLRlmQctf5AddafmG6uXGd0vDIBC6ammGxpngciH4DSAS9YAitmQNhOPSmchbcFE0ctkuQ==
X-Received: by 2002:a05:6512:4cb:b0:4e8:44e3:f3da with SMTP id w11-20020a05651204cb00b004e844e3f3damr9399344lfq.39.1680271953884;
        Fri, 31 Mar 2023 07:12:33 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id o28-20020a056512051c00b004cb0dd2367fsm393185lfb.308.2023.03.31.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 07:12:33 -0700 (PDT)
Message-ID: <7728af3d77339ea4a333ca4ad9654953c4c2c5cd.camel@gmail.com>
Subject: Re: [PATCH dwarves] fprintf: Fix `*` not being printed for pointers
 with btf_type_tag
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com
Date:   Fri, 31 Mar 2023 17:12:31 +0300
In-Reply-To: <ZCbQGhtWWJ5q2P+a@kernel.org>
References: <20230330212700.697124-1-eddyz87@gmail.com>
         <ZCbOdWCKKzLlprIs@kernel.org> <ZCbOr4pwrX7JVnCZ@kernel.org>
         <ZCbQGhtWWJ5q2P+a@kernel.org>
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

On Fri, 2023-03-31 at 09:20 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 31, 2023 at 09:14:39AM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > > This part I didn't understand, do you see any possibility of a
> > > DW_TAG_LLVM_annotation pointing to another DW_TAG_LLVM_annotation?
> >=20
> > I _think_ its a noop, so will test your patch as-is, thanks!
>=20
> Tested, now we're left with normalizing base type names generated by
> clang and gcc, things like:
>=20
> --- /tmp/gcc    2023-03-31 09:16:34.100006650 -0300
> +++ /tmp/clang  2023-03-31 09:16:26.211789489 -0300
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
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         void                       (*walk)(struct Qdisc *, struct qdisc_w=
alker *); /*    64     8 */
> -       struct tcf_block *         (*tcf_block)(struct Qdisc *, long unsi=
gned int, struct netlink_ext_ack *); /*    72     8 */
> +       struct tcf_block *         (*tcf_block)(struct Qdisc *, unsigned =
long, struct netlink_ext_ack *); /*    72     8 */
> -       long unsigned int          (*bind_tcf)(struct Qdisc *, long unsig=
ned int, u32); /*    80     8 */
> +       unsigned long              (*bind_tcf)(struct Qdisc *, unsigned l=
ong, u32); /*    80     8 */
> -       void                       (*unbind_tcf)(struct Qdisc *, long uns=
igned int); /*    88     8 */
> +       void                       (*unbind_tcf)(struct Qdisc *, unsigned=
 long); /*    88     8 */
> -       int                        (*dump)(struct Qdisc *, long unsigned =
int, struct sk_buff *, struct tcmsg *); /*    96     8 */
> +       int                        (*dump)(struct Qdisc *, unsigned long,=
 struct sk_buff *, struct tcmsg *); /*    96     8 */
> -       int                        (*dump_stats)(struct Qdisc *, long uns=
igned int, struct gnet_dump *); /*   104     8 */
> +       int                        (*dump_stats)(struct Qdisc *, unsigned=
 long, struct gnet_dump *); /*   104     8 */
>=20
>         /* size: 112, cachelines: 2, members: 14 */
>         /* sum members: 108, holes: 1, sum holes: 4 */
> @@ -227,21 +227,21 @@
>=20
> This was affected somehow by these LLVM_annotation patches, I'll try to
> handle this later.=20

Are you sure it is related to LLVM_annotation patches?
I tried (4d17096 "btf_encoder: Compare functions via prototypes not paramet=
er names")
and see the same behavior.

Looking at the DWARF, itself gcc and clang use different names for these ty=
pes:

gcc:
0x0000002b:   DW_TAG_base_type
                DW_AT_byte_size (0x08)
                DW_AT_encoding  (DW_ATE_unsigned)
                DW_AT_name      ("long unsigned int")

clang:
0x000000f7:   DW_TAG_base_type
                DW_AT_name      ("unsigned long")
                DW_AT_encoding  (DW_ATE_unsigned)
                DW_AT_byte_size (0x08)

And the base type names are copied to BTF as is. Looks like some
normalization is necessary either in dwarf_loader.c:base_type__new()
or in fprintf.

Thanks,
Eduard
