Return-Path: <bpf+bounces-61766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929E8AEBF09
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 20:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19773A8224
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 18:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4042EBBBE;
	Fri, 27 Jun 2025 18:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxx9ikdG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136B1EC01B;
	Fri, 27 Jun 2025 18:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049023; cv=none; b=obA5zMzgZqOF3d+9UZK4YvhqS7R+pO4aH4Ya/lm3JV7thv0DRx/CkyY+kXx8kh50lXRTKebacuvuQr2zOwtWVFhaU3MkWRYTGBMh83tetcbibJE9GhXfwRooJwQH/m/16pIFN/kpuYC7m67rHE0wkb727Y2JgKPM3QCjeiyT7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049023; c=relaxed/simple;
	bh=F2kaZL9psam6yAmb7KA4W+jbABJvGz4+PVh9kvOoHJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AV5Iyi4IeAHwTrqEy5GhOEs271lIG1o7Ysc5aZf1Wgj1NVAF+0OIyj51qICoeRCjf2Hfv4XgqQZtztdrOOXKqwpWyIJMU8Gh9SCBKe76Dj3MczL9KqmgxYxMKAMW5zkUBuJVZcNPB93sSKXMdDMAt9SyIzkrxA3bbbejfMwSOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxx9ikdG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4537fdec33bso1178725e9.1;
        Fri, 27 Jun 2025 11:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751049019; x=1751653819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7mIMUcA8vt8Z3ShV10cEWd0HnSw9ixn5R7nBQ5IiR4=;
        b=lxx9ikdGkgaolz4Y3DGXqGj6JB+gQeW543+XDeVO2EdQjILI/Sc3dtUkQinebq6t6y
         TdgTZe891eGQ8H5nDHn+lnwvxLkh1ZWUG757zVUgLNnEWBY7PtrY2YWn79EvwAF7zdXc
         4r9e0ZTOmGjlaQkyg4Rv9wIPNiALIfNncamLwYWQ/Wwpkyv+O580eQ27IfYCCB11CVkw
         GM0vnxEvPwCSpGxZ2B46tGVOzQ6TDupLNptRiXWyxtyi6M0KZacVhicmNImMrsb0RmtT
         EfemvJrvepq4xhq7ZpF0ynovTppckCeFAJnjMCf4pY13ONRFESCk04OdquvBG/eLtltg
         vnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751049019; x=1751653819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7mIMUcA8vt8Z3ShV10cEWd0HnSw9ixn5R7nBQ5IiR4=;
        b=rmj9UmJIjZALNar8O/wxR147J71jlsc4MQ99CnMlcuKX1q3LeZtuYjgm2iS3yXfZHk
         GCBBGXp9+cE/+Jp5hC/gpH/a9W10QeR/g+TUkIa/TfDYV5jBN4c1eoeOFQCnguaH3O1n
         IsscC3X3NEeG5xkvcrhthHMT2B3Jt8QeKKJ0SMi5FOZMg01uNaf+0v7cdQXNc2+hO3HI
         dW0RMtuRqaBmxLqb9u9Y8iIfJ4rN6EJpcZ0UF26iQWjupV/Gjx8iuEj1daddBhzIgYxk
         EmCt65Cus1O4EqDbe8M13+F9cauiJWceUIPlp+Scs6B4mtAxE/WJnHDtwntq1imyMhUh
         ptJA==
X-Forwarded-Encrypted: i=1; AJvYcCUpAwAGyKahe+bEL9gCVu04Rhh3ONpxiTpMm0OU0qomW6uaSKTPiniBsZU03h3m8cwG1pVx5kKP@vger.kernel.org, AJvYcCWlgCS447Zr4OLzaKUmgV5BaoRhSlRqbXQK07IMu+WsDTq0GwwZtYLwkMsK7mY5rysAT425MPSd71d+6Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLx5r+5IZb5emIPcHhYfYgkyYn16f6CFjT8/b0knR3q4YSsfxP
	+dXErcu8IfS5DrKWbkHlLzmUkI9Llot9CeBt9PyWADByAkvvRCnwOUECvFmc5UN1F3ZGVnjLQC9
	8k/Aa7IDfhV0sbA9DBNAYYFQC3VaZpGm10z0y
X-Gm-Gg: ASbGncsnq7/MJ0LHbnX8nwKS1T/zH76W5U0hnJnuxIsVQnlYJyw5jtkyGYHwZ8xr/il
	BNZ+qnMUWYXeQBTRavMZLZNOiKISURnYI+fRVd00xJQ/nB6/Z/b65+Ln6GOS+KcaBceyxUhB2JK
	J0ByNtWyP5ts8KboQWZEvSM+ax18mLOQrVVRdi9DUgd/ykJvLQqpWJWn0ZfJDTQJSToo6+8WfL
X-Google-Smtp-Source: AGHT+IFi5QtSWxRQLTobs98JpyVNRyqI2s1I9wNiFtZIjauVVuTSgsc9OfjvRILohIVXzIRk5CXnQtZDpFVjhdPXQwU=
X-Received: by 2002:a05:600c:3152:b0:453:c39:d0c6 with SMTP id
 5b1f17b1804b1-4538eea44a4mr44044025e9.32.1751049018559; Fri, 27 Jun 2025
 11:30:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1444123482.1827743.1750996347470.JavaMail.zimbra@sjtu.edu.cn>
In-Reply-To: <1444123482.1827743.1750996347470.JavaMail.zimbra@sjtu.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 27 Jun 2025 11:30:07 -0700
X-Gm-Features: Ac12FXxwEkxDnRQ8M5fp4bFvaKU9qj0Y_YDaHq7PejEC2_9p-vI4ymrzoYoKo28
Message-ID: <CAADnVQKwC0OnJMY6ZueA+QnRmmZMB0hDyvX9-gx_0m5TA=o33Q@mail.gmail.com>
Subject: Re: [BUG][BPF] Kernel Bug Triggered when Ebpf Verifier Check Fails
To: =?UTF-8?B?6ZmI5LmQ?= <tom2cat@sjtu.edu.cn>, Eduard <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:58=E2=80=AFPM =E9=99=88=E4=B9=90 <tom2cat@sjtu.ed=
u.cn> wrote:
>
> Hi BPF maintainers,
>
> I'm reporting a bug I encountered in the BPF subsystem on Linux kernel ve=
rsion <<5.19.5>>, <<6.15.0-rc2-00577-g8066e388be48-dirty>>,  <<6.15.3>>.
>
> I wrote a BPF program that triggered a verifier rejection, but at the sam=
e time, the kernel emitted a BUG() warning at <<kernel/bpf/hashtab.c:222>>,=
 suggesting a potential kernel-side issue rather than just verifier rejecti=
on. Later on, I discovered that constructing any ebpf Verifier rejection be=
havior within the specified code snippets would trigger this kernel bug.
>
> - Miniest poc code:
>
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
>
> struct mac_table_entry
> {
>     struct bpf_timer expiration_timer;
>     __u32 ifindex;
>     __u64 last_seen_timestamp_ns;
>     struct in_addr border_ip;
> };
>
> struct
> {
>     __uint(type, BPF_MAP_TYPE_HASH);
>     __type(key, struct mac_address);
>     __type(value, struct mac_table_entry);
>     __uint(max_entries, 4 * 1024 * 1024);
>     __uint(pinning, LIBBPF_PIN_BY_NAME);
> } mac_table SEC(".maps");
>
> SEC("xdp.frags")
> long mac_xdp_func(struct xdp_md *ctx)
> {
>     // Constructing any code segment that does not meet the requirements =
of BPF Validator
>     // can trigger a kernel BUG: sleeping function called from invalid co=
ntext at kernel/bpf/hashtab.c:222:
>     while(1){
>         __u32 j;
>     }
>     return XDP_PASS;
> }
>
> char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
>
> - Kernel version: <<6.15.3...>>
> - Architecture: <<x86_64>>
> - dmesg excerpt: <<BUG: sleeping function called from invalid context at =
kernel/bpf/hashtab.c:222>>
>
> Detailed info including reproducible BPF program and kernel logs have bee=
n filed on Bugzilla:
>
>   https://bugzilla.kernel.org/show_bug.cgi?id=3D220278

Thanks for the report.

The stack trace is the following:

[  280.376885]  __might_resched+0x494/0x610
[  280.376892]  ? __pfx___might_resched+0x10/0x10
[  280.376900]  ? __lock_acquire+0xaab/0xd10
[  280.376909]  htab_map_free_timers_and_wq+0x413/0xaa0
[  280.376917]  ? __pfx_i_callback+0x10/0x10
[  280.376922]  ? rcu_core+0xc6b/0x1760
[  280.376927]  ? __pfx_htab_map_free_timers_and_wq+0x10/0x10
[  280.376932]  bpf_map_put_with_uref+0x9f/0xc0
[  280.376939]  bpf_free_inode+0x118/0x170
[  280.376945]  rcu_core+0xcdf/0x1760

Here is the issue that the last uref decrement happens in rcu callback
which is not sleepable, but htab_map_free_timers_and_wq()
has cond_resched().

The fix might be this:

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index 5c2e96b19392..ed8bff8d4684 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -790,7 +790,7 @@ const struct super_operations bpf_super_ops =3D {
        .statfs         =3D simple_statfs,
        .drop_inode     =3D generic_delete_inode,
        .show_options   =3D bpf_show_options,
-       .free_inode     =3D bpf_free_inode,
+       .destroy_inode  =3D bpf_free_inode,
 };

