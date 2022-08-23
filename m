Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1EB59EEE9
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 00:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiHWWT3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Aug 2022 18:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiHWWT2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Aug 2022 18:19:28 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD21780F7C;
        Tue, 23 Aug 2022 15:19:26 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NJkaQT008019;
        Tue, 23 Aug 2022 15:19:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=dDjavq2niKmX31TWVeHKSFPAcxSWjgfC8vW2OTRYEzs=;
 b=gR9nAONSuNdYw3w5GJqg4x+KvZi/QTfasm7kSHGMErahhtW7KTl2vbzaAW+KllfMa+io
 feCjsn6K9mST849I02rO0yzmjNRCzQr49X5Ttasl3E2/t57bJu+g7zaMnkmnLT78LrJX
 LfZ08FWwvCimhZ4wi0lHYxZC17n2RPBExVs= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j4ywnbv94-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 15:19:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUsXYCW5QAjwbGpTYo8+gGyL1/8mFsWVnwQoahPGFTXWZE61njGETYUafyXVPn/YbJxeCHZ3QXhdAV+7WkB+NGKXpaXH+1E8h+S9wZMoq8Gntp2Ymg90rkvQFyq03z4DjIljSKQpU8qEWbPqB7u8qF2lWZeupSw8iZVEF53+eEGpcTR+VSCmMlse2DEGlcDV0R2cvGLz1VBvlGuj5R3kJvtpb8aqFinHO2DvFfZVRgmEsXBwsszDfk9zhL/+F8mFMaNGefyQCAIscJ0bV246JjIXbhpaNw/lxA/tyqRXzXQHYxLZdTTw8GNHuRe0HI48MzP2DL2AqDOudaUHp1hjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDjavq2niKmX31TWVeHKSFPAcxSWjgfC8vW2OTRYEzs=;
 b=JoeEODcoVRQX9fYeKfQlaxMWPBvKRoDuexEIEetnInC6Gb8fQY9C9sbB9Io21bv+fZ7KA26m0UWJMTW3KucZHAAsOogWcLt9bQv5lVVP+D6wu8qvOxqT5RhEM0KeH4aq8eMvkd+/L0ZsjnjBawMkPG2hFO+dV1Bq3sb2Xwjic1J+WoKl7i/XmoEITr8kf6220398MiG8kq252PaLlO8caBZX7tOPLWhBb4uP/JvJP8gn6T0AmpGu6trxVOyKPbMyzk0M2k3zw7sUMF361edU/RudReBuhq/y6c2xC1XQ5uoQtk4hLJbj9PMxa4cwCdnzxAE3IKjyoqm3L6AjpNhdIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM6PR15MB3260.namprd15.prod.outlook.com (2603:10b6:5:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Tue, 23 Aug
 2022 22:19:19 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%8]) with mapi id 15.20.5546.024; Tue, 23 Aug 2022
 22:19:19 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
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
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK29Dl6A
Date:   Tue, 23 Aug 2022 22:19:19 +0000
Message-ID: <95708205-66EA-4622-A580-FD234E6CE2DA@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
In-Reply-To: <20220823210354.1407473-1-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 132e4804-d85d-4269-9119-08da85558637
x-ms-traffictypediagnostic: DM6PR15MB3260:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQZdSMeDateV8nLmcjSzT1d366D7McVMTT8t+a++lEmuke2Itqu5T9qr842SVTtGaxafD2Fr5rghrMvOoTNvKIfmX0KEjM+RknnUmNhxsaDE4cvE1bdc418+1cN304zNBKTmSHXBBwTIZ9kFPfbXGHa3Mf5kJrknIAhySbYKi8NM0/gqVwwNGLzu5X2h6izCp46jxtI1ekT7F16MPExCmYlmqBa3brKa8/jZSCNJ3CCMz/1HJiSsubScAEI+LgfCIUEHApGDGDIMXaXeIzi7HO6JqEQjH3/bgN9tN/wb1owJtQ+6iCDgSLHnEKBkpsmK6ynAyIbGs1FAdX4VsqLBotyY1pwYR0XhiOBq/yUdRH/FIpMXLH04jaco5YdoUsdusnN+s3QlAkZHxOM9wGHrlBU/0AS2DlymtQLXmEYq/JjVkCd8eCAcGJnSHXdbwqQMqsnu65gw1qmaQQTS3l6CNTTx/sHNYf/i4lz+KVAo9j6dwDpnT+1alnrpJJr8Qmck2mPm49Rqdjr+0aGTONTAVpHW6thK+pgstNmaXWRQY+BK5hAOjAOd954Duv8X+XZ0fEUABYk/wvyTGrPNx6rBHa33nqee2h7n/bF7AR/PzPIVJD/sX5BpX3tBOCuwh5g1sMlOJQbWr6RcffSt7KPrAvXZxCsx7hVkN5t4u/Acn0t4yMH8Bgpa8YvX0XcwLnIp23YoTUS66Aoc3gE9QeIuxfysHnAw00o26yWd41iAh8glAYkFOTqzmAssYrn6Blz0MWiQ/eeA92zEyG0s4lUyaMNRTt3ZREeh13hU2JC0VXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(83380400001)(53546011)(6512007)(2616005)(33656002)(186003)(2906002)(6506007)(38070700005)(86362001)(38100700002)(122000001)(66946007)(7416002)(6486002)(66556008)(66446008)(76116006)(5660300002)(41300700001)(316002)(6916009)(36756003)(54906003)(8676002)(8936002)(478600001)(66476007)(71200400001)(64756008)(4326008)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7of3HnzbLgNR7sl3FwCgHpXZhr2LDQsrITwDzbd777o+DBDLRaorAoYFhpz0?=
 =?us-ascii?Q?GjVT7Gmx0TMh9Sn4QWanmW2DUwzo86UHK4OV7RTMr+xa+llNhC24sGGvqnqp?=
 =?us-ascii?Q?0shNrWSH03gEIratfPOm9b+tFFQ2LHqXjXUl0YzWc8fzPezHO/Emd8bgt8BO?=
 =?us-ascii?Q?ItOEQ5m4TJJJQl0dqeqdgD9h0DVggjpKjUL0ioxFw1Sfp92d5vU9nHaiIPPj?=
 =?us-ascii?Q?x0fOSEw4moJ16jml0PYHeSDKdg9mfqTM/vhfPa25dcn3YOK3aexUnSGJYSbk?=
 =?us-ascii?Q?5kuGDojdeGVhcEYxU81GZ2JLUsBu3niphXluz0rlafb8kX+aLBRlDtTSUf6x?=
 =?us-ascii?Q?JlE595dbh1ESWiYuZsnWHJdQqF4BmRoWfWzUs6D8zilTknt7s0KEaOPKRYwI?=
 =?us-ascii?Q?lKJ1vjsPnsn9aVI/9bOMvcgGG7zniF0NCJX/2D/pOYlBodJ3cz0ksZ3jwm8c?=
 =?us-ascii?Q?ak3mCkF/wJZZikGDw3DOFIaTFx5voJFf6Zv8MV8a112WMVD+4tgeTWkceoKu?=
 =?us-ascii?Q?c2mr+DTzu9ArYJ4Dp0ksX+kW8wBhNwI6XKgT8O49cplIyRMCJSaEC1EEmdLo?=
 =?us-ascii?Q?auYtCrxaIvDacDM+1IyERjRXFV2cbBa0+YjwY5uhfUnXnQWhBR0eOb5j6eUV?=
 =?us-ascii?Q?RizgtvXgHaHBozEADP9iObGHBu6mqSHVHYIP6dX2iPb2hrtuMe7vlBklVNJ0?=
 =?us-ascii?Q?k44wXSn7peCMCxIHbq9L03x4JedqUbRdSQjIwIue26X1Yz0DaVkG0t53vSWN?=
 =?us-ascii?Q?+0yw5yIW6B2jQZwcn1Q4nIfAmnV1YaKtS3h1IYdJsX9Ljk6BVsuaFaR86Z2S?=
 =?us-ascii?Q?QEbHhuxonweHATXYNHBgPWQ9/B6VyIILM0KVwjbLdgi/TZVhZjqo8fKJt2Z+?=
 =?us-ascii?Q?RM3HPEglciWnZ5+rKYA1IFap0l+9cH3LLvMnVexFYHipxsbbJ+sLj426RdpB?=
 =?us-ascii?Q?X+flL7sv2z0986SNiV0+Fv9HuySHbi9clVhmV4R6t1EFAGN94JXwjAiRz4D0?=
 =?us-ascii?Q?7v37vYQmC/lYzu3kwRVktRu5PRRGmSUNlpSCVcmEAZGeKH9OJfbOOYUFjhvn?=
 =?us-ascii?Q?8PP9enZJuQfly4oS0susu7qLzu7t1azrLoXwDsgKtEp1/GN9KdVYFeAwdNRK?=
 =?us-ascii?Q?d/aHzd2t2RfjhaoEhZ0V3wV8iMNCiGpL2w8G3Z0UaKwU10k9PNmTohKJcunG?=
 =?us-ascii?Q?O0FVY5xFpXRtnrkGSaE63dr6bfoNJ+TKe1fTalds6aB40NRTpfF6sneh5UPa?=
 =?us-ascii?Q?8DL/+m9ntlRnDqtxQP9d7Srw4ccuRfa+1Ox07P5hXzGKl6T/jVgZdEsKWba3?=
 =?us-ascii?Q?kIFnbqIBnfzb3nqLfifSTtsC8BNY03IKszHA7LxQiDETtZEW3lgH7G982DO9?=
 =?us-ascii?Q?Q3BG8fUZzrtqpU80H3HACiM7N/MdLqwOGacNFePe7sTkMvx/Ah7Em6aYN1bL?=
 =?us-ascii?Q?NQcDxmSimNTs5ksDZvrFePH8G6ArspEIRRpi8byqJkeCpYqPSJrsXo5PBEsp?=
 =?us-ascii?Q?dbZmqK4RFCpwW7Rh6au+3jqJnXC5oy8M9B8CrYgVlWMuYmXGCXaIWEp5OLkC?=
 =?us-ascii?Q?dxLSiJyNDqaX3dGWHXJ0E4UVNfWutjs21OTlQ0LPKXml8YOG6rXMcGs0lXqc?=
 =?us-ascii?Q?IrU9OvI9xjNw49WWjfkcej4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F733428D8A721B4FABA859396540780F@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132e4804-d85d-4269-9119-08da85558637
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2022 22:19:19.6693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jFi1UrrACnfc63i+I2T8rw7tzqEVqtNS9KHk0LSxW83TwG9zt1kXs/OJyFO0R8/aHmOKeAzJbeFxFoGr+uDtHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3260
X-Proofpoint-ORIG-GUID: NEjeUtA9Rwc21xtbt7ZHbAMAyyLr6KyH
X-Proofpoint-GUID: NEjeUtA9Rwc21xtbt7ZHbAMAyyLr6KyH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_09,2022-08-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 23, 2022, at 2:03 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> The helper is for BPF programs attached to perf_event in order to read
> event-specific raw data.  I followed the convention of the
> bpf_read_branch_records() helper so that it can tell the size of
> record using BPF_F_GET_RAW_RECORD flag.
> 
> The use case is to filter perf event samples based on the HW provided
> data which have more detailed information about the sample.
> 
> Note that it only reads the first fragment of the raw record.  But it
> seems mostly ok since all the existing PMU raw data have only single
> fragment and the multi-fragment records are only for BPF output attached
> to sockets.  So unless it's used with such an extreme case, it'd work
> for most of tracing use cases.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
> I don't know how to test this.  As the raw data is available on some
> hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
> rejected by the verifier.  Actually it needs a bpf_perf_event_data
> context so that's not an option IIUC.

Can we add a software event that generates raw data for testing? 

Thanks,
Song


> 
> include/uapi/linux/bpf.h | 23 ++++++++++++++++++++++
> kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 64 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 934a2a8beb87..af7f70564819 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5355,6 +5355,23 @@ union bpf_attr {
>  *	Return
>  *		Current *ktime*.
>  *
> + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
> + *	Description
> + *		For an eBPF program attached to a perf event, retrieve the
> + *		raw record associated to *ctx* and store it in the buffer
> + *		pointed by *buf* up to size *size* bytes.
> + *	Return
> + *		On success, number of bytes written to *buf*. On error, a
> + *		negative value.
> + *
> + *		The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
> + *		instead return the number of bytes required to store the raw
> + *		record. If this flag is set, *buf* may be NULL.
> + *
> + *		**-EINVAL** if arguments invalid or **size** not a multiple
> + *		of **sizeof**\ (u64\ ).
> + *
> + *		**-ENOENT** if the event does not have raw records.
>  */
> #define __BPF_FUNC_MAPPER(FN)		\
> 	FN(unspec),			\
> @@ -5566,6 +5583,7 @@ union bpf_attr {
> 	FN(tcp_raw_check_syncookie_ipv4),	\
> 	FN(tcp_raw_check_syncookie_ipv6),	\
> 	FN(ktime_get_tai_ns),		\
> +	FN(read_raw_record),		\
> 	/* */
> 
> /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -5749,6 +5767,11 @@ enum {
> 	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
> };
> 
> +/* BPF_FUNC_read_raw_record flags. */
> +enum {
> +	BPF_F_GET_RAW_RECORD_SIZE	= (1ULL << 0),
> +};
> +
> #define __bpf_md_ptr(type, name)	\
> union {					\
> 	type name;			\
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..db172b12e5f8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -20,6 +20,7 @@
> #include <linux/fprobe.h>
> #include <linux/bsearch.h>
> #include <linux/sort.h>
> +#include <linux/perf_event.h>
> 
> #include <net/bpf_sk_storage.h>
> 
> @@ -1532,6 +1533,44 @@ static const struct bpf_func_proto bpf_read_branch_records_proto = {
> 	.arg4_type      = ARG_ANYTHING,
> };
> 
> +BPF_CALL_4(bpf_read_raw_record, struct bpf_perf_event_data_kern *, ctx,
> +	   void *, buf, u32, size, u64, flags)
> +{
> +	struct perf_raw_record *raw = ctx->data->raw;
> +	struct perf_raw_frag *frag;
> +	u32 to_copy;
> +
> +	if (unlikely(flags & ~BPF_F_GET_RAW_RECORD_SIZE))
> +		return -EINVAL;
> +
> +	if (unlikely(!raw))
> +		return -ENOENT;
> +
> +	if (flags & BPF_F_GET_RAW_RECORD_SIZE)
> +		return raw->size;
> +
> +	if (!buf || (size % sizeof(u32) != 0))
> +		return -EINVAL;
> +
> +	frag = &raw->frag;
> +	WARN_ON_ONCE(!perf_raw_frag_last(frag));
> +
> +	to_copy = min_t(u32, frag->size, size);
> +	memcpy(buf, frag->data, to_copy);
> +
> +	return to_copy;
> +}
> +
> +static const struct bpf_func_proto bpf_read_raw_record_proto = {
> +	.func           = bpf_read_raw_record,
> +	.gpl_only       = true,
> +	.ret_type       = RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_CTX,
> +	.arg2_type      = ARG_PTR_TO_MEM_OR_NULL,
> +	.arg3_type      = ARG_CONST_SIZE_OR_ZERO,
> +	.arg4_type      = ARG_ANYTHING,
> +};
> +
> static const struct bpf_func_proto *
> pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> {
> @@ -1548,6 +1587,8 @@ pe_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> 		return &bpf_read_branch_records_proto;
> 	case BPF_FUNC_get_attach_cookie:
> 		return &bpf_get_attach_cookie_proto_pe;
> +	case BPF_FUNC_read_raw_record:
> +		return &bpf_read_raw_record_proto;
> 	default:
> 		return bpf_tracing_func_proto(func_id, prog);
> 	}
> -- 
> 2.37.2.609.g9ff673ca1a-goog
> 

