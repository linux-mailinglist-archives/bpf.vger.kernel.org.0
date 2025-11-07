Return-Path: <bpf+bounces-73986-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95A2C41A15
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 21:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA953BBDF5
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1107830E0F7;
	Fri,  7 Nov 2025 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEoUpn5K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA4B24DD1F
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548563; cv=none; b=VWtLKWdVTwf62Vpqe5kBN9h1+lW3F5+1TGKpsn5QMKLlpmq1nhaYv1TbfAuz5wlcuRQa0RRwF/1IYbBv68GEUMA3xzYmYvtM6jdmgV431TTn7QplwFyFnwT9LHfnnixVroxFpIKjdwF07F8vl7v7og117e3tF0aKyrvNYKVOC4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548563; c=relaxed/simple;
	bh=yUvoNb9/JSZ/ulLwpufw/LR6QfXxElq0D8+kJC7SL+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t1jHgridtDgxDPYDdLHSKHwGQpI3kmztSTYQ9O6MbdPqHpu9KY7hPNwykm/4JUqD9jRHQ8f/qw3Vg7LeO+zaXKHQ57CaB1+M7/03F1PvrWTmIWLWft6Hip5c2HyGXMtqrdutIh/+ZyuIcjdCwCpKzUjlzCEDgfK1q7qemtdeNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEoUpn5K; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-656bb297e31so283707eaf.0
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 12:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762548561; x=1763153361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yUvoNb9/JSZ/ulLwpufw/LR6QfXxElq0D8+kJC7SL+U=;
        b=mEoUpn5K47aVCEozrTLEkXKtPMRTGZmD8wQm4brADpJwtdrNR4iqaWqv/OngMU++d2
         MKy+PZGipzrXkpgbqUlmeSL3QiguiPVB+CkIVrWLKDxxydMtkstKbP69BTF++mJ++JBU
         Bu3sYKfyt4Dl45oqZNkpAdwVcwUZXrCx0pMwhEN5BXVkN8LdFlY6w1v+ujGo4Da+xckS
         OCNf2S1eI2Tt4JSRJbPE6KikcapH8V5mXyb/RqqioNDySnwTcURSe3i3MuYuh3gWWJwa
         BEiYuL8l6/+tV9jOmBjVslFjKt0yrqUVmwepZySq6ggOMpWhr4txfsVJECZPq2CwZzKZ
         vDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548561; x=1763153361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yUvoNb9/JSZ/ulLwpufw/LR6QfXxElq0D8+kJC7SL+U=;
        b=CkhdQX92/pHXwCVG7OQV3YbtuaiojeK127Ri9sK+axu6OqcrX4ADQA0f2neQDS+i40
         O1dKf3zR8fpTo77YMYPF5HpjyKpEQIEDfB0hYsrmthcsmWizE5i/SbGG9S+BjSu3L524
         4ic+6UZj7hr7G7IrxZQfRHprqruALy4pFvjpITXu1mV5w2XM5i2x92KrFlAIYIIH1+CX
         20iJEt/crnKGgFgFg/lL0f/U2hGKVcbyuZp5+0IMcds/6m0DpwVSZJwtcJNmp15Ut7g2
         oKh8PIYnXYQocTcvU1Xlp9sdw7lcpy+HYvBZc8kJVeBCz6MtsgSVySIkaJSFfFi7ghna
         eS4w==
X-Forwarded-Encrypted: i=1; AJvYcCWksXcLgJbWf+up7jS8Nwccoy0e0afhiBMtvyH82shHo8lNNaGfZoUe4HeI49V4bb57RjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBEFgd8OT8d5sCNDxHsYWfqZEOqKhzHcXxIYdvEFHF+TgnnlV
	adqKVMJFsAbmUUA7MuWXUbd4vzzvN5bIw2cZ8/j6UxfUCx1CN6YUAEXis0xgX7EsLezP8nexIND
	vqzwlSJO/9UE3z5gbe0dit0eXxKHWLbM=
X-Gm-Gg: ASbGncu6Lw3EwiAopECz56pu7bwVFYPzmDnD5YYlRQA6dHrfuKkrphSO/3g4d5DqDc1
	xzdUeCU7B656d+c0EO5LCYptcUfpm9IpjnetO/WnW2RhJcqju/xjykiY+9+264LhG8pY57whImq
	UDNZfcBmSbJ7YabaUVKLGDemzS/M4BT7fKLhgUods+jziHexuZdxwMP00qFLTEWyoIpcow9qAP6
	wM0VvBVUrzwluCzutnBIVscGM/dLsUUYsICJtVh6M5iRq3NNJ9QWgu5TBaLayEpqYN2eQJ1bGS3
	Bj8MhNIujkULR00Aheo=
X-Google-Smtp-Source: AGHT+IF7ciPYn8W/Wi/+7KxQeCmeVeuGWuMA1KkK37kM62RM/2HZfrlpGM0QRm+kdgyzz62gp5frZidbTYSY0zw89JE=
X-Received: by 2002:a05:6808:15a2:b0:44f:6def:3f3c with SMTP id
 5614622812f47-4502a3577a2mr400172b6e.41.1762548561145; Fri, 07 Nov 2025
 12:49:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107153408.159342-1-paulhoussel2@gmail.com> <4c33ab7a31ccbc1235bd183a5e4bfa4f94896c63.camel@gmail.com>
In-Reply-To: <4c33ab7a31ccbc1235bd183a5e4bfa4f94896c63.camel@gmail.com>
From: polo <paulhoussel2@gmail.com>
Date: Fri, 7 Nov 2025 21:49:09 +0100
X-Gm-Features: AWmQ_bn1aV14PXjx4pA4F1J2U2U6JQJreP3ssjQ3kHUWySsIt2TPmpiIcKgC14k
Message-ID: <CA+aJb_27fAdAXNwkYCxTKaWCCOdiWmJc7a_qhpmykXqxMjJYMA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix BTF dedup to support recursive typedef definitions
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Paul Houssel <paul.houssel@orange.com>, 
	Martin Horth <martin.horth@telecom-sudparis.eu>, 
	Ouail Derghal <ouail.derghal@imt-atlantique.fr>, 
	Guilhem Jazeron <guilhem.jazeron@inria.fr>, Ludovic Paillat <ludovic.paillat@inria.fr>, 
	Robin Theveniaut <robin.theveniaut@irit.fr>, "Tristan d'Audibert" <tristan.daudibert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eduard,

On Fri, 7 Nov 2025 at 20:45, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Fri, 2025-11-07 at 16:34 +0100, paulhoussel2@gmail.com wrote:
> > From: Paul Houssel <paul.houssel@orange.com>
> >
> > Handle recursive typedefs in BTF deduplication
> >
> > Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> > Podman) due to recursive type definitions that create reference loops
> > not representable in C. These recursive typedefs trigger a failure in
> > the BTF deduplication algorithm.
> >
> > This patch extends btf_dedup_ref_type() to properly handle potential
> > recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> > handled for BTF_KIND_STRUCT. This allows pahole to successfully
> > generate BTF for Go binaries using recursive types without impacting
> > existing C-based workflows.
> >
> > Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> > Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> > Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> > Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> > Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> > Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> > Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> > Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> > Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> > Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> > Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
> > Signed-off-by: Paul Houssel <paul.houssel@orange.com>
> >
> > ---
> > The issue was originally observed when attempting to encode BTF for
> > Kubernetes binaries (kubectl, kubeadm):
> >
> > $ git clone --depth 1 https://github.com/kubernetes/kubernetes
> > $ cd ./kubernetes
> > $ make kubeadm DBG=3D1
> > $ pahole --btf_encode_detached=3Dkubeadm.btf _output/bin/kubeadm
> > btf_encoder__encode: btf__dedup failed!
> > Failed to encode BTF
>
> Hi Paul,
>
> Could you please provide some details on why would you like to use BTF
> for golang programs?

We would like to use BTF for Golang programs in order to trace
compiled Go user-space applications using eBPF uprobe programs.
Tetragon [1] implements the use of the BTF file to resolve paths to
attributes in hook parameters, and therefore if we can obtain the BTF
for Go programs, we will be able to start reading any attributes.
Recently, this feature has been extended to support uprobes [2].

[1] https://tetragon.io/docs/concepts/tracing-policy/hooks/#attribute-resol=
ution
[2] https://github.com/cilium/tetragon/pull/4286#pullrequestreview-34277256=
98

> Also, is this the only scenario when golang
> generated DWARF has loops not possible in C code?

This is the only scenario we=E2=80=99ve identified where Golang DWARF conta=
ins
loops, which are not possible in C. We=E2=80=99re not aware of any other
Go-specific characteristics that could cause additional DWARF loops.
We tested BTF generation on a set of Go projects that are quite large
and representative of the diversity of Go programs, and we only
observed loops for this specific typedef usage.

Paul Houssel

