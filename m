Return-Path: <bpf+bounces-5628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E085675CE4E
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 18:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3636282301
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99991F94D;
	Fri, 21 Jul 2023 16:19:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A51F941
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 16:19:39 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEBE468B
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 09:19:26 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEGDZC011951;
	Fri, 21 Jul 2023 16:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=ADhsh02yOX5rOlKXrBPObY2T+eurcAi4k3QOSVU8J50=;
 b=confrn7RoiauR2IhhP26RwhQDl+SJ2zTV/GncpQY8zshTL2OaiNlHfQnxo04xS7jOZy3
 3IGNrD20dQCc3HTin7w4bv+jeLu6gqNzaXovA8BZNSnhyYgTo7uhZeqWqFauKmKbhMUb
 I36twfgKTmwk8CIh/qN+rfFKfCKDG8LWgCaWUtDvv6WMjG8qRtpi8AzeiiuAVYDdgZTk
 KHK6t2hJQ3kVLYLeuw6iNcFHDd00LZSILf1COuz1w9xPV/f793lLUUd0gM9Mz3ow6CqJ
 daaY+PlumNWCjnidL0r6C/KDFy6W7nHAnoIK7TCMcmX6BA3H2bFFHuw/YQdstujpTM65 Kg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run78480q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jul 2023 16:19:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36LF66VA023985;
	Fri, 21 Jul 2023 16:19:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhwaerq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jul 2023 16:19:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9aZsyP94MhGAfhYlpqF63WvTAtwOAzF6pGhznweXUgXb/hhTPY8+lqgytFYAKfclhrOHgoMOYtqQtJpfws+E6hNQ5S2f/9bBFCaYT91NXOXtviP9fHacor7tK6HsG+Y3LPwSd0Xzy/dslQwaQvtZMNarHJEN91lZH+Ab5atIdHptlIbpy4j/MMbKaN5l0OT6kkLFsB3q+mLjsmQWPebJQSU5A8zg3/LpFri18O+h2YhyvMeCl+/HEl2Wmj1AXoVHESbxq42WI+yylfH0QdVw8Um24LhIfUtk2K8ECPDPxV/9ad1pl2YrAygQor3Sk4A9JqyfnGc39i+H21XbCakPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADhsh02yOX5rOlKXrBPObY2T+eurcAi4k3QOSVU8J50=;
 b=OcUU3p/jZiq0Jh7Iqg7mh/G4FrEJcp//ldoqn/YaGEWEgtvH3ZGy7mUwQnhJp8HAqxe8wYTir6k4Ljmkc5OhzeMHBVyj27AHCPWz1QZwnuFWn04p2bGBfRJnVsF/QbfjYrRlptZgRwN5FMviX+ngFuB6Yr0R/xSrlYGyPDA4MOSuiaMDxaJNXUc/D1BKUGJ/skpEDSpuDr5wxj3xoUviM8hJDK8itS+sNeU2v1PMe1qEHwhXBS3qv3D7XCRIoloW2a/OmTmi8H1pd/r4+dpL/rfBsvt9erVzmj/9A6C8svKu9czG505LKupT0FbQAURgtNVpogXQ7vbwcpbMPFiNvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADhsh02yOX5rOlKXrBPObY2T+eurcAi4k3QOSVU8J50=;
 b=ey4TdLUtpjfjdogVHctEub0LEyQnOB/nDh01GWFwCBXEEU5uHkO3jpoFSqhUoQ3vvkTGR0K6ycJ3i4s2NHDtL6IxzM7AcAmIZ6lCRlmuoOaT3FtGBGDjEqBxdbrp66xzGHU4t3xFATRD5RzUpHo7t+tkwRfwtZ4M7A9oyGFvSMU=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 16:19:21 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 16:19:21 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yhs@meta.com>
Cc: bpf@vger.kernel.org
Subject: Encoding of V4 32-bit JA
Date: Fri, 21 Jul 2023 18:19:10 +0200
Message-ID: <87a5vp6xvl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e4b8be-ea2a-4b46-1df3-08db8a063dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eUsttmw/QzQPSF7nchTsXe7j5vhLCpUKppgP0iKBge9Xdos3D0Ib9Gyzh8r42sKsjwQlHDVlPfy175q7GSPfjIferXC3gKjprYwvlL6n6r0aOaXQeH2wmbFj1S5IW8ZJcdoKp340NjSVI/JnJBpEaAPmJYbJTsmIe8LuqBfIRnErQJ7//Gb57s3q2mJ7t+JKC8fVqxFXY08cfGB98LCHhJo5bz3bSYPi0KLSWWnCNoH5aAoQAKbDOKgCiHCFegB+DmUl+VxlEcDf7C7RWseZHeSDhQHyla25X0tQmUUqmoU6QVCUUeR4ZneMqURg/qN4svyr5JwIqlWt7g4g49Z3A/sIoqbqt+JIUd/cV/cQ9NnNlQ1huzysazm0s2itq6RTsdu1evqGN+c3Ljv/KZrVKL0MsG0scMhsF0hq2twJBiUohAqg83zYqW5pyUd50pMP7C1nb1xqNug36U9bK6FWwLuwGD6/jae0YNNDWWuzjwIP5vqRt7Rd7qr5dBi5XBeUiydHmZQet3AGhpgZSDeN9RqZeJJhxXvY2S7NoWbTtCNHc3IdCD1JeU/8sHymo3A6mLjCYQ9PIICX2tTmsoPgz0KtWhPpJQmUuLhCaWwnkeI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199021)(26005)(186003)(36756003)(6506007)(38100700002)(6512007)(6666004)(6486002)(2616005)(4744005)(5660300002)(478600001)(4326008)(66556008)(66476007)(6916009)(66946007)(316002)(86362001)(41300700001)(8936002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JokAqa/pKyDEEZpWcRNFC6y9QX1oLHzE20fhYmko2oA3W4e9fojxwGqqAsGF?=
 =?us-ascii?Q?F1OkSkD94mk8ngavecqyRlFkIMUkYpar5Mz9kqlbRRDzOZQNAXGflH0/e9Lb?=
 =?us-ascii?Q?eN0kvw8wyYhYd6Sc7YalfPgIkiexdEGo5DKGFfXjmgawhcgFtv3MDXGfOxEk?=
 =?us-ascii?Q?pP1GcgTX2GUQim9BZHkopnq3uniDmc6c5XGJzUQXV8d8eIm5RqrQSZxxuL3a?=
 =?us-ascii?Q?AoQHh1ihPl6pbdR8PmgcDoHJzRfTXqHdanwfUJxsPtRnKjODSeZ1dRzk3g06?=
 =?us-ascii?Q?chU0hWx2jHjDPNuMnzAohCQAalltHT1tcdlDz61H9eN399z7LOCAkBqAg9jW?=
 =?us-ascii?Q?8I6sxGwcAftyR/6G+BHFpHpOT/xmmqzQtA5yD6zrYkMaU3Rp4egzdf9MR85g?=
 =?us-ascii?Q?rJ3JirE6/BiJMOvtxFraAccJSA8tjN/bib0bvCfeJzOD63kP9b7mUM331gWF?=
 =?us-ascii?Q?L80zehhz/nCSe0JVYRNYsTPbsF0kTPLredKeoJJfmKFqSiubANnJ3nQM76wR?=
 =?us-ascii?Q?PTfSSOkSLe9mWJ4QrSntrkF6Yr76fMVLy3jMjRhRTkWg1Ylc4MVuEKHu/AOp?=
 =?us-ascii?Q?VwHzIuBThL+7uQn/OsDh9mefPbpDWHqNs6mo0+MN2brl2VTfJaLIMvfME8ib?=
 =?us-ascii?Q?C3tRxH3p5QvbkYwP7E8Y5VGhsH0+L3TxSR8Co/QryZEXTBDHFL8jnUfwj4nh?=
 =?us-ascii?Q?mKxouK0YdrowvfK/d2arDhNDvPuBfrnp0TwW0Z4zchuwjv/JDImGBqEJjcoQ?=
 =?us-ascii?Q?gIuEIepm77+MdrCCiZAf3lYPjy4dfzNvR/rmdLdEHtWqCn7dAexElcmjpGH9?=
 =?us-ascii?Q?Zseajc3WV+4Fyzy4HKi2znh4qv3kcT/FAO2Ig4EQCw48pfH/BJL03CCPzapR?=
 =?us-ascii?Q?7i2W2qhPod/6RwM7OakGd2JL1bI28gVFRVfP4028oaO0pwBhM4gZt2uE1sEo?=
 =?us-ascii?Q?k0sj+4m0ipiY0y1/i4Lg904aTZZDoEOGNJZLCvRCzI3LPUGu5blxD9EcY+ER?=
 =?us-ascii?Q?myyKXrxQhHdh0ZWAHjnLWCQl7mn5aOGAEOsoa5yzzCVBbcEVk6ImhDeFg7RU?=
 =?us-ascii?Q?tZs4cfI/PflSXWx+VF2qI35BcWA6r7f405gMMpmP0/eVyfeSgjGtPc6wxyok?=
 =?us-ascii?Q?QdYOgcNgRFnDTWdvJvOlmmut4CFzHj+opRkPWyUqJaEbP22N/P+OE6H1YdWE?=
 =?us-ascii?Q?mdW3CEQsHW3Mpz4acCQYI75v3TcImAlLBP30g8/gQa7iId2bs8X756dFV5su?=
 =?us-ascii?Q?aZT52ANNhH20Sm4DZ2pG/ya1HdBals0bCh3+TvI1PYeMS4EwS8wqq024bUpY?=
 =?us-ascii?Q?/ywOgtU/ek0FGfWAyfj5FFBhpX77QFdRgXEqKKVsWuT4D2aWgEECu0Lg+Xyv?=
 =?us-ascii?Q?n+Uo8cY8WSbc7V8TtBychHXhhpI3e8+RNpyXgEv5n50lH7ICQ8+kdYE+pWpD?=
 =?us-ascii?Q?zZNBeJ/SljJM2awgsp3SiqLLU3i1m1IiwJWqogzLgeOIwS9VsTIGeS3+L9Ct?=
 =?us-ascii?Q?ZtFwWoCJyDCEslTdUmjCHqnwhBX9gaz65sd275HMw72/t3erAelE9XDRmmcd?=
 =?us-ascii?Q?NDN6U2ewpz0oFGAnziZWZ2D81WSH4k+lqrFAzkPXzYBc2ZEK6qO5brBL+QFl?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	x4Y+kBZiH4BXqwD9AkdsyLV7c2jeGugg8it8tbpu3qsCEmLWwPQ23+H1Xy2VtQo6V4XOSoqlGTKEHSFcdyHoOeDtrCXGfZWEv77/z8xzPDIVcfbOkthw9TQrMBvOH3WyhTYHPJiHR7P/D+rCzMfmrzoS7VjkDqmNtTeTuNKUW1GCQc0oX8ZushK0BvsBF1YvvHQs5CcHHDhjDg+UfDj+UjM4+0IV92rKYYEqXc05ywX7KHBwbtO/upepYN/8JMsTjxd+ZcT3d7mc2PrUEPLvJE0P7B2YLteURlIdEck0URL7thSLnwQPxMvLcNhSydJ790TmEv1FN7wOWQiFYB94fNbdIKfh8N13vGsUssRWRQsFcY8awOlrpXrriDZ9nE/qyvq/nKRgQE7oQUGcYYly/RgOiS5Vy56JFkmIlqbEsmqWDTaw40t1Aqf0gQdQCtvj6JfKeBN5UPEdIhUxNs2lgwOA1YX8qZp6moL/AdiKWAe0URYSi2gS0Bro9rL40eC64/67rCzdw44pn+AOigA8ckziyPZP7WkelDprV65RdV87lGugFu/GRbaenkB71hONI9p+BeuAt/E3qf10asxwVYNenpbWSY5QU1GxT5oRkGe9GMzviTdGXI7kMAW/ALRX9QpnfQrBffdaO5P+uIgn7LedfQL5Hq5MWvn0TGAApqlU3aNeC519TfFxnB4cVY8H2QFGWZBf2nGQY5VuWfQgVKqd6DrXaAhx51RM6/8YOcGiF/T2qmtX7M5WhGbQYNoWekxCqLKY79PjPFR+Xf9avjA4yjgx0NxyexYYkpZJgrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e4b8be-ea2a-4b46-1df3-08db8a063dc2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:19:21.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ot7B3n+MHaXSe5xqeiR999M2otRBH2xOxGtQcgXsvDI0YjyebDkHA2neJkXI6ljhKYiY7f2RzQrYNfGFzzb5UtqzlvNihTp/cwtf20hOudo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 malwarescore=0 mlxlogscore=648 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210143
X-Proofpoint-GUID: j0bHGai8S_twD5biEy1aSOY1yJQdpjjh
X-Proofpoint-ORIG-GUID: j0bHGai8S_twD5biEy1aSOY1yJQdpjjh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hi Yonghong.

This is from the v4 instructions proposal:

    ========  =====  =========================  ============
    code      value  description                notes
    ========  =====  =========================  ============
    BPF_JA    0x00   PC += imm                  BPF_JMP32 only

Is this instruction using source 1 instead of 0?  Otherwise, it would
have exactly the same encoding than the V3< JA instruction.  Is that
what is intended?

TIA.


