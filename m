Return-Path: <bpf+bounces-10392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427287A68EB
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2312816F7
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 16:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9FD3CF22;
	Tue, 19 Sep 2023 16:30:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626A347CC
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 16:30:42 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC4FAB
	for <bpf@vger.kernel.org>; Tue, 19 Sep 2023 09:30:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JFxGfq012388;
	Tue, 19 Sep 2023 16:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=uGIZbyhI+1mRbCVz9Qrr6583vaYKdlX/CjvY2KHLYkg=;
 b=KHXC0Zmk5r7QOWFKXJeDf+gTSzAsItAZLtgkurGeOBm6HCBp+OGzqb0KxBM24pyLO7VD
 A6S0M1VmWcNxQsspU9wQH0LF9gjuASda3bzmbPb4Ky2aXMeUPErx3+sWe9p0F3PR2hx3
 IZbkcWzZhWCp5ciRoennUu+w2dBrygO2hpdhZtnuOK/CVZycDfgbukB4+Obz83q+SFPV
 PezgIEBlJGpog/OGkUAn8wdA0WpOPQHfK2qCAt1Og1/VGRzb+XEX0zCAKBqyX4wkg4gX
 ASJsYLgqtoLlkROXoxYHCSfq3BJTeP6HIzFdCuVqQvFA+sIx0S30dlK6cvp0WVzQjmxJ 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu5anq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 16:30:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JGRM6h012290;
	Tue, 19 Sep 2023 16:30:20 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t65mpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Sep 2023 16:30:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqKMJk8sF8dHjuVXBzfH6lYSHWHFz+RCY6NphIQXabS2UCdoeVMwvOvgv7Z5XW94YtXFqYVQt8C2eWrlpof1onRosr4L7KUyxKA3H/MbO4omzTB793tmCSzvashtcnPPQbFn1bYGxKdWKmoQYpz3+Ol6PbO1Z9DE6MKEUj86FSY96hjf8T7lq0/xAx920opkUgb199wcW+4O9/DHd4hg5VZGrpA8OzCvG2bwlPJZiYgbZ7SZZNZb7DlWKrOBvnP16njM08rNnIj7h0vVhsj3sA9MLYutk8OYui4LmJ4rbQHQBWu78VXtKm3g78oyvA4n0dZNUw7PVeMBIMh9iSPRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGIZbyhI+1mRbCVz9Qrr6583vaYKdlX/CjvY2KHLYkg=;
 b=K2VnLo5hlydU0zP0vflZZgX+4T6oLwGGOxEGU+PXA60Rqd8/sT5pYX0wYnUZsdNgwNpkLLhyPcZCkm4PvGxddbYcXhmia4YXKbYtp72YPjaUnJXBlVSTUF4leARohQoNDK33IyoJ4aaXoEXG1U45arQWfEU92A5v7fSy1/LXACuQOy0VVyfnOTTDqbUW+I6Yo2ghHt3hg4mvcIoqqGBxafESzc/ajYxGAPzpenI4l6zfGyXYLSVSF76Zu5ZyZeZek2AranBbqi7+Izyg537p46osAuPEf/m3z72OttSSZke0H37PO3jjazFw7YXDp+8OZ73AwhUeeN4pyBA6CPu0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGIZbyhI+1mRbCVz9Qrr6583vaYKdlX/CjvY2KHLYkg=;
 b=vN5/O05tGHf2QfnTMVOV2C1uHmwbDFpUq+js9ZUNrL7ug3qKM0MK9s/F7WkvflUqKfemNRlYW+le80/uJpDOgJsUbV0nb+Omcm7bMnKWXUYDrt8dJ3aPJHOobIwoohJ+UMLTLt9Vy33+Tj8wBx4Xok6RZ0thTkS08HnJllN/Ok0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN0PR10MB4870.namprd10.prod.outlook.com (2603:10b6:408:12a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Tue, 19 Sep
 2023 16:30:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::6efb:19f3:767c:1e23%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 16:30:15 +0000
Message-ID: <7e941212-7a2e-5878-6396-cdc6ec39d8be@oracle.com>
Date: Tue, 19 Sep 2023 17:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves 0/3] dwarves: detect BTF kinds supported by kernel
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
        eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230913142646.190047-1-alan.maguire@oracle.com>
 <CAEf4BzayTrNnOLj4t2s1aegATjqMdvz1iiGq4A6gMmbxJ+zmYg@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzayTrNnOLj4t2s1aegATjqMdvz1iiGq4A6gMmbxJ+zmYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0563.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|BN0PR10MB4870:EE_
X-MS-Office365-Filtering-Correlation-Id: c27dcc32-2293-49be-8f37-08dbb92db45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CFQclRqw/Kc8jGgU1IMQHF1AqAujrbyhgAqQqYplKbXOfwDafku8m7ornKz9fGKsuvuMFnL/NylBFMdj1NtTfzzWnLtEpoNmB1JT6MmbnvNLXj1suQBaw5RtD5nG8KV69aVn8JMkUjPWgw51fL+5r5H5vqDPUU78h5lIGK+ABE/I7JmZXlZ8W+r4mA0JMfxkHZrEagHQVX09LxVtacboAQo+P4/tJmfowv7NQt7Lfc+tHJH3OPsYn/IvkBgC9JqQXjMCS/n8JNYgkOj2Ycz6ysXmRcg9GfAEv4nHTF87A6VCaUiDxZo+ZeSgXbzLMr4ZsvucFrQaQ6L8U94o8enf35P4ljWU/+U9I3aRdtuUD0Jr+z6WqXtUFlg+qggN96wGKjptK6Vba08Qb/z62P1xLRofl9vov6T62CE1Jmf3YPBdLH8PC2j0erSpm5Hn38IPFCs1jBRX3KOwlFSx1FWZokQfr6cObdCmmbSODNw9OfRx6+UcF9zlC289fcsPEB+0DxXmxASmbbD9z7hlEo+ngVeSOae1JH7xNR/1hPyYYOZqOq3QH+w+cbNOApjMVtaO3OiENUiV1RvGG3XoK56+Z7dqBEOSFa/SAjWYSwHlUtGTbXmppUY09aKq5RnT8UP2G0IobO6Uf+obP2BcantRsdTbrcE7M4SEhYCubEy8nrBRmx48QGxgyxwq8+8/C9oZ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(346002)(396003)(186009)(1800799009)(451199024)(53546011)(6666004)(6506007)(6486002)(966005)(6512007)(478600001)(83380400001)(2616005)(2906002)(44832011)(66556008)(66946007)(66476007)(316002)(6916009)(5660300002)(4326008)(8676002)(41300700001)(8936002)(7416002)(86362001)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WGtmbGhpOHcydUVTSndhMW1oZzNzS2U3amJKRmpSclNGWWNYdVNTdEZ2QnVk?=
 =?utf-8?B?K2Z3SDliTEF6ajVaeDdCR1d5c2JUdE5TcFpzeFV2VXZ6MzBOc0ZrbWhvYURm?=
 =?utf-8?B?V1NYS2pQRjRkMkZJemdVWDFveHpHcm5BYTVKTEQ3N3MvOWUwU1BBYjJ0RWhZ?=
 =?utf-8?B?Y3YveHZXeUJ2R01FRm1mOGQ3RkVWYzVqQTZycVVIVmMrcU9UYmJka3p4WDBV?=
 =?utf-8?B?ZXJ3YnR6L0ErdHVvRmFFV0ptdTNsb1dQcFZKZ0JDTUczTnBMYzQydFU3TEFW?=
 =?utf-8?B?cHVCeCt3SUoxN244MTF0NGs3UTlEdXhPYXlGQmFzRzRHUjJ3Yno1eFJYb0g5?=
 =?utf-8?B?UUxkRElKNGRFQzJMTUVaZDBOeVo5bHNta3FJVnpwNFFkbjJZMlozQ2xjSkpT?=
 =?utf-8?B?UUhTVThjYkcxelpKQzB5V3B1aDFBU3lYYXgxSTl1L0R5ZFVndUFvU3dUTzRE?=
 =?utf-8?B?UlpNdzI2dmdYWjEwTmdCVGxMMFdnRU51M2xJbnRaZVl5MnE4UjFINE5pZVk5?=
 =?utf-8?B?TWUyS1lFQ0tGbnZnRXhWUnhEcnJ5SVNUbUhGZC9zRkxETlpHKytON2FsaEdS?=
 =?utf-8?B?SVY2ZWpyS1hEWUJuZlk3U2paamQwcjN5cmNENVJRZjFiUElvbzA5VFpFcElx?=
 =?utf-8?B?Tm5SRS9jcHR0VktpOHRJZVJuZjJLSDY5cE1FdEVwb0M2QlJ1TnE3dXE2OHRY?=
 =?utf-8?B?SUlsdW5Ma1pmWVptR3k3QWo0S1lKQ1lDN0RNNTZ5NXY3MkUyWDZPQ1lWb0dy?=
 =?utf-8?B?dERuR2dXM04wSEdyZlA3UCt4ZFJoZmFvZTNVcStDelQvNXJGN3EyQkxsbHlx?=
 =?utf-8?B?dzBLNC9LS3J1YXVBbjVybGsxTzB6bDNQUUFKRzRxOG9iQ1I1WVVSUUtQbzJr?=
 =?utf-8?B?b3N5WnhHQU55MkZZNjhadHlFTWRDRWN1WU5vRG5LWWQ4cTN0SzhzcExhNzho?=
 =?utf-8?B?ckpLTVFIeVVSQUNLY1dxNEs1YTlQb0gxVVlXMjJ2UnZJc1laV0pEUHdLLzND?=
 =?utf-8?B?S0RGbHN2NU5GSHQ3QWE0T0tsbmR0a0JYVmZlZHNvYjl4ODIyTDVENnlxK2E3?=
 =?utf-8?B?eDBsK0FDam92c0tObC92Qnl6OTV1RGcvQnJkS053YTVSV0MxRTlKNXRuMjFz?=
 =?utf-8?B?Y0JKQXpzRnVTN0RmQTZNSHZScm9tcHZTclA4eGUySVBSZXpLeEZ6aTdUeEs1?=
 =?utf-8?B?YmhiV2N1YXczR3pRaEhSN0RsaWpmd1RuVXNGVi94ay9HT0YrRWhoUmNJZHE0?=
 =?utf-8?B?TGx6b0c2Z3RGM1hncEc3NVBqeDhydGwwaTQzR2ZiNzBldDB6cFpHbUQxUGN0?=
 =?utf-8?B?cHI5SVZwR1liUTJvQTdLRVlsT2xvODhNTThPaThWallGaUJxbkFaazlzWGt5?=
 =?utf-8?B?RjgwZDdxMUJGakdsQUY0SEdEYy9yblV2UFRRSlFTcHhYV2lieVNWazBPSzlO?=
 =?utf-8?B?dGRHSHlVa1lGcWFQY0xqVnNXeXdQa2kySGtBQVNmWTE3R2IrZnNOLzlQQ3Uv?=
 =?utf-8?B?QmxRQW9QVENUa1lJNXpzU2QySlhpOVJMYld1VEIreloyT0tNZXJEUFZGNnIv?=
 =?utf-8?B?YjhOQzZDSTNqMEsyYlM0Q1R3OStZTEpPZU1NdWxXRmIzVGlDeGVBdk90OGFl?=
 =?utf-8?B?S01CTy9FVDRqL1QwdE0xcUxPTytmMXNrMjFVZE9kcE5SSHZ3Y2JISG0wbDNV?=
 =?utf-8?B?S0I4alZxbUY0WE52VENtbWxpKzQwRWJ5ekgzbG83YU9XNVNWZHdqQ1NOTWlB?=
 =?utf-8?B?cy95S3pkSUJiaWJ0RlZVQm9DZzFDbkxEV2dBczRWeStjYjU5TzM1QWU1VlE2?=
 =?utf-8?B?N3p0OXROV1FnWGVBd0JweGdiakpxcnNUK3hya3ovWVZPR2tlNUVyNkJmeUZo?=
 =?utf-8?B?QlhvUld4ajRITUJrZXhwL1JWYTdNNUMyellxdE1UZ0lnd2VVWkpTcks1ZktI?=
 =?utf-8?B?bHpscngyZGhMUC80V0M0WHpMWG0ySDJnTERzOU9uUDFQVyt1UHc1Uy91Wm8y?=
 =?utf-8?B?TzMzQkNRbGNtU1RldkJMdUcxcmx3ZjM4UldrdDdReStOQ0hQMk9zQTJhaExO?=
 =?utf-8?B?TWcvTmZ5RkJLUHd2Y3Jyc05hbTU4RC9IMzN5c0dQOStLMkhvYlQzTlMwLzky?=
 =?utf-8?B?R1JvYVlyNWhNUGpaaCtYK0FvSExaUkcxR0gyRjlyZkZxK3hNbTJIRVlBTXY2?=
 =?utf-8?Q?mNgEzGxLuJGoWSkPggNRMiA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?dlZRNTJnNjdUaTExSzllZk9Ua2ZVemJ5Rk9ZVzd0MlVPSngzNUNzbWZFNXdM?=
 =?utf-8?B?VkFBcXE2Z2FnSDJrMmsrYzZkTjhBSkF4YlJXdWt5N1lJUUw4MjFqM01UUXlz?=
 =?utf-8?B?Vk9OU1l5bE4vc1ZYT3hWNitHOWx3VTFqMThZSEZOTUl1b3VGT3lRNGxWMSty?=
 =?utf-8?B?bndIQlBHdDljdCtleTVlQWY0WmxiNlgzU3FhVVBCUkJSaXEySFg5aU8xRmJu?=
 =?utf-8?B?Z3pLbEsyWE9FU0o0Y09IU0hBeUpCcFNJMlFJZmFBM1EyMCtpdUU2OVNvclN4?=
 =?utf-8?B?ZUVCMUlpOXVYekF1RnErV25QNnVrYXgwcmtrMlhIaW5Uem5RV1ZNMmVRT0NX?=
 =?utf-8?B?MFoxbURSQjVGejVtcXZXSmR4UnNxZW5ldHc5NHAxcnh5VHEwMWtEUm00SWwr?=
 =?utf-8?B?K2pEakJFR2V6QVZtZFFoWVBIc0tsQXBrRU94MnJ3c1NxNG1EeFhpMzM4RFR3?=
 =?utf-8?B?UmhQWU5NZEJrK0NYQ2IyZ2plS0FhL0h2VC81M29DOFVVODRUQkdNdnBrbTJh?=
 =?utf-8?B?Qm1yVWM5QXgzR1lWaFdXTlNKcXpoK3hnc0pMT3RPVUordk5QaTk5NzhUSHBQ?=
 =?utf-8?B?V2lONVpCNkgxVHVtbTRGbitZS2pwd0tMcEtDUTlJQm1vanJNQS9SMmdpa1U5?=
 =?utf-8?B?MDBIeWxKZTkxeHBRQmZ0TUZPR1dMaGsrQytzNmdzMXM5TjhoTWJ1SzAvODBZ?=
 =?utf-8?B?VzJZOEhOK2xJQlVwbnNEcndTMXNZZC9nQjI3TkhIRU0wa0dya3V3aWVrRHpZ?=
 =?utf-8?B?LzZoNEZrQitqcGNwakxpSjU4VW83QnIweVZraFVoUlFPRlNhNVM5NzZKYXFT?=
 =?utf-8?B?TzJuOEZEcFFTZUJ3RTgvNkI3OTNXN04vREY1SmVrSTNscFZXRUNxcWFqQ2dX?=
 =?utf-8?B?aGVuSGtzZVI4Mm8vWTR2WGJCbzVOQkxSVU4xd3l6bGJUYUlkR2NhM2NTODdm?=
 =?utf-8?B?QlRRbDFWQ1ordVYwVE4rT1B2Vzd5ZURDNjR3M2VBV2NybXZIZzZFNDVOMjQ5?=
 =?utf-8?B?R3plRVZSOThaM0xvVUlnTDZvTElBSlhSYS9XMlJTR0lnSWZTdDRhZnZVbytr?=
 =?utf-8?B?aE9HRmdzME0xc3gxcGJYc1poQWZMU3hLc1J3SlF5TXE5K1lsUk1wTlVDUUZG?=
 =?utf-8?B?THVmNWJJY2NiaUJDRHFsNElYeElwWnFNQkZucmdQL1pDbDlvTlRLdFZwUnU3?=
 =?utf-8?B?eHdNVUh5N0lMSElIMDk4aURoQ3Fvak4yQVZsWnVScmdSUGxuVlBZcDVON2do?=
 =?utf-8?Q?magB7ieD8LqF17Z?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c27dcc32-2293-49be-8f37-08dbb92db45d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 16:30:15.8418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bXb7BgeBo6fTDboXxElYc/DNZn40ZjJFcrQfquK4HLaRXH2oolJ6y1PZDPlc96OYH4nT2j38QGG/duQ08DiJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_07,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309190142
X-Proofpoint-GUID: Os5YJyrTTNFKH4t9O3cSYe86FJrdTKeA
X-Proofpoint-ORIG-GUID: Os5YJyrTTNFKH4t9O3cSYe86FJrdTKeA
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 14/09/2023 18:58, Andrii Nakryiko wrote:
> On Wed, Sep 13, 2023 at 7:26 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> When a newer pahole is run on an older kernel, it often knows about BTF
>> kinds that the kernel does not support, and adds them to the BTF
>> representation.  This is a problem because the BTF generated is then
>> embedded in the kernel image.  When it is later read - possibly by
>> a different older toolchain or by the kernel directly - it is not usable.
>>
>> The scripts/pahole-flags.sh script enumerates the various pahole options
>> available associated with various versions of pahole, but in the case
>> of an older kernel is the set of BTF kinds the _kernel_ can handle that
>> is of more importance.
>>
>> Because recent features such as BTF_KIND_ENUM64 are added by default
>> (and only skipped if --skip_encoding_btf_* is set), BTF will be
>> created with these newer kinds that the older kernel cannot read.
>> This can be (and has been) fixed by stable-backporting --skip options,
>> but this is cumbersome and would have to be done every time a new BTF kind
>> is introduced.
>>
> 
> Yes, this is indeed the problem, but I don't think any sort of auto
> detection by pahole itself of what is the BTF_KIND_MAX is the best
> solution. Sometimes new features are added to existing kinds (like
> kflag usage, etc), and that will still break even with "auto
> detection".
> 
> I think the solution is to design pahole behavior in such a way that
> it allows full control for old kernels to specify which BTF features
> are expected to be generated, while also allowing to default to all
> the latest and greatest BTF features by default for any other
> application.
> 
> So, how about something like the following. By default, pahole
> generates all the BTF features it knows about. But we add a new flag
> that says to stay conservative and only generate a specified subset of
> BTF features. E.g.:
> 
> 1) `pahole -J <eLF.o>`  will generate everything
> 
> 2) `pahole -J <elf.o> --btf_feature=basic` will generate only the very
> basic stuff (we can decide what constitutes basic, we can go all the
> way to before we added variables, or can pick any random state after
> that)
> 
> 3) `pahole -J <elf.o> --btf_feature=basic --btf_feature=enum64
> --btf_feature=fancy_funcs` will generate only requested bits.
> 
> We can have --btf_feature=all as a convenience as well, but kernel
> scripts won't use it.
> 
> From the very beginning, pahole should not fail with a feature name
> that it doesn't recognize, though (maybe emit a warning, don't know).
> So that kernel-side scripts can be simpler: when kernel starts to
> recognize some new BTF functionality, we just unconditionally add
> another `--btf_feature=<something>`. And that works starting from the
> first pahole version that supports this `--btf_feature` flag.
>

The idea of a BTF feature flag set - not restricted to BTF kinds -
is a good one. I think it should be in the UAPI also though
as "enum btf_features". A set of bitmask values - probably closely
mirroring the FEAT_BTF* . Something like this perhaps:

enum btf_features {
	BTF_FEATURE_BASIC	=	0x1,	/* _FUNC, _FUNC_PROTO */
	BTF_FEATURE_DATASEC 	=	0x2,	/* _VAR, _DATASEC */

..etc. A bitmask value would also be amenable to inclusion in
an updated struct btf_header.

So at BTF encoding time - if we support the newer header - we could
add the feature set supported by the BTF encoding along with CRCs.
That would be useful for tools - for example if bpftool encounters
features it doesn't support in BTF it is trying to parse, it can
complain upfront. Ditto for libbpf.

With respect to the kind layout support, it probably isn't worth it.
It would be a tax on every BTF encoding, and it only helps with
parsing - as opposed to using - newer BTF features. As long as
we can guarantee that a kernel doesn't wind up with BTF features
it doesn't support in vmlinux/module BTF, I think that's enough.

Alan

> 
> All this cleverness in trying to guess what kernel supports and what
> not (without actually running the kernel and feature-testing) will
> just come biting us later on. This never works reliably.
> 
> 
>> So this series attempts to detect the BTF kinds supported by the
>> kernel/modules so that this can inform BTF encoding for older
>> kernels.  We look for BTF_KIND_MAX - either as an enumerated value
>> in vmlinux DWARF (patch 1) or as an enumerated value in base vmlinux
>> BTF (patch 3).  Knowing this prior to encoding BTF allows us to specify
>> skip_encoding options to avoid having BTF with kinds the kernel itself
>> will not understand.
>>
>> The aim is to minimize pain for older stable kernels when new BTF
>> kinds are introduced.  Kind encoding [1] can solve the parsing problem
>> with BTF, but this approach is intended to ensure generated BTF is
>> usable when newer pahole runs on older kernels.
>>
>> This approach requires BTF kinds to be defined via an enumerated type,
>> which happened for 5.16 and later.  Older kernels than this used #defines
>> so the approach will only work for 5.16 stable kernels and later currently.
>>
>> With this change in hand, adding new BTF kinds becomes a bit simpler,
>> at least for the user of pahole.  All that needs to be done is to add
>> internal "skip_new_kind" booleans to struct conf_load and set them
>> in dwarves__set_btf_kind_max() if the detected maximum kind is less
>> than the kind in question - in other words, if the kernel does not know
>> about that kind.  In that case, we will not use it in encoding.
>>
>> The approach was tested on Linux 5.16 as released, i.e. prior to the
>> backports adding --skip_encoding logic, and the BTF generated did not
>> contain kinds > BTF_KIND_MAX for the kernel (corresponding to
>> BTF_KIND_DECL_TAG in that case).
>>
>> Changes since RFC [2]:
>>  - added --skip_autodetect_btf_kind_max to disable kind autodetection
>>    (Jiri, patch 2)
>>
>> [1] https://lore.kernel.org/bpf/20230616171728.530116-1-alan.maguire@oracle.com/
>> [2] https://lore.kernel.org/bpf/20230720201443.224040-1-alan.maguire@oracle.com/
>>
>> Alan Maguire (3):
>>   dwarves: auto-detect maximum kind supported by vmlinux
>>   pahole: add --skip_autodetect_btf_kind_max to disable kind autodetect
>>   btf_encoder: learn BTF_KIND_MAX value from base BTF when generating
>>     split BTF
>>
>>  btf_encoder.c      | 37 +++++++++++++++++++++++++++++++++
>>  btf_encoder.h      |  2 ++
>>  dwarf_loader.c     | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>>  dwarves.h          |  3 +++
>>  man-pages/pahole.1 |  4 ++++
>>  pahole.c           | 10 +++++++++
>>  6 files changed, 108 insertions(+)
>>
>> --
>> 2.39.3
>>
> 

