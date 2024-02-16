Return-Path: <bpf+bounces-22119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA49857273
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 01:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C501C23B2F
	for <lists+bpf@lfdr.de>; Fri, 16 Feb 2024 00:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE30A3D76;
	Fri, 16 Feb 2024 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/f4iaDn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A838F;
	Fri, 16 Feb 2024 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708043100; cv=none; b=AI7qyjzl5w19jdsMYnIn/jF5p5AQeOQ2J3V7fp+mZLB6bX3hXsZ/6UsBdu2epNcXAJCOJ4iv9ROFp9HiW6CHcace1yPIfroYvb+3hLp2+SoMkHvwGTlSqViFDiNicNcOFfCK4tVbZIbbhmXiQx75Z+1m0mfgW58dd5gxatpGaHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708043100; c=relaxed/simple;
	bh=tpMOihWI6ca0LBEbywL6YZOFFAztXk96ed5zDkaxUyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+Ad6jDdeHBonrRkp7+ialrmmDZLTHEjdB/UOg6UQM+E7qdCo1CfvV+9WBSdM70SrlSkov9ZEH0DGwcKy81TZL452Mb1J+FvE+k/1y/z37PK9i4p07Qq7UQvNQycgvx0be2qmU7UDO2f/V6Z2fFhj2veMJAZoO59ukgmlxTB/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/f4iaDn; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2970595c1aeso999963a91.3;
        Thu, 15 Feb 2024 16:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708043098; x=1708647898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpMOihWI6ca0LBEbywL6YZOFFAztXk96ed5zDkaxUyI=;
        b=U/f4iaDnHiHQMVxdhH8df31IcDBjcljoHOHByitkXzrTTpXK9W2t9JVWpjiNmfvNFG
         RgwSV6elXgDKZwXX92yDNOSoPrX92PofLyIVuqmM4E8bkDX7HAiZYNJ8Mhr6Pf5+DxhG
         Tmni0tCy90M3zPOcJw8W1Us5CqeHJN7H/Z50w6rzOG7dfb/uksqMp5tu3u3ZaLa3v805
         VPprOHvPq32FpWMMej67KMLb4+scOnuVyLW7nB2Z/+H424k53vuJiobnjei1ddIJ3cZ5
         PKtdYAklA2n7R4agszu9pbzcj0foJzLmM2MG1vrNp+Qen7bdIWNJxA3IRopQrG+3eZXf
         0+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708043098; x=1708647898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpMOihWI6ca0LBEbywL6YZOFFAztXk96ed5zDkaxUyI=;
        b=FEJgwsEzThXG5rYos3VhARxjlfz6FyVRp7WJb/lUflpdOenUuvupgHdp/RKPz7iqqb
         CNaYL5vZJuLyii+0s1Kh5YY3iv3iIQoUCQcVJBufWNloenQBZttYx5EP1u1naSUvHhGb
         FwRBlRaZxkpYTD6juXEfP+BLJmDEDOyx+1ukuYYBFbEoZheLVgQQvPSyoYbSqJZ9YMcR
         04Qv5vVmtgvUgrLHZ2LIX/D2ICMSzJP/p3qUA124InSEiIkmGHPBdLOEQ9zCCcAHdLUT
         gv4Jv+Jzot8TeAjmNOzvzm4E1byVo+E1tnol12SWkSijtSyEsyDNdKKjuuv1An4lWIb8
         aihg==
X-Forwarded-Encrypted: i=1; AJvYcCXY/vd7TYyipE/UM+rCXtW4gEOcsUBOHJGMcoBTuBve4MCCYHhQ8prVrbAs/+UT6Y3p0nteZ4j0WuI6JzZe083UzOEWMu4EUingP6DPT2BZvwS3gzHDD7jwXbPEzBOQ1FK+
X-Gm-Message-State: AOJu0Yx1MsH5ZwlgLHakjYvLSIKUI1tG8K7/A9e82Chs8yF/sVotrqhA
	i9trllx7jp755zaAQ965uPCVScPpOdZeLeiOm0PyQBm5FiRAvVz6Rp9pYzgWtjpOhMG/4Ud8svz
	+CKBS3X8Bv/ihAKCGEdc8qzeUYRs=
X-Google-Smtp-Source: AGHT+IFwnBEuCqZR+6lY59H91jVDPeG/qSnR2C/wW28QNBmZMwe6zkb6ozMLyt23tfT/UbvhXEA6ZhFJ03ce2S5S/UM=
X-Received: by 2002:a17:90a:e501:b0:297:966:8f4d with SMTP id
 t1-20020a17090ae50100b0029709668f4dmr3363041pjy.46.1708043098279; Thu, 15 Feb
 2024 16:24:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214173950.18570-1-khuey@kylehuey.com>
In-Reply-To: <20240214173950.18570-1-khuey@kylehuey.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Feb 2024 16:24:46 -0800
Message-ID: <CAEf4BzYGRM6+0mFzE3pF1T4=bzVEvBtwe=vAVUPvs=NuyYJTiQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v5 0/4] Combine perf and bpf for fast eval of hw
 breakpoint conditions]
To: Kyle Huey <me@kylehuey.com>
Cc: Kyle Huey <khuey@kylehuey.com>, linux-kernel@vger.kernel.org, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	"Robert O'Callahan" <robert@ocallahan.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 9:40=E2=80=AFAM Kyle Huey <me@kylehuey.com> wrote:
>
> Peter, Ingo, could you take a look at this?
>
> ----
>
> rr, a userspace record and replay debugger[0], replays asynchronous event=
s
> such as signals and context switches by essentially[1] setting a breakpoi=
nt
> at the address where the asynchronous event was delivered during recordin=
g
> with a condition that the program state matches the state when the event
> was delivered.
>
> Currently, rr uses software breakpoints that trap (via ptrace) to the
> supervisor, and evaluates the condition from the supervisor. If the
> asynchronous event is delivered in a tight loop (thus requiring the
> breakpoint condition to be repeatedly evaluated) the overhead can be
> immense. A patch to rr that uses hardware breakpoints via perf events wit=
h
> an attached BPF program to reject breakpoint hits where the condition is
> not satisfied reduces rr's replay overhead by 94% on a pathological (but =
a
> real customer-provided, not contrived) rr trace.
>
> The only obstacle to this approach is that while the kernel allows a BPF
> program to suppress sample output when a perf event overflows it does not
> suppress signalling the perf event fd or sending the perf event's SIGTRAP=
.
> This patch set redesigns __perf_overflow_handler() and
> bpf_overflow_handler() so that the former invokes the latter directly whe=
n
> appropriate rather than through the generic overflow handler machinery,
> passes the return code of the BPF program back to __perf_overflow_handler=
()
> to allow it to decide whether to execute the regular overflow handler,
> reorders bpf_overflow_handler() and the side effects of perf event
> overflow, changes __perf_overflow_handler() to suppress those side effect=
s
> if the BPF program returns zero, and adds a selftest.
>
> The previous version of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20240119001352.9396-1-khuey@kylehuey=
.com/
>
> Changes since v4:
>
> Patches 1, 2, 3, 4 added various Acked-by.
>
> Patch 4 addresses additional nits from Song.
>
> v3 of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231211045543.31741-1-khuey@kylehue=
y.com/
>
> Changes since v3:
>
> Patches 1, 2, 3 added various Acked-by.
>
> Patch 4 addresses Song's review comments by dropping signals_expected and=
 the
> corresponding ASSERT_OKs, handling errors from signal(), and fixing multi=
line
> comment formatting.
>
> v2 of this patchset can be found at
> https://lore.kernel.org/linux-kernel/20231207163458.5554-1-khuey@kylehuey=
.com/
>
> Changes since v2:
>
> Patches 1 and 2 were added from a suggestion by Namhyung Kim to refactor
> this code to implement this feature in a cleaner way. Patch 2 is separate=
d
> for the benefit of the ARM arch maintainers.
>
> Patch 3 conceptually supercedes v2's patches 1 and 2, now with a cleaner
> implementation thanks to the earlier refactoring.
>
> Patch 4 is v2's patch 3, and addresses review comments about C++ style
> comments, getting a TRAP_PERF definition into the test, and unnecessary
> NULL checks.
>
> [0] https://rr-project.org/
> [1] Various optimizations exist to skip as much as execution as possible
> before setting a breakpoint, and to determine a set of program state that
> is practical to check and verify.
>
>

The series LGTM, I'm just confused why patch 1 and patch 3 are
separated. But regardless, for the series:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

