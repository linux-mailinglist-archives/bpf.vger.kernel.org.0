Return-Path: <bpf+bounces-13773-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F11627DDAA7
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 02:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F0BB21021
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DC6A35;
	Wed,  1 Nov 2023 01:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB70D65F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 01:39:56 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED9F5
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:39:53 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-41cc7b67419so45253801cf.2
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 18:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698802793; x=1699407593;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsJPNaVE/yTDKUnfj9Hu2OfLmVx5xX7bVJZoSTgP1Go=;
        b=KVqSGZTzsvhgSWVSPCfqkR5xEkod10v6j6L1EDKWeWmcnf5tFkRRwD/53H5pEAMAyp
         oAc2ckVFSqfSOC5AG3bjvdq+T/FXJnkI5jcTX8MtgsVXyonMQ1Qhmgtx24fHgJH4bDgi
         Ag9jzEsLyrVsybm2Iw54SIkFECgOuf45uysvLZbpOAewLwgRaF8eKm2Dzbekm7gl4vkr
         WULss3moskmPldjlybAbRK601lJLAl/D+Xfx2qw6cBQ+5khtt4IgQ6YZyTyfnvH0wRXp
         E4GUWAyVkrFl7QanU2+atlyZ856E+6Wf5h4YgUFmV7NsgetJr614DDsjE07snRs8qDiS
         X2Ow==
X-Gm-Message-State: AOJu0YzDXdmkLZYQe5KU7vP4vNGqpffFS8qwOelEsx0pM9tEumpc/qS0
	9xtbVEV7q6hmW6z8lxqGeAA=
X-Google-Smtp-Source: AGHT+IHch6EN6x0cn83pB+tc/zFO2lNNwRxWAMuKc565IRE32tzAK1Q/XF9OMfKSkG9hEFD13MpTzA==
X-Received: by 2002:ac8:5d8c:0:b0:41e:1f5d:7000 with SMTP id d12-20020ac85d8c000000b0041e1f5d7000mr16281984qtx.54.1698802792632;
        Tue, 31 Oct 2023 18:39:52 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id z14-20020ac87cae000000b004166905aa2asm978921qtv.28.2023.10.31.18.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 18:39:52 -0700 (PDT)
Date: Tue, 31 Oct 2023 20:39:50 -0500
From: David Vernet <void@manifault.com>
To: Dave Marchevsky <davemarchevsky@fb.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kernel Team <kernel-team@fb.com>, laoar.shao@gmail.com,
	Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Add __bpf_kfunc_{start,end}_defs
 macros
Message-ID: <20231101013950.GA11478@maniforge>
References: <20231031215625.2343848-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031215625.2343848-1-davemarchevsky@fb.com>
User-Agent: Mutt/2.2.10 (2023-03-25)

On Tue, Oct 31, 2023 at 02:56:24PM -0700, Dave Marchevsky wrote:
> BPF kfuncs are meant to be called from BPF programs. Accordingly, most
> kfuncs are not called from anywhere in the kernel, which the
> -Wmissing-prototypes warning is unhappy about. We've peppered
> __diag_ignore_all("-Wmissing-prototypes", ... everywhere kfuncs are
> defined in the codebase to suppress this warning.
> 
> This patch adds two macros meant to bound one or many kfunc definitions.
> All existing kfunc definitions which use these __diag calls to suppress
> -Wmissing-prototypes are migrated to use the newly-introduced macros.
> A new __diag_ignore_all - for "-Wmissing-declarations" - is added to the
> __bpf_kfunc_start_defs macro based on feedback from Andrii on an earlier
> version of this patch [0] and another recent mailing list thread [1].
> 
> In the future we might need to ignore different warnings or do other
> kfunc-specific things. This change will make it easier to make such
> modifications for all kfunc defs.
> 
>   [0]: https://lore.kernel.org/bpf/CAEf4BzaE5dRWtK6RPLnjTW-MW9sx9K3Fn6uwqCTChK2Dcb1Xig@mail.gmail.com/
>   [1]: https://lore.kernel.org/bpf/ZT+2qCc%2FaXep0%2FLf@krava/
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Jiri Olsa <olsajiri@gmail.com>

Acked-by: David Vernet <void@manifault.com>

Thanks for taking care of this!

