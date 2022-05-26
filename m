Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB76535393
	for <lists+bpf@lfdr.de>; Thu, 26 May 2022 20:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiEZSxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 May 2022 14:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiEZSxK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 14:53:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520C1994F4;
        Thu, 26 May 2022 11:53:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24QHN21N001688;
        Thu, 26 May 2022 18:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=egYQORubetu4GcwralxAya4C9Kz2E1dNpBDhXMKgFo4=;
 b=IktR5sipsbYAl5sR7kNxfW63AKqaUchJTZ1dCMxdIF+awPeLmuKRyUr6affL0BTEGz+d
 6rS46RVLJzIynnrYDhdRCseha+ONNAIpMnJSlfhvCVjt6BYEQGBroxNyUfEf2JctiLeI
 SHVEbWExBVIGJgHAwX57hexwSr0eF9zI14KseTeQQD2hILs24ThNC2cZ5izOxhuA2omj
 Y5U3HgZJMdlfpQoiBBdwKfmfLsfLpEPQZ+KRnSbhWdXILNwFMsS9J3pih9L3B8D6FwSD
 DaFeIiYLzR7ibMoulVLCzgojSsuzOBIzCMgSE48yZ3BFsJ+r/TpAAmKjs90yP2MyCMeC /A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93t9wmj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 18:52:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24QIkGvd018555;
        Thu, 26 May 2022 18:52:48 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3g93wxm3ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 May 2022 18:52:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/tjubqOvCCWgtYCk0i0ahHBZ3Y7iJAitSJt0mBsy6mrAZgJMlJ0+gKAOdG4trbmrLA3dqDWE/cIyw1Fshki8Ptgra4Hv+sUszfomlsVF/ICrX2w1dyeRLovSW3QxCB561cHcQ1CYp57cpHlp5/d4gGCwn5r0dMNNBa2F5AP4eN80g2/KPhV3ewhvB9EbDGhsd4ho8pXLxO2iLShlIxQg/ii+rBYJYkL1RH0dqxmHxg2ju4llN5V9m1k/gfWKAA+FONcQsFGLtckd1ZefwBTxIeF7LOdbNz8p2MfzxDF1AEQVAjz0Wcj43qjqlbYdJUplO+zTAF1MstM9RVHMGu7Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egYQORubetu4GcwralxAya4C9Kz2E1dNpBDhXMKgFo4=;
 b=gOsYx7zvUilttXCfho2bLgFOU001FVxTjAFDzgp0pNEm8Gw0sYmsHbYl26Xq/UdNyqb7a7wNBQOJawj92A12tABN43aFZ2KOinIIci+OZdOuqRfss0UMJw6OUtUqcYqe4O5sPcrzraF3EjdrC8w/uyvhH/S27i0Wcxd5DKUshWQYolHn4eML0XE8dSfEKhAPY2TLMgdc8gFG0RTdFYf5/juf8GloR3KirW+RMk4saqOP2NX1ibyBnljys8fsRM22APJQqwo77qyRBjJ4BwMl5ndP6Z94wkJHSc9QmcieDvNI9ktb5c2so2yUp1Gec7kQ8nwAcVIGcPsP7kM7vwsTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egYQORubetu4GcwralxAya4C9Kz2E1dNpBDhXMKgFo4=;
 b=K0tmfLSjAtu5LOeFXlGSFyItFB7s4sFiXl0gjmNn7PmU70jS5VsJvzGsnusfU6fiYuV3qw0PFDe35SZ7WifFNzrqjq+gT4axfxdj4zTyA+J4261WEknCeipe8ek+YvVtxCuYcHA88FVVe8IWlrEnhK/2i1eADGP7FMPVrxypy4I=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM4PR10MB5920.namprd10.prod.outlook.com
 (2603:10b6:8:aa::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 18:52:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::86f:81ba:9951:5a7e%2]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 18:52:46 +0000
Date:   Thu, 26 May 2022 21:52:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Yonghong Song <yhs@fb.com>, Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] bpf: Use safer kvmalloc_array() where possible
Message-ID: <20220526185221.GI2168@kadam>
References: <Yo9VRVMeHbALyjUH@kili>
 <67e7906e-3f93-a979-f534-bfe7199f843f@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e7906e-3f93-a979-f534-bfe7199f843f@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ffa1a7a-2146-43aa-2361-08da3f48ec05
X-MS-TrafficTypeDiagnostic: DM4PR10MB5920:EE_
X-Microsoft-Antispam-PRVS: <DM4PR10MB592084DCDCCDFF4D58E579EA8ED99@DM4PR10MB5920.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qj7ax8l564UCKNFyAJoZZjUFwOoVdrDY4qkgj+FzxLIZYRGefFGp01d2QfbK3JSk8fQ45j3D6AYPap6EgcS7WGZViLzqxSba/R0m+ddnfxTawMkrXx4ia/DZdm5+AigDf7HNk7pcpQDqM8sbydX7zzGbOsjE8mXkxL8rcwUiARVTiaoMFEifwtEvCtpui4B5KNt1aIPILTrEOoTsRTCJOiXBV3/58O+Tn6igbRAlgCFYjugaALq/2QI6D3AyPsaSSOVz0kqh3khbgX1ixCMBRd5NVaysUAB2yHb+TlWw+x0BNGIoPjx3zdjTumiM6y0bOYVEpbnm8C9/3whdqD98XLPh6oASPMhlETY2QydxzygfRURxQTvNBTaoUtUB+dVNBMJWe0lSFsDiZRnPs4G0GuqaTNrW9gtUWBUmvgFF2GKNAst6h1x3dVg2QMiVCUbStIPOarRNCi5PlWK+XmxANRg2XImUEnMoRoiVr/FxMEwxC4RMWoorffUlJgHfmsWGNWEYYc/UEFxtV0lvehqUvjjTsGedrKCoDzrMSUe/Bo5EaIbEssH4U2QpU8HvtNjCq9vbEdA9fdrLjMGJ5m3yggTsC9wQ+oCGK5mgRgPAihuVExMyC+I/0+YrFY07Y8H4Z6cSgK904JyUKY/n9XSnNA/V88oFqCiVtia8YQcqTKAqAqt1ifW5BmaEwPJWCcKWiZU9OUZyLL3h56rJYiWohRd8hWXj9Bhjr6mdznPggKsLSkqF2DYR88ax8P2PyhSIaRxW76IpQ8fYKzciQG2VJqM5K+bDdehceMApUt7qfzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(186003)(9686003)(6666004)(6512007)(6506007)(2906002)(5660300002)(33716001)(966005)(83380400001)(52116002)(26005)(53546011)(110136005)(8676002)(66946007)(66556008)(38100700002)(4326008)(33656002)(66476007)(316002)(54906003)(6486002)(86362001)(38350700002)(44832011)(7416002)(508600001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bTVA8zMbb4okW1Lw6+EvAKMKLQ0UtoFYCcLeZ6LH48yg92OesObbhHDfrNMj?=
 =?us-ascii?Q?ZcljuvWRFUpMH1xieuoDAJiTzZ1CSf18rJW6DY1NB0iav76Rtm4LSHIXX5N1?=
 =?us-ascii?Q?cjw+FBXdYbIkZtsFsOXYPq+X8+MJ0OMsjCZRBvVegdH6Hz/7PalYjj2YBCUE?=
 =?us-ascii?Q?OvNEvcV2/4pbfPzEQoYjNeguYo7BCFpKuca1LA/xX+LGdA6jN7gyguBXQOl7?=
 =?us-ascii?Q?XVddAADGVkZmn0i32ocjzLx2eh+OU8QlBxUC2Y8xh97tmT4303sfmmVm980Y?=
 =?us-ascii?Q?HuoL0UY5Or9wGNa9StaT+3fqEBO940E3+ejffwu1HJp9LVIoiQYwqqIf04jy?=
 =?us-ascii?Q?8OgzSI9QXdVukfDJYJW4meRyElvJX4wWy/g4SLal//DVQvBav2Mw6IXK6YqJ?=
 =?us-ascii?Q?aO4M/BLFP/0SIkD8TNoohm+9lmyv1Yr68OeWKm1DHbr68s0aTVZeROUPuaek?=
 =?us-ascii?Q?vzeCHT8pcIZx/TIM8OCPOZqZ5lCZIMJr7NIw1qQzMfwYt+JQ/S65BBHXucum?=
 =?us-ascii?Q?iMmX8OmjSo+HIRk+wZWbNdZ4O0XO2CjKioN/X4XUMVSRMndJ6wr4W8WKSanf?=
 =?us-ascii?Q?p8QjFxP4flgJjaLEe1V/mArLdrRfrqTiiLMhTL8o5gxS1fDsfA5N3Q1hjMv3?=
 =?us-ascii?Q?VtB3g8sCFP9SqaIQU42Gs7iQjXwRpf668hm1i8McRlFodAPBl9HObwCo+hyE?=
 =?us-ascii?Q?xPE0+YhR03NzOKkOCudJ8dPi/Yaa5GWB7PdISNAaRNNO9nCPlHreJZNcJOk/?=
 =?us-ascii?Q?KmM2REVV5CYToSTTCqUI8qQFC/yzMlvV45cE85jOWSOpZsf7jRu0rZkqaLIy?=
 =?us-ascii?Q?mtksFoU9BQ3stXuGmqI/EONTTzHY1otEEDS6GBi+tACA3GPpNMNJyJ6q0/c5?=
 =?us-ascii?Q?Jka20bYqETzPyT2FYlYlUNXRFkjODx8zcNDSb1ERn/qz5AtPB/J9Eov1cSeZ?=
 =?us-ascii?Q?aQ/i7LCG3zzYA3117xrcTGhpjx0CB4BGHEQzjm22lx6hdtAESMhMDffhkMFT?=
 =?us-ascii?Q?DNsCv2JJGvzPGB7v8Eix0Vz+uXpot5zmHtmR6AWRbbBpWiiQcRK8NjlcR1Eg?=
 =?us-ascii?Q?oNsa10PNIKkbAjnfqcle6WIZM7Yt9sFfsLgYElnJzNvk1sfdu5MtbJcHN7EI?=
 =?us-ascii?Q?v1zOCkx+W+3PgeC3lqU/F1tOiKjWhAQz1lEJ6pTyy7qOkmTQw6tQadqn8Lm6?=
 =?us-ascii?Q?4K/A/u74TFv2NR/3xdqxYCIDVJwdvCxl9QoOaS14B34JhQymGXjoopqjkdfO?=
 =?us-ascii?Q?aCKdKRjtL+qjRyjgv9ELKBBOSX/v1fcJS2WFe8VNLH264xmuOaXMd32JbNTv?=
 =?us-ascii?Q?ZLq0FZwGeuZ9BOAWVMlCiUjehjP/JYJOg11YDYk01wn5dxEvpDEHUbsJcKhZ?=
 =?us-ascii?Q?WrHZOfVOw0VOravm1EN5lpWLAvNVbieEbEh36p7IwoJpi2Id5+h6fLiVonxL?=
 =?us-ascii?Q?qTZdil/4dMernNfjcA4nd+n0Ycbzy+QM+M8inf3P4GElcu8Ovt9r+OEWf2j4?=
 =?us-ascii?Q?JUKyXV7U5jOlP92zqQgjV6DohD+ui/FzZOjSeviprBABM10wq9UyFtk8gl5y?=
 =?us-ascii?Q?LYCcDzHsn089V2nqxTW7Tg2XqFwVRPgohBaN82HS6ae8kz++uIK00e3+Z9tt?=
 =?us-ascii?Q?8K5nyUxsrw/00zStzsrg4EauePpcmLBtbRrnhM237Yxj95xL2gTWoTfWWTBs?=
 =?us-ascii?Q?vmTMx0V57otSXJZ1xFsP5lDXzFUMjud6kSHNVUs+XvdPcRVaBODFtbl15Y99?=
 =?us-ascii?Q?RFcjK8pAFEWFq+Jgk+XCKAmY792VdRU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa1a7a-2146-43aa-2361-08da3f48ec05
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 18:52:46.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UjYUCedJUGwBRAuyKco2DPDCIahwdoWBAi9Wnax+yuVjSZ6n/9kVlGRfM44wxWMVB8cQYlMqP7y7hRdJwQgHPkNzjXaTjWjxDN9jkPV0DRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5920
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-26_08:2022-05-25,2022-05-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205260088
X-Proofpoint-ORIG-GUID: cSKEUMNcMxDnh3hnJGIDxY3n2L0rbcNo
X-Proofpoint-GUID: cSKEUMNcMxDnh3hnJGIDxY3n2L0rbcNo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 26, 2022 at 08:31:10AM -0700, Yonghong Song wrote:
> 
> 
> On 5/26/22 3:24 AM, Dan Carpenter wrote:
> > The kvmalloc_array() function is safer because it has a check for
> > integer overflows.  These sizes come from the user and I was not
> > able to see any bounds checking so an integer overflow seems like a
> > realistic concern.
> > 
> > Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   kernel/trace/bpf_trace.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 10b157a6d73e..7a13e6ac6327 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2263,11 +2263,11 @@ static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32
> >   	int err = -ENOMEM;
> >   	unsigned int i;
> > -	syms = kvmalloc(cnt * sizeof(*syms), GFP_KERNEL);
> > +	syms = kvmalloc_array(cnt, sizeof(*syms), GFP_KERNEL);
> >   	if (!syms)
> >   		goto error;
> > -	buf = kvmalloc(cnt * KSYM_NAME_LEN, GFP_KERNEL);
> > +	buf = kvmalloc_array(cnt, KSYM_NAME_LEN, GFP_KERNEL);
> >   	if (!buf)
> >   		goto error;
> > @@ -2464,7 +2464,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> 
> For this part of change, there is a similar pending patch here:
> https://lore.kernel.org/bpf/399e634781822329e856103cddba975f58f0498c.1652982525.git.esyr@redhat.com/
> which waits for further review. That patch tries to detect the overflow
> explicitly to avoid possible kernel dmesg warnings. (See function
> kvmalloc_node()).

That patch doesn't apply any more.

Static checkers will insist that kvmalloc_array() is cleaner and safer
than kvmalloc(n * size, and they don't care if the integer overflow is
real or not.

-EOVERFLOW is the wrong error code.  Just return -ENOMEM.  Checking for
size > INT_MAX is ugly.  Use a correct limit based on what the maximum
reasonable size is.  Or if we only want to prevent the stack dump then
just pass __GFP_NOWARN.

It annoyed me that size was type unsigned int.  Sizes should be unsigned
long.  Every alloc() function takes an unsigned long so using a u32
temporary value for the size is what made this code so dangerous.  If
it had been:

	addrs = kvmalloc(cnt * sizeof(*addrs), GFP_KERNEL);

instead of:

	size = cnt * sizeof(*addrs);
	addrs = kvmalloc(size, GFP_KERNEL);

Then the integer overflow bug would only have affected 32 bit systems
and those are pretty rare.  Choosing the wrong type took a minor bug and
made it affect everyone.

regards,
dan carpenter

