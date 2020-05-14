Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABF91D370F
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 18:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENQ4J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 12:56:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65004 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgENQ4J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 12:56:09 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EGrpk8021972;
        Thu, 14 May 2020 09:55:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=220ktKXXD64FdcFxS+/AhHPh854BVwVbXlx2fTiTy5g=;
 b=UiWctiz+i+jSA7rEwJycgj+Dw0eZTp16ymw2gtFkBzObxzDHp9T2fz5nj4w3Z9jjBfOO
 JZW/O0GdAvugflkn7/cuErY5i94VpMrNteKsepDdjjpPyUwGJVL+4W3qEXdOEHPy6NG/
 TTsNvN7Br+gh7Jx9CxDER6Z7u/sT9ROjTG4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 310wawut8a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 09:55:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 09:55:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzNf7H0CToxJ1o9opJM/CVUfeVUM4i6RAzwmbnTicEI5XJZ2Uji1nDE+uW/aQ6tBinManJ7hI+onc/f++GUl/y6jMKH01PSJCFq7VjqyzjuvZLeKk5fWolzLLvTMgXUlM6wJJmVWMm8HmoWddNKQ4u7RZHDuRJzFUkF08Rx91dnmOifukTMZaSyHwGmJ/QW1ovTXYrHPH+73bt8+fA6wxNsUSXg9//gfuoazbH5sfF5u+oNa6/Dbn0cz8KMVhHhVqKjzrmn88jJDM/1cMocZTgB3CrnuxmoajSkSGOC5bUjPX2QGq3WP5uEJ29nx59IE6XRJWW938cFx6uWce7jxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=220ktKXXD64FdcFxS+/AhHPh854BVwVbXlx2fTiTy5g=;
 b=DXW9M4AqFlC4OrotzrT1Yima+IrVszcwwG8phpV/xnct2P5LYu5LDKlsk+BgdCbvlHLKPSd0PHk4tjacKzztbRfyprZ1mAGdu71RYsbTvQYJ8MUS/BPiMJC3sMz0+Yq30xZ+oLwpbHdLq3u19lU7SRkCFeGvbvzlSLxwEhTOuWO0fQTHx940ytktDduN5Bdbd1bFRPQ8D1VCH85pvqcqsOE4wOylCQKm7kXnEJNfD0tlkuQLXeLmmanEMSIilp19CjPo7tTjYzZJiBQyLhbJ5IDn+inwtG7wdZOI+O+5IWOOr/LZmZBKFObdctdgcOBi2n2ggidgkNm8ILSLyNK1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=220ktKXXD64FdcFxS+/AhHPh854BVwVbXlx2fTiTy5g=;
 b=dSzhoQ10/fop4ouxPFqdgxWuVOaJ+I9vY5+uqtbe6k36KMpZq5HEtKIiuvUHTHXfIH6RDmlFBcxlf0H0U6gjbGBsb2Zy0OyPGITaz5tkzmgtBkv5e+gOSjAQf3z0xtgIpQ6kls9qb+/vrUCd/U0ch9k0xcZw0A/bmTh33OzmF5o=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2503.namprd15.prod.outlook.com (2603:10b6:a02:89::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Thu, 14 May
 2020 16:55:51 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 16:55:51 +0000
Date:   Thu, 14 May 2020 09:55:49 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Introduce
 bpf_sk_{,ancestor_}cgroup_id helpers
Message-ID: <20200514165549.GA22366@rdna-mbp>
References: <cover.1589405669.git.rdna@fb.com>
 <c65795a13e69b7e4aa61a8e37aa340f2484f6c8a.1589405669.git.rdna@fb.com>
 <f885aa42-eb76-415a-7fe3-95ad9c4f38c8@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f885aa42-eb76-415a-7fe3-95ad9c4f38c8@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BY3PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:254::35) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:2555) by BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.11 via Frontend Transport; Thu, 14 May 2020 16:55:50 +0000
X-Originating-IP: [2620:10d:c090:400::5:2555]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8bce1d8-0a0f-4cd8-996c-08d7f827a865
X-MS-TrafficTypeDiagnostic: BYAPR15MB2503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB25038C068E570233DF772405A8BC0@BYAPR15MB2503.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7oJqIL2KXX9L6M8/eUtns/dq1fN0xmkCzL1mqEOWcDZAwV4hPX1iDkM76+QXbnxbOPB4+QVFlczbxCFprgaHtfZ1dC600o/6X0kUW8VJV6Tf4MLfpwOFLHeeYuPsgooQ859pxcF4/K55L7ZpjfHRtyyS56ro4lmcsO4O2+vhDnGzrqCSS1/IHMERC8OKQhJD1EVVLX8UnXTGM/YDR/l8d8rB9QCSFgKE7G1gac7m2CeWXoRk4qGBrvPRZLbFbnfZYceJqlo4knOKdRqaiuOXwvG2MyyHNJihSX02mJaq432P1WP/Lp3UbEYJgZPDSPm7GcG7/PLBaJX0w9snYXL71MfsDZVY1KdBq9gjkaeN8fQYLssYNF8HSkpgpQxSU05K8VCMDvcWwFP4KdQRmyDVj4PUNCG3xssfcF5XM2EGDsd3LuVYnQhsXFYpOJrgFllWkPCmzFXBO0iN7JSi85Zb57GJ14ncbE+llI12WhYXa2083hopgGktwDeV/NBpicZ/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(4326008)(8676002)(66946007)(6862004)(66476007)(66556008)(186003)(52116002)(53546011)(16526019)(6496006)(1076003)(5660300002)(2906002)(9686003)(6486002)(33656002)(8936002)(33716001)(478600001)(316002)(6636002)(86362001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: yLLAsyQjhTKwEupiYd0VQALwQthfDoeWcShlegwr8E4h40/lybvArDl7unmfGciKhX9f5K+CP2W6ppNmf02nOEKPh4ru7vQhwSWT9XGqi9BMzHFc7sUnbrgOL1vpj7w7ncat1eikopC/JuMI7ejZ4DQ8UzNwljI3HEjH8FH+iscwI9SmRRFpAS+lY0hZgpo9bycI1lKzC1RTi5940ldsTrOCoPHe1vgzDoMdzZCBgrE+Lqhge6+Ow/o4dtIvmfydI29PHwS/KmbqLnPvd8lcJCmRzt83EPXDFiT4XxifbsQYg392hzdd+qoLo6Irz3AsOpptGrQtQuk+k3BxBWRM19wLYVTwecHqTFoA5mOyXYLnzsYykiGjtk9MhJ6pp+g/F5rrkGan+h/rb+eSIhoCeJjwOVBGAtoRA62Z/rDPBN5kxxPbt40AE8EgpyICHk2HSEEGjpgj4hEjyW1/FkG+1VjV8LLZ+WTWNxCZj0sdEWvZiRIEstPhx2LaPqF94z0oe/ywWXYX3cFtpz0RqrpCiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bce1d8-0a0f-4cd8-996c-08d7f827a865
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 16:55:51.1586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGBHSIm2/oLYRCgWnYc5u/xfLSddpd/EkqMcI/FCn/uDNKygtxmLiLYnXUshyrv9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 mlxlogscore=881 adultscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 cotscore=-2147483648 spamscore=0 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140150
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 08:16 -0700]:
> On 5/13/20 2:38 PM, Andrey Ignatov wrote:

> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index bfb31c1be219..e3cbc2790cdf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -3121,6 +3121,37 @@ union bpf_attr {
> >    * 		0 on success, or a negative error in case of failure:
> >    *
> >    *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
> > + *
> > + * u64 bpf_sk_cgroup_id(struct bpf_sock *sk)
> > + *	Description
> > + *		Return the cgroup v2 id of the socket *sk*.
> > + *
> > + *		*sk* must be a non-**NULL** pointer that was returned from
> > + *		**bpf_sk_lookup_xxx**\ (). The format of returned id is same
> 
> It should also include bpf_skc_lookup_tcp(), right?

From what I see it should not.

cgroup id is available from sk->sk_cgrp_data that is a field of `struct
sock', i.e. `struct sock_common' doesn't have this field.

bpf_skc_lookup_tcp() returns RET_PTR_TO_SOCK_COMMON_OR_NULL and it can
be for example `struct request_sock` that has only `struct sock_common`
member, i.e. it doesn't have cgroup id.

-- 
Andrey Ignatov
