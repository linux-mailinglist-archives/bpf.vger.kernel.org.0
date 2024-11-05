Return-Path: <bpf+bounces-43982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824449BC2B0
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 02:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51471C21F77
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 01:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8316629429;
	Tue,  5 Nov 2024 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P9jgNbQJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797974C85
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 01:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730770521; cv=none; b=SkTWJwqQj7P5E2ScagYvPb+N0m4RFt2iM/TcEzLXFNXwBopAd9T1jCXEBXWjZ9asE56x/ZvdmX0bRzG0Y8GAdOeVEwkqpEZthIbyhEuOC5gubpNagCN8q+2VuyHcBq75RbSbI5IdXX2yWEqb6R70LuHsjXacVYwXPFf/Vuy5Cyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730770521; c=relaxed/simple;
	bh=U1yI3dAO9T2C+zEhSXJ9dRT9ytBzFYxXj4jY1L2MjvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3qbsM6nWpQfPQ5I9gg4axqqebaOatLI14I7N5BCO/b8yomc0tJLxGFPcUFCxP83WAtnxdAV+l4sztX1wK2gRi9BDb2PU7Lmpzl2jxoSx/omeoIN+c0ofwNGCv6V8Sm4a3nUV7w6f5uSAmlka92CqwpApeKyP4JSQajOoGeDn7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P9jgNbQJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <36294e71-4d0b-465d-9bf5-c5640aa3a089@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730770515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRvmFZ5mFdb6davUpfr9o4cNqDV+pCTA30BVCrWHG4I=;
	b=P9jgNbQJ4yONPTavdOd6VUPvI2LtqO90I7e0VKU/TOlmUHVAZwZMtLz0j5Eb2X5QK/dnAu
	dAwI7q9Q5eH/x+IJycdNHN6clADCSOEsxzlSPf8LkXLdr9BZqLjgwmWsI1FhfV+GuG4Oec
	rNBTaqRvBSiNZF+KRJs1rYzQPhpoAIc=
Date: Mon, 4 Nov 2024 17:35:01 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 02/10] bpf: Return false for
 bpf_prog_check_recur() default case
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo <tj@kernel.org>
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193505.3242662-1-yonghong.song@linux.dev>
 <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLr5Rz+L=4CWPxjBGLcYEctLRpPfh642LtNjXKTbyKPgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 11/4/24 5:21 PM, Alexei Starovoitov wrote:
> On Mon, Nov 4, 2024 at 11:35 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> The bpf_prog_check_recur() funciton is currently used by trampoline
>> and tracing programs (also using trampoline) to check whether a
>> particular prog supports recursion checking or not. The default case
>> (non-trampoline progs) return true in the current implementation.
>>
>> Let us make the non-trampoline prog recursion check return false
>> instead. It does not impact any existing use cases and allows the
>> function to be used outside the trampoline context in the next patch.
> Does not impact ?! But it does.
> This patch removes recursion check from fentry progs.
> This cannot be right.

The original bpf_prog_check_recur() implementation:

static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
{
         switch (resolve_prog_type(prog)) {
         case BPF_PROG_TYPE_TRACING:
                 return prog->expected_attach_type != BPF_TRACE_ITER;
         case BPF_PROG_TYPE_STRUCT_OPS:
         case BPF_PROG_TYPE_LSM:
                 return false;
         default:
                 return true;
         }
}

fentry prog is a TRACING prog, so it is covered. Did I miss anything?

>
> pw-bot: cr
>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   include/linux/bpf_verifier.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 4513372c5bc8..ad887c68d3e1 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -889,9 +889,8 @@ static inline bool bpf_prog_check_recur(const struct bpf_prog *prog)
>>                  return prog->expected_attach_type != BPF_TRACE_ITER;
>>          case BPF_PROG_TYPE_STRUCT_OPS:
>>          case BPF_PROG_TYPE_LSM:
>> -               return false;
>>          default:
>> -               return true;
>> +               return false;
>>          }
>>   }
>>
>> --
>> 2.43.5
>>

