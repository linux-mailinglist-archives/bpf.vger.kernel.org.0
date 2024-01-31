Return-Path: <bpf+bounces-20858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAF18446E9
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 19:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC311C22AD7
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C33A12FF80;
	Wed, 31 Jan 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DSESEQ6d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I7xIp17C"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40B612FF77
	for <bpf@vger.kernel.org>; Wed, 31 Jan 2024 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724841; cv=fail; b=G7l+ReBO9duwd2iUgP0/6ilYI22OTeGVeQJGNhto/uQWtLPKWPwBrc43Feh5sRokhRRvT4TUfmOvZTVRPaHFJxN0IevF05g2OHKDYdd0ioEzRRObXPP2dSSNup6Yeopcp9jMxUpW5IHZbYG5dCgezNexi+L9sU0y8CuU3tKZhLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724841; c=relaxed/simple;
	bh=l78xRM7fuC37ixp8M1tFM7VXnkDFhexxGDz+zcm8zfM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B6LWRKi4+J3lN7I+1KsJyHY/uEqhRXNCxr8CkFBqDrBEimEIzlDYQ37g35DDynBcAzh6mQr35pq+1T+rWgTqeDwsi+ScuH1lt65PdLiq46O7TfYNez9vzox42n6IVYejieYIHykJtAjzTjFldX1T4VKnIFtgficVx9W/GATyZxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DSESEQ6d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I7xIp17C; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40VHC39x004762;
	Wed, 31 Jan 2024 18:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=009gEZeeSGV7S4gin/btEHPOY1pzd7h/rw95Oyl0VOo=;
 b=DSESEQ6dbzd/paCGqAchPMmSdjZqur5I/1DJQDb9aOnR+5ntBfwx1M0Njjuw+pwm4ACC
 B74AuEKYseCCfcakjDND/jPElmhgAMshjulizIgmij057g+gsW5ywwxsykSnXCP0z0ip
 53ZveJ4lhY1je0Jnt5exk1L5toFnzqoo8rj1c/Vix77SMoiE9AZ2eDn0/T/mjyQifXJX
 k801ISnnwKwjeQk1ck3Cp7A1R8DEP56oL5JQgGudEeTMFv1sL5+rGIVmcDZQ3+N5/Vr7
 3WEItPSPKj11IJGTVbjgd631pNriKuzVpfs3KlA/U7Nv8csnC0NEk8TK6/NxtOOFgBKw Uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqb2hx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 18:13:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40VH12M5036261;
	Wed, 31 Jan 2024 18:13:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9fppt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 18:13:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXMpUAy/IWAJ0bNJ3065AwgDVFPf9TKRX6BhNDHr9mZCoDtMJCRjaQ6xBPA3D1i5VHVI8rCMQoOjBtnK9NfDd8RJuC8Au1jhJDcQjQSZzfIqdBTN1WqqM/kuBFBQfKdeWGIzRJgxZnttO0Az8lEJ7vahb+1HG79W0NWLUWGS3vW6odu6C6rc/751H7ibPoc6blrtAo4kptUVwV6MNhe7V8FZbaeQ1HO323gbhSpIHQ+s5DwwdOA2iFx73mQoteRTq1ooUfHFCGIt5eHEQKByBDleLaLfU4lilqQwH5CPcM7FdwVvlSX/DHMx0QEllP/Hoe8c404Kvliye8VZ+2Mb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=009gEZeeSGV7S4gin/btEHPOY1pzd7h/rw95Oyl0VOo=;
 b=L3TDWsKmtWcyQKjIyzh3SqNol//E17eWi18ueAcQLlI9Aj/zKyUC3XA2CXwOqH+IOfgurOti/+o6q9K8G67kKhNKI2nfi4fKClySvGt3z7b6jM6D2M2Ja0BDcAi6N0RcNL1RgjFg+FaOFsEjBS3UO4kxmPvKXFVDOCUR/ohSDFxOWM0he9C64P1RLq/H6MrJLxh9/9gtd2i2cBP9nwGZnvRe9fCAMEbeRXlodhaWlHhNoMUu4PGHz8e8Kv4lES4/ixigVuzJdwPBnSSiUX2whKskkNTX9gzsVh/bt6264uGZn2czM+cb5eRktT4f8OFaiyzkO1r1XvXML8u4RTk0qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=009gEZeeSGV7S4gin/btEHPOY1pzd7h/rw95Oyl0VOo=;
 b=I7xIp17C4/3VO1NSbgN8FS6Wlyzfx0WuCb75q4vkiHeAJ1tIX+FdUQDhmbUnRAEbxO6VLQJPN0pW6xdpG5u6yclRVGJWfghg+jzf4aSFiLLoDSS/aw11jW6lmW8MgFjPo16JJx8IScy9beyZD4wJMIAbyAjeEwDJa2DGam96YnE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 18:13:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7249.025; Wed, 31 Jan 2024
 18:13:36 +0000
Message-ID: <01046526-c9b1-4d7b-b6b3-296c1bda1903@oracle.com>
Date: Wed, 31 Jan 2024 18:13:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org
Cc: quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        Bryce Kahle <bryce.kahle@datadoghq.com>
References: <20240130230510.791-1-git@brycekahle.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20240130230510.791-1-git@brycekahle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:10:c0::27) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c040126-8c7d-4df2-d982-08dc228857e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vit3StFuLxxTpqyZLbYoeNX6l72cXh/UDvgPWNGMCeHJ7SDyh0X4cKBnUqd6UIXGZZgge/Xa/TV5C3cmdZMzsQdxcbwxQ+NnriT/S4PnwjVcLmsMCDDck7JXT+2V+DxVevq86w134JbUftYoSagElXwEfjWRfJpo1ZumLGL24p52ZGcs6bAFacWZukq/Fy1odKkVPxB01puyLq35Hb8eTTHNsOX05FdbUfIeJIVbJQWeaMwzibvF8t5ovEmMIOyvYZ5b3s+DR0ZJgkYwq9guWtcRzbpCzKOB4Vdo6Ac17XN8dmuomsJCgoscI9zzCC6kx1a9iHsuACRn+zx17GZUvrV3HdjrFUz2ievUhtPnCrFsrN63IDq0WiDM+6atdz5Jc86oeH++mGuNDfvrzweTBbnsKS5pMcBKu7Rx72Em3teYgQCRNnbEG/MnNOQdjV0ZJVVC17VZ570Nyjjbp5MMQJrk8GjeivDiBfNJ3f08Fs/M25Actpfq9+7KOXTZRfaVkwJwhKbrm1WJEmaw0OktEkabcH94m388B8eX36CT/RdHTW3i/ejWrJsnLRolS5dXokQmbGkfPWgSDL2lKkEXaABvhkCuk3oHHT2gG4MZUO7iClLVz26nJbDSsC0xUxvBNTmjvZvHsH1gW4LtQ9fWRQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(83380400001)(478600001)(53546011)(6486002)(41300700001)(6506007)(6666004)(6512007)(36756003)(8936002)(4326008)(8676002)(66556008)(44832011)(316002)(66946007)(66476007)(2906002)(31686004)(5660300002)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NGJGWTh3QjJ2QUZRN0FnNng4U25yY1hhcE0rRXBHU0ZNV1Z3RTZzanRXYXVq?=
 =?utf-8?B?eU1DdUUzeUdXb0VEcVdBL0dCNlBkZ055LzlhVlRodUp1elhvZUptNmdHVy9o?=
 =?utf-8?B?MncrWE1FSUhHVmJISVpGSm4rbFZXaGdtQnpLZ2xmR0NreXh5dlNLYVhGVDVo?=
 =?utf-8?B?U1JFWGNWUGsxZzRyVW0xdGtFazluQ21QdUUzWjA4WlY5Q2RJTnNSUUdzYkh2?=
 =?utf-8?B?OU1mUU5XU1l6N1pra2Y3Q1JYL21UYWlOeUhrT1Awa0MrWHZuK3k4WWhuVmxS?=
 =?utf-8?B?RWIwc0trdTlGLzgxNks0VDU4UzNMM1NBMVFYUThEUVUwWEs5ajJpODlYQVQ2?=
 =?utf-8?B?RVpWOVdZUm5hejB2Ky9Od0tLV3ArZmd5eXhvSWhwcUxVRXJhVzBkSnVlZkd1?=
 =?utf-8?B?Q3J0V3hOMjhIMWFiUjBVaWRxRnFhM1dqRVJGVnRzU1Z5a1k1MWt4UCt1aGMv?=
 =?utf-8?B?a0lGc1RlM0RSV2JUNWRHR1pnUDhHWjIvcUpkb2NxTEx1Q043eDVlQnpJQVAz?=
 =?utf-8?B?MnVMNHkxQUVuaWFoSCswcmhrNlVEQTgzdUZrMEtNb3U0THF5c2VaV21mWUIx?=
 =?utf-8?B?K1MvV1BVR2JqenA4Z09oeWVraHAwMm1QU2dCUCsyK01iUzVrNE0zZ0pxRjVS?=
 =?utf-8?B?akpjbDgxbG9UOStDWm5JbUxjeW14dkEwLzFoRWxXSW1LaWtKbTJTaVovd3Nw?=
 =?utf-8?B?cXRIa3lHWFNZU0ZyWXFJWGVmUWdvcnIvVW5halNnUkpnOUpuR2REN21XZVpm?=
 =?utf-8?B?UGljczQreUJzL2RiWlBXSlNqN0VEaUlRV2ZOQlJROGx1d2tsUEt0NHVDUVly?=
 =?utf-8?B?bmxOMFVpQmpod3RQbXE3MCt2emlBakNIOUpDQmkxYVJzZDZVZjFRYXQ2ZTdI?=
 =?utf-8?B?cFFmeWsxaGpFTVRZRnRaRnM0WTZUVmJ5NlNXM3hYSU5EVGdMckg1bEhqUldx?=
 =?utf-8?B?ZXN6TkEyY0RqeGRtTDdyNUlwVUZwQU56TXFHWDI1QXJEWjZMUXQ1a0Z4eDRG?=
 =?utf-8?B?VUxFaHc5Z0x0aWNSejJCc2xNZU8rbTIwSDB3RlhQaUxXaTJxc1lhNlc4Qnhv?=
 =?utf-8?B?VVBNR0taTUdFdWVETEpKWG16TGN5UllrN3pEOG1Db3d3VU9JK01yRklQOW5F?=
 =?utf-8?B?VkNSUHpBbEEyS25XYTdvMWVlNlFGM0cxcERtdUQwb1NxVHRGV1VweER5TWlK?=
 =?utf-8?B?M2dmc25Cek4yVm1Wc0c5djR2YVFWYmJEdDJubktWUW5yMk1SalJrdnRBbjIy?=
 =?utf-8?B?bmJXZTJBTzV1VFNXVFpPK2orcEZnN0Z6ejZzNmp4SS9QWm9yR2JNeG1WNE1m?=
 =?utf-8?B?TmtTdUQ4dVdOYjVMV0U3eitGRVBLVllUSEhjN3YzcldHdGVkRnNaN3BnWTQv?=
 =?utf-8?B?YlBFTk4waEx6bHhSV2hDUDRJbHRXSVd3U2tBcjRnOHY3WlV0dDRKd2pFZjlz?=
 =?utf-8?B?N3dLdzB4U0tWM3haSkVRQXRTbWN0VUZFdjUwUjRYK2ViSm1WTjhEczVhTXRv?=
 =?utf-8?B?NUloZFNlSU1GSG5DN2M4aGdmUDRBdHpGbE5JWDhBZmdYdk10T1dGT2RFQzMv?=
 =?utf-8?B?M1A2aktVUjFVNm5xY0FBbmlWUk5PUHRjakZLV3QwSlpTN1dMaUR3RlVLaSti?=
 =?utf-8?B?NXE1emErd0hrRDcyb2NINUhMVVhyQWtJczhmVkVOTWQ0TW9GNmxYMlpSM25Y?=
 =?utf-8?B?QW9ycnVXTS91Z2ZkR0ZveEgzUW41Rk1xK21xY1RLZ2h0MzgwMERHR3NyVnJo?=
 =?utf-8?B?d2NpblBLZ2I0dlE5V1hoTzNpVEJRdHdESVU5UERLUmhBeUswOXBHUkxzUmIv?=
 =?utf-8?B?d2dHL2FIZGZjRVpqZytlNVJSeUVkaGppY2ZOUUtIeHpIQldQcnhCYnpsd1Bt?=
 =?utf-8?B?VTBzQnhpdCtLL1I3NFFBMXUzdHhjTWxZTHRnT2RYVkpaa05oUFZzRzIyT0dn?=
 =?utf-8?B?SjZleGpjb3F2b2xSMzRnSmd3KzIxRDgrcVBXUnlPcWJRNDEwZUVOMHB2eVlz?=
 =?utf-8?B?a1RqS2ZmSXVCbmo1MzNHT3pBZE1IL205NVpZeS9pS0YybXhLMUx4N3hLZ3NG?=
 =?utf-8?B?eXoybEZmNXltTG5xdENQWkRCa1FqL09GVFBwbTA0YkFDWUI1dHhVaXVLeDYw?=
 =?utf-8?B?T2ExQk43dDRzSGxuMDNwNWpuRkY1YlgxMnNCS1BacWlMdGlPa1JCMjNzMmc3?=
 =?utf-8?B?cmJJbWF2MDV1ZS9rYVUvWHVuRU1UVTlyOHdsendUTHh1M0RWYlBVNm9HU3NV?=
 =?utf-8?B?UUtnOEhuai8yTjNQVkt0VUFDcVNBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cWA1+nPBmhYTDXBUkhrL+FZrepZCqnAAnics2FVNGcgZ80HtMwPGnxnXHWTJyysHEwa19ttVHpz83NPbWbfcywDCvMGw9jqosGu3wuHMJqXACj6iJhwvADiHXzZBPh6jj6uOAqEJkTnU5Pm/TUTbH+5miCa3PipL6JH+FKuUEiESd5FE/9F7j2n1QRg0T9Rev1AYobhuGNPR46GUhZYGRa+6/FWmr4jP85OTugzrFeeakSwTexoA1td0lzS4LYQi6sG3ZvQk7EdBEl8N+rGkX8KUdkUXbsm7Z3WD+YCPTn9RxczlWMeYZgsfIUvACM+p2Y2+OMVXa88k3nOAUkHJbzHUILpUV6BAH+oec+2sQQVe3k2xr38AfCfvVYKZsT+wnbeqWy7u4JXalBNOQK2IFbIo1diD/ma+diI6wqAL/vFELLTssFt9TzEXAIx8dJvPZObnAJTMQYS0ysu5GXLGmrCR4x6T7OOXP42M7tXQfwszJGVJjPVaROwUdaNoHuueOQDeFvI7u+HsJcMrhg8mS8gZVKvSmXexvEvGiK58dctrVAmd6wbeDFqhRVV3ttSmOqLMThhIRFb04c5UKDo0R4hUVSw5TxyJ74mxQEoog5E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c040126-8c7d-4df2-d982-08dc228857e9
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 18:13:36.6705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er8kvAZ0hHbRuw+MzPAk4tVyMBgkAIPDHw7IN12DR9lVgNZh2rUxD0/NkJToeeQXRZn0RV6HPFhxwbzmucWfPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401310141
X-Proofpoint-GUID: 0rc3n-WJJx3r8P62VrXLHOy083gWHZq4
X-Proofpoint-ORIG-GUID: 0rc3n-WJJx3r8P62VrXLHOy083gWHZq4

On 30/01/2024 23:05, Bryce Kahle wrote:
> From: Bryce Kahle <bryce.kahle@datadoghq.com>
> 
> Enables a user to generate minimized kernel module BTF.
> 
> If an eBPF program probes a function within a kernel module or uses
> types that come from a kernel module, split BTF is required. The split
> module BTF contains only the BTF types that are unique to the module.
> It will reference the base/vmlinux BTF types and always starts its type
> IDs at X+1 where X is the largest type ID in the base BTF.
> 
> Minimization allows a user to ship only the types necessary to do
> relocations for the program(s) in the provided eBPF object file(s). A
> minimized module BTF will still not contain vmlinux BTF types, so you
> should always minimize the vmlinux file first, and then minimize the
> kernel module file.
> 
> Example:
> 
> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o

This is great! I've been working on a somewhat related problem involving
split BTF for modules, and I'm trying to figure out if there's overlap
with what you've done here that can help in either direction. I'll try
and describe what I'm doing. Sorry if this is a bit of a diversion,
but I just want to check if there are potential ways your changes could
facilitate other scenarios in the future.

The problem I'm trying to tackle is to enable split BTF module
generation to be more resilient to underlying kernel BTF changes;
this would allow for example a module that is not built with the kernel
to generate BTF and have it work even if small changes in vmlinux occur.
Even a small change in BTF ids in base BTF is enough to invalidate the
associated split BTF, so the question is how to make this a bit less
brittle. This won't be needed for modules built along with the kernel,
but more for cases like a package delivering a kernel module.

The way this is done is similar to what you're doing - generating
minimal base vmlinux BTF along with the module BTF. In my case however
the minimization is not driven by CO-RE relocations; rather it is driven
by only adding types that are referenced by module BTF and any other
associated types needed. We end up with minimal base BTF that is carried
along with the module BTF (in a .BTF.base_minimal section) and this
minimal BTF will be used to later reconcile module BTF with the running
kernel BTF when the module is loaded; it essentially provides the
additional information needed to map to current vmlinux types.

In this approach, minimal vmlinux BTF is generated via an additional
option to pahole which adds an extra phase to BTF deduplication between
module and kernel. Once we have found the candidate mappings for
deduplication, we can look at all base BTF references from module BTF
and recursively add associated types to the base minimal BTF. Finally we
reparent the split BTF to this minimal base BTF. Experiments show most
modules wind up with base minimal BTF of around 4000 types, so the
minimization seems to work well. But it's complex.

So what I've been trying to work out is if this dedup complexity can be
eliminated with your changes, but from what I can see, the membership in
the minimal base BTF in your case is driven by the CO-RE relocations
used in the BPF program. Would there do you think be a future where we
would look at doing base minimal BTF generation by other criteria (like
references from the module BTF)? Thanks!

Alan

> v3->v4:
> - address style nit about start_id initialization
> - rename base to src_base_btf (base_btf is a global var)
> - copy src_base_btf so new BTF is not modifying original vmlinux BTF
> 
> Signed-off-by: Bryce Kahle <bryce.kahle@datadoghq.com>
> ---
>  .../bpf/bpftool/Documentation/bpftool-gen.rst | 18 ++++++++++-
>  tools/bpf/bpftool/gen.c                       | 32 +++++++++++++++----
>  2 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> index 5006e724d..e067d3b05 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
>  
>  	**bpftool** [*OPTIONS*] **gen** *COMMAND*
>  
> -	*OPTIONS* := { |COMMON_OPTIONS| | { **-L** | **--use-loader** } }
> +	*OPTIONS* := { |COMMON_OPTIONS| | { **-B** | **--base-btf** } | { **-L** | **--use-loader** } }
>  
>  	*COMMAND* := { **object** | **skeleton** | **help** }
>  
> @@ -202,6 +202,14 @@ OPTIONS
>  =======
>  	.. include:: common_options.rst
>  
> +	-B, --base-btf *FILE*
> +		  Pass a base BTF object. Base BTF objects are typically used
> +		  with BTF objects for kernel modules. To avoid duplicating
> +		  all kernel symbols required by modules, BTF objects for
> +		  modules are "split", they are built incrementally on top of
> +		  the kernel (vmlinux) BTF object. So the base BTF reference
> +		  should usually point to the kernel BTF.
> +
>  	-L, --use-loader
>  		  For skeletons, generate a "light" skeleton (also known as "loader"
>  		  skeleton). A light skeleton contains a loader eBPF program. It does
> @@ -444,3 +452,11 @@ ones given to min_core_btf.
>    obj = bpf_object__open_file("one.bpf.o", &opts);
>  
>    ...
> +
> +Kernel module BTF may also be minimized by using the -B option:
> +
> +**$ bpftool -B 5.4.0-smaller.btf gen min_core_btf 5.4.0-module.btf 5.4.0-module-smaller.btf one.bpf.o**
> +
> +A minimized module BTF will still not contain vmlinux BTF types, so you
> +should always minimize the vmlinux file first, and then minimize the
> +kernel module file.
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index ee3ce2b80..57691f766 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1630,6 +1630,7 @@ static int do_help(int argc, char **argv)
>  		"       %1$s %2$s help\n"
>  		"\n"
>  		"       " HELP_SPEC_OPTIONS " |\n"
> +		"                    {-B|--base-btf} |\n"
>  		"                    {-L|--use-loader} }\n"
>  		"",
>  		bin_name, "gen");
> @@ -1695,14 +1696,14 @@ btfgen_new_info(const char *targ_btf_path)
>  	if (!info)
>  		return NULL;
>  
> -	info->src_btf = btf__parse(targ_btf_path, NULL);
> +	info->src_btf = btf__parse_split(targ_btf_path, base_btf);
>  	if (!info->src_btf) {
>  		err = -errno;
>  		p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
>  		goto err_out;
>  	}
>  
> -	info->marked_btf = btf__parse(targ_btf_path, NULL);
> +	info->marked_btf = btf__parse_split(targ_btf_path, base_btf);
>  	if (!info->marked_btf) {
>  		err = -errno;
>  		p_err("failed parsing '%s' BTF file: %s", targ_btf_path, strerror(errno));
> @@ -2139,12 +2140,29 @@ static int btfgen_remap_id(__u32 *type_id, void *ctx)
>  /* Generate BTF from relocation information previously recorded */
>  static struct btf *btfgen_get_btf(struct btfgen_info *info)
>  {
> -	struct btf *btf_new = NULL;
> +	struct btf *btf_new = NULL, *src_base_btf_new = NULL;
>  	unsigned int *ids = NULL;
> +	const struct btf *src_base_btf;
>  	unsigned int i, n = btf__type_cnt(info->marked_btf);
> -	int err = 0;
> +	int start_id, err = 0;
> +
> +	src_base_btf = btf__base_btf(info->src_btf);
> +	start_id = src_base_btf ? btf__type_cnt(src_base_btf) : 1;
>  
> -	btf_new = btf__new_empty();
> +	/* clone BTF to sanitize a copy and leave the original intact */
> +	if (src_base_btf) {
> +		const void *raw_data;
> +		__u32 sz;
> +
> +		raw_data = btf__raw_data(src_base_btf, &sz);
> +		src_base_btf_new = btf__new(raw_data, sz);
> +		if (!src_base_btf_new) {
> +			err = -errno;
> +			goto err_out;
> +		}
> +	}
> +
> +	btf_new = btf__new_empty_split(src_base_btf_new);
>  	if (!btf_new) {
>  		err = -errno;
>  		goto err_out;
> @@ -2157,7 +2175,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
>  	}
>  
>  	/* first pass: add all marked types to btf_new and add their new ids to the ids map */
> -	for (i = 1; i < n; i++) {
> +	for (i = start_id; i < n; i++) {
>  		const struct btf_type *cloned_type, *type;
>  		const char *name;
>  		int new_id;
> @@ -2213,7 +2231,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
>  	}
>  
>  	/* second pass: fix up type ids */
> -	for (i = 1; i < btf__type_cnt(btf_new); i++) {
> +	for (i = start_id; i < btf__type_cnt(btf_new); i++) {
>  		struct btf_type *btf_type = (struct btf_type *) btf__type_by_id(btf_new, i);
>  
>  		err = btf_type_visit_type_ids(btf_type, btfgen_remap_id, ids);

