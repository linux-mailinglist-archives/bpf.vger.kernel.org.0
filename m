Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A090D2D1C33
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 22:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgLGVeJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 16:34:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34654 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbgLGVeI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 7 Dec 2020 16:34:08 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7LSMrP004469;
        Mon, 7 Dec 2020 13:33:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=6C4spxYkgpB6OQBlMNDCcH9ru3sUUiRTCwBIU8gN7wg=;
 b=SmtLpHC1z5kzttZ1660ZMzTZFFs66mjvVCL1po2OuGTdW1AShxeLPhrqk+8w/kgyE9oU
 QU1lz5fgNxlQC3vIo9275EGC4e4RdJMDZ5hie4bzV/8Ca+AgY5LwLlMejxW6/IjvgRg3
 MMFUNf9pTntxXKyML5iXDMJccuHx5EYClDQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3588wp407t-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 13:33:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 13:33:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDyZE3GoL5WXf2g0RFIaQN/QqnF0sM50QdJQ4mK1J6qf3tIRKwIy6oAM1ChREe36D7bTr5e/YpQOC74tX7lLtRjaUY4LzFu7aPoQJh5hZ0/8M3iudXo98V68MDwHUsLg48bCXRsFG7RBGqhGH1+D5KBCgqtrAICB+kerY/DAFJfBZvCLdU23+n7tqBAZjE+j4Wzf1hCl1x5VhadEhFvTEu+tIcqXtEypaVcDrC3X/pHBTe2wV+RrMTXoMwq8Jav1JYwazW/PYo9zRbEOUNVPYBroeIVgi39ZGeeUu+ra/7mIoBW8GBzSnohHSDBFl4X82QE3OZO+rnKPWrs0Gr1lJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C4spxYkgpB6OQBlMNDCcH9ru3sUUiRTCwBIU8gN7wg=;
 b=R1OIzqtZwAuaqD+VuClj+MV/tPXKXH6i3LlJWP7J3qpEgwFP26L1T5aHa1OwcTMaHq9cZTYXt5223i206DxBX4DiavzX4j7NZ3wGO8wQiSt2QiIm+fhvoZ4/Li9cnln5egh7yXPOqqqQ5Mxh4hKwe0U5tkpYrskRezVwtsPpFWlsFQXotfckr9qML439b6tKZHlPIiv1Rgxjt5BzLveN5UQEh5A2NwE9ogpeN29cuvW5zhqY+bGymvFvMV3X8uxPEkoLfq36GQX0zxsRNOn2vrx7847zxpijDnFxkLRI0wb0O5u86FHq3wG2qHBjMCO7jzX3EQZZ7/+ceJY0tiKaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C4spxYkgpB6OQBlMNDCcH9ru3sUUiRTCwBIU8gN7wg=;
 b=eEgj79qLjRTioZzWcxSjPyk/bw+wEpLlJxDAxISVIqBJE8t4wzUZ8lo9FMdB/Eygtzb92/PYCt8UYgGsbvDGNwh5xNfLNn7VyWD5UYkMfGjnDpMj5LfImDzI7aK1i67VBYjcVEymev6emxiWMizdzuff3qt+Wgj4GJ/s4j6+F7w=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2245.namprd15.prod.outlook.com (2603:10b6:a02:89::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.20; Mon, 7 Dec
 2020 21:33:08 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2831:21bf:8060:a0b]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2831:21bf:8060:a0b%7]) with mapi id 15.20.3632.023; Mon, 7 Dec 2020
 21:33:08 +0000
Date:   Mon, 7 Dec 2020 13:33:00 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Florent Revest <revest@chromium.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kpsingh@chromium.org>,
        <rdunlap@infradead.org>, <linux-next@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2] bpf: Only call sock_from_file with CONFIG_NET
Message-ID: <20201207213300.fy6xevnoidh2vk37@kafai-mbp.dhcp.thefacebook.com>
References: <20201207200605.650192-1-revest@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207200605.650192-1-revest@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:e1c3]
X-ClientProxiedBy: MW4PR04CA0201.namprd04.prod.outlook.com
 (2603:10b6:303:86::26) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:e1c3) by MW4PR04CA0201.namprd04.prod.outlook.com (2603:10b6:303:86::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21 via Frontend Transport; Mon, 7 Dec 2020 21:33:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36a95725-f3c9-44b1-caad-08d89af7b099
X-MS-TrafficTypeDiagnostic: BYAPR15MB2245:
X-Microsoft-Antispam-PRVS: <BYAPR15MB224543738F0FD32B7245E1BAD5CE0@BYAPR15MB2245.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT396mSLvSYdtZcR3iW47HzhMTCL1KZ0pmlINDBKIY8+qrkj8U4/MfL1JQ93bPoqF4kh2AXJSBGnDJ9sdqhfTzdQdB73ugSoOGyFgvkXKK9uptx/PBSqOprBor8w3jRiDDXiywd17XN9Xu1K1dslC75YjL4z0lWPKtt/5nP7gaL/HcJwKeaKBnTWDnLPpq0e66DjbFvb3p9mJeRElZGB0rIEW1Vgw80PoAciWzvY3GsLg31C/1yw80k61jUwj/+7qHcq6HMmjwDIPp4W9xZT+Uu+WKLIhTPW1lifUW3FvdtDe+CgElAyU6I1X47eGCcPLWxxtUmmCxacq5Ucxbz5VQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(346002)(366004)(39860400002)(136003)(6916009)(66946007)(186003)(316002)(8936002)(478600001)(5660300002)(8676002)(9686003)(86362001)(66556008)(66476007)(2906002)(6666004)(1076003)(6506007)(4326008)(52116002)(16526019)(7696005)(55016002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6iIE1PPGDSwVr1qEE7okVicC8RJb5Dt1rMO6U7CEMQ6VII2mYNruaiMz2JOL?=
 =?us-ascii?Q?py9/P1K0qX1vP4LijQiVZtbVxr9/g/KU/ujzv7ELm/aIvnoY0+RNEYASlGpz?=
 =?us-ascii?Q?dvLTj4AH7V4OESxhQ0D+c0Lec+QHeN/bi19jVVhexqRh1oL+By/T5Zc20fRr?=
 =?us-ascii?Q?gjfBklWhcpyr1GBucNXmUli+QqZHyjSKtUBLGtc+3G4+PFb2cfHO4IS9Df5x?=
 =?us-ascii?Q?o1CLwTres0wZGdyZDJpJoNMuubbdbgL/Ulzqm85TtlzwmY4QRZPGPigDBawk?=
 =?us-ascii?Q?Kl7xuBKrQTvhDYa3zHJ3bpB+sfek0am8/Yy+chdBuv2AAJAaQSe4nqIU1skf?=
 =?us-ascii?Q?wN6G1oqCvMTLcJl40y/wUtli7+E9ejPT0WxkE285kPhvKq+jaNnbRQpBYiRP?=
 =?us-ascii?Q?q8Oc37acDzj9SkdNthKiSqWdGRCwI0q9K7zOWtzfNWQwW/1GB6DdmhmnNouf?=
 =?us-ascii?Q?CuGqRa9aqrYeravtQVo33b/82GI3dy+Qeoi8k+rjWIa6VGGGqJcbeydttBSD?=
 =?us-ascii?Q?s4wOVqhsLfSXYifRYruigatV6q4I/T7+sBaFfvDKSDLiqmX39hYD93FRRKML?=
 =?us-ascii?Q?fAQtyy/pCb6T9+qZ1lrOEjv//e9cDrWNOyrjoVO5Uuitmlom1HCHhMfqLI7C?=
 =?us-ascii?Q?UKhWHKuVKveWDTT6k4s4YBF76jTxarTeKZXJlEmPeUZ5qkW0o58KYQ8UbYfU?=
 =?us-ascii?Q?2+WpvelPcJ3AEGygp8yyRAYsfbLnQPun/7dAOCweb8ZvkBtw4lNmXyEbQ1oX?=
 =?us-ascii?Q?cBfS2p/eZrM9W/VaKtHhA0x3U+0Mn4KJAWI8NNyLvn4Dsjc1poIB5PKOx2YR?=
 =?us-ascii?Q?GU/R8fXwMmWAK/9pcUge2CPMQv+cqWASSYKOmHkcS7zR8s66ljuC+5FGtnam?=
 =?us-ascii?Q?qBW53dnHl/QdcORI/pZs24GArUONFUnTJJGz5PVKF4LikcDmK3bFuvfIySJX?=
 =?us-ascii?Q?bY5nvRmHsnahUyZk3PxQ9OvsGk5GJ+RVtvPQ9I3wQXS4NW37bYNfvt34LTeJ?=
 =?us-ascii?Q?sP42H3qlzzplFpEYEKrteRifug=3D=3D?=
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 21:33:08.1894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a95725-f3c9-44b1-caad-08d89af7b099
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8XC0tGGsrgnknyCbhYXtQQcbmz4aFM1aHqma1htUsQmJw0NxoqOFY7W93p9zNIS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_16:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=1 impostorscore=0
 clxscore=1011 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 07, 2020 at 09:06:05PM +0100, Florent Revest wrote:
> This avoids
>   ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
>   bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
> When compiling a kernel with BPF and without NET.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/trace/bpf_trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 0cf0a6331482..29ec2b3b1cc4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1272,7 +1272,11 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
>  
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> +#ifdef CONFIG_NET
>  	return (unsigned long) sock_from_file(file);
> +#else
> +	return 0;
> +#endif
>  }
Should bpf_sock_from_file_proto belong to
tracing_prog_func_proto() instead of bpf_tracing_func_proto()?
bpf_skc_to_*_proto is also in tracing_prog_func_proto()
where there is an existing "#ifdef CONFIG_NET".

>  
>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)
> -- 
> 2.29.2.576.ga3fc446d84-goog
> 
