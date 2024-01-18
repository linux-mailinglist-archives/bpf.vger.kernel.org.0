Return-Path: <bpf+bounces-19829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FA831FDF
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 20:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39D21C22D1F
	for <lists+bpf@lfdr.de>; Thu, 18 Jan 2024 19:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419B42E620;
	Thu, 18 Jan 2024 19:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLz9u1D+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3782D047
	for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607398; cv=none; b=NgfdoiemXnGk2ZeFu1B6IrlFIPZNdq5xYpXfV+uYwpF+SrI6fMVWpKSJcMSXy80F+P+DcJOJWAfH6yUgadkafMms3WK+BbA9cNKA3tp0rzLkdZgcgsrJMlX3Os5EAeqMel0gPCrHDqcmPE1jxVVkB25tq5bQknh4dYU++3rSd50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607398; c=relaxed/simple;
	bh=1d33vVVjcrBgtBSmLPFDaTWYLstGJKGRjDgZfR6vnqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=szVMgFhAhVg2KVmYfB9gdfgfz97ru3w5blFMtvrMpHa9x2UgnWhhTLLVyIaQv74jPkG3uMG5WSz/d6nci2N1wljsSXVP1ctf74erUDA3J07uSE6SUEUUm4Xs999/14PyUui3Rsm1lFo6TLR4nRNZ4PU+qk1FiifxrOUIOfC4Fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLz9u1D+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e8801221cso98485e9.1
        for <bpf@vger.kernel.org>; Thu, 18 Jan 2024 11:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705607395; x=1706212195; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aEPlyhujEhOxADJThVVL7j+AnUwxIfP3NyzaPM+DnQs=;
        b=WLz9u1D+DakjlJOGzD19Kxn+8U7HmOwkdOlFz9zxWtpAma4siNxx8UON00LAbsUZn2
         /bmOL0yIWgVwLmNgHyHVNWoMzPXBf0N2bhH4FDcgO5U85cerDDL1HUFi+GeGiY1lorqk
         yFqXppeBj2M1zDP4rr9+5gjr2aVqaZsQi3KlKil+xkB9GSCNwdRSv5jmhW0JP6+a6jpZ
         4gpustQ1S3jrha9japvvg525C12Ld977YpXETCPi2jxjMXlu9lWlZXAKPzkD323kYy1p
         YoFhOttazVw3PJjwjZ0qd0gk+LJDFHreSKTBZuiEXYM+lWa3NlhuQHMYl5hY0dyMewrO
         JU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607395; x=1706212195;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aEPlyhujEhOxADJThVVL7j+AnUwxIfP3NyzaPM+DnQs=;
        b=DOMV0yLuUVS9rzoSNJCvXNzRV7dt3AtNZeeev1wE7P0igxgU5H9DcN+ZNjxxr90446
         CDd9glutGiDU4a6A2jFSTO/8VpbmaUaCok50RM/GWUXJyBWInr2lGJzttn+/Oyyf+T/K
         psK+sZ/LCYtxqQWomJKlLAl/9gtQvBi/rCREhLUeQLD0yr3UaTNWz3Qlke0YY8M4XYvm
         xAIcODYPd2cDSs32Pi3kLYb0J2o4xULVK9uWE6XrWyTCyH+UcDL9/+FLEz5pBGKEQUPo
         W8cSSSIyl9TLmoXzzIquHqRXYzakpRj94y0B2x1MG8v/MEsHvfhSVTTrGVzB1cqFKlnY
         6WWA==
X-Gm-Message-State: AOJu0YwFZuUQK52uMJAKu+98u166FLB0S21Gq+p8CJJ7rKonxqDNe0m3
	DJaDQ1fakHuPLdnpOvAEaWSFXO27/f8kpBj+38om3mDsL4QQUt+M
X-Google-Smtp-Source: AGHT+IG2ysXfbp+Pngu1ahEY0CW1FBj4e7yJ+d3j0phlAS+6WZEXs0h8RpuSrv8WlP58AqoKdAC5ZA==
X-Received: by 2002:a1c:4b07:0:b0:40e:7852:bc85 with SMTP id y7-20020a1c4b07000000b0040e7852bc85mr983477wma.41.1705607395273;
        Thu, 18 Jan 2024 11:49:55 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t5-20020a05600c450500b0040d6d755c90sm26808706wmo.42.2024.01.18.11.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:49:54 -0800 (PST)
Message-ID: <781173a0f5e6eb383b03fc85dab3927ae88c52a5.camel@gmail.com>
Subject: Re: [PATCH v2 bpf 0/5] Tighten up arg:ctx type enforcement
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Thu, 18 Jan 2024 21:49:53 +0200
In-Reply-To: <20240117223340.1733595-1-andrii@kernel.org>
References: <20240117223340.1733595-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-17 at 14:33 -0800, Andrii Nakryiko wrote:
> Follow up fixes for kernel-side and libbpf-side logic around handling arg=
:ctx
> (__arg_ctx) tagged arguments of BPF global subprogs.
>=20
> Patch #1 adds libbpf feature detection of kernel-side __arg_ctx support t=
o
> avoid unnecessary rewriting BTF types. With stricter kernel-side type
> enforcement this is now mandatory to avoid problems with using `struct
> bpf_user_pt_regs_t` instead of actual typedef. For __arg_ctx tagged argum=
ents
> verifier is now ignoring superficial `bpf_user_pt_regs_t` typedef and res=
olves
> it down to the actual struct (pt_regs/user_pt_regs/etc, depending on
> architecture), but for old kernels without __arg_ctx support it's more
> backwards compatible for libbpf to use `struct bpf_user_pt_regs_t` rewrit=
e
> which will work on wider range of kernels. So feature detection prevent l=
ibbpf
> accidentally breaking global subprogs on new kernels.
>=20
> We also adjust selftests to do similar feature detection (much simpler, b=
ut
> potentially breaking due to kernel source code refactoring, which is fine=
 for
> selftests), and skip tests expecting libbpf's BTF type rewrites.
>=20
> Patch #2 is preparatory refactoring for patch #3 which adds type enforcem=
ent
> for arg:ctx tagged global subprog args. See the patch for specifics.
>=20
> Patch #4 adds many new cases to ensure type logic works as expected.
>=20
> Finally, patch #5 adds a relevant subset of kernel-side type checks to
> __arg_ctx cases that libbpf supports rewrite of. In libbpf's case, type
> violations are reported as warnings and BTF rewrite is not performed, whi=
ch
> will eventually lead to BPF verifier complaining at program verification =
time.
>=20
> Good care was taken to avoid conflicts between bpf and bpf-next tree (whi=
ch
> has few follow up refactorings in the same code area). Once trees converg=
e
> some of the code will be moved around a bit (and some will be deleted), b=
ut
> with no change to functionality or general shape of the code.
>=20
> v1->v2:
>   - add user_pt_regs and user_regs_struct support for PERF_EVENT (CI);
>   - drop FEAT_ARG_CTX_TAG enum leftover from patch #1;
>   - fix warning about default: without break in the switch (CI).

I've read through patch-set and it seem to be ok,
checks match behavior described in patch #3 description.

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

