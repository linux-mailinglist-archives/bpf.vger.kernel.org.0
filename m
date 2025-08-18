Return-Path: <bpf+bounces-65895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3582AB2AD65
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A56B581230
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 15:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C3322C68;
	Mon, 18 Aug 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="HgapXyWU"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339DA27B332
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532315; cv=none; b=pYCXZUN5zWIM6hFCKUQrg4HjlrTfEid9x4UhP7yg3PWgGAiKktiMB9fxU+mDY9mZ0nL5hKYjPTK9d5fUMspR6oNzpFHjtcyjHnUJZ3YbaeHz0XGWpHKcmLfVJ4oRk00Bf6cDnHQDMf0TQx93Tp05guHRuDOCrNdCfNDfEwvOTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532315; c=relaxed/simple;
	bh=GHqPGu4J1EMKUTqffFtWbcsgEF5EpCWyqleX/6/Yv04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JccEdgblTpxsspCbM8+mrx2YYemXYTrRR+wvm/FaV+mF3a5q/QwnnRyKAAE/wuTQGOxt1r+52pIISK3nzrpxJD9aNA2Fzks05r1606YgLx+AjtS+nz4dPNZEbVL/SPeM7HTThKULEehT+lCFoMesV3Y/Qn6Q4vYMJnqG+4YObEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=HgapXyWU; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uYh/R375X642/K82Xpj8rMx9QN+Jm+0+c8Kd8PM23TI=; b=HgapXyWUis6P822xU0I1+8CAaB
	pmbhT5aTxowsJBiKWvxYSwpIkPFEFISj2fKupuGmXF6Ey3AjMeg6wmQmvzi3YUQyKvqUwo19BULfb
	8lrTMo5RZMXTC5ApNThbAmGn4Ha5f0atz8NY2rlaSIGyHIb4qIPNKKNzDMZVWlk9mUuNX3vFfO8/4
	fApHCvyPo3dLabd38qEqV+QzfCcQRyMchmjMFGypdRCuOx4JdIgqaAUcb4ufkTjCxMp05SN3q+yj5
	DEwM3D3lChtnbNvR9+HgM3AiWRtVMUPqjihYxb8YnjJ9UEMzYsRHRRd3aRvFxsimGzUCy6zJ1C6AZ
	QHV3na0A==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uo29H-0009Lb-0r;
	Mon, 18 Aug 2025 17:51:51 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uo29G-000Lsl-0W;
	Mon, 18 Aug 2025 17:51:50 +0200
Message-ID: <7083efc7-9ca3-4517-80bd-145ebe465a85@iogearbox.net>
Date: Mon, 18 Aug 2025 17:51:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: add kernel.kptr_restrict hint for no
 instructions
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
References: <20250808145133.404799-1-vincent.mc.li@gmail.com>
 <d9e524a6-6296-4a5a-941e-65cca7d72bcd@kernel.org>
 <729e6325-da97-4f01-97b7-3fc966c3fda7@iogearbox.net>
 <CAK3+h2ysLOfFyJC-O-jJDBawDOqPynHNYzVGvHL-jTkZqrUj5A@mail.gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <CAK3+h2ysLOfFyJC-O-jJDBawDOqPynHNYzVGvHL-jTkZqrUj5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27736/Mon Aug 18 10:27:28 2025)

On 8/18/25 5:50 PM, Vincent Li wrote:
> On Mon, Aug 18, 2025 at 7:50 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 8/8/25 5:49 PM, Quentin Monnet wrote:
>>> Please run ./scripts/get_maintainer.pl and Cc all maintainers for your
>>> future submissions, in this case: all BPF maintainers/reviewers.
>>>
>>> On 08/08/2025 15:51, Vincent Li wrote:
>>>> from bpftool github repo issue [0], when Linux distribution
>>>> kernel.kptr_restrict is set to 2, bpftool prog dump jited returns "no
>>>> instructions returned", this message can be puzzling to bpftool users
>>>> who is not familiar with kernel BPF internal, so add small hint for
>>>> bpftool users to check kernel.kptr_restrict setting. Set
>>>> kernel.kptr_restrict to expose kernel address to allow bpftool prog
>>>> dump jited to dump the jited bpf program instructions.
>>>>
>>>> [0]: https://github.com/libbpf/bpftool/issues/184
>>>>
>>>> Signed-off-by: Vincent Li <vincent.mc.li@gmail.com.
>>>> ---
>>>>    tools/bpf/bpftool/prog.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>>>> index 9722d841abc0..7d2337511284 100644
>>>> --- a/tools/bpf/bpftool/prog.c
>>>> +++ b/tools/bpf/bpftool/prog.c
>>>> @@ -714,7 +714,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>>>>
>>>>       if (mode == DUMP_JITED) {
>>>>               if (info->jited_prog_len == 0 || !info->jited_prog_insns) {
>>>> -                    p_info("no instructions returned");
>>>> +                    p_info("no instructions returned: set kernel.kptr_restrict to expose kernel addresses");
>>
>> Can we align this to sth similar as we have further below in that same function?
>>
>>     p_err("error retrieving jit dump: no instructions returned or kernel.kptr_restrict set?");
> 
> Ok.
> 
>>
>> (I presume the former we'll see for interpreter-only case.)
>>
>>>>                       return -1;
>>>>               }
>>>>               buf = u64_to_ptr(info->jited_prog_insns);
>>>
>>>
>>> Thank you Vincent!
>>>
>>> We have the same hint for the xlated dump some 7 lines further in the
>>> file. As we discussed off-list, this hint was initially printed for both
>>> cases, JITed and xlated dump, since commit 7105e828c087 ("bpf: allow for
>>> correlation of maps and helpers in dump") from Daniel, back in 2017. It
>>> was kept for the xlated dump only after commit cae73f233923 ("bpftool:
>>> use bpf_program__get_prog_info_linear() in prog.c:do_dump()"), I believe
>>> by accident.
>>>
>>>   From what I understand, the kptr restriction should not be relevant in
>>> the case of xlated dump (it does change the information we can print -
>>> it prevents us from retrieving __bpf_call_base from ksyms - but should
>>> not prevent bpftool from retrieving instructions entirely). Daniel, it's
>>> been a while, but do you remember why you printed it for xlated dumps
>>> too? If not, we should probably just keep the hint for the JITed case.
>>
>> Indeed been a while - my understanding is that we don't return xlated in
>> case of not having the right capabilities or when the program got constant
>> blinded so we don't want to expose the latter from the kernel back to user
>> space when kptr_restrict is set.
> 
> So my understanding is to  keep the error log for xlated then. will
> send the suggested patch.

yeap, sgtm

