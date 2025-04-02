Return-Path: <bpf+bounces-55119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A28CFA786BC
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 05:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F0516D4A6
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 03:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470A713774D;
	Wed,  2 Apr 2025 03:05:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9493FC7;
	Wed,  2 Apr 2025 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743563134; cv=fail; b=YCks7lbeA8oH1azxmeki6EswyCqaWBRlmoBtgK2X1F9zubc5XY0IVJzb8RFT0iAX6Y7CCbgAxLzNiFL8pH//oi7j6fiGwSk4mDm6RflzGpES3Qzvmrvq41wQXjpnE8J4y7gR3lplEFsZfpa8GWW74G3Xvagt5GsdQqUuMwRGfX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743563134; c=relaxed/simple;
	bh=OtWwf3KIAT82hGi11rObcwTuKM/cs4yD2c83pVsvnNc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LDp6OLpBuAQhosKtPzeFXU5Ac26BjU0vo0bIXMIyuCv6M3/b6QP51UAb6dTT40nfIX6j5hkrVgSjuJvmSdUisvB1EDP+kbN/Cjflu64WOTgWDufrxfSzUfh2hESsmsKcyiRp0f4UQiQsabzfArrb/D0GtNAHaLvwMtVavINvlXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5322AJ1v020265;
	Tue, 1 Apr 2025 20:05:14 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45rtc9r577-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 20:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKo+JqBGPC9gWU/TuXPoRjscAIknMZ3yvvo/jlBRfO1BSnMia6VgRP+xaUbceZpPBaKCiCIPYfUqVwfC0oamkpVwEzv/8sJXKzqf7dlwf6vGwSw04SGpUXVNsEMidrkLU8dYFF2kNnUSfEJ4FoRWxWKZe50HKQiZJVAR4VCIrdEdEnEfFRZmLgulINnrAS+f7nPYLXfsInAboK3GrhIKDRnU7akrI95vfA81QORkcUwj7jpkL9pbfbLhCkCqLjoly0i/TQraNe+L+FhCwAWmNbbbeHfwcfoLO+xJ6jJa8avNR7PBllOvJlbaFKoxG9hKsnQ3BSo1+6ZKUK5Sja5Yhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83V/HO00XvWydT9RayBF1SKOkzqtPGU3XJsDkuNrBr4=;
 b=S6H8RE/WfNak2IqbEZv0PrbCYq0TlsUANxb20DhwYfV7uGDirdDEbPrTsFixLRemjZOK+6sAYXCKFCpDCDEPNKAtFyCZtfS0xiT9iiSp2iOCtIZigWr9PqXB6gYwSoD7cKEzSyuq1TBX2MMOmcUncalJPfQ0q2qcfgV8j2ZPedNPs058eoqmah2QEazSFTnm3fN/v4YToomqvjGPu1FAObYiwRPmZmEzJ78D6TieBWMKvXpXWcrGF51KQk+oMguPZaYOvM+bx3kEcKydWkIbd9bVGlt9eBg4AxnZZq89BLNuNel2wUfJTrkzSKstYeJSWm4DJ6kkc1Um989WzysqFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CY8PR11MB7012.namprd11.prod.outlook.com (2603:10b6:930:54::6)
 by SN7PR11MB6828.namprd11.prod.outlook.com (2603:10b6:806:2a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Wed, 2 Apr
 2025 03:05:10 +0000
Received: from CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d]) by CY8PR11MB7012.namprd11.prod.outlook.com
 ([fe80::83d5:946f:3692:8c0d%4]) with mapi id 15.20.8534.048; Wed, 2 Apr 2025
 03:05:10 +0000
From: Cliff Liu <donghua.liu@windriver.com>
To: stable@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhe.He@windriver.com,
        donghua.liu@windriver.com
Subject: [PATCH 5.10.y] bpf: Check rcu_read_lock_trace_held() before calling bpf map helpers
Date: Wed,  2 Apr 2025 11:04:57 +0800
Message-Id: <20250402030457.617254-1-donghua.liu@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To CY8PR11MB7012.namprd11.prod.outlook.com
 (2603:10b6:930:54::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7012:EE_|SN7PR11MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: bdf7f0f9-81a4-491b-3e54-08dd71932dbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6A7ncHR837zh6fyPR+NHGEAM55yT6OIq0oxtyyQNn76fk47pjbdr1fNp6/U+?=
 =?us-ascii?Q?MQxrVfWS+fLLEcnHq0vEKWen2+0IDu1T5M0Ra2zwSThTbrNZCLb0+e4s1QC4?=
 =?us-ascii?Q?njJXiH9n6XMo680+DHgLK/x7VxcoZ54eueUx/miQHN4e2uucC0fS8+p095Kp?=
 =?us-ascii?Q?Kw+iVFQvVOY/sFbziBKfSL6mFOOLHFzZHbAXoAbeAgUFcGvuE+PGZ09OkauZ?=
 =?us-ascii?Q?KCXoyUhqcmdol/GuqZ/8mzdVYjaH9kHTWrIBeU2Mvufxss0Qml8ueqN1LU5S?=
 =?us-ascii?Q?I8t4wfjFZB9t4nJfjkKDpbULGGvOu51781vCvb1aJ/oJAzrCxbFSqPqibjdV?=
 =?us-ascii?Q?VqiqXLRowkxir4Qv067O2Hb/hegdnKfHLtLMvaklXz2V2iifsckuHleHvAJH?=
 =?us-ascii?Q?0+DEzotMsxzLx+NrIlLAkDrRfBfA1fij9W/ZbdXnq7Mp7jGuz2lGJVGD/0Lv?=
 =?us-ascii?Q?wzPufYPZBYwt8/HD6U1jC73vvlImw5aWwtXDvP569JY74L2msqE4GLrbC6Qb?=
 =?us-ascii?Q?K9d/uZ5dkgNJZST8eGlzNijXZBYvjJYKQgE9o1DfHn2WfoYlFVUz+jhCDFGp?=
 =?us-ascii?Q?De6TJKF76+HujiQ6IqZ7gzvSxSKe5iZCxSHUbwl0N/ecKHfI1s5djZ/6Rzwg?=
 =?us-ascii?Q?KdoHbIqAjEZFHIHOxrb41tTfBN61RZUVCOXZ32sv+tlKKpVsjWo7kaw8itI1?=
 =?us-ascii?Q?ipoQu+/oxhIDl/Nk+25HkG7pp6I0SsyYZcVBb7XUX7JaI7pEYurNEUf8CiPf?=
 =?us-ascii?Q?Xymr8F+WC4Sihf91npa1mUkQQ1AJhbLFiNccZDQkDFa5z2ZeUhWc3URkNkA+?=
 =?us-ascii?Q?aemxOX+Z5ORdhSkLodEioyLydVfJWhARJhU6EqWzaADeXN0BEZ8kVpoFdJHO?=
 =?us-ascii?Q?XuZZrFga9J2fmnNcrDS93fwl7dsXGPq5JXZQ7GQpgGueA3SvEC7kWavLBJKX?=
 =?us-ascii?Q?K8MjemUsKRIJhOAVDoGvOZIszgo76J0Dk9leXoYTyz9SYSQsR2Cg8MH2f9Yf?=
 =?us-ascii?Q?ZKsEWVt5b3vlbHTfzWSU178b4C0yXHdfKZt0mwO8xmDFeAk4mL1i+KW2Zidk?=
 =?us-ascii?Q?xQUdRRRy/odpbzWKCoGaHZmOBdb5Adx3e9Cdv1ln0p5NDhm7AVqu+zwyy2I9?=
 =?us-ascii?Q?1cTmBUl4KcMTVXx0JrxaC3Wvtsq9oBMHl2JhpFDAmGpCw9Kq9CZzCl5vVRzr?=
 =?us-ascii?Q?vTGt7tsTQW4y4CHNk9YHiPe/AsIZq2rkEe37P160+ATmNhn91Owz8ih0m4K1?=
 =?us-ascii?Q?xbHEx0IV39UASkdXgIR/Ump0fW+XQKyrK/1fLy0tC0dR9+M2lTF7WiGN4V5I?=
 =?us-ascii?Q?WA208+lWEHrF4oQwv+o0CPD28vrlLUFosfXK350Ixmim9FsrtvJAmaqHPSrC?=
 =?us-ascii?Q?Vsgb/dLfGQ2QVsu6BQ8Z684HPBUaGQRP44WYstmwPxYih6K9vx+25o8O8hxX?=
 =?us-ascii?Q?e6AQkGAKNDLavPgPVWFrT2eX64XRv/rK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7012.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1kGASZgdZjzMPyocPXRac6upGwkeUGT8jVeuEx4f4vffQx+ZgNrR2JKpmQ6Z?=
 =?us-ascii?Q?mVL4jbjw5AGTecc6p0pYjoEiR227yF6bIgmRJQ1yBlioq15pq80qatIjFgG5?=
 =?us-ascii?Q?6Y5KJpZtwR5/Y4S90VJnDtFRZEED1Amq5/2JM4ZEkaVdnOlBnzViXSRSfxes?=
 =?us-ascii?Q?ElT4GOk0SVgthr/YJFLhAdZy7aIgkOe2e4km8ZsnGjdNp1yliUz7MubypGRC?=
 =?us-ascii?Q?KeHoOrJzHPefOUNaQih6bmtuSWsR6gXCUMr1VaH9pUgK35ZY5dFFPMj4NUcg?=
 =?us-ascii?Q?Y3XUvKFsmvCNqZFa63oUzhx6HY3vnmv+up7+QYeIT6YXH4ZEM5SuciSbWfeE?=
 =?us-ascii?Q?Wt01AGNCmDCnI8sBM7H81Hjplzf8OPOVaiN54Qq7KSEobYJ7R63duIzkQPC0?=
 =?us-ascii?Q?R5XXSnba6CfylE4B/msiueSBTF+LIflBium9nfrjbM82ieC143s+ImcPL+JJ?=
 =?us-ascii?Q?96e3CgC3lsM2pZ4u7NJpunFYE+VhPBhnihRigBNwZ7QtaiTy/dyWyYjkifM7?=
 =?us-ascii?Q?NKhHPNnvskBgQySGlEfrQKOzM7gsgFz2ubZj6RAXpjjQNUgttKDJOCpCOXV7?=
 =?us-ascii?Q?fHWqG6juw5HAH4nzdusvFTwq5ht/oak1KBvDNssCy8GGTu513VD/Hmdhd0Gm?=
 =?us-ascii?Q?E3XF3LU/M4CvtIGBbRcLEWapViee1UTb8M4Gh9OiK3nsj4LaJogm15bRol+h?=
 =?us-ascii?Q?3/hSO9NJyqASIpcsxAfInVjIkxrcPHL94I3whFTVrnAga+U/D0fx71U2kX/F?=
 =?us-ascii?Q?hK4knGxxBSoGEitKUrXKLmFTfXZQhFHB+F0ENVMduf4023aIciLgbduP4UYG?=
 =?us-ascii?Q?1Jn4Zl5Bj9pnyNmKA2dsh5+FGaSs4e4IYIYwuQ/3n45huzYoB4zazkzXBPtA?=
 =?us-ascii?Q?E/dLnKHqVYLJCvwClA+Mver8mbqsjXhStSxb7ZKbGtyAGqIXpxHlz1xW7huv?=
 =?us-ascii?Q?eWtnl5x3RBu9cNhF7856mZ/UMhQl2zTEIZfKe1Ase5E3UqpXrPaWJZDJVKKb?=
 =?us-ascii?Q?blfzbrFNbkDpWcTOtfY4xh46KxLLYVfmVwVJltkNRIy9vx+EUZ+9tWZB+Dao?=
 =?us-ascii?Q?mShZh4ia+SFyiwIBTtTTMTmI7I5BXrj7e6HH5VuYvubsoHdFJd85la2BkZgl?=
 =?us-ascii?Q?i08T2gLp2Q6/B2NQsccqIiGOHm3dC6Zt1HJPlGGFbVvKtYxfHzS2PpFoUhxF?=
 =?us-ascii?Q?Tx+E5msgKGAwpRDdoC9MPZcNLs6H5OAaAfK/HzEt8WoD+gCYdHhWyCdVaxZi?=
 =?us-ascii?Q?ug4Qha3yh3vAHWhI2swr1nsxLJ252uQYxJkS1LAmQX/WQwYdllHclNsqvqn9?=
 =?us-ascii?Q?i75fDx4/Mr0J2F/NJ7z89GF7oZjgZHo0RlC7Opz23iQozQ/GOTU1Rqi9/JGk?=
 =?us-ascii?Q?9Y3HNsr171tewoxNmOwE75PZgWGiRdWUW49DjYqqFX3pmpvAiZ3CRVSAve3p?=
 =?us-ascii?Q?djIClKsv2XpR8oqhPogixRHIx0xDkU3OmF+sI700SQBLLRSt8/88POIAvxUo?=
 =?us-ascii?Q?uOEvXyVd7q+WOALNZ3YMQnbrtqiwF7yp1qUdavBOfX3AZ2oElrD9KMppzppz?=
 =?us-ascii?Q?+diueyF+nZODpX9MlguVFLIR/PRG/Genfs8Ntfw3ClDua0iZ6Bcx4qxbMeaF?=
 =?us-ascii?Q?CA=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdf7f0f9-81a4-491b-3e54-08dd71932dbc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7012.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 03:05:09.9893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79f3JMHynLzmsx52TdpSQ0pFVPJTQ1KmtQ61EBQ1cA/xCmmI7r7qu9vDCYscAAH3TEf0rk1Zfv72v7g52xkBBJ+UFpFfRtItXkGNeTOVRD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6828
X-Proofpoint-ORIG-GUID: QAujmhRGQiOBJc7E20hT21cJbACMIYZm
X-Authority-Analysis: v=2.4 cv=Tb2WtQQh c=1 sm=1 tr=0 ts=67eca969 cx=c_pps a=O5U4z+bWMBJw47+h9fOlNw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=H5OGdu5hBBwA:10 a=VwQbUJbxAAAA:8 a=AiHppB-aAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=dt8AdFoPAicW6VDz_WAA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: QAujmhRGQiOBJc7E20hT21cJbACMIYZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_01,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=865 adultscore=0
 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504020018

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
[Minor conflict resolved due to code context change.]
Signed-off-by: Cliff Liu <donghua.liu@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 kernel/bpf/helpers.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 31e3a5482156..238a51daefa4 100644
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
@@ -24,12 +25,12 @@
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
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 	return (unsigned long) map->ops->map_lookup_elem(map, key);
 }
 
@@ -45,7 +46,7 @@ const struct bpf_func_proto bpf_map_lookup_elem_proto = {
 BPF_CALL_4(bpf_map_update_elem, struct bpf_map *, map, void *, key,
 	   void *, value, u64, flags)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 	return map->ops->map_update_elem(map, key, value, flags);
 }
 
@@ -62,7 +63,7 @@ const struct bpf_func_proto bpf_map_update_elem_proto = {
 
 BPF_CALL_2(bpf_map_delete_elem, struct bpf_map *, map, void *, key)
 {
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	WARN_ON_ONCE(!rcu_read_lock_held() && !rcu_read_lock_trace_held());
 	return map->ops->map_delete_elem(map, key);
 }
 
-- 
2.34.1


