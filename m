Return-Path: <bpf+bounces-11020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556A47B1704
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 1072D281E60
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 09:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C934183;
	Thu, 28 Sep 2023 09:19:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC90339AE
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 09:19:26 +0000 (UTC)
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D61FC0
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 02:19:24 -0700 (PDT)
Received: from pps.filterd (m0166259.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38S8j6ZH022554;
	Thu, 28 Sep 2023 09:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=campusrelays;
 bh=eXWuEEnrEZfN1s0P/HpCRsOv5Zg4cDitrbB62lu2OTc=;
 b=Aj4/zMUSNmAa/2gLppHYmjF5EAT8xsDI2Ymyx4ugyrzU9DrgpI84p8rQSUejjOsbWWV/
 JVbKqrJBvN/DGMBVJ1Jy4lj5C9EX6jc6pdPCFjN70jRxujwbXCV3taZjf3qT/zNNJEa1
 lgrxvH/GA4miKlXca0IEfxhijmAR4edPzPFy+1ErCpXVVAqQki/JeEEV7vuPw+oPBU2i
 +/1J+JKUB6h/ya8QHo4TlGJ699X1mr66Xa48YMOxPK6IdSsRVoRSnag6govpe8sr0glh
 e36+PUGqx3huqzPo0Tx696iY2RyQOesy4YzMTf9HLEuQiVEBS0g40kO2ZEy6nZIa9AWW UQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 3tc79dk8a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Sep 2023 09:19:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5Zr+R0UMRDYIPnlDxr/otVpLiHA8ZFNWl/dgrq988jxwGuCpLtOdoYOwwSHzvadZOfdSu/oSF1FkV8e49zjl4U28uOPPMX3LSu8R+i+6pSGkIfCT0Lmqj8Y444ipf7YbqXIC1Ybzuh7fP9da93pTwMAGbcQKJi+xp1C1e2V9vuqzvKewnhMxVjFQiuXOZ6c88DF/yWClSIWB0YP7IgpCxo+81m5s0WbAcItP/x8Wgz+qDStMpGP8wVleyt7kkNMxZq0/X34dbixjiyU+8vkXdul82AxzZc7ypE+/Uzos5p0At2n9e03YttzpF5aBy+MaKCFltgcVTFPbNghsTkM5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXWuEEnrEZfN1s0P/HpCRsOv5Zg4cDitrbB62lu2OTc=;
 b=EfqtiNA6XwEpay5MsLoqBeGAIoHxTSy9tl2p7HHe/BV2qoqJ1JphMC6xbVrCtSquT9yBmdGs95GAjD6PWUfIXa58B1AoSmBLdA8eUaUUWJeglECOhYDrPpG6Gr9o/JdrtZivcUrU96c5bs3WZmVNj1uOyzvrtwOdEZk5ZaTYQPB3fwfEliI5gfCYZzpkQcSYfP6NGgkR+CNDnwXOl5PyoG+qN/M+lqHLMalIJ43YVxvcQHXAH0nHDFpm0bP8Lr+3j4EYOp5L0jGJfBJPfPjJLE47eYcuInM/8E+wX2n1lao3JlewG696TX6DTzeY+s6Cq1fRsUem7/bwWuIm/OiW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by CH3PR11MB7867.namprd11.prod.outlook.com (2603:10b6:610:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Thu, 28 Sep
 2023 09:19:04 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::c1d3:e5a9:2ce5:df9f]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::c1d3:e5a9:2ce5:df9f%7]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 09:19:03 +0000
Message-ID: <299340fa-a7dc-4b56-8f5e-da058b343386@illinois.edu>
Date: Thu, 28 Sep 2023 04:19:02 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/1] samples/bpf: Add -fsanitize=bounds to
 userspace programs
Content-Language: en-US
To: Jiri Olsa <olsajiri@gmail.com>, ruowenq2@illinois.edu
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, keescook@chromium.org,
        Mimi Zohar <zohar@linux.ibm.com>, Jinghao Jia <jinghao@linux.ibm.com>
References: <20230927045030.224548-1-ruowenq2@illinois.edu>
 <20230927045030.224548-2-ruowenq2@illinois.edu> <ZRQMASduySxE+TO2@krava>
 <ed2a63a4-434c-4cf7-ad27-c17f75bbdf84@illinois.edu> <ZRU2M3wlFDpljnZq@krava>
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <ZRU2M3wlFDpljnZq@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0039.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::21) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|CH3PR11MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: 220768a9-f6dc-44ef-c4bd-08dbc003f548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0h/UMCKIIoPa0Dxsm3VjVgRbxq4F0PcI6h+fvRpe1wTTpL0cHjyqTOwYnnF6rYnIxm/1MFDKEG/nXvdO5aBfNZ/HDFy1y/ov7sSUxpOATRsfsZhrFv9KX3ZTMwCJCJByQsO2BtAEzaWsKtlFWjGbQuQmnhLZGLkW19U6mBuFAKFGnaaBwG3woCBw1nDt+K+V1N6ThUup3d9RUFEgxL0K3mI/J8ewNXc/Ec5QjRB2aaN6pIVivp4mO6VkcCBTbcFxK77dym42QHK+AjVPZxL6TUjAIM4HLdTg6YC8dYb3omD8zNCNgaLHqChMgk28tEekPJcvYmo064knkNtb1b7xQ4I+/oEWrkiIaMf4PJbgeLVkMcK9pwMfWeisZLOXlCjy9bJBzWzCbz0lScNU90+EV2B5LRVTuVAyW0KxjI0BEPTXnzRnqveuxcBPdmv4tWmklKs6roMCbz6nL1/EW1NG4+B+dHRhlFcmOZmY2fC6zPyPvgHZBmsZ/cn32neJWlR/Jg7pGOaixtOupW2oTF6nLNek1tfIRYE33QcDLSlNmU0tc3ednK8LzDHG1r/l0drA52BoNga80O0P5DpQDiMlcXwgkX3b/p709FYBuwNHzGuMpp4GWPRPt5WCngl/0ZuEgeai+IN+FqB2jKX00lF2MA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(366004)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(6512007)(41300700001)(2906002)(4326008)(66946007)(54906003)(316002)(786003)(6636002)(66476007)(66556008)(6506007)(478600001)(6486002)(53546011)(2616005)(83380400001)(26005)(5660300002)(8936002)(8676002)(38100700002)(75432002)(86362001)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RUJtaVRWK2NEVkViZm16dm9kRi82NVNLRE9aSldsYVdIZ1NRRnRwaFY2NUYw?=
 =?utf-8?B?eFV5QWhtM3NsOVVFMklNMDZZakJpUnNnR0k5Tmo4NFBwT1p1ek42V3l1R2J0?=
 =?utf-8?B?WTI5RmJOUEFnSGlNcWNwTENGdHdRV1Y0Vk9EbXhYWW1EbWNLbG4wNlpaeTJY?=
 =?utf-8?B?WDFoTDFwRnB3dTcrbmJySmxXNjNYUnB6SldVZ0I3YTJUMld5RDRTTHZrVldF?=
 =?utf-8?B?aFRPK0FJUFJZYmJaZTZ6MkltaTd1TitsQTljY2NUK1p5UXRRbE5qMDdBOUk5?=
 =?utf-8?B?MWpUa3VENlM1NDNGd21mZXNoL01qSy9hN3JNVmRlZFFqSEZmS2t5UVRKQWd2?=
 =?utf-8?B?eXZGZDlnQ0JUNzVXbHFCUFhVMW1aOFF4WHVQekNBeTdrOC9WQU1DeFdKUDZK?=
 =?utf-8?B?UkdGUGk0VzVlaXR2SC9kSXRxak1mcjV1d2FXN0hKQUFDT3NyUnNQWVN0UVZR?=
 =?utf-8?B?bWxZbHpya3p0WHE2LzFCTTllbEdqL0VsQ2FVcVVvUjV6c05ER0h2cERrME9W?=
 =?utf-8?B?OVJHY29sTnNOVWxUQ1pQdWZ2WWJDa1Y2c0xoN0NIODJ3R0x2L2lnNkgzbTBE?=
 =?utf-8?B?ajV3WnczdXQ5VU8reGc2cUhjMVhPK0tJUU03VjNhUktmbzdhTzRFL0J6UWVz?=
 =?utf-8?B?L2EvVEQvczhVREMyUUwwcFNLS1UvcEwvako2SEFhN2ZiUlpnYjFlTG9jTXF3?=
 =?utf-8?B?aU9lM0JKVEEyR2x6VzZpRUxyN2hzWXE2Nld1K0RhTVF6RndRRjQ3K2MrbExu?=
 =?utf-8?B?bFB2UnhsTGJXc2NuUnprODhEcXVUM1Z6MkF0dlkrVnQyWU5hYjQrK2RzdXFl?=
 =?utf-8?B?bzYxRkdyTHBpa05aTXlBVGNud3lUMXQ5T1ZLYzlBQ2I1MU9kcld4QUMxazVP?=
 =?utf-8?B?Y05SaVFENEVkQUFZK1dBdm53ME11VjZBa2NaS1RtbERVLzl5L1BQYjFoMnhu?=
 =?utf-8?B?MXRFek1QODBuTjJEYnVIQVJ6a2xGTW1FOXdmekJGRGU4WFdjVFhDdmx1V0p4?=
 =?utf-8?B?L2hXWEhMdlNrYXFHVjVNbUhUb1R3Q296WjVVUWczUm9XamJCT1BLWi9mejB0?=
 =?utf-8?B?OXFJZXhra05hSWRmcHZNTzQzWnNoblBTYU15M2tsN2htMkQ0a2dTK01GRTJS?=
 =?utf-8?B?V2I0aWFXcUI4TGl0K2hmNFFrTkZHZVhHOFlHLzJtUU1leEZ0UHFFeTVoY2dH?=
 =?utf-8?B?a0UyRUNlZElKL2h3MGVEbGxXSmFDTFN0THY1Umo4ODFsYzZjNGI3eW10cmtV?=
 =?utf-8?B?Z0pqZFh2aHBGK0lYTmxRMFZaT3FZZEdBMU1nUFFGZXZnZFJBRUh1a1F0cFFB?=
 =?utf-8?B?S2lVdEZZZllLZ0VzM2VQNEFPbk1XWFI4T3ByNWdGRW1qeG96LzhHVU8wWllm?=
 =?utf-8?B?YWEwUTE2Nm1wZnRvaVBWREc2eE1PMEc1TnQ2QzVzQlJHclRQNkhnWmVRaFRp?=
 =?utf-8?B?dEZFekF3ZnVaQmlsRkF0QTlUQndnV1VRWlBWdk5VR2dYM3dMbVFxN3VkVjdS?=
 =?utf-8?B?M2ZrVWhXbUR3dFN5VkJKd0t1Y3NvWXNPckFVOXhzYUJucXdrL3VVYWhDcnQ0?=
 =?utf-8?B?ajF3RFFkcUZzR3l4c0FvK29lOFlxUC81RzQ1dk1ETWVNeHZBSlhKc0VPWkhF?=
 =?utf-8?B?eS9GWXpNRGNnS1NHcFB0MHV6Um95emZHS3FDSkZyb1NLcG1HRHBhb0oxcnFn?=
 =?utf-8?B?YzdKOXg2RDZBMlZTdXovc21GOTh5T05sMDRVU09jSWRPLzZxM2NqVWI2MFh2?=
 =?utf-8?B?OGYvVUtTSGRGZWI5Y0l3N2k5RTAvZ2c4aG95cFpUNEd4d2h4Q0tNWk1JR2g0?=
 =?utf-8?B?aW85NHc5TFpSZjRaK0lYUnlpR21zOWF0K1QzNEI5RFcvZ1RldXJ4Qllhelhu?=
 =?utf-8?B?ejNYUFNFYXJvclRVMkNDaC93NTBDc0JUbmhIaEI0NmY4eTlvQWpFQjRxMm9l?=
 =?utf-8?B?eFRFREIzTEsrOXFmaFZKaW1najBvYVNnYVBDRHo3Vng3bXBqVXhUWUdjczIw?=
 =?utf-8?B?Z3hERUlpRzdxYkpyVk5vWXBUeVBBVGJxV3d6TGMyNjV0alJvQ0lob1lpREpQ?=
 =?utf-8?B?ek42SHRYQWJzeGFaSCtkUzNtNkVDcU8zNUN4UkpTQk5TN3RUKzY5T3FJWWRI?=
 =?utf-8?Q?BWX4WwdykgA2nQhBiRCfhLPF8?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 220768a9-f6dc-44ef-c4bd-08dbc003f548
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 09:19:03.7403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N99nYHXfb9d9j9TMXFqqPD7W/UmQWx/fPKZFZMuTK9gPFjf4f0wrOJp4EM4WCJiI+2vj5t6JuDfM2Z3iqc2LFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7867
X-Proofpoint-GUID: 2CcUqcmNEufC0tGY0VBqqa2HJ4fOHAOc
X-Proofpoint-ORIG-GUID: 2CcUqcmNEufC0tGY0VBqqa2HJ4fOHAOc
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=946 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309280078
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/28/23 3:15 AM, Jiri Olsa wrote:
> On Wed, Sep 27, 2023 at 06:19:10PM -0500, ruowenq2@illinois.edu wrote:
>>
>>
>> On 9/27/23 6:03 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
>>> On Tue, Sep 26, 2023 at 11:50:30PM -0500, ruowenq2@illinois.edu wrote:
>>>> From: Ruowen Qin <ruowenq2@illinois.edu>
>>>>
>>>> The sanitizer flag, which is supported by both clang and gcc, would make
>>>> it easier to debug array index out-of-bounds problems in these programs.
>>>>
>>>> Make the Makfile smarter to detect ubsan support from the compiler and
>>>> add the '-fsanitize=bounds' accordingly.
>>>>
>>>> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
>>>> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
>>>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>>>> Signed-off-by: Ruowen Qin <ruowenq2@illinois.edu>
>>>> ---
>>>>   samples/bpf/Makefile | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>>>> index 6c707ebcebb9..90af76fa9dd8 100644
>>>> --- a/samples/bpf/Makefile
>>>> +++ b/samples/bpf/Makefile
>>>> @@ -169,6 +169,9 @@ endif
>>>>   TPROGS_CFLAGS += -Wall -O2
>>>>   TPROGS_CFLAGS += -Wmissing-prototypes
>>>>   TPROGS_CFLAGS += -Wstrict-prototypes
>>>> +TPROGS_CFLAGS += $(call try-run,\
>>>> +	printf "int main() { return 0; }" |\
>>>> +	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
>>>
>>> I haven't checked deeply, but could we use just cc-option? looks simpler
>>>
>>> TPROGS_CFLAGS += $(call cc-option, -fsanitize=bounds)
>>>
>>> jirka
>>
>> Hi, thanks for your quick reply! When checking for flags, cc-option does not execute the linker, but on Fedora, an error appears and stating that "/usr/lib64/libubsan.so.1.0.0" cannot be found during linking. So I try this seemingly cumbersome way.
> 
> I see, there's also ld-option, would that work?
> 
> jirka
> 

IMHO I don't think ld-option would solve the problem. It directly sends the
flag to the linker but -fsanitize=bounds is a compiler flag, not a linker
flag.

Basically, what's special about this case is that the feature we want to
probe is behind a gcc/clang flag but we do not know whether it is supported
until link time (e.g. the sanitizer library is missing on Fedora so we get
a link error).

--Jinghao

>>
>> Ruowen
>>
>>>>   >   TPROGS_CFLAGS += -I$(objtree)/usr/include
>>>>   TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
>>>> -- > 2.42.0
>>>>
>>>>
>>>

