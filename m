Return-Path: <bpf+bounces-9905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA7B79E96E
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D159B281BB3
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878741A732;
	Wed, 13 Sep 2023 13:35:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4F33D6C
	for <bpf@vger.kernel.org>; Wed, 13 Sep 2023 13:35:34 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859BF19B9;
	Wed, 13 Sep 2023 06:35:32 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DD2Gmt032101;
	Wed, 13 Sep 2023 13:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=EhPPb5zsf1ZsSpwizBZ8C8RyLxhRPdApBjsYUg7JHwM=;
 b=v6LZTPMiL/zqkHDxUopxINd+pdK2Es0SESywBj+Fhhs8+5k7a74Lgzn6toAN5YZZMnrN
 bh+bfNdynHrKsb+iOKGKJeoRQ7pOWfQgH6z4JzV/XbRc1+9Zo1YtMIhYLR7iSH3BewST
 AmP6CKZUkndhTBoXMx7jkXHbzySeFBZrgfJsnnF+6eGyOH3d6JdqjFfHYz7Bap2RG10+
 zp/2Gv1Y+Lpkmp4Osu5s1aXR8eqRwAqVlF6bTbX3n9Iwc6FI1eInRaS/jTm1TCUZreN/
 qv8JuIJW6udrkHLFtdpkuazapSJkfEQhQc24imfbKXOxzxZ6vjE42G8Rpv7qHFLKApSC bg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7msw5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 13:34:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DD123C004463;
	Wed, 13 Sep 2023 13:34:51 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5807ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Sep 2023 13:34:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMQNyEsem4OAQL8sRR2fY/prK9Ln395qRWJ8gVHl0Jo8elbmYk2XRjUuTvOqAKbJ3caUcWo8pF2+YLtyMtJT74jwjCiTSx29XeS+HTP3dtda9TJVr62GSv2E3Wkn1u6/PVzp67PWQmef/KWQfezLsY9iczgF04tpyipN1YIJ/CLrp4f0SF7+XXDz3mfyVkzIqni0PL0YYm74vOFuEngCysrj9xx33CMtACWEMnn3ZiXru0ysCawjL11qiDwYzLcm9/eYNSVokkUq+LFEQovS0ehynkwW2X5fLs4T86aorlymzkKL2JFRm8o9NshCyyY+FMYqFfKMXcHU0RPp0+tNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhPPb5zsf1ZsSpwizBZ8C8RyLxhRPdApBjsYUg7JHwM=;
 b=UZlAHwsmmL4IIL1gEXq88RP9aicLVxPF2gwfGiRIx/sivChxTPmg9QWOgMtvK49w/jiPW0+u8HJwoulLgdaqd7zt++fxz5jDmJJxT9Y/WKhCnQCNGPFFiuQh+5Le/R8OyaZDy+Izq6x2OkjutfQ1N7Etg1MQqB6S/0iBLxC8ZnD5+EXUzN/JNTYAsLAyE8JLHOsQfyy9Ltr2bufIn+b/ankMXDpcms8e02wSNsTe/MP3wfQfQHunpYrLSYuCIQPelxmNkSs0thczlFU83YCYVnJXRWD4483YSO94lF6TlcyY1ciW1hYZ9GT9/TW0/71I5+jjp0GywXW7zz/fJ9Gs0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EhPPb5zsf1ZsSpwizBZ8C8RyLxhRPdApBjsYUg7JHwM=;
 b=iI7upR6sylvG6uskIQAjRWtiTqzYVrBC0D8Yj8XKV/e/gRujKIjTXC/X5fpLfmWwOZu5ODkrSJerADijC2yEnMt3Nutg+m1Z4W2j8E5vrYvVN4xwWNfXKGuM+N0r6WdNyzSNTErGVS7JLostfAJnv7WlqMQ/7ELrNtqmSJ/kA9c=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB4509.namprd10.prod.outlook.com (2603:10b6:a03:2d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 13:34:48 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::c5dd:aa90:b1b6:c9b6]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::c5dd:aa90:b1b6:c9b6%6]) with mapi id 15.20.6792.020; Wed, 13 Sep 2023
 13:34:48 +0000
Message-ID: <e564b0e9-3497-a133-3094-afefc0cd1f7e@oracle.com>
Date: Wed, 13 Sep 2023 14:34:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH v2] bpf: Using binary search to improve the
 performance of btf_find_by_name_kind
Content-Language: en-GB
To: pengdonglin <pengdonglin@sangfor.com.cn>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230909091646.420163-1-pengdonglin@sangfor.com.cn>
 <20ef8441084c9d5fd54f84987afa77eed7fe148e.camel@gmail.com>
 <e78dc807b54f80fd3db836df08f71c7d2fb33387.camel@gmail.com>
 <CAADnVQL0O_WFYcYQRig7osO0piPdOH2yHkdH0CxCfNV7NkA0Lw@mail.gmail.com>
 <035ab912d7d6bd11c54c038464795da01dbed2de.camel@gmail.com>
 <CAADnVQLMHUNE95eBXdy6=+gHoFHRsihmQ75GZvGy-hSuHoaT5A@mail.gmail.com>
 <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <5f8d82c3-838e-4d75-bb25-7d98a6d0a37c@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e0d7240-8f16-49dc-f713-08dbb45e3319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QIfAn1f1wnJ3J5h+BucpLDiUUqZ438Okze3IpRFbUtIo211g3AwuAMi56erTGDUccyFUbyZG1TSutWm9pF0QVHjxbaaG+Eh/KhSK8CNxtzesE4Xn6tHJ+rdYB91f1hkQ2dB5xnzaKXM7qCVgzuGBa+XWWZnSm0S7cdmyZq/jxe01C8US9NLExDEfcVCR1VEd/Pj6kM/KZTb1OUJLMpr6GPJEE/s3H8xYZkQiPjlNKcY2YC8a4dH1F0RNy/k98IaEg6+WFyg/6PREi1MiWDUO//we2AUGY9WP87hHfDieZuwegCPDD5CGBdP3SvrivHvuhohXaA2d0tW4X1hlQRUDVrOw9K0I2jTYIhwdlTCS2Zw5nrhimn2ahbW8Hl9RLKe2eHNMX83yQtVA9wKatr15KRvoyizgGVomjDVCPJVBIbT/AT1xwT5dj6yINDnL41JWiZJ+9qRBOE9GDDvcKKQ2H4FJN3g0/mW/8dRH9y75y2CCFQQvjDXVKxEwMunTWRzA/1g32ZEDkDh7uCE6ja9ZS1xj494eyc5GdDpN520XXYfoHSBw8pnBLmOn1VFHQV4T+E+tmuSM07rwd1EyGPSql5fnUwCtRLcZfQ37cye+OmN4yesuecvbhIizh7VKIl2+UZf5xiQzHbs8Af08by25KA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(451199024)(1800799009)(186009)(31696002)(8676002)(86362001)(8936002)(4326008)(7416002)(5660300002)(44832011)(2906002)(36756003)(6666004)(38100700002)(83380400001)(53546011)(6512007)(6486002)(6506007)(54906003)(2616005)(478600001)(316002)(110136005)(66556008)(66946007)(66476007)(31686004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NVBMdjBpWmJGbGMyMmxuVjM2Q0tpc29FLzVCRnA2cEhvTGFibmMxcllaUHFl?=
 =?utf-8?B?cW9nWXpFRExldk83Wkp5clZxSHpNSjRvTU9ZaHNqa0dvaFIwZUd6bk5Qd3E5?=
 =?utf-8?B?dFRrbmxXWUIrZDlaMTlFNkU1SWovRVB5NFdHeXpvOEZGeGRLOXhEZHFMMHIw?=
 =?utf-8?B?K1FuamtuUkZRU1lsMWVjMmhBSnA5TDJCTzhjNk1BRkhSV0dnMVdtOWR6d2pX?=
 =?utf-8?B?WU5RTEp6Uys5c01BWE5KS0ZwYmFrb0Z3OXlGSzByS3dyRFovK1VvVDhzWnhq?=
 =?utf-8?B?NTJJNmhRcW1rVVFFYWhLSU5PZU12MG8xR2pXUFppcVhOejQ5RGpmSzBrWVFl?=
 =?utf-8?B?SS8yUXQ2ODM2VitXOFhqejVvZ1JRUjM5MHJ2cEhIdktkRVFLSEEzaWxWMmgy?=
 =?utf-8?B?cktTZjZ3SU9WbGNuSWduUS96T0V2UFlYbmxwaVcySVNlU2ZsT29NSnpiL3VI?=
 =?utf-8?B?M29Wbm5BTHEzNlBxeUF4V3Znbi90OE9BTmtyQXBLbFFYWi81QndlV3FkcS9C?=
 =?utf-8?B?b1dObWtwZ3kwWWNtc2diZFlNRGE1S1UwcVN3ZE9rLzhVa2RDRWVLd1IwSUhF?=
 =?utf-8?B?VndLVmlXeVhNNUpYR2t6ZHVoaDB2REgrOHYxRGdPYmlUV3k1VVk4VnJTYkox?=
 =?utf-8?B?bjQ3Q3E1NW01UUxCdFdZaWJ0aFhOck9rQXNwZm5MdHExd1Jzbm0yb0EvVXhW?=
 =?utf-8?B?QTg1b1hRUjVlVVVOTk85SG8vR3FvODY5S3ArTHVmaWdxYjA1U0pEa0hPSHI1?=
 =?utf-8?B?ZXA4aXhYSVBCZWp3ZkVPcDhWckxQeGFienZMTjB5RmRJZlFYc0hMd1d4QTds?=
 =?utf-8?B?eW5LTm9hV3hXTk43cVg4VVpHaUlCT1dwYjNWZkE0clBjSStoMUE4WHpHU1Rm?=
 =?utf-8?B?T2NBMmc0c0VpNWVmcXVxenZnM0taODgzNjEvMThtMWEvT2REaVZEbXQ0ekdI?=
 =?utf-8?B?UEU3eGlmYlJBWEdrQXlOY2c0ejVwZFNRd1JZTkJVajhPOU1jMDRDOE5Ld0c2?=
 =?utf-8?B?T0FEdXpsZEZNTkV0TzlNajlVRUd4NGhjaXdCQ3BCM3Y3T3dQT01qanlKTGph?=
 =?utf-8?B?S2FhZmlDQWZYTnBaM2YvT0xJUVhXUDZYamtXUUp4WldxOU9GNmVEaUt4MzVS?=
 =?utf-8?B?OFlDNFcrc3U3SXdUUzA2QWpBa0NmcWJYT1cyNllwUTc5ancxR08wRkUxaDhV?=
 =?utf-8?B?R0EyLzdOQ25tQUdFd1AvV3JnTXRPOFVrTG5ONjdRdW1mVHRYcEFCT2Y4UlBj?=
 =?utf-8?B?c295UGtpZCtNNm5JZlM4YWw1TUk0SVlqSGgvZENrR2lSOHdaR0I1dkExZXFx?=
 =?utf-8?B?SUhOeG1qN0phS0d2SEJRWWMxYk0zUkVqNTdZc0tnYjVLU1lrUFdvdDJLcFNR?=
 =?utf-8?B?UGxlQlFtZTNRTEJXYmM3ZEVzcjNUTzVmd0VQa1lqMXFzK3Izd0ZKanBvUTVY?=
 =?utf-8?B?cDNDWUVnd2dybU1aV2lNbTBncXQzbFFJV2RqQ0p3R2NXeXV0aHRZK1lCeTlv?=
 =?utf-8?B?dkxsVnhrMlRsTlpsb3ZPOGZVNFFnN05nYVNXM2ZzUVdlaVl4b2tSZDg1eFVB?=
 =?utf-8?B?YzBHeVc0eG9ETFVMU3FhckFrQzZnZm12OG9RZGR6aXpsL2hTeXFudXI1eDJL?=
 =?utf-8?B?UzExeGl0V1IrRFV1c3pwcTBYeko1cXZnclcwOEw0Q3oxNFU5c21oVFoyY0ds?=
 =?utf-8?B?QnNQOU9CQlUwWk5mdGZJQ2ZuaHJQQ09mV3FVU2c4UG1TdEVzc1BRSjk3WEJL?=
 =?utf-8?B?NDVaZ3RxREVaV0lncE9PdVVkMFdpVVlwVUpRYWsydGVRekZWbU1LbTB1ZGQx?=
 =?utf-8?B?MElWSmhGT0crOE9Hd29HdHdiTnpsV0h6b3lJZ21MWW1LT2VHL25XY1hSNHU4?=
 =?utf-8?B?b3RqRmoyNkgwVVpFaDQ1MTBMMEdRUGlqdDVpREhsWG9YOWlqczFIeWdZMXNZ?=
 =?utf-8?B?YWUwNEZtZzI2c2VpWjZzNzZEWnNmbllvVEt2M1hlZEIvOFZvem40V29wTXVZ?=
 =?utf-8?B?SFJGSldzV0dYQnc2bzViY2dXNGtsUVh0cmFuVnNwZDBjSjNxYXV0MmxwZVFp?=
 =?utf-8?B?clJhNnZ0SVJ1U3FzRURvTmtvUkd0Vk96SEpncXNHdjZPNmVJNWNaRngzaVJK?=
 =?utf-8?B?aTloeFRCZXA1WEw1Z3RKRDlVR2FScUF6c3lWWVgrVXZmSS9MTllpNGdtY2dC?=
 =?utf-8?Q?OUJhofkr4U7nnj1d1yBjVvM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?cFVwd0loYWRSVnNFNXNLTHVobEhqeHhNRUE4NjVtRzFjWjQxaW9WK1pUeVFT?=
 =?utf-8?B?WWtqak8zWE14RFM0RDVoeUxRZk1scmI3RmRsK1Y4eU9rNTROOFdUekNPV1Nn?=
 =?utf-8?B?SFNJV1c2OU1aWHhzVWJ0WXdvbXF4QmR1OUlIZlJSRHNLV3AxZ09iem5SRlpC?=
 =?utf-8?B?dUpKTUo4K1RuS1huT3RkSnI0VWVOVzJXMVU1QWY1a0E1dlBHTmErbUVlTjhX?=
 =?utf-8?B?SkdTYlVqR1dZMmdhcWVBZ0Uya1BWMHRqa0QrN0hGNVBjVXdERk5MOWNYQWc4?=
 =?utf-8?B?anRuZ1VNWUc2Nlp6N3FURThla2JmbmN5dVd3d29ha2l0aVZOOHd6QTBCQnNQ?=
 =?utf-8?B?N0hoaTc4R2FvT01lblRPN0laNmFCd0x5U2F6T0lBOWU1UTB4azMvcDRRYVN6?=
 =?utf-8?B?emdHNStUZzdFbE5ZWTQ5UGVDaFpqTG1SMFhnQ1NOOFFjVHRyTEZSYUR1TXdP?=
 =?utf-8?B?Tk9oNHRrVTZLQWl6MjhvQ0k5dnNrOGRKSVpJVGIrVGZ1VDhHaEhuR0haWXRx?=
 =?utf-8?B?TXVSNHVwTVpzRlhPYkx4MGVCeHMrTjk5T0EvVlY2NWk2ckVOejdQc3F3QzI5?=
 =?utf-8?B?UHhIVEd3NGl6blNvcUJ5WnNMYWYxNkdQWTFvbEk0TEJCQWtjUW5MWTNEMWdp?=
 =?utf-8?B?T0FSaFBhd25obHd1VzM3QmxDTE0yemU4MytuVVU4SmhUMStua0l6cHlVT0Zl?=
 =?utf-8?B?aEJMdHM5TG42eDRmY0pVbm1OTFFyTGl5amY4Ti9nOENKU3RXVXpsYkwvcEp0?=
 =?utf-8?B?ZTJWWGgzUmFma3A5dnp6dWsybW9jcDh3UWw4MHhNamkwQkkxYmxob0FJRFEx?=
 =?utf-8?B?dVNMTFlibGZmdlZnN2NpWnZLazFMSVQ4c0g1eVNTbXpFYmFaOFRiRng2TDhk?=
 =?utf-8?B?bHNLRHQzRG1kMzlUQjl4WEg0RjN6d0I0ektRVlc3SHZ3aVJpdE1DZFRNQ3Ir?=
 =?utf-8?B?UVZ3dW4rV1N1NGpDN2dDbFVJQS9lMjR4YmppMkVSQ0MxUkU4enQ4cVRDVm1r?=
 =?utf-8?B?NHQxQmxycVNaZ2loVU0vMHFuZUh5OVlhNWo1SVlUeEpmN2ZsRkFKeEdaNXlI?=
 =?utf-8?B?MnY5a1I0RG1ESmJPSzgvV1oyYTZWRzU0bUdxVVVOdnZHeDRNOUdGSTBCUkVO?=
 =?utf-8?B?ay9OazkxZGE5YVF3bG1Ld3VQaWl5QkdCWmNFd2dacm1ULzZ5UUgrU1ExakRT?=
 =?utf-8?B?S3J4UFVnYjNTY0o4L1J3ZCtSUUJwaUpDdGRVb0NJd1F1NTlyb2t6RjkzMDFH?=
 =?utf-8?Q?MhVHf343LGKUawz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0d7240-8f16-49dc-f713-08dbb45e3319
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 13:34:48.1561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yr1ozWEd0ljJORnZWXUCH9eKK/9HryT9op6bEBXE0sBo68F+cgGsgNTFhlTTJHHLN/H/0mA+Lne1SScDTLXWoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4509
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_07,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130110
X-Proofpoint-ORIG-GUID: m22kN6AuqTGRGsl7zFY2xs24TxkXcucm
X-Proofpoint-GUID: m22kN6AuqTGRGsl7zFY2xs24TxkXcucm

On 13/09/2023 11:32, pengdonglin wrote:
> On 2023/9/13 2:46, Alexei Starovoitov wrote:
>> On Tue, Sep 12, 2023 at 10:03 AM Eduard Zingerman <eddyz87@gmail.com>
>> wrote:
>>>
>>> On Tue, 2023-09-12 at 09:40 -0700, Alexei Starovoitov wrote:
>>>> On Tue, Sep 12, 2023 at 7:19 AM Eduard Zingerman <eddyz87@gmail.com>
>>>> wrote:
>>>>>
>>>>> On Tue, 2023-09-12 at 16:51 +0300, Eduard Zingerman wrote:
>>>>>> On Sat, 2023-09-09 at 02:16 -0700, Donglin Peng wrote:
>>>>>>> Currently, we are only using the linear search method to find the
>>>>>>> type id
>>>>>>> by the name, which has a time complexity of O(n). This change
>>>>>>> involves
>>>>>>> sorting the names of btf types in ascending order and using
>>>>>>> binary search,
>>>>>>> which has a time complexity of O(log(n)). This idea was inspired
>>>>>>> by the
>>>>>>> following patch:
>>>>>>>
>>>>>>> 60443c88f3a8 ("kallsyms: Improve the performance of
>>>>>>> kallsyms_lookup_name()").
>>>>>>>
>>>>>>> At present, this improvement is only for searching in vmlinux's and
>>>>>>> module's BTFs, and the kind should only be BTF_KIND_FUNC or
>>>>>>> BTF_KIND_STRUCT.
>>>>>>>
>>>>>>> Another change is the search direction, where we search the BTF
>>>>>>> first and
>>>>>>> then its base, the type id of the first matched btf_type will be
>>>>>>> returned.
>>>>>>>
>>>>>>> Here is a time-consuming result that finding all the type ids of
>>>>>>> 67,819 kernel
>>>>>>> functions in vmlinux's BTF by their names:
>>>>>>>
>>>>>>> Before: 17000 ms
>>>>>>> After:     10 ms
>>>>>>>
>>>>>>> The average lookup performance has improved about 1700x at the
>>>>>>> above scenario.
>>>>>>>
>>>>>>> However, this change will consume more memory, for example,
>>>>>>> 67,819 kernel
>>>>>>> functions will allocate about 530KB memory.
>>>>>>
>>>>>> Hi Donglin,
>>>>>>
>>>>>> I think this is a good improvement. However, I wonder, why did you
>>>>>> choose to have a separate name map for each BTF kind?
>>>>>>
>>>>>> I did some analysis for my local testing kernel config and got
>>>>>> such numbers:
>>>>>> - total number of BTF objects: 97350
>>>>>> - number of FUNC and STRUCT objects: 51597
>>>>>> - number of FUNC, STRUCT, UNION, ENUM, ENUM64, TYPEDEF, DATASEC
>>>>>> objects: 56817
>>>>>>    (these are all kinds for which lookup by name might make sense)
>>>>>> - number of named objects: 54246
>>>>>> - number of name collisions:
>>>>>>    - unique names: 53985 counts
>>>>>>    - 2 objects with the same name: 129 counts
>>>>>>    - 3 objects with the same name: 3 counts
>>>>>>
>>>>>> So, it appears that having a single map for all named objects makes
>>>>>> sense and would also simplify the implementation, what do you think?
>>>>>
>>>>> Some more numbers for my config:
>>>>> - 13241 types (struct, union, typedef, enum), log2 13241 = 13.7
>>>>> - 43575 funcs, log2 43575 = 15.4
>>>>> Thus, having separate map for types vs functions might save ~1.7
>>>>> search iterations. Is this a significant slowdown in practice?
>>>>
>>>> What do you propose to do in case of duplicates ?
>>>> func and struct can have the same name, but they will have two
>>>> different
>>>> btf_ids. How do we store them ?
>>>> Also we might add global vars to BTF. Such request came up several
>>>> times.
>>>> So we need to make sure our search approach scales to
>>>> func, struct, vars. I don't recall whether we search any other kinds.
>>>> Separate arrays for different kinds seems ok.
>>>> It's a bit of code complexity, but it's not an increase in memory.
>>>
>>> Binary search gives, say, lowest index of a thing with name A, then
>>> increment index while name remains A looking for correct kind.
>>> Given the name conflicts info from above, 99% of times there would be
>>> no need to iterate and in very few cases there would a couple of
>>> iterations.
>>>
>>> Same logic would be necessary with current approach if different BTF
>>> kinds would be allowed in BTF_ID_NAME_* cohorts. I figured that these
>>> cohorts are mainly a way to split the tree for faster lookups, but
>>> maybe that is not the main intent.
>>>
>>>> With 13k structs and 43k funcs it's 56k * (4 + 4) that's 0.5 Mbyte
>>>> extra memory. That's quite a bit. Anything we can do to compress it?
>>>
>>> That's an interesting question, from the top of my head:
>>> pre-sort in pahole (re-assign IDs so that increasing ID also would
>>> mean "increasing" name), shouldn't be that difficult.
>>
>> That sounds great. kallsyms are pre-sorted at build time.
>> We should do the same with BTF.
>> I think GCC can emit BTF directly now and LLVM emits it for bpf progs
>> too,
>> but since vmlinux and kernel module BTFs will keep being processed
>> through pahole we don't have to make gcc/llvm sort things right away.
>> pahole will be enough. The kernel might do 'is it sorted' check
>> during BTF validation and then use binary search or fall back to linear
>> when not-sorted == old pahole.
>>
> 
> Yeah, I agree and will attempt to modify the pahole and perform a test.
> Do we need
> to introduce a new macro to control the behavior when the BTF is not
> sorted? If
> it is not sorted, we can use the method mentioned in this patch or use
> linear
> search.
> 
> 

One challenge with pahole is that it often runs in parallel mode, so I
suspect any sorting would have to be done after merging across threads.
Perhaps BTF deduplication time might be a useful time to re-sort by
name? BTF dedup happens after BTF has been merged, and a new "sorted"
btf_dedup_opts option could be added and controlled by a pahole
option. However dedup is pretty complicated already..

One thing we should weigh up though is if there are benefits to the
way BTF is currently laid out. It tends to start with base types,
and often-encountered types end up being located towards the start
of the BTF data. For example


[1] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
[2] CONST '(anon)' type_id=1
[3] VOLATILE '(anon)' type_id=1
[4] ARRAY '(anon)' type_id=1 index_type_id=21 nr_elems=2
[5] PTR '(anon)' type_id=8
[6] CONST '(anon)' type_id=5
[7] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[8] CONST '(anon)' type_id=7
[9] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
[10] CONST '(anon)' type_id=9
[11] TYPEDEF '__s8' type_id=12
[12] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
[13] TYPEDEF '__u8' type_id=14

So often-used types will be found quickly, even under linear search
conditions.

When we look at how many lookups by id (which are O(1), since they are
done via the btf->types[] array) versus by name, we see:

$ grep btf_type_by_id kernel/bpf/*.c|wc -l
120
$ grep btf_find_by_nam kernel/bpf/*.c|wc -l
15

I don't see a huge number of name-based lookups, and I think most are
outside of the hotter codepaths, unless I'm missing some. All of which
is to say it would be a good idea to have a clear sense of what will get
faster with sorted-by-name BTF. Thanks!

Alan

