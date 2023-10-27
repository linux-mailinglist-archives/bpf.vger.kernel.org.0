Return-Path: <bpf+bounces-13389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BE97D8DEF
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 06:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FCB81C20FD9
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 04:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FF25229;
	Fri, 27 Oct 2023 04:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="V0StQjpR"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431F1FD3
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 04:57:05 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42C9192
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 21:57:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqFG4lG/VmUX9T3hXi9qoADZ3AQApHNUUfbeauhTZWLA4zADt+L9YBcvPNEUyZwB+Rp9X2hHZtL8wfvXYciT8gfTGEnSrdSrhZ5ixQDStiT/iYBL6NRpk1/aRwj0xABXjMc9LTSXC2gVJ4m9eO6pED5ukFpeNv/tvc7Kc4dtyFn+4tmmD3qM52G0z0K7CWCtdmgCMiO5kWGCOBOfNoEQiKDo7ukts8d4FPEX4vqpmZyqbM+CaNqh5MFWSF6+EWbJYwUsIwhYZ3bZkrke7TgHqWBd9cE8ZOqD0PyS/140H8B5J6ODM7oHBV02tb3qX1c7Yzaksbv8MGSBSz/bikQWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwyIaJX8giQToFm1W4Jwcfn/O2dq5PqB9XnTtJ21Hbs=;
 b=AwpAWW/ZlxWIUH2r+xVr+/UE18alA0AruUagPUNxDBit/u08RhBJbmAboICMCIFzCYCUYRuTyCjCAb0cfFSZtbunJcVR8TpBvPAJ9j6GUSLtQCEgYpVICTMWifuvTM2rz28dWquKSmicb+Of91hZB+wlar6162mjUScYJz0i3Yflz6U7MZiFdB+UPYW9+hJ9J1Vd4vtzzLFhqdJQno6UJjbWiWU8zw/+v4kjP5Cdf2ws5tP/mRX4/KVj4f2sj1HWcVUgZeYS5DdFzkVbYiQnnxyMvVWI8UoJM7tiS8ewK3zNlwKuWWB9pVX/sealOvNQTppBwT3RXuXpCn2S6c/fSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwyIaJX8giQToFm1W4Jwcfn/O2dq5PqB9XnTtJ21Hbs=;
 b=V0StQjpRUHCTR3eXNyYn8IKAkcPLSFX8sLMVE0d0t3FV8fybDOY6uRGucRSLVkwUk2zCbB+u3nJNXUuN1rjitJko8rGX4p9Ta0UdP6sJHlUqKx6KDIp9pIBf74uLQShO/jD6x2v4+xn8QW/wTjpxtUf4iAvvuwg3Z1lc/O3D/bH2ml4KJdgrgTnrJzjPDmOYx45vnuwrLmKwLLIWQdZtgpazY/Ta4N+REJzXYyCQvwOPBJBFIiL5OVJc3bgNrl9ZTZKEsmXOURfkfZa9TiPjbCuL2LIFgGuw/Ps8o9wD1tVAZZ9FutJ8VevegovA0zTi8ngxkDXlymDKE7nhASHF0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by VE1PR04MB7264.eurprd04.prod.outlook.com (2603:10a6:800:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Fri, 27 Oct
 2023 04:56:58 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 04:56:58 +0000
Date: Fri, 27 Oct 2023 12:56:42 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Dave Thaler <dthaler@microsoft.com>,
	Paul Chaignon <paul@isovalent.com>
Subject: Re: Unifying signed and unsigned min/max tracking
Message-ID: <ZTtDCts772nPnKXR@u94a>
References: <ZTZxoDJJbX9mrQ9w@u94a>
 <CAEf4Bzb6kLMZo+VsUu=LS5V4WRY-_x-zinv0Pkr6XEbCrHvo-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb6kLMZo+VsUu=LS5V4WRY-_x-zinv0Pkr6XEbCrHvo-w@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::14) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|VE1PR04MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: db236dea-37c6-43b1-8349-08dbd6a9260a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nweI2JxDjg6QaHSxDMnFepbSB2AlfQa5irSRJfXOMktWyB7TLVLttQ/8SunFFmvdqxfI+5xJeczZoq9VlaQwpNEKNs3mIgoOMzHUcf2uKe9yV2HBLqaUKAbENXhP9mEkCPmGEDDd0daGILiAq1j0+879rTpkY4RvLz5SwVGA7c642hnHyAkYSBs8wmFvLEvfE5yORDXNwq39932uFSEEwzJY+ed3VR5dxuQrph0NOPkJ0q+y5gFFj4JUfRQk4FFJrSqAS/yCXgnnXo0NaBfdL9pssj3u08Yq6b4Rrp2gmBuauyLhMbCTFJyJOBK9l74Xb7AQN484woN5Hg/LHPCdoT3QSun0v9busY2h63CCoRO/M59EeUhA8QxHl1Iz69RTSH2khTNGR4U/oCEW8QegGL8piAhb6V/IJV8iPxx9rAaquK+FhZLTlsyq9vPKx1QgqGatXuBY65W5hX1d00k70K96aXv3DlAkfIdXryOeJFKe0j6OnhzNQEF8kI3EQVGL7o0ok0zfOwuzVOkr5iuz/LKCCQnld4LvqX012HhoRjag5WljYgA1KgkL1nC9Og62vXHARivcv99K4v7x6I8PzA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(53546011)(30864003)(33716001)(9686003)(6512007)(38100700002)(6506007)(26005)(2906002)(4326008)(8676002)(66476007)(66946007)(66556008)(54906003)(41300700001)(6666004)(86362001)(8936002)(5660300002)(478600001)(966005)(6916009)(316002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SURMTUNmWkQzb3hXVjdveUdHcklSamVvcnhCMVVjMVFvbHhWd0F2T0pRc0pV?=
 =?utf-8?B?YU9pbThsSzJiVHM4YjhxMGRZcGIrN01KbUZsL0llWko5RlhaNFh6VStPK0lY?=
 =?utf-8?B?ZEVJYmg2VUNCNndUWWFkaWFTT0VFdzRQcHhXTmh0SDB2alRZQ1c2RTMxQjF3?=
 =?utf-8?B?VWlWOFczcTBWWW5Jd3VlZ1RtL3o4WHI3UzlNWERpZnVPelVkUG0wWkdIUlFZ?=
 =?utf-8?B?c1ZEMmtoa25PYWk0ek9kSGluL3Z1MWZ1YmdqNWEyeGhBdVdQQ243MUYrSjAz?=
 =?utf-8?B?bHBkc1JWcTVmck9NTzhRcEhJc1Y1TFd0UVkzY3cvNDVoR3N4aWsyN3ZhZlhZ?=
 =?utf-8?B?UG4wM0pKZHFIcktKSjRBSThZempRMUlSOElmSjNSeXd2clQ3ZmNNQnIwM2tY?=
 =?utf-8?B?RnliekNwSlRDYThSS24yNWlrL3A5SXBPdmpuOFJ4SG5VbE0xMzYxWHpXdWVn?=
 =?utf-8?B?emYzbXVvNW54eW11aWZtbVdxV3luWjZCRUk1T3hPbURLYnZKeXR3RW9WT2lS?=
 =?utf-8?B?NDRvY2dQd1RGZ21RamUrOEhYV2JOaVBYNmJ1UlpQSCtJKytkVlh3em5BNmRR?=
 =?utf-8?B?Y2FndkJJU3VQVEFIS0FMWGVMNHVJMCtVVmh6TE1FdDlVMWVXOWtDYVpJQXU1?=
 =?utf-8?B?Njl1SW82K0tHTTZ4TTM4S2ZOVnJPUXV2NXYyNDJOVFVjTkhuRUNQOUVxRm5Z?=
 =?utf-8?B?UmhHbS9jSjh5Q1NpdHRnU0wzaDRZeDkrZm5BZ3NSbUtFa3JUTUFYa0lNSUIx?=
 =?utf-8?B?K1Y2czQxQzIzc1J1ZWtaUmdiOGcxTGYyY2tDRkdjcWJNZXlZSm82U2lHYlhH?=
 =?utf-8?B?cWZCRS9ZMVd2NUt3MHFCTks0WXQrOHdVenB3R1NLK3pRd0l6NjlLZlRPNHJV?=
 =?utf-8?B?RUhkOElaZlB5eTJKYVdEeW1sNXQvNlVkanE2cnlPZ2Z5UnVtbkZKMFhKZ0Yz?=
 =?utf-8?B?aDlFRnQ4NDFJOTJrL0Fua0x1Vk9WeGF2cEZvYVJCYisrMGlKbDdHdURIV0tO?=
 =?utf-8?B?RWZLYXExNFZFQ0pBU3A4OEdqdFJzYzdCSUwyUnJKbEw2Z3lZTWlIUWZiWkpJ?=
 =?utf-8?B?d1VvUFFKOFFjMnhCSnh5VHlGektxQ0R4SzY1QlZZcHFZL09CVE5XRjg3ZStz?=
 =?utf-8?B?VXFBVmREWmpBczBKcTBtdU5ZdG8ydGx0MThmdjhJNGsxc0o1cTRaOW1VTGJj?=
 =?utf-8?B?emVHdW1mUUxBYStIUTYxTmFUMUJSbzFCM1dYME5qVkJZWWJqdG5CY2xpQlJQ?=
 =?utf-8?B?bk14elFxdzdZVE5RK1YvZHVCWm51WkhENTRZcWl2S2ZyQlVaTGo3MEpRS3hh?=
 =?utf-8?B?WlJENmVPTmZwbEloTVhtVWJKK0hDdVh1Sk1GL0lFOW94V3hqNmVYMnJzdm1E?=
 =?utf-8?B?RGdsa0VHcDNtWkdtZTg3bURlZEx2NUpJWHprRngzYVVQOTdxQVFQVmd3ZWZ4?=
 =?utf-8?B?c2JNazRKWFowOEJCSi9UNTZPUUVvTlVJUTJja25aYUo1V1JvcXVNdkYvQW1I?=
 =?utf-8?B?YnByUUR6amhGZXRjazZMcHNRbElHZUpVd1lWbE1BcEs0bnpzZ0E0ejUxOUVF?=
 =?utf-8?B?VnY2QXd5dlJBQnMzcDNjdWZmUm9oL0pzdWRSZ1dNcU1BNXdOL0o5V0RYb1JT?=
 =?utf-8?B?ZmIyVG54S3pYZHdvZ3V1RmpRcHFhZnFXSWdCUFp0cmVrR1Z0TGFXNmMxMmNE?=
 =?utf-8?B?YlhHM3RhN1BHbEtDcGs4VjVlNGhaUXd5MGVQTVBiM3FwRzlMWm5lN1h1ZERp?=
 =?utf-8?B?aWVJNkk2WnE4NUs2VGFZY3VDUHlraFRXV2tMZU1pa3hKcDExK2VBekc5OXJH?=
 =?utf-8?B?R0luMURJWG5JYXR5YkdSeG9YcENPcFFrakdieStYNEwyTFRUOCt5UDgyY3Nq?=
 =?utf-8?B?Q0lpdXVvWVNBUC9KdVhteFNFZTlZT0szbzZDeTZOdWhMOHRmSFJVREZaVUhw?=
 =?utf-8?B?YmhTT1hQWGRvR0h4VXJjQjRXRGhCcnM3aXhhZExiQ3liZitEbVU5MGdOcGlT?=
 =?utf-8?B?VWFXZGtRVFVoWkd3QjF1SG56M3RHT1dCWTNlWVFlRzZSYXRKT1pHUWpnRXkz?=
 =?utf-8?B?TmVHVmp6VG50d2lsTEIweGExeS9GTEthZFBSUkVtejc2Q0lBWFllNWRVT2My?=
 =?utf-8?Q?pkFdeHnOYXvpBgcWyNT7UZ29F?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db236dea-37c6-43b1-8349-08dbd6a9260a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 04:56:58.2652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UhorzWS29RhjFZiG54Hqv+1cId84VyiuVphy0BpOsAAnzVROQSnSJFOTL7DjblHmfjwjT2qJ+pJ7+e/Q3m2dAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7264

On Mon, Oct 23, 2023 at 09:50:59AM -0700, Andrii Nakryiko wrote:
> On Mon, Oct 23, 2023 at 6:14 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Hi,
> >
> > CC those who had worked on bound tracking before for feedbacks, as well as
> > Dave who works on PREVAIL (verifier used on Windows) and Paul who've written
> > about PREVAIL[1], for whether there's existing knowledge on this topic.
> >
> > Here goes a long one...
> >
> > ---
> >
> > While looking at Andrii's patches that improves bounds logic (specifically
> > patches [2][3]). I realize we may be able to unify umin/umax/smin/smax into
> > just two u64. Not sure if this has already been discussed off-list or is
> > being worked upon, but I can't find anything regarding this by searching
> > within the BPF mailing list.
> >
> > For simplicity sake I'll focus on unsigned bounds for now. What we have
> > right in the Linux Kernel now is essentially
> >
> >     struct bounds {
> >         u64 umin;
> >         u64 umax;
> >     }
> >
> > We can visualize the above as a number line, using asterisk to denote the
> > values between umin and umax.
> >
> >                  u64
> >     |----------********************--|
> >
> > Say if we have umin = A, and umax = B (where B > 2^63). Representing the
> > magnitude of umin and umax visually would look like this
> >
> >     <----------> A
> >     |----------********************--|
> >     <-----------------------------> B (larger than 2^63)
> >
> > Now if we go through a BPF_ADD operation and adds 2^(64 - 1) = 2^63,
> > currently the verifier will detect that this addition overflows, and thus
> > reset umin and umax to 0 and U64_MAX, respectively; blowing away existing
> > knowledge.
> >
> >     |********************************|
> >
> > Had we used u65 (1-bit more than u64) and tracks the bound with u65_min and
> > u65_max, the verifier would have captured the bound just fine. (This idea
> > comes from the special case mentioned in Andrii's patch[3])
> >
> >                                     u65
> >     <---------------> 2^63
> >                     <----------> A
> >     <--------------------------> u65_min = A + 2^63
> >     |--------------------------********************------------------|
> >     <---------------------------------------------> u65_max = B + 2^63
> >
> > Continue on this thought further, let's attempting to map this back to u64
> > number lines (using two of them to fit everything in u65 range), it would
> > look like
> >
> >                                     u65
> >     |--------------------------********************------------------|
> >                                vvvvvvvvvvvvvvvvvvvv
> >     |--------------------------******|*************------------------|
> >                    u64                              u64
> >
> > And would seems that we'd need two sets of u64 bounds to preserve our
> > knowledge.
> >
> >     |--------------------------******| u64 bound #1
> >     |**************------------------| u64 bound #2
> >
> > Or just _one_ set of u64 bound if we somehow are able to track the union of
> > bound #1 and bound #2 at the same time
> >
> >     |--------------------------******| u64 bound #1
> >   U |**************------------------| u64 bound #2
> >      vvvvvvvvvvvvvv            vvvvvv  union on the above bounds
> >     |**************------------******|
> >
> > However, this bound crosses the point between U64_MAX and 0, which is not
> > semantically possible to represent with the umin/umax approach. It just
> > makes no sense.
> >
> >     |**************------------******| union of bound #1 and bound #2
> >
> > The way around this is that we can slightly change how we track the bounds,
> > and instead use
> >
> >     struct bounds {
> >         u64 base; /* base = umin */
> >         /* Maybe there's a better name other than "size" */
> >         u64 size; /* size = umax - umin */
> >     }
> >
> > Using this base + size approach, previous old bound would have looked like
> >
> >     <----------> base = A
> >     |----------********************--|
> >                <------------------> size = B - A
> >
> > Looking at the bounds this way means we can now capture the union of bound
> > #1 and bound #2 above. Here it is again for reference
> >
> >     |**************------------******| union of bound #1 and bound #2
> >
> > Because registers are u64-sized, they wraps, and if we extend the u64 number
> > line, it would look like this due to wrapping
> >
> >                    u64                         same u64 wrapped
> >     |**************------------******|*************------------******|
> >
> > Which can be capture with the base + size semantic
> >
> >     <--------------------------> base = (u64) A + 2^63
> >     |**************------------******|*************------------******|
> >                                <------------------> size = B - A,
> >                                                     doesn't change after add
> >
> > Or looking it with just a single u64 number line again
> >
> >     <--------------------------> base = (u64) A + 2^63
> >     |**************------------******|
> >     <-------------> base + size = (u64) (B + 2^32)
> >
> > This would mean that umin and umax is no longer readily available, we now
> > have to detect whether base + size wraps to determin whether umin = 0 or
> > base (and similar for umax). But the verifier already have the code to do
> > that in the existing scalar_min_max_add(), so it can be done by reusing
> > existing code.
> >
> > ---
> >
> > Side tracking slightly, a benefit of this base + size approach is that
> > scalar_min_max_add() can be made even simpler:
> >
> >     scalar_min_max_add(struct bpf_reg_state *dst_reg,
> >                                struct bpf_reg_state *src_reg)
> >     {
> >         /* This looks too simplistic to have worked */
> >         dst_reg.base = dst_reg.base + src_reg.base;
> >         dst_reg.size = dst_reg.size + src_reg.size;
> >     }
> >
> > Say we now have another unsigned bound where umin = C and umax = D
> >
> >     <--------------------> C
> >     |--------------------*********---|
> >     <----------------------------> D
> >
> > If we want to track the bounds after adding two registers on with umin = A &
> > umax = B, the other with umin = C and umin = D
> >
> >     <----------> A
> >     |----------********************--|
> >     <-----------------------------> B
> >                      +
> >     <--------------------> C
> >     |--------------------*********---|
> >     <----------------------------> D
> >
> > The results falls into the following u65 range
> >
> >     |--------------------*********---|-------------------------------|
> >   + |----------********************--|-------------------------------|
> >
> >     |------------------------------**|**************************-----|
> >
> > This result can be tracked with base + size approach just fine. Where the
> > base and size are as follow
> >
> >     <------------------------------> base = A + C
> >     |------------------------------**|**************************-----|
> >                                    <--------------------------->
> >                                       size = (B - A) + (D - C)
> >
> > ---
> >
> > Now back to the topic of unification of signed and unsigned range. Using the
> > union of bound #1 and bound #2 again as an example (size = B - A, and
> > base = (u64) A + 2^63)
> >
> >     |**************------------******| union of bound #1 and bound #2
> >
> > And look at it's wrapped number line form again
> >
> >                    u64                         same u64 wrapped
> >     <--------------------------> base
> >     |**************------------******|*************------------******|
> >                                <------------------> size
> >
> > Now add in the s64 range and align both u64 range and s64 at 0, we can see
> > what previously was a bound that umin/umax cannot track is simply a valid
> > smin/smax bound (idea drawn from patch [2]).
> >
> >                                      0
> >     |**************------------******|*************------------******|
> >                     |----------********************--|
> >                                     s64
> >
> > The question now is be what is the "signed" base so we proceed to calculate
> > the smin/smax. Note that base starts at 0, so for s64 the line that
> > represents base doesn't start from the left-most location.
> > (OTOH size stays the same, so we know it already)
> >
> >                                     s64
> >                                      0
> >                                <-----> signed base = ?
> >                     |----------********************--|
> >                                <------------------> size is the same
> >
> > If we put u64 range back into the picture again, we can see that the "signed
> > base" was, in fact, just base casted into s64, so there's really no need for
> > a "signed" base at all
> >
> >     <--------------------------> base
> >     |**************------------******|
> >                                      0
> >                                <-----> signed base = (s64) base
> >                     |----------********************--|
> >
> > Which shows base + size approach capture signed and unsigned bounds at the
> > same time. Or at least its the best attempt I can make to show it.
> >
> > One way to look at this is that base + size is just a generalization of
> > umin/umax, taking advantage of the fact that the similar underlying hardware
> > is used both for the execution of BPF program and bound tracking.
> >
> > I wonder whether this is already being done elsewhere, e.g. by PREVAIL or
> > some of static code analyzer, and I can just borrow the code from there
> > (where license permits).
> 
> A slight alternative, but the same idea, that I had (though after
> looking at reg_bounds_sync() I became less enthusiastic about this)
> was to unify signed/unsigned ranges by allowing umin u64> umax. That
> is, invalid range where umin is greater than umax would mean the wrap
> around case (which is also basically smin/smax case when it covers
> negative and positive parts of s64/s32 range).
> 
> Taking your diagram and annotating it a bit differently:
> 
> |**************------------******|
>              umax        umin

Yes, that was exactly that's how I look at it at first (not that
surprisingly given I was drawing ideas from you patchset :) ), and it
certainly has the benefit of preserving both bounds, where as the base +
size approach only preserve one of the bounds, leaving the other to be
calculated.

The problem I have with allowing umin u64> umax is mostly a naming one, that
it would be rather error prone and too easy to assume umin is always smaller
than umax (after all, that how it works now); and I can't come up with a
better name for them in that form.

But as you've pointed out both approach are the same idea, if one works so
will the other.

> It will make everything more tricky, but if someone is enthusiastic
> enough to try it out and see if we can make this still understandable,
> why not?

I'll blindly assume reg_bounds_sync() can be worked out eventually to keep
my enthusiasm and look at just the u64/s64 case for now, let see how that
goes...

> > The glaring questions left to address are:
> > 1. Lots of talk with no code at all:
> >      Will try to work on this early November and send some result as RFC. In
> >      the meantime if someone is willing to give it a try I'll do my best to
> >      help.
> >
> > 2. Whether the same trick applied to scalar_min_max_add() can be applied to
> >    other arithmetic operations such as BPF_MUL or BPF_DIV:
> >      Maybe not, but we should be able to keep on using most of the existing
> >      bound inferring logic we have scalar_min_max_{mul,div}() since base +
> >      size can be viewed as a generalization of umin/umax/smin/smax.
> >
> > 3. (Assuming this base + size approach works) how to integrate it into our
> >    existing codebase:
> >      I think we may need to refactor out code that touches
> >      umin/umax/smin/smax and provide set-operation API where possible. (i.e.
> >      like tnum's APIs)
> >
> > 4. Whether the verifier loss to ability to track certain range that comes
> >    out of mixed u64 and s64 BPF operations, and this loss cause some BPF
> >    program that passes the verfier to now be rejected.
> 
> Very well might be, I've seen some crazy combinations in my testing.
> Good thing is that I'm adding a quite exhaustive tests that try all
> different boundary conditions. If you check seeds values I used, most
> of them are some sort of boundary for signed/unsigned 32/64 bit
> numbers. Add to that abstract interpretation model checking, and you
> should be able to validate your ideas pretty easily.

Thanks for the heads up. Would be glad to see the exhaustive tests being
added!

> > 5. Probably more that I haven't think of, feel free to add or comments :)
> >
> >
> > Shung-Hsi
> >
> > 1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the-windows-ebpf-verifier.html
> > 2: https://lore.kernel.org/bpf/20231022205743.72352-2-andrii@kernel.org/
> > 3: https://lore.kernel.org/bpf/20231022205743.72352-4-andrii@kernel.org/

