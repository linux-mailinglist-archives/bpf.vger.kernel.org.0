Return-Path: <bpf+bounces-6160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9CB7663B1
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 07:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D071C21340
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 05:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4C063A4;
	Fri, 28 Jul 2023 05:39:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8323AE
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 05:39:24 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB8235AD;
	Thu, 27 Jul 2023 22:39:20 -0700 (PDT)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S5IQDw014347;
	Thu, 27 Jul 2023 22:39:16 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s0ad056xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Jul 2023 22:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2wH5BN3nOY/Tl9hHGpco9WoeJU8yYeUcXr3kyvcIYpbOmheDY+LX32ZSrPYzsjMsqbUQO2jreQspkXxjF8xIa3zu8IWP3ac8V+SAxrjGkZP3C2wg6o/YpxuaZIwakSUCLS4PmswXH130RQRr5PD73gtJb6oOxRUGtccOch5LqNuP5OYL0ZZhwok2GTLgfQ+3X9HX9jgzWUFeoirVcJHcQD9MSETDYJsIwoldNC1P8O0BY9i6bztMPpIEg30wdoyMxKOMPUboD5B5YvC8Ey7M/REEgX+DKviZhFXB5PNzQOWe0NY8ZiNqFY+FD39IcGpBRuvb3W92/zYc0zyWciHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOyzTHcfKY/pzmefg4oRfM7t5DrnFuXmDp9rhrbJGp8=;
 b=BcSfIl3l3cZHecWJvbCLdmX7H+raNVi9oW4icqR1Y+c50KUdZe51+yXoDDCwmZ97pUoD/PTNSt5gPr3oFC5p1Tctmtbhd5E8SJkN6eJKAk6V60iRXao8lKZ2W8sTjJYGivv8AtXmrWxWyNDl2PiSNiK7Wn8JVUWwc2oSSnRQTUpe/04RFI6VDhi6Kn1k65K6KRBAIzORG48vzuujeo/g+X9dOXS/+xn2MuSiUI6wbbO9+cAbbfFqwvPPuFuYq7o9b9OmsQl55ev7Fjq88z+yLRaa7DhrZTg5+1jmmCRPJTUL3puu59pxsiluXrp/FXtoBDd6BHlwBoCEsKrDiAlflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by LV3PR11MB8601.namprd11.prod.outlook.com (2603:10b6:408:1b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:39:12 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::c8f6:72a0:67fa:5032]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::c8f6:72a0:67fa:5032%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 05:39:12 +0000
Message-ID: <0d37f1a0-7045-130c-9d01-7d26625acab4@windriver.com>
Date: Fri, 28 Jul 2023 13:39:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] libbpf: fix warnings "'pad_type' 'pad_bits' 'new_off' may
 be used uninitialized"
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230727082536.1974154-1-xiangyu.chen@eng.windriver.com>
 <ZMJOl5uLrK9rucXB@krava>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <ZMJOl5uLrK9rucXB@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|LV3PR11MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0708d1-c223-445c-f8aa-08db8f2cf8e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qZw65IiKUcpQDNN7DK817b7j34N/TNAL2yQkPaKTP9QInrpl4JFsBE7sQ0mzr8TMtk1otjdhnhrxsAq86XNkzv9u+Mc8vpDRotnHX8x+1f57xh7u5c+/EdpryOjMm0FxVIzTuxayYd2MtsBxnpU6Syfe8uGeXRuU2LV9eWgGcFn5zMEaCkgnQrtT4wrUu6526GFMrlxDUWR9H37LusV8X56LTwFmu4UBxXPKPhvn59e4Py64vcbt3uU+1zvkITRGF6ns5ubFXIpnacNs1WwI+DHNeCbFpj95X5+fp0k9TRYzc8t1/G1ophmSh7OpcSwL9/sHkSpQ8ujz14g6C2IzaZKK5ieo6CaWZzCHGkLHN5FH7vXmr4FCoaBsC2j8ihbi7laLmwt9AKle9DMe/0sFcrMnmKZylyWu1HmYEvBtUQjmZCf2q/rtQvnV3+dKYp+tP68j4k2qA2eAhyBBReKTNf2omithz5Zd/ztNvXZrnP290+jLnI47HeGmRNqojmgHVVuY8a/mrVMzKTPl8h8IPhF+MyhluEgDZWwUS0bbuGMj6+hz7SmyTH5h271Lq/pP78k3foJ1rQ/zgCAVQBsi3GRGoZ2AHZy0WxA6cA+g5WAZCR5z71uavLme3Mdfn8Ra
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39850400004)(366004)(136003)(451199021)(2906002)(6506007)(31696002)(53546011)(186003)(26005)(83380400001)(6512007)(38100700002)(83170400001)(478600001)(9686003)(6666004)(6486002)(66476007)(36756003)(66946007)(66556008)(41300700001)(316002)(4326008)(8676002)(8936002)(5660300002)(44832011)(6916009)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmxZek1Xb0lVSW0vMmtGOGgyNXdETnNuTVFoN1dGOHc3ZWVzb1JjeDZWNUN0?=
 =?utf-8?B?VnZINzNudzdpRGVUQ3VvVmFKU3VHKzNwd0dXZUhNWm55amRKYkp1UW0zK0dl?=
 =?utf-8?B?cXNxdk00NWlDU3Z2Qm1pYnEzSGhkdVdYR0pWMlk4NXBIM3FoQ3lXYWc3aXJz?=
 =?utf-8?B?VmJQQlJhNk9XY0VqUE00ekxna0R4N2NDc2VJSkU0T1NEcWY0NXVrQ1hrRDR4?=
 =?utf-8?B?bTk4VkZkMWE3VjBVbmVBcS93MDZGcjlqOTM3ZDdRU25qU2oxZVFIYXFqMGNh?=
 =?utf-8?B?bTQ5cU9NMkJXWDQ3MS9nTUxid3drd0IxWExRMzhuWmduRnI0TEFURkdMOHky?=
 =?utf-8?B?NkFPV2ZQeGhVbnhGbW1TeWdFdFlJY2w0Rmh4VW9GRklndStBeXFUQTdZR01z?=
 =?utf-8?B?OXZxYWROdVY1cC9jNEIzZ2FHOGxjL0RlVXp3dmRTMWtKd3VpUklnckFVUjNq?=
 =?utf-8?B?N3hFVkxwK0xOdTh6RjhwMElGdld3bjU3aUt2cmYwNVFwT0ptT1Boc1VvT21y?=
 =?utf-8?B?UHBIWlp2dVg3em42QmtYMEY3OGtVUjlpQnVhNVErdXMxQXZsWC9DQmpMK0RQ?=
 =?utf-8?B?dkRucHU4TmhKYlEwYitQYmx1R1RPcnpBZVZhTjJTWEJ1elVwRmhnUUlIUHdS?=
 =?utf-8?B?d2Z6aVA0YmxCdjk3SW1qTXNwWUJBRGl4U2Z2bkZuckdFKzRnNXRaSksvTjdH?=
 =?utf-8?B?eDNjZWNKSGM0ZFZmVWF0Si9UT01aSGdYNWgrd0s3Nzk4ek50Z2xiK0c2K3dJ?=
 =?utf-8?B?eFd2Yzh3Ly9QWmozNGtlY2tSNXpRdXhFUzdMeFYrTlZzSTh6UXpEazRKbXhI?=
 =?utf-8?B?T1FtMXdGN2E3YVNFdzNUblJmNFdyTkVMeXdnRGlqRU82Q2VqRWxveHQ1MlJy?=
 =?utf-8?B?RlpWZjhIenEwd1JGQkd4TUZSZEFmeGlkOHBTdVRPT1ByWTB1U2IxcW9sdDlG?=
 =?utf-8?B?WHZWOG1EUlUrV2lXRjViYVg4RXlRVHlqSS9KMFNyWUp6dlU3YnFQS3BHYmwr?=
 =?utf-8?B?MzBzTzM4VkR3c0ZObXdzdWhGVnVhM1IycUJ4R3pBRjRoNUh2d3JGZVF0aHZl?=
 =?utf-8?B?aTNGNjh0bStNOGViVVczbTVzUG5WaHFGeTVucWFaOWY4NFd0QlI4bzVudndW?=
 =?utf-8?B?UGViVFczdGx4MStJUXhxU2tnVjc4Ym1SeUdKKzJ6cWl5KzhYWHBYNHo3RStk?=
 =?utf-8?B?aVIwNFppc0hpdXc5Z3NFODAyeGdMWC9lUEVKakFQVUNFSXBSZm9BMmxGREZF?=
 =?utf-8?B?cCs5YkxuMzRnaFBSanMwS3IyeDlvQ1dlcmZXcDNyMnpjc01uUjVyeE1ZaHlu?=
 =?utf-8?B?OFBobFdRK0k1NjRlemtWamJ1R3d4NzNwQlRhN3hST24xNGl0eUx2aU41Tm5s?=
 =?utf-8?B?QW02N1Zubk1yNmJrWEFBbVZtK2duM1dIaUo3WmR0WHc1eHg2cVhkcXVsMGp6?=
 =?utf-8?B?eDFoMys3Sk9ZNGdwdUdOUFgwM0xVQzFPS1g3TVB2ZEZYU1Y0QmdiYktBUmRE?=
 =?utf-8?B?SkxrZWp6UWJtTjNtZkxzV2QreXRnTHFZZXQ3RlFOK0h6UDJxdHBaVVBmWDdG?=
 =?utf-8?B?MUlMbUFYenBmakxKMm1Na3hGa3RITDFrQWdTcGVuenFqRU1VNGtJQitEZ2xx?=
 =?utf-8?B?MjVBZEE4WUFZeGdsQ0hjYThCM04vdmhlTHZIR3A2K25Vd3RnTjQ4ZFh4aC84?=
 =?utf-8?B?UGM0UndleUlCaGc2UzZpemVyaW50V2s1QjFlMTBWUnYvS3ZMMWJZREkzWnA1?=
 =?utf-8?B?cXBWZVFEckdiaDBmcy9sUzY1V0M2VDRlL0l1eTBpMldYR2JaYkJudmZsUFJa?=
 =?utf-8?B?STNBQmFXb3FQRFRiTTVhT3BlVitRZDJLZzlVL2Z4WXpiMjFFZzhsQWp4dmdR?=
 =?utf-8?B?M2FBZ1FBdjltNmNEK1p4dVdmWkJwUWhMMDR0b1NmemVuc3E2NFlpTGpCNTdF?=
 =?utf-8?B?YnNMNTMxVCtaUkY2N0tTeHB4R2NNSy9memhTWG5xV2hrMjk0VzhtK3l2c3Aw?=
 =?utf-8?B?SDF6a2xvbVV4SEVxS1NNWUsrUjVSenZvVTJ3Z2dQZGp2RkRCa1ZzNENKeUkv?=
 =?utf-8?B?dGpkOWJwSDhyd0JXTzZGaVZRNFhwWDdxRmJjV0VmWU9tQ3RQZjY2VlZQVnRL?=
 =?utf-8?B?TXRpTGZrR1FidTFXWXozczQ4Q2IwaDVnaStWQlpXaWtTUzA0TGNPb3VNYmdi?=
 =?utf-8?B?a2c9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0708d1-c223-445c-f8aa-08db8f2cf8e9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:39:12.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbF5Cp/9Dd/yfhajiYvxDtpWIpAOr+Q2YBbg8WQgTr3zz+cCAp9K3SFRqkuKnq1MoYX8bBuUf9scUxsEzXZvtu89tjtsgxq3/awIy+TnLy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8601
X-Proofpoint-ORIG-GUID: Os5j4C1wtt6eFzX2IC1bjx9ilWTbdM-V
X-Proofpoint-GUID: Os5j4C1wtt6eFzX2IC1bjx9ilWTbdM-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1011 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2307280052
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 7/27/23 19:01, Jiri Olsa wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Thu, Jul 27, 2023 at 04:25:36PM +0800, Xiangyu Chen wrote:
>> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>>
>> When turn on the yocto DEBUG_BUILD flag, the build options for gcc would enable maybe-uninitialized,
>> and following warnings would be reported as below:
> curious, what's the gcc version? I can't reproduce that,

Indeed, it's also strange to me, the compiler using gcc-11.3.0 which is 
generated by yocto 4.2.2(mickledore branch).

The warning happens on turn on DEBUG_BUILD flag in yocto configuration, 
but when disable the DEBUG_BUILD flag, this

warning disappeared.

I have compared w/wo the DEBUG_BUILD's kernel build parameters this 
morning, when enabled the flag, the kernel build

parameters as normal, the warning won't happen. When I enabled the 
DEBUG_BUILD, the cflags with -Og -g -feliminate-unused-debug-types

seems the debug cflags caused the false warning behavior.


> and we already have all warnings enabled:
>
>    CFLAGS += -Werror -Wall
>
> they seem like false warnings also, because ARRAY_SIZE(pads)
> will be always > 0
>
> jirka
>
>> | btf_dump.c: In function 'btf_dump_emit_bit_padding':
>> | btf_dump.c:916:4: error: 'pad_type' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   916 |    btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
>> |       |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> |   917 |      in_bitfield ? new_off - cur_off : 0);
>> |       |      ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> | btf_dump.c:929:6: error: 'pad_bits' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   929 |   if (bits == pad_bits) {
>> |       |      ^
>> | btf_dump.c:913:28: error: 'new_off' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>> |   913 |       (new_off == next_off && roundup(cur_off, next_align * 8) != new_off) ||
>> |       |       ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> |   HOSTLD  scripts/mod/modpost
>>
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> ---
>>   tools/lib/bpf/btf_dump.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
>> index 4d9f30bf7f01..79923c3b8777 100644
>> --- a/tools/lib/bpf/btf_dump.c
>> +++ b/tools/lib/bpf/btf_dump.c
>> @@ -867,8 +867,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
>>        } pads[] = {
>>                {"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
>>        };
>> -     int new_off, pad_bits, bits, i;
>> -     const char *pad_type;
>> +     int new_off = 0, pad_bits = 0, bits, i;
>> +     const char *pad_type = NULL;
>>
>>        if (cur_off >= next_off)
>>                return; /* no gap */
>> --
>> 2.34.1
>>
>>

