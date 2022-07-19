Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AB257A5C7
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiGSRv1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiGSRv0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:51:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA3D550EA;
        Tue, 19 Jul 2022 10:51:24 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGu6j9030727;
        Tue, 19 Jul 2022 17:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=Q43j1niAnzjRnowVAiZNqbNStgZ3gEnW1uh9rk3OSwg=;
 b=BBJElkgEzm/+ZitkRSUzPh9mvbcYxtGabymfVxUr1MufcVhNa5N59PAb8idbC9FDQQXW
 Sj6FQmLCrW26PlATfXh+AagiSaiQpQIelbl3fiH8vMwZJtelRNCiomGdtcdnVFdm7ctK
 YNoRuHYY7wza5CvEDqPq3gzWPDcu62Ego4kQoHa0pLxMpS4uejPMGYNnLHGoD5o2NGco
 tFdQsdNGdHH7wBa95cpo+rxfAuCkk1Z/esiWUctt0aJ9m/RDej+1HQq8KLf0521Knp5t
 TFeaBiZxnzl4GwFa2ZiEuc66wIJHzaVGPj06emqVvFlPCd+xZkE0PMypmlP7pU2ioU0q PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc75r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:51:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JHk4Uf002688;
        Tue, 19 Jul 2022 17:51:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbc699-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee2L8eVK9ckeF/pHw98yRNdBj28Bw6l0anXSqVnILJ49ODu29Z3nRPvFJY1NftDGs082HEgJie/ZfqPvhfkhH6Ppmkx4azB8eiuWESe8od2JidsF5nIMF7vXNTZzrHc5BSSwa/xWd2TZYlX7QMUx/G7H7DloXb2Us1MNT+At74PEAPBx2XCuPw9fb84LZMAFvP3aySQEsYWs5wa+dFQHysGDZgIa5ijjZp2EndXAkibCqOyWOTX6U8JURcqWdEqkW+36gxMxIyeJcgG4KxAQ2Zcpp1r6GTe87XE0Hen7vQva2FZEOwBuqAtVaUxYl58lVg0PlkrM0YpDeOOJdxL1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q43j1niAnzjRnowVAiZNqbNStgZ3gEnW1uh9rk3OSwg=;
 b=Vk1RbOhKS4Y15N7ID23vgDSathkW38/p3sFmqk6ItYBRhNgUFfLiabccBSonZ3soFvc8yTrxn5gz6z73f4rg/dxGMvum5gxTGPIFdGevBaWjMa+xWVANC27ATd7WECFH4adV1F3Xd257LT/BIMfqKj2xu1bJXkD85FffKhaDxvdnjcGRnofFo3W7b1b1QezGivv748F7Q3dgzN0wj3JzdFL0oGbWNjZb0tQEq4tyAvdtqdRCDV9KKyONeVVq9soRi3qE+nHge2qQO0CMkAx1s1ZERvoQTWG6KD65SRZtruImoCh6n2J7FCoNri+z4PFf9vgvdZmRMJFu21PI1gjLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q43j1niAnzjRnowVAiZNqbNStgZ3gEnW1uh9rk3OSwg=;
 b=ql6ViO8JDwkNx/blQNfyr2VJs7C3jwINjElOZCaHUneyjbRLTnDAk+H1Ea5loKmRYkbzuubz7LsNUyhvleGYWjKxKmYNnf3cK0EKR5w61tZtHW4p6RJJ0DCgIWAFpFHDkrB0f/uXyG55KsPxSmTF0kds6jHqtA6A1vJYwsA6ESc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3101.namprd10.prod.outlook.com
 (2603:10b6:208:121::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Tue, 19 Jul
 2022 17:51:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:51:00 +0000
Date:   Tue, 19 Jul 2022 20:50:48 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix str_has_sfx()
Message-ID: <20220719175048.GC2316@kadam>
References: <YtZ+/dAA195d99ak@kili>
 <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719171902.37gvquchuwf5e4gh@kafai-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0167.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::8) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f14d2d5-281d-4614-2895-08da69af3de3
X-MS-TrafficTypeDiagnostic: MN2PR10MB3101:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+4jQy0iN4bvdL0fV9TWpcXJCoBgMLmqQ5kMs3HQdK4k3af4IMq1+fTFnF7TK3mhAXrOHEUbq8P3IgUk77o6ow8NZ8LG3Uz6RXZlBG64w2Jd3JVuQi68IblxcVifZcogIyzTMT277pD1NIYsmZ+j5h8AQlsLHb7N7/lelfbuam8r5toLl9wpBNc7TDpyzS688s8/EJARadMiMH4iKt+YMS4q29+p/MyTkZ4RgJmZOtjeJ7nV/tdyG3qyE6Xf0X3NGtipwDcw9bwHb8f+82qW1vehncCe5Hy4qkttUDidm2FU2jH4sgCHU2ybp68qb97/MiJQq5u7ofbbqL8n9699QCVw/i5jCjBrdNTuRxOXK84EXlfOTHEmE8hYEsQh+V6LnyY4a0+dl2JVSbCnSxxc2wrHlPl28fZHWsA1pUU1nd+Qg+Xtwyvlr2xEa32D38LQPhcfbfkqv/JrqK0bJQbEfXIStS85bejMnBkXjOXKSNVGqnFkUky+C0vCc2qV9FP558guZrZCGLUipuyaxHs8fKqMiGaQ8ZcR4xaXCDiKj4zZKI02wDyC2z7rKNOqERId5EVJVz1lP5J3q7/Y/WXOUaSXl7Lu7+1stHb1vrW3E3UyaPfYydSd1uj22cXYH3340plTzZriLEA28i74f7OMtvHfVOIKYkqmBY6VdRWiLBLOYdiOLCIhyrC3Sqw5VN9yqXo9zxPm3u8TPeaBbuk7HbjSoosQczqPAeLRGyyfH2Dc0FmDm0PACH2iRK9F4ak0uJx9r1zBkbq0toV66HW6h4m2LmOe1nWgDDVz7x7x/lA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(9686003)(83380400001)(66476007)(6512007)(1076003)(186003)(38100700002)(38350700002)(7416002)(5660300002)(8936002)(4744005)(44832011)(33716001)(2906002)(478600001)(6486002)(6506007)(52116002)(26005)(41300700001)(6666004)(86362001)(4326008)(66946007)(66556008)(54906003)(8676002)(6916009)(316002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JuuoPA+DYtQL7fubbVw0QCK+pL4B7QpXy4/qsnl74CSL1GYVhYJmY0LIj9QO?=
 =?us-ascii?Q?CMLuGp9/ym9Bijs8vNvD367Qnxl/xLbgHOd6/KXk5PbXInrSVnfFq2WZNUys?=
 =?us-ascii?Q?cgWazPX1a6DcVJIY6scCL7KxbDLOvUS06GEiqOJHk0zZ4jRPbGKVEO/z44Rb?=
 =?us-ascii?Q?uPQ6nlrAYPQMsCgdiMP5akc/QFqhRVlkv9AR+xkb3b03+pAa07p/TezFGFyA?=
 =?us-ascii?Q?8jXhSMINoOyz34yyCMMTD7xS1wRSn6jDkOOEzEhcTPzgWafHWtzR52r0Ud8I?=
 =?us-ascii?Q?usH9rHvaaArmWn9R6rIDW+bz62EXI1dIUKYewRWEsl4UZLfjCRlWLmwXtgGf?=
 =?us-ascii?Q?XgZ7Qp1pj+NTGGH/8yC/FBP6OSby/AneBFHtZdbdAd4VkXDk+fKByG9UmKdi?=
 =?us-ascii?Q?clcpHaErAm6UJ6ps8rjv9Zk2rbzSnoy1PTSJWkWuvJPJhcF23DbA5PidWKKc?=
 =?us-ascii?Q?/NeHR8hxqqDJvfthV7Ch4/xTIApB/To4HGGMqhFula+r49pB0lFnr4sfFjo1?=
 =?us-ascii?Q?ldY0C12XRRtrRmOZWIOD6RgLCwde/LxFhy0IS43HuISY/P1C9+hhNjubFHFp?=
 =?us-ascii?Q?w5Ni5ITlJVqFkCfYD27xcF8D0O1w/WKhmdXSwlU/1HQla047kx/ZBKpseyre?=
 =?us-ascii?Q?O4MEWG8sbDHAXlw5xCZHFUj6RcSQmm2kJkwinj4PEFdyx/rD14yefdO2eaG7?=
 =?us-ascii?Q?sAW7X70CSZ393bVzIQrPxgPVJGmT41D9ONUyz3PBo3SRIbKbRbL0M2hQiNrq?=
 =?us-ascii?Q?sJYfx3WiTuG5ys4ANudWabzFkERRab10rJS1G68VYh/KnmTvFfxNDSp8rRln?=
 =?us-ascii?Q?Hw9PjoE3gR0mh1Igb4Jwj1ooI0En+7SOafXyvwDuZW0joZKx/DhLRquz1jmL?=
 =?us-ascii?Q?gsKA7hZ/f/TgrMcY5MLnWa48Ndd02HiCpAaH5pcIar8kg1jLgcPSgeuyxus3?=
 =?us-ascii?Q?sJvLWpS71SsULrocVjTxBu1AtNMyObDTlXoTp457V56zK8+fr4cg95YaQtwV?=
 =?us-ascii?Q?yJ3fCvUFh1dKMaZ7c+BW5j0PYrewFYxh0PhpXmEX/YGUMteJtxneDBnY8jIz?=
 =?us-ascii?Q?ObTE4qm/qgsxAoMYq3qwsmRBu43AIWmQb6ZI9w3MxyuMSgSeDcQ2nbPLW2gS?=
 =?us-ascii?Q?574AWaSaS/LJ7UtmYW7HN6g6cRH63zyuLPFHeSbu+IBOaIiJur5gP9ASXKId?=
 =?us-ascii?Q?cV74RWLgOSvjRfcEgPMB6ti7R19693zLocnbhq33+3+v4CTxbOYLxP2YpTXd?=
 =?us-ascii?Q?UoBHpr6cDyeQqic9jK7/KlzIlhRneXmhTXTbX7KcJMSlqAaoI48nC2NGO7e/?=
 =?us-ascii?Q?FT1kiEQWEKAgVS3JNjKVFcCtCsTbDUgmOgEkaSTAYKjxEp1i+BLVBmIcPQ6J?=
 =?us-ascii?Q?CEMeZlXu9U+tadV30NLx42oV31HsUumw/4LjpaUFKiVwzkGZLO9qcWAUNhRv?=
 =?us-ascii?Q?lsjwhDXYfGpX+sAL6lB32d/nEAj601tbBm5oWOXwt8zK9H2Hca1VcT6bR+RX?=
 =?us-ascii?Q?b4y0TpaTA/IIv4TCBWw/2nyZF+hWxssVc99YD4orgc2ufsZJ1W5wY9ZX/All?=
 =?us-ascii?Q?IcRXgs71Olp6FzznS/aNYenlVg0mR/+nD/kKZFq2HHtIBxbyCnzjvfdoLYcV?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f14d2d5-281d-4614-2895-08da69af3de3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:51:00.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cBaGicH3ICCT64hRKF4+HS1+xPOkcpGxTRIJ0hZhhJZr4/sSqZOJoEbNBoimKVgX8m6aS3c/QuZJsvROHoPgJBB2kxoFF3K5/2/Gdh2NTPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_06,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=931 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190075
X-Proofpoint-GUID: Nl3DBX1jq0bQk4PuiiVVP-UAIzSuFYjh
X-Proofpoint-ORIG-GUID: Nl3DBX1jq0bQk4PuiiVVP-UAIzSuFYjh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 10:19:02AM -0700, Martin KaFai Lau wrote:
> > @@ -108,9 +108,9 @@ static inline bool str_has_sfx(const char *str, const char *sfx)
> >  	size_t str_len = strlen(str);
> >  	size_t sfx_len = strlen(sfx);
> >  
> > -	if (sfx_len <= str_len)
> > -		return strcmp(str + str_len - sfx_len, sfx);
> > -	return false;
> > +	if (sfx_len > str_len)
> > +		return false;
> > +	return strcmp(str + str_len - sfx_len, sfx) == 0;
> Please tag the subject with "bpf" next time.

I always work against linux-next.  Would it help if I put that in the
subject?

Otherwise I don't have a way to figure this stuff out.  I kind of know
networking tree but not 100% and that is a massive pain in the butt.
Until there is an automated way that then those kind of requests are
not reasonable.

regards,
dan carpenter


