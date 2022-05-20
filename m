Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1535F52F4AB
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 22:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346556AbiETUvm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 16:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353598AbiETUvk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 16:51:40 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53B435245
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 13:51:37 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24KJoIH6013227;
        Fri, 20 May 2022 13:51:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=j8SSzaRSAX3QCWKSjjcQ8Hd6TS4NtEdAq0eXIDwYEao=;
 b=PzaP2mfo8SycVBXkzPcoDHYDZQkR3fq5je6opwk+v4o3YsdNZzhxryaiahGbg5/wEMDv
 GgkBUVkaFjrsuLsMIPiH+R7T+yae8Uevuzr+gax/AoYQqo5TWIJlnjuUA3qOT4JW0U0U
 7i7ntpQ+Z3DMNVtti6RtLWLk7FP8wrMWocE= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g6341dd69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 13:51:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pw+VKbkX/m38FPCPQmwg5x04i1Ix1Tj7e91yV3nHf3AiMCCNezP6WnW40cvFMtC3wwlfR01+8HMx65zLvQmSfXZHZxVI6iBJP1yrXIgCElKUpLEniShioACTTbZ7NZdfXrZAWWCRpT1WkfUqGmVgg3S3lJ7TRcIaa7R7PSXnd0b1CWeTc+mdaUB4g6coKT0ThR2moRuo70srhXpRG/I1/KuSbnGJ9pV7s4O8KtzUDCH6vkfdgA6qKCen1AGXsua0lyx052qbSB7luoZV0WQeS3mm6DkmD0GkXI2rt0KycsGtbXcM1nTQrDPLfumGTa/mc+rjosFL0/psPjesyqesrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j8SSzaRSAX3QCWKSjjcQ8Hd6TS4NtEdAq0eXIDwYEao=;
 b=lxQHVC67Tz2sXYiShESkwA/grv7dOBfM2NAqzHITcNl+2IEKyllkFunztUKj3XtFAap4/n11e9ajPIJIvvEwU7XaErQotAh2oMfWLpK5aw4r30Q+sP37liHYbpvmuERXrYtDSVg7o4Kvmvwv08XWa91RD0Qms9ApacoWSi65PztCii8X+hR7weQ0R/9stVU7pmv57xlpdNH0wETgCqZRshUeRv3ESQEm0SuSwrQHqjRiVBvOhHohuDyiE22arTpOqCutZ7mAHg2mC5UR7ZPU91L6Fi97qS45gNBFEQKYTIe0c6joPWPhOAf37Nxap+q/fHaQ0/MT4YYwNX+Ydk0U3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by MN2PR15MB3711.namprd15.prod.outlook.com (2603:10b6:208:1bd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Fri, 20 May
 2022 20:51:21 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f172:8f37:fe43:19a3]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::f172:8f37:fe43:19a3%6]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 20:51:21 +0000
Date:   Fri, 20 May 2022 13:51:18 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v8 1/5] bpf, x86: Generate trampolines from
 bpf_tramp_links
Message-ID: <20220520205118.cw6g2ozxzub52otf@kafai-mbp>
References: <20220510205923.3206889-1-kuifeng@fb.com>
 <20220510205923.3206889-2-kuifeng@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510205923.3206889-2-kuifeng@fb.com>
X-ClientProxiedBy: SJ0PR03CA0093.namprd03.prod.outlook.com
 (2603:10b6:a03:333::8) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b7ad02c-f08d-41c3-680c-08da3aa27eaf
X-MS-TrafficTypeDiagnostic: MN2PR15MB3711:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB3711866325E07EBFC8C49B84D5D39@MN2PR15MB3711.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dUlzgHs8CQbz2VMlpMEVQQYvBDbYP6QUN0KmVYQFLK2AGoEU7/ekPq1v5GVP44Jj675a0wuBzz5EiCTqQNlPeNJDx8Y/G/oOkktK56JvOy+TONyHRGnPa89vA8paN+4qLzKKw2xu/WwNX43jeFi91nUt0LurLjxPEzWS9rjfzX2en+SKvxHGQyoF3vd+RGWxTuVu8UPh5dINnr6Ou57eMiaBwRlOPQjpgMENi7U1erESqcw0+JLSsxDz0/HPA3h8Bisujq+RcnLQLVrubAkpbhzYzY3flIvAt5IsTHqXOIBOA8Jdakt9Cc/X2ewxznm3KEg+q2dkS982xkt/NkRNwbROQlEe1bUhcPNIPHpcfwyDD6eyWrqoy037CX6z9l4pe7jlJCF0fj56I/4hizX2tTY/7JC8axG5RiOCI2vgxknzr3qYQIgYHvIEsuRZAK9ZIraR4oSh1GgJDCHS8eoAqGmW0l3k/J1PMfu9PA5lHxiL19k77V0TIeuYawfXqDrl+M6XjSzmeh/w8pn08Fc9pT9MMcwzl1ARJ/w5qjnXXQFtYgpd6zpYP5MaiA/YzrIvlzTkh8DKTMrOzRSnK5vtijJv32zCywH7rLd/58BuGOvJktUu7TrAOAdTAt8AzuVRVMWXVI/LdGKfDkQKUCDmCA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6506007)(8676002)(6862004)(66476007)(66556008)(83380400001)(66946007)(6512007)(4326008)(52116002)(1076003)(9686003)(33716001)(6666004)(186003)(316002)(508600001)(86362001)(5660300002)(6636002)(8936002)(2906002)(38100700002)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BvCaSkiZq5aJn7MqniAEEUMsSHqWOE8Gq9WY30+op+MpzRtrMYrL8Jmvjzu6?=
 =?us-ascii?Q?eXhOee+X0W7Iq1J5LEEuR2W/c5o6yePf2Q5z32ABiJixH339659YIpYkwXBT?=
 =?us-ascii?Q?ZCp0+1Wq8AjV5zI1FjvXk7vLc4mAML561O76jSY3r6ffTYUr3UTUaOM2akDe?=
 =?us-ascii?Q?HmDje9/7gWM4+8vT9qqEM49HKks5+8EiUGzvZA858z6zrReb6dYhOZlUkOaQ?=
 =?us-ascii?Q?9j+BB6BRESQtucmE+5Yh2FKyVvFfN680npVIrakQFvlUaODHD0LrSKBGc9tI?=
 =?us-ascii?Q?gTr5jw20thasrr4PkFX9CSU2UWKxfUqJIiGGZ1nNFnM9OKfTK5umx9edH1XU?=
 =?us-ascii?Q?EtyLLnqjJR2zOcrGsQT7IXpM8x7N+k+YXZfgcp6/jtHF6U78azKfVRFHOxbc?=
 =?us-ascii?Q?Wqs2Jm8bd/uc182zGshPJ5GXKYVgv8rbpumW9xEZovaYfMCBIluHQdVaigqN?=
 =?us-ascii?Q?dl3x9I2y5i13RI3MPe1XwtfQL8vzBDrsg6V0HpRwKWSOj3K0YHZjwgGyKfga?=
 =?us-ascii?Q?+6aJZUjHXFu7JPPHREI8JLaoCjNqBH1w02w+tDpTc51NPxRZeFoyoJDhpbu5?=
 =?us-ascii?Q?gc4F/cw60ZkNxv1G6PtzyKZF7tPlSI9Ha2/ETfGur8fGN6UGypQLK8WrngUW?=
 =?us-ascii?Q?dBLnUG8sfZeJ2fqbXTLl0/XYSM3CLVMUp5jdcY3NlyBGAnOiwpC1Pqli+E3a?=
 =?us-ascii?Q?avOuayaYoU/ps9f1CbJTtA7PrHES2eZkaF3f4RK++aCbWGYWETvStsdqlw2A?=
 =?us-ascii?Q?utHS5e7hfRM6Mrt4D0XS3luhPTKeBj8jsgC21kciLa+Sjqc7jgs7TxsYXrtH?=
 =?us-ascii?Q?LebsCbU+Jw0FJCzEM3uzi17ea5pPdZAJmbtmL0GC7E9QQ8mGdKmcyhKECDN6?=
 =?us-ascii?Q?/j2LV2gxivTG2NXb2Tle4E86eagLBoos0w+x7yIa7r9jJiMVYDT76xahKsjn?=
 =?us-ascii?Q?Cuw2QFKeoehQhwfHmgck2g29V1FyYto0IHcOYALexaImcHgVTHggYNNJsV10?=
 =?us-ascii?Q?OoVeD5zvT9i+oHCEpCrHva+xOVyv9fJ3eUz/VPFBocNYRaihSsiysT1lJ7ZI?=
 =?us-ascii?Q?OTie6ZXZmVYdEhgVxuKZtUxMsCgF0eKedUoJkfQreDQ0zohTvXUaMjkBBYEs?=
 =?us-ascii?Q?vhYZG5RxAj7dlyunpduxHadTxtgsr8ohWCvyIQ4UxIEME3g79FHwNHXTHM+0?=
 =?us-ascii?Q?8Axq96Zrsmmz59aL24KwOaJqybT0lz6zgg9DliDMFnOBCS1/f4J0DiuPfZrN?=
 =?us-ascii?Q?PnYTeehOXAP2/cG1D55vWBCRJquta4iwNnZUXpDssr2IfjiIffdfO80ZbaSY?=
 =?us-ascii?Q?TJ7yDhLdFlcCW77EWVCaPv03rokrcqlQGm9qLtkXuGCeuRVkRcDIY9sjMyps?=
 =?us-ascii?Q?V0I2iFHKqlqn51dbMTqHPV5h1S0YIuM19S67sTEyeO7xX9mi13BINILj12va?=
 =?us-ascii?Q?GnMhbPz4SPoGb+FxZ9gNl7lS36f174XjO/vU8Rud2byhEDJwQAflvcxMCy8E?=
 =?us-ascii?Q?ERV16OGxlJ9QK1YBUFXbbRzZh9xnaOOpLe2dxCYb/AkjVoyp9G0n6YBUimjz?=
 =?us-ascii?Q?Fz35ZM2TwUWA+MzGC3gm3HCzDQ0c6hEExtXFn2klBaJBj4Sh+9NW4vC5M/qH?=
 =?us-ascii?Q?s+wNgWJ1hagcboapCdmddFUoeYHtnU00sgbvvsBHiXlThtVM8L0K7ivT3GIg?=
 =?us-ascii?Q?Hb6vNeqIfCMsrU1lCsK0qOUUzXDmr7ISfhs+2y6JBVIznhNWRlUQQzqrp7ZW?=
 =?us-ascii?Q?oyLPjJ0G+FGwMyNFcnaerxrVzAyWFf8=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7ad02c-f08d-41c3-680c-08da3aa27eaf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 20:51:21.3071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0T/h0+qJI/qIH2eHewL01HxKhf7tEtPlBwFr1nJhxBJ0APWWHo61iHoNvCM/GZk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3711
X-Proofpoint-GUID: -gofDQ1tJhNdnsPnXwDP0gtrNotcKaqP
X-Proofpoint-ORIG-GUID: -gofDQ1tJhNdnsPnXwDP0gtrNotcKaqP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_07,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 10, 2022 at 01:59:19PM -0700, Kui-Feng Lee wrote:
[ ... ]
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1013,6 +1013,7 @@ enum bpf_link_type {
>  	BPF_LINK_TYPE_XDP = 6,
>  	BPF_LINK_TYPE_PERF_EVENT = 7,
>  	BPF_LINK_TYPE_KPROBE_MULTI = 8,
> +	BPF_LINK_TYPE_STRUCT_OPS = 9,
Sorry for the late question.  I just noticed it while looking at the
cgroup-lsm set.

Does BPF_LINK_TYPE_STRUCT_OPS need to be in the uapi?
The current links of the struct_ops progs should not be
visible to the user space.

>  
>  	MAX_BPF_LINK_TYPE,
>  };
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index 3a0103ad97bc..d9a3c9207240 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -33,15 +33,15 @@ struct bpf_struct_ops_map {
>  	const struct bpf_struct_ops *st_ops;
>  	/* protect map_update */
>  	struct mutex lock;
> -	/* progs has all the bpf_prog that is populated
> +	/* link has all the bpf_links that is populated
>  	 * to the func ptr of the kernel's struct
>  	 * (in kvalue.data).
>  	 */
> -	struct bpf_prog **progs;
> +	struct bpf_link **links;
>  	/* image is a page that has all the trampolines
>  	 * that stores the func args before calling the bpf_prog.
>  	 * A PAGE_SIZE "image" is enough to store all trampoline for
> -	 * "progs[]".
> +	 * "links[]".
>  	 */
>  	void *image;
>  	/* uvalue->data stores the kernel struct
> @@ -283,9 +283,9 @@ static void bpf_struct_ops_map_put_progs(struct bpf_struct_ops_map *st_map)
>  	u32 i;
>  
>  	for (i = 0; i < btf_type_vlen(t); i++) {
> -		if (st_map->progs[i]) {
> -			bpf_prog_put(st_map->progs[i]);
> -			st_map->progs[i] = NULL;
> +		if (st_map->links[i]) {
> +			bpf_link_put(st_map->links[i]);
> +			st_map->links[i] = NULL;
>  		}
>  	}
>  }
> @@ -316,18 +316,34 @@ static int check_zero_holes(const struct btf_type *t, void *data)
>  	return 0;
>  }
>  
> -int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
> -				      struct bpf_prog *prog,
> +static void bpf_struct_ops_link_release(struct bpf_link *link)
> +{
> +}
> +
> +static void bpf_struct_ops_link_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_tramp_link *tlink = container_of(link, struct bpf_tramp_link, link);
> +
> +	kfree(tlink);
> +}
> +
> +const struct bpf_link_ops bpf_struct_ops_link_lops = {
> +	.release = bpf_struct_ops_link_release,
> +	.dealloc = bpf_struct_ops_link_dealloc,
> +};
> +
> +int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
> +				      struct bpf_tramp_link *link,
>  				      const struct btf_func_model *model,
>  				      void *image, void *image_end)
>  {
>  	u32 flags;
>  
> -	tprogs[BPF_TRAMP_FENTRY].progs[0] = prog;
> -	tprogs[BPF_TRAMP_FENTRY].nr_progs = 1;
> +	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
> +	tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
>  	flags = model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
>  	return arch_prepare_bpf_trampoline(NULL, image, image_end,
> -					   model, flags, tprogs, NULL);
> +					   model, flags, tlinks, NULL);
>  }
>  
>  static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> @@ -338,7 +354,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>  	struct bpf_struct_ops_value *uvalue, *kvalue;
>  	const struct btf_member *member;
>  	const struct btf_type *t = st_ops->type;
> -	struct bpf_tramp_progs *tprogs = NULL;
> +	struct bpf_tramp_links *tlinks = NULL;
>  	void *udata, *kdata;
>  	int prog_fd, err = 0;
>  	void *image, *image_end;
> @@ -362,8 +378,8 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>  	if (uvalue->state || refcount_read(&uvalue->refcnt))
>  		return -EINVAL;
>  
> -	tprogs = kcalloc(BPF_TRAMP_MAX, sizeof(*tprogs), GFP_KERNEL);
> -	if (!tprogs)
> +	tlinks = kcalloc(BPF_TRAMP_MAX, sizeof(*tlinks), GFP_KERNEL);
> +	if (!tlinks)
>  		return -ENOMEM;
>  
>  	uvalue = (struct bpf_struct_ops_value *)st_map->uvalue;
> @@ -386,6 +402,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>  	for_each_member(i, t, member) {
>  		const struct btf_type *mtype, *ptype;
>  		struct bpf_prog *prog;
> +		struct bpf_tramp_link *link;
>  		u32 moff;
>  
>  		moff = __btf_member_bit_offset(t, member) / 8;
> @@ -439,16 +456,26 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>  			err = PTR_ERR(prog);
>  			goto reset_unlock;
>  		}
> -		st_map->progs[i] = prog;
>  
>  		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS ||
>  		    prog->aux->attach_btf_id != st_ops->type_id ||
>  		    prog->expected_attach_type != i) {
> +			bpf_prog_put(prog);
>  			err = -EINVAL;
>  			goto reset_unlock;
>  		}
>  
> -		err = bpf_struct_ops_prepare_trampoline(tprogs, prog,
> +		link = kzalloc(sizeof(*link), GFP_USER);
> +		if (!link) {
> +			bpf_prog_put(prog);
> +			err = -ENOMEM;
> +			goto reset_unlock;
> +		}
> +		bpf_link_init(&link->link, BPF_LINK_TYPE_STRUCT_OPS,
> +			      &bpf_struct_ops_link_lops, prog);
> +		st_map->links[i] = &link->link;
> +
> +		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
>  							&st_ops->func_models[i],
>  							image, image_end);
>  		if (err < 0)
> @@ -491,7 +518,7 @@ static int bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
>  	memset(uvalue, 0, map->value_size);
>  	memset(kvalue, 0, map->value_size);
>  unlock:
> -	kfree(tprogs);
> +	kfree(tlinks);
>  	mutex_unlock(&st_map->lock);
>  	return err;
>  }
> @@ -546,9 +573,9 @@ static void bpf_struct_ops_map_free(struct bpf_map *map)
>  {
>  	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
>  
> -	if (st_map->progs)
> +	if (st_map->links)
>  		bpf_struct_ops_map_put_progs(st_map);
> -	bpf_map_area_free(st_map->progs);
> +	bpf_map_area_free(st_map->links);
>  	bpf_jit_free_exec(st_map->image);
>  	bpf_map_area_free(st_map->uvalue);
>  	bpf_map_area_free(st_map);
> @@ -597,11 +624,11 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
>  	map = &st_map->map;
>  
>  	st_map->uvalue = bpf_map_area_alloc(vt->size, NUMA_NO_NODE);
> -	st_map->progs =
> -		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_prog *),
> +	st_map->links =
> +		bpf_map_area_alloc(btf_type_vlen(t) * sizeof(struct bpf_links *),
>  				   NUMA_NO_NODE);
>  	st_map->image = bpf_jit_alloc_exec(PAGE_SIZE);
> -	if (!st_map->uvalue || !st_map->progs || !st_map->image) {
> +	if (!st_map->uvalue || !st_map->links || !st_map->image) {
>  		bpf_struct_ops_map_free(map);
>  		return ERR_PTR(-ENOMEM);
>  	}
