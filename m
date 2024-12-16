Return-Path: <bpf+bounces-47030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A9B9F2BE9
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 09:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25821647D4
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DD51FFC57;
	Mon, 16 Dec 2024 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3GvNPCO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75F1C3BF4;
	Mon, 16 Dec 2024 08:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734337950; cv=none; b=c870929VeebhfYLG3+dwGggF1oqD7d7PQ7vQ/27ghLDtecE6fSYdzXZbBdv19WIbodlVckZgESxl1cQMIDFLbjv/9YUIiGp350miIpc78XI3npyiSdu0C1DWu4xKw4aWJQEG/OZQrDQUIQuKqaPJ+pcH20/+/Ga/R0GSR5b0gFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734337950; c=relaxed/simple;
	bh=tmc63graJPe0UKWyx4vkNpNO+m+4ga2BW8sW6KWUPfo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZM6J7cory3c4/wWcg2p/zeZ21Y3gSTSQHvl51FglJL2jqCFQZq/AbV9DaxDymYTBsCztz4VcE7cQP0iCmJpCKIlQXD5fW3zG5nbodxNpS0/ax5OZvDG8GNloZ6M5Oh+yvnQ9UdsEgE4+dZiMz3EGTOJZFAN4CdkL7jMP55Qpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I3GvNPCO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d3e829ff44so8963249a12.0;
        Mon, 16 Dec 2024 00:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734337946; x=1734942746; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DStXmAP1zl+BtmnNqXwLVT5eG0QidhabsDYM+Bje4Ck=;
        b=I3GvNPCO5p+9XNgF6Va65LxdhxBL0T86gnWtOE1KlNDWstydbGunyHt2Ok4Td6nrQP
         o2sXU7WJXc1sitcCjJZrA0V6YA470gGOYGBJSPtJmCVfenYkEYRL8GXxKl8iBvmsTJWk
         6KogrG2fcDYfeA7QtZqHhDb15k2Kx+l6bPy/0wHA9HhTNJn0mo0sf+vQIdQODguDok0e
         ZdVHYmD0OkOFjWu9kZIJBb5X+0OG6+fSiXpg6sV7X1Uks9jmASNzAGEJ78RGYy58zx53
         gXnSHyp/cpr91IbZAUQj7+7WoRvIT1syNw8o460zAHNC0dh1yrxiHRHcgiV6c8y7llxC
         /eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734337946; x=1734942746;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DStXmAP1zl+BtmnNqXwLVT5eG0QidhabsDYM+Bje4Ck=;
        b=GyffBiPlyHHmi7vyZm+lKbEDkz44UHyt1JwOhSEAcLzOSxqDRjIICPH00VB3b7z9WR
         JuI5NzHR1aur6FbGKWwpX/2aLyRR75otCWvug4ufnlt4dpUFJhAFLAI+qEvabOe5BHRk
         apXIX2+zvkE5T6MQjT+bAMqKgUwUfSfIuxTv88zrm1k3STo+y+U9h1IgmvbNmYaLEChC
         Br4KEa/Qp1Cg5rnwdNrc4hJl0QMUw1+2u3EbpEOd/ZfynwLb7cRwBXYxVI4AAGc4IChR
         zTR33zsgmG6KSH/QkaoM4sykn1JkwEbrlxOD1Ao09ZyGkUm1ovmNUcHSlpCn672ilQtN
         CNqw==
X-Forwarded-Encrypted: i=1; AJvYcCVaECX4MD7lnZW5bC5NqwgGD0RTn7MT2mAFHzyDXADrT/6emCRAsqQ1GVujVCudEeakFBU=@vger.kernel.org, AJvYcCXD47OcFGR6RngK/effPIbsAZ2IouEvQkqDd4QdmEmt7orw5uLxTCFDAkwqHC0hpu7BT5bEnkW0WqtpWGp13i9fFP/J@vger.kernel.org, AJvYcCXj58Ji6r1JXNMCIgB5815WJjjK+hTLn0BImSeJJNtIIlAatyMZajDO9e/zM/kIH6jkkovKjM3X77hVhFMe@vger.kernel.org
X-Gm-Message-State: AOJu0YxUIQTUgZLhxiXUzOso9YFZFfoEcrffz+/q6fvzQDkyI0X04AWf
	VK45Omhy4EHVfJfCiJEUGnZUeAp5rXdc6BQKHCcLHuJUefVxeCvS
X-Gm-Gg: ASbGncvi8SF7GOkgbk2eJ9uQMrckTUcYY/NGFTfJfxJ8+z/GSTux6zYK0ocnjFcUpmg
	pQ1UtmXMenkQMxpHMeUV5PFxBzK8F91JtjDHTzGHjdbOltgI6L//gVwgdfnOcAZkrhpuALNj0Uf
	n4R/oZQmRg/eI/DjAK5wGZFUKEru7n6Bv5RxP+EAxkM73VBrWncR9dugxYfT/JJ4IVgUroe5C1S
	AKKO+CrcZF1bTfFYdUUgG4QPRhuRIR39V7PbHxWVy4l0iC7yef9iPIPXLmt1fh2LfRx2nlIwOLX
	MNIOWsoJlaerc0nfkanaxHa6YBpr/g==
X-Google-Smtp-Source: AGHT+IFbJzgNGleaCl6XYHSoPut73f3e6DblPj/2gHplP/KlT1RUtBIX0KhXN+QPge/sy3mCbplt0A==
X-Received: by 2002:a17:907:980b:b0:a9a:6c41:50a8 with SMTP id a640c23a62f3a-aa6c418018bmr1518123966b.17.1734337945778;
        Mon, 16 Dec 2024 00:32:25 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab963ce30asm300285566b.200.2024.12.16.00.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 00:32:25 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Dec 2024 09:32:23 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 09/13] selftests/bpf: Use 5-byte nop for x86
 usdt probes
Message-ID: <Z1_ll7ArngBWpx4N@krava>
References: <20241211133403.208920-1-jolsa@kernel.org>
 <20241211133403.208920-10-jolsa@kernel.org>
 <CAEf4BzbF1Ei-MkKOM9N2nCRspVXpVLhpAYZFaaOUpDJ4HgJ6jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbF1Ei-MkKOM9N2nCRspVXpVLhpAYZFaaOUpDJ4HgJ6jA@mail.gmail.com>

On Fri, Dec 13, 2024 at 01:58:33PM -0800, Andrii Nakryiko wrote:
> On Wed, Dec 11, 2024 at 5:35 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Using 5-byte nop for x86 usdt probes so we can switch
> > to optimized uprobe them.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/sdt.h | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> 
> This change will make it impossible to run latest selftests on older
> kernels. Let's do what we did with -DENABLE_ATOMICS_TESTS and allow to
> disable this through Makefile, ok?

ok, I wanted to start addressing this after this version

so the problem is using this macro with nop5 in application running
on older kernels that do not have nop5 emulation and uprobe syscall
optimization, because uprobe/usdt on top of nop5 (single-stepped)
will be slower than on top of current nop1 (emulated)

AFAICS selftests should still work, just bit slower due to nop5 emulation

one part of the solution would be to backport [1] to stable kernels
which is an easy fix (even though it needs changes now)

if that's not enough we'd need to come up with that nop1/nop5 macro
solution, where tooling (libbpf with extra data in usdt note) would
install uprobe on top of nop1 on older kernels and on top of nop5 on
new ones.. but that'd need more work of course

jirka


[1] patch#7 - uprobes/x86: Add support to emulate nop5 instruction


> 
> 
> > diff --git a/tools/testing/selftests/bpf/sdt.h b/tools/testing/selftests/bpf/sdt.h
> > index ca0162b4dc57..7ac9291f45f1 100644
> > --- a/tools/testing/selftests/bpf/sdt.h
> > +++ b/tools/testing/selftests/bpf/sdt.h
> > @@ -234,6 +234,13 @@ __extension__ extern unsigned long long __sdt_unsp;
> >  #define _SDT_NOP       nop
> >  #endif
> >
> > +/* Use 5 byte nop for x86_64 to allow optimizing uprobes. */
> > +#if defined(__x86_64__)
> > +# define _SDT_DEF_NOP _SDT_ASM_5(990:  .byte 0x0f, 0x1f, 0x44, 0x00, 0x00)
> > +#else
> > +# define _SDT_DEF_NOP _SDT_ASM_1(990:  _SDT_NOP)
> > +#endif
> > +
> >  #define _SDT_NOTE_NAME "stapsdt"
> >  #define _SDT_NOTE_TYPE 3
> >
> > @@ -286,7 +293,7 @@ __extension__ extern unsigned long long __sdt_unsp;
> >
> >  #define _SDT_ASM_BODY(provider, name, pack_args, args, ...)                  \
> >    _SDT_DEF_MACROS                                                            \
> > -  _SDT_ASM_1(990:      _SDT_NOP)                                             \
> > +  _SDT_DEF_NOP                                                               \
> >    _SDT_ASM_3(          .pushsection .note.stapsdt,_SDT_ASM_AUTOGROUP,"note") \
> >    _SDT_ASM_1(          .balign 4)                                            \
> >    _SDT_ASM_3(          .4byte 992f-991f, 994f-993f, _SDT_NOTE_TYPE)          \
> > --
> > 2.47.0
> >

