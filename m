Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB13C61FF68
	for <lists+bpf@lfdr.de>; Mon,  7 Nov 2022 21:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiKGUSC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 15:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKGUSB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 15:18:01 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F52AE2D;
        Mon,  7 Nov 2022 12:18:00 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7JaSIR012872;
        Mon, 7 Nov 2022 12:17:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=86tZqmXkMov3REgCDCBEIlQMILLXEKmk1u0st5GonYc=;
 b=c13CArE76x6Y2OfCVLWmWEAP+WPA/XmxaNWnOKZRTq4rCsd0zthtXLapIz6p0/vb/8n2
 b9755OcT3bQ+L+FlnETFgzHv5ytWk8aGQhOBNLjjD8aNmec1QBZyQJBkih5oPSyOWsfM
 BlRXt2r+t3H+Ete33RFgpaAt1MORabaSt6D5+fjg0jTCdaUQ16ytZQIucEGWP4A+xL4r
 nAXvsTDWwYxPXpdDOGwS9/4pWc0T44VtCWyXtB4chnAPDi/H8zYR0EeNAIdmcv0QVXk2
 H7As3ACHukdj7ZLjENbNbDMDkaWgg5XMmxPbqMGF0B2j6Yo4+dFckURh/DbLVb/gtGKK bg== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3knk5mjwg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 12:17:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vem+6ZNUoNmsXR8lKOGyaEqP6ipeyCovT98sk3ADNyfNNOm+feFDL14qdgcl0J9Z9ai7OCW9W01X18KUkgoZ4nUcDbSSlyB0uvcDXz58ZzhQUZ/ZldFQx9heVgi7gPR8wB0uPRqumXczNHv2JnhONOA0R4IXW/tTmcnAwl85MDnaAo2FQq4NwtNQ6QcrUUvp2wYUDPaEi0mcJP/vU5ts0jyIz2MZT5M1e4Y1PhyeqBQKog3UyRT7sMGqe1bOVllQVwtuwAEQZK7Xd5rAxU0UUT1HpbTBexh1Xtc5F2gGrAG7+UYhVRQqGiIW2m3NOIZ7LD6F38iNzs9NNdWF4xtQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86tZqmXkMov3REgCDCBEIlQMILLXEKmk1u0st5GonYc=;
 b=KH9UrUAWqViP+v7hBJbvhBwuCJaPt2XO/8onaMM6ZKQr9bi4ItJxR/tkjrhMh7FieBJ1WwO/YrXlOUhEisvmaE0fLxBYKpIHjL2/QaJqJGV4qiGrY3dIIfbNOZ0in6ETllP9RTViV/oJHhhp4mlrjrCRlY2+dt/RzqZMuRmv7pLrs/EhKzNq1djxNL+f33bJ0/U85Q1Rkx6e6PqdA66eVmHP+EzgGvdt+GebTXoURkZip3I34jK5einFY5UjWTyY29i/Qf+5CE+jB72p6Rw9pDcsK9jzkKJfMv6TgZed+ibgO0o32cSKVOkKO3Pe5PyITWlML8juJ1lzTlFI8o3VFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3143.namprd15.prod.outlook.com (2603:10b6:a03:b5::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 20:17:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 20:17:53 +0000
Message-ID: <26fe394e-b235-d992-b7ef-f8cc855e13d5@meta.com>
Date:   Mon, 7 Nov 2022 12:17:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v3 1/1] docs: BPF_MAP_TYPE_CPUMAP
Content-Language: en-US
To:     mtahhan@redhat.com, bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <20221107165207.2682075-1-mtahhan@redhat.com>
 <20221107165207.2682075-2-mtahhan@redhat.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221107165207.2682075-2-mtahhan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:a03:255::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB3143:EE_
X-MS-Office365-Filtering-Correlation-Id: d2fcd374-fa6e-4927-4444-08dac0fd264b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ptEiofiWKGWPb1B8KFJfKvxCBBhNznmlLorynP+uRIPV2kSPkecsyCld/Q9w3xln6P1o9tXhnRP+hdUoML/+5QCb4AwqRVochsheIgNB3QzwcZ6I2dUci15vU7NLZMwkO43Edx0rNaY8VL5aiStcm7GgYTzANFgb6NuKl8rKmtc6cDEHte9J8W4039PFuwnR2KfWk0cVt1pRk6y4NMSXEu60mxMP4yDlYcprQDj5eaAmzy0qgwMttUMhm4r+x1ajAyRJzy6mJSLe537FsMlAdQiZx9Y1FWJC3bcPFfgIJkuBD0a3z/T93nHrjueSPS+5PrAUxskURU29PrlRz/VyERUSFO1Sh/e9F4gsuk6v+nXPVdSurZSGF8FLPKAAEqXJdJKbO3FK2JyxuWA+OJKU/iqJAkFLYFEPXtPdIt79d5DijSuI0hywNeJ3nAizc1LkrCSPP3LuWHCsv+r+whjSEDq+m/Fn9ZizsJqHzb3cvnYHK0pDRboABrFnKo6R2apDtCZ1+YJx6NjzRO8pM337aMuAUilV3RUXVd2qGYude6gJHgA25R6Nde3FechYPubFZ/DFe+Md+72YU7yo0bleQ/bHvriJ+fs7AHxlzX2/skkara59jbU3Cb6w+BIRAo4KcxUBBaMnfUTmQoyxX1RreNFxn8DRAb/dJ/YfLMRxQowfHdFPKydLHE6rZHMNYGge5maG8HOt+U8Py0HALmhvt0kBswPsUAQwV7QBUsSXZeDjPqrH9i2farXrASa6ZI3B3veIRmn5cQO0kfdI6at7HPh+rVXQoVIjXSXjo2ER80=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199015)(31696002)(86362001)(31686004)(36756003)(8936002)(5660300002)(2906002)(4744005)(66476007)(38100700002)(186003)(6512007)(2616005)(316002)(8676002)(66556008)(66946007)(4326008)(41300700001)(53546011)(6506007)(6486002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWtnb3dCZ3d1bWhUazBabzB4WGRuZThxa0F5N2JrdjV2dTQ4SzRzUXZEL0s4?=
 =?utf-8?B?UWY2eFZLU0tlRFZnUjBZMTFSdlY5Q3kvQkVodExwTTVmaEVZVW1ETXlIaDJW?=
 =?utf-8?B?V2hsNC83cHJoVXdXcTZMRCtwNWkrbXBxMjJPWHA5ZlgvOGdVVklKNmQzNCt3?=
 =?utf-8?B?c0NBeGVWZnpObmN1eFdTYkh5OHN3ZzFaN2paMHRyTUlad25GZkZTRzEzM2Nt?=
 =?utf-8?B?bXU0VjV2QTZhdHZNdVJWUkF0NXNNZE94TENaUytOdURnY1R2Y3Qxdno0U1l5?=
 =?utf-8?B?U3QvMXF2NTZhNk80M28vanNJTTloMXBUT2F5V0FuWDNYdjNQdjh3L3B0bThC?=
 =?utf-8?B?VWM5Z2MyZWZoZkVWQ2h2anZscExUZEhOdmZTOG10ZndDeEJMS1B6ZEdMN2h0?=
 =?utf-8?B?NHdnVzlhZ2NISm11VkpNWFM4YTBlQkJ2WG1sN0RMb21oajBRaE14WENVMnhs?=
 =?utf-8?B?S3N6MzhVZlRoVzluOFBnSG9PRHVqckhzaFN3TzNLOGNkNWhKT1p1VjJNcUVq?=
 =?utf-8?B?YThkc20rQ0ZhWGVvVXZwbnBRUkJiemUwSVc2RU9OZDhMWkVWM0xOVGpzKzMx?=
 =?utf-8?B?Q0p3SGhKTk1tN1FPa2pQZk4vZjh2dEQwSE9POU1sc1FZdmo4VXhkOFovcUIy?=
 =?utf-8?B?OUNzdlFsMmNidTJtZFdVRjRuTmdpTTBpcVVsSmNvdEgwUUNIclkvdFZVTnBV?=
 =?utf-8?B?Q3gzdTZDU2NKR0lRNmxzUHZpNUlRcHZzR1lqT3I5SUIwaVRWbEdQazRORkd3?=
 =?utf-8?B?YnJDRXRkTnZoejNpclIwNGNHODlyc0p5Z0JBNDk1Sml0b0o3RFNFK1FUVUxl?=
 =?utf-8?B?VWpEdnZZOFYrWTR3VkRRd0RjUDNtM1ZjUnN2cnR6QmQ1c2VUTDZJMXQrTkJ3?=
 =?utf-8?B?cllVLzA4NEphQjBBN2J0NEIwUTRUV2dRV3FQQ0pQRjQxRzR6Uk9IRXBSNDRl?=
 =?utf-8?B?SjhwcExBOEVuaFBranlpQW5xQWFIWnJVejFNK1Bvc3JVV3pyOWUrNzRJY2pr?=
 =?utf-8?B?V0lhbHlzR0pCbGExM2o1SU5oUFBUYzBYZ21JQlhsS3dNUThSeUJCdTluSHl4?=
 =?utf-8?B?NmhuNjVDSXVSd2lmTlhXdnhlZWRwTU1lb1hzWmZyQlNBOUhDOEdCRGdSSktD?=
 =?utf-8?B?NVFEbEtpQUdTREUzSWVNMmpaUGM2WEEwRWRmdmVKNDBiUzF3emZ5eGlFTmhN?=
 =?utf-8?B?OURMUnRuMmh5NXNma3BsM2d6VVR5ZnR3UzJ3eURqVmM2dTNvRmhKbVltUnJn?=
 =?utf-8?B?Wng5OHdybTNMalhUd3JkNU5aNkZHRGFVS0dnazVUV2xXRW9XejZFaDlPL0dF?=
 =?utf-8?B?RzMxYnFiVXhMamplUHFPbUxGVjFvZmVMUkpuNW5lV0NmNlpvaVBPVlBBRE0v?=
 =?utf-8?B?TE9QeWQ0WnNxYkEwYUlvT1dzbDVPRG1qYXg4UFZ5U2dodFRtdS9kVENQUkE5?=
 =?utf-8?B?S3hmTFdIZ2hqejZEMnljdmUvWEVjejRRT2tadUlpdHE0YWQrRXVUYjJwSjJu?=
 =?utf-8?B?d1l2WDNIZHQzWXhLdld0VHIreGhvZ2hTK3FFYzZpSkhLeHcycFVIR1lIU3RY?=
 =?utf-8?B?b2cvaUh2bDBPb2hOcDdWNkxZKzBmY2wvTGdqQkF0b1hwQTlmanBjdC9UOHcw?=
 =?utf-8?B?M1B5RmxSZWZ1allENkVHVEVYZmpveFhUd3hPUzRMVTB4MW5FaGJVYVJuNXZa?=
 =?utf-8?B?cmFRd3RjRVhWMXFBd0VPbDBhenVKNU9CYXRVM3F6aU5hV3dwclBKVTk5bHo2?=
 =?utf-8?B?MVJ4YnF5VSttRGRuQzlMRy9wb3JBTUU5OS80KzdkWWhVNWJkbFlzbEpybHBa?=
 =?utf-8?B?L09SNy8rU2RURmRkT3RrY3ZnUjh2aUxsaXBwVFBIQmVCRGJYaXpxRHd3MmZ6?=
 =?utf-8?B?Vkc2Ym85K2hLWTZiYU5vQ1lmaWljcnY5THpEdHl4NnhxUm5wdkNIZDNUZytK?=
 =?utf-8?B?MHZkRkprSFNjblBtYkJxd0Z3UUdZaFJleUxjSHZJVGxwcWU5UW5JOTh6YXlW?=
 =?utf-8?B?TVlWTGVZSFVJN09qSzlORHppTnk3VTFVN0Q2ZFR5bWIzZTBnNDNQTmZNZlFX?=
 =?utf-8?B?M1Y4d3kvUlNRT2xLZmlrNWFQQXhMYjNZOWw2OVJhVXhMdW8vK1gra1VCU1pw?=
 =?utf-8?B?UG14MGFFV0FWUHhTWlUrdjBCcy9GQUxhSVl3UHN3ZlEzb0RzaThXR1ZGSDgz?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fcd374-fa6e-4927-4444-08dac0fd264b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 20:17:53.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2AztpjGR6ycFYMCJzuUJ/RGAcpXJrmW2riIXFwkJ9Bou4XFlZWmJPUDgTKObEhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3143
X-Proofpoint-ORIG-GUID: RRdPG1SO-j4QhPw0TfqnSuYcgmGtx9Xu
X-Proofpoint-GUID: RRdPG1SO-j4QhPw0TfqnSuYcgmGtx9Xu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/7/22 8:52 AM, mtahhan@redhat.com wrote:
> From: Maryam Tahhan <mtahhan@redhat.com>
> 
> Add documentation for BPF_MAP_TYPE_CPUMAP including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Maryam Tahhan <mtahhan@redhat.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
