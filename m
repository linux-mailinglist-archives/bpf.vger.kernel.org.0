Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8722D66076E
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 20:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbjAFTxh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 14:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbjAFTxD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 14:53:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8231B9F0
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 11:53:02 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 306HImwm025184
        for <bpf@vger.kernel.org>; Fri, 6 Jan 2023 11:53:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=x2OefQ6Cf8QzGLS6xd6FHPAhTZHkvkxTYAWYi2uKrKY=;
 b=jtkNF53P7OCUBoTHtJoGt8IvyynL/7rITRVsbPxB2i1HwV7wCPkwClUND98w6b0I1ms0
 UHYAe2NdBNfZnlz4sFK5gjjSbzblEH4KdAflMHOBJ3TRdVLmXquiYcooY3CFt7TPrGsN
 fZlx+4ZCcrQP7OBC1XIBb+wLvLvPWzCkOR9+PkWUvJUu8l2iG0JOGzntJX64r9f/MDM9
 9ZT2bm9ZMlEiilcz4gd/lsWjvHZFxMdD8uRQlV4JIM/iDo9Do4R+7+bSZQ9QJuGr9oD8
 ITSQXWxCQsqb12+7HR7Ow952dBzH38ulyYy8PV3f/cSvxZCkwfp0rYUK9rzr/1x2UZGg JA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mx5gtdsr2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 11:53:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwRaMW2NnZZuZZsqy0lgCkVqlg/bRM3l8vb4FzRdmKpqucSmUo2lWq/LWKLjt+eWzymVxK9ebsG2ZDANisjwIgwy06hhhN/oUpTl+Iyw1hzcU2r3beMb/UFbEd1DgqzAvAAqKjOPYcTo23uD5NRbaofv8YEdbxM4ihxLPtgCtYR63DZJPow7+K02IZSDrB7TlMBzrAh7bwiTRJGA9+lAxC9qrxN3BjeFnEwV6XO6exj4o1Q8AX5IAhNvTPfJ4v+ZeNAmqrlzBG6JcZcV8Wo02stm4FNRWuZDqksAk3nglIZmCVQh5tBkVAJJzEhEuHJLyJSvfoH7ZcI859yJ9h2L8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2OefQ6Cf8QzGLS6xd6FHPAhTZHkvkxTYAWYi2uKrKY=;
 b=VLIs7wxi/r2wS4BXDRyABDR4lvO9DoKLqQ7iFfHXW0WHN9GoRpa88n7Qu0hOT3TeNLa7b/Nuf1ORq2DJe7PMC4iye9ghGIe87uFdBgKa2zdyOp//DWnzr2lEbVQZuF4JnB81GH5CyN+aqS1wxhQCwgskVlranRb7FlOulBsJRVhcT+MipfPnQOrAbYLcxkeJvit9L7x9DeGGgv6QqUANQ5GGemddO2nnfz2mscITBZzZ7YkDzbaPfFes7Ax5znyTWpjSvKRGfjrEqbT7lwGmRzq/CD8bYsBcsAtJfM8KRamU4lNAlsYo+kVGqmtL+pzpo5Qy8yu56VttHclR5l0RVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (2603:10b6:208:3d::12)
 by DM6PR15MB2748.namprd15.prod.outlook.com (2603:10b6:5:1a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 19:52:57 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::7ad3:6906:e150:8eaa]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::7ad3:6906:e150:8eaa%3]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 19:52:57 +0000
From:   Mykola Lysenko <mykolal@meta.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
CC:     Mykola Lysenko <mykolal@meta.com>,
        Mykola Lysenko <mykolal@meta.com>,
        =?iso-8859-1?Q?Daniel_M=FCller?= <deso@posteo.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@meta.com>,
        Andrii Nakryiko <andriin@meta.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@meta.com>
Subject: Re: BPF CI issue with s390 build
Thread-Topic: BPF CI issue with s390 build
Thread-Index: AQHZIdA+wolRGOoOPUOK967Ph13eZa6RlM8AgAAeZYCAABocAA==
Date:   Fri, 6 Jan 2023 19:52:57 +0000
Message-ID: <CCBBEE5F-44AC-49A3-85AE-F6E2692FC7AD@fb.com>
References: <0c25d95234d8e009fe57199ce35b9fd18bd2cb78.camel@gmail.com>
 <E5735DC1-7E84-412E-A7A4-432E5652AB91@fb.com>
 <e30d8e8b50bfdc64e85862d389f888f87bf5e8b4.camel@gmail.com>
In-Reply-To: <e30d8e8b50bfdc64e85862d389f888f87bf5e8b4.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3213:EE_|DM6PR15MB2748:EE_
x-ms-office365-filtering-correlation-id: 05a5fed2-23f3-45b7-07a3-08daf01f9bc5
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MhPYzvvJpL+/e2D+JFNR1Wgm9u4bOrYM1xb6VAqPFEa2GvPPduYQgDgGHmiS8PeBCd2ksDQIQWq9u+1kk3f3LnfnR1RVlJT095iWf5kMDJwJjz+/VubdvR33cpjRCWl7/Y2VY2KcgKm/arypp83ujkZIFMmLoYJncPXAk+Rnr9S685wPFsMVDC8I3+f5XLyX0WzgCGqOm8rhr8Yis8wEpKk+Wh3SX7EEjcNxRLJMW8n2VRwJGb122Chcj1Md0N9NVFgZ/Mu/8IPxcfZiTb4zuVIR8NXSJm0wZHb+wUoKuIaD8Lt76wpIgwMA4q3puHpp03xeZGxXMfOhBeVnZAFdCBY/L3zVvZoeGrQIYbXYPklkSBmeBTi/exbRc3u36wAMekrRh7LM+x+JaO5cMM5Bw05n4a8tkCfDOGIUMPYu85OPM78dTfkM04+JRpHcUN4YFZ0gnWZOde8wUAj6FCdsGKcA+Aeeu2nIsjKUEbWqd+S9eL3sBjahUQ1VcI4sdJ4qwGuRdZg8l9R3DNLsqCvXwvmkXQXVyGtRMP9TPM31uTIeG9CZA8e0aie2nv1Lmr6DyxAa3GtHxLxJkO2ltELVrNj7p8ST6PgoxJL5xVhgad4mLC4m5nXxfvQm0w6U4UnFOkOwI46c/zf8J5XrSEkZpfILfssklRB8ynk0y+G04BCYdmnHk6Yf3wCQyAXSr1JxKHu+trzXlU3Rml8zk9ohDDnfF5ESllaJ6uW55KQ2wIjqPWEyx6BOTxPgWHQkpjYqC7HDhOIbGtUMQMevCmZhqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3213.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199015)(8936002)(64756008)(76116006)(91956017)(5660300002)(316002)(2906002)(41300700001)(6916009)(54906003)(66446008)(66556008)(66476007)(66946007)(4326008)(8676002)(71200400001)(6506007)(966005)(36756003)(9686003)(107886003)(478600001)(53546011)(83380400001)(33656002)(6512007)(186003)(6486002)(86362001)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gfDCpU4zfPZ123QC6W4Cx0x0sJVqgmQKmOduCZ5CrdCX+MtxReLZvmmX4n?=
 =?iso-8859-1?Q?L6c9mXo513sQK1pp22MIWXGTlm3sj3xDGGxaDEy71MmxAZm8AI55wZ/FT4?=
 =?iso-8859-1?Q?rnBK+ybDphIEN1OPFmkhf4fFHwJkAQvtOqdeWKkvOO7Nkzdo27h2f5xfWQ?=
 =?iso-8859-1?Q?rWAREYQEDiKz13CIcYD2uxgF1v1xrK45ABuC+VdiJ0tVXjxWssoaKR5Qxl?=
 =?iso-8859-1?Q?ikPhjdpHXKktobKflXW1kG377Up63ikUXwcLnjESRWQN0xc2vPTC0ZftGy?=
 =?iso-8859-1?Q?n14kBX7TucP9lTQpQ9CfoOaWAnSSrGlskXwLgdhbdNlcw6J+R+nLHsOMu0?=
 =?iso-8859-1?Q?kJQ5RWFiEHTicMUM20bJfX8gmuTX2BEBl65g7GIPN2N1WGlKp5W2VE9kq7?=
 =?iso-8859-1?Q?yVX4Bb5ruRUw9yZxBnDw/zZbvUfTcq9cL9nO5h6t5Q+C3BlpYcZTVtrtyx?=
 =?iso-8859-1?Q?8hB7TPFUq4nhoJIcfxN48sYsRBX3WldGxqfB/Mx1BF14smwQh50uCHHms+?=
 =?iso-8859-1?Q?XG725c9gu58NgG1gAEbV8aPfoWNOVjraB4oK2RGeWW17Fl2kPod7AGqofG?=
 =?iso-8859-1?Q?cxqqaRMjk44wBOw/Hgyxx2OTJBPC3kOqhZWausWjWb/2+NX86EU7uoA+PT?=
 =?iso-8859-1?Q?oQewkKQEiaUL12R9PzoU4WL11MmMFtbsSnPMF+gWJ44lDUoERbgbq6oNTA?=
 =?iso-8859-1?Q?jEkw0KbWl2blmyzu1SI5/mzqtt+w2UEQKvrX2uhOAXpY9Qvm4GSHk4ziXs?=
 =?iso-8859-1?Q?Zom+WZgmyu2DWfianKXISxTlKVfF8sCP9PnrQInolVGkWiHNLmG/zzl7KU?=
 =?iso-8859-1?Q?gXGPwty4kMi+u0pmpKQFdNfCZNrhWFzy0Yh2t15Ce0B1E9OF3jQPuXy7h5?=
 =?iso-8859-1?Q?zkNTaZNmgXkp5H0t4KZkgVHArjLbU9dRb8D18mymFmWGyFC7Lb9Z2fQDOv?=
 =?iso-8859-1?Q?zSrrp7frVfyGmEhYHIKI6Zv7WOSfemBggt6Q5R3yW0qFbeseFvkzpgeUYV?=
 =?iso-8859-1?Q?IQolEyrYQaH1x6EsGBANnlq/URAxOEwc68oWQT+SZh4I6s1kZrZFXyGFix?=
 =?iso-8859-1?Q?0tN1AMCsQKihjdNv4ZMOOIv+SUkEn00LcZSZWHMl7itBcT90cu2By9JB5v?=
 =?iso-8859-1?Q?CDjVu+cBnUXkCJVUgikXzHgDNCkzqHX9v/SHHRDo15ewQNqVKLUqR8TOeW?=
 =?iso-8859-1?Q?k3D8GDZJPyvRQC5IXrFEO+Dq7W5Kb7ffKYYAZeESihWHevhpFxhZwhsUqK?=
 =?iso-8859-1?Q?UzeFG3SIaDlz1OSxW4tsLyD+6nmMbCA3O4dgkSrBv8WQHN/uyX81gi9zUJ?=
 =?iso-8859-1?Q?NoUjNa8bsqjnZ/ufRdQu0O4PT9KEAW4vlZ8Z7nXFOvebbkt2wKB4BHpW9j?=
 =?iso-8859-1?Q?ZaUZQZ0yQJoodN8acoJzLxi0doSCvJWFcqi5VZWfBooqpXMFRpAJyQCJ2i?=
 =?iso-8859-1?Q?4nahkOeHq29h0Jo6VrTPMkwUG1+aYNGrIHXhjcR7N3wSnooDH95ULHxyZe?=
 =?iso-8859-1?Q?ZeC43e/r2PPjjbUXkorXJ2O0+E1qENXfrQjK2WI+bZdZAwI6lrhLXDD/9l?=
 =?iso-8859-1?Q?x7452/uEgaxPP6RjigKEzquw+G7edG4cqmDpM9tcqdgV1A9bfoObp3QLiJ?=
 =?iso-8859-1?Q?YBAJV2F7AH0SiOu0d8EE8VrHIelGhPcGDfVAQZltTmbT4WphhJdSsTaHI2?=
 =?iso-8859-1?Q?USbJaabaV7Y4zxUOReFGpB3b0nT3PRrF+n5UdpaQuT0hJduPhTxAqfbovF?=
 =?iso-8859-1?Q?7U9g=3D=3D?=
Content-ID: <93DD7145D4D56B4B99100F113F99E055@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3213.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a5fed2-23f3-45b7-07a3-08daf01f9bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 19:52:57.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PixtkY6QyahPqIuvpC9O5iIwkznAcc7S1gxy66Amvr8cZB4aPukZ/er6PwwX6XibtCMiLxn49OlZC5VTSJTgMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2748
X-Proofpoint-GUID: nKDd9o4puKkZOXij_8AC6SzzKm6kFfYx
X-Proofpoint-ORIG-GUID: nKDd9o4puKkZOXij_8AC6SzzKm6kFfYx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Jan 6, 2023, at 10:19 AM, Eduard Zingerman <eddyz87@gmail.com> wrote:
>=20
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
>=20
> |-------------------------------------------------------------------!
>=20
> On Fri, 2023-01-06 at 16:30 +0000, Mykola Lysenko wrote:
>> + bpf list for wider visibility
>>=20
>> Hi Eduard,
>>=20
>> Thanks a lot for looking into this!
>>=20
>>> On Jan 6, 2023, at 5:10 AM, Eduard Zingerman <eddyz87@gmail.com> wrote:
>>>=20
>>> !-------------------------------------------------------------------|
>>> This Message Is From an External Sender
>>>=20
>>>> -------------------------------------------------------------------!
>>>=20
>>> Hi Guys,
>>>=20
>>> I think we have a temporary issue with CI on s390 caused by one of the
>>> upstream commits. All recent pull requests are failing because of the
>>> build issue on s390, e.g.:
>>> - https://github.com/kernel-patches/bpf/actions/runs/3851652311
>>> - https://github.com/kernel-patches/bpf/actions/runs/3851642638
>>> - https://github.com/kernel-patches/bpf/actions/runs/3851641331
>>>=20
>>> This LKML link discusses the issue:
>>> https://lkml.org/lkml/2023/1/2/30
>>>=20
>>> The suggestion is to revert commit 99cb0d917ffa1ab628bb67364ca9b162c076=
99b1 .
>>>=20
>>> I did this for my pull request and it worked:
>>> https://github.com/kernel-patches/bpf/pull/4299
>>>=20
>>> Maybe temporarily add this revert as a pre CI patch?
>>=20
>> Yes, please, create a pull request to https://github.com/kernel-patches/=
vmtest.
>>=20
>> Let's have PR pass the tests while waiting for BPF community input, if a=
ny.
>=20
> Submitted the pull request here:
> https://github.com/kernel-patches/vmtest/pull/186

Thank you, all tests passing, merged!

>=20
>>=20
>>>=20
>>> Thanks,
>>> Eduard

