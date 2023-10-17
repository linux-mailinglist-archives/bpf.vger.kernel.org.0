Return-Path: <bpf+bounces-12395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5BD7CBE9A
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 11:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65E63B210DC
	for <lists+bpf@lfdr.de>; Tue, 17 Oct 2023 09:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1AE3F4AA;
	Tue, 17 Oct 2023 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pe10I0kQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fi8+/X/6"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CE73D99D
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 09:10:01 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4510EA
	for <bpf@vger.kernel.org>; Tue, 17 Oct 2023 02:09:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO4Hj017537;
	Tue, 17 Oct 2023 09:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FL7LT/iiYUqSHamPm6fZf8EROi1BULcOe6Noaps6lJE=;
 b=pe10I0kQ67L9y7XASQD/oUJ4XggU+12V2IAyRwAsol6GPVNexLUuKRJ9OoLxVpb+nUGP
 ad+A4vdXQzVFlwzBQtkR2QMFG+CchCXlQ31ELfY/tF1ugfMjZXEAS6rrc2UNk7UbAm41
 P7PjiXQBIPklki7kpdw9qSvEaFh6NIE5CGdZqlqH0fgi/cDySlBUbekPlLmFd/p/F3Ig
 v5/KQxV/7l/T1Fcu3s54R3p/S/uPI0acrTGADjkvbkkoFampEofjC2tN6R8jZLVKStq6
 rpNq2sTUG9wetiyBTEBTTIf0eGUD/vXkr130L2+kPoH3HLhDQcyz9OODzv3ivUZ8r1Ah dQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cvkru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 09:09:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39H90PL4021606;
	Tue, 17 Oct 2023 09:09:41 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trg50r62g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Oct 2023 09:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7OFoVlMgLxNPwV232n6mo5KD12TB477U1ecg9ixS/qLi5cci46FEZ8/4tyLlVZjy9fZ/JS57p2hLaNhUYE7tlRMYS5lmAEwoRZk5v0O/frVGaHtKffGBiuTO+zsm7PHENLNHAvnqZw9lVQcT2DVtRV4j/XxLv5yTkGe3wsSM8OaNnePMY6s91cXECHU35ur9l5LeUGZLd7lceFwMhPgbE8XDoYettI83n4cAkWp3P/MnriTyCcRYGGPUBQA2vjCdhmIiU5SHeSqZUo5zAlFIzeGyKJlKnKPnxxWJDIXxQxUIcaw124FsEjQ6Jl8e/ptW3Why/+wtuHiVvXnapC47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL7LT/iiYUqSHamPm6fZf8EROi1BULcOe6Noaps6lJE=;
 b=UBpwzJTQ6mZVzEaAvWU1a0Q7QRHAKdDq0JwD5KYRRys+qn7yitFDp7FZRYtnu8z6kSZZIVuhXLmppxCrkpE6BHupPbEzcBPlJT7rUCc/UsHJZDf1NzRTnvNqbd+4yGfmaFzweXVY5/VxiLJiUidqy2geWmkLK0LEop8aZiS5zOJy3XaaLEb8hR6qXtdwDnQAUNCd50p/WswuZzbKahb08Ou0rTkoUoe97OnvpfJUHprMJFepHuKlE5/NV0hURyFPF0la3ODscnWQoi9APodvzPClKKateUTIGz3qbovKcbSInuquD/7HRHS4H11zuiLJhZDhHYqs18EVexJjEWsfvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL7LT/iiYUqSHamPm6fZf8EROi1BULcOe6Noaps6lJE=;
 b=fi8+/X/654wO7k/iPxO/MqjbBWipTOkceAAmQ4qXsNz7vx1/28H5KA1nHEqHMU3+az6TurPny6oaNUT28wca0Jrb7HoYl3y++uVpU8L/lIKRVzjEh80QwBbAnRf3zuJ6sZMoHaG3CW/02XAymE9tNtxlTPi0uFpTFanVvNEMIWo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by LV8PR10MB7752.namprd10.prod.outlook.com (2603:10b6:408:1e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 09:09:39 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::dfa9:4b44:40d4:5d36%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 09:09:39 +0000
Message-ID: <55bdb6cd-bca1-e829-61e6-874ad32852b9@oracle.com>
Date: Tue, 17 Oct 2023 10:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add additional mprog query test
 coverage
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev
References: <20231017081728.24769-1-daniel@iogearbox.net>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231017081728.24769-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0055.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|LV8PR10MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 8133ef8f-3837-4388-5184-08dbcef0ca95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NgXmJ8wFu4UWxFGHXqQp0VGUFeiU6MXuB52P1O60LDeU8stL9TEpHB+187oaEYWkgxsREly42XXY8JStF6nN4ThHdRgQSnC6LPDgG7O/ljc4sbBrdoLnuN22Cjnjw7rVaHPmIJ5wDa0+TowCgjd3IPyUT8XbYSLCeMXXj+guoaWO1+DJbnYqI91Xp8zwQ2F+scrCGHKwyhQXpeNZCoP04Zp6iTl0qoof77FhCEgvXTJ+7L7XqQ9DzImEgDOJS3TUHvsk6OXnbN18gYruJlMExdYtopNZUhNYMWGuxAVpR7B8kGzOXiN1dwgrLW/MTeMMg1wjc+20Jppz3aBLW4MWYB0GnfpCpIxP3PoFGj6zOuB1rJ8TZWOMasSBODOVaQG+3E57bk73AivvzMdTPrAG84p9MducJ/Mdo8nEClNz9YRCSj+1ulymH7cBXnxAz0OePW5AlqnFKrUMf4uvVcnAzEGugLRq3DZ9UWw7l5ePaDrredPD0/Isz35mX+jjExEwTdG4nSMi5GuzA+BGW527sqNXF6MN9b3u3EmmA+htBOjDz5rEXbEykAKMtwzhGPPv5VfHu6b/0IIPqk6GHwnVtPCUQlY0Sqs7SpxLBjs5DI5gKsVxzMUlnxcr6MPR2O+CgnO2KcoPvr0xdN/7KGRnAA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(2906002)(44832011)(8676002)(8936002)(4326008)(41300700001)(5660300002)(38100700002)(83380400001)(31696002)(36756003)(86362001)(2616005)(316002)(478600001)(66946007)(66476007)(31686004)(66556008)(6666004)(6486002)(53546011)(6506007)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SEpKRlJ5RkYrNCtKYU1wUnhZZStTMll6ZGhrL3lSaDN6UUd2bkJDazNFNGUy?=
 =?utf-8?B?VXZtM2NoQktENmh6cEtiZWs0WXpSMUhaY0dTWHZaSjRWMFRjNGVBVzR0bEhR?=
 =?utf-8?B?WG1QVTlDOGt1dmljb08yQ1lvd1dGNWdUMEhlMjBhQjQyL2dPQ2JrUktpT2s0?=
 =?utf-8?B?NFRKUndvYzAxbHVhdWdWcEFlQzd4VWc4Z3NqWXMyQjlHYVQyY3FjWUphOUk5?=
 =?utf-8?B?VStuUEtDUEcvUHVaOEFsUU5FdGpEL3dnTDNhdWdkUUNtRUZib0tVY0trY2U3?=
 =?utf-8?B?a1N4L1BXTkNCUzJ2ZlZ2Y1VGQTViQlNNNEJVSHBGaWo2Y0NzcjE2YVU1QUdX?=
 =?utf-8?B?VUJTZk5MVGlyd29BdmlxdVhTM3VQN09udjdIT0ZwMGRRZUMvdHduMEJkS3Jy?=
 =?utf-8?B?OFRreTB4Ymo3WWxaV1VnWlMrOWNxTUUyWEFPMmFCQVBSK2JBMllUQ0JjRlVL?=
 =?utf-8?B?UTFlamVEMmVJajc3Si80cmVlWFVJK2Fmb3VtbXI4NnhMZTJNYlo1MGVCcTNs?=
 =?utf-8?B?ZGw3L1RDNm1YZW04R1FFNjFDY2p1NnlvWWVQREphOTFmR2FaeWR0U1k3Titr?=
 =?utf-8?B?eDdRMlhpaDNwNDZibzZ1SzBuNERhUjRXc0tJU0NkRlljbGFNRllyTCsya1NZ?=
 =?utf-8?B?Qm9tRjJaZ2x2YXJOMHdzM2YyN3NBd2o5WmdnRlRIS0tGYWhSVkhicGZULytI?=
 =?utf-8?B?TWsrUnFrc3JMUUFBcVNBRENjbWtVNlNpUVZ5bERDZzZiTEdUU2hYSDdpTHFZ?=
 =?utf-8?B?TG0zL1A3Y1MyUmJNMmhpOG1wUXg4RmtBQ1dZYmpLd2JlemJua2xIRUtFa2RK?=
 =?utf-8?B?WGk1cUhiYUQ2Z3F2WXZzYWUxVXY1TU9BOWRyRVpUZjNVMmxTV0ZCOHpuQVha?=
 =?utf-8?B?aEp1T1c5VHZkNGRjTGQ5VGdMbVNscnFGam5mbXZxNEZzTGNabzgxRTZ6ZzNT?=
 =?utf-8?B?dExiSnErRkMvcWNVL1BpYnlnUVh6SHl4RDU0ZlZIQnh4Zkpya1hVQThtQ1Vk?=
 =?utf-8?B?eFBjaDNMMTRzL2ZBQVN0ZWVuQUM0Tmk3MW5aLys0QkI1Qng1VUxXcTBsSTNN?=
 =?utf-8?B?WXR0RmphUVlyczVMNmdtZDNEeU5WMkdWb3JEeTFYM2k3L2xGbU9WZmNudTlK?=
 =?utf-8?B?Q1hJL2Z2eGNJYVVXYmppVGRTNVhHR1JhMEpQaG0zemVFU0ZCMDRZZDlMMXlQ?=
 =?utf-8?B?YzlUNkE1WkYyWGtzSDdlY2pBTkwwaU8xY0gyeG5JdHEvK0lVeDhjYWFlSmht?=
 =?utf-8?B?QlhpVkgvemNsOE1rZXQ2LzJ1cmE4OUMxRW52WUlZcy8xb0x5Q1dVR25WNEVw?=
 =?utf-8?B?ZnBaMWw4L0RyeXpCcWtrczE5UE1BazVkeXd6NmdJaWNQYWtJQmpOUk1wUmpF?=
 =?utf-8?B?Ynk2NTNZbTZ4bjB0dWc5czBnRDVUM1JIc0g3bjRuYmN2ZExEUTViMXNxaWY3?=
 =?utf-8?B?d2s0aHBSYWVqWHJzUzdzZitwT3hmSzg5S1QvZi9UK0d3b2h6ajFXR1NKTGlq?=
 =?utf-8?B?UnVncWp1TnZ0c2tWRmpZWFMzZmsrbS9QTGJ2S3lRQWN2RzhTRFAwcUQ5d2g0?=
 =?utf-8?B?TVN1cUl5ME5SaFRxYmM3UTBhcFJTYVdreEwyU0tDQlp1QVQxSUVLazh0M2NQ?=
 =?utf-8?B?WTNBOEx3MmVPQ1BXQmpvbXdDQVlya2grb1VFZjRFVC9zMzRSK1BuWmlPZk80?=
 =?utf-8?B?bksxd2oyME9BaUxUNDI4aGVJZmZwV0FraXR3T0hUelBadFBPMFVSK2d2dGda?=
 =?utf-8?B?THlvTTNMVFE2UjNYL1ErT09NMWdXQ1VBbEZPYVdzdU1KTlIySC9YUm9kTEhq?=
 =?utf-8?B?bzdrMlVoZUVucUhuZWJWNWlmaEhGWFl2WlI0Y1Y0KzlWcDVUZjdqaHhHdEZ5?=
 =?utf-8?B?ak5qMklRY1Rpa0FBbDhGWUgvZmF3ekdKeEFMSFJoN0ZKOFVyNTFmMGQrek5i?=
 =?utf-8?B?RERVaUlWa1g5elp6bGZ2QUxJV0pHMlYxeEkrYkVQdXBKOFZtVXY3Nkx5ZDQ2?=
 =?utf-8?B?aHM4U0ZvbnJuZ0VZYnNwNGZTL0I2OFVLM3NVOGJSZVVhNytDZ0VieGdLUjNH?=
 =?utf-8?B?YjNjd3dQL0UrbHRxVncydCtmRmcxVlVCMldNeHJCbEZCeXI4Ti95S2VTQUxo?=
 =?utf-8?B?QzVjQlZvUE5ucVoxWjBDMXNYbFlXbmF1cDRFQlg4R1NEUnV1czN4N3pkcmhX?=
 =?utf-8?Q?4XybvUeiq4N0b0XrbpHyi34=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	cuA4IITuvPv6qpXnOXR6S1gE5zs6KHSzorhP8QglzDKQsVVMtPHSsM+B+fH127EBVp1UyLAx6sWDQLt3sZEKxWkZXYyT3EmoxdZfffrRkvdOt8BVxnwi6H1u//Yzlw1wMxnUGslrefx21MDOEIvDfrQdUD1gGS6uZkjlseaxpb6IkxrO1DW3yAg+Ynj46BX2gJhdL93ehBmMnxc2//xIVpGihs0EMRD2cXSXPsvohHqZYvbwIGJO63jpuwMGBfyFPdEBavgNUXMwqU+CGvnv24GfoXIewNrLevMGKfiM/FTVGsbr+1qJH798UO6FdHH5mbrUQOUpzLO+EpZ/v3ru4vzSwPoAK5ImIj7ByMK6+fM3xpsjCqbKvPDXgOzBbwh3Zw3TzSUaeyi6BWWBtvdwMO3obTo7U4dUP2F4SFrffJKB1WSCrmMTgorHaK3ePJ16bHuHJlNi4LZ68P8IyP7kXZijjQyuZaC8jpdSKH7GvDS4yNwgpdbodwsD84L/UMKA7XdQEQIZjEs0YkEoMIDP3LWY5tx5Vfys8UTzIytIZjtEm8s/qQclODV9ffXMlNBEdi46ZdVZL2jSmxApR+ulvdBV1G/CqXpeyQnfiYzFforoiDYJmynC8ed29BZv4AhU5uz933rs3drZYs28+0MPk6J+detSBre5dgvvfsmFtDABpynOmINg5/qduLMPILwh6pcK2tZu4lK95wjx0ISGA6S++qpV7oDwDslu/Mfe71tZ6B6kPVwEDaf6waEw65VYNCs+v9WlAnIaTSCtbQA89tDW3aMVxfecFIx3lh02+GnzI+Pq7PcmFoAHYKXFFBpFkPlCIwWQNmJBKAxQoAekVA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8133ef8f-3837-4388-5184-08dbcef0ca95
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 09:09:39.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ndKLeENSQUntW2O5r8/6Z4o7Qs7hIdW/3oOD5zyqpDv4MXHACYWS4TXgRVeCjY3OPixhydgXnkirMwRsk/YbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7752
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170076
X-Proofpoint-GUID: Jz-zb_A0GDdQ8vMhPupKmxFemS24dBQG
X-Proofpoint-ORIG-GUID: Jz-zb_A0GDdQ8vMhPupKmxFemS24dBQG
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/10/2023 09:17, Daniel Borkmann wrote:
> Add several new test cases which assert corner cases on the mprog query
> mechanism, for example, around passing in a too small or a larger array
> than the current count.
> 
>   ./test_progs -t tc_opts
>   #252     tc_opts_after:OK
>   #253     tc_opts_append:OK
>   #254     tc_opts_basic:OK
>   #255     tc_opts_before:OK
>   #256     tc_opts_chain_classic:OK
>   #257     tc_opts_chain_mixed:OK
>   #258     tc_opts_delete_empty:OK
>   #259     tc_opts_demixed:OK
>   #260     tc_opts_detach:OK
>   #261     tc_opts_detach_after:OK
>   #262     tc_opts_detach_before:OK
>   #263     tc_opts_dev_cleanup:OK
>   #264     tc_opts_invalid:OK
>   #265     tc_opts_max:OK
>   #266     tc_opts_mixed:OK
>   #267     tc_opts_prepend:OK
>   #268     tc_opts_query:OK
>   #269     tc_opts_query_attach:OK
>   #270     tc_opts_replace:OK
>   #271     tc_opts_revision:OK
>   Summary: 20/0 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Looks like it does a great job of exercising the codepaths in
bpf_mprog_query()!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  .../selftests/bpf/prog_tests/tc_opts.c        | 131 +++++++++++++++++-
>  1 file changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/tc_opts.c b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
> index ca506d2fcf58..51883ccb8020 100644
> --- a/tools/testing/selftests/bpf/prog_tests/tc_opts.c
> +++ b/tools/testing/selftests/bpf/prog_tests/tc_opts.c
> @@ -2471,7 +2471,7 @@ static void test_tc_opts_query_target(int target)
>  	__u32 fd1, fd2, fd3, fd4, id1, id2, id3, id4;
>  	struct test_tc_link *skel;
>  	union bpf_attr attr;
> -	__u32 prog_ids[5];
> +	__u32 prog_ids[10];
>  	int err;
>  
>  	skel = test_tc_link__open_and_load();
> @@ -2599,6 +2599,135 @@ static void test_tc_opts_query_target(int target)
>  	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
>  	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
>  
> +	/* Test 3: Query with smaller prog_ids array */
> +	memset(&attr, 0, attr_size);
> +	attr.query.target_ifindex = loopback;
> +	attr.query.attach_type = target;
> +
> +	memset(prog_ids, 0, sizeof(prog_ids));
> +	attr.query.prog_ids = ptr_to_u64(prog_ids);
> +	attr.query.count = 2;
> +
> +	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
> +	ASSERT_EQ(err, -1, "prog_query_should_fail");
> +	ASSERT_EQ(errno, ENOSPC, "prog_query_should_fail");
> +
> +	ASSERT_EQ(attr.query.count, 4, "count");
> +	ASSERT_EQ(attr.query.revision, 5, "revision");
> +	ASSERT_EQ(attr.query.query_flags, 0, "query_flags");
> +	ASSERT_EQ(attr.query.attach_flags, 0, "attach_flags");
> +	ASSERT_EQ(attr.query.target_ifindex, loopback, "target_ifindex");
> +	ASSERT_EQ(attr.query.attach_type, target, "attach_type");
> +	ASSERT_EQ(attr.query.prog_ids, ptr_to_u64(prog_ids), "prog_ids");
> +	ASSERT_EQ(prog_ids[0], id1, "prog_ids[0]");
> +	ASSERT_EQ(prog_ids[1], id2, "prog_ids[1]");
> +	ASSERT_EQ(prog_ids[2], 0, "prog_ids[2]");
> +	ASSERT_EQ(prog_ids[3], 0, "prog_ids[3]");
> +	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
> +	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
> +	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
> +	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
> +
> +	/* Test 4: Query with larger prog_ids array */
> +	memset(&attr, 0, attr_size);
> +	attr.query.target_ifindex = loopback;
> +	attr.query.attach_type = target;
> +
> +	memset(prog_ids, 0, sizeof(prog_ids));
> +	attr.query.prog_ids = ptr_to_u64(prog_ids);
> +	attr.query.count = 10;
> +
> +	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
> +	if (!ASSERT_OK(err, "prog_query"))
> +		goto cleanup4;
> +
> +	ASSERT_EQ(attr.query.count, 4, "count");
> +	ASSERT_EQ(attr.query.revision, 5, "revision");
> +	ASSERT_EQ(attr.query.query_flags, 0, "query_flags");
> +	ASSERT_EQ(attr.query.attach_flags, 0, "attach_flags");
> +	ASSERT_EQ(attr.query.target_ifindex, loopback, "target_ifindex");
> +	ASSERT_EQ(attr.query.attach_type, target, "attach_type");
> +	ASSERT_EQ(attr.query.prog_ids, ptr_to_u64(prog_ids), "prog_ids");
> +	ASSERT_EQ(prog_ids[0], id1, "prog_ids[0]");
> +	ASSERT_EQ(prog_ids[1], id2, "prog_ids[1]");
> +	ASSERT_EQ(prog_ids[2], id3, "prog_ids[2]");
> +	ASSERT_EQ(prog_ids[3], id4, "prog_ids[3]");
> +	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
> +	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
> +	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
> +	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
> +
> +	/* Test 5: Query with NULL prog_ids array but with count > 0 */
> +	memset(&attr, 0, attr_size);
> +	attr.query.target_ifindex = loopback;
> +	attr.query.attach_type = target;
> +
> +	memset(prog_ids, 0, sizeof(prog_ids));
> +	attr.query.count = sizeof(prog_ids);
> +
> +	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
> +	if (!ASSERT_OK(err, "prog_query"))
> +		goto cleanup4;
> +
> +	ASSERT_EQ(attr.query.count, 4, "count");
> +	ASSERT_EQ(attr.query.revision, 5, "revision");
> +	ASSERT_EQ(attr.query.query_flags, 0, "query_flags");
> +	ASSERT_EQ(attr.query.attach_flags, 0, "attach_flags");
> +	ASSERT_EQ(attr.query.target_ifindex, loopback, "target_ifindex");
> +	ASSERT_EQ(attr.query.attach_type, target, "attach_type");
> +	ASSERT_EQ(prog_ids[0], 0, "prog_ids[0]");
> +	ASSERT_EQ(prog_ids[1], 0, "prog_ids[1]");
> +	ASSERT_EQ(prog_ids[2], 0, "prog_ids[2]");
> +	ASSERT_EQ(prog_ids[3], 0, "prog_ids[3]");
> +	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
> +	ASSERT_EQ(attr.query.prog_ids, 0, "prog_ids");
> +	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
> +	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
> +	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
> +
> +	/* Test 6: Query with non-NULL prog_ids array but with count == 0 */
> +	memset(&attr, 0, attr_size);
> +	attr.query.target_ifindex = loopback;
> +	attr.query.attach_type = target;
> +
> +	memset(prog_ids, 0, sizeof(prog_ids));
> +	attr.query.prog_ids = ptr_to_u64(prog_ids);
> +
> +	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
> +	if (!ASSERT_OK(err, "prog_query"))
> +		goto cleanup4;
> +
> +	ASSERT_EQ(attr.query.count, 4, "count");
> +	ASSERT_EQ(attr.query.revision, 5, "revision");
> +	ASSERT_EQ(attr.query.query_flags, 0, "query_flags");
> +	ASSERT_EQ(attr.query.attach_flags, 0, "attach_flags");
> +	ASSERT_EQ(attr.query.target_ifindex, loopback, "target_ifindex");
> +	ASSERT_EQ(attr.query.attach_type, target, "attach_type");
> +	ASSERT_EQ(prog_ids[0], 0, "prog_ids[0]");
> +	ASSERT_EQ(prog_ids[1], 0, "prog_ids[1]");
> +	ASSERT_EQ(prog_ids[2], 0, "prog_ids[2]");
> +	ASSERT_EQ(prog_ids[3], 0, "prog_ids[3]");
> +	ASSERT_EQ(prog_ids[4], 0, "prog_ids[4]");
> +	ASSERT_EQ(attr.query.prog_ids, ptr_to_u64(prog_ids), "prog_ids");
> +	ASSERT_EQ(attr.query.prog_attach_flags, 0, "prog_attach_flags");
> +	ASSERT_EQ(attr.query.link_ids, 0, "link_ids");
> +	ASSERT_EQ(attr.query.link_attach_flags, 0, "link_attach_flags");
> +
> +	/* Test 7: Query with invalid flags */
> +	attr.query.attach_flags = 0;
> +	attr.query.query_flags = 1;
> +
> +	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
> +	ASSERT_EQ(err, -1, "prog_query_should_fail");
> +	ASSERT_EQ(errno, EINVAL, "prog_query_should_fail");
> +
> +	attr.query.attach_flags = 1;
> +	attr.query.query_flags = 0;
> +
> +	err = syscall(__NR_bpf, BPF_PROG_QUERY, &attr, attr_size);
> +	ASSERT_EQ(err, -1, "prog_query_should_fail");
> +	ASSERT_EQ(errno, EINVAL, "prog_query_should_fail");
> +
>  cleanup4:
>  	err = bpf_prog_detach_opts(fd4, loopback, target, &optd);
>  	ASSERT_OK(err, "prog_detach");

