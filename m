Return-Path: <bpf+bounces-70909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE86BBDA2D6
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 16:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8033A7EBB
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 14:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC2D2FF64A;
	Tue, 14 Oct 2025 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rFRnX/oy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JQIqJZib"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B97418A6B0
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453802; cv=fail; b=Q3AdiUGuzGzKtZTUR/3DbVGUx2eSPQGuhuRxYm7W89H25v1qZohCTOboxhpVHOGxP3bOIwGujhPhr2piQzgiyGuxy8wFI7VenlF8bxn1HiQwH2BOLJLp4Kc8zGtFgo65krPJI1vV4v/emSMcfgZpVZCa8FSpHDOO26WQxyuGCY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453802; c=relaxed/simple;
	bh=AeoHrPRy7xLXpA9RjJQLiGJOKId8KfMlO08DktAegZY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F6PtxuNR5m8E6R57HeT5oA3tWzGKPqQdh0Lc7cYOFSDBXCzaJvYN6KMA1SX0ihzQ+tIpGf1L6Yx/JGNKvOOYqCRvFuxOPvFEFFwoYVoKJxHnLW66a/WjOPjGiTIQam6L0uSgCxY3UwdpIMRF5axA2f+jkGKZwuixtVVdhafuGgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rFRnX/oy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JQIqJZib; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf8EO001757;
	Tue, 14 Oct 2025 14:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CzhtAJ7mIWavxtyHxZSygWI3xevZhs1uDf/KtvT30D0=; b=
	rFRnX/oyUwKY2BH9Ti44Ju1UfFyrOXKklFmVaxhC4pOl5Q0nKKqVOcwOgxZTxFqi
	55yYmHkJZJxg+MkT7PHsrSHPaBjoXZv3Mo+YMs2us1eTHWQolnyEWBAL+7u9I5HF
	RAuBEawSzwQrO59yTeUgOUp4qOF0TID63HxQz1dE6T/gRIkQHVPOE29KT8jCxzkj
	fsS04WxUrFckpWDKGH/wqyVzPENkB9+GlkPXiLzcafeWLv2vBr7Q7JXXawOEaB4P
	IymyusiTHoAXURAhMZit0AZdMgoseafUcm9AcefBRSqoTtcA8NhOUPwQ31wz2zbu
	LXETCcRGeBtXktXhBc4ifw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtymjnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 14:56:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EDCg8p037163;
	Tue, 14 Oct 2025 14:56:09 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdp923d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 14:56:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K7uAuqO8WCN+lyKoqmAtOfC3uUxFrsn9087fCIrAclvktONH09sbgfxHZkrkeOGkCIyVxEGtSiMFyMerSrom+lAUhDysHy/cHC3PT2smDtAl03PxOettAcqbhosQ3UPrRcRnQd1CekgerppO7l/5ebVnMRciHO2WH8SyqoQee9wwKNITqXrveohF/WIy94H7vReot80aXPuOwCnKiNQypBm2MjQYq3qlWiYPXkNtjzZD8sQ9pryvYEgO3e5Zo9/VTtMjGu/olHcVUkzYYj1iqmUnbnt8/88r0OjuP08YOtmzoayhZN9D4JLxNqHqXpcD70nbAWU5LCJ1D4OLE3DBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzhtAJ7mIWavxtyHxZSygWI3xevZhs1uDf/KtvT30D0=;
 b=F1K5Wa0tZKCqAfh7jJzmnzJjTu5sYK+YBZg8hwfN9bDSy0atnvz4bpNPUjvtcQWcdYH6w3zOfUQp7tJpn0qElI+0QuCx39JWCUIYl6nUCCqaNzhW3LObcsmTuRlOT+ZSNwh8an06M+cJ1Mf/dTSEUzqc70nul3yIvJ6NTImjLUTvsRpWrJwyMn5nqKQOO0cDLiCeDtg4Wvxj/PqvDh8eJHSyLONbr6gdV9AB1rdscOySsaIFbQYadOkCB6P/PTIPbsC+Gd5vqluOGE9a6J1oU1FlE6PMlg5iywGL9iiN3A1tJsJVYBo5IYU4q/PS/SxOM7iGvI7VUMrg+HUSdpaUKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzhtAJ7mIWavxtyHxZSygWI3xevZhs1uDf/KtvT30D0=;
 b=JQIqJZibrAJ4QkPPfuPFRwqhF1LdW5Dl8V46YTL8hkvcEuBx7aYobadPHhFhsZ14bXm8raWJE76GzAWyPiAcxDewC1v5/kSTU97JFeTa1lT5nMeI53cH92AKN0gSZLv11mUCCgHazHpyMswug3wqLHT+b2JgsmKkrxE0pjSOnv4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH3PPF558EA2A2C.namprd10.prod.outlook.com (2603:10b6:518:1::7a2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 14 Oct
 2025 14:56:00 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 14:55:59 +0000
Message-ID: <6a3dfd7d-00de-4215-9bdb-f6ffab899730@oracle.com>
Date: Tue, 14 Oct 2025 15:55:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Jiri Olsa <olsajiri@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thierry Treyer
 <ttreyer@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        David Faust
 <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
 <aO45ZjLlUM0O5NAe@krava>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aO45ZjLlUM0O5NAe@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH3PPF558EA2A2C:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f8c957-9e25-44e7-2bf7-08de0b31c982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?am5MQzhxWE9DWWNFZ002L3FPakRKdStjWUFEQlpUVnNNeUcrdHNVYmNhV3p3?=
 =?utf-8?B?amZKQlliWmc3aEM5M0R3aUl3ZlIxcElzMThyRncxaldFcDdnMmNFTzJEaTdX?=
 =?utf-8?B?QlNTSmJodFYzRnVoRFV1akFTV2REY2UyY1Q1NE9NNmd6cUlxWk9saDJRUWxa?=
 =?utf-8?B?VTNLcTIvUWJGU0lRYWVsK1VtdkpEMkVobmhKU2pyUXRlQ09xcGZIZlZuM0tU?=
 =?utf-8?B?OFlweVg2TjFZUkp4ektHSzByWFhzUkwyWkhoY2NKUUxHU3RBMitaUVo2di92?=
 =?utf-8?B?aUY0azVmUTY2ZWhuY1lpY1ZWOFZzMUVlU3lzMEtBNXdnbjAzcU9FRFZEditn?=
 =?utf-8?B?WTJuRWtwUXVXRjJ0OXRyenhmWjc5Ymdic2NCcEVrRzNMNmtISjFsKzExSzFI?=
 =?utf-8?B?SGI0dko2dTNHOVhUdFlhNHhtam1IWDVqZzFld0R3N1l0VVNvYVg4N2wwSjYr?=
 =?utf-8?B?ZFBVYXZwNnUzbkJJNWwxZVhybnIyenFjUjNJWS9wTzZMOEFiK3BQV3dCMmNp?=
 =?utf-8?B?c0lKS2w5T3FRdEN5ampHSGc2UkY1clVhRldVbGtHa3UrT0I5cEY0a3YzWFZZ?=
 =?utf-8?B?a1pxZFhEVkl2ZjZQV0VldTRYbWlYNFR2V0FDUVF2aEN2cENZYklaSDJqMTA2?=
 =?utf-8?B?VTJnVkR4WWZLeTY4YjkrTzArdER1bDZiNExqRDhhaGZqSlVIK1VaVll6bXA2?=
 =?utf-8?B?Q24zVDN2Yjhsa1I0c0paVzNGZG1KMjZUSkxZT3gydFZ2RW1iUVBKR3NVY1U5?=
 =?utf-8?B?S0M5SXBCMnFQR2NMNWtTaDdjdUVyVS9xT1Q2QlM1VXJnNnczMG02a0cyK3Y1?=
 =?utf-8?B?N1ZSSFBJRGMrazN4RElKaS9sNE44QkFITlBLdDg0L2g3cWdmWEwxVDdqNlht?=
 =?utf-8?B?MmV2c0tQNlhwclNpdmFCbUlVRTNDRzVad0JaNTRvWlFscXcxZ09DTjFLRHR0?=
 =?utf-8?B?TFp2aytMOVU3ODFZTytUSHdHaWhzTkZ2UTNUeEFPdjkxZExNMzlGbVY2Mkxt?=
 =?utf-8?B?aUZyMnY2WVFad3BSdXZ5MWdDNll4SVoxTGFPd1lGSWdLeFNVdnB1Mlh1dlJ4?=
 =?utf-8?B?OFBoc3NPSGJ1YlVVTUFLbVBCaEQxTVFzMTd6TkxPN2daS0RnekVHSllQM3ow?=
 =?utf-8?B?akVOcisxcmdxbXJwaUVGN3hmSFVzRnd0Vy9aUExBei84SiswZzQ2b0VNY2xj?=
 =?utf-8?B?eFpwSFpTdTc1NjZzdHcvOENlNEhNbTczT3k0YzZjNTBHVU41Z3dmWlRCVCtD?=
 =?utf-8?B?THVQRjF4aFg2Zzh3Mm1GRnZKcmhWUFM0NTRLMmkrQnprWWRteURPNHQ0STlj?=
 =?utf-8?B?a1hMTmxsVU5DZ0JuQmlEWmk3Y0t4WU5LcFlwSSswZHl4R2Z5WmlUSTVHT3Vo?=
 =?utf-8?B?OWVXdkg0bUlmWjRxc3NEcWcwdWUrYU1NVTV0REo1Z0w5OUhFVURKNXcyTHg4?=
 =?utf-8?B?dlpxd0dKNHRZdHRQMXpaUUZXOUthZEdRY2pRM01RMklsWGpGZkhzYlFNZzdT?=
 =?utf-8?B?b1RyNGJ5UzFFOS90SFR1a1BwcHkwZFlUUUdkV0phQVRxa25qRHllQTlkay9J?=
 =?utf-8?B?dXNRMjg2QWNKQ2FEdTZnRERoWHpTMHJBNUR5ZHVOaUxRd0pMR0FaUExyZUw5?=
 =?utf-8?B?ZWNZdEJCclY4WE5reFhvZ2V1Uy9hTnpyVnd2U0tHbkhWSlptQjR5bkRCUGdi?=
 =?utf-8?B?ZnBJRmNRZUN2dzlzQ1NQMFk1bHZsQWgzbzNIMU9QZUdLSTQ2dVFxQ1VVeGJM?=
 =?utf-8?B?MUtpcXhDdlBlMWZDU2hJUTJrSGkyd3E4ODc4L1R0NlZRYU1KcEVIVkxYMjZ1?=
 =?utf-8?B?MCtoOWVXSGU4STJFd3JzR2Z6UHZOZGtSRE43eHNSVWJSY1BMRlhZMlF1Y0cz?=
 =?utf-8?B?ckZpYUs0UzB0aS9WdXFibm1YaXVydHByZUN6RHI3MGRGSGZtakxFODhxWWlP?=
 =?utf-8?Q?+RNLrGwgdRvyMRlcDZ0STIC0K1kfG4SK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjlBelpXZDBPaDdkSm1jSGhEWHgzRUxET2tRNXBzWVo3QlVBem93U2ZDM051?=
 =?utf-8?B?OWJoT3lWWitSdnpXekxsdThwYk5sZTJCbFpUSE5UMFoyd0paUmFqZmJxTVUx?=
 =?utf-8?B?UkFZdFBGckJhWEcwN0h6d0NNVXRkb1BRR3drTkN6VVV5bi9YTVJ5Z2N3TEtB?=
 =?utf-8?B?TG5vRlRuZDJlSjROZHBkckU0eHFsdXRrcXNacGFXVWgvUld3OHYvdTJpQUEv?=
 =?utf-8?B?VWdlOFF0SUl5QTRVOEdDQzZBVTJnZ1J3VURjQlBZdldMYmxUQUE3NGorbXB5?=
 =?utf-8?B?ams5SmdIdU82SFhhVmhKSU9pRTM5L2VDMCtGbUpVRW1qVy9kUm9YRG1RSjIw?=
 =?utf-8?B?bmFrR0gvWkRXQXgvSDJqVUwyb3hlVGhqbTVwaUdYTHNidXJIVnM4T3FCcGY5?=
 =?utf-8?B?dzVGelBSTXlkNzdpeExaRzcxdWR4Y1FQd3VlMW9wVDdtZDhZeUZiSE1vaFRM?=
 =?utf-8?B?am5KQ2pYaExBSkg5WEFhSm9nT0NVbzI1aW96VFNnWEpZWWtGYWdldklEaTBy?=
 =?utf-8?B?QnZDbmYydWVsYlBHOTdMczNXMFArUmRtcEFEc1FDSUpYVTJMUDFXQW9BU3VM?=
 =?utf-8?B?ZnBVeTJEOU1UZFlzbmJvQ1laN0FXeHZVaEtKUHA3L2RrcjZrYnU1NUxLVTFy?=
 =?utf-8?B?M2srSHNmV0NVTXNQWFBhN1V3VXNMVHR6b1BTejQ4cTlTUStvRTZQMzVKaTRK?=
 =?utf-8?B?VTg1Y3VuN0VZVXdMMFY2bUx0ak14aS9MOXB4Q2M3QVNvanFVbStKOXB0TW1T?=
 =?utf-8?B?RUpnVnBvLytyL3hiYXFSRWVUZlR3MGllcUdzMjJteTJBT2Ixcm9oOFlvRW9U?=
 =?utf-8?B?RWpCcU1mREtOVWdEMGR4RmNMTS8renFkSXlKZENKbXNPdTB6THdrNzdPaXJ1?=
 =?utf-8?B?OGZ3d0NoTGFtUnprTjdZUkViTUd4K21jZ2IwQ1RjT1czbkVCS2VwSldXTlpB?=
 =?utf-8?B?WVM3UStxTnpjTWNuekJ0b04wL3A4REc2UHJoTWxEUjAyd2RGZFdZQmlXT2E3?=
 =?utf-8?B?eGpqbjI5MEhncUJKVEc5VjR4b201TGgwd0dsdkRiYTFSNkpoLzhkbmxKNW9j?=
 =?utf-8?B?R3Z6UzZYTzhpUWcvMm8zL1ZPbEUvdEZEWlhBNitoc0wzRnBPS3JRek1TSk5Q?=
 =?utf-8?B?Njk5MDRMdWtGUjhCbFR1b2JVS1pSNE0xWkMwZmlzU1FTa2t1WEtZS0xSWGZC?=
 =?utf-8?B?M2s4eGlwUVB1WldqMk9LNElTWUxURlpSUExOZWYzNFZaZWY3RU1nU2NzUEsz?=
 =?utf-8?B?OGdQemJpZmhqNEZUcmlZRUM4eUZBN1VERDh2dzdVYWpEbUQraGh3N2VsNnFN?=
 =?utf-8?B?UjJMU2I4RGd2TEpyanVkWWU0TGZHYWJhU0pOd1ZYU1lWTmd2cGp6d1JmcDZr?=
 =?utf-8?B?WlJkaWtOVjZrM2paQXk4VEZRY2RjRm8xVmN0bXJ0UmlVOUUwY2liVkJiK25t?=
 =?utf-8?B?WEZFVCsydm1qVWUxbW9TSzUyTU41am1EcVRTVkJBRFpPaEN1U2M5ZGxzTEZ2?=
 =?utf-8?B?cGh1bWNFNXJ3bFFqVFNrZWZqbVkzTUZjcUpSNGpnSEZHL09laDYyNGV0SkVu?=
 =?utf-8?B?Z0lUNGh3OUhFZ282ZUJGMEFMMjRMbHc1cjM3Nmx2N3lnbXNFaWdoNWpycTlF?=
 =?utf-8?B?RTc2S09BbXJxdGlZSW5jbWZOU0hwdXJ6WmNndE1qUlo1RWxKNjlUU2c0QVF5?=
 =?utf-8?B?ekdJL012cDFLZ2svZ3FhM0RaUU1VZXl4UXoxQWFoMjl1MjRMQUwwUnBzRWIv?=
 =?utf-8?B?Q1Y4R3VFdGdIQjE0ZXY4NmpWaUtnd0krY2JkVXkza29ydDl5ZU9wWnJ5STlH?=
 =?utf-8?B?Y1ZGRWZVNFFuMDFpM1hkZHIxS3UrU1pIaWhNOGZ5NTJ0Z2FDajVTUDhNTmZo?=
 =?utf-8?B?RUVmVDZRc09pb3FkVVpOSHQ0dUVVMU94QlpXUkgxZ2FzUWtmSmJramliR2dz?=
 =?utf-8?B?QmptREh1TDhjblY5bkZ6L3dtTVMrSmlneHRveHZvZ2tadWdQaEdTNTJtOW1z?=
 =?utf-8?B?TUIxeWwrL1hQQlR1WXBtL3JwMTYwUm4zZnovbU44Zk9nYWx4TnZKVklSdHJR?=
 =?utf-8?B?OEdvU0FTNjF4cFpZKzRtbjdrNzU4YTljZlN1NWNPbG5QcElWbmZSK2RmN3Fn?=
 =?utf-8?B?eCs3clBGQUZET0xQd0NEQUIxajFIVC8va3phd21Da01BYWswUjd0blp3cGF2?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QNbRbgLaoQ4JqYruqyKbUsBaOw6tWglk3D7dXg/10Cb7Hz9RYg7N7EBI7Qn5MOuywjuacWFEGlDXRv3BIyO1X5woOU5CihkWLHEmAT41qK9piRULFoRkEIAwFWA8uE0qnPBypQyYgq2wyKBmDLIvZFq3XrJ1gm8zw4yez1HsjPfIewIKQ4ZqigLgVxWEHs4bXWyBSA93lH2c7rkGxnEX6pj/lJdAqaKMs7x/ASrgNaQ/LQ5e/4exmVL7cLNuU8OGHhai3xejbiNOy9Md08wwDQommZs6t9TyRPxGNM/oMwzZuq7nxO6jz/UUZvC/yJJmIcK770kcZEt4IKuMiY4l9+ZfDrxe1FMLHimqwYEO7oTap2psgFQWZy9ZR3t11Zk49646VLw5r+z2l8xN/vjLYZ2DogJklsWjvQ6kF+iuQfkRgCjjbLC1NzkEnymaZ5ovzCaVHXdvPbX6UyqAmMsVhaiYfVWs6VYI+K1nbnm6V7sHVb41Fomn7AtGk2vtEb3aX2o3HvSsWKMz6qL6MvbjU35cMXEmq58GAcQIwtjYFPo9FAaIxdLZ64MFxe64yHrjCXVl3kkKMJwr8AxO2IBAf126AeBjTw1OcDmit3Jafws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f8c957-9e25-44e7-2bf7-08de0b31c982
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 14:55:59.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bfj3lNEoSbr1VtlOpJT0+uk6p0w0HRwvZspHSyND56kXXONLWLXyeDsBGeANDuvA6JFxOn3atHraY891oCNrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF558EA2A2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140113
X-Proofpoint-GUID: TEOt9EX8z9gZ1UpI7sDh54XdqKRcQhgh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX9gtLA8gKGm7u
 tiYe5e8t49sledWapN7IfhyzeRdgjmfBcvDIaOyOp9vK8Sd3JJbjVnj5zDx90POOOAHDoCvY+1b
 JMIPaG1cSQwb+KKtki77V/Rp6jJuA6braEMWt17UFEO089uatvD4C78UWwohTEey4/CTDLuHEx0
 EdXlZQxnVvMyWt2GyBYSsG3BX2XwPO1Uml69SFv4CvYJXcEySQ4n54Dw2RmBrefnbzuiupX54wd
 6m6BriTzVxGxIboF7Jq8KZ6YQ/wrlGsKilRhbCbipUYLePBB3yMklvjtGDpljVATSOuLu+RadN2
 9F41CWYNT6UIXQOuJ9qVkLfU9XVxOzRga1SZwQ4O3HYXe6E2CAcfS5IRuA3C+sIimmZxnw/I2ey
 4uFjgJQpoKA42vS0yNPCdba2hzBu2w==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68ee648a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=Rw79ccuu-uNeDIphBfMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: TEOt9EX8z9gZ1UpI7sDh54XdqKRcQhgh

On 14/10/2025 12:52, Jiri Olsa wrote:
> On Mon, Oct 13, 2025 at 05:12:45PM -0700, Alexei Starovoitov wrote:
>> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>>
>>> I was trying to avoid being specific about inlines since the same
>>> approach works for function sites with optimized-out parameters and they
>>> could be easily added to the representation (and probably should be in a
>>> future version of this series). Another "extra" source of info
>>> potentially is the (non per-cpu) global variables that Stephen sent
>>> patches for a while back and the feeling was it was too big to add to
>>> vmlinux BTF proper.
>>>
>>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
>>
>> aux is too abstract and doesn't convey any meaning.
>> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
>>
>> Thinking more about reuse of struct btf_type for these...
>> After sleeping on it it feels a bit awkward today, since if they're
>> types they suppose to be in one table with other types,
>> searchable and so on, but we actually don't want them there.
>> btf_find_*() isn't fast and people are trying to optimize it.
>> Also if we teach the kernel to use these loc-s they probably
>> should be in a separate table.
>>
>> global non per-cpu vars fit into current BTF's datasec concept,
>> so they can be another kernel module with a different name.
>>
>> I guess one can argue that LOCSEC is similar to DATASEC.
>> Both need their own search tables separate from the main type table.
>>
>>>
>>>> The partially inlined functions were the biggest footgun so far.
>>>> Missing fully inlined is painful, but it's not a footgun.
>>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
>>>> user space is not enough. It's great and, probably, can be supported,
>>>> but the kernel should use this "BTF.inline_info" as well to
>>>> preserve "backward compatibility" for functions that were
>>>> not-inlined in an older kernel and got partially inlined in a new kernel.
>>>>
>>>
>>> That would be great; we'd need to teach the kernel to handle multi-split
>>> BTF but I would hope that wouldn't be too tricky.
>>>
>>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
>>>> make a lot of sense, but since libbpf has to attach a bunch
>>>> of regular kprobes it seems to me the kernel support is more appropriate
>>>> for the whole thing.
>>>
>>> I'm happy with either a userspace or kernel-based approach; the main aim
>>> is to provide this functionality in as straightforward a form as
>>> possible to tracers/libbpf. I have to confess I didn't follow the whole
>>> kprobe multi progress, but at one stage that was more kprobe-based
>>> right? Would there be any value in exploring a flavour of kprobe-multi
>>> that didn't use fprobe and might work for this sort of use case? As you
>>> say if we had that keeping a user-space based approach might be more
>>> attractive as an option.
>>
>> Agree.
>>
>> Jiri,
>> how hard would it be to make multi-kprobe work on arbitrary IPs ?
> 
> multi-kprobe uses fprobe which uses ftrace/fgraph fast api to attach,
> but it can do that only on the entry of ftrace-able functions which
> have nop5 hooks at the entry
> 
> attaching anywhere else requires standard kprobe and the attach time
> (and execution time) will be bad
> 
> would be great if inlined functions kept the nop5/fentry hooks ;-)
> but that's probably not that simple
>

Yeah, if it was doable - and with metadata about inline sites it
certainly _seems_ possible - it does seem to work against the reason we
inline stuff (saving overheads). Steve mentioned this as a possibility
at GNU cauldron too if I remember, so worth discussing of course!

I was thinking about something simpler to be honest; a flavour of kprobe
multi that used kprobes under the hood in kernel to be suitable for
inline sites without any tweaking of the sites. So there is a kprobe
performance penalty if you're tracing, but none otherwise.

Thanks!

Alan

