Return-Path: <bpf+bounces-20579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20EDA84061D
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 14:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB5F287392
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11C3629F0;
	Mon, 29 Jan 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l6TzgI9n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JmuqnuOw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA5C64ABE
	for <bpf@vger.kernel.org>; Mon, 29 Jan 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533536; cv=fail; b=dq3UZka28mf5zNkD/NedPPFC2AZos7mmAhr+pTwLk241lxRiNmwIBAbHRp4fr6JHfi7EeWGy5iktO/nn2+PZ5lBDneqxc74utRkuGsCE95HrenThHCROWr+XeRQJNE8ErW6d+1YYd97r9HA4XMnUVYybGo1kJbg5lHcLt86MyRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533536; c=relaxed/simple;
	bh=DYOW38kdKDeVojKQCGyQ8IIgxhe5eKvsNB5YM4ns9W4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IYxOFqBrl/I5Oz32bV6nTv05HvnptwMP6T4iBRo2Cog7UxLZXDPFWLqPppM2e4T2ZmIDxGCuGoRRsGS9W2kmSD8soxUfkCV0dg71+2950U/0+IFvJCgH9cz20zxv1RLtnY1rA36TaRgZfbGibU9XYxnI3TdnQpcjXkSM2ueixXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l6TzgI9n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JmuqnuOw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40T9iYPl021913;
	Mon, 29 Jan 2024 13:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=8ElH8PXztppYF38YMGTfCbf+GAe9ECqGf+KA2K1Kf4M=;
 b=l6TzgI9n/gY2nYESDF8jfGvoFDYCkTb+Znc0nng8Jggs5UKhcCBgv4ZScuaLl8u20GK4
 14yDIsWnddIGNuNYchyuH9kAmoTGjaAvVUP5KF2h4ga/gqcX7cbZ0NbBEbHKEl8STL6s
 o+HLhoEKA2PsT8oq70vLzPsAoPXUkXcN15DM7T11zVhQjwTScYO+4LFEmQjMrGbnQHaJ
 xTjq0LgyDnM8+6GxNzz/D6VsTnYLcxjZ7SGr7DUL+vEcufuMje/LZjk26sy2FSkXlk1U
 bk1yAbCwVb2AMbxwF1vNxNo7vB3cz56kAoOQhQrOngqoblhVTGcXccVd/94ZRhTLyZiA Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrrcbu3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 13:05:13 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TCiAI2008488;
	Mon, 29 Jan 2024 13:05:12 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9c3gt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 13:05:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpC1lq2X8fOuttzN0lIcS8+8qEA8BoN2DNrjc/0mU0Kg7Y3fDdYHqbVbx+kHS24ubdiMNahOr3PA3ydk6RmCo/ZY15A97X6QosZ7o4GC3suYsXp5ixdWbO/ibWgDURUn7Hae13oz3550B4cOdXsa+5IgmwRNmUjrXAPdIm6TcihD5rtPJuC0tYVHoZF9jcsmYL57M7L/bPh8tHrl/XalfplrxEOeHNmaPVxt40pNZutOYQkktKXcvZ2gsE7zLOp8KZPo0CXKNUGJvfiu5lYRn6wM5z2q+LIqzm189pjcs19xvUGLBEI6G9cQuJEREl0p0QpqVJNI4qFfZ8l0IwDCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ElH8PXztppYF38YMGTfCbf+GAe9ECqGf+KA2K1Kf4M=;
 b=en0GtALrF38z9nE3EkHbwXpwqjxl+D/sKSKRqvAjgN3x/QtU9Jl1zwy95Yvhn+tZT9W6bm/oGvtw5rvViITdoQ470+aQkMd54ciA0MYoAoxjTi4iDT7yvN9aUtVxZJnG7o83xlf4aKCJQ/UpRsgwQce0IiR2s5zFpDEuAFHX7MH1ftFT/qfzKQZDOjJrHcimSIDdbvYDAlwBdv6sEH4jjBADuH1/4CRXMhBzaCqbOAhHqZBkqbCgTA8PM0+vwxfi8SGy/vv+yDG00Ob2XFMeZtyHZ839Dy4lTiorq82pGPjWYPYVySmjrGZR4+qrtneRDj9tZsPwyE6oL6OsCOArfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ElH8PXztppYF38YMGTfCbf+GAe9ECqGf+KA2K1Kf4M=;
 b=JmuqnuOwXYx+Ke5FF5bpCej5aWTh4sOVRCCrBOX/tfO+WienrKswVznczkG8eJ35QC65UeasYf0Z3p8xIY5J/7VWnZvQz1KEdyK0MDCvOksnMtkKfvXKhkwv9+spmOh6kHu5PUJ1Yg4dNplY9wuVdE9I/gbdIwcD+dt9AJAQLZE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB6689.namprd10.prod.outlook.com (2603:10b6:610:153::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Mon, 29 Jan
 2024 13:05:09 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 13:05:09 +0000
Message-ID: <49da8aff-1ec7-b908-2167-ee499e7a857a@oracle.com>
Date: Mon, 29 Jan 2024 13:05:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves v3] pahole: Inject kfunc decl tags into BTF
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org,
        quentin@isovalent.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <0f25134ec999e368478c4ca993b3b729c2a03383.1706491733.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffa3eae-80bd-4349-9dfb-08dc20caec1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ni7orunktyDQyltYGX46gNI2IncEUVzC8AReyr1R/+PmToh6T63vCQweiL8xH/L/TGaE8HiFnyq9CmSGp+m7j3dbCFA3wInTJXd6X36RH3V0cYT3DBix4F4Ffc/KMwCNreBghdE1xGeB0mbThBDbSeRvOmG7TWBQbTsWoTDUymUOzl7hOpawt14kslJlZkDBsZhL0/Hm+nXvklullU3KpL1Qyho/M2CKHBmHBiwqkpKfab8IWLT85bXbDNJzNW2tjzYVEq/Yq/B2jwa5UcdAvK/ksW25TXvoaN6AFHIMnCewK7JtcE0b2BHZKztDVEdEsjbMgnYugMBM6Q6GCrObEWB8EM3+wwV9g+cgBAd6J2LDjpyifDVowdkBv1Et7+kEyUA2zX11BnF2wLv2s7ihgeFBZ8uftGnDus43GRTUYwjeqeaFmkhLQ+yeLK4mlnpoVikUu+XmHP6ghmggDqCJlU9o+fZTqv5AFFGBjUzUZ89hU1bGqml4hEvHiV6sSpH+U1JFUKaQhE9I43ZkrtwjIZdkFuCJ9mrEMuoKanJ7q4ocV7kRgZ19XUvebNn+FgnPcJWHiyzCpdvHdMnC+lxzNAJ0HKJCOI+7K4zC11utA7+H4dbk4iOtko/lN7hISdAtFrvgA+dYk+NBshpNAb4RaQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(316002)(66476007)(66946007)(66556008)(8936002)(8676002)(4326008)(83380400001)(31686004)(478600001)(6666004)(31696002)(38100700002)(6486002)(86362001)(30864003)(2906002)(5660300002)(44832011)(6512007)(6506007)(2616005)(53546011)(36756003)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UHdjdHBvd3BYcmdiNitMVWVOaGVCY1htSnpla1ZRak5ONDRJcFozWi9zdzhZ?=
 =?utf-8?B?Q2xlOHArRlQ3UTJUREJ5SE1ISUNhY2NHbElCUWFWOVkxYzNhOTFDdHIxOEwz?=
 =?utf-8?B?V1VZQjBHRGFUUy9OaG1CSEtmSlRpZlE1TnpvVFNkcFZzb2lLdHlGMU5PZ1R2?=
 =?utf-8?B?d2cvd2VXbkh4bzdrRFBWRWs4c3AyVGZ2aEdSL2NmOUhZYytBOEdLL0xLVTRp?=
 =?utf-8?B?TDZHM2tjazU2eitGckhkbU5DQmx5UXh0NlBYUzhScFV6VldXdHlKOGlrc2JO?=
 =?utf-8?B?bXJWcm9ZbzVBNmxXcDhLZmxoRTEvekhpN0prZk9hb2pIUmMzTFVlL2FVKzZJ?=
 =?utf-8?B?V1hOcHczeGFiOXAxaXE5bmJXZm9TbjFabFlSM01uUkhaTjNGMTYvek4xUFFo?=
 =?utf-8?B?TFM4M1d0OUJydzZULzVjaEhZVXlvNUx6WG5KOSswUVlWaHpaWHhLUHlHcHJ1?=
 =?utf-8?B?TzNNUVZXYnBqLzdBYWZYZGkzclArcy9GMTRFbGovS1Z5SHZqbVdYSHhpVTJr?=
 =?utf-8?B?YTUyOFVlRmVVL2ppZXp0N3lYeGpTVHQrSGxnNW8vNG5Zc1QzZyt1bG96cFV1?=
 =?utf-8?B?K3g3Z1UyVVpESUFEQzVlOUdKUkJpbXZFSDNMd0JTWU1vMnFDaUhiUm5rKys5?=
 =?utf-8?B?OWV3L0NEU2tsVURlWmthNmR2alNSNlkrd2xoZGlHSDhFRkZYQy8yTE9TNEQv?=
 =?utf-8?B?THhQNU1OVzdTbmZKbVpmelFRRENjV0srNXdDR1M2NDZqbjRBQ3Z2SERYaWov?=
 =?utf-8?B?Mi9HTCtSNzFETEdjd1BqejJYSTNWMjRDeW5TN3lDOVNBTUVXMGJlSkxkdWlI?=
 =?utf-8?B?dWVleFQ2Zk4vWmw1TUZYeWJtdUcyWFRpVENFRkdiV1VYOWl3QjJ6SGtXN0lp?=
 =?utf-8?B?a0FyYUtEaEEvdEpwYWplUVltTUtEcGxtVUdOTktNY2xnWkZZSkxpdkNUSlky?=
 =?utf-8?B?dXk4c3R1aGgrVzhrNFZjeWEvbkQrdnM3dGJHN0pFbHV3cDl2dEM5M2ttdmFz?=
 =?utf-8?B?Tk51QUxXRE1FNXNFdTFFemVaRUd3Rm5TK2F6S0trQ1FYQXNOSTRnK3FSVmRI?=
 =?utf-8?B?WW16SmZUTnRKMjNGVExEdzVBT0s1b0Y3Q3AxOU85OVBiVVhjN2xDb2hKWU5P?=
 =?utf-8?B?cmlpTVdKN3pPL0ZDU0plU2x5M3VZeW9Ic2Zwb2U1aENqbG9QMW5tZlEzREpR?=
 =?utf-8?B?SEQrc2pCbFkwZUJsbElSSjdhY3hOMGJ0UUtpWFFjNG9iWndGUC9OSEtRMTl3?=
 =?utf-8?B?TkpLVHBaNDlNTk8zbjRzcm8rSlRMQThyZ2FDSDhjOVRnY2drNThpWFppOGVq?=
 =?utf-8?B?VTRsa1F2MnQ1SXgyek00Z3JWUnhtd252V0VEN09KLzVPTTMvczVmSHZ5V3RX?=
 =?utf-8?B?YkFPTjhPQ2FEZHJmNUY1bml1eXJnTEoxdFlHRjZOQUgyQ3dsbm9HRVhpRlNn?=
 =?utf-8?B?d0dXaGVSNXFaVGhPejI4d0piMWhxMm5ZNTZremdVVjA1U0IzOHFXZDRuVGtH?=
 =?utf-8?B?MHpuckpiby9CdWhvNkJuTmM3aC9DRndTU0JPZjNYUmdMdnFYYk9KUkhMdmFX?=
 =?utf-8?B?aHM3K3BvZVR5a0xEK1Y3WHRTYnExcWVRY0JNeFM2VHdlYzgxMER4N2pHWWs3?=
 =?utf-8?B?TElVMTdlN1MvMUNPNWU0OEVZR0V5ajJqZU95V1poRVJaalBabEowMHdkTG9O?=
 =?utf-8?B?dDlHSmc2dGJxYjhZM2ZYVVhLUERCOTZFQmIvbWdWc2VsTG9BS2xLWHR1aldT?=
 =?utf-8?B?ZHZrakRORzZGcE5KM2t2TXBodmZESmdDbUxKVnRyQXVLelp5NWp1d3p1VnhZ?=
 =?utf-8?B?N2QxQzJrMytBZWRmQndhK1NxbGJVLytILzJvNHpKTi9URTZzYmErai9lWUhN?=
 =?utf-8?B?WUExbVR0R1NhOFR2ajVIaHBsWUdHTFJDb3g1QXdFYWwwWmlPclhGcTJWTTl4?=
 =?utf-8?B?cm1naXFDVEVoalRQbHg1bmZJc1puR1FISTlxR0pOTHVGa2NsWC84dWxqRE1x?=
 =?utf-8?B?cXRJemtYdmVaUXNMUkJmMHExSkYvRFpzWmhnTktLZXgzUnFpYjh1NjRyUnFw?=
 =?utf-8?B?elBxZTRiTjNnNEdzczVYeVhGL2xWZGR3SGpWd2dweWhNWW01YTBIMllKNTlk?=
 =?utf-8?B?VUhFQ1ZWZXl2Y0gzRGMrbWlkbE5NdmFpZ0d5YnVTSTA2dld4V0tnbks4b3Ba?=
 =?utf-8?Q?WXAN+lleogbz0wnfOjBFLFc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	TbrvcU1GA9d5zAbZyxfkvrHcT4/zpc/emGW29d+PkTP2L8WSChaOgjkThwekUTtrm21UR+iTP7mGynFeMbOUoot45ZmIM0vqN7GZpeQXkd65GK/BtMFOw3B3k3vHPWftY6I43PNFPDyT5fC3ZKOrQe5wakdveDH9l0oc2ZDpJ0Bm2m4gff+OzhUfFrSvgxuZtgnJNifJFGXyoqVeW7sbI2yD2yYV4ULiKhIf35JU3kSmOBsrq06LBzkIBDlrLMBbymY4Mm9vDJoYz7QIeHFudRunx+ZBzT4KBraFp2/aL2D3HSapbhEVaRaiAZ+1IP1Vj1CmWAET9HqTB0Sj12iN+kBiqkU3TiU5RaNHlQUYqQ/8oHkqLbQtfITJcgm0oOcfSuAwt+TZu1aS+nrRoNf10pMdMTP2xT+DKb32feC0cncct5xfYlj2N+TQosADolxj0kmhCcV7XJ5p6nIjiWsus/PHKUOpSW0/CIcUVDf5BejmquadtnjSxsG7y6dvgmqKMUQoBpVEpNv0sYn4+/x8W1yeI7gXYTraxlhFWO3K5rDwaHJ2YtADxStfym0cN9NLySa2BEioZbBNyMg30P+zohUwxrg7QxTrVroXYlqnCL8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa3eae-80bd-4349-9dfb-08dc20caec1d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 13:05:09.7687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOPjLgR1rDybeDXgSKLgwtSDhSnmdCWFsBxNZSc/4m7cMDfRryryjlbasKsLja07nQPZtY8vP60kPepWfp/fTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_07,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290095
X-Proofpoint-ORIG-GUID: nTh0OxrcaixjkO-nKMLpJiiYJxh0oTTs
X-Proofpoint-GUID: nTh0OxrcaixjkO-nKMLpJiiYJxh0oTTs

On 29/01/2024 01:30, Daniel Xu wrote:
> This commit teaches pahole to parse symbols in .BTF_ids section in
> vmlinux and discover exported kfuncs. Pahole then takes the list of
> kfuncs and injects a BTF_KIND_DECL_TAG for each kfunc.
> 
> Example of encoding:
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg "DECL_TAG 'bpf_kfunc'" | wc -l
>         121
> 
>         $ bpftool btf dump file .tmp_vmlinux.btf | rg 56337
>         [56337] FUNC 'bpf_ct_change_timeout' type_id=56336 linkage=static
>         [127861] DECL_TAG 'bpf_kfunc' type_id=56337 component_idx=-1
> 
> This enables downstream users and tools to dynamically discover which
> kfuncs are available on a system by parsing vmlinux or module BTF, both
> available in /sys/kernel/btf.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>

This should probably be a BTF feature supported by --btf_features; that
way we'd have a mechanism to switch it off if needed. Can you look at
adding a "tag_kfunc" or whatever name suits into the btf_features[]
array in pahole.c?  Something like:

	BTF_FEATURE(tag_kfunc, btf_tag_kfunc, false),

You'll also then need to add a btf_tag_kfunc boolean field to
struct conf_load, and generation of kfunc tags should then be guarded by

if (conf_load->btf_tag_kfunc)

...so that the tags are added conditionally depending on whether
the user wants them.

Then if a user specifies --btf_features=all or some subset of BTF
features including "tag_kfunc" they will get kfunc tags.

We probably should also move to using --btf_features instead of the
current combination of "--" parameters when pahole is bumped to v1.26.

> ---
> Changes from v2:
> * More reliably detect kfunc membership in set8 by tracking set addr ranges
> * Rename some variables/functions to be more clear about kfunc vs func
> 
> Changes from v1:
> * Fix resource leaks
> * Fix callee -> caller typo
> * Rename btf_decl_tag from kfunc -> bpf_kfunc
> * Only grab btf_id_set funcs tagged kfunc
> * Presort btf func list
> 
>  btf_encoder.c | 347 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 347 insertions(+)rre
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index fd04008..4f742b1 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,11 @@
>  #include <pthread.h>
>  
>  #define BTF_ENCODER_MAX_PROTO	512
> +#define BTF_IDS_SECTION		".BTF_ids"
> +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> +#define BTF_SET8_KFUNCS		(1 << 0)
> +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
>  
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_state {
> @@ -79,6 +84,7 @@ struct btf_encoder {
>  			  gen_floats,
>  			  is_rel;
>  	uint32_t	  array_index_id;
> +	struct gobuffer   btf_funcs;
>  	struct {
>  		struct var_info vars[MAX_PERCPU_VAR_CNT];
>  		int		var_cnt;
> @@ -94,6 +100,17 @@ struct btf_encoder {
>  	} functions;
>  };
>  
> +struct btf_func {
> +	const char *name;
> +	int	    type_id;
> +};
> +
> +/* Half open interval representing range of addresses containing kfuncs */
> +struct btf_kfunc_set_range {
> +	size_t start;
> +	size_t end;
> +};
> +
>  static LIST_HEAD(encoders);
>  static pthread_mutex_t encoders__lock = PTHREAD_MUTEX_INITIALIZER;
>  
> @@ -1352,6 +1369,327 @@ out:
>  	return err;
>  }
>  
> +/* Returns if `sym` points to a kfunc set */
> +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> +{
> +	int *ptr = idlist->d_buf;
> +	int idx, flags;
> +	bool is_set8;
> +
> +	/* kfuncs are only found in BTF_SET8's */
> +	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
> +	if (!is_set8)
> +		return false;
> +
> +	idx = sym->st_value - idlist_addr;
> +	if (idx >= idlist->d_size) {
> +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> +		return false;
> +	}
> +
> +	/* Check the set8 flags to see if it was marked as kfunc */
> +	idx = idx / sizeof(int);
> +	flags = ptr[idx + 1];
> +	return flags & BTF_SET8_KFUNCS;
> +}
> +
> +/*
> + * Parse BTF_ID symbol and return the func name.
> + *
> + * Returns:
> + *	Caller-owned string containing func name if successful.
> + *	NULL if !func or on error.
> + */
> +static char *get_func_name(const char *sym)
> +{
> +	char *func, *end;
> +
> +	if (strncmp(sym, BTF_ID_FUNC_PFX, sizeof(BTF_ID_FUNC_PFX) - 1))
> +		return NULL;
> +
> +	/* Strip prefix */
> +	func = strdup(sym + sizeof(BTF_ID_FUNC_PFX) - 1);
> +
> +	/* Strip suffix */
> +	end = strrchr(func, '_');
> +	if (!end || *(end - 1) != '_') {
> +		free(func);
> +		return NULL;
> +	}
> +	*(end - 1) = '\0';
> +
> +	return func;
> +}
> +
> +static int btf_func_cmp(const void *_a, const void *_b)
> +{
> +	const struct btf_func *a = _a;
> +	const struct btf_func *b = _b;
> +
> +	return strcmp(a->name, b->name);
> +}
> +
> +/*
> + * Collects all functions described in BTF.
> + * Returns non-zero on error.
> + */
> +static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder)
> +{
> +	struct gobuffer *funcs = &encoder->btf_funcs;
> +	struct btf *btf = encoder->btf;
> +	int nr_types, type_id;
> +	int err = -1;
> +
> +	/* First collect all the func entries into an array */
> +	nr_types = btf__type_cnt(btf);
> +	for (type_id = 1; type_id < nr_types; type_id++) {
> +		const struct btf_type *type;
> +		struct btf_func func = {};
> +		const char *name;
> +
> +		type = btf__type_by_id(btf, type_id);
> +		if (!type) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve type for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (!btf_is_func(type))
> +			continue;
> +
> +		name = btf__name_by_offset(btf, type->name_off);
> +		if (!name) {
> +			fprintf(stderr, "%s: malformed BTF, can't resolve name for ID %d\n",
> +				__func__, type_id);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
> +		func.name = name;
> +		func.type_id = type_id;
> +		err = gobuffer__add(funcs, &func, sizeof(func));
> +		if (err < 0)
> +			goto out;
> +	}
> +
> +	/* Now that we've collected funcs, sort them by name */
> +	qsort((void *)gobuffer__entries(funcs), gobuffer__nr_entries(funcs),
> +	      sizeof(struct btf_func), btf_func_cmp);
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, const char *kfunc)
> +{
> +	struct btf_func key = { .name = kfunc };
> +	struct btf *btf = encoder->btf;
> +	struct btf_func *target;
> +	const void *base;
> +	unsigned int cnt;
> +	int err = -1;
> +
> +	base = gobuffer__entries(&encoder->btf_funcs);
> +	cnt = gobuffer__nr_entries(&encoder->btf_funcs);
> +	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
> +	if (!target) {
> +		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
> +		goto out;
> +	}
> +
> +	/* Note we are unconditionally adding the btf_decl_tag even
> +	 * though vmlinux may already contain btf_decl_tags for kfuncs.
> +	 * We are ok to do this b/c we will later btf__dedup() to remove
> +	 * any duplicates.
> +	 */
> +	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
> +	if (err < 0) {
> +		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
> +			__func__, kfunc, err);
> +		goto out;
> +	}
> +
> +	err = 0;
> +out:
> +	return err;
> +}
> +
> +static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
> +{
> +	const char *filename = encoder->filename;
> +	struct gobuffer btf_kfunc_ranges = {};
> +	Elf_Scn *symscn = NULL;
> +	int symbols_shndx = -1;
> +	int fd = -1, err = -1;
> +	int idlist_shndx = -1;
> +	Elf_Scn *scn = NULL;
> +	size_t idlist_addr;
> +	Elf_Data *symbols;
> +	Elf_Data *idlist;
> +	size_t strtabidx;
> +	Elf *elf = NULL;
> +	GElf_Shdr shdr;
> +	size_t strndx;
> +	char *secname;
> +	int nr_syms;
> +	int i = 0;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "Cannot open %s\n", filename);
> +		goto out;
> +	}
> +
> +	if (elf_version(EV_CURRENT) == EV_NONE) {
> +		elf_error("Cannot set libelf version");
> +		goto out;
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ, NULL);
> +	if (elf == NULL) {
> +		elf_error("Cannot update ELF file");
> +		goto out;
> +	}
> +
> +	/* Location symbol table and .BTF_ids sections */
> +	elf_getshdrstrndx(elf, &strndx);
> +	while ((scn = elf_nextscn(elf, scn)) != NULL) {
> +		Elf_Data *data;
> +
> +		i++;
> +		if (!gelf_getshdr(scn, &shdr)) {
> +			elf_error("Failed to get ELF section(%d) hdr", i);
> +			goto out;
> +		}
> +
> +		secname = elf_strptr(elf, strndx, shdr.sh_name);
> +		if (!secname) {
> +			elf_error("Failed to get ELF section(%d) hdr name", i);
> +			goto out;
> +		}
> +
> +		data = elf_getdata(scn, 0);
> +		if (!data) {
> +			elf_error("Failed to get ELF section(%d) data", i);
> +			goto out;
> +		}
> +
> +		if (shdr.sh_type == SHT_SYMTAB) {
> +			symbols_shndx = i;
> +			symscn = scn;
> +			symbols = data;
> +			strtabidx = shdr.sh_link;
> +		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
> +			idlist_shndx = i;
> +			idlist_addr = shdr.sh_addr;
> +			idlist = data;
> +		}
> +	}
> +
> +	/* Cannot resolve symbol or .BTF_ids sections. Nothing to do. */
> +	if (symbols_shndx == -1 || idlist_shndx == -1) {
> +		err = 0;
> +		goto out;
> +	}
> +
> +	if (!gelf_getshdr(symscn, &shdr)) {
> +		elf_error("Failed to get ELF symbol table header");
> +		goto out;
> +	}
> +	nr_syms = shdr.sh_size / shdr.sh_entsize;
> +
> +	err = btf_encoder__collect_btf_funcs(encoder);
> +	if (err) {
> +		fprintf(stderr, "%s: failed to collect BTF funcs\n", __func__);
> +		goto out;
> +	}
> +
> +	/* First collect all kfunc set ranges.
> +	 *
> +	 * Note we choose not to sort these ranges and accept a linear
> +	 * search when doing lookups. Reasoning is that the number of
> +	 * sets is ~O(100) and not worth the additional code to optimize.
> +	 */
> +	for (i = 0; i < nr_syms; i++) {
> +		struct btf_kfunc_set_range range = {};
> +		const char *name;
> +		GElf_Sym sym;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		if (!is_sym_kfunc_set(&sym, name, idlist, idlist_addr))
> +			continue;
> +
> +		range.start = sym.st_value;
> +		range.end = sym.st_value + sym.st_size;
> +		gobuffer__add(&btf_kfunc_ranges, &range, sizeof(range));
> +	}
> +
> +	/* Now inject BTF with kfunc decl tag for detected kfuncs */
> +	for (i = 0; i < nr_syms; i++) {
> +		const struct btf_kfunc_set_range *ranges;
> +		unsigned int ranges_cnt;
> +		char *func, *name;
> +		GElf_Sym sym;
> +		bool found;
> +		int err;
> +		int j;
> +
> +		if (!gelf_getsym(symbols, i, &sym)) {
> +			elf_error("Failed to get ELF symbol(%d)", i);
> +			goto out;
> +		}
> +
> +		if (sym.st_shndx != idlist_shndx)
> +			continue;
> +
> +		name = elf_strptr(elf, strtabidx, sym.st_name);
> +		func = get_func_name(name);
> +		if (!func)
> +			continue;
> +
> +		/* Check if function belongs to a kfunc set */
> +		ranges = gobuffer__entries(&btf_kfunc_ranges);
> +		ranges_cnt = gobuffer__nr_entries(&btf_kfunc_ranges);
> +		found = false;
> +		for (j = 0; j < ranges_cnt; j++) {
> +			size_t addr = sym.st_value;
> +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found)
> +			continue;
> +
> +		err = btf_encoder__tag_kfunc(encoder, func);
> +		if (err) {
> +			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
> +			free(func);
> +			goto out;
> +		}
> +		free(func);
> +	}
> +
> +	err = 0;
> +out:
> +	__gobuffer__delete(&btf_kfunc_ranges);
> +	if (elf)
> +		elf_end(elf);
> +	if (fd != -1)
> +		close(fd);
> +	return err;
> +}
> +
>  int btf_encoder__encode(struct btf_encoder *encoder)
>  {
>  	int err;
> @@ -1366,6 +1704,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	if (btf__type_cnt(encoder->btf) == 1)
>  		return 0;
>  
> +	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
> +	 * take care to call this before btf_dedup().
> +	 */
> +	if (btf_encoder__tag_kfuncs(encoder)) {
> +		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
> +		return -1;
> +	}
> +
>  	if (btf__dedup(encoder->btf, NULL)) {
>  		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;
> @@ -1712,6 +2058,7 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>  
>  	btf_encoders__delete(encoder);
>  	__gobuffer__delete(&encoder->percpu_secinfo);
> +	__gobuffer__delete(&encoder->btf_funcs);
>  	zfree(&encoder->filename);
>  	btf__free(encoder->btf);
>  	encoder->btf = NULL;

