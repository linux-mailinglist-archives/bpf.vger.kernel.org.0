Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310204071BE
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 21:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbhIJTMq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 15:12:46 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhIJTMp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 15:12:45 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AJ9TbQ023510;
        Fri, 10 Sep 2021 12:11:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Iuea+N+3U7R/uzQ0ejBNjH5p2TeFhyDXSdomIipwfqI=;
 b=b1QJqsEGmFH16h1GBE8d2cVwKVkky2o9/xlr+UYfqltxYswzpBhVzmyPrnqF+JypBXYP
 4YfFaOWYXqmxXlzQ4ITor8MPonHY34/u8KgCYWUr4e0exVDZhOEbTFVPxBVeHgL10lul
 sXu+vWgpp0vENwBxnhZnOTlCJB6Xjw6ER+0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytf2xyqp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 12:11:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 12:11:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c0LiGK8TShp+DJHA6oHLZ9MiwqY9mxghZuiJs0ACZbMarPlmhpWtu+sXdllX2u3Tr6Q9wW168jjFZQ+ugiyvMTlfhWgc3SP4/62Iq09sHA9h776vQE6DiIrPnrUNdNputSwClodjefdFU9zgZ6vuFsdGHY/zA4TeYIZhlf7knold+O/rwMjHaFVh258kvd/FoLlWDqsy/kxpvXjg5WGPuDr3KKHq3Znl2/JhjhWhiyCAqiPPSOBDRaDSoS7EU1n5b3ljLa8js7P4nhdHmkfgM9J5TqQ1Vsc10kow4k/Lr54/rB73amJPRdihC6qabjYFyOB5FGxJXF17pwwxFTS4yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Iuea+N+3U7R/uzQ0ejBNjH5p2TeFhyDXSdomIipwfqI=;
 b=VMD2yoqcm7HaO/Z1FdfugAXcVTfnoRM5Watrlgpid7wpEov8w9HomBasj7utFwmt6e2KxyTnOlgHbCNqXSiIRmDh8VWefQ7ZRtWV7fiyPY7fGDTQqp4YKkJa0SJ1MCFf+HdXkVdEDxqDnJ4jPeMcrhbuaZl21jujkb4fxaZvqbD+LROS3smF8Rj92zP7vWximRfnIuP9UEOZ6QUQLySgcXVAihUjapJfrgKV4daxS5PgzcCD+i3D3id5md97FoNNfzkr3sN5xeLfb+5HvQN1OIHZkvxVQ9eV6XWWEGwVHZ2AxivfWB3IYuDFkjoWVwi4XFgtjDmGB95U6gBxq/EIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5063.namprd15.prod.outlook.com (2603:10b6:806:1de::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Fri, 10 Sep
 2021 19:11:29 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%8]) with mapi id 15.20.4500.018; Fri, 10 Sep 2021
 19:11:29 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "Andrii Nakryiko" <andrii@kernel.org>
Subject: Re: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v6 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXpCby8uzfjDX52kWXwjwsop4wLqudGFYAgAA1/ICAAExtgIAAA5iAgAACr4CAAALQgIAAAjgAgAAA8oA=
Date:   Fri, 10 Sep 2021 19:11:29 +0000
Message-ID: <AF4F19DC-6B85-410A-93B0-E74CFC56939D@fb.com>
References: <20210907202802.3675104-1-songliubraving@fb.com>
 <20210907202802.3675104-2-songliubraving@fb.com>
 <YTs2MpaI7iofckJI@hirez.programming.kicks-ass.net>
 <YTtjeyfJXXiDielu@hirez.programming.kicks-ass.net>
 <96445733-055E-41E3-986B-5E1DC04ADEFA@fb.com>
 <20210910184027.GQ4323@worktop.programming.kicks-ass.net>
 <20210910185003.GC5106@worktop.programming.kicks-ass.net>
 <6830FC62-995A-4282-BD30-76E2506ED993@fb.com>
 <20210910190804.GS4323@worktop.programming.kicks-ass.net>
In-Reply-To: <20210910190804.GS4323@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2604e7de-b64b-49a3-75db-08d9748ecb6a
x-ms-traffictypediagnostic: SA1PR15MB5063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB506327CE69020FDCA9DB8F1FB3D69@SA1PR15MB5063.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r2hda4ewAuvDzGWObvZbjs5wpMIgIw8xDIW/6HzuR6r7zBNO4JukPOK4jOjo0IOn3aeSCQLV7pk4Uu2ryb9/EzzAh50886vidSRdnwOnkQkZQkt5ue/ozxurMdV6e1kSM/9BF6V8AtUqdUH4OU+1ouEh1LF/AcblVF95d9GasUAfYXgYZ1EySvIwuwcP+JnF0cCjOrPJ36kDyw9Z4vZfb2z+1pWaBBkgO9hZKsgAiU1L8VDGhyVBzP8x3oYuR/whTvao8RWseHzzNOyE9eyQ00EVB9MelR/YlfKk2qsrGGKpHEg/MrqnL/jUmHMKA3ffXWdtDqMJD9aSRlFPuYIlmq6j9PJ/dP23yPzicTGe9nTErgDcZMJyCneN+GNX4VzpCvZSBxU3fYYM/B8iP7xdzin5y3qWjSVoOsLOaQHVBJ0kctn1V3JS3Bis3Tl/zgAOA3o13KPWpD3kHDIK8QGunvp0t2Q4e88gHOuPtOnSJpeTrvap0DnrfG/Oc/wCZGtdt8DSOVUkL57nL463BkRpwZmsNiB2ov4e2HAAjRkspEsW7RIhFFbcFVME865hZzjLtx+iwaBoGLZYAmy9jYixgXfgBC6mYxdhVTuH1ciOIB64LZ9Y6M0HtN5OFKoyoY4183Ibr8KEEjjK137laDZVuqg1dTTalPwgB5TbIBZT74K2kppmnAVSfe5WAIPW+6wAVpfpsTX7TXJI22EQiLLnnJ18MzP8Ze71pQkf3e34ochQ5ByV31eG76nnH4buZQk4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(5660300002)(2616005)(122000001)(6512007)(4326008)(38100700002)(8936002)(36756003)(186003)(54906003)(53546011)(6916009)(38070700005)(71200400001)(6506007)(478600001)(8676002)(86362001)(66476007)(66556008)(33656002)(64756008)(91956017)(66446008)(316002)(66946007)(2906002)(76116006)(6486002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tu6gGSs2tYKYCYrMASihkrSWoh8HPyAoMEGnzqvbphqBEqFDoWDQv914Mk5m?=
 =?us-ascii?Q?EZ/SgcRckxp2jOVBvsCWrKefbMF9iHAaa4emb02EYeNCE4PwKMKtV1NVFxJ2?=
 =?us-ascii?Q?/JvYJPOUwOCTH4PW6gdnfNHewkjjKFslZyKGlk0hWraS8XfEdsjyvnHJzGOr?=
 =?us-ascii?Q?qn2StpQZzW2r7NII0chmp/Rqg6/zBPlArdoPhh40jICEhVuPs8Wsp3/vboUH?=
 =?us-ascii?Q?ivHhf/kl/OYtIjBoXE7Tfw71rI8QlEiDp68vMjy5v5k4ODi3Cf5D0FPZ7zYS?=
 =?us-ascii?Q?d3I4XEyshTZSzpsE4wnEusOG+PMYWpyZhhL7DVQ5A11yiar46U8uG0iTiCM5?=
 =?us-ascii?Q?sN6n/9yh1sLUpRLZwj2Uss9P9X4JbDbnersO/JrVEWztkYGWQGRyzQ9o4fvL?=
 =?us-ascii?Q?QWXDNk36pJCOTbfEgfDmuxluyJjPQ0zyb6iroU99ZGfKb1TALRJOzV5X2kWZ?=
 =?us-ascii?Q?vhPtxRr8/o8vW3QLNshcXuVI5P0p1vbLlqn4Op/BJdOFadhR2AE0NUY5p5LN?=
 =?us-ascii?Q?A6dYgriuxmOZxABRsBGrUjxsUd+4FXX98mz4W19OfG2/gfWp6BHMhUmHMd/6?=
 =?us-ascii?Q?3/SXmZZmDhgcvQo0xdJcnOFeQjctNDloyDIfJBSlaEsrNRGOmv9Sfor4m/Ud?=
 =?us-ascii?Q?SKeluQfwmb5buyl1Rc5/We4ZWt88hX3Nd3ESkzXQqWwG5ITus5eWQKBKmUJ/?=
 =?us-ascii?Q?t6MwWx6xwyHWxRRJjucHhgWX/SkkPQpHz8vZf1YbP2Fmq4dP3GQ5pyVRp0p8?=
 =?us-ascii?Q?zpId8nB8bZYIu7I6umHuFsWARr0DksNFAUxw/Hfo23o8mYdq5BzzNVxeDiSn?=
 =?us-ascii?Q?v/qiZENEVsOmIPvp7Hb2fYEgIeh+BbuyJjaRqPQSJAcPm7F0mZRiW3p97ZUo?=
 =?us-ascii?Q?X8HvN/yMBPsvv5Ie4G3q6tzvQ551fwcXQR1n3c9ughVnSKCPfJJl4ON6Xstq?=
 =?us-ascii?Q?9NdbHm5cPW9T5qtVkBTmpVGQr7OsLZbVdZioYyS8OBmVYUNi2+TLsJ4q9/da?=
 =?us-ascii?Q?BB8r4uO9knPprF2A6fYIUij3fnI1Bq3URKyn5ULu0HnLx8xmLPJjkLwzRkJp?=
 =?us-ascii?Q?STvMo7XCSygXpnL1yvVqm9WoZmHjn/U0e+d0fC/kcWuUue7qdFLUNOUtHOOc?=
 =?us-ascii?Q?XDqRwDDn9c9sXHl0VAABX5G3/VSekbKH6jBagOL/z3GvWILE92CC2iJynNRG?=
 =?us-ascii?Q?rvttxE6QZhOMj1V/C3Wthh4RH0c6j7ewouK20fN49Lb0BH6dOPZ6SRok0BZV?=
 =?us-ascii?Q?iSHCVKhQqYXCRmF+X/jcbjizK1RU4Rj6GiNqwvi5N/e2nDkxpbp2LCm9zBqW?=
 =?us-ascii?Q?CskChdKmwR/yNQJHef1QC9qlRj9vDHqM0qEp7/eupgaLl5KlCcvZLovn2XD9?=
 =?us-ascii?Q?qE91xrw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14E3BE765900B044A72996E5A34BBC59@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2604e7de-b64b-49a3-75db-08d9748ecb6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 19:11:29.5176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gXU+gIkqSNfxeEJcUkaFIO9yvQxIFbhCmRyUtkHO/u4z4yyxN0/S+vsOioOk7ql+eEOWNitMNncY6ktjKBHmdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5063
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Wt51SO8brCkhi3DvdbDS9p7c6zwBgLVR
X-Proofpoint-GUID: Wt51SO8brCkhi3DvdbDS9p7c6zwBgLVR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=956 impostorscore=0 malwarescore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 10, 2021, at 12:08 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Fri, Sep 10, 2021 at 07:00:08PM +0000, Song Liu wrote:
> 
>> Hmm.. not really. We call migrate_disable() before entering the BPF program. 
>> And the helper calls snapshot_branch_stack() inside the BPF program. To move
>> it to before migrate_disable(), we will have to add a "whether to snapshot
>> branch stack" check before entering the BPF program. This check, while is
>> cheap, is added to all BPF programs on this hook, even when the program does 
>> not use snapshot at all. So we would rather keep all logic inside the helper, 
>> and not touch the common path. 
> 
> Moo :/ Because I also really don't want to expose struct rq, it's
> currently nicely squirelled away in kernel/sched/ and doesn't get
> anywhere near include/.

This matches my guess, so I didn't go too far on that direction. :-)

> 
> A well, maybe we can do something clever with migrate_disable() itself.
> I'll put it on this endless todo list ;-)

Awesome!

Thanks,
Song
