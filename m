Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534DF32C21E
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384745AbhCCW5c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:57:32 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3208 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388016AbhCCUYi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:24:38 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123KEVDf012123;
        Wed, 3 Mar 2021 12:23:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=+bs0h6ClCVGC/Olti0O7L5YWGNIictMGxx7zaEtWzrQ=;
 b=UgqHiPve1bL8B5OjWjJnXJLDgejCVllUa5JCV7TMslydg3ZDVzxqNG8vUiZDPFhxi+fq
 MqiQxmYPXGAMVsdHYuecrt8sZD/LpFDnmo1LvYsvzX3wUNrlWx/jX6Hzi2/q71gGbwvP
 RGkQAzuBPCTE20cjULQbmpwLdiGgwwNqAU4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 371yv1d8c7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:23:37 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 12:23:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDsDFGHp/VhfFihJfbkZ2GZRc2oSR9mCuOLgmrgrxAqoWuN3UV8CEREBpwAIB9orCjuM4HGNpcnol36zoiDBsCBZ5fWee1I5LMnAcn7LSFoSnIN6lkePz00hZneGzvUEDSV/cdCQloYg/46VlFS9zYPEBXRIMG9BLZTYBiGe/PyAlIdZhcjlJ4dWmOLDwI9hH3r9mS1o5G13ZlBRDYicIZ74kd1O4o82l3df8otbqnqk1gOjWOg9XiVKy4j6tQvk8I48I1o0cbEr7rmdaVfc7aNTWH3vGkhlzjERXtlZI/c/R4YGjQf+PlkasiiG9MYvTzB3eaQXLEIisvq1hs6JBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bs0h6ClCVGC/Olti0O7L5YWGNIictMGxx7zaEtWzrQ=;
 b=aZi7VGQduD3AyVwwSa+Rw0ekiAHioAA8yxML9icmeDsL/EbcuEbpWAaULzPGUZ9qy5sXMrE5QdFnZbuG0GeGVF8dJNrdh0PmSFw5QjizP3rEPWwikbWNC+VQa9Mc2PjgFZ3htm5GUKkqrY9krXuZn/C5v48/56mg+Bkm5RUplOrPaMUSPaO9o3jW3DRSvdwGPvKWSHraio9tvbxkrrmpy6hip2Q9ODnjPtMhqFdXn09PC8qAQDb9zeuo9gQa5pFsNLwOkXNUMg1BVD4RJ+tagFyCR8kJ/wwtksFw9XW0C8M4GCfN7nJjrOen8z0q1ePsRgEgJc2EKBcAYJzRVfcX0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4222.namprd15.prod.outlook.com (2603:10b6:806:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 20:23:35 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 20:23:35 +0000
Subject: Re: [PATCHv2 bpf-next 05/15] bpf: Document BPF_PROG_ATTACH syscall
 command
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Daniel Mack <daniel@zonque.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Sean Young <sean@mess.org>, Petar Penkov <ppenkov@google.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-6-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <8ec11fd0-caf1-da4c-3b12-6ad889828fed@fb.com>
Date:   Wed, 3 Mar 2021 12:23:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-6-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MWHPR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:300:ef::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MWHPR22CA0009.namprd22.prod.outlook.com (2603:10b6:300:ef::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 20:23:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6df4d23c-d533-4a25-9216-08d8de8238c9
X-MS-TrafficTypeDiagnostic: SN7PR15MB4222:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42229F74521B8BE898F91E6ED3989@SN7PR15MB4222.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fcRw+5I7oAP/bU7TTsXbsVS6YAGrLyu0HJADWh79wQDECfqBw7510YfcOgFMURjTrPTaGzm0OMiu5yioG6WmxZlBy6ol89wMWofgqLvFdsVCYJ0rhPaJLQrQbzhT2EDbSfJj0wsfWUBztdprsOPyPZILIjrBCnJJYBZTimSHd50ZiPgdJSSLCnWHWIh4+npNiJUGg5y3VypLN8nWO1Ttc+XjB6wljo6kUbZhSoUMrsD8XzIbYnbzhSjW+A5Yi2ndNC7caVlvGqlWu+bNZvh/rJEKyS0mUr7i9odmsVXOLsAAbk/R9Nfo1fPyOtFh9FGsZSjoTMMbawJOUicMMhsr3vltuFvX/AOyyJjnfs2PsJKuh6BHqk3asa626v00DaJSyLYn1Tkgnb0q4ooIzm/8R0LM66LcS40AJuRx5564GFmhvYPrNYgI7tdyM2HtU+KamOOFV6d5CJrXO6RKuj6t1rYl5C+BU3ZBPxYNucTZugupxCfS0ZCAeyCmjpeQFrdfqAtExiq27C1NEBZr68tQoEQ/7dkks84idYrqVYj5hnHRCz0tkCHVzlDWJzQn1SWPpn9owT4Hx4gq28X/yuENdPSKrpH5T+Gv1nOddfEA+JY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(396003)(136003)(376002)(31696002)(8936002)(31686004)(52116002)(53546011)(2616005)(86362001)(2906002)(36756003)(7416002)(16526019)(186003)(6666004)(66556008)(8676002)(66476007)(66946007)(6486002)(54906003)(478600001)(316002)(5660300002)(4744005)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L1BpMGQ5TVZVUCsxMll3MVIwcGJpa25LSlVBL2dHYTNPa2F6N2I5WWlyUmRz?=
 =?utf-8?B?U2RLdkRpV2tkOGpucERMZnQ2bGtqUlRtWWNhdmZNaXZtZlV4blNGNTJVYUJ1?=
 =?utf-8?B?dlA2ZFNEUlIyRXlEUW1lK3NQYkFBMC8raDVNYXh5bTgyT2ViZjI4T2tWN0s1?=
 =?utf-8?B?VGtJVHNpeDZXS3F0NG1ERTVybE8zTFh4dGdpemdGSVZ1VmFsM2E0MlA0OW4x?=
 =?utf-8?B?dkN6YjdxaDBOUitCUDR3Rk1nWnpYU016S3RidTFlMVZvSThrOENDWEN0UHN4?=
 =?utf-8?B?VStPOHlHdjdrTVN2eEFhSEZiWWQ1OFhZL3A0aWRQTjhhY3pCQllvSWQ1UGNH?=
 =?utf-8?B?TG15SHJsOU5pNE4weG9rMlBtNEVzVWZWSnRvSDd2UXNOU2JwS3VIWFFXejF2?=
 =?utf-8?B?L2cvK09hRnRtcDhnVmZPdFNVVWkxajVrUGF1THRHbjRkRVVESUpyaWhMVWdU?=
 =?utf-8?B?UWZ3Q3hoSnFIY2kyajZhWG9LNEI1VWlPTDd3MTVtbFZHWFNWeElxclhxRHkv?=
 =?utf-8?B?bjRkcks2UzR3UWtpWWdxazlsNFFtdUVqK1FkTGY0c0dGeW1QSENMSjhJNi9X?=
 =?utf-8?B?cks4ckJLb3NmL2JTT0p6dk9lQ0RYR3ZuMStUV2pRaDJmTGhGR3RNcmliWEpH?=
 =?utf-8?B?bXNtOWptbE11dngyZGVxaUVYR0VGYkx6QlBWQ2dCVW9EZGtBMVNRclBLNm05?=
 =?utf-8?B?RTEyUEc3RllIbHp1ajBjNUpueUdoZFhKOW9Hd3lxY3ZoWHBKTDRvR0J0S0Jt?=
 =?utf-8?B?S2xpcnlTd01EOUNCZ2pKVjVXQ1A3YWpEWks2SlRyZ2d2TVJ4WElWWjQyVWR2?=
 =?utf-8?B?YmpibWR0NjFkOFZXTjVKSmpCZGhDM2RTTER4aml4SzhwZExKRlFnTml5YVVz?=
 =?utf-8?B?S0E1d0YyMk1uMVlla0hDUmNmeUdpTUVyR294a2tOaTlMUTFIcTQ5c3NDYlZI?=
 =?utf-8?B?ZGlFVUpVelJrVGRuaVk3ZmNFNmZHbnNFYWJGRHBIRng5cFhDUmVFOHpwYzYv?=
 =?utf-8?B?NUlKdndSb2lrcnFqa1J1OW1UMmxEQW53L0lkSUgyOWRHa0lGcnEreEdiUHFi?=
 =?utf-8?B?WDdJL3RSSFQzMGp1dFQxTkxYVHZwa0RBWW54NWRuM1Foa2JielBDU1hsSjl2?=
 =?utf-8?B?QjYrWndVaTA2c2ErV0NCbURYcFl2clZsb1YzZWNkVWR2NVdsVWMxWDhrd015?=
 =?utf-8?B?a2Q0RldnUEIzYmZHTGlEcGdoZ2hJVkJCVmNYZXpWL0NIdDBaQVozcEhLRlZE?=
 =?utf-8?B?UENlc0s0dzgvMGZiaHN4YnpaeFYxcEFENjlYMEhSNXFlMFRVQnF3ZjB5eTB2?=
 =?utf-8?B?VHk1SXN0dWI4NFovRkdvZHZRSDdiYXJ0NUdlakJ6Q1Y1d0hWVW1kWkxlQzdW?=
 =?utf-8?B?ZnpBVlZKMUxBYXRpa2d3Z2VubDZDaTBiSGNHR1dxMkxRdENCSlN2T0k3TFlR?=
 =?utf-8?B?d25WYWt6d3k4SnREazd1Z1RZSS9FdG9aQm5TMC95ajhOMWRJOE40UjIzNGhZ?=
 =?utf-8?B?UENXV1FGRG9VeEY0K1JDRFRDOS8xVjNUUTdWaDBvb3R5MDI0RVNYWWEzRDFD?=
 =?utf-8?B?bWNUVnN3czh1ZnFXbHdKRGpOQXhUZkpZMmpWK2JKeGNDcXpuQ3h5QWw5ekUv?=
 =?utf-8?B?MENib0FvOG9aTmVSTEEwcFhiTjB1OUw3SnVhbm1xTGF3VEQ3RDFETG9ieHRm?=
 =?utf-8?B?dTcyODVBbHhhYnZiWVFJQnovVjVyUXlZV01KZ09oR0dmN0hJeWo5R2UrUjky?=
 =?utf-8?B?TjZkL2krZVlHd2tjRWh6VEFZS2N4aGU3RzlJMEVURENENWRJYXhxbDhjbzl5?=
 =?utf-8?Q?V7PDJVZQJGnL4XOtbzYL3hB3OrCDEycTUqO/I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df4d23c-d533-4a25-9216-08d8de8238c9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:23:35.3493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDjeoGF1+3uowXG3iSi/C0pBuMOOVdcX5jzIkKgUn7QrGp77SjX0mm9n+EFqPBtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4222
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 mlxscore=0 mlxlogscore=898
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030144
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Document the prog attach command in more detail, based on git commits:
> * commit f4324551489e ("bpf: add BPF_PROG_ATTACH and BPF_PROG_DETACH
>    commands")
> * commit 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor
>    socket TX/RX data")
> * commit f4364dcfc86d ("media: rc: introduce BPF_PROG_LIRC_MODE2")
> * commit d58e468b1112 ("flow_dissector: implements flow dissector BPF
>    hook")
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
> CC: Daniel Mack <daniel@zonque.org>
> CC: John Fastabend <john.fastabend@gmail.com>
> CC: Sean Young <sean@mess.org>
> CC: Petar Penkov <ppenkov@google.com>
> ---

Acked-by: Yonghong Song <yhs@fb.com>
