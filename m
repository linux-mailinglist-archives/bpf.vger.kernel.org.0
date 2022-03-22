Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00F44E45B5
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 19:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiCVSIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 14:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234190AbiCVSIn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 14:08:43 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D46694A3
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 11:07:16 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22MHaQMW009143;
        Tue, 22 Mar 2022 11:07:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=DHcEj1idaUkxWHXgukbGrDwFZoZo6hJhw6+k10Nkq5Q=;
 b=HuUAhuLhrnXsGNEWawH4c9AxYrzG7pxBekS82t33KyifL/Ai2sU7+DlcWGYmXznAbsJ0
 LrHIeUvg9U4Y6cTGPA5G5IRMhWQIMhWOIrZ7hVJRPd8SA0rvNmu30uXFLzO5dsteKThD
 VRBdx6Pa32VDqNwSToe2OqLlmjWaHk4deNE= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by m0001303.ppops.net (PPS) with ESMTPS id 3ey8q1d0wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 11:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTuLoKhgDFYspfHfJpIu1y+PesKStwksn2eY9D7DpXUfyGVkw0D3RRXdEnD2MpR10nYeXvH2SzfboVPE5nFYT5AN3cpHFStbOVzlQQv6o9MVzfltKmkxT6vIc7XXvwg2hTRinpmZOAwdS3dE+A4EpfayHwaX7fV86fFAJMaUFkTHHE94wyfuaeL8zC16YDF7u/5MSHNiriGG2iocFi0eRhHlwuSOYGCx4DvQhfenHRx8fE4pn5W0MaIekfeSj0l7w8NLpG1u8c6DFYELiktB52bEu9+RMzYWMyQLZ0q8pamfBZELtpsowHUeauLK6/0yN9YgIVFUEn5zNpKkEcyLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHcEj1idaUkxWHXgukbGrDwFZoZo6hJhw6+k10Nkq5Q=;
 b=groZMvLwkQJ2mN3LD+zODnrJ+BC42wq/Xyd8Xr2eYjXIv7K8tQnplKUD7OHcIKetdKExyzIv8JAjwQysfAK7uhXgi5HcvsKbVfxLZqCE6wrkSRrizB4XiCocZA1MuoAVAaM6d3l7nUSTSqgdWzpC29F4MelzUu0CXRZz79G00faDqoE0ocQSOlixikDcM5a0iWJOW791LlUyaZY5BKKXLxwt8+mQP5pCLRstRftlO943jYdSwhRadRcjaXhHx09ey5aQFM0KzQX6solVjk/SVuEssMlJyAbQhgc+AIs63CPGunEtv+7WponZ5+OgBGsKldADvXJqF9+WvnNnMxekVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by BN7PR15MB2388.namprd15.prod.outlook.com (2603:10b6:406:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 18:06:59 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::708c:84b0:641f:e7ca%3]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 18:06:59 +0000
Date:   Tue, 22 Mar 2022 11:06:55 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220322180655.s6m4yzpkmvgfnk7z@kafai-mbp.dhcp.thefacebook.com>
References: <20220320155510.671497-1-memxor@gmail.com>
 <20220320155510.671497-4-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220320155510.671497-4-memxor@gmail.com>
X-ClientProxiedBy: MWHPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:300:116::15) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cbf2c5d-f1be-4429-a86f-08da0c2ec1f5
X-MS-TrafficTypeDiagnostic: BN7PR15MB2388:EE_
X-Microsoft-Antispam-PRVS: <BN7PR15MB238835B5FB46CA0DDAFE6036D5179@BN7PR15MB2388.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6c9p0vMDzH2bu7uXb4vLoNl8++ArBrS4GTSrCjjE/eXNPUClEXWI+jIjVUm6nDzlQ4x9F3gP8mZZQBgms06+kWzVrtpWGn3V95Yp6+auhnpOKAPG5WGrkhkb6bcb3zYhzo+chU6jEuVGva9OjtRNSWTke6j4YanbBeoo5mk8PEiEQOKJd1HG+sm94ewIww2AJ4jFesv3tSE+K5Fm9EePhM9kcaYrbKO1EqInVebrWPiF0NZtbGpIjDaQ0nbLLY0Vs5MPxuUi+FRJiJy9w1CzzR0Wcj6K62682HEXn9YvOvAK12BKYYfnpyo59nAXAgPpoMLDMSDm5phWxVA/G1KzK41QmbGLI2MWIBn4KWDusP76XU68trfm7ToEZopDRcXGey5ZZ0YrYQOiSuZUv+OTR8zNXp8GwuaAdZ9ZeJwrY+WmKjsrtmazd1JLpcOvbL8/MtVa7pJ/Q9TbUYkV8TdjOBFWS1kDsv9nNbXeStahIu+8Kh+yWGSeX7k0AuOqZ78BmnShoY3gDNJOQohAm/fMNhlsemDhIHtOrxaU6EZkv5es3+NslF2gDlDsIiABdhGjXr3xTyLM5u/oIIG1aAsoWKTrz0d/S9jiR09UTg7AF2Lm62hXNa3ju7SjpgJp+UkhebMyVKfn+xgT15PXsDu1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(6666004)(54906003)(6916009)(316002)(38100700002)(52116002)(83380400001)(1076003)(186003)(9686003)(2906002)(86362001)(5660300002)(66946007)(8676002)(66556008)(8936002)(66476007)(4326008)(508600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W/ZnIoWwYJ/pqmVcbRJD5URztWI78rQWGFUyZNRdLbki1ziVk4860UbFfoHv?=
 =?us-ascii?Q?g7oIu3KIJLY4zRRHvPa2qJfRoaVGYsCZEaiQ/SGn7qNM+cyIulsydnX9ZmNj?=
 =?us-ascii?Q?+WxIIXa916BtdWdoNFeeVAdiZibpAowYAmkOyQ8ASCVKkuWddRLgC1LR8Om/?=
 =?us-ascii?Q?ke62DfVhquCEnCMNPm1eKUcrJh4kgItVsuMbGYbpQHdnGH+eaQKRbthc3Kyq?=
 =?us-ascii?Q?lweVR47HlTY+pbXhDdOq8w2NLniR0i1+Qf8RmMQfdt3cDjW6xmhC1QvOQCY5?=
 =?us-ascii?Q?yJhyIiFteJO0LVDBwavbV3ns+cgHHUdASp1PmEDhIx2Wis47yAkQlomTCCXJ?=
 =?us-ascii?Q?oyZxUUcCHBcxcFtuuJD85igHqmZTLzxDqg9coP3kMkF+zTc0RBfWvR0lh9uc?=
 =?us-ascii?Q?5BHs4KA/IN7Hk3PFgAkV1CeRGgYNDbTed3d46eGQjwV55NLGRLJ5aNGaguzP?=
 =?us-ascii?Q?q2b+YUaMvKTIuMftJ3BKOV85jBlV3aogFDAuiz4JP8+cZ6xXyC8Ua+VRBzk1?=
 =?us-ascii?Q?fNR1VBqiXkor0+OR9AAHiPylZFtwcOMVJSSZ0hxR0ZEj7sd8mmOy0OyYoNUJ?=
 =?us-ascii?Q?xQd+iSYHzLF7w0a31qJloaLJ+rxu+FQHvn06fA03CsJ4ifRvMOg2BHMX5hsU?=
 =?us-ascii?Q?sUjhPrgfvtQ0cNbdsTXe/HdcGvYytNH4ITZCZEtb/uhZeiOa/ywst2g2BzMK?=
 =?us-ascii?Q?8COReEgIU6n0FukOoXcu72AI27AhfWbVpyW111j2Miq9xGhVea/NTTR4qDDB?=
 =?us-ascii?Q?Kkv+rL7FW07xshqR0c4ldO5DhDZhsjDr1FQ4TdYZ94oYss4rojC6YoRa561x?=
 =?us-ascii?Q?e3F3TaOLB9WGkOy4NObewISnaMPKbj3xlcry28eiaFMFuJvz1qHatlhz0gk5?=
 =?us-ascii?Q?S9Rl4Bl7xBOQFt/bQ1LpJcIwSax7Lm0KU2GBx9DI0EzoJdAk7s+11S1ZuMin?=
 =?us-ascii?Q?rNHh6716pWyompxEZT7gN9nV5hZutbEsvDNXrbX7OJ4CV64fbxs6ocdwlSI1?=
 =?us-ascii?Q?MlV+0dK/cMYfV3TyCy06hIL6g9RQPbU3J5svgYTnU+7ZlgjoV8zCIRNDhoMe?=
 =?us-ascii?Q?a9jzIIMHivbjF1Pl8k4ep6rWwUi41I1TUzcFdDk5NhUbNxGv1W3UOtgA8hEd?=
 =?us-ascii?Q?C0ztMiQZWfEjD/gmXZJYutcN5DrvuUxbCHbSAjp8d5vcjIpZ5LhzV5wqeUHy?=
 =?us-ascii?Q?oc5DrL0CB4WW8JTz+E+vUst9hio0yG8rpC2WfUCGlaYYerGVdx6rOz+WKcrR?=
 =?us-ascii?Q?npUFplfN20WrO97W3BqcSsoyCRoQElukNOcD69PR0aGPH3mfGy3ARlJ8S5uU?=
 =?us-ascii?Q?kfLPfdiGfDE9cFs2rDcK4BC8ymR5btrU3H4hLVK2e/xK0usQCN/1n/FzYLCa?=
 =?us-ascii?Q?O98S37QquFp7AfzK/Zs2Scyd0iHySscN0wCpc1sWbn9d5uShzTC5VMc1gQjU?=
 =?us-ascii?Q?m00FONXRpqpV+PuCCLu76rCaynSDS4bDiPLAFB26LSi03/Xqwc+rAA=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbf2c5d-f1be-4429-a86f-08da0c2ec1f5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2022 18:06:59.0195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJm2EeNDgpwGyIYFTZtPiZsHkHFC2oBDnRsFjrebDIwfYsdjlXeqR8qJhwsxPth+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2388
X-Proofpoint-GUID: Fm3qA89I7-vAXfQC6c1iPzfUgzHZGRnw
X-Proofpoint-ORIG-GUID: Fm3qA89I7-vAXfQC6c1iPzfUgzHZGRnw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 09:25:00PM +0530, Kumar Kartikeya Dwivedi wrote:
> @@ -820,9 +904,31 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>  			return -EOPNOTSUPP;
>  	}
>  
> -	if (map->ops->map_check_btf)
> +	map->kptr_off_tab = btf_find_kptr(btf, value_type);
> +	if (map_value_has_kptr(map)) {
> +		if (!bpf_capable())
> +			return -EPERM;
Not sure if this has been brought up.

No need to bpf_map_free_kptr_off_tab() in the case?

> +		if (map->map_flags & BPF_F_RDONLY_PROG) {
> +			ret = -EACCES;
> +			goto free_map_tab;
> +		}
> +		if (map->map_type != BPF_MAP_TYPE_HASH &&
> +		    map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> +		    map->map_type != BPF_MAP_TYPE_ARRAY) {
> +			ret = -EOPNOTSUPP;
> +			goto free_map_tab;
> +		}
> +	}
If btf_find_kptr() returns err, it can be ignored and continue ?

btw, it is quite unusual to store an err ptr in map.
How about only stores NULL or a valid ptr in map->kptr_off_tab?

> +
> +	if (map->ops->map_check_btf) {
>  		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
> +		if (ret < 0)
> +			goto free_map_tab;
> +	}
>
> +	return ret;
> +free_map_tab:
> +	bpf_map_free_kptr_off_tab(map);
>  	return ret;
>  }
