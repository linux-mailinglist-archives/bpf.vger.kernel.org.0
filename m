Return-Path: <bpf+bounces-3410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 179AE73D2F6
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 20:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D36B5280EFB
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 18:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A4379F7;
	Sun, 25 Jun 2023 18:25:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CB07487
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 18:25:03 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809C1BC;
	Sun, 25 Jun 2023 11:25:01 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35PBxoSE002041;
	Sun, 25 Jun 2023 11:24:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=k7Vgn/KZWjbtbNLRwgLxZHiP2yLkPpmUeEMottU1buw=;
 b=FNIZXyVWVLuljfXDOj6ED2rpqTQkWxGKGsPdIIlHknxPlfqz+VPoaQZvR03YbBbmtVC+
 WuGmIQHBzVA5dBZPnjI2YYDMFUWPjvO6MrJYsoR1ilYv8Ror0AawbEeQ9Qo6dq38c5/e
 5N35otytcg8ZCD5LHj2GTcKsW3WecWUbxSxPNfb2TBerWpBFImSE7hZpSNVetLhPt8b2
 eacA2p9M99+xNSNXm6JqeKoA4bnwJYF2HZe33p1rCjEwuuvrI2gopwdq4dq6Vb/dQHpF
 7KFcywc87srV0a8fNx3u7dl/9FKGB5j7BkSIsEux2xcm2Rg/WdrCRezF3HEqsVeiNMGz 3g== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rdx15g1w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 25 Jun 2023 11:24:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJng2njvhHv/2nr3zIRvGdFb8CMUM+177diaQqALiscMAq2ZeLO+y2Ij3gWyP4WgCAg99WRHWJERimEbhQ98X2UiD2zRI1C+UnkIw1iZNJZf+P93SOdG+/BR1axRiBsYAd3O764Yy3Z09Dqdn7zmnDHVWxTFcVeVSd7lRqJJghBnQ7UkgA6LCdx1zHMoItxvR0L6gxHvV9EOWOsHgbmwSmCADPflgX06VxGBLBCKnfuYkbgTS0m7oVBIWHia8DpEgZVptg1UKPFwJnxaqcw3vvCc24t0VKejeYXn4SDNHWCBFzPJ+4Yjtr3GtfaT1lUk6CcBh/tmFw2K0bmewTeaXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7Vgn/KZWjbtbNLRwgLxZHiP2yLkPpmUeEMottU1buw=;
 b=NOexKYCDDewuImU2/ZHPapts9jbheapgre47feldh88Ff1Yt+ib3n0yYT/lB/D1N0uEg4XHckU1xVtj52NiyQT3YM9ucsnNTjceHKGmFMP+V9NYXMwZI11jmm82inKXUzhy6YPt35u8hStskNiOvOumbssOLVayJzi9j6QGirsCEPpCQBPgqkDXIX6lw74DlbFRSfbo9CGn+PC0mC2pw1+uNjE5hxWqm6FCcjrYpemxDMmpUAqLRihj+IaBf2ytrMne4EF+6eMJzKijyccVWhVLTQ5pVYLb7yo3rRheMyFx+Qu8WD6hunvb0yzKSJIl3wyHWgzsT+nscN9966fwXAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4727.namprd15.prod.outlook.com (2603:10b6:a03:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 18:24:44 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%7]) with mapi id 15.20.6521.024; Sun, 25 Jun 2023
 18:24:44 +0000
Message-ID: <ff7c875a-8893-9b7d-e2fa-200f1601e666@meta.com>
Date: Sun, 25 Jun 2023 11:24:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] perf: Replace deprecated -target with --target= for Clang
To: Fangrui Song <maskray@google.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20230624002708.1907962-1-maskray@google.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230624002708.1907962-1-maskray@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB4727:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f288df6-c88c-4401-ae02-08db75a9729f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	l+hsbTzveJs0ADvTYV+X9flvocBtdWYwsvG0y4RyFUAbApUeiNcByc7uGbTE/6JwgDSiXDaDY5iofhT+aR+f3+FiKO/EE3pej4SdRXmn4cj863feXjD1+03/u99141Xr2ZO74PhSUpPiecg0Bc/i/e9/D8flMa0TsG21Y4J22e30SHlNiqLo8bx31aciQjh/dsQAYNHiGz81WPzvSiwAyKKo4fUzRph62mpCOWCmT5FXcM9KKoRT6/YEV1SI7/gvBqgXN4Nr5wfjRwqXxQtEOyky5ckDkw35AYfbGx1E3AM+O+UQe1RN40pxOaAB4kDGc0zgjg3YhZGFItF//ANMoLB4bW3fWLacCIlItag8padMkgvwb3rQRzM4BR5ZD9oDOaXsQ6al3GVFIUB5UuVpkp2CsNWi8H/DYFaPlZ+yPEwHHml7hFxoijpGCIO0kHYd87ICrH2Fd+q9RlFkRNLeMY1Xs3SH3NJAxTkxrDMEUasf+h9rpu4wbohk0io+8HjZqRe6kiNvs+sL8J7VXRTQWbTuy2uPEqQCftnEYr5kBtiUqf0vlp6HaBfifOVlhstHoqUDnltiC4Xccwho66CaKFTkWeXwLSnTyVGFRRRhEJn3HPZNvXCxcgNEkqJmj0mAl1fLHuDbRKUkoRIJwALgpg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(31686004)(5660300002)(4326008)(66556008)(66476007)(66946007)(478600001)(36756003)(316002)(8676002)(8936002)(4744005)(2906002)(966005)(110136005)(31696002)(86362001)(41300700001)(6486002)(53546011)(186003)(6512007)(6506007)(38100700002)(6666004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXhoZEJhNVNXai9ZVnN2SENydlpuWHJlallhWVlXQlkxRVZDY2xvMUUyV1V4?=
 =?utf-8?B?Wnd2QnZmRVhmUmgySDM0REJqbldpNzVGM2lzN2xqdkIzaC9QZE9WK3liVCtR?=
 =?utf-8?B?Nkh4cFNrYWV5a2RaU3pSdTY5UER0UnB4MDlzU0J5bTZyVjRHWVVnOFNLK2FP?=
 =?utf-8?B?RVBKaEhwWW5qQ0FIdmNlNG9yZXJuY0RiWEZYcjhxQmlwaDBxOGRET2tFUGVz?=
 =?utf-8?B?S0syb0MxR2hESFdBNE44bXhKOVdCYW43cGJKZDh5NS8xTlRWTHI2Zlc2OE1u?=
 =?utf-8?B?NGVJYWI0SGdBR3ZHQVVUM20xRXRxK1h2OWUySklseWFaZGd2WkhjZW5jQ3pY?=
 =?utf-8?B?NUlvVWtGa2ZFQlJZdmN5MzM0LzBlTXZicnRKVWZ5TFQrRU1HUzRBVzBIUmFP?=
 =?utf-8?B?aWJsMUZJVU5RZjJjVDVTZ3RNVnBxWEtESDRwaU9HS3F3KzJtbEZZbTB2NUda?=
 =?utf-8?B?VVpyTmtnQkFzNENLeEFiNHkxUTdCN1NkZEtha28yR2NDQzl0eC8xc1pJOTBo?=
 =?utf-8?B?NnFNbjZQRFhnUTF4YTBzTWpSVEVYVTlua1QzZ1pMVUNKVy9lQllpSGc1b2F0?=
 =?utf-8?B?WjlhMHVKbGVmS1ByUGRBWDBpbWRWZjBnQ3pDbUZzaUFQM08wTWJPMDlybmk2?=
 =?utf-8?B?MUQzSlJTMTYyMVFRTFNVdnNyeS90dUFYamVST3IxbmtMejlKVEdWQmZaRXpE?=
 =?utf-8?B?MmZ4WmszMkhyMHFJTWYvV09hOFpDZUVySDBuaXh4UjdlSmhNYmVsWVZRaHlK?=
 =?utf-8?B?dS9OK0tlNEZkMWpza3EvSSthdGJWNDgrS3VVTWJ1UVF2bGdSUGN2d25SMGtQ?=
 =?utf-8?B?ak5mVmU0NkdkQ2ZyQVUvN3FMWU4zZGJHZDRpZ3R3RmJjS0xoeStRVWtJcU5N?=
 =?utf-8?B?ODJXWU9tbXMwcjBsaDJzU2lzbVZEL2NoVW81bFdzRnEvak55L0pVSm1LMUZR?=
 =?utf-8?B?UHIwNzYwQkhwd0s0bTNxQUc1OWY2aFE0bndrQ1lwTVFyYmRueUZHaDQrV3dX?=
 =?utf-8?B?VUlFZHBGYzgvRWxxaTNLL2toY3A5cEpJZm8yQmM1d2hZMVlEa3kvNzRLL1k2?=
 =?utf-8?B?bnZ2UndOaEdhai9LRWVPc1NTT0J1NklMUVlFL2ZTSzU4UDVIc0wwMkpsOFlj?=
 =?utf-8?B?czNZK28zYlBMSVNmRDFSTnZtUlQ3dDZOYkVzMjBveXBpUHFTWnpDQ1BrSE55?=
 =?utf-8?B?MThXd3BZYnFwV2t6OWtBamdrT0VrR0dvejJ0NzhCZnltcXQzbU1XQ3Z2TEVs?=
 =?utf-8?B?OEJrZVI2UG16VmdiczRsSTNsZ1VRNUlzTUdxbTB1TmtiTEdua1JVUTdOeFdG?=
 =?utf-8?B?a2s0d0lEc0xYc2ZkQ0tTZEZML1JKdGhTekxZQmY2aWYxMm5yL01CVHVDdTIz?=
 =?utf-8?B?T0JsQTJYcW8zeUdvVUhXMmNicmw4MjI3VjlFSndQdFAvYkM2a01rVTR5Umtl?=
 =?utf-8?B?K29ObnZyYWxHV3hOT1lJZXd1b253OEZVN0o0T2d6dzdZQWc3MkRPM2pZWW9D?=
 =?utf-8?B?dVNic2dRUkhybGx0OTlYTjNOT1ZhVXBWa3JBTi9NNHRhUk5RdnYvcm1zWE0v?=
 =?utf-8?B?TnArbHhkc0EveXIzVEVPRmVFdGVYWUVQTHpRKzFQYk42cndwL3ZMWEEzY3Fy?=
 =?utf-8?B?ek1WWEhpdUlXbWF1bW5RUnlkSGVlVUliTk1sZmIzK1pjQmFpWE5KbEVZL0lL?=
 =?utf-8?B?bDZhc1VLdU9HOUFBQmxydUpEUEs0UmZJL1h6K05xMTZWRTRTZTlCREMyS0lT?=
 =?utf-8?B?UXpUNlNQNGFqRlh3Z0hGelFDRGNkZWZrTnMxVElUSnBZemVwSGU3UXFGRHJp?=
 =?utf-8?B?dWNTZjh2aURnSVF6SDYwbjRsSHdHZjRkdHZHd1E5b0g2Tk94Y013YUVZSnI4?=
 =?utf-8?B?TGFQYTVSWnZTWHQwL1pwZ2x6R3RCSE8vV1JuVjQ4OCswU2p1WCt1WjhqajZ0?=
 =?utf-8?B?ekM0YVFuTFZNMVI3MlpZL05zbGhrcGJqY21qRXhDUkRrUE9MNEp4QS9CTFVU?=
 =?utf-8?B?YzNFUmRDOHdVOVFqWjNIbmtLbXptZzIxTDZMN09Wa2MweXNWd212MEhPM3B1?=
 =?utf-8?B?Y1lIdFcxSVg1eERGUmQrVzV4OXpCNmw5L0x6eURtM3Nld1ZOVmszcE9FVW9P?=
 =?utf-8?B?MmNodUYzNTloc04yRmk3STFpM2UwVzZzQkRGSFo5SFBnZGtiVnVJaDJ4b00r?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f288df6-c88c-4401-ae02-08db75a9729f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 18:24:43.7753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uwQfF3ejP4CqwUDFF07yEsIA+awJuBvSy8L4hCmexkg917g/noytwvqQv52ZhDLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4727
X-Proofpoint-GUID: bD4JhBvsyGxes2HedKoi-YtMMmYm7_47
X-Proofpoint-ORIG-GUID: bD4JhBvsyGxes2HedKoi-YtMMmYm7_47
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-25_11,2023-06-22_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/23/23 5:27 PM, Fangrui Song wrote:
> -target has been deprecated since Clang 3.4 in 2013. Use the preferred
> --target=bpf form instead. This matches how we use --target= in
> scripts/Makefile.clang.
> 
> Link: https://github.com/llvm/llvm-project/commit/274b6f0c87a6a1798de0a68135afc7f95def6277
> Signed-off-by: Fangrui Song <maskray@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

