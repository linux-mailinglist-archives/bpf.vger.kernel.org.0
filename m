Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23DA320FD2
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 04:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhBVDnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Feb 2021 22:43:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39986 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229983AbhBVDnK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Feb 2021 22:43:10 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M3fNqk026984;
        Sun, 21 Feb 2021 19:42:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=XpGIU91eqtd7PWaEUZNP5tZMAXbzAxm4sauiRJVtibo=;
 b=EYM1ee3q6tAMEb9kHar8sNA4p1kZl2L/18OdKwyKUPZmIuYDV6q5+JzAjtaM8DJhNPy0
 hs+zQ4q02suAyqKLSVW8OwoWCyAk5qgQoSv6ys0slzwsc0Q3C7OkBchhHR9J+IEt7FJ8
 kWwF4/rq7LY+EXL315Jc3zc3jLmUojnMatk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36ujy7awhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Feb 2021 19:42:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Feb 2021 19:42:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKdMiWffdwCKMTe/gZpCBRrgOHKxBwfMXpp4NSd3io5Mkju+dvlJT0lAw3aCM0knDWl8MITBhjQyYbduIqN/2uwkNxPXQN3zYoV8Bc4wAoJ4oasAPkqPb4XdnFxtbS+Y11ccO+V/lghMcYDHQzkpiFLpYNFe9ZTqmpPIg3pPBGtIkWrHJubVXrKP7dULbHEzxiNsPWxv12kPm1pJ7d+7XatAbLvT4BFHPmB0NyOw8sTJWKPtWRBijR0ZYFjVtBscUEDM5YberWJEMKIMjZ7RmOdAiGoeGx0CzIfFbohPfe4uQPw+hZGktyTm8FNzcByX/NYSBFCxYkL6yFt9w7OWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpGIU91eqtd7PWaEUZNP5tZMAXbzAxm4sauiRJVtibo=;
 b=DBbtmkvKJs5j8/c+6St2yt2Be7GXEVB1OFA4HG8xzhFksUEAU1C2coIboYWAgdnMuxdpC2KNRyNqpYs441yo3uutnybnlsCNkPHYudsNXAqNIZL14kF3BLU60msmfYyFQCtrnNocRUh76UnnI5UBD9Q7oogkTui+7b0W5V/aSht2cZcx+pUL5HvAd/QJWEskwrBz0bCLIX+lLOASSP179RVG4HLIJO9DPCG1PmqFyj0LKOCQqsne7QLSXRyxb5/bu075j9sj60Yfo3sVmjflXC5ApRe++zT3+6UVN4QIyI4Mjg118txtTPdY8D8lo8bSWKJ4inxnDiglj6cLWefD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB4070.namprd15.prod.outlook.com (2603:10b6:5:2b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 03:42:13 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3%3]) with mapi id 15.20.3846.042; Mon, 22 Feb 2021
 03:42:13 +0000
Subject: Re: [PATCH v3 bpf-next 1/6] bpf: Add BTF_KIND_FLOAT to uapi
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210220034959.27006-1-iii@linux.ibm.com>
 <20210220034959.27006-2-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <73a0d08c-ec53-c650-7fda-367969d86249@fb.com>
Date:   Sun, 21 Feb 2021 19:42:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220034959.27006-2-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4afa]
X-ClientProxiedBy: MWHPR20CA0002.namprd20.prod.outlook.com
 (2603:10b6:300:13d::12) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:4afa) by MWHPR20CA0002.namprd20.prod.outlook.com (2603:10b6:300:13d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 03:42:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 632bff39-3aee-4ddf-f10b-08d8d6e3d779
X-MS-TrafficTypeDiagnostic: DM6PR15MB4070:
X-Microsoft-Antispam-PRVS: <DM6PR15MB4070FC2BF75B102ED8CF443CD3819@DM6PR15MB4070.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cIGBnb1ghxyci8DVHR4QNqzKq5Zcvd8dstYJ1yTdUOtO/Fp2/JT6xws7lVM884jfS9WZuJ77T3dpafWym02dnKcS8lslSqwHBWMg7KBGEkzbqbh9DRWr/SJuEeUBPT/sqfK39Q2KH5VsCTQ8L9W+yCtJkendz1/hZUB6d9mdc1ZmDILzd6Aynw2cAU2cVAPEaBqB9I6AIlcIUk2wPLyn/Z+ymFz82NH3Fo+/sardWtAoxpMDw5yrge+Cy2sC34NbRvW0KnepmOs943bsC7c2pAlqXUX8QG5rYoD3OoxF1+AyDb3frn/5HcLcmGGfigwJWfAvVHJO0b+yGIUzaqiTDSioIE0oKAyswlpacuxYodyhY6wSniILkrtAJYehzWGh2ZMZ33hQ/36ORjO8UFu0GFEs3NXzAgywFt8OrW+qemQnPuvxkm/E68cY17OiIAHTJruEdBiKY+NTNVFLsT+QNVzVy6riSs71moWioIllkd9UJBIzlqq6/7vSoR0G2DbV1YwMHjN7rkhB/F65HLu4TLsKscD/EXwUKFFlImeLO+tlNhbJ01luNUVyVU4XDwXUcpwYnuRPQ4zuz92DFwHNH3gSpxljAVKUTvBcV1JOI0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(136003)(376002)(86362001)(6486002)(5660300002)(110136005)(186003)(4326008)(558084003)(316002)(2906002)(478600001)(54906003)(31686004)(66946007)(53546011)(2616005)(8676002)(66476007)(16526019)(66556008)(8936002)(6666004)(31696002)(36756003)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MGZ6dkEvSTM0cDdIQ0JLc01ROTM2dXp6Wms5UWhNVDFzaHdTSExqSUJ2ckNl?=
 =?utf-8?B?RytFKzUvd1hqUGhTM2VFLzhMMUdwNEt6aTFZV3FIaFJtWjRxU3l0V2lPeGQr?=
 =?utf-8?B?TENzNVRYWDc0SVh0WFJUTHZEaVJJZ3FGbXNYTG85eFRyc2pJSkxiSERqSmZK?=
 =?utf-8?B?MHNxYUxSQWhpWjl4TWdiRWdsTDVmb0JLSlR6Uk5DSW5IUDVqTlFlbVk0cTJS?=
 =?utf-8?B?WXllTUVPUC81Q2JXdGNCMWpTS2E5NU1keVV1RFNoeWJWSWk1Zm11QXNzSEVa?=
 =?utf-8?B?ZG45amo2NW9zb0d4Q3UrUlg3SVVuR2YxVkplM3Q4cHZqYTI4a2JuM2tUclp4?=
 =?utf-8?B?L1cvUWd5R3c3NDZPMXNGbGNEc1R1RjhkbkpQbGtvUVI4OHA3eGpkOVpJM2kx?=
 =?utf-8?B?U0hZQWJsL21zTXYzZHdqQlhldHN2anJUelo1NHVQdW9DQXRKRGx0NDdGc2Fh?=
 =?utf-8?B?LzdtTkFDQVd0eHFHQkdrdDZ3SUUrUUxvNEovZXBEalAyRkcrTkE0T2RtTVdu?=
 =?utf-8?B?ZnFXb1hnOVV2OHg4TjV3aXRTQjkrY2R6Nit4ZFdScFhUcGdUOXZkSFBUUVZ5?=
 =?utf-8?B?aysxQ0hDblV2K0x5MVl5WElKc2VXcWpkTGlpNTFvc0V6b1ZWbFdodWowM1lY?=
 =?utf-8?B?aDZMT0VCcXBKVWJ0OG5wdDRhajZvdDdBMUluS1BabzduLzF6dWpFYjZTNStp?=
 =?utf-8?B?aFJOQjV5TS92QlF4Z2d6Rm5FRWFBVFQyRnlRcFFFaDVSR0I2dWhkaCtxdzdG?=
 =?utf-8?B?KzhyWVRyUTRsWHV3eTJHbm1LWXJ2ZWgvZzlVcW56RWNtWWFNL2NTdGw2dEZr?=
 =?utf-8?B?NzM5Z1ZHSXNEeVNwa1VybDdyZzZrc0dSSDFIMkRrR3piQjBKc2lRekF3c3ZN?=
 =?utf-8?B?R1ZlSDhleW90WUIzcmVVUlpaRTZ4alRBKytReFIyWGpXakpkNFZTL2c4YVZT?=
 =?utf-8?B?QW9kVmdOT0E4OVB3OWhNbWhQKzdsbHVwUllSdG1uenJjTW4vYW1uWFlZQkwx?=
 =?utf-8?B?a3Exc0NiS05wTW9ac1hzTDJRQVBiYUtxOFRDVDNHM001djBpNmczMmxHa1JT?=
 =?utf-8?B?TTEvUUdVaDhUbmZvNVRNVlJXQkRTaGg3R2tGTHZiSjJTWHg0VWYxc1JZMWRx?=
 =?utf-8?B?dDZMSllhcXI2TGx1R0xZek5nYW1iMExUOTVXTHFGZVBvNElwM0tPT3E3WWJO?=
 =?utf-8?B?U2JkdE1kQXpPZHoxeWpvektJVjZGRGdGTVdlZ2tSaHEyR1lZUDg0VGp3Z1oy?=
 =?utf-8?B?K05rTi9kT2syT3pybGVjYkFPeENNU05maXZVWXloU3pVMlBCb09MeGNlQUw2?=
 =?utf-8?B?emNrZlpTSlV0dDlJcnRlYWVtSVF3OWhCcnR1ZDd4N0daMDl4dHlqYWNyRHdq?=
 =?utf-8?B?dXdzRld4RDFMRWh0ODlXVDZhTVAyTXQweFdaQlZxVGliaTVLNEZPNUpLOEJI?=
 =?utf-8?B?QnI4b2owVVM5aC9QQmlYejRDejl0cTYxNW5OajVseEdjaHQzS0xPRGxvd1g3?=
 =?utf-8?B?SWZmUCtHZTYvK3JVMW1qUHVybElqcTJTcDl0aDM2WlFjSUp0SGNNRkxHNS9U?=
 =?utf-8?B?NGtJUWJaallYdGtxMjJXVzBTbk9Xem5ZSTZ3cEpNZm5zbGZZOVgveGs0MmtC?=
 =?utf-8?B?dFZNZ1BKTFlKTDhKcFRmSTB6K3oyelAwSkxaTUZmcEtIbXdjNzFkUzJGdkRX?=
 =?utf-8?B?OXR3QkMvZkdlMDBoSWppWlFNZEFWMmV1bG80dHlwUDRDNGZCSVRpalExNmd6?=
 =?utf-8?B?ZzkvM0xJWFE3em5RY1UrNHdCZEEyWVRNampzVnZ5WWQ0c3o4R2VEUlV0RXVX?=
 =?utf-8?B?Zjl3QkZ4bURYV3V2K1VFQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 632bff39-3aee-4ddf-f10b-08d8d6e3d779
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 03:42:13.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+nFWAzfKo0qFTKGUOrK6PTtmKROVl4eFFLfSWvt2FdV/NjNZBrN4RNsvoQz2+MK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4070
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_14:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220030
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/21 7:49 PM, Ilya Leoshkevich wrote:
> Add a new kind value and expand the kind bitfield.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
