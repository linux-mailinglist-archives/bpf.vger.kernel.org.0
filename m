Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90E86F13ED
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 11:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjD1JNt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 05:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjD1JNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 05:13:42 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AB0468C;
        Fri, 28 Apr 2023 02:13:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzX1FP4LlIqcjT/kUcNIXqeFoFT446m9T13nl93NemXhPrZ37k83k6VsGH6jDfkz6x+87yB+ffYYOsfGccyafLrAvHh3y7bYrbowiYzPHDO3xN08BQJkhhOMtN/mCA8k5cLP8d9VmEAACuguIQhoo3kpIxq/GSIqngaCNPtfRSQ+iJWVSrxywZlfcGbSf5WBjIjnLas9bdumvJ/nkjRCYtUUCGZ7EuK3LahhH3gDx5xfw7tz21nxVZTzPX7MOhUnqPqGzO1m2O31ARpIEwNl+qN+BK4s+WLlPgUNMl3eRmgv0IlgN7K64MC6jBlHI+lw3JRyEEmwGZ+vbw4d2R3LHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVJUz7IZOcIKTQ84ceUW+uSwLJlvlRF1aboMQu8gVYo=;
 b=kvAUMlS2lydk1w8QNhxuzdDnmdoN6wvKG7lG+Gk6iF9VNRWfujHlndv1uJ7tAUuBXj9/tomWj5IJ6L8zk71+pxQ4o8ZANtUOwDtZ2cBfRmc00OJnFXk2NWHOE0WSkTTgHB5UWv7fHL5x/ohk+R3VvWJnCQJLBzJRbqyHTxjIu1kICx7pNOL0x65Ua1NK56xlehU2VY3fy8gS2Psk7v4N8Gt54TWF5O74eUhkt9W9LyL+EUq868aKaEHmn2FIH8B0bdJGFC/aAeMJvuE+/0Kd0jBvLnt738bOp8E+DvV2ZGfmxn7KDa8YQS1r3e6KDBhVesLbT03Zxwq9FxL21VFqSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVJUz7IZOcIKTQ84ceUW+uSwLJlvlRF1aboMQu8gVYo=;
 b=GCH33kAMHEkIzDFqxPVicQdbXWi4fFbaAA+39Tp0ZluhOooEoZRTH3nHUydsFOan6hlzjZPz4EWXSgabUqU7ljI3VHYUm4lM/4ld3Giiey3YJALho4y6Y8uMHrWG2SNlyeM4wYgGN0BqJ66yiybZtLth4/doAs2H7Hq8Iv7Vj54Dma+Nh/vJnjMZbmYcQ5h7SpeCheZxFAm5G74arhADqH1Q7syNwHL2Q0hbKdMkVlCBBBGgeHAeMimwhPMYXPjbnp2mCFe2w37i8pdQfoXMytLvoTDtGABXJZh+v/p7Maze9vo+kbvL1Vob99848rwAxxmcL1OuFZ5RmMC7vfCW2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB8984.eurprd04.prod.outlook.com (2603:10a6:10:2e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Fri, 28 Apr
 2023 09:13:25 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::304b:8d0d:7d27:43ef]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::304b:8d0d:7d27:43ef%4]) with mapi id 15.20.6340.024; Fri, 28 Apr 2023
 09:13:25 +0000
Date:   Fri, 28 Apr 2023 17:13:15 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
Message-ID: <ZEuOK8Rvlm52d2DK@syu-laptop>
References: <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz>
 <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz>
 <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
 <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com>
 <87zg73tvm1.fsf@toke.dk>
 <CAEf4BzY9Hr2M7dZXaTZCP4SRat+KpN42c89LG1Msn4PB+1O1YA@mail.gmail.com>
 <878remtxvs.fsf@toke.dk>
 <CAEf4BzafdhjjxxW-7ovbO9vpGa3KVTV4iESe+gjRk7UyJtg6aA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzafdhjjxxW-7ovbO9vpGa3KVTV4iESe+gjRk7UyJtg6aA@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: 292062f4-1509-4ee8-af51-08db47c8d247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VeR2VCQw7HNtlVIIHW5sBt987n+0cMjT7KfVhVHidRU/4+WgcAnOHNpd5DChVkpkMldzS3Pzq4cCMjU2N6ypwS3O3cBB8dITLSSiSihnFgUUWSMfy8WedfOPKvbJvaJDR247TNbjSYnW9cZNAMr6Wc57qo8KUDw5aCy9SwTHWgILieJhP2H8ChRc3SQ+W7sOESHQR0R8efL1A5Bsj6fXslrf4ER8SDuif/RPeiEYi0bUxoUc2fXRxOZHaOMFbhwB6mwIN4rNeskfT17Tg8vY8OAKyPKhsg9p0ZkjwnJhz26u1a7u3H6yqBL8NYdamoAabTB9a8JSsj15+NFs88+Zl74pxrvdM9xGUobTFRIs3ZtdIaUGBRfsmTUeGET7j0U8qOzAyi2RnrrkRhDd2QRfkLofefRvpzMmPRNmBk3Ryw3NTKtmNBtRoeph0jOcyTe3amV7Nykj7eWLf4cLU4etXxuwHzJ4pTynkBMqAcayliRHHDUVmq2TFwHOvK6EMTPLCRZrc4Zy5eRg/MIxcm/gJuI52C1jfTiOKNXja1Dms87MANsu0XbdBA9ymHK6xE8M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(66574015)(83380400001)(186003)(66556008)(66476007)(4326008)(41300700001)(2906002)(66946007)(7416002)(5660300002)(8676002)(8936002)(6512007)(6506007)(53546011)(9686003)(316002)(26005)(54906003)(86362001)(478600001)(38100700002)(33716001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1ZSclEvbFNTem9rUWZjWXNoTFlTR0xkK1QyZjJuc3gwM3dGTWM1K2pyOUdG?=
 =?utf-8?B?Y0ovak9YR2hPTHZsNHZxbGd4bkVuVmJONFFmck5TV2VIMTRqT09GbVNjTEdi?=
 =?utf-8?B?RkV1aDhtcjlHa1BNeUM4VTM5bXhvQjI5Q0hNRkNkZHU5MnJ3Y3RJOWRhdHlT?=
 =?utf-8?B?Vk42WkUyc1EwNWZIZVdGUGErUFYzT290MXczdG9uak5jSksvTThVcXpiQkRX?=
 =?utf-8?B?MFFJMnA3ZFZwZzFjbWlmU0tMbnhTN1d0TytBcmc4OTRiYzdacmNacXVGcDIv?=
 =?utf-8?B?Ti9LL1ZyaGkwM3BTUURycFVzWStKSW4wcGNBR0RXUkxWWlQ0OXJuT3lEMlZH?=
 =?utf-8?B?OGNHS3MrNi9IRExoZVFrQmpOa0tDODJiU2ZCV2RVTlBJUkdqdkVSQXU4ZGxk?=
 =?utf-8?B?V1ZVRmhEZ0tiSUlNeGQxTW9MWnBkNEpHNCtxaE9SQWpNMFpDK0dhNkpTcWM3?=
 =?utf-8?B?QmxTcXBBRVNuQ2Jvd1M1YjN3M1p4a1ZOYlpXL3VQd2RaWE9mNkpnWU5NTU05?=
 =?utf-8?B?NFRidWhDbW0rbFFnRWplQmdkNUdrVkdiZmx3M3NjMHZLUkxIQ3J2djFMeTZL?=
 =?utf-8?B?STlpdytZZDl6RnZ4bUJIOW9VK0dNWThXNFNuclc3aG43V3dQTWtONG4wbXVj?=
 =?utf-8?B?OUlmVzNGWGcwMFpvOThGdFgwL0tVa0c2WDhFSDYrNWc1aVg1UW96UjZtOTVI?=
 =?utf-8?B?TnNkZWhyNGhKcEhlSEU1cGtYaXB3RmlZQmFjNEtIZzdGQmJYUkt1ZW93REZr?=
 =?utf-8?B?aXNLU3pPZmZ1OVpQU2ZCeXVIbHY5aGs5cGVIRVdreVpQcFF2Z0R1cFZVME4x?=
 =?utf-8?B?dnZ4RFVBd3U5bGJIYUNjV0RDeHNHeTFRTU9TZEtseXpBY0FWUzZBMmNSR2J6?=
 =?utf-8?B?cDhMNkl2TUhoRTVFd3M5M2VsbjZmWUt1WFlveFBRZy9KQlFOZWt0dm15Z2tB?=
 =?utf-8?B?SHNqc3FwKzhkeHM4UnJrN3pubXdIUGNOMDFPaG1DVUdVOXZtdDdJZGRyWnl5?=
 =?utf-8?B?dGFUTytGdHpzVWFhWTVHZlZ2OVJsOVJDNmhmTUNpMnUxVG1aS2txR1czT1lv?=
 =?utf-8?B?UXgvQkU3bHUyV0ltQ0ZjY2lKdzg4WTdaNG0yMXV1QUF3TDhOaXJ2YnVQZFds?=
 =?utf-8?B?b1dIbDFVNHpPNU1OVkx4ejkxbWVWWE1yZ0QzT3h0dVdQQ0hnMy96Zmg5UG5k?=
 =?utf-8?B?cU5DYkdKRFVXeHhnamJTTFl3SUJHZjJCSzR1ZWloVnF5azN1WFAvcUt5UkdT?=
 =?utf-8?B?Ri9OSW1mZlhKRXJ2R1ZmT1I5TzJuNzl6clYyQXJndnBDUFZDeWdLZlVQUnpz?=
 =?utf-8?B?QWorb0xVbmNrL0RiWGxPRHBubFV6TUxuQ2ZYQ1d6cW8ydDlFZjV1bGtEWTZq?=
 =?utf-8?B?U2tVSTRhNmg1SE85Qnc5dUZ2d1JKQkVXb3V2TXdLUFN2OHl4S0ZKVWNrRUpj?=
 =?utf-8?B?b0MyMXlQTTFMeXhydHBYRXg2SE01am1jZXNCVlBncDZCV3h2ZlRlN24vZUg2?=
 =?utf-8?B?Yld4Y3ExUjRYYWE0dWFDMW1WUkhQcExuYmkyQVhqNDBnZXFpMEFSaFoyUnhP?=
 =?utf-8?B?eUI5U2l0RHBvZlFpN3lJcGZTNEgrMzhxZi84TGFQMFUxWW1saDNMMDAwZzJW?=
 =?utf-8?B?QjNEeGdzeUF1anpjaWJHaGlJY05JVWY5MG5jQlp2OG1HS3ptQm5TbkJxNVV4?=
 =?utf-8?B?emIxQkFvbE9RNFBoZnZKejFxRmRYYnNXdURQVzUvNkRrdC84ckplYUg1aHV3?=
 =?utf-8?B?aWF6V0tXMDZSRmp3bVRESE9DNEk4ZnNtWkN4QWtFYnpKLzdVVkhWVnNsc0sr?=
 =?utf-8?B?dFFkZzF1REFrelo0OU9KKzg3Z1RDYVdnL0hyMVoyNzJwUVpRYlY5WEsrRS84?=
 =?utf-8?B?SHlQZlk2bG9vUEEyak9PQ012c3ZET2R4eEptK1NxWFBQUHlld0NMY08wT3FP?=
 =?utf-8?B?d1BnaTB5S1JHYTBFYkFZbk5qc21yRlljV1VUTmVjWnRZTEhTZW1leXVobHB0?=
 =?utf-8?B?Z091QXdUc094MmR6Zis0OHplQVR5RDZCZlBTemdxYUp6TkpMS2dCeXZjWTM0?=
 =?utf-8?B?bWN0d3E2RUJYYlFGNk5uRlZiNWYwYlhvUE1KelZLVnNFVDhlOXJLR05wK2hH?=
 =?utf-8?B?aUUwYmx0aTQrOGNSeVRzSWVmNUMzVHkyRktTMUJOaEpHMHR6cTc0V0dUc0hs?=
 =?utf-8?B?U2c9PQ==?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292062f4-1509-4ee8-af51-08db47c8d247
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 09:13:25.3494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4BxyodMpI0lrqE8Y/fjrcflUfg6gblOYHkTfgBKAEunVLwa+6d+FxGVN2J0umJ3GLfIwgWLevPlvoe6sArVKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8984
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 20, 2023 at 02:39:17PM -0700, Andrii Nakryiko wrote:
> On Thu, Apr 20, 2023 at 7:46 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
> > [snip]
> > Right, well, you don't *have* to be cooperative with the wider
> > ecosystem, of course. Just as packagers don't have to follow your
> > recommendations if they have good reasons not to. I believe we've had
> > this discussion before, and I don't think we're going to agree this time
> > around either, so let's not waste any more virtual ink on rehashing it :)
> 
> Exactly, so I'm not sure why we are even having this conversation all
> over again. I agree on not wasting virtual ink anymore. I'm not
> forcing anyone to follow my advice, I expect others to not force me to
> follow theirs.

Thanks for still going through the reasoning.

I don't have anything to add to the discussion, so instead here's an attempt
to summarize the thread thus far, reading between the lines here and there
to keep it terse but complete; feel free to point out where I misunderstood.


# Packaging bpftool and libbpf

- bpftool and libbpf version should be kept in sync
  - interdependency is by design
  - bpftool uses private functionality of libbpf
  - bpftool generated file is tie to specific libbpf (?)

- the GitHub mirror is the recommended source 

- benefits of using the GitHub mirror includes
  - ease of upgrade
  - maintainer crafted changelog

- downsides of using the GitHub mirror has to do with kernel backporting

- git submodule requires extra work for distros to package
  - offsetted if the source of submodules are released along

- bpftool releases will (have a file that) includes submodules' source along
  going forward

- bpftool and libbpf both should work on earlier kernel (if not it's a bug)


# Other

- motivations for GitHub mirror
  - ease of distribution, packaging, build
  - CI, to be used as submodule, Window support, etc.

- libbpf interface stability
  - stable API and ABI (within major version)
  - BPF object format is not considered stable

- libbpf is not opinionated in how it's used as a library, either
  - statically or dynamically linked
  - a tagged release or a random commit

- on statically linking libbpf
  - reasoning
    - full control of implementation detail, decouples from distro package
  - against
    - difficulty in applying fixes


Shung-Hsi

> >
> > -Toke
> >
