Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95B443CEF
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 07:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhKCGJq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Nov 2021 02:09:46 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61606 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230152AbhKCGJq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Nov 2021 02:09:46 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1A2LZTs5012373;
        Tue, 2 Nov 2021 23:06:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5WZT3zHohg0nmNRkMKoot2qVOFyH9W1vosAXitoGo+0=;
 b=c8qoAR4LLf+z64r80BRsRHqXL8jbtwf35vDibgvXZFWuvhGTEMZqNj154tf67ePwUMmu
 2em+fmMPpfQCR5C/qg7+4JkwjF/DrS/BpOGf7y8Z8evKz2tcrQhJBAWH4wOguzSSTaLA
 F4h9XjU+oVfbRTtFKsDhNXvQyJ3GuFglY/c= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 3c3dcetgh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 23:06:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 23:06:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2SI20ZnMQH1fNzzk2P+qc7JfbCl/RUCZwUX8gzlZ02FUdrnI9IJi9+SQOqS1pl8ikgz2YFTMQQRJ1f++5nFYb1O8oy74r8Ar2hsfYDbXiZs3NgyepCtm+/FxIZO8cGBTE8U/Pa1hsdhpr+f+i+wUbl3CXoMKzE8aeiTc8ffbTsjz/2ppfui7T3YrKo9ico6bsZyXVlK9+rKj9sxUrP2DJJfhC+2dWGYAARADNxqIFffGQ4sGFfgGfZ8yer8M7ig3G+7P4IlcC6Oj5op1Wfy908eT9AlHJG45z5T1kUCxgDcv9Zq4V4GhRMGE4BLD8qSLdYMwuJVpMaSE9URhjYa0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WZT3zHohg0nmNRkMKoot2qVOFyH9W1vosAXitoGo+0=;
 b=mJJQmOgmCo68jfxY7v+I8kj3MIevpwl8EgR/EfiK4WI4MrCo93i8Ve8jtxkwcsR5VALErLm61UGiu2VdNmQ9jBMNAEvnyhgU/lSRrwGK6E/Veu+FVLpSw3bikpBQ+4GTeZPfG/wzmoayXjML0VxoYJxeU8u8BDqj+OwdqVIxCBh/TrsKN3V92d/Y5HL216bAXlUeXow9n3/FUBX8Pkv5t36Lz+y9m0mnBBbLVuaa17uCOrdrYfjPXvJKe8X7IlU92dtkkr3SpoMLDnBZ/VPbRy/womRt6kynwVteB7Fv9Mo4eMyKMckA8mQ48WpAwOPbqdDxKLG/HWYq3gvLUTndQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Wed, 3 Nov
 2021 06:06:55 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 06:06:54 +0000
Message-ID: <ef6b8d50-d08c-f7fd-d358-85cf124954ad@fb.com>
Date:   Tue, 2 Nov 2021 23:06:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH bpf-next 3/5] libbpf: validate that .BTF and .BTF.ext
 sections contain data
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20211103001003.398812-1-andrii@kernel.org>
 <20211103001003.398812-4-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20211103001003.398812-4-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::1066] (2620:10d:c090:400::5:b3c5) by MW4PR03CA0156.namprd03.prod.outlook.com (2603:10b6:303:8d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Wed, 3 Nov 2021 06:06:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d685c883-7da5-4fca-b025-08d99e9022cf
X-MS-TrafficTypeDiagnostic: SA0PR15MB4016:
X-Microsoft-Antispam-PRVS: <SA0PR15MB40162DEB114AF39073810609D38C9@SA0PR15MB4016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1pn3B/ruFpTZqRSNLRIXnbVCibLfI+/2Y7mqiYizy9vCX7TXSa21LrpGuO72nD32QdAAkWnC1rqPaO1aw8iEexRGRunjunapByk2FEJPlScPGJCx7INGIZQkqOHb3GvQIFCmDwzR2YFggi231yZFTgzoVi+L7jhBcJX8UofX3/y2i35b3DTaxpviHQRVu2+wIxv9Z3fm4j8ukmog+KZRGRr5Kpc6/9SVzLea2WLQrCeUY4kYKYm+VLPZjgFi6V0cUTyjawTOLTqZmhcomdpAX0DbUlAYA0bwwzw/d6ycf14Ho+MePGrg+VJfDqRgvNAmdO22CrwwHmn0P7sK9N0QFP1xNbRd8iQ8ag4hzulqIcf3Paz7Yu4HDwav4/6eN4ySqpERBomVTQZxf8oHnmPj1gNZgAXauKQw8ys8NhK8X1Rz5VOwgcsPsoeSaxyZzCPPEk7WrzllOvBJuCFooumE5Dyl1QXRvpiHdUWZb58+weGlBhJxzr3BxK+HUw/ZN5UJYVj3nXdKfgEXHiQi4nA5lkQE5qB8FVYL6VogYfUBCqD/Rf6MLhpW1hlpfkyrNbwak601ZAnkHZaN8dWKAZmrqsVaaalBRifq+PpY6JsrXtTOMy5lvQAJMIutlUZkZ9F+zhTxfU/UjTLksG+wrQx/Kkc3ZI/HVDOdq6wDcqD4g0Hl8sjpHOXMmhHiHbcmA9Vvrh1hfi6jccJ0aaaa9fWURhh0X+F2n2zffRtUGks1IjlKfnAWOvCL1JslaJCPFDOIlBNxt9apccYZWNnZFS3HA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(31696002)(4326008)(86362001)(2906002)(6666004)(186003)(31686004)(5660300002)(66946007)(2616005)(66476007)(66556008)(6486002)(4744005)(36756003)(8936002)(508600001)(53546011)(8676002)(52116002)(38100700002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YktuaVBsamFVS1FTNEVzU0FwT29EK213cWV3Y1E1R1FQS2lkcExEcGpUMWpT?=
 =?utf-8?B?aGhsWGczdUVSNy9UNkdtVUZ6MUtkdHFxRUZVYkdCMW16RjRiVHpyT09ydzU5?=
 =?utf-8?B?YVhSWGZnMndMNjA1TXdlMHJCREdsUFoxOXR2ZEhabzdmWVoza3JkZm45N1FQ?=
 =?utf-8?B?cm4ybi9LcVRYZ0NZRmZORFQ4UkRocG1NRE1FdytZWDhUOTNuazNab281TU5C?=
 =?utf-8?B?aWdCM2QwRWx5dmw2cFlpYXRDNmhiRjJoVmlPVjhUay9RSmRsNVVPN3BVQXFI?=
 =?utf-8?B?NkdFOHVFRlRueVFiLy8yRStzczJmaWlIQ2dzZ0dheU9peXhmM1FuNnNjRlN6?=
 =?utf-8?B?TElXRGNVZFVkUmFWekFoeVAwTGdUZGUvY2pIaXZGS1doSkVIVzFySndCNTFC?=
 =?utf-8?B?dnhXLzVqNEJTcFdmdEdDdXZQRkRDODd4VzRpcEsrU0ZBSGV5Y1hFcXVuSUc3?=
 =?utf-8?B?TGoxaElKZkROSUwzMDFvOGwvbUJISUpQRlJVVi9WSHpkNFVVMXZNd3hWZDAy?=
 =?utf-8?B?MmN2QWdxYmVITnV6d0tFNmtDYzJOYUZXQWQxd0JqQkRROElXcmd0VTFsTGlj?=
 =?utf-8?B?SjMyMVZPNlBRYnlwSjhOeFdvZGVRbXJ3WXJsdGltYWxRdHFKb1QxeHZXUklP?=
 =?utf-8?B?M0FKcWFxZjVwck81R2UxanFMdDB3bGZmQUw1cHZxOEVmK0dXR21HUE5sRURK?=
 =?utf-8?B?dmxTYXArL3phRUVZckYwK2J6TDNFOXYrZmE1MmNHWmoyZWlxaFBHRzRZb0pX?=
 =?utf-8?B?SzFvSVhiZHdleWJ2ei9nSmhXeDNKRXVaa3BsRVdBNlVMNE1MMmI3NlRmaHNq?=
 =?utf-8?B?dE1FQWFxcHE5c2N0eCtBRFZvTmJqcXFudmtzTFdKZThucVZQd0E1V3grZjd0?=
 =?utf-8?B?VGNTOCtQTDVtZjR1THVTckhiQUlZTHhQdTRSMEVRSlVWVlFIbjBPNzk2Y1FF?=
 =?utf-8?B?V2R1SzZPMEk4enZiZGlLQTVEYnV2NTYxMXNvdFhqcUpROWpzdU5nODdIZGN3?=
 =?utf-8?B?bVlROUxXelU2UWRVTFhUWlVycjRTT3czVGdWTUUrTVFkbENXVXY3VEVpd2NU?=
 =?utf-8?B?Q3Aya09DNWxOZ21kTE1FNlV6eU4vV1NnY0ZMcllRRXhnQmlxVnBwRys3b2Vl?=
 =?utf-8?B?NlVYaG80bCt2ekhtVDhJVm45V3JFVEcyWXNWbWdPVktpbzloVUFXNU1vMEJS?=
 =?utf-8?B?ZHQwbXlJY2IxRFppMW9pQU5wekN0cmdWUDVlTVRuaXZBYkhQaExKU2xUY2Z2?=
 =?utf-8?B?Zk5zT1g5b0VuVmlsVlRlTnBHTDZnVDZLaDNCTUtBM011cWJERVhjQWI0OThm?=
 =?utf-8?B?REVOOUd3YTFScjdkazN2RCtRcFVWL3pQam50b1ZLS0t4em5nUXYvdC8vYjNr?=
 =?utf-8?B?NW93VTIrUzB5b1JjS3I4azRYSXpaYkVuZlRaT0Z0d2N4cS9HZUFodzVIQk1T?=
 =?utf-8?B?QktyMDNlSm9YOWxaZGNWUThOeHQ0ZWxvMS9CZHlVRm5SLzh4aXBnVTgvSzNE?=
 =?utf-8?B?eEEybXpmbzQvMHVBSldQSDlXdEZjeG11c3N3ZWYxZHRJNGozSVhhUXRjY014?=
 =?utf-8?B?QS9UczZ5dDR0d2RQS3NleENtVjNRYllDS2l4ckRqd3RpaVhabnMwOHpiR0ti?=
 =?utf-8?B?eXJlT01ta0R5WG11Tm10UXRTdkdLbFkyTkFteFpyZG45U1ZsdGNMZVpIQTdt?=
 =?utf-8?B?TlZJTm55QWZTMHRpTHVKdllIV3BuSEZpVnU3eGdlS1BKL0JDWVVSR1ltYzJU?=
 =?utf-8?B?YnBmTDR1S0xheTJyTU9TNzNDSkZ1Qnkrd3ZLK3c4SkxEWHNPN3Y1azU0MG9k?=
 =?utf-8?B?djlkRms1ZEt6T2pnTWFZelZFZDBBcGQwRWRuRFdxYXltSW9LQ2FNZEtxODZo?=
 =?utf-8?B?dnNEekNaRVVyZi9FbXdMd1FvSU03VWpYclJzMWZVekxucjRMVTJCaCtlNnVh?=
 =?utf-8?B?UlUxTXlGQUhydS9hdWNJVG1BQjlyNTBBRjJCR2NCeXJzVWh6dnRmY212a21Y?=
 =?utf-8?B?d3ViRGhRNklkaG05OEkxaENEb1QxTDh1NVVUS2hnell4eXNtcTE0WFhvZ2Vl?=
 =?utf-8?B?OUIvTXlsVFdYZHBRM043TGMwWHgzdnMyUERTZlluSG52bXN3YU1KdkNPa0Zi?=
 =?utf-8?Q?jMLS8PARCXVrrQwDapxCyfK0s?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d685c883-7da5-4fca-b025-08d99e9022cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2021 06:06:54.7990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ankOxCzNXAIctBC6022Iyj/nmHArMCKjH+mFtHDUa3e+MKaq+yIIHM/0rXmfJ6kz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: k_ARcJuhk5E7BpRpL6XE3ju-rQvAXsaK
X-Proofpoint-ORIG-GUID: k_ARcJuhk5E7BpRpL6XE3ju-rQvAXsaK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-03_01,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 mlxlogscore=920 suspectscore=0 clxscore=1015 adultscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111030037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/2/21 5:10 PM, Andrii Nakryiko wrote:
> .BTF and .BTF.ext ELF sections should have SHT_PROGBITS type and contain
> data. If they are not, ELF is invalid or corrupted, so bail out.
> Otherwise this can lead to data->d_buf being NULL and SIGSEGV later on.
> Reported by oss-fuzz project.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
