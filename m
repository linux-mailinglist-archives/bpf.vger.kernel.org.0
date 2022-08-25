Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9E15A1BED
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 00:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiHYWIe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 18:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbiHYWIb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 18:08:31 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F548670B;
        Thu, 25 Aug 2022 15:08:31 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PM498T021526;
        Thu, 25 Aug 2022 15:08:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=FHr7210xVdyOj1AOPsydbet8+yy3ZI5DeNmk7V7mxNM=;
 b=fPuSb8Ue7lm5UmOq0C+PSJYCpa+3Pla1l/48EOsn8FRoaHqCh/1c78xSy8kIx+UOINvy
 LsRDsMYD6aBPOrXuGUa6J/8H8qkquFceV70ExdXi+pxmwmEi5q7RXFxIBFG3gpK8Uzzt
 ZxOM4aTBImQoLmLuSIWWX9zUE3Wi6Mig7LI= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j68q94bc5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 15:08:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib/o6jQFO4LnvxSP2TR+bx1nI0C9a2vvF39jUKfCHTY9fRA2QkpGPHlsoVwrZFZVkX7lEJtLNLzgFI9e1RSVmH93NZLqLf9AkTtlrp6of7Ywibvf8FKoWWpfRfcSGcm4PsdnH0Lahy07XnL7IazzhnS/KmIooB/AAE12/Y7VH7zUdJ2sHQ2+jtaxpYBEjqdGdSenZ44YAV6hZ3QnHp6tqsv9ylhOp0omKbLklXY1UDgqhwdkoMH/IjxzXFqKmDuCPXm6fQRefINN6HqySWbXPxAqjjmE/rh46ZVyRoDti8UQQF5CG1LC+FbUCYevb2hbKyZA/AK80D+Xg9rgb9yCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHr7210xVdyOj1AOPsydbet8+yy3ZI5DeNmk7V7mxNM=;
 b=bhrOqCuLyXpwrzViYTuPcd3kFmC+89E4/g5eFlhYL0x9U0RYgtcGGVogHNonpchveZkOLaSsU4KurZ75mSLXRLe2hCNRd8y3vVgGaub+3djOH9Z0nxXsjkJkiT6mmcMQZm4CeMuhQAxrGntR1/jblkFqNHK64ZlPyBa3EpQnAiySY2KirvTKMdh6QK8tqOo0cylAsurlQXHIsg3CnCbHaPAiPiDaqOADmaOyVB/GG4uqyhOe0EP1CcyGFencag3J9n8TLwF99KmhD1eyFSKL4THvLicfIYkeOo9flwhoil742xaFp81yzr8oNJePIaf/NGri4eIQXodOb9ggM+UYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH7PR15MB5224.namprd15.prod.outlook.com (2603:10b6:510:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 22:08:28 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 22:08:27 +0000
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
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYA=
Date:   Thu, 25 Aug 2022 22:08:27 +0000
Message-ID: <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
In-Reply-To: <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f919f047-183b-47e0-5768-08da86e65693
x-ms-traffictypediagnostic: PH7PR15MB5224:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hvDr/kZWCxtIe5m2PhiThEBpBOrfAxhN5ToSWAbRigel6jMgEoJaHJniyqtQdhFMYblirYq6AEPPeA1EVPUnqp2WvbMU+pJIbzuiRrm6U/U/+SBL9kwtU4dDEUY4D0StRfnsn1NW3wE1bmZnJdO1YJ/TDGIob2x8N0IwH8ktaZsBNy1tgxdzIv/13FmgvSoYt3Hep0dmJsK+ZoSKxYRadr+z46Tva50cHj8RjUY+7N58IErK2UaR8VjGnruIRPXJacfttEbG4YKeMTSCunNwGl6HC4MLueqW664PuN+zwtrF6kMdd7qMIJ90N3eAw/FtWUstlwQZJXKUwxePexzFgUWMbGN5AaJ0CHvKp1mPLTsp0eiZBfEG7SRNIrYUtXbHHecXLwWGjQs7yc3vTZRbEGwmuQ19vbYrqo2jTLxBq0Uijv5LllKIuNCzSCSpJK2Ql4dUi4855TqFV/5fkGmzGDYt+n9Rn5sIWPEIQ+GgH1khQhXEhitlqT3WvL0rnUZuV4OZ/1k3KX60nir/rWkHRNOUP9RMtu0ry9WjsPnJcXkuHt/6w1PXHffmtdsfWGbea8H1krAXN48FK4uQ3ALR4LxRvRaDKVkwtaTvRxUpzEyA69fDWEkPDu6wg7jATv6kflDSBCAs5CQ9p7dsdaRRLGQgLSOxe2WuGPVE9Vjd9gDryW82UCtccuIi6Co3l4jsyfvCHwll+rqkzT6gZa5493fUmCTdV7+91f/zdcqZ58/ldQBmXWI3suRfEdu3dr9E9jR51p+Z6Ex83J279ULEHhUkHMIl75uSB4CQ6zARds4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(8676002)(2906002)(6506007)(83380400001)(53546011)(64756008)(6916009)(54906003)(66556008)(66446008)(76116006)(38100700002)(91956017)(122000001)(66946007)(66476007)(36756003)(6512007)(316002)(71200400001)(7416002)(478600001)(5660300002)(6486002)(33656002)(86362001)(41300700001)(4326008)(8936002)(2616005)(38070700005)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W76/jSXPVChHr6bOGYnUNQMYdLW81AwgyYANwDG2RYvswjJua/MxbOj+ga44?=
 =?us-ascii?Q?A7MzzTxjbwQLrP8PdgOKYUhlQ0J3CHJOutIUNNi06mw9q3nWNvhvRuoUmpyE?=
 =?us-ascii?Q?jGxztYh1M2gwqvl+QGZF3Mlau4sIk0KVjcZgSQ6jLKDF3qorVrS6pf9xHyHd?=
 =?us-ascii?Q?dsThUVGvjtHBPJ/qcmItpfn0yGv8tk0gau2jXGMiK/yn31YNw1GZsd4TtMbx?=
 =?us-ascii?Q?+eiV3LX6c84JZuwumYKK8WNTCFHS6hZayo8qz3iN8uX/lVW4KIPnZwYzGz17?=
 =?us-ascii?Q?TGQs0JZ2u//hlcBUs72GxC5PnBgGSh1559c/05n5fcDz7DEXjT2C47iPxszX?=
 =?us-ascii?Q?qiwsxPFQ6KGXqh9uFPokbLXNRHuKRIT/AiJH9CDqcwSzzt2smbdV8y6op5XU?=
 =?us-ascii?Q?lntYbquL+W0Ab0/gt2VozxPxbyndGjzN/XiVwL4/Hy5B92sdPMVliow2osYZ?=
 =?us-ascii?Q?vI8x9rltOiykaNzIrzz1JkrQMF/mi8XGKsr/U41MO0kvh7OrD8Yl9xqwLdU8?=
 =?us-ascii?Q?oM6gUF63qdoqeFmcw8WV1l9mwuF0UCbTDLb5R4feEyRO7oBphPdB2VdrOwKn?=
 =?us-ascii?Q?rChUeqGxACEI09hd4eMiu/RqD850fWBsOebDgJrHMZMBjklipKrEmtmHhCXH?=
 =?us-ascii?Q?Yh86k4nWbbFMwphBSHs+lnJNJutamXwWvhLQg1OgEb5ZJzXfuqy3PdrYWAgb?=
 =?us-ascii?Q?Z+KgIjCYhVFMGZ3/n7ePDkb8QNlmKE9IZFsRcvRx6iVjXoJq6YDHGt3FHQS/?=
 =?us-ascii?Q?Rilfo+p1jil1522NwHGIypFIb6MIkZpDtGyYo7A3IBqFoGaAgiytlok06CP9?=
 =?us-ascii?Q?DMDWWBcKsZnUoE1jRcU0YGDp3wyLSEouwfKOJKLC47dVgOxLgM+u+Y1+zami?=
 =?us-ascii?Q?lVco+1KE4LxH97asah0DR+t9mQl+Xv6mr3+kDfdgykSj09Dmc3X+SBHtSpqK?=
 =?us-ascii?Q?S0A+Gd3lZHT4zt51Y39JbGDqVVwY1YQAfZEPnzkgUR5aXEfsSdOXooUNbDih?=
 =?us-ascii?Q?VmAtjN7ibSl7iVrDlF8ocosiepFw5XP7/89wzu7/JivjhvCjtzK/rINTQ2GT?=
 =?us-ascii?Q?9VtxvdfhR+EN6J4klZCHtV7lEYW5zcoXz2PXySStWGh/3swOCoaFJtOcrm89?=
 =?us-ascii?Q?Z1+RO9YAzGLTH/ad1WbeumVlhSkAfbMnrE9HXv4tpqVgDLEee2RqD8zWjDgo?=
 =?us-ascii?Q?3CS/SU684tGqk5QMRjEZCsdL/BZHA5CFxVmGo2cVBNnmlxrvJnSgy4tRjN74?=
 =?us-ascii?Q?qjYQdy7j0FwsBkKPd+33wVP12E24DZlAP/bmqTitC+yworTP34p56dAoduEi?=
 =?us-ascii?Q?Cng7pCcVtVrJaYn5CdIRM45w7ur3UtWfaKvRBYp6kyccM0qdm8UhKVwByyK4?=
 =?us-ascii?Q?93cE7dDpJQJZ90lc+WLgckv2W8/4SIp6tFMGaUA/4AFby5VmbhxgCZyyYQRd?=
 =?us-ascii?Q?Mrjcs/I7G1Gc3D5eUOsmtZAuB15E4ny0nWccBiXv2nKOQ/rHL6XZh8AfaHjq?=
 =?us-ascii?Q?0q6yG8DIdo7zsCk/AS/1dDKpUf8dDFgntJ96CLnbklGxH7Xyi+d329fyeh1Z?=
 =?us-ascii?Q?0nO5zi995uf8UPiB/tPwSr/G42drXMW7OEQ7yct4lWI7zXWtZ7Y/PGyt3DCf?=
 =?us-ascii?Q?5nNabx7OwMdDB9/ejUPIr1g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5F3B00229603B4D8DDFF9879683D375@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f919f047-183b-47e0-5768-08da86e65693
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 22:08:27.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3upVM3qw+5dkY5e9HmGH1ARkFyh9QTDOZKRKsZXNIqRCmcAPng2YVQJSav6wTLVfCEuuYsnEzCQIGAPiNS+TdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5224
X-Proofpoint-ORIG-GUID: VJ_v6-jaQD_gCS5bCHBHugZfuGRAUw97
X-Proofpoint-GUID: VJ_v6-jaQD_gCS5bCHBHugZfuGRAUw97
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_10,2022-08-25_01,2022-06-22_01
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



> On Aug 25, 2022, at 2:33 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> 
> On Tue, Aug 23, 2022 at 2:04 PM Namhyung Kim <namhyung@kernel.org> wrote:
>> 
>> The helper is for BPF programs attached to perf_event in order to read
>> event-specific raw data.  I followed the convention of the
>> bpf_read_branch_records() helper so that it can tell the size of
>> record using BPF_F_GET_RAW_RECORD flag.
>> 
>> The use case is to filter perf event samples based on the HW provided
>> data which have more detailed information about the sample.
>> 
>> Note that it only reads the first fragment of the raw record.  But it
>> seems mostly ok since all the existing PMU raw data have only single
>> fragment and the multi-fragment records are only for BPF output attached
>> to sockets.  So unless it's used with such an extreme case, it'd work
>> for most of tracing use cases.
>> 
>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>> ---
>> I don't know how to test this.  As the raw data is available on some
>> hardware PMU only (e.g. AMD IBS).  I tried a tracepoint event but it was
>> rejected by the verifier.  Actually it needs a bpf_perf_event_data
>> context so that's not an option IIUC.
>> 
>> include/uapi/linux/bpf.h | 23 ++++++++++++++++++++++
>> kernel/trace/bpf_trace.c | 41 ++++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 64 insertions(+)
>> 
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 934a2a8beb87..af7f70564819 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5355,6 +5355,23 @@ union bpf_attr {
>>  *     Return
>>  *             Current *ktime*.
>>  *
>> + * long bpf_read_raw_record(struct bpf_perf_event_data *ctx, void *buf, u32 size, u64 flags)
>> + *     Description
>> + *             For an eBPF program attached to a perf event, retrieve the
>> + *             raw record associated to *ctx* and store it in the buffer
>> + *             pointed by *buf* up to size *size* bytes.
>> + *     Return
>> + *             On success, number of bytes written to *buf*. On error, a
>> + *             negative value.
>> + *
>> + *             The *flags* can be set to **BPF_F_GET_RAW_RECORD_SIZE** to
>> + *             instead return the number of bytes required to store the raw
>> + *             record. If this flag is set, *buf* may be NULL.
> 
> It looks pretty ugly from a usability standpoint to have one helper
> doing completely different things and returning two different values
> based on BPF_F_GET_RAW_RECORD_SIZE.

Yeah, I had the same thought when I first looked at it. But that's the 
exact syntax with bpf_read_branch_records(). Well, we still have time
to fix the new helper..

> 
> I'm not sure what's best, but I have two alternative proposals:
> 
> 1. Add two helpers: one to get perf record information (and size will
> be one of them). Something like bpf_perf_record_query(ctx, flags)
> where you pass perf ctx and what kind of information you want to read
> (through flags), and u64 return result returns that (see
> bpf_ringbuf_query() for such approach). And then have separate helper
> to read data.
> 
> 2. Keep one helper, but specify that it always returns record size,
> even if user specified smaller size to read. And then allow passing
> buf==NULL && size==0. So passing NULL, 0 -- you get record size.
> Passing non-NULL buf -- you read data.

AFAICT, this is also confusing.

Maybe we should use two kfuncs for this?

Thanks,
Song

> 
> 
> And also, "read_raw_record" is way too generic. We have
> bpf_perf_prog_read_value(), let's use "bpf_perf_read_raw_record()" as
> a name. We should have called bpf_read_branch_records() as
> bpf_perf_read_branch_records(), probably, as well. But it's too late.
> 
>> + *
>> + *             **-EINVAL** if arguments invalid or **size** not a multiple
>> + *             of **sizeof**\ (u64\ ).
>> + *
>> + *             **-ENOENT** if the event does not have raw records.
>>  */
>> #define __BPF_FUNC_MAPPER(FN)          \
>>        FN(unspec),                     \
>> @@ -5566,6 +5583,7 @@ union bpf_attr {
>>        FN(tcp_raw_check_syncookie_ipv4),       \
>>        FN(tcp_raw_check_syncookie_ipv6),       \
>>        FN(ktime_get_tai_ns),           \
>> +       FN(read_raw_record),            \
>>        /* */
>> 
> 
> [...]

