Return-Path: <bpf+bounces-14124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3547E0A98
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 22:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE16281F64
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C32374F;
	Fri,  3 Nov 2023 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blBnNaVT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941022EEC
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 21:11:55 +0000 (UTC)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F18FD4E
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 14:11:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so2030576a12.2
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699045909; x=1699650709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvQI0Y7ehmBTLQAlUfou3jFvUCQzko1qOzp6QNmutuo=;
        b=blBnNaVTrE8DOLnNRTQCaBaa4eOVA+bBRlYO3Vv196u6NREHY+mjHVWemmsyfNjJBA
         fs7lZ4veuID1FGDPhUqKxqZJY1vgkvHxmq1dZjm+2Xpmys8oRWgf+vRK62grUDgBUfCx
         6L793JuvRnOt9OQ1WgQDEAXanOqg0qjJFn6QTgsBGww+JV9AmmKUu/+mcFULsWxiUi0B
         p9zSapwc7Dlva1eqItCFLKBNll8CKXxm8wvtX2rFshpFCi3onRIgrDn+vhqO7Zprr/xP
         jqxIxdjbjamNVWZ3QhwxMTsHfqze/NmHurTFgx+ozZiyXMukEePcvATnY9JdWAgmFlVe
         saQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699045909; x=1699650709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvQI0Y7ehmBTLQAlUfou3jFvUCQzko1qOzp6QNmutuo=;
        b=Tko5+8xH/dS49smRT5sfaZtIpPdGDaLh8+riUQLT2szABdjFf02SZtN0TE6ObLXWL6
         8P8qCP3CodSuAny75RyttrSEpsDq6VnPudApc2fmzn+kCDr+jYGDaHgTsUGWpHjfndS3
         nbcgC4Ipaq/PH4uZgm2dO8mWxZuhoPHFFxrQlMVqxOP5a6gn1TqeWW/7rAeH/DBsP7mT
         eHTELOoiYwsp2inZ9g+L+NdzGZXJUIwvCB4SF4V5qRYfxfIBDryY0uQoIyuw46ZSZpMT
         YBmH+Fm6q8Vd384LayldO2jdhLmu3WR2nCVJ+PFJnbmL0rwJidQ500jynfchssrlJCMx
         TPBA==
X-Gm-Message-State: AOJu0YwrzodzxT1f0R2P45PyavLH6R3cEe6qZWV3nKIQENjkmE/3crJ4
	E0Xk0HVGJgrmuGJlxmtSair7BnJfHLjOPl9c7RI=
X-Google-Smtp-Source: AGHT+IF6FZScm0wuQmiWi9cFY8QyoeTRDXELSf9Yt2Ix78EaYvsI6SSNpNlisMGy+sHaPdTMYqEcDtjECOK36d8dBZU=
X-Received: by 2002:a17:907:954f:b0:9c4:4b20:44a1 with SMTP id
 ex15-20020a170907954f00b009c44b2044a1mr5744038ejc.65.1699045908486; Fri, 03
 Nov 2023 14:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103000822.2509815-1-andrii@kernel.org> <20231103000822.2509815-5-andrii@kernel.org>
 <f0344812c7d5cf1384b0fb7a04100d940fdbcaf1.camel@gmail.com>
In-Reply-To: <f0344812c7d5cf1384b0fb7a04100d940fdbcaf1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 3 Nov 2023 14:11:37 -0700
Message-ID: <CAEf4Bzbc_uc=77ZkipBQ_00WEh1-3zaUzOWPq4kwk7Q=YNLd6Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/13] bpf: add register bounds sanity checks and sanitization
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 10:56=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2023-11-02 at 17:08 -0700, Andrii Nakryiko wrote:
> > Add simple sanity checks that validate well-formed ranges (min <=3D max=
)
> > across u64, s64, u32, and s32 ranges. Also for cases when the value is
> > constant (either 64-bit or 32-bit), we validate that ranges and tnums
> > are in agreement.
> >
> > These bounds checks are performed at the end of BPF_ALU/BPF_ALU64
> > operations, on conditional jumps, and for LDX instructions (where subre=
g
> > zero/sign extension is probably the most important to check). This
> > covers most of the interesting cases.
> >
> > Also, we validate the sanity of the return register when manually
> > adjusting it for some special helpers.
> >
> > By default, sanity violation will trigger a warning in verifier log and
> > resetting register bounds to "unbounded" ones. But to aid development
> > and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> > trigger hard failure of verification with -EFAULT on register bounds
> > violations. This allows selftests to catch such issues. veristat will
> > also gain a CLI option to enable this behavior.
>
> This is a useful check but I'm not sure about placement.
> It might be useful to guard calls to coerce_subreg_to_size_sx() as well.

Those are covered as part of the ALU/ALU64 check.

My initial idea was to add it into reg_bounds_sync() and make
reg_bounds_sync() return int (right now it's void). But discussing
with Alexei we came to the conclusion that it would be a bit too much
code churn for little gain. This coerce_subreg...() stuff, it's also
void, so we'd need to propagate errors out of it as well.

In the end I think I'm covering basically all relevant cases (ALU,
LDX, RETVAL, COND_JUMP).

> Maybe insert it as a part of the main do_check() loop but filter
> by instruction class (and also force on stack_pop)?

That would be a) a bit wasteful, and b) I'd need to re-interpret BPF_X
vs BPF_K and all the other idiosyncrasies of instruction encoding. So
it doesn't seem like a good idea.

>
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf_verifier.h   |   1 +
> >  include/uapi/linux/bpf.h       |   3 +
> >  kernel/bpf/syscall.c           |   3 +-
> >  kernel/bpf/verifier.c          | 117 ++++++++++++++++++++++++++-------
> >  tools/include/uapi/linux/bpf.h |   3 +
> >  5 files changed, 101 insertions(+), 26 deletions(-)
> >

trimming is good

[...]

