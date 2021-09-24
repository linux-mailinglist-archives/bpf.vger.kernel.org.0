Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F25417A0E
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 19:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344597AbhIXRxW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 13:53:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344431AbhIXRxU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Sep 2021 13:53:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OHUkoG029970;
        Fri, 24 Sep 2021 17:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=vTzL7P+U2+2aRtRf46wWlyDNUr1U4BVLFJ+GQiDI8us=;
 b=iiFrXRKjF6fHLwfxTnZEZVgG+xqWq9p4flaQe+SbRrIzWGvyNunkdhTtS6+hUxLT6Acb
 V0sEQFxrytDraFGw2glvlJXoGZBArQWDE6TxJD5i2szCE57NVulgpd1w0435hiQ/CUu2
 IX/48sBcgUb1v4Syj7iQ/cvBP+FjpqVInyK5GmosZFP0twzHQs96umBEfTOWgC6/cgOL
 Tq2KhA8NT+Z4CItfvXwN2hgMsVIVi6FzmwkFGoWYWiQucH91HFyawCRip/IZmXmpSJqa
 DZmmwu3ziC0huP4tgyJ/gBxeIMHoy8ZH72yU6wG/f1efk6MDwFnZoUjV9LPQ6Ra9EQi1 Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b93ey4q5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 17:51:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18OHni2V045737;
        Fri, 24 Sep 2021 17:51:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 3b93g3jtnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Sep 2021 17:51:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=huSCGlSuoB7iUbG8tM5PUHbrWR/HpCjKrAwl8CFOyWr9USmUIdURbKXdMxoXE3Lg/CTubIYAqqHCHlzFmmPl2NTHWNTWDiFj9Al/bjMRy4Sw/nAQIFrXwj1//ZbxU49GWgi0w4yA9V1SZUxXlCANLyPopOCb0bItYDRkQ/aI10dqjiZYZ37WaBL/dzYPx6geSSkVG6lAGjD4WAHFdwTItLgEb0I+w1l8Fq3U0BJOOm2D7U50my5M759/H3RLsJJwf2HtD1KezglvbX06Uda9q70LnNh/bx4+8GBCNlV5t14etKR2XSHzLyjhmOHsW5Cy0lPrf2lLgUtFiJjbZ1gA1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vTzL7P+U2+2aRtRf46wWlyDNUr1U4BVLFJ+GQiDI8us=;
 b=hUtVZW9ZOBLwli55S36f7TDbULl6fvK2b9hzoLkX4X9cNmYI4g925YN3nIzdoFHx+mpORXMn4gz+BVd4C1DlsWo1ArZBEUIIt0G0rzgTUHxR48PQJ1x0UNXXr0OaZ2Jg+UmJtlFE7Vr/LYVS0fRgo0PEJQDwJH/CkMHNXUysb2taM9mjX42g4WXO8snnZFb+3cOv96dYLqoIufdViWoSgWZhRqeyWQBm1Bu24rhGFUjKGnO9q6K+BIE5gWM5LUoN+hWV3ppi9QJjC9vM7vTrH3phjjO/u4ZDObPscOI5bd3DsTLdhvE0iKcDxTTNC3bECzWrNALpPgureBgSyBEi4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTzL7P+U2+2aRtRf46wWlyDNUr1U4BVLFJ+GQiDI8us=;
 b=Hcchs2RcU6Ag3lvlVPfyrF4gsLB9yOIYN7yl4M10k35kzVYL9OE4mFcre3sB4z0g/mOLZPgkdo89LRQw5qjeuVMZag/F94ZpGEmy35I4a534KPxi8u+LG7NEykZoYMvkz1eYc1crJ04ijY+xkeQa7ji07tA+iACxn9oVB++32S0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB3551.namprd10.prod.outlook.com (2603:10b6:208:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 17:51:11 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9dc9:24ec:f707:cb53]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9dc9:24ec:f707:cb53%7]) with mapi id 15.20.4544.018; Fri, 24 Sep 2021
 17:51:11 +0000
Subject: Re: [RFC PATCH] tracing/kprobe: Support $$args for function entry
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163240078318.34105.12819521680435948398.stgit@devnote2>
 <163240079198.34105.7585817231870405021.stgit@devnote2>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <aba162cc-8ee5-45e1-e29b-60118bc2a980@oracle.com>
Date:   Fri, 24 Sep 2021 18:51:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <163240079198.34105.7585817231870405021.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::47) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
Received: from localhost.localdomain (2a02:6900:8208:1848::16ae) by AM0PR06CA0106.eurprd06.prod.outlook.com (2603:10a6:208:fa::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 17:51:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29a71dab-1358-4deb-f42f-08d97f83e518
X-MS-TrafficTypeDiagnostic: MN2PR10MB3551:
X-Microsoft-Antispam-PRVS: <MN2PR10MB3551919124AFB442BA99410EEFA49@MN2PR10MB3551.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fhmdpzv/SWV1xJJlnP7u+eAiw775M+OR1hlqRChG834QivC583vMOy/PDSCK1/JjwSBGuehOTMNqvy3SFB8MQqAeq6+znGcUphqV2Z74cwZtZtbWkXvPJqKTOFz5OhFlG61PJenzcRvloindRVhrY4ATHBiSF/Eu7drAuCvl1ScYTI1ozVZ91oD1Fqi4dRGNHI36M8AG9Mni7w/ZQ0Zvs/ue3Z5qkn2h+JZYm9a1ZA8J4MPjp0YQ/H3p0xgyfwgS20F7LnrktAsRiDsJFjC+lTTNfTPYopjqpbd5JHHCINQheHieVb/y8tQlF7cnVfe+BOwSnn7ml+6Dc9tcIjAXrCztryghhrF/hWE9lNh+vED/vx3J5uEeLq+4L+Yx66RG4jd+oDZHkePMFt7AACyl7kXJTM0PdottFibLezhLtJMQmA+9Vy3r5gMfua1AIodtmHfpgm8+ugRZsoN7Q0B1ncriXz3BATi5XIr3tcL8oVVJOaggfXG7ByfGKAtKSm6nUgfnQ2GHbN888dqGOMB8pFc+UVkl8FmTnXcd99hjjuqk8WiYITu+c00iMBEdHDYcKKssxQHhrPDn/91Jebh7ISJqwS81fJEEXgYM60kk7Hn0TxpKlLUTfNs9a2BXckXemN+kdsTyhMevFnwSQKerbIvYeWEV7aSvwqK4edod+CnFpDRywsbcaq1Ph4Evf+/GoJg/nJ3aS35zFhztkRrAIVp5yp2obYDWdx0X/0oMDrjP7fblC/x3TsJVKHkRbNK8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(2906002)(6506007)(66556008)(8676002)(6666004)(44832011)(31696002)(4326008)(6512007)(6486002)(83380400001)(52116002)(36756003)(86362001)(54906003)(8936002)(2616005)(316002)(186003)(66476007)(38100700002)(5660300002)(66946007)(31686004)(508600001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2RpU2RCbHlMTE5XckhjdnFRUDAweEt5dHc4cUxXSCs2dnpUQ0N6TzB2U0g5?=
 =?utf-8?B?YmZNVGFsbE9mbVYxTDQ2cVlqaDlTQlpsdFhKaWJUczJzckZkeVZFWDJEejBi?=
 =?utf-8?B?RzZ3OXVXZWh2KzNjMVl4c3lwbnQ1M25IRmovYkVxNS90TUxGSVkwcldPNTFi?=
 =?utf-8?B?M1lTNlJsVy9hSFk4UzExUXR3TFdkYm84R1ZtbFc0TTdvcmIzMVRENHY2OEd5?=
 =?utf-8?B?T2dvUU0wOXdyRlhnUzhzVjdrczlpZnZTMG9tMkNlRnc5WGJkUU1FZEttZFFV?=
 =?utf-8?B?S3RYcE1ZYVZyZXUzc3MwdGFNdVVLclQ5YTBPTnJKRTM4VDF4MWFIM3pmVHZy?=
 =?utf-8?B?TW54R2RVRXBuMnliTHU0czB5VzVTeDlnYXBVUkwwajV4NUlOV2prak5pL3U0?=
 =?utf-8?B?akFGQWFaL3Rqdm9BK0hZd1Q4SzNWTGN1Q1F6eWVqSGkvcnhLQzFYblpLbmhV?=
 =?utf-8?B?aFpzdVp2R280cEc0M1RrZmRUWTR1UTFzMmlyVlAyTHJFNkdKelU1N3Q2cGJ0?=
 =?utf-8?B?Qmllak9IbVFBcnJibVA4Y3lGcEpRQThLcmxLMFh0TkozVUdtWHpVOUZWNHVv?=
 =?utf-8?B?OURqb05MZ0JuN1czVndrbGZsWWZJN0hnYm1aVDRYVXJhUEFJU1I2TFoxdEgv?=
 =?utf-8?B?dlpwdW4ra3R6NVRrQS8xaG1vUkU5TTNrMVRWTEUvOGphM2RoNDhRZVdMdFhl?=
 =?utf-8?B?M0o1OGJ0bWl5NzFHc3NlMy9VZ3F3Y0I3SHRKalRjTWlJOEtFdWhOb3ZrbDdx?=
 =?utf-8?B?SVJhRHpnck42NjczSC9udFZReEtOd1Vqcit6TDBuQ1VyQm9YZmNSZXBvRHdk?=
 =?utf-8?B?MEZHWEJHb2llMVhmT2QySGZ6Q203dXArUzlheHQ4blhWc3Uzem5HWlR2RXVC?=
 =?utf-8?B?Tldwb2ZnY2FISGlwNC94MDZnUWhVcmRVenFhWW11MkplL1UrblZyTkZtSkFt?=
 =?utf-8?B?VENHMHRWNEN1aUFkS3ZiR2RtWFBpTXlmMUlaSnlXNEROWW9Dbzh1YnY1ZHFP?=
 =?utf-8?B?a1VadkRxZHdVWlZyQkhsdWordnRUQ2tGYW56TkpnNGNqSnVkRE4wVUpqcEs5?=
 =?utf-8?B?Z3o3Q0JrNjRGQUczQVpkQ3c1clF3UGRRWURzT0VZd3lvNDRCVlIzTGRiSE14?=
 =?utf-8?B?N0NoZ0JwNWxnRlZMQWlnaENYWU5YZkloZXNONDVTZEdtWHA5emgwSkxJaGox?=
 =?utf-8?B?VkJZc1J6TmV5UjdWT2I2QnNSNWl0MUZoUUNUVGhMWks2VUp0WXBZQ3VQOTNw?=
 =?utf-8?B?aUd4N3FobGdpelpjYnB3YkJBZzU1Qk5UeGJvTUVmOWlTY2w3cjRicWFOQjZo?=
 =?utf-8?B?czhyczloS1JpOWJTYVRTb055aEkzb0gyT3dMRWZvZTJvVHdpSG11N2k3QlNm?=
 =?utf-8?B?UTMyZm9aaDJVbzVleXdhSnlGTnBSRDFBYWxHV2dLbS9mc08yczUzRmk5R2R4?=
 =?utf-8?B?QUtSd2ZqWVdXcXo2bllEN0xodWZ4YlgvZUJLV0RXWEwyMjRra3hvWmgwZnY3?=
 =?utf-8?B?QytaMHJyZVpNTmVwcmdSQ0swSTJ1aDJidysvdVhOczJDR3FtQkR0VmRyWW1x?=
 =?utf-8?B?L25ma2JHYS9JdktFZHBscGpDVnRrNlhrV1d2NmFNMlY1VVBoTlF4WTdOcE1H?=
 =?utf-8?B?ODVmbzRsQjdicmFnY1hMSVVCY0FpbVMrOWJyVmhtOThWN2tST2l3eFpLK3dr?=
 =?utf-8?B?UHcrNENwYXR5dURvNkFZU3lDL1hqai9icXo3Qm5Qd1VPVHFGL1NmZHRQRCt0?=
 =?utf-8?B?dzNObnJrOEd0a0JydHNRWUFxQkdMMmNmS2R4SWxBMzJHZXc3TUZxSEdoNnhN?=
 =?utf-8?Q?8Bb1FgxnulRA3v5NU9zGXLx/xJjJlCUOyP+J4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a71dab-1358-4deb-f42f-08d97f83e518
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 17:51:11.3604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PA6TqK4TY+vVSaG/KolwflEhlPDP73ha5qVlU8NrK1Cp8or3YtOW+98e7c45RfjPGrHFtJobeHmzZXcmDZJldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3551
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10117 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109240113
X-Proofpoint-GUID: br0_ZbHYhl6YkVad5BLVatnrZdRHIOum
X-Proofpoint-ORIG-GUID: br0_ZbHYhl6YkVad5BLVatnrZdRHIOum
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/09/2021 13:39, Masami Hiramatsu wrote:

> Support $$args fetch arg for function entry. This uses
> BTF for finding the function argument. Thus it depends
> on CONFIG_BPF_SYSCALL.
>
> /sys/kernel/tracing # echo 'p vfs_read $$args' >> kprobe_events
> /sys/kernel/tracing # cat kprobe_events
> p:kprobes/p_vfs_read_0 vfs_read file=$arg1:x64 buf=$arg2:x64 count=$arg3:u64 pos=$arg4:x64
>
> Note that $$args must be used without argument name.

This looks great! Can I ask which tree you're building on

top of so I can play around with this a bit?


I also wonder if we could rework btf_show_name() to help

render full type info for the args? in kernel/bpf/btf.c:


/*
  * Populate show->state.name with type name information.
  * Format of type name is
  *
  * [.member_name = ] (type_name)
  */

The (type_name) part is what we'd want from here; no reason

we can't refactor that function to make the type name available

as a cast. It would rework the output to be something like


p:kprobes/p_vfs_read_0 vfs_read struct file *file=$arg1 , char *buf=$arg2 , size_t count=$arg3 , loff_t pos=$arg4

...if that's wanted of course (not sure what the constraints on format are here)? Thanks for pushing this along!


Alan

> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>   kernel/trace/trace_kprobe.c |   60 ++++++++++++++++++++++++-
>   kernel/trace/trace_probe.c  |  105 +++++++++++++++++++++++++++++++++++++++++++
>   kernel/trace/trace_probe.h  |    5 ++
>   3 files changed, 168 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 3dd4fb719aa3..fe88ee8c8cd8 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -712,6 +712,58 @@ static int trace_kprobe_module_callback(struct notifier_block *nb,
>   	return NOTIFY_DONE;
>   }
>   
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +static int trace_kprobe_parse_btf_args(struct trace_kprobe *tk, int i,
> +				       const char *arg, unsigned int flags)
> +{
> +	struct trace_probe *tp = &tk->tp;
> +	static struct btf *btf;
> +	const struct btf_type *t;
> +	const struct btf_param *args;
> +	s32 id, nargs;
> +	int ret;
> +
> +	if (!(flags & TPARG_FL_FENTRY))
> +		return -EINVAL;
> +	if (!tk->symbol)
> +		return -EINVAL;
> +
> +	if (!btf)
> +		btf = btf_parse_vmlinux();
> +
> +	id = btf_find_by_name_kind(btf, tk->symbol, BTF_KIND_FUNC);
> +	if (id <= 0)
> +		return -ENOENT;
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(btf, id);
> +	if (!btf_type_is_func(t))
> +		return -ENOENT;
> +
> +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> +	t = btf_type_by_id(btf, t->type);
> +	if (!btf_type_is_func_proto(t))
> +		return -ENOENT;
> +
> +	args = (const struct btf_param *)(t + 1);
> +	nargs = btf_type_vlen(t);
> +	for (i = 0; i < nargs; i++) {
> +		ret = traceprobe_parse_btf_arg(tp, i, btf, &args[i]);
> +		if (ret < 0)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +#else
> +static int trace_kprobe_parse_btf_args(struct trace_kprobe *tk, int i,
> +				       const char *arg, unsigned int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
> +
>   static struct notifier_block trace_kprobe_module_nb = {
>   	.notifier_call = trace_kprobe_module_callback,
>   	.priority = 1	/* Invoked after kprobe module callback */
> @@ -733,12 +785,13 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>   	 *  $stack	: fetch stack address
>   	 *  $stackN	: fetch Nth of stack (N:0-)
>   	 *  $comm       : fetch current task comm
> +	 *  $$args	: fetch parameters using BTF
>   	 *  @ADDR	: fetch memory at ADDR (ADDR should be in kernel)
>   	 *  @SYM[+|-offs] : fetch memory at SYM +|- offs (SYM is a data symbol)
>   	 *  %REG	: fetch register REG
>   	 * Dereferencing memory fetch:
>   	 *  +|-offs(ARG) : fetch memory at ARG +|- offs address.
> -	 * Alias name of args:
> +	 * Alias name of args (except for $$args) :
>   	 *  NAME=FETCHARG : set NAME as alias of FETCHARG.
>   	 * Type of args:
>   	 *  FETCHARG:TYPE : use TYPE instead of unsigned long.
> @@ -877,7 +930,10 @@ static int __trace_kprobe_create(int argc, const char *argv[])
>   	/* parse arguments */
>   	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
>   		trace_probe_log_set_index(i + 2);
> -		ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
> +		if (strcmp(argv[i], "$$args") == 0)
> +			ret = trace_kprobe_parse_btf_args(tk, i, argv[i], flags);
> +		else
> +			ret = traceprobe_parse_probe_arg(&tk->tp, i, argv[i], flags);
>   		if (ret)
>   			goto error;	/* This can be -ENOMEM */
>   	}
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 2fe104109525..bbac261b1688 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -765,6 +765,111 @@ static int traceprobe_conflict_field_name(const char *name,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_BPF_SYSCALL
> +
> +static u32 btf_type_int(const struct btf_type *t)
> +{
> +	return *(u32 *)(t + 1);
> +}
> +
> +static const char *traceprobe_type_from_btf(struct btf *btf, s32 id)
> +{
> +	const struct btf_type *t;
> +	u32 intdata;
> +	s32 tid;
> +
> +	/* TODO: const char * could be converted as a string */
> +	t = btf_type_skip_modifiers(btf, id, &tid);
> +
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_ENUM:
> +		/* enum is "int", so convert to "s32" */
> +		return "s32";
> +	case BTF_KIND_PTR:
> +		/* pointer will be converted to "x??" */
> +		if (IS_ENABLED(CONFIG_64BIT))
> +			return "x64";
> +		else
> +			return "x32";
> +	case BTF_KIND_INT:
> +		intdata = btf_type_int(t);
> +		if (BTF_INT_ENCODING(intdata) & BTF_INT_SIGNED) {
> +			switch (BTF_INT_BITS(intdata)) {
> +			case 8:
> +				return "s8";
> +			case 16:
> +				return "s16";
> +			case 32:
> +				return "s32";
> +			case 64:
> +				return "s64";
> +			}
> +		} else {	/* unsigned */
> +			switch (BTF_INT_BITS(intdata)) {
> +			case 8:
> +				return "u8";
> +			case 16:
> +				return "u16";
> +			case 32:
> +				return "u32";
> +			case 64:
> +				return "u64";
> +			}
> +		}
> +	}
> +
> +	/* Default type */
> +	if (IS_ENABLED(CONFIG_64BIT))
> +		return "x64";
> +	else
> +		return "x32";
> +}
> +
> +int traceprobe_parse_btf_arg(struct trace_probe *tp, int i, struct btf *btf,
> +			     const struct btf_param *arg)
> +{
> +	struct probe_arg *parg = &tp->args[i];
> +	const char *name, *tname;
> +	char *body;
> +	int ret;
> +
> +	tp->nr_args++;
> +	name = btf_name_by_offset(btf, arg->name_off);
> +	parg->name = kstrdup(name, GFP_KERNEL);
> +	if (!parg->name)
> +		return -ENOMEM;
> +
> +	if (!is_good_name(parg->name)) {
> +		trace_probe_log_err(0, BAD_ARG_NAME);
> +		return -EINVAL;
> +	}
> +	if (traceprobe_conflict_field_name(parg->name, tp->args, i)) {
> +		trace_probe_log_err(0, USED_ARG_NAME);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Since probe event needs an appropriate command for dyn_event interface,
> +	 * convert BTF type to corresponding fetch-type string.
> +	 */
> +	tname = traceprobe_type_from_btf(btf, arg->type);
> +	if (tname)
> +		body = kasprintf(GFP_KERNEL, "$arg%d:%s", i + 1, tname);
> +	else
> +		body = kasprintf(GFP_KERNEL, "$arg%d", i + 1);
> +
> +	if (!body)
> +		return -ENOMEM;
> +	/* Parse fetch argument */
> +	ret = traceprobe_parse_probe_arg_body(body, &tp->size, parg,
> +				TPARG_FL_KERNEL | TPARG_FL_FENTRY, 0);
> +
> +	kfree(body);
> +
> +	return ret;
> +}
> +#endif
> +
>   int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
>   				unsigned int flags)
>   {
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 355c78a930f8..857b946afe29 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -23,6 +23,7 @@
>   #include <linux/limits.h>
>   #include <linux/uaccess.h>
>   #include <linux/bitops.h>
> +#include <linux/btf.h>
>   #include <asm/bitsperlong.h>
>   
>   #include "trace.h"
> @@ -359,6 +360,10 @@ int trace_probe_create(const char *raw_command, int (*createfn)(int, const char
>   
>   extern int traceprobe_parse_probe_arg(struct trace_probe *tp, int i,
>   				const char *argv, unsigned int flags);
> +#ifdef CONFIG_BPF_SYSCALL
> +int traceprobe_parse_btf_arg(struct trace_probe *tp, int i, struct btf *btf,
> +			     const struct btf_param *arg);
> +#endif
>   
>   extern int traceprobe_update_arg(struct probe_arg *arg);
>   extern void traceprobe_free_probe_arg(struct probe_arg *arg);
>
