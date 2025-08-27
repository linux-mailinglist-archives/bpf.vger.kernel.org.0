Return-Path: <bpf+bounces-66651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 461E3B3810B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E5D20015A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C48350835;
	Wed, 27 Aug 2025 11:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="OSrxPNgG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0E34A33F
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294068; cv=none; b=Hkxfto+s9ZU+WcoA/3QLgpKbkMD/AT59crcDxVrfHo03Hszf6v6FCcgGM+rgaWE0PUykKvHvqzC2e7v5GLAHKW1FZ+MoG/It9xxKrG5tyWwhs1ZSDUYE3P8TWaxPU8WKj1vStUMsLZprsZsPP61A6fHvXNBxxCEQxcFS9fQKX4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294068; c=relaxed/simple;
	bh=PEuf/FgXr765VP9UAfvrHJzwAyD+rhSs/Wdo94CtjkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfbJeCqjBxFCpe5M3Y2TUZTsyMSZ3rCdjDw3izvo/ee3CCteGMynqrTMnxtqqKxHtA1NnsSErKmONPpWhDC9Kt2m68ocLqwdwp10EWJHXuaGnbw0p4pnyTBiVDINkPitNIJdCf+k+Tfl4nIgsC8KMhT5zGK4EmtblUzg6TfSO64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=OSrxPNgG; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5801161a12.3
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 04:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1756294066; x=1756898866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/jwl81pdw1HxKkspLwWnkr4Y7z1K3MHPBPRksjOD1I=;
        b=OSrxPNgGxg8l44X3ItDwAs+TY67c2ohn8Mbi/RQeI/end+03TLXnm6SFfjItTEl+FF
         0hpVv8R2KJn+jTNFOKqLDdbtapZdMavS90sXIRn6w1/9Aj5aP9qq8Pnt8k+vNrJOhJ6H
         QKLTcYBYfuoxqVAL/5UNuAymJNsRn+ZRWZTg33iHF8UJJeuIBGd+h46V815Q2g4M97mI
         WVuXZzowdEhGeX5xG+T0JgzmGl/bG1Xw4Eif1WYbRosASwgqoDmcdbbOFeBQUuv5y4Yw
         swkWOSiA/0DdvwKxUnM+AVXbbVwgWC1rhDhJ3E5+ZMiB7wUIHHTUfzZpdDZHbBNfKvfW
         o9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294066; x=1756898866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/jwl81pdw1HxKkspLwWnkr4Y7z1K3MHPBPRksjOD1I=;
        b=hixUnBhHkN8Xe7cDTY4JiwyH771lj04JHhk7y1E5bQ9zh37NlY1u007zFRIZCaTuOe
         0v0yj5YL1jcQwjSg2tMESfwq7wQlrUqGbvh1qD0XhW0RPZTTW+lcgnSznKn0pIpPorfM
         a+kREachq1fnXd4fwIjmkIO717XFqcJPzP1rAfjGHf/jM9jYZluGYurXl4RKDN0sKC+i
         imlH/9IHLq6R9lHAUJ9NZKOL428Jk8/kbq6oMGwxhn1KpANl/GC/jMYNE7g7pjq8NJ3I
         zUZ1JYKzI4n4dPNZnjFVW/yIUQSxBwDiUrPg817i4aE+wnQklfUi3kMJatBmRzXhTn+i
         8Tjw==
X-Forwarded-Encrypted: i=1; AJvYcCVWzY2mBRIieP2qAa7d6f7ruMU9H45Q/0G+LZM7vX5Z102uf2EbP9k4NqYWVn8H3oWF6p4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70tBwlV+DPYLL+2Irtx1i0WhaSJbI/aued63PXe66fFH2AzTM
	+adEiT0rgL9LbK5jUP5ppzCIQV+sLGL2VGL50f2tI5l0Txd2aF+WSNfD4bEhwiuWgilm0lxLmhZ
	gNWpsKUV1wSmHqZH08YJ9xcBvwN2FD/AwCvb4HQz6Ew==
X-Gm-Gg: ASbGncsQfU49FkMUFi2Nw5Q1vYhHWOJe4a0TSiOq5gN/HCa6oRPFiG8C8oYf1SAehbx
	4TAYZUYM4bjGYXAiIbkIRnCsWiTcbzwIaHPT0MEu1UUus8PD9w3rVRHi5gZgoa5S9HUNA+hu+cv
	Zs5M3XRCm1gtw/rUOnNYg1WENxMPhl8j730ODGvaQBDTk5kelEupjlWB7rQN3tjnU/81jIBl4rD
	SushRZzaW1cr3r+2x/8CfY=
X-Google-Smtp-Source: AGHT+IFzKBVLIyX32GRylpiH9ADpqFb0pk9OE/yfaJMr8XyWxnfkKtislE3eyuYu47aWVxFR3WGpR9F0jtF9zhU4jlA=
X-Received: by 2002:a17:902:c404:b0:246:464d:1194 with SMTP id
 d9443c01a7336-246464d13f7mr308106115ad.2.1756294066093; Wed, 27 Aug 2025
 04:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826131158.171530-1-matt@readmodwrite.com> <CAADnVQ+=bYcR6whXxEPst4a4n1eKeDXp4tO8Q2wEx_6GbwqMFg@mail.gmail.com>
In-Reply-To: <CAADnVQ+=bYcR6whXxEPst4a4n1eKeDXp4tO8Q2wEx_6GbwqMFg@mail.gmail.com>
From: Matt Fleming <matt@readmodwrite.com>
Date: Wed, 27 Aug 2025 12:27:34 +0100
X-Gm-Features: Ac12FXwG-oggcOGL4Q0g3dkKRhaG6nPFoY2p3ZGwYD8mjM7xk1b9ejCDM747Znc
Message-ID: <CAENh_SQo2-28P-QnN2Jga_dq_3qc451RS0Wc1UQuvxqvK+NM6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: Add LPM trie microbenchmarks
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 12:50=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 26, 2025 at 6:12=E2=80=AFAM Matt Fleming <matt@readmodwrite.c=
om> wrote:
> >
> > +static int baseline(__u32 index, __u32 *unused)
> > +{
> > +       struct trie_key key;
> > +       __s64 blackbox;
> > +
> > +       generate_key(&key);
> > +       /* Avoid compiler optimizing out the modulo */
> > +       barrier_var(blackbox);
> > +       blackbox =3D READ_ONCE(key.data);
>
> Overall looks good, but gcc-bpf found an actual issue.

Thanks. I'll submit a v5 with a fix shortly.

