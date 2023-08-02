Return-Path: <bpf+bounces-6695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950976CBAA
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 13:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E4A281D45
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 11:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9876FC5;
	Wed,  2 Aug 2023 11:22:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4259263AA
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 11:22:36 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212DC1FC3
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 04:22:29 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372ASswN023115;
	Wed, 2 Aug 2023 11:22:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=I6EWhbVaz3ozA2iJU79y2WGbShmIVWunKo5ebcr+Cv0=;
 b=JMpUadU6ruW8xA4GEtL2FYgkWtsqLQ3rTVu/EE02Ej/ZMXotwP3lTak8UxKnB0G4mgtL
 0hlSnevuWn5vFUPg3YeZK4L5Kp8NyKJiyaJwRJzXr50yS/JtpypgiTI2Zu74bDFjBLaS
 H5IIrqI+qK/uNV8LXWyCdJ4LXblp3aLmASyn2/wLqixWdKLAS+nMWfHB56x6p4iZUiDo
 LWohXy0ZPI0Scbdo9E5B2KvmoWvOHC3e1J8oLHrsnFIiAqKBYhU5fHCuiXxUVkuBydra
 RdLcWN6NQShYaYkXO6u9OtkEyqdz+fX9P3Fzml4Qvopzzk5VFy73/HAAA7ZqmayYYRE8 AQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2f1sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 11:22:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3729fj3b006671;
	Wed, 2 Aug 2023 11:22:08 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s77tnsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Aug 2023 11:22:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPR5joMhqMQzxeJnxKYmVL7DreugyL5L+OeZor8N2FQVqLlpjoBJ6Y2ICwJ2vkvxkN5izFHRQ3zF47ZYVH83Seu03DMeYS5+zn+Kss6eQKCotVO/8S4EReB1+WRlNtdO2lph3/Lyjy8VZZV/2us03qDVprRpYu77ehCQwPATXm37hNN13vpPW8F4uwelzP0kA+jpXalLRH5Hb360E4v8NWVqwgJgJHXKwXXvgJOS5p7fx0Aqn2FBV247+Il0mFlryVaKK+crvxc/2jrN0zZqnKY1xAtq4iOeuy7HhIzbbFUEWKjqhYfUVnimomsFckNsaOhb7VjnoOnlFb7yG/XNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6EWhbVaz3ozA2iJU79y2WGbShmIVWunKo5ebcr+Cv0=;
 b=PCEQGsC888K8KREl9PTyFWTFS7jbet2MD3XiAx3uT4U8dVI7Rgy+QksNgJSZWcrLsgLRKphHwN0bF5HeTRvkWGe0D8+u3LH+uZaMzNLsXu/L/8VsVxX6wyO+rnqR20bL6ypy3o0+Ykb7vPXkKFZQAjqOPaFeDqCtqvlY6dcy839pRZZPqEd4qDEDe58x99fkjPeLGNRepI7aZ4jSmb9exqv3FWYfulf+7Pcr5NIwb1uyLoRym/Ph5o/vw+lQvX7TyLccSBFCvk0Fuyg8mjd8KPDnzBJQbpAr2o74SkAQr7fiDIL5i9OTs1JdaGE3CZCghALyLc2IXmb72nYoUGEMFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6EWhbVaz3ozA2iJU79y2WGbShmIVWunKo5ebcr+Cv0=;
 b=Wf7BGT1oGtAOJQklNAm1sylVNUH8ssGC5Yc90G9jiNkcUh1GkLwtREDS2OeNbbkqkPkl8X9xPIggv5BdENntlvrMjQ1MdKhnI3BoVPra7BjoZ9XaGl1AYDogOIPljq44ZbnNJW7I1nfqCmNZG6Ml62kSFU+8KsSnRtEIObYUZl4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB5829.namprd10.prod.outlook.com (2603:10b6:510:126::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Wed, 2 Aug
 2023 11:22:05 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.019; Wed, 2 Aug 2023
 11:22:05 +0000
Message-ID: <e34ef898-28ca-6d17-ff5e-889e9f046ea6@oracle.com>
Date: Wed, 2 Aug 2023 12:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next 1/3] bpf: Add support for bpf_get_func_ip helper
 for uprobe program
Content-Language: en-GB
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20230801073002.1006443-1-jolsa@kernel.org>
 <20230801073002.1006443-2-jolsa@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230801073002.1006443-2-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0359.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::22) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB5829:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d67c1f-5448-457b-ce1d-08db934ab366
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+gOcXQXDDoesaUY5tMvegsixvdnITS3Soq5Yzhv2ekvthZ9Dww9HEwIze31c4uYcCq2U+Yf5lPP5uyCLjKMi4cfCoyVWqvmAHLftSWF12YM7BK6eiOdhizUHdrCvgHNfXJZXzg+1fTjiGMXPtMo98tsdaow9AQrkvhhWCPmDJzXV2tmLgCQGKjQnHPHwjTQ+R5JKIoheamPDPj9uK+/CjjNcFmJB1ccaVtcntrbzgz+5aQmTevLNv4iAPPBA0Q9W0ak9mfkyl6tur9usRzj0wnfRIfH073rl7enH/0u/1X2OVoP4pypMnQC21RPnhKhChSkofIzBQA2JWSJKWmI1qONUG8qIo0QtUeLJq83+6h1/gcAp/PFO4+ol6dcbf+IQ2ky9ohjz0fj8uGKze7CWqxTjbJjZK8OMHANVayA4/3SzqBr1YlmLFltX0St3rZSLYiDiqw0z8Hj0VU4SljDl7RjKS5a7jmugCf+6nSumGvJEN1xwQzNm+lcZd1l9uAGqsBaRhnCh00qhOVESbn6VoG7KL2cAKeQieKZAdx5qFImj0dpX1HUSwUDg0ekGueCBwNrXvcpxn5k1egkC7pKr6vq0nMDQUhBb7AoeCjlik2jZ+AUISGxu6K3F1G6J5Ebc5xj+FaQ6FEmow6Ixzrw+Lg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(44832011)(966005)(6512007)(6486002)(36756003)(53546011)(2616005)(6506007)(83380400001)(186003)(66946007)(66556008)(7416002)(110136005)(54906003)(41300700001)(86362001)(38100700002)(31696002)(66476007)(4326008)(5660300002)(8676002)(8936002)(316002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXMwMzh1c3pQTnJuM21mT2Y4bGNXdXdnNlFXaEFHallCY2ZYOVZ3MUs2REs1?=
 =?utf-8?B?a0diRUZEWUMycmJwVUZOblFEd3VtOE9CaHNJTWI1YnpMWnk5MXIvOGhWK0ov?=
 =?utf-8?B?azdVMzUyczVXRDc4bHRrSUt6d250Vk0ya0pmV3NuNHN0Nzh6TTNFdFRuaHpK?=
 =?utf-8?B?V0xpT0p2U0pMakNoU0FCelFoMzdFQ1NRNmRGTm0vbnF0ZHlMc2FnOVZyQTEr?=
 =?utf-8?B?MndVcjgxbzJpRWh2WWpmb2g3MW4xVmRVQkRQci9rUnBGSmZFQlBNbU9iMysr?=
 =?utf-8?B?cXhQeFAxak9EdksyTVpPSzF6WVkrM1lGYzliYkFpMDBWMGpPMGh6YmlOdy9Z?=
 =?utf-8?B?MVFVbE5USC91aHJ3aDR0YS9GWVZtSEVvNjZjNVFkbkZKazF2MTJNYzA0eGVC?=
 =?utf-8?B?b1J5N2lSUEpHa2dnTVdOcmJPVHJaTUNVdVQ5dUVjRTJ5VFE5VTRhSnZCWXJl?=
 =?utf-8?B?Uk80RHBzNlN4OEVibUJ3K0o1RHVjOGNsTThwVmw2VENkUWpzL0RoSlhZNm5O?=
 =?utf-8?B?d25CcXlaSmVRSk55TzBUckIveUpPUVBOaEEwTFFJNC93V2dhSm9kTTRObGJl?=
 =?utf-8?B?VGFZaUJqK3RIcGdiQkhibmJ5eGlES0xlcWdMU3RZdzdwNGN4Y3dNYTJWQnVo?=
 =?utf-8?B?Qjk3VWxaS2ozZnl1dE4xR3QyUnJBRExGcTJ4bk92UExqWjdKNFM2QTdxSThG?=
 =?utf-8?B?VFltWWEvMnJMc1dnYVVpUlF1cnR3QlNmejdQRG8wV3orN091Q1MrV3QyNlBi?=
 =?utf-8?B?d3luWlc2d2lXVVFqZ2RDeXVENENrandQOTQzeFRLTHVQK3lvc1VrT3VhMVRo?=
 =?utf-8?B?eVY2UEVKeGp4eXRhUWcwWG1UcFJ4K0Y2WVk4YmxaQWw5K2NJa2VMeUdrZFgy?=
 =?utf-8?B?Y1JPWjB1UHhTNVVZSlZ4OXU1STFLVlhBT0pIMHlIS044RlZJZjdKNEVXUVFq?=
 =?utf-8?B?WE1zZlNrVERMMVE4WDlIMHdRaGpjSGpBeFJPMjFvVGhraDJVT2k4Mysya2VK?=
 =?utf-8?B?TG9tbEFwaUJ5SXR6UzZDdlowR1hjc0xmVXhsdWMvVU1hdFhsZWFoSEtiM0J3?=
 =?utf-8?B?QXpEZGlkdUtuS3F6NGhHQTA0R05xUUo1c0JZKzBoUERuakR3ZW5ZRUwwUXl6?=
 =?utf-8?B?KzhyellFMkNYcGI1c29GZkdaeEJESTYrSUwzSWV0L0xORTJSMEVKTStaaytz?=
 =?utf-8?B?QjJxazBuVWVHZFNwWDdkdmgvNTgwZVRRTjdnbGhWYXdsdkkxZlEzZjEwTzJR?=
 =?utf-8?B?NnV5UTdOb1UrQWl3TVphOVhObERkcnRGbmxmTUZaVStqNFJJVVcvMlFHL1Bj?=
 =?utf-8?B?TThCT3B6S01taE45eE1ROCtQMXgvVXNlMlZldWVmVlVqdmpSWEtJYmdxUnYz?=
 =?utf-8?B?V25peG9VcVlPWVIrZjlJVFVOMUVWQ0gxSE9RMGw2aXZYalVpMHVtUnZ4R28w?=
 =?utf-8?B?cGJXY2hwVXliK2tHeGt0VFdIVzVqbEJ2L255MkhQZ2ZHSC9rSmlaYnI5ZjRj?=
 =?utf-8?B?K3NqN214bmI1Q3ZLYk5DUHM1UW9EK3YzMWh4ZDJMMDZSVDdyclk4enBLK3JC?=
 =?utf-8?B?czM2VCtkOGJjeHE1eHUyeER0d0pZQUNBNzN1SDNONjlBelZzNHdZZ2MwWkdL?=
 =?utf-8?B?d0plbHM4SmtkWEVKY2gyMzJKNnhaYXdoZWQ1U0I0ZlNuWnFrWll0d1N5c2x6?=
 =?utf-8?B?UXNhWGtzc0dyak55anlnSjVGTzFxUEZDVnMwU2VoZG5qdjJtTmhnWkJYNURT?=
 =?utf-8?B?TWxCZ1AzV1VlV0prUTY4L2ZSWTNrQ0h0T0lwZCtYcEorMEtrdTF3cEJlemM5?=
 =?utf-8?B?M3QxOXZvcG9uSUZJditheWhQQ0pvK3lha2dLK0pqVUw1ekxGNmE0T29lVXd4?=
 =?utf-8?B?aE4zRkR6aXNzZk1aQlZkcVQ5WUhreHBNdk9mcFN6MW1hYUs5VmcyaWNwbnlk?=
 =?utf-8?B?MjVSczhoMUgvc3hoUFk1Tysrb1R5QzB6ZFppL2M2eUhnWFQ0SG9SZFBoL1Fw?=
 =?utf-8?B?b3JBaU9INUYyV1ZReTRNdW9zSkxrSytZaCtydjhqcXNuT0pXZ3IxMFpsMFZs?=
 =?utf-8?B?c3R3dlRkMmxiaDd4czg5MDZ1VWZqZ0NhaUhwdGIycE9hcjNtY2NJUEh3cEdk?=
 =?utf-8?B?Nk5wTEtxRTBJR0lCYjNhbThIN2ZITnJXUVMvVnVNMVZCN0hqazZJRTBMTnJr?=
 =?utf-8?Q?1tsMnEzzLEbdu56u7AyZYrA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?WHk4RUpKZm5vVWQ5aWFUSHQ3bWZ0dDJsUC95OGsxNzBGUklodi9jTWtFSDNj?=
 =?utf-8?B?ZVhEWUxuaGwxT2xPMXJDZnBmaURtZm82M2hkUk5nU1hVdGVhaThrWERiQnpJ?=
 =?utf-8?B?dytGNXpzN2JCdHo5eXNqUXBOZHVYUG83VmVlSTNQTHBFNWJFTVUyMysrdTRM?=
 =?utf-8?B?MXRBT1dHM0RiMFpRVmV0eVptZzdHZUNlcmlIZWxxR3JjVVEzNGRWL0ZXQlJr?=
 =?utf-8?B?TERONWFiM2tpZnNsOHRieTNTYURTOW9MbEJlc01JdkFKOWp0dVVocG1GSzZP?=
 =?utf-8?B?VEoxdTZ1bks5eFV2cS85WHpTdE01MEJKa2RGdzI4bDZaMldnWFhYMDVFcXJK?=
 =?utf-8?B?c1d5bnJzKzVObHRZZlJhZkdGeS9scnlTU25sVmYxTVRuNU1yMjJScS95Sjdn?=
 =?utf-8?B?LytjSHZVZGorVXBPbUJlVS9yNWF2eXV6Yk5RZmFyY2JkOG1UVS9iZnBZaEVl?=
 =?utf-8?B?VWt5TVQ4ZlZKcHZHWExyeGdOMXpqaUt4VEpJYlVZU2NlVU95QndoRkFSd1Z2?=
 =?utf-8?B?YnMvMko3VlQzcmI0NUR0dWxmWFhvY2trTWo5UlNzZi9VbmdidWhjMEh1NEo0?=
 =?utf-8?B?ZlpJdUZMaWZacjZ0Q2pWM3BncUE2VXZNUy9WVUI0YmtuTUZGMVMyVWdJT3N2?=
 =?utf-8?B?NlhmV2ZkdmFHS0hHanJyZUdtdG5lOXZWNVFrT1F4QlAva0JlSWRaQzRFZW5W?=
 =?utf-8?B?L1pEV3hLb3l6MFJ1MlBJcUlsemE3N2ZGamxMc2hOckVxektjODdmcjV4bXFG?=
 =?utf-8?B?WVVTMzl6ejVVODFHdnN2U1NtOUpJUklVRng5NmpHR0ZjMk1KbDF3Yi9wallO?=
 =?utf-8?B?TU1oK3BhaU41YUEreEZxRThZZytDYlFlMEpCVEdrRHUrNWErTFhmb1FVRDNZ?=
 =?utf-8?B?WDNkTHZkd2ZhUGtrL2V5Mm1Pc1ArWVZzR1FmQmR0Z05CYTNIRkF4cTEvbmVX?=
 =?utf-8?B?NGJqTHpabitnc0FpTjlkQTNTTFhwZE53UklTMHpTRlBaTkpFVjNyOTVOVnN2?=
 =?utf-8?B?Wi9tWkFIck00ZzVPUTA1b0d4NlpVUFJURG9XVWs2M1NQd3I4bFhlS2F0RzVT?=
 =?utf-8?B?dVp1S3FTNng0MlhacUhiYk5QdlpBRWVzLzdlOWptM2t6SEswYnVobnNuMERS?=
 =?utf-8?B?TEN1VGFoQ2JJdHdjcXhyTHIwVHpMTWtZZkJEdDJIdnFCL1NQSmpJWVlpSUVO?=
 =?utf-8?B?ZlVrRy82NUJpbzRtcGdnZHQrU29UVzQ3WVVOT1lNRFhzTnZFMW95bWpxMXJS?=
 =?utf-8?B?SGpkRjhKNlF6ZWFGRFdnSU1KZ0FwRTlXaHAxR0lwTHBZZ2I0UT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d67c1f-5448-457b-ce1d-08db934ab366
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:22:05.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCYPvnf21hOvTzMSGRLhq+t6YI0D9BD9BgtXDidZQ2Za4e4KzbHxHhGP3hlJp9llignLqwn8wMJF0t1+QG52ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5829
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020101
X-Proofpoint-ORIG-GUID: 3OwGneGzkEbRY56Z0RJwqbmYg3iggVuV
X-Proofpoint-GUID: 3OwGneGzkEbRY56Z0RJwqbmYg3iggVuV
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 08:30, Jiri Olsa wrote:
> Adding support for bpf_get_func_ip helper for uprobe program to return
> probed address for both uprobe and return uprobe.
> 
> We discussed this in [1] and agreed that uprobe can have special use
> of bpf_get_func_ip helper that differs from kprobe.
> 
> The kprobe bpf_get_func_ip returns:
>   - address of the function if probe is attach on function entry
>     for both kprobe and return kprobe
>   - 0 if the probe is not attach on function entry
> 
> The uprobe bpf_get_func_ip returns:
>   - address of the probe for both uprobe and return uprobe
> 
> The reason for this semantic change is that kernel can't really tell
> if the probe user space address is function entry.
> 
> The uprobe program is actually kprobe type program attached as uprobe.
> One of the consequences of this design is that uprobes do not have its
> own set of helpers, but share them with kprobes.
> 
> As we need different functionality for bpf_get_func_ip helper for uprobe,
> I'm adding the bool value to the bpf_trace_run_ctx, so the helper can
> detect that it's executed in uprobe context and call specific code.
> 
> The is_uprobe bool is set as true in bpf_prog_run_array_sleepable which
> is currently used only for executing bpf programs in uprobe.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> [1] https://lore.kernel.org/bpf/CAEf4BzZ=xLVkG5eurEuvLU79wAMtwho7ReR+XJAgwhFF4M-7Cg@mail.gmail.com/
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf.h            |  5 +++++
>  include/uapi/linux/bpf.h       |  7 ++++++-
>  kernel/trace/bpf_trace.c       | 21 ++++++++++++++++++++-
>  kernel/trace/trace_probe.h     |  5 +++++
>  kernel/trace/trace_uprobe.c    |  5 -----
>  tools/include/uapi/linux/bpf.h |  7 ++++++-
>  6 files changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ceaa8c23287f..8ea071383ef1 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1819,6 +1819,7 @@ struct bpf_cg_run_ctx {
>  struct bpf_trace_run_ctx {
>  	struct bpf_run_ctx run_ctx;
>  	u64 bpf_cookie;
> +	bool is_uprobe;
>  };
>  
>  struct bpf_tramp_run_ctx {
> @@ -1867,6 +1868,8 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
>  	if (unlikely(!array))
>  		return ret;
>  
> +	run_ctx.is_uprobe = false;
> +
>  	migrate_disable();
>  	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
>  	item = &array->items[0];
> @@ -1906,6 +1909,8 @@ bpf_prog_run_array_sleepable(const struct bpf_prog_array __rcu *array_rcu,
>  	rcu_read_lock_trace();
>  	migrate_disable();
>  
> +	run_ctx.is_uprobe = true;
> +
>  	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
>  	if (unlikely(!array))
>  		goto out;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 70da85200695..d21deb46f49f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>   * u64 bpf_get_func_ip(void *ctx)
>   * 	Description
>   * 		Get address of the traced function (for tracing and kprobe programs).
> + *
> + * 		When called for kprobe program attached as uprobe it returns
> + * 		probe address for both entry and return uprobe.
> + *
>   * 	Return
> - * 		Address of the traced function.
> + * 		Address of the traced function for kprobe.
>   * 		0 for kprobes placed within the function (not at the entry).
> + * 		Address of the probe for uprobe and return uprobe.
>   *
>   * u64 bpf_get_attach_cookie(void *ctx)
>   * 	Description
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c92eb8c6ff08..7930a91ca7f3 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1057,9 +1057,28 @@ static unsigned long get_entry_ip(unsigned long fentry_ip)
>  #define get_entry_ip(fentry_ip) fentry_ip
>  #endif
>  
> +#ifdef CONFIG_UPROBES
> +static unsigned long bpf_get_func_ip_uprobe(struct pt_regs *regs)
> +{
> +	struct uprobe_dispatch_data *udd;
> +
> +	udd = (struct uprobe_dispatch_data *) current->utask->vaddr;
> +	return udd->bp_addr;
> +}
> +#else
> +#define bpf_get_func_ip_uprobe(regs) (u64) -1

Small thing - I don't think this value is exposed to users due to the
run_ctx->is_uprobe predicate, but would it be worth using -EOPNOTSUPP
here maybe?

> +#endif
> +
>  BPF_CALL_1(bpf_get_func_ip_kprobe, struct pt_regs *, regs)
>  {
> -	struct kprobe *kp = kprobe_running();
> +	struct bpf_trace_run_ctx *run_ctx;
> +	struct kprobe *kp;
> +
> +	run_ctx = container_of(current->bpf_ctx, struct bpf_trace_run_ctx, run_ctx);
> +	if (run_ctx->is_uprobe)
> +		return bpf_get_func_ip_uprobe(regs);
> +
> +	kp = kprobe_running();
>  
>  	if (!kp || !(kp->flags & KPROBE_FLAG_ON_FUNC_ENTRY))
>  		return 0;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 01ea148723de..7dde806be91e 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -519,3 +519,8 @@ void __trace_probe_log_err(int offset, int err);
>  
>  #define trace_probe_log_err(offs, err)	\
>  	__trace_probe_log_err(offs, TP_ERR_##err)
> +
> +struct uprobe_dispatch_data {
> +	struct trace_uprobe	*tu;
> +	unsigned long		bp_addr;
> +};
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 555c223c3232..fc76c3985672 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -88,11 +88,6 @@ static struct trace_uprobe *to_trace_uprobe(struct dyn_event *ev)
>  static int register_uprobe_event(struct trace_uprobe *tu);
>  static int unregister_uprobe_event(struct trace_uprobe *tu);
>  
> -struct uprobe_dispatch_data {
> -	struct trace_uprobe	*tu;
> -	unsigned long		bp_addr;
> -};
> -
>  static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs);
>  static int uretprobe_dispatcher(struct uprobe_consumer *con,
>  				unsigned long func, struct pt_regs *regs);
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 70da85200695..d21deb46f49f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5086,9 +5086,14 @@ union bpf_attr {
>   * u64 bpf_get_func_ip(void *ctx)
>   * 	Description
>   * 		Get address of the traced function (for tracing and kprobe programs).
> + *
> + * 		When called for kprobe program attached as uprobe it returns
> + * 		probe address for both entry and return uprobe.
> + *
>   * 	Return
> - * 		Address of the traced function.
> + * 		Address of the traced function for kprobe.
>   * 		0 for kprobes placed within the function (not at the entry).
> + * 		Address of the probe for uprobe and return uprobe.
>   *
>   * u64 bpf_get_attach_cookie(void *ctx)
>   * 	Description

