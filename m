Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A5633556
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 07:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVGcs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 01:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKVGcr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 01:32:47 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D2525F7
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 22:32:45 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALMdcBG006493;
        Mon, 21 Nov 2022 22:32:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=DpNOq9uwdf302J/NQlU36VygNy6ojVZmIfP+5f4J/HU=;
 b=WjGsXz0WSIoW7K5v//afR/agKrCmJ6XaHN3eRv02ZslooMEOwLHhoOsStyry29oOlCEZ
 fnVwgBqmeHegM9nF61rLrMajN0zSHbq6slR6U4/qA2e24crxugvCKkBjcHsJHFXuhbLx
 1k3m3/ufnn8y8Ls7OQ+EhwtkJITfJmoDq4qeLf1RvTqQ9XtqBr2yJ5WYXZYSPKopV4+4
 0y4smNmkp5Qr4CEa7hGNQaeQcuAh/VR9romOQAVzMr3tJM2iEhE76N+Ssdmw0glQrAzD
 VKmmsmkbcb5+IPkOgaFpFq1si0TIVzUJ77RKxxE6KrxThCxkS9zk5CgIQc6pjnWaqgzH Sw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0d21n0q2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 22:32:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSpKA5lDlxEVus9MTapL0JKfdU1Nj6MmhA3yebpLQhRbhstlABL3GBEpIfMLFR7yxDOioUAt7qPKidnWuBQmooswtpGpBKcBrIHyXfPJluNNhFXyKjEplA33Gt/E92XqA7h0IUzB81OBrXK2h9b+uJfszCgYXSQxkQmCyvbWtpqSiSBmF3pUHYo7SQZ9lCNdZO7XPVecie7+SPUoRO5aoeSX+2Bj9yQ+AhXFSOZ8XYOWMKImmmUjiz6qw90YyMyPtOSYHdPAHUx4RylneX3rNQl50BmycAktmNwnhPyXezT87m1nx7PgaCsININDL9sx+2XWJDW2BbFj84RVuQsqNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpNOq9uwdf302J/NQlU36VygNy6ojVZmIfP+5f4J/HU=;
 b=iDiVXuo4T/Ak7bgOawlyGgdLQWeHV57LYxvmMfo2PdOVk/V+OYrRn94kLhACk+jba+BmqbO15b8+ul2eCTLqzpL1WHdE1U+QD8uq4LE+5qr4t4sL6UdrqerROJN9uXJfgZdlswPQnvsHNhHQp5rofXR/1StX420nsEUzNTHWrECH4BUbZaYWUUNf2K2irYPrqj0yIGnWBPqj7HhwXApPrwbpN4n08UvjKXsPikIF6UAcHImv9epsxeJ4Ry026g64Mw2msx6Psa5EetSSwX0CpUXYcVLFSGoKnttDNhH1tT/CTcMZUpkFCnlRVEE0dcOD2DUS+7DjyWcTZaunOkX5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2920.namprd15.prod.outlook.com (2603:10b6:a03:b5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Tue, 22 Nov
 2022 06:32:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Tue, 22 Nov 2022
 06:32:25 +0000
Message-ID: <5c80c687-a70f-134b-ee16-63933020db31@meta.com>
Date:   Mon, 21 Nov 2022 22:32:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Alexei Starovoitov <ast@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
 <5f66b636-66a0-5ad6-c83f-09cfc1b020c0@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <5f66b636-66a0-5ad6-c83f-09cfc1b020c0@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2920:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6e0e69-e173-43d6-e793-08dacc5351ee
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hJgwl7kCCw9wqLeYqsPbFEEcHgXXvzDSr4mNNjFjROCxcp2cYlKWq5mrSQMvOmChBfULC1dJQ2GlQzbfY6ecWL8ZEWD+6I/mcz2sXJNZyXCRiKPKR1iBkVEAE63Fv3ZduCffSxjaoha0hehLHdPIpkU8Fbw3IMdbgq500wRzAo0FaWrBxmAGbO4fKOaFdpb5B0CKtOhpmbHhqHRCg1ntAQEwRUIQt3Rkds5p2iP+7/T9lLfQ7cyAxhJ9lFMN5kJXNKMUqZq+uRppSvCDASTE+3pOKP/PYUdsO/Bw/HWoDfgB6peu2iNwhU/RRC8ffPLsHz+/Tkuq9tb2zR3eF9yHzTzZM1mnCdHO53yeV6YZfuV1lMr2UTBdFU8ouFYx4i6wjvrPiIzFSRkgje+0TXWI3up2SrsDAq+H2sVLSElxe5uarXfslHLhvxDmFVem0keP5JDzM9AsE0q8UYpl7e721JLTBgXmrVJLs7kGhltkvz2oNFc4uWRR8RMgyYIrNorxat8YlWnMX2FmeRLK98djhq4Dz4mSNL/gqz+W3UimccF6tLsBaNJT4zACorUkgFVG0V2RARMwQR+4a6dTIK27kErqjUFZ1mVPJWWtogoIgg1IWX3IZAnCbIW+zI8YRfirb/lMWBt1v3Eb/8czwRFKA9JC2S5Ni8fpvnI+yUTNcAV1Yh01FPhlEkAuD/s2SytD2rvUk5LJXek3FkVDBdjn37hUak/PMBQVt6LbazgVtCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(316002)(31686004)(54906003)(66476007)(66556008)(110136005)(8676002)(4326008)(66946007)(2906002)(5660300002)(8936002)(36756003)(6512007)(53546011)(478600001)(6486002)(6506007)(41300700001)(31696002)(86362001)(186003)(83380400001)(2616005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nnp1TWt5UVZnckkra1dPa1BrcE0zWU1aZ280LzhnSjFYanZvZjZYdW9Na3Ar?=
 =?utf-8?B?MUpaYU9GaldsUHpKMHkvMWVEaVJKTG04Snlhcm1mU2hmcW9XOVdHOUJGMkFt?=
 =?utf-8?B?YjBYV3NmbjNJa0JEMGVsM05yRTdISWNJYWlGZXNCODZQSmxlcC80cHMyc2xq?=
 =?utf-8?B?dmtTZXNJQlhESzJPcHdmSGViV3FOeWdUVWdmWjZLZGUxSWdIcmJ2Q2Jwd3Vr?=
 =?utf-8?B?NndOWHdpTWRSWU5zQXg1MFFlTGZWL1BWYVk4OVVTMlNZMGJNNlVhUHN2UVNl?=
 =?utf-8?B?V0tlbXk3OWZNTXFJV2FsWVBicVR2MjNKcjlSb2tvYnozT0JsQTRzSW90bTB3?=
 =?utf-8?B?WE14c1d4QnBiZnR6cWNuS2JsaVlkMzFoYXFCamE0WVNEdHA3MnYvM1o3TnZD?=
 =?utf-8?B?NSt6bTl6TFNINXZxdzBaS3NIT1VOMURRbWE4OFl6bkpicmhXa0FRb1ljb05j?=
 =?utf-8?B?b1pocnBkV1JVK2NOb3BUeWNOWUxKM3JuTU1tZm1xelZIcWN4clNoOTRiK2V0?=
 =?utf-8?B?TDlHZHlXYUpWSHdJd3RGeDRtMStCbGZDSXFmaWMvLzBSVGtzUmlrdUtxb3NK?=
 =?utf-8?B?RTMxOUswYjJEVjdTenFlZEdSSjNyc3lXMXpmdnRLd0lhVjlGNlFEMUQ1Y3VV?=
 =?utf-8?B?ZWpvK0JXR0MvemR5bDVUNGxmMjcvdmFDL2s1MVppdFBDcTJIZW8ySjZ6SDVW?=
 =?utf-8?B?eUVNK2diVXNpS1Z1TWd5R3VjYjd2Z0l6RjhWSHhiV2ZGaUxrS0laUTVrRFNw?=
 =?utf-8?B?K1Z6ODVlNDNMT1QvN2w5UnhvTTNvS3hFVFpmZFRYU1hWYW5iLzFEajN5dmRr?=
 =?utf-8?B?RUdxWE9IaS81eUJDY1oxRjk2SmRlTjhDQWNES295Sy9ST1JubWUrSHJ4TUUv?=
 =?utf-8?B?cXBkUUMwOXhYeTJJeEdaN1gvVHYzalY5RmNkcGdVS2tVZWQzREFzRHJCcXI3?=
 =?utf-8?B?NXIzRWdWZmhyNUlPWDNERFVRTG5FTFhrWWJtajlkL3RGYU8zU1FsSlo3aWd6?=
 =?utf-8?B?Yml1UFg4K3dSU3BTclY2Q291dE9mZHo5MlBVZk1UN05wbU0ybjYycWxaeVZp?=
 =?utf-8?B?RnBSNkl4NUxQYS96UWo3aDliaFBMOVBLQ2h0L2dLK0hqa0pGVUtCSzZManRv?=
 =?utf-8?B?ZWVMenNiRW0zMkhEYUFWVW5qdThZMW9sWURic2h1eUZQRjZNTUJlYmRXUVAv?=
 =?utf-8?B?VkhzTEJ6OUNqdmxNeFVIcGpNRmRqWlM2R1kvbDlpQUpQbU5CUU56MlViaEhh?=
 =?utf-8?B?NGdHUHloYTdKTE1NeDVGVDc0YVpYbWxkdjI3SkJFVmQ4UjhNUHdYTVpNd2Nk?=
 =?utf-8?B?UnE2dzRrb0QzMWR5VGRJZ05ISkZKcUZ4bGUwUFpzSHhBOS9wdnlNOHBzMDN1?=
 =?utf-8?B?cVV2SVhySndoUjkwVkYxY1Y3Z2tJU0VMazgyWFMyWDFPb0V4WWs4cEZPc1Q1?=
 =?utf-8?B?UC94MVZrYWM2aTdkSW5xeExXbURDb1lDWkJmWmFETzkrVlhlKzNlMHpsdWp6?=
 =?utf-8?B?ZlhMckpqVW9GQU9leFdjQm53VHFleW9GcWU1aDQ3enJjQ1UrWFZxQ0h4WDQr?=
 =?utf-8?B?Tis0MWt3YzRXRDNvV3RPSGdZT2FoNmVBQjN3dU1TK1hzdi8wUGY0bzJpNlVD?=
 =?utf-8?B?SFZCYTVmdCtvTnhaSS9ZdkdweGw3ODJJTU5lOXVvSTRoTkxqZ3RlTWorWUVw?=
 =?utf-8?B?RFMrQ3RJVTdOdFJDb3VWTzBlNGlhL3JyTVIveXRuVVZHQjh6Sm95RFpQYmM1?=
 =?utf-8?B?enlCQ0pGcmpuVG5hSWVtQ3hIbzJoc0JBeVZjZWdMalgvbHNadVpRQWkxNFhV?=
 =?utf-8?B?UFNKUGlSaGxxT1VyOWxYN2VwbUVKb0VJdXZFWlppMlpDOWJwdjNKdSszbDB1?=
 =?utf-8?B?Q2dicEJ3SzZlNWg0bllWeEVSRjNZNzJpNmRNaWdZYTlzbVAyT3l4cGhWcnBu?=
 =?utf-8?B?L1JCMDZ5VDVJN1NmUTJUTlhCeiswdmhFbmMyLzAyYTdSai9NanpNa3VSR0Zv?=
 =?utf-8?B?V2ZocmFTZDhBcFRzaWVqbDFvdjNVUHF4MXZhcnE1Q3hHOHpGNHFVWElyeUlk?=
 =?utf-8?B?b05YcTRqQU1jNXRKNVoyS045L0gwai9TVDNqU2NTdWlNcGJWWEdOYmZDS0I3?=
 =?utf-8?B?RnZ3eWg4RXE5eVh6N2NWQnpYYXdBTXQ3U25LQTdsM1AxWWZwRGNJamJnbUY2?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6e0e69-e173-43d6-e793-08dacc5351ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 06:32:25.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TZzHCy156FE7arftBLAoyNNyZsPXd0gs5CtL+TdY1S/K0sgw6qulRZSAH4lOXmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2920
X-Proofpoint-GUID: oGaAuNnPAlNODqh46jao8jQnYbayUnGk
X-Proofpoint-ORIG-GUID: oGaAuNnPAlNODqh46jao8jQnYbayUnGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_03,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/22 9:48 PM, Alexei Starovoitov wrote:
> On 11/21/22 9:05 AM, Yonghong Song wrote:
>> +    if (env->cur_state->active_rcu_lock) {
>> +        if (bpf_lsm_sleepable_func_proto(func_id) ||
>> +            bpf_tracing_sleepable_func_proto(func_id)) {
>> +            verbose(env, "sleepable helper %s#%din rcu_read_lock 
>> region\n",
>> +                func_id_name(func_id), func_id);
>> +            return -EINVAL;
>> +        }
>> +
> 
> Even after patch 2 refactoring the above bit is still quite fragile.
> Ex: bpf_d_path is not included, but it should be.
> 
> How about we add 'bool might_sleep' to bpf_func_proto and mark existing
> 5 functions with it and refactor patch 2 differently.
> We won't be doing prog->aux->sleepable ? in bpf_tracing_func_proto() 
> anymore.
> Those cbs will be returning func_proto-s,
> but the verifier later will check might_sleep flag.

Ya, bpf_func_proto->might_sleep indeed better. I could do that.
The only problem is bpf_d_path.

static bool bpf_d_path_allowed(const struct bpf_prog *prog)
{
         if (prog->type == BPF_PROG_TYPE_TRACING &&
             prog->expected_attach_type == BPF_TRACE_ITER)
                 return true;

         if (prog->type == BPF_PROG_TYPE_LSM)
                 return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);

         return btf_id_set_contains(&btf_allowlist_d_path,
                                    prog->aux->attach_btf_id);
}

If I understand correctly, bpf_d_path helper doesn't mean
the helper itself will be sleepable. For example, bpf_d_path can only 
appear in sleepable programs if program type is BPF_PROG_TYPE_LSM,
from 6f100640ca5b ("bpf: Expose bpf_d_path helper to sleepable LSM 
hooks") it looks like the reason is those sleepable lsm programs
provide better context so bpf_d_path won't have potential lock
or other issues. So essentially, bpf_d_path helper itself
won't be a helper causing the prog to sleep, right? If this is
the case, we only assign might_sleepable to the other 4 helpers.
