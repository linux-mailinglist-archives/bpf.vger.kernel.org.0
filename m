Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4D9172789
	for <lists+bpf@lfdr.de>; Thu, 27 Feb 2020 19:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgB0S2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Feb 2020 13:28:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726805AbgB0S2N (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Feb 2020 13:28:13 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01RIRWMh020914;
        Thu, 27 Feb 2020 10:28:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=HrU/7npdbSktQkc4G8KCWpXMGWHbD440WZeaZUtParE=;
 b=GNh8V4YEIB8qm6iSmECdIo299E2QBUjcOdgGqU/NKAt7MGHTHkIwYccW3laWNO79KjyB
 XFmv1+y9ysvxEfYLcHK8wIWy1i4nvd53Xky0d2dUM3I/X7bkwxuxAt3g2N9HsdeqrhL6
 JlU0jNB8JqkdJKrfvi5+inlR/wZIjUX3JIQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yegtwruxv-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Feb 2020 10:27:59 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 27 Feb 2020 10:26:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJRsJS2JVB0Bi/NJG6DiiYl0g+clid73WzGICnDtH7/WPR8E7SWKZPJNZQ2Yhy4oiJXnPeXDcHPTwccNzweBCfdVrTI9aw3U2IojfoyI5vhVqqWc/XL1kt5tNExQTm/f+JCR//28lsCtnJEGblnaUOKXHPedtd9c3POOeauh1cFxTqO7KHfDvmqqWzACxnNBhGSR3rWGDALozhbfdbVcgawFd08znyFEqyUNz691nINr4Gh0EwILPb0v09hbBTEx128bRopuhvxqxPFhVmynTRMWSz/WuAKoXsuahztsKJ4Qn6GV6NN2pJsjMe5UeM+FT7NvcyzBfUFD/WGStks+Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrU/7npdbSktQkc4G8KCWpXMGWHbD440WZeaZUtParE=;
 b=Hz4j2aRTu+VNlIWtnybAjazCx0ib1fnumj7e2y/54sOjTKb9Ae7Ac3sD1yOijNJWyROf9oRoJmcYKrMmgjTTQCz2UAvw7A/C6VUZfhP2Xd5CiDQgutZRHm94CQ8hCVRKe3xvf1uSnUd02wS1QB2n3l2qnghnILGeUQMxhRT7SoJ3ZHKcdZZI+iXxpBMu+Ih9/+S79CACPugdhy/86CjVbgwP8TJYYYa7vwLatyCNOw/ZILp7KFzDagVb6CBwWJbtHij9ubibOMjLKkrgcBgQ6QwXZi5C3zkLmwQfZXVH5dHhNDRbM+wjR5MwlMZqpURJVTefcnRqb36koeozgGJ89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrU/7npdbSktQkc4G8KCWpXMGWHbD440WZeaZUtParE=;
 b=GC8SgTUic3l37FhouV1sbbhIiVwaNxRpSW3iA26Bu1ze3t59vNKG437NbXx5AwIXvDBNh5G+KqziymLPIu6KCqRlmAEahzNtBrqOcC1PVEb51h6B08KL7Rpytxq7Cg4sSIvtgnCAt8nYu8uHGCmYZHUSLWXyiWr/4ktrlavoMFg=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (2603:10b6:320:25::22)
 by MWHPR15MB1135.namprd15.prod.outlook.com (2603:10b6:320:23::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Thu, 27 Feb
 2020 18:26:55 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::b47a:a4d2:b9dd:eb1e%5]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 18:26:55 +0000
Date:   Thu, 27 Feb 2020 10:26:53 -0800
From:   Andrey Ignatov <rdna@fb.com>
To:     Stanislav Fomichev <sdf@fomichev.me>, <osandov@fb.com>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add drgn script to list progs/maps
Message-ID: <20200227182653.GC29488@rdna-mbp>
References: <20200227023253.3445221-1-rdna@fb.com>
 <20200227180102.GA188741@mini-arch.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200227180102.GA188741@mini-arch.hsd1.ca.comcast.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: MWHPR13CA0041.namprd13.prod.outlook.com (10.173.117.155) To
 MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:500::6:b3e7) by MWHPR13CA0041.namprd13.prod.outlook.com (10.173.117.155) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.9 via Frontend Transport; Thu, 27 Feb 2020 18:26:54 +0000
X-Originating-IP: [2620:10d:c090:500::6:b3e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e3dac09-5295-4b25-216d-08d7bbb29f4a
X-MS-TrafficTypeDiagnostic: MWHPR15MB1135:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR15MB1135B256791C660560A9A83BA8EB0@MWHPR15MB1135.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:628;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10019020)(7916004)(376002)(396003)(366004)(346002)(136003)(39860400002)(199004)(189003)(16526019)(9686003)(966005)(33656002)(478600001)(5660300002)(186003)(66476007)(52116002)(6496006)(66556008)(66946007)(316002)(33716001)(81166006)(1076003)(8936002)(81156014)(4326008)(8676002)(2906002)(6486002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1135;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhGaOXJwh/zrX+l97DCaTNyhO3OqBLa3ToFa1SwGJwAu52WwRdZNjcjzF/JoFkWbiKzykg/kxDGfGz/fs+GezQQj3pZnmlB+bTn4FXYSIChFSSDDLzvVGKOTi/6huthdf59yefSUDGz4mmattTQPDg8s3SFc4scP/eCWpBoY3kJBxuCrZhCcoXTxVPJ8xkjesSOU2Ae1DoCbbmAeb2IZlYhGuS2ArUKD+Gd4ZI6eeVC0R2eoDK7Z84RXWl8PWuXoDnC32S72JPZlMtsMu971vd8vsBov+kZkyr0jKUGsMYG8W3uZdbkQuFhWE3serqLBxrcQ+cwvA2S2Y0+sguy5bI9RR5cagIgEv/Ct+tmpbXN4zVXo/34LYRTcpGP2K7RZcatV8XWyLRHCWE5Jei7jlG7+sdMziemoMdsWo3+/CnjS58dcb/sNaSf1i85i2XWcdWzPkjk7+NZUY8GIA9FcXbsP59DI2H/aK/MaDV7fdIqPCn6E51UJcDXDc1CdcX8so3VZe1HEekXfFGIknQ222QS9OdIiHZg41CEu2byuUa+rrrfuY+ZcRcnjalGVl7zSzmOQp1WVuDZvC6fgFMIypTrOVRqHjy3IeAjQafwh0bBLsqHPyngsKF8CwIagtoek
X-MS-Exchange-AntiSpam-MessageData: iqvhf5f5RVyMRKAzV5X92M09BPUjqkMowV4wWgQisxze9QHAPZ31uOelIQRLWEhcwl5t2HK8qCJU23yMmO0KycU+6+SQE2PXaSQ4LEagvPtG1Fx9qe4DugMOcdfcCYJ4UXfeMZtaZeWBE3gROoNDsW3IGINpCaeIjhYazFdBJDQeUdTlemK3ZLobDqTTOoSc
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3dac09-5295-4b25-216d-08d7bbb29f4a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 18:26:55.1090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pu4lD2FJRjPHVDPZCJ1NPxyzGS/aMFbDh9p8WoPkVJXn47ficPqCLvcqQqVvaeO7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1135
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-27_06:2020-02-26,2020-02-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 clxscore=1011
 bulkscore=0 adultscore=0 mlxlogscore=875 phishscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002270130
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@fomichev.me> [Thu, 2020-02-27 10:01 -0800]:
> On 02/26, Andrey Ignatov wrote:
> > drgn is a debugger that reads kernel memory and uses DWARF to get types
> > and symbols. See [1], [2] and [3] for more details on drgn.
> > 
> > Since drgn operates on kernel memory it has access to kernel internals
> > that user space doesn't. It allows to get extended info about various
> > kernel data structures.
> > 
> > Introduce bpf.py drgn script to list BPF programs and maps and their
> > properties unavailable to user space via kernel API.
> Any reason this is not pushed to https://github.com/osandov/drgn/ ?
> I have a bunch of networking helpers for drgn as well, but I was
> thinking about contributing them to the drgn github, not the kernel.
> IMO, seems like a better place to consolidate all drgn stuff.

I have this part in the commit message:

> > The script can be sent to drgn repo where it's easier to maintain its
> > "drgn-ness", but in kernel tree it should be easier to maintain BPF
> > functionality itself what can be more important in this case.

That's being said it's debatable which place is better and I'm still
trying to figure it out myself since, from what i see, there is no
widely adopted practice.

I've been contributing to drgn as well mostly in two forms:
* helpers [1];
* examples [2]

And so far I used examples/ dir as a place to keep small useful "tools"
(tcp_sock.py, cgroup.py, bpf.py).

But there is no place for bigger "scripts" or "tools" in drgn (yet?). On
the other hand I see two drgn scripts in kernel tree already:
* tools/cgroup/iocost_coef_gen.py
* tools/cgroup/iocost_monitor.py

So maybe it's time to discuss where to keep tools like this in the
future.

In this specifc case I'd love to see feedback from Omar and BPF
maintainers.


[1] https://github.com/osandov/drgn/tree/master/drgn/helpers/linux
[2] https://github.com/osandov/drgn/tree/master/examples/linux

-- 
Andrey Ignatov
