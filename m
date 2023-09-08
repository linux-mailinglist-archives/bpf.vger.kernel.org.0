Return-Path: <bpf+bounces-9499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D14C79881B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 15:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28376281B8B
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 13:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D663B3;
	Fri,  8 Sep 2023 13:49:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55053B4
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 13:49:23 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A471BF6;
	Fri,  8 Sep 2023 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uqY6Z5h6ZluAE9vpCfYrBwCL495VscqDRqy2N8Ea9Gw=; b=jGqURuwfyBPWOeEwk8Azmv3R7a
	b5SMleDF3N5YuFPK0TzWTXLmhKnZ/nUJG58G2AbPMPCQiccSKMkPZnVleKN7qZXHODP8TAy/opAUM
	WNY5XTVD0w/7qjUskXl/Rt11Dd3v9eReTnLM0aGEnf6K48x5bZwerxatXdgg5gyGUox8l6h6wlBO8
	BG0tOp550Lx28Bh4L0ACP9yfLyE540Du/RTiXfgtO8cvG52Vh37qYSIH8EsIvbhIhhyExE9jG3o1F
	11QYhBeCTaifFQcAGPqfWfNoGci9P4SO9L0gggMdcqLakNsH2lm96yamsmmk7UMWdD7aecVUyuqnE
	DAS8RzVA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qebr9-000BEW-5V; Fri, 08 Sep 2023 15:49:07 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qebr8-000DG6-Fl; Fri, 08 Sep 2023 15:49:06 +0200
Subject: Re: [PATCH bpf-next v3 9/9] MAINTAINERS: Add myself for ARM32 BPF JIT
 maintainer.
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shubham Bansal <illusionist.neo@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230907230550.1417590-1-puranjay12@gmail.com>
 <20230907230550.1417590-10-puranjay12@gmail.com>
 <ZPrdQEhw4f+TK8TB@shell.armlinux.org.uk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1a4bc20a-b7ff-3697-5859-a2bb868c575f@iogearbox.net>
Date: Fri, 8 Sep 2023 15:49:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZPrdQEhw4f+TK8TB@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27025/Fri Sep  8 09:37:45 2023)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/8/23 10:37 AM, Russell King (Oracle) wrote:
> On Thu, Sep 07, 2023 at 11:05:50PM +0000, Puranjay Mohan wrote:
>> As Shubham has been inactive since 2017, Add myself for ARM32 BPF JIT.
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> ---
>>   MAINTAINERS | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 612d6d1dbf36..c241856819bd 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3602,9 +3602,10 @@ F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
>>   F:	drivers/iio/accel/bma400*
>>   
>>   BPF JIT for ARM
>> -M:	Shubham Bansal <illusionist.neo@gmail.com>
>> +M:	Puranjay Mohan <puranjay12@gmail.com>
>> +R:	Shubham Bansal <illusionist.neo@gmail.com>
> 
> Don't forget that I also want to review the changes, but I guess my
> arch/arm entry will cover this too.

If there are no objections from all parties, it would be nice/better if both of
you (Puranjay & Russell) could be explicitly added here as maintainers.

Thanks,
Daniel

