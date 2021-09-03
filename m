Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7448F4003A3
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350010AbhICQqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 12:46:36 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26904 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350111AbhICQqf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Sep 2021 12:46:35 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183GdiH8010459;
        Fri, 3 Sep 2021 09:45:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=8vo/a21njoz9c9yLnFJOK6k2Qs+Y4goaLATHf6eUwx8=;
 b=pSPkCD53BOclAIuOZrC0kk+ZJiVAi+n6gKX4ARCDffOIIQ/0imG4rP7+UX8aIiS4uZWs
 1RkfnDyqkPsLWc9QA71ChMjpaD4JJ9cEP3tCslkRgxzHZQH4q138fnjwDgjSPFcWx5J9
 iF62h+weu+qzLUmX3cIaP5RMtk1nBgD2BAM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aubk05q6c-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Sep 2021 09:45:34 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 3 Sep 2021 09:45:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROx03tPEFF/Op/eYkkba7+xKkM6kg/qjAKnykmU4bq4izbMPbal8GbsWA1H0Oic/sXST3JTL7rNw2/LkPjvoLaN3zuW8EGzvj/sqiDfyns6bOZZ8QOVjDK+xJe0HaZh6J/hsNh2oqiuOhiPNTOsZJl6ftMtX3BJMWtCBZ6ILMdNvykvdZGajsD2cfiSjZlSNSIhAvF729B+jqIzpUQigXVACq+kZ8epXzAY+qu5NX2U7qVurEydQk30oaAt0HOcFCwXNqeAdP4fBAbHH7xEIkHEXCLW15ER5uXEWxpnTHyZqOiNNAU5xYRE0uCMfNnxlwdgIYWjjEM/Y8hoaG4FCuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8vo/a21njoz9c9yLnFJOK6k2Qs+Y4goaLATHf6eUwx8=;
 b=YjA2nNMv8sB0ZsYPnD9r3XgxRKmz8f1u/tTNN/ZU9HoBS8Z86qCXfsfS7iF7yDUvnQHj1dyPJY9vTOcnXKLtFKQ8HQ0dCcBsssQoLLr3uIYaj1OMOfe0y3xNK850EhCk/3WUPcmkYC8IMovR/lWKFyc7a67S5ATbsNl2KQoFDQ9zFga7yu8ey8fKY9FoZEK+Rz+WACBF41Ck7KcNampbRUlLMSSMI9xk2rW5iQIoNah0vWboYdCuszp13ap1fZ0zuLHs+sFuwjdm6rG1gOrn3fcfQrH4RVHpj6Pys4cYU3zabwKVnC96YwiFY2gDbppHKfDtkg8rI3uxl3V6Ds/aAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Fri, 3 Sep
 2021 16:45:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 16:45:29 +0000
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
Thread-Index: AQHXoBueIwYxVW5RBEGe48w8ZsQtdKuR+sAAgACLPAA=
Date:   Fri, 3 Sep 2021 16:45:29 +0000
Message-ID: <6BA620C1-D311-4992-8119-68A740ABA8BC@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-2-songliubraving@fb.com>
 <YTHcXDhYDFsw9GQX@hirez.programming.kicks-ass.net>
In-Reply-To: <YTHcXDhYDFsw9GQX@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afad72a1-dd7f-4cf1-0af3-08d96efa3d1c
x-ms-traffictypediagnostic: SA1PR15MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB50783A34CAB9F07879A72E50B3CF9@SA1PR15MB5078.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O/7gWlTDvjawOG3KFPp7Oui9QTTLQ4BuNGIl18nHGtHag7yj8p9nOMahg2ZOtQ40c9LyotcTf1OQleWtPyfl+Yfsn1CNAxApkegmcO0IclqFLGTzcco9r3Fz8z7hGd4uUWGSWLFnRyMwDoTrlAhpWKKC771VkwuEwrjokMpohTNbX91J3DsQFWY3hdwfaDHgcg1QCVPJ5ZVG/zyBiWhaLOmQTpkeEJDltwzpWVwvcszrDUgGhaGaR0x2sYc82NT8cY5EwJ/zGBA2lA6XXebjrUrShrnGIIPkig/GNSBzHCxsO1eKHshpVEkh+CPltUvu0wJGnZU6D5pi3E/kMi6HgD/xTnd+z12YpZxe6HpSfpG9gXCFb4foEH3ROE7Vv8uXxmoYd5KtK2PTSRJsehBjxBxh1kJQ4UcMc4363r6vqhgb1JW8HzV1tZPj0ZOMLAAO/12JsxyUTNaWnTIuGtrY8555CIGYJMTuXVcZAgHDqQrbaIA2woYNjTwQ42V6rS+mGVwcq8AWOUHhmyQa9SNlIc4OQd1cMvg4g/yMzvKOmbWYHchLY4SIm6zafNNs0Pd6f18sOMb19nDmU7tB0pMxcYleao63Uf6uGHvAk8bNd5olqxDlh4XPrJmC5VhntljhLmjVDXOOWjt9wgLhMhNowU5y7OYqBKOxFLUCE2hcl9WWaVe1aGm44qnuMTytNb1sTydQuxsCf3aIJiJxnDIXEgdIs+3MXZfBRrI91VeVDnOQPlPrK+wTi3vqz7Kti82O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(6916009)(66476007)(5660300002)(38100700002)(6506007)(122000001)(38070700005)(316002)(508600001)(91956017)(76116006)(66946007)(66556008)(66446008)(64756008)(86362001)(2906002)(2616005)(33656002)(4326008)(8676002)(36756003)(6512007)(8936002)(186003)(71200400001)(6486002)(53546011)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?90Hxpv+ksfNi/xXSLop+v2HYaVYy7PeWVWw8MRTLojLz9TFWRKhz0pUVwY6v?=
 =?us-ascii?Q?OcUcKIC445r6JtUUNU1g8HD/g74VieleSTyUlV+KO8oaP0XTQqu4b4jQU8h7?=
 =?us-ascii?Q?TUPr8OuRO5tPuv5l2PpUzcXqii6FJsGQCU3f33EaLVAwS1CFbHCDYmsvUew5?=
 =?us-ascii?Q?cVzx2RxlPSTEiuwKbF18eeZawn3pMh4SqU+/2rcWTjerjLvmtVz/e3DQNfqi?=
 =?us-ascii?Q?0x0JC2bI5mPBFbhxLUdgzflY9mJHGouF8tu3y0jP6TS4J1TCDl3HuCkyJ7fF?=
 =?us-ascii?Q?A/+Sce5/DFKVXJ8pVk7wuQ4Ypo7DS4gNd5hPxY2p+4q3Ml+DPlI/x4R4WOur?=
 =?us-ascii?Q?ujGU5ryPBD7DLVcXOmtJOyUbyemXzeH4jdRLzd9pMFKtiVvalEUjIFal3E1R?=
 =?us-ascii?Q?x3/vBLlhA0OEH6C6ihxI5DtDMhIlXnZOiHwGGxEeIk3QbfCKuMaQtMfpjrPB?=
 =?us-ascii?Q?e1Ms/snTBUx+U/AlA78rviBH0HWL24GbIa1O0Sqseu5WYs/p6XlE/rbgQNSp?=
 =?us-ascii?Q?s/SoS61H6Qyx1dAsnv5MXMLqNc+7dNnk9dnaCvZXq1J6+hnX6laOnJWp1/kL?=
 =?us-ascii?Q?mikytfufDwvhoFZ28A9dxCqum69WRbS6+u0T84CAKggm3Tp7KtHzns5U0RUw?=
 =?us-ascii?Q?yscuqYK9Ag3tYc3mUNnZ4nFeHtwofhiG0+n5DxVxhuDX4879P4oCpzfoizzQ?=
 =?us-ascii?Q?lvrxjyfRtQGgGHam5uAuxgVtPQCUov7l57UDwOSHE6orKXcAWckq9MdxDkkC?=
 =?us-ascii?Q?n6XBuDtoZMXjtLv5QW6SMAxrF6VRUF69hYqwiqcHFSEKFzG5amQqNol4IKQn?=
 =?us-ascii?Q?1SaBoS9++zIGtm6xDcr9cYrMyIP5FPvAFe6C7rvPFPEKVlvXtHsZjSgFpnb7?=
 =?us-ascii?Q?x/a35DQfZlqOvMaJ393UnbDIUZ5kAd0XwxAd81Y7ALGfaJGjaHdeI9hsjMXv?=
 =?us-ascii?Q?rh80BmEsElDGNC/rCCJF2C8TpSB0130RFjmDZbH+nB83brG3SMdzXNOx2seZ?=
 =?us-ascii?Q?9vORMDnrGsMdyWwewpXZlJgtfFagyXnFYVcef4H14JgPHn1UHbBaaThVBEHO?=
 =?us-ascii?Q?1oE7FupH48Zx2QWzfQ2LSKykqQCB2djTZxqdutX8ta+YzhSpcRYO1l/5N5/d?=
 =?us-ascii?Q?iWTFN6epMiBXsO07wpX87w7adX/pzybIPwIzPUTlKVTB5bKpSl7QwD2qQEdu?=
 =?us-ascii?Q?52/dGLdNIrAg75sJaUT2DFx5FwHH+QYTkjsLokrXwJeyMxnnlgHe5RIqpaLq?=
 =?us-ascii?Q?aLLESiRsVk85uF016QH3FacYFg8G9RnTIi5OXWfk9l2NJiRipmFfJeDGIFEJ?=
 =?us-ascii?Q?xyoz4uYdAU0jccR+UN3qn3Eda5VOurC74D1jeGAUeenC6SFowFO74/LdirvD?=
 =?us-ascii?Q?k0uzZE4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D7055E0B69DFF42A74004867F3E6857@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afad72a1-dd7f-4cf1-0af3-08d96efa3d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 16:45:29.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HEIMEUvNatKR61aSHendB9AySfpQEOvhSRiRcpLab1odBHYq803hm1Tj+rMpiuDQs7yGHQvAATt3UzVblm3HzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5078
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: tKUMguly3w6hAiwsVkqDJt5T8jbduTJb
X-Proofpoint-GUID: tKUMguly3w6hAiwsVkqDJt5T8jbduTJb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,

> On Sep 3, 2021, at 1:27 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Sep 02, 2021 at 09:57:04AM -0700, Song Liu wrote:
> 
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
> Given this disables the PMI from 'random' contexts, should we not add
> IRQ disabling around this to avoid really bad behaviour?

Do you mean we should add (instead of not add) IRQ disable?

Thanks,
Song
