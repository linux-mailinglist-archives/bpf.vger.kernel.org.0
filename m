Return-Path: <bpf+bounces-21494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A9684DDAF
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 11:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388AF1C27EAB
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327666DCE7;
	Thu,  8 Feb 2024 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fupU+6x/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXEPfG97"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD76D1DD
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 10:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386445; cv=fail; b=gqOvqJgr77Wf0sFhmxNP+6Dj6r5fbBKHkjKnCHOa6JSYYp2utaI4hmSbQDcEsDGi+qxWo2CUAwrB6//Y8ebO9jJYngEYxu7mO/tg8C0ZBpj5d+T/TMmGR748yGh+/mogaxwr5AR+BzA5fMqyG6EkI2ALIWgEEwjRAsJnA1QobaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386445; c=relaxed/simple;
	bh=PAPx6+vjFJF9jD/4kqjwqikKFc0+56ul6hikpZwDkxU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hUxbAxjxxf/CHXYz/vp5e5CjUAwmyJAtbrOM+4eQbspU4tMfDQVN5AD4kIYyH58hbM7hQYYWMGAMjsoP4xCccFCiNhyMkgQc3F4F7Mi0FGPCYlKLEkUE9uuOixcSpYXXLp2ZqQ7ARmavCuIX8jn44+BU2sagOon1DvQZe8dtIMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fupU+6x/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXEPfG97; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4188xaTw029845;
	Thu, 8 Feb 2024 10:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CyfjiiLo2Nr8jbq22IcvaC/3SLWWAfCa3fiVmEy+TDI=;
 b=fupU+6x/g683OID3dKU14UUZsGEa2Ejml41LibTsJdUbgRsfzJKuaTnNmMl6TE8thd0A
 a7hzV6lKy9xrPpDaD+gHnYYjdV/sC2QnY2WyjCD1fCnHAzjo4PYTC3WqE8Ckzqq6nQ+i
 ts+9ffekBCk7XBTj4SoH5LVyeYBn5QJfmAbo6/fHCsUFbL6PzzwlWEgYqkuMI27xOUEb
 EU1MLZ36efOfb0O28fJWOPkZRW02OHKRQR5H8Lx4WFlTyJUZ968hltPcqmh2V7ZKCqHM
 q+Oh0v0dbQ2VZY7wcZc+0nkTi/I6R+Y195ssRiY5Yi+H8As4VP01iKiAt8jzPZwGyE7S RQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1c32v6af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:00:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4188fchD019719;
	Thu, 8 Feb 2024 10:00:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bxgpef7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Feb 2024 10:00:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB1tE5QzwugwhrxB/AKX/RKPfSBMZ6BprPzX/z5pcInwU+w9rAywYF99gw6ITw/JsrnehJAQccKHhxoUkS7RVwDk4PrDZ02DpZsoxIZB+f3X426MyNHVcJzHSwLusF53O73WaS3+vDm+wb0T/lxibiA/7ba3/r8MlcNazHW/8dL/t/Rj3hUeMfwPF0RyOb5/G97OaBTkgUoiKEAW4KIpsizO/Ut5e7vBOUAfir0zCGklgKI1B5ZhiKFT9KKedNAO77AQm2e3e/RO/DUuY6CgzuIpJa1xdxbKi5s5+QLJyeo8589oWgFF7vbEohP6Lp2PdnlQFHpvYUgVKrK7SiOkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyfjiiLo2Nr8jbq22IcvaC/3SLWWAfCa3fiVmEy+TDI=;
 b=dfT8nTfjSvpLQCZgVkFLO/sVIqPtrC2Z6jkfihk8XtmWOm8ADGgmiy4kcNcbA+H2xSxQnTeNPv15ld/uTYfT4OGU/byxCHL1EmfLwIpic7kru5MtFb+qyvbWGJIcZlCqxnme74XvhbygjKpZNqL72Z80f+wEF3CR9sHL5HxSio+iT8aUxxH0ByzdVkDodvFC/6mI4C2xPJDDPi2goNCxtSrsbQYBEzO31GueidET1XlQs+b6Jm3UOfB/4LxzWUDTA2cMYI3Knxev9J1uC1w6lWG7mYPbQ6RoFad7YWetLtW8MRm7ny+672S8BCA59oHL0JYy+I0pqVX9fZkyxjqW0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyfjiiLo2Nr8jbq22IcvaC/3SLWWAfCa3fiVmEy+TDI=;
 b=aXEPfG97PQLev4F1kXWmMRJb6RKWpZh4nniFmxeKR2IJCe+XlGRfGdYAorWqjmbwHPCKwxaADyFsT7FKWBDkAXFsV9+ZPULMOV56+ZFyS4ALGxfIpCWywT/Sg4g8OaTjlxf6h4v9PiXqUPNHVArI+d64i2SEKqoz42LPXIXAnGM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW6PR10MB7685.namprd10.prod.outlook.com (2603:10b6:303:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 10:00:19 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b3b:c19f:bbba:7f70%7]) with mapi id 15.20.7270.024; Thu, 8 Feb 2024
 10:00:19 +0000
Message-ID: <8e0580c6-bc72-4644-a010-c73d779f385c@oracle.com>
Date: Thu, 8 Feb 2024 10:00:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v4 2/2] pahole: Inject kfunc decl tags into BTF
Content-Language: en-GB
To: Daniel Xu <dxu@dxuuu.xyz>, acme@kernel.org, jolsa@kernel.org,
        quentin@isovalent.com
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        bpf@vger.kernel.org
References: <cover.1707071969.git.dxu@dxuuu.xyz>
 <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <28e81ccf28d6dd33f6db50af6526dc1770502b8d.1707071969.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0193.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW6PR10MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 6450ec69-b941-437a-38ef-08dc288cc1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G8vKHVjWKeva74H5rb/wdwX26gNGlbeusHc4ShaJ7Q/5hzBRjAPZqSXl8/FwTSbCiNyLfL7V2/x1iqosuQIOXueqhA5E3Gb47Ye/wsUNZ48nK5b+UDpeE9VFOUVh56Rq+4N4caH3Qt5m2k0+zJyuR9LGmpJ0HAFnKlbcaOmJT3vExildT8Beq3/oUD6MFB4FyAUO+0OBRweWUgmbqEfrJ4QKcjQHgrB946KiIsy+jOs3jpvzMLa4uGf9Beyj3jLnQgDoO5lBwU9+/oNKnjmsJggVd1M7Sy4oKICyHtcmpIgdJPwwq7m4TqRlLhMPpnaH4uth6iWr7KM7IXeWv0vUnyeYchTlVt9RYsD7lnupgNoEOmr6OxN4fRRUEPtYNzB6a1A0zA8vFgslc1ZW0SLByf2AyxEKDas3F6sQE8NeddWa3l+2vsvhUnra/e+OagwMz+Xx8iWJw+5F9AYdpvnRrwVCasB/8D8mJYHskedeltGWhCqEfufPC/HsnCVvTO14ROV8T/l/RtJHrPNodtAsLprQLKzX+YTNk21wspJSFJPJwu4iu+OLTQqB1/ZZLXDb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(316002)(6506007)(6666004)(38100700002)(53546011)(83380400001)(31686004)(31696002)(8676002)(86362001)(41300700001)(2616005)(4326008)(8936002)(36756003)(6512007)(5660300002)(478600001)(2906002)(6486002)(30864003)(66476007)(66946007)(66556008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UVJNdGNBeXc0RGxRd3ZKd25aRWJBVlMrcVFZclRhc05QVUN1MzJhRXJwZXAv?=
 =?utf-8?B?cUh4L2wrdGJRTXd3Z2t4RmlFRHVkTmNJY0ZvRG5rSXlVZWFGcmRXTXpCQnF0?=
 =?utf-8?B?c2JXbGFobmlRQ2xkVGdrM3RTaGQ4aVRZMkZacnZCcVZkRERNcG1rN2F4bWdw?=
 =?utf-8?B?UzRWdytVVHNqZEpqOEdNNngyUjZmVkR5ZENXWVoyNG9pUGFlaDFrRFdVWG1l?=
 =?utf-8?B?WHhWVktGd1hUbWJ4UjRhNFcrUFBYZjRkUEM3d1lIWHZaZU1XUUlnL05SZGp1?=
 =?utf-8?B?cTh1NlRRL0VYKzlDNSs5NU4vQW5tZVpISzJlYjQ5eXQ0SDc0dFhWangwWnJv?=
 =?utf-8?B?K1lsVXNxM05rOXZFWEt6aytLZlE0djVZUS9BRUQwOGFiRGlhYk5RaUpwK09l?=
 =?utf-8?B?RU8vektRemIrZEhPdU1VUk1PcnRkR3JGZFZzOXpYSGw4R2hRYTJlQlJwREZP?=
 =?utf-8?B?RHdyLy9GTFdRcGR5UVpCWi9NMGpzOUNHanVra2VtcjJZMUFXZHlvVHBuYXl1?=
 =?utf-8?B?NlFGVDJuZGI2T0d3OTRiQzhVSUIzOEc5R2JsNURpeUtsemZ2elJjaXZyc2RQ?=
 =?utf-8?B?RTFRTURKdHR2Z2NBTjF2UTFzenU3WlBoN1JFeWppZG9Nbi9KS09hY05RTkJF?=
 =?utf-8?B?bUQrSjRsSXlnMDBqOUN0ZnJSN0s1MWhxRHk5L3RNRnh4V05tSGFCajNDN0xM?=
 =?utf-8?B?LzZDb1lPTE83d2hnUFVvdWs0YjZCdSsxcTQreFA5aHlRZXlqeFZDYlNOVFVW?=
 =?utf-8?B?OXhMcFArME9VNGVZNk1JVVkwajN0Skk5OXlpZmRDTWpscVpzdGsvc3k3cUxU?=
 =?utf-8?B?OUNCM3NUMW16TlMwMzBaSVkxZ29jNUQzSkZ3ZDNoSUdhb2tTYkFlWnpUNmpW?=
 =?utf-8?B?K2NuUmtnblFYNk9LcndSZkd1OEFrbFVteG5IYlFjRnhCNGpKcHZnRTNhWVVy?=
 =?utf-8?B?eXhVM2ZjMXN6VWhPYk1sZUxQdnpjQVNUeGVEajcvaTlEK2FVVWdNamo2QThN?=
 =?utf-8?B?REN1a0VUL2xLbUVETTdQMmJYdXVReGJKNHZQeStwaXVlUXpoQU9sU1lVUlVw?=
 =?utf-8?B?aENqK3VERTNUTTgraXAySEhjUUtpcVdkTDc4Y0cwUWt0cVpuU0Y5d0JZcDNN?=
 =?utf-8?B?V29TTWdMQjJ0aUUwd2NqN3ZodTAyRFRTK3VRVE5iVDZxYTY5QTJZN25EMmZt?=
 =?utf-8?B?bnRLQ05WZGJURGpCTFNpeXJLaTBwY2xPV2hzUWJMSGZTYkxLNDV1SGI3WEox?=
 =?utf-8?B?THdtdnRYSTYyNDBKSTVXYUx6aWkySmhCQ20yd0hheWo3VUFEOXJvdHVqZDRW?=
 =?utf-8?B?MzFrMS82L2dEcCtoRWJ2NjdZOEtQdGFFQjgwSnRsUmtPcUgxMFN4dUtJM0Z6?=
 =?utf-8?B?NzE1aS9hek9EcWR6MVRoUmkydEptdzJ6c1hLa3R5UEUzckdUSWJudlJnTlpL?=
 =?utf-8?B?cWdmRDAxS2NTcVZlZnZvaTM5WGI5OU9TRVJ2dnluVUY0bU5PYnVJSENUQ1E0?=
 =?utf-8?B?Ull5d1dKVHhPYzFpUnVDdC9JZDJSUlozUzdmbTdtNFdobmxMN0dNWDdLWHg1?=
 =?utf-8?B?VDIydEtJY1BDNmR1SjRhZG5sekRYNWZHK3dROWZWVEx0VTd2cXBvRzZ1MlEr?=
 =?utf-8?B?NXlrN2x1WnB6RjFQMURGT1M0UDdTcFFwdmdMNTgwU0xMbjh3VG4wMDA5aUxE?=
 =?utf-8?B?WCs1bHRncE1MK1plMDliaXoyQW4yenlwMGg4VENYTUVlcDhOQ3hGQUIveXRq?=
 =?utf-8?B?YjNxQUhyTDFtNkdNMUljVko3OE94QXk5UDd5M3V4eVNGdUpJbFQwMk1pdWdR?=
 =?utf-8?B?NGtUc2NtTzROYUJSampoblN4dE1RcXN3VFdFakJBcGVyUGJscFY2Z2xLR2Fq?=
 =?utf-8?B?cFlaa0RFdnN0cGYxd3BzOGhkNENhZTlGbktPMTVmZU9uSjBLalMyNGlQQk1s?=
 =?utf-8?B?QzNETVNyUU9sOXA2TnVOeWJFc1dHQk5CdlZKZ3ZsVmVNNWVkWWs0eXBKMkpv?=
 =?utf-8?B?SmMrU0d4VXpVVTZVemJ6U2xPbDVkbEpya1N5MHd6ZkNXNGduL3pLUEtGamtT?=
 =?utf-8?B?aGFNRUdTTVVYTUFqdGpNakdLMDhwV1FxNUF2N1E4ejFwUkd6ZHRMZno5bkJU?=
 =?utf-8?B?cFBjdTNNdWdjTkNvQ0xKZ1NEanRxRjQyM24ySVBlT1ExSFdTbFpHUTR3SzJK?=
 =?utf-8?Q?oyBbpyoFB+jMliHuhPhplFc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	d/fkdoZhBPZKVuX4gp91tcX2xeL7TBYUd5/kKa2SiOhQJoI4ltg4P+uFmmEWSCwVh5EwzUfMxpyceaJm4HWl6J3Acbvw2KV/dykSmO1MrA0dbrbwqXZ3RkToagM4Pz0Kid25ti8nzfYYmk37PWwo/x+Q6gRynNawEvLt1UQfse6vZAtYDKxJKqzWvNYJOzfMGHms/3s/mE2zfFv9pulfgAYtu0Aaa58KqbRfsbxkV7LvGWKBnu8ZtCRWADjjm6mbswbr2H8YH7BRNIo6iSvXO3Iq0VSrgND3WLMV4u1YjijhTZv2p5D2F2TXAXcv2E8lee1uSlNCDKphcLDSEe1DDfEezNWiJEdH/eR0Bh/RYy3NH0eXXcSHlX5l1WZFE3nZTsMqOcbZi3FkeXwg4LUQcHQ0tlCIrwJWocvfYHZSkIEawFcR1gl5Ut0eCXOMezX8Zo5IaSiHjb/sr+Jk7qKWIyDIjGgjulRqArCBJD4nV9CpQ971EDxYDLKtZjmgOcG8Ix1nGEYsg++Lj37NkJFZOdXS0rOcqcpmu85MS4hBsLRF/67Gse/HrYUKhnwtL+mj+XwuE/YoAeALWGCEBce7ID33UdYhDyfeJFrqKHa45+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6450ec69-b941-437a-38ef-08dc288cc1a2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 10:00:19.0078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +rFf2IaNJ9sQR2wlk8zqQDzx3tNajfF9DGRgNxbWjthgVgh/KtkQkhho9M13QptILRfQVCOXgRkNIn0dkM5L9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402080052
X-Proofpoint-GUID: jzkWbDOBnJ2Yt2hgrNO8Cz1E42h7nry3
X-Proofpoint-ORIG-GUID: jzkWbDOBnJ2Yt2hgrNO8Cz1E42h7nry3

On 04/02/2024 18:40, Daniel Xu wrote:
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

Looks good! A few suggestions below..

> ---
>  btf_encoder.c | 359 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 359 insertions(+)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index e325f66..d6a561c 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -34,6 +34,21 @@
>  #include <pthread.h>
>  
>  #define BTF_ENCODER_MAX_PROTO	512
> +#define BTF_IDS_SECTION		".BTF_ids"
> +#define BTF_ID_FUNC_PFX		"__BTF_ID__func__"
> +#define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
> +#define BTF_SET8_KFUNCS		(1 << 0)
> +#define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
> +
> +/* Adapted from include/linux/btf_ids.h */
> +struct btf_id_set8 {
> +        uint32_t cnt;
> +        uint32_t flags;
> +        struct {
> +                uint32_t id;
> +                uint32_t flags;
> +        } pairs[];
> +};
>  
>  /* state used to do later encoding of saved functions */
>  struct btf_encoder_state {
> @@ -95,6 +110,17 @@ struct btf_encoder {
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
> @@ -1353,6 +1379,331 @@ out:
>  	return err;
>  }
>  
> +/* Returns if `sym` points to a kfunc set */
> +static int is_sym_kfunc_set(GElf_Sym *sym, const char *name, Elf_Data *idlist, size_t idlist_addr)
> +{
> +	void *ptr = idlist->d_buf;
> +	struct btf_id_set8 *set;
> +	bool is_set8;
> +	int off;
> +
> +	/* kfuncs are only found in BTF_SET8's */
> +	is_set8 = !strncmp(name, BTF_ID_SET8_PFX, sizeof(BTF_ID_SET8_PFX) - 1);
> +	if (!is_set8)
> +		return false;
> +
> +	off = sym->st_value - idlist_addr;
> +	if (off >= idlist->d_size) {
> +		fprintf(stderr, "%s: symbol '%s' out of bounds\n", __func__, name);
> +		return false;
> +	}
> +
> +	/* Check the set8 flags to see if it was marked as kfunc */
> +	set = ptr + off;
> +	return set->flags & BTF_SET8_KFUNCS;
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
> +static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct gobuffer *funcs)
> +{
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
> +static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
> +{
> +	struct btf_func key = { .name = kfunc };
> +	struct btf *btf = encoder->btf;
> +	struct btf_func *target;
> +	const void *base;
> +	unsigned int cnt;
> +	int err = -1;
> +
> +	base = gobuffer__entries(funcs);
> +	cnt = gobuffer__nr_entries(funcs);
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
> +	struct gobuffer btf_funcs = {};
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

Can we use the existing list of ELF functions collected via
btf_encoder__collect_symbols() for the above? We merge info across CUs
about ELF functions. It _seems_ like there might be a way to re-use this
info but I might be missing something; more below..


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
> +	err = btf_encoder__collect_btf_funcs(encoder, &btf_funcs);
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

we could potentially record this info when we collect symbols in
btf_encoder__collect_function(). The reason I suggest this is that it is
likely that to fully clarify which symbol a name refers to we will end
up needing the address.  So struct elf_function could record start and
size, and that could be used by you later without having to parse ELF
for symbols (you'd still need to for the BTF ids section).

Then all you'd need to do is iterate over BTF functions, using
btf_encoder__find_function() to get a function and associated ELF info
by name.


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
> +
> +			if (ranges[j].start <= addr && addr < ranges[j].end) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		if (!found) {
> +			free(func);
> +			continue;
> +		}
> +
> +		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
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
> +	__gobuffer__delete(&btf_funcs);
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
> @@ -1367,6 +1718,14 @@ int btf_encoder__encode(struct btf_encoder *encoder)
>  	if (btf__type_cnt(encoder->btf) == 1)
>  		return 0;
>  
> +	/* Note vmlinux may already contain btf_decl_tag's for kfuncs. So
> +	 * take care to call this before btf_dedup().
> +	 */

sorry another thing I should have thought of here; if the user has asked
to skip encoding declaration tags, we should respect that for this case
also. So you'll probably need to set

	encoder->skip_encoding_btf_decl_tag =
conf_load->skip_encoding_btf_decl_tag;

..earlier on, and bail here if encoder->skip_encoding_btf_decl_tag is
true. We'd need to be consistent in that if the user asks not to encode
declaration tags we don't do it for this case either.

> +	if (encoder->tag_kfuncs && btf_encoder__tag_kfuncs(encoder)) {
> +		fprintf(stderr, "%s: failed to tag kfuncs!\n", __func__);
> +		return -1;
> +	}
> +
>  	if (btf__dedup(encoder->btf, NULL)) {
>  		fprintf(stderr, "%s: btf__dedup failed!\n", __func__);
>  		return -1;



