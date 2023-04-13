Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32036E0A19
	for <lists+bpf@lfdr.de>; Thu, 13 Apr 2023 11:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDMJXv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDMJXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 05:23:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625D493C0;
        Thu, 13 Apr 2023 02:23:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClMAU3hDp8aedxn950dFiOPJ6griTll7sbfdRoq/zIL9LP4Ey+aOHU3tRyV5S5lVXYpDAXclPhZ6aybnJbtsDAPTN/OVZIDoy0KjF6BPCR5oNT0ablEiFFNrDeTl/CirDlc2TQsXQ5xJ/K78sq4q2q1oJpBztXrWxvHDd/yyg69ixeKzt7NSbTFs33BGJVEfHU3NUCQJiGSkGedCcv0VRGoe++b0H07pDrjvSGd9doqY59GQ6U+vu4suI41UCGAKYVB0ojPZcaPF7W6tfnxafu/zezEw+aFpaZLlAG2i2LD+0fFK73fznDHKardK2QA+SNm3GnVfgnhgjetkwEuWEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoVPguAxplQbgRiPWiEPqhLSSirwDWuqPJEzctS89x8=;
 b=UtIynZrjkAlUPnh+dPixWRrhuBspy5eXMj2J1hmCkVGqmnsFDhihqso/oth7WGaeghsQ1AXgy5yV/SpJh5LoRwPRnK+xNEp6d5nCHTe+QeM9ke2+gbWMSqWPo+/A3DbSRZ4U4PgjPH1UO/1FJ2Z3VkfRGUX1pryBZxQoo0617KkcpZzsOBvov2H53lLVQmo7cD5UfNqqi443nKhoxcxbo/EXudRIDAlV0oqc+UleJ+usOhHF4Ju81U+Eyn6hmvnvdb/PJ/JUcNMDaON+42h3DbfnxMpdDHpSzAL6/fSjSwaDwJZOiGnJnrVoacgYzbayK15IXj7NIlfjZ+zLZtwujA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoVPguAxplQbgRiPWiEPqhLSSirwDWuqPJEzctS89x8=;
 b=lD/T1jP4N1uUnr+A5KIhwYDOenvUv6zlGhunyZmfYbSCoqXs2tBjpTU9EW+amM/+84bgSIu0KeYs4Ge77eZPpVZ+m2RM71b6ItnKjUQaI/pmcBx5XKYltE9xLH2NsR4X+ByYjPrqeo6N9hMbAAfgrXPkCC3LL1Ix2RaHhYViodyVpcNI/O+pHoNL9F7Bq7vpsW4SMW7pXqpBD2ArhnDfILyeip9Ia/Et5pWofG8eKR2stUpqxOzBFFuvFa2BGWvt9/VrKSMOlz2t1eoOEvA5hXXAbx0gZHWAjemHY1NLyrQwPHxfmgE0RV7z4HwDjtAVEqB2aBl8XkcTKpRaEempZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DBBPR04MB7563.eurprd04.prod.outlook.com (2603:10a6:10:206::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:23:42 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::e4c4:247e:4a08:7ed2%2]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 09:23:41 +0000
Date:   Thu, 13 Apr 2023 17:23:16 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
Subject: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZDfKBPXDQxH8HeX9@syu-laptop>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:404:15::18) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DBBPR04MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b2e2b4-719f-4769-74ab-08db3c00c588
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rop7qUx7GNSYhvCn+Zvyz+eaYctGaAhLg23Jbudg1+ruqdWbLL2cikUqY13KgQjsATnnfewLAQjahSWXK5VKBUJs5PNOBl/t8TY0fkIy7A4Mhg5Yik1HAyTz0g9PBNPVfj7G2s4aiBskYcrKklD2fiZe7ssva638MeansnbLEPR2y4SA86AIZT9uH/P/Yi1N/UFIB+T0G0GoSsGmC+MQ1euUjipXfW9dOGkNRT0RXlIkFVcx6pidS1fulaC/UoqniWuI3Dnfuqa1bgt+VG+65UvYpbiIw392GKDAARF83Ai49gfnmfNtj9YPFaJgcHkcGqtDpauapma53qdt1JfAiRwajyaAAXF2pQeauD+JTWnnBsGtHeOORSdYNQ0bQ7VHcFJGAfdY6ih03Qr0LyYUz6nEmUBfHM8DsY/c5H8QHi1GvSC2kkCk18Vbdfj1b5NbF8vfcOtJO/P63j4ez1kL5CeBiHjDxiIWF/SzRqXIboQ6ZZJQKMd7UpwgX2s8EsFOYTPlv+WrUDrSfmZwKZhKN47NjXfY/s0FX+rirrF/NwGRYHhuyz+nXajXNtCg/XUjwnb6Q86BK/qqpJ2dYKsNCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(346002)(396003)(136003)(366004)(451199021)(83380400001)(86362001)(26005)(6512007)(6506007)(9686003)(186003)(6486002)(6666004)(966005)(478600001)(54906003)(38100700002)(316002)(4326008)(41300700001)(33716001)(2906002)(5660300002)(7416002)(8676002)(8936002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0tCMHRCWm9TUUpFQlJsOHNwM3lyMEtHTURlbG04YnJ5NDJQeDVuMTBqWWpu?=
 =?utf-8?B?NkVTcm1xcG43OHo5K2ZSYkhQVnd0NUtObjBCNGdkdVRGemFiODI3SVdHRFc1?=
 =?utf-8?B?TkxlZ29iUXhmaFN0MjZZdHNjMG1EdnBrMkxLZVlvNUhRNkZaMWtYZVRaOEU2?=
 =?utf-8?B?QjdLam96amw4WExIR2E4MzdwZU1HZ29DajJ0R0JkQTh6R0FyL2RiVUpQTkFl?=
 =?utf-8?B?WVlzemVZWW85WmsrcHZzd1o2ekl2cUZDbFhBMUJheVZtTW5tcTEzVUh6aE9k?=
 =?utf-8?B?VlJmQm54Q1EyekViZy9TQUtOOXhHWXM0emswRTZjWWl6Y2dVOEpHc0ptNzh1?=
 =?utf-8?B?eCsrUDJDREtYcVpDWlVCUXA4QkFsa3d1WXNjQUZ1enJxN2VGb0JQSHNwbkVj?=
 =?utf-8?B?ZDdFYjIwSVVaOFp0emJHVjdIdG8yQTlVSXdOU3JyQjN5S0ZmeE9BWGpibkFW?=
 =?utf-8?B?eFdPNldEb21kdWV0V2FybUJJNitYbE93MkFzalZRMVROcjgrdVI5OXR4TzJv?=
 =?utf-8?B?bDY2TU41VE0zRmhRc0ZDZmZlakhhMFY4NjZEVG5DdTRNSzFzdmxGZm1IbG5u?=
 =?utf-8?B?M2pVaEJhb2lPVGJGRnU0TmtselgrNjBsLzQwb3ZEZW5JYnpaMmdQQVhOMlhu?=
 =?utf-8?B?TTBJdjZnZVZZQVh1eUNjVkpKTGF1ZytoTUU0NThtbVZvNFM2Lzd4UE9LOGh6?=
 =?utf-8?B?OEV4dHhHNlIvVTZMYnNNWXkxS2JrUnRPUWlLSFpEcE5zdWFXMERrK3Q2NWNx?=
 =?utf-8?B?WGhBV2xVWmlOYUVwd1FIVldSNXFrQUxtUDFEZzRpbjhuQWRqZzBCcEVSWmZT?=
 =?utf-8?B?dlV2Y09UVk9DcVliNlZhTnBSeldlUmNLU1BCZXBHTVprZmdoQXJFa05RckJI?=
 =?utf-8?B?Z0tjK1ZZanhPdmZHUGhZWDYySmpzbFdtcnFYc2ZpYXdOaTFLRkdpTkdlQllm?=
 =?utf-8?B?UHB1b0dibWVWb2FNcjhEb2YyaDZuY1dWL1VDTmVhcXVuNm55eFQ5ZG5OMWhP?=
 =?utf-8?B?NjJvaFVmZ2lFZHloclhkb1hjVVdONDZhcGhJYm8vYzlLSWYxTStFUUM2UlpN?=
 =?utf-8?B?VnljUXlwWnROY2JWUWloc1ZBM1FEOWJLaTErZ091VXN2VkI4cWo0bk55RllK?=
 =?utf-8?B?eUdaZEZ6UFo4aFMvTzVxL1VGRGIrcmZIazU0Q2tzTXF0d01qRWVJekZCN2NE?=
 =?utf-8?B?UjFyaGdJcjZReDNNY0w1a0R4dy9EbTdHOXpOREZTTjFwemZxNkdtUGlrK2Fw?=
 =?utf-8?B?UnR4eEZtWGdhZXM1OUFWay8zSDBMV2dHZEcreHBDV3FvNXJWekpxYkU0VE9k?=
 =?utf-8?B?elN0VTQ5bWN3UWsydU9pc1R4U3Bia1lkaWdES3ZkYUVYY2dnSjQ3Y3hiOHNY?=
 =?utf-8?B?aVBmN1dBanFnL1laSUQrY3A0KzZ3bzNFK2lZRlhFdTBSSE12dXNvenVPRW91?=
 =?utf-8?B?YnRnSXBXdFVqeHZqbHQrZCtNQmhhMUpvNTR6cXVJeUZCT3dmVVBuZDNKRUZO?=
 =?utf-8?B?amZxbUs4QjdSQVc4a2pjYmltVmFtM2s4azBwTVZiSzVWK09DTmNyNVBpUVow?=
 =?utf-8?B?dGc1NlV4US9yY05Gd1gvbWs4amxZOEF6NDBNU1pFdS8xbWNBMEtGME9wOEhD?=
 =?utf-8?B?SHExemdzTnM3aGVZalluTmdXalFVWE5nQVdhd1o5Mmw2Rk8wU291eER5WWlT?=
 =?utf-8?B?TXlIUXZEaWNhWlRnaHlzV2hNa0RxNkxRZ0pMZUFPL0xieUZTbitiY3VobnpQ?=
 =?utf-8?B?NS9JNTRjaVhQQzYvUzN2Q2FPWVlOUUc0TnZrV3BITWJIUnZNR1VqTmx6UmpH?=
 =?utf-8?B?M0YyOU5LTjlqTEF1QU04MjBOOGxRRFAreUZNZFJVN2QwZ0w4N3FSV3Y5Q2hJ?=
 =?utf-8?B?ZmYzRHlUaVc3OTJPc3BEMXdVblpwQ2lJcE00cTlDZjRkdnVkbUVJNFExU1ZD?=
 =?utf-8?B?VUVpbVU4TmJIclZMMGtLZjJwdXNnK2wvZEJ3V0NYVGluTjB1aW1YTktTd0tD?=
 =?utf-8?B?azlBaUpOS3BWSG9kSkFKRGpqOGluMTNCY25LSnJVR0twYVVlT3dBb3d5a1hO?=
 =?utf-8?B?Z2xleWpDRFU5RmFvbmpneURJZlUxeHpDNHJZVDFBNlNtTlFrWGd0Tk9DZEo3?=
 =?utf-8?Q?Men6shc93+mokrr7OhQd6ijA+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b2e2b4-719f-4769-74ab-08db3c00c588
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:23:41.6340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z90fdjSYXu8PSPsBHXI3G3X5zReM4VJG7192PArXc9BWvgIkah8Dx3FcT1rt1Ut3bjt9vn3xLFD6qGS6rW0KGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7563
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, 

I'm considering switch to bpftool's mirror on GitHub for packaging (instead
of using the source found in kernel), but realize that it should goes
hand-in-hand with how libbpf is packaged, which eventually leads these
questions:

  What is the suggested approach for packaging bpftool and libbpf?
  Which source is preferred, GitHub or kernel?
  Does bpftool work on older kernel?

Our current approach is that we (openSUSE/SLES) essentially have two version
of libbpf: a public shared library that uses GitHub mirror as source, which
the general userspace sees and links to; and a private static library built
from kernel source used by bpftool, perf, resolve_btfids, selftests, etc.
A survey of other distros (Arch, Debian, Fedora, Ubuntu) suggest that they
took similar approach.

This approach means that the version of bpftool and libbpf are _not_ always
in sync[1], which I read may causes problem since libbpf and bpftool depends
on specific version of each other[2].

Using the GitHub mirror of bpftool to package both libbpf and bpftool would
kept their version in sync, and was suggested[3]. Although the same could be
said if we switch back to packaging libbpf from kernel source, an additional
appeal for using GitHub mirrors is that it decouples bpftool from kernel,
making it easily upgradable and with a clearer changelog (the latter is
quite important for enterprise users) like libbpf.

The main concern with using GitHub mirror is that bpftool may be updated far
beyond the version that comes with the runtime kernel. AFAIK bpftool should
work on older kernel since CO-RE is used for built-in BPF iterators and the
underlying libbpf work on older kernel itself. Nonetheless, it would be nice
to get a confirmation from the maintainers.

Are there any other downsides to switching to GitHub mirror for bpftool?

A side note: if we want all userspace visible libbpf to have a coherent
version, perf needs to use the shared libbpf library as well (either
autodetected or forced with LIBBPF_DYNAMIC=1 like Fedora[4]). But having to
backport patches to kernel source to keep up with userspace package (libbpf)
changes could be a pain.


Shung-Hsi

1: In practice kernel & bpftool version often falls behind libbpf in
   snapshot distro (e.g. openSUSE Leap, Ubutnu LTS), and the other way
   around on rolling distro (e.g. openSUSE Tumbleweed, Arch).
2: https://lore.kernel.org/bpf/CAADnVQK-arrrNrgtu48_f--WCwR5ki2KGaX=mN2qmW_AcRyb=w@mail.gmail.com/
3: https://lore.kernel.org/bpf/20191204233948.opvlopjkxe5o66lr@ast-mbp.dhcp.thefacebook.com/
4: https://src.fedoraproject.org/rpms/kernel-tools/blob/82960989c918f81fcc6742a6d765afbec5fa4f74/f/kernel-tools.spec#_248
