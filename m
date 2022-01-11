Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2948248AACE
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 10:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237197AbiAKJtS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 04:49:18 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6648 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237058AbiAKJtR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 11 Jan 2022 04:49:17 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20B8d79T021033;
        Tue, 11 Jan 2022 09:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=RWNNRjH+8Gk/zkPaHDMvkVdqvd+unAJfoUNYZ+cMfWY=;
 b=nnGprG/fBfNxh2D5j8SW4IBVBriI3cm+ITs0qWH5GhABEcP075Ud5ktSaYKKxSPANMu2
 zjfeLJJESfSlwnEx75gZvu+/6Bxbt38aYCjDBXWmdSYCxDx6V9OxgxSqMGdusalLefEP
 mD1eJ6rWW5f8z0vPx6tLoZV/KHwKboB56ArczWZMfpbOsW3Y4VRqUdiNSAU92jlKX7Wz
 ansYNDZ+uv7pKnGdx24F6fdKTD8vQAlGf4PN1E2nG3QdJT9Cn05TWHH29TR2RnToNEuH
 CD8sFwdgXgxBw3IEunhifZ7JZSvkPv//CwbqTqIe5xY+6Ua/im1XaVObeIhGKy1B2uox VQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7njf3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 09:49:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20B9kQWI126283;
        Tue, 11 Jan 2022 09:48:58 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by aserp3030.oracle.com with ESMTP id 3df0ndtds8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 09:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs7pQZqojbIBHDU1qK7hJpVMUY6Nx3lZ6/0rkLtVMEkXNtFo1SBCq3V9Pc9EUeNkholYQeIK/dzYi8C8/ap0j8Av4rZlDzu6k1ZAlACt6Tqnn+peptzfLgQjr2YM3AjpJS90pF1/cSgvB/X+67etH6Nm635QQNambusf9+/cPlDNFktL809O1fC8spyBVzsciJcDRksKhhYgTMyhWphE73m6HqJcklIcfwicM6fUGxXzFX0wnsJbImLkksmG6HHZBF3Do0HGwIByTj9rsdbo1/CfksZ4roY6zikNWImhc2dnzFgr2NoH8F7s/P8RVy/xdprNPlU1y6HKS1OC2m2dlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWNNRjH+8Gk/zkPaHDMvkVdqvd+unAJfoUNYZ+cMfWY=;
 b=W3xu3MqZ/P5YrMGVpwfbQFakJZ4D6B9dsk3hb+ert4ZiB94ls/wNKwXC5TdHaSLqUgz3TMNyJWYYBDamgJY14J2+bjMNDgqeC3rg7j9VJgBXlyzrD0M/N11Ea2/JA862ou614SB1YWyrih3mCP9ItOL+B2G/q21YU3MPy/ZEqU3AojJFT6VSMrA4g+ALsA7TlB+ih1eT9bDA/Dh/qoYAP01oSHqkUejFrP9JW4lYy63ylB52kCi98+teGXu5H3qEM0aegY3zfATSnN7Uox6Nv2wYEdcdeXODSb8r1/nyjmqepDjFROUpiWBdC8Wsp6QvyyebgIvBWYKCdf1TcC0SvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWNNRjH+8Gk/zkPaHDMvkVdqvd+unAJfoUNYZ+cMfWY=;
 b=rt7grM+FmhL9S28AbJSL5J7tGHkraFav4Yj32ixs4LuS7gPbBjZLVVNO3uIeYvud6RkjKBiJltqqxQDXAkl4IX1jZRFYZeutM1OlUS1TVlUemYnYU94qoAvmhVui/PZNLQEbHRu+UyrYIOtDSYqFHiZDwRA/EUDX7UkqCAkt5gM=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4707.namprd10.prod.outlook.com
 (2603:10b6:303:92::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Tue, 11 Jan
 2022 09:48:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 09:48:57 +0000
Date:   Tue, 11 Jan 2022 12:48:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christy Lee <christyc.y.lee@gmail.com>
Cc:     Song Liu <song@kernel.org>, Christy Lee <christylee@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, kbuild-all@lists.01.org,
        kbuild@lists.01.org, Linux-MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH bpf-next] Fix incorrect integer literal used for marking
 scratched registers in verifier logs
Message-ID: <20220111094835.GJ1978@kadam>
References: <202201060848.nagWejwv-lkp@intel.com>
 <20220108005854.658596-1-christylee@fb.com>
 <CAPhsuW5FQTLfs4P4GqMKxsakP82KuPGOrEcqX+zvAH1+VLf7aQ@mail.gmail.com>
 <CAPqJDZqf8-4DCe9J1jr7KekxqfBac3JBc+hx7a6qW4hoF6xPUQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPqJDZqf8-4DCe9J1jr7KekxqfBac3JBc+hx7a6qW4hoF6xPUQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::8)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa9926df-6072-4f96-76f6-08d9d4e795c2
X-MS-TrafficTypeDiagnostic: CO1PR10MB4707:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4707E331EF49E975A0B157008E519@CO1PR10MB4707.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:480;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jVzGyOKMmC1JyidNCQPLcKqWCOSGrF0kVYvGagfG/q8aJTcINz4yKULH6xj3VL2AQwjgGAS3LwmZalj0VZskkjXAUTx4hthdjBXv3C6dFehF6dtGqeqLd+LPAnYSWHSwRHysNDZocTDushiDrIavCUtrVIwtD8oaYQqUeGsBOUC1fzrPY0EAKCeK91stvgrhiUj5D3gXm2XFF3xFbrP4WZBqP9GDMzoSrqkdXOySA9nfJb3u80OKtxl7Z/sNGKg7U+v6YaViM9ymKehg4tAPylwwzTEXOntAU7AyrOOtclAgvGXyCnzTqzOgJ4Z9jvKYCQoIHDmu+8W2wfJIiPaCtxqkAvQG2gCuGsDU1EeDL7roP0QgTrmoxL4mDOm7XcHaG6y4ATPbKxsITjT6aokp0SlquuE8nWphSjQCKX/UgFIVOLG1D7aRtTOLC3qRA5Wx2af7M9RtqSZFlI4tlnWSOhfzoKsp5/K5+wliax41CeUN8/JwD01iqRyBIlefleh8djm0IvUKC/LEZicRRCHATV+4qY4V6M8ngxJ6/ZIHuBxI5Q4mo2o2a7+q1/Qa+cZBa/mLlTgFTfZh3/xOUZ1Q+RB0hDl96vp2ZO0lGaFaduIDd7qhK2nHnRWdEHoaP7T19T1qLLfxmNFa70OP7ti6EdUC1GMRLkIEBRrlUGc6MEyQIIN3BpMcXLelI33Mwe1/qTatUIx7CPY0UP47hLVHuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(2906002)(8936002)(54906003)(66946007)(5660300002)(316002)(8676002)(38100700002)(26005)(6506007)(33656002)(1076003)(4326008)(6916009)(83380400001)(6486002)(53546011)(186003)(33716001)(7416002)(66476007)(44832011)(66556008)(6512007)(9686003)(38350700002)(52116002)(6666004)(86362001)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VUyZZbG3mEAbAydALTVgGXLUUS+w3dF9WwkNxK3n/xBVNpY6h6ADCsoAfTCS?=
 =?us-ascii?Q?mqiWKa6hFfX9WZkODVtkdiFpkZodYVzHo05/11mOz47SwqYfxJW1/xefSkQw?=
 =?us-ascii?Q?biXz5SA1u4D4ko1WMKhHrZU2O3olUcF8A/20GaJRIkB6dk0ShyT3Yy4D1q1t?=
 =?us-ascii?Q?hfwqDtyGwUekSfxUhIggpr5M/24lC+89y4m2Uz/vMibshecG0gcGmSqASnQd?=
 =?us-ascii?Q?KJnqBkVDZm1mgeYNUMqjT+RMp9niNCsa551feOQ0vg3MXjhMsuTN390/BI6O?=
 =?us-ascii?Q?MhPw9HcjQ9xRH/c8KU0qgz9oZEQDUW6Ieyl09NZtiImW6TWbRv+NaPgbU6i3?=
 =?us-ascii?Q?RlZiMHry3nMIsqyD3zVpxQHiO8ramiQzUvw+JmxnO4JnFIJBUjthIQwn8Ys8?=
 =?us-ascii?Q?+GasvcZkAEyhb/NAsDvk+cWnVQlwhoG8jH/Usu9SJCuOGrsDFUhdXkAao5Hy?=
 =?us-ascii?Q?7x0hTCpr4jUTzFAd6ZS05I7itIDrkZO7lGac0nWwvia4bdUbGmnmjsZD2E5E?=
 =?us-ascii?Q?QVg4h1XgMLQyjam7g4IlkNXgyCkXsS4fKoHvlNtyKTXissw1UMwlxVA8pdeD?=
 =?us-ascii?Q?k2Pc2/kyWPJ59C5l7ns6IbEBr9KIbPERVaZ7vCqdHJ0kFZ8PLmr0wGf5A7xA?=
 =?us-ascii?Q?XG330ljduIJl9nFYrNjexRuYhJ6xknnDIJKtSX1137SG9UGwZX8tktIP8PxR?=
 =?us-ascii?Q?7xBe08MGtOPOhjktQ4237jEiGZLqD0YMl6vwtlwEIPZF7PQrMTLOmG8hrtQJ?=
 =?us-ascii?Q?9E7fXWWhRHg4FwshgW2VCPWi7IOPoPUev7pYOJ4BxNPozeObINmg3O2ObZm6?=
 =?us-ascii?Q?bGxiWdlu4TxALtKvv6k5eY/EQPHEGvRtTEH5n2Bp/AAK8yGklQEntu20lax9?=
 =?us-ascii?Q?zZoW6kQrSKfULYoaqfpB/YQMBPPzhCjWYNmSUrv3Jz7Rgx+AX6H7Rbhj5xnr?=
 =?us-ascii?Q?LIls+J2LFRM+eaP/YCU4mCuUAfqnFTsxQXeRWl0bk6SUf/OZCwEGI07mtkNj?=
 =?us-ascii?Q?WQG3C3RhH/LR70mizPRKkqEeai83YjRitlb5jK1nBASXpz+L0udZz7LvhYb8?=
 =?us-ascii?Q?OFwH3y2U1vZIPvJAMnS0l2wZ9PWibO2ZWet9sNutWsf4437M0IKqXGGDol+D?=
 =?us-ascii?Q?hvk9/Mpu6CfvHGyrhvRuRZIpqn7lRS8QbexbZY/Q7dWfAlDK204H3f6ieUDQ?=
 =?us-ascii?Q?thvOday4l4mCrkWf4vHNvM+BYdWS5aqsJbslSnzb6+akZo5u4RWmBuNAQKGZ?=
 =?us-ascii?Q?uPUq03vGEybmIN9T+pu1mLhfHC9KWK3eQsHL7SeoXeELREiljOGXRKpuVo8/?=
 =?us-ascii?Q?TFV4KACQIk1FXu2uQB71/8L+EjJChJFkvk6wbtnO6EDy38vBzfsB6jmqRRqV?=
 =?us-ascii?Q?1hrD+dbr7e9593rfPsZS6HhchzE8QKqlAk+boCozYeIByZWleET1+CjlySk3?=
 =?us-ascii?Q?RYw7wnfDfoJBJUf4yN4cAErYEOmVbR5XRHoCJgPKnMtFeoP85UYLfcwamXvj?=
 =?us-ascii?Q?dqn1NLWcxPXmaNo/WWiXUhTrX+YP39dmFcSi9QIh5e+JWw2tA+n9TYkngj+l?=
 =?us-ascii?Q?4GGGf+/KZd8NbOU5QpgpmBuhxqleoVow+KkpS9KEQvACzfgc9BruDYQHwMpU?=
 =?us-ascii?Q?eOLttaclWMxs++Y3O9LQw4R+4GcwiF3myfratXygX7v1LoTS4Be4hOAKmaIP?=
 =?us-ascii?Q?batG6pnqAd22HDt9pHT+kwUvC0w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9926df-6072-4f96-76f6-08d9d4e795c2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 09:48:56.9094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RxM1aWhF6dgssHliU/tGu5bnxMywOVIrLeRCJ/WmZIGhzx2MKEv22B9XVUYn6TLC5ZE7sYlUq7wdCNxcTx7y7nZ67I6nlBRyR0XP8IV2lsI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4707
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110056
X-Proofpoint-GUID: TCbkudkKPtaTRAcnDUYxb6iQjSngsIXg
X-Proofpoint-ORIG-GUID: TCbkudkKPtaTRAcnDUYxb6iQjSngsIXg
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 10, 2022 at 02:12:58PM -0800, Christy Lee wrote:
> On Mon, Jan 10, 2022 at 1:52 PM Song Liu <song@kernel.org> wrote:
> >
> > On Fri, Jan 7, 2022 at 4:59 PM Christy Lee <christylee@fb.com> wrote:
> > >
> > > env->scratched_stack_slots is a 64-bit value, we should use ULL
> > > instead of UL literal values.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Signed-off-by: Christy Lee <christylee@fb.com>
> >
> > The fix looks good to me. Thus:
> >
> > Acked-by: Song Liu <songliubraving@fb.com>
> >
> > However, the patch looks corrupted. Also, the subject is probably too
> > long (./scripts/checkpatch.pl should complain about it).
> >
> 
> I just checked that even with an absurdly long subject (more than 200
> characters), ./scripts/checkpatch.pl doesn't complain. It only complains
> when the commit message body has longer than 75 characters but not the
> subject line.  What's the maximum subject line length?
> 

People say 50 characters but that just seems more aspirational than
realistic.  This patch needs a subsystem prefix as well.

regards,
dan carpenter

