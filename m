Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486681D38BC
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 20:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgENSB3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 14:01:29 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28062 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgENSB3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 14:01:29 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EHxRtc009294;
        Thu, 14 May 2020 11:01:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=KSpUnFyIm+uoWd0OGaetGp0KLJ4/MbPwT21KKVdDCO0=;
 b=HgEQG3bmI2YMF0mKT19B0qAD6f5N3/FuWkOFPZTgcPUSjRDH5rkFXDwlkF3RWZSUXdXJ
 L9AaUCzf0zspinA82QM89SQfBAZ0HqOE6vxkpizmqNEptM+FmaN2OslPSM8u6YTKLNHQ
 Ql2AwAGCa53ed8D21ZgoyfDY1KCtrHQ0MrE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3100x74vws-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 11:01:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 11:01:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dcVfox8pycVKcy6jRb5p9Oq1apjK6DtW77yDLxGOQ4DmSdoeXAEmDuSRFnk3gq+iZPO7X8QuXNpujMantDIRYMy9RCj/B1JDtxx1ZwziYTK8IbjcP7SqD8AbL38wWz28uYl2mxZcrU6JI4UHVkLqrqQZWUBdqV0qwBmwEBSkb4THsvrOajrfq6K6sHFLszWzoAK96BPxhF3k63FuIIpgsHM/yES9wfmvpnAAgYpixNjjtXyZJCTWrUOyQCGLwm6DFT1YZFEzGh9NCfvK45aoEBpPFHiXJn/HDa4+rGkAacTcNAJkAa21oWVW0L79lhW35BP7SnJxwP23bd2HQW7TNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSpUnFyIm+uoWd0OGaetGp0KLJ4/MbPwT21KKVdDCO0=;
 b=BGPkZF4tyIsSU0IleJ5ehbTqstkmQVhLtX5TseEHWxhqT4KPY2qoPrtYYmb5jnSGkJtVzK5bISed8+lXeDrE2ES4dwLA7CNbSnyCNrrXF4V37gPDX4x6/1bLQFU4qzHA339R7F3T643ij6umeAdelgZIDFvvesJt99a7oizXi8Svc3D8nEZA6cKxqgBGeOuiZ5bjTd2ep33OphamXavpY3N+86MDUDnSKzl7Vz6S9t4metm8sOdkBhZefoFD03hQKdOYTI+asiKBsRJPor8/vTLTtTJnFLs+PmZHcsYuKFzVYVvGn5bLD/bV+84x07Nxl6cmvgBRXcvv3inW+uuyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KSpUnFyIm+uoWd0OGaetGp0KLJ4/MbPwT21KKVdDCO0=;
 b=VEPT/l10g/BcBgMpBgXsXBDS28v3PdZKboBl3Lpex6KpSmVQYoNreHot5A/Kob8pbLA8N2LGaTnklxtHwCsl4tN38OZIpXOeVIr5C0ZpeHG+Nh4z71lsY54eeFpoCfvzG03tVQuEiIZTXoHR4Z6XKicnQdjj6VLQf8VVkoGN6VE=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2296.namprd15.prod.outlook.com (2603:10b6:a02:8b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Thu, 14 May
 2020 18:01:11 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 18:01:11 +0000
Date:   Thu, 14 May 2020 11:01:10 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Introduce
 bpf_sk_{,ancestor_}cgroup_id helpers
Message-ID: <20200514180110.GD22366@rdna-mbp>
References: <cover.1589405669.git.rdna@fb.com>
 <c65795a13e69b7e4aa61a8e37aa340f2484f6c8a.1589405669.git.rdna@fb.com>
 <f885aa42-eb76-415a-7fe3-95ad9c4f38c8@fb.com>
 <20200514165549.GA22366@rdna-mbp>
 <6cc5f0a5-b6af-e74f-2266-d5c85a0205f7@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6cc5f0a5-b6af-e74f-2266-d5c85a0205f7@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:2555) by BY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:a03:1d0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 18:01:11 +0000
X-Originating-IP: [2620:10d:c090:400::5:2555]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70ac9840-ec59-4164-d202-08d7f830c935
X-MS-TrafficTypeDiagnostic: BYAPR15MB2296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB229646A0DAB5A0DA30B6E115A8BC0@BYAPR15MB2296.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hIl1o9XQ/J2vRezGL00EyKMC3OA+ctWX8TplyOFEVbNyHGRXcZusSZGd7tDuUN7XO5JCXu8VurP8KHsoXvK2/66W9VZ5T70bvmOlDdYR6blU/LBKIiRhbGexcAABw/A9xWCwvGsas19ul/kp7EtzsuZvMoozaxbTHyElFNBtk9yUzyx205+t1rYffRM251M+lIKbZdIcTtE4nCBwRdwTL3oe86vSYu/GaUHYfZ5sXbWI5MW7vPft7ABxmJbnEUTG97rkh7VWG6Zidnuu16Ed2gw5+UodL2KZ+On779yUxUwfLxOmUqELbIjw5KdPIrjXicWFDFP0rB7Ik9UwK0vB8F315sKgJIdP/qOBy78eaHjO3on90eByIiFlTJJ/CWbSftw5D30ekD2xLXjdl8HY6jtGqWdqWhW/U6TLGzqQDSIJBPUSNMb5cvcxvTKXYK2WkIYR5kkh7CzJv27M0EC3xA5c51NxLar/B0Go9an8syXyc+Io+yP07yQ55uAv9gAS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(6862004)(53546011)(6486002)(2906002)(478600001)(86362001)(52116002)(33716001)(6496006)(66476007)(66556008)(4326008)(1076003)(5660300002)(9686003)(33656002)(8676002)(16526019)(186003)(66946007)(316002)(8936002)(6636002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WNmIk/Kk8cLa5dUu7FbGsqaBID3ZsQEjA+aczwah9Gegyr8XEksxbCvSGvvkU1Hi6NsQBMu5p4+iDONX8uDLROhsVymkoeg0q6HgAsEm+/C1XUdNiiag4lT2gYaijpDLh79xt7m5GygpLfGThuoO9OeTg1hjO+hLAnzg/v2YZOf8LCQHgP8mOmEt31KmViP6jHBVgGGgPWmbpkPNK0SE9NP6VeEULrWeQwW8MHsGa2cvw1/rcPfOoSjn5/9UJFsctS3zR51mI2rMFsg3zKI45cv3z70EjeZLGf6n2EmFHsOjDIDt0PyHozkCSGG6b4YQpzVy73tQJg5jIEWZKdbl5SqOpQg5yuTONIXYxtpk954r+2ECieAXO+SZNHV0e5whQB/GIysLfaTCsWWBnh5gjmx8OCzISy0z1k7mcyGrmGunodJDn8oDxe4drLlRFvwNEnbkuIXoVPmRkI1FRI2/GpcYrjn8aQO0+kmm+5WWFtNgp99FZlXVlXKhkBg266vso7CSXpc9dLrcYG7yyaglVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ac9840-ec59-4164-d202-08d7f830c935
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 18:01:11.6219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnCgtalBg7HwbHOUPmSbbJZFZzowS9OWdS9U2FBh+F2j8jSDPOq0eg/8YzEN+s8c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2296
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_06:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 lowpriorityscore=0 spamscore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 priorityscore=1501 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 suspectscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140160
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 10:24 -0700]:
> 
> 
> On 5/14/20 9:55 AM, Andrey Ignatov wrote:
> > Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 08:16 -0700]:
> > > On 5/13/20 2:38 PM, Andrey Ignatov wrote:
> > 
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index bfb31c1be219..e3cbc2790cdf 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -3121,6 +3121,37 @@ union bpf_attr {
> > > >     * 		0 on success, or a negative error in case of failure:
> > > >     *
> > > >     *		**-EOVERFLOW** if an overflow happened: The same object will be tried again.
> > > > + *
> > > > + * u64 bpf_sk_cgroup_id(struct bpf_sock *sk)
> > > > + *	Description
> > > > + *		Return the cgroup v2 id of the socket *sk*.
> > > > + *
> > > > + *		*sk* must be a non-**NULL** pointer that was returned from
> > > > + *		**bpf_sk_lookup_xxx**\ (). The format of returned id is same
> > > 
> > > It should also include bpf_skc_lookup_tcp(), right?
> > 
> >  From what I see it should not.
> > 
> > cgroup id is available from sk->sk_cgrp_data that is a field of `struct
> > sock', i.e. `struct sock_common' doesn't have this field.
> > 
> > bpf_skc_lookup_tcp() returns RET_PTR_TO_SOCK_COMMON_OR_NULL and it can
> > be for example `struct request_sock` that has only `struct sock_common`
> > member, i.e. it doesn't have cgroup id.
> 
> So you can do bpf_skc_lookup_tcp() and then do tcp_sock() to get a full
> socket which will have cgroup_id. I think maybe this is the reason you
> added bpf_skc_lookup_tcp() in patch #1, right?
> 
> If this is the case, maybe rewording a little bit for the description
> to include bpf_skc_lookup_tcp() + bpf_tcp_sock() as another input
> to bpf_sk_cgroup_id()?

Yeah, this bpf_skc_lookup_tcp() + bpf_tcp_sock() combination should also
return a full socket that can be used with the helper.

bpf_sk_fullsock() is one more way to get it.

I'm not sure it's worth listing all possible ways to get full socket
since it's 1) easy to miss something; 2) easy to forget to update this
list if a new way to get full socket is being added.

What about rephrasing to highlight that it has to be full socket and
**bpf_sk_lookup_xxx**\ () is an example of getting it?

For example:

	*sk* must be a non-**NULL** pointer to full socket, e.g. one
	returned from **bpf_sk_lookup_xxx**\ () or
	**bpf_sk_fullsock**\ ().

Will it be better?

-- 
Andrey Ignatov
