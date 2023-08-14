Return-Path: <bpf+bounces-7777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59F077C3EF
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 01:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D171C20C01
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 23:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E6AD2A;
	Mon, 14 Aug 2023 23:26:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97368A925
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 23:26:50 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A81BE;
	Mon, 14 Aug 2023 16:26:49 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EN3FYO029924;
	Mon, 14 Aug 2023 23:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LbOGZMmhNlVa4ttclSQNtMPwN4Io1A6KXK/1M1+rEYc=;
 b=UR2z69B7Lvy9Vs3FWl2PX62cWJxF93RykR98OH9jfrahT+junQisll8dKd7o3VraRuo7
 ewqCdTw2YfqgwTMk3g0o9J6uGSVE9DFfByQYGuT/p+H/nqAez6gkOYzjP87/j3q0UAmE
 89EvYiXG1YIQ3mb7G/FRfLY0lLogE8t8VfkkydAzCSoLIi5FU/usLvwj6dUvNMa0fNNE
 EGu43O0X1sGG2oi8kdfs8FCIt9eKlCGTGdJ/6OKS/w+QtiiNR7pdQdjP4UjcVAO3hsLS
 JenqCniFfxgtedyi7a8/Dsj53oyhrVEtyGej2hCfVC4MKvdZ5M/l/HqqTdNdGCxngXiV Eg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sfwkj0ech-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 23:26:39 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37EMpf77003495;
	Mon, 14 Aug 2023 23:26:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3semds8wr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Aug 2023 23:26:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37ENQaXd46924218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Aug 2023 23:26:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 404272004B;
	Mon, 14 Aug 2023 23:26:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C4820040;
	Mon, 14 Aug 2023 23:26:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Aug 2023 23:26:35 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id BBBF3602FC;
	Tue, 15 Aug 2023 09:26:30 +1000 (AEST)
Message-ID: <ab85e604-b7ba-dbbe-53c2-2454e145d829@linux.ibm.com>
Date: Tue, 15 Aug 2023 09:26:10 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/8] Documentation/sphinx: fix Python string escapes
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
        bpf@vger.kernel.org, linux-pm@vger.kernel.org
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com, jan.kiszka@siemens.com,
        kbingham@kernel.org, mykolal@fb.com
References: <20230814060704.79655-1-bgray@linux.ibm.com>
 <20230814060704.79655-3-bgray@linux.ibm.com> <87jztxwxtu.fsf@meer.lwn.net>
Content-Language: en-US, en-AU
From: Benjamin Gray <bgray@linux.ibm.com>
In-Reply-To: <87jztxwxtu.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fMeSr82h78OcmSFLpK5YKZdGHM_Cfxs6
X-Proofpoint-ORIG-GUID: fMeSr82h78OcmSFLpK5YKZdGHM_Cfxs6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 adultscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140211
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/8/23 11:35 pm, Jonathan Corbet wrote:
> Benjamin Gray <bgray@linux.ibm.com> writes:
> 
>> Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
>> This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
>> be a syntax error.
>>
>> Fix these now to get ahead of it before it's an error.
>>
>> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
>> ---
>>   Documentation/sphinx/cdomain.py             | 2 +-
>>   Documentation/sphinx/kernel_abi.py          | 2 +-
>>   Documentation/sphinx/kernel_feat.py         | 2 +-
>>   Documentation/sphinx/kerneldoc.py           | 2 +-
>>   Documentation/sphinx/maintainers_include.py | 8 ++++----
>>   5 files changed, 8 insertions(+), 8 deletions(-)
> 
> So I am the maintainer for this stuff...is there a reason you didn't
> copy me on this work?

Sorry, I thought the list linux-doc@vger.kernel.org itself was enough. I 
haven't done a cross tree series before, I was a bit adverse to CC'ing 
everyone that appears as a maintainer for every patch.

> 
>> diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
>> index ca8ac9e59ded..dbdc74bd0772 100644
>> --- a/Documentation/sphinx/cdomain.py
>> +++ b/Documentation/sphinx/cdomain.py
>> @@ -93,7 +93,7 @@ def markup_ctype_refs(match):
>>   #
>>   RE_expr = re.compile(r':c:(expr|texpr):`([^\`]+)`')
>>   def markup_c_expr(match):
>> -    return '\ ``' + match.group(2) + '``\ '
>> +    return '\\ ``' + match.group(2) + '``\\ '
> 
> I have to wonder about this one; I doubt the intent was to insert a
> literal backslash.  I have to fire up my ancient build environment to
> even try this, but even if it's right...

Yeah, there is even a file that just has a syntax error. I don't have a 
way to verify the original script was correct, but I have verified this 
series doesn't change the parsed AST.

In this case though, it's generating reST, so it might just be 
conservatively guarding against generating bad markup[1]

[1]: 
https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#inline-markup 


>>   #
>>   # Parse Sphinx 3.x C markups, replacing them by backward-compatible ones
>> diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
>> index b5feb5b1d905..b9f026f016fd 100644
>> --- a/Documentation/sphinx/kernel_abi.py
>> +++ b/Documentation/sphinx/kernel_abi.py
>> @@ -138,7 +138,7 @@ class KernelCmd(Directive):
>>                   code_block += "\n    " + l
>>               lines = code_block + "\n\n"
>>   
>> -        line_regex = re.compile("^\.\. LINENO (\S+)\#([0-9]+)$")
>> +        line_regex = re.compile("^\\.\\. LINENO (\\S+)\\#([0-9]+)$")
> 
> All of these really just want to be raw strings - a much more minimal
> fix that makes the result quite a bit more readable:
> 
>       line_regex = re.compile(r"^\.\. LINENO (\S+)\#([0-9]+)$")
>                               ^
>                               |
>    ---------------------------+
> 
> That, I think, is how these should be fixed.

Yup, I mentioned that at the end of the cover letter. I can automate and 
verify the conversion, but automating what _should_ be treated as a 
'regex' string is fuzzier. Checking if there's a `re.*(` prefix on the 
string should work for most though. I'll give it a shot.

> Thanks,
> 
> jon


