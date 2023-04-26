Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82CE6EFA0C
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjDZS20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjDZS2Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 14:28:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740FD19BC
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 11:28:24 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QHksHb029409;
        Wed, 26 Apr 2023 11:28:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=w1SR15GHEK9Df3fH2Svw17uAtxdFGyx5zHm+ZSDRUkA=;
 b=iVKh8Zeahp8L/yMfBO2AGzZGW5vKa62YpjMsE8Cdm33riTcuMZWpaSi93RoWNeiQ1u0l
 FXfVzHrBRSXv35WYbUNeayflLqiNGI5i2l8QnD71T8g+AQEnCDfbQ0pKubD0pIn2ZrPl
 7+oQm2YFreFb+Vb7VpK8RSYZ99D8/AqqVeVlg4Cv7i0PGFCUn+6YUqtZ7CoTXqxxfowS
 ERTsKElXO2+RrduRvEISxjVmBQerVOc3xDaHRwW8VE079fyEVZ9YQAWzl/+XwZ3VZoaH
 ly5ivDP64biL7WUzpJw4ul0YLyAiwePbsgiCCr04aoK9LO94xYox55ej7e02WYctLY1y uw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6yxeuwqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Apr 2023 11:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0h/KEznKu22q+H7am5oLR7u+ubUmxSj4B+aMRFUgAxHv0ymGAbrnkXA+9riquAeCOSz94C+/seyt8LhZl34mzmWFKYwBBZDtjOZmgco9HI1BtuXY2wMun7sEC1IWQ6iBY6tguXqVGfxQPTQZd7q0DfYskEwK3NGVbfV2TkJGViRz+gsd3OA7HWPT2sSfIt/W21xI1CrpnKE22XqIW31jlR1l7zMyDMH21xYeQkKztvfFGedtJO47TZ9GTmbfzp9yW3aoZQnSnpXIzp4I3YhpFn/dhgyA8RRk2GnrD+5t1CMJMflhnMp//zsA0XQoxJFQcfrPGqKSz1Lj5sVtIWczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2+cvm+CsKGLReKCYBUFRfmxjWXbz9dcoRFW2Kp9oDo=;
 b=ODqjzVaF8dzM7Bp6oK+Fwu8Smvb9TdbjhO8D6gz0fN4DC4cWYQXB16an+eEr7BeHiii8ged2D+aJ5/o1Hi9/DLlIGU2F29BYOipcKQLDIdge9+E7Bmspe8XwphGqAcDd3ufbb1BjoSrVuNIEJbFCApCqxiDy1e0KqTCw2lksv8qyvAiZvnT5OfgVJWEbMG76emmFV3ff1z+neFf17+v5UMWchU6ZPokaAw324Y4vK/1r6NHtSbkRlQXV/Qd5dWIhUBtx/3naHfGLh33Qkp4nmrgWT6CK84Lljz2ibLFt4+ce4nUOAlQqBDkqPy9G4vPhUvlKDbvlsi6vM0BhziMsDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB3810.namprd15.prod.outlook.com (2603:10b6:208:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 18:28:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Wed, 26 Apr 2023
 18:28:18 +0000
Message-ID: <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com>
Date:   Wed, 26 Apr 2023 11:28:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
Content-Language: en-US
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>, gmartinezq07@gmail.com
References: <878reeilxk.fsf@oracle.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <878reeilxk.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0299.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB3810:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ee82d5-964b-4496-6f62-08db4684018a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ZoJqABtOCwalhKHRfyyD/htBoKfjG8ewivFalaNOOVwBlJ9WR9Ef8KQThusy6OmM0X4UhjyrZu0QebJ2h0jTssLj8Yxxdaxw2G4FTvGw0jcQHwTCbsTurI8wlcUgb8LpV6UD+ygQWHdLSCXJn3b6cy1sap8f3az3R6sCCgbLfUwUfNNtru5/reOaEM0JXltUvNVHdG/bA2Z9BZQn2t0HFq/CDvyKk+YhbzpIZU595xV32m7iPqlqYIq60GSO/ZmrI9ju2gBtOeVoEFK56wOECtvcOixgbe+vbgndS1uwLHBfUjCpXWxpQC39iDDyfsNDYaCNblW3KDictVh8GKZ8quRFhAP84glZKSSNBn8DB8YjiS1UOOV+u0qEw8QzyEGeLnNVC3j1Z6lu4gaIZlOStG82/WKoCdYpy+zO+BiQZ4s137MkGaBP7NZiqhaBn6WULOp/qV77f/hUeucTPHBzt6wK328gMcTiB4xk1jvlBzKXZzMVAyNvCjYr5m+X1z6AX9etVjA2b8R1bUAdqfk0Vm8fvT1qOhlCeWvms+JDehORA8ePiN4ZBeg629vmLGuVmXFvlmFdFp4l/RWeZdzMcL+T+iT/U+A1FWrFbctPP7sME2C3X0kQuETEm+EL1u1+KC5Rjiz+e/5TaFWPT/V5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(366004)(451199021)(31686004)(316002)(966005)(66556008)(66476007)(4326008)(66946007)(36756003)(53546011)(6506007)(6512007)(186003)(2616005)(86362001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(478600001)(6666004)(6486002)(31696002)(2906002)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhtMHV5dHVtTlNRQ2pOS0tiN2JkV3Fvb1FXOVB4dUxIMlhzSGV0Y3diVnJq?=
 =?utf-8?B?aHdzOW1MUHpNQWNKOUJwbW1sMEdvbEZkZ2ZPSTQxWkc3QmhucXFOaHUxWkNt?=
 =?utf-8?B?M3hTUDlSdVdzc2daOXFSQm51WVpUQi9wYzFVdWcxL2FwWmZqV2FBU0JNa2sz?=
 =?utf-8?B?QVJma3JobDdBbXVFaUVqL2JZYjE0Mzd1TnBYVkxORjdwc2ZuZVBSZjRzRldv?=
 =?utf-8?B?RTFvWVhuQmw2SDNONUorZXhwM3p2TzBwek5jem5ScEI2eTN5aWw2dXZ1VmlS?=
 =?utf-8?B?Y3NxWmttUnh1bE5BUGlqVGw0N3lXL2RIbVNyTm95UGNMZmNYa2hWU3U3ODBo?=
 =?utf-8?B?TmQ3QWxvNDM2bE1md3pjNlY2em9wbXNEK1ZpQWQxSWIvWmdBM3ZldU1tTFZy?=
 =?utf-8?B?N0l6UWMzT1EyN1hqdG44MWdoUU9wV2RDUnB4ZFg0Rm10WUpIeGJXNk5xbDY0?=
 =?utf-8?B?MjZPV0taMFFHczF4U0VlVGdpcU5VdHBhT0p1cjZhc0c0NUR2bU5VMFpIb28x?=
 =?utf-8?B?d3NkZFcxN0xsZ3ViSnRDdityeXB3U0hveXVDRUVKL0RrcDJsSjV1OUY4Mi9I?=
 =?utf-8?B?SC9RMmRUSFZOV2ZveEdQUUJkYkFmcWtNY0tBS2dxSW9XMU5QellJeWI0M25X?=
 =?utf-8?B?VFVpdjFCUTRXZmlXcDNtVnVHSWlaRkI0MW5oc0htSnl0NHAxOXVxU0d1UWQ5?=
 =?utf-8?B?Ukh2K3J6QTdSa2llUnhId29jZGorRjFSOVpnVE41T2lnN3ltSnNQcHl1Z1R1?=
 =?utf-8?B?SzVaTXk1Y1FBOU1yaW1SdzFSREFYc1RXOWJWcVZ4eG9McFMwbE5QNkJIUXBo?=
 =?utf-8?B?WmY0UW4zc2pxR2VlOElDbFBWUng2dEJGODhzcGNVN0FNT3RFYXo1a29iN25u?=
 =?utf-8?B?K2VlLzFDVWRZZVEzSFJxYm9sR25iWWRGaUVSR0dYNGx0NTM5bzNyeDFEdFFp?=
 =?utf-8?B?UVNNRks1WmRyT3lMREZlelN0MEhXK1djUVZITnpHNGozdCt3bnIzdnFhTnp6?=
 =?utf-8?B?anZ4WDRSdU9aS0dJRlhTZjVzV1RLNi82NXF3bmczWUFsMXIyMEU0TTJHdjRl?=
 =?utf-8?B?OEdHU0xoZWYxR1NrakprYlIyNThmUE1LOGs3THBQY2FNZ3JJNmc1elJiakx6?=
 =?utf-8?B?a04yMUZGTlNjMUZXS05BcTg0VW5nbk1CUERGWm5wYUpYNWt5S21aUWxlZzNW?=
 =?utf-8?B?bG9DbzhqSy81QmhvcTNQTVB2bjhDNW9jdjF2TGw3RWZsbW9YRG8xR2g5Q2tB?=
 =?utf-8?B?Z1JpWlc2cWV2QStPVHpDRWp4c1pqdDhJREMzOUhpOEFMcW05VUVNSERZTUxo?=
 =?utf-8?B?MDFCVE5KTFBWRm1CVlV4eGhsOVFmNThDakhLQXRTY2hhYkVsZkE5YUg4a0Vx?=
 =?utf-8?B?ekNHdDBUTXR4N21vR2VONVp1QzRLclNaWkdzSmNVS3cvZzA4L0Qrb3lKV2Nz?=
 =?utf-8?B?VnhLMnM5QyszTzRhT2MxdlNwVW9HTkphRUQ5T2k3TEtMWmJhYzlFQks4ZWVV?=
 =?utf-8?B?ZVFhamsvUDdIeFQxN1NXeDJ2dkZuWVFKeHNweUdwZjJrUnJTdkt1UDV4RXFZ?=
 =?utf-8?B?bVZiVEwvZkpRMGNaYWd4MEJTU0VJbmpTU3phb0ZVMUhmSWhXQnc5Y0JCME9h?=
 =?utf-8?B?dFhEUERDS25ESFY0YldXSUpxK291RjdLQ3k1dTNFcFFtS1dEZW9HTmhsb1F4?=
 =?utf-8?B?ZGRoVUJLYjZZZlZMWk5mYmVka0k4cndrVFZjdFVJTkhhYXcyMmdtcVRaOVY0?=
 =?utf-8?B?RVlTQlpjSFVxRGNNTjlUa1YvK0dQQy8xdEYweU9CaXhHNFdpdGE1R3BkMU1t?=
 =?utf-8?B?a1JRTWkyYTN3NjdtZzVBYlhwREdKajExbVpyMFFqN2FGcW8vdFpiTU9zTmlF?=
 =?utf-8?B?cEZ4RTZSbTdIY0ovaVRucGVMRGVBVlAwN2ZreGpFUVFRRno3WFR2TmxyL1pP?=
 =?utf-8?B?V0NWNEw2MjhDTzNqeWsxSU5wZjI4LzdOMFZHRHJiMEtCb0l2Z3lZdmFGdEd0?=
 =?utf-8?B?bXlIQ2UxU01PaTFWNHI0VnJZWTBzYU1jVUphbjJMT3lZUUdlYXJLK0pzZnhO?=
 =?utf-8?B?aVVVMmVNVjV2VkFHbHloaDVXUE1yUVliT3ZicjNqQUk0N0ZWOHBRN1YyQ0pp?=
 =?utf-8?B?akdQS2tQY2Vnek5PbjRFZWhlYjg0M1dEb0tiemp6UEpRQkVJNkZ3TG5KUVR6?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ee82d5-964b-4496-6f62-08db4684018a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 18:28:18.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d6PBvcpqf0KP0qLw0ciGFK62s5KzVkSAAEHiUImfuw071H6t2Qne1XkSF6Nvmmr6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3810
X-Proofpoint-GUID: IWvxtiIKvxA7_T043bnIdhIBReOcWOfw
X-Proofpoint-ORIG-GUID: IWvxtiIKvxA7_T043bnIdhIBReOcWOfw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
> 
> Just a heads up, we just committed support for the assembly syntax used
> by clang to the GNU assembler [1].

Thanks! Do you which gcc release is expected to contain these changes?

> 
> Salud!
> 
> [1] https://sourceware.org/pipermail/binutils/2023-April/127222.html
