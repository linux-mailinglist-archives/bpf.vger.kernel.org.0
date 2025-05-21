Return-Path: <bpf+bounces-58685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC8CABFF33
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 23:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55CC51BC5716
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 21:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCA1237713;
	Wed, 21 May 2025 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu8DcOyt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC45184
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864760; cv=none; b=eCC3JpFt9I5s1HLzNfkhJcl/GOq9XB7bnu3ghf916u5mh4ctzUfZBSpIHo8+nTFWAkr6TbNxEYRHYZryQH59EALukN50/UCLSgN+thF8bWAihl71BbucXMpGDsI6VRvBwob9YMGRfS/6Yz4Bm/AX5NqjvG8Vn0voSBcz3VcYH74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864760; c=relaxed/simple;
	bh=R9Jr+CA8v/tyRIL1FQ8eOrPlRqnrc0wklC4vm9tPLyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IZRCXggKwYOaUwXLMkq0H38PZ7VmCrMpmUufJcCski99ZvJYe0zjpQaUm+WQ8n5U64wEkSkvxJf0Rs4NcCLS+mbrbikwmsymZDgIz79q574NoEzMxH6fBo/Jz2+SZGME/oTKmzV4U6iHaBLzaCvxyv+c5x3LrenJim72lppUqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu8DcOyt; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c46611b6so5664797b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747864758; x=1748469558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzykwK2IDMFdhxIanaFajIGpngPATEgCh7F3a5tQ6EI=;
        b=lu8DcOytAX/3oAFfO5OhBSkm6GV6b9ye3LUkUaiXLZ1ciOusFw6/EnIU/QhBxGuj1B
         b+zp1QntRWK/0SolUYPDb5tWcht3OpNkVLkUVoi1vcCoaJKWWxnXFdkVHXa2+dX+8GiC
         SWpUIhAf2k+p+uD/U5idpQp3ADryR35wgXIFFZv0YwFxSh8rNgnsQR+aoA9WYa+zkoG5
         bFeO+p0PqV27/TFeaezxr+yBL962mf58mUSKCa/JzKcg4LbGQaXuKzCaKwUJ3FAcZLjL
         nrZx6DNh25wnC+OLt84Fh5UMOpVu66K14lqm/aPurg96pQ/tIFxjzQEJ3liKf8JXfOP3
         zwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747864758; x=1748469558;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PzykwK2IDMFdhxIanaFajIGpngPATEgCh7F3a5tQ6EI=;
        b=SSeTpThsv3DZwIGoYHOg0vgAQEZBaJRz271QIn5wk53G0UMVX7EjVt0ynUfFe59x3H
         MTyRqI/JPqk6poMCOgneA1yD2SR9pbTBiWppxUtbFPS85mWzqfIEO4jMj6LLSfgIxQna
         JMtILTcbKzRX5xrjXQTtq6hqR5NiWfJaIDmC1qBKfr/NcfUqb6mqaWHljZTCXSLaeJjT
         DxDXgObM8oGSSo1JlqXXgMhzQO1V8OpVzvNtAUlTFZw4LjnK/NNnRtBwZc6H7M+97WSt
         ayCBKM6ntQos770TjT+sDzNdF4qLpKmbx+m5PSpNFkUPyKPR2EgRi48z1AxECX0vR39s
         6HKg==
X-Gm-Message-State: AOJu0YzNU2/Ko6WK3SK6HPFSawXbF3U+CQa2x5AcwQ5DJQ05gxxy82np
	BuI2cudLK8laz9KsRl87X5pu8tbyuXmfhcdti5k5vJIYZL6dCyAxcxbD
X-Gm-Gg: ASbGncueUp2C1lacyxANuHv608F4drEhGMLerZ32mn0LweceGckD0Vo8RpD/1xuwLFR
	os+v9RxaKDj8Ge3tn3XhTDG3izlZ9OeST4FVvg2UrFycdYl5C8Y8eMkI1Vt/1RglXDB0kG6Toda
	sgeLdrDTkrBM9VPeLzBjbhzgTB5E/LTS75W6z/BFV97jgLTOJG6wdKdzjWaplgDDY1TI/3t73yp
	Q/K66TgTEkIJGmzxpJGpdiq1M+VtO67FRFZD8+hsrggLIyTcVg07mp4KAAmIXcQs9gkWD+HT4Xf
	XErDC5RLFNmngq7Srb2mpICrY4d+0yb/thk7VFEwOsMFWNUoMhjOKWA=
X-Google-Smtp-Source: AGHT+IGa0yTNo8EXjgkagapDgA+iHiFrb7osA3eUn34ZgcqGooPrfuFn2yMt1fiKM082eui5+QBQ3Q==
X-Received: by 2002:a05:6a00:1382:b0:740:5927:aa4c with SMTP id d2e1a72fcca58-742acba8f87mr29284829b3a.0.1747864757923;
        Wed, 21 May 2025 14:59:17 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a96e226bsm10029912b3a.29.2025.05.21.14.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 14:59:17 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  kernel-team@fb.com,  Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register
 in precision backtracking bookkeeping
In-Reply-To: <6885590a-266e-4230-9eeb-4fbfd7e2f3f4@linux.dev> (Yonghong Song's
	message of "Wed, 21 May 2025 14:35:48 -0700")
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
	<45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
	<2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
	<m2ikltd6kz.fsf@gmail.com>
	<6885590a-266e-4230-9eeb-4fbfd7e2f3f4@linux.dev>
Date: Wed, 21 May 2025 14:59:15 -0700
Message-ID: <m2zff5bp70.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yonghong Song <yonghong.song@linux.dev> writes:

[...]

> Let us say that we remove the code
>
> +=C2=A0=C2=A0=C2=A0 if (!src_reg) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (linked_regs)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n push_insn_history(env, state, 0, linked_regs);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> +=C2=A0=C2=A0=C2=A0 }
>
> The code should still work. But we might end up with more unnecessary
> jump history entries. For example,
>    dreg->type =3D=3D PTR_TO_STACK, sreg is faked (i.e., BPF_SRC(insn->cod=
e) =3D=3D BPF_K)
>    and linked_regs =3D 0
>
> In this particular, we will still generate a jump table entry which
> is not used in backtrack_insn().

If linked_regs set is not empty the push_insn_history() is necessary
even if src_reg is fake. Linked registers are handled at entry and at
exit from backtrack_insn() outside of instruction pattern match if-else
block.

