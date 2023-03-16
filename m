Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742076BC303
	for <lists+bpf@lfdr.de>; Thu, 16 Mar 2023 01:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCPA5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Mar 2023 20:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPA5w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Mar 2023 20:57:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD96AB093
        for <bpf@vger.kernel.org>; Wed, 15 Mar 2023 17:57:49 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32FMZ0Sh006660;
        Wed, 15 Mar 2023 17:57:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0lghgOsrQuox8TZDGjFXqKnaTFgdlIw6nVu2mdLRTe4=;
 b=GM1sY71zfOErZaounoca3eTCQvV9V4sHJ3F0IoYqfeirUsrjlqUOn2foUIftaHt2FLPc
 U9W41hEAA+vFIlL9YwPMv+Oa9N9aqPaPmfTVUKYZ8T9zHZWmvzi4DX38g3PHSiaH5WYa
 PlqIulo1kNlsfpCdmuh0Lg1jRJyofDAwg6YJ8gPQmFuHxL0bXnDAbXLYL/u36F3y/AuX
 29/ltCTcZfj+970k3vibV33vkpUnNupP9CdCtgc3qfWTwHzwQpS58IwWH+NxQskoT3Wy
 h1xUHmrwyaGMKd7BNeJbrDEIk1jR9Aho/gvqu4XT2l3//YVmnZA8uZomWKX1FUm76Li6 2Q== 
Received: from outbound.mail.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pbpxd8nju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Mar 2023 17:57:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0YpIxz2Zg1jnZTGVqjzBPAKJ4l4GJl1FXuSszV5a9M16zXynakKO3q5xzLpjqJKET/g2e+2q3gjCTfd9mwXgXscegPFK0xPjmesKPL7qzMtjjAarbWkzE/LKY8vEegb02v8++w2d+aVWey0z9zAmjGbcuwfPPw/DeSE0vnHOF/i4nyeTDqQwsFB/V6qGB2HpptPS0iKKAaw5wU2df5RypivrHOjGkdmmB7HCcCydsKoE7L5mvS14qBBM1Ztg6mNHfF0Te0WO2bv/X2/ms80+USgAFrQivSaOuYw7w29jOzEbe8hS2Vu7NAaBdaIaSohuhRs0p+bko/lHZhGRreztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lghgOsrQuox8TZDGjFXqKnaTFgdlIw6nVu2mdLRTe4=;
 b=K2N5KknEDMXwHfuPz9UdfKK0aSP5xJGwBWuljVMaQGujiQkt2VPt5kkhoNBobhszkKzUClV9XmTk/hqv1TJnNCU0pgl6y+RSnQ8DL3HzLR4WjuFANK/JKOxTTVMuNX64XWdAq3SDwalsi4i+cv/ySULbW9huDKIUdH3DOq/FWgbTmvwQpD2tsdmXbmjoZGSaJEzYuIPWwy+fIqmXz9ADAGJZhCDlACGNfoY+JZWbdMHea2DdjDMoVkKr51gXaF14bC6eQtMtRbbWd4hCGyUzaMz+gr7MnaSqKIH7PQd4Io2hUCxTzafc/O3ktsyxqOsV4cRn2h5WeRlMRBMECm2G+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5122.namprd15.prod.outlook.com (2603:10b6:303:19c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 00:57:31 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9509:699e:24e0:339e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9509:699e:24e0:339e%7]) with mapi id 15.20.6178.024; Thu, 16 Mar 2023
 00:57:31 +0000
Message-ID: <0096d13a-b61e-28d8-d256-49fda1519047@meta.com>
Date:   Wed, 15 Mar 2023 17:57:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Use ASSERT_EQ instead
 ASSERT_OK for testing memcmp result
To:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com
References: <20230316000726.1016773-1-martin.lau@linux.dev>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230316000726.1016773-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::9) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW5PR15MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d2ccf0-1de0-4a53-05ad-08db25b96bb5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PthMlN1KJqbqy1UVAhc4Y+h/ccdHTS04XujULGruhbw1R94n6o7mhi/x3y/GIrflayTyFtSk3Q8es9oCJle5g4F2JNQqMilHv0nZp5kBj0mgCr7jPFse5gLw/itVi72bk63PfBtSdp176m1zdNaahG8MButsJH5rf0AUNB9U3gq6cqYP8NFDm3FWTRnXMBQKk7s42+yC4wAwa4IbCRsSPqcXa10dH79QnUcjunVmrZp/C2LrRctoTOSiV386j6AuZorZ5D2eg3IXoMA3SssDds68rXWBTmQOOks0fiv1gI66mkGCyREIblh5JXG0k8WKW7KcbBMzYcmCByadwTObRB4fCMIFH9PmSyWSeK81F3SHrRfyU/RBTq44gzwh9txs5l3qyalU1vpUF9yBDVSx+Msu0DFR9sPXRlexwMFOkdBkNyJaNlmPsmIh/dGfFF9pcyxzlZZ/4Z+jsqI94YiTx24v7YfljFLFsYTk+K1leRS3i3ozDJMxhyTSibHrEPLCwsdeFPjJnwqJZi0NDc/S7nfPx0TQKsVkcb+j5uIzY/mqiHg0wX5HEQSGBsmXhED3VHR23jMlSOOwM3Z5mjthiEXFpYRLRa++ptbdWzM+ZuPuvJnwSCdk6Zb0UTq1Raa9z+/0Bfv9uOgJ7HFcWMGKNwlOSUf0DNBUiZzIR1fGaGtNr+XjehhJ4VHSadNGCqjW9PF6Lhr3cQDOwPyr7G0Cgn8qZ624KDANxYIUJUpfAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199018)(36756003)(186003)(6486002)(2616005)(53546011)(107886003)(6512007)(6506007)(6666004)(41300700001)(8676002)(66476007)(66556008)(4326008)(8936002)(2906002)(66946007)(4744005)(5660300002)(316002)(38100700002)(86362001)(478600001)(31696002)(54906003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmdDRE9ES2ZKMmp0bFF4WHNkeXd4OHFTNUxSZEhWZ2tHb3J4ekkxa2QvOC9m?=
 =?utf-8?B?RWhBMkdUazVLdW1MbGM5SlB4enl1S2p0c0V2NHlvUDd3djNabmVuNE9oRVh4?=
 =?utf-8?B?QnZZdVVZb1pNc1NrM01FTUNaMmRLaFJBRFRwRjVKam5iZGpWSTVRazBocVNI?=
 =?utf-8?B?N3N6WU9iYm4wNnFuRmIvUFZqLzRDZHNKUUNHdG0zN2FBUGlDWTE2WlNlMUFY?=
 =?utf-8?B?QWpFWkhlZ3U5YUw5c1VOc0NJTldYVytqdWc0d1NwaWp5dDZNUUpMU0UyVWIw?=
 =?utf-8?B?cEFyMHJUVXdtcEZYVnZCL2I3ZHFJZWQ2WTArbUFBdjJ5cE9wTkh3bWViWFRm?=
 =?utf-8?B?QkxmSFpTZE5WYlBiT1lKWVUxb3ZJVENHTEVLUTdKSTQ5Ymc0b3hYalpNV0Q2?=
 =?utf-8?B?K1Z3WFhzYXhTZE5rWk05aGtBWVdpRWlJU253bnpWMVQybUl4cTB0eWdWb2pR?=
 =?utf-8?B?Ylcyemxob1JJbStVMTc2VlJOWVA2cUt4WklHM0FHcW1JaGtla1NOTUxzQmdi?=
 =?utf-8?B?TDZCcmErYmlwTERwcDR1dnh1Ry9zTE1DeFFyWDZ1c0QyNVpseFFUWkl4b1NE?=
 =?utf-8?B?N2RGSmNoV3Z4dTZFWEdPYmFrYUR1aFNYTjZIQTdUNzBTcDJraTJRSkRGVjdz?=
 =?utf-8?B?V3NjNXJ5b1FxNVRLNXpIMm5IWkpqanh5bklSajN4c3RNMXZObm80dTdOa1BM?=
 =?utf-8?B?UXFvV3FLTlE4SkM4dWkzZGY2SEtnVGNobmdEalgyQ0hJVld1ZWhGVlEyaVF0?=
 =?utf-8?B?NW9tSjZIRmJPZzR5MzVRTjQ0cjQ2R0VxNzlpY2podHpLQksvQ25hM2U2djI1?=
 =?utf-8?B?dTI5K3U1ekhJTGFSTnB6TnVVeUk0dEtxSC83dGlOZHlkb0YxY3VhbXRYT0o5?=
 =?utf-8?B?cHVvUWxqRGNKLzVqT0pnMmpNYmpxV2Z4M2owSklIMUNwSXF0YmNKMkhjdlE0?=
 =?utf-8?B?U3lHOExDRWxNNXVNYnJpUHppUHlpdUxQU0E0SkpybVBwVzRVK2Z2cURodEtZ?=
 =?utf-8?B?MDE0N3JxUEd3RGh2SVF6RTJ6aGR3bk56c08yTEhEcWxnYTF6N2hMSTZqNGFj?=
 =?utf-8?B?U3NLSjlGR242TzBPQTVLVmdrbEMrZWRIRVY3VWljZXFoVnhMK2I1OFZzeWF5?=
 =?utf-8?B?dWsyNXpwSzdNU3FubHVzc2dKWW1HclpuWmdlcWExbjVqOHZEMWtLSGs4a3BI?=
 =?utf-8?B?YU56YWpYUDNDTFcwbldSaDF0NkhnU1ErWTlJZ3hUQTRsQ1RJdDlWWlBOZnRO?=
 =?utf-8?B?Q1N5Rk9qcjdHYUdBSzlIT3NYbjEvM0l3NFFvUllrUmN2Q0t3NDRKcXl1NG5K?=
 =?utf-8?B?QmQ1WFRtNy9uMmtGNlFLbXJKTFdWWVJMNW5aZXlndGkxc0dRMjVYWW1sNXpo?=
 =?utf-8?B?M25GMVhsUUZDR0M5QXVQNVlWZ09MaUcrc0JhTytoRW9Ra1BGZnpzQmpReFlH?=
 =?utf-8?B?OWt0SWE3bW1SWE9zWnVJVWVhazdRWi93T1EvRDFJVjhCZFFVQUtvM3BkanFV?=
 =?utf-8?B?UHBPNEtzY0lXNW5HUWQvS1VrdWcxMTF1UWQ2SFNqYkNVVkJoRXh5SEljcCtN?=
 =?utf-8?B?U0pmL1FjUUVpaUNVbGkrOGRHTzJIMTRMa3gvN1VNVE83L2J6MVdJZWxyU1E3?=
 =?utf-8?B?TjJnYmNCdEx4TjFlTGtWTVZVODhwV2hGZmRSZ2E1Z2JrRDJWR2l6b0loV1My?=
 =?utf-8?B?T1FMOEtUdERtRmg5TW5oVVZUcy9vditvNEhGWjNlZFVwWUZsQkpKZWl4ME5x?=
 =?utf-8?B?WEFWZHV6WG41S3lNWEtKYXFFYWNCVlhZNURSZDkvdURDemhZRTZsM0dNOUww?=
 =?utf-8?B?bXo4WHVCOWcxNllCdEhWTmZhT0t2RlBZR3llTXBEYW52Y3Y0a0F0WnRtR2xN?=
 =?utf-8?B?OW4xRkpZZG0yUVJqWjBUQ29pSXNlTGJJSlVWL01sOVp4aFE4bFo4VVZyb2s5?=
 =?utf-8?B?VytjK1A3czJzSWlBNWNTWXY0cGV1Q3A0dXNtUUtCS0dsM2hlRXcyRHo2RmdI?=
 =?utf-8?B?eUpuK0Q0bHM3MHBRMytxWS9xNzFSWjhQZmkyOFo0dzFTbFc1bGd2ejZvR0Fu?=
 =?utf-8?B?TnlMbU9tZ0Y3eWZlR01hWG56VzgrdCtvaTI5K2tIREdPUmdxM1g3emRFMjV2?=
 =?utf-8?B?OVhSNU4rYk5MKzBhNTZQRHF4c2ZiSHk5R1hwaTlJS2ZFTWhtdTNOT1JvMitk?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d2ccf0-1de0-4a53-05ad-08db25b96bb5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 00:57:31.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4m0mtMTN0v8nQisEYUq8A22XGyCRY8xNJhYH7xUm2gX/XeMusxL/Uh5lqMzkNpEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5122
X-Proofpoint-ORIG-GUID: 7SFRZI7P7xbTSnUH_DWynCB5B-NYoFxa
X-Proofpoint-GUID: 7SFRZI7P7xbTSnUH_DWynCB5B-NYoFxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-15_12,2023-03-15_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/15/23 5:07 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> In tcp_hdr_options test, it ensures the received tcp hdr option
> and the sk local storage have the expected values. It uses memcmp
> to check that. Testing the memcmp result with ASSERT_OK is confusing
> because ASSERT_OK will print out the errno which is not set.
> This patch uses ASSERT_EQ to check for 0 instead.
> 
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
