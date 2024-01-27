Return-Path: <bpf+bounces-20469-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101B983ECA6
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942681F23767
	for <lists+bpf@lfdr.de>; Sat, 27 Jan 2024 10:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90311EB23;
	Sat, 27 Jan 2024 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0uNi98s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k31C9T1G"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A01EB22
	for <bpf@vger.kernel.org>; Sat, 27 Jan 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706350207; cv=fail; b=a4vRUFcpKbZJmH2e6dYnLVsnW3vpod/rZEAYOXk8Jp2sdS0Yt2g+0aE8CssCboRvaLb9Xi4KU5sQZ6LaTxWMoD1awPDdTnsUZonNqFWDax7SwPnvsAkA/5ulEdcfLKuci+JicvVldzX9JvrrdxeqJAIOF5iUJDrh7gdJCPejM2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706350207; c=relaxed/simple;
	bh=H1xznqqxL0S4WgCzFCG8fJEsiip5LHzMruIFxDzJ858=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=oYCazTQyL8wNd7v8G5GuPvd+59vcaEpx+PI2MxSmmVSkYi7w4VqI27vTyI3miWsNsCRU9aCORqbLLFSZ6p39EatmQyu8Z7wAqaxb6po1gpOHoYKZlHfQ6F+Y4ONeVZasfdekdTCy9RddC1PZWIAckUrIdJ8PX4BKlumE+BjPcGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k0uNi98s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k31C9T1G; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40R9S5b6015588;
	Sat, 27 Jan 2024 10:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=PYCCwNPuiCauMhIah+ZbAG0Slmri9UjLdR/8GL5t1IA=;
 b=k0uNi98sO3aSkrKHT+kdX8AaO+mSKAFZVTq47eYMSP0QMVraF1OKadIocCREDHB4cAB+
 b+u68Gxie0reV44tw7FBmgkvwjk8EQlao11R2cxBGiyyC2T1FE+NoWMKRPMni57VMJWb
 lHums1jlffu4pXqHwtEEVhB6rEj2kEfOZ/nucTbsMpPvXDL0fp2nlwsRDXRgDLY81li9
 euajMNOjUdAPJXL9N2ahVIoqhL8ELAJ5DKrlRnfmVmFT0s+lHXffH90hPSX3d8C+Iipa
 /H3u/ttLnwvIr+LGSRc+WfEEfecsXNSPw7fpix+hR752Me/aDWdFas5sdjvOPQ2LykZR IQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqardgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 10:10:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40R8ioZb008425;
	Sat, 27 Jan 2024 10:10:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9a9vs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jan 2024 10:10:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILAVZCRWj+E3tDZxO9Pov/rs0HLR5iZRT7+ss6eQzrJ/sxhTYvB7ZONla8JWgnQDXlUdaybVYvkZxFOFYwYZtnagzIfaJY3VryxoZ6YbteMuk1lClWJ/DB0uB8HPckUQNWJpbfX3Q/fJPg4so8jaaLS1hxJOTqn97Da/6agTpVTRBTxLyyG0pyu0GTA8y+aF7lOUr+qm0mNubhEs9OmBdyeHRB2WRsFxUF61D+r0VGzEkueEAExgz6xbQl+B0JV+3i4p+1tTf9D3B0qv2jCEICxadUO84KUulV/3Q1wPXxXpiSTSQrKiKTfTAV6CU3DPrpEoBo3ajeMyP2X46y1U4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PYCCwNPuiCauMhIah+ZbAG0Slmri9UjLdR/8GL5t1IA=;
 b=f9uQv8RC9plend1e/pO4/TGX6xrRXIeaDr43L3k8RrBLCzyxQHsU2OmH6nvp7qApKNgfq4KDUppAaWElJdKLWLWXk34PYIwIth4+67ARKb4syqolp+t4GOyokLRqiy9r4+duae7ww5+ISWEf7MjOMWanxptzAGuZGZG6G+HbrGXjOl6rDU2PmcO1IxXbklzS2pbXsQV25KGUcr/cN+tZIWHyvUDSKeqdrCEKP9VynoBGyXht9oPf822r3TTkfWrz56+6K4F35cn9acpGvvPqevAEiRXl/K5RbL0Md8UII1XDDRdQiCUwICAlfC6XJ/4E0wtOYg1zQTvRivJUExT5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYCCwNPuiCauMhIah+ZbAG0Slmri9UjLdR/8GL5t1IA=;
 b=k31C9T1GqHKZEUrjQQsIpolSLZqZbQKaqGfQv+Zm1Nz6CcAWvHHnisuEyU5tS+iv8GidGKb78LwtJJGANadjWkNzCYizWvkjNr5kmaQV+qPN0bSGOEZvUpsSqicHn37fy5K5ny5r/9+D+txbRyuDyxbEcW95Rffggrh0uTgygaY=
Received: from BN8PR10MB3107.namprd10.prod.outlook.com (2603:10b6:408:c2::18)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Sat, 27 Jan
 2024 10:09:59 +0000
Received: from BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::f03f:cc66:b93:fe45]) by BN8PR10MB3107.namprd10.prod.outlook.com
 ([fe80::f03f:cc66:b93:fe45%7]) with mapi id 15.20.7228.029; Sat, 27 Jan 2024
 10:09:59 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
        Eduard Zingerman
 <eddyz87@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: Re: [PATCH] bpf: use -Wno-error in certain tests when building with
 GCC
In-Reply-To: <CAEf4BzbOqLaFaDdYcfH=TTqnB0doaHz55FxKwBuHyB2oRyxk5A@mail.gmail.com>
	(Andrii Nakryiko's message of "Fri, 26 Jan 2024 15:07:49 -0800")
References: <20240126185059.4376-1-jose.marchesi@oracle.com>
	<CAEf4BzbOqLaFaDdYcfH=TTqnB0doaHz55FxKwBuHyB2oRyxk5A@mail.gmail.com>
Date: Sat, 27 Jan 2024 11:09:37 +0100
Message-ID: <87plxnt7dq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::12) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR10MB3107:EE_|SJ0PR10MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: 92c5762e-ffab-43f3-7358-08dc1f20169f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HCTstTVHp3MsGyfLrsgchvCjEAPpM5GD7ZNepmlhlOkUxKPYN+psZmtf8C9dThikNYl1awqMsslaZnhg4qHwe5D1421kvgh38gr6QZpSeNFzz97ufn/1k+lC0V8faQ0lm1BFLMenORmdb6XqijuPjnxPk2mb6V4381C60pUM79AJaVbrJ5jwKTRQ141XxakGVJLKaswqOlr5kIE+ozdVOy8b/J/PbWpkeUAw1eG4z3i7znMzUMyiQZga7HP3z4gJ6dn4pH6TVplFx/eCw9Hp/tXuiAMvnsySFFYH3DGdkjIcVB7aSsOHG7Knl0Su/PuK+dtvzLb8Eblb1o45PO26po32FIc3zsT9/2cko/EKV3Evf3eNxo+QYcmSikFvyL7p/iVKyLMPEwDNgdzfZJe7kiGHIskZQ1otkSN+x1Hc3/EpvgmHVHnkpY0AN7H8eyKtuelxW30t0FwBqfEnbe3DA+TQw84dFIaWALjRlH0IPwQQAP4h2y3yXqhe0zRpQ75ubZLYYE95rAPW5UVLEIWo5pd6jJoy1qh4JlqnaLbRV5i15Huvf6e2x8/gQnirL2hmjbEcsXrStUafDigW1fieeffdmaOPWmbIEv5a/pd6/9+5P3Ib7cnS0VsQz4m5eE4b
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3107.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(66946007)(86362001)(316002)(6486002)(66556008)(54906003)(478600001)(66476007)(6916009)(38100700002)(26005)(6666004)(6506007)(107886003)(2616005)(4326008)(8676002)(5660300002)(53546011)(83380400001)(6512007)(8936002)(36756003)(2906002)(41300700001)(66899024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OUJEUUQwY1JrNEdPMHBmMklDZU1NcGdGd3ZheFJaZktISEd0bm15eHRlcmY2?=
 =?utf-8?B?Uk9UMkNXZkJhNUNETVBVUzY3bDJkL2pra1ltejhuN0FMVW9iQ2NZbWtlZE9p?=
 =?utf-8?B?V3AySnBZZk9mNVYxQ3lIclJoZUVzUCt2bTZKbG1FNWpTckJGbG43ajFld0Yv?=
 =?utf-8?B?cGRlT2RaSmFsMW5KdW9FdU1Ma2NEMEJoQnhORWZwSVoxVjVJRVJlUmlxQzh5?=
 =?utf-8?B?K2Z0T3VtczNGS1F0T2d1MnpGSi9IYXVhR3hUR1pUNDhPRnlJc0kydlovZTl5?=
 =?utf-8?B?Y1NRMmVjSERRMEUyTVZub2R5cVlqaFlWc29iVUhvOTdzZU1vWDJoWHR6WkRk?=
 =?utf-8?B?YWRjcW5tVVJvVHlvWnk5cC8xUjlSN0NFc3pWTWY5ZHo4NEZBZXNqWUF1ZnFF?=
 =?utf-8?B?MVR3RFgrNy9lU3ZjWmxQZ1dDV2NhdklJWVd0Wmh1Rm56NGpTLzJkZVUxNFRK?=
 =?utf-8?B?TTJBT1RQK1Avd0prbDJyUjd3Ykt1b1FIaUJhb0xBUGhQcEVqL1hhWWkwUnNZ?=
 =?utf-8?B?b3lZeGVrczE5RWVtalp1dEFGU01kUnYxN1RGWUcxQWdQd1RVYXBhMncyOWZ1?=
 =?utf-8?B?bmdCRDZ6OWZhTms0L1JQWGxBTEdqV2I2VUpNNHBMMjQrZENydERWaGdTOERl?=
 =?utf-8?B?VlRCOWFEUHF6eE5LeCtqbndkL2ZtK1BTbkRjbUZzSVdBa1NzNXUwZTF1Y3Bv?=
 =?utf-8?B?OXBtS0RaZ2krZlArcHJpQWJ0ZXl6Z0tmYk5WdXAvbU9nMWt2eGRhY3E5ZjRX?=
 =?utf-8?B?b1A0RmZZMDdnMUI4WHBrVDFjQzdEUGdmUlc0QS95WFRLeFpKYkFLSDFMckd3?=
 =?utf-8?B?OTA2YThFU25UYjl2cDRKR0FuWmZwbWQ1NWNRM0crSHlCbHJ0c2tiRkZPRWVu?=
 =?utf-8?B?VzZIWFBPeTVWbms1Q0thaXN4UW83R3F5WmtuZ3N4NDNwbEN4TzliZTc1a1k4?=
 =?utf-8?B?YU5vbDFLbmdGeTAvTUFud2ltRlg5L0tkWHhRWVpNbE5ZOHp6OEsrNXpvMnJl?=
 =?utf-8?B?RW5OejNkd09iWmxSMTJSR0VGVFVmSVFlQ0ZIQ1gwZEtYNU1vL3ExenlTaEhL?=
 =?utf-8?B?R3RPbFlvbi96eXRFNGxHN2dYUDQ0OXdIQUEzb1JCWlpLbXkrZTRGYnVhR0Rl?=
 =?utf-8?B?NG5HYUdWKy9YNnlucVVFTmh0YkUxa1JyUmFPQzZmOEJnZDkvV0R2K3IxYWlL?=
 =?utf-8?B?bkhTengyTXhsN1BtU1FzSzROcXl3ejRwbzZUelJpQldDVzl2VlNxcTJ4cEpW?=
 =?utf-8?B?aW84b0h4b1FTalA2ajBYdWdXTDNWUThBT1pqS3BObWtId1dpNk56bUtDRnB0?=
 =?utf-8?B?UUVSUzlpWHdKVE0xaFptTmJtbEMwL2c5MmgvM3g0d2VVUFZ3ZDY1a0xmWUxS?=
 =?utf-8?B?N1lPb3B6MUVOcTE5MTd5bWhEWElNTG05YW9nVkpjc2lEZmY5b2tqTGdITlIr?=
 =?utf-8?B?OWZPcjVlUFFOOWd0M1JjbnNaR3dyOS9HbCt1K0dwZnQrdmkzQjdhM3N1T0pP?=
 =?utf-8?B?dmlxVCtPSW91eE4rY0NZMHJ0c2d3eDBKQzVmdGlPSStCRXJDSXpEOWwxMzFi?=
 =?utf-8?B?cm10QnUzdDJmVEc4bGpNd0l0bExyVXBid25hS1Z0dkN4aktEN09CeEkwYU82?=
 =?utf-8?B?VVgxdXVZVmRrZ1lGY3N2V0xROVd2MWZPQVYrMTFoZmVUUVA3bTFteW85QUFT?=
 =?utf-8?B?WmRoaldmNDJHRWdMd2RDNC9jYUd2UjJ6bmI2ZXdUdTVkMFpXcGxBcjB3RE4z?=
 =?utf-8?B?dHlXU1BNZEJFSm1kOWlNZURMNDlhczZWZWdhaUxDbW9qb21NUUxqSkFwMkdR?=
 =?utf-8?B?NW1KU1lEM2lFZkxiUm5aQmtnQnFUZFZaTVlqNTVkV25Qb2ZydkpURWxWdXdN?=
 =?utf-8?B?QlpleHZZeXltanZqbHBkb0k3alptYnNyQk5GU2k2dWdlcjV6WTN3Y2hJNG40?=
 =?utf-8?B?UE5ac2UyNlJjeXo3RkhLSjdVMVZEYlpWOFkxdGNFRHBITXpRREJ0YTdmYUFP?=
 =?utf-8?B?bkw2ZnFmVEZEcEJtUDA2VnN2QkRFY2ZyVDVyN28xVm1pNEZLK1V5SnJVd25T?=
 =?utf-8?B?MFBVSVBhYUdHeiswWitKUFdaeFJTL001S2xaOVdLVTVPZ25VSVJNejMyMlMr?=
 =?utf-8?B?eFRPQitVdGpNb0hxeDBRTGl2UVJMZUxLSHYyYUoxWk9ZbnNpajVhVnRhYUc3?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0ihg8vpRiMOcnF6rr+r6P5pJUwHQKvYFK97TB0DH+JWckLMN/nGCSsoVD08siSXLbidnc+ZirjqfEhvXb5EmRXYxrkYK7DNzdFGcLDWS+xP8ek3GORqYRYRSj5BNisJVWDen0CDF9KFHV2tW74higq2mBlpJHvOx3jIIKCXwyhaYG0zSLPTMK4xjxWesburCJIBxQZ5X70O80qSi29bzkMKFx4ul7/z5I0nLbSFVyPCcfpJwJtMs2IQMrdVAgDVY9+Bdjk4vRKK3ciP95zp7dom+ZCtR4gkpXhvBJL8Nr9Wkcp5VfTWiPTMbeb/hBOPkfudo/UstN8BeGcLF8i78xKxIOAJnUwNwyYbSW66F5WXbsTSsxIdCpYoLzQabS89w85yme3Jc5pXd3tiqFpWoSNPzkLsRWBuKFI0PeJrbwzUFH2WhS5w2YkQHmOqFCnYYlBqasEZRRD66slDz7X4/po97uoLSyRkedknqK4ELY0B5oSUZVgIYazE4pMaKeQkGl94Kxb3l79MV2Omhz7GGfxubkRh2O21ziX6B1ACCWEoIOykHZW0s/epwN+S8CWL50dDnqg+soCho+Di+hgxSIXQlQkyduYl98KyCj0zxPZA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c5762e-ffab-43f3-7358-08dc1f20169f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2024 10:09:59.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6DrvDu38hfZHzr1rrZKfaUDgJajT1S9HxYWc6KRm0G9hEW0z6xWcxkIvgLJ9evTj2bBjC/HMbsKvizrPPiP1BLVlxxTqX/rRKfN7aIu8dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401270074
X-Proofpoint-GUID: wt7u2PL254ttkpkAgHwT-xjBRYbgMCmG
X-Proofpoint-ORIG-GUID: wt7u2PL254ttkpkAgHwT-xjBRYbgMCmG


> On Fri, Jan 26, 2024 at 10:51=E2=80=AFAM Jose E. Marchesi
> <jose.marchesi@oracle.com> wrote:
>>
>> Certain BPF selftests contain code that, albeit being legal C, trigger
>> warnings in GCC that cannot be disabled.  This is the case for example
>> for the tests
>>
>>   progs/btf_dump_test_case_bitfields.c
>>   progs/btf_dump_test_case_namespacing.c
>>   progs/btf_dump_test_case_packing.c
>>   progs/btf_dump_test_case_padding.c
>>   progs/btf_dump_test_case_syntax.c
>>
>> which contain struct type declarations inside function parameter
>> lists.  This is problematic, because:
>>
>> - The BPF selftests are built with -Werror.
>>
>> - The Clang and GCC compilers sometimes differ when it comes to handle
>>   warnings.  in the handling of warnings.  One compiler may emit
>>   warnings for code that the other compiles compiles silently, and one
>>   compiler may offer the possibility to disable certain warnings, while
>>   the other doesn't.
>>
>> In order to overcome this problem, this patch modifies the
>> tools/testing/selftests/bpf/Makefile in order to:
>>
>> 1. Enable the possibility of specifing per-source-file extra CFLAGS.
>>    This is done by defining a make variable like:
>>
>>    <source-filename>-CFLAGS :=3D <whateverflags>
>>
>>    And then modifying the proper Make rule in order to use these flags
>>    when compiling <source-filename>.
>>
>> 2. Use the mechanism above to add -Wno-error to CFLAGS for the
>>    following selftests:
>>
>>    progs/btf_dump_test_case_bitfields.c
>>    progs/btf_dump_test_case_namespacing.c
>>    progs/btf_dump_test_case_packing.c
>>    progs/btf_dump_test_case_padding.c
>>    progs/btf_dump_test_case_syntax.c
>>
>>    Note the corresponding -CFLAGS variables for these files are
>>    defined only if the selftests are being built with GCC.
>>
>> Note that, while compiler pragmas can generally be used to disable
>> particular warnings per file, this 1) is only possible for warning
>> that actually can be disabled in the command line, i.e. that have
>> -Wno-FOO options, and 2) doesn't apply to -Wno-error.
>>
>> Tested in bpf-next master branch.
>> No regressions.
>>
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Cc: Yonghong Song <yhs@meta.com>
>> Cc: Eduard Zingerman <eddyz87@gmail.com>
>> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Cc: david.faust@oracle.com
>> Cc: cupertino.miranda@oracle.com
>> ---
>>  tools/testing/selftests/bpf/Makefile | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index fd15017ed3b1..8c4282766976 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -64,6 +64,15 @@ TEST_INST_SUBDIRS :=3D no_alu32
>>  ifneq ($(BPF_GCC),)
>>  TEST_GEN_PROGS +=3D test_progs-bpf_gcc
>>  TEST_INST_SUBDIRS +=3D bpf_gcc
>> +
>> +# The following tests contain C code that, although technically legal,
>> +# triggers GCC warnings that cannot be disabled: declaration of
>> +# anonymous struct types in function parameter lists.
>> +progs/btf_dump_test_case_bitfields.c-CFLAGS :=3D -Wno-error
>> +progs/btf_dump_test_case_namespacing.c-CFLAGS :=3D -Wno-error
>> +progs/btf_dump_test_case_packing.c-CFLAGS :=3D -Wno-error
>> +progs/btf_dump_test_case_padding.c-CFLAGS :=3D -Wno-error
>> +progs/btf_dump_test_case_syntax.c-CFLAGS :=3D -Wno-error
>>  endif
>>
>>  ifneq ($(CLANG_CPUV4),)
>> @@ -504,7 +513,8 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:     =
                        \
>>                      $(wildcard $(BPFDIR)/*.bpf.h)                      =
\
>>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
>>         $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      =
\
>> -                                         $(TRUNNER_BPF_CFLAGS))
>> +                                         $(TRUNNER_BPF_CFLAGS)         =
\
>> +                                         $$(if $$($$<-CFLAGS),$$($$<-CF=
LAGS)))
>
> minor nit, but do you even need the $$(if)? why not just
> unconditionally use $$($$<-CFLAGS) which should result in an empty
> string, right? Or is there some make weirdness that I'm forgetting?

Indeed.  Good catch.  The $(if ...) was a vestigious of some testing.
Just sent V2.

>>
>>  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
>>         $$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
>> --
>> 2.30.2
>>

