Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9E4403E46
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 19:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbhIHRVQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 13:21:16 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64840 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231723AbhIHRVP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 13:21:15 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188H9DVU014174;
        Wed, 8 Sep 2021 10:19:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=rPhXMen/ijohqSGTU9u0EsFbnKZcHdZyAH/s0yJJNWE=;
 b=Izuh4ZttqrVYbhTt5xTYHUgn7E8+6RHLThgNbhSKt5/ZBvrpDt8OFE71v2o5Msb74hL4
 HZ62+aieeOl1AQavE1JwHw8j+BXvyGi8/JBgAg+L1fV56fkdRFIMAPPF6bWYuIDhonwF
 tBfGKmrLwxEqB7wH4XTfZiw8PoPAH5hLStc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpj77u2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Sep 2021 10:19:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 8 Sep 2021 10:19:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJCy8Yocd2nkbC4q36d+S8quFVIE0ukukTZWJk+btmob33Z/U1rgk2nWlCwDLka1YacyCiRMBMtsQdhDR6GbPBWIPXDYD+bqloCBRJ6Hyydh9YNrpd58W4+yUOxGycAfYSgWu+pgACfVNQ/nuGRipZT3VjC0KpF5JCfDMAlnv37lCkODtmc1hgCgPvqiFmgkQlHcGyhNxox2hMNFpPrj7xAuaaNbTLuBivMw+P1JYSuuLTGvdv3jmaDxDXHJ+zMzyn6GfVqxXzYomPYSuLopK2/CNRcWzK1CG2kB/VcfeoGJT3dGk5pigUv4eCCcJBKKHdjl0ZAMtYfm45canmt5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=rPhXMen/ijohqSGTU9u0EsFbnKZcHdZyAH/s0yJJNWE=;
 b=jEYHYSRZ4PgFtkA2McGdfssPN7KuhKxKTNS11/B6jjhp3g20GsXolLG3qjbiORphEG1zEqjDIBJ3iMdR8Y6atW880oS+UvZ7GsB8GxqyhDN/zRO443ktifXHHVbAExWzo4jJG4SpdnlNLIXY8VckD1/2lX4kNisGrxXR4tYhyDTugmwlp5RSpzCrklU3cN7lxAUHAFnWFvLXL3tqSadxqU3PJ6Nm01OxeKhkXdjE3ibsdAdAgecCpKybDogerSOpdLTaLUugHL6Y5ZEEVvHxeQTfUzxUV8H1/jehHrLlIWFid3ETggt03rhKlcasoPYaI0bD8g8eyQN6vfU5zC8K8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA0PR15MB3839.namprd15.prod.outlook.com (2603:10b6:806:83::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 17:19:41 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 17:19:41 +0000
Date:   Wed, 8 Sep 2021 10:19:39 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao1@huawei.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] bpf: handle return value of BPF_PROG_TYPE_STRUCT_OPS
 prog
Message-ID: <20210908171939.l6ozdyoji3n5baaf@kafai-mbp.dhcp.thefacebook.com>
References: <20210901085344.3052333-1-houtao1@huawei.com>
 <20210908060611.jylpjegug3gs5gys@kafai-mbp.dhcp.thefacebook.com>
 <8e8dd070-ba19-2153-bf9b-8bbb16a70abb@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8e8dd070-ba19-2153-bf9b-8bbb16a70abb@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:6717) by SJ0PR05CA0125.namprd05.prod.outlook.com (2603:10b6:a03:33d::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.8 via Frontend Transport; Wed, 8 Sep 2021 17:19:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afc60345-8731-4c27-c34a-08d972ecd807
X-MS-TrafficTypeDiagnostic: SA0PR15MB3839:
X-Microsoft-Antispam-PRVS: <SA0PR15MB38390F3F34F1743E0A0AF2CDD5D49@SA0PR15MB3839.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFj50DK0zWH9gybhTjBJN2tJclSyttHRicwD9KzmOWZ6MSFMRa6Q92gwpEx6hlfhOOwNu4ajJwPpeLkJe0Y8aAKwXbtOsiPNEeVjgefYD09jFS/eA9aFWcw+fsGWHqxb2mtlFVj1tIXBI8AiaBuilEPwijouR+LtVM/+3KiVW3z/p8pdsTfySmpq/6eyaUwYvVrApSsCQyN/gL5xyS4M3658iecdvD+x2Fcn24IKi8W15K4ELgwnItWXikdvYIz8HLe4r/tN+YGd/Yscqih2EkPA9+WcacbvV9Zk5dmdziqTpxs1AbX1qpIgQQIAG6f+LMfvcJGN8evHiKO/uoPNMVhmXHDfWMxMHTHcBkvzI3evvrQmpMIVNzQSEsMr4ue6YJbTHRndx9FfQWkTbDgpv6/vCzRWvD3UPLZpIV/9gI7ei8Rj+BnpvQ2fB/5kTr3cDkm1PQ0gFcdTBNJhLz7Hps/W1fS++6NAPMczTFAJdDd0pA8apEqO3CW9hnQleT/uDdAzF4uFSETbdQanqSqYh2iw51ZzVDQVzg8JALPjOyzQD64AaRJI4P9yEi2/9GumMWL0oP4ozFwMolqPDJudjMDEtSx9U/DIxHjy7U7jOpM0kxkeGstyo6nZISUET/AhmlrwnQNGlTiqV7T5STg9Kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(86362001)(316002)(186003)(6916009)(5660300002)(66946007)(7696005)(8936002)(55016002)(4326008)(478600001)(1076003)(8676002)(38100700002)(53546011)(2906002)(6506007)(9686003)(52116002)(54906003)(66556008)(66476007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBur2fl3EGuOjVlrH1td+UWInvch7Azx3nxXf/i9avn75U4XGaJMcGnW286a?=
 =?us-ascii?Q?sOUv+mqy+ie7NBCTu9U5YQ/6EJVbfQnKyq3ynXXiKwdw0u1U4Wb7VXZmHr1o?=
 =?us-ascii?Q?3Ch8CZBsE70mGrYf6mwnohWEaL1SF36P0eq4GyaFQXvEnwbZlFQEEUZJRxkL?=
 =?us-ascii?Q?YGUD6hz13W1Pv0vTAUYyQYv25XIjDbjFclIi/X2PhNg2LEMvWVh3cDmzOj3+?=
 =?us-ascii?Q?A460sdA8woV7LfUWyzrQ+f/JMwdUOOthjicV9P/NsfNnyRJYklnJc6MdOJkN?=
 =?us-ascii?Q?706jMpuQ7WNb/+AplYx4nH+broDTAjrLEO1OkI0TTYtdL8MKPU8KvFhl9Xad?=
 =?us-ascii?Q?+9UpyLlecxvJn+zWH6V0AvYbGJDMYof8pkjUum1lJt5mP/EzTc5sdGdmFo04?=
 =?us-ascii?Q?8f1Wi/Z5uX0dBMkpqNJF8PcrJjbJl2GSz5A4xXvjSDYJqWZ2YT2Ingmhl8WK?=
 =?us-ascii?Q?1jPvVWQ90FRcsV8ajs0GMHFi/u2T02zOIbA3VvDCZBvyyYA5F3DrljtEn1aI?=
 =?us-ascii?Q?lN1ozfsD72FRyUuOiNQNBux7ssb1JaJBQiqwVTOcWkrUZSU/dS7fQaaHblXX?=
 =?us-ascii?Q?eBvUPjjR4LsCW7OhSA3VQUXgltWzxcn9WJ8o07CKm+TcrayukBPXf4/wbcT2?=
 =?us-ascii?Q?0NFyMwGtixp8nLxdlFsj5tH+p4iJ+Z0/D1W8bYmXZD7PV7lhJAFLTrS652pr?=
 =?us-ascii?Q?v1Eius5kGg+/NT0a9WSJ37wQbNS7tZtOzRwucJ7UHSJ6xEFQUMLidNP0p2a5?=
 =?us-ascii?Q?yKT3KMLtx6MYXDOAHQ3bgDf11J/1aNHbZiwWStUyn+8e49j26GmNkNCenrTp?=
 =?us-ascii?Q?RDvAB2AtCNNW+ZDiZts6bTpEYtQwUc9SxMblxbJZYIvQg+TCy/SuQsbgaEA+?=
 =?us-ascii?Q?A2nqevXblhScqS/7DTrsIKdJUp0Q7wpUEmtIAplHoSdoDEKEVWg8TbGvxtcN?=
 =?us-ascii?Q?vckQrV/MUAsViDDlCb2NtmdX/zyvKDbZFGep5GBk3XvhlM6yVyDYUytdeVyv?=
 =?us-ascii?Q?03JUpTaHRpfOVSxwJbZOd2kVDIvLnASxZ4CF7E7/Q+Yw9NPPgttNyZ/FiAhT?=
 =?us-ascii?Q?Ut3x7U/gOzNAXxyHg96loeP/6S/BgZLEEdT0CknmrYED6xgkMPl8DFk+4kJ5?=
 =?us-ascii?Q?8QzAZxvxfzZDiXS6LoPgb8BI/YdfvuN5wxLjnwpQNYwvoWyVPHgmm6eRa470?=
 =?us-ascii?Q?uVI4Yzj6PwaMJDZaJyFHtsPqJdYofUHrdV/DEG182t7K6oT4VOvLlkYf829V?=
 =?us-ascii?Q?hYUB+JqNNH56JB0jzAD4a9ZTq4/4U+YmYeGd79X0VOcwbq/bVSHyGygQHrGL?=
 =?us-ascii?Q?swOPN9UviH28/yc1HXAwhz9tYkj0c9aW/U5AZw8wqatJsw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: afc60345-8731-4c27-c34a-08d972ecd807
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 17:19:41.3703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRBePI8Lh7l1bRWTYFyoKJfz06S4655cfDjIEso8YJWPQExSt9xbASvhaoQK0kga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3839
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: z9BqIs9itDJayin1h0Sj80yUXz19tcAp
X-Proofpoint-ORIG-GUID: z9BqIs9itDJayin1h0Sj80yUXz19tcAp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 suspectscore=0
 mlxlogscore=655 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 08, 2021 at 09:31:55PM +0800, Hou Tao wrote:
> Hi,
> 
> On 9/8/2021 2:06 PM, Martin KaFai Lau wrote:
> > On Wed, Sep 01, 2021 at 04:53:44PM +0800, Hou Tao wrote:
> >> Currently if a function ptr in struct_ops has a return value, its
> >> caller will get a random return value from it, because the return
> >> value of related BPF_PROG_TYPE_STRUCT_OPS prog is just dropped.
> >>
> >> So adding a new flag BPF_TRAMP_F_RET_FENTRY_RET to tell bpf trampoline
> >> to save and return the return value of struct_ops prog if ret_size of
> >> the function ptr is greater than 0. Also restricting the flag to be
> >> used alone.
> > Thanks for the report and fix!  Sorry for the late reply.
> >
> > This bug is missed because the tcp-cc func is not always called.
> > A better test needs to be created to force exercising these funcs
> > in bpf_test_run(), which can be a follow-up patch in the bpf-next.
> > Could you help to create this test as a follow up?
> 
> Yes, will do. The first thought comes into my mind is implementing .get_info hook
> in a bpf tcp_congestion_ops and checking its return value in userspace by
> getsockopt(fd, TCP_CC_INFO).
The bpf-tcp-cc's struct_ops currently does not support ".get_info".
It will be a good addition also.

Different bpf-tcp-cc implementations have different infos, so it cannot be
bounded by a fixed struct like 'union tcp_cc_info'.  The format should be
a btf_id followed by the actual info-data.  The kernel should be able to
learn the size of the info-data from the btf_id.  The ".get_info" is
also used by inet_diag for tools (ss) like iproute2.  libbpf can pretty-print
the btf described data and libbpf support is added to iproute2, so pieces
should be in-place for iproute2's tools to handle data described by btf.

For ".get_info" in getsockopt(TCP_CC_INFO), not sure how the application
may use them but I think it will at least enable the application log
them as other kernel's tcp-cc do.  The implementation details may
need some more thoughts but should not be a big issue.

> I also consider to add a new BPF struct_ops
> for testing purpose, but it may be a little overkill.
A dummy struct_ops for testing makes sense. It probably should
be the one done first for testing purpose.  Although "get_info"
is a good add, having a separate testing struct_ops will be easier
to test other interesting cases in the future.

> I just check that it can be applied both on bpf and bpf-next, do you
> have other commits in your tree ?
There is no local commit.

From a quick look, the patch is created from a pretty old tree and it
is missing the BPF_TRAMP_F_SKIP_FRAME.  It is introduced in
commit 7e6f3cd89f04 ("bpf, x86: Store caller's ip in trampoline stack")
on Jul 15 2021 which is pretty old.

I am only able to apply with the --3way merge like "git am --3way".
Andrii, is it fine to land the patch like this?

> @@ -1949,17 +1972,19 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>  	struct bpf_tramp_progs *fmod_ret = &tprogs[BPF_TRAMP_MODIFY_RETURN];
>  	u8 **branches = NULL;
>  	u8 *prog;
> +	bool save_ret;
>  
>  	/* x86-64 supports up to 6 arguments. 7+ can be added in the future */
>  	if (nr_args > 6)
>  		return -ENOTSUPP;
>  
> -	if ((flags & BPF_TRAMP_F_RESTORE_REGS) &&
> -	    (flags & BPF_TRAMP_F_SKIP_FRAME))
> +	if (!is_valid_bpf_tramp_flags(flags))
>  		return -EINVAL;
>  
> -	if (flags & BPF_TRAMP_F_CALL_ORIG)
> -		stack_size += 8; /* room for return value of orig_call */
> +	/* room for return value of orig_call or fentry prog */
> +	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
> +	if (save_ret)
> +		stack_size += 8;
>  
>  	if (flags & BPF_TRAMP_F_SKIP_FRAME)
  	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	
>  		/* skip patched call instruction and point orig_call to actual
