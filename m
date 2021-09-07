Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3730403106
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 00:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346386AbhIGW0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 18:26:23 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43358 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231891AbhIGW0R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 7 Sep 2021 18:26:17 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 187M8XWI032219;
        Tue, 7 Sep 2021 15:24:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=P9XfGMUa0yrgROkwrpjcMHpK5wCna8miu5V/b3h+XeE=;
 b=YcBp9mO2n8WU6eVcOvEvCAsnjg1kzFm2iLwUAboxas5ugJ0/TQSoWny8WovtYRTAVpeR
 LmvDf+1lls/cNQRnNrJ1LxD+codNc7X0D+m1pBkUR+N9lzb7ct8ZrqfMPkTWMQAHhBqo
 ZK7cm8dAHWzb0Ggo3+p/EJp9+OdVfejUAzk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpj1mtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 15:24:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 15:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXuEO7UlRRaylKVhcXJb06M2Azy12KHXUopbreS/3z/zm2Y5dkYVVDBxPEknU1seoGERfcRbgS5Ghnw7kAwZCr433sznqJfodacQmngmiRiJxz6IgCCSDQneUyWg0G8kgcEgWPSUCFIWZSW//0aS2xnRLSX9IlQfOAgvJjPpDqJizmdBlQczyoalX+xGtdYFLJcj5tRISP1foXbGMCmJpmQG4PE9NwEq3z6ABKbZHV0oefZeHUhEhIjfvs2uz7+UfnkNl1YFama21rvynw5KWtBV/Q6yqNYrp6IM1MYXLBWMslV37kzvavMcQceSqqXDN/qFY+0JWv0RzRWykKfhyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P9XfGMUa0yrgROkwrpjcMHpK5wCna8miu5V/b3h+XeE=;
 b=ZghUV0eSULUndv8Z5PnEAvOQwNYgbccvcyy0SYrLN/e97Lj4NsVAvwRrypUMpXn+dqQuG8LUERH3puyF4yRtHnhbwOAvy7nerxqvIn0YAOkiCsI+SP7iI5rtW/G70cSjrKb34MRCqUBVSUh4pH/jOCEZRr4UZS3/Sk3moruMF3qTH2CglPSjObIWwJQv6+CX1hIukf1Ek+b6P6QuMT9mpn/uKR6LOcaz5mJDyy57HNyuWvRkM9SB8uOwXm6hB90P9m3WdXVdlzkJ0RmXuhMw21LDAADaN2htOoEXdBYj3OgnbI6n3Wt96rSzxaVsUXrVbuQpVlfJZwsIr/YP4HpbDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4354.namprd15.prod.outlook.com (2603:10b6:806:1ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 22:24:46 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%9]) with mapi id 15.20.4478.026; Tue, 7 Sep 2021
 22:24:46 +0000
Date:   Tue, 7 Sep 2021 15:24:43 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     jiasheng <jiasheng@iscas.ac.cn>
CC:     <bpf@vger.kernel.org>
Subject: Re: [PATCH] bpf: Add env_type_is_resolved() in front of
 env_stack_push() in btf_resolve()
Message-ID: <20210907222443.gygy7eohzybpiq47@kafai-mbp.dhcp.thefacebook.com>
References: <1630564633-552375-1-git-send-email-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1630564633-552375-1-git-send-email-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: MWHPR18CA0042.namprd18.prod.outlook.com
 (2603:10b6:320:31::28) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:f6c2) by MWHPR18CA0042.namprd18.prod.outlook.com (2603:10b6:320:31::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Tue, 7 Sep 2021 22:24:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b06acb0-26a1-4b52-039d-08d9724e4bdd
X-MS-TrafficTypeDiagnostic: SA1PR15MB4354:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4354A810CCD43E41445E49A3D5D39@SA1PR15MB4354.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TP7ik0+0oDtbd+VjsNkBljmX1qrti9c0Nt6xENZBDcp0nIdQRlCLAkmAEGwULMVe0UYMxSNUdDxwl2iDSU4wHMDkR1WzsqU7dykfLpkW15RvR32QBuvoY8kbqI+29FMod9pW4iVjRdajYHJJCTq4n1Axy/Y1HTzk5g53Lxj9go/d2pJp1rShqGzQyY2vNk2Y8Dkl911BsVwaKlT912gZO0Elr/D2uYKl3dZTnkik3sOMs60DD93S8Ha0zmtxTqyM3aqw8CKmMjT6OEvCfxpPag06ItdApf2iVqAcB2P2vlX6AR2T4hYwFBaiKOzdgDyIPFqWhSvcb3nBMU44aEbVBshcCWLlSOa2hV0yZHTwDvULi7SlkOkLYZNX/2au/pvKTyzDUIAzZs03rA2RxNmduMy39SG3tMUVZdIW0nwYKCnLXEJxVRPCvPvo/muhvHT5C5LKcP8TChTGruhJmrEAdEfSlhfhCMOwd7JzW3GO9hrUEE4ct3Xi8zuNFxPQikhEzXzhyo4YLMdGOG/mctg8NrpaxGTt3wzUf8Y6Q0WwYu3kXwNWzmWfeGC2nx5SpW6mN8h1z3khi0QqUBl2duw7UGKHiEFNf3/dceMokL1EqDeijX8HBRXeypTpXB7yfgL3k5+Ts/A1fMi32hSGeoEISg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(8936002)(478600001)(83380400001)(4326008)(5660300002)(2906002)(8676002)(7696005)(1076003)(316002)(66946007)(6916009)(38100700002)(186003)(9686003)(6506007)(86362001)(55016002)(66476007)(66556008)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eH6jhcL1Rzn1bfpkfxFHRzbnecNXwYMfd8/xfz/NTuylGQtUupAA++wpgh6t?=
 =?us-ascii?Q?oGiAtA/a4bNUxe9Lg6B3hetpn3D6o60OsHlAzbnBnGgRIi9ElddvMGnGN+Bj?=
 =?us-ascii?Q?ilQaZps2Zg/PtrFO0/Rm4E2U2wVyIHI9HOQMZSjOFVri9GogAR5sX4DJVCII?=
 =?us-ascii?Q?mmrh/Z3dU23nI6Gj+8ZhHTiDx4rbuhjJPc65voThLdKE+UGUJzzKM/VRk0sf?=
 =?us-ascii?Q?68MGp5RdqQUEi11C2T/TZLChnmabw4stiRrFIw/9jXSQ1XFp4wQYxWU7QF50?=
 =?us-ascii?Q?dKZvvulaEgYbNhjkvxfB2buTr10IZsHZHHJhHGbIOdjtjJ04a1t0prMCPnMO?=
 =?us-ascii?Q?6lA3Fwn9tmWOnpfvcLRmXslpt3b06Row6Lv3LLdio7eGcOAhfKPjeDB33z1L?=
 =?us-ascii?Q?Fs6E2EUO+9CDDLdwJhgMNlfsRe0oBdORgRBtoGtizasMJtzB+ciJugif+a64?=
 =?us-ascii?Q?kbVAfh5Vxnw5J0MuAkLKwHOBawJkVJfBZhet+24VHp+jaMJ/o/Ib9YobUHNb?=
 =?us-ascii?Q?6yUo/WMXIfVDJvqadd1eeUuF/w00JRm649FwsjxHShV7c97bKyBiPjKjBxgU?=
 =?us-ascii?Q?0iHTRJXeB9FzLGdL1bJDck16wYFpwl/GPtEMllM2E5P/CGxn3RUC8SC2O8nx?=
 =?us-ascii?Q?uFilMwGQWAMGCwaomqsLRTxPlIqWwcNAy2kZv48La3M1dTlu/L9bkqQ43Wbe?=
 =?us-ascii?Q?UH/OVQFKf+2dRMJIKUhgTkPkxZ708xKanngK6uKWi85t9PPBH+d8VKTVBlh6?=
 =?us-ascii?Q?zyR1XYRmfk/ATPKgDKPx7zpGlArrh8s2MW4vhIXQHQMYFsGEIH1vbtJn+ttH?=
 =?us-ascii?Q?TiEfy6/NQf5LaWqTv6hbtGsa+zgyf6CVdP4E/lHzu+oT8tQCznEieelCObmY?=
 =?us-ascii?Q?zRYm69BS6mgY/k5fp30L+huzpiIY7qvW9Tr/F4MlSdXoqfEfOjl2kt/pGUCz?=
 =?us-ascii?Q?RCX8nzpYYNDXgpc5/Hw25vnqTZcgmZlOaYmoG5cPoTovVtfyBSU2CvEFS4fR?=
 =?us-ascii?Q?4n80AolUrwC060SYMNQ0cGehu4sCDIOSli26dkkCzBhJ9DZ3qFaTXqmnJ763?=
 =?us-ascii?Q?gp5P5404ZVaAi8GJ75UCry8KTWCc/oSaDSX1QByGZ6bywaqEpPnyupTm2q+Z?=
 =?us-ascii?Q?WumOPfSlsAEl0yv7cSsHri4buwIE4vXjzEJIwU3TnRtFZR4mcYg5yY6EqF1E?=
 =?us-ascii?Q?aThFX7Eir0sBSgbUQwy1PCRhuXk1+f17evcwQSV/gVZwzZipXiTPbNz8lKsW?=
 =?us-ascii?Q?+xbj5/BCSbAHLhRqDmfq/pRyObBto/gwKxTSJPMWFbd0fEBKt1A6NEM0UoCZ?=
 =?us-ascii?Q?UbtDrxEOytLThVdJkxhimste2GDN7lwvy6SmlsD45n/kOQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b06acb0-26a1-4b52-039d-08d9724e4bdd
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 22:24:46.0176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ps06YFAruDRKiQP639N71wtZXO2Pi5GCJT0kB14wAFBoQPCtYW0vFS4B70lnn80
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4354
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: bz6ZXjAQzr9tgz7B8LPWN4FBX-VaPLAo
X-Proofpoint-ORIG-GUID: bz6ZXjAQzr9tgz7B8LPWN4FBX-VaPLAo
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-07_08:2021-09-07,2021-09-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1011 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109070140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 02, 2021 at 06:37:13AM +0000, jiasheng wrote:
> We have found that in the complied files env_stack_push()
> appear more than 10 times, and under at least 90% circumstances
> that env_type_is_resolved() and env_stack_push() appear in pairs.
> For example, they appear together in the btf_modifier_resolve()
> of the file complie from 'kernel/bpf/btf.c'.
> But we have found that in the btf_resolve(), there is only
> env_stack_push() instead of the pair.
> Therefore, we consider that the env_type_is_resolved()
> might be forgotten.
It does not justify a change like this just because
one of its usage looks different and then concluded that
it _might_ be forgotten.

Does it have a bug or not?  If there is, please
provide an explanation on how to reproduce it first.

> 
> Signed-off-by: jiasheng <jiasheng@iscas.ac.cn>
> ---
>  kernel/bpf/btf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f982a9f0..454c249 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -4002,7 +4002,8 @@ static int btf_resolve(struct btf_verifier_env *env,
>  	int err = 0;
>  
>  	env->resolve_mode = RESOLVE_TBD;
> -	env_stack_push(env, t, type_id);
> +	if (env_type_is_resolved(env, type_id))
> +		env_stack_push(env, t, type_id);
>  	while (!err && (v = env_stack_peak(env))) {
>  		env->log_type_id = v->type_id;
>  		err = btf_type_ops(v->t)->resolve(env, v);
> -- 
> 2.7.4
> 
