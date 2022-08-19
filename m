Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD859A580
	for <lists+bpf@lfdr.de>; Fri, 19 Aug 2022 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350226AbiHSSSV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Aug 2022 14:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350148AbiHSSST (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Aug 2022 14:18:19 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2564213F92
        for <bpf@vger.kernel.org>; Fri, 19 Aug 2022 11:18:17 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27JI7A1t017412;
        Fri, 19 Aug 2022 11:18:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=gMYcNxRI9ak2+4MZKMv5vQhjS3AWADuBzwTUq6yjKOI=;
 b=iT2laBTpR7Qh+PR7Zi5WXm6ljbeT9MJ6cK753gs7Mc+A6Y7+uupNDGagYLRs9Pz6bJHk
 BUNxliyFFDEkxxKNFs/XJBeKWN+I+GXvWuzOe0pgD7BUesETeAUQpNJgcfDYVHL1aC1S
 u3p1+1KVfoJYySQ10e8wGrTTM5hLTf4KED4= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j1sdw0yn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Aug 2022 11:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWKguZcqPA8euj9iX35Ys4kAvcfTIMsW01fSpJAFVSA0zujDIv+m8dWPKj3iOQilR80PhqXL1x2/tpYDZHOrQ6HcISVlZdvM5BxAj7pjPvkwISmMvm2DVvb79PJFwfJZvm2m9w7i58aTKyT7p6ieRkPa1joBEkZ2jNgOUEhTRripo9tE8mqS8og2slEavu2vJjXVJkT5EBXFrO7a4iS9K4NXIVz836qBjoR7TITaJHQAUB5w0LFVamWmmnbqQ3Pu5t52jECHj3RLcyQNmMutzqj7A0z6yOZhAfYn1FZfvTmcj3wLluhMktJsNsCjwKr3PElOp/HqVgT13rin/i1Stw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMYcNxRI9ak2+4MZKMv5vQhjS3AWADuBzwTUq6yjKOI=;
 b=T/zVwBQ6JylkghyO4rsOnPhJ1lecHtpEMmB/7tU0PfUVry31u0Ye116mVbXJBCe+GTyHjRZ+3vatGBuN5G3OGSnXa4C1Fb77jtaI9jDN5gVclN9XjkIjnwUYpttykG7TzClRNAZ483rn8uToiUXZSRmTObEZ7/pdiqcDE2TLLto/yR8ll8rxG2PjCsyEigavMATJHyfztukJOPXoX5aw4ZjuJ+Q0hBe0frKAPjwqd1TWp5aAdWEULpIeLErs0AXktxkK/0ujLe0OyWY9cCL4oGhFCoO7/UlIvVmLSZzZqQzwzcKGLLr3Amc7m7f5MH7D5lk2Xk0/VHze+hTXcoENxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4515.namprd15.prod.outlook.com (2603:10b6:806:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 18:17:58 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 18:17:58 +0000
Date:   Fri, 19 Aug 2022 11:17:56 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Introduce
 cgroup_{common,current}_func_proto
Message-ID: <20220819181756.2jfak4bfsu5x7csb@kafai-mbp>
References: <20220818232729.2479330-1-sdf@google.com>
 <20220818232729.2479330-2-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818232729.2479330-2-sdf@google.com>
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fb8379f-b00a-4418-9215-08da820f2531
X-MS-TrafficTypeDiagnostic: SA1PR15MB4515:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iSv5kL0HwlkRoneT6uNPNpgGolEOxJHJJMEubTRVlLQ59m4tNropSPCW2wGPNSoAykzB0l8wWh6nCzrJkQm4NDGXbrMfjvvSMu7QSyShJ2PpchC8fAPDaoV+3wzZwAuCLLx1B62KSzeJnp1XadoyJgcKkwgklmXf7ia7Aagni3mcCEFzY5EBId5aws0UdzvnjQdzj+L9fnaP/nWb82jZ6x3rV4fQMJzjVTAS6i3K6VjXutCBI0zLjroWhldJY+Z3/NpNq44ww8rTTaIRPF4Xfoaf2pcXylIykqOA/0MyjU+2YDYiteaWMGJceo6tkKB6VSankOjLFkuRzrCogarTOJFczwXRpTlwygM7AeXmdovL2AQh61+PbKtJlE1Oy4Ow9WqsKpu/icF3zwcc2QmK0nhyf5GYV2F5rAayK7ms+pAxna7Sv9aePM3Gh+QVkJAfnBSO/y8KBdwV2yhtzdzzFA6RfmV0WWVAblFr4VE2CSpGnr3i9RfZZIZ1kPpD/+f2hjNP7sNnhZ3/gSMUKwbpKVTmHvC/OPVrUZzgBgoSEhAGWr+9+YS2bCyBiJ+twUlZddI4taKnRFQl/RTmpm+vnDvxad0kVyNrILOCLJXbCZ4RTluFSrrA1Wsw783085PQq6CLtFvbnSV7UzRRTLUtpBLU+McGqW+u1ZbpkI5/vFujQ76H1XRVOKjPBWGkgT00oZ1b0mGQsW9ixPfrBupIhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(2906002)(41300700001)(66556008)(66946007)(4326008)(66476007)(8676002)(33716001)(478600001)(316002)(6486002)(6916009)(6506007)(6512007)(9686003)(52116002)(86362001)(5660300002)(8936002)(83380400001)(7416002)(38100700002)(1076003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?orrZQj374fDAYLx4Vrv8Qapl0tzX0KByWY8YySd12gCTqIPbWEtN2m/mH4wo?=
 =?us-ascii?Q?TUmQ93OE2sAaiyYK/hrCvYrdU+GWEpIGxBLD5OpjZvrAtVbeN2PebM4J0ZNW?=
 =?us-ascii?Q?UY+/73Pp5FhuBZLY8w1EvoVmnjSPepHO+VWxMMbwAPz9HPZuKejDinOBlP+r?=
 =?us-ascii?Q?5w1re9UQMF/TFZADmuP36HuPVJmISlbSWUyxfsqvTCRwyRrMhRQmZbaEEMFF?=
 =?us-ascii?Q?PjPjJD1ijX5Yrp6X011/uZIwpT2tKKofkUGQKQKmYGWAPXC3RsPFuYmdEyZG?=
 =?us-ascii?Q?Rj9V8mneu/j5AM4OjTnAoMLxLd5bgB5sB5iCbgO5nTDmQx4IelP9BpuBoZ5D?=
 =?us-ascii?Q?vRNF5WC3HGbFu5MMRa3a7xMZblCmjFidmwQSa2U9N2CZ0O5eOc3CrWXn8SYD?=
 =?us-ascii?Q?ZIC//4klOwGHsDDzEm7v5sa7v+CFBE9bgjSObb1hgN2Pk8Fb5jFpI5JucBrr?=
 =?us-ascii?Q?bEEn+YlYtj1SCmnG38MkRPgc8zJagmxuJy6+FQbyNSymJbReel8tEr9AdZbr?=
 =?us-ascii?Q?5hf/aoVcWuF8eFOzRpzarn/vpeNZEBkbUAbQ/0GVTljawRcLAh0iWbHStEwU?=
 =?us-ascii?Q?BGEO/3yj6hHfz5zftfqGr2+u6D7Awc6fZrP2R0BAGWNAcZVuOkZdnbqEQmib?=
 =?us-ascii?Q?crdWUuh5daD0sPH1iYd9qlZLmvsLD/IjY/p/q/pgKUJDB2Lbo8QBUGyCktIi?=
 =?us-ascii?Q?i9shii7yzxSaN6zBtxzGD9aXV74+G47rBh9+3IAksFfZiXI77gNiRzq5ai0m?=
 =?us-ascii?Q?vlax9UrAj9Q8XSjyy7ll2zG8JKHMPeRhnPU/VUj/K6NEKaMtQB8sZ/Qe+2Gx?=
 =?us-ascii?Q?UPLF++id0/skC0A1pT+TmLsxeJP037uj8OoO/JouHxr70oK94p+UBx9gtBqe?=
 =?us-ascii?Q?lxBOhKSfKXntm3z8w6WuT0i9Qd7lRvMcxB+JK79NNDUiPC5p3/ZK4p+sJbFn?=
 =?us-ascii?Q?0lBSedj5iRTB41bYxd64CUUMC/Jeysu+Ni8CjZ9zX4lD359sCb+N5BrkC/Jt?=
 =?us-ascii?Q?obbauNhVBRJptmQ81tG7MZSCMNt60G4lUmg6zQltSiJZnTcUA+LiSvIMN8Wg?=
 =?us-ascii?Q?9R2fwxPGcEMEj/vknjLLfgIpBo406Xv8rQNF4/1a32UEY4tqAfJfCM+5j75g?=
 =?us-ascii?Q?boRYRU27/7ptrYnCeIad+4pTQUGt1L4Q+yD/Y6Jje3Iqarpdqzho592iEjmY?=
 =?us-ascii?Q?MewhJBygE36bGhWPD0kXrXi9wZR38BLxBnwYV0ZSNm0LkNhXKQhiRNPoFNFe?=
 =?us-ascii?Q?/DKSa7Zl52cKkfHfmjEwe0Tq+P6UZo4zkkU+xq3qq0w/zmFFBcz+CT60QXqP?=
 =?us-ascii?Q?2GMJrn0qthtgcXE+fgPzW7oMa7/nPUsztCN1ZevOoJvWF3QRZaoSrD/w3wgE?=
 =?us-ascii?Q?tqGQrMtoyp6LdYgh0wVZ6JY/kxhRHe/nGoTE/76T+LkZd3ACjDRdF4fUbPzz?=
 =?us-ascii?Q?FuY556fi5Xxq2hInJHT6Xtz5WnKsVWtegBCHe0lC2gB1PfGI28Rnf5qHesyk?=
 =?us-ascii?Q?QKiK/gBPQ8j4dG1AufzpyeQgCHTEB66PkXJ495mPa1ujI5bfvUFOaYLTMF8/?=
 =?us-ascii?Q?fZzx0pHPxst6gAd1fc4MjfDweBAe1TjV3Ev2zDq5jcfIuYMaINFf14OjnCP2?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb8379f-b00a-4418-9215-08da820f2531
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 18:17:58.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /xuCR6UytRmC6Qn+0nl1J4yhf2uVU20U5CEunox+tvZWr2vWQJ5SCrLXHNlJBDqz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4515
X-Proofpoint-ORIG-GUID: US0kiHOIqFTlVUPXmvSR8ur52ifOR7O6
X-Proofpoint-GUID: US0kiHOIqFTlVUPXmvSR8ur52ifOR7O6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-19_10,2022-08-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 04:27:25PM -0700, Stanislav Fomichev wrote:
> +BPF_CALL_0(bpf_get_current_cgroup_id)
> +{
> +	struct cgroup *cgrp;
> +	u64 cgrp_id;
> +
> +	rcu_read_lock();
> +	cgrp = task_dfl_cgroup(current);
> +	cgrp_id = cgroup_id(cgrp);
> +	rcu_read_unlock();
> +
> +	return cgrp_id;
> +}
> +
> +const struct bpf_func_proto bpf_get_current_cgroup_id_proto = {
> +	.func		= bpf_get_current_cgroup_id,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +};
> +
> +BPF_CALL_1(bpf_get_current_ancestor_cgroup_id, int, ancestor_level)
> +{
> +	struct cgroup *cgrp;
> +	struct cgroup *ancestor;
> +	u64 cgrp_id;
> +
> +	rcu_read_lock();
> +	cgrp = task_dfl_cgroup(current);
> +	ancestor = cgroup_ancestor(cgrp, ancestor_level);
> +	cgrp_id = ancestor ? cgroup_id(ancestor) : 0;
> +	rcu_read_unlock();
> +
> +	return cgrp_id;
> +}
> +
> +const struct bpf_func_proto bpf_get_current_ancestor_cgroup_id_proto = {
> +	.func		= bpf_get_current_ancestor_cgroup_id,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_ANYTHING,
> +};
The bpf_get_current_cgroup_id_proto and
bpf_get_current_ancestor_cgroup_id_proto should stay at helpers.c.
Otherwise, those non cgroup hooks will have issue (eg. bpf_trace.c)
when CONFIG_CGROUP_BPF not set.

May be in the future cgroup_current_func_proto() can be re-used for non
cgroup hooks.

> +#ifdef CONFIG_CGROUP_NET_CLASSID
> +BPF_CALL_0(bpf_get_cgroup_classid_curr)
> +{
> +	return __task_get_classid(current);
> +}
> +
> +const struct bpf_func_proto bpf_get_cgroup_classid_curr_proto = {
> +	.func		= bpf_get_cgroup_classid_curr,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +};
> +#endif
Same for this one. eg. sk_msg needs it.  probably stay in filter.c as-is.
