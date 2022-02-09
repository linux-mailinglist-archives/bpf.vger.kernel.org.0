Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9411A4AE6A0
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 03:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiBICjh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 21:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbiBIBlz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 20:41:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3449C06157B
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 17:41:54 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2190lmXo005885;
        Tue, 8 Feb 2022 17:41:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZS+fuYsjmm6U7d+szRGQw0gV8ntQraR6H/MIXqNY+DI=;
 b=KfkPyLHI1UbinQjN/ZzvHqi51egUkg5qF3RMg0l6yaVWzxYeMrLU4TaWnjyMnY07SEFP
 3CmWuZ4XtB3Q7AJKk5q53XQDdniHCemH+M23lgJt/8gKgMYZHwqESn3VLTEik0wXRpbD
 9VWDIMFPzP5Qqs1aARsnQJKLsCEE6Uc14Us= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3e43cs884f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 17:41:39 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 17:41:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af7DDP0BEE4cG8uns9wG21XVoohrtdHYztVIgI1Q038MZExqF+W/0A81//ev4FTvakUE/3jv3oMQ9u1rJKeMdJX6mEaHLPLGhJ/00jgJx25bduuelwXJUZz7QlT2rwW9t7tBrwbc48T5AUEKhmoCGxv6PEivEsVKxICE1fUrKLhwClw49EegeVZQqSqAb3/hssFDJVdvfYUfUGpiGn1pwaoZ06uxahHUPOZrcY1nfuusK06JkYyIz1y9J/nh8i86V25PkIdh/cZb9ymIAWI0TVxJiiCDx9+ZzGpBCPFiEmAS3tbvF2ILN4xcrYJXA4g2KBtGLid6S3W4QaeTr289Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZS+fuYsjmm6U7d+szRGQw0gV8ntQraR6H/MIXqNY+DI=;
 b=LOj5ugsVKpngxP7cgh0JMa2lEfc7IAY1ml45sUunoFJtDuF5RvGEE/k76q2Vga9E8EMDZ5UcVsTBGU18UP7NYEqUJ/sKaPJ+K/PrLY56+D1BTi5xLVhtEepNpYlRR0Aq7eLBer710ZSAGqDX7AgDqcrshETdh/g/D1qBR1RrvfunKQXmf2396PrNSJNkyD3DyDP/5cQrELnVl1dxhWbY8szRKTn47goASgPnkVCMcbY47GCYTiYS31m2FC87dLqna3lr0iTXEDI9yPzeD0Nj/BHpwf+K/abGGb6UUoOc3T/fyzljKyOqhcijx4IktcWLii+VoEEbcn9rso9Kq1aIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL0PR1501MB2082.namprd15.prod.outlook.com (2603:10b6:207:31::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 01:41:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 01:41:23 +0000
Message-ID: <e7104843-af33-d3b4-8854-6f602c658e41@fb.com>
Date:   Tue, 8 Feb 2022 17:41:19 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next 5/5] bpf: Convert bpf_preload.ko to use light
 skeleton.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-6-alexei.starovoitov@gmail.com>
 <9ec1f118-4e71-f78b-20d4-a4c49904e2a8@fb.com>
 <20220209005959.lj5xfgzouuvjum4j@ast-mbp.dhcp.thefacebook.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220209005959.lj5xfgzouuvjum4j@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:104:7::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df83b00-9633-4b73-05dd-08d9eb6d4743
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2082:EE_
X-Microsoft-Antispam-PRVS: <BL0PR1501MB208280C725664D2984A43A0CD32E9@BL0PR1501MB2082.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSHxhCIYPzm6eBMshDWZtq7CxUi6glto4cHXC1dxwsIuFqo5nV/06O7zRVBDy2SP1rzgLNDL8e1Hha1o2iklBKcHNcFFFWpHsjqzOxgWhjUqdfTplT6sRmcbUZNbdOZiPqUYk4d+ANZ0g2Xq7mSgOs8LKyirbhH+5Hr8m3C26j+ftiSbY0XaduUqubPoUl/mmPxRI6qSJWIQw9npLq5ATzyyA6V/2ovIVB0IB0TpNsTs+9ZOAspAS7Y5lZJQhwqONbXshilzG33nayGkX4TRsufQLU6l35FcKdfHtvPc+f+ygvOBZYpNKvrPvrY5gTlbUKRIl0nuspvnB8EHTDLM1ZcKMjNEX+3AQtyyM2LRHGuwu5x5Rn4IyINsFRnn6P+UVG3onL80vQ0BpqQnRcFYhDLxN3wnT8VkJUFsYfaVKLTeiHQrdVH4F7mwbQ9xMYDdhqFwVJoWIZwGVAmC4DglZhbEw8txe+JN7RysxTtxfxM/Mxif3AeeYepMKe/Z8TY1ubXoKTDVqWsAZ6/qcbPENZ/75dgp2bzhaiKr/uwIDPBpEwltp0aiOr8qmvrTg93oEhISBBltYnXZJiYoBaBFMIxfM38H8NeWNBzgM/vA0t1NciUchHt9YybcRLCdTFHbk6Rq6DUBL1EgJCLB87LbdGsX0kDhD4/PRLzT6TJ2KY6gbbFvm+PRFHiAoine9kknpLEMYipClzOQUnDl7tea7u5hgsTJGGiy2s3KHspw/6TilYiPYBIKt2wtMCeHYfLV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2616005)(5660300002)(6506007)(52116002)(4326008)(8676002)(6512007)(66556008)(66476007)(66946007)(8936002)(6916009)(31696002)(316002)(53546011)(4744005)(186003)(36756003)(2906002)(86362001)(6486002)(6666004)(508600001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rno2NHJ6UEEwSFFnTjA4enphcGZFbzlSbmQ5dGJIenJMU1ROTm9Kb2NUNkxD?=
 =?utf-8?B?T0lpSlkyaG9GcVI3ZXNBWTRiQU9qZUtWVkNMQkU4cCsrV2pCdzV3Ym5NQXph?=
 =?utf-8?B?NkxTd2hWQ1BWSGNUYkFSSDlTU2ltcU1SU3VtelE5dXlhUFp6QjBSVHBMUFlL?=
 =?utf-8?B?M3gvalEzVHF2VEx4T25PZGgyYmJQckFKTGZ3eVlFT3I3L2gyRCtPTXUyeW9l?=
 =?utf-8?B?ZDJyZzNPM3VKSWppaWxzdFFhcTRsSXJ1c3pmWk5yaGU2blhRR2NEZzY5TXpm?=
 =?utf-8?B?OWk1QVZVbnZDeklCNzFXOVV3UkhtZ3VzWGNuY0NNTVYzeGJ0ZnhQNVpHSi9W?=
 =?utf-8?B?T3VtU2pTY1kzKzZmVExaUGM0Nis4NmRpdFpKVDhtVVV1ZW1jVWFPcEVzaDNy?=
 =?utf-8?B?MlFDVU9GZ3V1ejJwSWtpSUF4blZ2YjNXMlp6SG5BVVVpU2k4Yk5sVzJZZktv?=
 =?utf-8?B?S2JhZkpMZnc3TjF0eEc5WXUzamVnakhKSGVxT0hpQjd2MVNKTDVGVmErSnUx?=
 =?utf-8?B?elByTWRPQVNSMHl1TjU2VHNJc0dHdjRRYUNLVEpHZkFNaFQzTG1qSXlOWTd3?=
 =?utf-8?B?M3hXS1d1YkFxODVuRnVxdmMyNUFuckM2VHdEUnZPc3VZZVp4ZUp6dDE4aUo4?=
 =?utf-8?B?WlhnRjVIQ2xRZTZvYmJvaCs1UEpaWk1IVDNEZWFuM3BtWGdtYlZPZk42M0ZK?=
 =?utf-8?B?MUFScXlHU2tLOGg4MlNIR1IwRWFwOTlsUWN5MHZFWVJSc2s3cGtuYnRxaFZs?=
 =?utf-8?B?ZGxnZjRBK0lReWRCeXkzUkE3bEp4cnRUZ2FqV2Z6aDE4cjhYVTEwZjhXWTFT?=
 =?utf-8?B?Vy9SYitrb3Jma2NRNVltL04ySStjS25zSHNmeHI2SGc5SCs5cWxjdnhjRVQr?=
 =?utf-8?B?Q2xRR1E2N3I1dUh4TTlod0pORFdBN3pCOHM5UTdlSTVYakJ1MmZPUGxsTTNu?=
 =?utf-8?B?aW1UL004MStPWDBKeW5KTGN5d1IzVjhUZmJLaUhuZCtjdzlFSWRGYWdNWm9U?=
 =?utf-8?B?MkEvZ2E4ak9EYTdBNHJuenNUTEoyRXI4SDcyUWZadFZjaDFraFFSU1pjQ1hC?=
 =?utf-8?B?dHlaelhDc3NhRE9JZnZ2cHFBanRncjYyK0xxK2d6a3ArNldNQmJET0JKOHRP?=
 =?utf-8?B?VVIzMjBsdnVuOVhjYjhvZGVOQU9JRGlxOUova0Q0K1hTSUtibjJFYis0L2dl?=
 =?utf-8?B?RFVXODI3UkZEMENaSXk0dzVWeHdiYlp6ODc0ek1icHNVaXBXT013aDQ4U242?=
 =?utf-8?B?WmRaVnBDb1Y2RWNaYUE3aEZTYzVQNXphQ3BDNXJjbU84UHlVdVRPUWdkQ2h4?=
 =?utf-8?B?dTQyaVZMVVl3MTExY3YvOTdkaDNzeG1EU3VManhUQWpJaS9YQVdSK3NoNm9O?=
 =?utf-8?B?QysyY0NFWnZqTlMrcytIbVQxS0RWLzk2V2RzWEZDYVk3OU12VEY0TTd1aHN4?=
 =?utf-8?B?UHJEM0tRb0hrK1ZqMHdTcFZ5WGxJRWd3NXQzdzV2Q3pyb0xTbHhzbXQveEpp?=
 =?utf-8?B?UExsS1pZMWtwTndxWnIxN0VTeVJGMjN1bmdwbjRyMXh6MXNwVE1XU1FwSTVB?=
 =?utf-8?B?aVhvUWZwRG9oVzZ5RnZ0ZmYwMnZpL2tBRmVnZm5CdGxJbHU2YktCM3NaRFdQ?=
 =?utf-8?B?bDl3TWE3V1QyREpWN0VnbTY0Z1hLaVBzL2pocFRJUkpkVFAyMDlIM04rR25j?=
 =?utf-8?B?ckQzVUtXY20wcnkwOTJTQ3Y4V1d2UjFST2FBamtYeVJRbXc2blR6Z2ptKzcx?=
 =?utf-8?B?aVdES3Q1dnNkL3NPVEdPUDJ1a3l1TEE2U2NqN0syNS94YWlZNWNDZFY0ZVdh?=
 =?utf-8?B?UTJLL0hwdzgyTFRWby9PdEpPdTFKamRKd3ZYMkt0VXhveHJYOU93YTlEYnVT?=
 =?utf-8?B?a1lwUFlkbURudEpqMTRlNXBmTHJSRUFHbjJUNVhtMHpQcmRjWnVHU0Y2amZx?=
 =?utf-8?B?SzM3d3V6L29NOENNNyt0KzZ0akRVbHcwOGhKM1B6bnMyQW5Td0p1RFdYYnpU?=
 =?utf-8?B?cUtQRHpHbkM1QVZOaWF0KzArc0hIaDE2VDBtNWtqSy96S2NmM0xEWnErMlhB?=
 =?utf-8?B?VkV2MGNuV2RxVEVCWWozV2Z5Z0p5SGFlR1RkcWIvdzZtbStESmpsNUdIb1Vs?=
 =?utf-8?B?TWkvblorcEFDSmhCSE9HWWJIaFdJT0w3Q1Vwc2c2blBSRlBUMTFERlJFTms5?=
 =?utf-8?B?K2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df83b00-9633-4b73-05dd-08d9eb6d4743
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 01:41:23.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5BgIjdcNCcjMMSKz9HmNsIvTbnQ0g3tWW1F0glx22P0PWfPRLFPsK4+WS1QAb01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2082
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: -z_5mq80TOFmLhkIWS92gLaollNv_WVZ
X-Proofpoint-ORIG-GUID: -z_5mq80TOFmLhkIWS92gLaollNv_WVZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_08,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 adultscore=0 clxscore=1015 mlxlogscore=599 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090012
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 4:59 PM, Alexei Starovoitov wrote:
> On Tue, Feb 08, 2022 at 04:53:38PM -0800, Yonghong Song wrote:
>>> -	err = fork_usermode_driver(&umd_ops.info);
>>> +	skel = iterators_bpf__open();
>>> +	if (!skel)
>>> +		return -ENOMEM;
>>> +	err = iterators_bpf__load(skel);
>>>    	if (err)
>>
>> We can do iterators_bpf__open_and_load here, right?
> 
> Right. It does __open and __load separately, so it's easier
> to insert debug printk and adjust rodata for testing.

Once all the debugging thing is done as in this patch,
iterators_bpf__open_and_load can make code more
concise. But I am okay either way.
