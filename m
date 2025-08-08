Return-Path: <bpf+bounces-65247-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2872B1E073
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 04:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC60A18C0DE3
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D6372634;
	Fri,  8 Aug 2025 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV15IZU1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725792F30;
	Fri,  8 Aug 2025 02:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754618998; cv=none; b=UxA8AsgwL6QAducmNTkrfTwpdei+pR/yocKBYwfWIod0HrNgGuFO+XgfXDvPSKw4nqcvXoNmWjNB3UlVuiop0xPgAaZYmuq5zp3CZ36y8X5qlegqeoPbyZxU4XQQEk7ZpojFJVUTJFkkwFFlY8j/hPQzqqpHd2LkgU0AEYbiNnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754618998; c=relaxed/simple;
	bh=b91ZBqX9h211qKGyiclLETNTM9E+32wOCR9W0x9qDdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OY19Kz1pHxVcOm/2d2GFy7DIDZSEa6HdsMgIeV/94Zzj/CdV1Mr+K518GW+anZJO8+W6pC1liWRWtqxvEl4Jr10OVWGF3Y6vhf4/YDPDjkTkN2S7zzqHIBl20YxQDoiyAa5Z77BDmLGSRBYXJAvMCVjbYj5EPIxlPxGBuPYQZLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV15IZU1; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7892609a5so969711f8f.1;
        Thu, 07 Aug 2025 19:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754618995; x=1755223795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b91ZBqX9h211qKGyiclLETNTM9E+32wOCR9W0x9qDdw=;
        b=YV15IZU1cHk7jf1j+ew1zHPY2+LzB4MIRBARzRTnOdLjxk/FB9qL+BVJ1roAiN+MT1
         4ERymlHTFkLqAHOpep1Ht/dzi3KWcz09RPZdNjaokxk2QwHO1xTe7WXxDSPX782kQzCW
         rzd3uOlU5Tb0OwXn8suPKn8cArFqsqqUtQKmTw3RMZtwnEIJTXItlpVn2JvnnlH20TJP
         x+YcUV4rJvV5vdDZwNxjPnNItSJGTqKh+xVBSBKSvGBq2xFu/nb8sejdHUYllFqX2qjq
         xo/Ubi9u/r+ui6qgSkQiECUGHaXTXZwwfI3MbuVr6sQlEeOsLC8v4CfgaLk5hhYvB2ew
         mg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754618995; x=1755223795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b91ZBqX9h211qKGyiclLETNTM9E+32wOCR9W0x9qDdw=;
        b=d338+/098D7/wmQHvf67Z/8KYCo/4SD8waSXbFi1PbOADijxIGPOpr0MMpRHbWnbl7
         YuzoG1/aLVLpH+55nI3XtKeHMQc8HUTHTY+vET1U/YQ+60c5dvXPdGaWofuY1+wm18FW
         BTjaJD1x9mmj3Qt4ZRcHjCnxze6sA4KfvJUSIl8onHlp5cPz0cV9HqJU1uMvn50OixZ+
         rup26g6+ISeSMafKubdztw821gfXt5vCj9UzerlHzyweSemP7T7YhiUPUJkHJAB3921s
         fgil+u0kK1xwBWlidtXHrLn9QDz5RpM1RCueP+Ab0V3auxPStbhS7M5WzItbmv4MwgI9
         f6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUlmUcpd37xF5fbmRi/ggXjGPEYSbvw80BkaJpY3wF1GWXXNSKSqitDrCBJi901PwPL+XOHhZ21zw==@vger.kernel.org, AJvYcCWI2FH4dPVCPb542VBDfQvVeTVRCnl7kQpoYS9VWnt1R2MIXCKqGR1rIOyfBBhS/AgbaEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54Pl5yjyYE3msS6EaXL5jryC09AfQOnD4zvNVvoU6Xd783TiZ
	xn0Zw+9GrCH0rxlB5NT53CTF7DRnXGArDcHlCO3Q/B7mfvYa723X4O3sw1aSngpWbNbzCqjc8nG
	p1yk6JWOuznLGJqp98PQ/+SbJ0esR2XE=
X-Gm-Gg: ASbGnctyTISFuaImdjcYzUAxbExUZAqYyavvDiOR1Rmli0wVpyEifoGcl5j+nKhq0Pr
	1kX7Di09CGZ30N6t7J8SHolb8nyqdBfkX/4hPAgiQDL+I1c/XAraM8cUt4zIzTdVnV/6E+8BGqZ
	Y2h42QHFhjeHMNV2Mx9COqKamkWz9BoHozrbDqrWe6I8CveABbAVTmusMKlmhsfcgBOF5PDOCTu
	3ZjrWkhGzx26YgjDcFuTaFnPZDmw+RKpSOT
X-Google-Smtp-Source: AGHT+IFRKscnOhmKI0Tm5pcCdNJc8klvKb/YBJAXcZlZYDStoQ0ZQ+gvikRDP318Oyr8nBgH714nXPk56LO7ktbx4jQ=
X-Received: by 2002:a05:6000:290b:b0:3b7:8fcc:a1e3 with SMTP id
 ffacd0b85a97d-3b900b5108cmr805722f8f.48.1754618994477; Thu, 07 Aug 2025
 19:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807182538.136498-1-acme@kernel.org>
In-Reply-To: <20250807182538.136498-1-acme@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 7 Aug 2025 19:09:43 -0700
X-Gm-Features: Ac12FXz2TmQFrKlJUMLcW7AW2DkrnvBMHrhbHB6_FPNNTdw7w-3d4-KnT7ImL1U
Message-ID: <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
	Clark Williams <williams@redhat.com>, Kate Carcia <kcarcia@redhat.com>, 
	dwarves <dwarves@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	"Jose E. Marchesi" <jose.marchesi@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	Namhyung Kim <namhyung@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 11:25=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
>
> This is complementary to today's series from Alan Maguire, as we can use
> the one liner for the kernel build process to test his series without
> requiring installing a toolchain that generates BTF for each .o file
> that will result in vmlinux.
>
> Next steps on my side are to:
>
> 1. change pahole for when it receives --format_path=3Dbtf check if
> btf__is_archive(btf) is true, then just replace the current vmlinux .BTF
> contents with the raw data in this just loaded BTF, short circuiting
> the whole process.
>
> 2. the kernel build process should be changed to allow one to ask for
> just BTF, not DWARF, and if so, using the above method, strip the DWARF
> info after using it to generate BTF.
>
> Then when compilers are producing BTF, we switch to that, falling back
> to the above method when a compiler is known to generate buggy BTF.
>
> And also to use in CIs, to compare the output generated by the various
> methods in the various components.
>
> 3. In 2 we can even use the same scheme we use for parallelizing DWARF
> loading when loading all the BTF archive members concatenated in vmlinux
> to dedup them.

Before you jump into 1,2,3 let's discuss the end goal.
I think the assumption here is that this btf-for-each-.o approach
is supposed to speed up the build, right ?
pahole step on vmlinux is noticeable, but it's still a fraction
of three vmlinux linking steps.
How much are we realistically thinking to shave off of that pahole dedup ti=
me?

