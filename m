Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0B74DBCEB
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 03:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiCQCUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 22:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiCQCUR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 22:20:17 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021C41BE92
        for <bpf@vger.kernel.org>; Wed, 16 Mar 2022 19:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1647483539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m+JkC+IBiPNhnOA21d5RTZZWETk3QlJ7YObDP4fTtWY=;
        b=KT/14Onv+esuFM/D88+HH5MDGUe238IXnEhUzD5aVuNbb81rYwrOBY4pA0AthgT3feawNH
        z4sF4GJOsdk4q8KLeHDaVrSwUC90SyC/iAefqd4M+QKUDZWj8QzQu4f78p3si1sdLY7oIb
        xKS4SHRD1QBLjxMjr8n04t0PFg9Ozgg=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2054.outbound.protection.outlook.com [104.47.14.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-4-9pc21r2fPOGm7K9RkmYR2w-1; Thu, 17 Mar 2022 03:18:58 +0100
X-MC-Unique: 9pc21r2fPOGm7K9RkmYR2w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEQJZpufYhzm9G5sGKz1niVZQXb/KgokRnYkYINl/1ztRWmNBKUeVbsiflNgsRSkZYN5PECFMBP6qNKZqbE0LlCUTeLhwz5T1lQ/rrjUexelrTcKR8ua6/8TVR/cuKHcbeXTe0TIUphDO+SLv5k9Jwe9JvbrVwmoRtYZWU+ppCn9kTKgx5ERD31E8ptc3JS8r41xZd/dUGSN4/Y2QeVdzBOt3CUfwv4dOVUnkg8L5iiNO9KZXOTMbde7kODi/uDNObhaSc6xa1L28YAoC39ycI6hVTE9spPc0u3D03jODIavv5gvdj0Kin0wDcIb86f3QRsXLDlYGTcUBGvfxIVh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+JkC+IBiPNhnOA21d5RTZZWETk3QlJ7YObDP4fTtWY=;
 b=GY544uWawZMNzdvFjkNPv4X/WeGGvT0aLpYf7Xw0UViQI71b/6zV0RiehP9l7BGeDhcQU8bTa412X/4iQOnxBIoeT20lpiR32fkNJ1/D4efyTgN/vOkJgkBdRr/QDXERresdsYcDKMIrs4oRHDuDJg8pATmMmzshU4wAE5kfi5DbAUYuK4seK9qCYKG+/rcwmkwoEZCy7xMflsEi3HSAntns2npRmGy2Q7G/IfQCo6NGd6NVuBtdOHnPiNSYoPuNKZGRMMM3Qt6llO/Ut8P8rRRKjLUo7q8kTtqzEfkU/p3zUSATmy31IQxOQYJpj0a+vODI9HDNZ60o5XVixFUuTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by AM6PR0402MB3941.eurprd04.prod.outlook.com (2603:10a6:209:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Thu, 17 Mar
 2022 02:18:57 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::3903:f9ce:3bb4:19e4]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::3903:f9ce:3bb4:19e4%3]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 02:18:57 +0000
Date:   Thu, 17 Mar 2022 10:18:45 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/3] bpf: selftests: Remove libcap usage from
 test_verifier
Message-ID: <YjKahUn7g6muDk2E@syu-laptop.lan>
References: <20220316014841.2255248-1-kafai@fb.com>
 <20220316014854.2257030-1-kafai@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316014854.2257030-1-kafai@fb.com>
X-ClientProxiedBy: AM6PR04CA0024.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::37) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aa1fb668-bce9-404c-b90a-08da07bc7d4e
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3941:EE_
X-Microsoft-Antispam-PRVS: <AM6PR0402MB3941BCBC5F8EF6AF664A7646BF129@AM6PR0402MB3941.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/VFr9HdWHwmUVNtvsNNiGd9FBYqykpMbDGfJUiDNmTLhoTqJYnaHibJ6VSNrw8OWJip8qV+ekPIRSX1y+jGy9DN6GO+rcdqU24L6i16SS22ItaAMA0vkB9x/KiMSvqzKeBP2BtiVsiEL596+YqXvkKg5CDfRkaFppXDmcgD3EuCZgg4hkooxgIW2GlUPS9hm1efiS43rlJDWysPi/BezqNjgwVK5WydWFCeWaLY4MBxqG7q28udyQLZs0IKw+v1ok654F+kI+/m9Jq1TecPFDXGE2oxOb3NKfexp2arebJA1H4A1+QFWIkLz7ph2AG6yifztsOee1shw72MoSI21b1R7UWIx7TwQ96Xphqemgt1w5M7zaPpdfuDVtXiE6YxyYJErJ97oWW4WLcbbHj8bb/650PsmmwzHtjbcK7yg0WDZdChfUUAcJJHUeczMx4qPiqUlLW73MVwQyLEKa2uk1JgreLdWbl8O/9ohwv3nzWkWCiJHpsZFuw2CyqM9jp8tMJUP6EuWkJTY8nkoY1erGSqNNNx4MgE0H7YrEN5mmFSmKvDzRabUUMlE0fPyNDiv9ABmqW49/09/vdwV4QUaatARY7D1pbHr1r4sPUvKtW8ZpoHS6Lu+vjx7ORf32uEAGZw9eOyMpAfED4zGG0LZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(508600001)(6512007)(6666004)(6506007)(316002)(66946007)(6486002)(6916009)(86362001)(54906003)(66476007)(83380400001)(38100700002)(26005)(186003)(36756003)(2906002)(5660300002)(4326008)(8936002)(8676002)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzZpUUlPNFJqTExrVDJEWlFKQ3BCQjJHZkNkaGxBaENvSCtSRmNoMnhOQ3Vx?=
 =?utf-8?B?QXZJM1BTUVk0OFVkaHBtd3ZWWCs5RVZaczkvTVpwYmJxVklUOGw5ZTNvRnNY?=
 =?utf-8?B?QlFwQkc2VWJwUUpjYXNidTRnNjBpSnZMQjZ4SE52WTRsTTh4NTRaTkU2NE1r?=
 =?utf-8?B?WWRsT1cvRUNUVnNEOTJuQUs5Mjl2S0VUUzd5a09EUU5IL0N5TUQrTXJVbVdR?=
 =?utf-8?B?QXNMR091MXMxRlp0ZS80Q3hCT0lmQTN2QnowR1l0OUJwYjMwbm9QTDNJZlRH?=
 =?utf-8?B?amZ4Y3pkRU5xem1xbkpNYXJmUTE3bDZFck1lNHdtc3Q1bGVrWHJSTjlIU0NS?=
 =?utf-8?B?cGZHM3JzZWxQOXB3U0IwaGZXNVFJL2tQMmJhbjRFVEVITHR1dlJ0UzNHNXRi?=
 =?utf-8?B?VFNXWXJxYkZJZDZCcjBHVnpMNEFUWEdqbVY0dElmWkk0OUtkQnRNMXo1MU1O?=
 =?utf-8?B?Tk42YlRkMUJ3d3d6dDlsZThiTnM0RWJhaEdLNVhwYjZVV2NwMkJmaGR2WGQ5?=
 =?utf-8?B?L1dNZnU4RmhiWmlpdFVQRlRpZFQrR01JNlRlTHhQRy91M1M3YTFxb1BDVmc2?=
 =?utf-8?B?amZWemsxeFVSeENWWDd2T0VTYVB3dnRKM3lXOXdZek9qMXhJNjFoL2ZhejJW?=
 =?utf-8?B?Zms1Q1U1VDhwcytPWUFUS1JUbCtEaGhWN1FqQnBSWEtLS2YxTUJmYTdoOWVJ?=
 =?utf-8?B?MUltZ2dQaUxpZHRtcTRtbUpqQVVHMkhKY1BIVTRqTTBBRGU2LzZ0UkZmTVhz?=
 =?utf-8?B?SXN6djg4c2lKWFF3SUxOQ3JwdWx4djR6MXZkVDJHK0xJbGRIL1BIa0JCYzZG?=
 =?utf-8?B?Wm1qNE5ySGlHWmEvcnBFOHZNQ1Naa3lETDlkakRhVDFCQW11VG5FUmRlc00y?=
 =?utf-8?B?NXZVallrUkJFeHQvd0t6a1ptZGxoZHJ5SmZRT21TUzlHcUpGcmZPTW83Sjdx?=
 =?utf-8?B?ckN2UHNkQ0hSYlNXT1hsQkt6YmkzUkwzNmJneGM1cDNrNDlZZVBqWU9oMXhx?=
 =?utf-8?B?TFVqNVZmUnNOK1NwSTRkclFUWVdGNUFzS0NIaWVtdGp0YXpNTFlBcTdydlor?=
 =?utf-8?B?bXR2azdhbDUxeXYzN3BEYklYUEVjM25RR0YrVmcwMWJuYkRjWjNDQU1qQXNH?=
 =?utf-8?B?L2trZzRVa2hrbXpVaHBNcWZQM1NKR3FmNHozUEVCV1RPdUVYNlBmYklyb0c1?=
 =?utf-8?B?RDExaThJQXNLSGRKN1YzM0JNd0R1K1NFNFJISWl1SFNOajNmMzFOaFZoa21X?=
 =?utf-8?B?SEFaUFBlcWhjU2VTZEFNRVdTZE9OcFFFMlh6L2hmK0IxZ0g2UFdIaG5PbSta?=
 =?utf-8?B?VDg1NGZzNW9NK2Z4K2NPbEVTVXFRWnJXMjlIdVdHNzRscWpHczcvay8wWGFi?=
 =?utf-8?B?WDI5aFVjYllmUkJQRnBaQ2FDWit1NWpaNk5Rc2lDMWYyMjRjbnpOUEJpc2Ft?=
 =?utf-8?B?NUJhaXNERjFub2NpV0xBdlJ4V2VCODZnYkNZeTNyK1pQNkpIRVFTN2FObjgz?=
 =?utf-8?B?aW9iWWpkazEyWXJ5d1BPTXJOcmp3RjhtT1pxYjR4bHJxMGU5TnhsV0s0SWFI?=
 =?utf-8?B?SGordWZxVkN2b3ZhRGJzWW9rMU5vampzNUFIb2VtdVI4SkNOVHZBcEdnYlk4?=
 =?utf-8?B?anB2Wmp2WTJwQTl3aGpucjFpZ3hTb0FkbXRzRDdVRXRyU2RwUC9uS3dMcDlQ?=
 =?utf-8?B?VkdTZ00yeWtNWWJTenJDWmpaZEM3NDNDbjVmMkNlNk5iRG1hRDNEWlovUm1C?=
 =?utf-8?B?MTM1UDUvc2ZqU2RET0xkenhzc0ZqT1ZmUEZLRFBJUnJCM0hvbC8vaUNDVlo5?=
 =?utf-8?B?MkVkSDFueExOblI4bit4bWY5dHJ1Q1lGaXJiOUhLdXRLazRFYnpleHk1N3dF?=
 =?utf-8?B?OUhTL3lzTVcwVitFZXI2SnlBMWN4cU1UZ1NjRzZuL1g2dlBRdHdTcmFxTEo5?=
 =?utf-8?Q?jYA7YCzlhisY8oEnQkOsprQXE1tUtuNX?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1fb668-bce9-404c-b90a-08da07bc7d4e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 02:18:56.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+ecSSV9uG22U8jwSj97Bd0FRRBNXydwbzM97NOyNoSIvelhY9Fraxv+Qy7jvE762Zeu6FivB1fyMw8VA/O4aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3941
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 06:48:54PM -0700, Martin KaFai Lau wrote:
> This patch removes the libcap usage from test_verifier.
> The cap_*_effective() helpers added in the earlier patch are
> used instead.
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile        |  3 +-
>  tools/testing/selftests/bpf/test_verifier.c | 89 ++++++---------------
>  2 files changed, 28 insertions(+), 64 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index fe12b4f5fe20..1c6e55740019 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -195,6 +195,7 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
>  CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
>  TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
>  TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
> +CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
>  
>  $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
>  $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> @@ -211,7 +212,7 @@ $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
>  $(OUTPUT)/xdping: $(TESTING_HELPERS)
>  $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
>  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
> -$(OUTPUT)/test_verifier: $(TESTING_HELPERS)
> +$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS)
>  
>  BPFTOOL ?= $(DEFAULT_BPFTOOL)
>  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 92e3465fbae8..091848662b7a 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -22,8 +22,7 @@
>  #include <limits.h>
>  #include <assert.h>
>  
> -#include <sys/capability.h>
> -
> +#include <linux/capability.h>
>  #include <linux/unistd.h>
>  #include <linux/filter.h>
>  #include <linux/bpf_perf_event.h>
> @@ -42,6 +41,7 @@
>  #  define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS 1
>  # endif
>  #endif
> +#include "cap_helpers.h"
>  #include "bpf_rand.h"
>  #include "bpf_util.h"
>  #include "test_btf.h"
> @@ -62,6 +62,10 @@
>  #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
>  #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
>  
> +/* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
> +#define ADMIN_CAPS (1ULL << CAP_NET_ADMIN |	\
> +		    1ULL << CAP_PERFMON |	\
> +		    1ULL << CAP_BPF)
>  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
>  static bool unpriv_disabled = false;
>  static int skips;
> @@ -973,47 +977,19 @@ struct libcap {
>  
>  static int set_admin(bool admin)
>  {
> -	cap_t caps;
> -	/* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
> -	const cap_value_t cap_net_admin = CAP_NET_ADMIN;
> -	const cap_value_t cap_sys_admin = CAP_SYS_ADMIN;
> -	struct libcap *cap;
> -	int ret = -1;
> -
> -	caps = cap_get_proc();
> -	if (!caps) {
> -		perror("cap_get_proc");
> -		return -1;
> -	}
> -	cap = (struct libcap *)caps;
> -	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_sys_admin, CAP_CLEAR)) {
> -		perror("cap_set_flag clear admin");
> -		goto out;
> -	}
> -	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_net_admin,
> -				admin ? CAP_SET : CAP_CLEAR)) {
> -		perror("cap_set_flag set_or_clear net");
> -		goto out;
> -	}
> -	/* libcap is likely old and simply ignores CAP_BPF and CAP_PERFMON,
> -	 * so update effective bits manually
> -	 */
> +	int err;
> +
>  	if (admin) {
> -		cap->data[1].effective |= 1 << (38 /* CAP_PERFMON */ - 32);
> -		cap->data[1].effective |= 1 << (39 /* CAP_BPF */ - 32);
> +		err = cap_enable_effective(ADMIN_CAPS, NULL);
> +		if (err)
> +			perror("cap_enable_effective(ADMIN_CAPS)");
>  	} else {
> -		cap->data[1].effective &= ~(1 << (38 - 32));
> -		cap->data[1].effective &= ~(1 << (39 - 32));
> -	}
> -	if (cap_set_proc(caps)) {
> -		perror("cap_set_proc");
> -		goto out;
> +		err = cap_disable_effective(ADMIN_CAPS, NULL);
> +		if (err)
> +			perror("cap_disable_effective(ADMIN_CAPS)");
>  	}
> -	ret = 0;
> -out:
> -	if (cap_free(caps))
> -		perror("cap_free");
> -	return ret;
> +
> +	return err;
>  }
>  
>  static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
> @@ -1291,31 +1267,18 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>  
>  static bool is_admin(void)
>  {
> -	cap_flag_value_t net_priv = CAP_CLEAR;
> -	bool perfmon_priv = false;
> -	bool bpf_priv = false;
> -	struct libcap *cap;
> -	cap_t caps;
> -
> -#ifdef CAP_IS_SUPPORTED
> -	if (!CAP_IS_SUPPORTED(CAP_SETFCAP)) {
> -		perror("cap_get_flag");
> -		return false;
> -	}
> -#endif
> -	caps = cap_get_proc();
> -	if (!caps) {
> -		perror("cap_get_proc");
> +	__u64 caps;
> +
> +	/* The test checks for finer cap as CAP_NET_ADMIN,
> +	 * CAP_PERFMON, and CAP_BPF instead of CAP_SYS_ADMIN.
> +	 * Thus, disable CAP_SYS_ADMIN at the beginning.
> +	 */
> +	if (cap_disable_effective(1ULL << CAP_SYS_ADMIN, &caps)) {
> +		perror("cap_disable_effective(CAP_SYS_ADMIN)");
>  		return false;
>  	}

Seems slightly strange for a is_* function to have the side effect of
disabling capability, also, this change of behavior in is_admin() is not in
the commit message.

Maybe a better place to disable CAP_SYS_ADMIN is at the beginning of main()?
That seems to be the only place is_admin() is called.

> -	cap = (struct libcap *)caps;
> -	bpf_priv = cap->data[1].effective & (1 << (39/* CAP_BPF */ - 32));
> -	perfmon_priv = cap->data[1].effective & (1 << (38/* CAP_PERFMON */ - 32));
> -	if (cap_get_flag(caps, CAP_NET_ADMIN, CAP_EFFECTIVE, &net_priv))
> -		perror("cap_get_flag NET");
> -	if (cap_free(caps))
> -		perror("cap_free");
> -	return bpf_priv && perfmon_priv && net_priv == CAP_SET;
> +
> +	return (caps & ADMIN_CAPS) == ADMIN_CAPS;
>  }
>  
>  static void get_unpriv_disabled()
> -- 
> 2.30.2
> 
> 

