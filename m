Return-Path: <bpf+bounces-12042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFD57C7393
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BD4282A76
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 16:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866F730D04;
	Thu, 12 Oct 2023 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSyTRo6U"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7157B2B76E
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 16:59:39 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA3FB7
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:59:37 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1037515b3a.0
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 09:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697129977; x=1697734777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uptzhPpO1zgR/giW2SA3LYvHdrcpgLBUl9BDOFgZA14=;
        b=hSyTRo6UnJ1ATOVFrEhFftoh+PCzxqXZStb9UnBDvyl0cmOZffkawfQ1YiksxFKbCR
         c3Zdto+TFb+a8D7aXS6S6PXZlf1u8spKnUvsHc/Rvew3RDD1InuRqFtjNKhsGkpmddo+
         109LjAqRhWv6kDWHZKY4nfSTx1D99GLp5BZly8oMDGDwPmE2xOMRKIDxlO1PShyNNZs9
         QlkWKNWj9XCQOMSn/MjAdqeBTl1odtCCe9UnJnEYG2AS2qVcnFwTjRW2nG0Yx9c+mr3N
         NuuZhqIDLkUY8fMIyjjMkpcSJZ8GxMSxBtg+CmVyD5EqTjN4x0mi09PAujI5ePVzK/lE
         5Vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129977; x=1697734777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uptzhPpO1zgR/giW2SA3LYvHdrcpgLBUl9BDOFgZA14=;
        b=cJGBJfalDLvtoK92O4ix7o8GyuLXsXPHaYIFS0FdfDeLT2DkSmzwR0DmW/mludbDco
         76WhSQKJBMfUZZat0oE45tJ5SOaKDChSxqswQLmQP+zJJS772JDiC2aU+BB9OjzQ0gG6
         y7wjNLQMG76PHEfhyOrwJ7Jl8NMfMIeBjWzy+hXrZqO7epe+n4JO1UwvsZtMHgAS2D9M
         VFvb1Il8lXoFWY39vVftpIrAWZGyrsB68JuLRGtueG1l/+/A5GSc92GeVoceOJK7XQLU
         2Hxp5YsitIlHKmawHGbzo0l4t66zPiPCjhpuDfcnQaVonPVy6Q0Zr+8K08Z5kDqULwjH
         NpYA==
X-Gm-Message-State: AOJu0YzUIW6mqWvIpjalCjz7e0xh5XenVF8D1bvDAuEyUyneGAZWyAaB
	ZQsPmHFjpC6QUgaPUyLS1HA=
X-Google-Smtp-Source: AGHT+IEyjxtFW7jgx16NAdGwdCN2qT0y+RVd7YqCPR14TYbPjexET9lBGOX0u2+Hhc9O1Z4sS3Rpyg==
X-Received: by 2002:a05:6a00:13a3:b0:693:4552:cd6a with SMTP id t35-20020a056a0013a300b006934552cd6amr26294908pfg.16.1697129976797;
        Thu, 12 Oct 2023 09:59:36 -0700 (PDT)
Received: from localhost ([2605:59c8:148:ba00:f19c:b8a1:b702:40fe])
        by smtp.gmail.com with ESMTPSA id x23-20020aa793b7000000b006933f504111sm12464719pff.145.2023.10.12.09.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:59:36 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:59:34 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org, 
 kernel-team@meta.com
Message-ID: <652825f6df713_5644208f2@john.notmuch>
In-Reply-To: <CAEf4BzaZx3_wGXqXBFt_Y4z+2L9XF7krNan4ZN4DQ0uLLXOf_Q@mail.gmail.com>
References: <20231011223728.3188086-1-andrii@kernel.org>
 <20231011223728.3188086-5-andrii@kernel.org>
 <65278534a3cb0_4a01020845@john.notmuch>
 <CAEf4BzaZx3_wGXqXBFt_Y4z+2L9XF7krNan4ZN4DQ0uLLXOf_Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: disambiguate SCALAR register state
 output in verifier logs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Andrii Nakryiko wrote:
> On Wed, Oct 11, 2023 at 10:33=E2=80=AFPM John Fastabend
> <john.fastabend@gmail.com> wrote:
> >
> > Andrii Nakryiko wrote:
> > > Currently the way that verifier prints SCALAR_VALUE register state =
(and
> > > PTR_TO_PACKET, which can have var_off and ranges info as well) is v=
ery
> > > ambiguous.
> > >
> > > In the name of brevity we are trying to eliminate "unnecessary" out=
put
> > > of umin/umax, smin/smax, u32_min/u32_max, and s32_min/s32_max value=
s, if
> > > possible. Current rules are that if any of those have their default=

> > > value (which for mins is the minimal value of its respective types:=
 0,
> > > S32_MIN, or S64_MIN, while for maxs it's U32_MAX, S32_MAX, S64_MAX,=
 or
> > > U64_MAX) *OR* if there is another min/max value that as matching va=
lue.
> > > E.g., if smin=3D100 and umin=3D100, we'll emit only umin=3D10, omit=
ting smin
> > > altogether. This approach has a few problems, being both ambiguous =
and
> > > sort-of incorrect in some cases.
> > >
> > > Ambiguity is due to missing value could be either default value or =
value
> > > of umin/umax or smin/smax. This is especially confusing when we mix=

> > > signed and unsigned ranges. Quite often, umin=3D0 and smin=3D0, and=
 so we'll
> > > have only `umin=3D0` leaving anyone reading verifier log to guess w=
hether
> > > smin is actually 0 or it's actually -9223372036854775808 (S64_MIN).=
 And
> > > often times it's important to know, especially when debugging trick=
y
> > > issues.
> >
> > +1
> >
> > >
> > > "Sort-of incorrectness" comes from mixing negative and positive val=
ues.
> > > E.g., if umin is some large positive number, it can be equal to smi=
n
> > > which is, interpreted as signed value, is actually some negative va=
lue.
> > > Currently, that smin will be omitted and only umin will be emitted =
with
> > > a large positive value, giving an impression that smin is also posi=
tive.
> > >
> > > Anyway, ambiguity is the biggest issue making it impossible to have=
 an
> > > exact understanding of register state, preventing any sort of autom=
ated
> > > testing of verifier state based on verifier log. This patch is
> > > attempting to rectify the situation by removing ambiguity, while
> > > minimizing the verboseness of register state output.
> > >
> > > The rules are straightforward:
> > >   - if some of the values are missing, then it definitely has a def=
ault
> > >   value. I.e., `umin=3D0` means that umin is zero, but smin is actu=
ally
> > >   S64_MIN;
> > >   - all the various boundaries that happen to have the same value a=
re
> > >   emitted in one equality separated sequence. E.g., if umin and smi=
n are
> > >   both 100, we'll emit `smin=3Dumin=3D100`, making this explicit;
> > >   - we do not mix negative and positive values together, and even i=
f
> > >   they happen to have the same bit-level value, they will be emitte=
d
> > >   separately with proper sign. I.e., if both umax and smax happen t=
o be
> > >   0xffffffffffffffff, we'll emit them both separately as
> > >   `smax=3D-1,umax=3D18446744073709551615`;
> > >   - in the name of a bit more uniformity and consistency,
> > >   {u32,s32}_{min,max} are renamed to {s,u}{min,max}32, which seems =
to
> > >   improve readability.
> >
> > agree.
> >
> > >
> > > The above means that in case of all 4 ranges being, say, [50, 100] =
range,
> > > we'd previously see hugely ambiguous:
> > >
> > >     R1=3Dscalar(umin=3D50,umax=3D100)
> > >
> > > Now, we'll be more explicit:
> > >
> > >     R1=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D50,smax=3Dumax=3Dsm=
ax32=3Dumax32=3D100)
> > >
> > > This is slightly more verbose, but distinct from the case when we d=
on't
> > > know anything about signed boundaries and 32-bit boundaries, which =
under
> > > new rules will match the old case:
> > >
> > >     R1=3Dscalar(umin=3D50,umax=3D100)
> >
> > Did you consider perhaps just always printing the entire set? Its ove=
rly
> > verbose I guess but I find it easier to track state across multiple
> > steps this way.
> =

> I didn't consider that because it's way too distracting and verbose
> (IMO) in practice. For one, those default values represent the idea
> "we don't know anything", so whether we see umax=3D18446744073709551615=

> or just don't see umax makes little difference in practice (though
> perhaps one has to come to realization that those two things are
> equivalent). But also think about seeing this:
> =

> smin=3D-9223372036854775807,smax=3D9223372036854775807,umin=3D0,umax=3D=
18446744073709551615,smin32=3D-2147483648,smax32=3D21474836487,umin32=3D0=
,umax32=3D4294967295

you could do,

smin=3DSMIN,smax=3DSMAX,umin=3D0,umax=3DUMAX,smin=3DSMIN,smax=3DSMAX,umin=
32=3D0,umax32=3DUMAX

but I see your point.

> =

> How verbose and distracting that is, and how much time would it take
> you to notice that this is not just "we don't know anything about this
> register", but that actually smin is not a default, it's S64_MIN+1.
> This is of course extreme example (I mostly wanted to show how verbose
> default output will be), but I think the point stands that omitting
> defaults brings out what extra information we have much better.
> =

> It's an option to do it for LOG_LEVEL_2, but I would still not do
> that, I'd find it too noisy even for level 2.

My $.02 just leave it as you have it here.

> =

> >
> > Otherwise patch LGTM.



