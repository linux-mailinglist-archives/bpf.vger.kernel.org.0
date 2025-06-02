Return-Path: <bpf+bounces-59422-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB660ACA7F6
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 03:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7C217DF4D
	for <lists+bpf@lfdr.de>; Mon,  2 Jun 2025 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B93196C7C;
	Mon,  2 Jun 2025 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKHF0lhq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4313B293
	for <bpf@vger.kernel.org>; Mon,  2 Jun 2025 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748824719; cv=none; b=EfczhT0ZFTmjUrArrIaj9pGYhacP36QZGs3PUiYqQ80R9ZAYvL7uwTMXR8ShR43QQZnNjMw8+T4z9YRnJe9wzbTnfdrCCSaqaN5VagVKK4haQqPIM1U2imQDcG9uT5WNbPS/L1DRhhgw7S+aIlgK2w0LVeMsWJRBX9HVeRpuwW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748824719; c=relaxed/simple;
	bh=O+/21A8JyeMjEuqZAu9g8yf3TAJ0nv/BDNqPmPCzyzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NpTBBSBdKS5UnfzAdnlcs9sFR+hx70/cXwR6IrUjvM/j4RWkDsyXS3N+5Q00vuzrBkyarWve+spN7MILj7AMdt5ByHvCKcgw028GFlf78LBOLlkogv5U4rz0YmChRBiz4uB9GlRfbqd0bZha/cr2qipCBAofjKzNGTRSVGyrKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKHF0lhq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a361b8a66cso2248554f8f.2
        for <bpf@vger.kernel.org>; Sun, 01 Jun 2025 17:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748824716; x=1749429516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZxNaUCLCZ1mopTkgQMsN+NnIC0RsNPEikMx8quI1jQ4=;
        b=NKHF0lhqs+pupfkCjqzaqVuGwGJezd5d5FLcw/F2em103zZPif5IREY9m4XIac/mSD
         0LF6+IVBRiWbN3cLjkFgfhDwprSVPTLMzEj2ICJ7bRJ3y55I43mjAtgBUIweBaDbfwxA
         MJn8B/c4bBuoMxx3hD1Ju0BOIjnx6D8qzWvnCHvKWsWFoYdp7kEFrTwEPbys3dgo5v0v
         l066UI75yuYk+sg9koJcNdfDfx6SgRHaLr449kmse2UN0vTMLtJsXaRDI95xh2Hk7lLU
         C7wTsB/+AjLwTZ/++uiGPMqM7NAlAIjdBxrmayXEH7TqRMbd9TbnAU4nrDS4lmMCqruf
         PoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748824716; x=1749429516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZxNaUCLCZ1mopTkgQMsN+NnIC0RsNPEikMx8quI1jQ4=;
        b=HZ0unbAf7fwftRB7Ugi+TxLzZtxzVARNIRF9yAamaSVHrZggp6rStIZsyAioiSOWqp
         oHP02DKJ6AvEoKxtmv+KWZN+/uOuBrzl+Rc0kBOuiSKBClQQf9O1bOQVJYajkXbFqw7t
         MmV6280bqxQslvEZ6f+87OLA5ru5lej3uOV5rZxo2IZ5nbm6S/c4ucUJjG6y9/hfOxmB
         yOmb3V/Z843tSbpIFcquD9r++slNLJUSbzhwgiBzZUXFStS8Xi0N/jZt9UgGutCwa6B7
         a5aIaWXrj+qysPKD/dBAo3OcejrPp2G+CGR5BW/exDpBs5N+BvQzSjJ51ViXQLK7dmBC
         OpEw==
X-Gm-Message-State: AOJu0YwU1p19TudVPicE79EB4qSkfhet7eKeEYkpqCz20xXRWCtbK1Hg
	x7Iht0m1ZdusgqI6YGNdOIN3kVbJmAEu4MhQ+q7iNciEoq0/HkpkufaILkhrJqzPRO2GB5DGwm6
	O5q6N2/CVbOqtQFdK2yAjSJ9LHkG0NaMxbA==
X-Gm-Gg: ASbGnctQh9hirli/q17XmlfN8K10NVvAp46ZptTtTK47aiS+A5CrWhYAHD53J7lTEvG
	rNJJVgUEXfGI08giV46gpYMivVGTFzSdgfX7tFUJ2mr9yvGbgCZHtG6eWNXI4oGA35+nCBww0hc
	uV2aPErUiDDbwyia4/E/8R0gATmxSypAqxbbjVbLl6mjYbJvkY1q7K7OGkSHxjrA==
X-Google-Smtp-Source: AGHT+IE94Pmgx6DjPg45m6rqa7uTMv2GE1UxEauWBq2yGPf+KOuh9Fadb6cFBMWTFD17ntYGxMrMnB/wEPAF9b474Y4=
X-Received: by 2002:a05:6000:40e1:b0:3a4:ec02:739f with SMTP id
 ffacd0b85a97d-3a4fe3a7fd4mr4977169f8f.53.1748824715678; Sun, 01 Jun 2025
 17:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602003627.1921138-1-yonghong.song@linux.dev>
In-Reply-To: <20250602003627.1921138-1-yonghong.song@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 1 Jun 2025 17:38:24 -0700
X-Gm-Features: AX0GCFvnMP9of5kkNSNA6pc4-WGVe78xKO1NEmiUPQ7V8XHC6A21ahRItuvbObs
Message-ID: <CAADnVQ+neTJWCZ2rmEUVYYvtGyjHgpoN-0W6pYec+73GRqDdfA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix a testmod compilation failure
 due to missing const modifier
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 1, 2025 at 5:36=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
> Commit 97d06802d10a ("sysfs: constify bin_attribute argument of bin_attri=
bute::read/write()")
> added constant modifier to 'struct bin_attribute *' for read/write
> func pointer members. This caused compilation failure with clang20:
>
>    bpf_testmod.c:494:10: error: incompatible function pointer types initi=
alizing
>   'ssize_t (*)(struct file *, struct kobject *, const struct bin_attribut=
e *, char *, loff_t, size_t)'
>   (aka 'long (*)(struct file *, struct kobject *, const struct bin_attrib=
ute *,
>                  char *, long long, unsigned long)')
>   with an expression of type 'ssize_t (struct file *, struct kobject *, s=
truct bin_attribute *,
>                                        char *, loff_t, size_t)'
>   (aka 'long (struct file *, struct kobject *, struct bin_attribute *, ch=
ar *, long long, unsigned long)')
>   [-Wincompatible-function-pointer-types]
>   494 |         .read =3D bpf_testmod_test_read,
>       |                 ^~~~~~~~~~~~~~~~~~~~~
>   ...
>
> The same compilation error for functions bpf_testmod_test_write() and bpf=
_testmod_uprobe_write().
>
> Fix the build failure by adding proper 'const' modifier.
>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

I already applied similar patch to bpf tree couple hours ago.

