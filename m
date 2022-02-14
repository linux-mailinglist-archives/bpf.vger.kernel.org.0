Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070224B4E87
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 12:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351609AbiBNLcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 06:32:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351895AbiBNLax (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 06:30:53 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396BB66CAF
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 03:14:04 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E84RcU029601;
        Mon, 14 Feb 2022 11:13:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=AiXbUjF9FJi52atixpgxQUH95w2ri5Il+Jjm22btn7g=;
 b=lSnZznWWcouRvxU5yL/aBjJG7EVqFanvSaxV3ghoOhFvNnZnknUQRLnZnZdlcBN/k4vC
 B2CH463Ff8hZfyp8tE5Gj0ixVOd0xQxmEkZ7EmfkB7iEXOMh+W8ZwW5XhAxT3c1DsPOR
 xGCHk1d10eVFhydjyVz0i3Xc7wuHt9UntAtYx5XucaqBusH40ujDov2DBaSEwaZdyyHK
 kr9XHqG7Sbych+gNfCDMkG7e36HE3I9BEDIyx1wmpKada26HhwF8RBhGIN/79ZcfDVjP
 9gHXW1ekSnN/3TphZAKFcrJ3fgYlPmoE1kP4HwtsieieIicZr/C6DOzOCrGwVqOfKphR Yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e63g144yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 11:13:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21EB6OEI005783;
        Mon, 14 Feb 2022 11:13:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3030.oracle.com with ESMTP id 3e62xcx6k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 11:13:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLsnfRflwRz/rGBiYgkJCdhJOIHqe6YT9xXbjjyP3FR3IW5xbDa7I7gR/GCJmabLDX6XezXUVg02bSYirWhZtAoTiuxpqr8NQpyfnylsvuXWC53RTNgRSHO+9OQJ5/XIhoh2EPKP0Fy1Ljb78T7Tpd5AAt1/+OcN2rx3rvHgPH2gRS5hvwmB6k/nah9vLyHA7Vtn5legJRM/k9jdIw5yAZUUMvDT23Oazmy++4PkPwNGW3ku9CdwgUuqhQ8QO8Dzom/wKTn05mw4LBKen3H1jBeWdZ8hby6z9rQEyrMRKvFPJAXqfVFWJN+3Cp/PFrJHQij8kbvtG48KA7coyXoTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiXbUjF9FJi52atixpgxQUH95w2ri5Il+Jjm22btn7g=;
 b=n261cnet5529X571taMAkg8yjGvD5Afz3H1QaAFyKzYv1GW5J82BolV6uCVQkUJPJ012+5NckpdY/1bvy4hKr8cCR6pko73vb04tvzyOx82bNu3KxMB8jnJY75siOLZqrmZaURiy6feYv3fjbyWLX30G95vzQgQg30PR2aX9y9kVZKaXUDCUeha9ZntbFonVbNio65cJtDp+Yotj3xtdb6H0k6o1T2bp/TRbeSikcfHTFRjGklHGaBmDHwWE5lNRfFz0zyUasD9w8nidEZIa1CnSRuggY208fEgGaRBrNtlXxwDwZsQohuhXwWlAriNIq3iB31PKtgR+SofP8R/pYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiXbUjF9FJi52atixpgxQUH95w2ri5Il+Jjm22btn7g=;
 b=BGta8UmYcEQEOaimgv34gbmY7cIYKfDfDfDG1LFT/n0HFnvRbQHCF7njUuD/lg1+9BvsIixayyYdt9oPl1PAqEQaI54592ZAzVKIAU+jTGDxL5LdEh+Vmj0MyBiGg/zeyL47/4+jZNQo7XdAFdEDXpZpTiWCfWNgxeLUQwAKFeY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4618.namprd10.prod.outlook.com (2603:10b6:806:11f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Mon, 14 Feb
 2022 11:13:41 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::517b:68:908d:b931%3]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 11:13:41 +0000
Date:   Mon, 14 Feb 2022 11:13:27 +0000 (GMT)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 3/3] selftests/bpf: add custom SEC() handling
 selftest
In-Reply-To: <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com>
Message-ID: <alpine.LRH.2.23.451.2202141036510.9032@MyRouter>
References: <20220211211450.2224877-1-andrii@kernel.org> <20220211211450.2224877-4-andrii@kernel.org> <20220211231316.iqhn3jqnxangv5jc@ast-mbp.dhcp.thefacebook.com> <CAEf4BzbrdJMX0P=P84D40oYH3BNrL-16xqFNFH48BtYc9DaJHw@mail.gmail.com>
 <20220212001832.2dajubav5tqwaimn@ast-mbp.dhcp.thefacebook.com> <CAEf4BzY_tQQ3sTmTwx_uFAg3Z50ckWf1MWgCy-ZR==gV65e3Mw@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fd2ff75-58ce-42f4-849f-08d9efab0ec4
X-MS-TrafficTypeDiagnostic: SA2PR10MB4618:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4618669FA541019704DBAD6CEF339@SA2PR10MB4618.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDj/PaTLbGd8/cZzO1kDvi937J0Qp/cNZVvOQwS4HR+vPECAzXlVXfx+CgQHG+QijbpT9BBArHKQNgHN1IENb3VRxnF89t/4k+1g2S11Sbt9D/o50gVsPxvMoTMWoJl5N8raf8+THXzyhx56YpodcsP1hjtotftEIkmvGsYv8ibeIAgoAWiieqznlE0KrtiUxR7I2VsstPkk3mSONBZCO+/v6yP77WndAEMtnZX1t4XID9ciA6xgYXiR+CEHdNy28EZZX4a33bnVaXHaVzLJh+2vCm3frqKz0/JFMUnoqT4RiWznNoEq+3AptYbMLKQlFq5Qw4r711Eav1X4xDZ1FDCgnLOh7NgJiZMpM1bL3ARmyxjBoo7AqUiZ+HnJm7t6rZkZ2FFSnvjW1G3ouWwuPFh5zKFiZvWu0T5w4YY1A9AKrzEAhfxmixoyIcvPppyig77atfWPh5QzdCf/8x/gyqebZrfwzCnrBOVuhdJErC85i2O0dCHhxteVdij2A79vuCFMz13r19p3YTQVoRvgis2vQEMtHz0WjABIMQcjyCL839Cc5UnOaahUNRKBBgqbanenH+Cuwj3p7izMfc1dhlJuzRYtxzt7hGBJAX9k95xib5/qxyTwwH3+U1EBfWPW45qvZDddoFsb0iF3RWiTuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(6512007)(9686003)(2906002)(86362001)(53546011)(5660300002)(8936002)(83380400001)(44832011)(52116002)(8676002)(6506007)(54906003)(508600001)(6916009)(33716001)(66476007)(66556008)(6486002)(4326008)(38100700002)(316002)(66946007)(186003)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KGxm0A85Ky+ugTx+oNY+CTbPC7mzkUsm+L7T40RpTYyE+tqFevGy9ecrZGok?=
 =?us-ascii?Q?jyMWKYLszYoe84tUWD6IFrXa3+nxCsmN5wV4dY/tAiJd4mD+cZ11PxAZ9tV/?=
 =?us-ascii?Q?z/H+UI7m77U9sJ9uQw2jut7RhvCNUQrKShoW7vdTiQuJcgc5eJb8J9V0yrk3?=
 =?us-ascii?Q?Rj3XbyQg8clykFZ1e+FQSAnxUvUb5SJVmAn1gLJLN1SiF6buMntfQ70/qFwc?=
 =?us-ascii?Q?x7SqTLHWq1FlwPzjQ0LCCEozlD+Ev5jnWZ2w3X6LMKNNJnq0yxTWwkdJcwpt?=
 =?us-ascii?Q?ckOp2OYolJMDebOyprctNlSqHeCQvJ/dHZUTHk8bPmBJzyVYRokQcczkW3Rx?=
 =?us-ascii?Q?FUx9dC0p8rufFcFSzsu2IABak5IMTGb0dSV3bb9mxTYW4zS8hIH6ux50l5L6?=
 =?us-ascii?Q?8LHX4QOF9WyLcJrBR8+NlcdhwUAwgFA48wrNzIKtAS+54S8iI45jbu3nT7uU?=
 =?us-ascii?Q?/xaPfNfODAKcJe3ModnWFHsABnwqgrbIeKPr02qwK3rXJu9leuYOdgJs6Dt0?=
 =?us-ascii?Q?vsnGE3B78LvSeZ5nF/ohyW9pkalKb5i+iIyIQgujP2k3c41QzXipray94tre?=
 =?us-ascii?Q?UbuD9L5SIuP+kwRRt1vH6IJeA+NLEk0RYcTo1wMQehKktLvaYPKNDz0FQFrE?=
 =?us-ascii?Q?Nki/zNr1S6Yx4X1c/4/n5EQXQoMqWwWFcaRWDGSXW6K34iVk1ZE39vhHh3pM?=
 =?us-ascii?Q?QXI/IPQ8kZC8Jm8SG6p1RwkymyuXrbi/6bee+Ysg3LjyfnJS7jKIipUxbh6Q?=
 =?us-ascii?Q?Nl7vAQEjsAmM90yN4IDj7YxNYQ6ZG0UiZ8bhjdGK5Slq0xc16W1S2acO2VN0?=
 =?us-ascii?Q?vHrm0w6qtUSJGwA+7E0eZIA+qcv6KHw4gNW/k2dv6VkeuNUMbigvOLjWfY0R?=
 =?us-ascii?Q?IJUNRyfEu8678gYdMWZy8omIa5GPcREVgRlL6lMO62d/xBRgPtprCPmv5Ttf?=
 =?us-ascii?Q?76IH8V/PxYfdOhvYYLL0B2Lqr9FcqZLopkOuBKRBLuILlih5L+hwh77v8CP9?=
 =?us-ascii?Q?bcSdtggm77le93ugAiMNSxHFtMkXWedSCnsMZkZEnBFR3qAqv7vHN/vsACPp?=
 =?us-ascii?Q?X46UbqRZ0lcH28dSEnECUpGD2IyiZAOw3F3bdHx4cREX+yMBrioP6KnLuw8I?=
 =?us-ascii?Q?h3C4ttID7JxhWhU4nPY/INKBRz+dtr8J7G1DXRCEClHK9m4JuieAk8WCnH7U?=
 =?us-ascii?Q?G4pjmiD4EC5GVqaxWdk0h6b8H9xVqIEEjkZqHZ4lgO7TKguNXN4uh0W8sog4?=
 =?us-ascii?Q?ln2ZcPMKi97sChvAB7YlhgxwJqHpRjPu4MNpvOX7vMXLOqOs4CMS5tBU3GE4?=
 =?us-ascii?Q?jOEetBVb8U/cjoC1ovggoWwYufMRr8Ma22DVgJA7PsIcG5fQ2bbn7nk/6WLQ?=
 =?us-ascii?Q?EP7inFwXg6t7G8rycPTVypq1b2kXrC/XZQcnEtRPFDAcMfbwXeqtEDb8wGlx?=
 =?us-ascii?Q?fqTivi6M+k8oDlIw/95+WdsuxXBatSTK774/jTGx5MZyiErgEPLvZHkqbXSG?=
 =?us-ascii?Q?vuvCB+dMrOwW6mUZyyxTvEXbIZZrryUzuiUMbr4bC7DaFBIiQKyfd/w+WV7p?=
 =?us-ascii?Q?IQt8hV3+K5+Z2E3XFTIe3WJUbNGIghvwSQVhBWr9FlHku+AANpniVYWLCF4z?=
 =?us-ascii?Q?FmR6fPHw9X4cdLobd546JLJgcNLAJAn0dJzthKu40f6MDtQ5DXjhz6A8UpI5?=
 =?us-ascii?Q?fMzAlA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd2ff75-58ce-42f4-849f-08d9efab0ec4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 11:13:41.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43p0dMCfAeGPbn0rcXYki+lep2GNauH+30PVOEPujz3SnDdRldOzDjw7+1T5c3TiG+Jui1Y8QamkcECPpaDT/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4618
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10257 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202140068
X-Proofpoint-GUID: Kp2NTIWzB50CEatOf-oJqkvY_E6zxL5k
X-Proofpoint-ORIG-GUID: Kp2NTIWzB50CEatOf-oJqkvY_E6zxL5k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 12 Feb 2022, Andrii Nakryiko wrote:

> On Fri, Feb 11, 2022 at 4:18 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Feb 11, 2022 at 03:31:56PM -0800, Andrii Nakryiko wrote:
> > > On Fri, Feb 11, 2022 at 3:13 PM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Fri, Feb 11, 2022 at 01:14:50PM -0800, Andrii Nakryiko wrote:
> > > > > Add a selftest validating various aspects of libbpf's handling of custom
> > > > > SEC() handlers. It also demonstrates how libraries can ensure very early
> > > > > callbacks registration and unregistration using
> > > > > __attribute__((constructor))/__attribute__((destructor)) functions.
> > > > >
> > > > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  .../bpf/prog_tests/custom_sec_handlers.c      | 176 ++++++++++++++++++
> > > > >  .../bpf/progs/test_custom_sec_handlers.c      |  63 +++++++
> > > > >  2 files changed, 239 insertions(+)
> > > > >  create mode 100644 tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > > >  create mode 100644 tools/testing/selftests/bpf/progs/test_custom_sec_handlers.c
> > > > >
> > > > > diff --git a/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > > > new file mode 100644
> > > > > index 000000000000..28264528280d
> > > > > --- /dev/null
> > > > > +++ b/tools/testing/selftests/bpf/prog_tests/custom_sec_handlers.c
> > > > > @@ -0,0 +1,176 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/* Copyright (c) 2022 Facebook */
> > > > > +
> > > > > +#include <test_progs.h>
> > > > > +#include "test_custom_sec_handlers.skel.h"
> > > > > +
> > > > > +#define COOKIE_ABC1 1
> > > > > +#define COOKIE_ABC2 2
> > > > > +#define COOKIE_CUSTOM 3
> > > > > +#define COOKIE_FALLBACK 4
> > > > > +#define COOKIE_KPROBE 5
> > > > > +
> > > > > +static int custom_init_prog(struct bpf_program *prog, long cookie)
> > > > > +{
> > > > > +     if (cookie == COOKIE_ABC1)
> > > > > +             bpf_program__set_autoload(prog, false);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > >
> > > > What is the value of init_fn callback?
> > > > afaict it was and still unused in libbpf.
> > > > The above example doesn't make a compelling case, since set_autoload
> > > > can be done out of preload callback.
> > > > Maybe drop init_fn for now and extend libbpf_prog_handler_opts
> > > > when there is actual need for it?
> > >
> > > Great question, but no, you can't set_autoload() in the preload
> > > handler, because once preload is called, loading of the program is
> > > inevitable.
> >
> > Ahh!, but we can add 'if (prog->load)' in bpf_object_load_prog_instance()
> > after preload_fn() was called.
> 
> Yes we can and solve this *one specific* scenario. But there is a
> bunch of preparatory stuff that's happening for bpf_program before we
> get to actually loading finalized instructions. All the relocations,
> marking whether we need vmlinux BTF, etc. All that is skipped if
> !prog->load.
> 
> I don't want to go and analyze every single possible scenario (and
> probably still miss a bunch of subtle ones) to understand if it's
> always equivalent. Libbpf's contract is that
> bpf_program__set_autoload() is called before bpf_object__load(). You
> are asking me to redesign this contract to move it much deeper into
> bpf_object__load() (and potentially break a bunch of subtle things)
> just to avoid init_fn callback. Hard sell :)
> 
> Basically, init_fn is allowed to do everything that normal user code
> is allowed to do between bpf_object__open() and bpf_object__load().
> preload_fn() doesn't have this luxury, but gets access to
> bpf_prog_load opts that normal user code doesn't have access, but it's
> not free to do all the stuff that user is free to do before
> bpf_object__load(). They are not interchangeable.
> 
> > Surely the libbpf would waste some time preping the prog with relos,
> > but that's not a big deal.
> > Another option is to move preload_fn earlier.
> > Especially since currently it's only setting attach types.
> 
> It should be able to affect logging and all the attach parameter. I
> didn't want to design new OPTS struct just for this callback, so I'm
> trying to reuse bpf_prog_load_opts as a contract. That means I can't
> easily change prog_type (but that's trivial to handle in init_fn) and
> insns (but I can hardly see how that can be done safely at all), but
> otherwise those opts give the full power of low-level bpf_prog_load.
> 
> I keep a possibility open to change preload_fn contract to actually
> execute bpf_prog_load() on its own and return prog fd, but I'm
> hesitant because all the libbpf log handling and retries, and other
> niceties will be lost, making trivial things like adding extra
> BPF_F_SLEEPABLE flag not trivial at all. But here's the thing, we can
> later add "advanced" load callback that will be mutually exclusive
> with preload_fn and would be able to handle more advanced cases. But
> that can be done as an extra extension without changing anything about
> current interface.
> 
> >
> > Calling the callback 'preload' when it cannot affect the load is odd too.
> 
> It's what happening before loading, I never had intention to prevent
> load... Would "prepare_load_fn" be a better name?
> 
> >
> > > We might need to adjust the obj->loaded flag so that set_autoload()
> > > returns an error when called from the preload() callback, but that's a
> > > bit orthogonal. I suspect there will be few more adjustments like this
> > > as we get actual users of this API in the wild.
> > >
> > > It's not used by libbpf because we do all the initialization outside
> > > of the callback, as it is the same for all programs and serves as
> > > "default" behavior that custom handlers can override.
> > >
> > > Also, keep in mind that this is the very beginning of v0.8 dev cycle,
> > > we'll have time to adjust interfaces and callback contracts in the
> > > next 2-3 months, if necessary. USDT library open-sourcing will almost
> > > 100% happen during this time frame (though I think USDT library is a
> > > pretty simple use case, so isn't a great "stress test"). But it also
> > > seems like perf might need to use fallback handler for their crazy
> > > SEC() conventions, that will be a good test as well.
> >
> > It would be much easier to take your word if there was an actual example
> > (like libusdt) that demonstrates the use of callbacks.
> > "We will have time to fix things before release" isn't very comforting
> > in the case of big api extension like this one.
> 
> Hmm. For libusdt it would be literally:
> 
> libbpf_register_prog_handler("usdt", BPF_PROG_TYPE_KPROBE, 0, NULL);
> 
> Done.
> 
> There is no way (at least currently) to support auto-attach through
> skeleton__attach() or bpf_program__attach(), because single USDT
> attachment is actually multiple program attachments (due to inlining).
> So until libbpf provides APIs to construct "composite" bpf_link from a
> single link, there won't be auto-attach. We might add it later, but I
> don't want to design the entire world in one patch set :)
> 
> USDT is too simple a use case, perhaps. I'm trying to also take into
> consideration perf's custom SEC("lock_page=__lock_page page->flags")
> use case, hypothetical SEC("perf_event/cpu_cycles:1000") case, and
> just thinking from the "first principles" what some advanced library
> might what to be able to do with this. Alan's uprobe attach by
> function name would be implementable through these APIs outside of
> libbpf as well (except then we won't be able to add func_name into
> bpf_uprobe_opts, which would be a pity).
> 
> I can postpone this whole patch set until later as well, don't care
> all that much. I hate callback APIs anyways :)
> 
> We can do USDT library without all this and the user experience won't
> change all that much, actually.
> 

Here's one case I had to implement which would be made easier with
this support:

- optional attach using an "o" prefix ("okprobe", "okretprobe"),
  where attach failure is not fatal.  Used for cases where multiple
  possible candidate functions in modules are traced, but we
  have no guarantees which module is loaded, and hence which
  function is available.  Could be implemented by overriding
  attach and returning 0 with a NULL link for cases where attach
  fails with ENOENT, and overriding preload to set program type
  to KPROBE. Having optional support like this in pluggable
  section handling makes skeleton interactions simpler where we
  mix and match required kprobes and optional ones.

Having custom section handling is nice because the above was
required in a bunch of different tools, and with custom section
handling, skeleton interactions are a lot cleaner.

I would expect tracers would find this functionality useful
too, for example supporting per-pid conventions for uprobe
tracing like "uprobe1234/prog:func".

Alan
