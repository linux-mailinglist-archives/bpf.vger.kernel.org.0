Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47B4D7B4D
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 08:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbiCNHLO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 03:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiCNHLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 03:11:14 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D89213F48
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 00:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1647241801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wra3wsjO+YdVr1bwhimzNP+FImp9i9ecroAvJoU1OSw=;
        b=fFYk4f9EZIEZR/vAw35rnk+XkZefpxKWgZdFOmgiqgcF4TS4+lFESSkxvN7ThFQElf1dd/
        lpf6+ZUwVxfiURrjCxy6SrgD326IkxcCgE8s23wxrG4+0ZvqxDFmSWnjq1z0iwPLJwjDZ3
        1i96rz2k/jBwd+OEeN0JZxOvsnFfFu8=
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur03lp2056.outbound.protection.outlook.com [104.47.10.56]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-ZxvmUEkjPfC34TdFgaOpgw-1; Mon, 14 Mar 2022 08:10:00 +0100
X-MC-Unique: ZxvmUEkjPfC34TdFgaOpgw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtbSC2tx9Z8nv85IuZGC5sUq5iRNq6/Fsvn1KrIXQu6hmW6PdmcxrfX0jprO/4+GDLKsi3OQLplQVIlPUbhtEf9vvMvgo90qiJnR1Zaq62PA+nFGDjbuJSkJ8Qpe8R75tDgm42PRU1JgNLqdV2AKHZ094Cdr+TMvCGO01q3QQTMGmQwri2wBBT+9FklxQ519X+egZc3OAJrNJaeVe8oVA9/LUwGqEHOkkvhhnWZ/u09JVDlDmVUbZb2KfDbQ1MWKKQd98YJcOO2bFO22yBDQzyAOJK4pVTDJIUfcA25LQ3G8ZuYtOra9u24+hoxQpzVHFGiTEXtuus3HBwpwrajy9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wra3wsjO+YdVr1bwhimzNP+FImp9i9ecroAvJoU1OSw=;
 b=aHr/ImgBxUtqy+pH6dsATkqi7FLlWFnETIHMe3U48/pPORymjlej8lKpBHNJlKVSM9P+e67ZYDJYRLWBhm3gDobhOn7yRx8w386cMZAe4lmeDoUrbNLGbHbhZNc77ii8Q7+YDF6bXKtncwKSQO8SzcVD+Iw0OuPolVBRKnXlGjZHj2OZlk69fybZgAlYaoyXXzjANpINjj/W9g0vhxChLeElsXOTLIKP19xwY7lt6X9L8Lav331MWPd959N1vsAr20jo8USYwxYXpAIPBQ4NVxYdXjPUOFr8t/FAS4dIN/xC+1kMV37oC6Gg7uc11jRSA+zIzWFSHsoEr8kyBTJ/EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM0PR04MB5873.eurprd04.prod.outlook.com (2603:10a6:208:123::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Mon, 14 Mar
 2022 07:09:59 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::3903:f9ce:3bb4:19e4]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::3903:f9ce:3bb4:19e4%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 07:09:59 +0000
Date:   Mon, 14 Mar 2022 15:09:53 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     bpf@vger.kernel.org, Omar Sandoval <osandov@osandov.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: Question: missing vmlinux BTF variable declarations
Message-ID: <Yi7qQW+GIz+iOdYZ@syu-laptop>
References: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <586a6288-704a-f7a7-b256-e18a675927df@oracle.com>
X-ClientProxiedBy: FR3P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::13) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc49473-e625-43b1-3887-08da0589a6c8
X-MS-TrafficTypeDiagnostic: AM0PR04MB5873:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB5873C7FD8670340624A5228BBF0F9@AM0PR04MB5873.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kEAe7BLGILXxn5Zr0fzGHtrO/5Dfa2FasERfIcIQhobwHB0vpjmuAHAL7iNaQtWrC0hwhCZdMU5BfM5PRbeRL83CDNY4np32WrqaVHvQurCXXGno/rbSi+Xr6JOomVyDk9KSuuECqBWl+3Eg8p2vrXMCIcVfta+eDLz/m6aCU+SaqM5nNq39vez2w+Mvz5dkEqhHydnTgmTf4sYggCZrQDU6qUpelb+HpZLg9fvLPk/5LxpuOVWxA3YiWXoIK+GeAezOY+s1tdpC/o09xkEUpqu9FL/bGgn53PtYXzUIfs5AOZxnBTlRcO+CHKlgLNHvxO+BDqPMrbriV0yVR3HpX+mS11Bqi2FHAvSTRT8nvFB0+TA7w4RpcmBA5sxE8XYr12i0gHwcnJ5K4RNxhbx+cmBJYQCGczxcc5rYxP+Yquji3TwrMSwv4v7HIWhJgHDGroeNlgWGNmpsdYsea+bGB3XIidJUo3Pw6x/sGrWj+4HZG1dLbNiSdrb0xN/qLToc9de5WwpUKSanf6gpqKbb9XQnKoeiwD0wEoYYIwjWUy66bhWJNBic8JMSUqFWlrRt00/XQ6AZ35Yr2rITeMhsl2WkN0IFDWcFqmr/P10HyppsBWuhkKJRpYp/5sLVM5kn3rjY/RKWYPtVl8g/XhgCeIDekMJUNH9k/xRzjiDNTNLTvj4ryUyYbkbM2cU3aNJpXXP23TW1EN1enHveJM7gz5KeqYXnku6NZ5FVZmfcGXP5WUXwfN+1RHctW6p9r64aJM3zr6D0sl7rhGxzQeS5YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6506007)(26005)(83380400001)(186003)(54906003)(5660300002)(6916009)(6666004)(86362001)(8936002)(2906002)(9686003)(6512007)(316002)(38100700002)(6486002)(508600001)(33716001)(66476007)(966005)(66946007)(66556008)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEpVQy9DSWJxS1h0Mjk0M2pDU3ViM0pjN1BGVUNNUkIyeHgzdmxQeHJRUVZB?=
 =?utf-8?B?NXQrcDRzSS9ZVTI2ZlJlb0pUQzd4TWVUWkFlS2ovZTVUVkdPUnFocnl3Qktw?=
 =?utf-8?B?bVhKdTFQcFRRVGl3RnVEbWJRbVlvMUJhQlFnUHp0dUZ1Y25PeThDZjFzblBq?=
 =?utf-8?B?dE1PMEJ1QlFlblp0S2FMdWJzbnByR0NNZUg1ZEptUDdkQ3VKTTJhVlVnYVRY?=
 =?utf-8?B?WExBRUNFSlNUZHh6UUNpZ2ljQk9pNWlOQW96YVI5cjBNLzJLV3lEaFV1a0FL?=
 =?utf-8?B?dXFSaXlrQkVXei9iVzFtZ1Bmc25uN0g5RGljNXpJZ3VEbU5OVnhMZHR0blJw?=
 =?utf-8?B?ZGtBWXBUakV4OWxEK3ZmN1QyMmk0c0J5OFZtOUxGUm9oRFV2Ym13aHl6blp1?=
 =?utf-8?B?VnU1MXhtQ1ZwWWMvaEtzYVB1ejl1QmFjdXNCcTJsZ2lSWmpyS0dTYjMxUXUz?=
 =?utf-8?B?WkxuNVRpbkRYanVsNGpqcU1uaExjMmNtZHNIWWdjeUdGUCtkbjl5dklqZzF3?=
 =?utf-8?B?eitaOXc5bHhaNGtwSExhOE1ISjg3dkt0TENIaG9nTDlhSHVlWlZGeGc0eGVG?=
 =?utf-8?B?clFpeUhTc2pJN0hBdC9UVU8zbjJ6NTJLcDVJazYzdUJpdUpJcjcvdVJyL3o1?=
 =?utf-8?B?VGpEd012NW8yb0JzWE0yTWZrOVFpdThIL0ZyanN3MytHSnFoTTBiN0NCZzFQ?=
 =?utf-8?B?dHBYZmc2SVV1ajZ6Ulo0aFUxblVLZUNrbWhkc1pGSTUvQUFna1dFaHpOSzV3?=
 =?utf-8?B?Wjk1cjFOaGtabGIwVFBLenpCb2dDOGh1Nk1LblEyOUJJQlJVUTluTGhZNlJK?=
 =?utf-8?B?WWNOZU9VM0FJbDFmQ2FibXlIZEdJbThTQWwyY3EybHZoWlVUbmxYQWtFdFpP?=
 =?utf-8?B?azk1TUc0aUZhWDJzcVFkWFI2b2kzbWpGK3gzb2RZTEJTc1FNZm9YZGgycWhq?=
 =?utf-8?B?NG1GZlE3ckY2cmUyRk5DaHE0UkVxN3IxUTVGbTV0bWdjNCsrSm1pK25PcU9B?=
 =?utf-8?B?ZkM3NnJLbFNUMWxHbEhSb3hxZGFqVXdaT09xOGFQRGI2Vk9nd2R3dzR3em9V?=
 =?utf-8?B?dXQwRVM5VmVKZ0hOQmtNcUtZM04wd2JTUVFBNEUwRWZJdGl6WlJDUFdQMUMx?=
 =?utf-8?B?TlZ1NXVTeVhpazVMbUxVTzBrYlZObVJ0UmNvTVpqbnlEUHBmdy9CbjlNbis3?=
 =?utf-8?B?cVFlbzRkUDlucnV5WUhqeG5KcmM0VDIzaFBFa2xXaUxNd3Q4WElncHBoSTNz?=
 =?utf-8?B?Um1IaUViYXVYbzFJZzlEWE9yRS82SjRtV3ArSnVER21yOGdjTXlvcjdiOVVZ?=
 =?utf-8?B?OUZZcW5Pc3hZYzhDSEs5Z2lWRVNCeTh2VlFQQ25wQ2x3blBITHowQjRrbzVM?=
 =?utf-8?B?ZTJxa0U1OE1lZ3dyUndPQmI1dFlZajJuYTVDaWhjVGtBL3ZiMVhxVmV5SEo4?=
 =?utf-8?B?d3MvaFNKN2JKMGlha1pSRWx0WmVtYXhJVFNVRXRYejZRRHRHQ1liaUtEcGpF?=
 =?utf-8?B?eGRYYVBaS1FGcXYvbVk3M1hVNHNwVE50OVlhdmR4MVFDeWFoNkpicmw1dU1Z?=
 =?utf-8?B?eThuQTJJcHl3VkxPL2VWdVgwelNvclZjS0ZHejBxMGhxTEltZk1qenRzM3kw?=
 =?utf-8?B?NEVvM1dwYW9UTzdLZkRSazAzeDdKdWUraDZSY01WYkMxQXF1Qzh2cS83OGtS?=
 =?utf-8?B?bWYrV3h3WTUzcFRPcVNmOVNIck9SM3hWbjNneEkxbUNHcDRiaEEwOVAvTm40?=
 =?utf-8?B?VlNiQlNnTVlGVFR4THd6T1B3RDFGZ3RzOXk0U3hFcjFzWk5SbjB4SS9ueEhR?=
 =?utf-8?B?MnFzcUxHd0NWOHFXQUpCOUloSGVVQkIzeTE4alU2QU5kU1NvblE2TWh2WWN0?=
 =?utf-8?B?T3BsQzdQVWpiQ3IwTk84dkZ6bkZzNHorRW4zQklDbGJ4dmpodExnaHc3T1hI?=
 =?utf-8?Q?UKzDeTYWZ9avOFTWJZOwQ0KWzCROzVcA?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc49473-e625-43b1-3887-08da0589a6c8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 07:09:59.4081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo4EisRza1SYDQrVo7vFe818ngJYlZxf+QAhl68nGkuAyJ6uWuWtB0KH1bBzWNPU/SwSucKb74C+Y7vqsOwPZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5873
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 09, 2022 at 03:20:47PM -0800, Stephen Brennan wrote:
> Hello everyone,
> 
> I've been recently learning about BTF with a keen interest in using it
> as a fallback source of debug information. On the face of it, Linux
> kernels these days have a lot of introspection information. BTF provides
> information about types. kallsyms provides information about symbol
> locations. ORC allows us to reliably unwind stack traces. So together,
> these could enable a debugger (either postmortem, or live) to do a lot
> without needing to read the (very large) DWARF debuginfo files. For
> example, we could format backtraces with function names, we could
> pretty-print global variables and data structures, etc. This is nice
> given that depending on your distro, it might be tough to get debuginfo,
> and it is quite large to download or install.
> 
> As I've worked toward this goal, I discovered that while the
> BTF_KIND_VAR exists [1], the BTF included in the core kernel only has
> declarations for percpu variables. This makes BTF much less useful for
> this (admittedly odd) use case. Without a way to bind a name found in
> kallsyms to its type, we can't interpret global variables. It looks like
> the restriction for percpu-only variables is baked into the pahole BTF
> encoder [2].
> 
> [1]: https://www.kernel.org/doc/html/latest/bpf/btf.html#btf-kind-var
> [2]: https://github.com/acmel/dwarves/blob/master/btf_encoder.c
> 
> I wonder what the BPF / BTF community's thoughts are on including more
> of these global variable declarations? Perhaps behind a
> CONFIG_DEBUG_INFO_BTF_ALL, like how kallsyms does it? I'm aware that
> each declaration costs at least 16 bytes of BTF records, plus the
> strings and any necessary type data. The string cost could be mitigated
> by allowing "name_off" to refer to the kallsyms offset for variable or
> function declaration. But the additional records could cost around 1MiB
> for common distribution configurations.
> 
> I know this isn't the designed use case for BTF, but I think it's very
> exciting.

I've been wondering about the same (possibility of using BTF for postmortem
debugging without debuginfo), though not to the extend that you've
researched.

I find the idea exciting as well, and quite useful for distros where the
kernel package changes quite often that the debuginfo package may be long
gone by the time a crash dump for such kernel is captured.

Shung-Hsi

> Thanks for your attention!
> Stephen

