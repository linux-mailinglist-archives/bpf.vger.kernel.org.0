Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15936189F7
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 21:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKCUzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKCUzi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 16:55:38 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D0114D39;
        Thu,  3 Nov 2022 13:55:38 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3Kp2qX021734;
        Thu, 3 Nov 2022 13:55:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=tTWS0I7n6PDEfMt4wLbY8HrQPfQdBbKQif+OBNYDSr8=;
 b=P5dr3H2SvywZ0Bt9Za1E3E74uTMkL7QFT7h12VmLfdDfI3KrrJwdrbjECe9e8pwUV74W
 KsAowPPvVWHoJobTr9QWN6ipCNyQlu+NAl+D0bKci19Lnme8pfilJrQzqidyE/+a3xFa
 84fj3pOieGh2eevgNJPrKVoSVDWufQz7u9NLw1s02Ed+yshvql29gazia5LnvUneDAc+
 5DPkVQsL94ICgn5l+SNh684eUq1EELzi/oYywJK8eTnKXI6ToBTh5iOsCR51yDWLQ/Rl
 Re/Cbz4r8ap+tPWZpjWye6AapmNHPS6VjLIfRzsm3V4rviUsEFOxy+z1zXmMTJNqeJLt lQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3km3ubrt6p-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 13:55:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0COAMs4vnYyImycEk2E2KnovBh9nOh/t2avBs3DXhMcABcmIGGdD5dcutk2EKXhtmQbnudANGHiW5lfqFURLRfqxhUssT2SKWHghCLAAJ/XiwPJG7JOXsh1GfpEDB4WGA3vWAH3NvVdsvddWeuiwh44b+IWkH2ADmbnRMtgaPqHBd2wS0zM2P+8d9xCwdP3/H45dDbpL2bNxGFF1XzmG81BuAWAbuxTYuCQIqh6MpX7rZ7GSYE62qdVMWKQHSfw9cRfFKNxMjMZNzjs9qdaVDBI02e+ZkssWqVQ1x5zql0Xk+QP845+J9umsiK9PCPs8FjdD7VI4mn7kBgIzsykvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTWS0I7n6PDEfMt4wLbY8HrQPfQdBbKQif+OBNYDSr8=;
 b=XUr9b9GsU6+IwNpo7hfRLeoTw4wVKk28Wx2IxHrW1VB31WDs7jviTerff021ye++zqWV7yJyWbI6XYI1acPWzWMQr+Zd0iz/DtuqCPbbjIsjsyXiZ3srhc2Rk2Y7lE1V5gYQvUFRFATp0FHi9wuWbPXGdhteb0ZGrAKbLFIaXTShMRUrBAh0a6kqmsLSllgCfMPlSX5+inVb6FS8sBoVhHPsDXPHjvGX3D+k3yam1WUr6Qr2jO7BM0Gq7c9DJM9OqSmkL1f1684ypnPb/vYGouXZZnKNf6vJ07Iswp6g1nbeG/6KDh3iMkScF8uLpLYCy8OoRo0r1cdlAF/tX7K24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN6PR15MB2319.namprd15.prod.outlook.com (2603:10b6:805:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Thu, 3 Nov
 2022 20:55:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6b5b:7834:b62a:7e83]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6b5b:7834:b62a:7e83%9]) with mapi id 15.20.5791.022; Thu, 3 Nov 2022
 20:55:31 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Yonghong Song <yhs@meta.com>
CC:     Jiri Olsa <olsajiri@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Lau <kafai@meta.com>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample() helper
Thread-Topic: [PATCH bpf-next 2/3] bpf: Add bpf_perf_event_read_sample()
 helper
Thread-Index: AQHY7bIh+3DV6iFa6kqnISpuNujMVK4p1tMAgAPHhYCAABN6AA==
Date:   Thu, 3 Nov 2022 20:55:30 +0000
Message-ID: <CF3D88C5-4D62-48E2-97AB-F6A7FF9CEF9D@fb.com>
References: <20221101052340.1210239-1-namhyung@kernel.org>
 <20221101052340.1210239-3-namhyung@kernel.org> <Y2DuzmnUm6NIh25a@krava>
 <5b0152db-8a8e-0d8c-0304-8c48b735c3b7@meta.com>
In-Reply-To: <5b0152db-8a8e-0d8c-0304-8c48b735c3b7@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SN6PR15MB2319:EE_
x-ms-office365-filtering-correlation-id: 294f3fb3-e309-4100-b612-08dabdddbea9
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERx0OYOghG3hEndH2r5V/E3Akdf6qYqysK/VstKmn7gu0LSSiyUWbTyFfPRzmK/oqTTD/exzXZhy1n42xGLKxRQa4P+AOup845r6AoEosE09ZhlV4EP6vmE7Isk80ZUtKTBjgoj/12mCJwTZvch0ju5SUpDDlP0OARnERrZz97X6Y5qqqsIc7LRrk12mbTv2bpfRnVIoQDOQQDHdjI2cXEIU5TweKbMDOkJkrKR+pU5n1/g2F786z7iLhVl6A3HFTv58BKDzRVTGcwhFUZdljlN9fXdfROv6jhxoHmf5UQD7XkkqaY5tXP7jmdpDuoESvZ84psrTcCSKtfNjC1V6U5n3SwvD9X5xCn273QINzwYas6nYT5rguGzz96abfDeSYoOGl2SrICoAxtmn36FVtMecX37KB6o+Hd1UYKV3FoBPSIMwe2rJ4LbPlhO9GcPJH3VcYH0pGss6swY147D99BHA/cKu8o12zWzsXcGAG2mVvGBteTJPLco69y3gDnqn0F/GOk3oJiBtrCM3jZQ714pFR2vG0TdYq4zYA82TEafd66enatKyKFWfvC+bFRJ1A0csCcno6UNfRygLapJ+n1ovI46AHpNTMm5AVtvkCT1Df8gd5EGxsRLl22OsY2k0cMoSymOxsIxC6qziVulagPhSdZoxQ9OONL7vZa0eRfnkTiz6MbuWBK3ZO4AGl2Bphjvb0tCgiY2bxAHas95LsW2NptlwsneGC2K4z3cQrKiGT039rMQUm8jL+Bp0We6UJMDLx4wJxNKUxoQj473T0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199015)(36756003)(66476007)(64756008)(7416002)(86362001)(83380400001)(66446008)(5660300002)(66556008)(186003)(41300700001)(76116006)(8936002)(33656002)(4326008)(38070700005)(6862004)(91956017)(54906003)(71200400001)(2906002)(6636002)(478600001)(53546011)(6512007)(122000001)(66946007)(38100700002)(316002)(8676002)(6506007)(9686003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OqEHS3uiQfeDsr+bMbhHSWvXJLUBJ39JZN++cqVreGsNWo0eQlfsxsm2DH5U?=
 =?us-ascii?Q?V9q6wk1p28mF6TJeZ6A/vFhZB4uI+Zncv9T2rPl/McizX4gh6/rFKzkC4v8v?=
 =?us-ascii?Q?TyXCPVtjvwId1+N+k8hxrI9WJh69ePPWd8RWHFEm8zU+LOc/LqV+069hcXuG?=
 =?us-ascii?Q?qdJfCaVWkxGb2gtBl9GRM9shGqVLKrtXMiI0PzMbHBPXQR0tj+nAjz11hN/s?=
 =?us-ascii?Q?c/0R1tYpHC9JL93mhFPoGO3vj6QFWujpGf9rNZz3R735sWwN5puX8SvCpMZc?=
 =?us-ascii?Q?94FLA1FGzCattEczw12bLA/i3TZ0qaXqBFaWQWfFh+C3+cjRxiPxfIihZz8b?=
 =?us-ascii?Q?ZpgsQ3rdMvrjrhKR7U3ZglRUZJ+8Dz8C7ayoaDj670kyPk/nM2qdXUzkpDUf?=
 =?us-ascii?Q?EdDLL16DFZO6L692THPoRTdLPUSnVoOSIsF/r94475PEziJU5IYdZSsLwg9t?=
 =?us-ascii?Q?P/QMvxJIlpcCPzGT44EE2v/xX4zITI6ypWxdNSHVdSf1HvVq1pl/cXDmySq5?=
 =?us-ascii?Q?bUqPUrzrjcKbx2R6BQOS4GfzRaPBlin68ZXkVsbPcnz1tps5U0x0HfRhe/x7?=
 =?us-ascii?Q?PKXoLIM5IN/DrqIYHdKBfW3yerl0tbQcq9Ch6VD7Z3WUhIxtqyGZskd2lC63?=
 =?us-ascii?Q?dg6iTXAkzuy2AdouJfhiIXZ/NuefzsMpBXfoB1oS9hfIwVJpkTGk0lv044WC?=
 =?us-ascii?Q?C9ec/FQm6SnYgkVD4EQdrYEuXEh/Z+Im5IUoLOlesk/nNPbfWv5pLiWHjLFF?=
 =?us-ascii?Q?FsMrIIuf2OJlU95V3PwQ4/XBerM0xaCfxqsKWlOgLyF9EPNCwA5TKTqtMtPj?=
 =?us-ascii?Q?BPRwoL2te+uZi2pWAw3n8rkSsf+yXWChV8hOLifvY6dx6H2K9Nf06/PFPXY3?=
 =?us-ascii?Q?230M/GZG8LA6fCwByjkvpLoiCRhBEOU6KpKPuNj9SgLMq7A/Y4KoG8BIKL/V?=
 =?us-ascii?Q?YRyh72l5X/LQ7HiIfKAwoYxpz2Mc3ou8x5yNP9RvzDB8gEkWPZybG9sBohDs?=
 =?us-ascii?Q?jxNhdddQ1VLU5wOQA8rNc60z8m6or0XkDLmPrxji2mvm49YhYTUPlSrNlM06?=
 =?us-ascii?Q?Jxn5iznzBZMZ3E5Rc4BLAUNh2X3vBKivPac04ZmSPouNe1fCDodmz6ueTLj5?=
 =?us-ascii?Q?3Ny53glmRzysTZ8P00LleDLVoK7agxw+lS+4YcX0JWeF9QEdohoIlBSVhX7q?=
 =?us-ascii?Q?9glT6/zOhhq2gxvTypDM7TMpqJoBJb8dCtC+zs18kPpdHYMNXnmqNyUe1Pyi?=
 =?us-ascii?Q?JaSpfFqmaUnMCcDwL906aWEk7PeiFQcUvdEFp6rNR5j0nHqKfxyyGMgCRuTZ?=
 =?us-ascii?Q?RATfBJML9Q8nOm1DFOESeYYPmjofE7olbGcdMN+qbIns5IrwzzjoGiQxc9uS?=
 =?us-ascii?Q?qt61HOMNfYRqDijuKFKq3Rs6wc/Zdh3BOf8gFKWMvz5nRe9XVmiR5vvK7pFT?=
 =?us-ascii?Q?gzIT7Olm2FEmT9af4Ir8je0nkhrvFLemYvTtjmsbd0W8x6D1MdvQ9sm3ORMS?=
 =?us-ascii?Q?ble0qFGElpvmK9lMEsJaHKfnozVCue0TMXpcMbTHo24vzG0VRRlGNMBuN6e1?=
 =?us-ascii?Q?sVxubdTjbu5mm6O+Rk+V8kJsMqTrXr+jZn0Fpepk8nJlsawvEkV7jLaUV+//?=
 =?us-ascii?Q?8w/kmYZgKExdAicfCShxMeezcpChaCFFwoXw3rafuv/M?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B05C816488A38A4CB7BC12176E5423B3@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294f3fb3-e309-4100-b612-08dabdddbea9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 20:55:31.0093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B/+Hic3egJxVAzVrPyXA8JUGP4mTLYMTGIgv8KXjuz6qupNf5pZfk+4ly+WVTURB0Oi4bBwSwwDURlNjN1mIFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2319
X-Proofpoint-ORIG-GUID: CBFYtKwtLvgiT00XWqpPPqWuNuUaO6dK
X-Proofpoint-GUID: CBFYtKwtLvgiT00XWqpPPqWuNuUaO6dK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 3, 2022, at 12:45 PM, Yonghong Song <yhs@meta.com> wrote:
> 
> 
> 
> On 11/1/22 3:02 AM, Jiri Olsa wrote:
>> On Mon, Oct 31, 2022 at 10:23:39PM -0700, Namhyung Kim wrote:
>>> The bpf_perf_event_read_sample() helper is to get the specified sample
>>> data (by using PERF_SAMPLE_* flag in the argument) from BPF to make a
>>> decision for filtering on samples.  Currently PERF_SAMPLE_IP and
>>> PERF_SAMPLE_DATA flags are supported only.
>>> 
>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>> ---
>>>  include/uapi/linux/bpf.h       | 23 ++++++++++++++++
>>>  kernel/trace/bpf_trace.c       | 49 ++++++++++++++++++++++++++++++++++
>>>  tools/include/uapi/linux/bpf.h | 23 ++++++++++++++++
>>>  3 files changed, 95 insertions(+)
>>> 
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index 94659f6b3395..cba501de9373 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -5481,6 +5481,28 @@ union bpf_attr {
>>>   *		0 on success.
>>>   *
>>>   *		**-ENOENT** if the bpf_local_storage cannot be found.
>>> + *
>>> + * long bpf_perf_event_read_sample(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 sample_flags)
>>> + *	Description
>>> + *		For an eBPF program attached to a perf event, retrieve the
>>> + *		sample data associated to *ctx*	and store it in the buffer
>>> + *		pointed by *buf* up to size *size* bytes.
>>> + *
>>> + *		The *sample_flags* should contain a single value in the
>>> + *		**enum perf_event_sample_format**.
>>> + *	Return
>>> + *		On success, number of bytes written to *buf*. On error, a
>>> + *		negative value.
>>> + *
>>> + *		The *buf* can be set to **NULL** to return the number of bytes
>>> + *		required to store the requested sample data.
>>> + *
>>> + *		**-EINVAL** if *sample_flags* is not a PERF_SAMPLE_* flag.
>>> + *
>>> + *		**-ENOENT** if the associated perf event doesn't have the data.
>>> + *
>>> + *		**-ENOSYS** if system doesn't support the sample data to be
>>> + *		retrieved.
>>>   */
>>>  #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
>>>  	FN(unspec, 0, ##ctx)				\
>>> @@ -5695,6 +5717,7 @@ union bpf_attr {
>>>  	FN(user_ringbuf_drain, 209, ##ctx)		\
>>>  	FN(cgrp_storage_get, 210, ##ctx)		\
>>>  	FN(cgrp_storage_delete, 211, ##ctx)		\
>>> +	FN(perf_event_read_sample, 212, ##ctx)		\
>>>  	/* */
>>>    /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index ce0228c72a93..befd937afa3c 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -28,6 +28,7 @@
>>>    #include <uapi/linux/bpf.h>
>>>  #include <uapi/linux/btf.h>
>>> +#include <uapi/linux/perf_event.h>
>>>    #include <asm/tlb.h>
>>>  @@ -1743,6 +1744,52 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
>>>  	.arg4_type      = ARG_ANYTHING,
>>>  };
>>>  +BPF_CALL_4(bpf_perf_event_read_sample, struct bpf_perf_event_data_kern *, ctx,
>>> +	   void *, buf, u32, size, u64, flags)
>>> +{
>> I wonder we could add perf_btf (like we have tp_btf) program type that
>> could access ctx->data directly without helpers
> 
> Martin and I have discussed an idea to introduce a generic helper like
>    bpf_get_kern_ctx(void *ctx)
> Given a context, the helper will return a PTR_TO_BTF_ID representing the
> corresponding kernel ctx. So in the above example, user could call
> 
>    struct bpf_perf_event_data_kern *kctx = bpf_get_kern_ctx(ctx);
>    ...

This is an interesting idea! 

> To implement bpf_get_kern_ctx helper, the verifier can find the type
> of the context and provide a hidden btf_id as the second parameter of
> the actual kernel helper function like
>    bpf_get_kern_ctx(ctx) {
>       return ctx;
>    }
>    /* based on ctx_btf_id, find kctx_btf_id and return it to verifier */

I think we will need a map of ctx_btf_id => kctx_btf_id. Shall we somehow
expose this to the user? 

Thanks,
Song


>    The bpf_get_kern_ctx helper can be inlined as well.


