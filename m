Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339B26D517B
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 21:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjDCTl2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 15:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDCTl1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 15:41:27 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897E926A9
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 12:41:26 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333HMbD9019660;
        Mon, 3 Apr 2023 12:41:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CP1uV/ZULOAu6sb0x37keNiyQUlLEMGKCAT0PGCRIHw=;
 b=KTNtkVzaiGrMGlS7RD4FwU4JCP3A8Krd/NFfu5TnKU+KFyDsF8rz8KhMByyFxsOeedA+
 gR6nX3pENvBwwBA+UjXU7WYceAUyIXs+kbw4Hcd8EAjXLYuFJQAeTa1MSJ4YMcJqWfhO
 5Vt8fh+5ZJ7PTUAQo6Gx16kkrGTNPR4p2SxBvy6xulX8DctozP26YGzs9ABFSpEvD5a+
 EutV+IibMMFhV3Ay0H/bz3BVOXlQpr9KpbeywAEHcyJzN44tBT/jDXR3saf3LVImnMrg
 8DN9BPe+ygTpQDKdFbJEGWbuAhqYWWCvzIECtdzZ+MkJ08lZBiSH/QfaGglBr0oqbQTh gg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2049.outbound.protection.outlook.com [104.47.73.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pqxk22wbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 12:41:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzl+/TjzYfKdFhCm39C7luFXniuN1GYFXFwAvsV6Lq4pZlw3DhtdMuCpRtE5EaZiLkS2uSr4PbJ2CaTpds3/QZzrp2X1KVt5U1uUVKXVhFQBBp7MOGnwRdq6KV/F8RcWQ1WXKwp42gLVd7RyCczFWaZKt53oyz6UOb/KwbWWhbMafoaBRmTBh7d1nif83YreaTwYF3XFxgXTitbSKaxLpS9IRnejqniPzl8iDfjoxEFKzjwRPGnQ2+UVkb71TcUW/lEktpKwQMtrMaWsOSOHUw+CqFAVfoonDLhbXVGT6CJc0dSDVHQsX1NGRtxSBA7Nrn0JvS0yTANhtRCOC+hU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CP1uV/ZULOAu6sb0x37keNiyQUlLEMGKCAT0PGCRIHw=;
 b=oDmxx5wEcIgX9BAbzEp2cfCkuaOEJuOzH16cx/YB93Ty049dhqjtKS7ZsXEgVajgmoSCK3W/qaSvLJ9pDAbkBlKTzSo3HWFnhOBsmQJoaDbsK4bldvNDx6ahAbMox92jqphK0fM+a4WfGOyoovIrLpcArjcSOgcrkYhp+2Y0RcOx993PvOMmv8zLi1s+1tQ+h0hhJ5MtjDfg8DRN89ut30uBbzjvUbU2/l9GvvZTzRYkHHq5dlEtig3deHQWMcZkaEErisp2uPFytADtCuLcjmxHSF0ySyICprJ4sHptWt1BJpWSZNPqFXK2TipPReuehsWBq02w+12PVW4SxK/Nvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by MW4PR15MB4523.namprd15.prod.outlook.com (2603:10b6:303:108::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 19:41:09 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2%8]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 19:41:09 +0000
Message-ID: <2bffdfe2-92c2-50c0-410a-7649933e4743@meta.com>
Date:   Mon, 3 Apr 2023 15:41:06 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf] bpf: Fix struct_meta lookup for bpf_obj_free_fields
 kfunc call
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20230403173125.1056883-1-davemarchevsky@fb.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230403173125.1056883-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0033.namprd19.prod.outlook.com
 (2603:10b6:208:178::46) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|MW4PR15MB4523:EE_
X-MS-Office365-Filtering-Correlation-Id: 048708c3-9715-43c9-79f9-08db347b5f5a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B/+MwjBMLxjs+tjhV2gyqNNWYXWXEuNg+yW7S+JEV0Su4vM8tT5vjArbJ25oifGe6ZSp2/O35K0alshR0jooP9JOZiNmCm8wBn1RF9JR7qkekPDN2h/Fboey1g84g4Rdep3y9K39/3YAwqP86gTSPgGyb+YI50I8kj8NXgdYGuO7sVYi8M0ynIZkFV+wu4H0Y/Fc0Qy85LPrwyv2HsH48PzjfcuLh7MDP0IryaFuFqD36vSkf+R0LlFZWHeKsLbTyUGsf+F/mJWHhgz2cHhD6Ep/qxh0rhBwMZ0iPQWzJTgq/MeQSuLOlKcx3bldNLDjCXXVavqRxVwKZH9IL2piYIc6jxmiFxp7I8drpK8xmYwQjZiSQ73RW5rfSde/J1P5q6QUlZ5NGAwKGjDD0/f5fE4UjhbccPaMjh9IlY5sD30wTxwtQhCIT912GfHbsc7i9Evi73R7t6L8wHKdi4XuoD43ea4+lB0yMRJPokaWLsIEyQflFPNFiepg1ZAdOvfxUytqK5tstPkI2j8ocVQS1lJUWkdTs2EglLanjwNW9/zMK2WLjDHGjguE9XFL++/9qHve14udqetvxqKQ4cn3NbKyGlKk5oALvFHzjvq622f+ySZD4G2Yb8Cx9K+t1QjgjvlYsfTxwfmKou9w1UQh2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(451199021)(31686004)(2906002)(38100700002)(5660300002)(66476007)(66556008)(66946007)(8936002)(41300700001)(4326008)(8676002)(36756003)(54906003)(316002)(2616005)(31696002)(53546011)(86362001)(478600001)(186003)(6512007)(6506007)(6666004)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVd4U2lpM2o5bGtYSTBBZnlxZjRTNUV3cjdOdW1kL1dyaG9wSjJuTmQ5L2xy?=
 =?utf-8?B?d2V0WVI4WnVpWldUT1piMGFuYUJIdktnbk50UEtFZnhuNzg5d0pLREVhVEVT?=
 =?utf-8?B?WXBDYjBtWDJNM3ZrT0c5dzlxd0E1TlVuZEoyWXRHVEdkMERsYklrWjRKUDll?=
 =?utf-8?B?SGVGazlYMEp0dTZDWWQ3UlltQ2c2c2FpOVlGWGNHUWZCc3FLTjE1VmtyNWtX?=
 =?utf-8?B?RXF4b1htZEo4WlN6Q2N3aE05NnBQWFpZWkJQcEJGYzZKWGM4S2pQT2pNL3J2?=
 =?utf-8?B?VG1IdW5wNnNRbjVLR3NqQ3dYNGdGNlhiUlRJK0ZzRGVpYStCdGtZaFNqWXMv?=
 =?utf-8?B?c0ljK3UvUXhDQ3Z4QVpyM2RibUUzeFRFYWc3cDNna3JWQ1hET2tUbS9nRzZ0?=
 =?utf-8?B?V3IwdEhHUGd2NnB2eHVOczA3YUVrZ253MTdPd1VDcTh3N3F2T1dLSjY4NTAv?=
 =?utf-8?B?b1RlQmNpcnBZaUlUdE1leDR1aitRK2xxQjRBOERVUitaU2VnZlNDSkl0MkQ2?=
 =?utf-8?B?OTl0dHhGWHN6VUVpd2JwL0VQZ0JLczd1dldCOW0xOU9vT283NzQycnlGOTdr?=
 =?utf-8?B?YXFHZTl3bEcvWGpISGZIczBoRURCOW9FQUkzVVJNRkVlSmNkUWNwVUJ4YWpJ?=
 =?utf-8?B?T0hEU0pSc2JtNGc2MUFaMnUwNzJFZ2pnZS9Ja0RoT2NEb1hJYjlvSnRYOEth?=
 =?utf-8?B?LzdibHA0eEpBa3h0Z2hnWXd4ZHFyTmVCSHJ2TTVkMUZOa1Z3N2tFcHdIcU5s?=
 =?utf-8?B?NVRiZ2s4eHBzVnptRWg4eVkrQjB1L1lRejgwYmFFMHJyT1ZwZk1vcVprNlBB?=
 =?utf-8?B?VkR0RGtFNzNhUDYvL2hqMjJXL1Ivb0Y1V3pTbW9manpod0Vmci9CMHJKSXBK?=
 =?utf-8?B?cXllWmxnRVI0YllkTlUveXp1TmtCR2dDTlNXazNRQ1BvUW5TcU1Ba01WRXNh?=
 =?utf-8?B?M3RxTVBtU3lIb0l3Z0ZSUVBmODB1M1VsaEI3NTg0S29aLzM3bjdmdHZyWVhy?=
 =?utf-8?B?SUJJRnJPM2RYOWZ2NHROL2FDeTBwZUZsRHZKVHJVOFpHRUpXLzNQVUJZRHl4?=
 =?utf-8?B?eDRjZmVYNVlrWmY0NStmUFJ4UzJzZ3VhWC9QekhySDNnN2VKYmVhZWRGRzJm?=
 =?utf-8?B?MjMyUVlOZlNLbnJOTVpEWmxqUUJZWGRJQ0dFL2JWOXFyVmFaWFZYR0k4VUpn?=
 =?utf-8?B?T01icjRKUFZlWU5WWVFwYlBEOFpiUHplaWhHcjJ6Zy9FZC9sQloxTVpwdmRX?=
 =?utf-8?B?UnIyMXdPd2RpRDJRR1MyN1FDUzZsZzl0dUtNZHR5K0JPTm5PdlZPK3J2SlUw?=
 =?utf-8?B?RTM5QzIyS2lIdDcyY2pIUEVIOWUvdnFMelFtNzR0ODdobDF1N3ZiOFBETnNj?=
 =?utf-8?B?OG1zN0RucDMrNVM3aHQrbnNPakcyUjRhUWxXdkszUWhJWW85YXQySktXeWlE?=
 =?utf-8?B?OVhYMlBiZnYvcmFPd00rYSsyLzU3YXZSbnpPU3VwV2lIemVWRm5aZ01RUVRN?=
 =?utf-8?B?blBEdStHQjFOejJSVzN3NTMwZElnWWNzeXVQbGpleThiM1JoUjlvRjBMMElr?=
 =?utf-8?B?VjNXSnpNbkV2TjVOVldsOGoxQXRBRXNNcUxlaHVKelpDR3k1TjdqdmtsZ20v?=
 =?utf-8?B?RW1EcUo3K0FBRm1QOUFzelRrNWtCWXY0d3RlZFdqRGpDdDFueWJ5VlAyYWg0?=
 =?utf-8?B?dklSdVVBVVZxdnRocThqSy9EWFg1TmZyVCsvMHI1ODN1STZKQVUrZzZLcSs1?=
 =?utf-8?B?VnZnSnl0dmt6ckdaUHh6VTJmTVBuWUl1cUc1d2ludHN3MUhhc01naEdRMDlK?=
 =?utf-8?B?SGk3YytUMVozZXdyV1JWOUFIM1h0M01iNU91ODFJbDQ5L0JsNjNhVUtXb05v?=
 =?utf-8?B?dENlQkNuQlY4TUZtQng2Yy83L3IvRkxVeXpzVFJxNEQyYkxOaXBGNTZOa3RF?=
 =?utf-8?B?YUlrLy8wNGhaR2ZlYkVXWlVDT21GRUdGRkNyYllCOTRhTkFWdmo4VXpjVXhX?=
 =?utf-8?B?bS9QMElSeWJCMmlkVnByQ1RrODJnV3ZWL2NJWHovZDRQRGVzSUdVK216bUlt?=
 =?utf-8?B?ZGtCRUdITWVlcjVIaVJ0YTVnb2lVYWdWd3Jaa0FQcG9waFp3WFFkNGRxTDRk?=
 =?utf-8?B?Sm9YVkJxalJ6NVdpZEJUZFJMODZlQVJ2Tk1sazNKMlF1OUMvTDZXRTB6aDYv?=
 =?utf-8?Q?8j09FOHVKx4RuX25Gi3eQAc=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048708c3-9715-43c9-79f9-08db347b5f5a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 19:41:08.9748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drvAkqZ7U/IrGIIL+IaF057dvn6Doi3vPIqOwvb9geGwsyYd1k3CmP9vAaU2+dfp7HXljc6A4fVUjlLjqQw/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4523
X-Proofpoint-GUID: sUCLGTp_Hlz6MQekgGeJsCVzMqRWMJPC
X-Proofpoint-ORIG-GUID: sUCLGTp_Hlz6MQekgGeJsCVzMqRWMJPC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/3/23 1:31 PM, Dave Marchevsky wrote:
> bpf_obj_drop_impl has a void return type. In check_kfunc_call, the "else
> if" which sets kptr_struct_meta for bpf_obj_drop_impl is
> surrounded by a larger if statement which checks btf_type_is_ptr. As a
> result:
> 
>   * The bpf_obj_drop_impl-specific code will never execute
>   * The btf_struct_meta input to bpf_obj_drop is always NULL
>   * bpf_obj_drop_impl will always see a NULL btf_record when called
>     from BPF program, and won't call bpf_obj_free_fields
>   * program-allocated kptrs which have fields that should be cleaned up
>     by bpf_obj_free_fields may instead leak resources
> 
> This patch adds a btf_type_is_void branch to the larger if and moves
> special handling for bpf_obj_drop_impl there, fixing the issue.
> 
> Fixes: ac9f06050a35 ("bpf: Introduce bpf_obj_drop")
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> I can send a version of this patch which applies on bpf-next as well,
> but think this makes sense in bpf as the issue exists there too.

Alexei and I talked offline, I'll send bpf-next version of this
shortly. This can be ignored. 
