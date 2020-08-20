Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7491B24C6CE
	for <lists+bpf@lfdr.de>; Thu, 20 Aug 2020 22:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHTUio (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Aug 2020 16:38:44 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21266 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726911AbgHTUim (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Aug 2020 16:38:42 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KKawgH004820;
        Thu, 20 Aug 2020 13:38:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tUt61EOES1/qkz1daIupNgVjwuve+Hcve/KZRA2PjLM=;
 b=HuNhvTCKGuwhxxUydjryR8TF4Ii5u15QMFNO3sjTaxsCm1t+WNwGFP/fano5kwxK5yHo
 N4sYAZN1TZTqu1GKELw8sqDCPVDYdNno3yBuiCDgWTu6lXcBJ/rPcspJ4Ph73/kRpb0G
 NUsnZJHFcgVOKF8EAnIuTHSY9pv5kLIt5Bg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304p3rgfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Aug 2020 13:38:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 20 Aug 2020 13:38:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDCPC2jo6N/ieKT8Nw0M/cUyZaiw8xMvRhdJDmgX+gC1GPadAhtwnaVn56yMmvpX7rw6JufwIJNC9H4rHK9zRl7PYsUf/oxNSTTrd2EPsBvo3nVTD40cRmkRWy0Efb8b6ENS1kNHPm/xCWsYkAtkaH4IIYeUF9fCtdKBWCfw1KCthAlU/x30/l4c6m9YNXKdg3MKteUCfp0vU2JS/y2RNV2WtrMbMh19TT4UN/4RZq7rifYisiY9Kqu9OcC4xajo3MqFC4RPdfgrzxFDAWFr12SXF6LPwedkIH+vbxgFmThePTkZhF5+fpSM3LCdD2NjHExwF9r1TFnYVzA+maCH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUt61EOES1/qkz1daIupNgVjwuve+Hcve/KZRA2PjLM=;
 b=dAerN7XGtWC0/+hrHiWBjOM0u4MP/8ripq5W+Rot6uCqoGnOU6tcv9Qyqu4u+I7WB74aoi8Uqw9L1EDXB/gbmgI0B1jvVe03iPCnM+Cjp14rChM0yqcNSqZR2vl9ZlgOCidGa0nvU8Roqf63yGY3CZ2lXafPiMX6oIa+4GP2jycTS/eU/Wg62l6WwNKJvRuQCJYLWbaIjFKBjyREZa8S0AN9PO9izJul2H8w6sw69eekQ6kNdhR0tMOT/5xHlvZdCorZx0j7Jrk7072oXXRadZjKbFrPA2TZbSCGL1Iib0d/8Ps0GEp/MhyU2J8SjOt9N4WI3y4jCSlE3KRHSS+Vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUt61EOES1/qkz1daIupNgVjwuve+Hcve/KZRA2PjLM=;
 b=OqRdh6wfCx1ouN3Z72d9jCdvyEKl0yC+UltSYrntaf8+0QzLAtvFutxzS5ALMk/H5EFpJKHmVagr8N0HejwbNcpiT1k07/X70XnOt0gIu51KBZ4AEl0VjEFXnL3wDGdZ6bae9pjJ/QpHahrSWS8SCbxwe8UWChnqGsgYSCDaqm0=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2725.namprd15.prod.outlook.com (2603:10b6:a03:158::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Thu, 20 Aug
 2020 20:38:21 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3305.026; Thu, 20 Aug 2020
 20:38:21 +0000
Subject: Re: [PATCH bpf-next 3/5] libbpf: Add BPF_PROG_BIND_MAP syscall and
 use it on .metadata section
To:     YiFei Zhu <zhuyifei1999@gmail.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
References: <cover.1597915265.git.zhuyifei@google.com>
 <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e4d7e9a8-19ac-b107-0f5d-8f9322ff9d21@fb.com>
Date:   Thu, 20 Aug 2020 13:38:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <b65c850c8e9f9ae8309c8a328a3d53ab76289c5b.1597915265.git.zhuyifei@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Thu, 20 Aug 2020 20:38:19 +0000
X-Originating-IP: [2620:10d:c091:480::1:7a86]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5409ded-665f-4432-de44-08d84548fa64
X-MS-TrafficTypeDiagnostic: BYAPR15MB2725:
X-Microsoft-Antispam-PRVS: <BYAPR15MB27258CDFE576453BE39E3C3FD35A0@BYAPR15MB2725.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:913;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnbJTgaNM5ezS1ga3zW8LJ/jayEiLJL21X3ZzJ6CdqdYt5alMrECWPBLwjcgsULub4HPZlHpkxWNXzRLBGMUJfGG5eXDe52tj4/6ocgV4/QNfXzNbXkekElhqeA3/KIhBTssZ8eCIhzE58B7xJg/t2wzk0lzr10aK4kX9pmODiCIFVYG1hdzxsN7kw2E2XIplpsmfW+NfqBmm+vU7uIqol+S2Sf96qi1wXVZiJqMLOjip6aMjif6clxF5wtHld02ndhQ2k1h/2uld97RI+U/6BcRkZ5SK5N5yxA+GBz3tb0VyKvsUChQ8xRHVrxUny4v6EenkWSOww77tUkZ77AXyHUXYixWDFjF/S1N4O0QDt2ZgCLK2aXQwKxQpnK7oi/BoPW4ewbohmCmaT0fpRIUqxJxernwq8yA8+bIFPPLDL33+fwtQFlp273j1mayo6CS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(53546011)(31696002)(956004)(6486002)(66476007)(5660300002)(316002)(66946007)(66556008)(2906002)(54906003)(52116002)(2616005)(16576012)(8676002)(110011004)(45080400002)(4326008)(31686004)(86362001)(36756003)(83380400001)(186003)(478600001)(8936002)(6666004)(142923001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kCtrXHb8je8gtlQ7X0RdPkbP31AcxBHpjMIV2EPv275HONXdiztsgdz+3MG0ZJEIPpAQm1k4WZQzdZVNWbybluwHCy27d8DUsI2r/TrbcnpyDwVbk85TepFu4itep46CjWbAJU/7cHJyHcSUPfa5PudymChkyD8xLOvvMzfvg95eYRyh8JFpLCIz1oP5zWAdIp6q/cmh0pLWgqbg1Jgkh8JajaCP146tSS9xKXt7r4x0V7200KtbTOcW/7rPr3Honr92gQ1lBmRp7onxZ218lJ/EZ2oS6/5ICi9i7OPG8Kgh49qEJ6EuXkpHs4K/GHti+dVLi9fAWp5ZV1zrEMMDmQ6t7iD/0GV4TOWlHIQD8D2u8tEFs7Uou8E1owr8WIxZmIZ8Tj+1WqR7NnuYCJQBY8KaMLUMT+GwyIpx5qCnSbWdLGQ6xauH+PN9vkaDbLv0D1gkDc2jBQLdNIroG+JSgRjwQE2rmeY9Wg0AV947Xqgm0gg21oDuhFV1bGShTMtFk1Ed+IPcpcsgZFX6fcVLxz9dIviXXHTQa63Shwe6Lq9/El8i3RHbenUmz5FmVQVuyZTmJtK87fk57hGAFFo2FxBWLGK2DF/kUF1/pk2n+tcbcSz8VygWUAUfn4TGZ9spEmrNBbOef7RJyL8lk8wIUFJNKIF3L0qXpNIKr3YbTZA=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5409ded-665f-4432-de44-08d84548fa64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 20:38:21.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DrfQO+VqM2BTTMSWCaDuyJjyRqG0ozZt83t0ipG7ZC3ku7b70ImyLBdcrCDOiivs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2725
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_06:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0 clxscore=1011 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200166
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/20/20 2:42 AM, YiFei Zhu wrote:
> From: YiFei Zhu <zhuyifei@google.com>
> 
> The patch adds a simple wrapper bpf_prog_bind_map around the syscall.
> And when using libbpf to load a program, it will probe the kernel for
> the support of this syscall, and scan for the .metadata ELF section
> and load it as an internal map like a .data section.
> 
> In the case that kernel supports the BPF_PROG_BIND_MAP syscall and
> a .metadata section exists, the map will be explicitly bound to
> the program via the syscall immediately after program is loaded.
> -EEXIST is ignored for this syscall.
> 
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> ---
>   tools/lib/bpf/bpf.c      |  11 +++++
>   tools/lib/bpf/bpf.h      |   1 +
>   tools/lib/bpf/libbpf.c   | 100 ++++++++++++++++++++++++++++++++++++++-
>   tools/lib/bpf/libbpf.map |   1 +
>   4 files changed, 112 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 82b983ff6569..383b29ecb1fd 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -872,3 +872,14 @@ int bpf_enable_stats(enum bpf_stats_type type)
>   
>   	return sys_bpf(BPF_ENABLE_STATS, &attr, sizeof(attr));
>   }
> +
> +int bpf_prog_bind_map(int prog_fd, int map_fd, int flags)
> +{
> +	union bpf_attr attr = {};
> +
> +	attr.prog_bind_map.prog_fd = prog_fd;
> +	attr.prog_bind_map.map_fd = map_fd;
> +	attr.prog_bind_map.flags = flags;
> +
> +	return sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
> +}
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 015d13f25fcc..32994a4e0bf6 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -243,6 +243,7 @@ LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
>   enum bpf_stats_type; /* defined in up-to-date linux/bpf.h */
>   LIBBPF_API int bpf_enable_stats(enum bpf_stats_type type);
>   
> +LIBBPF_API int bpf_prog_bind_map(int prog_fd, int map_fd, int flags);

Maybe put "flags" as an optional parameter? Currently "flags" is not 
used. Not sure how widely it may be used in the future. See other
syscall interface in the same file, e.g., bpf_link_create().

>   #ifdef __cplusplus
>   } /* extern "C" */
>   #endif
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 77d420c02094..4725859099c5 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -174,6 +174,8 @@ enum kern_feature_id {
>   	FEAT_EXP_ATTACH_TYPE,
>   	/* bpf_probe_read_{kernel,user}[_str] helpers */
>   	FEAT_PROBE_READ_KERN,
> +	/* bpf_prog_bind_map helper */
> +	FEAT_PROG_BIND_MAP,
>   	__FEAT_CNT,
>   };
>   
> @@ -283,6 +285,7 @@ struct bpf_struct_ops {
>   #define KCONFIG_SEC ".kconfig"
>   #define KSYMS_SEC ".ksyms"
>   #define STRUCT_OPS_SEC ".struct_ops"
> +#define METADATA_SEC ".metadata"
>   
>   enum libbpf_map_type {
>   	LIBBPF_MAP_UNSPEC,
> @@ -290,6 +293,7 @@ enum libbpf_map_type {
>   	LIBBPF_MAP_BSS,
>   	LIBBPF_MAP_RODATA,
>   	LIBBPF_MAP_KCONFIG,
> +	LIBBPF_MAP_METADATA,
>   };
>   
>   static const char * const libbpf_type_to_btf_name[] = {
> @@ -297,6 +301,7 @@ static const char * const libbpf_type_to_btf_name[] = {
>   	[LIBBPF_MAP_BSS]	= BSS_SEC,
>   	[LIBBPF_MAP_RODATA]	= RODATA_SEC,
>   	[LIBBPF_MAP_KCONFIG]	= KCONFIG_SEC,
> +	[LIBBPF_MAP_METADATA]	= METADATA_SEC,
>   };
>   
>   struct bpf_map {
> @@ -375,6 +380,8 @@ struct bpf_object {
>   	size_t nr_maps;
>   	size_t maps_cap;
>   
> +	struct bpf_map *metadata_map;
> +
>   	char *kconfig;
>   	struct extern_desc *externs;
>   	int nr_extern;
> @@ -398,6 +405,7 @@ struct bpf_object {
>   		Elf_Data *rodata;
>   		Elf_Data *bss;
>   		Elf_Data *st_ops_data;
> +		Elf_Data *metadata;
>   		size_t strtabidx;
>   		struct {
>   			GElf_Shdr shdr;
> @@ -413,6 +421,7 @@ struct bpf_object {
>   		int rodata_shndx;
>   		int bss_shndx;
>   		int st_ops_shndx;
> +		int metadata_shndx;
>   	} efile;
>   	/*
>   	 * All loaded bpf_object is linked in a list, which is
> @@ -1022,6 +1031,7 @@ static struct bpf_object *bpf_object__new(const char *path,
>   	obj->efile.obj_buf_sz = obj_buf_sz;
>   	obj->efile.maps_shndx = -1;
>   	obj->efile.btf_maps_shndx = -1;
> +	obj->efile.metadata_shndx = -1;
>   	obj->efile.data_shndx = -1;
>   	obj->efile.rodata_shndx = -1;
>   	obj->efile.bss_shndx = -1;
> @@ -1387,6 +1397,9 @@ bpf_object__init_internal_map(struct bpf_object *obj, enum libbpf_map_type type,
>   	if (data)
>   		memcpy(map->mmaped, data, data_sz);
>   
> +	if (type == LIBBPF_MAP_METADATA)
> +		obj->metadata_map = map;
> +
>   	pr_debug("map %td is \"%s\"\n", map - obj->maps, map->name);
>   	return 0;
>   }
> @@ -1422,6 +1435,14 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
>   		if (err)
>   			return err;
>   	}
> +	if (obj->efile.metadata_shndx >= 0) {
> +		err = bpf_object__init_internal_map(obj, LIBBPF_MAP_METADATA,
> +						    obj->efile.metadata_shndx,
> +						    obj->efile.metadata->d_buf,
> +						    obj->efile.metadata->d_size);
> +		if (err)
> +			return err;
> +	}
>   	return 0;
>   }
>   
> @@ -2698,6 +2719,9 @@ static int bpf_object__elf_collect(struct bpf_object *obj)
>   			} else if (strcmp(name, STRUCT_OPS_SEC) == 0) {
>   				obj->efile.st_ops_data = data;
>   				obj->efile.st_ops_shndx = idx;
> +			} else if (strcmp(name, METADATA_SEC) == 0) {
> +				obj->efile.metadata = data;
> +				obj->efile.metadata_shndx = idx;
>   			} else {
>   				pr_debug("skip section(%d) %s\n", idx, name);
>   			}
> @@ -3111,7 +3135,8 @@ static bool bpf_object__shndx_is_data(const struct bpf_object *obj,
>   {
>   	return shndx == obj->efile.data_shndx ||
>   	       shndx == obj->efile.bss_shndx ||
> -	       shndx == obj->efile.rodata_shndx;
> +	       shndx == obj->efile.rodata_shndx ||
> +	       shndx == obj->efile.metadata_shndx;
>   }
>   
>   static bool bpf_object__shndx_is_maps(const struct bpf_object *obj,
> @@ -3132,6 +3157,8 @@ bpf_object__section_to_libbpf_map_type(const struct bpf_object *obj, int shndx)
>   		return LIBBPF_MAP_RODATA;
>   	else if (shndx == obj->efile.symbols_shndx)
>   		return LIBBPF_MAP_KCONFIG;
> +	else if (shndx == obj->efile.metadata_shndx)
> +		return LIBBPF_MAP_METADATA;
>   	else
>   		return LIBBPF_MAP_UNSPEC;
>   }
> @@ -3655,6 +3682,60 @@ static int probe_kern_probe_read_kernel(void)
>   	return probe_fd(bpf_load_program_xattr(&attr, NULL, 0));
>   }
>   
> +static int probe_prog_bind_map(void)
> +{
> +	struct bpf_load_program_attr prog_attr;
> +	struct bpf_create_map_attr map_attr;
> +	char *cp, errmsg[STRERR_BUFSIZE];
> +	struct bpf_insn insns[] = {
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	};
> +	int ret = 0, prog, map;
> +
> +	if (!kernel_supports(FEAT_GLOBAL_DATA))
> +		return 0;
> +
> +	memset(&map_attr, 0, sizeof(map_attr));
> +	map_attr.map_type = BPF_MAP_TYPE_ARRAY;
> +	map_attr.key_size = sizeof(int);
> +	map_attr.value_size = 32;
> +	map_attr.max_entries = 1;
> +
> +	map = bpf_create_map_xattr(&map_attr);
> +	if (map < 0) {
> +		ret = -errno;
> +		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> +		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
> +			__func__, cp, -ret);
> +		return ret;
> +	}
> +
> +	memset(&prog_attr, 0, sizeof(prog_attr));
> +	prog_attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
> +	prog_attr.insns = insns;
> +	prog_attr.insns_cnt = ARRAY_SIZE(insns);
> +	prog_attr.license = "GPL";
> +
> +	prog = bpf_load_program_xattr(&prog_attr, NULL, 0);
> +	if (prog < 0) {
> +		ret = -errno;
> +		cp = libbpf_strerror_r(ret, errmsg, sizeof(errmsg));
> +		pr_warn("Error in %s():%s(%d). Couldn't create simple program.\n",
> +			__func__, cp, -ret);
> +
> +		close(map);
> +		return ret;
> +	}

A lot of duplicated codes here vs. probe_global_data.
Can we abstract common codes into separate routines?

> +
> +	if (!bpf_prog_bind_map(prog, map, 0))
> +		ret = 1;
> +
> +	close(map);
> +	close(prog);
> +	return ret;
> +}
> +
>   enum kern_feature_result {
>   	FEAT_UNKNOWN = 0,
>   	FEAT_SUPPORTED = 1,
> @@ -3695,6 +3776,9 @@ static struct kern_feature_desc {
>   	},
>   	[FEAT_PROBE_READ_KERN] = {
>   		"bpf_probe_read_kernel() helper", probe_kern_probe_read_kernel,
> +	},
> +	[FEAT_PROG_BIND_MAP] = {
> +		"bpf_prog_bind_map() helper", probe_prog_bind_map,
>   	}
>   };
>   
> @@ -5954,6 +6038,20 @@ load_program(struct bpf_program *prog, struct bpf_insn *insns, int insns_cnt,
>   	if (ret >= 0) {
>   		if (log_buf && load_attr.log_level)
>   			pr_debug("verifier log:\n%s", log_buf);
> +
> +		if (prog->obj->metadata_map && kernel_supports(FEAT_PROG_BIND_MAP)) {
> +			if (bpf_prog_bind_map(ret, bpf_map__fd(prog->obj->metadata_map), 0) &&
> +			    errno != EEXIST) {

could you explain and possibly add comments in the code why EEXIST is 
ignored in the failure case?

> +				int fd = ret;
> +
> +				ret = -errno;

libbpf_strerror_r understands positive and negative errno, so no need 
"ret = -errno".

Question: should bpftool freeze the metadata map or not?

> +				cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
> +				pr_warn("add metadata map failed: %s\n", cp);
> +				close(fd);
> +				goto out;
> +			}
> +		}
> +
>   		*pfd = ret;
>   		ret = 0;
>   		goto out;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index e35bd6cdbdbf..4baf18a6df69 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -288,6 +288,7 @@ LIBBPF_0.1.0 {
>   		bpf_map__set_value_size;
>   		bpf_map__type;
>   		bpf_map__value_size;

This needs to be in a new kernel release. For example
   LIBBPF_0.1.1

> +		bpf_prog_bind_map;
>   		bpf_program__attach_xdp;
>   		bpf_program__autoload;
>   		bpf_program__is_sk_lookup;
> 
