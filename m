Return-Path: <bpf+bounces-21714-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E14850688
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 22:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8111F21FC4
	for <lists+bpf@lfdr.de>; Sat, 10 Feb 2024 21:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8E75FDA4;
	Sat, 10 Feb 2024 21:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b="FUbnVO2j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1B13612E
	for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 21:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707601634; cv=none; b=kRFm12GkBGykZKo039ftl3da1Upyh+TGmdWWUeAXkfIZ8kWpk08tnlCjZp1mnFv55H3I1ZyxA6N3IyXVCtYkdEz3fskBZ3YmNpHozm9pv+6tBfL5pY0ktmgVBVYqg0ZarW0YHH3h0yWUSUl+Q/SbsecVGKyY+jrvOLxPg46st5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707601634; c=relaxed/simple;
	bh=fyNRvy9bRGBjrYR1bPAlZJp6O2ggurI82fvo2dmFciQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idt+SIocsx1timjd42w5UyeaulHJ0Q/OBguNQdjoxNa5CQR5hzTfiCMV801BOk/C3Q0glSODakZIaPjEbM7FhtxnoO2pF/9dPx0i4qqhInPBpreBkdSyKG7ymVFhl8wd6d1Q0jgLa4dJNCpRS3SDPEqmrx+9WKdaluzAk4/Zdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr; spf=none smtp.mailfrom=obs.cr; dkim=pass (2048-bit key) header.d=obs-cr.20230601.gappssmtp.com header.i=@obs-cr.20230601.gappssmtp.com header.b=FUbnVO2j; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=obs.cr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=obs.cr
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42c6e2f3aa2so1536211cf.2
        for <bpf@vger.kernel.org>; Sat, 10 Feb 2024 13:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=obs-cr.20230601.gappssmtp.com; s=20230601; t=1707601631; x=1708206431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AEpMK3KT1MsXa+SSX1BqR09ZNKqXqg4aHA0Fy+hmJU=;
        b=FUbnVO2j6aKlEM4Y0llWUWGgHB5v+fsfPEHIhZGV9oSGGQ+AmBv4TNKR9r2mNTAHB4
         2X46ZEpGp/UQuaR5h20gstgUjKprewNVEoqPfJJq1Y20lBF2y5FcPmN/puMt3tSApT8p
         ulQqbleKY1rafgOYZa6Oh0VrbtPe+YVOXrwx3Wj9NffQ4e5HODu4cmPjqy/xwEtQ6ves
         XVOFXEjoWLAwpiwuoAtI7CUVfT/HO9JEZ3QHUWn5U/H9qZhCKESWu65ZgvBl+AE0JT85
         gLsgJd3Dqtu5odhjsU0RgN3knJ/Dd5nU25eVsWx3DUNI6chwte3RN8xavEIhlri3j37o
         Tj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707601631; x=1708206431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AEpMK3KT1MsXa+SSX1BqR09ZNKqXqg4aHA0Fy+hmJU=;
        b=A408Cp79YU6bALGurqAKjsBxLXFSZovgZnLc/zzLs7860mF+sivCZzVqeDy2qVyzns
         hEIZC0LFZm4f3BmlLukGfPavF6rkH30pnahHNZmrzvgoOusJkF1bjb581driF9lwXKKf
         teS7hZSj55xdxnjG0ismquIKBFrDYaoXS+/u4RROQj3WddOQzmTdbsqGV225LwjRTzll
         CH+jcFkNQKrDRq80CeiBA9c/2tVrxd+AFIzvsMnwE9xNCOeS1KZ2gLCWr0Q3t8gEHcQh
         EBYZg0YkQLRajll3T/VNWYX2rDl4dpgjZAbgs4N9RtEM267uC+dW1v8q8xv5ehDwY5YR
         xoNw==
X-Gm-Message-State: AOJu0YxyTzkfiemNz3wYYmTXdg/PxaZkiWekNpSvr/EBRdI5WceXH90a
	3C4dR9Jp50kkn4CtDk6iAiFWJB6Z1+saguLw4RPG5aqeuvc6UjXqusVCjUWTyHQtRf4My9ya8Cm
	dxlNGPBdlqQGx0igEJ1joutof+TqjBIqKWhd2Kw==
X-Google-Smtp-Source: AGHT+IHlDZuPMMBBjQc3nR5gNC2dJsPA3L6hQs92W0YXWGP1fQZMKN3DtalgYVkMTz2ZpEWr6AjP4MfrkmpaWxWsRMU=
X-Received: by 2002:a0c:e1cf:0:b0:68c:6746:274f with SMTP id
 v15-20020a0ce1cf000000b0068c6746274fmr3377680qvl.47.1707601631209; Sat, 10
 Feb 2024 13:47:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208223237.12528-1-dthaler1968@gmail.com>
In-Reply-To: <20240208223237.12528-1-dthaler1968@gmail.com>
From: Will Hawkins <hawkinsw@obs.cr>
Date: Sat, 10 Feb 2024 16:47:00 -0500
Message-ID: <CADx9qWiOXUVwKK50Mqj7fUMGSxF7MEP9tJ93nzXWrbWcqAp0-w@mail.gmail.com>
Subject: Re: [Bpf] [PATCH bpf-next] bpf, docs: Add callx instructions in new
 conformance group
To: Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
Cc: bpf@vger.kernel.org, bpf@ietf.org, Dave Thaler <dthaler1968@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 5:32=E2=80=AFPM Dave Thaler
<dthaler1968=3D40googlemail.com@dmarc.ietf.org> wrote:
>
> * Add a "callx" conformance group
> * Add callx rows to table
> * Update helper function to section to be agnostic between BPF_K vs
>   BPF_X
> * Rename "legacy" conformance group to "packet"
>
> Based on mailing list discussion at
> https://mailarchive.ietf.org/arch/msg/bpf/l5tNEgL-Wo7qSEuaGssOl5VChKk/
>
> Signed-off-by: Dave Thaler <dthaler1968@gmail.com>
> ---
>  .../bpf/standardization/instruction-set.rst   | 32 ++++++++++++-------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Docu=
mentation/bpf/standardization/instruction-set.rst
> index bdfe0cd0e..8f0ada22e 100644
> --- a/Documentation/bpf/standardization/instruction-set.rst
> +++ b/Documentation/bpf/standardization/instruction-set.rst
> @@ -127,7 +127,7 @@ This document defines the following conformance group=
s:
>  * divmul32: includes 32-bit division, multiplication, and modulo instruc=
tions.
>  * divmul64: includes divmul32, plus 64-bit division, multiplication,
>    and modulo instructions.
> -* legacy: deprecated packet access instructions.
> +* packet: deprecated packet access instructions.
>
>  Instruction encoding
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -404,9 +404,12 @@ BPF_JSET  0x4    any  PC +=3D offset if dst & src
>  BPF_JNE   0x5    any  PC +=3D offset if dst !=3D src
>  BPF_JSGT  0x6    any  PC +=3D offset if dst > src        signed
>  BPF_JSGE  0x7    any  PC +=3D offset if dst >=3D src       signed
> -BPF_CALL  0x8    0x0  call helper function by address  BPF_JMP | BPF_K o=
nly, see `Helper functions`_
> +BPF_CALL  0x8    0x0  call_by_address(imm)             BPF_JMP | BPF_K o=
nly
> +BPF_CALL  0x8    0x0  call_by_address(reg_val(imm))    BPF_JMP | BPF_X o=
nly
>  BPF_CALL  0x8    0x1  call PC +=3D imm                   BPF_JMP | BPF_K=
 only, see `Program-local functions`_
> -BPF_CALL  0x8    0x2  call helper function by BTF ID   BPF_JMP | BPF_K o=
nly, see `Helper functions`_
> +BPF_CALL  0x8    0x1  call PC +=3D reg_val(imm)          BPF_JMP | BPF_X=
 only, see `Program-local functions`_
> +BPF_CALL  0x8    0x2  call_by_btfid(imm)               BPF_JMP | BPF_K o=
nly
> +BPF_CALL  0x8    0x2  call_by_btfid(reg_val(imm))      BPF_JMP | BPF_X o=
nly
>  BPF_EXIT  0x9    0x0  return                           BPF_JMP | BPF_K o=
nly
>  BPF_JLT   0xa    any  PC +=3D offset if dst < src        unsigned
>  BPF_JLE   0xb    any  PC +=3D offset if dst <=3D src       unsigned
> @@ -414,6 +417,12 @@ BPF_JSLT  0xc    any  PC +=3D offset if dst < src   =
     signed
>  BPF_JSLE  0xd    any  PC +=3D offset if dst <=3D src       signed
>  =3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> +where
> +
> +* reg_val(imm) gets the value of the register with the specified number
> +* call_by_address(value) means to call a helper function by address (see=
 `Helper functions`_ for details)
> +* call_by_btfid(value) means to call a helper function by BTF ID (see `H=
elper functions`_ for details)
> +

Could we say

* reg_val(imm) gets the value of the register specified by ``imm``
* call_by_address(value) means to call a helper function by address
specified by ``value`` (see `Helper functions`_ for details)
* call_by_btfid(value) means to call a helper function by BTF ID
specified by ``value`` (see `Helper functions`_ for details)

I'm not sure that it helps, but I thought I would offer the suggestion.

Otherwise, looks good to me!
Will



>  The BPF program needs to store the return value into register R0 before =
doing a
>  ``BPF_EXIT``.
>
> @@ -438,8 +447,9 @@ specified by the 'imm' field. A > 16-bit conditional =
jump may be
>  converted to a < 16-bit conditional jump plus a 32-bit unconditional
>  jump.
>
> -All ``BPF_CALL`` and ``BPF_JA`` instructions belong to the
> -base32 conformance group.
> +All ``BPF_CALL | BPF_X`` instructions belong to the callx
> +conformance group.  All other ``BPF_CALL`` instructions and all
> +``BPF_JA`` instructions belong to the base32 conformance group.
>
>  Helper functions
>  ~~~~~~~~~~~~~~~~
> @@ -447,13 +457,13 @@ Helper functions
>  Helper functions are a concept whereby BPF programs can call into a
>  set of function calls exposed by the underlying platform.
>
> -Historically, each helper function was identified by an address
> -encoded in the imm field.  The available helper functions may differ
> -for each program type, but address values are unique across all program =
types.
> +Historically, each helper function was identified by an address.
> +The available helper functions may differ for each program type,
> +but address values are unique across all program types.
>
>  Platforms that support the BPF Type Format (BTF) support identifying
> -a helper function by a BTF ID encoded in the imm field, where the BTF ID
> -identifies the helper name and type.
> +a helper function by a BTF ID, where the BTF ID identifies the helper
> +name and type.
>
>  Program-local functions
>  ~~~~~~~~~~~~~~~~~~~~~~~
> @@ -660,4 +670,4 @@ carried over from classic BPF. These instructions use=
d an instruction
>  class of BPF_LD, a size modifier of BPF_W, BPF_H, or BPF_B, and a
>  mode modifier of BPF_ABS or BPF_IND.  However, these instructions are
>  deprecated and should no longer be used.  All legacy packet access
> -instructions belong to the "legacy" conformance group.
> +instructions belong to the "packet" conformance group.
> --
> 2.40.1
>
> --
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

