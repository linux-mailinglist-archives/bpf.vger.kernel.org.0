Return-Path: <bpf+bounces-18853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511F8228F7
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 08:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E07E28520F
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 07:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A8A1802F;
	Wed,  3 Jan 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaCUfqFK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3B818622
	for <bpf@vger.kernel.org>; Wed,  3 Jan 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67f5c0be04cso87805346d6.0
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 23:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704266595; x=1704871395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3e9BghjieKo/ds8dd9osTeLc9tgJlGkTGyUQSp/mD8=;
        b=OaCUfqFK+XF1w9j2rMezRnyRnUZwsouL5DqirK9S8UIyRVMmd3C1IkzmbJYpPLgLZ0
         4e647sKAn0zHKCZTCrJjLdmK7CY8EvP8hCTtorZKbRztfCSCVL3quG9zNmK0OtyLnvDj
         wG6CMcjOr1rW7LjLzkSb/T15dq50bUn5sCfgv/N2Z5W5VoRJV7XQDsOMiOi8OD7pyX7A
         9KDxmTVIwKj1ze7G7rzJs39vCrz252kqvL6Z48WRMLB+iYn3hoSvGwsoOsST46YyRily
         sunNAbPLB1tVxqYrnmU/LgSw/CYcNCsAJ4756Cb9/9i85mIeVJJtzez4bvosfrbcZKNf
         7SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704266595; x=1704871395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3e9BghjieKo/ds8dd9osTeLc9tgJlGkTGyUQSp/mD8=;
        b=tDFb23o0YD01QuYhbgKyCqKuALv2iji87TNIVolVu/c5uwsNRaVfiOp5qrnaZYXR2M
         cqSorNXl+DqOBuus0WzEhQEQege2ooki0L8LwlCCeGfVXipHh6tm8RT5jwJXgCXbMyNZ
         Kv4IOFoNUCPCItjfhdWmu9YNdI1UePxrARRU+oqGMw1y9QZ+O2VuKrOStWCn17/0iIsI
         MBzP5yEor5ylXLYSlxFBLIBkKN9lZ997cTdzBozGasA/SSlqNoq+4xKBExD41wFmm4Ek
         hEJdt1OAfanPtDLHdprTjgNlJQ5ZfxH6dF5RvHLt/VmKwuvP+yBtVrfRPVvKyb/2jHXD
         avsw==
X-Gm-Message-State: AOJu0Yxczg3sNySYkpVTKto/TAEeC5pNynVXjEWdHlm2blJrYWqLZzu3
	K0f05VzGsIbXP4QIGbq4ZXBX2v7L2v7+ts49tZ4=
X-Google-Smtp-Source: AGHT+IF6sSfN8smPPJdpmXAIN+lYVAWIiBPL9GvZl81BTlXYnDvG2INKu6Bg0EFDkTQ5xNNTaencc/BRcqeYKNlAW8Y=
X-Received: by 2002:a05:6214:1bcd:b0:67f:86bf:a550 with SMTP id
 m13-20020a0562141bcd00b0067f86bfa550mr32300689qvc.4.1704266594884; Tue, 02
 Jan 2024 23:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM0PR0202MB3412F6D0F59E5EBA0CA74747C461A@AM0PR0202MB3412.eurprd02.prod.outlook.com>
 <08287f7c-d0aa-4ded-a26d-34023051dd14@linux.dev> <28bcf5ae2df9ed0bd1603ed161e1d4488694c0d9.camel@gmail.com>
 <1b45ec38-3a7f-4745-a063-8b16b040004c@linux.dev> <d3ea8754ed4c5f8a33b3fd2cc69eeff7f362ce35.camel@gmail.com>
 <ED829AA7-2F5D-41FC-8C2E-96A1DC19D5B8@gmail.com>
In-Reply-To: <ED829AA7-2F5D-41FC-8C2E-96A1DC19D5B8@gmail.com>
From: Bram Schuur <bramschuur@gmail.com>
Date: Wed, 3 Jan 2024 08:23:03 +0100
Message-ID: <CAOuJ=_55E2c+ZFtwNw7JKZvPVXK64kBz54Xk8-CgwCQG-Xw_iw@mail.gmail.com>
Subject: Re: test_kmod.sh fails with constant blinding
To: Jan-Gerd Tenberge <janten@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Bram Schuur <bschuur@stackstate.com>, "ykaliuta@redhat.com" <ykaliuta@redhat.com>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"johan.almbladh@anyfinetworks.com" <johan.almbladh@anyfinetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 1:03=E2=80=AFAM Jan-Gerd Tenberge <janten@gmail.com>=
 wrote:
>
> > Am 02.01.2024 um 23:39 schrieb Eduard Zingerman <eddyz87@gmail.com>:
> >
> > On Tue, 2024-01-02 at 11:41 -0800, Yonghong Song wrote:
> >> On 1/2/24 9:47 AM, Eduard Zingerman wrote:
> >>> On Tue, 2024-01-02 at 08:56 -0800, Yonghong Song wrote:
> >>>> On 1/2/24 7:11 AM, Bram Schuur wrote:
> >>>>> Me and my colleague Jan-Gerd Tenberge encountered this issue in pro=
duction on the 5.15, 6.1 and 6.2 kernel versions. We make a small reproduci=
ble case that might help find the root cause:
> >>>>>
> >>>>> simple_repo.c:
> >>>>>
> >>>>> #include <linux/bpf.h>
> >>>>> #include <bpf/bpf_helpers.h>
> >>>>>
> >>>>> SEC("socket")
> >>>>> int socket__http_filter(struct __sk_buff* skb) {
> >>>>>    volatile __u32 r =3D bpf_get_prandom_u32();
> >>>>>    if (r =3D=3D 0) {
> >>>>>      goto done;
> >>>>>    }
> >>>>>
> >>>>>
> >>>>> #pragma clang loop unroll(full)
> >>>>>    for (int i =3D 0; i < 12000; i++) {
> >>>>>      r +=3D 1;
> >>>>>    }
> >>>>>
> >>>>> #pragma clang loop unroll(full)
> >>>>>    for (int i =3D 0; i < 12000; i++) {
> >>>>>      r +=3D 1;
> >>>>>    }
> >>>>> done:
> >>>>>    return r;
> >>>>> }
> >>>>>
> >>>>> Looking at kernel/bpf/core.c it seems that during constant blinding=
 every instruction which has an constant operand gets 2 additional instruct=
ions. This increases the amount of instructions between the JMP and target =
of the JMP cause rewrite of the JMP to fail because the offset becomes bigg=
er than S16_MAX.
> >>>> This is indeed possible as verifier might increase insn account in v=
arious cases.
> >>>> -mcpu=3Dv4 is designed to solve this problem but it is only availabl=
e at 6.6 and above.
> >>> There might be situations when -mcpu=3Dv4 won't help, as currently ll=
vm
> >>> would generate long jumps only when it knows at compile time that jum=
p
> >>> is indeed long. However here constant blinding would probably triple
> >>> the size of the loop body, so for llvm this jump won't be long.
> >>>
> >>> If we consider this corner case an issue, it might be possible to fix
> >>
> >> This definitely a corner case. But full unroll is not what we recommen=
ded although
> >> we do try to accommodate it with cpuv4.
> >>
> >>> it by teaching bpf_jit_blind_constants() to insert 'BPF_JMP32 | BPF_J=
A'
> >>> when jump targets cross the 2**16 thresholds.
> >>> Wdyt?
> >>
> >> If we indeed hit an issue with cpuv4, I prefer to fix in llvm side.
> >> Currently, gotol is generated if offset is >=3D S16_MAX/2 or <=3D S16_=
MIN/2.
> >> We could make range further smaller or all gotol since there are quite
> >> some architectures supporting gotol now (x86, arm, riscv, ppc, etc.).
> >>
> >
> > I tried building this program as v3 and as v4 using the following
> > command line:
> >
> >  clang -O2 --target=3Dbpf -c t.c -mcpu=3D<v3 or v4> -o t.o
> >
> > (I copied definitions of SEC and bpf_get_prandom_u32 from bpf_helper_de=
fs.h).
> >
> > With the following results:
> > - when built as v4 program can be compiled, gotol is generated and
> >  program can be loaded even when bpf_jit_harded is set:
> >  "echo 2 > /proc/sys/net/core/bpf_jit_harden"
> >  (as far as I understand this is sufficient to request constant blindin=
g);

I built the earlier example using clang-14 with the following command line:

clang-14 -target bpf -Wall -O2 -g -c simple_repro.c -o simple_repro.o

I adapted the example for clang-18 (which is more aggressive on the
loop unrolling it seems), hence the difference between the compilers.
The following example:

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>

SEC("socket")
int socket__http_filter(struct __sk_buff* skb) {
  volatile __u32 r =3D bpf_get_prandom_u32();
  if (r =3D=3D 0) {
    goto done;
  }

#pragma clang loop unroll(full)
  for (int i =3D 0; i < 8000; i++) {
    r +=3D 1;
  }

done:
  return r;
}

I compiled this using clang-18 as follows, including -mcpu=3Dv3:

clang-18 -target bpf -Wall -O2 -mcpu=3Dv3 -c simple_repro_18.c -o
simple_repro_18.o

In this case the compilation succeeds, but loading it into my
bpf_jit_harden=3D2, 6.1 linux kernel fails.

>
>
> If your kernel is compiled without CONFIG_BPF_JIT_ALWAYS_ON, the loading =
of the program will succeed, but it will be interpreted instead of jit comp=
iled. You can check whether the compilation succeeded by looking for the "(=
not) jited=E2=80=9C line in bpftool prog show.

