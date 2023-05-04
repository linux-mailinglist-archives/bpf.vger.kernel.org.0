Return-Path: <bpf+bounces-51-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7446D6F7966
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49A21C215B0
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8D4C15D;
	Thu,  4 May 2023 22:51:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8756156FB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:51:46 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A495710F5
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:51:45 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965d2749e2eso53006066b.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240705; x=1685832705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gmEg8kDK3lUpXqxzECc7b2DzwafaRdlo5aU2Xb/wJhE=;
        b=XF3RVK2n6h1bytVpWnFBWd8aLEhXITsMw7kNzHsh7YsgfrncNuiexdOoa/aLTblIQS
         UCL3gjRq5kHFNBq0M4jXwK/sEl0Y56IRFCVcO2/c28Fc3RHD5vMvXOoO0dFizOCROpF2
         1cO9FOd/lRJS8Z/yrRwy8k6vhYcc5iT2PmxBJMFS9ia+eGc99dBpP80MQlJYpo8cP0+t
         S4x7Zp6EESOhYePap2eDUTQiYTwMOpYUUgc1CKWZbfTRSmDecbE490xFHuXA3SweK2+Q
         OaEhQDQH2WeLt4WDEOmQ+Rc7f+C+lOFe7BqJCrSmFWsITB3QoIC7u0Pofsylm89596es
         9oEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240705; x=1685832705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmEg8kDK3lUpXqxzECc7b2DzwafaRdlo5aU2Xb/wJhE=;
        b=WeQZEr+7KtemuPFvTxUhJ8oavLrcH+fYPZkY3z+pEKuvhzyXhljZUpDm0r7GhTlj+z
         hncYb8PnFTIglHJS6tLg9TYo90VPvuvmhCV+1Juvd3f6iALoGyjQXBVMTKWC+gxulF2O
         CySxtRl36tVndLS8V54+bbloaO+fc7LG2nU0m2tGmy9me0QQ/3dh8Q/zDE2oZ9k7KvHV
         +cMlsMthwbJAOsU80BRRDlDimYUaqBi+fI8D1MDBxMWKDB33yILiIEpoz2Fxx8RvxKZu
         eB9ErXecGsl1Xz7GGoEvo/sWordJjVUt7rgTOaXI7c6dBUvESwZ6p+106EZXJyGt40MH
         Nblw==
X-Gm-Message-State: AC+VfDyICuGgny+QfKUsq0YwmE+HggVQt5YLHc5+zyc4aGeSR1LkQXrg
	eVdB6GmdBFnkZaZb0Zg2ILDq2DdpL2KMGLFvm9E=
X-Google-Smtp-Source: ACHHUZ5YKPOzVoFaVGK6JAiX+KWqMrhbTf+2DHp1mqYFkLiOGrCYKMFg8oNXtDU+KIOMkRHzuAn5J0JHhKJFGDx8UaA=
X-Received: by 2002:a17:907:944e:b0:933:be1:8f4f with SMTP id
 dl14-20020a170907944e00b009330be18f4fmr392102ejc.9.1683240705136; Thu, 04 May
 2023 15:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-10-andrii@kernel.org>
 <20230504220941.rppjhdmnydlpm7ig@dhcp-172-26-102-232.dhcp.thefacebook.com>
In-Reply-To: <20230504220941.rppjhdmnydlpm7ig@dhcp-172-26-102-232.dhcp.thefacebook.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:51:32 -0700
Message-ID: <CAEf4BzbNZX15oxbXszzUY8U6QWHKFDrRk-hk67usd_4ZhfEEVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 09/10] bpf: use recorded bpf_capable flag in JIT code
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 3:09=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 02, 2023 at 04:06:18PM -0700, Andrii Nakryiko wrote:
> >
> > -int bpf_jit_charge_modmem(u32 size)
> > +int bpf_jit_charge_modmem(u32 size, const struct bpf_prog *prog)
> >  {
> >       if (atomic_long_add_return(size, &bpf_jit_current) > READ_ONCE(bp=
f_jit_limit)) {
> > -             if (!bpf_capable()) {
> > -                     atomic_long_sub(size, &bpf_jit_current);
> > -                     return -EPERM;
> > -             }
> > +             if (prog ? prog->aux->bpf_capable : bpf_capable())
> > +                     return 0;
>
> I would drop this patch.
> It still has to fall back to bpf_capable for trampolines and
> its 'help' to cap_bpf is minimal. That limit on all practical systems is =
huge.
> It won't have any effect for your future follow ups for cap_bpf in contai=
ners.

fair enough, will drop

