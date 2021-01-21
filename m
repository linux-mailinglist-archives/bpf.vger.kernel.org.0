Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9322FF227
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 18:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbhAURkC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 12:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388679AbhAURjU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Jan 2021 12:39:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611250674;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o1FCC9aTTTpRBcA3pp6nQ37fIcYQdAIptoZQSIyVfbI=;
        b=WKrVfjEDWkFw4dHgOquQKfWxxLzD4O7p1SsSWfLnDkfhK+U4Y5TBQRfyvU6I1Greqy46OJ
        BiIr8TpxqX29h2jgRihA7OPrisy1dc1Hzurju7PIKHNbO7b+gZwtSD6XmE2Yk9GVIS6L4L
        lrjRvv++lX3osgG9iYPqBwu/oHPhrcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-ZwFYkS03PIq2IRgjQk-2gg-1; Thu, 21 Jan 2021 12:37:49 -0500
X-MC-Unique: ZwFYkS03PIq2IRgjQk-2gg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92DC4190B2A1;
        Thu, 21 Jan 2021 17:37:47 +0000 (UTC)
Received: from tstellar.remote.csb (ovpn-114-198.phx2.redhat.com [10.3.114.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA2239A60;
        Thu, 21 Jan 2021 17:37:46 +0000 (UTC)
Reply-To: tstellar@redhat.com
Subject: Re: [PATCH] btf_encoder: Add extra checks for symbol names
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210112184004.1302879-1-jolsa@kernel.org>
 <f3790a7d-73bc-d634-5994-d049c7a73eae@redhat.com>
 <20210121133825.GB12699@kernel.org>
From:   Tom Stellard <tstellar@redhat.com>
Organization: Red Hat
Message-ID: <9624a879-eed1-5f04-f205-71500f85e6b0@redhat.com>
Date:   Thu, 21 Jan 2021 09:37:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210121133825.GB12699@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/21/21 5:38 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 12, 2021 at 04:27:59PM -0800, Tom Stellard escreveu:
>> On 1/12/21 10:40 AM, Jiri Olsa wrote:
>>> When processing kernel image build by clang we can
>>> find some functions without the name, which causes
>>> pahole to segfault.
>>>
>>> Adding extra checks to make sure we always have
>>> function's name defined before using it.
>>>
>>
>> I backported this patch to pahole 1.19, and I can confirm it fixes the
>> segfault for me.
> 
> I'm applying v2 for this patch and based on your above statement I'm
> adding a:
> 
> Tested-by: Tom Stellard <tstellar@redhat.com>
> 
> Ok?
> 

Yes, this is fine.  I also backported the v2 patch and tested it and it
fixed the issue.

-Tom

> Who originally reported this?
> 
> - Arnaldo
>   
>> -Tom
>>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>    btf_encoder.c | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 333973054b61..17f7a14f2ef0 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -72,6 +72,8 @@ static int collect_function(struct btf_elf *btfe, GElf_Sym *sym)
>>>    	if (elf_sym__type(sym) != STT_FUNC)
>>>    		return 0;
>>> +	if (!elf_sym__name(sym, btfe->symtab))
>>> +		return 0;
>>>    	if (functions_cnt == functions_alloc) {
>>>    		functions_alloc = max(1000, functions_alloc * 3 / 2);
>>> @@ -730,9 +732,11 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>>>    		if (!has_arg_names(cu, &fn->proto))
>>>    			continue;
>>>    		if (functions_cnt) {
>>> -			struct elf_function *func;
>>> +			const char *name = function__name(fn, cu);
>>> +			struct elf_function *func = NULL;
>>> -			func = find_function(btfe, function__name(fn, cu));
>>> +			if (name)
>>> +				func = find_function(btfe, name);
>>>    			if (!func || func->generated)
>>>    				continue;
>>>    			func->generated = true;
>>>
>>
> 

