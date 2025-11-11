Return-Path: <bpf+bounces-74252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0576C4F745
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 19:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C5D3BC0EF
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F11E27EFEF;
	Tue, 11 Nov 2025 18:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emk1aIgn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FB527E1C5
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 18:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762886156; cv=none; b=tLgvXbyF7EfnGcA9umnI6kKtEBnB3uMNopoTE4txInccNZ21jRtF0nk/5MLvREfZXL/W/FfRzJQ7ad8JCSkahrjb2yrpHI+194UurCvzLRL+iXXCDbvKJqjAA5AoL08din18Pog4M2fEePB8RZEfJF97Yqx6RkIQaiRsSEbS24w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762886156; c=relaxed/simple;
	bh=oiW+96lMPGbksmm+8Ne/yv29cjNp/Y+B/l3wSqF5fv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciTCCwsDU4xcwPGRg5xlbUyASkCTeGy088NDvA2HtXWcFhAelsfXeGTxVe6Nb886c8wbfJprkmHBoppcEEPEfRKwi8pAET9M6L/1uDPrayHrPajRdN4aI6SbfIomx1sYP8evPCBd/C+hDisaOWyWDFxQP2HvlkH0uCCsErY2EGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Emk1aIgn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c7e438a8so3964343f8f.2
        for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 10:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762886153; x=1763490953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R2qMufgLCOrAchjb40CxU794Xzs2ku3JcW+CtQ3zLU=;
        b=Emk1aIgnE+o+xS6ecQLTUWoJ8IDJh4A2k0EK8Ad5QVZOlU42wx61ZgRE0RQRu7LgmU
         tGRRydpHr6dv3nhePGC3P4pXpn+KMjd8VvCQyq+kbAgZ1ZbW+OVA4/g3f+2J3VNO1nEs
         tEVJiylo90npaCRuP13jOcBa8jDhvGp7DEBsOk5PlxZEdLoa1NnWr/Vyt7xNFndKQriY
         1afpT8+5mZQwBMXZptTQRBR91TEuTexjLK1WZ9JJMJX5H61LgJnjciVrpnPQ+LZY9YMq
         pBZYK8BfDyfgqtKdEUaGfZj39Vg6xUGSm/hYOUTZO4fEq8RZ4leUlNmCuwjOAiB4Guni
         OwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762886153; x=1763490953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R2qMufgLCOrAchjb40CxU794Xzs2ku3JcW+CtQ3zLU=;
        b=MF3xkN/IRcUWIsUrhN5RqJpq+aD5ZzEqq/k0p3E6hZLH/utUNQIBsPUhUe18TGZ57I
         86/gUkEx0OSkeAOFBJ1F4OoBbU/JnUER0iyOZpecBspOJOdr3nJuLP72fYAyPG86G5Ah
         9+PHPhoXa54FTr5jZN/acDz2LN3inwp3AmkIha9xM+woYSYI8NY2GKwhuphDBbGUTASl
         UAPC9lEtd2W6oWTtFwKoaUKTXmzb79EvCW7wC98vqTTpZQT8hW6WilPCKlW7iUHIVjcX
         rcWuEnl59o5cXkMZAK5Usx2MAbJTnencIVPAJPUyDdwj4w82kb4V19tc0KdM+ZbD7+2I
         T1VA==
X-Gm-Message-State: AOJu0Yz7Y8DxZDOTnsMAO+2M1X3LHGNeDTZTefJE9z6P8QB7ZZNP0ZN4
	VZb0pRtmc4SbT9y7HKLo1OEKmltp3zYMaQU6/bA11/3TWmxntDgaeEIuWzJrfXwSFmGXEktZw+K
	9iDbywmSHEFegjjJC9k20n6KMMtvqATw=
X-Gm-Gg: ASbGnctFTajDnw+RcRfPVp/oe/oumAAaOvQfBy/g5bGQJ7dOsmUwbS+snPw9YMS+fTi
	6bnzil+331Dq/2zq+CAG4sgu/dwxn8TDEGFZOFk76PGpTNqwPhYQJyMF1JrHBUZ1OJMXwZ+gNks
	XM/YUkyYVoUujp6WmCnL1KEgue4JlcNc6qsLDqcif6cnbKqpofw35LWnF3P2FUGTMGQnVu5E3AT
	ix5ax5hBSTskhNiPJ9vMsCCV/3fvtjHFuvpEzRXXXcJegfuQSvMEZxi6hQn3RqwRRK0+r/Hcz37
	oKTRDE4HVqw=
X-Google-Smtp-Source: AGHT+IEGQ85XhZEhKH5h5Lfi8UP2rxKI9DL75Cd87eZEEXwX3fis/UXrcV0y9f0bDUJzlJhMrSLfyBqXOYYDoYp9AR8=
X-Received: by 2002:a05:6000:430e:b0:427:813:6a52 with SMTP id
 ffacd0b85a97d-42b4bdaeeeemr171423f8f.41.1762886153125; Tue, 11 Nov 2025
 10:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106052628.349117-1-skb99@linux.ibm.com> <CAADnVQL3njbb3ANFkDWYRC-EHqAqWSwYs4OSUeKiw4XOYa+UNQ@mail.gmail.com>
 <aRNJE5GRUxdlJbZB@linux.ibm.com>
In-Reply-To: <aRNJE5GRUxdlJbZB@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 11 Nov 2025 10:35:39 -0800
X-Gm-Features: AWmQ_blGfD4ejxDR3wU_DBvkCzWL8lZb2tvYxWR8OAf4rdjOl-Xg9GCng8SORHQ
Message-ID: <CAADnVQLbMZdMO1zM2OhLsX+w22wQnNQWf60fazctCeEzPUfr0g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix htab_update/reenter_update
 selftest failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Hari Bathini <hbathini@linux.ibm.com>, sachinpb@linux.ibm.com, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:33=E2=80=AFAM Saket Kumar Bhaskar <skb99@linux.ib=
m.com> wrote:
>
> On Thu, Nov 06, 2025 at 09:15:39AM -0800, Alexei Starovoitov wrote:
> > On Wed, Nov 5, 2025 at 9:26=E2=80=AFPM Saket Kumar Bhaskar <skb99@linux=
.ibm.com> wrote:
> > >
> > > Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection and re=
covery")
> > > the updated path on re-entrancy now reports deadlock via
> > > -EDEADLK instead of the previous -EBUSY.
> > >
> > > The selftest is updated to align with expected errno
> > > with the kernel=E2=80=99s current behavior.
> > >
> > > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > > ---
> > >  tools/testing/selftests/bpf/prog_tests/htab_update.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/t=
ools/testing/selftests/bpf/prog_tests/htab_update.c
> > > index 2bc85f4814f4..98d52bb1446f 100644
> > > --- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > +++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
> > > @@ -40,7 +40,7 @@ static void test_reenter_update(void)
> > >         if (!ASSERT_OK(err, "add element"))
> > >                 goto out;
> > >
> > > -       ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
> > > +       ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
> >
> > Makes sense, but looks like the test was broken for quite some time.
> > It fails with
> >         /* lookup_elem_raw() may be inlined and find_kernel_btf_id()
> > will return -ESRCH */
> >         bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
> >         err =3D htab_update__load(skel);
> >         if (!ASSERT_TRUE(!err || err =3D=3D -ESRCH, "htab_update__load"=
) || err)
> >
> > before reaching deadlk check.
> > Pls make it more robust.
> > __pcpu_freelist_pop() might be better alternative then lookup_elem_raw(=
).
> >
> > pw-bot: cr
>
> Hi Alexei,
>
> I tried for __pcpu_freelist_pop, looks like it is not good candidate to
> attach fentry for, as it is non traceable:
>
> trace_kprobe: Could not probe notrace function __pcpu_freelist_pop
>
> I wasn't able to find any other function for this.

alloc_htab_elem() is not inlined for me.
bpf_obj_free_fields() would be another option.

