Return-Path: <bpf+bounces-2404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0B372C97C
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600421C20A61
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 15:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DF01C77C;
	Mon, 12 Jun 2023 15:14:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49E019511
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 15:14:00 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B318F
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 08:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FdmdFmO8c/jAv79q4Hel9ETQKm0x696dp8emycEt6bg=; b=Ix4VVrymbiDEMlPlEK40KTNFlo
	q/T4qHuQbFjFszFhOkVqqibloTDGtWXwA3oOdVVp98qO1fa2hHXj8rvxL8fL1nnaitkl4jdIx3fVu
	dTwpG1JqBEc4S6lxEWnnOgbFJXTsXQIW6UrgZl3Lw3OwUWqR0ySidFx6MG4ykwTXzf2NGAGRHraRP
	qeyG3CQCRwvi6GSOcx2erX4HaDkUR0gAkx0b4Q1bjnZ7KL1mU1nBgzSs1THQpri1YCpUcFYw3aA9s
	KdWgiadPEg/X1sGepH830J3fpJIRV5BLEntLRg5ttpgd7MhGmoA1kNqpBSU6zY4s/piYoD3ulRgW+
	RFUX/Hbw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8jEy-000FV4-E7; Mon, 12 Jun 2023 17:13:56 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q8jEy-000TSZ-3N; Mon, 12 Jun 2023 17:13:56 +0200
Subject: Re: [PATCH bpf-next v1] selftests/bpf: fix invalid pointer check in
 get_xlated_program()
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, martin.lau@linux.dev, kernel-team@fb.com, yhs@fb.com,
 dan.carpenter@linaro.org
References: <20230609221637.2631800-1-eddyz87@gmail.com>
 <4f9f4242-6943-5305-20d5-0270aaf506ed@iogearbox.net>
 <b1936c02fbda2ddc0b266d28b5de5c4aacbba191.camel@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c690cfad-544b-1d96-3675-9f6b32c99ec5@iogearbox.net>
Date: Mon, 12 Jun 2023 17:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b1936c02fbda2ddc0b266d28b5de5c4aacbba191.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26937/Mon Jun 12 09:24:05 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/12/23 5:05 PM, Eduard Zingerman wrote:
> On Mon, 2023-06-12 at 17:00 +0200, Daniel Borkmann wrote:
>> On 6/10/23 12:16 AM, Eduard Zingerman wrote:
>>> Dan Carpenter reported invalid check for calloc() result in
>>> test_verifier.c:get_xlated_program():
>>>
>>>     ./tools/testing/selftests/bpf/test_verifier.c:1365 get_xlated_program()
>>>     warn: variable dereferenced before check 'buf' (see line 1364)
>>>
>>>     ./tools/testing/selftests/bpf/test_verifier.c
>>>       1363		*cnt = xlated_prog_len / buf_element_size;
>>>       1364		*buf = calloc(*cnt, buf_element_size);
>>>       1365		if (!buf) {
>>>
>>>     This should be if (!*buf) {
>>>
>>>       1366			perror("can't allocate xlated program buffer");
>>>       1367			return -ENOMEM;
>>>
>>> This commit refactors the get_xlated_program() to avoid using double
>>> pointer type.
>>
>> Isn't the small reported fix above sufficient? (Either is fine with me though.)
> 
> I think it is less prone to mechanical mistakes without double pointers
> (in case if this function would be modified sometimes in the future).

Ok.

> But I can rollback to a small fix if you insist.
> 
>>> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> Closes: https://lore.kernel.org/bpf/ZH7u0hEGVB4MjGZq@moroto/
>>> Fixes: 933ff53191eb ("selftests/bpf: specify expected instructions in test_verifier tests")
>>> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>>> ---
>>>    tools/testing/selftests/bpf/test_verifier.c | 26 ++++++++++++---------
>>>    1 file changed, 15 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
>>> index 71704a38cac3..c6bc9e26d333 100644
>>> --- a/tools/testing/selftests/bpf/test_verifier.c
>>> +++ b/tools/testing/selftests/bpf/test_verifier.c
>>> @@ -1341,45 +1341,48 @@ static bool cmp_str_seq(const char *log, const char *exp)
>>>    	return true;
>>>    }
>>>    
>>> -static int get_xlated_program(int fd_prog, struct bpf_insn **buf, int *cnt)
>>> +static struct bpf_insn *get_xlated_program(int fd_prog, int *cnt)
>>>    {
>>>    	struct bpf_prog_info info = {};
>>>    	__u32 info_len = sizeof(info);
>>> +	__u32 buf_element_size;
>>>    	__u32 xlated_prog_len;
>>> -	__u32 buf_element_size = sizeof(struct bpf_insn);
>>> +	struct bpf_insn *buf;
>>> +
>>> +	buf_element_size = sizeof(struct bpf_insn);
>>
>> Just small nit: the `__u32 buf_element_size = sizeof(struct bpf_insn);` could have
>> stayed as is.
> 
> Moved it to have "inverse Christmas tree" for declarations,
> can send V2 undoing this.

Nah, it's fine. Fixed up while applying. Thanks!

