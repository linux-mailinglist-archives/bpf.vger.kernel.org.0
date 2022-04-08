Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942794F97CA
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 16:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiDHOTP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiDHOTO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 10:19:14 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468EB17A8D
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 07:17:10 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 238Cu2OS012558;
        Fri, 8 Apr 2022 14:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=LbJq8T1IK02og1uhQnLOXS52k4uvrxoA5ELfoVFK76A=;
 b=JFJRKvFa6IlrXrQJzQLViNlT8aSBW+RZGOOcmCHnkDJmG2MJgBzMB0JtAuAmqeldTz3e
 yCUdi7a9FNyscE7fB8gqI5G016tUl2McIhf7Kp0ApTrl3PP67Q86DvkrFZn7o/IAB77X
 6YWDwcLw2gnt/EpP/CGE3F2d1q9paqMqzcA1FCeX0IwKBTYBmCKNuPEKDp6xoXoFOrQq
 x7UIYp5tGb1oPrCi2wTY6afSl7e62RUptccMgeO2uOAbkleeLv1BYnoUq4Kj+U8welyb
 bsNWvDWgMIQQcjBjq+ojK6mtUtXEbwIg+BtuPl2Oc5zp21Ht6Z7WaLiJdUKA0DgwLuzW qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcps49-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 14:16:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 238DVGfA033911;
        Fri, 8 Apr 2022 14:16:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974fcwrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 14:16:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAKibnEEN3evq+/YbR5A5NnC7RGFf4cwiHkD5gl0bkpCmGFNfHL3sJJizIuc7XUU2vXe8PmqefRfScAg0CgnXvzn8sGzoCTj380RYNap+mfSOrvmwkL5ujmMDhDkVv9V0mkdmXb17p4s1AoeQPlXOikEUHJ4P/pqou5rCTQtmBe165uxtCcEFOovabRsdLIDBeIHzdG/mCn/0suqt24GSA/EibWlhIp/C79Xek9LB9XHOkQfB3hgf17E+DGKaRPR6Q9tdIE+zXUCsBJZ3BsHLxtHLGANCp19doTqnyKsoWMh4kYI33OU9XSiV029RZAkTxU6O/aKYQbzDJE+x5BI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbJq8T1IK02og1uhQnLOXS52k4uvrxoA5ELfoVFK76A=;
 b=GN6f78OFE86LyLFGSDaoCKLTPfhjNQt5+q3mOsEPOPeUohqq0SAKJEGr4xTySooUFWBQtJG0LzJovBVc1OLNJhGS42iOdbnpVCaWlqLjqw5jYoQx6Qd/9MVfQ5uQQ4HdGDpqB/n9aLTIvbxQ2nJyQkUUlCqrVaZLbu5MmzgTLKAPXJy2PNtJ7CF34fXhmvGQ7ZlSbr08hGVejOag6+xD5T9XpxTUCCiBhbrIVv4BooXTRpip5VemLbTAKzRYf0F7cw55IXHL6LKw/Oh2aVYqHjjXkl8B64Yb6xvc9Y5qhKDfve9tl6V9/qdOkvwjbRTvn6pVeCZFG1fJGL2x1p5joA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbJq8T1IK02og1uhQnLOXS52k4uvrxoA5ELfoVFK76A=;
 b=emTNSyOJNl8zUX3RAhyaafa0bPkRW0YuLF/nV0oJ6nrDCM91eSq2cbb5KyuRxg/l1Ae56ug2i+DtKXtUNe1OzgWhlA3t0X7sqEwOPGhbvWU2YWh+chsOwhDrsv4PB3r0sqTpLa27glLql4iMWBuFy1BQNfH9jwx+nAhVtVirsCY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 14:16:47 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::bc05:7970:d543:fd52]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::bc05:7970:d543:fd52%4]) with mapi id 15.20.5144.026; Fri, 8 Apr 2022
 14:16:47 +0000
Date:   Fri, 8 Apr 2022 15:16:31 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
In-Reply-To: <CAEf4BzYJixpYpg4MUxETPVbCrUrZYbn==-UYgVh1z5MWx1TV+w@mail.gmail.com>
Message-ID: <alpine.LRH.2.23.451.2204081515040.17700@MyRouter>
References: <20220404234202.331384-1-andrii@kernel.org> <20220404234202.331384-6-andrii@kernel.org> <CAEf4BzbETp3S4-HebGBNjFm1fCCAuytSqTp=SNXgXFSqsgCQOQ@mail.gmail.com> <034e57e04eeb7dab4bad4fa674ab337a5534cbdc.camel@linux.ibm.com>
 <CAEf4BzYJixpYpg4MUxETPVbCrUrZYbn==-UYgVh1z5MWx1TV+w@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b338f69-9ec1-49de-5878-08da196a6a13
X-MS-TrafficTypeDiagnostic: CH0PR10MB4972:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4972CDB31775A8785C3FC1E1EFE99@CH0PR10MB4972.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JclRqKbls8w4hlqyvlaVeTxolkxZxtXKuwK2D2wbg/l9VaAQ7rUNFkC0UQb822UCYMrlfW8bumWtFHG3EmUqCjs3EGpwl0Fbw8r1WRNfeYU3bM8thQc1xb+5NK1kTfFdu7744N+bSb2MnQSoRE376Ftc1szGYWtykaIjoq5lxiFJ+8lf2AzBWzru2u5j2H4TL6IQ5LL17JzCHheFwLtph3yJTv8Du1DIHIT6bhFYJ1MexFDIsE3fs6ye0/9VZEksRlEN4HkAXYsJvgyvQcmdO/DWxSIpOx5pQyl/du5cBi0FqFszvtchWdnbIYjqpnDjBoDQ+cRZPr9XCiARobmCQSO+8EOAhI4SAC1hSNjKm/mnG9FW+zs5Eh36ioXlbD5F0sM/N5wuuA5/kwZy3aTz+M1izyk5Al2deDzNkBgl1MAaKlrA/5dG7s/elFpjEbQBRMoKdWBu4T+LF0mQx2l77joDmiOtshgdX8ZKCH3D02IfyilLBsJE6A61rp1OoDWLedijiGJ5rN+/+kRWSg7k9FVsHHhgfoEx5HFDvAGg2UlNyeIk+VJBEUTkhsMCRJN9NTW2paPyjWqZO4r2F/KnMT9ool3vY49Sni9fUmlCmZucFwaDQsaK6MCxq7GryrKGPitVeAdkupfkJ1c+Rq7xbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(6916009)(54906003)(83380400001)(6486002)(508600001)(6512007)(53546011)(316002)(9686003)(6506007)(86362001)(33716001)(52116002)(6666004)(8936002)(5660300002)(4326008)(38100700002)(66556008)(66946007)(8676002)(66476007)(44832011)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?261UALt7aXoEEdhGunYyleUQelI3uOR+m1mvQkSeUB4EuWzqOAXxQG3AaeqD?=
 =?us-ascii?Q?XbL9Q7ZSsMnnbbwbmW55HD23YrV/hhi/Ul+tNnwdSXu8fsx86DP7ELd4Gk5L?=
 =?us-ascii?Q?lANISHQwNHjh+dOQWbk6fxJIaJULZT4bL1S+18nBsVgsPGanHE1PxLsfuFSd?=
 =?us-ascii?Q?YEFHuxMa01LftQsE6rdFGTL+e4xbqOf8qGsDQLFhjEAzVFccXsZU12qejbz7?=
 =?us-ascii?Q?3vxeFpFfPjuBBbpH982TmaGy0QCIpOTuvnOPJz7WpVkzhcRbCORvfu7lVUQ8?=
 =?us-ascii?Q?wi4y3Alu3la/eSs+ZdWtsUkhMR9uHQ6qahgxjZF4rUpPhqztMcPi40PRLlhK?=
 =?us-ascii?Q?DB7gkz2wjj6Us+QqfR0VibYuZvrkV6XhAx6bdNyCflfhtm4nCck70plgVtR5?=
 =?us-ascii?Q?jxLCp7gr7Sggz20uwsflTfXN1xcovCS/myodC5MgDlcFnFOf4GsFHtCNnsqN?=
 =?us-ascii?Q?4mxDryWk5UcqZ7gYnjbUNqq41R19HoBiR+o0RZf385IaJdl1TFag9BmzDeR6?=
 =?us-ascii?Q?Cg+0+4PXpX31X52PDIFSi7sFW/mT0w8Pv7xUyXoD8dl6I19GwW69R52EEYRZ?=
 =?us-ascii?Q?Ed27Gu7gjEUduGaC0RLNuOCA265nSLgu/0b7+ZQtKD9hvGVLBqqX0bbbmrsV?=
 =?us-ascii?Q?zE9sOrIjnxpGo4pPwjSktYA7zHg/99b29Wh2PuejovENZgzOVaJJYcEwtPfJ?=
 =?us-ascii?Q?Ik+z3aESe3+Wcf/qWWzKbolTzLH2sUC1XRXIi7kG6Shsow4OYG3byCJhhmMI?=
 =?us-ascii?Q?T9mz/Cnns9uzDKq5wqH3Il3DGuDwsVwBtk4nvBi4zUGEMgQ3VQVi3DGcztcQ?=
 =?us-ascii?Q?YAuv2J1fg+5bSLI8lX2UZV4OlkbDfik9KblJ7dXz2acLiL2JXn7DIIzbEnHK?=
 =?us-ascii?Q?4mewOkma7kVZRrtCBTn+paoz4Alrez1wYMXUaiFzii/HGP1sEVHnhreu1ISQ?=
 =?us-ascii?Q?vVQkY0UB/oqoINrcg3fDwkPe+3x/DjYU38d+CZ27VyW6enWxTTC14hvPn1vc?=
 =?us-ascii?Q?a9QnT0y6NTa2Cq9oUSQDaMkOftA6AUi7ZVvqlANxpw/dpiPUagPu/hCwb+tA?=
 =?us-ascii?Q?OT/1TtlBQd+clSKfdhra56aB5fE/I1v8q0shmElTdEp6Vc9rBiHf6tW6xXdd?=
 =?us-ascii?Q?OUFNyJTnWoWksaCerWrI4t7Lr0rQQNFCOmgw1mvEW2GRn839KHPKu5t4ORhG?=
 =?us-ascii?Q?NwRFLzFNY4F40sRpx+wLz5RQQgZX1H29RSGvirl4ZoymDwk5RLVT+N2ZNfL3?=
 =?us-ascii?Q?VzMePtgJw6u24BGx9dwyG28UsGuKDTH7zm4a2flsAqPvevDP7lOsvZzPyIkp?=
 =?us-ascii?Q?slgJUjLpMJCGLw7GFkEukm7tiCe9oMpILI6eWqubyKV0UZaZ6QMD05iQsbKz?=
 =?us-ascii?Q?TT7rpMx+saB6T0+c4wD/ELuYkXlxiCVFaHnMqgccDnp2ATGxjMVfjhtq+xRF?=
 =?us-ascii?Q?cwhCOIY4fkTDpS87qNgrF9lCBkf2ArIHPS/Vra2+bgzi3fmKfHy0p/l2cD2L?=
 =?us-ascii?Q?iYTdmECXJy3vGeAYSwHaSdaqO4rwd7O7hpdLJWA7RT6Og2UzFp43zYI18mQ9?=
 =?us-ascii?Q?mqJGfp5y0q3tlQ9IJ0lJsFZ/3W3f+6/XWRtJaGn82MrDeTmsPXgRbSBbeLsT?=
 =?us-ascii?Q?yxV9tvlQIWuUz5kdSqaSdekkTBXMUOMPwLJgC5c5b8Kf43Huyg660Ul4skCQ?=
 =?us-ascii?Q?L/IbvCq+4XTuAtWQNk9V2O5RsOneguEm5o7uL6rArQQMjtTLB8T0AiUrci+K?=
 =?us-ascii?Q?+aCB0hNT9ohc7vTA2iAvmPLTijjEEnBmEORQvF39khLHq8YUCvct?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b338f69-9ec1-49de-5878-08da196a6a13
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 14:16:47.0910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sqacli1H79JLj3Vh7rXlsJ5aTr3lPpgNzIlEE9rkLV73E+zPVcK6TqNGu6xurK0M44d3YnsLCb9KRX6m3lk89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-08_04:2022-04-08,2022-04-08 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204080058
X-Proofpoint-ORIG-GUID: v5ymGwT6IwvPMQMgg9885zbd47DGaLCI
X-Proofpoint-GUID: v5ymGwT6IwvPMQMgg9885zbd47DGaLCI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 6 Apr 2022, Andrii Nakryiko wrote:

> On Wed, Apr 6, 2022 at 3:49 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On Wed, 2022-04-06 at 10:23 -0700, Andrii Nakryiko wrote:
> > > On Mon, Apr 4, 2022 at 4:42 PM Andrii Nakryiko <andrii@kernel.org>
> > > wrote:
> > > >
> > > > Add x86/x86_64-specific USDT argument specification parsing. Each
> > > > architecture will require their own logic, as all this is arch-
> > > > specific
> > > > assembly-based notation. Architectures that libbpf doesn't support
> > > > for
> > > > USDTs will pr_warn() with specific error and return -ENOTSUP.
> > > >
> > > > We use sscanf() as a very powerful and easy to use string parser.
> > > > Those
> > > > spaces in sscanf's format string mean "skip any whitespaces", which
> > > > is
> > > > pretty nifty (and somewhat little known) feature.
> > > >
> > > > All this was tested on little-endian architecture, so bit shifts
> > > > are
> > > > probably off on big-endian, which our CI will hopefully prove.
> > > >
> > > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > > Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > >
> > > Ilya, would you be interested in implementing at least some limited
> > > support of USDT parameters for s390x? It would be good to have
> > > big-endian platform supported and tested. aarch64 would be nice as
> > > well, but I'm not sure who's the expert on that to help with.
> >

I'm definitely not the expert, but I've got aarch64 arg parsing working
and all usdt tests pass - I'll submit once Ilya's s390x patches land.

Alan
