Return-Path: <bpf+bounces-74572-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCBFC5F5AD
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 22:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9654E3590C1
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F4C355046;
	Fri, 14 Nov 2025 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSrQr/cb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC12FBE0D
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763155524; cv=none; b=e6JB34QWR3n6edeLlRXirccI0aWW52b/dDaQmJhuNQalpwRnWliQpxLD3Q3IOVukET0n0IZRte8azudRH+hZ27HBYTcfgtzGXNXZsxOwzfmWiR65Q1XTvTFe7/nTnvFl4JyRp8vk0uqJ3tmYFatHNBEFZkEau6/mNPVQU8KMIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763155524; c=relaxed/simple;
	bh=vuLdYrn+GOPJAh17D63g7ycEFg+5KNn+WOMTgIjyDEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxiwSWUfBPKzaptaHSm11+xn2Hw0pyGohilUYpLtkIAVdIMt4q4DHwaghNQJuZzB1oSNAcI5CNlJ0Xr0SN4LcLhaEFrj6xfyfoIUFCZ6C7/sqBlRbJU45gpu6Z6LE1LEPMFMpsaQ+cegKTmwTVe5e0GTS4ycC4czcqlIWEM3jNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSrQr/cb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso1427136f8f.0
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 13:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763155520; x=1763760320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33bxhs0Lm2UDDw9FsiHJ1LBCPkYUTOr2kBiOjO9Mpfg=;
        b=hSrQr/cbR4LeuXeaHDkaUl3XbIxZjSSeI1S6/LzGUp6ndeGERGotSmy7zmsTrpvnYp
         OvaVljLLM0ggqwFOgtjoW5FSinauh/yY8z+VILmkbl8AiYpWgEvgwjhhEbX9q1aywFPB
         1zg06rS8mw8NK036Pdq+FI9iaT5zDAGq3d4oPJjnj4w33elRlF05FQxz3ExNNcXOFcT+
         L17TKgBspbhTQFEoCSNChSNw/kkkDN5VaKZ8i1Cdu+1smWNJVsa1h2q2EQiPNjve8edw
         3T1dDqCKWIlYL+FA3EawSQdowzw2YXPbUEfRUxpA88tErfH0wqVVMi1jxDf169C+kqw1
         qOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763155520; x=1763760320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=33bxhs0Lm2UDDw9FsiHJ1LBCPkYUTOr2kBiOjO9Mpfg=;
        b=NUDyRTYMOlVrJ4DEqqrdlyyrULfDYVPwmXnJxudCOjJCY3qrbStulbp8beLC5zOtVc
         Bk2U4zkLNeErlpTRvkDDWIEE5DYqj60OXMSvTWBWHNeNTw/qQMhrNw4ezPv57L/xKd4j
         g+XprVlthIkMutWpdGml7CJ8Tw15sAOY0uLfjLn0Ea1fsdwqJ7+3s8nE1K5IigboIgDo
         dAFZs8JXADJCn7dUILDH0IfMn7jXFdKboQlvLNf9n7pHQdQVuIbUUPtwv7XClL1Dveep
         KD2LDLKRRNHkhWoG3vooC+PxRFqgwllh2gRn7tHdyxI0XqTNDASP+cg6fl0jNJap0ngv
         N8sg==
X-Gm-Message-State: AOJu0Yx3pJ0gaCbQ8kDNrS2u08soEnusCT1P2vCQ0e6gLqTKgAXLJ4y3
	S0XzxvKRVGm5TecRc7LtiMZS4obeH8Wv6ns3FFGI2jUux8uys+Mobr8Sl2z8u4z6v16vOIQmL7D
	tUKmfE1TVyY9FGtFn3gKbGa4hhhjH7Vg=
X-Gm-Gg: ASbGnctr+0ArSHxYU1zacHI5kztj0hQ6vIBVL/xVmV5SQQlWFjErflHV+VPD5F+6HCI
	HXjmDrvWhawiLZgdcXGRWIPbBHw7FeYHcxufEO1sfbK/g3NfknSHVB8FEfV4zWKCfDvph2vvYXJ
	6Its+PYcc3zaBhpetNDtnrN5I+B7TT2R5mUdAjj8VnHD9HKPIhevVbrLjEswSDitJRS5WcB6l5S
	t6XDF6tScNmR5sM2ZcwszgaQtu5svfPdzejYyIBajzT9JxPhdYRFtDXO2SVJJoSxtC8QLQNAkdW
	Qz2N2c11Fsg1nk5rdm/QPzzcB3Mj
X-Google-Smtp-Source: AGHT+IEn18HevlmkIcP7I0+a/K/frpVr85esmvOIl5L7rRF27u/bQu54LU9JO42jCYRGfPrIXqUaJM9SDcq9imRxAkA=
X-Received: by 2002:a05:6000:2210:b0:42b:394a:9de with SMTP id
 ffacd0b85a97d-42b595adf93mr4145476f8f.49.1763155520229; Fri, 14 Nov 2025
 13:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114111700.43292-1-puranjay@kernel.org> <20251114111700.43292-3-puranjay@kernel.org>
In-Reply-To: <20251114111700.43292-3-puranjay@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 14 Nov 2025 13:25:09 -0800
X-Gm-Features: AWmQ_bncOTJ65IVsNzf7dxYusCCpq_U7vYoASU4qR98_AggMzTM9T6AtDmKEDCU
Message-ID: <CAADnVQLHvNi3RoM+N05Ep3fFX0BfPTGJqEgquYRH6Wm9xS5p1Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: arena: use kmalloc_nolock() in place
 of kvcalloc()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 3:17=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
> +
> +       while(remaining) {
> +               long this_batch =3D min(remaining, alloc_pages);
> +               /* zeroing is needed, since alloc_pages_bulk() only fills=
 in non-zero entries */
> +               memset(pages, 0, this_batch * sizeof(struct page *));

run checkpatch pls. Above needs extra space after while and
empty line after 'long this_batch'.

