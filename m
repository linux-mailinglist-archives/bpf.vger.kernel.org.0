Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA50C6D12AA
	for <lists+bpf@lfdr.de>; Fri, 31 Mar 2023 00:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjC3Wzx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 18:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjC3Wzt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 18:55:49 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF665B99
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 15:55:46 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UKZSqs029655;
        Thu, 30 Mar 2023 15:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=cmsowr6osZJN7kJZxdd7ujdYshMi2jMmJvokK5ncaFc=;
 b=HvyrmFWFAOmCFMENwGYUiIY9Hh1rsrNH2A2CE7lph8TdfPi3V6cB6QQ/4Yo5Cm5PKChM
 UHHf3cCJukGFuKxlu3DfM8NQbd05e6kpEBylL4bTS8xk3ru9i1XAK5RNsoa6AU0LzZFN
 l6OuhTIwrFESTFgu9rcznmE9M5taAu7SEVd4QmbIqb1olg1h2r+OURd+cE5TL/2gJ5XG
 VKS7nKIPzV/ZIAVdAgKGnB6jWt1SrSIzCuUaXuW9kOTiJHMwttn9itAjRrMNbQS0nyE3
 WnGx80ZgSSZ2wLEQaSsA6j4Y7HjfbSwYjAt/rfinFfuhRNtvTeiD1HxKruvhrYKVu4t0 aw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pmvrhr5p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 15:55:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amLKDAi+YQ3TrEexWWyaAXyHc1cCSZ+GkggKUPyQRUaO5VQa/dt/Tz26O/Lo1vYOVqef00YM2eiTWBDvP9Mp4zdGXynbnliu038CxU8e4hiuUC4vngqLrHOPVg8SnEgKA+FDeT70w/W2Z7AeH4MYzYTrMveK+ViLH19vH7rIXi5FuGV4aS0ux05x+Gs1voZicy/heqi2yjCBn0lce9Lmq8hYYSoJl68JVD7pxw4VlSF4kJ/HfSNg2o//71yK9skZ+4ZEHu2Ex7NkP2VvXyztdfwRC2F9Z6pxbAsUqLbqG8/YkxN0mAGK/Kfpg6p9B6tdntfSQOA7sTJZQlG+d4dokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmsowr6osZJN7kJZxdd7ujdYshMi2jMmJvokK5ncaFc=;
 b=fjo7vGoR1gCcb5jtj/GY/Cjve3yF7nVOrEB3HFVYfDW8vV+Ki8Ug8GTpcTudbap+Vhr/NiIHu5zHiavBgEoST+tjhVjoA45qfz2mz8leNa5p7+fRj8bU1N/plFBb1wUJ1GohJgyu4/5lz7Zzua8KgVfQc727697zyTRazr6wFEa0FdQIhEitDnhKrby500rohkJnBJKJ7DBWxhE7X1Nl1zbh8MfL4FpgvJM3wT9rz5RPs97r5dyzPZMGEHJzD+AMonM0aB6/jdRB+A4l4WA/Ui9J9dt8H0F+vVoMAkxadzMvlXEMnfD/F/GleiiN3xE7Gd1ghINOtMaoXR163e/4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by BLAPR15MB3777.namprd15.prod.outlook.com (2603:10b6:208:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 22:54:56 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2%8]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 22:54:55 +0000
Message-ID: <57694299-9960-0ab7-be61-4f6ba903b72b@meta.com>
Date:   Thu, 30 Mar 2023 18:54:53 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next 3/7] bpf: Improve handling of pattern '<const>
 <cond_op> <non_const>' in verifier
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055615.89935-1-yhs@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230330055615.89935-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0432.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::17) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|BLAPR15MB3777:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ad9f46-9c2a-464d-b504-08db3171c798
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rregZq07X+UuWSsdO2pgg2mCxNiQCb5fxo6VNl9Kj0NKsi4NmHIZxxYqw2qunsWO+J0YTcxe9AMrCU68zyCcf5+zN9cD4Y9hAfSv5LMb4ta/7p+5j6q6fCDTRR9OoDJx7/4CxNTJUAKSudKsxh3TVaY5sd8RSNIuKnGQl4Xn14s7D4Ati45JciDJrOVh4EyBkx9ltxumvbdlfl7jiajWVTb8nyn0pYBijqx7OBN8mWP4LswbKRLQYxygnIy/9Kj3+48cfhJfcRw/UXAH7NT18J8xl6QE9kbbp/JbJ3UQYYYTUbl7r+g7W3DwXYyhYe3VNHUP2eMuB987IEHQWrz845kMdazBMdq+jhN6u1u06AcYJKdy5GwjTTtbvr+ZCIlLMHYrlc/RsNGhv5zAIwUnpkqPaMFEXjfmQ74YnfZBK3xkL/sLPXM520J51YQlUIsg+o8h0JkXYSyQOxKbfJ7YrnlZosZsZfy74HD8ITXOqXU1G26kypTcuKtquWIdseRry2GQ5zufpZJnyH4KdohJje9Pt6xjhvVdDWqBMMOUBQuXYE3LIZ7Heh5u0WTDlw8LJneKzPxLnTnaqqpLEAdZ1RXCzb/xLilXSfQrbEAUBKtpq6Z8gvWiPHS/jk7FJFPJtc/XqsC88do1OzYHYsz9Hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(2616005)(83380400001)(6486002)(186003)(316002)(478600001)(6512007)(53546011)(54906003)(6506007)(5660300002)(4326008)(36756003)(38100700002)(8936002)(31696002)(66946007)(41300700001)(66476007)(66556008)(86362001)(2906002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVdGUXZkSEkzeTQvcFhwQVJtQTJVSThQWDZnZC9SNzRCY2F6UDRTWGNqN2NU?=
 =?utf-8?B?WGpGVk9DSkNxOCtFVE5TR0g5RmxPUWJ1UzUrMjloWWpKcm5DYXdNakJualF6?=
 =?utf-8?B?SDlXK2JvT1lzWE9BQWFWd014UStyQjVPVmkvVHBRTWlSem9ZUDFRaVhDNUdK?=
 =?utf-8?B?WWZieXg3eXJtYjFIWkhsRHhMQ0wrUktTSjNMUFdmU0xHNzhubTE3Wlk4aTRt?=
 =?utf-8?B?eGFETWo3ZWxKSWF5TlZVUXFQdnhxb2FjSkNPSnBUVWUwTU0xTjZzeWpwVnBL?=
 =?utf-8?B?eURxK0gwdWxacnQzdlNyK2dsV1pqTTliZ3RHZmw0MjZvN1NJTCtZdk4zbVhL?=
 =?utf-8?B?WTVJbzh6bHdtaE9OSjNsS1dFa3ZCeUVzR3I5N3ZEWDhOODFXbXNpVVg5V0tC?=
 =?utf-8?B?d3VaV25KNDY2RXZZT3JQM2FPNHhZUjF2anQrblMrTTdVQnhOQkw2OC8zYTE2?=
 =?utf-8?B?S2NuS3YvUGpWV1VjTjJFQjltZktUL2RuRWVtei9oanN2VnhrOFFGMGJVZDRu?=
 =?utf-8?B?dmJMMzZCQi9vMTNCVWZtMWNYUlhSWjIzWFRIbmtLWXU0UWZFMTRhRGlzL0k2?=
 =?utf-8?B?d2dLVGpScjFuckNJOVc5b015S3B5Kzk3dERYc2Erc3JhQWhDVE5ZZjNqZkxi?=
 =?utf-8?B?c2pqVGh5Z1l6V3hlTlVMcVA4U01kSjRmMXI4SVJTNm5WcFpuaWU1d2NXMmJr?=
 =?utf-8?B?eWRuRWVjZy9rN3dhUWdUVnlSK0Z4eHozS3c1SHo2c3V6Ym1TcHh1VnVsZkgz?=
 =?utf-8?B?OW5GbDRwd1AzQUZHWVhkdjVyeHJjTjAyUUJDK1FsdEZuSEhCNUFROUg2ZTlU?=
 =?utf-8?B?YmtGaTFBdHJTOUJUZ3RrclhndlJPN3R6dXpZM2VPZ01NS3ZXYTFSaGp4K01k?=
 =?utf-8?B?aW9MOWJoeWFHUlA4aW11cXQzTVFDb1p3Qkt1d0lyVGc1Z0R2YS9vL2tlS2t3?=
 =?utf-8?B?c2k0SWdGaXl0MXBTb3pMSGVTZFFOKzFlM2ZPQUcrQzJZVWRPVmppUUx5OVow?=
 =?utf-8?B?aU1mOUhndU92K3RvQTJVVzdTSmx1N0VoOEZ3bHljWG5YWnJVM1gweUxkV3N2?=
 =?utf-8?B?TjhYWHErNDVUTTF4Vm5GbGZWNTZ6R1FqM2xhSUZVUHoycEhCQzJLb2tWeVN5?=
 =?utf-8?B?WEFmekZRU0N3eHFXbW5DRDdiV01zQkdLUXQ4ZnFrd1FXOEloWmg2cHpuNE0y?=
 =?utf-8?B?eGR0dXdyNVg3a09rMTZHd09XeHdtRkZ2S1Fndk5UMWNsSTJnbUxLK0xtblhK?=
 =?utf-8?B?Y3dManhJUlE0RGdieWc1cWxsWVpDK2VYY3g1MGQ4Nm1uYU1RMTNyb2ErSVp3?=
 =?utf-8?B?TFpIdlI1NkhBdU9YZjRFaEFpKzA4U3NpUXBFWjgvbytrZ2Vqdyt6Z0Vjelk0?=
 =?utf-8?B?NHhsbnEvUEp1Q1ZnUHdiQnBoZzhDalo2ZFFpL2hia1dHZldmUGFoWkJUSGRa?=
 =?utf-8?B?MFJWK0I0RGdNSE0xQmJoKzBWb0EydDNiNTVYbW1oUXZFK2Zia3NPeVRKdnhO?=
 =?utf-8?B?SzdjMDBJbWpqcTF3UWhobERMcnhLR1o0bXpEZWE3R2F0MlBodDZSQzFCalk4?=
 =?utf-8?B?MWVlY3k5dmpWcHNDL2R0dHpnKzRYRTlXWXNYcFliQVNqMW0wNEthcEs3T0t1?=
 =?utf-8?B?Ti9CZm1pU3FtcVhNQ3d0RUk2K1IvZFZ1eGNUTjd5a3NRZ3pjL28yQzV6ZURU?=
 =?utf-8?B?U25PZ3ZiSnRVemRXUTY2Vk9BeHhxSS9aWFBQeW5lRUtNeU83YUlwZ3liQmkv?=
 =?utf-8?B?ZncvbDFORzQ5ajJ1UXdpbCtaa214bWgxdFNwTVdqMDNKOVV5V3RRSTlpdENW?=
 =?utf-8?B?TWFEL2UzbnJxWHhQNjFaUGk3aENEbis4cUJkNHhseVNwZHdFdnhyU3U1NXRx?=
 =?utf-8?B?TFIzZEVuMUJVY0gxTEh4Q1FyWnBHUTJHL2o1ZGFZRm9sNnlteVNEbXNCbTNy?=
 =?utf-8?B?K2J4aW1WdGhiUVVmVnJkeGUyS2lPOTM0SW5kbkY0b1MwclpuczhFa29rM1Yw?=
 =?utf-8?B?Y1crRG9EcWNiWElGVmw5VGdVdFQxaWMrT2NxaWd3Z0dReFBzNEtJVEswb0pr?=
 =?utf-8?B?OUxreVc1UW9BQXpyL1cySE1BbnJuTmdwVUVEMmgyUk82N2h2enRMR1gvWkht?=
 =?utf-8?B?RW4yRTdsOHU3Z0JFV0dNWmljTDFaS1VETnVhbTBENXJEMzRpQldzNEdzMUpt?=
 =?utf-8?Q?RcoMOEOIzJK4kWdEW7kTfBM=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ad9f46-9c2a-464d-b504-08db3171c798
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 22:54:55.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /FZsoP3yFR3S8r8GX+jFPToObiTCOfaMbgITndaVqc0MsHUVkKD5wEOESwG0fVafOhdMpXBvWwOmTVJHUXgTbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3777
X-Proofpoint-ORIG-GUID: gH0dL1xNJOE0YyvQ40B-v_x13xIKPuqK
X-Proofpoint-GUID: gH0dL1xNJOE0YyvQ40B-v_x13xIKPuqK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_13,2023-03-30_04,2023-02-09_01
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
> Currently, the verifier does not handle '<const> <cond_op> <non_const>' well.
> For example,
>   ...
>   10: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=scalar() R10=fp0
>   11: (b7) r2 = 0                       ; R2_w=0
>   12: (2d) if r2 > r1 goto pc+2
>   13: (b7) r0 = 0
>   14: (95) exit
>   15: (65) if r1 s> 0x1 goto pc+3
>   16: (0f) r0 += r1
>   ...
> At insn 12, verifier decides both true and false branch are possible, but
> actually only false branch is possible.
> 
> Currently, the verifier already supports patterns '<non_const> <cond_op> <const>.
> Add support for patterns '<const> <cond_op> <non_const>' in a similar way.
> 
> Also fix selftest 'verifier_bounds_mix_sign_unsign/bounds checks mixing signed and unsigned, variant 10'
> due to this change.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  kernel/bpf/verifier.c                                | 12 ++++++++++++
>  .../bpf/progs/verifier_bounds_mix_sign_unsign.c      |  2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 90bb6d25bc9c..d070943a8ba1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13302,6 +13302,18 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>  				       src_reg->var_off.value,
>  				       opcode,
>  				       is_jmp32);
> +	} else if (dst_reg->type == SCALAR_VALUE &&
> +		   is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
> +		pred = is_branch_taken(src_reg,
> +				       tnum_subreg(dst_reg->var_off).value,
> +				       flip_opcode(opcode),
> +				       is_jmp32);
> +	} else if (dst_reg->type == SCALAR_VALUE &&
> +		   !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
> +		pred = is_branch_taken(src_reg,
> +				       dst_reg->var_off.value,
> +				       flip_opcode(opcode),
> +				       is_jmp32);
>  	} else if (reg_is_pkt_pointer_any(dst_reg) &&
>  		   reg_is_pkt_pointer_any(src_reg) &&
>  		   !is_jmp32) {

Looking at the two SCALAR_VALUE 'else if's above these added lines, these
additions make sense. Having four separate 'else if' checks for essentially
similar logic makes this hard to read, though, maybe it's an opportunity to
refactor a bit.

While trying to make sense of the logic here I attempted to simplify with
a helper:

@@ -13234,6 +13234,21 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
        }));
 }

+static int maybe_const_operand_branch(struct tnum maybe_const_op,
+                                     struct bpf_reg_state *other_op_reg,
+                                     u8 opcode, bool is_jmp32)
+{
+       struct tnum jmp_tnum = is_jmp32 ? tnum_subreg(maybe_const_op) :
+                                         maybe_const_op;
+       if (!tnum_is_const(jmp_tnum))
+               return -1;
+
+       return is_branch_taken(other_op_reg,
+                              jmp_tnum.value,
+                              opcode,
+                              is_jmp32);
+}
+
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
                             struct bpf_insn *insn, int *insn_idx)
 {
@@ -13287,18 +13302,12 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,

        if (BPF_SRC(insn->code) == BPF_K) {
                pred = is_branch_taken(dst_reg, insn->imm, opcode, is_jmp32);
-       } else if (src_reg->type == SCALAR_VALUE &&
-                  is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
-               pred = is_branch_taken(dst_reg,
-                                      tnum_subreg(src_reg->var_off).value,
-                                      opcode,
-                                      is_jmp32);
-       } else if (src_reg->type == SCALAR_VALUE &&
-                  !is_jmp32 && tnum_is_const(src_reg->var_off)) {
-               pred = is_branch_taken(dst_reg,
-                                      src_reg->var_off.value,
-                                      opcode,
-                                      is_jmp32);
+       } else if (src_reg->type == SCALAR_VALUE) {
+               pred = maybe_const_operand_branch(src_reg->var_off, dst_reg,
+                                                 opcode, is_jmp32);
+       } else if (dst_reg->type == SCALAR_VALUE) {
+               pred = maybe_const_operand_branch(dst_reg->var_off, src_reg,
+                                                 flip_opcode(opcode), is_jmp32);
        } else if (reg_is_pkt_pointer_any(dst_reg) &&
                   reg_is_pkt_pointer_any(src_reg) &&
                   !is_jmp32) {


I think the resultant logic is the same as your patch, but it's easier to
understand, for me at least. Note that I didn't test the above.
