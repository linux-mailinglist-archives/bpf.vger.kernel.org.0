Return-Path: <bpf+bounces-67070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16AB3D63B
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 03:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04BE31892A9C
	for <lists+bpf@lfdr.de>; Mon,  1 Sep 2025 01:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF0E1DF24F;
	Mon,  1 Sep 2025 01:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAOCAr5L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B8C34CDD;
	Mon,  1 Sep 2025 01:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756689047; cv=none; b=IfnCebkdeMK7TuyyVebRbx137IsZsFYGAp8CFbKa49yLTxp6Ve/BYr473ZqQ+wH2vUIfIolKlOJVEsqKnBEMHDmaJVNgOzhXqSDD3Hzs5JjSSU2lUD2X41sTph/L011TjNRyRxx98xn7Lf7J8sgoRHN0OuwK/ytJu+Vc3zqmCmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756689047; c=relaxed/simple;
	bh=67fkbb7ZY36ML1ItRj3mwkTL4ApN+NR1yaW2Cv7HSeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWjW13JVMas7ORFIDBZgrIH9JxcoT03FUhk5oIVY+HqTg1Qa4YsvsoO8KWUsJ+YAPyeiO+lNPaUgSd57mORMNpHL9CFyxIEATuO+kBae9XAWFrVX2yBYYdBp2WLSJWA+XhVQ8nDd8E5B51xgD1Br+gSiwkVCEzP4PybwhuSSZNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAOCAr5L; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso4054505e9.2;
        Sun, 31 Aug 2025 18:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756689044; x=1757293844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvKpDr/mytKtCWZ1X7UmuiPBBiC+Em5d9FB4Bvq56IU=;
        b=aAOCAr5LjcXXqscmtg4cUFkcrXDUVHWx1RcujivayMVHgV5H7Zvs3WN4qGedU7TBrH
         rIS3QnjptWsSF62vm30prEYPHkkjbzw2x2tF/mHZwv80kFdrfFHB5KrmQQ1RifP5mLaC
         fq0qPMYyKp52x/BB0Ysecx/3FedaCjyqduXsx09I383AVugtVnSPcTZxpmnqKgTm1rFG
         YXnBYZOrbNBdnFLUXqBV907Wl3cIyGG3hlXeuXm1KytSEUTQR0xUB7SsGcjPHUK5OB5l
         5IDyR5nsbSt2hRsFzTQYtffUsbMFiQ6ZN3AGDiUR/LxZMVyV+6Feknocw23ppY5xcMdP
         WL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756689044; x=1757293844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvKpDr/mytKtCWZ1X7UmuiPBBiC+Em5d9FB4Bvq56IU=;
        b=Q/UbPDVNKW+b+wH4z1QeKf73De7VUeNd+OAwBPwwSDSiI/fkjY1WkD6/QAJTt/iNli
         rD4EYEwVC666X5Gy1UxDUaJwboaYGZzfy1CjV0SX2m7q7kZ4cBrNQgmCk58QVSNtyaAW
         +FaRStRxz12ZW3cSYBdTtZ5Zkb/QZjjYrYe00o79XHf7mx4LgebvAlQpTPxaMQvc/t0p
         lIlF5GSiWAm2d9yCkFmBcLbL8E4uvWc/02LWr5ZrGT3JcVYw5wX++ogxlOTjLRB91sxB
         qJmQd+fuNDRDOUSl5cG32XVtp5pjhhA30o2qznxNiMaxpVye/bBl0h2Lnai0S3QgdpQ4
         /t+w==
X-Forwarded-Encrypted: i=1; AJvYcCVc0LqYSUpk1ZkMihfsAkQ+EMEhLhI70Ak6JV+lR6kwAcurmirq4bNa/a4IUp9qqtiDPGzqdS9bCvL8FnMj@vger.kernel.org, AJvYcCWHGUZZ5PV8dQnQII+8O8lYD7nJhsW/F+HJQQV9JuCJhJD1h7IL4AvJi7OsRvg0lXHuH2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeox5uSBDL1AvrgBF7WuqqYYVUisojqMcNYr+gapuqfzgAuLbl
	B/yITTt2ye03X30YUjbgdIETazKxGr2dkLJbrN3znAooZN9PWRTFuIR4De7K+FD9sApK3K2An8l
	BZ/6PK1k2Of/yavAXB+s3RtbdumrmUBo=
X-Gm-Gg: ASbGncvHR4f1pVaFThWgSHzREqgFgGZPRKj2d5NOgOb/r7PBbMalhYAte99aRkWFZ88
	PK+R0Flsl5Afodyyh3Pk0JDt32ecD36++DJIS6GKV+0Kvp1dGQainWtYDLxYhsmYB96HU3m+5t4
	ZKTYgV8i/N5utri7oNAKCzpM3ZkhR64eNLYi3n8RMTjkGUQQT5Shol7ZkIR5/txYOD/sXzRSpsK
	Kgh49NRYdJ1apmJpjHroLe7U42rLSfT23He
X-Google-Smtp-Source: AGHT+IG8A8wartjnQjHniRoB3M6NtN2qK9c/QbFY1hoyhuNF9ObPY0h6ugB0alk5AKaHy+jyu+IzqmTRlkRVG6j+BDc=
X-Received: by 2002:a05:600d:108:20b0:459:dde3:1a55 with SMTP id
 5b1f17b1804b1-45b855fbbc7mr35663025e9.24.1756689043703; Sun, 31 Aug 2025
 18:10:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826212229.143230-1-contact@arnaud-lcm.com>
 <20250826212352.143299-1-contact@arnaud-lcm.com> <CAADnVQ+6bV3h3i-A1LHbEk=nY_PMx69BiogWjf5GtGaLxWSQVg@mail.gmail.com>
 <CAPhsuW5P4sOHmMCmVTZw2vfuz7Rny-xkhuPkRBitfoATQkm=eA@mail.gmail.com>
 <CAADnVQK=3xigzt-pCat5OF29xT_F7-5rXDOMG+_FLSS0jRoWsQ@mail.gmail.com> <c2d982c2-9593-4ac7-91d6-635b94f52d4e@arnaud-lcm.com>
In-Reply-To: <c2d982c2-9593-4ac7-91d6-635b94f52d4e@arnaud-lcm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 Aug 2025 18:10:31 -0700
X-Gm-Features: Ac12FXwR1CCl1aj4LyGNiWlbVmEnkf3k1wbgBBIYa1YYuhw18s1eGfFHPMojPnQ
Message-ID: <CAADnVQJ8+xSJDnQeOQV=pT=oML37x=KygETGnA6AWJn=fEBFnw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/2] bpf: fix stackmap overflow check in __bpf_get_stackid()
To: "Lecomte, Arnaud" <contact@arnaud-lcm.com>
Cc: Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, syzbot+c9b724fbb41cf2538b7b@syzkaller.appspotmail.com, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 10:13=E2=80=AFAM Lecomte, Arnaud <contact@arnaud-lc=
m.com> wrote:
>
>
> On 30/08/2025 02:28, Alexei Starovoitov wrote:
> > On Fri, Aug 29, 2025 at 11:50=E2=80=AFAM Song Liu <song@kernel.org> wro=
te:
> >> On Fri, Aug 29, 2025 at 10:29=E2=80=AFAM Alexei Starovoitov
> >> <alexei.starovoitov@gmail.com> wrote:
> >> [...]
> >>>>   static long __bpf_get_stackid(struct bpf_map *map,
> >>>> -                             struct perf_callchain_entry *trace, u6=
4 flags)
> >>>> +                             struct perf_callchain_entry *trace, u6=
4 flags, u32 max_depth)
> >>>>   {
> >>>>          struct bpf_stack_map *smap =3D container_of(map, struct bpf=
_stack_map, map);
> >>>>          struct stack_map_bucket *bucket, *new_bucket, *old_bucket;
> >>>> @@ -263,6 +263,8 @@ static long __bpf_get_stackid(struct bpf_map *ma=
p,
> >>>>
> >>>>          trace_nr =3D trace->nr - skip;
> >>>>          trace_len =3D trace_nr * sizeof(u64);
> >>>> +       trace_nr =3D min(trace_nr, max_depth - skip);
> >>>> +
> >>> The patch might have fixed this particular syzbot repro
> >>> with OOB in stackmap-with-buildid case,
> >>> but above two line looks wrong.
> >>> trace_len is computed before being capped by max_depth.
> >>> So non-buildid case below is using
> >>> memcpy(new_bucket->data, ips, trace_len);
> >>>
> >>> so OOB is still there?
> >> +1 for this observation.
> >>
> >> We are calling __bpf_get_stackid() from two functions: bpf_get_stackid
> >> and bpf_get_stackid_pe. The check against max_depth is only needed
> >> from bpf_get_stackid_pe, so it is better to just check here.
> > Good point.
> Nice catch, thanks !
> >
> >> I have got the following on top of patch 1/2. This makes more sense to
> >> me.
> >>
> >> PS: The following also includes some clean up in __bpf_get_stack.
> >> I include those because it also uses stack_map_calculate_max_depth.
> >>
> >> Does this look better?
> > yeah. It's certainly cleaner to avoid adding extra arg to
> > __bpf_get_stackid()
> >
> Are Song patches going to be applied then ?  Or should I raise a new
> revision
>   of the patch with Song's modifications with a Co-developped tag ?

Pls resubmit and retest with a tag.

