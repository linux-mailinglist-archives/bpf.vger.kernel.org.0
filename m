Return-Path: <bpf+bounces-32494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC990E289
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 07:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBA72847E9
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 05:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63D50280;
	Wed, 19 Jun 2024 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYR0WZJ/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA3A2594;
	Wed, 19 Jun 2024 05:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773455; cv=none; b=n4rQTpJ9Y0ArT5ORVWodT9InOCysV1mg65wzecDLgNY7A8843fzgVxtXd2shDMGKuuV7mX/xVGuSvgN0Uxnl82WfORZ1EFKHfH7Gq7tU7WPcZBGR9948e4EDH6RrH2dKH4+UPg6u3FUCOSj+IVMBEZtOen4BQv0oa4NVCVIHbEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773455; c=relaxed/simple;
	bh=5CfxokEeWJtPfBVMgE4eC6s41pql5hFCsRZZ3k8KbZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9P9GmOTz5ZpuDtTFD+1rLnO38sGEmgHlpPDZp2uDlgdrR2rBe7+BNOy3/qPmClA4xY8z4KcVOuX4lH9KUYd+IKSBzv6k76MbXSbFDjgIf8dn8mQui7KkX9grLLqbg2FRGniX5M1zh5RRxUrvX/j4uc4kh5g1JKtBk6Tnb97dlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYR0WZJ/; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so13830a12.3;
        Tue, 18 Jun 2024 22:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718773452; x=1719378252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEHIgrOq8no6wDTko1C5dWqv8WCV5OBAumspbIV7QW0=;
        b=MYR0WZJ//Man9igDYdF0Hh8x3ie2esDfjYw8fvW5iKliErWkV/tbNZvuTishDQwGEb
         qIbonk/NcUv0ZUPFRyRuAxb/vPMfAD5iDue9Iq4NtlJrAt8WnoPpQbsq4zVwTbK7iiim
         kA207dtV5NR8vtUh2VS91/qaOaiYuFshxYCRJWlHiYCP82SFkh6dST8tlwxcbk+BWvMX
         nrUNpdbU1Qact+fAF48eWfg6OC7dBlXH3DH4wl6kPJbfWTGyJT5z90ctqwGtVbF3ZOqy
         uzbZiC9mE5ZAzVMPivBrNaoZEejoVR1bBH8spQaXJC+MupzqsiJTrP8IqyT+paTYLYUa
         2oWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718773452; x=1719378252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEHIgrOq8no6wDTko1C5dWqv8WCV5OBAumspbIV7QW0=;
        b=ACgpTwMfOq7V6MrqkmCCZuNnJXRBFSn8iGBdLJkOn+NBA8gTwWkKzCfqgKF/Nip33Y
         1qgKsrLaDS0yz/oCHyaDc2k6OGkjk0LBsih11Nk9j/qimutQ7R7xbhKl3HrQJjwkrq0j
         usaBm3I7AiBonJxbZtA6DD9FTLaBlgeWB3ERRjW47D6RiO0r/XH4nk29eg5DIWwldKu5
         YtkTE0o14pBmjGRd9yfF4t8Xgd5ckwC/+kKXZ548yDPQ1PThCTonv5ZXyCbglQQqU9Zn
         WbjIXuXPorxnXCmop9W++7thuUPDYfJNkhJB5CuxfDkugJOGb4WMUYXjfozniSJKSzm7
         +JAg==
X-Forwarded-Encrypted: i=1; AJvYcCXXoW/q0Y4O9Jumydc96/shiWtTUQYC1GvsTCjCci5c9aD4Q/J7akCQwcngHIp0574pyHLnqTvhz8USe/7zFXICOhpqz3KbQKWKhMQS6X/xxr6ZSL28tGa3qaZNcDtRzNwa
X-Gm-Message-State: AOJu0YxImwcX/hdUXmLW3u8wCYfbzZKLhkwoke39ckqglcrFRtavkmqP
	mKfUOLo+1Ksh18oKR6L4KB6V+Fh2rFsWLrntTtncxx/Obv/BxaDLhCePXixi001w0tusn3zTs8x
	K7MewFGBUYmsdhLfdsRApHImMbfM=
X-Google-Smtp-Source: AGHT+IEsaRPD8EDmRkrTZRoQxwonw9c3Ui37+jDanKgowu4Rp/RacRiNcoqaUkRwTOAKSYw+DGK+lw8EBcIMeP8Al2g=
X-Received: by 2002:a05:6402:1208:b0:57c:6188:875a with SMTP id
 4fb4d7f45d1cf-57d07ed3adcmr720325a12.26.1718773452328; Tue, 18 Jun 2024
 22:04:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616002958.2095829-1-dolinux.peng@gmail.com> <f4f51280bd0e83e04e7765e90081658e3ae975fd.camel@gmail.com>
In-Reply-To: <f4f51280bd0e83e04e7765e90081658e3ae975fd.camel@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Wed, 19 Jun 2024 13:03:56 +0800
Message-ID: <CAErzpmvLeSkL3yTPoZyXiFVGRVFPoAa_4k=0Vtp6eu_Zu3c5Aw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: checking the btf_type kind when fixing variable offsets
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, song@kernel.org, andrii@kernel.org, 
	haoluo@google.com, yonghong.song@linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 2:12=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2024-06-15 at 17:29 -0700, Donglin Peng wrote:
> > I encountered an issue when building the test_progs using the repositor=
y[1]:
> >
> > $ clang --version
> > Ubuntu clang version 17.0.6 (++20231208085846+6009708b4367-1~exp1~20231=
208085949.74)
> > Target: x86_64-pc-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> >
> > $ pwd
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/
> >
> > $ make test_progs V=3D1
> > ...
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/tools/sbin=
/bpftool
> > gen object
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_d=
efrag.bpf.linked2.o
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_d=
efrag.bpf.linked1.o
> > libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in sectio=
n
> > '.ksyms'
> > Error: failed to link
> > '/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_=
defrag.bpf.linked1.o':
> > No such file or directory (2)
> > make: *** [Makefile:656:
> > /work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_d=
efrag.skel.h]
> > Error 254
> >
> > After investigation, I found that the btf_types in the '.ksyms' section=
 have a kind of
> > BTF_KIND_FUNC instead of BTF_KIND_VAR:
> >
> > $ bpftool btf dump file ./ip_check_defrag.bpf.linked1.o
> > ...
> > [2] DATASEC '.ksyms' size=3D0 vlen=3D2
> >         type_id=3D16 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_from_skb')
> >         type_id=3D17 offset=3D0 size=3D0 (FUNC 'bpf_dynptr_slice')
> > ...
> > [16] FUNC 'bpf_dynptr_from_skb' type_id=3D82 linkage=3Dextern
> > [17] FUNC 'bpf_dynptr_slice' type_id=3D85 linkage=3Dextern
> > ...
> >
> > To fix this, we can a add check for the kind.
> >
> > [1] https://github.com/eddyz87/bpf/tree/binsort-btf-dedup
> > Link: https://lore.kernel.org/all/4f551dc5fc792936ca364ce8324c0adea3816=
2f1.camel@gmail.com/
> >
> > Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext sup=
port")
> > Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
> > ---
>
> Good catch, thank you for narrowing this down.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks, I will update in v2.

>
> (Although, I agree with notes from Alan, having a comment would be good).

