Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9C4071A7
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 21:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhIJTFv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 15:05:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1340 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229546AbhIJTFu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 15:05:50 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AIwDKW014010;
        Fri, 10 Sep 2021 12:04:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=gQDuR9rAh2VRsl6JDbAD3D2aFFttICBC/hXUp7UFOTw=;
 b=Jj78DDBnpsIo6gYkcpHMpVzDYBQhqMj9pswtxapPoxrPJ687Buwc7hYYinbTMuCl6QEs
 zTX8ltbreurBcYjTt6SJdBfsPXnAjPV/zbZdDDyYvjKDE/Ct/prX32F9guIJscHuAyoq
 PNQGrHC+B1hB+M6SJOgCWsr2lc5uXTuI6iA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytffxwqt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 12:04:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 12:04:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fgsz5kpiiC/qZ56zIY/24YmRn44wUixF9uFdKh7Cxs8Wls+BDH4zsZcdbtE1cJIvIo+szL6kgt2gNXii/F25eFTqIwfcKtd06CBCkUOyHyMraVjV2NMcrGnJX0WeL2WV1ZL4QCXCuOr7sdBeEzL6vVH1XzSNt7w/8+1wjxCGMcc0ocUBbfCzhjaIw7a8AKF5cx+Lxzrgl7ootH8jScHbpGkfIEaLoMWrn6QVwk4D+NIrUkO5/OPk42AFqrzuDp1bevQ7iTk+oUIjWp01xVlqK5HfW5wPqqDcNtS3R8GnnCFXSXEb+O8jEtaRkXzdQ0aOvjANLR0jK837FSkaWgxWCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gQDuR9rAh2VRsl6JDbAD3D2aFFttICBC/hXUp7UFOTw=;
 b=nuILQ7eSvdiPHgK2My/lUzOSznK8TET6AId77LmWKbMTsONuUzsxXO4zgegs8RR/M3sX8UWG6hYR31vBRqFytaOqxe4WIHqpZ8hHRfg2/+8fv61Fcj++WNMmBjjdgPjxjfITTR2XhEYCMQ6yoH7Ql+a9dIC2XYWFQsv6dGMr+tFjGF7e8IswTaGO4Tlc9s804UPfMe/zUwL6XQSsQ09rbspleBJ22QaVjKdmzXrTtrnL8IM0wd3V6+NL+jrn2Spuig+XnX2kNAojpdgJwXw4eVuG7PQ7acHBB3hlTr9beMLVYdiGGr0NJ5uJ/SVREMmyCeFX+KIWl9s38PqJQEPDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5077.namprd15.prod.outlook.com (2603:10b6:806:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 19:04:37 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 19:04:37 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH v7 bpf-next 3/3] selftests/bpf: add test for
 bpf_get_branch_snapshot
Thread-Topic: [PATCH v7 bpf-next 3/3] selftests/bpf: add test for
 bpf_get_branch_snapshot
Thread-Index: AQHXpnJ5DR84tw2uP0+VcILLi5UcKKudntGAgAABrYA=
Date:   Fri, 10 Sep 2021 19:04:36 +0000
Message-ID: <931A149F-6CBA-4D4C-8A90-134448AF878F@fb.com>
References: <20210910183352.3151445-1-songliubraving@fb.com>
 <20210910183352.3151445-4-songliubraving@fb.com>
 <20210910185835.GR4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20210910185835.GR4323@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82bda960-06d1-4eef-a358-08d9748dd574
x-ms-traffictypediagnostic: SA1PR15MB5077:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB507746006336304F4EC7ECBEB3D69@SA1PR15MB5077.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /EGGxk1sBEB7VskftQJszUc1gJKAHCks0yYAetnw5mH8109j1LpS9uHiSHwla+8JH5sRAojuFOTwechXyjR5Fnlt5vWlrouV/zNTGVjLDZ3530vQtZZwO99a/FrWLo/tRdB93JK5BS1V0VtpSIwObtJt5sz6Fx+hoaGLlQf/B/lYmi+fpB92HvrZ8ChbDcham9V6OV7wJXC6QfP3QKeJb0Ug939JJGE+HRTAWki2ZMxpKD16GPZS6oWC0uFmoRn0yxoWDBInlORJ+KL76o0hxgkXjQaOofWUY6Oh3JyGTfUDk5jGGpKYjM4fbNUEN6d9qOen6Y2ud3pC0d0upBwff1YgY8HJ4/RiL/Q09W9szG2U/eYmN+hnyJ8gG9xRAVT3kml8XicMZq2CtKDrpEBFbxSrPs/Xx9PQJOBe8yldA27013pwAhKGbO/uLX96w5ARtz7uvQGzlX26vY0WMe8/YL+PbFopCV+FGc7EB1I5REnWQdsqkXXQ8T5U5MQEeatHtXb29sgLsIytwkW9KPO4m7v8fc9tQ1UWW/S/F3m8pxlUOTAehCXa8DwV3nvfAka8lr/4fjTsvxKW+i9t3QK2URUtuYrFeA5ju2JZ0g9ZApG9YTGfgr1M5e/yEak1gjheVa2srAAfkK8wZ5hvna1qJHBuq3TYgkD8/HCwR0Ok/fvdP2GG9VIAtM1vwBMA5UMxe5qJFCDtS38RG8AXnRbRFR9YccdQnsnGKzBMf7aTR4E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(36756003)(66446008)(2616005)(316002)(122000001)(71200400001)(76116006)(38100700002)(66476007)(6486002)(33656002)(4744005)(54906003)(186003)(8676002)(2906002)(83380400001)(4326008)(38070700005)(5660300002)(6512007)(8936002)(66946007)(6916009)(66556008)(86362001)(64756008)(53546011)(6506007)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Mq4Gl//LK1tqeyDCm2mH1KyPQsM+0VjW8NLzb+SYyBy1PFse74zTVvqS4tnN?=
 =?us-ascii?Q?gI/MLtuZBrm+O5lbe0O/PCqFphuo6s5GO7f2C2bdFlr2sK1StDpooWgMY87H?=
 =?us-ascii?Q?4XMGw1dtDEV4ty5qmcZp1OjcqRNeFx3Xtc2QDrCQ/uE/fdczgr33/7dmUKDY?=
 =?us-ascii?Q?TFkFmSzXAQqCz5TeU/VQaE61ehOOFxV+I5TSs4jDQ0VsjOEdZRhDsXCCl3pj?=
 =?us-ascii?Q?enI7i/pQbd5F9uWAkhxvM9nMGeThw/PPBEf3sSH0TUVkw8rvvU9UaneXiZrU?=
 =?us-ascii?Q?0LbZ0EOoIqKfF0tIxvfh4FQZrxOaRM6arcg4CXLCQvezeLqua3Pj9S9TPqkO?=
 =?us-ascii?Q?6/y3q9G13IVMyo3Otxj27LyspufxZ1HAir5xnizku1SPG7/EQu8a5IeszejF?=
 =?us-ascii?Q?O2mGKEfgf6pAQI3kbMpEmdvr1ByHRY/uiDsq2CIvswvXv3V1uApoDwN7MHPv?=
 =?us-ascii?Q?I+hO8KYlv+21CoRFAMrwtJ3Y5kRz5m4OAQFThWnT90pvv6D4R91qS+PanAAg?=
 =?us-ascii?Q?9xNe9C7hAnVLLIi9DqioAlcv249mxnU0Gh2+lZby1LJeEd+rizyqgHvb5WJ7?=
 =?us-ascii?Q?aFxpOkjlb86gvfslFDS3CwaZVzOnv2Nyrp1ThY9Au27kMy6Q4bMhjlPzx6Kj?=
 =?us-ascii?Q?I7Un10XC7j2HznaU7+TsAmn1wFhhEWs1xcSFiu8YRNKITsDAiALK7j5lZvM9?=
 =?us-ascii?Q?8ZBMKX6ZK3RD63ZNoOKZFTx5FvRQNnkFYZy4Ifrt1+tJpeVnqcf/zW2hxQtc?=
 =?us-ascii?Q?AXvC1wyDFfWQqE2LPqnzaiJl9NAc929GYiQZQ0AcjaSkN9w+vs8vxF9+rNBm?=
 =?us-ascii?Q?7oOR1oyZqiN5O76AXWOns/U++jjSnFTdGhJCLQPOgE8vdIoeF8uX++CmPJi+?=
 =?us-ascii?Q?TBOy4FlB14N3dnY20wzr8S/+M5lckdkir0gNzxAAVDFsL2vBefj6jUCClDED?=
 =?us-ascii?Q?s3zx5kDqFSZWtanLukVZ0OqriUOlEuskdJYKkQva3tyJbqp3ckERCy9zF2QG?=
 =?us-ascii?Q?V8Z5jEQ/TMpz/E/+J8CVJZlg5HIbyLAeBFOItAXb6StVH/ofYYWLzE91zOsm?=
 =?us-ascii?Q?PW0C6Z/L/PPJlEuqtvfRHw2+2BMP/+1P3NxC4NA9JUmKOmje/VyropbYnPo2?=
 =?us-ascii?Q?q4Om6kriigINMF9/00MWbJRxtpD7iIagR7gjCT4+uyfs0D41pFgdVuyORYr0?=
 =?us-ascii?Q?Uu6nEwm5w3NjVHBkazgbGCr3u/EnKR4n/cyjz7usxPwxHyP5Ge2nPxwFr/4w?=
 =?us-ascii?Q?HqOPOSQPZhYLr4sRBxUnfDnSz6Z0mSuksr8u+kS6i9jyU6yKXdc3TAiPQ+Pg?=
 =?us-ascii?Q?t7se5ZRiysw+imUWYaIfBh84squ0ZlFjr94/bPyTaztWJommWktn3dlBlKRu?=
 =?us-ascii?Q?VBoQX/s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <707AE55B13E5E744916A99029F553787@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82bda960-06d1-4eef-a358-08d9748dd574
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 19:04:36.8559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NlFZs7toqpMMv7jGFbrKLZ4leovHe3rBDQ/uxWOXzHKY2lkjCNtsVza/fvNZHA1H/e7gTaBsm0mqoJg7RGzgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5077
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CzYDznqDm4VtYT24MbFR8mzVck4FRnIr
X-Proofpoint-ORIG-GUID: CzYDznqDm4VtYT24MbFR8mzVck4FRnIr
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 spamscore=0
 mlxlogscore=978 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100110
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 10, 2021, at 11:58 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, Sep 10, 2021 at 11:33:52AM -0700, Song Liu wrote:
>> +	/* Given we stop LBR in software, we will waste a few entries.
>> +	 * But we should try to waste as few as possible entries. We are at
>> +	 * about 7 on x86_64 systems.
>> +	 * Add a check for < 10 so that we get heads-up when something
>> +	 * changes and wastes too many entries.
>> +	 */
>> +	ASSERT_LT(skel->bss->wasted_entries, 10, "check_wasted_entries");
> 
> It might be worth pointing out that you can easily bust this limit by
> enabling all the various tracepoints that are still in that code, but
> that that isn't a hard error since that's not the expected use case.
> 
> For example there's the wrmsr tracepoint that will inject 6 or so
> branches on top of that you now have. And I also think there's a
> tracepoint in local_irq_save() that can trigger.

Right. I did some test with a lot of debug config enabled. We do see a lot
more wasted entries there. 

Thanks,
Song
