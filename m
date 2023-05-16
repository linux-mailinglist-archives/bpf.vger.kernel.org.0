Return-Path: <bpf+bounces-597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E117043E8
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 05:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4BC2813C5
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 03:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D562599;
	Tue, 16 May 2023 03:18:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372A82568
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 03:18:12 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7B3AAB
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 20:18:10 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34G1oN3x003018;
	Mon, 15 May 2023 20:17:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=w+oUyq3Dl5biOmKSOu2T21uhNhvrvkfMafGhvlM2XaI=;
 b=JHUY38SLTD583dbznXnsVYbf/JbBSKXjbGKhjAn5Y5FrgyNb4hyy3tsO9qWBEvNB0ZhV
 l5aPHf33ZYmirJyu33KUZrhopzBhEc8J9qfwVc9IaFReFBxhLG94disj7Lmwkid+/wdv
 Eg8jp0XIOt9CZdcCScu0bKvuretPpvswqSONqdizm8MMnzOxZE3mmXDkJASsiXwMF4/R
 6DyIsgXM9U/mkN3p0FH8rFGA4icawnFKZ4BtwW1VwCREvmIS9XgRNjSliyOxE+JpNNjg
 3o4H6aUZu9WSuDxnxx4PKnAML/KkCOK51x/U8VailLmpzOGc0bdyTNu2k33XhZHI54qj ZQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qm0h0gcms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 May 2023 20:17:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuceJQQnsmMzTN29EEhVpP3RqqCpo+injnuvFdiw0HuacEjf3l40ebefn+jo42fkSH+unkRT5yTavjJNqZCe/W4CSnZDo2cXljQQUqbOA4aTw2rYCPZlCqKOFz7be8/GdGfr+9Zyw3+w6/KbOrLJ6IyXoGlA1nDPv+lilnubZYdxTZ67DuBqMNvSF3s9wayiFo77wlA1DA6DwGjFVDdgux6NvRI04f3Pm4JtFCZieMikr3pFesOcxoENP9WvnzwZa4e1lOMUxvPXNmi+/wQMMBG/dPahvQMG3xX9v2uTcXrUAIJDjdKUNxJZL8GFFtO+NGIMWKQ8DSk7KH1F3iA9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+oUyq3Dl5biOmKSOu2T21uhNhvrvkfMafGhvlM2XaI=;
 b=CPyNohQ8dFWuccFMR0UXTtUPh027NvvDSanPOb91SuorykXciGYyrpvjelhm9h89ke0aH76gNhRxhNOFi9jyfkiPNIjs+q5Gdx4ZZyrrN7PRb98Soc0R8+T32YWqckRPy/D4h2+BiJFOTG/TzCXLO2o4QG29j19TsazznYuleXtS4vcj9W9jJC/Um+m2f08yAaagDy840rwDhPjzh3ix0TrHHZaakcovNirGCusC58jqAm71kHxEPT1PUk1/q5KgTJ3LN55/is1OdR2O81xcBBQGjYnYlkQJ7FEE5j+EWzlhOS8k4jV6vwiYa8yuMLIkxDECeC4UEke6dKbXSVIhfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4513.namprd15.prod.outlook.com (2603:10b6:806:198::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 03:17:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 03:17:52 +0000
Message-ID: <960c39f5-fe18-491b-b863-3e5e2d5f1dbd@meta.com>
Date: Mon, 15 May 2023 20:17:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v2 bpf] samples/bpf: drop unnecessary fallthrough
Content-Language: en-US
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
References: <20230516001718.317177-1-andrii@kernel.org>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <20230516001718.317177-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dfaba9d-764f-488a-7d65-08db55bc228c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4pTT4VsCNw3Mcw5PJWVtKr9oxB1jJe/PhTSqXgLbeID97tcC4tPYMKkQPeg92ulFPxjvC20nTo2jYQL14ibhJSJw0eRx04Ieuw1arbQuyWcafVE9wgyZRGr6eQBg94lKmGDt7sn28OpWrvjVhqUpHXfkPIHRegAmv2Bh4/5DDspl8WvOWZvtHEs7qj8aLUiVWSnnMne/f90BVkeuZ7R4qls42S6szoM28FCTr9NhmxJcCCGaGvvIXGKIR1wDi4mfYBmYN5MF876pMbEkiZKKy/IoObgoCKaR40KwngHf0caNWjXXG0I/Xc4VVzYfvCYKAQGtKy6gHtO7w3D5eoLeOZd9NW/LsRkoIP/cghPEhVnH/protVY+rJIJwMWdIDIq8DpjpKu/BcZ4skIYJT2qY2+LS2f+5u/LhTpFPPhVUTtt6SP7z1rW7hZxZg4RPfm790xIRxkpx7WXc4IdgVLSZ+6SDN1p16dkvNEa2srWFuHvS6IztLMC20kdMxwCI8cagcbaTJWzcUQrEbohNqs48OqeXp6QOnGkcKLMAwoOxAuCgEScqfk3nLzjCZmIV81jM5L91BqWU7RhvKlNP8kpPcmbPrBtA/86pzdTxMMwhbBr1SDFN1NvBbOWrOVpsF+OFDiYkw1tQ81R3Qy2hX/v9w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(31686004)(6486002)(36756003)(4326008)(38100700002)(4744005)(2906002)(31696002)(5660300002)(8936002)(8676002)(86362001)(316002)(66556008)(41300700001)(66476007)(66946007)(966005)(6512007)(107886003)(6506007)(53546011)(186003)(478600001)(6666004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MjJpZ21DZFBQUzhMUnZvNC9WaXhzcThwRStURVVZbGJPVjkvbTQ1MmNzSHNk?=
 =?utf-8?B?bGgxUUlrNGUwQit5VVp4QytMY3RLaFkrQWxLOE90eFhXZjd2T29udm01QzMz?=
 =?utf-8?B?bWo2QndmdUpucnhhZVdZb3JOYml6YWc0M0lWZVJPZmE4RC85a3JqTXlFQnFE?=
 =?utf-8?B?VUdIaWFNVHJ2ZGEvbzlYR2l6WFNVRzB5TnB3LzFlQUs2RnA0WERKcjc4elFI?=
 =?utf-8?B?dDRqMmZKZ05wUTl4bmx2VXFKMzlZYml0TmNReFNkTUZER1VFVkxQYmdYTnZN?=
 =?utf-8?B?dWx1cWVnd0dvU3VycTJEdUFza2JjdHRNTjdrQ3hOS3pybjNzUG02Y2Qyb2pl?=
 =?utf-8?B?TUlPL2NaamJ4dW9kZUxlU1hFQ3lCK3Y3cndZdUdEWUNJaE94ZlVtK2FONUdC?=
 =?utf-8?B?R0c0cGlGT3Zqa0hiS1ZONzhvT3hUbzVWTXo4Qnd6N04wdlkvWUtDM0MydS9F?=
 =?utf-8?B?SHVsTzdxTzIrZ01WZUZhaitOQk44NEp4eWpCVTlpOUtGRlBBclg1bnpqdWE3?=
 =?utf-8?B?N0dJWHVZTXhzeWZOcSt3RUdYaGtHVzFZcndpNG96QnlUcXYyTmpzQlBUNnJH?=
 =?utf-8?B?RFo3WEtFVndaV0ZDdzFMY2djZ25kUWJLTUp6K2c4QVZqdlNjcVZDVjNuOVNs?=
 =?utf-8?B?S0QrNWphcXlsTW5OMk56MHFuNVUzMmVtdndLcVRtcWc5cEZ6NUd2NGpMaXRy?=
 =?utf-8?B?aDBlZnhmbkgyWXFoMEdDeG1Vb0x2MWZORDBHLzhXVlZOa1E1VVBPWC9oRlVu?=
 =?utf-8?B?Um1oNFJ3dzJlWmNESUlrZWdMa2xodFB4VWdEcUNCOXB3UGZmR3hQeHJ1dkor?=
 =?utf-8?B?QWN1QnU0UlZWVk13SlRCZ3I0aFR5eFRkSzhwN3hrdkQ4VVM5SEsvOFhUYWhq?=
 =?utf-8?B?SmhMZWlubmkyeDNCTHhjamVSTUszbFFrbk1YN1pDb0J0bW82OEZxWnhDRzVz?=
 =?utf-8?B?OCtKazVRRStFZ1FmajIvb3h6cHB3QTBQZHBPM1FNNGI5RDZrSERMSlZ0Zkxl?=
 =?utf-8?B?alJuN0M5M3hGRTN4VWhSYnNRNUVadnh5WUI2RncrbDhqb0Y5UHlqVm5KOGpj?=
 =?utf-8?B?SE1TN3hUYjBuWVdYc1psL2w1REp2RWRERXliYlpFcGhHRTJ4czZueTNiMkZw?=
 =?utf-8?B?blZhK01QWHVvMW03Mys0SFV6OGpGcytRdmltU0dwZkNXeW02VkU4NHBFMTZ6?=
 =?utf-8?B?YUhvbVhTZUhUclFTZWJpdEtvcjNSRUY3dFRvOUhTa0g5bklYeDIzQlJLK3lp?=
 =?utf-8?B?Sk5lR3RCTm1mWXZVL1VhbVkvd2NPSnV0TlhwTDZ3azR6eUxHSGZremVNNVlo?=
 =?utf-8?B?N3VQSlNtclVCZFhyOW90QnpHM3o2K2grMHRzT0xOdjE3ZjF4UEV3bUJ1MzdU?=
 =?utf-8?B?VTErTkI1eHk0M293N0xiMjYySTZjR1hoays4SWw1NFd1NmI4QndxTWpwUlFt?=
 =?utf-8?B?WVNaMlNxSUF3NjdXakRBdlZjMUlVem5OQ0svMENJVUU1Z2QvMksrSjAzU1gv?=
 =?utf-8?B?eTIrUS9QNWxDbnFSVDVFT1NnUDdTMGxWL3IydjlxUUVWTlNacXVlcmVBVW1Q?=
 =?utf-8?B?Z00xSkQzOWlaR3QwTFUrSWc3ZmM3V1dsU1VJMU43dDEvQ0poQitBM093bUdz?=
 =?utf-8?B?bjREdCthTzh4UkJlcm1uYXBteTlJN3l0UG5kQXBpOU15SnVhU2V6ZFhQaWtQ?=
 =?utf-8?B?cWlqcmc0TEFHNXRqeFNzWUNZbS93YThBbE1zRk9FRTlEb3lGdWNsR0dRM2Z1?=
 =?utf-8?B?ZzZ0OGJOajRNL0tmOHM2UVJaVW5TT01aWG05NFdSL3BnaWxjSmsvZndUSzBC?=
 =?utf-8?B?ZHAxeXpPOVExVVdxOWo0U1NTSXFlUVYzMmkramJaZGwwZjBWYWtMZTNYNkxD?=
 =?utf-8?B?dGQ5aGNyNkJGa3RKZlhaaGg0bFBsWThXclQ1ZWRNRkwzNEk5T2t4NDdUajdo?=
 =?utf-8?B?VHJGUWVIZUJXWm4wRUdjS2dwREw3WXIwb0IrY0pmcFNZTGtrVWltOEFxaWhN?=
 =?utf-8?B?aWFqUjhHUmdVN2R6bEJoQmw5TDRJSjI0V1dzbjV5M2d4OGJBV0pJOXE4a1N0?=
 =?utf-8?B?T0JONG8vSVZ3SDVuRzlxcGROWTA2dHBHdXM1RWc5cis1VTViQ0VNVkxhM05a?=
 =?utf-8?B?NVFTa2RWcktKTG1MeU1ldVFMSlhLQ0s2MzBhNGZiNFoxeVU1ZkhycTVTSzR0?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfaba9d-764f-488a-7d65-08db55bc228c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 03:17:52.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fso4KRsFsLQ7rEruhr6RFwwxTaLbopspFD1ayhSAFia14hZJUoku6X3hUWgj4+z2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4513
X-Proofpoint-GUID: CPiLdWSrb_p7trPgT3pooo6E-nOEGKkK
X-Proofpoint-ORIG-GUID: CPiLdWSrb_p7trPgT3pooo6E-nOEGKkK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_21,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/15/23 5:17 PM, Andrii Nakryiko wrote:
> __fallthrough is now not supported. Instead of renaming it to
> now-canonical ([0]) fallthrough pseudo-keyword, just get rid of it and
> equate 'h' case to default case, as both emit usage information and
> succeed.
> 
>    [0] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>

