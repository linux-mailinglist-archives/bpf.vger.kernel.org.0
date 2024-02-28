Return-Path: <bpf+bounces-22956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1B86BC37
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA901F23F2A
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83A70045;
	Wed, 28 Feb 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PstRv9fJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E3F13D30B
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163076; cv=none; b=l0B+hFSXs81q4haFzJIkPDf7QmbSLLkD/N/MV3ZsUcoD+0ykFqBWaWCr8uNqEluIslN20Mz9fM1YZJHYZDHzwbZNpiFFTy4nQJ9w5Mlv1E8N3SOtEIaIcKbe2Jb1SuJFltpOAa6ax+MKndqy5xqHXrtlmH2skbLf5WfepP9SatA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163076; c=relaxed/simple;
	bh=ljQmZKFNOsr2s0JCwN3Fu0aQ/JQSJxBIhRbqrdm/Fe4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XI9LBkluV5IOI6Iwgzk0y2WCySfgAD+Vv1JJ6W1z6MpcHcZ+NZuQLG+FOB6xfnmy7gO3qD1rlsXfvKueC6nzvageFXvRRnzpOoBs/UPyMJUSh8FteyxrvZgcm+i8WbrotbBoldy7YdDY3Xtk7dOURftHgmJUygFf7RS6HOhYX+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PstRv9fJ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2533089f6so3331191fa.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709163073; x=1709767873; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hy8113Ds10i0I6q22Znd9JXCH5jElvfAQWp8X1iAg/s=;
        b=PstRv9fJUywV/Pw9WL3QE6wo4AlSX/tzirwcCUDL6a8E2TGYwrOOS3eDg+SafSzsGu
         SFuNGwfm5gtpAizoefuthuoJZMFDO3Jd4S4nOdGB9af0WiBuOf/JEhPDusdriY18J9yu
         UUC91yT0dgFbNg3RqM6H2NLDL11A6q86KWNSXDgOPeRx2Fdnff1feszAhgnIz0QeQXQK
         SWydXDRIU25FNdoNCWKQjv1GHApMC+UP9DtZhhZs/YBRadLngqfq3AGrcTzKkqOPFKK6
         y/VnReARmrgStfK6grE/wJrcIphux1GgwoQ2pYyXE1J0lHCS0Pf3697FcqMo69HzqJ/V
         lPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709163073; x=1709767873;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy8113Ds10i0I6q22Znd9JXCH5jElvfAQWp8X1iAg/s=;
        b=UHC6zzuDEn8KO/EBBcuuM6YDfaGjSQp/Cfb216G3XcK3QGqHbvtfnekZMw9+k3xYln
         nsYXih7soxdtKYY0xRMeTdyFL8WcN1WhdtkKAisvHPng9N1rmd1OL41xVq89Ra/wRJi8
         /KypPnfNjSGu/38HDr3UZ/05rhqRp5xIZatn0W+2oYakTXKNOx79fzfaIPosgK4c4eD6
         84/s1QMnK/GTrsl5vsJqi3y+DFYHpHdRmqKugUw28k6jNAQCIiqZyapGYRku7UsaDgWp
         zT8O3+6hgR0nLED0A9WtkGcuZOdXJy2gt8qBfP9nKgFu6xJF33YE9DLDSPfZ65l8Wng9
         xwXg==
X-Gm-Message-State: AOJu0YxN+2z11SdeXpI8G0sFfVSSG/bajSgBqTn5G1XRnamtAskzI52z
	NStXEVCaMLSbSuR+R0hNCyfh43i0cMTV4aHWAiJ4dS7o82qb5VEd
X-Google-Smtp-Source: AGHT+IEbhsnNTwwEkz0zKUIfdkhKVLyyOHFV3RpXqOlkmmEQRp66hCGtt475i3b0Y1D15WeX7gLkAQ==
X-Received: by 2002:a2e:95d3:0:b0:2d2:abcf:1fd6 with SMTP id y19-20020a2e95d3000000b002d2abcf1fd6mr216444ljh.4.1709163072789;
        Wed, 28 Feb 2024 15:31:12 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s15-20020a2e81cf000000b002d0d945e729sm15550ljg.98.2024.02.28.15.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 15:31:12 -0800 (PST)
Message-ID: <a4db633f27c18d09f773eb68c55d77adb68ddc82.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to
 kernel BTF ids, not to local ids
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com
Date: Thu, 29 Feb 2024 01:31:11 +0200
In-Reply-To: <CAEf4BzZL3+g0cN9swTGkH4bZgSFm-McUAyYnpcKLTPMENnW9qw@mail.gmail.com>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-3-eddyz87@gmail.com>
	 <CAEf4BzZL3+g0cN9swTGkH4bZgSFm-McUAyYnpcKLTPMENnW9qw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-28 at 15:28 -0800, Andrii Nakryiko wrote:
[...]

> > @@ -1134,8 +1134,27 @@ static int bpf_map__init_kern_struct_ops(struct =
bpf_map *map)
> >=20
> >                         if (mod_btf)
> >                                 prog->attach_btf_obj_fd =3D mod_btf->fd=
;
> > -                       prog->attach_btf_id =3D kern_type_id;
> > -                       prog->expected_attach_type =3D kern_member_idx;
> > +
> > +                       /* if we haven't yet processed this BPF program=
, record proper
> > +                        * attach_btf_id and member_idx
> > +                        */
> > +                       if (!prog->attach_btf_id) {
> > +                               prog->attach_btf_id =3D kern_type_id;
> > +                               prog->expected_attach_type =3D kern_mem=
ber_idx;
> > +                       }
> > +
> > +                       /* struct_ops BPF prog can be re-used between m=
ultiple
> > +                        * .struct_ops & .struct_ops.link as long as it=
's the
> > +                        * same struct_ops struct definition and the sa=
me
> > +                        * function pointer field
> > +                        */
> > +                       if (prog->attach_btf_id !=3D kern_type_id ||
> > +                           prog->expected_attach_type !=3D kern_member=
_idx) {
> > +                               pr_warn("struct_ops reloc %s: cannot us=
e prog %s in sec %s with type %u attach_btf_id %u expected_attach_type %u f=
or func ptr %s\n",
>=20
> Martin already pointed out s/reloc/init_kern/, but I also find "cannot
> use prog" a bit too unactionable. Maybe "invalid reuse of prog"?
> "reuse" is the key here to point out that this program is used at
> least twice, and that in some incompatible way?

Ok, I'll change the wording.
And split the line despite the coding standards.

