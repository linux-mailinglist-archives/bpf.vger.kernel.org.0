Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B93064543E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 07:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiLGGrY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 01:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLGGrY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 01:47:24 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368A3DF47
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 22:47:22 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6NlPfu008055;
        Tue, 6 Dec 2022 22:47:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=18qgU8PXSZP3UI38KcE0TfFNESW8QrSM9LxwzOPZl5w=;
 b=DCEhehFH5/9bLZfiwjJ9vlQbRMaiTtOUb+oyeUoB1j/FHQ6UZ+B1kf0S86+t2+OHCq6e
 HBPdpcP2z1CyKgfBBYMN7O1lA744d0XPs5YV0SGgBy3aBTYuMDW1AuUmM5joA/y8cGnv
 FlN/e5RKHYHvfD+lr8TARvb2p3cII0OrvAH/5lSD3gMHUDp0Q4jnBaWHmLvLGS3VKhJ5
 qI/O7BUtA9xZ/g4/AbUoJeNpLsHfRyMMUhZz4dVILL+r+Bta8aiB6zhL58ojhyq8YRrr
 wlJtGTPUrQqj4/u6D82xdlBejjACDp/2jM7xghtUUi6ZI5MMKITE9yFoSdmTxhjD15W6 0Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mafq99uh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Dec 2022 22:47:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6QdOstuS22GaiL4rJmVUUSzI4I72vwkP5o0niNHyGEiB/p7y8xbdYfY5RTyzub6drUSBKLMHyDwy3C5lQIVguPQ0iMPUVOLsqfYUj3+yvqpt3fjRuy2UHtxq3FzOeViS8e9jqzOy/8U3LVnCzGsa1S3IylsdJYmB8PBnQZnHj04on21xOUb2eVYgjWv6gIuqW3lSwfX+/iJB+yQptgDDhm+q2KF31Z/T/JWHvIFZX58fFU1/0xB0IIPxLcoUjtLIbYHWOp4ZVGzga1qbUBVCKxjsXFP0CXb7+W7hnHbtEV7n+5xiy8HVjW+xwxhOJ11p2cyrWUT6prooqjnaWdXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18qgU8PXSZP3UI38KcE0TfFNESW8QrSM9LxwzOPZl5w=;
 b=FMR2dhZdLGOteoDxtaILa9iVFZEJsUe3od2XWvk86d/H6jgbioBai1ebdYISrRxcqU4i20W5fhqs7Rk5NPhqvXj9wPdgXhBHNN/tXV5K2akMV+4JKUyBD8ePwAffCyQP/lTi8u481XxPOBYJrbLMXdyUqLsa1tGaMOX9P16oc2v4ZWEcCPKR/bNJrnNpB+l6HxvhL3cfXpRJ9x4cctPAsVoZ4Z7DgLiteMtJXQ3FLSd5G7fN6ixP7Wpxt7NmSVwNEqXhynLHsXlGw8Nyzow2gkdO5CWOS6rSzMf91RL6CeHMz+kXpbkKhJc4mam5TpsRweQIVskVV1B6Zth69+hGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by MN2PR15MB2669.namprd15.prod.outlook.com (2603:10b6:208:12b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.11; Wed, 7 Dec
 2022 06:47:00 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::5054:64cb:7c18:2993%9]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 06:46:59 +0000
Message-ID: <b4e644f8-dc55-a9fa-3fe6-8df0df82efb2@meta.com>
Date:   Wed, 7 Dec 2022 01:46:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 10/13] bpf, x86: BPF_PROBE_MEM handling for
 insn->off < 0
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-11-davemarchevsky@fb.com>
 <Y4/8zScubw9uEeCx@macbook-pro-6.dhcp.thefacebook.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <Y4/8zScubw9uEeCx@macbook-pro-6.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0069.namprd19.prod.outlook.com
 (2603:10b6:208:19b::46) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|MN2PR15MB2669:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aed36c2-073d-4f0b-a147-08dad81ed721
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lUvUmIhWKrVYabJjeCmnYv9nGcxDDxaJHr9Lmx3FlNrwgnrvke5lJxKt/lmOzRxsJGi0NSXaa7JnjoDLxW5UjV7SGmLbSYiCDn6j55g4BTNuMmNUKyaeJaaRzz5CRFY31bZrsZjbZ7VAkP+yZP7GXTj9YZQg6ycKF2tmyTx2eR9l+PqaRwWDl8GkSLbqVYe1xm+YE2FoxC2ZeA7mLbM6HmPtwaNc9Rlml36y21TQHai8f13AjMqg58SZbJMXua7qNPbsD0tfOiO28+spr4GuI8DT/5UW3gXoJp6qADruCk4hiS+8tGJtT27tHT61jkJT6HXI6ZV/Qrb8QoaaL0rxGIPr2b9KQZxj9LMI1Uxjy7i1/lgA+2oDjmOUr8ZiqFNiM8TtM8RmhzGVbRT2ngCIR7fQw/WKyhyfpTc27yzkuaQzED8jmhG3wOGEOe2IgbXBMEmZ+9bk6do1jRPUnxJoYG+dtALh0rhqayoAcXPD42zp0a0EMX5zlIb/ZAH7sKozjzOVPuxR7dWsEkXB+K/StzhyZyIzxNXSxmpQdf5KGHivZmBJSudYhJeYLICKFRWTbyqSrA8RuCE5MwLhUjpEBtOrCvvg5XcfP2Z/AeMEwZwubJuqNj+G2wCP13qvvY20TqwNOYyzQskTGdCQkYKCccsS/iEGCxgX4T1rHx59SOvT8ezleZLGH9AxAFQCvCgbHOGxlruw7cvHvFdivU8P4oUb/72AotlSiM068a1Aj5rX7PATbCXRLzNwbUyX2E5e
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199015)(66556008)(4326008)(83380400001)(6486002)(86362001)(30864003)(38100700002)(8936002)(5660300002)(2906002)(66476007)(8676002)(6512007)(186003)(6506007)(6666004)(53546011)(478600001)(110136005)(316002)(54906003)(66946007)(2616005)(41300700001)(66899015)(31686004)(31696002)(36756003)(522954003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJXZDFBV1lJcldHOEZRckFMU0xVdHljQlNiOEZGa05YQVFmbXdVRVZNRU5K?=
 =?utf-8?B?TXN6cFlRVUlFWDVSL0N6WW5BWWs4elhrYVM2Si9QVWM0LzNTM0RkbjN2UkdR?=
 =?utf-8?B?NndRaXBDNmdxUC8xSVVHYVoxbmJLaVNJeWFUL0FUcEdCZkkySU9NOFNaL0pN?=
 =?utf-8?B?VC9jZTFaMnlPNkRYRWl6akZ4OHhCQmpRcjZqZFd6cnN1anZwUUtMUWpaWWxz?=
 =?utf-8?B?bjV3YllBKzIxcDdUaDVqQ0lhZEFjejZKenBaazJvd0RGd3MwOHZqWmMvQlhK?=
 =?utf-8?B?YjQxOU1qOHBLY0N2UVE5VWFxYjlDa1JQS2JvS0VLby9MbTIxTnVXVHBZMEEz?=
 =?utf-8?B?a2JKZ1VoZm5EMVdlWkpRUG0zRVplR2dhRTc3dlVFeGtFWng5bWxPOEZFclZx?=
 =?utf-8?B?VWNwbVAyMVd4a1hFaEE2dHptSnNlWmhTeWtiMHRDTUFKU0NwVXp4WmIwWlhW?=
 =?utf-8?B?cUdYVm1IOGFpMjMrMS9JRTFzQjdkeUhjYSsxaWQ1NTQ5NlRvTVAvRkUxV2Ji?=
 =?utf-8?B?NzFqcXFDcS92UXdtQjhLZGF6M2hQcXVwRVlldDhKWk91MkFEWXNkNjY5N1d6?=
 =?utf-8?B?VDZURGoyT3gyS1pqYmlkVlpVcm9kV2VUM1FGZnpGWE84Nnl2NmpoZDczV1JX?=
 =?utf-8?B?TXFzdU05bS9FR1ZZNU4wZ1JwRTd3SDVwQzRML2VhOEtOQmhEQTNiYmQyODhh?=
 =?utf-8?B?U1Vuc1BvbW5mM1dJVW5CVmtpR3hmU2pnQmVwSE94TzFTUXN3L0pUbzc5MlFi?=
 =?utf-8?B?MWpmdmphQXNRcFlaOWdNQm90Y1o2TDR3MW10YlJZcUFEd2VyaW9CNUJ4SWww?=
 =?utf-8?B?RlVJR0FjZUY1dzFxTDNna21UaXdtbjVKYjZDMVVPMFlFL3ZlUTJ3cWdqdTRh?=
 =?utf-8?B?S2JXWU42VzNSZmdxdTNhZGk4bE1JODBOSWxONDJsVnpNMFpEQlVBNUxGeG1I?=
 =?utf-8?B?Z3VXUTlIT2dkejU2WU5nZkdWTkNyN0phaFVQU2ljUXAzUlJzYXV0enNGRUp5?=
 =?utf-8?B?aVBUSWtXVkVxbXhTSUhjdVRkQlFqUHd2TFFZaGlyNjFWN0NDdW1acVMvL2pp?=
 =?utf-8?B?YzZVdWxqenV5eG14OUFmeGhmUGkzdnlmZnNaMUhnVlNxcFlZNnZKekR2YUZy?=
 =?utf-8?B?WDNhVXpTZGxkQ2F5WnBhQWJ5cXZ2eFVpNnlVREJVQyttVlJFMHZUeDhzck11?=
 =?utf-8?B?Y2tjSkVNM0FhdStPVGRNZ3JLa0VYTmp2M21QWVNzSU93ZzRwUmRMWFRTcytr?=
 =?utf-8?B?RFFHQVhSbWxvZXExRXVnektuT3dWc1ZHQm5vRWg0T1lJTkdDL3JyR2hUZGh1?=
 =?utf-8?B?Q1BFazFTSXYvNEUxNkFHcGFVQ2hjbnNGSGJWT0RKZGtrT3JxdEEyMFl2czJB?=
 =?utf-8?B?TVNYSXg4cytjQXJJcWtwK2h1T3ZmZmViT25nWE1yMC9rQmxBTjR1T2hQT1Jq?=
 =?utf-8?B?YjFlbmNzUGxONDVtVEFJcUw0Y09FTlRUeWRubFFLQ0ltcVV3eDlvQXZrL1hN?=
 =?utf-8?B?Q1Q4ZTdVNmhrWEcvZW9HeVZDVFZwaEhqSWxoRVBQaElYdDZVWXkxMFBzOEF6?=
 =?utf-8?B?Q2tLMW5qTngxc0Z1dVk5SkwzakdFTDNGR1pWZHJVVjhCbGdod1FpbVpqSHJT?=
 =?utf-8?B?OU80Wk9yd09jWVhIVkJEN2IxQzkva0tGNVNwbTdJUXJxRHpjeDF2V3lOV1pU?=
 =?utf-8?B?ZlBRN09TWTlnbjVLNUFsOFl0NVVQdjNxTXhjd3gydm92eDdNNnZoaGRvbWRB?=
 =?utf-8?B?SEl3N1dTMkI5cnhzanE1cE5tQTZ6RStIOTZudWMvL2NXemlQWC9Xamlxd1hq?=
 =?utf-8?B?amtOcURkV0RMQzF3Q0RYTzlCL09FUlBML3p4M24zN0JLSW9KM0o1ak92a3d1?=
 =?utf-8?B?QWMzVXdsOUFpbFhsUU5wYkZBUkJaalpiOFdVMDc2bHF2RVZGWmtzVUNXaUph?=
 =?utf-8?B?eXlxZGE3eG5RQTNhakRBbDdFUzRzUVNOVzRJSU11dTJybmhOSEVzTW1NTVo4?=
 =?utf-8?B?eFl3N3E1NGk2ZHpJdGdsZzQwbFo0S0VoT2RCSWpZaVIwbDc1YktRV2JkaU1W?=
 =?utf-8?B?L0VYVFY4MUVBS0pwdUZlTEthb296aW1PNWpydTN3U3kyVVNzRUhIbG0wUitK?=
 =?utf-8?B?MEFkNmpGeDJkakZLdTZsRWNwRWhpTnJGMzBYWmxNZUlVemVyT2h0TTk1TXI1?=
 =?utf-8?Q?+bYW0XgeyZLgj/o9fNXcn9w=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aed36c2-073d-4f0b-a147-08dad81ed721
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 06:46:59.8613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPTGJk4SFCeDR7oWCFBWk1/c5uaYDqnk9RbiBGLEP3YK2p+mUqi7941Eu3NOl3/YeiKLXUGewX0P+0pNzrRclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2669
X-Proofpoint-ORIG-GUID: SZ1wmXuRLleCVQZPorIhPbBjesP78Mvh
X-Proofpoint-GUID: SZ1wmXuRLleCVQZPorIhPbBjesP78Mvh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_03,2022-12-06_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/6/22 9:39 PM, Alexei Starovoitov wrote:
> On Tue, Dec 06, 2022 at 03:09:57PM -0800, Dave Marchevsky wrote:
>> Current comment in BPF_PROBE_MEM jit code claims that verifier prevents
>> insn->off < 0, but this appears to not be true irrespective of changes
>> in this series. Regardless, changes in this series will result in an
>> example like:
>>
>>   struct example_node {
>>     long key;
>>     long val;
>>     struct bpf_rb_node node;
>>   }
>>
>>   /* In BPF prog, assume root contains example_node nodes */
>>   struct bpf_rb_node res = bpf_rbtree_first(&root);
>>   if (!res)
>>     return 1;
>>
>>   struct example_node n = container_of(res, struct example_node, node);
>>   long key = n->key;
>>
>> Resulting in a load with off = -16, as bpf_rbtree_first's return is
> 
> Looks like the bug in the previous patch:
> +                       } else if (meta.func_id == special_kfunc_list[KF_bpf_rbtree_remove] ||
> +                                  meta.func_id == special_kfunc_list[KF_bpf_rbtree_first]) {
> +                               struct btf_field *field = meta.arg_rbtree_root.field;
> +
> +                               mark_reg_datastructure_node(regs, BPF_REG_0,
> +                                                           &field->datastructure_head);
> 
> The R0 .off should have been:
>  regs[BPF_REG_0].off = field->rb_node.node_offset;
> 
> node, not root.
> 
> PTR_TO_BTF_ID should have been returned with approriate 'off',
> so that container_of() would it bring back to zero offset.
> 

The root's btf_field is used to hold information about the node type. Of
specific interest to us are value_btf_id and node_offset, which
mark_reg_datastructure_node uses to set REG_0's type and offset correctly.

This "use head type to keep info about node type" strategy felt strange to me
initially too: all PTR_TO_BTF_ID regs are passing around their type info, so
why not use that to lookup bpf_rb_node field info? But consider that
bpf_rbtree_first (and bpf_list_pop_{front,back}) doesn't take a node as
input arg, so there's no opportunity to get btf_field info from input
reg type. 

So we'll need to keep this info in rbtree_root's btf_field
regardless, and since any rbtree API function that operates on a node
also operates on a root and expects its node arg to match the node
type expected by the root, might as well use root's field as the main
lookup for this info and not even have &field->rb_node for now.
All __process_kf_arg_ptr_to_datastructure_node calls (added earlier
in the series) use the &meta->arg_{list_head,rbtree_root}.field for same
reason.

So it's setting the reg offset correctly.

> All PTR_TO_BTF_ID need to have positive offset.
> I'm not sure btf_struct_walk() and other PTR_TO_BTF_ID accessors
> can deal with negative offsets.
> There could be all kinds of things to fix.

I think you may be conflating reg offset and insn offset here. None of the
changes in this series result in a PTR_TO_BTF_ID reg w/ negative offset
being returned. But LLVM may generate load insns with a negative offset,
and since we're passing around pointers to bpf_rb_node that may come
after useful data fields in a type, this will happen more often.

Consider this small example from selftests in this series:

struct node_data {
  long key;
  long data;
  struct bpf_rb_node node;
};

static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
{
        struct node_data *node_a;
        struct node_data *node_b;

        node_a = container_of(a, struct node_data, node);
        node_b = container_of(b, struct node_data, node);

        return node_a->key < node_b->key;
}

llvm-objdump shows this bpf bytecode for 'less':

0000000000000000 <less>:
;       return node_a->key < node_b->key;
       0:       79 22 f0 ff 00 00 00 00 r2 = *(u64 *)(r2 - 0x10)
       1:       79 11 f0 ff 00 00 00 00 r1 = *(u64 *)(r1 - 0x10)
       2:       b4 00 00 00 01 00 00 00 w0 = 0x1
;       return node_a->key < node_b->key;
       3:       cd 21 01 00 00 00 00 00 if r1 s< r2 goto +0x1 <LBB2_2>
       4:       b4 00 00 00 00 00 00 00 w0 = 0x0

0000000000000028 <LBB2_2>:
;       return node_a->key < node_b->key;
       5:       95 00 00 00 00 00 00 00 exit

Insns 0 and 1 are loading node_b->key and node_a->key, respectively, using
negative insn->off. Verifier's view or R1 and R2 before insn 0 is
untrusted_ptr_node_data(off=16). If there were some intermediate insns
storing result of container_of() before dereferencing:

  r3 = (r2 - 0x10)
  r2 = *(u64 *)(r3)

Verifier would see R3 as untrusted_ptr_node_data(off=0), and load for
r2 would have insn->off = 0. But LLVM decides to just do a load-with-offset
using original arg ptrs to less() instead of storing container_of() ptr
adjustments.

Since the container_of usage and code pattern in above example's less()
isn't particularly specific to this series, I think there are other scenarios
where such code would be generated and considered this a general bugfix in
cover letter.

[ below paragraph was moved here, it originally preceded "All PTR_TO_BTF_ID"
  paragraph ]

> The apporach of returning untrusted from bpf_rbtree_first is questionable.
> Without doing that this issue would not have surfaced.
> 

I agree re: PTR_UNTRUSTED, but note that my earlier example doesn't involve
bpf_rbtree_first. Regardless, I think the issue is that PTR_UNTRUSTED is
used to denote a few separate traits of a PTR_TO_BTF_ID reg:

  * "I have no ownership over the thing I'm pointing to"
  * "My backing memory may go away at any time"
  * "Access to my fields might result in page fault"
  * "Kfuncs shouldn't accept me as an arg"

Seems like original PTR_UNTRUSTED usage really wanted to denote the first
point and the others were just naturally implied from the first. But
as you've noted there are some things using PTR_UNTRUSTED that really
want to make more granular statements:

ref_set_release_on_unlock logic sets release_on_unlock = true and adds
PTR_UNTRUSTED to the reg type. In this case PTR_UNTRUSTED is trying to say:

  * "I have no ownership over the thing I'm pointing to"
  * "My backing memory may go away at any time _after_ bpf_spin_unlock"
    * Before spin_unlock it's guaranteed to be valid
  * "Kfuncs shouldn't accept me as an arg"
    * We don't want arbitrary kfunc saving and accessing release_on_unlock
      reg after bpf_spin_unlock, as its backing memory can go away any time
      after spin_unlock.

The "backing memory" statement PTR_UNTRUSTED is making is a blunt superset
of what release_on_unlock really needs.

For less() callback we just want

  * "I have no ownership over the thing I'm pointing to"
  * "Kfuncs shouldn't accept me as an arg"

There is probably a way to decompose PTR_UNTRUSTED into a few flags such that
it's possible to denote these things separately and avoid unwanted additional
behavior. But after talking to David Vernet about current complexity of
PTR_TRUSTED and PTR_UNTRUSTED logic and his desire to refactor, it seemed
better to continue with PTR_UNTRUSTED blunt instrument with a bit of
special casing for now, instead of piling on more flags.

> 
>> modified by verifier to be PTR_TO_BTF_ID of example_node w/ offset =
>> offsetof(struct example_node, node), instead of PTR_TO_BTF_ID of
>> bpf_rb_node. So it's necessary to support negative insn->off when
>> jitting BPF_PROBE_MEM.
> 
> I'm not convinced it's necessary.
> container_of() seems to be the only case where bpf prog can convert
> PTR_TO_BTF_ID with off >= 0 to negative off.
> Normal pointer walking will not make it negative.
> 

I see what you mean - if some non-container_of case resulted in load generation
with negative insn->off, this probably would've been noticed already. But
hopefully my replies above explain why it should be addressed now.

>> In order to ensure that page fault for a BPF_PROBE_MEM load of *src_reg +
>> insn->off is safely handled, we must confirm that *src_reg + insn->off is
>> in kernel's memory. Two runtime checks are emitted to confirm that:
>>
>>   1) (*src_reg + insn->off) > boundary between user and kernel address
>>   spaces
>>   2) (*src_reg + insn->off) does not overflow to a small positive
>>   number. This might happen if some function meant to set src_reg
>>   returns ERR_PTR(-EINVAL) or similar.
>>
>> Check 1 currently is sligtly off - it compares a
>>
>>   u64 limit = TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off);
>>
>> to *src_reg, aborting the load if limit is larger. Rewriting this as an
>> inequality:
>>
>>   *src_reg > TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off)
>>   *src_reg - abs(insn->off) > TASK_SIZE_MAX + PAGE_SIZE
>>
>> shows that this isn't quite right even if insn->off is positive, as we
>> really want:
>>
>>   *src_reg + insn->off > TASK_SIZE_MAX + PAGE_SIZE
>>   *src_reg > TASK_SIZE_MAX + PAGE_SIZE - insn_off
>>
>> Since *src_reg + insn->off is the address we'll be loading from, not
>> *src_reg - insn->off or *src_reg - abs(insn->off). So change the
>> subtraction to an addition and remove the abs(), as comment indicates
>> that it was only added to ignore negative insn->off.
>>
>> For Check 2, currently "does not overflow to a small positive number" is
>> confirmed by emitting an 'add insn->off, src_reg' instruction and
>> checking for carry flag. While this works fine for a positive insn->off,
>> a small negative insn->off like -16 is almost guaranteed to wrap over to
>> a small positive number when added to any kernel address.
>>
>> This patch addresses this by not doing Check 2 at BPF prog runtime when
>> insn->off is negative, rather doing a stronger check at JIT-time. The
>> logic supporting this is as follows:
>>
>> 1) Assume insn->off is negative, call the largest such negative offset
>>    MAX_NEGATIVE_OFF. So insn->off >= MAX_NEGATIVE_OFF for all possible
>>    insn->off.
>>
>> 2) *src_reg + insn->off will not wrap over to an unexpected address by
>>    virtue of negative insn->off, but it might wrap under if
>>    -insn->off > *src_reg, as that implies *src_reg + insn->off < 0
>>
>> 3) Inequality (TASK_SIZE_MAX + PAGE_SIZE - insn->off) > (TASK_SIZE_MAX + PAGE_SIZE)
>>    must be true since insn->off is negative.
>>
>> 4) If we've completed check 1, we know that
>>    src_reg >= (TASK_SIZE_MAX + PAGE_SIZE - insn->off)
>>
>> 5) Combining statements 3 and 4, we know src_reg > (TASK_SIZE_MAX + PAGE_SIZE)
>>
>> 6) By statements 1, 4, and 5, if we can prove
>>    (TASK_SIZE_MAX + PAGE_SIZE) > -MAX_NEGATIVE_OFF, we'll know that
>>    (TASK_SIZE_MAX + PAGE_SIZE) > -insn->off for all possible insn->off
>>    values. We can rewrite this as (TASK_SIZE_MAX + PAGE_SIZE) +
>>    MAX_NEGATIVE_OFF > 0.
>>
>>    Since src_reg > TASK_SIZE_MAX + PAGE_SIZE and MAX_NEGATIVE_OFF is
>>    negative, if the previous inequality is true,
>>    src_reg + MAX_NEGATIVE_OFF > 0 is also true for all src_reg values.
>>    Similarly, since insn->off >= MAX_NEGATIVE_OFF for all possible
>>    negative insn->off vals, src_reg + insn->off > 0 and there can be no
>>    wrapping under.
>>
>> So proving (TASK_SIZE_MAX + PAGE_SIZE) + MAX_NEGATIVE_OFF > 0 implies
>> *src_reg + insn->off > 0 for any src_reg that's passed check 1 and any
>> negative insn->off. Luckily the former inequality does not need to be
>> checked at runtime, and in fact could be a static_assert if
>> TASK_SIZE_MAX wasn't determined by a function when CONFIG_X86_5LEVEL
>> kconfig is used.
>>
>> Regardless, we can just check (TASK_SIZE_MAX + PAGE_SIZE) +
>> MAX_NEGATIVE_OFF > 0 once per do_jit call instead of emitting a runtime
>> check. Given that insn->off is a s16 and is unlikely to grow larger,
>> this check should always succeed on any x86 processor made in the 21st
>> century. If it doesn't fail all do_jit calls and complain loudly with
>> the assumption that the BPF subsystem is misconfigured or has a bug.
>>
>> A few instructions are saved for negative insn->offs as a result. Using
>> the struct example_node / off = -16 example from before, code looks
>> like:
> 
> This is quite complex to review. I couldn't convince myself
> that droping 2nd check is safe, but don't have an argument to
> prove that it's not safe.
> Let's get to these details when there is need to support negative off.
> 

Hopefully above explanation shows that there's need to support it now.
I will try to simplify and rephrase the summary to make it easier to follow,
but will prioritize addressing feedback in less complex patches, so this
patch may not change for a few respins.

>>
>> BEFORE CHANGE
>>   72:   movabs $0x800000000010,%r11
>>   7c:   cmp    %r11,%rdi
>>   7f:   jb     0x000000000000008d         (check 1 on 7c and here)
>>   81:   mov    %rdi,%r11
>>   84:   add    $0xfffffffffffffff0,%r11   (check 2, will set carry for almost any r11, so bug for
>>   8b:   jae    0x0000000000000091          negative insn->off)
>>   8d:   xor    %edi,%edi                  (as a result long key = n->key; will be 0'd out here)
>>   8f:   jmp    0x0000000000000095
>>   91:   mov    -0x10(%rdi),%rdi
>>   95:
>>
>> AFTER CHANGE:
>>   5a:   movabs $0x800000000010,%r11
>>   64:   cmp    %r11,%rdi
>>   67:   jae    0x000000000000006d     (check 1 on 64 and here, but now JNC instead of JC)
>>   69:   xor    %edi,%edi              (no check 2, 0 out if %rdi - %r11 < 0)
>>   6b:   jmp    0x0000000000000071
>>   6d:   mov    -0x10(%rdi),%rdi
>>   71:
>>
>> We could do the same for insn->off == 0, but for now keep code
>> generation unchanged for previously working nonnegative insn->offs.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 123 +++++++++++++++++++++++++++---------
>>  1 file changed, 92 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 36ffe67ad6e5..843f619d0d35 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/bpf.h>
>>  #include <linux/memory.h>
>>  #include <linux/sort.h>
>> +#include <linux/limits.h>
>>  #include <asm/extable.h>
>>  #include <asm/set_memory.h>
>>  #include <asm/nospec-branch.h>
>> @@ -94,6 +95,7 @@ static int bpf_size_to_x86_bytes(int bpf_size)
>>   */
>>  #define X86_JB  0x72
>>  #define X86_JAE 0x73
>> +#define X86_JNC 0x73
>>  #define X86_JE  0x74
>>  #define X86_JNE 0x75
>>  #define X86_JBE 0x76
>> @@ -950,6 +952,36 @@ static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
>>  	*pprog = prog;
>>  }
>>  
>> +/* Check that condition necessary for PROBE_MEM handling for insn->off < 0
>> + * holds.
>> + *
>> + * This could be a static_assert((TASK_SIZE_MAX + PAGE_SIZE) > -S16_MIN),
>> + * but TASK_SIZE_MAX can't always be evaluated at compile time, so let's not
>> + * assume insn->off size either
>> + */
>> +static int check_probe_mem_task_size_overflow(void)
>> +{
>> +	struct bpf_insn insn;
>> +	s64 max_negative;
>> +
>> +	switch (sizeof(insn.off)) {
>> +	case 2:
>> +		max_negative = S16_MIN;
>> +		break;
>> +	default:
>> +		pr_err("bpf_jit_error: unexpected bpf_insn->off size\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	if (!((TASK_SIZE_MAX + PAGE_SIZE) > -max_negative)) {
>> +		pr_err("bpf jit error: assumption does not hold:\n");
>> +		pr_err("\t(TASK_SIZE_MAX + PAGE_SIZE) + (max negative insn->off) > 0\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>>  
>>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
>> @@ -967,6 +999,10 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>>  	u8 *prog = temp;
>>  	int err;
>>  
>> +	err = check_probe_mem_task_size_overflow();
>> +	if (err)
>> +		return err;
>> +
>>  	detect_reg_usage(insn, insn_cnt, callee_regs_used,
>>  			 &tail_call_seen);
>>  
>> @@ -1359,20 +1395,30 @@ st:			if (is_imm8(insn->off))
>>  		case BPF_LDX | BPF_MEM | BPF_DW:
>>  		case BPF_LDX | BPF_PROBE_MEM | BPF_DW:
>>  			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
>> -				/* Though the verifier prevents negative insn->off in BPF_PROBE_MEM
>> -				 * add abs(insn->off) to the limit to make sure that negative
>> -				 * offset won't be an issue.
>> -				 * insn->off is s16, so it won't affect valid pointers.
>> -				 */
>> -				u64 limit = TASK_SIZE_MAX + PAGE_SIZE + abs(insn->off);
>> -				u8 *end_of_jmp1, *end_of_jmp2;
>> -
>>  				/* Conservatively check that src_reg + insn->off is a kernel address:
>> -				 * 1. src_reg + insn->off >= limit
>> -				 * 2. src_reg + insn->off doesn't become small positive.
>> -				 * Cannot do src_reg + insn->off >= limit in one branch,
>> -				 * since it needs two spare registers, but JIT has only one.
>> +				 * 1. src_reg + insn->off >= TASK_SIZE_MAX + PAGE_SIZE
>> +				 * 2. src_reg + insn->off doesn't overflow and become small positive
>> +				 *
>> +				 * For check 1, to save regs, do
>> +				 * src_reg >= (TASK_SIZE_MAX + PAGE_SIZE - insn->off) call rhs
>> +				 * of inequality 'limit'
>> +				 *
>> +				 * For check 2:
>> +				 * If insn->off is positive, add src_reg + insn->off and check
>> +				 * overflow directly
>> +				 * If insn->off is negative, we know that
>> +				 *   (TASK_SIZE_MAX + PAGE_SIZE - insn->off) > (TASK_SIZE_MAX + PAGE_SIZE)
>> +				 * and from check 1 we know
>> +				 *   src_reg >= (TASK_SIZE_MAX + PAGE_SIZE - insn->off)
>> +				 * So if (TASK_SIZE_MAX + PAGE_SIZE) + MAX_NEGATIVE_OFF > 0 we can
>> +				 * be sure that src_reg + insn->off won't overflow in either
>> +				 * direction and avoid runtime check entirely.
>> +				 *
>> +				 * check_probe_mem_task_size_overflow confirms the above assumption
>> +				 * at the beginning of this function
>>  				 */
>> +				u64 limit = TASK_SIZE_MAX + PAGE_SIZE - insn->off;
>> +				u8 *end_of_jmp1, *end_of_jmp2;
>>  
>>  				/* movabsq r11, limit */
>>  				EMIT2(add_1mod(0x48, AUX_REG), add_1reg(0xB8, AUX_REG));
>> @@ -1381,32 +1427,47 @@ st:			if (is_imm8(insn->off))
>>  				/* cmp src_reg, r11 */
>>  				maybe_emit_mod(&prog, src_reg, AUX_REG, true);
>>  				EMIT2(0x39, add_2reg(0xC0, src_reg, AUX_REG));
>> -				/* if unsigned '<' goto end_of_jmp2 */
>> -				EMIT2(X86_JB, 0);
>> -				end_of_jmp1 = prog;
>> -
>> -				/* mov r11, src_reg */
>> -				emit_mov_reg(&prog, true, AUX_REG, src_reg);
>> -				/* add r11, insn->off */
>> -				maybe_emit_1mod(&prog, AUX_REG, true);
>> -				EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
>> -				/* jmp if not carry to start_of_ldx
>> -				 * Otherwise ERR_PTR(-EINVAL) + 128 will be the user addr
>> -				 * that has to be rejected.
>> -				 */
>> -				EMIT2(0x73 /* JNC */, 0);
>> -				end_of_jmp2 = prog;
>> +				if (insn->off >= 0) {
>> +					/* cmp src_reg, r11 */
>> +					/* if unsigned '<' goto end_of_jmp2 */
>> +					EMIT2(X86_JB, 0);
>> +					end_of_jmp1 = prog;
>> +
>> +					/* mov r11, src_reg */
>> +					emit_mov_reg(&prog, true, AUX_REG, src_reg);
>> +					/* add r11, insn->off */
>> +					maybe_emit_1mod(&prog, AUX_REG, true);
>> +					EMIT2_off32(0x81, add_1reg(0xC0, AUX_REG), insn->off);
>> +					/* jmp if not carry to start_of_ldx
>> +					 * Otherwise ERR_PTR(-EINVAL) + 128 will be the user addr
>> +					 * that has to be rejected.
>> +					 */
>> +					EMIT2(X86_JNC, 0);
>> +					end_of_jmp2 = prog;
>> +				} else {
>> +					/* cmp src_reg, r11 */
>> +					/* if unsigned '>=' goto start_of_ldx
>> +					 * w/o needing to do check 2
>> +					 */
>> +					EMIT2(X86_JAE, 0);
>> +					end_of_jmp1 = prog;
>> +				}
>>  
>>  				/* xor dst_reg, dst_reg */
>>  				emit_mov_imm32(&prog, false, dst_reg, 0);
>>  				/* jmp byte_after_ldx */
>>  				EMIT2(0xEB, 0);
>>  
>> -				/* populate jmp_offset for JB above to jump to xor dst_reg */
>> -				end_of_jmp1[-1] = end_of_jmp2 - end_of_jmp1;
>> -				/* populate jmp_offset for JNC above to jump to start_of_ldx */
>>  				start_of_ldx = prog;
>> -				end_of_jmp2[-1] = start_of_ldx - end_of_jmp2;
>> +				if (insn->off >= 0) {
>> +					/* populate jmp_offset for JB above to jump to xor dst_reg */
>> +					end_of_jmp1[-1] = end_of_jmp2 - end_of_jmp1;
>> +					/* populate jmp_offset for JNC above to jump to start_of_ldx */
>> +					end_of_jmp2[-1] = start_of_ldx - end_of_jmp2;
>> +				} else {
>> +					/* populate jmp_offset for JAE above to jump to start_of_ldx */
>> +					end_of_jmp1[-1] = start_of_ldx - end_of_jmp1;
>> +				}
>>  			}
>>  			emit_ldx(&prog, BPF_SIZE(insn->code), dst_reg, src_reg, insn->off);
>>  			if (BPF_MODE(insn->code) == BPF_PROBE_MEM) {
>> -- 
>> 2.30.2
>>
