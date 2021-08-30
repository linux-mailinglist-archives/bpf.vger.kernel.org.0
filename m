Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B93FB8F3
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 17:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhH3P0n (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 11:26:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:65350 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232682AbhH3P0m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 11:26:42 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17UFFw6s003975;
        Mon, 30 Aug 2021 08:25:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=nFYlBPY6yaYwyLPt+OcA6GpAXX8Y4UzNQjWG5LIRCKo=;
 b=jQR3zYSX06pdPuCa05YVGZGCOEvTqbyTGC8Wk7/VvY0ISPTXZgpl67D+4KvnJCc+UiMY
 aS2RbfDr1tZI3QKEnXAbY7KIVYjekroD205sS4qrxvQ0/S9jCZBgO10lTu1BRWCVTpNW
 qjZtEQiozJG8hy5nJHd6FfZ7rvygmfmRjE0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aryp90wjk-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 08:25:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 08:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxmXSjdHb81fJIa0vSjEjrIlcA9BUQORFNdULj1jIMtepzV5cm+vnwgYbENQ6vDS/cIyqG6v+ik6t3b8vEIe9B7OnbCoRhjIYTjvfWtuQ64JvSkou4eRIX8CwTDowAqeYOt9y9QOXg/rPNpbUPC39zbpb3YI4LOKePrfnFfR0ANW/Q/VURlh49MKBPP/WdaGHUA+HP4a3QgopzUQv2vgkW9fSEy9r9whQ+/HR8PlBouw7ddsabroeBJqffuq9UYmoVbDm14FlWMKxFBuSLvukG6H2kuUDbtAYZR88/SHo4BxRz+AJ9qfzw4CWRc2Hj5+bazNqODcLcRT0o09pW4fRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFYlBPY6yaYwyLPt+OcA6GpAXX8Y4UzNQjWG5LIRCKo=;
 b=nv02EOk6TfLQxPAJr+6zaOIEGmdZtgpitPePSWE4YTi6EM7c8ePfd1p+RtlQyBWJJ5ejOhnotw5RCZ1gmG9glk4jZ3u/dJJu5dOXOJ15m31kcGUdUH08Z+4AEceQ6IEoIxPDhDTG+tIatLLrsPGlmJShMH/WDUSz6Y8WG3mOTNr/XCWJMoj3bL6EiR3hGqL2gZiXmMfWSZQbSnkLXBuyByuK+b9z7ubxEhKh0pGqUzNppvmpGo1lerYT0oYIECzkY0WRhYvriINRO4GTXhufeh7a2xVPYBVYMCPbOO578WvWip0TqcWndYlu0BKpFfAwTt8y7MPaldmx+EDb2+VeHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5062.namprd15.prod.outlook.com (2603:10b6:806:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 15:25:44 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 15:25:44 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kajoljain <kjain@linux.ibm.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXmsebo1O8tvcQbk6YyjOXJsK0SquL3HIAgABUloA=
Date:   Mon, 30 Aug 2021 15:25:44 +0000
Message-ID: <F70BD5BE-C698-4C53-9ECD-A4805CB2D659@fb.com>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
In-Reply-To: <20210830102258.GI4353@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 749961a7-c752-4409-f2b9-08d96bca6f3c
x-ms-traffictypediagnostic: SA1PR15MB5062:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5062B68D888960320FBF46F9B3CB9@SA1PR15MB5062.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:901;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dYJovJhInzAOAekiulJDQQLwa0Fvk2Y1rSYLPyFUNhnrzqQASDhPbFnBfu0+O1KEpRHDcpLVUDRgrDPUmAmhszKgJl9m6IynYMK1lUyfOPkPAuOVK0k0iIexPl5/dHxB3CUYDQO/5mafVzktVLbPoqtVE63AtuE/8h+ueeOqwYcQQQk7VLiV0Zr1rcV/beDSI26f3fKMXxuVGAG3bAAPS4wIHOwk9Q7LfvEAw5TtN9Tk5bzBsqgPhH/b6R+tufvBwLktJNatfaFoqas0sSitdp+PD9qzyil3jhG9tVs9g06vVObqb9vEXkmy1v5GD8gSRf7i+mzDG/AcsNnRaYwxaLfRpmIBHA76+FtVO3VqR2ZpySI46ruweMeyUap/qVYpcmbfIsqDwP6RlOt5YDCFed+1lR7qtTj2OJElVknSpFe+QC92TnycJ/3RtU7+JQ9aUr0sx/TJ2OAI6nKIPMziTKCxWxXBo2CGbu6g6KJvSxmiccAw6Z/vAhpo2NJ8BF204N8jijjS0e6+1jhLhFvnTSp4JzoGzTwu7WVvHFrAf1+nePqq0KlDXGXZ/H+1XcZoULaOgHioBZXxk6k3JWqGs2S/nZWcS+SY+Pwmv3d8g/IsGlPyODXmlBPxqFrkPCRNlaZVRnrrJeyoOBuvngDi5Q/xAZPv35qYVV6dYsFuYqJ7J64/7p5oqGi7OErMNXBQ4pobjyFdOFY1q4wOGj4jMxup9V4+7FYnqk8qdO7hDxM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(2616005)(6506007)(122000001)(53546011)(478600001)(38100700002)(316002)(186003)(8936002)(8676002)(38070700005)(4326008)(6512007)(71200400001)(66476007)(5660300002)(66946007)(66446008)(66556008)(64756008)(54906003)(6916009)(86362001)(33656002)(91956017)(76116006)(6486002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bOpb+bja6u7VW+5DL2rJja4X8FYpyW0OA1gTCMdlCDosiC/xlIt1jjZZ3hLu?=
 =?us-ascii?Q?tFDVDFYhkJ8nRMZ8Uy7++dkAeZBGlt7R2v7oTXv2Y6WiWs3IGfrsYvDSbvqp?=
 =?us-ascii?Q?3GBSh3RVv9vzGGSIAy8lCDHFc3qhh3q/caeATOo4dd4EQYq0NnAJATNLv8J+?=
 =?us-ascii?Q?LhBgmzRcTQNVtBEbYjF1CYNVSMIQXSN3ho1YspWqcyQ8+FoKqDPYHDp3wZjj?=
 =?us-ascii?Q?OgCGiF0MI6mPKA4aMOooRMtoo/g2FR9s9raLXR+wlq+wLnJfqD/snAxI4q8f?=
 =?us-ascii?Q?mNOr5rZRQWO6fdDayjEZXkPmSShn6rCnG0/XhjYHM9PXlt24qm5dXICjkMeJ?=
 =?us-ascii?Q?wP8br+f+I0yivbdNG1n/wikQa0O3RMTT4SkxZqFO5qAxNF1VepzJITB+7G5g?=
 =?us-ascii?Q?q+fP8QU/36ZHZocYaYD93eBc7IrVXZb9DwETD0GsqrZle3LdXohsoHcJSGID?=
 =?us-ascii?Q?x2wPUF7YXVXVzpi3SCp4mHYl3RZHC8RS6pN5vgnjWlxyHTCr91DljRNVkZuC?=
 =?us-ascii?Q?VRQX77ZtAhwTiTcK62r+XeeNBIAIPLxS1EXNWvTgvdYt0Plh/IdLwna+d2fH?=
 =?us-ascii?Q?CSnKEpLBsZzvQzjVvvBxuhAtlbEVLd6bL5Mq7rvQTbqvI7FahpexSFTd8FlP?=
 =?us-ascii?Q?RsjeZXIUURjgnZ6G/idKwJbGEvpAVWN91+Ip94C//QEM19lYseNFt/sfhUSD?=
 =?us-ascii?Q?rVwiKAhJ3JNjHbaJZdZG3U2W834GGidzw+US7UBWVfAC7Sozvwq//EvbBCSA?=
 =?us-ascii?Q?58X/Rf97BQRGiGKGeGLiovxbsWagTTj38iboITSU1CPXOM1MOhLTMRZs6EC2?=
 =?us-ascii?Q?hQQUSjHIkg74yp0J1oxlBc2ECSZA5mA/ZFb20wAgJRNvJo/ernrSukRAbL+j?=
 =?us-ascii?Q?try/aEuNipOVQRgqnoObzOAKnmvbkiT/HmbHdZ4oyyl8FMsp8AR342QZkCIX?=
 =?us-ascii?Q?y70SbLk+sd2RhokrVx1+4gcY36C834y/9gmXCCz3dmWh253HHqrUUPbh/fTH?=
 =?us-ascii?Q?EgufjHKMjPlNK/UcI4yQvajtNvutZxU9S9icbILVOrwFtXFCWPZ0L98f0vvA?=
 =?us-ascii?Q?ldUVBQWdCDnn3ywe/7hPVNmYQGhWLG5pAIqLva5MhU1aTS0t3phIp/7nzrrf?=
 =?us-ascii?Q?D+LX3afqr6ABqZAEETHUayN8oGUbPdrhxcQURH1kzE/UQoIcIfztDlukUBPA?=
 =?us-ascii?Q?Z7Qx880mwR3SrO4reQ8KjvkCyv8yKh84LHVAY0N5iA+r1yeFlD+/j/+dplsQ?=
 =?us-ascii?Q?WfdR1yLGc9VrllGuSJjkmmhQ9lnkXiKpxkdVb1EzIr7qa43disStHiN3Fedi?=
 =?us-ascii?Q?IzEgBiD8RPrQ/xnHZwtshhmI4e+zrWMG9c2m22DGFi2fxoh75+qDMDl8qOuT?=
 =?us-ascii?Q?Lt5CACU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C2BE6915B162B84C94CDC6CCEF0C1886@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749961a7-c752-4409-f2b9-08d96bca6f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 15:25:44.2690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wLPNLKsMwN7bnjwNDPIzm20AY40yOSgIWfl+0gjE1DQ71eBGmoIak97Pfc4bOWt82aFpqFmBLwE2cOgBSloSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Uq6DwOJsRk_Z5f9NVY8kGldbksHOVI3g
X-Proofpoint-ORIG-GUID: Uq6DwOJsRk_Z5f9NVY8kGldbksHOVI3g
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_05:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 30, 2021, at 3:22 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Aug 26, 2021 at 03:13:04PM -0700, Song Liu wrote:
>> +int dummy_perf_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot);
>> +
>> +DECLARE_STATIC_CALL(perf_snapshot_branch_stack, dummy_perf_snapshot_branch_stack);
>> +
>> #endif /* _LINUX_PERF_EVENT_H */
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 011cc5069b7ba..c53fe90e630ac 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -13437,3 +13437,6 @@ struct cgroup_subsys perf_event_cgrp_subsys = {
>> 	.threaded	= true,
>> };
>> #endif /* CONFIG_CGROUP_PERF */
>> +
>> +DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack,
>> +			dummy_perf_snapshot_branch_stack);
> 
> This isn't right...
> 
> The whole dummy_perf_snapshot_branch_stack() thing is a declaration only
> and used as a typedef. Also, DEFINE_STATIC_CALL_NULL() and
> static_call_cond() rely on a void return value, which it doesn't have.
> 
> Did you want:
> 
>  DECLARE_STATIC_CALL(perf_snapshot_branch_stack, void (*)(struct perf_branch_snapshot *));
> 
>  DEFINE_STATIC_CALL_NULL(perf_snapshot_branch_stack, void (*)(struct perf_branch_snapshot *));
> 
>  static_call_cond(perf_snapshot_branch_stack)(...);
> 
> *OR*, do you actually need that return value, in which case you're
> probably looking for:
> 
>  DECLARE_STATIC_CALL(perf_snapshot_branch_stack, int (*)(struct perf_branch_snapshot *));
> 
>  DEFINE_STATIC_CALL_RET0(perf_snapshot_branch_stack, int (*)(struct perf_branch_snapshot *));
> 
>  ret = static_call(perf_snapshot_branch_stack)(...);
> 
> ?

Thanks for these information! I did get confused these macros for quite a 
while. Let me try with the _RET0 version.

Song  

