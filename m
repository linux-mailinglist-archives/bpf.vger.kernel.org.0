Return-Path: <bpf+bounces-77388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED594CDAE67
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 01:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7197302D5F5
	for <lists+bpf@lfdr.de>; Wed, 24 Dec 2025 00:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCC1A2C0B;
	Wed, 24 Dec 2025 00:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT0Rn5CE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E51531C1
	for <bpf@vger.kernel.org>; Wed, 24 Dec 2025 00:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536102; cv=none; b=J0RfWJ/ixzp5X5lNJ5MEaMCB/uo5aUspexqVF3n81kG7dUdJZvp8FaYEMGRNiC+gP+jcteIpP4/FmcP2mT9YpWJaHkGn1qkgUc1SEDn3rDMECwrIEb4l9gW0siKrHfwo9wevODdHX2LiAcVLx7/l8kXKZltKcBqgsXccsc50kkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536102; c=relaxed/simple;
	bh=ZqZClsofzEu1yCyRttHm61Jggr3mZgjtg5sTuzprGCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTjOjsblhad+CvO9mKQhZNCphZUDSbb+lJrdBCJm6z1M+oltd/s5O5VLxrwULaHACoZCtKvZIXG5KDsa1eoetAnqD4fZWWdUL2rJbu+n33ljLCO09uzD89rUYT5aY29qcfQo0VdFCUz88BvnRE0AdCdQy8/AnRZ6YMvRQ+UcW5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT0Rn5CE; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso6774222a12.0
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 16:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536099; x=1767140899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNlgJvjsFLifa8a/tfhw2vTVWbj6I4Xi+Kb0grx+eQk=;
        b=jT0Rn5CEmQM15cjNe3M6ghLUPgRebLdYwTLjGpaY10vIO7I0AXmE1ZP+WL8U+dcXyM
         lj6AIqkO3+bbLrGRgEIK74iSR3CWHk8V8bk3m0wahQYkvnk/xwMJQ6Uscn+qWPYdRxKp
         Gun8Jsdw2yr/CmyxFwxDU3BAt6rztfNiIN+WhBg97RNYfxK9vEoV9EjVBrD/JmFg8nC0
         d0os7VBR392m4zVcnh1PS/9bnJzOYttCxtrhJPUiKQoCfHe0Kpy2+XvbShWrI6v2u5PR
         V60BSwEG9TPpaHdZi9PMfCR4xkjcZ/USFfFL6tCO5t4fuEOgBu+ZOIjnQWC62N3G2MVd
         Ns4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536099; x=1767140899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNlgJvjsFLifa8a/tfhw2vTVWbj6I4Xi+Kb0grx+eQk=;
        b=GZVMRYLdvwQNg5wTGUz0+HJuEXrg+HDu3lkdqpMuZ6mySlasQZfhnExujYCp3ON5nP
         F+I37O++Cgh+k0CJZpGynJu3rpPoeZAvKsx486TX/hU8hLYIfUK3dAs5yvaN5HNodzSv
         4kIgy54htQP5G0Y1bczGBUz5OrjnRxXyRVaCDFxdiits9RItZ/7/EQkTM++x80i7ibtn
         9vTning6HWMl/V5UsVHXU2O+JG5kNTkyqNH0Yot06a9dwQuVaQNz/MNAgodrYflajInH
         9wRq2Ueo/XAx3V8uXCfWLBp5nBzYjkYFBib7fyCd8WjJ4DoBM7skStGEHDBDPekAyvXX
         ydOA==
X-Gm-Message-State: AOJu0YxSeQ6c7kjdoMR2tWWZoCHNWI6/T6mkuhXaV4VV7Gqvbre1ap2f
	6GxKKC96LNHYl9nOPvk0a92LhBqaZ+4wgycXdn31NEMmZylFMq5u+IdAOPBHNdHytcNEFWI8elF
	XAAK1NbHWJPEB01h2eGkp6GHIIG/2SuY=
X-Gm-Gg: AY/fxX5795GggU1pM8bCIg/bu8+6sS2FC3kQgb9QVW2d+/iKrEeWAqka4OmUopiN/qI
	WhyqBbe3FiqfjCmvWt3KabdubO8BxePRoBDqduzuiH9WiEit5sFZC/KDGklm+OS3zi9TI9KEB5I
	d0I2ttUGiu9JOu6hh1+/PIFKmpImbutpTQTcXlun9UW4OCVWZK0Ey+/M46AkmxDUCQL84N4ZVzq
	5A/MAlURTG3Jq6kOOU5kYjjN0SQ1KewaM71fRKJc6Q/bN59WpdLEypvM2k8rCJ9W5+yEbVGTY0/
	oXHuN9sPSzc=
X-Google-Smtp-Source: AGHT+IGTK6A9FRsZH45FUmxKJfcOf8qusmYwsaIu6xVcexpPlm2XFs0/4llBO1c8Yp969F1MsNroApPN2r4BZiz4g/0=
X-Received: by 2002:a17:907:97c5:b0:b73:6b85:1a9a with SMTP id
 a640c23a62f3a-b8036f114fdmr1687648766b.21.1766536098486; Tue, 23 Dec 2025
 16:28:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222195022.431211-1-puranjay@kernel.org> <20251222195022.431211-5-puranjay@kernel.org>
 <CAADnVQ+6K1-bfW07P+dNaQCt4vjedoZVBwao65_7rk1sPyZogA@mail.gmail.com>
 <CANk7y0jLCBr3j-Tz_Lg2kJiYc3vPrXei+QhAJZ5Au7QEBQbfGg@mail.gmail.com>
 <CAADnVQLBFDU-E=_4DM1rp6dNgEaDKKfJaHehemDfJmVZm6OvOg@mail.gmail.com>
 <CANk7y0hCBWW+z2Z_c8p9Wb8-nXRp_1HJHSLLCDpxcUQz4qM_tA@mail.gmail.com> <CAADnVQLzKsogyKoo_aiY4nx96YS1MrAfU5kAMBvmuTsrxaESnA@mail.gmail.com>
In-Reply-To: <CAADnVQLzKsogyKoo_aiY4nx96YS1MrAfU5kAMBvmuTsrxaESnA@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Wed, 24 Dec 2025 00:28:05 +0000
X-Gm-Features: AQt7F2oRD1TGVa9B9_zoqeoH5Aj2hIE54fDbccocWindqzyihKI4tAw3RtcP9n0
Message-ID: <CANk7y0jqPRE1u5uEPRCtsOT46uUUnjyQik3XWrMcSrq3bfgPFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/4] selftests: bpf: test non-sleepable arena allocations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 24, 2025 at 12:02=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Dec 23, 2025 at 1:13=E2=80=AFPM Puranjay Mohan <puranjay12@gmail.=
com> wrote:
> >
> > On Tue, Dec 23, 2025 at 7:36=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Dec 23, 2025 at 4:51=E2=80=AFAM Puranjay Mohan <puranjay12@gm=
ail.com> wrote:
> > > >
> > > > On Tue, Dec 23, 2025 at 5:04=E2=80=AFAM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Dec 22, 2025 at 9:50=E2=80=AFAM Puranjay Mohan <puranjay@=
kernel.org> wrote:
> > > > > >
> > > > > >  int reserve_invalid_region(void *ctx)
> > > > > > diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_l=
arge.c b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > > index 2b8cf2a4d880..4ca491cbe8d1 100644
> > > > > > --- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > > +++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
> > > > > > @@ -283,5 +283,34 @@ int big_alloc2(void *ctx)
> > > > > >                 return 9;
> > > > > >         return 0;
> > > > > >  }
> > > > > > +
> > > > > > +SEC("socket")
> > > > > > +__success __retval(0)
> > > > > > +int big_alloc3(void *ctx)
> > > > > > +{
> > > > > > +#if defined(__BPF_FEATURE_ADDR_SPACE_CAST)
> > > > > > +       char __arena *pages;
> > > > > > +       u64 i;
> > > > > > +
> > > > > > +       /*
> > > > > > +        * Allocate 2051 pages in one go to check how kmalloc_n=
olock() handles large requests.
> > > > > > +        * Since kmalloc_nolock() can allocate up to 1024 struc=
t page * at a time, this call should
> > > > > > +        * result in three batches: two batches of 1024 pages e=
ach, followed by a final batch of 3
> > > > > > +        * pages.
> > > > > > +        */
> > > > > > +       pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUM=
A_NO_NODE, 0);
> > > > > > +       if (!pages)
> > > > > > +               return -1;
> > > > > > +
> > > > > > +       bpf_for(i, 0, 2051)
> > > > > > +                       pages[i * PAGE_SIZE] =3D 123;
> > > > > > +       bpf_for(i, 0, 2051)
> > > > > > +                       if (pages[i * PAGE_SIZE] !=3D 123)
> > > > > > +                               return i;
> > > > > > +
> > > > > > +       bpf_arena_free_pages(&arena, pages, 2051);
> > > > > > +#endif
> > > > > > +       return 0;
> > > > > > +}
> > > > >
> > > > > CI says that it's failing on arm64.
> > > > > Error: #511/6 verifier_arena_large/big_alloc3
> > > > > run_subtest:FAIL:1299 Unexpected retval: -1 !=3D 0
> > > > >
> > > > > cannot quite tell whether it's sporadic or caused by this patch s=
et.
> > > >
> > > > I tried reproducing it locally multiple times and it didn't fail. I=
t
> > > > also doesn't fail on manual CI run:
> > > > https://github.com/kernel-patches/bpf/actions/runs/20442781110/job/=
58740000164?pr=3D10475
> > > >
> > > > I assume it is sporadic.
> > >
> > > Ok. Applied. Let's watch for this. If it's actually flaky
> > > we need to fix it.
> >
> > I have found out why it fails sometimes:
> >
> > arena_alloc_pages() -> bpf_map_alloc_pages(1024) ->
> > alloc_pages_nolock(1) this is called in a loop and fails sometimes,
> > from my debug prints:
> >
> > __bpf_alloc_page: alloc_pages_nolock failed for nid=3D-1
> > bpf_map_alloc_pages: allocation failed at page 435/1024, freeing 435
> > already allocated pages
> > bpf_map_alloc_pages: returning ret=3D-12, allocated 435/1024 pages
> > fail: bpf_map_alloc_pages failed with ret=3D-12 for 1024 pages
> >
> >
> > The VM runs with 4G of memory, when I changed this to 8G, this stopped =
failing.
>
> That doesn't quite make sense.
> The test allocates 2051 pages, that's just 8 Mbyte. Nowhere
> close to a Gbyte. So 4Gb should be plenty.
> Number of cpus shouldn't matter either.
>
> > So, I think we can do the same for the CI.
> > The CI currently runs through vmtest which runs a VM with 4G of memory
> > an 2 CPUs by default:
> >
> > I checked the logs of the CI and saw:
> >
> > [ 0.626933] smp: Brought up 1 node, 2 CPUs
> > [ 0.628387] smpboot: Total of 2 processors activated (12029.10 BogoMIPS=
)
> > [...]
> > [ 0.629145] Memory: 3388084K/4193784K available
> >
> >
> > I think we should change the CI to run vmtest with 8 CPUs and 16G of me=
mory.
> >
> > Here is a PR for this change: https://github.com/libbpf/ci/pull/206
>
> I don't think we should bump it without full understanding.
> It's better to make selftest recover on page alloc failure.


Okay, I will debug deeper to find out exactly where it fails in
alloc_pages_nolock().
For now do we want to allow the CI to fail or I can send a patch with follo=
wing:

--- a/tools/testing/selftests/bpf/progs/verifier_arena_large.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_large.c
@@ -300,7 +300,7 @@ int big_alloc3(void *ctx)
         */
        pages =3D bpf_arena_alloc_pages(&arena, NULL, 2051, NUMA_NO_NODE, 0=
);
        if (!pages)
-               return -1;
+               return 0;

        bpf_for(i, 0, 2051)
                        pages[i * PAGE_SIZE] =3D 123;

This will make this test unconditionally pass.

