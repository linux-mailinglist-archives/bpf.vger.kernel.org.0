Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E0F4D9E58
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 16:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiCOPJ7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiCOPJ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 11:09:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0F311C2D
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 08:08:40 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 22FDf7KW031722;
        Tue, 15 Mar 2022 08:08:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0kQ3rEsKBnKfT/63qHBjIfhefuVvan0I/eUl143fYd8=;
 b=a6TuSb4tqqVYWQcDqQWWsi+6UW0XrRDdmX+faF6OO7m24zp0Hd3sgxzgkPMQmJXpVdOZ
 ik1lkaOs/NT/amJy/zXyhaL69kSOMkEVGc4x3Ky9NpoKS8eDT1fOctKbCOpnOgcIz9Y9
 XP7cM/0M9NN0RG/K8T5vRetICOGdOA/h9BU= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by m0089730.ppops.net (PPS) with ESMTPS id 3et99mfrda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 08:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q36D4N7eh2/kmhLJ3Q77zuk/9Ia25dbGHklj6Rq0RRpygJd60wK1Ak243+OnZkVvqFf0AZrKkn5TOjupktMoYmzp/AFkEo5WbYw5Y7jUWDpADYqQc3KiVYzczjPgvfSS3lZeTVnFUXnWctEzR68+YX6oX8LgfATdWgUbJsrJTIYJK4Rni4/3/xlvVzINy7cdwcPPBoNekFBKjkR8tB+W0qSmy8eXMNllaumNa1ojFb8frsGeiNWZ5FlAqiA4c8PgugMwBXTUHrusLv9fL7Y4DbTFH994rQh93EJuJju2txLfo0OKeylKa1hvHCFp7blQaD/nj2kz6SL2dSuX3BW4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kQ3rEsKBnKfT/63qHBjIfhefuVvan0I/eUl143fYd8=;
 b=A1M98DlW/Ssf4IR3+Ft3+nADckkl7SgfXwo4kXU8outoOzz86aQiOluXtqJtz7rRUvzjHUYPyKmlkGpJvQGWWnBPHSK3EG4hhEAdv/uHrQF1IXTMm2FykYpB30rgmnAikA/Qzo0BCo8+BTBVZC++4Ltb7MlY+GiJp65uA8+7A+SR6lSUtxeVIHEgoPdXvqsbVm8bFx6wVvWwctwBYKJQcJ86JQxlIAbP43JW0yld5XvyIn9WRZywmmCC5zlj2Hu+mjgI1x3WVhY7e4+3cW4Fp8EGZSDZCTQpRHAdzFoCtKrPXAjqcMSlfnNWo+rXLeyF2pldgVhTWCNCqYCdWm63vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by PH0PR15MB5192.namprd15.prod.outlook.com (2603:10b6:510:12a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 15:08:37 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::df:de9c:3b7c:7903]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::df:de9c:3b7c:7903%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 15:08:36 +0000
Message-ID: <5315eaf9-ba18-e550-369e-ba50c9c97036@fb.com>
Date:   Tue, 15 Mar 2022 08:08:34 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: bpf_map_create usage question
Content-Language: en-US
To:     Grant Seltzer Richman <grantseltzer@gmail.com>,
        bpf <bpf@vger.kernel.org>
References: <CAO658oXGvzTsPDTE9yLEfxJbjFvBt7-HzfO5Aa94PWXKWXPCzA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAO658oXGvzTsPDTE9yLEfxJbjFvBt7-HzfO5Aa94PWXKWXPCzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO1PR15CA0105.namprd15.prod.outlook.com
 (2603:10b6:101:21::25) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd9378af-77f3-4a23-70d8-08da0695ae15
X-MS-TrafficTypeDiagnostic: PH0PR15MB5192:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB519274747DBA5933197D6089D3109@PH0PR15MB5192.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: erGu1HLwcvkDSV/DQ7G/sKCVYY9WHoCa4oPBgf8pfmqjFbpsSufsFZ+h8ZE5q2wFJ+cJbVC5Cc0yRDdM8pcECRgT5tpK1to2SBreskNTVxOCd3dCx/YVYDx/frj7r0EEZs4ziHztxlLuBpCNa2Ub3kmysdEbYQcmLyrdXEu3IDY1XqakNIWUyB3l9BkdFl4geOf+eL7x7VKR2OcIx5CjnklU+xUoI+UVF61vLQrG5UFsFLNsrX/7YkN+W3gwDVJSXCFkL5cbTTyY7DZxRAyzra3w4fM0k8+38XExqEzLoSmBgrM6yH6SGoZZvqTIuSHNsiqnY56I9XHPYlBbH1ciOCQOytC8mAcugQYXCLxQxqcqBCBYq7MpVQM6yGyuYX/Yxr1tl/U4tQWH2H8Hq1gaLz2B5qR5xfUWRxcllabjQdoCDIBf7YkWpUi9pAVa2G9s98rcRlt3TgufhshH4pjuubygirvGzzAXhg3JB4bysKt/Zct7l6t8oU03iTMQGj2H+iW4oon3GdJ13Hpsrsp3f02hB/tqRHjZEYH+791ftcEM2hofF7Ps2mhG4P4mL1Qx4K73YSnAyyZKgkZn7a2Iiu+6JAd4R1fz3siJBaDYqcPOdqDigljqeVluhjEaHKZNC1CZS5i6GQ1ahfEILjGnvFszl8YGtX/1Sj8pXAZ6dQJoXTBJ7ytCq8H9KXLMGW1OsiTb91uHCcZsp4Dtc1ijXHS/YVvA2m+6YUapVrl6t+a4gaBrxasnRKpMg/HCxBsp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7116003)(66556008)(31696002)(8936002)(38100700002)(508600001)(8676002)(6486002)(6506007)(66476007)(110136005)(36756003)(31686004)(316002)(66946007)(6512007)(53546011)(4744005)(2616005)(186003)(5660300002)(86362001)(2906002)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWNNNnJNcnNBUjBYOXVlWENTbDBNc2FxUDhzbVpnc1prczkzU0VQNmVOMllo?=
 =?utf-8?B?cEtyUFJxdzNyeEsyMndJeGR2R1VvTWVHU29saDdWNXIzNzFmNE1LYTBUR0Fm?=
 =?utf-8?B?RGxuRllJR0VjY2h1OTgrY2g0bWxUNC9vNEhjZyt0NkFaWTRjaGZ4WWE2TVVY?=
 =?utf-8?B?OHNFMGNzUDJXUFh3Qm1xZGcydWEwS3pVbFdLdXJVQnpkOWFha0ZEeW1WZEVh?=
 =?utf-8?B?eTJKR3RhejkyakcxbmZwUTQ4M2hkZzZkU0pYVS8rWHFUcmphMkQwaVBZeTJM?=
 =?utf-8?B?dmVLUkdBM3lic29mTXFUL1N4V1BsdFZ1dVIvQ2Z5K2FVNGVYUldBc0N2bWFp?=
 =?utf-8?B?dm9FZ1dpRFlpNUx2dThCb29QR2JZZEMzUWpVdFZELzBHNDNEWi9HcEw0elR2?=
 =?utf-8?B?YVNBL2RFeE5WaEJmNW5wUTh5cUM2NEh6bHFUMjJlTnNTbUloZjZlVUJBSXFh?=
 =?utf-8?B?VW9JdWpLQTVXWkYwYVZZVVJ5M1ducFlCV3F0bFZKRDJRL05yaWxVeGhYR3pT?=
 =?utf-8?B?Q1Z6dG82dWhwbG5JQW5QVUh3WmwwQ0tQL20wMkx1UGRFS3lxbzZ3UFJFY2M2?=
 =?utf-8?B?QmcxRS9pY1hsZnl6Q2cyTzBiTVFUend4STNJNkg1dUxod2swb0syMlowWnFF?=
 =?utf-8?B?dnM3U01XZElGTWRRSU1wbGlRVWhMVWpDZkJSWVV2cVdpOEdlM1ZXaWpZSXRr?=
 =?utf-8?B?QUZyUGlWZ1RRRk9KTU5WcTNjM2xrVWMvajBYSFVjYlZTa2xNaFdSUGxSRTU0?=
 =?utf-8?B?clBCaUs5TXJRYnpJc0JjOVpqN3FubWFRNzlFbnJhUmtQSDBIdVlzbnJGajJp?=
 =?utf-8?B?T3o5QmZKVDVGZUp2NzdJSittZTZLeTBxbzNXdncxdFJiODZjT1hENFdvVHBp?=
 =?utf-8?B?VlVZNVI5c2lNSWRpMXE3YWpPUkVYQXN3VngxMkdTTlR4TllPY2VVUEpxT0dU?=
 =?utf-8?B?OGdOSlFSZGpIb0JWZ1VuZktnQlg4WjFGemQvVlJsYXBjSXJWWWliYnVXa0Zz?=
 =?utf-8?B?MTNteEVpeHZmRU5tZHJpVVc4Zk1FaWJhV2x5eWxUbXQyYnlVRnJEaXJRRHFH?=
 =?utf-8?B?ZkNsQlJRVkpUWnNRbnl4TnN0cktqOGtCTzVsWmNLcGZjRXdJOWtnek00VkJs?=
 =?utf-8?B?Zi9WTTlaMmNJQ24reU5XUFVaQUQxV1dZTWlHUFVZOER0d2RXZnJYNGd0OGQw?=
 =?utf-8?B?NWJUb2owZno3dmVMTSt4KzE2YkltbWg3ZUF5UklsRTJWSDlaUFc2QkJpamRB?=
 =?utf-8?B?OTFCWjJRSjRpamRvdVl3b1RBcXIwZXNZT0hzOXFNVlBSMjRRVGM1UDE0N2pz?=
 =?utf-8?B?amFyYytjNXpkclZ2bFhCMWhkU3ovYklzV1dWcVFwd3ZPeHBwT1JpcFU5WVgv?=
 =?utf-8?B?Ylh3R2p0dnNFNnZNVi9QVXM3ajVrbVVlZXZxSkRrMmFhaW1VK3VnbkpFclBx?=
 =?utf-8?B?WTZVbUt4eGlGYjV3OThrNUx3eWF6emFVTksvT1MyM0Y4cUgyS3hKWUJUZHg2?=
 =?utf-8?B?cHpEVnJiNkN0QkhmZVZFU2dNYlVxcGNTS3IxcXY5MHdDZlN6ZnUrU3kvOWYz?=
 =?utf-8?B?aGRSU0R2cWVXSGJRRC8zS0pZRm5naTNUbUF3aWh0a0NCNnU3a0NET0FoQmRa?=
 =?utf-8?B?L0JrQkF3bmNFQ3lvT2lla09pakdHc1FkblpJdnpsR1FJRTZYeHRVeGM0ekVp?=
 =?utf-8?B?MFZnd0dWVXR5SnRYbEpNUGJFeDhCM0lrcklaaEJZWVlQQWhMSVorOWdtZGpO?=
 =?utf-8?B?bUhFMGNUMldQcmhSUWR1OVNWZlNkaGhHRGpiN0VWSUJUS0ZIa1R3OE8yTGxH?=
 =?utf-8?B?QlBneEh3OW4wcEkxaXBTZWk2aW1QRmV0RUxtclZrczhtUjdvTGFZL1Q5YzFt?=
 =?utf-8?B?Vm95TmZDWm1vVG1lcHJNM0xNM0FyUmJHYzFZZmVWZ04yMWNsMGIvd2U4cElp?=
 =?utf-8?B?OUN0ZTRYL2oxMHJZK0JRbWgxL3QvbmNEeFVwckJ6Zmpac2xiZU1KZEE2WENr?=
 =?utf-8?B?TDJGTHI5cmtnPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9378af-77f3-4a23-70d8-08da0695ae15
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:08:36.8287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zy4XbePDyestK9+Az7G1O/TzVPDCO6CJsOxENECOsnLvf1QLONre9tDVKesatZ00
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5192
X-Proofpoint-GUID: m1XxV8aUmKFsa7SsRuYV-XM2Lwz6zEWy
X-Proofpoint-ORIG-GUID: m1XxV8aUmKFsa7SsRuYV-XM2Lwz6zEWy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-15_03,2022-03-15_01,2022-02-23_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/14/22 1:15 PM, Grant Seltzer Richman wrote:
> Hi there,
> 
> If I call `bpf_map_create()` successfully I'll have a file descriptor
> and not a `struct bpf_map`. This stifles me from using a lot of the
> `bpf_map__` API functions, for example `bpf_map__pin()`. What's the
> reason for this? Is there a way to get a  `struct bpf_map` that I'm
> missing?

To use bpf_map__* apis, you need a bpf program which conforms to
libbpf bpf program/map format (see selftests/bpf/) and from there
you can use bpf_map__* or other libbpf api's.

If you use bpf_map_create(), you can use bpf_obj_pin().

> 
> Thanks so much,
> Grant Seltzer
> 
> P.s. been a while since I've worked on adding docs, but I will finally
> be getting back to it!
