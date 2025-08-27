Return-Path: <bpf+bounces-66709-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69BB38AA3
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909E9364D20
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 20:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94832BE7CD;
	Wed, 27 Aug 2025 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOdFXVBp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A98CA5A
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325115; cv=none; b=G9X4+DgedCpYw4acfa4fAuIlDBMqQGQAsSTnz+uxFQrKOD1SNEvQxh40WYGFatQjht5aTCko2yoadHGtcNZPbyqLnL3IsjyZ1mE6moNp1FH5JgO0MJ5Ze9YtnZo6k/3rtdxOZkjyspb8JuMFL0fbOlmxlh2jaSr0l/CsOwgLmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325115; c=relaxed/simple;
	bh=abo9KHOX4y2p9lPkp9bAk2ow+U2bfu0PjHWcVPor2Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Te1kFzsGwcX7V0svtikRZ674lr7bduf6x+gBc9LrcyUcey9gXkFo25nMBFT2JR5TZEy6CwkhtOS9cfi2ZE4w16TDiqIS9izWZLZmT1BXwSrjEtOkNFTiDlcc2ETbQKj0hqUgzEqYKP9A+OOCKVtPlZb5B2q9mVpksIMKSGGX3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOdFXVBp; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4c29d2ea05so1012365a12.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756325113; x=1756929913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bs/XV2NOqspI4S0fjmRCC0xYkGsSXdQpEFGFRK94i/4=;
        b=kOdFXVBpFzv9+9k2LtT+oZOEubtRoXAc5JbfN/3hMy+ppyN8fKJ6SIAsHRRvxS3ivX
         BHyVITXYpGKWHvwgGN18KwDvcr9r9YMWFAwLRF9ySLBYCyZm3Nww23aUPGaoRg/8n2Zb
         YihNAtCM0P+fzGchll4zFaDaZM/Fw+C9vq12oQtEhg4k9txryVCY9VNt+l+oIsewgYNp
         fQw5ANbkYrJQzZfBbJjtmVnE9di1BI+RgUgZ5gqKr2uQcjbvhxTZ9fpttGtOUswSCr8h
         Zw131wPquJE2gPu4VHEHHEFFQxMrM9Qkqr748tM7frGB87qEgCmbVYicjmDIg8RHV2Fn
         /DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756325113; x=1756929913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bs/XV2NOqspI4S0fjmRCC0xYkGsSXdQpEFGFRK94i/4=;
        b=Kse2vSL0ikz5gn5tNZ7Rd18RVLfKN/iogVncr3yAB4tmF6x80QwkWdyZjjCdAM7vkm
         qKfqH1/4PMvq78SWoKFVNbHUA9VaUb5/SI6xDMSOtqQL0nbzTCFCia6QGNAmP5D2rmsU
         8DdST//e54GF5btwEanSp1fI5mAAIeNpIdOOK+6Z+uCAblDytulR3E+CeJD78vDMvfDC
         uJIy8N4NiYhecIsOqOW+LayB52Bh7eGiA5wlgTajxJhpsaoEZcnMMMINLD54O5ghIOl7
         nb/xSkZ8yIfQ7Riv1+eYUZ5OEz2VVNz7FYRztLyfjnqeKYNTgLGeMdT7rdkByyNK2kGk
         XLOA==
X-Forwarded-Encrypted: i=1; AJvYcCV+JK2QQz3Tv9lnM7HwLFetEvnMDyuP3ajF0huwGV2yRTJuZogvt+rV5LAmnVUHWoQwzUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXifHJPVKDGAX3/Af6qZqwe7CdogI0ZjKGawTcx+dDO0lxVG2D
	ZwYY5LWda8I28YTtp4VzzYZNukDhjcPJDA65LJnH4e7qsKGCX1dqqF+2gJzkywDGMiqi2XCMCTR
	mW6JwpBN/4X2ay0RUmXWOaghy25bS254=
X-Gm-Gg: ASbGncs8lRrPcMtmPHzclop7CzlWP+azQqcoXlpU1XK7m+QmcJdoZ+XA78mn8woXwVL
	9ciGcD1w1W04rfnBLPU9H0ol5h2Bl+46mouzuaNB/+ZxKRsqvbBQJ+mlDlkHX/olK6F2Ea7UAuW
	2o3T5hGPgf7KUzAn59YSBBtwn/Jt0x4e8YAh0Nxu71UXiSNXli3KrVDa/Gv28CEagrsDtG4yS6r
	/VjT2aTatQ9aEGJQhoyhLTHOE2z7mzrmQ==
X-Google-Smtp-Source: AGHT+IHGXbnxPOIcvY8Uk3D4HBTdmIsqb/fphj5q9ViCrhtD9ZEImlK3BulZLfSLi3INGonSTs9VTzlVej7iFHHAJj8=
X-Received: by 2002:a17:90b:35c2:b0:312:dbcd:b94f with SMTP id
 98e67ed59e1d1-3275085e802mr7834642a91.11.1756325112424; Wed, 27 Aug 2025
 13:05:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827130519.411700-1-iii@linux.ibm.com> <20250827130519.411700-2-iii@linux.ibm.com>
 <CAEf4BzZgf4vRWnse6N1X_h4X6XPuax_iMxiJ5x=kwLyJzz8x-w@mail.gmail.com> <1c796beb8e6d864f6c7498b8a31e2085986e2d60.camel@linux.ibm.com>
In-Reply-To: <1c796beb8e6d864f6c7498b8a31e2085986e2d60.camel@linux.ibm.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 13:05:00 -0700
X-Gm-Features: Ac12FXxeGod21Wrz0504uh5Yh9hk2_CYW2q_mT8LuapGiKu6rjDr2yOYsfyd0Zs
Message-ID: <CAEf4BzYaZJ-TH_T32QpuxdeXOa4yt1dqrExbV6xrsXvs+kp6kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] selftests/bpf: Annotate
 bpf_obj_new_impl() with __must_check
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 11:34=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> On Wed, 2025-08-27 at 10:32 -0700, Andrii Nakryiko wrote:
> > On Wed, Aug 27, 2025 at 6:05=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm=
.com>
> > wrote:
> > >
> > > The verifier requires that pointers returned by bpf_obj_new_impl()
> > > are
> > > either dropped or stored in a map. Therefore programs that do not
> > > use
> > > its return values will fail to load. Make the compiler point out
> > > these
> > > issues. Adjust selftests that check that the verifier does indeed
> > > spot
> > > these bugs.
> > >
> > > Link:
> > > https://lore.kernel.org/bpf/CAADnVQL6Q+QRv3_JwEd26biwGpFYcwD_=3DBjBJW=
LAtpgOP9CKRw@mail.gmail.com/
> > > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > ---
> > >  tools/lib/bpf/bpf_helpers.h                          | 4 ++++
> > >  tools/testing/selftests/bpf/bpf_experimental.h       | 2 +-
> > >  tools/testing/selftests/bpf/progs/linked_list_fail.c | 8 ++++----
> > >  3 files changed, 9 insertions(+), 5 deletions(-)
>
> The CI found an issue with bpf-gcc in the meantime, I will fix this in
> v3.
>
> > > diff --git a/tools/lib/bpf/bpf_helpers.h
> > > b/tools/lib/bpf/bpf_helpers.h
> > > index 80c028540656..e1496a328e3f 100644
> > > --- a/tools/lib/bpf/bpf_helpers.h
> > > +++ b/tools/lib/bpf/bpf_helpers.h
> > > @@ -69,6 +69,10 @@
> > >   */
> > >  #define __hidden __attribute__((visibility("hidden")))
> > >
> > > +#ifndef __must_check
> > > +#define __must_check __attribute__((__warn_unused_result__))
> > > +#endif
> > > +
> >
> > do we need to add this to libbpf UAPI? let's put it in selftests
> > header somewhere instead?
>
> Will do.
>
> >
> > >  /* When utilizing vmlinux.h with BPF CO-RE, user BPF programs
> > > can't include
> > >   * any system-level headers (such as stddef.h, linux/version.h,
> > > etc), and
> > >   * commonly-used macros like NULL and KERNEL_VERSION aren't
> > > available through
> > > diff --git a/tools/testing/selftests/bpf/bpf_experimental.h
> > > b/tools/testing/selftests/bpf/bpf_experimental.h
> > > index da7e230f2781..e5ef4792da42 100644
> > > --- a/tools/testing/selftests/bpf/bpf_experimental.h
> > > +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> > > @@ -20,7 +20,7 @@
> > >   *     A pointer to an object of the type corresponding to the
> > > passed in
> > >   *     'local_type_id', or NULL on failure.
> > >   */
> > > -extern void *bpf_obj_new_impl(__u64 local_type_id, void *meta)
> > > __ksym;
> > > +extern __must_check void *bpf_obj_new_impl(__u64 local_type_id,
> > > void *meta) __ksym;
> >
> > bpf_obj_new_impl will generally come from vmlinux.h nowadays, and
> > that
> > one won't have __must_check annotation, is that a problem?
>
> It should be fine according to [1]:
>
> Compatible attribute specifications on distinct declarations of the
> same function are merged.
>
> I will add this to the commit message in v3.

Sure, for BPF selftests it will work. My question was broader, for
anyone using bpf_obj_new in the wild, they won't have __must_check
annotation from vmlinux.h (and I doubt they will manually add it like
we do here for BPF selftests), so if that's important, I guess we need
to think how to wire that up so that it happens automatically through
vmlinux.h.

"It's not that important to bother" is a fine answer as well :)

>
> [1]
> https://gcc.gnu.org/onlinedocs/gcc-12.4.0/gcc/Function-Attributes.html
>
> [...]

