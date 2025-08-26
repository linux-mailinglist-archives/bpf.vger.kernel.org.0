Return-Path: <bpf+bounces-66556-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88DB36F91
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 18:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938D9467863
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 16:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DE3302767;
	Tue, 26 Aug 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIIy6UDi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB5185B48
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224252; cv=none; b=i4y9qkp2Cax/o9tzVrQ33ytE+22mIlrmJH4M1Ec494knT3sY6ZkI5I0/GN5BUG7IyVR0Mu1URxOVnoxzx6lOvKfuNzSm5apSO4EZRPuVq2bADsXUBZxrNpemArZqPAWY9AD2aSr2mEXc/W1/HqXvM0HHuU6jCTwhv4KwmPiVbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224252; c=relaxed/simple;
	bh=KkZNswNqRBBaoBLL2z0u3h5khBzgL+B6l8omekGGnng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ish7AOz1wQgdUv0DUX4QcyAljs5Bzida6B3g7XClSdbiq7iOxZQy/TyxF+M52Hvze8nxkBnRlX2rZ1BLSdVRpiBS0yKfByCTpvmssJKirTWd4ARA6vcLroUcuN8yEXCxVYeMHrmJTEJpsEXVeGZ0iXRqgE10QVsVnZ4RF8qYH4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIIy6UDi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b47174c8e45so5592002a12.2
        for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 09:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756224250; x=1756829050; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bjk3YuWmhKID4xBBmpckqPYQJJ78+hQiLwkiJk2QtsQ=;
        b=XIIy6UDibVOUHENL7MNJD2xJlNq6HqHrl0XQV8I6vPWpATvv7EQOC6/O0F4ZA2eGOK
         vcn7FHTpgqXds7i26z0Va1GQ8fjyDDsK3IzEG5ukPuhngVQxCxe9qV252VAgDw3JbrkQ
         nhLKPA0RnJQk+TXUPTLbyP5xG3deB82oJose085n7Mu0ScVVkBfIaT6sMZnZZP9QJsRH
         VS+b8oVRZqvy4fCPzto0QlO0S/C8UqEMF0mIeqbW/S2ixLV7esVkE3degcPQvaX2Xkob
         y6r2kHcQKoAHoJoHJ69UjOodCncqVpqmrhXBQ23HRxOd2qJnogRaucQKmGGeDJh4aB7j
         Yecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224250; x=1756829050;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjk3YuWmhKID4xBBmpckqPYQJJ78+hQiLwkiJk2QtsQ=;
        b=wWhdDWrOs02wvvDcnEzxcUYr/CUJ9dZ2oO3JHMf1AIi4HcxYK4TZHQAXmnPkHaXrfx
         5HSnqKwHAaM7WE6+qv4hTfweQvCdkoUM+LZCHdR1PpUnnYCV39djyliyE+OnIvgWPPL5
         StGltg3GUK157UFnZlOeFbCyI9Sfnatg4SHyaD0MwFLQ6LiLVXw7ETwjjW33xWt9roB3
         4ziC+au67hHp0OMLXVgiarPAB3LNrqsHqTCJD5QDKRtZmv5wS/F/Xze1V9sNSig7sh2B
         bk49Dg6k+TJli0bs0Pl/LAGYYYaYocB3uPctwL0iesIT9GbYjQhWhDrZ0Qu7OG73EDW0
         lSlg==
X-Gm-Message-State: AOJu0Yx4pqmsEG/BCVmyTAMbwqQ6J3dlvjQafsvsmd0pskiVKg/amb+6
	n3CuSvNfw7sDTweAFTA/oUTBu8wOCv1hE6FYQPaE3hIq3R0y6mHXhogF
X-Gm-Gg: ASbGncvaNK7ssNnzzxZD2olgpIKBsKRRw6mOv6yxWUHbmAK8RhWGOwmtCHxVw1oc+dc
	75Bv8qlGVXzwfl/8hvwB2CvGWJdaoJrNsuv6bQxd44i3a82IhZgXpYqap+wxDvxtfBohnINafQg
	rEqCBzY0FKpo4LyID6hGMYn5Co75C0qh0tAlIfcRSPQreNlie7t5AZlw/0HYGbWWfwPb3G4dumy
	0EqMLXvKkdz9pTRnt2x/bzq2FhJUPvYRK5sgHhKOxiE8fsdzdiDQlm7tOLCAhck6aqm1ULBYjCr
	EnuwHAZihcTDntezMBemjOm4a6XmrTcnEaZU4NPSaHIBFBGnDYvjm781WHX5NvHRgUAb99i30rK
	e28h5B+VbGby8wBMZHx4=
X-Google-Smtp-Source: AGHT+IHKbaeS73KQUwhF4xvnvK6wXDdXfHl/v/jC+eA1xrwBTgo1H0pFzEFVSgnOdtNp1/nWPdu9Zw==
X-Received: by 2002:a17:903:4b48:b0:246:2afa:4cc with SMTP id d9443c01a7336-2462ef67771mr230110025ad.42.1756224250101;
        Tue, 26 Aug 2025 09:04:10 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32750bc341asm1737363a91.19.2025.08.26.09.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 09:04:09 -0700 (PDT)
Message-ID: <88fcbb6e482a4d41e5eeaaae385d397827b58d3f.camel@gmail.com>
Subject: Re: [PATCH v1 bpf-next 03/11] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>
Date: Tue, 26 Aug 2025 09:04:02 -0700
In-Reply-To: <aK3YRDJyZOYU9LTW@mail.gmail.com>
References: <20250816180631.952085-1-a.s.protopopov@gmail.com>
	 <20250816180631.952085-4-a.s.protopopov@gmail.com>
	 <8443ca8f17708fa22a3f3b60018513735b6dff5b.camel@gmail.com>
	 <aK3YRDJyZOYU9LTW@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 15:52 +0000, Anton Protopopov wrote:
> On 25/08/25 02:05PM, Eduard Zingerman wrote:
> > On Sat, 2025-08-16 at 18:06 +0000, Anton Protopopov wrote:
> >=20
> > [...]
> >=20
> > > --- /dev/null
> > > +++ b/kernel/bpf/bpf_insn_array.c
> >=20
> > [...]
> >=20
> > > +int bpf_insn_array_ready(struct bpf_map *map)
> > > +{
> > > +	struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> > > +	guard(mutex)(&insn_array->state_mutex);
> > > +	int i;
> > > +
> > > +	for (i =3D 0; i < map->max_entries; i++) {
> > > +		if (insn_array->ptrs[i].user_value.xlated_off =3D=3D INSN_DELETED)
> > > +			continue;
> > > +		if (!insn_array->ips[i]) {
> > > +			/*
> > > +			 * Set the map free on failure; the program owning it
> > > +			 * might be re-loaded with different log level
> > > +			 */
> > > +			insn_array->state =3D INSN_ARRAY_STATE_FREE;
> > > +			return -EFAULT;
> >=20
> > This shouldn't happen, right?
> > If so, maybe use verifier_bug here with some description?
> > (and move bpf_insn_array_ready() call to verifier.c:bpf_check(),
> >  so that the log pointer is available).
>=20
> Shouldn't happen. But, unfortunately, only after
> bpf_prog_select_runtime() which is executed after bpf_check(). Might
> be nice to allow jit/bpf_prog_select_runtime to use the verifier
> environment.

The insn_array->ips array is filled by bpf_jit_comp.c:do_jit() ->
bpf_insn_array.c:bpf_prog_update_insn_ptr().

My initial thinking was that do_jit() is invoked by the following chain:
verifier.c:bpf_check() -> fixup_call_args() -> jit_subprogs().
Hence it appeared possible to move the above check/call to
bpf_insn_array_ready to bpf_check() itself.
However, looking at jit_subprogs() now I see:

        ...
        if (env->subprog_cnt <=3D 1)
                return 0;
        ...
	<proceeds jiting all subprogs including main>

So, it looks like the case when only main subprogram is present is
special. Oh, well.

> (Not 100% similar, but related to blinding part of this series:
> blinding is happening as the very first step of every jit (initially
> was implemented for x86, and then copy/pasted to everywhere else).
> Might be nice to move it to be one of the last stages of verifier,
> then code is shared and env is available as well. For this series I
> had to add a bit of custom code to support instruction arrays at this
> blinding stage.)
>=20
> > > +		}
> > > +	}
> > > +
> > > +	insn_array->state =3D INSN_ARRAY_STATE_READY;
> > > +	return 0;
> > > +}
> >=20
> > [...]

