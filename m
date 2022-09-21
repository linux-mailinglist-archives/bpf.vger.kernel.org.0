Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D95BF95B
	for <lists+bpf@lfdr.de>; Wed, 21 Sep 2022 10:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiIUIfC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Sep 2022 04:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiIUIez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Sep 2022 04:34:55 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905134363E
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 01:34:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mi2jhpdvwZogoHwbZDWYb3EdAcyBGeFlDbVICrfuAxEyurtHSeqipUHManIZAlb2BfnG61H741AQ+MChkecuHCzBHK7nPWHZykJQMPSpvCj5BGkY3u7IK5n6Ley+AUKLhdhUm9FhDkxW+suscCdfNnxyYukOZkXTVxke2FuW1dnYYB9Ne6a7TAs6agAYdQkws5t0H5cBm2FbaT0xV+hVJMC1840SrscB2y9v/POZm6ArJV+sdQQd0B0OtrgukuJIdW+Sp66JJiD48lCuwE61kZ3kNNcxWO+Qc5rl6bXjhV5txhyAUb5lIyuqKIsU/qT6GlT0bdsCtWw8W3R1Y2opcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83S3ozagbOip0TjtHik479LqaVn+1fricxLQMUgoSWg=;
 b=Aw5c4QDoRmvnLtk3FmFMV+l5UyQzdkWCsyd6uUyfcFyWNtwCVgPgLcdaHFez8CP7UZueJnqG1BG10nn2i2srbvxGXq9A1W/UqTVJmvUscKTknqiWsDIBOG5MV/Q/XRS5q84d8Lk5390toi1VwiDgHxSpomO/JkFFB9TzU416KD5GCGsMmYdM7VkJa5nNuSkPbQu1OxjJw4rf4Ibj5IUfVSlZZlR1g1oBPbcAluny3Uxu90xq0EG47f8pDd7TyuhBZ9EhnTHzBC2LngPTPzFV3KS6CzcKQ5H6DbFv3sxmLrM0xa1ACfgii9G8g8kgg6wytIa2oVWQvEIGBIvHiWcFfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83S3ozagbOip0TjtHik479LqaVn+1fricxLQMUgoSWg=;
 b=U4tPPKdjDV4+VqZGsnfnsaswt3CxW34itBxx7rim7GSwg3PTlEO0T0d22+CxpAEZpgWYirq6D9q19n9VKTvgVbe5mDXvnYP+87fK4j63jQ/jsB/2nH6VTAyNRfngCu7bGv4DmDK3YAx4UJ3PTAqagQuxe7akJUl7FE6v7TBpIMSFHQK7Pm5CLT6QsB6xoCTVuD7DX3PTO5xA1qB4YAgz8j0rzfD+TMggczd73gThF2Sk5BGfhTc6MWMjlFVs8AJ1Wg3MHRRkUFnI0cJ5ArI5cgw5GwQQi0TU5w2lOK4BMutr/NRjS1COEZatFXyz1T1XUrwUtbjK4DUrukJ19cpGaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AS8PR04MB8038.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Wed, 21 Sep
 2022 08:34:50 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::50ef:4600:41bf:b51a]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::50ef:4600:41bf:b51a%7]) with mapi id 15.20.5654.016; Wed, 21 Sep 2022
 08:34:50 +0000
Date:   Wed, 21 Sep 2022 16:34:44 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     Dave Thaler <dthaler@microsoft.com>,
        Christoph Hellwig <hch@infradead.org>,
        bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Rethink how to deal with division/modulo-on-zero (was Re: FW:
 ebpf-docs: draft of ISA doc updates in progress)
Message-ID: <YyrMpAPJrP851vE1@syu-laptop>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop>
 <YyihFIOt6xGWrXdC@infradead.org>
 <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::14) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|AS8PR04MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe156b7-f0e1-42c8-47c2-08da9bac2606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: epSoHX21bFnwYOhrTboyTOM0kCPzlUdijJXJQWmfHp+KhqOWGG26ZAZ1dS2XbPNgpGMaKDit+kQ7b2mO7rXS4f5l2PVrM1uYf715nL9twTQVP/fh79zLvhYSw02cuETKYL4MY+DslO7pV3QT0tEXUT1CE98BhxNOKiuIGRerGVNCPTm6NDpC9e2eORKMX9KEfSZBAV+uvyGDWJfIxPWLBGTMfAiA7BnUoSCak9K/97SZTOnecNm6FHqKEHM0QJ27CT0e0K0noLlfa7zPZABjDqStYdgCL5CTIOeue0fiS6JfP6TvRtDfEfg3CDDXhznuStNtIWNOnM9w+cqeAXLRyItA4p2x3eVlwbv47K9o+LpFBzsFyR7lWIzx/MBJ10RhM/pYY1LK9sM7pxB6JpetpFYOs9XF9UqJVbWOcdIw2j7DbM1HfvvAJdL/Coxeq77aiQ1NY5HYYQFkQTamQby9NQ0Nl6bdi0pAV990scKTKiaznoLDIfOebbbUaAhWQxfvb0nF2CnWuroB2PI0K/WSghtr4wQ5TaOY+PWFFXlYy4oLkNs6ZOxVTlYzBq3McQZr6/cgq3XwJCx8Arxqdav7X4NWggtoX1cCZaaJrcdxaecYBYjFkDN2ttywCjkMCPqy6D3tO7PzAWZzJnGjY8V2THKXDT1wziABWr0bNuB/sHppgSeSWevpyGaoTk0yocbLnoFEA1q67MOTJm9Vl/AJzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(186003)(83380400001)(41300700001)(15650500001)(6666004)(2906002)(86362001)(53546011)(66899012)(38100700002)(8676002)(33716001)(9686003)(6916009)(54906003)(6506007)(6512007)(26005)(4326008)(45080400002)(316002)(478600001)(8936002)(5660300002)(66556008)(66476007)(66946007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlUvcjcwb3pNbDR3eGN3VFVxZzdMZGI0TDBsYTU2NWxhRVFhaHMya3M2TkRs?=
 =?utf-8?B?RjJyYjVLVFBTcGNhNzE2N2tiTnRZUW56TS9DK1M5UGs2ZzBXR3p3VWZLVjlS?=
 =?utf-8?B?NXJBRkVvNGJ2cjh0aVJCV1RrUjdEK2l1MzJvZ0pibForZkxnS21PaGNLRVdo?=
 =?utf-8?B?UjI0N1dVVnpWQzQ2dERzdXhXRFRLd1RnbE1Da0lTb0Frd3hORG95ZUJLcWth?=
 =?utf-8?B?OTI0OWgwU2RUTUptdFU1RjlUWDFEOGgweE84ZGJhVHFqUmI0aDFJdTN4eGtz?=
 =?utf-8?B?U0dCUnVRZU0wcXdMRmVHeUpObFdSZ2owRnhQcjRKQmZBd05LbHJzczJaLzhH?=
 =?utf-8?B?YmZIL3NxZm4wMlVZZ0ZEK3dIMmNQdlRNeWhrY3dZeWFaRmxBcy82Z1dZZ29M?=
 =?utf-8?B?ei9WOTFSODNwS3JkbW1oTWg4ekRJNHRtT0hBUFBXVUlnUUxvdWRDcmc4djBz?=
 =?utf-8?B?RHU4MkpGVW5Ha3NmcGtlZXZvVmd6K0hTYnhma0pYY1pEdU91RmhkejlwSVZk?=
 =?utf-8?B?VXQ0amFPd2FnUmtGTWFuUFlIWXFvSXpyMFJyN1NmZmhZY0NPUnRxcFh2VzB0?=
 =?utf-8?B?cHlPTm5KMitsTDhLOGhRUm1PTk8za0l0SG1MNlZONGdLOU53QzdBVjMyQXUw?=
 =?utf-8?B?VjRocVhnV3VubVJmQ3EzaTNvTGJDa0tLWWxwMkp6VzRNRWxqKzJaWXE1VGo5?=
 =?utf-8?B?eFR3V2o5Qm5BUCtnZDNReVRBNkthRm5pOSsyK2s3UUo3ZWVDS0dLYVA5MXg4?=
 =?utf-8?B?dmE0dUc2blU5bXFnQUNSeFZnbzZlMWY4RGlkSW83VVJINE5ESEtmNmQ5YVUv?=
 =?utf-8?B?N1VOakVhcDVrbStKczcxOERCd2hjVXA3MjMyM3pKa010cDMyaU84NnFXSjJw?=
 =?utf-8?B?V3JCcVkveGFncURNVDliVUhockM0czl4TlFSWDBCa2hmMHljWmR3Z3ZCQ3FL?=
 =?utf-8?B?cXJMOTFBYWNrdWoxMTVEdzNHdUxYbW80cFhucXUwMS9ubVF2ZXFrS0U1ZFQ3?=
 =?utf-8?B?dEk4ekFuS3lxSTRCZ1ZuT3hXazNQT3A2YWMwaDAyMms2WDM3eHdZT25yS3h4?=
 =?utf-8?B?ekh2Q3dMSmVDb1dxQ3NtN0ZuUU9kL0tjWDZ5dUFJTVNSY0xxTEtHcU1DUEFV?=
 =?utf-8?B?bGcxTzgzdXdRMElTWXNtR1lkVlFxa0tORGFSc0VZclFhRVIvdDBWdElvd3Ux?=
 =?utf-8?B?N21oeENpS3ZFNVcxMmF4TUpYWG9rMkJhWU40OXc5b2l0b0dZNUtOOG1qb1cr?=
 =?utf-8?B?b0FqZEcxUmQ1R0pBRDZMcWpXMU1WaWdnTWI0QnVVc0NqK2FUR2Z4SitLMjd6?=
 =?utf-8?B?cEFqZHhocnRHU240bC9hcko1dWpRRUxxeUZrN0ZoaW0zQ0hvVkNoZzB3TTJC?=
 =?utf-8?B?Z0lXcXN5RFRrZEhjRU9iY0NtTHVwVDcyZmJpU0hpR08yam5hYTNqdkRwdmRC?=
 =?utf-8?B?U1hPbCtLNElsTSttUlY3dmJROVkyUE1sblJ6UUxhcG1nSXJEZHJKYW0vSS90?=
 =?utf-8?B?S09Bc0xZQ0FpWFR0cjQvQ2QyWVcwaG9oQzdjVmJOU1FPUHRYZFZDbzZBVk4r?=
 =?utf-8?B?Uk95WE9hTmYwUFdaSHhyd0NxWXhRQng4eG9kYWE5QW1wYWZBV3pRcnFkdmhU?=
 =?utf-8?B?eHczY0RJUUdMb3BkWCtKRVJOU1BwWjJiNldmQkpqakZuek5PQWRKUjFJaTJa?=
 =?utf-8?B?Zk5RZTB2bFFpUlJQWHQ5OE9TNXpNam1DTkk2d2tHdWtHWVJQNVZmc2E2RzA4?=
 =?utf-8?B?Y1Y0UFBMWm9EZnNTcTFMbjJzcDdJeTAyTDUzZW05QjdaaGdueUVyeC9OUVp0?=
 =?utf-8?B?ZGhybjkrdGpVaGdDQldZbTNXd1k3ZFNDZWkvVnV0WllkVEtWOHRXM002UkNj?=
 =?utf-8?B?SnFBYy93ZkNZM0dhSnU0dTU4M2krZlJob2lTQmoyUVZCeFhNQkVva2NPL0E4?=
 =?utf-8?B?WC96OTA4ei94a29qRHZuRkpvdlB6L3JwVmh1MkNRak1LUkJhNDNRck9PbGw3?=
 =?utf-8?B?RytsMFhJYnkyZDhWc0c4ZTBUMGgwdG5BcTQwamlWQ01MN2lmODROSEhuRVRS?=
 =?utf-8?B?VzAvS2JZd3VGb0JPUXJvWmczY0J6VnNZVGZyYlc3QzBTM3FTaS9RV21SNzZT?=
 =?utf-8?Q?v23QukLWwKGqNsVyVCqR3ZWZi?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe156b7-f0e1-42c8-47c2-08da9bac2606
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 08:34:50.2847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZLyUcOKy+cjVe+FVzsA5ti2+VKa0oiSVKUjPjXCwI+1gUgx/FYlEsL1WJ+f6PQUUSfGMTWiqp40zvNmn5FP3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Subject changed to reflect this reply is out of scope of the original topic
(ISA doc).

On Tue, Sep 20, 2022 at 04:39:52PM -0700, Alexei Starovoitov wrote:
> On Tue, Sep 20, 2022 at 12:51 PM Dave Thaler <dthaler@microsoft.com> wrote:
> > > -----Original Message-----
> > > From: Christoph Hellwig <hch@infradead.org>
> > > Sent: Monday, September 19, 2022 10:04 AM
> > > To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > > Cc: Dave Thaler <dthaler@microsoft.com>; bpf <bpf@vger.kernel.org>
> > > Subject: Re: FW: ebpf-docs: draft of ISA doc updates in progress
> > >
> > > On Wed, Sep 14, 2022 at 02:22:51PM +0800, Shung-Hsi Yu wrote:
> > > > As discussed in yesterday's session, there's no graceful abortion on
> > > > division by zero, instead, the BPF verifier in Linux prevents division
> > > > by zero from happening. Here a few additional notes:
> > >
> > > Hmm, I thought Alexei pointed out a while ago that divide by zero is now
> > > defined to return 0 following.  Ok, reading further along I think that is what
> > > you describe with the pseudo-code below.
> >
> > Based on the discussion at LPC, and the fact that older implementations,
> > as well as uBPF and rbpf still terminate the program, I've added this text
> > to permit both behaviors:
> 
> That's not right. ubpf and rbpf are broken.
> We shouldn't be adding descriptions of broken implementations
> to the standard.
> There is no way to 'gracefully abort' in eBPF.
> There is a way to 'return 0' in cBPF, but that's different. See below.
> 
> > > If eBPF program execution would result in division by zero,
> > > the destination register SHOULD instead be set to zero, but
> > > program execution MAY be gracefully aborted instead.
> > > Similarly, if execution would result in modulo by zero,
> > > the destination register SHOULD instead be set to the source value,
> > > but program execution MAY be gracefully aborted instead.

While this makes implementation a lot easier, come to think of it though,
this behavior actually is more like a hack around having to deal with
division/modulo-on-zero at runtime. User doing statistic calculations with
BPF will get bit by this sooner or later, arriving at the wrong calculation
(fast-math comes to mind).

This seems to go against some general BPF principle[1] of preventing the
users from shooting themselves in the foot.

Just like how BPF verifier prevents a _possible_ out-of-bound memory access,
e.g. arr[i] when `i` is not bound-checked. Ideally I'd expect a coherent
approach toward division/modulo-on-zero as well; the verifier should prevent
program that _might_ do division-on-zero from loading in the first place.
(Maybe possible to achieve if we introduce something like SCALAR_OR_NULL
composed type, but that's definitely not easy)

Admittedly even if achievable, this is a radical approach that is not
backward compatible. If such check is implemented, programs that used to
load may now be rejected. (Usually new BPF verifier feature allows more BPF
program to pass the verifier, rather then the other way around)

So, I don't have a good proposal at the moment. The purpose to this email is
to point what I see as an issue out and hope to start a discussion.

1: Okay, I'm making this up a bit, strictly speaking the BPF foundation is
safe program (one of Alexei's talk) rather than preventing users from
shooting themselves in the foot.

[...]
