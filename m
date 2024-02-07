Return-Path: <bpf+bounces-21421-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D783E84CF55
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79104284932
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFD823AF;
	Wed,  7 Feb 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M391zmN0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0281ADF
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325464; cv=none; b=EVovKaP1UzaKxZ9nOpkzX+pi2x/OBAdstY7sdSm0SrEoNOP5D8INEoN7qR/h7ZNqwfmJOjbKKcP0pyDDiwaVNNGv/fENiLcWJ/Q3OZD6diHdK7C4PSopZaqFbWwwxpphm7K9/FDWY8xJIzds4u7uzW5xA5DMyes8AEu8XG8PtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325464; c=relaxed/simple;
	bh=rxiNoiR8+1lVfK6grUmR9Ez91ZuLgmZVAR22/YfuBT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORBgtI+Y5yqLIEXoBYF+Kkd/4lMJ01XCcVYbBzq3rTDPZkx/EqRaoLYdz5dk4EwnywWCv8/A1BdpB7+LA6wCg1EJcFmmZecTOC4QzyqLMEzCF8TrRw3kBYCW78U3Zcsi+43Fs6zH//ZMxfeHSXOeVI882jkdMoEv2Vo2qeV6j8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M391zmN0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so1111648a12.1
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 09:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707325461; x=1707930261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bhaoqcWYBq6WE1pA0sdZJ3AMjQVihLX4TaDPsGVB7dw=;
        b=M391zmN04K022IPPcKaqK/k+Jovg72aIiVTuXzD0pcQ0kEVj5IfOmowckARVtg4fP5
         TJLIalGPVIw8WlqJ48OBbZB2rWkLDZY57PKjALdLVA8FWqE6Q3pFDjcdVdIBa8Pz15Fd
         2W5f8QQFOSD+3acqJEm995e37RfofTwQ+WjE9k/Ibs0A7mlIGxFyZnEle8EH7GAKIWD7
         iTYjcfvMxgyAOv/r9kg4llCgdpD0X82KSIh/2V/uTKEYI6wBqynLV0emfRnpn2CN89jN
         rSCWZfeM4Z3yt9elGcCpOZByW8k0cZ4yg24ZWsLV9tpVn6OpkaVnuxSeYKefa+l9M4YL
         ywqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325461; x=1707930261;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhaoqcWYBq6WE1pA0sdZJ3AMjQVihLX4TaDPsGVB7dw=;
        b=quxZaozd7BeK0CMbOwUu7ViTgfOavTUxZG+aG0xpQTjWkDlVEjeT4VVZe8nkX6YjD7
         Prh9ZgpsVm+7SOHe1FsLxlBsx0R39SKSZ8sh1BJN17JH4/TGDcH6ZHhlxZgHRy+OLJr/
         r5RA93XHm77dXcYj4dCtX1FoBC8JXfJLFUy5E5XidHhO4yMIUSiEke500fGRcHzjVnAc
         b4FQHiZDw3yl6LD6f/IItm/lc2P9Lu+CcyjfX9/54CQ1msjhtp1WYM5rlAD96/F/1N6F
         E51mggrd+cgzBxcGzmNh5ECog6RGqE3k9GtwD5OPcsElVDV5/6ta/6ykrCt7jaGwSYUu
         xHWA==
X-Gm-Message-State: AOJu0YwjIkIcyR6inUC2GQ1g4npdZ9HGL4GLqsPWYag3zED07bxYlgQu
	dh7YGooRuE0mZEuPKZOiXrVYGpI74p4MHB7q1W/bMBYNgZ3QiCvD
X-Google-Smtp-Source: AGHT+IHRBR/2WhSaKGewrC/+rxAOjYH7OTUOOESPli/UxrVCHaT3KTPyozDJlnFukYWBeRvsEEXjKA==
X-Received: by 2002:aa7:d406:0:b0:560:cb10:65dc with SMTP id z6-20020aa7d406000000b00560cb1065dcmr2154569edq.33.1707325460990;
        Wed, 07 Feb 2024 09:04:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUY73TH9L4J8hRBF1bV0F4Y7a6D4uU3XvisIbJLhHabuUvYn6ku3Lbg/qkPCbPoHY3PSGY3+kGsbPyKyLKvSv8mxP9QRPr5h9EHAfCoToL/M0liUltVWBJ6/mI4QJFMjIEpdIa3bpBy50LktCeKQe8xA3GgT3uVWmANkSeYPMSJbd2pq7xghx0txNtKuQ68nai3mgHxykOS+hPU4mYWXw4qCiROdQEum/jbagQJ3BOCzsJUrmNqRuEfgFatyj17VTKNU300bcRcpa5R3rgzWQMZBpwK09cANf2NIZo=
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c0d1000000b0055f50417843sm838582edp.22.2024.02.07.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:04:20 -0800 (PST)
Message-ID: <3115274419b6bf0a27facdc0b41094842fc61c84.camel@gmail.com>
Subject: Re: [PATCH bpf-next 15/16] selftests/bpf: Add bpf_arena_list test.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, tj@kernel.org, brho@google.com, hannes@cmpxchg.org, 
	linux-mm@kvack.org, kernel-team@fb.com
Date: Wed, 07 Feb 2024 19:04:19 +0200
In-Reply-To: <20240206220441.38311-16-alexei.starovoitov@gmail.com>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
	 <20240206220441.38311-16-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 14:04 -0800, Alexei Starovoitov wrote:
[...]

> diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing=
/selftests/bpf/bpf_arena_list.h
> new file mode 100644
> index 000000000000..9f34142b0f65
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_arena_list.h

[...]

> +#ifndef __BPF__
> +static inline void *bpf_iter_num_new(struct bpf_iter_num *, int, int) {	=
return NULL; }
> +static inline void bpf_iter_num_destroy(struct bpf_iter_num *) {}
> +static inline bool bpf_iter_num_next(struct bpf_iter_num *) { return tru=
e; }
> +#endif

Note: when compiling using current clang 'main' (make test_progs) this repo=
rts the following errors:

In file included from tools/testing/selftests/bpf/prog_tests/arena_list.c:9=
:
./bpf_arena_list.h:28:59: error: omitting the parameter name in a function
                                 definition is a C23 extension [-Werror,-Wc=
23-extensions]
   28 | static inline void *bpf_iter_num_new(struct bpf_iter_num *, int, in=
t) { return NULL; }
   ...

So I had to give parameter names for the above functions.


