Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CC85B130D
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 05:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiIHDvM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 23:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiIHDvL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 23:51:11 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B2C7A74FB
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 20:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7ah2sSc5VDSwkFRYbF6V8ebQCulkcuuZS+nxUtEVZi/4KySHZecw0RV2mNiFTe2JY6OqA66XiyK9ugN5ddTXOTsTHqnrJrGSRBwyIzb9KbZWIf0/70EDGqfQyaFLA+v74a344NcdVA0EpRnwU9l9p4JZxcwVKSSXOkqpdPYi9H00blGaJSrO1CDeEVRPcNHNLh/2bCBB7Rxp2paSUsVXKeAfBVpm9/19Ok6pegwj6MHJS3DpQ/7hbKXrDvp4V0WeBbu6o2602Lqn7d3Mcepxe4U1q/lHPwGdNyiuLnHclTc+ZkKxivQ+XMSv+fYskvfnDhoQNDPcTHkwYf0hmXVlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkgsJQDVDqW47JsKECTTj/F/yBCsQO325Y96QwIpjg0=;
 b=C2yveqq6zwC4UWq8YOGVjT8hKMYDi4TSBCjkq3YD7/VoYPC9MPnnsQZhI2pv1QgV5eWtFQd7hcBtuu/e2zbcTs3B9OtmKo6CaRT/JswZ/XaOu0pnN9+TbBdD2DYSVChjGYYAZ9ujrHKkFNQUOCA/1ra3O01RZaPh/tyiOPtzZpbD1tgUU8HiiVB8tvFQPdK83QCiuKnD4HjvKNde4RUpTI1LkdpS8v/zfXEkTVvFHGES7H5ol/4XiEerhib9XUxtxxIyM1zspbmAhejXPqJwh5BkZ86CjYkvtNre56W21JrMQCTm9iacRZ+naASGudQpm85TikCeEX736tUHs3bFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkgsJQDVDqW47JsKECTTj/F/yBCsQO325Y96QwIpjg0=;
 b=NPQBvxTif9cYocjECNanw1JxvvDvOdn5W4/sQkBB39L5SQ70sZS74u3yOElL50+sM4Jw+4XSgAfR7ThwyeEOpAOI2h0cEcCIMBFWYecVIfEnPUOzXfMaecIpLMreOEoCuvB7AZz+jI9cDrciOIT349yu9s1K2rNlOcOvJ/AZ7zefepvBuDJHgOwaVRwmCJ1EL8+Iy+3gl1N4nmIED7+Y4L9f7lYemlk3kijtazC9It09X4kMedWHtZ35RIcOmMIc6WcZ74hq8nk6XVdNAdZgxo/A9m3pqxp97zeu3h7csiejXehaaFToC5e/1dZkDdC3VcaeaPbK4097s1QSqg5GZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by HE1PR0402MB3626.eurprd04.prod.outlook.com (2603:10a6:7:88::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 03:51:06 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e%6]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 03:51:06 +0000
Date:   Thu, 8 Sep 2022 11:51:00 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: differentiate the verifier invalid mem access message error?
Message-ID: <YxlmpEzm/ZDFTjKE@syu-laptop>
References: <CAK3+h2zZQ4zEB55Bn565Xf0okf+Jotmo6qHYmzpoJPBcFWPP0A@mail.gmail.com>
 <CAK3+h2y4isKQQWFY9dnEq86a4BRG1zr5nEveyKqFyVvYaRrPpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK3+h2y4isKQQWFY9dnEq86a4BRG1zr5nEveyKqFyVvYaRrPpw@mail.gmail.com>
X-ClientProxiedBy: AS9PR0301CA0047.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::27) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|HE1PR0402MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: 21be54bd-07a6-41ba-cf2a-08da914d5b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IIya8H0bg3Ib2lxakME3BIiLskBS2M/Zq66ptzCfkQ0iL4fL7t+I0sbZIBfDofV91/6oG6+kEotj8QePy2/xaCrvaLfRGiMNPjsB+b3lbSp+vZ9OUXYdnaJ7CO1CBaWLxj3ey9S4McpRqbne0hLf13r2upReWjbHsGF71brF2E6xdv1J2eTWVC890vtl6X3WZl4jY9wtIjH+KHNhs2csAG06PU70sDUrRucVpB6iV35FHc32uPk0ApaEOhl9iINZsFc7+HTUsCW8flMgRiaw5/JCydyudMds0cTu/omeMXpsXzKYOdOQYKWPgwutQROcpccGiWazTm91nQA4fsyBKpaneHmRx+z5Yo9f0Z1yIvpv1mC1gEFQJys4nB+jGxd6a7NRNs2vVuqSaI5ck686L+GJ6YpJO2JZYdNtvqKraRJfsh099kSURvgDqxPwmLV0SkMfo0qG17uA914kwX5a1l4YX4v/3Cn7ehFXzj7yUwwKSzwzxRu9lN8/HoOraBsHUG8F859RM+Qm2o1KXPU0LqAQhmIOZaVwd/O7VGcs5GBN6n+fBImN7Oij3VmItAENzIp8NfFP7sZef+IZVWdn1Y25zgzUdj83s8prik0+EqRiFlpyxQVRxOYGltMYCD0WGdjF6Ii5RiXqWCKqQlzUGeZ0u+2ePKC+wyDyaeaonkwirskY08d7UA53OVDdyt3EUg9ts1HvYB7a3Nr2ifmWtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(376002)(366004)(396003)(39860400002)(186003)(38100700002)(8676002)(5660300002)(83380400001)(8936002)(66476007)(66946007)(4326008)(2906002)(33716001)(6512007)(6506007)(41300700001)(9686003)(66556008)(26005)(6666004)(6916009)(53546011)(15650500001)(478600001)(6486002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkNQTVRkeSs3OUpISjEyWXAzRkdjNjdiMjExNW9FeDJidGIxSThYMnVjdGFS?=
 =?utf-8?B?R2d4aTArWUxnSkI2T1pyOXFGTXpyVm03c3c5TW5CZzlBOVFmSE5XVUgrSFcz?=
 =?utf-8?B?SkViOVF6eld1eXpnNE1GWXpQcmV2VzVzQnR2TGVOTkxzSk52QmdOK2kxTURV?=
 =?utf-8?B?ZGFiRnRxTVBzVTVqK2N3MHhLN25nb0lyVUM4dm83QnhkL0paVXp0N29lbHcr?=
 =?utf-8?B?ZCtJbE9qa0ViQUg5WnhnV1J0S3lWUDRVMUZHa2NGMXRuRDVXdW5kQis0SFRh?=
 =?utf-8?B?QmZWSnVqVzVJSWl3bjRiYUFHeW9VWGdreFA4aXdhd0xSc1ZHMTh5RlRQNWZC?=
 =?utf-8?B?YytaNmJVcjV4QWJkNTFYVjZJdm1rR2NxQWhYMjdTWDY0Z05ka2tlVTBIUkxH?=
 =?utf-8?B?cncrMG5MRVVLbERpSHNNcFpBd2hlbUMzMjF3SEJ5L1k2MHUxRStkL01UZ2g3?=
 =?utf-8?B?aHBHTFNZMUlQQlN5dnBDWkhHK1NhMnkwSXQzakFPUXlMRmo5NzByVC8xQUR6?=
 =?utf-8?B?aVJ6MjFaUjgveXZ4QnBtTHR1RHkxVGZZMDc4Rmd3MmNqb25oUFFWYWRjM2FY?=
 =?utf-8?B?bGR4dDJFcTNCelhvQ1d3cFJtVlU5L2tTbDNHNDhtT2NKVmhYa3JIQzhPSlEw?=
 =?utf-8?B?UjhWbkhHSjl3ZERmQUsvRmxDcVkxeittUnF2N3JQL1N2dkcrS1ZXdjVSVFNB?=
 =?utf-8?B?T25mVUorWUVIeG1HSXQvKytjK3RSL0VJS1N5bTZUNFFyTlllSktoN09KVlVh?=
 =?utf-8?B?dmdVVVdtK0IyZ2ZpZjd2VzZVMkJGWFNHOTAzWFpsZEhkQkg3ODVjc3dsRGRx?=
 =?utf-8?B?WDdsSE5Nb2gvbGdXS2RSWU5UMEZ1ZTVPNm9JVW5hNGpSdXlKRTdSUlEvanY2?=
 =?utf-8?B?d0loTzJ4Z3pSemFuUVVNeDlqV0Nhc3NDM05UUXZlYWh3OEJhcWtYUnNIditH?=
 =?utf-8?B?ZUJKSTROd0FDcFZWMnNsK25PazFXSDVrQ1dLcTI1SnRZcms1dTBmdHFPcjd1?=
 =?utf-8?B?Q1Bxa212dlBVWGxFa0VXU0JFMlArb2tWa21zUGt5d1UzdUwvQnlmajE1SzRG?=
 =?utf-8?B?ZjllUUlLdmxMc1RxQzJWUTZadkF5ZWpndlowSUNIU0FDcnhUSUppbVdscDZ3?=
 =?utf-8?B?dStXRFgzTFZjcm1XQzBxZmo2UjVsUkhlT0FaSVBZZC9ub0M3RWpCdDU4ZE5X?=
 =?utf-8?B?eEFjY0MzSTZ6YjRJVmVHaVJvSTVpZ2Znd1pvQVdXTnhXaEdQZkRkQUJEblRS?=
 =?utf-8?B?VDE2R1lNK3VQNFBNaXd3RFpkd1Fxc05HN1NWOS8yYmo0Zkhrby9yZTZKNHBJ?=
 =?utf-8?B?Lzk1N01EZm1xaWcyaStYZ2syQmloVll1V1IxUGRoOFlKb0QrNXBXWDE1ZWYx?=
 =?utf-8?B?UkZmeUYvRkEvamp6V0VnVzdSRHRucWNabTNCYWJ5cWFtTWZjRERaY2tCc2w1?=
 =?utf-8?B?T1RGbnhOT1M3K1Jaa1RNdEJJdTJHNC9KVmQwRElGNmVTaGZid0NCZ2ZzK0lP?=
 =?utf-8?B?MmlyMWlsNUhDazVWbWJHdkJIZC9KVlNQY0Q2R08wc2Zjc21Gckc3cG9UeUNw?=
 =?utf-8?B?bHJmVGVBdys1MjliOTBrVysxbkNib0FmK1JORUdJdExhQjNFZlNQSWo1ditE?=
 =?utf-8?B?MlhNazBGbG1FVWtuMWdOOHJhREpoQVNzVkYxU2lFQWVEeTRGTUF0WTNRSUlv?=
 =?utf-8?B?RG9ld2Rwa01rb0xHOFRwV1pvNWloVEwrV0EzWnIrdGp0aDRaTXVESFByVEJD?=
 =?utf-8?B?ZkxyTjF2WXBtV3pGMXZMOEhuekV1MUZERDFMWmhmaHZGS1BjSnBiTmtyZmN6?=
 =?utf-8?B?UE80Sys4Nng5cFh0TmJkR3c1Rm53NE81TWpaZVpMTjdWY05nTVdPOHl5Vi9m?=
 =?utf-8?B?dWYyTjZhYjNoeHNVK2Y0ZUxzNzNGcE5rSElMdlhaaElIMHhSWjhJN0dVLzEr?=
 =?utf-8?B?dDJDU0g4VWN6cTlOTGNMUXVMcTI1U3QvSHFCMXRERFNGM3plU1loUG0zazBB?=
 =?utf-8?B?YTZzZzMvQVhqZ0tlaFh2bzZ4MWRIMTBHU0daZStkVzE0a1U1UUV3N05PNEJh?=
 =?utf-8?B?d3FodTVKQmtvR0l2NnJIbGdrbEFkZ1prazk4eXNqRmF2UmpqSFl2NXpmUFhr?=
 =?utf-8?Q?xGc+qMdtozcmvkl83kKWAcRd0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21be54bd-07a6-41ba-cf2a-08da914d5b61
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 03:51:05.9553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j7s6HSeSXBCXdrh5Jj4iUlAG9GvYQLTg3HwAhAIUbSgAeCYrAdlnNCCBgIfPxz69kM7nF54HUEyY6nlN+dJgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3626
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 07, 2022 at 07:40:55PM -0700, Vincent Li wrote:
> On Wed, Sep 7, 2022 at 7:35 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > Hi,
> >
> > I see some verifier log examples with error like:
> >
> > R4 invalid mem access 'inv'
> >
> > It looks like invalid mem access errors occur in two places below,
> > does it make sense to make the error message slightly different so for
> > new eBPF programmers like me to tell the first invalid mem access is
> > maybe the memory is NULL? and the second invalid mem access is because
> > the register type does not match any valid memory pointer? or this
> > won't help identifying problems and don't bother ?
> >
> >  4772         } else if (base_type(reg->type) == PTR_TO_MEM) {
> >  4773                 bool rdonly_mem = type_is_rdonly_mem(reg->type);
> >  4774
> >  4775                 if (type_may_be_null(reg->type)) {
> >  4776                         verbose(env, "R%d invalid mem access
> > '%s'\n", regno,
> >  4777                                 reg_type_str(env, reg->type));

While the error you're seeing is coming from the bottom case (more on that
below), I agree hinting the user that a null check is missing may be
helpful.

> >  4778                         return -EACCES;
> >  4779                 }
> >
> > and
> >
> >  4924         } else {
> >  4925                 verbose(env, "R%d invalid mem access '%s'\n", regno,
> >  4926                         reg_type_str(env, reg->type));
> >  4927                 return -EACCES;
> >  4928         }
> 
> sorry I should read the code more carefully, I guess the "inv" already
> says it is invalid memory access, not NULL, right?

The "inv" actually means that the type of R4 is scalar. IIUC "inv" stands
for invariant, which is a term used in static analysis.

Since v5.18 (commit 7df5072cc05f "bpf: Small BPF verifier log improvements")
the verifier will say "scalar" instead.
