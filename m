Return-Path: <bpf+bounces-17124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC60B80A031
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 11:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C04B1F216F3
	for <lists+bpf@lfdr.de>; Fri,  8 Dec 2023 10:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CAB12E73;
	Fri,  8 Dec 2023 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YXExClsd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hWFaY3BE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54AC10EF;
	Fri,  8 Dec 2023 02:05:49 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B89Docr007007;
	Fri, 8 Dec 2023 10:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=mTmTmKEFDPh8g4PQ3C2x044hfXyKOJyXJr5V3EvZ2s4=;
 b=YXExClsdtSfEUxCTIgpb0VcGLEUjXCrA9AxosD6kQPIvDPEgZK9ZFe5oth1zV8cVCeaB
 9pd1da4dmf5IHnYErv0MWjVcl60XWGwr+xJFGloQCI+6KRA00+Iqex3mG6oNcu6UafPg
 0w8yAXHfWIwmsH0ljRRFpXycaB4K+C1uDS1BZZjdwfzd912o/z2F5HxyzwRrujane35R
 ThhQFJT7tAg8KNEMoJ2sk6S+0JJl/P5Rqma9JrGSxfnXHp438DvmxWdBaFfHVhWh1KCH
 ApHbTrv13rbRoVlrJXLMvvdLIH1P9YZDUh5x5H+KttXYg0UZWprXJLasrzpPWJmwSTE3 Hg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdmbnsj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 10:05:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B88UD5C024251;
	Fri, 8 Dec 2023 10:05:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utancq1va-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Dec 2023 10:05:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPaTfos5FS6/lq/H3KPKppW72eQuqcu/2+Pz3+o5LCZxSBa/XfSiZIHore6ld3vDLE7aQj7SfGGGsJA395sZ7H4cBXTbBnT1lrqZ3y+MDIKOab3DPm1LMcj5jo/no5EFgPflviGGivtgS7+yqYnYXBZ1tOSQXZzjPOqUHYPTwIpG/r7RTqj7tL0lzGz7tWe4p/r3H2P3Rokv810W3OEil6yyxZLbH6I1+RV0NAPBLGPdqUQK2knKC6/gMLIa0kZPG2KhOHH6mXjlT9DKBPMQQoiiBhp8D1ptIZaIGL34yqZlqRf+kdJHmAUZijZYmbulbBeuHLJnq/XaPk9BtXg+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTmTmKEFDPh8g4PQ3C2x044hfXyKOJyXJr5V3EvZ2s4=;
 b=i2b0vyzNSZbUrVklhcnWQVCxDIt2RIKdfP4q2/iWCAwnmMjTW/+6zCNvrLC8yDx5GJxZDWQr1IKgXwB3pqKR3Qv1jWZOIPqP0sHALEPHEiL6FIMEHEuMyQ1MASD4qHNgC1GxbCREgD0C/RZX9TOQaY0myjshQ5v28/mqHH95IUNYlOQfrH/KCZdbHd1S3TGgVHEdEobf1JD5rhY2Az5KVrvo7CwpAOHrpBfKgMiGIPHaKoi3GSWlLO+LGdaapSVaoHAxFpHmvCALYNLcvd9CKRzPX+V7HABeYryQXC3X4Zi2EFsBLx21BOwgveMqC6B7AN8dxdesNp+kXgjEc8Gw2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTmTmKEFDPh8g4PQ3C2x044hfXyKOJyXJr5V3EvZ2s4=;
 b=hWFaY3BExZyYyjc5Qsa5sbrbgCWf0kxdpUgOfc9JbZ6p5ukj1hXM9hjZM3o1uYG+lEMXNXMoVLxtNrP3TkUZ8oOsCXH35lnMW/wJ8bToI5vgoV2qL3uk7yYYMkFys+dF9C5eCiBuROCsP4zvZd0py7K0J6FVFdevY3BlqIn+/5g=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ2PR10MB6989.namprd10.prod.outlook.com (2603:10b6:a03:4cf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 10:05:24 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::8f9a:840c:f0a6:eaee%6]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 10:05:24 +0000
Message-ID: <37db4a55-c34f-f227-512c-a7b4841d8cf4@oracle.com>
Date: Fri, 8 Dec 2023 10:05:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH bpf-next] bpf: Load vmlinux btf for any struct_ops map
Content-Language: en-GB
To: David Vernet <void@manifault.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, tj@kernel.org
References: <20231208061704.400463-1-void@manifault.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20231208061704.400463-1-void@manifault.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0091.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::31) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ2PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 29bac50b-5e22-4333-a672-08dbf7d531d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Fz49pxStghADAWyqFPB6dhKrIoAtVCXjspL0yLrf7SN6VIFY58+EU+eYQ2xKBKjiKQc3L04ifGMVXPA79fJtmwMTmlpU7ueytbObs0lDsAhq/M9cTyXZUb5u+GkTLiEG6lMjn6kgMSorFJpJzrHkVbuMhpm075IW8/NgPpJMKQIgT4dxSWz3v0KH8wRSIz8T2w7T/GSEV6PpySo2TzF92knVWgo7L1GMJVlgHp3y2DZZ50shTT4/JV97kO/ogzAlwWdoU10sJMu1jsLh3F489+c4e6OT/PQ2u6K7EMsdwqJNATUu4hOh5WOrcFGDTcPbYhdjUPPz4rZvX5tKnac0u9LEqGimQLKxK5G7NSciGhAUi0Y+1ZLzNO0fpnchU5yeJ8dUl8jyEwI4sCZH+84uRcoIN11rA5givN2QX5N0voS69giC6PHlrmfoujCNkIvhe8QvplpM1EC1oo9aPw88FCasXAj46oG3jwJ8+C/Yszr42DrbMprWZkpqkYLegUJXGyKyRa9QDsG0/U6LdPRmJgysHhTQtkToRcMiivLEsF/1xLPPXFM3KEDRCHYxM84jDa1sRH5ewK/HH67OPwENmwTuQplCcPYdoi1BbVh3pRxCZxTrlAl3n5jFig5ugogm5sjSUxuMVTddWEhJsA9wlQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6506007)(6666004)(2616005)(38100700002)(41300700001)(6512007)(53546011)(83380400001)(66946007)(66556008)(66476007)(316002)(6486002)(478600001)(31686004)(86362001)(44832011)(2906002)(7416002)(5660300002)(4326008)(31696002)(8936002)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T1ZGUWRTWGZGd3dtOVRiRUFsRHNNWUgzelNNMU8yMkhkeUg5UGVTSG1nbU5W?=
 =?utf-8?B?eFVocTZkcDJ4ZHIvaVhCb3MySU9PeHlObVBMbkFpUkJGeDJmTjJqWjlha05m?=
 =?utf-8?B?U0hUWG9jSlo2akdvSzI0STVMekVjaFhiZ2JCTmtGcCtJdnZPeS9QOE53dGZs?=
 =?utf-8?B?UDBZOG9QM0hZYXdybEUvdzZJOUJZL2JReXByWjVxa1IwR2Zlb01RdHlKN3FW?=
 =?utf-8?B?VUtjaW1ON1J2d0JmMnpOT1M2TXB4ajhtRThQMkpHcFhmRDAyMXREWm1ZZmxk?=
 =?utf-8?B?WHp1UnpIeElLMXI3RU5zV1YxYjgwZ1pkN1Z1aGVwb0tqelVvWXg4QitHTVBw?=
 =?utf-8?B?NGV5ZUd4MGxGYVNDbUtDZnlSUTM2dWFvYXNIUkxFSnJ1cjhPRGlTejZTTFA5?=
 =?utf-8?B?cnhnSC9hcTJ3RDBaUUwwMllydVNPVUVBaGVyT3RpL0NVdjluNWNUU3JDbFpX?=
 =?utf-8?B?Y1VNcHVGUk1oa01XVWh2a1ppWEY3L21EcENGbDlLcDRDTkNld0xUcEg4aXp5?=
 =?utf-8?B?RS8ybmUySEFzNkFVZGMrMnYvQ2xzblRMM1lJTjc4SFloSjJ5dnNicm43Vkcx?=
 =?utf-8?B?MWI5RFBkRUdycTZWWTQ2aGRMRDc1UHhZMUJDRXhjUFl2UDNFTEo0dHEzblhW?=
 =?utf-8?B?OTJ5RUE0dWxadVA0UHp1K0wrUHJISEZGaFR3RGFQRE04b1FCSnVBNnRocEhY?=
 =?utf-8?B?MGc0cjhOQm9iWS9vR09ndDZDdFN4UkxIbFdmN2xRZ2lyTnBnSkxQUnpack41?=
 =?utf-8?B?bi8xOXU0dEkzUHpJV214TmNOSW0wbnRHQzEvZlVYam5KR0FST0hDYzlYem1l?=
 =?utf-8?B?dlNzVHhmMkpIYi8zeER5ZUNOZG93WXJ2TWg5bnZzVGF1bXFlTVI2N0pRZlBK?=
 =?utf-8?B?YUVMM1FjYTFaNEJkVG1HOHlTUDJkZVdUd29ZcmlFNVNrbVJLVHFsUG8wNkp2?=
 =?utf-8?B?U2ZZZm1LYTNJaFZ5akJ3VmJzaUhlYTFjcDk4M2U4MVdPWmJiTHowWHhtT21J?=
 =?utf-8?B?SDFCOW5vWFZiZzJVcDFpMStpeWRNbXJqd2ZRUGlpd0pMV0JDNmxQR2xjN2ta?=
 =?utf-8?B?MUtzczFYRElEOVNDWHFZVVlTcUxXUVhtVVNKL2V2bWpDYjZSejhrRlBwdFBp?=
 =?utf-8?B?V0tGVzY5dnRUQURNNmR3M1FPK0ZXQkJieTR0eGZPREt5S3EwV3ZOQ3R5Tnl3?=
 =?utf-8?B?UWMyV3ZEYmMyOFliUjMyMXVhb0RneGd4aXRxRnFka05VZDcvb0Z4OWMySno2?=
 =?utf-8?B?bmFQK0tFbmh4UEp3SlFNYkE3eVB2Y2N5eENYclVRLzF5QWU4VWhvY2VXNlV2?=
 =?utf-8?B?VGZJb0Z5bjNrS00yaDMyK1lhRE9mTGhqb3doZU0rMXgvTjRQQWYwRnhheGxk?=
 =?utf-8?B?dUk2K2NMVHRpWWxheUNHdUEvQklXU1dVOHBnYUhaZVFoZ0JuL1U0a2R3R0FR?=
 =?utf-8?B?cjZjbFFQcTdBWldWZWlWU0hXeUN3TUNIbmZGOFlEVzN0V24yREsyQmd3dkxI?=
 =?utf-8?B?ZkNvRjdNMUhlM0t1ZkVVZWYrYW56aThEMVhrRmRmZmJUcmpBdmFpV0IxVGVM?=
 =?utf-8?B?MkJESFFIenE0YTZVZkNjK3NObi9Rd0E0bFM1ejZxNUpqQTJkZWlaOTNvc3Jx?=
 =?utf-8?B?MmNGM0t2a2l4dFQ2Z3drYW56QjVnVUdycC9KSWl0eDJML1ROUFlmWkNpU0hV?=
 =?utf-8?B?YUhkL0wvRWJmMHhCZWRiY052RUJaR09lSUIyRXBkcExZT1Z4YW1FbGZocUpV?=
 =?utf-8?B?NzBDVk5LcVhhcVhOdHFobld2T1dmSkU5bVBaeXBReU9OQ01UMU83WUZhSW50?=
 =?utf-8?B?TnNIeksvekQrRkcvS0lwU3Y5SHN6Mm1nUWdUZ042Rng2dmpZOWNqRWVZNmsw?=
 =?utf-8?B?Y0xhVWZHQm5ITDAzRUM4QW1lVVRvNUJnQzVKZmhVVjNMUitoaXhzRnV2UUNH?=
 =?utf-8?B?Z21oOVNjSWVGL05nM3dHM1g3Rlc3MUYwOFVrUGIxcFJnSXkzVlphTDYrWExQ?=
 =?utf-8?B?U3RXME5RQ3lISjNDZXNSa0xJeEFOeFJ1aC9TQUhTWGYvTXpHMVlIN1VHQ0hh?=
 =?utf-8?B?RFF5VDA5Y1IxT213OUFuOVZsbnFjNTJGaVVHdjhwZzJKT0VBaTlqLytaMlJM?=
 =?utf-8?B?Q2xQZTRIRVE5UWZmSlpKaGh6Q0VIWmVWOEwxd3dKeGFBb1cxVnFJakViYW5R?=
 =?utf-8?Q?HJekeFUxqEMo2lFGsU+iQj4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?K2k1THQwNWtEYkdxRXdEbitvaFRtRFRJNnZMQkZuVzZabWZERmFXa08xZk95?=
 =?utf-8?B?Nmg3dmI0YTJYalNHaml4NzNkc1YvSGNETjdHL0xSbUp3UGFrRSs0K0RtZzdF?=
 =?utf-8?B?TzR2VmJoc0VLR2R2L1ZXQjNiYzdSdHhMMm9jTUhhODJDOEM1c3ZPMW5PcktJ?=
 =?utf-8?B?SXdRcFphNHlac3NLbkt0NWxsKy93R1ZwN1RDTGU2dnNkUCtydG5FMEhjWDZF?=
 =?utf-8?B?eEsrUnYyS0FWVTRaU2JaV0dlZ3dlRDQrSlh6NUNHb3ZlcGdnWEVsWDYwRVNS?=
 =?utf-8?B?d3NMeUlQRE9YUjNJZTRVOFZvLzlEKzdXeVYzUGNLTERFVWtmeFN5Z255Ly9x?=
 =?utf-8?B?S2c0Y0FGNzBTOFpXNU5rMWFxRHlUWWtnVkpjZzRDNkRJYm1pMW80SjZKL1BE?=
 =?utf-8?B?R3BjREVrRHNJaE9rTTg1ZjZuL1ZZa2xyVFAvK1NiRlIwZ2NpeG56NlJRY1JX?=
 =?utf-8?B?NS9Nc3RQSXQ1ZWNNSHkxc1kzNlNOc3J6OERNZmVYV0djc1NQR0JkcXIxWkdK?=
 =?utf-8?B?R1Z2cHVxTXF1U1ZSeTVwNEtVVFlmYlhoemp3NE9OcjV1Zldkb0lXT2VGdm9x?=
 =?utf-8?B?SkRjSE10L3JZcjBvWlBnS3oyazZ6UnozbGp3a1RMZ3VHeGxaVzdna3FaR005?=
 =?utf-8?B?VEQ0ZG1Xcnh2cmdaRklXRVJONlY3T1RjcW5nWUhieW9rV3BCb2dEaWJWMWJq?=
 =?utf-8?B?TDcxMUpjOG1BNlM3KzZpbURzOWVJZmEyZEpYUURJY3RtYWtvbmxrbkgzMzd2?=
 =?utf-8?B?ZGxXSm8wV3pXalh3My9EMnI4OXY4SmpjbkVnS09IM0g2MGljU1VpaDYxUEk4?=
 =?utf-8?B?a3hVRVlGWVROTzdWSW43cGxlUndCb3FCWGxEWXVSS0x0UTJvV0ZhcTVhc243?=
 =?utf-8?B?V2tUdk0rd2ZHQzcza21TaEV6RC9LWEJFSGR6Qi8wdE4wTkVBdEpaL3NuZko5?=
 =?utf-8?B?bnZJQm5QZXVaUXFZdUlvQTlTTWJoNjY2alR0S0d1ZU8yUW1aVDNaOFBLNGpo?=
 =?utf-8?B?SkdHcUJrZ1NIalk0R1RBUndtOXJvM0Q1OHZKZkQ0TDRFSU5YZjBXNERkM01K?=
 =?utf-8?B?KzExVUU0a1ZrS2l1VlNmeWJVcFZ2Z2FqejQzWmVkU1pXd2RTZDRBc3M1WmtC?=
 =?utf-8?B?b0xPRzNQampOeDFHRWo2enpzVW1YckxwYXplejVndWlXNUMxQ1ZwUlhoQ2VP?=
 =?utf-8?B?WEQzYi9sckdNUXl6djVVK2dkUkREcEtMOVJFS2Q0M01tejJlY2h0c0doRXN3?=
 =?utf-8?B?OVc5Vlc4OWZ5bkdCU3NCdkhNdE04aHZ2WXZLMjJVbUNZZDNSbTJyYmdZWTYz?=
 =?utf-8?Q?4fK0zGJXBs/D4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bac50b-5e22-4333-a672-08dbf7d531d1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 10:05:24.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3v4hyJML2JLMo0Au+DiqHdRLwsrUPJnYl9T7onDqypb85I+LYLUWsZM4CTFYp3+RS7Fhbmh1QkkWxkd3/KH+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_05,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312080083
X-Proofpoint-ORIG-GUID: wu682NEUW4q68OEs2T9xc1yzlnhWNNCz
X-Proofpoint-GUID: wu682NEUW4q68OEs2T9xc1yzlnhWNNCz

On 08/12/2023 06:17, David Vernet wrote:
> In libbpf, when determining whether we need to load vmlinux btf, we're
> currently (among other things) checking whether there is any struct_ops
> program present in the object. This works for most realistic struct_ops
> maps, as a struct_ops map is of course typically composed of one or more
> struct_ops programs. However, that technically need not be the case. A
> struct_ops interface could be defined which allows a map to be specified
> which one or more non-prog fields, and which provides default behavior
> if no struct_ops progs is actually provided otherwise. For sched_ext,
> for example, you technically only need to specify the name of the
> scheduler in the struct_ops map, with the core scheduler logic providing
> default behavior if no prog is actually specified.
> 
> If we were to define and try to load such a struct_ops map, we would
> crash in libbpf when initializing it as obj->btf_vmlinux will be NULL:
> 
> Reading symbols from minimal...
> (gdb) r
> Starting program: minimal_example
> [Thread debugging using libthread_db enabled]
> Using host libthread_db library "/usr/lib/libthread_db.so.1".
> 
> Program received signal SIGSEGV, Segmentation fault.
> 0x000055555558308c in btf__type_cnt (btf=0x0) at btf.c:612
> 612             return btf->start_id + btf->nr_types;
> (gdb) bt
>     type_name=0x5555555d99e3 "sched_ext_ops", kind=4) at btf.c:914
>     kind=4) at btf.c:942
>     type=0x7fffffffe558, type_id=0x7fffffffe548, ...
>     data_member=0x7fffffffe568) at libbpf.c:948
>     kern_btf=0x0) at libbpf.c:1017
>     at libbpf.c:8059
> 
> So as to account for such bare-bones struct_ops maps, let's update
> obj_needs_vmlinux_btf() to also iterate over an obj's maps and check
> whether any of them are struct_ops maps.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Makes sense to me.

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/libbpf.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ea9b8158c20d..ac54ebc0629f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3054,9 +3054,15 @@ static bool prog_needs_vmlinux_btf(struct bpf_program *prog)
>  	return false;
>  }
>  
> +static bool map_needs_vmlinux_btf(struct bpf_map *map)
> +{
> +	return bpf_map__is_struct_ops(map);
> +}
> +
>  static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
>  {
>  	struct bpf_program *prog;
> +	struct bpf_map *map;
>  	int i;
>  
>  	/* CO-RE relocations need kernel BTF, only when btf_custom_path
> @@ -3081,6 +3087,11 @@ static bool obj_needs_vmlinux_btf(const struct bpf_object *obj)
>  			return true;
>  	}
>  
> +	bpf_object__for_each_map(map, obj) {
> +		if (map_needs_vmlinux_btf(map))
> +			return true;
> +	}
> +
>  	return false;
>  }
>  

