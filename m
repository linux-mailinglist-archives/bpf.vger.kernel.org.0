Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16FEA4CB058
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 21:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244303AbiCBU4P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 15:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiCBU4O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 15:56:14 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2FACA0C7;
        Wed,  2 Mar 2022 12:55:30 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMh1h005226;
        Wed, 2 Mar 2022 12:55:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7nY5qnJ7GliKa1SM/ZvK6yw2mRorMSMr87tIUs83Ezw=;
 b=lziRa4/+0EhUwQI2Br9fNK+kyq+nc5p2tv6Ck1ambrMfF+2PyCOF2pcsD9yJSs5tXCQX
 0YUJDhnpRAQEVTVWD5Qh8R3e3zIdPT+LPj8gO0Y2dZYzCZEVmglsqHuz3iKj3EieUnyu
 oubTDTSC10JJ/fk5QxiwwU1Iuofx07VR+WE= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ej7kkvvmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 12:55:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhuKDrv2TlSRi5wvPdSNe1RwDpPpKw2vV/OFl7PStA52xpP40m1Rs4dl2QcwscYUhP+xiVp39mIQrcarORIjg0dkoSmHh000kgJPpx/78dCGqWTQnoRY7nm49EHyToQ/8aaUJjTnPK2A2rIiZxfXDpN+mshwvgyvnyHM07AQLotWHuP89xuIHK/ewyM90hWRKWGzhjtYFPmEJxYC6FW2zI1wtVjMYY4W3oBeKXmEr3Fe+PNCgJ5xAnXrYzhzfN+CErZSG31d8s4SRdW3p3nMCtJCHchzXm6SQAajvGjgwSOWK9qfDBYIzHr/WhdqPH3BLhZpEGG0PsroUFiOm06S/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nY5qnJ7GliKa1SM/ZvK6yw2mRorMSMr87tIUs83Ezw=;
 b=P8GPeMjSclEBLX6FR7ds/Z+XhRvZkTd3PhIozhpbn9zWcq+9lVtTlG73LvZBTOQ2sZrOyoBEWLeDxa+qYstnZ1NwkplufA2UG2+h0BAcGg683StTo2DGC5u0M6rEJ/675JEQMMDnxUeEOG+TEM0U2A+68pGcokxc0NSxceusJbn1fTxHE9T6gAddib5LwW9N+hoRV13wYulNtVsjW3tLcEhPKsMpF4hk8MYO6s4DQr2WuqGfLFXSZYiV9XLU808xLapeMTcjpHlN/ru4410+/SpTIL2US4QtCAj+PvdzUVUmxaehkZ/m8PjDc0J92tGO415SsyqD3TlbxAK6rKoHfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BN7PR15MB2452.namprd15.prod.outlook.com (2603:10b6:406:87::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 20:55:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 20:55:12 +0000
Message-ID: <7e862b1c-7818-6759-caf1-962598d2c8b3@fb.com>
Date:   Wed, 2 Mar 2022 12:55:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-2-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220225234339.2386398-2-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0005.namprd21.prod.outlook.com
 (2603:10b6:302:1::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7b20daa-64fd-407d-43fd-08d9fc8ef1c1
X-MS-TrafficTypeDiagnostic: BN7PR15MB2452:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB2452B1347373ADF8CCBE19D4D3039@BN7PR15MB2452.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOsZ/cziu4NuaNk+uyZgxMn2DKftmRrGQYj8zShlmvArBWEwkw/AwiL2/gI9JEWiJqFC0WdqL2z+CHu/ytV0FGnJBaFIXnHhNkDRlIwtD/IR+rFY24mWq2RSIQ3Gt5ew/m0rKBfRoAyXXjIlxnf0QMM2wrCQJbdCZRPtM2X5f2ihQ6h6lFC34kqpPr+4OI0HOR4Q5TJJh9BTXlbbcwSH/nkir+5aEwUNj9TyZvUBn3D/MuP/z0rPdMR/ecaOxWYETZuW9ScUitUbaVZ0nIKTTkU3UvL2td18djjgL8OpN6XqpfAnYnVSvwns9KtLJuZV/GtIm4IRdlwix6ogIzBRdoCFLJ9P6kwps2760jsZbRXfPWWeWflhcKKIYcFc/w2n/eUJcTaXDkzi3p7Uvx5B+9jVK+cQR5cRBpYiioKhAAXFK+Z6fNOpchYSxHFCR7Cn1+emNynyVXyBu6ZkV3Vs+eTu4D7dRS1dPCs8qEWs4HQSrqCseo1JQO6vNjSSP1I5uyPEfT/aKHc/PZ1UO/Vqkb3R/0JU4Jss96iWnEWWFEq+COQrbn4AEU8pnm8QFtPpi6+VCtC4zplENKqUkLwXq5TvOmMTWwSiVah6vdVbPLz5BkMjwFhDAhmv8lF4IrHQtu3mJJW4WQv+4oHxccjjsPjBE8aJRjUlGZM1beAVQDWaLPVxtRKuhNEEb957E2pIauo/U41bG6Y6Q1GgDFpxuy8JpEunRk9tzHOLweNTZlc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(110136005)(38100700002)(54906003)(6512007)(66556008)(52116002)(6486002)(66476007)(66946007)(31686004)(508600001)(4326008)(8936002)(8676002)(316002)(36756003)(7416002)(31696002)(6666004)(86362001)(5660300002)(2616005)(6506007)(2906002)(53546011)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDdoT2FwdnoxMk5YcGppOEVSUE5FYUZlNi9HN1h5UU5OSE1zQ25qWVlML2hZ?=
 =?utf-8?B?dTFER1l6ZmVTazlkZm51aFc1dlk0OWxTaFYwcXJXcFVxRm1obFhVWmNIK21T?=
 =?utf-8?B?QlV5SzYybjBVMWZUMlpXcFVJWEVZdGl2YnpXclZhTmpvZDAvRE5CYnNJZU5X?=
 =?utf-8?B?L3dYWTR3QTJHbGVwQUFPRjFCVjMrbFJyYmVjdVBYQk0rSW1SUEdxeDFjYmFp?=
 =?utf-8?B?RmZxYUYrcjlQYmRlcEpqK0syb3E3WDRLYThXZkFMcVMxemhQK1lZN1lsZ25a?=
 =?utf-8?B?dU55VW1wbFl2TjU0UHpqVVNicUxVZ3B2d1kwOFRZcDNyTFZMMk9VemhoZGFq?=
 =?utf-8?B?RWNmYjM3Wm9yQmI5cHRPVlZSd1A2TU9kcExwT0NjWkhEUytsTXRsMzlMQkd2?=
 =?utf-8?B?cmF2OHZKTDhHMTlVdVY0ZDgvUnhnQ1N0MDNldmRpcFZVRzZMUG9RcTk5dzhB?=
 =?utf-8?B?U3RNY0VWSWxqSVQ2MFJacEJ5bGtVdjNhWGFoVDlZZlhjelVWbWNEQUltb3BJ?=
 =?utf-8?B?UEJZWWk0RklyTzFPL1NOOFdTRDUwL09kNEI2ZGhmZk1rY0hndVNncHNXN1JK?=
 =?utf-8?B?c1F4aTFaWlErUFc4d1d3QnlLQXozckM2OUxpVitPOVM3TFgyVFlGZVRBWVZM?=
 =?utf-8?B?a2hQQXVEcGN2VWVaZjlqd1pjSG01SFBUdTFHaTFURWhwNnpocElkb1N0V0dS?=
 =?utf-8?B?UzV0NFdqVXYzSmdiK3BQWG13T0w2U2RVSlNUSVdQMlc0UU1jZTJlQzJ5dUl4?=
 =?utf-8?B?TTExdDMvK1R5a0pOMGZ3N2tJbk0vMnA0S0F2bWQ0V0IxQ1Vra1hZUFYzd0Vo?=
 =?utf-8?B?TVRXMjRDUVNmRWFnSE80UlpjM0NReG1qbEJQbFlmTERLVnNwZTh4b0ZZcnlZ?=
 =?utf-8?B?QTNVTWxPVVdHaU1LemxlZSs4dUZ6MW1XK1JwdzYycUhEdFB1amdwbGlraHpv?=
 =?utf-8?B?VkgvT0QzbEVBeU5LQU9VOHp2M3dHNWNGVXVNemRDYys5TkhNYnZPeE5SMnZr?=
 =?utf-8?B?WnlQczlXYWdPMTM5K1pRTVZXRHlnTm5xWS90ZGdSa01IYW9oZVIxdzVIVVE4?=
 =?utf-8?B?K0c1RGRBYjZCTDRTOEtyQU9NRW01eXViQmkzQUlYTU9heXpXTnY0cTJKYVBP?=
 =?utf-8?B?M2lJVGpsQ3EwaEl0T3l2WHB5RFFjUytGeUM4L3N5cE9mNWUwdnZwcDlXbXZC?=
 =?utf-8?B?RmdXc0w2M3NrdVdUUExkK0s3aVZKZnV6SC9ZMzRzUFJ5eCtrSEhkeWZKenlI?=
 =?utf-8?B?dTVKQlJBOEVySSs0S1poRWI1RXp6aEZqeTFON1B4ejZzYWQ0Wkhldlp5WkMr?=
 =?utf-8?B?bDcwZnFGemYzeWVFZnhjOXNpRk5LNS9NVjk1cGVQRThVaFlhT0Zma3huWlY4?=
 =?utf-8?B?VU0vejl1Y1pkckZhNmlBMFMzQ0JYZzJjK2ZsSWlpUUpQdnk1UDRZalN4UWRK?=
 =?utf-8?B?V1NjOFMxN1QrQ3JLcW1ybmk1TlJiMFhWNzdMQXl1bDQ0NlM5UzZiK1VIWjdv?=
 =?utf-8?B?RjNodVF0UUF3ZXpZSVQ4YS81cTgwdW91U1FQREhVaVMrK0dMckZsS3k4V21h?=
 =?utf-8?B?TmFKdTFlNWtkV0gxZDdLUk5DcXM5NFRIU090NnU2OU9EaUNRMjl1dXRid0Q2?=
 =?utf-8?B?blhrU3FjR3ROaFJCUmtoTVlpYmVIUmI5VTlTZHYxTWN2dGVKMTdTSFdpT1Fo?=
 =?utf-8?B?N2UwUWNKaTJjOXR4V0hWS2FFZmJ2bDIwM2tBaHVlTnNaMU1yaWdDcEJaemQ2?=
 =?utf-8?B?MThJZ2lLQ2owdDJlOU1lY2hoRE1VV0VhQkx3bGF6NlM2WXVUNDFSdjEyMDly?=
 =?utf-8?B?ZWFwNGlOZlVKUTBaN1Vrak5TQXcvY3kxNDRmcU56Yk5UbFVScFV5K0hFZkt1?=
 =?utf-8?B?Qmgxb0FkTkc4LzZuVE5iY1kxRXhRNjZiMjFKdVlOaHhZTTJveEtjS09BemF4?=
 =?utf-8?B?bHBOeXkwL3oxb2FJVjFEMXJnVHFwMDhjaVVPT25tb1VkcDU4Zk9oQTMzc1B3?=
 =?utf-8?B?cW10cHc4L1lwTEFzU2dNNHB4QnhQU3g4MVBMYmlvWFRFalRDcXVUeG9zZXJs?=
 =?utf-8?B?WWZ2M2I4amtsTGQrRjgzS2tlaGkzUExzalI1b0IzL3BVc1VhVjVwWHF3dmFE?=
 =?utf-8?Q?nu8g0tiD4Oayr3uvo4pcx4ViA?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b20daa-64fd-407d-43fd-08d9fc8ef1c1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 20:55:12.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fwtOPDforTzbU9Xbvtk/eIeeCc0RzDONptyxp2ezm8pwb5Q0kny7p+sqvu+ws4nO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2452
X-Proofpoint-GUID: OGdfvtAvvdAZscg1IPd5VHef1_FIiW9h
X-Proofpoint-ORIG-GUID: OGdfvtAvvdAZscg1IPd5VHef1_FIiW9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 spamscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020087
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/22 3:43 PM, Hao Luo wrote:
> This patch allows bpf_syscall prog to perform some basic filesystem
> operations: create, remove directories and unlink files. Three bpf
> helpers are added for this purpose. When combined with the following
> patches that allow pinning and getting bpf objects from bpf prog,
> this feature can be used to create directory hierarchy in bpffs that
> help manage bpf objects purely using bpf progs.
> 
> The added helpers subject to the same permission checks as their syscall
> version. For example, one can not write to a read-only file system;
> The identity of the current process is checked to see whether it has
> sufficient permission to perform the operations.
> 
> Only directories and files in bpffs can be created or removed by these
> helpers. But it won't be too hard to allow these helpers to operate
> on files in other filesystems, if we want.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>   include/linux/bpf.h            |   1 +
>   include/uapi/linux/bpf.h       |  26 +++++
>   kernel/bpf/inode.c             |   9 +-
>   kernel/bpf/syscall.c           | 177 +++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |  26 +++++
>   5 files changed, 236 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index f19abc59b6cd..fce5e26179f5 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1584,6 +1584,7 @@ int bpf_link_new_fd(struct bpf_link *link);
>   struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>   struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>   
> +bool bpf_path_is_bpf_dir(const struct path *path);
>   int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>   int bpf_obj_get_user(const char __user *pathname, int flags);
>   
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index afe3d0d7f5f2..a5dbc794403d 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5086,6 +5086,29 @@ union bpf_attr {
>    *	Return
>    *		0 on success, or a negative error in case of failure. On error
>    *		*dst* buffer is zeroed out.
> + *
> + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)

Can we make pathname_sz to be u32 instead of int? pathname_sz should 
never be negative any way.

Also, I think it is a good idea to add 'u64 flags' parameter for all
three helpers, so we have room in the future to tune for new use cases.

> + *	Description
> + *		Attempts to create a directory name *pathname*. The argument
> + *		*pathname_sz* specifies the length of the string *pathname*.
> + *		The argument *mode* specifies the mode for the new directory. It
> + *		is modified by the process's umask. It has the same semantic as
> + *		the syscall mkdir(2).
> + *	Return
> + *		0 on success, or a negative error in case of failure.
> + *
> + * long bpf_rmdir(const char *pathname, int pathname_sz)
> + *	Description
> + *		Deletes a directory, which must be empty.
> + *	Return
> + *		0 on sucess, or a negative error in case of failure.
> + *
> + * long bpf_unlink(const char *pathname, int pathname_sz)
> + *	Description
> + *		Deletes a name and possibly the file it refers to. It has the
> + *		same semantic as the syscall unlink(2).
> + *	Return
> + *		0 on success, or a negative error in case of failure.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -5280,6 +5303,9 @@ union bpf_attr {
>   	FN(xdp_load_bytes),		\
>   	FN(xdp_store_bytes),		\
>   	FN(copy_from_user_task),	\
> +	FN(mkdir),			\
> +	FN(rmdir),			\
> +	FN(unlink),			\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
[...]
