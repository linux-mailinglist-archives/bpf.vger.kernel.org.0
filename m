Return-Path: <bpf+bounces-22267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779785AC65
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 20:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5792852B8
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC255675B;
	Mon, 19 Feb 2024 19:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BsRtgLJs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F8F5644B
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372120; cv=none; b=j7J1+FBtcLUHSfinItjl8QfkJArbUzV8IAW8C+5xO9IJYWT6wqaxHOh2lOH+CqFXlr/uoEYw51BXsofW/chyBRZk+VTu7mAWzwS4lNc1hNsqqr5F2dv0EDDzUSSDXAVtvriN5oJI2c5D6eafshgWeomba6mG9eVDKA4qmr5nd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372120; c=relaxed/simple;
	bh=mTwnrWFRVkMmk/C370Z2PfPl2ZzMt3ZnRg8rjXdj5M8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sH7rofAwYaUiUVEmovBBy2QVtCiPO5dxivttvdUH//wVT04H3/axNJ0f0lo8jSaESc8nsFheFeDHsAArPpFgrV4HQn5ng+sHtze1S2GSf6EgWaEe5nyXJDtKhnqnP5678aAsL1jk4hjt9wKoXp6GwwB6v8nWrqnSAVHXLpQh2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BsRtgLJs; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3086131a12.3
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 11:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708372118; x=1708976918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DOFMy5aAASBYxwEuY26DwtWuV8GmVWpkF2wskH7Kuzg=;
        b=BsRtgLJsQMCLQ16wev0X7ok0toZRzp0KMmRlhfMFBLuARhuBWGzIl1ddg0B+jTFuxw
         bX3pq1/yM9RamwfpYN0PVgdPZ5W3X9xlsiGPQq+t6dM9+Y120t+uk2oRPHPq6ZzQA8lY
         JskCbXmzlBznsWKd0WPivfLmfJ0+Gtj7FMo7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372118; x=1708976918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOFMy5aAASBYxwEuY26DwtWuV8GmVWpkF2wskH7Kuzg=;
        b=FNuhihtqUDIObL5wr4tuH3ZvWbzaHXhSPqtGV7JgCY9bPBgx9wXa68WbC5jw5VhmvT
         NTWGh4LG91tNiKXE/kAMSWGeFJURbOBLBSb7G+xA6PbS01yZGTv75uATcX2es19o1dLX
         m5foISIdr1YMNixZNHL7i0g8ajW36n2Zzw4COQPzJHWwXNJ3vMZHM3NNzqPCGzX/+OSx
         JBVjraRDcSrWMpgPl84aQaJowEA22TSf7iBwE/mZUaqNe5JfLOgpll88n5bVliN3thc7
         GqNT4ezsyrV/XlAFYAy7DCMgmd9tIX6BGpmYwODpDFLW7+gxMyjHF21CzAoWGfE8VJSC
         XKVA==
X-Forwarded-Encrypted: i=1; AJvYcCWtQ3tOWs9MSEb+4FIydiYKzfEue3vkoegoXUJN542Z/zQ4zivWpp5LejwAKqJRkvfM+MOsAnsgTJDSV71Ty5NX6IsI
X-Gm-Message-State: AOJu0YwVkaPQRNcz2b8BqmVYFNJmFb4YDwna1rmpe8MSG62lZu4ezgwG
	6bzZeo9Zlu5iDc4KheNfSfPr3FrZuJDnqYfyfpeJE0RuK4ASIYov9irBDcRYuQ==
X-Google-Smtp-Source: AGHT+IGPuriO6pO2eohejQtmG+dYzeSLnoSt3wKlrVseB6ozhIMP/LdUZ29p1wXTlJey7+1f6pPqsA==
X-Received: by 2002:a17:903:298b:b0:1db:be69:d02d with SMTP id lm11-20020a170903298b00b001dbbe69d02dmr11902487plb.32.1708372118058;
        Mon, 19 Feb 2024 11:48:38 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a16-20020a170902b59000b001d8dd636705sm4716588pls.190.2024.02.19.11.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 11:48:37 -0800 (PST)
Date: Mon, 19 Feb 2024 11:48:37 -0800
From: Kees Cook <keescook@chromium.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Anton Protopopov <aspsk@isovalent.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bpf: Replace bpf_lpm_trie_key 0-length array with
 flexible array
Message-ID: <202402191144.C4DB9B7AA@keescook>
References: <20240216235536.it.234-kees@kernel.org>
 <e58d035c-fb74-4d29-94d5-6c22542e7513@embeddedor.com>
 <202402161902.FCFFEC322@keescook>
 <a74a7255-5dbd-060e-fe2f-ac3563f466fb@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a74a7255-5dbd-060e-fe2f-ac3563f466fb@iogearbox.net>

On Mon, Feb 19, 2024 at 06:48:41PM +0100, Daniel Borkmann wrote:
> On 2/17/24 4:03 AM, Kees Cook wrote:
> > On Fri, Feb 16, 2024 at 06:27:08PM -0600, Gustavo A. R. Silva wrote:
> > > On 2/16/24 17:55, Kees Cook wrote:
> > > > Replace deprecated 0-length array in struct bpf_lpm_trie_key with
> > > > flexible array. Found with GCC 13:
> > > > 
> > > > ../kernel/bpf/lpm_trie.c:207:51: warning: array subscript i is outside array bounds of 'const __u8[0]' {aka 'const unsigned char[]'} [-Warray-bounds=]
> > > >     207 |                                        *(__be16 *)&key->data[i]);
> > > >         |                                                   ^~~~~~~~~~~~~
> > > > ../include/uapi/linux/swab.h:102:54: note: in definition of macro '__swab16'
> > > >     102 | #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
> > > >         |                                                      ^
> > > > ../include/linux/byteorder/generic.h:97:21: note: in expansion of macro '__be16_to_cpu'
> > > >      97 | #define be16_to_cpu __be16_to_cpu
> > > >         |                     ^~~~~~~~~~~~~
> > > > ../kernel/bpf/lpm_trie.c:206:28: note: in expansion of macro 'be16_to_cpu'
> > > >     206 |                 u16 diff = be16_to_cpu(*(__be16 *)&node->data[i]
> > > > ^
> > > >         |                            ^~~~~~~~~~~
> > > > In file included from ../include/linux/bpf.h:7:
> > > > ../include/uapi/linux/bpf.h:82:17: note: while referencing 'data'
> > > >      82 |         __u8    data[0];        /* Arbitrary size */
> > > >         |                 ^~~~
> > > > 
> > > > And found at run-time under CONFIG_FORTIFY_SOURCE:
> > > > 
> > > >     UBSAN: array-index-out-of-bounds in kernel/bpf/lpm_trie.c:218:49
> > > >     index 0 is out of range for type '__u8 [*]'
> > > > 
> > > > This includes fixing the selftest which was incorrectly using a
> > > > variable length struct as a header, identified earlier[1]. Avoid this
> > > > by just explicitly including the prefixlen member instead of struct
> > > > bpf_lpm_trie_key.
> > > > 
> > > > Note that it is not possible to simply remove the "data" member, as it
> > > > is referenced by userspace
> > > > 
> > > > cilium:
> > > >           struct egress_gw_policy_key in_key = {
> > > >                   .lpm_key = { 32 + 24, {} },
> > > >                   .saddr   = CLIENT_IP,
> > > >                   .daddr   = EXTERNAL_SVC_IP & 0Xffffff,
> > > >           };
> > > > 
> > > > systemd:
> > > > 	ipv6_map_fd = bpf_map_new(
> > > > 			BPF_MAP_TYPE_LPM_TRIE,
> > > > 			offsetof(struct bpf_lpm_trie_key, data) + sizeof(uint32_t)*4,
> > > > 			sizeof(uint64_t),
> > > > 			...
> > > > 
> > > > The only risk to UAPI would be if sizeof() were used directly on the
> > > > data member, which it does not seem to be. It is only used as a static
> > > > initializer destination and to find its location via offsetof().
> > > > 
> > > > Link: https://lore.kernel.org/all/202206281009.4332AA33@keescook/ [1]
> > > > Reported-by: Mark Rutland <mark.rutland@arm.com>
> > > > Closes: https://paste.debian.net/hidden/ca500597/
> > > 
> > > mmh... this URL expires: 2024-05-15
> > 
> > Yup, but that's why I included the run-time splat above too. :)
> 
> I don't quite follow, this basically undoes 3024d95a4c52 ("bpf: Partially revert
> flexible-array member replacement") again with the small change that this 'fixes'
> up the BPF selftest to not embed struct bpf_lpm_trie_key.
>
> Outside of BPF selftests though aren't we readding the same error that we fixed
> earlier for BPF programs in the wild which embed struct bpf_lpm_trie_key into their
> key structure?

Oops, yes, sorry. I see how that cilium does include it in the same
fashion. I will adjust this patch again. Thanks for double-checking!

struct egress_gw_policy_key {
        struct bpf_lpm_trie_key lpm_key;
        __u32 saddr;
        __u32 daddr;
};

-- 
Kees Cook

