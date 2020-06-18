Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFAE1FEB66
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 08:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgFRGTH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 02:19:07 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:2650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726964AbgFRGTG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 02:19:06 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05I6GiXq029178;
        Wed, 17 Jun 2020 23:18:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=nxw9ruZdTPw2Tr8ILZsz0MPthvPSy0NX0JdkwfuEO1k=;
 b=OaH++9JEt8GxVewIiNHRB5WJpHjQlETKJeDTKI8EZ512s/vJjOH5mAq4QVVP0GuEmnfr
 bDG+jUJz72j2y24HqF3x/XkR78eH/JBd+R4OAJRYggXzm+lPGLGzy6Ey1PV+YfZyqJmE
 sGNTaOyTxm+kpcqgyaPT87am+YvChUTNPUg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 31q65kadr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 17 Jun 2020 23:18:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 17 Jun 2020 23:18:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV815BKp2G169/7/NCuZuG8v2LHE6gjweF8gMJzVHsZTgiaL+k2vzbFrgo8ZbSAIS3B0xgGI/YPjIb3OCjXxu7zrGvwpY1Xj4pgR1frMtIchQQ8v+k57Ki5rXw15aF+tFODtZkaomED8wwzJ8jkm13jdiUnykEUHMSVb6hVrlFhofzCczm7iPRrlROrYgVPeWIBhLtYWsbjcvBJdsB9+SQuFQL65enWBgDXCOaAzNaZcCXxZBHHXkGZjJNCX2X4wU29YVfoYn9510z4MHUXKeT0aXJ/+5q1CK1CRDbAUaogeiqH2YZKTOSoYEXof3W+YmZLQbjeTwptlymqfk/X/bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxw9ruZdTPw2Tr8ILZsz0MPthvPSy0NX0JdkwfuEO1k=;
 b=aiaDZve9CtGOf5tgp+oWZSLD5pkaiDL9/aW0IL1dF0tH84Rpqzp/kuB0OZrIqIjhNj7nUdsacd7W6YcZZd6kGJYcQt/Xyd1PIO5gK2LxwlDHWnaICcaDG5n60tyxjJKgmFYPXUWfkgbe8lxVWx6LobRPTnEAeJd4unnAXOVw7gvazRgs7FuUKc7J3Tg8zLW9m+CYekLKg1fwh+W7ZmvuuJ00QEzOoB4EcRghW1S/yqzx0CaW8rFU5KNOShHqjUEc3CNbfyNwVOlcL9dbdKWdKa7DDY9chgugHk0TWoaY8xHqU7PP2PcWT7whmPuMjk46+MzD8m7KiNJG6InnPqG2YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxw9ruZdTPw2Tr8ILZsz0MPthvPSy0NX0JdkwfuEO1k=;
 b=PuCkgd+khEslqN5rwmZ2IauSoBnGb25yhcV1HYPbmOQ0NmoFg8NDllu7+cn+omuxZPn1/vUbtK01RvL0vD4j4boc9R3FUjtv11P9GUvRP2FAO30MMkRI1JWZotGyQd7lrnNJTUEseYMYgCPGevJ0Xu3HdpowzmSwiwxo7HmyHeo=
Received: from CH2PR15MB3573.namprd15.prod.outlook.com (2603:10b6:610:e::28)
 by CH2PR15MB3736.namprd15.prod.outlook.com (2603:10b6:610:6::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 18 Jun
 2020 06:18:49 +0000
Received: from CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::b0ab:989:1165:107]) by CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::b0ab:989:1165:107%5]) with mapi id 15.20.3088.028; Thu, 18 Jun 2020
 06:18:48 +0000
Date:   Wed, 17 Jun 2020 23:18:41 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [Potential Spoof] [PATCH bpf-next 4/6] bpf: Support access to
 bpf map fields
Message-ID: <20200618061841.f52jaacsacazotkq@kafai-mbp.dhcp.thefacebook.com>
References: <cover.1592426215.git.rdna@fb.com>
 <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53fdc8f0c100fc50c8aa5fbc798d659e3dd77e92.1592426215.git.rdna@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR11CA0095.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::36) To CH2PR15MB3573.namprd15.prod.outlook.com
 (2603:10b6:610:e::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:4bb0) by BYAPR11CA0095.namprd11.prod.outlook.com (2603:10b6:a03:f4::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 06:18:47 +0000
X-Originating-IP: [2620:10d:c090:400::5:4bb0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b1410ad-cc08-40a7-cee2-08d8134f766e
X-MS-TrafficTypeDiagnostic: CH2PR15MB3736:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR15MB3736E4B24C40D38BFF8FCBF9D59B0@CH2PR15MB3736.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nIG+Gt+NZdeXgyOK0gfnh1aXFEDJ97WujeCYAbVdotXX75jnuSOYMbcTIXujmANcly3gsnRnTZzwSeANMecWdpUsDZAQ7naiB9TKNhaJcx89WzDhLEQu0BWrZzRWsPWFEjk42NxmiVw1QhQmfLpyP/6FvXlxTjvYL9j8cEw4W2Ur5GzUOzAogoEPldphD/mrRz0MA0tVnNM3RZZjJG5oEo72PhGZ2nHSq+6+7peZJEPmJb9qlOLfP7lQcK0hZEMNpQu/qBdUFfgY5xCAwH+IbsyrAiU8Awj4Pm8B0NJ12oTGZTjO6dluOoy5T+Rcg0C8sljSyTSO4Oh46Lu6g5DrMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3573.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(366004)(396003)(136003)(6636002)(478600001)(9686003)(6666004)(316002)(4326008)(8676002)(8936002)(86362001)(7696005)(6862004)(1076003)(66946007)(66476007)(66556008)(55016002)(5660300002)(52116002)(2906002)(6506007)(16526019)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 34paDJZ4ryR7Cc5RvaiGHlI1kZ+/+kP8SVExGFgw3pXj6q7g2LxtzrL0Dvh3xIlRJLukHnzrGISJV/T1C8oiktVeDxo/uGZnqRE+ERmPLopmYi4zC/2v0fbdTNS/N2cMcqlxw813MZ+E/4/c/Z5KMXA2efasVLi1qdc5IB+UcKyzh85tAKhIQOZgSq8hxRLvhiOfdAjzPH9aZQrs868Yd93W9wLkvUluPfi/r0r0SaLIgZyRkHUI928U7BE6BzbftBZyzwDHH2Hc/I4itsB2SMO1CrJxmLS748STLpQHNs5MLSaUICBfBUweriPzyA1Ij08DKkVEGgGhoGzSqsB4ipR1lMK+vM5vUTZrhPrbB85Vcf2/s4frpJekRA3AQvf7+ZYUfM/IBc8gt37va/eG0oLdajDdTTFLQ1IqsGwgI8syrZyNq9fRkWI3c4917EfaVrrYy56s7z8zJNOL5c0LBZtJDi02A0eIac15A7Rzb1HvSMlnorTG7fz7dKlN93uAio+HjYlaNtofLzsKgikUNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1410ad-cc08-40a7-cee2-08d8134f766e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 06:18:48.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OrdBoskGYuhr6Ni9GvsL1SNWIK8z3kj+9Bt5FVkxXY4VTSMxtYCuOp3LrvknmSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3736
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_04:2020-06-17,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 cotscore=-2147483648 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180048
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 01:43:45PM -0700, Andrey Ignatov wrote:
[ ... ]
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e5c5305e859c..fa21b1e766ae 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3577,6 +3577,67 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, struct btf *btf,
>  	return ctx_type;
>  }
>  
> +#define BPF_PROG_TYPE(_id, _name, prog_ctx_type, kern_ctx_type)
> +#define BPF_LINK_TYPE(_id, _name)
> +static const struct bpf_map_ops * const btf_vmlinux_map_ops[] = {
> +#define BPF_MAP_TYPE(_id, _ops) \
> +	[_id] = &_ops,
> +#include <linux/bpf_types.h>
> +#undef BPF_MAP_TYPE
> +};
> +static u32 btf_vmlinux_map_ids[] = {
> +#define BPF_MAP_TYPE(_id, _ops) \
> +	[_id] = (u32)-1,
> +#include <linux/bpf_types.h>
> +#undef BPF_MAP_TYPE
> +};
> +#undef BPF_PROG_TYPE
> +#undef BPF_LINK_TYPE
> +
> +static int btf_vmlinux_map_ids_init(const struct btf *btf,
> +				    struct bpf_verifier_log *log)
> +{
> +	int base_btf_id, btf_id, i;
> +	const char *btf_name;
> +
> +	base_btf_id = btf_find_by_name_kind(btf, "bpf_map", BTF_KIND_STRUCT);
> +	if (base_btf_id < 0)
> +		return base_btf_id;
> +
> +	BUILD_BUG_ON(ARRAY_SIZE(btf_vmlinux_map_ops) !=
> +		     ARRAY_SIZE(btf_vmlinux_map_ids));
> +
> +	for (i = 0; i < ARRAY_SIZE(btf_vmlinux_map_ops); ++i) {
> +		if (!btf_vmlinux_map_ops[i])
> +			continue;
> +		btf_name = btf_vmlinux_map_ops[i]->map_btf_name;
> +		if (!btf_name) {
> +			btf_vmlinux_map_ids[i] = base_btf_id;
> +			continue;
> +		}
> +		btf_id = btf_find_by_name_kind(btf, btf_name, BTF_KIND_STRUCT);
> +		if (btf_id < 0)
> +			return btf_id;
> +		btf_vmlinux_map_ids[i] = btf_id;
Since map_btf_name is already in map_ops, how about storing map_btf_id in
map_ops also?
btf_id 0 is "void" which is as good as -1, so there is no need
to modify all map_ops to init map_btf_id to -1.

> +		btf_id = btf_find_by_name_kind_next(btf, btf_name,
> +						    BTF_KIND_STRUCT,
> +						    btf_id + 1);
> +		if (btf_id > 0) {
> +			bpf_log(log,
> +				"Ambiguous btf_id for struct %s: %u, %u.\n",
> +				btf_name, btf_vmlinux_map_ids[i], btf_id);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
