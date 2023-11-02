Return-Path: <bpf+bounces-13906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E63217DEC61
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 06:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB531C20EE1
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 05:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8164432;
	Thu,  2 Nov 2023 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HxYYUV+y"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DE34C8B
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 05:39:50 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2082.outbound.protection.outlook.com [40.107.13.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C34127
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 22:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrdyQJ5MrciY4lRwKOwAxP+pYcsUGmevYJ5WKsogiFGZrbQGQsIbitkwjiWRDW7tr+a5vPEHTtGX8zX0OJwrOKbX/C4gNTS8mc9hBZokwg40WXA/ll9SLDq6jzXtpTN4O+WQSv279v0ZB5LfjwguSR8+CkVtR10mSY5SwKn5FUmGn2VROoQHx97zXzaX8la5OgVGvDk6dfn9VjuXBkr1ufXcGiPt4FBqam7fG2tTN/FVF7TuXWkfG1fgosmJ1bs3pacC9XnLNFGhcLTAykaOCEV1bljeoreS0ZpCL2oZ0eNY0xPSNb7vmITKgBbuODdc7gIPe9RMIu7fhBGEfW9q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRb7fT1/ix2yCD4SfbZbhdgZZiL/GzZYdmEX3jUyLU8=;
 b=HruA9eGfyU81/o5bu2Kbsw1dpUatsUaZCDDRjcAZNFDBukA0lR53+9x+xmhXF7sRM0nT/pQf2hhTwcp+OpxVy3suB6O7bv3ifbe8ubWQZo7zUIJ8eFgZYBM/USy9i5UL4kvJLmSILNVicxkHxPvV7ZP0NOZo4P1A4fHXirrhs1pLD7BGhAJGJm5mK1XUgO2kNA71M8wD2SWHELsalO3XJKbhFAOqYJU8FZGb7ThEi7MmxTHALiSOesRNIbyVFi0OqcQGi2q58a3bGTHa3FgDlhHlTU4iuWCwQ41twzk0bqvJ+q8qZGEM4kzoGGC7E9vusVpjEsUzt96Q1chaz1AigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRb7fT1/ix2yCD4SfbZbhdgZZiL/GzZYdmEX3jUyLU8=;
 b=HxYYUV+y6Q/h1njB2aOuf5WlYQ76ovWIohVhIaQdV5OLgWyjsBjRkMLqLoVAYK5wqWO5Tx35w3EO9YvAxxlEHHCFyOo7zhHujYxTz7qaJz3BAubRiHFPTAfA8kbOK0XRTvHHzqsVK1mQg9B+W3nDJfcKjwXjwiozLMxMZQsjqZSNNoMfAkRFbetW/d+D/xzBcy4hy0u5tEMZB7gr7a03oCRtXNU5oXcwa9KLJH200ywXVHunDYvUmYVMqKPOvcxl9C1OvmSTRhtqSFtAEzh8n8yE6vR+lQftSQ+LnTjcAPyCJdllxHwy/HAoXJhudcprwyDtXsUkBQgwBHtxjV4y6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS8PR04MB7687.eurprd04.prod.outlook.com (2603:10a6:20b:291::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 2 Nov
 2023 05:39:39 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 05:39:39 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf v1 0/2] bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
Date: Thu,  2 Nov 2023 13:39:02 +0800
Message-ID: <20231102053913.12004-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::7) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS8PR04MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: e32162b5-b439-4dfd-be71-08dbdb661ac6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fDTZY1Lq5+ZgZsjDdcpIUGUcXhc4Vah/iqRZNR1MDL3QybCdEz8Zxd9b+5wTB96LIrMpio1U9vvHPY9lOyUHltBAI0n2O7I4zIqYAX5lTbQ8+r0iToY1hWuQBWxQ3e2Sn7hbqD3NrStiZDB03/pTywqfU7EHX6DfPVnpb8m9T3Kc1l/uvNmZw1NkE1joLTxRHCwTpmSnXleTALYuDTv19xLsQ/cLaxc7TPcpgKaXYYe7Cn6+j0x2DFwVAkfjMsCyjidTMwcefLnzC+APZVwNE/jJqABuxlxSZ4hTSCftKfRr5dMGEy/9euAADEOmo+HazYS3nIpnNZODR2SnBBbtRNhC7vTnizcfM2tDCax1LVe+VH+HEqLqgAN6iDLDu6MDizrEFgH/kel2qJfObXT5SDEomy8wsHw+2zi2d1Y7ItPETz3STu84vu2ZQdAQaLqmB8crL2ne5b1VOqVm8gmctfewRjDi2KJK/PjUcoVZvNl3XvKrOQ87XHh9Bn1flVJ6X22nJgP8FSFWJuJmBpdAyBBzDRN5dmRaAoecx5+6a74NL4VXVZdt3SnXJja5nYUXIKqd+Eo4uRhJ0ao/nCHLIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(7416002)(41300700001)(54906003)(316002)(6916009)(66476007)(66946007)(2906002)(8676002)(6486002)(8936002)(5660300002)(4326008)(478600001)(966005)(38100700002)(6506007)(2616005)(6512007)(36756003)(83380400001)(66556008)(1076003)(6666004)(66574015)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEtmYndWa2hNTWJiTEF1S3N3eXYvWE55ZEpLcnMzUFNIcmtYdWxBc1liRWw0?=
 =?utf-8?B?eCttUjhhNUxsUTZvRUhWY2tpSDhKRTh2aW9leFMzT2hmNnpLNEI0dnZlemF1?=
 =?utf-8?B?dkhJcExOOHgvV20yaVZmSVN0dUErbmdpekxDY1h5MGJJVFErcGdKNFJnUDlW?=
 =?utf-8?B?SUNYSXhVblQ0d0FEeXRIci8velhPS1RnTER4d0pxSSthaStpSlRPbS9FT0Vx?=
 =?utf-8?B?SXpvWkQ5ejVaM2tPZG5SaUFPaCtrRnoyU3FqNTZvL0RpUko3Uk5RSm1iOUlh?=
 =?utf-8?B?TEhEenp4UDhxR0JpVVNwZHlyTk9hMlRtZWgvMlBiWVVnU2VLSmZ0RnU3K2Zx?=
 =?utf-8?B?Q0FzTXhxTXZTRFMvTEhLNTNta2pVSzdGdGRhcGZsWlk4aXc4cWl1REllZEtJ?=
 =?utf-8?B?UXJPeUdabko1MVBnamVOZDVTM3Vzcm0yTXl6WURScW51S3RrelA5MEd1eXlq?=
 =?utf-8?B?NDB3aHA5ZUNuZlFwMDRGdGExRFZnVVJDSjlqc1Z4d2I5dGR3dkkxTDF5Mzl6?=
 =?utf-8?B?UXYrNzRsRHlSWjRVT2lpaVNyUkw2dmM0b0dHYzdhakt6ZDJhVVlVZ0t5Q1Zq?=
 =?utf-8?B?NkdEU0RzWitjQ1BpNFREUGJVbXk4ak13K0JJN1lMU3BRdUVVa01LcCszOHVi?=
 =?utf-8?B?QThsQ3djVG55V09qcHBoVSt2Z0kxaG1EeEtzQXc2Q3pmNVd6TGFCT2hkK0d4?=
 =?utf-8?B?bDVWTXhhUW9jbG5YVlFSc1IrZzZoRE1Rbzg2b3JZdVZVZGZwbllabGZpcDZL?=
 =?utf-8?B?aFlGa29lZVo4eWxOMFh2eXl0UHAwU2dERnpJUEsybExISGh5Tm94UE9mTFZw?=
 =?utf-8?B?TjdiYjFKK1Z3eDJIS01GSUQwL1RXaVRVTVlIZDNRbVJyTDc0TmpCYlJIbGli?=
 =?utf-8?B?R3hUeG1WVUgyYjFTZm1nV2ZMdms4dkdNeFk3QkhLSlVIb0JOUnB1Z3NMVmtv?=
 =?utf-8?B?NHlVbWg1cGdQMnFwdmJyallEVXo5cGFwSThNa0cxa0M5YVNzZkRqcDVKc2Vq?=
 =?utf-8?B?U1NEbTFFSXBMYW9vRVZ5TzY4UDZ0NEg1SS9Obm15d3FBVWVTRDVybnRNdWpj?=
 =?utf-8?B?Vy9HcGdPdmJMb1ZJMTNVQVppU3FYd2tSdXMrYTczOTBDdkZ6L0hQbmxLYmNH?=
 =?utf-8?B?UjcrMklvaFk1TGQ4cXJjMGwxVHB5MURhbExaRllMMkdDN2lOR3BIWCtWUHZ0?=
 =?utf-8?B?cHNXOHM3STdlRE50RHpzVFVhQ0hDUGN3ODFIQys0OXc5eUhTWXo1Zk5XUlNn?=
 =?utf-8?B?OEdFbmNwUURWWFAyRDJCcm1udlFORkxIYWtDaDJKRjJRK3d4RzVwaWwvYzRv?=
 =?utf-8?B?T2c1L0dFVk4yWndrc1hqUEFhR1QvdFhqckxOWUFtK3BxWTBURWJiV0VQTzZJ?=
 =?utf-8?B?VStwektwd0s4SGdEZ1FaZUgzbHgxb0NlclNxREV3anZuUkF6MWJnMWdHWXVD?=
 =?utf-8?B?MVUwNUR2bENKZFpPQUxRNjk4WWtCZ2FZRVVLOUUzNVQ0VlBEUzNzMmRXL2Jm?=
 =?utf-8?B?TE43MVlsNmZEMnR1VlljZmNNMjloWWhWbDg0NVh0cHl2SXl3QXJVUW9XbCtD?=
 =?utf-8?B?OUtEQVNuVWZ2UmVTZnhCU3lUN2tvaTd3clRWUEpSK0g5MXVkUXFSTWExVEdD?=
 =?utf-8?B?YW5vdzhSQTNxRUR3dGlKMUdLdjdFcmgzUXBsV3FqeVZPbEFZemhUZVl3b253?=
 =?utf-8?B?MVVuWjkyZVRBRVVjRWE2MEUvMUZvUmNDUkRBYXFFVHFEaVhVMFBDNkg1Wlln?=
 =?utf-8?B?WGVxS1RvZGpOdHg0UE13bk4ya3g2SlJ5b2ZxQXpTdnFndEhxaVFmS0lzVGZJ?=
 =?utf-8?B?N0swN0h5TXhDMy9MazVSWEhIdG55aUJlODJ1UURQdDRjVDlIU0RUNERuSmxh?=
 =?utf-8?B?dmFnbThZck4xZDlNNjlENUJBSkhwTVZ1MkZuTGFiQUFXRE1Ud0ZhbVhKZzIy?=
 =?utf-8?B?WGFLRTA4d0Rib1VPQkp3Q0FlczlMSTlhcFpsbk9ETG1HUVJqZ2lTMlNIWUpp?=
 =?utf-8?B?MTBRNXlHTDZqODBqVUFydVRpREE1VHFuQnl4WDNvY0k4cHNkTUx4TFAza1pv?=
 =?utf-8?B?UXFrcytwK2lwRlhUTmJxU1JmdnErQU0rQ1RPL01TRFhFek55aDZ3SS9OZElJ?=
 =?utf-8?B?OEpJVXZzcTRhNUlvS2dlS3V2VDFvZHg2Um5HajBZTTh3YzRLeE9iVmFBSVZK?=
 =?utf-8?B?MDlMOTAwdTdWWXJQUDU0SEpxN2pyQlFRTy9nYlRaTGt1UDFWM2lNbUx6OEtx?=
 =?utf-8?B?ZmVYcGx5ZkNaVnlvdmlXaVRrRGxBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32162b5-b439-4dfd-be71-08dbdb661ac6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 05:39:38.8756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SG4GmuZDRmv6f3G+kc2V1Jjuc8b/R5RuCJ6d72iSVBwb1d3JggChtx6nL8jr0xHH3mW+4uy7O+JwspXJvmwfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7687

Changes since v1:
- add test for negation and bswap (Alexei, Eduard)
- add test for BPF_TO_LE as well to cover all types of BPF_END opcode
- remove vals map and trigger backtracking with jump instead, based of
  Eduard's code
- v1 at https://lore.kernel.org/bpf/20231030132145.20867-1-shung-hsi.yu@suse.com

This patchset fixes and adds selftest for the issue reported by Mohamed
Mahmoud and Toke Høiland-Jørgensen where the kernel can run into a
verifier bug during backtracking of BPF_ALU | BPF_TO_BE | BPF_END
instruction[0]. As seen in the verifier log below, r0 was incorrectly
marked as precise even tough its value was not being used.

Patch 1 fixes the issue based on Andrii's analysis, and patch 2 adds a
selftest for such case using inline assembly. Please see individual
patch for detail.

    ...
	mark_precise: frame2: regs=r2 stack= before 1891: (77) r2 >>= 56
	mark_precise: frame2: regs=r2 stack= before 1890: (dc) r2 = be64 r2
	mark_precise: frame2: regs=r0,r2 stack= before 1889: (73) *(u8 *)(r1 +47) = r3
	...
	mark_precise: frame2: regs=r0 stack= before 212: (85) call pc+1617
	BUG regs 1
	processed 5112 insns (limit 1000000) max_states_per_insn 4 total_states 92 peak_states 90 mark_read 20

0: https://lore.kernel.org/r/87jzrrwptf.fsf@toke.dk


Shung-Hsi Yu (2):
  bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
  selftests/bpf: precision tracking test for BPF_NEG and BPF_END

 kernel/bpf/verifier.c                         |  7 +-
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 .../selftests/bpf/progs/verifier_precision.c  | 93 +++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_precision.c


base-commit: c17cda15cc86e65e9725641daddcd7a63cc9ad01
-- 
2.42.0


