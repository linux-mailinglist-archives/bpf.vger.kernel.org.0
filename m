Return-Path: <bpf+bounces-12314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 834707CB130
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 19:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF2C281623
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 17:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF37431A70;
	Mon, 16 Oct 2023 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pqeq6zWI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yKq6L23V"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC86168DE
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 17:18:19 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61276A7
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 10:18:17 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GGwvC6023655;
	Mon, 16 Oct 2023 17:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Hc74TY9wmQkYRj82cyozuna2vKYLhJnwlzi4osCF20c=;
 b=pqeq6zWI7NE2VvNwoM/oL6vhPQxqJsW0Y+jW9w4FCW/6p5LEypxmuJxdTTLSEh+okbVD
 XZP83gUujXsJ5cpIht42MK3l5dbbKiZe6g/ovyCx5t9XCRZorYI8CRTY87+p5gs6xs+o
 lCnYeCfoaWcqCBFNYGDyuUgd7uCGQKG0KzSQjMCOJxUNZ7vPeUrijs6kaxISewzP+5PY
 Y9k6IPqBHZ7gD46lMHeb3SKw8YuFXdDgWO5V5pXcqt9KPntYYg4YzTuhvOM5f2zQFlok
 cRpqQ17TK9Pr6GU2d8xgEg62qrkMObytvtIHJjMaOCebU55BkvurCfkotpe3SATg8MjD 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqkhu3aj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Oct 2023 17:18:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GGJr8s028210;
	Mon, 16 Oct 2023 17:18:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy2f3qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Oct 2023 17:18:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwLcx05iEd/+pGU2SiJAM8SnMKTSDXgpVLOym10doqAk4uw8Sx67Tuya18+qODWvoZz0OS0vfj8yax/BMkXOPTc3tdB/ACiBqfjZNaXJL/1d2CsiXbABD6v+EpZHdAO6LQOAuLM6bAptUm9Kq8r4tcrkwJFB675Ca6ZX+WS/4eT3C1ITuMQbvklDKOO36gEjBJmaNtiLWI08xRp0GM6o6uDKR21rwv2vc8Vp+IwOG3P3EirDjrEFSC61SYYku6bttaZTl/LBdulqmKglEPWSfnNndqPaGsgAJFlryAhitMoCK1Gfl2Lc/FCXMO5pYP7bVunqIiJtJI/rA2qGiwvYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hc74TY9wmQkYRj82cyozuna2vKYLhJnwlzi4osCF20c=;
 b=K8AQ4qbTHz5uWHGYQXYboOhBPaUz0g6rlSQ/JI4l+3mvxVAB4cRWotKSpP4omrFl4yY8gpSNX4EPVixhQAIjh+B5lH61th+7w5dkQ3cuAwfiufccbL5nIwfcXAfN1P1Ejms1ZFpjzrNHHaQnE1WC18B70dRNwhNtBWpgccXnOftQERNcvvDDGchH0bOPkZJXtOy1ceuZ2UoET18RNQZZtgrxzWXtXmykLxEo7up+AOOViBly26MnTk1CdT+P90aTYKEFdXrvnsY8JQ+DutDkRWB0EX2t8Fhv+eD+FAPiotjsJXTyyEM7LU6g3FlhrhAirsSE9SBOD303oSFAn25D3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hc74TY9wmQkYRj82cyozuna2vKYLhJnwlzi4osCF20c=;
 b=yKq6L23VeUwlQyNq/59fx2ZIZLwAf4FqpndF63CNaiq81vXpapdVu7s/qG75wHHVYmQUVbvugp7Uch+SneTmUGTrWoiOhA/oIyXhAKXA7GX3kUJVl3zBBF2H46JvPOG/mbs44ythfFxS9DAGZpdGNWDGMSaUi3tFRtIkV7V4Fo4=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH3PR10MB6692.namprd10.prod.outlook.com (2603:10b6:610:148::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 17:18:00 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::664b:258f:3ef4:39b8]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::664b:258f:3ef4:39b8%7]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 17:18:00 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Barret Rhoden <brho@google.com>, Josh Don <joshdon@google.com>,
        Hao
 Luo <haoluo@google.com>, davemarchevsky@meta.com,
        Tejun Heo
 <tj@kernel.org>, David Vernet <dvernet@meta.com>,
        Neel Natu
 <neelnatu@google.com>, Jack Humphries <jhumphri@google.com>,
        bpf@vger.kernel.org, ast@kernel.org
Subject: Re: BPF memory model
In-Reply-To: <5b23c67b-8b15-4d54-8f38-c201a6842b20@paulmck-laptop> (Paul
	E. McKenney's message of "Mon, 16 Oct 2023 09:48:21 -0700")
References: <CABk29NuQ4C-w_JA-zev796Nr_vx932qC4_OcdH=gMM6HZ_r4WQ@mail.gmail.com>
	<33f06fa6-2f4d-4e50-a87e-0d6604d3c413@paulmck-laptop>
	<5c3b16c8-63e6-4f80-8fa2-6bacb38cdcb6@google.com>
	<e5c6b7f7-3776-4c2e-9896-fe44e735c1d1@paulmck-laptop>
	<22da941e-384a-4f02-80c4-8b84c0073f8d@google.com>
	<5b23c67b-8b15-4d54-8f38-c201a6842b20@paulmck-laptop>
Date: Mon, 16 Oct 2023 19:17:54 +0200
Message-ID: <87o7gyqyf1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::19) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH3PR10MB6692:EE_
X-MS-Office365-Filtering-Correlation-Id: d93083ab-e6ae-42c2-70fc-08dbce6bd8f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8lZBaAgp8mxM0XkTv7NSBFabhEW3ooOzmxy+dRGTruo2/xiQLKMVyZfbM153qLDbdHpVjeOo8ULhzv6mwPA+5VnDVzw4bO4U+Aj1n8u7veBMpiX8YBHiyqLfcDh2DdcM5KGA7BNnVY92GeFawG78mde+/Gofz+AXHKDq/ZoSiHMU1b3zBC/yLstiL6A83m0m76s8fYplSYWQy9CeiFG28lMmWvx+eyj2aEvUZGJUSDJIefWInxZFoCDWPwDJQQFcy7U+TDUThfvSQIFtuY8NmXh43NbBkoiyNMPrLFj/pu0V6wzlRvboon6Bfv0Zv2JwPBXctQyMqGZqGZEKelHYpi2gNAZDVAAvUOWSbblo0otA44c6XdXD7zIjEdcfarKGub37jz0YrYVZGXRTeZIqRIdDnjQMa7hRP3JsohHgxvg8pAht5D4iIRgbIdke329MbmLKOsbXhs8XC6PXtKuk2qt8v9c9bG5IohQTULIze3ZkeQBwRoK6137XxD9UYVpezATm7VvE0xFlLQa795F/AEfmwvEBP841l8AaDBtW1yqdxKyly0bGOOEinAc9qp/Nn7Bi1ecc/4yenJIkgsMu9QvHSz1Oo/6dx7gMhb2Wi+s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(66476007)(54906003)(66946007)(6916009)(66556008)(3480700007)(83380400001)(316002)(38100700002)(7416002)(2906002)(6666004)(4744005)(36756003)(6506007)(966005)(6486002)(53546011)(478600001)(4326008)(8676002)(8936002)(5930299018)(7116003)(41300700001)(26005)(2616005)(86362001)(5660300002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JKZ6tVlkJPmcKsWSerq81iCo9bScQKH0YC8MhW+9AvjECqgrzlOry+tVQkT1?=
 =?us-ascii?Q?hStzIYa75sS72gzjHHgTnfkjFjPKqkLfNLKKjkK82IJ4wamnTPJIkPBP9zya?=
 =?us-ascii?Q?oX/Cqf4e4v1nvS6M4klGRZekcc1Vmzc6QDbiCJSY8RN6hstE0+ihkW7NxTRg?=
 =?us-ascii?Q?NH5CwFE3bw5n0kReHENa0g7qPe0Pz5b+3BB+8wcINWnqbTd4WgcbbwnDdgl5?=
 =?us-ascii?Q?fy6OoTY7/9Hmftbnd17VEhRwiTEc5wTofA0gCYd/7QeaozJsdyQMGKp1xaqd?=
 =?us-ascii?Q?+kah+VuZjRaVEv3ZdyBzw4yFZja4lDFUh9MozZhcg5VZpGF9fzJI/O3qlNaO?=
 =?us-ascii?Q?wrJC7dA8cH0TS3jCV7pM5jb/2pCFGaYT912Bna6In1hugKKY9do31Z84Emne?=
 =?us-ascii?Q?QyI13Nw9Dl5XxY1OMQkAun8fPV9nXCP8L6FvNZ7khPromRao2dvpnONLFpS3?=
 =?us-ascii?Q?0HTISBXWDDzKenoq5jH4EPobCWAC/hqkLzKJ7EUXhCkRSCO7IGIKPPGLmVuY?=
 =?us-ascii?Q?7V3X0Lf2WC9t59jbBTd3t7OdKDwvTsFDPDLVDsJY03mZisYfdlvLM5fHKBFB?=
 =?us-ascii?Q?oI8o7uy/EjrDfqFUtKYkRnsV5Jfi3F0EKKhwz6jxXI9fzof1/7pb3A7gEtYg?=
 =?us-ascii?Q?K057tnxvU0PaIEQGHcCmK9LF/Rdr8z/ApoxmEgriFng+Og4m0ogs0KrZ+39k?=
 =?us-ascii?Q?a8b6G7wbGtjNEY5H+fPe7VSvlKzievrb0UewxfeZAJNPCECaOyiw/1jrwjUx?=
 =?us-ascii?Q?8b855tWkQ5iZDE4BEUVHkdWywihECyxutTyGhkR72/IO3gElmd6EOBtAju0y?=
 =?us-ascii?Q?10hlaiuJHYp3AW1ZLqMOJ4Sl8LHlnMZLqVq4jQgi1EecBSPAP8xYqbp/V1pN?=
 =?us-ascii?Q?hgTcuMg1FLP5Q53Pl2en91Ev7CbVt0JE/VCsBHXrLvRb0H+O6uI+Y7it4rYW?=
 =?us-ascii?Q?fjbVxqSB1iJjOXwRr+amy+8g8S38Wxme1SEJ6F2xj87SGiaGN9IqWNHS+ein?=
 =?us-ascii?Q?yxFz4RDSPtgglTvGrE9NZSiohJZ3fMX05HgRSGtztdSvDayBxeawJ+qtd4Eu?=
 =?us-ascii?Q?S8pCs/dOescCt2qGo93jPmgYJ7vMY1eGUwCrutV4UZp9RjZqPgzljWoy1f5f?=
 =?us-ascii?Q?XWxy8Bh6wXjZYOGV004zoPZHuse5tNt1gHwUVduYl4IdGvZWgLFN+tCu3zQK?=
 =?us-ascii?Q?ce7UqnBYeWyGUkPNPZsFumLVIKWHcPX7JomU3XqB9Urr+bhkXroTSvE5v82V?=
 =?us-ascii?Q?FYlrJ6JLQM+5PQSHCHkyo/zIWBd+GdKeU7duwrbuO+LAylC/wseSandZqc0l?=
 =?us-ascii?Q?BPXXaIkpE3xxWRy95ajbOD3BifBws8IUqs6uqZxKGCjIqREaoz+aiGrPW0w3?=
 =?us-ascii?Q?qBdlTZTghLee9usE/QVQZUcrYXr606ta098kE9yqPGeM4WhXzqeYaORZ6HGh?=
 =?us-ascii?Q?eXUWub1A3LKQp6NDrZg8BEecyDPSoMdYDJ5EacuGsQcSdBte8fgc2IUAuigL?=
 =?us-ascii?Q?z2JIWxrd1B3mLGNwwUEL5OQQjfxSCRTyK/pR/0RRDMsi1dllhsuuh+/Kv0ir?=
 =?us-ascii?Q?jqpCG0+lJQgM1zlsoy2oeCzFQA8QCGM6lWt/f2KdC7+Z8OR2xIbk205eMpo/?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OiDFPQ5hhmkADau0AtTur5da8eg+SJ1DzQQTmVByKLcwahV6waV6Kk939f5rndH4QcnZLJf05rc6+4Y6+4kAY9zejRgoM9VPTmRrmGOkmWrtfRBN0U2BsTOsUjo3tErZyIW4V8rQxYUxt3oKo5+v7ffabNQzx9SkL/HJNnYFQwupDTzlPA20O73hzvGySLoxAzMAvWirNCihgkFaQxm9mQE9pwHlvckwotROYaNcwC/DCduicgn2WBLq8HMht4KfaxVPa7v/qHyQzJ40s8mBkTVfPLKCAKPB6c76YLJ/2K5Y1Hbs7Eo412/gZD6OSC+VffsEN9ifShBCC3tGznwjDp0CZwI5ZKL14cvH0gsOfqSgZRVUy2S2lhnSYJJqfx/f5WBH2h//ENak7qdWFYhYaIycztjcrgpugecYgNTvd3ikqB4QnHwBRk9C2uL4tVj96dxMx9u1s8gF5sIWUL2qbFyYlhFEhx9b8KulMKW9P2GbbCEbpvdfsJsG6TF5uP9uTNsC4rYi5HezArzr/zjdnOedb4QoL4ObtDTBdwlUZxnZhS6WTFW6oQg3a7AfiIc3AMAyY6G1prpDlqv3hLn7L8Em9pq2ZlooDKh6oD+RAeWae+oyg1YFcz1WZqNug3ycQUqws6R5HBpdCu6jqlGJJme02+BZSku89WqNbtqtrnbHZm5gni2GvcTZyMFOQbZj1TYGkGZg5lBfWxZeJRnXBLQbGootZWtk4VOvgQISGhgGsxKw50GpQEoWr3W2WjcNnya97N0wNT7P8eBF8J/IMNvYUa0FISkJIUArJZvVZUa9oHZZbtzITBy3w1nhgG+nGHQDCjELJ+SFRNWJF/Tj0a69D3nt+nfAUSp87dP1TTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d93083ab-e6ae-42c2-70fc-08dbce6bd8f3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 17:18:00.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1FChwnzIBKNPx/3Y/JCOUpRhpVn4O94t2nFlVoz1v6qpchaWMjfxdzqhs2xc8YLS0wgj72HHyGTdaegwOa321VFDmRk9zZ/fW9jzORLfAT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=933 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310160150
X-Proofpoint-GUID: 9R9ToOzfanJNC4ra0CNWA_vBAfAb29IS
X-Proofpoint-ORIG-GUID: 9R9ToOzfanJNC4ra0CNWA_vBAfAb29IS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Tue, Sep 19, 2023 at 11:55:42AM -0400, Barret Rhoden wrote:
>> On 9/19/23 05:52, Paul E. McKenney wrote:
>> > Just to make sure that I understand, the idea is to compile from (say)
>> > __atomic_load_n() to BPF instructions, correct? Or is this compiling all
>> > the way to the target x86/ARMv8/whatever machine instructions?
>> 
>> correct; i'm compiling with clang -target bpf to BPF instructions, which
>> should be spitting out the appropriate BPF atomic ops.  then i hope that if
>> i get the compiler to emit the reads and writes in the correct order, that
>> the JIT maintains that order when it turns them into x86/whatever.
>
> Hopefully better late than never, here is a draft:
>
> https://docs.google.com/document/d/1TaSEfWfLnRUi5KqkavUQyL2tThJXYWHS15qcbxIsFb0/edit?usp=sharing
>
> Please do feel free to add relevant comments.

Nice :-)
/me reads carefully

