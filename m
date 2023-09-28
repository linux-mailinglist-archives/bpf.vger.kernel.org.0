Return-Path: <bpf+bounces-11077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CECC7B2724
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 23:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F102E283791
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 21:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB4154AB;
	Thu, 28 Sep 2023 21:09:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617F8839
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EDBC433C9
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695935345;
	bh=7te1mmtwRAR7CnjCs+EpdXe/jmMMQFgw1qqKxIIPsH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tQiaTNqc8UJR/3iLTF+2e52J5yaQlugX9dYPBfhXXPbWQxi25MmCdMx7KF+e30vkP
	 YS4h5dG+L5T7DN/0q2Ils6qcU3UTuuvvBEZHrEm20IoG46Eo6KtYAk77eRgg8pS/NN
	 TeteGAvB/B3ggREcJXb5oAwesn4i2UeVRS4zWL0FG6FQ5fwXzCft3ERMfUa52mkBdh
	 OgK4HATQfZEDfZWoeLR+af26s6LzcgUbHUb3vNVdv7g2l+3stqlQWM+fHXynEKi3+z
	 9W9viwhlNIyNOWIhc9a4JMRPM7+lA7edwmDc2e9r7c6bL76jQXW4xv//G5DW9mTe64
	 316EZnJ0z+0tg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50317080342so22311910e87.2
        for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 14:09:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YzJqyGjq85maBYpApfOJ59qytDLsvr5cSBEtejdi7b6tBPC7p6d
	Bb3HSVz91PK+oy1mzTejRoNR3bE5MHQg4y1Y2JM=
X-Google-Smtp-Source: AGHT+IHxEtFCbxS9MI1VFWusXoUBlvfGE+D0KZwKEIE5zEdHhgaN5BXgPngRbRFOCYv1VllS5IeyhBSrtieUv01AUDc=
X-Received: by 2002:a19:4304:0:b0:503:7c0:ae96 with SMTP id
 q4-20020a194304000000b0050307c0ae96mr1876456lfa.20.1695935343374; Thu, 28 Sep
 2023 14:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928194818.261163-1-hbathini@linux.ibm.com> <20230928194818.261163-3-hbathini@linux.ibm.com>
In-Reply-To: <20230928194818.261163-3-hbathini@linux.ibm.com>
From: Song Liu <song@kernel.org>
Date: Thu, 28 Sep 2023 14:08:50 -0700
X-Gmail-Original-Message-ID: <CAPhsuW520Tw1eUBvAhSRrEJ5wy6x4zLjRZsNzr8Ca2U6a1_o4w@mail.gmail.com>
Message-ID: <CAPhsuW520Tw1eUBvAhSRrEJ5wy6x4zLjRZsNzr8Ca2U6a1_o4w@mail.gmail.com>
Subject: Re: [PATCH v5 2/5] powerpc/bpf: implement bpf_arch_text_copy
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 28, 2023 at 12:48=E2=80=AFPM Hari Bathini <hbathini@linux.ibm.c=
om> wrote:
>
> bpf_arch_text_copy is used to dump JITed binary to RX page, allowing
> multiple BPF programs to share the same page. Use the newly introduced
> patch_instructions() to implement it.
>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Acked-by: Song Liu <song@kernel.org>

