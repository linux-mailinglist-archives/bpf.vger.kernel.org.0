Return-Path: <bpf+bounces-16062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E61C77FBF24
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 17:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4539BB213FC
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB01E4AE;
	Tue, 28 Nov 2023 16:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="No4KQIjL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GgUa+Vp5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECF2131
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 08:23:20 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASEjG7i032457
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 16:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=L2dThK7tdXuNLtIuyfzpXVGcgeuZxh7BPu5UYI1g61g=;
 b=No4KQIjLY81wTJRWAqdszcbT9B7nA8ZHoJGACvhZ4sbLH4lCXe+UFFONZ7+PVIEgUmLS
 eUQJcy2IicFYjpDCF9Kka5GrhcfnwtkqGBmJ7DQu02oatwGDNq/egwVAynHnxeifg2/P
 eBhNZpwkeSss5LfQsn0AlLwct60KID7go5RAS91Y7RWehwz2iXroGQm2iW/tuKwkaxFG
 He7pLxrdNcak/AVs0SqF9ykSk6cx+AtZye4qC5CG+yWYhHkHiK0nP82cD20q/L8jhAL/
 7ZdzC2+pJq8QsELtPRTNlro7MDKBhQXlhCCP5DKe6EmDCifbxZJq0BzvZN548lhLrL/d 8w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3un1rxj89a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 16:23:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASG11Tw009221
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 16:23:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c6vudq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 28 Nov 2023 16:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp58YT8r8U3DU+3QIot2A1ZMGGaCPv2uarI5pxwrnYDfmErojyVxl6wIlrN9kokDysZgoL6k1QJUa7M49ZwZIo1ADfgk/oue32kOdSt5ecxZWkRes0g6ZgYMblxD1ofkBjBJ2aBoyCUHRVCVaBBu+ph7lFqrhK6tD3t2Vcm+BEzyECrQ7tOr0VR3+DZQPubHJ14CI++PnvxXLZ6fp+HIV+g7tvCWbJKyM/BE1BuqL1sRjXjchWRyM2n+UPgcQ9n97El6ugj9ZZFM+oBbLf2zauT2zdQDFsmsPOz9cbseXnn/fdnwFn42WSrddzpwwX03ly/B4OvMEEhlpqb1HNHd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2dThK7tdXuNLtIuyfzpXVGcgeuZxh7BPu5UYI1g61g=;
 b=SlHFjbaElee4/kH4ypAj4VxJkIPNl855ETr0hsx4UVWL6ZTBOEaGvVaz7tS067qIyjlzRIUdO12g+8cSZYKDXvC1omYdQ/vG+uVDj96CV0ogjepyH6B/6s0BcYylmdFzN/aXkOsPNdA5BiVt3qeRVWpL4+Prg5F5rOlJPI2NWLHAsuLLoLeL7qZDqN+m+yCQutcRe8cjlbNdao4Yue01Cc4oSrGtVvfm6vZSKRNbCSpwHkfvxX1aIqLdkSJRG6kMsxVc5+dbDmgSB+tFcrrzOolOAhEMCYC+dAHp7iDNCKNZEcEbM66IrUfQoI4RoNw02UmmgDJy+MSxjdgr8KlaLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2dThK7tdXuNLtIuyfzpXVGcgeuZxh7BPu5UYI1g61g=;
 b=GgUa+Vp5R7lIf5OFnpcAHflHOGTjBqI2DgfRbg3F1Is8KUX1QjY/HfVdLYJwQYs7RJvYq0vZggrf4tJLJwzpWMMhr7t7/au85wobPR35WhACko1bOiKBOCmxyEfnl7PkVRn2wGa0WVAGOnz6DVPAS7IwXY9cCEeIT1egsYqPFsA=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 16:23:10 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::ba16:f585:1052:a61c%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 16:23:10 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Subject: BPF GCC status - Nov 2023
Date: Tue, 28 Nov 2023 17:23:06 +0100
Message-ID: <87leahx2xh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::16) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ea5ab0-d190-4329-be9f-08dbf02e5025
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HuNvqkHhidd9jdE6lT8BruA+LjrsrJFl8YDkLifH4zbKCa52VgUtq4yseENsxAAwFLUIk2ahxD7Iws8gHaz7q/Xj4qM7r2pFZ2Z2B/4XxbJvClOr2ZwjM/7jJTh8BRb1yMac6ABo6hfMVn5LIFtnfaBFM1DUnjvc/6l1ghPQwQsuLzeK1tXYnubLSGuNhp8J7QPw2A1W/8nl5Zy2RfXK6BDMlhgIe7iIRxI42h/sYOzZ29MamzJq0r6VnHYkoU7J8NzJDLIoZpQ/luIP7kntIowprHy9BDwla7EGFFaln9F8+rC1aTCXmcdtrVnuuIa5XBG5tple+75nwyuiClogEoY9617F2MfXiQPxyKXoxefhbSmqJwcvKYMQWagI7xU0npILZsPy8o1MbfCobQFN2yEeBuaCKmuE84Ad+7JFrJQ/YT5m5xpfu1M9eA3OLPDcr3BxUZKAw9BJq+dBwd774Ec9FhTOJgbwWnoVgWXmrCZ0Siv4FmfQifWWc3xWc343TWoOSviOn6tK7U7q7qVAJX18vYlZxcjfBUoB5xj07beEtLm9JJVPprr7o9dr/bBZ0ya2yNUQNUTI85QdjGBNNlQ7Ty0X6/jfqkC43PnUDfBFeQO4AzyQPONM9odiEIGbX+Dx13QpUxF7t9ZgOwtuWqBesyFbZz2j0Q6VG3NdWUM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(41300700001)(36756003)(86362001)(30864003)(83380400001)(5660300002)(84970400001)(26005)(2616005)(2906002)(6512007)(6506007)(6666004)(8676002)(8936002)(478600001)(966005)(6486002)(66556008)(66946007)(66476007)(316002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVlScElBQmJNRkdXeXU3RHhyamlraG1WS2NPazZVNERPOHR2M3ZlU1d1MjJX?=
 =?utf-8?B?M1luWitYUFlvaFRzekQvMVlNS3BSeE5pSWxpRytzY1pUMis1TkRMdWxQcm1I?=
 =?utf-8?B?T3pBWkphUE5heTltc3pGVXZyRXpra21OTHVQSWNrVzNwL0ovUld5RHZteHRw?=
 =?utf-8?B?ODdZeURzS0VIcU1rcXUyRWc1T0hsb2d2eVgyUG01dUJLMmRWVDhESmRTeEtK?=
 =?utf-8?B?LzJYSm53dmtDVVVpWXREN0pqNmt1Z05hcllvK3lVU0Y1d0hOMHV4d0JTemow?=
 =?utf-8?B?YWRIaVpobmVyWWdpZmw2NEVMeTF1YStuOUFLRjcwSzM5R2tJRGRFMXE3cW9J?=
 =?utf-8?B?djNBdHBvWEFIZE1HdUV6RHhhaWVHUUZMNnNpSVBrZncvRWRocGxGUk5uSmgw?=
 =?utf-8?B?enlZRHVIbUhSMDNHK2lzUW9pOHl0eTJ0TkxmNWcxVm9VdDdPQk5MWEdtYWly?=
 =?utf-8?B?SllVejN6U3ZaQ3doaEZjYzVxTXk1QmRJVWFZRnh1M2RaNmhEZ2RXdkFISGlI?=
 =?utf-8?B?bGJvSG54a2F0RHlMbWx6emJuUXliYkhMd25PdlNIMkViZEJiL2F5eW81RXk5?=
 =?utf-8?B?clVDRTZOWmdOMkpUdGROLytuSGpDMVR0WWhYbUNTOXlCTzA2N0R1Tis0dEtS?=
 =?utf-8?B?RVl6TXVjNEF6U2ZEUFJRNkpYaDVGVEc4MUg2c0ZvT0RSWGRIYVR4RVArdVFw?=
 =?utf-8?B?L0NYWGNlZW56aEJpcHZXRTcrMnNZWVArZTJmMG1lZEFBRlhKNkF3RVpmWk92?=
 =?utf-8?B?OWVIZzNQbEFLUjBldk54UFhZejJGRmJFMnU3dXVUbHRURUw3ZVZzaUdQU3N6?=
 =?utf-8?B?SnlKUVYrSUNTdEh4cVp6SU9GM21pOTZrL04xOEh3YVd3QmVMVjZsak4veThK?=
 =?utf-8?B?aTBMNk1iMldZRDl6OTJ5YnBZSEdIejU2MmdHcjgrTWo1UVEwY2NEN2ZiYU9x?=
 =?utf-8?B?R1RIZVBIbXpMbHRVMWRMdk5CMTR1UEd0ejk1RTd3dng3L1d1dm4rSmhpaE9V?=
 =?utf-8?B?cGRCbHRzMHI1WmNoMFRoYzY3ZjR3U1k3ZXkrY2t2ckVEb0Yxc3U0dituaHk3?=
 =?utf-8?B?aE1iU3p5SVU2Kysvc2VadUUxSzBPV09Yc05NODlKY2IxcjFHZCtueEE4ZFlo?=
 =?utf-8?B?NEhWRHFpTENsdUZYWms4MVM5U3FaRmxjTW9HWUt3aWNmeFFWQWlORHdEb0sy?=
 =?utf-8?B?VXdPMnUrMDNkL1o5TVVQQ0V3K2lsM1VUYXN2bVR5d2FKemZLRGQwL243M29x?=
 =?utf-8?B?VlZFUlBPQTlOMlp6UWRwdFJCeTRseXVRMjJGNUxCZ29XV29CUi9nV1lKR0xT?=
 =?utf-8?B?Tk5JWGJCZkJScHN6SnBjSE5SQi9Vb1BCWUU5MzI3YzFwR2p5eTBtemlSODBB?=
 =?utf-8?B?dGJuK3Jrc0YvZ1ZXeHBZNFZSdmJTQjYrYko3L3FuOGZyd3NjZGlYRU5sazB6?=
 =?utf-8?B?MHppSGhlWlluc1FKbnZwSytrMWlLRXQwOUJKMzBlSUVhamt2dktiSHlsNFVE?=
 =?utf-8?B?RFdpYVZxZ3oxWGllMTJEdUd1MGFhck1lb3BTbW9jR0RXTzJxckYxZnYxSFdi?=
 =?utf-8?B?ZWw1Y1FZdGJaTjI3M293VFErRVZmYTFUUi9XcW9VR29oRU1laE54U0NGdzVx?=
 =?utf-8?B?RUt2MHNuL1l3VmRvNUNYRXhZV0c5aGg2NjlYQXA3M0JxNzdWcUpBWjdVNWdL?=
 =?utf-8?B?L0FnWnZNVXZ0cFRLS0F6WEhBc2RpRFpackVZY0dkRUtUTjVVWnZNeStXZ0hm?=
 =?utf-8?B?UGdyN0VPVGVwQXlySE9TZ0krZWUvc2lSR0prV05OVWxRZWFxQnhETk45NlRl?=
 =?utf-8?B?RW43VHhKZXlTSVBEWHF5Q1JBNUJGaW1rZ2d1Nkg4TDRkNmQvblZRRTFUcDhn?=
 =?utf-8?B?OWQ5Y0dLN2lPL2orcHp6REdVLzQzR3hkUmFSK1BKenVYM295UzZvY0Fkcjc2?=
 =?utf-8?B?R1JDQVdyTU92NVBCYkoydUhNYjRqcEtKZnRvUnZPY3JzUzJhVVI4WG5RWTFr?=
 =?utf-8?B?RHBQOCtpa1dWQVhFVldMRjU5R0czcGZ0YmpBRWcrWUFwRlc0bnFJZitBME5E?=
 =?utf-8?B?eGU3ZCtmRFViZTlJbDRUZmRaMzJxQnIxb3VQbktXN0RMTk1CT3MrN0Q3OFBB?=
 =?utf-8?B?ZUp1WWdJYjZ0UTJIbTd5MmVsY2ZNRXlzQzZHMG5ZNnB0R3QzUkQxTWp5elpW?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	o1Ar11MqK1KeyxabV/KN1dAHZTCuEvUiQIVHQE2N8UNnWMXcAk5SNt5sTHMFyVAkDtzTc0JdndbC2Qj03fyeYgVqEPbvtsEhLQDudSJ8HzAFmJVcsAj5t/Vnfitfs0WvyMgW8D7NBqy/FbyNZD4RaUcvO8rTRqEPI3xoX/pKH/Aj951gnPX1qqa2aeKOnFfpI+FMz1oIalMmFCETqUqX4C8ujwcjKG7PDoJjCagvKgPcH90u7fDTthmi8+bSh01ixHFCP0wRblesvU7SEu6aCkaPfAszXvhtQ5Z5PSN2ihtb3uWE2wlvDh4AyaAbuc4PIkULOxHwwN2z24y73i2QVQNGLbJBoJJIm/wuLLzmHYsysWOjgkY4YSkP2xOlFd58JIVpTESumwW9Rrr3IKHup+41OV3MHhXaozFhMxtsDgT1s8v7b3ynIj8DCzO8l7WWqMD1GlW9RZvbBFroz/A5jEkV2S/ZaAYuKiAaXvyTyd3VcGkIyAMAJDfhFrYyXoHFvQJnJLEztRSV7vLsl1AMIiXd+VGMEBgFGCGD9txNEmaJHaftxrmfNNiT+3ajG261SpHCZ8uzcQFecVvTdUbwcTDuFjDqmzqMuNZKVpp4MfOVkzZVN7OlL/etNBGtMbwmU57C8GIdC1PpA60xdrYv/+2g/RDbZ1zfitLeM7emeCDE8BOa3Nezz5i45FTlDTra15juZbLB7tk1hjVE5vtxmFV1iFxv+sdn7KM7jPjODy2aoRMWRG35v01295cY+F4RYrAn21Kb2sc5T9kTVXF5eA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ea5ab0-d190-4329-be9f-08dbf02e5025
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 16:23:10.9167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLIeWeUhTqoD11HHBKFPaOzRrlSyz20WM4nv9NX3Pt7PZEQEaQ3AzuZqb7p9l5NiGxraayNdsRhhXeDrLnIycX1bODQ0pzmBKYulJB9J1s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_18,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280131
X-Proofpoint-GUID: -qwv755jBPeyKFXFHG26PwWL3-RW1VuL
X-Proofpoint-ORIG-GUID: -qwv755jBPeyKFXFHG26PwWL3-RW1VuL


[During LPC 2023 we talked about improving communication between the GCC
 BPF toolchain port and the kernel side.  This is the first periodical
 report that we plan to publish in the GCC wiki and send to interested
 parties.  Hopefully this will help.]

GCC wiki page for the port: https://gcc.gnu.org/wiki/BPFBackEnd
IRC channel: #gccbpf at irc.oftc.net.
Help on using the port: gcc@gcc.gnu.org
Patches and/or development discussions: gcc-patches@gnu.org

Assembler
=3D=3D=3D=3D=3D=3D=3D=3D=3D

- The BPF assembler was sometimes generating spurious symbols. The
  problem was that supporting the pseudo-C assembly syntax for BPF makes
  it impossible to use the traditional technique of hashing on
  mnemonics.  Instead, we are forced to attempt parsing entries in our
  opcodes table until some instruction template matches.  In some cases
  this was causing the parser to incorrectly parse part of an
  instruction opcode as an expression, which led to the creation of a
  new undefined symbol.

  David Faust installed a fix for this upstream:
  https://sourceware.org/pipermail/binutils/2023-November/130668.html

- gas: change meaning of ; in the BPF assembler.

  The clang assembler interprets semicolons as a statement/directive
  separator.  In the GNU BPF assembler that character was being
  interpreted as the beginning of a line comment, as it is usual in
  assembly languages.  We detected this discrepancy with snippets like:

	asm volatile ("					\
	if r1 >=3D 0 goto l0_%=3D;				\
	r0 =3D 1;						\
	r0 +=3D 2;					\
l0_%=3D:	exit;						\
"	::: __clobber_all);

  We installed a patch upstream that makes GAS to behave like the clang
  assembler when interpreting semicolons in the assembly programs:
  Jose E. Marchesi
  https://sourceware.org/pipermail/binutils/2023-November/130867.html

  The simulator tests have been updated accordingly:
  Jose E. Marchesi
  https://sourceware.org/pipermail/gdb-patches/2023-November/204581.html

- In the Pseudo-C syntax register names are not preceded by % characters
  nor any other prefix.  A consequence of that is that in contexts like
  instruction operands, where both register names and expressions
  involving symbols are expected, there is no way to disambiguate
  between them.  GAS was allowing symbols like `w3' or `r5' in syntactic
  contexts where no registers were expected, such as in:

    r0 =3D w3 ll  ; GAS interpreted w3 as symbol, clang emits error

  The clang assembler wasn't allowing that.  During LPC we agreed that
  the simplest approach is to not allow any symbol to have the same name
  than a register, in any context.  So we changed GAS so it now doesn't
  allow to use register names as symbols in any expression, such as:

    r0 =3D w3 + 1 ll  ; This now fails for both GAS and llvm.
    r0 =3D 1 + w3 ll  ; NOTE this does not fail with llvm, but it should.

  We installed a patch in GAS for this.
  Jose E. Marchesi
  https://sourceware.org/pipermail/binutils/2023-November/130684.html

- Cupertino Miranda fixed a GAS bug in the parsing of registers in
  pseudo-c syntax mode:
  https://sourceware.org/pipermail/binutils/2023-November/130732.html

Compiler
=3D=3D=3D=3D=3D=3D=3D=3D

 - Remove bpf-helpers.h.

   Now that we are finally able to use the kernel provided bpf_helpers.h
   file and associated machinery, there is no longer need to distribute
   our own version.

   Jose E. Marchesi
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/638226.html

 - Restore BPF build, always_inline in libgcc
   Jose E. Marchesi
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/637948.html

 - Fix expected regexp in gcc.target/bpf/ldxdw.c test
   Jose E. Marchesi
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/635892.html

 - Fix pseudoc-c asm emitted for *mulsidi3_zeroextend
   Jose E. Marchesi
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/635896.html

 - Corrected condition in core_mark_as_access index.
   Cupertino Miranda
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/636389.html

 - Delayed the removal of the parser enum plugin handler.
   Cupertino Miranda
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/636388.html

 - Force inlining __builtin_memcmp upto data sizes of 1024 bytes.
   Cupertino Miranda
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/636390.html

 - Emit errors for libcalls and builtin-generated libcalls, like clang
   does.
   Cupertino Miranda
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/638117.html

 - GCC was emitting funcall external declarations corresponding to
   attempted but eventually discarded code.  This happened for example
   when GCC tried some particular code that got discarded because there
   was another more performance alternative.  This was a problem with
   the BPF instruction set <=3D v3, because of lack of signed division.
   This is now fixed upstream.
   Jose E. Marchesi
   BZ 109253
   https://gcc.gnu.org/pipermail/gcc-patches/2023-November/638143.html

 - Indu Bhagat is investigating a BTF generation problem that is
   resulting in non-anonymous FUNC_PROTO entries, which are not allowed
   in BTF and rejected by the BPF loader.  This apparently happens when
   functions get inlined.

Pending Patches for bpf-next
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

These are the current patches we still have to submit to bpf@vger for
bpf-next.  We are in the process of testing them:

- bpf: add more options for gcc-bpf to selftests/bpf/Makefile

  This patch passes the following extra options to BPF_GCC in
  GCC_BPF_BUILD_RULE:

  -masm=3Dpseudoc
  -mco-re
  -Wno-unknown-pragmas
  -Wno-unused-variable
  -Wno-error=3Dattributes
  -Wno-error=3Daddress-of-packed-member
  -Wno-compare-distinct-pointer-types
  -fno-strict-aliasing

  Most of them disable interpreting certain warnings as errors.  Code
  like:

    #define __imm_insn(name, expr) [name]"i"(*(long *)&(expr))

  where `expr' is something like a pointer to a bpf_insn, requires
  disabling strict aliasing, which is activated by default with -O2 in
  GCC.

- bpf: use r constraint instead of p constraint

  This was discussed in bpf@vger and it was decided that we would stop
  using the "p" constraint in the BPF kernel selftests.  That constraint
  is not really meant to be used externally to the compiler.

  https://lore.kernel.org/bpf/87edkbnq14.fsf@oracle.com/

- bpf_core_read.h: GCC specific macro for preserve_enum_value

  This patch adds a version of the bpf_core_enum_value macro to be used
  by GCC.  The implementations of CO-RE built-ins in clang and GCC
  require different "magical expressions" to be passed to the built-ins.
  These macros hide the complexity from the user.

- bpf: avoid VLAs in progs/test_xdp_dynptr.c

  In the progs/test_xdp_dynptr.c there are a bunch of VLAs in the
  handle_ipv4 and handle_ipv6 functions:

    const size_t tcphdr_sz =3D sizeof(struct tcphdr);
    const size_t udphdr_sz =3D sizeof(struct udphdr);
    const size_t ethhdr_sz =3D sizeof(struct ethhdr);
    const size_t iphdr_sz =3D sizeof(struct iphdr);
    const size_t ipv6hdr_sz =3D sizeof(struct ipv6hdr);
   =20
    [...]
   =20
    static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_d=
ynptr *xdp_ptr)
    {
	__u8 eth_buffer[ethhdr_sz + ipv6hdr_sz + ethhdr_sz];
	__u8 ip6h_buffer_tcp[ipv6hdr_sz + tcphdr_sz];
	__u8 ip6h_buffer_udp[ipv6hdr_sz + udphdr_sz];
  	[...]
    }
   =20
    static __always_inline int handle_ipv6(struct xdp_md *xdp, struct bpf_d=
ynptr *xdp_ptr)
    {
  	__u8 eth_buffer[ethhdr_sz + ipv6hdr_sz + ethhdr_sz];
	__u8 ip6h_buffer_tcp[ipv6hdr_sz + tcphdr_sz];
	__u8 ip6h_buffer_udp[ipv6hdr_sz + udphdr_sz];
	[...]
    }

  In both GCC and clang we are not allowing dynamic stack allocation (we
  used to support it in GCC using one register as an auxiliary stack
  pointer, but not any longer).

  The above code builds with clang but not with GCC:

    progs/test_xdp_dynptr.c:79:14: error: BPF does not support dynamic stac=
k allocation
       79 |         __u8 eth_buffer[ethhdr_sz + iphdr_sz + ethhdr_sz];
          |              ^~~~~~~~~~

  We are guessing that clang turns these arrays from VLAs into normal
  statically sized arrays because ethhdr_sz and friends are constant and
  set to sizeof, which is always known at compile time.  This patch
  changes the selftest to use preprocessor constants instead of
  variables:

    #define tcphdr_sz sizeof(struct tcphdr)
    #define udphdr_sz sizeof(struct udphdr)
    #define ethhdr_sz sizeof(struct ethhdr)
    #define iphdr_sz sizeof(struct iphdr)
    #define ipv6hdr_sz sizeof(struct ipv6hdr)

- bpf_helpers.h: define bpf_tail_call_static when building with GCC

- bpf: fix constraint in test_tcpbpf_kern.c

  GCC emits a warning:

    progs/test_tcpbpf_kern.c:60:9: error: =E2=80=98op=E2=80=99 is used unin=
itialized [-Werror=3Duninitialized]

  when the uninitialized automatic `op' is used with a "+r" constraint
  in:

	asm volatile (
		"%[op] =3D *(u32 *)(%[skops] +96)"
		: [op] "+r"(op)
		: [skops] "r"(skops)
		:);

  The constraint shall be "=3Dr" instead.


Open Questions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- BPF programs including libc headers.

  BPF programs run on their own without an operating system or a C
  library.  Implementing C implies providing certain definitions and
  headers, such as stdint.h and stdarg.h.  For such targets, known as
  "bare metal targets", the compiler has to provide these definitions
  and headers in order to implement the language.

  GCC provides the following C headers for BPF targets:

    float.h
    gcov.h
    iso646.h
    limits.h
    stdalign.h
    stdarg.h
    stdatomic.h
    stdbool.h
    stdckdint.h
    stddef.h
    stdfix.h
    stdint.h
    stdnoreturn.h
    syslimits.h
    tgmath.h
    unwind.h
    varargs.h

  However, we have found that there is at least one BPF kernel self test
  that include glibc headers that, indirectly, include glibc's own
  definitions of stdint.h and friends.  This leads to compile-time
  errors due to conflicting types.  We think that including headers from
  a glibc built for some host target is very questionable.  For example,
  in BPF a C `char' is defined to be signed.  But if a BPF program
  includes glibc headers in an android system, that code will assume an
  unsigned char instead.

Other Updates
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Brian Witte has adapted the Waldo 80211 debug/test/trace wireless
  analyzer tool to be built with GCC BPF.  This includes CI that uses
  the latest GCC git version, which is quite useful for us.

  https://git.sr.ht/~brianwitte/waldo-80211

- Brian has also published a tested and documented very simple bpf
  program example, with the goal of providing an accessible and
  instructive example for those interested in BPF development with the
  GNU toolchain.

  https://git.sr.ht/~brianwitte/gcc-bpf-example

