Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF264FC01
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 20:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiLQTGd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Dec 2022 14:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiLQTF6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Dec 2022 14:05:58 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3322C11E
        for <bpf@vger.kernel.org>; Sat, 17 Dec 2022 11:00:04 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BHGIoQ5008601;
        Sat, 17 Dec 2022 10:59:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XzoADmPa7Dm2x6djmCx5JF+OHa/UJKfnnOu3IlpncZo=;
 b=cQeh5z46ZhgcjULA0dMZhUL24ZQGTdn3Dfotjlwgge5GQjfeQzO5F64UPDv/Nfp0neft
 AQj55d15x182A4kWlkJNNgJ2dpjSIwPfEFIrx8zRcbaPjIOqjHpIEdAbmi1YqBlYXFS+
 lAuqznOQPaKncuw+Ky1N6FSKVYD7FkLyqZL4q+uf6mV8xZyCQbgOaJJlgpY8EmyFZD+W
 mIFLYZ7846EftXwsaBnEEcSGq5WcHgtM5kakYReEVjeJoQm+eMHu4EZnE0romfSlwMXQ
 OXyIPHtwe09Ywvhs09+osntfUkgjVr1OR2noRLlAeS41VCnwW/Ds5eAzSSQMxIvuMD5D KA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mhcd3s3ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Dec 2022 10:59:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+10Dn/n8tHOMnrjEvNlktx2dt1ZY+bgVJtJHsXotXN8Nx9Klk+fEnJSuBFsJjYat+39OkJaIxO4PVYdrTWkyO81/FHuJX1Q4hX8jHQpB/VFPtBbbhgbEghieJ5CBDFGvpAF2lqR7zwr1MSLFE8zaKlygjyxXhrO9OfAtidyH2BGqJCRibkaTuRWe7t2ea4tOTAcn6Qvzh2tKEAMhwjLJyQJqb05QSqFzAQUSsbabQAf22CXSTx2Ce46USrZ0UN2v+4wUew3xI6w1ZZQlkr8Q/GiO/tEVUaXF8/NwHbF2+MlLYbBQwOAToINBD25pAEwfqpaCI8cuOlKxMaPYtOiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzoADmPa7Dm2x6djmCx5JF+OHa/UJKfnnOu3IlpncZo=;
 b=S7WARyAZfBYUlZkwp6Whf/szs92LzQFn53zEgT2kwhOHc5jsn6JI0uFZaDfppaBfwx/4S/9qsBFOS4NbuDeW+qHuWEu0YLLzBdT9IrIbRJSpinCmVnNp/3gdakyzd/QMZdtUxzVO6704VXmXirmYPN1gTg04D9aSDgL/drbkttZKaYZKtSDRu4ct4e7Vg3LJDzsL43fYrYqTSEZ315K4it4QaZoNyyKfCheQ0AnggbZmhCHvnkf3SIWUSUipcVzhqrcZ8gcaFdXnacaWjJutTxyMm+t65R7/ENyZd5tAdoPScZWiszPOrt2nAs8O1lRk2+Y6R7/7hbKQBjqNMg1L8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB3118.namprd15.prod.outlook.com (2603:10b6:208:f9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Sat, 17 Dec
 2022 18:59:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 18:59:17 +0000
Message-ID: <dc9f4c5a-7536-3764-58aa-9b65d7958acd@meta.com>
Date:   Sat, 17 Dec 2022 10:59:14 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next 3/4] bpf: reduce BPF_ID_MAP_SIZE to fit only
 valid programs
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com
References: <20221217021711.172247-1-eddyz87@gmail.com>
 <20221217021711.172247-4-eddyz87@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221217021711.172247-4-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MN2PR15MB3118:EE_
X-MS-Office365-Filtering-Correlation-Id: 1962716b-6c67-430d-48c3-08dae060cc1c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0FsZKiY6UP74sBNhBxY06MzBJjfq11XGUPL5OT/axZ0B+BEcO19Az5oWX3B8Ikyd+6bPe5v3MeL2k9yB9bTNTFmgb7Z6ZJDLte862MKRahWsjfPurIofTRq6Ie+PlnIReeziBsrzZ4QAquch+Op57pyjFpBYWDNPrWbrnLKLjk7bkQ1GdhalKWZJRhzMD9eB0dzHPW6F9vhCIkC/9FXd//nMF20PNMLA65fib/54xpnQDZOO8buGwF96KKKmRmxQg4Vl8bDxK+tNm2YMXX6JViHBihMVH0c3LJR2xBOGDghMzouuO4Lb8kDQeTDn2QIueDKtTb+PwI2dAOhH7MY+z7t/FXtLONwwmKJe8Yp2L9BUBRk3MVmzzm4y9CSZHQsXv4wSV2paV1CqV9SoBZJVLa3tj2tn6dP/jBuE39WrTZcgCyqXJuq5oqJt9LH/5Xosew5bWA/M8iy/PRA9Nh1Ymhx3URe1UiYIcM854RVyy8IY6iZkSCThPJwXlbD49kroYB0ERt73aQcoorRnoWokaU1kuFz8yp/x23YKXGg2fngKvMfdCCQxDN3cZeslG/y3Mps2ZWoUfHTJbX+pL2pHPgfOpFAS57Xs+9jREZ7fT6y0B52V0NkSrBO6gXq5Q4oDJWZAGuqUeKGoUxN0Sw0ymirP50Tiw5MEWQLtxrW06Udd9GdT5jeeLOiLq3dPtjQWDe9uyAvnrEQeijQE5/wmOZX1wUM/g0AkHEMzMh0tbnDFLmSjHm7DENY3Yj8feW6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(478600001)(41300700001)(31686004)(6486002)(966005)(6666004)(8936002)(36756003)(6506007)(53546011)(38100700002)(8676002)(66556008)(66476007)(66946007)(186003)(6512007)(5660300002)(4326008)(2906002)(2616005)(4744005)(316002)(86362001)(31696002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFHaVlaSHpldjhGMndON09CTjBlNmNJTUhxMWd0SjJZcDRRd3FicGJNRXNZ?=
 =?utf-8?B?cHRsLzZrM05rcHM1NXp2ZThPbmxWVnVwRnFyOTdSVFN3UkRPVmlhZ24vdEtE?=
 =?utf-8?B?MnVVLzdCbzk5OGhJeWhGOGZ2d2RvQ2VqRVNLeXl3TVFKQ1hwa3FtOU5mYzB1?=
 =?utf-8?B?QXJZR3dBR3dXbW1RZ1pMTDNNYTJlSm9RUGJGZU5rblhybEFXbXBuOUQ1b2kz?=
 =?utf-8?B?QUl4Qnlxa0xsRnJyQnA2NC9NOWpKV2haeGlLS0swVTM5WGZ2ejNxSXk4WFJ1?=
 =?utf-8?B?bWdOR0dtU0Y3VXhTczZLV1hDemxDYlI1Skc0TjV5U3dkdVRKbUI5Z3E4ZXAz?=
 =?utf-8?B?R3BaNFg2ZUtYbW1QOW9wdFY0QUdoK1QybjJCL3NtY3lDWHZ4T1BBODNucWRi?=
 =?utf-8?B?RFBKK0dmcDlTSXB0dE5ubGpjRlFVQjNjMEtScXFSNkt4YVhXakxackNBaW5Z?=
 =?utf-8?B?UGROcGEzOVpONkdHVTM4ajBFa3J1R1NMeG9zSEd1Z0M4Q3kxU3dpK0s4Kzcv?=
 =?utf-8?B?ZFZhT3Q5L3RZM2x6OGhTTjFmMHFtUTJXSzhIUFMvbDl2dlUxbUtoVk0wRWV4?=
 =?utf-8?B?VE5SMHAxdUZRMlplamQvcHdWRHRlNTZjdk0vdERNRTAvNlRuN0w4bEZJZ0hm?=
 =?utf-8?B?ckxRZTVZcFpGdFlKT2ZLbGR0R1hEVGtzb203TTNyYkxSV052bnpTajJsb2VY?=
 =?utf-8?B?U05Idi8rTUx2bW0zU095MWo3ZHl2K2w2VlkvV0VtTlBSMlNxYm53ZGJnZE5R?=
 =?utf-8?B?bU9KbGJFU0J5UWM2QitLNnhxS2lIN3V4WWh3blN3TlFGakFVWXoxTnMyOWxZ?=
 =?utf-8?B?MFlBcVV2Q0pSS0JEUis3eDlBemZBdXYvUG1xWHd3NHl1TWhrNU5iblNOenJk?=
 =?utf-8?B?ZGJ2S0ZnS1EvbjhoOUhRb1A4LzFGZ2kzS1NkSHV5aXRwQ2lsbmxPb1UwcHZJ?=
 =?utf-8?B?bUtNKzRCdjI0S09icDV6d0RmZmVQS3Q2SGdxb012WThnby9qL3VBMjhheUhx?=
 =?utf-8?B?T1dHYmlZbHFmTlVKQlJkeXUwWWtiUWtqak9pQjZFNS9Nd2M4NDluWFFMUUxx?=
 =?utf-8?B?L1g1cVZIS3lLbXNnRW1kWWkvdTZHZkVWRk1UYjdxQ1RxZUlRSW1VTm0wY3Y3?=
 =?utf-8?B?RmFpMmZycHFzRjg0czM1amVKMnBubjc0L2lKTjVqWnJGUVJ2SXE0QTBXVUhV?=
 =?utf-8?B?OC9JU21IZEl6NmlyUjNPVWV5aVVZQUdLWWEwT2Y4QnM5M0k1VGtwbW13TllM?=
 =?utf-8?B?blgrUHZVQUlpZ01meUN3ek9hTVBjUnJYdWtObnpPZTJjdjZMbk5IMVYzQktV?=
 =?utf-8?B?T21wNkRTeGZneW9QaG1rN3BibEV0NFNRTGhNK0UyanJaSWtZdEY0RnNFbTF2?=
 =?utf-8?B?WElBcHN6L29HTHVaSFZNcW0vNkFMMXFpYlZBVS9XbnRTbHVYZUk0VDhIcUFY?=
 =?utf-8?B?SlR0L3pzU2poR1dlYlFDV29UdFl2WENHdWIrN1graC9sR21ESHNCSWJIaThN?=
 =?utf-8?B?S1RlR0NoSzZ6NjhyNW96Lzlma1VzVHFpRUtOT2FhZ1JEREhNY2FrbnFlS1lW?=
 =?utf-8?B?SU0zNFNmUW42Q2N6QUpySFJLTmxjc0p3MzdGWVYvME9xTTJqNkZUdEc1M2pM?=
 =?utf-8?B?K1d2ODFJT3prZE1WQ0RmbjBFRDlBOUZvTjluTmNjYWFzdGxkSWpWVmpSRXZJ?=
 =?utf-8?B?Z1VESXRDSnFtOUcxdDZLS0FRMitOZi9tR1ZHT3dxSzhnTHF5RHdOYVd6eDMy?=
 =?utf-8?B?ek1PdXNKcyt5RCt1eGx6aHZtS2pPS3dGMVpZeTF5UFZ3TlViTC9WRlQ0ZmU2?=
 =?utf-8?B?YmV6VDlidWsvQ3Brb0N5NlJZREtXaDV1WDlwT01NcWxrUFFQS1Z4akZFMThB?=
 =?utf-8?B?NjQ3OFVZRERYYkNUU0YyWTl3QVk3WlpLdlhoRTJNQ0o0OElmN1EzSzE2U29L?=
 =?utf-8?B?ZjBxbjlER2ozZG50bndva0RKeGkyaE5CT2RoYzAxY2dzaTFuNWo1em9SenNH?=
 =?utf-8?B?Y3FHK01xcGdRWFI2RzVBa1h5L1FMV3Q0cEhBTU45RVBlSTAzOUpMVUNVTWVF?=
 =?utf-8?B?c1JjcVZNY0o3em9INnA3dGZNTlVxNkNBdko5enhST2Njc0NMT3pTT3VvK3Ba?=
 =?utf-8?B?ajNUSDE4WmQxeExRK0lrc2tHVkxBL3Z1OHdpM0RWN1dyUHYxbkdndWRHOTJB?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1962716b-6c67-430d-48c3-08dae060cc1c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 18:59:17.3484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SE3SurUwzJ4OZXDsinNj398FBKOhWkFeA4OzDvnHRATSVJNM8XK1rFFo70Ak+rh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3118
X-Proofpoint-GUID: iTBAs_SGVVsqWEwyJKqRyff_h9-YUWgG
X-Proofpoint-ORIG-GUID: iTBAs_SGVVsqWEwyJKqRyff_h9-YUWgG
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-17_09,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 6:17 PM, Eduard Zingerman wrote:
> BPF limits stack usage by MAX_BPF_STACK bytes across all call frames,
> however this is enforced by function check_max_stack_depth() which is
> executed after do_check_{subprogs,main}().
> 
> This means that when check_ids() is executed the maximal stack depth is not
> yet verified, thus in theory the number of stack spills might be
> MAX_CALL_FRAMES * MAX_BPF_STACK / BPF_REG_SIZE.
> 
> However, any program with stack usage deeper than
> MAX_BPF_STACK / BPF_REG_SIZE would be rejected by verifier.
> 
> Hence save some memory by reducing the BPF_ID_MAP_SIZE.
> 
> This is a follow up for
> https://lore.kernel.org/bpf/CAEf4BzYN1JmY9t03pnCHc4actob80wkBz2vk90ihJCBzi8CT9w@mail.gmail.com/
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
