Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1966C373
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 16:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjAPPTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 10:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbjAPPTH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 10:19:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6298D4C0B
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 07:11:32 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G8EQ5x019632;
        Mon, 16 Jan 2023 15:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1O0JHiBHDYJDhvLKt7sOQfJKpQ1vYdpDmTspdOMKadA=;
 b=mKvdpaxeN5Z38P/9tgWGK2AIF0k3DH86xIB1RkqtRID9H279xqAYxW13AF2YuTt1hctS
 Ezw0vnZMF1+Jd4yJ9CpPVK8f/10Zt0cDN1zzqMRFsUndBSlGEMcY2UcqZKBcjq9MIYJ1
 H1gGRR9Vn2yAwIjYf4ZWZ9UlYARHpqFHi9aBwsbQbmmAAJABoEbQ8yxuoDATR59I2/eM
 e5C/m/8gRMTmmmIPYCPS/MZR/uZlz4aq2pRR6jiJ9DNvwDEXIL9yrhMntrAcEBp8A6ji
 wpv9Fz2nagzG8u/2gf9HIzJlmvRkOixd9NEeO/bCEKwokSXNAN67lbwYexkGxb7Pdr2N vg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k00tyny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 15:10:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GEK6pv004891;
        Mon, 16 Jan 2023 15:10:56 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4qyxhyhw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 15:10:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiBDx9mYl5639JyR9bTx5oYxxiQ1A6bRm1gmrDcjCaqZjLh4fk4ndo+R+cLGpbLrasuEttW1arS44SJV9Z2ZSGjd1JQFpCSug7gFjWGdJqqs8A7ngiyrJ1iuzua7MGBsl/1UxWOpUemMwY4aPdbfzHgtcsJl1KYw07iefqhXeW8KW/OK7OsFYuqkZdf28Kce7fWLM2C864xtkE8DHZU1ujf61nr5OBCeoOsXowwo34WHfzqqpWRfBU5x8beRlM+r20b2UOHXbpxo9UZQBSZsm5G1tlJ8PoYIPf8EIx30bP7r4yVNoQ5NVinFNCRLNEGTXsKhuMgeOLsl9wDlMw5+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1O0JHiBHDYJDhvLKt7sOQfJKpQ1vYdpDmTspdOMKadA=;
 b=AJ78+TS9fZiNccyMQskVLGe0gQ64FymloN9OaTdN/LiQHChPMDM6qfyvp2t9pOwNM2coTf6C5vzQscwPcTWrZl6CY+7LPAG9qP8UX7Sya0LVipQm+akpCIQn5cn23ZcU5j9JJsoDeBeadY48fGhr+lwamDZaE5JObxgz6OwgJLJd2kMKmBqUz0MChvy9ieRGOWZ+Nn8JlGEllOhthsNll2icQVDonhD8zH+3isqPpki6V/+JhAgike5L/b/aoWqk0hIfy2DmgOOl5ftthQmQLFI+eyXCdUwtBZwajfn0In1ekvHzxEMVjzkybl/DfseR9W4jILDu4UCRcjlAwfEGfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O0JHiBHDYJDhvLKt7sOQfJKpQ1vYdpDmTspdOMKadA=;
 b=rz2UR5hIEEvT5INaR4v9oW5HCMs78dDO12CnDnVQ23HCGdYw9z5L5m+aZ7uJQ4PjnGxLdez+5WFYkmHNxORY1xcNjVUyF4Wyx/vzrvsSgLut6OVWEMhQb+p4jItDIB8KYLop5dEuYSUP729oE0vXSGyvPYTOQbOCkDedl+SgXvQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 16 Jan
 2023 15:10:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 15:10:53 +0000
Subject: Re: [PATCH bpf-next 00/25] libbpf: extend [ku]probe and syscall
 argument tracing support
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Pu Lehui <pulehui@huawei.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Florent Revest <revest@chromium.org>
References: <20230113083404.4015489-1-andrii@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <6baf4921-9d97-e90c-55b4-40b41b1bec61@oracle.com>
Date:   Mon, 16 Jan 2023 15:10:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <20230113083404.4015489-1-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::10) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 97771b5b-84d4-4560-234a-08daf7d3dc28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gKxdz/56iF6nGIw0SyvIxwxjcqjvO2VERpW8fboYABaT1KhXkQa9+YZy6U4NP5YRCEu4TfyWASbsrj4J3l+ih2zR6AnQ2S2SJ7MiCQKORZHKTDetxTb6jn94WDSzPJ5h0FMHHODUFu5tbDvJL6wnc5Z3an7Qp8+DCjKVzdkHVi4TQWa8OkZ01xcgwIpKDI+kiYjtKn2q02TCp3zN3Hh7r4qbLdAE7GWADlYtX8tfdzAmjUaMdkePIk5ZvaOkUzPFmD5Fy3OxHSZWjDbHcRIgIvsYvFuZVzkpnd5xeQ7AcwjfB+vzATLIu3NWpFRJ3XiEn74rUZS0hUh1rLCArITb2WufbOSabI/ZkRbctRqLEr0AEKd6wDAfrLQS4S/w0qXdIb5ZbLnnIutFhmB7Zi3VmwMzAvWkVuXlqWcFqcJ7vSUANNcbTeibNuPjK85efBSHWDvDgTSlAGG4roDisodvbUlCrMH+GrzBr1Q7dXHjf+LxO7hR6OKRBEMq4KOmulJqTjbplO+RUKAbxNhwUkeA40hSdOniarW6W3ZbMnFnVS5DsvRkQiJ+ZFtkLaZzLZDN61lDOQUqWhH5wrpRvlh+0qN+2mWTNc9jEF30nuc2LuJpyKhJxGl3A/ZuqHLGS4WFuNmlmKmDsVEMkfPyfQIV6ArbjRQYZGZYu4bHOpz9rE5js+58HjZWsw0nC3wdnPF4Y3yjCMYFJ13wZKT2tMiXUXUl07JVS0Bp97V7OAqbBWI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(376002)(346002)(366004)(451199015)(31686004)(36756003)(66476007)(4326008)(8936002)(8676002)(6506007)(66946007)(66556008)(6512007)(53546011)(186003)(31696002)(316002)(6486002)(86362001)(44832011)(7416002)(6666004)(2906002)(5660300002)(54906003)(83380400001)(41300700001)(66574015)(38100700002)(478600001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yzd1blVSemQra3VNWW9kTGJGQmRHZDZvZTI5VTJpMkJ2MWIxSmNqTHJubm15?=
 =?utf-8?B?cXNTNEtBeDh0UFNYUU91UnpoNjZHN0N5MnEzeE1rcW5UckZGU2c0V2pVYTVv?=
 =?utf-8?B?eWFWRmhQMlRySm1VQWE5eTBzRTl0VzBiY0pVZjBTTlVtaDdkZlJ1aVdqQzdH?=
 =?utf-8?B?YVowbC9rWHRPelNPRmFTV2wvVXpiaVZIUkkyYVVVanBxdHM4bVhGT3BYYUFG?=
 =?utf-8?B?RWxZQnBxeVdYMFpaVkRhRHRUYjc1Mm1wZlhwQVc0Nkt2SUtIejdnRE81Mk9Y?=
 =?utf-8?B?VitER1BUcUpWaHJNMlZXZC9sVjVHS1dNWkFVZHRhMWhCWFNjN3dsQThtcVhs?=
 =?utf-8?B?a2ZmRGFMN1liZWNMZTFVeVBYTWZKaisranZDTHJ4bkhpUDlHNVFZUStXVkFu?=
 =?utf-8?B?cHQrbnBocDRLZ2xDaFBCeldNNW0yODFEMXVrVzBpbDJ0cEIzdFhEMnNmTnlY?=
 =?utf-8?B?NVNENllHQ1ZJZjUxUmV3bjJDc3pjTzlyNDN6VHkvRmxhQWhEV0lWWksvNVU5?=
 =?utf-8?B?VmFZekgvSjdFVHJYMEMvSmpWeVVYSGRGTDExTVZNamluNCtPK0FxRTRJUUly?=
 =?utf-8?B?bHBxVHMraDdrRDBCS1lGcXcwZkdadFhOYjUvZ3Y3RVBqMzF0TVVoVVE1VmFl?=
 =?utf-8?B?Nzc0QlhaQnpwMnA2NXI1Mk01YTRJaXFVajl2Y0ZXZnc3NFZ2a2dHb3NQWlVz?=
 =?utf-8?B?cDRPV2Y0TFpzb1dXOTg2MURPdGtRZHhWOXVOSmhZeVBQM3FuekhpZjl1eU1C?=
 =?utf-8?B?QWZKallJYjRnSUx4YXI2SUU5Szh3NkF6cGxXb0piSEV6KzIwQ1hjNDR4UFdk?=
 =?utf-8?B?ci83YUQyN1dyaDVLZ3RZbklNS241QWpLSEJhZzltY3V0b0tqbE1Zb1FOMGg4?=
 =?utf-8?B?RjBqMjZnY0JyUWcwdm5QQ012TnRaSU1VekZhSkIwY0tQZW05aXM4aG4vcjkz?=
 =?utf-8?B?NzNOUHJQdDNMSEQwdkI5UEVDU0ZVUVNWN3B6Z0pFV0d3NEZydjh3N0hDS251?=
 =?utf-8?B?TnFoNVNPWm1kd3YyNVpwOE0xMGFwT0RKa3JLNmZNQVRIS1IxTkZlQlhWTURD?=
 =?utf-8?B?Z0l1bmFzK2xaOGJIM0hvT21TWWpIZEZQZ2hHZFFQd3VpSnlLSGt0Qm5lSE5q?=
 =?utf-8?B?Y25MVW9jaXdiQ3pzaDdJZ3RZYTA1cGI4bEcyYnlCWm9JY05mdm11cmRaT05Y?=
 =?utf-8?B?V2pGR3F3RUgyVE1QNXh0dUNTMU0zQThaaEpEYXg1eHJLWDJMN2pDWElsSEV4?=
 =?utf-8?B?SkxWbTF5blMrMnErUEJLdkVlaThqekQ3WGtWUDI0QjUwaXpRV0lPNVE1OVQv?=
 =?utf-8?B?aDV0bFdtdXhDWnYrR3F5ZGs1SlhEa1pMNDJISUt4VW1YclFReXNrRGJyMTVW?=
 =?utf-8?B?N1BxUUtFVmFWNm5TdVhPalEzMlVJdTRzY2hITGVDQUZidGVoLzJvakN3UmtG?=
 =?utf-8?B?UVF5SXRwV2M4clFsbU01ZUN0RmhQcTFOSFdsQlplWlNXU2V0N05uYkJZZitV?=
 =?utf-8?B?OFUwd3BHeXBOQkQ0cVJJNTJpNWU1d3BGcmdCaUM5dmNUbzFCVERPNU9xbnRK?=
 =?utf-8?B?cmQwcW5Na0dva2JKM3ZHYWlGOEcvNUJYUCt2cmdqTWk5RzlKYzJZcEhoM01u?=
 =?utf-8?B?dXdVU0d5K2pTM0FSZVpET2dqNUFHOVlURmthZFZ2dUdmTjdHdnIzTzl1Q0R4?=
 =?utf-8?B?SkxOWGpuNjhzbVFLbzhSVzdsWDVKUnhpVm5zZ0Z1d0MvQ21YNytiRWIxRTFj?=
 =?utf-8?B?UmU5TEQ4eXRaWG1rT0pnOEt5SEpiTmVMS2VPLzYyWjFhOTYxd0pkeGJFNHl1?=
 =?utf-8?B?OWZCU1JOMUluTHhSazIxemRmWm5mdEM2WnMyTG1JcDJ5aTJkZzlCRys3ZERY?=
 =?utf-8?B?MXlOZlorMUY3NDBJcXUwOWsyS0VvbkVyVnRxeUd4ZnR2dEZnZ1NVNkY3czJa?=
 =?utf-8?B?VlAvcFErbkNLdlhsNmRUbVpIbDFsd000blVaeVlGcitpMWZoWEo5U3BqRk42?=
 =?utf-8?B?M0JmUHJHcUFlSXRKaTdOVmlDSVhxVlRzVnZ1RS8ybWhLWkpyT1pTb2lLNHA2?=
 =?utf-8?B?L1ErSjhXNmdNRUFjYkhWZCtWY3ZpcFNNRVM3d1paSCtCMXVRRnJtTzVaVjhE?=
 =?utf-8?B?TzMyNEdTcldHdlk2ZE5lWEhPV3NmU2h3TkNPTkN2b1ptVnc3Y3B6NE5ta1c1?=
 =?utf-8?Q?3369+LZNon1mstYW6GWjkjw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VFJiQU1wc3BocWRwbWkvUFFEZnFRVHlETkRsempTL3RFVlArYlBwSFNYbWRz?=
 =?utf-8?B?MkZsdTJMRjJiaEppMUlsZmJPOU1lZ0txZWlJb0VqdURXNVNZNCtwVHlMaFRZ?=
 =?utf-8?B?M2VOS1JuVHR6WDQxY1lKa2ZNMkREYVdaK0cxcThsZXhTQ1RvTFo3cU40TnN6?=
 =?utf-8?B?NFd4enZidGVxY3hwVmt2QnNFcXB1dmtEQkhyYXhKckVabGVodi9HZ05iZFZK?=
 =?utf-8?B?MDkyK1lFMkUyT1MwZkpoL1ArS0JCSmpBVEdGN1ptY1pFTlZOWHlSVEFTZDh1?=
 =?utf-8?B?c2hvV1h5MzJuY0tGazRPMHgzWW9xZ0Z0Q3d5MXo5VVQ0eWtLRFprdU92Q3Jn?=
 =?utf-8?B?c1cwMUV5NHlCZmMySWdWMXFZR1RKdU5rL1Q4dTdjY25CRE1uWWM0cGk1Vlll?=
 =?utf-8?B?RklRb3pxdVR6b1M0REpuOEEvK0VpSUcreU93VWQ3UjJCdkdML3g5K0JJZVZQ?=
 =?utf-8?B?dTZYRCtDbGNNV1FpbXVMZ3l2cTVEZ1JIckRPQjk1TXd3RkNPQTQvSmhnLzU3?=
 =?utf-8?B?RE5TSllqUVVjVTdNRGg0WXZ6V3lFM3JLeEVwNC9FQXFXVk9oMldvZi9reEc1?=
 =?utf-8?B?bGMwUEowMEg4WlhzNkxBM1FYQlk5SS9GNFlRVWg5c1dxam9zNE9GQWhuK3hl?=
 =?utf-8?B?QXBxWGZNMGpscmxRZUgzTGxmclFVa1BRck5STUtHYyt0NHlLaElockdZQURN?=
 =?utf-8?B?UEVwakVYeVM3Qlh5azJaRlJpNlMwT3BkTnVHc2pXVTVuMWQ3ZEVmd3h4VWxo?=
 =?utf-8?B?UFBqVkIvcTJ5SjgxanE4WEZ2d3EvMjlGVmN0VGhnbEl0dlBkbTlPa3QxeTN2?=
 =?utf-8?B?Z3BhL01zYVdZa2FNQmJaa3hxbDlOOXlBUVpjVzVQOGxxZWM4RmgyU1hEZWRn?=
 =?utf-8?B?NlArU3FiMFhNRUVUNWwzYlc5UWhNRVd5eC9pcTlnajdBRk9CY1I5SlczM0Jq?=
 =?utf-8?B?Q0FIZWoxMmFzTkRTL2Vmc29FU2hVdzJjbGxBMzlDa29EYURySVRBYXFqZHph?=
 =?utf-8?B?MDdGWVlaTmptUHVCVUVJZlQ1ZnVQbWRNdzc2d3RKWFBLQzBoNkJqSGxwWFdV?=
 =?utf-8?B?aG1SOWgwMFdCcjNLU0hTMDRLMFRyRTRUM1dwekhIb2hrbEdDODgrREZ5bFIv?=
 =?utf-8?B?bEZsVy9zR1MxQ2kxUjFyYXh4ZFdzUy9HRTVlSkhuTTlHZklMaGdVR1RHSFZp?=
 =?utf-8?B?bk5EUHMrL1pUOUdKL3pidjdsTU4rQVFteWRvZittTjRGTjF0b1dKdjIxN2tF?=
 =?utf-8?B?UFUvSG1IWGp6MU13T0M1c2NqaGcrNEZpMkk1RitjclNYM2JUdGJzN3JjNG9t?=
 =?utf-8?B?Qk5PSEVsSDFDUXFWSVJBdkJRcU9jR1ZnZzFEczZDOGtiWUg0ajgxZEt1dTZh?=
 =?utf-8?B?am4zVHYrSTIvUmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97771b5b-84d4-4560-234a-08daf7d3dc28
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 15:10:53.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1aRMga0/z1lXUM30gs6eoVwkgJgZlc1YsWAX5BsILnkxNgRXmyRlZVVYyHvpdMJ99UEOSGKW4zLOiZcd7XCxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_13,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160113
X-Proofpoint-GUID: xRmZqfBLxrQ54ZMv3FVhL2sR2yBHfnD5
X-Proofpoint-ORIG-GUID: xRmZqfBLxrQ54ZMv3FVhL2sR2yBHfnD5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/01/2023 08:33, Andrii Nakryiko wrote:
> This patch set fixes and extends libbpf's bpf_tracing.h support for tracing
> arguments of kprobes/uprobes, and syscall as a special case.
> 
> Depending on the architecture, anywhere between 3 and 8 arguments can be
> passed to a function in registers (so relevant to kprobes and uprobes), but
> before this patch set libbpf's macros in bpf_tracing.h only supported up to
> 5 arguments, which is limiting in practice. This patch set extends
> bpf_tracing.h to support up to 8 arguments, if architecture allows. This
> includes explicit PT_REGS_PARMx() macro family, as well as BPF_KPROBE() macro.
> 
> Now, with tracing syscall arguments situation is sometimes quite different.
> For a lot of architectures syscall argument passing through registers differs
> from function call sequence at least a little. For i386 it differs *a lot*.
> This patch set addresses this issue across all currently supported
> architectures and hopefully fixes existing issues. syscall(2) manpage defines
> that either 6 or 7 arguments can be supported, depending on architecture, so
> libbpf defines 6 or 7 registers per architecture to be used to fetch syscall
> arguments.
> 
> Also, BPF_UPROBE and BPF_URETPROBE are introduced as part of this patch set.
> They are aliases for BPF_KPROBE and BPF_KRETPROBE (as mechanics of argument
> fetching of kernel functions and user-space functions are identical), but it
> allows BPF users to have less confusing BPF-side code when working with
> uprobes.
> 
> For both sets of changes selftests are extended to test these new register
> definitions to architecture-defined limits. Unfortunately I don't have ability
> to test it on all architectures, and BPF CI only tests 3 architecture (x86-64,
> arm64, and s390x), so it would be greatly appreciated if CC'ed people can help
> review and test changes on architectures they are familiar with (and maybe
> have direct access to for testing). Thank you.
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Pu Lehui <pulehui@huawei.com>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> Cc: Vladimir Isaev <isaev@synopsys.com>
> Cc: Björn Töpel <bjorn@kernel.org>
> Cc: Kenta Tada <Kenta.Tada@sony.com>
> Cc: Florent Revest <revest@chromium.org>
>

This is fantastic, a huge step forward!

For the series (tested on aarch64):

Tested-by: Alan Maguire <alan.maguire@oracle.com>
 
One question - I couldn't parse the s390x documentation (or find
anything else) which stated the function calling conventions for
that platform. Currently we support 5 register function call args
for s390x - is that the right number?

> Andrii Nakryiko (25):
>   libbpf: add support for fetching up to 8 arguments in kprobes
>   libbpf: add 6th argument support for x86-64 in bpf_tracing.h
>   libbpf: fix arm and arm64 specs in bpf_tracing.h
>   libbpf: complete mips spec in bpf_tracing.h
>   libbpf: complete powerpc spec in bpf_tracing.h
>   libbpf: complete sparc spec in bpf_tracing.h
>   libbpf: complete riscv arch spec in bpf_tracing.h
>   libbpf: fix and complete ARC spec in bpf_tracing.h
>   libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
>   libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
>   selftests/bpf: validate arch-specific argument registers limits
>   libbpf: improve syscall tracing support in bpf_tracing.h
>   libbpf: define x86-64 syscall regs spec in bpf_tracing.h
>   libbpf: define i386 syscall regs spec in bpf_tracing.h
>   libbpf: define s390x syscall regs spec in bpf_tracing.h
>   libbpf: define arm syscall regs spec in bpf_tracing.h
>   libbpf: define arm64 syscall regs spec in bpf_tracing.h
>   libbpf: define mips syscall regs spec in bpf_tracing.h
>   libbpf: define powerpc syscall regs spec in bpf_tracing.h
>   libbpf: define sparc syscall regs spec in bpf_tracing.h
>   libbpf: define riscv syscall regs spec in bpf_tracing.h
>   libbpf: define arc syscall regs spec in bpf_tracing.h
>   libbpf: define loongarch syscall regs spec in bpf_tracing.h
>   selftests/bpf: add 6-argument syscall tracing test
>   libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG defaults
> 
>  tools/lib/bpf/bpf_tracing.h                   | 301 +++++++++++++++---
>  .../bpf/prog_tests/test_bpf_syscall_macro.c   |  18 +-
>  .../bpf/prog_tests/uprobe_autoattach.c        |  33 +-
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  25 ++
>  .../selftests/bpf/progs/bpf_syscall_macro.c   |  26 ++
>  .../bpf/progs/test_uprobe_autoattach.c        |  48 ++-
>  6 files changed, 405 insertions(+), 46 deletions(-)
> 
