Return-Path: <bpf+bounces-20066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C3C83863C
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 05:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F901F24CD3
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 04:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D591869;
	Tue, 23 Jan 2024 04:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6EXCGg3"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5C626;
	Tue, 23 Jan 2024 04:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705982874; cv=none; b=c/Kfw11igkn4JCgrOSTIgCSHcEuOetJwP5QU7GzrUxHG6DemZeKF7MoeCRea81zE2PJlKTNDS7oKzd5i6SS+3sTc9tdS4NvI5aqh+pt/RiBTyS8Ur6Z61Osv0pGY9Gu87tphk+gprhyVn5pHaSky4RqWdYqcxOvp6mqPEBAAJqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705982874; c=relaxed/simple;
	bh=F3J4VLhI3E5hi/a5J/HebUE680cU1BPix/0V2rHvQaI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aD2/iwsY6h9Skxqr1X+PVdQzDELK26eyNYc2Kjvc8Cjs9LWtC5Ay8ysdz06rnr0775Sx4EpHdNkOw13mWaqkZVvefeYmuK15x09UKaHqjzYYpFtbSgKlFx2B911dZT1KskQXzF1CP5lQTuy9DhU8sYbRACk+hERvTO3bDRVS6FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6EXCGg3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59119C433C7;
	Tue, 23 Jan 2024 04:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705982873;
	bh=F3J4VLhI3E5hi/a5J/HebUE680cU1BPix/0V2rHvQaI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=H6EXCGg36EBzrxB0TtpKgUYdqWpGsNZRQ667Y+OkOQsWbmUx6rvuWKcVHdbMvw/07
	 4Cr6X1PZ5bFIjWnyCxMKkloGBne5TTTudZQxIXtF7+q91hRZnD+4SpFB4ZY42NRcdq
	 dv17RFfnP3DiUOK95LeCULP9L86Js/HyrW0F2l4+IjyUbl4XhMbY+wrRMMltpcKyzg
	 HPvSf/4/fAE8SR6FYEOLMY0yeU2uM6lRgD3Y7MA70JaYE17pajKQY0mjUwZbS1l9Js
	 AO0DYuRK1Qm58jBkqSaI284EFRYmoAIA3/M9ts0qPmkd8/0zsy7WDHvrBeBddeNzz5
	 Hy+Trm+s4hZvQ==
Date: Mon, 22 Jan 2024 20:07:52 -0800
From: Kees Cook <kees@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>, Kees Cook <keescook@chromium.org>,
 linux-hardening@vger.kernel.org
CC: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 43/82] bpf: Refactor intentional wrap-around test
User-Agent: K-9 Mail for Android
In-Reply-To: <15d65e11-d957-4b03-bec3-0dcd58b50f97@linux.dev>
References: <20240122235208.work.748-kees@kernel.org> <20240123002814.1396804-43-keescook@chromium.org> <15d65e11-d957-4b03-bec3-0dcd58b50f97@linux.dev>
Message-ID: <6CE08B7D-7E0C-45E2-8A6B-32691BE40D08@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 22, 2024 8:00:26 PM PST, Yonghong Song <yonghong=2Esong@linux=
=2Edev> wrote:
>
>On 1/22/24 4:27 PM, Kees Cook wrote:
>> In an effort to separate intentional arithmetic wrap-around from
>> unexpected wrap-around, we need to refactor places that depend on this
>> kind of math=2E One of the most common code patterns of this is:
>>=20
>> 	VAR + value < VAR
>>=20
>> Notably, this is considered "undefined behavior" for signed and pointer
>> types, which the kernel works around by using the -fno-strict-overflow
>> option in the build[1] (which used to just be -fwrapv)=2E Regardless, w=
e
>> want to get the kernel source to the position where we can meaningfully
>> instrument arithmetic wrap-around conditions and catch them when they
>> are unexpected, regardless of whether they are signed[2], unsigned[3],
>> or pointer[4] types=2E
>>=20
>> Refactor open-coded wrap-around addition test to use add_would_overflow=
()=2E
>> This paves the way to enabling the wrap-around sanitizers in the future=
=2E
>>=20
>> Link: https://git=2Ekernel=2Eorg/linus/68df3755e383e6fecf2354a67b08f92f=
18536594 [1]
>> Link: https://github=2Ecom/KSPP/linux/issues/26 [2]
>> Link: https://github=2Ecom/KSPP/linux/issues/27 [3]
>> Link: https://github=2Ecom/KSPP/linux/issues/344 [4]
>> Cc: Alexei Starovoitov <ast@kernel=2Eorg>
>> Cc: Daniel Borkmann <daniel@iogearbox=2Enet>
>> Cc: John Fastabend <john=2Efastabend@gmail=2Ecom>
>> Cc: Andrii Nakryiko <andrii@kernel=2Eorg>
>> Cc: Martin KaFai Lau <martin=2Elau@linux=2Edev>
>> Cc: Song Liu <song@kernel=2Eorg>
>> Cc: Yonghong Song <yonghong=2Esong@linux=2Edev>
>> Cc: KP Singh <kpsingh@kernel=2Eorg>
>> Cc: Stanislav Fomichev <sdf@google=2Ecom>
>> Cc: Hao Luo <haoluo@google=2Ecom>
>> Cc: Jiri Olsa <jolsa@kernel=2Eorg>
>> Cc: bpf@vger=2Ekernel=2Eorg
>> Signed-off-by: Kees Cook <keescook@chromium=2Eorg>
>> ---
>>   kernel/bpf/verifier=2Ec | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/kernel/bpf/verifier=2Ec b/kernel/bpf/verifier=2Ec
>> index 65f598694d55=2E=2E21e3f30c8757 100644
>> --- a/kernel/bpf/verifier=2Ec
>> +++ b/kernel/bpf/verifier=2Ec
>> @@ -12901,8 +12901,8 @@ static int adjust_ptr_min_max_vals(struct bpf_v=
erifier_env *env,
>>   			dst_reg->smin_value =3D smin_ptr + smin_val;
>>   			dst_reg->smax_value =3D smax_ptr + smax_val;
>>   		}
>> -		if (umin_ptr + umin_val < umin_ptr ||
>> -		    umax_ptr + umax_val < umax_ptr) {
>> +		if (add_would_overflow(umin_ptr, umin_val) ||
>> +		    add_would_overflow(umax_ptr, umax_val)) {
>
>Maybe you could give a reference to the definition of add_would_overflow(=
)?
>A link or a patch with add_would_overflow() defined cc'ed to bpf program=
=2E

Sure! It was earlier in the series:
https://lore=2Ekernel=2Eorg/linux-hardening/20240123002814=2E1396804-2-kee=
scook@chromium=2Eorg/

The cover letter also has more details:
https://lore=2Ekernel=2Eorg/linux-hardening/20240122235208=2Ework=2E748-ke=
es@kernel=2Eorg/

>The patch itselfs looks good to me=2E

Thanks!

-Kees

--=20
Kees Cook

