Return-Path: <bpf+bounces-13603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 756A87DBA89
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 14:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2603B20DE7
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 13:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E43316429;
	Mon, 30 Oct 2023 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BF9QhSVL"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682014285
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 13:22:19 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8467CC6
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 06:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BpZ7gwLi4bxFTgGlNvAsjHpOn678liztRACvYVGVxVrtfEaRB8ZEZSAyid0GpBOHGav3bs3TfO2oT098bZjq+bvL2+3XIUAnCyErcCtpWT0V+aonoDap17Ujt0bS/eBBENmVjJRz1oeaDgfuSowpTSZg9nL9pvFN+7sDk8uMQFiWaCV1C2y2Qj9zKGVMeRP3DQF8zSONxLtsrDLCXcNd87cLUOw0bcaVLzpAxWz4P8w0PkSyLvkdxC4AUXNxi2DMtohDOCqUghsaxqNQTddRAwt0iZW7gJOn8GR+h3+2bFr8l4xfWQvMqvyOLk9+omHw1JgeUKOOapbZuDdjn2ifJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cd4M63l+jloqdakBevhrS+rEqbjF2xSTmN3byz6o650=;
 b=TvBpLTV9+2bUK1d4CjxGOK/rFXKJ6/M5bZElKVXQKX9BI/o2+GCf33d1qE6hCvtyrwBZMaX7AGQDYDnXrtncAC6V4kT9SiBCha+o1H9VF+VCKj3zHkOar7V0GT+47zpjiWnRXHcqUmNBh+ffJ0X3OEsrEQYJAiUDfFj3Q1OIoFJgumP6qWvciLINW3YnlMGZKsrDAyhHEFI02CgkqLLO5Cd5xpFYc9PUfy+5WX3oiGRPQSedsx2cOkCc/Sj7uVeEuOvZPztfCxLgP+fy/9hnXRBpO88F3YVYbggg0YxQM3E7Ty6Sg3KRTIbifOh4PzbynWriLjYzFQDgkSzNlaeIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd4M63l+jloqdakBevhrS+rEqbjF2xSTmN3byz6o650=;
 b=BF9QhSVLlvpc/8FysOPMQxi96b0x47WBI/Usum9Ax0nJSYrI1ZGBAiXzVrds4qCYi6zv8NYTdxjM+XhPrM051H4gLjJlO/YKVqI4T2EcWX1QlmaqYJ47zagIlHQ1M9mtR8tUzvclY2LIc03F5kDMCeAlXrRix+WBOv1cwmKVIaZ6C8YWLzBa4i4ibN/4Z8zf78PT8dMkyLVE+wD2Z7B4yZqXFgObTT3bd41PKJYYOuZmPZ5QLVorSOz1058lcpJnBA7h9Dkfbxp2AFtV/dfxpNFYd0F4hANJI1WRor08O4fmVpHccxaTN9nKorvS6xucFhfWajiJanZmtrrzpbIrpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8861.eurprd04.prod.outlook.com (2603:10a6:102:20c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.14; Mon, 30 Oct
 2023 13:22:16 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 13:22:15 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andriin@fb.com>,
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
Subject: [RFC bpf 0/2] bpf: Fix precision tracking for BPF_ALU | BPF_TO_BE | BPF_END
Date: Mon, 30 Oct 2023 21:21:40 +0800
Message-ID: <20231030132145.20867-1-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8861:EE_
X-MS-Office365-Filtering-Correlation-Id: 32315b31-962a-476d-76b3-08dbd94b3c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hKPAFMQ0YJKcFeLvKAzwUWERv6iieBhAsDS+djSP1BZXUlSmDVceFKzCZEvelrp0Ko7JfzQkjm5CwVWJ/8IQjwXNb4Kq3zbj1RgX+Pqkhu8/yRZHGrxkj7AzYOK4AVJec2pPhdqHsxkF8uytb7tkPLyqIl3rZNsq+hH/joUmwpdGTlnU7f2wqzRjyfcIU5yhpANt+mWCzl0SAC5yacdhmmcNpLiIrZX6uhFMCdMAaPjYMsl6+iv3vtUOc23GkYMZtgqCZa0TkV2oIQNXqqJ8QTAcbH0RKGSdQSBS/s/tkQYtT8+ePTingDEDSY5ZIto7CuIzFFmVvXptQw443IpNStGliIDfORqDzQvSDwJtXL5ROuv9KsOxLUocIpGmzApGWrLIr3A5iGwKpgAeIuFzMNExuSAQ35sUYhnLqGm+RSI3aieltBP1rkTOR4RiO7SIoZZ39opNOfrBH63BP1+g+Job+t38FUpdVR4qYOZdanrdKNltULOTYj4tZKJC1hnMhcLxbXnxbH6h7AHZDHJ+UI37RKxbzuX4NgY3jjhQnxo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(5660300002)(41300700001)(7416002)(2906002)(54906003)(66556008)(66946007)(66476007)(966005)(6486002)(8676002)(8936002)(4326008)(478600001)(316002)(6916009)(38100700002)(83380400001)(86362001)(36756003)(6506007)(6512007)(6666004)(1076003)(2616005)(66574015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REtsYTlWcFpGRG1oc3VobmtQZUxjYjVvWE1ncFgwNkRubzg4RlNCbVl3OHE1?=
 =?utf-8?B?NldMZStZdlZmVXFnVkFXcHhCZmN6WjlSTlBESHN5dWR4VEMwZnJScW00YTFr?=
 =?utf-8?B?d0M1S3BubXJYSjRIYVlUemR0dnd0T0tHeDR3TmxWS0t1NC9kTVR4TFl4d3JY?=
 =?utf-8?B?WE5iVmRDbGxsWXJ3RHdxT3hlUEdVMVk0R2ZCcHd4NVZrZjhiQ2xwNjJWVHMz?=
 =?utf-8?B?WVlyY1RKWkV3UzFkNS9ER2ZMQU02eHc1SitxMVBkcSt4a2VNZGlxVDRDRWdY?=
 =?utf-8?B?NUJYWGVVbU9hclJSbE4zd25tNkwvNTFBNTI4NlgwL3I0RmdDYVQyUkYyaDBj?=
 =?utf-8?B?V3Z4S01TL3pCOUtyRy9aRmdQeitMOHVPWm8zTGRKa3pnd3EzOG56QXVES1Ay?=
 =?utf-8?B?VXNNYlFUUk5DV0IzMXdoeTB0aDlXYm5ZUXl2Mm1yQzZMVUJaSnRtdHlzYlEx?=
 =?utf-8?B?QVpqWkRCTGw3QXB4Y2FQOGNUTmw5dmc0R1Zpb3pEVU5kMHJaWkJxSkZrZkpp?=
 =?utf-8?B?NitGaGJUaE9WbzQyRkJza2UyRkdoSzF2VHFBSUpnVTJjSUxNL25uZ01VZkpj?=
 =?utf-8?B?clFTdFBXNk1sQkZPV2JmRVRXVWdoUU9TRnhNN3piamlkdjVXQ3ZRUXc1M21Q?=
 =?utf-8?B?WDJrUVQxMzNXaW5KYlJ4SlRvTFB6RTFWaGhnQ0FDalQwTWxBc21pOWJaOEVx?=
 =?utf-8?B?SHcwMzNCcVEzeGZjSHZjNWRUUTB1ZGVRcm5zb3BVTVNtMlBOdHhpUFh3UDhH?=
 =?utf-8?B?TmRrbzhPRWhpZDdLclBRWUtzNjZFQXBYeS9mRUtvSkxOcHdhV0tzbTJpNWRM?=
 =?utf-8?B?M1IvaGJ1VWpkQ1dZd0dYZ2dsYmdMNWF1YkxiMG4zdXd3bnh5ek5NY1lVMFRH?=
 =?utf-8?B?RzFhbHlUL2x1TjJQNDlJbkNvVkREWkwyckVaNnlmeHFqK04wcWRJUXhQN2Iw?=
 =?utf-8?B?OHBBVjA2SjFXYkZyampVeUxPVzVWRmJlWEhZQVc2K0hleEhSbmI1dUxHUXBF?=
 =?utf-8?B?dHlPNWlzVTFtb1EvbEo0Q243MDRqSlBKRVE5ajVrLzMyY1EzVjIrcC96N2g3?=
 =?utf-8?B?WGZ3bUNaU0hqOUJTWjNQOXc4L3E3VUpNeWRRTU1ldmJFaGJVRDdkMEtpVkVt?=
 =?utf-8?B?em9HWTRNSnVLQTZEZGV6NnlEeGF4RWpqdTlWNzhuNHdoUjRXcThadDMwdDFM?=
 =?utf-8?B?N3FvWEh0RVp3cjV2UFFyMURDdVc2MzI5T1ZDUlBKSkkvZnQ4Mk8xUHAvSjd0?=
 =?utf-8?B?dFQzNDdFVU4zNjBMODJ1Z3NnYUxsWmlMb1o1ZFF4ZitYemdXYWpIZGd0aEls?=
 =?utf-8?B?VEo2WU5mVjRFcFRhK2dmZXBVOHhjOVNrVUtvZTZwNEd2K1l0ZEppTEtZSjhK?=
 =?utf-8?B?d1lGZStCTGV6Q3Yxam1jMFM1dWRoZndNOGFEdWFmRGxOTDN4SXJQSHdSNllt?=
 =?utf-8?B?ZENuYWRMUFkxOGdmRUNQT2ZaOFl0N0FDNWdIY01yTjRRVnozb0lDbFh4VlVX?=
 =?utf-8?B?Ny9YNTV0VFNDOEUrTDAxRlQxWE9yUVNoYTZGSG5ZbnB0a0Z2U2JvbVc1ZWZi?=
 =?utf-8?B?UE4ycVRNbG43SGlCeUpXVTRPbUhnY1hsWjFTKzZHL3piVTB5SUw1cFVML2gx?=
 =?utf-8?B?Y0JnYTdtSGRFcXAzaDg1blQ3L3c1aUFOS2VpdDVobDRvTDBiN3YzWjY2bDVF?=
 =?utf-8?B?bGdiczV2NDRsY3h2YVJxVloxOUE3OEV3RUQyUnkvVXZ3UVNkR0NQMW10QS9B?=
 =?utf-8?B?T3NNajJob3luOWtaR2lHaGQ4KzlQaHZqQTdPcWRkRk4yNUZTbW9HRGJmUFJi?=
 =?utf-8?B?aWxUVHkwUHRWSnpLb29LNTdIU25iYmtVL01yanFPakNDR1Z3d21rZnNETThZ?=
 =?utf-8?B?MURzTFc4RWVUTlJ3NU1XbS81ekQwUTlPRDJHSlZId1gxc3M4WUFSV09OL3pI?=
 =?utf-8?B?MW83dzB5UzlEYldTUTB0cDBuZTZ5WXViOEJ0RXl6NEFjYUc1UWJaSlFINlli?=
 =?utf-8?B?N2t1MzNTMEhGcmppZFkybGFtNTBvTzQ2MWx4bzRiT2ZWUVc0S1A0S3lYTTJY?=
 =?utf-8?B?S3BCV3ZpSDljWXdKeU5IKzBvcHFDVmVTRWFzTGhUb0VmTHNjREtab3ZpVHA4?=
 =?utf-8?B?RFluQkRabE93bk9Jejd0eithK01mcFlnbFBUakZVaEJTdFR6TWowUUkvemtq?=
 =?utf-8?B?SGxzeDEyMk1xbXMwazA0clNLNGl5NWhzVEc4dUhWL1Fpb3NWVEg2WElGcmZX?=
 =?utf-8?B?M1doOTYwMzJoMk5FcThiNlgyWHlBPT0=?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32315b31-962a-476d-76b3-08dbd94b3c1a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 13:22:15.8333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMIgUAt0b4cbECGB+YmxDEgSOLYo60viU93cumoHtGzDpdNpXIEoTLRkqUWQmxN2OHJS+MVG0LISPugXSQ/HkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8861


Note: this is sent as a RFC because I'm quite unsure about the selftest.
      (Please see the notes in patch 2, just above diffstat)

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
  selftests/bpf: precision tracking test for BPF_ALU | BPF_TO_BE | BPF_END

 kernel/bpf/verifier.c                         |  6 +++-
 .../selftests/bpf/prog_tests/verifier.c       |  2 ++
 .../selftests/bpf/progs/verifier_precision.c  | 29 +++++++++++++++++++
 3 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_precision.c


base-commit: c17cda15cc86e65e9725641daddcd7a63cc9ad01
-- 
2.42.0


