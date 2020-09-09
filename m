Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600A526325C
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 18:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgIIQlP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 12:41:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36894 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730463AbgIIQlF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 12:41:05 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089GeieK021423;
        Wed, 9 Sep 2020 09:40:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=AQw7uURvMP77Km/HluD3CuMBaq3XogC/rzBAlBR/IUQ=;
 b=eqBt7O857/CXUbQhQmTioRsYlqtfmRHHv327PTq8mmO69fkbUZgLyEF+Emds/vhmlLlx
 eDUNZwMx2x86KtMm3jW83SGOaxw29OxKwDYIzkj4MciNg+xA6185mxHLXibQlKckt3LP
 vTjfQMaifMOC5UpPwBO71HwU7LBdXtUCtuc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33ct5u0af8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 09 Sep 2020 09:40:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 9 Sep 2020 09:40:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8WC1KsQxuKeyZQJcN8wxRTL/eEhYaBZKjt9MAajeueo0x8F3bwLsKCsCashgCd0SStqMSHD0tZc+SCb/FBt+fiuDMsUe53HLCwYtTljcvzJbPx9SuJjNsPKcTyGyP9pJoJ1Xz+Np69Q6T+TU4UUosUqq7p2nW8/fap6tpeAmpwUgg5vPOmYMMfqvRaFwQWFIHYecQZkWZeIqvz3eIcjvMhNXKollUMsbvZqRJn5AMs36EpLPtevBRXqgNGmtgcYZE/XaY+n4Sre7lGMW2QPLckQF1swoTQjFeOLL082yYEhFdoO+pn7gwRmttwIwnuyrKbBbZ8XKLPOjb801/C5Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQw7uURvMP77Km/HluD3CuMBaq3XogC/rzBAlBR/IUQ=;
 b=Bt6Ll0Bu2kE8NJY/s+boXhhhWhsYxo21mqTosJFaMk5+LMXZViT8eL2w0Ih0B3Cmx+GnGMxhN4DjYFEGP+wng9m3Kbspg68VyY+7qLGREV8mner9AcTv9hoq/gdeTVNJBxFv5VZIfgGx4P0zg4zMn4WoJOluYm7vbJXKA9+vy/Mf6SxpzPLSXsDRz46T7r/sD19Kxg2zOmT78R7lNjSUBsX1B+geHapH9810i5lZ+qiWFYyR50bCI0Jw57szYWQBvR8z4YmMzTM8D5LwvF2CdgnJEs9ExYgcSDVlB7RA3RubHcRdjPG5iZj3zBVLxN8sy7uEEzUIkCB+nTxJCdW8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQw7uURvMP77Km/HluD3CuMBaq3XogC/rzBAlBR/IUQ=;
 b=dSfzIw1UeYLRYqjBRYsJ88obWnuY+T3oQ92H/2uthUSywCartBJYxZFy447pE2kbYYCHzsRzTu8ZA26WWwuh0ShrQBvyNz91q6MRHBDLk27v21iaUy1rYHrzpJFNzHLgwKn3jbKGr29Kg61pg8BQRfKAR0floid40pL8lqztx/o=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2821.namprd15.prod.outlook.com (2603:10b6:a03:15d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Wed, 9 Sep
 2020 16:40:14 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:40:14 +0000
Date:   Wed, 9 Sep 2020 09:40:02 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 1/6] bpf: Allow passing BTF pointers as
 PTR_TO_SOCKET
Message-ID: <20200909164002.6icvwe7ex67cggrr@kafai-mbp.dhcp.thefacebook.com>
References: <20200904095904.612390-1-lmb@cloudflare.com>
 <20200904095904.612390-2-lmb@cloudflare.com>
 <20200906224008.fph4frjkkegs6w3b@kafai-mbp.dhcp.thefacebook.com>
 <CACAyw9-ftMBnoqOt_0dhir+Y=2EW4iLsh=LYSH78hEF=STA1iw@mail.gmail.com>
 <20200908195212.ekr3jn6ejnowhlz3@kafai-mbp>
 <CACAyw9-HZ0AzVYOg_2=PF9Y=xNwxNWUBk4VonxQLgRE6TmoZdQ@mail.gmail.com>
 <CACAyw99BGEQORogx2+KvpG=qVcyVEn+UwBBAYV3KV6+BssYibQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw99BGEQORogx2+KvpG=qVcyVEn+UwBBAYV3KV6+BssYibQ@mail.gmail.com>
X-ClientProxiedBy: CO2PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:102:1::51) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:cc17) by CO2PR04CA0083.namprd04.prod.outlook.com (2603:10b6:102:1::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 16:40:13 +0000
X-Originating-IP: [2620:10d:c090:400::5:cc17]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2da10eb1-9552-45d6-cc30-08d854df06e3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB28216C61A860A2DCF989549FD5260@BYAPR15MB2821.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bctTECKeeGKAOboXsFFxp/vGhGoQvXnkD/REIQ2Bk+4m+00WwaVRRpflfoGCnN5nQIZWzdiTP2+sDIRcuvCKfqjw4XST8Gitcl2W2TknfGJm8NQd4dhPkP76foxu8EZy26jz4L973UCVQOXqcMlkQQiLQnABegREzY/1WWLquymIsc2BGQ2fbR6QruwBNHLYV2L6272EtxTiZR7cvZwSzzielYJ4Untj6Nmjj3+2qLna0ysOkUpHM1vWeUxXH939g+lPJUxRz9H2AKML/WxuyVtoAbVqXvhRJFid5GjEcNptWUrvwmRSkLQIb7gsiIz+KoxPoTS/IoeSZhnGULVubA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(39860400002)(346002)(396003)(6506007)(7696005)(66476007)(4744005)(478600001)(1076003)(86362001)(66946007)(5660300002)(66556008)(6666004)(2906002)(55016002)(186003)(316002)(4326008)(16526019)(52116002)(6916009)(8936002)(8676002)(54906003)(9686003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zCIYet6Teuh93dnYqItYl9tMbvwmpkoqBdVbbSkyFeBZMirbbGeVho2ruqnvduxIPDN39bp27sBNc0SeryhAf7r7NomJqsLJPMoD+wYhqMlvdSn2sHoWcz+spbai2RVbuv8QjFY5mSuy4wf3pvBfPn8ZxM6zPPQ3ZdrsKxEs0oGLybebmdcHXrLcskckj724nX0uWxXUtdNPlGEuHHYAKWdqjxv/MiWPyv7Y7VaOAR4SRxm8eTIfza3omqdwHzGCz3959sJb9fBAK+daFInLpnhj6ixq5ITmsaDP5FVXabyzfUWvMecXha4rd+EA4Imgj0dvIhLuRG8daUtC/OfIIsBZqwlig6WqBG4/6u83v5bW0eo+uhQ7xkTfncUvmh+CIwL0YSvoD+Q+Rvl3jHL+DP98xBUZkjM6DhactlwQm72wDC5+C02bNZETdsyIbcPtRvc92XIV/A6I5ZRXV3Aky1fuqXiKUp8y6jRd052e7LL29A1vt1Cs3hZZ8ldnR4gUP8vAbP9uWhhkcdNzB4IN265YgJUHtmalN7f6OWeeKJrM108UwSMz3tn+63NJ6kJvJRj4NnZY5pWueF7a4igFtgNIfm3ukTz3zIYvoEgg2jSwEoXrpKCtGqBPJlMRgATvscPC+rGyyXB2LUByscUImSPtFEINc+F0QxYYyyV8Nn0=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da10eb1-9552-45d6-cc30-08d854df06e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:40:14.5196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfC6EMj1UE1meErF9H+JQSJ06xcLgwyMm5T1bpC+6ZPCBAdiQwL8w/l7YQ39PH+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2821
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_12:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=1
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 bulkscore=0 mlxlogscore=811 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009090149
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 09, 2020 at 04:42:57PM +0100, Lorenz Bauer wrote:
> On Wed, 9 Sep 2020 at 10:16, Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > On Tue, 8 Sep 2020 at 20:52, Martin KaFai Lau <kafai@fb.com> wrote:
> 
> [...]
> 
> > > Not all existing PTR_TO_SOCK_COMMON takes a reference also.
> > > Does it mean all these existing cases are broken?
> > > For example, bpf_sk_release(__sk_buff->sk) is allowed now?
> >
> > I'll look into this. It's very possible I got the refcounting logic
> > wrong, again.
> 
> bpf_sk_release(__sk_buff->sk) is fine, and there is a test from Martin
> in verifier/sock.c that exercises this. The case I was worried about
> can't happen since release_reference_state returns EINVAL if it can't
> find a reference for the given ref_obj_id. Since we never allocate a
> reference with id 0 this ends up as the same thing, just less explicit
> than checking for id == 0.
Thanks for checking!
