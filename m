Return-Path: <bpf+bounces-31073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67AD8D6BE1
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 23:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A3285D65
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 21:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD9879B96;
	Fri, 31 May 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i43m9lvD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CFFAD59;
	Fri, 31 May 2024 21:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191966; cv=none; b=XAob3Q3u22Zewn8BKEeWnqONDm+bijdNIKgAoQB1DcRQCfsGdXltodwCZtTJpEFMIaOW53ZHEJZqoODu0rAM4GsVq6dPT7vbYLEZXLuFycdGlsg/mPsq7M9vIe4Cp3SpV3TBTlBlY9w9SV8aPCgtPaOmllhFZ+xVV0WL0xZYKLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191966; c=relaxed/simple;
	bh=ZjA8oPmZyDECwwKJFVv43qINjPxwNOSDwZJRySfeg2w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8zrfYZmqj1Rj8LzIWzU9rCMGuVGUkjO7U/RYNmo2CeF6k+wN6LK8iKxGawUPry2dhnrpbULUDvU7GpAS6K0OUt3dqeXw7df8hYoFMmLA8jdp7Ftz9QWELXg9kBhU3wFzYtrPbH0ACXDqUUeKFkxH69T5A2GZ8u/+geEtDelekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i43m9lvD; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7022e0cd0aeso2364909b3a.0;
        Fri, 31 May 2024 14:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717191964; x=1717796764; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zcrBBXgHOmFVI6f9mb8pRs9nIzUb9Bryjka7xFk1bkA=;
        b=i43m9lvDXTUztF6lsVQphjuDNTuFzUFxjyNoKBD3wvw2+PXP27ghsdYiGtwqzROhGY
         EJbATfYI+LubvDqJ6ZJHeClJOC1Zv47DVR0lJfAqEX1q/a7gK457kJ+VK9AITuTNcFt9
         ulXi4mC9sp81pbLMUKyai4SAT50VZBJimc+IRj2enIGM6S8FAqILQxRuKV9gLjWsTfE3
         Uo/h2eGOR4Qtjc2P4JxSn+NCuG8MF08l0qrXi5tudrOSk5oF4vVw4oAD6NTEkasFTLye
         G3Z9DrV6PaeZAMbRtoNwJ+KkIlgzHANtIOe6ToDxgLpXAUVr4fQl1IBz4aqkpOX80s1z
         FqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717191964; x=1717796764;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zcrBBXgHOmFVI6f9mb8pRs9nIzUb9Bryjka7xFk1bkA=;
        b=bZQIHhRMKqYFqVSKcSizGwXk+CdiF4ZR9Uxu7OM0nu2vL84PJwrYJtxqDKn3yOI374
         hqd5y90keheh/+hiFfRdYtyD4hVdxl9P4HdpN2Y0Z/Z4dxPbPS2lXpdIIq6fkmRmgm3s
         THGp3SWa25Mh6HgZrJ1CSw7qfputPGdBWU3NY/oMhVO/yU/CvxVEi4I1ljbhQtTZ75z4
         fGLzIGubg8JwkYZ1m5QdBZsinku4VdNZ9Fcv0zy9HLtG5O4uSFN4griJbavgz4nmqlOl
         KoM4p8qT/AcLhzMiLeqjTcOMYo57PVd7tSiYFvrCyeA/sPAF5TkLe+QGiyJu75AfIbE8
         +Blg==
X-Forwarded-Encrypted: i=1; AJvYcCX/F518OHimNXOGrsNmaPI2AnPcaTpf/SyA0ty86MMm1C014nKb2mp9eWbqaFU7LBi+D7kNBKJEi+EnsX3xGG7OeC919g0eAORShzMFR4GcO/Q+IVhF1R0MPPaeOg==
X-Gm-Message-State: AOJu0Yw3wj9PhOKKQFUHSdSZyP6PM7Gttib6oMVm25Vhwtx7DB8MbEHT
	H7PQgQPtzy3iJZ7p/W0m20ozEAy5vaSFnQv/UTO0TcjyRjqgrIg7
X-Google-Smtp-Source: AGHT+IFVgVHFgqVrjkcdArPs3Bgi1rf/PkY2Ccv2YdMUO/aBIqd01H2OR+HA3J6NFUC+l9gBYGdSHw==
X-Received: by 2002:a05:6a21:7888:b0:1af:a2fa:e666 with SMTP id adf61e73a8af0-1b26f17d61emr3424203637.10.1717191963914;
        Fri, 31 May 2024 14:46:03 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7024f5ad7f7sm917906b3a.52.2024.05.31.14.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:46:03 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Fri, 31 May 2024 14:46:01 -0700
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: Problem with BTF generation on mips64el
Message-ID: <ZlpFGShLFgj4IngZ@kodidev-ubuntu>
References: <ZlkoM6/PSxVcGM6X@kodidev-ubuntu>
 <CAEyhmHT_1N3xwLO2BwVK97ebrABJv52d5dWxzvuNNcF-OF5gKw@mail.gmail.com>
 <ZlmrQqQSJyNH7fVF@kodidev-ubuntu>
 <Zln1kZnu2Xxeyngj@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zln1kZnu2Xxeyngj@x1>

On Fri, May 31, 2024 at 01:06:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, May 31, 2024 at 03:49:38AM -0700, Tony Ambardar wrote:
> > Hello Hengqi,
> > 
> > On Fri, May 31, 2024 at 10:17:53AM +0800, Hengqi Chen wrote:
> > > Hi Tony,
> > > 
> > > On Fri, May 31, 2024 at 9:30 AM Tony Ambardar <tony.ambardar@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > For some time now I'm seeing multiple issues during BTF generation while
> > > > building recent kernels targeting mips64el, and would appreciate some help
> > > > to understand and fix the problems.
> > > >
> > > SNIP
> > > >
> > > > >   CC [M]  net/ipv6/netfilter/nft_fib_ipv6.mod.o
> > > > >   CC [M]  net/ipv6/netfilter/ip6t_REJECT.mod.o
> > > > >   CC [M]  net/psample/psample.mod.o
> > > > >   LD [M]  crypto/cmac.ko
> > > > >   BTF [M] crypto/cmac.ko
> > > > > die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit
> > > > > or DW_TAG_skeleton_unit expected got member (0xd)!
> 
> Can you check the kernel CONFIG_ variables related to DEBUG information
> and post them here? I have this on fedora:
> 
> [acme@nine linux]$ grep CONFIG_DEBUG_INFO /boot/config-5.14.0-362.18.1.el9_3.x86_64 
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_REDUCED is not set
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT=y
> # CONFIG_DEBUG_INFO_DWARF4 is not set
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_DEBUG_INFO_BTF=y
> CONFIG_DEBUG_INFO_BTF_MODULES=y
> [acme@nine linux]$
> 
> If you have CONFIG_DEBUG_INFO_SPLIT, CONFIG_DEBUG_INFO_COMPRESSED or
> CONFIG_DEBUG_INFO_REDUCED set to 'y', please try with the values in the
> fedora config.
> 
> - Arnaldo
> 

OK, I have those 3 settings as expected on bpf/master branch:

kodidev:~/linux$ grep CONFIG_DEBUG_INFO .config
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
CONFIG_DEBUG_INFO_DWARF4=y
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y

I also attached the full .config in my original mail if you think other
config options might be suspect.

Is there anything else I can check? What do you make of the many pahole
"die__process:" warnings? Could it be related to your comment here:
https://github.com/acmel/dwarves/issues/45#issuecomment-1974004606

Thanks,
Tony

> > > The issue seems to be related to elfutils. Have you tried build from
> > > the latest elfutils source ?
> > > I saw the latest MIPS backend in elfutils already implemented the
> > > reloc_simple_type hook.
> > 
> > Good idea. I tried rebuilding elfutils from the latest upstream commit:
> > https://sourceware.org/git/?p=elfutils.git;a=commit;h=935ee131cf7c87296df9412b7e3370085e7c7508
> > 
> > I then linked this elfutils with pahole built from the latest pahole/next:
> > https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=next&id=a9ae414fef421bdeb13ff7ffe13271e1e4f58993
> > 
> > I also confirmed resolve_btfids links to the new elfutils, and then rebuilt
> > the kernel with the same config. Unfortunately, the warnings/errors from
> > resolve_btfids and pahole still occur.
> > 
> > > SNIP
> > > >
> > > > I'd be grateful if some of the BTF/pahole experts could please review this
> > > > issue and share next steps or other details I might provide.
> > > >
> > > > Thanks,
> > > > Tony Ambardar
> > > >
> > > > Link: https://lore.kernel.org/all/202401211357.OCX9yllM-lkp@intel.com/ [1]
> > > > Link: https://github.com/acmel/dwarves/issues/45 [2]
> > > 
> > > Cheers,
> > > Hengqi
> > 
> > Thanks for the suggestion,
> > Tony

