Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4656A5622
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 10:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjB1Jvp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 04:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB1Jvp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 04:51:45 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE51223840
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 01:51:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S62iCB018895;
        Tue, 28 Feb 2023 09:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=RRGOo0koLZgfGp9bpyTl7M/1a1eA/t8hlXas8ATXRo0=;
 b=KlOXqJ+4WRWmyen8PIKkM63uBef8xaurQuFOQmW8fhMoCmuaKaN49PETdJ9DoRlqGnG/
 2Qr35m11qG5EYj3pWD4JqZpzhlX7hihqLaaHHM5OWhiwMWNHgw5+koxgca76A9kAkynE
 8i3CxrLWeTJkoy8DZT1smwbhqkM+WK5ZUJO1Zo0jS9G1gqij1DKwHh+QAmc19r+dI7lP
 brxcFQ8uT5syspIulK1H/YD6u4rcLy8/SOVWjN1+oWHH4zv8ATpn1XhIMiPt6iRnd6WG
 js22MhKp8Of9Tf/B1vcJtmJqa6omKthJjaa4DZ7skLqAFWrzcVr/lVnvMCm27lVnh5tu Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7dpua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 09:51:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31S9YbDU032984;
        Tue, 28 Feb 2023 09:51:38 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s6j2qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 09:51:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VoYqVvv58XZr869vEf57CdpqOpjRO67g1f5ML07xUTwh6lygPFwKNTFDuvpesGKMXxwh/AtW8UM3Z2O67/yN8nQO2ZJLIIil6c6+ioTpqTauA+k1fxjsMK0GX+w4qee3uPowNhousXMlcTP6+0UBaN3qZHoPHjPj05MrEGJGVszcY65VhAnJlavc08feai+/JX06ex1/4hLprrtNk4dd21KrVEC9N9Cki9jIibEefqaqn08u8zSJUddqW/lJL/E05W/3oUxZKvR4CXFHb6A8CAqPt+Q9MkHsYsq/9PB2+piIBh7kz9wL6a5ugc6hVQYZnuLjvTwEeN0aqW9Dbr+LUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRGOo0koLZgfGp9bpyTl7M/1a1eA/t8hlXas8ATXRo0=;
 b=DGFFHNt67LK3m9IQm/cWx+X31OhfWSyVgslJYc0hkmjGr+mFSudtgbQdrNDDwaAoBHBw12YVFgGr4guNnJ4ySKLmHkDG5rZ1APipelXZ/H3vblz/6upWF+C2GIHSupREEz+ccFhaGeFQ+2VMlDce7dTRPmhgGxMIE+K11r80sckoyTbTlBcgXZOWdhSqMIG2SscjB9HAP2levtF3d3TyznkR2V+Wzq780G4tUBeW+XcwHX4yNyxMGYXhOG0LM9r1Ko6WgdeKXDNvcb2pjfwO2IwvwlPfJWzhuuvFzheqymYcz7RPd4mZ2hFbnGFqvjttEYU6cMhDTuFvV/y5GApiRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRGOo0koLZgfGp9bpyTl7M/1a1eA/t8hlXas8ATXRo0=;
 b=v6dMQMIMKTxjoHINXqRojq0LGbFfY40+0z6/wXdsEBNSMrourMjz4PK8osiKyyv6Jj3Z1jGnEFlOGNa+nwee0bGVqbl++9T7J3EoL8sc/Min+VVxj7KMo6xXwsxtvG0W3/R284pAbxiGBrAG1+jZfmVaTbjfRpLavH+F/ADN3/s=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CO1PR10MB4756.namprd10.prod.outlook.com (2603:10b6:303:9b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 09:51:35 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::486a:626e:635a:3ce2%3]) with mapi id 15.20.6156.010; Tue, 28 Feb 2023
 09:51:35 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@ietf.org,
        Dave Thaler <dthaler@microsoft.com>,
        David Vernet <void@manifault.com>, Yonghong Song <yhs@meta.com>
Subject: [PATCH V5] bpf, docs: Document BPF insn encoding in term of stored
 bytes
In-Reply-To: <d3dab9c1-5bb8-a23f-5ef5-2973ac05a554@meta.com> (Yonghong Song's
        message of "Mon, 27 Feb 2023 23:00:24 -0800")
References: <87r0ua7fu8.fsf@oracle.com>
        <d3dab9c1-5bb8-a23f-5ef5-2973ac05a554@meta.com>
Date:   Tue, 28 Feb 2023 10:51:29 +0100
Message-ID: <87h6v6i0da.fsf_-_@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0108.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::19) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CO1PR10MB4756:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f0930ea-a1c9-41de-28ae-08db1971612e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7KpYFCHPpzCBj6Omq/0PLndjw7e1UMfWJYzzhP3ygzKM5CFZqmYdB9GXVZ5AVylPF0VWc8uAfwxfhaKjfojdvFWo0uT7e0PFT/6wG7BZXBeIUGDHbR2V7sG/IY/8aA0cR5DMUWv2W+IconJgK6z9HL2KT9XgVn7FXCcjXJreBk5s94Cw7int4mATkX88dXoCxcrAcI3ddjFrrL+aQ4sw/HqPMP7wmGJMdZE7Woqy9UIQA1FF/jGc3UVfEvlm9JXZ6Ue/Lfgfmocrx80ehLeyg6rUorsFFWAIhC6Yr+d9EAbkLTjNR4+uJuIpLi9gEZ/O7afG7oIpURx6zIbslQAxjjoH0nVoFpOo2W9b3lg7iI1S5hzxqap5dxLr790w2FQh+XIqKfigztB9OpEz8PRNX223xLostS6PX2mlGPhXrTRk71zlIhqYBz8A70jbpGiuw5uihPRhfA3uy/f+62TLR3KB60apmK64lcKddQnq2kaAZ5ArU2lf47rDpFEgjdr5AI/UXLsEWHJAfgPgbY+sn9fbbbGXQUHKLBYrg3lab+IlEQ5pOYmb/ZfvmBT5Vg8xBFyKjpA1AwtIDchCss2ocnMKUBlKORuR/8LtvZg8lsdNyJ7mtUSn5ih2uk7kgWpwmnseL+KGiSS1K2SDLo0Jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199018)(2616005)(86362001)(316002)(6666004)(6512007)(54906003)(6506007)(36756003)(186003)(478600001)(83380400001)(6486002)(4326008)(6916009)(8676002)(66476007)(66556008)(66946007)(8936002)(41300700001)(5660300002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jkbuIaxzyJfP70HTXlJwpRJTz5H9Y82EjcBUs05H9pxrl3bc9ouPSf2O7J2F?=
 =?us-ascii?Q?9ahIEeoP2JlyIeodYzdD72CV+0sW27T2gNtbi9y5xlzRKQlx7o7Gd20AugHA?=
 =?us-ascii?Q?dHgguFG7E4aYc4h2huzk7JxCgRX29jjb17NkJwWuydNLYaZ8PMPytmowJrD2?=
 =?us-ascii?Q?UzTYviChgAlLIXMa5C4t4rs8KBji2BxDvf/JZRWggiEPA/Lj9Vp/9S/H0/xZ?=
 =?us-ascii?Q?QmgokmbwY79SiROau8yjJdqPSeuoXXwBhfth7XFN6PKlwaVa+aEmSmwKv5r4?=
 =?us-ascii?Q?4psBDj90ev34UrZBFMmeADDU0QyJV3SmsbJhrBl+p3+OoalGB+/YK2JD5NkC?=
 =?us-ascii?Q?/QTntRB/8EESfGTkko2Qg6+5shyAqJ2Pqq91BykI3d00SVEiG9qCNqfjr+ks?=
 =?us-ascii?Q?uFInpXs5GRHVeAxAYFrd+UCRmTTF8O9NGL9jlPhrs0A+csxJXFLocjCmtZW1?=
 =?us-ascii?Q?veYybUplI3KmNBjo0yEJbQsxackfVdbvjtjbGT+9xjZESxTdG24l7ku3snOs?=
 =?us-ascii?Q?7PR+JaJpCyfDlO7XdiPm7k2aDcSPYCaf72WHThPCCU1hYnmyKfEhvlu2PDdX?=
 =?us-ascii?Q?w12JNc4cOrvY+Z7hxprhLFQSgz9m/u4uJvxYPH89/GOR/UNac3/4m7tDsfXu?=
 =?us-ascii?Q?dB9z549RisYLaA/BnAdQTR0xvhuzGakFPFLNmEZUENj9DrGyhG4g8+SFU539?=
 =?us-ascii?Q?7u6E2kiMMjg1KjWuA55ew4JhAuwXt3kiL9T4i4dfBX7Sy9oCAdUqOXkm+GSD?=
 =?us-ascii?Q?0IyAQNMP3pWPFs7NYThJ4WgoddHVpOd/NHBJAdB+cvfzMt43Wqp6oGrl0w/I?=
 =?us-ascii?Q?L0dZvWIbb4HG23ldYS/z240Pp73XgjXkjXiI1pEaVcSaXd0JVqhxRJhl/SFT?=
 =?us-ascii?Q?RnRECl9jYelWfLDA02u0/zkaE1kxJTAnxG6J0qWwtx261pXZQlX8OLYf9+E/?=
 =?us-ascii?Q?UOSHlpv6+GwLAkpc5bZyfo2JSyFZ7gpraO0flRzlNgSf/ouuxwGq5PZuN9Lu?=
 =?us-ascii?Q?uxAT4ApMckrbSulDULh6RWOnfSMGIsDbc+kfCWMRNBfnX1OluREKdlr+hRoV?=
 =?us-ascii?Q?78LtmGxPBzlHyyGe6MbHIqVAvpOEV780yA+SVLeZ3NGzRNVXzxEMW57CA8bK?=
 =?us-ascii?Q?giVgfDSjF4H4p8ikGX9yzryIt+LjlPH21jbyvA4NqTwCDlB5KjbWEf6TVjjp?=
 =?us-ascii?Q?jYE48CUlVNDHwlvUIuKRwmJYvVm/Ow9sp9yiPYhX8BxMTjfPCqVQnVjDlsMz?=
 =?us-ascii?Q?HoU6796EP8Pe+wSFXOiIrjVgcvgCmrDuK+rtZMRx/+6ORt2yeN7JlcHRxqHB?=
 =?us-ascii?Q?67HMu+0VmaP+Rlsck+MT49g+VWDpX2Du8KMtRcm14Ub5iz0lygpeBCGSaNo/?=
 =?us-ascii?Q?F8C2FJ5Nr7B/CinJRLFxIzt9cQKBQuYz+dq7psJWAs1EAx3GjpRrO/YntKtq?=
 =?us-ascii?Q?U7YbR6r0/eI/7siUkpLUI16GKWF5LdKjd4EOjjJXql5623JMq6BwxUqb+rnZ?=
 =?us-ascii?Q?cdtLRmkJoBcR0Z0qWR2wd5eDO4IIC4ku8bOcDUFyurKRCdcdVE8/HTHye67/?=
 =?us-ascii?Q?0xm9WWOlY5U4xDjbjX8po4745ThyRv+liVYly/oN5utf2Nsg2ZXlXOJudqAP?=
 =?us-ascii?Q?fhmYm7Bm1MiCRp1bVFBNAz2FpoFdck7RZUH05h7c3ypN/L5fQT6sdtYWqM8s?=
 =?us-ascii?Q?Axg5AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e+LwTOyNq947pmYH7QPC1LiIOb9MQQ6/NR4xXNMotMxpuiS9tLFj5SeViR44Vl9ZkuVItr+hF2yNgRTZ8Q9OjSppEA/pmQW2Ojr5oXXBFRPDgX+f+tEEWX6PJaEy85nhNPK4cHOt3vmhfqz+YAnBIQy3Mo4mKNEA5HNyGkZ6R/IVUEIJAVMZMbhQ8IdPcL0Aw5aGcWWY/AaGhjHZiOZRadOuMIsM1E+MoXy038IZNWny1X6zfTWeWoGLe9qtpavWT2yihqMdLjyoKZl6nbPMCieA3Ijr1fm7HUgsnz599oMrncUJ5x56O6LahbNet0UzhXar6unUNkeCjlM+ETimrQiwPPZllrVuZbCsQvOWb+Cw82NrrfqaQs8BpuD/TBv86x3pujujFXxOWva2fLjPhiiLCYGvs5KePwB/43OtoZHONYkGPAgS3crxVkuLnStbF0M2Q3dyHX7NRaVyrK0HFvxLXF/dLnWLF+lXwFe+kC1dSB+5GTvxaaCdAxvBqJtBEP6paQGGWt6I8509JyhYmxNhWuBtCbcGz3dte4dYDB7NxZ+NYyaIOWOUpOKh+LptQGsKPUvAkv9QkTXar/iFRSpCtftlc4ljV0lfB4VzAx/NIYOt4oGt5V/KaXClRzNw6gTqpz8qFvr+2Ssg985XI+M8O3f7ITW6FqIbHEjSjGyzBtHRgkLFxh2LNJN8pTdyEzK1DPCZqOFPTMph5XL9lfLd6N8UjBqyS16qGEcWcg9Y6SuS9vwN8mMTUZfA+KQnJRVY00FxOLeNhpnyYMoDqEIKANTll22LhwHIBWQnOPFNwhfI2LFn0ljsciQsqjAkAUE89XOFCxfuAmoGKpoP5um5iSysnoqFGhDgFk3kr330cw7hq4wzhWeDgEeBXzC+PLoBqP8M41QkSxLOB3zk5hjf5wnF3AMLpIZeYg03Mww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f0930ea-a1c9-41de-28ae-08db1971612e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 09:51:35.8127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+xJALIHob97P9wadYDfEFJ4EH4yIobuqYtYxkDjv+6+GXxh2IOnJ1Ku1NPg07Pdm2X1Ra3fS8RtpLxHutOPU7HgATXkiE6TniwYagGpRlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_06,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280078
X-Proofpoint-ORIG-GUID: -3c5m0cB16ZM3GUgOo8WnIF2tyEQJVM-
X-Proofpoint-GUID: -3c5m0cB16ZM3GUgOo8WnIF2tyEQJVM-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


[Changes from V4:
- s/regs:16/regs:8 in figure.]

[Changes from V3:
- Back to src_reg and dst_reg, since they denote register numbers
  as opposed to the values stored in these registers.]

[Changes from V2:
- Use src and dst consistently in the document.
- Use a more graphical depiction of the 128-bit instruction.
- Remove `Where:' fragment.
- Clarify that unused bits are reserved and shall be zeroed.]

[Changes from V1:
- Use rst literal blocks for figures.
- Avoid using | in the basic instruction/pseudo instruction figure.
- Rebased to today's bpf-next master branch.]

This patch modifies instruction-set.rst so it documents the encoding
of BPF instructions in terms of how the bytes are stored (be it in an
ELF file or as bytes in a memory buffer to be loaded into the kernel
or some other BPF consumer) as opposed to how the instruction looks
like once loaded.

This is hopefully easier to understand by implementors looking to
generate and/or consume bytes conforming BPF instructions.

The patch also clarifies that the unused bytes in a pseudo-instruction
shall be cleared with zeros.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
---
 Documentation/bpf/instruction-set.rst | 46 ++++++++++++++-------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/Documentation/bpf/instruction-set.rst b/Documentation/bpf/instruction-set.rst
index 01802ed9b29b..db8789e6969e 100644
--- a/Documentation/bpf/instruction-set.rst
+++ b/Documentation/bpf/instruction-set.rst
@@ -38,15 +38,11 @@ eBPF has two instruction encodings:
 * the wide instruction encoding, which appends a second 64-bit immediate (i.e.,
   constant) value after the basic instruction for a total of 128 bits.
 
-The basic instruction encoding looks as follows for a little-endian processor,
-where MSB and LSB mean the most significant bits and least significant bits,
-respectively:
+The fields conforming an encoded basic instruction are stored in the
+following order::
 
-=============  =======  =======  =======  ============
-32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
-=============  =======  =======  =======  ============
-imm            offset   src_reg  dst_reg  opcode
-=============  =======  =======  =======  ============
+  opcode:8 src_reg:4 dst_reg:4 offset:16 imm:32 // In little-endian BPF.
+  opcode:8 dst_reg:4 src_reg:4 offset:16 imm:32 // In big-endian BPF.
 
 **imm**
   signed integer immediate value
@@ -64,16 +60,17 @@ imm            offset   src_reg  dst_reg  opcode
 **opcode**
   operation to perform
 
-and as follows for a big-endian processor:
+Note that the contents of multi-byte fields ('imm' and 'offset') are
+stored using big-endian byte ordering in big-endian BPF and
+little-endian byte ordering in little-endian BPF.
 
-=============  =======  =======  =======  ============
-32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
-=============  =======  =======  =======  ============
-imm            offset   dst_reg  src_reg  opcode
-=============  =======  =======  =======  ============
+For example::
 
-Multi-byte fields ('imm' and 'offset') are similarly stored in
-the byte order of the processor.
+  opcode                  offset imm          assembly
+         src_reg dst_reg
+  07     0       1        00 00  44 33 22 11  r1 += 0x11223344 // little
+         dst_reg src_reg
+  07     1       0        00 00  11 22 33 44  r1 += 0x11223344 // big
 
 Note that most instructions do not use all of the fields.
 Unused fields shall be cleared to zero.
@@ -84,18 +81,23 @@ The 64 bits following the basic instruction contain a pseudo instruction
 using the same format but with opcode, dst_reg, src_reg, and offset all set to zero,
 and imm containing the high 32 bits of the immediate value.
 
-=================  ==================
-64 bits (MSB)      64 bits (LSB)
-=================  ==================
-basic instruction  pseudo instruction
-=================  ==================
+This is depicted in the following figure::
+
+        basic_instruction
+  .-----------------------------.
+  |                             |
+  code:8 regs:8 offset:16 imm:32 unused:32 imm:32
+                                 |              |
+                                 '--------------'
+                                pseudo instruction
 
 Thus the 64-bit immediate value is constructed as follows:
 
   imm64 = (next_imm << 32) | imm
 
 where 'next_imm' refers to the imm value of the pseudo instruction
-following the basic instruction.
+following the basic instruction.  The unused bytes in the pseudo
+instruction are reserved and shall be cleared to zero.
 
 Instruction classes
 -------------------
-- 
2.30.2

