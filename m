Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1A32F54F
	for <lists+bpf@lfdr.de>; Fri,  5 Mar 2021 22:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCEVbz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Mar 2021 16:31:55 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34176 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229672AbhCEVb0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Mar 2021 16:31:26 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 125LOh2Z012811;
        Fri, 5 Mar 2021 13:31:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=789NFpSgEgGld9/c6IuKU1J1HGlS1TDlWi6SHqPJgBo=;
 b=V1byu+xNO0YpYPCw02EYk4iSwQdi4+ojAaI3o8J3VOsNjKYhbfsgOoXygH0bXaH0I5Xg
 AKgk1nlF50HklawdKoehX3k5qhoJym592WYfv7zMgHKYo9tdcSidBqTo/o2Av0rtefzN
 tAijhA+ySEsTP2Y2OiyEDqX3lNcykzfr1kM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 372jxx50mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Mar 2021 13:31:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 5 Mar 2021 13:31:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXKV2x2/DpRwwMuD6c4umNOuG1ZVtd1CGOlGQyjbO6rKVfJMHnyB/DTFgNCXTlh24TACkyKmV8BZygb+WH8dWTU4xMT7ayzxDRwokFyZQRPtmJYPDuMi/JKgMo2M0hmCn0mdlTmAav2ufOiPdKkbD2wW5/FTa98XzEjM9OLICvAFampqub2Q++GXWmzNLzeTUfO9iBzp5PHRYfgT6NrlTLvXFMddJn9iRZO9h5MFkijoIH+F8f1lVOlhzuC925zA4rU4sDN+c1NeOmreSOL/TUcMoxEBoViu1go6TmqMO/eOD9iJnsyXLv/aDqqbfSq1+c0xb+/Ubl43VDM1JmKYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=789NFpSgEgGld9/c6IuKU1J1HGlS1TDlWi6SHqPJgBo=;
 b=NBZQKAfXz4nrpnu7c+Y39I0rrdq5wgYfZbuNSvAtVnUz00pZHBFxACXtxoNMJu4+hrANriFBU/ymDe8SNLzp2YS1g9P0Kgmzm+HSSeJNa2IR8rVfUv9PTnB4jIsybMKTVGmUqtFSe9U5gyyb2DdDT0O3U3bDAjkUO+2DsGzrxaArBwbTVzLqUs4o64xW8pwWey2nMTovMqkQa54khWdoEQQkWGxOhBFMXknFf2mdi1AO51Y0dwIED6WwFZg5Rxk8QyXSeiqneuMqP3JRR74rKgjc3w9qwxKZnEUFGHJpYj5jtFNGm4r6SWOqyLHlNb+XJ3wsYhxSCbqKGjHahM8DaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2031.namprd15.prod.outlook.com (2603:10b6:805:8::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 5 Mar
 2021 21:31:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.034; Fri, 5 Mar 2021
 21:31:12 +0000
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add BTF_KIND_FLOAT to
 btf_dump_test_case_syntax
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20210305170844.151594-1-iii@linux.ibm.com>
 <20210305170844.151594-3-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <13e5c6f4-70a6-3aee-fe74-ec18245e7189@fb.com>
Date:   Fri, 5 Mar 2021 13:31:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210305170844.151594-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:81bc]
X-ClientProxiedBy: MW4PR04CA0082.namprd04.prod.outlook.com
 (2603:10b6:303:6b::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1105] (2620:10d:c090:400::5:81bc) by MW4PR04CA0082.namprd04.prod.outlook.com (2603:10b6:303:6b::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 21:31:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11ea2d22-e2c5-42e0-786a-08d8e01dffc5
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2031:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB203110BB20CC566B794CC288D3969@SN6PR1501MB2031.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:159;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CS5mnKynzLq3NBx0kn9mS1LXfeP5iRbAm4Qw7ymsgy82hXoWbzNjIDk9e0TNU0dlSeKTAdfQ7J9b1XgIBqod2KtNmsFe/XJmliiUTBeJCaByoggBAfqCgYYzvqIjXCk/XGyFVo6fCjeojpHQSQRNgtc9mkzQ159bKGxCOx5guN/z1bH2EIFNtmMeJtMt8pK46FVtfocu9I0IGu8YbjiGu2tRgOiuo6jDsN57hyccAzGl1bwfP+KrZBglhBDtqKyUOUjFg7SmuQ5oamtrU5uvh9jndLweuWw6RMrpcBfpbADsWVqYrxIWEvZ6deRIUB+5hL6wWTZlGhnj9p+eLc7y4ei4/AJUTcmtr5/uQqntVfjAX/0cZWHcIIBE+4Zza6Z1q+C0CyjyHw9LfCILWAR2SDeRp8YX8+RvpXP8KQnATuYTE3owHcyN340DINJV5qmBL5xTu6Uo2me0hmvzpZMhQazrTYdHtCa28F3LMZ2ppzRkz25qKv62dznBZlQFJTZ0RydIXX9TRcW1HcNMMVDsMhQH9sCpNPpSgaPGsBDSDg6NWY7Z1XCHxsrcUxullHRHCJDcErfc+kp/60AKrh+7Yi7+EuMJmKRA2mkay2FNLWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(366004)(136003)(376002)(5660300002)(66556008)(31686004)(110136005)(16526019)(53546011)(558084003)(36756003)(478600001)(86362001)(2906002)(31696002)(66946007)(8936002)(186003)(4326008)(54906003)(2616005)(52116002)(8676002)(316002)(6486002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3VqZkJBN0tMangwRzJIZExUTFNRR2J6c2U5RStzR2FkQlRsWFk1QjduT3BF?=
 =?utf-8?B?Rm9WaTZoNi9iTlBmRXVvWmsxM3VNQjIyemJvelJBT25wSkk5K0RDcjY0ZUF2?=
 =?utf-8?B?WTNSd3VPSWFkRFlYM2IxU3VDSTh6aktCTEk1VnJTbEgvYWxuY2pLUDVOMGV4?=
 =?utf-8?B?L3hUbHpjbEd2VG9CSUJNU2xYT2ZpYnhDUFZnYlB6djJlalM3ekx1OXJXMUpS?=
 =?utf-8?B?M1NzWEV5dGZJL0dxcUlyY2EyZGdScm1abkR6UUFjRUswbnkyTk5UbGRmNGV2?=
 =?utf-8?B?UHI2dlplU2hOT2hhNG44N3NycUhYbU1RWi9UQzhUTkRKdkpwZTczNm14RGQz?=
 =?utf-8?B?RGkxWXEvT1ZMRC83a1Z6UVZWOElGTVF1UjdoemxBZnNLRDRia1ZHU2x1dXRZ?=
 =?utf-8?B?bFgyUXhjZ284ZWhMQWg1MGU0SmFlL28zYU95Yy85MXpsNGZDT0xaY25OS0hJ?=
 =?utf-8?B?RElJOHZKVWNFTFc5dVJydGVQM2lXZFNTM1Q4U2tPYzVTMkpmRWszTzFnTU9E?=
 =?utf-8?B?SEpVYkVZeHhWaWs3UHRJSDhNaEZZNzlLdFo1UEUzcDFJamsyZ1A0NHBrZnU0?=
 =?utf-8?B?bnJSd0RWMFF3UllnQzZQUDQ3WXNtNlhhNlJzMXVPRHlrMVZxTVZ0bURRMmJR?=
 =?utf-8?B?RmNlelhFR3FGMG5NUkVBaVNMRmVQM0hGQW5ibnUzdGlWM2V6c3dXTHo2L2lW?=
 =?utf-8?B?VmZDZUtpTzBEVTlFY0RFQW9yK2VrTlNLb1dTMTM5L29pUXNScHpjNS9ySzM1?=
 =?utf-8?B?WFg1S3pkcVNvOHQ1YTJuSTZvcUxKMXd0RmwzS1lsZVBlb2p4SjB3V2swNlBB?=
 =?utf-8?B?SHpGK1FlMnovZ0RHTlMwa2RUZ0EvZEd2UHRtTXcyRXNSRTh4Y2xZLzZmZ0o5?=
 =?utf-8?B?SHEweGJJNlc0aEVBdjdkUDBwVk95bldYelBvenBHRTZKdnRMYzlmcTM4aGFJ?=
 =?utf-8?B?Zi9Pby9Jc0NURmtGZldkTzlGaVIzZjRYUmZwM29vTUhGNSszSU9qbzJMQk84?=
 =?utf-8?B?Z0picThWeFhsRjBJZ2NkSlVJVmdtT0RzY2k5VGxnTjIxNDBmS3NVaEdDZUQ4?=
 =?utf-8?B?SitxL3dQVEZJVTdrS2JkVy9ML2dDQ0hyK3E2S2kvTGRiRXVhMmFHYjFyeThI?=
 =?utf-8?B?bDJIZDQyOTU3ZzR1QWlMemNJWnFhSnBBK2Z1NGJGYVR6V3JaUTJsWWlEcWFY?=
 =?utf-8?B?cXBpTkZ6MEtUeHU1OElXK0dIRUR4Yld2ZWxydnN2TWdlSnFpTjRFTzNWZVRa?=
 =?utf-8?B?emZMeGVlS01KWDhHZEdmMXhCWHlXektNeUhVcVdXUzZIMGlxeS83RGlmRmFq?=
 =?utf-8?B?cldoRXFiTFAwaDFOOUJBS0JDSGFwN2I5akgveDRKcStMS0hKWUdydjJyeUdU?=
 =?utf-8?B?dlhXNDFiR0h3ZE0rUmhmYWhUWFZHZmVmdktCU0hBL09JdlM3YzF1c0xJaUhX?=
 =?utf-8?B?aVdKYmtKRis0SExtOExJMS9GT1VvU2xPN3p3TjVJM2NyeEFjc2RCbTR3bHJW?=
 =?utf-8?B?dmRYUmxrSVJqQm1VZmlZVG8vakI2cTBudUhWcUZ0d2hsWVU2MDcvQW5pUURU?=
 =?utf-8?B?RWtBZXU3N0txMUc4NC9ZR096am1ISzk0aXhxODIvUUpiNkMxL1JMdEZzOUhN?=
 =?utf-8?B?VXQ4Tk5pWml2NXd3Q1dGbkZqZDlCdGthd3lxYzA4Zi9UOStRck5qV3RwL2Rj?=
 =?utf-8?B?ajVXL3F1Mi9vS1R4VG43UHRHUkZWMk15UEhvNzExbUZ0M0c1WFJ4RjhEUzdL?=
 =?utf-8?B?eUdobVBvcG1mZnJPRkFKZytLdll4OStpc3RFdEhrTjBPUkZtZ1pwOS9RZlA0?=
 =?utf-8?B?Rk9DcE5sQjhkYmN0d0lYQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ea2d22-e2c5-42e0-786a-08d8e01dffc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 21:31:12.3889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILMfCWBxcFNdoMqtomg9XV2lN7ptnykc9Q1Zh+tRle0jYfuW4VwzfSyab+ZHthaV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2031
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_14:2021-03-03,2021-03-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=862
 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 phishscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103050108
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/5/21 9:08 AM, Ilya Leoshkevich wrote:
> Check that dumping various floating-point types produces a valid C
> code.
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Acked-by: Yonghong Song <yhs@fb.com>
