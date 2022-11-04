Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC8E61908F
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 06:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiKDF5Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 01:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbiKDF5C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 01:57:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145463A4
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 22:57:01 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NKf0P024848;
        Thu, 3 Nov 2022 22:56:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HFU0IVBg5/VpoOD4VPhL+GbBNFOdfKDp7syLFJL4Kx4=;
 b=D2z2UKZU82PsC/tlfdWH65Y0M1hqTEcL+2ja2zel6zD4i9bFBOBHC3HYzj//Y4FdCiai
 BtfOuxLTI6kPHVM51NU2zBfUPKcITN0h5tvnPzAYyxWl+D0g0yn+TqCPkJQByuwE2rHQ
 ZtTr3hVj/FCS5WLGe2c9kjtBav9XwJhld1IZBBN6ulQY1t3RnGm8emBsY+H+k8/zdPyA
 WDqRFjn34squq0pi68TRU1t+fd3OdcB+UcsyWnbZlAbSnUiNeHnQ2qSS2tUU3Ck4vxNC
 wGAkJtSdQ3T9QaHiutZzlswvWk/+dvJJjP/tYVWbNXTaChJ1nikMaM4EqTehpcUxRaon 8A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmpgktt30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 22:56:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZIO112jcevlRzK1+GE0fypNv8hvjHxe1lbTPFJdo/92dpI+Dq8vGCCQiPvp5IlPD3jP1BPzJxM7elgZO3r2uviG0pIxD+pT9iQwcdJKGVOx2kS53s58wgDMRAvFFKcbyVPnDWK4/OXbUUnNNgG9Q5au/SOwNVm/aEdXiIQ7/LMXcHCyVjnYJy0BktmvMFixnQHfZGNn3Cr2vzAb8QjkSmse8HSDaFydfNjnvVHkJydOgBbdhY1vliVptVjpc0/oCse/kUuz3IvH85fSRhYlomcuQuMW+LkLHIc07pJNqY2bDblBJNxueOtVLL1+HIWcKSS8zhYFMf9RAqENEiQ85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFU0IVBg5/VpoOD4VPhL+GbBNFOdfKDp7syLFJL4Kx4=;
 b=O/6nxPj8m1koc8EML9QVCIIaLMna6GBaYXwWgETsGxHWviSe9EuK6YR1D0oD7FIYxgiHpxUzxB3AhqPzLD851WeaXNsI8/NXMFeo/oNEy6gTfm3ow3Bund+rZScNAl9Pa/GXbhxzyPNJtq+ikcVR04etMwMf4CpTuv2Rt0VAx4psyEQ2tHWNcrdNx/ajduRRM8L5efZLXEyKPsWfLHVDtakOXJiOS+yuugm5saPNfm0GB4qtYwbn2DcFECA9+0cTkeSl0GK0VMtK+bJF9k/5+cSDW3QssKIPp2DU7OTxiZUMegOsUqUdLTYihy0GrTQstOPI2w4uM6V7WU4XiSYMPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MWHPR15MB1598.namprd15.prod.outlook.com (2603:10b6:300:bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 05:56:43 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be%6]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 05:56:43 +0000
Message-ID: <d3765c8e-3b1b-3ea4-8612-34b8580bc892@meta.com>
Date:   Fri, 4 Nov 2022 01:56:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4 22/24] bpf: Introduce single ownership BPF
 linked list API
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-23-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221103191013.1236066-23-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|MWHPR15MB1598:EE_
X-MS-Office365-Filtering-Correlation-Id: f7e4b634-63eb-4fd5-5293-08dabe2959a7
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZyTdvizuVouaxsk8VMtJ5AHcWLZ4xGOXyjwZ3Ijw4vaTFzs0HLWHzi/Gd4Z5dfl6aedMIrOy8v1v7KU+45b/BL1nacYW6RmLMhFdoD1eCii8FTYXdRrN81lvmFsEOK8fhdcQMa+JbTRXNenKYh1J9qFZAxTbG/7TTFs66f6115isvtHANZtDaSDOjA8sJ4eg9WxjCK5cpP2Nel9faB3r7JGrOb7oq/1gVpyLUVCg7kBk9GDApNqdnFm/WuDg1wBv3Eh5t9S/h05JX3z9E18hSocuMjZ6Nwz82VJxgP8EFgh8PdyWI6kxsX+MLM/8fhr0NGr1qntE85yk1GZ1NCbb4kt5kEh50Lf12Bnpti2yk1TWdAZfXAdt+a3yv2+gGzB4M3fdX6pwXU/kHAqN0XVWmhls4H0sML8hWMrwNXS3EHxEHZzs/7V+3/39ZLairWK9N/tgbHgHw7XXjnq38yR3Oo1VLmvS8+3EbBNQM70JpHnj8zlSY91YXc1bZkDK7mF7cW2Obr4YWQ9C7E8CbE+akCQusxvwrQlr5FP+0FnHT4WogMoM+q7KJK7ZS6Jx1thAjK4ObQ+4Di3X+8XjqF4KbCPDKX6/7OvAzZP60meIk3EN+PQWFAta7luI3u4z29SkY/FLf1cHtT8nC0e8Q+6aRiP9g31IVnAl4N+IrfrsFgxeAvwERldO323YENAWOchV1yZj3omiq7dtUMudRIq+3J1tbRsx8HydT7+HtY1+q6mceM+Uw718Aa6zSrD8Wr6fHnowfwPv9yy9csRAxPqQndhTuR+SB+t8QfwN9w3x9306T6l97dYnVAyS0SYGwvt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(478600001)(966005)(4326008)(6486002)(66556008)(66946007)(66476007)(2906002)(6512007)(186003)(41300700001)(53546011)(8936002)(8676002)(6506007)(36756003)(86362001)(83380400001)(107886003)(54906003)(6666004)(5660300002)(316002)(31686004)(31696002)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azhNejQ3ZzZXRkppUXdVb0NVSWNNWEJYK2NTb0RxOFNCSVVMSHdJeGNsMGNL?=
 =?utf-8?B?UkdLRjRpSHNxV3pMdjdRN1NkZ2xhdjNCdEszUzd1b0ExM3VhaTZoMWtDZzJy?=
 =?utf-8?B?U0VxcnMzVTd0aGF6TkpPRk9WRGJRUFJFOUF1MU1OVjhCR252LzhyeWxSRkFU?=
 =?utf-8?B?ZGo4OXdJRUhxWVJyR3JwYTZSM1B4MlBmREFScEpSN2VKNEwvUWhkQVZGNDRV?=
 =?utf-8?B?QmxLUXJpV2hBdy9PNXpzTzVsZyt4SUNXbGt2amxLeXcyZU9ueXMxSm93dDJw?=
 =?utf-8?B?UnRjOUs4aUt1V05oYis4bHhUZ0Q1aTJGQnpTWjNQUEhPWlFXS3Robk9Md2ZI?=
 =?utf-8?B?cFk2WG5nWGVFTVZ5WU1CRXlOcUkrZTlPVkl6cnh3UisvR2trVXo2MEVIbUZZ?=
 =?utf-8?B?eHVYWFF6NDFmWHVqRENtNmlKeWpCUU5FYjVXYm02OHI1N2M3eWxOOTJPRzR4?=
 =?utf-8?B?T2ZMSUFEQ0xyWXIzRFRGN3NISkFmLzZXYzRoY0ZqcjE1V2hFTkxxa2ZzNHhn?=
 =?utf-8?B?Skw2WVRIV2RabHhMOG5rdTFRU1lpSDU0cjZ1UW5QbmxaWDZnQ3FFZUNpdDJ3?=
 =?utf-8?B?d0I5U3RnbkZCS1o4L2o5RVVucUFZcVlHQXhuOUc0K1AzQzRlUGVTYVhUVXdw?=
 =?utf-8?B?dzRheXgySTdYWmkvelFWdDB5ckNyc2k5dmY3ZDM3aHErSmFMY2llcUhFS1py?=
 =?utf-8?B?OWJhWkl3VzAzV2I4VUV5TlA3RWw1ZFZtWlRxN2pMc1owLzZxazNQSEhFSmlD?=
 =?utf-8?B?djN1d2lseTlQVGpYaDZqN1Uxd0VEQTFsbHNsR01IMjhPeG1aNms4dmZGdzdx?=
 =?utf-8?B?bnJEUXdWdzVFempsRWs4R294aXBRUzkxU3FFY2xzY2YvVGdFWUk2dVZNRUE5?=
 =?utf-8?B?SlJwYmR5am83TG05MzkvdzYzVVJycm9SbkJwaEtRUTR0bUNFQi9WZXFEWWl6?=
 =?utf-8?B?aW1NamZzRjhVcDRsS2dLWU5GSFRwaWtzNG1VUG5EdzZNOTJ0VTJKVFZ3d0pM?=
 =?utf-8?B?cU9zckQwWWlHaHUrWU9BaEVJNnZmckYrcVM2aW56Qlk4ei9ZdDloTWk5eWE4?=
 =?utf-8?B?V0tST3dQTEtoOWhpQ2tqS1BkMS9FVjNMY2greGNoU053YmlSelhJcS9od1BQ?=
 =?utf-8?B?QnVnYmpWd2RnM3k0WFpVZHZHQzhEMzBYaUdZb1Q5UjF5L2hVa2t3UE8rSFBo?=
 =?utf-8?B?VktESi9ROGtYOWZqcHFNSk5GQmdvSWlQS2h4RE1MYW9IZkJZZ1RUUURQWENV?=
 =?utf-8?B?eVQ0M0FNSDF5a081TDlsb2srcXlvZ2NmOStBcE1UQzB2ZEpyTm9oVWt3eVRO?=
 =?utf-8?B?R3EwSS9VNkQyZzc4NXdVRHUyUWpQSDVudm9CV0ZLK2JIZDdjU1B0VnVQS1Jn?=
 =?utf-8?B?TmVMOGk4OGJjYVZmUjE0S3h1WTJGYjh6UXdNa1hlbVE2ZVFKcDJDdVZKR2lu?=
 =?utf-8?B?dnkvNExmUzNBSEhHNTNkcDVuUGlzSnlFaG9UNU4rWis2MWJ2M3hnZjg2WFpz?=
 =?utf-8?B?Ri9FSjFnRHFsMHM5M3FScHd5eklUZ3RpT2hRc1h3cmtWQ3FPbnY1RlpQcjha?=
 =?utf-8?B?b2dnbWpva2ljbDIwSVp5QUNuMFQyS2h1ZlQxS2RKZjFOcWE3bzRySElES3o0?=
 =?utf-8?B?S29zczVvaWpyYVVzNU41b0s2REF0WWlsam42T21ydFJQQzdqOWdndTh3RGJ3?=
 =?utf-8?B?L3hKbXA3WFpnaDBjeHNZYzRUczZBU3Nta0hxbjRPM1U1Mk5adWx3VkYrQmVu?=
 =?utf-8?B?Y1JCMkpzRWIwQjNWQUROM3E0MW80M1pVbEVsT2RtN2hXR1RKTkwwU2tuOHE5?=
 =?utf-8?B?UlFXTXlBTnd0bTlycEpWNGNTZ3FWeUU1TnEvc09UN2FFMmNxN0hQdXA3V1lJ?=
 =?utf-8?B?MDFjNEw1Ykd6YjhVdndQM2Y3Vm8wSG1QTVpLcmpJUlJxU1hSTGJDVXlmbWFn?=
 =?utf-8?B?MVZ6bkwwM0Vya3g4WkZEWHkyUG1VSm1HVnNSaXkvL21rbzNzNGQ1elZlTkgz?=
 =?utf-8?B?OVNrWitlNkJNZ2pTQndKeTJJRkJlQVRNMVU3dXJLRzZvQnByUTdKZWJtSDNp?=
 =?utf-8?B?TFJTT3VBQU1HTXBocFFPRzJib1RQK1N5V0JFTytadUJNVHJzZlBJS3dIN1k5?=
 =?utf-8?B?aVhEQXlWODI4Z2Yzck9nY1RjcGF0YUF3WnhoTTJObXliNWtvU3RIMmFRWXlK?=
 =?utf-8?Q?7gBIk37DCdtJmHjWx9gL8hs=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e4b634-63eb-4fd5-5293-08dabe2959a7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 05:56:43.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8A8ray4zAJQxO30dXE+b5/udJmeI+olji2gVeeXYzXKA+ovwx44196gJ1YcPFwVZPYKGe+CwmP/le6ZXJyU0zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1598
X-Proofpoint-ORIG-GUID: ZXOtmApQf4XsQznYsTFaOabS5-CBHR2g
X-Proofpoint-GUID: ZXOtmApQf4XsQznYsTFaOabS5-CBHR2g
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> Add a linked list API for use in BPF programs, where it expects
> protection from the bpf_spin_lock in the same allocation as the
> bpf_list_head. Future patches will extend the same infrastructure to
> have different flavors with varying protection domains and visibility
> (e.g. percpu variant with local_t protection, usable in NMI progs).
> 
> The following functions are added to kick things off:
> 
> bpf_list_push_front
> bpf_list_push_back
> bpf_list_pop_front
> bpf_list_pop_back
> 
> The lock protecting the bpf_list_head needs to be taken for all
> operations.
> 
> Once a node has been added to the list, it's pointer changes to
> PTR_UNTRUSTED. However, it is only released once the lock protecting the
> list is unlocked. For such local kptrs with PTR_UNTRUSTED set but an
> active ref_obj_id, it is still permitted to read and write to them as
> long as the lock is held.

I think "still permitted to ... write to them" is not accurate
for this version of the series. In v2 you mentioned [0]:

"""
I have switched things a bit to disallow stores, which is a bug right now in
this set, because one can do this:

push_front(head, &p->node);
p2 = container_of(pop_front(head));
// p2 == p
bpf_obj_drop(p2);
p->data = ...;

One can always fully initialize the object _before_ inserting it into the list,
in some cases that will be the requirement (like adding to RCU protected lists)
for correctness.
"""

I confirmed this is currently the case by moving data write after
list_push in the selftest and running it:

@@ -87,8 +87,8 @@ static __always_inline int list_push_pop(struct bpf_spin_lock *lock,
        }

        bpf_spin_lock(lock);
-       f->data = 13;
        bpf_list_push_front(head, &f->node);
+       f->data = 13;
        bpf_spin_unlock(lock);

Got "only read is supported" from verifier.
I think it's fine to punt on supporting writes for now and do it in followups.

  [0]: https://lore.kernel.org/bpf/20221025190033.bqjr7466o7pdd3wo@apollo/

> 
> bpf_list_pop_front and bpf_list_pop_back delete the first or last item
> of the list respectively, and return pointer to the element at the
> list_node offset. The user can then use container_of style macro to get
> the actual entry type. The verifier however statically knows the actual
> type, so the safety properties are still preserved.
> 
> With these additions, programs can now manage their own linked lists and
> store their objects in them.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

[...]

will comment on rest of patch in separate msg
