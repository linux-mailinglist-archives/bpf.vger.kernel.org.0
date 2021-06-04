Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5320D39B268
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 08:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFDGOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 02:14:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229833AbhFDGOz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Jun 2021 02:14:55 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 1546ALfv026344;
        Thu, 3 Jun 2021 23:13:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=vU1zMI0gj/kGZgKXo48OTg/2i5IbFjbB3tvUUCxdoLo=;
 b=MWy4l52RH3S9RfjrvYsuEANeMbyulvXyRIqG4uhVGAhm6sDTWHP5ydx05KFLZJuI7e9r
 hhn+xmfS+ew9/wkiQADZixHcaaReKAFHN+0C2BFcTp15OIo4zs1fn/b1ftIUuvRCOQb0
 Gxf6/Ec6lxKYx6Lyn9TM0a6tR/E+LIQuDZI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 38y9kq9bbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Jun 2021 23:13:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 23:13:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ4yRpDYxIR79cxvnBNho2GVPBW9HfWDlVBWQLvblh/jN1sTX+OmgwX2xQoNsEG1eV5F7APBmIBB9wKprIM5bhs6IXgG5XmG0q9w0MoPVu4xSU6fTxnUwCbJEepQs7GFApbPNQsDrZfn1UCM6gQKdn+CTCnAbxA19+BJyVwJXFIGvpFqoZUlu+tF/H76+4VXO0MoRj45U5hmmmIfDlraciQqPnKOx8bBnwYBi1PQRpDoie3Qf/tmCAw6UDYW1VXwt4Clh7Ig8Ds4314kxC46tcb8m4SjiGbezj5uQJZzDKA7oZFYOYP/+N5P1+wGMUCaiEvl3Koc56cIBvecVLdg6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU1zMI0gj/kGZgKXo48OTg/2i5IbFjbB3tvUUCxdoLo=;
 b=i+UZbWQFTdA7vwKRaoVWy1XQC1odK2+pTecrd255SnJlzQ3+d75aL0wmNj64n59Up+VGNSx8rnawbquMkm9snwMxrlzZod/sFa9MbaZy2PleSM2uJqcjCT5JgFSbk+5JpI1tQBafTjinxcC1kgSVP33ovHIYn80H4b1+Mx0xticbyRrQsNHFiBXyZSfacFDfXJwP/RzPyJHW6DLPXIrDeJvFJ5OonPOfWvXhUFN2Sh4oQhlvcQWVtgAFUjHmq0o2gNMtaI1T5susA+kVsac1VhXw1QRa4Gezw5s55j4DLNFqV2kkAIkFFIkc3VLv16ifXLi/5R7o+pJaclwwXG9c2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3573.namprd15.prod.outlook.com (52.132.230.156) by
 CH2PR15MB3576.namprd15.prod.outlook.com (52.132.229.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Fri, 4 Jun 2021 06:13:07 +0000
Received: from CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::3577:a44a:dfd:fe49]) by CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::3577:a44a:dfd:fe49%7]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 06:13:07 +0000
Date:   Thu, 3 Jun 2021 23:13:03 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kenny Ho <y2kenny@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: Headers for whitelisted kernel functions available to BPF
 programs
Message-ID: <20210604061303.v22is6a7qmlbvkmq@kafai-mbp>
References: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAOWid-drUQKifjPgzQ3MQiKUUrHp5eKOydgSToadW1fNkUME7g@mail.gmail.com>
X-Originating-IP: [2620:10d:c090:400::5:a867]
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To CH2PR15MB3573.namprd15.prod.outlook.com
 (2603:10b6:610:e::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:a867) by SJ0PR05CA0113.namprd05.prod.outlook.com (2603:10b6:a03:334::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Fri, 4 Jun 2021 06:13:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4391bcd1-0e93-40ad-e8f2-08d9271fd1bd
X-MS-TrafficTypeDiagnostic: CH2PR15MB3576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR15MB357664505A4FA318E2AD989FD53B9@CH2PR15MB3576.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EorFLa/YWjgTaYzQ9K0e9mjPpOfiPxkf+uyI8lIq2nZVZI3SHDe9DlRSGdSebOIZi5BCk7uH+9gegY+wxX1Rh4K0zyb8MhqhWuagmtBKhGWbUWQqZrpMWl6p0f2hp+Y0Tm0azKCiypTQ8jLxznv9VV2zEMBSE5vUiaOmuH2O1ZSqVTVhwBr/pViYU236k5eBPOE9P8Ov8YvDlhoQd3gp8Sey/Wa5jbTb93TjOWmLVts2csp0f6GFqGDlVpgUgnUc0gOqm/B1eZ21AovjQchZ4AJmjkue+7K3GZRKOcmQ/0tF9wDcSrWmf2iXvu7kTbpDc0GfaIBU9AtkEAPw3xLMJ3hr0JpV201GowNgAytq+f5yUyFhreG1nM9FiW/IDM5+jXCee4k2RaCwb7vVHYCxMpOygK27RhrgSqWZ9nL8wvQe31oW86fi4P7x0zwi4RrmzEImfFLh66e7ZwZCmA0cc6obiKE0BUQRpfp8hHyVcyCQLUt2uYvcUje9oqIPu3WWP4mAU6ZmoA/bSOZC8+dxyZdMthdPvOE2H0RBcYWDkBVjet2ZtuoVDb9aZgVQzlmeXRSL5EwOERU7+ByLHtZ+D7ZGBHyHtI+1gO14M9kf1Sc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3573.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(6496006)(66556008)(8936002)(86362001)(6916009)(4326008)(52116002)(6666004)(316002)(55016002)(38100700002)(54906003)(478600001)(4744005)(66476007)(186003)(16526019)(66946007)(9686003)(2906002)(1076003)(33716001)(5660300002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GVdXgGm+soGKeDyFmYxff7QnFQ+AIhyEwJjxwad2QxSl/wmoR1ntVF0faEyD?=
 =?us-ascii?Q?Z7znGdjVfJPfqiSVqxxwm5VvPhE0PROJ0MONzQQMKZIdD/T0Ga3BytRh2P03?=
 =?us-ascii?Q?yJpIYHHkSbLq8r2sly/abj0T/aAjxD9SB/m7ViiInqtGvW0ph06FJh1c8a2j?=
 =?us-ascii?Q?+rM4kL4JbdXGwYcRKKK/KeA5z1vb3wdY8VtYNkGp29DBzsE0SadZe5CfOQKV?=
 =?us-ascii?Q?3HrpDTXNsOXbCwazxGKWBOoxQmlBViqXrKMxABFEjQJ9cBzC+a5hsG6wHMKE?=
 =?us-ascii?Q?I2J6bJ1OjCjKsRejKC54+irDAZAY6d1mR9kbr1Bg+RGce4GCYTKIPbJrdrlF?=
 =?us-ascii?Q?QI5+DV/z8RfE+rI2TBBDOM4411rQ/gyHa3+9cTNqo3LJ5v9vks7RsBRcOsds?=
 =?us-ascii?Q?I3mLzsrcq67VtNEwJPa00jelqYUWwVmyWx2rCZZ/2urrb2qdECrSc6zSlb3T?=
 =?us-ascii?Q?xRDnPb+fS43CzL/lXmcoeA/aifhYDsOXptQ3WJDEmc0htYFN8JDSyMcUSGIO?=
 =?us-ascii?Q?jSya2uIG2r4QXz0JU08CFRyuLOVPfYm4Wlt9L3tAgX2xThU2zgMIi+vnkI3/?=
 =?us-ascii?Q?kAReU2Po8H6Gl8knvwGm98QN+7CQvE0aT0++ZfrUisS3Odi8sbGgIrdpQCAo?=
 =?us-ascii?Q?tksoZWflg6zw9MNphkKgAPvqfsR4bIamx84FGTLUpfkcLGCot0Rx/McPCXYr?=
 =?us-ascii?Q?8wxG5sfMzfAamwqlUSC0Q+1+UY8FtTl+ml6uzLce3FUwp/OU518tIQhKOTlo?=
 =?us-ascii?Q?DKl+KbjsbBe8+feVMzfd2uQ4aitqI976VAJesqOfbsq9V+vfPvQL7I76zeQF?=
 =?us-ascii?Q?N2jH0tLEFX75WiwNoY/8C5/RbKNycUix3KZQrhbdlINP41yzybaKYjS+fFGI?=
 =?us-ascii?Q?IC8WHJY1A1K3NICkArqUW+7N/xYj7mwB26r2mZ8BOpQDT4f1E+zSC0omzhQu?=
 =?us-ascii?Q?4Ln3+PIIWW4PsmAzZ1e9rdu1e0lm41HcKnVuIaYfeLWa/RUpx0B5vpO5kSZC?=
 =?us-ascii?Q?T64RmU/rlpDxX7RQbFVFr8B0U4cDfHfBXWbIJEO1MGebo72R+aheNWO5DeiV?=
 =?us-ascii?Q?+o+tliPSf1tWvMXy0XQU2K4JIv1iYkc7lcRTLVIVd1pY2utRlIThFQHRUmr6?=
 =?us-ascii?Q?wlROUqVL5m0hhiB6xIzd/UXXBNWYYnJPAeHVpzGYQhDuWofh+z/IES69s+Bq?=
 =?us-ascii?Q?q5t+xz/QJMce2hew1FTOqrbDQohBO4O6xztix6XePjDByZgoTzcmOdSdN1VU?=
 =?us-ascii?Q?cy/5H5I8eiB+lpZzDpIk9UfWLCmiEFXHfe54aPqQ4RD2nuwMiJwaeFhajkTF?=
 =?us-ascii?Q?PvQgWUtgeMQj2RtxkP0LKl8/J9qjTiMyCIKoxtp/hreZVQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4391bcd1-0e93-40ad-e8f2-08d9271fd1bd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3573.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 06:13:06.7788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aJ6UVyRUBuNIvUzkHpSQ3o386maygvXMyg2UjnlDBgkqm18/u8/8Z5nUp8UZEyk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3576
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: bhnkMPdpYA3B1Z1BV-MxLKqBiPhIYnTf
X-Proofpoint-GUID: bhnkMPdpYA3B1Z1BV-MxLKqBiPhIYnTf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_04:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 phishscore=0 mlxlogscore=961 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 03, 2021 at 02:01:13PM -0400, Kenny Ho wrote:
> Hi,
> 
> I understand that helper functions available to bpf programs are
> listed in include/uapi/linux/bpf.h and kernel headers can be made
> available at /sys/kernel/kheaders.tar.xz with CONFIG_IKHEADERS.  But
> with the support of calling kernel functions from bpf programs, how
> would one know which functions are whitelisted?  Are the headers for
> these whitelisted functions available via something like "bpftool btf
> dump file /sys/kernel/btf/vmlinux format c"?
Like other whitelisted functions in BPF, the list is not in the vmlinux btf
now but could be a BTF extension in the future (Cc: Yonghong).

Making the kfunc call whitelist more accessible is useful in general.
The bpf tcp-cc struct_ops is the only prog type supporting kfunc call.
What is your use case to introspect this whitelist?
