Return-Path: <bpf+bounces-51758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B678AA38A87
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C175C3A38C8
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E415229B0F;
	Mon, 17 Feb 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MrtLmmrq"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2072.outbound.protection.outlook.com [40.92.90.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78964EB51;
	Mon, 17 Feb 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813170; cv=fail; b=ru6DAiIEICJYLCyR4U0PNH61O/VhIZukJsthksveOzIs/Nt1V/KclXcRkg7J4wcZwszJMXJwCFVtovz9YeFa+HBUIz7kYpSJwCoJXUt3wKhlFLXtJH2KXLrqu88NqZg6+SArD6SX8WIxMA/UMtmBSaWnx0UWnTNLBWUoD95U28I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813170; c=relaxed/simple;
	bh=uZyrKme2tCXnb7MvZUcujjsBOJeNdWhoOWfkCwisZbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uwHQ/uGP3IibzapFVV09OhvGRnn7ego8YbadZgyb0B5SDAblHj7U+EpfjMrrbg/qhlQVgQ9o1DGpD+qRXMBeUgInYaOEKrAXoF3R9iUR6wxhQyBf2eCFPw/aYE6cvLyyh3P+FHdQoRY8YdeEv7kGM7INzp1lDHwSdT+jmKA9dXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MrtLmmrq; arc=fail smtp.client-ip=40.92.90.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl1lwHAeG+6WwJm3N2teldOZ8r9WyGf3cSUAExc5+S9e6ciZKfraMuK1K7BOAJO71tre8mDRaL+Btic4pKVASDggpXLwT7gYHNSO8HGFUpmJGDvdOsJsqjilJA8JkUj+w1VaXot+va9qLd5NwH9cXT1ETgrt4WsM7n2wHHpPATGIDHhk/4QlggTQOgLJbs52gDe0od57f0LFu1KbtAaCA2WcTJWgKfz5nUNlR42U7E3BDe4tj05ANrfF1iintsoq3mrs5Wl/sU5+PolaRcxPP3t/1o2YoVB9ZRNtkjVWAXlbBCJ6GdQtX3xxwRnlHLclcmByY1qEiFUQr13/8+14Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4md4asjGChWOidZdqmwKyZ0PWGkOJXry09dz2xmGuo=;
 b=OkRclrHmzB0K4dKHvl0MeXd/IDL2PvGvfFHJ8+AetDqyG/ynR2Zb1gV4oV375FBeGOt0O97llrk9zBcjqmwD7RIuviVtMOnPxeU8jPkTgrFIFWB4vqA+GL9zbTo2XeVhkoEejLbrjC9L9EwSr7tk1EJK1IzzZI+pZgtC7gl1D7GUbcF0ZQEILwd1ta93axA5Crn4jjhIGmi7k3F8HXKv7tzx3SANsVK6NdOEsW6492j1x8PloC8PQg1ys69tZ4X5/oDullw0jd/3u1vM4NDbhMggEy4rLGZ31ISIXD99nGvJJh+hc12IRjG+w7jb9YJMsOphjZLMWKEfLoNCcIklyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4md4asjGChWOidZdqmwKyZ0PWGkOJXry09dz2xmGuo=;
 b=MrtLmmrqRQlKYOQ2IteToCxVQIl01AASozfmNM+6SSWnETAqyWSgFU0Fwv5gFVfe6Ag0Uv4B7Ory4xbbSouYB3/ecM3ba7gUOJ0r8eBaTOMxGXN51MV6VaUQ2BNTLEqm7WJt/YIxN1nazdrFt/82HjnFfOwDcLIePA+cwQe0J2O3KrzShoAOxIodzg22wtADTTRrm1jY9kL+cMM2Vy9CVA2LuXaVtRg2YDmIjcA3otnXlzMnZLwHWHlZ7PeO3n9+Bp69YWJZPA1QyoHLuR5Yt0LUzyIKhPutbwvOegzlFW5kILndPZbphYzTKg6Tfz4UO2G1U74SEErD4JZR7qlbqQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6613.eurprd03.prod.outlook.com (2603:10a6:10:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:26:05 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 17:26:05 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 1/3] bpf: Add BPF debug mode
Date: Mon, 17 Feb 2025 17:23:48 +0000
Message-ID:
 <AM6PR03MB50805DA79A95E4A6AE79388C99FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250217172350.56184-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: 86d140b4-6029-4f65-9694-08dd4f782878
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|8060799006|461199028|440099028|3412199025|19111999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H9hx185upfSNaN19KMJ1GmadWsQ4lwj1N83qa7LNrFcEWK/6ZYy+nXZz38Iw?=
 =?us-ascii?Q?Ipo3CvIGot7vZafm//u91E3SOXPj2lIaR2BVS4nPNAP6DVycaDzbJrt2BQvp?=
 =?us-ascii?Q?QQA87BrtUx/VYdTnaM3C/aq+CoqUOFh/zKEjdXpRG3WwKgI29wheFa3T3jaw?=
 =?us-ascii?Q?br9PmF3jh0hC2N+MmOUUPsxOGf+bOaPHBuDhe0hl7As3xWP0Ak1IqzqNoLba?=
 =?us-ascii?Q?FDZqLXsNuqwXAUfmXjCiVGXgylHxPfwHciet9A4PNIWAM0VCRJSaE05OjYa+?=
 =?us-ascii?Q?Cxn5jV+xBgrZIGGmlQ4BU0Q7oNmyUyZCmHs+mJ4/8FvSf1FFw3IZ8n0yLA9Z?=
 =?us-ascii?Q?Wr22aRx/Vijuhue2aBIhlYekats2ryBn92z3QDanSntdHmua94aijan7jbwK?=
 =?us-ascii?Q?aom3n4y2i/gjE0ZroYxBmT06OpzmB641BzhDJN06yZqdQk50KQ2dnHfrRqR7?=
 =?us-ascii?Q?KeH2Xy/ZzF/AKwZxfR8RCwdMObKwDU5nPcyZSugtQyhaWjJgLn8PJNNsDV0e?=
 =?us-ascii?Q?O158kEy5RDNiUSoCT5+OE1he7fwoV1T+1DwLxSoC12Ai6JO403NhDHVDcNJB?=
 =?us-ascii?Q?JGyiW8cBbf8C7Ow3630Wk6x5i36S4rKpIO2AeLbzmmmsIU86f6uqjFWvRG8p?=
 =?us-ascii?Q?/OQzuqwBujGmkYTHdjJS3GyoujO4lmIyO7CrCg6ZvIcn60gQQPkaTz1YIfAL?=
 =?us-ascii?Q?cZBg9oMggd09Mhvq7gRoz6V8AJp0ZZxaTa1ud539hToDkEvsHEEQV7/vX5H5?=
 =?us-ascii?Q?47j/ObN3np0MIbq56D7TT8EqDI15K+OPBQ8bgJJ7FBQervDUfqslA2xwWjG0?=
 =?us-ascii?Q?vFrXbnsQ/Q45EgfJmkz1dKFj0k7Qt078RcQ57a4Nz7YGL1AOU/4ZYCpDUaj8?=
 =?us-ascii?Q?TIXKHKHZgOCSvjVeRdrq8+GU/um6uFm9Vr0NrHPXjChGgPRSyd2ac3wNEg2m?=
 =?us-ascii?Q?S4N6pPw4UUTzuTeQpZ7TMG2lECrldqlt+W5mbCDwiBJplC7BfdRSU3/TQgML?=
 =?us-ascii?Q?8952y3fQVJwfPgWkB3iU3UpN1SFWdiOawvqsWx7zBbcI67r7uPwatU0CSv6B?=
 =?us-ascii?Q?7cw9qIhAsL68O4ei000QsCm/725NNXb70ZV9mEhLSI8/Sd7W8Ng=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6WlnY1hd6K82nkfd70Im9Ej7sZ0CTPWoy+cD4MZxOm665uR2SjXOflqVFWZ?=
 =?us-ascii?Q?nZUH5Pl6kHfsHDd0gzqRsxl0ldFGw/K1CnXOxyJbfW23gRFbqGhnT44n/TH4?=
 =?us-ascii?Q?Z1ETPXpuNVhkoUng5mXQSGpc/d6b7iLnFmmZ734bH8mfHY138iO3gnSNTFR3?=
 =?us-ascii?Q?Ss0g9Ue0+/zMnEq70pPeJTQEtyUyLBRxZpE5/SO39S7cwB3fryGHnoFH2/HT?=
 =?us-ascii?Q?YJtOtxb8gqLG3l58uEgCK95NnTVG99oduwS0k6usibkbNDhcJ7pAGTjVPs0J?=
 =?us-ascii?Q?a345ZXIlWSm7Amrkgd/We3HLWrNkwyfANm/3grIoo1qW0Xf0nLRqNTBTljiU?=
 =?us-ascii?Q?lCpA1K0JYi8hYg1+oFTro06QtphWyJUvry54a15a2EkG7Q0pusVYd/6G6vAZ?=
 =?us-ascii?Q?pZbTpi/8RIgjEZZcGYmRK4qPw+LgHQTzyYFBV2eoRLHn3J1yHp+qSlYo+8FK?=
 =?us-ascii?Q?h0uccxEria3O3m0AjTupX0ohK/4wYlo5gNSsUSMF1t0w0qcXsswZv/A2Nik0?=
 =?us-ascii?Q?iOeZcMYpHVPNaOCDfi5FWSc5JVamP2VoCAjUzZbyS0GkV7WqVmdYt3Nn3AE3?=
 =?us-ascii?Q?bZN4g0sv7tnglnDa1qGc6TIJrKCfDiT9Lo7h2rP4EZRNhhVFv7MAxkewEzP0?=
 =?us-ascii?Q?myhSgb//DgeB3QeFooBLf04zr5Ajn8ixRN+jyVfxqKRHebzRztwQ5+CYMXO0?=
 =?us-ascii?Q?3x26EvZktpW8Xn0OtDyJlIrnIDaOXIzXfPBgay7PiGzKNAcj41yHUeFCVOjT?=
 =?us-ascii?Q?Z/SsMo70yrSBxEgmyhsXaRuGQPPNbDJFIxxcDbiJFPqn39UDVlGKJo7jGcKH?=
 =?us-ascii?Q?uTUeYt8JbWeSYCK2Enu4CDDuTL5g0VCS1zAykmKuEZ63rJKuxRp7La1eaM43?=
 =?us-ascii?Q?M5gobRdyWhvzz2hrEWozFiOk7ZJ2DcNRWqBE3azuRvgduCKj3DfVeOH/G/NI?=
 =?us-ascii?Q?Fgp/1EwMG8Vii1Nalt88t9ewJbY3ISUglZ393qcXuCJqihDUuPBaCSCCwyuE?=
 =?us-ascii?Q?QIjAj2/DKo894Nr7XDBoCWvkSNN3t0kq452ujdNx/WgxcpBzoN0H08vQVIE7?=
 =?us-ascii?Q?ICjyum7ThCcP6kKUkxHoADYO2gROD1CJho4qYiKumQJTJctnVJyFWQ1tdH0f?=
 =?us-ascii?Q?obmAxT3t68ZhjihwvQhwSAJmc+e27SUAK8deFuX46tTqhSbQ45tHVZxXHrd6?=
 =?us-ascii?Q?GvA3tvlUu8WC7dwYtsrHXDJuuqGpmS8Me2FJAudVCxFRWkGvgGd5iRVV3aUp?=
 =?us-ascii?Q?XPc9o37MW/vb1+Y5yquh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86d140b4-6029-4f65-9694-08dd4f782878
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:26:05.3218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6613

This patch adds BPF debug mode.

When a bpf program is in debug mode, all calls to kfuncs and helpers are
traced and output to the trace ring buffer, including arguments and
return values, in a strace-like format.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf.h            | 3 ++-
 include/uapi/linux/bpf.h       | 1 +
 kernel/bpf/syscall.c           | 4 +++-
 tools/include/uapi/linux/bpf.h | 2 ++
 tools/lib/bpf/libbpf.c         | 6 ++++++
 tools/lib/bpf/libbpf.h         | 2 ++
 6 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 1bc90d805872..c8585b436d0b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1614,7 +1614,8 @@ struct bpf_prog {
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid() */
 				call_get_func_ip:1, /* Do we call get_func_ip() */
 				tstamp_type_access:1, /* Accessed __sk_buff->tstamp_type */
-				sleepable:1;	/* BPF program is sleepable */
+				sleepable:1,	/* BPF program is sleepable */
+				debug_mode:1;
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fff6cdb8d11a..6c68a16a5549 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1272,6 +1272,7 @@ enum bpf_perf_event_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
 
+#define BPF_F_DEBUG_MODE	(1U << 8)
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c420edbfb7c8..1261315c2410 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2757,7 +2757,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 				 BPF_F_XDP_HAS_FRAGS |
 				 BPF_F_XDP_DEV_BOUND_ONLY |
 				 BPF_F_TEST_REG_INVARIANTS |
-				 BPF_F_TOKEN_FD))
+				 BPF_F_TOKEN_FD |
+				 BPF_F_DEBUG_MODE))
 		return -EINVAL;
 
 	bpf_prog_load_fixup_attach_type(attr);
@@ -2870,6 +2871,7 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 	prog->expected_attach_type = attr->expected_attach_type;
 	prog->sleepable = !!(attr->prog_flags & BPF_F_SLEEPABLE);
+	prog->debug_mode = !!(attr->prog_flags & BPF_F_DEBUG_MODE);
 	prog->aux->attach_btf = attach_btf;
 	prog->aux->attach_btf_id = attr->attach_btf_id;
 	prog->aux->dst_prog = dst_prog;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fff6cdb8d11a..3b700cb86836 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1272,6 +1272,8 @@ enum bpf_perf_event_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_REG_INVARIANTS	(1U << 7)
 
+#define BPF_F_DEBUG_MODE	(1U << 8)
+
 /* link_create.kprobe_multi.flags used in LINK_CREATE command for
  * BPF_TRACE_KPROBE_MULTI attach type to create return probe.
  */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 194809da5172..2ff3f2a597b3 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -689,6 +689,7 @@ struct bpf_object {
 	bool loaded;
 	bool has_subcalls;
 	bool has_rodata;
+	bool debug_mode;
 
 	struct bpf_gen *gen_loader;
 
@@ -7520,6 +7521,8 @@ static int bpf_object_load_prog(struct bpf_object *obj, struct bpf_program *prog
 	load_attr.log_level = log_level;
 	load_attr.prog_flags = prog->prog_flags;
 	load_attr.fd_array = obj->fd_array;
+	if (obj->debug_mode)
+		load_attr.prog_flags |= BPF_F_DEBUG_MODE;
 
 	load_attr.token_fd = obj->token_fd;
 	if (obj->token_fd)
@@ -7972,6 +7975,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	char *log_buf;
 	size_t log_size;
 	__u32 log_level;
+	bool debug_mode;
 
 	if (obj_buf && !obj_name)
 		return ERR_PTR(-EINVAL);
@@ -7996,6 +8000,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	log_buf = OPTS_GET(opts, kernel_log_buf, NULL);
 	log_size = OPTS_GET(opts, kernel_log_size, 0);
 	log_level = OPTS_GET(opts, kernel_log_level, 0);
+	debug_mode = OPTS_GET(opts, debug_mode, false);
 	if (log_size > UINT_MAX)
 		return ERR_PTR(-EINVAL);
 	if (log_size && !log_buf)
@@ -8018,6 +8023,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	obj->log_buf = log_buf;
 	obj->log_size = log_size;
 	obj->log_level = log_level;
+	obj->debug_mode = debug_mode;
 
 	if (token_path) {
 		obj->token_path = strdup(token_path);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 3020ee45303a..191547045b7e 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -123,6 +123,8 @@ struct bpf_object_open_opts {
 	 */
 	const char *object_name;
 	/* parse map definitions non-strictly, allowing extra attributes/data */
+	bool debug_mode;
+	/* open debug mode */
 	bool relaxed_maps;
 	/* maps that set the 'pinning' attribute in their definition will have
 	 * their pin_path attribute set to a file in this directory, and be
-- 
2.39.5


