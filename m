Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F214152BE87
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 17:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239067AbiEROv6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 10:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiEROv6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 10:51:58 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B66E115CB9
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652885513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBfOknYXuzIRDw4ydMy4cIilsstHeSMXQQOFCqkTGzQ=;
        b=ZHlbqFQnZiftqS3MPZQ6hhAxbTNfRdb7R0jkJY6FC/naHIZmGZ6HJGpqtYctmszHb5MSH0
        fycpc/6G1xDAtq1NjOqI11X2NcO0owFQUZwlOJdKdHti2bO3WCWWTOpcSCVMPnpcj5rQoR
        58cMgtLNFwjq9m8ACodQdFinVt6//8U=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2050.outbound.protection.outlook.com [104.47.8.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-40-Xk9gXcKXMf6bUNxuW_QHbw-1; Wed, 18 May 2022 16:51:52 +0200
X-MC-Unique: Xk9gXcKXMf6bUNxuW_QHbw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b92VIhQPTacJ/x9+PHOBD/kswonDYertM5mwNasj4sm80bzI4Qb7yrt4g9d3+uAMRfod63XEbANbtHov0u59rJnyD5u2JBG2+OCzqlejtue03n3RjjhOjVqi/wJwUXkAbZD8Pd/7YjASi1EWOWfku8Gcqv1d2UYaAqLwAOmkWmgduMuh7axHQD3Yq02GUzkFiA1KkeAG1QfiirgPCbPtzCBUjMZgdxq/ZDYmAB4yS4GJyHOqIMsNjef77LNhqU+73YTmgk86LdC6HUuG5yofwjuCNk7FkpcHJZgMyeBqgVAlazonNciorZqnikYhbf29sNIiCQ7JqKeIJKpMulZ8aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mBfOknYXuzIRDw4ydMy4cIilsstHeSMXQQOFCqkTGzQ=;
 b=Rf/Ew9E3pToPdRMpeIS3BNQaXWfeDQt8YAVhUE0xX02GGweb12ulYAo6MHDFjOby3dokpA9XWAX1zq/KmR82SSjE3bfwEhEqHmM+l0fnBd501lfck4QVieTNMzafao22CIesOAfOhAxUpf0eOpypBXHZaL47LYc0e6nGIPj4C8i2Q5FgnM8G4dU8WsiFq1VGF4GfjNHaCBbluv14IxO4hYTgj4pOotm4VtvHw2e7c/mv9ng2hOyiIWvdCkvRt0e0C1Evc8a/D3fpa+7/S+d5PuQqtWKYQCSFBSVMOSzybTzW8rXJrT2xwUDeHAlm3ZWVSp2ghSVnOeInU4G9GHjAmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AS4PR04MB9268.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Wed, 18 May
 2022 14:51:51 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::4dc3:b12b:bd98:b591]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::4dc3:b12b:bd98:b591%5]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 14:51:51 +0000
Date:   Wed, 18 May 2022 22:51:44 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Vincent Li <vincent.mc.li@gmail.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>
Subject: Re: bpf selftest compiling error
Message-ID: <YoUIAFPYea86JvDx@syu-laptop>
References: <CAK3+h2zMMMir6_ut=fb7gGj0Merzsc9vksG3fmt9JazCvk2=WA@mail.gmail.com>
 <CAK3+h2z74LZ5OFQxNDktex8WYxpYhycQxaWt=KqqW3ZsTu1nwg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK3+h2z74LZ5OFQxNDktex8WYxpYhycQxaWt=KqqW3ZsTu1nwg@mail.gmail.com>
X-ClientProxiedBy: AS9PR06CA0309.eurprd06.prod.outlook.com
 (2603:10a6:20b:45b::11) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d244363-5cfa-4d90-7c64-08da38ddf14e
X-MS-TrafficTypeDiagnostic: AS4PR04MB9268:EE_
X-Microsoft-Antispam-PRVS: <AS4PR04MB9268FA03E98C732C5F753671BFD19@AS4PR04MB9268.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhSxDbVoT8JvJbYQr9lX1NVZ/ypw+zVGo3owgB6AQAx0Cg0G8//AYMLrIb/aPpE5eYSo8G+4wQJCPyXuYiLCDV6ETWiF8/qmxh5+j4NIOXFYngH7UNHyhkh/o1HG+N2sfBfW7avK4uLxdoio1V3y8qZojnbvDNPGtbykymZXN1PiPQZlgfAwSXQdWfnQOyMdkQzoeeWTP3En+nwLdZOPVJPom35y30K/flyqYZJodC1ouYPDzGdGzdZf7usiS79qwje12P8h/PxBEuwszakQNuxLr3kKc3ywaxVofooHLGtWQvMmMbFjwemSUmFJ93ld6xt7wLZiU9byFL/sffmUHMZKEJL/7g4yheWInnlGmAce0/+Qo6zi6xfGowDvGfHPLTcUfAecn00c2r6zdOdaIPkCjKhvUjv06zZhDWAg1zAte4ktXK5LLokYRU1J1o3BA8tpp7+Xf7ddKDRpThvCfYnha9uJly5GeQ7lmt4fU4+ybuOxnztFKDS09UkWnkCpQLMThwyP9tookX86iDwCVwsvqyZCwbjH/yYa4I0dFQdoVy5v0QXwVzj2yxV99Eb4OCvw6BoCrBlrNF+yNhY3UAV15kQuHlBP7fFWw9iXUSo6n50Df1P30nW3OJY2QQGDBSttUyaVRxMLK41lu1BeZsQhO6qCSn4/L4917X5KSIBLM+ihVR8qvMt7BzjLwQwAYKALu0JMYv/YEMphcWA5sHaw31qlnSmpgpMgXq1WKRM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66476007)(6506007)(5660300002)(2906002)(186003)(54906003)(66946007)(38100700002)(66556008)(316002)(508600001)(4326008)(110136005)(33716001)(9686003)(8676002)(26005)(6512007)(6486002)(8936002)(6666004)(53546011)(3480700007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Smc2WVlVcVhIOGhFQk1NQXZqWi9uMWU2cUF1WHBjNjlXU05jWXpNeFIrcTY0?=
 =?utf-8?B?NmJ2eHNmR3lZRkRNQlBBR2xCNU9xbk9wRmx4cVBpbWNpS1V3eEE3RTNqS3Za?=
 =?utf-8?B?Qk16YWRPNjNHNC96UERsRzg5d1o3WTNob3MrcmZYd25Jc0JJNTg1V0sxS3ZD?=
 =?utf-8?B?VjRBV29ha1hBRjQ1SCtlbTNUVmZ0dDl0NnhtQTdnOHFmN3JaMDdUOHNadmZY?=
 =?utf-8?B?YmQzZ2ZNbVd0a1llWmRCT0FoZFlzR29WQmQ3d3dLRWZkd2N5VkVFcEhTZjhL?=
 =?utf-8?B?QmVoNGJCLzZQMjh1MzFvSHAzY2xNZTJ2eUZSbmo3cmY5L3dUWGd5aUNhYStT?=
 =?utf-8?B?T3g2K0NuckJFbWdtOUFhTjBITDdQRklFTUkrNWJUTk5sd3lPaElUOGxLUEYy?=
 =?utf-8?B?MmZoRTh0SDVXcnJGVGlVbTVaZ0lvTHc1SXcweWdpZ2VXVHZXaytUOW50Q0h1?=
 =?utf-8?B?QmtaMFkrNjI4L3FLY0ZtVk5EUUkzRndiZ0Q0VXRlUk9XOU5ZTE96bGc1aG5S?=
 =?utf-8?B?MnMzNHR3L3E0TnlYaEhjMGJ5QitjSmxZaTc2Q0pFejNhTXlsYVhyeXR4bVQy?=
 =?utf-8?B?dTBKd3JnRDlIZjcxNzB3cUxIc2pzUG1ZZDQzeHM4bDZ0OHdBRFdFdWNxQUJR?=
 =?utf-8?B?eFFaZFJjQi9OZE9xU3dvbHQrUHFkRk04OUhwbGRwNmprcjkyejRnRzlGNkRP?=
 =?utf-8?B?NndkbTdJQnVXNHFyZlhzOVZNeUZqNmRHSUNqVjA3N0l6dWN6WnJuYi9YM2Fh?=
 =?utf-8?B?Q2VMU0YydnQyZHFGWVp1MVp5RUtEQnh6Y1hGdGRjT2k3N2pkeXA3aTNRZ25H?=
 =?utf-8?B?OHptYmZCUS9jem01bGg2bGQ2c2IyRHY2ZUorNzVzTEkzYnNraEpGWktNbEx5?=
 =?utf-8?B?T1Q3bGQvZE5sQ0M4ZjE4TGZZZ1ZGNUVLT0JuVCtUYkQwU0QvMWJ5Q3c3UzNn?=
 =?utf-8?B?WE1udkZCb1MwUGt5K3ZLRTZGcmhkSzlLb2o0bWoyMFRkbTF5aE5naHl2M2RQ?=
 =?utf-8?B?UTZKMllwZDByYkdaRnFFSUpqNFpscFF1WjZCSUYwWGlZUm1Sa1prNWtsUTVI?=
 =?utf-8?B?bmkvSkphUE1MSk11b1Q1bVg5d1E0aXhTRUdMZW92eDF0Q3Z4eEkyRlc1S2xB?=
 =?utf-8?B?QjcyNldaeFVRT3NvV3A2UlY2bDBhUG05R255dUc5WXgyNXIvSCt6TXRLbHVS?=
 =?utf-8?B?NDF6UnBWMzVzeUtXRVJuMVVkK2hRWkVKMW9hbmQxNGlBbThJZzlLMW93R0NC?=
 =?utf-8?B?c2pZcDdaL1M1bi9TNmVQK2JjTE1vTTdJRnI4SWhjUFgyK3dINStzMGlUazNY?=
 =?utf-8?B?MVZUTVhTSjlpSUN3U09FRHRVL2xWVDNmN2hCSmxZbFVjNmR1VnJWdVVITUNU?=
 =?utf-8?B?VUFHbGgvK0xZUXQ4ZjJNVkxSeENBOHh3Ui9GMWIzSEdFSTcwMEdCd2NTY0ZL?=
 =?utf-8?B?SGRPeERBd053Rit4bmdrak51ZGtXNWhyMXd0eXhEbXYrcXVFaEhjZnVqUE0r?=
 =?utf-8?B?ZXV6eXRNamVOdWxndzVXWHhpNTJYYmZXNUxuR0pWQnZObTZIOS93SFg4MlVN?=
 =?utf-8?B?WUI3QktMcHN6KzFKcGhJT3phaG9vUlVaTmQ3c0VzdTg4ZlFMNW55QVFGelBU?=
 =?utf-8?B?dlJNQnNwZGJSU3J2M3BDcGJsZG0rTlJ6b2JQNjFncDk3Y2ZBc2tOM2o5alZn?=
 =?utf-8?B?OGdGOE1adTMxellIL1E4UWZxQkRGcTl5bkFOa2RIeXZPRHBTa2F5K3FYSS91?=
 =?utf-8?B?V25peGFNZEJRSmNuVlpZVW11NVg3OE5sR1BETHdEaTNBY0h3c0RIWmYrQXJ0?=
 =?utf-8?B?M1lCR3ViMUU0RkhqT1d3SmMrb21nbnUzVHhGRW1tc0YvNnhQMC9BWlBXNW9a?=
 =?utf-8?B?TlVXN2xuRUhFL0pXbkt5b3QxaW10YlFUNnM4VDFybHhIbFRMb0NrYU1Cb05L?=
 =?utf-8?B?NDZUdXhlaW5US3FjeExiRWtUQ3NkSEFoUjVMYWg2YllWbXpZWGdGa1N1VEQz?=
 =?utf-8?B?U3pLS1JCY0dMMERqa1BPRktuSk55RXJXRFFRUjkrNzZtUDRyYU43clBVSlNZ?=
 =?utf-8?B?SHBOWW9RekVSRFZrcE0wZ2NPaW1QRzR2YllISnB6amxrS2xKVVhEMmpDRzJS?=
 =?utf-8?B?dm1Td0c5SjZjREVtdDkrRVZjL3NzTHF0WHpGK3NrSmVOSnlhdThONm11SlpK?=
 =?utf-8?B?dnlMLzFuQnNzZmZWcWpUS3g3NzVBUTFidjNUb1dnWGRScjY4NFAwMVRXamlh?=
 =?utf-8?B?TXJNWTFZaDZUU3haT1g2RmVmUEVPL3FXajJpWjRNd0RlR05CcWFIU2xSMFB5?=
 =?utf-8?B?Q2JhU216aG13ME5UOWo5cFY2aE40TDRud0FHWUxTaWZZSWVUaWRrUT09?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d244363-5cfa-4d90-7c64-08da38ddf14e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 14:51:51.5289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3CeB5yFMgdW3yGab682s2e22TdFIDVuGhM8I+nKeIu2roCtKmgt3PLTKD418GIi/bod96Nmm+E/HQYQAap8qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9268
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 06:12:36PM -0700, Vincent Li wrote:
> On Thu, May 12, 2022 at 5:49 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> >
> > Hi,
> >
> > I cloned the bpf-next and tried to compile the bpf selftest.
> >
> > first I got error
> >
> > "
> > CC      /usr/src/bpf
> > next/tools/testing/selftests/bpf/tools/build/bpftool/xlated_dumper.o
> >
> > make[1]: *** No rule to make target
> > '/usr/src/bpf-next/tools/include/asm-generic/bitops/find.h', needed by
> > '/usr/src/bpf-next/tools/testing/selftests/bpf/tools/build/bpftool/btf_dumper.o'.
> > Stop.

I also ran into the same issue on bpf-next, and the error seems rather
absurd as

  1. asm-generic/bitops/find.h was removed back in 47d8c15615c0a "include:
     move find.h from asm_generic to linux", so perhaps this error has
     something to do with Makefile.asm-generic
  2. normal way of building bpftool with `make tools/bpf/bpftool` still
     works fine

Anyway removing ARCH= CROSS_COMPILE= in the bpf selftests Makefile
(reverting change added in ea79020a2d9e "selftests/bpf: Enable
cross-building with clang") can be used as a workaround to get the build
working again. Adding the commit author to the thread to see if there is
better approach available.


Best,
Shung-Hsi

> > I could not find find.h in
> > /usr/src/bpf-next/tools/include/asm-generic/bitops/find.h but I found
> > it in /usr/src/bpf-next/tools/include/linux/find.h, copied it to
> > /usr/src/bpf-next/tools/include/asm-generic/bitops, seems resolved the
> > problem,
> >
> > then I got another error below,
> >
> >   CLNG-BPF [test_maps] map_kptr.o
> >
> > progs/map_kptr.c:7:29: error: unknown attribute 'btf_type_tag' ignored
> > [-Werror,-Wunknown-attributes]
> >
> >         struct prog_test_ref_kfunc __kptr *unref_ptr;
> >
> >                                    ^~~~~~
> >
> > /usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:176:31:
> > note: expanded from macro '__kptr'
> >
> > #define __kptr __attribute__((btf_type_tag("kptr")))
> >
> >                               ^~~~~~~~~~~~~~~~~~~~
> >
> > progs/map_kptr.c:8:29: error: unknown attribute 'btf_type_tag' ignored
> > [-Werror,-Wunknown-attributes]
> >
> >         struct prog_test_ref_kfunc __kptr_ref *ref_ptr;
> >
> >                                    ^~~~~~~~~~
> >
> > /usr/src/bpf-next/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:177:35:
> > note: expanded from macro '__kptr_ref'
> >
> > #define __kptr_ref __attribute__((btf_type_tag("kptr_ref")))
> > "
> >
> > my clang is 12.0.1 and installed new clang from llvm github repository
> >
> > clang version 15.0.0 (https://github.com/llvm/llvm-project.git
> > e91a73de24d60954700d7ac0293c050ab2cbe90b)
> >
> > it resolved the problem, but now I got error
> >
> >   GEN-SKEL [test_progs] test_bpf_nf.skel.h
> >
> > libbpf: failed to find BTF info for global/extern symbol 'bpf_skb_ct_lookup'
> >
> > Error: failed to link
> > '/usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.o': Unknown
> > error -2 (-2)
> >
> > make: *** [Makefile:508:
> > /usr/src/bpf-next/tools/testing/selftests/bpf/test_bpf_nf.skel.h]
> > Error 254
> >
> > running out of ideas on how to fix the compiling error. I hope I am
> > not doing something wrong :)
> 
> I recompiled the bpf-next kernel tree after clang 15 installation with
> make bzImage; make modules; make and then recompiled bpf selftest, all
> compiling errors are gone, sorry for the noise.

