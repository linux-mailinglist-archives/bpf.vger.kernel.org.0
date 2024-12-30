Return-Path: <bpf+bounces-47704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 108489FEA95
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 21:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB50118832A5
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D6C198845;
	Mon, 30 Dec 2024 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miBcq8YC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2B22339
	for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735590286; cv=none; b=Im/Af6eyvMH1I0AwuoQX/0rntl1HdfTkmkRI/GetWpMddLzkOZDiI9Tji/i4x3ugS9YGGFb0Fg5CK9LInxgDfRv2sEj8QD4YKTBbhIbZ3d67pMIgoqY0EEOp5xGwqv3flsLzrjhIIsUpjbi2/0RHWAuqlsI6YJgv/pmvaSahJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735590286; c=relaxed/simple;
	bh=YOA2+e83vhXdEylYK31CLWYzgb0oU9J1ihLg871aGiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6GJIdLYxMYHoTMkiIjKlfZRWCFnrzODkVHnfx8Zt4WAA+Ym4G9tE5eBCtnEy2LE+zMeDQDvTjS+cMla2wNraFKBJw49V/PPlotnbE7YLWdZz2y504G0+Z96Wn70e/bThInsno0dX6MXwA3ZZY8xu2POiESsvDLdS8ijaFJ6RIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miBcq8YC; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2f44353649aso10167787a91.0
        for <bpf@vger.kernel.org>; Mon, 30 Dec 2024 12:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735590284; x=1736195084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E1KuCLYgVkzxVUJV8ogxUylMmpAhOLVAzBDZcYB8f4E=;
        b=miBcq8YCVy39m2jgNV6LVRM2vFdTCndDIFIVtymzZntJIzgZ+9VFWMMgDrpv3chQsJ
         XksDNdCi2Jt2G7KE3OReR2E5i+ZjLWbM6UMyvFpVq0IeP1plsDFyXiHCJP504viLJ/v9
         HMOOiMidsfX8U00S/XUk2cos+SfAm33PCSMkF/dsVIrE8u/+fp2EWoRZYbSVaxSqhkDZ
         fLX0o+6mUDwdtrLr92cCGDvijvf/eAUtQZxqELY4cBWa+mCDB0eLLe/gRvd4B2qj8IRf
         TK29Xeub20wwrA2E3PNDTAlV3QZcBLxOVbArDraa1ycS4rhiQkBhH0Pi63Nu5rzthycd
         pKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735590284; x=1736195084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1KuCLYgVkzxVUJV8ogxUylMmpAhOLVAzBDZcYB8f4E=;
        b=WvYO3/+rugmOkU/bapZtzSg/zKJirb2GdwXp2rbqJeoEtZcBrwY63pY9mvG3P277a1
         CA6kG9QiOK24uEIjz1qsGCHAKnKqmG29L8/tlxamwPvQ4zj/RbacG09/hVb6dCfQSUq6
         512AXIHOwNtTV2yn6nXQDTrMb4+lrfp5zFx9CekmUx9uSGEBRLa0wcmMHyxHhu3Xx+gk
         pdW+Cm46ZzQYRloS104Wssju0WGX1DZnFdeMxt0ZmTZcFJFas+rWaQGuL3I3IZn+mLwd
         V7SYXROXyfnr25sRxa4YSn6Lm8PzH9FuFLjs827akoqfZWvD+odHc0fsVq2ctv4t9slu
         9edA==
X-Forwarded-Encrypted: i=1; AJvYcCV94eeh4hz7XVgU5IFPwE18DgtUE/Rl/ltdW4/IRjj1k/GpKFePXWFfEDX9Fq8VcKQfTME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5WHY5KB0gXyVqggY+skS3t3Ube8x850luztkIl08/bZXrGSia
	KXdg2wGP2DwS3ecPQf/om8bKOPc3BFtjuoO10vyqll2TTTxtNXsAz7RuzpT8YTaBggrRFUiNpiy
	q6HQL80lJpMQsJkSPqeW8kOtN0Ak=
X-Gm-Gg: ASbGncuuXVDQhSgHPAbwOEYbNaNHdjrYQ7T+jSAxZGrRrjrQre38inXkN0AGbCJcr/h
	LGf1SamUcGKxdjdNLXuFJaKJruO2iK0eOKyA=
X-Google-Smtp-Source: AGHT+IE1Hg69yfyFQuKylNlqGiVakM3UB9IEkz8PpnnaB2wLwuic+cAlzHpltJvuhe74zUjOJGqMWG756f3dMyghN20=
X-Received: by 2002:a17:90b:3cc6:b0:2ee:aa95:6de9 with SMTP id
 98e67ed59e1d1-2f452eed7e1mr55446108a91.33.1735590283964; Mon, 30 Dec 2024
 12:24:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
In-Reply-To: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
From: Andrew Pinski <pinskia@gmail.com>
Date: Mon, 30 Dec 2024 12:24:32 -0800
Message-ID: <CA+=Sn1ktCrXZMjrC0b1TNxfz1BnQfG24XUdVuktS8kRWeEP2kA@mail.gmail.com>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Cupertino Miranda <cupertino.miranda@oracle.com>, 
	David Faust <david.faust@oracle.com>, Elena Zannoni <elena.zannoni@oracle.com>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Manu Bretelle <chantra@meta.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2024 at 12:11=E2=80=AFPM Ihor Solodrai via Gcc <gcc@gcc.gnu=
.org> wrote:
>
> Hello everyone.
>
> I picked up the work adding GCC BPF backend to BPF CI pipeline [1],
> originally done by Cupertino Miranda [2].
>
> I encountered issues compiling BPF objects for selftests/bpf with
> recent GCC 15 snapshots. An additional test runner binary is supposed
> to be generated by tools/testing/selftests/bpf/Makefile if BPF_GCC is
> set to a directory with GCC binaries for BPF backend. The runner
> binary depends on BPF binaries, which are produced by GCC.
>
> The first issue is compilation errors on vmlinux.h:
>
>     In file included from progs/linked_maps1.c:4:
>     /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h:848=
3:9: error: expected identifier before =E2=80=98false=E2=80=99
>      8483 |         false =3D 0,
>           |         ^~~~~
>
> A snippet from vmlinux.h:
>
>     enum {
>         false =3D 0,
>         true =3D 1,
>     };
>
> And:
>
>     /ci/workspace/tools/testing/selftests/bpf/tools/include/vmlinux.h:235=
39:15: error: two or more data types in declaration specifiers
>     23539 | typedef _Bool bool;
>           |               ^~~~
>
> Full log at [3], and also at [4].


These are simple, the selftests/bpf programs need to compile with
-std=3Dgnu17 or -std=3Dgnu11 since GCC has changed the default to C23
which defines false and bool as keywords now and can't be redeclared
like before.

Thanks,
Andrew Pinski

>
> You can easily reproduce the errors with a dummy program:
>
>     #include "vmlinux.h"
>
>     int main() {
>         return 0;
>     }
>
> The vmlinux.h is generated from BTF, produced by pahole v1.28 from
> DWARF data contained in the vmlinux binary. The vmlinux binary I used
> in these experiments is v6.12 (adc218676eef) compiled with gcc 13.3.0
> (default Ubuntu installation).
>
> You can download the specific vmlinux.h I tried using a link below [5].
>
> I bisected recent GCC snapshots and determined that the errors related
> to the bool declarations started happening on GCC 15-20241117.
>
> Older versions compile the dummy program without errors, however on
> attempt to build the selftests there is a different issue: conflicting
> int64 definitions (full log at [6]).
>
>     In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                      from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                      from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                      from /usr/include/linux/if.h:28,
>                      from /usr/include/linux/icmp.h:23,
>                      from progs/test_cls_redirect_dynptr.c:10:
>     /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error: confli=
cting types for =E2=80=98int64_t=E2=80=99; have =E2=80=98__int64_t=E2=80=99=
 {aka =E2=80=98long long int=E2=80=99}
>        27 | typedef __int64_t int64_t;
>           |                   ^~~~~~~
>     In file included from progs/test_cls_redirect_dynptr.c:6:
>     /ci/workspace/bpfgcc.20240922/lib/gcc/bpf-unknown-none/15.0.0/include=
/stdint.h:43:24: note: previous declaration of =E2=80=98int64_t=E2=80=99 wi=
th type =E2=80=98int64_t=E2=80=99 {aka =E2=80=98long int=E2=80=99}
>        43 | typedef __INT64_TYPE__ int64_t;
>           |                        ^~~~~~~
>
> This is on a typical ubuntu:noble system:
>
>     $ dpkg -s libc6 | grep Version
>     Version: 2.39-0ubuntu8.3
>
> I got this with snapshots 15-20241110 and 15-20240922 (the oldest I
> tested). This problem may or may not be present in the most recent
> versions, I can't tell for sure.
>
> GCC team, please investigate and let me know if you're aware of
> workarounds or if there is a specific GCC version that you know is
> capable of building BPF programs in selftests/bpf.
>
> If you suspect something might be wrong with the includes for BPF
> programs, or GCC snapshot build etc, please also let me know. I mostly
> relied on Cupertino scripts when setting that up, and assumed the
> selftests/bpf/Makefile is handling BPF_GCC correctly.
>
> Thank you, and happy holidays!
>
> [1] https://github.com/libbpf/ci/pull/164
> [2] https://github.com/libbpf/ci/pull/144
> [3] https://gist.github.com/theihor/98883c4266b3489cee69e5d5aa532e79
> [4] https://github.com/libbpf/ci/actions/runs/12522053128/job/34929897322
> [5] https://gist.github.com/theihor/785bb250dd1cce3612e70b5f6d258401
> [6] https://gist.github.com/theihor/a8aa7201b30ac6b48df77bb1ea3ec0b2
>
>

