Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFF1FFB54
	for <lists+bpf@lfdr.de>; Thu, 18 Jun 2020 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFRSwe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Jun 2020 14:52:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725953AbgFRSwc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Jun 2020 14:52:32 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05IIkXRR025634;
        Thu, 18 Jun 2020 11:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=pe0fdfnDAaaGy2epRFSu0mn5Pr86zWnTQStfQvQAQCA=;
 b=P8/DzN0ixB4rqvfPaBDck1/bWlA82deumfWqaF+cN0Esp/OAuqSO504QTBPyJIxGmjOr
 WIwp4IE1ACDGbBMkh+4MylGcW9pLM1wUjK8FuwCF5STS7QMiolk1C80fbEpZoxJ3ZQdo
 /w3P3kEtdadXEeAqCEfGfmus6G4CqfTqhKk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31q65ddwqc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 18 Jun 2020 11:52:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 11:52:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeVQ+TZ70ksWwREYysc46AcHKiGJI+QCY0D66s/plPN4DBd/U5AZk5q47w/vLYJRBh0W1U9HY5sLuB7kMCQsdAB2BvF7Bh2MssiqwmsSQQC4MOOmguoaFdwWU/27tsXZKZR5aQJ+D4m43NMT1lPpCJHOS7eiPXb//LqhaZLiuUHgrlNGjPdmIh+7zNIYgGxCer5iWNSeXEW9NqXZAuNHJ9HfNMZhZLAvdleqEHjUP2NCP3MuLLxlYoHWGPBi91SGxRobnp6FsYPL6/tkuV3QcjCy9QlypzXIebQEn5Nf0g/46b3mULMBzQxLyG3tRSL8NhyFGPPC3Q3gjWtQLifenw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe0fdfnDAaaGy2epRFSu0mn5Pr86zWnTQStfQvQAQCA=;
 b=Cuq4ecVJ+pQDJz7OmoYKiA4UUI+HKSqSwLvShzng+FJ/0rDrAJdBTIlVtwtDlZYJf2k6a3zux90an7RUmjuVLZAKx2V19r9sqCQr76dmm4G0aA3AImdBwTXKcqkY2S3CN7zQvZ8vunHujKFswJ86Vvjkscahml/r84LDcbn9uqkJW97qlXHngRWQeeYjUy4eMSsyvj61Jmnw8M4LtGYw2ZlAlHo9JKipN95wFkTa/HbFneidBcXii7STuR0PJWzgIiQVfdf7HvJyEmO4BEayMfMunTmTWdays5z4X+lRl2OCfj1LH3l1ga14ob0je8NcLdGwi3G9ARi93j1uvSK1bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe0fdfnDAaaGy2epRFSu0mn5Pr86zWnTQStfQvQAQCA=;
 b=IXarD2iQYdOO9bbI3k1JUHAD5+nJLZ8rJFNyPzIoUCFqYDDE2u+N4LHsNppb+eXQjjGlXhCEiW644RufMnZsY+sYmEn5870o/G4Lm9NPZmeYR+WnI7k33IBiOjUBOT6TkBjcQ8glyZp2fs0ZX2aqWyasjO8P9/0Lgl4fxtjhN7g=
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2693.namprd15.prod.outlook.com (2603:10b6:a03:155::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Thu, 18 Jun
 2020 18:52:12 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::b00c:d8f:2544:f92f%7]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 18:52:12 +0000
Date:   Thu, 18 Jun 2020 11:52:11 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 02/13] net: bpf: implement bpf iterator for tcp
Message-ID: <20200618185211.gtv452qvrkoeh42s@kafai-mbp.dhcp.thefacebook.com>
References: <20200617211536.1854348-1-yhs@fb.com>
 <20200617211538.1855792-1-yhs@fb.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617211538.1855792-1-yhs@fb.com>
User-Agent: NeoMutt/20180716
X-ClientProxiedBy: BYAPR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::17) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:d71) by BYAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:a03:c0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.10 via Frontend Transport; Thu, 18 Jun 2020 18:52:12 +0000
X-Originating-IP: [2620:10d:c090:400::5:d71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 635ecd92-54b2-4430-679e-08d813b8b630
X-MS-TrafficTypeDiagnostic: BYAPR15MB2693:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2693172EF7DCAE64B183CFC1D59B0@BYAPR15MB2693.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0438F90F17
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6g6lLONtAt1821kl1rO0Pp57wEjh7JfotgrLDMtEolGXW52kZ/8u2vQH6EfINRUT7lCyxtp2Pn+cYUCml7yIsaRZjjZCmrUPfts4jZdfiIvJxbZ0hgvq/6m2hRbfsZz1L7yeloBqtxYZ3Xqs3RAJSau2behYhAFINctulqG6cQ7yKJpfBqDlwxgDFZqwR/tA9nZ6xTs7K9wiSo7pZ0j5sgy/4EIhVynKJ4or3Z/sC+RWFK3KgszssqIVFAp/acc/fOEqdX+NNqEI4xujY+mgq+YJe2uxPaXzzsGfgCkA1Q/ZR2h12wwaLIYzj9jR6jBeUcduQiy+c44AweJcY4Kiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(376002)(346002)(366004)(396003)(136003)(9686003)(83380400001)(66946007)(66556008)(66476007)(55016002)(6506007)(8936002)(54906003)(52116002)(86362001)(478600001)(8676002)(7696005)(316002)(4326008)(5660300002)(1076003)(6636002)(4744005)(16526019)(186003)(6862004)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Hdwy2M+ApA2H0WcWoaUCJ7oEURXtfKc6WIz6DyHw24jMhgZ5N2qWEvXxgbqnAimwYYWNz4BrlLiWVc4U9lvaa6WOBPm2sO8ipZ/ZnH4GM8mZjwFQ0zyunBVe/rVfNTp3MiCah/Yn2On1hmoY9s01ciauYXxNbqjnKcVI1ZccI/xfC5S3CPWp/SCLDPjknWU44L6l9hwswcOdICNX8CuPs3u2eEqJJ7R1XelQdMyvgI03L5MaVyv8MDhhRCTARMRHZ+COBbgIe12iWuCM7KCL45OU2C2ZUd9kGe3evQg0lj8q39b66j3Y8R3kMi/yIj5Kzo5iJuDwVuDWeb2xgpjBeGbAiE+P6wNewFBzYcJ4bLuFx3TVCpjwqmYCzGxwX6XfAQI0KA86l/QzIfMfkEY86avfohp3qIrJPEoHH1tDRNzvtUMZxB6v/9+ko/gzKiH+EifjLeh/prXyQx/W75SROpDqOB91vDbFyJmZCH5jSqUX9doQ/HyXwO+TrGB8SBCbySEDBqODtRaAqH5zpZzlPg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 635ecd92-54b2-4430-679e-08d813b8b630
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 18:52:12.6519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXR6xC5XbNcYKGPbhL+6zmbeDp1ifph9S2an54yrf4q0VGG+EmhPE8PG1QXizs+I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2693
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-18_15:2020-06-18,2020-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=964
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 cotscore=-2147483648
 phishscore=0 impostorscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006180142
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 02:15:38PM -0700, Yonghong Song wrote:
[ ... ]
> +static int bpf_iter_init_tcp(void *priv_data)
> +{
> +	struct tcp_iter_state *st = priv_data;
> +	struct tcp_seq_afinfo *afinfo;
> +	int ret;
> +
> +	afinfo = kmalloc(sizeof(*afinfo), GFP_USER | __GFP_NOWARN);
> +	if (!afinfo)
> +		return -ENOMEM;
> +
> +	afinfo->family = AF_UNSPEC;
> +	st->bpf_seq_afinfo = afinfo;
> +	ret = bpf_iter_init_seq_net(priv_data);
> +	if (ret)
> +		kfree(afinfo);
st->bpf_seq_afinfo has already been initialized.
bpf_iter_fini_tcp() (and iter_release()) will not be
called? just want to ensure.

> +	return ret;
> +}
> +
> +static void bpf_iter_fini_tcp(void *priv_data)
> +{
> +	struct tcp_iter_state *st = priv_data;
> +
> +	kfree(st->bpf_seq_afinfo);
> +	bpf_iter_fini_seq_net(priv_data);
> +}
