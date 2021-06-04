Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B0139B291
	for <lists+bpf@lfdr.de>; Fri,  4 Jun 2021 08:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFDG3n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 02:29:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57934 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229835AbhFDG3m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Jun 2021 02:29:42 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1546OafD001561;
        Thu, 3 Jun 2021 23:27:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=facebook;
 bh=FXzqSL9G26Q0VSVyzh7fqtrWlQYHaSkBomk2G29ZOc0=;
 b=eQTIk1UU0S71F2ojQPA4hMOOHSlmDORY6kWCXy85R3lADlp+TeX61H0jonHWZplzcTr1
 lJtXP3NGZW2aFWOo7XFsA34zxBlnWuKRqgLLYpkCp/AUWUxn3opXE8wNkOjk2w8BrYmv
 uFWiQTHaQvo5hg4rrkxfWEmDZSPGA9Xo/j8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 38xj5kh49b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Jun 2021 23:27:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 23:27:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJKqjBAoYYzyKppE/s9kdu/AzGR2B9pGF0M+LuGltDdAZ0X0Lx10RPDvV/qyZwtn1AT9f5y64FJ6bglx7vCSBcnnWK/smQYVh+tAs2rZ7hMwc3Jm+nNp9R60444RBM6x2reVra35HNReusrLQq+1se8V8Z5CgF6ELg2OSoJUTQdTx4oFIACCszBxc1HfvsT4rJDY85db6fQVWE/YUEMw7aHtPgsLtFaxyArc66shneLSnzOuo++FmNh7e7WFT5ZBrQ5rssH06VRuLBYK3Li7zllIWn1ofypAhx6Yed9KADKF3knV51EOffLMh+Dg0ztrU7XYXevEywG9DgXk8uNWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyr7/8+1XR1HTwmlXorcTzZNPNJ5vh/M2HGThFXbBbM=;
 b=dZnmFxJwoHDUaP9DOqio5nEG0M8MiMXVorocIx1xOPANJDyLChd8qdErnkx13muvNwJSDQicFRgsP03FRyS79XOQJUmXt8k+8zljT4a65FOW6QuQRPRzTufvS778XIBQl2LHAENRXd++/xht/b2w5NhV0esAi3PovMxXntDEJbaueMECoHpolq11d4N7Ay+8cE5Rl+OknfQoMCm3hWh6qoFQOzavvsD75IkNdBZaC95dOUURHdxIdNmTIHrnXE3Q4FqzQ0v83KijDU6WBN/ERoOkOf2pxJdB5FODr9A+hOP71cLtT6nBfGwl+JVFkgDS7VRT2h1yJiYo3GOQ4Wuo6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: rub.de; dkim=none (message not signed)
 header.d=none;rub.de; dmarc=none action=none header.from=fb.com;
Received: from CH2PR15MB3573.namprd15.prod.outlook.com (2603:10b6:610:e::28)
 by CH2PR15MB3592.namprd15.prod.outlook.com (2603:10b6:610:6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Fri, 4 Jun
 2021 06:27:47 +0000
Received: from CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::3577:a44a:dfd:fe49]) by CH2PR15MB3573.namprd15.prod.outlook.com
 ([fe80::3577:a44a:dfd:fe49%7]) with mapi id 15.20.4173.030; Fri, 4 Jun 2021
 06:27:47 +0000
Date:   Thu, 3 Jun 2021 23:27:44 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Benedict Schlueter <Benedict.Schlueter@rub.de>
CC:     <bpf@vger.kernel.org>, <benedict.schlueter@ruhr-uni-bochum.de>
Subject: Re: fix u32 printf specifier
Message-ID: <20210604062744.rivtnhbdopb6jtzt@kafai-mbp>
References: <6662597c-13a2-5c6e-df6c-31d18ed34bfd@rub.de>
 <20210602174127.55ny556mki3uv4tx@kafai-mbp>
 <2d11fecc-4999-73d7-82e7-3a2c9d9826f3@rub.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d11fecc-4999-73d7-82e7-3a2c9d9826f3@rub.de>
X-Originating-IP: [2620:10d:c090:400::5:a867]
X-ClientProxiedBy: BY5PR16CA0032.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::45) To CH2PR15MB3573.namprd15.prod.outlook.com
 (2603:10b6:610:e::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:a867) by BY5PR16CA0032.namprd16.prod.outlook.com (2603:10b6:a03:1a0::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Fri, 4 Jun 2021 06:27:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6411fcd-a4a9-49dd-763a-08d92721de67
X-MS-TrafficTypeDiagnostic: CH2PR15MB3592:
X-Microsoft-Antispam-PRVS: <CH2PR15MB3592F0712AAEA71F0B9577EFD53B9@CH2PR15MB3592.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:348;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vK6rKD4d1CoEjG7cLda6z6QgHTqoFO6oRNLWdN4IyRh0lOHk3Ls0ZVnhoWr6H2tYnK8rgjjF2Vm1iYASZ+WvkBtOcsMn4L0Na5jwrktsWE8+fHoc6XJ9AKwPN1ysDo4ByfGRW8ctmUzww8q5skz8hXHC3Z3JnKRpzzl61Rccb2nNaJ3U/mBrlApRasIoyttxmqFWdHAXUI/sERZFmTP0urOZDtWlDeuauLQPf42DK1LQRuXi1GbH3ocAdTSIVhRUemZVS9wDYzXucrid8YDF+TIlQWbJQ+PW8mjlIwXiNVYXP1GdlTBNuUM7CaE/5LGpdAiCbBMzumoOpgAji2BtlovL90cTYVYTfUNBRlS4lIKFl2HTiSbwvzjSFnE0+6pQ+Y2aQPJY5RQAKphl/DmKOOZ8dcdBWCIfQJTbaZDgpbMjzSpIfWsg++k1RfGMbjM15n6EL/jsUH1AHvNYxXGZ3jzPwKrQdTX3PXLH3UcDXkcCZw/eLEm7p8eHMA4VTiguKI40EDcFQOC8HSmUS5Wmm+PtY5aifpwn5eUAU131CTLLqVrGYm1a1km7QkBtTkeO/8NuWDxZit8ThKIF7+Vr7dw35M9LYNsTl9yPmDPWF6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3573.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(38100700002)(4326008)(9686003)(83380400001)(16526019)(478600001)(186003)(55016002)(2906002)(316002)(8936002)(8676002)(53546011)(86362001)(66556008)(66476007)(66946007)(6916009)(1076003)(33716001)(52116002)(6496006)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?vwt2NhlT02giZoYBGfCMYO7Alz60oGaPiaqO38RgIM6zhD4sNf+nuHfJA8?=
 =?iso-8859-1?Q?JZZx5EOB4AyVYLBYgR6kmKsGOv/2xBR5WEprScaGfrIVR03fcLw5m3M7zc?=
 =?iso-8859-1?Q?XHPPiNFDgiU5v3BPf4BPCnMqWNirl9bUtDxPJF59DtjV7iGhlUJl0r3YZM?=
 =?iso-8859-1?Q?xtLdbm5Qgih+2F2Mdkl9FVBWB2VzMMVfXrpBR1XyQ1eLVOVxkUUv1ubV9O?=
 =?iso-8859-1?Q?XnDljJWNEPjkfZsxRGxTBP64fxXdV/xDFwm64haZatFHIX2d1nGc2z09ma?=
 =?iso-8859-1?Q?Epav59oTbyFafhKY1Z4p/3v6RGQuReAnvpl5NuIA3AICRxsPp5DhWXqn0i?=
 =?iso-8859-1?Q?hqISFV4nLp+asfgu2T5xzgAMEECI7ZEw9q3vJIQPjAZpmQE3oR6WuTK7wJ?=
 =?iso-8859-1?Q?fq2ywoYswHYjOorTe7gd6SO17lVkCUfdQYqcuzx0Xq5CaMr9RIpF9Y78mW?=
 =?iso-8859-1?Q?V9RihZJvxizeQt7nNf9gTL1+4T2RRg4A6kJShPm2SQbsQ6X9Fye6yvSbs9?=
 =?iso-8859-1?Q?dReGTtnEVaXA0LyqXQwo4Vn6TmwHi8jQzN5Y45tIOwy9JLAnZX+rAxdJfI?=
 =?iso-8859-1?Q?q3FimMLX1ARdKe1cnLhhgjQqazToO0I65JSETznK90zeMH2NJfCXrZM9QG?=
 =?iso-8859-1?Q?JcYC4zSgjz96lVaDrCMUl6w++gyQZaFQEWZBXWAETtmDbTbodpkSk6HCiM?=
 =?iso-8859-1?Q?IZyBJwMEGdWJaZMOKef2p5VxnLBHEvXoCIi8suYnVyiAJ42tyRm4fiQpS9?=
 =?iso-8859-1?Q?3nfwYpVhRRqH3LjOyy9Y5/0PnJHy8zJBGKf48DgI0ms5MU+G5Nsw9uCI7P?=
 =?iso-8859-1?Q?nCeJhzJS+f/J8ujO0w58EEEy9MkQfdlTCnInPHK6nn7yLEVxDFZcIUwy6V?=
 =?iso-8859-1?Q?MIjoMeFZd2ldfnIszwPoiDOXUjuxZF6ffkCEXCnaLrNKDjWYeyKXB2ZsHL?=
 =?iso-8859-1?Q?wVltD4s9+nNDWYHeyw4YdOVYnqKUQetBDtXtpk/3vAB8msENWQ7kll1r1/?=
 =?iso-8859-1?Q?Yswu9mUHrOpGzPUCHeA8AvF0lrvM09GR8g09kgDqunHiQS29is/Vu6DjSj?=
 =?iso-8859-1?Q?eT6P4uMTDF4YnyfQUxDeXAjEwM9/V1JFgRnT0gCE0Afs7tFEbtuc/tBOkr?=
 =?iso-8859-1?Q?o6XWRoCadNU2yN/NBeJld2XGTPHZC7bj4noC+Yi3/lubgrNmmieLxqhfj6?=
 =?iso-8859-1?Q?G4J9784BB6ITm89ylpuGG8qYSsGGqUFzgw7iubzIIiuG9A9JDlRXWqrw7u?=
 =?iso-8859-1?Q?YBkorU61/uJM6QDeagh4+VM8/iNm3fLI1VRWjqK8T9A0HtaggmkPIkIH0V?=
 =?iso-8859-1?Q?VQlKMX1aCDWNVnohL7Bzpy4sqyp9gTYAHnVl7ZOU/kTRTM/qI4NElU/M9r?=
 =?iso-8859-1?Q?qmCtGuYtIGFcQ6Gz1RHuH8rhMPJGnrLQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6411fcd-a4a9-49dd-763a-08d92721de67
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3573.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 06:27:46.9861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvqoJB7CDwZERdoS+w/gchkWm7vryFLAAofswQ/Rf/ft08kjQYyWSKZhvte3mAk5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3592
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: oJCvUY5BVppmaiZGQDRZtjvoOK-qOkkv
X-Proofpoint-ORIG-GUID: oJCvUY5BVppmaiZGQDRZtjvoOK-qOkkv
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-04_04:2021-06-04,2021-06-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040050
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 03, 2021 at 12:41:57AM +0200, Benedict Schlueter wrote:
> On 02/06/2021 19:41, Martin KaFai Lau wrote:
> 
> > On Wed, Jun 02, 2021 at 05:23:19PM +0200, Benedict Schlueter wrote:
> > > Hi,
> > > 
> > > I assume its clear what this patch does.
> > > 
> > > 
> > >  From 9618e4475b812651c3fe481af885757675fc4ae2 Mon Sep 17 00:00:00 2001
> > > From: Benedict Schlueter <benedict.schlueter@rub.de>
> > > Date: Wed, 2 Jun 2021 17:16:13 +0200
> > > Subject: use correct format string specifier for unsigned 32 Bit
> > >   bounds print statements
> > > 
> > > Signed-off-by: Benedict Schlueter <benedict.schlueter@rub.de>
> > > ---
> > >   kernel/bpf/verifier.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index 1de4b8c6ee42..e107996c7220 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -690,11 +690,11 @@ static void print_verifier_state(struct
> > > bpf_verifier_env *env,
> > >                           (int)(reg->s32_max_value));
> > >                   if (reg->u32_min_value != reg->umin_value &&
> > >                       reg->u32_min_value != U32_MIN)
> > > -                    verbose(env, ",u32_min_value=%d",
> > > +                    verbose(env, ",u32_min_value=%u",
> > >                           (int)(reg->u32_min_value));
> > "%u" and (int) cast don't make sense.
> Yep, changed to unsigned int for consistency with the other cases. Is this
> necessary? Since reg->u32_min_value is already a unsigned 32 bit number.
cast is unnecessary.

> > It needs a proper commit message to explain why the change is needed
> > and also a Fixes tag.  Please refer to Documentation/bpf/bpf_devel_QA.rst.
> 
> Sorry should have read this more carefully before. Everything should be
> included right now.
> 
> From fd076dc5f2bd5ec4e9cb49530e77cf2d3e4f42c2 Mon Sep 17 00:00:00 2001
> From: Benedict Schlueter <benedict.schlueter@rub.de>
> Date: Wed, 2 Jun 2021 21:42:39 +0200
> Subject: [PATCH bpf-next]
>  use correct format string specifier for unsigned 32 bounds
> 
> when printing an unsigned value, it should be a positive number
> 
> verifier log before the patch
> ([...],s32_max_value=-2,u32_min_value=-16,u32_max_value=-2)
> 
> verifier log after the patch
> ([...],s32_max_value=-2,u32_min_value=4294967280,u32_max_value=4294967294)
> 
> 
> fixes 3f50f132d840 (bpf: Verifier, do explicit ALU32 bounds tracking)
Fixes: 3f50f132d840 ("bpf: Verifier, do explicit ALU32 bounds tracking")

which can be obtained by:
git log -1 --format='Fixes: %h ("%s")' 3f50f132d840
