Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7070332C223
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391575AbhCCW6b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:58:31 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:17192 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388036AbhCCUdH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:33:07 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123KPTQU028564;
        Wed, 3 Mar 2021 12:32:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UfxN7kTcZ+ncAzcCyjUTzDaffhuHLrgiJzSLQKz2THI=;
 b=Vt6idpLkurt+NrJkkVCOVZlkoWUNviuI8DwWAt1MrsPqJQ3YqmAjlcpSX7aUVGkrAVx0
 Cun9d6ER9nF1SZtUZsHU01XVzxFJhZurmq3vaPjRLaIt8vNUSa3NwvR6tzqZ+UOxhtZM
 TMCunkBqmWVsYCC5aT/+ACyKa02syQqNaJA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 372107w14c-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:32:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 12:32:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDh9YahIV5YNfLVGyOW2ER+ocMsNntDEc8ieRWuwT7unKNhFvN5tw/xSrpdfNoaq71tNu3/L+mKmJVFVMsM7vfbV7BuixIRYmW5EJ8TV3668kBl4lTW1PGryC0NMTh/VqJlhwsazm/G4V8TAAcK0e94UL+jCQzmayNczX4A5z7Vg07NfA06Lwpfz1fsrLK6BnUMrTpli798njq68y4XOCi5O0Q5oWjDWr8qRusADFiSj1/lLPFXi58XU1yybWq0stCT/d5jNZr8YDhH/vaH17c7fvRJrQL1iu4aXi5Tb3coJMdOO18p/dVPW9PXrtszEgrvsDTSNqDAbsOJpN+qshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfxN7kTcZ+ncAzcCyjUTzDaffhuHLrgiJzSLQKz2THI=;
 b=DrgztPe5yH0qh7daQjgBp5qlkX0TKddGdfCuLOil5YZsPMhg3UvZXACzRyjwnrTTiIcCVHf0HKP761FtAgviXvEr9a4MQwPppr1o9XY/k6hXu0kKYwDNNpFeX55HrZDNtpKRtPnhfipPW6pvZdJia8w466SWlQEB4VXj4or1IRf0WzMIDxXPXg4gqh5brtm/YgBNjYtfTy4VNS/EqNhyf3rbCKFj8KYWiq2qEX7m2mgRbWuOMZvHGOlkZuql/b4QJ6ytovVmC9t8su//ZK8sltXSI6oqQRP1C9FGv81wEC0Cum9onC4EODAvUHIfoNaIMoBRu58edvLkWlkkcnGmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: isovalent.com; dkim=none (message not signed)
 header.d=none;isovalent.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4418.namprd15.prod.outlook.com (2603:10b6:806:195::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 20:31:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 20:31:53 +0000
Subject: Re: [PATCHv2 bpf-next 07/15] bpf: Document BPF_PROG_QUERY syscall
 command
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-8-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <76a428f7-c6c9-1cdf-7ee3-a7a2d1e07dfc@fb.com>
Date:   Wed, 3 Mar 2021 12:31:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-8-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: MWHPR18CA0043.namprd18.prod.outlook.com
 (2603:10b6:320:31::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by MWHPR18CA0043.namprd18.prod.outlook.com (2603:10b6:320:31::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 3 Mar 2021 20:31:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a1ccd59-bf7b-4185-2ffa-08d8de8361b1
X-MS-TrafficTypeDiagnostic: SA1PR15MB4418:
X-Microsoft-Antispam-PRVS: <SA1PR15MB4418B5682B491FB9BD378720D3989@SA1PR15MB4418.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tK0x59KQuLT5QPSdCqNApcnsGaynB49vo+uuM8G2yGDtAjm8F+KTFbywFiVLVK7uRg+SIXUG8bDL8tK1QHfkbQk165D3IgPKSBU7GQAOeGeh/Ym/SvpnvLKngSvI5tsuIdLN6O8DAmnWIof8FcQ9uMZs1EaUst8aguKmVV3Mqyy4epXBt+yTZ3veiu+rZlv0nrJKesPO6wlmyTCmz4lt8d+KC9kC//Pg6TjaAEC0knidyfbQE7TrnIKFtVqoohBZay6tFVaLWLt3AMbq78aKsKu1N5XrrDlDgcFQB1aG9uhTGrylMBQzgXQDn5ZWJ+MSAK7jj8ZZoYoAZUix93tLHFoFxdynkvwsDn9xg1OHA7KWHL5BlZ8mxDzzRR1R8hiTM2sfq8hz8ZWvKpYGmAcfgBVoHl3DrvyG1dwVXq6bmpwg4nViKN7VZoamSpGWiDm64EkhRvf+U8cADbQ8goPr+WJ14WZf2CLcnnKKa9tsWYT5aZmNfCTtHyGZQD6hzTVudx7u3iP8TTknofyN89rUpT7k+c4gXsX/DhN+OZfd0L6e9TWxxVdPKFvwncZZnAq0DleWwu2Itv86hg7pC252j5MHTXUTcNbIikuqRCQXFMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(376002)(136003)(346002)(54906003)(316002)(8676002)(31696002)(66946007)(4326008)(4744005)(5660300002)(66476007)(186003)(66556008)(36756003)(478600001)(2616005)(86362001)(2906002)(16526019)(52116002)(31686004)(8936002)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2ZsaGdaSHhjb0pJeWk3d2F6MUwyL0pjNHV1ek9rTXp4bE1tYndzTkR0T0Iz?=
 =?utf-8?B?b0Nta3FGajR0OVhSRmtFSURQM0ppQnVKVHc3R3dUL2NpalNEU2EzN1FZckkx?=
 =?utf-8?B?VkVsamZqL25YSjcrOTIyNEd4K0YzdzNpdjUzZVhVOTlNTjJCb1VCUHN5N09L?=
 =?utf-8?B?eEFPNzVqZllMVXNqVHdQMENZeGpQR2MyeDdEajFkSDZ4bE9wZldRakRGUTJM?=
 =?utf-8?B?T0NOTThuMXB4dU1RSjZMSWlUYVkwQ0trazRlMUtuTjZSY0VxUFFjSms1dGJi?=
 =?utf-8?B?MWs5NzJUc2lodHRSbWVtc0J5MzRDU0JBc25LR3dCdnhOdkQwL2lXNlY5WVI4?=
 =?utf-8?B?eFJtcmhqZ1JmMERBdEc5TkFGTHA5cGVaWE1PRjJNRDVGNU5ZQUtIYnVabG1L?=
 =?utf-8?B?K1RCRXZEUjV2RkZoTjllMmxrUnZUekh5OVVQb29KV1AwWWRHd1VHS1kxVEZY?=
 =?utf-8?B?L3NpakJVLzhna2tyWDd3VFdkSFNlOG0yZm0xbVdrRVliRGs4Mjk2SVJiSGs2?=
 =?utf-8?B?UjJFa2NocmVMT2FwZ1ZuYncyVnAxT1JYbUExUU8ySU5DQnJrS3poMGRJOGQz?=
 =?utf-8?B?c2lXZDVHM2hEMGtNeDNEdkFhVm4ySjFKVzdnVFZUOC81Y0phWFpsUXhKM1BU?=
 =?utf-8?B?RUx3VVlhUzgxV3VyK1RETVgyZzlEYkFBTkV0eEYwalBFVkJxZkVER0NwaWJT?=
 =?utf-8?B?Rm51OVBvM3FVQ0VxYUVBaUJuWjdXcWpGa0N3N3poaWRpWTdFRENkaW5zaU9M?=
 =?utf-8?B?bk55ZDVPTENxVGNTNGF3cTNmRHR4RWpsVkJDeEFycXI4ZzBDbFkzT3dwekY4?=
 =?utf-8?B?R0tQNlZnTGtENi9PMU1NanZvMFROK0cwVTZpUjI3aFRpazJyK3NiSlBkQUda?=
 =?utf-8?B?NHV2OTFPTDcrUkE0ZmV2ZU5pN3Z5VVdDZDg0T2NiTVNWekZJUG9DdkhDQ281?=
 =?utf-8?B?dUdTbXpJT1NGNlk4bDRWQ1h3U0RJWitacjR2NHJEcEJ5Y0RNaVhaSkJhWEYw?=
 =?utf-8?B?Wm11UStzZDF0Y2g5M29SWXE0RFVrekZIeU9PaVhjcU5UUENMYnh1eWswWkQr?=
 =?utf-8?B?NnhDaERtQ0Rvbjl6cW9oc216alJpYnVPK1JPTjYyMmdJa1QzbW40NFB0TEZj?=
 =?utf-8?B?TW5UQ2lmbnd3L25sbW9EMEV5c09yRzNNZjFJTVdFM1dXcHVGck14ejcvVG9T?=
 =?utf-8?B?TENacTd3VjgwS2t1VW5YbnY2WFpMVHJLYUsyV3JwZDRrU3M1VG1XSDZXUUVn?=
 =?utf-8?B?ZDFDZTdLbDgwYXkyRlU5RmhjRHV4U0VFVEkxbjJqazM4WVBqNkhXQ0tqSmpp?=
 =?utf-8?B?VHRrU01uUXZ4M2hiRXhlZWxQTDB0bUZhNnRkRFB2QzFCK2N0WXBlaFFnWFcy?=
 =?utf-8?B?ZG5JKzBKNkVFd1NaN3NkVm5TaFRLQlpFYU94c0NyNm4wZllJYmpCdjRCV1ZQ?=
 =?utf-8?B?UHNCb3VCMWNGQnpta2pOTzFlR1ZBU29UQTM1N0ZHWEZWTTZMc0xtQ3o4SEVl?=
 =?utf-8?B?NkQ3aUdEanpYbzdnTTBjRkxGaWFPeE9jaXBTTWZCdU9mcm5nSkFlUVRKSFVi?=
 =?utf-8?B?RldjTnpHUFk2emNkNzdnMk02ZEFKVldVaHFOQ09nUklrV3U5amNXK1pRR1Mw?=
 =?utf-8?B?Z29kWmtvT3ZpMmhOMG0yblIrTHNNV3p2RFdwc3doTEJ3Q1NxbXdlZlUveGhp?=
 =?utf-8?B?aHpsMWR3b1VCdGIyMEZ2T0ZtTEh3anVMNzNWQWc2NE9wamh5RzFka0U4TEsx?=
 =?utf-8?B?RDJKYzlwRG40ZkU0K3l3ZWdKWGlPWVp3eTZ0Z3JobmNWeW5zM3Fwdmdoak95?=
 =?utf-8?Q?lCVB/a+3lRxTw878D0WUraeDkm5RcBlR8bWNk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1ccd59-bf7b-4185-2ffa-08d8de8361b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:31:53.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EL73A/4f5fh4DuHKBILCV10yb94LlrFltZc5zX7mzyDqNDyCXrs0Q5+yQKCFZ3O1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4418
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_06:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=948 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030145
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Commit 468e2f64d220 ("bpf: introduce BPF_PROG_QUERY command") originally
> introduced this, but there have been several additions since then.
> Unlike BPF_PROG_ATTACH, it appears that the sockmap progs are not able
> to be queried so far.
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
> CC: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Yonghong Song <yhs@fb.com>
