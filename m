Return-Path: <bpf+bounces-64890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9447B182A9
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 15:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E675458787E
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38FA35977;
	Fri,  1 Aug 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nXyaf3ov"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59000C120
	for <bpf@vger.kernel.org>; Fri,  1 Aug 2025 13:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754055919; cv=none; b=izYyT/ECY8CuLg+O9xhzXMuzqXzSZ1nwRwQ7fH0khsWeHKCdcGug4HtJOSIDOVjPgpwAI+BDjvO/Y8TKXObQXtKasfRtF9i0bArS1um80dD7F0QystRsBp78ATcN6JmllONudYi8hVBbDmZIlv6scKYvJBrGrLJEby3HD5rUweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754055919; c=relaxed/simple;
	bh=mxge1jlAUG/BZkEXjp9pgZDdbKB/vSC7My7DMAp18EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzMEMTaKa0BmrPFJIzQBQa/wZHP26RXESFh8iHmTG3GbNjTrh5IuYadDwSWjJuni/62te6U6u9emXnlrspYRmP2qsDUe2BAVPF9iHdRNHghK6QVqaJRWq5jL+DCsHIGRwIrf0MPg3Z5I5GC6usgAR7wV+myvS6b62B9cce5Qtv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nXyaf3ov; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <90775658-23ad-42cd-b75e-ecbb1b62fde5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754055914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H7/Ty3nv35C0axWz0MFUkj1hZQGQFCdJbwNOFbL/YM=;
	b=nXyaf3ovQu5n6Sp5TcLmMNRfOEi71Vflf/j74jifWVN/pd6Dd/ujgE3N/h0+uBgN/j5kzv
	TCci4zfjlhG8sq7hK373tm/LrMTRsgJ61O9jNU5dTMl28Qr2OOTvdvg1EiiM7inbzJffMw
	RF/FdxCH8NiSL/0S1mhmYk8Ne3TqL3I=
Date: Fri, 1 Aug 2025 21:45:06 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH bpf-next 3/5] bpf: Report freplace attach failure
 reason via extended syscall
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Menglong Dong <menglong8.dong@gmail.com>
References: <20250728142346.95681-1-leon.hwang@linux.dev>
 <20250728142346.95681-4-leon.hwang@linux.dev>
 <CAADnVQJ-wC5kpGZMzU5O7cd-m_4hKA-tjkAm42xEqh2Lu_v_hw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQJ-wC5kpGZMzU5O7cd-m_4hKA-tjkAm42xEqh2Lu_v_hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/8/1 00:32, Alexei Starovoitov wrote:
> On Mon, Jul 28, 2025 at 7:24 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> This patch enables detailed error reporting when a freplace program fails
>> to attach to its target.
>>
>> By leveraging the extended 'bpf()' syscall with common attributes, users
>> can now retrieve the failure reason through the provided log buffer.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  kernel/bpf/syscall.c | 39 +++++++++++++++++++++++++++++++--------
>>  1 file changed, 31 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>> index ca7ce8474812..4d1f58b14a0a 100644
>> --- a/kernel/bpf/syscall.c
>> +++ b/kernel/bpf/syscall.c
>> @@ -3446,7 +3446,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>>                                    int tgt_prog_fd,
>>                                    u32 btf_id,
>>                                    u64 bpf_cookie,
>> -                                  enum bpf_attach_type attach_type)
>> +                                  enum bpf_attach_type attach_type,
>> +                                  struct bpf_verifier_log *log)
> 
> Same issue as before.
> Nack on adding new uapi for the sole purpose of freplace.
> 

Got it.

> Patches 1 and 2 are fine, but must follow with patch(es) that
> make common_attrs usable for existing commands like prog_load and btf_load.
> We need to decide what to do when prog_load's log_buf conflicts
> with common_attrs.log_buf.
> I think it's ok if they both specified and are exactly the same.
> If one of them is specified and another is zero it's also ok.
> When they conflict it's an EINVAL or, maybe, EUSERS to make it distinct.
> After that map_create cmd should adopt log and disambiguate all EINVAL-s
> into human readable messages.

Let me have a try.

Thanks,
Leon



