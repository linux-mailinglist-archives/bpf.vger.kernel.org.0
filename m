Return-Path: <bpf+bounces-1252-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF8E71198E
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 23:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28BA1C20897
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 21:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E224EB2;
	Thu, 25 May 2023 21:51:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857220982
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 21:51:48 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F011E4F
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 14:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=dECQ+RJTBkkcbsjpB8UkTwJE0MU4h4v5Loc8Or2lkr4=; b=RSax9on9clSidZmvYuL4qAj5tP
	2MEp01SFKD5BAypLxvYWyupzxXOn9XHSxjuP8RfKyeSOLitISe3F6nCY6JCtmE+za73IIPNMxT8lg
	zR8TprfxP5LYPzV9KqRALvH1Nc4dN/RL3EibCNE8Rz9Y8+QHqE9tdHf1kt6gIN8uNukdqaUZ6u5f8
	stWZ0ekiYKTFvCAUPuA0TR26QAzgiV8qq5dumiLfJAbzqQ40e8EzsNXCRR9ChQCn3SYVF7FYZpPNw
	mrDqlT2Eue9dVzHQ6fdQN+eKyct+VFO0wuwlvkQpBUeOINaqLHxmjtkQ/y/TfBZuWeLYWjEc3DBhr
	gX4rFUYQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1q2Ire-000BjZ-0c; Thu, 25 May 2023 23:51:17 +0200
Received: from [178.197.248.42] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1q2Ird-000Gbp-EB; Thu, 25 May 2023 23:51:17 +0200
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: revamp bpf_attr and name each
 command's field and substruct
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@kernel.org, kernel-team@meta.com
References: <20230524210243.605832-1-andrii@kernel.org>
 <20230524210243.605832-2-andrii@kernel.org>
 <20230525031810.g42tmdk7ykjrkrcr@MacBook-Pro-8.local>
 <CAEf4Bzbe-D1PwWB7T4SCzNG3RKTMko_0h1TOiEmUrR22NPjfXg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <528341ba-45dd-7708-ae00-4f2d6551baa9@iogearbox.net>
Date: Thu, 25 May 2023 23:51:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEf4Bzbe-D1PwWB7T4SCzNG3RKTMko_0h1TOiEmUrR22NPjfXg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26918/Thu May 25 09:25:14 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 5/25/23 7:19 PM, Andrii Nakryiko wrote:
> On Wed, May 24, 2023 at 8:18 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> On Wed, May 24, 2023 at 02:02:41PM -0700, Andrii Nakryiko wrote:
>>>
>>> And there were a bunch of other similar changes. Please take a thorough
>>> look and suggest more changes or which changes to drop. I'm not married
>>> to any of them, it just felt like a good improvement.
>>
>> Agree that current layout sucks, but ...
>>
>>>   include/uapi/linux/bpf.h       | 235 +++++++++++++++++++++++++++------
>>>   kernel/bpf/syscall.c           |  40 +++---
>>>   tools/include/uapi/linux/bpf.h | 235 +++++++++++++++++++++++++++------
>>>   3 files changed, 405 insertions(+), 105 deletions(-)
>>
>> ... the diff makes it worse. The diffstat for "nop" change is a red flag.
> 
> Only 100 lines are a real "nop" change to copy/paste existing fields
> that are in unnamed fields. The rest is a value add.
> 
> I don't think the deal is in stats, though, right?
> 
>>> +     /*
>>> +      * LEGACY anonymous substructs, for backwards compatibility.
>>> +      * Each of the below anonymous substructs are ABI compatible with one
>>> +      * of the above named substructs. Please use named substructs.
>>> +      */
>>
>> All of them cannot be removed. This bagage will be a forever eyesore.
>> Currently it's not pretty. The diffs make uapi file just ugly.
>> Especially considering how 'named' and 'legacy' will start diverging.
> 
> We have to allow "divergence" (only in the sense that new fields only
> go into named substructs, but the existing fields stay fixed, of
> course), to avoid more naming conflicts. If that wasn't the case,
> using struct_group() macro could have been used to avoid a copy/paste
> of those anonymous field/struct copies.
> 
> So I'm not happy about those 100 lines copy paste of fixed fields
> either, but at least that would get us out of the current global
> naming namespace for PROG_LOAD, MAP_CREATE, BTF_LOAD, etc.
> 
>> New commands are thankfully named. We've learned the lesson,
> 
> Unfortunately, the problem is that unnamed commands are the ones that
> are most likely to keep evolving.
> 
>> but prior mistake is unfixable. We have to live with it.
> 
> Ok, too bad, but it's fine. It was worth a try.
> 
> I tried to come up with something like struct_group() approach to
> minimize code changes in UAPI header, but we have a more complicated
> situation where part of struct has to be both anonymous and named,
> while another part (newly added fields) should go only to named parts.
> And that doesn't seem to be possible to support with a macro,
> unfortunately.

Nice idea on the struct_group()-like approach, but agree that this is
going to be tough given we need to divert anonymous and named parts as
you mention. One other wild thought ... we remove the bpf_attr entirely
from the uapi header, and have a kernel/bpf/bpf.cmd description and
generate the bpf_attr into a uapi header via script which the main header
can include. Kind of similar to the suggestion, but more flexible than
macro magic. We also have things like syscall table header generated via
script.. so it wouldn't be first. Still doesn't remove the eyesore, just
packages it differently. ;/

Thanks,
Daniel

