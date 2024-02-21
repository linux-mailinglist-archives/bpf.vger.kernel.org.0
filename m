Return-Path: <bpf+bounces-22465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D046B85EB80
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29ABEB232CF
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569771272D6;
	Wed, 21 Feb 2024 22:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bpj48WmF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A4126F3A
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552872; cv=none; b=LKL+KcWuMsVhLjkS11783wn6D2+Zp74IsQhpt/HA+F/IVC+Nf5ZLEjYLXJq4K8mkihtGhyWgNo/lRt8h8isVRdFNVnGDrqfUvGLkvsJx50veiZ03hw/vKIfQWePhjWpctefBUwQZ45Ii+Sxgvt+DoflSwlKeimVugYFVct12vgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552872; c=relaxed/simple;
	bh=wqGWw9nOiid78rmVoNJpLAKogw9OxxtIINANjebVuns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqvzCmQK7gFrM+md/p3gd9JKTAJo+O7QQx9hpoF4M8q2btoO+Rj0rGGx5RxslONs4XyGlNHI27TNfxEFseCPxX0qJA023BkeMzFcJzfOILg92pUZmDqVbHqLYHB7phPr5g0ArTvIaPHR8whohRXEr30+WvvyDfuYVma3zsuVc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bpj48WmF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so27338775ad.2
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708552871; x=1709157671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k+6LHH2NPUzYokJHyaMeg6P0BHjKGeB4TbkarefmniY=;
        b=bpj48WmFS/Iv/Pl0hg7lOS8zJgnv0NSStFCNmbJ6KEpuG46kTUN/691glGTo/3Ussp
         p+NO4+VI9TFFxK1I1IpwAumuQPpNmQosA0O5VcsIoRgOfll/Zs90O7tq42+7asod3qYo
         QfauMBovnb/+K04a39tMMdP5sPWShkQq8NrPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552871; x=1709157671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+6LHH2NPUzYokJHyaMeg6P0BHjKGeB4TbkarefmniY=;
        b=n8rAVuSqbpiO2ERsuK9TIoOmsnP+i8L3IePHvf2Qh38hthcTdhgJXDTFIq4VJ3d0eQ
         aG5b2l/UrI8FsvgjNZkeGYGT3eu3qpAxjhf7q4CsS3Ko7H6TwFTfZC5XcTaJXUQQCviW
         69CqrQh5031m+im8oUcx28GqP6m/iXkoEUPn6PzMj3fwPoMvPNReF56K6T9eOAZgZ4VB
         8kteYeokOYMkNz0QO1iWlwpnAiMzNJOjx6fnOVIn5kKwHhOm3jWH6U9yl+BlfPge8TCO
         3HoYPB/dWVOZJAv2xIh6/6lTB4PS76pzYJ2HOj0Mm9qWCyN0Qgq9agIRjQMZjR73PMrD
         dhEw==
X-Forwarded-Encrypted: i=1; AJvYcCUSHaNmfj/z6WwO1/yfbtbIzLV0kfQ80ymbhjn6p+lWwI4Hq1/N+Ym+uog6E2UR1ho22WuCeZt6WIIG0j0zOWvLX9D5
X-Gm-Message-State: AOJu0Yxk1AMImUKeKrDB9Kv850Z3Munl7pxK1z1uPGyjRF6VG+WcdwzY
	V3L4dqPetziHSOeri9iltmOaxEexwyOV9qnMhtR6HuvWNxr2aV202reeXcjw2w==
X-Google-Smtp-Source: AGHT+IEf5eKUQSWm+opFfaiF5eBQJmg0AXhYyA+h2y9jNbW7sOQuiyq0AM8mKQQVx25bJ6R/7Y4UCw==
X-Received: by 2002:a17:902:f70f:b0:1dc:4b04:13d4 with SMTP id h15-20020a170902f70f00b001dc4b0413d4mr60269plo.8.1708552870628;
        Wed, 21 Feb 2024 14:01:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902e90400b001dbba4c8289sm8533989pld.202.2024.02.21.14.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:01:10 -0800 (PST)
Date: Wed, 21 Feb 2024 14:01:09 -0800
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
Message-ID: <202402211347.2AF2EC4621@keescook>
References: <20240220185421.it.949-kees@kernel.org>
 <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da75b2bf-0d14-6ed5-91c2-dfeba9ad55c4@iogearbox.net>

On Wed, Feb 21, 2024 at 05:39:55PM +0100, Daniel Borkmann wrote:
> The build in BPF CI is still broken, did you try to build selftests?

Okay, I give up. How is a mortal supposed to build these?

If I try to follow what I see in
https://github.com/libbpf/ci/blob/main/build-selftests/build_selftests.sh
I just get more and more kinds of errors:

In file included from progs/cb_refs.c:5:
progs/../bpf_testmod/bpf_testmod_kfunc.h:29:8: error: redefinition of 'prog_test_pass1'
   29 | struct prog_test_pass1 {
      |        ^
/srv/code/tools/testing/selftests/bpf/tools/include/vmlinux.h:106850:8: note: previous definition is
 here
 106850 | struct prog_test_pass1 {
        |        ^

Messing around with deleting vmlinux.h seems to get me further, but later:

/srv/code/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c: In function 'bpf_testmod_ops_is_valid_access':
/srv/code/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c:535:16: error: implicit declaration of function 'bpf_tracing_btf_ctx_access' [-Werror=implicit-function-declaration]
  535 |         return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~

and then I'm stuck. It looks like the build isn't actually using
KBUILD_OUTPUT for finding includes. If I try to add -I flags to the
Makefile I just drown in new errors.

-- 
Kees Cook

