Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875262171D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 15:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiKHOpF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 09:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbiKHOoi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 09:44:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149F2ACD;
        Tue,  8 Nov 2022 06:44:37 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8EejJ5008279;
        Tue, 8 Nov 2022 06:44:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=de/s4os0hX4skvZoyfUOtKN5dydhu8Zru0boaCUHwC8=;
 b=OqEPtxvYgMCXoyrEc7GfprWPPFtJBz0My27UMMqcAFQxNzlxl5/k0Dscl11kONjXHncD
 4jV6ZzALy1f2zsve+rwfHBFg/xt2WTVmC5POLKfw/22RjNwm8gfJ4J2NHgv3vqQEuCdW
 lhaqPe32ybmjQLLorShhBJEnK+s9bPnuC5lRQ7FV25NcO4WjCBLMsX2w/auSGBkuxim8
 g8SpntADMBW0899WiVMQZadg0xuRaHTSytlv4eaVCAme+S7DZiE1D71GViUJY17qoEMS
 yCm09HuAnyHE1ndTRkeM6fJSu48Ji4VaNqOp81LvgFqn5mXe1tRBBcszOK42iVG3dPln PA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqcmqvut3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 06:44:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YzjxmTAU31H2X0ZaJr13aQhxBmyOhtuYNe+SCk26wc5JK8DBxpFOc7CvLMUOuKyX6rOc7bNjOrcKeBOipKE78Pe6cvWKAQaKfTnx0edrvjr9J6IrySFDS8mlc02541Wi5OxHkkH7fckQPDXEERZYDzXXh2h1gw8lXM7PZ0NTRcy6fGFFvwgHmdXhMOiRkF5ocI47h8+QtUgZ5O5aA6UxXonFCZyxF6TAy2ketQeAk6sOQj74fJfkXBdOfICa7rZpCS4nzF5p1ZJcpdPkA1p61KwELzXwWgIbrHsOSdaufmOUJXGtFqeSmfqMzhpEI6ic4e7yToR2OexKcEDnaTiMxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=de/s4os0hX4skvZoyfUOtKN5dydhu8Zru0boaCUHwC8=;
 b=exjFgzD4G2eVCWoRI38PYLqElg0iQoq4KUIgDx6R2CPN1ogeg6Nt+CvGulN59R3+EGzZv9jHpZNgLDsVqkHvEsYiBu6S2ReRZ1KkM3g/LkKmKim/KcPGicf5q4pWXaTAsIYLkbLjQ/ota0AVlK4AAzlYHHMgE9mdU0Un4kA1yHcKEJ9jzuJXtaGD2F1Qjmx7cpe/GrSNSg0ALSggXssNvSBbyAqmHnlEOjS2PJgpuqvCu53uNGHVaCgxT2FaIhBpBzjdUc0pWtcE5yv7LFlUxwEWQwG6qiIRJoOnAN/u2CTUI33CH0CpcQwSn4/UoM655VdwbckcsydzLUG1iWodMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5225.namprd15.prod.outlook.com (2603:10b6:a03:428::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 14:44:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 14:44:11 +0000
Message-ID: <58105849-3811-f948-6404-888437726a20@meta.com>
Date:   Tue, 8 Nov 2022 06:44:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4] docs/bpf: document BPF ARRAY_OF_MAPS and
 HASH_OF_MAPS
Content-Language: en-US
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>
References: <20221108102215.47297-1-donald.hunter@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221108102215.47297-1-donald.hunter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a5abd8-3f15-49a4-47bd-08dac197b2ff
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wSHvm5EY1AhlPH61uV067YusMp39WLfAGCANYYUVSf4LZ6VCaFueyCNisLoiBi0jeHQzYqn0fhqb+0LkNzFrQX4wu1Ahe4pG8EjcCYSuNu6a/2Obnntek6b0zMiAlruOG3jlywqcaW5Hi1Gkn/oDEa1H6nZvGpeClTeunjvxcuzgP7UpCXcmT6gaDzmz5wOGoi1wit0G1IzLzfZY2a8/xDn8WXXDo0YMKb37ghwVoehER/pqAov4H50bot+EwRagNwVyDzXYfVS8uheZ3lQ70trDYRcOL3zU975oDd7jUV7mq5sfrGd20zzmxtsvfqgcgzpnsT5CJJXGAalbqEo3zKo22v0fNYW9KUd1BQ7a3Y+CZfbare/hNMqBfW7EEozLF6ziM1z+g2vkro9td674BM0Z0DPl888qjXAp7xlFf6ZI7JT3ACXEscX8RSUCtl6GRM7FZmfEZlDKkxGMFx+yloyxHDbOOd774Z450+G/HnEO3gPEBjlgl/RG9jp4nr3THNt0tkCrItmMG2PIEAeRBCwgxrp98U2UpIsacPCVYOYv5hc8Ruw3koWRFS53WHPx/NzKfx8i1/biaBJmYnZ7zSxqN7buGDe0hwAzSM9ZfAQ7r+V5XguhOC5Au++NTfhhrjK0itkctUkO2OJLHRmQMwvmExUk7rx5xFldSdLTFNXvfTwz0BF3B5GKRoWpfppfyyuSJaKMHHlpPa/ntkFu2ZuTvJJaPbJf1QF7FUVVuiAiYqVqn94zIQdNg/CbJgefqPEj1gQA8wZdfuFwDJjYm7QBiaBYbfZIEgBEjJqeoAs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(376002)(396003)(136003)(346002)(451199015)(4326008)(54906003)(558084003)(66476007)(66556008)(8676002)(478600001)(6486002)(2906002)(316002)(8936002)(5660300002)(36756003)(41300700001)(53546011)(6512007)(2616005)(66946007)(31686004)(38100700002)(186003)(31696002)(86362001)(6666004)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUJxLzBmRU5CcFEvR1RpT0NvUTNxaGoxMkRNL3doTkdkcnUxekdOYmF0SThq?=
 =?utf-8?B?TjFMYUJjelpqaDZodWZZVmFUbk1DMWNoUnZ1akg0MGg1WGVXSDgyKy9MT1lH?=
 =?utf-8?B?VzNJdEN2UFBRSmcyZzJqYlplYlE0RXAvcFV1WEpCUFhqbE0zWTV1WXh6SmpF?=
 =?utf-8?B?LzB5UUJFNFhTaHNEYmFqL1RSYW51UUFoQlhrSzQ0V1Z1cWRkUXcvR3ZhdlZF?=
 =?utf-8?B?cS82NEwxNTNqby9ZSmROMHd2Q1lvZ1JJUVNtM1ZXNEdrMStIVERTa0FqQ2Y2?=
 =?utf-8?B?dnNsYlBoaU9jQnBNVnRQSmlKanRaK29kUUFBUGR1Ym1ISy9POVJqUkNGTXFs?=
 =?utf-8?B?dC9sNndHMkdsV1BpZXh4UHNsUzJuNDBYd1dYLy9pN0lwU05VdlpyNEREVG5k?=
 =?utf-8?B?a3drN1N3bkF0THNvYjQyV2ZzbzhqWmV0TWhTOHAzTVFIRnJ6TmhpekYySDRI?=
 =?utf-8?B?cEkvbzFrVmx6MTV4OExWOFFRUXZ3MkNKd2xtbDM4c1ZkNzhxT1RyQkRrN0Q5?=
 =?utf-8?B?RjNqTFB0TVdDVVdHbmtreDlvbTVlVmxsNGlpN2QxZHVUQlVRVVFHOXBIMkFH?=
 =?utf-8?B?eThRZThFTkhwQ2c3WlNnT1oxYWw3NEQ1Q3lTM2NrMjl4UE00bk5BTGVQdnNq?=
 =?utf-8?B?VGZhdmcrZmdhSCtBRzZwS3pIM1RGR2Q4NitkRmxIMXloMjdlbzRGTWlmUjBv?=
 =?utf-8?B?NDhYYUhpdGxPbElaKzdGQ3I1dmt0QlNCK3pyZUFEQmk4T3FMUUc2TFpnanFu?=
 =?utf-8?B?T0gzVm1aOCs1YzFJaGwyOCtXSHd3aVBNb1EyaXVGK25sVi9ETzRmOWRFOTli?=
 =?utf-8?B?YlB3V3hDcGQ0STZzR3MvV2RVcmNtZUV5Qkt1WlZab2RwVEFxRWttejJsZmpV?=
 =?utf-8?B?U0d0NW9FWEJtODdteEM2TVpjaVY4d1pXaHdxTFdhcUtPbkxEQVpKaHBZRVlL?=
 =?utf-8?B?NVlnVlZKK1JmR21yRnUvNHhLUkkyU29nbFJTQWZxNjhiczdaQWIzUFpKZ2Z5?=
 =?utf-8?B?ZzgyTnFEOUNwTUxpQ2Fray96bDlDaWh6Q045QzY4VlprSzB5RlhvOFA5N0dn?=
 =?utf-8?B?bGpXcGdieU4vbjBLanpTdXN0NmJtMlRiYTBJVmppancza2hjZ2o2WnRkZ2Z3?=
 =?utf-8?B?WUdMMFBsck00dVFHdkNtblI5akVSSHphTHltd2RjSndQMk5sV3FjdlJJQUls?=
 =?utf-8?B?aVpEc0lwTm9jVVBJWkVwcnNKVVBNbmFGQjRNdXRadmZIbG9VQjUzd3IxQnNK?=
 =?utf-8?B?bk5YTnR6KzlXMjVOL1NLemQ5a3c5NTJyVndCQUZDaTF1N09QeG5KdmdFdm5U?=
 =?utf-8?B?NmszRVhMbEM4Z1RnMWJ5SnNwSVVmWHdveGg4UXNNakhsQ242UGdpL2JOY1JH?=
 =?utf-8?B?b0k2aGt2VU02VTVCNHBNOFh1dGNXd3phMDF1ZGEyclJsRGoyTkRHdVNyKzVq?=
 =?utf-8?B?Z3ZLYU0rVnhHaDgwZEFnRUpQNi9LMS9lbExhMkxhNCtlVEtLSVloQWF1WlZy?=
 =?utf-8?B?OHBaeS9ENncyWkI4dUFHOGIrSXdVN2FtbXdNcDVZUG1TTzRZeHpEVU5XdzY2?=
 =?utf-8?B?enRKakowVzcwK1hwckVIU3F5MjdkcHRNUERwZHpsa2l3Qk1hUUR6c2hSV1Iv?=
 =?utf-8?B?elJGT29OQnJRNWw4VW9zQnpOc0tyaC9DVFRodkk0SnE5Uyt1VEQwMUpVU0ZD?=
 =?utf-8?B?VFhDRTNYaUVDMW9GSXRvNzIxcDVWaTNyZDBMSzFlS3NOMjBUUTZLWlN5SUlt?=
 =?utf-8?B?eHdseFVON1lBcmdkK1RhbGM4b3VRdFhCZWJzaUN1UTVmVmVoYUZuVGFMK0Jq?=
 =?utf-8?B?bnBuTWFYSmlscTk1djFOanM5R0swbXlScUxKbi90akhLbVhIQU9ZRDNzVmg4?=
 =?utf-8?B?YnY1YXZIcHM1cGNITlBuVmFKUjBXNURGRnByMTRDS2xWc3F2bDN6TGtSbVJy?=
 =?utf-8?B?QmlDS2prTjJBeFBXWFEzeE91bmFjcSs2Ty9xQ3lLT1VBUmMxQml4bTdDcFZW?=
 =?utf-8?B?QTVPQUp2bXpBYnFlNEtESHBrVmhIYmJuTU9OTmVkZnJzWGxnTmhHeFY3V09Q?=
 =?utf-8?B?R3FHSjZiWHY5ajV3N1I0UUR3bkU4eXF1c1Y0QnRlN3NqLzBaWlpQWk96b3JB?=
 =?utf-8?B?TW5DdnM4OGxpYkJ1bTFRSWh0eDZNZ0tyOVMzTCtlY1A3RFVYUlFyVzZaN1B6?=
 =?utf-8?B?NFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a5abd8-3f15-49a4-47bd-08dac197b2ff
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 14:44:11.5518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50pwlIBViTEos9ewkibAp8bSkyXemmU10ACkQYxWvLLIGTPLSAqJeBLRHAQ2lF74
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5225
X-Proofpoint-GUID: iBGaSsSLux5MZvQsUKCIFFdHMlOFWZAm
X-Proofpoint-ORIG-GUID: iBGaSsSLux5MZvQsUKCIFFdHMlOFWZAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 2:22 AM, Donald Hunter wrote:
> Add documentation for the ARRAY_OF_MAPS and HASH_OF_MAPS map types,
> including usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
