Return-Path: <bpf+bounces-38068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E314395EEEA
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 12:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218491C22033
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 10:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3460176AD7;
	Mon, 26 Aug 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YMW2zspv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0417623F;
	Mon, 26 Aug 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669433; cv=none; b=TLRansH4KHx37Oh62OFvd5XgS8eaGx5KOK/RJr3T8A4pM195eOUODmJAPvkhEUWQTGla71QdtjVDAvcO38top2nilXxiBD6Ia2sC739uOnvnw3Gr2adrGsJuUQu3S6OHX1za1mBCygL/XaAR6vRjD+EqMdGqVsweMoQ2EQBH15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669433; c=relaxed/simple;
	bh=uAJWrnhKAr+TitU4/QOtd7gy/ZzpWQKw7fRDPeKcgIE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1I1QX2RVFGdevzH61DupNEXmLglv5weiBQaO/azNjoCSTOSqoSgNtbd2rsHEjcqyBuReYYgzJQod/wVhFlWAsrhoozF29vZwFrPfT8B9J6kEy2P6LTSvfmTxzZ5OHX3+DAO+InsfFr6ZT36fDfbxWdTEd1OXvCZW1/I3fu69DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YMW2zspv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7141feed424so3372418b3a.2;
        Mon, 26 Aug 2024 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724669431; x=1725274231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kz4Xwf3jhGksglONaJ7p+UE/pw0jxJqIllk99bmumcY=;
        b=YMW2zspvMVCS1eloegvXqWe0jz85aZczh2RB4A9otvGRypuQpTU0sO7qJUUeeI6xBH
         5dbz8CRYiDTRDMukdAfdjlSTke2RtxnrckKGiYNDNWKs4TCvI6J7Be0ramngHqFc5hb6
         j4qKMIgkf44eD3HySYpatId9o28nK62OiuJoS9ZYt062pzEHLyTcTiqVbhjrtecxc5AD
         1dI8+pxR9VmGW8sKVSrzKx39fBmQpEbEjX+i7Z8BASIfDBEgBHKboqNjcmiO0yBnLlRM
         OQR/wrMN5Xk5Vz0fAWG1QH3qu7DWnUjrs+krlZ7xmNMggUrrbZeekYa4o1IJ7LMXeoVJ
         itZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724669431; x=1725274231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kz4Xwf3jhGksglONaJ7p+UE/pw0jxJqIllk99bmumcY=;
        b=gb+pC1wsgURoBkHBIv2sLHYajhKFawqFPhwD5dGgmVIWO0oS8YtpA5U/b7LltyPQNV
         A57eWHC7/5dRLqdeEEZSDu/UzEVbg3hcIpijI9pjD7pRe/IH11PeFukJwz6n2oMDY+Oj
         DINER3clfkypVPOxMWPaBIJWL4LrILYBaSUHvd5QOmXPfF8EO6t7WUM68eI6eVBv3ioy
         KWJKy/JHOJqWXlQLavdFutoF3UFVJIoWuFqTu68RxwMSQfh47M9EyJ7FF3cG3FnkiIyh
         oqmHzKmIoZNjgnJwf2o2Fws39zvCcW4Vz2BFiHTy43S7EULYy2FcbgYWNuNj6W7QfJVC
         dJFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk0t9ALwHX4mxgIDN05WxkfmOMiio4U6y6TK7iHBkVeMKTmzeQtMiU+r+9Ol0NSrARDwo=@vger.kernel.org, AJvYcCXf4SVUAbwVOgFtKIeMyPeqrjLHzKqMLZExD3dFixx7O+fEpAYPucJqPMWs5NSZrkNfUnEhPipheg/B3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaFY4to3r86RncEU3UN+5IV9Wiu7Wq2S4TBtON8jCx31gq6Pc
	FsNLBsI1ixG5OnGdrOY7OCbU1nROpUBFQp+eeF8tVb4E3shRI/QXExAUGQ==
X-Google-Smtp-Source: AGHT+IE+B6Dhu7mYsvVdA80XUfKbYNh6db4h8UlzbeNdJYdKTPQRqiwqqQhSfx+8JfTMMsGLlYcsaw==
X-Received: by 2002:a05:6a20:4311:b0:1c4:87b9:7ef9 with SMTP id adf61e73a8af0-1cc8b59171emr11036512637.42.1724669431035;
        Mon, 26 Aug 2024 03:50:31 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557f59bsm65602475ad.97.2024.08.26.03.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 03:50:30 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Mon, 26 Aug 2024 03:50:28 -0700
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org,
	linux-s390@vger.kernel.org, llvm@lists.linux.dev,
	Alexei Starovoitov <ast@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Subject: Re: Problem testing with S390x under QEMU on x86_64
Message-ID: <Zsxd9HskofXttp+p@kodidev-ubuntu>
References: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
 <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>
 <ZsU3GdK5t6KEOr0g@kodidev-ubuntu>
 <Zspq+db1KOhhh2Yf@kodidev-ubuntu>
 <c8c590b2-40b2-4cc0-9eb7-410dbd080a49@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8c590b2-40b2-4cc0-9eb7-410dbd080a49@linux.dev>

On Sun, Aug 25, 2024 at 01:23:51PM -0700, Yonghong Song wrote:
> 
> On 8/24/24 4:21 PM, Tony Ambardar wrote:

[snip]

> > 
> > Test '#525 verif_scale_pyperf600:FAIL' was caused by clang miscompilation
> > exposed by my use of clang-19 and clang-20. The test passes when built
> > with clang-17 (used by BPF CI) or clang-18 which I switched to use.
> 
> x86 has the same issue where clang19 generated code will cause verification
> failure. Eduard is working on this.
> 
> > 
> > One symptom of the problem is easily seen by manually compiling:
> > 
> > $ clang-18  -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endian -Itools/testing/selftests/bpf/tools/include -Itools/testing/selftests/bpf -Itools/include/uapi -Itools/testing/selftests/usr/include -Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-18/lib/clang/18/include -idirafter /usr/local/include -idirafter /usr/lib/gcc-cross/s390x-linux-gnu/11/../../../../s390x-linux-gnu/include -idirafter /usr/include/s390x-linux-gnu -idirafter /usr/include -DENABLE_ATOMICS_TESTS -O2 --target=bpfeb -c tools/testing/selftests/bpf/progs/pyperf600.c -mcpu=v3 -o pyperf600.clang18.bpf.o
> > 
> > $ clang-19  -g -Wall -Werror -D__TARGET_ARCH_s390 -mbig-endian -Itools/testing/selftests/bpf/tools/include -Itools/testing/selftests/bpf -Itools/include/uapi -Itools/testing/selftests/usr/include -Wno-compare-distinct-pointer-types -idirafter /usr/lib/llvm-19/lib/clang/19/include -idirafter /usr/local/include -idirafter /usr/lib/gcc-cross/s390x-linux-gnu/11/../../../../s390x-linux-gnu/include -idirafter /usr/include/s390x-linux-gnu -idirafter /usr/include -DENABLE_ATOMICS_TESTS -O2 --target=bpfeb -c tools/testing/selftests/bpf/progs/pyperf600.c -mcpu=v3 -o pyperf600.clang19.bpf.o
> > 
> > $ llvm-readelf-18 -S pyperf600.clang{18,19}.bpf.o |grep .symtab
> >    [27] .symtab           SYMTAB          0000000000000000 1739d0 01ad60 18      1 4572  8
> >    [27] .symtab           SYMTAB          0000000000000000 14f048 0001e0 18      1  12  8
> > 
> > Notice that the .symtab has shrunk by ~200X for example going to clang-19!
> > (CCing llvm maintainers)
> 
> This is a known issue. In llvm18, all labels (to identify basic blocks) are in symbol table.
> Those labels are removed from symbol table in llvm19.

Glad to hear this a known issue being looked at now. A quick search on my part found nothing, so sorry for the noise and thanks for clarifying.

> 
> > 
> > 
> > Kind regards,
> > Tony
> > 

