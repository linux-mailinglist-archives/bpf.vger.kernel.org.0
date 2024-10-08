Return-Path: <bpf+bounces-41276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ADC99564A
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 20:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D61283A0D
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 18:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BE21264E;
	Tue,  8 Oct 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fanD8ZR1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A420ADE2;
	Tue,  8 Oct 2024 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411518; cv=none; b=FbBJa/CBZ17gyuBfw4mlcDGD6V2G4CAztlgFC+3xQCaeU5Ncio3YoJmKlyWHQMgw6u7LiV8BIi32wV00hIJQPmA1KTwBfgDQ+f+XstQBb1S8tajIRPq5TUPZBqihzHTFQ37p6q22kHKIquEw77fizStSR5dUz9YLiMZWD4+aQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411518; c=relaxed/simple;
	bh=zcCo+naKQ+6xHi3XDFC+ZU21mkrShiOyjKx/GJqC87U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B17EN6QWHt+e9+KLSY21hQIlT32/Nn/w68Z+jEuDblgiFJRK4zrpHA4mHWkr2A40+quO5hNFubiix9y0Nejj3OEiAjAIuJ/Zt+8+LYUrIWUYaHb+ZPwsxY0btipGwUhDxsSYtSLiRm6KczWaxfKvyll11NyAhR9JKnbXuQ1kpaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fanD8ZR1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so47965435e9.3;
        Tue, 08 Oct 2024 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728411515; x=1729016315; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=47h+WttSju8q0HbSBeD7ZI3w1+wXMpgqyxIWAg/Pnu8=;
        b=fanD8ZR1cn1ZyX/6LUiRDs3/sGj5WHNNUUUypdJv2HKBWz8xx1ol8bGSzy5SCdeSxI
         ysHSI4xXn4Zs2URuRLfXCaKW/yIA7Ly5itqoXPktzopLvScOGaGMvjzFYaqWtxI+Qb/1
         l/Y8oOn+Xu/76+zQ2Jra+KWrBoM/E15ar4ZxuXztif8pUgCefOtf0l8MMeCrsaA6Q3Oc
         dgOqbt077m3kdmIvbvVTrulrIUL9WZqTZCZ+9LGGsS3pG5SBM7Fs8lOiQCwzlZv7d5SL
         xipODmr9mQBQOyveCApeciIbOW/rc2grhq/ie1ob1WrLUBwYyCOEGMvk9DRdnjGk54FD
         uadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411515; x=1729016315;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47h+WttSju8q0HbSBeD7ZI3w1+wXMpgqyxIWAg/Pnu8=;
        b=m8VcHiYhgcKhajBwQwOo9gjWqKQyp4UxFNCqKdCRx9taiOasycNNzeN++SYFcQWmKk
         HDb/0bDa9nQb6xqImF9myF9VphAECikjC65VdroreotnrXZjNP7b3ITTqz9k4ZUCZ+fK
         urRCDdOjiI8yAooiQ5BDiXzEggrbt1qiSOP2bqIdScK2CNDm0gA+FYFUqvwBtOy3cEBo
         iaS7DoYqSXnF5fJ30Zy8jutiQM/i7FV/h4sehHSVoyuFMSW+zpNHztPxHRljTHE0Q/9j
         e0u5kqvHu0Jzf8ATry3yUzLMDvO3KeWa1yPGdGFRs/MAexoWaxFV6YVzwDjViN305G+a
         Bd8A==
X-Forwarded-Encrypted: i=1; AJvYcCU8pOFwOJ+tUQ0vKN2yQMpkCnpjO7jUoka/BqZWqrQJF0Zh6rmNg1ChPpurjvQnv2b7Qi0=@vger.kernel.org, AJvYcCW3spLvqcW7aoaNsvYMYBsV2Qwtwf/cteUrap7nRXo6v2fW1mZZhMsGwuwvmrwM6Kz5RNXm1iN1@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQqc4UlTxj8h68jH0df+7cRfaUix5Fw3BhKEKm/hQKW2yAugJ
	/SqplR55d8mE2NNBwrbzUeF4Thi/vGnnwT8ax9PjgH6PY0aL8VWw
X-Google-Smtp-Source: AGHT+IE9KDMQK2rADBlPUW3pV7FCsILciLufwIQGADHY2crqenBECqAhUw2W1Xdgb7N8WC3FoNOLyg==
X-Received: by 2002:a05:600c:4fcf:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42f85abeab0mr120700175e9.16.1728411514545;
        Tue, 08 Oct 2024 11:18:34 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43017466e4fsm19574595e9.0.2024.10.08.11.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:18:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Oct 2024 20:18:31 +0200
To: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Simon Sundberg <simon.sundberg@kau.se>, bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH bpf 2/4] selftests/bpf: Consolidate kernel modules into
 common directory
Message-ID: <ZwV3d5-sBYtgt2vi@krava>
References: <20241008-fix-kfunc-btf-caching-for-modules-v1-0-dfefd9aa4318@redhat.com>
 <20241008-fix-kfunc-btf-caching-for-modules-v1-2-dfefd9aa4318@redhat.com>
 <ZwVv_ZOvh2mTGAlK@krava>
 <87ploascn2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ploascn2.fsf@toke.dk>

On Tue, Oct 08, 2024 at 07:55:13PM +0200, Toke Høiland-Jørgensen wrote:
> Jiri Olsa <olsajiri@gmail.com> writes:
> 
> > On Tue, Oct 08, 2024 at 12:35:17PM +0200, Toke Høiland-Jørgensen wrote:
> >
> > SNIP
> >
> >> diff --git a/tools/testing/selftests/bpf/bpf_testmod/.gitignore b/tools/testing/selftests/bpf/test_kmods/.gitignore
> >> similarity index 100%
> >> rename from tools/testing/selftests/bpf/bpf_testmod/.gitignore
> >> rename to tools/testing/selftests/bpf/test_kmods/.gitignore
> >> diff --git a/tools/testing/selftests/bpf/test_kmods/Makefile b/tools/testing/selftests/bpf/test_kmods/Makefile
> >> new file mode 100644
> >> index 0000000000000000000000000000000000000000..393f407f35baf7e2b657b5d7910a6ffdecb35910
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/test_kmods/Makefile
> >> @@ -0,0 +1,25 @@
> >> +TEST_KMOD_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> >> +KDIR ?= $(abspath $(TEST_KMOD_DIR)/../../../../..)
> >> +
> >> +ifeq ($(V),1)
> >> +Q =
> >> +else
> >> +Q = @
> >> +endif
> >> +
> >> +MODULES = bpf_testmod.ko bpf_test_no_cfi.ko
> >> +
> >> +$(foreach m,$(MODULES),$(eval obj-m += $(m:.ko=.o)))
> >> +
> >> +CFLAGS_bpf_testmod.o = -I$(src)
> >> +
> >> +all: modules.built
> >> +
> >> +modules.built: *.[ch]
> >
> > curious, the top Makefile already checks for test_kmods/*.[ch], do we
> > need *.[ch] ?
> 
> Not really for building from the top-level Makefile, that is for running
> 'make' inside the subdir, in case anyone tries that. Don't feel strongly
> about it, so can remove it if you prefer?

no strong feelings either ;-) I was just wondering what was the purpose

thanks,
jirka

