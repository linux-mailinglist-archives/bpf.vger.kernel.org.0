Return-Path: <bpf+bounces-49228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C238CA1579E
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E297B161704
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9311A7274;
	Fri, 17 Jan 2025 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPQtfllA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205CC25A63C;
	Fri, 17 Jan 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737139993; cv=none; b=uCPTzSbdb+0h0hONiAmvOm3aro7ndS6L2TN99W0lUMk0IWBYOpOMulLlwlISEPDnOyQl/Fk62fN8H3i07qIFZ+U5EcPHAZPkt9k1hhHeeCVGl3nblA1nULUDBTFtHtxnrr7YRmeTm92/pEr0WAxxP4q3O9mAVMsXGv6xnCdkLwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737139993; c=relaxed/simple;
	bh=WFeo/ed44mn9pJ4nlRB7GVZ4yNSIel+SlvP2ekVg4iY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8XVApkvyrMG+DW4w8M4XXgJvjBgjEf8A//o2lguGVez7i+YlIWzfbDW9Bqv/aE/2O8zyJyj7TlU4lcKTsM8/8caJYa8tGpwm+CID1FcMk1X+aTseXpHSNxMTGG80ivO3TRvZtzUSDmTiFbiz8IhcYkM+0ECbXXJqc5jRXjrcDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPQtfllA; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2a3d8857a2bso1389036fac.1;
        Fri, 17 Jan 2025 10:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737139991; x=1737744791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApYxoev8xGIfX4iPGqFUf6Z3OhUa3ivxI9SX+VljGuY=;
        b=cPQtfllA1qVtw53iioTr0oRjn9ktOx/xAEgPly7BzG1Fpingud+mNViZ9g9hYEDw+S
         vckY+Dmv8x5oN69jiZOUpp/1xDUI5YBRtn5c6JO9O76FBbkjIKLARpG+JgKhLANpzaFt
         6spTtMxT/yIa13l61uAdor2IMK9JZfsqB6mETVdAnSRLZ4hrlJHEWlFilXiGHQSafVhL
         3XMckxpLJm2DPUSfCbRZhmMJJaky4CJl72T8G7QxfxVx3p60SDKl071Qd4wGc9M/CJh4
         aUx5/N0nAk1XWFxPVXGYEk7LDElvY5dmABmOtQiHqzH0nEsCd4PtnqLB4pfaqNx+hB0m
         KWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737139991; x=1737744791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApYxoev8xGIfX4iPGqFUf6Z3OhUa3ivxI9SX+VljGuY=;
        b=Gp4ZVo67eXhI/agxkXKhFFykmL4Z80TQbclSa0FvEaPIfIRqDIcpj6D8M68nRO/j0+
         dJecVaABMgH0gEyGnpJMBB18fjzEz9ra5e93Zw+BEhP050vX5LQZP77+TuFlVgGc6EqR
         erQZmWoeWU28kUcYg3yObEZg5eDluATA7Nr/dcT3y7u56aNyPdm5SxFA54tZfJ3/GUH9
         u4RZOGjuzedIi6CCJT+iAU6mn8bYjDIBNPCIiMA2xnFhWHqXKbfwTX7uonQ8Zmk0D5VA
         pe5lAfy4LgMW8ePqD4TBoW+iUUU5U1oM33ZgAOOl5Jqs6ThLYvB3/pAtdGX5ZRBhJQav
         W+wA==
X-Forwarded-Encrypted: i=1; AJvYcCVv4T+5cnXIjj4xk0CPHL0bXYG9tqfKoq//9RvTU9RbQXmBfzC5KGXvVYj+BN154/8IYHk=@vger.kernel.org, AJvYcCW5QgMO67qOvAOMxrOR7MDaDsvCE/9VkxBBgCouR8gIy4u2l86y9LpT0uhzU0Q1D0iEc3n5wEADj/nijGS3wfl+uaKV@vger.kernel.org, AJvYcCWNFVKAOxvMfPX6vN5rfhlZ7CYFN31zxzPtO1Cb/47VfxV0UaQ09HKl4bF/GmpsaI9aZ2qmgVrB@vger.kernel.org, AJvYcCWiXokUKeK6FkXvNVd1ChtEUJclk6C7ZnyChfORS4E341GFQ+mO259CZrTAuROSi08pF2iD2OuVC1kV@vger.kernel.org, AJvYcCXfD8cWabxapDaJ1HkWcG861awHDhrNqsuhYyiBW+gwafBOxUvmN5FVrdKiz73Q3aYZKb6QpbQjT3IOTmLc@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7D6yILe8N8QxzOqkwxFcjsKPifeYMdmIOE4yJWrc4qe7ytPko
	qRVv146loz8E/ORX2fi6T0mc0WBpnt5bxQQvT76O2RNeDGFIEP1Y44aQA38OwRix3lihqCR3vdq
	dagEvVSmBi3BQlsG9BPjzxYqkUjY=
X-Gm-Gg: ASbGncsk75sSPeC9P0Ze+0pN0bC6xZJtmMdnWXBrJ54Qr7PS5MClbpPgDuNjV9fWWuV
	XupwCXVJPWSSjPA1a6xtv3nIG50q1KimzqGmrDQ==
X-Google-Smtp-Source: AGHT+IG2778Hb7D5FfNAbNylPjsx+5iabMr7hPZlFHvmnJdrZ2q1ggLb0Pv8KqZnaw5A+wvqXFnMM50gxp6LKDx3KM8=
X-Received: by 2002:a05:6871:4608:b0:2a3:d9b3:3d01 with SMTP id
 586e51a60fabf-2b1c0b50794mr2762433fac.29.1737139991095; Fri, 17 Jan 2025
 10:53:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com> <20250117183416.GA16831@strace.io>
In-Reply-To: <20250117183416.GA16831@strace.io>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 17 Jan 2025 10:52:59 -0800
X-Gm-Features: AbW1kvbuwV9Pt98fH1exRUkwPLknE0Qo80bqoxx9232MPZZyWH5QxUOnsu7X3qQ
Message-ID: <CAHsH6Gs0DuU691WS0BrabOhJzUTkUwTQODo6XctzeUs90ULAgA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 10:34=E2=80=AFAM Dmitry V. Levin <ldv@strace.io> wr=
ote:
>
> On Thu, Jan 16, 2025 at 04:55:39PM -0800, Eyal Birger wrote:
> > When attaching uretprobes to processes running inside docker, the attac=
hed
> > process is segfaulted when encountering the retprobe.
> >
> > The reason is that now that uretprobe is a system call the default secc=
omp
> > filters in docker block it as they only allow a specific set of known
> > syscalls. This is true for other userspace applications which use secco=
mp
> > to control their syscall surface.
> >
> > Since uretprobe is a "kernel implementation detail" system call which i=
s
> > not used by userspace application code directly, it is impractical and
> > there's very little point in forcing all userspace applications to
> > explicitly allow it in order to avoid crashing tracked processes.
> >
> > Pass this systemcall through seccomp without depending on configuration=
.
> >
> > Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return =
probe")
> > Reported-by: Rafael Buchbinder <rafi@rbk.io>
> > Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J=
7BidmcVY2AqOnHQ@mail.gmail.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> > ---
> >
> > The following reproduction script synthetically demonstrates the proble=
m:
> >
> > cat > /tmp/x.c << EOF
> >
> > char *syscalls[] =3D {
> >       "write",
> >       "exit_group",
> >       "fstat",
> > };
> >
> > __attribute__((noinline)) int probed(void)
> > {
> >       printf("Probed\n");
> >       return 1;
> > }
> >
> > void apply_seccomp_filter(char **syscalls, int num_syscalls)
> > {
> >       scmp_filter_ctx ctx;
> >
> >       ctx =3D seccomp_init(SCMP_ACT_KILL);
> >       for (int i =3D 0; i < num_syscalls; i++) {
> >               seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
> >                                seccomp_syscall_resolve_name(syscalls[i]=
), 0);
> >       }
> >       seccomp_load(ctx);
> >       seccomp_release(ctx);
> > }
> >
> > int main(int argc, char *argv[])
> > {
> >       int num_syscalls =3D sizeof(syscalls) / sizeof(syscalls[0]);
> >
> >       apply_seccomp_filter(syscalls, num_syscalls);
> >
> >       probed();
> >
> >       return 0;
> > }
> > EOF
> >
> > cat > /tmp/trace.bt << EOF
> > uretprobe:/tmp/x:probed
> > {
> >     printf("ret=3D%d\n", retval);
> > }
> > EOF
> >
> > gcc -o /tmp/x /tmp/x.c -lseccomp
> >
> > /usr/bin/bpftrace /tmp/trace.bt &
> >
> > sleep 5 # wait for uretprobe attach
> > /tmp/x
> >
> > pkill bpftrace
> >
> > rm /tmp/x /tmp/x.c /tmp/trace.bt
> > ---
> >  kernel/seccomp.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 385d48293a5f..10a55c9b5c18 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1359,6 +1359,11 @@ int __secure_computing(const struct seccomp_data=
 *sd)
> >       this_syscall =3D sd ? sd->nr :
> >               syscall_get_nr(current, current_pt_regs());
> >
> > +#ifdef CONFIG_X86_64
> > +     if (unlikely(this_syscall =3D=3D __NR_uretprobe) && !in_ia32_sysc=
all())
> > +             return 0;
> > +#endif
> > +
> >       switch (mode) {
> >       case SECCOMP_MODE_STRICT:
> >               __secure_computing_strict(this_syscall);  /* may call do_=
exit */
>
> This seems to be a hot fix to bypass some SECCOMP_RET_ERRNO filters.

It's a little broader than just SECCOMP_RET_ERRNO, but yes, this is a
hotfix to avoid filtering this system call in seccomp.

The rationale is that this is not a userspace created system call - the
kernel uses it to instrument the function - and the fact that it's a
system call is just an implementation detail. Ideally, userspace wouldn't
need to know or care about it.

> However, this way it bypasses seccomp completely, including
> SECCOMP_RET_TRACE, making it invisible to strace --seccomp,
> and I wonder why do you want that.

It's a good question. I could move this check to both "strict" seccomp and
after the BPF verdict is received, but before it's applied, but I fear this
would make the fix more error prone, and way harder to backmerge. So I'm
wondering whether supporting strace --seccomp-bpf for this particular
syscall is a priority.

Eyal.

