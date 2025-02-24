Return-Path: <bpf+bounces-52449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DA0A42FF3
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 23:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB99189BD2E
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 22:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3C202C58;
	Mon, 24 Feb 2025 22:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lb0+ZszS"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB351DF242
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435685; cv=none; b=ru/XcWO8q+05he6jQh6NwpGYZBAZgQVB+j3dnjok0DOSH3BlTzaVmRfMK6bULs8xvmpVRxJo5U36tK6PJx2hrA42FTZ+3NtxTVEd6DBHnSF0IuaW5z2bfkRgPDf/hQ+8TrX64tGJChXpCviVlYiCAIyv1Ejj8pmOItl4V6CJ+RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435685; c=relaxed/simple;
	bh=aw7XonwLG0LPLTQ0vBwR5udoOfN0+l3kbVOQOKWm5Sk=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=VOJTJ/sX7JEnyEuj6uslA/5yxy4cQKLdBt2Tih0SuqrqdmwMnTsx6O+qMH5JkC16FCebh/zU2+Uz9CHimnE/FmGKA79GJzE99IQiVtVmza+zNoOIsMexsftF2jWFhtXoyt6EFg/8Wsezt8BIqKIVNa4WVkdcU8beB2sSiNMofJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lb0+ZszS; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740435681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uADskKhPdpX3Ix/gkV0bScLLjJv/zmK3tRIxbfdcbKU=;
	b=lb0+ZszSI49rICPlnRDTLxermZAk+5CeVCuEIDnFbiGOYvlyL4zXCTYVyxltEFtdEir2yQ
	4a2b4/aUps5Z7zsQGOTZyfUuAnM0jjIyo8I5Alpey6VNNcIoqABJFff1n654JQLGfUtuo+
	Rv5APuU+FO1zEg3dmZ4kDlNLcFxLSp4=
Date: Mon, 24 Feb 2025 22:21:19 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <7fd22a4eaaf45527a28827c180fe5569f610e9c4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next 1/2] libbpf: implement bpf_usdt_arg_size BPF
 function
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com,
 kernel-team@meta.com
In-Reply-To: <CAEf4Bzb4T3DcySAyyCXWBK-ShyW9iuE-OM9f7EHXmBJg5Qm0eg@mail.gmail.com>
References: <20250220215904.3362709-1-ihor.solodrai@linux.dev>
 <CAEf4Bzb4T3DcySAyyCXWBK-ShyW9iuE-OM9f7EHXmBJg5Qm0eg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On 2/24/25 2:05 PM, Andrii Nakryiko wrote:
> On Thu, Feb 20, 2025 at 1:59=E2=80=AFPM Ihor Solodrai <ihor.solodrai@li=
nux.dev> wrote:
>>
>> Information about USDT argument size is implicitly stored in
>> __bpf_usdt_arg_spec, but currently it's not accessbile to BPF programs
>> that use USDT.
>>
>> Implement bpf_sdt_arg_size() that returns the size of an USDT argument
>> in bytes.
>>
>> Factor out __bpf_usdt_arg_spec() routine from bpf_usdt_arg(). It
>> searches for arg_spec given ctx and arg_num.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/lib/bpf/usdt.bpf.h | 59 ++++++++++++++++++++++++++++++++-------=
-
>>  1 file changed, 47 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
>> index b811f754939f..6041271c5e4e 100644
>> --- a/tools/lib/bpf/usdt.bpf.h
>> +++ b/tools/lib/bpf/usdt.bpf.h
>> @@ -108,19 +108,12 @@ int bpf_usdt_arg_cnt(struct pt_regs *ctx)
>>         return spec->arg_cnt;
>>  }
>>
>> -/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value in=
to *res.
>> - * Returns 0 on success; negative error, otherwise.
>> - * On error *res is guaranteed to be set to zero.
>> - */
>> -__weak __hidden
>> -int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>> +/* Validate ctx and arg_num, if ok set arg_spec pointer */
>> +static __always_inline
>> +int __bpf_usdt_arg_spec(struct pt_regs *ctx, __u64 arg_num, struct __=
bpf_usdt_arg_spec **arg_spec)
>>  {
>>         struct __bpf_usdt_spec *spec;
>> -       struct __bpf_usdt_arg_spec *arg_spec;
>> -       unsigned long val;
>> -       int err, spec_id;
>> -
>> -       *res =3D 0;
>> +       int spec_id;
>>
>>         spec_id =3D __bpf_usdt_spec_id(ctx);
>>         if (spec_id < 0)
>> @@ -136,7 +129,49 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_n=
um, long *res)
>>         if (arg_num >=3D spec->arg_cnt)
>>                 return -ENOENT;
>>
>> -       arg_spec =3D &spec->args[arg_num];
>> +       *arg_spec =3D &spec->args[arg_num];
>> +
>> +       return 0;
>> +}
>> +
>> +/* Returns the size in bytes of the #*arg_num* (zero-indexed) USDT ar=
gument.
>> + * Returns negative error if argument is not found or arg_num is inva=
lid.
>> + */
>> +static __always_inline
>> +int bpf_usdt_arg_size(struct pt_regs *ctx, __u64 arg_num)
>> +{
>> +       struct __bpf_usdt_arg_spec *arg_spec;
>> +       int err;
>> +
>> +       err =3D __bpf_usdt_arg_spec(ctx, arg_num, &arg_spec);
>
> let's not extract this into a separate function. I don't particularly
> like the out parameter, and no need to add another function that could
> be used by users. There isn't much duplication, I think it's fine if
> we just copy/paste few lines of code.

Ok. I wasn't sure what is the tolerance level for copy-pasting in this
context.

>
> pw-bot: cr
>
>> +       if (err)
>> +               return err;
>> +
>> +       /* arg_spec->arg_bitshift =3D 64 - arg_sz * 8
>> +        * so: arg_sz =3D (64 - arg_spec->arg_bitshift) / 8
>> +        * Do a bitshift instead of a division to avoid
>> +        * "unsupported signed division" error.
>> +        */
>> +       return (64 - arg_spec->arg_bitshift) >> 3;
>
> arg_bitshift is stored as char (which could be signed), so that's why
> you were getting signed division, just cast to unsigned and keep
> division:
>
> return (64 - (unsigned)arg_spec->arg_bitshift) / 8;

I haven't realized that. Thanks.

>
>> +}
>> +
>> +/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value in=
to *res.
>> + * Returns 0 on success; negative error, otherwise.
>> + * On error *res is guaranteed to be set to zero.
>> + */
>> +__weak __hidden
>> +int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>> +{
>> +       struct __bpf_usdt_arg_spec *arg_spec;
>> +       unsigned long val;
>> +       int err;
>> +
>> +       *res =3D 0;
>> +
>> +       err =3D __bpf_usdt_arg_spec(ctx, arg_num, &arg_spec);
>> +       if (err)
>> +               return err;
>> +
>>         switch (arg_spec->arg_type) {
>>         case BPF_USDT_ARG_CONST:
>>                 /* Arg is just a constant ("-4@$-9" in USDT arg spec).
>> --
>> 2.48.1
>>

