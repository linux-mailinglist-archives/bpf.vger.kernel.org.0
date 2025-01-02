Return-Path: <bpf+bounces-47743-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B49619FF7A5
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4DE23A1831
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFED019DF98;
	Thu,  2 Jan 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AmUsfm+2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oQPokpdC"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686511917CD
	for <bpf@vger.kernel.org>; Thu,  2 Jan 2025 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735811272; cv=fail; b=B+dtATJRiCAL60NysiTC3VG8Q9mpGxD4t/Idx7B7XBC/T5EdWUte+b4dFRy1eGd+lY0pO+cnNAj3nZD5T1zWjqs1AAStGFJu5pF2V+n1SY6P7Afg0guqcTW50KM0xKgsR3/BSgmM7W6BHOozqsrKC8xtogYFnLQsTzjkTOjLulM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735811272; c=relaxed/simple;
	bh=M5tXGC0yYQl0d7uyT/BgOrj1NmTzdEEyev03eOow5kY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=UWn/n9OqggNbh4cII7wYAk6zUoDOhFBfossUVcq/QkjITujUk+9B2O0OYcQBOvtU6phx5Nb93oU2WsO38GifA0Q9zGmJqAyE/I9OeYhgC9kdDUBs+7tYxSIKE2nT80hqmRD184aVNWqpxFzphYQxO1HBrOhkzAGQAETFjOpT8jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AmUsfm+2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oQPokpdC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5029fw30015143;
	Thu, 2 Jan 2025 09:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M03wGlNCgqYOKYHVgkwKbtEW6BwfVBIWNo6h0FrBphg=; b=
	AmUsfm+2klnAa9vMiJh3WmyqAlPX6eDXf5WmweP+Q0RdgP4UAzEdGH0y778+uVvg
	ezZtyGjjEXpnJgi1ew7bxvKytgChOMewAo3Jb9EWcWSRpQDi1ZbAhWBKUtit1JRV
	jp9izCy79tVQCTWdpTdP6Ul2zbCkZZAR8v/1Asb6J2EqK9NAIpgPBatpl6uYrPbq
	0XCBrC/1ykDQ1arshEENjO3vn4MhMMSLdACn+CIAvQK5iNHO+2jn/1CgG3w58ctW
	FSDsiclmVbwr+sfurBdElmfKenEGXQmtnZPCZRa8YUEpIqH7G+Liukvkhpvt8Yu4
	z7RBd3rvqc/XUKsD2YdBkg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t978n1d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 09:47:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5027s9t7009153;
	Thu, 2 Jan 2025 09:47:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43t7s8mkrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 Jan 2025 09:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD0tij66K8cTJuQ9XKWPDm97yJOKkbYzrtPrFnntERiwcSWiXKwVyqXZwRJpb4nZmmB/BE0AEEf+SL1A6VpKwQuaoQ/GB6qM974O3XS72kDiEuEvP8L6MNkadTAvzagwR2oZyNbxnMzOYQU5qd3tkEm5nxRw6UZoVdv9DKWYjDbim1F0MYwcOzxIzZMSTrm0X19h5oVy4ezJuRWARNT6V+JuVse8P6fKJFyn0y1bZJzrnElWVdQX/iXErmPiaoLEyj5lMKliCdfifHgHRZUIxK7YZGTQv92+2X/12UIfmT3IOHqD5cKerf3BXyFPxpgxXxmmYSuzBUxTq7v9XpewaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M03wGlNCgqYOKYHVgkwKbtEW6BwfVBIWNo6h0FrBphg=;
 b=sxI38Sg41Q5jPMA3fPYuctE7MTqiDoUeVlr+iOs9BdrtF4y1JA39E6oVfgRcYtXYs7lb42lZpmkRMiy/unEdAnDfkgJtaE0UmjXHApNOLClxuopC4XcOxKpx9eK0xWo2TB9c7wl1JejxP56UtbvL7YdGKdgeAZfqCAz+vUhFRg7Mbgdz+3NIDCuG17SkkWYkLNUDUf67KANfe3h/6doo/yOu4sJH2DIH/6E0++89knLZimPB11c+xlGy1Go7tgjdNxobBdwaKlKDwGZPxL41CPEer3PLK5Iu82SaNIDsIYIQejTgnOFLXikFABDNAmkJtDrvEgEYZyk6z96C5xTeVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M03wGlNCgqYOKYHVgkwKbtEW6BwfVBIWNo6h0FrBphg=;
 b=oQPokpdC3s5MVt0qeJtTxrW99i+zNxodwJuabO/tvF1nIrPBJAXF6T1i+Sm2MBFqCzrwtQ20VDVgzwW97MIpl3FSXKXx6x/RDRfAlxsuYhg6TebMvWjKMbPC2cG0e+UQfqi8BLXpMILaj1Hja1h3sbLZ0aURQcPCk93agD02aYU=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by PH7PR10MB6276.namprd10.prod.outlook.com (2603:10b6:510:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 09:47:15 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%4]) with mapi id 15.20.8293.000; Thu, 2 Jan 2025
 09:47:15 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>,
        Cupertino Miranda
 <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Manu Bretelle <chantra@meta.com>,
        Eduard
 Zingerman <eddyz87@gmail.com>,
        Mykola Lysenko <mykolal@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
In-Reply-To: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	(Ihor Solodrai's message of "Mon, 30 Dec 2024 20:08:37 +0000")
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
Date: Thu, 02 Jan 2025 10:47:12 +0100
Message-ID: <87jzbdim3j.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0550.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::20) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|PH7PR10MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ae5041-ac99-4de4-9d9f-08dd2b12707f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHJuSWNrbDdIMXI1YXJ4MHFRVnFwNFAyd1k2clRFaVFwbnZjM1N1cEh2OWhP?=
 =?utf-8?B?enlwMDMyVzcrR3o2ZHZmMWRuSlJuQjV3SzE0REhjY1Y5TnNXTFpIL3dMMVlk?=
 =?utf-8?B?OXBqT1UwY0c1K3R5TEVMeHFFWTM5cHUra1VSNEw2S3FYWFVjZ25lTmFNYkpl?=
 =?utf-8?B?NGpSUm8xajVYNWhWOGV6bE9Qb3ZPa0hwVjR1bkc4MU04ZmRjcjErUHk2OXNq?=
 =?utf-8?B?SHJqeCtJLzFwYkM3b2NLbTNjNEM5ZEt6RWordG8reDFwTXJYd1hhUTJaYmt4?=
 =?utf-8?B?eVE5anRidFhpaHhHcUN6WldYYTc5MDVXYUdjUVZsMmc0RHRmNFdEc3c2Yzc5?=
 =?utf-8?B?bVByTXhiTnJLZWg1N1p0VUFZNnJsZ3pJTzJRVXlWZXBxU3Y4QjJGQXlnRnhZ?=
 =?utf-8?B?bm02ZHZtd3NNODBHY21aWDNoVkhoV3VVRDIxOE5XMUp1a1F6VVdMeE1EekNz?=
 =?utf-8?B?Q1d5WVZvMkRGNVRUMXNvbzVYa05Ncnp0Z1hZQ1Rtc2NEWmNheDZydld4U0I2?=
 =?utf-8?B?N0xHR1VWVU10QmJmTWJNWXlxNllSaG5sU2VTRVg3NGwvV2hHL2NaT2VuNW1P?=
 =?utf-8?B?UWtpZ0hBbWdwNzBKTEF6dEdmTnEwZWFHcDhGNkg2R0V5OGdtNmYxaEd2MW82?=
 =?utf-8?B?QjE2amw1c0dOcDBVM1N3cVRpdVFsRzRoMzdBU214ZEE1Uy9HTHRHZXdhK214?=
 =?utf-8?B?L0U0bHRRdS94YnhLaG1LNmVrbVQyZDA5VzNXOVltVm9Sd2lXaXY2RklUazVK?=
 =?utf-8?B?Q1ZqNWFQalhnWCt6azNnUjdGQklEZHZUeXhxRXplZEMrWjZCMi9MVkxYbmZp?=
 =?utf-8?B?OUNNSEdqK3Iwb0JkZTNBSGEzbGl0QktXbVRCKzR3blJZSkFIcnJvUWpTazJC?=
 =?utf-8?B?RWZhaTlKUTI0UGVRaHNBdGRhaHR5N2t1QTVwM2JHMEJ2MERqd3oxWmRTTjRo?=
 =?utf-8?B?dzU2dmlWZ1NTdHNpazhKSTRiMTV2QUhKSEgrdkZWY1Y5K1ArZTlLTWhHTnZk?=
 =?utf-8?B?dmVHVnNPNDZkc1ZaY2hDVmk4Uy9kVVhoSnE1NHFrUm56VE5DUkI2TTBPeWtr?=
 =?utf-8?B?bXRCWWRVdHdXb3M4Wm9neTNKdktWYlJJeGdORzNmVFlKa1V0QWxWRkxMQ3F6?=
 =?utf-8?B?akk3VUNpMEdHQnN2UVJDNXRpOEUzVHdsSXdVQU5zRmY5aTdMRXQyRjk2eHpa?=
 =?utf-8?B?V1o0MVQwOU9QczFXemVDZjNYRVF5cXQ3L29UT0xmUy9jTFIveEFnMVp5Z0VU?=
 =?utf-8?B?ckl5S2NYRWlYMjFtNFR6RG9XbVM0ZWU1OHZsekxZdGxYMUtCRTVrTFpCMGY4?=
 =?utf-8?B?VXJSZ2tUK1oyQVFPR1R3Y3BtRTdRci9qSjE0UGRFemkyT2l5blUrQyt1UFg4?=
 =?utf-8?B?cTFkdjN4bTNCd2Q0U1VOZzVyTnFkcWpmYmJLaUpZcG9DMWg3RmRmcDloS1V6?=
 =?utf-8?B?emkxbXdQUlpzZnUwSk56cHdtZk4rU2g0blRGaEsrSS9XNHNuYng1emJQaE1k?=
 =?utf-8?B?VnNYdXJzUEwxbFZNVWliVm52b2V6S0xXRnFZSEgxbXd1eFUzMzBVbmpsaUJr?=
 =?utf-8?B?dXBtQ3I2T0diMnVvYTg3QWhGdk9YVWwyeGVHTDQ0eDhaSDNvVFV2akYvSERL?=
 =?utf-8?B?YS9tTmhNelNtdU5qSjUreHJJc0dDc1NScjY3cUxMa285SndTSld1cFJvWTgx?=
 =?utf-8?B?aUFRZEM2M3h1Z2tBL2dRQjk0TU5yWXIrU3cwVG1lWHdhdE1UWTk1dm12Um5I?=
 =?utf-8?B?c2h2ckV5bTNvL053OU9uNzcwQjFhYVdRMncvYm1QMlRLandtS05aOTBBa05M?=
 =?utf-8?B?WVpKNGxwSUdzUjA5Q28yUUxsOVRUdlBOR2NUd202Y01IWGZBQ3JtcC9FbFE4?=
 =?utf-8?Q?XSAV5pnpE3JY5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0NYSUpBMHNSbnhuOE9RM0NrRGUzYzVrc2RrZzNHWEZCdmk3eFpQREJqV1Zj?=
 =?utf-8?B?a25wWW9uNW4zaWVTV0VrNFVKTHIxU2R2Q0JtL3p4VFBpbnVaek4vTnd5d2Nt?=
 =?utf-8?B?RFRxbnRZSjRTV001T2hSZXdmbmpDSitadndaRW1CanZXbk80TFFFRVI5YnNo?=
 =?utf-8?B?MnljeTE0bU5VSkMvb25jQ2phZmRYVjU5RmxhNjJMTmdJM0tKSzdvL3BRTUY5?=
 =?utf-8?B?eXg3aityQVhrSHQxOE9Qd1FKZlkyMFNxK3pvRzlxaWVET2lSVmg3RjJ4Vm0v?=
 =?utf-8?B?Nm1pWEpvWlhwdGNsQTFCVzNib2xadlNZMmRuSktZMGtkL2ZCbTNkUVJVaGlX?=
 =?utf-8?B?R2J6MU9jcmppd1d2TVR2ZFo5TXZJblFJK0c4ZDJyOXc4NVRTZmxrOW9LTkJx?=
 =?utf-8?B?S1JacjhLWXhIZVMranNxUTFCUzdMd2xSQVFsenJGaHB1Z0JlOEIxTHErcVEy?=
 =?utf-8?B?R2h4UW9vUG5ncks2V2VxaVNNQjNnNUN3bXFiTldJL2JVamRiQ29BWjlwell4?=
 =?utf-8?B?SmNkdGJEcWRQRDdPNHJKYlUya0h0SEVnTEllWURXR0ovUStmTG5SWmNaK1Nn?=
 =?utf-8?B?Qm5iMDBoOFZSb1g2M2c5d0NlZnNkNmp2blpUU2tXZloyalFZZW95ZUpueVF1?=
 =?utf-8?B?N0kzOXNPZi9ZS0hxQm84OUtEaEFPTWx3OWpCWDd4WUtOUTFzTU0wNDlzeGZK?=
 =?utf-8?B?WWZYUkpJbEp3OVloUTB1TDlsVkVjZUlKcWpvRklBenhRRk9TL3hpYUZMYUc5?=
 =?utf-8?B?NFM4MUo5bENoUVJXbklyekZXUjBlVHJ2Y0ZEUFV6bVRNMm9MRDdzczhaY0RV?=
 =?utf-8?B?RnRvZmh4eVA0UG1QNHVxdHBUL3pQOGJQWHFHeUdWWkFQRDVXc0J6djE5TXVQ?=
 =?utf-8?B?SnduVWo4SGxIaTBxTXFDTkthczFkV016ZFJMUUgwSjFFSVZxS1E1WURhVzF2?=
 =?utf-8?B?d3JvRDNSeGE2d3ZXenVta25LMUF2WDVlbGFxUG5pblk2NmhWVlJObCtIRXJL?=
 =?utf-8?B?T1VzM1o0WEI5TkhyTGkvcTg2MjNiOG13TDl0QWl2OFRaVndReVU2a2dkUDhY?=
 =?utf-8?B?MVhzUkcvZE1IcjlCUmlWNnpCTHB6RjJyUzNVWUVuWjZ4RmpWUTR6UEJBSlRv?=
 =?utf-8?B?OS9EdFExcnJvdlpvemNod285OG1relo1V2JuWFIzU2dqbG45ekFIVG5qLzRo?=
 =?utf-8?B?YmhXVS9UL21hdkttOW9QK3FKRWNYZjRWTlZhSkJYeEtRZ3FqVk1OcWNsYWxo?=
 =?utf-8?B?T3dsa3RJTVErSjQ5eUs3QTJOellqOUpIRTd4VXZmd3M2MnRhV3Z0QzlMRUZj?=
 =?utf-8?B?WWlwYlRXOHhFRXNuZ1ZzeHVNVnFPaUhTd1FJdW05djNRR2dhcVNlZ25oeDlz?=
 =?utf-8?B?YW5OVHBNaVdLcGpoTWkva0Jtb29vNXNjTm1UMFhEeFc5WXBXekRVWkxzeGpo?=
 =?utf-8?B?L2U5UTV4SGhLNjRsTTJJZGFrVk9paHRFWndhNExIbXdaQU5mNG1hU0d4SCt3?=
 =?utf-8?B?dzZZdC9aMlJKVEszMExTS2s0azl3VjdNWWtEZEs4QmZLNkkxK1k5Y1E0NUR1?=
 =?utf-8?B?SU9IRXhuSFNhRk1VMUVSQ1ZKcFdyeW5pRk1mWFo3TXdvUjh0eHFNb1Y5dGt1?=
 =?utf-8?B?clpFeWVRVXlLUDgvMDhnWFUvRS9YL1JpRjkxQm51dFg5Nzh6WnFkVE1CTEVG?=
 =?utf-8?B?N1pmN1JsVXhBNTZvT0dvVkRYL2FhK0tlVnRkVkkzNm1IVW5FVGVpSkRTQnI1?=
 =?utf-8?B?WFRCWlY5L09GOTc4V2VCU2ZERFpVT2dhSGl2N0QxZlVlZjEvVGZBSmVIcnpH?=
 =?utf-8?B?anJVWmlLZEFOZzZsU3BiYmFidmRIVjUvOTBpdFNjVm96bHRWam5XbmVzNGIv?=
 =?utf-8?B?RmllZGFjMVJSMC80dWVJeHl4NFYwWFZ3RHRsaFZHZ2tVejE0aGozOG1nK1hP?=
 =?utf-8?B?dVZHbzJRZ1hHcWlrZHRQSGEzaHJQRFVHSGRQSmdnQnEzTVpTUUwxNGQ1S25v?=
 =?utf-8?B?TCt3YkVmWGRSS3JZNjVXRWxuUjF2dkhmb2Z0ZkRvRjNsejRGNDViN0I2Uit4?=
 =?utf-8?B?U1Z6bkQ1Y2JaaTJhZ1VmL0dSSXZQcVJoSFVETjIvdUQwRC8rVTF2YklzeEhy?=
 =?utf-8?B?VGd2SnhkRmc2dEQxVlM0ZFlzTG42cjVIc1dEVzZrdkpnMDF0UFoxclBrMitj?=
 =?utf-8?B?K0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MepJBTHYBWv0l3dA5dDzD78k54P566lEZAILxyuZi9HQi6JBbpNfiRkgO0mAI1sjs/5pCVjWwtWKI4USNiVyKF/yyYPNl91L8EV2dY6Jq6FWX0Q8/iUSuoF5sf5kQtl4mi9If6QZ4q2TIM1OPfFH+CzUttiw+FDWFBfWzTby9AC6q7LbGmiM+ERZt9KCZZAFl/YD8aD7LGCyNV8EwXMDlFm5Nhg30wBN/mEDrV7O0PvSKSi2FpAVlKYRrJEalAx10KxYHAc3BTnC+Fym/tCReAvQJNmqsCogNZhOa0fMoJu84AfV4rOq1BFwsYu/ljPkyVWIDc39a3wFoyWdhpIUi1G/VB+75K6Bfofof9YzACr/tovuiu3jBw10seAw1aPJwE9y6QKtqpvsc6Cnj2r+ZjGLKUhI43moFuQxuGLzF8JTTBrbHzVOdddHM8ERoogYgc2i4dvSwl0dEFDBWDyD0O02jen/o9xaGyF5T+SvVLn9Is1UOIiH6NEQB6HyD835wmsmgtAnbWiRXlbWIVHRXMde3uFit1E1QCiVJGqlmmFaWy9EQP2iPT1iWsJkhKxdXI1bHBdC3Yq5mRYKNshT+3FvN2M3/OdkbOBhK7SxiF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ae5041-ac99-4de4-9d9f-08dd2b12707f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 09:47:15.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UponM8jyOc4+meWVoO1DJIDGG0v2IPVmLY9W8RKuJ6BLbjNGTe/pRZ0MDNSr9NXFrZXaETI8zKqazOafT5YkSOsP8ADPkb7EWg+R34RlsO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501020083
X-Proofpoint-ORIG-GUID: OHn5Is9SUbh_bJLkqYyGtJKbq2NWnNTq
X-Proofpoint-GUID: OHn5Is9SUbh_bJLkqYyGtJKbq2NWnNTq


Hi Ihor.
Thanks for working on this! :)

> [...]
> Older versions compile the dummy program without errors, however on
> attempt to build the selftests there is a different issue: conflicting
> int64 definitions (full log at [6]).
>
>     In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                      from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                      from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                      from /usr/include/linux/if.h:28,
>                      from /usr/include/linux/icmp.h:23,
>                      from progs/test_cls_redirect_dynptr.c:10:
>     /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: error: confli=
cting types for =E2=80=98int64_t=E2=80=99; have =E2=80=98__int64_t=E2=80=99=
 {aka =E2=80=98long long int=E2=80=99}
>        27 | typedef __int64_t int64_t;
>           |                   ^~~~~~~
>     In file included from progs/test_cls_redirect_dynptr.c:6:
>     /ci/workspace/bpfgcc.20240922/lib/gcc/bpf-unknown-none/15.0.0/include=
/stdint.h:43:24:
> note: previous declaration of =E2=80=98int64_t=E2=80=99 with type =E2=80=
=98int64_t=E2=80=99 {aka =E2=80=98long
> int=E2=80=99}
>        43 | typedef __INT64_TYPE__ int64_t;
>           |                        ^~~~~~~

I think this is what is going on:

The BPF selftest is indirectly including glibc headers from the host
where it is being compiled.  In this case your x86_64 ubuntu system.

Many glibc headers include bits/wordsize.h, which in the case of x86_64
is:

  #if defined __x86_64__ && !defined __ILP32__
  # define __WORDSIZE	64
  #else
  # define __WORDSIZE	32
  #define __WORDSIZE32_SIZE_ULONG		0
  #define __WORDSIZE32_PTRDIFF_LONG	0
  #endif

and then in bits/types.h:

  #if __WORDSIZE =3D=3D 64
  typedef signed long int __int64_t;
  typedef unsigned long int __uint64_t;
  #else
  __extension__ typedef signed long long int __int64_t;
  __extension__ typedef unsigned long long int __uint64_t;
  #endif

i.e. your BPF program ends using __WORDSIZE 32.  This eventually leads
to int64_t being defined as `signed long long int' in stdint-intn.h, as
it would correspond to a x86_64 program running in 32-bit mode.

GCC BPF, on the other hand, is a "baremetal" compiler and it provides a
small set of headers (including stdint.h) that implement standard C99
types like int64_t, adjusted to the BPF architecture.

In this case there is a conflict between the 32-bit x86_64 definition of
int64_t and the one of BPF.

PS: the other headers installed by GCC BPF are:
    float.h iso646.h limits.h stdalign.h stdarg.h stdatomic.h stdbool.h
    stdckdint.h stddef.h stdfix.h stdint.h stdnoreturn.h syslimits.h
    tgmath.h unwind.h varargs.h

