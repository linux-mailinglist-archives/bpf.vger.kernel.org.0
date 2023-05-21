Return-Path: <bpf+bounces-993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F1D70AC39
	for <lists+bpf@lfdr.de>; Sun, 21 May 2023 05:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3FEA1C2096A
	for <lists+bpf@lfdr.de>; Sun, 21 May 2023 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D14A29;
	Sun, 21 May 2023 03:51:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CB4803
	for <bpf@vger.kernel.org>; Sun, 21 May 2023 03:51:32 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F90F1;
	Sat, 20 May 2023 20:51:31 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34KIeb6R010373;
	Sat, 20 May 2023 20:51:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CE4hN+hXmz8jpY4/daAOyALRJ616NdUoC7DmeFLx7R4=;
 b=f+QtxKdPkQa3UVfRCcnzAvENWBWcQdNVcbvMEQlt2qW72J27N+Y2LryawX+WAw3pgb1B
 boiL7ka9HF9OqwPMjFBwl4HoKoeoGB7KeY6l8QXzu2ggOOmeMNyTVx+0M4C9gCrhdb31
 +OkK0ILhCQfGTPx2A4kHxidvguUI5MJ9vx6Vfy/mnpINNK5Dm8XR1SnadcHbSeVAFIau
 6NPq3FLvUOFv2FGguJOsubrTTQR2FIQx7iBK9ZGeHr/qo5lNmpuocYBARATdFh4KYjwR
 h7hQOgfubKwbqEI8Bcel9WfcjwmhYPlwrsnk06oZndFDSMPjXPSLwCBkP99YwRe1DQR7 sg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qpt8jm3a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 May 2023 20:51:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lil9USO0yUyAVOCgBjAc1QcVizxw0bmTRZr5U2DfEFeLMhCQfoXOwqfqVv4Uk9SXOJkCbaWbxBbdar9kHwUujklz2MfiV3/4HB1UeuzUyE7xepnRveGYMJp5ELvTon2+bpK/Qa0BkvtnaCUska9ixKqUfvetwkYCJ4DGmlaCV7HwZoYwIfWueo0Mha50aQSna9uWt7kcjPElSFZedevnAIZGaRVJgevAlzaRyVKx+VdeR5j+csstCBQBtxOeRDcaHIyZYYhwnzTyG1EJFaSNW3VEqS9DX6jyFOK5Y/z6QM/ADtqbogBv12286fvDB00IVXnMoXGnkH+jKwnv/UBTIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CE4hN+hXmz8jpY4/daAOyALRJ616NdUoC7DmeFLx7R4=;
 b=JE7ZMWk79fj5haFpL43+BmgECGO6usADUm1uylqoaWfbBPSNBsJ1OGLwWLA5CWapED/8sEGy3qAWVrGb9UMuAHrs13Dpbb9kQkwBCPgOTdss43WqIirnnkbdqhihh/nVgMWlSZTjW45wETa+hmVoc1LdN+58JfVu70oePyqpSkB3YCQZ4zuNspyfe4XjmERpoDjjimeaa6ZaTyf1AQANQSreD5rvRUcTKXcLf7rkJc4hmycofwulmfdp3upHT6zxhkskgeZqX6vbkVFQ+OMbiMxxxLJ5cRAj7Jg7WBHkJGPrUZ9odXL+F8KL4UG1RqTevxFgSiIM8FzUZkz5Lx45wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3912.namprd15.prod.outlook.com (2603:10b6:5:2ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Sun, 21 May
 2023 03:51:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.027; Sun, 21 May 2023
 03:51:23 +0000
Message-ID: <bdef7a0f-5806-548f-f7b4-4644b4f2f56a@meta.com>
Date: Sat, 20 May 2023 20:51:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH] block: introduce block_io_start/block_io_done tracepoints
Content-Language: en-US
To: Hengqi Chen <hengqi.chen@gmail.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org,
        bpf@vger.kernel.org, Francis Laniel <flaniel@linux.microsoft.com>
References: <20230520084057.1467003-1-hengqi.chen@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230520084057.1467003-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR01CA0043.prod.exchangelabs.com (2603:10b6:a03:94::20)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3912:EE_
X-MS-Office365-Filtering-Correlation-Id: e3614a55-1655-4ab5-5052-08db59aea563
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	v8jMK/K/YTWOfxFj9uMVfV6BzlMCq/uplTYq/SULBo4U/xs84BkvEe2hVjOBFeYPKB22E7KW/snm9q3RWdXIi0w7aPXY/nHs/GlM5hWIuNk4vfg320X1wNti+BSdE2Vi0cpa/rVUd2hXQsIVsJEsSWWi02WOfPtbYYHPJcopxsSHGjWpbQYZpcdUaVB+JspgMc2TNKAk4NQ69wXRL+/qVcqTwe47aGo5sej0Yi9qpQ9lgCtb95KVfAHQUS3rp13JCjykNYyUgC8SQamGmeL/9twQbE2vgoZRbPoOSN2ehfnfMVHlplM5WX16yrSid3yTesh+oz/n7xtXtuCDKva/sDRZNegdGfMO1NjbEw4rCNtS2vDWDSohqOaHA73+s8U8Po5Wu86pzTx0CfKQiEz6x3S9TjTSgf8mFYcX85ppkJSW8A2HAofjVMhzxbKqY5K62Z9V1KjjncYHSD27LmQsBSyOCJeqezy/+gHb4d8TwipAcl8If+4gKqD3bqA8H5CxT+O8dtokyYMcipn+ib7QoLvkLKwsdO61xlozsDacUIq4ruGJOaw9OfsDawSL/oxmSpvY1HXm9dj+OijtWPpey7DQ6vZoorRZFoA5ubJFjTvs3AZdA7P0JVn60TjswzCvhz1O5wUaEEBNc6qJSyjfqdcrwW9cYGZLDM5EUO2R9LcM360PIwYAUhvegUXHR6Wu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(8936002)(8676002)(5660300002)(83380400001)(53546011)(186003)(6512007)(6506007)(2616005)(31696002)(86362001)(38100700002)(41300700001)(6666004)(6486002)(478600001)(966005)(66476007)(66556008)(66946007)(4326008)(316002)(36756003)(4744005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RmREVklGeE9BZDkrbDFYMGZxMTIxNkE0WGhSRFRWb1hFbDRGcFZHR0twV2kz?=
 =?utf-8?B?N1d1aHVjM0tYY295M1kya29GdW1pQWFxejg0M2ptSmlqNjJaL2dkSldmRE1y?=
 =?utf-8?B?d25ic1FCTmpYT3BDS0NucExybmF1MFlvL2g4ckpiUG9MaG1rV3JJQk1iWUdB?=
 =?utf-8?B?ZXB1M3hnNGIxSVFSY0tYZjYxNlJPZU53dWdBOEZyVi82NnUycER6cnkwR2Fk?=
 =?utf-8?B?RVNNd1pPS0xRR2EyaEtzUjM1YkdkUGdSSGQ3TVRwMDhHWEEzaE1IRW50Q05W?=
 =?utf-8?B?RGptWHBEMlR5RHBrSlN3Y1M0Z09Pcm1XNzdCTVp5UFp3TWx6Zk52dEFvdGZQ?=
 =?utf-8?B?a1c3SEZ0RHhld2s2bG5Ebm5GQ3RHKzdLVHRadnpVZys2dW9zaU9SQjhSR0JF?=
 =?utf-8?B?M0xIQjFtZytjbXNEVGJEYzRqSytrVGJpejc2dm52WFdjWUFTNUNDb25OanFO?=
 =?utf-8?B?L3haVnpTV21pOFVUUFhnZjFMVjlUdkJHaThBVTVMWnJPVjkrQUhaMTYxcU9a?=
 =?utf-8?B?WHpHWTF2M2hGdkpjQUtpK25tNFNvVnkwTjlkNUV6dG11KzgzNlFNZjZKS3Bu?=
 =?utf-8?B?YzFuWlpBQ2FQWUQveHU4M0xVc3pKc2xreFgxdmdpTVJabmVtNU4zRjdsNmxy?=
 =?utf-8?B?bEhZSUNvc3pCMk11cmFLOVZJRmEvd2hKQVlJRWxXNVFvanZrZm82YlJIUFFC?=
 =?utf-8?B?OW9LejZDVEVndGUrMzdJTllnUXl5SW9ENWx5K21JVmJxRm9BS0N6cXJBMWZI?=
 =?utf-8?B?YUVYN255TzR0cVFjcG9JVVdGOFVlaDhQTDlBSisyZ25nYitqK25aQXkrZU1E?=
 =?utf-8?B?S05Eb214ZmpTZ2tmb0FHY3JwNThPT3dPQWZPNFdnRzExSi9tU3FPZ0FpWSsw?=
 =?utf-8?B?YXRNMS9tRVFaZk9wbVlLUmlJYUxzdzZHQk4vL0R1UGRZeVNUc3VpdDhiZ2tU?=
 =?utf-8?B?YUIrNVNuakFkTlh6Y0FUaTNkTEQxL2I0ck1kU0t3NXFUN1dyZGhENWd6RnpY?=
 =?utf-8?B?T2xUenF3ZjF4bHRVM2Z0SzIrdXUzcWtYYlAvZTJBMUNNNUFQVExycnB3UnM3?=
 =?utf-8?B?T0dLUUFKWlpZVm5Ic0tkbERkdWE4UE03cm5pdFZ5WEhEcU9GRFV3UnJaRk1R?=
 =?utf-8?B?Q3hua0UxMFUySlZ2WEM2UVJNUFc1MFhleGRqSDROUEdPcTJsSjJTYW9WdERz?=
 =?utf-8?B?L09QMWJQUTRaK0tUUnpvWjVQK2VtMytPTFUxTTdhWlQ0bFBLcVFNWUJhbUJU?=
 =?utf-8?B?L1BCOExnOVJvYU92UDFmZHBYL1FGUlVFQ01oRU1uWWg0TENkTVQ4SFNjQmpC?=
 =?utf-8?B?SG9iK3hZeXh6aCt0SW5wWTdJQzZHZ2pJK1M5WHF0U1JKWlRXdU1XeFdEb094?=
 =?utf-8?B?TVFBSGNsR0lwWEpsZENjQWViR3hKRGRlUnp5U3RZZ0pCb0RITEw1RHlPQTJn?=
 =?utf-8?B?R2JjaGFmWTdnanFaZ1lCVG9vc25PRVJZSWswUFEvT1BxNGRZYy9sdGxpM0hp?=
 =?utf-8?B?NWE0KzF0TmlXbXZBUW0rdWdTUVZwUFVUZmtoNFFORFhZYVhjbWVzWVprL3ly?=
 =?utf-8?B?MENCbjZmYitiY01yTWk1clVIWTNGUk1BcStJYUdEajRjb0NjYW9Oc1RmNDZZ?=
 =?utf-8?B?Y1FYVStwRTNYNERjSDV4YnFack4vYTR5aGZJdGtBSXVRMVRtajRvM0tTUWVo?=
 =?utf-8?B?c0xnOHV3TWUvQnAwdmVCbGJqeDZqRVNRK29hNjJqTE1pa2VTOVlCckhqUmli?=
 =?utf-8?B?djVsSzl6MVJRdUc0NC9MUEZjcitiR2dIQjludjdjTzRDdFRlQkRCeFpHdklv?=
 =?utf-8?B?TmY3WC9WZjd4S2I5Wm1lWEI0QWowWTNqTXVMODM0M1VkcmRhaXcwcnlQZjRw?=
 =?utf-8?B?TGw1MEFqRHVzWDNDTWJZMjBWOWQ3TEtyVTljU2Jla2FPY2M5U3QzZFNRNy9a?=
 =?utf-8?B?Ykx6TytlYTlwallEOUtVL0x3Z0MxaWJ3cmxNWHhraURKRXNLRXBRc3J6MklE?=
 =?utf-8?B?UDRMSll6MVdoMjNsdUxMbm1TdVBwMEwrbVN2aEZkTk0yTW1SRVBlclkyRGZt?=
 =?utf-8?B?NG04NzlzYkV4RXZYVTVnbEN0dG4zR29iQzh0c1NMLzBuSUswMWd5eXdPaDZo?=
 =?utf-8?B?Y005OVJvcHdjVXg5SW0rZ1BOYTlUSXhmUEkremE2eEEyallIZ3p5Y2E4YWxQ?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3614a55-1655-4ab5-5052-08db59aea563
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2023 03:51:23.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2fI6EQ1iVOIFXC7tNH6Kb5JoBdQAt/B2JDEi4MaYo3v7JdZ0jt/fVq0tPLbdVGR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3912
X-Proofpoint-GUID: 1G1m2cb2PgjRxdT9SpTDUYG3zcPcxP4f
X-Proofpoint-ORIG-GUID: 1G1m2cb2PgjRxdT9SpTDUYG3zcPcxP4f
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_01,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/20/23 1:40 AM, Hengqi Chen wrote:
> Currently, several BCC ([0]) tools (biosnoop/biostacks/biotop) use
> kprobes to blk_account_io_start/blk_account_io_done to implement
> their functionalities. This is fragile because the target kernel
> functions may be renamed ([1]) or inlined ([2]). So introduces two
> new tracepoints for such use cases.
> 
>    [0]: https://github.com/iovisor/bcc
>    [1]: https://github.com/iovisor/bcc/issues/3954
>    [2]: https://github.com/iovisor/bcc/issues/4261
> 
> Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

I tested with my local VM, enabled the tracepoint and did
see the trace_pipe printout nicely. If the patch is
accepted, we will enhance related bcc-tools/libbpf-tools with
these tracepoints so they can continue to work with
newer kernels.

Tested-by: Yonghong Song <yhs@fb.com>

