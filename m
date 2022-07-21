Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389A357CE47
	for <lists+bpf@lfdr.de>; Thu, 21 Jul 2022 16:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiGUOzQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jul 2022 10:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbiGUOzI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 10:55:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA82191
        for <bpf@vger.kernel.org>; Thu, 21 Jul 2022 07:55:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LE7Le0026435;
        Thu, 21 Jul 2022 14:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=ysV7Bz57vswaQOmsK15eVtGDbwdeygFbLQHGLBx+M9o=;
 b=loI1VmlVqQMIhFJsmF75buFIh1EcZIgX0bYr3zn/op6wS/MtcuOvAgEBYBdTHzgWt9fI
 RCtCq0x6kzrMSPw2ktPK3EULF3vy2eHgco41BsinOs96704+0PFYBLX09/qm3IKCpbVa
 TCdnHh/jKDlzF99dNJ50vXfEz422EP44+SRW5P1KXRtVwm/TMJ/wYjngX/ZDrW171fjt
 3xByACnOwxujRXNj13RAT2GQdNQfVTeo6y76S3aIBDS+rUKDdiNWys2LYaDOznlhGumq
 fOzt91tkphyXzuXFrHJiNKbwMcVTYe/Fw8ljQU66LM/UFs5fqS5qOsoHcqkrPEryoqk/ jw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7achsq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 14:54:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LD9jV2009873;
        Thu, 21 Jul 2022 14:54:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gjfyyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 14:54:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2ZNYHQKbx0ra68ljCgyhxAMvikGij95ma5kBsTJpfFat2RtB70iuaA5Nc2x++EnOk44VioMu1/Wcbn/eVi6TJsfK5u9IMWeXjZsE3J0LR8QDqFsmaDTcG5ft5pad4KHSpO3pnBmfG5jt8aWwFiKslrgB7K8bT99q5/gF6TmRDs5IJy9fCpFftoEH7JPEh73WZTbIqXnid+q28ZmZVCv4v9zEShDMwwzpV14TD6wH57L4DZhdCXtU86OCfCs4kNCbiNa0xI09C3hzG0oWsYTfBVdSNB08XSpVSJ0MgKMMawDCSVgFGvCF65i+5tB7DorOL4o84G4y9epc0f+WFIJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysV7Bz57vswaQOmsK15eVtGDbwdeygFbLQHGLBx+M9o=;
 b=mc9i0iWdz3/4jkFUW5JAEw8F8/F53CqFG1Uz7QmtFs8mLvYZd3pyOgdQeJ7XqHc6mJBKWlANBuDZ+XSct1wrEqYPxCkhJeQN9aYMk9l3yqohIDP1M8xvbYgUTiEa8BVtRIb6tJ7y2L4X60GcHbl6td8A2Q3Jm0QdUceSubCd5y9pbd5AG9iFgsJX6PZeHaQvSkSxejXIt1MRhcRKL591Aw1WS4h63X21nBhgbRNHqWNiYQnPgba8e0bWgkHsZ1nokx3F1Ty6NwG38juEtcmqZuBceGFb2BxqJoIu5RwppFLKBy7GlOeiydE9z3IwyutsaCohulGxXYDbQsir8OkEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysV7Bz57vswaQOmsK15eVtGDbwdeygFbLQHGLBx+M9o=;
 b=sYT+zSjlsFBIEkQGxB9O+aueWwEKzFeHDdUQAciF3izm6qVQMNiKYvnq00fADCJfaQIQ1/AZbTqSdQYZU2ZEtIYVATUORQV7w2/iCHGqRiKzYb3vCksrTh+fysmaQRWgiDQDm9OonCrsK040TYkXHmlj38LVn7Oz6+dKCnKDU2k=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM6PR10MB4076.namprd10.prod.outlook.com (2603:10b6:5:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Thu, 21 Jul
 2022 14:54:49 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd%4]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 14:54:49 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     "Lorenz Bauer" <oss@lmb.io>
Cc:     yhs@fb.com, andrii@kernel.org, bpf@vger.kernel.org
Subject: Re: Signedness of char in BTF
References: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com>
Date:   Thu, 21 Jul 2022 16:54:41 +0200
In-Reply-To: <3fcf2cb7-8d27-4649-b943-7c58e838664a@www.fastmail.com> (Lorenz
        Bauer's message of "Thu, 21 Jul 2022 15:31:38 +0100")
Message-ID: <87wnc6bjny.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bbee5ec-9c8b-4a63-c35b-08da6b28f585
X-MS-TrafficTypeDiagnostic: DM6PR10MB4076:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: REtbUBsVKtM1K/iCvj+tWyeh8b6bUnYpL4mSOnrGhwGFHKxAxQ2VwitkKEDI9wA8OaupJbq/EMKjS++Te2Zibk7uNn/hiE+JSSLJImHc5mNJsMx75/6dw0/WxLdflFuWLPkSW1hM+LHKfuIIqOhbagqxab6qSp7PntSSmzEQoTKVgvMXrPN3OERFeitCDitUifnjIAD66xATtGqZ9YXQ6mJdFjO3dWhWbuMGH4OwOVKeBLzJhYMoNUP5SsieGlzR9DEdopr/NwmCAyIFLXmzuddRQlzO6Iv9PhWFdrJy2zMIECCXZxCLZkxtpz9Cc4QFsQ3mGHeymlywXUenDmTsBiWlLvbpIL2SrQ5qEGcv7wQCDKW3eXsp+Qt4Wu95PPIyg2+IohYQc5+Csz31TNsnVOdls958InZvfatTDyg6ooLq26dKCyvlaC2IHuTNpagFM8IeP97bZIQBTIX+4+TrH+eFu27glKODxhda63wLLnktXkClht9BjIr5BZAwBWPP0qWCPq/yDNebR3Rtx3rnJPDqsItpNiVwxDpGQGDCbQmFRljJencaAqzJh55LbAQk9oVQRmUPUizuSM8ejYI4uMLZbqv8xlgGtYoZ6kR39Wr9hdonHZpAkpGs0rsDGMKSxzkSp8R5H7nknPQayILF5erHzDOzowCHgsaiZMo++ppoKnuaBlrKHzlu4Z54DhahLWBLTeHTPstjii8vkIXfuFbrX2mzdap4sKl/A2bjIFGj+7G/eQg2oksufQewXB/qDuIb1ZRvg+vJpO2+UTvJkLMWhhk6+hozA2cMdp0dETb8hg7s36oMZaBMdhi9VziVQgKQDl5IHp9iy3pPcJu+ja3oX7IfMbYatPTz3o5/Pxav4ZjL27KxTVLVaP/YgBAz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(376002)(346002)(396003)(6666004)(6512007)(316002)(6916009)(6486002)(36756003)(41300700001)(2906002)(966005)(6506007)(66946007)(38100700002)(86362001)(26005)(66476007)(4326008)(8676002)(478600001)(2616005)(8936002)(52116002)(5660300002)(66556008)(186003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cn32yXKMVhuDJdjaRCxgGV/fDrgIQ2LmjpVWog1yLaK62RhTn0uAkIcWuyja?=
 =?us-ascii?Q?SHd+F9Z90jjzcOa07elsoXIHQPORZnoIqAH8YKu4VWXMfa16M6yRuhcaUQL4?=
 =?us-ascii?Q?StD9Xf8d6vC/KRmcQoNyH5FH5igVRGJIsBdnCS6bszLqcDxN9+5qR3TsESUr?=
 =?us-ascii?Q?scYgUiVJsumJGYW+AD82r6kWU+K3Xrz+9VhKIJ0tKDVZqbl1qoymxgG5+yXF?=
 =?us-ascii?Q?bIJJUHzIjhFrQMOxtVAVNmn4fSPjwlUy1kCUDmLty9MdkMVFex/sAsQmmkYp?=
 =?us-ascii?Q?WKklxhiehlP1BH6N3XZO2qGwHVn0WZmrqzn2Y9BTqdhqTxnUaRZzjr4dGEri?=
 =?us-ascii?Q?+USfxmzSbr+8afoBZQH16WRUCeaH0oKqqWAhQFBncb/1JFtUPgWzFkImkitn?=
 =?us-ascii?Q?19s7niq1C7ltunsSsz2ioq+CbuHF3oqPNAlua6dNlxcAK8SvA5hZIBJ+6biO?=
 =?us-ascii?Q?729X/lMnxUclCm4VsY7aFCGzOZMdCi6e1i+qMzoTkWfbDRUCm50GHC1BfTRz?=
 =?us-ascii?Q?H04iUlv91y+zKGufpj8PyqAjzuzzTHKKGZhxzMP3+JRbcY1gaDV99BIBMFQM?=
 =?us-ascii?Q?61NB6poRNOL3EG9fllvdS8mYW7g17Fs5M2o3p87/ZRVB1IY8M+HrR7MMe+i6?=
 =?us-ascii?Q?HSP+E9O7lVklBwfPh9MhXiu2j8E9nOc0Wtm/ptsZt3iXtNLbfQw54Gb1ujP7?=
 =?us-ascii?Q?6scACHpNRjSkFkPJ+U9DQkca6w294hWeAeaVf71yRifJMxGfMzeMv7IOhHLm?=
 =?us-ascii?Q?fEtOWCGGfTkdVB0S2H/jLJ6cHdxa0ipANQh1ypJYQsDiNiOmCrf05D6cpK33?=
 =?us-ascii?Q?fApvLGNBhn54+3h3CPaRHbxxu5Dd+LZvfEuQS6CDFk3tDj/2UfxBs5mvrxdt?=
 =?us-ascii?Q?ZGA4z0hF4bCvlucZKA9DD0hppQpUTTNK866h10I2UcGFHnugLJNnHhn++zNe?=
 =?us-ascii?Q?JcQXxk0rUHrQzq49NJh7Nc8Bi6OhLAi5F9rcRXLCszD5FaH4/AWyPkGwFCki?=
 =?us-ascii?Q?evtRghZEkxZx0pGvKzeQ0qe3qu5Nf4xxGeob6BeYZLZIJlqSF0Pw4oZTnclD?=
 =?us-ascii?Q?YDZg6UME3rYTxD6NXr3ZgLacq0e/OJzaahIe/zpLfig+vnaPAnm39CQStco9?=
 =?us-ascii?Q?BHUmYFu/0I/Qr+am71N1CRGRWidnma+/lMuF2GuuI8orogbafPNYMvwVztu3?=
 =?us-ascii?Q?oKi54Td/j/GRLZ73FXbyrL8Zu95wev1uoGl+riz4NqsJsV8tPSKURnAaQROb?=
 =?us-ascii?Q?/I1DrYvCvCgZWgEuAn0SYZM6+3GvH5m7r/GcM32gadIO3VhF2H9LOOZL6xKV?=
 =?us-ascii?Q?MLq64yGRPJXCmB09jR6FyCK9WYsZyI7Db4MnAOIa9kaeX3fAxFWrM7Z3mqlZ?=
 =?us-ascii?Q?ewfqtlnUrzq07XNbYqTyxBJFyC0rNfdgli1RA+UcGqFq9Be1veMDJOZGysN1?=
 =?us-ascii?Q?pYmCCWa/ZkZB0qi1KLnS7w4dTwN429P6WnoRnGgP3bZkYNN/ZWvk2ouaRw1c?=
 =?us-ascii?Q?fJo9dl9Jv9PmcJ39CvUDXhsJSNlFDTFZ+8Jp8uDiDUsBO8GZfmyCSYrn/13I?=
 =?us-ascii?Q?x8yKR2wq8qQBKSwZz9cEftZnXoyV+j6X3944MhMOzLRD3CPdZSOWTr8xSL0f?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbee5ec-9c8b-4a63-c35b-08da6b28f585
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:54:48.9800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gu77bh4RaMRvzvqwwWETnI3CvMpc1vxYBA0odWgPjSTW3kkmrba6mGXg6PeBO1CM2bJFGMj9fiN6vYSyKwLan+TgAtcqDat8I2wjBck1jhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_18,2022-07-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210059
X-Proofpoint-ORIG-GUID: 2BtiR9u2kTETKAezUAfdSwAwz-TAXdHT
X-Proofpoint-GUID: 2BtiR9u2kTETKAezUAfdSwAwz-TAXdHT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> Hi Yonghong and Andrii,
>
> I have some questions re: signedness of chars in BTF. According to [1]
> BTF_INT_ENCODING() may be one of SIGNED, CHAR or BOOL.

I have always assumed that the bits in `encoding' are non-exclusive
i.e. it is a bitmap, not an enumerated.

> If I read [2] correctly the signedness of char is implementation
> defined. Does this mean that I need to know which implementation
> generated the BTF to interpret CHAR correctly?
>
> Somewhat related, how to I make clang emit BTF_INT_CHAR in the first
> place? I've tried with clang-14, but only ever get
>
>     [6] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>     [6] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED

Hm, in GCC we currently generate:

[1] int 'unsigned char'(0x00000001U#B) size=0x00000001U#B offset=0x00UB#b bits=0x08UB#b CHAR
[2] int 'char'(0x00000001U#B) size=0x00000001U#B offset=0x00UB#b bits=0x08UB#b SIGNED CHAR

Which turns out is not correct?

We used a signed type for `char' because that was what the LLVM BPF
toolchain uses, but then we assumed we had to emit the CHAR bit as
well... wrong assumption apparently (I just tried with clang 15 and it
doesn't set the CHAR bits for neither `char' nor `unsigned char').

But then what is the CHAR bit for?

> The kernel seems to agree that CHAR isn't a thing [3].
>
> Thanks!
> Lorenz
>
> 1: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-int
> 2: https://stackoverflow.com/a/2054941/19544965
> 3:
> https://sourcegraph.com/github.com/torvalds/linux@353f7988dd8413c47718f7ca79c030b6fb62cfe5/-/blob/kernel/bpf/btf.c?L2928-2934
