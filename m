Return-Path: <bpf+bounces-9104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE10678FB04
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 11:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FD51C20BE2
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A1EA939;
	Fri,  1 Sep 2023 09:38:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB74A922;
	Fri,  1 Sep 2023 09:38:50 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B310E4;
	Fri,  1 Sep 2023 02:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=uMyJPJBxOLcIVVsqNXFeg88da7ZpAcznuFBOv1G00Mg=; b=DHX/R7mYlLBaJwfFFgCiqIsSgx
	PODwMRs5ky+wMDoToPxZxQ2Y81C0uN06aKHxEe5nKSrhssmuuAI/SaVC/+Q8pU6QCHx87j7QyCDZ3
	Wq4MvZ2iWdE0mqFdGi/ct8WDPZAAICmTrDU91V5/6FuOP7GTQPVtU5B0LQ3D4l7xdpmrFV0GbGjWm
	gjpUkjuP1a6b4F63e6iLokHW/vnbvJeqBVyB3o5qMv/9vHznd3aaORroJUBrRnzbzNsWe/OlpwBw8
	G5cGfSN08+acSGtZ5FLINDJaP86UXeryzz9wAWK9UUwwE7utZGP/1hkkXxJyWz/A4XOcJSrP4WPnf
	MN2MN7Yg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qc0bs-0004Di-31; Fri, 01 Sep 2023 11:38:36 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qc0bs-000SRy-5r; Fri, 01 Sep 2023 11:38:36 +0200
Subject: Re: [PATCH bpf-next v2] selftests/bpf: fix a CI failure caused by
 vsock write
To: Xu Kuohai <xukuohai@huawei.com>, Xu Kuohai <xukuohai@huaweicloud.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>
References: <20230901031037.3314007-1-xukuohai@huaweicloud.com>
 <485647ed-e791-0781-afed-03c2d636a00b@iogearbox.net>
 <ee9ee99d-115a-f488-2de5-f402daa892a8@huawei.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <30dd8d7f-47f5-154b-25a4-ea2bb65d9235@iogearbox.net>
Date: Fri, 1 Sep 2023 11:38:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ee9ee99d-115a-f488-2de5-f402daa892a8@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27018/Fri Sep  1 09:45:38 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/1/23 10:38 AM, Xu Kuohai wrote:
> On 9/1/2023 4:22 PM, Daniel Borkmann wrote:
>> On 9/1/23 5:10 AM, Xu Kuohai wrote:
>>> From: Xu Kuohai <xukuohai@huawei.com>
[...]
>> Should the error path rather be ?
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> index 2d3bf38677b6..8df8cbb447f1 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c
>> @@ -1454,7 +1454,7 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
>>
>>          if (poll_connect(c, IO_TIMEOUT_SEC) < 0) {
>>                  FAIL_ERRNO("poll_connect");
>> -               goto close_cli;
>> +               goto close_acc;
>>          }
>>
>>          *v0 = p;
>> @@ -1462,6 +1462,8 @@ static int vsock_socketpair_connectible(int sotype, int *v0, int *v1)
>>
>>          return 0;
>>
>> +close_acc:
>> +       close(p);
>>   close_cli:
>>          close(c);
>>   close_srv:
>>
>>
>> Let me know and I'll squash this into the fix.
>>
> 
> Right, the accepted connection should be closed, thanks.

Ok, done, pushed.

