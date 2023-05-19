Return-Path: <bpf+bounces-927-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A160708CD7
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 02:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62C11C211E0
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 00:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFF5362;
	Fri, 19 May 2023 00:25:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908737C
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 00:25:37 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F23D1723
	for <bpf@vger.kernel.org>; Thu, 18 May 2023 17:25:09 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34J03WWZ000567;
	Thu, 18 May 2023 17:24:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=EUzfmvL0khble3QkdYG9r5A7GMaGmMpwVS4YZjUAJLE=;
 b=I7FPeoQl4BUtNUx3/MhfdoQcpxBoWZCGELPP13ARaF6tdDGOGM9Y7vhvSUrHLG9re1sv
 BYHCAbvPwga09vBO/xbxZGcNoQwD9d+W4IB3uOldxMV9syHkuI1/ndYL+TASDMu6RLVu
 Sf3ktRSNgpPS/Ng9XmDVuexeqBEQATnEUs/RghE3f40r5gZ9sz8XQ5CXBMaYSaa/l8VE
 R7+Yn06IqXrO04K5SFtlrKMYpuvQwb3XClEu82maxpHfAIbJkvnyIFD7SaHosLpR6QmD
 VpamgMAAAkf90bkSzCeDlQTFXxjKvHR0KPM/l/VcdkktFeZ6j0ijtkCTEnBlOPKKEdqI ZA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qns5n238b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 May 2023 17:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG+CrJScpHx6sz5XbZUQg1bg7EHOxbuEMlJa1bAIVRQQwanEl5oXMc1ZRdRJ7/zNw/r5cAAY9oiEEbO7Ewc6ppH0blbbt3DkkjyqOFUglIdz6ZuX1GRuBHDYYlUkDdwiby6474RFK6nqzbv+IfXQWxg1/4McnWqzTQnyaxnTCc07yL0J2LQC5/cDsKfAZrnd7Tq3kMFaWrAm+RE0I3Q9RWtFM4ARB3PlCETsVPuM75fhzFlLLW7o4vjzxoVzPavlLHwnN6rigUgvsTtT4C8OF5t0PQNM5T/v/PDQLhw0MEI53L/M89W+9wQjnZf7WUF+Z5xZBncuqVSNldEtgOsK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUzfmvL0khble3QkdYG9r5A7GMaGmMpwVS4YZjUAJLE=;
 b=YifFiup0IhnMmmP5qf9IXmsH3XU7FmRlSHyb0J8fRbQ+lMT0q+RAxwT5UJdDYJ3M0nGatAlRFU7qjVX8IrZXlxt/73ruXe49aTlwgFKkNln63S+5gVY7MSNEuzLDOJfJLLogBrRzQBAO2T4849iQL+w/eGBe6WcSKNBR+ElOcyNWQkimKclVYr6g5dokxHSziAZBopJdn3mOrNTyYGzFcq46pkRGClsXwE+t6TfzRibSzo6+kNMgVAMOkCjREagScaie/sQwG35RNy5P6Z8xOPbOXiAbdKjLDXUmmoD66yR+b3+dKduTpCeo+FQtnbhKX1tnXEELCYR1vnoboesg3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA3PR15MB6075.namprd15.prod.outlook.com (2603:10b6:806:2f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Fri, 19 May
 2023 00:24:02 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 00:24:02 +0000
Message-ID: <32d01399-22a4-8ddc-379d-4ca2f41506f6@meta.com>
Date: Thu, 18 May 2023 17:23:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [RFC dwarves 5/6] btf_encoder: store ELF function representations
 sorted by name _and_ address
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
To: Jiri Olsa <olsajiri@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, yhs@fb.com, andrii@kernel.org,
        daniel@iogearbox.net, laoar.shao@gmail.com, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <20230517161648.17582-6-alan.maguire@oracle.com> <ZGXkN2TeEJZHMSG8@krava>
 <35213852-1d29-e21f-e3f8-d3f164e97294@oracle.com> <ZGZQuqVD7gNjia7Z@krava>
 <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com>
In-Reply-To: <ee0a24c9-1106-c847-2c91-0d828ec7fba3@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA3PR15MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2566da-d4b6-4c32-727e-08db57ff588a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iqq0lsouH+W4D7pbqmNOnjz8HqjljLgie4cVM1AxHoX4xY9tWMofmRwUxZIbDz8FsoG9rlB3OOZNF6TJYzUrQiJJuodWjfHRmet5GBEwU+0tQvLNkrjEiTJKs3HJHXujAEe6irbXPGV7Lr99oru/EpvgRiW/iA0EF7jxcCFinIwRmYKyIaoQvFI5RF3Ii4D1kpCGXGsL2iVrv9vPBh+LUDKzoYNm3VCfvJcdS2ywY8P1BzpEwj1CEn+Ncp9aCUD83lge5LjrhSOfSlwQsJ8PCtgDZUM+he2xJtptI9qBs5+Yg00aQu4e9vRQaC3h8OxtVrmPLMAmJ1WkkoIKuqdzk1K29FV43I7hVqfnLcyVaX5N6L8tn+4oxUGuP8SgMXRNT6TRGfkheCkYbecaVAS/1yBtgmRL2YX7CRV+xaEPDVYYCh/0urzVmTB6DyZhVsssLIk6QdQjL5ypQUzyKLVoRwKKGOZqy9U7O6fxg/DJOUBzIMQD8Yt9QhnwuDT3PdzAf5SfNU0GF+GRD8iOfVTuvBUddTLckn5u5rj8RMDL+jhKPXk0PgGdTIsHVBOEjlNwoI9k6e84KcobiMo1bWUj+U7lJcNxjnpcTtDsNpLZq2vXym4eS0mG3i9NFF4ZwkjBHlA9WGglHTpOwMhWJhTMXw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199021)(84970400001)(31686004)(966005)(66556008)(66946007)(66476007)(6486002)(478600001)(316002)(86362001)(110136005)(36756003)(83380400001)(2616005)(4326008)(6506007)(8676002)(53546011)(186003)(6512007)(41300700001)(2906002)(6666004)(31696002)(7416002)(5660300002)(8936002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXRPWlRZaDlIS3k5SzlEamNjalZBQmc2dVVwOTZMZzZsWDBJaGNGS1B2UWxr?=
 =?utf-8?B?M2hRRnZXTXN1aFovZEJHQ2ZBaFczeEVzbFRuRytXemZmMjRlSmU0NFRDek9S?=
 =?utf-8?B?Tm9qbTVObGR2a3hJcjNCbE9xdmtRY0JpYTNEUFBSditwdmZkMHRjVHIwakpw?=
 =?utf-8?B?SGhRU2dBUERYZUNTUHNoaXM3ZDZkSGFLV3hXa0tjV1JPWTYwa1VodVY3N2x2?=
 =?utf-8?B?YW14ZWJpL1lCOC9uQzFiVGlXLzg0SXJ0dFFLSmpaK25RV1M5Umx5dFpqM1lL?=
 =?utf-8?B?ZmVoZXlSYTYrTCtuUTUyQThoa3lHdVcrRUdqOVMxcjRTOHJHaDBBQlhpY3F6?=
 =?utf-8?B?WFZhbTRFbnkra1FReEFUUjFzc0w0SXNNQUtZdmdrR0Z3eXBEMHFPTFBEN1pX?=
 =?utf-8?B?a0JjNndndlhaWGg1bFI4WXplajBDekpLZyt0dGtUaDAyN0UxdzVpeHBoSkFE?=
 =?utf-8?B?djRQeGpqNzF3WHJUUWNFOFhVMGN5Z2V4M3BlV3cvZ0UvVHpiVGtzSjRLQUYr?=
 =?utf-8?B?eFFkaVhtb3krdXdkcXRtSFhRdWl1ZjFyNmRVOTBvbEJ2SlEzVnpuTWJIR0px?=
 =?utf-8?B?L25rUnJUdldZLy9taU9lY0pYQSt0TThBUnI0R3pnVUZnWm5mcytYeTJhS094?=
 =?utf-8?B?MWdFWkN3cTIvcllPdmpVa1BuckRkV08ybnYyMXNvdnl3c1VWRE5oeWVaOUJz?=
 =?utf-8?B?REo4bWZsQ3UwWm44YTd2TWZCc2s0cUxIeFJGeGZKRnhXNFNCanByUDdvWlBu?=
 =?utf-8?B?ZW5QSzVPRWR6bysyUTk4U0ZtNlpqMHFHME5zci9Lb2pwT1p6MkM4Qml2d1Bn?=
 =?utf-8?B?S3RaWGJ6VVpJc1pGVWFlTzZXRzh4SFlmR09uMXk3U1lJUXEwanVmb3laK2Fz?=
 =?utf-8?B?MUVTOUNBTmJJTklSK3VKQ0NRbjd6Y0RXOTdsa0JueVpBdGhkb2J0dTVIL1NO?=
 =?utf-8?B?dHp6Q0hGdWViK3krT3FHZ215VHNUeW4vUWxBeUVMVktNZHhrQkF1aHFITGhj?=
 =?utf-8?B?MUJIVGU2MUMvbVA3ZFQ4ZEs0dGFucHVWbFd4dXVtend1V25keDBXQk5EUjll?=
 =?utf-8?B?RDVXY04vcVZpSG43MTNYOFAwcHNOMXNTMFYyZDJLQlcvWEw0MUdMWGxXcnda?=
 =?utf-8?B?a3IrVnFicWRoTFNLV0ZYd0xYaVo3dyt1Tks1Qi9tK2hhcEVsZEl6eHl4NXFJ?=
 =?utf-8?B?NDZhVGtVR0NTcWNYbFpnRFMrSHNibVVCd2VnbXpxQUUyRkREZDlxakFWeFBQ?=
 =?utf-8?B?bVg2VWwxa1ZqQXh5VUlMbVUvc0JJQUF3bk5JUUR5WkhReTEyVGVoWTd4OWdL?=
 =?utf-8?B?NFVwaldXRHFnTGtPYXpQbm9sL2dwWi9rYTRObWNTZ1ZlMHF6UjlkZDhKeGw5?=
 =?utf-8?B?NG9rbW1KdkQ1OUp1Wml2NlRWQXZrVlZaVldKVzhvWm5MN0p3bkFvMExyQzJt?=
 =?utf-8?B?MDl4OXFkbzlEQk9Wa0pJQ1hucjJ1RDlLbEIzK0w5WGdFL2FzcnUxM2VIZVl0?=
 =?utf-8?B?Y0RnNDZXa20rai9tVzUxMmZ3NjBObHVneXpWQUhrTzNFbWw4SmRqejNMUXZh?=
 =?utf-8?B?ZCtLMlRyS1I1dmJrN1lwZW11M0pVVnQ4SnA2OWV5cFNOcTN0Tk5vd3BoQ3JR?=
 =?utf-8?B?SmN1NDF6dkx3VnVJbm9waVhqN1YyREZFenBqOVFYYWcyUkVEQXRhZWIvS2VV?=
 =?utf-8?B?bFhnWmZtZTNidmlkVitOSkErNnpEaVY0Yjlqa0xLQzJlVVJTVkpGWWxMVUUx?=
 =?utf-8?B?dS95U2FNVmNNUkdkd29LYy9MOHU1bWNTR3FTWWpZeGNvNjBUaDFCb2dRcytT?=
 =?utf-8?B?cFpXNGZjN0ZxeUJaajVNV1hRNHZyTFRiU2xkbnJoQlI1OEVuSUNzVThOVDBG?=
 =?utf-8?B?NkdOT0RhK0d5YUdrUGszM3hPcE1uMzkxMThXWXVzQ2o4NHZ2Q3BhWHQyS3VX?=
 =?utf-8?B?NU5YL21rL0NqVkdJQjNZSUY3NHVsQTBnTTJlbTYrZjdxbTU4ZmFNR0ozdjVS?=
 =?utf-8?B?K1VXbGozVTVtN3NlWittd0lNNTFtQmpwdC9JUHc1MEF1UHFmdVBCM2l2ZzRN?=
 =?utf-8?B?bzVCQm04eHVjbFRueFRNSkw1SzlhM2ZIZ0dFa2JEemVDMmZPQkI2aThzRlV2?=
 =?utf-8?B?TEd3cVR3aFFuaUZJRGN3bHJUeHJYNjFXRjB2Y1IxVGRCaU43aFFaYzU1Mnc1?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2566da-d4b6-4c32-727e-08db57ff588a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 00:24:01.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHycXmNGSrJIjMsXu8+OqO1sImP9h7nogsxmBT6semq9mpkr00S5xUcnCzDDsNQr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6075
X-Proofpoint-GUID: ny1iH55wmfT5Ts27PeHYLXiCvZU4abqE
X-Proofpoint-ORIG-GUID: ny1iH55wmfT5Ts27PeHYLXiCvZU4abqE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-18_17,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/18/23 11:25 AM, Yonghong Song wrote:
> 
> 
> On 5/18/23 9:22 AM, Jiri Olsa wrote:
>> On Thu, May 18, 2023 at 02:23:34PM +0100, Alan Maguire wrote:
>>> On 18/05/2023 09:39, Jiri Olsa wrote:
>>>> On Wed, May 17, 2023 at 05:16:47PM +0100, Alan Maguire wrote:
>>>>> By making sorting function for our ELF function list match on
>>>>> both name and function, we ensure that the set of ELF functions
>>>>> includes multiple copies for functions which have multiple instances
>>>>> across CUs.  For example, cpumask_weight has 22 instances in
>>>>> System.map/kallsyms:
>>>>>
>>>>> ffffffff8103b530 t cpumask_weight
>>>>> ffffffff8103e300 t cpumask_weight
>>>>> ffffffff81040d30 t cpumask_weight
>>>>> ffffffff8104fa00 t cpumask_weight
>>>>> ffffffff81064300 t cpumask_weight
>>>>> ffffffff81082ba0 t cpumask_weight
>>>>> ffffffff81084f50 t cpumask_weight
>>>>> ffffffff810a4ad0 t cpumask_weight
>>>>> ffffffff810bb740 t cpumask_weight
>>>>> ffffffff8110a6c0 t cpumask_weight
>>>>> ffffffff81118ab0 t cpumask_weight
>>>>> ffffffff81129b50 t cpumask_weight
>>>>> ffffffff81137dc0 t cpumask_weight
>>>>> ffffffff811aead0 t cpumask_weight
>>>>> ffffffff811d6800 t cpumask_weight
>>>>> ffffffff811e1370 t cpumask_weight
>>>>> ffffffff812fae80 t cpumask_weight
>>>>> ffffffff81375c50 t cpumask_weight
>>>>> ffffffff81634b60 t cpumask_weight
>>>>> ffffffff817ba540 t cpumask_weight
>>>>> ffffffff819abf30 t cpumask_weight
>>>>> ffffffff81a7cb60 t cpumask_weight
>>>>>
>>>>> With ELF representations for each address, and DWARF info about
>>>>> addresses (low_pc) we can match DWARF with ELF accurately.
>>>>> The result for the BTF representation is that we end up with
>>>>> a single de-duped function:
>>>>>
>>>>> [9287] FUNC 'cpumask_weight' type_id=9286 linkage=static
>>>>>
>>>>> ...and 22 DECL_TAGs for each address that point at it:
>>>>>
>>>>> 9288] DECL_TAG 'address=0xffffffff8103b530' type_id=9287 
>>>>> component_idx=-1
>>>>> [9623] DECL_TAG 'address=0xffffffff8103e300' type_id=9287 
>>>>> component_idx=-1
>>>>> [9829] DECL_TAG 'address=0xffffffff81040d30' type_id=9287 
>>>>> component_idx=-1
>>>>> [11609] DECL_TAG 'address=0xffffffff8104fa00' type_id=9287 
>>>>> component_idx=-1
>>>>> [13299] DECL_TAG 'address=0xffffffff81064300' type_id=9287 
>>>>> component_idx=-1
>>>>> [15704] DECL_TAG 'address=0xffffffff81082ba0' type_id=9287 
>>>>> component_idx=-1
>>>>> [15731] DECL_TAG 'address=0xffffffff81084f50' type_id=9287 
>>>>> component_idx=-1
>>>>> [18582] DECL_TAG 'address=0xffffffff810a4ad0' type_id=9287 
>>>>> component_idx=-1
>>>>> [20234] DECL_TAG 'address=0xffffffff810bb740' type_id=9287 
>>>>> component_idx=-1
>>>>> [25384] DECL_TAG 'address=0xffffffff8110a6c0' type_id=9287 
>>>>> component_idx=-1
>>>>> [25798] DECL_TAG 'address=0xffffffff81118ab0' type_id=9287 
>>>>> component_idx=-1
>>>>> [26285] DECL_TAG 'address=0xffffffff81129b50' type_id=9287 
>>>>> component_idx=-1
>>>>> [27040] DECL_TAG 'address=0xffffffff81137dc0' type_id=9287 
>>>>> component_idx=-1
>>>>> [32900] DECL_TAG 'address=0xffffffff811aead0' type_id=9287 
>>>>> component_idx=-1
>>>>> [35059] DECL_TAG 'address=0xffffffff811d6800' type_id=9287 
>>>>> component_idx=-1
>>>>> [35353] DECL_TAG 'address=0xffffffff811e1370' type_id=9287 
>>>>> component_idx=-1
>>>>> [48934] DECL_TAG 'address=0xffffffff812fae80' type_id=9287 
>>>>> component_idx=-1
>>>>> [54476] DECL_TAG 'address=0xffffffff81375c50' type_id=9287 
>>>>> component_idx=-1
>>>>> [87772] DECL_TAG 'address=0xffffffff81634b60' type_id=9287 
>>>>> component_idx=-1
>>>>> [108841] DECL_TAG 'address=0xffffffff817ba540' type_id=9287 
>>>>> component_idx=-1
>>>>> [132557] DECL_TAG 'address=0xffffffff819abf30' type_id=9287 
>>>>> component_idx=-1
>>>>> [143689] DECL_TAG 'address=0xffffffff81a7cb60' type_id=9287 
>>>>> component_idx=-1
>>>>
>>>> right, Yonghong pointed this out in:
>>>>    
>>>> https://lore.kernel.org/bpf/49e4fee2-8be0-325f-3372-c79d96b686e9@meta.com/
>>>>
>>>> it's problem, because we pass btf id as attach id during bpf program 
>>>> load,
>>>> and kernel does not have a way to figure out which address from the 
>>>> associated
>>>> DECL_TAGs to use
>>>>
>>>> if we could change dedup algo to take the function address into 
>>>> account and
>>>> make it not de-duplicate equal functions with different addresses, 
>>>> then we
>>>> could:
>>>>
>>>>    - find btf id that properly and uniquely identifies the function we
>>>>      want to trace
>>>>
>>>
>>> So maybe a more natural approach would be to extend BTF_KIND_FUNC
>>> (I think Alexei suggested something this earlier but I could be
>>> misremembering) as follows:
>>>
>>>
>>> 2.2.12 BTF_KIND_FUNC
>>> ~~~~~~~~~~~~~~~~~~~~
>>>
>>> ``struct btf_type`` encoding requirement:
>>>    * ``name_off``: offset to a valid C identifier
>>> -  * ``info.kind_flag``: 0
>>> +  * ``info.kind_flag``: 0 or 1 if additional ``struct btf_func`` 
>>> follows
>>>    * ``info.kind``: BTF_KIND_FUNC
>>>    * ``info.vlen``: linkage information (BTF_FUNC_STATIC, 
>>> BTF_FUNC_GLOBAL
>>>                     or BTF_FUNC_EXTERN)
>>>    * ``type``: a BTF_KIND_FUNC_PROTO type
>>>
>>> - No additional type data follow ``btf_type``.
>>> + If ``info.kind_flag`` is specified, a ``struct btf_func`` follows.::
>>> +
>>> +    struct btf_func {
>>> +        __u64 addr;
>>> +    };
>>> + Otherwise no additional type data follows ``btf_type``.
>>>
>>>
>>> With the above, dedup could be made to fail when functions have non-
>>> identical associated addresses. Judging by the number of DECL_TAGs in
>>> the RFC, we'd end up with ~1000 extra BTF_KIND_FUNCs, and the extra
>>> space for struct btf_funcs would require roughly 400k. We'd still get
>>> dedup of FUNC_PROTOs, so I suspect the extra size would be < 1MB
>> nice, I think it's better solution
>>
>>>
>>>
>>>
>>>>    - store the vmlinux base address and treat stored function 
>>>> addresses as
>>>>      offsets, so the verifier can get proper address even if the kernel
>>>>      is relocated
>>>>
>>>
>>> yep; when we read kernel/module BTF in we could hopefully carry out
>>> this recalculation and update the vmlinux/module BTF addresses
>>> accordingly.
>>
>> I wonder now when the address will be stored as number (not string) we
>> could somehow generate relocation records and have the module loader
>> do the relocation automatically

This is an interesting idea if bpf subsystem does not want to do it...

>>
>> not sure how that works for vmlinux when it's loaded/relocated on boot

If no KASLR, address in the vmlinux dwarf should match the one in BTF
based on my experience. With KASLR, yes, relocation needs to be
done for those addresses in BTF as they won't match the actual func
address in the dwarf.

Do most distributions enable KASLR (CONFIG_RANDOMIZE_BASE)?

> 
> Right, actual module address will mostly not match the one in dwarf.
> Some during module btf load, we should modify btf address as well
> for later use? Yes, may need to reuse some routines used in initial
> module relocation.
> 
>>
>> jirka

