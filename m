Return-Path: <bpf+bounces-70870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C668FBD7538
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 06:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE62318A6657
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBA30CDAA;
	Tue, 14 Oct 2025 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aznXbLcg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FD30BBAB
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 04:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417634; cv=none; b=dmvJ8AJ6HCZvqYohOW71PNKxsdcPlVdWD/bs18N8a9qBt0N8253bzYQ19J3KkjhqhrrSIPKM5BAq1YZmV5ZMsFwkIO+iHezPZmVdkfZpWUjkLPXRjQccW0s56CBFxzmZEOP5P89IsXnsvEJomRyIg+blXypl/KYy8E/3KQoekBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417634; c=relaxed/simple;
	bh=a4xoUFMwYk684k5JYg2VpNN7CFXbHuQ0VdyeOTINjuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EnnrHxNOeKMdx2z525yH2UQCGkPgcBOrWQ1/aNy4v2WH+jfqzlka0rwN7+H+CoVLsNafXQL/hn0aJPvZmOSQog2xI4877+CbzfTSBLSf3OrzAGEonIaW8BuFafzheljfMBVeLhAq0JgeK8x0KcYaLaSbuGlGn5MTv4bkcZV2hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aznXbLcg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-639fb035066so7672278a12.0
        for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 21:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760417631; x=1761022431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfQyCyE+XPfPYrrByTwKDtcCs6GmIeb9aW4FmXsJ1IU=;
        b=aznXbLcgXjHxPtXEW5ecJk+ZyMPLyVdCJoBMWGzWXF+AJO0LGO96KOWl9mM/ok2sbT
         bgxldsiqlSyJmSLIxYvBhzbsWxeqvyZ/nqZtHl/cOCgpwIMJzz4G5jlFv6cRaV/nIrGS
         Xmf2WL4PcetmZcLtNSgnF2T0TkJhmnsVVITrOrpeNk0BQUHomytLzTPE/eO4VG4/7gr2
         R6HTScfgjjstN2R4/tc0gEjE1r3MII0ab5XJg5rhB8/JJdOiWUyvl4Uqbj7D44JGJHYm
         6Xs7bYWkHqigveaGGr/jQMX9VF4967cf1nW9DkNc18ZgnBARtjAqd8uyA5v3MNhvycCN
         7SAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760417631; x=1761022431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfQyCyE+XPfPYrrByTwKDtcCs6GmIeb9aW4FmXsJ1IU=;
        b=Cjyr2yrZ3XdoxOxS+fFy2TAeUGiCgLjtotU3Gxm3AjcAzfi2rdIrmFtNp1Sb3Exl6+
         4JXfabjpB7Qdxt5AFTuPTqhc7Rt5OzZCqjiOZoFdRpstMFKSxXN8cGrdElpuWDe1If8X
         SXKrehUtffwI0+SIrsc9g13AXa6sPUu1f1XT9yeizlIfS8C40sOk6Glgih2enEK0yVCT
         W0ybKbkSVTT9OJ06ypmhtapVKI6Pfrz2kh3pcArmJvEv8B2KevheZhlzWNJIp82pDBUb
         bGUNUbxU+kt0Efewpjf6y28m31kBS1tjhCCrrQ+IAgD7YyAuRNWbneh1wJl9Hb0V7fJE
         /AeA==
X-Forwarded-Encrypted: i=1; AJvYcCUwXAejJCS71qxASW4WgpYcf7rg5X7ZUozmJnMheTZ+nW8h59Sv9lv1DquCSw/AmGLdFn4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjf18yUGvqoO+51hqLmhoLfzCForhS52B4LjIeHRt0fdnfS3bF
	zwcYgSsjQKKzZAfduzuYKFO8ynzTwuS3UABz9LX46+k/JRNb11ebXAiZcMie0Ntc3NrEKu3YuAK
	AkIW5PCiYBHB9c5fZhk3pk/A0VA+J3AA=
X-Gm-Gg: ASbGncvxl8HU6CUvO45twWJCX2iahKc3WZGwJJDaRJmGht10hKkcg7vHiaJmJ9QiK1j
	IBRdLe5esgamG0vRiRIwSfr82LyWDs1b+o30/9rjPXv0YtHJ4mg4ZDphraa0ZdTyUqWA5AY1ySy
	vuDcjRoRzVl0WC0qOQoL/Fxecz46zSeK4Lq5FiQrfZdJxy0Zu6asDZ4eBVfqoWFVhQOi2St4W/F
	WFpP2XykcZOj2DD4qC8GNHLkl52yBL3o/PwhQ==
X-Google-Smtp-Source: AGHT+IHycdhxq/9uyp9yKAAL3r9oERFUtH+HAFOLwQI4pevZSkF66rxnEvWd1Bw49lAHp9HOueRaVLiXkkjNr0qGtHc=
X-Received: by 2002:a05:6402:2744:b0:637:dfb1:33a8 with SMTP id
 4fb4d7f45d1cf-639d5b64901mr22616488a12.3.1760417630759; Mon, 13 Oct 2025
 21:53:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013131537.1927035-1-dolinux.peng@gmail.com>
 <CAEf4BzbABZPNJL6_rtpEhMmHFdO5pNbFTGzL7sXudqb5qkmjpg@mail.gmail.com>
 <CAADnVQJN7TA-HNSOV3LLEtHTHTNeqWyBWb+-Gwnj0+MLeF73TQ@mail.gmail.com>
 <CAEf4BzaZ=UC9Hx_8gUPmJm-TuYOouK7M9i=5nTxA_3+=H5nEiQ@mail.gmail.com>
 <CAADnVQLC22-RQmjH3F+m3bQKcbEH_i_ukRULnu_dWvtN+2=E-Q@mail.gmail.com>
 <CAErzpmtCxPvWU03fn1+1abeCXf8KfGA+=O+7ZkMpQd-RtpM6UA@mail.gmail.com> <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
In-Reply-To: <CAADnVQ+2JSxb7Uca4hOm7UQjfP48RDTXf=g1a4syLpRjWRx9qg@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 14 Oct 2025 12:53:39 +0800
X-Gm-Features: AS18NWBzhlnxQ9UDKq0PMeKLqmLwp_jZVc21fUyToJv8XAqRPenRlWCmVKYbt5s
Message-ID: <CAErzpmu0Zjo0+_r-iBWoAOUiqbC9=sJmJDtLtAANVRU9P-pytg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] btf: Sort BTF types by name and kind to optimize
 btf_find_by_name_kind lookup
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:48=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Oct 13, 2025 at 6:54=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.=
com> wrote:
> >
> > On Tue, Oct 14, 2025 at 8:22=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Oct 13, 2025 at 5:15=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Mon, Oct 13, 2025 at 4:53=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Oct 13, 2025 at 4:40=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > >
> > > > > > Just a few observations (if we decide to do the sorting of BTF =
by name
> > > > > > in the kernel):
> > > > >
> > > > > iirc we discussed it in the past and decided to do sorting in pah=
ole
> > > > > and let the kernel verify whether it's sorted or not.
> > > > > Then no extra memory is needed.
> > > > > Or was that idea discarded for some reason?
> > > >
> > > > Don't really remember at this point, tbh. Pre-sorting should work
> > > > (though I'd argue that then we should only sort by name to make thi=
s
> > > > sorting universally useful, doing linear search over kinds is fast,
> > > > IMO). Pre-sorting won't work for program BTFs, don't know how
> > > > important that is. This indexing on demand approach would be
> > > > universal. =C2=AF\_(=E3=83=84)_/=C2=AF
> > > >
> > > > Overall, paying 300KB for sorted index for vmlinux BTF for cases wh=
ere
> > > > we repeatedly need this seems ok to me, tbh.
> > >
> > > If pahole sorting works I don't see why consuming even 300k is ok.
> > > kallsyms are sorted during the build too.
> >
> > Thanks. We did discuss pre-sorting in pahole in the threads:
> >
> > https://lore.kernel.org/all/CAADnVQLMHUNE95eBXdy6=3D+gHoFHRsihmQ75GZvGy=
-hSuHoaT5A@mail.gmail.com/
> > https://lore.kernel.org/all/CAEf4BzaXHrjoEWmEcvK62bqKuT3de__+juvGctR3=
=3De8avRWpMQ@mail.gmail.com/
> >
> > However, since that approach depends on newer pahole features and
> > btf_find_by_name_kind is already being called quite frequently, I sugge=
st
> > we first implement sorting within the kernel, and subsequently add pre-=
sorting
> > support in pahole.
>
> and then what? Remove it from the kernel when pahole is newer?
> I'd rather not do this churn in the first place.

Apologies for the formatting issues in my previous email=E2=80=94sending th=
is again
 for clarity.

Thank you for your feedback. Your concerns are completely valid.

I=E2=80=99d like to suggest a dual-mechanism approach:
1. If BTF is generated by a newer pahole (with pre-sorting support), the
    kernel would use the pre-sorted data directly.
2. For BTF from older pahole versions, the kernel would handle sorting
    at load time or later.

This would provide performance benefits immediately while preserving
 backward compatibility. The kernel-side sorting would remain intact
moving forward, avoiding future churn.

>
> Since you revived that thread from 2024 and did not
> follow up with pahole changes since then, I don't believe that
> you will do them if we land kernel changes first.

Regarding the pahole changes: this is now my highest priority. I=E2=80=99ve
already incorporated it into my development plan and will begin
working on the patches shortly.

What do you think about this approach? Would this be acceptable?

