Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B1C69FC63
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 20:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjBVTnO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 14:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjBVTnN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 14:43:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BA526CF2
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 11:43:11 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id m6so11569180lfq.5
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 11:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fHwuYHjpMTKH8TP6+CYz+g35OwX/KSIU/Q6aWMAJGCA=;
        b=IOPNgiQXK2Imyjqp2ebDrENRrKZek2Wc3+HZTC//o417hwM/xkRLvXA/RH56i44Tkx
         s3MbVN1u7h6F4evs7JLC92Xs9fZyJVY1syg3F0RkoLiWxgG1mcfhX4EoxPtzeaNwtJ5d
         EZ89PMb9y2jX49bkkvZw/WoYSoHy53+fT4xI7ODjKyL/I4k4JJ+tl7QmzzQg73bvyY9d
         Lp0ASZo+CegSCrWRjSkqF94pycLBeR5XcWHSrXGLS7Nh6/U32HcPjgcdYdoi3a9rD2Y9
         Q0/79lKSlFotajrNtJhL64KPkIT95kA0vVU/sSYksnhCGKW9FPO+CGEHxj52IzYu3RKh
         cseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fHwuYHjpMTKH8TP6+CYz+g35OwX/KSIU/Q6aWMAJGCA=;
        b=0vkuP8AcvsEaR9WPXu+X6pqNLb4oUfLawxYf+hzDTpWqR5bRqzJZrnzgixXO8hCU2L
         qiB4Yhhnd5kpEJ8AaUmW24ANrJeIcVfxcwFdrkSVedA9QIaoGDiAk2rpNLb3XlI5m3py
         OlaPSkhO7iD7u6uNL5gqyrANT1Z0FmMe4oyR/3aRou1BTSeTMgiBQt566XyltOG3Itp/
         M4ih6WumLOKYlTx9y0vogfvVK6Uugh5Nnk3OaXgXMirGsNx/WOv0JluksFdAvKHAEaap
         VrXpfLWsmDWpMRZR448znCfvk1dWql23DoPelI0V7VYb+31Fx4U5hXzcD264Qc3hAsjC
         4ZVw==
X-Gm-Message-State: AO0yUKXRBHiJ1qBTBcWS/eZclt59pqznFi8ERb/stxRT58sIevz3tux4
        JiJA0eKLcUwW7JpQVH35qt0=
X-Google-Smtp-Source: AK7set8USxFjzis3fjB5IDwKnJU9dw9O2zrH/xgYgzhV2xx4NXT3DPYc5e97EPGvHZp7n4CIDWkkVQ==
X-Received: by 2002:a19:f604:0:b0:4db:3ddf:2fbd with SMTP id x4-20020a19f604000000b004db3ddf2fbdmr3127624lfe.45.1677094989258;
        Wed, 22 Feb 2023 11:43:09 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id a21-20020ac25215000000b004cb08757441sm396592lfl.199.2023.02.22.11.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 11:43:08 -0800 (PST)
Message-ID: <d6f9fe3faa4aef62227420fc41f2e896f4d7eb2a.camel@gmail.com>
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>
Cc:     "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, Mykola Lysenko <mykolal@fb.com>
Date:   Wed, 22 Feb 2023 21:43:07 +0200
In-Reply-To: <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
         <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
         <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com>
         <1b84d1477c3648e6d20bacaf1447724fb78e282f.camel@gmail.com>
         <a71cd1ae-d4a0-7463-0afd-32d2e15a8882@oracle.com>
         <CAADnVQ+QNAEaqgOM9PwDs+0dkiL3wmPafJN=XY5ckcgTzmsiEg@mail.gmail.com>
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

On Wed, 2023-02-22 at 10:11 -0800, Alexei Starovoitov wrote:
[...]
> > > > What do you think about something like "debug_type_tag" or
> > > > "debug_type_annotation" (and a similar update for the decl tags)?
> > > > The translation into BTF records would be the same, but the DWARF i=
nfo
> > > > would stand on its own without being tied to BTF.
> > > >=20
> > > > (Naming is a bit tricky since terms like 'tag' are already in use b=
y
> > > > DWARF, e.g. "type tag" in the context of DWARF DIEs makes me think =
of
> > > > DW_TAG_xxxx_type...)
> > > >=20
> > > > As far as I understand, early proposals for the tags were more gene=
ric
> > > > but the LLVM reviewers wished for something more specific due to th=
e
> > > > relatively limited use of the tags at the time. Now that the tags a=
nd
> > > > their DWARF format have matured I think a good case can be made to
> > > > make these generic. We'd be happy to help push for such change.
> > >=20
> > > On the other hand, BTF is a thing we are using this annotation for.
> > > Any other tool can reuse DW_TAG_LLVM_annotation, but it will need a
> > > way to distinguish it's annotations from BTF annotations. And this ca=
n
> > > be done by using a different DW_AT_name. So, it seems logical to
> > > retain "btf" in the DW_AT_name. What do you think?
> >=20
> > OK I can understand keeping it BTF specific.
> >=20
> > Other than that, I don't come up with any significantly different idea
> > than to use the ":v2" suffix, so let's go with "btf_type_tag:v2"?
>=20
> I don't like v2 suffix either.
> Please come up with something else.

Nothing particularly good comes to mind:
- btf_type_tag:wrapper
- btf_type_tag:outer
- btf_type_tag:own
- exterior_btf_type_tag
- outer_btf_tag
- btf_type_prefix
- btf_type_qualifier (as in const/volatile)

Or might as well use btf_type_tag:gcc, as you suggested earlier,
but it is as confusing as the others.
