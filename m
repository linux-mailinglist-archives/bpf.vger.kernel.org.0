Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DCC5E5A60
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 07:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiIVFAa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 01:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiIVFA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 01:00:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2078.outbound.protection.outlook.com [40.107.21.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BFC9F1B6
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 22:00:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWOGUPpzayQAMgLYlSwEKPPh3SFw9/AGy4r3xhBDuABX7nzoXuD8+GFuLvplhKF0DuuqKNx6vTnr1ZfkkfruQzZYjG3Lt7dxcHLt8jfNAsKDkBnoFeNrxV5AUXN5OuQY7C506As/zQHGNEJGSw65jlEhTGTUm6ElA1gfe6gpQmfVbAue6a1ZmORrHiehdvgz3zWFm6GrEJ7mlvkoHDcx6ei9EDSyrnI7+xiX0q2rpYs9AUfACKSIoXGkG1KpR1AZEZ5FK+/MTvm5nHaxHNu3HYhJrGwGNTMKduWKVAu9p6VjcmOOJLD59rDhvofgO7T6iWafu9izKlfwQt46BsGH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXB7Iob/542vbf+qS2iyKY3QwXcjHFKUNqXJCSvSwBc=;
 b=ZpEcH759bbsPXj6EZdHuaHeZEmL3PIDtp0jIA71MPOL0hMn3XMM4qFQevrAOvgFxts96KT0IHIMhJiZqc6feMsAFsU2l9vd400V0Hvu53oniznwpz3PxNi4NlfzKAbSKf+JQJytcRinVSB/Sp1BusEikxvnCzY2QAonDN6ttmnqDYZeDkDZOPHlfUzvnKEIJLhpLBgfq/FRijIOHq8FMQ4GFYHuoeejbkUtC4OpKN1z/n3Y38h9hUdS08sQCxDQN7RKEUD5kfJ2XazQKg5ov6F2uqnq2vubXxXIxYrj3IeIl9q9ylRmEJLNolfO7EpxTBir9gh0GJmxw7DYQit/O/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXB7Iob/542vbf+qS2iyKY3QwXcjHFKUNqXJCSvSwBc=;
 b=aL7VXb4px5zebEZ3jW9PwMeDWPQVs+6oLksjZTgGpOYRD+2daTimoGqETahVafoUFYYH3L1zyn8hG8YM0zc+X51X3mvs7KMFvlqq/LD+CE0ivZn3VKFVwH3kk87q6FheT61064qoJSDKRbslKrCUqK96ci+PIIxXe/SHE6XtTTqiv49QrndRY0ZtrC2VbrCD/ygtoLAtuGKaL+L+OsAgyQUKui3PeDMgSk+MHHSltDIb5kY2z9vl5rOgq6819kaWmpgrx8rXXxBNMc70R3LMa1UBU7vV/qJRp2XO7y1j8o5Nsste8Ral6HBT3p4u4Oi23wrcw1KT8QyMZnOkZpg15w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 05:00:22 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::50ef:4600:41bf:b51a]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::50ef:4600:41bf:b51a%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 05:00:20 +0000
Date:   Thu, 22 Sep 2022 13:00:14 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Dave Thaler <dthaler@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Rethink how to deal with division/modulo-on-zero (was Re: FW:
 ebpf-docs: draft of ISA doc updates in progress)
Message-ID: <Yyvr3v5yFXcq/wK0@syu-laptop>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop>
 <YyihFIOt6xGWrXdC@infradead.org>
 <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
 <YyrMpAPJrP851vE1@syu-laptop>
 <CAADnVQJAJaBaU_bsGZNqq8pRso4pNceXBprUwSENJSomq8UDaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQJAJaBaU_bsGZNqq8pRso4pNceXBprUwSENJSomq8UDaQ@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::16) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|AS8PR04MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfdcd06-6470-4799-67f6-08da9c57599c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/eNMys9lALglwLgMcmS6iee94FZ2TYKrZd+5TlFciOLO13CGeb07OH7qXik44I7ut8CJCVE3ztQuwU3kEIGI3f/30Ec1bnNovYtqEl+7ZYt30hUbsZYgtU49s8wv8OtjeNvfcODwLymheHEqXzfXGhOtjuu/78vewsrHDrXiTlHZqO/oZsXux4dRCdNwTioFMEZmeHqLS1UZJXR6SEEgTL/1MtFG2dxvjRC9EUUj5alXi5oZju2/wTOdB1CPSEYEh/BquneohvE/wEM8i8CiFUh5K60aNEHXAyqZTwHnsFLt6jAhCQ5snC17/k2JgFDCKfsR4n3bPkOCTonJ+vl9D7mXoGvhzE0xOZS05khsX+KRipI0no/2gVpiDWgVZUDsE70gKoRa1Sdss83/0BAM2lAJ1UKh0+YAErll+BDlRQOdwozisa6RIIWzPG/eMpiBp9SLpg8AoamBD6u208YViHIepqTpWrx95noSKHhUgxz9nP34IxDG/T+MXQRhDAwvTDomWzbZK0f7AnAF0WbDYu4FYEKVw7ab4uYD/eUFMXdzbGhEV0pciFOUs2guykFul9SBHs/bUilnEIGW3xtetvU4svaVDBY8AZWS1dnue0eBc7vlB2v1OgysdFhl0nckVyFx7HmyPq3fPaTJ15OW9b0jlIByl7rTiicMQwclfIf8XVtqyEkGYAIKOJdCvqY7/giPCoYjOi4ltP+zLTsxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(66899012)(66946007)(66556008)(66476007)(83380400001)(53546011)(6506007)(45080400002)(8936002)(5660300002)(186003)(316002)(54906003)(6916009)(6486002)(478600001)(6512007)(9686003)(38100700002)(6666004)(8676002)(33716001)(4326008)(26005)(15650500001)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y04xbmU5eFRBcm1uQmNSVUwwVUlZdHFkNXNYMjNXS2I4QTJ5NUl0Y1VyVHR1?=
 =?utf-8?B?OHlUUTU3YTl2Ulk0ajA0NjdLUUNhanoyaTZteUgrbk9COEFpeGJjZC90Vitp?=
 =?utf-8?B?QUUzUkNQaHIyN1ZEakY2aTF1MHliOWM0MWN3RXBReVpleUt3dWdDaVV2SkRk?=
 =?utf-8?B?djBnamY4bytTZk5PYTlzeW1hUEI3R29qN3NFeEYyWHNlMmFhWTFlb2Nhbkk1?=
 =?utf-8?B?RHR2MDIrYm1oR2hUNGFsVVVPK0pXckMvZ1BiNFd1TTZ1TnBUUk1Tb0hia2d0?=
 =?utf-8?B?a2ZMdEZhY2Q4SitJWkRwN3dKT2NOTVZvaDhqdk1OOXBtOFA1MEtQNkc4K1Y1?=
 =?utf-8?B?TUZFOG1qQXZNM0xLU0RNUVlLK1VhenBFK3pmaHZsV01wUklRR3dFWjRJemY0?=
 =?utf-8?B?bUZkaFdoM255d3JoWVpldUllQWlpdlpqbWNLLytvVkVpVHpRbnBRVWxDTTNO?=
 =?utf-8?B?WnZwTTBlMW4xS00yaDg5NTR5dGVvQ2RpeEh5Y3d0clpTWmU0U0llanFqei9m?=
 =?utf-8?B?VzFFNmhsRGs0UzlWU1N4THNJYWRaVmlNWGtYR0MwN3dTdDZHTVJUdmhwQVlu?=
 =?utf-8?B?OGxoTFpHWWpIQzdYMEFuTmdDMEhSd2ZSa1EybDVDc2ZWNGw4WTZzYWllRVFV?=
 =?utf-8?B?aHNCTWl4RnoyL2N2dWdmZXhaeGdET1h6WjJXdmRLOGs5N3Y4TmRHRWtHVHhT?=
 =?utf-8?B?SlR2Ly9WSjNHQnVzQVVmaThYRzR5aG9NeFU2ZGRvaGdBWk53VjlmMXE3S0g2?=
 =?utf-8?B?M1NCNnV6RWtiS2FKVDhpdEhLTFZEbnNvT09TTHZGZVJraXhDZGltek9aR1Vu?=
 =?utf-8?B?cWh4VkxwdTlyUTVFdkQ5ZlJVVU4wUFZpcW5EbmF0WlRXdHJ4U3VEbndxcDNN?=
 =?utf-8?B?NTFrRkhEaEMrM0VHekxqNGZuQ052eTBHQktPSEp4TUYrSGxGQ1U2WE9ia0lM?=
 =?utf-8?B?b0grYmpHV2UvSkhCS1N2WFlQU1F2UW1mRVBpS25wbUExR1pYTUpCaWRuaU1E?=
 =?utf-8?B?b0xYSkJRNjdRdVl4Rk5HYjVQV1dnaDZMV0xmY1VXd0FBNmNWMDZrMDhqUjMx?=
 =?utf-8?B?Z01BaEZIT042NU9xVDB2UHlycjlKUHZhd0Q0aEUvS3g1NXliL3JCYWdzUThV?=
 =?utf-8?B?UDh3c1grdmMyMnoxcDFFSmJWSjR6VVVKWmRtR2VHOXFnUVJSRHh0aVJHeS9P?=
 =?utf-8?B?MlJpOFlQandORnl4QXRxUy93alc4T280ZUF1VmJtVThFK1JaSFAyRFBROS9I?=
 =?utf-8?B?T29rQzJZYlFXcGRZL3JtNWgyYUd3WERsR0d6dWJualc3cDlldXJmMmxoVEdx?=
 =?utf-8?B?ZHEvM2tEb1hvS2VlRFFIWG9PdUhzaGdTY1NKUG56T3YreDFrVVFqT2JLQUF3?=
 =?utf-8?B?Y3dSYVJkM3N6T0Jac1k4ckZMVGY2SnFvcGdMdVRDTmpHRWFZdGtyWjg5RnlS?=
 =?utf-8?B?dGZiUzB2L2w3eXVCaENsY2tVR1RCWWV4R0U1WFdxNi9hSlRFODlxcW00Y1Bn?=
 =?utf-8?B?V2JaR2YzUy9qWWlXK1FaN1I5Vm5xQXd3MExuMWRYT3V3d3hNYjNNNTZlRjVy?=
 =?utf-8?B?SzVLUVNURzFHL3YzTTdST3R4WmJMZkw5Wm03OEVJdjY3ZWNVeFdsazJPdkNu?=
 =?utf-8?B?d3Q2T2hPWnJDcThjaHY4Vzg3ei9YaENQYlU0eFluY0Y5ZWhXYk9JYkVxaU94?=
 =?utf-8?B?ZUtLNHZQT2FGOXBRb1RYZ2NyLzRBMVZ1QWxpNU9Ic2pvZHJkZ013NG9LTkQy?=
 =?utf-8?B?Uyt4WHNLaTFudFByRkxzTTM1dUFOSDU1UmsrY0JVUmQyRGhTOUJmazhrNW5L?=
 =?utf-8?B?azJubWpoVFFvNTFHS2YyM3pWbE5henFzc0xub1VPeFFvS2lPUlV6WVlOc2Nq?=
 =?utf-8?B?eStUblJqQTdrUlRNdGw3WlNoeFNpcnc3RzNBQW5ScWdRR0lIR1p1NHRSUHYx?=
 =?utf-8?B?TENBVitFUklmRHcvN29VSFpSVlJZbHg5bTh3ajRWZDlBZXlkRytCOVhwcElB?=
 =?utf-8?B?RUVpTlkwRXQ3ZGNEM3o5K0M1QUgydVlab1pIc2RYZTdjNmxzNnlJUGUvamN4?=
 =?utf-8?B?YjRVZlhHazZ4L2c0NnYreU44Q2dmZk9ZTFZFbXZCZU51eXhVYjBwUlpUanph?=
 =?utf-8?Q?IV7EnZJrD++6ZEs2zpgdS/CLN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfdcd06-6470-4799-67f6-08da9c57599c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 05:00:20.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXVHCdw9VV3g9PUoPI/hElPO3zXrzLQK6Af4ANbVSWwGN8+hC/j8xFRTuCMBxAHeUFdcWuTkfh6fHtB02VBGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 21, 2022 at 06:50:54AM -0700, Alexei Starovoitov wrote:
> On Wed, Sep 21, 2022 at 1:34 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Subject changed to reflect this reply is out of scope of the original topic
> > (ISA doc).
> >
> > On Tue, Sep 20, 2022 at 04:39:52PM -0700, Alexei Starovoitov wrote:
> > > On Tue, Sep 20, 2022 at 12:51 PM Dave Thaler <dthaler@microsoft.com> wrote:
> > > > > -----Original Message-----
> > > > > From: Christoph Hellwig <hch@infradead.org>
> > > > > Sent: Monday, September 19, 2022 10:04 AM
> > > > > To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > > > Cc: Dave Thaler <dthaler@microsoft.com>; bpf <bpf@vger.kernel.org>
> > > > > Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
> > > > >
> > > > > On Wed, Sep 14, 2022 at 02:22:51PM +0800, Shung-Hsi Yu wrote:
> > > > > > As discussed in yesterday's session, there's no graceful abortion on
> > > > > > division by zero, instead, the BPF verifier in Linux prevents division
> > > > > > by zero from happening. Here a few additional notes:
> > > > >
> > > > > Hmm, I thought Alexei pointed out a while ago that divide by zero is now
> > > > > defined to return 0 following.  Ok, reading further along I think that is what
> > > > > you describe with the pseudo-code below.
> > > >
> > > > Based on the discussion at LPC, and the fact that older implementations,
> > > > as well as uBPF and rbpf still terminate the program, I've added this text
> > > > to permit both behaviors:
> > >
> > > That's not right. ubpf and rbpf are broken.
> > > We shouldn't be adding descriptions of broken implementations
> > > to the standard.
> > > There is no way to 'gracefully abort' in eBPF.
> > > There is a way to 'return 0' in cBPF, but that's different. See below.
> > >
> > > > > If eBPF program execution would result in division by zero,
> > > > > the destination register SHOULD instead be set to zero, but
> > > > > program execution MAY be gracefully aborted instead.
> > > > > Similarly, if execution would result in modulo by zero,
> > > > > the destination register SHOULD instead be set to the source value,
> > > > > but program execution MAY be gracefully aborted instead.
> >
> > While this makes implementation a lot easier, come to think of it though,
> > this behavior actually is more like a hack around having to deal with
> > division/modulo-on-zero at runtime. User doing statistic calculations with
> > BPF will get bit by this sooner or later, arriving at the wrong calculation
> > (fast-math comes to mind).
> 
> lol. If that was the case arm64 would be on fire long ago
> and users would complain in masses.
> Same with risc-v.

whoa, I had no idea.

And looking around I don't see complains. Taking what I said back and +1 for
using the current division/modulo-by-zero behavior as standard.

> > This seems to go against some general BPF principle[1] of preventing the
> > users from shooting themselves in the foot.
> >
> > Just like how BPF verifier prevents a _possible_ out-of-bound memory access,
> > e.g. arr[i] when `i` is not bound-checked. Ideally I'd expect a coherent
> > approach toward division/modulo-on-zero as well; the verifier should prevent
> > program that _might_ do division-on-zero from loading in the first place.
> > (Maybe possible to achieve if we introduce something like SCALAR_OR_NULL
> > composed type, but that's definitely not easy)
> >
> > Admittedly even if achievable, this is a radical approach that is not
> > backward compatible. If such check is implemented, programs that used to
> > load may now be rejected. (Usually new BPF verifier feature allows more BPF
> > program to pass the verifier, rather then the other way around)
> >
> > So, I don't have a good proposal at the moment. The purpose to this email is
> > to point what I see as an issue out and hope to start a discussion.
> >
> > 1: Okay, I'm making this up a bit, strictly speaking the BPF foundation is
> > safe program (one of Alexei's talk) rather than preventing users from
> > shooting themselves in the foot.
> 
> Safe != invalid.
> BPF doesn't prevent invalid programs.
> BPF ensures safety only, not crashing the kernel, not leaking data, etc.
> For example: under speculation arr[i] can go out of bounds
> and to prevent data leaks we insert masking operations.

Point taken, thanks for clarifying the difference between safe and invalid.

> Similar with div_by_0. If the verifier can detect that it will reject
> the prog, otherwise it will insert if(==0) xor, because not
> all architectures behave like arm64.

Speaking of which, should the "if(==0) xor" patching in do_misc_fixups() be
moved into JIT implementations and the interpretor? 

Given that the standard now mandates BPF_DIV with divisor of zero to return
zero, it would be rather confusing to see the output of `bpftool prog dump
xlated` contains the extra "if(==0) xor" instruction that's inserted by the
verifier.

Also, maybe there'll be performance benefit for arm64 and riscv where
"if(==0) xor" is not needed.
