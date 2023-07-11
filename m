Return-Path: <bpf+bounces-4750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D80B74EB03
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 11:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28AF0280F71
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 09:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B21801B;
	Tue, 11 Jul 2023 09:43:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C8F174E5;
	Tue, 11 Jul 2023 09:43:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC753A4;
	Tue, 11 Jul 2023 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=cIYxaT2JpAhwLaJ52gKkMlK74+PCbIgj/z/gLFd8aqU=; b=DonVZnuIeBd/85SRR5JVKmzGGd
	Hv1+xbOu6lIXj/4HUVGsJLVuqceasVah/SG05atf2VeaB9SY6iUVEp4X7mqRVxRml8ZY9aaKFOKf2
	25hysJcx6LxNr7NYVG2zGtbw1tXrRAp0XphQ8Sxplccqq4rwGK5y+YeQVVDU9D90v4qaCoClwmoly
	4Lvj2aui/JD4DLOCdJpyPtGjBPH0l5nrgfdZSh3nAZmQ0jFIFcm3FUnH2a3NhCxu00O/lkhvrcG45
	k9f9m1DeqF/VyIJk6HlFHwdpTRoluK5I/nx9iOa6tnT0eeKTCtVSvelbPrW9jUKylurLIXwMQ/DmC
	JhMbYAZA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJ9tX-0005re-5d; Tue, 11 Jul 2023 11:42:55 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qJ9tW-000S2D-M6; Tue, 11 Jul 2023 11:42:54 +0200
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Add helper macro to clear opts
 structs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com,
 kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org,
 davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20230710201218.19460-1-daniel@iogearbox.net>
 <20230710201218.19460-6-daniel@iogearbox.net>
 <CAEf4BzYBCHp6x_4mwjduHidJDfQ94-p2gnGSS+V3oAtqg9xsMQ@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5f9fcbe4-5736-4631-5d91-99ae6697f8bf@iogearbox.net>
Date: Tue, 11 Jul 2023 11:42:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYBCHp6x_4mwjduHidJDfQ94-p2gnGSS+V3oAtqg9xsMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26966/Tue Jul 11 09:28:31 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/11/23 6:02 AM, Andrii Nakryiko wrote:
> On Mon, Jul 10, 2023 at 1:12 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> Add a small and generic LIBBPF_OPTS_CLEAR() helper macros which clears
>> an opts structure and reinitializes its .sz member to place the structure
>> size. I found this very useful when developing selftests, but it is also
>> generic enough as a macro next to the existing LIBBPF_OPTS() which hides
>> the .sz initialization, too.
>>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>   tools/lib/bpf/libbpf_common.h | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.h
>> index 9a7937f339df..eb180023aa97 100644
>> --- a/tools/lib/bpf/libbpf_common.h
>> +++ b/tools/lib/bpf/libbpf_common.h
>> @@ -70,4 +70,15 @@
>>                  };                                                          \
>>          })
>>
>> +/* Helper macro to clear a libbpf options struct
>> + *
>> + * Small helper macro to reset all fields and to reinitialize the common
>> + * structure size member.
>> + */
>> +#define LIBBPF_OPTS_CLEAR(NAME)                                                    \
>> +       do {                                                                \
>> +               memset(&NAME, 0, sizeof(NAME));                             \
>> +               NAME.sz = sizeof(NAME);                                     \
>> +       } while (0)
>> +
> 
> This is fine, but I think you can go a half-step further and have
> something even more universal and useful. Something like this:
> 
> 
> #define LIBBPF_OPTS_RESET(NAME, ...)
>      do {
>          memset(&NAME, 0, sizeof(NAME));
>          NAME = (typeof(NAME)) {
>              .sz = sizeof(struct TYPE),
>              __VA_ARGS__
>          };
>       while (0);
> 
> I actually haven't tried if that typeof() trick works, but I hope it does :)

It does, I've used this in BPF code for Cilium, too. ;)

> Then your LIBBPF_OPTS_CLEAR() is just LIBBPF_OPTS_RESET(x). But you
> can also re-initialize:
> 
> LIBBPF_OPTS_RESET(x, .flags = 123, .prog_fd = 456);
> 
> It's more in line with LIBBPF_OPTS() itself in capabilities, except it
> works on existing variable.

Agree, changed into ...

/* Helper macro to clear and optionally reinitialize libbpf options struct
  *
  * Small helper macro to reset all fields and to reinitialize the common
  * structure size member. Values provided by users in struct initializer-
  * syntax as varargs can be provided as well to reinitialize options struct
  * specific members.
  */
#define LIBBPF_OPTS_RESET(NAME, ...)                                        \
         do {                                                                \
                 memset(&NAME, 0, sizeof(NAME));                             \
                 NAME = (typeof(NAME)) {                                     \
                         .sz = sizeof(NAME),                                 \
                         __VA_ARGS__                                         \
                 };                                                          \
         } while (0)

... and updated all the test cases.

Thanks,
Daniel

