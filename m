Return-Path: <bpf+bounces-15691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671527F4FB8
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 19:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C8FB20DCB
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B42F5B20D;
	Wed, 22 Nov 2023 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8PrMZVE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kEunJZWc"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0452A271F
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 10:38:20 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMI23IH005851;
	Wed, 22 Nov 2023 18:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=YO3KiMwMRGZmlkvXG79mOw3JOf4lY/k/RHN424ie7QQ=;
 b=T8PrMZVE8Vc938ZfinvWD4PfN2xJ17ck66bAAkgOD85i/gW9SoDTzFo2h41+XkAOOCla
 67PphSToY4E8hjybYWpdAFdEwjrZpfJ/QbUNEL0WB8jFof4pf+qZBGYANF7EhUtV6C7v
 3NIyBsJcGiHarHqCbrQbJNiPlWUO0aoWAQcMiUJZWsfczmWBcVdPWBamvTObUz0wz2Dz
 22RMZy739QSvqaAG5O47ruC9ERBbJ6VEMTHkCPmu1RCYJMUfQmhUH0HGF9q786d6tfx8
 7usrg6CeNU+vXWo6siPQqZGAdKfeqqu155XgJeCLPVMQlcIKZwSLa7DeVp2a4+rvgHug 7g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uem6cg8kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 18:37:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMHZ0ot023566;
	Wed, 22 Nov 2023 18:37:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq95g3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 18:37:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYkatx54agg0YLjYUg5IXxpBYZ/KrhxgrHc0/XvxDULxazIhd2jEoaeoDcIz2F739vXxGNpD+8q8RstKPvyOwy+ZcRAt9CM1fva1A5N0zA56hOGEZpslXvQO+4cI6Z8VHyJpY0HsscyBdXOLVVpnRo64YYQ7+dwQ2YVPo0pynYjvgpguq/dEU8cj9KOjEaepX1bLmL1oQcfWWd4MsoVOQRzbDJvCiz8+ixwfCRmF5pk136Qs0+0p/40l3wzq+cIwMYhQuv78NfoAr06zVDLveKpZMKPPT7mriwkt7LqpskhNJuvjD/ZQxiX0Twl3DgdCHR7dqg/pDZCbs6MOY9dzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO3KiMwMRGZmlkvXG79mOw3JOf4lY/k/RHN424ie7QQ=;
 b=UVwbSWLIfOUHitP2edlJSLiXLb75l0mm2pC0bdkpDZ/f7/AIPaPoNZ5HNN32VDEib5QoyQeqggUO74HGXdbopJKw1UHcdFn1cJCErHKKCgwH3L2eTxn2y8+LOivGuUXmgQZjJINqacDACPKcoLq1C+EkKjJXkn41NUmhOpR8FFHk3VI7o2xexb+TV9DH+hdd8yumUHFSk2ponsA/E+5uuFCcMIo36yDj4xq5a0EbcNJ4cU4eHooejvuV3UXgUtdHIn4vC2vu0bdrtT7IdAGwfWEuU1UazilbK6/EsWs6X+deWTQFzBZ03B1BBCL+hy2imnd7iOPku9cQ2Jw6a0CguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO3KiMwMRGZmlkvXG79mOw3JOf4lY/k/RHN424ie7QQ=;
 b=kEunJZWcff9eVkqiTQY0kit1F2xqWlWRtVLhAnj9ikCtY8d1bYO6wm8osAjk85OAFfxqgRqsYtiwMnPzRGbCCuIkFWvLhbibdyqlddHXRv2TExsK9oXjaIZ4alkBUqTJVZAynKASHI5uXWvzjPtDPvCQQei/bA1Ajtwzh8IuOYc=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH0PR10MB5193.namprd10.prod.outlook.com (2603:10b6:610:c4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 18:37:48 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c%5]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 18:37:48 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>,
        Tao Lyu <tao.lyu@epfl.ch>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei
 Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>, Hao Luo <haoluo@google.com>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, mathias.payer@nebelwelt.net,
        meng.xu.cs@uwaterloo.ca, sanidhya.kashyap@epfl.ch,
        Song Liu
 <song@kernel.org>
Subject: Re: [PATCH] C inlined assembly for reproducing max<min
In-Reply-To: <CAADnVQJqmpSoABqd-dCQBU2ExiPda1mHz2pKHv2jzpSMYFMeqQ@mail.gmail.com>
	(Alexei Starovoitov's message of "Wed, 22 Nov 2023 10:15:55 -0800")
References: <d3a518de-ada3-45e8-be3e-df942c2208b5@linux.dev>
	<20231122144018.4047232-1-tao.lyu@epfl.ch>
	<2e8a1584-a289-4b2e-800c-8b463e734bcb@linux.dev>
	<CAADnVQJqmpSoABqd-dCQBU2ExiPda1mHz2pKHv2jzpSMYFMeqQ@mail.gmail.com>
Date: Wed, 22 Nov 2023 19:37:44 +0100
Message-ID: <874jhdk51j.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH0PR10MB5193:EE_
X-MS-Office365-Filtering-Correlation-Id: 979ca927-61ea-4196-2311-08dbeb8a205a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eznoCDsIqQvCnPCUHS3w/ImNxaBtnUgCfIOcqGq8H3V7Eijsz0KO9AWuONLWEN4i66QJZJaeDT4c00rpXPJ+p91EfmLmPcymSIgZDhyGOcUYheCDj9Jh4JNy1CbDnTKST7ge9xwF7YT1PluA+G/y7MURkHS99orc8niANAdm3+C0fmXSRJy8PgjApJOVTYg2lEEPOuUpW5j/CUXxXP1/xmYPq9rDwxgrEl3B61IXcur4fR52sFnrfHHpJWQdoEEaQ9eHWZEPKDmPzbx1h6l8BP/ZIJqEea+Ska2fm0Bw2FtitBXhereoX3pbriTERXrc96u8QZVucsM7G2aibCssM+u6WcA/E4YfwrfrMCzpQFQQa/tu2rTUWXZFSpMKt2G4M4hHQYDVT1xDX58U3uHy1n7VZsyJ+fQ35xIspWm8fensBUXujIfiiR3YgxTtHXdzbKsCXRovNSk+lhaywGjIjp4AN5VNVpAQoM7Oxzb4/TNwy5+2pWyVkQTDhL6tAW2j+saw+zrpL52upX9dcifKeX74zw0IMIaVy7cwujiidIs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(41300700001)(478600001)(966005)(6486002)(6916009)(86362001)(26005)(36756003)(316002)(7416002)(53546011)(66476007)(66946007)(54906003)(5660300002)(2616005)(6506007)(66556008)(2906002)(4326008)(8936002)(8676002)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGxWb3ZqczJYUmdzOE5NSXB5ZSt4dHFVQVU5WWFBRm1CRXRXOGFCVjE2S05W?=
 =?utf-8?B?UytYZjg2aHBBRWdsbURrZkZWL2kwYWJmck9iUFRRUVVUUUt4RDNmS1l4QlVS?=
 =?utf-8?B?NUpEcUpkQyt3S3ZNTmR4Y2NrRjA4aW1Cc2twUDFJcHNvaTIrZWJUZlZ1MEJu?=
 =?utf-8?B?amFZUE03L1JpNzhqTWxFSWJtYU93bkxHRkp4b0dBVlBIRWZhSjB6VHVtcEZN?=
 =?utf-8?B?MTNodXVOTTFma08wS0hMTndyWU5PaFl4eDFUeW9xSXArVzJrbjVXZXB4d3hH?=
 =?utf-8?B?ZWtkUzNoTHc0S1MyTktGVG9LUjFFem1lOWhIeXJaUW15bm5ISmh3TTgxeTVJ?=
 =?utf-8?B?VGhseW5yMkVKNGlMcHkrL1BONkd1OWlWcm93K0VicFl2WUlMakw2ZDdSa044?=
 =?utf-8?B?TWZGTFBPNEpoRDNnb3FpQTQyVVhwWjAwbWVGZS9MMVEyUDZueGUvMTlXU2Mz?=
 =?utf-8?B?VXNPUnRlamRZa0toTCt5WGw2S09ReDhobXl4WkY3RTRvWk93b1lDMW9weHY1?=
 =?utf-8?B?RmFzMmRRc2t2UmxBN212WGNuc3MzTml1M05oWlYrRlEvenpqR1cydVM2VTNa?=
 =?utf-8?B?Slc3c2VHclQ4blZ0Mjd1c2JRbEJjQXJMNmtaNFRiWVBSdTZIL2ZNekxyTmpo?=
 =?utf-8?B?WFdMb0lLdFBrYUZ5YXoyYTlGWC9ORnoxc1prVmRiYVhMZ1hxN052WHQzVlZx?=
 =?utf-8?B?T2pKSnY4ZVV1VExaV3RLcWtFNWRXQ2NPd2lsY29zdmxONnNwNWoxTUp6YzlF?=
 =?utf-8?B?M0MraTJPZUV2WUZleWJMVExmWWlWaDBHbzhxZlZUc2lTR1NlTkdsSStSWkU4?=
 =?utf-8?B?WkdHUjFBcDEzOTlSWjR1cC8yUWRBeGpTSkZYOTQwdWs5dFZWT041NjJ5clJx?=
 =?utf-8?B?clVDd2NvenRMN2c2RVJNK0M3SVUweWlZSkxiL3VWNk5zTDhoKzBLZ2psNUF2?=
 =?utf-8?B?a3VwRWZ3RTFPSG13blg5b0ZhT2tza0hmYkpEYVJ2ZWxLRm5HeTdqRmJNc0gy?=
 =?utf-8?B?ZGNXOEplZE8wMEdPZW9QTzJLNmRnN091VXpDS21YV0c3TXlsOW53c0dyVTFu?=
 =?utf-8?B?MkllZzdhQ0E3STV5UEtLWXF2OExGVEJiK2M1WFV6UmNBbVlxV2pRRDFZcmo4?=
 =?utf-8?B?TENsdjBHZC9raCtCTEt2Z1hpU3FkVGhKYlYwYkdad1RlSk5KV1drYWJzRHps?=
 =?utf-8?B?dGswZGs2RWREQlJBWnB3blcyMlBBd0VYdkZVLzF1WHNpVDhSdEEyRHpzTFg5?=
 =?utf-8?B?ZjJJK0EvY1JrMVJHQzdSWURwREQ5MjA3NnRYUysyV3Z0cVQza2JwTjhocVNK?=
 =?utf-8?B?b0V6VXErZk91VDJ4K2xEZGJHRDMrdTFBb1lFY253d0t4MStyUlhZa2d4VElC?=
 =?utf-8?B?RDZUVlpOc1AyaUlFeCsxZVRHQ045ay9MU0Z0dEZ1SnpoSC81U0VPUkRVY0Jo?=
 =?utf-8?B?aGcyTFpTdzhrWWR3bXN5SXRWVy9jMzZuelVpWHc0M3N1SlhhM0tuVUJUWmsz?=
 =?utf-8?B?OGJPaEkvQTJYeDZXdUd5NHBuUVhmUm5WeWVwMnV0YkRmL3hYZkJKYUEvSUo1?=
 =?utf-8?B?SktKWG4zY0NlYnBNMWhSQUNwVEdrV3pKMkorVnNDZnptMTVyWndRZ09scmUy?=
 =?utf-8?B?dXNzTGNpK2pUanVyWEpORGp6NFFYN2dXKzdhakpBa0xnMmZyRlU0aU1QUVd2?=
 =?utf-8?B?aGMvdE5GQWVYcUFzb1ppM2UyTHJJeTZ5SDlsZXZrSW1kcDlwbGNScytZb3Zr?=
 =?utf-8?B?dXltd01vajM5UlVTMlFGZmttRjZLQkxCeTQ1a2oyZGtUbXNhbFNlQmVJd3oy?=
 =?utf-8?B?NkdmQWtnSHhpUXM3a2JmbG0wdXF5d0xOdkJMTDF3UGxwT3JOZEE5NEpPTzdY?=
 =?utf-8?B?dDFpUjFCSjc2MWQxcTFMVjJSY1hjcG9ROVQyK0dHdnRNbTFFQnJpejlEdUFp?=
 =?utf-8?B?WjVNYWVmU00ycG1sZ1NTSmZFcWtISmMrS0JjSXRWYy9aWmZpRXJ1V0ljWk81?=
 =?utf-8?B?Mm4vRWIzMFNvQkJoRW5TZ1QxUTd4cDk2SzJJb3dILzQybjBqVGo4OFRzQnFF?=
 =?utf-8?B?KzJ0N245N0RacVV0V20zUEpJZnEyT09CeHY1MmkxTlhkRlhxc0hydnkxR3NZ?=
 =?utf-8?B?Z00yNDZ5bWMybjFJV2lvclhwU1JteTNRRnJHOWlvRjU1bm1adnlFOWlYeEl1?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RGFScStoMEl0UlczSGgwNlN6dUtaL1RDcER3aTZnMWFnYml3NXdTeW9nNnpI?=
 =?utf-8?B?Ziszb2NuRjNPellWQk9VK28xNGNaeDU3UUxqYWloTGNMdXorZEFhU0NTdjI2?=
 =?utf-8?B?Vmx4bmlpS2xJaTkxRGcxdkxJWk44K3lLOHdzd1JBWkg2Qi94OTNwODl2S05q?=
 =?utf-8?B?V0NaL1QrRWlHeVBTVVVqMDFLTm1EUDRjaFpxZU9Lc2VjR0MzSFFVU25PaEJY?=
 =?utf-8?B?aFlDRGpxY1M2UkJsbE1Fc3dpVmhsS1hvZkRmeGlwSWNVMGY3KzlqYTJjLzVY?=
 =?utf-8?B?bk85NDB0QTVzZmtyQ3dSN0grNDdTM3BFSWRHVUh1MnRKUDZxY3BUWlNoNDNF?=
 =?utf-8?B?NnVPeWNCaEFuRkYvOWpqWDM1NVhZMEVmUmlRUFRqTGZmbjNjOXRVWTBOQ01C?=
 =?utf-8?B?YVgvRldjRlVJWlVlZmwvRFFnYUxDMTluRHdNSXE5SXJ5bnBwSFBHUktaNDdL?=
 =?utf-8?B?SEpxcnRIbjhwdjRCSzJLUFozRHRkZDlvV3QzTjlWQUlHSStlbmpGUUhObFRq?=
 =?utf-8?B?MzZVSmkzUnNWdlJnRklXcFJ3RzdxS0N0SGFWTGFrNkR0cjBndWEvMmwrQ1Vy?=
 =?utf-8?B?d1ZwUXA3ci9oSkVDalQ1b1pvZERNYlQ1blhtcEFBZHgyQ3NpbUh3bkFIVkJ1?=
 =?utf-8?B?UzlUUWV4dldoL3NLRGJIekZaYzh0bnppRnFEVm5CZjZmUHZFZENkTjZPOVcw?=
 =?utf-8?B?bkorMkpMWnZCWWhjWlNLVVhoVFRtY3JCMU9oYW8vTGYyMXFDNE5Va0Z3TVRw?=
 =?utf-8?B?Ymc2ejh3T0FrcXVpTitHMnk3bTUvVHVZa1NQWGVSNlRiM0c3Yi9IaW04NHNm?=
 =?utf-8?B?YTdoZUJ5Rkt5WEhmWnppcEF0OGREN3RaY0xxMkMxaWpRVjhmdzkwbDBJaTA3?=
 =?utf-8?B?NWZ0T212cWtLU29GUTNjSWU3VlNBTjJBRGJ3QTYwdXBIUldUTktIanNrUlM3?=
 =?utf-8?B?OG0xYiszb3pEM3BtOFoycEhWNkNpZkJwWjArZFRBVFBUc0JXcU1CdFFzVEZm?=
 =?utf-8?B?RVJWMXN5RHprSUxPNEVVSDRVM0JCK0JhU2c2RVF6WEFLOUdpQkpSYlYvelN3?=
 =?utf-8?B?VTBqWi9mNzN3ZWFjVlk4TU1NRWoxUTBpelZEKzdEN2g0clpjUFJtc3ZXT1pN?=
 =?utf-8?B?UGh4VXAxOXBYQXdYMlJLU1l3RmRsN2Q0SDg5S1NMY21OOXFvdld4d3hUS0dU?=
 =?utf-8?B?REt4N2F6M1paTEpKSWorLzcyMlpBbDRMNFdNT2ppVEdtbmN6TWZvNnNCWVpZ?=
 =?utf-8?B?dmtuMkhMZitYQ3FmNWVkTzIxd0JSRG9KeUVmam1ZN1pHL24wK3M2UWFwZjlM?=
 =?utf-8?Q?ix8JKOwB6SUdonhDkIIWPjaSAuvbMZGOv6?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979ca927-61ea-4196-2311-08dbeb8a205a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 18:37:48.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyiFSUESsIy0R5lKicRzIGJ2yRsHhh/YQyATihDsO7J1ZVoPij5sNcyKgloExy7aN+zPSaXOmXq4fqzlnoSYJ8ii2dsMBuJ1x6Utepo/WnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5193
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_13,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220134
X-Proofpoint-ORIG-GUID: pkWzz0ayht9g97GWdW36_P7QjQkHmxXe
X-Proofpoint-GUID: pkWzz0ayht9g97GWdW36_P7QjQkHmxXe


> On Wed, Nov 22, 2023 at 10:08=E2=80=AFAM Yonghong Song <yonghong.song@lin=
ux.dev> wrote:
>>
>> > +SEC("?tc")
>> > +__log_level(2)
>> > +int test_verifier_range(void)
>> > +{
>> > +    asm volatile (
>> > +        "r5 =3D 100; \
>> > +        r5 /=3D 3; \
>> > +        w5 >>=3D 7; \
>> > +        r5 &=3D -386969681; \
>> > +        r5 -=3D -884670597; \
>> > +        w0 =3D w5; \
>> > +        if w0 & 0x894b6a55 goto +2; \
>>
>> So actually it is 'if w0 & 0x894b6a55 goto +2' failed
>> the compilation.
>>
>> Indeed, the above operation is not supported in llvm.
>> See
>>    https://github.com/llvm/llvm-project/blob/main/llvm/lib/Target/BPF/BP=
FInstrFormats.td#L62-L74
>> the missing BPFJumpOp<0x4> which corresponds to JSET.
>>
>> The following llvm patch (on top of llvm-project main branch):
>>
>> diff --git a/llvm/lib/Target/BPF/BPFInstrFormats.td b/llvm/lib/Target/BP=
F/BPFInstrFormats.td
>> index 841d97efc01c..6ed83d877ac0 100644
>> --- a/llvm/lib/Target/BPF/BPFInstrFormats.td
>> +++ b/llvm/lib/Target/BPF/BPFInstrFormats.td
>> @@ -63,6 +63,7 @@ def BPF_JA   : BPFJumpOp<0x0>;
>>   def BPF_JEQ  : BPFJumpOp<0x1>;
>>   def BPF_JGT  : BPFJumpOp<0x2>;
>>   def BPF_JGE  : BPFJumpOp<0x3>;
>> +def BPF_JSET : BPFJumpOp<0x4>;
>>   def BPF_JNE  : BPFJumpOp<0x5>;
>>   def BPF_JSGT : BPFJumpOp<0x6>;
>>   def BPF_JSGE : BPFJumpOp<0x7>;
>> diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/B=
PFInstrInfo.td
>> index 305cbbd34d27..9e75f35efe70 100644
>> --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
>> +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
>> @@ -246,6 +246,70 @@ class JMP_RI_32<BPFJumpOp Opc, string OpcodeStr, Pa=
tLeaf Cond>
>>     let BPFClass =3D BPF_JMP32;
>>   }
>>
>> +class JSET_RR<string OpcodeStr>
>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
>> +                   (outs),
>> +                   (ins GPR:$dst, GPR:$src, brtarget:$BrDst),
>> +                   "if $dst "#OpcodeStr#" $src goto $BrDst",
>> +                   []> {
>> +  bits<4> dst;
>> +  bits<4> src;
>> +  bits<16> BrDst;
>> +
>> +  let Inst{55-52} =3D src;
>> +  let Inst{51-48} =3D dst;
>> +  let Inst{47-32} =3D BrDst;
>> +  let BPFClass =3D BPF_JMP;
>> +}
>> +
>> +class JSET_RI<string OpcodeStr>
>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
>> +                   (outs),
>> +                   (ins GPR:$dst, i64imm:$imm, brtarget:$BrDst),
>> +                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
>> +                   []> {
>> +  bits<4> dst;
>> +  bits<16> BrDst;
>> +  bits<32> imm;
>> +
>> +  let Inst{51-48} =3D dst;
>> +  let Inst{47-32} =3D BrDst;
>> +  let Inst{31-0} =3D imm;
>> +  let BPFClass =3D BPF_JMP;
>> +}
>> +
>> +class JSET_RR_32<string OpcodeStr>
>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_X.Value,
>> +                   (outs),
>> +                   (ins GPR32:$dst, GPR32:$src, brtarget:$BrDst),
>> +                   "if $dst "#OpcodeStr#" $src goto $BrDst",
>> +                   []> {
>> +  bits<4> dst;
>> +  bits<4> src;
>> +  bits<16> BrDst;
>> +
>> +  let Inst{55-52} =3D src;
>> +  let Inst{51-48} =3D dst;
>> +  let Inst{47-32} =3D BrDst;
>> +  let BPFClass =3D BPF_JMP32;
>> +}
>> +
>> +class JSET_RI_32<string OpcodeStr>
>> +    : TYPE_ALU_JMP<BPF_JSET.Value, BPF_K.Value,
>> +                   (outs),
>> +                   (ins GPR32:$dst, i32imm:$imm, brtarget:$BrDst),
>> +                   "if $dst "#OpcodeStr#" $imm goto $BrDst",
>> +                   []> {
>> +  bits<4> dst;
>> +  bits<16> BrDst;
>> +  bits<32> imm;
>> +
>> +  let Inst{51-48} =3D dst;
>> +  let Inst{47-32} =3D BrDst;
>> +  let Inst{31-0} =3D imm;
>> +  let BPFClass =3D BPF_JMP32;
>> +}
>> +
>>   multiclass J<BPFJumpOp Opc, string OpcodeStr, PatLeaf Cond, PatLeaf Co=
nd32> {
>>     def _rr : JMP_RR<Opc, OpcodeStr, Cond>;
>>     def _ri : JMP_RI<Opc, OpcodeStr, Cond>;
>> @@ -265,6 +329,10 @@ defm JULT : J<BPF_JLT, "<", BPF_CC_LTU, BPF_CC_LTU_=
32>;
>>   defm JULE : J<BPF_JLE, "<=3D", BPF_CC_LEU, BPF_CC_LEU_32>;
>>   defm JSLT : J<BPF_JSLT, "s<", BPF_CC_LT, BPF_CC_LT_32>;
>>   defm JSLE : J<BPF_JSLE, "s<=3D", BPF_CC_LE, BPF_CC_LE_32>;
>> +def JSET_RR    : JSET_RR<"&">;
>> +def JSET_RI    : JSET_RI<"&">;
>> +def JSET_RR_32 : JSET_RR_32<"&">;
>> +def JSET_RI_32 : JSET_RI_32<"&">;
>>   }
>>
>>   // ALU instructions
>>
>> can solve your inline asm issue. We will discuss whether llvm compiler
>> should be implementing this instruction from source or not.
>
> I'd say 'yes'. clang/llvm should support such asm syntax.
>
> Jose, Eduard,
> Thoughts?

We already support it in GAS:


  $ echo 'if w0 & 0x894b6a55 goto +2' | bpf-unknown-none-as -mdialect=3Dpse=
udoc -
  $ bpf-unknown-none-objdump -M hex,pseudoc -d a.out
 =20
  a.out:     file format elf64-bpfle
 =20
 =20
  Disassembly of section .text:
 =20
  0000000000000000 <.text>:
     0:	46 00 02 00 55 6a 4b 89 	if w0&0x894b6a55 goto 0x2


We weren't aware we were diverging with llvm by doing so.  We support
syntax for all the conditional jump instructions using the following
operators:

  BPF_JEQ    =3D=3D
  BPF_JGT    >
  BPF_JSGT   s>
  BPF_JGE    >=3D
  BPF_JSGE   s>=3D
  BPF_JLT    <
  BPF_JLST   s<
  BPF_JLE    <=3D
  BPF_JSLE   s<=3D
  BPF_JSET   &
  BPF_JNE    !=3D

