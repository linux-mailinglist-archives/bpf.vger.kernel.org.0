Return-Path: <bpf+bounces-31359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6B58FBAB0
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 19:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A311B2C001
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2024 17:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CCD149E03;
	Tue,  4 Jun 2024 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jh/pmGiz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EFF5F860
	for <bpf@vger.kernel.org>; Tue,  4 Jun 2024 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522756; cv=none; b=hUY5AmxDrNnwG8mV5RhChAYcJKgq5kjcBO9Bi/votBC2+M5obM7sdfS2jAAZ8onVPE4YyTIS4nc1kloByaFfSeyte1BUWly9DZG8wCgsHIxcBRge5hYgLXxcTdcp0Z/0XCxxJ8oDkGP1taRSTDxRHUhhoWm3Zz+aUgVywEmrDY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522756; c=relaxed/simple;
	bh=IPgo0Hte3ROc/IvXQMAIh5cMQSYi8Ix7HVwOZqMrs/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3CP0abv2R14WBpP1Yi2qsfRX86eRZ581U++ls89BgNr71oITIj48xuxO84oeTC2uHGUezRU1fwOKHkKas/lPQRacnCCXsJ4Cjp8/33UpkXwXGpoksSQ87fboNaStY1yWfN2hUj9GTchXfPePeN7txn+tc0m5shcHlWwzSXTX6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jh/pmGiz; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-681953ad4f2so4404383a12.2
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2024 10:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717522754; x=1718127554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oip7sVutF+x6AXa81xuIl+pNHCuhUQp52bI721YGXRg=;
        b=jh/pmGiz0vA+18pLkkUW26dEsOKO/OMVaXIvpzUJC0/dyZ+24BzM4RPgZ7CST4/vay
         CR+fhJA6P1JZseMjvhLUYOEdmtlu6il8bPXgqfivbZf552gUX7yuJrnQuvpvNbfWli3q
         Q1xJL7naGZqFvfklcSsSMhYZjwnNM3ILZheSXd/53bMVs8TFLKEaj3qqLu02e1b03qz5
         Tla1ItYr9Md5pIoetjtcyx5k9JnOtTvPZag6Td3NRz+ClKMHb4ZZzNlB5wJ+kJO5IUUs
         I70hXxVOyjjRPimvelLE1EMia14v6Hd95mftcrb4DxjuOJtlpNT1f/nEWps0u7DDvsR1
         mwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717522754; x=1718127554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oip7sVutF+x6AXa81xuIl+pNHCuhUQp52bI721YGXRg=;
        b=TJY6sU6Zv+9Lezx0zWaxCvEd9jpDAfliX6XnNBdEj8VXBhQ/kO7ZIQGqt0YXbUI0US
         h4xY53hXh+jSrAsb2UxgYr5zK0Ub6NycvsLVU4VjpzerzUc/iAVmtSnwQjESYQ9NtjS4
         lLPaaAAyVGXNdXWlPZZzLJ2fo0zbDbxML8E+arjFG0BJtc+vS8i8Hu5EkyqCmWed2GEs
         UpdOG6oWs2249tX1KAircZ0+SnlGJZL8oAwyG4A7IKtpPtMClG3sqRpeeU7cFO1Zwb4x
         Xi7GNEqFhGWDMGMgW7Fotb3l+pZX2bvsGUTXHaUKCipCtuxNPGofxXnrHT4eIBfP2bJD
         27BQ==
X-Gm-Message-State: AOJu0Ywxm+IoMiSxvxESfeHeQgrpTEV1bcwSeLajZrGK6UG3bhNbZ1Pg
	LsL0oiXUbW9nnK80QJDfW4y2175X0Ki00AQNazGBFuKetW8nk+qGqT7g5qZyiHp9xKLAkQky1Pt
	3E4ZKft25kmB/fj0efAEQ9+lFVOo=
X-Google-Smtp-Source: AGHT+IEtND4oL8pLC3uf8r0jpN73wKQpKwm0J7J5hFgSAxVxgFHUiPEx1wmcsklIs93B+UC0JD/bFChmZx+V+yNJTNg=
X-Received: by 2002:a17:90b:378e:b0:2bd:efa5:5686 with SMTP id
 98e67ed59e1d1-2c27db13aafmr148811a91.14.1717522754072; Tue, 04 Jun 2024
 10:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517190555.4032078-1-eddyz87@gmail.com> <20240517190555.4032078-3-eddyz87@gmail.com>
 <CAEf4BzbUPTU__d4G3dt6Rga+aNG=kLRxsBM4LJMhYfMKy+RSfQ@mail.gmail.com> <fbb23a418f892cb50470971f8966958f87329b93.camel@gmail.com>
In-Reply-To: <fbb23a418f892cb50470971f8966958f87329b93.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Jun 2024 10:39:01 -0700
Message-ID: <CAEf4Bzad6-zh8KaZXeKwT_K12zXU49Ov9Nc+hZD2mdWM_9TT1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] libbpf: API to access btf_dump emit queue
 and print single type
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 1, 2024 at 12:22=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-28 at 15:18 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > Speaking of which, for the next revision, can you also integrate all
> > these new APIs into bpftool to handle the problem that Jose tried to
> > solve? This might also expose any of the potential issues with API
> > usage.
>
> Hi Andrii,
>
> Good foresight requesting to re-implement Jose's patch on top of the

yay, I guess it was :)

> new API. I did the changes you requested for v1 + tried to make the
> bpftool changes, results are here:
>
> https://github.com/eddyz87/bpf/tree/libbpf-sort-for-dump-api-2
>
> The attempt falls flat for the following pattern:
>
>   #define __pai __attribute__((preserve_access_index))
>   typedef struct { int x; } foo  __pai;
>
> With the following clang error:
>
>   t.c:2:31: error: 'preserve_access_index' attribute only applies to stru=
cts, unions, and classes
>     2 | typedef struct { int x; } foo __pai;
>
> The correct syntax for this definition is as below:
>
>   typedef struct { int x; } __pai foo;
>
> This cannot be achieved unless printing of typedefs is done by some
> custom code in bpftool.

Right, though in this case it probably is still achieved with using
btf_dump__emit_type_decl() if bpftool detects TYPEDEF -> (anon) STRUCT
pattern.

But we can get deeper, thanks to horrendous C syntax:

typedef struct { int x; } struct_arr[10];

I think it still is achievable with btf_dump__emit_type_decl() setting
.field_name option to "__pai struct_arr". It does feel like a hack, of
course, but should work.

In general, typedef is equivalent to field definition (which is
intentional by original C syntax inventors, I believe), so maybe
that's one way to address this.

>
> So, it looks like we won't be able to ditch callbacks in the end.

hopefully we can avoid this still, let's give it some more thought
before we give up

> Maybe the code for emit queue could be salvaged for the module thing
> you talked about, please provide a bit more context about it.

We talked offline, but for others. The idea here is when we have split
BTF of a kernel module, we'd like to be able to dump it just like we
do it for vmlinux BTF. But for kernel module we'd like to get
<module>.h which would include only types defined in kernel module,
skipping types that should be in base BTF (and thus come from
vmlinux.h).

The idea is that in practice you'd have something like:

#include <vmlinux.h>
#include <module1.h>
#include <module2.h>

and that will work together and won't conflict with vmlinux.h.

>
> Thanks,
> Eduard

