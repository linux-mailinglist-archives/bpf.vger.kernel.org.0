Return-Path: <bpf+bounces-17689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A403811B26
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 18:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 016E51C210ED
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 17:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319F56B98;
	Wed, 13 Dec 2023 17:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxK+XREF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C977C9
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:33:35 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso9396806a12.2
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702488814; x=1703093614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=smS2tkiHMe1VlCYaniy8DHwSdJe5ZvK/CtIFx/Ofz8o=;
        b=IxK+XREFaVUUNwMSVfNGhlCcL0mRTC1ehvD3ybG/rG4BcPMeQl0cg8jx+M+8AfqbtS
         c95csCG5IG1eMtmlXLnuYOH0WbXlVNUmscaiH5Zf72h+20a5dfdZvGrOk1spxU5W5VSE
         HdEhq+0KfseuWk7kVOof+lYdKOLHEPsIFHIjoOShyeHiZQ47OJ0lxGKuE2OMgwflKQzl
         k7q7SQQxXlNFdTYVhtpzoYoGYw+3+TNArB1GnprgNoFhmgY45s6wQ0sveb/wWOK8yWzc
         reasXPksfxW8LyxSMlthy0TdlzWINBBYj6fbkr/m2qwlgpYiRg8FhXzlV7tziGn6Uyqh
         6wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702488814; x=1703093614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=smS2tkiHMe1VlCYaniy8DHwSdJe5ZvK/CtIFx/Ofz8o=;
        b=hyz4VG2TDtNMzclveDuIR2yW/EJ6Cka7AJ9zxw/DTAaRT6N9BFSy9tX8GQawIaaAuP
         9UWqT3ccp+40zB9e+I3jjE6auEg0YQfFksE9PQYiiu7dQ6K+s97pZTcDzmrs9NPkTLd5
         gsqBGwnRGDhgiv4wyhvNE7DvI81YAh7bsglyhQCHtsun0qHi0CFV5NavnJPdNKQ0KvCf
         uZ79FGeNu263Cm9GGtNqMis6Hewb/uPxlMM+UsoTB4PXkfeSQw+N6Dw7+aDITPxSRZQ4
         JB0wRNv7CmIJm3LdUywccABhqL13Qm8t2sSv9m85y7L5w2SFzbwPzx6eJa49B9GZd/LQ
         QmAw==
X-Gm-Message-State: AOJu0Yy16Rx3tn+BVoIh/A25Ot87J89K4ihjiTFHAh1ZS6B5ros/wZhp
	WOVC7hTtzgrYR5fbb7/nOrhcvYPQQcrioGTSLdMn3vkc
X-Google-Smtp-Source: AGHT+IHBSUb0rgVtB8O4dx767d8Sq4o+ev1qCh9DmCHUMDoO9+d7LJQy7KBPvHCUuzcR0q9S7ouVnAyKDtUI7/yEQyY=
X-Received: by 2002:a17:906:32c3:b0:a18:3b25:d72e with SMTP id
 k3-20020a17090632c300b00a183b25d72emr4521842ejk.67.1702488813756; Wed, 13 Dec
 2023 09:33:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212182547.1873811-1-andrii@kernel.org> <20231212182547.1873811-6-andrii@kernel.org>
 <ta3mccaaphwf3ax73lf6x22gu5xymt2mmhmardhj5wh34m55ce@gqdbmfhzexpg>
In-Reply-To: <ta3mccaaphwf3ax73lf6x22gu5xymt2mmhmardhj5wh34m55ce@gqdbmfhzexpg>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 09:33:21 -0800
Message-ID: <CAEf4Bzab_w-bs7rQ-JLUU7vg331Y2akieht2OD=AQ6+uTku_Bg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/8] libbpf: wire up token_fd into feature
 probing logic
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 8:00=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 12, 2023 at 10:25:44AM -0800, Andrii Nakryiko wrote:
> >
> > -enum kern_feature_result {
> > -     FEAT_UNKNOWN =3D 0,
> > -     FEAT_SUPPORTED =3D 1,
> > -     FEAT_MISSING =3D 2,
> > -};
> > -
> > -typedef int (*feature_probe_fn)(void);
> > -
> > -struct kern_feature_cache {
> > -     enum kern_feature_result res[__FEAT_CNT];
> > -};
> > +typedef int (*feature_probe_fn)(int /* token_fd */);
>
> Should have been in the previous patch?

This is the first patch that needs to instantiate struct
kern_feature_cache outside of features.c (now also in struct
bpf_object), so I only started needing this change in this patch. But
yep, I can probably place it in a final place in the previous patch
and make it less distracting from the main change. Will adjust in the
next revision.

