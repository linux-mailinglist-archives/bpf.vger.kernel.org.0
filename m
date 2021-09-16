Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B0840E2AE
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 19:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243958AbhIPQlM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:41:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29702 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243182AbhIPQhw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:37:52 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFgxpc000617;
        Thu, 16 Sep 2021 09:36:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=SL9aIDc1lWpTRYwjrD0l8M19rat6S2d454h1zGFgYQo=;
 b=PIahhE05yQAp42jvHXXiC7lBeN3evODUyPR9K5wNDlQzz0Hjc7TWseepEQ3vZ7Agy2CA
 aMAruKsCk+HHRJYFTy/fOt9OTz1MAZdwqHNe8bzcRozva1Cb7OgvdJ/ybtJMwzQwJe4C
 16n2Q2yt9SWfPLLv6DmJZxONxvggc3I3kLE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b40fb3hn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 16 Sep 2021 09:36:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:36:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyNKsttlJugDUNWDKRU5Kp637HBtEd4omGDwNeS9qtzCF7nR5H1qXSW4FejtNHk9KC4TUnBbBS3KoxNEImaq3SnCqL69YpUHVku5+Yrs8eLWV500pmenyP54VvNL0HxATafMOrR9pp1JWa+tGOpFvajiI9A6SBYz7ucztdf/NUI00Vb31V1G0CATBGWV6ffb3SnQSSEyVe7o585PudeXiF8qhyeLtxPxEMqaGJIOl8Lt83z82gS7mh7QFklqBZEnoe9sr0QuRGMi8xgy1mOhxPWeevgsGt+6pVAH8H9aXzHA3bPKC0c3CmKX79ZuHDrABJUCTk7yYJfhj+g/S5O7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=SL9aIDc1lWpTRYwjrD0l8M19rat6S2d454h1zGFgYQo=;
 b=HKYxjYPLoNJfXNqqTib7FVq0GNfaex1iz4RxMdUeQXi6WGmrgeD6h86De0TA+pgDFYoD0Q5ZJF3JkRPd4CyETEQVGvoqdULj09NcQZLDU1C6l4OkShrke3ljRPRO0sOWdHrERqVELglWeXA08zPDvCs7muk8ynbZTXo6HwZxxphet8hv/sfrEO0pmE1tcFSwS6gjpdlA7MnsOblKO++DNxQpH31zyKUhuQyuIY2V/i/sEJxJFE2kAOT3tb1jAcUesTiITo+Nqkj+rJ81eIugz4XQr5DxhUbNF8ZSEVPNHASg5pvDlk63LzIb7zEmwPrBTng3/riPXFDIbqGCkljZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB2600.namprd15.prod.outlook.com (2603:10b6:a03:150::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Thu, 16 Sep
 2021 16:36:05 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::1052:c025:1e48:7f94%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:36:05 +0000
Date:   Thu, 16 Sep 2021 09:36:01 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>,
        <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Message-ID: <YUNycdzO3jRBTlhM@carbon.dhcp.thefacebook.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
X-ClientProxiedBy: SJ0PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::21) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:e8bb) by SJ0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:a03:33a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 16:36:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6875278-a399-4d1b-17fe-08d9793013f8
X-MS-TrafficTypeDiagnostic: BYAPR15MB2600:
X-Microsoft-Antispam-PRVS: <BYAPR15MB26008C7C34646C09877AF99BBEDC9@BYAPR15MB2600.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZOq+MHx+vs4RvUGH4O83BmdGtQm33FWntU5Dkw4om6ebYTHHQ690PgpiyA6D6nleXzZTAmkuxv36awH/eK50t0fCFDhQ8Tc5KNq4Z+HfI7IezLOpEmd1cKgzY9CY11g9/JtUccTFYZ87iJEkxBqJEu62XUzZNKerd1SPbluZzuh8eOrJCRCQ1KR04mqYi2CyxiR1u7PJ3xoCBI3UslcvzbGdTdi4zK5+9hKmJUkBJEeaXuAuZISHjcjS0L/UuUxBQBlLjySmRjwNGkb1+2Vzdsy+R0JLsFd2sc5QL5XPLulgX3cnGuRpH2Lb0th0Zp6CMxMD3eVH3B7m/fHoQrAcqybsFn6cnrmGg3hifYtVAolN6RXTlg8bK/wlM8ZIywex0PAsyp9oEdZOUohy9f5CLtjYb/Ug90tZ7FFUJrIAtEgO166uPG4uvDRPNBnxmyPFuEm6l7p/i3xYtZYOf6SekGCfYvUaMCGDF4lTv3vsoT0k6HK7jgU9iqpQozo/rwC1n2BXvVvOmEkB0uWHsX0zEZTI1awM84jda7cWpvhIxlbzaZJTrxKjsdFwG815oDAFVAdJCXyJa7PfvDoVHM2imsOMQfI1pnLH341TaGj7dElL+nkkLSLC1O7ul7mR+p38liZMnAS4EneH6GrWCKFlOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(8936002)(316002)(38100700002)(83380400001)(7416002)(55016002)(2906002)(52116002)(6666004)(7696005)(9686003)(4326008)(110136005)(54906003)(4744005)(186003)(6506007)(508600001)(66946007)(66556008)(66476007)(86362001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?veT2M+J0GqwW6MOfwNkvPIkv/Tnn028nhwlZy6g0uGQS7fly9ndHtQYVoVIB?=
 =?us-ascii?Q?8Y5pr1aJ0P8ql/iR2O7C4kRejDjDE8zJwcfJ4B0bzoxfVn1e+Ls20eXxZBXx?=
 =?us-ascii?Q?w+6aMpi4aFkJ3R3eDg7Su8oqpBC0sLBgHQcgf3mrhOSCMxV4uRGAXA7yyj9h?=
 =?us-ascii?Q?RPOXlkjnYsoGuow8aDanYOETcPe68Ql9VirzrL2adXr5rNdJ3HQVJbY7yAi6?=
 =?us-ascii?Q?UV36nTGFVVvixbHq3+IG8aa5O4EJZzyUHDDbbDnRFxCL0ZVAKI2Cdi+3Or3W?=
 =?us-ascii?Q?q5v7cJ8bqB64V9xTLo9yvXr3Z/cytPoqFdRU1aS1ZjcSCjKJRvpZi7N+GpqV?=
 =?us-ascii?Q?dy1vBGBF5WUaVzM/JHlteKPv6snUWzpvEV5AnIBCUkdFyce1CfO96brh3edA?=
 =?us-ascii?Q?8H0gfLLRL8EvA6Gy1n5gEwkWmqGkVQheH0YHhBbbxietmJJCHe62FF7YBjyc?=
 =?us-ascii?Q?Xr0iJ2pMzTglWlZpmxAGcL8ye1ys7CfaLt/3tCYHC0ZSzrpdEBpeQKDu3gFb?=
 =?us-ascii?Q?hKXwdFcB6Q1WBexBWRXSCyEwiwYNKPxH3VXN2iedS5w7Wt3RiNfM3jrvzj3d?=
 =?us-ascii?Q?7I7in+DCYf1zoTtaIuIMmQ0E+BuMMMIo8aBBDlhJ+Fr87g+87TDPEqdjSObi?=
 =?us-ascii?Q?qVjvnePwDO+OuTDWSkwMXNnA1+P8Nq91NWb9eGUVV9dMF7O7sw113r7ZAI/6?=
 =?us-ascii?Q?pIoJAlkWhSXLDpythOLEoBAkq1DzdqvZOj+EzfBh5J9NvJ5Kbh99rVy+OZC5?=
 =?us-ascii?Q?u5vj652rIGftfpSbRT7Gqztipmc1Ke8Nkwn7yuWH1a52F7HLcEhEXDXEIUtM?=
 =?us-ascii?Q?8feaJuHzGmoC9VwdGbefJWnvelVYOkFJOzjL4IIkqTE7fugMYF+PMnvvHM8g?=
 =?us-ascii?Q?7UmVH/zQJKtpzPzaekku9rW9lxDvklsVM9IgSQOm4FEm/NeOP3pXU65BaDzQ?=
 =?us-ascii?Q?ppK8E6/KcmQuNB+L2psf3msV7pkdkBM7+JAbvRiNqFV01AEzgFqKcI6aOD6S?=
 =?us-ascii?Q?QoWhHlsq94i7bgJkV47koWWx+xuYjO156GhElaXU8H1p9Anp2dH5iKY9lVvq?=
 =?us-ascii?Q?6W1uIm1X7FtIUH2vo/8rpG0ta/+GCQpiR4gDZJhUY4ZBP+GCa19a++WP/5jh?=
 =?us-ascii?Q?lvAhAsm3ANFqb98jP2Lw46gRXyTQtz4VKFQzH76AxZJSgAjUFdFVbALtb1H8?=
 =?us-ascii?Q?M2N3Rym2Pgm2EK0Qcbt9zWwTAzMHmkCsLgnlycIIu9c40PpdKlB2LjdNBf51?=
 =?us-ascii?Q?4LB0gbROinw4A4IngaqMQDGhlxeBe4MsSFCdnPmBrdUVP1yw7bsazWXOTAXe?=
 =?us-ascii?Q?4azZWs8Q+z6/qoC2jRNVMdsdGyl8QADFP/tm9lP8U7gKeA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c6875278-a399-4d1b-17fe-08d9793013f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 16:36:05.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBuwHZuaMDY2hzqiDeym/BAQQnwpp+NsJ/G+ugioNvj+64E+EUD306glkwA8V699
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2600
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: HhOyMJ7eqYrmqg3PDHT03pGXr63weTRt
X-Proofpoint-ORIG-GUID: HhOyMJ7eqYrmqg3PDHT03pGXr63weTRt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 mlxlogscore=630
 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello!

I'm sorry, somehow the patchset didn't reach mailing lists and at least
some recepients yesterday (I'm digging into why).

Resending with a fewer people in the cc list, which probably was the reason.

Thanks!

On Thu, Sep 16, 2021 at 09:24:45AM -0700, Roman Gushchin wrote:
> There is a long history of distro people, system administrators, and
> application owners tuning the CFS settings in /proc/sys, which are now
> in debugfs. Looking at what these settings actually did, it ended up
> boiling down to changing the likelihood of task preemption, or
> disabling it by setting the wakeup_granularity_ns to more than half of
> the latency_ns. The other settings didn't really do much for
> performance.
> 
