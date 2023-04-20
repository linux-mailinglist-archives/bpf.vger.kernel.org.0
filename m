Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4073A6E8DC7
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 11:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjDTJQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 05:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjDTJQ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 05:16:57 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2088.outbound.protection.outlook.com [40.107.13.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC4CFE
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 02:16:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1uRHXDTB0nksbNX9h22cog1jMA9CSKa+JES3oirDLqOdWCdaUrcEi6HraQ8uFeTWjQ1asDysm84SoeFQ41qTejTDw0pXcLhrhOy6TKSFrhNQSqTyv7TAUEzEVvpUNKhlA5DWkwQbRwqDVpgU83j/f02ETBhcW0/wOFsM385DcBKTaTsBIz0mAjy5msMyOx9mV191uUVIWywGpeyecRkQsDVEw5tdS1gcGowd5GlaUQMHbiuRo3jTH3izdtZLcjCfqx3RU3RTWSl4k50zbwWixkq8XSIfOZdljOIi2k2aOL4OJkkR9NxWiKT2c48FCdQorE5AD49M4Xeg4u8AcBMVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNEo2uCeMaoyBqkkEUw30VY56rrBY0G0IeDuVOVCHr4=;
 b=DmpnjZCRbgzznFTK22HZSZfWkswulSv6B/tm3wMyajx9yl/meg8wuZB1a6nBd+k8uK6S2DvoyV8Ezj2gHDvKpmACPaTcX63RCsCdEw5If+TTsGIMjmpOggGcYphQGruuEffya7CZDObjK25v2faEAwPxEzd03EeJyrf8lEAKadYIa5/+Wv6899tZYAFLwk3G0sgr9HwI7kw7ANK7luJbYbbbBHlNmAbInNPSyv1X4B/RmONg/dYo9RcoJo4m+3J1J6mFISODSwYaxasTaD72F4mJIqvl016QLq/XOFydzwiOwFQ0tmmCiOrAVT6SYNdxjQB5VE3wwDGCEH3fl4rDNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNEo2uCeMaoyBqkkEUw30VY56rrBY0G0IeDuVOVCHr4=;
 b=xXznDg1nYMcb6fQAIGIInMWdYiXXGHVQtz9ZtMFpfY4BG+sqz2D2yJzi+blE0ewkvaYrIj+1cNk3mMDVJBnDCViPRJ5LBboNkZqncq94z/2w1XPL5E0q+YqBoS6C6TXUL0ebmTcyTrJMPZaf+kJ8etvyq9alOMS1VJPRhHa6M5TYzodJvmWbbVjHhR5AJZ+IbUNr5K0puDULnEo5qwFj4dyKbMac81s4ECWDwew7PSGCSX0HXwj2DWuVS5PIyp9N9Uz5aysm0vEpZx14A/GguaJR8gyUUXqg31NZYs4d2P0GTxrIyp2H4uJWiG6eYghdV9T0QdfcsyAZPg7/pPOhoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from GV1PR04MB9513.eurprd04.prod.outlook.com (2603:10a6:150:1e::9)
 by VI1PR04MB6798.eurprd04.prod.outlook.com (2603:10a6:803:131::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 09:16:51 +0000
Received: from GV1PR04MB9513.eurprd04.prod.outlook.com
 ([fe80::3cb2:65db:f6da:125]) by GV1PR04MB9513.eurprd04.prod.outlook.com
 ([fe80::3cb2:65db:f6da:125%2]) with mapi id 15.20.6298.045; Thu, 20 Apr 2023
 09:16:51 +0000
Date:   Thu, 20 Apr 2023 17:16:32 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Improve verifier u32 scalar equality
 checking
Message-ID: <ZEEC8EmikVKM3nJm@syu-laptop>
References: <20230416232808.2387432-1-yhs@fb.com>
 <ZD0+ULVuyhDtl8Aq@syu-laptop.lan>
 <0378bb31-dc0a-f656-c0e7-733ff1c78990@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0378bb31-dc0a-f656-c0e7-733ff1c78990@meta.com>
X-ClientProxiedBy: TYCP286CA0086.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::12) To GV1PR04MB9513.eurprd04.prod.outlook.com
 (2603:10a6:150:1e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9513:EE_|VI1PR04MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: fb076f52-e7a4-4504-c6de-08db417ff909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Si3mygqWKsyqiBZPZDrYQMroLuJ2EwGz1j6yznGShT4vA1hmJRfgYgZkJrX4NG56w3ZWNWgNII5saKgFBDwIKfSZxwjpSgvtc9VCYiFQMx8zRyMzu+3ac9NadWTWdnEd8a7SexmhoBLeL2R5oKV+iSwT2EZevfQZCOFCQMhPg3UC+YxJimh5hVEbPxPX6rFrZRNLk8tOkkhfn9HF7VAW10GHRxazqNtW3EGY+MBE8sc/Ag1pTGuXnkn7rKnFBwBYAIOp+5vVVtQDtCHuiPOJVN/Yx+4GvKokWmp7RFloJy30SvVqYhRa4TdIeQV4o7cVaioRurj97uXOTPUgzEkKkqswlPk3mjzNPiSDDYyl6gOqFhuVqRnS0fhSYvR7SSQ5XQGYkDjO1tNDHiIXkj4s3/IIeZNywPU/CnL0Lpcq//Mi8T9RWFKmv9DZW2rUjomRzvlbU8wKDMTzzdR9HjyyeZtfhvAk17y5QEu7ham1thyowkqSBahrom1Ln0kMKBp1qJ27suNUCV8A/Of3RFB2jYLk/ohe3qfh9j9XUOZ0bA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9513.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199021)(6916009)(4326008)(316002)(66946007)(66556008)(66476007)(966005)(186003)(478600001)(6666004)(6486002)(8936002)(33716001)(5660300002)(41300700001)(8676002)(2906002)(86362001)(38100700002)(6512007)(26005)(53546011)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2F2YisyYUphVGd6OWtIRno1OVpyQ29saEZ1eXQwcE8venFKZWFTZDM0bDRq?=
 =?utf-8?B?S2k0bWV6QVlUTmVjKzFSRllyQ0lTY1F4OG90bHRIcUhTcHlTRFVjcjZ0SU5k?=
 =?utf-8?B?OXVxTmFHVVlxK0l6Yk5uKzlCcEZDb0kyUlMrdk5POE9sUm5nZjVjemZVQUcz?=
 =?utf-8?B?elNEUm1TMmVxTnNMaXRsRXpRWmtlQWd4cDAyWVQ1M1hnbXFxdVl1TmJhZXdi?=
 =?utf-8?B?VWZTWDJ6WVA3YTMybEMyOS9JdWNSZm5uZnRGaVBWS1k2RmFwTE5OMTNGcXky?=
 =?utf-8?B?cWFvR3pYM29LZENiTWZsM2dPc013Ym9YajJsTG9LMEFiTmNKcktmTnJyekdx?=
 =?utf-8?B?L1ZGaTUwMWJnSFB2OG5SZnVPM0NIQ0hKY3FONEt3MUtobmJKTkVuSjludk1U?=
 =?utf-8?B?M2dQOVQ5cUZhRWx3NkxCaFNsVmN2allUcHFJQnI0WjFxNkRJNHdlWnpuUTFM?=
 =?utf-8?B?OEU4dkRWMjA5UjFvbFF3aE5HZ3RzdzFIOGlQNmtDa2RsRzVneCtRYnVLQ2NX?=
 =?utf-8?B?azFLa0pWOUxUMzhLTGVzeURXWmZiTXloTXViMDRlbExyM2J4cFphb09HWWJI?=
 =?utf-8?B?b2owUlpJaVRsNzVybWt5TG1BTmFtdnhDbFN3QVEyci9QUWNQdlBHVnZhWWla?=
 =?utf-8?B?Y2Zkc2pFL3M4SmlSeVh2LzNNM3ZhNmRsN21IemJEMnpoQ2hLTEE2Slordjlw?=
 =?utf-8?B?dVRWM3BoR1Q5cUpsSlp0bnZFbVp2UmNLNjBNRUltOWowclNyaFN2MmJNY0FN?=
 =?utf-8?B?cE1KcW5vOGNQbldVemx6ZWtQQmhIT1ZjbjVrY1FkdituTjhTdVU4Y3pHbkVX?=
 =?utf-8?B?eklwQ21FTjY3QWI2b2taUGhocGs4WEsyQkR0eFh5RnpRWEtMV0lwckxLUDJt?=
 =?utf-8?B?US91UzBtTzdVbFJIWUt3MjltQnVFdU1tbitjczlxcFBodkhNVzVOd0RRb2Vu?=
 =?utf-8?B?RUhjTFUweGFpN2E1Zm82dyt3Wk5HOU5vdjFNdDJYT21mSnIxRlV1RG5sQ1d5?=
 =?utf-8?B?OHhKdVA3VXZTQkgxSTFlQ3lldzRoYjFuY2JkZk00eGQ0djhzV1E1NmdXL2RK?=
 =?utf-8?B?VlRndTFBMDlRWjVPcW1Rdklpa2d6WkNScERLdjlJZm9RL2dORDRscmFLZ3Zx?=
 =?utf-8?B?Skc2SlhtYTJnVk1RVmtUM1FYR3RSU0pnUTE0M0VmblJiNkk1aHRSdmxZYWhU?=
 =?utf-8?B?cDFHcW50VXlzejE0alBQS0VPNytmaUtsL3RuUTFNaGpPTlJGT0o3ZlFreVFO?=
 =?utf-8?B?YXlCam1kSHNaZTZEbWd3alkxc3RPMTQvNnRtUFFaci9ya0pKMHZrb0ZBYU40?=
 =?utf-8?B?U0dxZUh1UWJmRitqa1RRSWRuamZWcUo5aWwwRjQ3YitBdkEvZWdsaEVXWWY1?=
 =?utf-8?B?NGkrZ2lmT3VxMUllZmR3QzB3VGhtNGs3enhsVTdWdUNBVlBkKzFhVmp3Q2VC?=
 =?utf-8?B?SmhYTDJUK2g4YWx4YytNL2YwUVd1QnVLQ1dYZGZmSDNIeGpjTTdmSHVoYUZk?=
 =?utf-8?B?NTBMUkNIbEgwOUxuYk8xMm5pb1hyN3I5TFlMOC9rdGNsd2crK0JZRE5tR3BH?=
 =?utf-8?B?STVzOVY5V2JRdGlPWk15cXB0T051c2YwR0lkKzU5MW1jTjVQRFZzVlRjTjVJ?=
 =?utf-8?B?a0xXdmNwdU9vNVFUamtCckg0MTdwaU5ob2RIakswZEh2dGh0SHp4S1hQWXh1?=
 =?utf-8?B?eXhoUXBwcUZrbDQ0a3BRbWlLTitPY0hRNFFnUld2a3A4TUNxaWxiV0dkbURQ?=
 =?utf-8?B?N0Y4dVAvd0RLL0FRUWNjVHMxZ2VYOXNHMUErbzFQZ3Z4VVJkeXRkQlNjVTI0?=
 =?utf-8?B?elg1d25tdjJJaTRtRXE5Z3B5eWNLT1k0YmtIeVdHVDdTTjh2NXlUb1kwdlgy?=
 =?utf-8?B?YW9IZmZCVDRMWi9ta0VxZFgxSitYMTg2RUNQT2UxakNWUkhFdDV0MjQ3NTNH?=
 =?utf-8?B?RzhwNXQ5VjFObk4zRVVEc1FObGk0ZHU5RiszQWhxeVRmRFdhNGFUQTZ3QUty?=
 =?utf-8?B?dWZFaVNleUY1RjNscUJYNVJoSE1iS2tmd3lIRXlaK0NiVzI2V1FGc01KYU10?=
 =?utf-8?B?aDV1RHA2Nm1KdGNQSmtCbFNtcitkL3hOYVFFQ1A0bXdvdDBxbk9IMjJ0czFy?=
 =?utf-8?Q?hRUhEKbZJ7k+xuv1JUDgpL1yr?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb076f52-e7a4-4504-c6de-08db417ff909
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9513.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 09:16:50.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEDMei+8k4IUSWQsjMZEIXiVRlXkJVAdkqzGFADaLd1lK/xr6Z69pmpyIXhed5jSz5j/Zi4V0fpkqROPglPe8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6798
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 18, 2023 at 10:54:39AM -0700, Yonghong Song wrote:
> On 4/17/23 5:40 AM, Shung-Hsi Yu wrote:
> > On Sun, Apr 16, 2023 at 04:28:08PM -0700, Yonghong Song wrote:
> > > In [1], I tried to remove bpf-specific codes to prevent certain
> > > llvm optimizations, and add llvm TTI (target transform info) hooks
> > > to prevent those optimizations. During this process, I found
> > > if I enable llvm SimplifyCFG:shouldFoldTwoEntryPHINode
> > > transformation, I will hit the following verification failure with selftests:
> > > 
> > >    ...
> > >    8: (18) r1 = 0xffffc900001b2230       ; R1_w=map_value(off=560,ks=4,vs=564,imm=0)
> > >    10: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> > >    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
> > >    11: (79) r2 = *(u64 *)(r6 +152)       ; R2_w=scalar() R6=ctx(off=0,imm=0)
> > >    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
> > >    12: (55) if r2 != 0xb9fbeef goto pc+10        ; R2_w=195018479
> > >    13: (bc) w2 = w1                      ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> > >    ; if (test < __NR_TESTS)
> > >    14: (a6) if w1 < 0x9 goto pc+1 16: R0=2 R1_w=scalar(umax=8,var_off=(0x0; 0xf)) R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R6=ctx(off=0,imm=0) R10=fp0
> > >    ;
> > >    16: (27) r2 *= 28                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
> > >    17: (18) r3 = 0xffffc900001b2118      ; R3_w=map_value(off=280,ks=4,vs=564,imm=0)
> > >    19: (0f) r3 += r2                     ; R2_w=scalar(umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4) R3_w=map_value(off=280,ks=4,vs=564,umax=120259084260,var_off=(0x0; 0x1ffffffffc),s32_max=2147483644,u32_max=-4)
> > >    20: (61) r2 = *(u32 *)(r3 +0)
> > >    R3 unbounded memory access, make sure to bounds check any such access
> > >    processed 97 insns (limit 1000000) max_states_per_insn 1 total_states 10 peak_states 10 mark_read 6
> > >    -- END PROG LOAD LOG --
> > >    libbpf: prog 'ingress_fwdns_prio100': failed to load: -13
> > >    libbpf: failed to load object 'test_tc_dtime'
> > >    libbpf: failed to load BPF skeleton 'test_tc_dtime': -13
> > >    ...
> > > 
> > > At insn 14, with condition 'w1 < 9', register r1 is changed from an arbitrary
> > > u32 value to `scalar(umax=8,var_off=(0x0; 0xf))`. Register r2, however, remains
> > > as an arbitrary u32 value. Current verifier won't claim r1/r2 equality if
> > > the previous mov is alu32 ('w2 = w1').
> > > 
> > > If r1 upper 32bit value is not 0, we indeed cannot clamin r1/r2 equality
> > > after 'w2 = w1'. But in this particular case, we know r1 upper 32bit value
> > > is 0, so it is safe to claim r1/r2 equality. This patch exactly did this.
> > > For a 32bit subreg mov, if the src register upper 32bit is 0,
> > > it is okay to claim equality between src and dst registers.
> > 
> > Perhaps mention in the above paragraph that this works because 32-bit ALU
> > operations clear the upper bits? Some along the line of
> > 
> >    A special case where r1/r2 equality can be claimed after 'w2 = w1' is when
> >    r1 upper 32bit value is 0. This is because 32bit ALU operations always
> >    clear the upper 32 bits of the destination, so 'w2 = w1' in this case is
> >    the same as 'r2 = r1'...
> 
> In BPF documentation (Documentation/bpf/instruction-set.rst), we have
>   ...
>   for ``BPF_ALU`` the upper
> 32 bits of the destination register are zeroed
> 
> I asssume this is known and that is why I didn't explicitly mention
> this in the commit message. The patch has been merged...

Thanks for still replying even though it's already merged.

FWIW just thought it would makes the commit message slightly clearer, hence
the suggestion.

> > > With this patch, the above verification sequence becomes
> > > 
> > >    ...
> > >    8: (18) r1 = 0xffffc9000048e230       ; R1_w=map_value(off=560,ks=4,vs=564,imm=0)
> > >    10: (61) r1 = *(u32 *)(r1 +0)         ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
> > >    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
> > >    11: (79) r2 = *(u64 *)(r6 +152)       ; R2_w=scalar() R6=ctx(off=0,imm=0)
> > >    ; if (skb->tstamp == EGRESS_ENDHOST_MAGIC)
> > >    12: (55) if r2 != 0xb9fbeef goto pc+10        ; R2_w=195018479
> > >    13: (bc) w2 = w1                      ; R1_w=scalar(id=6,umax=4294967295,var_off=(0x0; 0xffffffff)) R2_w=scalar(id=6,umax=4294967295,var_off=(0x0; 0xffffffff))
> > >    ; if (test < __NR_TESTS)
> > >    14: (a6) if w1 < 0x9 goto pc+1        ; R1_w=scalar(id=6,umin=9,umax=4294967295,var_off=(0x0; 0xffffffff))
> > >    ...
> > >    from 14 to 16: R0=2 R1_w=scalar(id=6,umax=8,var_off=(0x0; 0xf)) R2_w=scalar(id=6,umax=8,var_off=(0x0; 0xf)) R6=ctx(off=0,imm=0) R10=fp0
> > >    16: (27) r2 *= 28                     ; R2_w=scalar(umax=224,var_off=(0x0; 0xfc))
> > >    17: (18) r3 = 0xffffc9000048e118      ; R3_w=map_value(off=280,ks=4,vs=564,imm=0)
> > >    19: (0f) r3 += r2
> > >    20: (61) r2 = *(u32 *)(r3 +0)         ; R2_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R3_w=map_value(off=280,ks=4,vs=564,umax=224,var_off=(0x0; 0xfc),s32_max=252,u32_max=252)
> > >    ...
> > > 
> > > and eventually the bpf program can be verified successfully.
> > > 
> > >    [1] https://reviews.llvm.org/D147968
> > > 
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > 
> > Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > 
> > > ...
