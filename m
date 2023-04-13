Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662206E0A91
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDMJus (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 05:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDMJur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 05:50:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BBE5FF7;
        Thu, 13 Apr 2023 02:50:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGHfsIEF49baA6MuS0NTvuQeDvXaDYHspOoIwZQYQbeSy/piBfqzmQLh7vRe4iKlqwTkR0UoDYgSBnRyuPc24oACHXz7v7hqUNgcKb0r65I635lt3egMd8KHlE8ZLIeTkLMrTGoBGtJmn9aZhLTxYAOxmqKyUeWdlHiNO3htTQmEZQR3e7H/3QZd7DqFyBZWCaAAFW1/OKqsaue0fbd8OTzLtuBr3EX706wQU+cx7XaoCE+0jildMzByB6uSEcej+cpOL6TDFU1KR+IoCSulI+Yw0oOK5iXRMipnq9/dpAtrLUlkCy945KZTdm0b2EkNShVAsVib0FON6NYaWpPIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOiR/bHm5rCtjqUVGFh9InUnBTwxNcPvCobKkRciI0A=;
 b=NQX0EK46Iw8MzOTgegy49wgDD5yUD91ugd4Fh67v5HmQsG9n43aZ/e0Zux2A4f2oXXsqC8A4B6rpyFduJ7kWjkch/S7TqICBFf7DoBJ9izndKeVReKDvXSlP6KFVLwNIUCnyxTDnNIlcLC/0o/J+urBD3jyLIGlI9rH/sUbBvTuBzFPfGZFTR5aJ7dMkRjSItO5oUl6Yo08x2hZryR7OKjmZi8/fcQC8TMzczaDO3qtr83szROW1BHkeoeYNdF3v/B1obbi7lPYPht/dlmA3fzDhhtVAIJaQnB4hoPXBk6qsaFBfQL9hLNHNH3UFBnLakemNN/Z9pRffT0OA/EO49Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOiR/bHm5rCtjqUVGFh9InUnBTwxNcPvCobKkRciI0A=;
 b=DpnGBYPvNGMICe4q10BjXHvUk+/6etjiUWBFAL3i4UNoEZsri+o5OAJKjbRqKu1tXvpf4kJrvcsUbgLr+7x9XLVlbytG3hlZM+y9Gtm6yVqYkliCcQsfpEAH0VfOInNEb7tsG6uI5NcQmqZyUlv88fDvzZhtCbxInM26NrXyHxyuhwdY5CEH3pcIuzGw7qqSrykBHZX/BCGNMOBkpi5QA5a6NJHk6EMmqfZJSndokJUIbAxGqKfaQLTFN/UYlWadgcAc65Anb2v7CA6l6qvxPR9Dkvjx5Y7DJYzM8xtVqAcvC6i3ksGlJbBE0t2iYfErl9XpsRSIu8raSY+yF9kH0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by GV1PR04MB9182.eurprd04.prod.outlook.com (2603:10a6:150:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:50:39 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2%2]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:50:39 +0000
Date:   Thu, 13 Apr 2023 17:50:24 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Michal Suchanek <msuchanek@suse.de>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZDfQYHJyJOrR5pcB@syu-laptop>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZDfKBPXDQxH8HeX9@syu-laptop>
X-ClientProxiedBy: TYCP286CA0166.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::17) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|GV1PR04MB9182:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c87ec0-a815-4adf-d1fb-08db3c04898a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVaDelO5KhPBxql9EUxjAc20W5yIz+BNOnxJfi+fY2jhe9BSfIwukc4+okxnQ03qBTetTPhnILGavsN/b5xz2r+q5xir+xzTg21fHWIZIH+EREADI9PsLZ1SnlERYijCTtsWNmQEUKkCXCTpWGal8SZwECzL5Z9nkFOZfSwHrgS69X3ClXZJ/vagRgKHdPgZo6fZj2679lu3PBXx7uGPP6JTMOw9LhpjPyqrcuSCDzTUgWhwkzLm3ruEN8bi1i0tZwSSycJn5moXxK4QHmGlagxOtgXK7TABFU8dsf6KfnOUNDcopJ/i/W+1wCndsafEQIX3TZfnPliorqghIVfQ9LdM03ca8z16/ID2Lyn8dpcdRr8nlJYJPjeketVXGjUSILvzgNb7ehE3wopgoPEeGgtVsWZ+AdzN4K5+qTV0w9irGb/GYojsG8HutUmfc+TzEWSoZD+jG8+W4MlG42a1sLQVb7l2E7t7fMUwYe7Mo70VS37x5okXp9LehTMwfIHmBieQ+nz6A9hUttO5Kx100lEnQ/SwPmM42hYe7peWepcepjiHdQPxd7vbZ06v04s5F0cokGvVorMyrK2VJTnXIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199021)(6666004)(6486002)(966005)(66476007)(66556008)(66946007)(4326008)(2906002)(7416002)(33716001)(86362001)(41300700001)(5660300002)(8676002)(8936002)(316002)(38100700002)(478600001)(54906003)(9686003)(6512007)(6506007)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUVoaVN6OXFTL05zSWwxWkdLYnJ6Q3l4WFlYNldUSXpweHd4ZFZ4M0FocTYx?=
 =?utf-8?B?WFlsUjY1Y0s1eGRaaFdhYkhsWXk3TlVFYUFGZTBJMEcxenFiakZKZlh5RER0?=
 =?utf-8?B?N0liTlduVUNhREVtR0VEaEUrL0hZSFVqdk9SUHQwQWY2bzA5dWptaXhzQ3hQ?=
 =?utf-8?B?VVVuUTdxbGRuSldsYXIwNk9FMXNEWjFkcisxR2pEREhQNytvcDRoem9jcTA0?=
 =?utf-8?B?Q0NSN3VHKy91VUFDaUVpN09Vb3Juc2IzdHh0V3dMTGVjWG5TNXJEaHBKanVE?=
 =?utf-8?B?NXlpZTJEQklZOFNYaXZpU21CSEVxMHl5MjUwRHlERGZPcWpuWWl5MUdDNVln?=
 =?utf-8?B?QXhYckREUlNBNGVGUm5wcDF5YXZuam5YTWVxYnRVNjlqemdyMW1rRmJidFZu?=
 =?utf-8?B?VGE5VzJPcUJNSGVDZ2gyaHI4b1hCM0NZUGdqTjBZMWVTTlZwaFpQRmZBNXdy?=
 =?utf-8?B?MllBcC8rNWZoc0lYZjErb0ZPelhuck9Oc3FEMzd3b0xqeFNTTHVLYzkwY21x?=
 =?utf-8?B?UmFMTXpJUkxzQnJsaGpNak43eTlaQ01ieS9FKzk0ajl6UG1vYlZXMVdOeWFU?=
 =?utf-8?B?a2g4eE0xRXl0UStYc3p1NGRodk5peGxGdnpwc2Zkc1VpNGhzSmxlNzEvaVgv?=
 =?utf-8?B?RHVQL0VKYTJ5Q3pYNXB3M09scWxXUkp1UldKS2pra1p6OXJnSzZXQnd3Vjgv?=
 =?utf-8?B?dlRWMGxkbXowdUNyR0h3NlJuT0lFbnl6aVBQZ3BYbWRnREhPU3R3cytINllZ?=
 =?utf-8?B?bnArTWdvbUhLQzhIYzdPWlEwY0gybkNRQTloYTQvN1RXTmVvREVpYmJVY0tP?=
 =?utf-8?B?UDB3S2w5ditMSWlwY1lKMklJNXFZYXJNeWlZamhTUlBPVG9RaDh0M25uczJN?=
 =?utf-8?B?VTlPdmRjcDJpbjB0RERSNjZZNFVxN3lrS0dGUVpZVHZVb1E1WGRlNVBFV3FH?=
 =?utf-8?B?WFl4ZFkxY280ZDhlWndhbDNkZ0EzdFFEem9nUzVFbUFDYUhqZFVWY3pCaGUx?=
 =?utf-8?B?RFRkNUMrRm1CWUswRWFiSGFTaFVJZG9xZ3JxakxSUnVWNDBuTVZnUGFpaGVG?=
 =?utf-8?B?VUxJaWJScHZoV0ZYakEyZDM1VGVRODhXaHRBek10dnZqb250Mm9CNDBnV29B?=
 =?utf-8?B?WTdQZ3VHL0FJaWxaeWpHSWtHVjVrVVF1Ym1BazZFTWlvSXliWlN1Zm1jTFFE?=
 =?utf-8?B?bUFFNXppeXQvdU9FK2VkSTJwVE9nb0VmbGJnRnNMR3gzT3A1YXZPSUR3ZzdC?=
 =?utf-8?B?OHJKYW5LRDRGR05aZW16M1FWT1lwTkJwd2xXZkRvaFJUa3BnMVlLeEpXY3Zm?=
 =?utf-8?B?K2dEVjdOUU9JMHd0N254N1RYVG4wSlZkSUtUOFBGNVM5bEFKN3RtVGl6NzEy?=
 =?utf-8?B?YzV2cTZoNUxZN0x2b0M1OHZZQk1DUVVvYmc0b0RyblV4MHlYTGJtTG81THFD?=
 =?utf-8?B?c2hrYjhRbzVaMmpiT21SMWFPZzlabnAxdWdERERZaXdib3R4NUtIL3BHNnRK?=
 =?utf-8?B?L0QwV251THdxN1FQSit2TXpwbTYzUDllSmNWMmlpa2xQVWVud3VveWpkOGcy?=
 =?utf-8?B?UFpWeWhYR2J0NndxTWMzc1I5dUFWTUhWU2dYSllnVHM4Q3VoWWNaMHlSUHlV?=
 =?utf-8?B?b3VUcFdORHJyVHhLRWZVRXZxK0pkcnUvVmNaemsxRlFQemhzamp3TzVNdEty?=
 =?utf-8?B?OFlobUN3cGdvMnFYVW0vNlY1NXNkbEJPUVM5MWI1NE8wNlRrZjhmMmFqNVhk?=
 =?utf-8?B?QThVcGYyeEM2UW9EZFROMXFiTFpDcEVFU1hUbE1CZkJyc0VMdHp4QWF2OW5T?=
 =?utf-8?B?bEdka0kzUWJWVURsYzFKZU5MNUkwMCt3V2lBMnVlVE9xb0ZhSHZ3RjVuOUxB?=
 =?utf-8?B?OGs5QThnSUlTbzFzWlMxREc2bFNBdUROd0FLbUxkUkF1elZBczVoYzc4WUdW?=
 =?utf-8?B?TWNqejVqdjh6MTVzYW81MTY4MUpHRTIxaFRlbE1OT0Y0bFF5Q2Y3RVdmd3cw?=
 =?utf-8?B?SUN4eTdza3lxMHJYOEl3VEViYjM4K2ZKLzJvUE83bXZHM3NnNXM4MERFeHpE?=
 =?utf-8?B?QWVQNEVLbmluSzZraC9JRXQvMTR2TDgzSE1halV0bDYxVmxKY052NjhocFhO?=
 =?utf-8?Q?Ll1CkFr2fbcsHzBECXzWzNaC+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c87ec0-a815-4adf-d1fb-08db3c04898a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:50:38.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZriiN1rc9WL6aLAICeLygSjr4WCvG5lCN+dN9F6ZPRag1ISTCLCykL4KpU7A/J6345V46yYGdL0ICGBVpi5l/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 13, 2023 at 05:23:16PM +0800, Shung-Hsi Yu wrote:
> Hi, 
> 
> I'm considering switch to bpftool's mirror on GitHub for packaging (instead
> of using the source found in kernel), but realize that it should goes
> hand-in-hand with how libbpf is packaged, which eventually leads these
> questions:
> 
>   What is the suggested approach for packaging bpftool and libbpf?
>   Which source is preferred, GitHub or kernel?

An off-topic, yet somewhat related question that I also tried to figure out
is "why the GitHub mirror for libbpf and bpftool exist at the first place?".
It is a non-trivial amount of work for the maintainers after all.

For libbpf, the main uses case for GitHub seem to be for it to be used as
submodule for other projects (e.g. pahole[1]), and that alone seem to suffice.

For bpftool the reason seems to be less clear[2]. From what I can tell right
now its mainly use for CI (this applies to libbpf as well), which is
definitely useful.

But I wonder whether packaging one of the motives to create the mirrors
initially? Can't seem to find anything in this regard.


1: https://github.com/acmel/dwarves/tree/master/lib
2: https://lore.kernel.org/bpf/CAEf4BzZ+0XpH_zJ0P78vjzmFAH3kGZ21w3-LcSEG=B=+ZQWJ=w@mail.gmail.com/

> [snip]
