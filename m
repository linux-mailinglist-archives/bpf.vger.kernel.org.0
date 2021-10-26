Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB0543A9BF
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 03:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJZBeG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Oct 2021 21:34:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:16394 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230183AbhJZBeF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 Oct 2021 21:34:05 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19PMicaJ006790
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:31:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=qa9hzRrHcdihzU65OX36hO3YfCG10QkIIlcNWr4TsLs=;
 b=TapuM53iFv0jKBiO44Kdl+7VQKsUP3XTCOQyQgr92sywcWaaU4B31m+iquUyq2815xM7
 4gGo9AnFRo1vIrVl8QJcaz3lkI9/AcfRRrWuY3bIC5PGCQohg6qWUP4HJgjEAZknGSy9
 w10tlw86egFGSsi6S/ku7rtHPU8rdFZENpo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bx4gn9c0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 25 Oct 2021 18:31:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 25 Oct 2021 18:31:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n59w7y6APFiBeXFftTsAghnFMZnJ8F9cY3QEIKhbuJY36UhsLIrL9pLLvPbHzmd1KsW+++3o6WL94Xmo3ZMEf0r7GtpdJATfihtkStnbUvg8iPCwJLVbWPVkYu31dreLHP7+sWGgZzmtGJTpoUEBGClS4ye2fncgz5YsMjQ3Vbe5K2lcdW8UeIqeBk2Oys+ZTLeJ9JQJjWyEYLeGgO4pf6m5ZmjuNtBmzsMEUxTsxV+xsDUn2BL3qs2/whc+Pn63dTaCsny+Ar/FbWdTUV+Z/ypP+v53xqQt94LerXiH9IMLcjsu/g/T2i0l5zt8HvoVNKS7mOcOJywsfMtoKO8ZuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qa9hzRrHcdihzU65OX36hO3YfCG10QkIIlcNWr4TsLs=;
 b=M4uS4w/v4DWuJV+H7sidnoPGccQ02/yQ3YShxyk7iHVbdqsNb/msyTEI8ckH0IHPqI0yxYG1nZM0Vtkbm1G1ECfZXYs5cGhvGFVedLF9Yr50Stt42UL3HRMVCxctaJ1HuQ9qy3DrnsJ/zuWugPEpTqs073SCt59CBag44MUJob/va1qIXdFePe1XYM8llEgxesNX0MF2+zNlFFs5epipexWa6mSlyEW3J8KZ8LbGueFSzuLXLi7GATTXeZsTCmiwKDHqc68Yfs4ZVZttEZo7F8ipl2XvLFeV/Ed3sEwmIOH2Ap9NcnI9zfafcOu4TlBrSiys8BvseHRH5QTgH1KJNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4403.namprd15.prod.outlook.com (2603:10b6:806:192::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Tue, 26 Oct
 2021 01:31:40 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 01:31:40 +0000
Date:   Mon, 25 Oct 2021 18:31:36 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     <bpf@vger.kernel.org>, <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 2/5] libbpf: Add "map_extra" as a
 per-map-type extra flag
Message-ID: <20211026013136.mvtzbt7seyvguko3@kafai-mbp.dhcp.thefacebook.com>
References: <20211022220249.2040337-1-joannekoong@fb.com>
 <20211022220249.2040337-3-joannekoong@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211022220249.2040337-3-joannekoong@fb.com>
X-ClientProxiedBy: MWHPR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:300:ae::13) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:a892) by MWHPR14CA0003.namprd14.prod.outlook.com (2603:10b6:300:ae::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Tue, 26 Oct 2021 01:31:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 521a47a7-b2e4-435c-8ed0-08d998205be5
X-MS-TrafficTypeDiagnostic: SA1PR15MB4403:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4403DDA98DCD0632F5AE024CD5849@SA1PR15MB4403.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T21IT5pRPn6rRrCjAIPL5w3Sq85iPtiZhjayPiJ8ltoC4WuQRBWG89nD4BBFFzzMiLI3zZHKa1GIYzCVl+WgbTMTevVmyFHjI4mzzF00S73sBlSKr7Jg11X58GiZ5ZvO7dCS0VjUxdhiL3h3uMhYwQuPwMRYGM+UQJZ4l8GV9Z78SYMigIgD0hv+azP3WF79N7a8po9jmOFUHvMYvPWjNpJ8QWEzdXT3tw4gxx38O5TDl49zJJCAczM4d1uBrQP/O84R16+gV54pmoGO0VkFrEcJ7yz5XQesA20V1GiuCiMAaJTDpd3FjjwdYL9ALHPNnJfItoC+rJ8HRZL8+91cuvwHFWl3ab+PZTSPoG/+GzC5oQ1JD6ln6GSHYUBTwHv1+BHn7RU24E4nJRk02STGAHKIpO0JHsjmZFEWNdJMfL+/RITUCho9QBkPii1FzMrYl3fbHfH6qKKkfqwyCuelSTuRzdjZOSqDB/yNryDk+zaqrLAaHVjgqTJ6p092rkVW7PVVXHaiPpx7X9VOVsppeuMaX6kiBH6vmZlqV/lO1MS7oUQGXV04CdqodDbh2M2CkA0+cpwjz801IwSnazwN+o+PNLGNd5lSOccEt4/BudnKvhdnTOQ2EebO49rmxyRH8FCmOo5zPa95nJcb9dVbgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(6862004)(2906002)(55016002)(52116002)(8936002)(186003)(508600001)(7696005)(6506007)(8676002)(4326008)(316002)(86362001)(4744005)(5660300002)(6666004)(6636002)(66946007)(66476007)(66556008)(38100700002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CkHoFxt2QGOlVPJVymaJBvBCckX4t94UuF0LwYLAhksZJHaV1RGiSxX8kBtk?=
 =?us-ascii?Q?qvt4b/CppxtL76k/k4Oks0g/HJVETSn456VNB3BiqEt3bGXeAhanNjfrhbFG?=
 =?us-ascii?Q?IVmnMhZwFk6MOaAL9JoGmYS2mVAiBw2ybrccvepJGPYou0YJVDSaE/B5Fe6U?=
 =?us-ascii?Q?rnbj2qny0UWAfbxqpAcul7/SeIypq0nLTuNBhXwzYCHwEt9i4VgTzfSscyGK?=
 =?us-ascii?Q?bOwY2dB9JTFA+7o93gCU8jUNtEokOtMfx5P7IqVXZE07aTec41YZtm9JtWnN?=
 =?us-ascii?Q?KVsE8CDI4cxvRz/IecctZAvCLmsSddlBpNMt7s90Dyu0rrMUZhCSwRh5Pg8m?=
 =?us-ascii?Q?pBoz5V47zD1R54fc309W/75KkdMF0RZdd4kxn/BWOxMUkgmw1z5rKfv0JWeT?=
 =?us-ascii?Q?CXVLnWuohCNe/qwpWr4Csxhqf1JgKRtAI09dVOARbHKPLfdIM/ZYFSKMFBTK?=
 =?us-ascii?Q?Y/I8rJrLUz2NMIittQrEb51uQt4tnG4Bf/vE8cYcq56pNx6UdEgjA4nhHGmS?=
 =?us-ascii?Q?38Bm9Rq3ffzP0XEmqENhHfNHvOD8tYBIKZz8Mf5tS6qeAikmFr7O9IXNBxsd?=
 =?us-ascii?Q?qBXPuSoZQWecInxXjoPMcHcD/AXFyZTZezofgSAHbnxKV0LvSLEJi/zc0EtU?=
 =?us-ascii?Q?vqUO7Ep70Du3VqJib6PyTt0u6z57GNw5z1uWVhAcYygmG1AIK3lJqYO5q0Dk?=
 =?us-ascii?Q?bVtutSXkjshUCGVSFXBBarehcW7T9WCJhKBbmuHjELnMQ+8YXbAzt/JHu7mh?=
 =?us-ascii?Q?dAdvokHR4u00QreIS1kXDGTHSj87NK1DQQIbT0o2F3ZKJL4rckLyGRomKoNg?=
 =?us-ascii?Q?HV0TaE8eR0N4zXmvsIji8nII8AoVv9B+K6RJVuOMgwfGNAGWl00Q46YJW2FJ?=
 =?us-ascii?Q?SDyaesdzbFfyV4D/6XpBf10BmUhB+vcGNfdK3tol3xA25+S7ZSg6uc4JpZvX?=
 =?us-ascii?Q?SdWkyPa2YAMHzzuTu1DxZlFXWr7HX5kojiKGjYsE2YIiRbzJ2IsD/f97TzhT?=
 =?us-ascii?Q?LefZQwbNmDCd9tR4L0ct2SqTQR2uzPR3UnNYK/l3nWSSVAmaHSl6ObQIwpFi?=
 =?us-ascii?Q?B8xOEfHTeXQni2c15kZYI6AShtYXiJHC3vLa0tLzgS1umHxBm1A6uSEiOwEC?=
 =?us-ascii?Q?mdR4q+gidCoqFTRU5/9l+1jVI/9SbwP6ePiSYJT8dGzNnz4/lW3xnvkMmkmT?=
 =?us-ascii?Q?fpeO7ndRYXvLZBWnlGWIQL2i+7/dJFyicOIprWLLO549HaMq2tELj/P8bm4j?=
 =?us-ascii?Q?pDjHqr83jvyRdrjj+/cO24BTy67mEIKVpPMu1D9mvKIb8aJWbAM521nqWMHE?=
 =?us-ascii?Q?wGw7/TvpCD4XSuLrUYUhG0hvnNqTqgTOHJZ3hnt0AqUOC0AadGtC6B2XStDi?=
 =?us-ascii?Q?9Mle/VKWLe9KVKg8c6aq/zNC+h36mCoG+zS8/WxY2yZU0ULvA/8/JQGoeGPV?=
 =?us-ascii?Q?eAG0b8CRMyB0WVU0pxWtDCirKcx1+rYUXjon7/mbSdZg9XnISSQasZpkXwsK?=
 =?us-ascii?Q?EslDlOgJM1QTJ5GQ9LFPj9lvaHKHsA+r5a++w/VaZGhPYYxRzZLq38SdW/vR?=
 =?us-ascii?Q?KIbWL4B+dRdSFZLINi5sIY8bFjx3LYUfbihLsuLHAMSWKzVLDG/AB1pgY9Ec?=
 =?us-ascii?Q?0Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 521a47a7-b2e4-435c-8ed0-08d998205be5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 01:31:39.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vUytYdMy+yTIbgZezIgsNAscvhn/NHNNjv2ExXm37yoZ/i/SaLzrjjYLdU4Tjtwj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4403
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: b9qNgi85LS1aqVv6WX6O3iIGF9MfwGe5
X-Proofpoint-ORIG-GUID: b9qNgi85LS1aqVv6WX6O3iIGF9MfwGe5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-25_08,2021-10-25_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=627 phishscore=0
 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2110260006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 22, 2021 at 03:02:46PM -0700, Joanne Koong wrote:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 66827b93f548..bb64d407b8bd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5646,6 +5646,7 @@ struct bpf_map_info {
>  	__u32 btf_id;
>  	__u32 btf_key_type_id;
>  	__u32 btf_value_type_id;
> +	__u64 map_extra;
hmm... where is map_extra assigned in the kernel?
