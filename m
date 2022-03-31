Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2974EDE0D
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 17:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiCaP5C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCaP5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 11:57:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29586D4C99
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 08:55:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VF16nh027915;
        Thu, 31 Mar 2022 15:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=f0AxUXvDQviRoK5wW2Ls0wy3h1F22mNno0+lM/Tgh90=;
 b=WqfK44pCLR0hQan+zqcA/zF+N9/ErBCXsAKbTinnmt0XGhFu0AWirGh6a2hZ8m/gYlIQ
 WJ+E5i5TAn0Byt8hvxiQ6jB6qGIpshnXIZx0yK13NCh3RFo/8nEYypRx1o8cQ80+GUxK
 Co+aepe2TSy87fMHqhqv8Acc4p5dDyDzHqrxy57vypTDsClss4Ssz0F/YxVKoUvOiCSD
 P4xWVfKTRI2ge8VKzgHpUksgiQNLc64e+CN/L0tysOeJ7yyVe1FbORu7B+1KT/w4FWjf
 JnGkvKlFD7Ah6i8WAiUP4nwRTogF0zpuS6mEA73CMJcNijhi2rQ3gjy04a33e9KfHPNj zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2mtff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:54:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VFkPcc027833;
        Thu, 31 Mar 2022 15:54:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s982v01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 15:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RY7Wm+DONpDQXyTVuNLdE6yTf8u2q5AC1bHGn/lJwagBq++Qi84z717O+GAdqF5YTjg+lIGiqIlaUFlKdGg72LpsO6IP5rpkNO9HJSAOsVOx5upRNg4Fwm+ImSaYCmgdnqv0aWySzPTHdyJ5EuZWqmN3hwFMP0SBOh05RXLyNplCvOAGO9ixJOiPEBt+zdLFRGBsaTtIf6iyJ1XqcYU0AVi9onPTK6VlJCz/Vb2Jgx/MM4nO+zDE0X02ghBD7/5ls+eoloL1fXnPwOkbxSVP09y3YX9GKR14n9ivCKveSwUdbuawcrkh6l6qcWqJ4ZgDiIoJ9PP3v04PubV/JKyYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3mNqiHnFTlxwLaBm98XRtuKHVfOCM3OtWOMDxLDWmg=;
 b=oV+uPnsTm1k1on2d/vrcGUZF9rzGVnHRCWWs+0sHXShjBRDT6yYD93TU8qNsy4HZdbKTdwHJWDtR5paJo5Q7vM2w6vXOdHlpY8eQWVabexIfSoCafLqbdt4EFgIcXSIPFZOFJFDdmKH+B3wnR6/6akWa+leD7gXxLINUhLTXIF3lcEpjUxlUGQeBkxAr932Hz+jLmEnSEinuu7WgcerHI3n5SYn3lMVKukiXSeUBf4WIuMcBGelg/sF4S+3O5RfRw3s/91LanlQgDw5V0toVp6McFg2OC4SUfm/ovfqPI3KHdm0dUVbi+ymzVkWIejjZ13jHunRVxQz82E+Ms0KiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3mNqiHnFTlxwLaBm98XRtuKHVfOCM3OtWOMDxLDWmg=;
 b=NncdOOnB5IjN3EXGrtpccr/I+hG1msOYudZcjbiGCAy/c+HuP6QAexR3RI8cxTjkp+Mjrv+q+6uaKlziMfjKJOIHRRwm6IvFJPNHfH/ynuurkCsr2sBDj+U8565w9f8Ab9k/eTrVS9K723FppCWuAEwu/E2nMD6u/Gl5vwnD/9c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB3916.namprd10.prod.outlook.com (2603:10b6:5:1fe::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 15:54:50 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 15:54:50 +0000
Date:   Thu, 31 Mar 2022 16:54:31 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next 6/7] selftests/bpf: add basic USDT selftests
In-Reply-To: <20220325052941.3526715-7-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2203311654230.29864@MyRouter>
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-7-andrii@kernel.org>
Content-Type: multipart/mixed; boundary="-1463809791-1601919008-1648742090=:29864"
X-ClientProxiedBy: LO4P123CA0305.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9326a37e-ace7-42c1-6612-08da132ec9fd
X-MS-TrafficTypeDiagnostic: DM6PR10MB3916:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB391618C0AE483CE58DB3DF6FEFE19@DM6PR10MB3916.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibBWHcSjBdqSp8MTmPJeHTus5da62vbxl5cM5a+ig67VnytVeI3mfDeh1ggyRKB+pzOmDBHqKV7a8Z5P/7qdXDyWs4DG/s7DKtH6VyJIfC+dPx01dPSs/EdpK3kq5+IbnvPR5z4L3Rc7g9SRwx++qI+46N3NqesQilzfVE2j+vfqN8lqayCz+XSiGqbIvaZX34bOvdGVhsRbhxKymBJkaci1P5SJEz9mwQUHPT38GPXGUIoNwKvJBJEoQKU7Gx4paUKIHvNwjSRUmyqjzQH7KTn/z7nciBfaSw1WnaXPeAPKZFC3e74V/W2gCUq/g6nOxMEw32vGHYJ+1S5rfdymnuS81PcTlXpAxy60MO5HgTUQ+oMZYUbuqdyNA3qjJc9Vk7Fd1aSboZWjGzBsAHkg5L1sdmRTXfxnhjltyL9Av3aS6PWSj6VY6ghMqueyeyHX4j/zPgtFqLjZWMS8yrvXkraqChyAiZgLviIpr2NuU59m+x+kbTIeKB31Fsx8onhlA0OHkAU30Ryj6X8Bii3TArq7P05u6OmpjrLWe6R5bO/MqvAuSzUgZnSetqQj3AuT7DQlcPIRFyi7CQW3IR9+TObTG2ZozIvkZuh3dR7dnxm3RRn+UZE/NWw4NeSm0w7ojNOD/rqs3n+uEQV+ObNS6AKsnmRyZBTTCZa9jhTMndwTg0q1FUF6fzdqwaxgxuXoTUJ3Yhl3Vp2ma703hTvxqGvAzKeOZFxK0f9WReOH1oI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6916009)(316002)(54906003)(83380400001)(966005)(33716001)(86362001)(186003)(66574015)(508600001)(52116002)(6486002)(9686003)(6666004)(30864003)(5660300002)(6506007)(8936002)(2906002)(6512007)(66556008)(38100700002)(66946007)(44832011)(4326008)(66476007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-7?Q?bI/PYUrh11zl7xgR7qCgqoFHIty9flGO6J7mCiug7S2suvu2LyVskVLF9d?=
 =?iso-8859-7?Q?Nt5AWYpR+JvpBNKrvz2zZbq6tLXRc8wPMPkihMOadQ7HmgoBnmWVup1T/j?=
 =?iso-8859-7?Q?aiWK8pKFwt/ukjQ5/lVknwI1sw6A82nhaR1JS5itZc95E71ZWjIHvz0rtJ?=
 =?iso-8859-7?Q?bh9I1PCw7E3YMx76WfdDvTrK5k3STAiuuKgREjaExy0s6jqDTxWluSGY9x?=
 =?iso-8859-7?Q?8HaCpGNdlr7wgQgEndDlMLkOHkAK8QtoibyXW4u+D+JOG5D9vXsf+pr+zj?=
 =?iso-8859-7?Q?cePCPWzb5vyYREajiIPIEaDnGav8OG/u29AUpBcKnrMcYBossifpOUWyqs?=
 =?iso-8859-7?Q?/WZOMFw9cz6OT/7ZXKUXuQ6BSgGg5kMqHNHS3pqEgrbZR9O+SBHIuqKXIO?=
 =?iso-8859-7?Q?Z0fjkxpZFA4ZVXp11K11S2RYK8ePZzpGCUbxOISe5IMpP8Wb5mB2YeLQ87?=
 =?iso-8859-7?Q?warCu1/EtkqqPA8dz45EAIJX/Y2TiqaRP6RfVowZxPtw4gHUQekcyveatO?=
 =?iso-8859-7?Q?+xfbhXmb2/zbhrDNOzgKdAapYNRiTqz3lPkQM5seZul3Q2kKQbV5vX7DIK?=
 =?iso-8859-7?Q?eD82GXwKUz1Ht7IjMmjNA1+c48lXSzjPGdISrkEnQMDE/qqkxaJp0B1t2n?=
 =?iso-8859-7?Q?ttX8ASonzo7wUz4bt5aVx4yKbthwQBcqr2+AuLhBzn1aWumpXe8kWVrj0T?=
 =?iso-8859-7?Q?G2GCx34LYcyYy5lk729Iu9/GgLxn/V9QfGnrIOyc+WIouPs/tXPxwdbHoi?=
 =?iso-8859-7?Q?pE564mWG81UYYmAl9H5HlROuFEYFaYLp7C2cuCHkwwRpM2/jITCCQqXKQl?=
 =?iso-8859-7?Q?/jGOXzd0JROYepH2E24SykTLtAVOTDbnmNyTPN2KmRzao7sWPDloLNyNmX?=
 =?iso-8859-7?Q?cZeU2lYh3znHdX5fFM3Qz/cckZhXmQKc7Ui8GCEq49tJpn0EGpgYzJ5Xrz?=
 =?iso-8859-7?Q?C3zkpXOrHZwdbvvHsgb4ne+NhcXMn/bt4TidaUtWHXV7Vqo0TA+I/g6Dv3?=
 =?iso-8859-7?Q?e3Uw+M+Z9pvD+FjuLqwGskmGmSd3nypehBZ2tfFLYMhhudE8emJEqaE2Jq?=
 =?iso-8859-7?Q?Xk/U31+jZd5fWE9BBFNYwokn9AzuPvz2GmLEJSHp7Q7CModPLGlpoy5WeP?=
 =?iso-8859-7?Q?9ZRrXbpj44d8Yu3lUt1o+Nk5+zKURJtIm0ak1lMuer4dW6R5/c4GR7K0c6?=
 =?iso-8859-7?Q?s9C9OBaRNvRHzYRR1vpWUZ4tyA3N+pdGvX+IFGiCpR7LOtiJLdlbQfjAm+?=
 =?iso-8859-7?Q?HvAPKoxqRsbbis4z6keEsnNCj/cl77V9Ur1tlETIrLy8pzo7PkhU3KfW/G?=
 =?iso-8859-7?Q?0pqEbUjvsCD2YAKZGyduECxD9/obPVaGvasAvfHdgC7b2VNeNp21P/DgIk?=
 =?iso-8859-7?Q?0XC+dFEjtqHplVCFvROEk9Lo0EyL6raWObjFo8We87MwBM/aTc/8wDGSHN?=
 =?iso-8859-7?Q?S3k5dpDa32jX5Y5oKURdeztrEGXslU7OOBY7w/8CRqY0uz6DYzo/OXndEX?=
 =?iso-8859-7?Q?p125K++PqXpK0FCbqiN4HMQVgrZfg91buz9DCW1yUaHAEoWz1pK0czx45V?=
 =?iso-8859-7?Q?cw5wkJYaleGFVclY1WtIS91EWJiBVPiUNTr7XhXsAmmCl1XgpgSxqjn1II?=
 =?iso-8859-7?Q?NJ2EdVSsCH6yuWHJsrus+uCOdRVAq9Dkdz0mvhVIY5H2e2PtaFLyM2UJ5R?=
 =?iso-8859-7?Q?7u23t5iO5D/j2nbV7axoNUci8WZQbOCFqzMjHfxLr9dw81hlBGDLiN351t?=
 =?iso-8859-7?Q?6K5L4uqUPsSQfx8fkfEtyYqSpMjNZsX7NUkGxgEhUkGZALrFL6V6FrhoEA?=
 =?iso-8859-7?Q?sEQ+SgLuvPfO3ui80yEeZnyq2AsY4mLdKINRmDbRl6VSMlX4LA3t?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9326a37e-ace7-42c1-6612-08da132ec9fd
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 15:54:50.7252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjrNkBANTMWqxkKQ4e4VmP5HGVSvevnW5Ebprm5osoA43ChFfKfVYUGWZ7NUvO3F29K4etK8kHA/JJVOFBLHYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3916
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310088
X-Proofpoint-ORIG-GUID: XmwOpLAPxj327jfpJzad2kJIn1uOLfdU
X-Proofpoint-GUID: XmwOpLAPxj327jfpJzad2kJIn1uOLfdU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---1463809791-1601919008-1648742090=:29864
Content-Type: text/plain; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

cOn Fri, 25 Mar 2022, Andrii Nakryiko wrote:

> Add semaphore-based USDT to test_progs itself and write basic tests to
> valicate both auto-attachment and manual attachment logic, as well as
> BPF-side functionality.
> 
> Also add subtests to validate that libbpf properly deduplicates USDT
> specs and handles spec overflow situations correctly, as well as proper
> "rollback" of partially-attached multi-spec USDT.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

One compilation issue and minor nit below

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  tools/testing/selftests/bpf/prog_tests/usdt.c | 314 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/test_usdt.c | 115 +++++++
>  3 files changed, 430 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 3820608faf57..18e22def3bdb 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -400,6 +400,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.o:				\
>  		     $(TRUNNER_BPF_PROGS_DIR)/*.h			\
>  		     $$(INCLUDE_DIR)/vmlinux.h				\
>  		     $(wildcard $(BPFDIR)/bpf_*.h)			\
> +		     $(wildcard $(BPFDIR)/*.bpf.h)			\
>  		     | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>  	$$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,			\
>  					  $(TRUNNER_BPF_CFLAGS))
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
> new file mode 100644
> index 000000000000..44a20d8c45d7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include <test_progs.h>
> +
> +#define _SDT_HAS_SEMAPHORES 1
> +#include <sys/sdt.h>
> +

Do we need to bracket with feature test for sdt.h? I think I had 
something rough for this in

https://lore.kernel.org/bpf/1642004329-23514-5-git-send-email-alan.maguire@oracle.com/
 
might prevent selftest compilation failures if sdt.h isn't present,
and IIRC that feature test is used in perf code.

I just realized I got confused on the cookie logic. There's really two 
levels of cookies:

- at the API level, the USDT cookie is associated with the USDT 
  attachment, and can span multiple sites; but under the hood
- the uprobe cookie is used to associate the uprobe point of attachment 
  with the associated spec id.  If BPF cookie retrieval isn't supported,
  we fall back to using the instruction pointer -> spec id mapping.

To get the usdt cookie in BPF prog context, we first look up the uprobe 
cookie to get the spec id, and then get the spec entry.

I guess libbpf CI on older kernels will cover testing for the case where
bpf cookies aren't supported and we need to do that ip -> spec id 
mapping? Perhaps we could have a test that #defines 
BPF_USDT_HAS_BPF_COOKIE to 0 to cover testing this on newer kernels?

> +#include "test_usdt.skel.h"
> +#include "test_urandom_usdt.skel.h"
> +
> +int lets_test_this(int);
> +
> +static volatile int idx = 2;
> +static volatile __u64 bla = 0xFEDCBA9876543210ULL;
> +static volatile short nums[] = {-1, -2, -3, };
> +
> +static volatile struct {
> +	int x;
> +	signed char y;
> +} t1 = { 1, -127 };
> +
> +#define SEC(name) __attribute__((section(name), used))
> +
> +unsigned short test_usdt0_semaphore SEC(".probes");
> +unsigned short test_usdt3_semaphore SEC(".probes");
> +unsigned short test_usdt12_semaphore SEC(".probes");
> +
> +static void __always_inline trigger_func(int x) {
> +	long y = 42;
> +
> +	if (test_usdt0_semaphore)
> +		STAP_PROBE(test, usdt0);
> +	if (test_usdt3_semaphore)
> +		STAP_PROBE3(test, usdt3, x, y, &bla);
> +	if (test_usdt12_semaphore) {
> +		STAP_PROBE12(test, usdt12,
> +			     x, x + 1, y, x + y, 5,
> +			     y / 7, bla, &bla, -9, nums[x],
> +			     nums[idx], t1.y);
> +	}
> +}
> +
> +static void subtest_basic_usdt(void)
> +{
> +	LIBBPF_OPTS(bpf_usdt_opts, opts);
> +	struct test_usdt *skel;
> +	struct test_usdt__bss *bss;
> +	int err;
> +
> +	skel = test_usdt__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	bss = skel->bss;
> +	bss->my_pid = getpid();
> +
> +	err = test_usdt__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* usdt0 won't be auto-attached */
> +	opts.usdt_cookie = 0xcafedeadbeeffeed;
> +	skel->links.usdt0 = bpf_program__attach_usdt(skel->progs.usdt0,
> +						     0 /*self*/, "/proc/self/exe",
> +						     "test", "usdt0", &opts);
> +	if (!ASSERT_OK_PTR(skel->links.usdt0, "usdt0_link"))
> +		goto cleanup;
> +
> +	trigger_func(1);
> +
> +	ASSERT_EQ(bss->usdt0_called, 1, "usdt0_called");
> +	ASSERT_EQ(bss->usdt3_called, 1, "usdt3_called");
> +	ASSERT_EQ(bss->usdt12_called, 1, "usdt12_called");
> +
> +	ASSERT_EQ(bss->usdt0_cookie, 0xcafedeadbeeffeed, "usdt0_cookie");
> +	ASSERT_EQ(bss->usdt0_arg_cnt, 0, "usdt0_arg_cnt");
> +	ASSERT_EQ(bss->usdt0_arg_ret, -ENOENT, "usdt0_arg_ret");
> +
> +	/* auto-attached usdt3 gets default zero cookie value */
> +	ASSERT_EQ(bss->usdt3_cookie, 0, "usdt3_cookie");
> +	ASSERT_EQ(bss->usdt3_arg_cnt, 3, "usdt3_arg_cnt");
> +
> +	ASSERT_EQ(bss->usdt3_arg_rets[0], 0, "usdt3_arg1_ret");
> +	ASSERT_EQ(bss->usdt3_arg_rets[1], 0, "usdt3_arg2_ret");
> +	ASSERT_EQ(bss->usdt3_arg_rets[2], 0, "usdt3_arg3_ret");
> +	ASSERT_EQ(bss->usdt3_args[0], 1, "usdt3_arg1");
> +	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
> +	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
> +
> +	/* auto-attached usdt12 gets default zero cookie value */
> +	ASSERT_EQ(bss->usdt12_cookie, 0, "usdt12_cookie");
> +	ASSERT_EQ(bss->usdt12_arg_cnt, 12, "usdt12_arg_cnt");
> +
> +	ASSERT_EQ(bss->usdt12_args[0], 1, "usdt12_arg1");
> +	ASSERT_EQ(bss->usdt12_args[1], 1 + 1, "usdt12_arg2");
> +	ASSERT_EQ(bss->usdt12_args[2], 42, "usdt12_arg3");
> +	ASSERT_EQ(bss->usdt12_args[3], 42 + 1, "usdt12_arg4");
> +	ASSERT_EQ(bss->usdt12_args[4], 5, "usdt12_arg5");
> +	ASSERT_EQ(bss->usdt12_args[5], 42 / 7, "usdt12_arg6");
> +	ASSERT_EQ(bss->usdt12_args[6], bla, "usdt12_arg7");
> +	ASSERT_EQ(bss->usdt12_args[7], (uintptr_t)&bla, "usdt12_arg8");
> +	ASSERT_EQ(bss->usdt12_args[8], -9, "usdt12_arg9");
> +	ASSERT_EQ(bss->usdt12_args[9], nums[1], "usdt12_arg10");
> +	ASSERT_EQ(bss->usdt12_args[10], nums[idx], "usdt12_arg11");
> +	ASSERT_EQ(bss->usdt12_args[11], t1.y, "usdt12_arg12");
> +
> +	/* trigger_func() is marked __always_inline, so USDT invocations will be
> +	 * inlined in two different places, meaning that each USDT will have
> +	 * at least 2 different places to be attached to. This verifies that
> +	 * bpf_program__attach_usdt() handles this properly and attaches to
> +	 * all possible places of USDT invocation.
> +	 */
> +	trigger_func(2);
> +
> +	ASSERT_EQ(bss->usdt0_called, 2, "usdt0_called");
> +	ASSERT_EQ(bss->usdt3_called, 2, "usdt3_called");
> +	ASSERT_EQ(bss->usdt12_called, 2, "usdt12_called");
> +
> +	/* only check values that depend on trigger_func()'s input value */
> +	ASSERT_EQ(bss->usdt3_args[0], 2, "usdt3_arg1");
> +
> +	ASSERT_EQ(bss->usdt12_args[0], 2, "usdt12_arg1");
> +	ASSERT_EQ(bss->usdt12_args[1], 2 + 1, "usdt12_arg2");
> +	ASSERT_EQ(bss->usdt12_args[3], 42 + 2, "usdt12_arg4");
> +	ASSERT_EQ(bss->usdt12_args[9], nums[2], "usdt12_arg10");
> +
> +	/* detach and re-attach usdt3 */
> +	bpf_link__destroy(skel->links.usdt3);
> +
> +	opts.usdt_cookie = 0xBADC00C51E;
> +	skel->links.usdt3 = bpf_program__attach_usdt(skel->progs.usdt3, -1 /* any pid */,
> +						     "/proc/self/exe", "test", "usdt3", &opts);
> +	if (!ASSERT_OK_PTR(skel->links.usdt3, "usdt3_reattach"))
> +		goto cleanup;
> +
> +	trigger_func(3);
> +
> +	ASSERT_EQ(bss->usdt3_called, 3, "usdt3_called");
> +	/* this time usdt3 has custom cookie */
> +	ASSERT_EQ(bss->usdt3_cookie, 0xBADC00C51E, "usdt3_cookie");
> +	ASSERT_EQ(bss->usdt3_arg_cnt, 3, "usdt3_arg_cnt");
> +
> +	ASSERT_EQ(bss->usdt3_arg_rets[0], 0, "usdt3_arg1_ret");
> +	ASSERT_EQ(bss->usdt3_arg_rets[1], 0, "usdt3_arg2_ret");
> +	ASSERT_EQ(bss->usdt3_arg_rets[2], 0, "usdt3_arg3_ret");
> +	ASSERT_EQ(bss->usdt3_args[0], 3, "usdt3_arg1");
> +	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
> +	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
> +
> +cleanup:
> +	test_usdt__destroy(skel);
> +}
> +
> +unsigned short test_usdt_100_semaphore SEC(".probes");
> +unsigned short test_usdt_300_semaphore SEC(".probes");
> +unsigned short test_usdt_400_semaphore SEC(".probes");
> +
> +#define R10(F, X)  F(X+0); F(X+1);F(X+2); F(X+3); F(X+4); \
> +		   F(X+5); F(X+6); F(X+7); F(X+8); F(X+9);
> +#define R100(F, X) R10(F,X+ 0);R10(F,X+10);R10(F,X+20);R10(F,X+30);R10(F,X+40); \
> +		   R10(F,X+50);R10(F,X+60);R10(F,X+70);R10(F,X+80);R10(F,X+90);
> +
> +/* carefully control that we get exactly 100 inlines by preventing inlining */
> +static void __always_inline f100(int x)
> +{
> +	STAP_PROBE1(test, usdt_100, x);
> +}
> +
> +__weak void trigger_100_usdts(void)
> +{
> +	R100(f100, 0);
> +}
> +
> +/* we shouldn't be able to attach to test:usdt2_300 USDT as we don't have as
> + * many slots for specs. It's important that each STAP_PROBE2() invocation
> + * (after untolling) gets different arg spec due to compiler inlining i as
> + * a constant
> + */
> +static void __always_inline f300(int x)
> +{
> +	STAP_PROBE1(test, usdt_300, x);
> +}
> +
> +__weak void trigger_300_usdts(void)
> +{
> +	R100(f300, 0);
> +	R100(f300, 100);
> +	R100(f300, 200);
> +}
> +
> +static void __always_inline f400(int /*unused*/ )

...caused a compilation error on gcc-9 for me:

  TEST-OBJ [test_progs] usdt.test.o
/home/alan/kbuild/bpf-next/tools/testing/selftests/bpf/prog_tests/usdt.c: 
In function ¡f400¢:
/home/alan/kbuild/bpf-next/tools/testing/selftests/bpf/prog_tests/usdt.c:191:34: 
error: parameter name omitted
  191 | static void __always_inline f400(int /*unused*/ )
      |                                  ^~~
make: *** 
[/home/alan/kbuild/bpf-next/tools/testing/selftests/bpf/usdt.test.o] Error 
1
 ...but with 

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c 
b/tools/testing/selftests/bpf/prog_tests/
index b4c070b..5d382c8 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -188,7 +188,7 @@ __weak void trigger_300_usdts(void)
        R100(f300, 200);
 }
 
-static void __always_inline f400(int /*unused*/ )
+static void __always_inline f400(int u /*unused*/ )
 {
        static int x;
 


...tests passed cleanly.

> +{
> +	static int x;
> +
> +	STAP_PROBE1(test, usdt_400, x++);
> +}
> +
> +/* this time we have 400 different USDT call sites, but they have uniform
> + * argument location, so libbpf's spec string deduplication logic should keep
> + * spec count use very small and so we should be able to attach to all 400
> + * call sites
> + */
> +__weak void trigger_400_usdts(void)
> +{
> +	R100(f400, 0);
> +	R100(f400, 100);
> +	R100(f400, 200);
> +	R100(f400, 300);
> +}
> +
> +static void subtest_multispec_usdt(void)
> +{
> +	LIBBPF_OPTS(bpf_usdt_opts, opts);
> +	struct test_usdt *skel;
> +	struct test_usdt__bss *bss;
> +	int err, i;
> +
> +	skel = test_usdt__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		return;
> +
> +	bss = skel->bss;
> +	bss->my_pid = getpid();
> +
> +	err = test_usdt__attach(skel);
> +	if (!ASSERT_OK(err, "skel_attach"))
> +		goto cleanup;
> +
> +	/* usdt_100 is auto-attached and there are 100 inlined call sites,
> +	 * let's validate that all of them are properly attached to and
> +	 * handled from BPF side
> +	 */
> +	trigger_100_usdts();
> +
> +	ASSERT_EQ(bss->usdt_100_called, 100, "usdt_100_called");
> +	ASSERT_EQ(bss->usdt_100_sum, 99 * 100 / 2, "usdt_100_sum");
> +
> +	/* Stress test free spec ID tracking. By default libbpf allows up to
> +	 * 256 specs to be used, so if we don't return free spec IDs back
> +	 * after few detachments and re-attachments we should run out of
> +	 * available spec IDs.
> +	 */
> +	for (i = 0; i < 2; i++) {
> +		bpf_link__destroy(skel->links.usdt_100);
> +
> +		skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1,
> +							        "/proc/self/exe",
> +								"test", "usdt_100", NULL);
> +		if (!ASSERT_OK_PTR(skel->links.usdt_100, "usdt_100_reattach"))
> +			goto cleanup;
> +
> +		bss->usdt_100_sum = 0;
> +		trigger_100_usdts();
> +
> +		ASSERT_EQ(bss->usdt_100_called, (i + 1) * 100 + 100, "usdt_100_called");
> +		ASSERT_EQ(bss->usdt_100_sum, 99 * 100 / 2, "usdt_100_sum");
> +	}
> +
> +	/* Now let's step it up and try to attach USDT that requires more than
> +	 * 256 attach points with different specs for each.
> +	 * Note that we need trigger_300_usdts() only to actually have 300
> +	 * USDT call sites, we are not going to actually trace them.
> +	 */
> +	trigger_300_usdts();
> +
> +	/* we'll reuse usdt_100 BPF program for usdt_300 test */
> +	bpf_link__destroy(skel->links.usdt_100);
> +	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1, "/proc/self/exe",
> +							"test", "usdt_300", NULL);
> +	err = -errno;
> +	if (!ASSERT_ERR_PTR(skel->links.usdt_100, "usdt_300_bad_attach"))
> +		goto cleanup;
> +	ASSERT_EQ(err, -E2BIG, "usdt_300_attach_err");
> +
> +	/* let's check that there are no "dangling" BPF programs attached due
> +	 * to partial success of the above test:usdt_300 attachment
> +	 */
> +	bss->usdt_100_called = 0;
> +	bss->usdt_100_sum = 0;
> +
> +	f300(777); /* this is 301st instance of usdt_300 */
> +
> +	ASSERT_EQ(bss->usdt_100_called, 0, "usdt_301_called");
> +	ASSERT_EQ(bss->usdt_100_sum, 0, "usdt_301_sum");
> +
> +	/* This time we have USDT with 400 inlined invocations, but arg specs
> +	 * should be the same across all sites, so libbpf will only need to
> +	 * use one spec and thus we'll be able to attach 400 uprobes
> +	 * successfully.
> +	 *
> +	 * Again, we are reusing usdt_100 BPF program.
> +	 */
> +	skel->links.usdt_100 = bpf_program__attach_usdt(skel->progs.usdt_100, -1,
> +							"/proc/self/exe",
> +							"test", "usdt_400", NULL);
> +	if (!ASSERT_OK_PTR(skel->links.usdt_100, "usdt_400_attach"))
> +		goto cleanup;
> +
> +	trigger_400_usdts();
> +
> +	ASSERT_EQ(bss->usdt_100_called, 400, "usdt_400_called");
> +	ASSERT_EQ(bss->usdt_100_sum, 399 * 400 / 2, "usdt_400_sum");
> +
> +cleanup:
> +	test_usdt__destroy(skel);
> +}
> +
> +void test_usdt(void)
> +{
> +	if (test__start_subtest("basic"))
> +		subtest_basic_usdt();
> +	if (test__start_subtest("multispec"))
> +		subtest_multispec_usdt();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
> new file mode 100644
> index 000000000000..cb800910d794
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_usdt.c
> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/usdt.bpf.h>
> +
> +int my_pid;
> +
> +int usdt0_called;
> +u64 usdt0_cookie;
> +int usdt0_arg_cnt;
> +int usdt0_arg_ret;
> +
> +SEC("usdt")
> +int usdt0(struct pt_regs *ctx)
> +{
> +	long tmp;
> +
> +	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	__sync_fetch_and_add(&usdt0_called, 1);
> +
> +	usdt0_cookie = bpf_usdt_cookie(ctx);
> +	usdt0_arg_cnt = bpf_usdt_arg_cnt(ctx);
> +	/* should return -ENOENT */
> +	usdt0_arg_ret = bpf_usdt_arg(ctx, 0, &tmp);
> +	return 0;
> +}
> +
> +int usdt3_called;
> +u64 usdt3_cookie;
> +int usdt3_arg_cnt;
> +int usdt3_arg_rets[3];
> +u64 usdt3_args[3];
> +
> +SEC("usdt//proc/self/exe:test:usdt3")
> +int usdt3(struct pt_regs *ctx)
> +{
> +	long tmp;
> +
> +	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	__sync_fetch_and_add(&usdt3_called, 1);
> +
> +	usdt3_cookie = bpf_usdt_cookie(ctx);
> +	usdt3_arg_cnt = bpf_usdt_arg_cnt(ctx);
> +
> +	usdt3_arg_rets[0] = bpf_usdt_arg(ctx, 0, &tmp);
> +	usdt3_args[0] = (int)tmp;
> +
> +	usdt3_arg_rets[1] = bpf_usdt_arg(ctx, 1, &tmp);
> +	usdt3_args[1] = (long)tmp;
> +
> +	usdt3_arg_rets[2] = bpf_usdt_arg(ctx, 2, &tmp);
> +	usdt3_args[2] = (uintptr_t)tmp;
> +
> +	return 0;
> +}
> +
> +int usdt12_called;
> +u64 usdt12_cookie;
> +int usdt12_arg_cnt;
> +u64 usdt12_args[12];
> +
> +SEC("usdt//proc/self/exe:test:usdt12")
> +int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
> +		     long a6, __u64 a7, uintptr_t a8, int a9, short a10,
> +		     short a11, signed char a12)
> +{
> +	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	__sync_fetch_and_add(&usdt12_called, 1);
> +
> +	usdt12_cookie = bpf_usdt_cookie(ctx);
> +	usdt12_arg_cnt = bpf_usdt_arg_cnt(ctx);
> +
> +	usdt12_args[0] = a1;
> +	usdt12_args[1] = a2;
> +	usdt12_args[2] = a3;
> +	usdt12_args[3] = a4;
> +	usdt12_args[4] = a5;
> +	usdt12_args[5] = a6;
> +	usdt12_args[6] = a7;
> +	usdt12_args[7] = a8;
> +	usdt12_args[8] = a9;
> +	usdt12_args[9] = a10;
> +	usdt12_args[10] = a11;
> +	usdt12_args[11] = a12;
> +	return 0;
> +}
> +
> +int usdt_100_called;
> +int usdt_100_sum;
> +
> +SEC("usdt//proc/self/exe:test:usdt_100")
> +int BPF_USDT(usdt_100, int x)
> +{
> +	long tmp;
> +
> +	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
> +		return 0;
> +
> +	__sync_fetch_and_add(&usdt_100_called, 1);
> +	__sync_fetch_and_add(&usdt_100_sum, x);
> +
> +	bpf_printk("X is %d, sum is %d", x, usdt_100_sum);
> +

debugging, needed?

> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> -- 
> 2.30.2
> 
> 
---1463809791-1601919008-1648742090=:29864--
