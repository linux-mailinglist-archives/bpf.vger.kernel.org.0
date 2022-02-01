Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954014A643F
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 19:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242047AbiBASxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 13:53:20 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:24588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242043AbiBASxT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 13:53:19 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDbkr010655;
        Tue, 1 Feb 2022 10:53:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ot3WkNpiDw8vxUaW+zlVwYqveUuFwCLSL/5z7yyW5Zc=;
 b=QJtp758iS6mSgF3snLANnrd7Phx+c9HNifkMHnKyLjzwmY8ZZBd+7NYeJhcK9Eg3NUzv
 nF2AZ3B/goFNXXAacnykXBaACqifjhX5rvuxNFE7K97pAXpV6MVjb+VURvOH19Gmb5Uj
 uC1YNjNG0yHwRkjkTSIShjsXRA6ShHr41c0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxer4247x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 01 Feb 2022 10:53:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 10:53:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLQBrAjVh5edldffphygjutWbQNAcby1TxfDeNCbw6kigiHxhwGmNIdgYxGcoyxlH582q49iFqqpmD+NAla+X8hlaqyivYKSctZGYLh6Ou6UgP72XcMaA9ZF4Qx0REgEEg82UcS3CXq1Hb9SOdY1ZZNsXThuc9LtnBv9pD00zuGqTH02Us4vWMkVLtdNv78SlmPwgftd6uvWfuypY53CGnNvytgsooRaLILvMaEE7DGCqViCfBjVuJlDWDDIPyjUPUfM3oFwdhiEF/5xVQIQC33phMRiRwPhaQiNyDOTX0BD7QsPV9FJelbMOEetG2qpPQMviHl7L6IlRZYd1mc8RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot3WkNpiDw8vxUaW+zlVwYqveUuFwCLSL/5z7yyW5Zc=;
 b=U4VJ2do8SfDxRRVAypgWIOGugbqNbu5+MO/bwMh5VjzLU2zegOIfQzHiaQY5ko8i9TPoSzP/HDG6Mk92e1DjQYC9t3DWYQILafHG4LlbqeJgnMezE0+uKDQFlO6OC3KCurk6Q2N/fq1+pWGZxjgBzPd5xZSfRI2qjUhcZ9dvIX4DzrLGTaQFIIwFb+VrJkwQgTqafhQ+SH7sVbpNgPARzu9MQkXNky5hHfL9riWYnTA5mMnxHrmaLXpFKBupkhQPQrgd8+eJDdgWlUiX2O0nGHlNyYB8PYW6vukR7bBAQVEHZ7e6BZaZjvyWDSRRhlu6xud1SMuk05P25hEq05Ke7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SA1PR15MB5016.namprd15.prod.outlook.com (2603:10b6:806:1db::19)
 by DM5PR15MB1561.namprd15.prod.outlook.com (2603:10b6:3:d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 1 Feb
 2022 18:52:57 +0000
Received: from SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437]) by SA1PR15MB5016.namprd15.prod.outlook.com
 ([fe80::b0ca:a63e:fb69:6437%6]) with mapi id 15.20.4930.021; Tue, 1 Feb 2022
 18:52:57 +0000
Date:   Tue, 1 Feb 2022 10:52:54 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     <davem@davemloft.net>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/7] libbpf: Open code low level bpf commands.
Message-ID: <20220201185254.eofdtsxf4leual7k@kafai-mbp.dhcp.thefacebook.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
 <20220131220528.98088-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220131220528.98088-3-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: MWHPR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:300:4b::30) To SA1PR15MB5016.namprd15.prod.outlook.com
 (2603:10b6:806:1db::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66d6abb7-7b8a-400a-a38b-08d9e5b40fa0
X-MS-TrafficTypeDiagnostic: DM5PR15MB1561:EE_
X-Microsoft-Antispam-PRVS: <DM5PR15MB1561C84CBB95DE387C4D5611D5269@DM5PR15MB1561.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hZ54uINiP1eNWnL4HQhzQnZp2Mhj6ceXvLa9TXRi5t20gHFkmZFiGfFGA+fzmBM0XlSk4071kZ68bE8yzLnbKjVmIpnf+voo9pLuItsceg6DIaMyxlL4dAkPPz2fB1RY0Np4sdYnwGYU5TdDnifBKsJGmRhAzZwyEtQedg83xzN51N3ihEcrx+0oW4XJYTzUUBChKIRdaEAJnGRX9Y7xox8ZVArP617/02U7WZjoJ9Ny6fOr0zBeq0cV0JJGCffagRk3KP2T5J1IXjx0ZLckfUwQPOmCgWxFVsh/Tzrp0LCaYBawa5jHnFV5Rf6sJvFSS7zXW+LaqFRTVrJk/lhmi4X3rgOL3DEpPtvVDrYXeQs5SM3+6uuJsdSEMsFSxP2N9sXghrEjOlcsJ63+ay9IRXzYr7aWj/5c75DM3+jiP6N8R0kYXZcTu2N/szxOKgJ/Xcom6+CHD2bzIC/KKRHlzjcr+qB/8Ug4I+lsGJgOrLalvP9fGGtGc6n6rEet2jM0Zx+wTaphKUXlHXH4AWHZ5VSPywZ+yGYf02dvhF9/ICuPhQgWQ47qgxcg42ieQH8cZ3b/cB7AJwLgA621+rAsHGOd6/gTrU7SZ4IG8w0DRVWKBxQT3IyCHmfhzDFf8XmRfgz5zcXxN09TyiNk7aOE4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5016.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(558084003)(1076003)(186003)(6486002)(38100700002)(6916009)(66946007)(8936002)(6512007)(9686003)(2906002)(66476007)(66556008)(5660300002)(8676002)(4326008)(6666004)(508600001)(6506007)(86362001)(52116002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rdy+IZBwSEb2KG8wBpzhDw1v5Wp1wHw4JHUsLWt2PuhFUJxYl5/ULX/YdHbY?=
 =?us-ascii?Q?Kby0YnZthr3kS7FsQUlWr7UimR/vTuaFnIED7lfx0DVi99Zteo8gFgEw4vgm?=
 =?us-ascii?Q?qMqHgi7hRbDGfEWTVbo1obP0bUV2Mi94YdMwddKDnrC+kH3Es1CdqvqZ3MOy?=
 =?us-ascii?Q?qUE4lC3mwJ5aYGH1eyAgubrZmyOuquWHiKleTPfkmOmO/tseO43qm3vZUNfI?=
 =?us-ascii?Q?qwYr1tcOw2J5A5lEaqxbRFyRw9cfRvhTQlIC15MBfNua9tebE7dHmIUrhhDC?=
 =?us-ascii?Q?QFmw3G/XHJANbSJGczkX1RFAaN5uL4ABQSpnic2TMa/nGfqaDSmWE458Wd4K?=
 =?us-ascii?Q?i4MhzhmdzvdEZo3bHOoX6ZHWvsRJr5q7mjkOQEqhr5Ac/5REVMm8u7afBXgh?=
 =?us-ascii?Q?hSbMZxYDzaYMa5k28lsm4BM+x7aDA6lA3YJBIsaDJY82YDgV4CfoZhciopuh?=
 =?us-ascii?Q?WJQbLk3mHobu+4XFeVAQeEBn6f16TzeoVzu04NB3hTD5/yZzX2EBZEOWmAoj?=
 =?us-ascii?Q?c5lrMQmok+6u5pJaWLzLIoYLHTiPxDHCdkzyZCL8Yzls15dDkk9vAsf9RIbH?=
 =?us-ascii?Q?SqcXI4w735brvtYUSF7Y2LSNMcI9hinIBubZIjqtjrVG/OL3C6rWV8VAefet?=
 =?us-ascii?Q?4YGTENT12P1dt13FVMMZKaGFvODZuzYbAMUcA9lw1X6XbaoaoR24Ses5lj5X?=
 =?us-ascii?Q?G5leBe98EfFg3xh6II3pxBi0lITzAoKg2dQdfq940CcuB/5xyjh5xZ8LzuwN?=
 =?us-ascii?Q?B2UgWAHWlMVmaYllhwaDAfPCycx6I8MjV+nyFPvnDxgg4t6NQ9nnwuSxUg54?=
 =?us-ascii?Q?0IHBVI5/Lbr+pMz34KZjgK22Tf5dXm/1hZKyk3bxTmSX4HETEKD0osU933xB?=
 =?us-ascii?Q?cqAOgGXVjS6ZVNZc6BDryflNT2iYa5VxFU0B6lcmyuTPVZtu2+hEYp4pAGj5?=
 =?us-ascii?Q?N1GjvM5MKyLpug+/RMjsClwIxvAjgWj7WLHAZ+AXQBD5qUwE9iZBHBEP/GrX?=
 =?us-ascii?Q?XJ7qLdEJvdDPjnMD6k/TmaEFDas6uv2ix5ZxB4R9I+xPFZgOC5aChqSIe/jy?=
 =?us-ascii?Q?zgUR0SDJWWEB9FRYDtemXepws9BCqIjiCzlA/nIvjEpacJ+rIYef11LiXMPx?=
 =?us-ascii?Q?vV6ruFaIMcKuYkvTdQ+3K3da2UAW4wsLyGcp9CIDoR8xYh0A0zffrk1oFDmw?=
 =?us-ascii?Q?f+x/fMkhPN6PAR3bR+u9r+cxyZK7Db+pOkF4sOTcIvsJNCxHMuP+KRdZQw+L?=
 =?us-ascii?Q?eWkUiQtFJqWs2DbIyBszS8JTGiNOflzoZiY/cZ9M9z2q/enJJt3nrVY6I3yh?=
 =?us-ascii?Q?KqpRObCd7jjO+sYbKBgSYLYldjO2LY6HfGz2wkn3vzezbhXwJVhpozcFNcHg?=
 =?us-ascii?Q?ZuHHkEGf97O6dKIyPU2KTq6bK8pjgLqpAzV1ScHFaRbOUoMgruxNcV7gUYKP?=
 =?us-ascii?Q?6slb4kAKv84dl352Q83oz/8aCeNwrN/igcdwFfG3X5gcdZ+XU7GQAEjeNvvW?=
 =?us-ascii?Q?kO2UwRSXU1TVCXhaG6mHLLJ6U2nSGDKR+m0mRIDa3fArKbRH5NPvy44CvtU8?=
 =?us-ascii?Q?VMdLXwMGyW/GLVuVW/37nB8QqgOp6mDhMmJz7Ip+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d6abb7-7b8a-400a-a38b-08d9e5b40fa0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5016.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 18:52:57.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkpcTvzO0Pb4bl32Jr7esxguEKo9TyvUHosorHyJQOGEXh/ymsgho+HIho1qPotI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1561
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: jqAGgXVM-RsB5YJuGJu_0LqWa9X16ewp
X-Proofpoint-ORIG-GUID: jqAGgXVM-RsB5YJuGJu_0LqWa9X16ewp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 mlxlogscore=708 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010106
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 02:05:23PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Open code low level bpf commands used by light skeleton to
> be able to avoid full libbpf eventually.
Acked-by: Martin KaFai Lau <kafai@fb.com>
