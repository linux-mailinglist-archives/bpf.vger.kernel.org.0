Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A38851F263
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 03:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbiEIBbL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 May 2022 21:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiEIA7b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 May 2022 20:59:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4443CB69
        for <bpf@vger.kernel.org>; Sun,  8 May 2022 17:55:37 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 248Lji9s004558;
        Sun, 8 May 2022 17:55:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=eJA9SwIE99KyR5wcCfigD9ernYITI4zKx+O16lkbVsY=;
 b=YjKN4cFvRg162XXPRn5sAM/vnHY2eptEcjftelEZ7zRdkpnzDcB4kU9F26hHEbqRvLQ6
 05f7mH0HfGfoOsPAw12lb+kDzCyMs7+pHR6j2Wq6R794K8/3eDdTF6pJedgapfbYOLjx
 drz/Rob5PFBzHUosTnYejCAjk6Hli5SB5DI= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fwmtje1jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 08 May 2022 17:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX5H/3H2Y5M7lbe1antKjPvjFB3YkLlgtml3MnvePiMg0NuQvo/SKgkv2t1v4AePhl1wm5ztAF+yuGGsRj0ZeQMIvVzBPa7sM0+oLeZsFe1h5TKc3KSkV0gCRgCVvBRjSvrxN66lVwZWHBRrM+ZTXRu+ZhMbotPCAUeHpBLU5WZIJUZ59WO+9m21WQW5mTP7Vt+5iCf7AaBLLNQlJnD7ahNN3WjeEhGTf2kOwMzg3dmzEo/85YddX3b3/EuIVBq/ksvDcdYkCg9FEE+IDLL5ZK59lnXAxh/8Gg/UY98taeJKoQvh1zALArVxMsaERr3x9OeMj14D3Qg6mw9g4eGk6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJA9SwIE99KyR5wcCfigD9ernYITI4zKx+O16lkbVsY=;
 b=Hda7Ur3QS9Gi5LHtAca7o05D1hsRvjxqN6oMK54ZVtoCXk5kb+GL4Wcf/aU/rkedZVAlAd7rDfniR/33Ld/V7th72RhgvU2C4CGu7CSWdXgABmxE5rE7kCUFmwfIeP0XHFpQjVan19GO3hnlClxh89pibRdZEAGQnk/12IKp0IBeJ7jQUqJ/jK3JPbneA07dJwgSeUYi5KZ0mhSLuAd8FMDJaR+Zef9JSVU+SMuEUhOk5yvCFZby6sS4Ka11/yufEv+fj7WKE6e2gf/luY8KWJt+bFUy4GnZ5RDNatz63Bk3d0A+6P+vLmnAH/y7cU/WNe4TkMi/U4Mnol6dDvOi/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB2832.namprd15.prod.outlook.com (2603:10b6:208:125::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 00:55:21 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::108d:108:5da8:4acb%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 00:55:21 +0000
Message-ID: <8572184e-7ba7-d16e-8823-0fbc4abac627@fb.com>
Date:   Sun, 8 May 2022 20:55:18 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next 03/12] libbpf: Fix an error in 64bit relocation
 value computation
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190002.2576452-1-yhs@fb.com>
 <20220501190017.2577688-1-yhs@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220501190017.2577688-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::8) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9d83695-59be-4fca-5d96-08da315697a3
X-MS-TrafficTypeDiagnostic: MN2PR15MB2832:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2832D63451CB37F0DE4BECCAA0C69@MN2PR15MB2832.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F3sBTJAlYR7hnc85i32NeJ1pE5OPjybq+ZUaaGbW+aCB30ClfL+rL0nqIH7Jq65ck2fEhqY5/vBsMcDBlExyoXwdEMOuXhyERJA3BRDE70YYjeMn5+yCuv59fuOeMdIKJfit1kSq8B1zcpLX3sg3Qrntc4ta4TzQMtyEemSnCPPMKVRzF1Jl5b31r/UExlDISbvhssZPvznD0RDxqtM/5ZcI8IGPRgrrAD0fdm5hpJhxUBOwSGST7q1bdS9PlczO90TH90k+1LHGj3HPytYwYvr8faPMrkzE4QrUQcxo3q7HYJSfFI/e+rR7ePgaJ9ygy+DJ38x0zB2KGtGSUu+HCw3vvSlXBysyYcroo1Sxl0Ubn0z5q1eGuAMnIWKQGCTyix6lSPxUb8zvNSRKUMHQo14ALtP12ez5950eZh4+hp5L2C6Zyv1hOkmm+EordktJ2F0dmXHID5hbjneQ47v5NP5GRwcVhGuzGDL7+OYCKqSHQ3dO7E1YV//MyYMzJYk/lRUvz4NihNCT0X/dzTRjhxOnrfuKFAVvofDuY4SU+bgwmdG6urniWlhftNgFkhMia0hmIM4RzcAd/AfFUxzHof+5vLWGEbr5BtwXSw1vwUA8tbGMwXP452l3hwVM0vqITqLsb0gWWeDZx65WEjzjwepJbu33urUgGQ2ZYxG0qYqNVmgzqSFunqUxvbyY72YxpWSBWX1eijKfoeeIW/9z3seUMHeBvwl3Vb4vcxLh3jxcC6avbCe8xF1TbOucROfR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(4744005)(36756003)(31696002)(8936002)(31686004)(38100700002)(5660300002)(83380400001)(508600001)(186003)(4326008)(66556008)(66476007)(2616005)(8676002)(66946007)(54906003)(316002)(53546011)(6506007)(86362001)(6666004)(6512007)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGMzNlFZd204T0tsRjkxY1g0Z3NMYXdlMzVrTTMyL0szQ2xpcGVzay84U29i?=
 =?utf-8?B?aGk0elpRVHczYmcvcnVPVXVkQTIzTzJ2V0RwTGRTb2J5NTM3enA2WmZ4bkdT?=
 =?utf-8?B?SWt2YTNQcmpOVlpFRTZnL0lLdTUzZER5S21QUFZMMmlyeTc4a05MYTdoL0tr?=
 =?utf-8?B?UDB1cHRLKytXSEdQckFSMStHc1RNaGErREtocnE2T1lraERBYzcycHBlRDB4?=
 =?utf-8?B?R0poOTI4NEdsVG5Ka1o0TWhPeXRGZy95UWZhQUo3ZVRjVXdaSG41TllRTzZu?=
 =?utf-8?B?SE9RMmxudUZZNzVmMjRIc0ZsVFgzNCtiVW8rTXNNbHo5MTc2alJCNzI2cDFX?=
 =?utf-8?B?T0hIaEdNdjBMT1d2SkZOY3FTZFVzb3pqUE0vWjBuUk4vQ2xsaEJTTVFDZzJE?=
 =?utf-8?B?QXlCc3JwY0QwTVA3R2tQbUFrZlZqb3VhNVRIaC9xNGZTV3dpZVhiMTJhMEww?=
 =?utf-8?B?UmdiaGM3ZmV3cnFDaXNiSXNaVVRWbkJrdTJrNEJpVll5L3NXdzlxMGs0RzFh?=
 =?utf-8?B?RHNTakdZM1ZzZnhQZkdhcXIvQlFId3VzQ28xUzhyd0pab2VTcUdVZG1wTVdr?=
 =?utf-8?B?WGJRQnJZWDNDYVpramUzVGllSE96WS81bFYrdXNpN0orZTdYaTRPZFRIODFt?=
 =?utf-8?B?MmgrUGxMT1EvSm1IQXkzTGU3QUgweTY5NGpZRWc5MzBaemxhTEZ5NFBoODUy?=
 =?utf-8?B?eS9LYjlnWHVjK2RyWG8ySE5SdEtQQXQ5NXE0RE5KTWxSQmZGbGxYSlFrUUcz?=
 =?utf-8?B?Uis5N2ZzdFU2U2QrTzUzTTNMd1U4dkFKV3o5ZW5WOWJmTnFCTVhGTCtQYnNx?=
 =?utf-8?B?K3RhT2o0aDJNSVFENjhrR2VldU9yS2hBYW5QenBOa0NtUG1hREd0dHZ5ZTU1?=
 =?utf-8?B?emQ2SXE0Vm1pdlFIWVNtS0dGV1M1bUtoTUJ1ektESkE3UTQ3c1AvWFp6cTlq?=
 =?utf-8?B?VVhlTm1mVXRZdEtodEdUclhEbCt2RXhFK1luUDJJQU55d1ZlL2s3c1M5ODVR?=
 =?utf-8?B?ekI2S05kSFNzSkZuRndWbEo2SWZOYmNVcFhqbyt3NE1ZMUlXemI4dGcwMXln?=
 =?utf-8?B?Rktka0Y0WVdMUXBhSk1nUXB0THZ3WWRyYnZZZmc0b0oybCtxc29STmM5SGFU?=
 =?utf-8?B?MHlvVVAzVnRvMTVmL3JrcHcwOXZEMWpqejdoS0NrLzNxODZGbW5najV6Q0t3?=
 =?utf-8?B?SEphVkYzZHhsZ1ZqbEROSWQ5dW4zam1PcmRXWFZVK252ZU5obDRZdHQ2OTAv?=
 =?utf-8?B?Ri9OaTNMWElkNlllVU16RTZmaUl6VWFlQUMzeGZRSWM2ZGt0ckNUWE1lU3FG?=
 =?utf-8?B?QVArOVlMQUVBRWgrVHBYUkpoYVc5NExBb1QrZ0lRRVBhcUU4ZGZLSkVLVGp4?=
 =?utf-8?B?WmZsWk0vWmszbVp5bkV1VUt0WFc4QzlocTBVdTF1Znc2VUhjb3NZT0V2WklE?=
 =?utf-8?B?R0VBR252SjVyN2hOMGRZT1RIdXFQRFBZTXlhaGRNUk1FdkNZamplVlpBY0Vy?=
 =?utf-8?B?dTV1VFErcUFpOCtpR0kwN3QxUld1ZEI5M0Jjcm5nb0FwM2pVV0E5RkhPbjJG?=
 =?utf-8?B?dXNEQzBvZ2s3RGtFVWYrQlhhV0ZyNnpPbldTR2lTTmRGOEJEejkyNlEvbU9a?=
 =?utf-8?B?WnBrSEh5bzJwa3NZQmlSSHNuQWJhanJqd0I1RGYwanYvRFEyQ3Bkd3NCWTBQ?=
 =?utf-8?B?TklaNjdlekFQVFFBTEJLRlI1cFNwQ1NXZ2FuaCt1ajMrMUJtVGpCei9wTXI2?=
 =?utf-8?B?dHNHTEtEMHlBMWVRT1Znenl5Y3NJZlpUUzRSL1V2dVptOTNFTThieUN3eXFv?=
 =?utf-8?B?UzkxTjlJWUhIai9RQXdZMmszOGtGdGJDb3AzZ1V3dXJCWC94amFMZjg2cUs5?=
 =?utf-8?B?cFJPdjRxeFJ6dENyTFpyYjJWMnZvZ2tVSnl4Z0plR2swY2FnSFZ4Zm4wWXBP?=
 =?utf-8?B?ZUh4Tkt5QzBhdDc5eWtjK1BBdmpETWR1dThxaHlhRGxHOFMrSnRCY0d0bWZQ?=
 =?utf-8?B?WjVkYXlVSENiVnV5OUZWbnlkVytIeFBRRUdPOUx2UjlYU3pZbW1WNmY4NTFk?=
 =?utf-8?B?NzV0SkJZS3IwZGJRb2EyUE1CTk0xNEhGRklkd1llZU1rWlpaOTR5WlNQS3Ux?=
 =?utf-8?B?NjN5NlZzYWd6aDlaOWdFR2FvZHFGNXE3Q0FXd0Ruakt1bC9tZ0xjc0o3MnBr?=
 =?utf-8?B?TGZmaFEzYUg1OGFXdXZJNzdDUVNGRGR4SUJqTHNmc1pzdVBuV2RMcFpvbDVa?=
 =?utf-8?B?c01GNVB3L2Q0S0xJOUNJcloyb0g1aVVtSXZHa1FMWEM0K1VmMXRMVitueFlR?=
 =?utf-8?B?a1lxWW5vUk1iUDFlV05sLzhLZEwrKzBTTGo3OHR2d1JaclM0NUoyVWJhR2tY?=
 =?utf-8?Q?UjB6ooOivhXz+ybWOH282OBeSjnaZ560MbHyn?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9d83695-59be-4fca-5d96-08da315697a3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 00:55:20.8923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6Kp/jouD+LrUa3u2mQ2fKmYYYQlhAMRblky8Xqxxx008TDySeliwccOkgVyxAxmDKXogyNR7lYCePUC+Jp9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2832
X-Proofpoint-GUID: JAzkGGltkVIBQV_teRbOaz17AQfPgaPi
X-Proofpoint-ORIG-GUID: JAzkGGltkVIBQV_teRbOaz17AQfPgaPi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_09,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/1/22 3:00 PM, Yonghong Song wrote:   
> Currently, the 64bit relocation value in the instruction
> is computed as follows:
>   __u64 imm = insn[0].imm + ((__u64)insn[1].imm << 32)
> 
> Suppose insn[0].imm = -1 (0xffffffff) and insn[1].imm = 1.
> With the above computation, insn[0].imm will first sign-extend
> to 64bit -1 (0xffffffffFFFFFFFF) and then add 0x1FFFFFFFF,
> producing incorrect value 0xFFFFFFFF. The correct value
> should be 0x1FFFFFFFF.
> 
> Changing insn[0].imm to __u32 first will prevent 64bit sign
> extension and fix the issue.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/relo_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

