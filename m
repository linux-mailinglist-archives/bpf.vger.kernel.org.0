Return-Path: <bpf+bounces-49328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150BAA175CD
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 02:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3DB03A4AB4
	for <lists+bpf@lfdr.de>; Tue, 21 Jan 2025 01:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8D160DCF;
	Tue, 21 Jan 2025 01:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="C2Oybdy3"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D86145B24;
	Tue, 21 Jan 2025 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737423300; cv=fail; b=q9zSAqmDivqaAmhWoVoOYcerRSK3ahueoc4uJWInSfrJL8tAqr51rWFvU5z1dNxiYct1z/gCwPdCMXwXSWc6AFFkKdN3WFbl1ijJPzDM31OHbGX6KxOHAMWcJVdDgWM7IQqL+Lgfcbt0Mj8/Pfh3fIOvav6tZ29ddku0y1gG20c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737423300; c=relaxed/simple;
	bh=aktr7evcsXDN2vdmYMP0a3vpR23yfJ2S4umQAA/yIhk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UtJNaOORHmSOHs1c/mmcNsAshnO9pANegfSfDYQ2o5EipE0P8NJMkTZZvG5VkeveNnPnathrfwolR35QqQ7SxLImXYckUeKB0MNEBTq5cBIzqz/ltJjQ+ughCO3g9eN5zuqOhwXnqyuvtbVuV00SmG57akzP08rBda9fwIqaLu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=C2Oybdy3; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166258.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KNRcSC005407;
	Tue, 21 Jan 2025 00:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=OTFMxtW3VD73qlXHPS/l5NjQovKT5uK967Cq2GjWOHA=; b=C2Oybdy3bv2Z
	CRLI46JhFXJvXQBoUwck+4Pi4xPBxL4Gyahb6YQfSljUi8FyLoiEsSY9b/lTewo0
	MJa7tPsi19PhrkeQ196dbl+GbBMyKBWg4Cdpd6DQl6SenjgJM8PM/DefHU8HLmkt
	blaQFItnLSHzK5uvwycRphXZ2VButSgAryLvNIfrC8teFOUCAbHf84GBBGKu7FYL
	jtjLjQ7WTlhSczehHd4F1Nc1ustZhQ07ZAVdmk3hub7IhHrk0jph76+1OCRnGmIF
	UW80cjD5qrz2uRr26zuUvUVEcwHSSIyc2wFtO4bTy7ws3IDo6ys9R+tdVVAIXtKj
	k5VnAqPO9A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44a0688bp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 00:48:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEKNHV2UTGXmni2vvRBnJpn42Z7WJNIpbRUMgFz6iyFB7r96Rn9oqnBpALs3lwyD8n4rFp303OO2kcCgvnAg/ozLXObUpevzl9xd+AYjh0/d2XEgs5zInecRzpUNZooBH8IJg6YAd7dYeHNd7DeRBQFLmlPn+9GEkxct47qkr9oV7xq+TycEuEhBl5sq3/wCPS3LoVbVi4ZJ4qezX96HKY9LdRJht6Xmpe5rIGuvgKpLIIJay4+uTEke49CWxvMQdm0BZSqaSoLiEa0KLHjg6c1maQfboRBfac6GARSULdqxa25rhPK9CcpzG/iGFqylolCqZmg0XZzPO/EJazphwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTFMxtW3VD73qlXHPS/l5NjQovKT5uK967Cq2GjWOHA=;
 b=iUzRImOjjoZScxfuLWktNmyFr6COlk8keLe/0ujm0KWeaxUOJb6NnEyRuFtQWkEZcqnazMgFmxT9ObYdDjStM/SLA9EG+BEVkzdXVjH2gxgHVlP5j455s/QVUILC+owXe74v0/U3dwOcLt+z9GEygapuOqKpvfwjyTeJnOclcJ09+vRhz52IyjF2NXII7EH1dW1ELeXyeUWYn6mxnniMJt8bVslv/3FnzcfKnqWNTkSOI1Yje1R3i0ceZjOkgPiiYzy8NYwFeZJ7CB3uGN0IaW1VQSH5OFRkRWJhQ4c6F5/t6NOJ1YcBrVMi0hua2wy87XFhmP9v0bQvaQIOl45twg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by PH0PR11MB7635.namprd11.prod.outlook.com (2603:10b6:510:28e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 21 Jan
 2025 00:47:44 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8356.014; Tue, 21 Jan 2025
 00:47:44 +0000
Message-ID: <c07454ba-d124-45d0-815e-2951c566e0bf@illinois.edu>
Date: Mon, 20 Jan 2025 18:47:42 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] samples/bpf: fix broken vmlinux path for VMLINUX_BTF
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Ruowen Qin <ruqin@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Nicolas Schier <n.schier@avm.de>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250120023027.160448-1-jinghao7@illinois.edu>
 <CAK7LNASn2aS6kcOy2Ur=tv_0fuEw8Gv06cVrOJ0x==AD9YRwRg@mail.gmail.com>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <CAK7LNASn2aS6kcOy2Ur=tv_0fuEw8Gv06cVrOJ0x==AD9YRwRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR16CA0027.namprd16.prod.outlook.com
 (2603:10b6:610:50::37) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|PH0PR11MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 248eea44-fd60-4644-5b7e-08dd39b53779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmR3VlJLWmhLTzZyZ2p6YjZrRzJzNVZEdy9zVGI5bFVETUFPMEhUaTRzVHV5?=
 =?utf-8?B?YlBpdVVRNmRjejB1MGQ5WXRPanVjOGoweG1Zb3kwL29Vek9hVllYUXhCSHNn?=
 =?utf-8?B?ZWRXV3BlOEFwS0hUUW1BMVRPM3Z5MXQwZ24yVDF2dHFXYlhpRm0wVDd1R0xO?=
 =?utf-8?B?RXRDM0FEK0Q2UmhKNWpCalc3MUVQampJd3MwT0pSUW9HaEdmaUc3cmNvOGxp?=
 =?utf-8?B?YnhoNnFNNFF3L0lVUmg1Z0kwTlE5c012KzRBeG02V2dHdXlaYTZCbVlzbWJC?=
 =?utf-8?B?VlFmaS9mdEJ0T2M4RzBxWm93YUhYMytmSjR4aVByS2w3TVVTaUNFWkhQcldw?=
 =?utf-8?B?ZmZJN1QwVytMNUUxOFk2TjNVWHkzUWVxV3hIVHRyNWtlZnpScDZIekNTRmlH?=
 =?utf-8?B?SVc1RFVmK3FEN2orK2YrM3RsalNrRVhSeTJNeEl1bFM5T1dRWGszYzRLQlhP?=
 =?utf-8?B?bWcwZk43NDcvazR5T1V3M3NHYk9mOFhZY3RLUlZyRFk2ZjEvbWM5anVwelV5?=
 =?utf-8?B?QUJIMlBYU2s3Yk5HR1puM05WQmtFV0JCK1FyZEVQWWJZOHVaS1dIREFtOTJK?=
 =?utf-8?B?Y2xrYUFJUzYxcUE5by9EeWtPUENlbWxxVTduejdNeENZUXhwU1FNQ0lWcHlI?=
 =?utf-8?B?TUE1aEVrdHB4dCtsNE5pajAydys0U2VLMmRiVnpJNWlxZ1hBUVI1UjRETW5t?=
 =?utf-8?B?OXhyekxxVDJCb0t0RG1KRHFvbkQ0R3dvVGRxQzlPNTc0bDlJM09ZZ0gwL29Q?=
 =?utf-8?B?bkw5WHR0RkZvSTN1Z2oreXBQN0FQNmQ5dU5NWlJaemtvOW1BRU9OVHdxUHMy?=
 =?utf-8?B?dXZKTVRrRldCWTlIQ3hHNTcwNFBtY21MU0lDOFFjM3p3Q1h5MjQ1UEdhMGxh?=
 =?utf-8?B?bW9pM1JMZGppRXR0eHczZDhVMmFVb3k5Z3krbTEwMnBVd3VQWHozbUR6bEh3?=
 =?utf-8?B?cUlWLzhVUHNZVFc2YWRvRHBaNFN3RWFaUkhBLzBpZk1KeFdxanRBUVlyVHNp?=
 =?utf-8?B?RHRDUlpkUGlyZXJoNjk5c1lPYzEwQ2pRRW95K3h3TGw5ZlFDVWhqUjFPS0hS?=
 =?utf-8?B?OHF4bzVTNk9KNnhVNXNuSFViQzFmVlBaU3FqbUN4Yis5SzR3SzJLdUJnZERY?=
 =?utf-8?B?WmNJN1ArazViQlVOT2s5aXFraW9zNzJPTWt5NHFDK0FBQnFaZDhjWFE3bWlX?=
 =?utf-8?B?dmdxSmN3UTZyRnU5V04zWGVaSUIrSUdMb3JLeUQxUEZwZnBkemtFK1dGMkNk?=
 =?utf-8?B?aU5jMnMzOFpiY3dHcWlOcXU5ODFyR0xUSTQzVkxrMU96bWdRNTJKYmlpSXFw?=
 =?utf-8?B?NzRXczBvNm9pNzVDTkREOW05eU0yMkNVc1k3cm9JaS8rLzBrNnMvMVBCdm1v?=
 =?utf-8?B?TlBUMDY0RlRHMEZBM014MmdFUjBab0R3ekFtZytob3BUdDRFM0swVldpMUpt?=
 =?utf-8?B?UGlkUVd5dWtyd0JhSkl6SHFzSklzMzNlblZPRUNxNU5zQ0VDZ000YW01NVI3?=
 =?utf-8?B?STZ3LzBMVG80OGlpb2RxaElUZkZ0RkY3NC9NRlN6OWNOR3N5TlFMR2dQVE5u?=
 =?utf-8?B?cWowUC9SSVY0YU50T1hNRWN6STNyVlYraVZHUDd0RWNuSTVqWDdodkplK2Z6?=
 =?utf-8?B?NG9qbkw4Zjh3czhnQmZFOWVoOFNIY1hlNXpWd0pGQm1BTDBsczJHS1BwTERj?=
 =?utf-8?B?VXVkNHJqNStSaUlwMVRpZ0ZnN2VaWmdESEtzVHRXK2xWQXIzeUR0eENSbFlp?=
 =?utf-8?B?d05UOXdvN0IxampRY2V4elRCQlUrS0o3bGpCUGk0d0J0K2FXbFJxOTA1d2NR?=
 =?utf-8?B?NEhNS3RKS1VYRG9HK3V2a3IyUlFKUkFaZ1ppMFFnMjRhdkR0QWt6eFRJSnds?=
 =?utf-8?Q?HnOxO8j0ZV/Gh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnVBZTBraXBIeiszQnBWWkhJV1lOdGQ2OUJKK01MeGxLRE9OWUdONTNIODM0?=
 =?utf-8?B?ZWcyK25PL3BMd0ZRcVZoZmRXYmc1Wkc1dndxS2VCQ1c3OEE1aHA0Z0FDdWJa?=
 =?utf-8?B?eDVIWGhTVFcxSnlOczkxZjUxeDI5elBEL25hbElPMHR0L3crUGZXRUgxSk5z?=
 =?utf-8?B?K09LTm1pRzY2Z3ZHMm9yTjJVNWVEWldDajUwUlB5SjdFRnFDMTNkaWdrQktK?=
 =?utf-8?B?ckVVcVFuWXlEU0U2TklyM1dwOXlGYlFtNFJFVE0ydjV6TGE4QXM3T2JydHRR?=
 =?utf-8?B?djlNK3Z5ZW9iMldSTDdiQzk3dXVKNk40RHZ4Sng4MW9lSDZnU0IrR1hUK0RZ?=
 =?utf-8?B?SURKZ0V6KzNvZ2dvV1orYjltRmtSbDJabVdYQWlUK2MybkdmY3A3VEJXYngw?=
 =?utf-8?B?WGNIeCthS2lrb1ZCUEI4S0NHbmhVSHZxT2VMVU1zYlRnM1lTaWN3SUE3VWxh?=
 =?utf-8?B?Q1RlcTFJQXkxeWNxZ2MzTnJEdnpuYkFIdlBGM2FRR3J0UlpKeUFqZWZzWWZH?=
 =?utf-8?B?dU1kUVRlTHRTUkIrQnhNREpnQTNwOXgrb08zZzZkc1MzNUVpdWNvODVnYkVv?=
 =?utf-8?B?RlNyN0NMQVRKSjByTWVuS21TQTZiL010ei9wYVBoWmVCZVFReEhIM0Y3NjQz?=
 =?utf-8?B?SUdRc1AwQTdQTkE2Q3RDN3JWYzg0eXR3Mjg4L1Q2UHJ5V2hhU3EwSE03K0xk?=
 =?utf-8?B?UnU4NWdHdG84cll0YnRHUEN2U2UzSXVVQy92NDVPMFlQKzVEUG53YmJiVldI?=
 =?utf-8?B?bVBxenFQeWU4YWlWQTIwZGkwUEJsS0FJK0hXOVlMWU1uKzA4Sjl2dDlVR3Rj?=
 =?utf-8?B?MWdUVFBXTThWWXZxR0Z2cy90WTlNYjNKMjdISExROEZPVDNmRzVxVFBKZDNy?=
 =?utf-8?B?Z3hPVmFjd0lVZE0vVUhqVlpuU0RXbVNmM2pZZlNIQ2JsVDdJb01GTktsRHJF?=
 =?utf-8?B?RFJtMVBTMExicDFNb21LU1hnWDFvUFJNRUEyU25wNCtnTUI5Vkl0M0NIbTlR?=
 =?utf-8?B?R3NkS2J3eGpaYlRQR2c4TU5iblNsSG5wT1hwUDdxQW9IMDBwa29NWUtNQU1I?=
 =?utf-8?B?UU1SVlhtdDd5ZlVtbGh2S0Rvc1VDc3ZhSDM3R0ZSTHAvT3lPYW5hQWl0UTdO?=
 =?utf-8?B?bFZjSC8rZC9Ma1VQRURKVldlc0ZHMzBDcUgxOHhiMWlTNUhiUTV0T3dyd2tU?=
 =?utf-8?B?UHJrdDdCMTV3b1NibkFYNUcxRTg2UWxvSno0Z3JKekQrTnFqaDgvdVBwTVJv?=
 =?utf-8?B?YzFLWWRhUks4c0lQcDJpSTY0dy9yRDN5c29xTnIxaXJRT1RUTjJFS09IT0lr?=
 =?utf-8?B?NzJaeUl6STc3dndiMjlHaDgyVFVpYndaU0Q3V255UFpDa01GMlMvSHhNOW9k?=
 =?utf-8?B?a0diRmNuQ2ZLN1lhUTd5ZWtXUk1xWWpPb1A2Z29TU3ZPdnc0TjZsRTF2UjN2?=
 =?utf-8?B?c0lLTzJhckNBUnNyRTF4ekU1eXZSTnhvTm1RNVBlL09oMThNdk1lRUxGVUsw?=
 =?utf-8?B?R3U2eldoTHRReWhXdS9FTWJidFRzNjE3eHlMQS8vcmNRbmN6VmVma01hdXNK?=
 =?utf-8?B?OUlPL0ZKWjlTQXNSNkVZbFhvdzBHTDVHUU1RSXJKVjVGRDErb3dkSHNSS0hx?=
 =?utf-8?B?ZmQycXV2eWdneVBoMGtDTUxwb2pBWTFVSER6NTBmQkVXeklXMlBuaVkwYWZK?=
 =?utf-8?B?dWQ0Z3lER08wRDdydkxPSnpKVWxBNWNpVDdQL3NHZk5VWXlTTzhnZjg5S3hY?=
 =?utf-8?B?Qk1kM3Z2WGxySU50QlNkYmZQdi9qTERSdDMwRkExU2tId1RuL285UFRnZmRy?=
 =?utf-8?B?b3U5KzA0aDVEczR1QUxSQ01LY3lrMWZNUUpiQldtM1BESi9kNDNidGoyZzdG?=
 =?utf-8?B?NGNRNkt0ZUIrWlRDakpRR1MyY2VPdWhMT2RiMHQzOWppaUErY3JKRytubjNU?=
 =?utf-8?B?aDdVZmI1RGFKcGM1RmUxdWlaVWNGdWFocTdJN3JJOEVudzdJTXplZ29OWkVU?=
 =?utf-8?B?L21aU0NzVEhiMEhJR1dHLzcvYkdHMjJ0a0sxVGFBNDhvdkV3VXZiQjd2K0Z6?=
 =?utf-8?B?L0ZuMDVJMWxVUllnOGt5OE9XYUFxeUJzQWZuRTIyeFBSL3liS1FvNUFNblFo?=
 =?utf-8?Q?J00Ny4kR1OdGKoiPIzv7QcBPk?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 248eea44-fd60-4644-5b7e-08dd39b53779
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 00:47:44.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3CFftIlbG0qx+N/DctbMnh9XRKwTmn2Wb4Dhji2vjpRSU7EZtHrb8IcRucz+xdpPdpFeVkGx2ahZIKH5jCnkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7635
X-Proofpoint-GUID: TqJvUbmEgqs6DKCRPJZDMkd6njDjWVUj
X-Proofpoint-ORIG-GUID: TqJvUbmEgqs6DKCRPJZDMkd6njDjWVUj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_07,2025-01-20_03,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0
 impostorscore=0 malwarescore=0 mlxlogscore=798 bulkscore=0 mlxscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501210004
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 



On 1/20/25 6:42 PM, Masahiro Yamada wrote:
> On Mon, Jan 20, 2025 at 11:30 AM Jinghao Jia <jinghao7@illinois.edu> wrote:
>>
>> Commit 13b25489b6f8 ("kbuild: change working directory to external
>> module directory with M=") changed kbuild working directory of bpf
>> samples to $(srctree)/samples/bpf, which broke the vmlinux path for
>> VMLINUX_BTF, as the Makefile assumes the current work directory to be
>> $(srctree):
>>
>>   Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.
>>
>> Correctly refer to the kernel source directory using $(srctree).
>>
>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>> ---
>>  samples/bpf/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
>> index 96a05e70ace3..f97295724a14 100644
>> --- a/samples/bpf/Makefile
>> +++ b/samples/bpf/Makefile
>> @@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
>>
>>  VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))                                \
>>                      $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)) \
>> -                    $(abspath ./vmlinux)
>> +                    $(abspath $(srctree)/vmlinux)
> 
> This is wrong and will not work for O= build.
> 
> The prefix should be $(objtree)/
> 
> 

I thought the $(srctree)/vmlinux is a fallback when $(O) is not defined, am I
understanding it wrong here?

--Jinghao

> 
> 
> 
>>  VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>>
>>  $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>> --
>> 2.48.1
>>
> 
> 


