Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D340362615
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 18:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbhDPQzt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 12:55:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18138 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236427AbhDPQzt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 12:55:49 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GGt9DG006712;
        Fri, 16 Apr 2021 09:55:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=trZZp9y2sfkKJfpi4zkr7/YrX5eyGkiodumIn3RcldY=;
 b=V28VWO0Q958IVHNN6WkebLVKC5tcz8ysmu1+CDSVLL9gEbCCGN1QukpX//F9lEMe3dhC
 aJLK9ZHPV4oD76ePlm0D1HzIMiAN0NMwvhNRtsACx7KPjSIkog/U6npUDYSSQNgfHZT4
 T+WoQS0nPpO9+WYKCQS9iYlfUq7cd5MataY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37yb5e18sc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 09:55:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 09:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up+hF1bDFcDg1a3k4wfU0XvxrAFpOmO5DyyyjF1gEEsZZryQzWIxyChorbysOZXXJcSb1mxnR9PHpqQZkV0xcB7BQbKQeMxj8SjNlH3X7yo3eIVQ3IcgxtXBl4yrZyBBM3FRRzoR7NFwyuQ9SeV9UXSHPgwcywcGA3/BG5H2YqZJ1c5nV6/9Ji5j24iCceaPz0EA5jzb7Byx81XIhCUsnEjRdbgEUOFM3Y6jbQqVK4HnPALrRznr9bS7bH6clhSoQemeWqN0dN4tuQINkBRI7DyXTDdpammn12HUITMhaEWC8orWDDIh50I8G5rCcHdGf0z+kh4LBfiijt2AjRW31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trZZp9y2sfkKJfpi4zkr7/YrX5eyGkiodumIn3RcldY=;
 b=SgJbd7Be1f4oMdsRkIckDn5ldEV/rcbSMrIwSmOxZi1N3NcmlmQdx5IDqJdQJtRS87cJ0Y0QfRfJU63ceqgi409bp32JcVLkKG1sharGkCCrK07fSV8kjHhNHzuL7FqmwTwv9kAxj/bJU9IaeaT4oOC3lhgutaCN1TuC2tlyaeqc+78FfrtJI2uS4KMI7uGo9ZfWM/tv92s/GLevQoCd6n6Ajc/7dErPGHbg7T8hRKUOXxs/w5gbG6+zMuG/eo4bidO3NB7pGqlPKGmSfK9f3fMCcJDCEnmgP7eHHraDW1jnhaat7VRWxiuCMgaQ7hVu5ASmQlWBuf40wOeAtabbqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Fri, 16 Apr
 2021 16:54:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.038; Fri, 16 Apr 2021
 16:54:54 +0000
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: extend libbpf with
 bpf_map_lookup_and_delete_elem_flags
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20210416095814.2771-1-denis.salopek@sartura.hr>
 <20210416095814.2771-2-denis.salopek@sartura.hr>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <983b48bd-9653-66fe-ccd0-464ce2614e82@fb.com>
Date:   Fri, 16 Apr 2021 09:54:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210416095814.2771-2-denis.salopek@sartura.hr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7e08]
X-ClientProxiedBy: MWHPR1601CA0013.namprd16.prod.outlook.com
 (2603:10b6:300:da::23) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::112e] (2620:10d:c090:400::5:7e08) by MWHPR1601CA0013.namprd16.prod.outlook.com (2603:10b6:300:da::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 16:54:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 503f7b53-ed1f-48fd-dce6-08d900f85ba4
X-MS-TrafficTypeDiagnostic: SA0PR15MB4016:
X-Microsoft-Antispam-PRVS: <SA0PR15MB40160243A63EF7C15FFF9807D34C9@SA0PR15MB4016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: me7R2ZEnH+2ITPS+T2nqRkLVwtqKo4bNEBUeDGCC71xkn/uBznxDtqbtxEu77nz2lb0j46GMqR4LygswNDVpMdSHP15OgbsFoGrTLO2LTGNaB7Nd5z+y9Qk5MltJa3Bvd5MX4/39rJ3efdPr3ABpoxj6DfwJJOpuOXMLw+HpLPpoaH0aJg7LmYEV7npLq/5CBAMYpcIuGmmGZqjEwm+79itIZJcM6CXgSpyKyKpID6fCstCGv2ioNst8em26dpKrZqBtnP8mhz9TgmpP/I8cAR+oEJAVMvsm03nZD3mKIz/4lxQ57gPExOFyQaBOEC8f95qQPwE6IQ6ftXRpEqmaghtNPo2hN7B57mb2nwNN00qrs/B7SiFUg6tSvreYpsl+qtMthPzIiw+2LzaBMHBbrSLx82DHimFKswcepZIqpSSTswl7jH5zPlU9FnZp9Cgc9nXH67hu/d6qBziRLvgn9pVDKkqiEaYn+91j2wzcwaibn7MSZmp7hPeQeAXrPArjfotAOFg+v6ZCybXYvu9j5UiRZDRumHwMeDbkhOVQhBGIk5VVHrbdn75wu0ftXG5EhJUTIm9SnArdfmHI5ATTnHUgyuFPM10ilUVEJdYZqFPNhCZ2v85MDY1GUYVH9MEh/AjRqlPMhIR/IldwQnvVj7BgpCvuIFHyACng2j4sGEXwppc14zQtuwrCaLWetyRC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(346002)(136003)(39860400002)(396003)(54906003)(478600001)(66476007)(8676002)(4326008)(5660300002)(66556008)(4744005)(53546011)(16526019)(6486002)(38100700002)(186003)(8936002)(36756003)(2906002)(86362001)(83380400001)(2616005)(31686004)(316002)(31696002)(52116002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ejNNQ1FIQ1hmZzduKzFXVjdEYThVTCswUkpXVEppYjhNeUNTNDNFTVRIWWhD?=
 =?utf-8?B?Q1lyU2NwMi9FaDRJblQ3eXJBNmdFd3BMMURmbDM4YzcxaHNSSGxzT1NqWkJU?=
 =?utf-8?B?MmFLSmpGa0FUbnFDSFNQNXdUTEdQOFhFZkRGOHlHM3ZCdk8yNlJWRnVsRDdV?=
 =?utf-8?B?SnVBMjFCMXRqN0R3U0hhN2NUNEJnbVdqY2hzaU5ickJwM0ZId2xEMEtCOGlF?=
 =?utf-8?B?SEluSjJISCtzdnBCL2doMDZvVEdZYXdtL3p1NG5PeFhxMHBaZ0N1QzFVZjQv?=
 =?utf-8?B?QWlDNGtueXNZOGVnTjJWSXhZTHVXajljUXltaGRhdmdtbzFrVGYvdkhMNkM5?=
 =?utf-8?B?ZEtSdmI0SlhhVFFsc1hWOEVnUEVNTkRWU1dqUk9PdUU1V0ZuMHdsR3BoZ2Q0?=
 =?utf-8?B?bVVTYVJqa0Y5SW1FcjRtOG1CVHNTbk11bE9HVWlpbFBCcXFFVVlOOUErNzdV?=
 =?utf-8?B?Rk82cE1MNk1xK3JaQWNLd05hQnBTNmRPbHpTdGJXYTVleEhPS1h4dTYvUWZQ?=
 =?utf-8?B?b0tudUFhcXFaY09wczNPcW81aG13bm5LRzIxbE9sZTgrWkk5enNYYlliemZt?=
 =?utf-8?B?UVZNOWg3OXM1ZVZQZENLMmRYZno1K25YOGRlbzRlSHp2NWlhTkxBaW1GSE1S?=
 =?utf-8?B?RFNhazBsMUg5N2VCYUFVR2xvaUhObjJ1NTNuaCtMZHZNSDR6QURxSFFHWTN1?=
 =?utf-8?B?eE5aREwzbjg3Z05TSTdUcU0wd0cyMHozK3M3UTVDNUxyUm5tMXJHbEF5VTFP?=
 =?utf-8?B?aVZHVzdvTittYjBRY05HMWVDOWZpMEN5L2RTdXkrcFNhRktVUG9aSWNWQlN6?=
 =?utf-8?B?YzFSOFp4SlJjZ2VHaC9KMXJldzdLaUkxUlNLRUl0Rk9Iclhqd3NZc042WkZH?=
 =?utf-8?B?N24zVXRJdDJRVnBYWXhEeXdyd0pNbVYzVlVpQ1VtMlNXaUhZaFI5UVh2SUw5?=
 =?utf-8?B?Zm1JREV6aVpPM2hpRGR4MS91RC95M2ljWWZXc2pvc01xM0Y5RGdObE5LUUxM?=
 =?utf-8?B?d1hoMzhYcjBvWjROWFJMeFhUdWVsTFFUY1RQV0tJU1pJbGJmUVQrbnRQc2k5?=
 =?utf-8?B?VDNFbGRrczA4T1pZSTN3VkNsN25KOVNrR2RXL3ExYm9LYjBxOHdNdDR3Nll1?=
 =?utf-8?B?V0RXeXY0MS9ieFBqaWNmNFp4ZzdlRWhQOWhKRzdydG5QSzdjOXVScFBlYmM1?=
 =?utf-8?B?QzUvVVVUY2J2dStLMlRLYjVpWndwSTkwY0RDaytyVmt3aXVTejhnWWJxblcw?=
 =?utf-8?B?MTJPb0NVY2xhaWVOMEp3cVE4SjhQVWJZUC9CcmhzM1BrZ2xQSU5TNW52ZklR?=
 =?utf-8?B?azNocFYrV3VwY3BNNldxWHQzbjBlY3BpNi9Xbmh4K3djRlF4M1pwOWVOMC84?=
 =?utf-8?B?TnlPWS9lNzBuT1BqWkwvODI4Q3JGQ2ZmWGpKOEN6bEZrUy9rQjFFMWtVMTZ5?=
 =?utf-8?B?VDJmVkJQU2E2dUVlMENDTkxCdlFiWE1JVFJpVzF0TXczYzkyOGFFVGk0VjJ3?=
 =?utf-8?B?Tlg2bkoyOHBwR0ZRMUpqZ1Blck0rK21SbEpHMTNuL2dsalllT0syZUh1NmRt?=
 =?utf-8?B?bFdPbHRiNTc4d2ZYTmFnbHI3d1VuOXpkTExyeEQ2bzkrOG5GVm9pZDd3NUVL?=
 =?utf-8?B?SDk0UE9BWVZmWktlMjJpK1RuaFJUNFVpSFQ2bkNnWUZyMDBUWXJadU5QL01U?=
 =?utf-8?B?UGNzODlBV2IrZkE5TjJySUlQayt0V3Bnd1RtQ2IzUnJvQlVOdHNWay9TeHVa?=
 =?utf-8?B?MFBjSDd1eWhnZ1A1M3NSYVdoTnVLMEhGK0o4NC9hNGdPZytuMTlQRGtvYzZC?=
 =?utf-8?Q?MiTO1/uWtbNU6ZZIb0/tpIoXTX+jAYVv6qsB4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 503f7b53-ed1f-48fd-dce6-08d900f85ba4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 16:54:54.0155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3LVqhg4sFQK+jN+F+JhjvzL0ip2Gkau2ceJM2KVBPbzavNZkcduJPUmWcTru82Se
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: iZy798Xn7ubciwSSVF8a0pjPHh9AjLFb
X-Proofpoint-ORIG-GUID: iZy798Xn7ubciwSSVF8a0pjPHh9AjLFb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 adultscore=0
 mlxlogscore=875 spamscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 phishscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/16/21 2:58 AM, Denis Salopek wrote:
> Add bpf_map_lookup_and_delete_elem_flags() libbpf API in order to use
> the BPF_F_LOCK flag with the map_lookup_and_delete_elem() function.
> 
> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>

Acked-by: Yonghong Song <yhs@fb.com>
