Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9144398B
	for <lists+bpf@lfdr.de>; Wed,  3 Nov 2021 00:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhKBXX6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Nov 2021 19:23:58 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229900AbhKBXX5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 2 Nov 2021 19:23:57 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A2LbIBh019388;
        Tue, 2 Nov 2021 16:21:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=bGzR1gUa6KzO0KWmOIMOl/JtHCaTJ4i2KIaEzqx2HO0=;
 b=liV1+aZfDPOKv5DSbRfxBGUl5D7zJWHI4WzAiewzKQIK292+fIoQjXlc6PsXTbwUXKLE
 8FMQ7+6zyR/oVL4w2tR5sv4l7LvMVbmiY4LteqNLM1zVLyazJt9T2bJPRdC72O3BgwR1
 BoUocXMzrTSG8eKlOAEsqU45pqJj7yXPXFw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c3ddc8q4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 02 Nov 2021 16:21:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 2 Nov 2021 16:21:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9rzZHRAfRi6JVFCvvynqsR+I8B1sqCPLCNa6YRHgPFLSTUjXo3cPMQq9npkRz2IO+Vvbc2EIA+GxCQXiurE7+04i995DCroydhJd1h4fl1nS9ZXC/SnHC24a03Nnvr5UNPbhXTFxr3anVFur/OOYGqXb+QcQxnNGwHUTafck71IziQosHmaB077v6jH9kr+PcfjmxrkQIqCRQ9EvnLRkJXNLC19YAskL+76Wn8gyCCOOrNML50X3Bm1RcBrkmDhesbsLgzjqjngpc4BZ0o9P/QxwCuipmw97XnyvhFiEVVQ62rsm2N9gzbn9cg3wi276GIjeYQDUz8RT16NWtbHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGzR1gUa6KzO0KWmOIMOl/JtHCaTJ4i2KIaEzqx2HO0=;
 b=EmFkmzHuMNxWHa3xyMg3rZJUe0MOYRDERRWcLaN/tm350tSN4e+NJc/6upesB1v/+N0NkTpId0CAWDnJiVO/0Vu4+R4UD4ZUSe+oUFKYxcM+5+dfA56MG7sKalPMVX1PN8DmmkVu75063Itdp74OaHVOML2LJbbEYgCWshJQxGRemWe1mueIKpuJD7YDemDgVOrkf5m0fD6Grx+QNpZgRP5neNazHt3ckap5TrNC3D4eNG1wZW4FeCBlS9+2dXiaY5MiYy03H8N5EhllXSChqm2E/FyisUHXrRqkqDm4wO9CAmW8rxRurGZrW+qdiel4dfIjpOjjCsrQG2toFi8gPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 23:21:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 23:21:06 +0000
Message-ID: <b0eac86f-10ba-7fde-2fbf-3ba742dff858@fb.com>
Date:   Tue, 2 Nov 2021 16:21:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.2.1
Subject: Re: [PATCH dwarves 2/2] btf_encoder: generate BTF_KIND_DECL_TAGs for
 typedef btf_decl_tag attributes
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20211027230822.2465100-1-yhs@fb.com>
 <20211027230834.2466282-1-yhs@fb.com>
 <CAEf4BzaOuwJtLkEhLcnN4_GjG+qVBUF63ywPkAsZdC2FjxmJuQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaOuwJtLkEhLcnN4_GjG+qVBUF63ywPkAsZdC2FjxmJuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:300:95::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c085:21e8::198e] (2620:10d:c090:400::5:deca) by MWHPR13CA0039.namprd13.prod.outlook.com (2603:10b6:300:95::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.4 via Frontend Transport; Tue, 2 Nov 2021 23:21:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99de15f1-215d-4ff0-b402-08d99e57723e
X-MS-TrafficTypeDiagnostic: SA0PR15MB4062:
X-Microsoft-Antispam-PRVS: <SA0PR15MB4062143D027EF9073DBE9770D38B9@SA0PR15MB4062.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cufJPqOYlfPLKU5cCFJS5vGYX0XhWbKlfXe5Jo3TO1NO5xdOLkN4+CU55gEpMym3j7HMhzEf7Yz51GT/KR6lcGEYVh72VaoatyfR3rS4fucA1aoEED66miBIr0FDFaoz/nyc/CfkOPNch9Cr4viRbEeWUoLDN68XO113UaxKeKP4U+DCIIfpgaS/PR3HZSBxUJXLnxrUyw3XbHtp0Jq9DLjJiV3RSJJcz01CSsWjg7Vcbpj4KU498ieLrBdrFneWU3fdetT0RkLaWptGxxcThly2XsVBBajWMmG/qixshP/Bq5EVMmYFEQWLmQmT+nKC6JzPcBMWWPgD6RgRo1CW/3kSX7gB4fGAuOzwFcAXfm7fVzujTCOZmFtdsRMdCFpmAngWFQocy+ApCDXw1nqbJP9naNu72zvWCLEi/LQ121LOLQRzOhuPBNMbL1HTTuu4Cag2h1YPJZLY603ekqhGqNA5xwonP+VlfGZrB/0k4lwooiT13WEUUVZ9Dj2RcfZh/+eeDci/bb8DZyG4dgXVESRMxGF8M/g9Z8zAvaL/Mkhho5jF/gG84yJXCS1KLRPVZ6fWL7/+YLKMGoKpMrZW23ImqsxDanW73ULODxzolTgaJ+zJZkb+vKuhDnb/5CLtD5W2HXzGjQm/Tzrk73j4l6b13a8dpwgo1f1gClRBf9s8l+UpHTmR7zUOYHj8cNPg68LtdWof0Cyn6dss/lTCnn7c+Gq1DqbQgWEvNwqH5qhIfuo+L+R1CwONKtmeWnJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(36756003)(2616005)(6486002)(53546011)(66946007)(5660300002)(52116002)(38100700002)(83380400001)(8936002)(8676002)(316002)(31686004)(186003)(6916009)(2906002)(31696002)(508600001)(4326008)(86362001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xEcjFLWWp1OVJaRjFlcWsrcjZkbDdLK3o2Z0tPQVByamJQQ3hPWTJyL3JC?=
 =?utf-8?B?TDh2Y1pNOUs2d0xrUFIzRFRFSDM5OGhmRFV0bUN1Z09TZHYwNzg1Yk02M2Jy?=
 =?utf-8?B?d252QytLazNrN2YwdHpYbXRpSXlIaVV1OEh4c3RicmJ2S3ZpZFk0Nmc4eXhy?=
 =?utf-8?B?NWFWTWJ4a0pXSXU2dHpjS3RkTUk3azFUbnlvbFlsbWJxNHljVWVUOTdSZTk1?=
 =?utf-8?B?aUVweVN2bThLUFV4VHlOd1VFblJsMjBwZGs5WnI5Q0IvVzV4VnJKbXVrdjAr?=
 =?utf-8?B?dFFKNkpqTldiaHRBbC83Y2w3czZUOU04dUNFSDVTcWxKeWM0TnlxblJxMFhH?=
 =?utf-8?B?VUdxaHRxVzhYUlRRUjlSa0ZyVDhPYUVIejMrTXJxVFNUZnNKdlYrT3VuZWtC?=
 =?utf-8?B?UDhCSyt5VzhBd2YveWJZeUFsaGFkWFlQRnRMdE1xdFdVeG9PcURiUy9yNktW?=
 =?utf-8?B?QjdTNUdGZTNRV0FCVHFrMDYwN3YwUlN4cDVMK3lHVmpGazBydU5oZlo3bUpw?=
 =?utf-8?B?cDlUZ0xydWtkdEtVZVd5MnhpUzJERDFubUQ0SEs3b0ZqbXVrV0lFMms5TkIv?=
 =?utf-8?B?c3pkNVdOSWp6Q3VYbVZZNlNRRXl0VmRKMDNNbmI0YTlVNk5pR0N3N25IcXAz?=
 =?utf-8?B?UWF4bXpGaGVXQVdmZnJaeHV3YWRBN2ZGc1p4OVVCUW5jTjFhS04rRFREMjNt?=
 =?utf-8?B?ZDM2RVF4aGQ2eXVUTE9GZGI2ZUUvTlRuU2lrZDAyc1JpR0VVUGZJZWREaklw?=
 =?utf-8?B?TjlaSXNZSFJMejUzck11dXlNNmV4aDN5NUl3b3FyUDVlc3p5cnVaeDJCNDZ3?=
 =?utf-8?B?WHUra3FOcHJIR1hSWnpDUU9sVThxcWlhUWR4TWovU1RkY3lHbVBnSkFBeVM0?=
 =?utf-8?B?WS8ybGNUcWRVUEFkdFNGU0J4ZHNhZ3ZlOGUzTUZEZXA4VERocDJUa2VqWlNr?=
 =?utf-8?B?a0dkRVRQdUtBMlVQSkFpRWtsN1QvdGsyU3FUMkVxaHFQSzQwQmhpcDFscW51?=
 =?utf-8?B?YjVHU1lMMmxFd1dVY0R0ZnR3a1JFaWtFRkVjQVltNkxPT0l2aWlpd1R6ZGRL?=
 =?utf-8?B?SXV4bldoVDBuTlVFdXphcjA3ZmVVRGhkd1p5RHBmQlBNTll4MEs1eVJFS21y?=
 =?utf-8?B?VEZVMGFZcm5tZUc3WlA4dldtU2ZMaDRtRUpjNlAySzZNaUplYXExYnFBNW5y?=
 =?utf-8?B?ZlpuSjJoU0FNTUdKdHVXRzQ2UElMMllTMjZFRW1EMVQ0TFNDeldsNjRBb21W?=
 =?utf-8?B?QUtocTJaVlJhc25nL2tIR3VTQlN1Kzkyb21QbXNoV3RTSm9VVGpjeTFFRnho?=
 =?utf-8?B?dUpHZmkvTk5Vd2VwN0kvblFsNVVnSWhWbW9FK2hJdHdLdnp5N3kwam5vN3da?=
 =?utf-8?B?Tnp3TUErbDVxbEJOcmhjOXZkbExFQ0J4QWZFejUzcXh1RHlXeDhIL2o0M1lW?=
 =?utf-8?B?MElYaWJGckpVTDFFR2JEMExiczdqcTNTQVltL1YwRWZyYTR2Z2p3UklZUGND?=
 =?utf-8?B?UW9Ya1o0QW80M2wrMlFYY2p6WnJKY3Z1YVVuRHBrdlRsNlhadUc3R0V3SkM5?=
 =?utf-8?B?Z2c3dDRjOUJOWk52NmZmS25kUHFMRmtLMmJuMUdIWVZUMkVmNGp2anRTM3Jo?=
 =?utf-8?B?Q3JXTVZuVVpaSER2SXY2OFl3OE5CNUx1SkM5K0F1c1Y1RncyU3NCOHg3ZlAv?=
 =?utf-8?B?clpTWnJtajdJb0hRUVRHNUg1YjNVdzhIb1MreVZpVlhyTWN4WFdFeThoWjUr?=
 =?utf-8?B?cWRERU9mWkxQR1ExM01Fekk4emlTMHZRSEJpam42aUFxR3hJcEtSQWNMcDMx?=
 =?utf-8?B?TmVvZ3dRSUpYc0tkb0w3YmdvNWJjbExFbUpZYnc0aEdmdFI1N0JIL2M5dUVN?=
 =?utf-8?B?WHZIajArYkx3dkRTRHNaMC9qREs5V3lkTUxiVVUxOVo1ZUxIVm45eHV2eGl4?=
 =?utf-8?B?U29vU2RKdEF2RFQ4MnpIVVFiUitRcURjWjFwYjhRbldVNlpoWjB5QkFhSlZo?=
 =?utf-8?B?SzdRYW9RSFY3RTg3Rk5NUEc3R2thTnVGYVdsYW81anI4QmFDSHVKOFZIUGhk?=
 =?utf-8?B?eFgvNGVRUExjUlBZMm50U015TW9sOTdUNlJPWEZzVGZnR3kvVDcveW9XOUNV?=
 =?utf-8?B?b2pFNXVWM04wTklFZlFTSWtPNzA0RVdYQ3dITlMzbWpsdTBXa20zY3IrclpJ?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99de15f1-215d-4ff0-b402-08d99e57723e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 23:21:06.6860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Krxw5fGuMHsm18GKG+Lr2Nb1BXWEKX67Yx87yZAyamfC1FmSGk5Yhs5//l+0T99
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: doM2ALpex7xBmiRlIhhRSc6pL18R2hVI
X-Proofpoint-GUID: doM2ALpex7xBmiRlIhhRSc6pL18R2hVI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-02_08,2021-11-02_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111020121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/1/21 7:58 PM, Andrii Nakryiko wrote:
> On Wed, Oct 27, 2021 at 4:08 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Emit BTF BTF_KIND_DECL_TAGs for btf_decl_tag attributes attached to
>> typedef declarations. The following is a simple example:
>>    $ cat t.c
>>      #define __tag1 __attribute__((btf_decl_tag("tag1")))
>>      #define __tag2 __attribute__((btf_decl_tag("tag2")))
>>      typedef struct { int a; int b; } __t __tag1 __tag2;
>>      __t g;
>>    $ clang -O2 -g -c t.c
>>    $ pahole -JV t.o
>>      btf_encoder__new: 't.o' doesn't have '.data..percpu' section
>>      Found 0 per-CPU variables!
>>      File t.o:
>>      [1] TYPEDEF __t type_id=2
>>      [2] STRUCT (anon) size=8
>>              a type_id=3 bits_offset=0
>>              b type_id=3 bits_offset=32
>>      [3] INT int size=4 nr_bits=32 encoding=SIGNED
>>      [4] DECL_TAG tag1 type_id=1 component_idx=-1
>>      [5] DECL_TAG tag2 type_id=1 component_idx=-1
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   btf_encoder.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index 40f6aa3..2f1f4ae 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -1437,19 +1437,25 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu)
>>          }
>>
>>          cu__for_each_type(cu, core_id, pos) {
>> +               const char *tag_name = "typedef";
>>                  struct namespace *ns;
>>
>> -               if (pos->tag != DW_TAG_structure_type && pos->tag != DW_TAG_union_type)
>> +               if (pos->tag != DW_TAG_structure_type && pos->tag != DW_TAG_union_type &&
>> +                   pos->tag != DW_TAG_typedef)
>>                          continue;
>>
>> +               if (pos->tag == DW_TAG_structure_type)
>> +                       tag_name = "struct";
>> +               else if (pos->tag == DW_TAG_union_type)
>> +                       tag_name = "union";
> 
> nit: switch instead of these two related sets of if/else blocks would be cleaner

Sure. Will make the change in v2.

> 
> 
>> +
>>                  btf_type_id = type_id_off + core_id;
>>                  ns = tag__namespace(pos);
>>                  list_for_each_entry(annot, &ns->annots, node) {
>>                          tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_type_id, annot->component_idx);
>>                          if (tag_type_id < 0) {
>>                                  fprintf(stderr, "error: failed to encode tag '%s' to %s '%s' with component_idx %d\n",
>> -                                       annot->value, pos->tag == DW_TAG_structure_type ? "struct" : "union",
>> -                                       namespace__name(ns), annot->component_idx);
>> +                                       annot->value, tag_name, namespace__name(ns), annot->component_idx);
>>                                  goto out;
>>                          }
>>                  }
>> --
>> 2.30.2
>>
