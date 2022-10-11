Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA225FAC60
	for <lists+bpf@lfdr.de>; Tue, 11 Oct 2022 08:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJKGPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Oct 2022 02:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJKGPq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Oct 2022 02:15:46 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346B86CF64
        for <bpf@vger.kernel.org>; Mon, 10 Oct 2022 23:15:46 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29ANNRFL025579;
        Mon, 10 Oct 2022 23:15:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=NtKyTF2Q88DRfp/k8oaBbUwcw1F/8VhqucQ8IkIBKwY=;
 b=RRjBW9GuzJD8RDkeD5/yh6gC/8azJBntXsjBi3FiubYjAXPsfF8Xd58U9Nm+/mCR6q4Y
 Vy2v0dzr5RI6ZSq0QOBHZ24TpDK6qWAU2uiwA4FSe6bEew0ONT+7pwur6+TgV9oCY9+v
 WVq1Zg3+P11hu0ZdsoJMyPbvyZRzaIq68LeHcFe409xs2IrNW21DGo1jr+0wnYvkse4K
 Mvcwc6SAEHVr4xINfOuXTKuSLCEj0ZZd/+6Xs5Uxfc1PJhGS2kbeids/4lsyBWG6Xi4B
 /jown1otR42Dt0brDnLzSzuyOKFjB7feuuRjEGhDxEjduxW9J5/lLJRti5QVrIvzETgj rw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k4hfdfx9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 23:15:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhCLyJrb9Lkpg/TtsM6MN11R4+3cwFvvuqdylAHK9+GK7aGBdD2ZCLK7o7BmKXLo4tseHzuYc5/eNfU4JEAvxRwy96lgaY+8rhlGMCti4IdrzXE4vzmgJ7xjIhgX1OPMM/WVq7EzsLqG4s9vhwvHHzvIlwG671ZaXGougrtrekbx7fn9WVYI+AOKM52szEr7UDsuUOAxFIU56ulF4HfIQaZIR/hO2dzfXZh439OqYTkjs3T45e70C1bu9fgwWzCLP/vQjpXtbgVRjZ9U3DAGrTQbdp17ak72IYGqZBWCwwYKjkfCC6WOR34loGauSHCyOuUIb2rsAUyf7q3XNjVUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtKyTF2Q88DRfp/k8oaBbUwcw1F/8VhqucQ8IkIBKwY=;
 b=Jo18lihZUcizREnGfYqpSzbDHPnWLSnpdI4A1cx3IUtjIxrqks6T9/A+vzg2m6x4Bx1XJLjsdmRQWiE9BAGxhT7hOdI/IolvZ2no08eSw6TZyBxwF4sAVLtQR2M1sOfWvK08yX1njyygDZftI7tk+d2EAUxX9wcY5+Wr6R2f6c3Z3ttAap1LWaKkpdKBQk4Kk35xnJCKK1hnM3ZcCAx7kURH18FmWPdhVQJg5Iy8d3k1ZJ1Lc7AyVo5Tus2tcunozRZs4pbCSNT9jWHSvr3tutEJz/Hy46mzdQYNfM7GwLsdwZILxhOCAJWv7pT7km+OOjrszPPNWNReELoOBNI6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2905.namprd15.prod.outlook.com (2603:10b6:5:139::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 06:15:41 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 06:15:40 +0000
Message-ID: <d75c0d75-6d93-f8c1-a8be-c2bfb097c9ab@meta.com>
Date:   Mon, 10 Oct 2022 23:15:37 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: Symbols with double underscore prefix are not emitted to BTF
 .ksyms DATASEC
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     yhs@fb.com, ast@kernel.org, andrii@kernel.org
References: <CAP01T75b+YsU7suqaM8wk_ty3F2SkVew+6HrFGF8GaUsw=_xdA@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAP01T75b+YsU7suqaM8wk_ty3F2SkVew+6HrFGF8GaUsw=_xdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:208:236::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2905:EE_
X-MS-Office365-Filtering-Correlation-Id: fdc8d15a-a1cf-4258-e65b-08daab5005b4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4JSyHusMktEvkomax4GPxzNmy7sn4cdbQUW6dpThLIyTTTaMkc0OgFxrnel18aSh3HepwdT7sBaynKgB1DWFGsVMIrb5QsgCpR2hk3HAO/tbYEeKlOoBG9dQjwFGRGMtG+obZeKYGYhkkl3hUI1b6IUxuVn/gwpR4EVylVA4SakHaE7mHibiC/qfmfWt7NhvkXY3LMpdYRrIovRJey+bdGCq0FRFkUL2G4IP6RA08mikOpu2KUQYeHZULCLiCRiMqa7hMuC5Z67+j8wjIkO+6dHH0DLnSLj9Yj3kil8bz1BrwZ1veXIwq+rgJCFCowgRNvIMcSm8+ERsFs9QS8JdFPKzCxUQHq9Ywd2uYx1BluEtpNsErz21+L/oVANlkICXnSEOxK/HXGY4GOh3gzAH1ej3hRpgkAvPHJjkZx7tpXNv4VlpkRrjwrITGK64YyztUq0+9+5heUXP3r5olA6UQqsUcXvUmcVDLjbhz4Qpmb94qR8ky7L5LJAqqoRSBoByiwVSpvXXfvlZ/k5bPzVp3bxfJGwcw5UKNdOvpVO24TFPw3+hO73PyAwGs61ZiP5Wkn1FDj5MVrwVK2JSHV9pl/bGTPmMXvtiqInLsQphvGdLkulHiyJdgDlFd2k1kMXuIUwpRtxA5d2I0wCS89iXKe/9LDfYAwMr+AS5UIRiHcjV/06ioJOAoep+L1i/97G692kieK+KKS0dND/cId1K/BrNwDhY34cIVWIfwuYKv8pQtOvyfPO9wfPCPrZd6aj3+ftq3iDnMkzhZwq/w7dZzQLQT/9YvzJax6UgsJKKbpaz4V82HEzdEbrJ1u836MmblUMFY7LOLbO6xvXmkynScw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(31686004)(38100700002)(86362001)(31696002)(6512007)(36756003)(6506007)(2906002)(4326008)(41300700001)(8676002)(66556008)(66476007)(66946007)(5660300002)(8936002)(316002)(2616005)(186003)(6486002)(53546011)(478600001)(6666004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXdnalVnZjJ6T2tLcXVFWEhITGJya1VMbE53U0grOXdtVStwUXBTZmk1VUFt?=
 =?utf-8?B?dHptRlNwUUFMMUM5TVoxUE0zUFBLbU5QYTB4UkhJNCtla0h2Szc5d1F6R0lh?=
 =?utf-8?B?elNtTXdoNnM2STBTeWhXa0NDY2VubU40eCtmTTdvMlhtNzdVenJWaUdPZXFn?=
 =?utf-8?B?d0t6OXJFN3FGNUFER3lJdll2eHVmTGt2cldnSWs4eTNBVmxpeHViSlB6TTFx?=
 =?utf-8?B?eEV0MXNUMVkvRm92TFJXVnRmM0FNeTQxQTh3amQzUE1sbzd4NlVFc1E1SXRj?=
 =?utf-8?B?UGhEYU1hTEt0VFZZaFRIekNESnRjV3ZKUVBMSlNHeGxoSjloYW56KzMwaHN5?=
 =?utf-8?B?Z1BmNTIyZm1Bc3B3ZUZQc0JJZ0djYzNoY3Q4MFVJMGhURjR4d2pxRFUrOU9q?=
 =?utf-8?B?VUJOUUc2T2pTL3h2S1NOcHFFL1AyV0JtUDhsNlFRdHNid01aOTNhNWhOOWlk?=
 =?utf-8?B?Y0tyQmFHeTd4OWI4blJ3bmhKeGhGc1IwUVcyZ2pBb3dBL0JhMGRwb0I4Qno4?=
 =?utf-8?B?WndPS0pWSjF1U3JNNkc1cHZHRW5Tb3BzakhYRW5qUVZRc1ZQQWFiOWhSWXds?=
 =?utf-8?B?QVkvcHBPcXV5OGlUOVd4RXh6YWZCenRLL01ZWXppTS9rZE1HVmF6UVA3MWFV?=
 =?utf-8?B?T0lKOG1yUjMyQm1pRnlLZkhsWWtlQVY3K1ZJZFhpTW5xS2RnYldyUU8zTjBZ?=
 =?utf-8?B?QThQU0QyT05Dem9xcEtpdHQyWm4vVi93cFNiVjNhV2Z4YXkvU0taNFlSTVE0?=
 =?utf-8?B?bytLMjhhR0dsRWw0V1FQWENXU3UwejA2SGl0ZnNnSzg5Z0ZBWENjSE9Ua1d6?=
 =?utf-8?B?bXRad2Q1WHlxUTloSkJWUGFOQVpHcmtMdnFDS1FjRXhsaFYyV21JLzZoeUJ4?=
 =?utf-8?B?RVpGemJibXE3akt4OVNISmc4aW1UVXhRbUNiWWJmVnBIdmxpa0cxOER1eTA1?=
 =?utf-8?B?ZmtCMmNkS3Q0cWtaZDVkUTFIQnJ3NVZ6dTgwRGJlV2RBQWkwVE42d0tjbEFp?=
 =?utf-8?B?a2JVNHdVY2ZUREtEV3p4SnFhQkJYTlEwblMzNzBxT1hhRm1zZUlxV25hU1hM?=
 =?utf-8?B?K0VVeU1JSEVRdCtLdTFpbWpHam1sOC9kZW9GWlN6dEIrM3VNYnkxR004b1l2?=
 =?utf-8?B?YTRidnZqV1YrbDRrTVpualpoK0tKWlNGZUNwVXVZR0htSU1oM0ZBWXhrUU9T?=
 =?utf-8?B?OGllbW1yZHNpNk4yTlBEcXZxUXN2ZXhjelc1OCtiV1RjQVJSZ1R3YUZlK1NS?=
 =?utf-8?B?Wjg1d1BOdUQxeVFlQWZFVXJVMUNaVGdwWi9XVWhNamJXVWVJc3FLeFhNTk5F?=
 =?utf-8?B?Zm9xcC91ODBjSnBqZ002SVQzaXhUaC9QSVFOL2FWUUJrNGlvaFZKT0swWVVI?=
 =?utf-8?B?VG1jWU1hK1FvRSs1VHhib3Y3dWViREJaM3orOWpiMHBwOGRHMlA5b0FIV1Q3?=
 =?utf-8?B?NmVyd2thNC9GU1NGSzJhSmhvcXc1S3prVXhNL29ZVlFPeE5aaVhxbmRUMnRm?=
 =?utf-8?B?cUFRQmZpRWpLWDh5ZGlnbXJVT1VSUmNWZE9Tek9sVzVmcS9rYTdNdWFqQWgy?=
 =?utf-8?B?dEptN0V5azZ0MXdQVnNlcjlKazhaMHpUM21zMUw2amJlckw0Ni9pekNOdFdw?=
 =?utf-8?B?UnVzSnJlQ2tocEhpcyszZXh2TjBDUFJEclNGMkpCR3ZZNzlySjAwOGpYbktU?=
 =?utf-8?B?MllhZGIyR0lGSC9zYmVEUmF6MEVqS2paaXlWQyt5cGFHSGpDQjJSK0VONjlK?=
 =?utf-8?B?bmw0dnVQelhqVzVybWJFR0wwdE5zQXdXTjlpZjdwVk95SWVGOE5FcktuQUEw?=
 =?utf-8?B?TUxiWFhEd0NUTDZxb3BxWGhKMGcxWkloSko3M3Byb20zTm96eENoQ2pvN0xl?=
 =?utf-8?B?elB5eGtXeDB5dHEzbnhvcWdnclhDWGpNSklOeStNSGE5bmgzZTJqczllL1Rz?=
 =?utf-8?B?YU9JMFkza1ZoS29DZmk0TkJpZmtIQUpyVXI3TjBUVURpdUtaZjdGaWJ3VFA4?=
 =?utf-8?B?cWZLdnFWQlJ3b3BCNTJ0MkRDTi9QRkIwNTgxYjloYlhMQ05zYUo3dDY5cGVF?=
 =?utf-8?B?UlBUYVdrV3lqZk9KWlRHZlpSMVRRaUFnZDhxRHpEWXdLeDBxK3Y2TTNySTEz?=
 =?utf-8?B?UlhnbXNmK0NxUEh0dVlmK1VVLzAvdmEvT3A0VDZ4Nm8zbUlXbHRSQ2pJWlRT?=
 =?utf-8?B?ZXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc8d15a-a1cf-4258-e65b-08daab5005b4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 06:15:40.9071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KreQQpGX70Dj93JzWRtc7i/zHfyC9FmfNvODdU4SoLHDyqVC/3S4uDQOjkx1f6YZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2905
X-Proofpoint-ORIG-GUID: 3hxkO1ULiTST1S8IEkzf-dx8SLOVKRfo
X-Proofpoint-GUID: 3hxkO1ULiTST1S8IEkzf-dx8SLOVKRfo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-11_03,2022-10-10_02,2022-06-22_01
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/10/22 8:18 PM, Kumar Kartikeya Dwivedi wrote:
> Hi,
> 
> I discovered that for the following program:
> 
>   ; cat bpf.c
> extern void *__bpf_kptr_new(int, int, void *)
> __attribute__((section(".ksyms")));
> #define bpf_kptr_new(x) __bpf_kptr_new(x, 0, 0)
> 
> struct foo {
>          int data;
> };
> 
> int main(void)
> {
>          struct foo *f;
> 
>          f = bpf_kptr_new(0);
>          return f->data;
> }
> --
> Compiling and dumping BTF shows that the __bpf_kptr_new extern is not
> added to .ksyms DATASEC.
> 
> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] FUNC 'main' type_id=1 linkage=global
> 
> However, removing the leading double underscores fixes this:
>   ; cat bpf.c
> extern void *bpf_kptr_new_(int, int, void *) __attribute__((section(".ksyms")));
> #define bpf_kptr_new(x) bpf_kptr_new_(x, 0, 0)
> 
> struct foo {
>          int data;
> };
> 
> int main(void)
> {
>          struct foo *f;
> 
>          f = bpf_kptr_new(0);
>          return f->data;
> }
> --
> 
> and dumping now shows:
> 
> [1] FUNC_PROTO '(anon)' ret_type_id=2 vlen=0
> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [3] FUNC 'main' type_id=1 linkage=global
> [4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=3
>          '(anon)' type_id=2
>          '(anon)' type_id=2
>          '(anon)' type_id=5
> [5] PTR '(anon)' type_id=0
> [6] FUNC 'bpf_kptr_new_' type_id=4 linkage=extern
> [7] DATASEC '.ksyms' size=0 vlen=1
>          type_id=6 offset=0 size=0 (FUNC 'bpf_kptr_new_')
> 
> This is on the latest clang nightly.

Thanks, Kumar, for reporting. I can reproduce the issue. It is due to
clang frontend. We will take a look and find out a solution
for this.

> 
> Thanks.
