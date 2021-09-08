Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD140341C
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 08:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhIHGHq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 02:07:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33764 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347682AbhIHGHo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 02:07:44 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18864jYl029454;
        Tue, 7 Sep 2021 23:06:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=MA0gJcekwxpW1x8L8W0qMaljwYrgkncPbmPFoZLJuwA=;
 b=VljruyLKnBsz49FM91iQKofTXlvvVUPobpyVhsm3ACR1TzIKe3yAQCtukEtHXwIqsJBf
 lGIB8iamrWm95jzbzkFO0uCAOxQrMJ4ngeHpIFpShcFhpZN+O6rByXmUAxrIEclYAyic
 xlmWXIRSYRME7VWBOIqF8iVKbfEHno4f6JQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3axcpgmasm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 07 Sep 2021 23:06:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 7 Sep 2021 23:06:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAV+F01hZJWiGCXnozMIbmCkWdY2+FO8atBasHPYaKvVc73xT2iZmkwNR68RlEDRBZf/6ZnJGBE60Vj2XuBSnHOwEphuHNx/uZtg0AekwTYG+Z8ppmbStZL6g66zSUMvNOluTszgCdbSZsoYsAQ56o5DQcb4L7xAO7NImHs/1VMpNbIbVQ0Pkd3NvbMuJv2LcvR5tY+9Rx850jObQkJKtm37t6iWC3gU7f6OPhS744Tm859xFLYsdnpLekwZvgYmxkLyzieT1ypqDt79Bn/dgP+m2gjft+w1G6IaF+wXdy0qtcsUkKi8fWf9oleqwz5bM4luCziVCDB18JxHgsWZ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MA0gJcekwxpW1x8L8W0qMaljwYrgkncPbmPFoZLJuwA=;
 b=PcRWbysWgRlwQjaUMQck1cq28lb0PZzBDLUgy5/7XARU9bSb2nctDiqqaZCldWviOyWYZdwFhp1cXHpOSp9CWc+FToJxwIr1ZT7ywmufzXpn//Jk5OdFyPJxMA2g51I1VoOFUImvf2KWBNf8ErI3lAFRMs4MVYKuoTpvWkuCz9DK8MRohAxhEn3y6QNnPAeoLJ6R8EEaBRQy9pz20ktWAw/50sroqPi/H5o5EvgjzfLcE4Mkzv03XCi8f4+DZiZ2pu5SONHfZpAkcgEGKbKf2XOqF3s3gM3SrovqYHcJpkHRhgCN7A/NcjevxYhXPVFA4T3oU/GClfZRpM1zY2fmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SN6PR15MB4272.namprd15.prod.outlook.com (2603:10b6:805:eb::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 06:06:14 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::3c1b:1a10:9708:7e36%9]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 06:06:14 +0000
Date:   Tue, 7 Sep 2021 23:06:11 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Hou Tao <houtao1@huawei.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>
Subject: Re: [PATCH bpf] bpf: handle return value of BPF_PROG_TYPE_STRUCT_OPS
 prog
Message-ID: <20210908060611.jylpjegug3gs5gys@kafai-mbp.dhcp.thefacebook.com>
References: <20210901085344.3052333-1-houtao1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210901085344.3052333-1-houtao1@huawei.com>
X-ClientProxiedBy: CO2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:100::19)
 To SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:96ae) by CO2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:100::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Wed, 8 Sep 2021 06:06:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a97556-c3ee-4554-731d-08d9728ec386
X-MS-TrafficTypeDiagnostic: SN6PR15MB4272:
X-Microsoft-Antispam-PRVS: <SN6PR15MB4272FE57DA0291F2118F7DA0D5D49@SN6PR15MB4272.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0dn6ZtyMbyTQdr6CKvBrgaY239cxnMwXsp86RkXFwjs9XNV904B083YfZRYUg+Wv+4TKKZDm6AluffeFcBluLu8Niw3FZq29gJv9c3D/kHbXVQL8jG/9gQjMF99DQI95mHqzEUCyrICjOEyG0ExuIsSbDUWAX6TavoxEFLdxj+ZG/fnGUIZDGWYevB8xHVdcUKOOsTlbsIbP10v69KRZgvq12GGQaca63T6RMIj0He9kh8o44DSDJS2hDN3UQLtcnbbstDne7oEgNtrkB5lOYnMxZJtS0pVRjIF5EAd3/bGMUPhXy3vxptvGET924Qj5JPBbAXJtIWJ0L+0qjX0NAl3MPaMUCpHqfH7JwF6M/oL7oVo8Yqva6nq4ihWX5HQBPnihygVH2lMdkvuFgIBpWQhdtTOgbWkh8wfOQC/i+uv6iPFF9k5R+CH8NT1YBxHGqAEoXNtAT8CuuzDbCNWWBvhjgB8HtGEqR+yti24tUk8hWMoiznbx7T+AsOaSllHx1v2MAasg3aXozch0Jw1nZ8wcoQGFFjo0HyCzhI3jv1VPwiqTGJKDOyxhqAo6JIRUjQg/feUurpg/Tpfj4f8FLyYa24M+ddzv4POmCMzpcyn6ttgZ8u9lSd+hbUfFQ9eobzlD+2ajNLB1l/w6xp9hUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(376002)(396003)(86362001)(8676002)(52116002)(2906002)(6916009)(478600001)(316002)(55016002)(4326008)(4744005)(7696005)(9686003)(54906003)(186003)(1076003)(66946007)(66556008)(38100700002)(6506007)(66476007)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8UNa+xx3bWmykGDtC0j4dhaZS7DRi7xNI7IjvpPpK0dVuzNkqes598MJBmk?=
 =?us-ascii?Q?KUwmmsI5BeQEniFcMIbpbYbW/LkoHSlBSbA6KMVKQwb3S5P9zWR8NAp4MXu8?=
 =?us-ascii?Q?MBkHasKltmW2bZt8jhdX1fUo9rAsaolE1U/FVF8ZyFf9f6nHllUR1il3QJmm?=
 =?us-ascii?Q?PcxM6lyrR4UoHt2D5c58/zQc+miZkG6afOZ7B+NCusNtO6FbF0Y10SKMozyj?=
 =?us-ascii?Q?uvbBz9vQnHrt6zTKOBvB+FiwvTRPrypppJQbgHG9lBuuTDPeSL5iwKnfU5Bo?=
 =?us-ascii?Q?L0/s0kV4paSQ3wPuWS/6t5+FEUYFOclxhy+Lx0dLKSjRJmoPP5dfaEo8vS7R?=
 =?us-ascii?Q?ih+0P3Mbp/JsHOQzvGmSDjjdAXB2qZ9Lmy/ZrNauEtXi3hiSVFhXinxFFg3U?=
 =?us-ascii?Q?zBQ7wLdw4qg5PEm27LDuhKziOCuJcd7dpH+4I8IsYDR8WZaQ77uupUFdEwvk?=
 =?us-ascii?Q?hURHKRWdZBepu2tr6/dAjOegooB+SViRw75eDXK1dHQxPSEyL7FE9BVesHAs?=
 =?us-ascii?Q?sU71+fMcyPmoJg/DIuPR09PhQS+gwooUFz2DsKkGJ/yWPze82+gIBKQIMX8N?=
 =?us-ascii?Q?B++9SwkyRBDBzIzcAutFpidWB4mh01yEDT+NSjtdlYAoKCuu7a4mrMKGi49h?=
 =?us-ascii?Q?KBIXGpNYP0ugZpH50tuzbvXtt162X4tFjrUjf3LZBg0Fe1nzX8axATiWKw0P?=
 =?us-ascii?Q?YKGcHyOxkaeRLMBl5nsYsZjzWWiO98KH1KEoX/72jeBzG5iqqbXE6Nx4bPGL?=
 =?us-ascii?Q?TsdUjntk/2RVKuZ7+e1E7W/vbEUjUtT2Id2tFhZby5nHzg5sVFfGr8+CmilN?=
 =?us-ascii?Q?jQTw9zTRom4Azk1ZGPdH4kmhvXmc9AjyzofYHptksH7CP3TZjEzUHD/bFXQ1?=
 =?us-ascii?Q?2tHZp0+IOCREzf/HdVoxctGSDTvSGWUUpzfSvbODO4u5fm6yBbPcQxAS4D1Z?=
 =?us-ascii?Q?uvxIj/6mzaQ1KwWJEgKlZm6DSpAEJQZ7W5mTFtvbwVAXfBY/fPQjTaySbI21?=
 =?us-ascii?Q?/94aLnXRBg1kfvrZx67Bh6mHl7pIRGey7ETLGNnkWZ5GrYlFEvIG+m85TNqU?=
 =?us-ascii?Q?8pV3nLgg+70vgLHUd6W3tFiZbQl3NLtzx8F+Q0V3gJwqEFV+cOias0CN4nWz?=
 =?us-ascii?Q?laZaEEGz5sArXDOEDlYWUCfnRJ5aqmJ65YXJ4fHnDnjSwwR2QIl4mecPrV/H?=
 =?us-ascii?Q?dkGAHvO5wzi0r8C56+kSnAbNKPIGGtHpV7V7xevTcaPdZoDnfmB6UqMsbnGL?=
 =?us-ascii?Q?8SRNIeaaw8rdweX1q4Ndx/1KCUxmF3F2juwjx10zY+/qnARIo1tZtrHofFCb?=
 =?us-ascii?Q?kecBiemMguf/sMALK4WmV8eOixmmsQYXF4iHxIWuyw0yvw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a97556-c3ee-4554-731d-08d9728ec386
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 06:06:14.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RJAGhcPVSvnvbTl14r0z2fEn02uehxJRlK/QthWVPnrhy86cDRr3OZfh3OMV5P8L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB4272
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 8mHt6tyAGPnh7jKZHn-BdU-K30nYh92P
X-Proofpoint-GUID: 8mHt6tyAGPnh7jKZHn-BdU-K30nYh92P
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_02:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 phishscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080038
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 01, 2021 at 04:53:44PM +0800, Hou Tao wrote:
> Currently if a function ptr in struct_ops has a return value, its
> caller will get a random return value from it, because the return
> value of related BPF_PROG_TYPE_STRUCT_OPS prog is just dropped.
> 
> So adding a new flag BPF_TRAMP_F_RET_FENTRY_RET to tell bpf trampoline
> to save and return the return value of struct_ops prog if ret_size of
> the function ptr is greater than 0. Also restricting the flag to be
> used alone.
Thanks for the report and fix!  Sorry for the late reply.

This bug is missed because the tcp-cc func is not always called.
A better test needs to be created to force exercising these funcs
in bpf_test_run(), which can be a follow-up patch in the bpf-next.
Could you help to create this test as a follow up?

The patch lgtm.  However, it does not apply cleanly on bpf,
so please rebase and repost.  I applied it manually and
tested it by hard coding to call the ->ssthresh() and
observes the return value.
