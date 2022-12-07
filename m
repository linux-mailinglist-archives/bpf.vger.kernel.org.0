Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E300645F20
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 17:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiLGQlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 11:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLGQlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 11:41:42 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4958B55A95;
        Wed,  7 Dec 2022 08:41:38 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7EoDgY012885;
        Wed, 7 Dec 2022 08:41:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=eoQs2DXVYn+0bucR+yVgOZPW2Ns0nkiAjanYWvF9wXI=;
 b=P2ecSCibiGzULU3SiLIakG+1WWrzONhajpr7r7XYxQYSCDukZ9l156mQPRZN2M5zt217
 +6tABoHXkaE1JJEqRWmWHoBJB78LGk2wuODhv6sSEIf2ij9OQ6BYaK+TltDuL4jG2m+C
 BP/3vpjgw3xhrE46HQaD0jm88zAtvgDIYhtV9uT/FoladdRHlc1pwbaJPbf0BqCTkYUj
 aVlab+lIIuzKEyPqnvrBw7IeFo9FeDmLBXRGOR6GlfCpDX+Zoue0y8gYAmeMlQbsMvc2
 FygYv+jYJM37UHVWClIma1s3xBnTyeR2NBSIo3qLSz8vqz2qROTMtj0cscvxAuP2AhdR 8w== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mavtegv7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 08:41:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMlCzTm1U0mQIuaIp7iJTAK1zRq8cHzSQrWUpFEriv0dKS0faKZvxe0FfD2YFUvkCfxPiGbiAk65TxUb+QuCZN1LgAJLbOrNGcSbcVkAFwJy5lFCX4PVOjPdsMR3g+3G9kIr/xfkRyIBhRSPyXo6t86kwes9tAJP+uiOYiLEPfkKoJoKUnOwUwBgtxjmqajdLZu3QNb2rNBHRfUxLA2NxQ7tUoV63xJT9a2j/ayomF7u0uhtUIPfGTo+OlgS+w0Dk+on/G0PtK1UkFcRP/a1fIhMGiwINsDpmxtRrISRRrGVsRzAT+SCXu+ZpCweJIn0vyzGxu2K3y2CafF1SLzhhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoQs2DXVYn+0bucR+yVgOZPW2Ns0nkiAjanYWvF9wXI=;
 b=c2/h8XK1Go3GEk83ww1K5J503CLFhVpu/U/jzwmpMZh31FmD9S9fMD7etOpLocHjR8xQc4/y0BnrNgKUuszRcZghC79dJMrPeO+MzwplYhgeRCxRJ7m4be+iK7Q4lLFEgqGTMrXCylTrXowR7DPmv+miayHtT1uZReEbHx6aKKo5gpCJrejAy7P6YKM0jTYTIkqT8Z5bGn2OzCZuxfzQWloQXcW3inXr/WIgrJ+bp4yrblW6/XArPVSl5N/1AAAbLwEPPfN6oP2Y31iVAK1AQOwxoQf0xZspEjVxR9WMPs3tyxlz3/Gig0b6c+C0IiQwM8Ceh67R7td2EmFjVvw1dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN8PR15MB3121.namprd15.prod.outlook.com (2603:10b6:408:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 16:41:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 16:41:18 +0000
Message-ID: <76806a76-bb80-16f0-4b8f-affc0d933348@meta.com>
Date:   Wed, 7 Dec 2022 08:41:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v3] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20221207102721.33378-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221207102721.33378-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BN8PR15MB3121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb1ec8d-7b60-412a-c2be-08dad871dd53
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6RD5qRPunBWyW89ursy6ugNH4sLM+3g9v+dFv6g1S1+EYRlEokc+/5q5uCuCBeO0w7OU+88IyObXVzUBc56XhRfDLQK2GoM3DaPF0gpBEml6Ci7YmBMgrhZS7Kk9uc/AK5IJiC1xExXGLrmbdRRhgO0bCtgvYsaQGraTxrbCaPawnyub8aMuBkEuCUFQ2xYo81bHviARKpHGRjULrZF1ggutFjhU0ico8PNRsNz+sO6b/c9dgSGgimAsDsZq8G55HN7ZBVuk9owB4ZrERj4714ZETKgiAy/RUgGiwYIWi0rT7lbnGaOMRvHRWAinM81jkI2VhMcMlvGXNTT+v8+0n/eyAM+1wUkk/OZVTxJXHEYUaRDjciZkIHRggHA9wtNQ+HFtmzjIesk1nVBXkN8kxqrxlNGj5JA1hV5PvSgNfGcNVJnT7/UBEVa6RGhrPE/CHFj0uq4deJ/hPA1th+Uwh1U/ncbFf/plDw/R3bFjl7FBMS92lZkGxXZDMikSeGlBeApa2wgY4egg+PouxeL8U1iAP7PSddXNNbhVxFipCNZnPOMmfQicIdGJ8z/1my6Bbuzz7QzzDswpUNbTI2nR0qSXfj4KkofYETPiJX9kgoW7kqdzE46qJLJt/1k5TgXa2dJraRKIeinPC+teNWf+1F/80kddeE58vu2IV1eJ1dINOzna4DtuL8UrqlYQKK5yHu7EvUovPvLL+vyERGhG294DN4amZaWA7DBHS+sFQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199015)(41300700001)(2616005)(38100700002)(36756003)(8936002)(5660300002)(2906002)(8676002)(31686004)(6486002)(558084003)(6666004)(478600001)(54906003)(66946007)(316002)(4326008)(66476007)(66556008)(53546011)(6512007)(86362001)(6506007)(186003)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am5aTTgrRFRKN0ltcVpTSFBqVDk3T2hVV2t5eDEyWmRCdDBUYy9vSUF3Q2hF?=
 =?utf-8?B?VVl2STRzKzJRUUdBQUVOT2tNYmpHbXFqUGt1d3FOKzVHTk5ZUEh4MlNHUlZN?=
 =?utf-8?B?QVBZNzdERENISk9aSXRLU21md2toKzlDSENETDBIdGpDUHVWY0RjMS9NQ3lJ?=
 =?utf-8?B?YTVOdFVQOVhoYUtEUC9YZk84NmExOFEyN0VoSk8wRkxZcHZ4YmxGRk5tUit1?=
 =?utf-8?B?bGs4d2xSTlY0cmpHZ1RnczRJUUlKQzZGa1hZWG1pNkVvWEZkOGNxNWMrQ2dj?=
 =?utf-8?B?MjdoR0FyYWpUaXZ6dzVHWDlYSnhyb21jYWdWcDFCZzZkNUJJeU1sb1dQUVJD?=
 =?utf-8?B?OEdrZzVFQUlSOWE2WktsaE82U09QZFRyczhDeHdrTUp2RGNyZkZPUGxiMW5y?=
 =?utf-8?B?ODlBRWNKc0p5eHo1WjVobXRpZnVxZUZnMEx0RWU5QUhDUE9zSHdoN3NQdVdZ?=
 =?utf-8?B?TEZ1OFdDdnV0Sm05cU5tbjZPWnFkL2VyUkNVRXp2anZoYUFpVkhyTFZJYjR5?=
 =?utf-8?B?S0hQU0ZxZVUyb09GTnlheHhtTXE3di9tSGtMUlpIRUhOdERienNZTGZ5eXpj?=
 =?utf-8?B?SUpIYzdQWkgvbjR5NkxaRFBFaWhWZldMdE92OUpLOTFBTkVEN0EyeTVZSXdl?=
 =?utf-8?B?OFF3aE9XNE5TWU42WW1hVmozUjdaWFNRa2hRdmV6Z3REallKUlBheXMzcWxW?=
 =?utf-8?B?aXlzcWpZUXJDMHhvQ2RqMHpnSEFOaU9NZ3JDZExWeEp1U0I1R1JuUnJNbGpX?=
 =?utf-8?B?T2U2Zzh0dVRZdDBSb2hXNHZSY2Y4VUh6UU1GK1VnSDcxOGQxem0wUURJVy9I?=
 =?utf-8?B?N2pZTmZ4Q3VObENZT0Y2amp0L0I1NVcyT1Y4ZCtDSVdlbVMrc1Q1S05CUDlU?=
 =?utf-8?B?UFp4KytvVHVSTkJkU1B5RTlzd3NaK3dIQ2EwQ2NzVDk3ajBKalRsa2xYYTBD?=
 =?utf-8?B?M0owYm1CcWt6d1FaSlo2NmFvcEl5eGhoeWh2eHdkQ3FTMnB3MEZhSXFrdjRK?=
 =?utf-8?B?MWxXQXZmQmZremNzaklJV25KWEZPUVBPQTNTME4ycTR6b0pqcUZIZFJnbktO?=
 =?utf-8?B?dUpkdTkwckYvamVwS2VBYVRGck5MdjNDbTFPRVFCQ1V0MUZidUJLa0JISzlZ?=
 =?utf-8?B?dUxGaVBtNnNlWVlvblh3RTJqQVRSdzFhQ2NOdUtxQ2VYV2NUeGY0SkViOTdG?=
 =?utf-8?B?YXZSeXZQU1ZEQkpQNEt2WUhVZ2ZxQzltUk1vS2xhejcxaFVKVXNPK1RLTWZX?=
 =?utf-8?B?RlJNVUw0OVFJNVFTR0NvK0ZLM0M2Vk11SG5kZUZxUXVyNWE3NDVKZFVoZDVv?=
 =?utf-8?B?SXR6bzg5UVg0UjVoVDJwWW15QWdoQWRWZTRVUUZqRmhHUkhzQU1ycnVyNU5Q?=
 =?utf-8?B?cUdFTy9aazJUREYraHJqRGpJNFRxb3NRbE10c3k0Z1g0b2pzUHFLMGdIOWc2?=
 =?utf-8?B?RWtyb3ZhWHFOOHk1dnJXQWxUVHI5ams2S20rMTRxYlVvVzVvRytZMVNNakdF?=
 =?utf-8?B?QXN5d2taR1dVbHRsZ3NIdFZzbmFpTGs1WVEzbW00QXh5Q2dobHJrTHYxa1hJ?=
 =?utf-8?B?bVZSb0k1djFtZUFSQU9RYkZaQjdMZmlvcnhvbnMrTVdkU0RkWE1veTZwbjc5?=
 =?utf-8?B?NVU1eGgrV3piajkwaWl0UUptc0JFL2ZpRTA0bkIrQWJBTEdGVXFzV3lxNktB?=
 =?utf-8?B?b051RWpzN1lhNUNLZjBsVHJGcGFlYWlUb3I0dml1Z2E2RWhnbEhqYTdNYk5z?=
 =?utf-8?B?eFh2YlVBM2IrZk03dTlJVkRJdkR0QW12SFJaRDlqN3VTSHhGWFdSRkJUUzNE?=
 =?utf-8?B?N21DN1dESHlYaS9INU1kazYvRVFoVEoraEp4RmhYK0NYWHh6U3FwWTlsVGNT?=
 =?utf-8?B?ZHZBZmx4MzFHNTkyQSt3aUhDVmNubS94VjZnL2dlTXc1ZFdEU0RnNzdDcW1S?=
 =?utf-8?B?MTA3bTh1bHBTR3Q2REhDQVRCSUtOdFRSbDdCd3ZBdnlDQzVIWkFjMDU1Q21p?=
 =?utf-8?B?MyszaVF2WWZlR0NzTmN2cXdOZlpnekJxa2ZuK3BQcXYrQWlOZWpBQTR0dmFP?=
 =?utf-8?B?Mnl0dXh6dGUySXNoSTA3R1NiZWN5ZzkxV1NaK1ZuNmtWSkVrb1FtTkNWcXhp?=
 =?utf-8?B?SXJ4eDdOWHhINU1EUU9lTVQwOXF6eXJWVVc0anBLU2Y0aDU5ckRzd2VPYmpJ?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb1ec8d-7b60-412a-c2be-08dad871dd53
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:41:18.4535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuLv/fE/phHjjGzWsQ5Vq2gEdawWmetf+aGagLTKBFSztLQ0vFURhPVD4H/zGB5h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3121
X-Proofpoint-GUID: etpiBXyqWuGQhviL3AisLTMCA2vpD3sJ
X-Proofpoint-ORIG-GUID: etpiBXyqWuGQhviL3AisLTMCA2vpD3sJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_08,2022-12-07_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/7/22 2:27 AM, Donald Hunter wrote:
> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
