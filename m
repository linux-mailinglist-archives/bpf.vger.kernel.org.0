Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADD35FC88D
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 17:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJLPk1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 11:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJLPkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 11:40:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA1C45980;
        Wed, 12 Oct 2022 08:40:15 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C5O9WH000538;
        Wed, 12 Oct 2022 08:40:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=waAve3LNxid7cgmFEQXGIQ6jw1sZ2BQec0KVBBo3hDg=;
 b=ThKCSiLPxMxyU0IQUfvP0jxK83KeBgQYeAfS4xX1VfaoTAfZMFjOwQ1TyH58OCEEvRLz
 m2vtnYEiKlzCBUm/4EkAI0zXN01Z12f/OFejVIxA9xbOh6TdepdnKJGovgsocRXtTXXM
 sjk3dMORMASQ+tuXRMwxeOYyw8tcAUxHaRaQVZQi1QYIA1IR+RrjPMDwQyow85yS++lD
 mANL5OFgG6mg5MzBg6ZJvtSc22wLe3qxXXK151haHK8gdXDu+SUd108whsaZidar4o0q
 EV0xTmmRJpoMyrTCDaq7/PZIcNuBoieFlqUwDOVTtpcVf83yinqsLp4HbqlhBpDAnQ1n gQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k5qdcc62v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 08:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMR1gtPawlZq8MbL02DWJ5tTqE03PWiTxT0zyIJB+Ckkg7rb3CC8BpQjdGoF4dIoAgegmqRJRv7QPgMtGXXVWcd/6qk5ttQFAaHGZIpfjLE+Gmtv+YVGpFUe6TBsPdjzO3Kow4qrtjDWvmFTZn7Lrj0TCO4Dj/BNSEQGJbNdeqztqVb8GVGBhafh7CeJPkK6QPgwYZY74U+94MtV3cQE5PWLgqpfCJFTQteVKInNGlhKNCrA1ARYxIuahDi+DWh2Q/bnop8pU5K2dSo1OkKbqzDwDwbPb5lPM0dDcCG9j4g74z31MSiTRy++i+fIt1o6xB0aPGGdYXkqoRMRPzGYTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waAve3LNxid7cgmFEQXGIQ6jw1sZ2BQec0KVBBo3hDg=;
 b=E4w6ttl/VbixnDC+ACeT6kI5IJdYTFmjCxKrqNRjpZ9az6u9GudhzosLEEH4j509wR1lhj39z4ZWp1nQMBwlIx2kGeeHlJdJl5iWkPLNvtQdXd9silnBo0oew0Z47trFTVgutUOHIZ18+rx/2O38nbnYVDn51xihuZNJminI5D3FC+6tXDde/nWUCMfyWXOFLGFWsRpUdYalhsTAl1mW/+3D04wOadI6YpnLMPik3gk4MDcwxAuWurXXUDS49K6D+F6KlibWO7hwUNi/bQe+taSteUlG1pM01TzsJyCV3MZvhwJf1dZV1ucpFJaw6VK7yMngOw0QLZ9g4nXuKebTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH0PR15MB5191.namprd15.prod.outlook.com (2603:10b6:510:14c::12)
 by MWHPR15MB1662.namprd15.prod.outlook.com (2603:10b6:300:125::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 15:40:08 +0000
Received: from PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::b032:4b26:a4fe:697e]) by PH0PR15MB5191.namprd15.prod.outlook.com
 ([fe80::b032:4b26:a4fe:697e%5]) with mapi id 15.20.5709.015; Wed, 12 Oct 2022
 15:40:08 +0000
From:   Tomislav Novak <tnovak@meta.com>
To:     Alexei Starovoitov <ast@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Topic: [PATCH] hw_breakpoint: fix single-stepping when using
 bpf_overflow_handler
Thread-Index: AQHYz4xNSRmGp4l1PUKwAHNo0kfo464LAq+A
Date:   Wed, 12 Oct 2022 15:40:08 +0000
Message-ID: <Y0bf0TLWv2oUSMjG@tnovak-mbp>
References: <20220923203644.2731604-1-tnovak@fb.com>
In-Reply-To: <20220923203644.2731604-1-tnovak@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB5191:EE_|MWHPR15MB1662:EE_
x-ms-office365-filtering-correlation-id: 5af9684d-d14b-4f4b-2dd4-08daac680ad5
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +FIlSyTJXGvlN8mkh2FoyGbDf6hY34gaUDAIxoHqQ0N6rEInoan6K/WQxJbAjOswmOfiomLoGuVhRjRpXXKZXD/U51Dc2DoMFofgCeGxP9wRixy5WkxOjaHZeaAaEWhVLVaUZw46/Rq5FjhyeeL7KEX6C6pkZs2qA5mK5XetJL6cKzdNpYlKae/cobviZHcsuRX7DkFfsvnDxVy0tgfJa5CEPSTG5xA6R7ylgys52v/9mIgCl76IGCRpsYJN/CHitmbcWT8WZ2ru+oXA5YhUEWtPE6RqxrjlCFVpbZ+PtWH/auR5iprLpDPCS8RjvGj48ujDG743NrpHDpqWwHglg1dPnBDR7UeiBi0C41Vsa3yhDMMv8Nq0wIhpr5U+qqqpMn20EfXl1Aj3dZbYder6Z2nQJ2Znw9rkTIc/Ptvo18x9takuWahfSs28WOoc2+n8qwZZL9pDUQJ10JTbOAzQnKb87PziY4MdeZWLS6pm1t3bNVw0qt8mLn7BW4tVccrGuDLJXCaL6KJoOdUa8w9XWAE5YTqr7k91xUKnuf6szVobFiXABpGgmJzs8Oa9qK3sOQrQ86vRKdo1B3/8mJTEWuKlq3B8xLl3ROfoRCtkOtS4k+kDMHm9FUz+CdMKiilahMuBK53y3XIeowUBbVwd1ZfTSC2Zyd4ctGPrb8WfaCEZXXInBK9yGlnhNuFGoGdJ/WH523JXUTucILM/pwflDo8vLJKH4ts5gvNXivpid0wvQD3ezeQIrglDCkyNDZtP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR15MB5191.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199015)(38070700005)(66476007)(86362001)(38100700002)(66556008)(91956017)(122000001)(64756008)(4326008)(76116006)(33716001)(316002)(71200400001)(66946007)(66446008)(8676002)(5660300002)(41300700001)(54906003)(2906002)(9686003)(110136005)(7416002)(8936002)(6512007)(83380400001)(186003)(6486002)(478600001)(26005)(6506007)(66899015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YNDN8fHbeBM0CMyamv9pgUDffGHZI3Fo5wyPuOVbF6ROT2A7EPdBzwe0pu0v?=
 =?us-ascii?Q?qxA3DvxkPKSPzBWHkco/0LdZ2JRyII8mNpE5d9uwjXiZYH2RtFdoJo3GrccL?=
 =?us-ascii?Q?rP8NixFTbwwuRYiInPsZGNkwF4DmsXWh4FhZkIXBj1ICkEV4yb4vOVshaUiy?=
 =?us-ascii?Q?OCeG6ZiRk+GSiATrjAoIndLOt6kX+oAXsJNCOfko9gNB9aOHjNgjchcwy4VW?=
 =?us-ascii?Q?Bz2m/2t3xwLFOZNe0te8MJqoL7Nuu6dgl5rskncgTafj7EQoShh4hyIXXhUZ?=
 =?us-ascii?Q?6aMrS7jvanmnfyfeBFdyM+5nb93tKqHDJgIVY/wPivdfOfRuqhNLCk/YfJq4?=
 =?us-ascii?Q?FWiOxiKlQLuUmGxfHKXfszSgjJXp2ojTNdrTTHiw554qOj0e27k4JbhDwFKV?=
 =?us-ascii?Q?S8UOW/ib69l4Wd6jDTg80CijNXw22oxpBCoYqjdepiI34OnpydeLjiBDnOzW?=
 =?us-ascii?Q?gWSfYqMph/cffqe1ZsRZVbhtGRkc7V2oQ+68P+XK6yREIrAVKEdnaIbVmoJ4?=
 =?us-ascii?Q?+0Xq3p2qm/QQhjPo91hxgwrZRl2XzeouUlsYVYuBkFr/DvFDJsBo9flzur1g?=
 =?us-ascii?Q?3vqTsXxqsHRfeInLm6f6xAxPzTkbkAD72FpUYoWazCKbuCCSS1DoG8uSaxNn?=
 =?us-ascii?Q?YOnmvpAbdYijZminSZGnO6MYzoDim2lVk2fB4SjfeuPeBriRws/2mO7u6r/a?=
 =?us-ascii?Q?ICk/r3TS4FRtDdHQljlHO38Aw+pCqWyxD37YonKxdWEDymlPoXtQ8D2chw0F?=
 =?us-ascii?Q?EhxdpFMSB3U3bpU073zdhbgb7pbsEPS3xI4pyBTTWqhGdjgqECNJItrvmAou?=
 =?us-ascii?Q?Ry3ui6ZSEliU96SU6NQQtTZL9lMw2bNhfaKpoUiGCn4uUpxIhQEb4ec4Il6t?=
 =?us-ascii?Q?QcgM0UMSUywI5GhHJMfQiqICJh3h+mrH8c9fAa2RTsVbm8JDfErf3AH2sEac?=
 =?us-ascii?Q?FsGbHceJKPLM6M8Ri86Gt4cSLlvKgojy0FWGOMkr1R3rmRB0ausJ60wprNsD?=
 =?us-ascii?Q?R/H0me8mScA+CXEHKS/JuV6GkiwTLgrLkGpXObyoOraiwf59ua+nEq0ufMlY?=
 =?us-ascii?Q?TUbEzq8ufZmkde5gtNK8CuHLvBiFsu3B/Ihsb4mc35aUEDO0n6tX/9TWm0VO?=
 =?us-ascii?Q?FAnwslKrM6Akk3wQlpO3raMAZb8o9BCbzsdHpkccfH87BjRt/aPgG22isAof?=
 =?us-ascii?Q?SseXNdvulLJO+E2tNDtpVvtw3l9YjRAqTapy5h2sbYxTLgX6Ug/LF8Rd5oTW?=
 =?us-ascii?Q?1TldxnHFnoEkB9VwxtgLP3/CpizXXxfxaT4Cq+CWCLMLhaYfnbq1T6eksXXN?=
 =?us-ascii?Q?2vQsO3WoIv8eRHDR3Vb+/zSoJJP1RJQsPg5/FNyVYQvVYUutnFhfTUpSCtNq?=
 =?us-ascii?Q?OHLHDIxezK9pZjgKCWjPG5j+4n1syAT1wvC88GmhH8mW5EJWITtlKxicOrTC?=
 =?us-ascii?Q?3j8dicSLgmItX5dpxUEtyMgMaZ2nmq+OszGesei9YQ7XWneocXImt9QsrS/D?=
 =?us-ascii?Q?NNbV4lUJVgSOUfgv/OtShGdKEPKAJTzp9p3NCa5COzEBbxoqZT2V9jTuOD1R?=
 =?us-ascii?Q?n8w3mKtldv/8V16epNWHNFO9wPAFfmfjLXjKjS6G?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D69991EF6A0C60478AD71CA2383D9EB1@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB5191.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af9684d-d14b-4f4b-2dd4-08daac680ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 15:40:08.4197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dEkdwkorylqP4M1YJ6K1VUbyutpUYISsSs4N3j3dzNqgZJnVes0CAryOURcjIRWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1662
X-Proofpoint-GUID: gN76FXfpOSv_eqvlPsFW-raaVJkDOFjJ
X-Proofpoint-ORIG-GUID: gN76FXfpOSv_eqvlPsFW-raaVJkDOFjJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_07,2022-10-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 23, 2022 at 01:36:45PM -0700, Tomislav Novak wrote:
> On ARM platforms is_default_overflow_handler() is used to determine if
> hw_breakpoint code should single-step over the watchpoint trigger or
> let the custom handler deal with it.
> 
> Attaching a BPF program to a watchpoint replaces the handler with
> bpf_overflow_handler, which isn't recognized as a default handler so we
> never step over the instruction triggering the data abort exception (the
> watchpoint keeps firing):
> 
>   # bpftrace -e 'watchpoint:0x10000000:4:w { printf("hit\n"); }' ./wp_test
>   Attaching 1 probe...
>   hit
>   hit
>   hit
>   [...]
> 
> (wp_test performs a single 4-byte store to address 0x10000000)

Adding a few more people (per MAINTAINERS), specifically for arch/arm{,64}
(other targets don't have this issue AFAICT).

> This patch replaces the check with uses_default_overflow_handler(), which
> accounts for the bpf_overflow_handler() case by also testing if the handler
> invokes one of the perf_event_output functions via orig_default_handler.
> 
> Signed-off-by: Tomislav Novak <tnovak@fb.com>
> Tested-by: Samuel Gosselin <sgosselin@fb.com> # arm64
> ---
>  arch/arm/kernel/hw_breakpoint.c   |  8 ++++----
>  arch/arm64/kernel/hw_breakpoint.c |  4 ++--
>  include/linux/perf_event.h        | 22 +++++++++++++++++++---
>  3 files changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/kernel/hw_breakpoint.c b/arch/arm/kernel/hw_breakpoint.c
> index 054e9199f30d..dc0fb7a81371 100644
> --- a/arch/arm/kernel/hw_breakpoint.c
> +++ b/arch/arm/kernel/hw_breakpoint.c
> @@ -626,7 +626,7 @@ int hw_breakpoint_arch_parse(struct perf_event *bp,
>  	hw->address &= ~alignment_mask;
>  	hw->ctrl.len <<= offset;
>  
> -	if (is_default_overflow_handler(bp)) {
> +	if (uses_default_overflow_handler(bp)) {
>  		/*
>  		 * Mismatch breakpoints are required for single-stepping
>  		 * breakpoints.
> @@ -798,7 +798,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
>  		 * Otherwise, insert a temporary mismatch breakpoint so that
>  		 * we can single-step over the watchpoint trigger.
>  		 */
> -		if (!is_default_overflow_handler(wp))
> +		if (!uses_default_overflow_handler(wp))
>  			continue;
>  step:
>  		enable_single_step(wp, instruction_pointer(regs));
> @@ -811,7 +811,7 @@ static void watchpoint_handler(unsigned long addr, unsigned int fsr,
>  		info->trigger = addr;
>  		pr_debug("watchpoint fired: address = 0x%x\n", info->trigger);
>  		perf_bp_event(wp, regs);
> -		if (is_default_overflow_handler(wp))
> +		if (uses_default_overflow_handler(wp))
>  			enable_single_step(wp, instruction_pointer(regs));
>  	}
>  
> @@ -886,7 +886,7 @@ static void breakpoint_handler(unsigned long unknown, struct pt_regs *regs)
>  			info->trigger = addr;
>  			pr_debug("breakpoint fired: address = 0x%x\n", addr);
>  			perf_bp_event(bp, regs);
> -			if (is_default_overflow_handler(bp))
> +			if (uses_default_overflow_handler(bp))
>  				enable_single_step(bp, addr);
>  			goto unlock;
>  		}
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index b29a311bb055..9659a9555c63 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -654,7 +654,7 @@ static int breakpoint_handler(unsigned long unused, unsigned long esr,
>  		perf_bp_event(bp, regs);
>  
>  		/* Do we need to handle the stepping? */
> -		if (is_default_overflow_handler(bp))
> +		if (uses_default_overflow_handler(bp))
>  			step = 1;
>  unlock:
>  		rcu_read_unlock();
> @@ -733,7 +733,7 @@ static u64 get_distance_from_watchpoint(unsigned long addr, u64 val,
>  static int watchpoint_report(struct perf_event *wp, unsigned long addr,
>  			     struct pt_regs *regs)
>  {
> -	int step = is_default_overflow_handler(wp);
> +	int step = uses_default_overflow_handler(wp);
>  	struct arch_hw_breakpoint *info = counter_arch_bp(wp);
>  
>  	info->trigger = addr;
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ee8b9ecdc03b..f174b77437f5 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1105,15 +1105,31 @@ extern int perf_event_output(struct perf_event *event,
>  			     struct pt_regs *regs);
>  
>  static inline bool
> -is_default_overflow_handler(struct perf_event *event)
> +__is_default_overflow_handler(perf_overflow_handler_t overflow_handler)
>  {
> -	if (likely(event->overflow_handler == perf_event_output_forward))
> +	if (likely(overflow_handler == perf_event_output_forward))
>  		return true;
> -	if (unlikely(event->overflow_handler == perf_event_output_backward))
> +	if (unlikely(overflow_handler == perf_event_output_backward))
>  		return true;
>  	return false;
>  }
>  
> +#define is_default_overflow_handler(event) \
> +	__is_default_overflow_handler((event)->overflow_handler)
> +
> +#ifdef CONFIG_BPF_SYSCALL
> +static inline bool uses_default_overflow_handler(struct perf_event *event)
> +{
> +	if (likely(is_default_overflow_handler(event)))
> +		return true;
> +
> +	return __is_default_overflow_handler(event->orig_overflow_handler);
> +}
> +#else
> +#define uses_default_overflow_handler(event) \
> +	is_default_overflow_handler(event)
> +#endif
> +
>  extern void
>  perf_event_header__init_id(struct perf_event_header *header,
>  			   struct perf_sample_data *data,
> -- 
> 2.30.2
> 
