Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B885B81BF
	for <lists+bpf@lfdr.de>; Wed, 14 Sep 2022 09:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiINHDx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Sep 2022 03:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiINHDw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Sep 2022 03:03:52 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E03650704
        for <bpf@vger.kernel.org>; Wed, 14 Sep 2022 00:03:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcDSmo4daj+NAuNIdP/A2Kd3sNSl4KGw45QT5kgvdLECCHAh+BVXBIaenqH2lEMcNzy/YAqVtS5VP2VB3wtjm576LbWsqr27UU5WdnkYiHB4lzOLRot+iDqQQ3vK3yEHKyjhrTZx0eVqkuiZrXv2qXPtRr8/8aPbhwBjUByvl5FEX6unrZtX5M96XFu72gAFZiJ2/2+o2XPeG26sj4gmdRiNYoybcxEdKpHH1S7rvln5hgLolYZHaoQ3FK8/obHB6N0t7cTkrZenLa17ncV7QT1tsOsggXHglv/QpU1HlZxF1xmwqHTcRSBWB7a+9EO8RnRZcQPF6+qUgMqaeGKAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adHVNwyTJobiAs6KjAQH5hFW9mbKidKN9UWpHZKIivQ=;
 b=NUW0P8Ohlcmie9vpTp5fncZjJvTd9dM4JsI46A24RSd9yA0VB7vaxWIjERk+QnPitGdgk5zw65YwhuYluFSwGqMg5n/fAPsnnP6Z/BZsS1OMVpyfAkwNq/gAz2GjeilwSVkzx90j0X74lSY+enAGQsp1+m9d+pK9h3XXOnK2q/K1Ja/piwpj0PuKB7VaxbLqGL0uenXoFiwPxWyB2VmkS0b3fb7jElCc+w6ZABfAoUU6F04nAne5mD1fwWC6MtMHfFl5Qa89kWkcqYevsMxrr6mzqy7mcw0IHDU7flgJR47CLjiGsr9mGzYjGorpzv3tmD7yBNRa+2QIrk7RWoe89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adHVNwyTJobiAs6KjAQH5hFW9mbKidKN9UWpHZKIivQ=;
 b=G0I//QUHpFKRr6oUOifjrfPh7Czrj8UREoiTyNXVnByoQXNa+fuUQYD89XBMgmOWh886fEZRTtybm+Hx9UejuA07JVLVagyxwnazpdwsaKY+xK3F3asBj9++exkVoLl5AYXWorruT+CQ3LpL8E2xLdC+814dcQt4xosuvzzeZ63D1LbSkb18q6wD9rlHfX9VEVphh+DeEyZITARpdbaH8BZqf83Iapa9PhFX5FCow3IgxTzS2fBV5xrDCwA4qG+YuGiKaCRh8Gy7KUtA+NmB0Ta4cl0oPX2q6QPYQ4HJqtk1rT0UVJNcd4AzCjspYdHPCYFVabw2mvDHu2I4Cwt6+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AS4PR04MB9481.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 07:03:45 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::9c5d:52c0:6225:826e%6]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 07:03:45 +0000
Date:   Wed, 14 Sep 2022 15:03:40 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Vincent Li <vincent.mc.li@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: differentiate the verifier invalid mem access message error?
Message-ID: <YyF8zDF8of/O2YUu@syu-laptop>
References: <CAK3+h2zZQ4zEB55Bn565Xf0okf+Jotmo6qHYmzpoJPBcFWPP0A@mail.gmail.com>
 <CAK3+h2y4isKQQWFY9dnEq86a4BRG1zr5nEveyKqFyVvYaRrPpw@mail.gmail.com>
 <YxlmpEzm/ZDFTjKE@syu-laptop>
 <CAK3+h2won0ZJqmJZd46RfmnHnLSaqDc5+f_FuHxn8fpD6khKjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK3+h2won0ZJqmJZd46RfmnHnLSaqDc5+f_FuHxn8fpD6khKjw@mail.gmail.com>
X-ClientProxiedBy: FR3P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::6) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8107:EE_|AS4PR04MB9481:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5060c3-ed21-4cd3-89f5-08da961f43e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vHzT8l/c1JgaY22gCJyVngdpbqZ83VUWvr8q4VrCpVkC+gGZjQbucS8yOVBn9030NtOBUDnbgP7GFqnAjSdyFEPPqd8bAL741DjeI64JTdHTX8ipnCwxQED/lTLmnvUl0FU7SemaanUhOfevEAUUzRSi/w2xwKN643FBXNK8Win+8ZxbmChtJ+bR4CYRox5KBnP7cDwkqCZ5BMg+A+/d3rz7CFVUlMY1Wf06QIkNDJojpF8i2kzld9nE1puCrpSJNJhKRbt4GgJ9YQeWzk5SC4Ys+X54i0dWC0NaL7WL1c7KTqo3gDUqPk8/4S/f0L6c1cHaRhZTAYz+DjzXJkjvcIDp/xJ0JdNCA7ihne4vEAEyMFA+xeMPLCdWSQqOD7YYfBSc8k691/AeXKbsmYzOz2N7TewnYjhz8RFDOo/WWzejZzr/E1hPbwDopKakkyLyeK3gMRxpo/taUhFr3Z7p28iNuDpDVj77xcaVILSQag6oXiSAeDeSsmh8d34L7ASxpqFQTJWTtzfdulqObQ1b/fQHEEXgiFo42LgUIlGVE+4uAAPIF4lqKDVmtvBm9JZ1v2WZqcCwTeuAVtOANHYoXOW8mJw3MfETVFV4H3Ck2xrtXxOwgQIDsuDotT826XsKoKlQPj2kgCzYtEOtQJmw06LIRw4BnzRm4RnvzZ6x9/svbOIz9e0C/MyNRffpC5HQV94IaSLytQaIyJHnF6L4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(186003)(86362001)(33716001)(83380400001)(38100700002)(5660300002)(8936002)(2906002)(316002)(15650500001)(6916009)(8676002)(4326008)(66946007)(6506007)(66556008)(9686003)(41300700001)(53546011)(6666004)(26005)(6512007)(66476007)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2ZkSDIrdlJlMGptdlpIc0x4WVFmMmhQeko1ajJxUExISG41Vng3UnVoc3FQ?=
 =?utf-8?B?N2tJS2l4Si9td2d3aDVNS1YxTnY2NzhFU2l3WGJ2eXBTd1VrNHFuL2wrVU82?=
 =?utf-8?B?TGVQOFhpSnJ5K20yclVZMlMzZzhkSlBuYW9NVFUvQkFvNFdzYWVaSEtEQXRI?=
 =?utf-8?B?RVlzQmExTGtiMlVuMTJ6SENmcXhYdy9Rb0t2bVFnbGtESEU1RWxZeHR2bVpn?=
 =?utf-8?B?T1NOMk5HZTZXVTFaQTNVYzc1ajZkUHhSd0FkM01lbmF5TzhlU1NPbjRFSnli?=
 =?utf-8?B?bTJtODN1K09aanlVYlZSKzlkbExDdDUvSE1CUDVLWkN5S2Q0cXg0NnYzdDFD?=
 =?utf-8?B?bHhHcVN5QTRtcEtSQ2w5L1BNcmNSd29LRStWeTdlNGF6N1N4cjk0dXM0UG1Q?=
 =?utf-8?B?VW5aa2EyMkZuSVg5U0J1My83NFc2bVgyaDRVNlBtWjJ2bHFKR01BK0ZqeXFK?=
 =?utf-8?B?WkJrbm9Va3hRK05Sdkt4THVwM1ZFNkVzem9VdFM5SzRjaEMxdnBmaGhoUzBk?=
 =?utf-8?B?c3g0TVpub2tCYW95OHhUdUxCWG12dktmMERxci9IaTdxYlhSdHdkbjFRMEFs?=
 =?utf-8?B?UkpQTmp4Y0ZsTDQ2QVJaaDF5Z2hKQnBhaitKbllzWkxiY0Ywb0tEMlZ4eTNV?=
 =?utf-8?B?WGM1bkt2b1BUdDA5clFUc0t4a1B2QllrWmFNUWkyVjh4TlFMT1lKUXIvTFVy?=
 =?utf-8?B?bmZvNGtMQVRYWS9RMk9ERW9nTXBibnlOT3EzbjJzcEpscm04MURBenljKzBj?=
 =?utf-8?B?d2R0bmRNTHRLSWZyOWhUZEJLT0pyQXYwSFhxWG5jUHdzby9vWEpEakwwVnNJ?=
 =?utf-8?B?bG40UXlkV0VVTlArZFU1UnFnSHY2dkpQblgyT3oxaDgvWlQzOCtwTnYwMDRn?=
 =?utf-8?B?UkdxQUszeG9ZQk9SMTZxLzZCN1Y1azJCZEVGa2ZibU4zek1RL0pOZXRjMUF1?=
 =?utf-8?B?Y0hLSlg3ZEFWbHdFRzV6RU8rQlNHaTA1U3JIcTNZWlpDM2lxMTFZbU5aUjZT?=
 =?utf-8?B?R21oRlhsL1VMTTQrS1hjZXJmQXkweHpXS3dZNkxOS2g1UTFQcnM0Rnc3emU3?=
 =?utf-8?B?N0xaNGQ4WVgrM0tPcjhVK2R3c0t5eUtRL2hLS0NUa1NMcXVLdGk4cStuS29x?=
 =?utf-8?B?MUFFK3NJaE1YVXRtbExqR1daSmxYZ1lJb3VkcmZ1dEhydlVuTTZRVkZpOU1U?=
 =?utf-8?B?N0hXYm80SW14dVY3a2hjdXIxMHR5RjVFTnVwK3dCNmNnZU50aU1lR1FDZXhD?=
 =?utf-8?B?MTR4OWFpaHlDVHJLaVdSQUQ5VXFBTVpvbE9aWXVYU2VuQm8zOVluMldrWFRZ?=
 =?utf-8?B?NjZUWG1HWlJNYkpuY1NnbkduQjNVRU5uVENWcENYMHowdnkwTjkyeGtoVHpX?=
 =?utf-8?B?SG5EZkNFd1A0R3lCOEIvY1BKRllhUFZ0V3htRmlpbDVEMU1JOUpNS3p3bzda?=
 =?utf-8?B?ZlFjQTVQTC9xN2FucEl0WjFSNytwQlczZTFJaS9vRytPcmRKZDlYZnBvNkk2?=
 =?utf-8?B?cEdwM2pONk1malRBekFFNjlwMWVmUHBTdDF6OTZtamtwTTlKendhNFJ3Rzhj?=
 =?utf-8?B?QnVvU2JNWFR0RHY0MnRLVkZkemIvbXUvMjhPVXVodGVqT0M0a3dYM0JncE9p?=
 =?utf-8?B?Szg3dUo1K3J3bEF5NGUyd3JnazBzS0p5czBwTnVUUTNkVTU0RjFmN25wcG0x?=
 =?utf-8?B?d1dxVXg2V2g0Y3dkWnlqNkZzaHpER2JHaTF2Rk1qVXN5bmRkQmVEdVVTSzEy?=
 =?utf-8?B?QlF3Um9KK3FGZ3dkQmdzbC9kRFArcjVJMmU3bWh0WnFGTndMQzlUajdUUDhG?=
 =?utf-8?B?Z0R2aGpKRlJjT2dSU0YvOXdKVDVOSXkrelNqN0dPWEk5UitwK3FaeTlYNXdj?=
 =?utf-8?B?Rml3Wi9WQjk5cWlZYUdWNWJvcXpTMTFiRWRVdnFTUURERm9Md3ZtbGZ1bVJs?=
 =?utf-8?B?aDJFVFk3VTMwR3FFdUlLajlqNURpS3YwdDRja3lxL3UvZUUrcXJiWER5UU1X?=
 =?utf-8?B?STQ5LzV2bDMrZm0xTGp1ak56TmxyWTdaT1Rkdjh6Sy9Mb2luOE1UeXRFeTcz?=
 =?utf-8?B?SXFMYUFZTld6bURodEFIV1FDNmtINWpWZHNPVVhVL1dRcmVYY25HbzdGRzhF?=
 =?utf-8?Q?hGDtklD/VlvR3U0nzzGrZhcq1?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5060c3-ed21-4cd3-89f5-08da961f43e5
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:03:45.5802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ne7j8khaTcpzO9A3W4CJF98qmVl8NrxLaFGeYS5QFWKnvSZB9rBWyOoaiPnRDrAGpSZb8I1UYD1EJ8JiffAkoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9481
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 08, 2022 at 09:24:19AM -0700, Vincent Li wrote:
> On Wed, Sep 7, 2022 at 8:51 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > On Wed, Sep 07, 2022 at 07:40:55PM -0700, Vincent Li wrote:
> > > On Wed, Sep 7, 2022 at 7:35 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > > > Hi,
> > > >
> > > > I see some verifier log examples with error like:
> > > >
> > > > R4 invalid mem access 'inv'
> > > >
> > > > It looks like invalid mem access errors occur in two places below,
> > > > does it make sense to make the error message slightly different so for
> > > > new eBPF programmers like me to tell the first invalid mem access is
> > > > maybe the memory is NULL? and the second invalid mem access is because
> > > > the register type does not match any valid memory pointer? or this
> > > > won't help identifying problems and don't bother ?
> > > >
> > > >  4772         } else if (base_type(reg->type) == PTR_TO_MEM) {
> > > >  4773                 bool rdonly_mem = type_is_rdonly_mem(reg->type);
> > > >  4774
> > > >  4775                 if (type_may_be_null(reg->type)) {
> > > >  4776                         verbose(env, "R%d invalid mem access
> > > > '%s'\n", regno,
> > > >  4777                                 reg_type_str(env, reg->type));
> >
> > While the error you're seeing is coming from the bottom case (more on that
> > below), I agree hinting the user that a null check is missing may be
> > helpful.
> >
> right, I think the reg_type_str will output the 'nul' string in this
> case if I read the code correct.

The reg_type_str() output should be "mem_or_null" in this case since base_type(reg->type) == PTR_TO_MEM and type_may_be_null(reg->type) == true

static const char *reg_type_str(struct bpf_verifier_env *env,
                				enum bpf_reg_type type)
{
	static const char * const str[] = {
		...
		[PTR_TO_MEM]		= "mem",
		[PTR_TO_BUF]		= "buf",
		[PTR_TO_FUNC]		= "func",
		[PTR_TO_MAP_KEY]	= "map_key",
	};

	if (type & PTR_MAYBE_NULL) {
		if (base_type(type) == PTR_TO_BTF_ID)
			strncpy(postfix, "or_null_", 16);
		else
			strncpy(postfix, "_or_null", 16);
	}

	...
	snprintf(env->type_str_buf, TYPE_STR_BUF_LEN, "%s%s%s",
		 prefix, str[base_type(type)], postfix);
	return env->type_str_buf;
}

> > > >  4778                         return -EACCES;
> > > >  4779                 }
> > > >
> > > > and
> > > >
> > > >  4924         } else {
> > > >  4925                 verbose(env, "R%d invalid mem access '%s'\n", regno,
> > > >  4926                         reg_type_str(env, reg->type));
> > > >  4927                 return -EACCES;
> > > >  4928         }
> > >
> > > sorry I should read the code more carefully, I guess the "inv" already
> > > says it is invalid memory access, not NULL, right?
> >
> > The "inv" actually means that the type of R4 is scalar. IIUC "inv" stands
> > for invariant, which is a term used in static analysis.
> >
> > Since v5.18 (commit 7df5072cc05f "bpf: Small BPF verifier log improvements")
> > the verifier will say "scalar" instead.
> 
> Thanks for the clarification :)

Your welcome :)
