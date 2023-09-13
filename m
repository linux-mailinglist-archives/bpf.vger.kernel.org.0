Return-Path: <bpf+bounces-9950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB3179F08A
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 773B71C20A54
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B9200B1;
	Wed, 13 Sep 2023 17:44:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23D41F952
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 17:44:52 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBDA19AD
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 10:44:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DH0rKr013557;
	Wed, 13 Sep 2023 17:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Ge8lchIOS2diH1+QLRNpCujAG6X9jLu3ia3zT5kX9+o=;
 b=cRN36keHxEdwwLpreR8f8PiCZXA4zThGKQsriedBj3fsbBgECX7OKNVtP4IGb4edVHOW
 aNrGvUfP8vusBHQoWIHXJ37AHr/RNxofF25+riTzqU455GvY67UKTZjsGU7rTS/IM3Pc
 oTWg8/S0mdjgfPS5Pknl/RKOky6tBS+u/wrfCNwPCdI+9FqGA1COma5dkZXR6+xiuI6x
 navxBcxocBc7cJV/xYk/fA3VBlg7sR9ahTmXDNvUVfLEJADH2bZt5RRCLydOJw+QF0bn
 il/2/ZIyabir5C7AtsL/JOlw9kHSVsQXZ5NzWvfExwjyzaBYlH3FhxhT8TvaAEWG2LXK zw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kjryq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 17:44:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DHgK31015028;
	Wed, 13 Sep 2023 17:44:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5dvbx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 17:44:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=avNJ+1DxZ1m4WVaexLlvyMZm+tXxToR/pQEnsBsaoAs8XgIORv/FTokhQ37zRn/QfUJF7OKOfJsI9rBjyXBdNN/nebCcxOw4Vy4VJXvhtUi6HzFIuvx9i5RkLHcFIucqsA6QvMC6hxKYITq6GQF7JXj1KmY2k9Zbd9nzTSpIppguGRXfdXQOs+76exEG+pDqW9Tm7QcRTx+ktu7nLfDS9kT58ZhaNhDck629YkOOyk9ilSwBcvKc/gn5vxc9Tk4n2OgS1/Mwz78iATdArNkvBik7TRpNLyu8geI4gkH3WuUwcE/ivUKTOqBBJ/BmCIK81CVBEcikWnzag3hTjzgasg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ge8lchIOS2diH1+QLRNpCujAG6X9jLu3ia3zT5kX9+o=;
 b=c8Zh6xvvtYpq1tqU0TiNJvkNV6f9PnkQKyTH3VipLHm6fv+VPrc6+6VYyR6zbqb3iUEmMEQi2CM3qaBLvU/5tqT/RujzVQ8V70xz9uxRfONG0eLu9NhEsxTCGZiG+piAeVK2tNj3+5Eigl2Q4DwK/hrRC0GwLNsUWRD98ZOwUxUUwwm3r/wLbKKfxDVKKzAz4MpZ788O9LKmPtrUcA2nUzWMtgopTU/pzW0iCCM3mOaLJQLpXqYZb5wW2FLWtuazdxW2hdYLz7S+aAgbmvaZKrQGh0ANDMQbGfLw6T4cJ3qnZFCSRYpG/ROlm7VXlGTmhzjKfUBSDt8QBBE2Hb5Y7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ge8lchIOS2diH1+QLRNpCujAG6X9jLu3ia3zT5kX9+o=;
 b=bDbHYw88cW/dKng99cWRaCBmnJdpN3rsoRh0Zrb6MqJnF4KuU83Fug+tl3XyepzkL+zaDJpfURMfdluAAKaMyN5t3Mtd5v4wpmkBwPRjPU+RMA2wVKY5MQdLWtYX7QMVXfEd55xPsOfvm69GP7JiYorMAo/4NxRdjY6KUMZTfQI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CY5PR10MB6012.namprd10.prod.outlook.com (2603:10b6:930:27::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 17:44:16 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::c5dd:aa90:b1b6:c9b6]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::c5dd:aa90:b1b6:c9b6%6]) with mapi id 15.20.6792.020; Wed, 13 Sep 2023
 17:44:16 +0000
Message-ID: <0e2d3d50-c64a-d49a-d788-7c231aa0c9eb@oracle.com>
Date: Wed, 13 Sep 2023 18:44:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH dwarves 1/3] dwarves: auto-detect maximum kind supported
 by vmlinux
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, acme@kernel.org
Cc: andrii.nakryiko@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, mykolal@fb.com, bpf@vger.kernel.org
References: <20230913142646.190047-1-alan.maguire@oracle.com>
 <20230913142646.190047-2-alan.maguire@oracle.com>
 <69a3fa8112195551e6ed6e63785c80816f205d6c.camel@gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <69a3fa8112195551e6ed6e63785c80816f205d6c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::21) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CY5PR10MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fad85d-6d9d-40c9-8826-08dbb4810cba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rInqz+Wt3z0YdCRAOPwCJ0Yywz3jF+9BLU4qIskhFtUPUaGty8CPkyWDdYcq8c9qUwHRXXJ5TweTNe7MISGbrS2Q1zbF7M/3Pu7UzuMtzJy6b/qh8oetwKTw+Jpk8/2UH4NAtUE8DtEeGfW2pZE6sCsV6sPVhdwR4ba27kLPwc6UNXVjahzt3/+1i3yiTbn1+Q8E4ZytbxtrTQqucZTu1GQdyKFcmA5Z+Cz7aKuYnSJ8bcI/ygQanL1jK2G+maDvPaKl67H9RafW0pb/0/4uV/0o2ZFzcSWg3V3Su7LdPBg4IDiihN3ZytNWRw/+eIQPib6o75G9Gc4438ujzPUY8jCLk4h6MExLQtHIckohpgBmKdwQWpvUuRff9nD8xnfJAzofjH3+T+KWTgEw2rJ5WTupqE2GcGceH+XqGzAHhy9x87KggCB+ECo2/wJVSRVZMqvt/7Lyeb275Ua9gyTkATW2F2MqGO+JYmtEQtNf1JbD77e2pE1KAsoGe1RPWzh/+v8Oe5tOqndMoh3kHZbvpTI+r5v3conK5fLrEqCZ3y6QMOPZ1bMS8p9sMH3UBTrFTFkXtVVChlM7tzhs9KXIGkCCUugXtLUixlWKX+7TcvEjutiExrTOzRba8gptFsuXTt/dif8AMhedbzAEqyofug==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(376002)(136003)(1800799009)(186009)(451199024)(6486002)(53546011)(6666004)(6506007)(478600001)(41300700001)(66476007)(2616005)(6512007)(5660300002)(2906002)(83380400001)(66556008)(7416002)(316002)(44832011)(8676002)(66946007)(4326008)(8936002)(36756003)(31696002)(38100700002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SURTS2pwalQ2TXJLYVRPRUE2VEE2VWFJM0doKzl0ZU1XbzNNa04wL2ZWaDJv?=
 =?utf-8?B?ZkJka2dpYnhLNTRxOTJzTHlvOFlpbDc5VHg1bk9JK1p5ckgxcytIblJnV0Q4?=
 =?utf-8?B?dWY2MWljTUZkcG1ZMFArS1d3MHloWm9tb0E1ZDVXZERiRGg0QUVlUU9YUFhX?=
 =?utf-8?B?emZPcFROdm9lZ2R5UGRpc2JtU0J1U2FWZEs3aUFFaHNmenl3Qm1aN3UvQjIw?=
 =?utf-8?B?RUliaGU3Z1o5OW9abjZKSm1udTl3eUwyeVU5VFhJdGdIMThQUCtqUzgrZGY1?=
 =?utf-8?B?M0FYTUZYSmVHeGdWTU41cmlhS0dpUEhaYTMxbkdidEJaeVRjYTFaS3p0Q0VU?=
 =?utf-8?B?ZDJuM2w4S01CMlRLU0xad3phSjdrVitnb0xTVTFTM2xjSitOekVzOTNOY2Uw?=
 =?utf-8?B?N29UQ2owbkpZM2FJTlVWaFY2OXhxQ2ZJNnQzbFRXTXNCTDFJZjRkNDJKVWhq?=
 =?utf-8?B?OXVPYmkycUo1NFlqZHZRblZVeTNxYkxWc0dsTGlKVTA1bkF2d3NQL0NiU1E0?=
 =?utf-8?B?NGN0Tng1aUNnazRPWW9YMldVVVdrME9DL0R4ZmE3bGU4NkFUVW12Nm42cWF4?=
 =?utf-8?B?akEzWmlNVFlFWWRQc0pScjBJMFdZcCtoSnExaVpld0I2ZUFFbUdyb0VnK21K?=
 =?utf-8?B?aE85UVMzbHY0ZnRzMjJ2UXFxQUNRZmNYZGI1SUdKWGgzcVJBK3diamVvTlo5?=
 =?utf-8?B?WmVlajZQdCtTODBiK3NiMFZPNE5IL2hKVldaTDI4NGdIRTlPOG5ZbWEyNFJQ?=
 =?utf-8?B?VSsyQTJrdUNpM2JmaGJ5a2Rqa2ViT05ORENTMjlhQXBXQlNOKy9nbVBTU1BF?=
 =?utf-8?B?eTdNSGJpZmJBZ05ZSG5BWmE2dkw5VSt5OFZkNk9QQ250WTNNZVR0NTl5QjNi?=
 =?utf-8?B?UnhTSEhob3R0cTQ3R3VnZHNqbE1OYUtUbkIvUU9lNUF1MS9QdExzZEgvdmFm?=
 =?utf-8?B?QUczY3QyUFhBTS9zUFBDU2wyVE0reU9KNEc5SU9GNG5ScmQ0NnFtaFRzSnJm?=
 =?utf-8?B?QjdSYUE5WTJRVjRJOWgyNDdtdjI4VjNkUHNicU9WNllwNjJSczFhcHdlcnBR?=
 =?utf-8?B?MWxPR0YxUmdmRFZkeXBtOW9nZitnc2V2NENsb0FqeG9ybmw3bFd1RmpKeUV2?=
 =?utf-8?B?OUd3amloT3YzWTdvSEVRVnZCMjdDRStrOWhBSDFmZlRjSDNWODZEaHlVeFNL?=
 =?utf-8?B?VmxPMWsxWWJtZVI4YXBTTjgvcTcxemhEWXJJMlFYWWMzLzhEYmp1L3JoMEw3?=
 =?utf-8?B?WjBDQlpzdXJ2aExXQThuVWx0OWJLeWpFLytlZ0RhOHk4c0x4NWJBOVVrcTBy?=
 =?utf-8?B?bWZqaUJYamF6QmkzUUQwL0RHWFZteDdwcHdOZEFDeGdvT20zdnhVMEJXUUha?=
 =?utf-8?B?Wmlkc204R1lVajJKMFBDTDN1eDk0N01OZ3BHSVVBVFdkL0YxbWdETmlSR2xU?=
 =?utf-8?B?b0tNZW43UVk2Z3RsZUtTbHl1Zi9pMGI0OWU5K0dycTNuSUU5cEEweHphU25x?=
 =?utf-8?B?NHpReTZOVW9ockp3TWlmb3pIY0NteFQ2cmlUeFU5S1JxOThCWFlDUThrWXdK?=
 =?utf-8?B?WndSc2VnVEZLTW11TjVidjNlYmlBNXRsSjlsSDBZUERCa0dSaGZPaW9DNDN5?=
 =?utf-8?B?T2lJWHFwYmV5aDUwTU1PZ2d5SFRQa0xObWRsSWExUTA2QjFJSkt2OVA3WjYz?=
 =?utf-8?B?Nk1DYjE1WTlXM2Vwek5rbURUUFFteEI5WEU1MGI2V0c1VUNoNWRzeU5GUng2?=
 =?utf-8?B?L05ENGJMeFJaMVhMdHIzOTNOTDYwc3dMVFB0OHRDcm5BOUdmWVdRUzh1TE5x?=
 =?utf-8?B?UmkrNmdwTVIrVlRyNTBKWk0yTVErS2hXWUVFU0RROGJIZnRiL2VRamlJbFJJ?=
 =?utf-8?B?eUFzczlWR1AydWhYMmNCaWd2NlZna3A4K2tuTzBWejF3QWsrVE03ZWR2a1lH?=
 =?utf-8?B?TmtjRVl2WFRFd3FMaW5icldFWUh3T1JZSENCcXlzRndCREdVYWpxQVRrT3lm?=
 =?utf-8?B?TDVWZVJkVE5SVm5kcXJnWWtiU3dXWmYvNmcvaDBwZmVsY2o0QmV5eVRkVUo4?=
 =?utf-8?B?TC92OUtEN0RndmM4eGljdGZKRTJ0aVVaYmFEbVhtNzNpYStEMk13cnVLanlF?=
 =?utf-8?B?WXl4YnN0aW5SL1hWaVRHcFZ0a01Db2dHeVlMc3F3YmRGMS9yMnFjaFl4NlBn?=
 =?utf-8?Q?e1r9zVQfFdeYy5Sdx8hGtxA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?cW12elRMcnV0aFJreGNCOW9oUVV2bjEyL3ByOUpRcnNhZS9UUG5oK3NmcHpk?=
 =?utf-8?B?QlAyZ1RnaEhvWjV6LytnQnN1U0R4R3RNdmJYbFA0L1hvRWphNTY3emR1eFI4?=
 =?utf-8?B?bjdyeVFDbFRvcndoeWNyelB4UGJiQnN4SThKOWxId2sxUjAxeU9kSVFDcjNS?=
 =?utf-8?B?Rk82bDlJRmh2NGhuR1k1SEJPeHpNb255ZllmelVrd3FybkNSUEZ2M2Jwc21M?=
 =?utf-8?B?dE5ZaGZiQjNrMVBqcjhYVDZ6diswZUZ4QWRsMWZEdmtVLzhUcFZseU9wQkpE?=
 =?utf-8?B?a2xvc3A3WHJ2ZWtIWjE4eGZzWm8yeGdrU1Rjd2s1NnNkRGwxaVhCUldxd0k5?=
 =?utf-8?B?WXdFbUNKZFVSUkJ1eUQ5b1ZoOXlxVk4vVXFMdVk3Smw3OW1PL2RvZWdYZE0y?=
 =?utf-8?B?RVU2ZXpjVXpSaEpBcno3MnJ2bXptV25mR1oxUjF4VFVQNFRaS0VTV0c0dEZy?=
 =?utf-8?B?MlQ2cVdWZ1FTUmMyYWZ2bnpYNm14MXAvN3oyZlJDNGNGb3dVT1F1d085RmU2?=
 =?utf-8?B?VHgvY1RvWlVxK2F5OHZBbGZ4ZWZwSDdnK1piaU9XWXB3NDZ5WmVHSkJuclBC?=
 =?utf-8?B?dHpxeWJuS2NEOWpLYkdwemFLQ3ZET1M5Q2lXTjZ4eVE0Nm9WK2YyWWlnSHpk?=
 =?utf-8?B?SnMrSm1YR2ZtajdERkxXbWNEMHZ1VThjOHJhL3ppYUdScUhhY3FDMUxWT0pG?=
 =?utf-8?B?MUxOWmprM1NjSjlvTFpBU2NvK2JZeHpHcEt0cHFqOTVaZTZORUFqMzArc3Iv?=
 =?utf-8?B?V1VhSVdxUDhPbHpGelBQd3dIKzlwVnpQS0xGeVcvUXdjYnJocitpTmhueEt1?=
 =?utf-8?B?azFNTGFRcFg3eFpRL0xqUTJHRmlMMElzdWtnUE5lOGVSOGxWb2hDWG5zTC9k?=
 =?utf-8?B?VFhtVW1aelZjclZadTNGUitkUmZ2bzJ2QUFURStwekhJY3o5Zmg1YWdHVW9o?=
 =?utf-8?B?K0plRnBST2l6UURMVkM0dHN4anQ1VEV2dWxlb2dpcW41Ni9tWVM4ZzM2d2Fa?=
 =?utf-8?B?Z2JWRHdLeEZvZ1A4SU5HNzdONmFyM3owT1huVURvSk54Vkc4YW5UOTllKzRZ?=
 =?utf-8?B?QkJDbHhRejJSaGRNaFhGMTRBZEtqSmgvMkdaWXNVSlR5QzM1MXhCZVp0d3Fk?=
 =?utf-8?B?ZWU3Zlo5MitvdmJrRGtYa2ZVaFJQVUZTd25DVGtYL09GdkVmNGFNQ09WWk9z?=
 =?utf-8?B?WngySXNjUUFJWi9nZXNHblQ1UUFmb0QzdlVOOUtXSkxqNEpnYlBqZ3hSU1Q3?=
 =?utf-8?Q?u0IgblLFYG2HEsW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fad85d-6d9d-40c9-8826-08dbb4810cba
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 17:44:16.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSq47ALj4+IRB2TzhktDNOBujJ6BQpkqdfEc+QEafVIEcKa0KnW7vQ+G+S7GVrcmCe/GrBblHj7Z/hgy28y7IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_12,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309130148
X-Proofpoint-GUID: 08gykCMKycvheEZvPaTzOuCjs27y2pPB
X-Proofpoint-ORIG-GUID: 08gykCMKycvheEZvPaTzOuCjs27y2pPB

On 13/09/2023 17:58, Eduard Zingerman wrote:
> On Wed, 2023-09-13 at 15:26 +0100, Alan Maguire wrote:
>> When a newer pahole is run on an older kernel, it often knows about BTF
>> kinds that the kernel does not support.  This is a problem because the BTF
>> generated is then embedded in the kernel image and read, and if unknown
>> kinds are found, BTF handling fails and core BPF functionality is
>> unavailable.
>>
>> The scripts/pahole-flags.sh script enumerates the various pahole options
>> available associated with various versions of pahole, but the problem is
>> what matters in the case of an older kernel is the set of kinds the kernel
>> understands.  Because recent features such as BTF_KIND_ENUM64 are added
>> by default (and only skipped if --skip_encoding_btf_* is set), BTF will
>> be created with these newer kinds that the older kernel cannot read.
>> This can be fixed by stable-backporting --skip options, but this is
>> cumbersome and would have to be done every time a new BTF kind is
>> introduced.
>>
>> Here instead we pre-process the DWARF information associated with the
>> target for BTF generation; if we find an enum with a BTF_KIND_MAX
>> value in the DWARF associated with the object, we use that to
>> determine the maximum BTF kind supported.  Note that the enum
>> representation of BTF kinds starts for the 5.16 kernel; prior to this
>> The benefit of auto-detection is that no work is required for older
>> kernels when new kinds are added, and --skip_encoding options are
>> less needed.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  btf_encoder.c  | 12 ++++++++++++
>>  dwarf_loader.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  dwarves.h      |  2 ++
>>  3 files changed, 66 insertions(+)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 65f6e71..98c7529 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1889,3 +1889,15 @@ struct btf *btf_encoder__btf(struct btf_encoder *encoder)
>>  {
>>  	return encoder->btf;
>>  }
>> +
>> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max)
>> +{
>> +	if (btf_kind_max < 0 || btf_kind_max >= BTF_KIND_MAX)
>> +		return;
>> +	if (btf_kind_max < BTF_KIND_DECL_TAG)
>> +		conf_load->skip_encoding_btf_decl_tag = true;
>> +	if (btf_kind_max < BTF_KIND_TYPE_TAG)
>> +		conf_load->skip_encoding_btf_type_tag = true;
>> +	if (btf_kind_max < BTF_KIND_ENUM64)
>> +		conf_load->skip_encoding_btf_enum64 = true;
>> +}
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index ccf3194..8984043 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -3358,8 +3358,60 @@ static int __dwarf_cus__process_cus(struct dwarf_cus *dcus)
>>  	return 0;
>>  }
>>  
>> +/* Find enumeration value for BTF_KIND_MAX; replace conf_load->btf_kind_max with
>> + * this value if found since it indicates that the target object does not know
>> + * about kinds > its BTF_KIND_MAX value.  This is valuable for kernel/module
>> + * BTF where a newer pahole/libbpf operate on an older kernel which cannot
>> + * parse some of the newer kinds pahole can generate.
>> + */
>> +static void dwarf__find_btf_kind_max(struct dwarf_cus *dcus)
>> +{
>> +	struct conf_load *conf = dcus->conf;
>> +	uint8_t pointer_size, offset_size;
>> +	Dwarf_Off off = 0, noff;
>> +	size_t cuhl;
>> +
>> +	while (dwarf_nextcu(dcus->dw, off, &noff, &cuhl, NULL, &pointer_size, &offset_size) == 0) {
>> +		Dwarf_Die die_mem;
>> +		Dwarf_Die *cu_die = dwarf_offdie(dcus->dw, off + cuhl, &die_mem);
>> +		Dwarf_Die child;
>> +
>> +		if (cu_die == NULL)
>> +			break;
>> +		if (dwarf_child(cu_die, &child) == 0) {
>> +			Dwarf_Die *die = &child;
>> +
>> +			do {
>> +				Dwarf_Die echild, *edie;
>> +
>> +				if (dwarf_tag(die) != DW_TAG_enumeration_type ||
>> +				    !dwarf_haschildren(die) ||
>> +				    dwarf_child(die, &echild) != 0)
>> +					continue;
>> +				edie = &echild;
>> +				do {
>> +					const char *ename;
>> +					int btf_kind_max;
>> +
>> +					if (dwarf_tag(edie) != DW_TAG_enumerator)
>> +						continue;
>> +					ename = attr_string(edie, DW_AT_name, conf);
>> +					if (!ename || strcmp(ename, "BTF_KIND_MAX") != 0)
>> +						continue;
>> +					btf_kind_max = attr_numeric(edie, DW_AT_const_value);
> 
> Nitpick: attr_numeric() returns 0 in case of an error, when 0 is passed to
>          dwarves__set_btf_kind_max() it would turn off all optional kinds.
>          Probably should bail out on 0 instead.
>

not a nitpick at all, great catch! will fix this and make the naming
consistent in patch 3 (using btf__find_btf_kind_max() as you suggest).
And many thanks for testing this at your end!

Alan

>> +					dwarves__set_btf_kind_max(conf, btf_kind_max);
>> +					return;
>> +				} while (dwarf_siblingof(edie, edie) == 0);
>> +			} while (dwarf_siblingof(die, die) == 0);
>> +		}
>> +		off = noff;
>> +	}
>> +}
>> +
>>  static int dwarf_cus__process_cus(struct dwarf_cus *dcus)
>>  {
>> +	dwarf__find_btf_kind_max(dcus);
>> +
>>  	if (dcus->conf->nr_jobs > 1)
>>  		return dwarf_cus__threaded_process_cus(dcus);
>>  
>> diff --git a/dwarves.h b/dwarves.h
>> index eb1a6df..f4d9347 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -1480,4 +1480,6 @@ extern const char tabs[];
>>  #define DW_TAG_skeleton_unit 0x4a
>>  #endif
>>  
>> +void dwarves__set_btf_kind_max(struct conf_load *conf_load, int btf_kind_max);
>> +
>>  #endif /* _DWARVES_H_ */
> 
> 

