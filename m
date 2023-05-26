Return-Path: <bpf+bounces-1295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C69A6712349
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 11:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817DB1C210F5
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 09:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F3011184;
	Fri, 26 May 2023 09:19:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05D10954
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:19:27 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD77195
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7GoWo1uU+m7K1+vBK5OZ2og5KP9fUN2kD+E5MOF3A2A=; b=HUtAmZID+oPknDt7Qa2+GsJ95Q
	YqgnCosfGBfRQjIoKBEpFw4eAiVszwbGB4z6UMd8KJ7WIdK1aQwqKISReREPch+/AaM6amVuEMT6f
	VCBOkpkrT2hhsenRKv/DuaWZs9EW3QhnUVb72siUr6KpjW8sfoIvR5FEusIAzEGboMZjVQgELK41U
	dhZpAO9jtypMhYVQj2A/91fZF8tYVyz2YfwEujj/+K7FzjwGAYsGeNY06yE7LJ+Fme3TIoWbIiu82
	V1zlsGClSh66eZqFtPm9Yw+1IhT8SbfBI2WtyNVBNfKO8m3KnNvSdQHRnk4tYyCquWcQVLa5lq7cr
	UrOniG1w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q2TbP-000JTN-L6; Fri, 26 May 2023 11:19:15 +0200
Received: from [178.197.248.12] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q2TbP-000Irg-5p; Fri, 26 May 2023 11:19:15 +0200
Subject: Re: [PATCH bpf-next 1/2] libbpf: ensure libbpf always opens files
 with O_CLOEXEC
To: Lennart Poettering <lennart@poettering.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@kernel.org
References: <20230525221311.2136408-1-andrii@kernel.org>
 <ZHBrjg4xCNl0Z6KY@gardel-login>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ffd45013-4910-09e3-6bc8-2ef865a2a155@iogearbox.net>
Date: Fri, 26 May 2023 11:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZHBrjg4xCNl0Z6KY@gardel-login>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26919/Fri May 26 09:23:54 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/26/23 10:19 AM, Lennart Poettering wrote:
> On Do, 25.05.23 15:13, Andrii Nakryiko (andrii@kernel.org) wrote:
> 
>> Make sure that libbpf code always gets FD with O_CLOEXEC flag set,
>> regardless if file is open through open() or fopen(). For the latter
>> this means to add "e" to mode string, which is supported since pretty
>> ancient glibc v2.7.
>>
>> I also dropped outdated TODO comment in usdt.c, which was already completed.
>>
>> Suggested-by: Lennart Poettering <lennart@poettering.net>
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
>>   tools/lib/bpf/btf.c           | 2 +-
>>   tools/lib/bpf/libbpf.c        | 6 +++---
>>   tools/lib/bpf/libbpf_probes.c | 2 +-
>>   tools/lib/bpf/usdt.c          | 5 ++---
>>   4 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 0a2c079244b6..8484b563b53d 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -1064,7 +1064,7 @@ static struct btf *btf_parse_raw(const char *path, struct btf *base_btf)
>>   	int err = 0;
>>   	long sz;
>>
>> -	f = fopen(path, "rb");
>> +	f = fopen(path, "rbe");
> 
> You might as well drop the "b". That's a thing only on non-POSIX
> systems. So unless you want to support windows with this, you can drop
> it with zero effect.

Iiuc, the library is also imported by the 'ebpf for windows' project [0],
so we might need to keep the 'b' intact in that case.

Thanks,
Daniel

   [0] https://github.com/microsoft/ebpf-for-windows/#architectural-overview

