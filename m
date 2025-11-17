Return-Path: <bpf+bounces-74719-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1F3C63F69
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 12:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 678403459D0
	for <lists+bpf@lfdr.de>; Mon, 17 Nov 2025 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BB6328245;
	Mon, 17 Nov 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrQjM2Sv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33E2673AF
	for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763380403; cv=none; b=Nd2ZTroRh6ACvfCRJbmR+GWdV3Jyus3pofTn/T9SvsFozuRKm7kTCDbAz3gzyga3Z50eyByz9ewI8cq4PbWlpbAmybhUDjPvZ7PiOv3V2QqwHCV7IOJIats14PM/ruQuAsl2ngLxOdrtRzHGdEPvcEQdmgw81mqxKblSZzu1OAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763380403; c=relaxed/simple;
	bh=yimpNcH98IfX8wABBv6RbwaZOYA5aLdzY91zdW2s+IE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WI2q3vjO9N5RKPkd4+f5cyjT/rYsGimPsOdoSiLuvEelBZZ1/uio047WfDyd8AbT1muhYhzVB52CHW/QLP3mlJUEzbQRDAHp9OVOp1EJAnH346CEYR1MPwp84PoI5xJbrGe8DDw/ltAq2Z6AShhi9BZ6ZQu0FXLTz+kaGaFkuVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrQjM2Sv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF88C113D0;
	Mon, 17 Nov 2025 11:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763380403;
	bh=yimpNcH98IfX8wABBv6RbwaZOYA5aLdzY91zdW2s+IE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GrQjM2SviYPWo0yt0SRFt62LZhtXBmocILRjzKEQlB2KrKz9wuhw2Y7q4blZkqonm
	 Y2LVMWO9c00TmkW/7lCil4F+NX9w03/lfWC63gZ4dLbasJH8PuLMwxKSBIvFoe0ULc
	 eU/x96WeOcPaGkrYq/7o3MFFNWrgQ2RXMyqQYODfsFbkrxkF/TxL4cOLRBl0j0iINc
	 Cva8Dwi8CymXf3SEUb/HiHe7KP7xLLe+EIP3x93jJX+/18C/C+i2s+HPBcT68EcnV2
	 Ja5euls5YHzANUE/eHssJ4uvZVUXLYZfZUycgv+Dp3IGLSrH0WgoSnPNwGfb5n6KRn
	 SaG5I6RxWjeRw==
Message-ID: <78aa6ff1-a3b2-4049-8e99-f2397dfb3105@kernel.org>
Date: Mon, 17 Nov 2025 11:53:19 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpftool: Allow bpftool to build with openssl
 < 3
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Song Liu <song@kernel.org>, kpsingh@kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20251114222249.30122-1-alan.maguire@oracle.com>
 <20251114222249.30122-2-alan.maguire@oracle.com>
 <CAHzjS_vO3GseC0MsUpGDFdTULNYsj4rmWXt6kADa26zioSswgQ@mail.gmail.com>
 <cd326ce3-bff1-4003-912c-659db8da6bf9@oracle.com>
 <CAHzjS_vOOiHuTCygx1xSV-6mc12YHRnuhSew_f54chetc3zEpQ@mail.gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <CAHzjS_vOOiHuTCygx1xSV-6mc12YHRnuhSew_f54chetc3zEpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-11-14 15:17 UTC-0800 ~ Song Liu <song@kernel.org>
> On Fri, Nov 14, 2025 at 3:04 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 14/11/2025 22:55, Song Liu wrote:
>>> On Fri, Nov 14, 2025 at 2:23 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> ERR_get_error_all()[1] is a openssl v3 API, so to make code
>>>> compatible with openssl v1 utilize ERR_get_err_line_data
>>>> instead.  Since openssl is already a build requirement for
>>>> the kernel (minimum requirement openssl 1.0.0), this will
>>>> allow bpftool to compile where opensslv3 is not available.
>>>> Signing-related BPF selftests pass with openssl v1.
>>>>
>>>> [1] https://docs.openssl.org/3.4/man3/ERR_get_error/
>>>>
>>>> Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>> ---
>>>>  tools/bpf/bpftool/sign.c | 6 ++++++
>>>>  1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
>>>> index b34f74d210e9..f9b742f4bb10 100644
>>>> --- a/tools/bpf/bpftool/sign.c
>>>> +++ b/tools/bpf/bpftool/sign.c
>>>> @@ -28,6 +28,12 @@
>>>>
>>>>  #define OPEN_SSL_ERR_BUF_LEN 256
>>>>
>>>> +/* Use deprecated in 3.0 ERR_get_error_line_data for openssl < 3 */
>>>> +#if !defined(OPENSSL_VERSION_MAJOR) || (OPENSSL_VERSION_MAJOR < 3)
>>>> +#define ERR_get_error_all(file, line, func, data, flags) \
>>>> +       ERR_get_error_line_data(file, line, data, flags)
>>>> +#endif
>>>> +
>>>
>>> We have func=NULL in display_openssl_errors(). Shall we just use
>>> ERR_get_error_line_data instead?
>>>
>>
>> It's a good idea, and I tried it - unfortunately we then get a
>> "deprecated in v3" warning when we build with opensslv3. So this was the
>> only way I could think of to build on v1 and not get warnings with v3.
> 
> I see. Thanks for the explanation. This looks good to me.
> 
> Acked-by: Song Liu <song@kernel.org>


Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you Alan!

