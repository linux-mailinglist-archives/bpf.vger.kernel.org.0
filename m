Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B4604CBF
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 18:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbiJSQGt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Oct 2022 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiJSQGZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Oct 2022 12:06:25 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534F3BB057
        for <bpf@vger.kernel.org>; Wed, 19 Oct 2022 09:05:07 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JEWuw5010290;
        Wed, 19 Oct 2022 09:04:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=HofSKEqBC/Qv/Guo6pk4rYGGmoPMQxJxXyozIvsZ9VU=;
 b=giUFCpEmvBwaLME5StHY0mw2C43cr9iA/qgVsWA59yIffRhFx9GYYvZgnF+4b+PC4Bj+
 /Q4Waw1XQfAdQAcjgA2uuE9LelgOLeY/TCv+8+cLygbz7jrsW0o0WiLOVjFaI0jdTWTF
 v5y52DllaJMGTD+Yi7CBey0Dt0/cRkr9/bg+Ylk1HqA+1l8M4JJvmoxHfwAQqAR309Uo
 t8BIBXr7gj0+PEnBD45K6ogZX/mbRHMG07kF40/8f7FccFQq/2Be18gMyUHpZ47Axx20
 4z6md2SKm5CWOdXl0ARWo9AqqiRZKpbLLlYI+xYJxin7friyAN/Y/PYlLXFBMU2NN1tH 9w== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k9eynn55e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Oct 2022 09:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WzVOoFg2BpWO8YabKXErRDFHvAcpsXR4m0WIBGvIt2GkjPFwD02IuLSvJ8ncc90IIEnDY3kiNbDNBBSlIVQx/YGWycTTr/DRHdJNKsY03ZwOefSy9YHW19413wZQT/+TSRMC8hBj3YC/9z0SVepCI6BBD8j3sBUO/nuExyNx8mFz9EZQYHp6/F27t80yel6LsBT77l4rn+GizC1M9HlcUA9NFdGKdWnwM1Ps14KGxQZLXd1kRlf/rkxdvs61PEWCfEhogPMljByOA6C2YvbTsWulEJVvn3Z6QUQq9hYB0uhFJGFedh/ShqDYpczZN7kOq1TGimDXRXRH2nLDLJqzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HofSKEqBC/Qv/Guo6pk4rYGGmoPMQxJxXyozIvsZ9VU=;
 b=mQcc11zAQonvXKktESq6bGZTaxP7CCZcaFDOi+KWEYA4EoT0ebxfT/Sx9vPN3659+ar9sPW1DLVdwdXaTDb/zsh3Uye4FZbaKxwUQFPK6okRkHaZ5iH4yIsq3a5x6QwlhV/BI1NsPv8SenXnD5NEdrGshtsW49E+vgfExatBlDnZKepknycupwSD4MRVPF5jOstUEml/fRCXcnBwI6zkEAz1+GcWUX1udm652C9tWp8A69WCUf7ogoq+ixc2XKepSQhHuugP+nrtGWPNxfY9oNdpIVvQEjJX8gr8o5AAKNMSfBL6LeYUX6H0aiehQRdj06nTwBqwllBj27I1oO52MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by BLAPR15MB3923.namprd15.prod.outlook.com (2603:10b6:208:276::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20; Wed, 19 Oct
 2022 16:04:51 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::ba24:a61c:1552:445a%7]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 16:04:51 +0000
Message-ID: <5f7db320-60f9-256e-8ac4-eb9a5617c35a@meta.com>
Date:   Wed, 19 Oct 2022 12:04:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next v2 05/25] bpf: Drop
 reg_type_may_be_refcounted_or_null
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@meta.com>
References: <20221013062303.896469-1-memxor@gmail.com>
 <20221013062303.896469-6-memxor@gmail.com>
Content-Language: en-US
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221013062303.896469-6-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::21) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|BLAPR15MB3923:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2ef299-841c-45b4-559e-08dab1eba770
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PqUkk4VJ3IEr0iTYCoKrqXY6ybmpgW/SHVohlYv8ZW6zZc25ugTvFXXtv8cvVUIl3fAp/j35amAi3xFbm/emOujeMQ5NYksutsHIE7hA9w8GBBmIrc2Z/TrvKOf25Z9tVxN0YDIgoGcE9duzZWENAbatXjfASiKLw5vzYJeJ3SGVpPKrUSX3u8jjPD7KdKv/QDXVORL04EMsPJtVv+lXkMdqCAXSMLbE5PukddVXEG5dQNNWa0trxJafC2W5hp32+F2sa6/mBR8nho9r/OIILbao7bkvqyoQ91M2dhjFEWOOuaoWiSwEbUTrgrEoHHmUeAPofLfT07OZJlLyW5agvtuu7lt6kLdP0mAMiWAhBdi5MH31GYfiIw7lb0T8BirHN1U7fUA0h68QHfxuJh5DUjzDZVOc95osjQL4aqIMayPEE7mkc1rfaN1x2ttXST7pI5IX9S36VMH/XpdGcQegzBObYS62xie+dOEBTvZNFl+CTvG89QzOmohsCyepK7kwN7krmfi3TXoc6bociakdThFEjPusiVOjOMpOGu4DBMwJ9o1oRmWYeM3/5NqZMMGHBNXxL0raAOzNjDJmz7LAiyntBhG9/DAI6hpB/NK4YejQtrKwpDXlnjrrwwso+zC1+UINZZNa4kxxyDC9fnSesbTb8txY1XbRYlWbrJBowOkV0gOwRNQ0hkFRDCzYe3AK1rBJPubTpPraxHnF94kPfoxvwjFoMR3quJvUsZmqArVUWEas/0uCAF0bps6FD9uQdZVbJwAxtYo0Z49h5qeOaq4uWJQ9RORR3Digen/MjFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199015)(31686004)(4326008)(66946007)(2906002)(2616005)(38100700002)(5660300002)(4744005)(186003)(31696002)(86362001)(66476007)(53546011)(107886003)(6506007)(6486002)(6512007)(54906003)(66556008)(316002)(8676002)(8936002)(36756003)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NThzRjBYMnJqR0pqWWRiZ3k0ZXN4c3FnSjJCd1J2TGNacExBb213S2RONzRj?=
 =?utf-8?B?WEc5aVJPWlRuTEJWR0toZGtsRjhBNUx1a2k5cE1NNWxMcWdNenhidWpMWmNK?=
 =?utf-8?B?TllBcmhoRW5sRUR6dzdxTENydjQwd2hVL3lab005dHF6UnZ1emZiN0ttd1Vq?=
 =?utf-8?B?UDFDUTZqRC8yemhTZkExakhQVE1nc0g1VU9ySTJBL2IvT0o0OVkzYWpqUnJy?=
 =?utf-8?B?N08wc09aRjN4bWV3ZnFHeTVFa2FhQ1M4Rmcvb3Y5K3lWZzZydlFJQWVEa3VK?=
 =?utf-8?B?ejliMThMeVcvcDdESmJhSDRUYkNsWVZRK0hrNGE1WjUzUHljN2IwbHFNMTlI?=
 =?utf-8?B?cFJ0c1B0dkhPZlludUNTZjFxVXJYK1BDaHNpa2JsY1ByaXd0N2M1cldZY1dJ?=
 =?utf-8?B?eDFWa1E0aTlWY0wwT0dpQkg4RXEvNmxCdGR4QXBSZzU2MHZrYmNhM1B2NmE3?=
 =?utf-8?B?ZlMrZUdsNEl6c0tNUEVTcE81WW5peVBWRm93L0d1QjVvdk9IekUzNFUxTSsx?=
 =?utf-8?B?RmdvRHo3Y1FOdEFFNkRBd3NWUmlkd25OY3RKTFdnNE95ajlDM1kxRHdLeWx5?=
 =?utf-8?B?SWJ0QXVJWEdqRWRVSVhMMCtncE1OVHNONEVSaEI2UC92T3lIR2F1U0NOTDdx?=
 =?utf-8?B?RU1tQlF6SzZoTEN2UjFrdkRsS0ExWDQweElvTnpLdHRHL3NzSjBPSGFTYU50?=
 =?utf-8?B?TUpsSDZHWVRhc3Q5eG83em5mY0Znc3hxYWlQOFNsZWNxMWJjckF1NlcySmxo?=
 =?utf-8?B?UEQzNGdCdkFNVVdkeThlU3hyYXluSVpPbE55YjdUZkF6VW41b1c3L0FvNWNi?=
 =?utf-8?B?YnQvbjRhUmNBU29kdWRub2lsU2JWeVpZbC9YMG8vMUh4RmZheU5Da0FIT21h?=
 =?utf-8?B?NFBOMlBGa0xkcHZpelgrRmFGM3RZSFdOTEZ4MW9Ta1dMZUtaRTgyMEpwNUox?=
 =?utf-8?B?YnR3SmZ6V1o2V1BMY3NWblhIdVFRRk44clk5MmtlN05mN1FBcVluNGREN3hI?=
 =?utf-8?B?NHZpUHU0b1B4ajdvM3I3VGNqM2xlaW1aeEJZYTk0bmpiZWZSQmJHUmxCblk5?=
 =?utf-8?B?ZWVXMXpXQTNTdTdFL3M5ajQ2cHRwYllXU0FucTZHTFlLdFFzdk1BUnRaSGM2?=
 =?utf-8?B?N0JyNlFOMCt4Zncyb0RvNkRLR00vUDliRVU1eGs4VThjd0REa0pNSitjOGgw?=
 =?utf-8?B?S2dhMXNxMDN6RUtZK1NoeWY5SUovbjladlB5V3pBZ291eCtVQjZBcWtTVTNh?=
 =?utf-8?B?R0pkV0tyUDFaRkNmeGVFdnJlS3YvQzZRaXh6dzZPR0kyRjFoMm5YUGxsN2x0?=
 =?utf-8?B?cnhHTWFxNXpjdlRZVXloMmsxRlFpQ2dUZmJ6ZmVvL29VQXQ4QmNsSnJhSE02?=
 =?utf-8?B?Qy85ejZ3SEh3WWV0VUxGQzZLWkJwdHp5QUZETkhBNjB2UXdRcjVqbVFSN1ph?=
 =?utf-8?B?aTlhOUxab0RaTE4wcjRqQndTQ2RsNzBTZXFOU3JDVDg0UjlXL0x2eUZzNFF3?=
 =?utf-8?B?TmtxSjNadjVKcHBGZVpYZzFyaDRYdmlMNTlhVzEzNnNFMVFtSjZTcFR1dHVL?=
 =?utf-8?B?eFpzY3NuNXZSNWNXUWYxWFlJT01wbjF4VHE3NTNvMUk5L3FITU9yL1lvMWc5?=
 =?utf-8?B?UVh3NnZQUndYeHBTWlp6S3NNQnRyRExtcmppUzlFbWg2OFBiL05VL01ReWZF?=
 =?utf-8?B?ZXpoL3R1aHM0elVOMFZFaCtyWGFncUxWaFZrUEoyK05QcUN4OGRveHdsNHRq?=
 =?utf-8?B?ZWNFb3QrVUxBU0dNeEpsRWE1MTErMDIvRTBDdE9TQzFPSUQ1WG9IMFdzTnJi?=
 =?utf-8?B?VUE1ZkhYMDUrM0JjelF5WVo3SFQvbEQ2MXN2ejNuUVZjS0tLUjRvVUlhN1d0?=
 =?utf-8?B?NmZEcFZxQkFhZU5BZElvdGY2dE9DRmxwb0tJL1pIN1o2aVJsb3F6azVIeHBB?=
 =?utf-8?B?ZkJZWmIzYkdBVmJMdm5Tb0ZpeGFMWU5adjZlOXA2SzBGbkZhTXlPSkZrd1Rm?=
 =?utf-8?B?ZlRQWmROWFNyTlN0QWhhaDVsTWRjVU5xVXhES3JFUWxleWRBblY4V05lM3BO?=
 =?utf-8?B?a0VuSnA3Ky9yM1VRb1Z0SS8yZDhQaWpwWW5rdmN2WXBKQ2ZaVTJ4NmZtZC8y?=
 =?utf-8?B?WGxIWkNjZXF1TTF0MXY4UEsrZWZsY0t5aGpZRnRQWlREY1dtMWFrVVJMVmZO?=
 =?utf-8?Q?1jEbLqRndhofq2sUIQPXWto=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2ef299-841c-45b4-559e-08dab1eba770
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:04:51.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flqWzrDcILbHcNMDfnBaju6HtPUJPG2f3gzyOBHR4fZgwwTjiICuGjZQvhTU43m02Hfb9SShQVHKoXxr2mGC7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3923
X-Proofpoint-GUID: t3kCz9OOeT-69Et5y143Y3wgSm6IKp6C
X-Proofpoint-ORIG-GUID: t3kCz9OOeT-69Et5y143Y3wgSm6IKp6C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/13/22 2:22 AM, Kumar Kartikeya Dwivedi wrote:
> It is not scalable to maintain a list of types that can have non-zero
> ref_obj_id. It is never set for scalars anyway, so just remove the
> conditional on register types and print it whenever it is non-zero.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
