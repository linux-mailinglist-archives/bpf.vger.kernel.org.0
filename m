Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2EB59EA83
	for <lists+bpf@lfdr.de>; Tue, 23 Aug 2022 20:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiHWSGc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 14:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbiHWSGJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 14:06:09 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EF260504
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 09:14:06 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NAWru4005563;
        Tue, 23 Aug 2022 09:13:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=h/khDb70zP6lfQHtMN4VTBEYm4gMVfyw/3PvhhKRz7c=;
 b=m2xV7wyXNCORFgOQRkSNo7cAVJiu9rbe+D+9yy0u234y9Wd2Tx788O23KHewJF59hWHf
 4oJ8w8B1m7BcI0U8Oz9P8rfPrqFznWB1UD+kVltIb/zakcq/2o8IDqPcNR/nzkU0BqPn
 98paqoWa8MwL7aZ8sNxRIUMq7lMOrm1D+OY= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j4w83t5ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 09:13:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3BGB9V2bTozLptKmnoOGEMbQ0GXoQo8cV3GBE9rT7cphtEvrO+nc4N2DWUWRte7ozekwfaNE6+Jo7jOHwn1MYgvqz0o53pB6tJLHLXBfkFcRjaVuIvNAuXyFpPtQNTWBruT6NEQ9iHThiTLDA7X3U3v46eQ7XIkVYv7/bSNUsbJh5IBZRVg3nc225HzYu3nvGGb9ZgQdTUqxf6EcngbF9Nu4Z9razogMwIWMYlrz0ZiMQ3drFgM3yb4dXj24H8N6K++96U5WbvIusUmG4KWG2shsYc+1aQDiM+M+fNmq128RmbNZsxZiISLAEDKg9bhzL5w3S50+Yy1gUWDXj3e4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/khDb70zP6lfQHtMN4VTBEYm4gMVfyw/3PvhhKRz7c=;
 b=oJQxjh62nZjQ1za3eqZ37qcgcZzZgETCRaLCbNl7hmLgo2DPyEGK6nfsqNExLIeDfSc1EY8gOe6mnb3EACP+lYW6qksCL+/TtcWr8m9ijqzCosIjgsYgdskkApcCndUBEPNx9jWUs0GEdSeOYAWar6yi8pvVeVvLjDGAH7Ad3YIpYhpcvMkxUlrsLKM2VA3hTiv+u7bVIOd4a8U0+TIdlY2f95pbGQwJtVsVsjRaph3ORw2pEfLSG9KvRrriswhwXfXY8MbPh2nMr4OT/J5WHFthqBjy4MI//zRfm6Xqg4PZRTWu2EnpUj8ZuijIqUy9/wWMdyDdLDBjs+cKsC/g/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DM6PR15MB3989.namprd15.prod.outlook.com (2603:10b6:5:294::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 16:13:47 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::1858:f420:93d2:4b5e%3]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 16:13:47 +0000
Date:   Tue, 23 Aug 2022 09:13:45 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v4 1/5] bpf: Introduce
 cgroup_{common,current}_func_proto
Message-ID: <20220823161345.fgjnp2tjgfn2u4kz@kafai-mbp>
References: <20220822194513.2655481-1-sdf@google.com>
 <20220822194513.2655481-2-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822194513.2655481-2-sdf@google.com>
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ff043fb-455c-45d3-fe28-08da85227535
X-MS-TrafficTypeDiagnostic: DM6PR15MB3989:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JF/OZVN5RGC9LAqGi7jgu4jLynEw79/CtrcaSZT6I5RCbse8du8ry1c+MJ0FuYgzXFRPShnc8hWr4xbvWaft3iiSu1XYo6wLmXD3v4nmgwRQfbT/UFDkqQKN02ehzCFANQdnSPuly4PnLdWeqwat8DNnORRSmxbYm4OxUNdlOukEa2K1+vfXeqahdSLiBbfFizamj6Tl6BLH62eDNm4tV66I1Xa7231ckRPx7B/ElG1wFPMzrXzDkWh0wZ714RqkLF/atl1K6AuIf8pfzxV3TxMlhlPU6sh3IBmmQ8LjjRkUwp0h6ipzPMGDXAkT53CCIeW7irLZl1KN7i2T/xl2TlzP8Iw3lbUgRrWQ4MyG2+bDMH+9d/1vAGfhgnji2UVJleuGhrAj87SUWbYQCOkVloejfBf2YF+94qd8qPEkz+dDC9KP0anBJKAjORzOOIl1VsfY6nG3WoR6Qi1EmeqKBxfrC+uLAAM9S2h/mMsd+jDN75+IdX9NwMTuo7U53dJvPWlkCcz6LN7FWcaRL4usAaTxydbRaI0E6ZU/r6jXwor+ZadyDMcjlGPu9IWYru/CVn3OkM2YEckvONnOyVw22o+TTdBlz42+dG0sWGTC2tUzFk8tCDwl7WFfp0mlszrg9xsNccWWQ/FQeJx+DhgHah/hUcZ2EQSVwTsxXywijDsX7jTfAZ0GrbIamwT90JjEQOQtygHngc0VFhESXut0Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(6486002)(478600001)(41300700001)(52116002)(186003)(9686003)(6512007)(1076003)(2906002)(5660300002)(6506007)(7416002)(316002)(33716001)(6916009)(8676002)(4326008)(66556008)(8936002)(86362001)(66476007)(66946007)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwfgxWNPwF/3o7Q+Yq6ucPngx809wMMHL6SO2w0JBKeOxyc7GMTdCwJuah3F?=
 =?us-ascii?Q?M5mKBsQqKRW8+o/uY+ZwuPUwOoEWz8c0oy89T7uLC8IyE4QJ9Mt8Y29egUZK?=
 =?us-ascii?Q?0mSqURHswBi4zF7FagMBQrrHM5vhMGBa1K9NVrLIzzLpRyECzEPbM7UDsQLl?=
 =?us-ascii?Q?bqgM9eNq6pRCfGSEdYHZ+eKJ8Yq3MvbqSiF2A7r6qOhf4mN3ahWRBJqPqw8J?=
 =?us-ascii?Q?9nVRDHNyE1PVrP1Oa7ZK4DSXGVVkIAyO6McPBLGjBKiLqqNekzpvHCVkFZRc?=
 =?us-ascii?Q?7gJVFvScNu4JsEMbSXb81FzvUWHCudyltFqt64s56yh/pVX5362Wqj9LWEvI?=
 =?us-ascii?Q?51S8X1JZ+dWT7PLLsz9C2QDVpXuFdFwmbOaTW/64WVBEVLFWiuEuzUL3IN2o?=
 =?us-ascii?Q?uctb6xZ+QfssDZ/u6cE88/9643P9oM2JMvV5dnFMa0NJjHii0J/JZl3bJvxt?=
 =?us-ascii?Q?6OwmzBg0HIiLvtiFDKzM0eM+d3ZP6e7P9ZBjC6jUOH/22HiIgq4HHYssO/JX?=
 =?us-ascii?Q?AOacOS2skb/hwdW/m6WxuUS9g4nQ4ruLK2FsG2WfU737Sm+pqumlKLO2IuAa?=
 =?us-ascii?Q?+rkPu37pDUumfAI8GaItzk0OW1mAiHAHmlLxaPoF0qJdKC5VfmH+0uMQwjvA?=
 =?us-ascii?Q?cNSg2TV5JEv6a/KcGksAxcrFmOfVYIt1EcEOCHgC5VxpFZprCVu2TQ+qhILq?=
 =?us-ascii?Q?PW3vXQe5brZ0VkvL7fgRP+JiaNSjGl7sa8iBX8QEA0iNftuJPDRsCAann6jX?=
 =?us-ascii?Q?nUcO2L+isMbLpDmXzQ5Crtwy0V2eO2CMVjjuKouf0z8J6O423bbucR4jszYD?=
 =?us-ascii?Q?RcYab0HbazpKbGSxBtKSQxZwOMcXIvjbh2UZakGYnzWe+LHHX2RFy9o3u46T?=
 =?us-ascii?Q?O8A7lYbv+Vo6K5aK28u/lGTuDkzZYJYyL6dOQ9v+j4qvgT+PiJvDcigR71dH?=
 =?us-ascii?Q?F2sXdSc9NqCJIwNEKgOH1xvRFp/njfli3I+wKGBFt+WqzXK9PTH8KXRtzVde?=
 =?us-ascii?Q?LN8MrOaco21TkeI9KcWW6IPljzbO76APeeFQ/mqtVLc6n9uJqMHqc7btJOK+?=
 =?us-ascii?Q?nTqb7Wd35r0O7Zn2AW6mK0J48/SS+Yee2c6yiu5ZW/8JMDl9l1x49xjbH1Kw?=
 =?us-ascii?Q?/vcB9mpgJd8wHqoBy4K6rkv00NH3tOgPuEZtBgRJWZ35SNLlb3DTOnAhngLp?=
 =?us-ascii?Q?i8yFQ9oZq3VAYF/C01uINxZCh1JX9LAIXfC/IhyNkNt6prHvHIYAPB3LhgN4?=
 =?us-ascii?Q?cypXdmve1vITLId8JNCnWBO7WGommEnnu0h9nDo4oCVNoPn+3zAAyL+FryMW?=
 =?us-ascii?Q?tpMQdPnAXxbeice25Z4+YXmHqtXhV4TxOvyNKVGGxK+wg44Q2Ascuslxgu6U?=
 =?us-ascii?Q?3hN9R0JhMlKLBzaWhThbjp2to61p0OT6B0ePcDLLnGM7Z6u2h8XJj3b4kc//?=
 =?us-ascii?Q?1Ik5X2brzILO6Dp5nl7HzRrnxtxq6oFjj8szhp9bQuk1rw+fTXxqw5LLaMGx?=
 =?us-ascii?Q?3kAPZ/mQexlZVmXsBI26BEIG+fLkRYnfddWXySq/cD5KP628aYLAJkGVaVlI?=
 =?us-ascii?Q?BLPGvsLpE0aCPxVpiisXd8H4CucXegPv9oagLRDm/EeG7ZIa9H7g2b2t7773?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff043fb-455c-45d3-fe28-08da85227535
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 16:13:47.0700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8Tc8r84XtF/75zeBjv4IEwiO90r1/gdeFKjafQgs6i+VQ8wek+2Ua5P1kX/NbvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3989
X-Proofpoint-ORIG-GUID: THuEYMgUqX_l80gkVyhzw9R_KSXCpsUT
X-Proofpoint-GUID: THuEYMgUqX_l80gkVyhzw9R_KSXCpsUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_07,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 22, 2022 at 12:45:09PM -0700, Stanislav Fomichev wrote:
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 59b7eb60d5b4..1c8ac13fe208 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -18,6 +18,7 @@
>  #include <linux/bpf_verifier.h>
>  #include <net/sock.h>
>  #include <net/bpf_sk_storage.h>
> +#include <net/cls_cgroup.h>
This include is no longer needed.
bpf_get_cgroup_classid_curr_proto is not moved to here.

> +const struct bpf_func_proto bpf_get_current_cgroup_id_proto __weak;
There is one already in kernel/bpf/core.c.
CGROUP_BPF depends on BPF_SYSCALL also, so this should not be needed.

[ ... ]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3c1b9bbcf971..dd20e2dc6ea6 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -427,40 +427,7 @@ const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
>  	.ret_type	= RET_INTEGER,
>  	.arg1_type	= ARG_ANYTHING,
>  };
> -
> -#ifdef CONFIG_CGROUP_BPF
> -
> -BPF_CALL_2(bpf_get_local_storage, struct bpf_map *, map, u64, flags)
> -{
> -	/* flags argument is not used now,
> -	 * but provides an ability to extend the API.
> -	 * verifier checks that its value is correct.
> -	 */
> -	enum bpf_cgroup_storage_type stype = cgroup_storage_type(map);
> -	struct bpf_cgroup_storage *storage;
> -	struct bpf_cg_run_ctx *ctx;
> -	void *ptr;
> -
> -	/* get current cgroup storage from BPF run context */
> -	ctx = container_of(current->bpf_ctx, struct bpf_cg_run_ctx, run_ctx);
> -	storage = ctx->prog_item->cgroup_storage[stype];
> -
> -	if (stype == BPF_CGROUP_STORAGE_SHARED)
> -		ptr = &READ_ONCE(storage->buf)->data[0];
> -	else
> -		ptr = this_cpu_ptr(storage->percpu_buf);
> -
> -	return (unsigned long)ptr;
> -}
> -
> -const struct bpf_func_proto bpf_get_local_storage_proto = {
> -	.func		= bpf_get_local_storage,
> -	.gpl_only	= false,
> -	.ret_type	= RET_PTR_TO_MAP_VALUE,
> -	.arg1_type	= ARG_CONST_MAP_PTR,
> -	.arg2_type	= ARG_ANYTHING,
> -};
> -#endif
> +#endif /* CONFIG_CGROUPS */
>  
>  #define BPF_STRTOX_BASE_MASK 0x1F
>  
> @@ -589,7 +556,6 @@ const struct bpf_func_proto bpf_strtoul_proto = {
>  	.arg3_type	= ARG_ANYTHING,
>  	.arg4_type	= ARG_PTR_TO_LONG,
>  };
> -#endif
This 'endif' change belongs to patch 3.
