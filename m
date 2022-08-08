Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5687858CB4E
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbiHHPa7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 11:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243727AbiHHPao (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 11:30:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B56B14035
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 08:30:42 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 278ClJ1v026982;
        Mon, 8 Aug 2022 08:30:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=C4UGcv6Soeg6nJyDowuovxC2sw4Vqyn9UGxFU6ZyK7I=;
 b=n2m2P6So9f7Y005vhQeMRDPed2UcY4ka6vkEKn1uGgAT0ubks4VXAiYLA/TweyuWsR3U
 nbj2R2zG/2OeZIZoRBd4OJILfM2ADf7wGW1ORWDMKyzvfzmdmgiVNmWmw6j86ioLdIru
 tbnUMavzSlemCdXzNpXJK5MQgoPTixeK9Ms= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsndtjfxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 08:30:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBI/fgWKGEuHnXoLjMnFMskyiJv7NQ5nizgwPGvoJWcTQGsrn5c+j4Dr/qV63D90ld0JAx4mjVMP0ileCY8THYIU4DZOQoF9lVbtAi/LQQJdW9gA1iAdwW55aIRwEw6Bd9H/Thqs9VKL2GTCSNWDM5mTTuj01DGEnoBxO3XOD376tfIukZFpGlJzg67GUsqCR6UgmSusXMlKazsVXzOlV/lpQ7t/a5C0Z3FAPhrUqWv97Ok/0iX2DgZkoKv3GUF/SoBsIXeyjA0JeEo28SFdjf3ZqgA7iETrv0FaJq21cmjmjmvWxuWr24w13mAB1n8XYPa5LyJvVbpxDX/enmDm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4UGcv6Soeg6nJyDowuovxC2sw4Vqyn9UGxFU6ZyK7I=;
 b=IZTx66VG2JFA1QXWISmVMqTBvRr4VNkbaQDE+IEJk7Q9/7Mx7NEAjXwTinBwvby3ASbBiQr6i/5Jn657qVxKqme0O+dvsdZDDR+Xx55V6V6KFRo4S47G8xOHSFZymsMZNLzIk6AqTsjdRWK8Q107xef3w+gIGWeEdSBk/N0dOCxc14DTKKZlYPq9QL69W0Fn/6ON2Ees+Ii48KAJCPs+sf5ulzBeVBE9bBHxOrOgPWwgPfbl7/NuHlS8ZiJ6/Qjubg32mpP1kVTaxdpKk7w8lYcB+Et0EV9oim3LeX06OjMzEBJu2eCBKn8rFHrs6kK5CjqzoqiPGoaS9zc330UoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1183.namprd15.prod.outlook.com (2603:10b6:320:23::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Mon, 8 Aug
 2022 15:30:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 15:30:07 +0000
Message-ID: <67a8da59-4afc-5706-dcd4-f12d159fd92e@fb.com>
Date:   Mon, 8 Aug 2022 08:30:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf 9/9] selftests/bpf: Ensure sleepable program is
 rejected by hash map iter
Content-Language: en-US
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, houtao1@huawei.com
References: <20220806074019.2756957-1-houtao@huaweicloud.com>
 <20220806074019.2756957-10-houtao@huaweicloud.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220806074019.2756957-10-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85031220-a837-4cbf-bd6d-08da7952dfb2
X-MS-TrafficTypeDiagnostic: MWHPR15MB1183:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0mw4V8qs8+lSyJf7Lgy2zM8BPSm2pklNgFrN/WBewPGUcMgqrrF+Zcl9kwoaYpCYGbS/3NO6Q94782ybJgNRKIv0Wr5mh4Hc/qZE4Mm4h3mFdKNmaEZ/q3Mvg0PhEpu1uhQVaxK229DFXoaQ91gt7VBE8WbxOjWm4TDoJW0gTjF7Re1G4QyNg/IURdg0r9Pw9V1GSJPckmdIWTjsR58IUDjnlsMXMFkxg429P0TGzo6mAqOeNaqYt/t3cjR6sASka/HLNGOGZ17OskyuPNo5puny0pUualtKe+bC2ymkf0Q/Y2itnR7Ti27KAkzFc5hpNULv4DxXPcXPwYhMrXUtX3wAyAaDjnN2resOAm+hQhDASy5BxzgVHr5Rewqrof0Npb0sR01gIAPu55gLgLgwgjYlZRqRRiZ/RyO1aYFxXeAHylcl/hLfLGgw5wQz++AKii4TLcocBkAwbKka/nXEnciQaBMYueLE+T/r7uMK4kPvyNhNdpOqGGtYay2ZTAd+oOv6bA9s6rfIY3CvAiIIEa2rJL6num/Qpl1X++JujYZ3NmcS5Qrz76SPe743iWDWnFxmt115y2ddndLVm4fxvSF65iOkobMBax2LF+3mRcNuTASP/hccJrfV0t4AXnmh1ZM77K0nfst6MW+iA2B1IOVubHXgliiJ8q6mfGEIK89ck99EQB5hxvJWIn0hEeioAqtsIg5Z/aREUgDP5L+g3z+8Qq5R4opPpGMD7A6lUT34SBXWOYHeVS5cENp9o3op5zbt7r/zbj80eEbc3YdRZqmJMxY8KKlR69ONlkDSAfSDUQBYOEWU63tbg6XITHylKCa3ONCxuF0tLYqjpYUhtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(5660300002)(31686004)(316002)(54906003)(7416002)(41300700001)(6512007)(478600001)(6506007)(6486002)(8936002)(2906002)(53546011)(6666004)(2616005)(86362001)(38100700002)(186003)(558084003)(4326008)(66946007)(66476007)(66556008)(36756003)(8676002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjhyUEl3MlR4R2Z3WkZYMjlwTHUzbGxUdFdnN1loRnR3QzF5a252Ump6MVh4?=
 =?utf-8?B?WHFZRUpvSTBnUUR1alJ0L1hRY3lMQU12WXo5SmFJU0J5MWhlaHQ4ZlZtOUVv?=
 =?utf-8?B?TlJlRXNTT2dyS3cwcC82RE9uWExFT3Q3ajlkcG0vUjUrSEthN3NrQldxU0VJ?=
 =?utf-8?B?QnZjS0pJNWUzazZRc3hhTjJqTjFyYnk5MTRpUUVzV0xHZ0x5ZEhzUTE4eEdr?=
 =?utf-8?B?MERPNzhhM0J2L2pzdFlUVURZSVJXT1g0d1g4NUNSR2IwQXRiU2dmeCt1T1Az?=
 =?utf-8?B?NXdKZkwwWG83b0k4QXl1WVlnNEpkWHJ2VStHWFZadWJLcEdPRC9teUp2L1NC?=
 =?utf-8?B?b2Q4MnJINjNPMmxBSElxbUhNY1pHNytZT1JxUDVHVHg0MHJ3ZGxWemUveXdy?=
 =?utf-8?B?Y2hmdC9SS1pkRFMzcVdyY3FUZlphcDB4L3BVTGEyUnJ0L3IweVduUm9wTU95?=
 =?utf-8?B?bk5ranRYRG5wSGNBMisrTjFvYjVtc3V2NWV1M1ZZK1I5OWRHRVcraEtnNENI?=
 =?utf-8?B?ei8wNERQZ3Y0M3BrbjZZeCtxYWppeHBibUNWZkhRVlhxM0cxWi9vKytvY3JU?=
 =?utf-8?B?TjhFRmZyUXhkejVmYnVYbjg3OXg3bnFsWDJuUDBYeWRaWjR5bE95bVdoNkg3?=
 =?utf-8?B?K3ZPbGd1TThoUjVUVXVSUXNHWnNidzg1cTlDS1ZVbWtqYzU4bzNxdDR5d1Nq?=
 =?utf-8?B?MEUzeXhmTUovbUpJb3NFaTYwUGYxNXVaZ0ZaeksxS3BHZWlSTmIrZmZZaXZE?=
 =?utf-8?B?K2svUGtGM3VaMTRPWWFkd3dKd0puY2RFSjNJNlM4a1A0K2EvWDRBOVNiVzZQ?=
 =?utf-8?B?Sit4cUlLaGd6ZUorM2diaUo0cTgzT0pHc3NKdytFblM5QWI0MGNWdkQydWpX?=
 =?utf-8?B?cFB0NktVeFZSeG4zWDJ6NG9pNkJxRFNuQ1g0b2R6WE1tMGpRQWY0UGdMeDJE?=
 =?utf-8?B?d0p3V3dVNlpNSTNoTWl0M1hMWVhDNFNjdWo0czNmQVpsZ25KbTRUWnlpM2dz?=
 =?utf-8?B?cU1CdEUvdmxaVGU0T2tVTHJCeTNUbjVTREo4OWpxSndCamRMUm1JbFlHME9I?=
 =?utf-8?B?ekIxeE1iemlNSElVVG81WUF1OWlzTFRsVkNMdE9NZ2tBZW1WcnJSK0xRTGN0?=
 =?utf-8?B?Ly9xUDh5NXErcGZKSTZIYm9zdmZCRThRaGo0NkpTakJTRmUycWllVXhaNUNv?=
 =?utf-8?B?bmVXaGhMVVF2VVY3MDNEQkJvVFlOMzFzWmxJNk45OHF4eU5NTFNsanVoRmFV?=
 =?utf-8?B?eGRIY3l4VmVUWmVSQkgwRGtnd09Fejh6WHVESnBHazJzZjFJZWlSMVBZNEgw?=
 =?utf-8?B?cDdWU0ozSVVJdnZpR0NuRjBsclZHV0lvUnRwL0pkMlFLamNhYzE4eU5Hc0Zq?=
 =?utf-8?B?VndkY2c0eFNwQUNLc0xyRDBnY3Fqei9pRHlwYUtIamo0cWY4c1RsVndXOWoz?=
 =?utf-8?B?bE4yTVZlYXh3VXlLcXBTN1FPRHlxTWMzdTdQeXE5bWdpYkxxemVGVkFJTm9l?=
 =?utf-8?B?bVJUcCsvbUEyOFU4YWlJMy82cUE5QkltYmtWTEw3YkVhNWN0WnhsTDNzVjlR?=
 =?utf-8?B?M3RBQmxyTzZPVWg2cDBpdXZvdFl6VVhqOXJXaVp6SGpiS0VONzBTeXV4Tytl?=
 =?utf-8?B?OGI0MEhoaGxyR1hOUlBhclNuNmhtSXZIakl3d3hJSGpzRWJVbFFRY3FmT0Fa?=
 =?utf-8?B?d0VmMHRrS1FwSmxkSzhLSXFJOCtGQzZxeVF2azhrVkRuZk5TelI4ZkE5YVZB?=
 =?utf-8?B?LzlPb1ZqbkVialp4cXpIaHhmV1c0U2Q5Tk1iV0pkVzl1emlGeUIvZTZhRGdI?=
 =?utf-8?B?SUQ2TTZuRFFqTzcrZG1yTXpUQnlka2xhbC9pZ3NzYytzdDVQTklFaFoyZm5s?=
 =?utf-8?B?MXBpUjI0OE8zOVpmWm1kYWhPcjhtanNUeHRHV0IwNEpDOWJEL3FrZjg4QWdS?=
 =?utf-8?B?NFVmZjJHWktLWExVaWYyemp0K3VZcTJ5WTlLYkUvOC95MWJ3ZG41dzBBYWRB?=
 =?utf-8?B?QVFoc0diRi9uVWJBYnNMR3Nodkcyb28xTk44eU1YVkwxWjUrd2R4MnorTzZM?=
 =?utf-8?B?bkJiRXV0c3kyTXdNdlpDWmM4L2FkZEhsemJQQjU4R1Y0ZVJjV0V3N3dWVHBZ?=
 =?utf-8?B?L05EOWMwNElKWDRlT3d2a2pld1ZYSGxUTjA0Tll2RWxTLy9rQjFnYURBcEhw?=
 =?utf-8?B?NUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85031220-a837-4cbf-bd6d-08da7952dfb2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2022 15:30:07.4908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFMHveKm/9Z5FiOiJgeK66OW2U01VMMsO1ik1weHHqDuHsc/wkAg88U2XNSgVA2K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1183
X-Proofpoint-GUID: -EZbCk7ZCPBDgGeJaKJBr_o3U0sCCMI_
X-Proofpoint-ORIG-GUID: -EZbCk7ZCPBDgGeJaKJBr_o3U0sCCMI_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_10,2022-08-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/6/22 12:40 AM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> Add a test to ensure sleepable program is rejected by hash map iterator.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
