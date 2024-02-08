Return-Path: <bpf+bounces-21557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB584EBDD
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E317B255A0
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 22:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87AE50250;
	Thu,  8 Feb 2024 22:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aE9bX37f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EfuQ3FKN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B6050253
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432358; cv=fail; b=LKwm4tUxUTuxG4l8UW5P4aixd/gDKcUIzAE+DwE8RepxhbRLV9iPDH7FOo/UrMBBS4z5IoBdnkK/syQIqPtuqQhJaA/XISGQo8dSqYGRBxMMubVuebF+1R2uSSFyh3lnmFqebzkRoshiSupS5mGHKLGKEZLPAwC/zt6THxGnu1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432358; c=relaxed/simple;
	bh=oxaALLNW/rIP34k86lmhIqiMntBoTz3+W0L4ROVRVlw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fAquL3kDgWBPH4soFVki+1YLINedaNm1cPTpgNquNYqcZHFby5LMCFJZH0TRnJdch8KJM9jbzI5KN1OpZCnvB7ce0CO0IahmVJ/IXbCTjqciywXMezGBaJGLsRaMpthN5r4UbJsR4Ahiuizt5fIgwKXO9OSdU4gpURFPo5Hfrtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aE9bX37f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EfuQ3FKN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LTWJA000531;
	Thu, 8 Feb 2024 22:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=9ldEt72qf+hgeAU96dQpnOVKIRKpiYQUcjOHlg5qSvM=;
 b=aE9bX37fh5UFkjMGAp2L6fVJupzZCj/w5I8AOlVQZ1Bn/IQfHfCfzaTAgtnzikMJUr04
 fMcW+bt/wZw+q3MMFLoIFfbq3BDbUmPUEpZr67JAyj2x2LKz9Dq5oVX/S7Qo8JpAKvyb
 X/eu2yOHopgTX88JAkn3S5SXfP2q57oGGYqNLWr+OW2/VUcvai+GVpxVqO8g0XUpb8XA
 3dsxjfmD3xEKk138us6m9K/HrefEZdl/JCwCPxzV7XfOZplZiiF1SenwnD0XVv0s4K8Z
 xY/xNSZfO7XjGoU0hHqE0J5le2fFmuQqCN22LmUhpR3a8EKhJTQam/OMWARobxTSEs4Q pA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1cdd64hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 22:45:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418MVYsj019727;
	Thu, 8 Feb 2024 22:45:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxhp3uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 22:45:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTxqAJtf0FAI3E7JxSFdTaQcdyS1bDg2BKtTphUY4H5/n051V61ANzxOuUvr1Y23p57NwF+d0OTuUrl0yATg2+L7oZaS0yOM7J5ue/nHgnfv8xq9fLmeNiJiVU8Jagi/LdLvQ20++BeJnbW1XzfziM/q7Ss0RSN1tOcbnLefBScEmHkyR2oi7RBisu4zEFUzbaVX9Ave/jWHABuPbPuYJNox0rycKKmdLgs/Mm/xZticTIvlNgoyPx/RPmyQHBmEaTU/Ugep6bLOotQ5HmnAgN6gXf4AaSBTucdAF3DSPJcGN4kLqsLi0img7atyZy3Ux/wt8FtBWL0BViZEoSKm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ldEt72qf+hgeAU96dQpnOVKIRKpiYQUcjOHlg5qSvM=;
 b=AEl/vnuCIRTbYXy4bdTuxgmsBayaF6nJaYNW25dOonT7u3vdyzoPrJOTDmemRQOQpHHlOzIQBiRwk9ZLoOofQlt/HWqGHSeV1u22Bs2pnQw3wZzHNYe0RwgviwQoeyVh9Sj70LuxvippitpUDLl/N4AxTDhDhckEFIn+7MKT/Jlz3AYoC1IGkxNUXZwQ5/nm1Ijm3uTEaVL2RnZzFsc579Ycq/cKSyuufceOVpocJ6Q5/kmQm9FGuQennEwJJ0pwva2H1YJedXD1xG8GQxz7H455xM8HJVScDB5U6UtvOUffFzI7AGz72CILPRwNfpNxDm/vJYR6KODyP/+75Bcniw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ldEt72qf+hgeAU96dQpnOVKIRKpiYQUcjOHlg5qSvM=;
 b=EfuQ3FKNdJJlHosJO5i+B4bGpzs8pNRY9F0chRzhndLA51eq7QMvK+LPd/cG3nMl0NufMN4KgCP6mXZ9i1NRUkeb4Sf4gA46jF0uVlVLASDlsOUEqEX6Q5HlI8uBI+D/pE4+svOP6FyUiCKzSeS0Syhd0lG6oq5TVbbAlnZlfAU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY8PR10MB6706.namprd10.prod.outlook.com (2603:10b6:930:92::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 22:45:32 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 22:45:32 +0000
Message-ID: <db6628e6-74e2-4fb3-8e43-8588956684dc@oracle.com>
Date: Thu, 8 Feb 2024 22:45:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bryce Kahle <git@brycekahle.com>, bpf@vger.kernel.org,
        quentin@isovalent.com, ast@kernel.org, daniel@iogearbox.net,
        Bryce Kahle <bryce.kahle@datadoghq.com>
References: <20240130230510.791-1-git@brycekahle.com>
 <01046526-c9b1-4d7b-b6b3-296c1bda1903@oracle.com>
 <CAEf4Bzb8zopBkfSxynV4DwzODgvPeM_M9rDJ+BtrfriW+TyAZA@mail.gmail.com>
 <53c5bf7a-97ef-48f6-90f2-d2a170acf1b2@oracle.com>
 <CAEf4BzZm-fSSQbp85dx3exoPK2oRhNFg5Op0ggcaD7ZPv=XCxg@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzZm-fSSQbp85dx3exoPK2oRhNFg5Op0ggcaD7ZPv=XCxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0550.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY8PR10MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 31bc7be6-a8fb-45c7-37a2-08dc28f7a83d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8hWJz8Ej5m8NrN1DlNdUb/V8D78JOGW0PO6ROb2TNz0u/MbR2Pkp0o26DaZknz2/DO830ajL+tUbFYaeIItUqh4MgWG3T8RCTzoujksQesdYoNuvOSaBty0vVDxAJetbeJbCrbLFAWHPPf7qLp17J/c12siwl3MQdS92JAZDz24fJ5kqNWdFl21BnbWFhaZLOz5JMSk4BpaTbF9VREK2hjQ38ZFxozZ92jiGhVMY1hZ1uGs0wpiWBCs13btMZq4zIq4nE/WK+boLi7egtJyO5EbjRJtP/aV5lx73C43a696qQqo930HGyv98UbZw6zeLsIFZcNmJv+IOkIQ0sp/K3kBsELhuZrCeAikIB0h5EBoJk0gmmRpbFf1+1VRGpDS7lgmptMVLE93aZWnD3U4kijJnmLaqwJ4qX2GYDl1necXmiXTrsTyO3kWb1DKzAGc85iVk4l+ZEYzG7Dy08pDhnRoEaFcO69mDjtb13zl4glGD89ULBC5KaGztYTus8ESlWZN/VHl1X1MqemhsBYny1nUeP4X/b5DGuJjNK5iLWZ2XNFPCbJBzmgqauB87Lc5v
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(316002)(66476007)(54906003)(66899024)(6916009)(66556008)(5660300002)(8936002)(4326008)(66946007)(2906002)(8676002)(83380400001)(36756003)(31686004)(38100700002)(6666004)(6512007)(44832011)(53546011)(6506007)(478600001)(6486002)(2616005)(31696002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YlV4MzJyQXZQNVY0MzVocjhHMEFZTlZhbXd2cEw5OEM3N3RYUGQ1SHNtMW5T?=
 =?utf-8?B?NUwxSmozQ3lLdjYzcm9YWmRwL2VIK29RTFprL1pLb0RjN3dBMEpPbisraVNk?=
 =?utf-8?B?SjFUVGxHc2VXTE43d3Z1alRMWUZ6RDNsQ3lybi9MWFRIL0hXeTJFMTFINi90?=
 =?utf-8?B?YVc0MTlaVE93QURHTU5QWjhiVVlrNGdNUkROOTZKZHlBSlRTWFVkRFRXWlpZ?=
 =?utf-8?B?NlVJaHpZY3p0UUZoNUZDL1lWekRkWXYvR2hyMC9CY0RCRGU0ZEdRRVEyMERR?=
 =?utf-8?B?Z0Iwb1dzdy92bEkvVG5VWnZuQlJJMkJQd1oyd1RuWTdaVHRuTktNQWh6VjBq?=
 =?utf-8?B?QjhTU3pOejd5Rk5OTDBuOVVXU25LOUxBaWUvT0lHOG1neHpPTnlRakJITWZR?=
 =?utf-8?B?NlpsZ3VmQmsrelloQmw3MUU2THVKL2JjVnlwd2lKWldaQkZKSHlMMWNzYXpP?=
 =?utf-8?B?K1U4eVdKY3VMVG5hQ1BXbVNneWhFYWNPMlJqeDg0WVBNSUlKK09Oc1BmTklC?=
 =?utf-8?B?T0JXRGQwR0tuUmJQdGxYbjIzNStMSjBRSGR0OG5hVjFOR2QwY0xsTlFTV0ox?=
 =?utf-8?B?aHVkamxoQVpyT0tIYlhKcm9ia2RROFUzY1dDWE5iZmFoUWFWR3R2MTJuRkp5?=
 =?utf-8?B?V2UrazNsQWZVSGpsMUdac3FrY2JJYTdWQnFkaGFYMXJqMEpsUFFWS29JMmF1?=
 =?utf-8?B?eTRhYlpaTEt1ZnIvUi9tVzVBQXFJQW9LY0dkMDBsVVRrdW5Gb1pYbGdxSjZm?=
 =?utf-8?B?a09JcnRtaUhONzYzSFcvTWhGOGs1SzFnWTFSd1o4Q09QK25yVmllaVQ2SGlQ?=
 =?utf-8?B?UTNKQmg5Q1Qzd2NHNEtZMzFBKzdMZTJiVyswTGhnZit2SmRYbXl2bEIvRDZk?=
 =?utf-8?B?cmdOS0FyT2ZDYTVtYk0yekpoc0xNMWFYMFoydGRMQXp1cFBxNWRaNlRrbW1u?=
 =?utf-8?B?aFdzVWxkT2pwYVR3V253MkRwbmpBdm8wTFpzNzAxZkpYR01zbTJDN3hrWnpK?=
 =?utf-8?B?ci9YYzRiRWs5OGc1akdBazF4NzN4cU9lUnB5ZXVkaTF2Y2dDZDBSaGtlU3lU?=
 =?utf-8?B?cjJqeFh0ZXNtVXlXMlphRjZMeHJqMk11Nkx5RjM0TFJsSTZKQ2l5OWVOTWgz?=
 =?utf-8?B?NW5helNPTlFNeTYyNzZCaHdvaU9nWHE3TjdWUXBRY05ISHJ6Yi96MDN0MEV0?=
 =?utf-8?B?MWFpSG5JR1J3WjN4TjM1VWMwTVpJMlUwN1RLVTk0VFZTUGEyTlA1M3BZMUw2?=
 =?utf-8?B?eVJOL2d3ckxVSVd3d3c0QTREcEhDb1dwUjhBYkoxQVh4RnFnUXRDbW9CUjM5?=
 =?utf-8?B?TmxrVFdJRGVybGxIODVqZFJ0dzdiQjlnLzZBMXQ0aDc2NE4vYVBob3dTczg0?=
 =?utf-8?B?Zi81NGlZL0MxaFlEbVFSZmhLajVTbFFoQ0FIaTlDVFdVb0d2eUpUbUMycmc2?=
 =?utf-8?B?L282MFR1WVRHeFBZaWs1L1B0Y01OZmVYZlpmbUdxeURsYTVUcHpUTWR2VDRH?=
 =?utf-8?B?dGNKQzBMWjdaNVNHQkszN1Z6bVBQd1BGaE5wS0hNVTZpT1JUb0lKT0J0Q2JL?=
 =?utf-8?B?d041M29zeWFMOG9YNUlaaDdnR0x3cE5qWk5aMEJmamlIeFFuYU5kc3BCdjIx?=
 =?utf-8?B?MmIvTlora2xMZHVzMHM1STZURUhMWUZzOG9SMll3eWY0TGNLUkF5b0gvdDNE?=
 =?utf-8?B?K29hQ0hqejBCbTZzTFNFOEVBTDMxWjhVOHdnbDJOQ3l3U2wvTU40S1hhL2tF?=
 =?utf-8?B?Zisvc0pXaXB1T2hpQTEwNkEwOS9DNUpPeFlPWXpYaEY2Tm0vNUtveTI3VXJM?=
 =?utf-8?B?K25HaEFXT29YVlFIQ0VlL3h3akNLL3hlSEJVcGh0NFN2M21VZXZ6ckY2SHNU?=
 =?utf-8?B?K2dBU0twcFo3NElSeGlzQVJvYjBFbElHdi9ubmRlL0pIcGZyUHJLZ0FkK0xq?=
 =?utf-8?B?VzZCSmlUYlBnbEtsQ3pFdUdGVUVXSzlHcVVGdnFWM2c3MXdwQVc1UlRKRDBG?=
 =?utf-8?B?QWNNeWN4d3EzaVF3ZUJwUURKTHVLcXNzeHBzMjVVNHZzSjhkd2k3VXNCczZk?=
 =?utf-8?B?S3labVRkUjlqZnBYZlJhMFVMd3cwU3UrT2ExcmRBazZkNTc0NUFwVUhFUWV2?=
 =?utf-8?B?WTRnWjJsRnV5RmJHaGp5WUxqb2orZi9LbU1IZWlDL3lNQzNXRy9ENDY5cFBZ?=
 =?utf-8?Q?l+xhR/jzjgMVgHLLddC+v9k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	MLSNLCaJq283HR6VYLoyvCU3Hde6yJxU3PSDIGw2Q5rkBlHmJgGVq4AiQIEywPp795FD30Om/k+YuwZFKjiVizt1ICSYkvLeN1oWEv9zEPMWjU2R7F/cjX+nKJ8NdeEocZh1Iptdj5+Xu5PcB0S0toLCbIlzKVfnXJncz+lMqQ16JD9V5/YCflJ9r/AdVs0dwcWL7FZ/tCQSxCcWZaoJfee7so0wX9+a5GCxqhxOC3YE1DPaXaKroTxE5o7nzYtFYQgSL2B90hIL3IFcGVd+na475CEY9pTXY8J1cbVs9IqCtZlikoQyotQU30sbgDZU8XbtWAYP/u8jn9sGYJy+cPyz0Y+Rb9t3cywtzrPR5363V4IzzVb69qb5tJK1fJD5ji+ioigB0QgQtXNovqEJ1mVJCIFyRrpytYwYlJF9KBvBCTyFhSK1sqIdFnEV7sNFhsjzjwYwXLjGhJ28GsP8w9IJVmgMM3ySbCDf69lQLwinn2CDVejc3UuaVdh7znVfFsdaM6MphgrGh6KAM95NMiexjvYp/zkm77Yn3DsG0jyJACmu718QooJwnl/Qrmjx7jvOBCZO0Ppus714D4gTxt8arkfK9KjWvY8fS9M1MoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31bc7be6-a8fb-45c7-37a2-08dc28f7a83d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 22:45:32.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLZ1z4XHXLR99VP43SyH/9oUT8zxz/BJmeka+mofjQuS85tf0Q6Vc84sLV0fO+DLbpGhpDdKJBB9J1AJOKnAdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080127
X-Proofpoint-GUID: NLEewd2Fo6w-upSfVShpVMtCZDHbYjv7
X-Proofpoint-ORIG-GUID: NLEewd2Fo6w-upSfVShpVMtCZDHbYjv7

On 08/02/2024 00:26, Andrii Nakryiko wrote:
> On Tue, Feb 6, 2024 at 2:59 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 02/02/2024 22:16, Andrii Nakryiko wrote:
>>> On Wed, Jan 31, 2024 at 10:47 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 30/01/2024 23:05, Bryce Kahle wrote:
>>>>> From: Bryce Kahle <bryce.kahle@datadoghq.com>
>>>>>
>>>>> Enables a user to generate minimized kernel module BTF.
>>>>>
>>>>> If an eBPF program probes a function within a kernel module or uses
>>>>> types that come from a kernel module, split BTF is required. The split
>>>>> module BTF contains only the BTF types that are unique to the module.
>>>>> It will reference the base/vmlinux BTF types and always starts its type
>>>>> IDs at X+1 where X is the largest type ID in the base BTF.
>>>>>
>>>>> Minimization allows a user to ship only the types necessary to do
>>>>> relocations for the program(s) in the provided eBPF object file(s). A
>>>>> minimized module BTF will still not contain vmlinux BTF types, so you
>>>>> should always minimize the vmlinux file first, and then minimize the
>>>>> kernel module file.
>>>>>
>>>>> Example:
>>>>>
>>>>> bpftool gen min_core_btf vmlinux.btf vm-min.btf prog.bpf.o
>>>>> bpftool -B vm-min.btf gen min_core_btf mod.btf mod-min.btf prog.bpf.o
>>>>
>>>> This is great! I've been working on a somewhat related problem involving
>>>> split BTF for modules, and I'm trying to figure out if there's overlap
>>>> with what you've done here that can help in either direction. I'll try
>>>> and describe what I'm doing. Sorry if this is a bit of a diversion,
>>>> but I just want to check if there are potential ways your changes could
>>>> facilitate other scenarios in the future.
>>>>
>>>> The problem I'm trying to tackle is to enable split BTF module
>>>> generation to be more resilient to underlying kernel BTF changes;
>>>> this would allow for example a module that is not built with the kernel
>>>> to generate BTF and have it work even if small changes in vmlinux occur.
>>>> Even a small change in BTF ids in base BTF is enough to invalidate the
>>>> associated split BTF, so the question is how to make this a bit less
>>>> brittle. This won't be needed for modules built along with the kernel,
>>>> but more for cases like a package delivering a kernel module.
>>>>
>>>> The way this is done is similar to what you're doing - generating
>>>> minimal base vmlinux BTF along with the module BTF. In my case however
>>>> the minimization is not driven by CO-RE relocations; rather it is driven
>>>> by only adding types that are referenced by module BTF and any other
>>>> associated types needed. We end up with minimal base BTF that is carried
>>>> along with the module BTF (in a .BTF.base_minimal section) and this
>>>> minimal BTF will be used to later reconcile module BTF with the running
>>>> kernel BTF when the module is loaded; it essentially provides the
>>>> additional information needed to map to current vmlinux types.
>>>>
>>>> In this approach, minimal vmlinux BTF is generated via an additional
>>>> option to pahole which adds an extra phase to BTF deduplication between
>>>> module and kernel. Once we have found the candidate mappings for
>>>> deduplication, we can look at all base BTF references from module BTF
>>>> and recursively add associated types to the base minimal BTF. Finally we
>>>> reparent the split BTF to this minimal base BTF. Experiments show most
>>>> modules wind up with base minimal BTF of around 4000 types, so the
>>>> minimization seems to work well. But it's complex.
>>>>
>>>> So what I've been trying to work out is if this dedup complexity can be
>>>> eliminated with your changes, but from what I can see, the membership in
>>>> the minimal base BTF in your case is driven by the CO-RE relocations
>>>> used in the BPF program. Would there do you think be a future where we
>>>> would look at doing base minimal BTF generation by other criteria (like
>>>> references from the module BTF)? Thanks!
>>>
>>> Hm... I might be misremembering or missing something, but the problem
>>> you are solving doesn't seem to be related to BTF minimization. I also
>>> forgot why you need BTF deduplication, I vaguely remember we needed to
>>> remember "expectations" of types that module BTF references in vmlinux
>>> BTF, but I fail to remember why we needed dedup... Perhaps we need a
>>> BPF office hours session to go over details again?
>>>
>>
>> Yeah, that would be great! I've put
>>
>> Making split BTF more resilient
>>
>> ..on the agenda for 02-15.
>>
>> The reason BTF minimization comes into the picture is this - the
>> expectations split BTF can have of base BTF can be quite complex, and in
>> figuring out ways to represent them, it occurred that BTF itself - in
>> the form of the minimal BTF needed to represent those split BTF
>> references - made sense. Consider cases like a split BTF struct that
>> contains a base BTF struct embedded in it. If we have a minimal base BTF
>> which contains such needed base types, we are in a position to use it to
>> later reconcile the base BTF worlds at encoding time and use time (for
>> example vmlinux BTF at module build time versus current vmlinux BTF).
>>
>> Further, a natural time to construct that minimal base BTF presents
>> itself when we do deduplication between split and base BTF.  The phase
>> after we have mapped split types to canonical types is the ideal time to
>> handle this; the algorithm is basically
>>
>> - foreach reference from split -> base BTF
>>  - add it to base minimal BTF
>> This is controlled by a new dedup option - gen_base_btf_minimal - which
>> would be enabled via  a ---btf_features option to pahole for users who
>> wanted to generate minimal base BTF. pahole places the new minimized
>> base BTF in .BTF.base_minimal section, with the split BTF referring to
>> it in the usual .BTF section. Later this base minimal BTF is used to
>> reconcile the split BTF expectations with current base BTF.
>>
>> The kinds of minimizations I see are pretty reasonable for kernel
>> modules; I tried a number of in-tree modules (which wouldn't use this
>> feature in practice, just wanted to have something to test with), and
>> around 4000 types were observed in base minimal BTF.
>>
>> It's possible we could adapt this minimization process to be guided
>> by CO-RE relocations (rather than split->base BTF references), if that
>> would help Bryce's case.
> 
> I think this minimization idea is overcomplicating anything. First, we
> don't have CO-RE relocations, and from BTF alone we don't know what
> fields of base BTF structs module is referencing (that may or may not
> be in DWARF). So I don't think there is anything to minimize.
> 

The minimization is a method to capture expectations of base BTF similar
to what you describe below. In the approach I've been pursuing, we
capture those expectations via the minimal base BTF needed to represent
the types the module needs.

> On the other hand, it seems reasonable to record a few basic things
> about base BTF type expectations:
>   - name
>   - size and whether that size has to be exact. This would be
> determined if base BTF type is ever embedded or is only referenced by
> pointer;
>   - we can record number of fields, but you said you want to enable
> extensions, so it will have to be treated as minimum number of fields,
> probably?
>

Yeah, the motivation here is that often when changes are backported to
stable release-based distros, the associated struct changes try to fill
holes in existing structures so that overall structure size does not
change in an incompatible way, and any modules that utilize such
structures continue to work.

> Basically, all we want to ensure is that overall memory layout is
> compatible and doesn't cause any module field to be shifted.
>

There are a few other gotchas though. Consider the case of an enum; if
the values associated with it get shifted between the time the module is
built and the time it is used, and ENUM_VAL_X that was 1 when the module
was built, but is now 2 in base vmlinux, we'd need to track that as an
incompatibility too.

A minimized view of base BTF - driven by the types the module needs -
can capture these changes along with the field offset/size issues. The
approach I use today also avoids expanding types unnecessarily; when it
encounters a pointer to struct foo in the module representation only,
the minimized base BTF will just use a fwd representation of that struct
in minimal base BTF.

So to summarize, base BTF minimization is driven by the need to capture
the set of expectations the module has, similar to what you describe above.

Alan

