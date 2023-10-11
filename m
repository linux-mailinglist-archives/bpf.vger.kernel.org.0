Return-Path: <bpf+bounces-11962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FCA7C6022
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 00:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDE0D1C20B8A
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 22:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AD63F4DB;
	Wed, 11 Oct 2023 22:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gmMVqd+Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="f/u9qHXD"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32939922
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 22:06:18 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15792A9
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 15:06:15 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BKSwCR012773;
	Wed, 11 Oct 2023 22:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MaBnzOpfZYrQh+HyMpzxQlGoG9Ev+DXOxohfGGtb5m4=;
 b=gmMVqd+QD5Y2PSg48soFaW2sw9a85tC5bz60D0rq31hHe2gl5pdAjXw4bL0JVX3ghZMe
 MohX+7RakXIV3Nvgb8FYB11Do6bBcDYTU7BiF3gC1eXen2nRtMvUCN+8FgSxV4H1CtAF
 UmZ/YZ2TyKSY3GpuyQKHGuW+YCI/IeehbWmHK8i9nkQLLte/+8r/yWhug+MfZqa7yWKC
 hrwSVYkv8brirROfq5mpx52ACashgAlXmWZY9IKMXXvV01MyvDVqGh2eAtJXDR3APYB4
 RQDyPUceO/jITmPQGVU0chX2vHeFZyVdg9Nps5vAmufpnhWUYoKJrLkz/4reqtnXM9jV xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjycdsftv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 22:05:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BK3ER1002464;
	Wed, 11 Oct 2023 22:05:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwseqbrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 22:05:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+cFNa8/Cjz8cViJFnCNGQH/RgI7W+w3Arq7N7k1chll/NrdJSyGxwbxPYkJUHbkjnZXoTMp/1ZYsgxkZZ9iHAyT0Kus3Kk7DywiDmeowKbatI6AiJSrEZlGg4gp8xJp6zAXXa3MVg/o4pvgQIP1ZjchP70blMg7wa2nF6hNMjG61qjHjq+4j4ZnEjXXNAdSoMFcS4Z7LXDpv0ShwFI4GacNh5NRNAknltYdOiZ5mG1XQ2xomNtlbp1ft8WwVPDAOvv2pp73uSjBC1YAEIU9ts0uu4rfrcLMMcEz4IW7GIsxp8nEILLnNvv/RjApjvZyhMGlWJ9W+Wdgd/R/F1kgtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaBnzOpfZYrQh+HyMpzxQlGoG9Ev+DXOxohfGGtb5m4=;
 b=Xtd6gc8aoJvbnKrXlCnCSni+x/yaoLaTHYDjJyo85skhKVzQ240qPPTLMvfuwifNpfT2A9f8mimqT+y5ellTPuUyhvKfNlUIkXdpu30T24YcqPn8xtcikO3iY+81fZ8z+M/5EZkKuqNZGrp2kexeWgciwyNnrLR2jpWJ0KMwI+2P58H5urJANZHtmU1A8b7cGxTjAyRTPnWmZ66HNl8IlzEqZMdEpORKyDu1P02n+Ie9NZ3eX0VY7snVuiSaVllOL0gOw5a+wTPKv40k6jR3nqCRYEv2O5rGem8pXd3/rwUS++1BFpy8ARrLfST+AxapcTyoolBUPgX/Mt1glyAc2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaBnzOpfZYrQh+HyMpzxQlGoG9Ev+DXOxohfGGtb5m4=;
 b=f/u9qHXDnzN3lgOGejZd72A4+9MwmD4I3Pk7k3cmYccbpIPnrCSnXCtPKT3KrPUH9+SWCPUpITU24VkPfD4UjcjFGjLxMhCwBYO3VTTmImup5BAAhKbfHuxgYkKpbLxXYnoEXmde21rBHbIR0LNAHn843HuKJGsvFcvDlmWhvjQ=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 CH0PR10MB5097.namprd10.prod.outlook.com (2603:10b6:610:c2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.44; Wed, 11 Oct 2023 22:05:52 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 22:05:52 +0000
Message-ID: <7b4ff1c8-f8c7-b96e-c581-f27a389379f0@oracle.com>
Date: Wed, 11 Oct 2023 23:05:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC dwarves 3/4] pahole: add
 --btf_features=feature1[,feature2...] support
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org,
        andrii.nakryiko@gmail.com
Cc: jolsa@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>
References: <20231011091732.93254-1-alan.maguire@oracle.com>
 <20231011091732.93254-4-alan.maguire@oracle.com>
 <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
 <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
 <5b40ffbfa5949c24dad44ed6adf70d35cf72f757.camel@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <5b40ffbfa5949c24dad44ed6adf70d35cf72f757.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|CH0PR10MB5097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e33f9f5-6658-4291-a71f-08dbcaa63be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hU4CRFpoesVtZ33Bzf74ofy0I8xdTLDo4IaUSkO6DG7qYjerN/XOccObrvi1iqQDfE+ErsKRDoU7gpjArP5r7CxS0PNGqqGLZWX400yw4o3vu6qoPFa6zT9HANx8gNkDYc16pvbhX+choK4Io3hk9200rhLozyhQsQCjIUPVzc6a1x+ZDnrSd7Cixc8g1MK8mFpXD09vkbO+BFrHG3UUqDk30+jQPAMQ5FAwTy+ry/Cz2C6Xn+PiKdtqmiy1Ucl31vhsoutCD21R5+gp+doBQz5B/UjTdgvD/tptoE4bcbzEqTDU0NQLuTehFNIE6KB+VeTuO8RYibednscQYAXprzrSAGbNyhNbfFlj0B1xdppR2L4T0DMrZnZBLKMdJjgGoYIizD6+1+qMsFbD1B5JN9L6FTsbjJnu0WxUdQTDFE0RhhvuyJXLG1fkGhnBTMB4oAasogR57S4syfgaWYdG4RicYPv3C543+Tea1So+XEh7w0RMzbA9xb515+CRjxej6/SF262/mG3pbdjgatSFZIXIYJiE4xir5CDHOusM4Knp8WWfJDT9hqfWMWqYBaJNJsf6xT0i2d+KL4bPClY9zrShd008QROQn2BXysMfSuUzgr9J9SHTAdGoJVo19JYUbrtjy0c0HYtYMsmG2UeDyw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(66946007)(66556008)(66476007)(316002)(83380400001)(2616005)(44832011)(5660300002)(478600001)(86362001)(31696002)(53546011)(6506007)(6666004)(8936002)(8676002)(4326008)(7416002)(31686004)(6486002)(4001150100001)(2906002)(38100700002)(6512007)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UkI0YU5lcWhXNzUwbmlZSXgrOWwvYmZBN1Nma2RhSHZQS3lERWt5TE1rMGpo?=
 =?utf-8?B?QitObG9Tdm5IbCtoTmdJaFF1bGZFVmQyb2gyejk2aERHMzZETFdOTXB5RlVx?=
 =?utf-8?B?NGlJQlp4Q2hzMUNUdkxkMUhJNXQrd2tPSjJjSXFqRnlVMklJcGxRcHFUR1FL?=
 =?utf-8?B?cWk2a3U0RlYwS1VtZi9zZFZOWXhoRXBxZXJBZHJqcDh5U2h0RHAzYlNEa293?=
 =?utf-8?B?VVZzQVd0b3hjbGwzdGUxYXZrTWRCWDNZZDVFOTEyQ28zQWczRzlvYzd3YjlS?=
 =?utf-8?B?ekNSSW51YTQzQlZ2S3RxK0QvVjRPOGJVWXhCSS9oUWJxU2tkcW8vTDhQU0Zk?=
 =?utf-8?B?aXg0NHU3VmE2WHVYRGNIZHh0RU1DUmpkUnRPMSs0Rkh1Nmp4Wk1NK1JrdjEx?=
 =?utf-8?B?M3krVU41KzN1OVBOVzV1YzBybGNnckQvNjNsVy9MMFNVaUQ0cS9Jalp5ZGRu?=
 =?utf-8?B?WmlpT1VTa01BdlJRa0x4NHNGemR5aGdhdWxkUWpFYmVtc1Zoc2wvdzc5WnZX?=
 =?utf-8?B?OGpsVEFRR1N1cEFsaXQrKzRYOFdZMHdvY3BvVnVQNi9vRHpLOTdsNDU1VWV3?=
 =?utf-8?B?MDFJUU95M29XdktSMlBjZ2VEdmhaZDd6QVlIeTFVZXQ2Q3FvdlV5TmtvUVE4?=
 =?utf-8?B?elNQNG5MWmdVOFNNcEdXR1RicFRPaG9jOGhpZ2l6VWVuMi8vaVlraWpRTUkr?=
 =?utf-8?B?YkVDNFplQXh5RzNFS2xzZEg0aHBac3ZDSFRtL0tLYzNsSG05em4yQmQyU043?=
 =?utf-8?B?UFhkNi9Ta1JGMmZLZmZlWnRuRVZiczhsNlo1SUgrVXdIUjdVQzNSSUZnUEZW?=
 =?utf-8?B?U2thRkRKUVkrczZYcjJRYzc4eFZHSXBhb3ExNG5McXRPMjMrakZzaTZHdVVY?=
 =?utf-8?B?Q25oZjhaaDFla1YwUWtXUTU4OERINkRKR0JGY2hrVmtZN3JheVJ6TnBIOVJB?=
 =?utf-8?B?SHNWNXp1SFJPck9QRWRkRS9JRHhPYWkzQnhvay9yUE9CQmZEQU9INjRGSWFB?=
 =?utf-8?B?WlcyNUt6TWw2TUdzbVowclZmTFBCZ0lHbWlsYWp3UUxEdlRjcDFGazA3WVJM?=
 =?utf-8?B?NU1yKzBMdnQyNlhITjgxVzhIVFA0MXkzaXZXMXJYMXdWczd5UkJHZjh2MnlE?=
 =?utf-8?B?TGs5am1oQVp0UHlrYmh6V0dBKzkxRC9jeGJkVlVsUHRuK3d1RzZ2MUxvSWxj?=
 =?utf-8?B?N2RkWEhLbFN2U2xtQWZGNzd3dWtrNEZhZlhvTlBraHNWMHpJL1UyM1lkdkUz?=
 =?utf-8?B?aFFkL1B4MnY4bFNISGVKSUVscVpidHJaRVJOd0lnUHFqZDcraTlhM0U0MnQ3?=
 =?utf-8?B?dVlId3ZDVm14Z2hhV0FhSjFRSDdTTzNDd3N0NjhZS0tPK3d6c0dIYnBjcVVH?=
 =?utf-8?B?SHVreEoxUjVSQVIzWnJyUTdtbG04S241ckxyaXFQZi9HMkRva1FBRFNLOFRH?=
 =?utf-8?B?emZlaVh2MnlmcjkzNFc3K3FGaDh4dHUwR01WdG9penJ5THlBUjQvdjJQUm5h?=
 =?utf-8?B?T2Nxa0Z1anBpZEF4b0Jvc3I5TUpIWUpDTE9mcTFmZW5yTHJUa0c4bXNkR0wr?=
 =?utf-8?B?R21SYnlFWmp1dlJKMnpzemNsdktHS3RESXR4RWM3QW1KNTdkMmFJeGRKVGF0?=
 =?utf-8?B?bk85UGpxdlVKVWh4WlNJcFhLdE9adzBNa0krRDV5cS9lRXZNd2J5cDRteWQ2?=
 =?utf-8?B?MlRCU2tEY1p6SnhrZUIrMVUzWU1GY0RFZXVYYllJQ2xnM01oSlEzV3UzUDQ3?=
 =?utf-8?B?dmFadDlMNU45L3A0eDIzNkZvYnJ4RVFmc1pZTmgvM2t5TDc4NXJlc0xTa2pn?=
 =?utf-8?B?NHMyQVVtckFnUTRrSnBQQy9tb1p1cWNqMWhFVHN6Q0NDQ1VlUzVTaHBhcEJq?=
 =?utf-8?B?Vm9kcHhKOUd1UTBhSm43dlN3eTA5RVZnd20wMi9OZ3RTVDBaRlBXWDlUU0Na?=
 =?utf-8?B?WER4SklaV2Z6Z2ZxU3pYVHpWSkswMWtnbHdzdWMyRkJ1QTVaV0tDSXJXcGlG?=
 =?utf-8?B?SmQwSWlpUHNXY29DRmE1T2JOWlNuMFhWZFlTaDZLN25mNUQxbDZ4OTBSb1Mw?=
 =?utf-8?B?MGpJZHhlaDQyR0UxL3ZVT0cybzdLSTVnTjI2UzAzNG1HRnpTUnEvNGF2OEl5?=
 =?utf-8?B?MDJ0UEE3eElHaFBvSkl4SFNqWm13ZmgwTDdJZ3NLVnpNdXREK1RqaEUzMG43?=
 =?utf-8?Q?Eg5mwGSHMjPL1N5ZJRiTry0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?Y3B5aXc3RGxPUmV1emJtZkJaWXhyR0k5V0svdmt4RWF1TE5ha1NqMDBFVitk?=
 =?utf-8?B?R0FNb21zVTV2WFFzdTYvTlcxMzlTc0hTWkl4THRTU0Erdkx5SnJYWVZUamtD?=
 =?utf-8?B?N1lYQWxxWThEd3l1c09XUmc0Nytia1RqOWtNMU0rNHNva2NNYk1XTit6QVow?=
 =?utf-8?B?aW5kVllUcmFPaTRjTWFicVQwakVFVWtaOTRLNXRUV3dsY3VFZDNLM2oyeHM5?=
 =?utf-8?B?UXo2UWlzWFBEaWg2ZFFiY0pnUW5lMUZoREljQVNyOUprN3pweW1BQzM3ZUZo?=
 =?utf-8?B?cHc1NGdQekNPa2hoMzljSkVnMGt2cXBUUG4zd1QrVnBidVdpREQzVXBJZ0VB?=
 =?utf-8?B?V3pPMGVQRThZZC9lVG5ncUR2QzlReTlpdEpaSVFLd3lURzhTcG9Ea2x5ZFRz?=
 =?utf-8?B?ZlVzRmx4YUhzbm5hbFEzV3kwZURkR2VzWlVEd3dpMXRvNXFhbCt0cm1lZkZ6?=
 =?utf-8?B?am0yNHYrYmczWUMvdjc0dy84a2RIN2NYYWVpelJ0QjNEZ3psMmU0MndCWTl5?=
 =?utf-8?B?MzIrbXByTnBuS1VVYUR0OVFDV0l0dCs0VzExQ3phMzdndTI0TkZwZVRDdHBN?=
 =?utf-8?B?TDJ6VW0xM1ZsTkI4eFlmbzhCNlYvOTdqMEFXbVBtdHFiRCtaRDBNZWthakpN?=
 =?utf-8?B?bUYxZ1lXSzl2SGdVS3BoUXFXdW9BQ1hPRGEzbUQwWGNuRHdTbHZzZFl6VVho?=
 =?utf-8?B?TVo0SmwydHp6czBFajRHa3NXZ1VseFdCd2ErOGF2U0lZc1B2N0tkT0lHS2Zr?=
 =?utf-8?B?VWo0UHZZbEhXVkJkMVUralJkaFN6T0NHaC9BcmZlQW02TEFPaGRIODBqaTNq?=
 =?utf-8?B?OW9zZENPMk5lalFRaFJPc1NSVi9uU2tyanhwajFsbkRzYkhseTd5K21mcTZn?=
 =?utf-8?B?cndlb2ZzaWlxdzlOdStxR1h2dEl4Zm9vZGlPOEE4eXJncmhvZUorZXJLYW1x?=
 =?utf-8?B?NnY2T2NJSFlvcDdSeXJ4Tml6eFhzdzJaZUxqVWluQ0UxWVp3Q29VYk9jODJp?=
 =?utf-8?B?N2g0RU9PVGxTQnJKRTJmSStCcEloSEtMMnZQTW1KSHBBMVhPWG1mSEcxM2F3?=
 =?utf-8?B?OWw3MlFFRXd4YWZHcUo0Mnkyc2daTUdScmJkRExHVnJlcUg4dmNTZ0Yxdjc5?=
 =?utf-8?B?aTAxMUQxdFg0YzBrYzZXc3l5NEVQYjI4TjhDdit2SFFrWjhBbS9zTEwvK0RD?=
 =?utf-8?B?dUJ2VWh4d1Z4WjVpdmt2ZFZ3MEYxc1JoZis2NE1MaU5HTGlFMjdZT0FCVjg4?=
 =?utf-8?Q?yzF8AtqXg24oL5W?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e33f9f5-6658-4291-a71f-08dbcaa63be3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 22:05:52.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZlBPCYnLwrjWw/DrHs/kI1iL5IqAFieOVgVhFmJFUdHD0EvIP+DTDKifqmKqqvwNUSlA+vNfPWuq8a0Fw+mHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5097
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_17,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110195
X-Proofpoint-ORIG-GUID: WJEmO18sT9il_3g1rZU1VyW1jf1Xtldr
X-Proofpoint-GUID: WJEmO18sT9il_3g1rZU1VyW1jf1Xtldr
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/10/2023 20:08, Eduard Zingerman wrote:
> On Wed, 2023-10-11 at 17:41 +0100, Alan Maguire wrote:
> [...]
>>>> +		}
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
>>>> +		bool *bval = (bool *)(((void *)conf_load) + btf_features[i].conf_load_offset);
>>>> +		bool match = encode_all;
>>>> +
>>>> +		if (!match) {
>>>> +			for (j = 0; j < n; j++) {
>>>> +				if (strcmp(feature_list[j], btf_features[i].name) == 0) {
>>>> +					match = true;
>>>> +					break;
>>>> +				}
>>>> +			}
>>>> +		}
>>>> +		if (match)
>>>> +			*bval = btf_features[i].skip ? false : true;
>>>
>>> I'm not sure I understand the logic behind "skip" features.
>>> Take `decl_tag` for example:
>>> - by default conf_load->skip_encoding_btf_decl_tag is 0;
>>> - if `--btf_features=decl_tag` is passed it is still 0 because of the
>>>   `skip ? false : true` logic.
>>>
>>> If there is no way to change "skip" features why listing these at all?
>>>
>> You're right; in the case of a skip feature, I think we need the
>> following behaviour
>>
>> 1. we skip the encoding by default (so the equivalent of
>> --skip_encoding_btf_decl_tag, setting skip_encoding_btf_decl_tag
>> to true
>>
>> 2. if the user however specifies the logical inversion of the skip
>> feature in --btf_features (in this case "decl_tag" - or "all")
>> skip_encoding_btf_decl_tag is set to false.
>>
>> So in my code we had 2 above but not 1. If both were in place I think
>> we'd have the right set of behaviours. Does that sound right?
> 
> You mean when --features=? is specified we default to
> conf_load->skip_encoding_btf_decl_tag = true, and set it to false only
> if "all" or "decl_tag" is listed in features, right?
>

Yep. Here's the comment I was thinking of adding for the next version,
hopefully it clarifies this all a bit more than the original.

+/* --btf_features=feature1[,feature2,..] allows us to specify
+ * a list of requested BTF features or "all" to enable all features.
+ * These are translated into the appropriate conf_load values via
+ * struct btf_feature which specifies the associated conf_load
+ * boolean field and whether its default (representing the feature being
+ * off) is false or true.
+ *
+ * btf_features is for opting _into_ features so for a case like
+ * conf_load->btf_gen_floats, the translation is simple; the presence
+ * of the "float" feature in --btf_features sets conf_load->btf_gen_floats
+ * to true.
+ *
+ * The more confusing case is for features that are enabled unless
+ * skipping them is specified; for example
+ * conf_load->skip_encoding_btf_type_tag.  By default - to support
+ * the opt-in model of only enabling features the user asks for -
+ * conf_load->skip_encoding_btf_type_tag is set to true (meaning no
+ * type_tags) and it is only set to false if --btf_features contains
+ * the "type_tag" feature.
+ *
+ * So from the user perspective, all features specified via
+ * --btf_features are enabled, and if a feature is not specified,
+ * it is disabled.
  */


>> Maybe a better way to express all this would be to rename the "skip"
>> field in "struct btf_feature" to "default" - so in the case of a "skip"
>> feature, the default is true, but for opt-in features, the default is false.
> 
> Yes, I agree, "default" is better as "skip" is a bit confusing.
>

Thanks; I'll use that next time.

Alan

> [...]

