Return-Path: <bpf+bounces-71246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A97B1BEB412
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 20:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76C2A4E0F70
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 18:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F7330307;
	Fri, 17 Oct 2025 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLrmXQIc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A18231842
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760726477; cv=none; b=evaNK0TTYGB3TXzEjcp53irM2uSUeT3YHIQCSY6tHxb/K8lJBwr4mIAJc/qK3wemxVKpMB3JZXGjVzgJlUrksMzYbriXU6N2mH+KLggQV7tvU+W6wQTuWYetY8lIjqpgG/1QqubFu4XoZEIodWabV8oLT3Qwker8YCwk9S878Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760726477; c=relaxed/simple;
	bh=CyoZiXgpi+hizfho/pveREBzIUqtvQ1VAEpUZo7NTGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeQfjL7drYhQsp4yaPR6el7JQHzLNKt97PrO1ckoQ3kBlF0zTpV+59dpmROe8K/B/SxqDW9NZ0NYexdIICPIyPDcXbuXLEuzT8RKid/Iyx11E7X9zo5OAQdAMWvvw56QW2qQjrfcbQkFgYSSG+BuyfAmECndxOWaWOrUVijElBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLrmXQIc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4711810948aso12639995e9.2
        for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760726474; x=1761331274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trptsjPmnWAoXN3wGZ3KQTDdqsqPh591MWVvtnuVBws=;
        b=XLrmXQIce5Brv2q9PzMPCYVp9wYW+/FO405lztwHZJlwUdchrk9cA98QnhI2yR5xId
         uG0Fzna0DcsrpTTEFW4Sif9X0q/6Eaf04umwqXH+WSqVn/fdcrr1fMB+kGtbTi81cKmS
         DTIxkbKfRgoLMDcfWagqf1I9fDH7/gaoqTP2F3Qby4tWUlS3P0sWNOMkmqoJe+f95N+F
         CxfcBrsOcvDV2fx/pqSbL/fGZ4Q5l6qZiCqI5Z62sEm3tx/c/khcKPA+qmeCDXIvpRq1
         kStig7PrYxGPxCTnkk2FZ0sJ315JJJX0ucY3E2eYgU/qmw83a1es3BbMaZrcUk+E8bDP
         bORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760726474; x=1761331274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=trptsjPmnWAoXN3wGZ3KQTDdqsqPh591MWVvtnuVBws=;
        b=QbwH1G/ofdj093lbbMye+Lg0yHgjoo9lghK8vgtYK5i+BSZEly1GW32Z5MdH1hvGIY
         uezIi7FAPSOEnKvxzknULavzrCSLCjHHBY3MdOgD/uOqopMvylkeBNRae0I6wCqt9kX9
         NJTRzBEHT2hU6HTt3Mxu6yIAZPKaPsLCRixX+XtvbJlfYjCQ4y8/IHSBjDWsgrvOFw+A
         0ry3EUZvV1eT9PpTXCe8F0UFwRYso01scif/lDmSErARGOkteuLvCC2Z43Sp+FaQm6J6
         BBCmC6hbsD3wkYnhAWsQ1QpfMOH1nbS8feEAE5Y5tOoo0HuzZHzdWp/wAhGWGwy8S1QY
         b2Xw==
X-Gm-Message-State: AOJu0Yy1QJEFQ99PbZPdn3AqVDOqcLOgMdOOoCu3tKt5DOiMaVDC/AO+
	DeOO2YXouw/sO0xsBU32HaortSL3AQ4G79+l+ymwIIfgNu0V74N+PoPGu1UcLb3Mb+IEh+n5+lB
	ZrQozj2Nu+AifVjFpKuiO7G9PppIRo0U=
X-Gm-Gg: ASbGncuBpj1hyP+PGYB7Z+NeFT1NwWO6D/dCwJBo5DtaA6nmLGWm05hXw9kzgqkSk2Q
	pasSr/06kIeKkJH5RBlMe6n/b37YkNba5GaYMzC1mwEkvD3SKOU74LA0gdramlhQvlG/lMWMz9B
	gdJkmcwKv9A1ex7NBUGeF8QoMgqwvu7fT+KHZHiCr6AEC4JM3MTTDx4KIeCpPxwfiQkoeC40FaI
	x7zCSR0SvS4f/k8swyWCLZ2NJRK7yR2kfLJ0n1ZNWttb6RJUPmD1Mmup29XutK3byM8+H9IT0K+
	wpGZZQUmEvPj4wUgz2uiCsJNLFUV
X-Google-Smtp-Source: AGHT+IFrij05s0a0oKSWIhN4gXPSIx9zBHeGjE3tz6EC4/gi4bubAgaJ791kf4+UC3aEyXwq0QCXp3L10MrAlMFaarM=
X-Received: by 2002:a05:600c:3492:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-4711791cadfmr48775435e9.32.1760726473575; Fri, 17 Oct 2025
 11:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141727.51355-1-puranjay@kernel.org>
In-Reply-To: <20251017141727.51355-1-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Oct 2025 11:41:02 -0700
X-Gm-Features: AS18NWCwIKARadc4i30zeyZp4VgwQCj6zVoSVP7syeRcL-T2QAD5mwX2nsz6HXU
Message-ID: <CAADnVQLp2w-C+mV+x=A_hxhoNHUk0k5n0gGGFULT_9WiVoABtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix list_del() in arena list
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 7:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> The __list_del fuction doesn't set the previous node's next pointer to
> the next node of the node to be deleted. It just updates the local variab=
le
> and not the actual pointer in the previous node.
>
> The test was passing up till now because the bpf code is doing bpf_free()
> after list_del and therfore reading head->first from the userspace will
> read all zeroes. But after arena_list_del() is finished, head->first shou=
ld
> point to NULL;
>
> If you remove the bpf_free() call in arena_list_del(), the test will star=
t
> crashing because now the userpsace will read 0x100 (LIST_POISON1) in
> head->first and segfault.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  tools/testing/selftests/bpf/bpf_arena_list.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpf_arena_list.h b/tools/testing=
/selftests/bpf/bpf_arena_list.h
> index 85dbc3ea4da5..e16fa7d95fcf 100644
> --- a/tools/testing/selftests/bpf/bpf_arena_list.h
> +++ b/tools/testing/selftests/bpf/bpf_arena_list.h
> @@ -64,14 +64,12 @@ static inline void list_add_head(arena_list_node_t *n=
, arena_list_head_t *h)
>
>  static inline void __list_del(arena_list_node_t *n)
>  {
> -       arena_list_node_t *next =3D n->next, *tmp;
> +       arena_list_node_t *next =3D n->next;
>         arena_list_node_t * __arena *pprev =3D n->pprev;
>
>         cast_user(next);
>         cast_kern(pprev);
> -       tmp =3D *pprev;
> -       cast_kern(tmp);
> -       WRITE_ONCE(tmp, next);
> +       WRITE_ONCE(*pprev, next);

This looks wrong, since cast_kern() is necessary on older llvm
that don't have arena support.
On newer llvm above change should make no difference.
list_del() will still do the poisoning as it should.

I'm missing what you're trying to "fix".

