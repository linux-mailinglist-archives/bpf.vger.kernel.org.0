Return-Path: <bpf+bounces-16183-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB917FE07D
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 20:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6332AB211AA
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047C5EE75;
	Wed, 29 Nov 2023 19:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhIvd7VL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FF812F
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:52:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5be3799791fso112298a12.3
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701287538; x=1701892338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5yBfexVnGjK9zT3HZQkyABuZs4aynbOBNLg3URm818I=;
        b=vhIvd7VLT9IVEnL+3RHfdlFioTqgbCkogKsPkRp8dTukhSDh9tH8MNb3uExfA82yoF
         50Vwyf3AVTE2Q25FN8PR3UuU+7xuohmD5EBEmegetFO+eI3SXRoWfzCBIn/hWkgFLomw
         cOFDFZBcsfZDKNFQxa4ijYvJhcoKx5RQ1dROANTy3MBvqxvVElM2inY3BRtDPWAjqEvH
         qyH9ox5pwcVv3K8xz96kGn2c+i9J+9+tjWzLcU7q+iS5fuuyRPJHxO3BJWmArSi7P8dx
         wMpziYtoUt/Og90PF1j35iP5v/X125gUdEpU6oXVk8gtY2vRLdVl87VZkuhih9SXlaVt
         E4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287538; x=1701892338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yBfexVnGjK9zT3HZQkyABuZs4aynbOBNLg3URm818I=;
        b=NdXuz7ZlRtQzeTWWBMiUODGoE6qelQ4qs4sAzmG5DsEeTmUpD9vIVaiP7c8qoOtRyz
         TxM1xJHzTGA1fNkh+tVuVTeDnpST5EIiAAdwmgPv9wnJNT3bxuQfVxAcoG4bFj7y73Dk
         XK8X1lKXlQ55N5wG9hiv2yp8a78rqnnYCI7QohzujKPv/VxIDH9DPmUZD+11yttRrg57
         BB3Hh3zmsgfjy0DdW2HPR9sZhKD0C7MaPZT8l1Iudmo3o35Pn2fDWOj8M80+Ti3HeT7S
         +CeX0DYjC8Jc8ysI5K5n8IkHrXgsHk6SjrsOcaw4YCKx1HwZJ2TeTMd4RO7lsyTxyg1I
         FJSg==
X-Gm-Message-State: AOJu0YxNT74dQcyDkjHyWMZfA7lBRjpZgwJCWArxC/GU4U3RfPbco14b
	49WFOyBru7AfrRRwNM6ZejYpDe0=
X-Google-Smtp-Source: AGHT+IE/bAe6yat1ELBoTysTNVFXDSpYFyBEtSfWnZTL9dc2J1KYFSoSrBW40He+g5e8T/b1H8UtjaY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:e848:0:b0:5be:1b76:6a87 with SMTP id
 a8-20020a63e848000000b005be1b766a87mr3323713pgk.12.1701287537886; Wed, 29 Nov
 2023 11:52:17 -0800 (PST)
Date: Wed, 29 Nov 2023 11:52:16 -0800
In-Reply-To: <20231129075409.2709587-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129075409.2709587-1-yonghong.song@linux.dev>
Message-ID: <ZWeWcIWpNHsSY0fK@google.com>
Subject: Re: [PATCH bpf] bpf: Fix a verifier bug due to incorrect branch
 offset comparison with cpu=v4
From: Stanislav Fomichev <sdf@google.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="utf-8"

On 11/28, Yonghong Song wrote:
> Bpf cpu=v4 support is introduced in [1] and Commit 4cd58e9af8b9
> ("bpf: Support new 32bit offset jmp instruction") added support for new
> 32bit offset jmp instruction. Unfortunately, in function
> bpf_adj_delta_to_off(), for new branch insn with 32bit offset, the offset
> (plus/minor a small delta) compares to 16-bit offset bound
> [S16_MIN, S16_MAX], which caused the following verification failure:
>   $ ./test_progs-cpuv4 -t verif_scale_pyperf180
>   ...
>   insn 10 cannot be patched due to 16-bit range
>   ...
>   libbpf: failed to load object 'pyperf180.bpf.o'
>   scale_test:FAIL:expect_success unexpected error: -12 (errno 12)
>   #405     verif_scale_pyperf180:FAIL
> 
> Note that due to recent llvm18 development, the patch [2] (already applied
> in bpf-next) needs to be applied to bpf tree for testing purpose.
> 
> The fix is rather simple. For 32bit offset branch insn, the adjusted
> offset compares to [S32_MIN, S32_MAX] and then verification succeeded.
> 
>   [1] https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev
>   [2] https://lore.kernel.org/bpf/20231110193644.3130906-1-yonghong.song@linux.dev
> 
> Fixes: 4cd58e9af8b9 ("bpf: Support new 32bit offset jmp instruction")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Acked-by: Stanislav Fomichev <sdf@google.com>

