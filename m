Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2494DBFF3
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 08:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiCQHGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 03:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiCQHGG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 03:06:06 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F101E4
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 00:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1647500686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JpTmxrRzQcJQgTv+5G6XZI228pJh7OSQskuZnMjh5Yc=;
        b=EfeoYhmcRlslDkHZNRGwHxWYAanjYmkYfPYdNtMwvrNWz50lVZz0LLMST9gh6xfJC1wy9s
        v/7KHqOOBAYuO0NlT2BoQNgP+47FYvmKstzlSoF1jdkV2+ITCDXbFl0TepLRvMXz9wPzop
        MUm+8uvWoWw5a5xfUKdR0jk6IkxU0Ac=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-20-KmUliAudPtmUesks_Vzz_A-2; Thu, 17 Mar 2022 08:04:45 +0100
X-MC-Unique: KmUliAudPtmUesks_Vzz_A-2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcpayVkerYdrykaq9qQw8DU5RsserKQE5y9xc+hMZHe6Rrs+1jrgc7XbE+QzF04IBtWotT3BVO/QQTP5cnpYP8wr3QaM9JZ/q6U5yi0EBCKbWaCflON/S29K+9dzRsVPjZx5mCP4QzI/y0qVER/ddaUUUQIRzkq4kvskmvUAW6KhkdoY9++BcroOspI4GVRISn3g4kLE17Lo0Fug33W8iqk32JQGaSamW7bUql46BqSF725kM3S1USayI5egp+WZq0qrOT+qIL6MpWSucRV2ARqg/0MPmfPZfcqn54KWWmIHw7hvNRAByuGSsofjUwj6CxS6V5og2t8qVA2WB+T1Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpTmxrRzQcJQgTv+5G6XZI228pJh7OSQskuZnMjh5Yc=;
 b=Dm/QCRRiusmLxrjgjgVogEHDGaWJ9mTngUc7YUI9QF+7dWz7Y+HLWdC1RmDH3ub4lvY1GWtQp4PBaJVnUGx55OR7E4i7LXLBBCVEEacoQBz00MHLH5tJATEZgEf3NNzNHie+cgfz/im05lFTk08ZT8z492CC+fmmJkaESSrnJ9bJOkljoHrCzsXarp7vSY8b/TaLhGnPtvJ1SObllGNO879U2AgzF4QG343n3J3gVVld4umenvlMbJE2eU9uYZ9FfbC+r7/WikfdJDDirWTtuvCcmT/5k8ibSez8BsSaAbZOOEXhkw/ZOODUa8OlAX144LqXdWnwRJYVgKRdW77q4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com (2603:10a6:10:243::20)
 by DU2PR04MB8549.eurprd04.prod.outlook.com (2603:10a6:10:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Thu, 17 Mar
 2022 07:04:44 +0000
Received: from DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::3903:f9ce:3bb4:19e4]) by DB9PR04MB8107.eurprd04.prod.outlook.com
 ([fe80::3903:f9ce:3bb4:19e4%3]) with mapi id 15.20.5081.017; Thu, 17 Mar 2022
 07:04:44 +0000
Date:   Thu, 17 Mar 2022 15:04:37 +0800
From:   Shung-Hsi Yu <shung-hsi.yu@suse.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/3] bpf: selftests: Remove libcap usage from
 test_verifier
Message-ID: <YjLdhe9MK1hen9pk@syu-laptop.lan>
References: <20220316014841.2255248-1-kafai@fb.com>
 <20220316014854.2257030-1-kafai@fb.com>
 <YjKahUn7g6muDk2E@syu-laptop.lan>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YjKahUn7g6muDk2E@syu-laptop.lan>
X-ClientProxiedBy: AM5PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:206:1::20) To DB9PR04MB8107.eurprd04.prod.outlook.com
 (2603:10a6:10:243::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3951ff1c-250a-42d4-6e9c-08da07e46a06
X-MS-TrafficTypeDiagnostic: DU2PR04MB8549:EE_
X-Microsoft-Antispam-PRVS: <DU2PR04MB8549385E0455A510E555E180BF129@DU2PR04MB8549.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vl77bf55d+dUdecZmexjMV18fyf5nzGpLbUGCMJQ9nC+hJsYt299jT/WAomjyFkjQnx9UGhZstA+2F2UCLi/EyvHQvOOWMvKrVDigT4p7Q2X12MLvhm1VpzYRvaVG+BLRsMkDJ8ZsMO0ZBjTEuPgssG5FUFwL8eb1nGZjWPdBwRbRUak0ab7P/1fvyItqxZfNQeLVqI/LYFYh29hr7l25brL5Kd7NtMdCK6YSmPnQ6dZLLKUFbKNYmb3b1xn3m7ni5eOSqF3Rs4jS/ETUbi55Sfe7mDHWXXsBqnJ6txfKGrOqrHyhYyBjVycPSO5/7482Tk7xSwc6M7kD1XLvMSaRZr5rZheV+3l0IbgXGpXDm+C1V3kjEzmayQ8zz9X41/rPdY83AutmXpaRtdu6n/fZny7ndwnJPGMSjSL1g6+HZRX9u+XNUgEkP0A3cY4r5+1HME5XR84eSFTBjhtHmml6zeteqhB8qXX2YE1OQmYBGSiv+kUiMj2MMdqP4il66OQNSEIY3MxbCpngGGSHzAeYnMMQoXxFxuxo4hGvHpjMJYBSheFXzjKvstj5OPEcAbkA+KXprfxGG4XsT0w6acWC5zdc69ZU+xI6xtE0tuc8msFwG4+vodjDuUWhOd12SKdNoKZ0pIRUCzy5TDbcrbP5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(8676002)(8936002)(6512007)(6506007)(86362001)(4326008)(9686003)(508600001)(2906002)(38100700002)(66946007)(5660300002)(6666004)(54906003)(83380400001)(6916009)(316002)(6486002)(26005)(186003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0taSjhSWWJFN0pETzBwVXlkWHhrWXR2S0dVamtrMGlYbktGS05lSmR1bXpt?=
 =?utf-8?B?NXNDUjhUaWtWV3FBNlZ4bVR0WWVYTUZjbno3YTRaNEkxbzBNRklHV2JIUE4v?=
 =?utf-8?B?OUo3MThuRUZka1pSZi9ZczF1QXZXVm5aNXdZMEJxeXJEUUVQRGR6L1kzQkdv?=
 =?utf-8?B?TDlmVDRUUURMVEVkdjg0ME1vRHByU2RZVThzTldNelNuT3NIMVNyQThRSWFP?=
 =?utf-8?B?bEVGT293amk2clIzSFpiem9HZ2tOV0ZpUXBFUC9INGl4U2ZYa3hOOXhhbjlE?=
 =?utf-8?B?a3BOZGlBMHFtampVeFdpaENWbC92MWVSMFhCZVJ3THNycmZweTJQU2grekpn?=
 =?utf-8?B?NmhURFA1WlBGVUlYWWZUc2RsQkIzT2d3YVhWS21PNVk0UDRnekppWTNyOWVq?=
 =?utf-8?B?MXV0U2xPSjBFeFFLVFRFQXB2ck9kY0REcE0wbDJ5QUQ5SDJKL0hqRGptU2Nx?=
 =?utf-8?B?YzVYdmdOaGpiVmhBTTYvWWErL1VWcjkxYjMxbHFrVDZCYnpZWUEvOXpYVWpM?=
 =?utf-8?B?cG1JSUphN2dqZDNCMGF2L1ExT3pjR201ZklFSkpoRzRKVU16aDhWMlFKME1z?=
 =?utf-8?B?NUNYUUhDSmRja1BPRUZZYjY3aWYxNytuRTR2WW8xbVlVZFNNN2J4OWNuTXhB?=
 =?utf-8?B?QmdlK1NUQ1JzZDJ4ZXdnWnBpREptRDQxeUkxdURTM2tUNnJtN1hibGt3RTFi?=
 =?utf-8?B?NDYwT3o0UWY1K2JOTFdvZ1JMWjh4LzFmamtxdHVraHlQR1o5Z054TDlkZHhm?=
 =?utf-8?B?QTU4U3ZvY0Q5OUlRODQ3Y2Y3TTZEZDFMTzFWa2hjRGRuaWVBTWtsVTBlNklm?=
 =?utf-8?B?NldSTkpBMURzQjUwRkg4VXZidmdhMnhNVmJpWk4rN1NpSjJKZlJlSHpRdmdl?=
 =?utf-8?B?cTIvMytBOS9DcEhUNlVOWm1XL3NpK2hzb1NuZjE0aEJETGhhUG0vbzlEVzA5?=
 =?utf-8?B?NzlCNzJkUTVXNWphbmc1MTJUQi9xbm5oVnladEYzVTRxZ3phcm51amZyL2Iy?=
 =?utf-8?B?L0tuZllncUx4dUI4TGhXS1F2M1lkTTk4VXhhVlFGSWI2V2QyZWRiZE1wMlAy?=
 =?utf-8?B?UDM3TDh0cEN2NWxoVFIxZGZTSm90ZVlTNTNGR3R4U3BTMmphUUQwejRLUy9i?=
 =?utf-8?B?ZDN2TEdCQ3RVVHFGREt4N1RxbUNiZVAyRVlGazBKTHdxTXJwdGM3eXBGNDBo?=
 =?utf-8?B?UmxIRlJIZ0wvdVMzRFdtZWYrTVZ2aHdXclFqemZ2RStXcDhSK1MzcllId25P?=
 =?utf-8?B?eWlKRG9WWjNzUEFJSHJHbmtuNytuUHROdWtiOHFXcFh2RVE4Nzg4TkVjN1Jn?=
 =?utf-8?B?aG1KUFVjU3NLcGZkTUJsWVJxZ3RTRTNYSkdaNjlmdzhQSkhGclUrMGc4T2dU?=
 =?utf-8?B?ZWVoN1I2T3RhNGwzc25LUC9FNnhtNFlaLythQk1DZERyeTAzL0h5YjYveDA0?=
 =?utf-8?B?Vi81WXFHRHpHL05jeFNEUGxyNlMxcXduT0NxYldhL3FaNlU2RWNPRzdBeUZF?=
 =?utf-8?B?VkM2R3ZlUk84VGFvVW5IY2grU0NMUStuV3pvVmZ2QWFRWURVc1ZCTFJ1c0h0?=
 =?utf-8?B?VStEdWxtSlBrYWNkcGt4c29HbzFmYU1yQ0Mva0o0UkhPSkhMYUV2Q1VqK2d0?=
 =?utf-8?B?WVJDUnd2bDdoVFFuSW9ORG5UUVpBUzN6TWVYMHZ2T0M3RW5iL2pYRHlEK1or?=
 =?utf-8?B?NitpcDdNdm9JSjNENkV5aDV2UGhLdjBqRFVJanhKM29YUjJCR1ZxQ2g2clNG?=
 =?utf-8?B?OGhCUzg5bElYOXZSbjU3dmo1blhUUWlBQUtLWC8rUGo3WHZQQkFCeHVwaUV3?=
 =?utf-8?B?NHJ6eDJTWXRUc2tKeFdPaHBBOXFFZVRvMmJBMlp6WHNERFI0ZEkxY2RhNmt6?=
 =?utf-8?B?akZwTi91UjVUWVdiOFhMcis4WXRCbklaSmwxMjJ4ME9XRHBNT05na1lUWnNh?=
 =?utf-8?Q?fcteDROKG8HpyyR6HpR/2ytkj7eJ+4jW?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3951ff1c-250a-42d4-6e9c-08da07e46a06
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 07:04:44.0653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5cvXvxvr/wSY+I046FfbRDws/OMm4GHG/sIqCF/BYlRWthK78QTXEk/FTNm9SR1m2vJL06k9193ZwRzSl88xEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8549
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 17, 2022 at 10:18:45AM +0800, Shung-Hsi Yu wrote:
> On Tue, Mar 15, 2022 at 06:48:54PM -0700, Martin KaFai Lau wrote:
> > This patch removes the libcap usage from test_verifier.
> > The cap_*_effective() helpers added in the earlier patch are
> > used instead.
> > 
> > Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> > ---
> >  tools/testing/selftests/bpf/Makefile        |  3 +-
> >  tools/testing/selftests/bpf/test_verifier.c | 89 ++++++---------------
> >  2 files changed, 28 insertions(+), 64 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index fe12b4f5fe20..1c6e55740019 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -195,6 +195,7 @@ $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
> >  CGROUP_HELPERS	:= $(OUTPUT)/cgroup_helpers.o
> >  TESTING_HELPERS	:= $(OUTPUT)/testing_helpers.o
> >  TRACE_HELPERS	:= $(OUTPUT)/trace_helpers.o
> > +CAP_HELPERS	:= $(OUTPUT)/cap_helpers.o
> >  
> >  $(OUTPUT)/test_dev_cgroup: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> >  $(OUTPUT)/test_skb_cgroup_id_user: $(CGROUP_HELPERS) $(TESTING_HELPERS)
> > @@ -211,7 +212,7 @@ $(OUTPUT)/test_lirc_mode2_user: $(TESTING_HELPERS)
> >  $(OUTPUT)/xdping: $(TESTING_HELPERS)
> >  $(OUTPUT)/flow_dissector_load: $(TESTING_HELPERS)
> >  $(OUTPUT)/test_maps: $(TESTING_HELPERS)
> > -$(OUTPUT)/test_verifier: $(TESTING_HELPERS)
> > +$(OUTPUT)/test_verifier: $(TESTING_HELPERS) $(CAP_HELPERS)
> >  
> >  BPFTOOL ?= $(DEFAULT_BPFTOOL)
> >  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> > diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> > index 92e3465fbae8..091848662b7a 100644
> > --- a/tools/testing/selftests/bpf/test_verifier.c
> > +++ b/tools/testing/selftests/bpf/test_verifier.c
> > @@ -22,8 +22,7 @@
> >  #include <limits.h>
> >  #include <assert.h>
> >  
> > -#include <sys/capability.h>
> > -
> > +#include <linux/capability.h>
> >  #include <linux/unistd.h>
> >  #include <linux/filter.h>
> >  #include <linux/bpf_perf_event.h>
> > @@ -42,6 +41,7 @@
> >  #  define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS 1
> >  # endif
> >  #endif
> > +#include "cap_helpers.h"
> >  #include "bpf_rand.h"
> >  #include "bpf_util.h"
> >  #include "test_btf.h"
> > @@ -62,6 +62,10 @@
> >  #define F_NEEDS_EFFICIENT_UNALIGNED_ACCESS	(1 << 0)
> >  #define F_LOAD_WITH_STRICT_ALIGNMENT		(1 << 1)
> >  
> > +/* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
> > +#define ADMIN_CAPS (1ULL << CAP_NET_ADMIN |	\
> > +		    1ULL << CAP_PERFMON |	\
> > +		    1ULL << CAP_BPF)
> >  #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
> >  static bool unpriv_disabled = false;
> >  static int skips;
> > @@ -973,47 +977,19 @@ struct libcap {
> >  
> >  static int set_admin(bool admin)
> >  {
> > -	cap_t caps;
> > -	/* need CAP_BPF, CAP_NET_ADMIN, CAP_PERFMON to load progs */
> > -	const cap_value_t cap_net_admin = CAP_NET_ADMIN;
> > -	const cap_value_t cap_sys_admin = CAP_SYS_ADMIN;
> > -	struct libcap *cap;
> > -	int ret = -1;
> > -
> > -	caps = cap_get_proc();
> > -	if (!caps) {
> > -		perror("cap_get_proc");
> > -		return -1;
> > -	}
> > -	cap = (struct libcap *)caps;
> > -	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_sys_admin, CAP_CLEAR)) {
> > -		perror("cap_set_flag clear admin");
> > -		goto out;
> > -	}
> > -	if (cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap_net_admin,
> > -				admin ? CAP_SET : CAP_CLEAR)) {
> > -		perror("cap_set_flag set_or_clear net");
> > -		goto out;
> > -	}
> > -	/* libcap is likely old and simply ignores CAP_BPF and CAP_PERFMON,
> > -	 * so update effective bits manually
> > -	 */
> > +	int err;
> > +
> >  	if (admin) {
> > -		cap->data[1].effective |= 1 << (38 /* CAP_PERFMON */ - 32);
> > -		cap->data[1].effective |= 1 << (39 /* CAP_BPF */ - 32);
> > +		err = cap_enable_effective(ADMIN_CAPS, NULL);
> > +		if (err)
> > +			perror("cap_enable_effective(ADMIN_CAPS)");
> >  	} else {
> > -		cap->data[1].effective &= ~(1 << (38 - 32));
> > -		cap->data[1].effective &= ~(1 << (39 - 32));
> > -	}
> > -	if (cap_set_proc(caps)) {
> > -		perror("cap_set_proc");
> > -		goto out;
> > +		err = cap_disable_effective(ADMIN_CAPS, NULL);
> > +		if (err)
> > +			perror("cap_disable_effective(ADMIN_CAPS)");
> >  	}
> > -	ret = 0;
> > -out:
> > -	if (cap_free(caps))
> > -		perror("cap_free");
> > -	return ret;
> > +
> > +	return err;
> >  }
> >  
> >  static int do_prog_test_run(int fd_prog, bool unpriv, uint32_t expected_val,
> > @@ -1291,31 +1267,18 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
> >  
> >  static bool is_admin(void)
> >  {
> > -	cap_flag_value_t net_priv = CAP_CLEAR;
> > -	bool perfmon_priv = false;
> > -	bool bpf_priv = false;
> > -	struct libcap *cap;
> > -	cap_t caps;
> > -
> > -#ifdef CAP_IS_SUPPORTED
> > -	if (!CAP_IS_SUPPORTED(CAP_SETFCAP)) {
> > -		perror("cap_get_flag");
> > -		return false;
> > -	}
> > -#endif
> > -	caps = cap_get_proc();
> > -	if (!caps) {
> > -		perror("cap_get_proc");
> > +	__u64 caps;
> > +
> > +	/* The test checks for finer cap as CAP_NET_ADMIN,
> > +	 * CAP_PERFMON, and CAP_BPF instead of CAP_SYS_ADMIN.
> > +	 * Thus, disable CAP_SYS_ADMIN at the beginning.
> > +	 */
> > +	if (cap_disable_effective(1ULL << CAP_SYS_ADMIN, &caps)) {
> > +		perror("cap_disable_effective(CAP_SYS_ADMIN)");
> >  		return false;
> >  	}
> 
> Seems slightly strange for a is_* function to have the side effect of
> disabling capability, also, this change of behavior in is_admin() is not in
> the commit message.
> 
> Maybe a better place to disable CAP_SYS_ADMIN is at the beginning of main()?
> That seems to be the only place is_admin() is called.

Just realized there's a v2 and it's already merged. Sorry for the noise.

Shung-Hsi

> > -	cap = (struct libcap *)caps;
> > -	bpf_priv = cap->data[1].effective & (1 << (39/* CAP_BPF */ - 32));
> > -	perfmon_priv = cap->data[1].effective & (1 << (38/* CAP_PERFMON */ - 32));
> > -	if (cap_get_flag(caps, CAP_NET_ADMIN, CAP_EFFECTIVE, &net_priv))
> > -		perror("cap_get_flag NET");
> > -	if (cap_free(caps))
> > -		perror("cap_free");
> > -	return bpf_priv && perfmon_priv && net_priv == CAP_SET;
> > +
> > +	return (caps & ADMIN_CAPS) == ADMIN_CAPS;
> >  }
> >  
> >  static void get_unpriv_disabled()
> > -- 
> > 2.30.2
> > 
> > 

