Return-Path: <bpf+bounces-5689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFF475E474
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 21:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02B32815D6
	for <lists+bpf@lfdr.de>; Sun, 23 Jul 2023 19:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E6F46BA;
	Sun, 23 Jul 2023 19:21:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE34C75
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 19:21:23 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9641BC
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 12:21:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99357737980so622191466b.2
        for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690140081; x=1690744881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Of2dZR6p7RQ+g+Cv/a0IJt5mdimLvIK0gQgJyv7jmkM=;
        b=CKAheqEzXzy/u01yffy+ZXv8EyMrd36HtIg932DXwSZuJQZSgYILgLS3CycpnhpM9k
         sbDwYZVmTdTqePJTqPGUUc+KSMlSMzAechZNpHm7vNnc1LJIALkkUrFcPypiTqyxXKFC
         yCfZKrxMkGbtnCTpvuMWtIAbbL4PeH617FMtz9Jq1QHXv0UGTq8bFiS2ykX0ZWJhvZOV
         Mn3LkCAgfUpMCN7DMxF7EcoToR0wwuZSdQhhGVWUBlNnm5gc9GEC883FoL7/XrH/iPhx
         whJneVoFPStHntgh0LKDX1R54Qu3o5dktPLGxs0IAI+aEocBwEdDDg9fAmK2BJcQJ2oV
         25sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690140081; x=1690744881;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Of2dZR6p7RQ+g+Cv/a0IJt5mdimLvIK0gQgJyv7jmkM=;
        b=bhWnOebx+gFXX6cJmAzmiDrIMXe8jzgKZndDvUT9goptkDg+OVf1+aRwSojRV1+3pG
         stJ+Ahb3XBKQx/LeqC2LGftOnz6S7bnzEEDt/7ROIohyGyVlWt1abO6MQooJojjOQ+QD
         yer6bojWVKelPCX99IjNAg9wnG7gr+BcZg89rOB1GEiKXxm05PegIq863pkP3M8viVZ7
         YIDEDJJ+jiZznRGTl++w4GshbO9zkEymwMwUEzWjJnbFsfC98d3ZuUV0nZdHTkko1n+E
         A+1DU0QxAOxzFOTFUB4heBr432QdWcL5AcGmSZb4eHynKVhPfF/NcnIM7dCy+X8MmXEe
         4vUA==
X-Gm-Message-State: ABy/qLaDZdlLvINgB4nY+GDNREc/rJNWpvpog0iYpJlPzH0fZON+iP6g
	GmdEBNYoSC3r5Bh7nB5qXyc=
X-Google-Smtp-Source: APBJJlEBvXgJgyUDpUM+LpU8CVkCxTTT4CBUCsb9vSZtSEKhD+/d1m3oOBY9USVAhsrJqfYCxzEoeg==
X-Received: by 2002:a17:906:53d9:b0:99b:5642:b97a with SMTP id p25-20020a17090653d900b0099b5642b97amr8311101ejo.46.1690140080513;
        Sun, 23 Jul 2023 12:21:20 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id oz13-20020a170906cd0d00b0099b8234a9fesm2343525ejb.1.2023.07.23.12.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 12:21:20 -0700 (PDT)
Message-ID: <ee97e19d73fa460bc37004baf01bd5f9fe6f67b4.camel@gmail.com>
Subject: Re: Encoding of V4 32-bit JA
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Date: Sun, 23 Jul 2023 22:21:19 +0300
In-Reply-To: <878rb6qw2h.fsf@oracle.com>
References: <87a5vp6xvl.fsf@oracle.com>
	 <32dc8c48803ff047266ee396fed3ccc9f7f0147e.camel@gmail.com>
	 <878rb6qw2h.fsf@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 2023-07-23 at 21:14 +0200, Jose E. Marchesi wrote:
> > On Fri, 2023-07-21 at 18:19 +0200, Jose E. Marchesi wrote:
> > > Hi Yonghong.
> > >=20
> > > This is from the v4 instructions proposal:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0code      value  description                n=
otes
> > > =C2=A0=C2=A0=C2=A0=C2=A0=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > =C2=A0=C2=A0=C2=A0=C2=A0BPF_JA    0x00   PC +=3D imm                 =
 BPF_JMP32 only
> > >=20
> > > Is this instruction using source 1 instead of 0?  Otherwise, it would
> > > have exactly the same encoding than the V3< JA instruction.  Is that
> > > what is intended?
> > >=20
> > > TIA.
> > >=20
> >=20
> > Hi Jose,
> >=20
> > I think that assumption is that `BPF_JMP32 | BPF_JA` is currently free:
> > - documentation [1] implies that only `BPF_JMP` should be used for `BPF=
_JA`
> > =C2=A0=C2=A0(see "notes" column for the first line)
> > - BPF verifier rejects `BPF_JMP32 | BPF_JA`
> > - clang always generates `BPF_JMP | BPF_JA`
>=20
> Makes sense, thanks for the info.
>=20
> Do you know the precise pseudo-c assembly syntax to use for this
> instruction?

In [1] Yonghong uses the following form:

  gotol +0xcd9b

But it seems to be not specified in the documentation for the patch-set v3.

[1] https://reviews.llvm.org/D144829

>=20
> > Thanks,
> > Eduard
> >=20
> > [1] https://www.kernel.org/doc/html/latest/bpf/instruction-set.html#jum=
p-instructions


