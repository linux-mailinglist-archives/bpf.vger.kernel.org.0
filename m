Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8578D603465
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 22:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiJRU5P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiJRU5O (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 16:57:14 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8B53A54
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 13:57:12 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 29IKLUSr019842;
        Tue, 18 Oct 2022 13:56:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+qNrWjt3HzSRPpVEKzg392bLyz0OaMobFNloLbxZhP4=;
 b=SxXLlNEdIsGqrMzgy4BAt+28YgNTzkHiIe4B+ZOlANU4ZOsTxbZW9Wn9sO6NN5A2bAzI
 ZZ/spATA46gkL1l3YrTWEGCE/n7bAah6fLghT0rCIPiscCrlAUuwkWKaF8FEJTdTUjeV
 C/J6lm2zpCmA0/w1oJcYMzs/1d3JR+h58U/Ujb1oq8Ncj7f8eIXASmmjy/urpFRPBfS/
 zxu04T9EMCWpgTHGZt2JJWgVmCtMZFXhl4ibGyauf63Sqa7u+bvERo0vRtP2OrrjTlxd
 srmesoCzOjyFYQT7BLo2OiPjZXb5ZPRi+johUdOq9siVEwJ/dSdCBZykodmQleboVAML Ig== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3k9abe7y1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Oct 2022 13:56:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxi6VT2rHl82CBLgnd/ehvMdOvnOYppZ/1LhWWweROEdzrWvV/lmQjOAYPxUjcjcfSCXt1Igjx23NRrCxCIRXXeYT3DDIHp2OqC8DUZwGXH6yelcIQeJvKrGd5GPi8JroDoeFcjigjo40LcV+rDdli80x0ONvd6osmY5dhLWon0c8WrGnVk5S2MTVddnNdtDoH/miQlTyd7bBi7BCFyPUhgLCxmns9n9ILsgNP1uZFQuf7rrPjIVPoKpeGoRWG1pKbSY/b4GvCZ+TtLNT1B2dlL2n2cJTanvukpy0R1Ll+fJWuH0gAukWwKN6rGrp96VILtLNHbIyAIgSNlQQnuIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qNrWjt3HzSRPpVEKzg392bLyz0OaMobFNloLbxZhP4=;
 b=RoTx04CMpc8s/AcClNdQpfFfWmwZmwE+nBXIKIIcJvyGQF/hSpUsD2q6C67khKFFaLyoC9uDBpoGFI6To23kX7Qv/d5bKCBbm95mQOOfuXAWAe8Qk60QFmXkPz7Jw2uQQQPEsQU990ct2+CQC7pT5oDA+H3H6m4DRXBDRIGlxuoO/w2DhJCMAhnx7LvN625siixLOO0Q2zcvqtNv2yFtmTVb4Fcab3mQ6E8QfBCQFEMirDrp2mHX1YbXUtlnmFu0H7o2+kMEnNkXyfCDAuASKJhnVYF3faPIRh5MDk+z5fK3e7Q0lwmRZnsZP57p1uIrPfJ1Tt9e7WQyBNLY5reHZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BLAPR15MB4065.namprd15.prod.outlook.com (2603:10b6:208:273::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 18 Oct
 2022 20:56:55 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%7]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 20:56:55 +0000
Message-ID: <dae252af-70a2-bd8c-77cf-58492747c4e6@meta.com>
Date:   Tue, 18 Oct 2022 16:56:52 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 3/3] libbpf: add non-mmapable data section
 selftest
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20221018035646.1294873-1-andrii@kernel.org>
 <20221018035646.1294873-4-andrii@kernel.org>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221018035646.1294873-4-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::24) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BLAPR15MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 611f3c5a-f443-45dc-b356-08dab14b4a25
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDLiuYAk6+3xAFlP90V2L5vsSHXrGrerS181TzZB161ndKBC5HShGI7j1Oe1rEz7Msg+9cUgActVFTT0mWkB4trRdXLoRTVc7bGbBbz4PjupIgFMWoR6nKQn1XsvNdwE9HkfCNxld9tNS3tLCcvsQIaSglWHAtKMjN1vLDIQJHWfmw9MahQvU1huNF7M2lAljTyz10pGjzZnvlaWHKHtRwdNw/cUDTLmXeI1JZmbPcJhmmn0uYsDb2+ZFvn26HkY/VksdaownvLxp5bz8Q21yN3rkf0/4HnGHh2CWC2WhXYFmC/TTZlms6ctH/GBnYTn+hDYKt9Mnt5ceJNxLfIPrjYG4aseyuW5CvhtK4uaTovrTMXEZIOP1dYrWmVbfcGSz1avSYvvr3tQtmNNSTFJu32WLGhGfc1ZCva0aKrtCfugXFPiy9ZoKFJTb002v9En0lZWiXVg54seolG0v1ySxkxB7hLQguJ2E2ggRH5JS4qOLr+9CxylQOhF26TOFoKCP5O/cLrF4DwwYvbFgvMj/1ZzGCx8IoqDBe8NC2gFjgwHHgox3E7QG1sGo6iVHtAbTlRr7C5CL+er2erZ0F/AbjdSbcex+PuM9nMk8Vp9v/1nieV4J6hU3SGyZXFbPs0esIgDieKf6g0W5ocQLxxSkuNEhIZerjxaPLCitxCBOahIWv3Mhp6pTtUL0GqtYLYbNzOH3xcUV7Ao/F6nZXAuEYB/CoATOcCuj3HkOkQsKO+wtlaEvqkUvRz5HPSoRY7E3tcxbtUCxsikCELnpJrGms+471LhHEXQ6Jic7b3M+m4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199015)(4326008)(66476007)(8676002)(31686004)(66946007)(66556008)(8936002)(316002)(41300700001)(5660300002)(38100700002)(2906002)(6506007)(53546011)(6666004)(83380400001)(86362001)(6512007)(2616005)(478600001)(186003)(31696002)(6486002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2R6VTZGZ1JlNjFSa0NWS3VRQnRwVlFoSnM1TE9iWUQwb0pTRVpEdjNkU2dE?=
 =?utf-8?B?Ulg4SVFERTNMWkZJVzBqMjFpUVBpbGpqT1JWM2pmZTdOckgvZ1FWdjltSndi?=
 =?utf-8?B?dGZuMEhza0U1RFJDOXcrMXREQ0FyWUF3RlJHcjR3UmNEQ2RoRlg3Q0xMU1pU?=
 =?utf-8?B?R3p4VWZZQkdaOUljTDZhYWFlS3d2czBtV01JOFREY2IvL0dmL3huc2NNSDQ2?=
 =?utf-8?B?RVlqdkNPako4MFlWYk1ncXJhZFM4aU9QUXFqdDRLOW5Wai9LMWV6b0txdXda?=
 =?utf-8?B?UWFvYm9NTk0wWGFMai9FTldzQ1I3cDB5dFlxdWJyKzFEcEY4dWNXeWNhN291?=
 =?utf-8?B?ZS9obUhWWXppZmcrcmpkQWZaeGhnU3M1WGp3S2Y4a2tOVy9GWUIyTTMvV08r?=
 =?utf-8?B?UVVKa0tSaHBJR1NXWnlVTzZrakJqczl6clJJQlU0dzRaZ09yWjlpVitHU0tI?=
 =?utf-8?B?KzdydnhaajI1STRPOW1OeWRIZVdqM09wTjZMU0V2S1NkYXZFc3RjSFRXTmtI?=
 =?utf-8?B?NWFTdlMyLzVYRFRBQUNmbzN6cS9mL3doamwxQnVHTG9nenRYYkcvWW9kQlFI?=
 =?utf-8?B?UHoxeUZXeXlmajNlUlBZc2RJNy95SVZXSGltYVBJWUpsbDRwSktkQ0UyalV1?=
 =?utf-8?B?emNKWUV0ZDMyVGYrYkw3YVBDR0dUczVPSjNMaGNwZkQzR0hXQWMrYUEvd1Jt?=
 =?utf-8?B?UDhHRi9ubWFoV3RQSXJvNE00Z3hscFVvK2VIcW5aL0tIb1F0YXdFcGNMT252?=
 =?utf-8?B?eEdwb3lhRFBySFpOWnlVTU13S2drckRzRFZwSjByTmJMZCtuK0d6dS9GQnc2?=
 =?utf-8?B?R1c0dkdxS29GM1NMWFgxdE9ldFh1ZCtFN0VERDJBVE9BZ1ZIUUxyTXpIUUlX?=
 =?utf-8?B?VjZsWW13dUJlMzAwbFprTzFUbzd0Mlk5ZDNPaUNPVitKVVQxdDRFb3duMUpX?=
 =?utf-8?B?eUpxYysrRHJQb0ZES1ZUcmFndUlUZnlUZFBoY0kxZmJ0TGVOanlDNDIzS1h1?=
 =?utf-8?B?QmEyZmdvS2JBeURHdXNmR09ldE5Zbi9lTlZKNW53cjRBVXZHNHVObWNQaU9s?=
 =?utf-8?B?SVQzV0ZXaGl6NWNSeGRsUkR6N0xmTE5jM21oWnNaVUxUdzg0czYxbi9kYzJE?=
 =?utf-8?B?WDRIMDQwSmI4V1hzNDBiVXVIbkw3RXIzZWNTUG8xYjM5QlFRREpNNGt3NW1W?=
 =?utf-8?B?S1o1dVlxV1NPNzZDU0Z2M3dDc0Y2T3FzMnd0Q01PQ0hLMWlGYlBGdzZzOUtH?=
 =?utf-8?B?UjZWTVFVQ2FlNGtSOTRhN29MbVZvZlpxTXJTOUtRMWNMTCs2M01RRmFaNGo1?=
 =?utf-8?B?YzZFUnBRUGZEY3hSU01jbG80UjN3bHZXeTlENUc2WUhoSzBhUEpMZkFlRnhl?=
 =?utf-8?B?VDNxWjI5Ky9kODFaRHNSRVRUaU9mWlFDc3kzWU9xN25TSHZ6bGVNNy90RG9S?=
 =?utf-8?B?N205dWNGZUQ0eGRlNEJCUHcyalVnUzlKRkZycjc3Z3N0UWM3ZXpTbkIwV0x5?=
 =?utf-8?B?ZFFENEVvbVB2SnRiQWRUalFxSVZHdzBabHhKNU9nWFFPQVViYXJ6aG5PSXRE?=
 =?utf-8?B?bTZGNkowWklsdVlCNEcxdFp4R3NPbFV3aUtZd044a2RlV3dESXRaUy9tYUFX?=
 =?utf-8?B?SWtxTTNvdXZNVEl3ZGhlOEtFYlZFeHZ5SmR4S3ZMbVFXeTlOQmtBMnJPMDho?=
 =?utf-8?B?OU52WWRZZnBPclBnRmR1T0xBN0loR0JtajdlUkwxUEI4akh3WEU5YTF3UmJD?=
 =?utf-8?B?K0hjaUFRd0pVcml6RUhrV08xM0pSajRaV040Z2hqQnQybFRkQUxlUlMzOCtJ?=
 =?utf-8?B?djdxZ1VXeHYxQkhJUU80WnZqWXJkYVM0ZGNrL1dBeEdSdEU4U3pQVGxwMlpR?=
 =?utf-8?B?M1FscDFCb0pJcUxEVDFSSUZzWUZsZzVVUzRpd01MMW5PTHZtVDJvQU5jcjB1?=
 =?utf-8?B?Q010YnRzNzRmYVc5TEpjRncwd1ppMmtienQzMkxRbjZnbytmNWozNDVzUVBY?=
 =?utf-8?B?b1czOUhIWDh0RHhHdElDSXd4bFVWNFZ4TVN0NndPbGE1RDlPMVRmallDTEVO?=
 =?utf-8?B?eXhoazdieVZmaVRCUmN2N2F5V0tXazRnWnhRVldWRWFMVnhONm8vb1pOaklM?=
 =?utf-8?B?ZnJFUzlWVzU4eEZHZktJU1FYdGpKQmxRaFUwZEh3VVlqOCttaE9RanRmbkx0?=
 =?utf-8?B?Z3RndUVRRk1CWjhqeXFSSWZqeFBmbjlkeU5lcDg5L3pWM21zVEp0Q1ZMNjZL?=
 =?utf-8?B?VHplcUJFa0NZdkd0RnIyaXF3a01RPT0=?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 611f3c5a-f443-45dc-b356-08dab14b4a25
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 20:56:55.2557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: be6VB0l8O3iIE5Zs5JqJ3LaejQ9coy5DEDtpGRheO0dV2IL4b1626BYNzUPt/zfFLQoZy1mj9Kxz9hDCshMrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4065
X-Proofpoint-GUID: ev3ijDumTPyW-l2d9V4Z4WQR-sA25s1l
X-Proofpoint-ORIG-GUID: ev3ijDumTPyW-l2d9V4Z4WQR-sA25s1l
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

On 10/17/22 11:56 PM, Andrii Nakryiko wrote:
> Add non-mmapable data section to test_skeleton selftest and make sure it
> really isn't mmapable by trying to mmap() it anyways.
> 
> Also make sure that libbpf doesn't report BPF_F_MMAPABLE flag to users.
> 
> Additional, some more manual testing was performed that this feature
> works as intended.
> 
> Looking at created map through bpftool shows that flags passed to kernel are
> indeed zero:
> 
>   $ bpftool map show
>   ...
>   1782: array  name .data.non_mmapa  flags 0x0
>           key 4B  value 16B  max_entries 1  memlock 4096B
>           btf_id 1169
>           pids test_progs(8311)
>   ...
> 
> Checking BTF uploaded to kernel for this map shows that zero_key and
> zero_value are indeed marked as static, even though zero_key is actually
> original global (but STV_HIDDEN) variable:
> 
>   $ bpftool btf dump id 1169
>   ...
>   [51] VAR 'zero_key' type_id=2, linkage=static
>   [52] VAR 'zero_value' type_id=7, linkage=static
>   ...
>   [62] DATASEC '.data.non_mmapable' size=16 vlen=2
>           type_id=51 offset=0 size=4 (VAR 'zero_key')
>           type_id=52 offset=4 size=12 (VAR 'zero_value')
>   ...
> 
> And original BTF does have zero_key marked as linkage=global:
> 
>   $ bpftool btf dump file test_skeleton.bpf.linked3.o
>   ...
>   [51] VAR 'zero_key' type_id=2, linkage=global
>   [52] VAR 'zero_value' type_id=7, linkage=static
>   ...
>   [62] DATASEC '.data.non_mmapable' size=16 vlen=2
>           type_id=51 offset=0 size=4 (VAR 'zero_key')
>           type_id=52 offset=4 size=12 (VAR 'zero_value')
> 
> Bpftool didn't require any changes at all because it checks whether internal
> map is mmapable already, but just to double-check generated skeleton, we
> see that .data.non_mmapable neither sets mmaped pointer nor has
> a corresponding field in the skeleton:
> 
>   $ grep non_mmapable test_skeleton.skel.h
>                   struct bpf_map *data_non_mmapable;
>           s->maps[7].name = ".data.non_mmapable";
>           s->maps[7].map = &obj->maps.data_non_mmapable;
> 
> But .data.read_mostly has all of those things:
> 
>   $ grep read_mostly test_skeleton.skel.h
>                   struct bpf_map *data_read_mostly;
>           struct test_skeleton__data_read_mostly {
>                   int read_mostly_var;
>           } *data_read_mostly;
>           s->maps[6].name = ".data.read_mostly";
>           s->maps[6].map = &obj->maps.data_read_mostly;
>           s->maps[6].mmaped = (void **)&obj->data_read_mostly;
>           _Static_assert(sizeof(s->data_read_mostly->read_mostly_var) == 4, "unexpected size of 'read_mostly_var'");
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
