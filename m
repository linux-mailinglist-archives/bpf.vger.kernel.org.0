Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A5568E54
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 17:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiGFPxp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 11:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbiGFPxc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 11:53:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630D217585;
        Wed,  6 Jul 2022 08:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1096AB81DD4;
        Wed,  6 Jul 2022 15:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B149C3411C;
        Wed,  6 Jul 2022 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657122715;
        bh=QrvSEGjTk/SEFZ9JaHW1BcDV3Bs+gSOERlbtFXdLTCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ns7o9rSManQtptMRyQOeWgLnfOnPkvdAiQk0HzthhvA1t+2WDSj1AlQXzT5C6UehK
         n/iYy9H8nDNI9hJgopoKrFVajIwsgoa7dDhD11Ug8HNyKoLkwzjMm31fASEYTPUvX7
         VZ1/WifbTQycLE8bmbGn4wBtrr2cIexNW7nX0u1UC3GxiazE8oSGHRBHBFoUOK2JA1
         mNFYgYMbB6O9itQ1NtS7kYld2+R9SgBsPh0suJs+eHQaWfT5UID1XLk5x4+gNHZfey
         pByAzBTH/NXKrJqyEXkT4atiRgQJx8c7wNAOU7KynyHXdRDMSF/UATpA+JuY8ZQaXJ
         0hDqK8YZFN+2A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A3214096F; Wed,  6 Jul 2022 12:51:53 -0300 (-03)
Date:   Wed, 6 Jul 2022 12:51:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Jiri Olsa <olsajiri@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH] btf_loader: support BTF_KIND_ENUM64 was Re: [PATCH
 dwarves v2 0/2] btf: support BTF_KIND_ENUM64
Message-ID: <YsWvmRKaCbjf0XXB@kernel.org>
References: <20220615230306.851750-1-yhs@fb.com>
 <YrrPOFzYAGHm0oht@krava>
 <Yrx+Ehpc71/6WHVT@kernel.org>
 <YryELT6OadpiJki/@kernel.org>
 <CAEf4BzananDqBJyfu8n3VATNULd5ZgY2GrEYGvGSS_5dMW3mpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzananDqBJyfu8n3VATNULd5ZgY2GrEYGvGSS_5dMW3mpw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Jul 05, 2022 at 09:28:05PM -0700, Andrii Nakryiko escreveu:
> On Wed, Jun 29, 2022 at 9:56 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Jun 29, 2022 at 01:30:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > ⬢[acme@toolbox pahole]$ pdwtags -F btf vmlinux-v5.18-rc7+ | grep -B10 -A5 BPF_F_CTXLEN_MASK
> > > BTF: idx: 4173, Unknown kind 19
> > > BTF: idx: 4975, Unknown kind 19
> > > BTF: idx: 6673, Unknown kind 19
> > > BTF: idx: 27413, Unknown kind 19
> > > BTF: idx: 30626, Unknown kind 19
> > > BTF: idx: 30829, Unknown kind 19
> > > BTF: idx: 38040, Unknown kind 19
> > > BTF: idx: 56969, Unknown kind 19
> > > BTF: idx: 83004, Unknown kind 19
> > > ⬢[acme@toolbox pahole]$
> > >
> > > Ok, I need to update pahole's BTF loader to support:
> > >
> > > lib/bpf/src/btf.h:#define BTF_KIND_ENUM64             19      /* Enum for up-to 64bit values */
> > >
> > >
> > > Working on it now.
> >
> > ⬢[acme@toolbox pahole]$ pdwtags -F btf vmlinux-v5.18-rc7+ | grep -B5 -A5 BPF_F_CTXLEN_MASK
> >
> > /* 27413 */
> > enum {
> >         BPF_F_INDEX_MASK  = 4294967295,
> >         BPF_F_CURRENT_CPU = 4294967295,
> >         BPF_F_CTXLEN_MASK = 4503595332403200,
> > } __attribute__((__packed__)); /* size: 8 */
> >
> > /* 27414 */
> > enum {
> >         BPF_F_GET_BRANCH_RECORDS_SIZE = 1,
> > ⬢[acme@toolbox pahole]$
> >
> > Quick patch here, please Ack, if possible:
> >
> 
> two minor nits, but looks good overall:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for reviewing it!
 
> > diff --git a/btf_loader.c b/btf_loader.c
> > index b5d444643adf30b1..e57ecce2cde26e4e 100644
> > --- a/btf_loader.c
> > +++ b/btf_loader.c
> > @@ -312,6 +312,49 @@ out_free:
> >         return -ENOMEM;
> >  }
> >
> > +static struct enumerator *enumerator__new64(const char *name, uint64_t value)
> > +{
> > +       struct enumerator *en = tag__alloc(sizeof(*en));
> > +
> > +       if (en != NULL) {
> > +               en->name = name;
> > +               en->value = value; // Value is already 64-bit, as this is used with DWARF as well
> > +               en->tag.tag = DW_TAG_enumerator;
> > +       }
> > +
> > +       return en;
> > +}
> > +
> > +static int create_new_enumeration64(struct cu *cu, const struct btf_type *tp, uint32_t id)
> > +{
> > +       struct btf_enum64 *ep = btf_enum64(tp);
> > +       uint16_t i, vlen = btf_vlen(tp);
> > +       struct type *enumeration = type__new(DW_TAG_enumeration_type,
> > +                                            cu__btf_str(cu, tp->name_off),
> > +                                            tp->size ? tp->size * 8 : (sizeof(int) * 8));
> 
> tp->size should always be valid, so this fall back to sizeof(int)
> isn't necessary

This was just a copy from the create_new_enumeration() one, will remove
it there as well as a prep patch, then not have it in the 64-bit
version.
 
> > +
> > +       if (enumeration == NULL)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < vlen; i++) {
> > +               const char *name = cu__btf_str(cu, ep[i].name_off);
> > +               uint64_t value = ((uint64_t)ep[i].val_hi32) << 32 | ep[i].val_lo32;
> 
> use btf_enum64_value() defined in libbpf's btf.h header

Great, will pick that
 
> > +               struct enumerator *enumerator = enumerator__new64(name, value);
> > +
> > +               if (enumerator == NULL)
> > +                       goto out_free;
> > +
> > +               enumeration__add(enumeration, enumerator);
> > +       }
> > +
> > +       cu__add_tag_with_id(cu, &enumeration->namespace.tag, id);
> > +
> > +       return 0;
> > +out_free:
> > +       enumeration__delete(enumeration);
> > +       return -ENOMEM;
> > +}
> > +
> >  static int create_new_subroutine_type(struct cu *cu, const struct btf_type *tp, uint32_t id)
> >  {
> >         struct ftype *proto = tag__alloc(sizeof(*proto));
> > @@ -419,6 +462,9 @@ static int btf__load_types(struct btf *btf, struct cu *cu)
> >                 case BTF_KIND_ENUM:
> >                         err = create_new_enumeration(cu, type_ptr, type_index);
> >                         break;
> > +               case BTF_KIND_ENUM64:
> > +                       err = create_new_enumeration64(cu, type_ptr, type_index);
> > +                       break;
> >                 case BTF_KIND_FWD:
> >                         err = create_new_forward_decl(cu, type_ptr, type_index);
> >                         break;

-- 

- Arnaldo
