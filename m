Return-Path: <bpf+bounces-11931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51587C595E
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 18:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6B141C20ECB
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 16:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439411F954;
	Wed, 11 Oct 2023 16:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4TpUZd1Z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pc7sOeHV"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB101B29B
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 16:41:50 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B354494
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 09:41:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BGSvB9018114;
	Wed, 11 Oct 2023 16:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=b1ydaF6Hwc38jOQXMPulnlrmiwMi3zFh3BkDNBoM6nE=;
 b=4TpUZd1Z78dkAupDSGHWIDY3RPORl3tFqyT/kM1OxhqYL1kgnnR98UFQojIBXr7PfWcc
 zDHFbVn4TgJLkoFty+OBKBfvFHOI5YSPvquaVAkqjlaLYSt7JwUTYF6OMkW1+7Of9/8l
 UGKx2Jyv63dBr/BSJ0wnJleYCpbxyKm7KaKcVLQ1zSf5xL2S1V1Qlh++XkbnsYy8kjmH
 vwViqyGkLVpN3i+zSiZNhjKK7rtI4gJzxSa+b11LG8FXcOj9ZknvB1jYxW8ja+7qaYMz
 aV5uOBQ+dXHwvXZuAvgf3mPypejdF45USRtxJYoXxfSKhfprmCwR7PMXuK+1ApnZY4oF Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjxxu8na6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 16:41:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39BGQQhl024307;
	Wed, 11 Oct 2023 16:41:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwse9uy9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 16:41:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWCzuWBqwdqQFz8NwV9lN1ciet+Tuc1pDdElcd4zEbz6OjYW2oJG/qgj5hTGhyFmBCaUo7tOkrnZpUcYk73tOOwhGli1GIsLUIeHokM3uBRRWKCT49v7RrXz9343eiVVqy9MsN6FSLLLl/JMYTMB99biUQWcnQFLgR1gJNuY1lgDrNQZNoVG3Cfl7i8PHfB2edpiHdFmx3/11A5Q3a33KsK3o2K+XTE4K+cEl0LpmVK8CVwJFinK50mKhbtl4sGZql0tSi1IwEEn7TOsRXMCUxizESiqv060nqQCgaD9a/iFgGc54qg64JxuN/P6aI5wDOB+pkfRxzdLoqIYQMqA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1ydaF6Hwc38jOQXMPulnlrmiwMi3zFh3BkDNBoM6nE=;
 b=Y0WG6myvUyIYtBkqcI2YfI2cenA9Zcum+x6brZyX0jpZXRgWJkcxmuCF9H1lOouJb4a+SgScxCzSROMv2fELpG/DlOHRWSlLZuJFY6TocBfnwzfrl2C+n4NzeyiF1tsmmxLxrNtqEdBQSI2dd6+Z+U7Vb6wa6H1Bk5CR3DlU1AnJ1dnK8IMqSeK9HnarNVrm3f3wyIvz37cHP4SHeH6tv4rxxUn4357bB3E+MsJXlDVHETBVbCEtxHsRBpaj1lMH8paL34j3OQjAiOMKcLeaJ//FtwDfEQYE7NON+aNhDjP7AU+snaBDupFtBa0CpRmr1NILumGoEKe0c6xlw5Tdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1ydaF6Hwc38jOQXMPulnlrmiwMi3zFh3BkDNBoM6nE=;
 b=pc7sOeHVI8tQJJaLsM7MevVqGclMqvkA1lFxPF8JccQC0r/49Ud83yeeDzYpBvd6ux0LwqVTH2wKkVbHcRiGM6bQkHHhU7s9WWzjsNrDjjPrwJEivEKkFBReHnt8m2B/x2cv43c/3NSxvfgK1Esba37/tD2ODp/9Mr4se7taOLI=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.37; Wed, 11 Oct 2023 16:41:25 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::9914:632d:759e:f34%7]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 16:41:25 +0000
Message-ID: <f822334f-335e-bd38-09c7-95c69086ba6f@oracle.com>
Date: Wed, 11 Oct 2023 17:41:10 +0100
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
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <b7b61031f41ab4082205ed061bb66cb859bd1f0d.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0142.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::21) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd60b94-5017-4321-878e-08dbca78e8aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HWxTM7ca5Gw/nVHbYgEiKZUa+30CzWU+kkAwdLp8gRHKinu/CoczkUd8R8vHHYdFzDQc5aPOk6kGUwVmXUnX502wSGuofZduoWvusxKaMGS/sQrpF1V1jpMFSGR6s+s1EAVGYuPXwIfCb/kNs38wFQT1sIAG3grJE1fqp2gazLlBeRBICXsPkrLhnkYySZCRbSuWjM9TI3xY28cQiOfvXVJYahtgEUgwnAwPWA4pRew3ywD4JpWLTJ98ZQMlqih7CUnV6+sADMURL9U8KK3agrrXXM9V9OIGKDdf/jZI+oeLh05bOSTtYNgNh2F2Pm5T6ZtOIasZoOpGW4As3SrcHYkMtTej6OsmOp38u8QwAzRS1OnolOelt14ext3BXFoclgOFKrVlJJrbFh62WIzwG18FxKbXWINSrdKoWt9tB+LJJNmhVgaDXY7aPtVxdkC3ryw2JU/L3M9QJK6/9tFicll3sijwsZtLikIpPXjjIsPMRSS3a2Eo4vw3aPtaCSWhIuI6QDwGGF3PfSmZiD9hTevBWJ0hCFL4CTZ0xlNhfrRuTOfdN19av0kpHRJ1dQImr713COhTpG8TcOtFVAG7jPh63NkfP3Lh+rwcAqeRElNJLm3Uul5jhWJXX+U/sYr11wLNl+EM0SG/lpzcZnDchQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(31696002)(86362001)(38100700002)(36756003)(66946007)(31686004)(2906002)(8936002)(478600001)(4001150100001)(6486002)(6512007)(41300700001)(44832011)(5660300002)(4326008)(53546011)(6506007)(8676002)(6666004)(83380400001)(66476007)(7416002)(66556008)(316002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VXY1cTVLbE1nbTNYeElnamltUGwxZFpnWG44cGVhMDRVdlljZ29QOUxrT25V?=
 =?utf-8?B?U2pEbHE3WWpZRmZic3JtYWhzNjlDdHczV3dOamZvZ2EvOUxyMXBJYUx3WHcx?=
 =?utf-8?B?WGJEQ3YvV0swd2taSjBGWGVJTlZGbHIyM3RsSlFUMktsTVVmS0tvMnRvbWNO?=
 =?utf-8?B?VVMzcC82MHdVeEpPeW1aOUFuVlVSMGU2UVFxcWtYNjd3OEhEajV2azNhaDk2?=
 =?utf-8?B?ekhNemRYZGpYTmJjSEtJNldscXYzbjJpNXZRV1Q1SGF5VEZOa0tYUVlEdlpu?=
 =?utf-8?B?Q1ZFeVhVMno1ODhuQ2JMN1pZdnlZakh6VXFKUVRzZnljY1F1RmU2L3l3S2ls?=
 =?utf-8?B?dlJtWmdXeWlSU2FuVlBCdWFzeEh0aEMyelJNTGNXR3BZczZTVGh6Zkw5ZXBV?=
 =?utf-8?B?VWtmUDAzTGxkRWFLbHZaWnl2a2gzUFdxNlkwaWNDV2s3VFE1Yk9kMEJlNkhU?=
 =?utf-8?B?MnhUMW9EMnlQWlFKUVNlTHJzS3lISzZ4UFlWWEJVcitxbHh1dVozd29VQ3l1?=
 =?utf-8?B?K3dRRndkeTJVRjN0WkllSUtwdjZYalFjWlM2L0pVeHAvOS9EQXFNSDNYOFda?=
 =?utf-8?B?OElPWW1ZbWFoZFhFUHRPMlNGdFd3ZTlpcXF1YmM2aUttWEtrOGZtZ2dTY05M?=
 =?utf-8?B?N0pRWU1PTFEwTnNCckp6MEF6dDZVbVBUL01sSUg1MnhPRm5MTmZhZ3ltMyt4?=
 =?utf-8?B?MUkrVWgrcnJDaEdndC9FZ0hXVE9ZT1o5WStVRVNQSDF3WXBkUGR4N2d1ZFJD?=
 =?utf-8?B?T1NvK2tWQVZQeVVBTmc1UjlUbjMvcnAweHd4RytkWUFBaUFYT3N5aTl3MEpO?=
 =?utf-8?B?ZlRFSDB2V0pvSjM3TTdkNUhRaTN4ekJjZ3VPdzkxVXdxWkNySm0rWVdwcit3?=
 =?utf-8?B?VGxYbVB1eDVzOUh0bUMzVEdtSGZNWndVTUNkeUJQenNhNllTUTRtR28vdDlQ?=
 =?utf-8?B?QnZrcHExYTBwN1BTcWJQcXlDdXE1cTQ0QUZYK0N6VysvdDd2UWpmaFhPVjR6?=
 =?utf-8?B?R1lNaEdZMzRhWjJXOVFmTE00R0p1bEZwWjFhYldaS3Q4UW1VS0h0VHB2OEwy?=
 =?utf-8?B?ZzA5SVFOajJIVW5TbUplc3hRZFN6ZnpQQ09uVzNyTUJxZVVBVVlmcjQ0Qy9D?=
 =?utf-8?B?MTZCcFBkZEZheE1BSjR2RWZieTh5cFZKR3Y4Tk45Vjc0ZXhVYndpK3k3c3dY?=
 =?utf-8?B?Wi9wa1M5QmZvTUVkOGM3dlQwdjU0RGdPR0xycjJKWVZuVUdXUi9ZMzNEQ05F?=
 =?utf-8?B?ZTcwTHNhYlVqbzRYKzcvTmpTb09DajZydUkxUW9WVEVUWVd0bG1Ud3ZOZXZY?=
 =?utf-8?B?WE1nMVR5VzZCTFhIZGR5dkVJOWMzM0JwVWltZFBMZ21DZU5CTmdTSm5rSEdT?=
 =?utf-8?B?TEl6TExxUUlwZDNRU3hGT1BiYnRxYUQ5blUwZW01dGpTZC9WelVzb00zajU0?=
 =?utf-8?B?NXkwanJSNzVYRUFOUE0vQUo4Rm1Xb0lwQzl4anFkY2FkdjlmVzJBWFJQUVlk?=
 =?utf-8?B?NUEyeVhZOWo0ZGQ3eU8xK0RiS3FVaWp1ZkFDazZMUUUvSjYxZWhxYVBER1Zi?=
 =?utf-8?B?cWdOaFByTjFuY1Mra1p5Y1VGS0ptTmdMVUpTMEpXWVZDQ2k1c2hvL3owd3Jz?=
 =?utf-8?B?QWJ6VU4yYWRtcVd6Qk92UFAxZysvcUE3Zk1WcXJDUkl0WnZsU3pYbmlEL3BZ?=
 =?utf-8?B?cnlXaTFUU3FIeEZLS1V3VndadDdoVmxQb0VROUJ6Z3lBQjJ3TWtnSUd6MzZt?=
 =?utf-8?B?bTVPZUoyS0tOSTEybkpsek1nQTVwUEdEVVZPU0taMVhMelB2cGhSbVUwSzRQ?=
 =?utf-8?B?L294TFV5eDNpa3hUbC9NQTNZMjh0Y0l6NmMyRjg5eFVWcWlLQXB0MWhvTnlv?=
 =?utf-8?B?L3Y2N0lLWmNITjFBbEJ0L2R4bFZ4QWxxVGpIY1EzRzVzRk5zam9Ea01jQ2xa?=
 =?utf-8?B?TW1uNTJTbEdvWmpLS3NWTXN5bnJDVitjbHFId0xCZ2greWsydFhWZmFObDVT?=
 =?utf-8?B?L0RuU05QMUo3aEV5cTA3TnBTZCtUeVFDYm9SK3IwWXRZR1JCWk0xVmRCRmlE?=
 =?utf-8?B?WG04QW4yY3g1MHhMYmI1bmJvYmxUUmtxYW5rTHhDVFdvamhIdWpXNGNCaHJz?=
 =?utf-8?B?YjJxSUFkMlpNZTF6bjNWSUMzekxuemcvOVUrYkkyZEhmRHZySDc2dk5nQVVh?=
 =?utf-8?Q?uRDBzbnuzfApBTbd39/oSdo=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?aXNGcndiYmkyQXVRUm80dEpkUGdWOWpaYUxWTkxiVVhGT0tDRW5xVjl5enBC?=
 =?utf-8?B?YXFiUjBSbFpKN2pPcEZ2VGJLeXhXOEF0Z01TT09nbVpXcGJWZUtib1U0NC9O?=
 =?utf-8?B?bUZSa3FnUXVYdnY4ZDFGYXFRUUgwRG4wVEpkWDJHVjFLb3ExMmhZems2bHhO?=
 =?utf-8?B?aWo1OFo1b29DRXpaRkVEV2IyR1NHZjVoYWxmODRtYW1lTWNzd1BjcENPZVpi?=
 =?utf-8?B?SmE4OEFCb0lOMnEwZ3hmRjZnZTRYdHhETEZ2TXdWOTdxSGovMW1vQmJQemZ4?=
 =?utf-8?B?KzFQODl4dXFSZElVL2VpaSsyUVRWc2VPd0hSWkp1VEgzZ1drUGdHVmU2d3ZJ?=
 =?utf-8?B?RlZULzJxY1lDdDNwY0s5ZDhPUnFWN0hTWS9KN29EOHpBRm5Na09nRER1L0JM?=
 =?utf-8?B?QXhRT0d0dUtiWmFBVnBJcStQMlR1R1h0U2FsTTduU3llRWYwRFpaZUJTQ2Zk?=
 =?utf-8?B?a1cwTm1MZm5OUElzUXhaZjlxRUM2NUswVHZHYlNHZitOT2ppMi8wUHRBNXRX?=
 =?utf-8?B?S2NvUEhaZGVqTXdrVUlDb090bUkzSk9JKzlFUWh3QTVKN1pPQU1JYVUxM3ZL?=
 =?utf-8?B?YjZLSEk1MldpV3dpOW9xa2NMWWM5d2N0QmN4bk5uNnZ3VG9mYzR5SVNRSFhI?=
 =?utf-8?B?QUNQM3VBRFY0SmcvN2dCWDZ1cUJRRjZmTXBhK1UyOHZXOWxNQXd4SE1Ta1dO?=
 =?utf-8?B?aUlmVGFpKzFxS2hlV0JBRWU0STEza1VneGxra3JXdTBqRHNSNnR2aXZQWWhm?=
 =?utf-8?B?NUxwZTRkMzRFMWVqV0lVWDRXaE4xU3NQRWN6K256L29VSmRZWDVjTTF2YXZt?=
 =?utf-8?B?OHh0aFBTREVsclQyT1NHS2hHb1BKTXgxUzl0N2o1Y2Q3NkRnVTg5ZEVEajBP?=
 =?utf-8?B?bjFkWThiNVczYWp5bHhlOHQzd2pwWVp5WUpzbnpxSmExN1pJSUhLbGpwSWwv?=
 =?utf-8?B?YnE2TThpaWwxT2I0V3o1b0xhUmpTaDFMK25WUm16WUFWRXNLbUZ1UDJna1BW?=
 =?utf-8?B?eS9KdkVXUnR0eTNzeVNYWE9yVlN4QUtucjNoRnhKQ2tMM0xyYWpEeDFkN3JT?=
 =?utf-8?B?M2lNRmw3VzBpWFZnMWR2UG9NeW5DaU1TT0dmeDR4MFRlQU1sQTBnYldGSktO?=
 =?utf-8?B?YjhZK1NVU01sSGplbEJIb2FPUkVSeFJ1Q01ZV2VBWENVRk92dy9JTzVCdDRq?=
 =?utf-8?B?L0JGaVZWd1AxaTk0TXBYRUdmcG92cDh3Z0xWU1YyVURWc1I0NW1PaTdReDFs?=
 =?utf-8?Q?Tt1DGcZrjefwPzC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd60b94-5017-4321-878e-08dbca78e8aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 16:41:25.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPwgW0RO2EeTsbHOpr407KmYqVIFL/iaDISwr/F+WLGb7/+Ej7EuKlC4Y59vfGP/8JXi1jAyupq/lXEjMxbY9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_12,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110147
X-Proofpoint-GUID: ytYAfWFcWNXujx8P69ncfRPZpNF0gzXM
X-Proofpoint-ORIG-GUID: ytYAfWFcWNXujx8P69ncfRPZpNF0gzXM
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 11/10/2023 17:28, Eduard Zingerman wrote:
> On Wed, 2023-10-11 at 10:17 +0100, Alan Maguire wrote:
>> This allows consumers to specify an opt-in set of features
>> they want to use in BTF encoding.
>>
>> Supported features are
>>
>> 	encode_force  Ignore invalid symbols when encoding BTF.
>> 	var           Encode variables using BTF_KIND_VAR in BTF.
>> 	float         Encode floating-point types in BTF.
>> 	decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
>> 	type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
>> 	enum64        Encode enum64 values with BTF_KIND_ENUM64.
>> 	optimized     Encode representations of optimized functions
>> 	              with suffixes like ".isra.0" etc
>> 	consistent    Avoid encoding inconsistent static functions.
>> 	              These occur when a parameter is optimized out
>> 	              in some CUs and not others, or when the same
>> 	              function name has inconsistent BTF descriptions
>> 	              in different CUs.
>>
>> Specifying "--btf_features=all" is the equivalent to setting
>> all of the above.  If pahole does not know about a feature
>> it silently ignores it.  These properties allow us to use
>> the --btf_features option in the kernel pahole_flags.sh
>> script to specify the desired set of features.  If a new
>> feature is not present in pahole but requested, pahole
>> BTF encoding will not complain (but will not encode the
>> feature).
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  man-pages/pahole.1 | 20 +++++++++++
>>  pahole.c           | 87 +++++++++++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 106 insertions(+), 1 deletion(-)
>>
>> diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
>> index c1b48de..7c072dc 100644
>> --- a/man-pages/pahole.1
>> +++ b/man-pages/pahole.1
>> @@ -273,6 +273,26 @@ Generate BTF for functions with optimization-related suffixes (.isra, .constprop
>>  .B \-\-btf_gen_all
>>  Allow using all the BTF features supported by pahole.
>>  
>> +.TP
>> +.B \-\-btf_features=FEATURE_LIST
>> +Encode BTF using the specified feature list, or specify 'all' for all features supported.  This single parameter value can be used as an alternative to unsing multiple BTF-related options. Supported features are
>> +
>> +.nf
>> +	encode_force  Ignore invalid symbols when encoding BTF.
>> +	var           Encode variables using BTF_KIND_VAR in BTF.
>> +	float         Encode floating-point types in BTF.
>> +	decl_tag      Encode declaration tags using BTF_KIND_DECL_TAG.
>> +	type_tag      Encode type tags using BTF_KIND_TYPE_TAG.
>> +	enum64        Encode enum64 values with BTF_KIND_ENUM64.
>> +	optimized     Encode representations of optimized functions
>> +	              with suffixes like ".isra.0" etc
>> +	consistent    Avoid encoding inconsistent static functions.
>> +	              These occur when a parameter is optimized out
>> +	              in some CUs and not others, or when the same
>> +	              function name has inconsistent BTF descriptions
>> +	              in different CUs.
>> +.fi
>> +
>>  .TP
>>  .B \-l, \-\-show_first_biggest_size_base_type_member
>>  Show first biggest size base_type member.
>> diff --git a/pahole.c b/pahole.c
>> index 7a41dc3..4f00b08 100644
>> --- a/pahole.c
>> +++ b/pahole.c
>> @@ -1229,6 +1229,83 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
>>  #define ARGP_skip_emitting_atomic_typedefs 338
>>  #define ARGP_btf_gen_optimized  339
>>  #define ARGP_skip_encoding_btf_inconsistent_proto 340
>> +#define ARGP_btf_features	341
>> +
>> +/* --btf_features=feature1[,feature2,..] option allows us to specify
>> + * opt-in features (or "all"); these are translated into conf_load
>> + * values by specifying the associated bool offset and whether it
>> + * is a skip option or not; btf_features is for opting _into_ features
>> + * so for skip options we have to reverse the logic.  For example
>> + * "--skip_encoding_btf_type_tag --btf_gen_floats" translate to
>> + * "--btf_features=type_tag,float"
>> + */
>> +#define BTF_FEATURE(name, alias, skip)				\
>> +	{ #name, #alias, offsetof(struct conf_load, alias), skip }
>> +
>> +struct btf_feature {
>> +	const char      *name;
>> +	const char      *option_alias;
>> +	size_t          conf_load_offset;
>> +	bool		skip;
>> +} btf_features[] = {
>> +	BTF_FEATURE(encode_force, btf_encode_force, false),
>> +	BTF_FEATURE(var, skip_encoding_btf_vars, true),
>> +	BTF_FEATURE(float, btf_gen_floats, false),
>> +	BTF_FEATURE(decl_tag, skip_encoding_btf_decl_tag, true),
>> +	BTF_FEATURE(type_tag, skip_encoding_btf_type_tag, true),
>> +	BTF_FEATURE(enum64, skip_encoding_btf_enum64, true),
>> +	BTF_FEATURE(optimized, btf_gen_optimized, false),
>> +	/* the "skip" in skip_encoding_btf_inconsistent_proto is misleading
>> +	 * here; this is a positive feature to ensure consistency of
>> +	 * representation rather than a negative option which we want
>> +	 * to invert.  So as a result, "skip" is false here.
>> +	 */
>> +	BTF_FEATURE(consistent, skip_encoding_btf_inconsistent_proto, false),
>> +};
>> +
>> +#define BTF_MAX_FEATURES	32
>> +#define BTF_MAX_FEATURE_STR	256
>> +
>> +/* Translate --btf_features=feature1[,feature2] into conf_load values.
>> + * Explicitly ignores unrecognized features to allow future specification
>> + * of new opt-in features.
>> + */
>> +static void parse_btf_features(const char *features, struct conf_load *conf_load)
>> +{
>> +	char *feature_list[BTF_MAX_FEATURES] = {};
>> +	char f[BTF_MAX_FEATURE_STR];
>> +	bool encode_all = false;
>> +	int i, j, n = 0;
>> +
>> +	strncpy(f, features, sizeof(f));
>> +
>> +	if (strcmp(features, "all") == 0) {
>> +		encode_all = true;
>> +	} else {
>> +		char *saveptr = NULL, *s = f, *t;
>> +
>> +		while ((t = strtok_r(s, ",", &saveptr)) != NULL) {
>> +			s = NULL;
>> +			feature_list[n++] = t;
> 
> Maybe guard against `n` >= BTF_MAX_FEATURES here?
>

good point - will fix.

>> +		}
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(btf_features); i++) {
>> +		bool *bval = (bool *)(((void *)conf_load) + btf_features[i].conf_load_offset);
>> +		bool match = encode_all;
>> +
>> +		if (!match) {
>> +			for (j = 0; j < n; j++) {
>> +				if (strcmp(feature_list[j], btf_features[i].name) == 0) {
>> +					match = true;
>> +					break;
>> +				}
>> +			}
>> +		}
>> +		if (match)
>> +			*bval = btf_features[i].skip ? false : true;
> 
> I'm not sure I understand the logic behind "skip" features.
> Take `decl_tag` for example:
> - by default conf_load->skip_encoding_btf_decl_tag is 0;
> - if `--btf_features=decl_tag` is passed it is still 0 because of the
>   `skip ? false : true` logic.
> 
> If there is no way to change "skip" features why listing these at all?
> 
You're right; in the case of a skip feature, I think we need the
following behaviour

1. we skip the encoding by default (so the equivalent of
--skip_encoding_btf_decl_tag, setting skip_encoding_btf_decl_tag
to true
2. if the user however specifies the logical inversion of the skip
feature in --btf_features (in this case "decl_tag" - or "all")
skip_encoding_btf_decl_tag is set to false.

So in my code we had 2 above but not 1. If both were in place I think
we'd have the right set of behaviours. Does that sound right?

Maybe a better way to express all this would be to rename the "skip"
field in "struct btf_feature" to "default" - so in the case of a "skip"
feature, the default is true, but for opt-in features, the default is false.

> Other than that I tested the patch-set with current kernel master and
> a change to pahole-flags.sh and bpf tests pass.
> 

Thanks so much for testing this!

Alan

>> +	}
>> +}
>>  
>>  static const struct argp_option pahole__options[] = {
>>  	{
>> @@ -1651,6 +1728,12 @@ static const struct argp_option pahole__options[] = {
>>  		.key = ARGP_skip_encoding_btf_inconsistent_proto,
>>  		.doc = "Skip functions that have multiple inconsistent function prototypes sharing the same name, or that use unexpected registers for parameter values."
>>  	},
>> +	{
>> +		.name = "btf_features",
>> +		.key = ARGP_btf_features,
>> +		.arg = "FEATURE_LIST",
>> +		.doc = "Specify supported BTF features in FEATURE_LIST or 'all' for all supported features. See the pahole manual page for the list of supported features."
>> +	},
>>  	{
>>  		.name = NULL,
>>  	}
>> @@ -1796,7 +1879,7 @@ static error_t pahole__options_parser(int key, char *arg,
>>  	case ARGP_btf_gen_floats:
>>  		conf_load.btf_gen_floats = true;	break;
>>  	case ARGP_btf_gen_all:
>> -		conf_load.btf_gen_floats = true;	break;
>> +		parse_btf_features("all", &conf_load);	break;
>>  	case ARGP_with_flexible_array:
>>  		show_with_flexible_array = true;	break;
>>  	case ARGP_prettify_input_filename:
>> @@ -1826,6 +1909,8 @@ static error_t pahole__options_parser(int key, char *arg,
>>  		conf_load.btf_gen_optimized = true;		break;
>>  	case ARGP_skip_encoding_btf_inconsistent_proto:
>>  		conf_load.skip_encoding_btf_inconsistent_proto = true; break;
>> +	case ARGP_btf_features:
>> +		parse_btf_features(arg, &conf_load);	break;
>>  	default:
>>  		return ARGP_ERR_UNKNOWN;
>>  	}
> 

