Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF2D1FFACB
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 20:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgFRSKC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 14:10:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16680 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726882AbgFRSJ6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 14:09:58 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05II9jAZ016485;
        Thu, 18 Jun 2020 11:09:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=9d2WvH8g3er4rw9/oAn/34oQMUGDK9xe00I2HZrN/sE=;
 b=lMSqT1iT45XcykN3T1loYaNimzu1R/Ua4NbeyqsYWdAiEMnJJIJAF5Ps+GYCleMa8hw0
 sgj2RrBK3+NxaYc86j1uCJyYcQanKAgKnuC1/g/+WXz3TAgI0s80j6qPrbzNvdt4lDRi
 ynPXZRpqVOF/9PxTOQ8PceAJ67DtUXUnGUE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31q644nqy7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 11:09:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 11:09:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+ezm8jaEsGa3bbhvsKTFktHAnZBZ1HXdHdPVOb57NPE+bFaKvnid0po/uDcdCc6JrgIz5Yymq5nYvAJnjQSElLAaWuNN2mQ5eg8UABbxqnFp/441EQCFo0lUKrD2z53jZf53Y/0YYD5ZSjEdkI5dqn8XsBcqvdgycFO3Ovc586vsquaKYC2N3lzbwMUOGcmVkJQZlin5omOgcrdxm/V452Ak5INltu/ZBoJlyvarZmx9tAggfOsozLov/2deg1ojt/J2wJ69h8Po9qWTomSp0a30XPkE06AT5gKZVfANiukrAf20mF8Am8KcVRXRW7DN89Gl/QUV74ciXD9UhJWWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d2WvH8g3er4rw9/oAn/34oQMUGDK9xe00I2HZrN/sE=;
 b=M1ldWrz2s1lsHZi6tiheABVtROFerh6LWuMwpTJmiFv+aZ6rJSA+LQNyST7KnfdzQeNWuQ5wHnl1H10JxGg6yd2beZ969/bvnM/9/iz50XoH8fFiDwbyAsGqgmqrbmuMo6POV1MniZK1KusmxFCsaQ8+eD4qEYtai+7YmuTUZCEhcEYGlnTIMMSoYaRpbhygZw7reFN7UwcrLhkpH1dsz3iOPt7TwrSp0cLQbSdXmqQ2nxbi4xlejjmKjhylEIYj5F9UzjtHzk7DcdYyXlBgr0tWFcNiTJBVGYXX8XD2IXmz0FGuQtY3+LbCrDw6wJPfj62QUsrUrX0EgojiLSJ0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d2WvH8g3er4rw9/oAn/34oQMUGDK9xe00I2HZrN/sE=;
 b=Fbxc7aCtUL9RMy6O6H505v8KvuUxAc9JWHXGBlNb0n0mPGruk+yntC5HXRNZRFL79mELvo2dJK5/OwP1VdSgO1ar7zWzP1N1XJjzg9qiSGjMwUHa/duWUuCPUR9sYAPsYW0HZtiAe+XrmEmtn/RKUWxc+9a3xCrof3Srb7bWH20=
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3618.namprd15.prod.outlook.com (2603:10b6:a03:1b0::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 18:09:22 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:09:22 +0000
Date:   Thu, 18 Jun 2020 11:09:20 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 01/13] bpf: add bpf_seq_afinfo in tcp_iter_state
Message-ID: <20200618180915.a6gkehjt5jlaa3bb@kafai-mbp.dhcp.thefacebook.com>
References: <20200617211536.1854348-1-yhs@fb.com>
 <20200617211537.1855673-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617211537.1855673-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::49) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d71) by BYAPR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:c0::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.10 via Frontend Transport; Thu, 18 Jun 2020 18:09:21 +0000
X-Originating-IP: [2620:10d:c090:400::5:d71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3056a01-1ac1-4646-a18d-08d813b2b9d1
X-MS-TrafficTypeDiagnostic: BY5PR15MB3618:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB3618921DA2916EE28EFED738D59B0@BY5PR15MB3618.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMuWd+HrlFG6w39clyFrWX+rlX4JYCM0OFHyk+vtDgItFnM7xjj+UDA7F918gSVcyovYDqToWu+IBOwSV8P6Bim6QIHF9VubtWy4D/FxVjLYfw4OiDD0CX4BIrGjembGjNRCmoMmwoLEZxebUufq0ZXVqw+lN152PhwoQOg/Onv95josUD7vXTWmXLT3UkpmQAkx3lLBLgGqH0CpBGx6wfr1WCl5sPuuY4ubbPVJ1QAH1pa3uZHlx6Ja0tckNYVnjA9O/ydSib+khndhkyacEudNdl3BoQzDKhnlxR5IhubcMNolH3NgpLKUVe1ZMTy1UbvHAxBxuo6pNjkTrBwM9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(186003)(8936002)(5660300002)(86362001)(4744005)(2906002)(4326008)(6506007)(6636002)(7696005)(8676002)(52116002)(16526019)(6862004)(1076003)(478600001)(9686003)(66946007)(66476007)(66556008)(54906003)(55016002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: E9vK7mSb0gQtw2VDT3tm56Uesq8PCDerV/3cAzMrg0xUdDPo4yvAHPe7cz4VW3oi+WEv8L90dGwf9sSUN/uIQr7xT13fNL+lRdwAf25o8jCdDYGNHDQ4yc0nbET0HrIbTg/9q/CjM/1snHMWS27sv24KWiOiT1aoRmJLuLC/O2TUxf5ePltikS4ZJ67Vw5L/32erjKniXAxChB+RJNhl3vAsbOzjPCzz0MexyEsp1khB3gdCU5OZPHIpfnmvZjbi42RlIqgt0/ouvz9R8ossSwemQqQZ24SMRafdBCKkDDrqYPa94mhBGUo2MHQoRZa8ErJ87j3yc/iDUlxSBYisKUQLt1nyHW2AAkcGHFjuIUSEq3mMjoCBQFGOj8GbGZbb7ZChYLc7jIk/7RYlfeqrVGUBHqEVZCe6KojyL6FBkjmYH7L044EHidjDCEfKH0Ry7N4hj7J6LgjJryHb75OMhA+Cm/rZbcWZbbOByt4avLXE7H3kfn3xFICBXC8QryAxwOAlOMkpePkX4efizstCvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c3056a01-1ac1-4646-a18d-08d813b2b9d1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:09:21.8083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j43B8t+YbTnNWNuNKmytc5wTqDguOnWObM3Pzt4Mi5eIPCVlXCOpGokWgYH9SvNZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3618
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=816 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0
 cotscore=-2147483648 suspectscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180139
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 02:15:37PM -0700, Yonghong Song wrote:
> A new field bpf_seq_afinfo is added to tcp_iter_state
> to provide bpf tcp iterator afinfo. There are two
> reasons on why we did this.
> 
> First, the current way to get afinfo from PDE_DATA
> does not work for bpf iterator as its seq_file
> inode does not conform to /proc/net/{tcp,tcp6}
> inode structures. More specifically, anonymous
> bpf iterator will use an anonymous inode which
> is shared in the system and we cannot change inode
> private data structure at all.
> 
> Second, bpf iterator for tcp/tcp6 wants to
> traverse all tcp and tcp6 sockets in one pass
> and bpf program can control whether they want
> to skip one sk_family or not. Having a different
> afinfo with family AF_UNSPEC make it easier
> to understand in the code.
Acked-by: Martin KaFai Lau <kafai@fb.com>
