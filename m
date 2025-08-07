Return-Path: <bpf+bounces-65216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B07B1DBDE
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 18:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7EA04E2B33
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 16:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9158D271456;
	Thu,  7 Aug 2025 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YjHxm7uI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CQmq+867"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A09D1E51E1;
	Thu,  7 Aug 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584632; cv=fail; b=Lpn163NNtYGnBs6oW0YFng+R3bb6My/9MzOr2FED6UMxqP4Iwz/aS4UyWPvUECqyw70niIeHaRfiDh4NniVRcTsB7Nt2Pxx38QrXBrfuIKK66KRvH71e4C4pQ/0DRKfDpLaW/Y74i64AgZRXtVLwZ8RlMSoY/j3gjipOKgqQwbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584632; c=relaxed/simple;
	bh=qF/P+UGwJ/Vig74kS5QXcrb/uGcErTubIJ3w/gBaiAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=mooRThFw069bC7A+r56IIc3NZsVFI+K5cgKv06jnUVaJefVMdT+HIp08d30ssWz4wBwhYXejNt2Jwt3DKa9gpX9ZT8Z+vpIJ8p4DTQNfWJWlpmp7iPdgiHS9+8IvNpYzXg8VVx4rhU5sHFiJnhPdDScSUn6PaFTst1xZ6k5LEB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YjHxm7uI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CQmq+867; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 577F7B8K028608;
	Thu, 7 Aug 2025 16:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WStlKKYOuMVCqN63WCCc3D6EAmdGuqrsd9cjZYrvmQI=; b=
	YjHxm7uIkNFdlfF1uTBEiIH69ahfAiYPeMONrcQj/adUw1nI0LWqOdQ/N5gC3Waf
	oShz9WLRCczUTJwWvjfjdSg1TFxT0XSvuzU91H/3ORIIvbSqHHXotT/ofHY9bbAd
	u0YMbKPky0KPj+Rvy/95MB8YZFb6NhKXtasqItzF1SeP6CFpexN+CnWIMhIRvXzP
	ussYjVsXeOjsL8pm2g0HYZppqJUlXCl/AEpGPS0CHkUR75EJb0hzF/qMy4ee1w31
	BwmiiVE9A2cVNDedX6yoISZIFIvdpQKlCUlKnwxs+Q/inxwR6yBHbtk2g+uN6xs7
	sMgSvoWH3U2ybkjEJ1Z35g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvh4h2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:37:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 577FnYIk028190;
	Thu, 7 Aug 2025 16:37:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwnw26e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Aug 2025 16:37:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5uE6Puk+lVdSlPLjWWg6gbXh7p9dJErd2BLMW1opx2m+u700znMvBZjWn0Wuwjrmxx7JIGnOQtjoIteQwGbky7PX3orkLHGFEN124jI7vqm1dI+Xrzv0FZHaD9P/WkLI6/05rB2622R7YtEO8/Ve7gBcvAXRDx7eNuGdYZC9+vEczsKOtEQLTuToKWDfjY47nsrN7TI2cWHeMJdCNn2iBf6H/uHijdVucWzjbYZFTDmFK5KG3V/Iytruf9/7pNO7xpyvNuX9HKvUjGBwhGPJN3V7jFGYOi6uND6kuw704IXD2ws/8NlxK21HvjcYTCdwcNA17UB5Al/axLE5EvVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WStlKKYOuMVCqN63WCCc3D6EAmdGuqrsd9cjZYrvmQI=;
 b=Mw8nCD/IrpZKvj19kQsx3upsnGi6AVP1Re8ATDS1d4QT6yt3YzhELZBt0DEsMOouh7HcmwxUJg2z0yGEX/FBh+lGYTqvJQOJrs1sQ3nc/lc2us48nZ3PxBLqrReue35ZwuP1o8gQT8+KNal5O/M1hoEpkMlfQAu7a+/4sd61qM4jeni6PXF6PEm4eF5ObdT9qk61NMr9y6hknG/ksnJ+tuDmNeP+m0ZFo+OYDcefjNXzKQ6+6lBqKdpGCSTTyjCt7wYr6x96Lpht2wdaYXMDCMnlVG63HrsymFhzIEIA6ns4gX76G6MCGQyHFxL9kLHbMGQStCOFtle+3GOH9rmQVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WStlKKYOuMVCqN63WCCc3D6EAmdGuqrsd9cjZYrvmQI=;
 b=CQmq+867LWmjw/g7/vkgd+REEtIoHYq1tYWIvmlnLP4AjuvPeFUJfZ4ub1e0usZ7eAButZ9mfPNXZQ+Rw5iSFayU6JnAmHT0kyg4XTvAI2TLup36CPQ1ojcFLt620/cmj+YTpFuOYPobBe/f/bNwZAebCARDg6StU6kdL9DGtwE=
Received: from CO1PR10MB4500.namprd10.prod.outlook.com (2603:10b6:303:98::18)
 by BLAPR10MB5090.namprd10.prod.outlook.com (2603:10b6:208:322::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Thu, 7 Aug
 2025 16:37:02 +0000
Received: from CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953]) by CO1PR10MB4500.namprd10.prod.outlook.com
 ([fe80::f005:7345:898a:c953%2]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 16:37:02 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, dwarves
 <dwarves@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [RFC dwarves 5/6] btf_encoder: Do not error out if BTF is not
 found in some input files
In-Reply-To: <CAADnVQK38yk3XO9cebrXhMUSK10bH2LVPvs6W4e168x3mGpTWA@mail.gmail.com>
References: <20250807144209.1845760-1-alan.maguire@oracle.com>
	<20250807144209.1845760-6-alan.maguire@oracle.com>
	<CAADnVQK38yk3XO9cebrXhMUSK10bH2LVPvs6W4e168x3mGpTWA@mail.gmail.com>
Date: Thu, 07 Aug 2025 18:36:58 +0200
Message-ID: <87cy972imt.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0268.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::12) To CO1PR10MB4500.namprd10.prod.outlook.com
 (2603:10b6:303:98::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4500:EE_|BLAPR10MB5090:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2ed9f4-b087-4572-beb9-08ddd5d0a2d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDdqNWt5clljQXBYRFFWNERGTyttR1BRQlNIZmVSaC91empMQTlkdkFyOXVu?=
 =?utf-8?B?L3Awb1dtNXZhRmJ4Q0luVzFFOTZuVDFPRlB4bVVJaHpOSTRXMm5qZVpKVlpW?=
 =?utf-8?B?dTg2UnBIUEZCUG4welQzR1lRQ3N1Slp4cHJHbVA4NGVjMGNwT0FvUGljN0g0?=
 =?utf-8?B?NlY2TUovRGFkTExxKzdmU2lwZmhRc2NsWHppQ2hSYVhPRnVmWi96byt1VG9o?=
 =?utf-8?B?d3Q2OHF6R1hJejk4a1FncUZoTEd4NE5nWStEaEJtWEhQdHZVbHFEVlFVVnVw?=
 =?utf-8?B?VTRqSzBlNmZyR0ZVWFh5VVplZytBanIrTmNFTkNVVDdyc3VSMittemV6V0RF?=
 =?utf-8?B?Uk5pWWE1SWszdHA1WWxFejdDRm13a3FqRk45b3RKUXdFNVhqTXpMRWNyczNH?=
 =?utf-8?B?cjZHNER6ZFV0b3F5bk5NV2pUaWVMbXdoa3I0MWdlOGUwRExRSVVjTVBqaFhs?=
 =?utf-8?B?RmRDNkd6L2E4YXhjWFVFRzZsR0dURlRMZ3pCMmlKdmhYUlRUenByWVkraGha?=
 =?utf-8?B?MUZOSU1oa0hBaWRybEU3R3ptdDZuTmhZQ0FCUXdTdDZyUGpWS2x4Smtrd3k1?=
 =?utf-8?B?Vy9aUEJWZFdnVlNUdnhXVEFMb3J4cDRTN283dklWazdnQ2NSSlFaUmRyS3Uy?=
 =?utf-8?B?SW10VTllQ09UTERWVmpDUzJzYzZDaklkWmsva2FmUDd2Q0R5UzN3bHoxZDcw?=
 =?utf-8?B?L3VMWjN1VTR1Q1hyaWZGQ1BGKzV6S1NNUlRCMGNqdmtwUXI0OGdWcUIwbmRs?=
 =?utf-8?B?MTVzbXJzN2hWeVg4WTR5NEFjNkJCVnhYekxlWlptNmd3MzZFelNoNXA1NUov?=
 =?utf-8?B?bG96NnZHTzRNQjIzaTlUdjdIYk05YTJ0eEcxK01RMFRnTkROZHlqSUhUdHJR?=
 =?utf-8?B?c2ppSzNST1FwaGU1UTdhWTJBRUdwWXIySk9JcnluZEFvSnpVeDYzQ3I3dFMz?=
 =?utf-8?B?eUZrZ1ZMVWlWenVSUWZYa0s4VEpSdUdPa0N4Q0cyeEkxaEMxeDMzaGVsRW5R?=
 =?utf-8?B?TmtWcHJUd3A3cDBPT1B5RUU5REJKajBOMFhyR1FXVWliTFI2NmMxMGl2UmJl?=
 =?utf-8?B?WVVXWkNLTHIvajBMSXN5VHBFRzRjM3BJWlRBMzB4QTlZb1pDZ0lBZXRRODZZ?=
 =?utf-8?B?d0lzSDlZQ3lBNnRucTdVVmRndGpjZXozd3FIT3Vod20rZjFTR0RNT2hKemJm?=
 =?utf-8?B?WGI5ekV3a3ZPNTRsRi9vN0s3YTBoT3diNGhlREhCbUdodUhIMENHa3hUTzl0?=
 =?utf-8?B?Zmp1aEhDR3FqcGJ5b2V0aW5WS053eVBCVXNUMWloR2FKTEF4cFBMOTROL21Y?=
 =?utf-8?B?bDRjRnlxWHYwSDVtbzJ4T1pQOHVEUUxyZ0k3eHd4RnN4RlNXYVlOTEJJTThE?=
 =?utf-8?B?ZHJ2dXg3QlFHdHgyWHZIZTNkRW9jc2IxODl6UndOYXcwL0JKdGowSmhWTzh0?=
 =?utf-8?B?RGF6TU9NOENJcXg1YmxWZFgybSttUGtSQVJ4eUlOQ2FxbWdKWFZoVnF5UWds?=
 =?utf-8?B?YVE2NTZMejFiRXF3dnFKQTdib3JkWElyK3MwTGZhWXN5aWZFOVJhcDdMTG51?=
 =?utf-8?B?ckxEVEI3Ni8vaUFtVHRvY0xoOVQxc1MwdTZqTXdRZG9yTW5TQXRHL0xXNHNS?=
 =?utf-8?B?ekxCemh1VHVvNlUzbmROS0xkMHdieFI4WUlLU0Q4eklHM2RDSkN2L3kvS1RX?=
 =?utf-8?B?a3FacUtxdkU2T3VacjNNL3FiZTZnV25SN0hpOS9XQkxZaURPTkt0Nklmb0FW?=
 =?utf-8?B?bTFzTFFGWkFiT21TYzFaOWkybCtIdEQ2VlBjdDB5b2J6QkF6dXM4YVNxK0RE?=
 =?utf-8?B?Tkd1YVg2RE1vclp0KzhDSitpU2EyZWl2RjlrVFB0NXBYL3BEcGdvbG40b3FG?=
 =?utf-8?B?ZVBmTE1GTktiN2RQWVNmUFB3bG5RSW9JR1A0UnVJaE5aSnhkVklRZEZ5dW1I?=
 =?utf-8?Q?QgdpwFzJEp4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4500.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1o1QTYwNGFucjRlaTVNTDlLNWxnT1lkb2o5c1B6Vy9SbG9ZMDgzVDlOQXIx?=
 =?utf-8?B?TjZoV09MU1U4dG1BcGIybEkwOWc3WWUyN1ViakJGQWp1ckprZzBtRTdDUzdU?=
 =?utf-8?B?eHFqTVpSZEhGMUNxS3hPODRFQUQyS3BiWWxEcVpKSlhVVHZlUFV5dElBa0l0?=
 =?utf-8?B?S3p4Nzl1Q3NGYmtWWHc3WXlOdldqejdiZi9EQ3pIY0NveWVjakswVWNPdmxz?=
 =?utf-8?B?NXZ6UlQ2UFNxUndOdVhxQ2h4NmZkakZCS05GQWtpTTBhSXBINE9IODJDVjJp?=
 =?utf-8?B?THhtZkVWSE5EMDVSODMwNWVjRkpRNmdVeENNMlN5UFJ0TUlFaXNhUm9WS0pE?=
 =?utf-8?B?TG16UXBSalFyNndRSU5sYWh2OE1jYjVrYnMwbHQzWlM5emJqNFFVUldGQ0t2?=
 =?utf-8?B?a2JVcDZDTVpZSHNGMFZheGtFa01YWk41NkxzS0VrWjBESDN1djZYN0VxcTU0?=
 =?utf-8?B?NFQwYWVSbVkzVGlQa21rVFQ0aEpjU1dGVDQ3bmd2MWkzTW9pKzRPTjlBQmtP?=
 =?utf-8?B?cUM4NlJ2S2JMUnROK1FQSEp5V3luM1hRWnlRWVpxTFJHVTJnbXJkWm5sRDJv?=
 =?utf-8?B?TjFYSGNxUHNLc3NSSlVVYisrTTZYdDRkOHRZQ3gzQU1kT1c1aUxFSytmdHVH?=
 =?utf-8?B?ajBRU0VMbTYxRm0ra2JBSkZyRG1KSkFOZFJieHBhbVIwOTZ0azRHRHY4VzFs?=
 =?utf-8?B?VHVMVEl6Y1grVHRJd09kcENDMHNBNSs4a0NKaHNkMUZFckVWalYwTndTYTVv?=
 =?utf-8?B?blNDeWtpQWs4cWRONE9CeFhuUlJGZ3NLdVA0Z2ZWaWVIR1h3ekREV2dwVmIr?=
 =?utf-8?B?MTVDYllrWTFXVlQvNllEZjdYU212RlJWREIxS3pvVlJsMG13amdyMjdIM1Er?=
 =?utf-8?B?Y3Bia3VaOTBEWlUrYVdUWFdicGhoNVprcWI5SjE5L0xlaVdiK1hRTjloU1pv?=
 =?utf-8?B?QmxtOE9yanhpcEdFQ2JXVndRRVZPR2FRb21xT0xwTjd1RlhOMENRdkQwUGdX?=
 =?utf-8?B?WGpoZHJrNm1XblJRSnJWeDNIR3RtUmdVTjVuUmEwcmgwcE90R3JaMHBFQVF0?=
 =?utf-8?B?UVJwU09OWFhpaUM5UUg5RFhKU1pFUzZTemNiNUxnbGl4M0tmZ3FodmhvcTNV?=
 =?utf-8?B?VTdPaFkwVkFNaHdCS1lNV2srRDloeXFuZGlGQXNYZnJVNUtET0trQXlDMmlE?=
 =?utf-8?B?eTZTOWlnR2xmU0c5UkFIVmFWVHFJMDlENWtQYjFSeWd1cklCZjQyY2FNL3Y5?=
 =?utf-8?B?TUdVUU95dzVCTUVadGJiY290eVVWd0pJMjJyZ2t0TGtja1c3V2JBbzd1bWx4?=
 =?utf-8?B?NW1BRGoxNVZIdlpIQnpnY3JWNVVYSmMzd2drbWYxRFdwMEpoRFdaQ1hTV0sr?=
 =?utf-8?B?SEU1NXo5MjlGTnJHZ205UkFXM0txV0ZhQ3ZmcnBCR3FldiswSy9zSzFmWWV1?=
 =?utf-8?B?eVMzanpKNy9kTmlvOGJIZVJOMW80aUtLYVFidDU5Yk9UK3lCdisrTDBGcndz?=
 =?utf-8?B?TUYxL1Rwa1Z1eHlSYW5ITGR0a2JZdzN0emwyRHo3ckZuaUhoeVZuYXB0N3cx?=
 =?utf-8?B?bzJtWmVlUzBBdEFNMlMxakJ4QngzL1JWYUhQejAzejVWTHZUL01HOExjeUV4?=
 =?utf-8?B?cXJpNXV2cGRicnBWemMrcndUV3R6UXVnMkNxakNBcWtrcHZzNCszb3RPZ0hz?=
 =?utf-8?B?ZitrOE1BVndOeGZGUWp1eU0zSVlwZ3k5THFDYWUxRlVzS01TSHFqVXllbk5q?=
 =?utf-8?B?dHAwTmdrbjRWczdvYlBpTHVnY0JRdFN0OEtNa1hNajEvU0dxeDg3ZnVlTUd2?=
 =?utf-8?B?bTNWV1k4NkovZnYxL01nM1djaVc3eEgvd3BzZkRiTVVSeGRrMzlOdzNwT3F3?=
 =?utf-8?B?NnVWQy9WU0M0YU1iQUZGMmdMR2JyaDMvNU50YzRtbEtkNkJoRU5lVzR0Uzla?=
 =?utf-8?B?WkYzNXJ2RzFseFBEc09nY1lraTRISVo2MFVzanJZclgvNEtFTGVnTDV0NFdX?=
 =?utf-8?B?WHdjb0tpQkQ2L05ZQ1czK0dKMG5YUEdNUEpZMHoxSHlzdmhXQ0FpL3VPOGtJ?=
 =?utf-8?B?ZmxvWlVWRW9VTVppT1dWeFVGeVFDamxTVHhkVG1CMGdxc095THgvSmcwOU5S?=
 =?utf-8?B?Vmd1ZjcwZjZxZm1vUTVPcTkvbDFLQUFic1ZqZ3p5eHNoRGYwdVlHaDR2WjdO?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gGn/MRA1QR7M2nCtSszWi/mxoSlj9zQ+/GsORPU30bpJ7Ki/kYtHXtkfMHOrwKuTRBUZ1HV+2LVaFr7SibdMmSLxfcQghUKHsO/buOy9pwmAt5BDMAux6AXKkaTiU/7Pl9IN6Iikd1nEeSnoRvDfo/lFSX27KI7uxRgB6hUCCoobccPmh3XpHxZjjIhEyyzc8kbNBgYogda4Uzi2v1gW/Y3nfy6/7+4qllqN5oQcHeVRUhJIu2BpfAfss6RwG8yZ5JlD/NUIaZ3TU3BOeyeHOo1ycNfG35FrCSCsPtxmYb6KrhC+TqT9zKhvCyl4Gwl96JarBmevTL8xJfnDvQBHamvPPQMVyAV+KZbHo5UkLNpI1HMqPSVWDQ++FvfqVu+tYXofayWfPXvU8YGSXTJJJyqx4/MQS+JmuLRX+u7M20fBCo0Up7eifCcFkBCvpH4E3WcEckYroGXbQ2Tp9qboqDaVPfeGnVReom8pOiUgScDMCcTQ/jRlbbKvkD+j1Z0xNrgYLsRj52b6872ZtwTQfny7bud4kl5mR1XjqdXJLLu++jHKtqIez7MnoI4Mpv7V7HsH7x41jfWnbgAe7KWllWcxxmtbASnnn1ycee1fxiA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2ed9f4-b087-4572-beb9-08ddd5d0a2d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4500.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 16:37:02.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZC5+2WMjq6VFzdImRcU4Ojy+ZebTRoRTsc6CnDP46wS7LiicDRLe7/3+d7WfQ9KfllGrDvcX1BSEek8xu4VUAtoQX8d1Ja3c4NofqF90Se8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508070135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEzNCBTYWx0ZWRfX7v9YNi4ND1ex
 zhub2NKVx/H/lT5pocJwLuHXq4rY1HEbGU8NduVL3cHTFYmhm6rF4sJlEu+Hogclkr0+B7ZXYFP
 OHeZGKUtmUjQCNwYnH0yIFkSw5GwZQBZBr7tC27ozizw8+4D1ionkTCZhWgCTmv7jzUmdxA/v+2
 30Y9kxk0x9nPNK0O/IzowFung7CLD8OG9Q1CdFE828/Iq3ErbF4gIuJJ8K+FJYxkcvGMiZBA8g1
 Fh/cdaG6tmmAIX8H9BBMlso1q/wr/uGhBlQoZS5OjbLuVwrRcj0KZhEShBloz/2lcSVbn9FysTx
 CPtavHWLxigiKRd8MF1r7Ce8+dicPsEDrSMfY6dIpT6b6WfIe21WdyDi0TeTgr5zJ/PoRG/da7n
 /cmt/klCYufWRXfRIPrZaA6RXEV9jBgGCLynbUAE85mZHZbBmXH+o05uYeCZ6Nc1PcdjvlUL
X-Proofpoint-ORIG-GUID: Crsww6MG80WH-vNAWajOfC6OaYX6aUXW
X-Proofpoint-GUID: Crsww6MG80WH-vNAWajOfC6OaYX6aUXW
X-Authority-Analysis: v=2.4 cv=Hpl2G1TS c=1 sm=1 tr=0 ts=6894d633 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=PBXSyQl6t6HQkZJ5:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=mDV3o1hIAAAA:8
 a=yPCof4ZbAAAA:8 a=GtM61V9KvZWU4nbbv6MA:9 a=QEXdDO2ut3YA:10 a=Jm1mEQp8cQcA:10


> On Thu, Aug 7, 2025 at 7:42=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>>
>> This is no substitute for link-time BTF deduplication of course, but
>> it does provide a simple way to see the BTF that gcc generates for vmlin=
ux.
>>
>> The idea is that we can explore differences in BTF generation across
>> the various combinations
>>
>> 1. debug info source: DWARF; dedup done via pahole (traditional)
>> 2. debug info source: compiler-generated BTF; dedup done via pahole (abo=
ve)
>> 3. debug info source: compiler-generated BTF; dedup done via linker (TBD=
)
>>
>> Handling 3 - linker-based dedup - will require BTF archives so that is t=
he
>> next step we need to explore.
>
> Overall, the patch set makes sense and we need to make this step in pahol=
e,
> but before we start any discussion about 3 and BTF archives
> the 1 and 2 above need to reach parity.
> Not just being close enough, but an exact equivalence.
>
> But, frankly, gcc support for btf_decl_tags is much much higher priority
> than any of this.
>
> We're tired of adding hacks through the bpf subsystem, because
> gcc cannot do decl_tags.
> Here are the hacks that will be removed:
> 1. BTF_TYPE_SAFE*
> 2. raw_tp_null_args[]
> 3. KF_ARENA_ARG
> and probably other cases.

We are getting there.  The C front-end maintainer just looked at the
latest version of the series [1] and, other than a small observation
concerning wide char strings, he seems to be ok with the attributes.

[1] https://gcc.gnu.org/pipermail/gcc-patches/2025-August/692057.html

