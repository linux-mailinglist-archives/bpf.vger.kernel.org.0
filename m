Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC864F16D
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 20:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiLPTJs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 14:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiLPTJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 14:09:47 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76DD6E9C2
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 11:09:46 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BGJ95Xl021611;
        Fri, 16 Dec 2022 11:09:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ez03DLSA/KR8C3ZUB9krXa4VgilzkjmzFxQDmaEvT24=;
 b=C7W3PniUb6rjXjMV4nvi6ZVS/ZCQiZ73dDlm8IjIAcBKV+p63wt/e7UGvUx6Tj44PENn
 p4SGC/VOxSvQn0V36Rc0j6azebLUOy4SM2Awda6JB/fxCRSJZ+y7NN+l/ECL6U+3URge
 bbiFovqlovo3TASZUL5BO3XimgWHCtItatrkpafoIi2uJe6cmzi/gGzedfUTiHycMBL5
 fa77JPaSeMtCV+A8vIZN3Ld+G4qPp7pPGjwH6syit24EC6ju/qReHGlTIv16kZMBwf+G
 xJoCc9dl4GUGFTQsLD9WbbR9otnKUJZqeGuwf7la7rX0FjbiykSqwHNwa+A4HJ5TKClQ gA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by m0001303.ppops.net (PPS) with ESMTPS id 3mg3hn227c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 11:09:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEnYEkFQHAAH5BMn/Q51WTVjinm6Z4znitnktnCiab3RCm6csvsG0WdrNT97zc84ByuxJPUUpmHUelsqp+pUAhUlSjZbb8Z7viutGtSYdH8mxfHCHJigIuxkyL7I9ugwdJrtH6/j3RQa9rbVeMNt7pavu03SVypRy7ZSHR84cjku2JFl+Ard+Q73jbp8ikMaxIWIzmZVItcG9nXmjlOveGxsR3VfUcaEVgDV1IfW34CJFVKTNCHxx0KK7lekpKiQ/74nPk5UPV6H7Qjsy3u9aW9hHGUrX1Ez4posonEf+PqpyO45iAeOt8oEyFaci/nJfhC9sN6qL33BCHKBZdSfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ez03DLSA/KR8C3ZUB9krXa4VgilzkjmzFxQDmaEvT24=;
 b=O1Xt1Xs1EgCtIjsOhJ/Z9vusX0ue7SjE3dK9pgw92Z6VRABYL00SVwjrz98T2I5M5Wyhpd2IRcVafG4VHOHdNls3K2WMMHSi+O80YpvhIJH1DMhtpm91zxCS5lJqMFOCY7I56Ew9H6jVu4/3XBLouSnQDDKNMKUAHzHjrDkN0VPQS6eLx8OIIQ6zjgL3O6BSRvsfMfd0v+hPfDu5nDilaS5kr2F/HTIZJaPqRu9Hnkta7DLp6VLBpf20DM2H9Q00lm0xU0VtcldSm/genroO6vhHOXZ94mxBWHbdfnjXP47vWKLDcHaYO7YlRljXhpBTPf/1yjXzAiVibBnMNFulVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN6PR15MB1537.namprd15.prod.outlook.com (2603:10b6:404:c8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 19:09:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Fri, 16 Dec 2022
 19:09:40 +0000
Message-ID: <c29f26ac-3b99-4603-295f-ffd80d9223d1@meta.com>
Date:   Fri, 16 Dec 2022 11:09:38 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 1/2] bpf: keep a reference to the mm, in case the
 task is dead.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@meta.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, kernel-team@meta.com,
        song@kernel.org
Cc:     Nathan Slingerland <slinger@meta.com>
References: <20221216015912.991616-1-kuifeng@meta.com>
 <20221216015912.991616-2-kuifeng@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221216015912.991616-2-kuifeng@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN6PR15MB1537:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b4ff4be-0cc3-4fff-67ab-08dadf991535
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6SCzpXkJNwywqkt//T+pcQkqh3DXvxHjafPslwhgHvSiXjtAov6BYtuuAHml+yYmU1zp5cw61zioSJzgBa7+pwFqNC3Un3oEymlPu4kkEFjWdPX9L9ebooQInApaFwd5hyrrAi3PklVM3DvlNymB3veEKDXWaBipTHA1LQJ6GwKnAOcbU8f7oC3Imr85qw5sCMYVB9/g+x+LRMRXaPZLWE/uxCU4dADWzdMgMGT8pO23CUBDV6y4qssCxUGkclTQVaRfSYqfmNdB2/bZHrk6dk64B5HUbhxX4FU+3titQmOGxJRqg9B+E3qi7vy4F+Dwj1PPdI32OQObAjFAKVU2/8zv+hr2olS/Ftan0pANL6WIZc+aMIy5rKNJKJbD3VDBtLzj7qwK11db0ic83CTRkpkKIJ/KAxlCiWuojgjVghDYS/lwtQgvO2C83qAoK/sJRAdp3wYMiU/axDkw0DKIBYriHxqjbuYm4PAYiyxrU02Z4CKfAguKQp+aHJxKxv7wjDv5tZzJEWTL7M5/NJAmkKQI42rzd0a+aXpA9DOegywW8qn78gAWaI31J3AerMMIo7viCSylMNGRCttTsVWA8qYuFN1ymfb79rK17VEqcJvAnUrhCqvs3z7WHQ2CfX9nF4OrTy6NnPcTCtHJAfB07/A19bsNzoO7MGUrLwfm+YcDQh4g0QalN2+sMm6MIXAVpO+7eEZUntm6NZI8RMh8I/V12JKtL5/4Xn52V6bM/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(451199015)(31686004)(2906002)(5660300002)(4744005)(8936002)(316002)(8676002)(41300700001)(66556008)(31696002)(66476007)(66946007)(36756003)(6486002)(4326008)(107886003)(6512007)(478600001)(53546011)(6506007)(186003)(2616005)(86362001)(38100700002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzUzdUt1ZmxHeHVnemw1d0VPeHByQ3QwV3R1amcrNlVDSFFybGtnR21KbzZY?=
 =?utf-8?B?YjEwTkY1bjRZdy9GYjU3NGFuTlZDVFR6N2t4WEM0SEVNbFBSY1VzWndKRVE4?=
 =?utf-8?B?VGVLZkFMS0lWWGNSNGM5MTNNY3RvT004OHViTUhxWGdSMnVUYWV5ZmhnMEcx?=
 =?utf-8?B?VnZGRWsrN2VnaU9tbkUzU0EzMEg4U25LMXBuRk1BOXlCSUZPQWVpTzhnMEJG?=
 =?utf-8?B?Smg2bmlXb2IyQVpkalhXN2hDbUxxemtsNTBVWWF4ZnJwWUMyelprZE5jWlQr?=
 =?utf-8?B?c3ovSC96eUtkS1lXL2lncERDRTI2VjlmVGVaTlVIUi9DQk9yVUs5UTNvZkxk?=
 =?utf-8?B?VFM4UTBPSFVjWHpaUytIdzZ6K2VqT2lySGIzdWlqUnRYZmdkYjY4MkIwV0kv?=
 =?utf-8?B?Z09uaUxGMWp0MjM5anFrNmViR0FYaG00UnlBNXNmVmN3UTdPbVJEeEhXNXMz?=
 =?utf-8?B?a21JMk5kNURWajRocEdGZXNlNm1tNVFTMkMzVExsTFhWa3FwRDAycldXR1pK?=
 =?utf-8?B?TXJIMWhpQWRncndFWEEwcDlPZFNmQm94SHVoZFlMZFQxaHh4NXRqYWFLVTBo?=
 =?utf-8?B?eTJ6Ky9jcHFJSmZucVduVHZmaHJvNzhtTHVhWTkvYk9RT09jT1l4N2pjQXlS?=
 =?utf-8?B?eGFJVUdlUXlzQ1UyRXJMOStoWXd0eERWVlBMbWY5UEtaNldJT1RPTUZ1T2hY?=
 =?utf-8?B?YmVTdEY4N3NSVldyRlFOSlF5aUh4NHJZVlpVWTNZK0pKYXMrUzh1aHFVbjZM?=
 =?utf-8?B?ZkhHN3FKMVFxbmxNRlluS2NWcVVuQWVxTm5DZUNQekZ2YUE0NnFaemRrcVBK?=
 =?utf-8?B?NkwrYUlFSVRsVFRjK05EY3RpQkJCc2RGbWpkcCt2UEQ1Qnp3WnVYdjlyQ3Vj?=
 =?utf-8?B?NmNwY3Nla0k0cTBNdE9BemR4RUVaT0craWJIWTZlOVFKV2FhZ0N4WmlPNTdu?=
 =?utf-8?B?d2F2Nnhkb1JCNVRqaUxxbXh4MG50bnR1Si9UNU93amRBUEM3L3l4RHgrbkdQ?=
 =?utf-8?B?QkdNclJhSDBud2pIaWhYVkdyMDFlQjRaTlI0WG9vYkFTNWlhSjVlV3Z2dWZF?=
 =?utf-8?B?RmJBLzlwTHdKY1FtZlh5S1p5ZGRaM1pqQ1JNNTRiZUN3Ly9aUEYxZjhqN2p4?=
 =?utf-8?B?Z2JrNjFYRVROVzJZUSt4NWFkQkxhOHJUUXp6cDV2UzNvc2wvWE95NmgxYUE3?=
 =?utf-8?B?djVzazZoTE1idGlrRzVPeHB0UkRBSmkra3dHQnJaQjBMdEdrUUZNUk4xenNQ?=
 =?utf-8?B?RmVWZHg2NUc1VjlObjJSek1iWVNrblZrSUVWczRuc3RnRysvWTROU2krRFRs?=
 =?utf-8?B?K1JTRzdtVHRNaUl1czJYSXZEem9PVTFnTmlDdjdMOGZzNGtZcGNwdUdwckcx?=
 =?utf-8?B?MWEyU1QyeFl3ak4zZFh6SWYwTEtEUTNXY0JTRjRLMXBKUEhSOVI0ZEY3OXQ2?=
 =?utf-8?B?M3M0em83aGp2UFozOVZZcTBvSSttaUhjTW5jYXVsRHJiTGl5NlJma1RBSzBa?=
 =?utf-8?B?QkRSdU1CUzM2VThIVTRiVXRlZmdCTmZ1UFBIS1FvU2xIcnI4ZTNneHRTOE05?=
 =?utf-8?B?ZFJyVlM1bER6eEFweWhSdGpneG9kdFMrdEczQy8wZ1pGUzVzVWhtSncwSVFl?=
 =?utf-8?B?ekpnNkgxWUtYVVBEQmphT2hZQTFqcGM5UlZHN1ZZYzc2N1NrRHhDd2tEblIx?=
 =?utf-8?B?YXFlMjhyTjFhcWluVTR5ajhkNzU2bVFNbDRINmVBQUpTNGFPWURZNnR3aThn?=
 =?utf-8?B?VitYeGg1ZldDZVAvTXFoNFFBTWU1cEl2Qks0bTcvQmM0bmxBUGdwRDErRk0z?=
 =?utf-8?B?ZkhOQXBVTG4zNEJrOG8vK2FYaFc1MnVRTmE1aENzc0E5WWxSYnBueDIrTlVP?=
 =?utf-8?B?N2VqbU5PZ1pEa2dtUVR6c3F3eXdoR05WY1BUMHpXRnFvYWwwcHR2Q25TMmhz?=
 =?utf-8?B?RWpaT0JaMENQNldJejRPcEkrRmV1clhuN012eDRkQWxiSUhjYTJIUDUrWXVs?=
 =?utf-8?B?bHpMaFFaNU0rOVlMSFIwOHVrdWVyNUk4WUdZVWRkTHJoVEU5cjZ2SVdwN3RO?=
 =?utf-8?B?ek52UzVLZFh6a3FYWFAwbk1aY2ZvdDBnOUJZYXd1NFBoajRnYkNleU4ySllX?=
 =?utf-8?B?enEwQVVIRE8zTFkyOVo0QjROcmRBamtOcmdVMUhadUxqczdOTDZ3eDZma2FR?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b4ff4be-0cc3-4fff-67ab-08dadf991535
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 19:09:40.6564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dt2i5kHZq4o6590hR7pVSYUaKpe9TocrNF9Boz+ZF6E/MfvrxmxiGBcJbzrAQ/FC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1537
X-Proofpoint-GUID: OCGcWuctFPDCt6u8r8rK8_5y2FBUUftu
X-Proofpoint-ORIG-GUID: OCGcWuctFPDCt6u8r8rK8_5y2FBUUftu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_12,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/15/22 5:59 PM, Kui-Feng Lee wrote:
> Fix the system crash that happens when a task iterator travel through
> vma of tasks.
> 
> In task iterators, we used to access mm by following the pointer on
> the task_struct; however, the death of a task will clear the pointer,
> even though we still hold the task_struct.  That can cause an
> unexpected crash for a null pointer when an iterator is visiting a
> task that dies during the visit.  Keeping a reference of mm on the
> iterator ensures we always have a valid pointer to mm.
> 
> Co-developed-by: Song Liu <song@kernel.org>
> Signed-off-by: Song Liu <song@kernel.org>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> Reported-by: Nathan Slingerland <slinger@meta.com>

Acked-by: Yonghong Song <yhs@fb.com>
