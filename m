Return-Path: <bpf+bounces-51643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E838EA36C00
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 05:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B28E7A4ECF
	for <lists+bpf@lfdr.de>; Sat, 15 Feb 2025 04:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009C5154C08;
	Sat, 15 Feb 2025 04:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVtN2BZS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE7748F
	for <bpf@vger.kernel.org>; Sat, 15 Feb 2025 04:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739593858; cv=none; b=nu/ot5hiVOCWqq0i9yr2N41XUOlIsemW3BK7yETK2hBvs0o/K6or8vvSsvv6KDrImMczHFo3w5+Q6tVRvtgaslHCzhK99ow6wm232C1eilmo2Dmz1POStmFY1tWPymGmNsrzVntuDoETHflMNwEXfIxUEDb8rlK/3aCUrtJ57lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739593858; c=relaxed/simple;
	bh=UOHRSyGXK7U6DiObiiy+Ft0Sj/pyMQxRsNvLXfERG7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GGUX98XgsPyvsmH7NLZzAFZkr3VxXjXQg9sTAuQjFNoni3cShC4wtfuyykmZx3h+CkLBnCeX519ZyXCilxZ5SwjhI7k1Mh3/Vph9p+Iqpcd5PNmzhTUxZySfTE5gMHtCmGm76rm98hgNcKUpENWDhTa8OHqvdAIOJSsxrToOgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVtN2BZS; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e5dcc411189so55127276.0
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 20:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739593856; x=1740198656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iMzle/DVnhytojyPfHhlTi8cdackX5Bk1t0zWtVrvw=;
        b=eVtN2BZSS1bJ6RnBB871RniH7kTg3BMFyas07Jh8YgQ9g61oDmsLlWu4H6eE4GknOb
         u7ZiIayMHuLGdj+dd6xiflb1z2SWtqn1anZA8pbEMa5vYT/VeJXQFYSNZ8dBecH6yeP7
         Bsk/hW3nEEwJ3dfazrrsEoVaknFTQHBwABRROCc3lH7FEa2zsBUyPy7jGxxYNP1E1DxA
         b48LOYK8hNICvTmu+8dfMFjUtBbS4FautyEhJY2xaprDuvWO50QpUVICP4ZABLbPNA4p
         rYYz5IMT0cCp8vqBeieHxK8SXz9Eiq6GX2wE8JLv27us1FzfNLDDML5nWLFRV0n3rp7h
         IBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739593856; x=1740198656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iMzle/DVnhytojyPfHhlTi8cdackX5Bk1t0zWtVrvw=;
        b=QZTfqSge6J+QWWbm/YLmU+q+N+BhiimcgmE8KhOYqPBL74NICJEgS6XiYtK7We2ncj
         Wmu6nplsDZwFeftjbEPyQGqD53jsHQupghkVjW5exYxWN2+3xdWFt5w/B49EHwfBQgJc
         3KOYwLptLK0LApjfm5XwPg4TSh4mYz/6MT6yppWlsQID/OBF2/1tkRXFMUFclwXpE9jA
         R1rUNQRbb5y4Ib7xfBgMzGcI+4CqZvs02YX5q3fZ0gs2cvYKGo9ImB3DbP4F9+xHTbKv
         5QPdQ7G27WUdvijb6ePR4INtzs0f+NSzKXkN/nycFPgeAknf7RXmCk992c21vhTkRCOw
         cYCA==
X-Gm-Message-State: AOJu0Yz0x/NDw2qUWOxRWAF4cs2G1AntAedfcC+AlV0H3vn6npRvlGE3
	hcHQPN/OZd5Gk08PJK7bOXJ16Cqn0rQNXWyYziGOzY+Y0qamhkQGYJUoCEe6UdJ4+o65CJbF199
	BKNa3kq5e5ll86G136iVyEayK0XwH4g==
X-Gm-Gg: ASbGncumJNhtRo7V2r9ncKW85rKsp9lj7Bv/dTQJZDo3l8ZXw5qf4bMnnR9l5nwQNvb
	eXskafQi70xGfc2sZ3RcTOVrFZ3WQ4w8r7VXOQfYTcc7RAijBtJZvBQ3jhhnuDqND+zzvk8Zy
X-Google-Smtp-Source: AGHT+IFlBz1R6KfoO8FHbp3rr3qoF9IMQM9BNG1igxuckyFrVgfPwk3xJbNRI1Qm6tNGCL40HGNDBNgFfi52hT8UV64=
X-Received: by 2002:a05:6902:1a4a:b0:e5d:afe5:8c2b with SMTP id
 3f1490d57ef6-e5dc9045af8mr1643195276.13.1739593855836; Fri, 14 Feb 2025
 20:30:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214164520.1001211-1-ameryhung@gmail.com> <20250214164520.1001211-4-ameryhung@gmail.com>
 <227f048e-402e-47c3-b989-27b8e88c83bc@linux.dev>
In-Reply-To: <227f048e-402e-47c3-b989-27b8e88c83bc@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 14 Feb 2025 20:30:44 -0800
X-Gm-Features: AWEUYZlOX_kGYpmwB18HIlmQWbh-ixwySGepmp1x2kWYtxdB0czX3_DJAppkxc8
Message-ID: <CAMB2axPekh5qOu0vHNS0+iDHKuk=124UM7z2ezO2G0OuKJKFqw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/5] selftests/bpf: Test referenced kptr
 arguments of struct_ops programs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, martin.lau@kernel.org, eddyz87@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:14=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 2/14/25 8:45 AM, Amery Hung wrote:
> > diff --git a/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fa=
il__global_subprog.c b/tools/testing/selftests/bpf/progs/struct_ops_refcoun=
ted_fail__global_subprog.c
> > new file mode 100644
> > index 000000000000..ae074aa62852
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__glo=
bal_subprog.c
> > @@ -0,0 +1,39 @@
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "../test_kmods/bpf_testmod.h"
> > +#include "bpf_misc.h"
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +extern void bpf_task_release(struct task_struct *p) __ksym;
> > +
> > +__noinline int subprog_release(__u64 *ctx __arg_ctx)
> > +{
> > +     struct task_struct *task =3D (struct task_struct *)ctx[1];
> > +     int dummy =3D (int)ctx[0];
> > +
> > +     bpf_task_release(task);
> > +
> > +     return dummy + 1;
> > +}
> > +
> > +/* Test that the verifier rejects a program that contains a global
> > + * subprogram with referenced kptr arguments
> > + */
> > +SEC("struct_ops/test_refcounted")
> > +__failure __log_level(2)
> > +__msg("Validating subprog_release() func#1...")
> > +__msg("invalid bpf_context access off=3D8. Reference may already be re=
leased")
> > +int refcounted_fail__global_subprog(unsigned long long *ctx)
> > +{
> > +     struct task_struct *task =3D (struct task_struct *)ctx[1];
> > +
> > +     bpf_task_release(task);
> > +
> > +     return subprog_release(ctx);
>
> One question, swap the subprog_release and bpf_task_release order will st=
ill be
> the same failure, right?  Meaning:
>

That is correct. Main program first will still pass the verification
and then the global subprogram will still fail due to the same
!find_reference_state error.

>         subprog_release(ctx);
>
>         bpf_task_release(task);
>
>         return 0;
>
> which is fine based on the changes in the do_check_common() in patch 2. J=
ust
> want to confirm my understanding.
>
> Other than that,
>
> Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

