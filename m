Return-Path: <bpf+bounces-5694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B51675E9CD
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0267928112E
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC249EA5;
	Mon, 24 Jul 2023 02:35:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7AA2D
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 02:35:51 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDAC83
	for <bpf@vger.kernel.org>; Sun, 23 Jul 2023 19:35:50 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36NNfB6X000972;
	Sun, 23 Jul 2023 19:35:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=aqveiSrQfXkndUZeEAc8wI0mIb5kVvFmgjCG9J58qNU=;
 b=W5EAhBfMlXG8KH4KksUwE9I4q4/b3/OXL7lKgbGrQLWeOzKo+c7gkd247Hh5MGLttRSJ
 LhQxChGFsKzCMLlIs1MYZpO9he7y9OFmQ17iUNlSS1jBLUzed5mgAjepnt4miGj/Y8oW
 YIbQCLuvCrjOVN2jqRuzq8zLgdR9pllFcs6r7t/aSm4nFKDCysWUfwJtQ3R5D/USAJzj
 5iPK9qE7VxPSJ81GSUP165brmUuhVKfSBYlVIWy2qxMvx0/iXucKM5Tu76jCY4Nw1Zgw
 halLmHiHJpLn68IlJoAkM97IXvC9GqFgO/F/7doorQed2Q3FDtLMlZiMeNa0KBGKD8w/ 4Q== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3s0ctphe1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jul 2023 19:35:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDZBVB/aeFCp7lkNeFadWqpmb/2NLcMc9V3z8zofzpIILsNbn02q+3vSiScFtfv2v62Xufvui4k63YYGbRrGdwLPbngUuYxva2qcz4SD/L4jj+b/jWOm5fjU+gc8aIGvL9tIqVobvXVnez4pbK3rMW/ITsQcA9agDrK8udbh/IJjHM60aN7EYNEgFmLw+DlACjsfaRTDT6NH4eqmH9TyyYFCcoz+zUWS+23OuONdEzKKMhBLc6evXfJfHD8Ry6OCD9OuPSwYWOGN9+NiUzaKBksdm0ckX3z/lMS3EWxFP6109TMCG+l3T1snh97mj8PnxXmWuDKFWEfUqYeWtvp0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkpKuo00TQknXkmy12JtTzc2/nmVXlxF3W5S8BZX5Ts=;
 b=Bc7/AOx314Cz50hQZQwN4KIDgiv1JQYoQQUCTTBeiuMDe5rL9IvzYog/7ovyjxuSbydSAWNqOwgLN5j+tf8XYpqbdijkwW1H584zFs7QDsFfFR2WKEDQ9oS8tLRRYpZK2mi69n6kb4a1qJhslbf3ZSfhopucffOYpj7JNB4Q5ImRzSpWqRp4n1W3R9vGwr9ZsNDqdCgpC1tBHfSkkxEIsi4NC+lWcGq8ML/QbB7LS5sQHMAibpuSVTjzsNQXw7Knlky8yZdX6MxGbWBWDVpVB1pRrpJN+KgHT4iXdySr1GGfQENjQ5z2y/+zdJu0Jo2de/vTWGhkD5vV3r4xfV5XMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB4001.namprd15.prod.outlook.com (2603:10b6:208:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 02:35:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 02:35:29 +0000
Message-ID: <dc0d16a6-7c22-6a76-44a5-1f1605eb4b6a@meta.com>
Date: Sun, 23 Jul 2023 19:35:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        cupertino.miranda@oracle.com, david.faust@oracle.com
References: <20230713060718.388258-1-yhs@fb.com>
 <8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
 <aa910249-cc7f-680f-144a-b6f6962b277d@meta.com> <87351h8gak.fsf@oracle.com>
 <87fs5ep3gv.fsf@oracle.com> <875y6ap1bg.fsf@oracle.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <875y6ap1bg.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0063.namprd05.prod.outlook.com
 (2603:10b6:a03:332::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB4001:EE_
X-MS-Office365-Filtering-Correlation-Id: acca44c1-b467-4585-2b3a-08db8beea4cc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	42nCrB+gcF7guTvU/SIh6dvjRSd1HqNB04rvWLO0ii50wNzHqDaCM5cgOc97arh9keO+zNOnoBduyHX4PtmHo4YXg71RcA5l7SdANEi9U02ytv7kvdMQEZb9LfhoFr4QM0SvgV1xseOPE4q0QOhZFSlfYKH9NYPBsIb73Ikr/Z55ilS5rCwKtMlC7Yv5TQx+HwnstRipfuKsPfLzc0kAHBuH7AGYQb7ToH8Nm9LcEaOLsZITpBwR443yfwbOizIDZJxYqfPBbawKqt3PU/Zl5wgprdfK9VeUnSwFfOvI28a7uDg2921+uZQApdwO9HXRWdygwa4lZpK0WoT94xtrAIWI7CQPdsptT/I0MeDJtzLsyp2XOcqW+Iy/Wf1wZi8sth0u8GjMtsVPt0g4UlvqPrmfe3ZuAsJBa2a4cSMOeGmtz4kM8iglm7uIPumM/LW4RmNSyk0bi7X5uAxzC+KuhdC5r/8MLEeGDaamxyeTXYUwwkp0OrDQYeJoA2ETqfEB4AVjkO3JzxVptZSOXJ/u4uYAqUeT2LA6dCdSgi4eGKgzFlvJmthFeMYgatyD+p85z1eZRDb5LjbvoqZe+mzzHLtzs3lY4cLNAoToLLfZFETg4AKIIAHAS/spf2chkcld
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(38100700002)(36756003)(53546011)(2616005)(8676002)(8936002)(478600001)(54906003)(66476007)(66556008)(6916009)(316002)(4326008)(66946007)(41300700001)(186003)(6506007)(966005)(6512007)(6486002)(6666004)(2906002)(5660300002)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SWo2MU1VOUpQNEk4WnpYcVhYZXJ4YmZCRzhHSW1LU1dzU0ZkZXhQM05XajhO?=
 =?utf-8?B?UG16UkVZcEx6N2RLNDJPYS9HdWpkSDFiWU9Ba2VReHZaalhnV21mY2g5QnNZ?=
 =?utf-8?B?YUlpazNNWmNOR1VvYU9ERG85K085R0lVSys5d0czdTdaaVBxdEdEdUF3c2M2?=
 =?utf-8?B?bGdud1NsOGxvTW82QlZjUU9sajFOb1lpTjFMdW9MeUlyK1hrNEY1RG93b0pY?=
 =?utf-8?B?dERNc3poWHgzcHd1Q29qZzFLODhjN1RLMGZqd1BBNWhHMXRCZG5wK1cwVlM5?=
 =?utf-8?B?eU1MbjNDeTZaMXNiQU56a2EvSXFCdVVzMVM2YzhSa2E1Zys4T2pPbHZ5ZldR?=
 =?utf-8?B?am5MU1F1K3V1V2hyVVRaM29FdVlMQTgyZFdsU0Fubi9Ia0UwMnR6Q0dRbHFR?=
 =?utf-8?B?VmNmcUR0a2hwWUNybjZiNUs1Ny96amFEck1SRXNsdGxhODdyWm05RTVrRDNK?=
 =?utf-8?B?cWRsOVNYOTk5V3NZeGlJVWIxb1ljaTA3Tzc1a2ZLWi83S3A3SlNtVTB1NmEz?=
 =?utf-8?B?UUt5ZWlZMjlmZXlFVTd2aCs3WFp4ZElSTVFSbytaNllCbmxWa3hoQjFqQjdv?=
 =?utf-8?B?THZjWUUwU1p1WWdZOGZVeCtyZE9kdTNEVVVFRmgwakp4THVNTlBxQnZNZUkw?=
 =?utf-8?B?eTJEUDZvVExEQ0JCaHhQaDE2VE03SG1UTG5jTTNxMTFXRGZIY2xQU3g2Q2s2?=
 =?utf-8?B?cmhpTHRzRUIrN1FTaDhmRlUwaDVnQmlRMDZNMGpVWm5sVE9NYXdDeWhUTzJV?=
 =?utf-8?B?RVBENHRWcGxaUWFzdk9Hc00vV0VSRkEyN2EyQm9lQ3ZMTkErV2I2Ni9BZ0tP?=
 =?utf-8?B?ZG1SUHNaM1NuTjNpaEZTWFhXQklrOEI0OExTZldRTmFVNGYwdnlDUjhPNW1a?=
 =?utf-8?B?REcyOUlYWGsrZ0h1UmE2RllMUXBYZVBKYjdzbG5vRkFvUHdkTWxpZ1RPcnFI?=
 =?utf-8?B?bkc5djF5Q0lRMktsbTkxNmNvYmt4NzlPbFpYVmZITHVPYVpKajZhZVJUMjRl?=
 =?utf-8?B?dnk2V0xPQmR1MVRBQmNEWDdLZ09BaXZLOXVHUE1SVTBNSS9ZZTRaOUJtWmlp?=
 =?utf-8?B?UU1sNkFLclc0VE5pMXdZRldYaTIxNGlLb1FZdXVUdmV0aW5FL215R0Q5M0hQ?=
 =?utf-8?B?Tk42OHVSYVU5MGhzenF6d0ZOOHlma2lTcHJzMkJlZXpSdTU0cWtQc0dscjE2?=
 =?utf-8?B?ekFWNzlPaVNHNEl2aTc1aVpUSXJKY01HaWxNcjNOdTlWQ3JRYi9ELzZxcWI2?=
 =?utf-8?B?RjF4L1ppOHJmWDNSenlHNGFXQWxoVjJ5ZEJIM0JwazFSa3NUdjZTSlRZQ0pT?=
 =?utf-8?B?bXRKcWc0V1Z0MGptTFY3S2YxTk9QK05wZzIwblBEY20xL1EzaGtFaDhJdmkz?=
 =?utf-8?B?dW44QnhTTFlLcmdDTGNlMkhkd3BKeDdXS0RneGZ4UUIzcXFzNGRsQnMyME4z?=
 =?utf-8?B?ejBQY2ZHTGd2Qm1rSENNbnByNHgyN2p2R2FqQ0syL0s1TzNtUitzM1B2MG1X?=
 =?utf-8?B?WVNDU2M2MStzTndjWjdTMXFUeEdTaE04R1c5a1d4TSs3UWFEVTVYVktUcFdu?=
 =?utf-8?B?RXJnaUM1bEZlc3FlcUwrMFB4WTdvTzl1YlNIN3IzV00xS3l1VUEwTXRCUlFC?=
 =?utf-8?B?UWU2cytmUyszVy9OWW1rWWFTWlJYR2M3NVpZU0FuMHBhbVNFSlVqMmtPamxL?=
 =?utf-8?B?UnRqbmJnSHdaS1JObk0rUDJ1L3NqSFJRdlM0M2N2L0M3SFhlM3RJMzBNNGtl?=
 =?utf-8?B?ZkhteU85NGk2YkVPZVpySHgzQzRDNHg0UlZTM0g5NThxd0lNZnN5MnJGRlZM?=
 =?utf-8?B?QzBDNHBjcDJFNWxBUHFWRmhDakFFVXhLS3pKc1E2SkhvL3prS0lPOENzV3d3?=
 =?utf-8?B?V01RRGF3QUJLellaeHdpamFubVEwTi9wYjRiMmI0K0tUYVVpNGtXczZuV0tm?=
 =?utf-8?B?QjM0NGltamdzb0ZMaGxkLzUzb0dzU0c1N3pxZTdCeFo5MlFNUGRKaStPMEQy?=
 =?utf-8?B?Sjlrb1BFK2dFdEI0cndXd055N1RRdzRqWk9DbEdnWHVWbmFmYmZjdWxMUUNx?=
 =?utf-8?B?TEJtZFBnWE5KMmdLcUU2N3N0a2tUM2lvbGJ2TWpLVWlTU2M4bWZ3SnVub21l?=
 =?utf-8?B?S0VzdCtIZEM0NXFxa0RWT091U0xudlZzbVMxSEc5QzZaM3pqOENRa0hibXRB?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acca44c1-b467-4585-2b3a-08db8beea4cc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 02:35:28.8685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cl1jG6T3jpGVhrLs1n1jtMa5CRnrc1i0BR6gEUffH3+kkDL/T39Ob3MftZwJhPDV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4001
X-Proofpoint-GUID: SJ6kAIPs_icEribhV9HXkBv6MFl-59zO
X-Proofpoint-ORIG-GUID: SJ6kAIPs_icEribhV9HXkBv6MFl-59zO
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 3 URL's were un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_01,2023-07-20_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/23/23 6:04 PM, Jose E. Marchesi wrote:
> 
>>> Hi Yonghong.
>>>
>>>>>>>     . sign extended load
>>>>>>>     . sign extended mov
>>>>>>>     . bswap
>>>>>>>     . signed div/mod
>>>>>>>     . ja with 32-bit offset
>>>
>>> I am adding the V4 BPF instructions to binutils.  Where is the precise
>>> "pseudo-c" syntax used by the new instructions documented?
>>
>> I looked at the tests in https://reviews.llvm.org/D144829  and:
>>
>>> For ALU sdiv/smod we are using:
>>>
>>>     rd s/= rs
>>>     rd s%= rs
>>
>> Looks like I chose wisely, just by chance 8-)
>>
>>> For ALU movs instruction I just made up:
>>>
>>>     rd s= (i8) rs
>>>     rd s= (i16) rs
>>>     rd s= (i32) rs
>>
>> Just changed that in binutils [1] to
>>
>>    rd = (s8) rs
>>    rd = (s16) rs
>>    rd = (s32) rs
>>
>>> For ALU32 movs I just made up:
>>>
>>>     wd s= (i8) ws
>>>     wd s= (i16) ws
>>>     wd s= (i32) ws
>>
>> Just changed that in binutils [1] to
>>
>>    wd = (s8) ws
>>    wd = (s16) ws
>>    wd = (s32) ws
>>
>> [1] https://sourceware.org/pipermail/binutils/2023-July/128544.html
> 
> And finally for byte swap instructions:
> 
>      rd = bswap16 rd
>      rd = bswap32 rd
>      rd = bswap64 rd
> 
> https://sourceware.org/pipermail/binutils/2023-July/128546.html
> 
> So, at this point we should have support for all the new BPF V4
> instructions in the binutils opcodes, assembler and disassembler.
> 
> We are working now in getting GCC making good use of them.

Sounds great. Thanks!
I plan to push cpu v4 to llvm18 which should be available in the
next week.

> Salud!

