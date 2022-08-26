Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CE85A30B0
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 22:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344712AbiHZU6x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 16:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiHZU6w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 16:58:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B6AE1163;
        Fri, 26 Aug 2022 13:58:52 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP419018131;
        Fri, 26 Aug 2022 13:58:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=rTNsdSZOf5RfwrRe1/wkCvZHoBG9V4j4TjT5kyqNIUc=;
 b=c5VfFRLgaV6UC+EqCKAqb2y2oQ6HwQ//jM/kKysI1vji9VmbEOOXDvG8iakctATNlC9c
 ZCMJVKWZOtcHAocEtepOoy16G6Syg5X3H97B03hLmlXN/NQT19MQP0A9Hjlf6n2hXCUe
 CKib2rfro/Veh99o6IM2HvsPVdHON8kXvKQ= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j70s9t9du-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 13:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmWpHnQ5Ls/xxd8v4ueTMpiJTUcXeyKH7m/AEmSk+fKOG2O+sm4qlCR5yQYGi353zynrcdDFZDn9c1rK5qbEl4UH35o4QrvBldCBeOQGRBEGNpaHFIsE2qYL6+R+X8bvMNE/5tr4Xth/CzkcB6shL3owkOw3KnHItTJY1BgYKRXTiI5UnSD+ru0l81VWSfw2ue1ZaC7VliUzhcmfSoGB+cZR58m0UO4nsM3RHXENAJcTqgcu3Opwy7tAL7wgJ3XpmtOgr/w3GvA5hOSTaPxvzNvdILm3DiaWuEKcYPVLczL0vUIAF8pj/p/+AgX9gfU+6xMFagg8isqBQlhUTZD/hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTNsdSZOf5RfwrRe1/wkCvZHoBG9V4j4TjT5kyqNIUc=;
 b=NF22YOvWgb1f1rhRpc0MJo3nmL4O2Bc7bBZpQN6XJExxQwhfM61CDPcwA5Ftmg+26xP3rHN3brJGLlxrKcSKj25apNEvPU+MWXYArueT13VNzKKirnUw4TDsrYxgvS4sXjQpKDv81s4o+48B94shgPzRtpRW56s1ubIzTuzhZYipHGR1zx51BT8JdwKptqTSyieHHeE2Uy7H8fi8yDgcAkRxzl0GRmAkAevBsi22Qrq4Tj9SDa3Jye5KyCtTb981nuNwp3Nwg675VlNgGyeCsmYzBC0kwMQ28VHDTtFJ+QeKl4Bvt6XfmWBWeunjU4JVZTW942V0K7ZjTNMgr8yBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4395.namprd15.prod.outlook.com (2603:10b6:303:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 20:58:48 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 20:58:48 +0000
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
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYCAAA9aAIAAO0MAgAAulQCAAAilAIAAsuMAgAAazgCAAAnxgIAADKuAgAAYuoA=
Date:   Fri, 26 Aug 2022 20:58:48 +0000
Message-ID: <FD49F694-10FA-4346-8303-E1E185C3E6E4@fb.com>
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
In-Reply-To: <CAM9d7cj6YNTL+u38PZjhPF2Qg_BYiJ1NMmDkPDx3N3Xe+ZTbyA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd5d0881-60e4-498c-ab6c-08da87a5c5f6
x-ms-traffictypediagnostic: MW4PR15MB4395:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UEdjNZeVAUqY+FKWRbGMUYPEEQPkjCGMQFFZmbSqR33Qa+zYivmbAai0iquQ1sYeNntcMF63Fc/eZ73r4wi39ztjCv1mJ0UbcujOchlVGUZG4I6+0UVT1OpLLYMUVCMUYPzyVhZVzKOeSDhUN84zADtDcTdTd9L2XHtq7ZCDtyqtCMfaJxpzvocywiEaxGE4vCcImEi6OR4FJAJ0h9kv5qzRwuL8xep4Zq/zHKGLXG+lxARQY1gdzIjAYCrDEJDRed3Y2biL0mUvPw0C5glOv+NqDkEnFKdsM2UxR3pmrdYyWW2bm8vbKryLZaBwohXdwJ8GMrIVjbPXCRH3nCZlv9RRLmli+s7CD9s1/tGgb+Re4dmOlsa4n5PPx6NUXRS6eDxsxlctjj60YIbtv/nLocMAi0S8xWXeLtm+LosVEQUgTU7ly8ZKYv+Ygy9bX7Q79S545i2hxf5yCOhX5DkJVAKwztsDNBIIwMBopOXpf/PJL49vZeWdUCFqd2G+LLbuXl48nC3/u4KWsaTsXfJLqqRqHUpr+IpauV3cyDJqjt/dBWPsqD1aHBR7HeW/Flg6wrWOeiYumEY/oF80lGIftC3mxTkPJqT9eDowqbTEaAsomEQxlJPQI6uqRhjPVrF2wFiGsC4+bn3h5f3BeLLHUPamP+Z/1ZL+61Rra+9JlZxHhyxNx8TR1KfOGVj5efI4m+E1n2XVUcXxaNMeHYMHAbssXHx9wkhbIkcYOHiEkHUgHPv2nGvCfEumXTgegwY7yj7LVmVUDYG67H+5sK0eYb8qTX7iy107i+LL+harbRE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(8676002)(38070700005)(76116006)(6916009)(54906003)(66556008)(66446008)(64756008)(66476007)(91956017)(4326008)(66946007)(316002)(6512007)(83380400001)(36756003)(186003)(2616005)(478600001)(6486002)(122000001)(53546011)(6506007)(71200400001)(33656002)(38100700002)(41300700001)(2906002)(4744005)(7416002)(5660300002)(8936002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6u/GQVURjFN3xbtGR1fjPIPtI3krgzoTQMx8Vhj4UqaBNFNbWt66K4LDl8qW?=
 =?us-ascii?Q?zF7RzdVA7pd0eY/hxFeTeaA8wsfi2fze8ojq8CRHvPv1dmnQBJy+n7FvRbYk?=
 =?us-ascii?Q?ie40LoE991wFJjQrTpT8TD2yaE4AJjhf3v5yY0iiza39Y0Y0RdRqCa5Bw+TJ?=
 =?us-ascii?Q?N3SKRufYcJKNxablezbNG+f8ULc2bqdNC8GnExEpeRl3Z1nUO7uuaJ6t7C52?=
 =?us-ascii?Q?mRYOwERzb+4hIgsvINh2LWxSyBvFm2hzEBzAcW73txj0ixQz7l6CLK/FcX3R?=
 =?us-ascii?Q?/V2BxHDqSjptIglJeMmllJFuXalD6MctMkyD6uasYXUi/n12X4bCp7lk+WSS?=
 =?us-ascii?Q?Mrc6GS1VEq3Am59bmOF5qzyTaS2KttkAORExfDSLjeg8MSX9oSF6yAo2pYS6?=
 =?us-ascii?Q?g6+1dDDb9iF5AbhRL5B5+1ZCJPOjcbRxb3RXP4HIga2kU/T9gIL4rjhgCaa4?=
 =?us-ascii?Q?VMqceLcyvKAlP8SauuMbYT6DiQTeJDmNSno6HY4iQSPeVEBtdBzboOc5sj8Q?=
 =?us-ascii?Q?aJ3BklV/4L/EVHLliV5vaQYKdEHNgqAUSAkd5Tnhufd+lNB9PSgPg1YBDSM3?=
 =?us-ascii?Q?8wxP78/k05FY2R0RE6n/7FHlMJF0sxxb9gu6Za9tyCWCxSVcPoTp76XjBuT7?=
 =?us-ascii?Q?XNNNHN/4wMAqGoa4pU6jwLtg61QHN4UZ1IQBfh6xJSJFsOVIy53dMcCZPX93?=
 =?us-ascii?Q?bZ9QqqaMdyWZgWWXMPZrY7kCpZDZ+L8IVzpVCVpxdk7xHfnZXpMLOL7JhEdl?=
 =?us-ascii?Q?F5XGG9YRAlevnzYnJalEYqH2X2pgjT2k/H/61EWFt7CQFnUwf6BQPva/vDU5?=
 =?us-ascii?Q?cw6hnRfiTj5q8kSMFjbJsr1aX8Cpe9sIZrwJ3GqhLFCdUNGhYM/NE9bxuPME?=
 =?us-ascii?Q?k6gW44h0PszsMKpw8lBXmDxc7yALm9oTyffnhzbpTfgmPhZLOfNVbc4qRbbY?=
 =?us-ascii?Q?aAXGVwJ2zpfto1FzZKJF0HAfhFJolJRn4I8Foj+SelWXgM5ldg1NH642QUxc?=
 =?us-ascii?Q?NpDDQE1X7DFpdNZqp3cV6IqC+QP4jY+t1loZlnAku9mmQlSNUXbmvuiPbM1L?=
 =?us-ascii?Q?gyEksk4KFfc2bc259WkHd8lCJcYxFYhNkJQj5Vn/8QBa2Pok6o/kWlBl42zi?=
 =?us-ascii?Q?S5J8VzvcWL/WOJ951AMltjHwtXwGkKZcH4ISKQdSstaWEKRZMW+KOBlrUvcB?=
 =?us-ascii?Q?nuQcgDwI1wi3EvhMc6V9NU7bCnCdaNL3wV+Ws2FeRD0UPDiu48p7fqrz8LQm?=
 =?us-ascii?Q?PkoyMRlprcyMNDQoc2UVGz4bnKK0mqHZGj8hHe2Vxw+yoYvXWHuMq/faeKqD?=
 =?us-ascii?Q?Eo9zwJGQNw7ST2RrMbGIcR1faF63rDC4mVSt+Wl74foKFkQx01SlkWcWemIP?=
 =?us-ascii?Q?N+GjFeWxjatj7t3kNrjRuCMp5JmLVps4Gq1IIWzBvHQOit6M7UEKcsHk1WJV?=
 =?us-ascii?Q?eoTKFnliR7VBJxkj2qc5SEhXTdh5yISv3j5XUJmI5BfkZJRXNQ6dVyDv+tcq?=
 =?us-ascii?Q?Ccmj8eSTqPcw8NNR1f9wOjcsgyeuuUAwPcXGBA8F2uzXrVelmRCJwReYmtZQ?=
 =?us-ascii?Q?HulVDedGN7+ap9A2k0z0ZOItq7NHWmfV8QQRhuvNKt+FCsBO3KXd9g/3+Swp?=
 =?us-ascii?Q?VNh99Z6FsP+26yNzqGJhc1I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D089AB07810C24D9E38596F890F64D8@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd5d0881-60e4-498c-ab6c-08da87a5c5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 20:58:48.6352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jvGqe3Fa93X+fzzY6kBaDXbtJVAU+RahE9X+RF9iDdtK7vwDCSvKLn51Sij7ECYUmBeocL+5qfqaF3lOmx54ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4395
X-Proofpoint-GUID: lKHw2aZi1xkt_AlvdI57yoqALavoGkcB
X-Proofpoint-ORIG-GUID: lKHw2aZi1xkt_AlvdI57yoqALavoGkcB
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



> On Aug 26, 2022, at 12:30 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> On Fri, Aug 26, 2022 at 11:45 AM Song Liu <songliubraving@fb.com> wrote:
> 
>>> And actually, we can just read ctx->data and get the raw record,
>>> right..?
>> 
>> Played with this for a little bit. ctx->data appears to be not
>> reliable sometimes. I guess (not 100% sure) this is because we
>> call bpf program before event->orig_overflow_handler. We can
>> probably add a flag to specify we want to call orig_overflow_handler
>> first.
> 
> I'm not sure.  The sample_data should be provided by the caller
> of perf_event_overflow.  So I guess the bpf program should see
> a valid ctx->data.

Let's dig into this. Maybe we need some small changes in 
pe_prog_convert_ctx_access. 

> Also I want to control calling the orig_overflow_handler based
> on the return value of the BPF program.  So calling the orig
> handler before BPF won't work for me. :)

Interesting. Could you share more information about the use case?

Thanks,
Song
