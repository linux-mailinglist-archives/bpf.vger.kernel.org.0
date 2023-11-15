Return-Path: <bpf+bounces-15088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B24997EBEC4
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 09:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A152813E1
	for <lists+bpf@lfdr.de>; Wed, 15 Nov 2023 08:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46FC4687;
	Wed, 15 Nov 2023 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OpxKPlh/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J7DVBs3R"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD637E
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 08:46:21 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CCC10D
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 00:46:17 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF8Xu2h000568;
	Wed, 15 Nov 2023 08:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dSwtSrwGkKblbQQebZ9hQ8c3CfYOHB1kjBS0xPw1DeU=;
 b=OpxKPlh/GdVXZuX/ovt8uOaezIXkzQJziCX5L/oaEGHekLYqSOWF7EnspmkOPJiuA89f
 JjIJlXJC9fYX0DeYaVpW0W3ZKZVVZb2okwnPEbR1MhPZ60RBm0eGuXFqrwBLPBhOCp8A
 uuH8+OlopvGPqcebpGS6h1uCp33yk68J9vYN90SgrQOxU6g6GyDAeJiZzlswlM1IPdcd
 tuUx/Hh3YMc24FTgyrjOhq5HgcjWRLSNfmTgyr5A4mo6GYF4HtpsA9NZbD0YL2LeK8sm
 4g7pZyOVLAwGlKM+SYJiv8qyTSqjzp9+PdoPQ5kE3aGZh7ET8H5HfrBrEUlZqYrpB8iG 8A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2n9ykfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 08:45:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF6edd7013072;
	Wed, 15 Nov 2023 08:45:56 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxq0pk7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 08:45:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuSnNvWYP+Jw64O+71Vx4XvVxOGstYybfg1XNp21UlCNhMfE33ewgizkXTAS9ANF3Dl2ub9mJjDHSf8zyaRkWS6HZ5ihyQdeYbdxH1urd7txbS6sJppzeAEZUeEgrzlntzpROyn5XFuim1OxEyIOjTLu6536dkAFIzrR3fMlZdcnWG02Irn7n3SBD3aQ+s7Vgq+D/sQODnX+xJd/yhDqYXgRQGA2A2ce1dK/F0SFs6yjeCQme5uHU/3WmLTDrhE2E6aj3jN6ZCUHcJRfTw5gchsqRBA9PHoJzDia3Vo8v1CNNble0Z8opAKFIapGSXyKmivuibxJkWuB5SjDqK8lKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dSwtSrwGkKblbQQebZ9hQ8c3CfYOHB1kjBS0xPw1DeU=;
 b=Vbgv3fHMlHut7X3PWUlVCB3M1+11kMwZ8b/D6v8NC1I94qPz72AarfKwwqPu5X1HOsWOd0gO6FpY9NUlBVCiRJwnuLgfL+qwbj/xWvXYMXGvy0ukyYrwD4Y+/6hQ/v3jSZbQj9QvrnajVsiWbmKehl04n+FYjvw81viNcIaWLM3/ox3YXneGeDzYfMdy4zBEBDb4W80flZLlCnvXoyDeBGSG5JVgKuTW5WOnHCkLVREO5lDINooz7HH4+8rh0BWZFPQBXRTmSJ9vDZE02Q4P04c7u7uPwfh3977hFWSs37DVInr+Dk92Il1jT7/YtOIeSG+2PhiqaVtAR5YTOYDs0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSwtSrwGkKblbQQebZ9hQ8c3CfYOHB1kjBS0xPw1DeU=;
 b=J7DVBs3RxWJZ9eK2DP5ruuUryEj+7qONqO58zUwANRB7c4nc4qUGJP8oMwVinKDlDJ8sA6T22UpTKTzvcjSrg6G3x0AufjR0bHeeoAsHOcLWIb7IfxgH7BsRbDeoJxq0s1LwyZBLcCDmYnSIzuMI1ScZdBfbocJsfCJot0wjQLg=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 DS0PR10MB6077.namprd10.prod.outlook.com (2603:10b6:8:cb::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Wed, 15 Nov 2023 08:45:54 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9881:65e2:3e51:ab48]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9881:65e2:3e51:ab48%7]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 08:45:53 +0000
Message-ID: <b6368b81-e141-13c0-7fde-c4cada3e242c@oracle.com>
Date: Wed, 15 Nov 2023 08:45:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v4 bpf-next 10/17] bpftool: add BTF dump "format meta" to
 dump header/metadata
To: Quentin Monnet <quentin@isovalent.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, jolsa@kernel.org
Cc: eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, masahiroy@kernel.org,
        bpf@vger.kernel.org
References: <20231112124834.388735-1-alan.maguire@oracle.com>
 <20231112124834.388735-11-alan.maguire@oracle.com>
 <ebb1d463-68f5-4668-b930-f5dfe1f52230@isovalent.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ebb1d463-68f5-4668-b930-f5dfe1f52230@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::6) To CH0PR10MB5276.namprd10.prod.outlook.com
 (2603:10b6:610:c4::23)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|DS0PR10MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f907508-c4f6-48dc-fe55-08dbe5b746b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hULOUDsM/snnrbLwIfZ06MKb1RQlQZ2SfzmRuY5v1Ll023Tqw5m7PCpjgid7cxPzBnq1NcgKPAMZ+Rl+h0ce8QoEZeUu7cSCrA9OyRyzggecFlJfi3VXmvduUAM+01LdKp5U0cqW3DN9C23j59R4N3TTvbR4LhpqNTh4Ut2n0dLSe8WEcrT6nMRFBSfonWNHLtgd20Wt6eOz4ODYSGTN/+1UnJiTcpZAeA36TvZparRIQwBXJemuQ4OpWzrOGZMNNdz4Bsg/63zK/JOlyHLKK3Flj4o1YqKiCmEIQvfKBk/ryIXU4850F+nv/BsauroUT6XR/m9qaGt0AVsqdoC0LiWBDdoZ6pgmHYCo8ytdUPxM/6a7nPxRFnqazvdILQuxmmfOPZgZYTGvPYfQZ8b5xeg+NCKJgaX4ZZ5zFM0Xl6sO4Wyf5+o6C7g9iZq52aqXpxcIUmJsc40wH6JVlY41LOMxwroOyXq/7lat/mT55V9pFlbwq+75qrhCr/TAwsAKcIYIKNtwFI+Zacz4aWngZLlD+M/CFu9VGF0vpXYxEYAumjAO4nVdiu2U6H6v4NJ/owWqf4j6Sji6kw6DQwg6CXqbucaBzoshmqNsIrvQ6aBouUvzo81B9tewuEyX1/8Z3VBbUT6xg6xS9+s+XKUBpg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(86362001)(2906002)(31696002)(44832011)(7416002)(5660300002)(8676002)(4326008)(8936002)(83380400001)(36756003)(41300700001)(6506007)(53546011)(6512007)(478600001)(6666004)(6486002)(316002)(4001150100001)(66946007)(66556008)(66476007)(31686004)(38100700002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SE5hdXZzaUtKbzBmcFE4bER0T3JpdmdOakJ4NElBVjRjZVpVS25VMXZZYXE3?=
 =?utf-8?B?ZDFlQ2IrajVnMVZ2dWJBZGgrQWE5K0RMZE83QzdoNVUzS0JHMFZmUjZXTDRG?=
 =?utf-8?B?d2h4VGdyNFB2NGhDZk1iRnV4Y0ZJaEs0YWpPTUdtUGZQUjE3L2N0MTRxckda?=
 =?utf-8?B?VVRJb0FpVG1sWFE5Z0pqc1VaTm1uRjhzaWI1VGpTMkFqK2t2eE5MUzc3VEt4?=
 =?utf-8?B?cklXOUVhMVY1MDF6Q3Zhdzhqc2IzaGZyVmlIR0JZZTNnMEYxNWl3MzZIQnZF?=
 =?utf-8?B?SkNKOFdxK0lwNUd1dHpOcURPT2sxRFMrM0JmWmFpK2VjSG1SdHpERStDSExC?=
 =?utf-8?B?NUw4L2IzSllwaDBYS1RSS2RwT1hKZWljc3JzL2pDaUxJY2dvZDFVbWU1dXhv?=
 =?utf-8?B?MDJUNWZTcWV4azlEM2d6Y0wyY2FqNU1rdkVGOHBoTzdCM041LzZyUW1wU0xE?=
 =?utf-8?B?VVB4MFFVU0QrVnBzU0ZBTXUvMjZvVXVZSkhDZ0pGbmdPd0RNWFV5QlFrZ2Ew?=
 =?utf-8?B?YUs4bTV6enB0cVlabFdhTk1qSkwwcElERGhnQ00xb21EelN5M2Z3YmRiSE5P?=
 =?utf-8?B?SWg1blYyYmtGZjdMQVdpYlVtWkI4b2hsdkhBbTd5WkNNVXJjVzZ3b2tsWmIz?=
 =?utf-8?B?K2ZUU0V0Vit6SjBuc2o1dlJuM25tdk9wT25xbWFnWXlJS2JHVk1TbG0rdWR2?=
 =?utf-8?B?UE5mME12WFYwRW9kZm44cnpkL056bi9RWmhBcWdnYXNSMHJ5eTNSblYzUnpN?=
 =?utf-8?B?V2krNkowRis3bUVjdXo4bExVOXZmaCtIbHhiT2kwbHNMRDVwNFpIblNFNm94?=
 =?utf-8?B?UkVFRnRnalFHR21TU1d3Q0NUZGZ3NW1CV0xGcDN6TDJFQmRaTFBvZDRuTmNY?=
 =?utf-8?B?aktBbHAwWmR6ZDQ2YXdwa05OWFVJR1ZUOUNJYUZxeWhpMnhQM2dLVmRyQS9B?=
 =?utf-8?B?Yk4zVm5qUHpnVUU1ZlZRMUdCR2tocmZsT3h4VGJ6NzF3eTJrWnlzQlAxWS80?=
 =?utf-8?B?TWJyWnY2MjJxRWQwMFVoSEFtRWNET2d2ZzEyZ3VXUmovYmpGUTlTSE1RZU5o?=
 =?utf-8?B?bjdhMHVvcjJZZHd3TnppOE1RVTRHV0JiWVpoWDI3WExndVpOSWpmOWtBM1V4?=
 =?utf-8?B?bUNLWW9PLzFnWCtRTk5kRyt5bHdNbXFTdzRoVVBUK2V3cXJhRVB4N1BLU25G?=
 =?utf-8?B?bTZSc1RQeFNCMFQvZjBOWEd2TnRkOWN0RnFOMjh3QWcxVnRTWW1LRUV6WWp6?=
 =?utf-8?B?NE9iUldwWXFHbDNJSWR5WkwvWVNtNWpDbTVmRmRadlZIV2xJSnVFRDNuWVRG?=
 =?utf-8?B?dG95bFRPSHBtT1R0ci9NQWRzU1V3SUtYVXlKMEUxbTNIa2d1cUxUd0lhNi9w?=
 =?utf-8?B?ZndVNVJqM04xUktRN08wZWhnSHFhcGJSYlBqSzVDMlA0R3EzK3lqOSt5djlV?=
 =?utf-8?B?WmI0YTR3L1FhZkZGdmJjOWw5UTYrM1hHbkl6ZTNkRmhjdjVVMnI1TVpOaGNs?=
 =?utf-8?B?UGtDeWF2RG52QStLRUI2cmpXT3RGbEpYck95MjF5THRXZDQyRllKWlo0MElu?=
 =?utf-8?B?bHhKaHhabUlGbkVrNlFiUUNsY01rbzUyamV6WnBkSm9yelpySjltVkhSdExG?=
 =?utf-8?B?K2IwSW1BRmVmNjEvL1ljMEhrUFIzUE9PQU03dlFGVWVDSEs1cTgrdGJFODZo?=
 =?utf-8?B?M2xvVUtQRzJvSXpWeXhvR2Y1S2JleWZTTCtyWDdxRndCTDJ3M3loeFJCbkNW?=
 =?utf-8?B?WEJsTVVMZlhuT0dXK3dzV0pzVW93a1pyMVBRc045RGhucGF6ZVhPdnBvclRa?=
 =?utf-8?B?ZFEzNzR5NlBBajVSRGFKdDFaaUZrdy9LdGtDeVNsbVM5T2tBVFhGWkt6Wlpp?=
 =?utf-8?B?UHBJWndkSE1VZzNVallLTVZwQlhGbWdXTEtZT3U0eVVlOXpQZXc1d09DbVBW?=
 =?utf-8?B?TXNDRzNTWGVTYVlzQXNXV2VqeHVGWTBveVF4YVJ3UDV6TDRyNlJoMXdCdUtF?=
 =?utf-8?B?TlFpaGovNnY0RUVPUWhET01nbXRvc3R3amJ1Sml1VUc5UW40MVY4dzVCQ3BK?=
 =?utf-8?B?dFZlUGpXMzJRcDkydDhIZ2x4Sy9JSzFmblFxdktPd3cvb1UzZ0R6VSsweEFR?=
 =?utf-8?B?N2ZZWXFxWFlKZzNVeXFuUzQ1dWtQODNqbWZod1JLNDA1RUloWlFiZlpXRFVO?=
 =?utf-8?Q?0+GKiKqttDYm0u/dZXlqEAI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?S0IzUWVlZmtxSER2cDFsN1VZRndsUVpSQnZNVmVVeTk1ZGc0Y2xjanp6ZnJF?=
 =?utf-8?B?SnBCVlhMVlZPbEZKNGpNQ0k4NkREU1pkVFN2RjRneUdwTzFqM1FmTUlVZTYx?=
 =?utf-8?B?Q2Z2UTk5VDNXQ0FacWM4TTlHK1YrQVk5b3dsK2lXOHBVRmhDQlRaODk5YWVs?=
 =?utf-8?B?Z3l0MHo0N3NqRG5jaE1zQVU1T2I2WXpuUmxSd2FBL3dHcEdSV1BSOVVsTlFv?=
 =?utf-8?B?Qk95V2lNS0VCbE5QS1lweWFkcnhqWHZmU1pscjRaZ0VFQW1vcTk0YTRjdTNo?=
 =?utf-8?B?S05EWUVnbVNMU0wyakh0SG5QTUJyU1lXUmZwRXNNbDRTd0pNak5mY1VxcTN6?=
 =?utf-8?B?STQ1bXJrNVYwajZMK2wzNG1jZzNaWEdvTnNZdFJOTFIzMGlwRE5TaTFTbXRw?=
 =?utf-8?B?ZllJblo4c1B6a0JsZWQ4S2ZUM1AyYnBvclYzVHQ1bDRrNENkcVBnZTlxYWpT?=
 =?utf-8?B?ZUtKMmt1SVZSQ1FDUDJDWVc5SnRqODRWK3pEVVU4UFhiVUtUUFI0dVgzWGZH?=
 =?utf-8?B?cENka2FRamorVzVleURVUFA4N0k0Q2svMk0rZVhUd1hzemdianEyNjExc1lp?=
 =?utf-8?B?SnlpZkoySHlCVENpa0x4eTFwV0QwalFqbFkyYkhDMWdYWWs2YjJZQmsrVjMw?=
 =?utf-8?B?aG5NOG9aSG5UZmtHYUpKRjc1ZUFvWUhPblhod3NUa0lpaG1ONGd4QXh3ZC9M?=
 =?utf-8?B?VUFJdTJNQmgvUFM0dEJQejJCUW5MZjkrWDZuRm0zcXFmMG40WGpYbWgwMmZY?=
 =?utf-8?B?dGZCZVp4SVJQSUlCRzBwZUdHL0NCZFRtNUd3NEVUajlaYXpkTy9mc1g4dlNt?=
 =?utf-8?B?MGkycExTazJWMGUyK2huY2VlOTNDTWhJVDZ3Ykw2RnNaYmJ3U0tNN3pkblVM?=
 =?utf-8?B?K3Z1a0xaZjhQd3BtYWo2VnprQmw2dFg4aFJSSThMUEw5YWtQNG9wdlNwd2g0?=
 =?utf-8?B?OWlYazBUblhMYmEyYmdVd2NBS2JkdGIxVy80blFYT0hVN0Z0OGN2R3BERXdJ?=
 =?utf-8?B?anJoVjlHbytYL0toS3N5c0lJRkNWamxQM2FLU0RWSGtGOFY5cVJMY1ZlREdO?=
 =?utf-8?B?K3hNV3h6bzQ0UHFFWHBydzhkMHFNbDN1cXl2cDVhc2JLM0NweHlsNmpzNUV4?=
 =?utf-8?B?WjY4Z3hEbnp6MS90U2sySitGL1E1a0xlYU9hS0kxSEF2OS91cEJjNmVBMm1t?=
 =?utf-8?B?YXJLQVNDanBlMWk1RWNTekNiQ0IzbStTei9FdWpOMElDa1hIbzRoQW53YlFv?=
 =?utf-8?B?Y0EyZTUwc3hQbVRqQVR2NDA3QmN1UXBqdERmbXBuL2VSMTRUdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f907508-c4f6-48dc-fe55-08dbe5b746b3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5276.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 08:45:53.5900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/sWiEmJffcyrGBh8RAHB6efNjilxq0c0Gjb6hRfNT/LXRE0+Jgn1MURN86/TAKxGyJR3uIN0VXlBbNESWpV/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_07,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150065
X-Proofpoint-GUID: ER4uGgSqVlG7NzVYeHG380kx6nuIStlu
X-Proofpoint-ORIG-GUID: ER4uGgSqVlG7NzVYeHG380kx6nuIStlu

On 14/11/2023 05:10, Quentin Monnet wrote:
> 2023-11-12 12:49 UTC+0000 ~ Alan Maguire <alan.maguire@oracle.com>
>> Provide a way to dump BTF metadata info via bpftool; this
>> consists of BTF size, header fields and kind layout info
>> (if available); for example
>>
>> $ bpftool btf dump file vmlinux format meta
>> size 5161076
>> magic 0xeb9f
>> version 1
>> flags 0x1
>> hdr_len 40
>> type_len 3036368
>> type_off 0
>> str_len 2124588
>> str_off 3036368
>> kind_layout_len 80
>> kind_layout_off 5160956
>> crc 0x64af901b
>> base_crc 0x0
>> kind 0    UNKNOWN    flags 0x0    info_sz 0    elem_sz 0
>> kind 1    INT        flags 0x0    info_sz 0    elem_sz 0
>> kind 2    PTR        flags 0x0    info_sz 0    elem_sz 0
>> kind 3    ARRAY      flags 0x0    info_sz 0    elem_sz 0
>> kind 4    STRUCT     flags 0x35   info_sz 0    elem_sz 0
>> ...
>>
>> JSON output is also supported:
>>
>> $ bpftool -j btf dump file vmlinux format meta
>> {"size":5161076,"header":{"magic":60319,"version":1,"flags":1,"hdr_len":=
40,"type_len":3036368,"type_off":0,"str_len":2124588,"str_off":3036368,"kin=
d_layout_len":80,"kind_layout_offset":5160956,"crc":1689227291,"base_crc":0=
},"kind_layouts":[{"kind":0,"name":"UNKNOWN","flags":0,"info_sz":0,"elem_sz=
":0},{"kind":1,"name":"INT","flags":0,"info_sz":0,"elem_sz":0},{"kind":2,"n=
ame":"PTR","flags":0,"info_sz":0,"elem_sz":0},{"kind":3,"name":"ARRAY","fla=
gs":0,"info_sz":0,"elem_sz":0},{"kind":4,"name":"STRUCT","flags":53,"info_s=
z":0,"elem_sz":0},{"kind":5,"name":"UNION","flags":0,"info_sz":0,"elem_sz":=
0},{"kind":6,"name":"ENUM","flags":60319,"info_sz":1,"elem_sz":1},{"kind":7=
,"name":"FWD","flags":40,"info_sz":0,"elem_sz":0},{"kind":8,"name":"TYPEDEF=
","flags":0,"info_sz":0,"elem_sz":0},{"kind":9,"name":"VOLATILE","flags":0,=
"info_sz":0,"elem_sz":0},{"kind":10,"name":"CONST","flags":0,"info_sz":0,"e=
lem_sz":0},{"kind":11,"name":"RESTRICT","flags":1,"info_sz":0,"elem_sz":0},=
{"kind":12,"name":"FUNC","flags":0,"info_sz":0,"elem_sz":0},{"kind":13,"nam=
e":"FUNC_PROTO","flags":80,"info_sz":0,"elem_sz":0},{"kind":14,"name":"VAR"=
,"flags":0,"info_sz":0,"elem_sz":0},{"kind":15,"name":"DATASEC","flags":0,"=
info_sz":0,"elem_sz":0},{"kind":16,"name":"FLOAT","flags":53,"info_sz":0,"e=
lem_sz":0},{"kind":17,"name":"DECL_TAG","flags":0,"info_sz":0,"elem_sz":0},=
{"kind":18,"name":"TYPE_TAG","flags":11441,"info_sz":3,"elem_sz":0},{"kind"=
:19,"name":"ENUM64","flags":0,"info_sz":0,"elem_sz":0}]}
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/bpf/bpftool/bash-completion/bpftool |  2 +-
>>  tools/bpf/bpftool/btf.c                   | 91 ++++++++++++++++++++++-
>>  2 files changed, 90 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/bpf/bpftool/bash-completion/bpftool b/tools/bpf/bpfto=
ol/bash-completion/bpftool
>> index 6e4f7ce6bc01..157c3afd8247 100644
>> --- a/tools/bpf/bpftool/bash-completion/bpftool
>> +++ b/tools/bpf/bpftool/bash-completion/bpftool
>> @@ -937,7 +937,7 @@ _bpftool()
>>                              return 0
>>                              ;;
>>                          format)
>> -                            COMPREPLY=3D( $( compgen -W "c raw" -- "$cu=
r" ) )
>> +                            COMPREPLY=3D( $( compgen -W "c raw meta" --=
 "$cur" ) )
>>                              ;;
>>                          *)
>>                              # emit extra options
>> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
>> index 91fcb75babe3..208f3a587534 100644
>> --- a/tools/bpf/bpftool/btf.c
>> +++ b/tools/bpf/bpftool/btf.c
>> @@ -504,6 +504,88 @@ static int dump_btf_c(const struct btf *btf,
>>  	return err;
>>  }
>> =20
>> +static int dump_btf_meta(const struct btf *btf)
>> +{
>> +	const struct btf_header *hdr;
>> +	const struct btf_kind_layout *k;
>> +	__u8 i, nr_kinds =3D 0;
>> +	const void *data;
>> +	__u32 data_sz;
>> +
>> +	data =3D btf__raw_data(btf, &data_sz);
>> +	if (!data)
>> +		return -ENOMEM;
>> +	hdr =3D data;
>> +	if (json_output) {
>> +		jsonw_start_object(json_wtr);   /* btf metadata object */
>=20
> Nit: Please make sure to be consistent when aligning these comments:
> there are several occurrences with spaces (here three spaces), several
> ones with tabs. For these, I'd prefer tabs to align the start and end
> comments for a given object/array, although I don't really using a
> single space as well as long as we keep it consistent.
>=20
>> +		jsonw_uint_field(json_wtr, "size", data_sz);
>> +		jsonw_name(json_wtr, "header");
>> +		jsonw_start_object(json_wtr);	/* btf header object */
>> +		jsonw_uint_field(json_wtr, "magic", hdr->magic);
>> +		jsonw_uint_field(json_wtr, "version", hdr->version);
>> +		jsonw_uint_field(json_wtr, "flags", hdr->flags);
>> +		jsonw_uint_field(json_wtr, "hdr_len", hdr->hdr_len);
>> +		jsonw_uint_field(json_wtr, "type_len", hdr->type_len);
>> +		jsonw_uint_field(json_wtr, "type_off", hdr->type_off);
>> +		jsonw_uint_field(json_wtr, "str_len", hdr->str_len);
>> +		jsonw_uint_field(json_wtr, "str_off", hdr->str_off);
>> +	} else {
>> +		printf("size %-10d\n", data_sz);
>> +		printf("magic 0x%-10x\nversion %-10d\nflags 0x%-10x\nhdr_len %-10d\n"=
,
>> +		       hdr->magic, hdr->version, hdr->flags, hdr->hdr_len);
>> +		printf("type_len %-10d\ntype_off %-10d\n", hdr->type_len, hdr->type_o=
ff);
>> +		printf("str_len %-10d\nstr_off %-10d\n", hdr->str_len, hdr->str_off);
>> +	}
>> +
>> +	if (hdr->hdr_len < sizeof(struct btf_header)) {
>> +		if (json_output) {
>> +			jsonw_end_object(json_wtr); /* header object */
>> +			jsonw_end_object(json_wtr); /* metadata object */
>=20
> Similarly, can you please keep consistent comment strings? "metadata
> object" here vs. "end metadata" below.
>=20

Sure, I'll fix indent consistency/naming and the docs issue in the
next revision. Thanks!

>> +		}
>> +		return 0;
>> +	}
>> +	if (hdr->kind_layout_len > 0 && hdr->kind_layout_off > 0) {
>> +		k =3D (void *)hdr + hdr->hdr_len + hdr->kind_layout_off;
>> +		nr_kinds =3D hdr->kind_layout_len / sizeof(*k);
>> +	}
>> +	if (json_output) {
>> +		jsonw_uint_field(json_wtr, "kind_layout_len", hdr->kind_layout_len);
>> +		jsonw_uint_field(json_wtr, "kind_layout_offset", hdr->kind_layout_off=
);
>> +		jsonw_uint_field(json_wtr, "crc", hdr->crc);
>> +		jsonw_uint_field(json_wtr, "base_crc", hdr->base_crc);
>> +		jsonw_end_object(json_wtr); /* end header object */
>> +
>> +		if (nr_kinds > 0) {
>> +			jsonw_name(json_wtr, "kind_layouts");
>> +			jsonw_start_array(json_wtr);
>> +			for (i =3D 0; i < nr_kinds; i++) {
>> +				jsonw_start_object(json_wtr);
>> +				jsonw_uint_field(json_wtr, "kind", i);
>> +				if (i < NR_BTF_KINDS)
>> +					jsonw_string_field(json_wtr, "name", btf_kind_str[i]);
>=20
> I prefer to avoid conditional fields in JSON, especially in an array
> it's easier to process the JSON if all items have the same structure.
> Would it make sense to keep the "name" field, but use jsonw_null() (or
> "UNKNOWN") for the value when there's no name to print?
>

The only thing about UNKNOWN is that there is a BTF_KIND_UNKN that
is displayed as UNKNOWN; what about "?" to be consistent with the
non-json output (or if there's another option of course, we could
use that for both)? Thanks!

Alan

