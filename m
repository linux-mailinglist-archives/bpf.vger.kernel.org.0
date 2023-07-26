Return-Path: <bpf+bounces-5921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 143ED763180
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C6E1C21185
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 09:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C330BA2D;
	Wed, 26 Jul 2023 09:17:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599AAD37
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 09:17:17 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB6187
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 02:17:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q8AMCC025744;
	Wed, 26 Jul 2023 09:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=88xa/kNQhPa5mq+BVwivKVZdIiv4fSLjO6ly2R+q7cY=;
 b=W1hVh+uFH+a1pMxJJRlYvMY9Uqjz4s2O7JB9G0DkutRSzvTCLAalms1Zi/6C3o3WwrwG
 HMjfTz3j3aYCmvm9alnfMivnJF+NCLEgSbMfDA1WuGg2ikjI5sSufmTCMMW/zCsbT9da
 eeVBkU1Cb4zzG0v6oiXQDjonc7yENBcbZ3OdLp+C9QQs6FVY4+955WqNLIfzb86Wq0NC
 Dyz2YlnO8X+wi3YuQfiqlUikmllL3lYuvCp9VUOVWTSKd8jRpyrvJowri4H1iPrjHgYI
 HntGF2Vlaf4/B1cyRkIn8jj3kn4ysRk4RnvvJv+3mdEFzSnQRU3oMFuNcwfJObxY7ToV yg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d72c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 09:17:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q85ife026224;
	Wed, 26 Jul 2023 09:17:11 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j6et2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 09:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hag/JrufWUw06TbLeCBnQ9stCd/y2hqhmnm3ZytXmm+JcZuSRqXlDZLnbCvqRqs+c+E31UaNW/bmXy+t0j+T1grXd25FelkLgC8NU769UR9+qqo/Kzt0zg5cefEcQGhXqGAH5m6XkiQZIGZskYiypa1vT3BmSI/a5g5XHccLbquNZ2+WBDO5I8CjQ3L2X9tyf0++3kOaDdC+ofrfHzCoQGw/6vidXZfXuqaTMrP06iXkJv2bYbZTcOanFcMXK4Dpd0+eXe/2M8Syv/s60NFaP1np2zoHL1Ul6srY3KsAwHxWCW/SqQEgN4/zI7DRt/Y/o6JmwOJMBV98aCsNpRZNRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88xa/kNQhPa5mq+BVwivKVZdIiv4fSLjO6ly2R+q7cY=;
 b=kKXI+exA3bx81XXWjazZaDl/cEOVrxd8JklC97uhAxzA3wBVsQv5tixPd6pk6JGbaRcGajpS4arcrpb+HEDST3S7BksRgFTgCjL5725S/ADL5SYT8833+75OnDRl5TzYIj3RbIRYuucDoast/F1HMArK1CHBzFqXT4NEvqJJhdkKRyILnhBRPKsmvMTjBnifVLrwvWN5GPCRCwY/t3uMe5wLQEK2DRA0AXORPYbFi2gndEEs0wGU0u9/KU/XDwRzYYvk4z11WRoeYOoQuPSC422RKijNxZqmLiDSv2pkqMHWlrmunv9/dYRniQhrMH27ju+rLGN+RXvCMO4XlDQ/dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88xa/kNQhPa5mq+BVwivKVZdIiv4fSLjO6ly2R+q7cY=;
 b=eHFPvzRuBf2FDfICJXKnkSx4GwXkDqmeuqMPzfmJeI+5RcjCqJO9J3p6iPbUzVNzc+rpm64AUWg39OwIkXw2yNwgs0Ka1jZ17Lac66VZeb+IfwEqkXDkXICXQPBQN7XYvZ3ivzE7iNaa8bR7jTiNsPUaqLD8YwnX0Q8qlVwN0O0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by PH7PR10MB7782.namprd10.prod.outlook.com (2603:10b6:510:2fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 09:17:09 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 09:17:02 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>
Subject: Re: Register constraint in NEG instructions
In-Reply-To: <878rb3842z.fsf@oracle.com> (Jose E. Marchesi's message of "Wed,
	26 Jul 2023 10:33:24 +0200")
References: <878rb3842z.fsf@oracle.com>
Date: Wed, 26 Jul 2023 11:16:56 +0200
Message-ID: <87y1j36nhz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0037.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::6) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|PH7PR10MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: afc4cc43-11b9-403e-fa6c-08db8db912b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dYGNkw8MgkViuR/Q/DUo1Dmvv2Cm8LDr7uyeQxAChy12GYFu6OKLQmmR+3DzAD36q91EzaWokvFoeYxnaCwngkCSiU2+B7NcG9V324kZ4V73JYZSU6dnA2KRq7SJJYyJFhn50WmFIqoiqkCd+7Jhtkn5vbzhiycCTEM9sl100UaKHopLeUaiAAieVM354ueuSsOzBO4/3wLE/WMozb6sIg9oOeW6ndUTAko4I4laBiNRSia7cC9QgCvpx5BnkISp5mVeFSeU3BW6eSQt/HuSJ8Zt24DL0s9vLz3YdI0UJfoFRoDt9BbwVAZtHWaSSFa4I4rauMLtpikzrOsur39M8tQbwohTrSftZJbMMDolergsqtxbn6N54N2MtF9e4qrYCFVFZKL+/MrHUDkFBvsM0LVETpQr5owi5DLvcHMqlPGW34Sl/Pr7tnuWZYO3fpCASb0mT4C+g2eWTzVfShV4L9Z5Z3hy9upZq0V0MyUA9W56wVBcoLxtOseRYptLVHy+xnD7zUu7T8bbK+dkF2sR1kKIfOefjR+QcQO+nh6jVNGo8T2pdAe3wPgbDWZ/I01C
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(396003)(39860400002)(366004)(136003)(451199021)(8676002)(8936002)(5660300002)(41300700001)(316002)(4326008)(2906002)(6916009)(54906003)(6486002)(66476007)(66556008)(66946007)(6512007)(26005)(186003)(6666004)(6506007)(478600001)(86362001)(2616005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MJkeXYuzsrna2yUAWVaBv7y8w6ILPzyNojz7Yztc/XS3BJ9bXRtRDMwGqyNM?=
 =?us-ascii?Q?0CrXXnuu3YrsYIu0ebLYLEyqouX/YDKyXPT0rGY5EJ4P9nTU8a4TqfuMCCbu?=
 =?us-ascii?Q?JwjX+P68GqP2UVlf6NT8Jk4I4OXQYtXkROjejKuFXONwHq+Jwc2/iHyFIRY6?=
 =?us-ascii?Q?tFjid98z9CYN/j409ENzzoi8lO2sw4L4Sag8rT0f58PRW8ikm5cL4I8g61om?=
 =?us-ascii?Q?ns1ArHzq9N0MYxQJIZq2JTIZZYSt80zzWH1jrZiBMfm8avGSrF6C/BLaUoiJ?=
 =?us-ascii?Q?NJs7x3MvH9KV3TqJ4n0Iou15oj4gcBAfMQSM84qD4RffLnj9lk9CHGP42B4o?=
 =?us-ascii?Q?plBE9fvUdbDNjHmQbblJMdjBRE+HaYpf0IkyNdXUWavu97Xf+Y0WjjBgDrnZ?=
 =?us-ascii?Q?sXiTSk5VVaO5mGZRL/umsI1egQBLgQ5SqICIh9wN3YFWXO+L+LmdLo+9f7pl?=
 =?us-ascii?Q?5CiYcuSsIwsDPyW6X4iDZ5MfT6M2nkov3a2k8kkdGZ+KcfR3RIZiTv1HCjzV?=
 =?us-ascii?Q?I2ni2O3pDJF/mKbwYWWRTu/xWnidNYe3V1iOUjgWiSwyWRMPB/ZInQz7Mzx6?=
 =?us-ascii?Q?+RIo1aCtEYNbFho7D8l0W8x7DOsU8fZUSFqDWvV/FvWkqJKhVcqDyEKI/DlQ?=
 =?us-ascii?Q?ChSVShPeIFYvcCZe4UqyaRKgrKbI6iPRG+ziopoTCCuKUpUTChpgF3ZuBrLP?=
 =?us-ascii?Q?F/lwOoECa2tQJIKdDkfpt4hgi+Gi5h8WgRBthif76dPUjI5xN/iS9rUFKbOC?=
 =?us-ascii?Q?2PQ9E3JVNCJskG9MGt895NQcbdasqlzjNWPbIolutA7WdQA6+YHc7Xq6TO4P?=
 =?us-ascii?Q?5QVoVT4d2LJfb6cvS5Ygehm91ZL2zSUshQ2g09in7RvSsNbg5ny69YlXNyFA?=
 =?us-ascii?Q?aTIkJ5Qq+J9DrOBvFj1RblWqk8oAga5KV3rOs7gUv2q+XUcr0+VBwm1v1YOF?=
 =?us-ascii?Q?BeLJxvRq9R4TmusWkxG9+csv740cmvSnWbGe+u+4wYQD2lLaaMRzVi4rheeX?=
 =?us-ascii?Q?2JtPiFNkvxUQO94GUHkMg+SHZxCcUm6ZgqMOrrmluVY0ys7zZrqFqjI14GHM?=
 =?us-ascii?Q?iTKHO6ebreXak6TZ1PQLrxIES9wYaKu3Y8r3iMPE/daah+00KKI0RvpuXvdF?=
 =?us-ascii?Q?7y1DHbuaXkmfxHrtu9HrNeL4i5daXszYxYXrItk9/pcgkYzyU7xgF0WD8B3r?=
 =?us-ascii?Q?cFmtpC1HnOENrY5ceq0xNiqmrVt3s1FxEOVloqzU3/JkALHcaTtXe7syK+gP?=
 =?us-ascii?Q?slRrgh9MOKMUjaQ6//wYNj+TfGpl2hsVQfWhy0izZITn/ql2MFgugfy7rXUK?=
 =?us-ascii?Q?cuQOY229/9oJn9pKyGVhbGEWrsj1+c2T5qaV4UKP3Xmf6TUer5Hiy+rv2cYs?=
 =?us-ascii?Q?wZv61nESJGMqv/X1Q7BrcgmasbT4tyJodFYiYCJMsffGWF35GJxYKWs/tQL4?=
 =?us-ascii?Q?H2Mu6Zc+A5UWfHCL7WdjSOtzU2JUCW3QcdDWy+hzLbMfhehjJi6khLDAzrss?=
 =?us-ascii?Q?bKuqh339mG4L9Qtzzmhplzu7Off6qYv4yNHiIgcyeb7LtjKK/up7pIQJAl5r?=
 =?us-ascii?Q?v3VqaKgLPRKWjRlVthy62SuyCSntneLKHDS1hixrdFI28Qpy8NhIlU1SDXS4?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VuddTfFjUp8VoC7//sR88NVfFsA91esDbXoLyjExDobEWqXbXtRJfCuifrHj7DdNIgq+ssWRVpQSPSM+hbQuvv+3tnbRYUxTbQTlnEcL52DLmAb/QLwZVy0lcfJydK1lKV6WxKIgH1rNUyk9ykeoOhtdt5VbFoznyc3oHIp9tZwm6zOltHbAGekA9ti69nnsNP1Ap5GVaiRyhaM+kp0N/cC5U8c0nPpfpY7wmWXt8SYmqzuq4pTiXjySBMloJ+m+MsZZ+A+CC2c4S3b5ALw1zybBTPtdocPGaAdkyI65W4BCDknHDT1M5p++6nLjl93E13YjU2Y6/oLuT6Jwmq0svnJLhPV7FRr793qXo4wL/GIkU/brcqebIqtf3prYauqRnrsPx8tE1qTmO+JExN6xzTurBuxNwVXFglUleOCvSnT/vdB+8fSWNWc3aQElEMx91EyeHWHzqyr6qPG4PsH92PO1SJqCc0oglYjIUfiX44lA6uNsssrfssKhI+OBf0d6y5eU3vdAhVUOPtgeJQIdCkxGmZ6xXKXLhgE3ZP7ZVM4Mx4MGyfQjRbAdCs4kNjt9PP4eqw9Ecdi1iiUTTld2bYw8FM0xH5M7n19PIefBDSN3RKTXOBvdqSS85BFVRaxqB8+QZPEqceGWK69z7xi3KAYITWtguZWmFxBcarGL1xl/ubvxCSU1xQOmScC9zNsGGRKHCHLZ0M5cVxAk9SnllJA4PdnLA5Hs4Ai7hcbkASdVjpfyBGPv+fj8fna6jhNmrNRScHAqkxJwaLjWT6FqnBXjBKwWbssfNRSUuS1bkFs1jh5iUCy1BIPko+vqvuv/
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc4cc43-11b9-403e-fa6c-08db8db912b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 09:17:02.8275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0DkbiIXUqdir97WiTNi9ZZiaawRrO7C8mx4RzCDm3SC7zjbH7xcBaWHqNeDq3hR6PMBCf1svaf82gVyT6BWrkIpYSOaGumtmQWlMwkr8oU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_03,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=435
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260082
X-Proofpoint-ORIG-GUID: EtbslkAHpt1PHeaEoiRRn7xYT24jKdqf
X-Proofpoint-GUID: EtbslkAHpt1PHeaEoiRRn7xYT24jKdqf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


I see this in the verifier (bpf-next):

   if (opcode == BPF_NEG) {
	if (BPF_SRC(insn->code) != BPF_K ||
	    insn->src_reg != BPF_REG_0 ||
	    insn->off != 0 || insn->imm != 0) {
		verbose(env, "BPF_NEG uses reserved fields\n");
	return -EINVAL;
   }

And along this llvm assembler test:

               |
               v
  // CHECK: 84 01 00 00 00 00 00 00	w1 = -w1
  w1 = -w1

Is enough evidence that NEG is supposed to use only dst and not src.  I
am sending a fix for standarization/instruction-set.rst.

> Hello.
>
> The neg (and neg32) instructions are documented to use (and encode) both
> src and dst register operands in standarization/instruction-set.rst:
>
>   BPF_NEG   0x80   dst = -src
>
> However, in llvm's BPFAsmParser::PreMatchCheck, it is checked that both
> source and destination registers refer to the same register.  If they
> are not, an error is raised.
>
> Is this to speed up JIT to different architectures, some like x86
> featuring `NEG reg' and others like aarch64 featuring `NEG reg1,reg2'?
>
> Should I send a patch for instruction-set.rst documenting the
> requirement?
>
> Thanks.

