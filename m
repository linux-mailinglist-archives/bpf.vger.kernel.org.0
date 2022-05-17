Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8252AD58
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 23:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiEQVKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239621AbiEQVKD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 17:10:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2362F53715;
        Tue, 17 May 2022 14:10:02 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24HKFHNA002129;
        Tue, 17 May 2022 14:10:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=v2j8gyVyNBzi9Q1DmX/2WgA/4DXtXXfi5q689sq5WXc=;
 b=CztfCdFt1AAsdgVqyX+tPQ8gDEkwwAcnrdCM5Xe+pa2RcT6Zv/J+XUkVFqvlXH6tJx89
 YUP77Ty2z0DM66gBfrsyE1UCXjQMvdONLdzAlEJPnB/EOHqx4X1BYRtMrb9RWnc1QOZt
 nyrxlht8BQys5cn7uR63xUCbXSchxITawHg= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by m0001303.ppops.net (PPS) with ESMTPS id 3g283wmtv8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 14:10:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kb3UpC6UvvOWw1LH/mGaQhicZGZixIyLotrY/+zS7sHiRP2yVrBKZFqGfEDbx0hYBh4RMqYmhGetBPkxG83OK9rEWVpuzRMKZOiNB/V37fVARKNSoSqfooJpKWaCcDxV3q+tulB/Q7ZLNcguWT9IImy+W/TxRv6MzWwMV1ZOTTGUlTC0ct5qgFMnFv1bzUXtR/5OaZGDOGTYA4r7hu4zsOz/yFNXfT2TB51fGOdmu0KfKa+e8rYOAckQnq2tB5HXKZsGngY4GaOFuqjQ2UMIqqAvTpnZLokbBRJaqIauqWqSlaEQX9RY1b1k6G8NmqiASQKI3r7mZxDs9C4W/Q6Ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2j8gyVyNBzi9Q1DmX/2WgA/4DXtXXfi5q689sq5WXc=;
 b=Q2CeHQPIyQ5vLMHRQON35bu46kO8OSO9DrPnD4Zv1i9GNaGY+h4aYGyWov2LaS4bN+BcYIdt/Gehlbn0NW4AEf9Idmjiw4WgokdrzsZEh5xYzc6OOthO+5RDTruW/YA+FrDnSm3MhWgq3S7QGKdBBJmUFol7oDrTPF5Au6II1Cd8GCkG2XeJRufN/NIU/dYsMZs3E3y/RNvFcPQ07JV7kp/zPI3ORrJNU3Kds/vcrl3qqNNhr48NIq2YYhVNCzqnBX4M3qOPgA5Ha9xeDDJC7xhvPzyeWzMhcN81qAXIk2OZ16Kv7kyULyd7AxoWuxKe4C3JPBg2RI4cRC9d6/HkhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN7PR15MB2322.namprd15.prod.outlook.com (2603:10b6:406:90::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 21:09:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%5]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 21:09:58 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Topic: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Index: AQHYaOeQGQ/WNhSrw0WYR6bm3RcCIa0jc3eAgAAfpAA=
Date:   Tue, 17 May 2022 21:09:57 +0000
Message-ID: <C71A3F08-5FDC-4981-99E5-F486A048D377@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-3-song@kernel.org>
 <e681c4083fc53cedded845301e8df7a4910d1075.camel@intel.com>
In-Reply-To: <e681c4083fc53cedded845301e8df7a4910d1075.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8406cb27-ae3d-44dd-ef9b-08da3849992f
x-ms-traffictypediagnostic: BN7PR15MB2322:EE_
x-microsoft-antispam-prvs: <BN7PR15MB2322019D4B36D21FA341B141B3CE9@BN7PR15MB2322.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CdkEu8pjmFS7qpvLGUahAl5Uzf5LTu1BMHrvUb4wxjtM4pW7JubJ/mQ8rlrgq6u36KrY8vQk2cln02Z6q+Dz2wgGOslzphXkysnP1gQhStADguY003kKnl6khAcZkvdvUQIUP20dPqunrPBcr/bfyDmCQisDklx4M8vH8onngVdpx6hj9to/CmQRgjKYtEinau+0y1uvWJ4YWX7ri5UK18QHaVqtXFSQUZ4sTPYPJ5FTX97LgzZN20p2WutHxe/FP0/ZVlsAxSb7PALSazLCLnWWBKwewfKuR/R8Zc3xWcUa1JuxBhOCUaw+G5rbsxbiqgKdem7fXU4+WJitGEWpWV1cVkOO4uos162+/SUq53hUQ6+NAR2S2qHsLPlpcHOrmW6ptvTgFK5l3d+QAxfTWjbNgnkF1hpsQsQOqchWFseYa+cqm4pU+yYWhZtlzvSvoBbLLMabOMPhwclTDAErJ2tgW540NadYB6atUq/qIZ7jhj8oS7T2NgWLxJm8duIn6G3wFCeMl9KfkXbPrXkCbOtVyFsllSsNX/LEnSb7/QuydasoeuFfoAuGDTTxZeTw+Mm2Cs0J0OqrTAgTqH620qKIfFlq8ocAcANMfuF94+0P6fY1KzEMKpSThk+8gst408ar/j5lUkLoQCa42mNMUh7Nv0PiaCm8ZuN6lYryBOGvYlSTo7Lf0FiAze+iVKvJs1hSkUqW9jI8YTvjnDFnyvUwnpm/QX91GssMu3VNdYdIvym7Kny0ovDd/+IeLWR8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(4326008)(64756008)(66556008)(66946007)(66476007)(66446008)(76116006)(186003)(71200400001)(54906003)(91956017)(6916009)(6506007)(53546011)(508600001)(6512007)(6486002)(316002)(2616005)(36756003)(2906002)(33656002)(86362001)(4744005)(5660300002)(38100700002)(122000001)(8936002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WoLFZ6xpMsCZq75nww6Y21j6ZSjpsG6yjPwJFZqdNA4wc85d8HeKr/eb2VuC?=
 =?us-ascii?Q?s/W/mNZmPggyZUkhXo1NewCJUFOXOf89aHP2yLfsy/x8QfYS3WJs+Pkkt49p?=
 =?us-ascii?Q?6lRavPfCtiW71uWXYjHerVXULc1ExxZ7Ga6mwujwD5uUJ2r7jlE8OHl2E4HA?=
 =?us-ascii?Q?y8bgk1D0mVpv3NRY0KSHLVkjfYxCiEvbWfdAn6CVRusnBmKFAdciCUO4+JBM?=
 =?us-ascii?Q?tA/onfjaExIAPNYo2Rpfn4GT6bQCeHdIj9FnUQ8AP4N7qkKjGtaH1yMgAvau?=
 =?us-ascii?Q?eVYGjgFsgw1mjcx3K4P4DEEwNn8kDfIxwvwC3SrqdeSTSA3OnHibHIceMpt8?=
 =?us-ascii?Q?Deh4P3zzLGnglijgDWU8+qwa9nlE9E0RzZcQnuo2BOccmp65S+F8Rk1YAwv3?=
 =?us-ascii?Q?7M7BYBzcpsGyuEREK92VQzNcimbiYx6w485UxF9P2YZapkfTwBQNehvPMym5?=
 =?us-ascii?Q?gQEfRs/oyfiTnOJv9tnWiPg6EOizoQS+e6moWAH51zc0XZ3wPvQplf1wN8e+?=
 =?us-ascii?Q?ujMIoRjNaJIrwXf3XhC/AfLBd1L/gHiHM3Dw4tDM5rVbMW8YhsUhMsPF9PSJ?=
 =?us-ascii?Q?0zQQTeYNqd4Max4CIdGMgVD0uLPYrHZfmE/5KMAL2N2ygrgA4G0YWLnvU56o?=
 =?us-ascii?Q?593zsEISm7BRV2cwD+8/3eTZJPw0tEXAHEmdmedrrW+i21phkW6xLHsa8IDD?=
 =?us-ascii?Q?D6eE9QhTRReaBHmbSy12POnRldicG2BlhtxURVz5fHwHm0nuWkurWQwSHj7d?=
 =?us-ascii?Q?Tvjg0csjGBKtaCPpV+bK7nrTRUizzhHz55Gv335hgxj1LPKKxaTrEHfu+00g?=
 =?us-ascii?Q?z6LqKjI725Meyol70f0yWkRI2SxUtc9tu6Jd2bOjeyJLeZHw2kt3KF6kzMlj?=
 =?us-ascii?Q?Wxl2NOeuX5eoZJbc4rv7zu3FKGiSl8o5OrqGyHfqZ616xQXTVaGUN8XRf8Yw?=
 =?us-ascii?Q?lnBoRhPs0NjVGMSDeP7Imqn2ufpyzdWbKDPycN0QN7KpM6HKwu8cNoYix6jH?=
 =?us-ascii?Q?vh4XMQJ/Ocx3/U7yiuQ1o9T8mzEUHETHTjEdYVoMD8uKCHAKLEXUvIurJFw6?=
 =?us-ascii?Q?ECd/S9mZdCnUQ+4vRj1KBJyVaJ9zZr36x0TZO7tRW0tfC6I7EOygTfCJVshM?=
 =?us-ascii?Q?SH5sZ8NcLoFXMAGSNZGKpcpg6/LrV5NexOGCJrsxuC9jSy7x8IkIWIo59NGV?=
 =?us-ascii?Q?zZ4rwe9mtnjPquDSLII84pKDe6yUcrGRmpyFqwGwqPqNqvGhXeLuGTFUKcQF?=
 =?us-ascii?Q?+/FMRRqv4e0J/OnKSqLsoCAod7l2sixhIqaOBofiNTfeOuD2kfO3xUUHRp9y?=
 =?us-ascii?Q?Hu6qL36RMSE3Zr6gGtUcK53aNhIAIzWzn4f2/SfTjO5472Ef0OCMlvUi51Lv?=
 =?us-ascii?Q?WYniyc45d4x0YkMZRN8qvggMrwZeNd3hhv52lOKwwyr4+UWMYMIjY9LWyztv?=
 =?us-ascii?Q?rIXC3xV2rpLxBb+ZId2OuPWdP0EBJgiO6ZEawTGLLObRfkQixB/fIH6eHvLe?=
 =?us-ascii?Q?+ul/QLWW1oRegOAr+oA2tzdxVua/Gqz0J1yGRLEtizE3LC+XzYpQ05yyCkUF?=
 =?us-ascii?Q?E9zZCO4z5TttsHC5RwIodaldhuknGcizmadzqU4rw5rrd1I2XVPWQ9mtrXpI?=
 =?us-ascii?Q?A0RF8MCf0Ny1TocjP4AlfSlcnnuZqlcqMFhr6EoAn9lxsdmW2CZmfjwVvBD/?=
 =?us-ascii?Q?VqcKeQdl5bYJctEFYvHkORKUUsRIeOgc+X0wjWIS/r96/vIYlhA/X4Pw/s9t?=
 =?us-ascii?Q?PzwsPPrx5m2e5GSAmVA1rm0jKzzTa1Zyo3+VLm9x6sO7S2RTTnqv?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87CF3FC68848B447A1F9FACAFEA5A3A6@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8406cb27-ae3d-44dd-ef9b-08da3849992f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 21:09:57.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gw0zpALxUHC6EDUWGPw9IY01qLHcjDQ/DGCb3FCVlzIdX0PxYLGUGvFfA/K9R9q34P9m93tNscn7FJgYUm/ADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2322
X-Proofpoint-GUID: D3HyMvpkWxV63clxEEalIRZpDdb49_67
X-Proofpoint-ORIG-GUID: D3HyMvpkWxV63clxEEalIRZpDdb49_67
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 17, 2022, at 12:16 PM, Edgecombe, Rick P <rick.p.edgecombe@intel.com> wrote:
> 
> On Sun, 2022-05-15 at 22:40 -0700, Song Liu wrote:
>> +static void text_poke_memset(void *dst, const void *src, size_t len)
>> +{
>> +       int c = *(int *)src;
> 
> It casts away the const unnecessarily. It could be *(const int *)src.

I will fix this in the next version. Or we can ask the maintainer to 
fix it when applying the patches. 

Thanks,
Song

> 
>> +
>> +       memset(dst, c, len);
>> +}
>> +

