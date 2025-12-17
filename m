Return-Path: <bpf+bounces-76891-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E229FCC934C
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 19:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6E7F312EF6D
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880832863A;
	Wed, 17 Dec 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DgqgDr3t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079625487B
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765993983; cv=none; b=Di9kZwpEre1tDAKnEM5xdIxJco45DrNbg/BGI85lBqWDFt7wT1WGkD8GQABz4lwp5TeWfTMHfptIE+BJ6Uu87lj1zzFtok6JxyTIK1sekf0SrpUIcKR1Dy6sJP+kA1qbhYhSLf76HPA4ZCaTFM9emXnYA7z7aOMsz/sUWN1wYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765993983; c=relaxed/simple;
	bh=Y5To4HEoKY0jLQgWOPyijWvw0xPY/8gkUyI9EKm4X5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WftsZHVc1/RNvyQaI9sZqsKylHF8W1Iu9jh7c7XirNvZ27bXFWdWAQ7rd8Mqxf0vPIDTRiGcErU1YBlSaUoXnUAgpwn6vNKsHBj0Cmhogkr8azHws194zGlZ8sghBwWa75MBw0EDuXOEha180rqswMB3G720g5dTlFu8FW8SxkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DgqgDr3t; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47796a837c7so45019775e9.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765993980; x=1766598780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNdLzk3CpOMSmo+uA+1hUI+JL/z4J2Efi9+luO+Ytgw=;
        b=DgqgDr3tUWWGCgNs+wPMckV87C0nkoqoparxvYk5HyGzw6Bcazh/ofzn1R7yj60fH6
         4x2PNckDtRI+AQnJi4E0SfxKpFR5ggK7MnY7ctl/aHwMMa24U0Z0U7D2248Cfc4/woxL
         4bGcntoy9p9irnhW8LKoKbZcKpPHeN+yV+uU2/+iG19ba8NHQPWxIaD8g0z+f1RPbz7d
         09W/DrkHnmQ3ZAw+FKurAAUv6qw2I2ZO/EvqSneHoTuAVMdUNbQoYJExjrW0FRvARlPE
         pt9wsKoAmqPmEsZZq7+u17u4aBON4ZgiXGbKz97aC+zouuL9Pk7f8T96tN0dctDY0A9g
         HBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765993980; x=1766598780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DNdLzk3CpOMSmo+uA+1hUI+JL/z4J2Efi9+luO+Ytgw=;
        b=cLB38BlK7H34PT3RuZjT2mbIFmmjYwVo9qYTMr79IztByNsTT9R2jrR2w1yEok/15T
         tMue09ed1TIYdomcCMyrSpX2zqL/yoZWJ0Cuf0C/3eZXviQhzs11IA+E8Ue9JL1PiXGy
         V4qylhrb/+9fIzXagnRKk9qDmBAqxF+7566zi9r/slLs78hWPmAbOJfE3xU9z+7bjhrR
         rWgJ2SOExFBR46Sb8AS1kmjcZRtqWG3gLnIFjbckQXJSxYRLjrD+N7z82i2qVFKKPWRh
         CgRtHuNnuRMc7QJIwZkr6kMxZQtalWjUoQ+lM7RyKWs9q/XA0sgUO4x2RsUWlcJmMNav
         E9LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhz1+IhAqg+ozzuIcszDc9Fbu1oWhzFzwmCtd4jarXHyYBNUEimXqCayHQf20z+AiX5iE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynLlvo9UqPZ+lOAtMVkAj0JpCysSNX+gmjFQCh8XyR2bnO7n5F
	PFt/aw8W+fvQWVeIPuty+vgRzS9tqY5gq1lku5tbnJmqniPAa9SmX7njqLnu+GKpRHk94nbFGAe
	F5NqLp2zyqO4CxJYxhpfcvp9vqBI7DWo=
X-Gm-Gg: AY/fxX6FDmfqMIUULF8yOBgrcVaJFDybbed3eSPePW8MU4vLEiAd5HpPqKG1FoC3kiR
	LP6E4yQljpts3++BbwiNgLityf1bBJsyYZ6nfd4uEC56eTUWBRt2wW/9JxzFrNgme2Qo8Xl4JbZ
	0kvcQAwlHC5Mw4vJqAcmxWCEMhmHf1RpWZNRYAN1b355cHNdwG1ZbFHo8OaieUpsjyfNMMGD19y
	c3rHu5ELHUQJcAbjWMA96kpj5iEHIbyPIJgmlKNoSOFxCCr3JLaFmqvUduErnNGF27QdZkG83aO
	5aXWXsde+lM6RgAOMhSWBwotslhd
X-Google-Smtp-Source: AGHT+IGmdsFR1LxfoHW9IwlbOH/E2ifR/ELoagawmO4yy3A1je9wigW35WCWTGOLPhX9zsWy9nPOw45CXxH3gkgkpcc=
X-Received: by 2002:a05:600c:35d4:b0:477:7b16:5fa6 with SMTP id
 5b1f17b1804b1-47a8f89c85dmr228839815e9.3.1765993979958; Wed, 17 Dec 2025
 09:52:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com> <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com> <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com> <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
In-Reply-To: <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 09:52:48 -0800
X-Gm-Features: AQt7F2p7AIekj2Dl32vozfMULcovfTnlm_IVlcYSHWGoHKAIMVfzNuPRiTRPqo8
Message-ID: <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 9:33=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> On 17/12/2025 17:06, Andrii Nakryiko wrote:
> > On Wed, Dec 17, 2025 at 8:13=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >>
> >> On Wed, Dec 17, 2025 at 8:06=E2=80=AFAM Alan Maguire <alan.maguire@ora=
cle.com> wrote:
> >>>
> >>> struct foo {
> >>>         struct foo *ptr;
> >>> };
> >>>
> >>> struct bar {
> >>>
> >>> #ifdef __MS_EXTENSIONS__
> >>>         struct foo;
> >>> #else
> >>>         struct {
> >>>                 struct foo *ptr;
> >>>         };
> >>> #endif
> >>
> >> Did you test it ? I suspect AI invented it.
> >> I see nothing like this in gcc or llvm sources.
> >
> > Grepping a bit I suspect we need to check for _MSC_EXTENSIONS, worst
> > case - _MSC_VER. But Alan, please double check in practice.
>
> Thanks; I tried these too, no luck with either gcc or clang. Looks like t=
he
> requests to merge them haven't landed yet, latest I could find on this wa=
s [1]/[2].

clang diff landed, but these defines are there only when
clang is built for windows.

After studying the code a bit the following works with clang on linux:

#if __has_builtin(__builtin_FUNCSIG)

but not with gcc.

