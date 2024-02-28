Return-Path: <bpf+bounces-22935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13986BA20
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 22:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7DBB284F20
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F205570041;
	Wed, 28 Feb 2024 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI2aiOIK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F470020
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156467; cv=none; b=dQiRmp0P4j8JwHrHlab+E8prFlohj7xJCdvwUACjSdqu2aP/c6j3gvJ4Vzxphg9bR+Fc3ZI9F6qrn93XSRsSvr4QCWZOhzSLT1iwAxd6iRRJnV3N58R+jj5jktJrQF/wJqlkp6M+TGejTbPehrTfJgOue47WHGDSSiST6fvSh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156467; c=relaxed/simple;
	bh=zk3L+ib1rohDJHANhUmHUliYLZc5GJTi9/m2BHH72jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DzPciCeBQ3pkdFXDAJlsDOH7dDU/8atKQf8T/8JEuMYXvRrH2juRLkBWUcutr9VJxQQtWnfVAahbGVmi17R/plYSnaejyeq10DMFYRiNbSW1zt5/0Fi05SeYrc65F8jxkipRO5oeEn+EvnQtTxvQIkls0Ymi0KKYnp6uTmunYpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI2aiOIK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc9222b337so2951755ad.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 13:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709156465; x=1709761265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCM+8uN6bk+iNHms7/4W48UoMexoT+a1OO7dxqBgfwc=;
        b=lI2aiOIK8aLOCZr3iukmgFJLDwXnTnvdL95vwKkh9iS1cwKwpSs/gmpynaaNKBK19v
         l5asq5YBMSVig4t1XF9XVuaBFpLKIHOBH3dSv28NaxVvZ8kXM0tiGYzeOtsAlBXdgr78
         KfCVEmxyGD7xZGrk2Sqe/hsPFUB+Q3cvkQ3Zd7Jtu0HDePtPBeFQltjN6G3NvXylXP3c
         B1HOcLhR6/gg35k+2LlsnRTByEglomlCu3HyOoT3GszeotG9UQNo9LJLrme5a4gB98uz
         s70TUVWqW75pkAl3ggkWkeSzlZUvNKk3zt6Bwp7df6PPFzRHTe+PLgIhzwlxN5we5rEr
         8igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156465; x=1709761265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCM+8uN6bk+iNHms7/4W48UoMexoT+a1OO7dxqBgfwc=;
        b=A3vN0blkmJsfGoem7+QTK+Kl3v6U616xZWtZxPglN1b46ae8sXehanLFCBFsL4Hbk7
         g0ee0zbh43zdUiGzsYVS+8d/TLih1m3Vfu5lWBa0VvWD0tX+5LUF9j5c7HPlPe2LdzxO
         6DICiclzphKG14c/ouehNUMNA1+jhKcCWNU8AS1pPXzs6+NJm3ucvOp+1bX+/M4QTFhN
         bq5odVX7Jav3VvBVNnfLP7S1/FayDR7WeU7FHxg4OnkxqqlNcloPilJ5/g4M7t/eLRjV
         VhZPTDc7FYFLhFGtrqnadZeMwiYpmbsJZ2E2I5bUbedcRjGrW2LJF5tt7PSvAdIuCn1P
         NBLA==
X-Gm-Message-State: AOJu0YzqaIvc81XipefM+yHUQ9xVK7U/31MByBYvbqqH7uGMqpnw06k4
	wk8/KhFuMOLoFJ2z9I0F3DWj2MX3SRDVUFQ4/RDYeodIx72ePRjdrppcyHOFPmYJz8fXg9trEL+
	lab8B4GoPrq9mOInxmXtmWI506W8=
X-Google-Smtp-Source: AGHT+IGFrU1K8Gp7Fol460hNw9aYFHbpDelhFHejm0awUfav/azN02/kLYi3digbNsRJWT/T5u09uujZp3S/Ee0wm2Y=
X-Received: by 2002:a17:902:8d8c:b0:1db:d586:b2d with SMTP id
 v12-20020a1709028d8c00b001dbd5860b2dmr229055plo.18.1709156465491; Wed, 28 Feb
 2024 13:41:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222005005.31784-1-eddyz87@gmail.com> <20240222005005.31784-3-eddyz87@gmail.com>
 <CAEf4BzYwoFN8GzdWt+6Avbh1jT5LoybOUVh=C-8=dX8H75J_+Q@mail.gmail.com> <27ec4223c14109a28422e8910232be157bf258d3.camel@gmail.com>
In-Reply-To: <27ec4223c14109a28422e8910232be157bf258d3.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 13:40:53 -0800
Message-ID: <CAEf4BzZkL_CUfENS36DHsN8bCoxEr2Bb2E3Dgqu6Rw92wwunnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: track find_equal_scalars history on
 per-instruction level
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 1:16=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 11:58 -0800, Andrii Nakryiko wrote:
> [...]
>
> > > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifie=
r.h
> > > index cbfb235984c8..26e32555711c 100644
> > > --- a/include/linux/bpf_verifier.h
> > > +++ b/include/linux/bpf_verifier.h
> > > @@ -361,6 +361,7 @@ struct bpf_jmp_history_entry {
> > >         u32 prev_idx : 22;
> > >         /* special flags, e.g., whether insn is doing register stack =
spill/load */
> > >         u32 flags : 10;
> > > +       u64 equal_scalars;
> >
> > nit: should we call this concept as a bit more generic "linked
> > registers" instead of "equal scalars"?
>
> It's a historical name for the feature and it is present in a few commit =
and tests.
> Agree that "linked_registers" is better in current context.
> A bit reluctant but can change it here.

I'd start with calling this specific field either "linked_regs" or
"linked_set". It's a superset of "equal scalars", so we don't strictly
need to rename all the existing mentions of "equal_scalars" in
existing code.

>
> [...]
>

[...]

