Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3D36CB0C
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbhD0SVq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 14:21:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23162 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236279AbhD0SVp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 27 Apr 2021 14:21:45 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13RIE622029913;
        Tue, 27 Apr 2021 11:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=FOqTioE3fJIB8DwevHf7C+jZCPDInLYE8uRSKWEmaic=;
 b=U3kwyQ7c2xXgO0pU4ALIywWkKINj2ej8RToCgYBJmu2SBvRoiyL9kmm4QqXnTEeV0jFu
 sbcUGWNgDS4LiCbOMwVbocf+roIskzOx4NW4ZoqIwbju/to4eMDEhr2Uq23GUqV9b4AI
 vN6MPT56yD6GzsAa9lZ9Pw3J3ZDTu2SwCPw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 385v2j12v8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Apr 2021 11:20:59 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 11:20:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pd+RxaYfLOfHM6eEih1KiEbIRMHZ9zPbDRl/+55BO0oWCJWhnegSDPHMA1v6yKzgFjsLw/3jiEmDbuHP5wCXyZZ0Zju/BRYpCpW04JakGa4oy0xbEedfe4NO/MfMtf87Y/rfnE3Y3BHRnHWCd4OaBbSI/ht1Juk59PeWKMfsRvhcBQnhlrdjUhDZJnmFQa4M+j5I/yY+cNwQa8h5ZkX5bAfJZXFcVuNF/aV6Lgd1Tz4PGBW7+g8kgIaZAwUVQUEdbmwZey498E6zTMLpkg8gfIvfUsAN6zrvgj1GoOLq9NAuIQLQScNhNq9arCZvFE84+mvGHf9sTfKvmcQ2/5H28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOqTioE3fJIB8DwevHf7C+jZCPDInLYE8uRSKWEmaic=;
 b=I0+W44Ke+3yWsx4CrvInvuHVvE1nrc1W5u/AKPdyWqcn6dvieHKAarwpTs5pkK50M7oJViPA/WaMkShbHVqG2t8bv6St9zmew6F16i1K19wz9kTuv8mXqvejfMaIsE0QiDjfD0ZeLEyWhNFfPbcP59cCPo351lZ+wmggpGvs6EtBHy1/ZnUb7lrLvkIallHoFJ89DQzoxwgau7dQ+z9YOj+GC1LFJPpq/qNjr3iBqzQQnBj7XZKRJXF562Xs5aluec1ezonsKFN+5yw6feoeHtYabsWk9c5EnC8fH1pwAtahc5mcledL+FSRGIlkXEjlI/w2+paYMLPqI/nvwf1ZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY3PR15MB4882.namprd15.prod.outlook.com (2603:10b6:a03:3c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Tue, 27 Apr
 2021 18:20:57 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::718a:4142:4c92:732f%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 18:20:57 +0000
Date:   Tue, 27 Apr 2021 11:20:53 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <dwarves@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH dwarves] btf: Generate btf for functions in the .BTF_ids
 section
Message-ID: <20210427182053.ttiuxdt675lzmvk3@kafai-mbp.dhcp.thefacebook.com>
References: <20210423213728.3538141-1-kafai@fb.com>
 <YIf4sF2H/xkex2Q1@krava>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YIf4sF2H/xkex2Q1@krava>
X-Originating-IP: [2620:10d:c090:400::5:3762]
X-ClientProxiedBy: MWHPR01CA0035.prod.exchangelabs.com (2603:10b6:300:101::21)
 To BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:3762) by MWHPR01CA0035.prod.exchangelabs.com (2603:10b6:300:101::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 18:20:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1b4fa50-95af-4e20-c443-08d909a93386
X-MS-TrafficTypeDiagnostic: BY3PR15MB4882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY3PR15MB4882D011AF258893715A5B27D5419@BY3PR15MB4882.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8H8Bb1VBuSfLuaMkJHitt54cCN+1MnwouA6IchDKNwxHiknYcP1H0o8ngFDztNa6j+IWW8wK9YKkla/n0lBJ3mdJuTgfCL6U6PMyTp6JMc8Cx6NMQQT8+B7Q7fvpxRcLANS8469ufTYN+dwGypznWFccsuULjY0jiKE8sM4cQzbDdIlSeavN+8Ehjv3fSg5N26PjEec4ZpdsZMESeJ8U/xvoLXyIlatQl0vtpzu8hN9l+7E4cwQwzSKDZQz1EZTLTW85yb0Dknfs9gqwJgai52Ma6PQsNSJ99BUTMZfWiFCsyYDAbYKEwiko12ZNdxgJV1mfS3dcJEJigF8+CREWpLZcOt1OtLOmtEZw0bqX2TQuFqR/mae+pDX0GFceCu70yqZAzI2amGL7hkBXXhxWvIyrqBNzEWkEQQcvYOGTn/uzk2YL3rFEVC4YzyHqXns3k1dwG6sBqpRqPvRwYPETWf0ejT16S3z4GOSQBpwsVae7yHNj/m80XLAz2rDmb8AxvvYKayZQtfpcdLeDVgCnTYHCNy8572lBHYNslimNISy5EPyaLSf14uaIr3LSdwoR0R8QQ9fgVr5mbspUSlm4n2KDeCbP8rpQ0h/Bn37qyu/vVh9mvo3uHM/+jjXhUEz6iVY1sRU8QjIsM4wJl9aNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(7696005)(6916009)(5660300002)(86362001)(55016002)(6506007)(38100700002)(16526019)(186003)(52116002)(8676002)(66946007)(66476007)(66556008)(1076003)(54906003)(6666004)(8936002)(4326008)(498600001)(2906002)(142923001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?l3HaDAjVc3gg445UhRkTYkvCMfGwMAPIZSpTpNYj0fEH/nZ0Ndcy4dB11Ech?=
 =?us-ascii?Q?5TB47qXLCIN6ucRy74x36C2fADcjuKCmm5AoIT/CJsQbUUf7odTNvY6aR90v?=
 =?us-ascii?Q?WkcBJNuOuSLfoqtxFRIsB5gjQpbMckB/2MbJK3j91oCAzGmHvhcS8ErnnZi8?=
 =?us-ascii?Q?3FyuVftRx4FcHm6vyOPlagXmSto84iWFXTC4Xm9/OvZbdzsA/Tjc/DK/DTAx?=
 =?us-ascii?Q?pxHs46O06LiTCsIi4+wAnEoWIM1Vmc8XgxRXg85NI01I7R32XTlJBCDPW9oK?=
 =?us-ascii?Q?fDU3bDrkj5tRJtCb/e1oxTsMpNihPi/MbxZe+/bBY0FbkvZ2r3A8CAM8gwf+?=
 =?us-ascii?Q?Agnv/tk6NCyFJPOynzgISAZuOsuD+4BtaUTRB2BovyLHpGCDEODCxuEp2FeV?=
 =?us-ascii?Q?FXIp2ykhye9z51Hqege1z8UzIcfRRxw6qiahwgFv7cCIFVIsZsNcQHib/dTG?=
 =?us-ascii?Q?HDP4fsNNJl4XsGAIVGh4HUEeIUHwRmK5WjvPJW4/xErhtfPzPyytuify2XB5?=
 =?us-ascii?Q?GE8KGMkWwmZoWF6x9M6JiK3NNQbAQ4UJVnAeKodw1K/uiiNu+9Ro6LI2OBa5?=
 =?us-ascii?Q?eAJZgo4+Ug4MYJ5cjvkIZTcFp9ZOL51eLlbnDcS4mIRbjGBLGCZUBPJiyn7W?=
 =?us-ascii?Q?OnQvhMBQzltUFHR80gQGWfIedQ1XLJ+/TUlYr1PixBSr7RsDW3F/7BXGTtVu?=
 =?us-ascii?Q?Jb35xjuCxWwaLUImX42Z/PdHc1F7VlqfyBUeTIUoCM6x81VJ10fPXzjgd0vc?=
 =?us-ascii?Q?A6noz2k8dKKFgbO0KKAikfS+VzZLbAtmwFa4fhwN3LTZq8tFIVW6ThNoKaA9?=
 =?us-ascii?Q?tDIqpJHtmZEEEW738V5p9lt3FpTnZPXm1iCtOBbcXAcLMWtz4hQig8JfZ+2b?=
 =?us-ascii?Q?MkX74qsx6Uyw7Zdgs8opwaw5jOe0su5Gs4PLUQptoEwP0vpSoWYeYKkjrucL?=
 =?us-ascii?Q?4O3cV+6p51FqnLwbYkcpi8/tJPPbWstJcpgXqB9Z+RdiJOm3ehedsxOOQF4z?=
 =?us-ascii?Q?PlEIpOEzrrE3Mn9/Xx2G5fg5O2qW3109nI6lS1ALlRdpyOVPGfGz5D30TDxT?=
 =?us-ascii?Q?/Ew0d7h5fmcUnzfmTJhs8jo9kwzgXlubMOyaox7pZSE+LtSmBZeFq3O6o2HA?=
 =?us-ascii?Q?BqnU5b9cu4AjXyTpo9b6VSzdedMip46ovXzC8K40ysZQWRzIf7mTOVoLnnof?=
 =?us-ascii?Q?bgIHpf5866qbEGuNi29MjUWacbV9K12YtzpxkONulTipOBc7YeyDQRBiZXsZ?=
 =?us-ascii?Q?PRyt/QSY8HzPcoslzlABjhbjE5cIv5/iMc91jXMEwjhby094QRI7exyZCoyb?=
 =?us-ascii?Q?mJuEtKOdyQSqUfp2VYji590EovvWN/edfAWroL4LWIlJag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b4fa50-95af-4e20-c443-08d909a93386
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 18:20:57.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXCti6/okOybELWO7NNyEWWygOlHHkP35OIYn7EiZ2BZolqO4MZjhh8QPar3WeS/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4882
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 5eCbYOCbj3cs7cpQbmrR76427G-dC5fu
X-Proofpoint-GUID: 5eCbYOCbj3cs7cpQbmrR76427G-dC5fu
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-27_10:2021-04-27,2021-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104270123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 01:42:40PM +0200, Jiri Olsa wrote:
> On Fri, Apr 23, 2021 at 02:37:28PM -0700, Martin KaFai Lau wrote:
> 
> SNIP
> 
> > +static int collect_listed_functions(struct btf_elf *btfe, GElf_Sym *sym,
> > +				    size_t sym_sec_idx)
> > +{
> > +	int len, digits = 0, underscores = 0;
> > +	const char *name;
> > +	char *func_name;
> > +
> > +	if (!btfe->btf_ids_shndx ||
> > +	    btfe->btf_ids_shndx != sym_sec_idx)
> > +		return 0;
> > +
> > +	/* The kernel function in the btf id list will have symbol like:
> > +	 * __BTF_ID__func__<kernel_func_name>__[digit]+
> > +	 */
> > +	name = elf_sym__name(sym, btfe->symtab);
> > +	if (strncmp(name, BTF_ID_FUNC_PREFIX, BTF_ID_FUNC_PREFIX_LEN))
> > +		return 0;
> > +
> > +	name += BTF_ID_FUNC_PREFIX_LEN;
> > +
> > +	/* name: <kernel_func_name>__[digit]+
> > +	 * Strip the ending __[digit]+
> > +	 */
> > +	for (len = strlen(name); len && underscores != 2; len--) {
> > +		char c = name[len - 1];
> > +
> > +		if (c == '_') {
> > +			if (!digits)
> > +				return 0;
> > +			underscores++;
> > +		} else if (isdigit(c)) {
> > +			if (underscores)
> > +				return 0;
> > +			digits++;
> > +		} else {
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	if (!len)
> > +		return 0;
> > +
> > +	func_name = strndup(name, len);
> > +	if (!func_name) {
> > +		fprintf(stderr,
> > +			"Failed to alloc memory for listed function %s%s\n",
> > +			BTF_ID_FUNC_PREFIX, name);
> > +		return -1;
> > +	}
> > +
> > +	if (is_listed_func(func_name)) {
> > +		/* already captured */
> > +		free(func_name);
> > +		return 0;
> > +	}
> > +
> > +	/* grow listed_functions */
> > +	if (listed_functions_cnt == listed_functions_alloc) {
> > +		char **new;
> > +
> > +		listed_functions_alloc = max(100,
> > +					     listed_functions_alloc * 3 / 2);
> > +		new = realloc(listed_functions,
> > +			      listed_functions_alloc * sizeof(*listed_functions));
> > +		if (!new) {
> > +			fprintf(stderr,
> > +				"Failed to alloc memory for listed function %s%s\n",
> > +				BTF_ID_FUNC_PREFIX, name);
> > +			free(func_name);
> > +			return -1;
> > +		}
> > +		listed_functions = new;
> > +	}
> > +
> > +	listed_functions[listed_functions_cnt++] = func_name;
> > +	qsort(listed_functions, listed_functions_cnt,
> > +	      sizeof(*listed_functions), listed_function_cmp);
> 
> I was thinking of doing this at the end in setup_functions,
> but we need to do name lookups before adding..
I am planning to just use btf__add_str() as Andrii suggested.
Then most of these will go away.
