Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4986E77D3
	for <lists+bpf@lfdr.de>; Wed, 19 Apr 2023 12:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjDSKzY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 06:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjDSKzS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 06:55:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2045.outbound.protection.outlook.com [40.107.249.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EBD13C32;
        Wed, 19 Apr 2023 03:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KklcQbJI6OUrxDuUbCkiQNP69sqKVuvMjPjRfDituPsP7kdKey5qvQekpVGWfpcJRDvFZu8ozIdyBUoh7BvjK2toe4vTx9Zw4dy3Y6WCp86CKFZdVwjrD3eNeNAfD4DQ0+A6Rno7X8yP2HPF8J6ODLCdkIzCVph4USvLqbuUDpLfa55A7iuvGsgt6Xv0jtJCKuutMyRhAwW4XDVxSRwTRdrvdM/yEa9twru2IZH/lNPZS/JrnXtS9KTJmTCOOaj4lUdSiBoaZJ13uclAc/yVBVPDvTPHUMtGY8Aocyr/2ig501B6Vnuw1ogiruQC9RvQRGvLOawMeGSwtZFD+HVK1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vaeXb3vdDKmXEKS+yDhiRxeTm06Q+y29UEBbsWxyffk=;
 b=kInIcsiuBwRVGr8oKy7sYwWN+z7ZnZRd/pO+VqDfrZ17Pqy2TT2bjkVS401uvbD7ySV8nERjq8SJAQSiWoIsVllHtHgRzJybHQ4l5B/G9ZnEt/tAehe6Hz0JhHneRsiq6U7MW41NCIo4BHEl1STCHKchsAITtIfBL5iIvIhBPRVwO0dmw9CIuOjIQS+6MiT34SXyLzhHiXgVoBPFo7BdLrafTk8Mf4SwIrkr/jofzBSV3dIAUHxHTtvWF+DXvpFP9AHej6HG+bu8MJAa1nbGVtbdnJV61q7T2YVn1WtxIb+U88ZV9ZoyYroqAdy96V7o2haL6ddkwmBPsKBgTEQokQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vaeXb3vdDKmXEKS+yDhiRxeTm06Q+y29UEBbsWxyffk=;
 b=z2CzmDglT1850DI7Kc92nipdq4RHAlqlXwTsN/ok65rS+Lb7x6R/qsrfju/odpFKqAC8gavUzCFBGZVGplL+27ZYszOKXDOAmO8C4XGvkuBij0D7QA8BN7d5xaYgSG0QISEGChpgNKhkWbUcUfGntD+oU6TyGQaxH8sd5GexcvFZ97kYLOwRN5k+ORd3kgA/96mcVvA0tB9u86Yt8EqZ5iLRNKSmu8lOjkJwRZ1JK92J1a/d5h1+ZBb7DzVwGJKw2plyBwZ/QaA2PYbstXoWfBq3p1Iw3cFzs7IeV6puJKQVGNmLGNhd3p4oJhgUSxyzw/IBGyT1gDKVg5ZTy/EqGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 10:54:56 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2%2]) with mapi id 15.20.6298.045; Wed, 19 Apr 2023
 10:54:56 +0000
Date:   Wed, 19 Apr 2023 18:54:40 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Quentin Monnet <quentin@isovalent.com>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZD/IcBvVxtFtOhUC@syu-laptop.lan>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <87leiw11yz.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87leiw11yz.fsf@toke.dk>
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAWPR04MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a87129f-b159-43b8-2832-08db40c482f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ruVQuflHGZKAu9WeDKvTGoDexR2nmdaqzA4YFwWdlKWiZN5HnSgudQWP14EKe9Bl6NueiSNrPljCNvZBUP351/1lfiAIdYLayV0m4oneXslMth4OetIbc7Bs4A+q6LCqScD/NZzK+hP2BnDY1AVLp2X1ll2615jhJRJsTLRWy9QeVWSVuEvW2myh0XTxeqyDWb6PNR70uMfndPODAK5QmUxH7+zYlndKJyNDYPP22BX9OY4Z4NVavtfcTu+qhq9WcaROn53HtTZLOsvnMn8nYDSxzuAqh++gKP4p4HD5CQDCsuWvswwoJrKCscKGUzhFsdIE50lFABujzMsygANgyT1POuEOQRKkH2iu6AYyxwDP4n2yVzw/7av3HNRcnalf5o7vjd+4uQajrOjJ+ubzoAD3dw/YnFGKIjrNTi3mrOWiXw8q26axh3mZrdY1DcbdvW5Kog+OedzCnlFgh5jspu5L4r7PMYedwsRN7Tkg+gnGLR9Ty/COkSzA/1k3mY9ak29ASqvZp9+3Q9esxCVTg9mhGzTPEZCyJUPZYQL+OPQyS1Fw0ymhYAjWfrofNAQ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199021)(4326008)(110136005)(66946007)(54906003)(316002)(66476007)(66556008)(478600001)(6666004)(6486002)(8676002)(5660300002)(41300700001)(2906002)(186003)(36756003)(8936002)(7416002)(86362001)(6506007)(6512007)(38100700002)(26005)(9686003)(83380400001)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjFLYkZWVEkrWFY1V0Y2cVAvZFB0UWxYbjQ2TnQ2dzdydEJobnNIanJwQmVk?=
 =?utf-8?B?NHNtL1QyS2wvclFRZVEwd3M5c3VKSTEwT2pkY3FTK2FyQndOZi9uRWZKdEsr?=
 =?utf-8?B?QmkrSzVDZmx3VVl5WTVUTUUvTE5nMGc2S0JSSWwvVjdkcVo4ZHFyMms1Z2xx?=
 =?utf-8?B?YlRyeml6Vkt3VzBPNFkwWjNxMXVDWEl4QWhERGo1aGNsS1pvUGo1dzBxcGVt?=
 =?utf-8?B?Z0F0dEVwTE1uOHAvRUcyTFJGd2VnZlJ5N3NVbWZiQVV4Qi9rZjkwTGMwYjAw?=
 =?utf-8?B?RXV2ZlZjOEs1bHdSK0dZak5yMVNxdTZDWlJkMTdlWllrVDMzL2tlNnBvNTNs?=
 =?utf-8?B?eGdEYlgxRVIwdlpFYU1OdGV1a2dHdkJic0VaeGxyM1NWQ1J1UFpwY1N5TXFR?=
 =?utf-8?B?UDhxTEFkUFJoblJBVnpkVFErTmFhaW9TMytYWUhYcWZndUtJM004Q1lMdmky?=
 =?utf-8?B?a3pZeWlMYlkxY0d6Ly84NnpyeGlKR2JzQUJrSUJmbzEzeCtieVdrZzZMUldN?=
 =?utf-8?B?ZWUrbyt4N2dEWmJlM2lXM2VJbWVoTW5LdW4zSkdiRzNMV3lrd1o2ZTM1bmRu?=
 =?utf-8?B?ZHg2emp0S3NUWkcveXlXUTMyN2hmaGY0UXVQUzZOVGF5S3NlZFJpZ3A2Tkhh?=
 =?utf-8?B?Ti9nRzNiTDNBUVVXVFV2dXdXV3dVVFhGWWVBMWZveUVvT2czR0xITWxLSitS?=
 =?utf-8?B?RFFGVUc5cU11YVc5ODA5M2ZaWXloeGJTTzJJN2ZaSTFIbVpkT2lmSVhmOGFR?=
 =?utf-8?B?MFovU3ZnOEhXRHVwc0xKbVdQU0NjYVYwRHNvM21CQXhROTI0d0ZDZHFuYWta?=
 =?utf-8?B?YVVtSXpDTG9DR1ZEdWMyLzk3SmhtVDNmb1RSY2NyanlUY1pMYStqVFNmclBU?=
 =?utf-8?B?RDlaTDJJUlpDUDR0V2duVnNSU2NaQS8yZ2x5SldLYWs1MGpKVmtvNlhiNW9C?=
 =?utf-8?B?dTY0aVNSRnJ6bmdOUWdLVDVoSXE2SkVybjR3QVp1SHBsYVR2MGYraXlDMTR3?=
 =?utf-8?B?T0ExNkV4ekJ1SWxPeHprMFpxU3JIaGE5ajVzZzd5clovemZsT01IQTdiVmhL?=
 =?utf-8?B?SjZTYzBidWt1Vjk0NGRtUDJGWXdicmZjQVJrOHlOdUsxRVgvMCt3NmhHSTZL?=
 =?utf-8?B?eGNXcGlGa2NoelRqczhMbXVaS1AxSWNVNmxNbk1VTW1iM0J4TmVvUC8wSmlD?=
 =?utf-8?B?ckxGOEFOYWxVNjl2ZVJDckxiMUpvY3Mvd3BLV3lIYnNuRXZBZlExNnVNNXRo?=
 =?utf-8?B?bzdHYWlwWDdXV2kzZHdncHFUdkIrV204R0R2UlVqdG9HNDZtSG1Nd2ZJb21k?=
 =?utf-8?B?aGNESlh3RkFFVXEyblBIcnE5UTFaU1lTU0hSZllqTkZxUWtOZlk3MUpaYzVU?=
 =?utf-8?B?VnZXYnVYLy9OWGdhTFlEa2dWd1E1NUppaHZKeHcvWnJvODJ4R3hKS3BYbmJ0?=
 =?utf-8?B?cnVRWmdkNDFwa2FBZUZzTkY5eFdmSmVyOE5sQ05rZFJ0ZUhRV0llRjJvblM3?=
 =?utf-8?B?Z1VVcmxOdnhZRVFyS0tqcVJ0TytlM1lGejNkenFucWdhMnZ6K3VXYlN5N1Ey?=
 =?utf-8?B?UWlnM1FOdHRrYkZjY3JvRXdUN0FoVkYrMUNKTHROM2wyZ0IwTzVGTGttZ2Rp?=
 =?utf-8?B?L2tONkJCZTlvd1ZUUjdjT3dlQWtuYlREVXYxSEY4UVI1YnJjN2RDdGxRd1Nw?=
 =?utf-8?B?cVJRZ0hCNWhCYisvZm45QnYyRzlnQ3F1U00rcW1MMmN5ZTVMalFHTkZwcUpn?=
 =?utf-8?B?Q1VJNlpCb0tnNU1EaExUdlc5M1hXbzRIaW50WGh6SzhDSUZUdWZGbXpDa05N?=
 =?utf-8?B?SUx2akZyMWNBODNKWFFxdWlZTmFLOXpacUZDVmxXbU9hZEtTdk44VU5UaDE0?=
 =?utf-8?B?K29HS2dSdk81MXh6RDVwSzBQK0thS202ODNDd1V0dDUzZ3A5ektrWXZYbkZX?=
 =?utf-8?B?S3laKzJNY3RNMkRpVmpJODNjYmN0RGw0Yk1ZWVZ0NUEzeFVQQmFNa09STXJR?=
 =?utf-8?B?K2tXa2Mwbzh6dHZNcjkvY3hMWXdTOHhsbHlsUW9NQW1zN1JDQjdlN1F6OWVa?=
 =?utf-8?B?emkxVzhENHBjdUdsa3Q2aHRyYVBhTzNrcVJvWmNkSDc4MFBmU0xEVndxaWtw?=
 =?utf-8?Q?syGTSHovgNKd+QA2HAYOd4Bj8?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a87129f-b159-43b8-2832-08db40c482f2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 10:54:55.9945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4N6US37hji4OqKjdQom6g4ynytt6eMicM4RWx0NH+LNFKLYq96uf2NoDgvNIh3mq7QhPM9grKJZZ6LNaHQtQiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for sharing! I though I'd expands on what you said to draw a clearer
picture of the challenges.

On Thu, Apr 13, 2023 at 01:00:20PM +0200, Toke Høiland-Jørgensen wrote:
> Shung-Hsi Yu <shung-hsi.yu@suse.com> writes:
> 
> > A side note: if we want all userspace visible libbpf to have a coherent
> > version, perf needs to use the shared libbpf library as well (either
> > autodetected or forced with LIBBPF_DYNAMIC=1 like Fedora[4]). But having to
> > backport patches to kernel source to keep up with userspace package (libbpf)
> > changes could be a pain.

Here some more context for completeness. Kernel source changes are published
at a much slower pace than userspace. When an application in the kernel
source (e.g. perf) depends on the userspace library, it's kind of like
trying to catchup a car on a bike, which is doable, as evident by the
plethora of userspace libraries perf already depends on. While I don't
having experience maintaining perf, judging by tools/perf/Makefile.config
that does not seem like an easy feat.

For perf to use libbpf in kernel would mean that it's just depending on
something that moves at the same pace.

That said, maybe perf won't need additional backport to keep up with libbpf
as long as we keep it within that same major version (and disable
deprecation warning)? @Andrii

Now that We've got pass libbpf 1.0 it seems like a good time to reconsider.

> So basically, this here is the reason we're building libbpf from the
> kernel tree for the RHEL package: If we use the github version we'd need
> to juggle two different versions of libbpf, one for the in-kernel-tree
> users (perf as you mention, but also the BPF selftests), and one for the
> userspace packages. Also, having libbpf in the kernel tree means we can
> just backport patches to it along with the BPF-related kernel patches
> (we do quite extensive BPF backports for each RHEL version).

> Finally, building from the kernel tree means we can use the existing
> kernel-related procedures for any out of order hotfixes (since AFAIK none
> of the github repositories have any concept of stable branches that
> receive fixes).

+1

Got something similar in place as well and being able to stick with existing
procedure is appealing. 

> YMMV of course, but figured I'd share our reasoning. To be clear,
> building from the kernel tree is not without its own pain points (mostly
> related to how the build scripts are structured for our kernel builds).
> We've discussed moving to the github version of libbpf multiple times,
> but every time we've concluded that it would be more, not less, painful
> than having the kernel tree be the single source of truth.

We package maintainer are certainly quite hard to please :)

Just having an individual package easy to work with is not enough, we want
it to be easier for most packages before jumping on the bandwagon, which is
why this email ended up talking about perf despite it started as a
discussion on packaging libbpf and bpftool.

I suppose the mileage depends on the build system & scripts in use and how
much backporting is done; the more kernel backporting (along with more
established processes in place), the more painful it'd be to move to the
GitHub version. My gut feeling is that SLES do less backporting compared to
RHEL when it comes to BPF, and that probably placed us closer to the middle
ground.

Thanks,
Shung-Hsi

> -Toke
> 
