Return-Path: <bpf+bounces-12067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB347C7508
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 19:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA41C1C20FF5
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6572536B1B;
	Thu, 12 Oct 2023 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaeLxGj/"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2BDD2EE
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 17:45:58 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A5ECA
	for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 10:45:56 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso2173321a12.1
        for <bpf@vger.kernel.org>; Thu, 12 Oct 2023 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697132754; x=1697737554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0ZwkkR7osHQvvjFE34MWIuyBeRq/0LPKkLjfSC2xE8=;
        b=FaeLxGj/WwRxs36ORlPy5ty5v7TVwBpsyo9ubWGlPoRRPexq1fRo0sREaR669XvAB9
         QL9oa9I3C6tiQTOnS2GzVSG/LDKO5HJx1US9AYroFH2P4SELips0jJTTfAuW4HU6JwrB
         XBfW+FhnoOE8ycz2DG2XdaJwQG9eFPBg9S6tn9ucLDw4jskU7Y4wjA60Hqq1XyVFJyCs
         9Wo96Ol6TJcVGurONMTml+uIkFK7ji9VI0cKM4poRGl0EYW0Rk1JSY5bfMx7AB3lwjy2
         JjSNBldvl5k3SJZBpg30u54bq04sAXHSVdGZN3WUNqJd0G7Lgdd0gCh76ona1N5SxWAs
         mmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697132754; x=1697737554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0ZwkkR7osHQvvjFE34MWIuyBeRq/0LPKkLjfSC2xE8=;
        b=jPTTxdRPH4jtd2EMjf61zfZG8n5qGahTPOMrAtadlYBVvaqNdptsOopsv45eP3V0T+
         V9BdJ/gB7m6h4ORVWQofwfNsAYuCeM2IeeCMnn9FtumDpTVxa81BXHx3kJrjp2Jqkj2z
         wpXw0kD8LL284vUelek/gnWsXcGynIfCtX2MzxrRbXUdxeQB3tjytWnkZVuHwolh8V1U
         mY6X5nqvkTUZRL5n09y842AgJEw1sdp83W8wrP6y1FujOHLZRjXRUpYyEp+eBK73oooO
         32A304mM/cwoSZLR6/mh1c3lfbKakqul9tPT2bb7OBZoCWNg7COehTD9MVRHqfDSbk8F
         HTcg==
X-Gm-Message-State: AOJu0YzBGeCHDRNLDtjuzbDGiZg098rHSwflFRRAXk9PfCfBX5IptVKS
	ugE/0y6OvBY4GJQpTTe5d9YKvsHGv7ZR0pOPYTI2IIhi
X-Google-Smtp-Source: AGHT+IGpwrSxfl8vqiwgQD+VC71w5LACGQaJywY4kLt13j35NO4o1q5bLR/icy1ZZKGJpn2mpoSbGqaRREzozjqKQjM=
X-Received: by 2002:a05:6402:22b0:b0:53d:bb21:4d90 with SMTP id
 cx16-20020a05640222b000b0053dbb214d90mr4801166edb.40.1697132754451; Thu, 12
 Oct 2023 10:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011223728.3188086-1-andrii@kernel.org> <20231011223728.3188086-5-andrii@kernel.org>
 <65278534a3cb0_4a01020845@john.notmuch> <CAEf4BzaZx3_wGXqXBFt_Y4z+2L9XF7krNan4ZN4DQ0uLLXOf_Q@mail.gmail.com>
 <652825f6df713_5644208f2@john.notmuch>
In-Reply-To: <652825f6df713_5644208f2@john.notmuch>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Oct 2023 10:45:42 -0700
Message-ID: <CAEf4BzYTRmjoDjHtJJH41WJXjDRSkv7KT3xOr6xb7VUsc0J8kA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpf: disambiguate SCALAR register state
 output in verifier logs
To: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 9:59=E2=80=AFAM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Andrii Nakryiko wrote:
> > On Wed, Oct 11, 2023 at 10:33=E2=80=AFPM John Fastabend
> > <john.fastabend@gmail.com> wrote:
> > >
> > > Andrii Nakryiko wrote:
> > > > Currently the way that verifier prints SCALAR_VALUE register state =
(and
> > > > PTR_TO_PACKET, which can have var_off and ranges info as well) is v=
ery
> > > > ambiguous.
> > > >
> > > > In the name of brevity we are trying to eliminate "unnecessary" out=
put
> > > > of umin/umax, smin/smax, u32_min/u32_max, and s32_min/s32_max value=
s, if
> > > > possible. Current rules are that if any of those have their default
> > > > value (which for mins is the minimal value of its respective types:=
 0,
> > > > S32_MIN, or S64_MIN, while for maxs it's U32_MAX, S32_MAX, S64_MAX,=
 or
> > > > U64_MAX) *OR* if there is another min/max value that as matching va=
lue.
> > > > E.g., if smin=3D100 and umin=3D100, we'll emit only umin=3D10, omit=
ting smin
> > > > altogether. This approach has a few problems, being both ambiguous =
and
> > > > sort-of incorrect in some cases.
> > > >
> > > > Ambiguity is due to missing value could be either default value or =
value
> > > > of umin/umax or smin/smax. This is especially confusing when we mix
> > > > signed and unsigned ranges. Quite often, umin=3D0 and smin=3D0, and=
 so we'll
> > > > have only `umin=3D0` leaving anyone reading verifier log to guess w=
hether
> > > > smin is actually 0 or it's actually -9223372036854775808 (S64_MIN).=
 And
> > > > often times it's important to know, especially when debugging trick=
y
> > > > issues.
> > >
> > > +1
> > >
> > > >
> > > > "Sort-of incorrectness" comes from mixing negative and positive val=
ues.
> > > > E.g., if umin is some large positive number, it can be equal to smi=
n
> > > > which is, interpreted as signed value, is actually some negative va=
lue.
> > > > Currently, that smin will be omitted and only umin will be emitted =
with
> > > > a large positive value, giving an impression that smin is also posi=
tive.
> > > >
> > > > Anyway, ambiguity is the biggest issue making it impossible to have=
 an
> > > > exact understanding of register state, preventing any sort of autom=
ated
> > > > testing of verifier state based on verifier log. This patch is
> > > > attempting to rectify the situation by removing ambiguity, while
> > > > minimizing the verboseness of register state output.
> > > >
> > > > The rules are straightforward:
> > > >   - if some of the values are missing, then it definitely has a def=
ault
> > > >   value. I.e., `umin=3D0` means that umin is zero, but smin is actu=
ally
> > > >   S64_MIN;
> > > >   - all the various boundaries that happen to have the same value a=
re
> > > >   emitted in one equality separated sequence. E.g., if umin and smi=
n are
> > > >   both 100, we'll emit `smin=3Dumin=3D100`, making this explicit;
> > > >   - we do not mix negative and positive values together, and even i=
f
> > > >   they happen to have the same bit-level value, they will be emitte=
d
> > > >   separately with proper sign. I.e., if both umax and smax happen t=
o be
> > > >   0xffffffffffffffff, we'll emit them both separately as
> > > >   `smax=3D-1,umax=3D18446744073709551615`;
> > > >   - in the name of a bit more uniformity and consistency,
> > > >   {u32,s32}_{min,max} are renamed to {s,u}{min,max}32, which seems =
to
> > > >   improve readability.
> > >
> > > agree.
> > >
> > > >
> > > > The above means that in case of all 4 ranges being, say, [50, 100] =
range,
> > > > we'd previously see hugely ambiguous:
> > > >
> > > >     R1=3Dscalar(umin=3D50,umax=3D100)
> > > >
> > > > Now, we'll be more explicit:
> > > >
> > > >     R1=3Dscalar(smin=3Dumin=3Dsmin32=3Dumin32=3D50,smax=3Dumax=3Dsm=
ax32=3Dumax32=3D100)
> > > >
> > > > This is slightly more verbose, but distinct from the case when we d=
on't
> > > > know anything about signed boundaries and 32-bit boundaries, which =
under
> > > > new rules will match the old case:
> > > >
> > > >     R1=3Dscalar(umin=3D50,umax=3D100)
> > >
> > > Did you consider perhaps just always printing the entire set? Its ove=
rly
> > > verbose I guess but I find it easier to track state across multiple
> > > steps this way.
> >
> > I didn't consider that because it's way too distracting and verbose
> > (IMO) in practice. For one, those default values represent the idea
> > "we don't know anything", so whether we see umax=3D18446744073709551615
> > or just don't see umax makes little difference in practice (though
> > perhaps one has to come to realization that those two things are
> > equivalent). But also think about seeing this:
> >
> > smin=3D-9223372036854775807,smax=3D9223372036854775807,umin=3D0,umax=3D=
18446744073709551615,smin32=3D-2147483648,smax32=3D21474836487,umin32=3D0,u=
max32=3D4294967295
>
> you could do,
>
> smin=3DSMIN,smax=3DSMAX,umin=3D0,umax=3DUMAX,smin=3DSMIN,smax=3DSMAX,umin=
32=3D0,umax32=3DUMAX
>
> but I see your point.

Heh, SMIN/SMAX and other "symbolic constants" is not a bad idea, yes.
I actually have a rather big patch set coming up for testing range
bounds tracking, and there I went even further, both having
S64_MIN/MAX, etc, but also printing in hex vs decimal depending on how
big or small is the actual value. It seems super useful and intuitive
in practice (I did it in a selftests, not in the kernel, but the point
stands).

But I think this is a completely separate discussion and with my
changes to make printing of range a bit more generic it should be now
even easier to do. But let's not do too much at the same time.

>
> >
> > How verbose and distracting that is, and how much time would it take
> > you to notice that this is not just "we don't know anything about this
> > register", but that actually smin is not a default, it's S64_MIN+1.
> > This is of course extreme example (I mostly wanted to show how verbose
> > default output will be), but I think the point stands that omitting
> > defaults brings out what extra information we have much better.
> >
> > It's an option to do it for LOG_LEVEL_2, but I would still not do
> > that, I'd find it too noisy even for level 2.
>
> My $.02 just leave it as you have it here.

Sounds good :)

>
> >
> > >
> > > Otherwise patch LGTM.
>
>

