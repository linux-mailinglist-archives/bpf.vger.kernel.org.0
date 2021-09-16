Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12DA40D28E
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 06:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbhIPEak (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 00:30:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhIPEak (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 00:30:40 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM3vvX015240;
        Wed, 15 Sep 2021 21:29:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9vNevVW7e3ClaHibrGuCYCdRgjZjcVUtCLNPWmyqITs=;
 b=rcmYidAbKj8Hv5BiGfYywkf9/2h947ZImBSS1GOdnvkNhZBkuXhKQCpRsXGdSWxxoP4b
 KgLNKCrGfrZJYjXaEZ8dShm0xZ2W3P5injVLlBXx0uIcKthH3f4vUkny1wBHZQzI+ljH
 39AoysrfOMt8HVGVrxbY9TfsIyOqreYoaVA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3my2bmyw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 21:29:08 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 21:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx9WxJYD1OMndwUKb2Tnh5m85Td+mjpf/lgjk5vr1qEYgsLyHeNjNhhbruFGOhZJArkrffUr4Jw9sCItK9Dce5l9sOic3H6b6lHsDFGSXk5lM1Syd5AzwoB8OtPyhvB+pvo6e9O8qaVyHCarjt44HJmTV8mVr+Q5dshppotzC/Geh/AFOvsYupbrZPj0LXwZYXUyWPTQaeLg4npB05SB7Nof4ejHsqAXrp/xuMNVniTi4vgTfDt7VkmHF3C7TDpOvCeVt9B3fgkpKXHJwPtZj+4h4xlCx0h72NbZaHrEwIL5szd8yCkd3C6uv5c3TuC2+WycKDW+nrFFfEs9NXTTKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=9vNevVW7e3ClaHibrGuCYCdRgjZjcVUtCLNPWmyqITs=;
 b=lGnFUPbLymvoU+N0JGE8QHrHBo31URcrAx1WpOucSogYhLVaDNi9FoxRrlg+ciF7W0h+w+tg/0ZiMeYBUVBQMMvUbx3WShxAzO9UGTRNPFB9IhpOlVpKu4gHYzXiWZ20BwhEUmBPPJf/ChLfKQNb7acE6meBEIrQqbwHOwLm57+95YTKI3tFuMsKI+anc+dQret6wYkwxlU+tw1IUiuR3/nAKPfoa/Y0dd91swE+LXM9F6bWA0gQbe1Kr1JoNh4fA4hhESJKbXjc3mxluOuAsK74HUV7aySIsHPHXC9XRI3XYeisQG5fn1OKSFNe1mAlv8HanlIB/d6agu+y3TvmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 04:29:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 04:29:06 +0000
Subject: Re: [PATCH bpf-next 7/7] libbpf: constify all high-level program
 attach APIs
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210916015836.1248906-1-andrii@kernel.org>
 <20210916015836.1248906-8-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0021de1a-3c56-df8b-36c2-6a5952afae46@fb.com>
Date:   Wed, 15 Sep 2021 21:29:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916015836.1248906-8-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0082.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:51c) by BYAPR07CA0082.namprd07.prod.outlook.com (2603:10b6:a03:12b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 04:29:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a78aa7bb-37dd-405a-691c-08d978ca84f4
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB406246AC4F24687744B2D21BD3DC9@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:530;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fr+fjhm013q1Qq2E/M1uVcSopI/LT1sT/hlqfM5h+6iJ9XuUA6aP+LH/nHhA5YpQEeaRQmZ/j5AQgcTEMdHhzbiKTsj9R3goYgnijPUZyhlWQqgigG5F6aG0Pimua1PJfui+oIbBFv6N3op9SUp5UHt9ZGYtdxdK2FCiLv1CXQDqTZzs4hP5VM/jI6W8HX3UzE/ozIiSF/DwXjcGpiEDM7qhcGMAGsNdkBHEYRlzzOgcDP6pkNQxgbqcWGe0X3SpXtn//SobGvt6hPQecEKzdYc8RZ3UMApA6R2LIPgLHHzv42sKtWV5FaYqi2WIkJL44xzeIrMf7NFf52TqMjlvkNNJKk/NR6R1I+Q9ghFOWNSuEkiWvLk14dsM9XL2H1oPFUps3358JSLZ77aDeWX+ZPt6Wg2AhIW6VXz33NMJWo/6tICI+eRAcCP4t3sebaz7Z0smqiHpUMTBiZr5owYY/w+0jzVx6BuofPLKdR7pwb9uijeiemd7yz2CK4UsXMEo0ck3Bi0/Lie5icsnBG/Rv1ombIQvz+f7pOCtaUl3kwtZMI26sA8yH16d94mCFO8vD3WxOt8Nw3mBGO7Xy2RbOvwQYU8ob6aV12H/ydtn4wQj4uaoa98F3A28GEp3xZ/6vEkrLqIqAz+tn40p1o0H7txb8pUQR/wiFQa1nOmaZ2BVq7cTI+2Gjld+PmyKKs6lYy2fXgJG7LdXdMIi+VP+TBvPC8xOCADNerrjJcp08IE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(4744005)(31696002)(53546011)(66946007)(86362001)(66556008)(38100700002)(186003)(8936002)(31686004)(5660300002)(66476007)(478600001)(4326008)(8676002)(2906002)(6486002)(52116002)(2616005)(36756003)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWxHTk1IbVB5OThDYlJkNFgyN0Q2SHcwSUV0VVkyNC8yR1RlcDk0YUkyUElS?=
 =?utf-8?B?MEZqRVRuZXAzZnJBK25NN3liNXlwMFU3akZPa1RTSW1FWk1HeVdqY0MzVldw?=
 =?utf-8?B?K0RWWU5rRDVoRXRLc2JoOGprYk1ZdHoxV1BKbXZOSllVWUhQdDRXankzVEZh?=
 =?utf-8?B?MVJGN0gzVjZHT0l4dU4rYXNHSWxkUUlOUmFnN2w0aWVSUno2LzRRMUM1RUJG?=
 =?utf-8?B?bXlScFJlellBZ2ZDak4vZEZyNUxyMlY5TTZQV2p2ZXZtTDYzdndJck45bTBR?=
 =?utf-8?B?UUVrUUF5T3lzUUphelFVYzBnU1NYUnpiOGVjM0p4QWUzdjFWY1JuN2IxaDdQ?=
 =?utf-8?B?QWJmdjBrR21PTGhNOExQcmplSUZVRkVFSkF2ZHRDNDRReFIzOCtjZzJCeXJD?=
 =?utf-8?B?WU9DSlBpdXhRdnVqakxjWUQ2V0JqWWtVWm9yU21NQ1JhWFgreVNWbzlybnJP?=
 =?utf-8?B?MjRWcXBBYnprdFJidkhkWDhYeWtQMy9ZOE50QWdQMTFJcmhwZ05ZZE1CS25E?=
 =?utf-8?B?YkxhYm1FS3RacFpxMk9rVGhlQ3Z4U1FoeVA4dTlIUXprVlZ1NnNLRU0wQ0I1?=
 =?utf-8?B?NFRiblNLV1VFZnFwamVseEw1bGlpcCs0cnhNelRSVU5YdWo2U2UzSzFkdGRT?=
 =?utf-8?B?NXVFZHB3bm9FcWNvcHY2Z3hSd3RpR01mbWttYzZjS3d3YytyQUIzeklDWXNZ?=
 =?utf-8?B?QzJOeWNXOHc4ODdiY3dORS9MZHcyM0JnS2xTOGVMRXZNcXQ3TGw4N215VjFn?=
 =?utf-8?B?cmdGYWhYZmZxU3VETmp1TkpabTB4empYVTRqcGRzQXVrSklRUCs3VVZHUlN2?=
 =?utf-8?B?L0tqQ0dVRlZhRTRZd01JRnc1S3VXMFpUZmgrYjRnc0cxVjhMQ0lvWTRYaXFJ?=
 =?utf-8?B?bzU2VXlTdklOWGVNaEZGdnFPUWVCa2wwVVV0Sm15VmlmOEdxeGdHTVRzdnhB?=
 =?utf-8?B?SWFiV3RuT3hGa2xCWHBvRTZwR0RqM0ZoSTlHbEhNYlljRGZLeUhMeUtiOWRV?=
 =?utf-8?B?RDdCSkZYa0lwVWtHN1RHc1ZGc2pYWFVqb0U2QS9RdE1ZM0FKMkpxWkFBOU9E?=
 =?utf-8?B?ODRWbEhadk5JWGwrYmswNUpxNm95ZTk1NHlRZHZLaEFmTTNPOGJodHY5a0dm?=
 =?utf-8?B?ODB1OWdEcExNQjJkckdpQXBwMUxjT3haTGpTMHJUOVpZKzV2NDNJbU04KzJn?=
 =?utf-8?B?YngrNmNhVzJMYXlEcm0yU2VRUklXWmNIT1FxVlArejVPdGNCMFdncW5BZW9L?=
 =?utf-8?B?aVE0Mm5TN09FVHoxa0NIMkxQdHIxUWdWQ0d4aS9NK1JCL29HOGNBTURLSFZN?=
 =?utf-8?B?L0c1U1kvYnY1NnJRYVRNYVFRNWlEVzN0TVZmZzhNYTk2dTVTUk0zeDRzeVBy?=
 =?utf-8?B?bjdQa2dEOEdQdjNNemZjeHppa3E4UVBKWVI4WExJZGtTdlA3SVV3OTk0cE9M?=
 =?utf-8?B?Y0lSTEFacHBqdXB6RGg5dWdBMUtHa1NaS0NSblFyVFk0TGJmNUtseWpSR3V2?=
 =?utf-8?B?SDlTcjkwMC9uTS9udlBSUlJyWVJydUl5Y3FDSFY0UnRSeHZZVyt3MDdMUlg1?=
 =?utf-8?B?Yzg3ZnZLVGRuQ2xwcVBKZkRLcHdSeTNZaTBqSFdEYVJRbHVKb3pXS2doZW9l?=
 =?utf-8?B?LytZWGpjZnhVOW4rZzV5QU1LZmNSYnE1ZklDaVZQNlZZK0FaOFZKU25PR2lm?=
 =?utf-8?B?UDdlRkhoVEZaWjVob0ZMVmxjdCtVYzFNOEEzQ1F0bGZVRUorUVFLUFgzbkJl?=
 =?utf-8?B?aVhwRGtpeUdUYjZLbERZaXVwZ1NuOVZCTnNUc3FKNVVZcVkvaEhaOGNId1dS?=
 =?utf-8?Q?FTPaYiIZnsULEeIJ2Ha77tH1dwBQdLkPLeR1w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a78aa7bb-37dd-405a-691c-08d978ca84f4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 04:29:06.0072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Git+mkCk1VJkRfH8gVFuOSjV8VGYXa3fI4wssJSMWGhFk+KZe+9tkaqpRxkQ4gKU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: UyXoUPeFj-FZUOARgQhmEra_7_SU-GCB
X-Proofpoint-ORIG-GUID: UyXoUPeFj-FZUOARgQhmEra_7_SU-GCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_01,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=972 bulkscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> Attach APIs shouldn't need to modify bpf_program/bpf_map structs, so
> change all struct bpf_program and struct bpf_map pointers to const
> pointers. This is completely backwards compatible with no functional
> change.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
