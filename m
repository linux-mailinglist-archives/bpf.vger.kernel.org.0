Return-Path: <bpf+bounces-40297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D364698573B
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 12:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0091C21458
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BABD15B968;
	Wed, 25 Sep 2024 10:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="YnPgnMyb"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222E71304AB;
	Wed, 25 Sep 2024 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727260568; cv=none; b=daLPDJ+DsAcwRLbWWK/YB7QaM31hEG1QuB4FlwGlifXwKzjj73KUHdP1bljI4B3PnU5WZe2xCq+Zyjr+wx1zUxRmwD1ePKhiPakirZi/0VtgNRu2lOUvR5nqY7UYYF762eh+OK52eUj9aY1z5KPG5aY/XsMElwI4/T20tN295Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727260568; c=relaxed/simple;
	bh=EHwd2d+hqVgsyBcdI/VT2BZY5ls9gxMbsay29WFqh4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tgbnYnO5C6csYsWvYk144/iqXfkpKWAQlw2fPHjv7S2DzMvcfXnY5GXmmbwDuChvPew2GkGlSCr3Xfr2A+ENh64QTt9I72kPr4U3Mq0f7WO3LU1VWu+m2Uk6HTSw/GUdR4XklWJ/uV54tngV8v+zQImbZ6WrV3wSHYUd2Nt8bQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=YnPgnMyb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xZijSakaFI8Z3r7WPvVbRLHmqe3UhmGepM/S5JV7NbU=; b=YnPgnMybuFjS9iG8qlsOz177HI
	pOheTewqZgHFvSIfAlHtoer3wH0TsOboPDbmZWgRHtbR8kZjehI0g3SUtREZ9cYrs6x1+jhINyvYz
	wxHZl0ccX7C4yySqV0sXCvSJRzLqH65fOK6/aTRIZt1iORM4sYZzwynAQ3ofIWaxzl8ihBJeuxC9M
	Hbkk6rw9naDOkWncIbYe1PLsRD8WWOHamuow3NyqGq0/MDgo70Iq86YCkNbnAIkr9xAo4DISX/vZR
	9rE1ib1gf2DD7X2vM7RaXhzFzOOb5V/ODkMQ/1XGwSf1dCdnM0K8lALsbgxB+Ow6Yp9zgiq3NfHvt
	YyRdB2sQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1stPNM-000Fsi-5G; Wed, 25 Sep 2024 12:36:03 +0200
Received: from [178.197.249.20] (helo=[192.168.1.114])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1stPNL-000P50-2l;
	Wed, 25 Sep 2024 12:36:03 +0200
Message-ID: <11e2ed15-b3a5-419a-9e9f-cbfe270d0fe8@iogearbox.net>
Date: Wed, 25 Sep 2024 12:36:02 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] libbpf: Fix expected_attach_type set when
 kernel not support
To: Jiri Olsa <olsajiri@gmail.com>, Tao Chen <chen.dylane@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240914154040.276933-1-chen.dylane@gmail.com>
 <ZvPl6Wo4cdihaQ0A@krava>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
In-Reply-To: <ZvPl6Wo4cdihaQ0A@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27409/Wed Sep 25 11:17:07 2024)

On 9/25/24 12:28 PM, Jiri Olsa wrote:
> On Sat, Sep 14, 2024 at 11:40:40PM +0800, Tao Chen wrote:
>> The commit "5902da6d8a52" set expected_attach_type again with
>> field of bpf_program after libpf_prepare_prog_load, which makes
>> expected_attach_type = 0 no sense when kenrel not support the
>> attach_type feature, so fix it.
>>
>> Fixes: 5902da6d8a52 ("libbpf: Add uprobe multi link support to bpf_program__attach_usdt")
>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Tao Chen <chen.dylane@gmail.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 12 ++++++++----
>>   1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> Change list:
>> - v2 -> v3:
>>      - update BPF_TRACE_UPROBE_MULTI both in prog and opts suggedted by
>>        Andrri
>> - v1 -> v2:
>>      - restore the original initialization way suggested by Jiri
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 219facd0e66e..a78e24ff354b 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -7352,8 +7352,14 @@ static int libbpf_prepare_prog_load(struct bpf_program *prog,
>>   		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
>>   
>>   	/* special check for usdt to use uprobe_multi link */
>> -	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK))
>> +	if ((def & SEC_USDT) && kernel_supports(prog->obj, FEAT_UPROBE_MULTI_LINK)) {
>> +		/* for BPF_TRACE_KPROBE_MULTI, user might want to query exected_attach_type
>> +		 * in prog, and expected_attach_type we set in kenrel is from opts, so we
>> +		 * update both.
>> +		 */
> s/K/U/ in BPF_TRACE_KPROBE_MULTI in above comment and 'kenrel' typo
>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
Same typo is also in commit desc, would be good to improve the commit
desc a bit if you spin v4 anyway. Thanks!

