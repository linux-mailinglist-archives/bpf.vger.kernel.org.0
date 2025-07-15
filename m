Return-Path: <bpf+bounces-63342-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400ABB0646A
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 18:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA2D1AA4E14
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EB8277CA8;
	Tue, 15 Jul 2025 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdY2pe8g"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCF81EF391;
	Tue, 15 Jul 2025 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597325; cv=none; b=J9C+0JQBtsZgyTlCuslvYoXnqlcXCxxHUMAFudiuwfuJhwAS+agtvXTbJclWLQsrLuMV+MsYo7s6eWR/idmbAWe5l2zmON6m9yiE50xBuTM2ku1bhuYKl407zyzo60W9rJmGrLpXHKCHfFL+oMK3yGrgWvePF6jM1ML9fFRj9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597325; c=relaxed/simple;
	bh=P7mDsVyt791kxDsfLEoUKYDr6aDfJjXifiEyA1h7Pmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I35OR4oQRndmq7bDMRqZf+1gRY4j3s7QutWKBxBk7hl/OMKg+XP4Hr80tgX37XRzptujM/e47zbruP/lEMxhQosvhAwEm02BI/wIoOxauwNZLKgiIOnsgifhOjlYmLbU6yEec1dP17ZlVYb9sU601WmiJ7ZZvYuZrW1CZgwvPE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdY2pe8g; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so4246319f8f.2;
        Tue, 15 Jul 2025 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752597321; x=1753202121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2edKyEpQyMO8RJB0jHrVcw4jdJZBkKGdWcVMJb4YdBs=;
        b=CdY2pe8gtV7UHeitTjYi1jv9Ezg9Onv14P7LsQWq9GrqlnYaNr7HUv0kCs9DkDfvOZ
         HPOJ6mutVz3w34/IqILs+MJms5Rb7XIkQvrWeiXN0dcCaOJnab5rhwxQOdJvx03ejClA
         kZnzDTcWWHn+6xpjDChJ7UTxXL720keQbaFpcG+J5+zPNfMbvTryjYbMGBVTXQjkJ9ob
         IodCJSmSKPSdhmV1Kb9J+LQwE0Eam3rrdwmrJQ/mv/jyUrVSiYfBn0o0HonL7FUBiI8c
         itpZLtLWGIdSTu/VqffX5QO1wTyIm8vDi5GktewycGKUcF3edxe7pD3huJmszDjGz3Wj
         G4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597321; x=1753202121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2edKyEpQyMO8RJB0jHrVcw4jdJZBkKGdWcVMJb4YdBs=;
        b=iQ8QrP+EceqnR6ezzwqiw52f7YDZgFREq+WnYH1wea94LH2GuQoGqcEM7KXBcKlS4g
         W0y6LXkPEAM9/H55JYhTcEXWKfxDr1cFIlrp+A96kuDVCj9pAaDl7uw9WdAOIvCXTOOQ
         Omxh5c1JKUEcvz2Fh0XjWCCxw6/gFh3LE336/F1GRozYxNve0mg3ka/1qHBswiATnRuB
         PDhqYeCuuHznww+bzkSNE/NZDcFxWZDNWbUc9YgkTbSsmg/NMHgiTK4r3AcNYk+21Kr1
         6E/4mpgXAZzCGBO6L/+skbiuHXin2ab0dkeRiZls12ZK5aleEYTa740KYDcDc8vgmP02
         QC6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsn7lHSXklG0nzuLZHO26XRLv44N6As/coR+5cCgmJYTvVZE7FpHQ6Y5jgwS75opiHecoGzAvr8IQqg1ep@vger.kernel.org, AJvYcCWUopD4ifho1+BbvG62XnMdeFOh2zAkJ4YrWF7VpldaYPHtygbRFznUHfsl3KrKr+KFRrTp1NR5@vger.kernel.org, AJvYcCWWV70O+QAaC4DpajINB573QcIlih7251+8N4BNViffCZV9ICb5S37PTWCfTjhW634Yh7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM/Hu+iwLFXEDhOB033aGmpfFqbiZZ/LDwGHI8ctP79bXVv5UK
	yqO0NbspTVjFGBvdTZ9N1IzTGMOuL4uKb9n9G2qi7K/VnPzGlITalakVeMITpqSQHIEoC2Wtsyn
	XYyFVyv4jLVPx+RkU6Tnhj+SnocyXhag=
X-Gm-Gg: ASbGncte0m6Dki1ZRp69VtLmqskAgxih/X2WWSPtEyPvauD4Iz6zE8KlLhNA9fljfWZ
	JD8zDNaSmJQhL+JR0IGvFGJ3l1xLQ/UuSou5NOpXjDD4PdO0m05aOhHnbnBTOQy0BzAgna9BDb7
	b6XtP3hoBnNKHCzbXwDFkM3yyhF6m+5E4V9SP2kqD/8HJauVhkA8MuE5T/7da1bdaEbwRJZmLcO
	+GtOXTN1x2FS+784X0Rb9s=
X-Google-Smtp-Source: AGHT+IFz2aUUEOv3dAQkduq08fnYnQj6ngF7d/TxHuFffROOwFPSIpMdst0b+iM0ZEuX77eFaZ3RQooWFo4YeD9Oh5U=
X-Received: by 2002:a05:6000:4b13:b0:3b3:c4b1:a212 with SMTP id
 ffacd0b85a97d-3b5f2db14c9mr13339680f8f.7.1752597321157; Tue, 15 Jul 2025
 09:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <20250703121521.1874196-3-dongml2@chinatelecom.cn> <CAADnVQKP1-gdmq1xkogFeRM6o3j2zf0Q8Atz=aCEkB0PkVx++A@mail.gmail.com>
 <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
In-Reply-To: <45f4d349-7b08-45d3-9bec-3ab75217f9b6@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 15 Jul 2025 09:35:07 -0700
X-Gm-Features: Ac12FXyYNaKEOVHp0hpOSGyjFzhmxFYVkKwEjZo2OQiO_jY4UcfvosI1WJVmAq4
Message-ID: <CAADnVQ+7NhegoZGHkiRyNO8ywks3ssPzQd6ipQzumZsWUHJALg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 02/18] x86,bpf: add bpf_global_caller for
 global trampoline
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Menglong Dong <menglong8.dong@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>, "H. Peter Anvin" <hpa@zytor.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 1:37=E2=80=AFAM Menglong Dong <menglong.dong@linux.=
dev> wrote:
>
>
> On 7/15/25 10:25, Alexei Starovoitov wrote:
> > On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >> +static __always_inline void
> >> +do_origin_call(unsigned long *args, unsigned long *ip, int nr_args)
> >> +{
> >> +       /* Following code will be optimized by the compiler, as nr_arg=
s
> >> +        * is a const, and there will be no condition here.
> >> +        */
> >> +       if (nr_args =3D=3D 0) {
> >> +               asm volatile(
> >> +                       RESTORE_ORIGIN_0 CALL_NOSPEC "\n"
> >> +                       "movq %%rax, %0\n"
> >> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> >> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> >> +                       :
> >> +               );
> >> +       } else if (nr_args =3D=3D 1) {
> >> +               asm volatile(
> >> +                       RESTORE_ORIGIN_1 CALL_NOSPEC "\n"
> >> +                       "movq %%rax, %0\n"
> >> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> >> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> >> +                       : "rdi"
> >> +               );
> >> +       } else if (nr_args =3D=3D 2) {
> >> +               asm volatile(
> >> +                       RESTORE_ORIGIN_2 CALL_NOSPEC "\n"
> >> +                       "movq %%rax, %0\n"
> >> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> >> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> >> +                       : "rdi", "rsi"
> >> +               );
> >> +       } else if (nr_args =3D=3D 3) {
> >> +               asm volatile(
> >> +                       RESTORE_ORIGIN_3 CALL_NOSPEC "\n"
> >> +                       "movq %%rax, %0\n"
> >> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> >> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> >> +                       : "rdi", "rsi", "rdx"
> >> +               );
> >> +       } else if (nr_args =3D=3D 4) {
> >> +               asm volatile(
> >> +                       RESTORE_ORIGIN_4 CALL_NOSPEC "\n"
> >> +                       "movq %%rax, %0\n"
> >> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> >> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> >> +                       : "rdi", "rsi", "rdx", "rcx"
> >> +               );
> >> +       } else if (nr_args =3D=3D 5) {
> >> +               asm volatile(
> >> +                       RESTORE_ORIGIN_5 CALL_NOSPEC "\n"
> >> +                       "movq %%rax, %0\n"
> >> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> >> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> >> +                       : "rdi", "rsi", "rdx", "rcx", "r8"
> >> +               );
> >> +       } else if (nr_args =3D=3D 6) {
> >> +               asm volatile(
> >> +                       RESTORE_ORIGIN_6 CALL_NOSPEC "\n"
> >> +                       "movq %%rax, %0\n"
> >> +                       : "=3Dm"(args[nr_args]), ASM_CALL_CONSTRAINT
> >> +                       : [args]"r"(args), [thunk_target]"r"(*ip)
> >> +                       : "rdi", "rsi", "rdx", "rcx", "r8", "r9"
> >> +               );
> >> +       }
> >> +}
> > What is the performance difference between 0-6 variants?
> > I would think save/restore of regs shouldn't be that expensive.
> > bpf trampoline saves only what's necessary because it can do
> > this micro optimization, but for this one, I think, doing
> > _one_ global trampoline that covers all cases will simplify the code
> > a lot, but please benchmark the difference to understand
> > the trade-off.
>
> According to my benchmark, it has ~5% overhead to save/restore
> *5* variants when compared with *0* variant. The save/restore of regs
> is fast, but it still need 12 insn, which can produce ~6% overhead.

I think it's an ok trade off, because with one global trampoline
we do not need to call rhashtable lookup before entering bpf prog.
bpf prog will do it on demand if/when it needs to access arguments.
This will compensate for a bit of lost performance due to extra save/restor=
e.

PS
pls don't add your chinatelecom.cn email in cc.
gmail just cannot deliver there and it's annoying to keep deleting
it manually in every reply.

