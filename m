Return-Path: <bpf+bounces-52465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B0A43101
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 00:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C36E3B3A54
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AEB1DDA35;
	Mon, 24 Feb 2025 23:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uNduifNK"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3C318E377
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740440293; cv=none; b=dpc3RsaN1hPvRef6IpQTQvAq2NI7TvVFY8sbDAT+4CSr/PibDASyAkRnBkgYf5ywc2eLy+5KHK5Wstk7M8KKQg0HfvoH9dSvtlEy9pzgXwpK8RVgzh9hcgHTaPpyueIO/ffykXY2ai73gXyEN1n8Lrp/UWTzGkBMKJdNsFiFfnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740440293; c=relaxed/simple;
	bh=L0gPk+zjj2ifaM993MmW9P3q/Iwl8R3g4W9JAGE7SOA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=p2v+hHRpcw7Yujl1pdHmGY/C/L6Ei9gQrgoMcSDKgqmXg16r5LLI+DrFFAQAEr04BfNVpCCeDGJrpSjLzVs5DrxFXLzzHSn7H2ti2BwTn+KcWKNrILPR9W9xFYOg/Q8ec/dYOTV3jKWHGSmmaEEhUmC4qGZVgb6wGeaUx6rcikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uNduifNK; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740440289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fB0+chUPAFYowG+XkJXcvXgYK4iuTcXgORaFY1RvoEI=;
	b=uNduifNKoXCVckmBzF5g+rUoELyOMmDXCBTiCQCKZcqPuaP/PNx1OOALSf8aEKC/TqloSK
	WVxjdd5Nt8gBhDIakDMs/Rz/xEK2lYtxtTDIKGrW3HFU7EqDZEwao6sNYrQixTRDDak5M+
	N2vq5eQM6CviKfnnoDxbpZJi+WQnXcQ=
Date: Mon, 24 Feb 2025 23:38:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <e73e0f197c012b0c770dfe4579914721c13eaedd@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 1/2] libbpf: implement bpf_usdt_arg_size BPF
 function
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
In-Reply-To: <CAEf4BzZkmAQOeFWLn7BTcqLVj812dfhxxrybMxvWXfQG7hBi2g@mail.gmail.com>
References: <20250220215904.3362709-1-ihor.solodrai@linux.dev>
 <CAEf4Bzb4T3DcySAyyCXWBK-ShyW9iuE-OM9f7EHXmBJg5Qm0eg@mail.gmail.com>
 <6b35b7490955800b5cc3833508c88914d59d0d85@linux.dev>
 <CAEf4BzZkmAQOeFWLn7BTcqLVj812dfhxxrybMxvWXfQG7hBi2g@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2/24/25 3:25 PM, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2025 at 3:15=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
>>
>> On 2/24/25 2:05 PM, Andrii Nakryiko wrote:
>>
>>> [...]
>>>
>>> arg_bitshift is stored as char (which could be signed), so that's why
>>> you were getting signed division, just cast to unsigned and keep
>>> division:
>>>
>>> return (64 - (unsigned)arg_spec->arg_bitshift) / 8;
>>
>> As it turns out, this doesn't work either. Presumably because
>> (64 - (u8)x) is still a signed int.
>
> hm... ok, surprising, but fine
>
>>
>> This works, however:
>>
>>     return (unsigned char)(64 - arg_spec->arg_bitshift) / 8;
>>
>
>
> nit: just unsigned (int), BPF doesn't have single-byte division
> anyways, so it will be upconverted to 32-bit (or 64-bit for noalu32).
> So let's be bold and use 32-bits here ;)

oh

I specified a type because:

    $ ./scripts/checkpatch.pl /tmpfs/0001-libbpf-implement-bpf_usdt_arg_s=
ize-BPF-function.patch=20
=20   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
    #56: FILE: tools/lib/bpf/usdt.bpf.h:140:
    +	return (64 - (unsigned)arg_spec->arg_bitshift) / 8;

(unsigned int) it is then

>
>>>
>>>> [...]

