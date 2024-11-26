Return-Path: <bpf+bounces-45662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E49D9F29
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 23:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A9DB2308D
	for <lists+bpf@lfdr.de>; Tue, 26 Nov 2024 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7141DE3AA;
	Tue, 26 Nov 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7aV0vwW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B421DA632
	for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732659599; cv=none; b=DTv83mUdwuBdbYN73lmF7tFb2erqybERLMcmplciU1bGQq6/9Zl/s3l3jg5bVmSmiU9I9pXOnsXgGC6fA/NV2kI9BxU6xy6M4Kyf6DCUlcgPrIPed4MOhmCkuzBvnwvDw0A+WBsMmSwpMoQ3At8x29BLdlNlRRgylvRNdkzwhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732659599; c=relaxed/simple;
	bh=zz7TNvBx5xi56zhPJmKiPDo54/M7QCmW2BO/wLB1yms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkvxefI6LObLGgLog4LOS6QxjO4jvXWmm9H/z5PmXJV+q5H5wMcZ/Sa//VDSPwzyu+3Hboo9pdjPkl8boAgIbis7lrGGedjf263JmxYm7L8PiavAL+lxfTBQZNsIzfDMqFqvi5K52Lc/earxluSqZzQBfh2Up0nmmGiS0ltGOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7aV0vwW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d027dc53ccso868a12.1
        for <bpf@vger.kernel.org>; Tue, 26 Nov 2024 14:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732659596; x=1733264396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGY7QwodFNYUHclakP/2Adi3pmyV0Lark245Z598Wx0=;
        b=e7aV0vwWwyMBnxoJgWPy8Q/A2gquIB4D5nbjDKlj2VjoZeXQto5ayzZXZJHWqkRDOq
         UOj6ns2f9QdMMuZDHNIPU2VZTjBjhe3qy4mo+JbLvrcxSOA8IzkTnePREa1KJe9u1fGE
         flZhqiM4sOq2E28RK2Sf3IvgotzwOsX5wtnzKNYbBBpUmR3nt/vbVNl7XqfNS7+1SgMD
         +vk4CCU4Nv67Hr8slYFsNrpo0+CpJCBbnu5wUYTk95/LqlIU05XpA6aXlY8Gf46mXHOb
         McjXTVjc82ewY4qKPV2WBPG2W10YIePsd5tX2sl9ef8wJBkMlPrtj5eytzuIx/sXUDJr
         s91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732659596; x=1733264396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGY7QwodFNYUHclakP/2Adi3pmyV0Lark245Z598Wx0=;
        b=vu6DvCP7Otrsy2iTu+o1C9qdJD8BJ8oHERML4WTC8LLT8tTKBjid51GDIxbrtbGbQ8
         SwWtkPg5ZEGLPAsAtBPI0qDEnyT98YAGnJjmt9FTd8OKltiZB4B4xB/Lhu5DRM+i8Aw/
         IEMfVhvJjLjCHwD8dchywhKj9bTulHf9OxNMlrIk+76ckg8VcuCXPLxOQ+gCHhYsSKCL
         P/WwKlMIokASNGtzV4IaJQ6RlMbiYAZYlCA9G5cEfgOM6S0Zx0WIhfaYdDtJ2GUQppca
         I04ezpDoaBnStlSDbxnPuoTStr70FJ+c0kGixU91/QKznFAPy3WARohAJMM/vS8GieUw
         l9bA==
X-Forwarded-Encrypted: i=1; AJvYcCUuZWrMiQFsIh+8fYLBmeyT3dh4g4zK7wIC8t9rTVuOpJxOyiKmCrrse0jHBsuTcvpAjvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe0YbY3NmFwTWlJDZDVmfMlxXwC1D5VNh/9US3Y0C+08GPHSBu
	iWhNcG21ZjpEiHLmYbnufucSBGkL2WDlYkdRTyKM6y0DTPQ/h/grta+HUkR2jojkj3O9mLy8PGh
	eOGrdauq+bh5sbxtPSgoy5Lxy+xHAyy3sA/48
X-Gm-Gg: ASbGnctVsMWcweQYjEK/tLtNFR82dtaME1YonmgXTC3gbE/7xzebkj3hyQQ34uXBxG5
	sfAFOwfQL93uUMPfHT93GzcUAVzjjSQuB7B2AiwTSPbkzXVz8gKou7eFIhqM=
X-Google-Smtp-Source: AGHT+IGghalrCXpABL/y3u0zloXzVTx5bHkDBo/FoL8D++lML0LriucShqcXgM/1fJ70ZztUyHF/HnMjC7+FhnM8r9k=
X-Received: by 2002:a50:d4c2:0:b0:5cf:ab12:1aab with SMTP id
 4fb4d7f45d1cf-5d0810a95e4mr30644a12.0.1732659595892; Tue, 26 Nov 2024
 14:19:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122035922.3321100-1-andrii@kernel.org> <20241122035922.3321100-2-andrii@kernel.org>
In-Reply-To: <20241122035922.3321100-2-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 Nov 2024 23:19:19 +0100
Message-ID: <CAG48ez06=E-rXYk59yJR2aKFD2yaqcQu+6wqVau9pQ8X36A+aQ@mail.gmail.com>
Subject: Re: [PATCH v5 tip/perf/core 1/2] uprobes: simplify
 find_active_uprobe_rcu() VMA checks
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, 
	torvalds@linux-foundation.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, surenb@google.com, 
	mjguzik@gmail.com, brauner@kernel.org, mhocko@kernel.org, vbabka@suse.cz, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, david@redhat.com, arnd@arndb.de, 
	viro@zeniv.linux.org.uk, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 4:59=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
> At the point where find_active_uprobe_rcu() is used we know that VMA in
> question has triggered software breakpoint, so we don't need to validate
> vma->vm_flags. Keep only vma->vm_file NULL check.

How do we know that the VMA we find triggered a software breakpoint?
Between the time a software breakpoint was hit and the time we took
the mmap_read_lock(), the VMA could have been replaced with an
entirely different one, right?

I don't know this code well, and your change looks like it's probably
fine (since the file is just used to look up its inode in some tree,
and therefore for incompatible files, the lookup is guaranteed to fail
and nothing will happen). But I think the commit message looks dodgy.

> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/events/uprobes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a76ddc5fc982..c4da8f741f3a 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2305,7 +2305,7 @@ static struct uprobe *find_active_uprobe_rcu(unsign=
ed long bp_vaddr, int *is_swb
>         mmap_read_lock(mm);
>         vma =3D vma_lookup(mm, bp_vaddr);
>         if (vma) {
> -               if (valid_vma(vma, false)) {
> +               if (vma->vm_file) {
>                         struct inode *inode =3D file_inode(vma->vm_file);
>                         loff_t offset =3D vaddr_to_offset(vma, bp_vaddr);
>
> --
> 2.43.5
>

