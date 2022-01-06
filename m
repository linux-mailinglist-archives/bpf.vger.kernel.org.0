Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED2486CFA
	for <lists+bpf@lfdr.de>; Thu,  6 Jan 2022 22:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244929AbiAFV5x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 16:57:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244452AbiAFV5w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 16:57:52 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 206HYYgD011046;
        Thu, 6 Jan 2022 13:57:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=aONE+vdDpx7NAi3ZeNDQ3UisvqUZruuFv6cKHGdvAJc=;
 b=b7eRu2rPxV3SO4vsB1GLuQZJD0emaU8dATacGsjAYfGenF6NNrCR8xW8vTY4qL1MwMl/
 t5Z+ozQ5Ly3ikuLl2WVLRMd8EsF0kLhgYZsQRM44Rv1Nbk3ornZoVOoYjvHM6lyeAm8e
 bOwvs3L+N1kCmw/13E0KvxjWla9IwpoHUJY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3de4xfspka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 13:57:49 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 13:57:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwM9DVcgntLdi00orN3QKliSir1kj40ntTYlPNJNk4W8i+bhVg1GeNBk8ta+G+Sxpib2Nt2LGp/ujz5xCM6ulxwB/nSwQSWskMDyU9a/BIoRnzn69OuGct4R52GKUyAmBzELSWp8cOKdcXo1Uvp2UOoPNYN6zTi21o7TxG9JijAWw6a7ljoP+CsoK0+ACzHUNYLCNRbMmdhe64YeDANEaTKdzsFTZZ1bolpeY2ZhEXlJYmYmAMJ518b4HHq9HPkFFE8ooFgGypKI872q4Ebf6EJw8D6tThwglMTeyTaAPBcv63JuA0tcEG39kkjo3kPNFE+5K8SCBqMdVwQ6PHKHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aONE+vdDpx7NAi3ZeNDQ3UisvqUZruuFv6cKHGdvAJc=;
 b=oRB0KNGBd+KRgstI9ljdxkRFbjIuXkH3A7eH/+O5/tdyzjG6h7ueSc9UGpYcLRk/e0ODzwno624UgacD1eQTlBlmC6OBTnxR+RMTwYaK/FLDynVM1RkyQIrGFgKqEp2bWQYVzf9HoemHBqfJQx6JdQQSw09qxUAJjr5QkA5cObJvwDtDn6aET+LWIe/f+hVqOpZLFrmgNnZWZsjD0jxcU5LNc2aXjw0KHN9kPcgCvAXYcNoJSRUrMF1MqjCE8Mstn9BHiX6WZfjZkQtpHd/PBQ+Q57OWZ5Yx8nyH5zYSs+X75gw+trbjAlErN7GNTe9VVhWc/iTKvoQloLNcqcc43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4159.namprd15.prod.outlook.com (2603:10b6:806:f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Thu, 6 Jan
 2022 21:57:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 21:57:47 +0000
Message-ID: <97f2dd15-91c4-5fe1-a706-c4433f9d68be@fb.com>
Date:   Thu, 6 Jan 2022 13:57:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v3] libbpf: Add documentation for bpf_map batch
 operations
Content-Language: en-US
To:     grantseltzer <grantseltzer@gmail.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>
References: <20220106201304.112675-1-grantseltzer@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220106201304.112675-1-grantseltzer@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0152.namprd04.prod.outlook.com
 (2603:10b6:303:85::7) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5659352-e4be-42d3-19f8-08d9d15f932d
X-MS-TrafficTypeDiagnostic: SN7PR15MB4159:EE_
X-Microsoft-Antispam-PRVS: <SN7PR15MB415921DF7353ECD297951251D34C9@SN7PR15MB4159.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InK/4A93HKigZ1dRuL7wDxoFRaH10CPxcod/5r0m/LwQpy0G1RiXElom+/Frow1DroXLVW9qFKoXuCj/uBrkWJ0rjKtAxWC3bQmR2M7Jy5vFGa/gqj6l1zTolZjGao3HzvkmMr5qckHNL+2ZxSv2pDvDb4T06bUQVzAtrtJy+gjQ0UW33wi6Dtuq1zKW86sgHOT9sN+T8VTG/gGmMDXxriZ3InrxIZglB8qwW/IgyznNEOiYm2O9rtknn/W7RLFp3vFPaVSBSgyEg64m1lrgICGMQJGz6AOxUcOeciittSeAcl2LWDh0617lsgGZ5ucXL+upwkkpgueXiw7YKOqPNxAGMDhuxZmyCngO0XJEDrDQnNqIuvWV2X+2aVXyk4TPM9a2zc3Rn7Ax2GuSLe/YvPCl50hndCvtuq/Y1v77HugysPsF/t0Jt7VzPgG+PGvrC4z9Og0rWUu+x4cN7ocyfyLeO7NXazF49dBMBiKhLT7qid6FI3AV5yiHj4Vi3QdB3T9dJ4GDC/zUszxP0pohOXDAb5RLH/dd01w5iZLlifIpIVEA/bHWKwGR6CyXqlTVvaKKdY6NslRZuZNEgqMusCouJvT0TMaL7PljZfJJRDRKrWWi7m809d4K28FCwciVlwLqUaebtwWAPuCEk3lKZgahrgdh0uA4rm9H38pdMEa3Ja8f9VUhVKB0RWbGs+/TuDr5QezRxGStvVRifig9Jhfmtqwn6VmpjkzW+46tErY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(66476007)(508600001)(4744005)(8936002)(31696002)(31686004)(6506007)(53546011)(52116002)(4326008)(86362001)(2906002)(6486002)(6512007)(38100700002)(66946007)(5660300002)(36756003)(6666004)(2616005)(316002)(186003)(8676002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlWdThUcUQ1S0JZRFhjM2xRRndkVkxhNExIRHgrbEtDd0JWMVYwRjduODFn?=
 =?utf-8?B?TTdOM1J1SW80R203QnNMN1JLT3NpTVBQQUdsNmRNbHhCbGdnMHVxUi9PMXlB?=
 =?utf-8?B?NTdlVXNnd1pIdmtiSWdJWE14K2NUMTBQT2Q3emZXN2VvZ1hHOEtsQnd2NGJE?=
 =?utf-8?B?aU1tYW5IVlZCb2NFZXpmcGVmejdaaTRLWjA2WjkwVXpNUnpNWHVvblpVLzU3?=
 =?utf-8?B?SHhlQytxQ0RHeEl2MXZ1cTZrRzllS3FZUUpWTjVDUjhGbzJzMlRsYmFPZGJO?=
 =?utf-8?B?SzI5SlMybjVSMlRVaXdZYThSNHBURkJUV3dPTUZYN0NhZmViU2E5Nms3d0dn?=
 =?utf-8?B?L0RQbVZiNmQ2ZnB2aFVKTmJBK2RlV1BJaUMxQWd5MS8yM3d5MjZyRUk3UDkz?=
 =?utf-8?B?dTVaYzVqRkNZRW0rWko2ZWpnenJmTHVzU2xjR09mOGRIREY4NmZkaXFDdWhv?=
 =?utf-8?B?ZTVTOUlwbWZZV2pla01KT28xMzVGT0NJWE1xTFhlbXZLYTB5VXhOVXV6ZFFw?=
 =?utf-8?B?ajBGYWlKL2lUaWZ5TFBadzcranJ1WjY3VzdNT20razNDa1daS1NCOGZwRXp2?=
 =?utf-8?B?VDJqVlBidmQwdUlUMUhMdFBQZ2NHMlFkQ1B3d1VoM2V1SytVQ0k1eDMwRXZr?=
 =?utf-8?B?Q2NUb1hkM0ptcTBBblBrSUtBcFRMK3dsbER1R0h2d0ZpbG9xK2Vod0xsMFd2?=
 =?utf-8?B?ZlY1dVFGaTRWZVZHNXhTa2JOeHJyS2JwK0ZJTUEyRnIwRU1pc25UV3BQNEpG?=
 =?utf-8?B?YktXYUpxbkxaSnhkeUZIZ0syZEh4Q1prb0pzdE5KZ2FYSVZIU2Y0clhVWnUv?=
 =?utf-8?B?MUFjdVc3QlJ5N1ZaNGY1OVVuVWovTzBnRWF6ejVaMnlqdWpUQmZXRkZ0Y0xi?=
 =?utf-8?B?Uk5YTVRuRFplRlZhV1hqR2ZGdzlNMFVTV1pzL055WGd0OGU2RndOV1lXVC9U?=
 =?utf-8?B?WHdyRGd3WFpqeDBMRlVobjRBMnYzYUFHc0dkcWtjelVVcFdraHNYUGFUYWlv?=
 =?utf-8?B?MVBxbVZXb0FvcTYxM0N0VVIreEcwaXhpeUpPS05rQ2swNVJ3UDc1S2gvak5o?=
 =?utf-8?B?QlVEVmNORFVPRmVuY1pDUG1MUkNLdWc2cDA0QWh2bzF1TGN5dERSMU82RDJi?=
 =?utf-8?B?bWxVMnloSXlpTGp1QXNNWnZxMjhuUzBZTFpZMi9uOTNnOHRRVmJwNXg3NDhF?=
 =?utf-8?B?Q2o5YTNJWVdDaS9GR29BSldhNEYzWXE3cjZheXMwUXlCQnZ0V3VVZFE0enl1?=
 =?utf-8?B?WWNqWXo0dHlFN2ZhS0dMUXZEZllvTWdRK0MvSFZKbWkvRzJGeXNvaWN6NGZQ?=
 =?utf-8?B?SHFoOUl2bS8rU3NuZlJTSkJvaFBJMnM4WU5wTFV4WFpQcmtkM0ZQSEpzeVUz?=
 =?utf-8?B?T1pKV3dPRnJRekJvbnpvZC9xQWJCdFdvMnBicDFGbDNORHpHdlc4WE9jcXM5?=
 =?utf-8?B?UExQUWRKL3RldWZPLzJzOEtkUVFaUGZiNVpPRGtXSHhJV0w0c2JnQUZRN0Vy?=
 =?utf-8?B?dEdSUzRSYUZudkZnbk51NTViYTV3Qk5CNXNwZW5DaG9EKzU2UVJweEwyRHZD?=
 =?utf-8?B?RnhneGw2N3Z5SXRaaVR4OUJQK2xwY2lQTE94YlZkSzNvNkQ5WXc2Z2VUYnNM?=
 =?utf-8?B?N29MTmhxZmtQOHRnYzlUbXRhNlRtZmsrMHdmbGp5TklvQVJRNGg1RnNMTWtj?=
 =?utf-8?B?d2RFSUNUbm9tR2tlZjE4RThZNVJ5czdIVDhSQWpYRndMWjl0OFdjeFVFNE5D?=
 =?utf-8?B?UmtoYktxTEcxbjUycmJsa2lwdUwxdTRZaDNzRTBKKzRlaUdhbWszdzlqa3NZ?=
 =?utf-8?B?R3VCZmh2ejRVZnVFZldQMi9mU1hwcUw4cWRJQXkwdDNCT3dQR2pLUU1aa2Z5?=
 =?utf-8?B?eHZJMW16MkFwd0hmNWh5MkJQQ1Z6ZjBXNWtTRkw3WFFibFROMy9CMHhwQm1x?=
 =?utf-8?B?dUtpZXVkem9nRmR4NndrWXlQc2pEWGJDNTUxNFpaMjNQWXJJOHZxdEtQWU9F?=
 =?utf-8?B?azUzUmRoUGZjQzYweEc3T0RrWXA1UkFDQ1MzQlhEMUxldlM5SVN4ZDZ4Q1Fs?=
 =?utf-8?B?dHFPME1XbC9PS3g3bExyM09xQzg4MWRUSW5zVStXdXNjVVVsK1FsRlR1VXlO?=
 =?utf-8?Q?BV/8PxGSDOoImWt09QDbojSv9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d5659352-e4be-42d3-19f8-08d9d15f932d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 21:57:47.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjUX8WM5reDLmm6plXfoR1MbiQ5x3SJdCaba+1XdZzUSHIXN9TG7QbnSJf65nAJ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4159
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: sTJ7WZkjoEZYLvIZtSBS7flxxopB7S7C
X-Proofpoint-ORIG-GUID: sTJ7WZkjoEZYLvIZtSBS7flxxopB7S7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_09,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=980 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201060136
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/6/22 12:13 PM, grantseltzer wrote:
> From: Grant Seltzer <grantseltzer@gmail.com>
> 
> This adds documention for:
> 
> - bpf_map_delete_batch()
> - bpf_map_lookup_batch()
> - bpf_map_lookup_and_delete_batch()
> - bpf_map_update_batch()
> 
> This also updates the public API for the `keys` parameter
> of `bpf_map_delete_batch()`, and both the
> `keys` and `values` parameters of `bpf_map_update_batch()`
> to be constants.
> 
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
