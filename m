Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE772025EA
	for <lists+bpf@lfdr.de>; Sat, 20 Jun 2020 20:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgFTSMC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Jun 2020 14:12:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:64272 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728204AbgFTSMB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 20 Jun 2020 14:12:01 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05KIAL9r004951;
        Sat, 20 Jun 2020 11:12:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Z81ihaiOitRbjF0rr6GBiXzmwV5kHgjLdz3mLjTSTlg=;
 b=aFXPyw1agCP/gc9XyzLIZaPcS1i/UW574I/xjscHRHweX8BmTuVhTw+Yshsd6tJ4z0Vh
 YuJ2HRk3I4Lx1vyEASa5wcDYSRy07gBR3JwFZlcRzJJOeQovH6pbE5h/niSbyDpm6GCx
 zCTuNfLhrfCM5hOm9AjNJEP0U2xEnFzmA+E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31sg5b95sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 20 Jun 2020 11:12:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 20 Jun 2020 11:11:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGNMT5gHDUzmq+WCH9SbhW05UL5pMNTvYnpnFe1uSFOrN+5EunlZWA4A9cZPZmLiD9V/yn5n0XNCWvr6SB6YmdAFb0NvZm2Q9tfsDZ7KftzySPCKrSLIG5/BxGTD4j98NdB+GzviV0HP1xaSMJktbeMa8iSh7MiiyG+NU1avTAdqxVIRZvyuPGYqP8k5f6PUlywCWOIV1/xy2chdfunICpDdXG5ZYTh/lld5DLXNMQmSO7hJkm6FlrPkrhm9WYVi77OtqBUqi9iDwGTDDyHxH86pNLeeuUzSS+ZE4PpIAtapfFlYZFiGcZaASx3JRAhxpqjCaYBSgMNOe3/MCiEaQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z81ihaiOitRbjF0rr6GBiXzmwV5kHgjLdz3mLjTSTlg=;
 b=jlVk/HTEv74rk3EF0dFOTvjH1RG/vqeWMJw3/3o6oJmbcaFgal+8NUNU+30jrxOT8UJVVi5ZoTLP1AWb0zBeU5hnay+nsoxtBAqJDrKGC6915zS9cf454X8ToD0LUWBQDECR2hd3Sob1wDFs1Y7LTfwpzTlEWfT/ygq9RUAu5lpzc5I439+g+lvT3h5xKg9GtwW6YVHRGy1xfyV1y5Tv5H1qZFC3/OKKmmTbEpiMlvNQVQK/n1d3gVWRdqM539jEvkfd9UbeVpp8rrGxhVaarw2SsWewIDWBpKUsk/XQTE5yWwPrtpXldMVYIj8czOY4lqvdUSL90E6zWSe6q3A9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z81ihaiOitRbjF0rr6GBiXzmwV5kHgjLdz3mLjTSTlg=;
 b=e+YvXiRDAXvyyt/iOxWrCEh4Ybr2v/o7F46CHyrudbIb3ACDobzlyhfx9kJ0Zyis5xLDfRDsiFC76ngRyAdksH+PgrFVD76ZUy7WiYINTvTVnSmTQub3TjJzXl1Tv/tRmMcQq91rqwocak6XgItuQWyrf1PwJl5zaK1yPyUUwOs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3512.namprd15.prod.outlook.com (2603:10b6:a03:10a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Sat, 20 Jun
 2020 18:11:58 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.021; Sat, 20 Jun 2020
 18:11:58 +0000
Subject: Re: Accessing mm_rss_stat fields with btf/BPF_CORE_READ_INTO
To:     Matt Pallissard <matt@pallissard.net>, <bpf@vger.kernel.org>
References: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4889d766-578e-1e20-119f-9f97621e766f@fb.com>
Date:   Sat, 20 Jun 2020 11:11:55 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200620162216.2ioyj6uzlpc45jzx@matt-gen-desktop-p01.matt.pallissard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::1063] (2620:10d:c090:400::5:3ea0) by BY3PR10CA0030.namprd10.prod.outlook.com (2603:10b6:a03:255::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Sat, 20 Jun 2020 18:11:57 +0000
X-Originating-IP: [2620:10d:c090:400::5:3ea0]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cf79a7a-2db4-40b2-742f-08d815456bd4
X-MS-TrafficTypeDiagnostic: BYAPR15MB3512:
X-Microsoft-Antispam-PRVS: <BYAPR15MB351281F22CA29D2AA4652088D3990@BYAPR15MB3512.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 0440AC9990
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8bIKCas107ZeWF1bWkDVgGSbP5lObR8ZL7zrcRcX4xeN7c1TSSB2elhfUszfzynraGHgoM6iMjPRqXuKSrLu32PbR4uG2aexJOnXnA3HbjLah7QtpuIX4kQyUsKFPV7rztJccADiwt/bty7sojsXTucRsJpQ5jeOa066euX9M30nWEX04TNHa9k68avREgVL7AbPxOJ3Z0o9XfGiTpsARocrUNaiaph0rQd6ZcANzjh7g6Zvu9WPlgJt643rSQR1R9P5ZNDVq5+Qt/yFewR08/KlwfXvSyhuCmMeAUZgfj+6jBvxAj66LNta5WXboFJ7rqKPZ1i+cECJDAxjBW2Q4DKSQ4bFpFyE/GCiXzo0/6CLOvES+cRQ/GIy8ETrPjp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(52116002)(8936002)(53546011)(478600001)(316002)(6486002)(66946007)(2906002)(66556008)(66476007)(36756003)(5660300002)(86362001)(186003)(8676002)(16526019)(31686004)(2616005)(4744005)(31696002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: zyL2KNxwoHI7P5mXn7FX29Q31rvG+FOxEbYf9plWislOUVfNCGsuz+LdK96vIWcKtXDggyjw1Dw8TqaB7Es3462rg2XIhgaGvmf+tWSGL5I4AaiGBnreshkevg2Ztpl4QOPqUbrKyLLVXgNKoCGb2Q4bKshUiMstSmLgZiHe59NvUNVvKUmGDsxKjoT+ZkkKzmNj7ig4rRg1k3EiFcwAyUJxrrlTiOcyEVlmCct2ThPoWrZN46AQIqQYoa4tA2wMrjeUIyjIfCRqQD54agYoU+W0kRyOIRAbMyesBbLGPygE2OOD5D1GmaiBSys3gZu4WIQ43P3Un0pLu17PUHC73HHdov+mR1E7wIfqxPVW+FLAplciIJUZC/RpEG5CISculL483z2B+Tf5bhOkrw/AXDaPzV6JuaF/e67IOhC7UYCjMH1Ya1aq1e2NzlB7w6BvnaeZNq9YumZhkMIuK9qQTPFJpQbysyakhcU6/YirtnUZJp0kEsCY4v7ZAjsoLtATkwUHkBomgNgrPN345K+iIA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf79a7a-2db4-40b2-742f-08d815456bd4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2020 18:11:58.4524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avu8X70gOYZJ0oaY0Y8QmFlUc6oNvFDbzeLagWwqJSI88U0PQalCFwqwA18IAz2k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3512
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-20_09:2020-06-19,2020-06-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 cotscore=-2147483648 suspectscore=0 spamscore=0
 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 impostorscore=0
 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006200135
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/20/20 9:22 AM, Matt Pallissard wrote:
> New to bpf here.
> 
> I'm trying to read values out of of mm_struct.  I have code like this;
> 
> unsigned long i[10] = {};
> struct task_struct *t;
> struct mm_rss_stat *rss;
> 
> t = (struct task_struct *)bpf_get_current_task();
> BPF_CORE_READ_INTO(&rss, t, mm, rss_stat);
> BPF_CORE_READ_INTO(i, rss, count);
> 
> However, all values in `i` appear to be 0 (i[MM_FILEPAGES], etc), as if no data gets copied.  I'm about 100% confident that this is caused by a glaring oversight on my part.

Maybe you want to check the return value of BPF_CORE_READ_INTO.
Underlying it is using bpf_probe_read and bpf_probe_read may fail e.g., 
due to major fault.

> 
> Any advice or documentation I could sift through would be greatly appreciated.  Thanks.
> 
> 
> Matt Pallissard
> 
