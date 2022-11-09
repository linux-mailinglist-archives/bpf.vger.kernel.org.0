Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D86622F6C
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiKIPyg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 10:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiKIPyc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 10:54:32 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E701F1145C
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 07:54:27 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9ANlm0008938;
        Wed, 9 Nov 2022 07:54:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ofJT850oPe13nkvabEd77IS9eOBw9JlqTM5WupfPDcA=;
 b=D7XapKfP/SUSiWkg4VfGShOEdn66w6p3GJ/tsXOy502h4uTQNi2EHbTCGIf864njLbxL
 MoRerdM/Td0zMqQdXFW0DzyQpoERu04Qc0qJbdInj65FeSdNwFsgv1Mb+hy86Uvuuo5L
 o49ZNu69yQatRr8gv76j5usGXaYZytXhv7JmlqbB2DDgq2sDeoI4NZAx4tkGKD8yrmHj
 xuRLe960tXiYm9m9PAtpy/jFefyZ+MXH6bxs5FnVr5XAMH3rEAAOB4l5NdGEl+7nazSW
 sReRGLXvPNxykIcHw42Nx9nx86a+Z/dENNf0zwlEADtxmFHl88ebn3Exkq1gx+E+MIzL VA== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kr68nm0qy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 07:54:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9L97QdGVhk/+wE8T9HmmgAL2DHlykllTVltCbMZT9gKc5XsluW5fFx3Hx3ceIRA/WVsTC/huTEujx1ushTjVrsgopRlhPLvs9MMUP/gGuvspPnd8dK9r9Sd+AgWqMIIPXU+vUBPl5SHSBV5VWzrzMLaYDM0LYg6AIHq8kGu2oeq5b5pZq3lsaK5VUQw6FdyWr2YJi9vGQ19OILegZ1+gV3dAWExzGJpLHDm0Y/nzycWTa0mtlO0n7sVV7AUJoeyXnAYCbFhhsiJ3DNZ8C897+9yWOGp5vF+nUhLVFSEzusaRwjvqCRWF+s5SlBYGV8+O51wYJRxmvnG9qVFJ4XypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ofJT850oPe13nkvabEd77IS9eOBw9JlqTM5WupfPDcA=;
 b=Q8Fk5B3F0hNxbdPeSSoJXzOJJswaZKFBjeTSaUxEiA3+HFx5XZTXejkDDxj8y5EbSYLplZKZP950A++I05bz/9H608BWR5vh5CuY44H6F/0zvlbdml2UnQfs9DcB56o5JFwvxPeGZtiXLxXB/0qLRj+/+HnahlFczs1HaqC9wRCdR1WV7100cFLC9qqEVc+y3P8UJDp6hN1BpDmIqxeU3rH/0H1dbwvHhWOyfO+6wOSmg2rSTXLN6IB5jqy0hLE3wwhl8e1psZnoK19IRjscMHAH1JwxsAx29O/de0jXrsMRxWzUpwbLYajLll1UwtjUVeTANiRcKI15H8LktnRr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CY4PR15MB1846.namprd15.prod.outlook.com (2603:10b6:910:25::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Wed, 9 Nov
 2022 15:54:03 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 15:54:03 +0000
Message-ID: <8f340958-71da-508c-bf57-73daa0fd22cc@meta.com>
Date:   Wed, 9 Nov 2022 07:54:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v2 0/5] clean-up bpftool from legacy support
Content-Language: en-US
To:     Sahid Orentino Ferdjaoui 
        <sahid.ferdjaoui@industrialdiscipline.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
References: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221109074427.141751-1-sahid.ferdjaoui@industrialdiscipline.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0371.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CY4PR15MB1846:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b88baf5-aeb9-4db2-a572-08dac26aa031
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eHmOXCqXpNvRpMHu0v0mkv2g8Uqjx9uVvgDYRnoHpNSbpBg0PLz09+SbFLRqgj9nGUxl67h9tFQSu5M1yaPtYeohoHtj9pNuqxRNsOwxWSrAizKFbfRTdUhLY8/Y5YrFzdaS1pvIjAjEwZa95rqdBoLX2I2toJwyKglmPQqme6nHlGWTXVz7+EaPoYcvdDtA7P9fVd8yyC88+i6YA4INBYPXpxdS5FTHHTdrUO+9Azzb57TIG+nOUR4BEGLiqNn7V+g5d2YZZ63J1Ao86hmrHMhTEKZpqmKHFvckjtFCDMIQwB5OLQk1u7uAv/4Ue708Cv7BkTjvvNfc2JXfLoJxAp7TphyjcCSZ3lf7tdCswDyyW4gyY16b9IAS5s8JqVuhS+PtEHmSvy53mqll543VMISyeM53Tg4DMPeA++PrFhjl4Cb5XBGxyEtVCWBkk6b6njdL3PzNGwuvl8q9x99KYHOlTUPyrkVGqzuZHYjm12ZEACnIXTB6huQQXd6OD85I1+4wEA+F40ZY2cazxa5DUhvFtzHVyxK7nVH96H9SG3Vj9TuzACS/pTj6pqaZiVjSS+Pr77nBTQ9MId/9EarAF+jMsi2y2+ATe7V6sQfpgR3ZNW6/Z3jDsbwhYZvJX4TAfZdH86kJVsLCjru39MEgf/gcPpYdFK+F2SfRRvLPd7eXYCPfyRe0xRPnf8tfM7LS5ePTKl2k9Ko2TijQ1+rRx7XP3vWMMpmM0NXrSGoqhie2c583Ratgm7rxyGHJagE+hc0JRWi8Y+S4Af4DMhBvfwOjlvq2qHe/CQ8Tv9MC69E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199015)(2906002)(31686004)(36756003)(66476007)(6486002)(8676002)(4326008)(41300700001)(2616005)(8936002)(5660300002)(7416002)(316002)(66556008)(86362001)(31696002)(478600001)(6512007)(186003)(83380400001)(66946007)(6506007)(53546011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxNZWhaZVA0ZXlBQVppQnFxRWR3WEhzbG9ha2toU0FrTjZvVWJ6VXBEa0Uv?=
 =?utf-8?B?MVp3M2dZY3paUURZMDVmQjFMRHFleVEyYmN0d3JIckhSQ3NNN2MwK0FqS1FM?=
 =?utf-8?B?bVhUWi8wYzNNQ1V0d08wcVA5ZXZiQzM5amxlck5FYkF3a2dmbUVSbk4vMXd2?=
 =?utf-8?B?L2VpQkp5bnJsNWthNHBVVFdoZ0NiN2k5dmZmL2NWVXdjYVV5dS9TUStybUlz?=
 =?utf-8?B?MFVTdEYvTmU0bW9iTVZQcXFXRXZEOGRZaTdjVkFOVHhndkxUdVhibUw0alEv?=
 =?utf-8?B?WnRqZDZoMnE0WHR5VFFxenB6bVRsejY5OWFNYWpYR0dxS1BvUWJqWFJvMTF4?=
 =?utf-8?B?Uk5yTWtzcldjNjJFK2doSEt5RUJuTFBENkpKbjZ2ZGcwb3phVGdndTN4ckov?=
 =?utf-8?B?clhEcFIxQnpHUW5Ob0duKzR5TWh1UXRkZit5emovbkQ1NHhid2dxY1k2WjNr?=
 =?utf-8?B?UEpDOVE3MDRHekdiaVJlZFQyc0RhZEp0aUJtbzd5MjhIbjR6dUNGdzF1S29G?=
 =?utf-8?B?K1RjVEpwNXhhTi9iOVI5RGxJUEZlckp4Si9EYzkxMVJxS0pvZXZJS2VENkJN?=
 =?utf-8?B?SkJBK1BON3h3UzMyaUh5cHFhRFp3UklaZXZOb3JnVEtWUGdGY2tsczRmV2Q1?=
 =?utf-8?B?NExZUnUzWlduUEFqa3cxL1FLUmxia1YvazZmamFlZEI2dytPOFVUOUNXdzlG?=
 =?utf-8?B?TnBvRHJZcEs1RGd1bHFrWnE1bCtsRHIzTis2U2NtNDk4aC9mTzlwRllFc2JQ?=
 =?utf-8?B?T3d5VDB3Y3RReE9FZE1rT2VHTUYrODZrb3V0bUlacFVrQS9BOGpUa0RwSWlo?=
 =?utf-8?B?NTRtKzZGZ1RMOXpoVlFldTltSU5hVEtteVpZalY2SVJ3eGJ0SkF0SUdidFNG?=
 =?utf-8?B?REh5UlhkU1N1Rm1MMGJYRGdCbGR6czNtM29CZWQ2cUVnbFNXZFFIdFBYVEd5?=
 =?utf-8?B?NlNpb2RDNUpqVlNPb2wxSE5XRWlkZWpueC83NE5nbGliZXpvay9PSHJpdGxY?=
 =?utf-8?B?VzcrNlBBZzF6R3AwNmVYNThiTzVWMnNVSmNhV1NEaUN5SStLUlZuVm5vZmZH?=
 =?utf-8?B?Zm5ZMTBnYmhqV1ptWlFIMU0zdHBDRXYxRE9FbGMrMkkyWnhWVkdGdlU5U3M4?=
 =?utf-8?B?UmM4TEJrdGlObGVIaEc1b0d5dDVkdXhWeDlFUnpwNkR1dFdwdTk0NVV5NjFu?=
 =?utf-8?B?RzhEeVBrVE02M2FtSXlRdjV0NWFVa1RlNTdGUmJvZUFQdmhSZzZmdEtaQjlD?=
 =?utf-8?B?QjFQL0NRSEhkQXpmK2sydjF4NEpncEFkbzhJdTkyV2t2TmY0OE0vazI1dXVR?=
 =?utf-8?B?Q1AyOW90bjY4ZmJvUi9oUzZocGJTZTNkSGltYUN4Zk5kOWhLelc3bHhFeFE0?=
 =?utf-8?B?N0ozR2RuODMzYUpqdTFZQjNYUnd1Sk52ZjR5VDl0ZHJuL3R1dWdVMlRMUHl0?=
 =?utf-8?B?c09BdTZTOHlGM0s2NjdkeFEwTTREN09xNDJMck9WTmJoWW1SMCsrT1N0ZUw5?=
 =?utf-8?B?NGdnUWxmMWgrRVJ3SDFBQ3NqZ3A2V3dMbjdJNFZEVm1lNTJielgrVHd5a1Qw?=
 =?utf-8?B?cEZXMGtGZFRGbjZVazVuNmQ2KzRpTDNiUklQTlAyVzEzcnVaRWxaK2xNYUVi?=
 =?utf-8?B?MVZNbTlFdlBhZHlQVHhDb0lkUEhMTnFwOHcwemR5NUpLRXVmWTJGcXl1OUpX?=
 =?utf-8?B?Z3hHbmI4V3UyU0VnU3JQWUVmNktpVkdhY1oyUHE1VDZURzVJOHlxRXB2Mjl0?=
 =?utf-8?B?b3FKQWV3NXBXd1d5Ky9kTGZoUjV4SFZ0ZjhKOVR0TGIxYTAySDZtZVpYQVNh?=
 =?utf-8?B?VGk3VVdURElTdXhnVHBTNW1IQjYxWjhXOVpGWDlxejdpbjE3RXFiY2k3NE8w?=
 =?utf-8?B?OWNETzB1dWlJT1BSN0UyTGkxaGZCRHVmUnpDTE1FKzdZSk9oYi9SSzdFeHc1?=
 =?utf-8?B?SWt3Zzk1NUkvTEJpQzNYZ0tveHBPUE8yRHQ5N2RUTk9jNDhnKzAzMkJyUVEx?=
 =?utf-8?B?QWl4djkyb2M1QUZ1dUZFVCtEbzBiZkhTTFJuaHhFZ2FVMUIyT0RsNFd3V29D?=
 =?utf-8?B?L3hpSmtCWUxDMzF6d21XTmZOd1pOTFd6RnZOQXUwbVJPakxhY1FBZDQydTVi?=
 =?utf-8?B?TGI5UFQ5VjBUckdZUFVvT0xCYVJRbDU2dTU1WXg0Rmc0TC9kN1RKOXkxdkpD?=
 =?utf-8?B?UGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b88baf5-aeb9-4db2-a572-08dac26aa031
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 15:54:03.7526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWx90tRfxcFIdS9bgPi/Eg9GeQv33g2kBl++kyY4qcM2Y90ZlJvgn1Ug5RLXGPJC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1846
X-Proofpoint-GUID: T89Z9AQlzGnkpv5ZHNZIX2nAFU8NSigH
X-Proofpoint-ORIG-GUID: T89Z9AQlzGnkpv5ZHNZIX2nAFU8NSigH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 11:44 PM, Sahid Orentino Ferdjaoui wrote:
> As part of commit 93b8952d223a ("libbpf: deprecate legacy BPF map
> definitions") and commit bd054102a8c7 ("libbpf: enforce strict libbpf
> 1.0 behaviors") The --legacy option is not relevant anymore. #1 is
> removing it. #4 is cleaning the code from using libbpf_get_error().
> 
> About patches #2 and #3 They are changes discovered while working on
> this series (credits to Quentin Monnet). #2 is cleaning-up usage of an
> unnecessary PTR_ERR(NULL), finally #3 is fixing an invalid value
> passed to strerror().
> 
> v1 -> v2:
>    - Addressed review comments from Yonghong Song on patch #4
>    - Added a patch #5 that removes unwanted function noticed by
>      Yonghong Song
> 
> Sahid Orentino Ferdjaoui (5):
>    bpftool: remove support of --legacy option for bpftool
>    bpftool: replace return value PTR_ERR(NULL) with 0
>    bpftool: fix error message when function can't register struct_ops
>    bpftool: clean-up usage of libbpf_get_error()
>    bpftool: remove function free_btf_vmlinux()
> 
>   .../bpftool/Documentation/common_options.rst  |  9 --------
>   .../bpftool/Documentation/substitutions.rst   |  2 +-
>   tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
>   tools/bpf/bpftool/btf.c                       | 17 ++++++--------
>   tools/bpf/bpftool/btf_dumper.c                |  2 +-
>   tools/bpf/bpftool/gen.c                       | 11 ++++------
>   tools/bpf/bpftool/iter.c                      |  6 ++---
>   tools/bpf/bpftool/main.c                      | 22 +++----------------
>   tools/bpf/bpftool/main.h                      |  3 +--
>   tools/bpf/bpftool/map.c                       | 20 ++++++-----------
>   tools/bpf/bpftool/prog.c                      | 15 +++++--------
>   tools/bpf/bpftool/struct_ops.c                | 22 ++++++++-----------
>   .../selftests/bpf/test_bpftool_synctypes.py   |  6 ++---
>   13 files changed, 44 insertions(+), 93 deletions(-)
> 
> --
> 2.34.1
> 

You can carry the 'Ack' if no significant change for
each patch.

Ack for the whole series.

Acked-by: Yonghong Song <yhs@fb.com>
