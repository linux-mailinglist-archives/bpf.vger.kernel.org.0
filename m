Return-Path: <bpf+bounces-70881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85937BD89B2
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 11:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1999B4E134D
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 09:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE2C2EAB7A;
	Tue, 14 Oct 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="moqTl8mx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z79Dz6VY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C83B2F549C
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435938; cv=fail; b=lj4JZ1LMb9rXaUllTgfNZTvVsvpl+UcHBnUYNy1qBh9jyJD61D8T1yjCCV6fJHzByCoH3eEGqg/T697rlf/sWIksYxqBKrFSzjj+Q1J5i2dpkjr+eQIOlmATUstRzxFG4CA6F4scWZHby2sVRsjYcwYu0OJR9efOBM6m73TQxmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435938; c=relaxed/simple;
	bh=8V/u99txvLXnFMmNC/HFmN0YzF5EIOmbUX/Y+xEvrnk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dzEP0s6Zw5WoxVtulqNO/Z0+jTRo38tzvlI2W7bIZTtj/AJbvUozlY4g6fcK66bbMG1e467bqPkunbv0HhFw5FbIZh3Z4tEG46JMrkCjxjtm4fu6v+I0eYKwi58vY1TaszJSDNPN+fuuGU+xJroL86RRRuk2y7hNAH32e+GpRCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=moqTl8mx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z79Dz6VY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E9uBS5024282;
	Tue, 14 Oct 2025 09:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=7SAPwqS59BCJfIkk/emYbZ2axrinw48rRB/6yIZACOI=; b=
	moqTl8mxOM2tWhxHgsMN8ptBn3Zpq7NjkR1/B7Rf6yofyEwBhy56jMzTqk2oXF7Q
	jdaY5OfkKdCdpw5BmnfdPQ6Ec5VTcmO6tBUR2vFqhaLQkivQII5Bv5U6ytKAR2if
	iINqZM327tjyu1jCAyUe4xB6IpLIfnfVN1Nagzi1/fFG+SDFmMQL5Z1Ncha2F8yF
	2u/V3V2q/OZQyJo3bM9dh63s2PMzeZ8oFMMxpH0Rimztv+6NfbqZhP93a7BG+3Pk
	3z5J8KAphtLKcoEktmItd260jKGy/Uo8gMrgYSpFjoy/5fwBsXImsb/QPKNZ7Qrl
	39K6lceWK3y8eULbo+whtA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeusux4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 09:58:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59E8VLDe010020;
	Tue, 14 Oct 2025 09:58:25 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpeqje3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 09:58:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3sAN2UMtiXaOEesEmiLdsW4hfC+AvlMUdMIHabRThAjs7s9fjck1/DHPH40nfPIAQFarSObUbm0Xk74H7Y+m5GjT5adRZbM/4/X6wERsb5PqEv4T+iNZ4dJyFsRqEy2RC9NQhVECWg0VqbhZLdhljaTHndzhp/F28LcCf0mkuuAcRweJvJdIcijX7e8KZzu57wIzc0Vv7IPG2ENKXRCFt6RkYDgx/y25rtKO048p6Of+HC9Mb3hC9xvWneyePabpm67dAbPhXOB/09lu+vkAMV/emlhdOOX//ffD1aGlMRaZb6We36QlnpvIbS9CSeadVjgFItVUASqs2U6Zmdnig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7SAPwqS59BCJfIkk/emYbZ2axrinw48rRB/6yIZACOI=;
 b=wQug22yVXqzjQqUUmHA7ZZlGdATlmC7pdb70cS0Z++9O1chXbU3ehne3l+S7v5qyGuJtwi7uJMuGyOYGOl1POO1DRsdmMBSJiisa/SmQW6s8QvzlnWjFmy6OtjS0OyCd69ojrtnlo2Y4kf/dLJyQIbHEb6/kyD/12J/LP3NKOkAf2eALUD0Mo8ZFd6xtg077zM5cQ8q6DRhdzWe9qcKHHP2uFEoXGVziPfwD0VHKhjQp/AbuTx1n/irrDNGYGxFhBSJrbM1mjh7S96qaXLLIwxvIFDc/dvc/IAudie0B7bn3v5+EIDk1MS+/IMNbKAn8i/o0QlYM4ujs3ElFPGq/rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7SAPwqS59BCJfIkk/emYbZ2axrinw48rRB/6yIZACOI=;
 b=z79Dz6VYAlUgx9S/3Ha1MZGQmB1rF34+shngY23rLThd0XMZicl4VmKP5UA3fLcNvDOEDJ3N2V/oje9z6dsSf/QE5ofcKuHyOoIsNo9WrmDh4MxrdY/JpS6L2E5ltvlst67Fy/rTyFz4bhBBF46kcpugj7tqGDqq32KpS+RrkFI=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 14 Oct
 2025 09:58:20 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 09:58:20 +0000
Message-ID: <4201e67c-5a56-44f9-ad62-897326d84a41@oracle.com>
Date: Tue, 14 Oct 2025 10:58:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
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
        bpf <bpf@vger.kernel.org>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
 <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
 <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQ+yYeX7G--X4eCSW_cyK_DH3xnS-s2tyQLeBYf=NnzUEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0392.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::19) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: 138173f4-a834-4510-2a1f-08de0b083494
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUhMcXV6OW1mWDMvVWNRS2xJVlNmeVZ0cy8zYXNSejJVNXlhY2RVQ05IR2hU?=
 =?utf-8?B?M01xa0dHRWxsUUorcG9zVjcwQjlzc3g4TG9GWWNicDJKL3FSTURjUnJVanly?=
 =?utf-8?B?RGsyNXR2TEh3SEY1WlpmWUI2SmphbFNCTmR3Q2lYU0pUcmFyai83bUhObFZP?=
 =?utf-8?B?cnl3YWQ4NGlrQjhLTGYrZkVjYzBXVmh1Rm1kL01rUlJ5R1cwSmg1UFc4MTJh?=
 =?utf-8?B?YVF2WTFlZDJFU2VQcmh5SnZlT2F0cWZFeVBRNkZIQ0VQWlE4MjJzL0I1eGIz?=
 =?utf-8?B?M0d1dlhacDNiM3p3TDBMQXJxSEJBdXl4c05ONGtWQ05FSkw0dDVDb3BQS2Rn?=
 =?utf-8?B?R0JxQXYxYVpLQVBuUVpIWEdNMFJIcWdqR0I3RzFsNWo1QnJCbnBKSWFTc3pq?=
 =?utf-8?B?ZU9SUSszeTF4OTZQMUdlOWcrcjVvSHNTT09hTjFLQlZueW1VbjQwS05BUG1N?=
 =?utf-8?B?SXlnYUJuM0Y3bE9IaXBLZmx1bWppaDBwUllQOE5sWmt0dlhPTnh1c295WUtY?=
 =?utf-8?B?YlkrbXEyNFRUNk15M1BDRUFvNXRUREdkQVlHZ3ZMV1l6T3NZNjZXMEdMaGVL?=
 =?utf-8?B?bFhVdTJ0NTdiVVBEVDduYllQbG8wTXdCek1UWnQ3MjVKQ2VjRFBwSFdRZEZy?=
 =?utf-8?B?ckRycngzbldsRlJZRWROSW96dG9yTk9UVmxVQm55MmJVQVdTdDBGTjRKNnFl?=
 =?utf-8?B?aWp6cXY0b0V1WjNnV2tieDFrRVpOY0hyRmJKN3d4Wm9rN0dOUGlRYXNhUkpG?=
 =?utf-8?B?YjhSaS9aQURiOEZoazcrakN3TDFTSjdET0l3WXpNU1BHbVJ5VVd2c3BESm42?=
 =?utf-8?B?dEszTXBtL2pzd09OeHZJWTBIYVYxdG5pRkJ3R3J4ZWV3bmtncmt0cUVnMGdv?=
 =?utf-8?B?VkxVYk1DTG5ldTU1L0VndWtQNm5Wa2dsZ3N5cVRxckEyWGxmSmhrUVJNU3l0?=
 =?utf-8?B?RW5PQUxNZFduODVaV3FNdGxVUWdCN0w2Z2t6ckMzTkljOWIyc0dzOTQ2cmJn?=
 =?utf-8?B?SDRiam9ENER6WDVvK0ZsbFcrVXpZeHlWOFpUYjd4T3BrQlZCWjd3M1FUM3h6?=
 =?utf-8?B?TXg0ODRvanFCY2planhicHF5VWJFRTN4eklKRzJkald2UDV3c1M4UXhhaElt?=
 =?utf-8?B?QjZPQmd5WmhkSnNuS2JIYkxUcHRiTGRFeVFISkhKNG9vem5PQTBCSVZqZ3Vt?=
 =?utf-8?B?SGFjTXErbGNRaDNkMUM3eG1Ucjl5Nk1rTFlLcWdJejZMekRxcTZkQkgrMHAy?=
 =?utf-8?B?QTdHTzU2WmF3VDFDclhzVk9NditwUEtpeEYwUUphRlFKMDVzdHVPOXc4QXd4?=
 =?utf-8?B?alYyR3gxWE9oZDNVaVY3bm56MFBFZG5NbzRCanZzQU9pSHdLaFdFdUE0Tm1z?=
 =?utf-8?B?eXBrWHpaTlkrSmZzanBuZEhhd2lJb24xQWlZVnhqSFVwL3dTT0FGUEJkcE01?=
 =?utf-8?B?aG0zbFVVWUlWeFUwSjRxVDQwTndBaEZueDA4QVl4V3Zia0grYmN5eGFQaU4y?=
 =?utf-8?B?UVJzNVA4Vktsd1lNZ0ViTzdkaWFnRVFNZGVLaHlOT3Z3SWYyTVg5RktVVGh5?=
 =?utf-8?B?WFVEUmFhaThQbkRQT3hCRGJIN0JtZS9tbEUyQ2JDS1RiUFV6OWVuSVE0OFNj?=
 =?utf-8?B?b1U5elptRFQ0UlVmdDdQNzdnSkt2aFdlUXYyd05BYnBGMmI4Z2UvL0Jpcm13?=
 =?utf-8?B?UEQxR2tuSHVnOXdzSmMrZ3Z0ekxSNTd1RlJ3ZnhFRnk4RXB3SGEyaDhyS3hw?=
 =?utf-8?B?Ump4SFlJelJ0WVJJWC9iVENBNzVEbkZTQTk5bTJhUmk5L2Y4V1dFczRSckN0?=
 =?utf-8?B?MU5VSTU1Rzk2NDRqa0dhZk1lcjErc21aWi8vNi84NUJIMTAybGpWMmliYmV2?=
 =?utf-8?B?YmR4cGVLSkl1RFZ5Ukg3Q3Q1elVjbWFVeXVTSmxVOFFndFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UktNTWJXeDI4RGtweHc1U3l1ODJsL051R2xrU2EzOG5FaUY3b3JjQXpxb3hV?=
 =?utf-8?B?eHhOSVRDclpkRm83ZVM5MVpKZitOSllKNlYzZk0zQUxmMk1BSXZaYzZpWlpq?=
 =?utf-8?B?bjNDY2V3TjYvcC82Z1FWVEsydDNoU081bFJXWWYySExVQW1PbWdwb3VLdE5O?=
 =?utf-8?B?ZkZDQjFhRzhIamcrVXM5cmI0Z1Jkb3NUd2dSaS9KUTh3Q2tmcTRSYkxTbXIv?=
 =?utf-8?B?YjNwYzZLM3lrLzRBZ051Nm9OU1E2TXlQRVJSVUZ5S2ZtaGpBRktzVGxyb1E3?=
 =?utf-8?B?ajJnczlneFpud2g1TWlYc1hIVjlGVDhZM0F3d21XQ2pxWG13eTJSODBaWmh2?=
 =?utf-8?B?QzVwNEp6N2QzbWptdEg4aDlUMWhFb0g1U3JNRVoyUzFGRFFqWGtHaHAvZHZL?=
 =?utf-8?B?Qm1YYXlIZHlxdFpsbWRRdXdRWmRxdjNaaDZadUFWd0hOSG9OVnpvMC9nV0Fx?=
 =?utf-8?B?NG00UUpUNi9JUnZybGpmQ1YxdmFvMy9lZFFQQ0hGWE8vNTNuVFNtNlZrTlRG?=
 =?utf-8?B?UW40STA4MUM2WmpsYUh4ODBBV3NCVnRCQUI3ZmNZbW0rOVVuQmxzUTBYUUdn?=
 =?utf-8?B?TytSZUltWmN3c0ZrSStaMTRSdytpUDVFTm5WOTRPS1I5Ui92WU1PMHZyMDNS?=
 =?utf-8?B?UTM0OGM3VTN5NEpzNWcwZTZBV0lDdEVraVZGS2RleTRlOTU1Zjk4djBBYUhO?=
 =?utf-8?B?Sm9wNi9ZeGh3Ry8wMGNCditUdEoyR0hCdnhrbkVUb05OdU1NQVdUTG5LbWtl?=
 =?utf-8?B?UEFaNUNabXpwTVpGRzFhZ1ovWis2VUt4TjV5ZVcrY3VEd2lLc1RoeWZ4RmFK?=
 =?utf-8?B?VmZlTDRCclRzOGcvRFAyK1VFanlxeGh1YmpZeCtCU2MzaU92ditoY2NacXll?=
 =?utf-8?B?bEp5Y2NtSjRiZ0Zxb1VxNE81SUQrNnZvc3BRMjAzc2VmUEpmRktIRW9vdHdm?=
 =?utf-8?B?aVNoYktwVTM4RDlPUWUxTXhIbGxjNjY1UTNkQllqaVZGVVp0dkhCaUgzUC9y?=
 =?utf-8?B?Z2dMVVhBVEhZQ0tBdW80dVdhRHdiZGNxbXg4Q3JHOTFraUlkdUFpYThKT25B?=
 =?utf-8?B?VmNraFgwMWdMb3dyQ3RYOXpTMU43ZkEydUVvZS91TFBnVE01bHkxaVM4cXRU?=
 =?utf-8?B?cGtuLzB5emo3K0xxU3FmOGNudWR0cEozUlAzVDlNbHBLNElrZkJMOHQ2eFc1?=
 =?utf-8?B?L3FzdTU4R0Noa1BPbFlPTHZjcW1vaXRmSTN5YXFGM2lsTW1uMFBiTkxiMytC?=
 =?utf-8?B?VStDN3pFdy96WmIxWFJtVHI4MFZWaXlzVUpLMzFIbUFzNWxEOUF0eThXL1Fm?=
 =?utf-8?B?eHZqa2NXdmlFY1hISWJ1WXVVSGc3UjlQSUpjQUVmNUdSb0w5M25qUHRLQWtG?=
 =?utf-8?B?QjRESjcxSEhMNXlsVTF2SGN5alNvWkEza2pZb056MHJCcmNPblJIOHFsTmph?=
 =?utf-8?B?RDc5Q0xBQnR5NWR5bHU4SnFIRDR6b1FHTTlaajY0RFE0L3UvSmF3dDFoSFMw?=
 =?utf-8?B?dTY1MjdjOUdmMXEzN2VHamZMSUppazVyOWJEVGFVcUozYUJVTnNyMTd6WGZW?=
 =?utf-8?B?alhiNVBCQVNHUWFiZkZuUGZPMWpTcW14d0ZiMHNWZm1Kem9sSk5kbVZPaUZp?=
 =?utf-8?B?eG5HMDU2Nk9FN3BieTQ0dUhyZnN3NDk3bnRYWTJzRSt1SFhIWW5aSTQ0S05T?=
 =?utf-8?B?dzZEdXVGb01MTFpIajAzbzRMT29zZ1ZwL0VNVWdUSm1RaGVoYVBUZ0ZGVUVH?=
 =?utf-8?B?Qlp6TmEyYzdIVXZlY0pIalRZSTU4RFFrZk5iT25HNkhBcnQyTGNPYUZmZW5i?=
 =?utf-8?B?bHJtUzU2Nkt5anpMOWFVOGhabFR6WlRwSjJ5ekl0UTYyakp5K2ZCZjZNeWhy?=
 =?utf-8?B?eUVlbkFKby82WVFvL2orSG1aYXEyVnZ3YVZ2aVhCNG55Qnd2K0xXcmNDOHZo?=
 =?utf-8?B?WTdhaGFCWUk5K1g3alZITEZ3aTNRNHVKdGQrUVRtQVIyaGhOTk5lcUtycy9s?=
 =?utf-8?B?M1lMdW5qRUZqY255Q2FUdnhRR2lrR2Y1UW9KWGxjbGxrUmN3OFpYV09DaTc1?=
 =?utf-8?B?Z1gwTTRnZVQ3bkFuQ0VnNWMvTCtOZnB1cEdYUmdpMXhPb2tETU9oZ3l3blNQ?=
 =?utf-8?B?QWpFWTVYWnJpZXBaUEx0c05mZENlb2JSY1NCVDIxYnAwV2tSc2Q4V05jdGRy?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XsOG5B7YuPk9gu3RvOQHyrMUsdWoH/hcGA8gZKgUJ7hY2FoiUsFypEXSb9TOcX/RX+Y7PCqh9ak8vlYjKPQlfCA6ifS072scu78it1AnD7zs0k81CZkaxakbQTkbBUjko/3jQPuERxA3J5ned5274ZdmzlDlFFwM2o/tuaQG5zScmRTRbvYDk+swaKTM16GcHd/trRZqZTwHjCssLRODRq/bU4omNTR5VLuzIZGpjWYA+QxHLdYZMIbNM5NUyMDY8456vQ22EHxncOZqDsR+xBicZ8t/hWDxub+uxvo9nxnAGUpGIEdA2GsfFTMC9zUWKCi4fXJVgVzKrqW9fHVLLyOirFyJxdFsz0SgMZw2VAH6+eBBEc/0zW3XiBXr8qkAoIbaKDz+QDwXIAT7zykuGRjm7e+I3UwB1zBiBhhRQL7FgoJ3pf4c846uw3qjbqJx/hjCIAegvZtxmuax1gBIj/4bBUOIMmTxWbO3r/r4aCQhF59CerNJpvbzcJmKGAN8gNQuQTny4m/hiCNyar8CqoxDsOK0PISccShNG8742pN3ZSukAi2kO72FTbf1rikTYGkki/lCKy3x5Hx1zEWnPxrgpfxlnEg2wZb6LlE9cP8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138173f4-a834-4510-2a1f-08de0b083494
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 09:58:20.5480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RX/Hl6UhTBMqx6NqV2Z78KYEtJwzRjKsGAY8uZMNip4BVPVJzZsWnsm7dmRcJkPPMAFdvL+IdQf/KkYHzAsFvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140078
X-Proofpoint-ORIG-GUID: XbJyEYEYRrWx_B0Fmxko9AhyykKuqs2Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXz4hJgOopBW9C
 zkClDjzc0qHup07A5gFQOJ7YtvgQN/81SgW/Y3NP5eNZG5ltJ54U7VyvAa3k5JCVkdaihCvXazd
 MlNIX2FACRWDH5b+F469hB5PYbADVadDPBWlnoJA5bskym0Lkzuch2xxUuY2PwbxFgSmoguNL62
 joSoiGyZPUXQBcjY2hDn/gy8CYkCt6t3YN1FeQsaKM9Z+Oec5QbM0HGIFJHEc13F2x4Y8AranLC
 MfhMjUHZIFTysrgLj+zZl74Q8/v/Vxi6pjVtWpnc/BZJIjuNkmRkiv8TAwJ+g3Y9FMUuVRzpUQx
 vHafFKO4yp/tiD3rSihPTsE1tyg+0sPuR4Wb+yOL8z7t3MlWzUS8zpye/YrW0veluKeeEggkd6Q
 1gjcGqgnIvtCS0MoOCHGv/9FVd5AW9Uc0MFvFWMSeQOVfyztR1o=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68ee1ec2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=TOY_8snQAAAA:8 a=yPCof4ZbAAAA:8 a=J22pCsRn9h_oOQvx1MIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1-V9h6BHp-r8_tbamw7_:22 cc=ntf awl=host:12092
X-Proofpoint-GUID: XbJyEYEYRrWx_B0Fmxko9AhyykKuqs2Q

On 14/10/2025 01:12, Alexei Starovoitov wrote:
> On Mon, Oct 13, 2025 at 12:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>>
>> I was trying to avoid being specific about inlines since the same
>> approach works for function sites with optimized-out parameters and they
>> could be easily added to the representation (and probably should be in a
>> future version of this series). Another "extra" source of info
>> potentially is the (non per-cpu) global variables that Stephen sent
>> patches for a while back and the feeling was it was too big to add to
>> vmlinux BTF proper.
>>
>> But extra is a terrible name. .BTF.aux for auxiliary info perhaps?
> 
> aux is too abstract and doesn't convey any meaning.
> How about "BTF.func_info" ? It will cover inlined and optimized funcs.
> 

Sure, works for me.

> Thinking more about reuse of struct btf_type for these...
> After sleeping on it it feels a bit awkward today, since if they're
> types they suppose to be in one table with other types,
> searchable and so on, but we actually don't want them there.
> btf_find_*() isn't fast and people are trying to optimize it.
> Also if we teach the kernel to use these loc-s they probably
> should be in a separate table.
> 

The BTF with location info is a separate split BTF, so it won't regress
search times of vmlinux/module BTF. Searching by name isn't really a
need for the non-LOCSEC cases; None of the FUNC_PROTO, LOC_PROTO and
LOC_PARAM have names, so the searching that will be done to deal with
inlines will all be within the LOCSEC representations for the inlines,
and from there it'll just be id-based lookup.

Currently the LOCSECs are sorted internally by address, but we could
change that to be by name given that name-based lookup is the much more
likely search mode.

One limitation we hit is that the max BTF vlen number is not sufficient
to represent all the inlines in one LOCSEC; we max out at specifying a
vlen of 65535, and need over 400000 LOCSEC entries. So we add multiple
LOCSECs. That was just a workaround before, but for faster name-based
lookup we could perhaps make use of the multiple LOCSECs by grouping
them by sorted function names. So if the first LOCSEC was called
inline.a and the next LOCSEC inline.c or whatever we'd know locations
named a*, b* are in that first LOCSEC and then do a binary search within
it. We could limit the number of LOCSECs to some reasonable upper bound
like 1024 and this would mean we'd binary search between ~400 LOCSECs
first and then - once we'd found the right one - within it to optimize
lookup time.

> global non per-cpu vars fit into current BTF's datasec concept,
> so they can be another kernel module with a different name.
> 
> I guess one can argue that LOCSEC is similar to DATASEC.
> Both need their own search tables separate from the main type table.
> 

Right though we could use a hybrid approach of using the LOCSEC name +
multiple LOCSECs (which we need anyway) to speed things up.
>>
>>> The partially inlined functions were the biggest footgun so far.
>>> Missing fully inlined is painful, but it's not a footgun.
>>> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
>>> user space is not enough. It's great and, probably, can be supported,
>>> but the kernel should use this "BTF.inline_info" as well to
>>> preserve "backward compatibility" for functions that were
>>> not-inlined in an older kernel and got partially inlined in a new kernel.
>>>
>>
>> That would be great; we'd need to teach the kernel to handle multi-split
>> BTF but I would hope that wouldn't be too tricky.
>>
>>> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
>>> make a lot of sense, but since libbpf has to attach a bunch
>>> of regular kprobes it seems to me the kernel support is more appropriate
>>> for the whole thing.
>>
>> I'm happy with either a userspace or kernel-based approach; the main aim
>> is to provide this functionality in as straightforward a form as
>> possible to tracers/libbpf. I have to confess I didn't follow the whole
>> kprobe multi progress, but at one stage that was more kprobe-based
>> right? Would there be any value in exploring a flavour of kprobe-multi
>> that didn't use fprobe and might work for this sort of use case? As you
>> say if we had that keeping a user-space based approach might be more
>> attractive as an option.
> 
> Agree.
> 
> Jiri,
> how hard would it be to make multi-kprobe work on arbitrary IPs ?
> 
>>
>>> I mean when the kernel processes SEC("fentry/foo") into partially
>>> inlined function "foo" it should use fentry for "foo" and
>>> automatically add kprobe into inlined callsites and automatically
>>> generated code that collects arguments from appropriate registers
>>> and make "fentry/foo" behave like "foo" was not inlined at all.
>>> Arguably, we can use a new attach type.
>>> If we teach the kernel to do that then doing bpf_loc_arg() and a bunch
>>> of regular kprobes from libbpf is unnecessary.
>>> The kernel can do the same transparently and prepare the args
>>> depending on location.
>>> If some of the callsites are missing args it can fail the whole operation.
>>
>> There's a few options here but I think having attach modes which are
>> selectable - either best effort or all-or-none would both be needed I
>> think.
> 
> Exactly. For partially inlined we would need all-or-none,
> but I see a case where somebody would want to say:
> "pls attach to all places where foo() is called and since
> it's inlined the actual entry point may not be accurate and it's ok".
> 
> The latter would probably need a flag in tracing tools like bpftrace.
> I think all-or-none is a better default.
> 

Yep, agree.

>>> Of course, doing the whole thing from libbpf feels good,
>>> since we're burdening the kernel with extra complexity,
>>> but lack of kprobe-multi changes the way to think about this trade off.
>>>
>>> Whether we decide that the kernel should do it or stay with bpf_loc_arg()
>>> the first few patches and pahole support can/should be landed first.
>>>
>>
>> Sounds great! Having patches 1-10 would be useful as that would allow us
>> in turn to update pahole's libbpf submodule commit to generate location
>> data, which would then allow us to update kbuild and start using it for
>> attach. So we can focus on generating the inline info first, and then
>> think about how we want to present that info to consumers.
> 
> Yep. Please post pahole patches for review. I doubt folks
> will look into your git tree ;)
>

Will do; just chasing a bug found in CI, once that's fixed I'll send
them out.

>> Sure, thanks for the feedback! BTW the GNU cauldron videos are online
>> already so the presentation [1] about this is available now for folks
>> who missed it. I'd be happy to do a BPF office hours too of course if
>> that would be helpful in ironing out the details.
> 
> Can you share the slides too ?


Sure; thanks to Jose they are available here now:

https://conf.gnu-tools-cauldron.org/opo25/talk/SBMUWN/


