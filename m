Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C1043F64C
	for <lists+bpf@lfdr.de>; Fri, 29 Oct 2021 06:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhJ2Ew0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Oct 2021 00:52:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11220 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231759AbhJ2Ew0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 Oct 2021 00:52:26 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19SJv9PR006704;
        Thu, 28 Oct 2021 21:49:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=amMEVs+OAWHjNTO0Bn1FltE1J+9rtc31netDahVRt9s=;
 b=lQ81C8P+HgBJr6FLTNq1fBZbdDcSwyXCWgB/fnm2BrBKup9WcJnK7TZ0Kau/5r10QVmJ
 ryt7P7IDEqYOk5N3xmgkQBo4FczzIkfUnCLkdYl6k6JfzL5H7pCyQDBzyreD4wUgjAvE
 PxcCAWAyqsPizMmpXUQwH9hyl0Rzm3GZOOs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c02fdjrjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Oct 2021 21:49:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 28 Oct 2021 21:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKPZlcV8VlWo+OZgUyI0y1zAqYKdEVzXogqY5YjqrQKV9SobeC1Y3by2janTZt2tnoHz1+t31k2fF4P3iPOLIdEmKawe5qJw2R8fsaOcNc6f5gHKe1tiseQB+gJPpNhpUNHSFdbyI6/gywf1TCUNmdbKst0VLMlDZXSeKnyhYEZQyLo/Sdd9L816Zq+JyHTt7gCY+P6vueDRZk7ypqjzqGUOSzEhCSVVukdOE4/mxrQyPVGkkY++07QKum4mx+zAfPNACM9ON1OYwebxnlmDT/P3usevzPvXAsi7zbM4DInSf1sY05/jqtcgQaV6e0VMyZCRr3mLKqvuvkvMv/dpdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amMEVs+OAWHjNTO0Bn1FltE1J+9rtc31netDahVRt9s=;
 b=OyOuZ9lxMOH1UgGDYByyIkXY/3iKe0EqYszLBwPYr2p1SAwlaArHuyzJKF7YYwLTl1vouvLFdLCNdqk9YAJFjqJdRZoskHAHdd0OpMVJdRGU4ZqEVmtKqODwy9fofPbgQJYyxaoAYCTJD92mr01AiwZgSrH/9++sqybI5W3WVOOvGacqarjDOHGFs4E0+JLU0fHr/XZ6DUSbAnIecnTjdkt7GWqDnsLfySenZ56EPE377F+3XxukeCqL4L1QZKttsYi8S0+iUNccULWBZttBRgKCLKgtHurOoKpdzRfBdWo74vIfOb+F5pJGcCBJD9iEFsJWc824/XFBMYLimOHT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB4013.namprd15.prod.outlook.com (2603:10b6:806:8b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 29 Oct
 2021 04:49:19 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%7]) with mapi id 15.20.4628.020; Fri, 29 Oct 2021
 04:49:19 +0000
Date:   Thu, 28 Oct 2021 21:49:16 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannekoong@fb.com>
CC:     <bpf@vger.kernel.org>, <andrii@kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <Kernel-team@fb.com>
Subject: Re: [PATCH v6 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20211029044916.d2e33y3jhwr2dvbi@kafai-mbp.dhcp.thefacebook.com>
References: <20211027234504.30744-1-joannekoong@fb.com>
 <20211027234504.30744-2-joannekoong@fb.com>
 <20211028211424.m5y4kafaulvgke54@kafai-mbp.dhcp.thefacebook.com>
 <8ff8008f-baee-123c-d61f-0fd0140ff50d@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8ff8008f-baee-123c-d61f-0fd0140ff50d@fb.com>
X-ClientProxiedBy: MWHPR15CA0030.namprd15.prod.outlook.com
 (2603:10b6:300:ad::16) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:ae8b) by MWHPR15CA0030.namprd15.prod.outlook.com (2603:10b6:300:ad::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Fri, 29 Oct 2021 04:49:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d4e192c-82b9-4839-f7e4-08d99a9777f8
X-MS-TrafficTypeDiagnostic: SA0PR15MB4013:
X-Microsoft-Antispam-PRVS: <SA0PR15MB4013E1F158747224BA61A47FD5879@SA0PR15MB4013.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzmXdrJ00fKol7X3J0oNPhGV1MokWG2+tFMOpcQTroUG3hYOXwfv+tia9YXyr8c88EQSa9QIstc0pmbRDmAMDnshpDw/RF0bO7PD9/lAYL/n7LkppCFmbeD3J++hkbD4JHuGtMvyeaWJqoVS1uoxSHsDN3gP39Yl8SOAlGPCDyuo4VJ4LUXs+LaC3ZhreI5PFylVmST4bKngVR26aCTX5pA0uig3Kve9UUPTsT/XE0lV5ZVzC1FkxEddDM/lT31P/l5vX/q354vVjcadsrQjijs0xseGiIu4bxfqH2DSGs+wcB2jbiV+nXujfXHhZIf6jFmc+26CvVYGFYAi4OH3JWwq5UFLtpzK60KxDl22DsZGTSVKru52UIlK/XqVA+2Iz/Hsrej5HKLwCvryNUt9pIEb84F52lbqtcZcZkt/7OEDgSXl6u918Qgy99YT0a2LCeAtc7U4zkUBQRsA6bvUerc1A9h0IPvvKxPMe2TtIMNCI79vcAgS9N6odc3KZd8LvN0NHc1LlKFZFL/OOdJsQEALzexV6ZO/huM64n30G9eZ5CazgsGy1GLGxYVk0xYjj0/BL/RPLuPIE8KMWtWqVQ5dmqauIZNFUirei1fbkb+5Zc1/j9n05BU/yjR9eYKfibabGoYiO/xQAatewAcspQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(5660300002)(8936002)(6636002)(186003)(316002)(8676002)(7696005)(66556008)(66946007)(38100700002)(4326008)(66476007)(52116002)(55016002)(53546011)(86362001)(6862004)(508600001)(1076003)(6506007)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lXpQaQKbPIDwS+aWnKjCOT5cNCOwTYyqd86LcLxySYulWj0oSeZ2UY31bLUR?=
 =?us-ascii?Q?e/LEj/d+OomG4K/ODh9AiaW9pSBF/C2lZynSDNm020Fw8BFdbbAgxU3H4aCE?=
 =?us-ascii?Q?sd6ZpntRLZw3i18W49APKgon1zj47Ix78U9IsGExqLET97aQ/gkXwadGubYH?=
 =?us-ascii?Q?5IAC00UjngicUdpiVCvKgWAIiR65Ir0drz5bppJ6oP5YnQ1n2HEXhrkpK1G4?=
 =?us-ascii?Q?7/+Mxet/QnMNbGoaCJB6JbxInk/RktBN/hPQ43KzZc6xgS3f9yEpV+eEj0X/?=
 =?us-ascii?Q?mnwHMQ/TGE203IMAOjshUD4vGRWH2DI/rYPp1tzQTxkKnmfPvVrDgmfAUuc1?=
 =?us-ascii?Q?RfXRGsx8Q7PQP35xdlD/iVHKWKfWdhbCxDWUEhug7G8aXBsdzG643afZvCoc?=
 =?us-ascii?Q?36IuzLRpvIWVO/S3NLuq8Oom4akwHFqIToQx65CcwBdKVZVoZtddOUXP/+Em?=
 =?us-ascii?Q?/5a/ewlsn+YIOp6EvmzAjWRjBbiedWWIzXufGjTkY4LPkGMQBYoUD1mENP4M?=
 =?us-ascii?Q?U/KwGWzzvWjkt2FujpbSKQlllnkJ2QzIvv1XbVnc3pUql4btuU+val9WOkXw?=
 =?us-ascii?Q?2W0+UXuIaNfI0KYuzew/xG3XoayzrL/wEjOPWwIP8E6XNBKwbcl2CcYffA82?=
 =?us-ascii?Q?muEYAdNDKt9HlDXmR/uz9V5O1apklbO9HV2o+LZmxecuVV3OgQUOuMQIv73x?=
 =?us-ascii?Q?UyLPkhbKElbfgz3mKM4xrMvoXDasrQsdpgfAwOKDzQs9qaHZ9G9or0gncZYY?=
 =?us-ascii?Q?234W23BmqYlngLhouQXjrkjgpowVEY09MbqkDc19yFPxthQjKwPDusxdFV7o?=
 =?us-ascii?Q?1WFQTwKLi943ktuBdEOBmGnLiqD/C+oIKheCUk4JiStIhU2gpSnUW+xpZlAE?=
 =?us-ascii?Q?BrnpdXRQrj/EcuajTSZyAJPb8HJnREeo8Ck4SBO/UZHmgIiQsYHg81L/ZQiH?=
 =?us-ascii?Q?pGb6Wkjhq5iOk1MZm8qxEWDJqYBwYG65v1Ofdd8lA9uCigYS7VL50wkBoqVK?=
 =?us-ascii?Q?3ymigAbM/sEvhd47Mgxn7A7s8+flOITxEFIxlEmmiCNnxEKUSNgXozdVAqU+?=
 =?us-ascii?Q?uw3KI7FlDmyIPMu0dGzRo5rVYDjVpHJ385wcWAbhgMgmypo4uiZEl6X+zRy3?=
 =?us-ascii?Q?+e8kt7t/tC51YjJ6XU8sdRCG6RqsNBVxqyB2x5etQCyf+hhz0Jt7tCmUxJzc?=
 =?us-ascii?Q?A9GjZI9PG3BSg7q8/o0gspwmnY4bBfJky8nFLf7bawVw88HqmLM1gRlY0v9m?=
 =?us-ascii?Q?l6yrd0cMtv5FrOgN8VxP0BOOZ/sWrWabC+EU3zbrOjceHIG4+jSRhhSFezzR?=
 =?us-ascii?Q?HgpMx2mRwTU5C0ziDcGvDV80hfnR0Qu22+0POqGsfYlgjotwScWW5r66H9va?=
 =?us-ascii?Q?pYLIb9JbiswrvJ3QzBb8khlu2txN7FhqvYKDiP2kLhJWnGIPAbibRxn5ilC5?=
 =?us-ascii?Q?icb2GUyAHixt9fuYQucwzUBZdoca54WJZ3oOuS8WlkHuQhaCvHJAOFoJ7f79?=
 =?us-ascii?Q?hHRy6l1hk1qZwAy08yF9TOfN9pZTJplAq+0vopMq4XyuAxfIzXNSJeLofOKc?=
 =?us-ascii?Q?ongHNmaAKW6twIsWFujv/bVRmXhRU+2ISHnwj9rF?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4e192c-82b9-4839-f7e4-08d99a9777f8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 04:49:19.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvi2qhDLHDTCo7+dOwyW72aSReMgFIPgHkyjL2EaABEKcFO7DL5xehkCbjdVBGm0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4013
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: heK1uKUja0t9WN_vA812Jcv1KFVLZ5LX
X-Proofpoint-ORIG-GUID: heK1uKUja0t9WN_vA812Jcv1KFVLZ5LX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-29_01,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110290026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Oct 28, 2021 at 08:17:23PM -0700, Joanne Koong wrote:
> On 10/28/21 2:14 PM, Martin KaFai Lau wrote:
> 
> > On Wed, Oct 27, 2021 at 04:45:00PM -0700, Joanne Koong wrote:
> [...]
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index c10820037883..8bead4aa3ad0 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -906,6 +906,7 @@ enum bpf_map_type {
> > >   	BPF_MAP_TYPE_RINGBUF,
> > >   	BPF_MAP_TYPE_INODE_STORAGE,
> > >   	BPF_MAP_TYPE_TASK_STORAGE,
> > > +	BPF_MAP_TYPE_BLOOM_FILTER,
> > >   };
> > >   /* Note that tracing related programs such as
> > > @@ -1274,6 +1275,13 @@ union bpf_attr {
> > >   						   * struct stored as the
> > >   						   * map value
> > >   						   */
> > > +		/* Any per-map-type extra fields
> > > +		 *
> > > +		 * BPF_MAP_TYPE_BLOOM_FILTER - the lowest 4 bits indicate the
> > > +		 * number of hash functions (if 0, the bloom filter will default
> > > +		 * to using 5 hash functions).
> > > +		 */
> > > +		__u64	map_extra;
> > >   	};
> When I run pahole (on an x86-64 machine), I see that there's an 8 byte hole
> right before map_extra in the "union bpf_attr" struct (above this
> paragraph).
> It seems like this should be padded as well with a "__u64 :64;"? I will add
> that in.
hmm... I don't see it.

pahole tools/lib/bpf/libbpf.a:

union bpf_attr {
	struct {
		__u32              map_type;           /*     0     4 */
		__u32              key_size;           /*     4     4 */
		__u32              value_size;         /*     8     4 */
		__u32              max_entries;        /*    12     4 */
		__u32              map_flags;          /*    16     4 */
		__u32              inner_map_fd;       /*    20     4 */
		__u32              numa_node;          /*    24     4 */
		char               map_name[16];       /*    28    16 */
		__u32              map_ifindex;        /*    44     4 */
		__u32              btf_fd;             /*    48     4 */
		__u32              btf_key_type_id;    /*    52     4 */
		__u32              btf_value_type_id;  /*    56     4 */
		__u32              btf_vmlinux_value_type_id; /*    60     4 */
		/* --- cacheline 1 boundary (64 bytes) --- */
		__u64              map_extra;          /*    64     8 */
	};                                             /*     0    72 */

or you meant another struct/union?

> > >   	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
> > > @@ -5638,6 +5646,7 @@ struct bpf_map_info {
> > >   	__u32 btf_id;
> > >   	__u32 btf_key_type_id;
> > >   	__u32 btf_value_type_id;
> > There is also a 4 byte hole here.  A "__u32 :32" is needed.
> > You can find details in 36f9814a494a ("bpf: fix uapi hole for 32 bit compat applications")
> > 
> > > +	__u64 map_extra;
> > >   } __attribute__((aligned(8)));
