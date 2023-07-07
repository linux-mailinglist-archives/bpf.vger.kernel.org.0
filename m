Return-Path: <bpf+bounces-4436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7518F74B4C5
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 18:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEC528179C
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747FF107AF;
	Fri,  7 Jul 2023 16:00:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4092210795
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 16:00:58 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EE91BC3
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 09:00:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b5c2433134so26273141fa.0
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 09:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688745655; x=1691337655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beSJIkhZ1mrhGoJFwJoIZU5b5WTDvSAWyPHUCduELkE=;
        b=BNKBN19JcLtmyiSFVQSOss/dvveuS9zwPsi16h4cdg81Z+PYvIfWgxxqc2Mz/pePkL
         InD/Ra7fGo13H3FycN+LAsPDGNoPuuqaN7XoohlUk/x5latXdN/dTBktWJLszdClO20l
         F+NddSh3SucyIiQiuClkkgfkrKOUjtw5mr2jHx11+tRw2rmGkXwMdmLphBfaOGAGCDXE
         FKfUqk0jNXiHUlfLuGX9q1y9/TChLvuSTzl2l/2ToWMF9BBFM1iqU8GaKHXllXiWXi8e
         NbNm/mkGp5HagdFkXYpDpFTZhMyx1KUGvopogzfdA0+MtbT4jYkCr8zjuSUB19k/AUlC
         LAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688745655; x=1691337655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beSJIkhZ1mrhGoJFwJoIZU5b5WTDvSAWyPHUCduELkE=;
        b=lF5KL6aCyIzTIF6TO9DC/h3kiAR0dJN8fvFcoJ74rRdKW7PYBoLPnDx4VYCt20rlSh
         U5YPmXCuMcKrmxNO3hH0EzqqCq9SFE4a4uEvJzzuD0LV1W3dulUBlEJiCuuc74sRdm/6
         kjnlNdIuQMm1iMW/pZYshdjZDQeD2fzYpv0LbyvppzyNABd0pVwoBACU/ALeEpSfpNHo
         GS5sqVLXFqC/bo8Ye72ChF2/1H/BGzoUvy2gvnfOaUotJphEaC/018022iC96J7SrrRg
         FbKJPxSadM3Hd95H7GMiUbppCyxKOGlJhYqD4WeyUOqdkcb17LgHoYMq1WTE4cSLxSF1
         4Ffw==
X-Gm-Message-State: ABy/qLYx9YlrFtTZeG4huIDKLCfiN/+yJdAPpl0dm7rmje6+h2LsQ6Hg
	2Vxpu6c65tv19LcEF7s4ivaqcRzaHfDvlcGzgjM=
X-Google-Smtp-Source: APBJJlF0zchngRB/hnloZAdmK7buggvDVCDMxftne2PQeYQVO/8Fy1uY9/e6MvuChNVtbLXLUg/OAcI3he9kdD7f380=
X-Received: by 2002:a2e:7819:0:b0:2b6:c3f9:b86b with SMTP id
 t25-20020a2e7819000000b002b6c3f9b86bmr2141743ljc.15.1688745654554; Fri, 07
 Jul 2023 09:00:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH7PR21MB387813A79D0094E47914C5A8A32CA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJhfa+g227BX=3LijoXwgh7h3Z5V_ZF8tMeMWNZguAp5g@mail.gmail.com> <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
In-Reply-To: <PH7PR21MB3878DEA7280C274A8A18D082A32DA@PH7PR21MB3878.namprd21.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Jul 2023 09:00:43 -0700
Message-ID: <CAADnVQ+ogOVdwZSX4315hHe8bxP-yoYEacNPCP6CTHqn=Xp-uQ@mail.gmail.com>
Subject: Re: [Bpf] Instruction set extension policy
To: Dave Thaler <dthaler@microsoft.com>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 6, 2023 at 6:35=E2=80=AFPM Dave Thaler <dthaler@microsoft.com> =
wrote:
>
> I don't see any problem with defining an IANA registry with multiple "key=
" fields
> (opcode+src+imm).  All existing instructions can be done as such.
>
> Below is strawman text that I think follows IANA's requirements outlined
> in RFC 8126...
>
> -Dave
>
> --- snip ---
> IANA Considerations
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This document proposes a new IANA registry for BPF instructions, as follo=
ws:
>
> * Name of the registry: BPF Instruction Set
> * Name of the registry group: same as registry name
> * Required information for registrations: The values to appear in the ent=
ry fields.
> * Syntax of registry entries: Each entry has the following fields:
>   * opcode: a 1-byte value in hex format indicating the value of the opco=
de field
>   * src: a 4-bit value in hex format indicating the value of the src fiel=
d, or "any"
>   * imm: either a value in hex format indicating the value of the imm fie=
ld, or "any"
>   * description: description of what the instruction does, typically in p=
seudocode
>   * reference: a reference to the defining specification
>   * status: Permanent, Provisional, or Historical
> * Registration policy (see RFC 8126 section 4 for details):
>   * Permanent: Standards action
>   * Provisional: Specification required
>   * Historical: Specification required
> * Initial registrations: See the Appendix. Instructions other than those =
listed
>   as deprecated are Permanent. Any listed as deprecated are Historical.

I think that might work. What is the next step then?
Who is going to generate such a hex database?

