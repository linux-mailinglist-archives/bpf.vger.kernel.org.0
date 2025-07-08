Return-Path: <bpf+bounces-62699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF44DAFD593
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 19:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EF954829FE
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 17:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375F2E62D5;
	Tue,  8 Jul 2025 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScBkgE01"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EC82DC33D;
	Tue,  8 Jul 2025 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751996346; cv=none; b=XRj7UtxnS7VGuzmcXt5jxMmiVNWg/mzke0M4S5WSzI/MOqqKnJyDlRS7g+JVbOZtpJn0zOyUFF4GIL+TU8iMpLqbKjLh4y+tr147HbHVgUzU/pzowKP6ZK+80+lk2MNBsBXZKJyn8MXIo970wFWW74gk6xhEKB/0D3t51BrKasQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751996346; c=relaxed/simple;
	bh=x2cUatXHX7xLPxvAV2RG5X+9WG2Zjf0Rso4cf3+eBRs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HI4da0EaxKWZR8AQBo4xFTn0QM7kqm9z+/7DLcWHd9lQg+Ihhf3d9ohK5DcQygSyeqlEl5HvfiGqaf/WeaQIe909JjiK0efDpQAE3DpZDcMwcKbvoxUNQ0vhKw5A1v8Mrot/iR25ZDrScFsxavRr1t72yn6WWeZWwwNeepttTtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScBkgE01; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-235a3dd4f0dso29687145ad.0;
        Tue, 08 Jul 2025 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751996344; x=1752601144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ClIZSmfHPjXZm8/f+h7U+319eUsl5U3L+I8Es+EzDW4=;
        b=ScBkgE015PNWI6Vq6/bZ9zj1yWyVeoEH5xSmO1FHi0tBrhthoIl+TyWhsOOiy/TJrZ
         VkoktoMLY70V5qfUEmGe6VJmvWEfbHP8KC5t4SIatv1gLw4faCS6NrnVxidVX7Y3QOFe
         RvH8oSJWSLYabxUjE+m8le15n4FbRCXy2y5evJetuea0jgxUUr4HvnIu7VxtmGXG7pk/
         vf1xSB4Vz0lXO8BnCtnYX/+FcHcWgWhc/kG3ue1R2eWtaB03Vmo+lpsvfHoV4hmq9slF
         s7XM/2yJtlZXl7ChIPpN0Jro6X+ISASW1k3dnpQnx8p4Wd+XljMWE+264Qpw/bF1cWhI
         9Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751996344; x=1752601144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClIZSmfHPjXZm8/f+h7U+319eUsl5U3L+I8Es+EzDW4=;
        b=ri51h4hz07w7UKhIt5Ub2bO8mS0rt1Pylj75Akat97Hv12E0DUmlCcLlL2Bnvq4jN0
         AAvynPZgPWbjV1QbxIKZ2Yj3mRLGLg5jEFMbqbeml1bEdOipERElcryh4u+YVnbKveoC
         T7d2iCpNPfiXxqfqAVdYp/m6YEDONPRGlGF5/QU3ymMXCM5oD3MZgWR25S2wiwiMzu0P
         YfSeL9Pdz3p6pvXzNsmvYSnduGwUGC8bxZWRx88ycI8lVURF86FcpMEY2OXr1BuIRhAB
         nYUSF6RI0Rql9eGplEAfMhDJZjJTsrtz7iq0MekpcpzOdUe4b47XD6+hL0jDz1KDUvjK
         q7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUABQyTELaasV27bXg9oi9EPeVASsEUMzAMRS6ijr+SR/B8TSPArVldQ5UqavN7UOGh3a1cjzs9lyi3M5YK@vger.kernel.org, AJvYcCVzuw69xf0az/RpuNrVSDV5SXM5KU7NFEzd/YfOja0a8P9LiDtxCId630QK144uycgFscs=@vger.kernel.org, AJvYcCXOrxxJM5H98aGElPhflF/KkIKbSKdL3ChOi+wVY+yrJyannOsVvLPdAJ9YLcwMuqMRqWkN7N6c@vger.kernel.org
X-Gm-Message-State: AOJu0YyPsFNVu1gN55dOxVvTbWCEkhXLOiTSjCm3c58dlbBkcxg7eRvT
	2YmcXuRXlFyLZcjAry8WHL/VHrUtfeE83DdSma1wzfdjYjG9sJlA0FDu
X-Gm-Gg: ASbGnctcd6xQ12Pog48yQAvXoqj9YSi66k3b/M6V+iBo9jwBXxrn6E/P9CVXMvKgt+e
	XkWf5nk/ubeQaI9/0Qoje/RFc3N7+L7/SMkxxsxZTOggUPhuJJGcn7EhHOkiE7jbAUyJ4LTIR4L
	7CvqFMt67eyMpHKv6YGnHwtm8ojWwW1b3p3vHV/oqxdB/EpRSiRd77mcEZEx9reniHrXvwoZ9f4
	O78BfNHlqxiovjY6JnX4AhVsV9i7du1roT9lcGcl+cZPJ/7G52W5arJa3xS+G0yGNMpJwI9yGlD
	bo2cU28lS1ozYAjMPK1kUVfT93p+CO9NtaOfNLDrxBhE2O0H1iTv0B7valPi5kH6MxwT
X-Google-Smtp-Source: AGHT+IFT1pxp1bRfM4fHER2ZOeDaIpqqQQY5SmraXSPbwq4KX6xdkbBPZwiRZuUjJ1aUnC9z9welWQ==
X-Received: by 2002:a17:902:fc87:b0:235:779:ede0 with SMTP id d9443c01a7336-23dd98cca97mr4544185ad.35.1751996343909;
        Tue, 08 Jul 2025 10:39:03 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:2404])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455ba80sm117549785ad.114.2025.07.08.10.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:39:03 -0700 (PDT)
Message-ID: <24a63d26171a49fa110fa7fff6d70f9e2b61a2fb.camel@gmail.com>
Subject: Re: [syzbot] [bpf?] WARNING in reg_bounds_sanity_check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, syzbot	
 <syzbot+c711ce17dd78e5d4fdcf@syzkaller.appspotmail.com>, Andrii Nakryiko	
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf	
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Hao Luo	
 <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>, Jiri Olsa	
 <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, LKML	
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Network Development <netdev@vger.kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Song Liu <song@kernel.org>,  syzkaller-bugs
 <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Date: Tue, 08 Jul 2025 10:39:00 -0700
In-Reply-To: <aG1FDHAu-H2oH4DY@mail.gmail.com>
References: <aGa3iOI1IgGuPDYV@Tunnel>
	 <865f2345eaa61afbd26d9de0917e3b1d887c647d.camel@gmail.com>
	 <aGgL_g3wA2w3yRrG@mail.gmail.com>
	 <df2cdc5f4fa16a4e3e08e6a997af3722f3673d38.camel@gmail.com>
	 <e43c25b451395edff0886201ad3358acd9670eda.camel@gmail.com>
	 <aGxKcF2Ceany8q7W@mail.gmail.com>
	 <2fb0a354ec117d36a24fe37a3184c1d40849ef1a.camel@gmail.com>
	 <c35d5392b961a4d5b54bdb4b92c4e104bd7857cc.camel@gmail.com>
	 <CAADnVQKKdpj-0wXKoKJC4uGhMivdr9FMYvMxZ6jLdPMdva0Vvw@mail.gmail.com>
	 <4ae6fd0d54ff2650d0f6724fb44b33723e26ea49.camel@gmail.com>
	 <aG1FDHAu-H2oH4DY@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 18:19 +0200, Paul Chaignon wrote:
> On Mon, Jul 07, 2025 at 05:57:32PM -0700, Eduard Zingerman wrote:
> > On Mon, 2025-07-07 at 17:51 -0700, Alexei Starovoitov wrote:
> > > On Mon, Jul 7, 2025 at 5:37=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > > >=20
> > > > On Mon, 2025-07-07 at 16:29 -0700, Eduard Zingerman wrote:
> > > > > On Tue, 2025-07-08 at 00:30 +0200, Paul Chaignon wrote:
>=20
> [...]
>=20
> > > > But I think the program below would still be problematic:
> > > >=20
> > > > SEC("socket")
> > > > __success
> > > > __retval(0)
> > > > __naked void jset_bug1(void)
> > > > {
> > > >         asm volatile ("                                 \
> > > >         call %[bpf_get_prandom_u32];                    \
> > > >         if r0 < 2 goto 1f;                              \
> > > >         r0 |=3D 1;                                        \
> > > >         if r0 & -2 goto 1f;                             \
> > > > 1:      r0 =3D 0;                                         \
> > > >         exit;                                           \
> > > > "       :
> > > >         : __imm(bpf_get_prandom_u32)
> > > >         : __clobber_all);
> > > > }
> > > >=20
> > > > The possible_r0 would be changed by `if r0 & -2`, so new rule will =
not hit.
> > > > And the problem remains unsolved. I think we need to reset min/max
> > > > bounds in regs_refine_cond_op for JSET:
> > > > - in some cases range is more precise than tnum
> > > > - in these cases range cannot be compressed to a tnum
> > > > - predictions in jset are done for a tnum
> > > > - to avoid issues when narrowing tnum after prediction, forget the
> > > >   range.
> > >=20
> > > You're digging too deep. llvm doesn't generate JSET insn,
> > > so this is syzbot only issue. Let's address it with minimal changes.
> > > Do not introduce fancy branch taken analysis.
> > > I would be fine with reverting this particular verifier_bug() hunk.
>=20
> Ok, if LLVM doesn't generate JSETs, I agree there's not much point
> trying to reduce false positives. I like Eduard's solution below
> because it handles the JSET case without removing the warning. Given
> the number of crashes syzkaller is generating, I suspect this isn't
> only about JSET, so it'd be good to keep some visibility into invariant
> violations.

I suspect similar problems might be found in any place where tnum
operations are used to narrow the range. E.g. if a repro for JSET
would be found, same repro might be applicable to BPF_AND.

In general, it might be the case we should not treat out of sync
bounds as an error. Assuming that tnum and bounds based ranges have
different precision in different scale regions, situations when
one bound is changed w/o changing another can be legit. E.g.:

                              ____ bounds range ____
                             /                      \
0 --------------------------------------------------------- MAX
    \___________________________________________________/
          tnum range

Narrowing only tnum:
                              ____ bounds range ____
                             /                      \
0 --------------------------------------------------------- MAX
    \___________________/
          tnum range

This does not highlight an error, but a difference in expressive power
for specific values.

> > My point is that the fix should look as below (but extract it as a
> > utility function):
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 53007182b46b..b2fe665901b7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16207,6 +16207,14 @@ static void regs_refine_cond_op(struct bpf_reg=
_state *reg1, struct bpf_reg_state
> >                         swap(reg1, reg2);
> >                 if (!is_reg_const(reg2, is_jmp32))
> >                         break;
> > +               reg1->u32_max_value =3D U32_MAX;
> > +               reg1->u32_min_value =3D 0;
> > +               reg1->s32_max_value =3D S32_MAX;
> > +               reg1->s32_min_value =3D S32_MIN;
> > +               reg1->umax_value =3D U64_MAX;
> > +               reg1->umin_value =3D 0;
> > +               reg1->smax_value =3D S64_MAX;
> > +               reg1->smin_value =3D S32_MIN;
>=20
> Looks like __mark_reg_unbounded :)

I suspected there should be something already :)

> I can send a test case + __mark_reg_unbounded for BPF_JSET | BPF_X in
> regs_refine_cond_op. I suspect we may need the same for the BPF_JSET
> case as well, but I'm unable to build a repro for that so far.

Please go ahead.

>=20
> >                 val =3D reg_const_value(reg2, is_jmp32);
> >                 if (is_jmp32) {
> >                         t =3D tnum_and(tnum_subreg(reg1->var_off), tnum=
_const(~val));
> >=20
> > ----
> >=20
> > Because of irreconcilable differences in what can be represented as a
> > tnum and what can be represented as a range.

