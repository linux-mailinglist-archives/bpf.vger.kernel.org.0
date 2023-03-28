Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB896CC65A
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 17:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjC1Pb1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 11:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjC1PbL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 11:31:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B879011148;
        Tue, 28 Mar 2023 08:30:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x3so51248488edb.10;
        Tue, 28 Mar 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680017409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SmG71KAe/HbOI/Vh5jnMjRu3Q7yaHvmEFQCCmVI70gM=;
        b=Xg+PTJRhONydOdUYtwqTNCV2+1RMLOGNZsuYif6kmKsGZPZyv5DZf8go3aaiXM6AD3
         k6SUdeSLJt9b3p/tPIYNJYn7GIJEtFR+fyiCCTqIzox+EgTn/Wl2ovlDMmXqJUzOy0ig
         FSDV6LnHFnOGl9DX27KrvinRnpMN0LP+Fz7zRXGWd8AvCys6eY5eycAgrdjumsiWJtgP
         5UIfTN2F2zUficuqLJdWYEIKp9CNa5X2RXruY/C3PHQuYSaqZkOGNXSzraMXIMQJv5t+
         qFnjxDUKjhDKVdwN9iDHAd3T7vJYMTzAPBEwhlBDvoSHzLEam0yfs+v+rm10Bsf+XkgI
         X1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680017409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmG71KAe/HbOI/Vh5jnMjRu3Q7yaHvmEFQCCmVI70gM=;
        b=SNwIS2yB7HGb7YDpbadeO/eYkSR4JCtTDMsK7sG1GhXtAx19qVZOlwMutzjkhCk798
         a3qlKnMEgf7slbX3fUxB+2yuf4KIi0M61f0fr1tC8CA73fnxkQ69zE24PUKY4oQ1ILiY
         GTTgHIPDv3QjjPB/IpIByW4MbQAqyEj718a+HItGmt2ytGpXV6A9/+5WdXWeNeFHkDNn
         s89DLcALjDwAHnbFaRmCfKrO4ZSbCz0iwzfWa0tS0nC+Twb2gc0+bu23fXpKV58Gc1vr
         ULKv3PnIrdUEYn+AF22dVBrxujrBb9LujsBTV707fxv4dszNTnx4J36rXgFIv1osM3tU
         8Xmg==
X-Gm-Message-State: AAQBX9fOLjVH1PCp8iAvfDMnm6bcjg0rokFsKox8lrbNZibRQP7vuRLU
        CMDNaRQ2OkRCqsgUkKtjxHY=
X-Google-Smtp-Source: AKy350bgmFX2NPv2xwdz0oJHOHmaiza+hmgUYsCFTpvF4HpGDe9246z0ciGMwnHFw6BYApbHCFzvVQ==
X-Received: by 2002:a17:906:4bcc:b0:93e:24f6:d7a3 with SMTP id x12-20020a1709064bcc00b0093e24f6d7a3mr15756390ejv.8.1680017408989;
        Tue, 28 Mar 2023 08:30:08 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i22-20020a17090671d600b0093348be32cfsm13501133ejk.90.2023.03.28.08.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:30:07 -0700 (PDT)
Message-ID: <50a160d802ad3f84e91cf05c8f541e0c2e388fc8.camel@gmail.com>
Subject: Re: [PATCH dwarves v2 1/5] fprintf: Correct names for types with
 btf_type_tag attribute
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, jose.marchesi@oracle.com, david.faust@oracle.com,
        alan.maguire@oracle.com
Date:   Tue, 28 Mar 2023 18:30:05 +0300
In-Reply-To: <ZCMHKFdmjVpOSNsJ@kernel.org>
References: <20230314230417.1507266-1-eddyz87@gmail.com>
         <20230314230417.1507266-2-eddyz87@gmail.com> <ZCLy0hjyR3KuYy3e@kernel.org>
         <f4803213ab27c65517eea19a12be78dd4ec9f6b0.camel@gmail.com>
         <ZCMHKFdmjVpOSNsJ@kernel.org>
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

On Tue, 2023-03-28 at 12:26 -0300, Arnaldo Carvalho de Melo wrote:
[...]=20
> Sure, but look:
>=20
> > > -       struct qdisc_size_table *  stab;                 /*    32    =
 8 */
> > > +       struct qdisc_size_table    stab;                 /*    32    =
 8 */
>=20
> Its the DW_TAG_pointer_type that is getting lost somehow:
>=20
>  <1><b0af32>: Abbrev Number: 81 (DW_TAG_structure_type)
>     <b0af33>   DW_AT_name        : (indirect string, offset: 0xe825): Qdi=
sc
>     <b0af37>   DW_AT_byte_size   : 384
>     <b0af39>   DW_AT_decl_file   : 223
>     <b0af3a>   DW_AT_decl_line   : 72
>=20
> <SNIP>
>=20
>  <2><b0af77>: Abbrev Number: 65 (DW_TAG_member)
>     <b0af78>   DW_AT_name        : (indirect string, offset: 0x4745ff): s=
tab
>     <b0af7c>   DW_AT_type        : <0xb0b76b>
>     <b0af80>   DW_AT_decl_file   : 223
>     <b0af81>   DW_AT_decl_line   : 99
>     <b0af82>   DW_AT_data_member_location: 32
>=20
> <SNIP>
>=20
> <1><b0b76b>: Abbrev Number: 61 (DW_TAG_pointer_type)
>     <b0b76c>   DW_AT_type        : <0xb0b77a>
>  <2><b0b770>: Abbrev Number: 62 (User TAG value: 0x6000)
>     <b0b771>   DW_AT_name        : (indirect string, offset: 0x378): btf_=
type_tag
>     <b0b775>   DW_AT_const_value : (indirect string, offset: 0x6e93): rcu
>  <2><b0b779>: Abbrev Number: 0
>  <1><b0b77a>: Abbrev Number: 69 (DW_TAG_structure_type)
>     <b0b77b>   DW_AT_name        : (indirect string, offset: 0x6e5ed): qd=
isc_size_table
>     <b0b77f>   DW_AT_byte_size   : 64
>     <b0b780>   DW_AT_decl_file   : 223
>     <b0b781>   DW_AT_decl_line   : 56
>=20
> =20
> So it's all there in the DWARF info:
>=20
>    b0af77 has type 0xb0b76b which is a DW_TAG_pointer_type that has type
>    0xb0b77a, that is DW_TAG_structure_type.
>=20
> Now lets see how this was encoded into BTF:
>=20
> [4725] STRUCT 'Qdisc' size=3D384 vlen=3D28
> <SNIP>
>         'stab' type_id=3D4790 bits_offset=3D256
> <SNIP>
> [4790] PTR '(anon)' type_id=3D4789
> <SNIP>
> [4789] TYPE_TAG 'rcu' type_id=3D4791
> <SNIP>
> [4791] STRUCT 'qdisc_size_table' size=3D64 vlen=3D5
>         'rcu' type_id=3D320 bits_offset=3D0
>         'list' type_id=3D87 bits_offset=3D128
>         'szopts' type_id=3D4792 bits_offset=3D256
>         'refcnt' type_id=3D16 bits_offset=3D448
>         'data' type_id=3D4659 bits_offset=3D480
>=20
> So it all seems ok, we should keep all the info and teach fprintf to
> handle TYPE_TAG.
>=20
> Which you tried, but somehow the '*' link is missing.

Yep, thanks a lot for the analysis, I will take a look.
Hopefully will send v2 tomorrow.

>=20
> - Arnaldo

