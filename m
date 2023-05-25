Return-Path: <bpf+bounces-1205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 992BE710550
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 07:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA071C20E88
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 05:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009A98485;
	Thu, 25 May 2023 05:29:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4B199
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 05:29:17 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7558097
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 22:29:16 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34ONaOpG023238;
	Wed, 24 May 2023 22:29:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=avTDbePANQtADeMC0X4Ngq+mObMFLZLrCOeLzA0cUXM=;
 b=IjmlnAY4UwK/aZoZJMZrHAvLiSeoD+iIglunOySWv7mmSMPpYY4/8hlve4wre0qsvILX
 LitNj1nCTCseq/GwiBiyX5095UKKDyyYFPNbHZMeRLO73ob5Cr6nTHgfpDLe/vgI94J1
 GFw7E2/zhJifB6MI5HckDXC7Ta/mFYCHvUWKZayp91pV9i/uFSYRvxeH59Ri99FuExI8
 WPI8AKI+GBGl+lvxAOe3BvFmQyRVz9RQUEMDkXmZ6DYpeviLDsNTBR1k3Z7M3lq6Etd0
 gr5JdntEn6yo4HLeXRN/YINPcLn+hUoH+l4eRGoQ74Wtj93uC6Re6Hyrwsv4ocMky5Gb TA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by m0001303.ppops.net (PPS) with ESMTPS id 3qs8en1hd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 May 2023 22:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKZEX1WGCZioULhMffYTj10h5jL9K3mOelBUZzw7ZTSKdHgRt4ziH2kdsyEBDGJnzw+/FWvP9bsKpbsHYxX5xBFR0ybhhhDitFT3E+VR7ry+9p+2dwxne35Omrg3LXLGDyBaBzzXgh1G+hawyt+uuV2QHc1wc2j7H4CNVD1tz+eldJt3Udxm25xPSMJYOPt891EefAcMokTzexxVBuSgjmqGBQQWkLlMDeso0szEWVZtKLrlnQUeIyVJFyZjlr5/QZbPWBUsDUH2sZvv4BWIOacsBYxeBjLabWUTPM0yoKUkRq/Bc93Ohpn3QWENgrx5BHQ9PPpTWeQ3EeijkPPkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avTDbePANQtADeMC0X4Ngq+mObMFLZLrCOeLzA0cUXM=;
 b=RPf6zexp/dclU8prezN3JAiC7KF/yfuAVqTZS1codUiFiceMTMbh6aumD+cfWK2fTCQuwoxsNce+wO81F2dRW9rmp25LUfUizbGvz+BjI4zTXegQObscDT3D2lQXiSFVM/uEAexYaSydAohdV/vitj8YzLQ/jhSmqqmkDXMWp24REXZtSTOG+6HRDdnATZwgkTIYzpcJWTck1rI9d6msuV+HKLpdIuuxTbfpciHxUbGcqQyylUcZW8Of3F28sjNAp7MP2XtB5G3pEzC3bLqAr88lXey80Uzjrgta2vI6pNiGwPMKuAPXzTCFVHBtVrzBFrgyX94hnrEPtf0LFa13dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4030.namprd15.prod.outlook.com (2603:10b6:806:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Thu, 25 May
 2023 05:29:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%5]) with mapi id 15.20.6433.016; Thu, 25 May 2023
 05:29:09 +0000
Message-ID: <56827417-9376-68bf-c33b-49761424a2cd@meta.com>
Date: Wed, 24 May 2023 22:29:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH bpf-next] libbpf: change var type in datasec resize func
Content-Language: en-US
To: JP Kobryn <inwardvessel@gmail.com>, bpf@vger.kernel.org, andrii@kernel.org
References: <20230525001323.8554-1-inwardvessel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230525001323.8554-1-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA0PR15MB4030:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5a432d-7e99-4ae6-4eb6-08db5ce0f706
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xQ4X60l47O4Pr0sMH7ZCIhynbLiYYRGAIvcQi8/Fz/oYSBANsBquU68TwwOl1CHepfkJBkxCPEIrvc7zHQ6ic6BddVMine36RHEe3BAaPaTVbk9v5EYLmMH8NZO62ZrO/BxXGdwPwx2J83R7YKdi+zDy3TL5sSlkKTdfdR37SQ8QuH1XnB8h54SLA3bUf9sYNFxsTB8Pvr1cClgRblS+dzXAeq6TyCLg9JGufNJlqDdjVY2p/r9yxP96I1PwhRAFuBU79e1Bz4t57ka/Deyf0UqTckkp96kXzyJsuOcSGoRSwZnnWztVbXOx22jw26hdzXefre+YDLX7KUgCSuAvPF+vfKV2pKfpxnt/G6qGeApXSAsvZsO69Qq8wybxSlICO0QPoTiFI307nwusPUHhzGohxVBsaDtH+8Kla5y1hnIYmtz/PZP64Z6Hp7UOWAN19qDFdHnbpYtGL16EyNIwd8taftk47MK3zBf5vF9dwKpwhaRpL7xutUmmUW0eCHFo1LNmKxZVexlOp/S+z/4RocGwia7sxHBHiKmG4jyiqDQVdABCwPFR+pPZSD9PUpqOlMzJyVbj4j1M5HrS6jlS5HhQxhJzKOrDbaXxKweJa7gcCqs4rrqMD7v2u1NWj8w4PA/XR0EAXfWxQEDxMy4Tng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(2906002)(2616005)(186003)(36756003)(558084003)(31696002)(86362001)(38100700002)(6666004)(316002)(6486002)(41300700001)(8936002)(8676002)(5660300002)(478600001)(31686004)(66556008)(66476007)(66946007)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UTNkTzRNWW9aQ1hYOUVObk92bnVQMGNsR0JnSjRRenpRTkhjcXFJOGcwem44?=
 =?utf-8?B?SXAyU1Z6VlhnOVA5cm9xMnRkTlRoUnpkaG55TFc0MFJHNTZCUmNuM3B5RWFi?=
 =?utf-8?B?V2V1ZHhocW9acHA0T1NLNFhXdkNhOXV5WEM2YWQ1YURZcThZMnE5bEZzN2Vv?=
 =?utf-8?B?YU1zTTJSTmMrdm4vbzBOcXBQd094Rjkxc0FNeWlpQUE1TjhEeHJuSGd0WEIr?=
 =?utf-8?B?eVByVkRvUzdYbS95aGZDc2dWRzFSNkpvN21mZVFDUHlMRDExYTVrSWl0MDJR?=
 =?utf-8?B?SlpMeGNNMDduR2N0K3QvelpxWjM1NER0R0Z2VmxLa3d0WHRSa3NsbmRQeUtQ?=
 =?utf-8?B?VkhkbitkNUhLdHBmYnJxTXl6MmRWaHJLcVNUOG5TV25RQTd3cGQ4L0JQaC9i?=
 =?utf-8?B?VjFlV25NN1Zmb2M0Y0ZVaUxxUkg0VjNLWnlaOHZTRy82S05yMklHMTMwY1lE?=
 =?utf-8?B?eWp2cUFvdkRFcFVDbktpSHJlNGYrTFI2MEFaM01pV2xVOFFjODQrOEFpczlq?=
 =?utf-8?B?QnByNy9WSjZhSE13U1lQL3Z2YmdHeWFEQmIvWGNZd2kyeENjWml6Vm50QWdF?=
 =?utf-8?B?VDc4R0ZxeGo5bVRzSFNoZ0dqMlpQeFpacFh1UWhJUytiSFlNUWJNQzhQeHJT?=
 =?utf-8?B?OFI4WGN2emdOems1YllMQkR6UkdLZjJzcHZrcDRHcXUvbEg5RFAzbG9xblZu?=
 =?utf-8?B?Y1VBc2RSTDg3Uk9vK0laelNkT2IvNGNmNklwSG5sdFV2MzhrVDNMTFBGdDh2?=
 =?utf-8?B?TnBhVUkxNHdwYmpkNnBZd1FqMTBteStMUjhCNkhoNnJjTlNkTXU0a3RkNTk0?=
 =?utf-8?B?M1g4emgzS2ZHOGFsWWRSQmV2ZFZ2L3hGTnUralFBeC93VkFlakpHUlFGS0Y1?=
 =?utf-8?B?NE11MVFQbjNDcUJHYWs2bzc5NGxCeWJBanV0RFprZFgxODJmMGJPTkZzMTFP?=
 =?utf-8?B?Z1EwZzRpeitjSnBSeFlNREdtUkZvRys4T1JrUmNxQSs5YlhiUEtaaDE5dUE5?=
 =?utf-8?B?RzF1MWdTMngxN05XT3l0OTFVUk9yNGFUVVZiMjVKZVIzdkZvMUJzZCt0WkJv?=
 =?utf-8?B?M2tpY3JZUXhNeTA4dGhDMGZacFQ4SlVnU0trajRDZE02S0tYcUY3cW9tVkFw?=
 =?utf-8?B?d1AzdysrZ29MQWVFTVNMOUJESGFhcThENFArL0krNjJGanEzc2N2RURKTk03?=
 =?utf-8?B?bGp6ZXRzeDUzQ0ZQdWgwNnlTK2JUV1d4cVhLOGRONFROYmZQMVVRdGNXb1ZM?=
 =?utf-8?B?YTJsVmp4UUpTSHZ6TFZiUTNhN214Zm1OMUVsbTlUR21CR3JwTXhVOTd4VEhO?=
 =?utf-8?B?TVJYU0ZmajYxaUJUQjZudmFJcVJiekZaVWRyN1dJVnRjNHNldmVyc0RrMmk2?=
 =?utf-8?B?QWJiQ3NCelZLNUE5dUVLY0p6QjVwWEtoODZReFl6cTN1ZE40N0hxUmZ4U21u?=
 =?utf-8?B?bkc1MVhKakJSLzRsQVNtSlJsWW0zdHBaQWFmYWN4a2RiNWZQWHppVHRBdFA4?=
 =?utf-8?B?cGQyc3k1S2dBZ3czcnhGQk04Mnk0aEF5WDVDRWZJMWFsRDlnM3NkNVFWMEQ2?=
 =?utf-8?B?WTJVeFRBcHo1NmRkeU9FdXNMOEN6QW5qWVhLKytNTnRkQytzdkhuZDBDR20r?=
 =?utf-8?B?bDd6STJUVWJOd01xaVlxUXlZc1dhMkZ3RXM4cUpYa1p0cmpSVzM2TjYxbStS?=
 =?utf-8?B?NGJJc2lBZTRCRUFwRUlsVU5mMW1HYUlGSDBGOEZXSXEvZkpjWUNEd0M1aE5q?=
 =?utf-8?B?cXlrK2V0Y29YOXlJOUJWVmc2Ynh3M3BEMm9OUDRsWnZpZ3ZNQ2l4UEdtM09H?=
 =?utf-8?B?SGpKU2xDdDJRa3J2aDhJdHJYeGNMSW5xL3pOc1p3anNtU2kvOGVCN1k2ZUpx?=
 =?utf-8?B?czI1dFZacGdEWDJ2dkVEKzVpYzQ5Y1BzUm84ZnNKRmF0RUVLQjQzZWV1cVI3?=
 =?utf-8?B?QzQ5dC9aRjh0cytIcGpyZzhyZEpqZGRJYUJJNHVTeVZiQ0FtR3piSk9zWDhQ?=
 =?utf-8?B?bGhVZ0llTGc1aFl5M3RndjNtRDErRU1LUm9zY0pnei9iTC9vcjRaTjBYdGR3?=
 =?utf-8?B?Y3hwQXpFU2V3ZFRFNld2K2NtRm9TMVRVSlJGNTJzcndnNkZrT0p3SDFRdlov?=
 =?utf-8?B?b2NVMFhsdGdMRkxVVnUzMGwxQk5PcHkxb1AzbTZtVFFWS2NxUHJTRlBhTTNT?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5a432d-7e99-4ae6-4eb6-08db5ce0f706
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 05:29:09.1660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQr8fl+jJD/A6o1MnXt18bRI6MUX76BILeD8MDNsLphk4X8Ue9fVYWESYxIO33yX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4030
X-Proofpoint-ORIG-GUID: hVq9SQ1rLYQQ7NenxSoYve2Qc6YGRB9m
X-Proofpoint-GUID: hVq9SQ1rLYQQ7NenxSoYve2Qc6YGRB9m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_02,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/24/23 5:13 PM, JP Kobryn wrote:
> This changes a local variable type that stores a new array id to match
> the return type of btf__add_array().
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>

