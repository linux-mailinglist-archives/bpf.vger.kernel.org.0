Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0888456831
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 03:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhKSCig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 21:38:36 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1080 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231217AbhKSCif (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 21:38:35 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AILFnRR019190;
        Thu, 18 Nov 2021 18:35:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T1S3h7IgEm9hne3DKvdnKY8PcLqKZMMgRdA2WObJqLQ=;
 b=FXFexWPAIc4hGv/l8BjCXJOp7dF3/cwibg2xPUcKKOiNzLXrq9wP3S9KhG1b4mwBcAKU
 KGbT1BmcRrl2j/KVLbPMXmjJfQWnsLutnFbAPNTtMOlFCpGK04x8WpNz8XWhuu+Gg5Yz
 Sv7DlatQhEHLG4tfpR6FZXZ+qmYVOaWaFmA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3cds394mda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Nov 2021 18:35:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 18 Nov 2021 18:35:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0KrSNXBLxV3fEIIirj8vKeIVhWJOOCnKC7jP9c3qVxWtNBuxQUJpHZ9KDavACmGBbfY6WDFvGEF5dnD238nsIK87AuVF0zl0puZVkyribIifAn8Vqt+ABBr0nxB6jhafgDJ5dId2XFdEOeRfZKUrlOSUXLrI4QXyi+sYSuABrwlhupQb68bI15/YULn/rRkaPUgU+EGejsvhKs5b0HZ0vKrBoyTTPOYUEk5ynat2woL6e2ii5cp/taVH/ojfaqgPiyrpul+o0IVA141Z7NbwT7IZY2K0iFlPxw9576oP9DbrXjLvGAjnk7U8bFpqHJ/XvMUUkmGjU3XpdqTzbdidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1S3h7IgEm9hne3DKvdnKY8PcLqKZMMgRdA2WObJqLQ=;
 b=Pk1Qp1ZeS5BYvCYOiP+pE8VIyIuF1OdW0guSMq7yMuOWyDjOqQ4EeJm3yZQDRa6VxYBWzgqHdssFlyNsVvG3jolMZlf2CvpYeK4JfYOKqchVaxrgKKq7pjDJdfY17yZMHROO7DElL2gf8RINVL9HNHCRf8RaGC/9/Q1b7TmokphY/jbr+aQk+kC+z6mPX7n7uMhB4XrZ+5R0SO4YeS27nb5qi7fZ9ne1IJqWJNxcUBv6JT+Zlp9K03oAZ7O3Y0fcL5KUzGWMskSpJrAt8RzJEFgheoNMMIukQXpJ+CFzwyIJy4v6nquuw9EAWpJyKXSq3wfHzWc1yNc9RwsgTNuqlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
 by SN6PR15MB2447.namprd15.prod.outlook.com (2603:10b6:805:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Fri, 19 Nov
 2021 02:35:18 +0000
Received: from SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b]) by SA1PR15MB4465.namprd15.prod.outlook.com
 ([fe80::853:8eb0:5412:13b%9]) with mapi id 15.20.4713.022; Fri, 19 Nov 2021
 02:35:18 +0000
Message-ID: <a1c10bc8-4d97-508b-f7c4-a362b5692f3b@fb.com>
Date:   Thu, 18 Nov 2021 18:35:10 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.1
Subject: Re: [PATCH bpf-next 0/3] Add bpf_for_each helper
Content-Language: en-US
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kafai@fb.com>, <Kernel-team@fb.com>
References: <20211118010404.2415864-1-joannekoong@fb.com>
 <87tug9emwv.fsf@toke.dk>
From:   Joanne Koong <joannekoong@fb.com>
In-Reply-To: <87tug9emwv.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16)
 To SA1PR15MB4465.namprd15.prod.outlook.com (2603:10b6:806:194::23)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21d6::18af] (2620:10d:c090:400::5:8825) by MW2PR16CA0003.namprd16.prod.outlook.com (2603:10b6:907::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 02:35:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4de525cf-f21f-4b8d-9b95-08d9ab0539a1
X-MS-TrafficTypeDiagnostic: SN6PR15MB2447:
X-Microsoft-Antispam-PRVS: <SN6PR15MB244782515A8588653F597A74D29C9@SN6PR15MB2447.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8vJ6l2ivjo3JassqHRRhJIkmZtFqeE8WB2eGKiwYYkPip2BMDQAqePeH1/t7dJ1ce010Ve09tQemYM5fJhK7wAsHCMOQDUNyZyhLvdEUy9dyu6a3DojREuI5Ho7EZUnfEAhCmQRGdiuDo1/fRzBpCLtm5x434BTC5BRfcQldHnN04XiKHXhn+NQjO7jSYsxlypEXDEwSHtWGbppDoA5rCZrsxs1Yn1nxi3Du6SjPzRmZ7mh35URQpjRWUtsoNErPsJ6ZMWMd6VJWYYIO/Emn4D7nxMUZ2idLyn0JNWArqEjACtV1fWJrC5Bbu9CqbLYCoFlzvhQ5ViGYvQvvcza25+v0pKr0g7kAP6RG/StFX1oDF4rWWc7UP1LoLJxN3kNawc//GlvYKFKwX7+tWkv62+iJ2MDsXg6g2fPko2GPgcHOgdq3WexWYGagF2jlMkObnTGlxEwrIo4gLbHLGalnpmj5koaBHIwfF7J69wSFuW+L84GlOLaswM+5oaDKduReH1mCNm+qI3QN8je8MYdYMR+iSqtR6Uegaaa6WQYATGCJ7L/+xENZ0OclZf6BbHFCWgH2/eZZWGn1/1JGn7f4vPcNkMlB9uTxsOaamVP6o+cyRTyLIizs/CumspC0N4hDiYiEH0Et4ssBbTd/sjKz0hKNPANlggj4smmwhl8YaQHOkWqrpr/l4E0RJXZydcOZViVtde17mK5+eQbXapqCOjBerRNbzsbO4eDrrWmqX4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4465.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(31686004)(316002)(36756003)(38100700002)(5660300002)(4326008)(2616005)(186003)(31696002)(2906002)(6666004)(66574015)(508600001)(86362001)(8676002)(83380400001)(66946007)(6486002)(66476007)(66556008)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXd0c3MvVWhycVFFMGZBRTA4cnV0bStkT3BuWjJNZ0pkbWVLcWhYb3NnaFVE?=
 =?utf-8?B?dXQyWXRHU2pLRlFBeEoxQ0w2RzNHS2d2ejhwVm1jNW1FYzhGK2FJTWxqaVJS?=
 =?utf-8?B?WWVDa2RxRkhybVh4QWozZ3BVVWZEem9IMUpIRzFGSTgxbmJVMXA1VXZ0VE9K?=
 =?utf-8?B?Q09sVDZjek5zZlpEM3ZSWDNvdkZYNUI0WG91UmQ3Ti9BdVdOODY0QlJmdlA2?=
 =?utf-8?B?MWZxM0F0bE8yQUVqUnJFdGlwaFZrSHppaDZ3YlRMTGxkRUZCUVd5SUd2dUpO?=
 =?utf-8?B?K2M0djUzcS91Y2RaR0dScU1FQW05NzhiN2drUHRjOXY1L0U2bTZ0ME9WYlpE?=
 =?utf-8?B?U0YzNlkyblROSnY0d202L1VVY0duQW9xN3dUWENScHBSQk1yR0hQVEJqUDJU?=
 =?utf-8?B?VVlUVW5ZU2FEOWM0WFRvTjJGVTNwajJIR1BxTzZzd1JLZXBXeU1PVy9tSUcw?=
 =?utf-8?B?c2FiOXNkMFRTSkdraFpVY2o2Z1JsUHJKOThsL09TWDNWYkF5aTMyaHJzdEFZ?=
 =?utf-8?B?VzJCUnFmV0xnTytxb3NxUGszaHEvWTVkSCtRRXRWRHFwaVEvQjhNMjZjc0d3?=
 =?utf-8?B?bWd0VE1Sd1hsTFAzQ0V2VU1BQkxaUk9tbzkyWVplZ0pEbnpMT3Jhb0NHSGQ2?=
 =?utf-8?B?aHQzYTFKQlAvR0dSNWpoUE9HZDNINXBKc0xpSWxXV0RVVzZNbWg4NVllT005?=
 =?utf-8?B?S3l4UTN0clRUSmMwZzlRTXA4R2J3Q1g1ODlhQ0daQ3hZS2JSVy9WeUZLN2FH?=
 =?utf-8?B?VnViSG9hMWxLSkRFbEhsVVBwMTdJcG4zTGZ2WFp5cFN5a0wreEJGUGxEeTB5?=
 =?utf-8?B?S29LcHA2eDlHVFcvNkN6amhUZTJ2L2k0VFlFc0RqcUYyRGZ6MTQ3Z1NWZTBi?=
 =?utf-8?B?TXpKTld4am12RkJKTi8rd3Z2TFd6MW9ka2U1ZURpUSsyMjFWVmNFMUNSallF?=
 =?utf-8?B?akxpVGVsLzJUZmZpYzNmSGk0c3EvUEE4b3R1TXM2UGs2TUk1S0pGYTl5bDdT?=
 =?utf-8?B?L1hkR2VBbnVhZGlwL3ZqekExV3dEVEdKRXQrcUNWMkdxbURoM0VWQ05wZGM2?=
 =?utf-8?B?bVE0NDlJZjBVb1FDTVRHdUhKN3hVMHZlYUUrcW0xOTB0RnYyREhPNzJKLzIr?=
 =?utf-8?B?eHNCS3pwMkdYRUlsY3pxc1VWMFJLQlBCUEVBNFRWUWRndTI0V0pDVVBFWE91?=
 =?utf-8?B?UHdESFg0UHU2R0FycS9WdFVURmptc0hNekswWXI5R0lnTk5TSXFLbTlKblFk?=
 =?utf-8?B?eHZrM0QrdTVqZ0xWU1FKTXBPZzVOWGxTb01nL1E4WjFyd0U0TmgrVk5iRnlh?=
 =?utf-8?B?MHE3djh5dXlKRFY4M002bUZQQmNEN3RIT2o3bjI3ajlTUEhPaGVMMzlyMHUv?=
 =?utf-8?B?RE5nWUtHcXA4RmRET2tJcmhKME5hWjhSTXFHZXhEWG9kY3A0ZnNQN0dobWdC?=
 =?utf-8?B?Q1hIL0ZyMGc2cEVyNkFQMWorM1AxUVN1dkNIQkZsdmVJZHdwRzBaVkdtMmcr?=
 =?utf-8?B?NjN5QkNxS0s4Z3hZeWMrRWU3SFJ2Q3l1S3ErcXB2MnVqUWIyRFZrRFRxcnEx?=
 =?utf-8?B?NVFQTnN6QnFWRHdEREJpTU9EOXBzU05vbGNrUnVuU0cyVzdycnpxY1QvT0xW?=
 =?utf-8?B?VU9LYW52WVhnbFpkTzJOUE1uN0c5aDRlM2QyS1ozcHp4Wk0xWmpwanlCUHFS?=
 =?utf-8?B?eUF4YjZIQ1JlcGxOMGs0TVFqR3dYa2I3ZkxWT0Z0YXVyWFAvS0dlYWVYVmUy?=
 =?utf-8?B?NUlwL3BIMmtZSUVXMGNrK2VoNys3NzFrSEtiLy9EVStDMEVlMDhjODA0bXU2?=
 =?utf-8?B?SmI0MkZoTTVjSllST2ZsZ2hhK0pRUkNaaUNudlNvNFdSSEZ3Z0U5QmNqb3Jo?=
 =?utf-8?B?NkJDMXM1MVFlNjFBeVdhKzBSNzZndEtnNlc0Wnk5SWx0MlRSUDZSRzlYWExy?=
 =?utf-8?B?eG5OWWtaQjZLWWJIUlhOcCt0ZmtEMXlwbHR2VVdxWXRpaDNwSFlaRXQzQWND?=
 =?utf-8?B?SW5vaTQ1WUFLZTA2VnRzd0Rra2Ezd3padW1rY0JRN2FZdDdZNmtmMllNdDRy?=
 =?utf-8?B?aHhhMFBxVzBBaGRaRzdITDVSTXpLRVNWNDNuc3FDOVZ5TnI1cS9TSzVTa0Na?=
 =?utf-8?B?VEtlTVAvMXpyTXFXdFhqS0hrQVNvK3NjMkZoQzZaUEVSWXBaejc3ZWdQMFds?=
 =?utf-8?Q?nu3mw1DOFOYldmh3ZKi9mxbaKeKmJk67Uzq67b6pSS95?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de525cf-f21f-4b8d-9b95-08d9ab0539a1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4465.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 02:35:18.1446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lPIbOJhipP+uojhoVNalr2oUudK7mqA6XyBA7Bo88VZhQkWugz6FAqw1pOJy1vGX6JLFekF/DqF6bbdaSsfT4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2447
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: MUCt7HODrA_J7N43lOLPVA_3arcvQpTi
X-Proofpoint-GUID: MUCt7HODrA_J7N43lOLPVA_3arcvQpTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_01,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 mlxlogscore=520 phishscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111190009
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/21 3:14 AM, Toke Høiland-Jørgensen wrote:

> Joanne Koong <joannekoong@fb.com> writes:
>
>> This patchset add a new helper, bpf_for_each.
>>
>> One of the complexities of using for loops in bpf programs is that the verifier
>> needs to ensure that in every possibility of the loop logic, the loop will always
>> terminate. As such, there is a limit on how many iterations the loop can do.
>>
>> The bpf_for_each helper moves the loop logic into the kernel and can thereby
>> guarantee that the loop will always terminate. The bpf_for_each helper simplifies
>> a lot of the complexity the verifier needs to check, as well as removes the
>> constraint on the number of loops able to be run.
>>
>>  From the test results, we see that using bpf_for_each in place
>> of the traditional for loop led to a decrease in verification time
>> and number of bpf instructions by 100%. The benchmark results show
>> that as the number of iterations increases, the overhead per iteration
>> decreases.
> Small nit with the "by 100%" formulation: when giving such relative
> quantities 100% has a particular meaning, namely "eliminates entirely".
> Which this doesn't, obviously, it *almost* eliminates the verification
> overhead. So I'd change this to 99.5% instead (which is the actual value
> from your numbers in patch 2).
>
Great point!! I will change this to "~99%" (and make this change in 
patch #2's
commit message as well). Thanks for reviewing this patchset!

