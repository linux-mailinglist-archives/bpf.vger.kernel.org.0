Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E814621AC8
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 18:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbiKHRec (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 12:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiKHReb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 12:34:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9133010F4
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 09:34:30 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A8EJgpe029507;
        Tue, 8 Nov 2022 09:34:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=fEwCHCe2jc6bii8/keZbVJVQYCf5k3tS7Dic+l1s/XU=;
 b=GbqWftlathoYRJgNBTdVNfbqYuJXllG3Snd/XcL9LPRu03LAew03ZqqnwkkHfhXQKltc
 5ziYKxAvuqmqa2ysQukocaLBjxrSAeL+WSfFwRboN2ika4xb+8rvWNs0PDW0IWbk0NG6
 ojecHDrtac91YXYg8Xd7c6UUpVZeRwpc/RCnQige3JmOm+DORva/er6S6meUbMgx6FzL
 MUJZuov9JvXU5+ZkscQFk8gF6iQ6KOJYE90X15DZ4M8ey5NapQHRSWfQZI5vI/S2pVdz
 2eyHlQbti8n/EOAFhMOKkS4VLp7xSI9VioOeHdrQ3A56dFV+4XMEqIneRfEusY9zZCiN Hw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kqcc5pyxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 09:34:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRwvXSk58y2GnkZCRQMQ9NWPeXWR3lRLPh5QnaNBb6P7k0iPgoxV/h8OM2Fyq45GJFHxt/twozLHaV8x+repnsbxBbalCF75TE7w8CXMcqsk6h0Pi5TbhyM/Mvk7G4SF1R/fPcOxf/utindhnIYxmuSYaL+T+M+nfvn5QDTRo4OXyBNSGe2cg+Y57dNY75aIjJfC2qb3YLf0+/9U5Wb6CA7fyvxCuPtcOxSvAvCTU7NIQ9acNk+zIy0ySR3FI6W7Q34ktOLDSf9kQokhQy70nJkPubZKujOGATP6mgKVJQpWqVhh9AjrdplBnP/5OABYoSbgu/iLu9viUek2/1Q8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fEwCHCe2jc6bii8/keZbVJVQYCf5k3tS7Dic+l1s/XU=;
 b=OaginFTIoOINAlDhf+mPM+2O9C5XeeTqfjHLQ/t8Dnk3CPoChMRB6Ujk2Y14HitIuEdRj89WW5SzA6kByXLNrpi3W0I637/Y44qnqK02soTQsxC1yT3IRRdOwMb6zI6tnwAC/BUxa/RnCq86zbxKb8NcTnmVVaICL93/1tJbHCWbvqZ8GnTDy/jRIBb6+600GvGvLAzo6o4fD0ahgVQj+r4IBBN5cdA2xQt0ag1fZnlni5cqeb8/Xgcy9yNjIYx6LspmgVCyXgbzaSLs2rtGcsUTlfrlL96PHF4h0tvlLCMmW6toDrneKsn0MYOeSnTra0jiNoJ9LRKEYitA42rU5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 17:34:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 17:34:09 +0000
Message-ID: <91e942ee-dfa9-7160-4f6a-d369a2641434@meta.com>
Date:   Tue, 8 Nov 2022 09:34:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 3/4] bpftool: fix error message when function can't
 register struct_ops
Content-Language: en-US
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
References: <20221108142515.126199-1-sahid.ferdjaoui@industrialdiscipline.com>
 <20221108142515.126199-4-sahid.ferdjaoui@industrialdiscipline.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108142515.126199-4-sahid.ferdjaoui@industrialdiscipline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dad1d12-3ccc-4f66-4845-08dac1af716b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S7vEAv4+gvMvYICzT8tJ4DIj2uhGPRKVfoMKNWPmKsd0UhIY2hInhrXlGYgejrRTw754ULf87kgOm7QZeyICrXfCek6qiFHinEDP5w7dAhc4GwMa4/rJjpmMIvbVAj0+VYdFAoyiW1xbXUfyQC0ygVBjZn7KGR+U0TdBTFJy9EHWoTNXYc6Zp0OQZO4j9FKpJRJoVXCEWrdJozHqLNtGXBJtm+5xkUTCK/NMKwoWSkM+f3JIQHlGtX0FmpML3RS94D4e9vrGJsrRDhh2AHiI56NVFYbbH7fwVNhiIc3ed2A7Ow9FS15HfLgcCwbsT5eM5JSmN5RdeBHqCxEiuF77qcXhVBl3eM6LDl38QvUEavqM1gIjN1ueFC1YjzyU+9gHG/24tc+CAOMW2WE7M68r2D/f6c5n3RgGkhzD9UZQzEyRci8AuV4exkcJJkjC/MqHV+oX9g+iPV8LRbcIASCZiZG78ga+12OOh7uX2++lRjhNXOhE8FPm50CIY4krufo0FpbTVGB2TKBYTD9gFb+rv3w8SVFAODPB2wXp9Hvs90pz/wp1am5x3Rq4yCpsUc/Ju7te07fLlrlcL8HyBTH2lhy/kUn7AWbAaA02nJusky1/r3IEVH0oFukJxKT6oW38mkOMNCuf+6p7sw+xTZrPfhbTUqQHiOiiNoqTjQmF2/Lu88K+wX5hh6OtGmM9OLrKYtUWbd3KvOjuZsY/KbFJ6jsOuFJXXWnmYljNJYpWlBw5MKv8aYNp01pAOsMr657dODAh0k2MsaQ8priixXG8XV59lSS+8Z97DwFs4+tFMkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199015)(38100700002)(186003)(6512007)(5660300002)(2616005)(53546011)(8676002)(6506007)(7416002)(2906002)(8936002)(6486002)(66946007)(6666004)(478600001)(316002)(4326008)(41300700001)(66476007)(36756003)(558084003)(66556008)(86362001)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjNjVTlSM3hRbTkycldkRHE2aEhncUUyYzJNZGdXZmRnaDhQQmpHV1JvcEcw?=
 =?utf-8?B?RTdEbng5dXp2aEVEck5QejRwZkh0bzBnTWpMS2ZZbk5iVmtIcHMyRXhIUnVn?=
 =?utf-8?B?UG9sUjEya1ZGT0U2Vk5EeG9HRUtCTi92Si9RL0NYUG5hekZVdTJxbWx0dkJa?=
 =?utf-8?B?YnhJQk5MaE9MbCtsSEFFd1lvaHhFOVBTelF2YnJLU2VsZ0p1RXNyN2tuU091?=
 =?utf-8?B?aWdOVWRDY25ONG5pcmpJTTQ2ZDFyZVNYbE81Tm1SWURWMUdDaFFpQjZYVWw2?=
 =?utf-8?B?VWJFemYwZ3pBMlJHTjg5VW1JVm1SSCtHYVFUcTNVNmx5NmlkdlIrQjV1WWlm?=
 =?utf-8?B?cmVxRHViL2V1RVVsR0pKL05LVzZtRzdrZ2UxeW1VeGpmOGdxRHJrR04rNk5m?=
 =?utf-8?B?cUQ3a24rOGMvNG96NUV5VE1Eb0ZLNHVyYkFMME96cnpPeC83M1N1akJxN0Qv?=
 =?utf-8?B?c09nN0x1SklSZjFrOUtIbk84Nk1zdW5wcWJwTWU0Q2YzcTB5d2MyUmJyMSsx?=
 =?utf-8?B?em1nc25yaklCUENac2NhVWN1QlJlSTdrU1FXYkRsYllvcG5acUJ0OVRzMDNK?=
 =?utf-8?B?b2MxUTBCNkhXSXordjRJSTVHQmZGL05pbGUwbXpJVTFUREU4TVJoN2Q0WU83?=
 =?utf-8?B?ZDVqYXQxOHdmdVVUcFFVUDBCb1k4dk13WExTZHlmeElQcFNtM0M0enlYOWFi?=
 =?utf-8?B?aVdha2IxOVFOOE5VaWVzVmhiMXQ2YXF2T1d6bFMyemtac28zOXdNVmpaNXMw?=
 =?utf-8?B?Q3U1UGMxZncwWHEwM0VLMk9qd1dmNENvRndaM3lvZDJDV2xNcGNNTWxvSGxO?=
 =?utf-8?B?TURyazNSMDhSZnN5QnpNSmlmVVM0Zi93VkwyWGtZTSswcjk3MUdtd1JqUUd2?=
 =?utf-8?B?a1FKWHZTM3FUckRpK1dnaVRzMlVPMzFWSmdwZERLZEUyanZlaVdvanViZUFT?=
 =?utf-8?B?UFNyZ21RVzg1WVBDaXc4b29XMDNxS3hDZnB0ZzVaODNYeDZTVWRNU0s3RUhK?=
 =?utf-8?B?TmdrWVJvRDNTUTRUN21Yb3gza3Q4L3FRZEtFYXRNU1V0N2xYK2lSN2MwM2s0?=
 =?utf-8?B?eXMwdXJvaldhREQvamdNRW9uZ3l2MmRyZnNHUE92WEFkMzFQZS9mVUh4UG03?=
 =?utf-8?B?VW5Db0xxZXZDNkwzWXNITmxTQW5YSXhCcDZjUkFxNjgrWGE2V0xsdmI4bjNP?=
 =?utf-8?B?bENXVUVNRm0vSWEyRStZRGlBZEZDNVZsTlhkNEZPcHBZeGpRUXYwMWpjZmdK?=
 =?utf-8?B?ckt3aGkxMUI1VW1yVHZWSEszV01NTFRxTVMxQ0xzczcvelpFZkZxV28xYjNq?=
 =?utf-8?B?blFWK1NHeisrdENUcVFPRUZuNHRpRkI3T1RyditPVCsvczB5Z3VxRmhTeWR6?=
 =?utf-8?B?VEhBQ0lJVE5ZOWljczV6WjR1a3I1dWVPTVVCUEhjL3JpRW8vbUpPMTFLMUdF?=
 =?utf-8?B?LzkzVTV3Y2daMHVrVzhqNTMraVl6SzFYdjZwT2M4d2V2a0hENGk4SkxsM2JI?=
 =?utf-8?B?WVZhekNWUkJNUlIzVm1CMCs1UkxtTmRKcFJ1RS9JZXNmTWg1MzQyaWxTaFhY?=
 =?utf-8?B?UXJmMlJPd2dQMGF6L01jU3pMNEJ2emg3M3pidzcyWnkrM01jRW5Sc3RML2FJ?=
 =?utf-8?B?bDhlRHpjeEJxajVaYnZkWHpCWGF6UmRZV0dnTllvRHJPUm1iQnlvSVJBZ1Ri?=
 =?utf-8?B?QXk0bkFiRzArNVYwcGRlSFZKYkJncWVrcTdiZTZCSVNGcmwwc2RYMGY4S2hO?=
 =?utf-8?B?VzdxRGcvWE8vSUw0cGNxNGRCdno0RFhUbDdIZG9ONTRnbXZsRlp1VklvT3pX?=
 =?utf-8?B?M3lMWVBsVWZFbU15RFpoaE1Lc2h2aUEzMVh1Z1FCbWVzNkxjZ2gzWG43NE5z?=
 =?utf-8?B?S2g0RkM3b1kra3UxSC9mTFRZVkl0QWpEZmV5dWxTTEkzeVdSc29KZnlDME8w?=
 =?utf-8?B?Y0wxV2l2T1ZRQ2lqYVE4WXEvcjVaQVZUa0RCUlc1MnlCdzhMQWVjRTlvQ3BK?=
 =?utf-8?B?TzI2bWpvZEdsNTFLT3RiNVNlVEJ2Znc1OUlkdWxRYmU4SmhqM1B0NUh1NDlN?=
 =?utf-8?B?Z2poOU42QVBjM2U3WDJ5U3d1U3VqcFg1QVpHTmYzcHFHZDU2UG9NQTBpRnZx?=
 =?utf-8?B?c3ozVkhjckd1TzN6K3BjMnpLcXY5V3FCbVBpdXd3WTBtd1c5RHdUMkVCN21T?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dad1d12-3ccc-4f66-4845-08dac1af716b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 17:34:09.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+8Ep5VFW0lDayrtQkUCvcuXttHvi2GMwRnMQgNb12lV1uidejfIyOatsKBWV9t2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-Proofpoint-ORIG-GUID: arA-rMmcangZfYRX4asY7YCLXRQNtwDb
X-Proofpoint-GUID: arA-rMmcangZfYRX4asY7YCLXRQNtwDb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 6:28 AM, Sahid Orentino Ferdjaoui wrote:
> It is expected that errno be passed to strerror().
> 
> Signed-off-by: Sahid Orentino Ferdjaoui <sahid.ferdjaoui@industrialdiscipline.com>

Acked-by: Yonghong Song <yhs@fb.com>
