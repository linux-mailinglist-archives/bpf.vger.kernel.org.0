Return-Path: <bpf+bounces-6526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C61EB76A8D4
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 08:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 022AB1C20D29
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 06:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA694A2C;
	Tue,  1 Aug 2023 06:17:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAF31110;
	Tue,  1 Aug 2023 06:17:39 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3331712A;
	Mon, 31 Jul 2023 23:17:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFPzH3K3cz4f3lXf;
	Tue,  1 Aug 2023 14:17:31 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP1 (Coremail) with SMTP id cCh0CgBXwSt9o8hkFLYAOg--.28678S2;
	Tue, 01 Aug 2023 14:17:34 +0800 (CST)
Message-ID: <22b5f668-d0cb-f127-0890-b0ca5c6a7370@huaweicloud.com>
Date: Tue, 1 Aug 2023 14:17:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH bpf] bpf, sockmap: Fix bug that strp_done cannot be called
Content-Language: en-US
To: John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>
References: <20230728105717.3978849-1-xukuohai@huaweicloud.com>
 <64c882442b8b0_a427920828@john.notmuch>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <64c882442b8b0_a427920828@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXwSt9o8hkFLYAOg--.28678S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1xCr13Gry3ZF13Aw17Awb_yoW5GF1UpF
	1kCay7CF48AFWxuasIqFySyw1agw48JF12kry8Ca43trsF9r1rGF98KF1jkFn8tr4kGF1x
	tr4jgFsIk3W7Xa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/1/2023 11:55 AM, John Fastabend wrote:
> Xu Kuohai wrote:
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> strp_done is only called when psock->progs.stream_parser is not NULL,
>> but stream_parser was set to NULL by sk_psock_stop_strp(), called
>> by sk_psock_drop() earlier. So, strp_done can never be called.
>>
>> Introduce SK_PSOCK_RX_ENABLED to mark whether there is strp on psock.
>> Change the condition for calling strp_done from judging whether
>> stream_parser is set to judging whether this flag is set. This flag is
>> only set once when strp_init() succeeds, and will never be cleared later.
>>
>> Fixes: c0d95d3380ee ("bpf, sockmap: Re-evaluate proto ops when psock is removed from sockmap")
>> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
>> ---
>>   include/linux/skmsg.h |  1 +
>>   net/core/skmsg.c      | 10 ++++++++--
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
>> index 054d7911bfc9..959c5f4c4d19 100644
>> --- a/include/linux/skmsg.h
>> +++ b/include/linux/skmsg.h
>> @@ -62,6 +62,7 @@ struct sk_psock_progs {
>>   
>>   enum sk_psock_state_bits {
>>   	SK_PSOCK_TX_ENABLED,
>> +	SK_PSOCK_RX_ENABLED,
> 
> small nit can be make this SK_PSOCK_RX_STRP_ENABLED? That way its
> explicit what we are talking about here.
>

OK, I'll rename it, thanks.

> Otherwise it looks good thanks nice catch.
> 
>>   };
>>   
>>   struct sk_psock_link {
>> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>> index a29508e1ff35..7c2764beeb04 100644
>> --- a/net/core/skmsg.c
>> +++ b/net/core/skmsg.c
>> @@ -1120,13 +1120,19 @@ static void sk_psock_strp_data_ready(struct sock *sk)
>>   
>>   int sk_psock_init_strp(struct sock *sk, struct sk_psock *psock)
>>   {
>> +	int ret;
>> +
>>   	static const struct strp_callbacks cb = {
>>   		.rcv_msg	= sk_psock_strp_read,
>>   		.read_sock_done	= sk_psock_strp_read_done,
>>   		.parse_msg	= sk_psock_strp_parse,
>>   	};
>>   
>> -	return strp_init(&psock->strp, sk, &cb);
>> +	ret = strp_init(&psock->strp, sk, &cb);
>> +	if (!ret)
>> +		sk_psock_set_state(psock, SK_PSOCK_RX_ENABLED);
>> +
>> +	return ret;
>>   }
>>   
>>   void sk_psock_start_strp(struct sock *sk, struct sk_psock *psock)
>> @@ -1154,7 +1160,7 @@ void sk_psock_stop_strp(struct sock *sk, struct sk_psock *psock)
>>   static void sk_psock_done_strp(struct sk_psock *psock)
>>   {
>>   	/* Parser has been stopped */
>> -	if (psock->progs.stream_parser)
>> +	if (sk_psock_test_state(psock, SK_PSOCK_RX_ENABLED))
>>   		strp_done(&psock->strp);
>>   }
>>   #else
>> -- 
>> 2.30.2
>>


