Return-Path: <bpf+bounces-56321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68CA95583
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 19:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92E0F188F455
	for <lists+bpf@lfdr.de>; Mon, 21 Apr 2025 17:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846091E3DEF;
	Mon, 21 Apr 2025 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flnuzB9w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454961E32DD
	for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745257723; cv=none; b=XxYzL1GmHVoKdU9KuaMBgolHA8t0hyIPd+w7GdWNVpA+MOyz4tzkqe2llolvA8OmS5f018uSH+nhAMPmg+YdT+kitmzmB3luirUXCjL3oV0AvTsm39xTDfwQnwJOVWJ8c387YLd3+QmFVQWnYvfyuVsDVMdfgmBSkb0mE9apZUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745257723; c=relaxed/simple;
	bh=y1JLkcgSPHCx3oMbHA6Te0jRNcfkUi068ij9puXCCWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXdVRmmqO95vyFIep9xZEASkolL8PE+VoTeVqQOjZpuozCkV95G/VIK2gxqbGUmQLdSWuMkze+OqdsnAKvV5zozcN/U8/Li3jgLOi+Gi8MvJKE1X7ru7pZsxQQ2gI9v3gx1oUow+ZELctQRyZSFl0xG4TrzWQ1PKZuXFlLmy98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=flnuzB9w; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2c663a3daso733606666b.2
        for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 10:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745257719; x=1745862519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgEvatn+1Htqs7q914iQ+Tb6ZeYd0ENqoEC4hmRDOwQ=;
        b=flnuzB9wfaQzwTokIQ3n+52JITwfsyFaB5J0E/DbEQ7FFRm4ij2GI1ykdIPdjyZnzE
         sZy+hC6XLDgKg4pzG27dArnNW7wdpKDip7S6bTaW9DAqj9zce4iKLP7r7HR0/ygbw1lO
         XvgO8p5pmKPPeXYKxmDZEAGqPTBXWTFyzGfcq0M4IeS6k6NcRaLmFQ0P+eilG7AT0AQw
         Smfu76BP1kJkWFYe3wwdVPTEfNx/ZJfDR3xLjDLMkGePTbt/TYvIfddO09r34XKbXGsD
         +yYHVJkgAJsALdKXnvM7hTzv25n8WCE45U6blEUxBM3wIon8tboTdzqmiEXrfZc1HYOK
         MwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745257719; x=1745862519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgEvatn+1Htqs7q914iQ+Tb6ZeYd0ENqoEC4hmRDOwQ=;
        b=qalpJq+YF/oSB5trNPT7ve9r3S0qV7xZqz1j/mY095FBpqZYbM2pNYU6hwyzR8123h
         hHeiyJ44OXeGpAF8io8fXk/m274ulXd4FGoSELzCHAxzgceJkQQSbFkS01ffXVz8r9B9
         s7RHLzdFnKgAmNhvvPpT4wRylyAfS1U+7dhrNYHDya9BXs8JzMApU6Yi86HSIbxcQ8us
         iTI3jqKVADbbFnLQGLwuoCDm7VUBb5trsb+YvqoTDEdajyl0i9pQPugyOoSEpizzQwl5
         P+Uk5iYVVhFxpMAm3Xl1BwLjg7dAdNU3ZASCGfnxO+jcS68+eBOMs3eJDdV50vxkF6SU
         1RvQ==
X-Forwarded-Encrypted: i=1; AJvYcCW81wTgyfA7+oI+LdbMKEVYYnArjkUUVx6iCj5G5bJnK7uQXygbhanbo4azXq4LpTYdRUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8DbyBrGiWH0gC1SRsIpP/UnikunTAsQJWshQ6SIv5f2lttL2
	4N1DPDT/VlnHu54sXw3ap6E9Kl6qejYb58zHe5LVfxidvacsKxxH5kOcZH2u4kmZrxyWCPFwHsO
	O8tcU8nkYWBQlAw7sDRopDb/EVjETpKJu9u4=
X-Gm-Gg: ASbGnctDjD9WOfTBic/ZieLfda4M7Ch2y43BPTAbfPDgkVIHG1Vt9MaM6CrE5BboWku
	okiJuZbU+D236EFBLIUNcpJGoBj8qMsjy53DgIKYpY3X26qLkwnqE1GtEekYKJD+bYGFwXc019l
	orODHu699IQtQtlWU+v13t+2Hd
X-Google-Smtp-Source: AGHT+IGRnGJqU7jGMAnF9mMpjz1sCIFPLTpyxI3YIjNcIf6g1t3mXAii2MmHyGNaBSTwRJSZETLTKqdURq6wBrtAK2g=
X-Received: by 2002:a17:906:7c43:b0:acb:b381:c28b with SMTP id
 a640c23a62f3a-acbb381cc4dmr178624866b.47.1745257719034; Mon, 21 Apr 2025
 10:48:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQJbBOK25Fx3zEG-ZH=zTFRfPNQye673b5TnpdTdMEXAUA@mail.gmail.com>
 <20250410103804.49250-1-malayarout91@gmail.com> <CAEf4BzaogUrvCxga36F1_o-h53Ur0mAaG9im1JsPfAhutxSYuQ@mail.gmail.com>
 <CAE2+fR-QvJqL0VkqPufLL+r7FLaOSTRt2_xXjq=fdpk0yAGj2w@mail.gmail.com> <CAEf4BzZGCfrEJpqbd=j11poDHyHqfobRvQeQB0FLEpBg9Bf_XQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZGCfrEJpqbd=j11poDHyHqfobRvQeQB0FLEpBg9Bf_XQ@mail.gmail.com>
From: malaya kumar rout <malayarout91@gmail.com>
Date: Mon, 21 Apr 2025 23:18:27 +0530
X-Gm-Features: ATxdqUGIyJCl7sblZYcZx8mqLjgTgMyNCpV4vsr3dwmVU_mrOGVNlxUfLwObSwM
Message-ID: <CAE2+fR8vXac0=0FQsH8S+fkGF4GBcKz=mCTdCezb8FMo1iMFAA@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v3] selftests/bpf: close the file
 descriptor to avoid resource leaks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: alexei.starovoitov@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 4:45=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sat, Apr 12, 2025 at 11:45=E2=80=AFAM malaya kumar rout
> <malayarout91@gmail.com> wrote:
> >
> > Malaya Kumar Rout
> > Ph. No:  +91-9778203508
> >              +91-7008245249
> >
> > On Thu, Apr 10, 2025 at 11:03=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Thu, Apr 10, 2025 at 3:38=E2=80=AFAM Malaya Kumar Rout
> > > <malayarout91@gmail.com> wrote:
> > > >
> > > > Static analysis found an issue in bench_htab_mem.c
> > > >
> > > > cppcheck output before this patch:
> > > > tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3: error: R=
esource leak: fd [resourceLeak]
> > > > tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3: error: Res=
ource leak: tc [resourceLeak]
> > > >
> > > > cppcheck output after this patch:
> > > > No resource leaks found
> > > >
> > > > Fix the issue by closing the file descriptors fd and tc.
> > > >
> > > > Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> > > > ---
> > >
> > > I still don't see this patch in our Patchworks.
> > >
> > > But I noticed that the subject is:
> > >
> > > RE:[PATCH RESEND bpf-next v3] selftests/bpf: close the file descripto=
r
> > > to avoid resource leaks
> > >
> > > and there is
> > >
> > > In-Reply-To: <CAADnVQJbBOK25Fx3zEG-ZH=3DzTFRfPNQye673b5TnpdTdMEXAUA@m=
ail.gmail.com>
> > >
> > > email header, so I suspect bot ignores this because it's a reply.
> > >
> > > Please send it as a stand-alone email with `git send-email`, hopefull=
y
> > > that works.
> > >
> > I have shared a stand-alone email with 'git send-email'.Kindly confirm
> > at your earliest convenience. If any issues arise again, please permit
> > me to share two separate patches, as we have modifications in two
> > distinct files.
> >
>
> Yes, this time email arrived into Patchworks, but you had pclose ->
> close mistake, please fix, test, and resubmit.
>
I have submitted the patch in a separate email once more, following
thorough testing.

> > > >  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
> > > >  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
> > > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/=
tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > > > index 926ee822143e..297e32390cd1 100644
> > > > --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > > > +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> > > > @@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const c=
har *name, unsigned long *value)
> > > >         }
> > > >
> > > >         got =3D read(fd, buf, sizeof(buf) - 1);
> > > > +       close(fd);
> > > >         if (got <=3D 0) {
> > > >                 *value =3D 0;
> > > >                 return;
> > > > @@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const c=
har *name, unsigned long *value)
> > > >         buf[got] =3D 0;
> > > >
> > > >         *value =3D strtoull(buf, NULL, 0);
> > > > -
> > > > -       close(fd);
> > > >  }
> > > >
> > > >  static void htab_mem_measure(struct bench_res *res)
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/t=
ools/testing/selftests/bpf/prog_tests/sk_assign.c
> > > > index 0b9bd1d6f7cc..10a0ab954b8a 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> > > > @@ -37,8 +37,10 @@ configure_stack(void)
> > > >         tc =3D popen("tc -V", "r");
> > > >         if (CHECK_FAIL(!tc))
> > > >                 return false;
> > > > -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> > > > +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))=
 {
> > > > +               pclose(tc);
> > > >                 return false;
> > > > +       }
> > > >         if (strstr(tc_version, ", libbpf "))
> > > >                 prog =3D "test_sk_assign_libbpf.bpf.o";
> > > >         else
> > > > --
> > > > 2.43.0
> > > >

