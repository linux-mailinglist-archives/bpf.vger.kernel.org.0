Return-Path: <bpf+bounces-76927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6041DCC9B82
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 23:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12B393031CEE
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A4B32573E;
	Wed, 17 Dec 2025 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J02awCVj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4AA296BBF
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766010860; cv=none; b=aRY1kk8u2YKjRtyjwdDsCCc/yDAo5JVnEQ7AfsVmPQx6X/UewUj9laNaIY6WzdZFrfSP6EBkU0ECg6kjJxOMP6uakQe3Ra3fdvuOUnpyvKEkvEcw3MVeZnvtAsHEVoDVtTgikIkFjevH70haZcg/lxPVCskJKaS1VKPFyPYlai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766010860; c=relaxed/simple;
	bh=IXq5/3dFlmxxQgf13Vxgn8YlBM73UISDTowcZj0VERo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=caNfz1al8HIIQtKups/Hyq+6e5xQEDR/+JOUt/EaVjv40/qRN/Gj6Pa3Z3csUObbQdJ/ggKiVEECMTJNiWGcWswU+4ObFG+Ob46YXAEEmRZQjZS0v6PTKGyW5sQH15FTBPMh+o52YE5yrHnIfBugPgBBzCxiIf9S3jZ/RCBYSNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J02awCVj; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so44609b3a.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 14:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766010858; x=1766615658; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z6EUMfqffTwbShAjal8oHtzsjiuYJcumiq8lizyQBv8=;
        b=J02awCVjB03/3u0abtcrDYojD0L4eZSL+poEYeXqP1iTfB1m9wWr0fcGNdhatO7Y+T
         ZwcGb7J3xBF6m24O82Nh1fEqsDN2+hChkYECNFDfYzoTDFQeu29sYQ6jE8LGcU0lhuLx
         vyQVARjKaUTEn2m61826818BDyWUb2xoxy6IwAm+ryCXXoqdRVnMPXTrBk2BNnXZXPCS
         wO+ixomSQ8CFAYhmMgjrI7WR1stt02iobWZaFhLCTDHpPRYXB6st9VIRqjCFXjH/Unmz
         cVFoeSXH/as4F81slRLOmQDfQOMe27hzUEE6O93ieWOJdWV/GPbQw7BXRwBAuxUxmV8f
         mH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766010858; x=1766615658;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6EUMfqffTwbShAjal8oHtzsjiuYJcumiq8lizyQBv8=;
        b=dHn/2koxYW5CgAXyqPcJR3YDRTEmqjESSTE65msF5Or5Re8VXPatZNmvotohDsqAfp
         uc7i+cREi712Yjx/IMZV6ASrbUufRzLghcQVg5f7uVtGCtlV9iVsSnbfqeC1v7njSnYQ
         7UCsCLTJ0yKExNtH8TcWvmferUT/r3uIphKkIbJxiQ2bCB6G0ZVIWIZ9Gd89bUSlniPC
         nGAIQFYVWFtmZHP5RmfLvkyfLXqz0FQAPoHcbVDAZgF95B12RPQ6BBt+QDH9ncdEbyFK
         VbphIsMGNULH3R/TtEysu4YLN13MPfZJxYtqIoQbRtSl+jY1G7W1GxUStk3WgTq4JGRv
         N9Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUzAyL3QNATjoUnejdFNfdV3acVEGtEXLEUi3vzKZU9wWsr3SswnW2JAyN1EaDKwZWh7AI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxOGfVS1WG1f5uda9U9bqLGrH1J9Bi1qNrkvK2x+YLMvoqPsw0
	FJLAsGgVkC1yjAZM8ytsI0NteQgVCfxR5oMmv1+FJ4x1VcMxeSEwMfoi
X-Gm-Gg: AY/fxX7L6cZB1dv/Xhy4svNUv/2gmbueSRr6HhFDMt5wPqGZfVgICotHJjMLAKevSip
	OIL6PGvW38SgeHrpxcR5dAILc9/G2zv8SNXVx9eJvR1Z7dckhywIRuNkoiAcMH/HKpFbOrS0l7g
	5xBltEnc/hrwhXI/Za8RZPhlGx2WD4sYDl4I0jEEXy0odrPtO1Smj+WGapBkOo6Hs+YfDSjh/5W
	+qvopwbwNxZs2hf0U0hqMA+A6eGAXnNiV6iNsPk/Q6i5li8G0jme5GHBM6uDv3UvS8MX2hyCu3j
	rhG8WJktGoS6FBbJblOS7HOZkBBvGkDaoA4GUTfLx7B6VItp/CaG+2Imkl2xgjJyZ9xhKAL5OmP
	HzjbZJaVt/H3HvWfCce/SQe7MYgTDmBBzRYBthKTXz9+ZGt9/Fdfw+y5iuYd5iWuWBCUnK+1rRA
	qp3Bgwxrcs+rOucQOaLK+L7I3fWvDtNFDhDBEu
X-Google-Smtp-Source: AGHT+IFKAdYVsvgU3BfOUAxtCdCjqxmwP55/aVdRxY7in1o28WJ0JThJmpZrfjW+JvbQTP5APxG7sA==
X-Received: by 2002:a05:7023:a85:b0:11a:335d:80d3 with SMTP id a92af1059eb24-11f34bfa7damr15185047c88.22.1766010858390;
        Wed, 17 Dec 2025 14:34:18 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:9f95:2f12:bb69:e3e6? ([2620:10d:c090:500::7:a4ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061fcfc66sm1919430c88.15.2025.12.17.14.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 14:34:17 -0800 (PST)
Message-ID: <5022ccaf5591e5bb88fe3d7a08dbb3c4fb6c3132.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize
 nested structs for BTF dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Quentin Monnet <qmo@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, bpf	
 <bpf@vger.kernel.org>
Date: Wed, 17 Dec 2025 14:34:15 -0800
In-Reply-To: <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
	 <20251216171854.2291424-2-alan.maguire@oracle.com>
	 <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
	 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
	 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com>
	 <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
	 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
	 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
	 <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
	 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com>
	 <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
	 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
	 <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com>
	 <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
	 <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 13:27 -0800, Alexei Starovoitov wrote:
> On Wed, Dec 17, 2025 at 1:02=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Dec 17, 2025 at 12:50=E2=80=AFPM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> > >
> > > On 17/12/2025 19:35, Eduard Zingerman wrote:
> > > > On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
> > > > > On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > > So maybe the best we can do here is something like the followin=
g at the top
> > > > > > of vmlinux.h:
> > > > > >
> > > > > > #ifndef BPF_USE_MS_EXTENSIONS
> > > > > > #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS=
)
> > > > > > #define BPF_USE_MS_EXTENSIONS
> > > > > > #endif
> > > > > > #endif
> > > > > >
> > > > > > ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
> > > > > >
> > > > > > That will work on clang and perhaps at some point work on gcc, =
but also
> > > > > > gives the user the option to supply a macro to force use in cas=
es where
> > > > > > there is no detection available.
> > > > >
> > > > > Are we sure we need such flexibility?
> > > > > Maybe just stick with current implementation and unroll the struc=
tures
> > > > > unconditionally?
> > > >
> > > > I mean, the point of the extension is to make the code smaller.
> > > > But here we are expanding it instead, so why bother?
> > >
> > > Yeah, I'm happy either way; if we have agreement that we just use the=
 nested anon
> > > struct without macro complications I'll send an updated patch.
> >
> > There is a little bit of semantic meaning being lost when we inline
> > the struct, but I guess that can't be helped. Let's just
> > unconditionally inline then. Still better than having extra emit
> > option, IMO.
>
> tbh I'm concerned about information loss.
>
> If it's not too hard I would do
> #ifndef BPF_USE_MS_EXTENSIONS
> #if __has_builtin(__builtin_FUNCSIG)
> #define BPF_USE_MS_EXTENSIONS
> #endif
>
> and it will guarantee to work for clang while gcc will have structs inlin=
ed.
>
> In one of the clang selftests they have this comment:
> clang/test/Preprocessor/feature_tests.c:
> #elif __has_builtin(__builtin_FUNCSIG)
> #error Clang should not have this without '-fms-extensions'
> #endif
>
> so this detection is a known approach.

Speaking of information loss.
It appears that clang does the same trick internally:

  $ cat ms-ext-test2.c
  struct foo {
    int a;
  } __attribute__((preserve_access_index));
 =20
  struct bar {
    struct foo;
  } __attribute__((preserve_access_index));
 =20
  int buz(struct bar *bar) {
    return bar->a;
  }

  $ clang -O2 -g -fms-extensions --target=3Dbpf -c ms-ext-test2.c
  ms-ext-test2.c:6:3: warning: anonymous structs are a Microsoft extension =
[-Wmicrosoft-anon-tag]
      6 |   struct foo;
        |   ^~~~~~~~~~
  1 warning generated.

  $ llvm-objdump -Sdr ms-ext-test2.o
 =20
  ms-ext-test2.o: file format elf64-bpf
 =20
  Disassembly of section .text:
 =20
  0000000000000000 <buz>:
  ;   return bar->a;
         0:       61 10 00 00 00 00 00 00 w0 =3D *(u32 *)(r1 + 0x0)
                  0000000000000000:  CO-RE <byte_off> [2] struct bar::<anon=
 0>.a (0:0:0)
         1:       95 00 00 00 00 00 00 00 exit

Note the "<anon 0>" in the relocation.
It appears that we loose no information if structures are unrolled.

