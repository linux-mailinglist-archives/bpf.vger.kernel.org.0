Return-Path: <bpf+bounces-65289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84555B1F1BF
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 02:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35AE6A06B33
	for <lists+bpf@lfdr.de>; Sat,  9 Aug 2025 00:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F2C25178C;
	Sat,  9 Aug 2025 00:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLvV2VRc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE01B241676;
	Sat,  9 Aug 2025 00:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754700404; cv=none; b=GW8IEQkHHQ3bebCaPH4WUhU/Apc8mWEyqZPWTBC2HV0b5Blu9x8y+YItl5n16kntsqSjr2oP1hntVepdiPfgBuGUm68g8S3GnXBB9X67pLrfSZkt/GTxyiPf3lr55Ja0LxL6omdJk59vAv8IKNo7mwPYnTIxXn2v39Pq7EXiulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754700404; c=relaxed/simple;
	bh=P+a/z828C9ATYEw0sufbvgfqo7qMgYNIDVX3sBM5Ono=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RVRFdi8PPgu5NWguCkCA5m0pX46zLCCKTqUHfDAj9xeGPZ6jfHP8Wr5h8nGTe54Xqv5ux1ORpHv/6Nt+rTEV7tW3mLMCdvZYPDGX66ZSmevgNCRMTrS+hV9CM2caiL0+Id+wbx26bWuNePBlCGArjRnWU4Tw/OwWsl6QApGVfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLvV2VRc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b7920354f9so2178577f8f.2;
        Fri, 08 Aug 2025 17:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754700400; x=1755305200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Tkpg7TKm81jroZNDppuJMD1Dmeluu/DX1yG64Mhiqk=;
        b=MLvV2VRcI1geFQkFVDSGblb3G5ouUQHaJqBqV/523HIpvfP7utTJfL2BGkUZj5u5+U
         8v65XVZTD+zBVeKKEaTTlhxYsPPZwtOlMe7A9FSklxEQSySkW8/u6cOw5cr9qXSgfYsZ
         /xUjShlZOqeJr7kmU4CDAW+GRiRa2qjhW+cY5ZFWvcMungO1jniDUn8qif/gYXSU4ZaC
         7TW6uwh2rB6Ee4mf2TreJR+xZgQUoMzab4gN3Yia5CEg5LfVkPNLy0rfsOmm8Lc3GWoy
         smO+Y/ibuYDgN36xj0V+fCGq2xJ8VEa/MkYf6bVQ29qCXkIQy+7pJAHVaDjqmoHJwbPj
         ynIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754700400; x=1755305200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Tkpg7TKm81jroZNDppuJMD1Dmeluu/DX1yG64Mhiqk=;
        b=IoJmyBaK7xuQbWZaFejXOcr3BUUTKl1lR3I2SM16ZCXRv8L1QAmH9EKBZ60rshrLCd
         bZheDQCrYzRxcTdgRd5Q7MbC8OTXFjpZb0SC5OCUW6otecu9ONpBJQEwCUQcS8SMDQ4G
         WxGh4CTx+xBJMuppSreIoerc6S3aPQo8MfTsPRxHB72clPMA/jaa9OwOR2WYE06iTfyD
         pHze85GDKUILjRWCc2at3WB8YD1ijvSaAhlmOFhJjTS6U/1lM2hUhHF0yKp+MWXI5FJX
         qZG5QI0eCqfXnWk64EwSBXGl1t/rQKtA5G6jI2+QN87HCD1bn4LOWMhZ7jKRCVxiMlzi
         xVGw==
X-Forwarded-Encrypted: i=1; AJvYcCUgxsba+/76PQbSIC45Nc/kWH2A5Id2Pbioc3DWisYcjG2KaZqiV5vr8DCLD3YSsd9+U0U=@vger.kernel.org, AJvYcCVDynhAo86rrljE+XX3fLtQMCOX4EUSob/FPd5Hb83IoYjv5vUQYa82c+PMBFLKKx7LOZoDF1BXn6z75THKjG+Tc8xD+QoQ@vger.kernel.org, AJvYcCXBUZgUsyNemtKEBt8mP2aZpYq1/bDCtPVrdo5tGQaQIgtglRDSADfydvOhSNvzVkIRzW0HZKhaCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAkTYSvQ1bCaQVnj/Y5D1W1aqlX/+YBZQVm6eSePt7NCyJGlPY
	EPp/n7QxRUQb3aVc+Wx3KnVh45rIDgHMRjIqfhy3UjnnlCwT+fIJ3f+gVoLCCvkDALWvMI7UT00
	JksIQAfLZ6AWPBudEs3blPwfw8ib2XhDx+Dxz
X-Gm-Gg: ASbGnctvTClvS1IAoS/eTggvND+dITTkF6jvnY/a/8+ucwV+AwVI0ao6nW+cmGMkm9s
	WjtvC5o7Ur4ENcbNYCrKbhtKKxnWlJmmLxpV+41dU1xgNCEEE1E2Op1yltxzj2ZvCkxtPGc0ZuK
	dEKZheWvKtV1b6HvN1qONqnOxvg/Ea5AEMGC8xn52/UPPlA66ftontNKqoe2O8nqXu85MPPsxKp
	AE6UYeMHMpr3z5kTJiTvwi8uYNCbtWYDvNiroK4mpaSLYA=
X-Google-Smtp-Source: AGHT+IFKnvIzImzl3LA5pnqzFEDOEfM4xuewqEC0eQSIqSxv7muiupFafpiall8CxrzWzHrIAEJGROyKQhExuHEnI7k=
X-Received: by 2002:a05:6000:2dc9:b0:3a5:527b:64c6 with SMTP id
 ffacd0b85a97d-3b900b4bf19mr3967463f8f.1.1754700399656; Fri, 08 Aug 2025
 17:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806143105.915748-1-omosnace@redhat.com> <aJP+/1VGbe1EcgKz@mail.hallyn.com>
 <aJaPQZqDIcT17aAU@mail.hallyn.com>
In-Reply-To: <aJaPQZqDIcT17aAU@mail.hallyn.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 8 Aug 2025 17:46:28 -0700
X-Gm-Features: Ac12FXy-7S_oVP3iFlr9nXbpoGzrDRbVEcktC11QXsWmKk6RZ_NInkzKLSEgWn0
Message-ID: <CAADnVQKY0z1RAJdAmRGbLWZxrJPG6Kawe6_qQHjoVM7Xz8CfuA@mail.gmail.com>
Subject: Re: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
To: "Serge E. Hallyn" <serge@hallyn.com>, daniel.sneddon@linux.intel.com, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, alexandre.chartre@oracle.com
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, selinux@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 4:59=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> w=
rote:
>
> On Wed, Aug 06, 2025 at 08:18:55PM -0500, Serge E. Hallyn wrote:
> > On Wed, Aug 06, 2025 at 04:31:05PM +0200, Ondrej Mosnacek wrote:
> > > Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but inst=
ead
> > > use bpf_capable(), which checks against the more granular CAP_BPF fir=
st.
> > > Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spam
> > > under SELinux, as privileged domains using BPF would usually only be
> > > allowed CAP_BPF and not CAP_SYS_ADMIN.
> > >
> > > Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369326
> > > Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence =
on exit")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > So this seems correct, *provided* that we consider it within the purvie=
w of
> > CAP_BPF to be able to avoid clearing the branch history buffer.

true, but...

> >
> > I suspect that's the case, but it might warrant discussion.
> >
> > Reviewed-by: Serge Hallyn <serge@hallyn.com>
>
> (BTW, I'm assuming this will get pulled into a BPF tree or something, and
> doesn't need to go into the capabilities tree.  Let me know if that's wro=
ng)

Right.
scripts/get_maintainer.pl arch/x86/net/bpf_jit_comp.c
is your friend.

Pls cc author-s of the commit in question in the future.
Adding them now.

> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.=
c
> > > index 15672cb926fc1..2a825e5745ca1 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -2591,8 +2591,7 @@ emit_jmp:
> > >                     seen_exit =3D true;
> > >                     /* Update cleanup_addr */
> > >                     ctx->cleanup_addr =3D proglen;
> > > -                   if (bpf_prog_was_classic(bpf_prog) &&
> > > -                       !capable(CAP_SYS_ADMIN)) {
> > > +                   if (bpf_prog_was_classic(bpf_prog) && !bpf_capabl=
e()) {

This looks wrong for several reasons.

1.
bpf_capable() and CAP_BPF in general applies to eBPF only.
There is no precedent so far to do anything differently
for cBPF when CAP_BPF is present.

2.
commit log states that
"privileged domains using BPF would usually only be allowed CAP_BPF
and not CAP_SYS_ADMIN"
which is true for eBPF only, since cBPF is always allowed for
all unpriv users.
Start chrome browser and you get cBPF loaded.

3.
glancing over bugzilla it seems that the issue is
excessive audit spam and not related to CAP_BPF and privileges.
If so then the fix is to use
ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN)

4.
I don't understand how the patch is supposed to fix the issue.
iio-sensor-proxy is probably unpriv. Why would it use CAP_BPF?
It's using cBPF, so there is no reason for it to have CAP_BPF.
So capable(CAP_BPF) will fail just like capable(CAP_SYS_ADMIN),
but since CAP_BPF check was done first, the audit won't
be printed, because it's some undocumented internal selinux behavior ?
None of it is in the commit log :(

5.
And finally all that looks like a selinux bug.
Just because something in the kernel is asking capable(CAP_SYS_ADMIN)
there is no need to spam users with the wrong message:
"SELinux is preventing iio-sensor-prox from using the 'sys_admin' capabilit=
ies."
iio-sensor-prox is not trying to use 'sys_admin' capabilities.
cBPF prog will be loaded anyway, with or without BHB clearing.

