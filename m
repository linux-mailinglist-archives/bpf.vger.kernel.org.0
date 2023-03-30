Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520566D10A2
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 23:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjC3VPd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjC3VPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 17:15:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40970EB4E
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 14:15:05 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UL2BYl022831;
        Thu, 30 Mar 2023 14:14:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=cUU2Rt+l5AQ0qfMFtOEg0ervbxphatgDZBgjQtY5deQ=;
 b=OwDrwECSxlhItKvvxXiLIlDavA4P+mEcGtqccxU1jBNB3ZQ9oZ6866AWNRZ01sqluVnE
 xXarztGGZttBK3lAEhmbBgXJ9zH8YXVNKeI0rmPkFZaf3OI4Dbcew0Mgdh5S67BKGGVA
 G94wJDPgilF4GY/l680Q8aw7OccZNpB3gZ83I2wg+M0+OyIv8ZvvfN7r3wJ0Y0fd+QdI
 nZ/SofNa4opqKpdBZ9B+U4ikwfMh1PQk4XeArToSvJvHgbDh8G0mBdb6w1EhCcvNqMh7
 wkN21idGXTSsEtiJPIDMVxLqIPbB7pPvuh+SRy+JVE5GFnnIM3yy+ZrihsDO1tn7CIVW eQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pnj01r2kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 14:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4vz0jY7vrSinRR4AnFnCBhB3swrBlAMeA1xj+mHT8/PQO3fU1moWkCYL+A6M9w2UwBbvGSalRB27TW/Y8Y2iVCCWv69/+CI5QwTBgdPFgdIPfuRJGfh/B3E20+3EdzYV5umKqxINb3NpM+TydIyO5jPokELSoBDldaB2D1OxHTF0thGt0v3gg5UzIdfibEXpSWJEGzAFaevLvpTMQS5M4ob7bRc5NANuHiW18vW/hZ7f1glFarPDQaUiTwvPSallRiu0pW2nJUtoQDBbqQdykZQGFOoQFgmq31vtwtMa78Omr9WHel3olVwnOGj0QFCtKjhaBk0L+YM8IAtOOzurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUU2Rt+l5AQ0qfMFtOEg0ervbxphatgDZBgjQtY5deQ=;
 b=mQsohx+otoBUFGJBMTEs4ln351J5Fa1sh2Xl+RQ7ko95TgXwc43ewu4lso+uPwieLFdeD0DFQnoH089uD/sP0nF5XpSmqtexfEtLU7UA2AmkScRtxUM+SSG6o5ZkvJeWp9BX1irGd8CN7NtDmlKFaMgv6GhErPnAk+OukU+qr/FkIZaFUaQ8CshwRzxHWGGaz1x7d0WHLMpCPyRvNUcAzIl9DpxrHcqr1c4KRTNHC64Z1PK0XOkL9hIzjsHCn2dBpwf1feuXqrZ63Ttq5Cz4BJW0uefEzmEUPoDfCZo43mQwzSzMVp1bB+o23S8g5r552qVASC37gRRPPD0kHqoJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by SJ0PR15MB4568.namprd15.prod.outlook.com (2603:10b6:a03:379::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 21:14:45 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2%8]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 21:14:45 +0000
Message-ID: <e16053a8-d9af-ea22-3653-9cb9591c2eaf@meta.com>
Date:   Thu, 30 Mar 2023 17:14:42 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next 1/7] bpf: Improve verifier JEQ/JNE insn branch
 taken checking
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055605.88807-1-yhs@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230330055605.88807-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0125.namprd03.prod.outlook.com
 (2603:10b6:208:32e::10) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|SJ0PR15MB4568:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a4fd21-4f0d-47e2-9209-08db3163c96d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0T+jp7CDYk4JRAxr4ldt5rg/QkYr00Glzebp3d/15jxX501FMMEQxs2IUdtDt/BLCCJBzJj07VXAYGkfAC0zSALWPccxOWZIQNoipjgwmkplgX+qqyvigeJq0e0TaiZ0HlH9oL/8swvTagUy4P2OVaYS4qz+hRlc4pwuHDMyZrZ2txafo26mP7WB1OXzLDEXA6lyyuUTSeQF6oWIrof9Ti03l6ZDi1GMVpLv3V2EXWomJGmhLuWi/FSJNlcG5hXfeWQOaDaomqOHQB6xJZ3CKi9DwmZlQ/TLb5gY1vrJoi8j6wUHnWGU9h7WdbcuFdjLFQiabe9M0s5pIbA0Ymm7eXI0mAxXhqQ4vygC0tjDp2RfqSuIaqvuiOawfNciuGQrmEsPUV9RN3YgcSXuX5tY8FVTBMBEjSLajhMcjMRNNEAeEyDf1OfRcjz7aIOaI0lLpGm5hCe4Lzi6ckh5AVHiO4HDRMOAkgAeuJ3iqIBjHG7e+BoVltZj3+dvNnlQIzHeueH3DSeqEbjPCQVvl1rFBs08AufFxuTnQ5TbgTin8VnvRM6HS5N7Syljy22G7zxlXF6KJLfTbd8b0uy5uHGB0gXhYKRxIugpU2UYhMao04bQmw0UN+dA0VX90cu1woya+ZMlo/UgBfvfsdIJKxCnxaW+otSwLBxGlVz7FoTk8+iklj24dAkpJ1AEKbe5hOx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(451199021)(6512007)(6666004)(66476007)(53546011)(6486002)(38100700002)(2616005)(5660300002)(186003)(2906002)(8936002)(6506007)(86362001)(54906003)(316002)(478600001)(41300700001)(36756003)(8676002)(4326008)(31696002)(66556008)(66946007)(83380400001)(31686004)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm9sRGxaZVdrYm5hODdnbHFOT2QzRUFNd0doZHFkSGI1dEVkNlBOQnYyeXE0?=
 =?utf-8?B?MXI4ZHpzRzNXdWJOQjh2c2thcXk5RHpPdlVxeVBneEpMQVZNb1hUVUtFMldI?=
 =?utf-8?B?ajcxWVFyeVAyYld6U1pZb2lMVmh4NTZoNzl5NFRGbEE2N2Mvc0craWZlUXdr?=
 =?utf-8?B?VVRBSHRXcjZEN1g3eWE4Q3RRMFlRaldZWUtYNEI1ZFB5MGVnTkhvWmlEMmdT?=
 =?utf-8?B?dld4V0xiVnlZMW5TZ20yUEN5VVRYaFZSbVgwZU9LZE9XTk9jcU1FOE55dnBV?=
 =?utf-8?B?SXE2TDJjRVl1aWRUaW85Z0ZYaktrVTh4VUF5RU9yUkRNOEY3TmZwZzkwSzd6?=
 =?utf-8?B?d2pOeXFMOGdad09CYjJpcVZ0T2Ryb1lRNUNvWWo2bk1EdkdNWWVNb05sM3F2?=
 =?utf-8?B?WHVSNndYTDQ3elVxMEp1eDB2MEl0WFZJZDNwNVN2Vy80alBXYXdzOU8rUFJn?=
 =?utf-8?B?cmtVckF4aVE3SURmc2ZYemdnT2lYL21VWkFNNFlxRjhPV3RndXdjbjZYQ2ZD?=
 =?utf-8?B?Rlg1R2NTcVp6RW5jb0VtV21Da0lQYWR6bVZmZUdRRnZ6VE5yTFBCNUJFb2Qr?=
 =?utf-8?B?S09zU05iRG13Q3Y4SytlejFiSGZEYUN2ZkhqeDBySTBnaGFYMHBHaGtuTis1?=
 =?utf-8?B?OW1UdTR1N2x0ZTZUWDlWT3g5amRuUy92VDJUVFg2TXoxcHBCeVZBWXZJQXZi?=
 =?utf-8?B?RUp6UStsbXVEc2gvL1ZiODRCSlNwTm5JNFRRMjNHcFlMWHBvZndhc2NIV2M2?=
 =?utf-8?B?RkhKSEZiUHhaK2JVOHdQMW5LczdKMmo3UzBCYjdLMW9qb1pZVmtoU0V5WTdU?=
 =?utf-8?B?ckZsQW94RVlMRWxJWFNrVm5CblFqRlVIS2xBS0hrM1RsZWxPNlBaUmsraEVG?=
 =?utf-8?B?Z2xOelNwbnNKZWZMY25IOW56emlxbGwxb3hzdUJRN0tobHhlUkpVSjFMQ0tv?=
 =?utf-8?B?cnBaUGFsRG9uR0pQOEQ5WE04WDRtYkNSMUpaZnlzRVM1VFdKSnBKOFhBVFhm?=
 =?utf-8?B?NWQxYXZjbFUwb0dkZTdFRU13Z3hlc0VxNXlIdmdHUHhYUTgxMVB4S0pZZEha?=
 =?utf-8?B?U21oNGxOL2VTMkFySWtHSEhZTEREams1OHB6NnllemhQbzN3RTNodHA5SnhM?=
 =?utf-8?B?QWlSa3A1RGhnRCtIN0RqZTkxMnZwRis4RkRnYlZTOHVyd3BOMUlaZHpaVUVB?=
 =?utf-8?B?UkVVUlR3N1dld1V5a0tzVWxXU0RPcG9GdkdDWFhUL1ZTU1YxSmI2V0RTTmVJ?=
 =?utf-8?B?eWxnNy9WeTdQTXZmcThZb1BPeWdRK2hqeGhiTGpUb0tLdGx0K2FYQkQ0R3Rv?=
 =?utf-8?B?eG5WbXVKazNkRVFHR3ladTdpalpxUU5VemNmSWV1RXFtZmVFV2JKekFBNnox?=
 =?utf-8?B?OXJsaXUvclMyMzE1eHBRUG5zc2hBaHFUVUhNRVE4Ymp6cVVMUkE0N0VMZ25u?=
 =?utf-8?B?OGpGb2NTOTRNMTFZM2hOcWtiUlJOYkJKSU9lSDlqazZ1Qm9UUjZaaFo1dXJt?=
 =?utf-8?B?NURMMnpVRDVzMHhGM0lzeDc4emxaMnI1THBjOWtTL0xEcTI2OWNOSndwa29D?=
 =?utf-8?B?WXFHdDNTMHNMWUtkYUZMNXgwdlZncHQ3N0lscEZBZVlHbnZpeUNSQWZndXhW?=
 =?utf-8?B?Z1d5UzRNVU1OajNVOGdaVGxJVG5kV0FEaktPVTFUUTJHNmZPRnhBQ0s5a0Z6?=
 =?utf-8?B?ZmtUcno2aUdPa2tTVEVhVnVna1VBS2xPa1NuWUhObGVIUjNBazlWRloxNFRQ?=
 =?utf-8?B?L01jc2hmQTUwZGZYZSt1ZVVsV3UzQ1kxYlJER3U0dG9VZVRPaU9nMWNVOGt4?=
 =?utf-8?B?T21uUVVlRWRRQnJTdnBWckRlK2NUaUJnUjhWeERJam5TaHhLekhkKzFucklO?=
 =?utf-8?B?Vmg1MnFZVDFhMUhYSjBiV2VQdSsyQVQ4eGtaREcwVStyb0dvSGl3Ty9yU2Nq?=
 =?utf-8?B?OHE1Vjk2OXBrY0JEbjYvWllDSUZQemxwd1puKzBkVUkyOW1XRFprMDFVNDNm?=
 =?utf-8?B?M3lZcUZOYmE1cVlZR0Zwcmx6TVduOFhUOTV6U0RQMm5LeExWOW9uOWI1OFdx?=
 =?utf-8?B?dFFxV2duWWNPN25adHhsZjlHdTZQc1dJeHM4VGNIQ2gzY0tZSXpnR2JkNTBM?=
 =?utf-8?B?dms0a21EdUtiR1ZBeGR4ZmRXVFNuZDd2WnE2TDhDbUxoRm1pOTNkOXd2WnFk?=
 =?utf-8?Q?NEboq5Mp1dAWiDJPOUo43EA=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a4fd21-4f0d-47e2-9209-08db3163c96d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:14:45.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qo2gsgc7b3SnMz7MFkH0xe7/qXy+xdNH7G9B78pAXYcdwogmKhm51zz8kMUKEkTVEZHGCac4wb0I6SijZDzH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4568
X-Proofpoint-GUID: 7oqEurpeFnT9WMHzRTlKc4GYdNBseK2L
X-Proofpoint-ORIG-GUID: 7oqEurpeFnT9WMHzRTlKc4GYdNBseK2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_13,2023-03-30_03,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/30/23 1:56 AM, Yonghong Song wrote:
> Currently, for BPF_JEQ/BPF_JNE insn, verifier determines
> whether the branch is taken or not only if both operands
> are constants. Therefore, for the following code snippet,
>   0: (85) call bpf_ktime_get_ns#5       ; R0_w=scalar()
>   1: (a5) if r0 < 0x3 goto pc+2         ; R0_w=scalar(umin=3)
>   2: (b7) r2 = 2                        ; R2_w=2
>   3: (1d) if r0 == r2 goto pc+2 6
> 
> At insn 3, since r0 is not a constant, verifier assumes both branch
> can be taken which may lead inproper verification failure.
> 
> Add comparing umin value and the constant. If the umin value
> is greater than the constant, for JEQ the branch must be
> not-taken, and for JNE the branch must be taken.
> The jmp32 mode JEQ/JNE branch taken checking is also
> handled similarly.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 20eb2015842f..90bb6d25bc9c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12597,10 +12597,14 @@ static int is_branch32_taken(struct bpf_reg_state *reg, u32 val, u8 opcode)
>  	case BPF_JEQ:
>  		if (tnum_is_const(subreg))
>  			return !!tnum_equals_const(subreg, val);
> +		else if (reg->u32_min_value > val)
> +			return 0;
>  		break;

The explanation makes sense to me, and I see similar min_value logic elsewhere
in the switch for other jmp types. But those other jmp types are bounding the
value from one side. Since JEQ and JNE test equality, can't we also add logic
for u32_max_value here? e.g.

        case BPF_JEQ:
                if (tnum_is_const(subreg))
                        return !!tnum_equals_const(subreg, val);
                else if (reg->u32_min_value > val || reg->u32_max_value < val)
                        return 0;
                break;

Similar comment for rest of additions.

>  	case BPF_JNE:
>  		if (tnum_is_const(subreg))
>  			return !tnum_equals_const(subreg, val);
> +		else if (reg->u32_min_value > val)
> +			return 1;
>  		break;
>  	case BPF_JSET:
>  		if ((~subreg.mask & subreg.value) & val)
> @@ -12670,10 +12674,14 @@ static int is_branch64_taken(struct bpf_reg_state *reg, u64 val, u8 opcode)
>  	case BPF_JEQ:
>  		if (tnum_is_const(reg->var_off))
>  			return !!tnum_equals_const(reg->var_off, val);
> +		else if (reg->umin_value > val)
> +			return 0;
>  		break;
>  	case BPF_JNE:
>  		if (tnum_is_const(reg->var_off))
>  			return !tnum_equals_const(reg->var_off, val);
> +		else if (reg->umin_value > val)
> +			return 1;
>  		break;
>  	case BPF_JSET:
>  		if ((~reg->var_off.mask & reg->var_off.value) & val)
