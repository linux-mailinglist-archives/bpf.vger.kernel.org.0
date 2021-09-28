Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0ED41A47D
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 03:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbhI1BLc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Sep 2021 21:11:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6824 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229942AbhI1BLb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Sep 2021 21:11:31 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RMxbsg006962;
        Mon, 27 Sep 2021 18:09:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=aZ7chfOUWnlSVsshClIh6qNqGNBl9swpbMyir00Q1Ls=;
 b=Qtk3vcrJ0lZLPBU6iZoX0MNQ37gtYR0ARRWaBNiqhmxqJvqJ/GxX6BlO1ktZofYK1AF4
 7kT6xL6LpJf4zqkJh9+tkjVLM5TAeUsjWM6vaOUty33cyyUclcfykFZRb9alMxMVV/aO
 pD29sEnZwwFycyyPj15euOnT+1fIjkW8lIU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3bbq81rmcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 27 Sep 2021 18:09:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 27 Sep 2021 18:09:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB0xa8cT/gtjqGclq7seGrPuxm7c6nKEOyI6KrWVmoJCjI/UZ0/mxLzT1rGnGQ+s1c+biKwT4mo0U0lKEloVPUGaE8YBl1kTGmSOb4mIWT3Vd+4Dx+NOW6znIjeAqgqXIAuFJddK06dlZS/dhtetIcAMitPOG8MmpZqUoEfEahMDS293AcCsSS7tzpvelRycpemWrz1uG3ZUW5Kb/r28XTf5mebmnn0KpbArlBQB8ypJZ0VAesh1tPalv/xXnS+bDAxrDfL3jK8oxoRGmZFX3jlxoNYxjvZdCRo0tZwa3mxJiwUHEDK0jUZgH8aOKvRG6gUfBRUZLCoyynbhEThPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=aZ7chfOUWnlSVsshClIh6qNqGNBl9swpbMyir00Q1Ls=;
 b=RNUpLhm3ZArAH8B9BwF7FWWtrupxUkZJdnm8rMVM/9Rx6mqhEp6hy3aS39vShL39lVhsaPBlT+D4KC/Fx9P5qJzZPGqpRkb9ju4ejXg/FN3b+ENy8Y9vLm6EGhz3QoREbTcZXTjyzuafyGphsnyJ/E+hEifJ62uj3rRfTrAvR07ke1UVbh3kD55DiV6wWv7xed6z/v9hZLcHCGJQTPhiJt2OP+KSDe0lmjw+9Zi8M/f8RrAwEqJaJlN6t3lOdFl0ibT5ETWRwK1k2aH43z1/iDxr+tCy+Ya8Sdg656mRNHJ72NDnrSnitJYxEaVBBlYR57fvN9RYLFEg/KRj3y6mNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by SA1PR15MB4772.namprd15.prod.outlook.com (2603:10b6:806:19d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 28 Sep
 2021 01:09:48 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::6c34:bcb:51af:6160%8]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 01:09:48 +0000
Date:   Mon, 27 Sep 2021 18:09:46 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Joanne Koong <joannekoong@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/5] bpf: Add bloom filter map implementation
Message-ID: <20210928010946.lrmwfhxopwv6i5ne@kafai-mbp>
References: <CAEf4BzaQ42NTx9tcP43N-+SkXbFin9U+jSVy6HAmO8e+Cci5Dw@mail.gmail.com>
 <20210923012849.qfgammwxxcd47fgn@kafai-mbp.dhcp.thefacebook.com>
 <CAEf4BzYstaeBBOPsA+stMOmZ+oBh384E2sY7P8GOtsZFfN=g0w@mail.gmail.com>
 <20210923194233.og5pamu6g7xfnsmp@kafai-mbp>
 <20210923203046.a3fsogdl37mw56kp@ast-mbp>
 <CAEf4BzZJLFxD=v-NvX+MUjrtJHnO9H1C66ymgWFO-ZM39UBonA@mail.gmail.com>
 <7957a053-8b98-1e09-26c8-882df6920e6e@fb.com>
 <CAEf4BzYx22q5HFEqQ6q5Y0LcambUBDb+-YggbwiLDU86QBYvWA@mail.gmail.com>
 <118c7f22-f710-581f-b87e-ee07aced429a@fb.com>
 <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAEf4BzZ1BXyTWmLpfqoGOms02_bwQDgBgEd9LkUM_+uDZJo1Og@mail.gmail.com>
X-ClientProxiedBy: BYAPR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:40::27) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
Received: from kafai-mbp (2620:10d:c090:400::5:fd53) by BYAPR04CA0014.namprd04.prod.outlook.com (2603:10b6:a03:40::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Tue, 28 Sep 2021 01:09:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff808a11-2809-4049-9e6c-08d9821caaaf
X-MS-TrafficTypeDiagnostic: SA1PR15MB4772:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB477223F3DF0EF8525F0065EAD5A89@SA1PR15MB4772.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zaI1fmTaBf3Uo0ZoRlBu2EoHiVBMJ2ZtMERGJj2JxgHQKFw4yyN+7QKL2BHks+DbGWX1+5dQkgCuY8gLLWm83ithtTPt8mjEYGmNZC7MNL9tlOvHdcAlCIe2oEIRnUm8W02BZoN8QCoa2H+X2s8nrD65TXAjcLlsb1XuVWLWrrZ2DLh32BZXPuE5staoU15nldBHiihDrQkJyKK8qHyFyBNDPsaCEwkjhqoyVsNaiUrt03M00qm0dYAShZLKE+eZXqao7M11pMfMW36BK8dEkT5I/eSmvNMfQmLPc5cSthu5D6Yu/Sqe7R1p/gij2sPX1bqoOtkAhVDMR1446tY+5/xO1nffo3Pd7+xFpZA4DQmco05A8H2TYv4nGkv2LycOGzVtOUoZGC98gFjZT79pz8rsDSmLMjFGbMPDRtWHv8RrYTs9C9DtAuWFYtZs7VW59wFbO0EhXRufiGh8L8V2k3mvch3Rwv0BPVY8WAjWTgiCs+UOmUOXgdgDrnrPc5WfG9i2jKkUc0CGrEfqPZldXW4QxOGHPx6r+qOwvrQDQFxk7hPidahdG6UwXj2YVH8TsFlA5YJndVYO5hz+foEBq2t9HQYtQ3Yemrl/F9GSK+Zm3tKLw1jMfvA6zEGHXV135iKNB/K1K6V+NS8ZXc8thA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(8936002)(4326008)(38100700002)(66556008)(66476007)(6496006)(508600001)(66946007)(54906003)(8676002)(33716001)(55016002)(9686003)(86362001)(316002)(6916009)(1076003)(186003)(5660300002)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/clKPAftlkRvcr/NDRDSXelENncKwudR9sefbRt4w1GegTRnQz/Q1CSY+0dE?=
 =?us-ascii?Q?OiWMjq4BXM2iFHUZCrDdVMusU3SEmB9qAUo7Skyme1j3yNKHRZiRFIZYPGU8?=
 =?us-ascii?Q?ZF2j6rMZZviQk7/Orn/c5snF/aNpt76OYe0QtIWx03DaqgG6JMOtoYDTwBvo?=
 =?us-ascii?Q?isdIYfwB098P08UvV5xRipqKvInFhEjxBN1Ng/9IE+Pvi9vMFsehBO7zBwQa?=
 =?us-ascii?Q?NdvWvxAzCtgRbN6Uj1eatSxBcvs2ucRNVpqk4qWMfdbadqQPDUt8xVkqSzyT?=
 =?us-ascii?Q?zyXwynpV13o5GjpdzDFYYYqpqCrqMndvhvX/ZdE9c/x22BbEutUJAa8ksvDP?=
 =?us-ascii?Q?5HdI5EcMskNyN/R+hJitMwVnezOh/BcX6yz1wDjP45W9009TpPW1arD6kyiQ?=
 =?us-ascii?Q?GHU8ZsBw1wuB6PK+3evCg3rrBkeX8UpiIHfBxr4PHIKCsPZJDkkfWJxPhRBq?=
 =?us-ascii?Q?AW4cAxF7w/OP1caLaME7NWcT+UVomOEsQ0IaKxl5xiAgE0bT9FnpcAlPy3cF?=
 =?us-ascii?Q?xAQgn6wApaQx1OMNmIYiPhKTev3qrR8V/qisGcqM8fqAmZ1OtjSqfKmFDhDb?=
 =?us-ascii?Q?99VuHK5/g791VisXOSNWkyfn+Tzpjnj4KRo6hkDzZOlWRtSBBc/KveBMfECX?=
 =?us-ascii?Q?xQtyFWha8ga0G93EL4vtbFROQvusJb4cliiGMnnEsVrAAyn36I5dWMW71ybj?=
 =?us-ascii?Q?5onUjPGou8Yqlj5UycpNQtv75qywuFEJxQ3OqVr3H8Onb5QLEwP7byyYCQcc?=
 =?us-ascii?Q?cvIPoNbBzeDxXbJxGYqJmNJx5a4LA1KK+n6GALTbh5wayjULfW6VE76dgEFi?=
 =?us-ascii?Q?SSvDp9XC4dz02VCu9Hya9COqPsCQQT2vvVhVo5WlqNQy/ZfPUY9fALfX4ilH?=
 =?us-ascii?Q?jj9QWzfEwhUnRAerlE6HBt13s9RqkFM6HO5Vrc0unV9o+8eiAGP4kOs4O3nC?=
 =?us-ascii?Q?nkCSsYYOZosnbSyIelrkLqE6Zkg+grb6uKvrMf7Tt1lDWY4AuGx7frJVwyYd?=
 =?us-ascii?Q?4A8fucEFIaK+ZjuBKN5XMxp3sELyNRqI8Qe6obO6H2UwMALeOcB7E5gGVdVN?=
 =?us-ascii?Q?Eq/hCNkVykN1yVYL7BbxzsY8HdHCtH/aT2P/ffMI5gieTm52uUx+Fu/o71je?=
 =?us-ascii?Q?FClo+xeUgND2v2anNWta+VTP+imX5sAKZi5mwJYqEdByqQkLeZHishleG0BG?=
 =?us-ascii?Q?XfTsZJdcAprTmKWZw170Me5Upz5+GV9xGXYqMmFsPM3pu8x7+DOxSylRZGXU?=
 =?us-ascii?Q?ZGtf0xxIA/lNpqBImnqOm7QYpQg+MBGfm2IXUW5G32Cjm/bvFq6KKumHIBPn?=
 =?us-ascii?Q?TGpXLW2l3H5YE7UJbPTjSGH/2U8IxPq9IEaz1rBmySubtQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff808a11-2809-4049-9e6c-08d9821caaaf
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 01:09:48.5460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io5VdA0KZNSg+UhyUULOas6wHly9s8ljY88pKbeVsqLgSCjR7tCpzTaljmTtGL0E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4772
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9tWWj72DUmeHg9dBCGtjBiYMJqcQBo78
X-Proofpoint-GUID: 9tWWj72DUmeHg9dBCGtjBiYMJqcQBo78
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_07,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=769 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280007
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 24, 2021 at 04:12:11PM -0700, Andrii Nakryiko wrote:
> > To make sure we're all aligned on the direction of this, for v4 I'm
> > going to make
> > the following changes:
> > * Make the map a bitset + bloom filter map, depending on how many hashes
> > are passed in
> 
> I'm not sure we are all on the same page on the exact encoding and
> what to do about the bitset case (do we restrict keys to 1, 4, 8
> bytes? or we go with "noop" (or xor?) hash function? or?...) Would be
> good to hear from Alexei and Martin to not waste your time iterating
> on this. The rest looks good to me.
I would prefer the earlier definition on nr_hashes:

> > > nr_hash == 0 bit_idx == key for set/read/clear
With nr_hash == 0, the value (or key) is the position of a bit.
Since it is the position of a bit, it is easier to understand
if the value is some integers, either __u8,__u16,__u32, or __u64,
so I don't see a need on noop.
As the position of a bit, I would even limit the value_size either to
be sizeof(__u32) or sizeof(__u64) for this case to keep it simple.

> > > nr_hashes >= 1 bit_idx[1..N] = hash(key, N) for set/read/clear.
With nr_hashes != 0 (let say nr_hashes == N), the value (or key) is
hashed N number of times to set N bits.  I don't see a need
to limit any non-zero value_size or XOR must be used with nr_hashes == 1.
Some hashes may need special handling for non 4-bytes or non 8-bytes value_size
but if possible that should be something internal to the kernel implementation
instead of limiting what value_size can be hashed.
