Return-Path: <bpf+bounces-15077-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AFB7EB7B3
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 21:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058C9B20BB4
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 20:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB46A35F10;
	Tue, 14 Nov 2023 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ApN57tLO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uYaK4jwX"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F335EEA
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 20:20:57 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180F2F5
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 12:20:53 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEJneYe006498;
	Tue, 14 Nov 2023 20:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=G+kA8uj+0RbOqaOKWDsLpXYlZYxmjgx2kHHhejQNuMM=;
 b=ApN57tLOZcwcbs3SNxVs1TVIWai5xAS4GuHTi9pgb9qoS30njJbocsoyTg2UavuXUiEm
 pzP7L7vOOZLoS+QmyjCYNGriaedJ2B20SeLPxMTJ0lqr80wNjnCk+gBU17DEKRxdhOhJ
 roRaBqBNPnEvqJQsk2lNt9g5uFLRNvL/GK3D6e6ur9LeUgPOeS9jMsx2xr9RGh6e4/Ib
 EDjF/xMz2BuUnYeUx+v5q4v1ziCEMVdmHRxKZUG5NIsKCGroMOnwhWANVS249bdST2gF
 SZ40pYcVxdGi71eugdmqOZxXV4HXxGzFiKmsu17opX2Jc88AJOX9ZfcJUmwZeZCDUhf/ 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2m2ejt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 20:20:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEK6OAX006887;
	Tue, 14 Nov 2023 20:20:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxh1vy1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 20:20:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIIfWgXtrnRVL6zATuPhzFYb/qeYnQ3vT5nbo7ex8n+4ydMc/RY/q8dAvw+309DZl8A6XN2SI+tsD9AaB9KELxVPhBBc4+FzIy3fFNcfxAzm2Ubt9lnLr1JxyhJtDk+Y/DdfQkyhVo865Ul/KsojjGTd+HAbDpDz88QD/xJpBCw7PGe2NEB9azhw3qEC/jKhVq5iDSYJPC5jVkoYpjUq2pVxF6jKcStuJJkPzn050gG64UmvFs8UoBjmgjbE8k+el+Ei+TlnLEZVNdFj1CFyZOqVRNQkLmNy9vBS4yS63Q8Ai0hnAYOLctliHDVkRfO3QUIEkvO9veLu3nkXaDw5qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+kA8uj+0RbOqaOKWDsLpXYlZYxmjgx2kHHhejQNuMM=;
 b=UqiGlw3p44RsZFB6+yw2LpY91viCd2boNa815ODL65am5O/Cy4uKVx1zWIPNuegmSpGb2YKdShKULeJ7iKr1kVxFVzWl+3ewfp97yyPmmQEPRZTsaxTs2G9G93EafD1hsM25KsqDtGTuWBHrO6y7ume1Tcqo8E7ZRtp34E/WXwl0iUSREVtY1iTOi60ABsdfIIEJ8NYlxBRbRGKM3GmmAI7PwGmmvUEyAmRWIUD9o3UMlN+rXyp893hZKQFchBje5qrUzwf7RxlkNWCxwxoZKoxTOXfsm1bCIyg+emP4M056xVXMpc5QToUdrpYMCPV2mrVCl4n6DkH9xt2AONoYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+kA8uj+0RbOqaOKWDsLpXYlZYxmjgx2kHHhejQNuMM=;
 b=uYaK4jwXcFerWKv57YnVRBPsmnGz+xmZmx+Ld03gftfmP3o2lyNY4kZtYyPQq6FUvYV60QruaRdhysu/wfDFKLuqYTvYb3w56UwWNwQ3spMZUp56Sfb2zEemEJ90+lOuB6dQzehkVhe+rRx406Imv+tfTY0i9KufLVxqva3yDtU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 20:20:28 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 20:20:27 +0000
Message-ID: <f546e2bf-982b-62cd-b2d4-88760d4d97d7@oracle.com>
Date: Tue, 14 Nov 2023 20:16:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 bpf-next 00/17] Add kind layout, CRCs to BTF
Content-Language: en-GB
To: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: quentin@isovalent.com, eddyz87@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        masahiroy@kernel.org, bpf@vger.kernel.org
References: <20231112124834.388735-1-alan.maguire@oracle.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231112124834.388735-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0126.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ea9a52a-8923-4d72-c1e2-08dbe54f2429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YL4xxnUxcrEwMfQJuLWFGhlPreMz6GbXG3kjUR5XqeU5SHY7G+vrc5sVeZewxoXSgoH3m7dq7LEqGgpoAV2H+iyhTy0DVLYAQPSvj2Gi87fS8eMnlmpY2NuZ7KdS0pC9iWMBxf0wVcvfQW80WVzrjzWX8UTz+MMe4UF3WIPwa6TnXlJWgFJaEMRrTF5tKTG9DFrjJJb/QMGttCZoP5LrRSclUjGYF0a3sVVEdI8di0a3MECsP1SF7g7rarIAC0sbJseitEOOSHcuDwKHfrIQc9F9MRXo4dJbscAIhxpo7dDONxGc0x6lsxO3V8LmVUN4N7gBK7zx+NVc+EmOU1i6D5LkKJpZAmZCVg+UWt02cf/vdqKM6Hbm4EHtzgKlscntmlaoRkW2Ap64B4Iid4kPAe1xyNneh243Ay+UCy0i47bFczhdWWoiOmkwQm1ovqsuT/BW9TkE4+b5tC1jju2sgHHyFNMYQs2E8RYouiZZVrVbDJSZmM6MlmpUCwxkM+wKi3IGwkCxt20x3i5iGgMB4UrKpLC9XF6YeTiNozek+F3BWUttm1dZ80JOJlI8nTi2x+oJsvcvwRzx2T22ZJEStpTOSGzTKCWgbrELmILuPGaxns1sao0b8Ljnwf9Ix6iDXefACU7ZqyEY374e0jXkLQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(53546011)(6506007)(31686004)(41300700001)(478600001)(6666004)(6486002)(966005)(8676002)(8936002)(4326008)(44832011)(316002)(66556008)(66476007)(66946007)(6512007)(5660300002)(7416002)(2616005)(66899024)(26005)(83380400001)(2906002)(86362001)(31696002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djJEYXc1VkErdU9ONnZiZzBmQlVWemlJQ3dibU5sb1VJc0ZvVXhuM2RjYW5H?=
 =?utf-8?B?cXp2eVZiL1k4UlBEbDlycFVvT2dwWitlb1NsVDVQYnRkWXR0N2d1NVJPbkpT?=
 =?utf-8?B?QlRHdUExNE5MWTRNRllBUml1K2VkblNUQk56MkNKcFM1Y24zMm5RSDNESVpI?=
 =?utf-8?B?WDFZRjgxZTFEUjNXN0N2TmpKSG9EQTZmNS9PNzNBbWtDV3krRU03UUp2L2FV?=
 =?utf-8?B?Z0JnZ040bmFKYnJWSGE2SW40SFc5bmtSSStIWVdjWFJIclRVV1ZQNVJjT090?=
 =?utf-8?B?d2doWms1UktlcVZqM3g0eGdNdWRpODZ4bVJTTmxoS2lKbmdML25BSFc0V09P?=
 =?utf-8?B?UEd4ajFxSzRYei9ESkJRM3BmYTZSNFdWVm9YeU9zb1ZCWm5HWXp1N3FxZlhE?=
 =?utf-8?B?bDExc1J4UG1aMVhzNzJpOFN6N2pwSTB3dnRqc3QyMlJnZ2s2ZjJMM2t0MS9i?=
 =?utf-8?B?OHZxRUdrRjNPMys5NU1RaC8zVkhaK0lYclp0blJFd0NHQmRqUldrRjdVbGJ1?=
 =?utf-8?B?NjE3ZC9KYldmZzVQUEVJUzk0T0M0c01sSU1TbTZQclVoSEd2QnFqQmR6elQ4?=
 =?utf-8?B?TlFUdHZHOFE0enZRakxFaDZlTi9lcUdDSlBSOWZXbmlmVVNQWEVQSGxCSCtP?=
 =?utf-8?B?QTNqNEtmaWRoOEd3dEY4SEFDbmNSdVpSVmkwZU5rMjAxazh1bHNjTXlWbWdo?=
 =?utf-8?B?QUJRd29jOFRaNkVWNDErcDNJUHN4UStaQktQc3llb1JiK3hFWVFyUzAyVTZW?=
 =?utf-8?B?MVVMRmErTjloSlErTjJxVkRkem5QTFAwbnViK2xoQ3FEalNKQUJndEtGVWJX?=
 =?utf-8?B?cnZXZFEyUVBpQW1aN3prZzlscmp3UGZORnErUHdTMHd1YXNDUE9jMURuSnJx?=
 =?utf-8?B?SlZKdGlvVjhzekN3ZEVtTlFSNzl1L2p5WHlseUVGTnlDbDQ4STk4UVZIZVk5?=
 =?utf-8?B?TzhRTE90RkloZFU2K1k0a0w5Mkk1b3NCcUh5alA2bERNV3lqUTVncUVYaWY5?=
 =?utf-8?B?UXZBTlVLTUQ4Q0RVQ3d6cU43NFFCV3EzZTlKQmxvZEVIRHBPVzhaMElVdG1w?=
 =?utf-8?B?bkpXeStrZSt1b1REbGd3UGo2SXFjSFE1V1hYWlhEN0NGOEM2dzZ6SEpYeU9O?=
 =?utf-8?B?ajBYQmFzTFU2OXNXMVdOTTIwaXBRQWFWbG5iR28wRDJZOC82T1BhZ0E5NTY2?=
 =?utf-8?B?L3NLQkNYZzFxUmpzRWtTLzNxcHBlRWlJbzFROVduUS9qakNkVWVuK3BpaUFE?=
 =?utf-8?B?Z3dXRkxYMmJ1cVVZWC9nOTlxcUYvWHptVE9HZ3JBeGg2TkZVaUI5LzZud0pv?=
 =?utf-8?B?S1FpR1ZyamhsWDE3eFY4VkltclZaM2JZd1l1S3R6Q21aOFZ5dzJub1RKODIx?=
 =?utf-8?B?ejFHekNWbktZQldpYUpUTXBTazRlWm5Cb3JQSWlDcFRoV3NkYUw2Q2tNeHNI?=
 =?utf-8?B?c25pWDJLUklMS1dVV2F5c3pLREtMbnp0ZDAvV2l6M2c5VmZIN014UUZzYm9M?=
 =?utf-8?B?VElSTk1uVXVXeXlhMHRncnphSG9NU2xFUmZWR3JZdEU0MFpYRHAwWEJrTmZz?=
 =?utf-8?B?bk9MTmFqdTF2cklSMlpHL0dWMjRKVHVLRFlKUkdKU3pjY0VqOUphNHVHQ1Jj?=
 =?utf-8?B?S0hzc2FkQ0ZKRVFhTmV5TWorVm1GanRVZ1QzQ0NFb0M0c3B4d2dTR1JUTEc3?=
 =?utf-8?B?dXpUUUw3OVpiUkNvby82b2xERWp4Q3lFTnZYMDlKNEtMZVJoUG1mV1lWWllU?=
 =?utf-8?B?Q1RObTcwV3lDNVpNd2Z2V0FoMEVlQ0ZHbnFQT1hLOGtMNVQyQ0V4d21HNUJs?=
 =?utf-8?B?dWpSYVNucWJJTHdMQUtLZmhkTyswSmNCL3VRMTJvUGNvZU14VHhuOG43a2po?=
 =?utf-8?B?Rk9HdzZjZ0h5ZmRwMWIzRFpzV2JJM083WmdIbU1ISDZSdXZyc0lPdk1YeXhY?=
 =?utf-8?B?K3paU3BMUklZNThiYVhScjZJTFc3b3Byb05CZk80VmVRN1gzYVNHczNBVlJC?=
 =?utf-8?B?WmZacDYvcW53SlBUYXZzbDNTL1FjNFJseDZpZjgwZFQraVFVR2RBR2VPTUtR?=
 =?utf-8?B?cWJOTk03WVAwdG9sVlV5bXZYdDZGODFBd1ZGb2srYnpQbzdmTm1TQXoyczYx?=
 =?utf-8?Q?nqXiVt844U6WuLqsruQpMmG+w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?eEdjZjIrZ1pReUtpaVppelZNc240akY3dEsxTzNHbGI1c3MxcWhURG0zZWht?=
 =?utf-8?B?OGoxclhXc1hyb2VGWGNrQjUxbSs1QVYxNXNmdVpzdEp5alZiM0x6ZTc0ZWZn?=
 =?utf-8?B?di9XdEZTNVdiejdQYlY0R1ExRHpmS293Q1ZKOFRVMVF1eWZjYytuSXBmbzV2?=
 =?utf-8?B?V285UitSVndUUncvUE1wZkN3cE9oM0JQR29SY3VtbGJXQ3VPYnp2dzIrNXhT?=
 =?utf-8?B?bE1BRU9tdGNLQzFueUhPWm43Vmwram5meFhpRndNRHQrYXl5U1N6VjRWRFhh?=
 =?utf-8?B?Q3R6cTNOcngxR3U4RzBtQjZwN3ZER0U1SENsenlZQ2RoNmJ0YjJIQVdQZ09k?=
 =?utf-8?B?L05CQ3FTV2xKMVh2Vk1xbU9VcjFmSlRkZkZmWXk2R2RYSXhMVXBhWXF6L2dU?=
 =?utf-8?B?bk9ya01XdEVKTjl3VXJHampXKzVYWmNtZXZKczVPSEFCUXJoajFYUjJTdVdT?=
 =?utf-8?B?ckt4dGFTLzRCUDFZNlFBQjhPbldFaXZWVHRkTno4WW93am1hRHFlOEpkWnFa?=
 =?utf-8?B?eTNDMnRWaVRBSXBIZlU1d2NaOHNuanhyKy8yaGlxVnovZnl3WUlMcm5qWnA3?=
 =?utf-8?B?L0FaNFVsRjJxWVZoYWNLVlhCR1UySEs5NlF5V0UwQmp2dTVzWkp4Ykt2Zzd5?=
 =?utf-8?B?VU5UUGt0MnltMit6WHlJekdmcG1NVDUvM1FZM3N2VzZ1SGUvSSs3aXdUektw?=
 =?utf-8?B?bU1rNkFkSkNoYkc5NVVEWXZnTmFVUC9GS1pHdkRjWkpHNjd2dk5zUVJ0NERS?=
 =?utf-8?B?amJETlhiVTU1dzVhMVVpVkZFZDNzaXd0Q3UrVWw0aWZhejJFSXpLY29wWmZo?=
 =?utf-8?B?UklhZVAzUy9Ia0hoSlZIcjdLcVIzY243bGZGUGdkcVFZZGIzSm1xMjZGZ0FU?=
 =?utf-8?B?NE50QjFxSGUxUzhLazNpaTdQSDhpOHlGQmJqT3EwN0NaV3BpOXB5Y0JlNjRo?=
 =?utf-8?B?M1RtRGszUU1Rcy90N0gwZEswY3lISXdGNXlPYUFna2VsOFoyamtXN1dLV2lW?=
 =?utf-8?B?aUxGcFpldmZGS0ZIRVAyTnViMGo5UUhXMkVBQXk2UEV1WFVtUFd1Zkk2eWxH?=
 =?utf-8?B?cHBJejlWR1R1bkNUSnN2UG4rZUVLSWtmbHlIYVZXWEQzb2JzMzB5VDk0SnlR?=
 =?utf-8?B?eXRNekwrSmZYNUJiUk4zck9vOFlwQTVGL3N3ZktoVXR2OTgrLzlLek9LUUl4?=
 =?utf-8?B?NVpjR2YzVkVTUktSQW0rZzJjSHk5OHBVU2Rod3E5YWxkdmYzSGRDOUhERlAr?=
 =?utf-8?B?cUtGWUY3RHExby9NTFV1TEFVaHZVQmZVUXMxNkNvdUdHbUlMdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ea9a52a-8923-4d72-c1e2-08dbe54f2429
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 20:20:27.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9OiovQVBjMerueaOUTZNDfXpljaCvYQGwmWGuewAJkSIBvkdek5Hm9PMiPCsLZaR42nMs/5jyMiuvxo76FNhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_20,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140152
X-Proofpoint-GUID: dnzOkPzXHpgbjIkN3yg7xh4d1pGjnC7e
X-Proofpoint-ORIG-GUID: dnzOkPzXHpgbjIkN3yg7xh4d1pGjnC7e

On 12/11/2023 12:48, Alan Maguire wrote:
> Update struct btf_header to add a new "kind_layout" section containing
> a description of how to parse the BTF kinds known about at BTF
> encoding time.  This provides the opportunity for tools that might
> not know all of these kinds - as is the case when older tools run
> on more newly-generated BTF - to still parse the BTF provided,
> even if it cannot all be used.
> 
> Also add CRCs for the BTF and base BTF (if needed) from which it was
> created.  CRCs provide a few useful features:
> 
> - the base CRC allows us to explicitly identify when the split and
>   base BTF are not matched
> - absence of a base BTF CRC can indicate that BTF is standalone;
>   i.e. not defined relative to base BTF
> 
> The former case can be used to explicitly reject mismatched
> module/kernel BTF rather than assuming it is matched until an
> unexpected type is encountered.
> 
> The latter case is useful for modules that are not built as
> frequently as the kernel; in such cases, the module can be built
> standalone by specifying an empty BTF base:
> 
>  make BTF_BASE= M=path/2/module
> 
> If CRCs are not present (as will be the case for pahole versions
> prior to the proposed v1.26 which will support CRC generation),
> standalone BTF can still be identified by a slower fallback
> method of examining BTF type ids to ensure that BTF is
> self-referential only.
> 
> To ensure existing tooling can handle standalone BTF for kernel
> modules,  we remap the type ids to start after the vmlinux
> BTF ids, to make it appear to be split BTF.  This allows tools
> (and the kernel) that assume split BTF for modules to operate normally.
> 

hi folks

I wanted to capture feedback received on the approach described here for
BTF module generation at my talk at LPC [1].

Stepping back, the aim is to provide a way to generate BTF for a module
such that it is somewhat resilient to minor changes in underlying BTF,
so it does not have to be rebuilt every time vmlinux is built.  The
module references to vmlinux BTF ids are currently very brittle, and
even for the same kernel we get different vmlinux BTF ids if the BTF is
rebuilt.  So the aim is to support a more robust method of module BTF
generation.  Note that the approach described here is not needed for
modules that are built at the same time as the kernel, so it's unlikely
any in-tree modules will need this, but it will be useful for cases such
as where modules are delivered via a package and want to make use
of BTF such that it will not be invalidated.

Turning to the talk, the general consensus - I think - was that the
standalone BTF approach described in this series was problematic.
Consider kfuncs, if we have, for example, our own definition of a
structure in  standalone module BTF, the BTF id of the local structure
will not match that of the core kernel, which has the potential to
confuse the verifier.

A similar problem exists for tracing; we would trace an sk_buff in
the module via the module's view of struct sk_buff, but we have no
guarantees that the module's view is still consistent with the vmlinux
representation (which actually allocated it).

Hopefully I've characterized this correctly; let me know if I missed
something here.

So we need some means to both remap BTF ids in the module BTF that refer
to the vmlinux BTF so they point at the right types, _and_ to check the
consistency of the representation of a vmlinux type between module BTF
build time and when it is loaded into the kernel.

With this in mind, I think a good way forward might be something like
the following:

For cases where we want more change-independent module BTF - which
is resilient to things like reshuffling of vmlinux BTF ids, and small
changes that don't invalidate structure use completely - we add
a "relocatable" option to the --btf_features list of features for pahole
encoding of module BTF.

This option would not be needed for modules built at the same time as
the kernel, since the BTF ids and the types they refer to are consistent.

When used however, it would tell BTF dedup in pahole to add reocation
information as well as generating usual split BTF at the time of module
BTF generation. This relocation information would consist of
descriptions of the BTF types that the module refers to in base BTF and
their dependents. By providing such descriptions, we can then reconcile
the views of types between module and kernel, or if such reconciliation
is impossible, we can refuse to use the BTF. The amount of information
needed for a module will need to be determined, but I'm hopeful in most
cases it would be a small subset of the type information
required for vmlinux as a whole.

The process of reconciling module and vmlinux BTF at module load time
would then be

1. Remap all the split BTF ids representing module-specific types
   and functions to start at last_vmlinux_id + 1. Since the current
   vmlinux may have a different number of types than the vmlinux
   at time of encoding, this remapping is necessary.

2. For each vmlinux type in our list of relocations, check its
   compatibility with the associated vmlinux type.  This is
   somewhat akin to the CO-RE compatibility checks.  Exact rules
   would need to be ironed out, but a somewhat loose approach
   would be ideal such that a few minor changes in a struct
   somewhere do not totally invalidate module BTF. Unlike CO-RE
   though, field offset changes are _not_ good since they imply the
   module has an incorrect view of the structure and might
   start using fields incorrectly.

   Note that this is a bit easier than BTF deduplication, because
   the deduplication process that happened at module encoding time
   has already done the dependency checking for us; we just need
   to do a type-by-type, 1-to-1 comparison between our relocation
   types and current vmlinux types.

3. If all types are consistent, BTF is loaded and we remap the
   module's vmlinux BTF id references to the corresponding
   vmlinux BTF ids of the current vmlinux.

I _think_ this gets us what we want; more resilient module BTF,
but with safety checks to ensure compatible representations.
There were some suggestions of using a hashing method, but I think
such a method presupposes we want exact type matches, which I suspect
would be unlikely to be useful in practice as with most stable-based
distros, small changes in types can be made due to fixes etc.

There were also a suggestion of doing a full dedup, but I think the
consensus in the room (which I agree with) is that would be hard
to do in-kernel.  So the above approach is a compropmise I think;
it gets actual dedup at BTF creation time to create the list of
references and dependents, and we later check them one-by-one on module
load for compatibility.

Anyway I just wanted to try and capture the feedback received, and
lay out a possible direction. Any further thoughts or suggestions
would be much appreciated. Thanks!

Alan

[1] https://lpc.events/event/17/contributions/1576/

