Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D925F47C35F
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 16:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhLUPyE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 10:54:04 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11882 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229449AbhLUPyE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Dec 2021 10:54:04 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BL9ptEA011609;
        Tue, 21 Dec 2021 07:54:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tkILQ4ZFWkGkdfTPBkmT0Os8HfmxWzNWs2yW0nCbZqw=;
 b=U2fTVoGujbJsohid6uBIaWYABq3Hd6E8oCnqNL1YCZRLCSNw/fcVDOn+gTA7vSttOLn8
 jRmEMBQYLlGJzVH0xPItssLFXjoztiOGs6EveoXP3NnUmV7bPHsYpwC6QaNLngtHJZc7
 jEqvjgHzaVtkIT8PLE8gRzRnAunIr4G+4Xc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d3cmhtcka-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Dec 2021 07:54:00 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 07:54:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls2P/y4g0c+Js5EbNtciPqSBEDdNUYRI8D5kiFsBHDv68sWn7zXFUf9qogONPkWxa8YFTiJpQwCgqj6cggiji4rljsY24upxb21pSEm9N0fUgmU/H4Liz+/8yFUXlvO1n3UQtUGcLBPfXu6i6FgWS0djxlWE4LdfSW+VausbNqPvCZDJPM0e0VgMT1LIwYC+XOKFDViTJZsZcs9sEnJTfSgekY4hpeTVPMSycuSQYu2qsW9sUVy6/JHujxo8UjXEoRuoXGWJ2YiAn8CyOScHmapnjk2iUqGfhV3rXvBW+6dqX8+d3WMGsqylspOg+uCARY2bwkCSN9rtm8r/CbW+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkILQ4ZFWkGkdfTPBkmT0Os8HfmxWzNWs2yW0nCbZqw=;
 b=Ah+vyDNvZLJt7PXuCvU/m/1SaB2aQCYifzjUZ1CfCOi/tZzdja1So8RRfhtvMGL7Og1ma1+fIKCuq69zLnF7wulrimccyxTD8p25IT+iqfSrwl8JfGfI4xCHecoiQSILK6fRcM4YUVKRVt0wbqq3SmCF/mu8HwMRTFV9WRa+SzVyf1XjcIH+Vvw0C86BIm6t/cqmFnYYlnQz5WtXwMB8V+3DqcCt51h7H+3QFzi1YN5zvBitLjPTkPZsA6MWc2OJUTudgsLTSXmGTFMnoi33WvCziJl1U8fnbWzrII0GY+QnaJLjDHOc9kDyn783GdrVQaKAt98C2Rc1fBph16kXnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4738.namprd15.prod.outlook.com (2603:10b6:806:19d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 15:53:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 15:53:54 +0000
Message-ID: <5e8cf0c3-1d76-848a-cad0-f39d0167e347@fb.com>
Date:   Tue, 21 Dec 2021 07:53:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add
 BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros
Content-Language: en-US
To:     Hengqi Chen <hengqi.chen@gmail.com>, <bpf@vger.kernel.org>,
        <andrii@kernel.org>
References: <20211221055312.3371414-1-hengqi.chen@gmail.com>
 <20211221055312.3371414-2-hengqi.chen@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211221055312.3371414-2-hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR04CA0367.namprd04.prod.outlook.com
 (2603:10b6:303:81::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 816a876a-4c9c-4941-7288-08d9c49a1740
X-MS-TrafficTypeDiagnostic: SA1PR15MB4738:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4738FFE1BCCE9A9F3D33616BD37C9@SA1PR15MB4738.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zmYw63GYNpda0iz6BDEW6qS7fEncnnKJfIRJBltrvOIVsyjMFU1bVj50M5lyISYF/MPenftNhA6apnIKmmy5d50CvyMlPx+AghTfRb9XG3ODI1YGDcNEp0z5jsTjgh08KImqkso/LuCtognYD33/+0/SDE3KVW+ppWm8N5Gs2oa8pyuxugBDf4/+idqd6aPXD+8aW7KOfmOsQeXQiAuFFU0qfMVlWLnJAh31dwgmXn4fguSW4BV+6GbVB+Or5mPOgtVG9gGdxCGxtVVwnzEnuSSYSal70W7j8zhLl/z8qxd1S6nFTugR04Ssej4OTOCEu4Od1XnFl0Kw7AjimV/1TYkzx+JqaLZhzgkT6hO4NkIQkYsaSRxNpiWqhD2Zwb8aYN3JFoM+lWPoclo+GuYRoaAzZQzRs528oF+H/YKW1medIaWP4PudJdljAVIpREHk1obczo/7vVdhlLtw+67Sv0AsWREgOXBupAvJuDlDVKlxEibu3DOKBU3aFk6oG83ZDr+vDw9ajbgJW9r5hAnl6nr8jkJ8+ts1oRzU6wN1epbJl0qvkURjCLGJcyeIBUcmpDybRauFKJd+v/bjXC8QmpGLdjF4TqycXEfxXHuJtoEP7HvD3i8Nr+6J+f6pkrHlCuBLcmg6YXDuIuaKBm5UPrBJ1/qj8z2JWggd7xONXCH+FL3QR456q8GAzVUH6BJu7+yeOWJpnMBAheb66dlM8LTinV16fWo1NQpG4WQin2O3Io+UTaCvxMvhaMLKXwcuwTQmlrkNiTYk8fXcp/Hwa8wK+MHrJaQTF8HQ9VsV4K2pxjPB4Pxpng7bJW5Hwl/dCKWjjKMzA5lfEVSJuF5RXqsNY+VfcchYFxnIoHr3ek=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(52116002)(38100700002)(316002)(45080400002)(6512007)(66946007)(36756003)(2906002)(966005)(8676002)(186003)(6486002)(5660300002)(6506007)(53546011)(31686004)(2616005)(86362001)(6666004)(83380400001)(31696002)(66476007)(66556008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzEvSWh0bGN4NjJQQm1oN3p6dHl3TkJkbFpPVXozZmNIWnB0dGJ0L2JhbHpE?=
 =?utf-8?B?SGc2RkZhWk15N2lveUtpeHVtbEwwMEtSVmkvR3gya2VCbWZDem5xOEJKeFpJ?=
 =?utf-8?B?aWZXL1dwcFF4UDYxbFMxZk1wZ2VPVEZBaVcwNjdwT2ZtS1psSVozWVc1dC9q?=
 =?utf-8?B?R3AyS0NoQTRLQVMxWXN5VE9QUjdtdHNSSzlSNW1ER05PeklITGJPRW02MDhy?=
 =?utf-8?B?MER4VCtNR2k4RVMyYk9LcmdTR25DMlBhbkRuMCtsTUl0blV1b0U3SHZyUjBr?=
 =?utf-8?B?YW1qTS96blZGSlVPdmMxY1o0amV4NmxCajFhWEdBcTFYZExjTWdObXNLUU9T?=
 =?utf-8?B?OGYxNi9oRnFrMGZWTTlpSFRGNWw2cE5wZE9kdW5qcXI2VG5JVExoZzdqczE1?=
 =?utf-8?B?K0dsMkdEQkE1eUxFbURYVHB0a3hrOFdQd2VhbWYrbDR1NmxLMTR3ckFIZGd2?=
 =?utf-8?B?QTVIN3VPRGtueWhMMWdEQm1HV2hFbnBOSysvZkljMHVkcVBJZ2JmUHRnTnJ6?=
 =?utf-8?B?aWRyajI5NU50YjAycHVOMEIrK21paXBhQ0ptUHJqWEVGYkNiTnNlVG02ZDhV?=
 =?utf-8?B?TUdHRVNxdDBaSytrci9pdEV1TERPakhBRHkzUkRNdGMwZjFzems3YmNLRGoz?=
 =?utf-8?B?VGlCN1ZDTHl0Tno1eXZFUm5TU29RL2ZhSy9FSzA5L2MzcElIalZ6RFExNzJo?=
 =?utf-8?B?SVo0QTBPMnN3SXhsdVVpb1pRd1MyNTlKczBvYnl2aEY5OGFLb3NwZGpJdGd5?=
 =?utf-8?B?TS9TanI2U2RLbklFYWZOU0FSemZFR0daQStDa29wQ21Jb1c3MWpMaE9udlB2?=
 =?utf-8?B?RTI2aDFacU5Delk5YnZQSml0UCsyNWp5UnU3OWZTMW5sK3FWaDFEMFczaEZJ?=
 =?utf-8?B?RXViejRBZ0NHMXZUcUpwcHUwTkNFUTNYUGxOekV3T01UTnNCcHZYSTJEQ2E0?=
 =?utf-8?B?eEtucWVjZ0ZPK0xpc3NJM3ZTUnZsREFDeW03WEh4MjU2elM5cVg3eTBtSG1M?=
 =?utf-8?B?T1RONGVVcU1TbUw1QU53aHNxSTMvMmUrY2RLcklUNFlRTG5jMmJHeGFqQ0J4?=
 =?utf-8?B?KzJJcHFtaUFFN0NnazhGWDl0N0VOMzFFWGtGMXA1bjRnbXMzNW9xVllBalJU?=
 =?utf-8?B?WWlMaTh0VmlwcGtwTS9PUlJJRzkrZndmejVlL25nUXZ5MXE3NkY3cnhoZkhY?=
 =?utf-8?B?ZVNDWlhBejRrdXdTS2ZCOHNxVnI4MUNLRFoxYkpJQnhZTHNxU1ZTSW1DQXBB?=
 =?utf-8?B?NHk4ZFh2T0JCVnRQZTc2VlFJUEoxaXdueGJ4bE8vVnM4RjN4TkwzUlIxODFi?=
 =?utf-8?B?R3FvZWVwZCtvWVJBbnRNSG1yQzdJSjNnWU9mekJPUU5uS21xMXdZQ3MwVVBQ?=
 =?utf-8?B?U1ppRVRsNEtUbi9ma3FJcm9YSk1mQUFhdEQ0OXBhc2lOM3pheHdMSkZkZUFu?=
 =?utf-8?B?VVNhNy92YzNFWksvb2dzdTFBdGIyTEZTMkp2dnRmZlV0UXMyekEyR3hwSkFR?=
 =?utf-8?B?R2xZYkFjckNEaEJuQU82Wm9lY2N5YmhhUDg3TVlqMWgwR0xNdVBrKy8vTzRY?=
 =?utf-8?B?SzJ3dExWMVhDNTV1R3B0ZW9BZFlLUmlxOUlqYTRJUzc0RHkrbjcyLzkwQnI0?=
 =?utf-8?B?N215NEcxdWhnd1Z4VlN4NVlmN0VWdDQ3WUd4WnZtUGpKQ05jejNTKzMwK1du?=
 =?utf-8?B?dkxJVVFTbzFYdE1zWFR0dDVFd04vaytXTW5IUlkrWXV1TGkxdDVmWE5YNnpU?=
 =?utf-8?B?MmFIbDVRWUhNVVk1RExIaWh0WjhhRkY5ZDJqbUp2RlpGeHk5VElhUE9YK1FJ?=
 =?utf-8?B?TmFYdlgxNDFSamVFZnN6ZkozQXIvTHRIVEJsSm1NMDRNZFNUNnFENEVHZ3ls?=
 =?utf-8?B?TFd2WXZTNjMrYkY2d3FOZ2o4SncvT2lVMXBnMHhWT0F3dlZUVUpvVjN1a3Er?=
 =?utf-8?B?cTFiZFRJcGNsLy8rTGtqdzVpOFdUTm5zY0I2UVpTb01yUXU0K21zUktXWHc5?=
 =?utf-8?B?eVpQaUdwaW4zT0UxUXRDTE5MMU9sUDJ0Z3NLaUkzcGZwS3QyQXFwUDdha2dw?=
 =?utf-8?B?OXNDbWJyT3BCeG5uYzdyVjBXNXV5Yzl6VnNkQlJLVktpSXdDbTd3aGZiczRw?=
 =?utf-8?Q?zJQVawu3V+YCnJyPfPIg9cDMK?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 816a876a-4c9c-4941-7288-08d9c49a1740
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 15:53:54.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VVc4pSXspjb3uEUWXhm2X+zorco/SY7WWps3qv6iPggVEidrmlXJkNkORG23HeO3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4738
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: SGAXC4h-tOQE0y4qrxPQKO0RylL9T-z6
X-Proofpoint-GUID: SGAXC4h-tOQE0y4qrxPQKO0RylL9T-z6
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_04,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112210077
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/20/21 9:53 PM, Hengqi Chen wrote:
> Add syscall-specific variants of BPF_KPROBE/BPF_KRETPROBE named
> BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL ([0]). These new macros
> hide the underlying way of getting syscall input arguments and
> return values. With these new macros, the following code:
> 
>      SEC("kprobe/__x64_sys_close")
>      int BPF_KPROBE(do_sys_close, struct pt_regs *regs)
>      {
>          int fd;
> 
>          fd = PT_REGS_PARM1_CORE(regs);
>          /* do something with fd */
>      }
> 
> can be written as:
> 
>      SEC("kprobe/__x64_sys_close")
>      int BPF_KPROBE_SYSCALL(do_sys_close, int fd)
>      {
>          /* do something with fd */
>      }
> 
>    [0] Closes: https://github.com/libbpf/libbpf/issues/425
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   tools/lib/bpf/bpf_tracing.h | 45 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index db05a5937105..eb4b567e443f 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -489,4 +489,49 @@ typeof(name(0)) name(struct pt_regs *ctx)				    \
>   }									    \
>   static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
> 
> +#define ___bpf_syscall_args0() ctx, regs
> +#define ___bpf_syscall_args1(x) \
> +	___bpf_syscall_args0(), (void *)PT_REGS_PARM1_CORE(regs)
> +#define ___bpf_syscall_args2(x, args...) \
> +	___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_CORE(regs)
> +#define ___bpf_syscall_args3(x, args...) \
> +	___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_CORE(regs)
> +#define ___bpf_syscall_args4(x, args...) \
> +	___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_CORE(regs)

We probably need to use a syscall variant of PT_REGS_PARAM4 here, see
https://lore.kernel.org/bpf/TYCPR01MB59360988D96E23FBA97DAE0AF57C9@TYCPR01MB5936.jpnprd01.prod.outlook.com/

> +#define ___bpf_syscall_args5(x, args...) \
> +	___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_CORE(regs)
> +#define ___bpf_syscall_args(args...) \
> +	___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
> +
> +/*
> + * BPF_KPROBE_SYSCALL is a variant of BPF_KPROBE, which is intended for
> + * tracing syscall functions. It hides the underlying platform-specific
> + * low-level way of getting syscall input arguments from struct pt_regs, and
> + * provides a familiar typed and named function arguments syntax and
> + * semantics of accessing syscall input paremeters.
> + *
> + * Original struct pt_regs* context is preserved as 'ctx' argument. This might
> + * be necessary when using BPF helpers like bpf_perf_event_output().
> + */
> +#define BPF_KPROBE_SYSCALL(name, args...)				    \
> +name(struct pt_regs *ctx);						    \
> +static __attribute__((always_inline)) typeof(name(0))			    \
> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args);		    \
> +typeof(name(0)) name(struct pt_regs *ctx)				    \
> +{									    \
> +	_Pragma("GCC diagnostic push")					    \
> +	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")		    \
> +	struct pt_regs *regs = PT_REGS_PARM1(ctx);			    \
> +	return ____##name(___bpf_syscall_args(args));			    \
> +	_Pragma("GCC diagnostic pop")					    \
> +}									    \
> +static __attribute__((always_inline)) typeof(name(0))			    \
> +____##name(struct pt_regs *ctx, struct pt_regs *regs, ##args)
> +
> +/*
> + * BPF_KRETPROBE_SYSCALL is just an alias to BPF_KRETPROBE,
> + * it provides optional return value (in addition to `struct pt_regs *ctx`)
> + */
> +#define BPF_KRETPROBE_SYSCALL BPF_KRETPROBE
> +
>   #endif
> --
> 2.30.2
