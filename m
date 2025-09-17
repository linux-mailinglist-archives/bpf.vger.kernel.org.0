Return-Path: <bpf+bounces-68607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 332F4B7C7EF
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC6711B243DC
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 02:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8612222D8;
	Wed, 17 Sep 2025 02:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SgeB0ro/"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588DA101F2
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758076682; cv=none; b=jbBUEw/YEbAqxyKkpnw5QDWcSEDuwU55geppcnANdc1IpSKhkarQ8XA8PoRfVmsLB31iRYwc5c7rUPrWRixBePu22goRMwkvjFcy9OkiNuYsV3B4xWC/CfufntIuMWDBw0R+Og3+LecqfocPU117FlJ6ZHTqmz0R1pAZb0okcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758076682; c=relaxed/simple;
	bh=+Oqv1htTU1oUQjoIW05xzrckf/ASgORwl3N7cCZXE1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UcMy1E7jK75i8hWOOdPzt3qHKp0zavJBszE5dV8Y5MNhceAUiuFs3xjXJn8qKUZxXGmy9LdT4S/HpgkZaAty9E5U+oxweE4xMq0i+K9djysSYv5CPK6O6KkVVWNZamszPtXftCleKIn9FhdaHOvkpbMqYvOhh1dBoSArLxMEeP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SgeB0ro/; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8d641d6-9afc-4bfe-bf50-25ac4a3702a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758076668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p3MY+R4WlGn4rtSW55R1LJoHIL+0MIVP772CgyYCMxU=;
	b=SgeB0ro/uuX3tDAlrYKbDux+d4sXbPUojiloZ7f+4R1MxgMa6Dk0dhrp62MhLOYXFKrWgw
	LO50glCVjyagbyRBpecTHT8TSQimV9YRjUL96CU5JFGSBHnoc8QnAO+6EtbUCoTlaq3Pkn
	bArAlUljAap/rTfb4Z1g0eTOWkC9kM8=
Date: Wed, 17 Sep 2025 10:37:38 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] bpftool: Fix UAF in get_delegate_value
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <20250916054111.1151487-1-chen.dylane@linux.dev>
 <20250916054111.1151487-2-chen.dylane@linux.dev>
 <CAADnVQKfH6QnLHfsGO_sL10LhTjL+YUWDist2+xGM_PiPjM9Wg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <CAADnVQKfH6QnLHfsGO_sL10LhTjL+YUWDist2+xGM_PiPjM9Wg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/9/17 01:07, Alexei Starovoitov 写道:
> On Mon, Sep 15, 2025 at 10:42 PM Tao Chen <chen.dylane@linux.dev> wrote:
>>
>> The return value ret pointer is pointing opts_copy, but opts_copy
>> gets freed in get_delegate_value before return, fix this by strdup
>> a new buffer.
>>
>> Fixes: 2d812311c2b2 ("bpftool: Add bpf_token show")
>> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
>> ---
>>   tools/bpf/bpftool/token.c | 47 ++++++++++++++++++++++-----------------
>>   1 file changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/token.c b/tools/bpf/bpftool/token.c
>> index 82b829e44c8..c47256d8038 100644
>> --- a/tools/bpf/bpftool/token.c
>> +++ b/tools/bpf/bpftool/token.c
>> @@ -28,6 +28,12 @@ static bool has_delegate_options(const char *mnt_ops)
>>                 strstr(mnt_ops, "delegate_attachs");
>>   }
>>
>> +static void free_delegate_value(char *value)
>> +{
>> +       if (value)
>> +               free(value);
>> +}
>> +
>>   static char *get_delegate_value(const char *opts, const char *key)
>>   {
>>          char *token, *rest, *ret = NULL;
>> @@ -40,7 +46,7 @@ static char *get_delegate_value(const char *opts, const char *key)
>>                          token = strtok_r(NULL, ",", &rest)) {
>>                  if (strncmp(token, key, strlen(key)) == 0 &&
>>                      token[strlen(key)] == '=') {
>> -                       ret = token + strlen(key) + 1;
>> +                       ret = strdup(token + strlen(key) + 1);
> 
> Instead of adding more strdup-s
> strdup(mntent->mnt_opts) once per cmd/map/prog and
> remove another strdrup/free in print_items_per_line().
> 
> pw-bot: cr

will remove it in v2, thanks.

-- 
Best Regards
Tao Chen

