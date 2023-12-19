Return-Path: <bpf+bounces-18301-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1A5818AB8
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 16:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC1871F29999
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40151CA9E;
	Tue, 19 Dec 2023 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=polimi.it header.i=@polimi.it header.b="sEBhQ8Bh"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C891CF8A
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=polimi.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=polimi.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3dXupeFSY/m24uw228mgkz7JxZBaDyvCpnrnnWXxNS/agFYtTTyGQ7JgizxjxETRhJfoCRTKVk4cBAD14DUR+VWfz3vBRRLPkr5htCVrgMgs22uofs9tv65vtLNCjFHv9/DaMKbujNgQPLYEmy6T+EGbvH9ktHWk2OARCE4vrN01YNC+XNtv3jCk5IXbWJHU1SLISZSRhE5mkCO7irhX1Q+zsRYgQaCgyI1UFItrgE2hyMjioWwEul1whtDM9GODZRWHShE/A4dM6Js9DLsQh2wXpj5Dk1T0VZHERklMH4lakJOc/JdeUskzQeMWiXKc+3oOArcuSzS4hyewW28/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owB0fhr0Dr5mBrWoKzcAiQBUlkQ4CN1IqyAgIuhTKXU=;
 b=aRe6m+hNAik2Fe9DiT5YRofEdfWkp4MU2+g+1hJRw7pJ7dgmDdzD1G7KEUaXCQTyCgLqIxGcPJq710tmUDfWa3gfAKm3/NyzmUItuNcaXyDfGjtR1N6K9arRz3F4fXhMqcyc3j48Uqtp0x8JtIkcrv9nkOaKkCirYKKxvOLyMazHzus+i1U3cN4Q7aEZpaR8Ar8Uw60N6k/YLmR+4V26aNLPP3vHwX3KHp4wC/vlxcvk6KoaO/6PwS83APTmOUWz552L1Mj2la+RUGLbr8LBkzer0G49XpiyxSQcTRU67YuxYWVlU2vNOgz1rMh4ehKniZp+XK6jZ3g1RLvtyI51hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=polimi.it; dmarc=pass action=none header.from=polimi.it;
 dkim=pass header.d=polimi.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polimi.it;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owB0fhr0Dr5mBrWoKzcAiQBUlkQ4CN1IqyAgIuhTKXU=;
 b=sEBhQ8BhwyJEDxEI+AmKaRQVBStQnKA9ET8aZnknfEFimmN7bQ45VFH0t4xlAbwFEGKBEptbUyHG3OuC/L3BkQ3m3Az8d+lWLH3/KsBTR0GC6OXIy5BTYSoXvp88TRpVTKNf4EPXVzqDDPEaLXsEdpiWX4XymWk9w49mQCaXhDD1+scWVRgZmWdcfHE6BNysho0rpuCqPQnesQ1UOuEm+WMhHBMoEMSJjCzOIpCLQwx2M5gR5g71mtU76X7esZ6qFFI2m0i4SOOp1uS8QYYW0JYMiWBSAnUDllsTwIjvJ2LmlEkBI9Qxns4wndVUlwlWdVeo9gz5eAD7jZAJzfA4ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=polimi.it;
Received: from DB9P251MB0389.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:2ce::14)
 by AS4P251MB0896.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:580::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.10; Tue, 19 Dec
 2023 15:00:23 +0000
Received: from DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 ([fe80::afd1:5d4a:c4d0:945c]) by DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 ([fe80::afd1:5d4a:c4d0:945c%7]) with mapi id 15.20.7113.016; Tue, 19 Dec 2023
 15:00:23 +0000
Message-ID: <901d67ce-1344-4015-ac2d-7ca7dc28acc4@polimi.it>
Date: Tue, 19 Dec 2023 16:00:21 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Farbod Shahinfar <farbod.shahinfar@polimi.it>
Subject: Unexpected behavior from BPF/XDP program
Organization: Politecnico di Milano
To: bpf@vger.kernel.org
Cc: ast@kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0059.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::7) To DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:2ce::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P251MB0389:EE_|AS4P251MB0896:EE_
X-MS-Office365-Filtering-Correlation-Id: 24ad76c0-d58d-41eb-2e07-08dc00a33a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KAWRPo02LoEe+TeU1I4RIhb4CzRwdQPp2aFeppoSZMVns2oUUMiRv+ZGk0H+84d8tLovQ0jesJUD9yIMHB6vS9QlA6leFjCacNrKHEwhgS+aD3bhmfw3heCFhV1DzpfPx3xUdF0S2sF0ePzZDzmUOMAMD6dRWOS8JqUkyt6N8F8wgFLjm9o20NBUmcGTphmL0JRWyx5XWxfSaQiJxaB1KsoylYy4l9jrdJDoAhcB2l6kXRdOfYAaIU8c4PJvrQS04oSarIW4STqWTXkgHBOB6DKdljmGod0q0Mx9zWo19+ltf+ustSX+/w2Vn4djtyC2ObPFzxCycGcNcSx5Qfakz1uQ55uIYho0jXHr+pVxwcuL6DRIW+NIHQ2YVvcIBoIEMmzIL2td+NQVIkwq6kZNm8i7t+m7TGIRtkkAGYZ9S7msgJLHUmqm6YAKrFiF1w/KgnhF4VU/moml1Ayw6H38RIfMKAVOd3kvG06ToQI15aswMnCedeIhbUTMmqjvrd4+HCn1JGxpt57ExO+xrt0OYFTo1/bR3z2xOyimY4nL/F8d7sdEhFI1DyVjl2Wd+LwxJO3JWIiqMTx+TPMpeuAEN5wgeV2G7InyC8oWQhoGqcf1DxFsw+HR/arHmpexOW/OVnGcZ+rwyfSnOYzXFsH38g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P251MB0389.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(8676002)(8936002)(36756003)(31696002)(41300700001)(38100700002)(86362001)(2906002)(44832011)(5660300002)(26005)(36916002)(31686004)(2616005)(6512007)(6486002)(6506007)(478600001)(66476007)(66946007)(66556008)(6916009)(786003)(83380400001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWZ4QWJmRE5pcnhoTVlsMzhNY1JTUXJudkJKQmZvc05YbVlDS0wvMExEUTVQ?=
 =?utf-8?B?aVd1Rzk4UWNIcHhvcHlId0lBbFA0TWFnZGNOamFCejZtdHhNOWswWmtiNG03?=
 =?utf-8?B?TEVBWk1vMjFlMWhOcWFMcWlOd0tNY3BTUE1RRnpYQWlFa3R5VC90U0ZhSGZy?=
 =?utf-8?B?VHNRTG1hUUlMRFhBNEF6NjlycWdhenJLZmNHUHBMRGJPeFROeXoxOGs2cFQx?=
 =?utf-8?B?MFNjVGM1d1oyRisyMEdQTXcvS0srTUpzZWlqa1lscVIxRXdJK0pwd2FaRzlZ?=
 =?utf-8?B?dXQ1eTh4OVBmMUZIMzhVd2Z2SWtyMFFkS2tUdmpvZEZ2TjMvUmNxT1c1Y0ov?=
 =?utf-8?B?eTR3L0VDL24yUnF6c2hGakd3OXhSckRyVkVGQzFEUEl3OFBYbFRSckpiUWlM?=
 =?utf-8?B?SkRYT3NhdGgyODhxNUwxT0tQTVlxZHo1M0ZWZmdmR01KS1M0TndXK09LTVVV?=
 =?utf-8?B?bGdHSXl3bzVIWm5KbElGREdGWkpMajVVQjhMTElJckwzRlhaalpxZzZvV3VR?=
 =?utf-8?B?RElWNDFXUjVOMDdYNHlENjRWSk1sMEVJdlFUL3djQU9qd0lJWXFjN2hqNWF3?=
 =?utf-8?B?T3lNdXNqVDVvbnNHdXp6ellFMDkrdXVVL0RnSW4zZU8yQ1RvOFJPN292NjRJ?=
 =?utf-8?B?OWpzVC9VTWh6RFFWaUNkSnpGSjlLbG9HTUs5S1gxcTlMekZtN1pTWEpRZFlI?=
 =?utf-8?B?MEtDZzJpOCtZS1V2cGxJaWtUNXliYk5XRlBteGpPWmVzNURmZHhUMGZuVVBk?=
 =?utf-8?B?MDcrWHNoa3FTZ0dNaWJnWDF1WWlLTlFNNFpVYWxKampwZzVudFFNdHBlM0lV?=
 =?utf-8?B?YXpaOFBLYkYvK2U5S3FIWmxnZGRGRlYraktHMEdReGtKazJnT0JBd3ZIYXlj?=
 =?utf-8?B?NjNESEFLYTN5R2FnYStWd0hxaW1WeGZkUEpwaVhoRlJ5S2VKSm5ZMXl5R0pI?=
 =?utf-8?B?RWxWU1lBOWQ0Z0RSTVZpVkNvN0hUVGFDOVZ4MnZkK3RoTlE0amcwWkk4UWhE?=
 =?utf-8?B?N3dvZnRHeVFhNXlOUXd2OGZVeGlNdExORmI1SmhqemcxRVRlVDlzSVNPZDRI?=
 =?utf-8?B?KzRWVFZxZmhhNklYUUY0UDlZQjBtek1za2ZFM2RRamdmZnZnZ1RYSGgydVYv?=
 =?utf-8?B?R3VzdlhITjRmWTNRb0RWMG9ONU14eldMS29paUNQTW5GeDF0MmhZQ0cxM0R4?=
 =?utf-8?B?TUl5VnBMVkZaVC9pTi9MM1pHZURubkVzTkl3QTUrNGhoUmNXOCs5U2plb3Uz?=
 =?utf-8?B?UmFWdDNpRE1jQ1B0YlBJR2VQb2h3cEk5YTlXMWUvWWhCRFV2czBFOHg1Yzdy?=
 =?utf-8?B?UlYzelZqWWpKZnNCUVhDN1FFVVB3bFc2c2ZyS3h3UmQvZ2JZMzJRUFNTNHhF?=
 =?utf-8?B?UVlseVdWU2IrOVMxOEpSU3lSdFlUelU1VUYwejk1OXNkQW1xTTRXT3pHalk5?=
 =?utf-8?B?cDhibUF6UTBOOFdrdHc1R0JJZjNwMlVENEhIWXRWQlB6bTJQUFRleVFsTUQ5?=
 =?utf-8?B?SG9YTkVudElrQWdENTBJRFJ3RW5wSkoxUFhISU1KV1Z1TU00ZkpmcDhlRTR4?=
 =?utf-8?B?Q2IySCtZNWpLVXNBL1RzQ1BvTFZJM2dDNFdqSUpsOXFwelF5UW5vL1VoalVR?=
 =?utf-8?B?L1IvNUJzK0NXWC9YNGF4dTdrWUw0WmQyNjNaZ05yeVJwdkNoMURkd2pvOWY5?=
 =?utf-8?B?Vjh2ZXI1OUNyQVdpZGZJNngweDdueGhoM25VZllOMUplT09xQWdDeENSRGpU?=
 =?utf-8?B?cWZRSytRTUNKWXF0amhUUjF4RXFydnR4bkt5YThuZWxUZ0h0OWhCeTY3a3FB?=
 =?utf-8?B?Vklka2hoU0pkMTNjR3Y0MCtEbUR2NnIyR1NOcjMvMHpUSmwySnZ4eXN2OFNK?=
 =?utf-8?B?Z3piZXJXYjZUNURVZUxNaDNaVW9iaUk0K3VpYkJFckJheTRGbkxvc09rVU1D?=
 =?utf-8?B?RFMrdjJUcTZ4MWZrU1pLUmNEUTQ2enBBdDNKR0F2MWRWQ2ZDMkVQcklsMVBa?=
 =?utf-8?B?d1NEc2RTT1krNmVJeUh1YndPbU1RR0MrN3FUZXJNdFNFRFE4c3ZRbjJyMCsx?=
 =?utf-8?B?QUN6Y3pSazdlVDhrZ2RKQjlVWDBOWnVlYkxWRUZYWGhvQ2wwL2lhUllSSVhR?=
 =?utf-8?Q?b8TllIpCu6lTlfZ2u8NoynziR?=
X-OriginatorOrg: polimi.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ad76c0-d58d-41eb-2e07-08dc00a33a16
X-MS-Exchange-CrossTenant-AuthSource: DB9P251MB0389.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 15:00:23.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0a17712b-6df3-425d-808e-309df28a5eeb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Q2LcK0j4jyo3gRNfydVYxnGhV7jtZIJmTAc1kSrAGb4S4Z3PCChwAOfpa+zQHCqCNcE3nQkAlAxqanQYqTFxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P251MB0896

Hello BPF mailing list,

I am observing an unexpected behavior when running the BPF/XDP code 
attached to this mail (`found_bpf.c`). The branch taken after performing 
the comparison `i >= g` is wrong. Basically, running this program using 
the test code logs the line `BOOM;0;24`. It means that i=0 and g=24 but 
still conditional branch `i >= g` is evaluated as true. The tester 
program is also attached to this email. It uses BPF_PROG_TEST_RUN. The 
source code provided is created from a more complex program using 
`creduce`.

The program has been tested on x86_64 machines with these CPUs.

- Intel(R) Xeon(R) CPU E5-2640 v4 @ 2.40GHz
- Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz

The kernel versions tested are:

- v6.1.0
- v6.5.6
- v6.6.0

The clang compiler is used. The tested versions are:

- v16
- v18


I suspect the issue is related to the use of bpf_loop but I do not have 
any strong evidence. Is this a known issue? Have I done something wrong? 
How can I debug this further more?

I am using following commands to compile the source code to the BPF binary.

```
CC=clang-18
LLC=llc-18
$CC -S \
         -target bpf \
         -D __BPF_TRACING__ \
         -Wall \
         -Wno-unused-value \
         -Wno-pointer-sign \
         -Wno-compare-distinct-pointer-types \
         -O2 -emit-llvm -c -g -o $LL_FILE $SOURCE
$LLC -mcpu=probe -march=bpf -filetype=obj -o $BINARY $LL_FILE
```

And this command for compiling the tester program (tester.c)

```
CC=gcc
CFLAGS = -Wall -g -O2
$(CC) $(CFLAGS) -o ./tester ./tester.c -lbpf -lelf -lz -lpthread
```

The tester program can be executed like `sudo ./tester -b ./bpf.o`.

The logs can be read from:`sudo cat /sys/kernel/debug/tracing/trace_pip`

Sincerely,
Farbod


Attachments:

---
found_bpf.c

#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <linux/ip.h>
#include <linux/udp.h>

#define memset(b, c, d) __builtin_memset(b, c, d)
#define e(...) bpf_printk(__VA_ARGS__)

struct f {
   short g;
};

struct u {
   int l;
   char *head;
   char found;
   struct xdp_md *xdp;
};

static long loop(int index, void *arg) {
   struct u *ll = arg;
   if ((void *)(ll->head + 1) > (void *)(__u64)ll->xdp->data_end)
     return 0;
   if (ll->head[ll->l] == '\n') {
     ll->found = 1;
     return 0;
   }
   ll->l++;
   return 0;
}

/* NOTE: Allowing for optimization solves the issue for this simple 
program */
__attribute__((optnone))
static void test(struct f *n) {
   __u32 g = n->g;
   long i = 0;
   /* NOTE: removing the else block seems to solve the issue */
   if (i >= g)
     e("BOOM;%d;%d", i, g);
   else
     ;
}

int parse(char *b, struct f *n, struct xdp_md *xdp) {
   char *head = &b[4];
   struct u t = {
     .l = 0,
     .head = head,
     .found = 0,
     .xdp = xdp
   };
   /* NOTE: It seems for iters=25 is the smallest value that causes the 
bug */
   bpf_loop(55, loop, &t, 0);
   if (t.found == 0)
     return 0;
   n->g = t.l;
   return 0;
}

SEC("xdp")
void xdp_prog(struct xdp_md *xdp) {
   char *q = (void *)(__u64)xdp->data + sizeof(struct iphdr) +
     sizeof(struct udphdr);
   struct f r;
   memset(&r, 0, sizeof(struct f));
   parse(q, &r, xdp);
   test(&r);
}

char s[] SEC("license") = "GPL";

---


Second attachment
---
tester.c

#define _GNU_SOURCE
#include <arpa/inet.h>
#include <sched.h>
#include <pthread.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <errno.h>
#include <signal.h>
#include <string.h>
#include <getopt.h>
#include <net/if.h> /* if_nametoindex */

#include <linux/bpf.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include <linux/if_link.h> // XDP_FLAGS_*

#include <linux/if_ether.h>
#include <linux/ip.h>
#include <linux/udp.h>
#include <linux/tcp.h>


struct parameters {
	/* Just load BPF programs do not attach */
	char *binary_path;
	int repeat;
	char *progname;
};
static struct parameters args = {};

void usage(void) {
	printf("loader:\n"
		"  --binary    -b   path to binary file\n"
		"  --repeat    -r   [default 1]\n"
		"  --prog-name -n   [default xdp_prog]\n"
		"  --help      -h\n"
	);
}

void parse_args(int argc, char *argv[]) {
	int ret;

	struct option long_opts[] = {
		{"help",      no_argument,       NULL, 'h'},
		{"binary",    required_argument, NULL, 'b'},
		{"repeat",    required_argument, NULL, 'r'},
		{"prog-name", required_argument, NULL, 'p'},
		/* End of option list ------------------- */
		{NULL, 0, NULL, 0},
	};

	/* Default values */
	args.repeat = 1;
	args.progname = "xdp_prog";

	while (1) {
		ret = getopt_long(argc, argv, "hlb:i:", long_opts, NULL);
		if (ret == -1)
			break;
		switch(ret) {
			case 'b':
				args.binary_path = optarg;
				break;
			case 'r':
				args.repeat = atoi(optarg);
				break;
			case 'p':
				args.progname = optarg;
				break;
			case 'h':
				usage();
				exit(0);
				break;
			default:
				usage();
				exit(1);
				break;
		}
	}
}

int main(int argc, char *argv[])
{
	int ret;
	struct bpf_object *bpfobj;
	struct bpf_program *prog;
	int prog_fd;
	struct bpf_test_run_opts test_opts;
	struct xdp_md ctx_in;
	struct xdp_md ctx_out;


	cpu_set_t cpu_cores;
	CPU_ZERO(&cpu_cores);
	CPU_SET(0, &cpu_cores);
	pthread_setaffinity_np(pthread_self(), sizeof(cpu_set_t), &cpu_cores);

	parse_args(argc, argv);
	printf("BPF binary: %s\n", args.binary_path);
	bpfobj = bpf_object__open_file(args.binary_path, NULL);
	if (!bpfobj) {
		fprintf(stderr, "Failed to open the BPF binary!\n    %s\n",
				args.binary_path);
		return EXIT_FAILURE;
	}

	/* Load the program to the kernel */
	ret = bpf_object__load(bpfobj);
	if (ret != 0) {
		fprintf(stderr, "Failed to load program to the kernel");
		return 1;
	}

	/* Prepare the packet */
	char *reqstr = "set my key req\nhello world is the value\n";
	const size_t payload_size = strlen(reqstr);
	const size_t max_buf = 4096;
	char *pkt = calloc(1, max_buf);
	char *out_pkt = calloc(1, max_buf);
	size_t pkt_size = sizeof(struct ethhdr) + sizeof(struct iphdr)
		+ sizeof(struct udphdr) + payload_size;
	struct ethhdr *eth = (struct ethhdr *)pkt;
	struct iphdr *ip   = (struct iphdr *)(eth + 1);
	struct udphdr *udp = (struct udphdr *)(ip + 1);
	char *payload = (char *)(udp + 1);
	memset(eth->h_source, 0xff, ETH_ALEN);
	memset(eth->h_dest, 0xff, ETH_ALEN);
	eth->h_proto = htons(ETH_P_IP);
	ip->ihl = 5;
	ip->version = 4;
	ip->tos = 0;
	ip->tot_len = htons(sizeof(struct iphdr) + sizeof(struct udphdr)
			+ payload_size);
	ip->id = 0;
	ip->protocol = IPPROTO_UDP;
	ip->check = 0;
	ip->saddr = htonl(0x7F000001);
	ip->daddr = htonl(0x7F000001);
	udp->source = htons(1234);
	udp->dest = htons(8080);
	udp->len = htons(sizeof(struct udphdr) + payload_size);
	udp->check = 0;
	memcpy(payload, reqstr, payload_size);

	/* TEST */
	prog = bpf_object__find_program_by_name(bpfobj, args.progname);
	if (prog == NULL) {
		fprintf(stderr, "Failed to find xdp_prog");
		return 1;
	}
	prog_fd = bpf_program__fd(prog);
	if (prog_fd < 1) {
		fprintf(stderr, "Failed to find the program file descriptor");
		return 1;
	}
	printf("Program fd: %d\n", prog_fd);

	memset(&ctx_in, 0, sizeof(ctx_in));
	memset(&test_opts, 0, sizeof(struct bpf_test_run_opts));
	ctx_in.data_end = pkt_size;

	test_opts.sz = sizeof(struct bpf_test_run_opts);
	test_opts.data_in = pkt;
	test_opts.data_size_in = pkt_size;
	test_opts.data_out = out_pkt;
	test_opts.data_size_out = max_buf;
	/* test_opts.ctx_in = &ctx_in; */
	/* test_opts.ctx_size_in = sizeof(ctx_in); */
	/* test_opts.ctx_out = &ctx_out; */
	/* test_opts.ctx_size_out = sizeof(ctx_out); */
	test_opts.repeat = args.repeat;
	test_opts.flags = 0;
	test_opts.cpu = 0;
	test_opts.batch_size = 0;

	ret = 0;
	ret = bpf_prog_test_run_opts(prog_fd, &test_opts);
	if (ret < 0) {
		perror("something went wrong\n");
	}
	printf("return value: %d\n", test_opts.retval);

	bpf_object__close(bpfobj);

	return 0;
}

