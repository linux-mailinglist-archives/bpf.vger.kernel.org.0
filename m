Return-Path: <bpf+bounces-22464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200F85EB25
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D50A5B2672F
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454E812AAD1;
	Wed, 21 Feb 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LNhDoZGR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD6E1292FC
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551524; cv=none; b=rzgb5K6ESbgsccQQQls6FEeWanXDOul1sLXP177tFjX6iPnCqaUwoux8iOpEWtDRqLbUuDcg3Pgo8vve+Skuebys3q9/GCGrTVfxF4CH+2c62nV2lzr5/By1HMtiLhYyltmPm4T1YlM2hquNmu+17f9j1vg54G/gH9fKOACYqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551524; c=relaxed/simple;
	bh=tdC/CiuVWPHSufrgRHTfCGIP/BXt+NRLyAohkR1KzmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJHUWKXoF69fpiIhAuqyYRqzc+InaijmNhKy7rKvM55PPKkTfFhYoKwNliX7n6viZLCHZMJKq9xWOv0AZEhR5YmpUsSQX1MwMCqKeIrhPmpE2Xcu5aZTcxAB/vkJPwAtAhZyrRhSY3/X6WG6wDPPilrnluSDhDPLuuRVvHNRYUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LNhDoZGR; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso4194069b3a.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708551521; x=1709156321; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UQex++ttS4RzCrpq+AKJPUO9eah2DR726vpHNT3YCIg=;
        b=LNhDoZGRhp2bqQOiJ1qjqrA970ZBKux361+V7tI+5aENf+JiyIYxOvdBaFVR9h+3q2
         72iEdCibq48fBJwOeWpyJArrnwMXfg5ilHXZmRgkQCipKC/b6Qq0A60XAOswRFlzDELW
         C6DCRbL8VGc1seF8EQHY+PwqXmAgx+GyrtFe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551521; x=1709156321;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQex++ttS4RzCrpq+AKJPUO9eah2DR726vpHNT3YCIg=;
        b=MWGbO88I2Khf/s85YR1BigPLvT1r4LEOans1udFrm50e9rgPzLbdWUbLPZjx/t34yE
         97NvqYXb4UcFX+pMr+xAOxOI8GCpgkPu9xxAJ6mo7pnAoejOYGTqS8udyybFq4X50B8Y
         IjrXLQF3mMEgvkpd6DMK7N9Y7MhuNi6/0zBVbJ/b+o19L9qYo6ozkolC0b/QAFnsNzdL
         3cmKavMnfExoX26D4ghDqESmJxTAMhOzYxeRqzgx1WetIX6V26AhEH48tM/f0yM5R5Kx
         +iNFk88RLmc3Bj2hI3fqrbaVM2GBZ2BnCOU0on8JBa+aMWL3eYabXxRTmalqE3KuP1tu
         Ii/A==
X-Forwarded-Encrypted: i=1; AJvYcCU9RAy1XP2+8gjq38HEyGAITuRwNNLNWb8z4VzZ0gn66KXG4efsTyTJwreomQhe/jjP75bk4ruPV7IrFDuew98RrrFe
X-Gm-Message-State: AOJu0YzNglPc5IDF6ZjZVGzanD4e7yjGtb3A0dx4EzAd3wVW0Oxk1Uxi
	TBzoqSNLyfQe2Mocwz3JiYnKPaajfxlaVZSyCkV6YhBII7e1+2jOIMh5SFuVWQ==
X-Google-Smtp-Source: AGHT+IHDh/MRb5Op0VGAH3i2K/wXYQriert54RdfL+L6lC7CA/epD+rsZx/gHYIBfDp8bfXy2Py4ow==
X-Received: by 2002:a05:6a21:1014:b0:1a0:c46f:62be with SMTP id nk20-20020a056a21101400b001a0c46f62bemr3014569pzb.38.1708551521543;
        Wed, 21 Feb 2024 13:38:41 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b006e45daf9e89sm7123140pfa.131.2024.02.21.13.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:38:40 -0800 (PST)
Date: Wed, 21 Feb 2024 13:38:40 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Mark Rutland <mark.rutland@arm.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Haowen Bai <baihaowen@meizu.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yonghong Song <yonghong.song@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Yafang Shao <laoar.shao@gmail.com>, Kui-Feng Lee <kuifeng@meta.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402211317.4D3DEDCA2@keescook>
References: <20240220185421.it.949-kees@kernel.org>
 <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>

On Wed, Feb 21, 2024 at 05:39:55PM +0100, Daniel Borkmann wrote:
> On 2/20/24 7:54 PM, Kees Cook wrote:
> > Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> > flexible array. Found with GCC 13:
> > 
> > ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
> >    207 |                                        *(__be16 *)&key->data[i]);
> >        |                                                   ^~~~~~~~~~~~~
> > ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
> >    102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> >        |                                                      ^
> > ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
> >     97 | #define be16_to_cpu __be16_to_cpu
> >        |                     ^~~~~~~~~~~~~
> > ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
> >    206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> > ^
> >        |                            ^~~~~~~~~~~
> > In file included from ../include/linux/bpf.h:7:
> > ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
> >     82 |         __u8    data[0];        /* Arbitrary size */
> >        |                 ^~~~
> > 
> > And found at run-time under CONFIG_FORTIFY_SOURCE:
> > 
> >    UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
> >    index 0 is out of range for type '__u8 [*]'
> > 
> > Changing struct bpf_lpm_trie_key is difficult since has been used by
> > userspace. For example, in Cilium:
> > 
> > 	struct egress_gw_policy_key {
> > 	        struct bpf_lpm_trie_key lpm_key;
> > 	        __u32 saddr;
> > 	        __u32 daddr;
> > 	};
> > 
> > While direct references to the "data" member haven't been found, there
> > are static initializers what include the final member. For example,
> > the "{}" here:
> > 
> >          struct egress_gw_policy_key in_key = {
> >                  .lpm_key = { 32 + 24, {} },
> >                  .saddr   = CLIENT_IP,
> >                  .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
> >          };
> > 
> > To avoid the build time and run time warnings seen with a 0-sized
> > trailing array for struct bpf_lpm_trie_key, introduce a new struct
> > that correctly uses a flexible array for the trailing bytes,
> > struct bpf_lpm_trie_key_u8. As part of this, include the "header"
> > portion (which is just the "prefixlen" member), so it can be used
> > by anything building a bpf_lpr_trie_key that has trailing members that
> > aren't a u8 flexible array (like the self-test[1]), which is named
> > struct bpf_lpm_trie_key_hdr.
> > 
> > Adjust the kernel code to use struct bpf_lpm_trie_key_u8 through-out,
> > and for the selftest to use struct bpf_lpm_trie_key_hdr. Add a comment
> > to the UAPI header directing folks to the two new options.
> > 
> > Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
> > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > Closes: https://paste.debian.net/hidden/ca500597/
> > Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> [...]
> 
> The build in BPF CI is still broken, did you try to build selftests?

I did! I didn't have this error. :(

>   https://github.com/kernel-patches/bpf/actions/runs/7978647641

Thanks for the pointer. It took a bit of digging, but I found this:
https://github.com/libbpf/ci/blob/main/build-selftests/build_selftests.sh
which is much more involved than just "make -C tools/testing/selftests/bpf"

> 
>   [...]
>     GEN-SKEL [test_progs] linked_funcs.skel.h
>     LINK-BPF [test_progs] test_usdt.bpf.o
>     GEN-SKEL [test_progs-no_alu32] profiler1.skel.h
>     GEN-SKEL [test_progs] test_usdt.skel.h
>   In file included from /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:11,
>                    from test_cpp.cpp:4:
>   /tmp/work/bpf/bpf/tools/include/uapi/linux/bpf.h:92:17: error: ‘struct bpf_lpm_trie_key_u8::<unnamed union>::bpf_lpm_trie_key_hdr’ invalid; an anonymous union may only have public non-static data members [-fpermissive]
>      92 |  __struct_group(bpf_lpm_trie_key_hdr, hdr, /* no attrs */,
>         |                 ^~~~~~~~~~~~~~~~~~~~
>   /tmp/work/bpf/bpf/tools/include/uapi/linux/stddef.h:29:10: note: in definition of macro ‘__struct_group’
>      29 |   struct TAG { MEMBERS } ATTRS NAME; \
>         |          ^~~

I'll see if I can figure out where this is coming from. This sounds like
something is being built with an unexpectedly strict option. (The above
report seems weird -- this isn't coming from -fpermissive, and is
actually an _error_ not a warning, which is the opposite of what
-fpermissive is supposed to do.) Also the mention of "public" is scary
here... that implies a C++ compiler is involved? Maybe that's why my
builds didn't catch this?

>   make: *** [Makefile:703: /tmp/work/bpf/bpf/tools/testing/selftests/bpf/test_cpp] Error 1

Ah yes, cpp. Fun. I will try to reproduce this failure.

-- 
Kees Cook

