Return-Path: <bpf+bounces-11928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82157C5902
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDE11C20EF2
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DDE03C691;
	Wed, 11 Oct 2023 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WhhrFNTA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ovpPG+1Y"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BB30F88;
	Wed, 11 Oct 2023 16:20:23 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD193;
	Wed, 11 Oct 2023 09:20:20 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BGErml013909;
	Wed, 11 Oct 2023 16:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=g6X9GaeBUNvsr1oIgH1dkcmdZAuZZNLSI0QqdqguSYk=;
 b=WhhrFNTAB9AxmPuCCeDT2iRZK9nnplK1eQv/dT61MT+Mf6ahLTRJOi0sVNo9YKLrFFtg
 GTBAtviBkbVIPadN4VF7Tjy03QVDAC96EjuekG8ppc0dv9h4wLS/oUgY9LVUC2Xp2cfm
 WPiufh06bk3MCqQrSnzUxYbwH0KZ/h2DukfJ3dxO3HGF7RtV2Qm1/PcPPcdq/deAPNY+
 k6UyD3AYh1yzAjEADPMV2hr0/LmOKuPpg1YQUuuDZsi0Gw+BF46rbmQowyZdbdE5NdQ7
 dCXh6dT9thzquysTMj7FJT05oQFds1cObuS4WstbBoQ0xzWU1eRbnnLwvb66CApuEWy8 6Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tmh90wyjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 16:19:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BF8fkX035358;
	Wed, 11 Oct 2023 16:19:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsejt9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 16:19:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOOBgs1Q+jTOumb3in50p0E42WIy1zTBwNXc1gE31HtsoOeb5r2e1PUPbNl67K+/ZOxoha2tqHZ0/Sk1ArZJogM9c7ZHGKC5rUXFYOOzj2e0LhuiwEkOfIQ91ItqVwt8DEdpt1JXQiAK/xCyn8gOJCfRzjfIsoFrTU+vy12LVgFA88td41YIHnSXQ9H593Tt6xwxkCt86VjA/aaPLs8pPPiy+b5b1Lfo3ltEWncN/NVYW/gEfVInllETYwJNn12bw6VR4Z/GUlZ90fyPPdg6P3yhnp1fhKUKoybb5UynDPT5SFXkHCsX18Cy7fJ8yQSGIMp8Ks9LK2Vw+eDRNo1LnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6X9GaeBUNvsr1oIgH1dkcmdZAuZZNLSI0QqdqguSYk=;
 b=b3fVdltgd0iJtyqP2DgI0Kol1C8zbdO76fsRaxEPF28sP7D7ieq0CPLfWNn2/iO6Igq3/uJtBGbVsWwb5b5+4kf7iLDvt37H87kW3Ki4d5VK/ZB7ACewVG0aaW0tLC1jaZYaZgusj58Q+xk4T6zVkGLa9NIE9Gr+jkO6ZXC5tF7vsGWDNOiLVCpy8rPH+RJL62aD8cXJsa7LjMX0n0zPwpLzMKxgBjgyVX72M0AA794A6GdFb0A1WBVXh5LQT8yi3SXOM82Cy6mwL5C7Vup1ICPBLhUYv8ZIjy/iCfsR/k80e/yAQoEfPpioup5zK845A4qmdg4J/cZfrvBr/QCNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6X9GaeBUNvsr1oIgH1dkcmdZAuZZNLSI0QqdqguSYk=;
 b=ovpPG+1Y18tS0FaRZCewwMtt0Yb3z55lJlKOcFVuSXvvN0p/RfexiWqXeDEiETai7leFggoEes7tojAVtCQjVT3qaVsVoEzGP/nCfpaGZeoxuW4Hz34m8fOKGulW25YrWW36AY3BV9k+83SAKh5tI37yVfVRsWRFFmNICKW8bSE=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 DM4PR10MB6061.namprd10.prod.outlook.com (2603:10b6:8:b5::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.36; Wed, 11 Oct 2023 16:19:38 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 16:19:38 +0000
Message-ID: <3fdfffc5-6fd2-1fa4-c523-04333c538d49@oracle.com>
Date: Wed, 11 Oct 2023 17:19:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] bpf/btf: Move tracing BTF APIs to the BTF library
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <169694605862.516358.5321950027838863987.stgit@devnote2>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <169694605862.516358.5321950027838863987.stgit@devnote2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0355.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::18) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|DM4PR10MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: a92bbb4e-5f10-4c0f-8f16-08dbca75dd86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	18TyywCw+ttTDQtzusXt9pT5ysNL3jpni96I2hgmRdxz1kSmWdwqqfNTlQFf+J8pM0Rwj1XF9Q/BomDzjl+pgujE4GUdLHnaFA5QLnsZ1jG4fpDbbAT28+9k2MTtDwlgPtV7YvGmmDRDYdyh0GSCdsg7JVjc1dN3ks0uW3m/XeOL05IJMEi5AJGIlLmiJPjTdclo28SBwlSAlFxd1mLxry4XT1SURY/sYql4mQrcpO/Olhe1RAKoNFkNph9TRAAWHUPeMrAs8PqojMHm7o6ys/hmS3qOb3BDkN5DxxSKaI/ZcWXoqdcSrPiEo19siFse5FfRtv4E2wZhdc5JP5tcVtTHD1TMZfM1qf/5s2nbQAzzaQ5xXA8ky+NZE7t1bqz/KvSU5sz2UooJxA5NFM1MAdgMF/OyadJsOFDmQKrRc35pFHXVfUNDBxWuGao6/uwC9gL9sJPI8NRRDfFzGSmpp8IA1GMUjh53n/PUYqozG/+LDS2fV68SlR7gS9b6S4gROoE3DUGTQdCibLvkRsB4fNmXKHiAdvmQLvzopYvosx3W/6q/fyVJh4ck5URzjRiUuGz5nJoPvPj+zObGa/GmIUKXqXh/fKTeFeDxYwH8vokCaiyVJ9KjCrxwAEfOkROx+JKdRbXdJA02e0P1kN0tQw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(53546011)(83380400001)(2616005)(110136005)(66556008)(66476007)(316002)(41300700001)(6666004)(66946007)(6512007)(6486002)(478600001)(2906002)(5660300002)(30864003)(4326008)(6506007)(8936002)(44832011)(8676002)(38100700002)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVFnTGN2U0F2WnQvOHVuQ3RvSmt0b0FUVGlTNUoyd3BWL1UrbmkyeFVYYVhB?=
 =?utf-8?B?UGVtaEh6L2lodGo4QTBrZUFRMHRlN2V6Q0FlMCtyVlBmdnR6QXJPZzh4a2Nr?=
 =?utf-8?B?ajVsSGViTkIxSld0dHBIQk5BblIycU9GUEJnS2p5OERYUDEya2VuNTZxTWRx?=
 =?utf-8?B?U20vL2tkTktMalBqYkNSZkQ3RUZvdHVqZ3BDZkozMVh3YUpGb1lHYTFVRzRs?=
 =?utf-8?B?VXZhWGlySm9UbDUwYjQwQWdBbnhsUTBqSk9OTFlyK0tuUWp2WlNOT3o3dW8v?=
 =?utf-8?B?TEtKa3dJRHhyWmN0OWEzMTZMN3pKOTFVb3RjUzR6OVhTdEFOSzVJV2MwRmdW?=
 =?utf-8?B?MzRVLzMzTTVvQmFMckF6SXd3YVQ4K0lkdndhOXdZamtEL2pvZTdlYW5KOXNl?=
 =?utf-8?B?c3dtM2p5U2kvV3hFRk04WDhoVFhTdHlFVmFlOUIxaURyVjdZdzZlWTA5d3FI?=
 =?utf-8?B?dFdzMUpmTEV1bXpEVk9NQld3TTczOHF5YXU0RExxQUhFc3RKWkIzMVcrc0Rx?=
 =?utf-8?B?KzBPbEpCeFoxekNPTWovVnFxRmlJbFZNU20vcnJLRHhhc3ArRlpRdU1jblFr?=
 =?utf-8?B?Q0VXeDJGWXhISC9rRi9qK3JnRzMrc2pBVTdiNHBNbCtiUW1QUU14N1RteWxM?=
 =?utf-8?B?QnRxZzNnd3pNZ1d2OURMTkRNWWQrWjB0a2dvNnArOVVxbzAxNEtwTjZXSVdv?=
 =?utf-8?B?bnNhOW9sQUtYTHhLbUxOa1diRXNGV0EwSnE5QndxMXBENTU0Q2dyTVVFQ0xB?=
 =?utf-8?B?cHNwMlRWSnFEcVdxYnZsTXVONiswQjNkZlovRHMyZ3Y3THluNERuempSalVZ?=
 =?utf-8?B?UjRtWTNOZVlDckxOWkxBUHh0WjNtYU1xSHhQOFE1dzRXalNZd2RGOHZ6OEI3?=
 =?utf-8?B?bGFHamZ2T1lES0JBUW50T3hjSDNLc2M0ZlA0STVpT20vR3hISDdQQWU5MElD?=
 =?utf-8?B?U0dlR2EwYlVSMDROcUxVeWhJZ1J1a0Z1N1p6L0FWVGt3VFBudzNGNzc3Q2Rw?=
 =?utf-8?B?dTZZUGloQ1paWGpFc1FFQ055Z1VOV2VoWVQ4dXAvMkRVTkI5ZnNRZzVFaHJR?=
 =?utf-8?B?VFdMU1pCUTFWdTJVSWVCWG5oaTMxaGVvVENnczRuSnF1NnZkT1RBZmpmdjVK?=
 =?utf-8?B?dzg4U2V1dXJ0U3JsdUtQakdHRlg4Z2NBNVZnSDhMTGRKcDZnVzNvT2xrKzN2?=
 =?utf-8?B?ZUpFaGhwZjZWTml2TEJRR3RPeDVhcFc4WFJvbkw5dzJjRUNTY0phYUxSdDNZ?=
 =?utf-8?B?eVpqWU1NZnhObC9ESDVXUmpYa0V2YlMzY3NLWSt1ODBMTDJvbUxrTk1nNnlR?=
 =?utf-8?B?b21Id2c2VHN6OHo0dkxDTEI2TjlHay9UcmNtVFlWV0xCUzYwSlkvc0ppRHNZ?=
 =?utf-8?B?bVhMM3BJWXoxOHdUbXhUcDNpc3paeTZ6Tm16a1YvTG9ZbzNOQy9Lcld1U1k0?=
 =?utf-8?B?ODRZbnNoRDNOTStXWlg1eEpXUk8rK1FvZVc4ODhyNWMyb1ZWTllSWG4xTlcr?=
 =?utf-8?B?VlB0ckkvZm1xMytEOFVQS2Qra05mdnd4ZW9FMHJpdXl1dDlJY01VQUdCNm9U?=
 =?utf-8?B?eHlNM2VMOTF1dms3eUZHcjVSY1Z5WGFGdXJyZENwMm5ZZjZUdzZxdEtkNlIw?=
 =?utf-8?B?bE9xM3NWS0MrbUtRTTYzSXFReUJJR3ZqWS9jWlJVU1FDWnJNanlpcWtCaURm?=
 =?utf-8?B?ZmYwd0tnOEl5M2Ezd3BMQXRkaTFiWS9GMVJocmJYZG9VRmV0N0VRalcxdUR3?=
 =?utf-8?B?OFRFYXU5b0FxbER1Q21xTXhyanVocTM2K2lWSUU0V3hVK0lITnYrY2FnVStn?=
 =?utf-8?B?ZnFoUDZYT0tHSVBZRFlrQTIwaTdTMGxpWEpjVTB3cjV0WllqYkhQK2tkRFo0?=
 =?utf-8?B?QXFKdUliZXhpajNGUERKWE0ydTJDd1dxOThaTThRTk95MUFOd3NLOEVML1dj?=
 =?utf-8?B?cVNCM3VmU0llSDN3cVZBWXJMemE1Y0QzSVYvNFNJbmxMM2drVzh1VkZHOWpM?=
 =?utf-8?B?c1MzRDVRRjJkdlNKU2FnS1Z3Nm01NFVlRTZrMWlmNU9oRWIwUGhicWNwS1Vj?=
 =?utf-8?B?QlNFcVpZeGNtOGZ6aHUvVyttWE9yT1k0YXpIWFlKc1IvbEw3KzFlRFlVUEUy?=
 =?utf-8?B?Y3U0OUNmdjVDUXZuc094UFlsdktvdnYvUXJCZlN4RzZ0VWpxbUZhbFhHYlpG?=
 =?utf-8?Q?Xeqr8V2iP5Ne8Jzlg5dE1bc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	X8Z1Qfk51xeLjw2Fyz+dCus8K5isPCydvlbFaVPc8IZ84yLh14PiUBi9hJfYwOaN4i4nRmiZO51p2xLunWik0uvyAzR4TIH6ee2LeipirBtEh6okcwBpDGYbr+7H2Nni1c+j+ccHzJ0cVm4HOnn+j8dYVT5n2s6eRr7WBt9wYCyItqg30fWn2Wmw50Dp4tvSqEztETshlnDe1qb9qhQ+2LOfsUjoSSUv/0eadc9TF0DGxl8GyfOrP3rX9rnXLb2Bcasnk4bd7tAbLJxk5K+LYqUSmqX/aX8CJxoGKopfMlOVSs92MVo7M6WTn6WFxiL+nbGGevjkqCDFZpr6/ugbfXcBJukH5MPgP/Rr2/G2Zw9nwoOZlldattqA/1Jz5kyChBO4QKbhK0kVkqSXfp7bFYdeAg+hpq5PdtvN5izZ7HDEdF1lkAeJPVtFPTISC6rHARa8s00YtDTpToiXOujQ5ipM9yOO1Ks7P8E5xDnuxO5nXUQnfZFZggb8L74Q5gXmyP2EZsdiNkG9n+5/ZE+CcyE60X9R3SkJ6wZyMQRm6hHo0UqyWOg9jVPsrUuPBF89fIv/Za5nJl4ciUsKgCg9goawEoQZqrII9+uYz6DxXzMwkupaTuZYPPoxSObPcXbJy+tAz9kDCpRiC6YBM+rSG7tj9M6m9mQdxUutKfwDg1zToAo2I8uHYGMAW/u1hdwNKgyiUxJyUK1w9Tzofv3sjz1ZMf19TFU/RbDMSGu+rnZKmA1YsuThpWVB6nxuYTOgYmxXCHlWWFHo00XN8Da2i5PqeJAtSSih64StoIAsFOAUGrgUpkKYNBDkNI7R8w+YnNFdnZqTFEDxnjYwX2cuMEfwLzainnk1kaAHQ+0G4dU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92bbb4e-5f10-4c0f-8f16-08dbca75dd86
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:19:38.1542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0E2fZIKf865gy0kRGfnaFnNTZQejm6zRd3cZbK6jzTVMwM+slLuYXUixQfgNuAAD23kBoS8y/vvm8GBb4TZy/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6061
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_11,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310110144
X-Proofpoint-GUID: wKBEJ8_LkF0pBY5Jwqar8f1FT9Eo7Sg2
X-Proofpoint-ORIG-GUID: wKBEJ8_LkF0pBY5Jwqar8f1FT9Eo7Sg2
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 14:54, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Move the BTF APIs used in tracing to the BTF library code for sharing it
> with others.
> Previously, to avoid complex dependency in a series I made it on the
> tracing tree, but now it is a good time to move it to BPF tree because
> these functions are pure BTF functions.
>

Makes sense to me. Two very small things - usual practice for
bpf-related changes is to specify "PATCH bpf-next" for changes like
this that target the -next tree. Other thing is I'm reasonably sure
no functional changes are intended - it's basically just a matter of
moving code from trace_btf -> btf - but would be good to confirm
that no functional changes are intended or similar in the commit
message. It's sort of implicit when you say "move the BTF APIs", but
would be good to confirm.


> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>


> ---
>  include/linux/btf.h        |   24 +++++++++
>  kernel/bpf/btf.c           |  115 +++++++++++++++++++++++++++++++++++++++++
>  kernel/trace/Makefile      |    1 
>  kernel/trace/trace_btf.c   |  122 --------------------------------------------
>  kernel/trace/trace_btf.h   |   11 ----
>  kernel/trace/trace_probe.c |    2 -
>  6 files changed, 140 insertions(+), 135 deletions(-)
>  delete mode 100644 kernel/trace/trace_btf.c
>  delete mode 100644 kernel/trace/trace_btf.h
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 928113a80a95..8372d93ea402 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -507,6 +507,14 @@ btf_get_prog_ctx_type(struct bpf_verifier_log *log, const struct btf *btf,
>  int get_kern_ctx_btf_id(struct bpf_verifier_log *log, enum bpf_prog_type prog_type);
>  bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  			const struct btf *btf2, u32 id2);
> +const struct btf_type *btf_find_func_proto(const char *func_name,
> +					   struct btf **btf_p);
> +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> +					   s32 *nr);
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +						const struct btf_type *type,
> +						const char *member_name,
> +						u32 *anon_offset);
>  #else
>  static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
>  						    u32 type_id)
> @@ -559,6 +567,22 @@ static inline bool btf_types_are_same(const struct btf *btf1, u32 id1,
>  {
>  	return false;
>  }
> +static inline const struct btf_type *btf_find_func_proto(const char *func_name,
> +							 struct btf **btf_p)
> +{
> +	return NULL;
> +}
> +static inline const struct btf_param *
> +btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> +{
> +	return NULL;
> +}
> +static inline const struct btf_member *
> +btf_find_struct_member(struct btf *btf, const struct btf_type *type,
> +		       const char *member_name, u32 *anon_offset)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  static inline bool btf_type_is_struct_ptr(struct btf *btf, const struct btf_type *t)
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8090d7fb11ef..e5cbf3b31b78 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -912,6 +912,121 @@ static const struct btf_type *btf_type_skip_qualifiers(const struct btf *btf,
>  	return t;
>  }
>  
> +/*
> + * Find a function proto type by name, and return the btf_type with its btf
> + * in *@btf_p. Return NULL if not found.
> + * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
> + */
> +const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
> +{
> +	const struct btf_type *t;
> +	s32 id;
> +
> +	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
> +	if (id < 0)
> +		return NULL;
> +
> +	/* Get BTF_KIND_FUNC type */
> +	t = btf_type_by_id(*btf_p, id);
> +	if (!t || !btf_type_is_func(t))
> +		goto err;
> +
> +	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> +	t = btf_type_by_id(*btf_p, t->type);
> +	if (!t || !btf_type_is_func_proto(t))
> +		goto err;
> +
> +	return t;
> +err:
> +	btf_put(*btf_p);
> +	return NULL;
> +}
> +
> +/*
> + * Get function parameter with the number of parameters.
> + * This can return NULL if the function has no parameters.
> + * It can return -EINVAL if the @func_proto is not a function proto type.
> + */
> +const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> +{
> +	if (!btf_type_is_func_proto(func_proto))
> +		return ERR_PTR(-EINVAL);
> +
> +	*nr = btf_type_vlen(func_proto);
> +	if (*nr > 0)
> +		return (const struct btf_param *)(func_proto + 1);
> +	else
> +		return NULL;
> +}
> +
> +#define BTF_ANON_STACK_MAX	16
> +
> +struct btf_anon_stack {
> +	u32 tid;
> +	u32 offset;
> +};
> +
> +/*
> + * Find a member of data structure/union by name and return it.
> + * Return NULL if not found, or -EINVAL if parameter is invalid.
> + * If the member is an member of anonymous union/structure, the offset
> + * of that anonymous union/structure is stored into @anon_offset. Caller
> + * can calculate the correct offset from the root data structure by
> + * adding anon_offset to the member's offset.
> + */
> +const struct btf_member *btf_find_struct_member(struct btf *btf,
> +						const struct btf_type *type,
> +						const char *member_name,
> +						u32 *anon_offset)
> +{
> +	struct btf_anon_stack *anon_stack;
> +	const struct btf_member *member;
> +	u32 tid, cur_offset = 0;
> +	const char *name;
> +	int i, top = 0;
> +
> +	anon_stack = kcalloc(BTF_ANON_STACK_MAX, sizeof(*anon_stack), GFP_KERNEL);
> +	if (!anon_stack)
> +		return ERR_PTR(-ENOMEM);
> +
> +retry:
> +	if (!btf_type_is_struct(type)) {
> +		member = ERR_PTR(-EINVAL);
> +		goto out;
> +	}
> +
> +	for_each_member(i, type, member) {
> +		if (!member->name_off) {
> +			/* Anonymous union/struct: push it for later use */
> +			type = btf_type_skip_modifiers(btf, member->type, &tid);
> +			if (type && top < BTF_ANON_STACK_MAX) {
> +				anon_stack[top].tid = tid;
> +				anon_stack[top++].offset =
> +					cur_offset + member->offset;
> +			}
> +		} else {
> +			name = btf_name_by_offset(btf, member->name_off);
> +			if (name && !strcmp(member_name, name)) {
> +				if (anon_offset)
> +					*anon_offset = cur_offset;
> +				goto out;
> +			}
> +		}
> +	}
> +	if (top > 0) {
> +		/* Pop from the anonymous stack and retry */
> +		tid = anon_stack[--top].tid;
> +		cur_offset = anon_stack[top].offset;
> +		type = btf_type_by_id(btf, tid);
> +		goto retry;
> +	}
> +	member = NULL;
> +
> +out:
> +	kfree(anon_stack);
> +	return member;
> +}
> +
>  #define BTF_SHOW_MAX_ITER	10
>  
>  #define BTF_KIND_BIT(kind)	(1ULL << kind)
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 057cd975d014..64b61f67a403 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -99,7 +99,6 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
>  endif
>  obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
>  obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
> -obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
>  obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
>  obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
>  obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
> diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
> deleted file mode 100644
> index ca224d53bfdc..000000000000
> --- a/kernel/trace/trace_btf.c
> +++ /dev/null
> @@ -1,122 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <linux/btf.h>
> -#include <linux/kernel.h>
> -#include <linux/slab.h>
> -
> -#include "trace_btf.h"
> -
> -/*
> - * Find a function proto type by name, and return the btf_type with its btf
> - * in *@btf_p. Return NULL if not found.
> - * Note that caller has to call btf_put(*@btf_p) after using the btf_type.
> - */
> -const struct btf_type *btf_find_func_proto(const char *func_name, struct btf **btf_p)
> -{
> -	const struct btf_type *t;
> -	s32 id;
> -
> -	id = bpf_find_btf_id(func_name, BTF_KIND_FUNC, btf_p);
> -	if (id < 0)
> -		return NULL;
> -
> -	/* Get BTF_KIND_FUNC type */
> -	t = btf_type_by_id(*btf_p, id);
> -	if (!t || !btf_type_is_func(t))
> -		goto err;
> -
> -	/* The type of BTF_KIND_FUNC is BTF_KIND_FUNC_PROTO */
> -	t = btf_type_by_id(*btf_p, t->type);
> -	if (!t || !btf_type_is_func_proto(t))
> -		goto err;
> -
> -	return t;
> -err:
> -	btf_put(*btf_p);
> -	return NULL;
> -}
> -
> -/*
> - * Get function parameter with the number of parameters.
> - * This can return NULL if the function has no parameters.
> - * It can return -EINVAL if the @func_proto is not a function proto type.
> - */
> -const struct btf_param *btf_get_func_param(const struct btf_type *func_proto, s32 *nr)
> -{
> -	if (!btf_type_is_func_proto(func_proto))
> -		return ERR_PTR(-EINVAL);
> -
> -	*nr = btf_type_vlen(func_proto);
> -	if (*nr > 0)
> -		return (const struct btf_param *)(func_proto + 1);
> -	else
> -		return NULL;
> -}
> -
> -#define BTF_ANON_STACK_MAX	16
> -
> -struct btf_anon_stack {
> -	u32 tid;
> -	u32 offset;
> -};
> -
> -/*
> - * Find a member of data structure/union by name and return it.
> - * Return NULL if not found, or -EINVAL if parameter is invalid.
> - * If the member is an member of anonymous union/structure, the offset
> - * of that anonymous union/structure is stored into @anon_offset. Caller
> - * can calculate the correct offset from the root data structure by
> - * adding anon_offset to the member's offset.
> - */
> -const struct btf_member *btf_find_struct_member(struct btf *btf,
> -						const struct btf_type *type,
> -						const char *member_name,
> -						u32 *anon_offset)
> -{
> -	struct btf_anon_stack *anon_stack;
> -	const struct btf_member *member;
> -	u32 tid, cur_offset = 0;
> -	const char *name;
> -	int i, top = 0;
> -
> -	anon_stack = kcalloc(BTF_ANON_STACK_MAX, sizeof(*anon_stack), GFP_KERNEL);
> -	if (!anon_stack)
> -		return ERR_PTR(-ENOMEM);
> -
> -retry:
> -	if (!btf_type_is_struct(type)) {
> -		member = ERR_PTR(-EINVAL);
> -		goto out;
> -	}
> -
> -	for_each_member(i, type, member) {
> -		if (!member->name_off) {
> -			/* Anonymous union/struct: push it for later use */
> -			type = btf_type_skip_modifiers(btf, member->type, &tid);
> -			if (type && top < BTF_ANON_STACK_MAX) {
> -				anon_stack[top].tid = tid;
> -				anon_stack[top++].offset =
> -					cur_offset + member->offset;
> -			}
> -		} else {
> -			name = btf_name_by_offset(btf, member->name_off);
> -			if (name && !strcmp(member_name, name)) {
> -				if (anon_offset)
> -					*anon_offset = cur_offset;
> -				goto out;
> -			}
> -		}
> -	}
> -	if (top > 0) {
> -		/* Pop from the anonymous stack and retry */
> -		tid = anon_stack[--top].tid;
> -		cur_offset = anon_stack[top].offset;
> -		type = btf_type_by_id(btf, tid);
> -		goto retry;
> -	}
> -	member = NULL;
> -
> -out:
> -	kfree(anon_stack);
> -	return member;
> -}
> -
> diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
> deleted file mode 100644
> index 4bc44bc261e6..000000000000
> --- a/kernel/trace/trace_btf.h
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#include <linux/btf.h>
> -
> -const struct btf_type *btf_find_func_proto(const char *func_name,
> -					   struct btf **btf_p);
> -const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
> -					   s32 *nr);
> -const struct btf_member *btf_find_struct_member(struct btf *btf,
> -						const struct btf_type *type,
> -						const char *member_name,
> -						u32 *anon_offset);
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 4dc74d73fc1d..b33c424b8ee0 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -12,7 +12,7 @@
>  #define pr_fmt(fmt)	"trace_probe: " fmt
>  
>  #include <linux/bpf.h>
> -#include "trace_btf.h"
> +#include <linux/btf.h>
>  
>  #include "trace_probe.h"
>  
> 
> 

