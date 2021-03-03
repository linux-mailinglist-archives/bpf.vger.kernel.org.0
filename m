Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6025632C229
	for <lists+bpf@lfdr.de>; Thu,  4 Mar 2021 01:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391967AbhCCW7d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Mar 2021 17:59:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:30506 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1388057AbhCCUpH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 3 Mar 2021 15:45:07 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 123KhLPD007722;
        Wed, 3 Mar 2021 12:44:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6hzpJP89AFiKwLfRjjgMOHu5ZVarVSIOHEtnFmK34PE=;
 b=hP3vH7+EaHCiDWhKA4q1ZeiCX04/Nlga3Cwp51ytTTE0AQF72DYdPusMSbs/WqmGM2y0
 EJtxVVhmLjA+F3wMViVOhCZQho8S7E6WrMHA7Ximgz7NfIQDCH1oL4qEVEb8D/icEZgf
 faGn0g/djQ2XK2HD5iSPRSFfXtRmtMAvE+o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 371uu3pt51-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 03 Mar 2021 12:44:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Mar 2021 12:44:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8nrLjqcnueHfhRuGq9SN495FGBLrb185x05BQglEUNiZWmk12gZD8oWObcBlF+GhW3YwNbZhhvTHB+/IfzkgdLpSyAKpB85fU6fec2ecnGbz/un0SEnltu7Z7Nd1B/Zx6r8JMxaA5a0/iygQl/Olt43EW/rUxh2YzgJznMdnxKdYPqgeZZPqZzCd43ThZlkGixZ4A5WDFNciwoOS8HBVSbr5R9vuJGFWNkz2JbYpSm0KFMVCoxXX3ghpJW3edBbpwiJDRuNRU4s1gNLNfODvwYsbJ2OlK+IuPxrTy/dFNtfy8Ixe0vJTmTrvNyIoPmYlJBAche9G6ZeP1cYbWTobw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hzpJP89AFiKwLfRjjgMOHu5ZVarVSIOHEtnFmK34PE=;
 b=e/Q3/OHgbNnrmz0rVgrdi4pkFd+MxbWA/RuXR18CcCrqyn659cOvGqU4uDWLI+Ydd2hmR4fgZZ2lKuQCTaIgH0OBSBm/V2P9KioInDp1fVSRo02S/bMM3oQ2QaZq+JE0vZhEY3p1Icx/kk76Ui972RLZUCYjRPhAJloDSdb/R18yfISJxUi/TxZrYUkPwMXuLNo/Aj/BLAcgYK5ZA4LtPMXRi/k/1yAERKaTgKYOt94xjMCTxKA4zlUmUQFMxvOONZXNZ1bOer//7zaeJDazIlC5M+25+J6RKREyhbTHAfGpk/W32HKrzlB40M8pEuYP6eX3uul/eaaveQbrXswh/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4339.namprd15.prod.outlook.com (2603:10b6:806:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 20:44:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 20:44:09 +0000
Subject: Re: [PATCHv2 bpf-next 08/15] bpf: Document BPF_MAP_*_BATCH syscall
 commands
To:     Joe Stringer <joe@cilium.io>, <bpf@vger.kernel.org>
CC:     <daniel@iogearbox.net>, <ast@kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-man@vger.kernel.org>,
        =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Brian Vazquez <brianvv@google.com>
References: <20210302171947.2268128-1-joe@cilium.io>
 <20210302171947.2268128-9-joe@cilium.io>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <747d100f-fff8-ece8-f69c-42b30dfa5e63@fb.com>
Date:   Wed, 3 Mar 2021 12:44:06 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <20210302171947.2268128-9-joe@cilium.io>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:94d2]
X-ClientProxiedBy: SJ0PR05CA0114.namprd05.prod.outlook.com
 (2603:10b6:a03:334::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1a32] (2620:10d:c090:400::5:94d2) by SJ0PR05CA0114.namprd05.prod.outlook.com (2603:10b6:a03:334::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11 via Frontend Transport; Wed, 3 Mar 2021 20:44:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dce1ba67-8671-444d-8180-08d8de85181e
X-MS-TrafficTypeDiagnostic: SA1PR15MB4339:
X-Microsoft-Antispam-PRVS: <SA1PR15MB43394540A3C00DD20D929113D3989@SA1PR15MB4339.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hyblm8R6ssLrSuqKVZd3lZI7KKdPXtzHmhuZkGZ7l398Qd8+9msL34bKx8+aykTFBZWU4RHxh2rU5CE1rB3KFvGL4LqsYekTDEbr4lFFviohg34uZJ1GBj+4SRdrq+jgTZNYyzzAmtDjJOeuOZF/3FadQJ0m3V7bUWlmiHcrb9I+GtyA1YYs1zC2Z5zn+Jq+cqlkLRwwIAkAbeH5iAX3XqbfugYNFVkjIzWoa8SsckJ7FEYwrH0ngBZwgxfxshbZNF9psWk4h/f+3l7TzNG7/9yqHbw7NIOyCez31uuyAF8D9Ns1Del0i8+6LvXoJoh2M0xFaWiLVlcoP4P9ETa8gNLj1mqwkYdJu1No1J6I4aeQfmOKhw0r+KSb2Xxw5xsrk8SVLY8h9IMnaR+gWFvKYwshCsLuRXRLI3LdTfNgjOcaGOKi8zbpLoUg5/g/u8B7XJPOZoXNXC82cY3lL5gpTchLr8Y5GRDv+HvFbydCtT9BUdxkY9UR8EuhKzPjiY8R3pIxouHAmD0bzNejQCM5z0CiPRJdujhrdXnub8f20FPVjGUla5IYeQEhdOyNMXgfZ9w8j+mO9x5FilUQCJTXnrExXSmPMH2bPV+GtU/934I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(39860400002)(136003)(376002)(346002)(83380400001)(4744005)(66946007)(316002)(8936002)(52116002)(2906002)(86362001)(6486002)(66476007)(186003)(66556008)(36756003)(16526019)(8676002)(5660300002)(31686004)(4326008)(53546011)(2616005)(54906003)(66574015)(31696002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?amZnUENyTmUyUHJ1WjZWV3pMVnp6YVBVWDNZdHZnYzRjU3pwbUJaT0p5SFU5?=
 =?utf-8?B?UGxrdWpqM3FIWlBRWDJVL0N5dk12eHF0VWNoRk5FTThQWVBiYVJpNGJ4a3BO?=
 =?utf-8?B?bVBaQWswOXJxbVdyeW1LdzVmK20vdU8zZlJ1U2hLSnh2UFBaWnVrVzVrUlRo?=
 =?utf-8?B?UHVKVjR6b01KemNJcmxTbFhwczFzUVBKclh4bi9WaUswUnBXN0lyalE5djBO?=
 =?utf-8?B?aWhYYUNpMkdzemtyU1l0bnJ1d2dmaE4wY3JWa1laZ2VDYWdaMTRYZStuc28x?=
 =?utf-8?B?d1lxKzlYZ3V6emovNFVUNmZva0IxWEZyQVJRRmNkMzV2T1lhMlZERWZjb0lw?=
 =?utf-8?B?aWswaEt4S3Z6NnNYaFp5OFp2M0ZpaHdCR1JwU0g1OTNQblVtRnIwbktnZnc3?=
 =?utf-8?B?OGp2TzdTN095VTB2UDMwZ09yQWRGdFpxenJTVEY5elE1ejhHM1lvd2FUTFhT?=
 =?utf-8?B?UFo1cStGN1BqUXA3S1IzMjFQRXJrSy9tc0w3R0E0dS9LeThuSFpzeUV2ZnBS?=
 =?utf-8?B?MS9wWHF2U2VVVkg2NnBwLzN3SmZMck93RG5oaWRQVEdrY3c4QlFVc2t2K0ZG?=
 =?utf-8?B?MjN6UHNRY0YvbTR2M0dzQmhsUUpuQnpYZFZQL3NLNTBvM0w1S1VkVEFzRjZ2?=
 =?utf-8?B?Z2lDNFlNL0tKK1l1TEs2b1NRQmxPSitaMkwySm1xL2l0cS9GSUhWNVo3SHps?=
 =?utf-8?B?dUd3RjB4SmxxMHdVaXNLZVBRd05LTmp1Q2VMSzhYM1BmNE1jWjMzcWJQQUJr?=
 =?utf-8?B?d3dwWFpqV0xvYjNMOTUvQ3JsQTR6SEViYUROSmFTRmVIT0E1R1VWczdnOTBE?=
 =?utf-8?B?THE0MEVJb2d4Z1c5c2g3Nlc0bXA5Wjd5aE41STlNT1hMUDVRZVZpUGNMNHht?=
 =?utf-8?B?WGpRRjVsdEs4WUh3YUwwT1VjY0JwWDJWLy9vZWlpWFE0dXFUQ0t3eTUxam1r?=
 =?utf-8?B?STRob0dYdVJjanpWME85bi9hVDJqQzJ0UC9WZldnTVZmbnhDR2FrNFJQTEc3?=
 =?utf-8?B?RFVZdHMzS2NRc0NWdXloWDBtZFVPdFpQb1BjVEJqYTdwKzJZUkNzRi9PU085?=
 =?utf-8?B?Y1ZSRnpYcHNOMGZWNFpCNG5ObXJaem9LMnhLeWhueWtUbzRiU2xUVWZXaUVv?=
 =?utf-8?B?T1ZLVURDb0JNVFA3NmhMQ1llZ1BxMHdwdGUrWFo2QU5XaUZpWG9GeDlMM1hk?=
 =?utf-8?B?S2JWVzhPb3B5dlVoV2FQL1hBNlozZERzME1yUXVodjRqQnYvTlJZMFJQZm1i?=
 =?utf-8?B?QzRBdXgxNVd6QnNtMERGbVMzUzR2blBhZDBkcjZtdXFlYUxXbnI2S3hCcnVE?=
 =?utf-8?B?ZXJ3bW5weEFNVGtWaXcrVVQ5bG54c0VvbzF0ZDY2czdNVk5vUDdmRWxhNE8w?=
 =?utf-8?B?anQ3amwzWm9tcEJuSnVPWG5wN2p5RFFORG9UQ205UVRLSEZZWDZhcjJZSDB3?=
 =?utf-8?B?TFNoRUFFNTlTdThwdTNsN2VkK0NUQVg1RHU4N3FmckptRy90ZW1NdmtOaTlz?=
 =?utf-8?B?Z1hvQ3Vid25XNExGUEI5ZkFPZ3BxWDJQZE5heWxKRHcxU3hSc295ejVRRFVM?=
 =?utf-8?B?dkcrYW84VHRjWFdqOHkvY2ZHSWNVc2NsckZvWnFFbmp1R3ZaVHhMNHpHZ1RL?=
 =?utf-8?B?ZW4yRlBqNjQ3Q0E5aFRHVnpKUTB1NEJlMHZmeVRBN2ZBeUI0WjErTzJHQVFx?=
 =?utf-8?B?S2R5OFZCdXdYV0EzS0FMYWZUejE2b1lpbXdPVTc2ZFRuNnJOUXB6cXA1UVE4?=
 =?utf-8?B?RktLbjRUNVJicVp2dlRKUHBlNEVsYTRTWWhiaENnRVV2SThvWk1ISm5BZ2Fi?=
 =?utf-8?Q?AEBBheGQnNvaQvl33mk+B7LLlAdMX4dolT4MY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dce1ba67-8671-444d-8180-08d8de85181e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 20:44:09.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzquxF5e/mCkms9Co0UizQC+ZqfBzq2JO5wfEKcAhaZVFvCiGaKU+omcvuRjKQhL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4339
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_07:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=731
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030148
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/2/21 9:19 AM, Joe Stringer wrote:
> Based roughly on the following commits:
> * Commit cb4d03ab499d ("bpf: Add generic support for lookup batch op")
> * Commit 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> * Commit aa2e93b8e58e ("bpf: Add generic support for update and delete
>    batch ops")
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> Signed-off-by: Joe Stringer <joe@cilium.io>
> ---
> CC: Brian Vazquez <brianvv@google.com>
> CC: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Yonghong Song <yhs@fb.com>
