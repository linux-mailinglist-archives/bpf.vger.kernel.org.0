Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5945567499
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 18:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiGEQlU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 12:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiGEQlT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 12:41:19 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B71A045;
        Tue,  5 Jul 2022 09:41:19 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265GCIbM018672;
        Tue, 5 Jul 2022 09:40:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=E8WrRQuSgP3zOQj7Ev4NO2sY5kjsIQBM4SYEhInGoxk=;
 b=C4bl3zslqI/2A+lTu4b38eh9PL3UIeuyLrsEPYzvCvVa4SQnGL+DwVVlsnmT21hnUD+O
 A/iunwbNEYx4uVHeRsdArffBUkTkGa8J0cRk9EAi1CGZTQ8MyHrd/RN8UsGgZ+4pSKK2
 Pd+KBKJNQlgreY9SOJewbEumO5YcduqqHiU= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h4rm1880f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 09:40:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwU7AAGt2speBmATR3CYQdJSRe/9/9VlTDn1fyendYne+VVsRpqW7nsK5tYkzW0qYhnR2ZHjJKs/HGenan1To5nkACV7SBil33L/5+obExn30CnrUkHs0wKuwFp+DjVMG5M8Ywa9hf5gHWHR4rkig+cQ7rIR7HKJxlFZjodgqnoiancPyzH4KDNYv/bH7ayWIN4kjyU3Xmr9y+J8Z3g7xu/MXGwTkhOctzD3gqn1zav27BcjgIckm41h+JmKSJl0dteqxWiHWV62tRFXtG2jHLpCtmeTY4XetwoXkW3dflDV5cH+MZ1gKwGvM3fVkgwALuGrW/BTzpMSq0aVtN8yNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8WrRQuSgP3zOQj7Ev4NO2sY5kjsIQBM4SYEhInGoxk=;
 b=AshfTA5ZpJ5b2D1/rAHihX2MSgY7ljgSUYZU/wO6NkWfOSrWMm8+5PjShcvhTf5nLPKUGVW1Gv5+2d/Q8RMZtnDrvug0XKzGbGfdnf2k4odjvZDfSJekUArCVREQS7TCxlvhm6MBChG1nptvdmO+OgKv4iRoJSF8lN6k/i03gYzh4tsjXujVc7I8YZ/tzuLmOXFnvWEndAIblDSqt9gJyDK+FGl8YqY4PT9QkLcZk/VBmaIAhMu/Rd2UXhNZmj6pCBw30d3tn+u7xMVlhGKsJfeK8reVy+jIhF+9zjk32pdso4O8RkelC4lBJAEF7i715Xay4Nzrgg1ekD2+RSK5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2837.namprd15.prod.outlook.com (2603:10b6:a03:f9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Tue, 5 Jul
 2022 16:40:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 16:40:48 +0000
Message-ID: <7e95ce01-abcf-dda8-9071-5537074b5198@fb.com>
Date:   Tue, 5 Jul 2022 09:40:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: add a ksym BPF iterator
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, songliubraving@fb.com
Cc:     kafai@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org, mhiramat@kernel.org, akpm@linux-foundation.org,
        void@manifault.com, swboyd@chromium.org, ndesaulniers@google.com,
        9erthalion6@gmail.com, kennyyu@fb.com, geliang.tang@suse.com,
        kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1656942916-13491-1-git-send-email-alan.maguire@oracle.com>
 <1656942916-13491-2-git-send-email-alan.maguire@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <1656942916-13491-2-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:a03:217::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1eae6ef8-358e-4aa1-deba-08da5ea51d8e
X-MS-TrafficTypeDiagnostic: BYAPR15MB2837:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAlIW9zYRAvKIIMDScfABq0s3TmIGp+DaEhpazu7P32ajohkFTeTnSHosBWqJoZgRqIFihuLU7AFKPNSDFHXQqPGYtgaCc6t5jovSkt+DypP6bH0UWHen4NAH05SqHa82U6LGfTLnLwVsbfrOF9PYrftjq4DEiJXHupaHorbbXmbE6lA5lVLnJ27iABF4pF9pph8Q/t8/zzHnurk9dKiA/vXLG2OP+PYvahQNv+ncMoqp87IiGCBFh4Xe29Es71HwW0RlrXXd4RO+cl0U/n0kHVYVxSYhoO8o4MKnOGLR5ltVCTSY9FdmH0evtl4v+cR9S0VfGuLY1d8lzjOaEahbhjaA01n9PA2go/KGp89MUS1gSYWEIvdtbHIdV9C7tgXfDeXSbz1Um+LJKztVTWAyxZpO56Qq3nVU8xfMTpQpDtE+kc8IGqf8/Kl/l2bEJEQAZvjbvBzPtwoq4ONmKYA5PrQ2v3m61tI7vSYX/zUScuxuHzQXQHFBwO2MyucmA5N1yQCgW8aD7jg19sdNVW1DfgHda/3wkHp1kurt8GHt5hcGz95q+AE9IvvPgoeRi9nix6FzFQ8jmd7LKHr8MdmAFq5WUKh6fy0AbNZ20O217pgAhCviqd6GtWylp51TrtgTCxxzC4xL9LrxVJE9uFCet8AxtSlNGtD6/OQXxtAeG35x/WrJnOMqdf5mF1vGXyg6liM3PBLZ35T3abMlSCbXThAbQ1o1ZsVt23AUfaO3ZV3tgHjbLfhWgl2OWL4jX8i/ZQvdjFuOHOWO6OIOvCZGv3X49kZxPcL/QfBr6ctGSxs+s8zKR6LaeedmoTrWP3vKDmRImk2SWz7e8VxLBr5iKvjqRUu2e59ICWPobuCuThXBkcz623sYo3empgd7mPJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(86362001)(8676002)(66946007)(66556008)(4326008)(66476007)(316002)(2616005)(6636002)(31696002)(8936002)(38100700002)(6512007)(6666004)(53546011)(41300700001)(6506007)(7416002)(966005)(36756003)(478600001)(2906002)(5660300002)(6486002)(83380400001)(4744005)(31686004)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTIreTN1aHRDMWdNQXB6ajFBMXUzS2szbTZxTWdBaVlVQVBPd1pUVUszbFI0?=
 =?utf-8?B?ZHBvZkNDdUFaWERCaklIMFMzcWFlOUZ6NGdTVTdQRXF6VkZmZ0RGRXdGVmRU?=
 =?utf-8?B?bEZNY0M0WkkyTG9nVlhGUldQQTN1Y1lidGkxbDIvcUljWnRBT00xRjhnMy9k?=
 =?utf-8?B?MUp6ckpKSS9VUE13V2RNMXJoblR3bXJBT3pydVdTUEV2bmVad1pLdTZyM09t?=
 =?utf-8?B?VEk0dGNyTm5Nbjc1VklWNUxKMmxJM0w5YmNiU1pMQkdWSFoyRTJTNkI0c3cx?=
 =?utf-8?B?dUk3b1g5Y2hSU1phNGxjNTREMllkd3c2WXB3Z1psQU8yNDZNbmlmaEw3a2Y0?=
 =?utf-8?B?T0FLR004dDhwZW9PQVhMMThnWEduRzBSSnBRV1Q0a3JxbFhnTTlPajQ0UzZt?=
 =?utf-8?B?RkRIRldYM0E0MERCSGh6R0pJa3QzWmx5Skx1L3NKcHo0Ym9zQk1NSjVGME1J?=
 =?utf-8?B?UXZpRStZd0xVajZGOURkSlU4RTIxVU1Kc2kzanY1dHZpcG93UFNKNW5US0FI?=
 =?utf-8?B?OXpUVG5oNzJQNENqQXVnNFVGdGlQWEZXUXN0OExpSWo4eFhtVTFoRHJCU1hU?=
 =?utf-8?B?dlNDSXJ4OFVlZG1rcnNjZEtub01ncFhjR0NGWFZNTGVjUEtqdTBnLzJvdVVW?=
 =?utf-8?B?VzNoejVvN1FzNWFPUWk3bDJFWDk2TnNpNEpqV2hkKy8yak1nSU5aS3EvWjFw?=
 =?utf-8?B?TGNkWENGWEtGRWFXdnBnOEpLSHdOcTRtcGZyNC9sR0t4KzBsaG50Q0NvOUJS?=
 =?utf-8?B?UGlJdjVCbGFlQVlhSU83ZURBY2lCaFJ4UkZlcDZMUFNJam5QaU1tUlpVaE1i?=
 =?utf-8?B?YnVsYUF6YXJvYTVaczJWT3hZTFBPNG0vbTB2RWJvV1ZlRzIzSk9uT0JNM3p1?=
 =?utf-8?B?aVRVQ2lCZUIwZDkzSGV0RW5lL2JHRDZFeG9yTjM3U3pvUkduTWVkQjZKL3R5?=
 =?utf-8?B?V3phMXJScTNJNjI2SnhGTGMzWEdiOFJabmtoSzlUMWNYd01wN1pobENENE9C?=
 =?utf-8?B?Y3Joam5OTmk2NXRzakVqckc1VUVvYUV3NEZEbzBNd2JJYUtFME8vNHNCZXh1?=
 =?utf-8?B?dFl5Q29aUDVNNm9BaFVkckxuaWZzSDJKSDlOMjU0bS9vSE9PRzVjd3JobTRw?=
 =?utf-8?B?cmJaSDBGejBDV2dmeDRiT0syd2pDVlYwTy8rcWY1RytDSFBmWno4UW9LTjVx?=
 =?utf-8?B?enViN09ZY2FVNGFZbGZBUEd5ZEZJTXZpaXVqaDJMQm13UUJvZVZCUU1CMTdJ?=
 =?utf-8?B?bGh6bWhQbTlEanRweC9UNkJXUWhkeFFHK1A0K0dOMTV4WXNFNXlCU1k0RjRZ?=
 =?utf-8?B?Nk1MMEtBV2d0c2NBaTFVNVA1dFRwWmU3WURXWFVsKzZIOUdTZEJBZTVyLzdN?=
 =?utf-8?B?OG9GWnNJSmxxbndiOThueHc5L3JSUXpFdkFNMk9PUmphR1JuSS9iSzU2YTVl?=
 =?utf-8?B?RmVmUENSV0VTOGhvUTRBK2pEZTBkKzlya0JiQ2xCTG9JeVlFOGtEaHMyUXIv?=
 =?utf-8?B?RDd1TWVrdElLQ0t4blJpOVVuZFlNZWhGQUwwZEVrWGxwSHNKL0doT3lXS1BC?=
 =?utf-8?B?czZodmtSaDR1RkpQWmRjNnhlVWtTaE95bUVqeUM0a2d0dlZvU0pSajhEN2NP?=
 =?utf-8?B?RkZSOHVnU2Q2TWVCRFk2cTd3VUdjNmJXVThmZnkzbUlnLzlWbHFIcm1BV3ZM?=
 =?utf-8?B?Z1duVEtyb1RwakhyNzlCTUhMKzk3NG1kN2JjS2VEbDJKL2o3cUFyUUdXcjA0?=
 =?utf-8?B?cUhqMjlBdy9CaXVSYXlwRlNmSDFzUGZUcDRlclVjcitycCtrOWlEVzFXSFhF?=
 =?utf-8?B?ZU0rV3VRc09TYnAvWXpkcHVEK3ovSTJUd3VYd2drL2JTcDNaU0ZmNXZDNHVR?=
 =?utf-8?B?RGEzMEtvNVFOcmp6aDVMNFBGcHlYc0oweUNvZ2NTSnNQdU5zc3N1ZXlHWnVW?=
 =?utf-8?B?MURSTXJpQTdka1FJa2tNWG45R0l0VU84YXBTdE1CdXYxWDlGUENYL0RrLzNP?=
 =?utf-8?B?bXk0cElXaGJqSDlWUzdvQllEM29yQTRpWEh4QjcwV3QvYW1JN0RKaHN5U0lQ?=
 =?utf-8?B?MzZzejQ5ODQzbTVxYUN6cjh3dXpSUDM3T2VDMVd3bHpBcmx0Q0RHazVqbXNP?=
 =?utf-8?Q?S/CU35vRk2DTIQdcHaUs8kwqO?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eae6ef8-358e-4aa1-deba-08da5ea51d8e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 16:40:48.7207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZMhllCUxh0+qFb6ePT7Udcl9IYp1EOHzyd4XvU5/YOFsHVGzTMQqraYiRrVXYiJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2837
X-Proofpoint-GUID: X90Ui_V5_pdTrO_rx4g9yr1d561TSt3s
X-Proofpoint-ORIG-GUID: X90Ui_V5_pdTrO_rx4g9yr1d561TSt3s
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/4/22 6:55 AM, Alan Maguire wrote:
> add a "ksym" iterator which provides access to a "struct kallsym_iter"
> for each symbol.  Intent is to support more flexible symbol parsing
> as discussed in [1].
> 
> [1] https://lore.kernel.org/all/YjRPZj6Z8vuLeEZo@krava/
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Yonghong Song <yhs@fb.com>
