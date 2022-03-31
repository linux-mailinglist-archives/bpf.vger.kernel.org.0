Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E264EDAAE
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 15:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235080AbiCaNkW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 09:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236921AbiCaNkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 09:40:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF18457B7
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 06:38:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VDCMt8027080;
        Thu, 31 Mar 2022 13:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=fj/VXKsbDa93uQLktZf2Vt567kRd7WrviVgCH2t0cRU=;
 b=t1suQw81D7Rk9g2nZL4wnPs5ltUXjlhDc+ktIhMnEKaOl4P53zqgZMAGv5bzHFfaLq4f
 QYkyKLkOnV8z8llN88nxOZhmkOfmOCyJQo5xa2jCkqMuyUSjjdhoHtVlMfHJRLr5IijD
 WE1kNmkgb0TknnTkJVLFJ+cdg8o2wpULsSN7XaEx/y1OXcWw9WdwgceZlNw2KKb3DBzG
 hzreXbTVWCIQuPfXfYrbwIf9P7QeBPW2aI9WZxjYOF7KH4vYKH7T9eXryXRonzbf8EXO
 Rj+kccK/RiNPCN4rFCre6jQ6NURIy2EhJtlxfVFJHor+I48nEx9VQ8u+DYeeQHJF5EBU 0w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cv2uj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 13:38:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VDaZjh000906;
        Thu, 31 Mar 2022 13:38:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s94mrke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 13:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvIbD7OSc1Ev/n8PVpDhd6Z1tKzBAMhHnKZWY57F8qCCuk2AQdFtKkJa7DtvKn8yIiMKzrFeus4S6Fi9CI4Ou585RVnaCMf8v2r3hNUTVKFMb6a/y2f1EOq/Q/RVZjZ5NRnD1hB2JKGUOtSokY0OZfZUd/80kec+BIuon/V/vjhAEqBl3dkU9uRQZD43UnamRbyaJnbiHmHDtc0JTf0wuo/PKnNz7Z8ifFCpdxQAO2q3yu+mp81dMsuK8ysOJj48VWW2c/rib53phURf20msp1j7sfu7EEN/eXEbAAQMl0QgBcPSSGDBs0bG19z7SH3kZ6C1BjIi/9j9UZPY2iy6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fj/VXKsbDa93uQLktZf2Vt567kRd7WrviVgCH2t0cRU=;
 b=Z7RwhvKXIH5UVnhznZfMDl7cZh32DbSuTTsJWbtHsxqYkQukj10wF2pvllg8Ss3hSiOQUoBaQNiFjZUn0K7tLiwDCyWRtZ6sbS0MO/M4EVcur/JsZW6KBkryaxMisApikJp5W3CqadXA+BsHyL2LQbFKlcpsdcjPwG0W4m0zo+gjEiYlLOdnZA1fClBHpXBpUd/x0VvQA6SAnZSHwQgg1Gr4ZbOw60D8+BsnIvSfW1+rAdIAgUNs30K1x9dGAhwXXuoTOncEssGnOQ+r+lCTJtLORrodmATBWGIlIB4N8oMJZk5nv0thet35yN2xbpkUx5B6/MDL5hk2E+GGGvtr+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fj/VXKsbDa93uQLktZf2Vt567kRd7WrviVgCH2t0cRU=;
 b=EcSr17R119SjXZqkVrPFxWBlLqjxVilvFo7W53lbaq8n/FrrJPrhRLfT2Fy+ffrid5z6+5PKC4kAB9Cb2DJG+ymbq89PmKe5J94iA9BY3jWJsR1w1Tqq/tdVKATrLw9LrdRvx2WcnDIo6TfI9DW8P3nEaYU++xfj6LNPI92jvr0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB5032.namprd10.prod.outlook.com (2603:10b6:408:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.20; Thu, 31 Mar
 2022 13:38:02 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 13:38:02 +0000
Date:   Thu, 31 Mar 2022 14:37:45 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next 3/7] libbpf: add USDT notes parsing and resolution
 logic
In-Reply-To: <20220325052941.3526715-4-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2203311405350.25204@MyRouter>
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-4-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO4P123CA0415.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9962aa01-fbec-4d3a-d4b2-08da131bad2d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5032:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5032338B46B8DB168D90516FEFE19@BN0PR10MB5032.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v63HudYNY+y1z6NH0J4nMc1VXTBkYJ3P8fL/95HBi4tMIk1Bye44lRDKlIC+MfZjZ0MNgSO4WnNTJSQRpmudUMDgoQFXYTMGyeWzSd+0z2Fnw/Efdyf0FgjgxtQ2s7G3dhmMTvIgTJ/dsyCnM6U8CSQgnstedQTAIOB2WE1di5xwJrOAQwgUsZRYDRE2oNkvn0pphtg/wnpY0qP9V+uRLVfPBuL3V4FoxVJjwxsosSzji7zgH0Oj4GNKtf2hNCDSYvJ2V65yu41Cw4ncNfzwv3Ac3aG2dX3U0FHJuvtKoLcARxZ+tgXLAf4WcEZID2G313VxtP/1TtroFZ71hBQWejwpOw/Y7vw7BYWLsB3SF4t3ZKlYdPW40N5hEywoN3zzeOB8WL+6lsRfYBYhZavULa39f5k7MqSOpo9TTUO0YtVjgfeK+yalYLa+2E84nNQNiz0UnJQMcuCHSm/vCkXxCD1cXakgxg/tmKUkKfFrLK9gwFoC1BcWwvu64s7Zq79p5OroMwBqapnpGeBQgHEQAOtVzs7ibRiYLsodc9x7aEsejGBf2mihEwfmbMj1F1mzWVPLDD+8vQXngZaTmR9GWHgMmT+gd+FABoG6SWRvM7xez96K8h+QGsLuh2X16w846aBRtTDaIUUEoxa3dodW1mNT2n4hFy/ir6D1g7rCLd9yQ5tAjU8xIq1reTxalE94JvuXW7/f3Yyr2HI+xxMqP450INndaOwlHugHYUas54k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(30864003)(9686003)(6512007)(44832011)(186003)(38100700002)(2906002)(33716001)(86362001)(316002)(5660300002)(66556008)(4326008)(66476007)(66946007)(52116002)(54906003)(508600001)(8676002)(8936002)(6916009)(6506007)(6666004)(6486002)(966005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5iOpSbZYTcCJDeeSUlAMaIxRFNKksgUPVVhIqLeh4SW4dtIxw8oz+SS1fvlY?=
 =?us-ascii?Q?lpaj3zCN8debMQafdXAZZw1VSY1p4S32jofX26aHPqL8XWfMPEZsM+ViTNRi?=
 =?us-ascii?Q?qNyO8I4G5AjXnSTbm/0wp6Y2UpDSvDoZoqAiEH1lfYA/oPQjUNi0BFciS1wo?=
 =?us-ascii?Q?hFJX7YiHpJ76U5vpHQClKWJQRbNB25+4GNYXMLolfaMt0e4HV62r62lLhtbK?=
 =?us-ascii?Q?rRdpIzTHC8OhCWaLKSpkKebsBGEjHPPh69gvBoPqyOfueHx6RktyntYvakgc?=
 =?us-ascii?Q?duMTuCI50ywnxB2kTr3HrxwSe4iVIb/egPiXHSF9DIG1joUt4iJIvFIj8M5y?=
 =?us-ascii?Q?gp389gi35QjpY5tFOI6FhkmJ82Za902r2c8isB+jK6nI9IwWNOyXtxlLTduX?=
 =?us-ascii?Q?YtVcX5geqctLX4ZmNxOgxhO3VaM93+BuhIsFj30+3fxH6u+PHRti8k/fW05c?=
 =?us-ascii?Q?j8Ky452ulCcvuoHkAuMdik5PQfQSg0bleb38FxIgyG9NZ7eugdyV3QdqggtR?=
 =?us-ascii?Q?oC3pSCO78o17UHJu266Sjsxy0cR+xi1jOzMeNO66X0bEGA0TM3jpx78oRZFI?=
 =?us-ascii?Q?o8Lfidtj2BQssmVEhauVSatGvWsRjC5jD1T/hcvI/M/tmoIAKCUMbYOp7/T1?=
 =?us-ascii?Q?q1R5XQFh5WpYe/giL2yUrXX2D+f1R6ptEbWYdVnDLI1wwKKGxkcDJx7XdFma?=
 =?us-ascii?Q?Us5lMSIAaqmKoeY7jiutUqu1BxIHEnxr2IDJI0zGuPn7+POwiLqNo86jCnor?=
 =?us-ascii?Q?c7iZVRR88M80VLqosYjHecrXdj/0e/khL2yi0UcRqTquJ5D566nJ5W4xqMBo?=
 =?us-ascii?Q?iLC+kOPewnZ2Kviltgi553hwk1hrTkckd5kGCZwm2aNme+SMtR+D9UOdS75M?=
 =?us-ascii?Q?wzJvOA0G+66wKXGiR70b0lA6A+VkGbSPkeQRbESX3KQZw9FU1/LUZ3st9d7f?=
 =?us-ascii?Q?GnD8jtgMGaM0CbyoYKv2pNfiKBaDhYeUG1rQHLbGfVd8Tg5PCGdvJr6tMwL7?=
 =?us-ascii?Q?yQc8W0OXsIae9IQRV2yA9oHCUhrqxLNbrNw7P5KK1ZwL6Rz06W3qxhoosRzc?=
 =?us-ascii?Q?huYC0g9p6B7xwRgI1VkWA6Ifo0dZ+pXC0iq5d9vO4MeGhEfbR6K3q+8y3OAO?=
 =?us-ascii?Q?0I7Fikesb3q6GNk4EbAmhL/EksIQDJozNacxfAW/JUPdJVydMIK5JYwtndmm?=
 =?us-ascii?Q?kpuefM65Wx1QYoXWTIOLAuBkZ8DdZpf75Cb5rjBPAniZ5u8/CU0NKNu+pj53?=
 =?us-ascii?Q?heM8sWspbz6TE8YMV3mzwLzTAmiKscesQpGhcoT4QqStmkGcHpco6xyGweAO?=
 =?us-ascii?Q?PlAB4CN8F3QFWJq2BbIsggTiaMvexVNs6CrVdoG7KiweTxQHDKFgv8GkzeoX?=
 =?us-ascii?Q?twBrJyWC0iVbtO+ZyJzGqz4xoCHSFOcb7wa0yuJ6uEPIw9Y+8mQgwIIvsO/n?=
 =?us-ascii?Q?RzueJmiQ1/6zqMXLFjDpIrGGe0UVJ80MyeSYaKWe8G31gcMIe/FA9BXlXc7b?=
 =?us-ascii?Q?67EtzZW/sIDlDVUc47Kh2KMXH9DL4mMMjzox7cR324LZf/X9ljjlJAZdS3pK?=
 =?us-ascii?Q?zRZox70JXNnZap5segrUjwFMEnXaTu3qz6TksEII0g2BPoYC+XCo0ljKda22?=
 =?us-ascii?Q?jDk0lDBKSqnts8rh9XcubTHG+c1vqwBUDiN46dh53pCFgCdqq9C/irs8yHph?=
 =?us-ascii?Q?gPzXfCPVWlyChe+h6DgnYtswvAMBsWgzk2D+CzWzbhZpXnLFvnOnBPReGigp?=
 =?us-ascii?Q?nWWEAJd2fnCgHbclcXTl/MjNc1c2gGgLuiGz5FnlJUvV5z88Ci/G?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9962aa01-fbec-4d3a-d4b2-08da131bad2d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 13:38:01.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BnLylsuYKYLqXxTCZUwcDzPinZf4OJZ98hd0+GuL301tX5QeAbKOPUk7+kSSuFnNbCkLci2BFbnAOEbFA0cMOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5032
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_05:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310076
X-Proofpoint-GUID: PyiIZ1ZhEqOBJ-uP9HlbTXryiObOwPyV
X-Proofpoint-ORIG-GUID: PyiIZ1ZhEqOBJ-uP9HlbTXryiObOwPyV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022, Andrii Nakryiko wrote:

> Implement architecture-agnostic parts of USDT parsing logic. The code is
> the documentation in this case, it's futile to try to succinctly
> describe how USDT parsing is done in any sort of concreteness. But
> still, USDTs are recorded in special ELF notes section (.note.stapsdt),
> where each USDT call site is described separately. Along with USDT
> provider and USDT name, each such note contains USDT argument
> specification, which uses assembly-like syntax to describe how to fetch
> value of USDT argument. USDT arg spec could be just a constant, or
> a register, or a register dereference (most common cases in x86_64), but
> it technically can be much more complicated cases, like offset relative
> to global symbol and stuff like that. One of the later patches will
> implement most common subset of this for x86 and x86-64 architectures,
> which seems to handle a lot of real-world production application.
> 
> USDT arg spec contains a compact encoding allowing usdt.bpf.h from
> previous patch to handle the above 3 cases. Instead of recording which
> register might be needed, we encode register's offset within struct
> pt_regs to simplify BPF-side implementation. USDT argument can be of
> different byte sizes (1, 2, 4, and 8) and signed or unsigned. To handle
> this, libbpf pre-calculates necessary bit shifts to do proper casting
> and sign-extension in a short sequences of left and right shifts.
> 
> The rest is in the code with sometimes extensive comments and references
> to external "documentation" for USDTs.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

nothing major below, might be no harm to use a common header for
some definitions for usdt.bpf.h and usdt.c..

> ---
>  tools/lib/bpf/usdt.c | 581 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 580 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index 8481e300598e..86d5d8390eb1 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -18,10 +18,56 @@
>  
>  #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
>  

unused?

> +#define USDT_BASE_SEC ".stapsdt.base"
> +#define USDT_SEMA_SEC ".probes"

unused?

> +#define USDT_NOTE_SEC  ".note.stapsdt"
> +#define USDT_NOTE_TYPE 3
> +#define USDT_NOTE_NAME "stapsdt"
> +
> +/* should match exactly enum __bpf_usdt_arg_type from bpf_usdt.bpf.h */
> +enum usdt_arg_type {
> +	USDT_ARG_CONST,
> +	USDT_ARG_REG,
> +	USDT_ARG_REG_DEREF,
> +};
> +
> +/* should match exactly struct __bpf_usdt_arg_spec from bpf_usdt.bpf.h */
> +struct usdt_arg_spec {
> +	__u64 val_off;
> +	enum usdt_arg_type arg_type;
> +	short reg_off;
> +	bool arg_signed;
> +	char arg_bitshift;
> +};
> +
> +/* should match BPF_USDT_MAX_ARG_CNT in usdt.bpf.h */
> +#define USDT_MAX_ARG_CNT 12
> +
> +/* should match struct __bpf_usdt_spec from usdt.bpf.h */
> +struct usdt_spec {
> +	struct usdt_arg_spec args[USDT_MAX_ARG_CNT];
> +	__u64 usdt_cookie;
> +	short arg_cnt;
> +};
> +

Would it be worth having a usdt.h that both usdt.bpf.h and usdt.c could 
#include, containing the above definitions, avoiding need to sync?

> +struct usdt_note {
> +	const char *provider;
> +	const char *name;
> +	/* USDT args specification string, e.g.:
> +	 * "-4@%esi -4@-24(%rbp) -4@%ecx 2@%ax 8@%rdx"
> +	 */
> +	const char *args;
> +	long loc_addr;
> +	long base_addr;
> +	long sema_addr;
> +};
> +
>  struct usdt_target {
>  	long abs_ip;
>  	long rel_ip;
>  	long sema_off;
> +	struct usdt_spec spec;
> +	const char *spec_str;
>  };
>  
>  struct usdt_manager {
> @@ -127,11 +173,449 @@ static int sanity_check_usdt_elf(Elf *elf, const char *path)
>  	return 0;
>  }
>  
> +static int find_elf_sec_by_name(Elf *elf, const char *sec_name, GElf_Shdr *shdr, Elf_Scn **scn)
> +{
> +	Elf_Scn *sec = NULL;
> +	size_t shstrndx;
> +
> +	if (elf_getshdrstrndx(elf, &shstrndx))
> +		return -EINVAL;
> +
> +	/* check if ELF is corrupted and avoid calling elf_strptr if yes */
> +	if (!elf_rawdata(elf_getscn(elf, shstrndx), NULL))
> +		return -EINVAL;
> +
> +	while ((sec = elf_nextscn(elf, sec)) != NULL) {
> +		char *name;
> +
> +		if (!gelf_getshdr(sec, shdr))
> +			return -EINVAL;
> +
> +		name = elf_strptr(elf, shstrndx, shdr->sh_name);
> +		if (name && strcmp(sec_name, name) == 0) {
> +			*scn = sec;
> +			return 0;
> +		}
> +	}
> +
> +	return -ENOENT;
> +}
> +
> +struct elf_seg {
> +	long start;
> +	long end;
> +	long offset;
> +	bool is_exec;
> +};
> +
> +static int cmp_elf_segs(const void *_a, const void *_b)
> +{
> +	const struct elf_seg *a = _a;
> +	const struct elf_seg *b = _b;
> +
> +	return a->start < b->start ? -1 : 1;
> +}
> +
> +static int parse_elf_segs(Elf *elf, const char *path, struct elf_seg **segs, size_t *seg_cnt)
> +{
> +	GElf_Phdr phdr;
> +	size_t n;
> +	int i, err;
> +	struct elf_seg *seg;
> +	void *tmp;
> +
> +	*seg_cnt = 0;
> +
> +	if (elf_getphdrnum(elf, &n)) {
> +		err = -errno;
> +		return err;
> +	}
> +
> +	for (i = 0; i < n; i++) {
> +		if (!gelf_getphdr(elf, i, &phdr)) {
> +			err = -errno;
> +			return err;
> +		}
> +
> +		pr_debug("usdt: discovered PHDR #%d in '%s': vaddr 0x%lx memsz 0x%lx offset 0x%lx type 0x%lx flags 0x%lx\n",
> +			 i, path, (long)phdr.p_vaddr, (long)phdr.p_memsz, (long)phdr.p_offset,
> +			 (long)phdr.p_type, (long)phdr.p_flags);
> +		if (phdr.p_type != PT_LOAD)
> +			continue;
> +
> +		tmp = libbpf_reallocarray(*segs, *seg_cnt + 1, sizeof(**segs));
> +		if (!tmp)
> +			return -ENOMEM;
> +
> +		*segs = tmp;
> +		seg = *segs + *seg_cnt;
> +		(*seg_cnt)++;
> +
> +		seg->start = phdr.p_vaddr;
> +		seg->end = phdr.p_vaddr + phdr.p_memsz;
> +		seg->offset = phdr.p_offset;
> +		seg->is_exec = phdr.p_flags & PF_X;
> +	}
> +
> +	if (*seg_cnt == 0) {
> +		pr_warn("usdt: failed to find PT_LOAD program headers in '%s'\n", path);
> +		return -ESRCH;
> +	}
> +
> +	qsort(*segs, *seg_cnt, sizeof(**segs), cmp_elf_segs);
> +	return 0;
> +}
> +
> +static int parse_lib_segs(int pid, const char *lib_path, struct elf_seg **segs, size_t *seg_cnt)
> +{
> +	char path[PATH_MAX], line[PATH_MAX], mode[16];
> +	size_t seg_start, seg_end, seg_off;
> +	struct elf_seg *seg;
> +	int tmp_pid, i, err;
> +	FILE *f;
> +
> +	*seg_cnt = 0;
> +
> +	/* Handle containerized binaries only accessible from
> +	 * /proc/<pid>/root/<path>. They will be reported as just /<path> in
> +	 * /proc/<pid>/maps.
> +	 */
> +	if (sscanf(lib_path, "/proc/%d/root%s", &tmp_pid, path) == 2 && pid == tmp_pid)
> +		goto proceed;
> +
> +	if (!realpath(lib_path, path)) {
> +		pr_warn("usdt: failed to get absolute path of '%s' (err %d), using path as is...\n",
> +			lib_path, -errno);
> +		strcpy(path, lib_path);
> +	}
> +
> +proceed:
> +	sprintf(line, "/proc/%d/maps", pid);
> +	f = fopen(line, "r");
> +	if (!f) {
> +		err = -errno;
> +		pr_warn("usdt: failed to open '%s' to get base addr of '%s': %d\n",
> +			line, lib_path, err);
> +		return err;
> +	}
> +
> +	/* We need to handle lines with no path at the end:
> +	 *
> +	 * 7f5c6f5d1000-7f5c6f5d3000 rw-p 001c7000 08:04 21238613      /usr/lib64/libc-2.17.so
> +	 * 7f5c6f5d3000-7f5c6f5d8000 rw-p 00000000 00:00 0
> +	 * 7f5c6f5d8000-7f5c6f5d9000 r-xp 00000000 103:01 362990598    /data/users/andriin/linux/tools/bpf/usdt/libhello_usdt.so
> +	 */
> +	while (fscanf(f, "%zx-%zx %s %zx %*s %*d%[^\n]\n",
> +		      &seg_start, &seg_end, mode, &seg_off, line) == 5) {
> +		void *tmp;
> +
> +		/* to handle no path case (see above) we need to capture line
> +		 * without skipping any whitespaces. So we need to strip
> +		 * leading whitespaces manually here
> +		 */
> +		i = 0;
> +		while (isblank(line[i]))
> +			i++;
> +		if (strcmp(line + i, path) != 0)
> +			continue;
> +
> +		pr_debug("usdt: discovered segment for lib '%s': addrs %zx-%zx mode %s offset %zx\n",
> +			 path, seg_start, seg_end, mode, seg_off);
> +
> +		/* ignore non-executable sections for shared libs */
> +		if (mode[2] != 'x')
> +			continue;
> +
> +		tmp = libbpf_reallocarray(*segs, *seg_cnt + 1, sizeof(**segs));
> +		if (!tmp) {
> +			err = -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		*segs = tmp;
> +		seg = *segs + *seg_cnt;
> +		*seg_cnt += 1;
> +
> +		seg->start = seg_start;
> +		seg->end = seg_end;
> +		seg->offset = seg_off;
> +		seg->is_exec = true;
> +	}
> +
> +	if (*seg_cnt == 0) {
> +		pr_warn("usdt: failed to find '%s' (resolved to '%s') within PID %d memory mappings\n",
> +			lib_path, path, pid);
> +		err = -ESRCH;
> +		goto err_out;
> +	}
> +
> +	qsort(*segs, *seg_cnt, sizeof(**segs), cmp_elf_segs);
> +	err = 0;
> +err_out:
> +	fclose(f);
> +	return err;
> +}
> +
> +static struct elf_seg *find_elf_seg(struct elf_seg *segs, size_t seg_cnt, long addr, bool relative)
> +{
> +	struct elf_seg *seg;
> +	int i;
> +
> +	if (relative) {
> +		/* for shared libraries, address is relative offset and thus
> +		 * should be fall within logical offset-based range of
> +		 * [offset_start, offset_end)
> +		 */
> +		for (i = 0, seg = segs; i < seg_cnt; i++, seg++) {
> +			if (seg->offset <= addr && addr < seg->offset + (seg->end - seg->start))
> +				return seg;
> +		}
> +	} else {
> +		/* for binaries, address is absolute and thus should be within
> +		 * absolute address range of [seg_start, seg_end)
> +		 */
> +		for (i = 0, seg = segs; i < seg_cnt; i++, seg++) {
> +			if (seg->start <= addr && addr < seg->end)
> +				return seg;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int parse_usdt_note(Elf *elf, const char *path, long base_addr,
> +			   GElf_Nhdr *nhdr, const char *data, size_t name_off, size_t desc_off,
> +			   struct usdt_note *usdt_note);
> +
> +static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note, long usdt_cookie);
> +
>  static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *path, pid_t pid,
>  				const char *usdt_provider, const char *usdt_name, long usdt_cookie,
>  				struct usdt_target **out_targets, size_t *out_target_cnt)
>  {
> -	return -ENOTSUP;
> +	size_t off, name_off, desc_off, seg_cnt = 0, lib_seg_cnt = 0, target_cnt = 0;
> +	struct elf_seg *segs = NULL, *lib_segs = NULL;
> +	struct usdt_target *targets = NULL, *target;
> +	long base_addr = 0;
> +	Elf_Scn *notes_scn, *base_scn;
> +	GElf_Shdr base_shdr, notes_shdr;
> +	GElf_Ehdr ehdr;
> +	GElf_Nhdr nhdr;
> +	Elf_Data *data;
> +	int err;
> +
> +	*out_targets = NULL;
> +	*out_target_cnt = 0;
> +
> +	err = find_elf_sec_by_name(elf, USDT_NOTE_SEC, &notes_shdr, &notes_scn);
> +	if (err)

since find_elf_sec_by_name() doesn't log anything, would be good to have a 
pr_warn("usdt: no " USDT_NOTE_SEC " section in '%s'", path);
> +		return err;
> +
> +	if (notes_shdr.sh_type != SHT_NOTE)
> +		return -EINVAL;
> +
> +	if (!gelf_getehdr(elf, &ehdr))
> +		return -EINVAL;
> +

the above two are unlikely, but could perhaps benefit from an error 
message like below..

> +	err = parse_elf_segs(elf, path, &segs, &seg_cnt);
> +	if (err) {
> +		pr_warn("usdt: failed to process ELF program segments for '%s': %d\n", path, err);
> +		goto err_out;
> +	}
> +
> +	/* .stapsdt.base ELF section is optional, but is used for prelink
> +	 * offset compensation (see a big comment further below)
> +	 */
> +	if (find_elf_sec_by_name(elf, USDT_BASE_SEC, &base_shdr, &base_scn) == 0)
> +		base_addr = base_shdr.sh_addr;
> +
> +	data = elf_getdata(notes_scn, 0);
> +	off = 0;
> +	while ((off = gelf_getnote(data, off, &nhdr, &name_off, &desc_off)) > 0) {
> +		long usdt_abs_ip, usdt_rel_ip, usdt_sema_off = 0;
> +		struct usdt_note note;
> +		struct elf_seg *seg = NULL;
> +		void *tmp;
> +
> +		err = parse_usdt_note(elf, path, base_addr, &nhdr,
> +				      data->d_buf, name_off, desc_off, &note);
> +		if (err)
> +			goto err_out;
> +
> +		if (strcmp(note.provider, usdt_provider) != 0 || strcmp(note.name, usdt_name) != 0)
> +			continue;
> +
> +		/* We need to compensate "prelink effect". See [0] for details,
> +		 * relevant parts quoted here:
> +		 *
> +		 * Each SDT probe also expands into a non-allocated ELF note. You can
> +		 * find this by looking at SHT_NOTE sections and decoding the format;
> +		 * see below for details. Because the note is non-allocated, it means
> +		 * there is no runtime cost, and also preserved in both stripped files
> +		 * and .debug files.
> +		 *
> +		 * However, this means that prelink won't adjust the note's contents
> +		 * for address offsets. Instead, this is done via the .stapsdt.base
> +		 * section. This is a special section that is added to the text. We
> +		 * will only ever have one of these sections in a final link and it
> +		 * will only ever be one byte long. Nothing about this section itself
> +		 * matters, we just use it as a marker to detect prelink address
> +		 * adjustments.
> +		 *
> +		 * Each probe note records the link-time address of the .stapsdt.base
> +		 * section alongside the probe PC address. The decoder compares the
> +		 * base address stored in the note with the .stapsdt.base section's
> +		 * sh_addr. Initially these are the same, but the section header will
> +		 * be adjusted by prelink. So the decoder applies the difference to
> +		 * the probe PC address to get the correct prelinked PC address; the
> +		 * same adjustment is applied to the semaphore address, if any. 
> +		 *
> +		 *   [0] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> +		 */

ouch. nice explanation!

> +		usdt_rel_ip = usdt_abs_ip = note.loc_addr;
> +		if (base_addr) {
> +			usdt_abs_ip += base_addr - note.base_addr;
> +			usdt_rel_ip += base_addr - note.base_addr;
> +		}
> +
> +		if (ehdr.e_type == ET_EXEC) {

should we use a bool is_shared_library here; might simplify debug 
messaging below...

> +			/* When attaching uprobes (which what USDTs basically
> +			 * are) kernel expects a relative IP to be specified,
> +			 * so if we are attaching to an executable ELF binary
> +			 * (i.e., not a shared library), we need to calculate
> +			 * proper relative IP based on ELF's load address
> +			 */
> +			seg = find_elf_seg(segs, seg_cnt, usdt_abs_ip, false /* relative */);
> +			if (!seg) {
> +				err = -ESRCH;
> +				pr_warn("usdt: failed to find ELF program segment for '%s:%s' in '%s' at IP 0x%lx\n",
> +					usdt_provider, usdt_name, path, usdt_abs_ip);
> +				goto err_out;
> +			}
> +			if (!seg->is_exec) {
> +				err = -ESRCH;
> +				pr_warn("usdt: matched ELF binary '%s' segment [0x%lx, 0x%lx) for '%s:%s' at IP 0x%lx is not executable\n",
> +				        path, seg->start, seg->end, usdt_provider, usdt_name,
> +					usdt_abs_ip);
> +				goto err_out;
> +			}
> +
> +			usdt_rel_ip = usdt_abs_ip - (seg->start - seg->offset);
> +		} else if (!man->has_bpf_cookie) { /* ehdr.e_type == ET_DYN */
> +			/* If we don't have BPF cookie support but need to
> +			 * attach to a shared library, we'll need to know and
> +			 * record absolute addresses of attach points due to
> +			 * the need to lookup USDT spec by absolute IP of
> +			 * triggered uprobe. Doing this resolution is only
> +			 * possible when we have a specific PID of the process
> +			 * that's using specified shared library. BPF cookie
> +			 * removes the absolute address limitation as we don't
> +			 * need to do this lookup (we just use BPF cookie as
> +			 * an index of USDT spec), so for newer kernels with
> +			 * BPF cookie support libbpf supports USDT attachment
> +			 * to shared libraries with no PID filter.
> +			 */
> +			if (pid < 0) {
> +				pr_warn("usdt: attaching to shared libaries without specific PID is not supported on current kernel\n");
> +				err = -ENOTSUP;
> +				goto err_out;
> +			}
> +
> +			/* lib_segs are lazily initialized only if necessary */
> +			if (lib_seg_cnt == 0) {
> +				err = parse_lib_segs(pid, path, &lib_segs, &lib_seg_cnt);
> +				if (err) {
> +					pr_warn("usdt: failed to get memory segments in PID %d for shared library '%s': %d\n",
> +						pid, path, err);
> +					goto err_out;
> +				}
> +			}
> +
> +			seg = find_elf_seg(lib_segs, lib_seg_cnt, usdt_rel_ip, true /* relative */);
> +			if (!seg) {
> +				err = -ESRCH;
> +				pr_warn("usdt: failed to find shared lib memory segment for '%s:%s' in '%s' at relative IP 0x%lx\n",
> +				         usdt_provider, usdt_name, path, usdt_rel_ip);
> +				goto err_out;
> +			}
> +
> +			usdt_abs_ip = seg->start + (usdt_rel_ip - seg->offset);
> +		}
> +
> +		pr_debug("usdt: probe for '%s:%s' in %s '%s': addr 0x%lx base 0x%lx (resolved abs_ip 0x%lx rel_ip 0x%lx) args '%s' in segment [0x%lx, 0x%lx) at offset 0x%lx\n",
> +			 usdt_provider, usdt_name, ehdr.e_type == ET_EXEC ? "exec" : "lib ", path,
> +			 note.loc_addr, note.base_addr, usdt_abs_ip, usdt_rel_ip, note.args,
> +			 seg ? seg->start : 0, seg ? seg->end : 0, seg ? seg->offset : 0);
> +
> +		/* Adjust semaphore address to be a relative offset */
> +		if (note.sema_addr) {
> +			if (!man->has_sema_refcnt) {
> +				pr_warn("usdt: kernel doesn't support USDT semaphore refcounting for '%s:%s' in '%s'\n",
> +					usdt_provider, usdt_name, path);
> +				err = -ENOTSUP;
> +				goto err_out;
> +			}
> +
> +			seg = find_elf_seg(segs, seg_cnt, note.sema_addr, false /* relative */);
> +			if (!seg) {
> +				err = -ESRCH;
> +				pr_warn("usdt: failed to find ELF loadable segment with semaphore of '%s:%s' in '%s' at 0x%lx\n",
> +				        usdt_provider, usdt_name, path, note.sema_addr);
> +				goto err_out;
> +			}
> +			if (seg->is_exec) {
> +				err = -ESRCH;
> +				pr_warn("usdt: matched ELF binary '%s' segment [0x%lx, 0x%lx] for semaphore of '%s:%s' at 0x%lx is executable\n",
> +					path, seg->start, seg->end, usdt_provider, usdt_name,
> +					note.sema_addr);
> +				goto err_out;
> +			}
> +

could have a bool "exec" arg to find_elf_seg() which allows/disallows the 
segment to be executable I guess.

Alan
