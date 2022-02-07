Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6A4AC139
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 15:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347774AbiBGOX4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 09:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390357AbiBGN53 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 08:57:29 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0AFC03FEFD
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 05:57:14 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 217DdoA3004446;
        Mon, 7 Feb 2022 13:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=g95Hj8kY54svepeb2DnriZJF4dxQKTHQhRyozfvbMSM=;
 b=nz14p8TyP4RvCR1jHv+7xSDauTPtKVbzHLv3kSuOuiDNHIlnT202j3dc10xSB3YXBG2i
 oNU0abdaxEIuz25jtfeDny0D5iy7H+491yBiqlRfP3Qlq4LN1tumwgHmNYtDYUVdAGPW
 9R0y+DvVaO4i0FZ6vDdpGYZxeuREUiTL4kgckklG/UxODIHV6SnpB7r/9mS6Q7oksOmj
 of+Em+ZxwnB7dUzq3wWLDgySry0pRkt63SAOK3CymmY/XdP0BlW1sLASlLNT728zfFbk
 iVLUWINS3JrOCaymgG2G5UjkE00uy+ywOnkjyec4e+By1ZCXCdwTZHTqV8YmEbQ8hydc qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1g13pbt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 13:56:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 217Dthx1025737;
        Mon, 7 Feb 2022 13:56:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by userp3030.oracle.com with ESMTP id 3e1ebx4c3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 13:56:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3TnQb/eC+pc/19bE5B043qL9xmL/EgdtQ4i+54GJgn9fKwbL8rNC9wMjTfqQk1IhzEoRcMKfujl361KSeEAsGTIpi4ValVTxOe1L5eF/iK5kAgi9AcMnQ94eKLt7mUhUrfJgA201jJ+huwF8O9oQBw3pM3suY49UDeE77K/T1eam1PRjoXBHVqGJaQIDiaS8GM9aJQk9dEeJM/m3Jr8evwbShq/aqu3uLGfcjJaq9UyE5krkMoV4+/jSiLEgUL738BKDJXQr/YFC7u07tP9t7oF0LqY21io3ESL9J/B6BZRLvr4aUI6bgaQpN/jlYqBxZbewSCtCRCuDhCjku9y8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g95Hj8kY54svepeb2DnriZJF4dxQKTHQhRyozfvbMSM=;
 b=SSMlq4R1BCMlBJ71/hOYE2ucBl0SOAP+JrVPKoMs/Snhb3VFpELtqNBn4Ayy0E+rD31ak7Ddgb7ZG5+OG9F7Jsscr1lLUG1rZvg93bKVyrQ7RBKJJiNmp2pjiBpsw3ULzH5M2eoxYtoK2NMKn4vdrX1YTWsdxAfB5e0Scbo1RK0zoV4CGvYO+a1KN7K1tqpJeQ34RHIV4TRk5fb6IWeJuuVk86p4PUP86HB/L8Ys+G/ZP7jlhHLUoS16AtZ+eycOIR8awcEpTnZnofpjV36EU/99dMfQ/sHHNNilTx2wyl9Zpoj/d+3CYwP8WMb/ffX24UDsFvX9Cs6EwBbbdVcB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g95Hj8kY54svepeb2DnriZJF4dxQKTHQhRyozfvbMSM=;
 b=IWWZow05FfOC73DwrtfnBwq0a+/r4RFmjEFwKROun9a/sVf/sxxdLg/zICCbVuCRh/XQHzu3n6pZpCZRvJbEZUH+0AvjWb3TNzzfN0/QCsTKHbw4KhUriuJT2WxyKymdxw/2GXaew2uVIjlac+lRTTxPW2XNSmVQQxaxph3jT0Y=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN6PR10MB1268.namprd10.prod.outlook.com (2603:10b6:405:10::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 13:56:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9484:fe8e:904f:1835]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::9484:fe8e:904f:1835%4]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 13:56:48 +0000
Date:   Mon, 7 Feb 2022 13:56:45 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 2/3] libbpf: support custom SEC() handlers
In-Reply-To: <20220205012705.1077708-4-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2202071222170.9037@MyRouter>
References: <20220205012705.1077708-1-andrii@kernel.org> <20220205012705.1077708-4-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P123CA0328.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::9) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca84c548-76d2-4a3d-4ba9-08d9ea41af55
X-MS-TrafficTypeDiagnostic: BN6PR10MB1268:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1268A05B22656DA1DFEBB873EF2C9@BN6PR10MB1268.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faOinVwOTD9xb+MsgWtorCmXoad9/8Kc9jMcvMXb6BkDR5UxC2c6bpSfU4qtGDlQ0tetXRhfXoJCZyYFDJl1hjeItofKy7eiI8f4hM+lfkCfW+NYyIH7DkF7WCi1flFdPmfrJ0IkOZwoAcLXlMgtgc5FW9NG3B1jUE3iI7yoEw93Bghcx4XgII5okslMahxZI+n/5HQT0NeVAm9ONRULiiVcVQApC9+pw/3FyKePMFry2/j7WOaaLgEzSQUA24gMmofKJtRQ0A60iKPKKOw72PWfS12rtGmbsq1heXZmPU/sek0ig2MpUMsn01VjLasq2rSwKcYWYoV9kOtzxzHccMfs5845UaBFGGRGkR8qU8k7/UGdO89Y4cXTrdsR0ije02u5WotnHi+ubj6/XU+Ma0lPMiFgZEiYoY/qy3l80ID6quPGnFXnurNtaYekSA9085DonTtv7i6ApOD7pOdjyAuJpfIypsIrO6+xSuyh69bWGGSOAW7jR4/2jixRviLiNG51O47ibFI6+pyp05dP3ucVtvfTtrVLjNpjSo1CRT/qyEa4aZQKOsJIh8RSZwMNK3wb5yLos00ULB7VE3GDJd/uj2Dt4yTwFc/oCOUEePdZqDAaBRxo3d7vNvBMcxnGym1G6pOf8SoDshv25019sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(9686003)(6512007)(6506007)(52116002)(186003)(6916009)(30864003)(316002)(66556008)(8676002)(8936002)(5660300002)(66476007)(107886003)(4326008)(508600001)(44832011)(66946007)(6486002)(38100700002)(2906002)(33716001)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?52UGUyguLGlGDWFZ954qZyL3vwn2RcFy0MTWosbdmLqjNtenR82epwDJIOer?=
 =?us-ascii?Q?qQ3+dRSmW917y5do5UPIvunJECW3A8DNo1catInf3zYG0x2WJvguxaHgAL4D?=
 =?us-ascii?Q?+ZJ/ck5JV+50Ve8FecA9YSQtu8lzpZHYzQiTIjpr0N+kW9Sm/qtZPdI6frhF?=
 =?us-ascii?Q?nVR40dpHlpeoog8KtOsri4PPhFzPZf7zh954uus4L6ogwwsglsarYsZff4Xv?=
 =?us-ascii?Q?sjyxIVKh0vrqa4vmh/yVYpdx4tyi1sw0ntCyxcgp7Hnm4xQ1d1+4ID0GSymY?=
 =?us-ascii?Q?7jhPj4LcJ1I6Oisg6kz2gpZzzxa1ZMQu4MjTiBJ8BMtxA5GKewzerdu+Cuqp?=
 =?us-ascii?Q?HVKUeWbjhOWUawLd2RqkwGe7sVH+NpFJiiFCPydxPoFqFce3n/LWnd1QU6Ob?=
 =?us-ascii?Q?gRcnnDiU6VDlTUTZXdB+E800mdq7uXvG/Fp8wl3RH3B/4BK2vZX4u72X96k8?=
 =?us-ascii?Q?/P5mVo74LJLwmtIMGZgkknVF33Av1IfsW/DAHLvEsHoNUr1XoTq1yIJYz79c?=
 =?us-ascii?Q?07jxRA6fjrZ4FAzRSmihPn/RG/y5CFUKujOgveqj7kL/cbjDy53QZCuTuxAv?=
 =?us-ascii?Q?tLy6DxsiZN+wmadl6SptCvSTvdnMaNauNg5KrS4aSKRJ6gkAaF/15wQbOyHW?=
 =?us-ascii?Q?OqLz8RAayWObgwr4kWdbq+MCyLcDSF7QmW384rlhm+wl3KYAlYtHmXQW/xwm?=
 =?us-ascii?Q?9wijBg036qbiFwxK7WGGmLyR/9wgrK/Gc68DwKwsHnv4WwrUBKxjEmlHx141?=
 =?us-ascii?Q?nvH17TR+3Z2JO/hltfiDhMDc1e3L9MZVHZY3cA9ASHpQMLsurH5CViOCUmuQ?=
 =?us-ascii?Q?VzeebmwGZzMZ3FSM41qu0QluknMZX/U+h/zHTvkOWUsvpHLS0Lykxs1cTRuf?=
 =?us-ascii?Q?Lxo0edMZmoq2xyrS7OuTVczu70+hNW17qRf9sYGZIoL0NhC6w/CApFpKrqbk?=
 =?us-ascii?Q?X1zBWYHMBP755Yr2+M1eCzo0twKAaYT74KdDC5G6JERX37MhT1ss7hvesFjs?=
 =?us-ascii?Q?eQ8pcHd2y/lrV7SLHmzZJBy+WAA80Pgul75ZhB1qqCujuk1beXQ3VvGp5LiV?=
 =?us-ascii?Q?RNPzx9p9TArupTwAECL6PXoO8Ene7Id282MubAYcZtiWnFB5AC1tzxk9vQLU?=
 =?us-ascii?Q?vuaEPbWCWhCvNE28NEVZUEr6eyNtqa0AQl7LNGRoBuPQ2A/A+1uEbgvUYJwV?=
 =?us-ascii?Q?sQyniOEVvTFabdsiwJMLqS+tHec6H95h+rtWbT6vu0gBsDGBAk88glwdf0QH?=
 =?us-ascii?Q?zKy0sVMSlDLLCjamyfazpTP+cf3QpkK5dBCyg/9q1dQO2tht6qpXlVSxzLBU?=
 =?us-ascii?Q?u3mPXg0tMi9qbOXZd1odwMscBFxuEQtMYnvedPfXUiqzsmH1UfhHnJIEYext?=
 =?us-ascii?Q?BostLpOvfT8TeOVFZJJQqqUBt6dR5EhGBiKMJrjEqkjRukBGYa8jTstqCwAd?=
 =?us-ascii?Q?pNoh4dXYr87A1jQrIpilnrclfDnJSoE4zNbhGMP1ujR8+D3PBPR1O3aeQP+R?=
 =?us-ascii?Q?nbo9SEkYVHaMXlFjJzscRQnzwHbikTozJ+LPA+gldQixnh7PQBmV8yl3zSJ3?=
 =?us-ascii?Q?Q596srC7zxyMzpQYtGJBpU+oZMS1wmEUqydxit0uvK5rjHl2yv4TDjYVDXgf?=
 =?us-ascii?Q?+PNmaERMPCZ3/81ec8+1Dn/LilV6uQwqL6VM4SH4dSD2s57JC5Tw+r5+SNG/?=
 =?us-ascii?Q?OkYxgQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca84c548-76d2-4a3d-4ba9-08d9ea41af55
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 13:56:48.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mS4ik/kl2O3cTm24sBElHeij/W/FgENtZC7CiXnJMPvfp+B8HlCO9ekA6tyKQTdMW8KLPiq/m2+y1i7uL/5kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1268
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070090
X-Proofpoint-GUID: rO3Djm2fPYUJ-VsJr_XaDbxtLR-DjFQU
X-Proofpoint-ORIG-GUID: rO3Djm2fPYUJ-VsJr_XaDbxtLR-DjFQU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 5 Feb 2022, Andrii Nakryiko wrote:

> Allow registering and unregistering custom handlers for BPF program.
> This allows user applications and libraries to plug into libbpf's
> declarative SEC() definition handling logic. This allows to offload
> complex and intricate custom logic into external libraries, but still
> provide a great user experience.
> 
> One such example is USDT handling library, which has a lot of code and
> complexity which doesn't make sense to put into libbpf directly, but it
> would be really great for users to be able to specify BPF programs with
> something like SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_name>")
> and have correct BPF program type set (BPF_PROGRAM_TYPE_KPROBE, as it is
> uprobe) and even support BPF skeleton's auto-attach logic.
> 
> In some cases, it might be even good idea to override libbpf's default
> handling, like for SEC("perf_event") programs. With custom library, it's
> possible to extend logic to support specifying perf event specification
> right there in SEC() definition without burdening libbpf with lots of
> custom logic or extra library dependecies (e.g., libpfm4). With current
> patch it's possible to override libbpf's SEC("perf_event") handling and
> specify a completely custom ones.
> 
> Further, it's possible to specify a generic fallback handling for any
> SEC() that doesn't match any other custom or standard libbpf handlers.
> This allows to accommodate whatever legacy use cases there might be, if
> necessary.
> 
> See doc comments for libbpf_register_prog_handler() and
> libbpf_unregister_prog_handler() for detailed semantics.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c   | 201 +++++++++++++++++++++++++++++----------
>  tools/lib/bpf/libbpf.h   |  81 ++++++++++++++++
>  tools/lib/bpf/libbpf.map |   2 +
>  3 files changed, 232 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 2902534def2c..d78a6365ba74 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -209,13 +209,6 @@ struct reloc_desc {
>  	};
>  };
>  
> -typedef int (*libbpf_prog_init_fn_t)(struct bpf_program *prog, long cookie);
> -typedef int (*libbpf_prog_preload_fn_t)(struct bpf_program *prog,
> -					struct bpf_prog_load_opts *opts, long cookie);
> -/* If auto-attach is not supported, callback should return 0 and set link to NULL */
> -typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
> -				       struct bpf_link **link);
> -
>  /* stored as sec_def->cookie for all libbpf-supported SEC()s */
>  enum sec_def_flags {
>  	SEC_NONE = 0,
> @@ -243,10 +236,11 @@ enum sec_def_flags {
>  };
>  
>  struct bpf_sec_def {
> -	const char *sec;
> +	char *sec;
>  	enum bpf_prog_type prog_type;
>  	enum bpf_attach_type expected_attach_type;
>  	long cookie;
> +	int handler_id;
>  
>  	libbpf_prog_init_fn_t init_fn;
>  	libbpf_prog_preload_fn_t preload_fn;
> @@ -8582,7 +8576,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
>  }
>  
>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
> -	.sec = sec_pfx,							    \
> +	.sec = (char *)sec_pfx,						    \
>  	.prog_type = BPF_PROG_TYPE_##ptype,				    \
>  	.expected_attach_type = atype,					    \
>  	.cookie = (long)(flags),					    \
> @@ -8675,61 +8669,164 @@ static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("sk_lookup",		SK_LOOKUP, BPF_SK_LOOKUP, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>  };
>  
> -#define MAX_TYPE_NAME_SIZE 32
> +static size_t custom_sec_def_cnt;
> +static struct bpf_sec_def *custom_sec_defs;
> +static struct bpf_sec_def custom_fallback_def;
> +static bool has_custom_fallback_def;
>  
> -static const struct bpf_sec_def *find_sec_def(const char *sec_name)
> +static int last_custom_sec_def_handler_id;
> +
> +int libbpf_register_prog_handler(const char *sec,
> +				 enum bpf_prog_type prog_type,
> +				 enum bpf_attach_type exp_attach_type,
> +				 libbpf_prog_init_fn_t prog_init_fn,
> +				 libbpf_prog_preload_fn_t prog_preload_fn,
> +				 libbpf_prog_attach_fn_t prog_attach_fn,
> +				 long cookie,
> +				 const void *opts)
>  {
> -	const struct bpf_sec_def *sec_def;
> -	enum sec_def_flags sec_flags;
> -	int i, n = ARRAY_SIZE(section_defs), len;
> -	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME;
> +	struct bpf_sec_def *sec_def;
>  
> -	for (i = 0; i < n; i++) {
> -		sec_def = &section_defs[i];
> -		sec_flags = sec_def->cookie;
> -		len = strlen(sec_def->sec);
> +	if (opts)
> +		return libbpf_err(-EINVAL);
> +	if (last_custom_sec_def_handler_id == INT_MAX) /* prevent overflow */
> +		return libbpf_err(-E2BIG);
>  
> -		/* "type/" always has to have proper SEC("type/extras") form */
> -		if (sec_def->sec[len - 1] == '/') {
> -			if (str_has_pfx(sec_name, sec_def->sec))
> -				return sec_def;
> -			continue;
> -		}
> +	if (sec) {
> +		sec_def = libbpf_reallocarray(custom_sec_defs, custom_sec_def_cnt + 1,
> +					      sizeof(*sec_def));
> +		if (!sec_def)
> +			return libbpf_err(-ENOMEM);
>  
> -		/* "type+" means it can be either exact SEC("type") or
> -		 * well-formed SEC("type/extras") with proper '/' separator
> -		 */
> -		if (sec_def->sec[len - 1] == '+') {
> -			len--;
> -			/* not even a prefix */
> -			if (strncmp(sec_name, sec_def->sec, len) != 0)
> -				continue;
> -			/* exact match or has '/' separator */
> -			if (sec_name[len] == '\0' || sec_name[len] == '/')
> -				return sec_def;
> -			continue;
> -		}
> +		custom_sec_defs = sec_def;
> +		sec_def = &custom_sec_defs[custom_sec_def_cnt];
> +	} else {
> +		if (has_custom_fallback_def)
> +			return libbpf_err(-EBUSY);
>  
> -		/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
> -		 * matches, unless strict section name mode
> -		 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
> -		 * match has to be exact.
> -		 */
> -		if ((sec_flags & SEC_SLOPPY_PFX) && !strict)  {
> -			if (str_has_pfx(sec_name, sec_def->sec))
> -				return sec_def;
> -			continue;
> -		}
> +		sec_def = &custom_fallback_def;
> +	}
>  
> -		/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
> -		 * SEC("syscall")) are exact matches in both modes.
> -		 */
> -		if (strcmp(sec_name, sec_def->sec) == 0)
> +	sec_def->sec = sec ? strdup(sec) : NULL;
> +	if (sec && !sec_def->sec)
> +		return libbpf_err(-ENOMEM);
> +
> +	sec_def->prog_type = prog_type;
> +	sec_def->expected_attach_type = exp_attach_type;
> +	sec_def->cookie = cookie;
> +
> +	sec_def->init_fn = prog_init_fn;
> +	sec_def->preload_fn = prog_preload_fn;
> +	sec_def->attach_fn = prog_attach_fn;
> +
> +	sec_def->handler_id = ++last_custom_sec_def_handler_id;
> +
> +	if (sec)
> +		custom_sec_def_cnt++;
> +	else
> +		has_custom_fallback_def = true;
> +

should we try and deal with the (unlikely) case that multiple
fallback definitions are supplied, since only the first will
be used? i.e 

if (!sec && has_custom_fallback_def)
	return -EEXIST;

?

> +	return sec_def->handler_id;
> +}
> +
> +int libbpf_unregister_prog_handler(int handler_id)
> +{
> +	int i;
> +
> +	if (handler_id <= 0)
> +		return libbpf_err(-EINVAL);
> +
> +	if (has_custom_fallback_def && custom_fallback_def.handler_id == handler_id) {
> +		memset(&custom_fallback_def, 0, sizeof(custom_fallback_def));
> +		has_custom_fallback_def = false;
> +		return 0;
> +	}
> +
> +	for (i = 0; i < custom_sec_def_cnt; i++) {
> +		if (custom_sec_defs[i].handler_id == handler_id)
> +			break;
> +	}
> +
> +	if (i == custom_sec_def_cnt)
> +		return libbpf_err(-ENOENT);
> +
> +	free(custom_sec_defs[i].sec);
> +	for (i = i + 1; i < custom_sec_def_cnt; i++)
> +		custom_sec_defs[i - 1] = custom_sec_defs[i];
> +	custom_sec_def_cnt--;

We're leaking a custom table entry each time we register/deregister.
We could libbpf_reallocarray() to trim here I think.

> +
> +	return 0;
> +}
> +
> +static bool sec_def_matches(const struct bpf_sec_def *sec_def, const char *sec_name,
> +			    bool allow_sloppy)
> +{
> +	size_t len = strlen(sec_def->sec);
> +
> +	/* "type/" always has to have proper SEC("type/extras") form */
> +	if (sec_def->sec[len - 1] == '/') {
> +		if (str_has_pfx(sec_name, sec_def->sec))
> +			return true;
> +		return false;
> +	}
> +
> +	/* "type+" means it can be either exact SEC("type") or
> +	 * well-formed SEC("type/extras") with proper '/' separator
> +	 */
> +	if (sec_def->sec[len - 1] == '+') {
> +		len--;
> +		/* not even a prefix */
> +		if (strncmp(sec_name, sec_def->sec, len) != 0)
> +			return false;
> +		/* exact match or has '/' separator */
> +		if (sec_name[len] == '\0' || sec_name[len] == '/')
> +			return true;
> +		return false;
> +	}
> +
> +	/* SEC_SLOPPY_PFX definitions are allowed to be just prefix
> +	 * matches, unless strict section name mode
> +	 * (LIBBPF_STRICT_SEC_NAME) is enabled, in which case the
> +	 * match has to be exact.
> +	 */
> +	if (allow_sloppy && str_has_pfx(sec_name, sec_def->sec))
> +		return true;
> +
> +	/* Definitions not marked SEC_SLOPPY_PFX (e.g.,
> +	 * SEC("syscall")) are exact matches in both modes.
> +	 */
> +	return strcmp(sec_name, sec_def->sec) == 0;
> +}
> +
> +static const struct bpf_sec_def *find_sec_def(const char *sec_name)
> +{
> +	const struct bpf_sec_def *sec_def;
> +	int i, n;
> +	bool strict = libbpf_mode & LIBBPF_STRICT_SEC_NAME, allow_sloppy;
> +
> +	n = custom_sec_def_cnt;
> +	for (i = 0; i < n; i++) {
> +		sec_def = &custom_sec_defs[i];
> +		if (sec_def_matches(sec_def, sec_name, false))
>  			return sec_def;
>  	}
> +
> +	n = ARRAY_SIZE(section_defs);
> +	for (i = 0; i < n; i++) {
> +		sec_def = &section_defs[i];
> +		allow_sloppy = (sec_def->cookie & SEC_SLOPPY_PFX) && !strict;
> +		if (sec_def_matches(sec_def, sec_name, allow_sloppy))
> +			return sec_def;
> +	}
> +
> +	if (has_custom_fallback_def)
> +		return &custom_fallback_def;
> +
>  	return NULL;
>  }
>  
> +#define MAX_TYPE_NAME_SIZE 32
> +
>  static char *libbpf_get_type_names(bool attach_type)
>  {
>  	int i, len = ARRAY_SIZE(section_defs) * MAX_TYPE_NAME_SIZE;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index c8d8daad212e..6e665c26dcc7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1328,6 +1328,87 @@ LIBBPF_API int bpf_linker__add_file(struct bpf_linker *linker,
>  LIBBPF_API int bpf_linker__finalize(struct bpf_linker *linker);
>  LIBBPF_API void bpf_linker__free(struct bpf_linker *linker);
>  
> +/*
> + * Custom handling of BPF program's SEC() definitions
> + */
> +
> +struct bpf_prog_load_opts; /* defined in bpf.h */
> +
> +/* Called during bpf_object__open() for each recognized BPF program. Callback
> + * can use various bpf_program__set_*() setters to adjust whatever properties
> + * are necessary.
> + */
> +typedef int (*libbpf_prog_init_fn_t)(struct bpf_program *prog, long cookie);
> +
> +/* Called right before libbpf performs bpf_prog_load() to load BPF program
> + * into the kernel. Callback can adjust opts as necessary.
> + */
> +typedef int (*libbpf_prog_preload_fn_t)(struct bpf_program *prog,
> +					struct bpf_prog_load_opts *opts, long cookie);
> +
> +/* Called during skeleton attach or through bpf_program__attach(). If
> + * auto-attach is not supported, callback should return 0 and set link to
> + * NULL (it's not considered an error during skeleton attach, but it will be
> + * an error for bpf_program__attach() calls). On error, error should be
> + * returned directly and link set to NULL. On success, return 0 and set link
> + * to a valid struct bpf_link.
> + */
> +typedef int (*libbpf_prog_attach_fn_t)(const struct bpf_program *prog, long cookie,
> +				       struct bpf_link **link);
> +
> +/**
> + * @brief **libbpf_register_prog_handler()** registers a custom BPF program
> + * SEC() handler.
> + * @param sec section prefix for which custom handler is registered
> + * @param prog_type BPF program type associated with specified section
> + * @param exp_attach_type Expected BPF attach type associated with specified section
> + * @param prog_init_fn BPF program initialization callback (see libbpf_prog_init_fn_t)
> + * @param prog_preload_fn BPF program loading callback (see libbpf_prog_preload_fn_t)
> + * @param prog_attach_fn BPF program attach callback (see libbpf_prog_attach_fn_t)
> + * @param cookie User-provided cookie passed to each callback
> + * @param opts reserved for future extensibility, should be NULL
> + * @return Non-negative handler ID is returned on success. This handler ID has
> + * to be passed to *libbpf_unregister_prog_handler()* to unregister such
> + * custom handler. Negative error code is returned on error.
> + *
> + * *sec* defines which SEC() definitions are handled by this custom handler
> + * registration. *sec* can have few different forms:
> + *   - if *sec* is just a plain string (e.g., "abc"), it will match only
> + *   SEC("abc"). If BPF program specifies SEC("abc/whatever") it will result
> + *   in an error;
> + *   - if *sec* is of the form "abc/", proper SEC() form is
> + *   SEC("abc/something"), where acceptable "something" should be checked by
> + *   *prog_init_fn* callback, if there are additional restrictions;
> + *   - if *sec* is of the form "abc+", it will successfully match both
> + *   SEC("abc") and SEC("abc/whatever") forms;
> + *   - if *sec* is NULL, custom handler is registered for any BPF program that
> + *   doesn't match any of the registered (custom or libbpf's own) SEC()
> + *   handlers. There could be only one such generic custom handler registered
> + *   at any given time.
> + *
> + * All custom handlers (except the one with *sec* == NULL) are processed
> + * before libbpf's own SEC() handlers. It is allowed to "override" libbpf's
> + * SEC() handlers by registering custom ones for the same section prefix
> + * (i.e., it's possible to have custom SEC("perf_event/LLC-load-misses")
> + * handler).
> + */

Nicely documented!

> +LIBBPF_API int libbpf_register_prog_handler(const char *sec,
> +					    enum bpf_prog_type prog_type,
> +					    enum bpf_attach_type exp_attach_type,
> +					    libbpf_prog_init_fn_t prog_init_fn,
> +					    libbpf_prog_preload_fn_t prog_preload_fn,
> +					    libbpf_prog_attach_fn_t prog_attach_fn,

Naming nit: a prog_handler sounds less specific; would
"sec_handler" or "prog_sec_handler" be more descriptive perhaps?

Also, would it make sense to pass the functions in as options instead?
They can all be NULL potentially I think, and it's possible we'd
want additional future handlers too..

> +					    long cookie,
> +					    const void *opts);
> +/**
> + * @brief *libbpf_unregister_prog_handler()* unregisters previously registered
> + * custom BPF program SEC() handler.
> + * @param handler_id handler ID returned by *libbpf_register_prog_handler()*
> + * after successful registration
> + * @return 0 on success, negative error code if handler isn't found
> + */
> +LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index aef6253a90c8..4e75f06c1a00 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -438,4 +438,6 @@ LIBBPF_0.7.0 {
>  		libbpf_probe_bpf_map_type;
>  		libbpf_probe_bpf_prog_type;
>  		libbpf_set_memlock_rlim_max;
> +		libbpf_register_prog_handler;
> +		libbpf_unregister_prog_handler;
>  };
> -- 
> 2.30.2
> 
> 
