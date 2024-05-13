Return-Path: <bpf+bounces-29647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505A8C453D
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B06FB2384E
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 16:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FD0182B9;
	Mon, 13 May 2024 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LNBKvguN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AYBjmSpO"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463C1CAAE
	for <bpf@vger.kernel.org>; Mon, 13 May 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618811; cv=fail; b=r7kay/8U2XoKFuYmEyPC8+kGcVHR9h3J7MJYIuPNa6EQMN0xcfPZ0cQRAZEH3JrWZ5VxobjQzG5icVaV9fBM8hGDAjEjYggzenl0NpB9PPavkeA1AVa59zTzOQw4oIR1uXR/vUP8e9gPDFsnUJFUKu10bXeLSEyBGJZJCPFtK38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618811; c=relaxed/simple;
	bh=8rJB2jIiAKGmaG9klKAdGZV/g0vDGJnK8mHMNiCvY7k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CoF0yIGX96IbH3IvSYk/OF5EwBeLJyxmUSzQQOKebvUeAmImHw9jKITBHNw0miIZNLa+SKVd/svvmj3B9dbz7dBTKENrkxY+fTjTC7ndJT2o5TH9jxDMY0PoIvq/OgoM8KD1mTfChzliJ78ryEtcpf/6aEYlLn5kw8R8uTo6nsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LNBKvguN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AYBjmSpO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DGixig021397;
	Mon, 13 May 2024 16:46:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=e4uvCHdD4hltGy/TXRFmE5IOQQia00oGqALCbFXmjDU=;
 b=LNBKvguN5Kef/fQgpooi759IfjV7ueNKdIWEmDGATQTblXTpQx+iBgbpCbpdjD/UMYXL
 EkD53z3qcGyv+vqbXj+Z3wg1oDJWduc7UdpAJk07v/qt9jREO0wNLNO3U4qTC/wmfXlA
 hdb04IoYppPzkGTILmEe+RoTrvzDtnskfF2kesB7EYuYlQPfS/dhV0KkFJ7oZbqE7iDw
 8ISNZx6W+4SLdg/lYcnQtpzO3TuHM2B3K+1bm2zOIV5RJS3IX5uJxh2EqTY9l2dZjXe3
 BxoSygL6hHb4jvlneNVcpEdxKFOo1mUsX6SDi1KgC3HLiBBMygNrcPswclYOGVhBZrBv Ww== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3dyx1f1c-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 16:46:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44DF2pIc005900;
	Mon, 13 May 2024 16:25:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y461ktx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 16:25:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsm2YsaDzRjeLFjnhHLkqVx53TrpTBCLVnMMdVW1mL4LuHLIvTP4GNNfmWyLfkjE9rXvV0BmXVJhh//2rwDJMxDkBJK7e8/z+PXinoInv6mepvdCaEan26lDJPmnKIUp1Ivpa5fS1lQzgaC+WUBCVNy2lLoD+mXBi3CE3VTNOFpyyBBZz5MTAOkXvmbxj2QHSgIxiBGVjEE6H0gPrKC+dpOTduU8N9OfAYgFCz/HVGMiJAbMhs7rkihKxVRpSHyg6ICdiPkxZk4OsDTEYvwR2bqJT18XDURo6J5cv5ngBiJM3lPfy7+mDN9FjTXLFvmGiDjjprcAZUkNVoPexguJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4uvCHdD4hltGy/TXRFmE5IOQQia00oGqALCbFXmjDU=;
 b=WqJ5/e47hpl3V6r33YRjKF3+uZ3iI9pYsXikSPuk+nJl5JRAmqqF8NDqGCRaMqMTpaIwUx90avOgldF5PV7/pHhO5CKXbkUNA/5nd2muFWIXSUgumkAqmZ/kWNzZIkPKS/r7T0Bvv5vvLB/CdtnCmW3KKfgP9+ZnzXSQPx5trUyI3imhdk8i2p3uP2+LEB/icRByL2dAlFUmsSJhgDxEH+tk86iw6Y2SmkSr16mwHwOYdqDy6nOX7x/F+IoPl8ufPY/Z4WH8fsIQiM6+y0h3G/6XW680WI1BOnudboOlG2IxhTSKoJIG6Un0YA4WnOS/ZIcp9J02lvtD+eyzbZ0ayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4uvCHdD4hltGy/TXRFmE5IOQQia00oGqALCbFXmjDU=;
 b=AYBjmSpO8L8KYabH41ztUCDYtUs0jh9gk8pZLFhfFCYbnaGsnYjsg7MjtFo/5p85MOLkZqV7y0PAXUx17BwDnlCLM9usYrAa1fzhZ/8olvl6kHHC91CS0HLnIJetcJKpavG9vBdAguw7hiCMoOe6AUCX3mKUCrvQ+rF98R/IjjQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6345.namprd10.prod.outlook.com (2603:10b6:303:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 16:25:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::372c:5fce:57c3:6a03%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 16:25:27 +0000
Message-ID: <5e2acba0-5860-4e6d-8b5f-bb63bd4d89f8@oracle.com>
Date: Mon, 13 May 2024 17:25:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 bpf-next 03/11] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
To: Eduard Zingerman <eddyz87@gmail.com>, andrii@kernel.org, jolsa@kernel.org,
        acme@redhat.com, quentin@isovalent.com
Cc: mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        houtao1@huawei.com, bpf@vger.kernel.org, masahiroy@kernel.org,
        mcgrof@kernel.org, nathan@kernel.org
References: <20240510103052.850012-1-alan.maguire@oracle.com>
 <20240510103052.850012-4-alan.maguire@oracle.com>
 <e161fa605db9eea0f55ccc724051bda6bcc7d058.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <e161fa605db9eea0f55ccc724051bda6bcc7d058.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0100.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6345:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ba6695b-eab2-4734-56ac-08dc73694c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N3JFU1NQZkx1cjk1QjFMRTBQNFFVYi9JZ0dCZFB5ZE53MHBla2FvNUVsKzR2?=
 =?utf-8?B?ZWd4T3RkNzBlS2VxY1c5UlUwZzZ3bjhtU2FSOW5UaGVmK1lkL0lFUDBwdFFt?=
 =?utf-8?B?dkJNejdxcnlzZVBPTExWcmtIME4vd2FtUGdERUZQK2ZqS1kvT0M2M094VEts?=
 =?utf-8?B?cTJBRzF5ZVVIeFJYTVgyUjh4eUUweFhjb1ZjcGdraDBEL0ZQc0d4dmtuMjVV?=
 =?utf-8?B?aFdXMDZGdEhLaVdHb0JqWlJlejdOTUZFTktjUHZTdnVybE9JUHowQi9MRk1C?=
 =?utf-8?B?Ti94MnVrZ0MwNDlpaVdDZnlEV0JTdlZnTmdIaXJFSzVkakxqd0tCaUhadklL?=
 =?utf-8?B?eUYydmhna01XWlJLSEF0STdaSjV1UHl2dXBEd0dGREV6ZTBwbEQ0RW51d0Q1?=
 =?utf-8?B?b3pNdDRkcTBqSjEwZ0VwNzlKeWJTczBNTW0zbEFLZFk2aU5kcXVKMHRnbFBW?=
 =?utf-8?B?QlhhM0FxTlpiSlNrTnR5RDdsUXNLVC80Qll3akN5eDhEMXRCZTEzbUFiMHFW?=
 =?utf-8?B?aWRBNndMdGpXMHZsY1Vxc2p6OHQ4cEhHeGMxZStzRHZadThoaTNhZVJtaklP?=
 =?utf-8?B?ZU5ocndqZDdGaFllMDJXU0V2OWNualFlNFd5THk2Y2ZhYXZjdGNyWjdBb0Rx?=
 =?utf-8?B?Z0VZbmJoWFYzVm82bGIvU1I4eWdjTGpzWjRvSlhPQVJxeGNuS1RybTJYdkUv?=
 =?utf-8?B?dmJDSnVwc1lINHdwVEt3WVhML1RXS2hubk5HSmN0V2ZETTJSQXFyekJiaHhk?=
 =?utf-8?B?NlA3S2tLYXlrblZabU0xL0M1SXJHNEV5ZXRzKzlOemk0bTNPMDh2azBKS0Yw?=
 =?utf-8?B?bmluVVE4QXpSY0xUOXFGV1p2NkRic2RQTU9NQlFGbk5sQlpzYnMyMzVvRnZy?=
 =?utf-8?B?SVRUTzUyTktjT2RINWVFSGw4eHBzZVM3VFpYQnNURE4yaVJ2RlQyWS9teDBz?=
 =?utf-8?B?SXhTMDUyNUtRam5DWFNjenUzaXBRcXNRTzI2anp2VStIUmE1S0JxdE5ya1Bt?=
 =?utf-8?B?QmRjVmNNdmFzaWJ1eHpmOUk0VkFJMjNMNjFkeTg0akJmT00yWDl2N3lZRWl2?=
 =?utf-8?B?M2hSUkUzNzBaOTlEOWhKY2FoZzl6M1FzNExCVFpIamtzVTBScGFzNkRLa254?=
 =?utf-8?B?dWxUeHpSQ240YXFrUkRtOXkwMGV6OTMzdXQ3cmpGNEZzYTJhM0lVd3kyVTNK?=
 =?utf-8?B?TnMxOHFQdXRrRGY3VHNxNFRqV0Z2VjNHZ3VMbEZBMVNaVXFFY08wQ2hCbHd1?=
 =?utf-8?B?OS9KTVFZdFBoYmEvLytPeEtmRk50aFVRNFQ5Z21GTlBlcnVXKzZQOU9WVThs?=
 =?utf-8?B?VEJmbkU0VFl4b0tXT0xIQmhMWmZTQ1gxY1VWK3p3d0UvQm5iempNNi9PekpX?=
 =?utf-8?B?dlBkaXdvMzBzTzZLcnZ6aFBkUS9iamRpUjZzVVdjRTdVYi9qWEhWc3hLQnkr?=
 =?utf-8?B?aEhnbWRRTnQ5MmRMdU5UWVlMaEZhSXk1cmpwUy84ckk1MVg4eTd3aHV6V1BK?=
 =?utf-8?B?WjhKMlE2ZDRLK01GYXhtbEw5YzdYRkRFSE5yYXZkSnA4NkZKTTI1aENmV0V0?=
 =?utf-8?B?Q3RRUzVhWnQzb0RVZG9jQXc4ek40aUYzZFgvMUNjTnBzMUNpa3IvYy9rSTd4?=
 =?utf-8?B?cWpKMXFwL2psRXVUSVNydkZrS25VbGorWG9WRWlRRUMvNVdaZzZuSExQYVNn?=
 =?utf-8?B?NEo0c29Fak1WclhiZ0RLdVdwNnFuTVkvNE0vbnc2Nm1vVytsaHA1dGRnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L053VG5LbW5pNi90K1hQYXhXaHBxS1lhcS9hWG1DMEpwbjVsQkxzc0piOVNl?=
 =?utf-8?B?RnVkL3VTaFVIZEVEZE1qZnRuNEs1OHdaQVZpelMvaWs3aFJzTDNzMDlVOVlC?=
 =?utf-8?B?TzRLZ2dwZE9SQUtSb1NQeVJpSW04VjRvTmEwVjhSbVVMcDgrSi9vWlBxZ1dp?=
 =?utf-8?B?TlJUdzRmUWtxMk5BZUZTbWtkUjFpNk13MFBmUkRsWW5pODFVYzFYbTJheUFu?=
 =?utf-8?B?RlQzZitwalhLZlFIN0ppSE1VN0N0d0lUUm9GOGlKT1RsdVNKTHc0LzBTZXNF?=
 =?utf-8?B?WmROdWVnSDlZaHNobkJrMk9DcDltY1RYV3YyNXVNS0V2dlFCRUI4V3BiNU1J?=
 =?utf-8?B?U2k1L2ZzaHVqVmp4Q2RIVys2eE0yZ3hYdyttY2c4bDB0QVdLU29vUTVXdVB3?=
 =?utf-8?B?QUZ2dFR3UzdzeXZVOUp2M1pMYkRpTSt6WXhLWk8yMXI5cnl5RUV1dkxiNU1C?=
 =?utf-8?B?T3RqQTBFL2hlWDgvQzg3S1QwbVZZNGpNeGpwL2tIMEE4R09uR2RBNGlOMHhi?=
 =?utf-8?B?bXpseUFiY0NzejdTajZQenBHeTBJZ09JSDlUdTRkWEFVc0dSWm9BdUZkKzVO?=
 =?utf-8?B?dGxEUkNUNzdPeUlVZEZ0aUxPOWJwMzBYZklDd2lBT3QvOHRHbHRxaFlYN1Vj?=
 =?utf-8?B?am1iZ0FueGY1SktHSUtDVDVTNmZOaGJrQWFkNjk5YjAyVnREVTdqT2FQQzQ2?=
 =?utf-8?B?QkpHS25rNVVtdUROK2ZkczdCK1o0QTdRY1V2TnVvZ29mbWRhUGlJN2NkSUZi?=
 =?utf-8?B?d0JPNkM2eEFyNW5lWHZPSlY2S0hXRm4rRk9NaGJUc093U2o3WFh6OVp0SE9v?=
 =?utf-8?B?aWxNUDZpdGZrOTZ6aVU5WWt3SWdOdVlyWFhzWk52TUhITHljZURCTVluS1VR?=
 =?utf-8?B?SVo0TlJVdnE1MzlNV1JaQVgvelBXRWhtK3lDSEN1ZkdLS1dwUE5PdXRpSEJX?=
 =?utf-8?B?S2ZHTnlVTXlpTkNEa0NIekNhRXI1c3U5NXNLbmFiQ004L2pOM0REeVVHVTVE?=
 =?utf-8?B?N2pWbS93NFRjSWVoSlgxVmUzcGpwd2FsOW96YitWaWh4UW9lYXNMQi84VytU?=
 =?utf-8?B?d3dZelF2aDZyanB2bEx1S1hvTmpEZjhseUdHbE9EY3NZTjRFVHJPT0dXM3VU?=
 =?utf-8?B?bm9PVXdvV3VyakE2SkwyMG5sRGtEL1BrYlB3WWdHa25RZkxPblI4ZWorck1Y?=
 =?utf-8?B?RmR3alV3VWVvTEZSSWI2Yll2d2psVDBXNElldmhENnF5dURlUS9vL2s1b1NR?=
 =?utf-8?B?ZlQrdVZzdldQWTVKNE1VNC9WUGRiK2VoYllhdTZBS2pDdWRGYk9WT3h1QXFX?=
 =?utf-8?B?eTh2bWtueWZTOElIc2JqN3RDOUJSYmtCb0xQS1BzZmlRZTRYWHJPbVVHN0tj?=
 =?utf-8?B?bHRlSG5iMW5OMlZ5NWVaNm5jTHZDTG1DdU5oblhwdVlUQjRVbkVwOU1WV0VY?=
 =?utf-8?B?NFNTWEt6NktrcTJWQS95VWZGM0RCaURSWVo4RjZiOTdjemZ5YmczMHFMemhW?=
 =?utf-8?B?ZFU4U2x6R3JTc01aeU5DN3JzOUNKKzNrMlF6YVF5NENXLythZjVZM21zY1hV?=
 =?utf-8?B?V21ER1d0VTdOcHRnbzdvTnBCdW1MMXlKd2ZYYXRRTXpVbkJndzVVckh2RlBY?=
 =?utf-8?B?MzFOVklFTFkwR2YyYlNNUHRxamhjRmVWRVVPQlp6WUlNOXFtZ09uRUV2M3lU?=
 =?utf-8?B?ZEVRUlcwVFpkaUQwME1tb2dpQ29Hd1F6a0twbW5VMXo2aGo5SHhuSEFHWmFP?=
 =?utf-8?B?VEVGZ1NYSFR6amxBbXh0aHhQQlNPMkR1RElOMksyYVhUOE8wU05LY00ya0lQ?=
 =?utf-8?B?SE1UbC9pQlJiSEN0K2lnVENuMFp1T0FDRGVpY1Q3WXhxaGFOb1FsYmVJbHla?=
 =?utf-8?B?bEc2ZE1KZkxqWE4xSWloZFNtdXVFcTBlV2pQVmRCUWdwWjlBbTBZbVBUOW5T?=
 =?utf-8?B?cy9tMzBaKzlOVUQ4NXQzcGd2YkIwd3B0OTJzNDFCajQxK25JcWxPYzVXamh6?=
 =?utf-8?B?dENmMnlMNkNYQXpKUnRFRnBHaThsQnFxOXdYd0dwVG1PWHptaURZT2ZBdzNQ?=
 =?utf-8?B?bVh6eUFvRjdYKzJlakZHcUJHandDdWx4V1owNVZMVWswS09FeW5WMStvaEVV?=
 =?utf-8?B?TzRQMkxXZDl5QlpoUUNQdTRWSTRGcnlaWHNkUHRIWmtWQUZ5MVVvWGV5Q1Av?=
 =?utf-8?Q?6Rypb7Y11T4IFgORZg9A3xc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QJxkJQ3ajIMaZwOsdHOBsLxMbYMkSCNWjpCGc5bQzfCtRj+rpoAyqtGv3iLCnntTkWn4/cf5RAq82fec1kx75larpN2zxyoLnmZjy4ASH2xPZsYqwpQwZkLHA81TeTw3ktXir6k9WAKqoLZ8TUt3mwhizKK4nBTMBRBLwT8ZG2zetbQ3BsCOHLqff8xY/C2gI8MxcgHgs2eEmACnK0tJi7lEFCp3hty8ODHAeZ7L97irIsE3Fhin7OZRqOn+mwYn/SKkNJI9B7iPrbCrBr8B734CHT4J3r3E0jht6ZGbR45FVQIAN3BPcIM0eeVrBvXk43BxA7aedUn9qixUrA1N+BEbSMt75Z7suMDsBdIgBdiGrM1mVtBz+SrN8ApZUKZ3sLj6PA5AlnhOMDDlB9mFHdyAp8k6n+kXwyRvSlt6QcfkSpp1JrQ0vs/PaEDR6AEyMH47ozGykJcG0hxsNjEbV0K8SZuwnK0U0sMhYvKDLbWC+hXrnHFiVjNej8n7VpVZ7md3BriRlCNiXexXMKz5Zgk103tP7C0YcS08qmkJOn+twhc9zpRkYcyrNENeAZ8VF9zR3CfobdHGAn00T38nHBSC98ZEmAqjlOoJ5jbOBmU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba6695b-eab2-4734-56ac-08dc73694c98
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 16:25:27.5904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6L9eTHK8o9p1kr1mpZgf3I7dJn95bP8bNZ2RekQcvt6N+PnKpyH9fIugy0dSu2jW8FRvL1nzFOcJJwJVCrGdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_11,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130106
X-Proofpoint-GUID: iYMUC5V5UW3WkdCx9epPWkup7y3ywLcO
X-Proofpoint-ORIG-GUID: iYMUC5V5UW3WkdCx9epPWkup7y3ywLcO

On 11/05/2024 10:40, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 11:30 +0100, Alan Maguire wrote:
>> Options cover existing parsing scenarios (ELF, raw, retrieving
>> .BTF.ext) and also allow specification of the ELF section name
>> containing BTF.  This will allow consumers to retrieve BTF from
>> .BTF.base sections (BTF_BASE_ELF_SEC) also.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> For the sake of discussion, what are the benefits of adding
> btf__parse_opts(), compared to modifying btf__parse() to check if
> .BTF.base is present and acting accordingly?
> btf__parse() already does a guess if passed argument is an ELF or a
> RAW file, so such guessing semantics seems to be a natural extension.

It's a good idea. The only thing I'd say against it is that we already
have existing semantics there that are well-established, and the
.BTF.base scenario will be relatively rare, yet the check would I think
be a tax all .BTF-only cases will have to pay. We'd presumably check
.BTF.base, and if not present check for .BTF. So all callers of
btf__parse() when accessing .BTF sections would be checking for
.BTF.base first.

In that context, it seemed to make sense to support an explicit request
for a specific section (via btf__parse_opts()) rather than inducing
overhead in existing checks. But again, if the overhead isn't seen as an
issue, we could absolutely do it.

