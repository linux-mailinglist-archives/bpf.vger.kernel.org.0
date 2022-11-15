Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1AAE629F32
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiKOQlT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKOQlS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:41:18 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6172B18E
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:41:16 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFEOs0f030992;
        Tue, 15 Nov 2022 08:41:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Ndx4e0CDD8bKe1lRAJBpD1DCe3ENVFnMaCTvrYFVneo=;
 b=TXR8yNIYFOdN4mKA1ay0qXE+bPGkc3D/2boxnxmckmEQgWzQy0T6ITWbeuLpsOxKuAVR
 kdSkTR8cofendi6vEopyKewVQCvmX2D1TXW2ECoQqG696v9TMFz3Z+2cZM1MUHYxLs5x
 FFukrIIWaMOpfWSRHTuhtn1oPS5DrRir8reef2j8m0o/OQvWDAYoYm0YAat6ibitDSkl
 +2S7mKVYFEsg+9GS89hz24/+ICmME9KrQGCEEZqlkIWA0UK2fxtfkwVPLJNHGrWOSlZb
 0uXNkY/RklE6T4I60wrhJTJYyXza9j0ER6UAwEyMbzRgUQvujy7XTSCsO9jhaZShYkhw lQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kvcghhbgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 08:41:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZqSzygFEyBYUTFBHRjBFRekX2X4RgnSwSwWU6t0nlqC35DGJ8aOLI52iOueMDgPE9/5jMeommUeqEGv3iIiD6ixSA5cTQk3hHgLLeETt6W9Jg+77hrrzKaS4Ge79z8dlIw0QfYnQLljtyRGE0QaxtNEDa1T2frZriwHVLcRtBWT13iW0KYzYY2mbLcYIKCasRVhrLU9SO6o8wXeVqFZHIEA7827OQeoThcErOuGuW7fYa8bIg3HH1Dd8jSd12HoPmEz0xGOCTeaYZugxAUHZw2Z9X70hW1/Ij9tmp79nK75mE6hd3cAyq3FCzBwkxWiDUYS4wsHarUNPEjbfXEznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ndx4e0CDD8bKe1lRAJBpD1DCe3ENVFnMaCTvrYFVneo=;
 b=WyKy985GrSaYN7HNZxCDOjOdaHQHvUTu4mLLX9d2n6Vfc6Hi4VTf2m9KTId8R1CVBTSoOA7TyxGs36FPiJ+m9dwPnoxcNbPOjexOWtyhj26IHN9tikqjFWhG8TwR+uZ5+w1c0km3k6Psphf+gOQ9I1tOPXK1qAhmmhsprj6ySEG9ZlhhrSBgxCEhn4iyYLAl8BO52V7QnkRM9JGYyUdGCv8QWqVKbC3SCKsmJbalUnSVNk4TxGBsRaWs9co/YVX08lKOeAUp7XaWr3ZEK0wgwREMKQ5sgTpFRS6pcSnfdJvR5oAulrMjWDul0l8AS1DE1NMJiEQU9tLMp7LO2RqicA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB4793.namprd15.prod.outlook.com (2603:10b6:5:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 15 Nov
 2022 16:40:59 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 16:40:59 +0000
Message-ID: <169ff1b6-aa81-e3f1-7bc4-3abcc616883f@meta.com>
Date:   Tue, 15 Nov 2022 11:40:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v7 22/26] selftests/bpf: Add __contains macro to
 bpf_experimental.h
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-23-memxor@gmail.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221114191547.1694267-23-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:208:238::8) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|DM6PR15MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: f3bd2bd0-af4c-4e26-49ed-08dac7282cb1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jB2Le9ce1TKarXbpn7CcNv3pFLVfxGBbPNEBI9QFhKwIxJXY4xLn3cADvxdlaGLKk1KTV0Tw5QnpX4m7GjoVkX6/EyFH8H61dkNwoWuI0qzTuZey5Lj/0lg10YUk7dPYvNW8OR9hqQIUDKoTGSeZVJpGoGd1zoG5QkABP2lmtkneNHzcERaDDFMGj8mdnsbQ9hXF62kjM1rQLko7MleM0VQpzk2Plhbv1raiXa1HbLjR0ZbnBiP3zQcfGzG6d2e0uz5PHE48JmBQNTodqyn6uh3nh4PqV0Gc3QdlrHvsvSH+a4QHTsaZUnVz7WJD8NSnsKa6FJ8NvHgdomm9VcsDXxNRGhYVTB/36VNnn/vERFnCl+kU8KVVhQGUKgfNET8v3hWLfTwBKD2yA1083HAEVKFiYsYcDO9YZiO3W/f712Z3R9CnaKTMzWgP9BvQrBKvts2pZdk2Kbtbvi4pKpwUjA203IFyLgaQiZI3bDVz67MiMjLy2qGvSADAVjXn33A+MI1GIoX8DbLKnraTqRTNOmAbohGA/Yc30Kry95pD+Lrep4ME30ajqyk1hMJUM/Q09+1IZE22tNgx7xA0KZdGkuE0+31ce/ILdWJyRlgIB+V4fr8Y/KDZapqz//fmBINhaFCKOkROV8fDs52SDMbSJ9QqDJuSZwpfkdp7l9BtAfNYwTokgdcoNhqtEhpqTz+c1C1GuIEO+TbjnNoxLZBedZvYOI3gyvACY+tDcvXppBHm86BIM6w088GypEjXur9wI3kj8Xyl6mwTzQLHo2VWRQwoFpb3M4RbhdPkg3KmB4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(451199015)(31686004)(4326008)(6512007)(6666004)(53546011)(6506007)(2616005)(478600001)(4744005)(8936002)(6486002)(2906002)(36756003)(316002)(66946007)(186003)(38100700002)(5660300002)(54906003)(86362001)(41300700001)(66476007)(66556008)(31696002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUgybFVQV3RHc2RldkRkbnRjVkdiZ3U4SmUzcjh5K1B0d1NLV2RLRkQwWjFO?=
 =?utf-8?B?THpZdENHU1BQbkM5VjFXb3ZLMHlKcDBYSWtGNkUrWUhGbEtBRFd0LzdFSFpB?=
 =?utf-8?B?dERaU2xPRjdEZzUxMnd0aUVNbE5HY3l1VHlzaldxbE10WE5udlR0QlNsWG1R?=
 =?utf-8?B?MmN5bW0wUFA2SVRyejFZS2V5cmpOaEJuK1B5MXpWK0RzWS9LaWRIUlVZR1ln?=
 =?utf-8?B?ait3QWlDV2xXQ2xzdTYvNVIrc1VBdkhteDdkeCtXd1JKZXM5NFpORDNRRFJC?=
 =?utf-8?B?R05RVitOcU4vcWxSV2RseFZYeE5UZ1lrK3ZnT0EybnpuQUtOemZOeTJwL2lX?=
 =?utf-8?B?a0lDaUFoT2ZoeGt4ZElQYmE4VngxVmJoRE5aQWIxQ2xNTXB6ZGJuaGVDZXFG?=
 =?utf-8?B?NzY1YVVSWlkrbzVvTUhrWDJLV1ZpZGI2Tmk1V09lVzdXQUtvTXNkTGFXOG9z?=
 =?utf-8?B?dm9oTmhJQTd1b0x4YjBVYmE2SlhycTVuMmdQMUhUWkh3dkhBUkg2UDI4RldD?=
 =?utf-8?B?bTlqemtQY3ZWcWZrdEZFbFg5Tm1wQWNkaW5BWGw1UlZ2RTBReWZIUlNWN2dT?=
 =?utf-8?B?VFpzQlEyN3RacTlHSlN6SW9KWnZEVktkQkZTVHlkaHc5Um5JZXdWQXI2WVlh?=
 =?utf-8?B?UEh4R21oeHNielNXYi9NUEh6K3k4ckw0c1FkZFZiZithdXBPZVB6TUFmWkV4?=
 =?utf-8?B?QmxhUjBWMUdmWElxZWl5bXgxSGFVSGlOQkE5Z1ZsK0RCZzkzYUFzd2xZWUE5?=
 =?utf-8?B?eEppU2w4dy95WVlweUZzNkZwL1JDMTlGbXBzSnZWa0krdVBxNi9OWkRzQ0M0?=
 =?utf-8?B?Q0VmNXJRTG5rQ1o3a2FXczlZNHQyNytqZFFXT3ZjeEk4RUJwSHM0SUhhaEVw?=
 =?utf-8?B?Q2VMZjJ1K0tNbEJMMGlCV0V1bFVlbjhFenR3Vm1JVWZkZk9Fa0U4ZlZ4NkRm?=
 =?utf-8?B?QzlCejNlUzNRVEUrbFhLUWF3QWNqNVJkb29rcUJFMkZQVWpQY3ZXdyttSjdv?=
 =?utf-8?B?NnIyWTk0WXh2NDRETWZHZThZamR0SDRob2J3TVN2dDUxeUJlQ0l5d3ZJUGt6?=
 =?utf-8?B?SWpsd0NHbzdwM2FobTZnbE00N3Q5a3FlL2tCMGt4UmhTdDhpZ0k4RUVmNHIv?=
 =?utf-8?B?RGFFQzhrM29Bcms1ZDZaSzFCM0pYcldkWjlyb3VQL2txMmRyTDVENTlSMTFm?=
 =?utf-8?B?Ty80ZGFBKy9xZU45ajBIVzdkMkczOXhMSTAvQXZ4Mk5tKzRraFZOOXJtd0kz?=
 =?utf-8?B?QVJueDhXSHhsaWtRM1VyOVJ2dURPRXFTemw4WitpQTZYaXFOZlVSQThoRXZL?=
 =?utf-8?B?cWh1cjBKKytDOG1lYVhZN2YrbkdBckI2QVo0T0lCMlFCN0NyWDlVM0pTQmZs?=
 =?utf-8?B?cWhwMnhWTDhLZERmaG05bkV2a3NnZi9udGNHbVU0SXVIeVE0OXFNWXdCeGhw?=
 =?utf-8?B?UzJjVmVOdFlvQzlseHE1a0NmbDNWeHRFTTlBc2pqZysweFFYT1E0N0hRdnRH?=
 =?utf-8?B?QVBPRnRnNW9BcVQrU2w0QXFGQ1Fxby8zTS91MEdTMkJHdG9sR2lyaE9KOUhB?=
 =?utf-8?B?VVJGMnI1Z0J5TXlOTmtCZG1QMmU3QzVENUdUeHRWd0QwOVVjQzVwSkU5Vzh3?=
 =?utf-8?B?T0hmOVhiZnFmSDQySDlwZG81aXg4Z3dYaEluWFBrSE1UNnRBWEl3TVUvOFhU?=
 =?utf-8?B?ZWRLaU8rS0JwRGhWTkoraGhlTGpwc0ExVkdXUXFxSG1QVHI3bncvODhkd201?=
 =?utf-8?B?MUplUzlWdWVUdVprWEFiVjBNUi9lcElnQk1vMnZUY3ZVUzVxTTZaSkI4ZEg2?=
 =?utf-8?B?Rk5QdUs5TU13VVdISzhNTlladEZ0K0Z0RThrZ2tQV1REL3p6a3hsRTZCMkIv?=
 =?utf-8?B?Q3duYzdOUzlJeHA3b21nUS9wTnhHN3pXdTVEMkI5ZE5NZEp2UVNnejFKLzFG?=
 =?utf-8?B?SGltN3g4aE1jTmNsNWRxcTdUQnRTeHhBY2dkOGJNVkd6c2lKWlEvQ1Y1VXhD?=
 =?utf-8?B?NGhTaEZsZCs5c1E4bGx1ZHhEOTNKelAxM0piMVhVTmY0MG5tOURYV2NHSnIw?=
 =?utf-8?B?L01kUVFGY2xFSDZZRUdQZ1dJdGZROTBwcG1kUDh2Z3Fta1I3ZHBTUWQ2R2pM?=
 =?utf-8?B?SFpCTzdZZW1vUk0rS2U5NzEvZVMrb0w2TjlIc3BEeVl3bzBYcjZPNXpxSVd6?=
 =?utf-8?Q?fRCc2S7AX0oOnkLBER+F0MQ=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3bd2bd0-af4c-4e26-49ed-08dac7282cb1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 16:40:59.0656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrus3+nzk7tuMMVOyFe5v7+DYVD+eYMyAY4nJWGjgmpvDYIg+31Hc4BGyi5UuMQAwcsqcu+OiLb0VHAZOTakoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4793
X-Proofpoint-GUID: qLd3vljfiT7wEtLhQ9Z8nW8-sZZmQTg-
X-Proofpoint-ORIG-GUID: qLd3vljfiT7wEtLhQ9Z8nW8-sZZmQTg-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/14/22 2:15 PM, Kumar Kartikeya Dwivedi wrote:
> Add user facing __contains macro which provides a convenient wrapper
> over the verbose kernel specific BTF declaration tag required to
> annotate BPF list head structs in user types.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
