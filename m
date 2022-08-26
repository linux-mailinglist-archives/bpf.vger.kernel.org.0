Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C705A1EDC
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 04:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244807AbiHZCfi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 22:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbiHZCfg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 22:35:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FB229837;
        Thu, 25 Aug 2022 19:35:34 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PM49Fs025160;
        Thu, 25 Aug 2022 19:35:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=kbl3nFTFYD5w61SoTqnZFMDC4+sIJHpnK/758f8w4Vg=;
 b=p87OYC1r3W9Lefmbz7uAkzk4pdxqlTJqYo3Q8E60Pae3RXlhRfdR5HMCrqkNMCmIhzUU
 F5AcpOQFhVWILi56wCaT/55mrjvr3tsqk2t/m2vM9j3ePsS8PeesyABYVw1zjjZYiDxB
 v89SJrMI8qWf+OnfGHDBIoCU+/ELPN3rqMY= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6enwakkb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 19:35:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ds7IFsUT7MWq/HIFgQmYVv5QX8bl4pBHMAH47NzPJuPQplp6UBTzMuFrNqkRdWJc0SWF+ZOLRYW1ji13iryqCzhh8FVVTWrnT9fNxX/Lvlmmhp1DYHrGhS1siwOMg88a8OH+00XOllD6LAzo4vgjDVifMTA9x2UzKTVsMgUwDZ8+Mb5IEqRSPhD1w9cNZlW/h5bo4vixS0h97lCW+6Ncz1kQG1E+NIi9YInyOy4qr2QH8ZyP3TMCQFdJJat/ldXn9zCmh5ZDzEp4Jpj6nCil+lhpBfvVt83pF6ooIgJkEzcT++s4ZjRnktThmmO3ujXdej2rXlnBnWcFkn30cTzJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbl3nFTFYD5w61SoTqnZFMDC4+sIJHpnK/758f8w4Vg=;
 b=CO7dzrXfTQJzNF9JyCaMa4g9nC07jxpBKJqLqQ6sjdhZ/DBCUTmVWnsg7+J4huB8PijHAzMsgJoobqRBM0gjtOJeC3ZK2wEXABehRt9ka5/sOl6TIUaTWPzUVodJpir07PzixDf5cf3BKaIo3r6vWaWKeT2jB9M9x86+DxrB+LjQqX9QsV2+kdtrlokTjFnO7jGFOV/lT9csBf2Z6+z2NwG5WBMIC34NReu3X0PXWZz7Ooic+y2AlmFFAM2oguBHn7/DRWfPCOMJr4Cv2B4xen8EPCMWKY7VIJ9H7ZEOZdzUqUP+tLda6kG3hAGkeoac+L50qxvzKmMfkZYN6UkF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN6PR15MB1842.namprd15.prod.outlook.com (2603:10b6:405:4e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 02:35:31 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 02:35:31 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Namhyung Kim <namhyung@kernel.org>,
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
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYCAAA9aAIAAO0MA
Date:   Fri, 26 Aug 2022 02:35:31 +0000
Message-ID: <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
 <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
In-Reply-To: <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7a0b8910-87a2-4f35-d8d1-08da870ba527
x-ms-traffictypediagnostic: BN6PR15MB1842:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Il4SflNgP40oOJIrRVoHAoaE2h0eZDWs9619oyi1yB7+01LKBLPbh/RZSM98dkX4j+Ywkk2+Hb4ixvckuSSSCM1dCSDsPS/eByIexg2+X0DcP5N70WtyyZHy+fhhTckOoiadEdudXzl8eKwNMlpB0KB5PNChPh0+CJnxM2nL+jmpqpBRBDLWkVdy/aoMVkiVFMczcUH03/x4aU4zuJFv3NYHshV3HpHkNq6XfQR6ROud1g15TF92XsjKMGgSQCX9pPX7hCLbM4p0EGvTbKKxEzmyzNEuZsf1bAyaq7qxSRjBh07pnD4iNK6mByvf+OAF0FESUYUh8rCE62gZzqXgUoiF39GnfmtKcFQ08Wsjd64M/kdAPqzriv/IUwCWzmZDuxYNYj39EGR2CDDf+EUUWSfkq5lHTcKDMurVJcq2oZFxvp0UdvwL9v+hONCSRT5ns4tUp2rfrA0hbNhnhSiVpi8NT+gK5GzwIIe1DB2aU60sHNYEb3Cxt36CKuixjL7AyyUDMn0W5V2LvP1i2H3axVFxZ3YCszW1iLTynnYlcFczcFlcKbPDC3difFVWdaz1WNhEAZjwJjpJOXN6kNMndOO7lZuYem9Vw+0x2vSibT+y9iBjQAPDusxfFcEcc91/VT0w5tiQXS1+l/R1fInhM8RycryvvCApVlBLUXdO00GtUU/bKQiAWxKu50BqqJsYtsC8J6ey4knxZtS8MDCV/RuZmhUzyvBDi4dLIPxYVbsl9kAi7WGCTknqQZp762iEt3BdvE++ApCe/VHg0GIOAf0gaH4IQY/RhQoJBQv7+o0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(186003)(36756003)(33656002)(2616005)(83380400001)(6506007)(6512007)(122000001)(2906002)(53546011)(41300700001)(38070700005)(478600001)(91956017)(38100700002)(86362001)(7416002)(6486002)(8936002)(5660300002)(316002)(54906003)(66476007)(8676002)(76116006)(66556008)(6916009)(66446008)(71200400001)(66946007)(64756008)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gK5Iq9O4skcjYbmOPqotjGBn+ePOYiNB0Eslsr+sM39pFyFqF+04d5QcDtio?=
 =?us-ascii?Q?LZvVoQPHzaLxg+Wh2XjQatTPJ+0byu1K2U7CsJ6yyXIen3xqnEaWLl4Yzotz?=
 =?us-ascii?Q?03dY18F/Jf39N3Y0AZxg0EP7l9LM8hGqV2hCQmGzRn4YtgwcW7KdnZgh5Tc3?=
 =?us-ascii?Q?UKFvo/kSl2WAzt4SIncucWrCA8AzdqqKe0tVTg19fxI7pHXUjxQZgAhUp/Nb?=
 =?us-ascii?Q?fWdCfxxu0Xy+DytvOh0AMiGF95K1qJNy2X3WL0cIYI6TBeAk+G/rh9V/QEyL?=
 =?us-ascii?Q?N7ZkMf2BHHe5gO+gqvgikY70lDxBhZU3pLLNNJb3e2tEYKjSZ1kpeqoS8XsO?=
 =?us-ascii?Q?OyA70EUygOoX97sGuADaiVzexO8yH5jAFNKColhn8Kv6050ihPYg0fFGfAd/?=
 =?us-ascii?Q?O2M0ALpyz/3H0hTYg6GFAOGeFXEG70Jbnr0vNBrVdCbjmJxcME9f77QJgeLa?=
 =?us-ascii?Q?ZDk4NKWsCDlDAaedp7E69BAVOa2/HmHocwMa59yG3pXbXoGiQmqwvAXz+3KF?=
 =?us-ascii?Q?H9TSNRxvki93gYe36w7fzquyHD2nDp2pebF+Wr5GpJX3mqqMKj+R6FkiAmIN?=
 =?us-ascii?Q?JEFYKegG3pei8QBgRhLiGWOdhKDbfmyTDJjDgyKdHRrAm+L7K2JcZ6xj1PzT?=
 =?us-ascii?Q?zmOQoMwJiR23ajEdvUetxLIVtUpmuBs5ohdji/YGnBGV5VBG9LuYHhKIxJ2F?=
 =?us-ascii?Q?y4rWup+lbEN6GNbBApbfjT+UyXysu2Nw1rBz7uc6nYpbhk7FzeGfjUswAiE4?=
 =?us-ascii?Q?uTFQHDbJxaFpVL8T35ybPhT0J2tH8xxUPaswUuyeHdw+1c9UQ7KgeJy3lDVY?=
 =?us-ascii?Q?gUV/f/MY863dRJ3K3VgQVOMa0GLiNPnrlM8EcFp1UebMJCEVv1KK9HG9G3fi?=
 =?us-ascii?Q?V8xIQA1ftBu6EuAP3v0hfDZfMQKqd5oonZ6WepVojD/ZZWF/h4VhcWRAmuiY?=
 =?us-ascii?Q?6K9sxgMpj4jYPwdEEe26bCbszM8K6vH4sW+51cJFtGm5KD/FwhFxZ1n/epcG?=
 =?us-ascii?Q?yfb7MfRLZgtfEgy8XD0HKrgtLyvf0K5Uj+dqbfpZ53OKle9wmpp8trzgg+ZK?=
 =?us-ascii?Q?umFt+5ifIHVV55P5alIe0O27NSad32A7ORDE4r6r84dT4BekJR8MB+Q4bOZu?=
 =?us-ascii?Q?qDgsxvcRKuqKOybOldDwz7Iz+U5fV6Mlpzu5MsVeVtKvT6vEXVtDPtcIAngr?=
 =?us-ascii?Q?hvP5kkyOxNMtXm5Z05FnNoaKjZLH2tZzUwk+UFxXfzU6v2gXf4iddfe+NTTp?=
 =?us-ascii?Q?BQTbHeb2X31dF0wWVLyezxzT27dhLaBjlp3+1MNHObBaUL/dRwh+PebahHIU?=
 =?us-ascii?Q?+sCpUsR+eu0L42FIRzC6pxsHRNjBQqaok9S4RP/Cx6eE6eRsZ7Us5S3dLCLA?=
 =?us-ascii?Q?feOpysU/F3E0imJTf2GiKAyQOE6ltMVlXgG/KqYp9qRP8sgbBt+kYyo7FH3r?=
 =?us-ascii?Q?AfsG4IH6HEKYAoh2D/FPKO0XCQVIunVLR9xoPQBW9E3+xj/9g2ZaNztT6LAW?=
 =?us-ascii?Q?MSaUFgbReHnkik9qt3XprbQeCDxnBZpb2WLmo/Soazc9IfNy78UgFqxTngk0?=
 =?us-ascii?Q?iCm5byiQpZXlIvMyehvYKUCMXy3VdzV133mF0o+qAcSwrsqAhFj5ywhTHsr9?=
 =?us-ascii?Q?ePcsmP+pZQzyAXMlWAymtKw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1D843FB2DE5613418907B9A2BC149EF5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a0b8910-87a2-4f35-d8d1-08da870ba527
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 02:35:31.0963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohy3rIK1gC74MYd8iZKOOrVsPI2RInN0YEKAWNmR2E4WqVZ04UjKuCft3qirkq/KSjs3RZWcJDTcBJHSGjeacw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1842
X-Proofpoint-GUID: AtNbmp5-PnfNsNRI4b-JaWd7tE_kSlpm
X-Proofpoint-ORIG-GUID: AtNbmp5-PnfNsNRI4b-JaWd7tE_kSlpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 25, 2022, at 4:03 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Thu, Aug 25, 2022 at 3:08 PM Song Liu <songliubraving@fb.com> wrote:
>> 
>> 
>> 
>>> On Aug 25, 2022, at 2:33 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>> 
>>> On Tue, Aug 23, 2022 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>> 
>>>> The helper is for BPF programs attached to perf_event in order to read
>>>> event-specific raw data.  I followed the convention of the
>>>> bpf_read_branch_records() helper so that it can tell the size of
>>>> record using BPF_F_GET_RAW_RECORD flag.
>>>> 
>>>> The use case is to filter perf event samples based on the HW provided
>>>> data which have more detailed information about the sample.
>>>> 
>>>> Note that it only reads the first fragment of the raw record.  But it
>>>> seems mostly ok since all the existing PMU raw data have only single
>>>> fragment and the multi-fragment records are only for BPF output attached
>>>> to sockets.  So unless it's used with such an extreme case, it'd work
>>>> for most of tracing use cases.
>>>> 
>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>>>> ---
>>>> I don't know how to test this.  As the raw data is available on some
>>>> hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
>>>> rejected by the verifier.  Actually it needs a bpf_perf_event_data
>>>> context so that's not an option IIUC.
>>>> 
>>>> include/uapi/linux/bpf.h | 23 ++++++++++++++++++++++
>>>> kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
>>>> 2 files changed, 64 insertions(+)
>>>> 
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 934a2a8beb87..af7f70564819 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -5355,6 +5355,23 @@ union bpf_attr {
>>>> *     Return
>>>> *             Current *ktime*.
>>>> *
>>>> + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
>>>> + *     Description
>>>> + *             For an eBPF program attached to a perf event, retrieve the
>>>> + *             raw record associated to *ctx* and store it in the buffer
>>>> + *             pointed by *buf* up to size *size* bytes.
>>>> + *     Return
>>>> + *             On success, number of bytes written to *buf*. On error, a
>>>> + *             negative value.
>>>> + *
>>>> + *             The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
>>>> + *             instead return the number of bytes required to store the raw
>>>> + *             record. If this flag is set, *buf* may be NULL.
>>> 
>>> It looks pretty ugly from a usability standpoint to have one helper
>>> doing completely different things and returning two different values
>>> based on BPF_F_GET_RAW_RECORD_SIZE.
>> 
>> Yeah, I had the same thought when I first looked at it. But that's the
>> exact syntax with bpf_read_branch_records(). Well, we still have time
>> to fix the new helper..
>> 
>>> 
>>> I'm not sure what's best, but I have two alternative proposals:
>>> 
>>> 1. Add two helpers: one to get perf record information (and size will
>>> be one of them). Something like bpf_perf_record_query(ctx, flags)
>>> where you pass perf ctx and what kind of information you want to read
>>> (through flags), and u64 return result returns that (see
>>> bpf_ringbuf_query() for such approach). And then have separate helper
>>> to read data.
>>> 
>>> 2. Keep one helper, but specify that it always returns record size,
>>> even if user specified smaller size to read. And then allow passing
>>> buf==NULL && size==0. So passing NULL, 0 -- you get record size.
>>> Passing non-NULL buf -- you read data.
>> 
>> AFAICT, this is also confusing.
>> 
> 
> this is analogous to snprintf() behavior, so not that new and
> surprising when you think about it. But if query + read makes more
> sense, then it's fine by me

Given the name discussion (the other email), I now like one API better.

Actually, since we are on this, can we make it more generic, and handle
all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
like:

long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);

WDYT Namhyung?

Another idea is to add another parameter, so that we can pick which 
PERF_SAMPLE_* to output via bpf_perf_event_read_sample().

I think this will cover all cases with sample perf_event. Thoughts?

Thanks,
Song



> 
>> Maybe we should use two kfuncs for this?
>> 
>> Thanks,
>> Song
>> 
>>> 
>>> 
>>> And also, "read_raw_record" is way too generic. We have
>>> bpf_perf_prog_read_value(), let's use "bpf_perf_read_raw_record()" as
>>> a name. We should have called bpf_read_branch_records() as
>>> bpf_perf_read_branch_records(), probably, as well. But it's too late.
>>> 
>>>> + *
>>>> + *             **-EINVAL** if arguments invalid or **size** not a multiple
>>>> + *             of **sizeof**\ (u64\ ).
>>>> + *
>>>> + *             **-ENOENT** if the event does not have raw records.
>>>> */
>>>> #define __BPF_FUNC_MAPPER(FN)          \
>>>>       FN(unspec),                     \
>>>> @@ -5566,6 +5583,7 @@ union bpf_attr {
>>>>       FN(tcp_raw_check_syncookie_ipv4),       \
>>>>       FN(tcp_raw_check_syncookie_ipv6),       \
>>>>       FN(ktime_get_tai_ns),           \
>>>> +       FN(read_raw_record),            \
>>>>       /* */
>>>> 
>>> 
>>> [...]
>> 

