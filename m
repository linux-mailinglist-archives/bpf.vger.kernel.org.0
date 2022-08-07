Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7411658BBFB
	for <lists+bpf@lfdr.de>; Sun,  7 Aug 2022 19:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiHGRXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 7 Aug 2022 13:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHGRXj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 7 Aug 2022 13:23:39 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F2465AD
        for <bpf@vger.kernel.org>; Sun,  7 Aug 2022 10:23:37 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 277DtliL014515;
        Sun, 7 Aug 2022 10:23:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=IeR8jR+FFcdHCLOd/b59OM6XwuVIQ0yu8G3n+zwBB4I=;
 b=BK6sCkPJvCF6pHkxpIlPqcIKoEaHO4jxWt2Q86jH2DIJzVZLrG0YWjkjGROGj8oIx1Ka
 Ux6RcC0dx5HzuvbDTD0LoN+3CQ/C9npM31sPcS4oWNCyc0sK+hK8s7CZf8a3gKcSIDU5
 HXnWWCHg/NzgODmjpvLXbqE0Dp3rTis1QAs= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hsndtdgt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 07 Aug 2022 10:23:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqbZt69foUvuEMLZnRqiJg4ZvE0Ho79fycJkZYzE6dI5tRqiRf33omCuPPNOu7YZ/8H2AbmmygPbtGCpEjksc5ylXG+I4TaQMgyKPw/5bdFhTIdEIOeRzTmmUYJOqolvlDnTMkq2FDvTpQQ/LxjQ2eg7oHwKZk7amY6/ukgdL1/8jB4SE4CxASeQj5LPx7wYYUJltMrhyi1x7aWJ5LMJChDKK1zShNWgWZ2cDouv4s0ALPI0S7pCOfGH7DBQJVUW0EXDQBmHU7IALxwPw1HQBfh8qu0fLiGueFjdi+/+YHhdVl/FEMGnrf1naqCQ5NUherY75x8huxyBhV4Jje/wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeR8jR+FFcdHCLOd/b59OM6XwuVIQ0yu8G3n+zwBB4I=;
 b=CBGEtzlOe2tYaKtgCUOZACa3I5Z2Joa6vgEo9OX1BWZD/Ip9omTWMIJpfg5C1ft5zZBBu4pblvoMP26ckA6W/azYMj8hvTsl/cADVB0WgkveF9jt4xU68oaDL57rJ5l1KK6/XTVeiQsoVVBexAg8dq+YbgxK5jp6HHk26yAiRD4l53bUVk38eW9dr2RXZ1wmsYQypnlGqUTPxfQe2U8TdLGku/gQ7khZ1cJN4hb/nxoHjhFBJlujVFZ24vO4W/M2jUdEOc5lYkJ9b211mXngrp59riRFt9qefi93Z7AZu2Z8gHde30N6o84mqZb65q7KmMEwM37jNrIswpxzb1tkmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY5PR15MB3634.namprd15.prod.outlook.com (2603:10b6:a03:1b2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Sun, 7 Aug
 2022 17:23:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::de2:b318:f43e:6f55%3]) with mapi id 15.20.5504.019; Sun, 7 Aug 2022
 17:23:19 +0000
Message-ID: <1512310b-ba31-6b6f-95e1-ac2760e3f966@fb.com>
Date:   Sun, 7 Aug 2022 10:23:17 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Clean up sys_nanosleep uses
Content-Language: en-US
To:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org
References: <20220805171405.2272103-1-joannelkoong@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220805171405.2272103-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2366c97-9c9d-4dee-c832-08da789985b1
X-MS-TrafficTypeDiagnostic: BY5PR15MB3634:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMIipzdOubboT5UUSq/L8zTVrFKfYIViLawg3tK04myJddIZSx8zg52NTtJLQauM1XD0VCgsjVKzAbyIIF6KiJC2liHVAm7UA3Govhb/RABA+Lhu0o5VMauWWvSB4vKL57nqU+3dUHdasRvItXr+htYOR/Ws4ydoTOijt5aDjQs471wkkPMClPuG7nCj7qP/BV22WCzjk6N5rjLFrbIa82dfvoOkitZlXMFrE2PFRJEGY2ogxMAk0afJR2IOAqxsfCMvGGr5mOFpL5ZPip8nUuihKWSRNh9umU6JF2vO9s1z0biy3b01pzTOgxm6uDh/Rmg3cJqC9lZfL4tg13It1fJvnCH5g+OhbZ/NIHsWHcZGm0U+J0eimcuGW9uUv5ALxTZJyWbJ1zweNjuCZTgcYSQ8eHEruhvcmJCO5k2CCuzXvkRIpcBkgQxns6i9hNzw+0IU8vDXFAsKFg5jpgFKLyZEdWS4HxTJUbjhCHioTvudf2HJx+U5xb84VZxZIGVcMGHIkQlj0W4dOSEcdQXFCNYrwprkR+kywOKGCXrOViAJTDJB9mshwxRFyTH0eVpcFO0eDjZNPrke0fMW46Vscqb3AcDoX8wFwcWN6ti0e6Ox/ZEJ6No3ovN+wdWXWQhJWTpMvtBeVqo6xH5w5ho4Fsvd8O+L61kYHXcc3Z6BhN4oF6MUY+/hYxQ18aPlmDLtdREh+4EN/ZYDrKdCxPC1UHou/XHebvczAwvZVKgiFfrfH5fpNC42wtp2NzhEgtEx2Dof9uLLhkBHAlqfM9Q8RRFfOMQ7ToaDn84gVtOEj9hELEKBePzwzLG86lKWD8CxkUmHDm2NihL0Y5O6I0bGcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(66476007)(66946007)(66556008)(8936002)(8676002)(4326008)(38100700002)(5660300002)(4744005)(478600001)(186003)(6512007)(41300700001)(2906002)(53546011)(316002)(6506007)(6486002)(36756003)(31696002)(2616005)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0VBcnNuNGpjNEN6U010NzB1bms1R3Y4cmZ4eFI2bHJadjFtZHFxaE1kSy90?=
 =?utf-8?B?VUhqWGtMdlhIdWRCaE1yY1QxYUFsTFlUallFY0ZOME82dFFjSkpTd21TeXpQ?=
 =?utf-8?B?YjQ4NVgwSzBGMFN3MHdwYTFtYWRKcXAzRys1UzQwMlNNZXhLUUZkOVRGL2Ri?=
 =?utf-8?B?K3plTktKQ1NsS2xPWldaWkNiWkxJN1grZU8yamFVN3pleGtXVDZlanNhbkho?=
 =?utf-8?B?cXN2clMrT2l5Z284ZVk4Ujd3WEZSbS9SdE1tQlhTUjB4bFFDaDZVdHJCNndl?=
 =?utf-8?B?V0pZRFNBc2F1KzNoaUFwTFJrem1odlgvZVYrOE5QNEpZcThVd3RCTnQ0Z0FS?=
 =?utf-8?B?OGIvZWNXK01rWXBER01uNUc3MlF6TWxnN1d0QzdQdWtqcnYreHNWNHNGazRV?=
 =?utf-8?B?dVlhQlBNb080U09SZHN5OW53QkFrSDFwWkVjbXB2QlpCQXFVK3pUL0V2aHBD?=
 =?utf-8?B?K1F3ekZIRW0vOTlrRHkvWitVU09QeXoyZDdzZ0lFSk9EdWRsTC9hcWt1RE1z?=
 =?utf-8?B?QzArVGdLQUtVejg4a3h0M2dpdDJIcXZKYm1WZzdtRHVxaHU4aGhuSlEvRmpy?=
 =?utf-8?B?b1pjdW84WFdNc2ZHckpXYTlKdzdHQ0VPK0NpS1NjcnNaWFZrUC8vaEpwUmhO?=
 =?utf-8?B?RnFrOURpVGtNNmE2RlFzaXNOU3ZmRE92V2tvNnJLRjVQYm9DMFVsc0wvNDkr?=
 =?utf-8?B?Q0xKVVpCTkRpSUNvamNhWjhwS0Y4T0l3Tnc5Yjl5WVgvaE5tSlFoY1BneEtT?=
 =?utf-8?B?bG5kME9ZK3oxbVE1L3lVczFaQnpTVnVxZzc3VndaNlZUZHQ0dGE0b0MySzk5?=
 =?utf-8?B?UjBLd0xiZlFva2RMelg5cCsyT2NwS0g5T1lXcWswL2s4UERLVS8yUkdwcFdj?=
 =?utf-8?B?MExGWkhmZVVKaDRZdFlyckw3TFd3NFY4aDdNRUQ5OXkrcGhYZ255bnJML3hF?=
 =?utf-8?B?eGt3bVV5SFFZUEpKMEtBZ0pFaU1BUUl2SkpHekEwMG1LcmFvY2piei8vU0Zv?=
 =?utf-8?B?YVZSWHZhSXYvNVF1QytpRjI4azdmMXhLdmxRTVRCMEIxd1NFTE85bTNDY0Jn?=
 =?utf-8?B?akFubU15MDVkYkgxUzVoWlZqL2p0L1JIdTNCZ3diUUQ5NzRZZWdyQmRCRFR5?=
 =?utf-8?B?aEduOWs4cmduY0R6NHZZa05FMldFMG92MkFLL0xtQ0FIdkVSY2ZQc2drYkdF?=
 =?utf-8?B?eGx4cExrcGpMcUN5MTlUdEZFb3VWVkdta3MxYmVVTCtjT2h1RkpleFJVUzhw?=
 =?utf-8?B?VFFRK3hSOGszVEZJVDJtQ2l4eWNJTlhzK212bzc0NzRHRHIyK09xNk5jTmdk?=
 =?utf-8?B?b0dzKy94NXBTbFNwT0Z4SktqUjVoRjM4aG92NnhBbEF6QjQ1TVUyaXZUb0xr?=
 =?utf-8?B?bFBXWCtQVmYrTENlTkQwdjJpS2RTUXM4SFBMTDlXSS9iemMxcFErcVkwUVgv?=
 =?utf-8?B?dTNrZWNpU0RvV1RuTi9GTjRHL2xNdGNoNGE1blprNm54dDBCak5jTnAraDBX?=
 =?utf-8?B?Uks1SEtqcExDanJuVXhiNmpIY3RjbC9Fc3V1MGtzRWpaK2lDdFRDWkRRZ1Fu?=
 =?utf-8?B?b3p5UFNyTTJ4SGVOVUtlcXVaR0FBMzE2d3VzdlhqTWVmYzkyNXZYcEczZ3NT?=
 =?utf-8?B?R040WnBMcitBaytWM1FVeHdtUEtxVExQQzQwMUl6c0FyWGltS1FxRUZrRlBJ?=
 =?utf-8?B?KzdKTCtrNkc1empISzduaVRYZS8wclhKTmlhMFZYcEM2NjJocFg0RXo4cFpQ?=
 =?utf-8?B?ODJFTmRzZGNkdEp1SFllVENpK1VDTWl2MzY2LzBmeThSM3V6UHVRTUJpL014?=
 =?utf-8?B?NGlqSURMd0hGNFppc2wybVYxSk5rUTlYY3hoSUFZTmtFbVhPTzA3NzhXRDR2?=
 =?utf-8?B?OEc4TStYNXV4eTQrc294bkFjcEtvRFBROVlQcFR3UGlUd3VLcUtUVXo2eHl5?=
 =?utf-8?B?dEVPbDc5RWU0THdITWlmczlyRXlDV2tFbXRSRlhObEVxNENjRDV6RU51cVIx?=
 =?utf-8?B?VTQ0NUpmdWFaeDhEYzJyTSsxSkNBN3dvZVUyVU5STzRFOERMQkNMcGxFS3Nk?=
 =?utf-8?B?ZFdNcjhGZmN6S0Q0cExTMnNhQUJiRTNNOVBRdHAzL0phcW5KNHpucm1mM2px?=
 =?utf-8?Q?s5sfxybrRhLIXFKFNedjzsIR2?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2366c97-9c9d-4dee-c832-08da789985b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2022 17:23:19.6727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7MKmoWvWNMK4jQaNEuMT6oCMxrCTD9w/43Io7DXmhik6A+0vzFjGyJNzf1L6WMK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3634
X-Proofpoint-GUID: cqRswG32p1bh3DEe4ATToesQTmGlRrbP
X-Proofpoint-ORIG-GUID: cqRswG32p1bh3DEe4ATToesQTmGlRrbP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-07_10,2022-08-05_01,2022-06-22_01
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



On 8/5/22 10:14 AM, Joanne Koong wrote:
> This patch cleans up a few things:
> 
>    * dynptr_fail.c:
>      There is no sys_nanosleep tracepoint. dynptr_fail only tests
>      that the prog load fails, so just SEC("?raw_tp") suffices here.
> 
>    * test_bpf_cookie:
>      There is no sys_nanosleep kprobe. The prog is loaded in
>      userspace through bpf_program__attach_kprobe_opts passing in
>      SYS_NANOSLEEP_KPROBE_NAME, so just SEC("k{ret}probe") suffices here.
> 
>    * test_helper_restricted:
>      There is no sys_nanosleep kprobe. test_helper_restricted only tests
>      that the prog load fails, so just SEC("?kprobe")( suffices here.
> 
> There are no functional changes.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
