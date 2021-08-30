Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DA3FBA39
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhH3Qhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 12:37:42 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34334 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233446AbhH3Qhl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 12:37:41 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17UGUYCp022642;
        Mon, 30 Aug 2021 09:36:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=jJOpBL7yZ8r2NSyMtsICOLwYNMlmXXlKPl67nRR0iQM=;
 b=aZrBg0nVw1yexBLZTMGLs2wg3LLiIMdPcR0alAM4xJUInDj4r+oq6hUPtkp4khXIGLJS
 Pxb+tsVdG0/YoGAF6Ww1rZjkR0Mda7hfdAogPJCov255GJnuQ3m1yyfZP3Qi2+zq4D2X
 UVFCQKBLROknNUlCr+wxuJ/tUwevpdNYTmQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3arvyfa9ym-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 09:36:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 30 Aug 2021 09:36:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/3LdjVyNg+/cjkhgby43zrzkQiUILrxKC5dtzJgrKTzmnYs4/n0K3gorJ8fa1jyHKmYBXo2q9P0HuzQaIS5U5WzD+Z60zMEWrejO6SAsd6aLTKjAUrgjyXPAWVawXos0Vkl3qk3fItu7LmsqP5mb62Z2Scqzk2Cc+ca+tHm5SVB7q9k7BUrAgu9Wmpcod+NS6wPlftW1uqmGARQlBUoWGf10opcLkWfLHpXYK+lo+zyoVg47GuB3kYQqN9n/WFD/BJPRLRd8bvyzN4nsEQegevLP/mgsRxfCE/bhdLcH0d5bkh3TQ0p3ko1WjpovYvrghN9ZJFpPZbZy3R0igawlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJOpBL7yZ8r2NSyMtsICOLwYNMlmXXlKPl67nRR0iQM=;
 b=Lr0Dqv/a8znHqOA2EpsceCCedMJbvn2GLidQ0jzImW/2juaL9FTfm9vXu5/aGKIwVzNLLh+KoTpPWLkKRrslcEBTrqwq/rySmaEcdRxMvt+4PBv3PPrB7BhDOiqbXk2lwt7q4gRg2+8lLrQkCfZzl+/FHb18emuggbNKI7tGOA1YNAUjCvE1Em9FPytK/VEbgGTcfmLkH1LWO0cbsmn4BmKwYuP03A2Pxn7vxyvC84btN+yJBf4ybJQ8j/smws3JkaIz2PAJsWRpylMP/fl3gitIMWemTpJvo1Sgw+tYx81ooT7+XBXuF5RV5p0LGG5qvKcQbDLRnk4UBAiW5ogMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 16:36:44 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 16:36:44 +0000
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
Thread-Index: AQHXmsebo1O8tvcQbk6YyjOXJsK0SquL3HIAgABUloCAAAtlAIAACHKA
Date:   Mon, 30 Aug 2021 16:36:44 +0000
Message-ID: <106E85E3-D30C-48BC-8EB6-8DFEEECF2022@fb.com>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830102258.GI4353@worktop.programming.kicks-ass.net>
 <F70BD5BE-C698-4C53-9ECD-A4805CB2D659@fb.com>
 <YS0CBphTuIdTWEXF@hirez.programming.kicks-ass.net>
In-Reply-To: <YS0CBphTuIdTWEXF@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ff30a99-ff6e-407e-a434-08d96bd45a59
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5112267BD1A2DEBE793CB048B3CB9@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYjSNTP89yRjdy/qmeQmPG5IWhUWIdEULnRNXk+TIbnxmZvvtatKafYSGZGeJP9uPPGJHIU5XcWdUzr9ZdbD5G5NKWRmllFU9CyXMBF+GvQgCZzc48DloX2OOI+JOpMEBbuQmfrcZ8iyGBJ1gVfnykfXhJNzMifTokbXszKyOgYD0ZBxem3UGDo/zoe/TbODNfWn8eWLOTRwVoxczfEzxZCmL0UHkK2n7hXICRTMK9JmMbwlOVo6u5oX4R2JuN3H5CRwdWF+H8eJkWyYWuAzckIPfPSwfvtRA7EC0T2r8h4zfx+sYkGwTMsKS2z1DcVbeR08irC08oNOpr1mV3ZittWMgzDAYH2Ekg+UkQVlnnbrZg5Uvp4NGDU6mJtg07eD+aMpAo2hsv5//cjcpvA55OpOjpe/t1cvnTUiwohHiirZmMEPjWJ19SibnYuQ9dPxczObJ/UjvneoYJYjy4/2PrZFhA3Ufs68sFpKMKbBhF3a9rDsvzrtmTHpXlH+WpDjaro5qAIfSadd2bcduvLm5vm8k3Cstuycinv9yWhbtb26ykT5JfX4qP1V2SCtjDjv5Wc2QHE0Qvh1C2WkFgmx9P7qiNZ6jR7O/lpoVNMp08fkZU88MP2yaDuTRkkRBWLS0ReJi1ZG0fIrIFnWqDtqcZMRJ2XmHLuRkjFaOy3Q32m/kqL21Iz1NThy3mNEkTSfr4tBHYZUjgY7CDQRd3W9vwn1lGf5QC9/HxDaPp3Pf1sqfee6/L2bYKcprHHrHcu9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(6486002)(66446008)(64756008)(8676002)(6916009)(66946007)(38100700002)(5660300002)(122000001)(33656002)(83380400001)(66556008)(316002)(2906002)(54906003)(6512007)(38070700005)(53546011)(186003)(508600001)(6506007)(71200400001)(91956017)(66476007)(86362001)(8936002)(4326008)(2616005)(36756003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6F+xyCDcfv8sWtaxDhy2DKxmzLMAOMbH4hM2HWAyjbVSCFO5ngcexoB61ZU1?=
 =?us-ascii?Q?Mw4Uc3iHlPYzUYyrhspX5nCcxI/2Gd2RJpBfchde6Qz3fWH6uUTJxoySaeM4?=
 =?us-ascii?Q?d/cbkTbA+3o8anxcI6v9PpZaV4T+2y5G58Vl0GWyfIyz3ga9Tzfa2xwEuY8z?=
 =?us-ascii?Q?uQAtHQeWQVuWUpTLKthAoGDzqR1jh2K/E3aJA4aszc/4wNfNq8gEizE1BgMX?=
 =?us-ascii?Q?geNZPaSaBiFZd6zfVtNXw6Sv0pob1teRv05nuT7VJ7te4adqOcyCATtKN98Z?=
 =?us-ascii?Q?OJGV1a5IBoEYaMwGPh2cQ7y1VdFFow3zUMRO2qDfVPclq4R2oX7eSN5KY0l2?=
 =?us-ascii?Q?UJXSkBastFgoc3wj9sR6M7FKRtsqPgcZSqZMO2jbvSQ9HBQWsDWTfFHW29qW?=
 =?us-ascii?Q?hzHhcFxKIqvyyty2jKADvQKzy2oEZ+Kk6RDMQx3QeWlPmqALoZNmcDcK3fKQ?=
 =?us-ascii?Q?lp5qPI0fCtRjqCyxkr7nPE/gsRg8/M2LxorFxXtCO+kT+gQTJvOnsgsQDVX9?=
 =?us-ascii?Q?aoH5Sri8jJzJPU1j/ZrrJ3CITrMmqO98pA+6na6c1Vkw2GuTD6fFHQ5qNqkU?=
 =?us-ascii?Q?LBWF4vtiBq7H1pmGLahuVN50q2kdx4CQR11sMlyCDiJzYNuh3v0U0s9ajOLz?=
 =?us-ascii?Q?WYBDoA7jiaFJb3bBTIOvQ50SLlbDyCp5yxNMmCHTI+PF8P3LmKmYPpcJqwNQ?=
 =?us-ascii?Q?1x3gKy+llzjNTxGVtEfzu9EaiFRg8o1R3XWqmsQfcyizHjCv1cZiDmRegUSz?=
 =?us-ascii?Q?uz7JfanjkgDY8TkG4iGHWfbRtvk7oicpCQNrmJMRqdTsuFY8Conx3UMOGtXt?=
 =?us-ascii?Q?U8Ve0W8meNG58jXZH4XHIRM2HrzGWEdHJpTVgPUq+UbTay2atHnSekKvnAaS?=
 =?us-ascii?Q?CQHJCVgFQJR6O8z7ds8yDt1TLi4v+n6ds/8gY3xpCo1LTa75UeAMSAi15TYU?=
 =?us-ascii?Q?nX84Hljg7cXBge5L3xI2kSSptxif6XfyjlA2FVxeGPcAwzT+NN0KdjnBl9sh?=
 =?us-ascii?Q?e4PzIV/zg3WrT4NG9TuWqmhtg0tuEQaPUKv0222kZvdJwXr93gV8aFBtkYWs?=
 =?us-ascii?Q?eQ7pQ+bmrCAFxL6YD4ssbosCsBALNbIGE3Qbl2nN7aB+B77MVQ/pJ6GtFwKC?=
 =?us-ascii?Q?xjPxdtuRqz5mCoxJIUivQifQ0GaMqwin/TqoZde3avUh0Ooyd276HRGMqatL?=
 =?us-ascii?Q?vtYB4V+dPZN1fCUX6OFyBGLzPK3E4GtL6RsY7x5rDeBNQlkXMYXJNeXCrRDb?=
 =?us-ascii?Q?Y4x02V+w0dNnKRPUDflDwbPUdLEGTmCKNdy5wXHaBLKq2bnwHdc1Z3mu3FX3?=
 =?us-ascii?Q?ThKrytisKPmSXUkm/Ktfk+Phz9jzuJ+lnPa7noxOkpp6KXxChz7qm2TVH1Mi?=
 =?us-ascii?Q?oW0+3IU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24A7C0F98ABB8C40BBDDF6412A2323FA@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff30a99-ff6e-407e-a434-08d96bd45a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 16:36:44.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sg0CbBLvd65C1ybSAA0tOF0eApdpa6wHUngaMipXY9/zv5Rk5El+2KMDlq+iLSiZMvQ6qQciSPsvWQJr8go4dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: j5aXYVZsUYIQEguii3as1t-Pr0MSyx9V
X-Proofpoint-ORIG-GUID: j5aXYVZsUYIQEguii3as1t-Pr0MSyx9V
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_05:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 30, 2021, at 9:06 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Aug 30, 2021 at 03:25:44PM +0000, Song Liu wrote:
>> Thanks for these information! I did get confused these macros for quite a 
>> while. Let me try with the _RET0 version.
> 
> Does you kernel have:
> 
>  9ae6ab27f44e ("static_call: Update API documentation")
> 
> ?
> 
> With that included, the comment at the top of static_call.h reads like
> the below. Please let me know where you think this can be improved.

Aha, my kernel has the code for _RET0 part, but not the documentation. 

> 
> /*
> * Static call support
> *
> * Static calls use code patching to hard-code function pointers into direct
> * branch instructions. They give the flexibility of function pointers, but
> * with improved performance. This is especially important for cases where
> * retpolines would otherwise be used, as retpolines can significantly impact
> * performance.
> *

[...]

> *
> * Notes on NULL function pointers:
> *
> *   Static_call()s support NULL functions, with many of the caveats that
> *   regular function pointers have.
> *
> *   Clearly calling a NULL function pointer is 'BAD', so too for
> *   static_call()s (although when HAVE_STATIC_CALL it might not be immediately
> *   fatal). A NULL static_call can be the result of:
> *

Probably add:

 *     /* for function that returns NULL */
> *     DECLARE_STATIC_CALL_NULL(my_static_call, void (*)(int));


 *   or 
 *     /* for function that returns int */
 *     DECLARE_STATIC_CALL_RET0(my_static_call, int (*)(int));
 * 

So it is clear that we need two different macros. IIUC, the number and 
type of arguments doesn't matter? 

Also, the default return int function has to return 0, right? Can we let 
it return -EOPNOSUPP? 


> *
> *   which is equivalent to declaring a NULL function pointer with just a
> *   typename:
> *
> *     void (*my_func_ptr)(int arg1) = NULL;
> *

[...]

> *   which will include the required value tests to avoid NULL-pointer
> *   dereferences.
> *


> *   To query which function is currently set to be called, use:
> *
> *   func = static_call_query(name);

Maybe move above two lines to "Usage example:" section? 

Thanks,
Song
