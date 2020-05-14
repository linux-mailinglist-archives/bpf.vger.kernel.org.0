Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E42D1D389A
	for <lists+bpf@lfdr.de>; Thu, 14 May 2020 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENRqe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 May 2020 13:46:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgENRqe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 14 May 2020 13:46:34 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04EHjgBQ008503;
        Thu, 14 May 2020 10:46:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5BSQapadVe5e6ipIW5zwV5j0YGSw0LCwt5f6BgDXfDg=;
 b=R77XeaKC2CJykL8fvQMTSSyMKLM64YMIXOLMbFjVZ1/gX41KQIAjGhCiORRfx/lCdl27
 qxT5os5hyZFLynN7GK2RFEvUbrm96gf3zhti64DNy80lLklC7iZ6EUNHMEGnTh+f0o+W
 a0xoA5qHvM0KjfMb5eRRGpLC8WPg99ZClJI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3100xbcr9f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 May 2020 10:46:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 14 May 2020 10:46:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmfTr9xLv3nlX326YbnEniEVN1Nz0pU200EO4UWxQheBGDTOxT3OXvZaTKOgEJZCykWhYuQdaTbpSf8vgYLjnEZl7IfPyvVFpFhKm3GId4wiD9EmVEPqeCF+Jbq+sT/gtjPQJHVanuV/o3aobtrOyGSR2YuQnotAWZmGFvi3Zp9LkgT9JLwoEhYm9VCiZTsdedLfl42Ms/xd1VPL/5A8+fJ7T4on6YY2u/PqRusZct1rCG6aPfyDl6iQFyT4cSqId0ZySymBaeWtjErjlekA464nVrUo5P94b8RGgue5mu2Vt2/wVWUhos+yhGfse87kciAYHH3ZMok13ezSfHBeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BSQapadVe5e6ipIW5zwV5j0YGSw0LCwt5f6BgDXfDg=;
 b=epZ7dY/aoA6eFOe7jd4VU2KuJoviblcZAMdXC/wU1HkRviITBqou+4IYl1vjWQBtaj4Ln0lDxcjrN0pkcHfCsoHdA7NU7WvJINy/vU5onV4MzQrTGKZrL4cLUEsdaMQvEOhL/1v1Agz8lBpvLQ0oKHBKMFGb3EMjBgDNBghn014yZlVqmk9rqH0jB/U3bsj6tBRjQS9dynp2vOVY69+vFe+NmKdhLGkW55sHxxYWtzAXqBCPz/oDXXyGowpSKRv5pS4/eH8/ZPqakD2TjIt4ERJE9nFTssyH4n6F+qHgLK0sK66SYakEa5EOE3d28CfkaNP6YXGk3Pn2lue0XSe/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BSQapadVe5e6ipIW5zwV5j0YGSw0LCwt5f6BgDXfDg=;
 b=PB7vt1YeaptKqLRwowM/QBZLntKv4u9FrR9NM99Lj/XWJ8BT9nMYB470F6BqtW5SlF4Z0DC8JFV+aqotdPuwR34vxo8YPq4TisfyxSkqcH1xyJH80W1YAs3JM3g7n0T8Y0n5+004FuQJzGLdEpd+T6lT7iqfYIUUc0VOLFoDyKs=
Received: from BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20)
 by BYAPR15MB2935.namprd15.prod.outlook.com (2603:10b6:a03:fd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 14 May
 2020 17:46:16 +0000
Received: from BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34]) by BYAPR15MB4119.namprd15.prod.outlook.com
 ([fe80::f9e2:f920:db85:9e34%6]) with mapi id 15.20.3000.022; Thu, 14 May 2020
 17:46:16 +0000
Date:   Thu, 14 May 2020 10:46:14 -0700
From:   Andrey Ignatov <rdna@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 5/5] selftests/bpf: Test for sk helpers in
 cgroup skb
Message-ID: <20200514174614.GC22366@rdna-mbp>
References: <cover.1589405669.git.rdna@fb.com>
 <646dff71848bd93780581cf4e0f5a70f7f386966.1589405669.git.rdna@fb.com>
 <a1360303-220c-5bde-5657-b8f5497190ad@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1360303-220c-5bde-5657-b8f5497190ad@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ClientProxiedBy: BYAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::15) To BYAPR15MB4119.namprd15.prod.outlook.com
 (2603:10b6:a02:cd::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (2620:10d:c090:400::5:2555) by BYAPR03CA0002.namprd03.prod.outlook.com (2603:10b6:a02:a8::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 17:46:15 +0000
X-Originating-IP: [2620:10d:c090:400::5:2555]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 81c52006-886e-452b-80bd-08d7f82eb361
X-MS-TrafficTypeDiagnostic: BYAPR15MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB2935A1D898E029184A03FB11A8BC0@BYAPR15MB2935.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpBcz23MjoYZWOqb2+ojcvJ21MBrnnP857osvTs3kjgp62qYFCpKLtZSp6wKxK0dajbpEONaPgY2jBt5dFEdGsSz0a9ImEyOmP5TllEYvlZH+e/orrCM1No7VcQD85+CEenWR6Br4CY4wStbT+eoBSx2Xcsek5+zk+43D77wdym3XihMqTdTI77Ae8YNPIU3QApA1ScE0eMpu2cYpi1Jv2+zsHbhYZOcw11+ku5wCZ/Vs8jr8ua1enMizjHdnFAEWpPVjWAmgKnYXZXjgnvtEJf5eQSPnd2w/+wTcYNhglM/eAvUgY0y913haLgbBo1sjpIOqrNNA8dqa3U7vbFS6d2FTJlAP15LTyyT5Bbv2zXeXbejq0RleekwizVyDFZXGQlZEyD0yjVzm2X6ChjjJGYs0ub7w7q2H3YvR67O9RocCpJixZS62MknKyAan1I/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4119.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(39860400002)(366004)(376002)(136003)(396003)(346002)(8676002)(9686003)(53546011)(186003)(52116002)(316002)(86362001)(33656002)(6486002)(5660300002)(2906002)(16526019)(6496006)(66476007)(1076003)(478600001)(6862004)(33716001)(66946007)(8936002)(66556008)(6636002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CByKK/HOaxUWZb6x9xXolungI5MtC4elxcUB3WCSVpBSwhgPxzjzzkV1FDM2nBEouIVBdYkKlxllnrdgqjNPZHBabhlqeVfiYHhKUeO2FeYLzScv9Fws3cKy5s2llSUmU5rCWL+BBWa2+CtpqLGDNKFmWo88p4spRvP0y+jp7VCNnkK6Cb5HGz8k83LehUX2hI8SREtt6WU2FGnJhddwZZ+mQnmUC6MDw+SV55KKWOW34rQxDeZS2N1sgKWgRsuVVZITbmH5h8yRQTiTUtXKegMBj4moxlknwqK02VGkZUxq72f8urah1iOz2y4nly0558DSytTg9nhURMWa5MInT7KMYEszEAksrhV92hhndU6XfxeetqYptqPxMhxx7M9GDjPrY3tPI0SNxeFR0cXMEmcYM+9OG9nD1ocr780Fwo9LC3x6u+vAVSoQqfQc1fimJzgF/kLI1rypkfama0itYnCE2oYALIBy6stCH1Od2KvXayDY/nwjrSl/zDptQXG/VhUAOoogE5QazLR4pr/mdg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c52006-886e-452b-80bd-08d7f82eb361
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 17:46:16.0068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LN8RevXk8S4WM5v1f9fCdriJzlH+TWYC8HlmRV/BHV2CGbmZqmrTCcki/8vmxQs8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2935
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_05:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 cotscore=-2147483648 mlxscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 adultscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140158
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> [Thu, 2020-05-14 09:07 -0700]:
> On 5/13/20 2:38 PM, Andrey Ignatov wrote:

> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2020 Facebook
> > +
> > +#include <test_progs.h>
> > +
> > +#include "network_helpers.h"
> > +#include "cgroup_skb_sk_lookup_kern.skel.h"
> > +
> > +static void run_lookup_test(int map_fd, int out_sk)
> > +{
> > +	int serv_sk = -1, in_sk = -1, serv_in_sk = -1, err;
> > +	__u32 serv_port_key = 0, duration = 0;
> > +	struct sockaddr_in6 addr = {};
> > +	socklen_t addr_len = sizeof(addr);
> > +
> > +	serv_sk = start_server(AF_INET6, SOCK_STREAM);
> > +	if (CHECK(serv_sk < 0, "start_server", "failed to start server\n"))
> > +		return;
> > +
> > +	err = getsockname(serv_sk, (struct sockaddr *)&addr, &addr_len);
> > +	if (CHECK(err, "getsockname", "errno %d\n", errno))
> > +		goto cleanup;
> > +
> > +	err = bpf_map_update_elem(map_fd, &serv_port_key, &addr.sin6_port, 0);
> > +	if (CHECK(err < 0, "map_update", "errno %d", errno))
> > +		goto cleanup;
> > +
> > +	/* Client outside of test cgroup should fail to connect by timeout. */
> > +	err = connect_fd_to_fd(out_sk, serv_sk);
> > +	if (CHECK(!err || errno != EINPROGRESS, "connect_fd_to_fd",
> > +		  "unexpected result err %d errno %d\n", err, errno))
> > +		goto cleanup;
> > +
> > +	err = connect_wait(out_sk);
> > +	if (CHECK(err, "connect_wait", "unexpected result %d\n", err))
> > +		goto cleanup;
> > +
> > +	/* Client inside test cgroup should connect just fine. */
> > +	in_sk = connect_to_fd(AF_INET6, SOCK_STREAM, serv_sk);
> > +	if (CHECK(in_sk < 0, "connect_to_fd", "errno %d\n", errno))
> > +		goto cleanup;
> > +
> > +	serv_in_sk = accept(serv_sk, NULL, NULL);
> > +	if (CHECK(serv_in_sk < 0, "accept", "errno %d\n", errno))
> > +		goto cleanup;
> > +
> > +cleanup:
> > +	close(serv_in_sk);
> > +	close(in_sk);
> > +	close(serv_sk);
> > +}
> > +
> > +static void run_cgroup_bpf_test(const char *cg_path, const char *bpf_file,
> 
> You are using skeleton, bpf_file parameter is not needed any more.

Oops, forgot to remove it while switching to skeleton. Will fix. Thanks.

> > +struct {
> > +	__uint(type, BPF_MAP_TYPE_ARRAY);
> > +	__uint(max_entries, 1);
> > +	__type(key, __u32);
> > +	__type(value, __u16);
> > +} serv_port SEC(".maps");
> 
> This can be simplified as a global variable, e.g.,
> 
> __u16 serv_port = 0;
> 
> and use skeleton to access this variable in user space
> and in kernel you can directly use this variable.

No strong preference here. Ok, will try global var.

-- 
Andrey Ignatov
