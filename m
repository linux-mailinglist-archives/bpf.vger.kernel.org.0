Return-Path: <bpf+bounces-2906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0401736689
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 10:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6590A281129
	for <lists+bpf@lfdr.de>; Tue, 20 Jun 2023 08:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11D8BE68;
	Tue, 20 Jun 2023 08:42:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E58848A
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 08:42:29 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C1E71
	for <bpf@vger.kernel.org>; Tue, 20 Jun 2023 01:42:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35K01i8H029358;
	Tue, 20 Jun 2023 08:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=WFlkfHySE6O2+wD9rf4qHlcMuMfQhwo/Tb4SWWplEpo=;
 b=2lX98igL7UUBmchMiinRu8MWU5OjNqi8ZgyCondBwB69TK+Rpmd/IvqGXN1lPBS49gaA
 P2rak25KtSKPO4DCPHPu2+KtqridckF866sH9USGZ23QcQq2ZJHZiO/+tmmvOS8ZnwPO
 gGoh65l85Q7NdwZbFsWVapAhRKd7uPNQc6bsg3398jEZqJdqhMMM188+HT/Co08BU5lA
 iiYQvdXBfxdWof9PaiEKpOmTBI2YKLssejujukiPsVec1NvC0N4VkqWVDOlyRFDOop4k
 ateJVB8ATIVxSh82+PaveOkzzjb2mPhgECUPyR9qmpVhCriifavbuOSngy1fDUl5/BA3 TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r95ctv3tq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 08:42:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35K7JRcK032944;
	Tue, 20 Jun 2023 08:42:04 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r939596fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jun 2023 08:42:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xw8G+yB+yGQ8bk/tmbFF73l9duD/NIkUN6e/wnLFFPNrMgVX4EpkVUwpTa04x8RhPD2+FNPfA6v2xRp4oRsKWylju1ZKnrzKvcqhVNAkJdod0czQ5NjjV8XBq8JPxLu6TOcLy3/4lIZI52l6Nw/odQXxHnEIF61C1xVLOmWA9MBDLhIYtgx3L5o8Ir8zf8W+6/kLXaBJ72FcyvzDdyCxtNnlcayloroKn9wbB8oK1M7kc3T4u9IIELkmDXBXd1RM6NNlU8hOLh7a/Wb5ODrXjZ35sfsY+LmHjqJC8ZMe3+GtYnSnKtuHJd3q1/y6PqI7rCq8X1guQci3OAeuyfvnKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFlkfHySE6O2+wD9rf4qHlcMuMfQhwo/Tb4SWWplEpo=;
 b=YJdft98eQiW3MNGu+fTMEPvVSD89Ki5msHCWHjaDIpwLcfHHqFlRJtB6Pz0DKFQx7/4/Dxc4/McH+oFD8ymKIUB2mtmYG2IEDvFT2t2UEPuZQC0PVAsU/RfBdb5PUrTYtT/Cblx8l2gEsGDo4zX9Xkq51F+l4oPKlE+iY0yI8rIRT8U/Y19bMB5CeHD59O+pCfJd4lyJSJ1GoT+QtQAVu0ibqS/Pgc+dbeTiQNcLxH2LvIUVVnrXCU5lci3XfqsTNLF1V8xxxpVeF3GEzpnKTjtWMNpp5BEiRyrG7183zeiEboMyV2hj1GikMM5ebEN+UBBpO5XWx8k+j2Cqq5t/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFlkfHySE6O2+wD9rf4qHlcMuMfQhwo/Tb4SWWplEpo=;
 b=Koff4QMQEhC7w+0UCnqz+QGnpxSqW62q6HviTCHY0kgqDN5XdwjtFRwZnLBWDnm3ZBE6hZBp1SCBle29Ja8NatBBBZgy27bz0zaMP/0NFuaa85SeYMd9UHTvISbHf6VMd5v6Esv+2zgOpGFUhjmmNXs7tl/lqJxpdbilD4eEgjU=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB6060.namprd10.prod.outlook.com (2603:10b6:510:1fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Tue, 20 Jun
 2023 08:42:01 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1740:1ef6:ace8:c6e9%7]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 08:42:01 +0000
Message-ID: <507a0366-ab31-9d7c-c132-441788fb8cff@oracle.com>
Date: Tue, 20 Jun 2023 09:41:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 bpf-next 0/9] bpf: support BTF kind layout info, CRCs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: acme@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        quentin@isovalent.com, jolsa@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20230616171728.530116-1-alan.maguire@oracle.com>
 <20230617003925.hrzvkiyasj4rwhdj@MacBook-Pro-8.local.dhcp.thefacebook.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230617003925.hrzvkiyasj4rwhdj@MacBook-Pro-8.local.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0275.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB6060:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b758703-9034-442b-2219-08db716a3761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uHdToRmWxSaYhnvARfFMapEckkO8egxurHRrrv2POudlfVbVRKGeou8S5QYhjfYifeqRYWbVJzYxi5jwTwX7lBvxou2aPj+vi7Aj1HPMYZ4/EmzAdZdn40XCWZjJZY5DdiCyKRhpPaRTOiXjdOF4Bkt76ww0sXV7XFYsZnU9ARmOtP01CmENvpnTptMedAsG9bkbn3yjzneybWN7Iu+KsJelpxlfjItAMR78dWCUhFyk3KSxnHmAZDQA1+/19FtCRZDMFvn0l7Van8IWgh8OWaDEtjfccsUByv86sAj6I5jHMZ/cyt6MtRBpOBSK2OsIdiEmJyTlUlnbiNEUvXssfLUH4rGxSXxwIHF9tOPHTphg4xs1b7Y/EOk0KL+4obVrcZ2B+J9ilftue09cinjZaolHBxBtyO4XqcW8J3ozHUuKDf4CJOpP4maoaWeLl/2X+Naih7O5zb2Sr7PJMfYHzVQ12x95jQtdPEYqVu7u1en9cZCnjygRcO/9eEI+Utf+m+Yc1vtNoVwsZXL3AtvX2os6LNqta/W7SyXc4u9F95uAV7B9pIQ7jmXimdfqz4Bv6dFqeFa05BGVk1nUfBnwmgL5yYSuXOIQr26dsTU6oChCwpKihTO1QqeYKhx4Tg10wfLy//723prhZMjCXUcdZA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(6486002)(478600001)(83380400001)(31696002)(86362001)(6666004)(66476007)(66556008)(66946007)(316002)(38100700002)(6512007)(53546011)(6506007)(186003)(6916009)(4326008)(2616005)(31686004)(8676002)(8936002)(5660300002)(44832011)(2906002)(7416002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnZKVU9TcWdxMkVTZE16aFhIUEU0Wkc1eFFENGo5a1VHditqR2lINnd2ZG1G?=
 =?utf-8?B?OWV6Vm5pVnUzN0hBdkZLVzRXSmZTN2dKSVdLeVUxTmQyWXU5dGc0Q3FGd2d3?=
 =?utf-8?B?RkRNVmpkUFJ3Z25Bcm01VmJQNUdmQzVwVVRFNG93bnR4NWpKL1hZMFBlN3hV?=
 =?utf-8?B?ckJNV1pJRFAweUxtbEZpVjFtME1DclRmT3Y0OVJOYTNMSnFhYWVMWW9TUzEw?=
 =?utf-8?B?MUV2Z1JJNGV0b1RiNWM0SG5ZRWdDb2w2QnR5VVBmQkloZGc5akkzM0xBL2Rz?=
 =?utf-8?B?bEEvY0oyaDg4aW9GVVNBYnVDU1lFc25rSldKcERFM3J3TitvZXg4LytkOUlP?=
 =?utf-8?B?M2JadVFIOC9uMlZYQ3RSbGFGUHVTSDFxeU9Ha0hmbWsyc1RkOUJpVjJ2bFBx?=
 =?utf-8?B?NGdFcEw5RnBiUXB3dWQyNHZteTNlTkdTZTFaL1d0V0d3WXR6Qzlnei9vY1Zl?=
 =?utf-8?B?MjRFTGNOSXY1QVlZSzJ5bUVkNllMZUhiY0pHTDFNQW8xNG55cjJUbFR5VFJL?=
 =?utf-8?B?ZWtkZjJGOHQ5WTVNbVg0UkJud2ZUYzMyQktYUnlpdmJOWWE3TXE2VUx1aEdx?=
 =?utf-8?B?dlNiQmlkOGFMRzI1R0x3T2JjYi9MQmJSQ3JmY0NUcWpqMHZNRjF0SEUrcFd2?=
 =?utf-8?B?SFExUnlDNW1IN2x1ZHZhT25NWHJSUlp6YVkvakNhU2o1SmRzOUZKVDVxblli?=
 =?utf-8?B?YTdTTEdocURPWERUU1NZT1hxU2I4bVZ1bkN2c1lqZGt3NXFWdFl6UURkOHNY?=
 =?utf-8?B?eGMrdXV6cUF3N1FXWHRNS00yODdneDJ1eWI2RDhwa3NuWHlNQVFvSlJSS2Zv?=
 =?utf-8?B?ODMyWjhKaDZxWFlHaWxhM3g0S25kT3Vmc3RXaHFmL3dNTThIRkJwY3NIWmY0?=
 =?utf-8?B?WE5YbzVyNzlKSTA2THIzZmMwb3pYU0RBc284N0tsZU5SdEVMcHdMbzJkZUMv?=
 =?utf-8?B?TCt2S09LVnNvYmZnNkZ5ZHJ5WENRU0lSL2hNelJsV2xUbFBQdkdtTzhuN25t?=
 =?utf-8?B?VEF5aWYrbExkclkwNVZRdTF1Vlg5bWlOcFhqQ2IxaG0xWHNmeTFMTHN2bzAv?=
 =?utf-8?B?SXZZVndYSUhpK2ZndnZtVUFOUW1vRzdrNTZMNVZ4cXdiNWhuMys0MzluMkV2?=
 =?utf-8?B?bmxMOTVmbWo3NldqZWxiRk1MbkpEaHhPYUNPVkFncjVpc0FoYlExdk04WlBW?=
 =?utf-8?B?SWJvNGM3MlZHZml5ZXppY0NXR3owRUZ4eGVtWnl0Zkdzb0J3aW95bGw0dnNP?=
 =?utf-8?B?dlN6eTcvbk1JYnpTdlkxTHcrbG51cDhiR0srWXpLTXVkdjF1L2hhQUJMbjFY?=
 =?utf-8?B?WlhqWjJSWnVIbGgwYm1jNVB3bVI1MTBQc0VTSjNaOW9HTE9SL3c0WlZrdlpq?=
 =?utf-8?B?Zzl1K2dIMGYyOVZVZDNmcE1XVlUxS2JHTWFvRWhKRXZCOGd4aDMyUC9wSTU3?=
 =?utf-8?B?S0haNC90aU8yb2haUmxmTGYzMk1LRnl5QUNOQWpaMWIvU3ZTV1ordEdhcGVt?=
 =?utf-8?B?NzAwUFYrZEYvVU9QamtnT2pWS3ZmbEN3aGtWeFF5OFVUMVZhb20zNHJVR2t6?=
 =?utf-8?B?U3pTbklkSVFKR1YrNG44bDBwb3NKNEprUUU3RkVKeWJMYmNPWFRKMzJPVHdX?=
 =?utf-8?B?OXc0Q3llcXgyQ0dFWGF3OWUvdW15bC9INlR2SU90S0xUZFcrUUgzM1hOSXBs?=
 =?utf-8?B?cUovS21hanY5VkZSSVhtYkg5L3E0RW8xRjM4bC9mdWtDenNMZFU5bzZiaVVM?=
 =?utf-8?B?NnVwZHJOOUdERUdkSktVT21ZNUNBSVkvSWVnTWpsbHVqM3hyZkF5cmFqMWxK?=
 =?utf-8?B?K3QrWFYxcGY5cVRVOUFoYlZMUzNmS0FENEtHSzlBbElDcUo4em1iV2RsNmpa?=
 =?utf-8?B?UUpIRnhVNFpkQ040L3orZUhjd2lHc0dkTFd2QytNWk1WQk9WaWpnTS9GZEJw?=
 =?utf-8?B?YytoMVhVS1UvTExVMHJoUTkrUXRGTUZPWkJoYUE2bWFvRlZTTHZ2Vm1LRFRZ?=
 =?utf-8?B?VUR4ekpqTUxFbEx2NlFBRXQwMktjSFFaZTBWUnpBVitNRUIwRCtxSnkrVnA0?=
 =?utf-8?B?cVdpSlIzVUxuVEh2OHRVWWFlZnVvOURhY1I2YUN5QUtkdU16TTdUc2o3VVc3?=
 =?utf-8?B?UGhmR1lXei9VeVlxenU0QTgySGdBeE9Ldm1LTW9PSU9sVGt6U0RLRXNVKzNH?=
 =?utf-8?Q?2wnGZMuRw8hmfFoGXZ0R+4w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?RThhWnJ4YWNnNmNvSmN3MTNYWDdqUGJXNityTWFRTEJuVmNNSC84WElVWDU3?=
 =?utf-8?B?dG14TkdEaVRFUTdMY1JoSm1DOGlURFBaS3lmMkp2Nmd2TE13dkdybFhHVzJS?=
 =?utf-8?B?S0lBY2dURzA1WkJJM1hnbEhZSWR0NnVHZFhVcWZwVkUxR1FwUjQxNHlLSlBS?=
 =?utf-8?B?U3k0TE5lOGNJNHlRTytKb3BWK0c5UG1kTEh1eUVsOFU0YXFPLzI0MmUxeVVY?=
 =?utf-8?B?bzFlVDUxMHpPSnFxTFRrYTV0d0Rua3BjUnZlZm9uYlVvRzF2ODRvSHBKQmh5?=
 =?utf-8?B?TU9Tay9KS28wNlNpczBRMnNQWnA2THVneHFxY0VmTFo0N3FEai8xSytKOW9y?=
 =?utf-8?B?alZUdmwxYTdPS2did2drd3NucFc2VGRBWDBQWmMrajZlcENZeHlwZXpBRHUr?=
 =?utf-8?B?em1oUmhJVE5wYXNBanNub0Y2Mkt0SVNZdVVIRjNZZmJhN0pnY1JERktXTjhY?=
 =?utf-8?B?Tm5qdFFSTXQ1eStOQVZPT0ZrbGVzdWJ6KzJRQzErSkMyay9rR00xbGdrTFRv?=
 =?utf-8?B?d2ZvVlA1NTVUV1ZPRzNQbDVrODFzRHdSWVhyT2tsRDNPZ2pnWjJFc2NORW56?=
 =?utf-8?B?aGlKdmNWbEhEblZLZFdIYnBqWGpBUjNXZ1J1Z2dnTnZCWGozeUpScThXdi9C?=
 =?utf-8?B?WjRjWERpbXNvYTRFVDhxeGtwVGxOcFJUazV6Wi9PZ2N1SitTWFNDSS9uVDBa?=
 =?utf-8?B?emhydGVnbXgwL21NREtOZ0xuMFd4aytubXVMbW9PSkZIUXhJeTJrL21wRFhr?=
 =?utf-8?B?Vm9ZVG9vd2dYVERldDE1eDVmamxXMnpOa2VEVGg1WHpkcS9xRmtYNDFNRWNu?=
 =?utf-8?B?WkFRRGJyakpheWdBWGdXUmlmWkVKNzRpem42ZUxtamtRc1RKdU1zdGdRYVM1?=
 =?utf-8?B?ekZleG9Xa2FsWDZhS0xnWU1qNXFQRnNIcVlBK1dISHpEME1UZllZc21yKytp?=
 =?utf-8?B?RTFoWGk1VGFLd1huWEV5MTE3aFVWTVZQZUQ4NmlUd0hyYVpVZUd0SXcvNWVh?=
 =?utf-8?B?VHpWTmhWNjBCRDJnTDNDUzJEVjZyc3g1eUdWeHpoVjFab2ZNU1VYTUdiRFBr?=
 =?utf-8?B?R2x1NTJIR045QitReVEwQU5SbkU3OWtKZXZVcHg1ajRiVmx3Z2UwK0xzcVFz?=
 =?utf-8?B?QklMRkxWZzVIV3VUajlEcytvanh5amxZbVdUakt5Z3l5ZDZnNzJtVStOZytY?=
 =?utf-8?B?S1dKOGFVSGF6YkNUV2VEY1c4VVVRQ1E1dWpBOVphSlYxWHF5dWVoQ1BoSmpN?=
 =?utf-8?B?a3ZWa3ZyNXZaZ3FrcXZxN0lkMjNqdFVYeC9oaHBzT1MzZ3FqZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b758703-9034-442b-2219-08db716a3761
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 08:42:01.5519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lX7XBKkOUZxLODisjCpn3CD2KOZv5iYI303w8zvxx5PUB6LI7Fgaqjwka1IgRGC31mISuB7etdQGEvIEdCm51Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6060
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_05,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200076
X-Proofpoint-GUID: FOztmv-pVidsKUP0ygTpSCuawoMIuN_P
X-Proofpoint-ORIG-GUID: FOztmv-pVidsKUP0ygTpSCuawoMIuN_P
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17/06/2023 01:39, Alexei Starovoitov wrote:
> On Fri, Jun 16, 2023 at 06:17:18PM +0100, Alan Maguire wrote:
>> By separating parsing BTF from using all the information
>> it provides, we allow BTF to encode new features even if
>> they cannot be used.  This is helpful in particular for
>> cases where newer tools for BTF generation run on an
>> older kernel; BTF kinds may be present that the kernel
>> cannot yet use, but at least it can parse the BTF
>> provided.  Meanwhile userspace tools with newer libbpf
>> may be able to use the newer information.
> 
> Overall looks great, but
> why such narrow formatting? It's much less than 80.
> 
>>
>> The intent is to support encoding of kind layouts
>> optionally so that tools like pahole can add this
>> information.  So for each kind we record
>>
>> - kind-related flags
>> - length of singular element following struct btf_type
>> - length of each of the btf_vlen() elements following
>>
>> In addition we make space in the BTF header for
>> CRC32s computed over the BTF along with a CRC for
>> the base BTF; this allows split BTF to identify
>> a mismatch explicitly.
>>
>> The ideas here were discussed at [1], with further
>> discussion at [2].
>>
>> Future work can take more advantage of these features
>> such as
>>
>> - using base CRC to identify base/module BTF mismatch
>>   explicitly
>> - using absence of a base BTF CRC as evidence that
>>   BTF is standalone
> 
> That's fine to have as a follow up, but with BTF_FLAG_CRC_SET
> the kernel should check the crc.
> Calling crc32c on modern cpus should be plenty fast.
> It won't slow down btf verification.

Sure; I'll roll this into v3 and fix formatting and
the typo in btf.h. Thanks!

