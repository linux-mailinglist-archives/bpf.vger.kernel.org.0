Return-Path: <bpf+bounces-21527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D9984E8B8
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C84B2D5B9
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA00288DF;
	Thu,  8 Feb 2024 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nB6WuH1M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lG8+3Xle"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC96288CF
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418801; cv=fail; b=pdxwo1b6p6fE+K7vANST23pz4ZRaTVckIic9wsdjsvh847oJC5kbfqc7+OMGYWQYa/mgTZ8iCWLLxzqdSNNdZs1Dmq9LGO8uPy7Qn+c17Em+KIcpZLlJwoPPCLIYpyCRqglFe0aVjUXVbJGiwyrKyPIt6SFe9puSCY91/u8lDlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418801; c=relaxed/simple;
	bh=pmw30hJREwVg1l/ODA64ZpvI5z1cvpj4fMD7rmF7G88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=Y3cpI0NxBMXSDXH7e/2+NxhwjW2s+XftBQzuG9EO0GZ99MkwW8GPxUyCzGVVZo4qFAO4hCfICrMhTYngrNecSdCK5yBuS/G6/+tTmCBnTuJAXDEkRpRMZdLCWbDFzHbf3iyDC+CrrwadJtdoCSSfcsvuZbQ7NvEuJama4rbblvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nB6WuH1M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lG8+3Xle; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418IxMls020583;
	Thu, 8 Feb 2024 18:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=QyC643PEWWdkOQiAtZYVC5lYr5PSyH/qT1GmqujvHwY=;
 b=nB6WuH1MKoByT2qKXo/5Yyh3jMmYNoS4gG2e0TclugX0ncseadfRzFyzimzdMHtyh31N
 rGe8B+PTZAdh/4RYyktEaw7y+lY3f6qRqU1FzQyPjTvuHKeXxmqrSBr26xC4a3ltok99
 42r3GvOd1918qD2U0IEbI5IbxiG5jbdELDdBbKQADsWGmBgPSqXSq4EZJqvT4zBQlIDF
 eiMnQXG7JTl3mLrDKfyuYBI7k1lstHnLEWeUSdZr3EqEFx6oKDBcllHB0Ky5eWIbvBFb
 gLPGpzMXAty3SKRjLGc2JPRpUKjN/jIucm/7L6F2UTgcKBBdHbcnhJpLhrnlgzZE4PBt YQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1e1vdh6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 18:59:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418HvLXs039499;
	Thu, 8 Feb 2024 18:59:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxauk8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 18:59:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azoqbzUh//n7QDbrsQpH5ROBcQ8sEKgvKrpfGyKABY7JOYVWOxtvNKFmh0X8W9GdgL19hf6FajiFd73/9geHL6edv6CCSEHAVRk58NmT/zTUv4GyOFhDQpHH7MuyteA09RBYvOKw1h1hl7Mw8nmhet8jMf3mxHmt1cMYYoxIky54ha1TubtPJMJOUSDHNf3IHTLPtYEgmLND4xqZV5BFQvs7NkEDTxkqcbL2vYPxZnEHRNuVHQwE7xgg8bzM2SBjG2h0B2sIXVmVnopCjTAmecHPYjJEpSM/y5Nk9yGZiTYPGvOVy2YtQGzAxUpeg8EY0jjXEpfi0BvtgUBriqu9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyC643PEWWdkOQiAtZYVC5lYr5PSyH/qT1GmqujvHwY=;
 b=Qerts73emSqCekS8wtaSxCXoa06vD7QkIJxAu/BM+E/VdVDFeL/T1aPd62k2oheHLUvNlGEDLwb7oDQnsfbt3vZRkkZaF4iD0XkTPjJrUBch9lKI4IicBWWkwA7RlSe6wyL3iSLb6hXLQj+IxH8wN8/NP2uxGv5IyNKET0CtsYhRtsUj0Jv20UuU5879NMCQ5G0aYiEzQFk2cVarl7WC46/K9EsafMmPLG1bMmE2ZoTfKnUh2BHBCCoBz0hPC4DfGBMDsslAWPxRvRaJYEyNd6SYCgKU1AB2Nj5+rDYFAKVc++NtSX6FjZ1l3Lz205ytU2gTThcOru97uwi7tX7LcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyC643PEWWdkOQiAtZYVC5lYr5PSyH/qT1GmqujvHwY=;
 b=lG8+3Xle2v7Ltwye2UQ6ZduKMt2YhtoZU8Ys+OAhQ7SyCHxNrai3PokBPTO0oc7E1lS0Il4ufXrmODapkGpi6n5916fFbWN81sRfMBDCrRdzsOii9eqgtedOp0E4/FquvWP8kEWIc5So4tWnx0idwA/xbt40lm7rXLwBejiAcJY=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 18:59:41 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::cafd:c8d6:e2c3:3a1%4]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 18:59:41 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
        Yonghong
 Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
In-Reply-To: <514b171d-8a3c-4134-a0b4-9b6531b3fc38@linux.dev> (Yonghong Song's
	message of "Thu, 8 Feb 2024 10:35:55 -0800")
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	<c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	<87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	<4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	<87o7crdmjn.fsf@oracle.com>
	<eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
	<87il2zdl43.fsf@oracle.com>
	<7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
	<871q9mew62.fsf@oracle.com>
	<8297be08-cd05-4f08-8bb2-5956f13bbd25@linux.dev>
	<514b171d-8a3c-4134-a0b4-9b6531b3fc38@linux.dev>
Date: Thu, 08 Feb 2024 19:59:33 +0100
Message-ID: <87a5oadboq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CY5PR10MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e49161e-f027-47de-eb2e-08dc28d81aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BX6KSOseJBM0Ej3vku7+heQ5qOEGhlnyJ+EPFDS/FeJty6H/XMTVNcSHjSNt1Q0kmdpDAujO9THuPYwe2E3hMah+EXHB5ns1MXlHftsp3RUJY7LZte6ifj5UL3nFkCyz2N2VITeFC0HTVjaDhCgoUm7E/faBN1Xv2GoVKxpDz46IExDFBIcRmd2ZQbgsKGOIpE04sUUp7EkdMEdzfRpqon0mu1+t5pSG9SLTUx45VnMX1RBP58o+1Ko7N3HaOquQG5itGzCCYlnbiMesWs20ePMZaF442Cqz/OjX+30flNG8yp3qoO2EmpHBf5gbF1LsCvA62I9t2JvmNh6XFVoF7mdslRQNp2c+KjQ8KK47E8YzsRhzkkECS/C+6V/02Ix8Y8JvOnZPxGtlEBQn7Y2Y6gHQSW1M3/f6AiUGuCmiBc9zadcyQtTs4ZFhxkYyB4GDGGn8/iIdN7s88ZXGdae/fjqOYutIgCy5lPQTBuF5KchHklxEed0PbKGeP2LcCW1cA/OHlKk6uV2Rciv+zcEVuO/TzMoBwR2OrSB9ilE5ovNLK0j4KGpuRZFimgfykQFm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(36756003)(86362001)(41300700001)(4326008)(8936002)(8676002)(38100700002)(316002)(6916009)(66476007)(66946007)(54906003)(66556008)(83380400001)(478600001)(6506007)(6512007)(26005)(2616005)(107886003)(5660300002)(2906002)(6666004)(53546011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SmZxMTQ1Q1JGT0lTOW5TQWduUUNERXZ5VWRkblZwb3ZTYk1BbkV0eXVuaXNr?=
 =?utf-8?B?ZXpiUXRMTlVQRDdMQ2VKZExZZjRWZjBQVURjOFpqUCtRS00zSmxvYWRFazFP?=
 =?utf-8?B?dGo2QTRLV1dVeGtHWUNkS1laNDJGdDdPcVJxclZhOWx4MHZJbkMrQzQwamI1?=
 =?utf-8?B?ZXRDb1lSMVlNbEd0TTdjaUNqWmJ3Lzh4cHppUG4wRVdwNHNLcnVRSzI4bEJT?=
 =?utf-8?B?bW0xc3lpQldnOXE1eWNKZXpxaXRlSXE0YUljNThyb3JJd1FGQkxJbkdJL3k2?=
 =?utf-8?B?K2d1WGFIQTZGeG16TDVrcndVa3NpV21zR0x4R1AyUFBpWVd0eHM3SHAvWnow?=
 =?utf-8?B?d1JyL2xrWkdxS0F6bHBkbWxFMUdjMEl6cXVmOCtERGZ2RWRSSEdCQkRCU01s?=
 =?utf-8?B?SXpiMUxWbTM1K2wxbUphWm5hVHk1ZGRsK2VTZEFJRHpwSVU4SXhaQVZrQTU5?=
 =?utf-8?B?bTc4QTNtb2lGS0dGTjl1ck1kYWluaHE4S3ZFRjE2eVh3ZlVKL013TWs4TDQ3?=
 =?utf-8?B?dmFramdzRGl3STdMRHh3YVo2UmhCT0hiakdRZ0c0cUlPQ2dBNXNnd3pzYXl5?=
 =?utf-8?B?Q0xZekZoVlY0QloyQjc5RmMzTk1EdXpHeFJzR0Jyc1dGWlRESnVlNXBIV2ZD?=
 =?utf-8?B?c25RSEJsYVVET0N3MlVxSFJkM2M5WEFXY3VCbFFIcjlNR0ZkalloZnN0a3B2?=
 =?utf-8?B?ZHZHVVNzbDFmbWVCV3Bta25RSWt1ZkZ1aHl3WmRrR0RJVDhnSWVLSlU5RjhM?=
 =?utf-8?B?T2FIZEVvTXVUSERQVE10VDdleG1EWGdBYzR5L3RiRGs5YU9DTUVZYkY3Tm5C?=
 =?utf-8?B?QVlPSU5nUzRHeHJqUU5hZDZpallrbmo0Mzl0cURRZVJhYjJWd3lVL0lIblZo?=
 =?utf-8?B?OTN4Lyt5WWpiTXhQVFUzSVgzU0c0Qm1HZjBQUG1pdGwxT0tYVytFMjREdHdr?=
 =?utf-8?B?Sm5VTmdwN2hmbVlMKytvNW12dWVqVGxPZnpKT1VlL21jR3dzejJUUjJlS0FI?=
 =?utf-8?B?SUpXeElhZGxVbkl6dThDeGYvMGhhSUQxYXNMYnRhZUZOY1pVcGNHMWdtQloz?=
 =?utf-8?B?VmtOSEZWa2psUVdQeVNYMXVnbS9VQVVZYWNWY1BtbzNHSVZVWlJTSHIrWXpI?=
 =?utf-8?B?eHk3L0RXOEsrZ0xyVmVLVjVVWUozWjd4bUROVU5JVWpqaWJvYzVFa1Y2RTl6?=
 =?utf-8?B?ZmdTTmM0UUI1bmRXWVA3dlh0aGF5c1dxeXdiSi9Wc0NaZHpjOTUxeXJMOUNC?=
 =?utf-8?B?Y2pwdVN0Ump2Um1selhkQ1Q3dEhpZk5MZjF0L2VYK3JMOFB2Mllud2NZSE9h?=
 =?utf-8?B?N0ZDaXQ0SlFMa0ZGS0NaRWtUMVVBRG9LK2pXL3Fvb1k4YVhhYldUU1FVdUNE?=
 =?utf-8?B?VU11MGtEQU5BQWNBRDNYZ1hDanh0RHoweDN5TnFnMHhNUlhnd3B0OXZDR1dn?=
 =?utf-8?B?KzRjSkFlbUZOZUtSZ2E3UEJBODFOWWdIOURPYW8wcVNORFpkcFJPQUhyeUV6?=
 =?utf-8?B?MDVzUVJFTDhvaGUyMjNWcHZ2TDkzV2JkNEhRS1Y4TGZVeEx5MjgrU2luSkQ2?=
 =?utf-8?B?dUNCZFQvSFRjOGV0T2xRempkVmtwWXFTR3ZFVEljMjVJNGtGSlpvQTFZZDF4?=
 =?utf-8?B?VjkxVk91cVgwS01IS0s0bmxnYVBWcmRJNnNLdCtHeEJLVm9weGtzRlp3aVpD?=
 =?utf-8?B?V2ZaWGFNYTNyRDZCS3NmL0l6cmQzUm5sSEsxU0c0b1IzYm9hQnlHY2xodjJM?=
 =?utf-8?B?b1J0LzhuUjNSM2ZMaHZtQzV4eElEbjlSVWhsTmZXT01XdkhCSmlKa0oydGRP?=
 =?utf-8?B?THpBdURJUHAvRUN4bk9wVExYOS9BVC9SekljMmdJeVlaVEJUaDNNS1hlNVh6?=
 =?utf-8?B?Y0NpUndXaHlLV1B0L1RrZ2IvQWNWWG1jR0MxWVNxdmFkU1FkV0N0YnFaMkcx?=
 =?utf-8?B?Z3pzeE9jQU1XbklqK2NmdHY2cU43WGpzSzZpTFVKLzU2T2Y0N1hkeDRGNWlp?=
 =?utf-8?B?UkpaUi83UjZhYmtQRE1mR0pkMGJVRTZWOUJwaGZGdTJabHBGaEVKL1pjNzNk?=
 =?utf-8?B?andHbUREZ0hDQmcyV2dENSs3SkxPbklGNVdoenpNVE9uZXF0bW0zQ1J3SHB4?=
 =?utf-8?B?WnJ5OGszTklFdndHMFIrNjc5WEQwa3EvWTB1Z29IVWhIS3ZYbWNnam9yVTFK?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lWdBd/EyuiPYY1GwOa/qj2HzOhyGHAyK5Y11WMD/wqAe4gqPHfdQikvz4sNj0UjenornoT9mOOoVdI+1U1GQDeP3K+YMlR1M6RBIrOCJXkdiMArfz7SGeKlQ8PjVpxvkFSKZ3kGxU20paJ8hZItR3YUd7YZ7CWiz7ko+4qqu1i9efNrfLJ6S6m4ZuqLwmOsfAASqHsW+qP1iS2LwwZiNaG6R+IYsM0JdyNQydHI7k/p12UcgwRGhC0yBjTNuCvLRodwnd/3WS3gqyc3fmHMKstpKF7lZ31GCyM8gEYRVEkOz6WeXO1kHtWHqjij28Jl0A1aT4QH+3msYaYQKaJrQ+N/zKMws0sEKxxEv1MMlnVARmJ7b7j8PjJl3P71XOm0/yhKKOGoC7c5y4tkSrFk828RyDhO8JZrNyC9icP+gtOXYuHhJOGBL6S1VCEisrua4zN8AvTXi3QYxpJ9bh9+BHA6OgZLeeGI+Mt8Aag/swkK0buHzV6BGjMEYYgeK4EQ35lBKmARA1jdlzM9xpEARkNlf6vSTy/fii72eNMpZmMwr8Bp0aKdbzxqb1Kst9AG4oS32cQHezlLMAL/8Qpy1uXP5EE1Pt22j/bMXG6Uvh3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e49161e-f027-47de-eb2e-08dc28d81aca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 18:59:41.0306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xmajw+5D8+skRXOnwnYQjLqEc3LBWAenyAbcNJuDCLL9YqQBvhqDPGmV0uhzWNnvb+C+3AHdEmgVPDJrWytoDU3ZSIhulY7qZcVdkqe/eWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=941 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080100
X-Proofpoint-GUID: 9h3om5WPwqnec6KWzAXWLMXNuPwcML0M
X-Proofpoint-ORIG-GUID: 9h3om5WPwqnec6KWzAXWLMXNuPwcML0M


> On 2/8/24 10:04 AM, Yonghong Song wrote:
>>
>> On 2/8/24 8:51 AM, Jose E. Marchesi wrote:
>>>> On Thu, 2024-02-08 at 16:35 +0100, Jose E. Marchesi wrote:
>>>> [...]
>>>>
>>>>> If the compiler generates assembly code the same code for
>>>>> profile2.c for
>>>>> before and after, that means that the loop does _not_ get
>>>>> unrolled when
>>>>> profiler.inc.h is built with -O2 but without #pragma unroll.
>>>>>
>>>>> But what if #pragma unroll is used?=C2=A0 If it unrolls then, that
>>>>> would mean
>>>>> that the pragma does something more than -funroll-loops/-O2.
>>>>>
>>>>> Sorry if I am not making sense.=C2=A0 Stuff like this confuses me to =
no end
>>>>> ;)
>>>> Sorry, I messed up while switching branches :(
>>>> Here are the correct stats:
>>>>
>>>> | File=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | insn # | insn # |
>>>> |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | before |=C2=A0 after |
>>>> |-----------------+--------+--------|
>>>> | profiler1.bpf.o |=C2=A0 16716 |=C2=A0=C2=A0 4813 |
>>> This means:
>>>
>>> - With both `#pragma unroll' and -O2 we get 16716 instructions.
>>> - Without `#pragma unroll' and with -O2 we get 4813 instructions.
>>>
>>> Weird.
>>
>> Thanks for the analysis. I can reproduce with vs. without '#pragma
>> unroll' at -O2
>> level, the number of generated insns is indeed different, quite
>> dramatically
>> as the above numbers. I will do some checking in compiler.
>
> Okay, a quick checking compiler found that
>   - with "#pragma unroll" means no profitability test and do full
>    unroll as instructed


I don't think clang's `#pragma unroll' does full unroll.

On one side, AFAIK `pragma unroll' is supposed to be equivalent to
`pragma clang loop(enable)', which is different to `pragma clang loop
unroll(full)'.

On the other, if you replace `pragma unroll' with `pragma clang loop
unroll(full)' in the BPF selftests you will get branch instruction
overflows.

What criteria `pragma unroll' in clang uses in order to determine how
much it unrolls the loop, compared to -O2|-funroll-loops, I don't know.

>   - without "#pragma unroll" mean compiler will do profitability for full=
 unroll,
>     if compiler thinks full unroll is not profitable, there will be no un=
rolling.
>
> So for gcc, even users saying '#pragma unroll', gcc still do
> profitability test?

GCC doesn't support `#pragma unroll'.

Hence in my original patch the macro __pragma_unroll expands to nothing
with GCC.  That will lead to the compiler perhaps not unrolling the loop
even with -O2|-funroll-loops.

>
>>
>>>
>>>> | profiler2.bpf.o |=C2=A0=C2=A0 2088 |=C2=A0=C2=A0 2050 |
>>> - Without `#pragma unroll' and with -O2 we get 2088 instructions.
>>> - With `#pragma loop unroll(disable)' and with -O2 we get 2050
>>> =C2=A0=C2=A0 instructions.
>>>
>>> Also surprising.
>>>
>>>> | profiler3.bpf.o |=C2=A0=C2=A0 4465 |=C2=A0=C2=A0 1690 |
>>

