Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254236381D1
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 00:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKXXob (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 18:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKXXoa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 18:44:30 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799A688F88
        for <bpf@vger.kernel.org>; Thu, 24 Nov 2022 15:44:29 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AOCmkrU001299;
        Thu, 24 Nov 2022 15:44:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=0aKY7IhjXB/tTbX+oW9YjvekCEa9AY91/khN1wyRd2o=;
 b=ivMANQXvO2LDlBakb8x94fz/M3dmvYvs4oVF6lUwj/adND3MzwKJTo7+0DaeFHpjCTFB
 ECOeItBcMsThQS3ZWazsKt6CnrxwSx7bkqEcDuOIo6Dks9j7r4Uzy/V8mAUt6H+YDeoN
 7SmnPxarufa8+4ibg3PTaBMawRY3zEryBSiIazAMcxbrh8rlL8LBe5Z5ezMU8hoqgSBN
 NRERcSaX1FDHaysgwnBFfVHVh58emZ2Fb35iCCtucg5ZB62CCtAqMCmGKWSYmQHhiF3A
 b6E1jj2a0Xjf2LmXnEK5ELEYVS/+OJn0wnJONkD0lPWrSKcul+M1KG4/KiEMnx+6NybO Ow== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m21sx5mjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 15:44:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbVQGPDrS+exGKe5K4uzs5hcywLEebWXyaD42m7J6R2q5J6U4Z5eD0C7UXZCcdfWaT6q5REWpEaNkzvba1cE4uikXt/CBC/Ol3a5cHGPuiE0TdTF9hRIYKIG22htQAxuVQPn+7SV3FwwR9yLvLNkSynalHlTduZKrlquSPTjh6nHym2hB/ZoELphNiwSW+0gT+02dllc8kLe71ozkiOw7uuR5MH/gtJpzVg9v71cdMfDZn5i2dC46i9w2oNor6QA76AdhbwcMWUSH5ShUWjNegYyn/7HY77cR9NsvS+b3qpp+elqAUHGXna4ECLIY7bXniFnuGCTGZWbpJrrYMt+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aKY7IhjXB/tTbX+oW9YjvekCEa9AY91/khN1wyRd2o=;
 b=MHYQ7VWHN75VghOckqUdvMsyIz+LkNgurHEg4UH4/MzHiNOzluloyQXrvJLPlG1IWcyHrym1mb+y467s7x0ZB5iUVgxqonZygsgK+pA7CU5ce4GKzjVRqBMgSFOZbs7ar4KsPDAhrhC1yPG1bDEk8zCJNna708XGS6yTu9vPOSRrTAPH7AFbF14U1CISGOIX2nTh+lixvlzO+L6ovOlQblheWmdbvLvzRFqw5XCbQ8IJCyw7xF3sWnNThzVie/T38e+F93+rodWEH8XWbzWrb8BIZJnbqJqtI/ef/z2RXe7H3mMVIz/qICoYJOCMo1DsTShNK5YBo6mB9fCCl6rv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4846.namprd15.prod.outlook.com (2603:10b6:510:ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 24 Nov
 2022 23:44:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 23:44:11 +0000
Message-ID: <540e410d-0a31-ac74-d258-a636530fd77b@meta.com>
Date:   Thu, 24 Nov 2022 15:44:08 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v10 3/4] bpf: Add kfunc
 bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221124053201.2372298-1-yhs@fb.com>
 <20221124053217.2373910-1-yhs@fb.com>
 <CAADnVQKVm1W0JpSD4YbH+teMVg8EHtR-+DXM-eR--EDHXxYz9Q@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQKVm1W0JpSD4YbH+teMVg8EHtR-+DXM-eR--EDHXxYz9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0045.prod.exchangelabs.com (2603:10b6:a03:94::22)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH0PR15MB4846:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cf9040-4405-404c-ae0a-08dace75c95b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zQNEx9bYTaHO4fnBbZBKuzYACndJgaliRDuo7z0sbMzWJB7CRfYZnOjtLEEKZy6IzobI7iSZo5fobYBLqp75YqXUuD4p2bQE7jmRHEN8IbB9eM+Z2fbmFEqhnpdEKnOlYjyp2rlYeighTWE/YWDVlJY0CTU12drqmjdSYy50/Alsdj7ZD1g6U4kxOXNNFWCL4y5PL/1uOke7/y0pMwgjC+q/ssKEv7Dm8ao63Vowtuvs80uJLRzEzDB7kGqK+FlvrncyBF78/Gq5CZZVJSId9mptZ4KUzlVJirku9thAAgeS7LOSboCgk+6E36Q+SqdwBOPKyjkM8f2Shb5i5aXOhVnIZgTYsKULTzZflDQyUgygHSIMcw332VCr0BMvdem4Bz7HyFcpc4Ucercl9HQ91HDR/41OCohuZ9PRFupWoWyc6UsTiou1DrBuOqzuaHcTgCp25vI6WBd7n4Z02xe9ccW1xg31Yf6tBc2sPJ1HAN/B3I8kGtxkuBipdrpmPcj3xG7qDzLAHouX1eX0sAyJAHKLTeYzQmK2DvZGtPWcBUE16tV9RpS5FfXYHtltnML/mgJzCbx6H4ZO+AWJ/OdowtEbJk2pjBQJxg5E2rnOTPZ5wZshypIdKyTDrXX8GdzfXaJMhk1jb9OFDBzbn3N2ysqD3nyVpRbJqYMK+17yUUcDIPhUdy9cEH7vOFpmmvNHjlmLJ5eiRifpAgT1GQUCA6hc+jjhCP1x9tnJpJWUj7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(31686004)(36756003)(86362001)(31696002)(38100700002)(2906002)(6512007)(54906003)(5660300002)(83380400001)(186003)(8936002)(110136005)(53546011)(2616005)(478600001)(66946007)(6666004)(6486002)(8676002)(316002)(41300700001)(66476007)(66556008)(4326008)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGtYWVZBd1N4WFNiUzY3cEtWc3FEVW96YTUvQzc1UDY3NzRTUStXeFVQUjRE?=
 =?utf-8?B?ZmJPRVYyQlVoMkVyWFFuT01xdnVYZmdSdFdIT1JOZ2VRazJNZnVMRUxkVEo5?=
 =?utf-8?B?VGdRbjhqMm9RNXl4M1NHK2JpSjNacVNuU0JvVkRHQWNaY3NobE1DdURvdklu?=
 =?utf-8?B?SlBCVFA1cE5EOENJKzFJRmw3cUJ0andoWmtGb1JJZWVqSmU2dXBoZjk0Szg0?=
 =?utf-8?B?eVRhOHdaMVRrTEU5d0QzTGR6WFpTKzdNZ0lnOVZDUDZaUUlZSkU0ZUU1WVc1?=
 =?utf-8?B?eGFHNmxqQkUxMXFqcmwzUGYvNHg3bDNyTmlCMzRWVlZiZ3hqMEFvSzhVZmZM?=
 =?utf-8?B?TEFSVzYwdTlyb2MwY0ZpbFA4aWc2d3lTb041Y254Z2NoVjBnRHp5ZkcvbXhp?=
 =?utf-8?B?czBTQVZ6K0FSWGxrMGV6TndzZGIza25xVUNOSzF6VjFRY3d3YlBqaVYxVC9v?=
 =?utf-8?B?R0swMjhQOVl1QVpMR1NQNGlwTThHODVXOVgrU1I5S01MS1c5V0FsSW1YQVQ1?=
 =?utf-8?B?eXBEbVVHOUtFR2RxV2ZoaGllZHNhT2lZK1RmVld1bnJNbjlTeDErVkg3WURJ?=
 =?utf-8?B?Wksvdi9kS212eU4yV2E0Zi84akh5RmpXVU9XR2lNRnpxTGFmS2pXQUtoNTI4?=
 =?utf-8?B?ekgvRmx5V0R2QzhGK2tUbG5XSXN3c0ZpV2V2KzFQWUY4NllRRUM4Q3RYYUxz?=
 =?utf-8?B?cW1GeXg3Zm9RVVFRemtyYzZLOEcwT2p0bTVFVnFXRVNWZmxOYkNmamhnZS8x?=
 =?utf-8?B?T082OEtsTmRCeU56aDhYQ3BkZkJ3VUNONFNNMS8yYmVReTdWL3hEU3pyUVlR?=
 =?utf-8?B?T0JHKzNmM1hRRmxUaFFOMGV2MHBUMCtWVEJkelArNzVia1ZWK1ZIVlNOTGVM?=
 =?utf-8?B?QnlKdzlUR2hSTUowdVVpaHJmeElPamJCNUU1SVZaRGdCbzhwQVJLUDlXeDZn?=
 =?utf-8?B?UHpKOERVN1R1YmhZSlpySUMxNW93VnIybjM5NVdLRWFobG9YNDIzZzBteXl4?=
 =?utf-8?B?MXRUL0p5OWdkdUdHTUNQenhobGlmV1ZmUEZySEJDZmdzYkNpdUU0cExkRGVP?=
 =?utf-8?B?c201WmxBdHJWU1FVTWZGckVsWSsyck5vcWVHZ2J2bFp5U0xmRFN3ckx2T25P?=
 =?utf-8?B?aFNYRUtnSGtKWUx1S04vQjRtK2RVWmNpQzBQTGp1L0wzdk5LKzIrQ014Nmhy?=
 =?utf-8?B?cFdGMXNaRVlJRERlU1lla3gzNjJxSlFnZzR6T3Y3T3JDbi9iQlp5b2hodnVW?=
 =?utf-8?B?OU12N2lpWTFVL01SME9RSktab00ra0VTUXlBSXR6Tm1jMmJWZU9kK0Q1SlRn?=
 =?utf-8?B?bnZuMUxkMm4wamtoQk9qMHRVN1Yya2t5K080RFZsZlJSVTBGTFBTNFBJSXhI?=
 =?utf-8?B?a3YzSVpWTHpoVUc3TGovUDh2enJ6RjB5c0prTXlBM05KV1lJRmRreGdXK1R0?=
 =?utf-8?B?NVZxRnhWaHFwNjJXNEdzKzd2eVVyMXZXZWs2cyszRE1SRXNuUDBqYW13WFBr?=
 =?utf-8?B?bldvTXBraXhIRklPekg5MG9LU2d5QjM3aG1wS0x1YWhlM2wrVyt0ZFkxTytL?=
 =?utf-8?B?emdvV3IrbHQ0K2FoMm1qV3VmMGFJVDVKcDlpeDUwTjU1ZUVBNEZmOGpSNTdR?=
 =?utf-8?B?eW52SzFFM2pMTzk3MnFTVEdvZTJ4eVdseWlKVE9LQVEvSTBWSXhSallRL1p5?=
 =?utf-8?B?SkNrWW1OeE5LTUxVL05EckZNcng5QWx1MUpHa3BHTDlSY3pSUDc0bnExMFdZ?=
 =?utf-8?B?STRPMHY2d09zUzlBcjgvYlM3MGY4bWI2ZnE0cW1BQVFxbWU0VGpzWEk5WmVv?=
 =?utf-8?B?YjQzMzFLUWFHMzBnSlVOeFh1YUtDcmYvOVQ3emNxTGxBQ2x4TmsraEJvQW93?=
 =?utf-8?B?MHlKTDhISEQ3YkRjZ1ExUHlYaG40aVVSUmFscFoxRGNLeWpHWjZLd0xGWnJI?=
 =?utf-8?B?WWQzdHltbXUxRGk0N2hTOUNDQjNJZFluRHM4dmd5OXBmK0lpMjd4T3dNVGV2?=
 =?utf-8?B?UndRMkNLQUZQY3QrZTgyN2l5dVd2VWhULzhzQ2h5a1pPbUF0VEpIUFFzOEZw?=
 =?utf-8?B?bEt0cXAxRzJMVlg1TDJleFNodkl4REczREVvZCtKd2dJbERRZTRweGpMdFRz?=
 =?utf-8?B?bmdNWm1YS01tNE9UTFRHMzBkMGF4R2lXZ29SdFNEVU9rSlBGRldWaXRrdVI3?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cf9040-4405-404c-ae0a-08dace75c95b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 23:44:11.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0yNbCjcA3eDcBdFjUUlMS13PtIwsOdetUVEy5pKqStEqHE64xIQ0NxCkm3Q/dr3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4846
X-Proofpoint-ORIG-GUID: xz-9uy5k-AeVMrUw6A-PhZoD-LeKCd6l
X-Proofpoint-GUID: xz-9uy5k-AeVMrUw6A-PhZoD-LeKCd6l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_14,2022-11-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/24/22 12:34 PM, Alexei Starovoitov wrote:
> On Wed, Nov 23, 2022 at 9:32 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> @@ -16580,6 +16682,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
>>          env->bypass_spec_v1 = bpf_bypass_spec_v1();
>>          env->bypass_spec_v4 = bpf_bypass_spec_v4();
>>          env->bpf_capable = bpf_capable();
>> +       env->rcu_tag_supported =
>> +               btf_find_by_name_kind(btf_vmlinux, "rcu", BTF_KIND_TYPE_TAG) > 0;
> 
> It needs btf_vmlinux != NULL check as well,
> since we error earlier only on IS_ERR(btf_vmlinux).
> btf_vmlinux can be NULL at this point when CONFIG_DEBUG_INFO_BTF is not set.

I checked the code and it looks like btf_find_by_name_kind can handle 
btf_vmlinux = NULL properly. Consider this is a unlikely case so
I did not add btf_vmlinux checking here.

u32 btf_nr_types(const struct btf *btf)
{
         u32 total = 0;

         while (btf) {
                 total += btf->nr_types;
                 btf = btf->base_btf;
         }

         return total;
}

s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind)
{
         const struct btf_type *t;
         const char *tname;
         u32 i, total;

         total = btf_nr_types(btf);
         for (i = 1; i < total; i++) {
                 t = btf_type_by_id(btf, i);
                 if (BTF_INFO_KIND(t->info) != kind)
                         continue;

                 tname = btf_name_by_offset(btf, t->name_off);
                 if (!strcmp(tname, name))
                         return i;
         }

         return -ENOENT;
}

If btf_vmlinux is NULL, then btf_nr_types(...) will return 0, so
btf_find_by_name_kind will return -ENOENT.

Certainly it does not hurt by adding explicit btf_vmlinux checking
before doing btf_find_by_name_kind(...)

> 
> In the previous discussion I thought we agreed to
> fix convert_ctx_accesses() vs incorrect application of
> BPF_PROBE_MEM for PTR_TRUSTED pointers.
> But I didn't find it in this patch.
> So I'm fixing both issues and planning to apply after testing.

Thanks. I didn't do that since it is not really related to
bpf_rcu_read_lock(). I plan to do it as a followup. But
saw you just fixed the issue.
