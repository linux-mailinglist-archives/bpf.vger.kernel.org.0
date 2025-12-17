Return-Path: <bpf+bounces-76884-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AA9CC8FF7
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 18:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C17F300AC71
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632EB31A577;
	Wed, 17 Dec 2025 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZblywDET"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F025CC63
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991210; cv=none; b=mGrdU1LYEilUNwzqxPzzp+JazNEuqvfk/LMP6803kQjURyJJ6enzcKq9BXk2jRHLH2S6Vmn03eU/zo9WGLbCR4EGArlSh+cMyzZU6CiGG6nqcD6GFXQswuJiZA5elj96qrevAkeMSrM9H27vM+enRZi6fsorStyyaYnQ2m/WdvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991210; c=relaxed/simple;
	bh=bTn22dcfv+34sys8IvgPrL14FEEryzVpSjALZbDXeHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2weWFAbJhe9BrK4lPCn7apmLoFlS2vCzfDm9/olRYROkf30LAE1+ubAx5c2WoYrpviPIhC9jlG3xOnutUj9AzJWrC4KjCVl0YBVcZgmC0R+VmtsZY+9FBm4p4yZeT4sl9/8oST1GpuhjWQpPcUUWxaVqT8rxLENpZ6+y8urqQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZblywDET; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c2f335681so3928988a91.1
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765991209; x=1766596009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn2uBYzzTVBiH5aNAeQkJ0DnhavBK60yUwjNJCl6Gqg=;
        b=ZblywDETKbEFQO9CEV0DjaGOjKY0ZSFsDIkrf3eo0RR/utMwKAcDGmxxP1vOPmAMJy
         X8zl4CSelJ6K5hhcDAjs6zLRBGJv0AEtQuQs+JSswAyvVRxC+1ERYnKcmNPWzsJemVEz
         gPZWZTtyRnueznkprNch19plGEyxgKX+ZpPiJtKVQA3/q3g/vWeqRrgPOUpYFoPR6/Nn
         46OybSilK3u0npMHZ+R+X0Mvi1eZRrQvFcYJrsxbYBLdJj9A8ju0kWmp7fLcCHAwDAQo
         kBBw6cza0H6bmHv2GpJjlGgNnGsEJxGFV+G/EgXe/2MXqTfGidLm6x7ywkEGB64R7tyU
         SB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765991209; x=1766596009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yn2uBYzzTVBiH5aNAeQkJ0DnhavBK60yUwjNJCl6Gqg=;
        b=mcFjLC8vs/f9eETM3Y2n8rJ2Xa/+da4yULgnp6pueRI3w6xbQI3Bmu5RjQSkNRLb0o
         qIZuQKLHCnAekRkG4JikSfCOyvWIHVdhUt17G8VNZcz2NuTanTPrJ9zj2H6fAcdGyas6
         Tb0QuwR7l88QMEf5pnB6xGl6W1XrSynGJhw8Q4k8EzQcvQKkOgOjBTQh7u7hdWMS/WpL
         CAsfKztB+DyMRKhkC0obw8iFwnOMD1iKo+DpSP5Nur8A62juGaLulfDEL+XkXw6a97O+
         LpimGn1Eu4OR9V5cyiuZjoGHtyjmQbiKJibKXCqNBeE+ACxxFNRvczXQvTI+OIxDgCrM
         oaWw==
X-Forwarded-Encrypted: i=1; AJvYcCU83g/Q/474PJr1hwlsbIDJfxI6LxgS8igWTb2q3+5w4EtISk03JQl6lKN8WbQJLDZsDWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vxsAA3tEgl/QYvnyYIq9CoxcmgroToA4YwVBHex19d5/1SIQ
	cdOGgH+h62cfF7J8cyF2cxzdSNNgbVts6xZNjHeT9n0uhaHjaiuJDdCEiRgJ6kXQUouM879kE/9
	ZySFFxFW6Sbfwz226xW7ZhhfkIAzfFUQ=
X-Gm-Gg: AY/fxX7PwkQS8wcYhbyYeTignPY3nU4vhTGnLR/pAG1g0TRM+M9PYzPDIXkuOiBJ+Ih
	FtvOGKY6V1l04QjAj2X82H2dShlbKMw4u5eWCvgnBvy0ciussdNQ4Oo0ZdX0ucUI+L9LtGZ8dpI
	y1DZ8BsX0QLdI2IKOWAEilgleXb2H7lVKsIOZrtL0aID8KLu35oj0wYAhHPVqSip8vNGaj9zpCD
	4UJVv6Fx2xgRWqABIYlcaWwAIrsdY9CBTU2K3xp+ZYgqEhKro1ii/HNY/atT6bzum2epDBLqjC2
	l9ql8Eb1cFyKYZ5t7ckIOA==
X-Google-Smtp-Source: AGHT+IGjK9gXqTJqalqQhS9mkRqVZPi/QU5Rkyv2W+ql0zEx7JqZ8kPydf3BBVRTvuYf978a2BYZET3frjYixDeMMMs=
X-Received: by 2002:a17:90b:3e4e:b0:340:d578:f2a2 with SMTP id
 98e67ed59e1d1-34abd7a9571mr16951751a91.6.1765991208900; Wed, 17 Dec 2025
 09:06:48 -0800 (PST)
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
In-Reply-To: <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 17 Dec 2025 09:06:36 -0800
X-Gm-Features: AQt7F2oBH3uMv2nbfTs_Ij0koWwSN8fMG3Me6KMF3ICMI9iT9fhW1-9hwv2MYA0
Message-ID: <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 8:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 17, 2025 at 8:06=E2=80=AFAM Alan Maguire <alan.maguire@oracle=
.com> wrote:
> >
> > struct foo {
> >         struct foo *ptr;
> > };
> >
> > struct bar {
> >
> > #ifdef __MS_EXTENSIONS__
> >         struct foo;
> > #else
> >         struct {
> >                 struct foo *ptr;
> >         };
> > #endif
>
> Did you test it ? I suspect AI invented it.
> I see nothing like this in gcc or llvm sources.

Grepping a bit I suspect we need to check for _MSC_EXTENSIONS, worst
case - _MSC_VER. But Alan, please double check in practice.

