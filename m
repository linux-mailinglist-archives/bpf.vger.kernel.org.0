Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360E15A30F5
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiHZVZx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbiHZVZv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 17:25:51 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631603FA0C;
        Fri, 26 Aug 2022 14:25:49 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP9kQ007904;
        Fri, 26 Aug 2022 14:25:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=XKr8MvdDSqRG+K1j/hFPHaDNw9OYx/qZJOz3KI86wVw=;
 b=k5yrhyCTO0yXWp+he24WMLs2aOPCZ2cY15rAh/oIbT+Hw7lx2zGlaDrss2BldVQgptt2
 OADDjcK96dxnJ9JeGnVIfZT4u35nyPY0Hb4A6yRiVhPlFGhr8cdBttTXEnD0JZKrYVy9
 0ZU5YJk/uc4HZSevW/3ZQ67IDv4GiiK1PzA= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6rwdd49h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 14:25:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWi6HWtXRiQ2SHTMEoioc9DS71AoDKW30Zp85tWBlqgJmYk2MjBBnWIl7FVn4zyCQpR1vfu63BXr+PoVy/r0bAJ6qUxHwJIJrwljTmCyiE9G76i7ENZR4rlVPjuuy8A9wzCZKnyKQd5MjZN1NS8ghwCn+9XZ4qHAKsbKtmXC4CLDp5mospxF2gtk/AZjGjiUiBjYx9xKGB/6LyAq3bmLfHCY9rjmFuknXfdOuXCvPLXX4KKNKXgItwhSwbNoMHylIDlVMLPJacIZsoniGUDmYQBoLno94iBjayoIpKm5wk6wuX8Gdzkhg5IZkpoUY/nAv5q46I3NsJJ5px1FaQtV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKr8MvdDSqRG+K1j/hFPHaDNw9OYx/qZJOz3KI86wVw=;
 b=Z3mfty4NaphEyI1TZCkjbo+i6Sk7N/+NvRjtNbi117iO9JrcYB6myDJxtkRG+si8qyoPKWkHMfBKJz/8NPTy+pgLc8ErW+c85PNZ2osITF9TV9A9fbepIB2lnqzoQIF3W3gNZtjd4ytTLPcMjDid1Jnm3XaxypdGbCtibwhLpSIf8EBcuW4eGpMlpKrkiFOsQd+9OGAr9+qM5mPBK2fZvUdl77htjpJmnuzN+XvmeothnoMBuQ30H78y9/e/tre7H6J6yLBptSE+oMGgpP+SsE4O33KyXVPXKadiiRMR0qNMMGztkEpZGkNLQUUvPQ6Xqr77A0p+cJs8KKI60IOdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by CO1PR15MB4939.namprd15.prod.outlook.com (2603:10b6:303:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 21:25:45 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 21:25:45 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Thread-Topic: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYCAAA9aAIAAO0MAgAAulQCAAAilAIAAsuMAgAAazgCAAAnxgIAADKuAgAAYuoCAAAP0AIAAA5MA
Date:   Fri, 26 Aug 2022 21:25:45 +0000
Message-ID: <1CA3FC40-BC8D-4836-B3E7-0EB196DE6E66@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
 <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
 <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
 <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
 <FCC75F8E-4C2F-42A4-B582-9BE3BB87E15A@fb.com>
 <CAM9d7cj6YNTL+u38PZjhPF2Qg_BYiJ1NMmDkPDx3N3Xe+ZTbyA@mail.gmail.com>
 <FD49F694-10FA-4346-8303-E1E185C3E6E4@fb.com>
 <CAM9d7cjj0X90=NsvdwaLMGCDVkMJBLAGF_q-+Eqj6b44OAnzoQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjj0X90=NsvdwaLMGCDVkMJBLAGF_q-+Eqj6b44OAnzoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08c7b429-8830-4ab0-94b9-08da87a989bc
x-ms-traffictypediagnostic: CO1PR15MB4939:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JGay98UF9mVKwKpTtNXYEo03XZtnewsGnAAU0E78yYAObAVGg0hsQ+EhMXn3v0qSbBYvEGp2LUihu2KhDkRaiYCaOa4gqef2bk2Xrqk7vFqllU33cYQSa4s/0NDLhQa5w4N5bkflzEiB9RrXbEhVjd3BG8lgKkCzzQFlO7XjrkNlokPfGbgvdEMyj14fn8rjZyB9WLMcpcTQdt8AwOuwwPFAAVUvQTQHe5egefsxHqxlyUAAvkVh480ST5APUGIAw/X5nYlZTlb9GZ6Pugj4bL2PpKVaZ6dg/AQeKUsrmFFrQcD8lllGDiTIoUUoFaNcg28Liav+6yHvP3v2sZ9qriWy+Z0nyVESuw/F1tqwboICfCFSDFnz1k4BKuifiogZzcJPWLiSvaZjxL68jguxncXmqvaYmG/DBSVjO+C+POsmCcP5JG9aH6gXAfY4AGAP6QQmTMW27gM3e6hxPWh70hQfi6NcoDpf74XkCyxaAF9y5iRRru6ulvtJqJc19zJE9bRNH7yJOdjaUwdduc70wHFUE2ODW1THdvNgKbIfcEZiqrooAu67zi/I86v5KH/F6XJGBmahbhgHue9YTNenf6y7ZMz/ksqImzmviMhpwRRNxQblEdSZbE5qeLlt0dJWQsNoblhc0lqLyrb7rM/ww2SdkFgDqkM0L9YwjDXJtk8XFOCXAuteR80IjFH0kLTKmsos2at5b8BydDA7DoM7vIVN3Kc1bNB557EEdMgVpt5tBdFkZjA3syVg8WGGE3QEOVC0h6rmRtRah8KFPfy6U+q1+oIQe8jbmRxWdJYzXGGzPq7klib6riyzllK8Y2bGgIj9G7AQKhecQ+TGi3Kq/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(366004)(346002)(66556008)(38100700002)(122000001)(66476007)(66946007)(76116006)(38070700005)(186003)(66446008)(64756008)(4326008)(8676002)(41300700001)(2906002)(71200400001)(2616005)(53546011)(6486002)(966005)(86362001)(5660300002)(54906003)(7416002)(316002)(6512007)(8936002)(478600001)(83380400001)(33656002)(6916009)(6506007)(36756003)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RdnFflkZCnVWI0AvdocUDQqyRDWJt4YCDO7Ho0NN354AsdqpNbwC0Uv78jer?=
 =?us-ascii?Q?hcy6uhxYBrp0fWhA1Uae5SSbnL/4+quy5G9nhZt1ZMEye1URr4nG4wNo43ka?=
 =?us-ascii?Q?pyGLMeqS73Mk+IdkFeeBFMOHeVgceKCl1Y4wQDNnk6VPZPFPW+1P35+TGYEU?=
 =?us-ascii?Q?ijb20lFmQC7V0Py8qb5YXyozhQSOZK3WDR+NHh9jMfGILqql+UMHBgz4puTm?=
 =?us-ascii?Q?tBSVHe4SZN7OIiM5Sm6lX1+vWjDyUPyy8+4zRCF9IZc8slh04j/vC2S4y5br?=
 =?us-ascii?Q?PgAayIMMtAx/pjT4iMpGHV7grUPzxn0AXJ8K3/9sZ4uX6dlls54LkCX3MUOf?=
 =?us-ascii?Q?ndjKDSL+N3EDjOPc1fVcR4Vfu/iziQnJdIZchDxRYSDdotAcnfzihw+D0XR9?=
 =?us-ascii?Q?ekN0cVCX4aywecuXrs6Vseler/LmXQLwS0cZh7BME9tlwSFzO7VHIcvqozHj?=
 =?us-ascii?Q?xrT++9MI5NGd0XLCpTfUfAUmuDTEjGjTldl1d3DBWC5obmJ1Qo2shQhtUL0g?=
 =?us-ascii?Q?LKAc2GoLzKwW9dluJV5Sm+PnDCLQfzUMfDVXIZUS+4ejAutUud3h4kbSHSJ+?=
 =?us-ascii?Q?EpBw5/IiJuL2dT/hKoPfYoQOD4HSrrUeAtreYOQt1oFQxIywyrvgKfbIkEdM?=
 =?us-ascii?Q?FkhHoYPkcZ295cb6WDdAvty+1ypH5gdm+4fTWDNf6rxlXLnwo/0ZB6B7+6Xe?=
 =?us-ascii?Q?vimeCDDRzGI2Qk2mDWasDqq7Hhb5cQzA75coUWx3pQVsFXLohgdQaXtHcQ4u?=
 =?us-ascii?Q?UqNBwqqxqoFf7CJnptF6iMBsnVIJ3iw2K3qJcphRqqyIbLYGjc48/5k072vN?=
 =?us-ascii?Q?xRFBw41esZ8YqEYN7oyWFP83E8snGncKq3pJEM9J8EvfXJuy/4WClYf3cHFz?=
 =?us-ascii?Q?e+k+7pw5iPSJ6Y59Btyhti0sW4Vv07W5Vu5tr85L+8kPrIP2J1WbkV99/ZeO?=
 =?us-ascii?Q?X4JTkq07LnK+cn2hYfjCjuVYQBzE+ZaRehfUsjmHxAP2kWja8LmM0FPBJZFp?=
 =?us-ascii?Q?1WhbAm68u+Mzl0RtHG4QN4ZmP7O0a0VVhLmzzLE0NGjxi0DeXBbR4jmmFAEp?=
 =?us-ascii?Q?PmMjN3sfU8Ifg0mjYO7SLckJ1jHrMq3AG3abEvDqXIpa6w0a4a8xn1pyXqU7?=
 =?us-ascii?Q?QGp5jThrJuEevrPyq95/dB8aZXmNmtJBFH2qRW839H7FU4l7AUh6agfO3mhQ?=
 =?us-ascii?Q?gzoPiVoxOtYoLndhK35YGibOW2SRui3yn8MEkIFikLQCzpwAM4/1wXZdn2v5?=
 =?us-ascii?Q?ksqeEtqerxa+VeN2eBVfLv1oP09S9zh0v0AGAz3h2EeLlq6pnccD8JK3hOnq?=
 =?us-ascii?Q?3kNL0TZtbwhl/8ZZzEgDPktWvhDVtc6QKubkCiiAXSoauOb6f9aq+d0tHoeT?=
 =?us-ascii?Q?k2M3UNszwG9y9yEmomaVNQIxMhOFEp4AF9WpB0F61UBc0n8jbJ71aEZ5W2VG?=
 =?us-ascii?Q?9+BYGeEM2L15sqpff9iGzn3T46BXFcKGQc3uAIXY58j+OgeW5irwj0+mglH3?=
 =?us-ascii?Q?7lrZn4/yl22XgTXZTrOwHHKEheWnt1eAGtdTdWGBYgSDA8E6h3vO7RXw8dUb?=
 =?us-ascii?Q?orzliRZTDAkfzGRZ1pjXvm+zVmIGkAIqJDUFU9zOXY/Z8JvZSF7jL5WTb1PW?=
 =?us-ascii?Q?d0noBAvjikR3TA8v92LrgYI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92FA177B16382842858C4B8D9208F5EB@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c7b429-8830-4ab0-94b9-08da87a989bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 21:25:45.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClhJ91MTDpxsZuledqSpEdIWy8KkPJCvgrvtSZfyDb8p6KxqpDLdOlpfhPir7XtJPJW0JKYVzBLum12VdLd1Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB4939
X-Proofpoint-GUID: j18Fr6RWHuw-CihyJiQrp8R6QOfBaWwe
X-Proofpoint-ORIG-GUID: j18Fr6RWHuw-CihyJiQrp8R6QOfBaWwe
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 26, 2022, at 2:12 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> On Fri, Aug 26, 2022 at 1:59 PM Song Liu <songliubraving@fb.com> wrote:
>> 
>> 
>> 
>>> On Aug 26, 2022, at 12:30 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>>> 
>>> On Fri, Aug 26, 2022 at 11:45 AM Song Liu <songliubraving@fb.com> wrote:
>>> 
>>>>> And actually, we can just read ctx->data and get the raw record,
>>>>> right..?
>>>> 
>>>> Played with this for a little bit. ctx->data appears to be not
>>>> reliable sometimes. I guess (not 100% sure) this is because we
>>>> call bpf program before event->orig_overflow_handler. We can
>>>> probably add a flag to specify we want to call orig_overflow_handler
>>>> first.
>>> 
>>> I'm not sure.  The sample_data should be provided by the caller
>>> of perf_event_overflow.  So I guess the bpf program should see
>>> a valid ctx->data.
>> 
>> Let's dig into this. Maybe we need some small changes in
>> pe_prog_convert_ctx_access.
> 
> Sure, can you explain the problem in detail and share your program?

I push the code to 

 https://git.kernel.org/pub/scm/linux/kernel/git/song/linux.git/log/?h=test-perf-event

The code is in tools/bpf/perf-test/. 

The problem is we cannot get reliable print of data->cpu_entry in 
/sys/kernel/tracing/trace. 

> 
>> 
>>> Also I want to control calling the orig_overflow_handler based
>>> on the return value of the BPF program.  So calling the orig
>>> handler before BPF won't work for me. :)
>> 
>> Interesting. Could you share more information about the use case?
> 
> Well.. it's nothing new.  The bpf_overflow_handler calls the
> orig_overflow_handler (which writes the sample to the buffer)
> only if the BPF returns non zero.  Then I can drop unnecessary
> samples based on the sample data by returning 0.
> 
> The possible use cases are
> 1. when you want to sample from specific code ranges only
> 2. when hardware sets specific bits in raw data

I like this idea. We already using BPF in counting perf_event. 
Now it is time to use it in sampling perf_event. :)

Thanks,
Song
