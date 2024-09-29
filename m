Return-Path: <bpf+bounces-40512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4059896A5
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 19:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32B21F224E7
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 17:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7973BB21;
	Sun, 29 Sep 2024 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="l95jA3tf"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2048.outbound.protection.outlook.com [40.92.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224652CA5;
	Sun, 29 Sep 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727631929; cv=fail; b=T3Kj0fD2EhJyM2B41XsjKfm4OfiabceZPVMgeNzDRUvPyQ4SnmMyYV5DhShjPw21lGyfvjxQBnXD/XIGBSGeMrOqP8/Dm6Bbyah/sO2Cam3qSrFlxjKlEa8T2qw0/WoQW3jE3q/Ip8lcDNaEbcqB0rs+J6CkVdTrw9Q1KEnY0zM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727631929; c=relaxed/simple;
	bh=EwRIjixWictG92uy03xv4do3aE7PuW0GwkRhoC9qwNw=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sKG0gr6hBayteG5YwlEUDQPniv4Q1Y1DOAFtDJVzVlBIrM/2TntJ6VBgXATjS5rM5VvaohlRYZN2KJ4vAxrQKewK9zhM11M1Kvfvd9iogk9r6c5d1bdP03y4MFas65nU7bbX2fxNtwqfY5whVgxRPNQltTVvUZksKoumtj2x4mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hack3r.moe; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=l95jA3tf; arc=fail smtp.client-ip=40.92.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hack3r.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b2Pvebtq539See4+1KgeevIJOiAlXOhOcGmRY5GfGGhp5GCWpMmoAosHklYa+JDq3Yrof9nWTYdQnhyBFEXwACaCvddftfXrXiD6Oc9zovWF2IueLZtvo1/CS+XKZcCRZ7GJ6qOnZ9vewiZqrpwwj6iWU9SulbmAfKOkpkOj7nUoesiEzCJttioTMq+So4K/kXahrljLWgcdHUAtXP8b/2O0lZ0tUbpmxzferbYOZ462RUhg85biGsQ6hpVYYTZOLGeRtHzUUTSuEinSIqINXr1PsErDVhLFZ9tWpi2yw+JXW47VUx2rkJDyUexEFX1kLY4ouWme2mI6YAE5ZcQafw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7tfDbOPS4NH2g5vsn9Zd7k6j36BfmA341zRc6EWbNg=;
 b=ESvuQ4Oax5dKNlayQAH2Sf9R5Cn5gzGw03gKAqoNQREjFj0zwDIJxuYwjKJB1WezpJWbl+gjdTn5aZccwYGkNmulw2MOMOh3Vtp3uGUhxXubLPhojdCRVgUVxXCDggEPMCEpBa2nF6UCm8b7Gd9LFIAbKu3MWgIt2G5nyd67raAoI3c8cC974zhZhrq+fw7fQMOML5krYBGTTtx/5LJD/OU9hRMRNpvtBE3/++2Zl5f82oQiQZ+twYASb6DgfF+DnBmiOyEAwFBJ6YIdb185ueK4Qn0gFNZPZ2+Nhw1nLDwgNLP7KmQc15tyHUM1aZNB8aCojphBNnb5CP3LTrZISg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p7tfDbOPS4NH2g5vsn9Zd7k6j36BfmA341zRc6EWbNg=;
 b=l95jA3tfnZfnf21vVmyDL/Ep0omzva8dvcDQz5UBaCAw2cgdE6hv009rvMOSM+ASts5ed7P7m6M4jsdb2aMAfyav9g3OhZEoCDMTJZEN66ylti8ua8sSkB9Qs3yQAUWVDKz3da14f8Bz0Qlepcu5SadeezurziwvuVBAUiyyPpoV6vgYEadPfxyeLk5qU/Fj3s6k+tnQwlZc56Zx6lFhiqSnGWz4goDd84a5TbDbHi6cAqeuev4rEcnpU23D9owY2ZUJHkWvg22KtMahF+Lpv33LKVFUMrE174IyrR4vRglVIuoPJeLh2y9QaDHferJqAP/0bdtLBXAOIPUH2EiZKA==
Received: from MW4PR11MB8289.namprd11.prod.outlook.com (2603:10b6:303:1e8::9)
 by PH7PR11MB7641.namprd11.prod.outlook.com (2603:10b6:510:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Sun, 29 Sep
 2024 17:45:22 +0000
Received: from MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022]) by MW4PR11MB8289.namprd11.prod.outlook.com
 ([fe80::d626:a4f8:c029:5022%6]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 17:45:22 +0000
Message-ID:
 <MW4PR11MB8289A6D1FC8B6823A67583BED7752@MW4PR11MB8289.namprd11.prod.outlook.com>
Date: Mon, 30 Sep 2024 01:45:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] libbpf: do not resolve size on duplicate
 FUNCs
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe>
 <20240929-libbpf-dup-extern-funcs-v2-1-0cc81de3f79f@hack3r.moe>
 <CAADnVQLdmmvJRyf+br=CtJaDw6PowqKGTXb3z-q7LpbYiYFpHQ@mail.gmail.com>
Content-Language: en-US
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Network Development <netdev@vger.kernel.org>
From: Eric Long <i@hack3r.moe>
In-Reply-To: <CAADnVQLdmmvJRyf+br=CtJaDw6PowqKGTXb3z-q7LpbYiYFpHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::15) To MW4PR11MB8289.namprd11.prod.outlook.com
 (2603:10b6:303:1e8::9)
X-Microsoft-Original-Message-ID:
 <7d9a0442-828c-46cf-bf3e-5933665b8a3a@hack3r.moe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Eric Long <hackereric@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB8289:EE_|PH7PR11MB7641:EE_
X-MS-Office365-Filtering-Correlation-Id: a59a217a-d9ad-4e47-3ebc-08dce0ae7e02
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|461199028|19110799003|6090799003|7092599003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	BuHVygsqBfT0f1+MA/98MVBvt7BWkB5jdB08xVk+qLQqttXoUkhe6WrkGlu21ENsl3coOpM8OsGsrBB/oz29v0gmxn5Fd5uiAK9rW6ZmoBxMZIeZAmO3u6LKApVMNlprvULmpb4rQ6/mwgNEutrekRgz24PLHEKe+0CYnnQodExDBorpL013iI5NBxiH7BZA0cnxR6IomLm3ozSZ6qkkspknCvvhJUgFGKHKQDczhyk9yFlkyrEK8Rn4XCYQlm5a0Z4yyMcZsntm28ujxDBFVUXB8p7FnZTaw6V57lFbvQNZzAyoVIuhXu+guIdBOoZoiXoc05K/vxZcbjAKfb63mInuuUFie8e6onGiCWLud6eixXUFpsA2ua5eoUxjHt/47z2S3otrwzWrMC7F7+/GI1Qhutrsy5rVQtMArHMpnhWeLAFZNshwvJm8XOu2qsjNhPSSBA6ML1aANs3Fmo0EpDTxl0X4Ii/k9E7vAR1vGKfX64ssDqwE0ahvPWtZjLglmfi0iobnVf4ofdoM0cVs6MutSncA3h84WqgsOfA+Fs4DSF4A++KEzfhXrlntpsvYy/U9dWUgbaB4EN9rcj496PUnYa1naj/5lx6/A+6ZrtjWJUOQNv269Tas03Dzc/Dj8ZS4wRnU+uV1hwICaMTemAVTG7+sQDIs8xBFhR4ACHwTRukAiqJg4UvtMaTav8hXKPM8aMOwRoF89ocT30yop6h2ZrIjqgPPdkvHjPvHZ42PGt4DowC47qaORL449SNku0NGTM7y8bn4K/i11yG5Ag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGVmVlBiUHA4VXZsM2pEc241VE1la0hLRm1aeXdldEpoVm02Q2NrbVpVZlpP?=
 =?utf-8?B?TFhjWTh0SkxOMWxKLzJvQnY0bDhvS0VSZ0hhS1VpYXl2cVZ6TTJ0ODFTcEpv?=
 =?utf-8?B?cU9zVGdnZXk0b3k0K1ZWbCtIcnpRRnVFM2NUeEd3U1BPd0xOUVA0MzQ1bUZB?=
 =?utf-8?B?dVN0dk8rUExuNENMYS9SSEMyVWFRZ1hEOGdMMUNqMnZHTlFkaDhyNEVqZm0y?=
 =?utf-8?B?U0U3dENWMTlpdmo3N1VJZ05TWlRsa3A0Y2kxOHRUQ0VQdTQ1UVphRTV1Uldk?=
 =?utf-8?B?Mmg0WDE1UHRMN3VUOThMdk1Xa3h5THVTZDU1UUlsTnhReG1ORXJPaURFS1BM?=
 =?utf-8?B?YUhCZjhZR3E0K1F1SnNrdW10eWV6VDB2aUZ6L2xtNHhZelpWU0ZoN1lQTGI2?=
 =?utf-8?B?eTUzbUNrQ2dUVHRMVEVIcUxSYXVhWDE3Q01nRXhOWjVlTklucVdnZHNibnB1?=
 =?utf-8?B?cldzTERIeHRPYmcvZnRNdmZDa3FTL3FnZHI4c1YzbWZMeFZBU2pkUjNEMDQx?=
 =?utf-8?B?TjJZWU1RQkVBSGFDYVgrWWxkVjB6R0RGbms1NXYzTlVXTW8vamp4VEdZbkQy?=
 =?utf-8?B?WFNMR2NLb0I5MEcvRGN0SDNNWkV5aGdYbzhwcDNhT0c5c0ZxTEtZRjE5YkU4?=
 =?utf-8?B?eUhNK3ppcjEwYTJWaGhIMDZMWWJFMEY1bmFFcUJKLzhjSUN0cXFiNXpzOVox?=
 =?utf-8?B?RHRWT3IweDNlZ05LOXZKZjlsNDhGWGtRSnhQRDg5R0crSzlvMkNjdW80S2c0?=
 =?utf-8?B?b2IrclRleVdKZGJRd3VvNDV3aDVseEhTMzRjelp4dnFOVWdFSHh3SnhLa2w1?=
 =?utf-8?B?bWM4c2txdVNrSXBiVVNLcXBnb2UxMU1SSDE2R052WEh3Y1pOYUZNOVlLdDNY?=
 =?utf-8?B?aWlrWkxBNkJmZFAvQUpIaWJSVy9WSzhnUnlSZ2dPVjZWOWtyMnppODE4REw3?=
 =?utf-8?B?Q1lkRU12Mkp3K2Qwd29IVSsrSXBRWDF2OGUyWFFqVmhZM0JZdVpwOHpqazVw?=
 =?utf-8?B?dXBxcU1ZMHl4S0dYSXU0Mk5ya2tvRHFoTXFKa3FPNTBuSW9HVCtINFUyRkxC?=
 =?utf-8?B?K1RianYyVkQ3UHA3QXVHM0Q1RzRXT0FvMk9oMStYV3dlNDJmR09NY0pNbThN?=
 =?utf-8?B?TTliakpwWkxGS09JMTlQeGZYTVlmcm1UaStnM1hwYmxCRUF0V016Y2dGUHli?=
 =?utf-8?B?RU9IVCt5eUZJT0lvUjIyMkhJTGFkSjFwTTV3a0JXUWU1U2RSREozVm5jNTQx?=
 =?utf-8?B?aDBHc2hLdHcrUDArVVpOczBFVUVMT1JZQldUVGRGeWFFUjZJeGdZN2cvUEto?=
 =?utf-8?B?T0tMTk9PdU54dW1nWW5TV0w5Q2ZMRklrOWhHWTVycTVxcGdoV2krVXcxcmpP?=
 =?utf-8?B?VmFVckMwQ2QrMS82cSthVEJ1dnUwMFZnWVdkWExYVG9zc0N6TVJxSE9QYzE4?=
 =?utf-8?B?UitXQlhaV3QvUDE1aUJjYWs3Z3BwM3VUWlJ3eXpadDk2UVhEeFU2TnIySkhz?=
 =?utf-8?B?NTVWY3doWWo3SFVxTmhVdC9QSTIzZG5MelExaHk5Z2tnandCemNQaGJEc0tD?=
 =?utf-8?B?V29rcmlXTldrd3JJSkltVHJVR2pSOFhqQXhLa1IydHQxTGdrc2hpVUxUM0Jn?=
 =?utf-8?Q?B9xCzOMPzVpKgemfixKlH31M0yA80GjFG8AgJeNFFZXM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a59a217a-d9ad-4e47-3ebc-08dce0ae7e02
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 17:45:22.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7641

On 30/09/2024 00:32, Alexei Starovoitov wrote:
> On Sun, Sep 29, 2024 at 2:31 AM Eric Long via B4 Relay
> <devnull+i.hack3r.moe@kernel.org> wrote:
> 
> Looks like a hack to me.
> 
> In the test you're using:
> void *bpf_cast_to_kern_ctx(void *obj) __ksym;
> 
> but __weak is missing.
> Is that the reason you're hitting this issue?
> 

No. libbpf still returns -EINVAL (from the same path) even if the 
prototype is marked __weak, when the patch is not applied.

(Sorry for the off-list reply)

