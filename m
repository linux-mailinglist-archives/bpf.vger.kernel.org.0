Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5568460348F
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 23:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiJRVDA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 17:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiJRVC4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 17:02:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F35EC589D
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 14:02:43 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IKLTic013223;
        Tue, 18 Oct 2022 14:02:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=f0S5kfDnxYlBfKI+jwv/w52NeUpH7etXYz/1rT71z80=;
 b=aBvjwj2lcg85hIxDwBUCo7BC1EtrSuRf2JDFJg65QRQTOKxLLKvyyR72Y8F95snoEEtv
 58YYB/olbCgPoSaU4sEMNysX3YvBFE4rYVRgceFr6xuuuIbgOp8ffCtu6X0i71MYoto6
 ANjyZ05hhsfNl5Pnb+x1kgqH4mIcdSNstkn1JZUbvNV4YJFeb3gdI/HMpOh+zzgp0TLX
 c5nY0T5LymwuajEYFvbwp9uAAQ/MjCiS08vMuIsx1ee+sczfi+yMzbM2ITDoBASnsK2n
 /sWQMuOdL6SXBxgN7zlkmXI3ADdqc0ytCL1GFgSb4Wee0Lp2oDYRP6TSutAGQBUGALBw Cw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k99av8set-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 14:02:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKGiufqeAZe1VhG/m7WZoklrj6j2YVw321aGWudUoOyhmtyBRsjU9FdfTSdoDJpkBcWz3lMzoX1DX01lminaDsOeQx1FBOi5Ro4N79q5TI+HTqO+Fi4jEg5MFoVhc5TNZ58jMhiFYrk1oeAjUVeUOJFYU9lEEhhCOYIT3bEQ63rY+AvL5BkJYKtjQKQsGq894n11APJjj9AJWrxKWA0/FPK7DpfDUgWkctqRqqoYCMbSHF5EB+M51k8L3rN5NGb7ESh/ON+6EZgKNa3zlD9rSCZ9pr4Yaq4IXuuBveFDnCLXrpghiujqy5FfQe7XPtcTm/YHOBzycZ4CRx4YY6Zwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0S5kfDnxYlBfKI+jwv/w52NeUpH7etXYz/1rT71z80=;
 b=m9xChHlZHM13HFFBrcjsI2iGEers3QVfaYTks1uZCvEsrhFg9zfqN/cvDxQNbn2GE94cr+wc89DnPDfm5b4s3308raRWzgWKflzpl958NnSHrNWtJ2wTEthoBB2Gz70S+XHeyHIoTGIH1/eND5oq56v9SMfX1ob5tdYQ3KfDeIS0CQkIyryBmIDiHHdW7qOyRlFCV4AmUQs3eqVKScK4CXSusjhyzExf8tdRoSrq5oxfxzo8iN/eTERumhy1zWLldvVYm763SAXiita/K2m31Fi7EyXMqkAzHUo74nkH57vwTMyPfO/BqWALxsHhYheVhaWWGVzTEF8zn8pjYoKjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BLAPR15MB3906.namprd15.prod.outlook.com (2603:10b6:208:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 21:02:22 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 21:02:22 +0000
Message-ID: <7a7407d3-3ff0-4fea-2ea2-39ffda606138@meta.com>
Date:   Tue, 18 Oct 2022 17:02:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 3/3] libbpf: add non-mmapable data section
 selftest
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20221018035646.1294873-1-andrii@kernel.org>
 <20221018035646.1294873-4-andrii@kernel.org>
 <dae252af-70a2-bd8c-77cf-58492747c4e6@meta.com>
In-Reply-To: <dae252af-70a2-bd8c-77cf-58492747c4e6@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:208:d4::19) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BLAPR15MB3906:EE_
X-MS-Office365-Filtering-Correlation-Id: 0274631f-9e6d-4387-5718-08dab14c0d2c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2mJ82wVJY2oXBRd+hCq0bWl9askVv1fp+0LgLArxUiB4s0GxFwupKLA/bVK8gtB9msWz7Ltu2wHhglC/FSeDElLuO7FBtAw6Gsld18Fx63e3tKjjtGdUjR0uy5QroRBXODPPO0Vorowszr8ajUp2UWSgGS5tz5CYD+LpFWcQFS01ZJzpcrXULUKi6ahMcWdyFU/piYY+zJWcYwYPMfZQtdwPbtmd4osZYeDB1tps+zyQJ8T+I8gIv8rAhJqxDanHP5p/Zij0D5VL1KJdn2sK3Pk3eO8h1C0qGjGWcygGhe0UO55Ln2erez8j6JhlZGAylTwYa/saHjhXO4lY9h5dIij4rcvTMgJFVnRjzsXw93rQ+enh5OBq4Qev3VHea7y/ygA58K5iOw+4QLYbEHmwETqdFjYauTXbdKuCtR9Lp2skPLiivSgi/VKLWMbkAdGhv1y+UQrIqzsjrh1dfDeurc23xUJ4DviYcyuX0eSmycCSNv4dbb1tld0KejPDeDoOhjOfYud1eWxCWLBbLIy8HOHK/4ZlmqzQCfivFuuHgaaiqkLC229mpXrocppm93JhPTLNSG2DAgZObAfyp2W2ca5HOpJIxrqCg0A+Ro0f5hHNyQQyFoKTutkaCI/BUOdoRmL+POhgcBq1PM66e0DDPxyte9HJnGXVyBWEyvAn+F30O++sl0QHq35a0eh3zpidlyb27lSrcI0wlNmSYxceBHpO4UPJJ5I9LuUWiWnbb+LerVqBX+2thsXmAu758pMMyhb2PrSWFoLRbLe9TQh6Yh7BZP3vk5ve0enfcDGINM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199015)(38100700002)(6486002)(478600001)(36756003)(6506007)(41300700001)(2906002)(53546011)(2616005)(186003)(316002)(66476007)(86362001)(8676002)(4326008)(66946007)(31686004)(66556008)(6512007)(5660300002)(8936002)(31696002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEExWFp6Rzd5L2doN2RqRDVYWWxsMlpLanpMY2pJTXRVUlh1dms2a1habWUy?=
 =?utf-8?B?MjNKem92cTlkakpVYU9RUlk4Z3VpQk9LbW5yWlhTM1BNQ1VrRlpzRHhPMFgw?=
 =?utf-8?B?VkQ2dHlSV25mME1ZckUxL2FYbmZkYjBJV05RcmlHcjNURDkyN0JFK2ZweFV3?=
 =?utf-8?B?S3VYcXQzMG54QjR1dHpDMDNob24ySGdyVm9SL3pqdUg3QXdpNDQwcW1PLzBY?=
 =?utf-8?B?QXNWNkI5OUk2QzJnSEZUamhxeTJOdGZnTmhrRFphS213ODlvTTZST1BjZWZ3?=
 =?utf-8?B?SEVlK2xGWEdIbEM5cUVUZ3NPU00vTHBjeE9aSHVOakxCMkc4R1U2Q3dYQ0Mx?=
 =?utf-8?B?VGxLYSthRS95N0IzaEVJNTRkOExiZGN1UlBnZkhMY0lwL212TjQva3hmV1R6?=
 =?utf-8?B?NkNrZ25qckIrYTRiYkFpVzdpYmg3dW5FU0V4SHZ4cm4zS0ZnUzZFUXhUUGtS?=
 =?utf-8?B?dmUxcEM2anVDR3habG1qa1dWL2pLcFBycFJhMVJXUnZqa0xQQ1JGM2t1YkI5?=
 =?utf-8?B?VDFWRWpHMWR2TGl4NUh6bGM2UEtKczBOQ0J0K3RidzNzbnkvelRjWitYWHVh?=
 =?utf-8?B?M2k2ekhIeHRmZWROZ1pFd3RNSE9xWEh5UTY0ZEE2dWtWQ1JCUGVhSENsbm1h?=
 =?utf-8?B?UnZhSFBMUWpMQjFYOVlYUzUyTUNsbEZMTmFHYVBDcTJweWRkWEhTNUE0RHZs?=
 =?utf-8?B?SFdtNXY3akZXRTFBTmZvb1pCTHM5d05mVXpTVDUvQit5T3dpZUk2YnFQNCtI?=
 =?utf-8?B?Nk00SldYRS84b3dRTnhsNkxEcnFRdCtvUG1uVytRUnNJVFhGL1pFMG1NbFV5?=
 =?utf-8?B?VTd1SitZTUM2UzJJMFNqdEhQWjkyVTRxNVFrcmNtdWFlaHBmbmxCOHpNRyta?=
 =?utf-8?B?NFUvdFZHL0RyaU51NHRFT0lWb1NOaGhYeUtCc3dyWjdsNUlFa0RQT0Q2ZnU0?=
 =?utf-8?B?TWFmS0t6S04rZTB1YlVXTVR2OU1nWHc5Tk5jOG9WaERpS2V5YS9qbEN1VGZs?=
 =?utf-8?B?UEx5ZDV6U3JrNEFiNmNzR1JFRVlCWEIzczgyVVR6N1lKV0IzNnIzbHdxVFpq?=
 =?utf-8?B?OEtXempKaUYwMTk1dC9Ed2RCeG04YmNxaGNhcXlhYnpycXlmODFzVXo4bExX?=
 =?utf-8?B?c3daYksrV2hWalRWSUk3Um4xMEErQ3FtLzRUOGZaSjluRHNXNVVGTSs0TXBU?=
 =?utf-8?B?NnJXcUF1d05iUXdpQzRZMjc3YSsxeUxmQUorY1BVMTlXSndieU1ObjdJZVpF?=
 =?utf-8?B?bkQwZ0QrWEIvWWYwQ3JyZkd3RkxmZE1iYXEvUVBhYjNxRE1WVWpRTUFkZDEx?=
 =?utf-8?B?ZDFwWXhhc3ExVm1FSE85Q25xaDQ1SXplQ1o5QytrdkREWXlYRndLeU1yTjF3?=
 =?utf-8?B?dHNRR3BNcTNPb3Z6cVhkdUx6L2k2UFk2N0dkTUFBRkpzYlJ2WkRLTGNkbytx?=
 =?utf-8?B?eXpQYmFyeW15azAzUXVBdGxDTVVlaDdFdHlZUEF3SHpoSzVSbUZ6Z3NqSlQz?=
 =?utf-8?B?RGl0cldNWXNFVVFlVGZZd2M0M2tMaGNNanV1Si82NWRGOWJJRjByUWdOcXBz?=
 =?utf-8?B?QWU2SUxlcG1HaVFZVm55REd6RDNORDhSUTc5OURaNVF0UW5CdnJKT2pDUTFQ?=
 =?utf-8?B?SnEzUVp5WWxBVHFnOTlpUGhkYWdtY2Jmb0hIU1RybVJhd3grSmdFb0xkMlVY?=
 =?utf-8?B?N2J4VktYNDZadEhuc21udi9pYlF3YkNtMWZtZmpFWnNKU0FCRS9QNUUxeHpm?=
 =?utf-8?B?NjhzREZHUWJBWFJQWGxBeEtVK0laUlF2d1FqbXh1SkFWbWdnMmlsT3B4MDNr?=
 =?utf-8?B?QS9tOVozUGdrSUlKVzJTT0tLMUpBaFpBalZaaytJaDhoQjBNZzV4eXR5WkFx?=
 =?utf-8?B?L2FCWmRwUVNPSlIxbGNmek9nMHZ2YkpkRUg1VXhTcjV5RVZTdDRZM285N2N4?=
 =?utf-8?B?S29SOHZvaU56UHRuMDBxRTRpR2tRWWtLa3JMd1hCNEhKRGFPc1JFSUE5VllE?=
 =?utf-8?B?NVdRY0E3WkR4bDZyVVBpTkpXVEpva2svdnhtYzRYUjdMbjBnSUNmZEwvYm10?=
 =?utf-8?B?REo1cjhCNG9ZMVBvQUJpcC9aL3VlaEdUdEZpSHMycTQ3VGR1aXFlWTdWWEIw?=
 =?utf-8?B?TFhuYldEbE1KSzVCOGNTcDg0SzhBNFFJRVRXcm9zRldNdTFkbUZVSHhyTnJo?=
 =?utf-8?B?ZldRR0xlWGkydER2OHVxY09WYzNpdzdtNms2SmRnVFQ5RHNtVDlNaS9PQjBu?=
 =?utf-8?B?MWJoa21zbjRHNkpZWFc0cXI4VkpRPT0=?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0274631f-9e6d-4387-5718-08dab14c0d2c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 21:02:22.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ztlquSuLx+Au5b3OkT9eNFPpdRoYrQVnudRLoHJMPE9YbjqbzLwsPItV6CPRau3gHb9gkF7+q1ApRvq5Ny6S/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3906
X-Proofpoint-GUID: RyCnENhDg2KDqPMRVveT9opkapitLW01
X-Proofpoint-ORIG-GUID: RyCnENhDg2KDqPMRVveT9opkapitLW01
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_07,2022-10-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/18/22 4:56 PM, Dave Marchevsky wrote:
> On 10/17/22 11:56 PM, Andrii Nakryiko wrote:
>> Add non-mmapable data section to test_skeleton selftest and make sure it
>> really isn't mmapable by trying to mmap() it anyways.
>>
>> Also make sure that libbpf doesn't report BPF_F_MMAPABLE flag to users.
>>
>> Additional, some more manual testing was performed that this feature
>> works as intended.
>>
>> Looking at created map through bpftool shows that flags passed to kernel are
>> indeed zero:
>>
>>   $ bpftool map show
>>   ...
>>   1782: array  name .data.non_mmapa  flags 0x0
>>           key 4B  value 16B  max_entries 1  memlock 4096B
>>           btf_id 1169
>>           pids test_progs(8311)
>>   ...
>>
>> Checking BTF uploaded to kernel for this map shows that zero_key and
>> zero_value are indeed marked as static, even though zero_key is actually
>> original global (but STV_HIDDEN) variable:
>>
>>   $ bpftool btf dump id 1169
>>   ...
>>   [51] VAR 'zero_key' type_id=2, linkage=static
>>   [52] VAR 'zero_value' type_id=7, linkage=static
>>   ...
>>   [62] DATASEC '.data.non_mmapable' size=16 vlen=2
>>           type_id=51 offset=0 size=4 (VAR 'zero_key')
>>           type_id=52 offset=4 size=12 (VAR 'zero_value')
>>   ...
>>
>> And original BTF does have zero_key marked as linkage=global:
>>
>>   $ bpftool btf dump file test_skeleton.bpf.linked3.o
>>   ...
>>   [51] VAR 'zero_key' type_id=2, linkage=global
>>   [52] VAR 'zero_value' type_id=7, linkage=static
>>   ...
>>   [62] DATASEC '.data.non_mmapable' size=16 vlen=2
>>           type_id=51 offset=0 size=4 (VAR 'zero_key')
>>           type_id=52 offset=4 size=12 (VAR 'zero_value')
>>
>> Bpftool didn't require any changes at all because it checks whether internal
>> map is mmapable already, but just to double-check generated skeleton, we
>> see that .data.non_mmapable neither sets mmaped pointer nor has
>> a corresponding field in the skeleton:
>>
>>   $ grep non_mmapable test_skeleton.skel.h
>>                   struct bpf_map *data_non_mmapable;
>>           s->maps[7].name = ".data.non_mmapable";
>>           s->maps[7].map = &obj->maps.data_non_mmapable;
>>
>> But .data.read_mostly has all of those things:
>>
>>   $ grep read_mostly test_skeleton.skel.h
>>                   struct bpf_map *data_read_mostly;
>>           struct test_skeleton__data_read_mostly {
>>                   int read_mostly_var;
>>           } *data_read_mostly;
>>           s->maps[6].name = ".data.read_mostly";
>>           s->maps[6].map = &obj->maps.data_read_mostly;
>>           s->maps[6].mmaped = (void **)&obj->data_read_mostly;
>>           _Static_assert(sizeof(s->data_read_mostly->read_mostly_var) == 4, "unexpected size of 'read_mostly_var'");
>>
>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>> ---
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Bah, I meant

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
