Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690B5BD8A7
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 02:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiITAMt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 20:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiITAMr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 20:12:47 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E743300;
        Mon, 19 Sep 2022 17:12:47 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JMsuCm020039;
        Mon, 19 Sep 2022 17:12:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vWjlwUY5xDkiRThHSU63n4prfpenRMDzsJwz8deLEVQ=;
 b=KwFauZ+YbJYYTG9NNH7oT9k650NeVhd5XagUMozYEXdU9IwhGJIokswXhJg0748sWfQv
 Er+wopZ/GAVWn4lTkOipK3jKezuRy6Yt066Qb7zqUG0UXanwEJVt/sYVi/fa/nYVJvLY
 7T2hWaW68kc28egNlkkypyBuHatmEYeU6Sc= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3jnbrxq6h1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 17:12:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVJwUPPKmqoyWNGm5WYk75z+G2fvExqwS3mhxg+dx8iM8+dTlGilnFvbH7nwyDIL7WRicdB/p/oAXllCGkfcTFA63ASs7kuTHZ66BeCzu3FeEuuVbkpenLtuxZ9ClWHnJ4McJQWr7QGRPVM5HOKYYdlFFlNh2GaJTsFJRaVKQDpfvUXQA3vxd+A13+16H/djDT32pi8+jhCXEdpJ4lELVpeZHJQSDk8c0L+BFP12+1rIQEetX4Xvwds+pGFSkzSQK7gPbrW+xFxvrJef1l8GkD0dcwKctZB5eRjZ+RO4hadC9gME7o8o7Fyj7dY8ijpQ5fRXXF1ITYpl9pJyzNNekA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWjlwUY5xDkiRThHSU63n4prfpenRMDzsJwz8deLEVQ=;
 b=fBM2J840/Ut6i9tNXcC7CKDq8KtlzyzWGQqNBQi1h6ARJOAnbOltvvKKZthdLAtU5aqrYiUOpq6iUjaLrRun8sUwHI1mkgy9GBvtTDWd9vrVNx3Pfdr2gcx16J3eu9JvQ3iYiesVkNET1GtwqIoxuMgHd/j9HGGnM0lGGC6GUobjRCfQwoXPKTsyHJVmftj/O6Cxzg/968WmMjEsl4L/4TLmu3rKc00GOmiSjiifQP2bASFuhd0U6x43qBtVPNYki/E4U8Egd6YYoh4+eFnTBQTP1Zb4vBVnwUvJOx6XHsuF1JrSbZMbKTG7WFkXaEs/lE0BfEZCEUj3Psc440mBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1621.namprd15.prod.outlook.com (2603:10b6:903:133::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 00:12:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 00:12:18 +0000
Message-ID: <9b894802-7342-b911-d5b7-e3b191fa3136@fb.com>
Date:   Mon, 19 Sep 2022 17:12:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH bpf-next] samples/bpf: Replace blk_account_io_done() with
 __blk_account_io_done()
Content-Language: en-US
To:     Rong Tao <rtoax@foxmail.com>, sdf@google.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
        jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, rongtao@cestc.cn, song@kernel.org
References: <YxtuR6hWUkGfiWya@google.com>
 <tencent_1CC476835C219FACD84B6715F0D785517E07@qq.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <tencent_1CC476835C219FACD84B6715F0D785517E07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0326.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1621:EE_
X-MS-Office365-Filtering-Correlation-Id: ff3bcda9-1682-4a6d-f7fd-08da9a9cc7d7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4cQWoPxnlSWs9xjy/GjHrjdkAXB0uSQNGsFW5LWCufMQzAB+f1jBETVcqAgs8SweMNHTC+Upono1tszaar2JA5LPX2Af+6ztBoj5hEjK6zK+xJcFT2bwLNQb+rbFr+SJj15uQjdluvENkjGnNYvUP7tu34fi+jMGKnW6KpCoJKJq8m593rgu5JjDWOariE8+olE8V+SbHeSlvFv0lw7dTfMABZ7DCgz7esIG6vKF2YljjAIiIh6+0sD0tA58/D6RhVZ7pZzOGsmPwjBV/l9pNmxAYx1KRLWFd5hiycob69hNKqXv9kmMXJXVeJIEF3nIFYHJ+LJaKr5BZkrAcDtM8pDKRIHcRBbevvq4ChdkNxbhj7VpLKFjx83dFx0nuAUdiM5DHprGNvhYNQzSsLikPK5hqqHX4qpjpLCxrbIKabKezXP6YHDQW7XUPCLheN0+d9qKBFGsao13hUdzbAMG28X85wb+4vRDpZkaBS5NQrcxPfOKj+MNwjPs5uKChEkerYmuMNb37gp1+2P2VczRDam+/I6VyUeKQ+fGh2vXA3B8FPDa2HheJ+a5Iv3WFiavvay5Fs6BGECCc6N+BuufNd9jHLfO5czpBOgx6XFU+L9vJYcWd+DRgdlVUwoVOi9CEtBjwzrn8uTGnxznkKrI4hPP28cykUjKS8dyOmyDVcLPSgT7GKNndY309HBLuck8VU3O6QM2xJzo4r42q02in+DWg4QXWItyABu66f0HoA3TUOLcttqGWPevoW5AgijtkqIQh1kozqzHorOtQ2C63EiTJffUsKFhZbyOsvR5wKhMLYV+1GXGutW/sWw/KneuFmSRA2Ox2TSVYrrn6jSiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199015)(558084003)(31696002)(86362001)(38100700002)(6486002)(316002)(8676002)(2906002)(4326008)(5660300002)(66476007)(7416002)(66556008)(41300700001)(8936002)(66946007)(186003)(2616005)(83380400001)(36756003)(6666004)(478600001)(53546011)(6512007)(6506007)(31686004)(48020200002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmRhV3d5Nk1zby9kQ3hmMXpsVVg0cHMxN0ozeTNTNWJNZ0VCNVFsVkNXeVZ1?=
 =?utf-8?B?dncrQnZTNGVsMElsU0pIZ2VZOUJocVZEM0F3aFpIWDczOGF4Z2pOU1BzSXVC?=
 =?utf-8?B?aEZCa0tpamVSemF1V2UwdDUwai9nWmlrci9yL2M3Z3loa0FHelpDWnp2amVj?=
 =?utf-8?B?SS9Pa25iS1luYjJ6aU5UYmhDRXBIVUdxcHFXbUllR3hZWHNpczVWMDVqUTNu?=
 =?utf-8?B?cnpXUitoNjVibkZzTi9xbXhmbzNxRGJFc1U5V0JPblBodk1CUkhZZ200VDhX?=
 =?utf-8?B?SE8ycHF1dEUxZ2tTRjlWUnh2aEp4d254YTY4OFFyOG5hS2FUWEsxMVlsMHRT?=
 =?utf-8?B?UEJKSTBKbmlZSEgwSmdGMU1YeFNINENjM3JzbVhGL0ZCcGRiSlMvckpLSlFB?=
 =?utf-8?B?RkVzNk9TazZ5T0VrTW0yb0pSeFpLVXAvOGhZUWJBMEVzVnBIZVRBZVpucEZs?=
 =?utf-8?B?ckJLbS84RXNILzNzUFlMMEdNSlpVQ1FDaGQ0YjJabGtoQkxhcGU4VFdVWFlB?=
 =?utf-8?B?cTBoRkhoc0N1TWd5ZWVjUVREa1RKNGNJS0RKenVVZmloZVpqRzZFOHlkTXZL?=
 =?utf-8?B?OGUwTGM4MnNUNmxNaG9zVDZ2aTNnT1QrdWFITkhNdSt3aHJ5SFVjS3diVGpI?=
 =?utf-8?B?TW0ycjBwVXpJbGJqUHQweXRpQzdiU3U1U1FWMkFVQWJmODJNdDBOQWp6eXZY?=
 =?utf-8?B?dHVWd2VpRXZMTnlKYTRBZWZUeG5ldVBqbDNoZjBOUUNkbDJxMVZjZWFNbEky?=
 =?utf-8?B?TitoREJEcGFHem1GYnY1NnRGNWlVOHlXQXZFRTZRQ0xPejl4OFJNRUE1YjF2?=
 =?utf-8?B?ODhtODlJSkIvMEI0WUdkdEVWYUJnRzV5RFV2NkdwWWxGeWpxWngzWE41cTNH?=
 =?utf-8?B?d2JGeWpsNFpXZVdVY3lDSXNheElrV2JSTmh2VEVMa2lCYzVVbkkyRVp5Smgv?=
 =?utf-8?B?WUxIUmN3UnJxTFFCWlRhc3JDZWUzSC9TWDBiOS9sakRWWG1ZRGcyNDhQTVJs?=
 =?utf-8?B?ZDZaeVBPRFpFdUdlNnAxRWRGQTd1aFF4Q01yL2txdGFjbjdQYVF2SGxaMitq?=
 =?utf-8?B?M3MweExxYXJJTzdZQUhNR2MzR0d4bnEySkMrNk51b05PVnlWN0FKQlorV3VF?=
 =?utf-8?B?NE56RExJMEN4WTduRGxmMXhEWVRqeE0wa3dWVFJEdUpyZmhadlRkQ0Q3aVNJ?=
 =?utf-8?B?OUtMODBscURqUmVVa1QxZTJicVJQbmdadWU3S1B5RXZ3enBEUE1PL0ZzMGhH?=
 =?utf-8?B?OHB4Z3FqUmhTYnJTeGtuekIxNDcrQkw3RmdXeVFEdWg1K1BRR0RhTDFPR3Rs?=
 =?utf-8?B?cEdObDlGUjRndStGUWxBTTdidUJjTFBZRm4wZEVaSnpzbkNGaU96WURhRVVH?=
 =?utf-8?B?T3lDRFVZTllTQ0FBWHF0WWJkc1lpRE5BcndYS01sRGpkdm45RnJaQmovZDln?=
 =?utf-8?B?eWpZbmhLelRaOGFjTDdGUlFtSW1jb3NtTjFtdXlmUkl1STAvdU1LMU1vVmNQ?=
 =?utf-8?B?ZXhDeTlXZ2NKU05CdEJ6MVk5VkdVQUxvK1hyMWhpNjRDZit3SEJaNktFQVQw?=
 =?utf-8?B?QTVXZjNqdldZN2w4ck1LbGd2VHlibktvcVEwVGRtUVJvdnNWakZWa1FSbFp3?=
 =?utf-8?B?dGs0T2cwYWJkNXVldlZ5ZDd3MFM0UjNVTjJGNWxiWFFGZmU2N1JEVnZMU0dL?=
 =?utf-8?B?clREd3NEZTN3dWhJZVNjdGNHcWtaczlJdEgyTnl1OWN2b0Nrb3pQR1VFMkE3?=
 =?utf-8?B?Z3duNUhVdzZjM0ROVHhrTWszWnFubXViSERlQUd4Z0QvclQ0dmJONjZFZzFI?=
 =?utf-8?B?UUdLMWhscG42OXVPMnZleWczekVVMlJNNUd3QnlZUE5odTZybUJQMmM0VW8w?=
 =?utf-8?B?YXozQ2xOV0lHUWhkdGl4bE8vTUNHVkVidEZrVUlTcDdIaFVkZmVXc3FCckx6?=
 =?utf-8?B?SGhaWmd4a1VaVnozdnd2S1p3MzU5RmxsN0Q5eWJjRzJhZkZkSzdUQVR5dHBn?=
 =?utf-8?B?bmJPYkl3NWU4MUR4Q1NQeHhudGVxNUR2SmRDZ2tsYWcwWmJrUlpEZVZKbFhm?=
 =?utf-8?B?c3RzajBjYmdBTGhwY0VyMjVVQTQrTjdOV2ZvemJPSE82VTBwWWxwM3NpNXV3?=
 =?utf-8?Q?PVuIkyYr6s2CtSBwVTQ0N0tEm?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff3bcda9-1682-4a6d-f7fd-08da9a9cc7d7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 00:12:18.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vz1WW9OzKQ8MaKHxYzp9CuJXyTOMk8emiU0D/TXvydbrXJgeXRH5J2W3tcVlPKG9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1621
X-Proofpoint-GUID: Q-7aONHVrNH49FAvg2LaBHBZh8bw2c0F
X-Proofpoint-ORIG-GUID: Q-7aONHVrNH49FAvg2LaBHBZh8bw2c0F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/11/22 6:03 AM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Since commit be6bfe36db17 ("block: inline hot paths of blk_account_io_*()")
> blk_account_io_*() become inline functions.
> 
> Signed-off-by: Rong Tao <rtoax@foxmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
