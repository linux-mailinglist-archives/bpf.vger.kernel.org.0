Return-Path: <bpf+bounces-31149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4F8D75C9
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885321C215E5
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFEE3BB50;
	Sun,  2 Jun 2024 13:48:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AA4084E
	for <bpf@vger.kernel.org>; Sun,  2 Jun 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717336092; cv=fail; b=LhePkvDq0TBZyDwPvHsl6f1i5hgZQ65kJh1CzMmmUyVTzx2Tr4g8ThVm88HtkyJdKBP26HSMnA5BfMXZlQf1M9BpLrdI13RYdRxrIeJSyZ/s0mU6FOJ5+CviQqsJDfQdynzpHLYeGp05SRSXMsb8EnTMAQfUF52vJ+2don+ZTP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717336092; c=relaxed/simple;
	bh=NG2ughKjatn0mMJ3Up+wai9kNObq0Zg4FOXrR/dT+c0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nBrLQpLLIoegB9v8DxLk7nt/+Eu+draEscx5tp3Vrn4/lGymjhqSX5ZdYOsHYCYcwYKI0HlclW3TLdt6s54dZ92iehokgY6HSRAK8RfeXMYkzqWungYWOQGSoCfVpqJsflOoRhTGoZ5wOa5138f7ABrLSpMluH0yIwwz8mcLGQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4525m1Jb000945;
	Sun, 2 Jun 2024 13:47:35 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DnAI1UH16Wo5zvs1FadfiPBFU6LbmLXXoDOlG1kihhLA=3D;_b?=
 =?UTF-8?Q?=3DMhYlglJLWef8pRVsoOColQG4omvU/VPxa3dCG9UKQrCWCMrfWkLrJryVDBER?=
 =?UTF-8?Q?Hv/CZu8N_a2xLlPZzDAJSPCHBfPHGZ4Q54/Ix25LtqKGpKu8f8ChSBLqcqIDP5/?=
 =?UTF-8?Q?gNZ1EVd0BvWdYd_P4dvERueE5GkuTaOWwRQ7kiGVGNj2gwqf/JGkT756l248LLM?=
 =?UTF-8?Q?zqO9qDE2AF1fAAWBQ54d_OW/MXHz/yhEi+VanOvIRYSPWrqD83NvihBzbaNdk+c?=
 =?UTF-8?Q?4do+hPeAfVF6eaQKdhPpUrOUWR_C78DDpkvQfkrvT7NLSvfHXsJ35MOvBrvK1G0?=
 =?UTF-8?Q?rDjGa7tWvkr1MMJizQcz6at38LsA4iXa_DA=3D=3D_?=
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv6u1c67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 13:47:35 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 452CDXee037787;
	Sun, 2 Jun 2024 13:47:34 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrja17fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 13:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fu8ctioRX2ovohuZ4k7Jh41IdCpXvpUrrVsPtnJPm1WG2geUy+NtHBMG3rb2WXkHYmbH9AYJy2WKhQSZIn1EA3bGXQN5GNpLJmY2xLT9w1XAOet5oDeV/A/TW3F0EM0Rn9wtgWc1dzN+UYQhYSyT7zZFek4OLyLb/4kreELRa2grwVAC+uSlqVmlL6MWyRRE3iNOW5fVYeailB3akr514qgheKDiqzE5ExdF6TN7FNJDpF3HSAeVZ4UMJGB55hIgUNNOdqQDwd+75KM6WsvMm9DVwlACYZfDM0IbPz7rZNaCwHompIYLgHqeNGLtZPtEXMPsfCa1p6FsxbRu/xpRmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAI1UH16Wo5zvs1FadfiPBFU6LbmLXXoDOlG1kihhLA=;
 b=Bv4Y13evYFtbQ8Vda0oB+57fyGJnzKvianHZ4oS47LiFmZS165hSIWmm7Dlkeyq5LEgdRXtMjpirpe/ozmvJtfS+c7zLwzXo4zAis9xExfR5IXiT+Sb/JRnGv6uPGmj+mWvqQ4VhbAMwNtfUQ++Cr3at9oCuhbe18TpUD1+FE2WvbgpBZ5ED6rPmy86SxqoKSgWuaBe9QyGyzUkP0oij5jTrmGJcRliZC2khg0B37zJWY9QCtI+7+2+X8Ejth9Z+7hxlk8eNwDAbtcAAkOTIDPdvqfiP1p88Mgev3QCKol6+nrlqWemSKFjHN1d1AcvkIX/5puoGSbP2zAn86FitCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAI1UH16Wo5zvs1FadfiPBFU6LbmLXXoDOlG1kihhLA=;
 b=IkHlSHBmSO8gOdTQAyFlpzepZaYWm4Mb8Tf/U8AH1K8IPEPtL2ixhSRhuLFYq2L0wvAiQstgwtuXL8jsQ9i+gJpIE+qmn2bRZTSHMcSMPTbTWpua46L8onGXf+Ye/Qcq7n7DukECg6iojn8MLyS8Pwp0x2L+PizqoK7qhBHuJ8s=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6814.namprd10.prod.outlook.com (2603:10b6:8:10a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Sun, 2 Jun
 2024 13:47:31 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7633.021; Sun, 2 Jun 2024
 13:47:31 +0000
Message-ID: <9f6ba8d7-1245-4267-951e-f4890abc28e3@oracle.com>
Date: Sun, 2 Jun 2024 14:47:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 3/9] libbpf: split BTF relocation
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com,
        quentin@isovalent.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, houtao1@huawei.com,
        bpf@vger.kernel.org, masahiroy@kernel.org, mcgrof@kernel.org,
        nathan@kernel.org
References: <20240528122408.3154936-1-alan.maguire@oracle.com>
 <20240528122408.3154936-4-alan.maguire@oracle.com>
 <7da6ec1c366bb7b5461b10eeaaa75945b74815be.camel@gmail.com>
 <843d8e77-080c-4211-b7c7-dd6918bef901@oracle.com>
 <0848f8e3fec1954540b9d679aaa59c17177d0aa2.camel@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <0848f8e3fec1954540b9d679aaa59c17177d0aa2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0107.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::48) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6814:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f53805-6d66-4af4-6607-08dc830a8cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?enI2cU92dTR4WEhjenJJamxydmhDMDd0ZS9NT25acEJPRFVES1cvaFVyMEIz?=
 =?utf-8?B?ek5DMFNsczErcFhyL1NBL20vUUdpU21lNjgvMElyd0tTUkF6TW1RZHhzNlNs?=
 =?utf-8?B?ci84a1NJalVGU0NBQTgrTjluZittc0hUSVU0Ui9uWTd6RHBSeXJ1eEhpS0Jo?=
 =?utf-8?B?RFhQVDdRRmJjME1sUDZjbnF3ZFdKVWVTNE04WHlsbE0wZVJza1BwMTZNM21R?=
 =?utf-8?B?ZXJDbE0vWkVrYTd4c3B2cUZSWFBHejAvemZ3S09TS0lGcnlnbDRiZUE3VDR0?=
 =?utf-8?B?OE0wUzczR0pjd0JIWmZwZFVUc2lHK01qMGdUeS9KWmFBQXlpM3N1aThRNjkx?=
 =?utf-8?B?R2ZqNUVmWFhuMy92clQzZ2owM0F0cEEvdXhwalRPaUtXc2F6RXF0Y3JzOC9Y?=
 =?utf-8?B?ckM3SVJXREhISmRVUmpsVjhGQ2E3ZE5NVitiZHBDOGRpdzVQY2RoT3E0cEcw?=
 =?utf-8?B?MXM2Rk9sRDlvUWFqL21ydldQNExycUdtYlVJSk9JMEV1bFhNQmVkcjNrQTJ3?=
 =?utf-8?B?bGF4bVJpSFVZbnJ6SWpkT3BkUld2Z1RMNGNhdWxiM0hTTGZjSnlZM2Myck03?=
 =?utf-8?B?dlN5NjU0b04vRzQza01acXBOZVlnOGVBdEt4NTl1V1E2NFBOMkozRXNOTXB2?=
 =?utf-8?B?UDJvVkp6eXg1Vk9rbzZya0dRV3JSYjFHQWtIUXFRTFNySkhHMnFWUnRVbEl5?=
 =?utf-8?B?OFFvekRkUEZXNUFyeC9OWVZabnYzMThsUjQ5bVFqTWJSV0JNUkpjMnJrbWNo?=
 =?utf-8?B?RE1JZ3hwQXg3L2dwNk9rQ1JkMGVSTUtUaGJSRkgyL3VZZHRaU0VmTVd3Wmsy?=
 =?utf-8?B?cFFJSDg5QTAxQnJCVFpvRlRRV2Ftd1VydDExdlhtN3RLZmZnNE1tUUFRQ01w?=
 =?utf-8?B?YWJCRCtlVGNoYXpXc2hucG5odUV4UWFvWDZFRlRWMVBXNjhNV01RblBUQkdr?=
 =?utf-8?B?WG9mWHBkSDJ5aVA0ZnBHRnpnRlFaZG9icjAzMzNOejBxdndTVUxRbTB6S3Jx?=
 =?utf-8?B?R2NOb0JseExYVU9MWkcvZjQ4Ty9yamZhbFhvSGpSVnlkcmNpVlF5YVJORUxs?=
 =?utf-8?B?TjZFYVRqcitwL1EwL3VmZjdFWnEwaXd4czJaaGVLemhJWW9nYlRJWnNWT0xS?=
 =?utf-8?B?aFpQbExmNVhqcmVjNjFoYW03dGk4SmpjdnQzS0JBaURXaGVPcUp3eGVyRlRt?=
 =?utf-8?B?Y1NrYTQ3c3ZkaVNmbzRWNDhWR1p0MS81Sjg2OTJKUWVvTGowQXZCUkl5RzVE?=
 =?utf-8?B?MkFkYkhvOUhTUmZMMFJwNGtTOGd6cndycHo3K2pEWXdDVThoOWdOZWhnSGN0?=
 =?utf-8?B?OW1SdHdaYVZyaDVmdkNOL01uQzhYbkgwaDB6TFVQUDlpWXJ3QVBBeUd1SEtL?=
 =?utf-8?B?LzBPakRRbzNRQnd0QWlDT3ZpR2RQdWJTbnNKV2lBNFRrcU1RTU9yNHY4T29U?=
 =?utf-8?B?M1FmOFVESm9MVEtUK1RsemtHOUpXUlVXRXhqeUxqNFI5cjNLa3lpaEhhUmo3?=
 =?utf-8?B?bjhodUtNbUhhT0pYOTU1SHNBV0NmTGM5SzRLc3RzSUVKVVEycXdmdVlabnJZ?=
 =?utf-8?B?TThRVWpWVGlDU1cvYzVvQk1taFB0YXBOa0FtZzZ4cUlPa1VEZ3RWY3l5RmNz?=
 =?utf-8?B?RWhGSHVXUmtnTzd2UnFUVjFhUHhhcmlkRjRWSHEzYUN5NG81cWJpYmNYVmlZ?=
 =?utf-8?B?STB2Wko3R3ZtZFBGdWN2L2ZodjNVK2FkNlJVY2JzTHBzRUpCRkMva0NRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y3JQbS9qdC9hYk5xQlpHQ0gzVFQxck5aZTNlbWwxYThTSFNwNGNQYUVCck9M?=
 =?utf-8?B?eld1OFNVZUw2MnMraEcvNU1KK2R0ZGM4S2NHY1lENC9XVlFSMWxvSjZSYVA2?=
 =?utf-8?B?YkFJSTQ5VnROMytVM3d6RzN5d0ZodStEUHRyVHEwMUhyMzhCSHR2cVpUTHha?=
 =?utf-8?B?RVBmVjFvVCtZOGlVTVpaaWowVGw3bVdlb2ZjTmRsaTFMR0M2aDNMem1qMEty?=
 =?utf-8?B?QXBac1NDM1lZa1NNWUtwOVMra1l4YXRvZEtGNFZnRnIyQ1FWQTloSmFGYW5t?=
 =?utf-8?B?Rk0yUjV0UysxTlpjVmxmNDhaTWJ5RnR3UFNxdlFZak1ycEhEbkhlQ2paUzdC?=
 =?utf-8?B?bmtORDFqM1BsU09KRDl0R0lnVGI0ZnA1c3ZDWmJZS1R0b2VjY0JwWVg1Wm9r?=
 =?utf-8?B?bm1qM0xucDRhRkZ5YzRTcndaRWIvT1JsNEVlWWM2Ri9HU2dXaW9oYysvMkpZ?=
 =?utf-8?B?SUYzWlMzZEtFbG4zdTVpcndVNTlNa2k4MjBRUXZNZU0yQW1MR2tIQVlpY2pM?=
 =?utf-8?B?bzZiV2lQSXlrUFo2QXFQQXIvd1REMWYrOUZ4VnJPQXc1RTUzUEtQOFJIcnQz?=
 =?utf-8?B?TFZXeExGWVVjTFVucnJaMkdSbGc4SlFRU08wSW5aemx1RktCQjRUYURlWnBh?=
 =?utf-8?B?R2t6Z3BMNGhmRUU2YjFBcEZMODY0Y25KdTRGYUE4RzBjV1o2SjhRQm92eTJL?=
 =?utf-8?B?T3NhSUNXM2ZXNzNrSTBnQytDZEgyOWpMV0tVN01Uamk4LzRpa28zQ0pxVGVz?=
 =?utf-8?B?cDZZUHQwbVhFd25QNmpIeUVDUFhDOVloWkZyMWtSZWNPRjRORUg0NmxXV2NJ?=
 =?utf-8?B?VEJaMG1qaGxuWFNMTlVzMmRBdlYyL2xiQ3l1VzFkTGw5bml6MDQ3OXpORUhw?=
 =?utf-8?B?UEh5S2VzRFp2K1RJaExHNmRCeU5jem5pTXRtTkJDUjJhR1Jid0J4ZUEvNWxP?=
 =?utf-8?B?RlV3SVFxeEpGVzVybURiL0dBc0JUbXVKNFU0ekVnZkc2OW1NeHVjR2JNRkRW?=
 =?utf-8?B?bC9EZ3NiUzBuMTE2QVZFc2oxMkpmMm9XQ2g1WVZsaHUwRFlRUUk2VVJ6UFJJ?=
 =?utf-8?B?ZFNMckV1dTJaTkpCSUE1bUEzNGRBM040bVBBLzdkbWxyZnV0QUUzL1lEOFpR?=
 =?utf-8?B?QzQyMG9ZR050eVl4YjNROVNlOE1uaUFBQXVSRVhOdjcydUhOR0d5cEZjQ0VT?=
 =?utf-8?B?NWQ0b05EeVEyalhPMVUxb2UwekxVSnpBSXhVYitEQ2tSckcrZkhtN3loakFG?=
 =?utf-8?B?NjN0MFViRGk0Tm5kNlNKdStHY0RNc0dVQWppZ3ozZkZvenJWNm9ITFFoY21q?=
 =?utf-8?B?a09yWUFPWDc3dDAvSTZhbmx1MGJoTUdaM29pTCtKM1Zpb2tEUHdwOGVENFhS?=
 =?utf-8?B?TllabW1PZkN5a3ZUcUZ6Rjd1UXlUNkJZYzNuK2Q3Nk1Ia2o5L3VRNmMwczgx?=
 =?utf-8?B?ZkZLZFJJOFc4WlFXd25XRXFCUE1TcFNYb2RYN05zamZmM1dhYm9sRDE3VW9F?=
 =?utf-8?B?Skludm5HK1JhWGNkOG1aNWVia3F6QzRGWHNEZ3dJY0RtQVBwcWQ1eDdURUwx?=
 =?utf-8?B?aERCUDVYSHE4Um9CdGJud2ZEcmRqYUpLcHdMZ0tKK0lTUVFzWVV3N3dBTWND?=
 =?utf-8?B?WFpneC85R0NNVmx2aVp2WFZZRHJiNVpzU3k1Ky95bElBM2h1N3VQbndKQTRs?=
 =?utf-8?B?ai9FL2Z6RGRtTVp3Y0dtMU9jOG50d2tIM3FQTHdSM3VvSjI0ZlVIWlRZYXRT?=
 =?utf-8?B?dmZjbDZMNVlndUZBWHVjRzNNRVJHcjZuMkg1QktpT09NWnN2VmRwb3QzVDlV?=
 =?utf-8?B?bFB0Z2xVblpibHZuRm12R2l5bDZIWEE3ejdkbTZpYldqaFdBbkFqeFJhY0w4?=
 =?utf-8?B?b3BlQ2U2NmJ4azRKZmpLTzN0V1M4TS9zMGxab1NiNFN5enFVdDlHY1JrbGtm?=
 =?utf-8?B?VFdoczhkdkp2bUhDYkxKeVFCdTgwRkttb1hGSmtENmJSYkRHcXp2Vk5aS3gx?=
 =?utf-8?B?b2U3ZUUwWkY1S0FxMnR3Q21MVVdNTmVyeGdZVXB3aHRmYTlIRXQ2UXMrVW1W?=
 =?utf-8?B?N1ltY3IzRFBabm5KeHNUY3krWXlFbHp1SEZ0ekd5U2xCMmFtRW9rQkEwVkVX?=
 =?utf-8?B?Rlc5dkp6UzN1UG83SEFJREYwS005N3hCNmp5cW9uQ2JBM1UrTlZMalQrLzFt?=
 =?utf-8?Q?DZgTOr/WSsyMsEm6UPQiHJY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LhDwdMhdXPbzy45b+MtgjYJhyt69kyCQeKhvpXrIRQskA2vFmUTcp2iRkZtz1wEKMvZBQJIN2IEW6ZhVyB2OIuR0jh9YQhxmp4gBgbZnmJORO0+oCUwOUk2FC803wUgST2L3+gCIbUqjoKFSjcRUr6rl+61eVoKmGKwy6A+YcG4FK6ERHC97n+AQzm70f6JxNyeSQy+EGCoJa589gu5keYUYWaYuZuDJQMCuHpX4ZsHe/Gp2do6MHz1t3pIIzNtRXkw1fCyOZkKTfBs82DsAtwBFnPsypOYZrvrMW0lpCbGXQyTPPKWksCFHs/aH6EOiT5h61iXW46n8OX4cbH24gncKJNE/Lz0zU3P8GoYiL1XYwzVQr+eE8awnL7Df2H1zWpGRVm6wx/uL4XJeZAGkAtjmVled2/TcvLXOI48O73mIgmT/YrIbSaFp3s0niYXw52BLxTm88QsbUfvJIk/vaYra2mWzZP4n8Hx1AYVS9fPBnN6GXjhr+TEerQgWq+ElYjHnu6Hn3duHSEdIAA4XPxH4Zo2ymQqq9f3y2O3qpJEDK3PHU9lCpcIeD2OuumiQPPjmPDg/VoZvnJf3QonppHYNV5Zp8CTym+Qk2nHKV/M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f53805-6d66-4af4-6607-08dc830a8cd8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 13:47:31.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcMKKQIDNAnLp5hbu4hSvPAzHxRPBc8ISfm1g3JY10M+YqoMQT5YSeNwAbATrma9ZZ9Ve97Rx2OLLUvbRfPHnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6814
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-02_08,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406020118
X-Proofpoint-ORIG-GUID: 0HtQP4shw1gokZJsdhXud0aRYVaQB1VT
X-Proofpoint-GUID: 0HtQP4shw1gokZJsdhXud0aRYVaQB1VT

On 01/06/2024 08:56, Eduard Zingerman wrote:
> On Fri, 2024-05-31 at 16:38 +0100, Alan Maguire wrote:
> 
> Hi Alan,
> 
>> The in-kernel sort reports n*log2(n) + 0.37*n + o(n) comparisons on
>> average; for base BTF that means sorting requires at least
>>
>> Base: 14307*14+0.37*14307	= 205592 comparisons
>> Dist: 600*9+0.37*600		= 5622 comparisons
>>
>> So we get an inversion of the above results, with (unless I'm
>> miscalculating something), sorting distilled base BTF requiring less
>> comparisons overall across both sort+search.
>>
>> Sort Comparisons		Search comparisons		Total
>> ======================================================================	
>> 5622	(distilled)		128763	(to base)		134385
>> 205592	(base)			8400	(to distilled)		213992
> 
> It was absolutely stupid of me to not include the base sort cost into
> the calculations, really embarrassing. Thank you for pointing this out
> and my apologies for suggesting such nonsense.
>

No apologies necessary! Your feedback was a great reminder to actually
check the relative overheads properly (which I had neglected to do in
depth), and it just turns out in this case that the relative proportions
between base and distilled base make sorting the distilled base the
right approach. So this was absolutely a valid theoretical question, and
I'm very glad you asked it.

> [...]
> 
>>> The algorithm might not handle name duplicates in the distilled BTF well,
>>> e.g. in theory, the following is a valid C code
>>>
>>>   struct foo { int f; }; // sizeof(struct foo) == 4
>>>   typedef int foo;       // sizeof(foo) == 4
>>>
>>> Suppose that these types are a part of the distilled BTF.
>>> Depending on which one would end up first in 'dist_base_info_sorted'
>>> bsearch might fail to find one or the other.
>>
>> In the case of distilled base BTF, only struct, union, enum, enum64,
>> int, float and fwd can be present. Size matches would have to be between
>> one of these kinds I think, but are still possible nevertheless.
> 
> As Andrii noted in a sibling reply, there is still a slim possibility
> for name duplicates in the distilled base. Imo, if we can catch the
> corner case we should.
> 
>>> Also, algorithm does not report an error if there are several
>>> types with the same name and size in the base BTF.
>>
>> Yep, while we have to handle this, it only becomes an ambiguity problem
>> if distilled base BTF refers to one of such types. On my vmlinux I see
>> the following duplicate name/size STRUCTs
> 
> As you noted, this situation is really easy to catch by checking if
> id_map slot is already occupied, so it should be checked.
> 
> [...]
> 
>> struct elf_thread_core_info___2;
>>
>> struct elf_note_info___2 {
>>         struct elf_thread_core_info___2 *thread;
>>         struct memelfnote psinfo;
>>         struct memelfnote signote;
>>         struct memelfnote auxv;
>>         struct memelfnote files;
>>         compat_siginfo_t csigdata;
>>         size_t size;
>>         int thread_notes;
>> };
>>
>> Both of these share self-reference, either directly or indirectly so
>> maybe it's a corner-case of dedup we're missing. I'll dig into these later.
> 
> This is interesting indeed.
> 
>>> I suggest to modify the algorithm as follows:
>>> - let 'base_info_sorted' be a set of tuples {kind,name,size,id}
>>>   corresponding to the base BTF, sorted by kind, name and size;
>>
>> That was my first thought, but we can't always search by kind; for
>> example it's possible the distilled base has a fwd and vmlinux only has
>> a struct kind for the same type name; in such a case we'd want to
>> support a match provided the fwd's kflag indicated a struct fwd.
>>
>> In fact looking at the code we're missing logic for the opposite
>> condition (fwd only in base, struct in distilled base). I'll fix that.
>>
>> The other case is an enum in distilled base matching an enum64
>> or an enum.
> 
> I think it could be possible to do some kinds normalization
> (e.g. represent fwd's as zero sized structs or unions in
> btf_name_info).
> I'll try to implement this and get back to you on Monday.
> 
> [...]
> 
>> I think flipping the search order could gain search speed, but only at
>> the expense of slowing things down overall due to the extra cost of
>> having to sort so many more elements. I suspect it will mostly be a
>> wash, though numbers above seem to suggest sorting distilled base may
>> have an edge when we consider both search and sort. The question is
>> probably which sort/search order is most amenable to handling the data
>> and helping us deal with the edge cases like duplicates.
> 
> Yes, you are absolutely correct.
> 
> [...]
> 
>> @@ -136,6 +137,19 @@ static int btf_relocate_map_distilled_base(struct
>> btf_relocate *r)
>>         qsort(dist_base_info_sorted, r->nr_dist_base_types,
>> sizeof(*dist_base_info_sorted),
>>               cmp_btf_name_size);
>>
>> +       /* It is possible - though highly unlikely - that
>> duplicate-named types
>> +        * end up in distilled based BTF; error out if this is the case.
>> +        */
>> +       for (id = 1; id < r->nr_dist_base_types; id++) {
>> +               if (last_name == dist_base_info_sorted[id].name) {
>> +                       pr_warn("Multiple distilled base types [%u],
>> [%u] share name '%s'; cannot relocate with base BTF.\n",
>> +                               id - 1, id, last_name);
>> +                       err = -EINVAL;
>> +                       goto done;
>> +               }
>> +               last_name = dist_base_info_sorted[id].name;
>> +       }
>> +
> 
> Nit: this rejects a case when both distilled types are embedded and a
>      counterpart for each could be found in base. But that's a bit
>      inconvenient to check for in the current framework. Probably not
>      important.
> 
>>         /* Mark distilled base struct/union members of split BTF
>> structs/unions
>>          * in id_map with BTF_IS_EMBEDDED; this signals that these types
>>          * need to match both name and size, otherwise embeddding the base
>> @@ -272,6 +286,21 @@ static int btf_relocate_map_distilled_base(struct
>> btf_relocate *r)
>>                 default:
>>                         continue;
>>                 }
>> +               if (r->id_map[dist_name_info->id] &&
>> + 		    r->id_map[dist_name_info->id != BTF_IS_EMBEDDED) {
>> +                       /* we already have a match; this tells us that
>> +                        * multiple base types of the same name
>> +                        * have the same size, since for cases where
>> +                        * multiple types have the same name we match
>> +                        * on name and size.  In this case, we have
>> +                        * no way of determining which to relocate
>> +                        * to in base BTF, so error out.
>> +                        */
>> +                       pr_warn("distilled base BTF type '%s' [%u], size
>> %u has multiple candidates of the same size (ids [%u, %u]) in base BTF\n",
>> +                               base_name_info.name, dist_name_info->id,
>> base_t->size,
>> +                               id, r->id_map[dist_name_info->id]);
>> +                       err = -EINVAL;
>> +                       goto done;
>> +               }
> 
> I think this hunk should be added.
> 

Sure, will do! Thanks again!


Alan
> [...]
> 
> Best regards,
> Eduard

