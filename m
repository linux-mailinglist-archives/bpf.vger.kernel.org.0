Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1C164AB84
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 00:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiLLXXU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 18:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLLXXS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 18:23:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DE65E7;
        Mon, 12 Dec 2022 15:23:17 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCMc9mU029408;
        Mon, 12 Dec 2022 15:22:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=AFQ8fK1hraNxQDJAm2lz9hxa6mwHbab6dX1pQAtZS0U=;
 b=juB+P8Rp2TK2hCD7AeUSIo0GhbqX1ZVEjSoihC18DEeWwtY8JQCojCne7oUNx93qSPxq
 Cbuh+4oqzbQx903S9OK4HEDuzIYeQVQRblijTk5QEGbvaS4TtYiC3dcGfzZXfX/WpASW
 WZ7lqS+O/MUAwcyAiOSSxX4u8t3T22N+ft+wQXypJo1qD8G4VdV0QwqEzuLbqErOTAdp
 8etcrBtoORBb5ebUy5Y6/yN3OOk+T9RG7HHqd5Q27/tqk4Gklus8ORS5TePxZquGo/SB
 +rUtSMFAW6KrT26PHs88viAKvJ7dSfxHgCux6lVxPMekCsFsgKZhqr9LfjlrtUrD5aDr SQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3me4bkdvsy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 15:22:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7kwR2LS/DIbHoEepCuhAfJq/I+k1ts9KKdEQhzIGlYkQ3iLEfmBNyp3GxytXVN3PgpjsputnZ8j8idSuDVNL3ZYToOLSGLbzLJYg0hO4IH4xkfqXnqQDbzVW8svrobeMUy/UAHyVyb3ESH9At973PrbdPdHgVI7J2+OMTXFJX4mNXAbxgi1PdlhTPmCcjtc8Q/iDH5jBLu7dpafaEU821lZUj6sqyhoCXVz2JwYJb72WXe7VL2K5gCAASWs6Y2K738gmKT7Wg+7wWLHQhD9ol/xYnuHb2SwbxPzlqA5PoPzb5WK3bvNQJBJ3twl5MDwsdzRXcdcgggXCxKADaSRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFQ8fK1hraNxQDJAm2lz9hxa6mwHbab6dX1pQAtZS0U=;
 b=V5non1GupE6kUP+UENBcD7nGyQPSkS66kLtHKkzH8JgzEEAJx/0wJBcEJ9A35FCd8UcjhhRKx5+pplbog1/E8RJaqrYI94IrTt/Fdc13kjWIQI46P9gi/3itPVMh7WY1AvBLEesrjTYbEYkRW5W0QGm9xDeFI/b5GvMq892NFkYloUy0MUhuwmGTIruQCvDYHIF/2iKgslJYjjQ80yhNijBwQVBcXsHJcoCyr2U62cw9HUe5yk7KiHgouFrnM5/al0VJ7XVEa8Y7Xv4D2NEDW4mJym9qxG28aDzUVMHdYxwjJ0YbMlWfnc66gN9ZLZXgjE7AHjaJ6LjcNsAIzYM2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2249.namprd15.prod.outlook.com (2603:10b6:5:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Mon, 12 Dec
 2022 23:22:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 23:22:52 +0000
Message-ID: <45067d6f-1752-8e3e-49b5-6349d35831af@meta.com>
Date:   Mon, 12 Dec 2022 15:22:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: check null propagation only
 neither reg is PTR_TO_BTF_ID
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20221212041547.12775-1-sunhao.th@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221212041547.12775-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0027.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::40) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2249:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b5e2d0-4c0a-40dd-e1d7-08dadc97ca70
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s12OTUOo9Gf8cG7jlyyHPw7JH8FvdDhGKg1cTUiSaty9RTFLaL8lwPBJe1fOFlyAe+EdFx+NCrqjrmFXcJStCZ8aYpxwwSS/qfW0EzmlARDYyDC4yU36hG2qqhgMMuRGf2UGkzqhwX0sZ1Gt70d0dSsRKWUqW7TlCPd5dctkyU4qqY6dv1sqx+SfSmRX8iV8GTw03P9TvXDYwCLRNwi7lrIlHixXR8GHJCGjZwphmC51fWCdKDfCLs4zxMNSeTu0rGpoI9Fda8x5l1HN13XxMn3o5dqMDfmCxB2PyMdvXM17m7hxMCXWEa0+IWswCBE4F02cMeDR4VczVy+G0Hrn2A2nyGitD5yNV1z9Pn7hEQ6URvDDqS7TT07exqMO8YeSGrlWgmWv1OI/Emaj6T9Ofrq55bX/bYQQOF6gZ4VwLcRSlpq6O0M3DjIA3DkjFh4Q7Q/RzZJPXwNTBOdvY2WElFMTO3STZKgBN/Zx0s374+XUlntMINVVJDlPVu6MAduNfqtabELePBoq1lFF4TxJCkrJlSPppObr4iiizenh67mIddj72yBwyR6XXfmZqzBsTSaBSXH+/9pikD4QOP5+UuWVwqB9imRMFr7THn2QOv4tmGZR++4lQbO/eDxS02pCiC7pxbcPavmuxkyZ3QgZofVBlS3E+5nebSTnXHimMwJrWeW+4ZauOmucO0sKZ00SDNyCqACpwVgbWHvbrg50Z7+GvoxAZWBDy1kSBAjf6Kw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199015)(186003)(31686004)(83380400001)(558084003)(478600001)(6486002)(31696002)(86362001)(36756003)(6666004)(2616005)(38100700002)(66476007)(66556008)(5660300002)(4326008)(7416002)(53546011)(6512007)(6506007)(66946007)(41300700001)(8676002)(8936002)(316002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEpoek85YnRFcklGa0tEOG82VFBLMjI0V0puUFlCRlRUK1plL0pObkZKTnll?=
 =?utf-8?B?YTFJNmhmTWZqNTUwQXYvM3dRTXpkMkRMaGFaRmw2WlJ1K1NrUDNENUVtY1Zl?=
 =?utf-8?B?WkQrM082L2xVY213OWtFdVQ0Nm9qdGRxYThSNVdWMjdydGR1T3ZxS2VQN1hB?=
 =?utf-8?B?cGF4UzNQU3M0Vmw0VGtnYTFXd2VuWkhTNjBwdFpHTzl3dnhOVjdsK2dJdm9s?=
 =?utf-8?B?UjVaaEV0bnhFYzAzZGpNWW5JdVYzL0pzcU1CNDNUVG16Z2RwU3ZEZzV3TkRp?=
 =?utf-8?B?Sk1WdUE4SndPRVhvTlFpaDF2UEw4Y3dvNU8yOTl1NEZUWGdnQ3JsUnhseDhr?=
 =?utf-8?B?ZHBOMjNYVHdOYXRmWFFSR2hXUUJvb3ZYVk9EVjJMenVzM0xFKy9FdHh4ckg2?=
 =?utf-8?B?V2NWL2ZZNEd4R2I3T3A1dUYxZ1BPNk53RUlQT09wbGJyM05ZaExFdE1jYlJl?=
 =?utf-8?B?cEVwTlJyMnpWSHRTQ3FvQVpQUmVldTlHM2Q4Zm1ZRk1oM3Q1TDVVemhmSFRV?=
 =?utf-8?B?dUVUaTdVSVFURUJzVHhnZGR1TUlLZXJESEl1RDlRZW54aGZOc1NpOFd6UU96?=
 =?utf-8?B?bzI2dTN4SXZjekdNaytPMXlCcmJYSUlyblpSak5TNDJjb3FEcU1zZXlHOW1h?=
 =?utf-8?B?L2JLSHY2aG5rbVhHVHQvL1RVcXdtMUZNUUZSR2ZlR21JMkZIN2tpZXB4Zk8w?=
 =?utf-8?B?NFNVWWhTUXpuYzRud1Y3TldHVk5uenFZNnB4MFRFRjdXWCtDemhucDFIMzAw?=
 =?utf-8?B?NmJYc09BdWs1OUFvckRyLzROdFk5RWdkTllMMEljeGw1RDNvMkZ2cUdJWGk5?=
 =?utf-8?B?Tml5QVljc2RmK2RHNzB5M3MwTm9BQXFmM1RGTVNLVFBoM2EycWx1VjBrdWta?=
 =?utf-8?B?c0RKV3BmRXVaRHM4akxpTXVneWN4a0dYOGJwalhBbkhUQSt4dUc4S0crZkUy?=
 =?utf-8?B?UlhhbTZXME91MXRvQ1dkSm1lbFdhNnh1cGZhaSt1VDhibXZlL3VSMmFoVFBo?=
 =?utf-8?B?Q2NKZExINGxHY0tuN0FIYk4veEdON292QkN4WGRUY201UDhENEErV29RZU9k?=
 =?utf-8?B?bDJmSXZtSURtcjRkb1lrZGk5cmFMOWpWcVk2dkF5a0V4TW85b0pneWZvUVAy?=
 =?utf-8?B?Tk9hWTdwQ3JVSlpUak9EV0xVMmhMVmlhQVZmb2txRk9NN1VGb0VLOG5xc1dp?=
 =?utf-8?B?eUVRRUtIak1HcDRUWkFUbHNmdHlxWE93Z2xUaXloV05CclNJYlhVTTdIRE42?=
 =?utf-8?B?eHdkeTV0Zzh6TDA4Ulp2Lzczd2NSU0xseXk5YkhJanpZTEp3VldObGRuNWhy?=
 =?utf-8?B?TjUxWmhJQWZqdGhFTVY1cDRDM01qV3g2V2UvaHhSZmlKYnZITjAvSi8zRXFl?=
 =?utf-8?B?bm9YTHlIV290VzJuZVl6WCtFRUVUQmx6TDNyTDZlSTBteUJEd3AyUXJpeTI3?=
 =?utf-8?B?cTA5azNhMHMxNUpySnNnQS9HWUtOSEZ3UHYvbUFWMXh4NHpMd0JRVDJ4RkZV?=
 =?utf-8?B?Z0lMQmYyc0g2RWdOeWk3ci9YUmJvSG45T0t5UUk4dU5ZbXJaMnpORDI0TFRR?=
 =?utf-8?B?Q1pmV1N1YlhNRXo5T1R4K0J6ZWZCNWVCYzJ3U0pLYU5MbTNxZWRLZVoxc1Zh?=
 =?utf-8?B?SUxmOSt6MWYyTEoyR3VvNUJ2YnNTQ2VIYmdYVWQ3c0RpVzRPZFRBcFJJcHFI?=
 =?utf-8?B?UmN1bHVoTmJ0SkNJQWxHZzJ0MXhlbVlEZ0taNVViT3R1OHdvSnB6NDBudVFR?=
 =?utf-8?B?NTByMWUxd3kweUs0ZWlKZ1MzQzNiL3MxN29UdGJxS0FVdVhubnpVRlRtYWJn?=
 =?utf-8?B?YnJWYXN6OU1JKytCOWt6NWRUeFd0MDMrUGtGL0k5UkZSYjByUWR4S21xeE56?=
 =?utf-8?B?a0Yvei9xMEFDbmdKWjluVEdmcVR6MXB0L2JDNzhXTFJMSzI4WVhBb0J5bm9U?=
 =?utf-8?B?MTU3UXIxQStVOFAyc3VNdHFMdkxOZU5xZHhnK0tkOHBYSVRDOXR4WkFrTEV4?=
 =?utf-8?B?RWxMN3pSWVd4d25FR2w1Y05hd2ZTZk4rTW54bi9XeXhKemY4c3BGQUF3bHNI?=
 =?utf-8?B?azh1NGtJZU1qN2oyRHdHNmk5Z3NjdTNRWVduTlRUU2QrbTlhVzRzS2RMbGdC?=
 =?utf-8?B?M2JiNnk0KzJ3a2dRbHppUWVEcTlSUUdibE52WmpTeWJOdzdjaGk2MkNJZlVQ?=
 =?utf-8?B?bEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b5e2d0-4c0a-40dd-e1d7-08dadc97ca70
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 23:22:52.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVdcKohJsv79NQ8RZ2mOEzD0r6gh2dyWgtfpXGZ2b7UOoZ9sX5vFAIW/o+Zx+6IR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2249
X-Proofpoint-ORIG-GUID: fLvQakG9HcHW7Pyb193SvBEe4YjICzYZ
X-Proofpoint-GUID: fLvQakG9HcHW7Pyb193SvBEe4YjICzYZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/11/22 8:15 PM, Hao Sun wrote:
> Verify that nullness information is not porpagated in the branches
> of register to register JEQ and JNE operations if one of them is
> PTR_TO_BTF_ID.
> 
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
