Return-Path: <bpf+bounces-10978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5BC7B093E
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 17:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6EBADB20AFF
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 15:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B7B48E9F;
	Wed, 27 Sep 2023 15:48:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E7B6FA2
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 15:48:22 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A527E47
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 08:48:01 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RD3P2Q010682
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 08:48:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=AQ61yro3etfxUwchsx40YfjwPtfFSURP8/0PxC82x4A=;
 b=XefI996mBnUxYfhUB+wtVr5nyMt6bZmw3w8vGXxxoJWZRMZ029et+ZrO731cA1dXKbBU
 C3AyXe9LQin7eNgnN78VzhcPuCRflpc7RpjwRF93HNYARi+9BgVfeNUuyN1So/yZlepj
 mu2YrIBDHamRmvGn69AVI44LGMstX6AxJAFpVPDnjKzA3QAUXSY9Z1jRreatkybDfUYZ
 fBSsjkrULoSrHYoCYnqbGy/MzU1dJw5IiSXAwus91rEhnMDWOXpPdSqllgQ78Pu+SWgu
 JtCJHjjKuziIbS+3lku6xxgIm8GrRIS33K20OpnKEvi8fpDZAD9s/rc+irRfcJ1yN+9f 3w== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tcmxhhgvf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 08:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk9R+R475NoSBop4kub9Edhdgc7iL41A1gHnCPt8J2pmK+eKqyqvE8MS9XFqgJUYBO1MuUc3Wy8ed19iTs+Ef3g4QTJMVdNBdGxM6yNOUwkcuy4xQ4A1+XuUUq9b5uayin9gs2GjRs3j8DWWudTLeTtST3mPsinAWHehFKrzhgnywT4p6t4qGS33/lq3EcSKZllgK8vzCZ4m2jS+gXBEXMkTgq7TBZCSxLk82BP33RI3IahKw5sR+Ptxw86XttFtMn7ez6Ooshm/pBvZwoRUx0mLnBcwJLEw8oSKJo72J5KScFyn86F7HxxGBzU5EDZrVjZVXZPNVNw0bu/y3FahQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ61yro3etfxUwchsx40YfjwPtfFSURP8/0PxC82x4A=;
 b=LJbroQDkz2NcgAClGuQU7SkWFONNQ2FYE0NUHCLgtgdFHRZq0KDJsKjUOtT0faxeaqGW66IJC6QKvGbTQV2DVkYOqGMRJvroty4DEBuJoYd2X8qiL2Ek3uvW+Hatcm8OT955ZECokECo8xTc5/PympFEhbjztJSLdQ5OwvjBn7lafx68Z0fteA9Y94bAucMAtWYByro4E+3/CTu1fXvZaUotWtB96Tb8J2M7JEpxgvbMeqltmzPcfMJU/uYpIvy2UaAgIuegUq00c0LtNPmvJbNkrm5GnlrFh38dwxP/DL22q0AI7knFBndywmggcLNAAOE0C7d1wRKzmPjrGIf7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by DM4PR15MB5520.namprd15.prod.outlook.com (2603:10b6:8:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:47:55 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 15:47:54 +0000
From: Song Liu <songliubraving@meta.com>
To: Jiri Olsa <olsajiri@gmail.com>
CC: Song Liu <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov
	<ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
	<andrii@kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        Kernel
 Team <kernel-team@meta.com>,
        "iii@linux.ibm.com" <iii@linux.ibm.com>,
        "bjorn@kernel.org" <bjorn@kernel.org>
Subject: Re: [PATCH v3 bpf-next 8/8] x86, bpf: Use bpf_prog_pack for bpf
 trampoline
Thread-Topic: [PATCH v3 bpf-next 8/8] x86, bpf: Use bpf_prog_pack for bpf
 trampoline
Thread-Index: AQHZ8Ku8oe+zfr5cG0mBPsTWQBF2fLAuqDmAgAAqWAA=
Date: Wed, 27 Sep 2023 15:47:54 +0000
Message-ID: <1AA3C7C1-ACE7-4FD3-9FC6-74F9643897F8@fb.com>
References: <20230926190020.1111575-1-song@kernel.org>
 <20230926190020.1111575-9-song@kernel.org> <ZRQrG7ve8MRKD6xT@krava>
In-Reply-To: <ZRQrG7ve8MRKD6xT@krava>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|DM4PR15MB5520:EE_
x-ms-office365-filtering-correlation-id: eba5e3c9-07e7-4172-b5bb-08dbbf711d76
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 i2rfiwG0ZOm64mRtK/RVEwk7gJc4vjEQs3L+x/GgG6KG6CCR8BbtjlF1b2UaWxYCA7aYoPmlSOJanjeK9Wl908pLJDioTxAmPuSSP3kHsuSsmKAV4ALEcxcBEpnp8y2oHMW6QTvAWf27L+1WFkDfvjRSPkf5ccekqViElbIDQEq4uuMuNLJraeUoWz/Az0833XKw8t7h7xBinXus9E4AsLB8qWqx4dmtNtKrETGbUuG19o08niYWg+5aerTqKCP8ls/oIT9HVq2N/GbTfR+zDBVKa/FX6CYlEVFYq4Oq6tCQfZp7aTb8RD2vyDo2VuqPGtMrPI4Mh2J7YzXuvlYmu3iMWt03uuIYtkSrgNYtZKrtzGsTLzX7NH5/imcxdUR/S63whgh3rhxE8hxxk+1cki32qa4PpMnaH0J+zsyjL18XHNbe8V78WrREvGsw35VTA4LdmNuPyNR0RY711lIeODrR7v/DrjX8Y/C6GY+Cn/oqLjb4UWWKNVkeqedO94FvK18G8DdFhjt5ghlE/sv3X6dhRz44JTp2yGY6L4dgcCadG0K/E0U7bPJ15HRX23t/YxwXPTL1igzCw8A8cpcCcxrmdEl9enicWHAhVhM4oD77tdZ6abQIrlSJtfHRwFm1
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(4326008)(8676002)(8936002)(6916009)(316002)(66476007)(41300700001)(66446008)(76116006)(66946007)(91956017)(54906003)(5660300002)(64756008)(66556008)(2906002)(122000001)(38070700005)(38100700002)(83380400001)(6512007)(9686003)(33656002)(53546011)(86362001)(478600001)(6506007)(36756003)(6486002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?e+sHf+ltKfHrnRhDRVzI9mTzdsRGlYrVUXIs81EAGKFJswItREcRyw/5fEQw?=
 =?us-ascii?Q?LV6PnFhapVpxHoOufj4+tKZKGLkNmm5NX37L2YJxq/9H7ZUJVKuEPDiHCSN2?=
 =?us-ascii?Q?g9p14L5e9WiGxZcfvdMsMeXlMVIxNQgQ+8oBBmddhop1lmExbr9waKn8dxIV?=
 =?us-ascii?Q?+geuDpqvBwe1ool2rYPvtwRHMX5QsVU4wFUgjWIa/MphRtFmTqlxFXTqsLC4?=
 =?us-ascii?Q?Uto+DQR+Bo/EphAoOtToEjY2jiPV2Y8t4XQQw6QxTwfGOzZ3bRQgVOuZokUn?=
 =?us-ascii?Q?Xp7BcBuGdx8iveLmDnD2yi7aieJDVaS1xJ355LhxupcVJEicoL7vVPpyC942?=
 =?us-ascii?Q?CxekgbTvnOLakXlcewFZvqlVGDDtMhkFuyWaLBwQUe4oLYl7AsXajKaveX8k?=
 =?us-ascii?Q?mQva1OkKGJcZ07E1RHCIEcgEcSz5VNtrbyTTYlF9sfgk8pwk44LB2ftNce11?=
 =?us-ascii?Q?D4c26frepnEzGyYWfwbJNrCwv+C+4KiGdX2qMG0hD4Hi4+Yy/8l41QoNDvHf?=
 =?us-ascii?Q?8varZyBdd4RmAICLOfevED00QsONNzGHOFbrnQkXyjffKSx4Wlqdrnd59zxj?=
 =?us-ascii?Q?wgN7EiEJOIYYwNvu4cuHxbm7MTr8ZuniYjaGX/rCZwP++X4ISNBZVmGx4Nr9?=
 =?us-ascii?Q?0ACJZDVEEEBTWogeN9fHAZ+c+3JIu9HMowC7O6kflHILcSd8CnzZo6Y3X8V+?=
 =?us-ascii?Q?TRiexUN9ZJ9VUnjiUYY6ITezDY7A4xGE98d+oi8YRSnA/KnTNBvL5f6rji96?=
 =?us-ascii?Q?WiqlNJ0hUnYF4Zdb06Lh8Kv2x9PUygcSyYiu0/XRk0/R8jGsaSomywfFpAN1?=
 =?us-ascii?Q?AJ9L/48hqzD14a59F29mKAFgDd3RA5fgbbgOS1Fvxnfymg5oTw2sKZcnadpI?=
 =?us-ascii?Q?JNaza5nvx/as5a/7ncW8PpGt+uXOI8+FgJIt49MBbMCUbZuQOXSdoUdq2aIx?=
 =?us-ascii?Q?rOj4813ETsQGjf82XkWUJP8dkJqOO53CDgKz7TB5EMH09PFTAH+ILxSso6re?=
 =?us-ascii?Q?y0PsyuS9/s6L/jZP7UEAeHp2xg7kCh4C7DwpiXrf7Z+hpgBtJTqff5+MtRhi?=
 =?us-ascii?Q?SLHFqT1yOtMs6OR42iUcHeqNn2mPoIsniZiQK5VV20D4HCKpyC7pX4FvUKBd?=
 =?us-ascii?Q?Z+tWHDaPvDVhsn3uoWTWNtzNFU9/iKxptKGy2p0EO36zELZQafuhdRu6AG26?=
 =?us-ascii?Q?7dyJIF0R+3ymJKOBb4uSIkX1068TVrnyP2MwhFBeaRlMKOVT63XOX9CQC3Of?=
 =?us-ascii?Q?Q9KsDbYMyRnjrs+NPenBqugCLJZHCYnfEqxUY9jcYS6IzSTfQhhvHhMrrriz?=
 =?us-ascii?Q?xC7xI2RWspfNy0vuJRPuuHUB7rAd51xfSPYfw7SXH7LJvryCXzB5iQLavUMB?=
 =?us-ascii?Q?zJ1/u8aySDLjCMBnhrqpAXFde4kLIShgncSqNCboMdzydauOKnZovbITIaLh?=
 =?us-ascii?Q?h7sfdguTm2epyOa6ZrG2bCpIhUVxWY5f/xvSgP3bs1BqsSQmd2w8nfD5p/34?=
 =?us-ascii?Q?Qz3w8AtH90mz0lZcso/Co65Ja870Yc60OgVw0b/kIhPI66J9VpBsAVORQ434?=
 =?us-ascii?Q?ZwEQyiY7g/y/Q73OcJj8QTmPtc4fWkdjgoJbaglbvwypkw6Kn9ncShuku+PI?=
 =?us-ascii?Q?gK2AqX9BkAaa/0TvVdTxhK8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F8F921064C0B9C42844734CD6E6F3818@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba5e3c9-07e7-4172-b5bb-08dbbf711d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 15:47:54.9424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9EwSJFTgABZi9EjIHcShH03/kL0AWs1iAbHlxV2PbjwEt3qsMMcKT1UAZ4Olg1lTnmwvtcdmqrD7PzXBHBbnlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5520
X-Proofpoint-ORIG-GUID: ZiyOc0QwIoWJUqDFbRl7UVpi8jpiuOKm
X-Proofpoint-GUID: ZiyOc0QwIoWJUqDFbRl7UVpi8jpiuOKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Sep 27, 2023, at 6:16 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> On Tue, Sep 26, 2023 at 12:00:20PM -0700, Song Liu wrote:
> 
> SNIP
> 
>> @@ -2665,25 +2672,61 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image
>> if (flags & BPF_TRAMP_F_SKIP_FRAME)
>> /* skip our return address and return to parent */
>> EMIT4(0x48, 0x83, 0xC4, 8); /* add rsp, 8 */
>> - emit_return(&prog, prog);
>> + emit_return(&prog, image + (prog - (u8 *)rw_image));
>> /* Make sure the trampoline generation logic doesn't overflow */
>> - if (WARN_ON_ONCE(prog > (u8 *)image_end - BPF_INSN_SAFETY)) {
>> + if (WARN_ON_ONCE(prog > (u8 *)rw_image_end - BPF_INSN_SAFETY)) {
>> ret = -EFAULT;
>> goto cleanup;
>> }
>> - ret = prog - (u8 *)image + BPF_INSN_SAFETY;
>> + ret = prog - (u8 *)rw_image + BPF_INSN_SAFETY;
>> 
>> cleanup:
>> kfree(branches);
>> return ret;
>> }
>> 
>> +void *arch_alloc_bpf_trampoline(int size)
>> +{
>> + return bpf_prog_pack_alloc(size, jit_fill_hole);
>> +}
>> +
>> +void arch_free_bpf_trampoline(void *image, int size)
>> +{
>> + bpf_prog_pack_free(image, size);
>> +}
>> +
>> +void arch_protect_bpf_trampoline(void *image, int size)
>> +{
>> +}
>> +
>> +void arch_unprotect_bpf_trampoline(void *image, int size)
>> +{
>> +}
> 
> seems bit confusing having empty non weak functions to overload
> the weak versions IIUC
> 
> would maybe some other way fit better than weak functions in here?
> like having arch specific macro to use bpf_prog_pack_alloc for
> trampoline allocation

We can also have a few flags that arch code set at init time. 
Then we can use these flags in trampoline.c. But I don't think
that's cleaner than current version. 

With more archs adopting bpf_prog_pack, I think we will be able 
to remove these helpers soon. 

Thanks,
Song

> 
> feel free to disregard if you have already investigated this ;-)




