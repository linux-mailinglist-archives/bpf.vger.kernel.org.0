Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A0057B06E
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 07:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGTFkx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jul 2022 01:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGTFkx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Jul 2022 01:40:53 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FBA3C8C2
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 22:40:52 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1S6vk009207;
        Tue, 19 Jul 2022 22:40:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EITZDxvEJdVLdYdTF6VSJKQgFqCingIQa4G/cRfQr7U=;
 b=UwEbguV4CxCA4i4QHSMxtD6Wq4qMyoF46MNuQgNcr+nMiB+cF92uYqyjMh+e5eGLTDRr
 DzJ66uz72T3AsBx52iLowPnJhmVHZzkV1hPk6TflmYcfwkW7E5/Jq6A14BQNASNEZJCf
 ZdvfQhr/LOtTwVO5aB0dwgCUtrXa2JeTbQM= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3he82dgu6h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 22:40:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvCXNXieMawk7LqJVe8iVEzfOOHMxLxCD2yCn7Fp8TKALYx/raG11wMuQfP8qWgLebiezgme1jQnvwNJPl1b8mFrQUYFk50zrSkpTw97U3lfJUscdD2q4uqb6FFMfrguGloyiyY3knBH4L1B8EzrkGTA41lyuKE57FxOnsnR+IeycafExXRlMtpsIwrklYW0f/XiO6sJtOiDLKfjKT2sAS1lY/rBiYzWvQrSOfldkohVhcterr3ycrs4gmCOQXJNO76Fg5lAdK3xakolhQISm4HEZ54ox8OddEo/7p5N/tU1X3ykhjl7gOvl8tBRRk75ogedsLI1pEfNqBbe7efxPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EITZDxvEJdVLdYdTF6VSJKQgFqCingIQa4G/cRfQr7U=;
 b=RYK3EkIZKwHVoYkKAwQweXWMianjjhNG0sb42imtdPG9sTpBYGDZSRqjv4bApuror7XVzuiAV+qlkXQ5TkGL2+uQMEJ8AZ0PPx4tHwqFUuuhqx3TFKoP1tcc6gHzewXKaoKZv8uiL254BPKG/FzBENUJAZ+gUC5DzE8YrOe6xcRIKhcEAjtCl8YK5GKRXrkO2hvGynswIhKXIB4eBtsEqTxGp9k4S/RMLhVkjx21y/RaebtScYfSB55P9f8dapWnDGe6SWKmU8fZwqubCllSUV+QUc88OiBmxk+8qyuqujudFT6XKnHKP1yN0wVBsk33bfyfOINxjq6ivV8oz4ZR1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MN2PR15MB2943.namprd15.prod.outlook.com (2603:10b6:208:ec::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 05:40:17 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 05:40:16 +0000
Date:   Tue, 19 Jul 2022 22:40:13 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH bpf-next] bpf: fix bpf_shim_tramp_link_release ifdef
 guards
Message-ID: <20220720054013.tqe5fmhcbow45am6@kafai-mbp.dhcp.thefacebook.com>
References: <20220720034954.3032878-1-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720034954.3032878-1-sdf@google.com>
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d2c8e42-e925-48c7-dc38-08da6a125322
X-MS-TrafficTypeDiagnostic: MN2PR15MB2943:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4SWhpa8MAF961iSyZFn3qIE7Gur2AMsUizIR664S5YZTHpfpUZgvEeNenzwLazlbJUmguX4EH63qizIOhSnaJ7zacSrVlAPhv3l8e2US2gdZmvMKE2G4BfZ9WOo0HFObxIZsnfugtp1+9+F2rVNPMOucFUPiyZ9a0UY+9yggymjL30zpzooOaDsfkJUWGPsTFr5MJbPpppv7DrX1qyTPmIMiIzUWVBkd2cJv4kWE58KLCZnT6/GQN+P4nMlAPYDl+ZUwURCpXwTHTP0XX6K5mG878YL9G52yYzu/E/ErnV9Rx4aP55V573PKDWFpL7P+c01kt83HQoBQ0Fe5hVUIvcwXJ9sXrzLicc1haljp5KKXuF906YkdTaJpgt5V2Po2iXCBNhv2ma5fxmM5G4tWvfRFhIM5Rr9hh1Rhv2W43Y1EAcqbOvOxzEmpCgDtnqAUBxtQRKAQa7cOvivxZ3pqm5hmjp3IZ0IzAbz9smTsjZzit6FKIQBBHt6FkEauJ0d9SVlHoGLSN7cARRK+l7Rg5fktW7cjl0F0HVUT8DbSl+MlbpHJkaXJotNdbdO06ezlnN3259TklO1zqV6PlCZ6ipKJQlw1Rgj1tbG1+czVDaEwSNu1d0NGxrvDaSo0ZWfEEQGCtRwY29QJ68VIEvsaryqoRn5YlH3XDE3UaxHzGSVG9azyrUU1ND205G1v/4by4hBtPhaCCW03bQ7ls2bYQl1od6fJSZJACvPqYM3n8MmSUDvFtm0nWbfhAGAQHiYk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(41300700001)(6512007)(52116002)(2906002)(6506007)(38100700002)(1076003)(83380400001)(9686003)(66476007)(5660300002)(478600001)(6666004)(6916009)(6486002)(186003)(8676002)(4326008)(66946007)(86362001)(66556008)(7416002)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m5DbYXGPz6UY05Kb/xKkf5I5/X6GPKGRiAORo7bk/Chsir+7ynr2BEcsBHpS?=
 =?us-ascii?Q?iGMVXH6AnT23iex1lszi555ACgg7jo6KdugZr4ay0/wv+PpdDV8V4z9iR+zU?=
 =?us-ascii?Q?mAAlZmdGBJGvObaoSdGOSu9ScFuX0xoOmPAYQjyNs3H5c8MSDQHVAqVgpEi1?=
 =?us-ascii?Q?aw/kskD3NScVRdJ7asKDx+dAM3LDqwr14jxkuvmUz/8+OjOlvXrYHYs/+tdc?=
 =?us-ascii?Q?669gESywbp191VziMgD2tXQsLemnlJDzMeKKHwy7m9Pkp1hs6+aACJTLhQyB?=
 =?us-ascii?Q?XyXjY69OgLy00lr1pkXrH0aQzLsj1p5NZMsf9YOTnM5iQfu3WnL/Ixey+8WO?=
 =?us-ascii?Q?soUr2dHI3g6rQSNsklppAwoPnldF6Ui/irpFFx50QrH9fUyc0VzdgP5dwWlL?=
 =?us-ascii?Q?gZLq6wKh1boThVMYuBNEfM6akl2VUyg63kxXAG9s7kM4zEwbTmtiKXqzlHHO?=
 =?us-ascii?Q?ohBHdVHYP0EJVk7T35jBzkf1o0wwzN7YvO1ia75Dxi1ZsstqVzqpA6/30kAm?=
 =?us-ascii?Q?qNP6AN/gmND+3llsQMVBA87lM0Hzr/fODdTRvKEIVyK2Z0bJslWhzq8S3T0R?=
 =?us-ascii?Q?2WB/xxq1tfqbL/4Dds1ok7QR3W17Ftjdo9D3B9Z0Djxzx60b0AJ00QvCRpwR?=
 =?us-ascii?Q?HMTbwxb4HshD8zpVsmYx2vrjBH2nRAPXSJkX0zPuNxBsp5jCOWJ+OP2eASRE?=
 =?us-ascii?Q?HpcL1WvYt37g5hRqZufzmseoUZ34e65cxaI96ttV/0mf4ogFrVXzqEARXOrT?=
 =?us-ascii?Q?d3nkXrFjG+iepgOVtgql2u7J0YgCwFnF4HVV3hwhY9gZTtFuK0dnlTvmZCYq?=
 =?us-ascii?Q?sEtmde1u6A2NEqGN/kUH8+PladkJMEJkydp2A0IpZonmHOlfM/R7bQ01+NWr?=
 =?us-ascii?Q?+8WgfOdM4sa1+ykxeWYS4WkOtMvLLeeWqu0JTALp6iHjmohqyX5NMeJgQptp?=
 =?us-ascii?Q?mZJNxNCAe2CCGaZvL7ATC+IRCCKIDF68/YCR49b1vfqXOvekyToE6y+qCAHv?=
 =?us-ascii?Q?kiBsAJ4Y91gDXFG+r5Axyqqxr3VLlpamioaIwyiyvCoU6oWU/49XwhK4zwjO?=
 =?us-ascii?Q?OVXtti4XQR/L9pXMc8wakEJN25X4nyGI5nrZJ2kRh31Fh2aBkK/nn83pNZcI?=
 =?us-ascii?Q?j9om7lp3zJbJ1H/TWf1NcaF16R0kAYfjr1OeERzYAP1jitXCu6ldoeRJgwk9?=
 =?us-ascii?Q?FVkkSNQbEP/YLCTSTCJ9Fspd+bEn1AHRJZ9vXZs0Jx9OhSEC9Ns0iLh5GxP1?=
 =?us-ascii?Q?0je1ge84Hpe3YRWFAicE5zel0TpRDiWMT/dmKPXr2jU5KxWG2B0uUlKpyVet?=
 =?us-ascii?Q?TLwf1QgF6QAMttAVeqQgNeHnVcuZ5yI0BrU6xfIV8409cbrZYTrOiSX3nOfs?=
 =?us-ascii?Q?LLZXi8y/rVWF730Pyc3ilvLMDsGhkCe8YXCB8WZWVy7HmJEbk2r52jZWgdzK?=
 =?us-ascii?Q?F3910AbBrXErwADSp9vGK2eEf4Kzp2VePa/zUCJvjQ8JrWUGqkpMlDwtI+EV?=
 =?us-ascii?Q?bu2ZB9fx2QZz1Tj2algIFbTjknQD2CPLZm7QjSS945fZ1mR+qSTSKoWfqGrq?=
 =?us-ascii?Q?LpbrSy2JTw7XRdwqEv2Hk275NVBDpZevdH3aZK239VrVEYAbaANvT4CW4av4?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2c8e42-e925-48c7-dc38-08da6a125322
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 05:40:16.5126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDJInYCthKEP4gBky+Lx14HlJ4yvSx01yUSFxkXrGSBt9mV6pEHo7V0TDqGmqco1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2943
X-Proofpoint-ORIG-GUID: Zr8HCq7PEGE9odbZtW-yCoALAOKCqg4W
X-Proofpoint-GUID: Zr8HCq7PEGE9odbZtW-yCoALAOKCqg4W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-20_02,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 08:49:54PM -0700, Stanislav Fomichev wrote:
> They were updated in kernel/bpf/trampoline.c to fix another build
> issue. We should to do the same for include/linux/bpf.h header.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: 3908fcddc65d ("bpf: fix lsm_cgroup build errors on esoteric configs")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> ---
>  include/linux/bpf.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a5bf00649995..0ff033afe0ad 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1256,7 +1256,6 @@ int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>  #endif
>  int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>  				    int cgroup_atype);
This link_cgroup_shim also needs to move ?

> -void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
>  #else
>  static inline const struct bpf_struct_ops *bpf_struct_ops_find(u32 type_id)
>  {
> @@ -1285,6 +1284,11 @@ static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
>  {
>  	return -EOPNOTSUPP;
>  }
> +#endif
> +
> +#if defined(CONFIG_CGROUP_BPF) && defined(CONFIG_BPF_LSM)
> +void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
> +#else
>  static inline void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
>  {
>  }
> -- 
> 2.37.0.170.g444d1eabd0-goog
> 
