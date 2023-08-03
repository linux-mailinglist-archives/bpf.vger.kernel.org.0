Return-Path: <bpf+bounces-6837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCF76E670
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 13:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D03328209B
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F83182B9;
	Thu,  3 Aug 2023 11:11:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3C8F7C;
	Thu,  3 Aug 2023 11:11:20 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB3C30ED;
	Thu,  3 Aug 2023 04:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Faw1z6Kl6XClTdMmvHIJamN/HRmkkH62NTJd87yX7rcbpish4WqN/MMbr3B16XJkeiRzL7gQADeMGV1l3aSZXbPoGQBTT7YEXSWQqZ7+EEKk6b9V5zShGj7kluzwzbhXL3njxrXEQ4j3iW6nURtp6JM2ZhxpRDDabXU4YIbJGxmK1dKONHvSrfQro43SYBgDguvNK+FfPrdYOEU67r2TlpxjAPimEf9eQUnjRpSFJI4iuuatQzLL5Ry7+LvUFN86Xf9WaWD3v+gU+SM7/nLkGpqs0f2tMzdZAGnBUYGsSScML4625Q3uQ63e6XRQQHMhAjgzVsWaKau5H/HC3ndajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXfPEpUQFgk4Niim2D8MuQyj7NAO/H4wSv35/mFRN98=;
 b=Ps3z4UyHLXcs2arHdZhun3kOIHlJzh1dXY1ZRI9y79MFOjqdyCnAcpulw1Tt789IsmzZ4Qb5rvkKrgJh0EHdNANDin5SzTkAryJahLwM/adzgG4zIkpKfxV9xChummyWogtGO/nAqzlvsQzY91t7Pc+5ixeu98dkAK5gTtl+vd8sHxYcyohEZ42Xbl2PGPKUIkCipCZaTXp1wUj0bFPQ0DE3nmGKSqd/kloyjtE6410YrYssj9zA4h++TzpqZT7vSp6l+bBy3amUSlt9qu6oOQPi09dGxXjjTFz2PelH/OjbGL4/MAQYN9/pxiQ6T+YvzJrwez72N/SdZNSpqXgAWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXfPEpUQFgk4Niim2D8MuQyj7NAO/H4wSv35/mFRN98=;
 b=agrxdZGste3K3nHopQUQ8YZm+1VaGnINlXEvugnhBY105BiPgJ8TUD62oQqtAzdcAzTB4d62ftZx9e9fAsU/iuuHRoH+32cNJBzdnEyf4jD4iROc6kwKc4sd0HyPRVgeM/7E0kMYUc6upooWcaYgzaUXgCDGhLgFQjvYydwsET9tXBs0SZ/pSFVmHk31DWu9U999UfU6tM1e2LoR5ntJA/S5BLA7VN8n+S2A5PJ1oGuBJ1VB8yQOGD2u5DhgYIs24gNAu0no/AiSbz45MHAOq2yv5yeSKkf71qb8TWMjLeXDc34Z8+VGTXgJL2H9Es6hqvZIO2URIclrj6rLYq07rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 11:11:15 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 11:11:15 +0000
Message-ID: <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
Date: Thu, 3 Aug 2023 14:10:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
References: <20230721233330.5678-1-daniel@iogearbox.net>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20230721233330.5678-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0060.eurprd02.prod.outlook.com
 (2603:10a6:802:14::31) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cccc92-f802-4d31-f971-08db94125a71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/FwC9bzdn2K1rroBVJ+MnK6nNjwVh8LXpKFihS5qR0ZMMH3VOtqjaIVgkzPMrM7lA31Ky9Qon5tUvwZYP1nlykAvMvHtgJGcBtKKSC94JQPxk+5k9cB481hbZBIVCW0lvDQVzXI5uK3hnZJG1BBqBALV/N1N4CQ46/G4BOQ01wfjvKn3hVCKX6BXNRpz/vOfbxiaVmZ0nK/FgIWJkQqOh0+m/N9F35GcJwkZTOi/K9jEdcq+0DocyeSRS3Z11oL4HXQiCca0B76x2dbIx6z/L7hI+I2VF9t0z1GhEHR4O+XFCrQtKmSHOAf+BJKFhs/fM6G85j3vXrUMLRFY1JYnMCM+BYyWJtMcDlSgOLXaJy5/0n6/HbRGy8bV2Z6hFhfHyCpMz3KfcBNEaLUOR+LjaRS8VZKl9lU9kpYz5UZXD80hZB98IDr26I5wkOrzZjlHYUIw+N1x6E2Jv10okIJblafx8bME28ZoHvM9JF1MgEvjBtRum3LcKH+gxKMWLg9lvtyIsFhUEipET6ChvKEauAKt60heMhMRn42FUYSI+0tQE7jvSklD9H8tgqga96R6HgchokQGLotDFexv4AscBcW3lUiR17t46AUIMn1lxoRqO2LYgwja5CigsPF5yKfKgqs9Bj5p5eBxWxDUJfr2Pb/mvYGwdphx+1KhfE5FloBtKc/JiaA9VVqpO8y6qAec
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199021)(2616005)(53546011)(83380400001)(6506007)(26005)(186003)(41300700001)(2906002)(66946007)(4326008)(66476007)(66556008)(5660300002)(316002)(8676002)(8936002)(6666004)(6486002)(6512007)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9ubEk0eUVYajJzakloTUJRdnNpaTV1U1N0eElTWXRlY21veG9ESmZPdXB1?=
 =?utf-8?B?dUlyWGpiaWp0YzVtbVlEWDdVaXFucDcwT2tyOFJPMytVMFF5Vkx5MHh2eUJ0?=
 =?utf-8?B?amlDVkxzenkrQlpkQ1FiTGh3cU94UkNaWjlrTkVFeHZmZG9qbmhCbnB5UCtG?=
 =?utf-8?B?UXZDMWIyd2ZJN04zZ2JPRlJTKzl0SEtBTGJFNzdWRUI3WVd2ZkRUaHBuTnJP?=
 =?utf-8?B?M3Q2cTFvUDFDRXE0ZDQ1TzlMSklndTk3WnZxMXBKc1o5LzkzTi8xZDhyanhQ?=
 =?utf-8?B?MVpXU0FDLzFVdGhlRi9oSG8wRDRqMFFmRGVSaGV6WmZXbEFQdEJGZlpLQkJI?=
 =?utf-8?B?dE40VUxabjh2UnFBU25abnNNY1JxczU3bkFTcWY1dVlhbmJFaGk2UngzaS8y?=
 =?utf-8?B?SE12VGk4TGxZeXlyK2pxTlk1MDNPWDhXUWNlbEVkTG9tTU51M3ArcThEL1I5?=
 =?utf-8?B?SFJuWitoUHFIZnlmcnVNTkV0K1lleWxqbElHMm1tUHkzS0IwbVY4T1NTeXNR?=
 =?utf-8?B?UVQwdTdQL1RKZnBWTVdlQ3dyOE9KL2pMSElNeUZPTkFkZTAza3BlRUo4NjEy?=
 =?utf-8?B?V0N3dG05TC9rOHFZeDkvVTdTeVo0RnBXRzZwbzN4ZmFtN2l0c1ZBR2I2ZVBN?=
 =?utf-8?B?QytNQ29IQk5OU2tpcEo0U3RXaGV0cW81elJGdUpTSzN0Q05yWVVoRkpmSGhH?=
 =?utf-8?B?L21UMVBTd2c0QnZJeWlXbDRiMXVGdDVQc2taOTdoQUFkTFFVU2hPZVZ2WFJH?=
 =?utf-8?B?a1JXOFB6TjI3Z1dUY3MxR3VoMUkrQ05QcmY0UTVSNGVsK0I0czI0aDArUEo3?=
 =?utf-8?B?Zkt1WHZQRktudUYvWE5pOGhRMHRKbHVYRWJ1VGYyMFI3c0h1T2hoeEpkTUVJ?=
 =?utf-8?B?S0F1MDF4TW5xaDJHcWlsTGdwbHdOK1pNN041U1QwTEUvVDUycnBFQyt6MXFR?=
 =?utf-8?B?VVlRNk9aeUo2K2hORjMvZ1ZpS2t2d1pmU095ZTA0U0wxWXhqUHV1SFJXMDJ0?=
 =?utf-8?B?dUpwL1JmMWxGMVZER0F6OFdacHRQUWZNZ0EwWlBCaEpGaG9qMEo0akxKN2ZH?=
 =?utf-8?B?Z2ZRRHl2NUlzczBoT1AvY3dmQXVXMDdHS0tYSkgwK292R29nTGg2QUhtZkQw?=
 =?utf-8?B?OTNtVXR2OFFPSU95Rk1kZ3hSVW9jTnNCZUF3RXZkTkRYUkY1MnUrN0dhMjI5?=
 =?utf-8?B?akk0dGl0d0lzeHRXelV5SGgzQ1JGTDZHbENaTVJ0NG0rczUyck9XRGs2L0xW?=
 =?utf-8?B?SFpyRGJKd1B1OXpGaENRZlpYaGdteDRSbHNhL0ZQaDVOSjduL0pHMWZQQm1v?=
 =?utf-8?B?UFRQSGxuZVlTUmdORjM0NzkxMlFyUUd2U1daSDFRYUpsOTllQUhtcmg1Vm5R?=
 =?utf-8?B?enlabjVrcFNvUjA1elZ5YnRWU2NNZHJ1MzZFL3ZSSmNBOFhFYllHbnJKY2p5?=
 =?utf-8?B?emJHTTJrMWpPejVneTdxUGVPalRlTUNSUklnR0M4MGpqa3AvTWlUSUd6a2tM?=
 =?utf-8?B?RHVEaGhkQ3YzT0tlWDlhYXFKWXdoM2NmSlIvS1ZNS0hqZVo2T0VGMEJaKzdO?=
 =?utf-8?B?cC9QUzV1V1NNUkh4L3hjL2p4cUp1TW5WNk45MFZpZkw0SlVNZkljSm83RUIw?=
 =?utf-8?B?cTIzRWp6Z1g4dVA3UkdaTXFReE1tR2JkSVV1QWU0NndxaTN6SFhEa1dRWEFX?=
 =?utf-8?B?Zm5vYjVPcnJiZHEzSXpqVW4wcVhtN2xwbDdqZ1ZVcldJL2VaQlZzNnZzWVdW?=
 =?utf-8?B?SzdwaW02UExDeloxc0hKKzJPd0pOUEZkNEppaUw0aUVjSGVSNUlLL2JQTWRS?=
 =?utf-8?B?aHhtRURmZGxTa3lMNlNEK1lvUThFSlVhQ092UWZrMmpyN2lCcXVzQk9EUU5R?=
 =?utf-8?B?S2RyYSttS1BxcmFuY3J3N1JOb0lQK3E4bE5NNkwyZjhmTnpYWklBT2VSYmVY?=
 =?utf-8?B?N2pHZm1pSnQvUFRRZ3R2Y0Z1N0QweEM1RE9hckZ3dUlJK25OQ1VXa01CSEZ5?=
 =?utf-8?B?eFZISWxxZUhGSjR3MGdUZzBkUHh5M0VnS1grclJMdjNYbmZWay9VY2dyM1Rr?=
 =?utf-8?B?SkVINFFJMmNkaVhRcVhHVmthalhKbzd3a2Fnc1hURXFNS3V0cGtuS2FPSndR?=
 =?utf-8?Q?SUkqJKpX+gdB9X/DTEU45yqup?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cccc92-f802-4d31-f971-08db94125a71
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 11:11:15.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVnxdBCVtxSlSENn2d+an1EVsVDp/CZt0SY/JslwiyenZUdcRhgDHtZRDmeiM0Iu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22/07/2023 2:33, Daniel Borkmann wrote:
> On qdisc destruction, the ingress_destroy() needs to update the correct
> entry, that is, tcx_entry_update must NULL the dev->tcx_ingress pointer.
> Therefore, fix the typo.
> 
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link support")
> Reported-by: syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com
> Reported-by: syzbot+b202b7208664142954fa@syzkaller.appspotmail.com
> Reported-by: syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Hi Daniel,

Our nightly regression testing picked up new memory leaks which were
bisected to this commit.
Unfortunately, I do not know the exact repro steps to trigger it, maybe
the attached kmemeleak logs can help?

unreferenced object 0xffff88811ce37b80 (size 224):
  comm "kworker/14:1", pid 7451, jiffies 4295350041 (age 64.444s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 e0 69 29 81 88 ff ff 00 3a 39 0d 81 88 ff ff  ..i).....:9.....
  backtrace:
    [<00000000a0f098fe>] __alloc_skb+0x1f4/0x2b0
    [<000000000dabee54>] alloc_skb_with_frags+0x7a/0x6c0
    [<00000000e681c78a>] sock_alloc_send_pskb+0x63f/0x7d0
    [<00000000a4774143>] mld_newpack.isra.0+0x1ad/0x800
    [<0000000060e32100>] add_grhead+0x271/0x320
    [<00000000040e7099>] add_grec+0xc8b/0x1120
    [<000000009853483c>] mld_ifc_work+0x387/0xae0
    [<0000000079d8299d>] process_one_work+0x86a/0x1430
    [<000000001968010b>] worker_thread+0x5b0/0xf00
    [<0000000090c285b0>] kthread+0x2dd/0x3b0
    [<000000001f322d79>] ret_from_fork+0x2d/0x70
    [<000000008ad6bd7b>] ret_from_fork_asm+0x11/0x20
unreferenced object 0xffff888153058640 (size 224):
  comm "softirq", pid 0, jiffies 4295350849 (age 61.212s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 e0 69 29 81 88 ff ff c0 32 39 0d 81 88 ff ff  ..i).....29.....
  backtrace:
    [<00000000a0f098fe>] __alloc_skb+0x1f4/0x2b0
    [<00000000bb2ddb4c>] ndisc_alloc_skb+0x133/0x340
    [<0000000009614816>] ndisc_send_rs+0x1e0/0x4b0
    [<000000004bc1b8be>] addrconf_rs_timer+0x25a/0x720
    [<000000004d021706>] call_timer_fn+0x167/0x3d0
    [<0000000088aa76a3>] __run_timers.part.0+0x546/0x8b0
    [<0000000066f62ff3>] run_timer_softirq+0x6a/0x100
    [<000000003732ddfb>] __do_softirq+0x264/0x80c
unreferenced object 0xffff888155d0a500 (size 224):
  comm "softirq", pid 0, jiffies 4295352832 (age 53.328s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 e0 69 29 81 88 ff ff c0 32 39 0d 81 88 ff ff  ..i).....29.....
  backtrace:
    [<00000000a0f098fe>] __alloc_skb+0x1f4/0x2b0
    [<00000000bb2ddb4c>] ndisc_alloc_skb+0x133/0x340
    [<0000000009614816>] ndisc_send_rs+0x1e0/0x4b0
    [<000000004bc1b8be>] addrconf_rs_timer+0x25a/0x720
    [<000000004d021706>] call_timer_fn+0x167/0x3d0
    [<0000000088aa76a3>] __run_timers.part.0+0x546/0x8b0
    [<0000000066f62ff3>] run_timer_softirq+0x6a/0x100
    [<000000003732ddfb>] __do_softirq+0x264/0x80c
unreferenced object 0xffff88814e3f6040 (size 576):
  comm "softirq", pid 0, jiffies 4295352832 (age 53.328s)
  hex dump (first 32 bytes):
    00 00 33 33 00 00 00 02 e8 eb d3 98 21 bc 86 dd  ..33........!...
    60 00 00 00 00 10 3a ff fe 80 00 00 00 00 00 00  `.....:.........
  backtrace:
    [<00000000525ad98b>] kmalloc_reserve+0x118/0x1f0
    [<000000008d146183>] __alloc_skb+0x105/0x2b0
    [<00000000bb2ddb4c>] ndisc_alloc_skb+0x133/0x340
    [<0000000009614816>] ndisc_send_rs+0x1e0/0x4b0
    [<000000004bc1b8be>] addrconf_rs_timer+0x25a/0x720
    [<000000004d021706>] call_timer_fn+0x167/0x3d0
    [<0000000088aa76a3>] __run_timers.part.0+0x546/0x8b0
    [<0000000066f62ff3>] run_timer_softirq+0x6a/0x100
    [<000000003732ddfb>] __do_softirq+0x264/0x80c
unreferenced object 0xffff88812acdebc0 (size 16):
  comm "umount.nfs", pid 11626, jiffies 4295354796 (age 45.472s)
  hex dump (first 16 bytes):
    73 65 72 76 65 72 2d 32 00 eb cd 2a 81 88 ff ff  server-2...*....
  backtrace:
    [<0000000010fb5130>] __kmalloc_node_track_caller+0x4c/0x170
    [<00000000b866a733>] kvasprintf+0xb0/0x130
    [<00000000b3564fca>] kasprintf+0xa6/0xd0
    [<00000000f01d6cb3>] nfs_sysfs_move_sb_to_server+0x49/0xd0
    [<000000009608708f>] nfs_kill_super+0x5f/0x90
    [<0000000090d4108b>] deactivate_locked_super+0x80/0x130
    [<000000000856aeb1>] cleanup_mnt+0x258/0x370
    [<0000000040582e39>] task_work_run+0x12c/0x210
    [<00000000378ea041>] exit_to_user_mode_prepare+0x1a0/0x1b0
    [<00000000025e63dd>] syscall_exit_to_user_mode+0x19/0x50
    [<00000000f34ad3ee>] do_syscall_64+0x4a/0x90
    [<000000009d3e2403>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

