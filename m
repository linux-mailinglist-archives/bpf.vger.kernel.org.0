Return-Path: <bpf+bounces-70794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16484BD0DA0
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 01:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2DF1893EAB
	for <lists+bpf@lfdr.de>; Sun, 12 Oct 2025 23:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F121F0995;
	Sun, 12 Oct 2025 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASrPrayS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E575F4C97
	for <bpf@vger.kernel.org>; Sun, 12 Oct 2025 23:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760312737; cv=none; b=rkXehZBHhlREBeDuVTogUE7HZ55eBozip2TVQhywM1b9Re+HuDbfSxqOAs/zyjJ2scEgzvOF5Wh6JtHBJAaFp3jN5LWdltVHejxiaf8aB7suT++S3x8RFwoD8H+03GthKzQVhpnyFenTySgmNdYYj2eIlKHatkiSs/V7FIXOxdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760312737; c=relaxed/simple;
	bh=MuAnMand/nvwUHqF24iFeEjQdKXib/dWOLfBLA65Sd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OFuLoiuVmvGOezoe0MwWB8kEvZ+5dKUkjZ54MSZDcFIVLSIORg6nDhU4PrQgUG0nC9971kXCAPXq9ScTEJDXYlhNhkbjGATqJnQtYnqvttpspgzMXe7SB/nMNUPh960cOZ2fdxzQgeGI++/sG2VePJ2WZjnoCkyptNfg4hUvuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASrPrayS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso3051415f8f.0
        for <bpf@vger.kernel.org>; Sun, 12 Oct 2025 16:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760312734; x=1760917534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuRe6cpi3iO7soDacnjgBBBFRXF8dJtWFuE+tuasCXY=;
        b=ASrPraySxvl4zwstjJTpx1fNzxeV2gMyb/0YPMqynjG5p2KmaPyrjm6z2cKwLpL2nt
         SQqth5o6rGE1CZ7eO5tZG2a0v6RxWqpLwB7/oJAOvM85homHjPQrsE2eMCNoue70/LsA
         2LYbDHZcogZa3bN7LBTcel6SWQ0SEOqsICa/mnAVqtyUR+CZ3V7MKUtV5WRVQVb0Bk43
         p1WP0dY59pw7iUkFfvEwj+PmvXuWO0mNC3DUvuXUg+n0cozA2610ngZSdsUduKcnzSPe
         H4e9LQ0/Fvp/IkDKZR72Tch6zTK4yB1R37ieyRnlrmoUUjGzzXOXA8X+60FDf5iP/LBy
         jDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760312734; x=1760917534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuRe6cpi3iO7soDacnjgBBBFRXF8dJtWFuE+tuasCXY=;
        b=P7nVfP34qM/LpTBuiCSThfMdIpFbGGP0bhE6Qw8cvaC4gEjid2QCmhovLSPjcbOk3i
         rZ3HaWWQMIb+l0DgwtOOJwmyfdZ4zFhOp76/DPDJko7zKdkvKrGkQGE5LDnbsekAYkY6
         Q7ThczI5V6vfoclKGX0FA2iU15Z56okUkIdFxVyOB8lA9ZxFoERb9H82VxYNwHpU9Kbg
         efwyBAvuSCwmk/ISz8bNQW3jl/0dqpbZVMz0B7Rvp+BHqdbfRgCl1Q7zFzICRwIRukmj
         8tDcUyXxVucYbo9FKUBt/h49d1OI3mbWifM1+KptDdAvGBcCl/ENtBFSnDMJzYoHIJyw
         3CYA==
X-Forwarded-Encrypted: i=1; AJvYcCVKobKWZ/cNsHrPsR1gE+x2OtfbjSmslDi30dZ4Xt+y1R4Vr16O3ILSdQDFTMmqnuaHPM8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg+1SM6w1rOE/oDvvau2RHfKWaKx0ZfK+WKBggNqGlGT2CcdOh
	UyZPU2Wyb2zZlBMpss/J23ZBozbAFtzlx5xF0LBKmJo4LwjxIEJClKhD3dIcugh6LssogviJiCg
	lqqFnBU3AK/UwIdzuW+nbJvd0uWKGilo=
X-Gm-Gg: ASbGncuqx1Y8pvYyjmoc05wMFlu4TuGqmaq9Zl4UQezTMh/aQzwF91SmhBaUFKILU1R
	93U3bK+eO26HLdEK22Aby38k5xPsvhXL8Uvs5959JxjKOQPk9RtfOasnAFnN8f91tNEt8IU46ul
	IlTbcaRHxjCfo+zVUjJz/VrOEfTwpDbBHg/yYF9ZiGX25nswPVLhMOj7SYXbmdbD2YWtF24OnvR
	bIXruQy4HxiO3UYOn+MPvMvYnN2zYnOL5U0G+yokbVSOGYMfRrZWPvN/Ig=
X-Google-Smtp-Source: AGHT+IHLKIRHhnjYr1zhh88d6IC6Sp7r2YVECtLfhRoavF2b8ODcTYZDXh9HG/SyrDLJQhRqUxpad+f1GeaaVDHxfNk=
X-Received: by 2002:a05:6000:2386:b0:425:6fb5:2ad4 with SMTP id
 ffacd0b85a97d-425829e78f4mr14753484f8f.15.1760312733915; Sun, 12 Oct 2025
 16:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008173512.731801-1-alan.maguire@oracle.com>
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Oct 2025 16:45:22 -0700
X-Gm-Features: AS18NWCl0e9gsbLecYflTZeFq0uME46gCGpf85LQWfva1hSLKrQsgMP4lZ0ojXg
Message-ID: <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Thierry Treyer <ttreyer@meta.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <qmo@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	David Faust <david.faust@oracle.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 10:35=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> In terms of BTF encoding, we wind up with 12010 LOC_PARAM which are
> referenced in various combinations from 37061 LOC_PROTO. We see that
> given that there are over 400,000 inline sites, deduplication has
> considerably cut down on the overhead of representing this information.

Looking at loc_param and loc_proto... they could have been 8 bytes
smaller easily. So the math there is (12k+37k) * 8 ~=3D 400k byte
is not worth saving, since locsec dominates the size anyway ?
Having a common struct btf_type for all of them also helps dedup, I guess ?
A bit uncomfortable choice, but probably ok.

> LOCSEC will be 443354*16 bytes, i.e. 6.76 Mb. Between extra FUNC_PROTO,
> LOC_PROTO, LOC_PARAM and LOCSECs we wind up adding 9.2Mb to accommodate
> 443354 inline sites and all their metadata. This works out as
> approximately 22 bytes to fully represent each inline site, so we can
> see the benefits of deduplication of LOC_PARAM and LOC_PROTOs in this sch=
eme.
>
> When vmlinux BTF inline-related info (FUNC_PROTO, LOC_PARAM, LOC_PROTO
> and LOCSECs are delivered via a module (btf_extra.ko.gz), the on-disk
> size of that module with compression drops from 9.2Mb to 2.8Mb.
>
> Modules also provide .BTF.extra info in their .BTF.extra sections; we
> can see the stats for these as follows:
>
> $ find . -name *.ko|xargs objdump -h |grep ".BTF.extra"|awk '{ sum +=3D s=
trtonum("0x"$3); count++ } END { print "total (kbytes): " sum/1024 " num mo=
dules: " count " average(kbytes): " sum/1024/count}'
> total (kbytes): 46653.5 num modules: 3044 average(kbytes): 15.3264
>
> So we add 46Mb of .BTF.extra data in total across 3044 modules, averaging
> 15kbytes per module.
>
> Future work/questions
>
> - the same scheme could be used to represent functions with optimized-out
>   parameters (which we leave out of BTF encoding), hence the more general
>   "location" term (as opposed to calling them inlines)
> - perhaps we should have a separate CONFIG_DEBUG_INFO_BTF_EXTRA_MODULES=
=3Dy|n
>   as we do with CONFIG_DEBUG_INFO_BTF_MODULES?
> - .BTF.extra is probably a bad name, given that we have .BTF.ext already.=
..

yeah. 'extra' doesn't really fit. Especially since that will be a hard code=
d
name of the special module.
Maybe "BTF.inline_info" for section name and "btf_inline_info.ko" ?

The partially inlined functions were the biggest footgun so far.
Missing fully inlined is painful, but it's not a footgun.
So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
user space is not enough. It's great and, probably, can be supported,
but the kernel should use this "BTF.inline_info" as well to
preserve "backward compatibility" for functions that were
not-inlined in an older kernel and got partially inlined in a new kernel.

If we could use kprobe-multi then usdt-like bpf_loc_arg() would
make a lot of sense, but since libbpf has to attach a bunch
of regular kprobes it seems to me the kernel support is more appropriate
for the whole thing.
I mean when the kernel processes SEC("fentry/foo") into partially
inlined function "foo" it should use fentry for "foo" and
automatically add kprobe into inlined callsites and automatically
generated code that collects arguments from appropriate registers
and make "fentry/foo" behave like "foo" was not inlined at all.
Arguably, we can use a new attach type.
If we teach the kernel to do that then doing bpf_loc_arg() and a bunch
of regular kprobes from libbpf is unnecessary.
The kernel can do the same transparently and prepare the args
depending on location.
If some of the callsites are missing args it can fail the whole operation.
Of course, doing the whole thing from libbpf feels good,
since we're burdening the kernel with extra complexity,
but lack of kprobe-multi changes the way to think about this trade off.

Whether we decide that the kernel should do it or stay with bpf_loc_arg()
the first few patches and pahole support can/should be landed first.

Just .02 so far. Need to understand the whole thing better.

