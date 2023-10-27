Return-Path: <bpf+bounces-13417-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 075CA7D973E
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 14:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A3E3B213D4
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05E19463;
	Fri, 27 Oct 2023 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xl6VbKP7"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7887118E35
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 12:07:41 +0000 (UTC)
X-Greylist: delayed 44959 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 05:07:39 PDT
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BEFC0
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 05:07:39 -0700 (PDT)
Message-ID: <fc71a5f2-20e2-49f8-a954-581c877a0f09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1698408457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sa/vSZFE5gvOkYAuZ3jHdlVx2bGcbqIPjTph2eNpnOY=;
	b=Xl6VbKP70G0wDRXGDda7jxFskC9XNzrTdjs184AUMo+eK+dmdxA0bk0LXOF6B09u9Beqth
	pAwykwYZeeUFHi8uN4PK0enSORRN0OtziHkH9nhPJ6YkDXQJ9ku1l04M5JJacG5y70SKSk
	5M3NPb0bh4kVk2WLyLM0bjHC/fjHvSs=
Date: Fri, 27 Oct 2023 13:07:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: add skcipher API support to TC/XDP
 programs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Vadim Fedorenko <vadfed@meta.com>, Mykola Lysenko <mykolal@fb.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20231026015938.276743-1-vadfed@meta.com>
 <20231026144759.5ce20f4c@kernel.org>
 <a10cdab4-ab67-1cd2-0827-52c3755a464f@linux.dev>
 <20231026183509.471af050@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231026183509.471af050@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27/10/2023 02:35, Jakub Kicinski wrote:
> On Fri, 27 Oct 2023 00:29:29 +0100 Vadim Fedorenko wrote:
>>> Does anything prevent them from being used simultaneously
>>> by difference CPUs?
>>
>> The algorithm configuration and the key can be used by different CPUs
>> simultaneously
> 
> Makes sense, got confused ctx vs req. You allocate req on the fly.
> 
>>>> +	case BPF_DYNPTR_TYPE_SKB:
>>>> +		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
>>>
>>> dynptr takes care of checking if skb can be written to?
>>
>> dynptr is used to take care of size checking, but this particular part is used
>> to provide plain buffer from skb. I'm really sure if we can (or should) encrypt
>> or decrypt in-place, so API now assumes that src and dst are different buffers.
> 
> Not sure this answers my question. What I'm asking is basically whether
> for destination we need to call __bpf_dynptr_is_rdonly() or something
> already checks that.

ah, good point. I'm not sure how to make it better. the
__bpf_dynptr_data_ptr() code is based on bpf_dynptr_slice() which has
bpf_dynptr_slice_rdwr() variant. I don't think it's good idea to add
local rdwr variant. I can either add 2 parameter to force checking if
dynptr isn't read-only, or I can convert bpf_dynptr_slice* functions to
be wrappers over __bpf_dynptr_slice and reuse it in this code.

