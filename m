Return-Path: <bpf+bounces-18989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302FB823A4F
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 02:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43A321C24B9C
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95C1C20;
	Thu,  4 Jan 2024 01:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfGRZLyi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65491878
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 01:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-336746c7b6dso33515f8f.0
        for <bpf@vger.kernel.org>; Wed, 03 Jan 2024 17:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704332518; x=1704937318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owFicmdt8Z93Mo23mHgHl5yM/Cxr8Gr0qCbKIRDU3lI=;
        b=mfGRZLyiYbf4Xmx7Bi3n3albXVNJT2LDvZDLh1gQe9upBqJD0Ir8LnvircChLpaKsg
         prDlBZhQkmI25hE4virrx4cHFy8sHfsGRC7/NJXjRAZbD3Linkkus2fttdueCAQzZQLO
         6tbm72xmgigoT4frsEIv0gXfIaly+EWCLhRM2JqEvC7mDWv+570hR4BHPHYGhImKLMpj
         BdXQm2O0Qo3vHso785Qd3qD28NDMQtoZA2NGHbY077JREGtdWXML1LH3ykTPrFBI1xeJ
         QVwzuyRVPabGgx619jW5FDHS3F2en9XE0CgxBxhglDvA/9X+YIAgd14KRk8+EfoWYIpg
         pskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704332518; x=1704937318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owFicmdt8Z93Mo23mHgHl5yM/Cxr8Gr0qCbKIRDU3lI=;
        b=Fi2SdKujLlHhYdWbe5m8hMI6XrEm8t0TNolIiw5wtGaku8BLi5kSOyYrZ1mVUeBf2u
         GeUMBapyO3ThwIYIk5kWsSbhPsrNutN9Hot1JYrEOiDgjTnnKMTgYnFX9VG/QMPoNPqA
         Q/VK9W9mQT7Z1Sz4Xtg7Yu6MbvQAwv7QmJCpwYRC98Cl9w1i+MA32WlGAUAtDTgpw3Iq
         8NoY8zJlLPJiO523asgiiuJZhF6SWMjkZgxeGhAYab0YWY95hu0605HhuCrwWEaMZ2qp
         qUqkdV24O+WwMaJdLWcNcGTyj8AwXLL/TQVfF1l+UFwo+AAGohvH6HRRph0ruv0vXB/H
         58kg==
X-Gm-Message-State: AOJu0YzM1+YQjXXVjaZ94ScwBZas5myXqWv6xH/e1ZJ5HInbXuSyeh8Z
	ex+udlDJJwfd/zehGLZ46t7iu/IOmcmvPyLOWkc=
X-Google-Smtp-Source: AGHT+IGPfmRNDH7z1kBV73btG7eMWN5Z3iShUNpkF3qAFkZvK9c5NcfF3TsZz701hlzdgHYSyhsGUjszX8hsX1BB/yA=
X-Received: by 2002:a5d:66cb:0:b0:337:39c7:2a3 with SMTP id
 k11-20020a5d66cb000000b0033739c702a3mr3355655wrw.129.1704332517937; Wed, 03
 Jan 2024 17:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYZPR03MB679243A8E626CC796CB7BDBDB461A@TYZPR03MB6792.apcprd03.prod.outlook.com>
 <CAKOkDnNAQSrWxsJBrcLV7ReaQkX_BHX+EAn69e0cpe9b=FAsUg@mail.gmail.com>
 <CAKOkDnPnNE=MNP-1_8=T9vw6Ox80OAJmKonzpDO4abW8Dz9JwA@mail.gmail.com> <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
In-Reply-To: <SEZPR03MB67865F9167DABCA16AA6811BB4602@SEZPR03MB6786.apcprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 3 Jan 2024 17:41:46 -0800
Message-ID: <CAADnVQJCxFt2R=fbqx1T_03UioAsBO4UXYGh58kJaYHDpMHyxw@mail.gmail.com>
Subject: Re: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
To: Maxwell Bland <mbland@motorola.com>
Cc: "Jin, Di" <di_jin@brown.edu>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"v.atlidakis@gmail.com" <v.atlidakis@gmail.com>, "vpk@cs.brown.edu" <vpk@cs.brown.edu>, 
	Andrew Wheeler <awheeler@motorola.com>, =?UTF-8?B?U2FtbXkgQlMyIFF1ZSB8IOmYmeaWjOeUnw==?= <quebs2@motorola.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 3:45=E2=80=AFPM Maxwell Bland <mbland@motorola.com> =
wrote:
>
> > -----Original Message-----
> > From: Jin, Di <di_jin@brown.edu>
> > Sent: Wednesday, January 3, 2024 4:39 PM
> > To: bpf@vger.kernel.org
> > Subject: [External] Fwd: BPF-NX+CFI is a good upstreaming candidate
> >
> > ---------- Forwarded message ---------
> > From: Jin, Di <di_jin@brown.edu>
> > Date: Wed, Jan 3, 2024 at 5:19=E2=80=AFPM
> > Subject: Re: BPF-NX+CFI is a good upstreaming candidate
> > To: Maxwell Bland <mbland@motorola.com>
> > Cc: v.atlidakis@gmail.com <v.atlidakis@gmail.com>, vpk@cs.brown.edu
> > <vpk@cs.brown.edu>, dborkman@kernel.org <dborkman@kernel.org>, lsf-
> > pc@lists.linux-foundation.org <lsf-pc@lists.linux-foundation.org>,
> > bpf@vger.kernel.org <bpf@vger.kernel.org>, Andrew Wheeler
> > <awheeler@motorola.com>, Sammy BS2 Que | =E9=98=99=E6=96=8C=E7=94=9F
> > <quebs2@motorola.com>
> >
> >
> > Dear all,
> >
> > There are a couple of noteworthy things about the patches:
> > 1. They currently don't work with CONFIG_RANDOMIZE_MEMORY, which
> > should probably be addressed.
> > 2. BPF-CFI tries to ensure the interpreter starts from the correct offs=
et under
> > code-reuse attacks, which means it needs some form of control flow inte=
grity.
> > Here we are enforcing that with the state of a read-only variable, whic=
h is
> > toggled by temporarily disabling the WP bit. This also introduces the p=
roblem
> > of having to disable interrupt during the interpreter's execution other=
wise the
> > variable will be in the wrong state during interrupt. In the paper we o=
ptimized
> > away the toggling of the WP bit by some trick involving turning off pro=
tection
> > like SMAP during the interpreter's execution, which is faster in terms =
of
> > performance, but the security trade-off is a bit more subtle. The argum=
ent
> > being that SMAP (or PAN) are contributing very marginally when BPF
> > programs are being executed, since the things they are defending agains=
t,
> > namely user-controlled memory content, are already present in the execu=
tion
> > context. This version of BPF-CFI should incur almost no overhead. The W=
P bit
> > toggling version I don't have numbers at hand.
> >
> > @Maxwell: If you are not in a hurry (I will need a couple of days) I ca=
n
> > generate a set of patches that are compatible for patch submission (pro=
per
> > name and email address, signoff, formatting, etc.), during which I can =
also get
> > some performance numbers. We can discuss authorship depending on how
> > much you want to adapt these patches.
> >
> > Regards,
> > Di Jin
>
> Hi Di Jin,
>
> Thanks! I sent some formatted patches for review a bit earlier today. See=
 https://lore.kernel.org/bpf/SEZPR03MB678610EEBA5140BAA4D1F13EB4602@SEZPR03=
MB6786.apcprd03.prod.outlook.com/. There was great feedback from Alexei Sta=
rovoitov on the issue of Spectre effecting the interpreter when JIT is enab=
led, so there is a mutual conflict with any hardening options which disable=
 JIT. This seems to be a major barrier.

Not quite. The presence of _any_ interpreter in the kernel text is
a problem regardless of whether JIT-ing is enabled or not.
In bpf case we can always use JIT and remove the interpreter from vmlinux.
Hence "JIT always on" is a security fix.

