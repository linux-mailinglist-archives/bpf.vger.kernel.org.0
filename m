Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0BF3325BF5
	for <lists+bpf@lfdr.de>; Fri, 26 Feb 2021 04:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhBZD3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 22:29:01 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:31304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229460AbhBZD3A (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 25 Feb 2021 22:29:00 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11Q3PMd9021231;
        Thu, 25 Feb 2021 19:28:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=grZxepjaEa65Pc7OFwFCOVGZRPkV1hH9mvnyHB/bECA=;
 b=apUXdd+usOibgCxxERr6hHwlTH/iFVm8n6u7APzHrBBSkG6CyYW65mhY1qhlBsBEkdEE
 ZjGhRSxiND2XUEnGtYv4KuQa724+YTptPNmYqwcYsovLoP508Yt87AIG2+iSES/mHJcA
 pRolTjRHlXhqbKb59+PZMTOYsDAX+km/BS0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36xkfm1p4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 25 Feb 2021 19:28:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 19:28:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ly9Gogk3m9IcTdQW92KZGomnq5kPaeMFXSORXDKjLHlRKY81BNCZg6vQLOhn6DGOeKhcwvzGWlu9RJpjx8cUdxYlibeJZb1EWTfry4HgOfy86EZZ+ChTSA3KyQE8PlbuLPH7LiMN+sW/KABHZfHMvlsMYezG3U1PyQaHEbNEYwnfZuej4henVESfZOR1lSoneI+DJtZ6dzijz+2awiuQF3bRGxUpFa+9NK9U3gYHs5JKY4zovFffAYbWqDeQkd0zk4ekrWkZIGf2eQN4J+yBUAXfHAcb9T1fs3H+vd1SO7R5CBE6UDoG7mQ5MwiWrHrzcuIISOjcUd0bRTaL72pMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grZxepjaEa65Pc7OFwFCOVGZRPkV1hH9mvnyHB/bECA=;
 b=nGCWkP9GyPN2A9UJngaS0fwR9NAq4cQhh9MT0iWnMx5jfHPIwnlFF+OCMjEYeVxQnkVfxgQTmZOjqQBmZo8xha/g+xxLsndqB9rOae3DXbjanqGEHy+ddGI17ytDbLrobVmCQv0uwSQdBkD4XWKCSUETyiIGE/nVLfp47bqtE4D1f6LDsgJPmGDiSoap/noPrWohXFLl2jhdNBevIlDfIHj2Msf4u5kczQt+tf3TrftvT0slxOLxT2j9ws3a3w+43FHNhKT6+43bKsD1ZnjUdqvGyGk5+2xNgkKluMk3neFsIISGNaDtbDQaXvPmxRDoLTLz4M6HYmXC0ii1Jge+Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Fri, 26 Feb
 2021 03:28:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 03:28:03 +0000
Subject: Re: [PATCH bpf-next v3 04/11] bpf: add bpf_for_each_map_elem() helper
To:     Cong Wang <xiyou.wangcong@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        kernel-team <kernel-team@fb.com>
References: <20210225073309.4119708-1-yhs@fb.com>
 <20210225073313.4120653-1-yhs@fb.com>
 <CAM_iQpUjQ1sD1pyk2GnCuoyMYBhDFcF0KY0Qg9uMtH8DRGGEMg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <0aa2660f-8d58-2a88-73f9-93b28e2a7a3f@fb.com>
Date:   Thu, 25 Feb 2021 19:27:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAM_iQpUjQ1sD1pyk2GnCuoyMYBhDFcF0KY0Qg9uMtH8DRGGEMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:480::1:1f06]
X-ClientProxiedBy: YT1PR01CA0082.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::21) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11d1::15dd] (2620:10d:c091:480::1:1f06) by YT1PR01CA0082.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32 via Frontend Transport; Fri, 26 Feb 2021 03:28:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 536b80dd-6a24-47dd-ca26-08d8da06863c
X-MS-TrafficTypeDiagnostic: SA1PR15MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB46449E2C6156EBC04016C879D39D9@SA1PR15MB4644.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKmmkBlk5E9P0K2p7oseirwDpFcT3zkkJJc+uDCGkhT6Y3FoDccuVvsik+tUKMlJvi8rOASeUcmNdAVl9Vv2V/lAYlyNXYwQOFt3tMmKs7osxrEMRMRZflA55HlX9Y/ilMmZnH3CXhm8YMug1vGqqqWOdm5gIDgDJ0NdnjrdCDtm9BI0TJTpjxVQWLPHtC6R5LVcvcU6QzpPhDTxUEU5Ou5SxVVHT6+HaF0kIyF+AdNr+UmOtzCEhtghrs5QQ7LhHUCOqb5s+PUUVkafzAq4emvGTfbZUgFOvI25GdXf/33gkjjASp1hqO5b0owKsr0jF8KIIJdDSGa4nv4Lu6xKffD/C3I3szsWLILBlHsCvqXxXBMqqO1z/nio2PtxQnKQN/0hYZhTlFDjMyI2/5QnKvyLhppFznRtXg/gdgonvrP2aXM57OFy39sHYTOh4bk/o+Ci5UVypWXmLwluP41DjDPw/GfzMK7mp347mC1LjQwFyur9wRnlKmaGFYEkyEfZRTxIfsGbUJJekS36WaeQeuMA4xJwOGB2ng0iwKnEflTRbAIWafN8EbvEbKW4v87gNz8fEoy0GUQSLwitwbEh5N19Z7lS4u/fF3OryznuLtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(4326008)(52116002)(478600001)(8676002)(8936002)(53546011)(31686004)(5660300002)(6666004)(31696002)(66946007)(186003)(66476007)(86362001)(66556008)(16526019)(2616005)(36756003)(316002)(54906003)(2906002)(6486002)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2ExMEhMRmRwdG1SV2cwWmpqL1YrQnFmUG1WcW5ENG9XMzhqRVRJNTlZVGNi?=
 =?utf-8?B?RVVrU0dJd1FqN001UFgyNVBRMDFDWmw5UUFsTlduTkJzVWFQY1RKNFgvWGVx?=
 =?utf-8?B?SlVPZmtabEJSVlNZdkQxMjQvTHBWUjYwbkFEMkE2OVZmbjJFSzkxVkpsT0hV?=
 =?utf-8?B?b09XbHhyVE5qWnVQc0g3eWpUa2RUd0xjeWFXbHUySzc4aG9GVndHMmlMRkx1?=
 =?utf-8?B?OGd0QzJMNjRleGoxb05UdmZ0VUJpbUlhZVhldVBQR2lXeStyamRTcUQ4VmF6?=
 =?utf-8?B?WUV0NllUZFJjZHJKWWJ3c09hNjdHQjVmU2s5VzQreWw4TURob3dYd2hud21E?=
 =?utf-8?B?QndTNmVoYXcxZDJUK2w5WWtYL0tzSzh0d1BVRmliVnM0S3F2ZE5aWjczTjRD?=
 =?utf-8?B?WUxEaTNXY0p3YlNFWGZJaU15YjhFWk03REpUbWpWZjdVTzZoS3FucG1Fam5j?=
 =?utf-8?B?Z2p5ckVFcXpaUWZXNCs1WUtWN0xtY1ZYVUdaU3d1bXJWZmZlQlVid0Jqcmla?=
 =?utf-8?B?QzNtYmR1N1piMVdUcEN2cTN1SVdSZzcxTnM3TlBYNWhWdlZQa1ZkUUdyaWt4?=
 =?utf-8?B?Y1FDRy9vc3I4SlpjcS9qSHphVDZuV21udmdDQ2dpeHVFWmx4ZFg3OEpNMUta?=
 =?utf-8?B?bk5ibDdQeUxCSEdRem5wSzAreEFBQzVUM0QzcVFXdllnaktmL3JsUjlEZDNN?=
 =?utf-8?B?RU5FdVNGSUlKZThQWTBaV3M5ak1LZUFiRnpaclFmdmticWZPODZ5QnFrZGhE?=
 =?utf-8?B?U2Q2bmg3bW04cyt4QWtuV0VXcmJqakFsdm1abjhJWXc1WEovQk5UZlFOR0lo?=
 =?utf-8?B?VnpZejA2MzhpUHpibUFRNHRaYU1zRytLbkdTOFVVSm1xeFFUVkh0bnBONmxY?=
 =?utf-8?B?a2ZyTmdqaGR4ZExxK3MwaVNNVjAvSDZwak9xcm1yY205SVlmOGVtNWl1N0V1?=
 =?utf-8?B?Q3BNTlZyZGRrZ3FsUVg5anM4dDJxKzB6UWlhYTcyd3RyYVpnTndhOE1lU2lY?=
 =?utf-8?B?YlZVSWk0QitVUVpkMVJldVAveDh6cHEvMTFIOWlQNUVCTTh3NDZXTE1yRkhi?=
 =?utf-8?B?UVJaTy9ERjB1VXkvV1l1dllYeHFCcHhUVVlwRjIxOGR4UkR6dWs1UWFJWDIw?=
 =?utf-8?B?ejVFVkJBNFNzRGNDcy9qKytrV2xMWW5oRHAzWDQ0dEV1b3hGanVVWVZRTzRp?=
 =?utf-8?B?cmFGbk1GazdVUkFsakhqV2pHUnltWWdTcU80Z2Y3NFQvZDQrUjdRTE1VQ3p6?=
 =?utf-8?B?SkxjYkdML1VnbjBETnZwRWkxUG9PUGl6YnQ5K3lWdy9rUElzZy93ekJScHRr?=
 =?utf-8?B?czcxdEs1VVVMdmI0SEdIUVVyNElzVWFEOXBUellHMG9ybmZIUzd2Tk9raTdi?=
 =?utf-8?B?V3ZtazA4a2xETlJVb1gyT0JsMGN1dVAremZpbzQzMGtTQ0lua2RJNjdoMFhK?=
 =?utf-8?B?SmROQWdRbmdDTWliWVp1bzNjcTdGS0hrWkxFSXdxaXBlZ2JZeGpYc2l6SXJi?=
 =?utf-8?B?aWpiQmRlWkQ0REszSFhibTkyWEVrSDJEdDJhZC9PTHBVbU54RU9aYStEVkpE?=
 =?utf-8?B?ZWprTnFCZHNJeGNUNzg2aEFHTVBOcFQ0dFR2dGhZcTVBT2d2R2tiM2kwQ3pG?=
 =?utf-8?B?cEMvMGhMS0szUStzc2tCNjFvMlBWMXZ1VWllMUFCUC82NXNsYUZJSUJKVDcw?=
 =?utf-8?B?SjlRbXRvazI2L090YnN1dU5hbFdEemE4Y1RiZjlITVdiem5ZZUdycmhvclV3?=
 =?utf-8?B?S1Y1M2NGWlJxRTRpZ2RLTHh4Tm1aZk5jb01SV2IyQkxEWm9LL2N0NUVXSTd0?=
 =?utf-8?Q?PPj7Mjh4KWnQIdDtlu2276o5ZZ8UtPq/Deieg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 536b80dd-6a24-47dd-ca26-08d8da06863c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 03:28:03.0574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSVR4fxaGm4k7WjRrlCwkTyUz/sOqyXqyhDbRc53o91DGTTsRkB1bgvGCGMtxW6Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_15:2021-02-24,2021-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102260025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/25/21 6:27 PM, Cong Wang wrote:
> On Wed, Feb 24, 2021 at 11:33 PM Yonghong Song <yhs@fb.com> wrote:
>> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
>> index a0d9eade9c80..931870f9cf56 100644
>> --- a/kernel/bpf/bpf_iter.c
>> +++ b/kernel/bpf/bpf_iter.c
>> @@ -675,3 +675,19 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
>>           */
>>          return ret == 0 ? 0 : -EAGAIN;
>>   }
>> +
>> +BPF_CALL_4(bpf_for_each_map_elem, struct bpf_map *, map, void *, callback_fn,
>> +          void *, callback_ctx, u64, flags)
>> +{
>> +       return map->ops->map_for_each_callback(map, callback_fn, callback_ctx, flags);
>> +}
> 
> A quick question: is ->map_for_each_callback() now mandatory for
> every map? I do not see you check for NULL here. Or you check map
> types somewhere I miss?

At the call site of bpf_for_each_map_elem(), verifier knows the map and 
ensure check map->ops->map_for_each_callback() is not null. Otherwise,
it will reject the program. So we are fine here.

> 
> At least some maps do not support iteration, for example, queue/stack.
> If you can document supported maps in bpf_for_each_map_elem() doc,
> it would be very nice.

Yes, will add more info in uapi/linux/bpf.h. Andrii suggested the same.

> 
> Thanks for working on this!

You are welcome.
