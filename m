Return-Path: <bpf+bounces-19267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B97F828A95
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 18:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1CD11F265DB
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 17:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441273A8E4;
	Tue,  9 Jan 2024 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfP8ZN/e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAB53A8C5;
	Tue,  9 Jan 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbe78430946so2277778276.0;
        Tue, 09 Jan 2024 09:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704819600; x=1705424400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYX4iopU3hH3Lrc97kLCNebamc5oIYTO340ikGT3SMM=;
        b=WfP8ZN/e2Kg1o+UgqQT5tQYIlh7eDeZQ4kgSa7tbZiCD08Rm3dVFEHCKopOrHiZ3jh
         h03NVOeUGpH//3C0YXtzrjeDHCtMuZTJ8IXhGrLhtk0zpxvS6c1XNvpSsbnvyIgyDbVR
         jd2F8mpPwOdiWMYnqb/s6XrrqI/Ky3akl2NkTrx+3/6FkPiLV41KfoLR4LXuLCm1yvua
         NV/v5XvgtP8FzJcn6ISEXDoUI3vSpfUfsm0aSkewJh6EyXtIYxMhLm260b0onsToxia3
         eJ+TBZ2HFTio07eudDlBBwCHZXqFASbsTmgZkRGivKWEAfwiyY6EsQf6M5GuMz2iHcgC
         GypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819600; x=1705424400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYX4iopU3hH3Lrc97kLCNebamc5oIYTO340ikGT3SMM=;
        b=EDLNh5n43D4hsWpvO489WARQHPByG4FMJLNeTE3e3eno5neIWACvV1ExugqKWNGakV
         +ywVtnTZ1u/kLvGIS8a0oEm+W0bIwXcRSo1xYrHj4BjpREypbVwRgbI/tS036sqB3JIQ
         4hrQgNfhsTV2afowe5BYBuNHAjxfn6EhXw3ibHm1cUxzpgQDKJGozmNjT2vzb93b+7Zb
         0eMdULIBicf1KCMsJtayagVRpUixc7ZrkfcWNZvb3Up7dbD3ylM6sdbSbnLjdXPkKaNS
         02LeD8L7QgBOvrnQfvRx+49ZtajXrpODm4n/Q2CtcUQKOLl+uaNTwQfkBUtxnKvi7AWJ
         BCYA==
X-Gm-Message-State: AOJu0YyQ2ApzJT1IwmAOieJF6W5kLpCyFRfIDqCVelFTzRJ+FyQBLevv
	G81/l4PjtULFOpvEyBh/NWWlqbX6vHywcCKUrA==
X-Google-Smtp-Source: AGHT+IFMAJE/ek3LB/WE3y8xcP5p3Dv1htvD7kcIRjnXqNFqQCw+Uer4Ift09c68Yv/gKmzMtFMsTB/v0Wn3ywkK4xM=
X-Received: by 2002:a25:d3cb:0:b0:dbe:32a8:12b2 with SMTP id
 e194-20020a25d3cb000000b00dbe32a812b2mr2943200ybf.106.1704819600280; Tue, 09
 Jan 2024 09:00:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109153609.10185-1-sunhao.th@gmail.com> <f84ffb6623d2901624337e88daf73ac639b37a2c.camel@gmail.com>
In-Reply-To: <f84ffb6623d2901624337e88daf73ac639b37a2c.camel@gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Tue, 9 Jan 2024 17:59:49 +0100
Message-ID: <CACkBjsauj7G31uAUB7137+ij5Pf4m-CB=woN35HBbZR5L3E6jg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, willemb@google.com, ast@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 5:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2024-01-09 at 16:36 +0100, Hao Sun wrote:
> > For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off
> > for validation. However, variable offset ptr alu is not prohibited
> > for this ptr kind. So the variable offset is not checked.
> >
> [...]
> >
> > Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hoo=
k")
> > Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index adbf330d364b..65f598694d55 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12826,6 +12826,10 @@ static int adjust_ptr_min_max_vals(struct bpf_=
verifier_env *env,
> >       }
> >
> >       switch (base_type(ptr_reg->type)) {
> > +     case PTR_TO_FLOW_KEYS:
> > +             if (known)
> > +                     break;
> > +             fallthrough;
> >       case CONST_PTR_TO_MAP:
> >               /* smin_val represents the known value */
> >               if (known && smin_val =3D=3D 0 && opcode =3D=3D BPF_ADD)
>
> This change makes sense, could you please add a testcase?
>

OK, will do it in the next version tomorrow.

> Also, this switch is written to explicitly disallow and implicitly allow
> pointer arithmetics, which might be a bit unsafe when new ptr types are a=
dded.
> Would it make more sense to instead rewrite it to explicitly allow?

Yes, this sounds more safe and clear to me, should be done in another patch=
.

> E.g. here is what it currently allows / disallows:
>
> | Pointer type        | Arithmetics allowed |
> |---------------------+---------------------|
> | PTR_TO_CTX          | yes                 |
> | CONST_PTR_TO_MAP    | conditionally       |
> | PTR_TO_MAP_VALUE    | yes                 |
> | PTR_TO_MAP_KEY      | yes                 |
> | PTR_TO_STACK        | yes                 |
> | PTR_TO_PACKET_META  | yes                 |
> | PTR_TO_PACKET       | yes                 |
> | PTR_TO_PACKET_END   | no                  |
> | PTR_TO_FLOW_KEYS    | yes                 |

This one should be `conditionally`, variable offset disallowed, fixed allow=
ed.

> | PTR_TO_SOCKET       | no                  |
> | PTR_TO_SOCK_COMMON  | no                  |
> | PTR_TO_TCP_SOCK     | no                  |
> | PTR_TO_TP_BUFFER    | yes                 |
> | PTR_TO_XDP_SOCK     | no                  |
> | PTR_TO_BTF_ID       | yes                 |
> | PTR_TO_MEM          | yes                 |
> | PTR_TO_BUF          | yes                 |
> | PTR_TO_FUNC         | yes                 |
> | CONST_PTR_TO_DYNPTR | yes                 |
>
> Of these PTR_TO_FUNC and CONST_PTR_TO_DYNPTR (?) should not be allowed
> as well, probably (not sure if that could be exploited).

I think both should be disallowed.

If alu sanitation is triggered, alu op on func and dynptr would be
rejected by retrieve_ptr_limit();
otherwise, it could be dangerous.

