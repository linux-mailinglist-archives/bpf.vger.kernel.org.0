Return-Path: <bpf+bounces-57757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A19DAAFB49
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 15:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0B11C07A11
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 13:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779622B8C1;
	Thu,  8 May 2025 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b5yNR3dc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="r/HWGHsF"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB4223DC4;
	Thu,  8 May 2025 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710728; cv=fail; b=ngqJfaALjeXZwitmuHKQ8PCzIIuDGYj6yy5ePEVjhu+/y5RjYTMC7rdjlTD9684QeqsIwDv7+Jc940pU2feL2w8b9HWKOsUsypcJSHl4Skd1wAhaOouOx0IR6WDsfb8vqeAlcZ0LI/rFiNEY5lSXFGi6iQa2dvNiQlkfir2tlP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710728; c=relaxed/simple;
	bh=sdgUYvsP+0L48HpQ816aROSkvLWpU+zradK1yWxLl+Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oaBTeaOlBjIolIKboXRT5gIkAPJl8boJRHRZYNXxw8szm+yu3l49Als3s8GhjGayZGcjHMg1eNo8H5/8NSRZTb547SwsBTUTwylpLY+XupzYyXl7D1fvx1huulgf265C9UCRcbhg3lQfMRAoUVD4FRKfdocVOporiXssqkUhXrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b5yNR3dc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=r/HWGHsF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548D2GSk029754;
	Thu, 8 May 2025 13:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NsVQON/P19vV03KaKUrGjOQy/r2jFn3jDlOYOYrNUb8=; b=
	b5yNR3dco23RT/nmtBLRtmwc/Yn8yg81FF7lu1n7F2YP7DvWDt+mwrUjjxalupRU
	kZApcqCqb7jR0FOIj7nPQcL2otVOoN7OcLAE8rTJggTpsSR/zRi+lHig+tNqWNQY
	tj2FWOA1W3iwVf9DBbwhtZGApxf0qbCMrd7fDyjlTBqR2/on6UpLajH/io6d3rUz
	j8ot6sQ0LCgKj+CX+r19vzhtZv2TCXW37EYqQYdRU5z+WDHmwxeB59jidRBiO20K
	s08RsP6fXEG0I4sLc6By+Kf603pfhMwsppSX/x3EUOL5FsboU/yaCKo9JWu5VbJU
	GIIFlz2cLb1+K8Z4CYMXPw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gw4x01tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:25:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 548Cnu4m002011;
	Thu, 8 May 2025 13:25:10 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013076.outbound.protection.outlook.com [40.93.6.76])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46gmcbr66y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 May 2025 13:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URK2rzPh/BBoIDscu7U2dMsgYCMtWW6NjCLyWOkku+MyTkKtKWNj+kHHcB2VlurxzMFcDLYyfBvESWVSF9UGj7rSnjKWDMS7j6idTXL65BpWP3zPEVrRlJkUe8fSeZCcZUpq0c0iIelewpYlyDFd5+pAZ0g4++XVf9UKlF/N2yGRHXZfU6rmIxs93jmEJAdfRYBFMYtEWqtHnUtojqORUqWpGiFHwM7oLt6j0gHS8Iv/GMb/4C7whu8F2r+q0iKAPMIjUZ4iraXtq9P0PJvONoQhO5B4HJmMrnXoDREMYW/2y07D2i/ujKBlA/oSm+BHHy74QI9OjV2dlkJY1EpsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsVQON/P19vV03KaKUrGjOQy/r2jFn3jDlOYOYrNUb8=;
 b=Mr0B9LnCvM34H4OrwaE4OKOFw/U9zTuqXNtsOoG0axDFjuBDw8gBFIY1wgVKHFiS5jxEKfK9IZYpKftvwDroxa0bva9u/6jfqiGawfQ6ezfW8yv/u7M2PjDB5BCIDALcmwGX3/wosUR9QRBGBP9CP7W4WF3L/ZgAf0NxPORw4ppzSfyqIneVWWq1xLpE3Al6kN66itKGYrZnI9fGnHXL/VIjBSj7XBabB+swhO/sXMhS8rIJA3jQt9URPqdIflN9IEn6DCofPvXXCAaDFfoHWOmG2YgVY/54dUuDwn7uOGVHRAYYZniu6ELomtXaHyepaXEWqvW/sZ3Qiv6Sge4pBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsVQON/P19vV03KaKUrGjOQy/r2jFn3jDlOYOYrNUb8=;
 b=r/HWGHsFPCA5ep/jmReDsvghKFyZQxJjS23sjD/xt6Sz+LWXoNlVcS6xs3rtwHBSWasTeClrAT8KHk7AZ2pTkui34JHpy9woKhX4D+1JT+WkEDhZsCGKd3jn2fx3ce0ncFBTqSOyBz5dArAVEUp4egG8el1p2KikjTRjrVdlFO0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB6423.namprd10.prod.outlook.com (2603:10b6:a03:44d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 13:25:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Thu, 8 May 2025
 13:25:03 +0000
Message-ID: <e0754d8f-4ac0-4e03-88f3-2901d49ca4e6@oracle.com>
Date: Thu, 8 May 2025 14:24:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] dwarf_loader: Fix skipped encoding of function
 BTF on 32-bit systems
To: Tony Ambardar <tony.ambardar@gmail.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
 <20250502070318.1561924-1-tony.ambardar@gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250502070318.1561924-1-tony.ambardar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::19) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 3633075e-d95b-4992-b835-08dd8e33bd89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vjh2T1ZNa3o5VjV6cmJVQWZOSHlEbG0rVGpwSlBGVU5kbWRRbnF5Z0FUbFZ5?=
 =?utf-8?B?UmdTdGtocjF5c2JER0xJcW42WjUrREtZYVhHb2xGMXdDRDJ0NHJVOEY3TVMz?=
 =?utf-8?B?M2R5M3pVK05WZmsxVHJvOVBUOWhjMGdiVWJBVEU4b0tjZ2dmQjVHYlJoaXJR?=
 =?utf-8?B?YnI0OUpjMzcxSHc1NEZReXFzYW9vcUlDNXBuTEY4U1hSOXo4aHVoZ2p3Ym81?=
 =?utf-8?B?cC9QN0hGdWxDWTB5bU5HSFUvVTVwM2JCbU5MclFPN2lyemhtdHp3WHZQVU5Z?=
 =?utf-8?B?OWdBVmtrQmt6WWxtLzhTcmxlTXJlZkJ1b0NBRVh0cTdBYW5KNzE4ODl1VGZm?=
 =?utf-8?B?MUp0bExONmlzSEIxeGkxZUlPdnM2YUtQZFoxM0pyaXhjSnhVNkYzVGpoRmcz?=
 =?utf-8?B?R1NSVTNtekcrd0ZRblhZdzkvK1QrL2pVZlMxaEVmREFzSTcxdGRMZWxuc080?=
 =?utf-8?B?cnB3WEJJc0YxMk5nbUFZR1h0NkdhWEVIWnRFZUFBQlFvcEJ1RWY0ZDA3ekla?=
 =?utf-8?B?L2YzRC92NzlabTVFTm1LUTc5R3hWN3hXRHozTlAwZFlsWWY3eUZWVnAzcVNZ?=
 =?utf-8?B?b2JsZzlMcHBCZmlmdHZzdTBESkx4djVIQzZoNHZOdWtoKzNJUWNxRVFCS21C?=
 =?utf-8?B?MDQvMVE1R3pVWDMrL2srMktnbWpYNjVVL1RXaHgwSi9DcndCZThLdUIvVGVQ?=
 =?utf-8?B?dVVNRnpyZHRJYUxyZUxETE12M1J6VFZYWXkyaXVkdUtGUjZpWGJ4SHRBdlpX?=
 =?utf-8?B?M3BqUUhSS1FIR2ZmSDYvY1FVRTNiR2VWQ0ZSNERUNnFmc0lzNmJJRXdMelNB?=
 =?utf-8?B?TC9vaCtINi9UZnRYOGc3SVBReGxvdHc1R0p5Y2tFSkMzanNhRTIxS3gwaDc4?=
 =?utf-8?B?SERFWHQ4b1VNK3UxRkZ3Qld2azYvQi8vRlFCYWw0K0xoNEJWVzBEZGRaNXNN?=
 =?utf-8?B?ckpxa0JxQ25zNlhaS3NsWWpRcGxvYUc5dmhMNDNYVUFqSmd3TTkvbnJXK3B1?=
 =?utf-8?B?ZWpOME56WDVSbDE3YUNlTDYwMVUvb3RGNXk2Mm5qZ0RrNmNVNkUxd1ZCZ09T?=
 =?utf-8?B?NWVpYjlhUGE5MWs4bStXaG1DRXR6dkxKVDFXazhRY3Z6blVXMWgwRGZLOEF3?=
 =?utf-8?B?U3ZJSXdIb3N0UWprUXlvZWNQRTlObG1IU3RyR1FlUm1ISWYwRGhGL1VLVWU1?=
 =?utf-8?B?TUtESTg0MXBmWStFdzBxWURIa2MvKzg1ZFU4bmh6QnlJSXFSZU5rbTdlam5C?=
 =?utf-8?B?RmdwOFFQUVlraXZGNkczb1pybVdKWnVmMWtzQUVra05XN2tEK1ovM0dBS1pn?=
 =?utf-8?B?RFNiNUg3bDBDejdsRVY4Qm9RZjVmVlVEZnN4WFNRclpQZXYxMC9SUzRpQVQ4?=
 =?utf-8?B?cWsvOTgrOUFDMjFkanhOaW4rVlEyRmd0VWhkVkcrQnlOUElJUWFGL2VCeUNu?=
 =?utf-8?B?UHRKdU9QbEdscnE0OTRTODJZaFd1MGw4QkhCcUVUbDhKSGdYTU5MeE9UVFYw?=
 =?utf-8?B?bjZseGZBZFNlcjY1Yy9jbnlJbWtPQ081aXg2ZDdaNTBQOEx1ZlJrY2pGK2JP?=
 =?utf-8?B?cFlyZUlZejA4QnNiZTR6SDZRTGpnSURxZFNZMzNWUGxsdGdBT21INHpiRmp4?=
 =?utf-8?B?VDlKKzBIMTlOWkhWU0lFbGJRNU5iR1FkMW5DblJJRVJQZkFubmcyNmdRSWpG?=
 =?utf-8?B?Z3VMMHhCc3RpWVNNZVVCYXZBZG5OYktUeUJkSFJNR3RsblZ6d0hkZWtjcDhT?=
 =?utf-8?B?azlkVThzK0VFVGt1QzdaWHk4aEZSRThib3k5THVxQzFSZXNTejZTVlIrcFlQ?=
 =?utf-8?B?bTl6KzBuRW9SY2NPNXBXbXpmWWE5a05WdVJDWUh2WkF2ZEdnTVhDMHJ1RFU2?=
 =?utf-8?B?R1h2dW9jdFR3VlhTRWtRekQyN3JTMVc0QkhKUWxPZjRJU0g4U0tWbFgxSnBZ?=
 =?utf-8?Q?bM3lFgF5vn4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUtUdmZHMjlUWlhTbXZkT25jak92cTF1aXdsRWJDYWZqTFdXcHc5Yml0Z3A1?=
 =?utf-8?B?bmMxSW1PNUoraHdZK1pNU0FKbGFYVTVyanQwRjgzdzlMT2Y0QnJ4cDdyOUoy?=
 =?utf-8?B?b0NBbjZyck90Y0RuTE5DdTFEdVlaTlowMHN5WFNMN1lYNHpqRlA4TGVybjE2?=
 =?utf-8?B?RCtybzZBeFpSWDJtWDZEYkN6TXhZMm1VUHQxYXFLTkFzdkRhd29tMmlBQnla?=
 =?utf-8?B?KzZwL3UwU1VoMHlqYURWMU1TS2h0K0E0MlVQQkRtSzA4Ni9KWTBDTkN6b3Fi?=
 =?utf-8?B?K2dWdGJDTFova2FtV0taN3p0dnBxcVpDNjZPclNEY3YvRi9lczA2NWtMeEl1?=
 =?utf-8?B?d0ZqVk55ZGIrdWhleDJBZ1pmaXozUWRvRTVBWFVraVRWUGFYbWFNeUUxcDd5?=
 =?utf-8?B?aFJ3Z2wrUmgreWYzODJ2QjFoa2UraVBmMlg0QVZDcVFQaFMvb2ZnTG4rTWVy?=
 =?utf-8?B?TXdqVlZ4WDZxQUFiV2ZDYXdteThZUXhEVTgxQWxGMXczTDE1U3diRWd2MmYr?=
 =?utf-8?B?UUdUelk5MEluTmxMck9hd0ZodDR0LzZEc1U0ais2RWJmSGx5eDduNVZ4Nng5?=
 =?utf-8?B?d05pT1M0eGJDTGlDQmdid0o4bGJTdUJPZVRMVGI0aFNJbG5ybkhBYWRXclRu?=
 =?utf-8?B?OUJDM0hYYWM5ZVpxU0Fiay94RGNibGVBTmxNZElnQkNvaGFvU0FuS1RNTmJZ?=
 =?utf-8?B?ZWJheHpQY0pmYXc1aGR6QUw5cFZGR3VmT1RpaCtFY0ZGZjM1M0krdkcrbXRG?=
 =?utf-8?B?N0VETWpTNWVTbGwxZjJZbXVXTmUyOXF5Q1VFWlcwcnRTbDE3NkhqVjkxZ1RN?=
 =?utf-8?B?cCtoMWtUK2JiTDI4TGR6RVEvVVRvUGR0Nnc1YTdWcTZDR0g2MmQ0OUxWSGN2?=
 =?utf-8?B?VnY3U1ZVckl2cEI0NGZGL0xEYmhBYnZIKzNmSkRnNDd6MWFySUhSa0pKbGdD?=
 =?utf-8?B?WDVybHZpRHlaVS82eUU5anhDNjZXZ0xVbWdrM21KVHNlZzdTNGVMZEM1OHQz?=
 =?utf-8?B?dFBXSmk1Qm5QcGMzbmlnSGp2b1d2RXF1bEQ5SldGbXBHQTlpZjQ0UEsyd0xa?=
 =?utf-8?B?ZUM5Ulk5UlNBREF6RWVSTFNJNkE3UzZkcmxQQUlYUVZpbmFlbnBpMHMrYk84?=
 =?utf-8?B?SWJJM1RmU1ZYMlJIT0ZrK3k2bDdBRGYwOWVzbU0xMUZFS0pGTVNzdWJybVFi?=
 =?utf-8?B?QXN1ZGhXdThMVDRpOWNiR3dhOUdCa2RleGtxT2hnOW0wbWZIbkE5cjNtcjNV?=
 =?utf-8?B?N3hQNkVLeCsyNGQ4M2ljdGpVYnM0KzRpRXpBdFg3R2gxNnpKd1E5aHpwelcv?=
 =?utf-8?B?U2E5YllpT21saW9wY1lvczBtTDhMVnZXejlxS04rVm1ELytLOWVxd3NsclNJ?=
 =?utf-8?B?ZTJMT2hKazQ0djNPUzA4RUJFS0xHbnoxSFptR3B4U3RuZWo3OFMvemdONnJ2?=
 =?utf-8?B?UGUzdlBpZWUyVkcyZTBpdXd5cEZFd04yRm1zR1ZMTkNTYjhpV3UwUFJGcTRL?=
 =?utf-8?B?d3h3OFg4YmMwUjRLTG9zdzlydnJQVnQzQ2VOMzdRVVlSNitWRU1lcmxiZWZH?=
 =?utf-8?B?UHczcjZyT3pDQklJdzF0dnVsaEhxR0FlenhaakZWblIyK1hoZzI4aS8reUtq?=
 =?utf-8?B?bUQxM25Rak91SjNkaGloY0NYTlZxV3RMbmR1ZXhIZUJEb29oYVIwREVKbENJ?=
 =?utf-8?B?NTh6L1hRVEFvVVFsUVhPUUpSSWZLUk13dExlS0JtTDM1TWVxNWhpWU1RZWZM?=
 =?utf-8?B?TVp6cHExUDFsOXdBZG52STZOSXU4U3cyZHZBMzl1bVlpeVU4NFVuRjgwVVMw?=
 =?utf-8?B?TUk5Y1R1VVBkSkFBV1NQUE9DRWpadGhTK00zc1d0WlBTQm43VEZqQmUvUElu?=
 =?utf-8?B?eWl1SDQ0OFYycUdmWDNwYlBTeklTL0h1amNoNDJRR0tiNCt4MGF6T25mUGRX?=
 =?utf-8?B?bC9NcTBuSFE5U2EwQWp2ZVd1b0owQStQeUdNZFU3SkZqTFUyT3RQYzhVZHRT?=
 =?utf-8?B?UzZRbkU5bndBeWJuQURVL0hUVkpQZCtPNjlqbytIQjUzUlRPK1ZQY2sveW85?=
 =?utf-8?B?MDA5UFJpOFRuVGViem8xN2NyaVU0WW5EdzdwRGJjOWNYcG4ydWhKa1FIN0dM?=
 =?utf-8?B?WWJvcVlrdVo0QWJiZ1BlK1JNMUhaTTNrWm9xTllwejFBR2xkYzB6azdWQUxr?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DMierV2ag2iMIaXZQGqeF2FZ+STOXu6G0MOSivshrM1MwOZS8eDLdSAAICDXWKDp7OCc5SRwnTJcyu5PZWBPgG+OV5aKDF6ejypoixxuP4ZiL770UHrNAs4C2ygMqJ4K5t9bylLxAtkDQyfzBSybiMX+2hD+2Mhk0s+jZJGoqj52DMNQfNpY9YshjVWSJb683BsHk6j/SfOsQC8w1cQd5yo+fdx7ahulCVVKjSJpK6m7L7Ms6g2gkzJTfS3f5UbUdhXlAPTuuWD1i9TrxnA0UnLSYmEsoOQ2Pz5fIPVOp6Cmc43zuYhcy92vbl0aMfbCYaQyw2lc+rzH3nb1PscFRlGVAXB6+Fr305JkUI5RYVCzBpfR1w4Ss4nfcSNPhgUT++ziPfMlty1hEZu0XiBqApGg1UdspdROUHCXr58HHMWiwOKENI6HzoNf2wWQEZv5NdADsrLqx/ULL5ydiynQK/+RW5NlXTLv9ovmkBevttEWbAKyrp5vVZVMCuLYaFxqNKnv9J0iSa7NlyLYkAjbFFsi3A21m8HIaOy+lFNwXRcvj86hOIm8XXPVrsKrf/MhErDHSlO5+ch24f0GXwSQ9IIE3ZylvVSnhHPS3eSJ1gI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3633075e-d95b-4992-b835-08dd8e33bd89
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:25:03.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae5GLBfEo3oQrD+cvPJVa+xyhJsrbzkZ3UOC8ltUBoq9D7rKiC2eUEUaa7At1AxCw5i7vegpkere6vNxMcACAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_04,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505080112
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDExMiBTYWx0ZWRfX8jqFTNTwwnZD mGFXJpGrZX7jUPcvjFUwEhTgEDtEZtKWiySD+Ss8CPjDov39NvR03f8Ou6ORDom0wZYUuYbPE41 iRD7kasr9Gz3VN9bEUN8GcPvMPDrVedVhHwhc/GAQp/2M6xRqBQ+87AF771EJAbjPrubHgd8VC2
 kPjT2aoDjv7rnW2Av4sPgRwYkcpYdZ1FTPREUE2TLIJ2B5Bs/j7OCxVRehldNKhfmpNwsQz4rNy n1doA7yZE7dHiNQmneZABMeI4oHDpcLzHODmZKrgX9uvN0q231pyDTtpEOV5lkfZtgrrrust3uL 7aeG8CpkC66OE9VlohGcMq7TJ3Xt6IeQMGR/SqgSLe0ORGUlZnCtTuWRO2HNJ8oOoRvTcTX1J6u
 zWuql14McELEluuWUMStB7EcAEfXYbNJJNmDGguosKBblASoijQ9aDUjwCcn2sBuj0qjnmaW
X-Proofpoint-GUID: WEvS4OALFqO7-UIhgSin9BB24hlIU9ac
X-Proofpoint-ORIG-GUID: WEvS4OALFqO7-UIhgSin9BB24hlIU9ac
X-Authority-Analysis: v=2.4 cv=Aqru3P9P c=1 sm=1 tr=0 ts=681cb0b7 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=Fq-898Mxsk5gQL65THUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13186

On 02/05/2025 08:03, Tony Ambardar wrote:
> I encountered an issue building BTF kernels for 32-bit armhf, where many
> functions are missing in BTF data:
> 
>   LD      vmlinux
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol vfs_truncate
> WARN: resolve_btfids: unresolved symbol vfs_fallocate
> WARN: resolve_btfids: unresolved symbol scx_bpf_select_cpu_dfl
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu_node
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu_node
> WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu
> WARN: resolve_btfids: unresolved symbol scx_bpf_kick_cpu
> WARN: resolve_btfids: unresolved symbol scx_bpf_exit_bstr
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_nr_queued
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_to_local
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime_from_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_vtime
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_slice
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch
> WARN: resolve_btfids: unresolved symbol scx_bpf_destroy_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_create_dsq
> WARN: resolve_btfids: unresolved symbol scx_bpf_consume
> WARN: resolve_btfids: unresolved symbol bpf_throw
> WARN: resolve_btfids: unresolved symbol bpf_sock_ops_enable_tx_tstamp
> WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
> WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
> WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
> WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
> WARN: resolve_btfids: unresolved symbol bpf_iter_task_vma_new
> WARN: resolve_btfids: unresolved symbol bpf_iter_scx_dsq_new
> WARN: resolve_btfids: unresolved symbol bpf_get_kmem_cache
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
> WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
> WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
>   NM      System.map
> 
> After further debugging this can be reproduced more simply:
> 
> $ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
> btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
> btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'
> 
> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> <nothing>
> 
> $ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> 
> $ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf
> 
> $ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
> bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);
> 
> The key things to note are the pahole 'consistent_func' feature and the u64
> 'wake_flags' parameter vs. arm 32-bit registers. These point to existing
> code handling arguments larger than register-size, but only structs.
> 
> Generalize the code for any type of argument misfit to register size (i.e.
> zero or > cu->addr_size). This should work for integral or aggregate types,
> and also avoids a bug in the current code where a register-sized struct
> could be mistaken for larger.
> 
> Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>

I've tried this on x86_64 and the issue of missing functions has
disappeared; I get the exact same number of functions encoded. From a
pahole perspective

Tested-by: Alan Maguire <alan.maguire@oracle.com>

However as mentioned previously I think we need to think a bit about how
libbpf for example might accommodate such representations, as the
implict assumption for fentry in BPF_PROG() is that the function call
register conventions apply. BPF_PROG2() handles the struct case, but not
the 0-sized struct case, and in fact there are checks in btf.c that also
need to be fixed to enable verification once we have 0-sized struct
argument support.

So in investigating this I've put together a short RFC series [1] that
seems to do the job in

1. fixing up the BPF_PROG2() handling of 0-sized structs.
2. fixing the verification failures with 0-sized parameters, carving out
an exception for 0-sized structs.
3. testing the 0-sized struct case to ensure we get the correct data by
adding a function with a 0-sized struct parameter to bpf_testmod and
adding a tracing_struct test to verify the subsequent arguments are correct.

In terms of cadence, I would propose that if the BPF folks are happy
with the approach, we land this patch in pahole, then after that try to
land the BPF changes. Does that work from your side? Thanks!

[1]
https://lore.kernel.org/bpf/20250508132237.1817317-1-alan.maguire@oracle.com/

Alan

> ---
> v1 -> v2:
>  - Update to preserve existing behaviour where zero-sized struct params
>    still permit the function to be encoded, as noted by Alan.
> 
> ---
>  dwarf_loader.c | 37 +++++++++++++------------------------
>  1 file changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index e1ba7bc..abf1717 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -2914,23 +2914,11 @@ out:
>  	return 0;
>  }
>  
> -static bool param__is_struct(struct cu *cu, struct tag *tag)
> +static bool param__misfits_reg(struct cu *cu, struct tag *tag)
>  {
> -	struct tag *type = cu__type(cu, tag->type);
> +	size_t sz = tag__size(tag, cu);
>  
> -	if (!type)
> -		return false;
> -
> -	switch (type->tag) {
> -	case DW_TAG_structure_type:
> -		return true;
> -	case DW_TAG_const_type:
> -	case DW_TAG_typedef:
> -		/* handle "typedef struct", const parameter */
> -		return param__is_struct(cu, type);
> -	default:
> -		return false;
> -	}
> +	return sz == 0 || sz > cu->addr_size;
>  }
>  
>  static int cu__resolve_func_ret_types_optimized(struct cu *cu)
> @@ -2942,9 +2930,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		struct tag *tag = pt->entries[i];
>  		struct parameter *pos;
>  		struct function *fn = tag__function(tag);
> -		bool has_unexpected_reg = false, has_struct_param = false;
> +		bool has_unexpected_reg = false, has_misfit_param = false;
>  
> -		/* mark function as optimized if parameter is, or
> +		/* Mark function as optimized if parameter is, or
>  		 * if parameter does not have a location; at this
>  		 * point location presence has been marked in
>  		 * abstract origins for cases where a parameter
> @@ -2953,10 +2941,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		 *
>  		 * Also mark functions which, due to optimization,
>  		 * use an unexpected register for a parameter.
> -		 * Exception is functions which have a struct
> -		 * as a parameter, as multiple registers may
> -		 * be used to represent it, throwing off register
> -		 * to parameter mapping.
> +		 * Exception is functions with a wide/zero-sized
> +		 * parameter, as single register won't be used
> +		 * to represent it, throwing off register to
> +		 * parameter mapping. Examples include large
> +		 * structs or 64-bit types on a 32-bit arch.
>  		 */
>  		ftype__for_each_parameter(&fn->proto, pos) {
>  			if (pos->optimized || !pos->has_loc)
> @@ -2967,11 +2956,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
>  		}
>  		if (has_unexpected_reg) {
>  			ftype__for_each_parameter(&fn->proto, pos) {
> -				has_struct_param = param__is_struct(cu, &pos->tag);
> -				if (has_struct_param)
> +				has_misfit_param = param__misfits_reg(cu, &pos->tag);
> +				if (has_misfit_param)
>  					break;
>  			}
> -			if (!has_struct_param)
> +			if (!has_misfit_param)
>  				fn->proto.unexpected_reg = 1;
>  		}
>  


