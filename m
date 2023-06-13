Return-Path: <bpf+bounces-2509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD1072E5D5
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBC6280F18
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4AD171BA;
	Tue, 13 Jun 2023 14:35:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F5C23DB
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 14:35:40 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0092E54
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 07:35:36 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DE0gqo005316;
	Tue, 13 Jun 2023 07:35:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jAY1pU5GGktLCB1OuyvbpAIVX3hbsMnyhT9JjJuaurU=;
 b=hjEGGBVLDiv2QgfhUjJRi3xCn1kDifMAiS2297PjcttpuAjs1v+UJZuzQRuV2SMyUUD0
 Dr1WO/ootlUcAPucONAj3mM4mzMKlo4W5w3aZRk+TuPqoew6q3l/bUus7hSnpt6IFYsw
 awq/isXO6w7ydz0QfKWCf0RLtfRweBQL8sD058cYrwS/icI9jhrQ6JMvTFvZZnLXKOzE
 mPgaBz7WBLdIC0UJ/80l/g5ooNxGl/5tUfQ/JffZrf4lWtGQXmS0wi3ejd1IJcuk5bl1
 KCqdHR/KMZTVErzXTEev1GE6EVS7YEmwxmeLDGDENK3m8RRGdMUMuaDFWf85lOHyiUV6 Lw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3r6cayn2h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jun 2023 07:35:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0m41yU/pO3dHnBRZq12Hbmbg4ufIxobLOfQznu4hupez7ePx4Jaqnh5K0yth4Z3vuStiTKRx3RIsvF0CID5QI+PZSZB2hNffRYLB5O6Od/ZWygQvaxo7qbldQP6+3fszR1sVEiMU0P7L8nLMvpGEg9S119qOVO04yHfRDUMhtQYEE+doc55/yV0vyrWIdBDoUO8noLTQn08/MgRk0CYbm830Smah6OGoI9M9HJR5o7exXznuAMZofY1X98KmD4W3n1Qzu1pAPSAF6T7wFJ9RbuFYi4s3DO2KN/bskHCvTf3kxDdJ7t6FPILULz1rUcxuhDsiM2fzjGuFSpxYhJf/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAY1pU5GGktLCB1OuyvbpAIVX3hbsMnyhT9JjJuaurU=;
 b=FfNm6rMEhqsRUSDzP8KpOBgs/YTRSw3NbGQCbPLDF1fyHoh4LfcAdmZm4fxoWJ7DZWZ/E56vsynAYx1IC2h6pjL14AB8S3/rQ/MENrkkwY6usLK08Qa0l82qxlKX5xquf/APxihteHlW5Hwfx3r4P6zN9Nqxrrolx2Lqc2fQskSsBQfqBqA0l5wycVN5dRztQ0KD+3+is4tLf92ajkx0mNnh8yzvoMPhM2IQCVKt1waDuPbToufmlbkAVK1H3HL7onukYLotFsv0qG+yPaXM6AJRtEI9a5xHmIjjxpwgbvVaHTFAXxjjUuVd/mKXEQ99HhILGKOb4YiQmgT45G6aRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB4052.namprd15.prod.outlook.com (2603:10b6:208:276::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Tue, 13 Jun
 2023 14:35:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::428f:acec:2c1f:c812%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 14:35:17 +0000
Message-ID: <09161988-7c1a-bee4-e71b-21561e9d4676@meta.com>
Date: Tue, 13 Jun 2023 07:35:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH bpf] bpf: Force kprobe multi expected_attach_type for
 kprobe_multi link
Content-Language: en-US
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
References: <20230613113119.2348619-1-jolsa@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230613113119.2348619-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 1762badb-b780-44dd-c438-08db6c1b6857
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wIu4gycAN94zXsvCHRg5qX1kslRQXlLpg5fi5PbRm0vr3a6GfDcwJw6yO3YI4F+rsyLfN4M+qzJP7FyoxNYfy0LYPJqHopvQSZGdwFcfrfnocrzGAJ74VHRvTWifty4bWhK8dhoBKk5gNpnE5UwHzKwsnucO0gEn2+8mAC4CcF4RJY5ZBgESOZcnwEn4qf2h7JF0guzG5BBAqE8ugzDZBty+qhwLLS35amXmwC+bMsPFAJe8/KuRrzSOiTkCNoztms4cEsPAijUvEPrwwsVEcYM0EwLTzt4XBduUEQurEzvkZdQdz2GWPbTyBO+X5kU1IFPQduLSWkjPh6lnhMS/FYz0XyCICsMKpr/o+hpuDKgTjkxV4a9hogpiPjrpL/k+iDdCkbEQnS5VsSGCKKceAfP6LPgt9yzCtEhbd5GT3s4EDIdC81jP4fqcODeg9CouEvrtwOfvC68xNIgfUm8eBIJh3tecjmq7zDPL0LHpdGvonfMPixeutfvkuU/4HaflviA5Zj5kgqf9pGeeKopj4t855yKwbxXbJK4mIBVQAsAUWUCnw9ZXVOi5imjSDiNiNqqeur4VY9Cyx5DLPAQ3Y1fqgWS9JXjgNDs0OqwqiFwHx3jl8FEbynaUBR7ob1p7eiMxsIQ0OTLAFOUwyyoOww==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(2616005)(31696002)(86362001)(38100700002)(36756003)(478600001)(110136005)(54906003)(6486002)(4326008)(6666004)(8936002)(8676002)(4744005)(2906002)(5660300002)(66946007)(66556008)(66476007)(31686004)(41300700001)(316002)(53546011)(186003)(6512007)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dldVRU1QMkRCcWJ4UXlQcGJoUW1MY0JWS0p4VlN1eW9yZWNDUHZzZlY1ZHJz?=
 =?utf-8?B?VzRlT3ZoOE9VRnlxUTVLcW9VbFliMGpaa0M4VERCci9jR0YvNHZuMWtveWlh?=
 =?utf-8?B?cE5sVVJndlluK1dLSENidGRBQTJtcEtCT2dGN2dLcWtrTjcxZzVrRTVqaldI?=
 =?utf-8?B?NUVPWEZCM2hrbUpkNmtGVmZlSTBrN0g3OHNISG44ZGFUc3VER200bk5hcjNW?=
 =?utf-8?B?eUw4ajhiWldXbWdzTm5tL0xEdUhtcTFBaG9OSmZSREEvSjQ2RGNuNzZic3dC?=
 =?utf-8?B?d0xhYkN1SFZpRDIvK2hrT21WSE1xMU1GNEs1YzhNWjVJRG8vVXdJTllWSGlE?=
 =?utf-8?B?K012amQrdWdPMWJDRWFJdW0yL1g0azFKcDBEWGFVYlBCclBCTjFwSHQ5eTVk?=
 =?utf-8?B?TjBaQld0ZjlyeXdpUjJWQno1aDlzR1ZTZmVDdm93NVIxMWJ5UWlSaEh0eU9r?=
 =?utf-8?B?SGIyWkRnVzVvWHp6VHpmN3pqUTc3ZzZKYTVOM3JSejUzeWNLTGI1cFlvWlVQ?=
 =?utf-8?B?Yk5IVGJlUFhud28wRG9ZNVMxbmtqSFpscUtZUU80S3Q1aEdzSmFtZXVVVVdE?=
 =?utf-8?B?VDNCMjl2UGhhd0ZxalZuMkRGMEF2Y1V5S1RSQ2tWRXYrYmNkd1JvL0pUYVVz?=
 =?utf-8?B?clB0RHdLUWFickZIMzlXM2s5a3RxaWg2Vnd2K0NyNUVMakwyaHlRQ3hwdElT?=
 =?utf-8?B?NzBFSlJrUXlPY1RNeWZoZ0swNDh2Z0oxc2h1YThLaDM3ZUs4WmU3bkFLREx1?=
 =?utf-8?B?VldEWXNqVmJJRVVnVHFmTitjaUhFYjZKOE9lMUxlMkRVcnlsWkFpZURiN0wv?=
 =?utf-8?B?bWVGbVBTT1B3dTdtOU5pKzlQOGJYR0JpVDh6OWVLSnJXUkY4cTg1WCtSVjgz?=
 =?utf-8?B?RnR5Tk9RN2JpWHlGSjlzTWdBWitGUHV4Q3dLRWdEOHB1ZVRrUkoyZVA3cHVr?=
 =?utf-8?B?YnhBd3F1SDY4TWRLbjNIWFFuZ3FPMVZHN21ZeGxSRkdzeXZnREh1RG1ESGVR?=
 =?utf-8?B?TThzdGFkQ1M3aTlMZHZlR0EyVWtRLzhhMWM4NzBiazNTMlF2Qk91T3FBUk9P?=
 =?utf-8?B?U3VMZFE0ZEIrZjFGS3QxZHJVcTFrK29ZN3hmUnBHRlFSU2xPaWhUajd5WGh2?=
 =?utf-8?B?Z3RkOWFQUUk4YUo0cEF2K1k5aHZURlZ0ZThZWkFQZC9KM1Vhcm4zL2JnSHF3?=
 =?utf-8?B?dVdHSzZ1MGhmb3FuRk1XRjd6ejlOYVFxcC8zeFZDclVsU3ptemZBYWx6cWZQ?=
 =?utf-8?B?bDJxSmdOdlpnYndJaUpwcmJsTWQrT1VTdm1UbzlPcWJUUk1WVkxVWW9tVzFK?=
 =?utf-8?B?d0RrU25Jdm1DZSszY3BqQndzRUFnRHM1K1laZHh4RkV4T2xTTjIwR0t4Q2ZX?=
 =?utf-8?B?ZE1HVjhoMTE5WGp4R1dmbFdYNktuRnpYYzh6dll2Q0dXbnFBL0tJeXJ5U0dR?=
 =?utf-8?B?TitYV0REMFZLdGgyb1RGNEcxZTVNcHkwQUZsWThkYnRrQXo1UXdLV0t1ZVB3?=
 =?utf-8?B?d1pMWlZzK2s1dll5YVhHc2c5YnZPaVFRckM3OGpCNXFSK3dnSURBVWtta21X?=
 =?utf-8?B?YnNVSGpTK2ZzWlgwS0NSaHE5QWszb3k0NjFlc0NJd1JZL3I4bUk2ZG50bFQ3?=
 =?utf-8?B?WEc2YnRramZoRUZkR1BuZUZ2bHNMcFFONVZraFJwV0xreFFvTDFqUlVYN21H?=
 =?utf-8?B?U2lDK1NSMHBYY2YvZ2h3NTBTZnRMYkRkd0dmWllQaXhRcTNoT3dkeVdtRUVu?=
 =?utf-8?B?QXZ5MWkzTUNqdG9qNEhwUjI0YTFSVDRscVlSMVBRdEI2K2kzTnhxNWJESjVH?=
 =?utf-8?B?azRnMWxMSDlSeVRadS9mOW5iTGVuTUxaYmdhdnQySTR2cmJoazNsemtUdXJm?=
 =?utf-8?B?K3JTRjU0aXpaelpkUzJvWEdaRDNrdHZmZjdacGM2MTVrK0dRb2ROb0xMNUI0?=
 =?utf-8?B?QWxVYXplOENqaXRZUnBZMEZ0KzhCOGJlMnpZUzM3Z21mcXZ4a0NzSGloUzZI?=
 =?utf-8?B?anI4V0VYRG1FYnhZdjlZa2tnQTVZWGw3KzdXaisrN1pJdlhMYVBMQjhZblMr?=
 =?utf-8?B?QUpwTlRnQk9vL0xRcWQ0MVBLT3hXNkJUNVJQZnlqamNFcnFJSEZmZnNzcDNi?=
 =?utf-8?B?cktSSXJyWG9ZM1RnTCtudk5hOHNocmxsci9BQ2ljdWI0ZldYRW5Pd200Y2Ju?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1762badb-b780-44dd-c438-08db6c1b6857
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:35:17.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SB51BxDl/1c50iyyigbxW2+lpgmKfbY7qWzalCOLGZZoaQO0Lp59b4ZtbBX8WlEn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4052
X-Proofpoint-ORIG-GUID: SH90QFO7TIs8gfBsjhT2zO1pCQGENJ7N
X-Proofpoint-GUID: SH90QFO7TIs8gfBsjhT2zO1pCQGENJ7N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_16,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/13/23 4:31 AM, Jiri Olsa wrote:
> We currently allow to create perf link for program with
> expected_attach_type == BPF_TRACE_KPROBE_MULTI.
> 
> This will cause crash when we call helpers like get_attach_cookie or
> get_func_ip in such program, because it will call the kprobe_multi's
> version (current->bpf_ctx context setup) of those helpers while it
> expects perf_link's current->bpf_ctx context setup.
> 
> Making sure that we use BPF_TRACE_KPROBE_MULTI expected_attach_type
> only for programs attaching through kprobe_multi link.
> 
> Fixes: ca74823c6e16 ("bpf: Add cookie support to programs attached with kprobe multi link")
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>

