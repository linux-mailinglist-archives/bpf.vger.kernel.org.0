Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB91F642094
	for <lists+bpf@lfdr.de>; Mon,  5 Dec 2022 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiLDXsG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Dec 2022 18:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLDXsF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Dec 2022 18:48:05 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC47E95B2;
        Sun,  4 Dec 2022 15:48:04 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B4LTLCj007670;
        Sun, 4 Dec 2022 15:47:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=TxljiuZ46n4rLhgMo4G7sSasanRHrceLXGLRI4zr2NM=;
 b=frbtgx4xGChmM/HbKA+uKjgETJ81A8g/2SdqRQ4JIaATcM1Dxh9YX/SVUru+TXRS6+ot
 2c+UPVJnHPvg/vJoUypJ1Y5JVhTfYXiv0UjwnAVbxktbBj+jWtg8xRxo6YG3YpATGrgP
 EQbNC915yeFAKKg51M/AjtRVWNqJcUXsxjRNe44iYLEVmjcgKF6lpkffR+UpWo9xPK/y
 8FYKhUcxUbvJPi1gtRnb8CV7jShg2WJ/IG1smKeYZdKAXlQq5z11xLtQlJLJnl5KuoSC
 0uW67maWpTwGutnmh2AMlhkYdmlXxIR0afFsOZ74OAIN0CCOUv2sWh2iK/2DZLx5jE/Z 5g== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m8534mwe1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Dec 2022 15:47:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PvrYStJ5zB7yriv/btgI4o33nPuy4+fIilOyqiduyt5kP1dJ5DZnakUJyXqX4cdJYo09YN1KyJSvNSivhK39R7hf0CfItgWp43eaKR4PJHqI3YN0MRjO7mXtBA5VsJCWfTPb0fj8rcY0J9V9GMhyzWkaU4huAeWMN56AhXdCSUZjtpR1x71lLWy1Q9M6QZ0exQNVNCkT2uXvDMCvtGVhduCV+XM64i5evfBwmvj/7PBnvQGvU9KgH1uv7sGUNGC9AsRL505dIAbo9aIYQPoyrTSc5LCSeRAjM8Y0ucddirdoAnxAmZlRJPe8rujtOC4vKhg4G+Rf5M74JLgyJAKAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxljiuZ46n4rLhgMo4G7sSasanRHrceLXGLRI4zr2NM=;
 b=j1m1Lu0VGcNxRJcxZizN2ke3dh5OdPb97u0dWL7VnGAcS7OmrYzTwXYOKVlpLtlisDJyadicXkPTUbG0QknKzzz8fW+xaf9+otJamxs+ykBhPHiIYf/GqGUHwXRabu7obop6gbnDpywdAJc/KEbXmc14qBiF2gicCuDFrk+qttm3l/XsZmZaYjJnYO9Eqa3/MyehskmYu/aBqXQr2dVASzjYxt3HlCGv64pfOBS0OWZbvO3/JUPd3+niXKc40NOzHhMOzCLgWVtSLzDWEc6wdPMcdLhIR9zxS2vHtt9dA//Dtgdj01InIjYg2ajs42/T4S96FsKvWaSF38rRWLABeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DS0PR15MB5623.namprd15.prod.outlook.com (2603:10b6:8:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Sun, 4 Dec
 2022 23:47:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.013; Sun, 4 Dec 2022
 23:47:46 +0000
Message-ID: <cbe896ff-9693-a834-939d-be97ae7ff7bd@meta.com>
Date:   Sun, 4 Dec 2022 15:47:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v2 bpf-next 1/1] bpf, docs: BPF Iterator Document
To:     Sreevani Sreejith <ssreevani@meta.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, psreep@gmail.com
Cc:     void@manifault.com, mykolal@meta.com
References: <20221202221710.320810-1-ssreevani@meta.com>
 <20221202221710.320810-2-ssreevani@meta.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221202221710.320810-2-ssreevani@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DS0PR15MB5623:EE_
X-MS-Office365-Filtering-Correlation-Id: 089343d1-0abf-4774-838d-08dad651f1bd
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPdRODr2hPZ3myc013PPh2JzDAjF8Ooo6AiDX2FDRny0N7ZUWG91Uhy0gBbj1Vxhv3iURAL/t7G5k/K8fHNcaRRDsBhacamm77gR5nHVibVs2CJ8zF9dF8D6MFTimRMAMCgVTEEQKxzp8Wwb29/lpUi01I85ApTCy5ejTr7DcPNzCdSeNjzWPcX7neIdK5mLWoDdLsOD0x4sD+sVXftpr4RE0Z/Lq37lC+wm+ZQbA+U9UaEEdyZZL+ohUy29sHh09Rpb1XydqwRdDi2iR+Imqln1ER5dyrYcqiGBFbjt5MzgMcKuRXPIeGuyhjkRJ9zIt+vbgG/dkmkTK0rwG99qIlUbPUyKGugDISQ3zrjbanZUTIcSKGbQEShjRI6dz3VE5as6oc8fKSzczz98S9z1JQSzVmy1r0/vQWrWMdWrl3hgZf0zRM7BAy+U+ifMLMswVcdtR5oOkrieerO1S6qSfAqjNpyc0YkUPZmwBPDSRdbAlj5LC0BAxv/j4DtkriPi6oSNMoFbJs4gZNB78lTcfeOoMst/5sQJlEZ2SIB5uAx2HWCfRcw2VArUmkSQXD/mUXvc0nKYMzoBo01f9Kfcm6+wZa+4s7T4yr/i289uhvW/fL/Jk7jq0FHa/uC7VBLv8QYKruDW0fbAMYJIk6cBIL0oCDu6u9eu0qS3G4LLk/cNstGG31d1cBBF1br1cW5HVju6yndIlqk7HtDvbNGCLhun49UmuX7o7izeOY0j0gM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199015)(478600001)(6486002)(53546011)(186003)(2616005)(6512007)(107886003)(6506007)(6666004)(36756003)(66556008)(41300700001)(8676002)(8936002)(66946007)(316002)(66476007)(4326008)(31686004)(2906002)(4744005)(5660300002)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djFPdDdYcnlyRmZCUDVhZVJ3V0JBYTY0d0xIYmhQMW9xb0RXdFB5cUN4ekhn?=
 =?utf-8?B?VmF3UE9RVDZhWW5FaXVHa0FlVFdMSzc2TlVlR0EzUGV0c3ZFczRXeU53dkpJ?=
 =?utf-8?B?d1J6bXArd0ZQZGxXeHdENlpDd1VibEd3eFR2dERvd3NFM2s3WC9xdU1Wc3Qv?=
 =?utf-8?B?TWxrZW5TSWU0WCtDb2FYTjN2Q2V3QkdwbWxCL0lRZitLMDNLaDdMQnRSeXZQ?=
 =?utf-8?B?eVc3aDhlRVJhWXB4SWdvUjUydDBEVmVWdEl5MjliclpRRFY2MzBVZkJOaWxG?=
 =?utf-8?B?ZDhXbnlNclAzT1pyQ0NjejdYbFpsQURmd2QxOGc1MzBJRmNHZENmM0VjcDQv?=
 =?utf-8?B?Z3NEbFlwOU5ud2VBTVpRL3EyUDlGU3BWelJFZHprYkJpaFVNN0J6RVhRRWVa?=
 =?utf-8?B?MWppM05id3NacXVqTVYwUGNnTTNYMklxVlJaUjZpVzZZVnJmTFQ2MktjWGFS?=
 =?utf-8?B?eEhvRU9PRjJUYTJjdllpMkl5SnFXQmdTT0hSYnNmOFVIYm5yNlM0aXUrMklG?=
 =?utf-8?B?U2ZaWVI1L1lra3hKb2JGaWNDRlpNZmJhVkRGUE1BcXFMb3lDcHNFQUZGVllH?=
 =?utf-8?B?d2phYll1a0VMdk0xUEt1S3l0RlV6Ri9Rb1lRSnU2WVV3VHczTGFjZjJwTEdN?=
 =?utf-8?B?aGRTTzJTSVJuSVo0OXJkMTNzMTkyUHduQXlpRXlyMk84Y0xmZ3lobE1GS3hq?=
 =?utf-8?B?SG9MaGJXZzdOZTJOS0lqVDBJSStXbFgzSGpWVUtiZm1LR0FlMUhOK3grOTRu?=
 =?utf-8?B?QjlBL0pvZkN6M1p3Mzh5Rk5VbWRyYS9PZERxbVVvYlpKdW5DbXVZenZvN1la?=
 =?utf-8?B?NzI2Rm93Z2pSaTZoZGJXUlc3V293Y3BRNnJMYkZmYyt5ckV6amxnQ1NYNHlK?=
 =?utf-8?B?VVppUUtjbEVjdzcwZURzOXFCeGxaR1FReUdiemFEV3lGSENkY2cxbFBTYnVj?=
 =?utf-8?B?MU9yVkhrOEpWRG1JbGRXNmVuMHUrcEhiVVVHZkpldURUZ200R0NTTWQzK0NL?=
 =?utf-8?B?UHVRbWFtRk1GRmErTGhUeTMxTEpvaDc0UlVsMmYrNTVxa0hKS2JvMjdVMks5?=
 =?utf-8?B?d0laN09nOW02RFN2MWlXU0tVS1Q4cXJZWW9nNGRqb1lGcFRYelVZSi9ibU5a?=
 =?utf-8?B?MnRFQkdBcmRUcElWZ29KNkZkejhGcUtudVI5dml5bDYyRy9XTkxBWXI3UlpR?=
 =?utf-8?B?WVFCWnNFVkFXbnlzR2VOWXBEU0NBSjdCMjVsWGVVMVVPUW1ITitaK0NmZVhm?=
 =?utf-8?B?TnZRTUprck9lM1BBL2xyRXlDVmtnT21KMm1HSTg2Y1dyQWJMQzByY1g5cnVS?=
 =?utf-8?B?dUVNOGtGcmRJQlFSMHhFUjZHMm1WT2xHZlo4RkVwMElocGoyeU1sbjg5S2VC?=
 =?utf-8?B?NFhrOXpCbUp1ZE9pWkZWYUdNRnY3NUR0c2Z3RDd1aEFLeW9TYzZHTE9TaGRN?=
 =?utf-8?B?RGxpdnlUZEFzdHlhZ1NPbFFRRkk0ZC9iazF6OUV4NGhBYjN4dGl5cjNSOXA3?=
 =?utf-8?B?eFVmMjAvZVBSWHlCS2VaSVllN2w1YmIrRVVFNTNsWGRBWnlBSEs3R2RtcHJz?=
 =?utf-8?B?QmRuTzZaRWEyQnVTbmxUNjJpVE1Zemo2ZjFYaEFlVXYxcjRvbXhEUlF5bFZT?=
 =?utf-8?B?bS9IZkhablQ4K0VIREdwWnI0S29xN1lyT1V2QXRNYU1IbC9xMXJ5VnJrVEkv?=
 =?utf-8?B?VXlWRHEraUEwa2NtNCsvL0laZzQxOGFDSUNHZEtqWGtuTnJHVmNaQXRsTXRt?=
 =?utf-8?B?dDI4NkhGdWozaGZsYzZWeDliTUI4WVZkZC9abjF0UldKZEZvRzloVHZqVVBj?=
 =?utf-8?B?VnYxaHFjRGNCNkYwSkZJRDQyRFpUcFN4Y3pZNWZZL3QrajJCTGU4WXlDVFBS?=
 =?utf-8?B?dkRsNVZLMmxIY0w3Nml5WnZKZWNiZDRHTmZzRHI3SjR6U2NQZUhlSG5VdzlR?=
 =?utf-8?B?YXVRMll0OGZ1dU5QY2VwUlVrd3haU3ZJV0QyMDYvU291NVdEdXNRMFZ1RkpM?=
 =?utf-8?B?ZkFtRXJ5eE9zT3orV1JxemhCeWVablVVN0pSbGkrTWY3aUtqNzlhcW5BQVZO?=
 =?utf-8?B?S25lTW5QSTJudmkvL0NyQ1QyNUZsZkt4K251MXVadkdUMTk5NWdMSkN2aFdY?=
 =?utf-8?B?Y1pNbVZlcEI1SFZJQmp2dVJscko5bk5mV3Z1U2J1QzZMd2tid0VvR0lxbGVJ?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 089343d1-0abf-4774-838d-08dad651f1bd
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2022 23:47:46.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u/A9fABHkLD+xv+vh6JlEu343onpS3QOe5wEYzUX/p1T7mr9FtSgQu915W3yzqoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5623
X-Proofpoint-GUID: 1j2pyF_hBCPCSlMmFrPwhbEvfaFLxaZo
X-Proofpoint-ORIG-GUID: 1j2pyF_hBCPCSlMmFrPwhbEvfaFLxaZo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-04_16,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/2/22 2:17 PM, Sreevani Sreejith wrote:
> From: Sreevani Sreejith <psreep@gmail.com>
> 
> Document that describes how BPF iterators work, how to use iterators,
> and how to pass parameters in BPF iterators.
> 
> Acked-by: David Vernet <void@manifault.com>
> Signed-off-by: Sreevani Sreejith <psreep@gmail.com>

LGTM. Thanks!
Acked-by: Yonghong Song <yhs@fb.com>
