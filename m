Return-Path: <bpf+bounces-5770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA197602DD
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 01:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDAA281300
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B772012B67;
	Mon, 24 Jul 2023 23:00:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583A653A0
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 23:00:15 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07476115
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 16:00:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36OFNsY8007670;
	Mon, 24 Jul 2023 23:00:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=68PZosU0BL5CZ0q2MpKXtl+mQLY39xIi4/Okr/acehQ=;
 b=Gvcga3eYQLTVpxSeu2JnA/SAMHGWXPFqOKCZXJtt7sD5KDvb99ITWHFDwDaxYCdc3YQh
 9e+iuJDmI6LJXIN6nM1jj51Xd+f/bgO0kXUjSbdl7j1BsGkDTJVfwXSyNzNh2u38sgVp
 ioezmLvLCfT/ADJHpUtSfhPUiQH7r2yLWgdwIpNbUIpYYNSufcmezT7SaSr8Sf51RN8q
 JbSQLeJHB7u5FQG0NtkQkO25dnK1zzq8dtO3Uxuw6t1o1F7tsYn+hwk/ZFA0SOilWoPI
 UN62yxyeHr2KSeiRYJolIV9RfWKibrsJsIrkBqTpmZJYNVpBzqjgd9LQ3xXP91zsryjb sA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05w3kw73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 23:00:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36OKkEhO029093;
	Mon, 24 Jul 2023 23:00:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jaa2f9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jul 2023 23:00:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUCn7shw3iYf/7+uhk5roFpsa1SptHmmMUNZYHWlDkMiJCKfUK/wIp8pr4sfBo62G3gfS/UzwuDWka6+Dqr+BZZqH6r73TDCPQ0ehvzKsB/c9DXLKjKp8fJfYAC2kJtAqPaygsAz7JNtHAF5mPeK6CGD5uRWE1YiY8NwUvN3c8v8MjDZb5nivWHmglVOB0Xvr361T4bLNN0krL3jBbXJiO7tx1xP2Qa0kbm1+oyecLL1yM9bmXD4kXJ83uhEHnKh8X50pBARReb7vHv2P6AxzM2SGwN/tlBnXwGup8ANBDh9Oq4DenD0KEE5zpFyJjo/8MmTMZKqs8vava310IYZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68PZosU0BL5CZ0q2MpKXtl+mQLY39xIi4/Okr/acehQ=;
 b=P3vXdQzKtEG5gnK9bo2DW2DNmJoR8+QErJaYApz1vaf08TAppYZVZwoY1T0ILH7RaASOQQNaMNR7cojHNEQyTAmi8ABZ2JRe8HGtteTI1PDT8coKYkP+uEM/v69r34fSaSb8FxHV029cCjiELGObR7i9QLb5OMvScRzKLQqBnl81ctEjnlFjdH8OS4Zl+yLUISYnKUUD/8dvwY1TfG3qEvL8zj6/ABKJPHhuA7mUIuFsVE7g9y6WBrgF+nUZQ4d2sGF6vgLczV0tdaFNTg8ADTfqIdynxf0erqd5TZG3JKtscTECKaoD4oyGgvZD8XTtksFGCt/FOssiyUFmmJai5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68PZosU0BL5CZ0q2MpKXtl+mQLY39xIi4/Okr/acehQ=;
 b=A/n2feGdmIKT5+EskqBBckf7JE6tz3hsgAaKTzarBGrorNCERgA5h36VLfIkPdfAUKhIDP80UP1CfqhDm1COD788RHlZVbsTXYGqpQFbynM300rPp2NmdX/VZAa07EGs5Omk5s2MC3wSJTbBNaf2MpI+KBENaHQ7NRwh5AOgd6g=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by IA0PR10MB7325.namprd10.prod.outlook.com (2603:10b6:208:407::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 23:00:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 23:00:07 +0000
Message-ID: <883961c3-3ea2-2253-4976-aa5e20870820@oracle.com>
Date: Tue, 25 Jul 2023 00:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Question: CO-RE-enabled PT_REGS macros give strange results
Content-Language: en-GB
To: Timofei Pushkin <pushkin.td@gmail.com>
Cc: bpf@vger.kernel.org
References: <CAChPKzs_QBghSBfxMtTZoAsaRgwBK9dRXuXZg+tg2=wz=AuGgg@mail.gmail.com>
 <3d26842f-86a4-e897-44c2-00c55fadb64a@oracle.com>
 <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAChPKztZ9kaNw-PkhEq4UKidjVgKNnwLPKzYvLc6BcOOUtvEkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|IA0PR10MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: bedc1ce0-2452-4e9a-1775-08db8c99b967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6CV7saaCzIta1j+xfnbVmMGzuUl/QYah2ZOsrrevVgKwTw+1Ze6mQKH5j8dDfVgdx3TXp/5tcLaz2DPff1r70jOnyE5FqTUMw0u5Wx9VPB0/CD0+9/R182NBXfZtTK+ZVuQn7gZmqUZ5MyKMxlU1vMbvF1Dh7M85ChRwWuvvoJPQYRVMr2x8ADDvrePUTco3RHaChjA9s+UttWLL/FDtMqIeK6LvttReqvoK4K0mq/imTb7BCkccVl95g+oDmhQgVBTI4QU+h6yinKcEKYIab6hsLs0xdueSrLPDF0AgM/AfS/QeMplcwKG+6yug68ciPh8LOO57EuSrybmIVwbeQzORrnVYwXxExL7iSDeRlbMqw1gS6kcmpHtirR2wpo8ssW4rrL2fp7cpVHAocuEUK5Sy00cu/wFXATu7RzeK6uVEhY+hKi5Z/ZBzKPXsM3YkQC6T35tVH1Ky5A5hlmF9y1rQa/7cOFLDoY77bTBJhNVMq8tD9SqRaJueXYe2GhH1WVGiSodUYjHc8XQyg2j5atDKD5XAmP9SnlQw80+dEISds6Qum8CYtPdj7mAMxUa/3zQkBg+lJ+pL+mZsc2q0GR4NyHwCCzHCi9JRtftqN4gMMAcklNP/ms1CtpsXCeBzw9159w2TG4rJwLCilaeV3w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(53546011)(41300700001)(6506007)(186003)(83380400001)(478600001)(6666004)(2616005)(6512007)(2906002)(31696002)(6486002)(36756003)(86362001)(44832011)(5660300002)(66556008)(66476007)(66946007)(4326008)(6916009)(8936002)(8676002)(316002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1I5bnU5RmJBbGxPSDdyR00ycnM1OW5uRTNyRTdHMXJ3aFRPQmMxTzdYelhQ?=
 =?utf-8?B?cXFrVXE3cEtLNjU1UElWR0p4RlVoSStZcjVWZ1R1eWd0dnhPcUdDbzRqNWxy?=
 =?utf-8?B?VVdIWEtZNXFkTjB3c2F4K2Yxc1dyTFlDMzNiTkVnZ2tWSnkrclBhSGc3blVz?=
 =?utf-8?B?MFZuMi9PY2hWdXI1UFlsWjNhdU13WHM3MDlhc1k4eHJXVTIrV1Y2MFJhVHJr?=
 =?utf-8?B?T0daSDFxdU9CdHhNWjBIQ2hvVHRPWjk5djAyQUlrdG9GOEJySHV0Wjdvak1r?=
 =?utf-8?B?QVZVY3V0eGxMbVR4Tkd3WFRSejY0S2docHRwSmNJejltYXJSNkYvbFVEZVc4?=
 =?utf-8?B?ZXdTY2ZJQ3NmcGd0UytyaHhIRHl4dlBvYjZKaXdHYnQzaE5sbWcxMW92NnQ3?=
 =?utf-8?B?ZUFrREVCclpNYlprR2Ezdmd1N2N0aDZodlFnYSs0Rno3QWFjaEQwOWZXWnc0?=
 =?utf-8?B?UDc0THJiYkVBOVg0NHg1VG9BYlR0ZFBLVDRoSFhyM25jemkvaWdJZi9udzZp?=
 =?utf-8?B?amUxMFJnOUUvSUU2RGR3VnJzUzQ0MTdWVytKUmdIQUp2NzBBU2pFMUpKaGpU?=
 =?utf-8?B?cGx3VWNxVGJwNjNqOUFnZ3JIaUt4SXdVMmswR0JNaUZ0T0FJNXJLemp1TXhQ?=
 =?utf-8?B?Y29sNHNNMml0RmFXOVdNQk92V1RmRmJaRFhiZkdjWk8vRlJsdjArMVZsQ21m?=
 =?utf-8?B?SFlCbWxiQ21ZTmlLOVFZLy9JTElEYjJDeGF5L3RPdzVMdFBsZ2lqTml6c2dy?=
 =?utf-8?B?d0htV0VBemdBSXJmYkVXd0RTTzVYRlhRQ2ZITE5LSzVkOXIyMnFUcWFrRUlh?=
 =?utf-8?B?eVlEcERJZ2xUV3Y3UzR2MEdpdUgxc1FnREVkazRid0ZSdzkwTWNQeG9MMFox?=
 =?utf-8?B?d0dPK1h5bTB0RHJqSXVPRThsaHRoNFRRb2JlRm50Q05wcFlBWTZER3EzSGU3?=
 =?utf-8?B?SG42SEJqQlhkWUVqQWlwd0xTNGU3b0l2WmVzbUFpWG1teVl3ZnlmVXVpeE5s?=
 =?utf-8?B?S2hHaGkvUHlPTUc1alNqU1lYUHFVd2lSVzFjYk5ONzVrOGNBLzhIVS8wRlRk?=
 =?utf-8?B?SXRPVldGUnFYcjZZRlJkWllERnNaNXpiZUpieU1aVHVwNXdRRzIxdjNWeCta?=
 =?utf-8?B?MTMraWdxMytITG5lWTdLV3ZjOFNSQ0VhRHlmejlCMzdPK0o2cUk2NHJORFlw?=
 =?utf-8?B?YkQ3L0toQkpSdUJGaTFDbklwQzc3N1BVcmlCTWp5VjE4eDFWVnQvbU0vUmkv?=
 =?utf-8?B?TThtbXgwc05vR1k3UmFHOW9qOGFGYUZKYnN3cE9WWnRwMDM4ZkdtWjkrNmVO?=
 =?utf-8?B?bEFRcFBEbmhNa1RtNUJ5N2xhWis1ZFB0RDVuckNiUUFmK0JhNkJvVmhrT1E5?=
 =?utf-8?B?N3lIQ25jSWpPekhjcGwybGNPTzF5M1g1RDhJYnVUd2RnRkNGb0ZjMXNicTdF?=
 =?utf-8?B?S1pVK09uNFJaNXgrb3dqRWZwVUh3RlpldkdDUlVZR0xoaEhsL0hpTm5GeERE?=
 =?utf-8?B?eENidVdkOEZFMitJeW5ZRFltb3MrWCtTZHpMdmFhTDFSTEQ0Tkx4NVg1Nkcr?=
 =?utf-8?B?WEZoQzVpQWhEdDV5bEJqdHZxdnhFSjlDZ2k5T2J6ZzkyUWFOdXdIRDNNS3JO?=
 =?utf-8?B?Qmg1TzVHVXJIRWM1aGQrRGtjYVdkcS92WkxQYXJFVVV1dVFSc2ZkSTFvSEp4?=
 =?utf-8?B?cnlEaStwVWVTRjlKVjB0dm9WMVNPN0NFM2ptSWF0dHNOTm1Ba3JlTkMvUVN0?=
 =?utf-8?B?eVZJMms5VGpsYk1MSVNmbmhtcHZVTDNSeU5KRXM0M0R1Y1NXOWFpV1FDNzly?=
 =?utf-8?B?bXNwSHJDTm5CeUZQSFBwTzFvRi9UcDhMNGIvYzJRVkpGSHJpamxuUTE1cy9y?=
 =?utf-8?B?ZTZRREl1SFgrZUNiVkhLZTlBcFBZaG96c1hvZTVsTkxrOGl0TDJjNzlJTUFH?=
 =?utf-8?B?Q1RJSG9CZEdoU3IrSEdLOGJsM0ZMUkdhZGFxVjFWUDZOU3QvZ1czL2RiOGt5?=
 =?utf-8?B?WVA2OTNFT2ZhZW8zMHpZNXllS1hKU21Edm9OVitCNlRkRVAvZDdCMVFWSEtw?=
 =?utf-8?B?NzM5VnlMRkRqQ21nM1Nackd4UUZmTzQ5UVhXb25DTXNYQksvRGVtemxac1Ft?=
 =?utf-8?B?QnhPOFRxeW92bTNoUFRTN1YxQTZHUUdaMFJickZBcnFZbmRCRkI3YTZsYzQ4?=
 =?utf-8?Q?LgNUapyvGARkSPvooKS8ThM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IP9DudLVifn6yzeMUosrAMWue0oQ58iFxOId8LtV29ZhMbDo91T/WF95o/TCVEvXvDFmm3Z8S90n9V6kOPB3YP3cHHSPlX4rVq5I6a9PDNEKg6SqljvuVt5sHElyqkYAd3x4ihvg1/a+tdL1dnz5P56wRCU9uf9e4hfF2216dUokygGw9CJAnYDXyULvrvaozHbTZW11I/ZeoRcgOUP89IvNntZg06sCC4riE3Xu2v8Cervgpo4Pz4l1XqiheusdTohpPjG5LsTG3k2a9Is1Sbxc83FeFqgg65nhA5zqaHFmqWeM+6InJyGwARk/ntJrp8N1DPmHO2w5xPdgJjt42YdiqmoreJSxFR4qrXyvv2h/9jBjYoy7NIOVBD+daWzM5ldIsdEMq8euGJsMEsGL7DYj3rMJ7ek19xtW2kqpkxvMIrrUGIpL/9V3w8/XEB9VFiNQdz5RPv2aw7JknSIfFWJOLlrHwKnwnTqNslNGh9UTkhC3zGNO8gyl+ZxX79CIOwn/7DIDLF0or1yWbDimjGruuxLfNuEn2EX00qUiEzvTRkI4m5McYlsBN48wAfzKFujGl/+SF8BFhsJyiAy3m/Q1+xvhYvsgW4FuSfaRvuDUquyr9Qa5YiCCIi1zW3BV07QayJTMkrj11ojFIACkTJbav4FnRsElZUfXQOJmShBaw/ptidLBw8gF8dk4Rz2H54azxSyX5DtGjQzDbqpe13oBx+ap/vjrYelpg1AlUTykWO7UU49eNY7K6gQdLWaBtmC/vpa2EYQUahqA4pWu0ImCOrzHC+Z4yzxg7VfsjLo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bedc1ce0-2452-4e9a-1775-08db8c99b967
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 23:00:07.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLanvFRYQx833Mq4XTVDNJkGuQ1SA6zBpvC723t/OBWJJKZeaXlloozsvdXkLLrov0cGGe0CerC62SNKB1QL/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-24_18,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307240202
X-Proofpoint-GUID: MKt1sBSEvYbP70N-TpD7CTEopF99Vvge
X-Proofpoint-ORIG-GUID: MKt1sBSEvYbP70N-TpD7CTEopF99Vvge
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 24/07/2023 16:04, Timofei Pushkin wrote:
> On Mon, Jul 24, 2023 at 3:36 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 24/07/2023 11:32, Timofei Pushkin wrote:
>>> Dear BPF community,
>>>
>>> I'm developing a perf_event BPF program which reads some register
>>> values (frame and instruction pointers in particular) from the context
>>> provided to it. I found that CO-RE-enabled PT_REGS macros give results
>>> different from the results of the usual PT_REGS  macros. I run the
>>> program on the same system I compiled it on, and so I cannot
>>> understand why the results differ and which ones should I use?
>>>
>>> From my tests, the results of the usual macros are the correct ones
>>> (e.g. I can symbolize the instruction pointers I get this way), but
>>> since I try to follow the CO-RE principle, it seems like I should be
>>> using the CO-RE-enabled variants instead.
>>>
>>> I did some experiments and found out that it is the
>>> bpf_probe_read_kernel part of the CO-RE-enabled PT_REGS macros that
>>> change the results and not __builtin_preserve_access_index. But I
>>> still don't get why exactly it changes the results.
>>>
>>
>> Can you provide the exact usage of the BPF CO-RE macros that isn't
>> working, and the equivalent non-CO-RE version that is? Also if you
> 
> As a minimal example, I wrote the following little BPF program which
> prints instruction pointers obtained with non-CO-RE and CO-RE macros:
> 
> volatile const pid_t target_pid;
> 
> SEC("perf_event")
> int do_test(struct bpf_perf_event_data *ctx) {
>     pid_t pid = bpf_get_current_pid_tgid();
>     if (pid != target_pid) return 0;
> 
>     unsigned long p = PT_REGS_IP(&ctx->regs);
>     unsigned long p_core = PT_REGS_IP_CORE(&ctx->regs);
>     bpf_printk("non-CO-RE: %lx, CO-RE: %lx", p, p_core);
> 
>     return 0;
> }
> 
> From user space, I set the target PID and attach the program to CPU
> clock perf events (error checking and cleanup omitted for brevity):
> 
> int main(int argc, char *argv[]) {
>     // Load the program also setting the target PID
>     struct test_program_bpf *skel = test_program_bpf__open();
>     skel->rodata->target_pid = (pid_t) strtol(argv[1], NULL, 10);
>     test_program_bpf__load(skel);
> 
>     // Attach to perf events
>     struct perf_event_attr attr = {
>         .type = PERF_TYPE_SOFTWARE,
>         .size = sizeof(struct perf_event_attr),
>         .config = PERF_COUNT_SW_CPU_CLOCK,
>         .sample_freq = 1,
>         .freq = true
>     };
>     for (int cpu_i = 0; cpu_i < libbpf_num_possible_cpus(); cpu_i++) {
>         int perf_fd = syscall(SYS_perf_event_open, &attr, -1, cpu_i, -1, 0);
>         bpf_program__attach_perf_event(skel->progs.do_test, perf_fd);
>     }
> 
>     // Wait for Ctrl-C
>     pause();
>     return 0;
> }
> 
> As an experiment, I launched a simple C program with an endless loop
> in main and started the BPF program above with its target PID set to
> the PID of this simple C program. Then by checking the virtual memory
> mapped for the C program (with "cat /proc/<PID>/maps"), I found out
> that its .text section got mapped into 55ca2577b000-55ca2577c000
> address space. When I checked the output of the BPF program, I got
> "non-CO-RE: 55ca2577b131, CO-RE: ffffa58810527e48". As you can see,
> the non-CO-RE result maps into the .text section of the launched C
> program (as it should since this is the value of the instruction
> pointer), while the CO-RE result does not.
> 
> Alternatively, if I replace PT_REGS_IP and PT_REGS_IP_CORE with the
> equivalents for the stack pointer (PT_REGS_SP and PT_REGS_SP_CORE), I
> get results that correspond to the stack address space from the
> non-CO-RE macro, but I always get 0 from the CO-RE macro.
> 
>> can provide details on the platform you're running on that will
>> help narrow down the issue. Thanks!
> 
> Sure. I'm running Ubuntu 22.04.1, kernel version 5.19.0-46-generic,
> the architecture is x86_64, clang 14.0.0 is used to compile BPF
> programs with flags -g -O2 -D__TARGET_ARCH_x86.
>

Thanks for the additional details! I've reproduced this on
bpf-next with LLVM 15; I'm seeing the same issues with the CO-RE
macros, and with BPF_CORE_READ(). However with extra libbpf debugging
I do see that we pick up the right type id/index for the ip field in
pt_regs:

libbpf: prog 'do_test': relo #4: matching candidate #0 <byte_off> [216]
struct pt_regs.ip (0:16 @ offset 128)

One thing I noticed - perhaps this will ring some bells for someone -
if I use __builtin_preserve_access_index() I get the same (correct)
value for ip as is retrieved with PT_REGS_IP():

    __builtin_preserve_access_index(({
        p_core = ctx->regs.ip;
    }));

I'll check with latest LLVM to see if the issue persists there.

Alan

> Thanks,
> Timofei
> 
>>
>> Alan
>>
>>> Thank you in advance,
>>> Timofei
>>>
> 

