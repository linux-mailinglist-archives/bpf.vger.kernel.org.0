Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815052BF3D
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239309AbiERPcZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 11:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiERPcV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 11:32:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D7E5B88E;
        Wed, 18 May 2022 08:32:19 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24I72uco018497;
        Wed, 18 May 2022 08:32:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=xNIjt7wCmcOibtkZ2rSIrc0acNu9jPfeyhUVYzoayPM=;
 b=i1PbASCOizhBwkhJr/KplShGdDJlOWxcFhoy5IXdpxmET5tqeAvqCL2nLLcyuCZLiQTH
 hAOYK7zLosgu6rHf9D0AyNagp7z9QLsAsO/FRbEwsoXQsvH6hDieHLYEdcxpacELY1Z0
 hln/jVH8pknrJCWFagrbkKpSv7d4a5RxHcU= 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g4d820hqy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 08:32:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUy9i48RTySTdY4S27xyH5gWrEoH6jNdnJ3Za1nXJmOm15AX23XsN+5sS96+sz5Hr1Q6trdIREUHbxeIEhsyOMTGBJGLN6wXI7zjzi0HJQfrIcXKlC2fVz4QD62Neg1FmVPXAzOvgY7xgR2ftsIiEWvw54f1GyxVM4Ox1ZTdsOLactvJhUpS5xfMd5IGKgTbbxSFI9uNFj6NhFtQVLg61JRqBkNhnBCt8g0yyDXaSCkYiANekOhCQ4M30PHfFIfUy+xuZn5WrqwdAy5h4Nc8r9E6KUj38keGZ7lF0NpxctjsRxmerpppp0mhXK5mB+SN+T4p7Auqw1f6HPydGEKI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JW1zbCODClr9shXiC8HKGYjI3C/Eu8a4rMWVti/U6U=;
 b=BlxIecrZaHYkMnMBshZ54efz2M1IkUr5K0bDqR7eDm8e4UkLLYZ/B2pLFtGJ4uiR6jwLGaYZyXkwVcF04UmLsfhtxxl9MEauYGZDLZwU4ECJ+MZxToNThv7/QvxnsNlunKWO/Eb3UR8vNDzNeJMtpOT6+2b8c2OR8PPUbq+JXcZN6GfMBFdxiumJsa2O66OYS7O4mHXPsLAHM5ySeMW/sWsf9o80itQU2xb575XJQGWCSJbHlHRtRIoWbJ1Z0zpaM460PFvPjLVBivNxSU0oMgFN9NqqIhSeuoiVEfg02Vw7cI3spS5FhvSl2MShDhvIbMgcaBrJQ1FSSubvZOhryQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4727.namprd15.prod.outlook.com (2603:10b6:a03:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 15:32:16 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3061:40ff:2ad:33aa%4]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 15:32:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Song Liu <song@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Topic: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Index: AQHYaOeQGQ/WNhSrw0WYR6bm3RcCIa0kN5+AgAANLYCAAIJLgA==
Date:   Wed, 18 May 2022 15:32:16 +0000
Message-ID: <80E388D2-819C-4126-B81D-0659AB6506D2@fb.com>
References: <20220516054051.114490-1-song@kernel.org>
 <20220516054051.114490-3-song@kernel.org>
 <8370EC6E-C01F-496C-8B7C-D13EF9C474C5@fb.com>
 <20220518074555.GC10117@worktop.programming.kicks-ass.net>
In-Reply-To: <20220518074555.GC10117@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 323031f9-f9a6-4d2e-3f70-08da38e396ea
x-ms-traffictypediagnostic: SJ0PR15MB4727:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB472752686E014773A79A36DFB3D19@SJ0PR15MB4727.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5YZp6F+d6HgUSM96YJ+ceg6PS17Y7F1Xgoi4s6g8zQnzwH6Lh9q735XDgPrruUYrTPcBsdDOddNDtqamF+PZ8EOEr49R6Z0UQtDA1XrH/Vg6FP3NDMQEPd7uriUYY5MkC+lVS+xW23G16NinRxM98qhpJwKZW3EuuIiVK9iGTA/009n50ThxzU3h97FZMM9UTJZgi1he30wmVDbFEtbTrcw8lKO4vlo2eYmqCpFI+VLFtGrISgtj+u4p2lNg295kR9jG1p8VJkaODPYDP2MB/kRHsUoQiY9t1Dx9Xn9TRXCEo92F/ru9jvzi1eub1Pf2ZRUo/rqQrtub3DY6qGdLR9e99Uwyv0KZTQ6e1wwaQxUFOw86mYJ7lHnVrIRUh+Cu2prJE1OKgb/rX8K4zCGNIYSpXwxxORUGW1kO9eKogtZZxt/uc+rP31T+XEYj/t6D5oTvHMTlYzL9IFlsg+KwPA6Mg2FlxW/VjPdhPJvmUD3OeNhX9HBpgqtt30WZ96WI0QXHydcyY/ZAXlc+Yd9XimFzLZ6TYrLWDEh5SLPmbcSHDqtzi6w9lQPlADokQx2L+2IWGNHiAM1IejhMUMT0ajmPxVgClz/rtnsmwBKoijRleQG1Gq5L6DXsDUaqfSexe2tWBFET0I7Uo77rbo9vDqLZCjI6AsdJSge3s82OXP6hynr4FMG055RUEms0q4f0A10Rb83enjq67F3RqC0tbzxmSzxGylVK17wrIaNRKqI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(122000001)(2616005)(316002)(6512007)(38070700005)(2906002)(6486002)(6506007)(76116006)(4326008)(64756008)(66476007)(86362001)(71200400001)(8936002)(508600001)(53546011)(66556008)(91956017)(66446008)(8676002)(66946007)(6916009)(186003)(4744005)(54906003)(38100700002)(33656002)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fPxIHIzZdT5cCrQSXT0hRBGkAd09yXAsjTruVrz3MhTJudy9KmSDY96dp41S?=
 =?us-ascii?Q?t6qlHMy/EAbFDQvm2eFXr7fIRdI+t8h70Gh+sLJ87l2VQqcCPucaXzMK4UzO?=
 =?us-ascii?Q?WN9MW6qGbXywacYvzCogHoasUXQJkhfBURDuMXB/0h7Ooa6K4jXy+IV4dkC4?=
 =?us-ascii?Q?hYM9BL4pUkT1dENqEGIGrhacUZkE2OwZ7HhtQUeK6nOsKAZkcObgDkk91Wc6?=
 =?us-ascii?Q?Hv5ntQJXLJ4PZiQ3DELIqaXdbBp1AZZ+WxLiINGDyEjuKkAcNNBq8PTDcRz9?=
 =?us-ascii?Q?FU+Gu906k4Z7qdQGF/cScP9/asRw0Sczw/w56d/jVEAnWgjNr3RkjDkQ4i9G?=
 =?us-ascii?Q?GLIlR4d0VxrOZjRrBNUnUlBgC08jdZ+/1gQt+Kvj9yEdk4ee3uvIYAcJvdZw?=
 =?us-ascii?Q?DLdlWRa7F+3Q9EyknGNabeiF74DgCwOrQQuZLr7Km8Ngb8yrKLaLirRC59jV?=
 =?us-ascii?Q?qQYxdenimYnim3pXaTKffrKn15pI93TmILVC9JbMK+spadPpZ0EE8Jz3O1yj?=
 =?us-ascii?Q?H98qNbRyoSKGgoP2f7ZCUmwr9IrKG6ICoBPqO/72C6ohcf7XDIQJCpSzLqb3?=
 =?us-ascii?Q?drC9siq81Fx8BlzvWPuWv1veS2IB1LXdO14iEEoXP0FoLROEecvTV/MiP47q?=
 =?us-ascii?Q?lhIRbZObH9Cb+Kq7LiHW+/b3vnylcRi3ShYZ0FgXDhn/HFZRg9WKCAUiPWXV?=
 =?us-ascii?Q?EUNCQdsibNQxZMI4ihLfI2yAS5WTjQvhKdmnzmAW5dawLd9pyn++wNdux1tg?=
 =?us-ascii?Q?7IyiUkIKDO1DQw+T9Jv1NI7+4KiZBl4+erYD32TX0KdropZXp75912hF5jHr?=
 =?us-ascii?Q?StGnMk5hxPxzd9DBbWo0lBIA2TadGg1ppSorpQcZSS3QzX9a9B5DdijwQy2p?=
 =?us-ascii?Q?CxRLhjlIP8cvNHOHJ5vlPcmg+7G4YMJkjq8emS5ouHGwuftLcII2up3LFbcT?=
 =?us-ascii?Q?tH1ughu0UYqZTWpPD3/HxgHvAcJnOfUTOBteKnNtMEHWd2CYlAQsSfnDKdHE?=
 =?us-ascii?Q?9PrQXNfULDnnN320zJm45Pupw9h9E1NieueD9Z4l5IKCyLbDGV0NIe1k1IdJ?=
 =?us-ascii?Q?lXVBaz740x0lzK8lPMHnRz+cM3DMWgUq1q3cGF+PRW4CbJFDS8U1zK4Y1zat?=
 =?us-ascii?Q?1frXyppAjlxzWu0vkdHzNoxKDLy3KnjtaUXYqqAVJn2G407dN0hB/7FTIPNQ?=
 =?us-ascii?Q?hT90cqMKTz04sWXKbubDDglvggcftwiMBUInRFwykfpcRN/Tc1w7/TlaH1bB?=
 =?us-ascii?Q?3IvFbIZ92QvVuhzGW6q6NQu7A3c0qSsjDjNgQwBvJ46+C/JuTaURNDNJma84?=
 =?us-ascii?Q?rzYNYIsPixoVoeSmLsXGU/CHwhuPucGWMW8SnAgn6Y28F1Mp/zf7V3bYxfg3?=
 =?us-ascii?Q?fKO2U0wGvidPYFRSBY/XPoo8kahytAkgyFWmZS+FYQI96b4C6x6ZQCx2Gsb8?=
 =?us-ascii?Q?yrU+7IkD4UGg3IPzPeX6j3rmGgqfT8uwO037kIF1KRu05WTxpSlpMaMjyPR1?=
 =?us-ascii?Q?MHZgIUjxanKQT2CBed9k39B4NyTVkAOAD3HNBzaoOm3nLnxxBzycXKGLU9un?=
 =?us-ascii?Q?hnrS2JGkz0f+9eQwBHJxRqDSbiNqmMevk+piek+pgA6iY43ERBwglMJvfozd?=
 =?us-ascii?Q?43WrJEldp2Q//vw6mnJNcUnLNiCkC99JUmL/6sBECJbOGWLtJFgE8kuddTiE?=
 =?us-ascii?Q?1C4xat5zTzrUiJYeP7xjANbnwEMxK7NeSv9M+P+Z/8gSqq42xMvMY1yCtbNG?=
 =?us-ascii?Q?x1G4tiSWKkHUC8QoZ1r1DH6RjvLwHRjacFrl9JdW9APXeqYR21Oc?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9ACC86117239A44A91FF5495E6D0D8B8@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 323031f9-f9a6-4d2e-3f70-08da38e396ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 15:32:16.6543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0am4SpV6LgtxlGyBb1EJLbwYFC2aWENXQC6LMfhERjOViwzY2ySQagK+YdvUIIx3W+PuhE6BgvfdUEH6KTWbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4727
X-Proofpoint-GUID: cksIsBgFAEWOKuRyq7bYE8qP4hQHkSoq
X-Proofpoint-ORIG-GUID: cksIsBgFAEWOKuRyq7bYE8qP4hQHkSoq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-18_06,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 18, 2022, at 12:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Wed, May 18, 2022 at 06:58:46AM +0000, Song Liu wrote:
>> Hi Peter, 
>> 
>>> On May 15, 2022, at 10:40 PM, Song Liu <song@kernel.org> wrote:
>>> 
>>> Introduce a memset like API for text_poke. This will be used to fill the
>>> unused RX memory with illegal instructions.
>>> 
>>> Suggested-by: Peter Zijlstra <peterz@infradead.org>
>>> Signed-off-by: Song Liu <song@kernel.org>
>> 
>> Could you please share your comments on this? 
> 
> I wrote it; it must be good! What specifically you want to know?

Maybe just your Acked-by or Signed-off-by?

Thanks,
Song
