Return-Path: <bpf+bounces-14475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC4B7E5373
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 11:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D73D1C20BAE
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AB5D52D;
	Wed,  8 Nov 2023 10:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eEPFBFHw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C612E4D
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 10:33:14 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC221BD5
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 02:33:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzrFbCfw/L1X1JVEbP+tZUUO8FVq5z8p8ewlY4i1nu8zzvNG1/GVS4SYkYL8Sv2GBJF3QECmPT6KES1CF8i+4YImuNrtCMvnR6fjVlPojvKDgbw1oGK97y4c88c0H04fE+GYNFaguE+3jeb7VZuW2dmXSw4UGRM7JzQKlkvT3jvOfM3Qg7D9qG063AMzwRYopfVf1Qc9IRxiEQ535XYOjL/cG0rk77UWnjY4QiLqqAEA9XzEopKkFbTrLcptogZxZz4+e8hvN4E/jFr+rYG2QHhu22BFlsEbZNIuQ6Di7XIueEoeA1NVO0nxD0MrRr69xM5NVUH4tWJJ+A5gIWA58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXg0nNhzVwYDlDUcRm5nUvofXJjlUUoGtXAUPIA+AVQ=;
 b=lZPQjGT6o6ds3xVW0H68gxyj/jW2QeaPlZ314B+TREtB7amKUuTPVaNkwb7JRYQrWLmA1B9i5jNuPlRGi3g1B37/CClCtvogs29D+dtyN7stnnEPh+t7uRimzoPWqLwKEQuAgctuw4f0GaqLFRLkP4d2e/cnjRSCYSQbTz9qlEfBq2yIyARycbNbjon1Ggo3G5doUlO5T6PHmcNEsB96vf1GXRqC9Ec3IsdQrow3xXT10TFjv88KMz3zaF3rhgBjfdxq57TH8JE5hJDnmQ+MouTSc5Qj1rgn5svggXFQP9K1P5datq7KM+XDU8/EEkKbVaOBy/LNQp0kXtbvgDzxAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXg0nNhzVwYDlDUcRm5nUvofXJjlUUoGtXAUPIA+AVQ=;
 b=eEPFBFHwK1O8wgg/lXFp5dCuWDKOEHK7mDhB/K8GmsH7JFmhmWoeXr0ki81mE0bGUOBxKAmeM3hpGMPLHiEAWiHHSDQTA3F98PF4ligdGZIohRbSNzRW5G0kmTGwBNxvzxRyKCrO8FiZuGBzGdOOdZBhwMpt/wE/wfJT7seYBScBPCGz1FJc+IsNT5uoke93pSzGjI9LGsEWuayfvCPr5VpuTn0kmNGnZwHVb3ZJOmW6Ttz6koC4ZqEdX5GhVADrSRPkmeph81QMD23P/N4TI/RrUBMpaqg+p+9qMBDOlQchcxGhpQKCupr2idsoRxBUUzLbdXavIbNmQSblHeb8KA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.17; Wed, 8 Nov
 2023 10:33:09 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 10:33:09 +0000
Date: Wed, 8 Nov 2023 18:32:58 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Dave Thaler <dthaler@microsoft.com>, Paul Chaignon <paul@isovalent.com>
Subject: Re: Unifying signed and unsigned min/max tracking
Message-ID: <e77tezitp73p7omfzgl53owoncuzc5a2n43ro7ihjyr7cvw2in@u2f4kgp5pf6g>
References: <ZTZxoDJJbX9mrQ9w@u94a>
 <ZTtOEFqpFIiYoqht@u94a>
 <CAEf4BzYqu-Ojqc0jjiJdTfmV4F2HwU45-OqBYQ0NcKk9D7hxaA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYqu-Ojqc0jjiJdTfmV4F2HwU45-OqBYQ0NcKk9D7hxaA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PA4PR04MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1a0f7e-f0b9-4f13-c06c-08dbe0461a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9vxj7VagC8iBP9wW/hfPA5cs0Etks4gaw6yxbkiabK6FfzHlNDbgjhev784FKWahgnFle28IxUuR1GxpsJ6ukJSvHxrC7QPMKRLIpb3llJwRgWYY1EVzyoX4Oy3lboGCUKIB5d7BR380u2b+qWaTGdeEFqhtkUnRvLIZOwzaIGfEs6AEKdcI0E80oFeGFOSLdcTp1t9T51mF35xe8GI6a9VVRw3P2+nacylioO9hTNet5QKc7CXB8ooqVbL7DlNcbe/lezHGtJZFYwfi49YGUf9y7iyrY4OeQBeFrKubEncrOjnCxJNQF+pWAiwukyPcNGoFMaau9prIMEZpkNnKweMnlqj9ICmo3Q6aMFBVx+hRYFCCDQH9HTQrsku8LOpKS828hG9LRDA2hiIbxiVKL2Nb5NauXwR3qUGXkCWQ8EOUPPPFdhRlbW9/0HEFo3/3Xm8QBbpARMqxPpDzzAv7fiotPyoQAe2RY4ggwiA2YbEDEMPZyaJyMRnC2xZ83rYRmUpOmC9WGwxQ36emDnXNBQR/6kTO8aMjZn1ii60C640=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(53546011)(6486002)(478600001)(966005)(66946007)(83380400001)(86362001)(38100700002)(9686003)(6506007)(316002)(6512007)(66476007)(66556008)(54906003)(6916009)(6666004)(2906002)(30864003)(5660300002)(41300700001)(8676002)(4326008)(33716001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0Z2YmhPaG0wdjVGRHdTbTNVV0ZHcFc4OTNTRmVVQ1A2dUt5NDRNVWF1K0dU?=
 =?utf-8?B?cTh1d2UvdVM4UTJTTmh6anFNdkwwcjlla3I2aHlQUHBZZXZzYkd4TityVXZF?=
 =?utf-8?B?YjU5WW1NWDRjN1p5Yk1Fa0E0MjA4UE9tdWVCTmZxaU1YN1VpWGdQTDJuWFNM?=
 =?utf-8?B?MnRTRXlGTXFPVllKcnFwNk4vYURHeUdadG1CMWh2K1RHODhQU3h2RldsVVJW?=
 =?utf-8?B?UVVJdm52SmNBUzF4d3pIYWJVY1hPT0dvNXpMN3paWXU0ZnVYV2t6elVvYmJl?=
 =?utf-8?B?M0RzTXh5MFA2RzMxdmFZRmY3RzFxK2kyRFRhYXQ1elRZUjVOZGc0VmVNMFVE?=
 =?utf-8?B?c1AxbnB0ZGlDRll2bHR6Qkt4VU5PRW0zWVZQci9PQ0pHTm1yanRic1dEaXM0?=
 =?utf-8?B?VDNScnlBOFhxZkl2dWNnRW9JMWF1bzQrdzVsb1A3RFRqcWhaejE0NWRwaGNW?=
 =?utf-8?B?bndHc2d6QWNzQ3NCQkdna3ZDcXNtSVJNVVBtcXVCb2EzZXFqc0xGNW9sWU8z?=
 =?utf-8?B?aXV2ZWpvaG81VE0yQlpCR3E3WFlBcksvbFhrcTNHSVlVcVFMMGloM0l6VUVV?=
 =?utf-8?B?eHlPeU94RVNVTGVteUp2bE1ydllQVm95ZnowRitvSWJzMThtTWZYWm5CV1cv?=
 =?utf-8?B?S2RCblFZUUFmTnJHY1M2WHdhaFM2YXdHeXBYZlVjUWE3d010aFN4eTBmTEYz?=
 =?utf-8?B?eFdGa1pnMkcvemI3bmttTnhDbVMrYTFidW0xNW83aFl2VGtoNDlwMzRHY3VV?=
 =?utf-8?B?WkptZURac3ZJTUxXbnFjMGpwN2Z5dHhuY0ZlTUJ5aW5LV2NIMlhDeHBFUEJT?=
 =?utf-8?B?ZVR3ZmlDamJvR2pxTE54WmxmV0xZZFBhTUxGTjc5ckdEcFVkcDVKRjFRSHdS?=
 =?utf-8?B?c25HTU5CdU1kNHRVYXR3cWQ2aGtCWGpPTjhNN3p4cklISDlCbVBTUHpaVHVa?=
 =?utf-8?B?dVdQQmQ2RElzTXQ5RCtuNU15T2dWQ3lRMkhWSCtFMWJ5WXNhSGk0QmxOR1JH?=
 =?utf-8?B?TkxvcXJXbWYyRXdjMHlxS0gzOVl3SDNWWjZlTkcxOXF6aFNhMS9BZlljY0o3?=
 =?utf-8?B?VERQZjlIYlpoS3VOWmdadGdoTGhVOTBRK3FUYVZIOFpUVzM1elN6Ny9TalNq?=
 =?utf-8?B?TytWc0tSRnZ6ZHBIYzBzMkdMYUdmS3lqL2gwQlQxOXJET3pmRFdVbW92Qktu?=
 =?utf-8?B?MFBqblI0cnUydHRFM2huVGxMZHFsMmpHMkhwQUVPRFBGM2EzbDVtNjh5L2w5?=
 =?utf-8?B?WGZ0dU1FNVBUbVRXYVkvMlp3MWIzaGxSMTdhUVkyNmxxRW1XbUFSc0d0MFpY?=
 =?utf-8?B?YjcyMWl5QWpsQWNVNlY3SzRXOTgrN3BiR0ViUHNnV1h1N0hKaFpRelVNRENW?=
 =?utf-8?B?bmpmMC9vb1pUQy9iMGJQUHNXS0VxN2YzR0NiL0xZYmo0Sk1IVlVRQzBybkdr?=
 =?utf-8?B?SlJJWS9pL2UvZ25RTUdQd0lhbTlqUUZac05MM1MyMk1OYWJLbDJNT082WHUr?=
 =?utf-8?B?RVNpNWJMMnUxdzVkc3FycWIxOFRVS1NUaWR4TTJjblI0R0RPNHdPRzlFYWhJ?=
 =?utf-8?B?R204NXBzdjhhekRQNTZWVWlLaDlhNDJVUkRYODZTOEIvV3kvT2ZGdnV6RUZ2?=
 =?utf-8?B?OUpLdmY0Q3ZwM09PbGQzeVl2OEJkZXZhVlJUam9PWnduQjhmTkU5RTZJRmlL?=
 =?utf-8?B?UTYxYko1MlhiRHFNaTNJNVVVR3NSZk94RWU4TDd3UjhWNHpaL1pMckZJQkl0?=
 =?utf-8?B?MUppbVJaVm43bnBNUHAxLzZ3OGRHcHk3cktRUFpRWTRGMm52VVpLVWIySllY?=
 =?utf-8?B?WVV2OHpzdE5BVmFqOFBUUnN2Q0VVWGRkUEtDL2tZMTV5dncwYkxNYktjSytU?=
 =?utf-8?B?dlQ0eURIT0taYjd0NUUxOW5WSFgzRUwyaXJkWmxwNUxhbnk5Y0sxcFRjd3RE?=
 =?utf-8?B?RzRnRnZJb1JQaEpLT29OcUpITDc3WXNhY1BwKzVwbFdheENkbitmamNsOEhW?=
 =?utf-8?B?RDBJMUt0NGJyK3hrNmJ0bGJWd3ZneituSzh3OElZeWI2S2VVejFFdVQ0aGJM?=
 =?utf-8?B?bUk3V1YwWUpiNHRHcnlETEJYNjJKMUlEYnBtOURnUU9DcU1zb1VKdFNxT3ZE?=
 =?utf-8?B?ZGZnWWxRTGloRUE1M3BHd1NvWE92OEIzUzRubmFXa0wzRWMxQWk4RG40dmxh?=
 =?utf-8?B?a241Q2tQZUNGNkY4ancxVVdJS2UzaWMyaEp0QndwMXNEbE1QOXg4ZTVDQ2JR?=
 =?utf-8?B?YjRTQlp1THVJTDhqOU9uaGRDM2pBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1a0f7e-f0b9-4f13-c06c-08dbe0461a0d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:33:09.6057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71DjlP1xQshQfWsegxrsdjcPTSOj4qPqrt40E0bDA2ozWrBCaLBL0lPxprdYM5mRpYeCI5nZ4Obod4mIwZ5Sog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8016

On Fri, Oct 27, 2023 at 01:46:35PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 26, 2023 at 10:44 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Mon, Oct 23, 2023 at 09:14:08PM +0800, Shung-Hsi Yu wrote:
> > > Hi,
> > >
> > > CC those who had worked on bound tracking before for feedbacks, as well as
> > > Dave who works on PREVAIL (verifier used on Windows) and Paul who've written
> > > about PREVAIL[1], for whether there's existing knowledge on this topic.
> > >
> > > Here goes a long one...
> > >
> > > ---
> > >
> > > While looking at Andrii's patches that improves bounds logic (specifically
> > > patches [2][3]). I realize we may be able to unify umin/umax/smin/smax into
> > > just two u64. Not sure if this has already been discussed off-list or is
> > > being worked upon, but I can't find anything regarding this by searching
> > > within the BPF mailing list.
> > >
> > > For simplicity sake I'll focus on unsigned bounds for now. What we have
> > > right in the Linux Kernel now is essentially
> > >
> > >     struct bounds {
> > >       u64 umin;
> > >       u64 umax;
> > >     }
> > >
> > > We can visualize the above as a number line, using asterisk to denote the
> > > values between umin and umax.
> > >
> > >                  u64
> > >     |----------********************--|
> > >
> > > Say if we have umin = A, and umax = B (where B > 2^63). Representing the
> > > magnitude of umin and umax visually would look like this
> > >
> > >     <----------> A
> > >     |----------********************--|
> > >     <-----------------------------> B (larger than 2^63)
> > >
> > > Now if we go through a BPF_ADD operation and adds 2^(64 - 1) = 2^63,
> > > currently the verifier will detect that this addition overflows, and thus
> > > reset umin and umax to 0 and U64_MAX, respectively; blowing away existing
> > > knowledge.
> > >
> > >     |********************************|
> > >
> > > Had we used u65 (1-bit more than u64) and tracks the bound with u65_min and
> > > u65_max, the verifier would have captured the bound just fine. (This idea
> > > comes from the special case mentioned in Andrii's patch[3])
> > >
> > >                                     u65
> > >     <---------------> 2^63
> > >                     <----------> A
> > >     <--------------------------> u65_min = A + 2^63
> > >     |--------------------------********************------------------|
> > >     <---------------------------------------------> u65_max = B + 2^63
> > >
> > > Continue on this thought further, let's attempting to map this back to u64
> > > number lines (using two of them to fit everything in u65 range), it would
> > > look like
> > >
> > >                                     u65
> > >     |--------------------------********************------------------|
> > >                                vvvvvvvvvvvvvvvvvvvv
> > >     |--------------------------******|*************------------------|
> > >                    u64                              u64
> > >
> > > And would seems that we'd need two sets of u64 bounds to preserve our
> > > knowledge.
> > >
> > >     |--------------------------******| u64 bound #1
> > >     |**************------------------| u64 bound #2
> > >
> > > Or just _one_ set of u64 bound if we somehow are able to track the union of
> > > bound #1 and bound #2 at the same time
> > >
> > >     |--------------------------******| u64 bound #1
> > >   U |**************------------------| u64 bound #2
> > >      vvvvvvvvvvvvvv            vvvvvv  union on the above bounds
> > >     |**************------------******|
> > >
> > > However, this bound crosses the point between U64_MAX and 0, which is not
> > > semantically possible to represent with the umin/umax approach. It just
> > > makes no sense.
> > >
> > >     |**************------------******| union of bound #1 and bound #2
> > >
> > > The way around this is that we can slightly change how we track the bounds,
> > > and instead use
> > >
> > >     struct bounds {
> > >       u64 base; /* base = umin */
> > >         /* Maybe there's a better name other than "size" */
> > >       u64 size; /* size = umax - umin */
> > >     }
> > >
> > > Using this base + size approach, previous old bound would have looked like
> > >
> > >     <----------> base = A
> > >     |----------********************--|
> > >                <------------------> size = B - A
> > >
> > > Looking at the bounds this way means we can now capture the union of bound
> > > #1 and bound #2 above. Here it is again for reference
> > >
> > >     |**************------------******| union of bound #1 and bound #2
> > >
> > > Because registers are u64-sized, they wraps, and if we extend the u64 number
> > > line, it would look like this due to wrapping
> > >
> > >                    u64                         same u64 wrapped
> > >     |**************------------******|*************------------******|
> > >
> > > Which can be capture with the base + size semantic
> > >
> > >     <--------------------------> base = (u64) A + 2^63
> > >     |**************------------******|*************------------******|
> > >                                <------------------> size = B - A,
> > >                                                     doesn't change after add
> > >
> > > Or looking it with just a single u64 number line again
> > >
> > >     <--------------------------> base = (u64) A + 2^63
> > >     |**************------------******|
> > >     <-------------> base + size = (u64) (B + 2^32)
> > >
> > > This would mean that umin and umax is no longer readily available, we now
> > > have to detect whether base + size wraps to determin whether umin = 0 or
> > > base (and similar for umax). But the verifier already have the code to do
> > > that in the existing scalar_min_max_add(), so it can be done by reusing
> > > existing code.
> > >
> > > ---
> > >
> > > Side tracking slightly, a benefit of this base + size approach is that
> > > scalar_min_max_add() can be made even simpler:
> > >
> > >     scalar_min_max_add(struct bpf_reg_state *dst_reg,
> > >                              struct bpf_reg_state *src_reg)
> > >     {
> > >       /* This looks too simplistic to have worked */
> > >       dst_reg.base = dst_reg.base + src_reg.base;
> > >       dst_reg.size = dst_reg.size + src_reg.size;
> > >     }
> > >
> > > Say we now have another unsigned bound where umin = C and umax = D
> > >
> > >     <--------------------> C
> > >     |--------------------*********---|
> > >     <----------------------------> D
> > >
> > > If we want to track the bounds after adding two registers on with umin = A &
> > > umax = B, the other with umin = C and umin = D
> > >
> > >     <----------> A
> > >     |----------********************--|
> > >     <-----------------------------> B
> > >                      +
> > >     <--------------------> C
> > >     |--------------------*********---|
> > >     <----------------------------> D
> > >
> > > The results falls into the following u65 range
> > >
> > >     |--------------------*********---|-------------------------------|
> > >   + |----------********************--|-------------------------------|
> > >
> > >     |------------------------------**|**************************-----|
> > >
> > > This result can be tracked with base + size approach just fine. Where the
> > > base and size are as follow
> > >
> > >     <------------------------------> base = A + C
> > >     |------------------------------**|**************************-----|
> > >                                    <--------------------------->
> > >                                       size = (B - A) + (D - C)
> > >
> > > ---
> > >
> > > Now back to the topic of unification of signed and unsigned range. Using the
> > > union of bound #1 and bound #2 again as an example (size = B - A, and
> > > base = (u64) A + 2^63)
> > >
> > >     |**************------------******| union of bound #1 and bound #2
> > >
> > > And look at it's wrapped number line form again
> > >
> > >                    u64                         same u64 wrapped
> > >     <--------------------------> base
> > >     |**************------------******|*************------------******|
> > >                                <------------------> size
> > >
> > > Now add in the s64 range and align both u64 range and s64 at 0, we can see
> > > what previously was a bound that umin/umax cannot track is simply a valid
> > > smin/smax bound (idea drawn from patch [2]).
> > >
> > >                                      0
> > >     |**************------------******|*************------------******|
> > >                     |----------********************--|
> > >                                     s64
> > >
> > > The question now is be what is the "signed" base so we proceed to calculate
> > > the smin/smax. Note that base starts at 0, so for s64 the line that
> > > represents base doesn't start from the left-most location.
> > > (OTOH size stays the same, so we know it already)
> > >
> > >                                     s64
> > >                                      0
> > >                                <-----> signed base = ?
> > >                     |----------********************--|
> > >                                <------------------> size is the same
> > >
> > > If we put u64 range back into the picture again, we can see that the "signed
> > > base" was, in fact, just base casted into s64, so there's really no need for
> > > a "signed" base at all
> > >
> > >     <--------------------------> base
> > >     |**************------------******|
> > >                                      0
> > >                                <-----> signed base = (s64) base
> > >                     |----------********************--|
> > >
> > > Which shows base + size approach capture signed and unsigned bounds at the
> > > same time. Or at least its the best attempt I can make to show it.
> > >
> > > One way to look at this is that base + size is just a generalization of
> > > umin/umax, taking advantage of the fact that the similar underlying hardware
> > > is used both for the execution of BPF program and bound tracking.
> > >
> > > I wonder whether this is already being done elsewhere, e.g. by PREVAIL or
> > > some of static code analyzer, and I can just borrow the code from there
> > > (where license permits).
> >
> > As per [1], PREVAIL uses the zone domain[2][3] to track values along with
> > relationships between values, where as the Linux Kernel tracks values with
> > min/max (i.e. interval domain) and tnum. In short, PREVAIL does not use this
> > trick, but I guess it probably don't need to since it's already using
> > something that considered to be more advanced.
> 
> tnum is actually critical for checking memory alignment (i.e.,
> checking that low 2-3 bits are always zero), which range tracking
> can't do. So I suspect PREVAIL doesn't validate those conditions,
> while kernel's verifier does.

I didn't know this :)

Looking into Wikipedia's article on Zone domain it seems that indeed it
cannot tell memory alignment.

> > Also, found some research papers on this topic referring to it as Wrapped
> > Intervals[4] or Modular Interval Domain[5]. The former has an MIT-licensed
> > C++ implementation[6] available as reference.
> >
> > 1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the-windows-ebpf-verifier.html
> > 2: https://en.wikipedia.org/wiki/Difference_bound_matrix#Zone
> > 3: https://github.com/vbpf/ebpf-verifier/blob/6d5ad53/src/crab/split_dbm.hpp
> > 4: https://dl.acm.org/doi/abs/10.1145/2651360
> 
> this one (judging by the name of the paper) looks exactly like what we
> are trying to do here. I'll give it a read some time later.

I'm putting off reading it fully (for some fun), and only went through
the introduction and a few figures so far. It does seem like it had
all the bits that I need to know to make this work.

Also, the use of circles to visualize the numerical domain in the paper
makes great intuitive sense, too bad my ASCII art skill is not good
enough to draw circles.

> ... Meanwhile
> I posted full patch set with range logic ([0]), feel free to take a
> look as well.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=797178&state=*

A bit late to the party, but I'm coming back to (the latest version of)
this series.

[...]

