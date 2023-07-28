Return-Path: <bpf+bounces-6222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACB8767217
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E325282674
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA6314A92;
	Fri, 28 Jul 2023 16:41:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591413ACF
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:41:42 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A8C19A4
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:41:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF4uXB024191
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2023-03-30;
 bh=2aGkxeO+9iePrg8AILJKtD150KjNBaVvHuI60ofmYyw=;
 b=S1IJmZcne6ncx+mRRX9nVCV0V+2my+He5LX+TUNXVQlbdiHSZ41tRceWh0xc81ebYpa7
 K4YNIqzVN+j/l1K6Y7klBRuEeLupR6PCW54Z3Z6cmWm7isVbHQNYwMRsQ15nswmhQKWG
 oPShrw7nHw3PlwGiFFVblak2Gsgx8EkiD/Fg54jRf9Yc4YED5jhG6wyGQnNE3VePtI41
 KDGdaFl2jGjMdZLrYkCtCo/l9MkjxjCWl6v7MLk+WURSXMPAJVzx+JyPgzg2EvWNrlZy
 TWS3cNTjZzv4PDOz1vi8zgB9AXyolFsnosjP+IHuI/Rt18sLKUhR7s4naP7RvHtX8LuC bA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070b4aks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:41:36 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SFLYgg023367
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:41:36 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j98upp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:41:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GBf9ZJQzoDRXXHKIPWdF3t6SYIyjPOD94YF6/0iJ0KiP735+ChMISMgWd1mOwamO3ScJoiAJZjuRQSEIzOKAMuUY5mVtdcbYlo8/18ci/2RTFpLB9RZx0m7jyITU4+O7bMU3YevUKfX+zX5y7eetvVECJOZOpQxfDwOjuVmClNKCXdM4ESQXfcp7GkwM5Pe8tTYA62GKMccDqA6ykAdbsAX4E6XXmkCt+PR5rq5DFjA+lpV1yWgQ2LM7csTgMp9EJV9WnzT5dhyGJmkz2R9mOd5mUWB5Iv4VE5yaUgBzV5/0mM8KnRIz3BCH87phRi3YqxLt6GCk4f30wRq6mss+lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aGkxeO+9iePrg8AILJKtD150KjNBaVvHuI60ofmYyw=;
 b=N2f17mABhgArxq14eFN0SJ/thiQw2SHzdaEiEJQHJ6as9H5F11ZKN5YQr0IFHQA6IgR+ikq2h727NK3Mc70CMJdrQgIQ0FR/goQnfWN1+EE6wmuGEl7a1YfmNMBK15TvszvFybMRU3nUMKHxIDLNyk1BWdNdfdjuZ/R53plrpcuoWJ9sWR8KpN6Pn4S9JpkyGBC7UTWG7f85MI05VC9OigKpOheAtHhiqtnpFAshXMUwMWbMKslsLkocVxtjV/JAq58k1Sa4XF0O6Yeh3bGG63QNUjCeS8cgrHz6q6kokrTUaeqca00XXMzUChehdODZryU1mSJbjGkrRRCVpNuOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aGkxeO+9iePrg8AILJKtD150KjNBaVvHuI60ofmYyw=;
 b=m9qmbTkwQ/V5TgatTyX/l4xW915rjcX+VWxgKXtrcuO4N8dBhKTePAMGDxmMNwb/OidmnHjbG5o3tb5lbVXq8dXNocGoR8hWpUxTVnitzdmyXJcUOPJ7Mg6w/je2ewXCNYw80THK2mQFLKe6UvVYK/ToXYNNpjhwK+iAXOT9Wrg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:41:34 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 16:41:34 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Subject: GCC and binutils support for BPF V4 instructions
Date: Fri, 28 Jul 2023 18:41:27 +0200
Message-ID: <878rb0yonc.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0608.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::8) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CO1PR10MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: b0665f9c-a7f9-4c28-f23f-08db8f8980ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3AcH82hlQiNQiGSSO6e/Wwi66k4+aymlHgJSlGz75Gns196Wzfwny4NncXxVGmFDJcs1QnlBAdRB9kFRM7sKpdsxqieHegY/o9A4tvYEFOY5+uzBlY/mD016d8+OQvevG00QSHn8otnrfz0tNtFRLRJCCcCdLK431Wjwr3v90VT7F8kSzvADOMZxdi8jJlCl/Z+kFU6x2Jq8eewgi4lHNlls32gqCz3Rc/yv49Xsrvfkd5JRV0EkS+0KuU1vEB0h2teTDSQEqSjebr7t9ATkr5IEM7aCfn3Mla4ifhwOO68kfd/OR2at8LIONAROwyy8eLi9ngLj6+OQaCrbULY/BoNYU0ec21nt8TZX+vGLPxGCE9D0eh+vHLi5Y94/2xZQLkQZY8EM0EJVZEbDAI5LOOmTpFxxBnX4QbPqxLEk+NQSyGBtEdtb/kVjiRvBkfGRjWDLvdvx10t+MlgVEmcj70/+ZyY8xfCdtwM9R0w4Ub9yDXPaUv/v/KIbm45BXnyjAvs0lZl4F+wCacDqJg0UNxwPZnw6ZRGAccEjBUjDnZHGwI3mv0PzAZ22gCb1JBlEJuwplKRZs1VC/DzPWWm/Mw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(966005)(6512007)(478600001)(6666004)(6486002)(86362001)(8676002)(2616005)(8936002)(6506007)(5660300002)(26005)(186003)(2906002)(41300700001)(36756003)(38100700002)(66946007)(6916009)(316002)(66556008)(66476007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BVgE9YO6/lauEaIs72qvPLPSCwLfUZqfvKtpPAO2t1FvN4CqPrDffJE3+0J5?=
 =?us-ascii?Q?bqY4ckefcsrVMyR1m4pJY69omu/v3nGUoUU77GksDiLBt7ltpbR7OZNW6BXM?=
 =?us-ascii?Q?CYrtcsN+rKB9ZoZZSUx42ZOLYHavcBIjH8KfWRMYZdPkRxW4NFpQAFYIvHsK?=
 =?us-ascii?Q?Vf+TujZqkfWjHQnrl5y7cbYRVijpkZeMomW5ychUsNp4EcAHwm9Y1a+N7Tkc?=
 =?us-ascii?Q?FSzAsZmwt4TOckVPk3gf7bIVQ+RgJYXEltiBdrDoD5EZW1aFUExtWqH4EkyD?=
 =?us-ascii?Q?xEjSdvkFbh9ZMLh+ZAm9ZjPrWfsvFWhC1AomT2/ZiQbb7CiMcBI6q1gIVQD3?=
 =?us-ascii?Q?oqxbOsoKRekfM4aK0u9S4ylRejuBY+kU2KuPtQVv4SgMzb5HWe3LYSfNed1j?=
 =?us-ascii?Q?JxxazLffRhM5rr+ieqs+lGW3pf6y8hnmTZEPKOYfKyzzRXCaWpEtpror5+sW?=
 =?us-ascii?Q?dfjA7/KkVEpkA2i6WCnc/hpZ1lZ4JN5DUK3OsvWbz0lp3nMAT4SEMsq4fYvL?=
 =?us-ascii?Q?JGC7OQx3b0ngbU20dE8O8AwQwYpnlJ46Kq0a94jTBIjoFqtSENGqfauT3y5a?=
 =?us-ascii?Q?IwrUMcATxp6GnlGePk4o+wyeQ3dHyfS1gDM2/CkjG3CBpam7XD9xaQdOzN95?=
 =?us-ascii?Q?YRD806ouRKf7f0AK+sBm+zOnUAQg+RBlpI5pP+nQdrCwrPy9zYN27xUY1T8B?=
 =?us-ascii?Q?UlgQU4T8kTlycIQsmteC5PT/VW3ZqLxb1BrOiJ88Y8IBepSEpMLd3jafIkgL?=
 =?us-ascii?Q?kfKm5+hOUJ4KJcZsCn3I7oWmB5/lMGHOU9hOpMyoJcgz/ATRuRNmO3dMq7dQ?=
 =?us-ascii?Q?lSDaOoQKyOu5otpVvNZbLu8f72bWkiR7y++0SQcsl3SV1jEzv/S7jlfLN1ZV?=
 =?us-ascii?Q?y6q2uuT0H8jPuSbZwmzQeC4YsmSvVMiW6C/gfWOsONZVPg3SPMpxZYq2apr7?=
 =?us-ascii?Q?e67LSyxXNFB73WXSb99oCJfU5fLw8LjsTcLLz8fOeDNBlFdm4VdpAPnnMXXU?=
 =?us-ascii?Q?SH1leffRJkfAcPLrUPwv/gRvVbM7uqrYW7r2cyUOny62R7nCmDhYlOKblIsm?=
 =?us-ascii?Q?17OvXbqyzbHd4GHvTe3uLTS/Mx+xgcM4Skbj9Fn4XWehW6PwlPWZx4LeqwFc?=
 =?us-ascii?Q?Mop7qjQ/UMe0GX+h0sc7LGAj+2UyJldJ2U4MEavaiieCrDKVghK8I8hcjzHY?=
 =?us-ascii?Q?r7J3ajKm6+pbBIQtL+mF1VKhVDYusw95pH5W3qTuzdvDkgdR9oPzivjsX9ZX?=
 =?us-ascii?Q?4IW4PDhMiLG/bCBX7mNSDf9bxKI2c1joYEv1TBslSlF6FVfr9vP9jM+wFygv?=
 =?us-ascii?Q?YLinkkZLK54MSCBsyk3qISLNdT2OjgzII0JkYwBJhbqHnr3M4Xght3lH9YM+?=
 =?us-ascii?Q?vx2ChuUpb33ZDok1qlI3a2WxFvxGXoQ/rgC7P5xzk4lRpNF3J3nYA0+u9azi?=
 =?us-ascii?Q?HgijHIa4vkzHidVzFKckFXDod6wN2iw9DG/6Q+8AEr4fY/MSkEczFARWwSqN?=
 =?us-ascii?Q?M8SYeqWdX2b0gO4vbsVNG6llZoy3fISmGSLX0I+PlAEZsrI2GjzC/31EGzU6?=
 =?us-ascii?Q?PWsPRfOUuJKikozTE1+x8DcW2tV5GsYHXyJ5AnLeMa2em7UI7pxr8zTUYhHc?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	RPcZA33d7yE7HsDQahpjPCe+dSfys7laFwl2PzHil7jjex+fMx+XHM1GdQJ3ohgkhlj6l/Fk1DQ125MgUrYGAjpV7aibpfAH3nnlc7Pi26k4VjBXtwx3aB6u7BTH/JJH/qxz4bvrz6CCmNvm/1EDCQpxwGnV6AhQLyaZTHp8zapMf3yHd+LoKgHpNfatQv9yetQrRCiS/0t0AXF8HArePRXzKwIkfDvCQX2T6rVsts9YFEKH9n850jNP6nUOxnukZDzojtac6H1nX9yeWNZuyqihC9z3m7nIs8bsfchmMmkFBczuEHyTMLCBDXl68CnDw5ji9FFHiC0JiTL4bSstuSPAa/FzjpHoRDqRUlkrTI1LbWTm5l0/fgrxEczvtTz9glrbcTR1o9zGp8DxDGvPzNHIwYqsW5/oY140gLS4Jygm4HCjDft++Tc3AD9hSVbFuaK4xWZA1DAhCPMrhyxZdafH49/j3HQZgKVn7ta/kkWaC2XKbdR5s8cpLHVpYqZFk77L8H720vwEn8PQUtrHkl05pW694Hh+L/01HzOnKodQRDuTtaSC9YxB8EAGq/AQkYxjhuAqvIZ1/N7xGLre0npEOnzafQdGeLIdH3dAhrPENV5dUJhoefglHHjcpFMAcFgPQnfRjbZIb5BX77762nCgfNHZbWrnw0aDj0N024uFC3+vUWIQ222Uoh/owmHJMkAq5kKu1Tu0wquUh4mzHGIirAP8rqdZOJS3Hm9kp5klhOTas3APFb+LdPCT+fied3uHHcZaqWlBT993TxgFLQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0665f9c-a7f9-4c28-f23f-08db8f8980ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:41:33.9767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBw9Za8HWE4bs0b+mj1MNqrEbn8EbhXH4YeZirPq1Ra1lVaka3oDz3lYQU6pobjhZN6p87l5sii8lYmW6dEfSnv5cHdubTy2yXCCniZNaV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=971
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280151
X-Proofpoint-GUID: FmLNidzo1BpbMjzWHOpkdHg4mRHZpxLL
X-Proofpoint-ORIG-GUID: FmLNidzo1BpbMjzWHOpkdHg4mRHZpxLL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hello.

Just a heads up regarding the new BPF V4 instructions and their support
in the GNU Toolchain.

V4 sdiv/smod instructions

  Binutils has been updated to use the V4 encoding of these
  instructions, which used to be part of the xbpf testing dialect used
  in GCC.  GCC generates these instructions for signed division when
  -mcpu=v4 or higher.

V4 sign-extending register move instructions
V4 signed load instructions
V4 byte swap instructions

  Supported in assembler, disassembler and linker.  GCC generates these
  instructions when -mcpu=v4 or higher.

V4 32-bit unconditional jump instruction

  Supported in assembler and disassembler.  GCC doesn't generate that
  instruction.

  However, the assembler has been expanded in order to perform the
  following relaxations when the disp16 field of a jump instruction is
  known at assembly time, and is overflown, unless -mno-relax is
  specified:

    JA disp16  -> JAL disp32
    Jxx disp16 -> Jxx +1; JA +1; JAL disp32

  Where Jxx is one of the conditional jump instructions such as jeq,
  jlt, etc.

So I think we are done with this.  Please let us know if these
instructions ever change.

Relevant binutils bugzillas (all now resolved as fixed):

* Make use of long range calls by relaxation (jal/gotol):
  https://sourceware.org/bugzilla/show_bug.cgi?id=30690

Relevant GCC bugzillas (all now resolved as fixed):

* Make use of signed-load instructions:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110782
  
* Make use of signed division/modulus:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110783

* Make use of signed mov instructions:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110784

* Make use of byte swap instructions:
  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110786

Salud!

