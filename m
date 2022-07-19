Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AECE57AA86
	for <lists+bpf@lfdr.de>; Wed, 20 Jul 2022 01:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiGSXkM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 19:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbiGSXkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 19:40:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1102718;
        Tue, 19 Jul 2022 16:40:10 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JI5Jsu007580;
        Tue, 19 Jul 2022 16:39:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=9kOqoYxm5N108Ztlz1Emp1slal5QrnOvD2BCVDmabo4=;
 b=H0vBmht3EN/NfOC5lRTNqXX+RT+EW9vXQCsBioNlAoE4Pc0ifwUQ4F5LqAd/ceWDEeyP
 cwpj7eox6k8HhrDdPVZLsKc7LCZoa8vy8/wIw5Q1B+ktgoAsM1/jFpQcCf8DRIMmNIdk
 1akzqWtagtxdTdh3oheC+cwFeYqVYepPZe4= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hd7exkhjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 16:39:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNmqAftSO6PSp1wMpgSdWnE+StGxvIqfOvlYEz/7CkMamjSs5m+iJeU+JvhRWj2/j3oaFBV7PiTKGps/1kA+cH/eIeZdkZD/OSHFVNbKhFP9+iJZHUIhb7nbcJ/vzDivvXhd4i4SO0t2D7RIcuAn/7X4zzJpscINKVptKP/rL6bTwR3PgvozUiE4cll6Orc5neUz5M4ybHAv/bt6uLQi9kPZj5cvDUSw8Zp4vGrDuUz3M3VcwQB3JTv2hi4sPCh+hlz6W9TyNJyrXdqU7xV3xJr7KOhtrywMq/Tiv0j0Ak3tioVQfdudXiZNofRP+1oqi5pc11eFw6bNN/3083DcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kOqoYxm5N108Ztlz1Emp1slal5QrnOvD2BCVDmabo4=;
 b=Jtgm/1VJXhS4KmChHbx4B3c0VYkKGZWJdA+BVRAaLt3lB9x2IjhmsF26kW4DS8z9RcLgD+7DoO8scJeSEYcqnzI0am3U9m+H/L7HnK4fv4Bw6IQaLQLyrHh9n+L4qgVTTYycznjLEvA2cYSSMOCnINjyfVVQ3+3+hN3sRmv7XReJwe/+GvbycaNa462aHINlFGpgqnTwmnuyqlOxZBxNbzFYgqffE7kN2GV78Vl84iKSxqhr08aijIuVzPQxuDq5aEsaZXTf13nLEdA4uMqkac0D/spOVCMRNUgz7poVmR5geH2UURIGB3M2gXy7dwWtQTMIecdnlCqSqj6tNZg1UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4472.namprd15.prod.outlook.com (2603:10b6:a03:375::17)
 by BYAPR15MB2824.namprd15.prod.outlook.com (2603:10b6:a03:158::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 23:39:28 +0000
Received: from SJ0PR15MB4472.namprd15.prod.outlook.com
 ([fe80::91e1:d581:e955:dd3a]) by SJ0PR15MB4472.namprd15.prod.outlook.com
 ([fe80::91e1:d581:e955:dd3a%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 23:39:28 +0000
Date:   Tue, 19 Jul 2022 16:39:27 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix sign expansion bug in
 btf_dump_get_enum_value()
Message-ID: <20220719233927.g5vvaeeklxp2mezz@kafai-mbp.dhcp.thefacebook.com>
References: <YtZ+LpgPADm7BeEd@kili>
 <20220719172640.pfbsfhdgmzn76kos@kafai-mbp.dhcp.thefacebook.com>
 <20220719183413.GG2338@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719183413.GG2338@kadam>
X-ClientProxiedBy: SJ0PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:a03:332::12) To SJ0PR15MB4472.namprd15.prod.outlook.com
 (2603:10b6:a03:375::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f6904f3-f9a3-440c-fc38-08da69dfebe3
X-MS-TrafficTypeDiagnostic: BYAPR15MB2824:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MM2q19kqQxdSGoRVq4iQ8TVHgdD9hEyCEJzayQCzbAka1/ttzYMYvzaWWfnHDJcsyBYzfjjCuztHi/VBAkswSvtcyhKWQSmXLxtwWA8Bkx9wYzzZ8cZZChWDnI6WQdqFlyPTTO4/HDyK90BuF34rKiKNW/wFTu2dAn9GoNBZ73XicVIFEtsEzR5wWAYlLAJSioc0Bap6BLnUGp55pppbjcIpM/SVVCCRCmz4SlR4mag0Es2yhDAy1/WAQgnPgSlNwR71CpArXC+NFJejkJUrABgBYf2F5srVQwGvePG34FbHiOcRC27LeORBhGIAH32CKO4BPQYdZrNfD1g4Yiuw6Hxva08mZydr0bz0LsVQME/QZMPyxk9vGImT4NMxFwF+m5eEz1qE5fTMhsV8J+1ENPSn1l3JcYCTpMVYD4raZCDq2kmbhOT0QNIueYogiv18x8/N8fRYeZq67612+ZbmqrAWKUbg3baYMc1f4pDywNoNwbGFbYAd/c+TPslZ2O7+m7zs5xlHH7bXGK2w5y8x5AD3JzrjOErr+bK5dkihsawyWtVHpkg216hgPxbRLtefANpnNh4f3UI8d9R5lQkLxjlR/uiOQfSlk0Z0GRrTn7b6hAD9xSkNlSkPESq49SpLA/Gt8H1oZfNKDk1j+mJb3phRLj7nBMZlnjYvN3btATyhMr8OtAxo2U1brU6nDZEsRCj77r3n+cu7lPppk2v+mPYSut9E8cW0NGuy+y3zgdv8JmmqMglFDVLN5MivdhXU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4472.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(136003)(346002)(39860400002)(4326008)(8676002)(7416002)(66946007)(38100700002)(66476007)(5660300002)(83380400001)(8936002)(86362001)(1076003)(52116002)(478600001)(66556008)(186003)(41300700001)(316002)(6486002)(6916009)(6512007)(9686003)(2906002)(6506007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uan2X+2D7mFM75ax4OeKi5V2wasIYUfmWtJtlqnnwmDL5943PCOubiVBFI3B?=
 =?us-ascii?Q?zT+xie+L6AuLC01GoGNN5J7I3IxuBNZTSsNUXcvJWujNrEIegt4sT0TQDKyb?=
 =?us-ascii?Q?5uGXfoFMTQeJuUABnpKxkAPdt+swV5dGjKnVy6ndEG3yEvRnJnUuEnzHl0Pt?=
 =?us-ascii?Q?lm7TUOuI08T/+L9O58eyTgwGugtvtIixEynouEpb4pVCKXjS2zUAi4XnAXyo?=
 =?us-ascii?Q?WLZHtkDF1TygOklxx1npUye6AXEX3BNjZaZkSRDRr6Qxa/FxwT+CxvAXb26r?=
 =?us-ascii?Q?9W1lL2X4O7LvTRRq2LWj3KHiu7MapVltLJ20Tcc/4+Y5x2bIOyXkkbSbRBNs?=
 =?us-ascii?Q?kfoQLWltL+gFexkq3yeKA0q+ym66jYRL9v2CcSY/mF9ZJP9sGQbWuKmErf5c?=
 =?us-ascii?Q?AtdIAORqT8KVyXGDHQqziLfwNoHm3ehYKUUR/hrDcSM8xbFUT7bWqr5i6tGA?=
 =?us-ascii?Q?9MZ0GMIzS9M8vEiHRNvvqwlBHh81LDHtYrPRaYAQcTxi3VDBhhM0WtpIfQwr?=
 =?us-ascii?Q?IROs1PNHDNSF7LPQJgDLpJ3rQ73JExRznBmlu8qsWa3Y6/6aDmGVmwyjl7Q5?=
 =?us-ascii?Q?aUzGlHfamYNemV+vtobAfBkznsXuDZclsTfIX5fVyawaFDhjabu7Mfm+9FTH?=
 =?us-ascii?Q?92ogWHZVIvOD2HgW3O23ySdcvXWP4fwuWBm0WyE9KZb91mqLR1q1skqArtGh?=
 =?us-ascii?Q?Pj3KHYa1j1MRcT/nMCIg4xO2o3rYv2Lbai595ioHKVvhTBkUVm+9CB1lhCrK?=
 =?us-ascii?Q?MfiidrVtVwDAl/zXyG3KDkO/olQ4O1D9EI/tejrUBhcNmIqYsbphvbIyTqZO?=
 =?us-ascii?Q?/6qAxYFpYdtR1iLbp54t/MTUqgsi+moYWUP3zAKtaVtzszta50yS4q5yMdQy?=
 =?us-ascii?Q?USJS7Nv7fwwUHZLnloYyjr8nxOJRSiwoZIh9ULJXnyO5VRtfTVV7ZjeZ2Pb4?=
 =?us-ascii?Q?vopDMHMt7tj//JdVzrRtM7z1HqOXG0vO3DDJ+GUy6lXkOErjMywVxjjgE2/u?=
 =?us-ascii?Q?MQXXAeHLDIK9hmp+skwjjACcPBpjAGtwlrT+r+Gg9C9nVxpy7rx0nxlfd3t9?=
 =?us-ascii?Q?7kQ5YeCFDatmfu3vhebUaCJGHesgwQPv+0oF+EH0WKR/rtgubNgdiF8qIP1l?=
 =?us-ascii?Q?rzYs2ZQL4lTOHc9EOMiZia9gkYm9JT7Gh3eUfjWIkWqUvzCECfwusag3wSg4?=
 =?us-ascii?Q?bkqpXuZk00N7aARF2tk8SOQXZMdjGzWwdQvp883uPcVTDkVhSvg/PS6I1M+i?=
 =?us-ascii?Q?200ojaD+F3V/KIf3cgMYmNxrBYMB0foXOtBGqhhrZbrncPhaXLXkrtovRtf8?=
 =?us-ascii?Q?wxBVTmuwwWxE20KY5fJqoVDckehGzd1DcA7eHm5o99+1wImAHu4CB1m0WDOQ?=
 =?us-ascii?Q?mmettufmYLX4iD4kCrGepiVRiJsDJgtcF22BqwPNZbzPufSX5+u0HRib3ud/?=
 =?us-ascii?Q?4S+qFrqTfI0H5n3r9aRRAalKL/yddUBcnoGI6l6YFHD8ih4Yz8FTJCaa2cf8?=
 =?us-ascii?Q?7ZENIX3ZIr144N89u0hGKiVy0kL0DQP5wbcseVNXCaA3no3wo0TGdrS208ym?=
 =?us-ascii?Q?CaDl3/yYCxaErsYUeqtBRYseflWslot2Cd/znW0K+MS9PNfbtRGvibblGoS4?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6904f3-f9a3-440c-fc38-08da69dfebe3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4472.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 23:39:28.8506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KB70A2eus9JImFmm9TAddtcA4rVp9Jvl5AtwGmnmkGfIt9z2Ai00d65UbxawuonS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2824
X-Proofpoint-ORIG-GUID: 6Qk3KTmPYMlY8B1wNGdpffmz-7DYBSaa
X-Proofpoint-GUID: 6Qk3KTmPYMlY8B1wNGdpffmz-7DYBSaa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 09:34:13PM +0300, Dan Carpenter wrote:
> On Tue, Jul 19, 2022 at 10:26:40AM -0700, Martin KaFai Lau wrote:
> > On Tue, Jul 19, 2022 at 12:49:34PM +0300, Dan Carpenter wrote:
> > > The code here is supposed to take a signed int and store it in a
> > > signed long long.  Unfortunately, the way that the type promotion works
> > > with this conditional statement is that it takes a signed int, type
> > > promotes it to a __u32, and then stores that as a signed long long.
> > > The result is never negative.
> > > 
> > > Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > >  tools/lib/bpf/btf_dump.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > > index 400e84fd0578..627edb5bb6de 100644
> > > --- a/tools/lib/bpf/btf_dump.c
> > > +++ b/tools/lib/bpf/btf_dump.c
> > > @@ -2045,7 +2045,7 @@ static int btf_dump_get_enum_value(struct btf_dump *d,
> > >  		*value = *(__s64 *)data;
> > >  		return 0;
> > >  	case 4:
> > > -		*value = is_signed ? *(__s32 *)data : *(__u32 *)data;
> > > +		*value = is_signed ? (__s64)*(__s32 *)data : *(__u32 *)data;
> > Only case 4 has issues and what does the standard say ?
> > 
> 
> It looks weird, doesn't it?
> 
> Yes.  Everything smaller than int gets type promoted to int so the sign
> is extended properly.  The only thing larger than s/u32 is s/u64 which
> is already the right size.
Ah. tricky.

> 
> > Do you have a sample dump to debug this that can be pasted in the commit log?
> 
> This is from static analysis, but I made a little test program just to
> test it before I sent the patch:
> 
> #include <stdio.h>
> 
> int main(void)
> {
>         unsigned long long src = -1ULL;
>         signed long long dst1, dst2;
>         int is_signed = 1;
> 
>         dst1 = is_signed ? *(int *)&src : *(unsigned int *)0;
>         dst2 = is_signed ? (signed long long)*(int *)&src : *(unsigned int *)0;
> 
>         printf("%lld\n", dst1);
>         printf("%lld\n", dst2);
> 
>         return 0;
> }
Thanks for the demo.

Acked-by: Martin KaFai Lau <kafai@fb.com>
