Return-Path: <bpf+bounces-12146-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1F7C880B
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 16:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2786E282E45
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 14:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501F114006;
	Fri, 13 Oct 2023 14:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CacyjTcY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aC6H5Buu"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA812B7F
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 14:44:30 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2915EE1
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 07:44:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DE0six024960;
	Fri, 13 Oct 2023 14:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7w1URG8MiGwt0YCtJJ+ma/MTo9l4o9HEmqPYo/XoXwQ=;
 b=CacyjTcYRs7u5cj5+NPK0XcXcAeM4l6v7McREyY1+AvVv0id3/hf4Ddjx3mKPSWhL1FH
 U+ul3OLT8yUwlnbR/IMROaThJcCP3aplw8MbEa4VofxR7mwLxZ8WweahM1BMusvzUnju
 wCWvMozhBsoCH2NT4oVi6geDmJaWgJjgB3PF0TZshHsbDtW9oB0ijBfHSub+p3tl5tup
 pNXZaS0Yfh3v+Z6BIBCkHekuJmkz5NUnXtcc1g4A2FX1PEAd5dLkXAbZu2IxAYbKgI77
 Lvn+yFeXLaMcJnQZB5AuprXtq5fTiEhVoETVuc49l6QGzU0E0V5mYHNdRtMFIdtF2jWk BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx2d6u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 14:43:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DD3GXk036781;
	Fri, 13 Oct 2023 14:43:53 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tpt0uf560-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Oct 2023 14:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mADxIyVllcLgXsYeqAjFSduI9UpY647iuIUsNDI9TPNL8fB3WWGtoBsnNthLkjlDC9gwuq+E3w+d+d/uh5iJ8PgNP14WAAkToN5SSBAczQ0YgVPP9zya3BpZVd7UwLjxCs6ggtKdipCXiZKe7dSlOcluRxMkTWPfsMrvZIfD/DU08a9tmPoGtlt+7qUk8y/IpIBg8qofEUN8QdgkzW/vMRD4qaorhjtxL6u3O+Gt7tNT4NzpeI59p1PeoRBHMm41JAvgbwkdPRIyOulhfGhE5RzrfIzPVGCcM0WOLSmtKWWc5JVV8+96Rsg7dAGZl+0S+C5k3d+saOwagMMX/5K80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7w1URG8MiGwt0YCtJJ+ma/MTo9l4o9HEmqPYo/XoXwQ=;
 b=PE2hk877DQUiIpFhDPJwmGGWWvTQToFCjmh8lvAQqD2WqSY7ybkddAIphFbTiUrnSA2cx6Qrr5n8Hzh+AcZbpjjPFEjRaapPBPf3I8XaGQOleKHY0GjEfg9NSqeOIQT5gINU55vga5cmQqxoGTYiDtzgS4GoTqvaRgWrh0vEiKJfqterKjO7/MsZuyhrH01zk1kA+qbD/2Hc9eBVXYp4kDVWXzabaw50Rgw4CVNdPnMof3F1JKsujTOrKf4tKBElSj4QlbhRBeN+rqF18/rAqpGlFfDQDexHTpbgGkCzcdABUahylTs9nXWVlrgzFjpulrDVBwsfwvGCIG5J39YoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7w1URG8MiGwt0YCtJJ+ma/MTo9l4o9HEmqPYo/XoXwQ=;
 b=aC6H5BuupC5QB1kgKfvs2QnPeaHkMaQE0q+vt0Tk8JTGzYjLaLdNxiQbEW0w/ntGqJllczI5+oB5x9aVwUuiDf76G3iGmXHV8xqg6sQ7/4LYwPO6GIz5WSZY8ZDTj3Bruvfg+oI5aaFye7Ey+iF10ij5CTo4hmqZ2UMZ7NDm0r0=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.43; Fri, 13 Oct
 2023 14:43:08 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 14:43:08 +0000
Message-ID: <647e050c-56c5-7fc2-9a25-c18ce7f98529@oracle.com>
Date: Fri, 13 Oct 2023 15:43:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Content-Language: en-GB
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, andrii.nakryiko@gmail.com,
        jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com>
 <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
 <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
 <5b40ffbfa5949c24dad44ed6adf70d35cf72f757.camel@gmail.com>
 <7b4ff1c8-f8c7-b96e-c581-f27a389379f0@oracle.com>
 <07a9eb9eaa6cd424ac5025f76ea620eae6062c54.camel@gmail.com>
 <401a9b36-9a4c-db0a-272c-e85eb31aeccd@oracle.com>
 <ZSlRftMvOpscFe2S@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <ZSlRftMvOpscFe2S@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0048.eurprd03.prod.outlook.com (2603:10a6:208::25)
 To DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f080a97-fc2e-4be8-70ce-08dbcbfab793
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xLAuPE/AYX7y/JMdrEnRGnBrBQpfD9ow07sb/fPkvv1zhEgIuFIrJgqAXjzT8MKO+YzYsRaFGVGnIuInzyMWTyZ3IT0oWdC0cxrAxdlgrInosR9d7fZeVle1jC34WuetB6gspykuuXUQ5Jyxbqbfw2qSJ4TqM0yTK5KkZ9f7rv5sNyyUJnsqg1s36SBXvRVzjDF59RFWqmTGkVEUEFTnUkGyG7i2uKxMJnAiILjRMPKBdPe/c2d2r+XDkx3cJgDDToMZJdoNAJ+hz2SUW5hbFl9oI46qSUkPBit1F/5yt3qfqvM1RsN6O4GfFJwHjmFmPxS/hfmqLravwNmZfVB9rNYMn0nrUjhhk0fJlAUYWiIkJqnmCA2AZ4pAvcEQCJ34ZAAj0HlEdzlZqhxIgGQkXoy9clU2fdyyVvMvr2bEDRkpzEI266t7eu8PhU3H5MTZZmeL2sn7bj/wW7zf6sZETurrJ3b6NQ4vHHsz1+VgYVxR5eRP3zMCz/m8isPiZc0FZgLz/0TeN/liBkZA2kPilWs2CHWYap6auwpLZX+YplljCRekwpsWt1hFEPzZLkYF5Z2Odzb2D5dnesqGP/CIkwlNuw3P+KNbO5CtWSm9YKzNU5KFWemLOlUhA8RT6vvmXlMizDUh6ZuyMh6ljEKlFg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(38100700002)(4326008)(316002)(6506007)(53546011)(8936002)(6486002)(6512007)(6666004)(478600001)(41300700001)(5660300002)(8676002)(6916009)(4001150100001)(2906002)(66556008)(66946007)(7416002)(54906003)(2616005)(83380400001)(86362001)(36756003)(66476007)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eU02a280b0hmZ1Z2Vzl6amZvakRCVGpOaFVxSXQ5eVZOeHVhcHFCbFZVODF3?=
 =?utf-8?B?eVd5ZWdCblErN3Z3bE03Q1hLVzNBYTdyU2U4U3BLWkZCbGU2TXh4K3dyRCt2?=
 =?utf-8?B?dTVwcGt5bkxOLzdsRHMwUy9oY0VOdWlMaHp2S0JhSTNTd0sraUtFOVBpOG0z?=
 =?utf-8?B?THZwRzkyNWw3UEJucGV2TWtyM2ZDRzNLRU4xZlUxWFpDTGdQa3VjYmFiR3Yr?=
 =?utf-8?B?YUVRSC9WTHdJcndhYm92RExWVkV4MXRWOVRzcHNCRmRReWVtK1VtandvdDZ1?=
 =?utf-8?B?elNvdEdzNE9rVXFVOE9qbG9VbVI4MUFaSGtHRUxnbWpWU0VuMTVaNStZaEtw?=
 =?utf-8?B?ZUxOc1Z4U1VtMHljcmhGOG04MDNoMUNWeVJKQmNRRk1wNmtENGk5NkExeUJa?=
 =?utf-8?B?Ly9YaUJ5bkZOS3JUUVFMV0JLTzlDNjNrQXVVTzQ3SXpPNVF6dE9xMk8venFz?=
 =?utf-8?B?QlphNEpkYmZXeVNuZnc4blRETXRnbUsyUEttcE43SWRyRy84SmdQdng3a3Yy?=
 =?utf-8?B?NzNJWk0wWExocmxoK0tiQ2lQVTNhVURFMEFIVmdaZlh1L0c5VXpwK1RDYlFs?=
 =?utf-8?B?ZFB1MzRmWFBzS2ZCUFlVYkRjQjlwbjlJVVFkcW9xakh1ekIwMjZxZDhESWhB?=
 =?utf-8?B?TXJhWDhIUFFSK1M5L0dEM2JMb0VnUXNmMkpXNVk3TXNTM1F6UmoreUhBKzI4?=
 =?utf-8?B?SXlPTVR2VHZKWmdaZGtyckNIdm44V1B1Mzl0NkcyNkc0MkhQNUkxSzdaZHZu?=
 =?utf-8?B?eDB1NVBObVBCZmNzT3RWOG40VFpNelZ5Q1BqU1VoVGlSUHpYODVPNUgvSTJI?=
 =?utf-8?B?dFBKdVhLeUh0QlpEZ20vNGo1Vk9Tc3lJeG5ZSzdpN05JZmFKZ1JuSUl6bEEv?=
 =?utf-8?B?T3FwNWp0UzlPL0VGSmNJOU1vMm1MMFo5Y0FRUW9KTDZIb2ZjT0NLZ1p5NE9I?=
 =?utf-8?B?VFlFTUs0bGp3RXM0QjNzY3ZXblo0a0FwTGtkSktHRndiaVFOdkpzQ1dZMGNW?=
 =?utf-8?B?MGxHK09sRVdBTWVJOFN2N2QvVVY3OVdlbGtqa0tFTnhyenNkZkpQQ2NFL1Fo?=
 =?utf-8?B?dHIyaklBbThDTnVNcjNNb1M0UHJ0UVNFWjNqZDJvbGZRcUgwTEY5Rkl6VWJq?=
 =?utf-8?B?L1F1S256Mmc5NFg2NHRUamV0Y1dVUk5OZ0phT1hjbzJBZ1cxM2NhalBicklx?=
 =?utf-8?B?UTFEMlZ6TVBYZjdTZXJWR2NKNDl2Zml2N1l3WUN5NllLTjdJVVpKeEx2SEcv?=
 =?utf-8?B?cmNDZ2tJUjlNWk15em1sYnRha1kxY2d2ckZHM3h4anFQMkNkR0dpV2duc2JP?=
 =?utf-8?B?QjNKVFo3cjRaS1NZL0tHK0ZKeUt2a3Q1MWZrTU1xakFialM1UmpxUEFTUHFV?=
 =?utf-8?B?RnRJVVdUQVp3QVF2ZllwcG8weDRlUHd2Y2ZiWm8wUHkzVDAxTjF4UjF6VkY0?=
 =?utf-8?B?TDVEOENIOFdpQXN3dTdaOTNnNDByUE5RRHlTc2VQNTFhYVA4bFUwVFJoQjh1?=
 =?utf-8?B?Y3paT28yL1BXT0hweFJCSEFSL1YwVGdJNHdXR09QRHJFRy9QbFNjd1o5NVli?=
 =?utf-8?B?VmdvZ2w4SmhyQXZuRkJnekx4cHE5OFBtbmRLQnJNQTI3VzB2MFN0MjFWQmxX?=
 =?utf-8?B?OFlydXZIOThJRnZZeHBNeEhFTWdJeDhNNGc4SXI2Z2xVZUFtZm43aFdkMm10?=
 =?utf-8?B?ZUJZTXpVVVVKQnlRY0REWXhSdGpXQS9iSk5TbVZYUjhIMkJuVHVmYlZPdk1r?=
 =?utf-8?B?a280NkhlWVl2dHBLQ1FWSW1FVlZ0NGFQZnNMOVNhOWkzak5sRk92R0t1OTlC?=
 =?utf-8?B?ajc3dTdUN0JZWmpPRmhKWVcvYVNoaTZXRHk5UVNFM21uWldSa3RCbFQ4N0FM?=
 =?utf-8?B?L0xTYnkxalZ2blNYcVFocHUyYUI3RS9FTUdDYXJ3VUVvL2NRZFNyV1c1VDlh?=
 =?utf-8?B?V0VoUk5mQ2RXeGFsMFFSbGdyYkFLR1BYanlVaVZrYTNXOEI4cmtWSmNrZHVH?=
 =?utf-8?B?bmNvQk9aakxCOVpiN3dJcmhnZUZJUk9FYWo0N25DTnpYalZZSURMZXgvYVB5?=
 =?utf-8?B?My9vSUhyNHlhRjFyTXByNnVLUDJObHMzbmlaL2t4dHFzTnRYMUxGRE1HSi8z?=
 =?utf-8?B?S3gzeDBOd2xyS2hOU1hLeVJLQ1FjcWhpeXUxZUxHSFFxTDJJbm0waHdaUXpY?=
 =?utf-8?Q?D/uqP5inyR3m2WplivX1HqM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RHE0eFNZRUlaSU53WnRxZW1udnZaZURwSFU1MnF3anNhNVY4ZFhtWlBzSTBx?=
 =?utf-8?B?ZzRuQjFIaHVnUTdkdElzRFZJcERrS1JJajlPY054Z2JWTTJEeUlmWjZhOCs1?=
 =?utf-8?B?N0w0eWwxa2JDQnQyRkdaL0xLQmNnS2FjNzMxZVlWMVRIZFIrZ2R5LzlScWpk?=
 =?utf-8?B?eDg1UVRHdy9NVlh5cTUxOEdIUlluUmVNQUpjT2cycWpLTGtkYTFMQ3g3Rkto?=
 =?utf-8?B?bzJHMWVxbEU3VVR2dXAyLzVMU1lIczVDZThnZG9mZk50SStneDRobnpmOFVk?=
 =?utf-8?B?ZDhJNHhDcnR6SWRBcVdTYndqODZNdTBYSURMQm9vV0FGT2V6ZDJOQmM4ZmU2?=
 =?utf-8?B?dWQwdkhxaTZSWnhjeXVienloYU9DVmI2R2FiOTN5VUFrQkd2bGRuSjJVQ3BG?=
 =?utf-8?B?U1FWL2htVTd0L2hJdGp0MjA0MjREM2tQaXVuRzg2bVNpUXFpRzFRZ2RJbzMy?=
 =?utf-8?B?T2djMDdaYjlDcW5OMXRhL1htVVh2dktnR0w5WXBYd3JnVzdiYyszSWFsQ2pr?=
 =?utf-8?B?MXVWR2x0cUZRMFFLaDZHVjRWK3ZFNjhkRlZTQkdTejdYSUZVK3h6MjVFZitG?=
 =?utf-8?B?OTJEN3lPck5uTkxvSGJhUTByc1V0QjdmU1oyZGh5V3hROEV5RXpXUmFVZmRD?=
 =?utf-8?B?Uzg5UEJJTlNKU09kRWNjRWQvKzY2YlJTdXkvSCtCYVZaWDUraThMNHEySlVk?=
 =?utf-8?B?UWNQN3grK1o1ZWlHRTVsMkFHckFkT1JkM3pXOUhZZTV1aVhYZEhXNG9YVGxC?=
 =?utf-8?B?WU1sOUtyZXNHR0pacG9sdEcxTUhLUk92cU9Iay9yb0I4RjNMQ1NCdHVYWFhz?=
 =?utf-8?B?Mi8yR0tDYzhPcmFwcDgzUFE5aEZmbk9zaU9yN2syc21mMm5FMWpUTnAzNEZN?=
 =?utf-8?B?bElyaDVKKy9SbFFUcU9qSERMOFR4ZktXYkxKTVMvWEozeXZ0ZEVhbExlM05X?=
 =?utf-8?B?Y1Y1MmJqZHdxd2FKSHJqK29nVlJscllWM2p0SWRrMGxQVUplaXZpS1c4VDZ2?=
 =?utf-8?B?cFRjRjMzMEo5bk9Sb0FJNlZjUEUxVVpFbllCbCsvRmZGblJBaEplaGtab2pk?=
 =?utf-8?B?ZWRRRFBJb1Z0SWQ4cHlvS2tHNWZpV055OHlSTTJwMy94ckprY2phejIrZWhP?=
 =?utf-8?B?NGM3ZFhaaEJJcHBRdnhaSmhmRTNKY094YVo0OUE4QmpjSis4QjdVNFdiaXI1?=
 =?utf-8?B?cHpaSHMvOFlnVmdYZGQ4eXpsYzJSK1FNN2pmaVZ6c0NuMDh4dkJpYXpSRGxU?=
 =?utf-8?Q?zt5TNwFKePRB+6b?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f080a97-fc2e-4be8-70ce-08dbcbfab793
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 14:43:08.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mHJUKO6eUBp8KJmrLKM9mmGGxBLeQz8EtQP1PshBbPKC3RHunFlYEisL/RXe0PfHpaiZKuuu/fx60wQyIZ3f4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310130124
X-Proofpoint-GUID: Iou7WCfG6DVRmoxV-8VkvCxFo_Cj0zMe
X-Proofpoint-ORIG-GUID: Iou7WCfG6DVRmoxV-8VkvCxFo_Cj0zMe
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 13/10/2023 15:17, Arnaldo Carvalho de Melo wrote:
> Em Thu, Oct 12, 2023 at 01:35:41PM +0100, Alan Maguire escreveu:
>> On 11/10/2023 23:14, Eduard Zingerman wrote:
>>> On Wed, 2023-10-11 at 23:05 +0100, Alan Maguire wrote:
>>> [...]
>>>>>>> I'm not sure I understand the logic behind "skip" features.
>>>>>>> Take `decl_tag` for example:
>>>>>>> - by default conf_load->skip_encoding_btf_decl_tag is 0;
>>>>>>> - if `--btf_features=decl_tag` is passed it is still 0 because of the
>>>>>>>   `skip ? false : true` logic.
>>>>>>>
>>>>>>> If there is no way to change "skip" features why listing these at all?
>>>>>>>
>>>>>> You're right; in the case of a skip feature, I think we need the
>>>>>> following behaviour
>>>>>>
>>>>>> 1. we skip the encoding by default (so the equivalent of
>>>>>> --skip_encoding_btf_decl_tag, setting skip_encoding_btf_decl_tag
>>>>>> to true
>>>>>>
>>>>>> 2. if the user however specifies the logical inversion of the skip
>>>>>> feature in --btf_features (in this case "decl_tag" - or "all")
>>>>>> skip_encoding_btf_decl_tag is set to false.
>>>>>>
>>>>>> So in my code we had 2 above but not 1. If both were in place I think
>>>>>> we'd have the right set of behaviours. Does that sound right?
>>>>>
>>>>> You mean when --features=? is specified we default to
>>>>> conf_load->skip_encoding_btf_decl_tag = true, and set it to false only
>>>>> if "all" or "decl_tag" is listed in features, right?
>>>>>
>>>>
>>>> Yep. Here's the comment I was thinking of adding for the next version,
>>>> hopefully it clarifies this all a bit more than the original.
>>>>
>>>> +/* --btf_features=feature1[,feature2,..] allows us to specify
>>>> + * a list of requested BTF features or "all" to enable all features.
>>>> + * These are translated into the appropriate conf_load values via
>>>> + * struct btf_feature which specifies the associated conf_load
>>>> + * boolean field and whether its default (representing the feature being
>>>> + * off) is false or true.
>>>> + *
>>>> + * btf_features is for opting _into_ features so for a case like
>>>> + * conf_load->btf_gen_floats, the translation is simple; the presence
>>>> + * of the "float" feature in --btf_features sets conf_load->btf_gen_floats
>>>> + * to true.
>>>> + *
>>>> + * The more confusing case is for features that are enabled unless
>>>> + * skipping them is specified; for example
>>>> + * conf_load->skip_encoding_btf_type_tag.  By default - to support
>>>> + * the opt-in model of only enabling features the user asks for -
>>>> + * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
>>>> + * type_tags) and it is only set to false if --btf_features contains
>>>> + * the "type_tag" feature.
>>>> + *
>>>> + * So from the user perspective, all features specified via
>>>> + * --btf_features are enabled, and if a feature is not specified,
>>>> + * it is disabled.
>>>>   */
>>>
>>> Sounds reasonable. Maybe also add a line saying that
>>> skip_encoding_btf_decl_tag defaults to false if --btf_features is not
>>> specified to remain backwards compatible?
>>>
>>
>> good idea, will do! Thanks!
> 
> I have to catch up with all the comments on this thread, but does this
> mean you're respinning the series now?
>

Yep, I'm respinning now. There were a few small things in Andrii's
suggestions that we might need to figure out - mostly around names - but
there's enough change since the RFC that it would probably be best to
discuss those with the v2 series. Thanks!

Alan
> - Arnaldo
> 

