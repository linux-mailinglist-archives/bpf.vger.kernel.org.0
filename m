Return-Path: <bpf+bounces-69109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB83B8CC90
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC777A1D5D
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 16:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D81C221714;
	Sat, 20 Sep 2025 16:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hxxKvr2x"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AE2C859
	for <bpf@vger.kernel.org>; Sat, 20 Sep 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385131; cv=none; b=Ov6Z/JlCKRjds0Zqbs24uPtdIlVDLmrQAxD8I73TogHOF0pKLtFjD9rrzWo/9myLnp7NH1PBuZzDQXvr0nOxGcsznCYKMqJkfdUtvGXL2lD1To20dL8Y+GH2U18m14M7OXcp5jSmEjFDGS8lWgDYZ21JU4I2pQdQr4Lxd2Fx/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385131; c=relaxed/simple;
	bh=SeEvx0LOb1wghwCn6KbMiY3T+xz/mM46uK144pUfVQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBCS6/BJID3Za7BLbqh31y1nS7DCFD3XCYewkAX4KJnEPugE5ETThBLla+EMeedp8n6qr+g8aG1b7+NtMrY8TKc7/+/7TpqP1+s+JngxOYzsjueETzf+/9Ewgo3PBJEOmL+getbvdADvktTUc/lUyLnxMcmKYT0p+Y23f9XwBoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hxxKvr2x; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb9f421d-0464-4b94-8825-6d96609aaee8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758385125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xn2FbOx9UvFLPxughq+tS2Mw78lAUyn7+2UiQDk7S9c=;
	b=hxxKvr2x5V/fVRcYZyLdm/zellBQYm2o5pqjv96hojh+7JhrER6dkNPcWs9q6OYxs7jB5Q
	sErFKbItlFpWREocwjPJc/Q0H2CJj4AJqlfVTDY9jViUYbjPvAeaFdoPmEgbCXirVRpK98
	JgxmiGWEmDryggnaXNBA9KvNK/L1Yuc=
Date: Sat, 20 Sep 2025 09:18:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] libbpf: Silence newly-added and unused sections
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>
References: <20250920153531.3675700-1-yonghong.song@linux.dev>
 <CAADnVQJ-28Oy9OoKXtnDOZBxkDofuwfWS-cdSFHd1uqpOmNLmQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJ-28Oy9OoKXtnDOZBxkDofuwfWS-cdSFHd1uqpOmNLmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/20/25 8:56 AM, Alexei Starovoitov wrote:
> On Sat, Sep 20, 2025 at 8:35 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> With latest llvm22, when building bpf selftest, I got the following info
>> emitted by libbpf:
>>    ...
>>    libbpf: elf: skipping unrecognized data section(14) .comment
>>    libbpf: elf: skipping section(15) .note.GNU-stack (size 0)
>>    ...
>>
>> The reason is due to llvm patch [1]. Previously, bpf class BPFMCAsmInfo
>> inherits class MCAsmInfo. With [1], BPFMCAsmInfo inherits class
>> MCAsmInfoELF. Such a change added two more sections in the bpf binary, e.g.
>>    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>>    ...
>>    [23] .comment          PROGBITS        0000000000000000 0035ac 00006d 01  MS  0   0  1
>>    [24] .note.GNU-stack   PROGBITS        0000000000000000 003619 000000 00      0   0  1
>>    ...
>>
>> Adding the above two sections in elf section ignore list can avoid the
>> above info dump during selftest build.
>>
>>    [1] https://github.com/llvm/llvm-project/commit/d9489fd073c0e100c6fbb1e5aef140b00cf62b81
> Can we revert this instead?
> Why do we need these sections if we're not doing anything with them?

Yes, we can revert at llvm side. It does not add any value to libbpf.
Will submit a llvm pull request soon.

>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   tools/lib/bpf/libbpf.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 5161c2b39875..34aed7904039 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -3788,6 +3788,14 @@ static bool ignore_elf_section(Elf64_Shdr *hdr, const char *name)
>>          if (is_sec_name_dwarf(name))
>>                  return true;
>>
>> +       /* .comment section */
>> +       if (strcmp(name, ".comment") == 0)
>> +               return true;
>> +
>> +       /* .note.GNU-stack section */
>> +       if (strcmp(name, ".note.GNU-stack") == 0)
>> +               return true;
>> +
>>          if (str_has_pfx(name, ".rel")) {
>>                  name += sizeof(".rel") - 1;
>>                  /* DWARF section relocations */
>> --
>> 2.47.3
>>


