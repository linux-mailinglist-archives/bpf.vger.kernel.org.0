Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BC82147E2
	for <lists+bpf@lfdr.de>; Sat,  4 Jul 2020 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgGDSPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Jul 2020 14:15:52 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:12462 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgGDSPw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 4 Jul 2020 14:15:52 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 064I9Z4U031816;
        Sat, 4 Jul 2020 11:15:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=roeP4qzrW23j41i1QWV++bbHQP3cxqWq77ewGXIh5N4=;
 b=OlJdEkn9yE7xmDXeA5ZTCJFuDkkV+Q4l6STYQehgDBhrGWHrSR1+tAIvohfK3ROsFTq4
 RmF+oVWF8XbD5SPg+j4Wka5erVc/bZ1LDwdJuDTcRlwpnqQltE3wJgCni5btaJmRWvNl
 2EqxHgqMHWFKX39VLN1tyt/uTOzV8pXiv4M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 322s2u8yk3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 04 Jul 2020 11:15:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 4 Jul 2020 11:15:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls/aTqBPk+1NLysbO6peDZO/zxB6RDICJd5dC/U0la1f1DL7KYscVDCzreTPQ50IG58aG7TpgPCoNmkaGQkaHffcWLPjwhJbIz+19W4Fv2DwsBLYnqUFHjU8E37s7jeufOH3zAoL+OHboU/CvxkS4TYYlAsSdqKCyeZ/hHiqzpuktVkEARIfkv5HQZ31bYeWqhich4awv/4zq8fcc7tYY09ySBn2mUkb9YTk+6/52UMj/PXnWIp0TPhopYopBWudh6iO4JXZX7EW64O7mPvx444GWJc7K5WtaNgL/8hkI4EzRcu0VI8uwpZDetbeRt8w2eS+zEKMNSXcSmIx9gunEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roeP4qzrW23j41i1QWV++bbHQP3cxqWq77ewGXIh5N4=;
 b=g4yDfSF+KgMqHQ0jgSWujmaN0o/2lDdpmRT16IMfk3E/Q2u1OUZmHW+c2Cn/R/lirY83LACdF39AyM1uopJbUGaGKSMLs8MXq54IB7z+jBRkKpOxA+cTuxMkCaV7jzj3L96VpsCVnsDd7rTFFHwIrs5EvouVhUfTex3I96X/M856tCex5AyP8fIkecGJLggSMzZIqfTq4QaywgtFhNp79e2pLuWIPYpJjACNkCRAbRrdCAHPmZt9zneC4YeaSkyc6xxHudjhYQ4FfRE0DT0+QmyObzi/a7wb8C/LbH3L+p2CDqyAMBXWLvAVR4I0v59wJBe5jJ512LOBht4Und1EGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roeP4qzrW23j41i1QWV++bbHQP3cxqWq77ewGXIh5N4=;
 b=RbqyM1TYNvyVFW3mT3HheeqC7evZHiSJrb6voAbR4ZwsE5agyLKYiWLyXICv0GKbJGPH8Blfc0fr0LK/j9SEvcotIXro/aqiG/LpLbD+40NNuJ8sXpBgEmI0E87ROzzDmKXW9CEUSAVYD5T8QWocAFNb228sIFa/pfXGK4WYv78=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3413.namprd15.prod.outlook.com (2603:10b6:a03:10b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Sat, 4 Jul
 2020 18:15:18 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3153.029; Sat, 4 Jul 2020
 18:15:18 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: test_progs use another shell exit
 on non-actions
To:     Jesper Dangaard Brouer <brouer@redhat.com>
CC:     <bpf@vger.kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Hangbin Liu <haliu@redhat.com>,
        Daniel Borkmann <borkmann@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <vkabatov@redhat.com>, <jbenc@redhat.com>
References: <20200702154728.6700e790@carbon>
 <159371277981.942611.89883359210042038.stgit@firesoul>
 <7b3f6c32-78e9-69fe-1f49-7065149e943e@fb.com>
 <20200703135923.5bf3e521@carbon>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1eb06f3c-188e-b9ae-aa5d-58bf0fc831d1@fb.com>
Date:   Sat, 4 Jul 2020 11:15:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
In-Reply-To: <20200703135923.5bf3e521@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::29) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::106a] (2620:10d:c090:400::5:aacf) by BYAPR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:c0::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.12 via Frontend Transport; Sat, 4 Jul 2020 18:15:17 +0000
X-Originating-IP: [2620:10d:c090:400::5:aacf]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5251e752-4aed-4cd2-3422-08d82046350b
X-MS-TrafficTypeDiagnostic: BYAPR15MB3413:
X-Microsoft-Antispam-PRVS: <BYAPR15MB34138C9B5531A96828E09305D36B0@BYAPR15MB3413.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 0454444834
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUrjXHtVeDbbSQJh/45XwSo9QFSaTKvQBWWtkISdSKi5XrI8ev+3PJAwVGbsw/bfGrGVnaorMT14dEzCyZb4CZ/daO/0VBut3kQQP6vsAqSuLIQKwVmokAMwk0inoF9NjXQKSLFMT5Lx4yHslpbubZ9EZOzL4w2A9l4I+pCDsy1Nyw728ZfajrDRSJpEnMFu53z+okgMKegVIW4Scy66BoLJDyzEt+Z9xoT3YVu2eb4itDFDVsRmzCFHwGCyztC6h9GJJl+04janyocpfCoVNWh14yQGQ3xjGEQFOeTMfabQXQM7RJ0zGfCdJJ5Lisfmt9l+sK4u+4gvwhg2oULPDEjNVZSMSRhIRlkTcEosKf8zl75YpfXW+WdOSwj6Q/uH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(366004)(396003)(376002)(39860400002)(478600001)(6486002)(66946007)(66556008)(2906002)(36756003)(66476007)(16526019)(6666004)(186003)(4326008)(52116002)(8936002)(86362001)(8676002)(54906003)(31696002)(316002)(31686004)(83380400001)(53546011)(6916009)(5660300002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lRZLEVgqoYVUx6s+OZVndT+W2BrBOVoTuyznSwW9GsMJKaIUFmT0lxrqq5nBzDqfSp1IdvIoqWHpcnVrug+BjzE301sAKkdRx0stcYu1NOhU8JhciQdhfEaAemOnfLA8b0WO6+Kk5dM+RxoUV4Y0c8Tebhc/eotnDnO5vyzZ4+XJcln+F3vJqId4iF52STXB37jEKpDBeZUMvulQhsl9HBCzJeFvcyW9eQx4HnU7rcMnxbHqjCKMjV7ydaSVcFtAc8FeosXs40N3rcsQEktwjgm8vimyxYpy7C4zY9InP3AovQ+LpAjbBcyHXxuehciBVWCLnfHKCNlj1tJFXxjEfKHT3ExzIDxAsk1PfA1sQ13raONOn7fpMvw+lcUNGGCeAKhzXNHSn4sgpf8Ze9L/6b1UpQ0AIvvOnt0AgGY29v+OsjmQwTI2u64SNRQz5QRoYOqrUGY0ctTAHBxGQPgmcEwCdaQ364QsqNyKTnLFWFEzT++ur5+UGO0YsTaQuUAJS2WNfAuj5rKUsFTQB+gPJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5251e752-4aed-4cd2-3422-08d82046350b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2020 18:15:18.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWdNmC9AqihfK4bJ5zdrfGejo1LGQx6vXYp271JLOtzPkiIot7dnMosc72/oKmSy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3413
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-04_15:2020-07-02,2020-07-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 cotscore=-2147483648 bulkscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2007040127
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/3/20 4:59 AM, Jesper Dangaard Brouer wrote:
> On Thu, 2 Jul 2020 14:24:14 -0700
> Yonghong Song <yhs@fb.com> wrote:
> 
>> On 7/2/20 10:59 AM, Jesper Dangaard Brouer wrote:
>>> This is a follow up adjustment to commit 6c92bd5cd465 ("selftests/bpf:
>>> Test_progs indicate to shell on non-actions"), that returns shell exit
>>> indication EXIT_FAILURE (value 1) when user selects a non-existing test.
>>>
>>> The problem with using EXIT_FAILURE is that a shell script cannot tell
>>> the difference between a non-existing test and the test failing.
>>>
>>> This patch uses value 2 as shell exit indication.
>>> (Aside note unrecognized option parameters use value 64).
>>>
>>> Fixes: 6c92bd5cd465 ("selftests/bpf: Test_progs indicate to shell on non-actions")
>>> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
>>> ---
>>>    tools/testing/selftests/bpf/test_progs.c |    4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>>> index 104e833d0087..e8f7cd5dbae4 100644
>>> --- a/tools/testing/selftests/bpf/test_progs.c
>>> +++ b/tools/testing/selftests/bpf/test_progs.c
>>> @@ -12,6 +12,8 @@
>>>    #include <string.h>
>>>    #include <execinfo.h> /* backtrace */
>>>    
>>> +#define EXIT_NO_TEST 2
>>
>> How do you ensure this won't collide with other exit code
>> from other library functions (e.g., error code 64 is used
>> for unrecognized option which I have no idea what 64 means)?
> 
> I expect 64 comes from: /usr/include/sysexits.h
>   #define EX_USAGE        64      /* command line usage error */

Thanks for the pointer.

> 
> 
>> Maybe -2 for the exit code?
> 
> No. The process's exit status must be a number between 0 and 255, as
> defined in man exit(3). (run: 'man 3 exit' as there are many manpages
> named exit).

Yes, if user app exits with -2, it actually prints 254, -1 for 255...

> 
> But don't use above 127, because that is usually used for indicating
> signals.  E.g. 139 means 11=SIGSEGV $((139 & 127))=11.  POSIX defines
> in man wait(3p) check WIFSIGNALED(STATUS) and WTERMSIG(139)=11.
> (Hint: cmd 'kill -l' list signals and their numbers).
> 
> I bring up Segmentation fault explicitly, as we are seeing these happen
> with different tests (that are part of test_progs).  CI people writing
> these shell-scripts could pickup these hints and report them, if that
> makes sense.

Make sense to use from 1 - 127 range for normal exit.

> 
> 
>> test_progs already uses -1.
> 
> Well that is a bug then.  This will be seen by the shell (parent
> process) as 255.

I think previously people may just check test_progs return 0 or non-0.
Since here you will try to check different error return code, It makes
sense to do an audit to explicitly define all return values. So this
way, tools can have a reliable way to check exit code.

> 
>   
>>> +
>>>    /* defined in test_progs.h */
>>>    struct test_env env = {};
>>>    
>>> @@ -740,7 +742,7 @@ int main(int argc, char **argv)
>>>    	close(env.saved_netns_fd);
>>>    
>>>    	if (env.succ_cnt + env.fail_cnt + env.skip_cnt == 0)
>>> -		return EXIT_FAILURE;
>>> +		return EXIT_NO_TEST;
>>>    
>>>    	return env.fail_cnt ? EXIT_FAILURE : EXIT_SUCCESS;
>>>    }
>>>
> 
