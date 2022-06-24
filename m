Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFF655A3DD
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 23:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiFXVqZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 17:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFXVqY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 17:46:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B986AE9
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 14:46:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OHdfvf025247;
        Fri, 24 Jun 2022 21:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EaXK5v4dhH55CXR8L9dbXPbuBFX/TqY3Rgf8pvljBBo=;
 b=N/z1Ns65y8PFphUV0Fz5SuPSBuQtFIukU8DSINjCmy3Lupyi6NvA+3zs2xOKm7mJRSrn
 3o88zpdCjkfalxnpqTvkvsgM4nIPS4GiWI7GpcIoNYZkX6hdXMDdvhHM8losyjkW+oGZ
 d4MviaNwWDxh544ukgz4Gpmsqiyndbfw+D12jmoQOLAQzQQBzCvsjHnbFBhMqRxetuiQ
 8e9gnN9RrxmKKygmcSwP+YT4fNIeEJisG3b7qA7xFxmu21NXg7ZYIKMp7+xJ4AQuNL/O
 ydifl2JAFxIoZVo1NLysF7POWpxJq6w9Y086G8gCXnmivAbTBLyGTD7jHVzYkXDZPAh4 DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78u6u4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 21:46:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25OLajgk034943;
        Fri, 24 Jun 2022 21:46:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3yq4em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 21:46:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFtAJmGswDcP2DvzCOCLAmzEDTwt5Z38GY0N7LPsalFoB4btk7uCj6mZhxgCtJLnRZLWoNWVlmMLpp8aHepI9YCRgpRfaTKyQ6VxhN3I59GWlZMIeiznWIiQk8qgbXA/LYIpXyBNEVThdn3tlc4ws6R5pv8s7eSMQAiVehyi+YfQsCVu/O5qTkHWmutVchk6cvy9nUaMZZEBcoMp7cVd9yCvptCwBcuzgTKFF7Y8ST0V9o6vsv9cZCGiRMr+Ymimg0mql5IxLKzaeui8A9yhPD95q6WHcEgC1TDEzvpq/YA3rQccNw+AXd+BhIZSr/8tt4Z5m8NjuK1CdrqQ+IhW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaXK5v4dhH55CXR8L9dbXPbuBFX/TqY3Rgf8pvljBBo=;
 b=N1/SMbYRDOXbPmdFz54v54LgiJgLmZ9KXdrzEQgJJ8UXbKn4gKRjL99Bi+svN5IcRwUjDkq7uaHEaNpjzTBFRgrLGwqGPZzAqQzXc6nh4KxcIfZJ1YE+sBzEDkUn9E8jICtt/zsUtC1/I2Yz8V60P6XqHHilOKdxofTW2hYI3Ufu9eyJ4AG59yaP7EOM0jlXQR/oFSoSTKHrExUQZ3nM2vyA5MpaSn2+xrXpb1S2iyt6/Zo09y3lyr+vGlOhiSnfDZZ+QNXjy+STeJux8BtKtFgA42WPLGUEYplqsLPF6AkrdOHe1OvQeabbKeuR5QrHSWT91IngAcPPJJxfgj2jjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaXK5v4dhH55CXR8L9dbXPbuBFX/TqY3Rgf8pvljBBo=;
 b=yJqjHewKrhNt7/DtSiuQ+20P1m/fyAwG2fp+tsEZRRSGmwBGKAXjce0SUlZsv1aH3Sg51tuFn/RwkTNzqwGKhNBT90yknJ1/wwFhQ3dnClWX6ZBXIRHwEOYM8Mlyh93cEFeGpgJG2/2V7HFUx+RpOZzIL6Zfb7prbIc4MOn2gTo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BN6PR1001MB2356.namprd10.prod.outlook.com (2603:10b6:405:2f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.20; Fri, 24 Jun
 2022 21:46:03 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::a080:c357:962c:eb5]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::a080:c357:962c:eb5%5]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 21:46:03 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: support building selftests when
 CONFIG_NF_CONNTRACK=m
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <1655982614-13571-1-git-send-email-alan.maguire@oracle.com>
 <CAEf4BzbbME=oZbp26=OMVpMSfrH-6Bp38ELcY6oNYSCAsnobQw@mail.gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <5876210d-1541-2248-6e2a-43bac281a741@oracle.com>
Date:   Fri, 24 Jun 2022 22:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <CAEf4BzbbME=oZbp26=OMVpMSfrH-6Bp38ELcY6oNYSCAsnobQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P189CA0001.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::6) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91955a62-3299-4c85-9c05-08da562aef3c
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2356:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cr3WCgWBHHHtfGZBgpP7tYH02FLT5UZIQRqvDxBcsCFc8vx69yDz5iYZUUwU97K55fw6PofITHQUPLdNiXlJPVi6245kLY5w0rAXuSq5OdqI6i1l1FO7MLxq/5Z/mhCweGZItQtHjsjSIjAGxuyLz2now6HFZcKa4PkWRdmk7XzEih3l0+EVX2SfuvP5MKgas1S+UzedgIP9Dx0Kuuq0X0B38yzc75l8hcbChb7j8U9FhMm8uA9OTt37iCdr9hS2dwnBOW8IQerIdLZ47namf/sxuqlQWBimimQDg9EbWU3y7r8juA84cLNFzAFPtMHm2abapfLcTvteDAFSkSgaOY5B6URBEs340Hwi0ddE1OM0Z7vdGwTKWH9WuhiOm5wn5GK5z8h0NVRw6Z3EfCQUvH4rhmHOElMlqBgg3TK6iYa7ATmUHk/iiEQLA0lFjcPWDUoXz0059vG0rLhE+UlY9Bwkx2H4PbGKRACAhoHX5CWM5bn9Xox/nFIv6yNJKqGyO8anQsV3J6Zd4T5IzhGqN6uYd+efRLKzWDXVIteiA7ip7zzzun3P1jRn5wMEgcgeOQGem0jtnj0SD6R1UgYHBYn5PKjK81qoMf/Uo4yjh0Jcvj27MEKNNXVpn40mmmNQvBpfaNhndYnnbotReSttpiiHDQjDNfPCn4oPYSTRRJbhX+4hv33AGk3dje+XvN6fP9MXMvyJ34mjQqsfGCo7rhJvBWWwnOri5u+TdAAXe7DnmdZ/qmK9ONM+/jdfK1tHfUOSRQ79EbqEz1oDN0a6PEA9hVX0eJCdwTCdlck889toGrU87D7eqGlZiFTgBUHAHRCFDTzDgkxtzP4sJooP8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(136003)(346002)(316002)(44832011)(53546011)(2906002)(7416002)(4326008)(41300700001)(66946007)(66476007)(186003)(6506007)(5660300002)(8936002)(8676002)(66556008)(31686004)(36756003)(478600001)(6486002)(52116002)(6916009)(86362001)(54906003)(2616005)(38100700002)(6512007)(31696002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWl5OUg2RmJvd0Y1VFY0UDhkUFVtOUl1L3hRcVF6SjV4eUZoQjFOaUF4VGhR?=
 =?utf-8?B?SE5tR3hadG5GVWtWbXd2UDNtZlRvbVJHYlpsaVlmU0xyeE92V0o4cGZkbnd0?=
 =?utf-8?B?Zy9ZNGcyOFlGRXVCaVdiWFpvN2tsNXpBZ0xrenlReGhZSm55ZDRVbFRpcncx?=
 =?utf-8?B?WGdSSWgzbkU5ZVRHenUvakxnVVpXQVRqMUdNMEJUMThYa3N0UVQ2UG9GWnhU?=
 =?utf-8?B?S2NmekQ2a0FSZkZ5TFdNOEVZVXpVNE1jU2V3cmFNRDQ1T200TlNBSFIzQ242?=
 =?utf-8?B?eVEzaGFJdGlpZjRzQ0l3WFo2eUhXOUFWakxQYWlCL0hWbm5CQWhpZjdWL1Za?=
 =?utf-8?B?dTNZMHJudHp2S1JEYXBRYnNSRCt2TVlRaDdpeDBjUHZEQjNkZ045ajh5NWY4?=
 =?utf-8?B?WWxuVnl5ODY4SzNvc1dsT3JRU2Rsby9waTQ3SVgxZlJ1M3FJbWUrOUhiU0dv?=
 =?utf-8?B?Sy9lUUVCbXlBRjlXT0xiK3NCYVg2QlFzTnkyMTI4R2ZINGpuMWwzOXNVNm9K?=
 =?utf-8?B?NUlhRkFQRm80cCtwUTRMbUpJLzMyM0JpdUM1NjRTQWljaHZtRlY1U1ppQ2dI?=
 =?utf-8?B?Y2xVaEgvaDFhdzR2TUFnZk0xcFlHTjQwNExiemg3aUJoZVg0RTZiVkF6RDFM?=
 =?utf-8?B?dktLQk1WWUNtWllwU1VhZjJPZ01QRzNCZ3dQWEtSNVZFcmNVeGQ5QU5uUi9x?=
 =?utf-8?B?LzhrTFdkVUZiNzhpMGgxdks0cTF3SXpIaDJHSTJET0tZQkl2L1lXclZxYVJu?=
 =?utf-8?B?dWZQa3c2dzB6b2dxdS9zUk9QaEJIN2lydXU4VkkxVFJhdEFhZnJPejNCTnAz?=
 =?utf-8?B?M1ZQdHc5OHZNeDhFeDZOS3E4Y0tadS9HVEVaVThLRDB3RGJBWGxhd0xRS0Ro?=
 =?utf-8?B?QlJiNVErZ0hBYXVIUEZENDVJL3hlTVFjZUhPN2JlQnBiUUk0OXFPM3FqcEdS?=
 =?utf-8?B?eVBaZ0hWV2dpZW9lYlFiaWdMOEYyUFl2TkZtSFVUcUlKdkdhdS84dWlTempX?=
 =?utf-8?B?Wmt0VXBaT2h6RTI3Ym1tRHVSVTdnNTBLa2hGL2lZSEZIa2VQMS9YMjhZWGh0?=
 =?utf-8?B?VVpVcUJSZitTWmMxb2lXT2NFSmxDdzZ0bVR2RXlnRnN4U1pEbWdlOHA2M2hi?=
 =?utf-8?B?TjVPTFEzRGdjNWVSZ1lqRXhsSzR2RXl5OU1XM2NzM3VZL2hzZTVwWjFSNGZH?=
 =?utf-8?B?dG5CS3hNRCtMTWloVlhYNmc5cjNtUHlsekpmazA1Rm5aOFlkTW11T0t0OG9q?=
 =?utf-8?B?NzZCMW9ENGJLUjE4WDhxYmVTM2JxT0Y3Uk9ST3M5cnBJVWNXTFhrUktZU2hX?=
 =?utf-8?B?NnVKQ2lIc1U3eEJGcVU1bEpkK2c5ejF1L001dlBldG94MmlYTlF3Ykw1RUdC?=
 =?utf-8?B?eTduKzc3WTdYaEpMaTFvNkMyQTNHdXhCSW9oTE9IZTRRQ0RMTlB6UmxJYVlW?=
 =?utf-8?B?L095bVNzUTh1RzdXT3M3dzN1bGJYQmxrKzBkVkxtUUVVUzI0dEx4bjMvWjVF?=
 =?utf-8?B?Y0FYekNvWDNsSkpGanBabWo5WTRvRG4xNFJBNGxkeno3bmp4cVQzd2pUZWto?=
 =?utf-8?B?Ty9RYW5WZCs3alFERnFVU25ZT3VYSnZKN1pDbzVJZ2hwcEpOREE4VEVKRmRh?=
 =?utf-8?B?SCs2K2JKdlhyK2R5dGdsaGJoRXZUcklTM2dhQXpDVmFrNStpVHVPZWRwcWQx?=
 =?utf-8?B?b2VVei9kODNjMlN4ZFRMaU9FQXBjZjdQQk0xcXV3Q0VsZEczVFU4NFFhcHRi?=
 =?utf-8?B?RGM1U2xFaGxDODByekh1UmwxeDZHMGNpUmZyT08wSjJVR0IzNVEwZHVRT1hp?=
 =?utf-8?B?d2htVSthQlNHV3c2cm1QWHdCQWlyd3Z0RzhpWWhGSzZZME9xanNUSmViZ0Fi?=
 =?utf-8?B?OHZqTjQyeEpvUGxDVk1PT2tNVzZGZWIxVjZKM3JoYlRKRFdNTHF6aFhtRi94?=
 =?utf-8?B?M2gyZkZmeDgxRkZOc013cFU0Tmh0eTk0MERuTHNmdFlBY1RwYW5IYk1mcTEz?=
 =?utf-8?B?SEhtZ3phbWJKcEwwbHVEdHlWMTBpQXJZR2NkQkE2SWM1NXNvSEVQck82RjBH?=
 =?utf-8?B?b0F3VnlPQzZaN3AzM2hOSDlselVnM0cwTks5eDN0UmZIR1AxTU1UTDc4SEJ6?=
 =?utf-8?B?QU1vc1RZaUl0akVLRkorMTk0cDg3QkM2WjN1L0wzVlJpK214TUJpdGo4U0tD?=
 =?utf-8?Q?BHpFoYVuIyJfr2GUA+8FcOs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91955a62-3299-4c85-9c05-08da562aef3c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 21:46:03.0719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA+mQoZh/4losW2hTdx5TN3yyudgd7bhNmME1kYOB0NnKE6eXzlJNofPSmruBtFAiU0C+eSxQL6pUYBx5FLUtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2356
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-24_09:2022-06-24,2022-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240083
X-Proofpoint-GUID: yYIyThrqvzgadCgHtDo7S4VFQZyBGK3A
X-Proofpoint-ORIG-GUID: yYIyThrqvzgadCgHtDo7S4VFQZyBGK3A
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 23/06/2022 18:56, Andrii Nakryiko wrote:
> On Thu, Jun 23, 2022 at 4:10 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> when CONFIG_NF_CONNTRACK=m, vmlinux BTF does not contain
>> BPF_F_CURRENT_NETNS or bpf_ct_opts; they are both found in nf_conntrack
>> BTF; for example:
>>
>> bpftool btf dump file /sys/kernel/btf/nf_conntrack|grep ct_opts
>> [114754] STRUCT 'bpf_ct_opts' size=12 vlen=5
>>
>> This causes compilation errors as follows:
>>
>>   CLNG-BPF [test_maps] xdp_synproxy_kern.o
>> progs/xdp_synproxy_kern.c:83:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
>>                                          struct bpf_ct_opts *opts,
>>                                                 ^
>> progs/xdp_synproxy_kern.c:89:14: error: declaration of 'struct bpf_ct_opts' will not be visible outside of this function [-Werror,-Wvisibility]
>>                                          struct bpf_ct_opts *opts,
>>                                                 ^
>> progs/xdp_synproxy_kern.c:397:15: error: use of undeclared identifier 'BPF_F_CURRENT_NETNS'; did you mean 'BPF_F_CURRENT_CPU'?
>>                 .netns_id = BPF_F_CURRENT_NETNS,
>>                             ^~~~~~~~~~~~~~~~~~~
>>                             BPF_F_CURRENT_CPU
>> tools/testing/selftests/bpf/tools/include/vmlinux.h:43115:2: note: 'BPF_F_CURRENT_CPU' declared here
>>         BPF_F_CURRENT_CPU = 4294967295,
>>
>> While tools/testing/selftests/bpf/config does specify
>> CONFIG_NF_CONNTRACK=y, it would be good to use this case to show
>> how we can generate a module header file via split BTF.
>>
>> In the selftests Makefile, we define NF_CONNTRACK BTF via VMLINUX_BTF
>> (thus gaining the path determination logic it uses).  If the nf_conntrack
>> BTF file exists (which means it is built as a module), we run
>> "bpftool btf dump" to generate module BTF, and if not we simply copy
>> vmlinux.h to nf_conntrack.h; this allows us to avoid having to pass
>> a #define or deal with CONFIG variables in the program.
>>
>> With these changes the test builds and passes:
>>
>> Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
> 
> Why not just define expected types locally (doesn't have to be a full
> definition)? Adding extra rule and generating header for each
> potential module seems like a huge overkill.
>

True. I also forgot that if we use vmlinux in the kernel tree as the
source for vmlinux BTF, this approach won't work since it assumes it
will find nf_conntrack in the same directory. I'll figure out a simpler 
approach. Thanks for taking a look!

Alan
