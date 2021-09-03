Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA4F4003AC
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235438AbhICQvh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 12:51:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45964 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230187AbhICQvg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Sep 2021 12:51:36 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183GnxQs010732;
        Fri, 3 Sep 2021 09:50:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=KixfEx/zH3XbQoQ8GdRJxRRwvYPCGtZ2Nw6VyeJTkOk=;
 b=WkMMSYHcYllbz3toofdWb4ykDYQzWqPJzycddJ87cdVBXTvA7JwHH9uJp2i+7g/HJsBO
 zmHhtJbTMXhrnHGgDhY8+E3KppRFHFATsJXFYlTGeQ7x7RciilwynXqnga2RkF6N+TlA
 dI/GOL4SihL5fxbcqxjWCQZYQWvil1GbEkU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aukrhhj4k-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Sep 2021 09:50:36 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 3 Sep 2021 09:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2YF0eQYKRHWgzKjscAPPlXBQ+pZn2LEWEFAKaeHVsc7pRSCwTJWBbf/xJqZv97XCey//FiTdtlXCmiNWt8SkBgtE2jz6cjV+P+6AznN7tuYc5iAoUpWxiMoKaAH2NPJ81ZRhu/AWkWgN7ARrrNGmyiU9pX0QUuW09AhgMSDr8J8dvjUaSoWe6tJXxbMOBjm6H1jc+mS8nmsB8MHXgQNKV0aEQslM1kuIbuaQG4oEF/338xxx3a6CSUbAjdU1hVIF+F9Y420gmHDqLUzlxidM38E0NrnTkOEgke5SI0QDKlfBNfBjtF6RNhkFB94l5MP/9Hc80U/97cuAiKEyPeatg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KixfEx/zH3XbQoQ8GdRJxRRwvYPCGtZ2Nw6VyeJTkOk=;
 b=IxHm/x9EgwLFfihV9PJTNVyyvp3/4thfbfiFelyw1FUDlZYCqbLdA+IdWJdBT9bpHLTEn1+mvmea0IyKv5JV6ulblgTpx8frOy2H8tLjrZlWeMZjQbSE1LwKq6/Pi1oJi/lcRepo8dF7XE59WXHrwvfNrhTI1+DNbHJSTw2FTjLWmAFLt8EKuz4+q1Y1JYp35ts68SWYwUuMbn+P7AvYlQtVP/56F5JySIpyR3o5UMbDesZhTBUac9IJMFnrblN0+haZh4eNN20xDggqVuEXg3TwsYO+3MErPqd9xXpQ3ionWxiYc26A4bKbZXnj4DGEKNxh0hb4FYnHcIEIo3miyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5077.namprd15.prod.outlook.com (2603:10b6:806:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 16:50:34 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 16:50:34 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v5 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXoBueIwYxVW5RBEGe48w8ZsQtdKuR8+oAgACTfYA=
Date:   Fri, 3 Sep 2021 16:50:34 +0000
Message-ID: <D501C4AD-3778-431B-A710-3399BFE6EE56@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com>
 <YTHWoCcSgvfx24/N@hirez.programming.kicks-ass.net>
In-Reply-To: <YTHWoCcSgvfx24/N@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4132171a-beae-4c84-09dd-08d96efaf2c0
x-ms-traffictypediagnostic: SA1PR15MB5077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50771808A51EAE72648531FFB3CF9@SA1PR15MB5077.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sD3tTHkGlf7Q7gitEbQE8q5QExqnxspkwk3ylimYEVGZEppRLH+jsmaAAwsroeYhJdp72OW4OnqmsDcD9JpIqvMXJwd9Rp05iysKPJB6HWDGPSJHRkn68LvnSutn3oHsz/rNvAnBGxRNg+2UYCHyaDh28HkNjwKtaHWYge6PMJeIFzdPs/QVJV/fKwZkcH8KZ3F8DB/laW2ZwO4EBO5A6+tPhsadrGQyJFNfUSqr0UfGs7w0CYZzAuEgukVupSC0T9oZTyO6yacWkwHU4k4OIIK0o65KdMBweXW/BKPEmigRp1wZpTjH7FmMoz4bQ/ym369y6D9s8q8rNrzOOzAI4P2sVJO6wQHFV03QN1+Wu0KErDALtql0+7cdACUE/T4pRibaP4xw+YPwWcTCziTKbHJwkyDo9nWf1Zk3LeNU5v4g+VDGfV2s6+hXmi42kv6mDwaQ8ZXWQSEjImRVd7LlLxmHCE/6pwsBsAHCq6ax2QcQ09WLg8SlZEM0uG6TPI+X5M+0R5TZsGu5L/lE2IFddL7qZ8KrIQmksHa/oKcPJEzxbG0KEUdyJolWQeQ5zGWgXI4gJOh3KTQlx4kBM6HSn8zJDqel25JXEx8M2TsOpsuOIOVbQQfN6B1Dc5U6QUTYZ+eXiR+aasmskUic5ECrk5M52lLKcpNHyY3sLNnRwUsD3nGB5EwesmOKUT7K1M+PVActqbESTtE8e526YnR5oJIJ95BdYs3B5gJBK6AQiQyyzgIo9oLbE3wlYsYrLY34
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(508600001)(4744005)(4326008)(36756003)(2616005)(76116006)(6916009)(91956017)(66946007)(66556008)(64756008)(66446008)(66476007)(6486002)(6512007)(71200400001)(2906002)(86362001)(8936002)(6506007)(8676002)(186003)(38100700002)(33656002)(122000001)(316002)(5660300002)(53546011)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XqTl9SsQGnp+7oDwFIskR4+GsmwsCMsslIwoUQB1fiAe9kmYfSADYGIrJoZp?=
 =?us-ascii?Q?0Nj9KXo6cW0pQicACz05R6rYtmqwSrbSdVGjX3Emy/J8lZ/6s++UOzYjfwOA?=
 =?us-ascii?Q?ypZn1qoUFn0Ix+u/11R79K1oQ5ZtUBZiL74P1TZpCa5h//iv0P0eInVfGo2w?=
 =?us-ascii?Q?gKKpJ+0SWh27wZ1/suFktA6PE6GQK7I4LqDFsbBiqLgPDf+h4kupzn4g6azD?=
 =?us-ascii?Q?DV/lceZVJ9w0ZJRYx7lpvyRJlMej0HFQMLnGCVXHLzsqMEXPuzN28/KAvaM+?=
 =?us-ascii?Q?1EgNvYCQ6UOd976vSpsP28F5cQ5mPLZm2eclu46lP2fI9FM+4nH+yGSAD/+d?=
 =?us-ascii?Q?CQbsNcsYWWEpoX+DKoYVMozkZAfhJO7/o1cL8/bv6dvrr1V2sc8F41tv+DTe?=
 =?us-ascii?Q?9S7qhsEVhZWx/nkcHh+C82VU92WEgj84QkA5Qn2640q0I534v+fHcwVkVMuL?=
 =?us-ascii?Q?n+P0lWDqTm+xHLulqu1YMTH90qzj68FW+Tp7638YIZ1s2tm5WLYR+OUyb7es?=
 =?us-ascii?Q?oUckYzozV+rwzLriX4Oj+FL/v8crFhzhcXI8+AXMSE8VzQnFQZ82kHmsN7D6?=
 =?us-ascii?Q?x3LTNOHnvZ2ilGv0M32lHK72K8GsnlViYv6UIxgcmBbys9sw/71ArR9jJ3QZ?=
 =?us-ascii?Q?IcQXJ2vAqoiOKfgTO9nlefgyXmFH5S8s4qlRh6d+KyEX3oG+9mGop1QrV2v2?=
 =?us-ascii?Q?r2q/YeUKvE+hpSsx16uitLeJZghupnjys4v9N6TPtNqVFKcd5eqYsOn1u8Fp?=
 =?us-ascii?Q?ifRlDjvy4U6qmU+fOixlBQwN+fAclnbudjDdwORsft1SoGc8HkUfaxPHNFou?=
 =?us-ascii?Q?XgmYIN/A0A3UKztmzgMZqfQs85+8u3W5rIOCKqxEtmV8MU6n2KpNYBZCuDTY?=
 =?us-ascii?Q?6J0UMDd/CdOUn45lkvOWxcgw8qrlwXU06XUsB/SaYvtfEDr2UXNJLQ65ojVr?=
 =?us-ascii?Q?/yywGf7nKAQHOrn4VjLaIncUEopLTv8ej+HJheTYtw1Z+qyTzOmcoJ8C0dtS?=
 =?us-ascii?Q?z/Os0G7hWjZHvk6jMcVnxLwjD5letyX1MkAQ4phkBhn74DIXrYYekoUL12K8?=
 =?us-ascii?Q?KC5yUwKBzuBfaSqH6+siUmurSkIafh09Rq6HRdBe/+dkCFQQ687UXfOYtvt8?=
 =?us-ascii?Q?KQxdVGR0MusCR1tuoA4k9BL6QSRTwpG5dVT4ZL9ujkq9Z32hRYCSGPNnX+i9?=
 =?us-ascii?Q?PdDIOm6ypUtvUl2LIlv4ACeYTwbmDlxtazDiRYyrDOB6XB6FiuM3JsFlZefh?=
 =?us-ascii?Q?L8/jVMIzvlljWPeAaHtH6OpsZ6Ya8WS/twnv+nikhgu85iKCEIyxLsYgQBpK?=
 =?us-ascii?Q?0kEGWudaYxttrtc3s3nY11E2L7QKBjy+1y1lob9Af206wk6xZegqdkJalfby?=
 =?us-ascii?Q?/L53Rb4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <463E6A64A25C0E4DB52391F68DB2D734@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4132171a-beae-4c84-09dd-08d96efaf2c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 16:50:34.2091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGuvch/4fteNKyoGRR/ZFqP6xMcojZZtUSq6KVhNbRZoWMo10/E/Qc1i8Tq0IjgQKes/6ekcjIrtEDRKZRgZFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5077
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: bT1Ues_uiC-ulVB9i2Hwp3d7lQPGRg1k
X-Proofpoint-ORIG-GUID: bT1Ues_uiC-ulVB9i2Hwp3d7lQPGRg1k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030099
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 3, 2021, at 1:02 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Sep 02, 2021 at 09:57:04AM -0700, Song Liu wrote:
>> +static int
>> +intel_pmu_snapshot_branch_stack(struct perf_branch_entry *entries, unsigned int cnt)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +
>> +	intel_pmu_disable_all();
>> +	intel_pmu_lbr_read();
>> +	cnt = min_t(unsigned int, cnt, x86_pmu.lbr_nr);
>> +
>> +	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>> +	intel_pmu_enable_all(0);
>> +	return cnt;
>> +}
> 
> Would something like the below help get rid of that memcpy() ?
> 
> (compile tested only)

We can get rid of the memcpy. But we will need an extra "size" or "num_entries" 
parameter for intel_pmu_lbr_read. I can add this change in the next version. 

Thanks,
Song

