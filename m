Return-Path: <bpf+bounces-3829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85B74437D
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 22:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F08B1C20C27
	for <lists+bpf@lfdr.de>; Fri, 30 Jun 2023 20:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3620C17728;
	Fri, 30 Jun 2023 20:52:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EC816428
	for <bpf@vger.kernel.org>; Fri, 30 Jun 2023 20:52:36 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC6E3C2D;
	Fri, 30 Jun 2023 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BEH1BowktuuStjJyeH3e8YBBtNZC3SC1+Libjz6/Dj8=; b=lW574RdS0doFq42rK/UIqsZuRL
	WnNSsLX/ZVMsZR0EKjfqfSCl2t5qiZhecH2/EYVCOjhYmRV5kQf/HAsAWQdl+zUyfZ9BcnaYwfc9C
	a4qRCp6E4tXR7Lbf1Ho4+PPcjhKOABHUXIfm00XXYNYdXtF/utqBBIKsRn+3XJ1br8jDTtjodV2bn
	jGQatFCT9w6sAUZ4UISN1Y9AJ3RZao9xc+1e0pcpc18ePEWgOtCZRYZvw+jsUxUTalrJ42Y3W2Dtz
	EMcELk9+K75r84r+tLvOgeB7VjiPt1xc58k8PBVGHTnLa7IvPLwZAxKZajq+ljWyP7buvDZfKUSBW
	8e6ZbcMg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qFL6P-000Gji-5a; Fri, 30 Jun 2023 22:52:25 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qFL6O-000FsX-QE; Fri, 30 Jun 2023 22:52:24 +0200
Subject: Re: [PATCH v2] btf: warn but return no error for NULL btf from
 __register_btf_kfunc_id_set()
To: SeongJae Park <sj@kernel.org>
Cc: martin.lau@linux.dev, Alexander.Egorenkov@ibm.com, ast@kernel.org,
 memxor@gmail.com, olsajiri@gmail.com, bpf@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>
References: <20230630194859.100332-1-sj@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <75483b53-bd8e-692e-ed18-a4c87cf20a1b@iogearbox.net>
Date: Fri, 30 Jun 2023 22:52:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230630194859.100332-1-sj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26955/Fri Jun 30 09:29:09 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/30/23 9:48 PM, SeongJae Park wrote:
> On Fri, 30 Jun 2023 16:53:38 +0200 Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 6/28/23 6:46 PM, SeongJae Park wrote:
>>> __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
>>> .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
>>> the function prints an error message and return an error.  As a result,
>>> such modules cannot be loaded.
>>>
>>> However, the section could be stripped out during a build process.  It
>>> would be better to let the modules loaded, because their basic
>>> functionalities have no problem[1], though the BTF functionalities will
>>> not be supported.  Make the function to lower the level of the message
>>> from error to warn, and return no error.
>>>
>>> [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
>>>
>>> Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
>>> Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
>>> Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>>> Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
>>> Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
>>> Cc: <stable@vger.kernel.org> # 5.18.x
>>> Signed-off-by: SeongJae Park <sj@kernel.org>
>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>
>> I presume this one is targeted at bpf (rather than bpf-next) tree, right?
> 
> You're correct.  It's not urgent for us, but I would prefer it to be merged
> into all affected kernels as early as possible.

Ok, sounds good, bpf tree it is then.

>>> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
>>> index 6b682b8e4b50..d683f034996f 100644
>>> --- a/kernel/bpf/btf.c
>>> +++ b/kernel/bpf/btf.c
>>> @@ -7848,14 +7848,10 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
>>>    
>>>    	btf = btf_get_module_btf(kset->owner);
>>>    	if (!btf) {
>>> -		if (!kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) {
>>> -			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
>>> -			return -ENOENT;
>>> -		}
>>
>> Why the above one needs to be changed? Do you also run into this case? vmlinux BTF
>> should be built-in in this case. I understand it's rather the one below for BTF +
>> modules instead, no?
> 
> Again, you're correct.  This change is not really needed.  I was interpreting
> Kumar's suggestion merely into code without thinking about his real meaning,
> sorry.  I will restore this in the next spin.

Perfect, I think after your v3 respin it should be good to land.

Thanks,
Daniel

