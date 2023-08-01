Return-Path: <bpf+bounces-6596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AEA76BB71
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 19:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7CF1C2102E
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B098923590;
	Tue,  1 Aug 2023 17:37:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0C023582
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 17:37:34 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95435A2;
	Tue,  1 Aug 2023 10:37:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371BAxMG005182;
	Tue, 1 Aug 2023 17:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yyyjQ/0HVSwXY36VxENeN01Aq/HSA0sPGbIYKvFw4Lc=;
 b=PAoqe9HDWSZoEl0M5bWCcX/mH2132fEnPHw8Z+6uqN8Az6o6q6TqQzRl8of6XN8EVkO2
 ZjVwKQMXs+SP+e0zYG0FqChv7qyGMbX02fSuw+zzxtWEtwcAEu62A3pWC+nHEEK/sYsM
 Tqa2BjqmUlaT0n8+n8JGO+5IQG484ZkIc7ERUjkGylamU+/a3WXc8VWvNRF5bWK4OH24
 Aw511wF9a6SN92Cgi9ZfuF8hwFDCriyouA8ra+fBr1vhmGVNTziWaELTQ0rIaSoYbycu
 pz7uNoV2/HNmy4DXxHBRN4dEMe68rzUKKUrNge7U2p3EcntYETAZu6qpVzXihDeTWrxd yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4uauwf8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 17:37:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 371GFJ8d000605;
	Tue, 1 Aug 2023 17:36:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7csfdr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Aug 2023 17:36:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF/8BD5MjoIYqbwQFsm3GHAqHmsITpx712NWyAPCUss1z3ot3fAEgBJRxP4xstTwnTBaqFUSwUyJeEpmlztTD5I0YGxPGoUgP6Fjxxcym/ROe+0202FmWond//41pINa0ebMXgXaGe/98u9KyHGbb2L73wdlV0+h1kQ1jHPFxkD7KaQ6Wya4nkS1LfTi0SieeQlnKfPB1hSpmS4RNzyyb8bBz9AZt+1/a7xcs/YnDtNaBnTPqqkhno7WOsyW6KIkdYqquDPql93+dq0kd7+gXgR9PcLctPrpzRVqv5ZYQzBQS7gv0rLC1HTWMfB2a+PPgHbWKcdY7eTaTQYHkfz1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyyjQ/0HVSwXY36VxENeN01Aq/HSA0sPGbIYKvFw4Lc=;
 b=lbOVwEBKuBSGfAQASK0Zfw+INMZ+pax2JyLEvV9i0CYemWpPi6RxwU18JnWJW7cDrz69CPcATOECkSu5QPF9XncWgjysvMUT1hMClt6BDfzftT3fbLh/nzVdLIyr8wjLTCBLpQ5etXpDyxuRRnh/94kp5tVL+fhUZN6mJQgBeJhEOWGya59RhAmMxN7XaYM6m11QjgcD40qQaiw9wqkr7qMRAj5DYTCuRm4Rwx0KPPNehKTCu/nlGSimBRm7VZ36urtc34lMHOWJXpN9D7uwF0riyIf4RHvwzZOibnjk0AfEGzX1p3HiNPIvDGhg4HoKkyVIZqHfes2HYdKcLCUUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyyjQ/0HVSwXY36VxENeN01Aq/HSA0sPGbIYKvFw4Lc=;
 b=eOqzJb9sWhincjFyaPqUlAZRt8jgdStdTnKy1qXL9m7HVgY65JXauqjN7Ut6/PfgazLz1KgGQ0j1iC6M+Aw8ia2AtR5DSg+PP3w1aFAHo2WMRK22vqDGkaCOZgFUT+2ier81S0OhjhE76P4pNpIct9nd3M8+ChroUhTg0htdoN4=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Tue, 1 Aug
 2023 17:36:56 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::237d:96e6:7f50:e202]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::237d:96e6:7f50:e202%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:36:56 +0000
Message-ID: <bba3b423-8e38-ade3-7ce7-23b1be454d1f@oracle.com>
Date: Tue, 1 Aug 2023 18:36:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo
 <acme@redhat.com>,
        Yonghong Song <yhs@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
 <ZMDvmLdZSLi2QqB+@krava> <20230726200716.609d8433a7292eead95e7330@kernel.org>
 <6f0da094-5b49-954b-21e9-93f8c8cecc3f@oracle.com>
 <20230727093814.23681b2b0ac73aa89f368ae8@kernel.org>
 <20230727105102.509161e1f57fd0b49e98b844@kernel.org>
 <c5accb4d-21d1-d8d9-85a0-263177a06208@oracle.com>
 <20230801100148.defdc4c41833054c56c53bf0@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230801100148.defdc4c41833054c56c53bf0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0426.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::17) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c710e7a-459d-40c8-6f06-08db92b5e6be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gio2aqx7jyTEKkNJwphr6Feqm7V+nV6LkkJWOm2jTIR7C47Fs/CM2ysrI37VPZkzd9otyX4eST76WfcXoHiNOgT6oNRpWvxZJpN7UZH+AT/C92h5gTcfGWllxg/1QSx1mc4Car0KCKahIObd7UwUp2Y0oCpGSNXUR8PTbCIdYuv3HUWfNMm1wDVKPXRGe6VG7ArTFlfMI7sIhhq3VWOWZi1aLg9uQkm8fD/a18vewtHrk6MlL+j+rTYibeIksRn7FoeJcG5CigVnhCgrJPhyAHrtX2K9u1PvrNkPopHBA0rA8vO/jn10PUmsZXjPxDqy2stxN1m1f9QEJT4AqiGL4+QV8izmmlszDuR1EPcliae4aaT2g7La7wBKsbh9MtZr+OJIiJoDoez4mDvRdxb+VZKsr1+5PrYOEAlD84WrVJfqrynoXYKFpEOMrk9EY/UG6819axC+p8fAHMUjzYz7HQ42H7bNZUY/BRxW/N0MdD+vi41U3zq5+qHUvMUzWb/4LVaK2FiJZFQBPN3NA+rwmXQpTm/hhBm/JgHtglYExKoFIzZ9w8CjDoIJnQtrnV+6kOZFDltrOsf/N2DhTmBurta3VIFdewnynksVD3y3OHLVQDFY8ksGCK5Vt0I8wxU+AvLvOg9du02saTlMw4Nehw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(396003)(376002)(136003)(451199021)(66556008)(6916009)(66946007)(66476007)(2906002)(4326008)(44832011)(31686004)(5660300002)(54906003)(41300700001)(316002)(2616005)(45080400002)(6486002)(6666004)(8936002)(6506007)(8676002)(53546011)(186003)(83380400001)(36756003)(478600001)(38100700002)(6512007)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MXhnNlZJSnBQcjg0YzhoVmtJT01EcWFqaHUyUCtkRWpHc1lFT3h2bzBRRnJ1?=
 =?utf-8?B?aDltRjBiZG9BVzQ2WmM4V3NrOGh6Z1dtSjBQc01UWHdYdDliVDlWdDFOckty?=
 =?utf-8?B?YUZTMXhNR2NVV2J1QVpNWmpLSS9oYUxYZFdNdXB2THRCSWJmRmUrKytXL3ZR?=
 =?utf-8?B?NWFodTFtMTZkL05DcGN4S0RYVE1JaitLdTJCOC9sbWkwK2Z2RDlQazBuV25P?=
 =?utf-8?B?RGtpbmxZNmd5ajBSanNqZCs0dnZQeW1Uc1hCSHVwa3V1YkhKaHBmN2hwK1Nl?=
 =?utf-8?B?VXVsbHNwVVZOY2J3QjQyWjdVK2xPbk9ER1J4SDF0d2J4bFlNZFVvakp2Q1Yr?=
 =?utf-8?B?S0w1Ym5yRDh3ck9oaVRCaVBMVnliSC9MTFJkdHhWbkplU0c2K2htb3R3L2JF?=
 =?utf-8?B?aExYSEhMcjhXaVU4ZlhRTExoTHd2T083N25PbW5TSUk4NGhFdWRnclJEU2s3?=
 =?utf-8?B?NmFDbzc1ZTVINkp6VU9qcjhnMk5NNlNhZWYzSjhyejRLWnF0bEw0bFZlQUVJ?=
 =?utf-8?B?NHF5eWprcFpualZzZVFIL3B5bVp0OGgrU2tpdTNpY2p2QTJaN0Z2ajJUTVRG?=
 =?utf-8?B?b3Y4UENpbmJUQTdxUlhYZzJOWHFQVUQ1UnQvNmtWVnU5a1UwNDhyVms1U1hy?=
 =?utf-8?B?dFJuSk5SRWlYcHphU0d5eHBTWmlzYkVVUEZiYy9JVEFYTTQrMnhKS2VoSTFU?=
 =?utf-8?B?cnJyODF0YjI0Y2R1cHRtRDJ5VFkwNSs0Y21XZGxFellqN2ZCQytFY0sxRXlo?=
 =?utf-8?B?RC95UUJjZUdVc1RsSkR0OTJIRW9jYmVxUlIvc0JrcGhDWWt1WUhFQU10SXZx?=
 =?utf-8?B?Z05TN2lBRGFtQjR2bnloWHF2T2xmQ0NaTFJQc2k3alVtM281L3dmQ3NVbDZL?=
 =?utf-8?B?V1A3OGVBSFFwQ2VURjBsOENtdFFiQTB0TEcrekFCeWtLNkNTSW9yeXRlb1c4?=
 =?utf-8?B?cXpkSkJiR3JzUnVLb2ZVNU42bTc3bGkycy84aWNkZkkyWkxMUnB5UThIM2NT?=
 =?utf-8?B?MGJQV1JCR0lMdzVoUWVZL1hPZG9uOHRxZm1MZDhoaHRuVWNXeW5hK0Nqdkdr?=
 =?utf-8?B?aUdVRzZ1ZEFNSGFIWEVENHJWbVFXMkUvaldzRGJJaUIwc01NOHhkQlhraVRo?=
 =?utf-8?B?VFpHTnpHanVYTSt3eFhRb25jbkxmTld2RXkvNWdRRWZMa2JyQVlKMThoRDZL?=
 =?utf-8?B?bnB3ZElZcmNKa3RiQW4yUkoxM1d3T2dnbU8zVFN5YXh0NzlHSGVYZ29xMTFM?=
 =?utf-8?B?NGhsSDBlcllMdCtJSGp3VlVyZGFiYWtUelhIWUFMb3c3Z200Znh4S1owcnF2?=
 =?utf-8?B?dEJXeTZvVGdFQmhQcHRTbWN4QytnenZXdVJpbjA2NUJZRGxrQk5Md29lZ3Yz?=
 =?utf-8?B?ZTRzYnVIRit5VUxwdGVzWnlLaTNMTDdoa1U5cEFSR2dJZTU3VVFsVG8xTUFp?=
 =?utf-8?B?emlEL1JBZUpkRWw2azh5ZlFsQkYyTHQ3S05LQWZQejViTlY4R2Fjb0RHUjlh?=
 =?utf-8?B?Y0hydnlmRU5qL2dPaDVUbjVMa1JDUXBQN3QzTVR3cGliZTlnMG9zQlY3T29H?=
 =?utf-8?B?anFaT0MxNXFNdXBvUWRvd0ZEVjBYQ3gvcnN5YlRyREJlU2I2c0Y4ZEZyZTFl?=
 =?utf-8?B?a2dycUxBMDJHQnRmWmR2RFRnWTB0S3VseWI2alI1NkRkYUoveTJzcGxILzZK?=
 =?utf-8?B?QWo0Y3VTekFUZlJ5ZjQ0T21LTkZWb0VOVmhTR3RjM3lQOVEvckwxc2tjNFRU?=
 =?utf-8?B?UEROSHNOVjd4WFA1NjdzS3hrcE93SEQybHdjZllNZCtVWjFYNXgrSkVHVTJz?=
 =?utf-8?B?N2NZbHpiUmRXYVRFVWtQSDhDalVqT3hobDVUalNYMkthWUJIWDBIY0loUkla?=
 =?utf-8?B?SkszbEZHYWYxcldjUkF3NHg1cFR3QlN0WmpMaHF4UDVCME9VbmI2MUZLMFA3?=
 =?utf-8?B?QVNWWUxxVysrRlZUVUlZZUtEZDBZSGFlRS9qM0dER1dNOFRIUlBQd0swLzB6?=
 =?utf-8?B?eTVBcEkydmZ5TDlJN2hjWUp3WlBuTmtkSUcyQ0NIVkxLajRnUkMwRTBmVlQ0?=
 =?utf-8?B?VUtJN2p6bk1YTUVoaVFDa1A5c1l6cTBBTCtPeVU2TVpySEw3S3JUNW90ZWJO?=
 =?utf-8?B?ekZWak1seGt6K2hzV1JmQ3pHblF1RVFyNiszU29zWmRYcUo2eEM2aWlzSUVR?=
 =?utf-8?Q?6BAFElaKagxse5xuimrEJeA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6knkj/bQVwgdQtMFosfRNPVmCuVHGTqzMOorAt7WC0O3oU+OS9Jb0iRBHJruMFbURB3TqvUVj4w4zoxGIVJNfCWicqLK6lRJ6qWb4ftG5hqxaMweWhvE+3cLhg/SnLWN7/70+MyglCppC/EdlsTg9kdmtPTlUcPa9YckZfgr5V8R2EsE36teblRAKv24Kj0Frq/0Hmkxre21fBN+xwX6gCivUdpNVF6PNjBYkPalm0aFSM1Zma1wBZrjZBY0yCE8aj669IrSBVwPnRviPYFSirnEZkK0nSx8MBQQNbfswrpOaNgpd/68go1cZ5OoHhjBte0SBzUk6diflGYYUHwI1WwL3YbrUG/MaTio2ZITr7TUNkG0v8LsQ4zzo5Gj0/XTI6ffqxnEJHROtp6w/6bOyZ3SXP6F39T0Dxpxxu1K53WY4yQqz23SjWKu/eeKx7sXLF9ya7t4oSYOPY7NWJsc+KAtmUvx1xGXb9gS1sHumUARr4Q76XIrONfLj4HLyDoh6QRJ/zhRSf/rnnSxCoSDeLC2BcY0kmLe/foiL4jNsvIZBGGz8yvWGlsQF0MZCetLo7h1tO479KCbuzcDtXs7DFEJV6H8HcqqM85T6l3+Zr9rwD7HMEgBuoQocKAW7+ipp+FkT17uiPc0JMq2Cdl8CUkNuz1kYEL++5TOg98SRT65kQApownNW4FfA3KBcAGTBBvt/B06SclbdCNrZYErECG58+0whx0BPPObXavLtC4Fol6ybdDbVB9ixteKqsULel+xeEq1ZyFd6EbgQxkGFOgk+dR7G99gKILRutA9/Ia2PNZWmgAOJerLZqzFotBZwKKUmB6txysWu2FUIn20wJSQCyXs4F5ybkOWOfLiuXJmLNkV2aZOqp5DMlg5YZiB0iSzFaVqyLOxaEaOqbRAPg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c710e7a-459d-40c8-6f06-08db92b5e6be
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:36:56.4036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ip2BLJZjvsFAC1z6msesXzTQIp1LKAM+2/0ZLZ5J6n/ujOwIRJk9/Jv02l492mQEFdGFTkBL5IbP6zEAbNDbtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_15,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010159
X-Proofpoint-ORIG-GUID: OAJFmtrSYzHOCpBCUix6yizHCjIZS-J8
X-Proofpoint-GUID: OAJFmtrSYzHOCpBCUix6yizHCjIZS-J8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 01/08/2023 02:01, Masami Hiramatsu (Google) wrote:
> On Mon, 31 Jul 2023 16:45:24 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>> On 27/07/2023 02:51, Masami Hiramatsu (Google) wrote:
>>> On Thu, 27 Jul 2023 09:38:14 +0900
>>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>>>
>>>>> Yep, BPF generation is more selective about what it emits in 1.25 to
>>>>> avoid cases where a kernel function signature is ambiguous (multiple
>>>>> functions of the same name with different signatures) or where it has
>>>>> unexpected register use. You can observe this via pahole's --verbose
>>>>> option (a lot of outut is emitted):
>>>>>
>>>>> In a built kernel directory (where unstripped vmlinux is present):
>>>>> $ PAHOLE_FLAGS=$(./scripts/pahole_flags)
>>>>> $ PAHOLE=/usr/local/bin/pahole
>>>>> $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
>>>>
>>>> So this will generate BTF from vmlinux DWARF info.
>>>>
>>>>> If you want to investigate why a function has been left out, look for
>>>>> "skipping" verbose output like this:
>>>>>
>>>>> skipping addition of 'access_error'(access_error) due to multiple
>>>>> inconsistent function prototypes
>>>>> skipping addition of
>>>>> 'acpi_ex_convert_to_object_type_string'(acpi_ex_convert_to_object_type_string.isra.0)
>>>>> due to unexpected register used for parameter
>>>>
>>>> Ah, that's nice. Let me try.
>>>
>>> $ pahole --version 
>>> v1.23
>>>
>>
>> shouldn't this be v1.25? Is it possible pahole is picking up the wrong
>> libdwarves? what does "ldd pahole" say?
> 
> Here it is.
> $ ldd pahole 
> 	linux-vdso.so.1 (0x00007ffd6b1e2000)
> 	libdwarves_reorganize.so.1 => /opt/local/pahole/libdwarves_reorganize.so.1 (0x00007f1ddaad9000)
> 	libdwarves.so.1 => /opt/local/pahole/libdwarves.so.1 (0x00007f1ddaa72000)
> 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f1dda82a000)
> 	libdw.so.1 => /usr/local/lib/x86_64-linux-gnu/libdw.so.1 (0x00007f1dda78c000)
> 	libelf.so.1 => /usr/local/lib/x86_64-linux-gnu/libelf.so.1 (0x00007f1dda771000)
> 	libz.so.1 => /lib/x86_64-linux-gnu/libz.so.1 (0x00007f1dda753000)
> 	/lib64/ld-linux-x86-64.so.2 (0x00007f1ddaaef000)
> 	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f1dda74e000)
> 	liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007f1dda723000)
> 	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f1dda71e000)
> 
> Maybe libdwarvers is not related, I could build pahole v1.23 and v1.22 without
> sync the submodule.
> 
> I also confirmed the same issue on Ubuntu 22.04's combination, which
> update pahole from v1.22 to v1.25 recently. (but gcc is still v11.3)
> 
>             gcc-11.3 | clang-16.0
> ---------------------------+---------------- 
> v1.22          OK         OK
> (ubuntu)
> v1.22          OK         OK
> (local)
> v1.23          NG         OK
> (local)
> v1.24          NG         -
> (local)
> v1.25          NG         -
> (ubuntu)
> v1.25          NG         OK
> (local)
> 
> So, as far as I checked, there is something wrong between v1.22 and v1.23
> which is also related to gcc-11.3.
> 

One thing that is notable about gcc 11 is that I believe it's the first
gcc release to emit DWARF5 by default. I wonder if it's possible that
the kernel emitted DWARF5, but pahole was built with libraries that
didn't support it yet? Not sure how that fits with the fact that
pahole v1.22 works though. If you have a chance, it might be worth
experimenting with your kernel .config to specify DWARF4 to see if
that makes a difference.

You can check DWARF version associated with CUs with

readelf --debug-dump=info vmlinux |grep -A 2 'Compilation Unit'

>>
>>> $ pahole --verbose -J $PAHOLE_FLAGS vmlinux > /tmp/pahole.out
>>> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
>>>
>>> OK, so something failed.
>>>
>>> $ grep skipping /tmp/pahole.out  | wc -l
>>> 0
>>>
>>> Nothing to be skipped.
>>>
>>> $ grep -w kfree /tmp/pahole.out | wc -l
>>> 0
>>> $ grep -w vfs_read /tmp/pahole.out | wc -l
>>> 0
>>>
>>> But both kfree and vfs_read are not found.
>>>  
>>> $ perf probe -k ./vmlinux -V kfree
>>> Available variables at kfree
>>>         @<kfree+0>
>>>                 (unknown_type)  object
>>> $ perf probe -k ./vmlinux -V vfs_read
>>> Available variables at vfs_read
>>>         @<vfs_read+0>
>>>                 char*   buf
>>>                 loff_t* pos
>>>                 size_t  count
>>>                 struct file*    file
>>>
>>> However, perf probe can find both in the DWARF info.
>>>
>>> Thank you,
>>>
>>
>> Unfortunately (or fortunately?) I haven't been able to reproduce so far
>> I'm afraid. I used your config and built gcc 13 from source; everything
>> worked as expected, with no warnings or missing functions (aside from
>> the ones skipped due to inconsistent prototypes etc).
> 
> Yeah, so I think gcc-11.3 is suspicious too (and it seems fixed in gcc-13).
> 
> 
>> One other thing I can think of - is it possible libdw[arf]/libelf
>> versions might be having an effect here? I'm using libdwarf.so.1.2,
>> libdw-0.188, libelf-0.188. I can try and match yours. Thanks!
> 
> Both libdw/libelf are 0.181. I didn't install libdwarf.
> Hmm, I should update the libdw (elfutils) too.

That might help. Thanks!

Alan

> Thank you,
> 
>>
>> Alan
> 
> 

