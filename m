Return-Path: <bpf+bounces-21560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D0684EC3E
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 00:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E661F24341
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0247F5025E;
	Thu,  8 Feb 2024 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kBoOM0Tf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M8qgd8wp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4F50240
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 23:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707433328; cv=fail; b=sZz4VZwCi/NqE4tH/gHPqG/63qZfTJFz23iDnaO9oYMjeJLMR4qisoUHfHWEhCZF5RzlE2v/KmXs0vKe6WxXHYyDtIdssNPxE52RONCfRo2WPo4iH907Z6IaiXULxqp99gZsiCiMsoFfMvxOhn8EWz6/9/dGnbsGF/Ync83LNoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707433328; c=relaxed/simple;
	bh=X49OOxfWyuuWYzvpmqOY5BkOsPt82MYpI/fCyZkGJJY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVzfR7MnHuDpBOm33ZAmzN4ZhVAHmxET4Yfv5VYc/1P/LzXFbdujROAesAJ7c3g41zn08XdvDY3Lcx/wC0h5sp3miyqlTYC5NcY4f+mx/NRgVFXcK6kr8zYbya5BpawRgWRaaScZB/mpmGEr46EITVf+q8jC+2K/AM6e975z/EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kBoOM0Tf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M8qgd8wp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418LT0Bv019811;
	Thu, 8 Feb 2024 23:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=SiLp+zIro2gujwOiDlokrwq7MbZiJi3WkQn5Gtlwfg8=;
 b=kBoOM0TfnJ3B4Fk9c6uokfmOI97perzvLz1o/1ISluyMVErOBtxncUD7gT61xT61DJcr
 i9tsI15NAummrAzJurvbdPtniXBbNlc2Qmjp1VtNLBLdXp2C/KbD8cX1aMsLH5nsZEdw
 7m+4Hij4GDTiCpnPtUAaKZV9DqgBs3Ue028RH4FIk64A/SrZzY2Wk0Xt9ndvLdVesNkH
 5Hpg4OQL2Y4+ug6YDasyUJgRaYbofvOKhuayHLs7/tJwiqIraJsGRYgZHPFRYLAwqLu+
 pvJ5FDtZKDCGonEsm8NpHBL30zI9jqQP6FppLo4ZsYbzR1q4cAePwk0TDWkvC5zA3PmZ LA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1bweww14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 23:01:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 418LZgvq019946;
	Thu, 8 Feb 2024 23:01:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxhpk7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 23:01:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDqme+E6KacdGxlwmdkXokoq9suRhZJV9Q6ekE8aPD1GnzrIHQKAWuLPCe7aSbCBQAx1Zdk54SzOhFend4Kiiobe6YnZeP8FRW6ABXN1trD5cs2qiWRZQtPGAt89MJuwMzbB0G4fXvDMgLoqaGbDZjE5GZnG3QCcEEvaSwCYssrrdRhFX6UjI7dwpc6gd1D1+kfbr98f+ZxsKUh1+LMv0oV4EIY8RhKGCqOzec4CovkqbbPSdIK8xuETadVVdNaHdZjLmWj9EJXg9Ar4EAh2YA5zKT6KcBynoa1qejAN+sxYq5dBf4Gz9SR2wLUVTzUjLu9rrE5YFOqzJC5WigaibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiLp+zIro2gujwOiDlokrwq7MbZiJi3WkQn5Gtlwfg8=;
 b=BxlLv0Qy/k2btUtcipGBQQyCB9F3msfDA+unSyjcNqW9vPSNbK4LgAEO2TU9CdVCmP4yDryvikqr9zzuVEX5WUR8NJQOcb7SHailX/Gt/yFg9+sL3tKi+lzSxduHRFUioIUPcwH6yjMKCVluf/my5yh8DIUnxKcjfEzbnXIOTMFGWr40b2m/HHBNJFRk0wVFtKfhr8FvWI0SSzu/yvGvqrgB3tUvtNE6ACJru75BAYQOxiAWQZgoVnftCdbh78EOSatCa8DfcZ3pIzv80LVAc1xT/9MwWENwa67M0cPo2SraQBZfNNrduKAI3d7xtDWrUgh8aXoeRdSymh+hhzLnMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiLp+zIro2gujwOiDlokrwq7MbZiJi3WkQn5Gtlwfg8=;
 b=M8qgd8wpCeBzf9CvfrsEWcczsnKr7xrJXitQDFWDMEvaqHsUZF6LnnN5yqxKqdeDHkDdD4n61L5aqjTf82yhJkmst7wcXT6JemdVsxlP7geCDUujIB9uRoOckRgX5Dbjd11DHNYZH3eMrvaUdy8tB4DIqSDvyV5tgv5gPEs37E8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Thu, 8 Feb 2024 23:01:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 23:01:42 +0000
Message-ID: <5c186046-77c7-4e5a-bdbe-ea699a18ec70@oracle.com>
Date: Thu, 8 Feb 2024 23:01:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4] bpftool: add support for split BTF to gen
 min_core_btf
Content-Language: en-GB
To: Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Bryce Kahle <bryce.kahle@datadoghq.com>, Bryce Kahle
 <git@brycekahle.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
References: <20240130230510.791-1-git@brycekahle.com>
 <9b054832-3469-4659-9484-00bcfef87563@isovalent.com>
 <CALvGib8u_owyjKCWcD3ZrFTkUw6dwE2Aev6nG2AD+D++b+R77A@mail.gmail.com>
 <CAEf4Bza=mroJ6+zhK-fCKLutuH_1z9ESeJs+BHbNbCrATrwRdA@mail.gmail.com>
 <dfcd6c3b-dbaa-4e72-acc5-89aed8a836f9@app.fastmail.com>
 <CAEf4BzZMmbV4H2vLeYO0tm50VV9evLDnUTM69=P7z41v1jY7gw@mail.gmail.com>
 <CALvGib8LtTY8qBN+tvZTzb_GKNOX4R9YEUxkOL0ghuQmjG8Yqg@mail.gmail.com>
 <c4624866-894f-4340-ac97-41bbb683c149@linux.dev>
 <CAEf4BzZ94O0=PGczhtCMc+-T1DoNUV1rG5TsfFq1qFahbMptyg@mail.gmail.com>
 <7f4b6a8d-a4ea-48ff-b195-d00ce2f2fe52@linux.dev>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <7f4b6a8d-a4ea-48ff-b195-d00ce2f2fe52@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P191CA0007.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 40585bb8-ce8d-453a-231e-08dc28f9ea56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rKhboRc3p4B1YcBhvIhCnSHCsuARA1cQJfdG4HpSWI7XVkGp8QE+UukAQRZZ3DATbMjz0GYQQGE3lZSpx1vQBINY36BkWxD9ide7rIaxtufKkKETmgAlNdVqWmUwOkKE9B31Ekrr5R3Us5FIZuOJqfbHUBguziIJrE857xI1J+iBeKHIoSEioBHGzHXCXdtZ9FK5am3+syoZWyU1SBtzO73TmE5thcc19kG+JlRAB1TC9wJk3uujh2HsDu7WlUhork0ZU8mujMD1f912EiTC7OHFw4zmnLZxiE0WlUvrnfzkgqKxxWGm4fF5eWe5s1PN9oxKC0yiZIwxDdBS7umhebQ+wojSem6BTZDGdSMM+cu9VXiY7KhExwmoldUy4K7iQGFHkwUOAPwcwnY60ydpfcWdduXrPFaqJwVNH8Uu/P66w+/d++Ad1RROy/6MbOapaCZYn+ClO6028Ytwcd4ukNoQkyzQnOKQp81oHAaLUvBSw/BT3jK6KSleZr4sIc+WtrtDczHZ+riXxgFq9keOHC0YzixznBjN49JdNz/nc2gDVk+h4EUJCQ7+pLIgDRkp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2616005)(31696002)(86362001)(41300700001)(6486002)(2906002)(478600001)(5660300002)(54906003)(44832011)(66556008)(66946007)(110136005)(316002)(66476007)(4326008)(36756003)(8676002)(6512007)(8936002)(6666004)(38100700002)(31686004)(6506007)(53546011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SGpxWk1HckxiaXU5YklzVjlCQzlRc0kzV3hCY1pGalNsSUJtQ1BrUDBBdklK?=
 =?utf-8?B?MTBTVmR5WFJGYko5NENsdkhyTXQxZEhGUHVWS3RLZXhuaXpHYmNFMXFUYmJa?=
 =?utf-8?B?eU9uWHpHNVpydXpqRVJtVTdtSDY0ZjRUejFSSlJ6b2owZ0ZpMTBMa0F6c1BX?=
 =?utf-8?B?d0dVOUFxOGh6UlRMbGZ0dlZ0RWMxeHFWM2djYkRSWXNhQVF3c2Q5dzYrMXhj?=
 =?utf-8?B?WHNUWEcxenVSVEI4elNsS2ZzSldIbGk3eXFZaFFDTlIrOXRTQzJ3NG8yZ0J6?=
 =?utf-8?B?ZHpmSVBBcjdoeDFWMkxNKy9sQ0t2YjR2T2xocmlxelBGQkR4ZUxVamtvT1hQ?=
 =?utf-8?B?S25uUDlUbTVFaTVCdnl4TXBGTjlCdDc2NUVMS1lONUdqMjNnZ1ltYjh2UDI0?=
 =?utf-8?B?cm5ENzlCd29kdlY3WEV1TnBlaStaN1B6L2MrR0pGQlhWdFJMdlNvQ2tybzFV?=
 =?utf-8?B?d3d5Y3hUR0N4bmJINDRhbHVtR1hGWU9YTWVPUmh3MWNQZ0w0eVNJaFlMUHcx?=
 =?utf-8?B?NWoxOWorLzhXVjgrZTA2cklrQXNTM0x0RFZXanZGZmRQMEVaWEEvaFNETTc1?=
 =?utf-8?B?OEZUZWp4MVlKQkpJZzNCZ0M3c2ZZMzdQT2hiQVYyaW83bTZwWCt0MlRnL3dO?=
 =?utf-8?B?VEJXOGJHQ04vYVg5RFgzbnQxSmUwMnN4R2NJa1BlWVVDc0hsTEltVlJvamQr?=
 =?utf-8?B?OHhyN0dqM0dUN3pHNGcwdE5rc1phTmp5MXVtdldmRER6Q1l2TWljQnV6QjNV?=
 =?utf-8?B?K1BwME5XTGw1TzVpZ1ZqblY5L0dKMUk4T0FMV2ljNUxWTy93NitnUXcvY0ww?=
 =?utf-8?B?MXhPNWl0SktMZzU3eUF0VUZjd212VWxXbDNOdXI1dWhJd2dmNC9oY2V3WTN0?=
 =?utf-8?B?V2VwNjRkbmVSNzE2SzN3dHlnYXhUVHVDbkdtZTRNUHFRQkJVOXRXOFBPajJL?=
 =?utf-8?B?NTk3Q1hJUGE5dmp6cHJvZjc3Zm1OeUU0Q3MzSG5SNXpXMzZPK0dyQmtFbkdG?=
 =?utf-8?B?c2FiWWdlM2t1VWlrdytEanJqT013WERheDFNbVhaSmIwNG1Tam1PVUVoU3hZ?=
 =?utf-8?B?MFgzVWJ2V0xzNHZyblpxOGxZRjZlQlI1dmRxTlEvSHNVeXVBNmhEQ1cyUndU?=
 =?utf-8?B?dGczQ0lPd0dBUnZNWURkb2h0TVpuMTRUbXFSc0Y3QW84aWlPUk9zRkFoYUJn?=
 =?utf-8?B?TU9rZWl3bkovUTI5WlZVa1djWnEyblljeEZEMDFSZ2IwVFRYTnArQkxTNG5P?=
 =?utf-8?B?TGZwbVlkUEF0SldOUStzN0w0eEFtcGpqb21QSzQ1MnpRNWwxajYzOVpKRGhX?=
 =?utf-8?B?WXJwdXNTUTJXSC8rOFhhaXRHUnF6N01YQzVHTExJY0dwcjdVWEk4NzZDMjJU?=
 =?utf-8?B?Y2o1V3dHSWtjaWxLb1ZkNlBycnhCNWpBZnFwUnYwdWV6WlBvdzliME9SaDl2?=
 =?utf-8?B?ckpHUE9WamI1UXpxMWJsd0IyWEM4MEovV3YwcXlQVTJ2anIrQUFHMkxIK2sw?=
 =?utf-8?B?dk9aTEhrUUdJejNXbi9pSXZmd0dseHkwckpsRUk5RC9PeVVhY25BWVh2ak5N?=
 =?utf-8?B?Sm1abDRXK3NsQk1tZFpRNWdHQURuenpsdk9xenlGbFYvdUM1TFhnLzFiK1Zv?=
 =?utf-8?B?S0dWNXVONWM3eVZmZDhQVnN6SUhJTU1sQXp2NTgzV2d4ZmJVSy9UUk9kS1Bs?=
 =?utf-8?B?cktKaGZ3by9icXRaNExCeTVqNU9zdDExaU5lUk9Rai9PVTU4dUpPNyttMk04?=
 =?utf-8?B?Rkhrc0FiSmljZVltMmIzOVlwT0w2aFJyTHJrWjNoZHgvbExUaXAydW5CaTVy?=
 =?utf-8?B?OG1Ta1dFaDEzTjA2Z0kzM1UrcXZoR1Vra3c0R2lERzc1ajRtUGkrUERkRFBO?=
 =?utf-8?B?ZEM0L3FOaU41aTVaNnFxRW5JUEhRYlYvdmd4ci9MQkRPOHM4WStZeDdxcC85?=
 =?utf-8?B?V3VOLzFMY21md3EvLzh6OTNxRElJNnZ6NTluVG5yc1dtTG90TnRPdWMxc3JD?=
 =?utf-8?B?MVczUm5OdDBWdnFieGIvdzRYWVN1bnlqUlFzclNnMkxJT01YL3h0TWl1dnZU?=
 =?utf-8?B?YTdiR0F3Z29DRXhnWG5sVnFnaG1hYlhudmhhaUlDK0xkelpOc1VRSHRnWVly?=
 =?utf-8?B?d0htTXJ5YWVZaGVheXFXc0hIekNkeXZxaXg5KzNwRU96L0NoZkk4bGwxb3ZM?=
 =?utf-8?Q?NnlH0wgwY0FdQbjT7lvrDM4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Hg2Im2dCee2vHu8/OnvO6DVyxfCuU9FfDVU0kRNrWkyWk1VBeAXLMEdbV9FT8/0yvvtRnbithR4sLhpV2TO3RsDqtnekHz3Mau86l14+y6GkUV5ymEuEP3rZ6/o1uPD2i2M+Yp4qZpA0Fl1ckBpAO7eZjIdf0iDn5myH2NBoaTOCLJ3sZ4iqHTCldt/3tQRaWyxdSJlOU+m1sz6syAmCE4rxAFi0MvQoU+0f/0ot0eiTCvwZrwuNWEE38h9oMFf9vfvtwoe9EYqKHC17kvriXItDDVpOUMngvqIFllBb0XZEeK4cg9EVKfZlGMnvj6FvLUZQDaYedi2qS5sdmYuKOdzKH+j5P1Gf59jWCnIs/zTHSrwV0jLTl782xAN/PCFT+fyLUDx3GITt7Z8AzW5/A/+x1Ryw5Emw3BscGKh63VBqqZfEpMzABE3LfOYaU+uoSEn8Dk06UZADGTGyXjR4D1sia2l7Y+4rJmnv/NDeNQLu07jIiHchv4eK4iQ3MkVcFc6cxgoJArRvOmENo380kFx87KgGGzSViw7hX0qCoy4ORPNgcK4BOv4uTaxe9DZrhXurH7yVdG3fYivsoxTg0rm5bvBTGFkTXeE6vfSG6/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40585bb8-ce8d-453a-231e-08dc28f9ea56
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 23:01:42.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMymYh3y/NuhXY8pNXAaIr+4Ts19jnWXzVihrwZ9U2IQgCreYPKVWi/s1jMKnNmvnWCUokzCVaHAoxjY0iJbtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080129
X-Proofpoint-ORIG-GUID: rtKeCmvj62NQJmlKgcFKyzWLJkuFHfbe
X-Proofpoint-GUID: rtKeCmvj62NQJmlKgcFKyzWLJkuFHfbe

On 08/02/2024 01:56, Yonghong Song wrote:
> 
> On 2/7/24 4:30 PM, Andrii Nakryiko wrote:
>> On Wed, Feb 7, 2024 at 2:38 PM Yonghong Song <yonghong.song@linux.dev>
>> wrote:
>>>
>>> On 2/7/24 10:51 AM, Bryce Kahle wrote:
>>>> On Mon, Feb 5, 2024 at 10:21 AM Andrii Nakryiko
>>>> <andrii.nakryiko@gmail.com> wrote:
>>>>> 3) btf__dedup() will deduplicate everything, so that only unique type
>>>>> definitions remain.
>>>>>
>>> A random thought about another way.
>>> At module side, we keep
>>>     - module btf
>>>     - another section (e.g. .BTF.extra) to keep minimum kernel-side
>>>       types which directly used by module btf
>>>

Yep, that's exactly the approach I was pursuing; an extra section
containing those types (I was calling it .BTF.base_minimal).

>>>     for example, module btf has
>>>       struct foo {
>>>         struct task_struct *t;
>>>       }
>>>       module btf encoding will have id, say 20,
>>>       for 'struct task_struct' which is at that time
>>>       the id in linux kernel.
>>>     Then the module .BTF.extra contains
>>>       id 20: struct task_struct type encoding
>>>       there is no need to encode more types beyond pointers.
>>>       this can be simpler or more complex depending
>>>       on what to do during module load.
>>>

Right, or in BTF you can use a FWD declaration for task_struct. The
approach I'm using explicitly identifies types that are only
pointer-referenced and uses FWDS for them, and this helps keep the
representation as small as possible.

>>> When a module load:
>>>     For each .BTF.extra entry, trying to match
>>>     the corresponding types in the current kernel.
>>>     The type in the current type should have same
>>>     size as the one in .BTF.extra if otherwise
>>>     layout in the module btf may change.
>>>
>>>     If new kernel type can be used for module BTF,
>>>     simply replace the old id with new id in module BTF.
>>>
>>>     Otherwise, type mismatch may happen and the corresponding
>>>     module btf type should be invalidated.

Yep, this is the process I describe as reconciliation; where we make
sure base BTF at encoding time and current vmlinux BTF are compatible,
and if so we renumber base BTF references in the module using the
current vmlinux BTF ids. So if compatible, after reconciliation the
module BTF looks just like any other module BTF built against that exact
vmlinux.

>> Yes, I agree, see my reply to Alan. I'm just unsure how strict we want
>> to be and whether we need to record fields of expected vmlinux BTF
>> types. Or if just recording expected size would be enough (to ensure
>> correct memory layout if base BTF type is embedded into module BTF
>> type).
>>
>> Perhaps, if BTF type is referenced from some "trusted" BTF type (used
>> by kfunc, or in BTF ID set) we might want to enforce strict
>> compatibility, but for any other type just make sure that size is
>> correct (if it matters at all; i.e., if base BTF type is referenced by
>> pointer only, we don't even need to check size).
> 
> Agree. The above is a good start. I guess some real-world investigations
> can help shape the actual design about what is the minimum change to
> make it work.
> 

I'll try and send a pointer to the work-in-progress code prior to the
BPF office hours next week. In investigating how much info is required,
for most in-tree modules (which I force-built with minimal BTF) we ended
up with information about 4000 types or so. So it's a significant
minimization compared to vmlinux BTF.

In this context, perhaps my describing the information we collect about
base BTF as minimization is misleading; the intent is really focused not
on making base BTF small (although of course that's important from a
practical perspective), but collecting the info about base BTF needed to
later reconcile it with the running kernel at load time. Maybe
.BTF.base_expects or something like that might make this clearer? Thanks!

Alan
>>
>> WDYT?
>>
>>>> Since minimization only keeps used struct and union members, couldn't
>>>> you have two internal types from different modules which conflict and
>>>> end up using the wrong offset?
>>>>
>>>> Example:
>>>> in module M:
>>>> struct S {
>>>> ... // other unused members
>>>> int x; // offset 12 (for example)
>>>> }
>>>>
>>>> in module N:
>>>> struct S {
>>>> ... // other unused members
>>>> int x; // offset 20 (something different from S.x in module M)
>>>> }
>>>>
> 

