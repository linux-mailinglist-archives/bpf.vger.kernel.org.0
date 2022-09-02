Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3EF5AA6AE
	for <lists+bpf@lfdr.de>; Fri,  2 Sep 2022 05:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiIBDwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Sep 2022 23:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiIBDwa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Sep 2022 23:52:30 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50073.outbound.protection.outlook.com [40.107.5.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23BBB4E8E;
        Thu,  1 Sep 2022 20:52:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY+95Ztc4RwgF5tZZ6uajtWmJkum7BSW0eul1KBALURgPiNuE/6GC4rUWNSf+ntxh9umcQlFTepXoYwSFF+loy4iQ5EBRKIQJ6ud1WMSkUZmS5A2lgAHNkGTrTHg6iIKUUMOY4Jpg3U0Nxq/qkhKjasnwSbVfwTstudqM9bqURywmfQr5Lj1VpcxZkZD9OZB1Tcwg6LVgCy8MCSDcsuqHgbufUE53wbTt4KbSo/iKcAxK3FmNVAhNS5YRame/BksTcUQJ55tFmhsguL1s4MKNQ06IqF4xm/UCnzpFNozZJ8VbwkQVVEy0Fgr1BuUfIdtc/PiOiT8KXGcOwVaV0HNTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYVCiqwvKHqgkjWiF757Ryl6yAtpvYW7RR4fGVuMkYo=;
 b=g0YRHho3tB3zQnYzjSvBzjTvZcHw5ODTeZIFbhQ3X4kZJnVrsczpgslmF0pGOYXHkDf8A/l/z03+2Co1YGhE+Ae1Od8zqsA0KWDN8eBccpLXG8lL/HGtGZNx6ddRG/ecmplRpewY2g2PJa68awvTwJ1OlYDg6qE1fcu2PeW7FU21CHVb7+XmKj30VX14QnyCiER6ZzWrRzLx59v/xdDdo4WPpvSQZNJNRrIrgNwwkMLzRACkHFVnTAja/VfD6rqWyJD93k+FVYHtb5wujeO0n+r+lWkeWK/WTF7fHfGLEzK6CvQiMJlSv35lSInmiAa1URK+K6CTU7eMZBrJSCqiSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYVCiqwvKHqgkjWiF757Ryl6yAtpvYW7RR4fGVuMkYo=;
 b=Hz9GzBszJP9XjdoW935TFu/ijv8jBZqaH0ozOpLLvsnWwKsAzMGAP+2vmL2NWK43hv3EEwpcBiygnorr5/CLlUv+bbxPa/zsc9rLWgW0RyHKV4hILKDLgAwqaYjZ2nTftxnmMYvML28jHkATmBpHTTONUmjVwLJK2DA0IbWexpFc/Lk4QyZk6zHzGGfjeh4DbSIhAiIbpJasxL0N4SX2VKW2Man1O3GPQVuJUPNtYKXrjEMDhA1oKU7q9eS/34B+qxSSrt5lMxjhPK7V4bsqSxFHl2DOJIfRm8bZykPso1ypp0WkU6BCTV1Y/ggNeeJjDeQrORESSxYDhv75llrNKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Fri, 2 Sep
 2022 03:52:26 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e%4]) with mapi id 15.20.5588.014; Fri, 2 Sep 2022
 03:52:26 +0000
Date:   Fri, 2 Sep 2022 11:52:19 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [RFC bpf-next 1/2] bpf: tnums: warn against the usage of
 tnum_in(tnum_range(), ...)
Message-ID: <YxF984GIloJWnV9x@syu-laptop>
References: <20220831031907.16133-1-shung-hsi.yu@suse.com>
 <20220831031907.16133-2-shung-hsi.yu@suse.com>
 <0f6d7f97-8cd9-d513-368b-39706dd6b06a@iogearbox.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f6d7f97-8cd9-d513-368b-39706dd6b06a@iogearbox.net>
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8ce39f5-4141-4544-fd8a-08da8c968c63
X-MS-TrafficTypeDiagnostic: VI1PR04MB7072:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCmonHgRcFLBnxppcpE2z9iL+ZxfklW5LoVTgikKgGYkh97VMGCojK/najwnBztx0GH61g4nJLvdOLMS60sWEdfMyIG+/pckNYyJeFWWz6Sh+BEKarvXxWunrg/P/ByH1CbxYdBYv9s1LrIbD2fxRE7rLwntJAiS0pn778GPpQ6DVYqAfT57BUXqbsQN721c1ZAF9WWX7YmNPU462ZVyPcg0IUVS8HDT46N0vFL421tj6mfcmKGSP2286vu1FIdFvTR5mMZb4mmADmV5/N4RWqpodFo9CnHs2iMsyDqad5ILKMecvawQFckUBB/+NRVcCowfWIvjWyynnMLovMJTtjWrMmQ6XW1mgp9SiFI5xZunqUEmnZW4W/kjdmvyMReffjNkHePMbBANsZ8Vcp6Cb5EwlDi9pu0ticCnwq4BQxR+gzWzH8SrVoXAYfYh9yR8uy42MIYTILzPGtIZAexH7jNnVwGl4sleq0YjG/wJcjO+IBRcv5kul+n371OY2ISaoVbGp4luOerXUq34rhIv61u9zXeNkjeorK1/SKQzrrSt06PbIusBAcyHk86JYldSE1XJ64gtYN7Cy6ZTf2+3BreizD6+XUNohkJeroFQmafVZYLr1umoRWLjNROWx/h2Zk7B4zuAZuXrjjfbRoJRe9pRtPaNLg0InOX+OJGbbomQCVQJ18jYfXQ71GcY/LMxNVmYKKfJebQm3WoamS5icBsobp80ty67aHKSPLBQ9LiwaXAwQyj89QppN+7YjhSoK1eNaMf5q6+beOhX5eOvyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(39860400002)(366004)(396003)(346002)(136003)(376002)(8676002)(4326008)(478600001)(83380400001)(26005)(86362001)(6666004)(2906002)(9686003)(6506007)(53546011)(6512007)(8936002)(41300700001)(5660300002)(186003)(66476007)(38100700002)(6916009)(54906003)(66556008)(6486002)(966005)(316002)(66946007)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmtGcGdzSUN4YjVoUmJNK0NMdjBGK1Q4UkwvZ0RXeVMydlFYNVFtTWVWRDlv?=
 =?utf-8?B?QmJIek1RQjJTSE82VTA2WnhaY3FMWVFCN2hDNDkxUXozQ3M3clRYb3Z1SitC?=
 =?utf-8?B?ME5haWhHSVJERHJ0MTh5d0VMZWRDWlY2enhUMWk2Y2QwaG5ISllZRDI0REky?=
 =?utf-8?B?OVBWU0g0OHBzMytOdlgyMWFvcjJNVUR1dnF1TGZZaXBBNEl4TlJVQ053M3oz?=
 =?utf-8?B?ZHBqWUJyZzNhbzY4b2JTd0xJYzFkbTlsNXpGdkJ6M2l3NW9XYUdNak1BSTVV?=
 =?utf-8?B?eFI0S1AvN2ZuVGJZc1RHYUhaV3ZnVlRqL3hMRlg2TlA5R0xkaVZ6RFVWZjIz?=
 =?utf-8?B?MHErS1IvaGlqeTNnZDBLNm9McFljNkhReStBMXlyaUUrQk95UkxaSkFzMTFU?=
 =?utf-8?B?b1F2WXEya2tUcVpJM29PMTA2UnluQkwyQlJFRFNQeTIyeU1PTXVLOU1FWGd4?=
 =?utf-8?B?SWdUNjRYZWxEOXczd2tEb3JXTUx6UWYzQnNrbG5CRXk2SDZhRXN1YlNnc1ly?=
 =?utf-8?B?Rzkzb2czOGZXOHlGdjZjQ3dqdUxGY2hNaDZBRWZYNUtIcVNXcnBLR1UwUUt2?=
 =?utf-8?B?bTUvZVhydUZLS3F6REpucXNLcWc5aGVXQUxrMHd6c0lSK0tJTXZZaU9id0NV?=
 =?utf-8?B?VGpFem5mREtsRXlSWnhWd29GVzBjZzNxZUV0c0VUNmRuZXMrSmZUdUxoallW?=
 =?utf-8?B?L3BzWXJiSEJkNERMMDBuOVJqQmx1RzNQcDhzRVpBNytKWWNIRllCcVdIVFlU?=
 =?utf-8?B?Vm9Kc3JGeVVWZ1JrMWJMdTBOQUE1RW8ybU1oQWEyZERDandhUnVtQW1uSEpM?=
 =?utf-8?B?ZXNzcmhKdFNPS1RXUWFqc1Flb1UrdXMvQXk3bGhadHFyZWNmbE0rbWVwZXA0?=
 =?utf-8?B?Wjg1RDRxd0Jzd0R4RVVad0xENkVwc3JWbmFxOUh5ZFk0UTJjRXg4TWplc3cw?=
 =?utf-8?B?YnZjQkZjZXgrRWxqZnc3YmVLaUl0TUpuei9RSDlGVXF3MlN1and6cGlqeUox?=
 =?utf-8?B?MHIvcHorUXgyK0lPc0ZlaDNYQ3JmOTVLU3JKZVYxdEJVQlV3eko1U3B3Smxm?=
 =?utf-8?B?L3lzZFg4WGVCVzFUZ0dReDdYRHFPQmxOU3FzYkFzUFdMWXZJNHJjeGZHaW5T?=
 =?utf-8?B?aTdQdXpQQ0VJTUN3SkpmN05CWC9Lajd1Um02TG1BR2hES1ZxNGNVTWIyRGRW?=
 =?utf-8?B?UGVHVHJ1aC84R0QrcFpoc29qaEtCdHRQOHF2ei9pQXgzcHg3WEhqaUtoanVK?=
 =?utf-8?B?cVNER0Y3Z0t5cFBHNmhDaHI1d1VsL0Y5QzVKNXA3QVg0NndIOEtsRVlqTGk4?=
 =?utf-8?B?MSs0TzNUWlZkbjVubGVqbHFnblc1dWRRMzhYTU1kTVZYM0dPbzJSN05pSGgz?=
 =?utf-8?B?Y25kUXZNVnBFcU4zV2d1VFJGUitoS2IxMlhzRkFvTzgvUWZQbmRNUEU1YzZZ?=
 =?utf-8?B?S0srbm54aHJ2UWFhYkk4aE9NOEt3WWlVaW5FbUVRck41SXc4SGIzbk5FOTU3?=
 =?utf-8?B?djNmbVB6amp1d3hvdmRGb250bGtOdUl4bTVKcjBUemRvUFJCN2RPcUFWVDcx?=
 =?utf-8?B?dHc5cndJWFNLTDl6bjhmTG9ibUJpMCtkUDFxemg4OW1RQ09GSzUyRXlVMnlY?=
 =?utf-8?B?TlZ3ZXdNYzZFd2o3WUVkcjRGL2xnWkFoZFdVbXJySi83Sjc3dFRIY0l3eXhr?=
 =?utf-8?B?eGQ4OWFDVkV0ZURiT1gwUThNbWRNOTRKZTgvS0phd0RmbWU4blcwSEp1OGV0?=
 =?utf-8?B?RTFXTWJrc0oycS9TWURQdTN3cEZ2Z2pXbDVDcVJEQUIwOGZwNFp5d0xxaEkv?=
 =?utf-8?B?TUdzVERxR0lDNHg3aWN1SVdXT211eGhZbWFXTERPRTNEQkpzTm5QRStBT1k3?=
 =?utf-8?B?VEJkSjNCd3kzaFVBcmFDZ1NMc0dVTkNJV3lvTFBOandYT3hiUllrWUpIZEIw?=
 =?utf-8?B?N0did0ZGeG4wcjBHSHF3bkxDOHB3ZXYyRDNTR2FnYlFTZjJhVUR1K3M2OUxp?=
 =?utf-8?B?RnZsSStYV0tvbi9VNFh4Q2M0SThPbkdBYXpCM2FnRkZHVUFpMGx2dE9sbnZD?=
 =?utf-8?B?TXVFMTd3LzIveldBZ21iSnk5aDJaZTFxRlV0V0JRNkVKbTNmanR0cFFjV09P?=
 =?utf-8?Q?iiQwGXjLzUxeAgfJF1B4bc8Pm?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ce39f5-4141-4544-fd8a-08da8c968c63
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2022 03:52:26.0641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7KOs/r//+7MJ7T8zrgfPeeDKLulQZU64R1l0vnrPCdR0ujXIFhvpEkmGXebnIx+pIJEeoLZZZ1X2ofn2E8fCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 01, 2022 at 05:00:58PM +0200, Daniel Borkmann wrote:
> On 8/31/22 5:19 AM, Shung-Hsi Yu wrote:
> > Commit a657182a5c51 ("bpf: Don't use tnum_range on array range checking
> > for poke descriptors") has shown that using tnum_range() as argument to
> > tnum_in() can lead to misleading code that looks like tight bound check
> > when in fact the actual allowed range is much wider.
> > 
> > Document such behavior to warn against its usage in general, and suggest
> > some scenario where result can be trusted.
> > 
> > Link: https://lore.kernel.org/bpf/984b37f9fdf7ac36831d2137415a4a915744c1b6.1661462653.git.daniel@iogearbox.net/
> > Link: https://www.openwall.com/lists/oss-security/2022/08/26/1
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> Any objections from your side if I merge this? Thanks for adding doc. :)

There is a small typo I meant to fix with s/including/include below.

Other than that, none at all, thanks! :)

> > ---
> >   include/linux/tnum.h | 20 ++++++++++++++++++--
> >   1 file changed, 18 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/tnum.h b/include/linux/tnum.h
> > index 498dbcedb451..0ec4cda9e174 100644
> > --- a/include/linux/tnum.h
> > +++ b/include/linux/tnum.h
> > @@ -21,7 +21,12 @@ struct tnum {
> >   struct tnum tnum_const(u64 value);
> >   /* A completely unknown value */
> >   extern const struct tnum tnum_unknown;
> > -/* A value that's unknown except that @min <= value <= @max */
> > +/* An unknown value that is a superset of @min <= value <= @max.
> > + *
> > + * Could including values outside the range of [@min, @max].
              ^^^^^^^^^
              include

> > + * For example tnum_range(0, 2) is represented by {0, 1, 2, *3*}, rather than
> > + * the intended set of {0, 1, 2}.
> > + */
> >   struct tnum tnum_range(u64 min, u64 max);
> >   /* Arithmetic and logical ops */
> > @@ -73,7 +78,18 @@ static inline bool tnum_is_unknown(struct tnum a)
> >    */
> >   bool tnum_is_aligned(struct tnum a, u64 size);
> > -/* Returns true if @b represents a subset of @a. */
> > +/* Returns true if @b represents a subset of @a.
> > + *
> > + * Note that using tnum_range() as @a requires extra cautions as tnum_in() may
> > + * return true unexpectedly due to tnum limited ability to represent tight
> > + * range, e.g.
> > + *
> > + *   tnum_in(tnum_range(0, 2), tnum_const(3)) == true
> > + *
> > + * As a rule of thumb, if @a is explicitly coded rather than coming from
> > + * reg->var_off, it should be in form of tnum_const(), tnum_range(0, 2**n - 1),
> > + * or tnum_range(2**n, 2**(n+1) - 1).
> > + */
> >   bool tnum_in(struct tnum a, struct tnum b);
> >   /* Formatting functions.  These have snprintf-like semantics: they will write
> > 
> 
