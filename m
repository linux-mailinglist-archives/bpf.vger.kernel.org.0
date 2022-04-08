Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5774F9FA1
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 00:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiDHWiX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 18:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiDHWiW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 18:38:22 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B72E1427D5
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 15:36:17 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 238LNd7G024523
        for <bpf@vger.kernel.org>; Fri, 8 Apr 2022 15:36:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=v0a7Asx9EJnXMqZGzJ7DZkicUkNPFPVOLuVYFyQsiQw=;
 b=hpJTy701YD15XhYMGDdNvCSdim8Q/oBvv5YGW/9R6tKm4N3uDEh2FsruUYBDIoS/UqOd
 4N7mURvq3cLlv8NYn3oDyDx5DQtqD2eKchKqXKyXXCXykEhP0OEic9Sux0gqjUr/Exmq
 +5gUQjpsDSnHUQ8QbOf3OWUGqiRkx9A0efU= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f9tgrwy9j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 15:36:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWBlVs04Sz2p68zNCcNV+ns88r6cjjltcARS/pMliAG73gRkcwtwIfx+DRAHakT1MkWcLCL+hhkTIxd+x0WmfMQbQGY/DfySGE98a+jTVA8HyDH7aQPO5+XZuv0aWLyRDnWTI3vGsx/qK8VzttFhXyX0tzGf823L0urPKkX5/b0h/4Iso7eaD0Sxz6+OEy7zqhbhQ4nmrC4fDu6wbnI18+SdoRRw5SW9ZSBgKWRTrfLqDnuPil7muk+KoZbCc6RNmacullbXvg+jGyisXCRJEEgRCherDUhf3qy6USmH4hMMTMVukYl8PqUiRyx6pSliEKES/fS93LS68WOLi2zVUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0a7Asx9EJnXMqZGzJ7DZkicUkNPFPVOLuVYFyQsiQw=;
 b=XBxSCrQ6wIsOTl5wUi6VXqmUgYDZajiZ+RI3LnMM3K83H4qCiPZGuJU7QAKiEzwi/ugrJwlnomiLjdoFc2vaanIJS4i4sDL49qfZxjOleOe8RgdeUf+fAJ24GlWv26YCG7xBaVSLzs2z5KrJlK8PQToUZmw4HBYrXBA3ixSe2UVV5+VQbP12+CsA1yrC12JHTF6TnBKcu0e0Nm6G9QqASr7C6wVwCu2j/I8COHwHKZV+xpaKqJcEIAqurCGMYbeP1t7ZhLw7gx0nOZMtct8Z0wH+viFT1GMMw5ZSCXsayzmp6voIjkriogxZCSy9L5iqkEW8JhTio6hcXEoBjL2dXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO1PR15MB5002.namprd15.prod.outlook.com (2603:10b6:303:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.26; Fri, 8 Apr
 2022 22:36:13 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e150:276a:b882:dda7]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e150:276a:b882:dda7%8]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 22:36:13 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: allow "incomplete" basic tracing
 SEC() definitions
Thread-Topic: [PATCH bpf-next 1/3] libbpf: allow "incomplete" basic tracing
 SEC() definitions
Thread-Index: AQHYS4gxfhHXQoG0OkKHpHSJ8aT8bKzmfGWAgAAao4CAAAQBgA==
Date:   Fri, 8 Apr 2022 22:36:13 +0000
Message-ID: <37A18073-735C-496B-B158-3A9CC57F33D2@fb.com>
References: <20220408203433.2988727-1-andrii@kernel.org>
 <20220408203433.2988727-2-andrii@kernel.org>
 <CAPhsuW5N9qBX0kkQSLK_Sy36cPa==SVSFi+38ZNqNez05zGD6w@mail.gmail.com>
 <CAEf4BzaZai7QZnBEcAV72D=0irABs9BjbH++rmRQkqKiKpLYvA@mail.gmail.com>
In-Reply-To: <CAEf4BzaZai7QZnBEcAV72D=0irABs9BjbH++rmRQkqKiKpLYvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 243fbaf3-a6de-40c1-a337-08da19b03026
x-ms-traffictypediagnostic: CO1PR15MB5002:EE_
x-microsoft-antispam-prvs: <CO1PR15MB5002A07E0D62EFD06C5EB201B3E99@CO1PR15MB5002.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlWS6Jxy6Zyh/H3pk1L06PVwyzOCO5qfvTVM461Zzc5J8eQPfU9CLCIWou8Iu7mNqaa6qPWqZ3r71qfA4Uor1ufBsv5JG8zdMH6eZ57A6IZXm/XGvckkP81NA6fvSqVt4fwtSAToMkzdg3JxC73LFMwoWC9EI2BCPb4GQ64lIKrA8d/PVMZnmCLfyzjPSxaaLzW8Rucw4PPJEamqb86I38z13VBINxaF+yXmad6NesRS5Sli6OxHBWsUL/jIVo/6yUyXf+3hO5/rw4afusUPWwvhyqbuWWLJ5Ctp0XGdg1/0Rk6QmApIj3lUUfYh3b2SG4DEUNoBvra6BZn55FmiOa4hFyuJ5EPqTNS2pRROV/tgFyyOX5zgKPwIhHfjCajx3hO5BEoMzOfTzKhnTO7K3c0uWPw++Yh1Q+m++zx33VYUEeCVSEWpKesKopLhb2Sl7G+EpKWWujefOSM3nC0VXMUkFVFlLzIIIPQzdStSBkCly3w670WiompLYGMYpb6VCiW5ejhX0A0soA3OdyVCtB5D196hbvHAQkTV1BPhuMXpjvX/EKx/InzDxQNDMviZZTHvyqoXn11v9abqmGDATWs1F22lP3zV4oRfdm3zdqon91SBWAVHZe5Ot8SYoftcF6dgN99NmG6pdlMk8oLllM7teRnDR28j/UYyM8hIlcrKQPY3e3HIn8aQcj/nZ1GCu8U5rWaFH+87O2THfUF3Holi29ZCuuO7/LFSm1Wq349/ItszzSqKxEOi9aJCRa9o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(33656002)(186003)(6512007)(508600001)(6486002)(53546011)(86362001)(6506007)(38100700002)(38070700005)(122000001)(83380400001)(91956017)(76116006)(66946007)(2906002)(6916009)(5660300002)(54906003)(66446008)(8676002)(64756008)(66476007)(66556008)(8936002)(4326008)(36756003)(316002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3N1e9xOw11ifreLzy2Fx6mEsGC3ejszx5WPp+VeR3iTjCxFmQxQUn0n28ATv?=
 =?us-ascii?Q?DogEkBtdgUyKeFVcRDkcNcjXMe9mq1hGe7Zsz8T1RffkGuyXKOpAmWYJtEEb?=
 =?us-ascii?Q?/LNWmlRL6Q2KdV/tatKvuop/Qd7OaAY8B/fzqsZCFCz1jirR+RMW3de1O9O/?=
 =?us-ascii?Q?5mn79U/FqUMdRnen7ygGoLeg7d8OL9dE3F1uv76AeA2wkOTCrVi0aJNqNanw?=
 =?us-ascii?Q?lsfCGbj4Myolw5+zlo1Wb/6PyTzBpO219mAmpPl/xXKFYBdxxfxBhX15xs4/?=
 =?us-ascii?Q?D8rlkVtUZ0MNWreBF8gH/WBRpZ69O3IeGacE5e0gY5CRPp9VuGzLS3R7ffRa?=
 =?us-ascii?Q?JB7XkqwzL6sW/VparmuwXZkSNnXFmA9W2p925+VxXt8e5vadGw4Mi1Zm6c0w?=
 =?us-ascii?Q?WzOkHbT92CwfcLmfS3L2fAMwYz4vfnrSKIu1ITq1KbwQfDxwHJGFaE4ealZE?=
 =?us-ascii?Q?5pqcmKmx+hMkYSIqx9BGzXuO38qqZFK2KvVwclwqV07FPVRSym1LsOCzrp1C?=
 =?us-ascii?Q?8L1Rpfvl0y/eFeUnKEXPJH088Wj+4mS8zR3nl6VBKdawauQMx2rgkQBYuOh0?=
 =?us-ascii?Q?sA9EC/pXBn/O2hoz9XlFPAaK1SQ0jXCHuEN+AbgCzgxbIlIAE8cBMN39Z05l?=
 =?us-ascii?Q?Kq7bH/mnOQ6R1+ov0VJGjcnFNM6eqHEJC8t+Wmq9W6H431xzOOomoDUm7ZwW?=
 =?us-ascii?Q?XHvQTD/lv4Z7nIaOEMB+9GHeivJnrbQbHi3dq+oIZ9DJCUFu5RDTDJaPIu9R?=
 =?us-ascii?Q?uZcRfb5HjE2yN8fMV0WyoYIS1qWO4c+aAoGYVplLAibrqZdY+//QuEJ/EBBs?=
 =?us-ascii?Q?XymIAGcM/oxVZRyxCeu50RuJz/JVdiZx9looWL2f4qhrXJ4oetPEb2vCmKbi?=
 =?us-ascii?Q?gPYZdH3Ko2ADY9SjQXhxFDOkNStEXOq+HYWNpYs5DeQQpa5asPlPyD4Fntze?=
 =?us-ascii?Q?JrVnXMUuu6qTpxnoT9fXbA8A/7iXy5XmgAJenzOxqWzdz/T8I2yVrVZbKWNS?=
 =?us-ascii?Q?dXc9IJosvJbsVn3262d7xtVnR8akSqHViat9hFfkv7UMPD2nTviefZshD9dJ?=
 =?us-ascii?Q?r2VvyZquPP13fcdI/b0rYOkK4N72n/pSSvl7qL7sM6SOZW4fYZ7hk43uNAcj?=
 =?us-ascii?Q?SMwtB9+a4hd6XBs7opqaIErf+kug4c0SYl6WYbhoMuB6thJBkh101UMMS/7Q?=
 =?us-ascii?Q?2sEf/W/c86MI6x4aHfvpTGBNmf2fMOqNmH0wXWajKxRhCCsHmQtSUfeGuMah?=
 =?us-ascii?Q?eXIi0G/a0CsNYEx6EzSxl3KlyYNTuLbQ/MEvkhgglM/6CjZzPknEBdYXBzY0?=
 =?us-ascii?Q?hLaTGAn1fkSw8v6ick4ym6Ih/D3r9druCSJQ+KsiLg9SWdIsRbbOrEVc8XSs?=
 =?us-ascii?Q?puv3EdF8Wr11FjuzbPLvCzfXvCn15Jb8NvcXYE0RC0cwlORvHDQhtCoZzwIf?=
 =?us-ascii?Q?zVT1SozAX2yLwstDSBVZ8XYHqYtu8idrKzh9nV+ZVTgI6mSmyEziMttuutkx?=
 =?us-ascii?Q?CnvQQeYNVEwnJE7gc924bpAzCKZHjGH8D5/IUkvLG7FFDJ678iecs6FHdnH9?=
 =?us-ascii?Q?iwONstKFe+7bXKjGZJoImB4Ht38Nt9P6sDWaFLLRr8Tf2QEf7lT3kxoSkAk8?=
 =?us-ascii?Q?4bjUVmp5X3jQ6A32M/08u+6p1xFBjpXEVSt1lZ4cne820fZ9/2f9sglFpjao?=
 =?us-ascii?Q?FucejniwuguKvU9NtvpwsZ/BGGwwWtlmx2CG9fwsPI7o2rZR8mp29/5sEl9T?=
 =?us-ascii?Q?GRa5uK+UlMGRjjITpJyGHp+vYV0RDyeDazNQ1wWQflxRyHUYGkqM?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA78869A9302DD478D76F64B4973FC6E@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 243fbaf3-a6de-40c1-a337-08da19b03026
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 22:36:13.8342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kNrxYm+sRNQAbUWORUSCn/H6SllVjC33NKKHDFg1BmRZkPTmpjv/qbSAGNRe0RUafHqeIC49TXHiCaTfu9e0vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5002
X-Proofpoint-GUID: ORsPQgEd4Zpg_csZ_iBdFIwvSVA-_EZl
X-Proofpoint-ORIG-GUID: ORsPQgEd4Zpg_csZ_iBdFIwvSVA-_EZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_08,2022-04-08_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 8, 2022, at 3:21 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Fri, Apr 8, 2022 at 1:46 PM Song Liu <song@kernel.org> wrote:
>> 
>> On Fri, Apr 8, 2022 at 1:34 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>>> 
>>> In a lot of cases the target of kprobe/kretprobe, tracepoint, raw
>>> tracepoint, etc BPF program might not be known at the compilation time
>>> and will be discovered at runtime. This was always a supported case by
>>> libbpf, with APIs like bpf_program__attach_{kprobe,tracepoint,etc}()
>>> accepting full target definition, regardless of what was defined in
>>> SEC() definition in BPF source code.
>>> 
>>> Unfortunately, up till now libbpf still enforced users to specify at
>>> least something for the fake target, e.g., SEC("kprobe/whatever"), which
>>> is cumbersome and somewhat misleading.
>>> 
>>> This patch allows target-less SEC() definitions for basic tracing BPF
>>> program types:
>>>  - kprobe/kretprobe;
>>>  - multi-kprobe/multi-kretprobe;
>>>  - tracepoints;
>>>  - raw tracepoints.
>>> 
>>> Such target-less SEC() definitions are meant to specify declaratively
>>> proper BPF program type only. Attachment of them will have to be handled
>>> programmatically using correct APIs. As such, skeleton's auto-attachment
>>> of such BPF programs is skipped and generic bpf_program__attach() will
>>> fail, if attempted, due to the lack of enough target information.
>>> 
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>> tools/lib/bpf/libbpf.c | 69 +++++++++++++++++++++++++++++++-----------
>>> 1 file changed, 51 insertions(+), 18 deletions(-)
>>> 
>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>> index 9deb1fc67f19..81911a1e1f3e 100644
>>> --- a/tools/lib/bpf/libbpf.c
>>> +++ b/tools/lib/bpf/libbpf.c
>>> @@ -8668,22 +8668,22 @@ static const struct bpf_sec_def section_defs[] = {
>>>        SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE | SEC_SLOPPY_PFX),
>>>        SEC_DEF("sk_reuseport/migrate", SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>>>        SEC_DEF("sk_reuseport",         SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE | SEC_SLOPPY_PFX),
>>> -       SEC_DEF("kprobe/",              KPROBE, 0, SEC_NONE, attach_kprobe),
>>> +       SEC_DEF("kprobe+",              KPROBE, 0, SEC_NONE, attach_kprobe),
>>>        SEC_DEF("uprobe+",              KPROBE, 0, SEC_NONE, attach_uprobe),
>>> -       SEC_DEF("kretprobe/",           KPROBE, 0, SEC_NONE, attach_kprobe),
>>> +       SEC_DEF("kretprobe+",           KPROBE, 0, SEC_NONE, attach_kprobe),
>>>        SEC_DEF("uretprobe+",           KPROBE, 0, SEC_NONE, attach_uprobe),
>>> -       SEC_DEF("kprobe.multi/",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>>> -       SEC_DEF("kretprobe.multi/",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>>> +       SEC_DEF("kprobe.multi+",        KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>>> +       SEC_DEF("kretprobe.multi+",     KPROBE, BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>>>        SEC_DEF("usdt+",                KPROBE, 0, SEC_NONE, attach_usdt),
>>>        SEC_DEF("tc",                   SCHED_CLS, 0, SEC_NONE),
>>>        SEC_DEF("classifier",           SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
>>>        SEC_DEF("action",               SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
>>> -       SEC_DEF("tracepoint/",          TRACEPOINT, 0, SEC_NONE, attach_tp),
>>> -       SEC_DEF("tp/",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
>>> -       SEC_DEF("raw_tracepoint/",      RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
>>> -       SEC_DEF("raw_tp/",              RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
>>> -       SEC_DEF("raw_tracepoint.w/",    RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>>> -       SEC_DEF("raw_tp.w/",            RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>>> +       SEC_DEF("tracepoint+",          TRACEPOINT, 0, SEC_NONE, attach_tp),
>>> +       SEC_DEF("tp+",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
>>> +       SEC_DEF("raw_tracepoint+",      RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
>>> +       SEC_DEF("raw_tp+",              RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
>>> +       SEC_DEF("raw_tracepoint.w+",    RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>>> +       SEC_DEF("raw_tp.w+",            RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>>>        SEC_DEF("tp_btf/",              TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
>>>        SEC_DEF("fentry/",              TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
>>>        SEC_DEF("fmod_ret/",            TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
>>> @@ -10411,6 +10411,12 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>>>        char *func;
>>>        int n;
>>> 
>>> +       *link = NULL;
>>> +
>>> +       /* no auto-attach for SEC("kprobe") and SEC("kretprobe") */
>>> +       if (strcmp(prog->sec_name, "kprobe") == 0 || strcmp(prog->sec_name, "kretprobe") == 0)
>>> +               return 0;
>>> +
>>>        opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe/");
>>>        if (opts.retprobe)
>>>                func_name = prog->sec_name + sizeof("kretprobe/") - 1;
>>> @@ -10441,6 +10447,13 @@ static int attach_kprobe_multi(const struct bpf_program *prog, long cookie, stru
>>>        char *pattern;
>>>        int n;
>>> 
>>> +       *link = NULL;
>>> +
>>> +       /* no auto-attach for SEC("kprobe.multi") and SEC("kretprobe.multi") */
>>> +       if (strcmp(prog->sec_name, "kprobe.multi") == 0 ||
>>> +           strcmp(prog->sec_name, "kretprobe.multi") == 0)
>>> +               return 0;
>>> +
>>>        opts.retprobe = str_has_pfx(prog->sec_name, "kretprobe.multi/");
>>>        if (opts.retprobe)
>>>                spec = prog->sec_name + sizeof("kretprobe.multi/") - 1;
>>> @@ -11145,6 +11158,12 @@ static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_lin
>>>        if (!sec_name)
>>>                return -ENOMEM;
>>> 
>>> +       *link = NULL;
>>> +
>>> +       /* no auto-attach for SEC("tp") or SEC("tracepoint") */
>>> +       if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
>>> +               return 0;
>>> +
>>>        /* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
>>>        if (str_has_pfx(prog->sec_name, "tp/"))
>>>                tp_cat = sec_name + sizeof("tp/") - 1;
>>> @@ -11196,20 +11215,34 @@ struct bpf_link *bpf_program__attach_raw_tracepoint(const struct bpf_program *pr
>>> static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>>> {
>>>        static const char *const prefixes[] = {
>>> -               "raw_tp/",
>>> -               "raw_tracepoint/",
>>> -               "raw_tp.w/",
>>> -               "raw_tracepoint.w/",
>>> +               "raw_tp",
>>> +               "raw_tracepoint",
>>> +               "raw_tp.w",
>>> +               "raw_tracepoint.w",
>>>        };
>>>        size_t i;
>>>        const char *tp_name = NULL;
>>> 
>>> +       *link = NULL;
>>> +
>>>        for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
>>> -               if (str_has_pfx(prog->sec_name, prefixes[i])) {
>>> -                       tp_name = prog->sec_name + strlen(prefixes[i]);
>>> -                       break;
>>> -               }
>>> +               size_t pfx_len;
>>> +
>>> +               if (!str_has_pfx(prog->sec_name, prefixes[i]))
>>> +                       continue;
>>> +
>>> +               pfx_len = strlen(prefixes[i]);
>>> +               /* no auto-attach case of, e.g., SEC("raw_tp") */
>>> +               if (prog->sec_name[pfx_len] == '\0')
>>> +                       return 0;
>>> +
>>> +               if (prog->sec_name[pfx_len] != '/')
>>> +                       continue;
>> 
>> Maybe introduce a sec_has_pfx() function with tri-state return value:
>> 1 for match with tp_name, 0, for match without tp_name, -1 for no match.
>> 
> 
> Hm.. tri-state might be quite confusing, but there might be some clean
> ups to be done around this prefix handling for SEC_DEF()s. I'm
> planning to do some more work on SEC() handling, I'll do this clean up
> as a follow up, if you don't mind. Need to see how to best consolidate
> this across all the places where we do this prefix matching.

Sounds good to me. 

Acked-by: Song Liu <songliubraving@fb.com>
