Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336B94285A3
	for <lists+bpf@lfdr.de>; Mon, 11 Oct 2021 05:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhJKDqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Oct 2021 23:46:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230358AbhJKDqf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 10 Oct 2021 23:46:35 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19AFWDb9002378;
        Sun, 10 Oct 2021 20:44:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=l56SgOf/A0cXSreXmPDyzYPIc/oEd0HNCtb3zGoxGcI=;
 b=MtJWBPWsleESUkjYxdLfMyg+TsQP1erhPHrc5VxHWc5NbM+RLbNlOBloXZFY09Gm2SEr
 GwPs410rrpyVNEfflpc3lYQt+mr9fltfXSKsR4AnwsM1fE39p6+UoM/VXmon4uc+mObA
 fDL4WXRWnkt5UjcUI9aU+ZvxdpEsU3GhXns= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bkucnck7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 10 Oct 2021 20:44:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 10 Oct 2021 20:44:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5CsGKKltSS2w+W6xNuiYunJoAWOUGEWmRL2/uVtekkP+LpWQGEGNjsAS36wx8Am+AQNIQdVfRbIbNn+UBqQUAiZm14J4rGrTQlXKHsSSvllnseCBu40y7vGyJ8UUweddHlpPPSMYYa8ACU9WirWRU85T6zX89UvbnQWmMcPl8SJQt21uHAdj5I2Z6NijleXGtjGAhkzED+eb93szif7z0f+ai8Oug+bf5R7eOlBfLDIEAkRvOaOEFbvKEpUlI1vZk3Sn6LpBpWwQ0Vbow/wCXZdYmAONDVVIQCsT/BujnNklHIjmt5Ukn2OWH7LcraoeGoKBxv9503THmFwUHnQ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l56SgOf/A0cXSreXmPDyzYPIc/oEd0HNCtb3zGoxGcI=;
 b=Zz3f6fE2tkqSffeIARK8VyhHKSnDAHLjy9a3wJ7990/aHNKfw+E6uZWDnoYaiYcXV3gvY1eWBcuuyh6uLrV9JXYoI7AFkpiNB9A2iFYztwN88Dm4X+150hKD1WvuWynkiYPCjg2XTr/XiyyjeQgZgRAtxy9ul6QbH9R6S9r2qnIuCmnH2z1oKlZUnkr18uOw/x7HGG/agNMoqloBDlnFkU+VinWR304CQFAYxy8yBmavfEIi3cbFQlPA4+l91+JwJErQDIN8j8sHASJcysUkVowxPGMX63cenGaF5mQy0FNdk5Gu6DOWmwByYxKqS4ReFwVFH3DNQAQiQndEweOrAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1706.namprd15.prod.outlook.com (2603:10b6:4:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 03:44:14 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::955c:b423:995c:d239]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::955c:b423:995c:d239%4]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 03:44:13 +0000
Message-ID: <722b63b0-0f61-f3c0-2c6f-91b0f6f61c25@fb.com>
Date:   Sun, 10 Oct 2021 23:44:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH bpf-next 2/4] bpftool: use bpf_obj_get_info_by_fd directly
Content-Language: en-US
To:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20211011022704.2143205-1-davemarchevsky@fb.com>
 <20211011022704.2143205-3-davemarchevsky@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20211011022704.2143205-3-davemarchevsky@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11d9::13b3] (2620:10d:c091:480::1:e065) by MN2PR05CA0057.namprd05.prod.outlook.com (2603:10b6:208:236::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.4 via Frontend Transport; Mon, 11 Oct 2021 03:44:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe353f6-0448-4aef-cb03-08d98c69648d
X-MS-TrafficTypeDiagnostic: DM5PR15MB1706:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR15MB1706C484200CEA5A263BB6E4A0B59@DM5PR15MB1706.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h0rF7XBD8vJcxWTuCCZgIdphBhrCc5x533dd80hFGeV1dvkTVbJ0P7wrnIq8DlHzFn8Lei/7RafP6bzb6SEMUGcfOt5iBjmttEaSwxKNy2HFy71AGQbrCuXhwfIkAKppuN3h974+9iDePqvzkSG9+nq76P1O8mmp9Y3hNQtkCUhLtFb6QHtcc6c9XxxuT2Z1W4t3IpPcR2Up1epJX0EiZ8MoyEWmoWCr0wk2HPXguCQClRDoKrRI3ZosF/lhqmvnU/dRYjfn3du4CBi3L1PCp14oRKNSA5bTikcrOJdQNWFXKoixt+GsZnbndrqY2ySRjn/t1vzGzPANNkwSwlLxMtXj5a9pyylUUBrbYbtLl8RgRlWA104fXDiw054Pk2zMBQ0v1k5FNzwBnr8iOsu7SWE9GTKkxYVqY5ik/X5m3N9JwkMF2Q1WizxUDFvH8XcmlO6JPcRI5kKkc+XXmp/7S0AK8okm7K5iS2tDWqYJC9xD2gUZFhFiN6SVubY1ACGPZ3WCWV5NjpJaM07qf11RXFecRcEbFuE3WBaAOP+1e6pu4npQobrllTGse1C5iq9WQDBbEe2n9XfIAq7aUJU/Cda7O6U+ue4f20VEsXMpz0JSLSxjWHN9vdll+T5lDYrsqnxbY8TUJ7ooakls9mNef+l1Sufsp2xjCxEyQx/gBinjiepHCm3q1yHR3b34Fz7CwsRyTT6Ft1BIGj/20DcDxDBLe1dS5GGy/R4OkNgc7V0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(36756003)(4326008)(54906003)(38100700002)(8676002)(2616005)(5660300002)(66946007)(53546011)(86362001)(508600001)(186003)(66556008)(31686004)(8936002)(316002)(6486002)(2906002)(31696002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cC9ibFNwV3lndnZMeS9RdlQ3SnkwZi9BMzJ1MUNYOWlHYmpGWGc3bzNBREJS?=
 =?utf-8?B?MGMxakhkYlpkRUMwcXdoMzRXNmZJWjJqSzB1Vlk0Yi93SHBjcFdTU09JQ3RU?=
 =?utf-8?B?WUFMNHo3TmZRUVZuQXM2R3dLYW9qUkpEYm5uaXhkbHdicURybkRXVkR4YzBh?=
 =?utf-8?B?TEpTak12LzhOV2RLV0hnekpuaVV3eDRWS0NPR0wrbm4xRWNRR2wxeDRTY2Q2?=
 =?utf-8?B?eG5jMUpsQU5pNE9SOWdEQUZ5eUlobXNMVDZGM1NjSWhZSWI4Y0ZvZVhVTDk1?=
 =?utf-8?B?eXFpTWJoUzZteUxUdGdnQzRrVjhQdzNjUWhpK3pIckdiZ3c3UVU2eDVOK0V1?=
 =?utf-8?B?QlFJQkFhRjVOVDV3bW1tU2ROdFErL2U4djVWWkthZE9HT2xxT216RmpPRkNN?=
 =?utf-8?B?ZFh5Y0FTalZkZTB4YmJCZ2VJZUM3OHJtSnh4bUlkQThFMjhoZVE2L01HaUhs?=
 =?utf-8?B?b0xrTGkyQ3BNeGVRaFhEaStzcWR6WUpUeWRyMUYxc241alhQc1FnTFhmdE5L?=
 =?utf-8?B?UUYrM0hGOWhoTDd4TURUcDVlSWpESUFxNXJWeGN5V3hra2FpWWIyUXRLZ0dF?=
 =?utf-8?B?cFF1QXUwc3lyVWYwY2hXazFldlQ2S0NpeDc4WXhiL0dSTUJxdnkvYzMyckR5?=
 =?utf-8?B?V2JlUXJMYnNhY1pjNlY5ODVraGhpN0hPcjVQN2xteXhkeVlObG9IM09wV0ox?=
 =?utf-8?B?VlpqQU1SVFJzaVF2M09xY2tyS25GNmFmUTN4MCsyK01VcWZWeVlTUXF3ZnlT?=
 =?utf-8?B?QkF6R2lvanNWWXU5M2lPV001RzNBcDUwaU9saHpITHFUS0d5b2hQcjd0RWJn?=
 =?utf-8?B?eUJLYS9mcThGejMrVTJyOEsrTWluMkVsbEEydGhUQU1xR21WYjNnNE9QK3VU?=
 =?utf-8?B?K2ppcGRGdnYzdUUzVlQ5Nk5WVUZPWkl6RkVocDJ4bU80OWxxRXNuKzdzNmE5?=
 =?utf-8?B?YXg4dzNBcmRBR25ndFplT1lKOUUvVmp6NWYya2hGeTRmSFEwd3FLTkoxMXlS?=
 =?utf-8?B?R1ZmVmZSWHY4RUpPRGpNRlgxQW5nZzlJcUdVdlI1bS8xSTZWRHpORXBqb0ZL?=
 =?utf-8?B?dVRpM1E3NGRwZlQvYks1LytXSUNmaXRCbFpheFFRZHc4eEpOZjJNdmRKbVMv?=
 =?utf-8?B?UEFHMlM2ZDlkMEZ2di94QWFPMVJ5cGxnTnNhR3IvTkszRDhIaTE1MVgvOHJ6?=
 =?utf-8?B?a05OdVovMklTNGpmL0FqdzJiNmFvYm5MTDdCL0JIU0JnNmdzWXdQcGlpZEZa?=
 =?utf-8?B?Y2RHNE9CTmdYa3lUYno2c1lqQzdublo4Ym1NNWJaMnZGcGtzSTFMQXJxZDRy?=
 =?utf-8?B?YUh5dGlhb21xSlZmNWVIUWRHOUxndHJadmxrWEJXQXVyUzRiSlU5ektMbGE3?=
 =?utf-8?B?Unl0M3Z1ZkJ5RGc1QkJXak91cjlES0tLNkRzV093VklLN0ZvUWdPSTJpcWNn?=
 =?utf-8?B?UmoxK3FNMWsxK0o4OGZRRjVqanFvZEdvNVhzRUFHaDQ2RlNRVkRIRVNQOERW?=
 =?utf-8?B?RkRlSFNPUGxCUURIY1Y3a2Z5cG9SZlJNS3p5aEtjYXR1NW9mUm5EVUhVbUZD?=
 =?utf-8?B?cEV0UTFSKzlWK1VXZXpwRmFSblFiUS9lOVYwbExNM3l2amNKcGtkeUVRSFln?=
 =?utf-8?B?bVZtS0tuUWlmbmgrWU14M3ZLSEMzYVd5NGdPbmpRNkpXb1hyRlpFdGJJc0ZU?=
 =?utf-8?B?ZWw2em0wOFRUYnprcHhkbldmYVNhOUpDSU5vb1Z3dVBwbXVZYmNmU2NuOEJw?=
 =?utf-8?B?ZGh2V0lPUTdRb2k0Q2pRNHYvV1ZCdWxla1FpZkl1YVlYL3ZDZDZjRG1URDRZ?=
 =?utf-8?B?RWpodWdGdGZxelo2a1pHUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe353f6-0448-4aef-cb03-08d98c69648d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 03:44:13.7598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AK9fd40ndghLYohUy733o4rzrMPNUWOtNfDPwSNIahqvZbdr6BDc3UAm7uBA+NuJxPVKpfbdszMZgXox2Qkxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1706
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: QJd61hmgEz_dCFx33NgpbXrPGXZCdXEa
X-Proofpoint-GUID: QJd61hmgEz_dCFx33NgpbXrPGXZCdXEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-10_07,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=947
 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/10/21 10:27 PM, Dave Marchevsky wrote:   
> To prepare for impending deprecation of libbpf's
> bpf_program__get_prog_info_linear, migrate uses of this function to use
> bpf_obj_get_info_by_fd.
> 
> Since the profile_target_name and dump_prog_id_as_func_ptr helpers were
> only looking at the first func_info, avoid grabbing the rest to save a
> malloc. For do_dump, add a more full-featured helper, but avoid
> free/realloc of buffer when possible for multi-prog dumps.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/bpf/bpftool/btf_dumper.c |  40 +++++----
>  tools/bpf/bpftool/prog.c       | 153 +++++++++++++++++++++++++--------
>  2 files changed, 143 insertions(+), 50 deletions(-)

[...]

> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index a24ea7e26aa4..a7507cc165eb 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -98,6 +98,72 @@ static enum bpf_attach_type parse_attach_type(const char *str)
>  	return __MAX_BPF_ATTACH_TYPE;
>  }
>  
> +#define holder_prep_needed_rec_sz(nr, rec_size)\
> +({						\
> +	holder.nr = info->nr;			\
> +	needed += holder.nr * rec_size;		\
> +})
> +
> +#define holder_prep_needed(nr, rec_size)	\
> +({						\
> +	holder.nr = info->nr;			\
> +	holder.rec_size = info->rec_size;	\
> +	needed += holder.nr * holder.rec_size;	\
> +})
> +
> +#define holder_set_ptr(field, nr, rec_size)	\
> +({					\
> +	holder.field = ptr_to_u64(ptr);	\
> +	ptr += nr * rec_size;		\
> +})
> +
> +static int prep_prog_info(struct bpf_prog_info *const info, enum dump_mode mode,
> +			  void *info_data, size_t *const info_data_sz)
> +{
> +	struct bpf_prog_info holder = {};
> +	size_t needed = 0;
> +	void *ptr;
> +
> +	if (mode == DUMP_JITED)
> +		holder_prep_needed_rec_sz(jited_prog_len, 1);
> +	else
> +		holder_prep_needed_rec_sz(xlated_prog_len, 1);
> +
> +	holder_prep_needed_rec_sz(nr_jited_ksyms, sizeof(__u64));
> +	holder_prep_needed_rec_sz(nr_jited_func_lens, sizeof(__u32));
> +	holder_prep_needed(nr_func_info, func_info_rec_size);
> +	holder_prep_needed(nr_line_info, line_info_rec_size);
> +	holder_prep_needed(nr_jited_line_info, jited_line_info_rec_size);
> +
> +	if (needed > *info_data_sz) {
> +		info_data = realloc(info_data, needed);

This breaks 'bpftool prog dump' for multiple progs, need to pass info_data as
a void ** so that the original ptr is updated on realloc. Will send v2 shortly.

> +		if (!info_data)
> +			return -1;
> +		*info_data_sz = needed;
> +	}

[...]

> @@ -791,16 +857,18 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>  
>  static int do_dump(int argc, char **argv)
>  {
> -	struct bpf_prog_info_linear *info_linear;
> +	struct bpf_prog_info info = {};
> +	__u32 info_len = sizeof(info);
> +	size_t info_data_sz = 0;
> +	void *info_data = NULL;
>  	char *filepath = NULL;
>  	bool opcodes = false;
>  	bool visual = false;
>  	enum dump_mode mode;
>  	bool linum = false;
> -	int *fds = NULL;
>  	int nb_fds, i = 0;
> +	int *fds = NULL;
>  	int err = -1;
> -	__u64 arrays;
>  
>  	if (is_prefix(*argv, "jited")) {
>  		if (disasm_init())
> @@ -860,43 +928,42 @@ static int do_dump(int argc, char **argv)
>  		goto exit_close;
>  	}
>  
> -	if (mode == DUMP_JITED)
> -		arrays = 1UL << BPF_PROG_INFO_JITED_INSNS;
> -	else
> -		arrays = 1UL << BPF_PROG_INFO_XLATED_INSNS;
> -
> -	arrays |= 1UL << BPF_PROG_INFO_JITED_KSYMS;
> -	arrays |= 1UL << BPF_PROG_INFO_JITED_FUNC_LENS;
> -	arrays |= 1UL << BPF_PROG_INFO_FUNC_INFO;
> -	arrays |= 1UL << BPF_PROG_INFO_LINE_INFO;
> -	arrays |= 1UL << BPF_PROG_INFO_JITED_LINE_INFO;
> -
>  	if (json_output && nb_fds > 1)
>  		jsonw_start_array(json_wtr);	/* root array */
>  	for (i = 0; i < nb_fds; i++) {
> -		info_linear = bpf_program__get_prog_info_linear(fds[i], arrays);
> -		if (IS_ERR_OR_NULL(info_linear)) {
> +		err = bpf_obj_get_info_by_fd(fds[i], &info, &info_len);
> +		if (err) {
> +			p_err("can't get prog info: %s", strerror(errno));
> +			break;
> +		}
> +
> +		err = prep_prog_info(&info, mode, info_data, &info_data_sz);
> +		if (err) {
> +			p_err("can't grow prog info_data");
> +			break;
> +		}
> +
> +		err = bpf_obj_get_info_by_fd(fds[i], &info, &info_len);
> +		if (err) {
>  			p_err("can't get prog info: %s", strerror(errno));
>  			break;
>  		}

There should be a memset(&info, 0, sizeof(info)) at the end of this loop. In 
current state, when dumping multiple progs, previous iteration's populated 
info will be passed to first bpf_obj_get_info_by_fd call in next iteration,
resulting in unnecessary data copying.

>  		if (json_output && nb_fds > 1) {
>  			jsonw_start_object(json_wtr);	/* prog object */
> -			print_prog_header_json(&info_linear->info);
> +			print_prog_header_json(&info);
>  			jsonw_name(json_wtr, "insns");
>  		} else if (nb_fds > 1) {
> -			print_prog_header_plain(&info_linear->info);
> +			print_prog_header_plain(&info);
>  		}
>  
> -		err = prog_dump(&info_linear->info, mode, filepath, opcodes,
> -				visual, linum);
> +		err = prog_dump(&info, mode, filepath, opcodes, visual, linum);
>  
>  		if (json_output && nb_fds > 1)
>  			jsonw_end_object(json_wtr);	/* prog object */
>  		else if (i != nb_fds - 1 && nb_fds > 1)
>  			printf("\n");
>  
> -		free(info_linear);
>  		if (err)
>  			break;
>  		close(fds[i]);
> @@ -908,6 +975,7 @@ static int do_dump(int argc, char **argv)
>  	for (; i < nb_fds; i++)
>  		close(fds[i]);
>  exit_free:
> +	free(info_data);
>  	free(fds);
>  	return err;
>  }
