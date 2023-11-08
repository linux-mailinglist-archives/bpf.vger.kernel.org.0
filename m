Return-Path: <bpf+bounces-14469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF297E530E
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 11:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88905B20EE7
	for <lists+bpf@lfdr.de>; Wed,  8 Nov 2023 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A9410963;
	Wed,  8 Nov 2023 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mvzr2pmi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35310953
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 10:07:27 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5BD1732
	for <bpf@vger.kernel.org>; Wed,  8 Nov 2023 02:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZj1eirWCLhJjQvOrx9NnGUU0Nhs4+oBc2B7l4otyCrZ7e2Pxs6MSyaXJni4c5jBBRk2J9D8j8KIJzDRt5eGUzEGqnbu1cNF4IJw9384em99ixZ/oAqMtq3ieE6hZ+m7QN7MY1Mj8atEkR7WkszFlc9mepFiXv/gNOQaV7RwnqqsSPiFnuXQVWJBe+E/gPRPdstDXerXgbEZgfW+sbSQneAz7EgYTFh9QjVHnw720RPKYfxB+LsHCjlwDJWtoXNfObdBqU/SiV8Z5QXsv5pu5ElB1z/UEDtuAn0fTZp9+5K3AIOH7Q+i8uNymotIPDR/xdcPG0YZ+XndCEK6IBWAyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZMiCv2l3WZ/auSgHDXUPxN0LSZHqtltHh/sMU5iAxw=;
 b=nr9NPDn/cTmszcN4TVeF2fGIy7AUNDnWfO4buqrFV6kAbgBlphzHsOyj7/nDoHg7ySPgbalhUE/xR4DWPfBUCfmuuWvSVyoGTgj1LNYrjtA72R8QuSIncbYexj11BmWmD54oK9Y4N0Wkn6+zQQEquvsEAfCTCaUffkOinJnHmJmhEDlff4gZiDoMAZENQtOI2qwS90chYSHxdPqkp2mwvdFxjTcLKaRj1s0dP6AgOyCBWjMCqSlLoNlx5RmVKjPn5WqwSwp7rNbZYeB3tY3+ItJZAu0ZyerNATv8wXMefaHh6404d/dMKVrgI8jpN8ygy+hpIGqdnDpW9+nOgSfKgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZMiCv2l3WZ/auSgHDXUPxN0LSZHqtltHh/sMU5iAxw=;
 b=mvzr2pmiLHZq58kR0gy1YQ5MV/CWmo7ccXA7WNEeJgt2EqgjtEkNJ38SEK1TOsjdQu26BaEl8i/ro/0oQb627ECdhlGt4z7JUBFDDLax5QCoicLgd1Vs9RgTDQ3FJG3FuK+RLWZTJLrCsyU7JIfdFJsY0VfyINfZIoOgLiks58dmgnEs+L8k3ONk/bPS2SFdI5KGl4A49Y8TE8oIm58diY77mhdV6qstUF0qgGfPvM7nfzVzwANi68mYRqWSpe5ECLWjnWmlpifJuE1dT2Ec0lPhH71NBTTVfwUe73XfAAX5VAU869LnG2e/PDsJ0MkRxTYMeCqPnDXSyLA8pX5vwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.13; Wed, 8 Nov
 2023 10:07:21 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 10:07:21 +0000
Date: Wed, 8 Nov 2023 18:07:06 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Dave Thaler <dthaler@microsoft.com>, Paul Chaignon <paul@isovalent.com>
Subject: Re: Unifying signed and unsigned min/max tracking
Message-ID: <5ymuvwfonurlqbf6kc6qljrxwfu7bg737hywbng6kbv47wekeg@vntb4cdvq6tl>
References: <ZTZxoDJJbX9mrQ9w@u94a>
 <CAEf4Bzb6kLMZo+VsUu=LS5V4WRY-_x-zinv0Pkr6XEbCrHvo-w@mail.gmail.com>
 <ZTtDCts772nPnKXR@u94a>
 <CAEf4BzYRSVUtO1ADdSy901UdudRELMET50ckH_tbDWV=Mx6HNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYRSVUtO1ADdSy901UdudRELMET50ckH_tbDWV=Mx6HNQ@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0133.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::20) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b3a978-0e79-4b70-5fc3-08dbe0427f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F5P67Q3tL60+OzAoO9Uqp4i/0c+v4HBnmGGlQan4gVPZkCpBGmA0FgkEPWMJFhzTivWvb3E4rzBc34xNOFTycZhVWmRfFdKGoj8HdLm+G8ck3N6snobtSAILgXK+ZmQ/g7CmUcwns1krNWaiAJlK8fUq7cR+abD6QJEXqkxe7Dvm7gmEOJM3rbTG9n+X8EcrTgGA75eqBRfDvZAzKU3VyY2uT4q4+wYuF9+gik6mVPqSxZ5UalLP22Lomvdmt9fKT8skTA7nreO5epf6hhHwVfRdomdi6+LOY16UptuMrR8zjyvB+JZ9Dl/rp6YQuU+bhOXGX/GMAmMTRkbQ6J1n8p1gf1V9tAr9LpiysdQFErlhXZZTucO126/j4bHfxRTx14AV5nlAvMKoFItLWLPnYwimjWCtYEw6jSQB3VTmIAIapJe+W9xr/uqHKPT3CIqTzrteTewPrKqU2N5qzQ81i1Vid7NZmFjEIvumJL6thZ2Axw13l2zTXze3IZYnumTPx5/+HrElYdprs1ZudmdB5KOVEk9snwBmbxnD09YVzdzAKUQrd+qJJ+3G8NrWfOGoIf6tpp2kTJxfpfdC9rYo+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6666004)(33716001)(41300700001)(86362001)(2906002)(4326008)(5660300002)(8676002)(316002)(8936002)(66946007)(6916009)(966005)(66556008)(54906003)(66476007)(38100700002)(6512007)(6506007)(53546011)(9686003)(83380400001)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWlxOFRhZEN0a2F0QXBEWFQ4Mkkvc0JKWlBjd0N5MW5yS0N3eGxKRWtEOEl6?=
 =?utf-8?B?YXFPV29DMVdUWDFZK3g2eFg4emtmSDhJWXJWUWllOFRJSjZLZWlNMjR4TGVP?=
 =?utf-8?B?Kzk3bDFONDFKMEFEdTN4WGN1emQ3bjl0MDdpd2ROQnZDQnRSN1R3WEF3bllw?=
 =?utf-8?B?bEphRnFMeW1uelF2NW9yTE1jTXgvbGZnek1ZL21nRVdlZytJaEdhRWhaRGox?=
 =?utf-8?B?YmNCUE5CUklSYnlaREJRMVJ5aUQreG9qUEFqZ2dRbXZaeUc5UEhrMUkrNnhP?=
 =?utf-8?B?eHdFUDJ5N0tYM1ZTcDRldVVYU3pUdHV1bWpHK25xZGRGWVZRNmdPUzJoM2R2?=
 =?utf-8?B?Wk92ZzUyTVVha1FOQnBKR0EyKzZZQ1RXd0xoZWR1ME0renZuTUl5TTYyd09t?=
 =?utf-8?B?S0UxWDZPanVrdWZpc2JTL3BvVkxIRVUwT3d5cWlad0t4MlZQTWtZWHJIVVgr?=
 =?utf-8?B?dHk4ckdBS2RSSDZGU3dwTnVMT3A3UmY2bVArUzduL3BWUjgwWTB1UnNTbE00?=
 =?utf-8?B?S01OS3BjcFk1bFhLMzNxUTBHeGE3NC9QR05YM1JLQ2FuNU1sUk84bGVBaTEy?=
 =?utf-8?B?UFh6cktnclNKYVY4QjFsSmdkZi9xY2xlWmZLOU5yZ1ZoZ3Y0TTF6SzR4OEYv?=
 =?utf-8?B?YisreGRsY0ZZLzVYaE5sOElxc3l1c2N6enhlNnhnMjdoVzcrbExOQ0l5amNP?=
 =?utf-8?B?cDZJcjBMM2J0YWlLWEw1TVZGNHdWZGlUYzQ2RjJtOXVjUVZoYnFnU1BWbGMr?=
 =?utf-8?B?eGhYVU5FemdkaWlMa29zN1ZkOFRxbjJOMFRVaVJzbkZwSmFUb01vZnJKbmVv?=
 =?utf-8?B?MWhvL2JxUzlmZXBzZTFZYS9SREhZM0ZJZVFMOG1oOGU0T3VqYVpzeGlCcXRX?=
 =?utf-8?B?M2YyRWVRRFVWTWNiMUFRUnBVZmRPRkRNNXRDeW5LMzR0LzdrQWgwajVETG9K?=
 =?utf-8?B?aFJ3b2lZY1ZxTTFmZjU3L3hJY2JCUnhlVWQzVnBodHdYbHZzNVA3aUgyL3J2?=
 =?utf-8?B?aFRXUWZ5WWl3TUV4Y1o1a0lEdGx4UGp0U0FjVXlibENkTzNZc05YZTIrZU9M?=
 =?utf-8?B?S1NQeFlhWU52OHR6WTFJUzJRVlYzQkNTUmF0aUxac2xwb2loNFNtZUhvOHdt?=
 =?utf-8?B?SWcvNkVJcXlxeWJiWndQSWg0MFBCbjJCWFVIQ0tidlNFY2RZOFJ0U1ArWEtH?=
 =?utf-8?B?b3BFTU1mVWx2VldneUVZTWc4RzNCVjZxT25DTEhNcmkyUmd3SU42eVh5bU9W?=
 =?utf-8?B?US9xT2dlaUt6VUpPdkFja0VpdW4xN3RJZXdOdlRQMER2Q1EzdCtERWxGbXhw?=
 =?utf-8?B?blphYkVCZkRQWFpyNDdYWU16ejlLQ2xsNFVQT01qejh2WDBjQWpMYTlKa0cv?=
 =?utf-8?B?aGtPM3hucVlQTFA5anJ6eG1reXVZMmFrRm8rdGZnQmMrTGtFK1lQc1RzZXho?=
 =?utf-8?B?ckcyaXRsVStCZEhQeHhycWs3ZzFJT2JXelowSTZCdFpvalQ1KyswWGY3ZVlr?=
 =?utf-8?B?cy9ZeWROMndDSWdUdTZmVVk2ZjZFWUZZWGxwdTl3MlpIRkcrK1c0NVBGL2tQ?=
 =?utf-8?B?L1lZdTZOOGNnb0VYOGJTNmNXU08rQXI5MmY4b0xPUXVvWnFoOHozb2I1NnpN?=
 =?utf-8?B?QkJjd2R2YUwxQ3FSL1REZ25BdWhENnFVcWk1N2xneWxXOVNPNXdwL0hPZS9j?=
 =?utf-8?B?MU9TdndyazJUY0k3Q2tnc2w1NjA0bGVWNGJ4Ri9QT05RaHR3MUhBUE92L0l0?=
 =?utf-8?B?NjJ0NGw2M0lqckQ5Z0M3ck5KbEF5Y1hLdDdQU0IrVXQybjdCaXFsNnpWUC9O?=
 =?utf-8?B?QVMrQTc3N000OUwybDdwdzJsRmFRNFBVdVlLeGlYU0V2VlNLeVh5VnFIbys4?=
 =?utf-8?B?eUJFSW1xYzhvZFZJSFNmTTlyNmVEV3lPVWwvU1F3UWZ0ZEtoaGdaZW15Qm9O?=
 =?utf-8?B?RUh6QW53T2VqcVFMRVhzMEFXSGRoK2lCMTZwbWkzVkZ6TlR1TjNmY1BnOEdB?=
 =?utf-8?B?dVVQVzR5K0ZTTEFKeC95dm1yN3NHRnMrYVZpMzR3bFY2OW1sYzE1RXlYYzBX?=
 =?utf-8?B?cnhNL3RUWE5FekZOSStPMzB6NExlMndCSDZkT0lhMnFiZW9WQzlDSEtYaHpU?=
 =?utf-8?B?WWhMRjFqaGZ4Q1h4SnE4V0tjY2loV0JGb0RwWndIOUlFV2Y3Q3lVQ0dPWXg1?=
 =?utf-8?B?VC9pbGJ3dDJ2YXMxWTJweGdMbitoclNCYWJtNGtUQU1ZVkd4dnErNUQxYzlQ?=
 =?utf-8?B?Ukd3amVuQkl1L2xaSVBRc0Z3Z0Z3PT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b3a978-0e79-4b70-5fc3-08dbe0427f2f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 10:07:21.2977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcUZywG7K/qhDcTr1+y+u3fuvhtZ6rrlJa4/RcC6MPGRgQB+DBf0cH9SzdSAgwzsqmBZui7RkN1jbM47mGE32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451

On Fri, Oct 27, 2023 at 01:49:34PM -0700, Andrii Nakryiko wrote:
> On Thu, Oct 26, 2023 at 9:57 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> > On Mon, Oct 23, 2023 at 09:50:59AM -0700, Andrii Nakryiko wrote:

[...]

> > > > The way around this is that we can slightly change how we track the bounds,
> > > > and instead use
> > > >
> > > >     struct bounds {
> > > >         u64 base; /* base = umin */
> > > >         /* Maybe there's a better name other than "size" */
> > > >         u64 size; /* size = umax - umin */
> > > >     }
> > > >
> > > > Using this base + size approach, previous old bound would have looked like
> > > >
> > > >     <----------> base = A
> > > >     |----------********************--|
> > > >                <------------------> size = B - A
> > > >
> > > > Looking at the bounds this way means we can now capture the union of bound
> > > > #1 and bound #2 above. Here it is again for reference
> > > >
> > > >     |**************------------******| union of bound #1 and bound #2
> > > >
> > > > Because registers are u64-sized, they wraps, and if we extend the u64 number
> > > > line, it would look like this due to wrapping
> > > >
> > > >                    u64                         same u64 wrapped
> > > >     |**************------------******|*************------------******|
> > > >
> > > > Which can be capture with the base + size semantic
> > > >
> > > >     <--------------------------> base = (u64) A + 2^63
> > > >     |**************------------******|*************------------******|
> > > >                                <------------------> size = B - A,
> > > >                                                     doesn't change after add
> > > >
> > > > Or looking it with just a single u64 number line again
> > > >
> > > >     <--------------------------> base = (u64) A + 2^63
> > > >     |**************------------******|
> > > >     <-------------> base + size = (u64) (B + 2^32)
> > > >
> > > > This would mean that umin and umax is no longer readily available, we now
> > > > have to detect whether base + size wraps to determin whether umin = 0 or
> > > > base (and similar for umax). But the verifier already have the code to do
> > > > that in the existing scalar_min_max_add(), so it can be done by reusing
> > > > existing code.

[...]

> > > > Now back to the topic of unification of signed and unsigned range. Using the
> > > > union of bound #1 and bound #2 again as an example (size = B - A, and
> > > > base = (u64) A + 2^63)
> > > >
> > > >     |**************------------******| union of bound #1 and bound #2
> > > >
> > > > And look at it's wrapped number line form again
> > > >
> > > >                    u64                         same u64 wrapped
> > > >     <--------------------------> base
> > > >     |**************------------******|*************------------******|
> > > >                                <------------------> size
> > > >
> > > > Now add in the s64 range and align both u64 range and s64 at 0, we can see
> > > > what previously was a bound that umin/umax cannot track is simply a valid
> > > > smin/smax bound (idea drawn from patch [2]).
> > > >
> > > >                                      0
> > > >     |**************------------******|*************------------******|
> > > >                     |----------********************--|
> > > >                                     s64
> > > >
> > > > The question now is be what is the "signed" base so we proceed to calculate
> > > > the smin/smax. Note that base starts at 0, so for s64 the line that
> > > > represents base doesn't start from the left-most location.
> > > > (OTOH size stays the same, so we know it already)
> > > >
> > > >                                     s64
> > > >                                      0
> > > >                                <-----> signed base = ?
> > > >                     |----------********************--|
> > > >                                <------------------> size is the same
> > > >
> > > > If we put u64 range back into the picture again, we can see that the "signed
> > > > base" was, in fact, just base casted into s64, so there's really no need for
> > > > a "signed" base at all
> > > >
> > > >     <--------------------------> base
> > > >     |**************------------******|
> > > >                                      0
> > > >                                <-----> signed base = (s64) base
> > > >                     |----------********************--|
> > > >
> > > > Which shows base + size approach capture signed and unsigned bounds at the
> > > > same time. Or at least its the best attempt I can make to show it.
> > > >
> > > > One way to look at this is that base + size is just a generalization of
> > > > umin/umax, taking advantage of the fact that the similar underlying hardware
> > > > is used both for the execution of BPF program and bound tracking.
> > > >
> > > > I wonder whether this is already being done elsewhere, e.g. by PREVAIL or
> > > > some of static code analyzer, and I can just borrow the code from there
> > > > (where license permits).
> > >
> > > A slight alternative, but the same idea, that I had (though after
> > > looking at reg_bounds_sync() I became less enthusiastic about this)
> > > was to unify signed/unsigned ranges by allowing umin u64> umax. That
> > > is, invalid range where umin is greater than umax would mean the wrap
> > > around case (which is also basically smin/smax case when it covers
> > > negative and positive parts of s64/s32 range).
> > >
> > > Taking your diagram and annotating it a bit differently:
> > >
> > > |**************------------******|
> > >              umax        umin
> >
> > Yes, that was exactly that's how I look at it at first (not that
> > surprisingly given I was drawing ideas from you patchset :) ), and it
> > certainly has the benefit of preserving both bounds, where as the base +
> > size approach only preserve one of the bounds, leaving the other to be
> > calculated.
> >
> > The problem I have with allowing umin u64> umax is mostly a naming one, that
> > it would be rather error prone and too easy to assume umin is always smaller
> > than umax (after all, that how it works now); and I can't come up with a
> > better name for them in that form.
> 
> min64/max64 and min32/max32 would be my proposal if/when we unify them.

i'm going with start/end for now since it go along quite well with the
number line analogy, where the number line start at at one point and
ends at another; and it should be less assuming about how the values
compares.

Following this logic, `end - start` would be call the length, rather
than size that I've proposed above. Calling size is not that great
because it implies this is the number of values between the two bounds,
but in fact it is off by one, (borrowing from Eduard's email[1]) the
actual number of values N between two bounds is 

  N = end - start + 1

1: https://lore.kernel.org/bpf/d7af631802f0cfae20df77fe70068702d24bbd31.camel@gmail.com/

> > But as you've pointed out both approach are the same idea, if one works so
> > will the other.
> >
> > > It will make everything more tricky, but if someone is enthusiastic
> > > enough to try it out and see if we can make this still understandable,
> > > why not?
> >
> > I'll blindly assume reg_bounds_sync() can be worked out eventually to keep
> > my enthusiasm and look at just the u64/s64 case for now, let see how that
> > goes...
> >
> 
> probably, yes
> 
> > > > The glaring questions left to address are:
> > > > 1. Lots of talk with no code at all:
> > > >      Will try to work on this early November and send some result as RFC. In
> > > >      the meantime if someone is willing to give it a try I'll do my best to
> > > >      help.
> > > >
> > > > 2. Whether the same trick applied to scalar_min_max_add() can be applied to
> > > >    other arithmetic operations such as BPF_MUL or BPF_DIV:
> > > >      Maybe not, but we should be able to keep on using most of the existing
> > > >      bound inferring logic we have scalar_min_max_{mul,div}() since base +
> > > >      size can be viewed as a generalization of umin/umax/smin/smax.
> > > >
> > > > 3. (Assuming this base + size approach works) how to integrate it into our
> > > >    existing codebase:
> > > >      I think we may need to refactor out code that touches
> > > >      umin/umax/smin/smax and provide set-operation API where possible. (i.e.
> > > >      like tnum's APIs)
> > > >
> > > > 4. Whether the verifier loss to ability to track certain range that comes
> > > >    out of mixed u64 and s64 BPF operations, and this loss cause some BPF
> > > >    program that passes the verfier to now be rejected.
> > >
> > > Very well might be, I've seen some crazy combinations in my testing.
> > > Good thing is that I'm adding a quite exhaustive tests that try all
> > > different boundary conditions. If you check seeds values I used, most
> > > of them are some sort of boundary for signed/unsigned 32/64 bit
> > > numbers. Add to that abstract interpretation model checking, and you
> > > should be able to validate your ideas pretty easily.
> >
> > Thanks for the heads up. Would be glad to see the exhaustive tests being
> > added!
> 
> Check [0]. You can run range vs consts (7.7mln cases) with
> 
> sudo SLOW_TESTS=1 ./test_progs -a 'reg_bounds_gen_consts*' -j
> 
> And range vs range (106mln cases right now) with
> 
> sudo SLOW_TESTS=1 ./test_progs -a 'reg_bounds_gen_ranges*' -j
> 
> The latter might take a bit, it runs for about 1.5 hours for me.
> 
> It's not exhaustive in a strict sense of this word, as we can't really
> try all possible u64/s64 ranges, ever. But it tests a lot of edge
> values on the border between min/max values for u32/s32 and u64/s32.
> Give it a try.
> 
>   [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=797178&state=*

Finally gave it a better look today. It looks good. With this I should
be able to easily see how the unified range tracking differs from the
latest implementation once I have conditional jump logic implemented.
I've only got to add/sub/mul so far[2].

2: https://lore.kernel.org/bpf/20231108054611.19531-1-shung-hsi.yu@suse.com/

[...]

