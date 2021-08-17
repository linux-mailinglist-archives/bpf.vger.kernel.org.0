Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 951283EE60E
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhHQFJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 01:09:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63524 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237458AbhHQFJf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 01:09:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H51xH2018803;
        Tue, 17 Aug 2021 05:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=2C64agNVx23skZWUBh3Ar6Bn6C1b+Nq5L5RCZRUWKUs=;
 b=RqwB41mBi1Euz634eSeCfpZyT9TEIFElJ4GxtwlcnpAD78sXZmLMNKtY6YyaZrRaXilg
 fF6/Lto8pciAFCrCPSeG/W7ToW7aL2iuxAtvkgEzqyssNENdsSWcFDN8eFgnA921KTZO
 /qbE7YtafInepiTVojmD5UBBoBAPYn3uuSYfMF35nX6K9mSx6DbQiPU6UfzT8h8ceM6h
 5hgIu/2euLSXtqDtGr9Rjwjw+EmM873ecAGHOkieOwgQorAF+sAA0QnsbgBU0CqEbfnO
 EZDXjALzinEwzSm67Adl5xsxR6KGOYic1LGK1lL6MT76ZCSZOunSvGgfhgJK9wIUAKWw GA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=2C64agNVx23skZWUBh3Ar6Bn6C1b+Nq5L5RCZRUWKUs=;
 b=j7RhJCh2GFGhuh+hOlmq5At4HkZFhdthpiCSr2mbDHSctWBFtZvdKqDhJuxcHk7siR2c
 uLWBANQq8Wd3E6AnmTU1Bm9LAf7aCeKNiueRQeamPHtBFAStyGhasr41MHuWEyxBLTEq
 vZ/doFdFfZV8+kXE6Y4mQZzxeb1dkkh/6kQQhLa1afJgeaoExph+eCEJKfewhf80/1HQ
 BuIlQu+MTHP593dcVV01ifFCi2SlvczQ4JeI9CL5CdQEnyu3LpmLwISdKyzupk9KcITD
 jmXWS4jGoaGGNfQqPDFPyqJ1XrVbxIsEmoXAuzl3hgP8iz4Ey/dLc+nuI1bEDlTGravr sQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgjsd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 05:08:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17H510Cv108045;
        Tue, 17 Aug 2021 05:08:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3020.oracle.com with ESMTP id 3aeqktedsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 05:08:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXkUr3zh6T+1xkEBo30vF2go59UB3dDY09ZaEhF+XtQv1wwP57oxpp+KkWmMkZcE3waIyJO8lREfyqMoL75g0lk7arHJtmzo2+GlLP88i233+bU7lNosA6/j6LQsMlx6zBUDMBBDFrVT9yB8SJnJh+G/4CBTyno3APGtYPOucrB3bm42HNMgNBkDud7DXH86n2RU1x+4rP8cwqPk8miu7VGxB8pGb2bh8rU3WoPCsjEpe39cAot/LVEl/lnzal07Lu2piDWcpQIWPPcNemVA7kQ5lfs+sDjXwSUIFw20qMFH8wB25KAszjghgAkLnuD5e8wXD13kfWh8TgOxK8MMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C64agNVx23skZWUBh3Ar6Bn6C1b+Nq5L5RCZRUWKUs=;
 b=aGneCqGL5Vc8E4sf2QTVUJQ9ShFtKEJz8pgJslJBqGHuz6v5YEYDnb1jQWVHGUtdPqu393YOF8ENGnsLEr+R1as0Eg9xXl4WUJx5XAs3QRpU+Phae43ZvXjw1Zbuj4bH0aixK0rQn64RuItmcsjVZDFiJw9rqCnIosrFjXjK7aiR0MAavywVqHbfxKoBcR+dmVBOCIbhDbsh14goJyfLdfLcGfBMFS7ddA+SWEXqCz5p5VqThEEwACEXE1Xf812MQrAIkpOotfUDUCcFaSmL9tZ7WLnhCn75YNhfLWtlI+T6ZgAdPjg+xLbsepwwlxyyjAtpw47xxGAhtw4F8MgA2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2C64agNVx23skZWUBh3Ar6Bn6C1b+Nq5L5RCZRUWKUs=;
 b=bBlieDsWsMFOquRj19s07jiBLKb/Vup/39GH8NLXQ4TyMoY839q51n3LLdxwjOlrY9iCRQf3uyd7bRqliNlA1GVGSSlPGNBAkIVXdnqdZxkGtg8ovkl7R/HRZYgeQJYbXbR/oOoH/XMH9U7U+fBb3q2ockqqMcvfl4a5A+2mvBU=
Authentication-Results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4484.namprd10.prod.outlook.com
 (2603:10b6:303:90::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 05:08:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 05:08:55 +0000
Date:   Tue, 17 Aug 2021 08:08:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     rdna@fb.com
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Allow narrow loads with offset > 0
Message-ID: <20210817050843.GA21456@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (2a02:6900:8208:1848::11d1) by LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17 via Frontend Transport; Tue, 17 Aug 2021 05:08:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27157c98-20de-4a6a-170b-08d9613d1cda
X-MS-TrafficTypeDiagnostic: CO1PR10MB4484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44840FEB6A7FBF603A3641778EFE9@CO1PR10MB4484.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DzACqNWV/jt1eGcXpsAE7oD6P8ZR0jyizvc0Rg/WNuXqqs6dmCBhBOmKonc2BAlMa2W4ZuAOJdy1r6z6N0AhWCO7ZsCZ/YDU92uD9pwNu7KcXUkYSwMKy5S0a5GUYL7HExEiBelmPQgm6eZtkSoFUMpC9sx3l6anfPLocHoG4vBkta4m3mlHaZ2Ps0l/+aV7qhsPf52c2BcTdclRPpMvfIV6U14ffvIwMepnUEVqa6dRjWM9f/3WK17V/cPucNlfDgHuPcMNXWJLL0intSMz5Nl76e7xvYL2mAd8JxH9lrabdwKb9+LJXemPo7Y0jPdvXbzOtlujsqWgc5Uaw9wRXVGtH+0Rk/vWXGRE/zURGeqdMl8kKjN2w1l9Zhu5ZJwC+c1L9VUq9kYFSSbUalCX+WM5gIKlYxO7fQYzwbiSq/5ecllDGi9szZn7BAA8q698ccJUcK8zvks0lSVyx0Z6dAANI1KXj9sE6m+YHhuvjWhccMyj3UYrXDxZvK/gJ8mcUUppJjiAP9WIyMIYtCySES9F4OW6zuxwO10WStj1U7lDZwTK946ZFmGEQ45Bc8tzADVTR+rEK1ZA8EKX/rlGunh0+nmzL2m1PC4KpnwE5Jqkn3W8aJlSWLO8XIVbRhgHp9oABlk/4A5Uxau2fZx23Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(136003)(396003)(39860400002)(44832011)(478600001)(316002)(8676002)(6916009)(33716001)(4326008)(33656002)(186003)(86362001)(55016002)(38100700002)(6666004)(52116002)(6496006)(1076003)(8936002)(2906002)(66946007)(5660300002)(66556008)(83380400001)(9576002)(9686003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GXS0SwuqfWQtLXaQfr6/+kjUG0IT0tClKlGnarGV6XvFluCPsZx3sBTHat8K?=
 =?us-ascii?Q?LTirAurjrZNAOdT1+YM8hghojv9Ez68oK1f99GYEl2vXtL3Add9czcv/45ZA?=
 =?us-ascii?Q?kofISJAImkXImhFWmLWFEVt59yG0ODADITQfOo6cSIoJRwgFj65rlM8bxuan?=
 =?us-ascii?Q?dnKYhnk8kqLOzWUBRUMnFaEj1TBUxm/DOxxYK1TQc58gHr2voUAl87FbkAkQ?=
 =?us-ascii?Q?ZUyQIHKEo8o7Y9+bcy6rp+LLUijLEVfZSKwitlBLJqEOAhtBUCfMBdB0FPMO?=
 =?us-ascii?Q?gTPexzgOVt7400Pj8RECS6w00MplJC676Od9SVtShAq/qcLrir0R/TlHjUnk?=
 =?us-ascii?Q?yfq5s0vHNCXJ8d1MpKt0Rl2tWJ2wDMmxmY5b87CqO9eLRZtbH9GgPBzIfjCF?=
 =?us-ascii?Q?Q7XlBwfTeN8zHQ0zgYOmfupoldCdQalFGoMdXDM1a0ROcR2DeL2oDj9pHzNs?=
 =?us-ascii?Q?OntSP18qpXwx7cLxGlv+xmdrPT3WpWGi52WKaRGmT4Hp9C7M3w1cib+lHUsC?=
 =?us-ascii?Q?ZpWdRab8Dc7yHMSO3MKYETkXMr93HXCtHwRwbE0gTLLTgRR6YHyhWXGOgpwi?=
 =?us-ascii?Q?zRk37fGXKpuJvCcQsmC2R5Xqsgf4gGZL+qdrrcft2fPrgenSzbbrR+fKJL7d?=
 =?us-ascii?Q?WKjAYeXXIaRYpoDVOZBXQfbQVf2ODpFAznttQ33Wb4z9Mza84NnaNNFfjAKR?=
 =?us-ascii?Q?0nRkCpeIgj4EqXn4nu1S7o8sJW9aWy8PKRUz8QVd1qdA9rV9U9vlWF7qdxtO?=
 =?us-ascii?Q?qEa56BITdOmOCPJPJ7juesleH8hj1y32r5FR5btlgPe5Aev2aay4DNhN/O1k?=
 =?us-ascii?Q?mgNAiVjITp+ke5LuX9kagAaCEdep1NaKdoq2Jl9Tzk5jobZhRMCrk2AXXRRy?=
 =?us-ascii?Q?hzSDZCjabxzZkl6oDH9fWLifFo9DLkmtBJnImGs4p3rVnaclTDs6H28G7wD3?=
 =?us-ascii?Q?ZDvpNHqMtzsRDLkbtmk56IoNjIfsh29KZkk38mLy5Iwhg6aPu6hMY69nlAaP?=
 =?us-ascii?Q?08WMBKJbp6IcxQzlyUMDW2WNmRceca90YlUtohTbuAQFyYewZTPm/gOUUZdt?=
 =?us-ascii?Q?dCi0nqZUuV7UaElvcCaEoy1HKk5GX/yGgX4STEnyGG7F41gTm9p90hBxY8Yz?=
 =?us-ascii?Q?KfsNznrYI9GD03afhEfhZDWSI+1H05/YXXe1Oe/4Ka3H9JKaJhYVv0K8WfHS?=
 =?us-ascii?Q?Aw7BmDCiUhOZ7Cp9rPPD5NiHT4kaocBBpl/zrAM8doLsXW3ogiZa+n8gB7/h?=
 =?us-ascii?Q?HblJhAznikW6L+7V9cesBAX7vh0gIoC/ImxNfvQRn9QogrInCmmk1/wT1wpK?=
 =?us-ascii?Q?wVEOXmTJockWmv2g6cf9gs+jL8AW35hBhwsVFmqhxHf29AXkjW2VvkPFpUcw?=
 =?us-ascii?Q?5l/nOe0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27157c98-20de-4a6a-170b-08d9613d1cda
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 05:08:55.5709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOm/R7U2P1YpAM644mPfdvOEl89Y2KbMfOYpbKolleIZuASQco474XJIFs4SFZI7wFww3pW/rqwoMFX0RmoGKBFPVBodD/kZnbJH3SPVib8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10078 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=668 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170031
X-Proofpoint-GUID: dHLcPG2mOmupU2qM0VKZIaoWw5LIYjuK
X-Proofpoint-ORIG-GUID: dHLcPG2mOmupU2qM0VKZIaoWw5LIYjuK
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Andrey Ignatov,

The patch 46f53a65d2de: "bpf: Allow narrow loads with offset > 0"
from Nov 10, 2018, leads to the following
Smatch static checker warning:

kernel/bpf/verifier.c:12304 convert_ctx_accesses() warn: offset 'cnt' incremented past end of array
kernel/bpf/verifier.c:12311 convert_ctx_accesses() warn: offset 'cnt' incremented past end of array

kernel/bpf/verifier.c
    12282 
    12283 			insn->off = off & ~(size_default - 1);
    12284 			insn->code = BPF_LDX | BPF_MEM | size_code;
    12285 		}
    12286 
    12287 		target_size = 0;
    12288 		cnt = convert_ctx_access(type, insn, insn_buf, env->prog,
    12289 					 &target_size);
    12290 		if (cnt == 0 || cnt >= ARRAY_SIZE(insn_buf) ||
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Bounds check.

    12291 		    (ctx_field_size && !target_size)) {
    12292 			verbose(env, "bpf verifier is misconfigured\n");
    12293 			return -EINVAL;
    12294 		}
    12295 
    12296 		if (is_narrower_load && size < target_size) {
    12297 			u8 shift = bpf_ctx_narrow_access_offset(
    12298 				off, size, size_default) * 8;
    12299 			if (ctx_field_size <= 4) {
    12300 				if (shift)
    12301 					insn_buf[cnt++] = BPF_ALU32_IMM(BPF_RSH,
                                                         ^^^^^
increment beyond end of array

    12302 									insn->dst_reg,
    12303 									shift);
--> 12304 				insn_buf[cnt++] = BPF_ALU32_IMM(BPF_AND, insn->dst_reg,
                                                 ^^^^^
out of bounds write

    12305 								(1 << size * 8) - 1);
    12306 			} else {
    12307 				if (shift)
    12308 					insn_buf[cnt++] = BPF_ALU64_IMM(BPF_RSH,
    12309 									insn->dst_reg,
    12310 									shift);
    12311 				insn_buf[cnt++] = BPF_ALU64_IMM(BPF_AND, insn->dst_reg,
                                        ^^^^^^^^^^^^^^^
Same.

    12312 								(1ULL << size * 8) - 1);
    12313 			}
    12314 		}
    12315 
    12316 		new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
    12317 		if (!new_prog)
    12318 			return -ENOMEM;
    12319 
    12320 		delta += cnt - 1;
    12321 
    12322 		/* keep walking new program and skip insns we just inserted */
    12323 		env->prog = new_prog;
    12324 		insn      = new_prog->insnsi + i + delta;
    12325 	}
    12326 
    12327 	return 0;
    12328 }

regards,
dan carpenter
