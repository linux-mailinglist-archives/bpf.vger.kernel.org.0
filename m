Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19935326A6B
	for <lists+bpf@lfdr.de>; Sat, 27 Feb 2021 00:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZXeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Feb 2021 18:34:25 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53888 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229622AbhBZXeX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Feb 2021 18:34:23 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11QNWsFW023804;
        Fri, 26 Feb 2021 15:33:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HNk2Dniq/yC0ZeLdRtgoFBnQCrX6f05SoK5mfAKxFFo=;
 b=a/FAYJxLfZo7w94jTlDQS++ICf8oDAX6ZRLwS67tHTOJELKdDQtLMHuaZR8CVkErcFDE
 sxp2B4EjA5bzt0hUde3snwLcqZSk19O3MBRjTDeSxSPO2mydcN65+ElCFWlCgFUJbAvR
 MyaMoDhtqm2pW+FKehQYhCgd42AsUzaZIkE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 36y8md8njc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Feb 2021 15:33:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 26 Feb 2021 15:33:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSPdckQFZDS2T1Z7JAiCJEbFKxcIhKQmminEVimrG6sTShCyUrrr+zNmseCPaAasOxi1ZnKgpHGDjdvjWn5VOpJi5kxTpl7Io08ZAAIWcBmzKKdWpMFG0F1BnEPFfS+sWPXKb5b7arTEBAv2ls+Ivc1K9+MrBUH5DwRuWCf2KFGYWWAXHLFPW5HlU32AiiBWJUrRrfoUJTL3hI3pRjWQtwoYr5K+Yic+1PYGoNKxSvQ3mx1ThaZmKodZsxRmNqy9+ZaApTArt8d21HMA0ncss1HQ7JZfFAuX/Gh62sslW0D9A1NRL1HFjjjbepaS0P/DRR/EwJqCAb6Qy2BCf+daBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNk2Dniq/yC0ZeLdRtgoFBnQCrX6f05SoK5mfAKxFFo=;
 b=nIAHVZiZeGFr9ntj+I1vcECYTFc+C66s84295lf6OduziIqpVNs3xh4t5jOg3IViv7/je5ESJZkJWu+apWOsPh8MqAm4iXjwnVieFMCBW+GyhS2KTx3bpSTQIPGe3xvlbPV7tc3obev7RpC6bkMOsmLc5iVLyHNDxfnqDrteFXgyrCSBstrGcQR1El05Qyfw3zNhQ9Ghqh3xZjZqY6NhPAaT8ougOwM8JiHyOT2YJcpWdzDJN9TFRD0nCIreW7pw57CfA1DCKVQiwfeMytUd1/pLdTwHGR41S5eCIlFp3/foplvZiFnz0NjfwMRNREvxrML28RHixnJLH2RB0UOI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4205.namprd15.prod.outlook.com (2603:10b6:806:100::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 26 Feb
 2021 23:33:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 23:33:23 +0000
Subject: Re: [PATCH v7 bpf-next 06/10] bpf: Add BTF_KIND_FLOAT support
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210226202256.116518-1-iii@linux.ibm.com>
 <20210226202256.116518-7-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <7876ed9d-a543-c856-6a1c-5ae9591fcde3@fb.com>
Date:   Fri, 26 Feb 2021 15:33:20 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210226202256.116518-7-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e536]
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::193f] (2620:10d:c090:400::5:e536) by MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 23:33:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f75da5-83bd-48d8-0548-08d8daaee86e
X-MS-TrafficTypeDiagnostic: SN7PR15MB4205:
X-Microsoft-Antispam-PRVS: <SN7PR15MB42055A90EADA9AE31A31F7BCD39D9@SN7PR15MB4205.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ejm2jJtGeudNJCKE7kzOWFwXlgFczzBvgRPB0luq+5o7hma5CPwPlpgvAwhmmlRhkDzQ35vFlJCIMIFw/ybT7D2iPCMG8KW2C3D9LjZZ1L9z5jHmCfV9j3r6s6bk3q0f543qhvMgBNODMSalMSgSzsklB7iOkuEmSc0dzbt4sRBYgudSx8t79VAB3hSJGijYmyvP9bCLfoqLdM55IxkLQoK3EuAde1zlBcBxwWJckxVGTphcfeVm2nJ1NvygSrOOUWZ9fgnFm5uoGJpFZT36328lXC8gPxzKgDdEdW8tl/ZwXwhiiAAhfTJh5p7AmMIM6orHEp6AnW10QevfMXtNtngxEQVBU6y73KrUuqB4oK4gOLHyeiKTdFK/2pRCoI+nvWOzzNLa28i8DqXck6mcEY7tTt6cUNPp68rBBWLuP9xhcHDBhsub0dzl69rh+DIph5fiHYatFbrESIW+Csp9C3ifZ1F2x3COqctj7zE7ddJ4oRwWnvH2wPfzT2nuW1sBokL6ebmVR407IgYl9cgRBJBh3P5b0u2pt1YDjNC7xAdtk+hWfBqEbWjKyJ0QdLjGB4T0HG0S9ww4D6uoNYsBBu6fzyENlhyycHpeTvAn0BQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(396003)(39860400002)(6486002)(66556008)(86362001)(31696002)(8676002)(66946007)(186003)(16526019)(4326008)(66476007)(53546011)(52116002)(478600001)(36756003)(54906003)(5660300002)(316002)(2906002)(4744005)(8936002)(31686004)(110136005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eTAzQ3hwMjBhSENLRjhFZDNHU2NtQ09PR1AvTElHS3hmL1YrYnZFYktMeTdw?=
 =?utf-8?B?Wll1Y2RnZS9WNFh6UU1LVlVERWI4a2JlZERXK1NGUHJhT2ZuVks0M3FtVkdR?=
 =?utf-8?B?cW5RUjIvZUwySGdTQXRaWDFmbWFzUmpwK00vaVhBU0xFQTVJU3NGTUJjKzd1?=
 =?utf-8?B?dlhGTzNVdStCV1NXcUZDeWJ6MUVpQmFwVFlKU2JTY213b2IyMHBvaWsrRlpP?=
 =?utf-8?B?cjZzeVlPbzNYY0MvWnJoSDNVN2dqK1ltYTIwTXpHVU9UTnRlcCtsaUNiTzdy?=
 =?utf-8?B?ZzJLRlRaNklpV0xUa29ma1ZER0xGV2k5Wll6ZWhyc0d1WHZBMG9MSG03WW5W?=
 =?utf-8?B?U2hsOCt0d2lUWmwvNHNBdnZBOVByc1JPb1kzSGt1Qng2bEZidEdwYzJ0VXlT?=
 =?utf-8?B?MVhCL2h2dlFBRTFBS1Mxdnl1WlZwOHN3eWVuZGVPaUV5Z3dFdVBJRkhiQWNT?=
 =?utf-8?B?UGkxRVBIczBJMWMvbzJKckgveTExaTVJSWo1UWFGbGJnSTFlZDZJNy9QQjhR?=
 =?utf-8?B?ZmIvK3FMRmtYdS9xS1NlR1Z4Z2lpaC84SUpJWm5rR1h2aVJVaWdWTmZBRTBB?=
 =?utf-8?B?ZXJZWDA4SnJXZzRSbmNZWWFiVWlEczdFaGpyejVCYXdXanBkOXFNcHd3bE1S?=
 =?utf-8?B?aUozcUZ5SjRSeVNQQTZydWFxVGgyd1BoeDFtY2VPTDBqaTdEckZDYWd0YW5S?=
 =?utf-8?B?b2ZNanNzRHBVVEVUQ0JKUzZ6Vnl5U0NZVGxvcGwwdnduN20zQ2FSUDRnbmRD?=
 =?utf-8?B?SjRERmlYZDdoQWxiaUxwQitYRngweEl5am5DRzRHNnFJbCs2Nis1T2ZiUWJz?=
 =?utf-8?B?YVY0K0NvYlQwMFhYamdyaTNFVkNWUDdVQXdNQlpQaVhtanRZMVdUYkJBVmsz?=
 =?utf-8?B?d2JNMTNTejc0YXdPZk1TM3M1TGVvbHc1V0FyYnlSZWtXYVBOVU9KcjZpSTls?=
 =?utf-8?B?SEZuVE1vdWhSOHFGYnp0MmIwMzJEYTlEZ1dQRDJ2K2tyM0lXUzJNZTh4Znp0?=
 =?utf-8?B?ek5Zbml5a21QcTFWMHZOUGRtRytrTXhuaHhhakZNenpGWlBzTXFwTEVtMG5u?=
 =?utf-8?B?K2VkN1JvVUlyT0prRjQyTTRjSndwSTBxYXVoVWd1QTlDMU5LdUdJbjVxUTlC?=
 =?utf-8?B?KzQrZmxFTWhUdXpHY1NzR2ZOSHhUTDYxMTVWblYydmZ1K3JVNVdoeDlVaGxy?=
 =?utf-8?B?bXFjamRjZ2tQMEpVK1YrZVl3TzJiaDd4R0p5OGtpdjFwb0N5Qm1pbnNiVzRr?=
 =?utf-8?B?SkFla2JHTzVQWmtCbG9ZbGFSMDlHTU51akJCeDd1Vi9jYXUvSGh3YmMwUW1v?=
 =?utf-8?B?SlozNVJHcm40MHVMRU00WW1GTWFTVnI5TnpoREJOUjhhc0xyeFVNS3FNeFZN?=
 =?utf-8?B?SWlaeHNIYXhQL3dYRm1UckMySDhnVE82d0ZiMjNkVGZiK2orQTFaaS9vdGFM?=
 =?utf-8?B?UWZqOG5XbDNES21VVExGcFp0UWQ2THkyQURDSEVxbEpOY2xGZ3hWOTh2amVN?=
 =?utf-8?B?RlZqU3FtK0h6N2Y0ZlUzUVFNSHBqRFBmQTRtODhCMEljZGtJajIxVmJpVWIv?=
 =?utf-8?B?dTcrZ2ErMTAzc21xYkY3SUhTLzVIbnR1bm1pdGNGeHBOZWViZGcxR29TVTk4?=
 =?utf-8?B?UW90bS9qc21QeVlRTlF1dlVuSE9DUEl2a3BJQmFzbWlqWnJjV3hkOVpTcy9O?=
 =?utf-8?B?aEdReGYzT0RTNnl5OFhVdENsY0htWUY2ODQyOHdxNjU1Vmxha1YrS0ZjN2ZV?=
 =?utf-8?B?eFVmTDVyZGpDQzVGZkJsamkrQUVoYXp3b1FsZkdkdExUWU90VU9lVmd3S2w3?=
 =?utf-8?Q?dcKs72z0K0bbVWBMZPO/lG3giMd7W0Rhq+rjg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f75da5-83bd-48d8-0548-08d8daaee86e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 23:33:23.3283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uYKkGUjRKSiUTSQ/qeHpeDVRbveQvS8urgdXN06GDHUTkSzpit1w4wTJuRVTeS5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4205
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-26_12:2021-02-26,2021-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102260176
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/26/21 12:22 PM, Ilya Leoshkevich wrote:
> On the kernel side, introduce a new btf_kind_operations. It is
> similar to that of BTF_KIND_INT, however, it does not need to
> handle encodings and bit offsets. Do not implement printing, since
> the kernel does not know how to format floating-point values.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
