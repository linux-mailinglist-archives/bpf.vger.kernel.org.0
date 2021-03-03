Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D13F32C1BC
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449572AbhCCWwk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:52:40 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34646 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237886AbhCCRkd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 12:40:33 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123HYXAT030242;
        Wed, 3 Mar 2021 09:38:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lE3powfXxCGNkmQKaElXuHgkFpqsjpKhtBk2N7ePnUw=;
 b=l6FHKBqW0STlOeNYXSNupBwc8613J8CDNB49VvdKNFhEc2BJU9N+WCY8eNZ8ZPUaJ453
 Oje8W/9V/xIJCkyrSMeBP+SIfUOzJOZ5Sa3wWhhp6a4qKeLNjHrNfDIxMRbEhzceJbIY
 8xd+TYrcz3IA1xqXn5m40Ns05VLs6Fia9iU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 371k6ps19s-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 09:38:25 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 09:38:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ey42Tm8Vwzns5m6KeYVNUipLiep3Nr8B2R+tp3Dmhk76MahDkRgfqu14g/9vqr8tWVDHhl3RSxCFAY4HYT7bjc/yRvExG2MDrRoJJ5LPHPKeO9o+pkPc3Mx4M41AguXgTg7lm/1ak3KR35dHQASJPIBPZo5DOhsQrvgYPpgM9g3x7e6YxXqQ55a6sKG6CrpQjVRDyjJyPwE/ItEPjfLByJ01B0jkraY0IpbTNCqfglyDxYT8ZnEs66GPpN9FOMew+j9WmDXKEuFUY2XeyXg1AJfC1IJ7G6B+BVoJIdFWNEaFxLya7zJo+cx7+BfAKDfTe6oZBe0/GFhEkraS0Gb5/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lE3powfXxCGNkmQKaElXuHgkFpqsjpKhtBk2N7ePnUw=;
 b=oLUO9YtqlmAfQ7iR4HWwwlCZGEe15kCein7FjDXsHLnPGf5Thln2d9y6mLJuZBD0m9Vk2QONxj4cW98Cn1r/Mwv4/992kihMv2R7XN1Ru1O9aDDWkSkAGCNlIi08b2vtQ4sx9SwU0RQ78upYsuZeZsK09s84uX0xYk4g7r+X15p88BsyfOZ6gbhOIj8rCbMubxvJIjNtYJVu5ijV3qlqrIWaQZmOIbKXSQorEYJT9KJ2tZIjZpV/03gAyhVgIHfv3TjdALcux4zBG7IIgD6EyWKZyndoUX6NQRMM4KiassQRfvs3eHH25f0p25SUH5ABhHjoq+HqLaJ4dEdWgY+OnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by SJ0PR15MB4204.namprd15.prod.outlook.com (2603:10b6:a03:2c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Wed, 3 Mar
 2021 17:38:22 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2975:c9d8:3f7f:dbd0%5]) with mapi id 15.20.3890.028; Wed, 3 Mar 2021
 17:38:22 +0000
Date:   Wed, 3 Mar 2021 09:38:20 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Brendan Jackman <jackmanb@google.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v6 bpf-next] bpf: Explicitly zero-extend R0 after 32-bit
 cmpxchg
Message-ID: <20210303173820.hldpcrmnrqvirbqf@kafai-mbp.dhcp.thefacebook.com>
References: <20210303110402.3965626-1-jackmanb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210303110402.3965626-1-jackmanb@google.com>
X-Originating-IP: [2620:10d:c090:400::5:2266]
X-ClientProxiedBy: SJ0PR05CA0160.namprd05.prod.outlook.com
 (2603:10b6:a03:339::15) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:2266) by SJ0PR05CA0160.namprd05.prod.outlook.com (2603:10b6:a03:339::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Wed, 3 Mar 2021 17:38:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 028ed2bd-d6fd-4f89-b1da-08d8de6b242d
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4204:
X-Microsoft-Antispam-PRVS: <SJ0PR15MB42047A61A147CB75B429FAA8D5989@SJ0PR15MB4204.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raIsWub/bjwhcvYQ6lTPY4Mr8u9r6HGMi+ccr8usO09yL6ZXlg3B+E7IWVOwUZ4FOtZDxVGTbf5/6snmi9G8UHH3P44MUfN3OEqKvkD5WpYXbkypMhqz90E6lOTKDeAdnK9ujRh3kSXhZ7/D2opV7YAHbsP2uHWwf9uD+U/jaQIP6m1lU3WfnGFLwCFIkWcelHaZ47L3TGhwA8A0dhU7wmabasCSK474cyIwIcw9k/GCYmrUf9TCOR7sSWS/fu/QoXMictCWZSwR9t6aIDinLRQQtjTCLtedRhBDOTrOU4mVDppDGu3M/5vMh1mte6nYiddJP6scwfu1xC9xHnOcTEEIacst4eZ8K0Bw+r2fkbyE61hhLHu8DQzWMcHobg72fQMiKvNFQgrkBaOVy6ZJE4kdKMx5a+HUjqfNGt0RVaa/5z+WA+Ps/B7s0RcGyO3yQ6q//p/fzJEWyoHqyRuXb7A2PK0rcG0GYJrfGOrDMkmFxH8PJjNtLRwUcSeu9A3Pi88T2lrbqKybGrNt+RrIRY5mFzawQTEhTmZchGBjeK1nt+iooDrfLrNT8LqT4xhbYTinRaZnIDjKm6gtr4oUSOyyun0lGbHqOqN/9pAZkGIqHu5ld6+fUdXHXyw9FQC8CGkOtjW/G7WVFeQaCFEb9myj8vs8PyfuLj4upuJQWXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(346002)(136003)(366004)(2906002)(16526019)(66946007)(5660300002)(55016002)(6506007)(66556008)(966005)(86362001)(8676002)(9686003)(478600001)(1076003)(3716004)(52116002)(7696005)(6916009)(186003)(4326008)(8936002)(316002)(54906003)(66476007)(17423001)(156123004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zi3bbn+aTqeQhBAVhr4avNM4cyn3EYbCGTTkiUIWhFO35qrb0XZxiOLlUq1o?=
 =?us-ascii?Q?HaHBQdpJ8duOh1faDpql+tEuiM39ZdZEwIslEONd46i5p1fLEObwE0uiAszZ?=
 =?us-ascii?Q?nrArhTI8VVwrSKbFlKdYxmNQ2QLlafQhbh3vHPgtraMtyC3k4kiyhrwNEH7E?=
 =?us-ascii?Q?gCLdYh+RC0IGsR9iwXi0ew2HPUn4zc8UMmnVxpxxy5maeDIBxa28j2DxNK3Q?=
 =?us-ascii?Q?h0N8q/dfxzZYbQE8aNVmnPKyIL+nlSO0HLyo+eqq2WXR/dMQMPZO1cIidSs+?=
 =?us-ascii?Q?gtgyxQlgo9TeWRE1/s+UWL2py5NIH0sogZu9Gdx4EOBxx/+e4XccnGrt6JoS?=
 =?us-ascii?Q?Wg7h9ts1JZMRM2nI0iLtHBl3tYCAvog4Pw5y0/iNsYbulTIF539k7Uu1X+2m?=
 =?us-ascii?Q?tPQqC8foQCpjALUeCjLSKNBNHCCWxum5CH8C/97gVEt2ZTL6Xiq/kfUf5wHH?=
 =?us-ascii?Q?wxYmqrSDgNL2OA3l0ub6ORdeIFVsKUbX97VraBwZrZ5hJBjWkoycwUkHHS8u?=
 =?us-ascii?Q?VKP89gkyDvH0oAeGsdJ/hZuAXlBFj11w9sbYySfsnz2XL/2EgMixK+NUc/oN?=
 =?us-ascii?Q?6hd84LqAF5QTvKmGdjdgZ8BPsjL9gcwjbUOfftEPWg4A93Nra5g14JpX/cVB?=
 =?us-ascii?Q?y3Z4DIJmvjjM8FhDSba0U2hXxu6rJbW8JEtAzY70yLWpcvhpaGpJrhU+IVzd?=
 =?us-ascii?Q?JIJenYT4okXXt9LK0z+FF0vwr6ApKkAalae19d98iOksxbfHO7ozb/Sib/jU?=
 =?us-ascii?Q?t6v6tS9wmlIsn53mL5bp73Oqw7+AdMVRFSq103GwLoBcZXFEi8W4xlf0vwkZ?=
 =?us-ascii?Q?TuAhr/lT64gHYKm3XAcJ0Zq2PrNBSzkodm7i1faY+Tg2hLKUDnHooZmMkRDt?=
 =?us-ascii?Q?x6qr5ce14awpMyRwA/oxk2c14QGPphxdt2bNXx0fFhoowXf0BHdW8aohhjhS?=
 =?us-ascii?Q?BYdKDOZQHiI/7azdehErL5oXxXjxTVjgcDV5mYFugPW+7cJJde6+d24VPTrO?=
 =?us-ascii?Q?EzRiJ33NSXkxzCOfiExOKt00/pYt0OZE0f9ooklSHpUg6AeJSKfhr9f4wz68?=
 =?us-ascii?Q?b3uvJ4V6i3jPeLY4AeruUKDb+j5yLMUzSIR6DC7mLW37zOm3uYEivIlylP4P?=
 =?us-ascii?Q?1VR6fDpf4wftB81ruZJEvsdPWWxlXTzUNH1qSWMTAwgyGWcrBbrFTM1/5CeC?=
 =?us-ascii?Q?7cDR/JKYPmmbMnTN9mto+eF25eiMi8N/7XEyjo8MJ40zBGPZvQX8ZuZZsdXF?=
 =?us-ascii?Q?qngaH1MHAgro64Bc5oz7l3udLdNc2+X2kplILdTAxgvTUnvLBzNpMz7gpXg/?=
 =?us-ascii?Q?8tAyEn0CkvlJDlLX1YzuLoVHnBjVgZ8gk3lM5jxddeRONA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 028ed2bd-d6fd-4f89-b1da-08d8de6b242d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 17:38:22.5395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gziNB0uFhMTdHIz5xBpFO3U+hQHk66T5w81macz0mp4Jlcsp4M0+2tz13S/k1iLN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4204
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_05:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 03, 2021 at 11:04:02AM +0000, Brendan Jackman wrote:
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different. The same issue affects s390.
> 
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
> 
> The fix is to explicitly zero-extend rax after doing such a
> CMPXCHG. Since this problem affects multiple archs, this is done in
> the verifier by patching in a BPF_ZEXT_REG instruction after every
> 32-bit cmpxchg. Any archs that don't need such manual zero-extension
> can do a look-ahead with insn_is_zext to skip the unnecessary mov.
> 
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
> 
> Note this still goes on top of Ilya's patch:
> 
> https://lore.kernel.org/bpf/20210301154019.129110-1-iii@linux.ibm.com/T/#u
> 
> Differences v5->v6[1]:
>  - Moved is_cmpxchg_insn and ensured it can be safely re-used. Also renamed it
>    and removed 'inline' to match the style of the is_*_function helpers.
>  - Fixed up comments in verifier test (thanks for the careful review, Martin!)
Acked-by: Martin KaFai Lau <kafai@fb.com>
