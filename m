Return-Path: <bpf+bounces-41503-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34C997938
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2024 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FFEBB22B69
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 23:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6662B1E47BE;
	Wed,  9 Oct 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNa8dXpg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0C1E32A1
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 23:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728517161; cv=none; b=NwYYQXa2cEt4456yLlwbGer93slcxBRWiKrAPTx8b54Mean1dUrORTMn5QCWDmhWnbesoc15AblnPJ7mBItq5lGod42gsl4arefZdL0h27shTXh6xbsC5imUZb0SgQrIi8Gsft40CttcMINRJfx1dpVO+jeFTVWyG6yIPUAjGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728517161; c=relaxed/simple;
	bh=rPSIuBkP0hwZneR4jinHF1K5o5AEGyUe2vsPnmBwz2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XJxIC+NafkZCZvsJxV/i+y8t6rE31zh64ihYk9TYfo4R63G2aMTX6OQfMJ38WNmFtBtk7x2j/l3/qbL7Z32ZVWoi8FvZ8sbqkM5kWlHkzqlpOdqOxcxa0tRObNZm8PgemYXGbXmmUk2YATn8Klq5l3cwQ9G96wIp4jFNeCkK5Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNa8dXpg; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-37d4ba20075so11807f8f.0
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2024 16:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728517158; x=1729121958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqQBuOt638S5sT3qYpZkqfpgPhuXThcm7MAtkSqwD18=;
        b=QNa8dXpgF4mx/yMBoCBTg3bD3FNxGKWUZ+GJfGOJG60QE4mRD3My0KqUYu5aq0dR8E
         rMK/lUZdUt/9Bgd5bogaMZWQj+ZSKDIwEg46E3gaCjgTZ3btEV8RycsPnRqZIzx0ZZaG
         XIP5n2+huVD2P6cx5/Gts5+mRio0BG3N1zkGSLR1ny2gRQwD2Bke/xfqM/68SHH64BmV
         sz8BwS3gky5O5IQ2bf9rqZm0wvpfMthw1qhPqsRrCg9DSnhjMZrADGbSHUdfaC192RJ7
         GRePWOc6K7WRXs2WyInz0NV1cVvbD5BEUgFruMGk5IVtv61f6UO9JJWhN5lztph7/juU
         RKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728517158; x=1729121958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqQBuOt638S5sT3qYpZkqfpgPhuXThcm7MAtkSqwD18=;
        b=TvSEmmUc7Rol7cE3zTy2ZA1llf3RmswEWsedRADapniKcTemzXguA1khtPBdCqursJ
         uhBo37cMAuNlO+ZLu7tTQSiQ8Ym2K5i4hiwWh+2ZgTryAuuzq8QaGd0EXjZcpiTi6wKC
         Tg1SdYz7CidnV2IdPDAkK0z3YJThLCxTAG8Oq0d7qIKA1y4FrbZ/xwII/CwmpFzrtIL1
         JGBR4gy9SZV1U8QHMQyB4vaxOn0xVgEeExV8Ji7crUHOVOhxCZhPh4cqAtmDTPF3s9GI
         Vf2isPhnSx7atyo+gvPo2kH7GnG6O0APbTj8lmxhewTBl3FhkjskZ/95tLomADQ+HBCr
         YlAw==
X-Forwarded-Encrypted: i=1; AJvYcCV3d4+OXBnsnyg/nriCvBVUaansFdpw1eV4H9+XvmNYBwsl3q2TtoQvvuolWSViEc0JVNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHjL7NPp2ZHhaUOICGqVJ5TlOUdUGFAQUyigA9d6cKvHth4GSp
	QTUPM8c3zC6R1ry2gNWYu8zTfjEPXlTH7FwYuBb38sf0PWBySrG5ebzteYEFmz5pHDkDamTZCuc
	QePOwsNyHEKm2Q0eZkW9EkGqSuuI=
X-Google-Smtp-Source: AGHT+IGNWrC6UWbuT4f1g9W3iEepAQshk/SOuGV5vq5kXAGP4iig8BkRMWbdTXfCmD/u+51ZKBgCA3UBeeEIz+3PDHI=
X-Received: by 2002:adf:fb87:0:b0:37c:d11f:c591 with SMTP id
 ffacd0b85a97d-37d3a9d90d5mr2659080f8f.17.1728517157589; Wed, 09 Oct 2024
 16:39:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
 <20241008091718.3797027-6-houtao@huaweicloud.com> <CAEf4BzZ2J+Kd3wHNUM92ro1ikD3kqMF9zXEMPbG7u=GAVev3Xw@mail.gmail.com>
 <bcb4adcf-0e02-2543-6cb4-ac237b11a061@huaweicloud.com> <CALOAHbA+k9mgGfc76vuWAEAdCF4mhMFJ9qrt1N5ECiQiWQzFqA@mail.gmail.com>
In-Reply-To: <CALOAHbA+k9mgGfc76vuWAEAdCF4mhMFJ9qrt1N5ECiQiWQzFqA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 9 Oct 2024 16:39:06 -0700
Message-ID: <CAADnVQJdrochMe+bwi4gr-_Cj6WFcugx2OKzWnhDU2RXKLKfvw@mail.gmail.com>
Subject: Re: [PATCH bpf 5/7] bpf: Change the type of unsafe_ptr in bpf_iter_bits_new()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 4:40=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, Oct 9, 2024 at 10:45=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> >
> >
> > On 10/9/2024 2:30 AM, Andrii Nakryiko wrote:
> > > On Tue, Oct 8, 2024 at 2:05=E2=80=AFAM Hou Tao <houtao@huaweicloud.co=
m> wrote:
> > >> From: Hou Tao <houtao1@huawei.com>
> > >>
> > >> Under 32-bits host (e.g, arm32) , when a bpf program passes an u64 t=
o
> > >> bpf_iter_bits_new(), bpf_iter_bits_new() will use bits_copy to save =
the
> > >> content of the u64, but the size of bits_copy is only 4-bytes, and t=
here
> > >> will be stack corruption.
> > >>
> > >> Fix it by change the type of unsafe_ptr from u64 * to unsigned long =
*.
> > >>
> > > This will be confusing as BPF-side long is always 64-bit. So why not
> > > instead make sure it's u64 throughout (i.e., bits_copy is u64
> > > explicitly), even on 32-bit architectures?
> >
> > Just learn about the size of BPF-side long is always 64-bits. I had
> > considered to change bits_copy to u64. The main obstacle is that the
> > pointer type of find_next_bit is unsigned long *, if it is used on an
> > u64 under big-endian host, it may return invalid result.
>
> IIUC, BPF  targets only 64-bit systems?

64-bit bpf programs run just fine on 32-bit systems.

