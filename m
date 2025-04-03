Return-Path: <bpf+bounces-55206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 789D0A79C63
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 08:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA561894CA7
	for <lists+bpf@lfdr.de>; Thu,  3 Apr 2025 06:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C061B1FBE88;
	Thu,  3 Apr 2025 06:52:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADC55897;
	Thu,  3 Apr 2025 06:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743663172; cv=fail; b=uOhArsMsSoodQ7vpjXWXzeMYFTmHAG49fsOYqGWbZl+yDwX5xOU+YBNFCgXpVVazeM2shJNCsxjb9pOOitxF0jl8rjeDG9sqzKIG7woR1HYoIkNJu84kR/n0gbg/TkmZ0u3J/S9MTg/lvFEVCp+ViwH8V4tQhbCvW5XIX5SVpfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743663172; c=relaxed/simple;
	bh=c08Oz4Y0APGglPNDW32QndKRV8w6RUUw2dNChl5HAJw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=D0/vWeD36tZaIUgI1p3IeYWCFV0njsQ5DrUprvBazY0MkyFx5ZyLjh046xERxy5qAK0hOy2y5jtmvESZsOvmxSTNxfhRVwPOcNXxUIqit2yvNPfOck3EpfqR4JSHeQGDjsnSIOqUptMrjEiuhzeaZGLgqh/iYLg3lJCqUt2J90o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53359xMF028924;
	Thu, 3 Apr 2025 06:52:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45sg2dgb53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 06:52:26 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mu+BDvIkV02RiTVCQ/xgQiuzesSjDKBjKXcnD8I9R3UhiiHtz6Ij1T9W5/s7rOVkFCSs5RpDOn44qYuZrLJ5Siv6pFS/yHnayiSnrA+FOIGUD3xgj6vlVYlWY0Ut8CZ9NYFnc9Zc/zsqJJSft7GgTrqINqgVI07la/gEK/+AtgfV2KpQp3sb2I2eYhLBsH4LIaQ7ejpx8Gb40v15zhEVOVlhvZ9uxbdGI9RChj6Nr6Eww4vBkcaBPaXil0xbSOncZVlKWMaeaEO5LxjWdTkCLEhn4ve6F6hKOCYzPj9GpEUSBCCluCu43XfB0bIiBOkbF2HbHXzAZBrFJ8yBhjibKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+pDFQ2Kj8gEVe5NH1cSfNdOmZgE+mbqYSXDK86tDTk=;
 b=d+huj9qOVc01LQwRyAceWSlXcGoMGvo3hUL0OkkWcTQOIKHDxcF+GSQJHhr67w/VYiv5H4ruqh21RAFptNoBhekBoMsDnctvYBk8nSYJ/BAhFhhejtGufh6DhcafIUZiTZTRy2IN40SN1hDd1+IM3iIaUTOo5QUAQZIDZ1ZQqgrrVvthRsKnWjSPhqzVPNN3FSCpD+wRF/gv+RX8AmB2knX3xWgW6sFyjo6UnBctKEowONaNUFWrtBmsuxXjXFE1giXzximcjJkI4EeLmdRDmTM4l+Liy6QqEEPFvUpfozJeQh63A0oVOWrCxVdBb2+jNulIprQj7m0xN7VAFHpvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 06:52:22 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8534.048; Thu, 3 Apr 2025
 06:52:22 +0000
From: Cliff Liu <donghua.liu@windriver.com>
To: stable@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhe.He@windriver.com,
        donghua.liu@windriver.com
Subject: [PATCH 5.15.y] bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
Date: Thu,  3 Apr 2025 14:52:09 +0800
Message-Id: <20250403065209.1181276-1-donghua.liu@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0090.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::30) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9e0a8e-5ccf-4e62-82be-08dd727c15a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c3u9SymyM0hEhO2GGyMO7DM2zbIgbgTEdp02UoOLTquc0zj+zYxx1vL8Y+JM?=
 =?us-ascii?Q?QDBUoeHASb2Y8wYgD910c2AMdXWOGm96OKZU47vPovCYQPtJoWvJPfrRK1QU?=
 =?us-ascii?Q?62y/BhOXNaVTJYsTT6xdAUGRieGNpQPJyJqchLlU6rrh/mE3TthYjhtsVGIy?=
 =?us-ascii?Q?4mC3K8Towgd6BCB3eOyBiqlmPoolPqmytIhvHLgGM5TKODXXvA26ZHSFnQME?=
 =?us-ascii?Q?S2rBdTSkMzWT9cwYbj/fe5nhM1LiIC4cEVwPhbCfHEoMsKftn+pW0WOUXNpy?=
 =?us-ascii?Q?9ezpXOVC3Mh3IV76Z4IkpCaQI2a++aR+e+1VYgHGNMBmuqDpNFbipV7U2bju?=
 =?us-ascii?Q?aqYFVtX6J/c/v62Af6uJn4eyYkemkpAiRcWwKkTAzr62vfcMZYY3yjeZhEWn?=
 =?us-ascii?Q?gqJ2sOX0bh0BSGtHFUdM/qBJ3n9ZebI2O2jz/uf7omvly3k96+5X/8Dus8n+?=
 =?us-ascii?Q?rt7dJQE8/q/7S+Rh4G+/bnDD0cS1WWldu83nItIiiVPL7CCWLA0NW+h8rCQQ?=
 =?us-ascii?Q?moCTPI5abFZXAf6u8CUTBt/Q+fluinqJk6X3KhegmopNxbp+atiqTMENQnQP?=
 =?us-ascii?Q?jiUoFdlznATpphlinCX+PnbbSlhkZOs6+CFBh2X3/6PPaK48R1BpPyoK4e8T?=
 =?us-ascii?Q?ImCq2YZoPTsJe9fVzNwktzSiRSBrkhRGIj5Z+SXtUkmGJDuy4E78BFkJ4hF1?=
 =?us-ascii?Q?KrfBBMPrhWfmx+UTi+iEA4dmr2rjJ+nSu+duYV8py0rfuiLi+6SBVQEOUYZy?=
 =?us-ascii?Q?6h+WhUq9K4SPwRxjMUX/22E5qe97ka0VD/mjiU8xdwTmLRl+jo3w6UB030J8?=
 =?us-ascii?Q?AcRF88obJE0/EBDQBGVQ3rgr3NqemnNwANBKizJY25bzNHFfSRTjbk4D1Jrg?=
 =?us-ascii?Q?osFG4Xk0ikK5N1E2YBqll7QJnstWX5zvEyOOf22olol1BQ2+WMjdZU+laidw?=
 =?us-ascii?Q?ziplLyebscwT9T9BWelzghxrZjAVA3hrQApbGTm2PGqVPkvxp5VJuo9r5JUG?=
 =?us-ascii?Q?oG3Iwjo8sSmGNBOV1Yh76Nw+jUGM+JjCImV0nNaXxS5n8DKiMl/4rgX2UuPp?=
 =?us-ascii?Q?pIfSm/kiq3xL/Khe8WdGoGvWXb60aQu15zVGbhfWqwh5isST6MpahuWXxuwv?=
 =?us-ascii?Q?q+aLjiM2pCunR9SIP3zP30WDvzgqrlwvXahBGQYB+AS3WVvlxfy2QhyUsQrw?=
 =?us-ascii?Q?ocIr9lqbT3lyhM2krxq39RVNI3FXSVa1A8qKFSQR6atpN7LHcTApJx5E0/dP?=
 =?us-ascii?Q?XA0Zny28HzzANzXXLDObBe+azi5NF9U/3WvzDFdq0FwRpZ7RrVNChunHhItA?=
 =?us-ascii?Q?copQ4Ic+xsyOg1s7LkE2KKrzcSz8SotOHACt6WMvKoVlQ0LMcI9MV0Gsct9o?=
 =?us-ascii?Q?QhK7MFRTORPE+qunxAb26N3S6g8kTLMgOXHUzipWjxqPEov+9So5e2wiWb7g?=
 =?us-ascii?Q?C891cGy81cd4qz1eHAE0vU/g+fF4WeVT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WfBDOmw3KnDWA2JaZF2h30rzhsSunUlQocYRbbFwDujQ4GBjy6IV39OyaImn?=
 =?us-ascii?Q?0rcd9w+vH4nH88MfIRk0oZ8ZynT82KNL9T2EGusgPBwcWnw0RvjtiC1chRxR?=
 =?us-ascii?Q?TwHfAkKDqzoUCs/aevAU/2PvMTKts/C/cPY8WbrHfD0g58hkeLXbNXN4W0SW?=
 =?us-ascii?Q?jQwVDnDUg9KL2ccQLaQ26MYfAxzOYZ/abevZ5VkxrfBm7JXO7U2rkXXb7Tji?=
 =?us-ascii?Q?PLiLO9TtAnnT1a1mI9UfyQ38XDFhCbqInkrvQN0pdLfeTsbVBWBLe61Myetn?=
 =?us-ascii?Q?4Q/D220KBRpVRgw801o5u1TCPkRsH+227JvDA9sjE3mK1MlRnfMgZxggzUI1?=
 =?us-ascii?Q?QeSfbU+O/KXIEaIzpG3YJRg8zrnJf7x/fZtJisVbrfL/Fvy8BVMiJdBASO2i?=
 =?us-ascii?Q?Cg5RYrQOaoAax2zCoR3rnHYffC5b/p6ODQZJk0WOQNoogeHLePvmKohVzR7G?=
 =?us-ascii?Q?kWC2Sb8lKaLzutSyNb5UvoHust2xrEkSrVOZb/KhMlnDKHWTszwBdbZSjTZZ?=
 =?us-ascii?Q?TQRQm6UMqs7SvdlizliRd8GVE+TTSv0K+xmCAMSYN85Pv06XqCv9QfGgaAbc?=
 =?us-ascii?Q?s/4PtpOXGPaEL5vITddqANJpudrIr1anc/YHKxRNaszhX5ZKADXptsXN8oZy?=
 =?us-ascii?Q?rmCnoqFAt+i4UGy23yb1Rm0euvr/wq++RzGK30+81RuH25klcpedBrFArXxf?=
 =?us-ascii?Q?khMRosUqRU/Asyr+FoA/KjZkLHClKsntzoMaCAZP9SNTXnNQdqdEnyvjfRqz?=
 =?us-ascii?Q?cP57nbTZOWoga0z3/LgLRTIvN3nNaIJHplLSYcwltAquCVg9dsEGSAVaXRK8?=
 =?us-ascii?Q?3wZJ59EF9oV1Vn+J4eEzRJrXL6itbqmdA+eqdMTA4/zClG1Oe+x9/daavbNB?=
 =?us-ascii?Q?Si8Vslya3HQanOm+sNeWcm95O/FxUM3198kj8MLCMuxV11jS6ndAaEWlH6Z0?=
 =?us-ascii?Q?7bqZyh/CPZ8NLBZvJiUvPydOAmA84m+HMiu7TxEPT7AXSprhVK0f+4vJYbaG?=
 =?us-ascii?Q?yzTzQ5STB6Sco8t+fPWD1eek48zs4JieShky6G5OBntgsOjLJba6rAeRMO3W?=
 =?us-ascii?Q?GF3R0xyD4dSRxSh+rLA+owGeZ+Of5aGyNf4MzHsgYR5nff1XSGGLXyP8MR+t?=
 =?us-ascii?Q?t1oM0Vr9+m+wN1tfJy4hUf13npuVhp3V+hrEpFKAkCLubdX9/u/YfbESQ7eb?=
 =?us-ascii?Q?PNNnPrYLEoWFgf1e2SPaekZkiC9ncxNWf+yHwER36J4CL+NLcjDTQCCHcduf?=
 =?us-ascii?Q?xrFHMkP/RTmIabeMvCCLVOOXVcZPh5Ky7x2hRxELiCeTIK6+UNy6cERJU/K2?=
 =?us-ascii?Q?tKVGKKpn/9bVVTFbbYpOcT7JEf80a8A8dhFEOhva3Dx54sOjWq024U4m+LJ/?=
 =?us-ascii?Q?PZEzEmOxenEsyIym+VEpxfwjO3YGPMB7aamKxrt6PZa7mUMo5yUQAyg8MZfY?=
 =?us-ascii?Q?TgEUCa0YFtb2ni937zwK2ZAgM6KBJAoRTG6ceWtiX2QA8Mw/RfpYPUx4hk1I?=
 =?us-ascii?Q?GRcIsDr1MGTn+BkaMdbNBVkokxnGMoKv1ITTmmSbRptZt6cGg4ChmCe96uwR?=
 =?us-ascii?Q?XCKqHROYFZoOWROdbEagDYVqV+BUFrEnhgexukujFSFX6Bm1zbiv8jSnz99e?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9e0a8e-5ccf-4e62-82be-08dd727c15a8
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 06:52:22.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYwTsWPuhujxJjqE5z/Jd+c50y67A28PoDhRPEUUNXINCqD7GWC4Lmj/TNzKV5qusyDSrxtb6+vzTSh2LNIxcs3a9SeefVBowp96raSA9sU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-Proofpoint-ORIG-GUID: jmUWxlOmq92-TgE1pUXJpZcUU1ipVx4W
X-Proofpoint-GUID: jmUWxlOmq92-TgE1pUXJpZcUU1ipVx4W
X-Authority-Analysis: v=2.4 cv=LPFmQIW9 c=1 sm=1 tr=0 ts=67ee302a cx=c_pps a=AuG0SFjpmAmqNFFXyzUckA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=dt8AdFoPAicW6VDz_WAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_02,2025-04-02_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=820 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504030033

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 169410eba271afc9f0fb476d996795aa26770c6d ]

These three bpf_map_{lookup,update,delete}_elem() helpers are also
available for sleepable bpf program, so add the corresponding lock
assertion for sleepable bpf program, otherwise the following warning
will be reported when a sleepable bpf program manipulates bpf map under
interpreter mode (aka bpf_jit_enable=0):

  WARNING: CPU: 3 PID: 4985 at kernel/bpf/helpers.c:40 ......
  CPU: 3 PID: 4985 Comm: test_progs Not tainted 6.6.0+ #2
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ......
  RIP: 0010:bpf_map_lookup_elem+0x54/0x60
  ......
  Call Trace:
   <TASK>
   ? __warn+0xa5/0x240
   ? bpf_map_lookup_elem+0x54/0x60
   ? report_bug+0x1ba/0x1f0
   ? handle_bug+0x40/0x80
   ? exc_invalid_op+0x18/0x50
   ? asm_exc_invalid_op+0x1b/0x20
   ? __pfx_bpf_map_lookup_elem+0x10/0x10
   ? rcu_lockdep_current_cpu_online+0x65/0xb0
   ? rcu_is_watching+0x23/0x50
   ? bpf_map_lookup_elem+0x54/0x60
   ? __pfx_bpf_map_lookup_elem+0x10/0x10
   ___bpf_prog_run+0x513/0x3b70
   __bpf_prog_run32+0x9d/0xd0
   ? __bpf_prog_enter_sleepable_recur+0xad/0x120
   ? __bpf_prog_enter_sleepable_recur+0x3e/0x120
   bpf_trampoline_6442580665+0x4d/0x1000
   __x64_sys_getpgid+0x5/0x30
   ? do_syscall_64+0x36/0xb0
   entry_SYSCALL_64_after_hwframe+0x6e/0x76
   </TASK>

Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231204140425.1480317-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 kernel/bpf/helpers.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 13f870e47ab6..d3feaf6d68eb 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -3,6 +3,7 @@
  */
 #include <linux/bpf.h>
 #include <linux/rcupdate.h>
+#include <linux/rcupdate_trace.h>
 #include <linux/random.h>
 #include <linux/smp.h>
 #include <linux/topology.h>
@@ -24,12 +25,13 @@
  *
  * Different map implementations will rely on rcu in map methods
  * lookup/update/delete, therefore eBPF programs must run under rcu lock
- * if program is allowed to access maps, so check rcu_read_lock_held in
- * all three functions.
+ * if program is allowed to access maps, so check rcu_read_lock_held() or
+ * rcu_read_lock_trace_held() in all three functions.
  */
 BPF_CALL_2(bpf_map_lookup_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -45,7 +47,8 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -62,7 +65,8 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_bh_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held() &&
+		     !rcu_read_lock_bh_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
-- 
2.34.1


