Return-Path: <bpf+bounces-49848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B62A1D397
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 10:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE453A3C19
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 09:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918CF1FDA6A;
	Mon, 27 Jan 2025 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="Tx49416P"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00007101.pphosted.com (mx0b-00007101.pphosted.com [148.163.139.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727928E7;
	Mon, 27 Jan 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970725; cv=fail; b=jMPsfefWGcxqd3iWbpYPMdtdwKbTrakl6BlW6PxQES/Xt5Q1XMTupVF4k8VX9tCi5p8SibEDTI7AGhierkjbV0xrKtu9yjR/umJox4lGn4CDxd/+MzNcSgMgwPEt9vRGG6cO9vAi6MAI5o5T7t7x540oKunrkllSVUebGl/D1s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970725; c=relaxed/simple;
	bh=3t46Oxcd0pLKdzg5WTsYVkzzajHM54Y5e+SVUIKZ8mQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ahWSEyOYpaVSbqLe9dzK3mFZH2eI+z5+BtKOQEdRMc9SUwKGWR6P4awaXWVuQMo/Ma50VAKb5ekXuKvlis15m+gRsxXW+4D4KHEM4dYsgROuyoOUd93Uyme5M0iyNGAvST4oFbCXbYJZiP9PT/TAptkpqkPxmEjqCumA1K7QXAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=Tx49416P; arc=fail smtp.client-ip=148.163.139.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0272703.ppops.net [127.0.0.1])
	by mx0b-00007101.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R8mHCX013943;
	Mon, 27 Jan 2025 09:38:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=campusrelays;
	 bh=A2kYtthnZaAaPsf6pPDqdlxIPSEXMna372Y/qPs3m6U=; b=Tx49416Pg/Pe
	1pqJRrhYZ41iry0yKvJr+E5m0dKhJQHd26Ypt8yaFwUnsHxrPEG/78X+dc9GdDoW
	9tFUcaXuFEkZvYrQafMCeU/LjwGn1wmJK9gtht2daOKzCksbwm8CuyP8TIUyFFtH
	egpSW1+UrvJMinW319GyzSu24Zh4EARwA8EgdcS2WTBjZkn0erPJUbUy7UDwiSCO
	Gjn3yiC3Fw5yEWWSNVVFDlEkTZvYLGWF5cBt9dymCi9WzrTWvfMWvgxxWKvwaHyN
	QvPdFX3AcEAssfFsGVIuDNBWNLNgr5pci5g8Cnzdl2Bupy9aCHQ8NYHQmT/9fgfF
	/+ypk7xp1A==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by mx0b-00007101.pphosted.com (PPS) with ESMTPS id 44dw8yte01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 09:38:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIP7etSwR4M/fd2qVXU6sWPmi6bu8FyDuouqgzpcGM6CKP7ffjQ2lzzVWlYMX/Jn15Ilrpy64DVr/zD0b1Koi/SHwgWhsN17MpSD12VhHckSVdzUPp8ZsVE+pK1vylOtNinj16rScFycNv567RpnyYJN2auNY4KQD2aU1QpjUzGaz+iyBNURJs9yG3u7llvjX37lOfeeDmA8EJmWOIeBCncX3jX3UNaBrfKA1vC8YjHhaxiE4V2+psmgStq05hm2pOLaGkVPZEn+HPCknZBWHkeQhHJE+CKXwq+pHrFfXHs0695EYvVUCqOVRmRfUWuKUoKoGeKAgC7dnhpSdBToEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2kYtthnZaAaPsf6pPDqdlxIPSEXMna372Y/qPs3m6U=;
 b=aCA1rm4VKv2AYoLt+zyUragQ3tvet2S9ELJPa8QTcX+WG3mia3EXFUAlRjZObLtdNl2dWJdLHLm9GNCFUtLUkvv4hrhmjflEcK7GCt1tMBxIHnyz/mx7OqwIlZzHDwNHpst1EeZsAHgFFv0ht03LsNY6Jt7xTTup2pDJN7Cp4tFdGpalAoTkYAzYdop3/zEzoRCOjZPfpd/kWAiU9JeqVEFgaqLNn8dmsgO3xoq3737rB8USfdPo0letIdCORCUjtQxkk3H/HCUuXtF+Bqhjhewz4PHRnj8AQtY9QhPzZJ3LoR9YinMMkqNWbkF0iIROGcfP+tWHBlNQS+r4Go2EoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from DS0PR11MB7286.namprd11.prod.outlook.com (2603:10b6:8:13c::15)
 by SA0PR11MB4703.namprd11.prod.outlook.com (2603:10b6:806:9f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 09:37:58 +0000
Received: from DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808]) by DS0PR11MB7286.namprd11.prod.outlook.com
 ([fe80::d52:d2da:59c7:808%4]) with mapi id 15.20.8377.009; Mon, 27 Jan 2025
 09:37:57 +0000
Message-ID: <d2f8f530-2e31-4ddd-a743-35c7f0c48199@illinois.edu>
Date: Mon, 27 Jan 2025 03:37:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] samples/hid: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
To: Nicolas Schier <n.schier@avm.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <bentiss@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>, Ruowen Qin <ruqin@redhat.com>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20250123081950.173588-1-jinghao7@illinois.edu>
 <20250123081950.173588-2-jinghao7@illinois.edu>
 <20250127-military-salamander-of-fame-3f6e1e@l-nschier-nb>
Content-Language: en-US
From: Jinghao Jia <jinghao7@illinois.edu>
In-Reply-To: <20250127-military-salamander-of-fame-3f6e1e@l-nschier-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0052.namprd14.prod.outlook.com
 (2603:10b6:610:56::32) To DS0PR11MB7286.namprd11.prod.outlook.com
 (2603:10b6:8:13c::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7286:EE_|SA0PR11MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aaa7b08-f03b-4150-75f7-08dd3eb6487d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VE9GbC9JWlNiMHdlb2ZCWW0vY1AzZ1pjbTFNQXVjYkFPbXM3dDNCSW9mM2tH?=
 =?utf-8?B?OVBTQ0w3ZmMydmNhSndhekdqWVdVWmZPZjJqVkd3L0xBT2toRmRNUklGbE1Z?=
 =?utf-8?B?MTZLbGFDenRFUXlxN1VFdkhFM3FvV0pyTUlVZDFXOUVJeDZ0Z2lxSTkwL0V4?=
 =?utf-8?B?eHhVUXIvQjRMUDRxSWtZdHMrLzgxaVlzWXREQjdwVUJrL2NrT0hFWTNmc1R3?=
 =?utf-8?B?YXFCcC9BbjdFODRmbUdsL0hFR1hoMjR6VStnRm53aG5za2FPMVEwaTFZdUcz?=
 =?utf-8?B?cDcwZG1WS1VlWkU4NjFXUlN4emlNc1VpaS9KTnRQY1VFU2tqM01jeGV0OUpw?=
 =?utf-8?B?c2FoUmkvZ3ZmZEtZaWlTZStRRVVNeVlWQVM1ZGIramNnRXd3MVlVajJEc1lD?=
 =?utf-8?B?dzRuV1NpcFhqSXZReHExV1FXR0tzSkxuN3kvOUNwVjdTWXVPeWM5cmF6R2Rs?=
 =?utf-8?B?cnlQaXQ5NFh3ZGxTUXpYRC9tY1ROWHo2ekk2L2JsZTNJMkVsdGRGblZneThN?=
 =?utf-8?B?UVFTMlQreEVTN0IyT05USmpDR0VBcXRtN2t0TjdBam1kUTFFRFdRWENZUExz?=
 =?utf-8?B?WHJGTXhZSkxlalRPSnQ0L1JvQ0plb2ZSSldkcVNmTU9BVERxdVZ5Z3BYUllv?=
 =?utf-8?B?VjJPckl3c2dSUk5pSW9TVG1ST3hNT2RndmJ2RWpnVTdlcGJxN05LK3hKUmZj?=
 =?utf-8?B?NVQ1WkF5Zllra2oxcDJkalpDVk9YL21xaHdGQUpqSG4zNlFHQVpCL2t4ZHRK?=
 =?utf-8?B?ZTA5YU55R2JGbHNsUUN2d1o5UVI4RWp3YWtkcGpYdkZndFlubEhUSFdQRFpq?=
 =?utf-8?B?Z09HMTZiajJUQUp0SDJheFd5QTM0VHZWZGxOMzhhUjF2ZUJVL1gwckROZVkv?=
 =?utf-8?B?V0I3WDBJLzJmd3ZHdDFUQUFGYm9jVFp1Y2sxd0loM1p0OWRWVVMwSlIxam5a?=
 =?utf-8?B?WlNJb2Fzc3kvQyt0Z005dWFsL1dCN1hIaC92K3U4NmZUbWxEZ2lnRFpReXVL?=
 =?utf-8?B?blFJSDlEa3B2WHVwTDR5ZEp1Z2pzbDEvbUtvNStWWXNKdFI0YUhDT2xNbktD?=
 =?utf-8?B?ZXYzY1E2N29UdmpIUHZ0Vi9XOWh6UHdMMXdIMVp0MzBPdlA5U1hyenA5ck5Z?=
 =?utf-8?B?Q1BlbkRvVlFobHBDS2FyUzU0cmxsc2pkL2R4dGFYTzVZaEpZaUNlSmhaYXQ0?=
 =?utf-8?B?MHAvM29RZStyYis0NGRvYW0yZHhueDJiQ2EzcXQxUTBSZ3FaK1RVdTFCaHQz?=
 =?utf-8?B?OGVUMklkd1NIS2t0Y3lHUm1MV2ozMTlSM1pRNVlNQmo3MlZ0Q1JnL2pnZlFr?=
 =?utf-8?B?TWMxQkttRTNoZ0FVMkNlbkhWTjM1dkVqbFJ4dE1uTitUMEVDVFFSanFSdS9l?=
 =?utf-8?B?K2VieE9ucFZoME9qWG0xazVPTENIcDVsYU5WZ093a2IxQWRZS2lZMm0vazMv?=
 =?utf-8?B?OC9GcUNydnNDcnZRdzdYblNRdUpMNGo0TDNvQ0hFemhqcTNvWUJSdzFUNkZk?=
 =?utf-8?B?YTBheUxtWUZGZ2FMRG1aK1J4VkhxRDVoYjcreVNQMjVVdzN2cmtDd1hlR3Ev?=
 =?utf-8?B?aGdLVXVibzJoaUdOSTRQQzlSNGg4VExiMTg2VjNOVUhEYkhZNHB4Y0lIWUR0?=
 =?utf-8?B?L0ExbThvZG00U0xiaFltaHJaTm9BS2ErUWVhTC8wZlpoSis2TEtYOVNJNnFl?=
 =?utf-8?B?alRURkZXcHFDa2FmSUM2WHVoNU5CcE9qdUNHOVhiR205U3c4ZEJZYjlBU3JS?=
 =?utf-8?B?MnNDdkdXcEJtbVhJRm9mOTlobkZBOFVZQmhnUlpNOC95bDNtZHNmOWpEaVVV?=
 =?utf-8?B?UG1CMmhnY3Q0Z3ViM2dObFRHTFRObHdWT2R3WEM5emRCN2pXVW5zcUQ1Z2Q3?=
 =?utf-8?Q?8T7xW/tuNk65b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TC81SjQ0dVJBVUM5Qlk0bGNhT3Y3Q0lmcTkvQjdCbFZieEswNWVOY3RJM3RS?=
 =?utf-8?B?TWZaK3BJRkg5eGR4Zk5wZUh6dFZrSlZxNFJCSm0vR1ZnZ3RpaURONUd5VzJG?=
 =?utf-8?B?ZndzZFV0bWNJNzdIMXYwUDJLU2NtclRyMWN6WUxMaU9leG1JNHdEcWxLYzJW?=
 =?utf-8?B?eUVQRThLZFlpY0dObzVqSlhyeUZKYUhvb3dQRDhQV1A3Ym5HYTJoQzRYTGUx?=
 =?utf-8?B?RTI2bS9LTnExQkV0WVRFVUQ0QVNOUGFLdmNXdmMxSExTVkR4cnBOYldhNVkv?=
 =?utf-8?B?Y3pndG00aHdtWE5TOG9PakM3Yis2VVltOGlEUzB0Nm9sUm1VTmM0QkJPQTZu?=
 =?utf-8?B?Mk02dUwyZXc5Y2JGNzgyZ2JNUGRvWmgxVTY4NjN4OTcvYWJXOGdxNDE0cGpU?=
 =?utf-8?B?VkJWOUQ0RlpPNGRUTzh1anZ5RStheDI5cnpoYlgyYmhuYWFWcGYvYmkxTDJi?=
 =?utf-8?B?dks5M2p3SlJQUVBSSEM4ZTFjV3RYTFN3WGFXWDZCQ0pFT1Naa04yODkweFlj?=
 =?utf-8?B?NTNaUlVnZjRpenlzcXVVMzd6amM0TWRQNGtBdmdCRW05WmxYOUZ1WnEvdnJ4?=
 =?utf-8?B?T3B0T0wxMGNlOW1FOHN3Qy9DcTNweGJFeFBTWUFuMnZXT2tIMVdhU0RWRjhI?=
 =?utf-8?B?WjFnczkrdFA2dXJEaXc4UFNHUnlGSmRmaWdPZGVSMWlCYysrNUU5dmNpbExM?=
 =?utf-8?B?ZVZhd2RON2VNQTJ6Y2ZOTkg2NnQ3LzI3d01ya0ZJdWZudzVOc2s1aDEyMHZX?=
 =?utf-8?B?MllsT1MwMDRERGFZZ2U3ajFqRVRBUGlVNVd2SWQranYzTEg2K3JDd0wxV2Ey?=
 =?utf-8?B?NjNoQzh4NDAraHFPVmM1R3hqRGtOTGd3aFlYODRZeDNOUlYyWi9NTzZTTUNO?=
 =?utf-8?B?angwV2VRUVQ1M25FdGREN3FUM3E3OVdTTzRBNDNTQmd5N3dnQjF2RE5HTis5?=
 =?utf-8?B?NnJpeUp2WWNycXFET2tZRjg5Zm9EcjdmbXBOWGtReWpHK0YvazBDNCs3OGZ6?=
 =?utf-8?B?bHlzZ1ozTlVIUVpMbUVRQTVWTU0wd0JtQ3l3VW5UalhxNGRrSytUc3Njc3g5?=
 =?utf-8?B?T1Y4ZHQ3MXJRNmNjeFI3bEsvMDVJQWdpakk1ZDNsQXBJOVVJcVVRVXNzUHZV?=
 =?utf-8?B?N1k5OEtkTHFTTG56QlRUU0VHZ0FqR2QrajJYUWNXb3pxUnNLM1FBb1dZbktI?=
 =?utf-8?B?UWJYQzU5NTVjeGMya2pCMlZMRVRRcFdPVDFiZ1lacjQ4NDFPcERjekE2TEQy?=
 =?utf-8?B?VHVXMkh4UU9hL1ZuUThXKzBSMkxiUE5iY29VbGhsd0dNdXRtUEZpM3Bkd0x3?=
 =?utf-8?B?Ym9UbTA0a0g1bm5SdXpLVGFVejhIazZ1eWlWUlo3RktkUGFRUmRFQS8xUlV5?=
 =?utf-8?B?V1UrMldvZGw0ei9vK3NNS0YwVnZkMG1nYU5mOFg2WXFXVVFKcWZYMk5vK2oz?=
 =?utf-8?B?a01EVk0rVVpVeVRQOVVaZDQ5eTFETXk1eDlZdTk2QWpab0NEOXF4UVErT1B2?=
 =?utf-8?B?UUlxMGpWWk05V0Y5VkJkVDVwVXB4Ujk2T3JWazVUNjRQL29nSk9wZ0FZMkJH?=
 =?utf-8?B?T2Q0WkpsNzRnQ3hDdnRpRVptZ2ZhS283SHp1RG9pUUtjVmpYRXZSMFAwOXZT?=
 =?utf-8?B?aVlKaU9aYUZZUU5XRG5hdHFzK3Z5bFI4ZVN1OVhXUEpiSDV1RnpRNllXZkRV?=
 =?utf-8?B?WndGeWgvL2hGeTU5OWo0a2ZrczBGUFpzUGZRU1VzUFowcjRGWU91ZGF2Wm9P?=
 =?utf-8?B?VTE4UWNqd3pBUWpYeVh3SmdtWDIvRTlycG1SaXRYN2sveEpzU0lhS1NWMTNh?=
 =?utf-8?B?MlE2OFVFWlllNm5qZHU4RnJuMGhMZTRRcnIyQTFMZjd6TjhaZ0JveGFuNXQy?=
 =?utf-8?B?U05obE1XNUg2c2tvTVVaUmpQV1BLak43M3hNWkNFU3ZqN0c4eXhrVlF1Sllm?=
 =?utf-8?B?SVlvZnMyZXhIWU9PdC8xVTA2bFN3NGZWdFlJN1p3R3NnQjVVTE5FeXZMSG5B?=
 =?utf-8?B?c1k2RnhJNEQ4emdiNmtKd0c5cHBEaTJjL0VBVXFGcUdEUWVIRmRvVFkxSXd1?=
 =?utf-8?B?cFNBcHRpUmFQNEpNY29Cbm5WR3FPTHd5eVFUc0xhUmhVYzBVRlJMNHNRUlZW?=
 =?utf-8?Q?aDLyooCgGuSCBz6kLrsYa2jmv?=
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aaa7b08-f03b-4150-75f7-08dd3eb6487d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 09:37:57.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rt70l/Ghy21MDNLKATAPcMkIclu1m1mjifAcLXL5atwVZVI3y2xb98mFw4WRIHt2pruYjycv5MJiCBexGy1SLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4703
X-Proofpoint-ORIG-GUID: PAMvkdDJZuRVic5ATBAQXRDqnDZxIZ20
X-Proofpoint-GUID: PAMvkdDJZuRVic5ATBAQXRDqnDZxIZ20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270076
X-Spam-Score: 0
X-Spam-OrigSender: jinghao7@illinois.edu
X-Spam-Bar: 

On 1/27/25 3:29 AM, Nicolas Schier wrote:
> On Thu, Jan 23, 2025 at 02:19:49AM -0600, Jinghao Jia wrote:
>> Commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary -I flags from
>> libbpf EXTRA_CFLAGS") fixed the build error caused by redundant include
>> path for samples/bpf, but not samples/hid.
>>
>> Apply the same fix on samples/hid as well.
>>
>> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> 
> I can't see a relation between this patch and the referenced commit.
> Can you please check whether the 'Fixes' is (still?) valid here?
> 
> Kind regards,
> Nicolas
> 

The 'Fixes' is from commit 5a6ea7022ff4 ("samples/bpf: Remove unnecessary
-I flags from libbpf EXTRA_CFLAGS") that fixes the equivalent issue in
samples/bpf --- according to its commit message, commit 13b25489b6f8
("kbuild: change working directory to external module directory with M=")
is the commit that breaks the libbpf build in the samples.

Best,
Jinghao

> 
>> Tested-by: Ruowen Qin <ruqin@redhat.com>
>> Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
>> ---
>>  samples/hid/Makefile | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/samples/hid/Makefile b/samples/hid/Makefile
>> index 8ea59e9631a3..69159c81d045 100644
>> --- a/samples/hid/Makefile
>> +++ b/samples/hid/Makefile
>> @@ -40,16 +40,17 @@ BPF_EXTRA_CFLAGS += -I$(srctree)/arch/mips/include/asm/mach-generic
>>  endif
>>  endif
>>  
>> -TPROGS_CFLAGS += -Wall -O2
>> -TPROGS_CFLAGS += -Wmissing-prototypes
>> -TPROGS_CFLAGS += -Wstrict-prototypes
>> +COMMON_CFLAGS += -Wall -O2
>> +COMMON_CFLAGS += -Wmissing-prototypes
>> +COMMON_CFLAGS += -Wstrict-prototypes
>>  
>> +TPROGS_CFLAGS += $(COMMON_CFLAGS)
>>  TPROGS_CFLAGS += -I$(objtree)/usr/include
>>  TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
>>  TPROGS_CFLAGS += -I$(srctree)/tools/include
>>  
>>  ifdef SYSROOT
>> -TPROGS_CFLAGS += --sysroot=$(SYSROOT)
>> +COMMON_CFLAGS += --sysroot=$(SYSROOT)
>>  TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
>>  endif
>>  
>> @@ -112,7 +113,7 @@ clean:
>>  
>>  $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
>>  # Fix up variables inherited from Kbuild that tools/ build system won't like
>> -	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
>> +	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(COMMON_CFLAGS)" \
>>  		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(HID_SAMPLES_PATH)/../../ \
>>  		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
>>  		$@ install_headers
>> -- 
>> 2.48.1
>>


