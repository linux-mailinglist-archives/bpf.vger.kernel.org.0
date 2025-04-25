Return-Path: <bpf+bounces-56723-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E81A9D2CB
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 22:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A171760EF
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 20:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AED22068B;
	Fri, 25 Apr 2025 20:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmnigMN3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635B5190692;
	Fri, 25 Apr 2025 20:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745612185; cv=none; b=tG4Xw7msqXlzG54EUr2ldLYMq9n8fId75GXQ3wQXsyuAghFdkEd3Af7U/hBDZvYNSP5kE8dPH152et+NYXZCyrOZoVmJUWxPiA4wifpWutWlzexWeA0lvrwxCDB2sFb9J6ZBOsHwaOABDFiVxU/8ltUa3e+vMO+JZcNs9i9lAYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745612185; c=relaxed/simple;
	bh=SvQbI9N7Gk1efogbNDjZVBEHSwQPmHTYvGZwdt1PasU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnZdcGjks9pP868T5noUIfPcdflc8hTi2YUf1vMy3G9cpSb53dRAiBYlORUe7thX2GyNsqvbeZerNflsbDV5p56AeINl7EikL1YhY9He26CgJfYHlLtbk4UfWNu3eC8WaPm84mBoxKFoH8E1cZHOsJXnqLnN6Unb6wWSRn+g+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmnigMN3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so25549885e9.1;
        Fri, 25 Apr 2025 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745612182; x=1746216982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QkeVDV//AI1GukUI8NVNNpHYDyvKY5NhFKebS9C1DM=;
        b=CmnigMN3j71DzyELT0Bbkvtz8ef+Fr+pDg+aGHIIKSt/lnRzAXVLq4+fnJS2mxqwiv
         q95ChTfiyFyaov2gL6NlAePdgTt3GhiAhL5eOCw8t8sSq0a+iqAPt7yvAcBhYEpSlu9a
         beNfcWMGKPSyw00VA+4uOQqz0RI7sPInklsulDWxoZDhVu1ZayeAHjb4XwFP0BRuWBXg
         aBI6Lpelrec9aQjqYOEIjB1SFObvyMzeLf/AT1o08lEWYGgQRdBms5rqp8Y3LQ93+kis
         u+/bOg2EAAb4jUs07Z5L8Y8Y5WuFAPAWVsYAaOSN1BrZ3eTjI+WUxA7tphVs3a2HNfdP
         Rkpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745612182; x=1746216982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2QkeVDV//AI1GukUI8NVNNpHYDyvKY5NhFKebS9C1DM=;
        b=w/in32V4N1amkWCJCRqQQQMYCiUat4Qv06/wwSE6CY1dIlqfgLOgC1jFH5BiSU5g9j
         efEBxQRqmppvcIWJmLahPiau7rZoFjy/9/QL2jXHCA0yMco4CjxO/WH/yo0JGIsfrcsC
         h5/9qs0Kmbl495wcuYC3EXxXpLQ+z0/+NpqdFuoIKrl0/48q8HyNWX902sPPiXCdQmSK
         TQyteHStuwGZTFbCzzAJdN4sFExuDyTVyoPRBRji/VrFX7SviWB+easP9OBTxZ5WXHhK
         CI0+XWWXKBccrIEiZZL04nIpUKta9z9+iUC2ETkRuLh9e3ZiQ2yCnNFhwd1Cdlld/ZBE
         gIgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSp57L5t0A2cT1aa2/L8qmutqRz71XEKfhz+tu1SLvZNcu+pBnhzN4daEVQLy0qEegz2M=@vger.kernel.org, AJvYcCW5G0cNgzrL5TDlsJb13aLsZ8AomerE3NS8jRILzzTMOvVn6RG3lY18G8Jl3EwMpL17bsag/Md0zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHVcqsSY39qxPIESYmASG2QlKAoFFeFoYqJtSFTAW6wUhUN5VY
	bliPRyB5068HwHxD3EBS+ODrJTKEpziSgHPK+Fz4T5Wm329NekMC05M2+Z5lcPuRm/gtaM/2ROw
	zojUViLJoDIJLmik3ZzrrcfWCAVE=
X-Gm-Gg: ASbGnctKBGRBTqytrvBPlXTDNZrVMnWuPP5zCqqbnY9qkOEvxckMQuv9FOj8z6IW+Z1
	2nZuMVuXzX+bSe2IxnnLCb/5hQk1CbiNS/DGrdooxzUAdtX439D+KZheIB16mvTeyOehKnvntN5
	EU65fs958t/cs7Cb6+S29F+g/b8FzjTt7G25adgQ==
X-Google-Smtp-Source: AGHT+IGFLtLfxLdT9KubeFJ5N6f/1w/zt/u6PvxnHMQch7EGTJdiz7sqyKEq8k9WNY9uP/9+6fyL4qsyW7VyqsQr+Jk=
X-Received: by 2002:a05:600c:3491:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-440a66b6fb1mr32810365e9.29.1745612181372; Fri, 25 Apr 2025
 13:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
 <m2v7qsglbx.fsf@gmail.com> <m2h62cgh7y.fsf@gmail.com>
In-Reply-To: <m2h62cgh7y.fsf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Apr 2025 13:16:10 -0700
X-Gm-Features: ATxdqUEhYzagOs8qsfw_ZqOoO4tlKaAbYmZG1jZrWm9PiD4-5QOTOx4jELhSaOs
Message-ID: <CAADnVQJQuAkmE_D_ATp-hZeTtUK4Tn=BOOOx+wPtUB1QpzeQuA@mail.gmail.com>
Subject: Re: pahole and gcc-14 issues
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, 
	dwarves@vger.kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 12:43=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Eduard Zingerman <eddyz87@gmail.com> writes:
>
> > Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
> >
> >> Hi All,
> >>
> >> Looks like pahole fails to deduplicate BTF when kernel and
> >> kernel module are built with gcc-14.
> >> I see this issue with various kernel .config-s on bpf and
> >> bpf-next trees.
> >> I tried pahole 1.28 and the latest master. Same issues.
> >>
> >> BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
> >> When built with gcc-13 it has 454 types.
> >> So something is confusing dedup logic.
> >> Would be great if dedup experts can take a look,
> >> since this dedup issue is breaking a lot of selftests/bpf.
> >
> > It does not look like the problem is with dedup.
> > Quick glance at structure definitions does not show any duplications,
> > just much more structs compared to clang:
>
> Or maybe it is.
> For example, task_struct is added to .ko BTF generated by gcc, but not
> clang. This can only happen if dedup fails to merge structures in base
> and module btf, right?
>
> Here is an interesting observation:
>
> $ bpftool btf dump file ~/tmp/objs-gcc/bpf_testmod.ko format c | awk '/st=
ruct task_struct \{/ {s=3D1} s {print $0} /^\}/ {s=3D0}' > ~/tmp/task_struc=
t.ko.c
>
> $ bpftool btf dump file ~/tmp/objs-gcc/vmlinux format c | awk '/struct ta=
sk_struct \{/ {s=3D1} s {print $0} /^\}/ {s=3D0}' > ~/tmp/task_struct.vmlin=
ux.c
>
> $ diff -pruN ~/tmp/task_struct.ko.c ~/tmp/task_struct.vmlinux.c
> --- /home/ezingerman/tmp/task_struct.ko.c       2025-04-25 12:37:48.31248=
0603 -0700
> +++ /home/ezingerman/tmp/task_struct.vmlinux.c  2025-04-25 12:38:03.09664=
4654 -0700
> @@ -18,7 +18,6 @@ struct task_struct {
>         int static_prio;
>         int normal_prio;
>         unsigned int rt_priority;
> -       long: 0;
>         struct sched_entity se;

I reproed this issue with default .ko build that includes:
--btf_features=3Ddistilled_base

Once I disabled it and did
bpftool btf dump file ./bpf_testmod.ko --base-btf .../vmlinux format c
the task_struct from vmlinux.h and from testmod.h became exactly the same.
So it sounds like the 3rd issue :)
bpftool dump of distilled btf needs work.

