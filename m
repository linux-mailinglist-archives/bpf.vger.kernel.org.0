Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3894F0EF3
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235305AbiDDFKF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 01:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377339AbiDDFJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 01:09:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B64B3A721
        for <bpf@vger.kernel.org>; Sun,  3 Apr 2022 22:07:45 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 233F13JC015576;
        Sun, 3 Apr 2022 22:07:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aIMwBsA8Jq4zZWQOi+Qz4nQhbkDmYNdHCTIHH7ENiNA=;
 b=Vo1/xhxcFIVAT4CXtWjryOWA99UQTrHxYSvrN84qBXnMaPThK5JofGgwkEr3CZayXLDb
 CJ7GfBqk2BixwiVvdWjFiWF1G60PU6Dp3fhPRFX/yuRHZxhHyJgrf9h00wnI5MAomBqp
 n9Qyc9E0IzbX8j5gkyBeLYOa0HWIiPOSUTM= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f6m0wfg0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 03 Apr 2022 22:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCcnOHo9Xhgl0JW3tEWmmODmSN8E4/UI7M/yr/g3PYtnb3Q5ITZR1o9HJ31uoFmogb5hOBY8OnltUO3jCIEosoccjbUZ8IOAYoWZHzD+TfyEl5eDnOLcDOtX3kMMEeYX7B4cJBo6Ti/Z1OtgQT+8sC+YsSUqZVe+cOQ44BArxHcc8/FI5GZ3piWO3wQ78EDl8kEbMZxHq4uSPWNLVjzvogdFgzpvTbqkUcWYGRLJQ16GIAUkiIt9K1TwrZN9DqjnrpQi5bxfF6iQV7oefitnD8MbzivkKDVU7t73nywccx/XRh9H2WyHe+AJNacGOOXtjbYLSnjQDRRs1YiSy5TTdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIMwBsA8Jq4zZWQOi+Qz4nQhbkDmYNdHCTIHH7ENiNA=;
 b=NL33JFWyCCja7AuqzTFuTh+Ra1I/g7VyTl3tQ400Eug4OLCYy7KaZtlBugX0GqfTvnOriAFENSbhSOYvtosuwfBP2YA5U8Zx8I3oYdxmlVsQE5y0YsI3obeNLMUOzSnFDYOeOJyyKhRqbcu66/OCmM4uaBxv2HVNPF9n6HaVqsD1gamZepUhExRVFHZ4TG5s2l76JtbZfsnc5wcjaJ5Ko9ayMmJQyk2agQFJYj9S2k5GCs68ztLYTgHoOvD9ztfpELtaHGDsDRit7cpVPCBSuxhX4cjCqm8RDymf6J5V7ohI2CIIzQ7ArwwHfan9eHUemD/fam/TnHQ2NGMYLFRxDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BN8PR15MB3346.namprd15.prod.outlook.com (2603:10b6:408:a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 05:07:27 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 05:07:27 +0000
Message-ID: <d624afa2-25da-d417-68eb-5ef302b96ebf@fb.com>
Date:   Mon, 4 Apr 2022 01:07:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220402002944.382019-1-andrii@kernel.org>
 <20220402002944.382019-6-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20220402002944.382019-6-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:23a::7) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8aa9465-6168-4462-6b94-08da15f90354
X-MS-TrafficTypeDiagnostic: BN8PR15MB3346:EE_
X-Microsoft-Antispam-PRVS: <BN8PR15MB3346DF81073D512A08F112DCA0E59@BN8PR15MB3346.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eLS0P9u/59J61hR/R1/+63XggRmGfHu8xAWBsv4AKlyLMBnO8UUH8ycnCponMc0FD14QoGLVTaLHAnqzm0W2b4GLxWR+fsqQUNT0doRrl/t62elMxBbsY4zv4D2QYtKzvhevpg+lbRu8aV6avKoNY+YDRPeLLJ6iKxP0NBwqh5Hn53mv1SdY2t1+Q+2zI/XJ0Z2D5htCERKqkC864hXqK2KFvLw5JTniGxF4dmxx1Spq+Qqp4f6f+aRKUkOHYgnB44DF2HMOHfYKvUrPKZSjbRC0OH4l5/MhhbGZ3cut5t62QBiGQSmKHmLcxADSPPSaaiqeTWdeM0poSuqPigJSeoLCncejplQxYJ6UoO2flOZAP73rDa5dsexvMYSy/EiSOLYe+U1LBS0+MK7ddp+yNcZS2Xiiheh/Lrx8+BKtxqQVa+26NWeUEXGHYRKXOhFX7UFybdNUYeTMIZjaixOgZemBrEJQX3S3rddJ0YRezGWKtWrAPdIgmVMn6AoubJX2TcGTHmvg2Gro6CAMvTtfnlQ32hzYFnw6uAHT6+alNgj7b3Hr2IZMDHzqlGzETg/HMRpWvJclbVHBohaAFT+YxcBdJTnwAg0jBp9dzczAMj+X4bfV9vnyHou7yZEzRyMAMQeVHm0JPNk/Bq95hGr1axC0DIFccRhhs7SyaYFCfWcXIu5PLD+MlMwl4h23OG75dcfPo+/RPsoKVBYbmZzgqFKZJhGrgXsJWHH2bjXPJvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(8936002)(4744005)(6506007)(508600001)(5660300002)(316002)(6486002)(31696002)(2906002)(54906003)(66946007)(38100700002)(2616005)(36756003)(8676002)(4326008)(66476007)(66556008)(31686004)(186003)(53546011)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MndMaklGd2JXeXI4ZDk4R0hqWng2TDV4ZGFBTTBIdXg1a0RKenJFN2RNcGlp?=
 =?utf-8?B?Vm5YRnFkNFRSZU9vQlUvRmI4M1hkUHRJaTRIZHI1b2l5Y2hIZ05wNitoYnVD?=
 =?utf-8?B?VWNEWU9VajNBWE5TNnVYdG50WE5jV1dzNGpjenFwWGJDcEJMQjFHUmhoenoy?=
 =?utf-8?B?TG5kQnU0QU4zUGw2TVhLT3lHYVJBRUpWNUhUYmJlRGVwR21MS1pEN1ZZRUcy?=
 =?utf-8?B?TFJ2bThIU1VJdk9xbndiV2VBOUtiMDdkZzJZemNwMUxPUVRNNE8zSlBYbGVh?=
 =?utf-8?B?STlrVmRwME05Y0RGQzRWZWF6L2xkeEYzcEhSRnFZTnMvMGdqZzBqdEdvNFh6?=
 =?utf-8?B?d1FYa20wU3VXcUdUVCszQzVYUHBiZkw2a2czZ3M2WlY2RFhrRGRvRzhtbm9u?=
 =?utf-8?B?Ty9IcTJ6QUQvY3RWUG1icTNZbkpCeFpuNkYvbkNaSFNtOWZ3NnpCbUdwR1Ns?=
 =?utf-8?B?WFZPTThTRjhVb0gyNldBV0ZUVW51eTlHSldOYkEwTkMvaTJVcThVRjNrZWpU?=
 =?utf-8?B?MHptcDNmdWYvUmQ5bUlBQzA1NlJ3dWVTOXdHZDJ2N3ZaK05rcnE0dzE3WUo4?=
 =?utf-8?B?UWMxWGJSb0xxSmROdDdCZEtiQVdVdGdaaEF2T0dCUVhLWTZtRm5mOEJyWkNE?=
 =?utf-8?B?NlpzUnB2eFlSd1hvWWg3M3BmV0pvYTZua1lpK3BqVHdWcDBLZlF0R250dzVE?=
 =?utf-8?B?SHIveXpadDF3cjcwUjYvQnIva00zNDRwcHhGa08rYVA4YWtKNXJuSmtvU3Bu?=
 =?utf-8?B?bXhyaVJXanVNbXdhWWVjVVZzL0ZuWUFWU1Zpb0JOZWxNNk40RGo5L09wdXpH?=
 =?utf-8?B?SE44WGdZTy9DS3BEVDZtbFd0Z1pnY0Y3c3BkNmlFQlNXeG91a1BLNUdoNHNY?=
 =?utf-8?B?dTlySkFzemdpSXVHRjdSbUZLZ3FTaEZaVVlPVkViaWVvblc1TDF4T0tEbHRL?=
 =?utf-8?B?Tml1ODRmKzUxb1h0WlBQYnFJVkE3MmErK3Q2R0MrQU5iQ1pUbzFQVTNNZm5S?=
 =?utf-8?B?RW1pc2NlRFJLOXF1QkYvOWFOTENzTTgrRVpNNE5EdnNtZnNLMUt2WEg1WTlV?=
 =?utf-8?B?azZKYTYyVXRDZWZ4QmVwL0hJTnZUTjR1TURiNEZCSXdBSVM4WHJ3aE8yNlA2?=
 =?utf-8?B?QW14ZHlMVmVvVlR4Nk5RcnBFRzQ3Y2EwWkdTb0UxdEhja1pyRnl0M0g5Mnh6?=
 =?utf-8?B?RHNFOHlaRGlyd1lGci93TFNmcXhOdnZqaVY1c2ttM1pZV1RoSTByWnZQaytF?=
 =?utf-8?B?ei9hcjZOa3ZGVThjRWJWOE5NcTBOeUtBY0l4TXluWE9Rcks4Uno5SGV6TDhn?=
 =?utf-8?B?Wll1SzIzbGRFNnJvL3M5NWlNeTNYQXB4Ym1lckpBWk5XTjFzNlpIOXFyMit4?=
 =?utf-8?B?eVJWbE13UFBtZlFhTlpteUhjMnJKZlhBMjRpOEZ1Mit3dnh4ZlZuQjBkU0tI?=
 =?utf-8?B?RklLczBPTTFzbThyRVBZV0hvdjNxcWNLQVlIRi9ybUUyb3cvQXhGZW54dXlr?=
 =?utf-8?B?QTdXTEJBNU9aYXNHNGFjcVpvUXZOVVRWUDI0L0pxa2lNd1BmMStxTy9sTm9C?=
 =?utf-8?B?a0xsOTNlU0ZUcWtuZnFBdWNnd0V4d3E5aExzYWJyd0hVS1NwVVEvRzQxM05l?=
 =?utf-8?B?ZnBxQ055T3Y5S0htZXBSbUZqVVRlUGcyV0dZNDg1bUlUblNnWDN5Rk5OdFRQ?=
 =?utf-8?B?TXZ5eWYxalZPdDQyVU1iR2VNOE95QkN0TjZwTkRSdXdwUW5kWWhJeUpnSldh?=
 =?utf-8?B?VzdtbGNTYXFPcFRpK2RabXFsMW1MZWJJaEd5Um52RVh0d1FJYWRBTHAwT1hy?=
 =?utf-8?B?UlB1bWVWRmh4Z0ZPWCtiTDZwVUFVN3VmaEhwQmhTRjN5cFFUUkVLM0RsajZo?=
 =?utf-8?B?dm9IckY5MTRTS2crUDg2c3dWQmMraGg0Mk5oVk9kc2lrZDF2WWhsVFRVUzZ3?=
 =?utf-8?B?eDFzZkFMZHdObDQzNmtMOGxQWFZ0S0dGTHgwK2ViVjBkYmMzRTRVTEpBREwx?=
 =?utf-8?B?RG5vbDlkYmZkSlZHbzBFdVA2OERSY0V5ZDN6UHZoTnUyM282SjNnRHVCR1kx?=
 =?utf-8?B?NEZZYnJFUDdhZU94MysxMm42ZDBmQmJzVXBjMmJzZGcyTTJYazREdTZ6WS95?=
 =?utf-8?B?TExVVm1wcFlUbXdzTGE2U0t6QVlnYTNtM1pmRFJrTThSWkpUbGU2TWFxNkFt?=
 =?utf-8?B?K0prNEN6Y3paS2lTckpYWjd0enlXMVBDRXdWRmovQjllTU4rU3VNZS8zSmRp?=
 =?utf-8?B?N2thMno0d3RFN3Q1UG8vTUJKVEF5MGF5ZDA1djNTcDJvNzMrZ28wTUo3N01I?=
 =?utf-8?B?U1M2NGFiOFE1MktER3VFZUtNcUhSUHNMS0FvQVM3ekpEaWYyZ1I0ZGFGY2F6?=
 =?utf-8?Q?+O4qfKG+NYdJtLdGixsNCPr+CuTbE1nniBVFz?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aa9465-6168-4462-6b94-08da15f90354
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 05:07:27.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OBQbnyX/ARyLHdqcbd1B9Z3qs7IqDVF9Lp0li6W+fxA8GrivNhVlUiILZYGCU8su5re6Nb+McFj2MnKMb4k24w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3346
X-Proofpoint-ORIG-GUID: xz8SKmjOOQ2oqOqc5zyKymDozAbPJR0S
X-Proofpoint-GUID: xz8SKmjOOQ2oqOqc5zyKymDozAbPJR0S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_01,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/1/22 8:29 PM, Andrii Nakryiko wrote:   
> Add x86/x86_64-specific USDT argument specification parsing. Each
> architecture will require their own logic, as all this is arch-specific
> assembly-based notation. Architectures that libbpf doesn't support for
> USDTs will pr_warn() with specific error and return -ENOTSUP.
> 
> We use sscanf() as a very powerful and easy to use string parser. Those
> spaces in sscanf's format string mean "skip any whitespaces", which is
> pretty nifty (and somewhat little known) feature.
> 
> All this was tested on little-endian architecture, so bit shifts are
> probably off on big-endian, which our CI will hopefully prove.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/usdt.c | 105 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)

Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
