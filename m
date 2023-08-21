Return-Path: <bpf+bounces-8147-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8F7824DE
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 09:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5EE280EB0
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB31C11;
	Mon, 21 Aug 2023 07:50:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D36E1C03
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 07:50:39 +0000 (UTC)
X-Greylist: delayed 1383 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 00:50:38 PDT
Received: from www.kot-begemot.co.uk (ns1.kot-begemot.co.uk [217.160.28.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F43392;
	Mon, 21 Aug 2023 00:50:38 -0700 (PDT)
Received: from 212-39-89-85.ip.btc-net.bg ([212.39.89.85] helo=[192.168.14.227])
	by www.kot-begemot.co.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qXzJj-001Ag5-3l; Mon, 21 Aug 2023 07:27:15 +0000
Message-ID: <02404242-ab8a-5300-ec76-fb13dc3fb403@cambridgegreys.com>
Date: Mon, 21 Aug 2023 08:27:12 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4] um: vector: Fix exception handling in
 vector_eth_configure()
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>, Minjie Du <duminjie@vivo.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
 opensource kernel <opensource.kernel@vivo.com>
References: <20230706013911.695-1-duminjie@vivo.com>
 <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <888265629.6490567.1692478887611.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 19/08/2023 22:01, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
>> The resource cleanup was incomplete in the implementation
>> of the function "vector_eth_configure".
>> Thus replace the jump target
>> "out_undo_user_init" by "out_free_netdev".
>> Delate the orphan function "out_undo_user_init"
>>
>> PATCH v1-v3: Modify the patch format.
>>
>> Signed-off-by: Minjie Du <duminjie@vivo.com>
>> ---
>> arch/um/drivers/vector_kern.c | 4 +---
>> 1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
>> index 131b7cb29..7ae6ab8df 100644
>> --- a/arch/um/drivers/vector_kern.c
>> +++ b/arch/um/drivers/vector_kern.c
>> @@ -1646,7 +1646,7 @@ static void vector_eth_configure(
>> 	err = register_netdevice(dev);
>> 	rtnl_unlock();
>> 	if (err)
>> -		goto out_undo_user_init;
>> +		goto out_free_netdev;
>>
>> 	spin_lock(&vector_devices_lock);
>> 	list_add(&device->list, &vector_devices);
>> @@ -1654,8 +1654,6 @@ static void vector_eth_configure(
>>
>> 	return;
>>
>> -out_undo_user_init:
>> -	return;
> 
> I don't think this is correct.
> vector_eth_configure() cannot communicate the failure since it is of type void.
> So, vector_remove() will run and will call unregister_netdev(). That can cause a double-free.

vector_remove() will be called only once per device. It checks if the 
device is in the device list and if it is not - bails. If it is in the 
list it removes it from there and calls unregister_netdev() after that.

So, unless I am missing something, there is no harm here - unregister 
will not be called for a device that failed to register, because the 
list is updated only if the device has registered successfully.

However, on second read - if register fails, the current code leaks a 
*device which was alloc-ed in the beginning of configure. So even if we 
skip free_netdev, which invokes remove we still need to free that *device.

> 
> Thanks,
> //richard
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

