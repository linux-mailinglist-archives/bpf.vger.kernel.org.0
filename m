Return-Path: <bpf+bounces-19620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB55882F47A
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 19:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B62282F87
	for <lists+bpf@lfdr.de>; Tue, 16 Jan 2024 18:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D9A1CF89;
	Tue, 16 Jan 2024 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8YrKVA8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E830B1CF83
	for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705430440; cv=none; b=mF9vMMHM+x+mq8elihpAz84f4m2JfF2bqfxvitjvghCEjp9aylfdEWLVbPO+aHAN+m603DhUXgPmVfxrtKwpB81fIDeFQ2HtQ10moGyQGoh9UefDX/xYbNlak7FWTskxZljHosORQFacLGYjCZqJlAr/VMr3q/WvE+3nel1dZWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705430440; c=relaxed/simple;
	bh=nrcDeJKeX6hXHs1nyUyYBahZbFLOXTexgxpTToI6pOA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Y1TpOjymKHcgcMvGQ1+PgtzLG+EW3Ka/uFUt2r7VXKqZ8x8K53SOuN5f3XymZncXYAfM4d7Yp21FlbBm0LNCdaDn6huCN7jSg3X+88WNH/PcSmt3HLmxOG66RogroYGlHC2YDwZ09j5HwYdfia4kHgB7n+mMWf/YvLdbjr3JCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8YrKVA8; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-336897b6bd6so9773861f8f.2
        for <bpf@vger.kernel.org>; Tue, 16 Jan 2024 10:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705430437; x=1706035237; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmo0kS/B5ekfGS0iy9pJhRGQaLGGA6RDiY13Y2R0nXQ=;
        b=L8YrKVA8WYuBjt0IEObRSryLlgAvEmRPqxTQTVa03VV3ktyR5RxrvJy0yLZuNOiMdW
         oTxhfMQMwrlYM8DcjgCHt+7cpjqJLD3240KKrtxoBDkbIRZTIlsknhVyA2AcAdC4PGdQ
         1jdagLTJ8o3WqFQngIaKetl8a1JHyU6pFlDDZTdNyrN7wExZ5J6RFwWEiQjCq8pJBt5j
         d9x+mWj4VlEtaadOOm70WtahnQJjsoaqQwy51BrfLTbsA3njn/MMC5XUAK6fgidPpgW4
         TZFDb/fZtYYn86yjg9LJXVQHC5mqa60ibgZ3GPFTThb51ugP09VAWOx7qn16dawGcjz3
         d2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705430437; x=1706035237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmo0kS/B5ekfGS0iy9pJhRGQaLGGA6RDiY13Y2R0nXQ=;
        b=D9YGoZmXlLqdki8+4dbLXIpQY6jxXzHcAbFlx8ovgSfZg3ZWCrcHWCVFgIJNrXS/s3
         KrtBZKUtJw7qpb0YgZLkqpYW321eoWbtevbmj8FHZeDIxSsGLJ7uW3yNNMOik9+5VU/J
         vnCFdB0ozI+f/UPBuw6i1NMju39EnO+wEGKNWMLYpZoVsmDmwHYS7EV/O2GjeY/iI4sg
         SYDVWSDFfXdh9KNhbR60xFTrMolEfzv7sgnxDqM1HURoEGJX0+5zFkfwOG+4af5htvyw
         bfDbeM+Plc4gd5ishE6hyIcEyqmRRg7eSm14g0Qx7NCUYtqkldhmzdzenrkhU5JN8cTC
         jECg==
X-Gm-Message-State: AOJu0YxF5E7+xDgwydvwAwOxLy1u5Gu5uXwol1GvADAQh+cWPJ+B99R9
	WZhFQb/sv9Ywb9lKBrabnOVPyTMHb9ypX/3ggUs=
X-Google-Smtp-Source: AGHT+IGluijXsSCRw9mXA4yqUO0ErmamCcM3eG8jSKGUqeFQLWoQUOW3EjQ4b3Po7QrbsSnFskiTC6a2axvEgNx2DKU=
X-Received: by 2002:a5d:6847:0:b0:337:b12b:a723 with SMTP id
 o7-20020a5d6847000000b00337b12ba723mr948317wrw.24.1705430437019; Tue, 16 Jan
 2024 10:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
 <20231221033854.38397-3-alexei.starovoitov@gmail.com> <CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
 <CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
 <CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
 <44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
 <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
 <87h6jm6atm.fsf@oracle.com> <87mste4sjv.fsf@oracle.com> <878r4vra87.fsf@oracle.com>
 <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
In-Reply-To: <95388269687be49d7896a881eda8aa3bb89e40a4.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Jan 2024 10:40:25 -0800
Message-ID: <CAADnVQ+57cJ_ChW10jAwvxV03Tctx1ytMPParVocSYYxGuY5PQ@mail.gmail.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, 
	John Fastabend <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 8:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> [1] selftests
>     https://gist.github.com/eddyz87/276f1ecc51930017dcddbb56e37f57ad
> [2] Cilium
>     https://gist.github.com/eddyz87/4a485573556012ec730c2de0256a79db
>     Note: this is based upon branch 'libbpf-friendliness'
>           from https://github.com/anakryiko/cilium
> [3] Tetragon
>     https://gist.github.com/eddyz87/ca9a4b68007c72469307f2cce3f83bb1


The changes to all three make sense, but they might cause regressions
if they are not synchronized with new llvm.
cilium/tetragon can control the llvm version to some degree, but not selfte=
sts.
Should we add clang macro like __BPF_CPU_VERSION__ and ifdef
different asm style depending on that?
I suspect this "(short)" workaround will still be needed for quite
some time while people upgrade to the latest llvm.
something like __BPF_STRICT_ASM_CONSTRAINT__ ?
Maybe a flag too that can revert to old behavior without warnings?

