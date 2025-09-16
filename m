Return-Path: <bpf+bounces-68497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3488EB5969B
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 14:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDD9F324325
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 12:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCD8625;
	Tue, 16 Sep 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liLCLxVV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF61B6CE9
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 12:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027076; cv=none; b=Xqsj/c/+aV8Mku0IG0BJI4jQBfkF6gsBDr13mdE9nisjyg+vyQgIyIQW6+LFy52Gh9xtQaBDLpIXY0XcHH0jR3AgbEuCBHKWugo5RtfJcLKxeYu1GpKKARiN15UzeN19ybwPuLVROEV+Wb7hkrRLgZpWV1dCLnhoqd/f57t2Ef8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027076; c=relaxed/simple;
	bh=LKfxR01l8rsCyw1WHEHpU9DJnBznZ0aG8tKc4xFHzbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uocnMmf0DIvLd2kVZRiIsRSb1Ll5BiEt8GP9w+lyTzMiLFTH4jLTG2m4QO3U0/vWpVooCLc5SHF4XQnatnZ+3HEU0LNbFDv9CJO39sQUWqvP2lnxqDFbBMGqTfVwmBQDQ0hGnnVSlJpdR/z/+8i7NYIfLDq7UVXZPu9mCnH4lV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liLCLxVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735DDC4CEEB;
	Tue, 16 Sep 2025 12:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758027076;
	bh=LKfxR01l8rsCyw1WHEHpU9DJnBznZ0aG8tKc4xFHzbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=liLCLxVV0HhtSOlaJI+QArxUq1f9CAVkLEQx8BXAbs8XbfLqw148ajyYbVEZjrAf3
	 jrVK6wjb+jLNhVO/TJq4NcPIS0mAiskMfbB4N34qQ9G0LSR0HaewMhzblVMbZAFh0V
	 evOSP0J9N1TXTQt8d6g/yQkLxeLMc/o12cnz3LSAELzd9Vpr17V6gJ+ApNVou/YOT/
	 xW2ktN0yLIlgh1FaPSbMssPpCaUXv8ZRBZaj6OWjOWDLc1djDV2Rz87u9xTjt3wmWs
	 31XR59DSA/tt/v09TpbY163OapffPXBZRwrtPd75ltni9ZxamWbMMDdpavLJAqeGkj
	 +CrbpiU0oEmSw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Song Liu <song@kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 xukuohai@huaweicloud.com, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, arm64: Call
 bpf_jit_binary_pack_finalize() in bpf_jit_free()
In-Reply-To: <CAPhsuW5-Q7F9-6hUWJ9XhS37fZrJjk7YNmbHriQM_rDW07X5KA@mail.gmail.com>
References: <20250828013415.2298-1-hengqi.chen@gmail.com>
 <mb61pjz2nmyu4.fsf@kernel.org>
 <CAPhsuW5-Q7F9-6hUWJ9XhS37fZrJjk7YNmbHriQM_rDW07X5KA@mail.gmail.com>
Date: Tue, 16 Sep 2025 12:51:13 +0000
Message-ID: <mb61p4it2a7cu.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Song Liu <song@kernel.org> writes:

> Sorry for the late reply.
>
> On Thu, Aug 28, 2025 at 5:10=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> [...]
>> Thanks for this patch!
>>
>> So, this is fixing a bug because bpf_jit_binary_pack_finalize() will do
>> kvfree(rw_header); but without it currently, jit_data->header is never
>> freed.
>>
>> But I think we shouldn't use bpf_jit_binary_pack_finalize() here as it
>> copies the whole rw_header to ro_header using  bpf_arch_text_copy()
>> which is an expensive operation (patch_map/unmap in loop +
>> flush_icache_range()) and not needed here because we are going
>> to free ro_header anyway.
>>
>> We only need to copy jit_data->header->size to jit_data->ro_header->size
>> because this size is later used by bpf_jit_binary_pack_free(), see
>> comment above bpf_jit_binary_pack_free().
>>
>> How I suggest we should fix the code and the comment:
>>
>> -- >8 --
>>
>> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp=
.c
>> index 5083886d6e66b..cb4c50eeada13 100644
>> --- a/arch/arm64/net/bpf_jit_comp.c
>> +++ b/arch/arm64/net/bpf_jit_comp.c
>> @@ -3093,12 +3093,14 @@ void bpf_jit_free(struct bpf_prog *prog)
>>
>>                 /*
>>                  * If we fail the final pass of JIT (from jit_subprogs),
>> -                * the program may not be finalized yet. Call finalize h=
ere
>> -                * before freeing it.
>> +                * the program may not be finalized yet. Copy the header=
 size
>> +                * from rw_header to ro_header before freeing the ro_hea=
der
>> +                * with bpf_jit_binary_pack_free().
>>                  */
>>                 if (jit_data) {
>>                         bpf_arch_text_copy(&jit_data->ro_header->size, &=
jit_data->header->size,
>>                                            sizeof(jit_data->header->size=
));
>> +                       kvfree(jit_data->header);
>>                         kfree(jit_data);
>>                 }
>>                 prog->bpf_func -=3D cfi_get_offset();
>>
>> -- 8< --
>>
>> Song,
>>
>> Do you think this optimization is worth it or should we just call
>> bpf_jit_binary_pack_finalize() here like this patch is doing?
>
> This is a good optimization. However, given this is not a hot path,
> I don't have a strong preference either way. At the moment, most
> other architectures use bpf_jit_binary_pack_finalize(), so it is good
> to just use bpf_jit_binary_pack_finalize and keep the logic
> consistent.

So, in that case we can merge this patch.

Acked-by: Puranjay Mohan <puranjay@kernel.org>

Thanks,
Puranjay

