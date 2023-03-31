Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3301A6D2183
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 15:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCaNf5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Mar 2023 09:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjCaNf5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Mar 2023 09:35:57 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7A1BF62;
        Fri, 31 Mar 2023 06:35:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id h11so21927605lfu.8;
        Fri, 31 Mar 2023 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680269754; x=1682861754;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eCjDt0K/wxKPEs3etH2BLFmP4xafFAuBbzgtVkfgkAE=;
        b=M7mPyE/SOi8es9IIkwXRDnBPNHkG9Y0TVaETA8Kn6T5ge0VJ7Hsvh/YVhd2Es8dMHN
         klVgJeLnpS+t/ou17pZZO+UR+qM+VLOPvaUx2WGtMC1BiupN53ca7DTgTxu3iQlXoyTo
         tgJc6ulLZme2POoRkGTKW6sQx/rI34iYylA/X9ai5RSy7iIa96X6OM6eOs2sUpxtOTqd
         ByOCOzg/tmlkJ/BHWp2XZd7YE4wEGpTf6kW7Tckr3gsWhyG1tIMClPqB8eNK4QLan8oA
         rxfEOPCidIYr8OyR9xdfUJcs4rHGyEyaEiQHvX1DyOZisgRkdsl54/8FXVqH/Ow57P/p
         uugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680269754; x=1682861754;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eCjDt0K/wxKPEs3etH2BLFmP4xafFAuBbzgtVkfgkAE=;
        b=YljIGYgjeZAwRKp4AqA/lSafxVMoG+qE2jUCsAKxK4Z0PHHBHJkYhkdTEme7YCDfgx
         3XFuKHIClURo2gZFVjAg6RqvJYbm6d/zIzruuWd82RCIXNDJgNvq2QFfygFdFFLF2DeV
         FrhLSq+Ltpz+qbPJXPrJs70xHHpwgho/9sHOccQnX8rzhPkzZ5LLH4OYrDO6lhrBgbHw
         5x3aVNvVb0VxeWIMuNW+8HfAydszQbl+gwOIdiY/cbcKKq6nvckyD3Q3sKvw9WSevSSo
         be2xQcfvZ9HyedOG0hkWGlTknKZVqTif+AOSroDA7SkiNBHPqkEaXFKsu4tZIuxALExF
         jXSw==
X-Gm-Message-State: AAQBX9f68mcWg2SLTUhtzmhXINbT/mfpfpb7v8FkbOY8m/ZKek25MCXA
        hgOs0Hm4I62hGsGROgJoBtxd5L2p37cN2g==
X-Google-Smtp-Source: AKy350ajX3COQpqd1eF85arl9Ccm3D7guWM/EOHZ3XV69uE5Z+FU0TGkY1MxfNn9J95JEeLIUsUMiQ==
X-Received: by 2002:ac2:46ea:0:b0:4ea:e789:25b with SMTP id q10-20020ac246ea000000b004eae789025bmr3043263lfo.30.1680269754288;
        Fri, 31 Mar 2023 06:35:54 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x11-20020a19f60b000000b004eaf2291dcdsm385179lfe.102.2023.03.31.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 06:35:53 -0700 (PDT)
Message-ID: <f044179e39ec9e7665232eb5abad959ef5e19119.camel@gmail.com>
Subject: Re: [PATCH dwarves] fprintf: Fix `*` not being printed for pointers
 with btf_type_tag
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, yhs@fb.com
Date:   Fri, 31 Mar 2023 16:35:52 +0300
In-Reply-To: <ZCbOdWCKKzLlprIs@kernel.org>
References: <20230330212700.697124-1-eddyz87@gmail.com>
         <ZCbOdWCKKzLlprIs@kernel.org>
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

On Fri, 2023-03-31 at 09:13 -0300, Arnaldo Carvalho de Melo wrote:
> [...]
> > =20
> > +static type_id_t skip_llvm_annotations(const struct cu *cu, type_id_t =
id)
> > +{
> > +	struct tag *type;
> > +
> > +	for (;;) {
> > +		if (id =3D=3D 0)
> > +			break;
> > +		type =3D cu__type(cu, id);
> > +		if (type =3D=3D NULL || type->tag !=3D DW_TAG_LLVM_annotation || typ=
e->type =3D=3D id)
> > +			break;
> > +		id =3D type->type;
> > +	}
> > +
> > +	return id;
> > +}
>=20
> This part I didn't understand, do you see any possibility of a
> DW_TAG_LLVM_annotation pointing to another DW_TAG_LLVM_annotation?

Not at the moment, but it is no illegal, it is possible to write
something like this:

    #define __t1 __attribute__((btf_type_tag("t1")))
    #define __t2 __attribute__((btf_type_tag("t2")))
   =20
    int __t1 __t2 *g;
   =20
And to get BTF like ptr --> __t2 --> __t1 --> int.

> [...]
