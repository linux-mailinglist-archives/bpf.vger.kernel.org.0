Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D07B148C79
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 17:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbgAXQsR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 11:48:17 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:58060 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbgAXQsR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 11:48:17 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iv27r-0006Gu-PM; Fri, 24 Jan 2020 16:48:08 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1iv27n-0005K8-Ga; Fri, 24 Jan 2020 16:48:06 +0000
Subject: Re: [PATCH] um: Fix some error handling in uml_vector_user_bpf()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel-janitors@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>, Alex Dewar <alex.dewar@gmx.co.uk>,
        bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
References: <20200124101450.jxfzsh6sz7v324hv@kili.mountain>
 <36070c96-8e75-7d06-d945-87a9d366d0b9@cambridgegreys.com>
 <20200124164427.GF1870@kadam>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <de3bdae8-2dcd-490f-cdf2-67bf92a552e8@cambridgegreys.com>
Date:   Fri, 24 Jan 2020 16:48:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200124164427.GF1870@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 24/01/2020 16:44, Dan Carpenter wrote:
> On Fri, Jan 24, 2020 at 12:52:18PM +0000, Anton Ivanov wrote:
>>
>>
>> On 24/01/2020 10:14, Dan Carpenter wrote:
>>> 1) The uml_vector_user_bpf() returns pointers so it should return NULL
>>>      instead of false.
>>> 2) If the "bpf_prog" allocation failed, it would have eventually lead to
>>>      a crash.  We can't succeed after the error happens so it should just
>>>      return.
>>>
>>> Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>>    arch/um/drivers/vector_user.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
>>> index ddcd917be0af..88483f5b034c 100644
>>> --- a/arch/um/drivers/vector_user.c
>>> +++ b/arch/um/drivers/vector_user.c
>>> @@ -732,13 +732,13 @@ void *uml_vector_user_bpf(char *filename)
>>>    	if (stat(filename, &statbuf) < 0) {
>>>    		printk(KERN_ERR "Error %d reading bpf file", -errno);
>>> -		return false;
>>> +		return NULL;
>>
>> I will sort this one out, thanks for noticing.
>>
>>>    	}
>>>    	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
>>> -	if (bpf_prog != NULL) {
>>> -		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
>>> -		bpf_prog->filter = NULL;
>>> -	}
>>> +	if (!pfg_prog)
>>
>> ^^^^^ ?
> 
> If we don't return here it leads to a NULL dereference.

It says pfg_prog

I cannot find this identifier :)

> 
> regards,
> dan carpenter
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
