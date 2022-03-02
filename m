Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC394CB1A6
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 23:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiCBWBA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 17:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbiCBWA7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 17:00:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078C6CD5D7;
        Wed,  2 Mar 2022 14:00:16 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 222JMoEl011132;
        Wed, 2 Mar 2022 14:00:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=rT6ko2SecWITHSpqGFiqRHFbplyN4beHsLk7Syq0HVQ=;
 b=Kel3OA7dgS6su+ASoAMwDVd9jmTbldLp2+c86mHoUGeoAOJjtwlTH+RPUtlG46464rOa
 RZU5bEUED7qTulFOAq9ByNW+PvrcfyX+S7ka/J5WyE+QIRxmlI8N/Xso5tzkZpC1Fz5l
 MusLr9A4XPhNBLy1i72Bkf1JwCN1BrmX/Q0= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejaqwu6kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 13:59:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMjf3GvjfzSuKCMdlotzaVGiaoo39NujRI0sTBNP7H7xPwXDaLAVMhUXSGNXJ5npcTD4chJbAOkE2qN2AjK09FrShwhmhu2NG7z4ngvJowQqAMjY8/Y7MDrEzZi5ctVzcg1jM3701wqrrMuk1544gIOu2Hm0w9SOLli+05pkhTwN+TEDq5SFw1aZq8wRjDM37Ms1fhYf4L8XZiWrMvGT6OqTDs08f/DD1nk2PMHx4eoRXSGdcWFaPybRPjPQH0GIEeFsTcGoTcPL2/ILy340x6rZlnTLq7xDNDDdUhllSGtySFgEf17Rtkt1ACNkhF1naSEWBSWggdIgQQA30fbA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rT6ko2SecWITHSpqGFiqRHFbplyN4beHsLk7Syq0HVQ=;
 b=lTGOdRmnkRZ+X57QFCHncdMkOUT/dFzejWO85YVUgNuMvVeha2wgy6rUR/bFuA12byt68fkCNVhziOuFkibiXSGhFuL15qphyjSzksm6kPRGuSaXRgJo+5reeqiaxURKxjL330xvEM/RgvXvWQY4Ag7q76C6sf3hoB0qVhO++eWoi08oIbQ74/QQtPEgP3Abdiq4+cCVguwVR4Cgz5B+LwBCsW3FsTLWWTStBFbq6dSa298ft1UWu+rR8AeW6ZWvuEwgCDtu66Fse9NG9zfAHXQ83D3Jhbd0c4FTyzSUMVUGKBqi48IGzyALVsGHMurDNf6isDBEN+3qZ3y7syHQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4661.namprd15.prod.outlook.com (2603:10b6:a03:37a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 2 Mar
 2022 21:59:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 21:59:57 +0000
Message-ID: <a4a23560-8a63-90f6-ad1c-c2d5c761e7e6@fb.com>
Date:   Wed, 2 Mar 2022 13:59:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 8/9] bpf: Introduce cgroup iter
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
 <20220225234339.2386398-9-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220225234339.2386398-9-haoluo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR18CA0052.namprd18.prod.outlook.com
 (2603:10b6:300:39::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4838601e-abea-42ba-280f-08d9fc97fd9b
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4661:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4661CA28FCA1A571291A6712D3039@SJ0PR15MB4661.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUdioub7KjSDfOspetfIcE1mgVN81cFUP0rluxYt4Xhn/xb+w4fMCMUYK3qnpWAWHzFhka8QWEhQattHG3qwmH2knEYOyPd31MZ8OKlwRNQMUqdEo7gfmTeLmeyzm3NM3fEOaxXkSN68CaxNhyGCssdV01H/mCrB02spookMKu8F/L0yL4UP0Nu3eQVjBbBalUKaLfOJjIUfyLn9yMyJp19HCdwBcuHqyx/GgWGhc51Eut73U+iW79MsBxXIL+qbrOVCCy4PupVZ53ZOSjZe9VtH9f8cAvkNSkuzBLE030p6xA2BbY07XZY76wv3CnFJHp2CfFUI2KQ3eImWUo991doxY3/O8BME1UZFLkXldb+7/KXZZnEGThr9mKqF3o8EuiyCYgEyOQCbXdcp7ccuwvnfFJdW420ot3aMRzYfGRq31h44JUad+oSPIlrFP+XWh4HeuOh/HbvBYBxXEanL/75ENA/SJCBcvPDhH/ncaaGzg7d0lsekDqOg7mjxeh/7vWtY9iK1bCx+p0hyWULn/0jK98QmiG3tmpb4qRnIJQX+/Fgk0+hlYNiMv735JbqlixDCgmAmW4t2uEKlEYjvfPjSq3sSB7TSIfynz3dC6ddqc0eKYM+5plSpTp+4rgGDzSRhzJUHnaXKzo8K4CmvTduCsBvju3S532T1Ur3g6mOgzP+KEkB+UQs3kM02I5LDeGBTPt3HeDF9puenVPQTKQBAjsWhUyjuXCAhYnBf9WuYYFAXd0CapomN+lZnJ7SW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(186003)(38100700002)(54906003)(86362001)(31696002)(110136005)(66556008)(66946007)(6512007)(36756003)(66476007)(4326008)(31686004)(8676002)(2906002)(5660300002)(7416002)(508600001)(6486002)(83380400001)(8936002)(53546011)(2616005)(52116002)(316002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmRGQUdXOHNGeHVyazJab2o0LzAvQnpSRmZCUkVnZXBYcmJDWjdxZjZXWFZo?=
 =?utf-8?B?VWdIRi9LYUpYUElTdEQ1TkJIN290NFY0ajFHdDNNUUJUU2g3dGhqNm9FZ25x?=
 =?utf-8?B?b2tIY2dkN3FPNEUvZWNlYmY5NEorS2tjL003aFVldnYwSmVRM1FnN0ZQMlJ4?=
 =?utf-8?B?ZUw3VWp1VzJQVHkwUjUvYXVwRVk5OXdwNHB0aEZqUlVuSEg3NStnaDA5a3hF?=
 =?utf-8?B?Q3ZtL3FiNWFmSnRraEs4enArRG5yQ3ptWGJSTWU3RjQxNU5iaWFHTU1SSXFo?=
 =?utf-8?B?N3lzYVJPaWw4Sk9rR3hqWFo3QlJ2TVVLdnlUU0F1QnRyQzJBWVdLVHdlMmtH?=
 =?utf-8?B?ZTYrcndFMU5QS1BuY2F5T0w4SXpOYkVhUEdMbzdvVlF2cHhrcUcwQnNGY2l3?=
 =?utf-8?B?S0hoU3QxdTRsallnNmVBeHQ1SUZrcExtdE9yRDJFZk8yTGhJc2xINlhEYWtN?=
 =?utf-8?B?MjN0cUd0M0NVN2dyU1VKWHBSaUZvanZWUTVabnlEbVVEZVYxR0FqZXJxem42?=
 =?utf-8?B?bEllSFNXamh6eXlWL2JVUkNiM2dmUnFSOHpYa2tyQ0ZXNUNia3krS2c0OGlY?=
 =?utf-8?B?elpaYWFBemI3NnUwTzV0a2c2UVFYaVl4Nmh4NDdBZ3RVaTAvemF2UWcreHp6?=
 =?utf-8?B?VmxhYmR4enNFOGI1dVpmYkpCTU9EaTJiTVpUSExxOVFxZnVSN3czcVd6OTYv?=
 =?utf-8?B?cEVIVlY1VGRvcUlzZUFEa2Z6dDJrVjhaZUxxYTJxUWVocUR4QWtDTjY1VFdQ?=
 =?utf-8?B?YVBPRnY0M1RXenEwMmhNTDlsV3pVcGJvcS9MQ0dqd0tKRWlFUWpnTytlWWVC?=
 =?utf-8?B?ZzB6aWtrUE1uWk1zWkZyUmJPZVpxWVl0T0ZROUVoQkFkMzRqc0o1WkxscVNM?=
 =?utf-8?B?UXloZmFORWVRaDFCTnlOMENybncwUjVKU1ZiZ1NzdzNOZHdEYlBoazFGU25u?=
 =?utf-8?B?MjZWc3BHSzd2TTA1aUNRbTArUGNVeC9qUmhHWGplNlRwZFJNQ0JPaE90MHhW?=
 =?utf-8?B?VVBTMXVQUWp5dzZQb21CZ0tveHRKZTFMMzlaaVVrWlFpWG1GeFpaMS9iSTQr?=
 =?utf-8?B?bFdrVDQ0bVhqOERLVHJwYlBrVDNETDVZU3FuQ21tbWxBSWowbTVYU0p5NjhQ?=
 =?utf-8?B?RjRjYUhSYTBYYjQxRC9jQWIrL3ZDTUVuVkMvMXJUUmF5Q3gzZ2JSUFZFUVpq?=
 =?utf-8?B?Qmk3VzJOR0R0LzROM3NPTmFHelgrTU9URENpakh2dkJRS2VqeXhEMy9mWUVu?=
 =?utf-8?B?Q2ZpaFZYK2s2MHErSHpCOEQrRnhjOGhLZEpsTTlrM2hBeGlnZUZ1dm1CbTlN?=
 =?utf-8?B?V3FGUTF3cHM1UWZYM3NSdTZJM05ES0VaNDF0Z0cwL2s4dURMUUNodHNnZzhi?=
 =?utf-8?B?MVl5ODZzZks4Yi83UDFLdXhac3pwZm03V1k4c3Fsc28vSTBCSzkyMUxZWTd4?=
 =?utf-8?B?SVpjYTFxSHBNdFQrVmEwWXdHRTBveWdxUTJ0RUJLS2lZTzdGUy9yUS8xcWhu?=
 =?utf-8?B?Wk0wY1FwYlZtUmVaTUM5RE91ZjQ5V281YUl2cHMwQ0E5Z09uNERiRmFGZnVX?=
 =?utf-8?B?NnBDUXJuSE0zS0ROd0dIanBGUUdXditoeWlKeFIwT0pNdlRJQVBwYkh3N3c2?=
 =?utf-8?B?bit6RXdjc2lBUnZjOW9vWmRFL3NqMmoxWmMyMUJsQmNEU2swdTZENk5ZOVlr?=
 =?utf-8?B?NWgzV0YvL1oyU0F0RnYvSXNiR2FqVXFRbmpaQjY5aitWU3ExanZRZVdXQ0J2?=
 =?utf-8?B?R1orTlRUelJXK3FuSk1UKzVZbk1NaUFlcC9Lb0dMR1pQZ1JBWXM3ckNqUGNi?=
 =?utf-8?B?cDNkcEMyRE9DOUlWYTR5M3BVMW9TZTliS2hFcktUNUhrMzhkRzhod3hVTCtK?=
 =?utf-8?B?eE1SWUplbkpHVi9uK0didUpZeFpwMjk0d0lwUUptNXNFVDVzcmx5RWtvdVQr?=
 =?utf-8?B?TGFLUjZsSnA2bTBLVlZib3NMVlRBTFpKSkhXeGRpQnlmVnd2dUVzeUI4ampk?=
 =?utf-8?B?VVA2cEIxbzNPM1BFVEpDTlFUSU9iV20xSDZ0ZVFHWU5mWEZob3NtbFRBckNy?=
 =?utf-8?B?MW5uZjQzWjJ2R1QzS3pMMkNybmkzT2lDQlNyMUx3cFVXOXRyY1FxQXd1clJp?=
 =?utf-8?B?VENicGozNTZkRlg2YzU1QTdocVB6ZWZCcFdyc2Ezdk1nSE0wQzdnUzZrZ2N0?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4838601e-abea-42ba-280f-08d9fc97fd9b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 21:59:57.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PagQTxv443fOOr6mxVRczFKO39oXevukMrPVLy0rUmgY2iDM2jTucMpyXCQp71a6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4661
X-Proofpoint-GUID: Wf--Qx04TssLstBjKAgpGXvyEVsiMpxi
X-Proofpoint-ORIG-GUID: Wf--Qx04TssLstBjKAgpGXvyEVsiMpxi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020092
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
> Introduce a new type of iter prog: cgroup. Unlike other bpf_iter, this
> iter doesn't iterate a set of kernel objects. Instead, it is supposed to
> be parameterized by a cgroup id and prints only that cgroup. So one
> needs to specify a target cgroup id when attaching this iter.
> 
> The target cgroup's state can be read out via a link of this iter.
> Typically, we can monitor cgroup creation and deletion using sleepable
> tracing and use it to create corresponding directories in bpffs and pin
> a cgroup id parameterized link in the directory. Then we can read the
> auto-pinned iter link to get cgroup's state. The output of the iter link
> is determined by the program. See the selftest test_cgroup_stats.c for
> an example.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>   include/linux/bpf.h            |   1 +
>   include/uapi/linux/bpf.h       |   6 ++
>   kernel/bpf/Makefile            |   2 +-
>   kernel/bpf/cgroup_iter.c       | 141 +++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h |   6 ++
>   5 files changed, 155 insertions(+), 1 deletion(-)
>   create mode 100644 kernel/bpf/cgroup_iter.c
> 
[...]
> +
> +static const struct seq_operations cgroup_iter_seq_ops = {
> +	.start  = cgroup_iter_seq_start,
> +	.next   = cgroup_iter_seq_next,
> +	.stop   = cgroup_iter_seq_stop,
> +	.show   = cgroup_iter_seq_show,
> +};
> +
> +BTF_ID_LIST_SINGLE(bpf_cgroup_btf_id, struct, cgroup)
> +
> +static int cgroup_iter_seq_init(void *priv_data, struct bpf_iter_aux_info *aux)
> +{
> +	*(u64 *)priv_data = aux->cgroup_id;
> +	return 0;
> +}
> +
> +static void cgroup_iter_seq_fini(void *priv_data)
> +{
> +}
> +
> +static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
> +	.seq_ops                = &cgroup_iter_seq_ops,
> +	.init_seq_private       = cgroup_iter_seq_init,
> +	.fini_seq_private       = cgroup_iter_seq_fini,

Since cgroup_iter_seq_fini() is a nop, you can just have
	.fini_seq_private	= NULL,

> +	.seq_priv_size          = sizeof(u64),
> +};
> +
> +static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
> +				  union bpf_iter_link_info *linfo,
> +				  struct bpf_iter_aux_info *aux)
> +{
> +	aux->cgroup_id = linfo->cgroup.cgroup_id;
> +	return 0;
> +}
> +
> +static void bpf_iter_detach_cgroup(struct bpf_iter_aux_info *aux)
> +{
> +}
> +
> +void bpf_iter_cgroup_show_fdinfo(const struct bpf_iter_aux_info *aux,
> +				 struct seq_file *seq)
> +{
> +	char buf[64] = {0};

Is this 64 the maximum possible cgroup path length?
If there is a macro for that, I think it would be good to use it.

> +
> +	cgroup_path_from_kernfs_id(aux->cgroup_id, buf, sizeof(buf));

cgroup_path_from_kernfs_id() might fail in which case, buf will be 0.
and cgroup_path will be nothing. I guess this might be the expected
result. I might be good to add a comment to clarify in the code.


> +	seq_printf(seq, "cgroup_id:\t%lu\n", aux->cgroup_id);
> +	seq_printf(seq, "cgroup_path:\t%s\n", buf);
> +}
> +
> +int bpf_iter_cgroup_fill_link_info(const struct bpf_iter_aux_info *aux,
> +				   struct bpf_link_info *info)
> +{
> +	info->iter.cgroup.cgroup_id = aux->cgroup_id;
> +	return 0;
> +}
> +
> +DEFINE_BPF_ITER_FUNC(cgroup, struct bpf_iter_meta *meta,
> +		     struct cgroup *cgroup)
> +
> +static struct bpf_iter_reg bpf_cgroup_reg_info = {
> +	.target			= "cgroup",
> +	.attach_target		= bpf_iter_attach_cgroup,
> +	.detach_target		= bpf_iter_detach_cgroup,

The same ehre, since bpf_iter_detach_cgroup() is a nop,
you can replace it with NULL in the above.

> +	.show_fdinfo		= bpf_iter_cgroup_show_fdinfo,
> +	.fill_link_info		= bpf_iter_cgroup_fill_link_info,
> +	.ctx_arg_info_size	= 1,
> +	.ctx_arg_info		= {
> +		{ offsetof(struct bpf_iter__cgroup, cgroup),
> +		  PTR_TO_BTF_ID },
> +	},
> +	.seq_info		= &cgroup_iter_seq_info,
> +};
> +
> +static int __init bpf_cgroup_iter_init(void)
> +{
> +	bpf_cgroup_reg_info.ctx_arg_info[0].btf_id = bpf_cgroup_btf_id[0];
> +	return bpf_iter_reg_target(&bpf_cgroup_reg_info);
> +}
> +
[...]
