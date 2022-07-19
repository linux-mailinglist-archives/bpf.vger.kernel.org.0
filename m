Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6551557A509
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 19:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbiGSRUZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238901AbiGSRUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 13:20:08 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C325B7B1;
        Tue, 19 Jul 2022 10:19:55 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JDbST8022558;
        Tue, 19 Jul 2022 10:19:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=w+J+qsh4ILWWEtF6d5rkOEgNcDivguxXhnHo+nOLgJc=;
 b=EA4wqxJg58Preq+aQCkJBr4rPZsTb9PVNW8dWnulTczqd9X+93EdMhQzGkmOHgXs35Va
 AULIKJ6EYbHV1jDfOreamnxq7auEJygPt7BXChGug4fLh6KlChhvyDuE8jA+urshXQRt
 5S1YS2CxCRbVINwSRCBsH334OWf59zwnB9Q= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hdwna9q7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 19 Jul 2022 10:19:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIk1vJuRMk+KHi4xij3crHoIaxw98nb8Lyn8tDQsX61LIf5KkyiX619dOt/tcv/YDNQ6ekMy3ZJkEb8JcbFjtvUYs0cSbvVX5yDN1K8KrFMt8qn91H6K4xp99r84EC6jawBddcrgF5Pw8sMmGCgqRWnbLDvfFjnkUIC6kCi9mldyj94P/BjAowRU6NT+UJGXrcfsAbMywzIj93buLbsDoZH/Huaui1H30gBkvrLxKIhRdLOnfoo67SRbXVU9lU017OMNfFVWpDaNeeLh3ft/EHYQFKrqJFtYmmFnxATyCuXBwjgSNf7hnHVQMsb1HrQTkKYrW9iJ2Kigq6lFulpLKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+J+qsh4ILWWEtF6d5rkOEgNcDivguxXhnHo+nOLgJc=;
 b=iLg/Ytl8Lns7ZpOSWpcMSAM7aPaCzXBU88GSF1R5cLhyvh5F/T5FQvyim7gMg3F9gatQ3lPVlnJFJUJ/BPxpBZFvWsdK+OnUcfJkre9rzLtdoq7iTG9t8Di/kju+xoPfvZscRzlwdYLvzHEAtjjAk7C2eWk9xMNA2KyH1EKkFW5emTVgYu49oemAliyLq1K/DtJlM/Po9wPRxaARHdi1zBQJDQ7WnvZO4B7sN0IB3r9PDyrbY1eDyLqCwY2KywqmtIgguIj/9VzSEIjprfVGgwCzmJR42W3VTHCzG6g8D0OD1XV3d3eQF1ZlQqrcqdYlr9hvp6wKTZiPO/TbO9xifw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BYAPR15MB4087.namprd15.prod.outlook.com (2603:10b6:a02:bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 17:19:36 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%8]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:19:35 +0000
Date:   Tue, 19 Jul 2022 10:19:34 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] libbpf: fix an snprintf() overflow check
Message-ID: <20220719171934.ugavrrucmcguqvxe@kafai-mbp.dhcp.thefacebook.com>
References: <YtZ+oAySqIhFl6/J@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtZ+oAySqIhFl6/J@kili>
X-ClientProxiedBy: SJ0PR05CA0137.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::22) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57f671fd-b831-4aad-4635-08da69aada6c
X-MS-TrafficTypeDiagnostic: BYAPR15MB4087:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkJkIkFd+sO8v+JeNrA95YajJf3KZrNIf928SMr69ZIea1A2kHc/8m/2o7us5yiivebKLbsd1WS2ijSsVxShtkAx57uS7PY9q0ub/XzRk9eYpEjst9efn/17zKZhmxV5fZ+qpAxkJcRGJ8tsM0AtYX7WEIjLe2IsvnlGcIF2ufeEqgdEItkJJ1gNVdDN9JQq+fCEth2OimH566MK9LA09kon10H4BEpiegbivfhpZU6kL1hwQXONKPrH57oxJyfGvTdomYMtfS65XyYjMRM9vuDUMcF24Dy6y5tyRzs9Sujy5IwYgCL+LFuZol4vg56Dk1JMWVOVjjhZFS/KijfYBuepBJGSxGm6lHrnmO+HsS6Z0Mzs0LJqHuPBKbPXkc6nZf6xLJnsO0BALpo+7mRizeVSwnURecYJxHsufkIIWWMA6BUB3FRLVVUWxDpQz6xALk2Gp3UiXfrQaeaz3fuUwlktOQjoQ7J/miuL9iL56/BI1v/thKgddpoU0qPquBFrTQwPFBEY7yTZYSk0wWYmD93YO4erz6TSOK3dsojjTDrHOjZ4xtuwE26JKLGf2Ii+ys4SYHDg/3bham1Pjfi3QDslSPQm9CeJ4YLvKkvSCruyqgSabNVf7BoDTNC25JHMY/2PnXOduuCeUWaQAVqwdGG2Ae1FhPqRCTn9mqVrbg+a4lE/OKKGpoSL5gXiJhlhQUiMFpG2pox+8VUmClw3fxgLQyCZTvFnUNKZSiDFp0b4frTikz3olkb6tB2N/U0B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(54906003)(52116002)(478600001)(6916009)(41300700001)(3716004)(6506007)(9686003)(38100700002)(6486002)(2906002)(6512007)(8936002)(316002)(8676002)(66556008)(66946007)(66476007)(5660300002)(4326008)(7416002)(558084003)(1076003)(86362001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQS9KWXwsZYmmJ2BkOoa3B3vde1FbszhXjhPDdz00yK7Bs8eT9XIp/oWMQth?=
 =?us-ascii?Q?BdkusL4piHqEanep7tWs7WDj8+Twkth9hi3FuJK7TgXqsX7cKzsbYaMCbLgA?=
 =?us-ascii?Q?Tul/NFsMVaMBwCnnpL94a/5QPUuuD3UMv8oSFeCI6ayiYCKcLv1lJvIUYCkg?=
 =?us-ascii?Q?MZXE0DAC/hZp9hiFBw8MrtZlqiHSKaF5m6gh1EDmL9PIHbMpQsr29nnNtcDQ?=
 =?us-ascii?Q?AUTGg5mdGpa3crri9gHrxNYd6YCzyLIbmzCycz2huYSZydpBg0ZNyO6pEBZq?=
 =?us-ascii?Q?mj9u9jTj9wG+l5+4SrGChQ2OPi1vGdckKg36I4wr75D+mQITqIUpngoz+cg0?=
 =?us-ascii?Q?MDlqqHdWs8NeM1sD71QTN06uWdf5t9GUJf5YizgvwJnpx5ehLqgOtpCtuPti?=
 =?us-ascii?Q?85CJ6mxmdZsKxOuwaOPh8sjNdM2Uy2EP4etmxkW4OIsUYXnjr6of0T+QOzrz?=
 =?us-ascii?Q?Asch5bHOhAZxf8H0D/k/5yv9x5FFv77UWLuHmdIkr0h8/oKnt6XYU+1rU4OT?=
 =?us-ascii?Q?iSEONgkKHSf7/WGQiOdAqPNDsLVw95005xmqEiD4vDpeFOP8mHMHwAJtO7zf?=
 =?us-ascii?Q?6eA++PvVdf10aKtphH3EPlTnHEds9WtugZtQZyPAqs9xS5Y8Oao43dZeEEG2?=
 =?us-ascii?Q?kAC82EEYSV25pH3cb22paYpkdhWCMnZgIUgY0X4xoO2Ohn5pS8r2dTRW5iXU?=
 =?us-ascii?Q?QTdmVz9W10jDWcvclKiMLvCttYfKYqI5pR+M7ugMnqlShhkYHIYWta6fCoPj?=
 =?us-ascii?Q?/jzvWHCkQJ9+9xvox2H8J3xn8YfhsOW3wac2AsmEyg4ClalZafOY1kYdLYhI?=
 =?us-ascii?Q?dSHb/Q15QenPsIgCmUkKKjXaGN2Y+J7AAz1vC+uLzpKHH5Y/EZ+8j1uwxfrp?=
 =?us-ascii?Q?wZNdbZRsqf2vGXcS06HGYHkHlwjhy/8WojhvksEM3oJfRNM8yTudSrcmTT2j?=
 =?us-ascii?Q?rpvcDQDzFwDFeGm6jBojIzOXwLKmtIcYuS91XKx+/tnYlETVQvpooSIB5k2t?=
 =?us-ascii?Q?Z+aT6Qf233POEfqke/oPDy6ZYrujWyQoRFHdKA+zYOv+ZkHKmYOBijnUdw1z?=
 =?us-ascii?Q?hheApCgyJoueI8DxR5lPNiaNZb6r2Y+OCpwrOrMn9clGE1Xhpxm7n99opTkQ?=
 =?us-ascii?Q?p2TBDVmthn4sK0AtT0TfPgP1qyJ9t4kI1ZHw0B4nB5sMWqlRTf+MaiadpyRP?=
 =?us-ascii?Q?5Q7tYzqqWjX02JRBzVyOPmePPyYs8rTus5k7sxo4tlP0FsoDzB570xnorpAm?=
 =?us-ascii?Q?3L/t8zdfwDeAQtf1dvI+gtsYejSz55qADJ8Z+99k3AGp+IoRuLHaoeP385CO?=
 =?us-ascii?Q?No3KrzIVJ0wLNlJT7joWy71PoqWNWomrOZY/2GG8sugV0UcF+eTiJ6uvEldL?=
 =?us-ascii?Q?ApTqZPCsd5zOFMdb5eHnji97QgCRmeIosx1slPFHKKwbBaq6yRc8EsV0qU1s?=
 =?us-ascii?Q?xEBbOUjR5sjIC7c9L+8vINE/9FURmcRevlxkIfxNPdNL/entgToalUhXEcMa?=
 =?us-ascii?Q?hr5mmHl7WZ7E8uUvq4u5DwhVaNZKdhhZw/jYeCK1yhBnrJ7jM4YOgdiJTJos?=
 =?us-ascii?Q?RI+PGaATubavTislVTa0ixGhZb0mhVg6BwjVr8rJ0YskwGLwiRq9HLX+UGth?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f671fd-b831-4aad-4635-08da69aada6c
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 17:19:35.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSFiu86v/jTxB2sFOo6F04+GEL8Q/61m40SsvoGoKL2xMjDePGn17ydSJZmh7jBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4087
X-Proofpoint-ORIG-GUID: nUDLW9CUdCs2h7tFIRJX3J93xREkZp3Q
X-Proofpoint-GUID: nUDLW9CUdCs2h7tFIRJX3J93xREkZp3Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 12:51:28PM +0300, Dan Carpenter wrote:
> The snprintf() function returns the number of bytes it *would* have
> copied if there were enough space.  So it can return > the
> sizeof(gen->attach_target).
Acked-by: Martin KaFai Lau <kafai@fb.com>
