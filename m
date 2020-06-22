Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F37A203F50
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgFVSja (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 14:39:30 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48894 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730303AbgFVSj3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 14:39:29 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 05MIcOx5023626;
        Mon, 22 Jun 2020 11:39:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=0XvLYnSOF+kshxO7Syi91Eblk54de9qGHjoLxZWyWGc=;
 b=AZjVjGV8PymKKGtYDkOnj0rgNlUogEv8itWYN0R1cOj/1x/79aLpnPvY5+jc9DR0XUTM
 pHKRKpicfVjB6TvDL2c60X+qN4KmIqKrYWs1pvySwYK6W05AuYsDl41v8n5shE7kRLmL
 R10L4rgFhZgPbgB+teMblO6UR+rlZgqffeo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 31se4nhx2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 11:39:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 11:39:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg5tL1/gSIvKwaZMn+ohFeesacdaXFqlqvpLkE+MVH6IgtcV6mGpjsN2D2pQmIevrzA4wBkm+NabqzJ+W1C6/NJS1kHFf/jUNk5o8/eSd3L20CH2P6clFybazP9uTb3xRpq3d5u5Cpgh++e6wbg23qY+fHJo4gS5T5DYW1xqyhOFNRhywgacEymsBj/l7PdiaSV7bsTxOGF7/urPKqs+n0epCehYz54WbUowOUJG4O/XJslWvgf7tE7aRAb6LTTUlb8pbnbsuhbC/V89jyav/U6J5T6ENhdvHHoUf50v3KScWpIZp7dDIMu/JGpGDqvovFmhrPfgFDg0svN1RQVbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XvLYnSOF+kshxO7Syi91Eblk54de9qGHjoLxZWyWGc=;
 b=Kd5ZfJDgR2T6RZgLsuHscXtu6Af9oBgZGnfwKr5PNV0jctjgCy6T0HYcpEyAUxfxq9Cu8sYANALKk9qei7UorONeDGrIIqMH6IVBgb42I2QYPhGtXWNzc8ambI5Kxnx6375tj0pHCE1Wa9okR1hYq5Ut0clabd7yjs23brhF+gS1fnsdhVbAjwUXGwPxxoyRnV6O/pMblLtKhBLJUBWao+o1JlK6SkZ/AK2MKfCNzAyRAZ2lhMHwAKeLKJ3QnXCwIHtWEsIpb9MJL6hBkbUWuUH3/DZVOEEiM/m4S7LCVLyRRBiqEYHm+8oFOPL2sMeRr2keLRVJmWE2rBSVOz9J3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XvLYnSOF+kshxO7Syi91Eblk54de9qGHjoLxZWyWGc=;
 b=aPMX7vJ9KK++Wl+dQpvl/7UKvIrIuZ8GtHQJJPzgP7Fbh0nLot7yPDqN1TEJATRmc7d4rRZ4kOcNiHoitZQB9PyAokiTxX7/ajFx1t7KZiXbjQcbcjc9wGPzVyzrbM7B//WkHGhipBoSW3Qd7iWPYHADDa533l3nL0kSZnhBIkg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2199.namprd15.prod.outlook.com (2603:10b6:a02:83::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Mon, 22 Jun
 2020 18:39:12 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::bd0e:e1e:29fb:d806%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 18:39:12 +0000
Date:   Mon, 22 Jun 2020 11:39:11 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     John Fastabend <john.fastabend@gmail.com>, <ast@kernel.org>
CC:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <kafai@fb.com>,
        <andriin@fb.com>, <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Support access to bpf map fields
Message-ID: <20200622183911.GA31771@rdna-mbp.dhcp.thefacebook.com>
References: <cover.1592600985.git.rdna@fb.com>
 <6479686a0cd1e9067993df57b4c3eef0e276fec9.1592600985.git.rdna@fb.com>
 <5eeed39388e0d_38742acbd4fa45b89b@john-XPS-13-9370.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5eeed39388e0d_38742acbd4fa45b89b@john-XPS-13-9370.notmuch>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:bd7b) by BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 18:39:12 +0000
X-Originating-IP: [2620:10d:c090:400::5:bd7b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11c672df-1dc3-46c5-558c-08d816db8ef1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2199:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2199BD105F8E1A1AC4291EDAA8970@BYAPR15MB2199.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OtbN8OR7bfq4d349TpFn2u6PXmJ3GVq1JYf1aCFNGoaUrqG6tZGn7+itclGvTr8Me8CsLAEs16EVLw33BmEjsuxUvn4blb/EEmyvRerlYmBwVp88jGsrrM6YZgg73apfpPDFnTCOc3CbVclVTbggn4+FHJmpctEvn8U7TLTNngMp5WI4V6DEJWt8JUy9EcTrMFDkVqS1PDb94RvNskuKMW0sLcq8HQwVvpP7FhTaM1XUihW4Bq8nnJxnRRYyYpJaBN49Fjr+7aoO6f7/ENfy+fpCe4LlR67Rt/RqydBkBvpBmIzRY0Vo6rsjOXlkFzLPaxEBXApFdxSXURKU/ZJ1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(136003)(39860400002)(396003)(346002)(4326008)(2906002)(9686003)(1076003)(83380400001)(6496006)(52116002)(86362001)(478600001)(8936002)(316002)(16526019)(186003)(8676002)(6486002)(33656002)(66946007)(66476007)(66556008)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cGRQEfABmQjaghoUd5PJZX81jDnnrepMvPnC27AWNCK7dmwqIJAm55huOmj4TXflwg2CtDqlOJwiilumc33hxL1n74p2A5R2ysCVIuU0QyuKC9XMAzxQqPHMgoq/KT3xhHUL75FWaD6qNOWg4YRr0KkfBIzLNEth3fe735X/mEB3NIuXPsxC0iMelJ3UssPy5S90xvXd8gOt2Vn/1mTH2oJ7YwvkHDRtmjbgy6ZkwpgmD/reNpCGbhCXAmTgJck9rDzij74LKGEbmgWe0RbwSC9dGi7KqM2z7ZOtYj3OC0hUBGtCc58SoBijgugV4ul9+Q7hKVcZ9g/Dk7twe4lmomIkD+EN2oWj2Y4CBcor061pLjpk5FANt7z/jhVai64d5OVglY1DWWAUsVp+ETBLB+n6VvcrWJAYfWu73jJYqke3xOC+813mtpRh5sBe9vSrMfrQGGGpV2jtlL33ge+ccXRmF2RZjDHykLD7DOmx/gwx/JKHiz5ar/rUh7XyhB3HXRuZqri7iDPbZLvQFFLiXQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11c672df-1dc3-46c5-558c-08d816db8ef1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 18:39:12.7923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vm3mshq4y8FKnGsivZAMAu5RnlBa5a8Q/BH4742by7k3ehcrGvCQw7SJ3k+7HntU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2199
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_11:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 cotscore=-2147483648 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220124
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

John Fastabend <john.fastabend@gmail.com> [Sat, 2020-06-20 20:27 -0700]:
> Andrey Ignatov wrote:
...
> > 
> > The feature is available only for CONFIG_DEBUG_INFO_BTF=y and gated by
> > perfmon_capable() so that unpriv programs won't have access to bpf map
> > fields.
> > 
> > Signed-off-by: Andrey Ignatov <rdna@fb.com>
> > ---
> >  include/linux/bpf.h                           |  9 ++
> >  include/linux/bpf_verifier.h                  |  1 +
> >  kernel/bpf/arraymap.c                         |  3 +
> >  kernel/bpf/btf.c                              | 40 +++++++++
> >  kernel/bpf/hashtab.c                          |  3 +
> >  kernel/bpf/verifier.c                         | 82 +++++++++++++++++--
> >  .../selftests/bpf/verifier/map_ptr_mixing.c   |  2 +-
> >  7 files changed, 131 insertions(+), 9 deletions(-)
> > 
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 07052d44bca1..1e1501ee53ce 100644
> 
> LGTM, but any reason not to allow this with bpf_capable() it looks
> useful for building load balancers which might not be related to
> CAP_PERFMON.

Thanks for review John. I agree that this can be useful for many
use-cases, incl. networking programs.

Accessing a kernel struct looks like "tracing" kind of functionality to
me (that's why CAP_PERFMON), but I'm not quite sure, and using
bpf_capable() looks fine as well.

Alexei, since you introduced CAP_BPF, could you clarify which cap is the
right one to use here and why?


> Otherwise,
> 
> Acked-by: John Fastabend <john.fastabend@gmail.com>


-- 
Andrey Ignatov
