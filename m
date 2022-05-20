Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75E252F64A
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 01:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbiETXfs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 19:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiETXfq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 19:35:46 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3C270
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:35:43 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KMsA0e012004;
        Fri, 20 May 2022 16:35:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6bYxR/dyjqmwjE92mJ9oblWs0GiIk3JTPkFy6N/rfe0=;
 b=ZlWSRo2KS22j0nDNre8kf/Vc+WJAlkdq/reynBPlDBlVxgrysK4uj+TMgwppdwMuqUtj
 GV1pU+rXvTDJqWl9DZwz0R+7a/S055MYhgYToZ1SAjTTkrYvfjFL1rvLs5+FGW8oaCyK
 F7XxHb5OLnIqSLqdSap3INroOTlOd/V2YGA= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6341eax4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 16:35:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX5uAPCfn6JZEMd2IakpJExQ+FYo4KjqVDDic+7c9+S4a6ieAsOOOAwZytpl1HZEoceb4C3Vo1XTgfYN0ZMr6kxghBpMmUYgbpFOLlGk87Zsq2q2y3i+KoE2J2o4MMy3MpLjg5EAyU1CEIpAcekQSlPrkFWWuqGQHNQANyrfMnD8MNh6/XRP9z8568Kz+bSj3v1y0CaQ4bp4FKgnjIYTiWorLy/hoPOc0/QVF/KaDqKV6Rxiik2BvSEYaVeJVeXcQMyVC6PD3eHW4bBP0XBibVCO8fVwNpH6DEkVULrOs6WTeqC2sbuefIWq8fqgDKHymwmORY5jtAQDa7gyYSLDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bYxR/dyjqmwjE92mJ9oblWs0GiIk3JTPkFy6N/rfe0=;
 b=E6YPRr9OnSJHSnckktO+vtxUqr8iO4V/GnCeW/y5MOnl6tOrK2uh8oSkANMKV8FNtIPapdeb9i0KU0Q+oWeTx/yGmAV44DFiiBpbV+VkXrUNxeRaR78yFLzY6jm+EanyCCpJ1FWXlS0GJaZMN0B+KSPO6Bh95EtAs7eYyCfIfHNlpOujOyaGL72wz5DHNjpKw4x0KuDaa0sRNnxrJCqqkHFFWr7avbhw2nQt1UkPZbADvN1l487Ke/PLUyNC0B0WNaBsNMJqlO1/7u0VXZRqrMdxc9/UUJRXmsk+mXLAwGzKGvnEOeuFNB5Y0/pM/xZo3vJAX5rcFb0Hhl0n8VCNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3185.namprd15.prod.outlook.com (2603:10b6:408:a7::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 23:35:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 23:35:26 +0000
Message-ID: <53115f3d-b271-533d-2721-3c4139f6d857@fb.com>
Date:   Fri, 20 May 2022 16:35:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v5 5/6] bpf: Add dynptr data slices
Content-Language: en-US
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
References: <20220520044245.3305025-1-joannelkoong@gmail.com>
 <20220520044245.3305025-6-joannelkoong@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220520044245.3305025-6-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0019.prod.exchangelabs.com (2603:10b6:a02:80::32)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 168f3f04-da58-4bec-a74f-08da3ab96a8b
X-MS-TrafficTypeDiagnostic: BN8PR15MB3185:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB31850F70627F5C76DB1BF263D3D39@BN8PR15MB3185.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ag8+hted/BLEjFF3NPLtI0dZlyiTmsHjWfxQmxfUklkufExj16+ZtrauwfHFtu89C/n9bW6WSRHBGzvZasDw50WT4Xw5WrSqnXPtoEPR5fe2id0S1x70OKZXlSHd/H06qTOzqrw0XRl3ER7zFl+xB12G1bnoZsfFO0L2LpPdkQRL25uVnApIvjFywsVjaIUTNvmRUXV3pZQoSvQHVVhfpk0C386BVSx2fFUH8amgLFwWxanGUEi731AnAA0jENnOBI+CBFVzOlBcBgwQrO67se/vIx/SDW/osjyoKCmbtee04LqHTzbw/SMyia/5Rth5lcIzp6zYRzb+g0M4eQDIk088troNMYWD05TLQdb3ujF46We6EtFpU1QWczUYUyYPA+RS8aCDAO1Jj74Az0+09IHwsoAj5Lw8BLthCvHe2DwJYm6MDemtPGONCeywdZz0MaA/t7TBTnBBQBrrNbmRoe1QLv4GOC0K/6MPsddlcoqTy220A7b7BSa9xpqs+pI+6ybKbRZRvAnJVrZcT9HMkg4EMBpeZv/AhFSQwd105UPbfZ9kKRDtGA02E5AtOdEROrIVZlRpKSz2X1TMDjCTffsvCmDoTKOS+MJxZ3Y0NYTRrqvW3hofccue7d3+N62hIARSVNT6Z/55E/T0Cwmw/EUg1SnXRXsFUbhIlgovF2iaMdrhg++Fu5YyyE/8aWWG3h2mQx6JBRhV3MecSG1yv2ynjkNOqpiOKkdoFvnHDZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(83380400001)(52116002)(66476007)(53546011)(66556008)(6506007)(4744005)(5660300002)(2616005)(316002)(31686004)(508600001)(31696002)(6486002)(6512007)(38100700002)(6666004)(86362001)(186003)(2906002)(66946007)(4326008)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHpVZnRrNldXNDMyYmkvZzhuaVNRemJlcG91RkJFTVQySnpsT2RyV3JibG1k?=
 =?utf-8?B?RVRuL1J2NndNYmJEQkI5L01EOSsveU5XMzZrUUs1WnE3eVoza2ZibU42dlVh?=
 =?utf-8?B?eVUvSUthR3JVNjl3YmtVTVhLTHVaNENPeDNYbGltcFNYd2QwVGt5eFhnenBK?=
 =?utf-8?B?WE1mU1VFcGxPY2dnM2dkSitXY2NjWVV0Qm9QMWRqc1J4cmJyZWlGcm8yTDhR?=
 =?utf-8?B?M3c1aXpncFd5bldnVWZOUE5NaStRVjVRdXlSZHNqQmUvOStFWGhLWWlzTHAv?=
 =?utf-8?B?ZW1JTkdXWDFLa0ZPcWk1NXJ4eml3M2hESk9WWWx2eVcrUWZGVHpOaTdsb05z?=
 =?utf-8?B?M2k2K1pBUTRPYnBlRllNZ21YNFFKMVBnQ2xHRDU4clZnUXBUVXVoalJqcHgv?=
 =?utf-8?B?WjVSMmFYUHZQekUwbklXT1doYXptOWNMNVlEVEE0bmNzZExhRklUZ2xjMHow?=
 =?utf-8?B?dHBmSVJhL2Y1NHBVWENJdHZFNnFxOUQ5MDE4TEtJYUNra2d3SVhKaUdzMUN0?=
 =?utf-8?B?OFhwOGE4OTZnUkl5emFydG42cE5xSjlFQzI1YVJHWjdHNStlSGlucXFPUFRP?=
 =?utf-8?B?Mnlpdy9odjdHMlh0M0d2UFZBR0ZSQ2lCazV0Z0ZwWGNaV1UrRmNsYjBRMEhN?=
 =?utf-8?B?MWMxV3d1Tmxqd1dxd2lVbkZqcDdkVHZoZTdYOGluZmtqT2FqSHV0M2w2bmlt?=
 =?utf-8?B?UVZMbzBJeTZVcEsvUDJtSFZmdTBxZnFVVm1zZnJocTJOOG05NUpkbnNwdHVv?=
 =?utf-8?B?UFlrMmhpYTZLb3duRTZpY2ErUDVZYVdGMXB1N0dEOFEzV3dCYVJsaEdHeHFw?=
 =?utf-8?B?SUZyVDVQQUpHOXc3ekU1R2dZcU9DNGtzeDJTWmdGVC9PaFZuaEE4R1hicDJS?=
 =?utf-8?B?NzBDVFpmanU3bElsbFNZZy9Ecmd4Qm9KRVFVTWNHTE5XU245dHkyKy90azZp?=
 =?utf-8?B?bzQ2bWJiZHZmR1FiTnNCRXZoUE9MQXpMWmJId0pkaG5UVkVxNHhraTU4ZktE?=
 =?utf-8?B?L05sWHNFV3pDdlZOQ2wzL0tLZ3pPQnI5cjVhZjQ1bXlIa0pGZmJGRjRubmtm?=
 =?utf-8?B?V2xUUFl6NTRHTkxMcVJmZDBkNWxjN1F2ancvQlpCU0R6TVNiclQ1NVhVSkc0?=
 =?utf-8?B?THRRR2VJMGwyOFVqRFY4bUQ5T1YyZmprZlhWZnpyMVZhQXR0bks1c1RUa0Rq?=
 =?utf-8?B?N3czWUxIYmJZVzVyQklGb3NCOFk5VVM1TDFMOC80c3R0U25DeDhwdy9uWW9N?=
 =?utf-8?B?d2YxOWdIQzg5SS9wZm96TGxDcm42VlVTTGY4TktNWWNJWkpWTnQ2QWQrR05l?=
 =?utf-8?B?WWYwbmlaM25kYkZHaCtRWEZIalV0OGtsRFdjWXYxVXkwMGRoWVRiZHc2cUs5?=
 =?utf-8?B?akNCdEpQZldiTmxwVGpIcFBZN3VET1Y2SlZSVHpwNHppR2hTTkZaQ3ljNHBo?=
 =?utf-8?B?UXVqWmF3QXpaVFhubnk3VkUzUUpHNnNLVWc5andWbi9DMm1nb1dld0xTalJT?=
 =?utf-8?B?WnluVDNBMEhiLzJQczhvVDZNZExRb1FnNEJKYzYxZVRsSW9yc2d3ZzVmR29v?=
 =?utf-8?B?ckZRQmRvMnRBZ043UHdtM2x6NlpwbEYzMzZwT01IOURMRisrY01aQ21kaDFJ?=
 =?utf-8?B?emFMc20rK01TbC9ZSlJIaUlMeVhwWGNXck8vVmdnSDRTcDdURU1CK0FMMFlX?=
 =?utf-8?B?QlBHV2xJUTNPK3BDVkxSNFdoejJ0a0s4VmZOTHVFdnhhVFF4dVpYL0pkYmxn?=
 =?utf-8?B?TUQzdWE0UjNwS09IRzM2clVwdEJXRlJjYVVXK1c0QVFsbTlHSGhoVVFGTkJq?=
 =?utf-8?B?d3dHdklXZ0JoVkFKa0tjM2NKYjc4aUJZQVJ3VDVQeDVMOE9YZGV1bk9NVTdT?=
 =?utf-8?B?S1hudHFCUVE4OThYSVFlOFpKYmI2N3R1ZHlnK2g2LzVtbVlaQ0JGektYTVJp?=
 =?utf-8?B?MXBocHIxcm9SY1VVMnFOeUtnSTVTQ1BWakcwYmM3blFDbXhpV0Z4OFJ4ejFo?=
 =?utf-8?B?dWx2V3IrTVJjaFdWUFF1YWYvK2Y2bjIyRXBDM0VELzRYT1J3dGhaNVFNN0hO?=
 =?utf-8?B?OHV4MmlYR3ZSOTNFNGVURC9oTkZkVUh6TldRVEJLWDAva2QrSmJmbmFXaVR2?=
 =?utf-8?B?eTg1ek4zUVE1amFLRnFFZzJ2MjJvQ3lkWTBzYU5LTkRGZHJ1QzlrZEVIT1RT?=
 =?utf-8?B?aHVmSjBWd0FDQnl4c0ZaMFA1YzRzUFFhMVFJWWRSNE9qSzhzcjFGci84WDQ3?=
 =?utf-8?B?RzFZQUpNVHYxWjFhRm8ybkt3Y2FWUFlleE0rYW1HVnBMVDBDR0RVRTdzbVRG?=
 =?utf-8?B?TXRVcDNuVU5IK1lHSzhmRnoxQ3RnWXRwTzBLcWJBYVFKZ0NsL3JkUlZjamcr?=
 =?utf-8?Q?TYDHvxBKybjYRk/U=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168f3f04-da58-4bec-a74f-08da3ab96a8b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 23:35:26.0681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6bqZAn1To2aYRWvlTHvaNqf36p8d3TsTSnKJ6+hkf9kIPQiO53nmSdl1GflxOCb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3185
X-Proofpoint-GUID: yFsH95ccCmNjxOHWxZdwnAc85b0X7r7u
X-Proofpoint-ORIG-GUID: yFsH95ccCmNjxOHWxZdwnAc85b0X7r7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_08,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/19/22 9:42 PM, Joanne Koong wrote:
> This patch adds a new helper function
> 
> void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len);
> 
> which returns a pointer to the underlying data of a dynptr. *len*
> must be a statically known value. The bpf program may access the returned
> data slice as a normal buffer (eg can do direct reads and writes), since
> the verifier associates the length with the returned pointer, and
> enforces that no out of bounds accesses occur.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
