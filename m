Return-Path: <bpf+bounces-33499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B22491E1D1
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 16:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2FCEB2357B
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2024 14:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F15315F41E;
	Mon,  1 Jul 2024 14:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZK3xCGyH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="chJY2z8w"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F3153BE2;
	Mon,  1 Jul 2024 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842691; cv=fail; b=Q9l+jyF/V65BurtlqqtX67zphiI0iwYgF+JTXPlYOYZDW1gy4FNae7IkEi9yuvu04H81ETYyLJS08ZDjmmJaxfVhmf7rYAT+5Ou1h3y4RCg847wQdxjsIjK2oRkLGmxvI4tzdIUcbfFnJRT3UQPaKTq3j2eAiXyNrGRRi0UChbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842691; c=relaxed/simple;
	bh=Y74xU//V1lfm2duaymzryBNzeMObp/zZP7l7ZA9g/pM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pv9Dt5ozDp5DS0VaB3eAmkEsSTNKlPr6gFdalpISuv6wsYwkALVuhgrgZG1ahaEgX1RxSywxSJ2TPUFbYa8SG785ULQjdVPDo5gP2Bdab85M2fTqTUHv6DyvRIRM1hJ25g8X3S4pI6hWNl126hbXz25ZkBlcVdaricwGfvSaIWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZK3xCGyH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=chJY2z8w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4617tVqL002085;
	Mon, 1 Jul 2024 14:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=Y74xU//V1lfm2duaymzryBNzeMObp/zZP7l7ZA9g/
	pM=; b=ZK3xCGyH6nqNfZPHKqSbHo3qsWhQ6H5pEF10Ce0mCUN5VD+gKd5IFOyF+
	fIOIEF/m9cWAeNufuC1a3y9Ewtav4Ow/YWL3McePCV0L8Zw/cJbCJp8SLw6UHqO9
	XDHrRK3aDoroARu9eg8TJQuFsLa3nmmO6dtJ0YiN7ZdBFfMoID3HRuehJ9kmz3wk
	veg+o8bmJnPxmE3UZKlCYAAGzODvVhv4YRJUj5EsuQgjLOQ2BfvjqIQ0EIq6OwDV
	i1xZlLYaTQjBPseXSpazzLV1vsbCOr1RyeMGPZPUZGeruPtozW4Z7Qq9FRQLwmUx
	2w03h2Ji2p0anBvQp//1baBJIC34g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0juxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:04:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 461DZB5d009955;
	Mon, 1 Jul 2024 14:04:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q6hy7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Jul 2024 14:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX27DxVZHv7EF8mQOWIh3pb6zRb46bRveMsPnqY7R4fOXNVdBSxgESvsi984CWh3jAKGS+fLuqMzPsa96c3mz7zhzrMQMQjJjDYSQMgxj1162BLK9ot4DUJ8U+LxT9g3+vjKMN2ezxaemy93p1DZ24Lrqd0dXK3pKvLDr7XTxNhL5KXzvSXPo3Kv3vSnpIF8FY2Zf05gRCRdhOkFsvKN+xVN3YcwFra1BCTvHC6eGJl+SUHtAW136CDyrgCQfMHH2U8EDRtAWgmShNcKEpMTco7xnsNFYg7340xm3+KlSiP4JjiYb5xANOsD4eo/AAoOxtQUHU45BsqfbK4SkFDi/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y74xU//V1lfm2duaymzryBNzeMObp/zZP7l7ZA9g/pM=;
 b=HuCHHIZWDXv22oLKIMiKxWlMb12ee7IHBDrfKEDhJ6+c/Q0djdb0Y0NeOQp/kUgqaGnDIA07obGLPuTdDG1SzdX3OidcLVnxqtbBKfcZYBYorjBL+bVeaQAK/2vRBq3Gn0OrZZZP0g0xU39pUBRYhUqcIZmrBYo3WxOxZ3SDJcibvzX5IGUTFVX4JLKJG/RsO+iddWa+iOLgbRIbG2WARIOy5PQhI3WFmhWTXNF+ukN0FEOP1Q70RgLL0C3VWbiRmqsiffAaM4xHGtty/UD4spkvjCkiSlcZd+boRjEaklPN6LUa97PJbMYzIoY7sjGyxjzWklC2UFYXTx2BA44f9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y74xU//V1lfm2duaymzryBNzeMObp/zZP7l7ZA9g/pM=;
 b=chJY2z8wVMeTAsYlX/VxJcT8p6Z9Jm8XWjwyqFcDJD3SuVGUVydN8nus2VgcyNlbpg/zwFWjgtxR9/6SUKNz1TjmH9BZYeWIowKfqVKSno8RlklO5u+Y5OIE/nwiGq8MeC1fjf7xVOAd5Rd42TRz8o/67B4PIDe3r5SEPvGEsPg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH0PR10MB5755.namprd10.prod.outlook.com (2603:10b6:510:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 14:04:22 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 14:04:22 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Simon Horman <horms@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>,
        Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Olga
 Kornievskaia <kolga@netapp.com>, Dai Ngo <dai.ngo@oracle.com>,
        Tom Talpey
	<tom@talpey.com>, netdev <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        Lex Siegel <usiegl00@gmail.com>
Subject: Re: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Thread-Topic: [PATCH net v2] net, sunrpc: Remap EPERM in case of connection
 failure in xs_tcp_setup_socket
Thread-Index: AQHayXi20fKufczNVkW3hiPfAUfk27Hda9GAgARMOwCAADQagA==
Date: Mon, 1 Jul 2024 14:04:22 +0000
Message-ID: <39757894-2C57-4DD6-AF93-25EA35C87C3D@oracle.com>
References: 
 <2e62f0fc284b2f27156cd497fbb733b55a5ade43.1719592013.git.daniel@iogearbox.net>
 <Zn7wtStV+iafWRXj@tissot.1015granger.net> <20240701105742.GV17134@kernel.org>
In-Reply-To: <20240701105742.GV17134@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|PH0PR10MB5755:EE_
x-ms-office365-filtering-correlation-id: ab675e8a-f14f-42fe-20e4-08dc99d6b52a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?ZFNSQjZJZDJ5WUJJcFlTSzFvRHArVFJXdDliRmNhUmMxbWRqVm1idGsvZUxx?=
 =?utf-8?B?SEh3VnBhNVl5dmtyK2pIVEc0L21JeXR3TXBseis3dU1YNmdFRmc4VFpESGUw?=
 =?utf-8?B?WldXNVhabEdPQmMzUHZhZ3hQb3lYZG5pT3VMLzZvZk5STjYzUERteVJNVFd0?=
 =?utf-8?B?T2VLdWdZclo0TVpEdCtCTG9LKzJzTmh6bmZkSXQvU3duU2pjeU1nRjE3Q3ZL?=
 =?utf-8?B?ZVQzQUNUUDFVZkh5L2dJU1Yyeko4VkRRR2tkOG9ZSUlQUkZzRFhsQlB1N2VQ?=
 =?utf-8?B?NjQweUdxZVdBZldXclRqK0FHK1dRS2M3ZW1rUkNzNjdZVzl0a2dlNHVXckE2?=
 =?utf-8?B?RW90TStJMnpyQkNhZDFuRTF6YnB5T3Mwcll3VENiZXZXVWwyN0xZQW5SZk1h?=
 =?utf-8?B?ditibnJ4WWRTWGJnSUxmbjBlQmU4cDBCcEN4a3liaDUxOUhNQWc0THpOUnZo?=
 =?utf-8?B?QUE3bGZ4aWZzQmhuV3pSbUpPM1J5L3RwSDlpYXpXVjFucEdpaHJmQ2czbWU2?=
 =?utf-8?B?Tmt2eFZnS0FwMXlHU1BLTkVYc283Zm5uTGZwZ093Q0dpSzFnMnVTaGtDREZr?=
 =?utf-8?B?dExYRTZyYUJCVitsUTY3ak1PNXpyL0EzdmhMVThtOU45ZlVZaVB4dksyL1JE?=
 =?utf-8?B?eVYweW5VelZhTmRUOEhEY1BrTlRYTlQzSS9rTDlxUmhMUC9QYnY3UGFGaEIr?=
 =?utf-8?B?SG5uOC9PcGFzZTdVcHhWL1pObVV6c0kvdCtsMlU3RXNsV2JhTWVqZkV5UlBB?=
 =?utf-8?B?bHg4TzV0OVRKSzFDNTFiQnRGaXo0N2NPWG9BQTlMams1UzAxb3dIc2dVdDBU?=
 =?utf-8?B?S3o0RlF4WllJblR2TU1hU2pCYytBS3RBY3RoYXNuOFpPYzV4aVY3ejQrL0dM?=
 =?utf-8?B?dVBVZlZDTklzOFdBNnlkTUN1eWtaSnpvSGp1RDhmd0ozemMyZ3dWZWw4TEE1?=
 =?utf-8?B?R1g3MGt6MjAwZmFFWW12dHVaSmFocTFubDFsNU1NclFROVcwWHphbFZxUlpB?=
 =?utf-8?B?MFd6QnpZT3N3QTBpUXdmTWNwblNKN3J4SFVsK2o1MW1Bd0ZmZjcvS1NKbm15?=
 =?utf-8?B?bTNxNFpINWlCYXNyODVUTHZHdFI1dWFlMkYxaFA4cWgxL1JZV3ViZ0E4aVhB?=
 =?utf-8?B?QTRLbU53SjlwWVAydnc2RENnZFNYczNoQnRZWW5MSGtQUmFPakg5OTdGMTla?=
 =?utf-8?B?T0xCU3J5NlRCZDd4SjNpYzNITjRNdWpXUGZHWVNudlNCNE5KV1N5THk1VEE4?=
 =?utf-8?B?TFhtT3lxdlBCaFZYK3dUQTZ1SmZBYUQvU1lUOVZhZUt1RkNBV25oKzRjbC96?=
 =?utf-8?B?Z2NQQUJ1NHJGenJWandiTXlYdkRkYUlUS2VLaEYvdmFjb3ZyK1JQUThQcHg3?=
 =?utf-8?B?aDF4U25EUFpEcnZjTnFPaGVEVFE1eTExeS9pRVNnK0NjUlNZa29JeEtZR2ww?=
 =?utf-8?B?NzBWeGFLUUx4cDlrZXB3TWFuU1R3dnpyWFJldmhINExZemsyejNpaktuOTdn?=
 =?utf-8?B?M3VPQnFYRm8rUnRaSG9xZ2MzNk1Sak8zb1NGbVRmQlFVVDFjMG10THNCY2NF?=
 =?utf-8?B?WlNIc0tRR0ZJa01HUlRVajNCWkptNW5vZUVzOXM4KzR3bmgwVDhkWWtTUUVt?=
 =?utf-8?B?Z0ljc2VzOXJrczAzT3BkYVFIYW1aQ3pvZUp2dE1vNDJnUGFHYVNxVzRjL2dG?=
 =?utf-8?B?d1ZjMXFsMXJLTnpPYkdHZ3YvT01aR2lyL0xSZGg2b3BUWlBDOE54dEdNYkRs?=
 =?utf-8?B?WlpFR2dRSFlUNHdGRSs3SGQwa3dXYVFHemRZd0UvdTBJK2pCOTlSZE9DY3F3?=
 =?utf-8?Q?hqeT0iWGZghUSZE7cApY4L6m3sqBmWwdbZYjw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUFpWW9rQytJd052cDc5TGdVTy93RFpCaVhMSVZJemljNG0yZFVrMTdsRHZO?=
 =?utf-8?B?QXlqeFpwdmJUcXhvRC9ENFRzRkZTK1MzZjkzNkNtdWhaTi9qa2t0ODY4bkYw?=
 =?utf-8?B?QUh1aGhKUlFNRGZNeUFjZUtKWERRUFlTL1hDeFI0d0VvcWxMK3JKUmlHTUVQ?=
 =?utf-8?B?dTFKTW1kMzVFcjhKR1VKa0x3VHM0UzVHdCtkL0lDbFpiVUxzemJvdzNMbWJp?=
 =?utf-8?B?R25TdThkbUhlZVpxNFhZTnppcU5WbXVQL0tya1Z0Rm9CVFdzYzNyMTVaa2tv?=
 =?utf-8?B?c2R4cGlRRGEwSTZCYmJ6NDBWKzhXNEJiSGQ0N0N2MXNLRTVSRW5RZGdSRXpr?=
 =?utf-8?B?Z25OUm4rOU5EenEzVEIwZUlIa3I4UzEvTlhFeUZKRmVKbm1yejM2Wjc3U1Ey?=
 =?utf-8?B?dTRDa1FaZlNNOEVvbXZnQzJZSk9WWVVObk11OElqaGhhNVVWVGUyMDNOZ3dx?=
 =?utf-8?B?eW9VOWNOekx4K0tYVmZyVWxOZDdpaDA0dlA1QmRReDZaSE1DOUVNN215dVpp?=
 =?utf-8?B?SllaQmVvN0tlRGVwNHlzUStodmJWcDdGZEZkejMwQjBjcC9xT2FPQ3Exdkxy?=
 =?utf-8?B?UEQ3emZVVngxWEQ5QjJjbzZOemxtR0RhWWRtbkN0RGQwbkVSZ0JidDdWdHhi?=
 =?utf-8?B?RjdLTENlWEMyemFtSHdoeUhWUzVZYmpCTVFabjdqZWNxaVZ3TW1DT3lFYlpW?=
 =?utf-8?B?clhsbnJEdTdVc0lERi9rOXhmRTYzcXZrOHk0ODFDRUZzaXBRM056cFJ3Vitz?=
 =?utf-8?B?NVdpL0M2eGMvaUpJMktoR1ZESUZMZEJOMnFvY3NwcFBoenpXN2puTWU0SGE4?=
 =?utf-8?B?ZkJvR1pSRkcwaWVaeStRZGNVNzhmU2VkeVh2MG9zazZucFNkUk50ajA3MUx1?=
 =?utf-8?B?T1BySHdZb2xnVGE0cGROMW1uNnJHNFNaRXR5ejJxTnc2emZWcXcyN2ZFbEdT?=
 =?utf-8?B?V3MrL3FpT3ZpMlc3aFJGM2VxYUl5Yk93a1hZdjBCbFdjdkxOdVE5UHpuaG9a?=
 =?utf-8?B?eS9HKzcwYmJ2RTB2KzB2Ulh0TldQQmhPUW5zSXRGazZNR1VBSmxjcFVWTEkw?=
 =?utf-8?B?dExtSUxvZHR4MTU1a1g0eVBYUnN1WmZJaEtzek9ZcjJsM1E2WE13ZTZvN1lF?=
 =?utf-8?B?Q1FESGUyaXp5cGROYm5EQ2xCWm4vS0FLWmVIUnVlZ1hUaU9QTHdSOFliWHdw?=
 =?utf-8?B?NlFjUTYwcTIxd3Njc0U0VUpqUEw1eTUyTGUxZW8wUUtzb1RxdFdkd3cxRndr?=
 =?utf-8?B?d3I5M2c5L1NlbkhjZTJXbDlxcUgvMWNYaDExTzVnRGVhTzR5YmhzeHRJVXhl?=
 =?utf-8?B?RnlVaFZUbkhsandMK1JtTU9iMVZUa1p1WEQySmtLSjZDSG9haEpnbE1LQ0tI?=
 =?utf-8?B?ZDl2NEhud1d5UG9IbG5GTVhBVGdjNGx2MVhQZisvTTM1QWZBODAwQnE5S21i?=
 =?utf-8?B?S3grQ1pvTWhEVFBzQ0NZbzJDNkpKR2RxbGpSbUUrL2JQajN1TUFkWGdsZ2Jp?=
 =?utf-8?B?bGRqWVU5RVpIQTVvZ3FzNlRqZXZETXFITmRhYUN2NFFxd2VlNjZXaWZHQVVZ?=
 =?utf-8?B?SW9hU2Q1eTNkbE53a29tZm5zbWJLb3ZlQUtWLzBvVExzUXVEYUdYbkc3dzNB?=
 =?utf-8?B?anZFSDNUc3FKKzQ4cjVjVmViOG1vWi9JWGM1bzdZMUFtZDI3T09NclYrNmNm?=
 =?utf-8?B?MXdzUXV6YXdQZmpncmRiL3RGekpRUWx4QUVtaS9JN0xYYW91aDRUcXgxLzZG?=
 =?utf-8?B?R2U1VnQrU3R1ZzJ1bGhnZVRuMTZDQlI3YS9OVDdZV0ZDODAzNWhyWnJEMGJj?=
 =?utf-8?B?WTlVa0FmOFRWRmQrVEV0K2tIaVhXbEl6Mks4WHEyeFVYWjZmSC9HLzBjcmhw?=
 =?utf-8?B?emFtOWdKcDRzb2N3VXVvWTBlOGRMVXhEZTR2RXFXMG80Tm1HRkdjZHZtbDBn?=
 =?utf-8?B?NkQ2YXlwUFBMaHo3TkQ3K1ZJcW1lOHJyTS9MUDdHMS84U0lmRUFiK0lWNDMy?=
 =?utf-8?B?N29FVFJmL2tIdHlCMTY4c2dKcHlUSGxNazNFK1Q1cGtSUURnZktMTUZPQXFa?=
 =?utf-8?B?bFd1WVJRUEdKd3F5cXZweHZkYnVZMGZXdlFDUU1tblhZY1BDTFgyQ3JoSVFT?=
 =?utf-8?B?NXdhc0tWdGNvNm15YzNKcHhBUmJCRWNwYzJuaHFLNHZUTTdCR2R0c3lSOXYx?=
 =?utf-8?B?b0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <903BC26195F1C549BF2D0AC2B0377F32@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2tHEpGiNjeCQiaHEwGHLlJrvA1KEpN56ZSO7gwLY+58t584/rPbqe7gaCbePM/+W+9GVFYgi/BlKAbV2lce4jjdxJ3TnX6AIci/syMv0AIjYUBEFDH+QfNcXDhf5lu6Mc/IU2FTpgN7KI3IKvM/ApBP5yT3HaskKQnAVr1EBPSQ7AGT7ymtITH1ni8e3iMWhu3jYQRBP3H3MDg7s3ij4gsb6zCdiIEH/9x5OkSuYCiuDTNCCvuq87Q50dEITAw1mPhlw+PQijAbxDsSLC5madNh+nuw53n/xl5d63A3KNLcSST737hAWjUV76agdbxRjtpZWCYCXlqSxgs8BJ+Oyg9ExxBpunCtObtSY35galog21gAd9yAFG4w0BPCAKvcoMT12/sooyqfVFU2xGZwwFXU+tgmLZ5KNi6WRk4b+gJRp69HTrPSq6A+xweZreSOR3REV1dP3lZZZ6E29LF3J13SmIQbvP5X4rY7x9ZQq89ZhT2UgL0ivnXcMh9JsiQyeCTA50r0qk/jTu99B+LFWARd8FDBKmP03Z2V5r3RoL4e9qSfaIhrK7Ld9WxDWg6o6GuCAlImTP4z4qf7IY2CmXpFMCi7MfeJz4mGpi7TzheM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab675e8a-f14f-42fe-20e4-08dc99d6b52a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 14:04:22.1150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AuKOT+QYq9mh/xNyXEy03JMgQILZG6AGUWPZXA6P/VsTGQWzysaT7Nqbagi7EIl/OzqnTVcwjFY4hovG3CkJgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_12,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407010108
X-Proofpoint-ORIG-GUID: t4WdQNQnYxmxOVyxHs0KpNUaVHJT5knW
X-Proofpoint-GUID: t4WdQNQnYxmxOVyxHs0KpNUaVHJT5knW

DQoNCj4gT24gSnVsIDEsIDIwMjQsIGF0IDY6NTfigK9BTSwgU2ltb24gSG9ybWFuIDxob3Jtc0Br
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIEZyaSwgSnVuIDI4LCAyMDI0IGF0IDAxOjE5OjQ5
UE0gLTA0MDAsIENodWNrIExldmVyIHdyb3RlOg0KPj4gT24gRnJpLCBKdW4gMjgsIDIwMjQgYXQg
MDY6MzE6MjNQTSArMDIwMCwgRGFuaWVsIEJvcmttYW5uIHdyb3RlOg0KPj4+IFdoZW4gdXNpbmcg
YSBCUEYgcHJvZ3JhbSBvbiBrZXJuZWxfY29ubmVjdCgpLCB0aGUgY2FsbCBjYW4gcmV0dXJuIC1F
UEVSTS4gVGhpcw0KPj4+IGNhdXNlcyB4c190Y3Bfc2V0dXBfc29ja2V0KCkgdG8gbG9vcCBmb3Jl
dmVyLCBmaWxsaW5nIHVwIHRoZSBzeXNsb2cgYW5kIGNhdXNpbmcNCj4+PiB0aGUga2VybmVsIHRv
IHBvdGVudGlhbGx5IGZyZWV6ZSB1cC4NCj4+PiANCj4+PiBOZWlsIHN1Z2dlc3RlZDoNCj4+PiAN
Cj4+PiAgVGhpcyB3aWxsIHByb3BhZ2F0ZSAtRVBFUk0gdXAgaW50byBvdGhlciBsYXllcnMgd2hp
Y2ggbWlnaHQgbm90IGJlIHJlYWR5DQo+Pj4gIHRvIGhhbmRsZSBpdC4gSXQgbWlnaHQgYmUgc2Fm
ZXIgdG8gbWFwIEVQRVJNIHRvIGFuIGVycm9yIHdlIHdvdWxkIGJlIG1vcmUNCj4+PiAgbGlrZWx5
IHRvIGV4cGVjdCBmcm9tIHRoZSBuZXR3b3JrIHN5c3RlbSAtIHN1Y2ggYXMgRUNPTk5SRUZVU0VE
IG9yIEVORVRET1dOLg0KPj4+IA0KPj4+IEVDT05OUkVGVVNFRCBhcyBlcnJvciBzZWVtcyByZWFz
b25hYmxlLiBGb3IgcHJvZ3JhbXMgc2V0dGluZyBhIGRpZmZlcmVudCBlcnJvcg0KPj4+IGNhbiBi
ZSBvdXQgb2YgcmVhY2ggKHNlZSBoYW5kbGluZyBpbiA0ZmJhYzc3ZDJkMDkpIGluIHBhcnRpY3Vs
YXIgb24ga2VybmVscw0KPj4+IHdoaWNoIGRvIG5vdCBoYXZlIGYxMGQwNTk2NjE5NiAoImJwZjog
TWFrZSBCUEZfUFJPR19SVU5fQVJSQVkgcmV0dXJuIC1lcnINCj4+PiBpbnN0ZWFkIG9mIGFsbG93
IGJvb2xlYW4iKSwgdGh1cyBnaXZlbiB0aGF0IGl0IGlzIGJldHRlciB0byBzaW1wbHkgcmVtYXAg
Zm9yDQo+Pj4gY29uc2lzdGVudCBiZWhhdmlvci4gVURQIGRvZXMgaGFuZGxlIEVQRVJNIGluIHhz
X3VkcF9zZW5kX3JlcXVlc3QoKS4NCj4+PiANCj4+PiBGaXhlczogZDc0YmFkNGU3NGVlICgiYnBm
OiBIb29rcyBmb3Igc3lzX2Nvbm5lY3QiKQ0KPj4+IEZpeGVzOiA0ZmJhYzc3ZDJkMDkgKCJicGY6
IEhvb2tzIGZvciBzeXNfYmluZCIpDQo+Pj4gQ28tZGV2ZWxvcGVkLWJ5OiBMZXggU2llZ2VsIDx1
c2llZ2wwMEBnbWFpbC5jb20+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGV4IFNpZWdlbCA8dXNpZWds
MDBAZ21haWwuY29tPg0KPj4+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBCb3JrbWFubiA8ZGFuaWVs
QGlvZ2VhcmJveC5uZXQ+DQo+Pj4gTGluazogaHR0cHM6Ly9naXRodWIuY29tL2NpbGl1bS9jaWxp
dW0vaXNzdWVzLzMzMzk1DQo+Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYnBmLzE3
MTM3NDE3NTUxMy4xMjg3Ny44OTkzNjQyOTA4MDgyMDE0ODgxQG5vYmxlLm5laWwuYnJvd24ubmFt
ZQ0KPj4+IC0tLQ0KPj4+IFsgRml4ZXMgdGFncyBhcmUgc2V0IHRvIHRoZSBvcmlnIGNvbm5lY3Qg
Y29tbWl0IHNvIHRoYXQgc3RhYmxlIHRlYW0NCj4+PiAgIGNhbiBwaWNrIHRoaXMgdXAuIF0NCj4+
PiANCj4+PiB2MSAtPiB2MjoNCj4+PiAgIC0gUGxhaW4gcmVzZW5kLCBhZGRpbmcgbW9yZSBzdW5y
cGMgZm9sa3MgdG8gQ2MNCj4+PiANCj4+PiBuZXQvc3VucnBjL3hwcnRzb2NrLmMgfCA3ICsrKysr
KysNCj4+PiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+Pj4gDQo+Pj4gZGlmZiAt
LWdpdCBhL25ldC9zdW5ycGMveHBydHNvY2suYyBiL25ldC9zdW5ycGMveHBydHNvY2suYw0KPj4+
IGluZGV4IGRmYzM1M2VlYThlZC4uMGUxNjkxMzE2ZjQyIDEwMDY0NA0KPj4+IC0tLSBhL25ldC9z
dW5ycGMveHBydHNvY2suYw0KPj4+ICsrKyBiL25ldC9zdW5ycGMveHBydHNvY2suYw0KPj4+IEBA
IC0yNDQxLDYgKzI0NDEsMTMgQEAgc3RhdGljIHZvaWQgeHNfdGNwX3NldHVwX3NvY2tldChzdHJ1
Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+Pj4gdHJhbnNwb3J0LT5zcmNwb3J0ID0gMDsNCj4+PiBz
dGF0dXMgPSAtRUFHQUlOOw0KPj4+IGJyZWFrOw0KPj4+ICsgY2FzZSAtRVBFUk06DQo+Pj4gKyAv
KiBIYXBwZW5zLCBmb3IgaW5zdGFuY2UsIGlmIGEgQlBGIHByb2dyYW0gaXMgcHJldmVudGluZw0K
Pj4+ICsgICogdGhlIGNvbm5lY3QuIFJlbWFwIHRoZSBlcnJvciBzbyB1cHBlciBsYXllcnMgY2Fu
IGJldHRlcg0KPj4+ICsgICogZGVhbCB3aXRoIGl0Lg0KPj4+ICsgICovDQo+Pj4gKyBzdGF0dXMg
PSAtRUNPTk5SRUZVU0VEOw0KPj4+ICsgZmFsbHRocm91Z2g7DQo+Pj4gY2FzZSAtRUlOVkFMOg0K
Pj4+IC8qIEhhcHBlbnMsIGZvciBpbnN0YW5jZSwgaWYgdGhlIHVzZXIgc3BlY2lmaWVkIGEgbGlu
aw0KPj4+ICAqIGxvY2FsIElQdjYgYWRkcmVzcyB3aXRob3V0IGEgc2NvcGUtaWQuDQo+Pj4gLS0g
DQo+Pj4gMi4yMS4wDQo+Pj4gDQo+PiANCj4+IEhpIERhbmllbCAtDQo+PiANCj4+IEkga25vdyB0
aGlzIGlzIG5vdCBkb2N1bWVudGVkIGluIE1BSU5UQUlORVJTLCBidXQgY2hhbmdlcyB0bw0KPj4g
bmV0L3N1bnJwYy94cHJ0c29jay5jIGdvIHRvIEFubmEgU2NodW1ha2VyIGFuZCBUcm9uZCBNeWts
ZWJ1c3QsDQo+PiBjYzogbGludXgtbmZzQHZnZXIuDQo+IA0KPiBXb3VsZCBpdCBiZSBwb3NzaWJs
ZSB0byB1cGRhdGUgTUFJTlRBSU5FUlMgYWNjb3JkaW5nbHk/DQoNCkkgY2FuIGRvIGl0LCBvZiBj
b3Vyc2UsIGJ1dCBJJ2QgbGlrZSB0byBkaXNjdXNzIHRoaXMNCndpdGggdGhlIE5GUyBjbGllbnQg
bWFpbnRhaW5lcnMgdG8gZW5zdXJlIHRoZXkgYWdyZWUNCm9uIGhvdyB0aGUgZmlsZXMgYXJlIGRp
dmlkZWQgYmV0d2VlbiB0aGUgdHJlZXMuDQoNCg0KLS0NCkNodWNrIExldmVyDQoNCg0K

