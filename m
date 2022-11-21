Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E254632961
	for <lists+bpf@lfdr.de>; Mon, 21 Nov 2022 17:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiKUQ2E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Nov 2022 11:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiKUQ2E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Nov 2022 11:28:04 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F057214D2D
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 08:27:58 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2ALCqWVl006240;
        Mon, 21 Nov 2022 08:27:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=lOAHbBhis/UcTN58O5IoId8QZZMzA4uh/jzeuySc7Cc=;
 b=gjalTlF+PGX3OtLNyL3I4E392onVp3CrpTAS1MzzLkB3nGL+LdcRYXPBhBRXGCuI/lmZ
 yqTVz/kDxr9mnV9Q8m9LHUKpGa/ZlqVN3SVNeamyTRPVzNvEuUEsPTLx2y14ERcFGLob
 k1kwCp7akGFXWAqVA452HgKm2NbWcPYAxQMVYb7Vl+7EUjTv9MWmwmaH7CAVaF1RsJF8
 IMKz9QI4O/Qi0oBgfxEbacc1V2fDssqGHxBfOgutJdiGCoBy6SXpF5uHRu3wivNUHYNv
 bLIv0vYpkwXP5BlgUk6fUUfSAQ8RJFzsY/Nkj4p0jxsEVs1EZ/cl1zrPJkdC8e0QrQRU sA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3kxuq0egyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 08:27:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TFij9YXWmaolmAQE7IRfRbmS6+pfSBkTywQEQFGEW4XxkmEFKwXU11C6wKMPOyK60faUs23YgFb1SxGPAJ0VbjR1WLPWXRNtxPDEVF66YwDVcm0rms7yJaxsXZNTCvycUMlo74a//XUOe8Sb1QVtJ1csl7PTRJxpPHORvjN2O1qqgoUtd7m8MCVMNeOeSzOeRuJlX45j6pXupmHCfPLgMQmwKDdhArWkOiYqTHHtAOQ5zXDwpGzyier99xoI+jecSkeNBt/G/NDvjVv6w8epCdW7KpySN4Kx2Facem819Lh8u5a51LhdozIMUfVXjfg+J0gFJDbfolJauyfOJaAUsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOAHbBhis/UcTN58O5IoId8QZZMzA4uh/jzeuySc7Cc=;
 b=kyU4tX/98PF2ObfUvedfwJSWA7C64gSmw7X+SDy4UUo6U9l+kW30v4JZ9tVTvPprOku2y+/nanT4Li+bAHZmxV3+cH52Hi6C9+EU3Mi4YmhOiuZ20IUIrNN5yV2/E6i+lN+s5DGhK1BHNdaOg4ineWXrDQi7fPZ4+A/IriyRbhMZUKiEI6CbrT1XGgpzlMjHtE0ZbW+FZoXpxQmvfGzg7xt8T8Uecu+G3hbmo36mZ8Y96hVNFEiJnNa7oH84VOvA8UPidNkjijssOol9KNc2hCaSh6rahLcRzmOfXFn3qyrKAnK7XF8daYhlorX7AWTnSEQ/M3hyZ+z3l8H7IqHwaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3828.namprd15.prod.outlook.com (2603:10b6:208:27d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 16:27:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Mon, 21 Nov 2022
 16:27:12 +0000
Message-ID: <29a89827-0922-7520-6540-edc0c07f7fd9@meta.com>
Date:   Mon, 21 Nov 2022 08:27:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v3 1/3] bpf: Pin the start cgroup in
 cgroup_iter_seq_init()
To:     Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com
References: <20221121073440.1828292-1-houtao@huaweicloud.com>
 <20221121073440.1828292-2-houtao@huaweicloud.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221121073440.1828292-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0222.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3828:EE_
X-MS-Office365-Filtering-Correlation-Id: 978b4bee-490b-4f02-2990-08dacbdd3e43
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVytffl6LMvDGjry/+IVr9am4W7QRhtffow7x8pbjUnkzJDNID8Cjly6s4UhQKu3Ot3343e+7jDSuz/hwAFiDP1nbwlBFrrOzCpOd8NCgXsVyD9uPt3ez9aqx39+yMhvolffh3KhgdhbyuiIInz4t3spht41YXDh5ParN7oI8O1pWVx+my7cTDcVPtFjdu+wiRtdQ8LJIRGNwD3zw9MT4U5SzSya2+iWQw9jbQfk1Gfu08KHa+LKL3QZUobYfU9peQfUIHrLJNzntw9lhmEerkyVOb5dS1KoWJi4z5H5K2s3Dh+yEeRoqrbJiI8l0AGS5KiOo9az4jRD5rXSungnNvevPVrQKSsdKOB7eSCxM37Oqp3rNIXzkvbmYVyfvzaKiU5FwsDSAlvrWJXOWhYqTahXxAG5vX804Wf3B/AL3j92/UajUzYVUslbd6GDerhh7WUg4kEs6g8HJqGd+8pO6H9bXdJCBGIKYU2rQXC27OFOdohNKf752MQUfic2AFMuwqWMPn/F3zsbbACNXwC/UrPU4EjUxiqGvF05nrGaaDDUYDsqMW+wP2w2bUmirKop4GYB+a0ScYaHW/8lMflMRFc40aHkx7Q6Uw95EFpdGjtf2rZ8n8pksEb9Zcs/D+nPw7LlCj1+GKA2y7vq/p6wStotUgB1QjY+WGbh7twLLOLsn6DHUetWvi1YaN6P+tGbnPIOsvzZRLB8fpmCeV3IY1O6sdn4uNfkwfWRmNow5RQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199015)(6506007)(6666004)(6512007)(53546011)(6486002)(186003)(110136005)(2616005)(36756003)(2906002)(478600001)(38100700002)(31696002)(86362001)(83380400001)(8936002)(7416002)(4744005)(41300700001)(31686004)(66946007)(66556008)(66476007)(8676002)(5660300002)(4326008)(54906003)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHZBTkd4SUwwWU4xeWIxYUJ5SFRrVXd6NllBaktFeGNsUWtJcTBld25NVHpq?=
 =?utf-8?B?b0prWFBqNyt4OFkrTHBudHkveUtCdjU2OGE1SVU1K0VzOFJGaFk1S3NkOE82?=
 =?utf-8?B?aTdIcUJBcTY1c2RBY3JRWlVaY1hrTDllWkNMdGRraXNFVGtGN2E5UGdNdDVP?=
 =?utf-8?B?cHN0SUQ2MFIrTHdVNW95MStUOHNjd00wbDNXQWVnakh1R0pqQVZUTHQyRytr?=
 =?utf-8?B?OXNlNnlnOU0yaE5xVERaTUFYWEZhSTlxZk50T1ZLWlBOV2xTYjJFVEdNSFNC?=
 =?utf-8?B?OCtVczJmcXczOXZLREgyM0lqU3RxV0l6OTU3V0NWc2h1WHdGaHE0WG5QRlYw?=
 =?utf-8?B?aWtvWlpMQnhIYW05K2EzRUJ3bGJFcG81c0VjWXJpSUJKSkFiZXcrZ2ZlclF5?=
 =?utf-8?B?K0J3L3o1bUhLVWJBOGV1VUdZMGoxVDVqU0dGTmZ4d1NCbUlVYXNMb0VDWlZG?=
 =?utf-8?B?OSt5QUNLN0s3ajRSV1NzMHNRV0poTlIzV2xyVElLdkt2TTlqOXFWTGhvaDQx?=
 =?utf-8?B?Y1FtS1V0aUg1OEpZYXpjK1BhZE1BU3IwVCtMdmxsWnVRL29VSCtFYnRVUXc1?=
 =?utf-8?B?SGNIZ3ovUm5MMHBNd1RNQkxJVEc1cTJPWGd4SXZ1YWVlNkZlSlZMcEo3ZnRs?=
 =?utf-8?B?ZXlpUVVYMGsxeHhPWnU1TlJRNnVScEhJdXdZVmZpbHBJZFR6NFM5U1J6c095?=
 =?utf-8?B?UFhJWEY5bkcyMzJNaldhbkpDWFZXb1ZMRFV6OGJvREVZSHBvZjFjNUgzZHdu?=
 =?utf-8?B?SGVydTNodGhDVUI0YnU0c3JSWkZzWmtmS2xkUC9BMmc5RkptZEZtdm5WREZ5?=
 =?utf-8?B?OStCSThyTWRvemZjbnB6SFc2dlNTRGRRVEZuemlUWFk0bThxTXVEaFBOUWJj?=
 =?utf-8?B?b0IrQWxYeml0SStsT251ZEFvWWhUUjNNQ2R6ODdjQlpiQ2RXemVLSWwyMk13?=
 =?utf-8?B?RjRjYlhKVjJXL2NEaGpsSVJHWkhGMitXekdYN3ZlMU44L3NJbXJ3c3NhQnNO?=
 =?utf-8?B?eE5pSngvQXpLRkdpY0FTTGptbndTTGJNajBXYmxKSHBaUndiRlkzZEUzOHdi?=
 =?utf-8?B?QWNxNTVEYTl3R2lmb0VIcHNyTElLbkp1RlZOZkhVRStrUUNCeVZRRHhydkd3?=
 =?utf-8?B?a0xXMXp2OGNSdkpTNlNXREI4MGpSNmx3OVpEL1gzTDFUOUJ5aDhkYjhiL0N5?=
 =?utf-8?B?RHprYjhRMjVxbVUzd2V2UWVvVkcrNDFhK0c2ZU1DLzdWdVBxN1BmK1lFNXJj?=
 =?utf-8?B?Z2lhQXN0RGJCUk4rUklHSnUzelNRamlRRW9JVkhPbW9TTVo1V3QyVnVjYUdN?=
 =?utf-8?B?TnNoZEhqOU5IMk5HMjlrVkJINFRwZUVyUE1lYkk4MmdOdWcvRDlmUzYzRnQw?=
 =?utf-8?B?VER2YVluVzRLK21pZXRvb0VJVWIvb012dzUyU0xYUUV5SHYra25leHVWSDFP?=
 =?utf-8?B?QmNoa3hYVlh2NmtPd1cyZTczUlRyZGpTMEpJV21qbEVDTzBDSFROWW1qNWk5?=
 =?utf-8?B?ajU5c05hTW5NK3QxM2FHWGp4elhKVmdCYzdBZDUvVmhVeWhvRVIrYzd1SGtL?=
 =?utf-8?B?TlliNzlhWlpMUFpHWGJneXlIRVVJOVZyMEhHVFFZUkRSa1hRRUUyb1VnMERG?=
 =?utf-8?B?VEFTaEcxcGh3WmJvNE9GM2grVDZia0laTjlUWUU3Wlp6UHRVaW1qQXBlaUx6?=
 =?utf-8?B?N3ZVNFEzUm5MK1VYcGdNMEg5cStEbUl5ZWFOQVh5dTJSVGxaYmNRQWYvNDU5?=
 =?utf-8?B?YXVGa3luOUk1U20xb0xveXFmWVNyQTZvc1I3RDJvUHk1ckJmZjlUYTVWdkZl?=
 =?utf-8?B?S29LVE1PQU5ZM0RrOVVyMFRMa2cra0dSYWhUNERNWVZhTDB5dXVyeTFDTFgy?=
 =?utf-8?B?Rm51RjFSUFN6b2dYUkJhYzFMWWNIalUvVEM5MXZMbHdwalNzaFBqREhDd01O?=
 =?utf-8?B?ZkhCMFE3bllaWXlTM1hPRDF6M2M4YTBjUDlqL3NZUTJCS1hlU1RwSlB5TzZ0?=
 =?utf-8?B?bWNQZ04xTGxEZnozbmFLYjBxZ2NwZllJZDQ3YUtwK0xYZGxNbDI4alZSWFhD?=
 =?utf-8?B?cklVSzFmRUtKN1paSEEyNDIwRzJqMm5QZFRKdWRrZTNnYmFjOTU2aU5ua2wx?=
 =?utf-8?B?bzBiZ1habTEvb3IzZW5CL0RPNXZuSTZUWnEvT1liSkxaeDVYTW5aMnNXbC9K?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 978b4bee-490b-4f02-2990-08dacbdd3e43
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 16:27:12.1333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfecdaJI9n+MiOyrtECX9l9if7eYgnoN+/hsJoSQY2ur4EouRihYe2XKCms3q73e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3828
X-Proofpoint-ORIG-GUID: MTLz4dkFZ9HZhzUhEPBWUFH_K4MNxUxM
X-Proofpoint-GUID: MTLz4dkFZ9HZhzUhEPBWUFH_K4MNxUxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_14,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/22 11:34 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> bpf_iter_attach_cgroup() has already acquired an extra reference for the
> start cgroup, but the reference may be released if the iterator link fd
> is closed after the creation of iterator fd, and it may lead to
> user-after-free problem when reading the iterator fd.
> 
> An alternative fix is pinning iterator link when opening iterator,
> but it will make iterator link being still visible after the close of
> iterator link fd and the behavior is different with other link types, so
> just fixing it by acquiring another reference for the start cgroup.
> 
> Fixes: d4ccaf58a847 ("bpf: Introduce cgroup iter")
> Signed-off-by: Hou Tao <houtao1@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
