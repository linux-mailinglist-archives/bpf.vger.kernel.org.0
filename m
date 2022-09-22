Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70BE5E5A63
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 07:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiIVFAn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 01:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiIVFAl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 01:00:41 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE6EA61D1
        for <bpf@vger.kernel.org>; Wed, 21 Sep 2022 22:00:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Px6Ilvan6bXdyIywuqjAkKas/kXh4a/E74u7UH5qeBScQf8O7s9xaVkmJUkhE9uEzisQoPVkkTbsfW1LbKryte01eoIkIq8DBV5FTMq+RxE43ri+T54u03K6xqADJIQ6LNWP94iqzs8nSVKYrkGpfSryV7CDNfRXtzukXNBojOGi9Jc2MqERZ4IgZB5wOPtuCIxnSoi9fs4kP5spag7GvHvaXCccK6vuP7Sp+7H4GvzHK6T7hCMi4urXWphOUvLokTNwJBwDCA0OIOPk+pO7rafMwSaygdyGoOP326MQ0ZYgr/7s6lES2oqV2gW3kVSTS1243OTtya52iP3rEKJEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDB/QL1PNQnueFV7YnqrtBzDidQcKw22tnb6Ymg1Rfg=;
 b=bXl+MO3EK5bDAaX473TU70zP/patCer4YSpcxkY0vml+n0/ZPcsSj1fklTMCtK4tkXwkXKK+lm8MWOW0JWf1D19Azkzm+BiCGmLtfynQERl90O5k8K3IrI0MFBoCecvaC7CCQ71r6E/q6lwrTkxuY6Tnjs0oYkg/WxKXP86X+k7g5Rn48N1D0nVWM5foHOeJyPCzlETTsat20dKnRzGFksYkca3qipcEAZJub9YuiDCIaH1eATD6y5V1HlBLV/pY4BuFB7SgjfZGZFr3LtwAyiLRHyqxz4Z4sxVJmxEzRjtXYvxXk6w3GnszJ4COQtVy/MeiKiRZovmTmSBAeoskFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDB/QL1PNQnueFV7YnqrtBzDidQcKw22tnb6Ymg1Rfg=;
 b=vPzmuM+m1vRFmmD6WG7nJIlaAXs0d+Lvq2BbvvTQNpUD0LeXYIKRj9UhajASE7awYaFeLi1aLaPNswPwF1BSpkqFx2yNi2KE0jLxBosDb18CWn3EaFwtGngPcM0y83uK8tqghjYr2/QOJEIEaJIHOqcWGPYbykXX7GIREM9umXH6DtJxcTrW2xH3AZsd2Dz+KlcjN6CUiTJEUHDb/ep47P75Egv0alL+6eLt2D+4B1J0gJMbxm1rCe8S2pcnFz7dH/7foSW44Q0VpslPGRv1e0134SU0bVaAnjR0wTVJzOmUD3ZhSBne3cadteW4TMgDoFVv5KTmzBdTay6Qg+yBZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.18; Thu, 22 Sep
 2022 05:00:38 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::50ef:4600:41bf:b51a]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::50ef:4600:41bf:b51a%7]) with mapi id 15.20.5654.016; Thu, 22 Sep 2022
 05:00:38 +0000
Date:   Thu, 22 Sep 2022 13:00:31 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     bpf <bpf@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: Rethink how to deal with division/modulo-on-zero (was Re: FW:
 ebpf-docs: draft of ISA doc updates in progress)
Message-ID: <Yyvr7z5kTFY2Gc9w@syu-laptop>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyFzO205ZZPieCav@syu-laptop>
 <YyihFIOt6xGWrXdC@infradead.org>
 <DM4PR21MB344020798F08A9D967E70719A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
 <CAADnVQ+bRxDkSWnx27KRm4mC3QrmPO+UyiA5VrjHNMQqeVYcNA@mail.gmail.com>
 <YyrMpAPJrP851vE1@syu-laptop>
 <DM4PR21MB344078B626F92E3476090082A34F9@DM4PR21MB3440.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR21MB344078B626F92E3476090082A34F9@DM4PR21MB3440.namprd21.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::6) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|AS8PR04MB7494:EE_
X-MS-Office365-Filtering-Correlation-Id: ef18dd56-7bbe-4627-da75-08da9c5763ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CT/FbNOCksD+z3fwl32TuYR5GOD7wpObrKK+4PTB7ssHsK6AaZxcp4oZAO+ycYPOhUiu90uYkY07/3rJL4demMe1TBxvVpu+jPnTNBkCdVd4URuE2o8nLcHCMJZGhbAHnyXVWiFAW0Ro/N4xi3Buf1wKLvMp6oXapTOUNxG7KLhR3Y7rNpDeawEHhtZprFO/ATYxve6o9wgpoCnPuJ6BLHu9YexlalB2lPpPo+aKetOkODdHcaCWAxNPky8sHdmX8KT04povlBAvIXVmzF4j8Fx/3MmsExwnf4xWdxIhrj9oH90V4LFsgVT7HH7/NRzQ/1kv4H/PirfjVmO5fDG0mtMGm6GXcaYUr30l5YrVzztVT941oA7aqESqlAX9EVxqqp8k0+mvNfGVI9aDZ6wYSUdcOv2xfVusFpo0DCZJhUZAd+Qf4dOydZAVppGmbCt5CPNtyc2K3pD154jTG3D/4O8dibC5qaCHhaTCXj/tPAIPnmYAkSe9BJvsUToZ0p0smmec0Lhf+g6FIO+nOIzIaqA7Wp5Kd+vF3aMsv/yOiaPnC4BFinJqN45pcaPAEdAp1ccvb236RgMoWgRR4XHnQclgR+lsmx8bgwFJvnVOsjdl1Q4mcOmScVIKViJDMA5KNm7Q5EzGzrr6kh0q58NfF8Nifc6kZNxb43TJr1LA5VpjRCIr+PeOTlPsxWZBFfYQMfcrTJ/zMRKFiOKjcFNlkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199015)(66899012)(66946007)(66556008)(66476007)(83380400001)(6506007)(8936002)(5660300002)(186003)(316002)(54906003)(6916009)(6486002)(478600001)(6512007)(9686003)(38100700002)(6666004)(8676002)(33716001)(4326008)(26005)(15650500001)(41300700001)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGlkeUF2UWdrdnQ4dU9lMVpZbWNaTW1RMFdBekNleGJsakI3dndiOFZHWHk3?=
 =?utf-8?B?MlhRUGhDaHNJZUhybU5yTUJHa0VvWWtzVnlBcW1SRXJ4U05yMGdWMTlZb3lK?=
 =?utf-8?B?cTlnQnM4cUxCbGxoNXFTSlF2YldzWExJM2kyYW9EWUFWbXMyd0dVTndkUFV2?=
 =?utf-8?B?UUUvWm5rOHBFTzJPV3JBbi9ERjJvOHY2d3U5OU5FTjlab3RUZUlzMWN4M1Jr?=
 =?utf-8?B?c2k3UFlVWmF4Zlp5Y0xhRFFyMFJ1c0FscTB2Rkd5SllLVjkrNDBLUVhPQnZu?=
 =?utf-8?B?OG44TG5UQTlhSitYSkpBRTNGNEpiY3g5L0d3eE1aZHo5UkJUZ1h6Ti9JNmJq?=
 =?utf-8?B?b0I4ZVRoRDRmNGtpVXo0WTJjNTlHdWRvRTM5TldvTUpya3RmcGNrc1pTbndH?=
 =?utf-8?B?SlkxWE90b1JLU0N2bzJlYmx0SDhnbDRWUTd4TmlYbzBsNll3QXk0cUt6Ui9h?=
 =?utf-8?B?SmNjaVpqVnZkcnBYZ1FVa0l5R3Q2VDIwcWtiNUxOZzNnM2g1c1I5UEs3ZWRL?=
 =?utf-8?B?bW0yV0RRKzlOQzlzalBJUXVwMS9USy81ZVEvcmRQamJCWnppbVJZMDBUUUI0?=
 =?utf-8?B?ZWpuNEJWdExKV3ErM0xsY29KZ3N1a1o2cWM5Ri9CWnhZckY2RForMWZhOU9M?=
 =?utf-8?B?ZlMrTXJUellZREtKMkgzcWNqbW5xNmJkSDl6V3lWWVErMGU0Qm4zVHlqcVVK?=
 =?utf-8?B?b3FXUTVBNUpmOUt4VitaU2p2Nmt3NVZyblV4Z1J4bmJzMGxpWUhLYTdwOWVB?=
 =?utf-8?B?b2w5QTZSL0FreGxEbVBPanN4UEJKeWtvOUgrZi93YnhKQXFZaCtKTmVTdk9C?=
 =?utf-8?B?b1RpcDB1blNwNkhiajh5MUIyb054eWlrOEZaY3FBcit2MFllVnZ0b0RiM1lJ?=
 =?utf-8?B?bE1Jb0ZTRE43UmVBUEFnNXVtQ25yMmdTcHdmSEtsTEtZc3BMVWs4L3MxWmc2?=
 =?utf-8?B?SmM5VGxmZGRjV01hc3Fkd3QxM0YrMkhVRkVkVGowTktKMUwxeG56VEFXL0gr?=
 =?utf-8?B?UWd4UzFMZUJZOHliWjk5R0JFTWtvYUxEUW5aVEsxcUEvTzZSd1c2L3czRXBl?=
 =?utf-8?B?SjRpV2k0OHRaM0RnSHg0YmQzaFR2NGV3aVc2Ym1aOUYxUGttWFliNm1NQU5a?=
 =?utf-8?B?VCtLTyt3TGpad04waTAzWlBFN1FOeWQ5R1p5NUNLcXFqalVoOVlhclRIb2x3?=
 =?utf-8?B?eVdldi9ucGR0TFg4dFpZWlhKWmlRMmZoNnB3d0ZJTUxBTDBWU2pGN1ozOG1L?=
 =?utf-8?B?VzBiVlFtTm44YnlhNzVIYjF0T3hTOG9aaURnc3dqYnlLUUVPVTVTL3E5S2xR?=
 =?utf-8?B?U2NjVkYrZWdEQi9GaTh3OHh6WjNRY2tvQ3poNThFNFFLYzNaWmFSNVlqdisw?=
 =?utf-8?B?aVpIUHJrRDA2MlZCRGp5ZVdjTFg5STlUcXhHS0VZL3VmbFB4QkptYU9Ha01O?=
 =?utf-8?B?QkN2cDFvZ3dXTkk3NEZhelR5ZmRPanJXY3VITVpiOEMrdzE2ZnNZUU4va0h4?=
 =?utf-8?B?QjFub20ySzl6MTZNWTJLWXN4QU5zSWVhdUlPWE5wckZqOFNrcmNaVk5IL29i?=
 =?utf-8?B?WkR4dHgxSHg0cE9HbVJyUnBjRG1qZDMwTWh3Y20xd3lBS1BPalcrM2VRNVJP?=
 =?utf-8?B?QWRyOEtvUEVqazJ5Y2FVK21IQkF2NzNlTjl2YjRvTEpVTm92ejd6a3hoNjZ4?=
 =?utf-8?B?YTdONGRTUS9GcjRXUSszdGFjL3FFZ0hYQ3d2aWN6UUU2aGVOSHViakc0SXM2?=
 =?utf-8?B?dDJOeUk5UFZlTlVxSWg5MCsrbkJTNGQ2TmZyRENiMWltMTgzdjhIQmExdkpa?=
 =?utf-8?B?c3hPTVEyaWV6S2QvTUpnQW9MRSszZkhDSm8xMU5ia215R0plQ2pvRkNWSExS?=
 =?utf-8?B?S2V2V2pkYThsei9zV0dPNHpLLzNIZDNJZlhPWm5hekhHRjlsTEIzZDNjeFhr?=
 =?utf-8?B?aTBWQk1JdEw4NzE0TTJQTW4zcGpRU01MK1pQUk56bXZQY21SYjY5ZXpGaWlG?=
 =?utf-8?B?cFNqZlZqRTdPMzVKMEtUT0xYblArV21CQ0E0OG9vSzMvYU9SMVdOMUFCWlgy?=
 =?utf-8?B?VXlkL0R6S1pQa2dLMGk4MG1DcEUzaEhiNnJJMlhLd00yZnpqMjIwdThDVjIx?=
 =?utf-8?Q?mZU4MWg2mmg92tONIRMQjMvUa?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef18dd56-7bbe-4627-da75-08da9c5763ff
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 05:00:38.1396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z449f/FiTio/jOF7ixyawKzC3jz2dPEdpI1l50NkSqMl+ciid5iHFAip5Plzt6dcDv8K2ZVSQlgMESKVQiCRbw==
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

On Wed, Sep 21, 2022 at 02:41:28PM +0000, Dave Thaler wrote:
> Shung-Hsi Yu <shung-hsi.yu@suse.com> writes: 
> > Just like how BPF verifier prevents a _possible_ out-of-bound memory access,
> > e.g. arr[i] when `i` is not bound-checked. Ideally I'd expect a coherent
> > approach toward division/modulo-on-zero as well; the verifier should prevent
> > program that _might_ do division-on-zero from loading in the first place.
> [...]
> > Admittedly even if achievable, this is a radical approach that is not backward
> > compatible. If such check is implemented, programs that used to load may
> > now be rejected.
> 
> FWIW, the PREVAIL verifier attempted to do that, although it was incomplete until a patch I just submitted to it yesterday.

Cool, and skimming through the PR I'm surprised by how minimal the changes
are. Interesting to know that it's possible.

> However, when running the patched version, it would reject some cilium, falco, suricata, etc. programs that it uses as test cases,
> so my patch proposed making it optional in that verifier although maybe there's
> some better alternative.
> 
> Certainly I think a runtime should implement the 0 check itself regardless of whether it's rejected or allowed by verification, but I wanted to share evidence that your "may now be rejected" is demonstrably true.

Thanks!

> Dave
> 
