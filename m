Return-Path: <bpf+bounces-47702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644579FEA4F
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 20:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 321731883643
	for <lists+bpf@lfdr.de>; Mon, 30 Dec 2024 19:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0370198845;
	Mon, 30 Dec 2024 19:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmN71cQy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E68EAD0;
	Mon, 30 Dec 2024 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735586651; cv=none; b=iA1MJwQNBITc3FgH2MoQkS39HFX3YbQa6P2QhI5rLD66q1UyJlZ19w/m2B7U0i9bOlvObwNHXPK3CoXPoAq2mKzuOaKCvg9kqzpPUHCCH90EpP1MK5l5HdEzfeyNjldMX8ncVN878FB1tgKDM3Xpkm6TrOMojgMnCvH78KUWglM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735586651; c=relaxed/simple;
	bh=ni/QKxzeY0LDICUiVgjqH6QkZf8q5iTZ7crbkM6DQoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPGM0iwdkvW5VLYxMA/1LMUwUzZyZY467/VoLsvAdhJpyyhfL2YisIiTvsha+buWiTN6SFKHZ6Jb95o6NZwEHpYz7iIVcW4VApo1Qdk+4wIylnni+UXbGy3squ6UK7hoO+KN2XbzRN2MBNtlD1NWwvxefSGAEDROVhaTciCK70I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmN71cQy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3863703258fso6175970f8f.1;
        Mon, 30 Dec 2024 11:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735586648; x=1736191448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciNJcV3G83R8GahauylaxlmlO9BLBj94cxwbim2GMw4=;
        b=LmN71cQyCEqphT3rREAD50oBJdmU4pmlVZm//glx21UKbUkIvWrLnCVEge/h5ZmjdW
         B7BoNActx5NlfwpBt5Vaj69XWtpKn3sW3F1RmqDz4mrmnOF/LIV6+xskwCGj3/hJVUGF
         kvxPnTptqwaAUmaPtNS9MQ+1XsIKoI7n5do0NEV6DOhLrXNerhhpF8sVUrVTT+rO82CQ
         Fmojv//3m1d/NrOChDZYDj0rASPiJpRQmSrI6V6DC6HZeQBD3psO+QBItdFWvdfbcJ+O
         cX9nF4hwZ3HH8Oz03dp3hJ6OugrmZyrjGtyqOrkIGPg3RDRMtuaav7ZVrUv65h/Sy6LI
         XWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735586648; x=1736191448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ciNJcV3G83R8GahauylaxlmlO9BLBj94cxwbim2GMw4=;
        b=i/2OChZogOaEOjylM3HZs3g7UN5V6l2EmO+FYgWfBRUX4REuQKUTHuMXaR5D635hiL
         pVOSotm9bs61TqEhxgQOF8TY+jp39U2Ium/dYHQ9RRhDpmhIwMRVQMiPJlJWDuNjVP8V
         XbX2y8FF8dS+68RBRk5skRpCol2/+WgWZkLkLubsWqOA+9B45N0bscSbXTmh99Bu+nPz
         1w5SVx541BhEuowavVQ6qeqdXvI+NXjQB+HrEA+y03ad5r33mneV6sCqnu7tAv8AU1kb
         oQk/bA7vaxqGVSyj6/JuTtW8KRnUOp68cu+oZfrFPnsEuOLJkgPEPpj2d+071+8hg4br
         0Lbw==
X-Forwarded-Encrypted: i=1; AJvYcCUiSA99tvyh9STKOh5p45q1HRmNK29YO282MOHBU8oQTyKKrLc7v9HXceUsP07wa/5bzoctPwru0ghSo+AQ@vger.kernel.org, AJvYcCVJGeO7WLBiUVdsHydc8BvAvqqXWF370QeuPILF4wspg1a5qbiFcIh1mOyoYVHmf6fbk8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQzkgcP1k8ACBIkn1LF2s8GWH2p/LRvw5HdN69ezHVnKDsjCc
	eZ1pMP2zjEgVEAmf1fZuu1rxuKY/7mraVUjvyBSFYUb/BT9TqNEJV5gpqQL4gplWIXaGFDICPsn
	IjAQZy7jBv56cNPp1JScwiIt8UY0=
X-Gm-Gg: ASbGncvYtfi9AB5vrUAY3nNS3alCAi1SV9IBYa2KPc+xuDKNdmdYy8tdNQZ+mw9G0Q4
	9aso8cvh97VKq5ke3XvISegu5tvycUdeDNVRctXJNkstKS2ujdSVBAO9GiL1k0btb85niCw==
X-Google-Smtp-Source: AGHT+IEdaXFviQoZgEZyU7FadaBKrD3FIgnrt8BhINnusVocvYRO8/BO4gb6KTGguBPaO0Q/ROVXjgScrIdTJdPLyoQ=
X-Received: by 2002:a05:6000:1f86:b0:386:32ca:7b5e with SMTP id
 ffacd0b85a97d-38a22a1aa50mr28206157f8f.16.1735586647961; Mon, 30 Dec 2024
 11:24:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6bf30e1a22d867af9145aa5e94c3fd9281a1c98d.1735508627.git.dxu@dxuuu.xyz>
In-Reply-To: <6bf30e1a22d867af9145aa5e94c3fd9281a1c98d.1735508627.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 30 Dec 2024 11:23:57 -0800
Message-ID: <CAADnVQLo0z9OOr6QOwU_+2480DaK8HT+Nu=OcMDG-PDptk44Zg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Set MFD_NOEXEC_SEAL when creating memfd
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2024 at 1:44=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Since 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC"), the
> kernel has started printing a warning if neither MFD_NOEXEC_SEAL nor
> MFD_EXEC is set in memfd_create().

Except that the code is different now:

        if (!(*flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
                if (sysctl >=3D MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
                        *flags |=3D MFD_NOEXEC_SEAL;
                else
                        *flags |=3D MFD_EXEC;
        }

        if (!(*flags & MFD_NOEXEC_SEAL) && sysctl >=3D
MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
                pr_err_ratelimited(
                        "%s[%d]: memfd_create() requires
MFD_NOEXEC_SEAL with vm.memfd_noexec=3D%d\n",
                        current->comm, task_pid_nr(current), sysctl);
                return -EACCES;
        }

Since libbpf doesn't specify either the EXEC or NOEXEC will be
applied automatically depending on the value of sysctl vm.memfd_noexec.
And it will warn only if EXEC flag is used with sysctl =3D=3D 2.

So the patch helps libbpf avoid the warn on somewhat old kernels,
but not strictly necessary on the new kernels.

This patch is relevant too:
commit 202e14222fad ("memfd: do not -EACCES old memfd_create() users
with vm.memfd_noexec=3D2")
It has Fixes tag and it should have been backported
to the "somewhat old kernels".

So if the kernel backport process was perfect there would be no kernels
at all where current libbbpf code would cause a warn.

Pls add these details to the commit log and respin.
bpf-next is fine. This isn't really a must-have fix for libbpf,
more nice-to-have behavior.

