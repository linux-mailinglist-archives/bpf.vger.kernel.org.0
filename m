Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E4861008F
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 20:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbiJ0Sn4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbiJ0Snz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 14:43:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A05F9C7D2
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 11:43:52 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIKFI4005350;
        Thu, 27 Oct 2022 11:43:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=azJJ6CATdyctvPCO9Nzw2flWQjqPpEoBO9MVwzbyquI=;
 b=nObbx9cd3/G8iJ7ZjfUcFARYRZDXFXMg5pybT46AzKq73750pFIohhiMcVCv24yEZq/G
 ApJgNiGgGpYRM0y/6721KYjHJ+DlLazM1GSzxIFu3B9MUCMKn5dewrDlya0IU428cGeJ
 /FzD4DQLhXeCWuEeQB782e1RRAFu7cymnnStpJG1WckfMrKcXO3oah0qFOIXEXf1rKym
 8Fl49blY5xruxnEDQtjM2eG/sq7eDm3kzQ3sY2xs1UL4w2O3GpGiWzr0dnW0/tLmEZN1
 YGELQfrdQnhvT1fSH2pL4WsMFwbIRMFdkZ6Sl25Y3eqA3vAuh/KT51k4FkJPZLABpNnh nw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kfahs41ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 11:43:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLJdpkzMjm/Vxm2iYlsJkqb2BaJ0bpm8eIEzdn2L9gqKyJ63QUnUHarwOI4Vw3g9010zBGBZNpt6Om64pC8YqenEgnDlLzSkYGh9lOL9XXCLJkS2tSK5fcJtAjlCxqSDJ4j/JzyI3JLwshUGejKRo0891jIWJ+P2nQzVPa+BgQioYlChfNFp50J9whL2aE3pXIQ8SufTjvsJSS06cnA+xIAspTnExd97TLb2f5mFpVLuEKrQHx+lzRUzIidHTBC4l9MkXUUEhzt5ww3gEBNvIlxSCIOZ/SjQ7hBoarza7yRvwtv7Iwap2Id+UH0g7GW/7ZYOkxoZ2FqOm/xpXTUZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azJJ6CATdyctvPCO9Nzw2flWQjqPpEoBO9MVwzbyquI=;
 b=dd8IYRnKB5/gvDTFDHhng0w+nYbtqcg7sqodgtDLFPx11MKk1jxxXzSv1Qo+i4cPmjO/rG21RNVW2dClaw3/WBcxOmHuRnxAdkJkraA2vqH7UOB2BU8C1wxerIvUdHP53JKE0ApuwpGwszpZRw9489fjqrpdbva7fniO6TX1Qhs4fKhl3C/flMEKjg1EhuoL7AJXein6Boq5O7Q4e5JsOsCtYZrTBXwxv+tlbhKU+bXUdil87Lpd+aniNmn8rtLS33zsiGoKd56SXpSmxmWVJmyhJJmStmM7ofC6PMx/pVh0RVuCg6/YnED+yQtBlSCBSVlmBcn4yUgxUshaN/zNDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB4071.namprd15.prod.outlook.com (2603:10b6:5:2b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Thu, 27 Oct
 2022 18:43:34 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e25d:b529:7556:1e26%5]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 18:43:34 +0000
Message-ID: <dacaeb37-c55a-a328-61f2-77324efbc822@meta.com>
Date:   Thu, 27 Oct 2022 11:43:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [RFC bpf-next 09/12] kbuild: Header guards for types from
 include/uapi/*.h in kernel BTF
Content-Language: en-US
To:     Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com
References: <20221025222802.2295103-1-eddyz87@gmail.com>
 <20221025222802.2295103-10-eddyz87@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221025222802.2295103-10-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0341.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: 8995a9a9-1aa1-4cbb-2ae9-08dab84b2725
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LFHgv7UgkF17Z7r3toyRQVgTDraBiIuAw2ZTgGHmJwa3FnT0OVscUL9bHzKW7ZLOIhuh2j2tn3teKZT8PppgJxCfy1sj+5Br003r9jRIQstUHE+22nFDxiKRnJ4RrNBkpN+8NfvoNDcku4RZx9E8dtAHwHNMAKgiScJ21o5q0gNXyvcARpAwsf+0UgM4+iX29xOvMQxJ7ROYYRlVzPV0WXzRXjnPMNOylMvObeKIrqpZ4uvao4OsU8BEuMpLDhJwv9kmY2hheAI2k8v0UxA4S1oohiDekaztlWOzRF0zeXbIAXjOUoMmN7+NyxUrakfWS+ldPp3z80muMGQOUGys/QcnnVWtTBI6LXGpzzrbP5RL4219R6YAQwTzV3GCQruNza6WLGC0gJD16aA1/oYf+QiDzR7vekhn8lW5YJ1WP8CCpWwgrK+Q5shajIfq2JSZW6z6vAARc0H2VlmJGuPYKbp8J2mM8z+WxVxBr+lR/eHZfmouXbi3Mmv2Pf7sy70e0ylvznduQJ1kGp/RlafZJs8yKoowfoNbOjKXBYOqK75Bo5Mz6CH+oXVJdIDAKyBVRuY+24EwdzgLHi9COhg9vWpyjjObvwmCZNbU7VDUA7PrCrjrZljJw4MCv4MZU18Jspv9PMwjCTLIkkODa7mfB0WJs0MyFrATaYPJUHsc+/LJBGqxfmBNKVpw+UkmjuxREaq7y6bONz4enJWax6VMp0CnBCK2t4liVeju4Jw4oinkGLarfhtUkVWp51a/Qnvm+56ww8KV+x373g766XIjs5xctHnfrq1E/LIpJeD22Mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(31686004)(36756003)(5660300002)(2906002)(38100700002)(86362001)(83380400001)(316002)(8936002)(186003)(31696002)(66476007)(6512007)(53546011)(2616005)(478600001)(66556008)(6486002)(6506007)(41300700001)(66946007)(6666004)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xwNnVWd01yMy9zTHlnMEtsaUttS214TFJDZ1JRSWxpUWhpczNjRHhqc3Zi?=
 =?utf-8?B?OWpVNjNYSnNHRjR0aWVVZFVZLzdzaXNPMDFsN2kyZ0RBRnBKbHc2VExOOW4x?=
 =?utf-8?B?N3dUUFpOdi9Jc0FXVm5ZcnhBL0Z4TUxyaG5FQnVvNFRoYUxmZFRxa1AyTFl4?=
 =?utf-8?B?S1Q3TkY3MDk5bjRubllNNXIzWGQyYUgybmdBYXZhQzdWMkk0R0RCRWFYY2hl?=
 =?utf-8?B?T2R0dFZwWGViU08ySTRuYmpETWpTWGdXVjNPU3dydy80SU1LMklDQm9sdkI5?=
 =?utf-8?B?RnZEZ05RTlF4QUVyYUZrWmpINGN2a3pudFpWNFM1ZHBIWUlhYUx2dXlsWURS?=
 =?utf-8?B?R3ExbTNIQmFIamo4TnRWWE1kT3RYdEpnN0R6dlNqT29INXUwLzQ0WUw2TWlq?=
 =?utf-8?B?NFZ6VmxOK1k2ZEJXeVdBeElwVTE1NStNUlZ5Q0hzVG9FNlY4K0tUSGVISFlx?=
 =?utf-8?B?cjJnTThhMzZsNjFmRmo5NmxJZ0JLY0ljd01aMU42ZksxR3I4amZzS0VqekxX?=
 =?utf-8?B?Tlk3R0I5Qk9xbmo4NUhuRWpnaGpVT3JwMnl3bU16UXBhWVVRWnVlN2syV25T?=
 =?utf-8?B?bFV3RlRsTEZ5NE5ZaWUyditDcHhmRmxrdGdFRlNCVFlpKzliY2FWaHAxWWhY?=
 =?utf-8?B?QXQycGxxTlpYeE50cG5qbW16Y3d4ZzhJcDYwUVljWDlETHI2RkRRVHBxTkhn?=
 =?utf-8?B?MFl1YVRUeXZvRnAybDA0UjZ6amtHbExIemwvV29sdWlpLys2TUdrMElXTTV1?=
 =?utf-8?B?YjM3R0Jaa2lqMURYdTNlbEJJUU5sUDBtQUNlb28zcm5RMlJqMUkxMVZvSTFj?=
 =?utf-8?B?WmN3cE1YMTRZektBUE9BdWUzSWJOV0pHbTdNRGFMcDJWSkZXSDlKV2pNRzNP?=
 =?utf-8?B?b2UwMzNyU1dWUjY2Y0RGN0ZVaGF4VWNab3VtQURCWUVoWEVqN2QxaTA5TmMr?=
 =?utf-8?B?aW1FZHNtVmk0Z0loblFVRlBhV0ZwZWtPTmVlRjVUbjFocDJIdUwyVmQ5bVl3?=
 =?utf-8?B?eENLcDBGbDJPczlCQ1VaQTVLeSt4c1MrMHkzZk02L0VMMGwwditrbVNOSFhR?=
 =?utf-8?B?RHBTOU5Wb2ZTdVhnejB1WDhaa2t1bGdJQnhJeXlzNHQvUGhvM1BpMFI3ZGFI?=
 =?utf-8?B?cnEraEF1NlRHSG51eHBtak1oZGp2SEJtMndrZkRpZi9WVEtPWUlkaGhDTmY1?=
 =?utf-8?B?RjdwUkJrUFQzYktCNmFvYlVKU1h4SnlFRnljclJhZEpxT1JDMzNuWTJodUdv?=
 =?utf-8?B?MkE5OWZRU1poNktoaTFEd0ZKT21PbE8vQ0ZyYWIxWDJubkYzNUNwSnM4dndh?=
 =?utf-8?B?Ry9TalY0bDZLNmJ2UXE5Z2JnMWVIWkl5Q0pMRzYwTElmZzl4S1AwRldla1hv?=
 =?utf-8?B?QlljeEJ4OVlRVTh6YXJ6NzZPSTFpc0lDTlhuZjhsZCsvbmRnWnBqOG0wZ01H?=
 =?utf-8?B?cHM3UmtlZ1ZHYXhCdjdrREJJVUI1YnRKN24xWXNOMXI1V1U2UkJGaHVTbVgx?=
 =?utf-8?B?UUVHS215dGM1SEI2MlgxMTZYSkFUa0oxN1pzTURmbW42T2FHZnl2ZElQVFc0?=
 =?utf-8?B?dXJadjhFcHZaZElFN0xrK2ZrclkxVGM1U05BQjhuNzJnMVFWUlNMY3hDM0E0?=
 =?utf-8?B?OHF3Qk9xRkNTTG5PYUJWKzNHbGtWRW5oYzNEbU5zSGtOV0drZFBKUjZucUhT?=
 =?utf-8?B?aFEvaXBGbWhNb2k0NzFKeE9WZlpxc29LaEVQOXorNnZ1cDM5U0NxaFczMjg1?=
 =?utf-8?B?REFkVzhCYUxYNEQ0SXNXUFhOYjlVM1RsRlo4Y1lpVVZYaWJ4NFY4TnN0N0wz?=
 =?utf-8?B?SWNwbGg0YU44RmkxTFdHdVExaG5FZ21kenRXUHE3RGVJUXorMmh3YmFyMTEr?=
 =?utf-8?B?cUhpdGFnYXFUYk5vUVJzL2szdFRPY3FFdllVenQ0YVZpcVF5a1l2dVFoRHBI?=
 =?utf-8?B?dUxaS3dTTXlvazdqYXcrMVV0RHhWaVFDcXNIWjBTRnd6MURDcGdNRlFSdHBT?=
 =?utf-8?B?cVJmOU5zU3U2MXBKZGxCRGRnMjFWMlIzYnBocXFXZ2NuenNaVEtxTmZGL0J6?=
 =?utf-8?B?OE8vVDZmdGw3QVp0RVpKeUxCN0syYkRmdDdkY0l1MzJaZ3RzaWJPUWV1RHY1?=
 =?utf-8?B?ZXFyWk0xM2g4UFJRRGFidlloT2pnaUpEVEh0QXNTN2VlVmVIRkcrUEppVytz?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8995a9a9-1aa1-4cbb-2ae9-08dab84b2725
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 18:43:34.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYfRgSzn429S5Paoqqm6MoNKI4RROiJpwJeD7xX76AKBBGjJ/TRRPKupAVxlwg/3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4071
X-Proofpoint-GUID: I3UEbuUFd_UuW_VMOjIGbnzrsvrdf5c5
X-Proofpoint-ORIG-GUID: I3UEbuUFd_UuW_VMOjIGbnzrsvrdf5c5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/25/22 3:27 PM, Eduard Zingerman wrote:
> Use pahole --header_guards_db flag to enable encoding of header guard
> information in kernel BTF. The actual correspondence between header
> file and guard string is computed by the scripts/infer_header_guards.pl.
> 
> The encoded header guard information could be used to restore the
> original guards in the vmlinux.h, e.g.:
> 
>      include/uapi/linux/tcp.h:
> 
>        #ifndef _UAPI_LINUX_TCP_H
>        #define _UAPI_LINUX_TCP_H
>        ...
>        union tcp_word_hdr {
>      	struct tcphdr hdr;
>      	__be32        words[5];
>        };
>        ...
>        #endif /* _UAPI_LINUX_TCP_H */
> 
>      vmlinux.h:
> 
>        ...
>        #ifndef _UAPI_LINUX_TCP_H
> 
>        union tcp_word_hdr {
>      	struct tcphdr hdr;
>      	__be32 words[5];
>        };
> 
>        #endif /* _UAPI_LINUX_TCP_H */
>        ...
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>   scripts/link-vmlinux.sh | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 918470d768e9..f57f621eda1f 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -110,6 +110,7 @@ vmlinux_link()
>   gen_btf()
>   {
>   	local pahole_ver
> +	local extra_flags
>   
>   	if ! [ -x "$(command -v ${PAHOLE})" ]; then
>   		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
> @@ -122,10 +123,20 @@ gen_btf()
>   		return 1
>   	fi
>   
> +	if [ "${pahole_ver}" -ge "124" ]; then
> +		scripts/infer_header_guards.pl \

We should have full path like
	${srctree}/scripts/infer_header_guards.pl
so it can work if build directory is different from source directory.

> +			include/uapi \
> +			include/generated/uapi \
> +			arch/${SRCARCH}/include/uapi \
> +			arch/${SRCARCH}/include/generated/uapi \
> +			> .btf.uapi_header_guards || return 1;
> +		extra_flags="--header_guards_db .btf.uapi_header_guards"
> +	fi
> +
>   	vmlinux_link ${1}
>   
>   	info "BTF" ${2}
> -	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${1}
> +	LLVM_OBJCOPY="${OBJCOPY}" ${PAHOLE} -J ${PAHOLE_FLAGS} ${extra_flags} ${1}
>   
>   	# Create ${2} which contains just .BTF section but no symbols. Add
>   	# SHF_ALLOC because .BTF will be part of the vmlinux image. --strip-all
