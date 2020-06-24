Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1632079DB
	for <lists+bpf@lfdr.de>; Wed, 24 Jun 2020 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405168AbgFXRFz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jun 2020 13:05:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28460 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404208AbgFXRFy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 24 Jun 2020 13:05:54 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OH5URK007450;
        Wed, 24 Jun 2020 10:05:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CvTHSHyj0Snfd/7GGCa1zCsBlOL8k+IwdNPMk5GVuWk=;
 b=Zb4f+n/FtWP7tDrkITCWCpyJkjbXvXNoG6P/swsAmXf/V/heQRFN+3eZp4tCA7yifU9a
 mmAu4Zsu3UGTFYAETCWsZvdAoua/pd5oVnwZs/AqXW/3nJRtmH/J+WRF+ylqj93USx86
 zv+FjsSADM8Dy+ary8G7KlouF9Y/F9XCBpE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31ux0xk8xp-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Jun 2020 10:05:51 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 24 Jun 2020 10:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXZOpR9t17/lm6mxvyEmNC5Ts/ZWWGf+Z+wNtig83J/NVCeK1zc3aDdjfpmSMa6zmxlhpMN3FumI09i/dk9XQDYVPFtVPCHyW+cQ72GpLkfDO6Aq1chs0pZ1lrO2qYZ6rwYsaAL3UGxvFkV+JPcnrihf/Xsq/6tGqu+Mre8cH7HX4J12OCWtvHvk43tVcn4he3rO1xdqEj87VVxyE2Ekxf6aJ/NJduVIJgVBmhslCcswC0xBfPTfAAy48IFR/qy8u2z2/8YpJ6Z+SHBvJ30AiUgU+d/K0y/xqMi/+MRURGjgX/9QxXXrNj+QYVtzRd0RAeImVJtHplhT0XiYMQpqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvTHSHyj0Snfd/7GGCa1zCsBlOL8k+IwdNPMk5GVuWk=;
 b=eQNGuXzDU45YE062VGsaa3m+smoK2pBavGBlrleXb9d/jmiQtHmvP8JoUJG51XUCEc4pTGZ/PfoVfx6T9uInfYjYHZZDqD7xeaZAuUdpJdiP6neULTgTLo5cKrVgkh6hJXNGTr1IxbOwdcvPaM5XNqtwY+oAvQa1jSAieq8pL8V3NCrnA6WORNPTDfyo6VWl3XD4ToovlAzUC7dElfYEX5RWeEIIFdZuc371XqnOJfDNEzkB/nSoyCUebutFf25wO2jF2l42+nfEjwiOhX92Df+NAThv3BJa9xZdPhdT2enJCGZfISHUpEdTBh2Xfz9scDwK2Hbnw7xkuh/Y3sMKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvTHSHyj0Snfd/7GGCa1zCsBlOL8k+IwdNPMk5GVuWk=;
 b=DpbB9rqN4x+jf7eiqJT186SmWuBCfDn5wGsHtZnucesd/TjQHyRVL6xBylIlGRjrvHGm6pYGzl0ofih0coIatpUNtTYBeNiahue67XhphqjnONUQ68hN92uy2ctkgQanJunR4wXvCObgK3Jz1P7KBLaO7Qfohph1HZlhtf0UYTE=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 17:05:42 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 17:05:42 +0000
Subject: Re: pahole generates invalid BTF for code compiled with recent clang
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Lorenz Bauer <lmb@cloudflare.com>
CC:     bpf <bpf@vger.kernel.org>, <dwarves@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
References: <CACAyw9-cinpz=U+8tjV-GMWuth71jrOYLQ05Q7_c34TCeMJxMg@mail.gmail.com>
 <20200624160659.GA20203@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <dc0a8fc6-d0be-45ee-be19-9feb1f0d21e8@fb.com>
Date:   Wed, 24 Jun 2020 10:05:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200624160659.GA20203@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1926] (2620:10d:c090:400::5:e935) by BYAPR04CA0012.namprd04.prod.outlook.com (2603:10b6:a03:40::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Wed, 24 Jun 2020 17:05:42 +0000
X-Originating-IP: [2620:10d:c090:400::5:e935]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6cb835bd-2196-493b-39e0-08d81860d400
X-MS-TrafficTypeDiagnostic: BYAPR15MB2999:
X-Microsoft-Antispam-PRVS: <BYAPR15MB299977A2F9307FEB3E0B7750D3950@BYAPR15MB2999.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N1+RuK1Hg1hplSLfrFV88pdlny+YCLidoe2J+qe+Oki5bHiHp3jj9sTego85BWupQ6P1goVVlMPya1NnvurFlzevgLNwW/hjz94o2uW2ADn2GN6rC1zjhyaLG0iAIqTD4CyuLj/TlTVg7J9nv3LCDp6ixBVH8/HcKwvZ0sYqozsNnZGRIdnZs7p0HDP2l+tOLJT3JHnWZlkYf//+CBTZtxvU9dWnkFYebXuARVO1F7t1FePITTQTQkO9Qfacu8OaYxyTeXg0su7ggcxgyHRzuxwppUh1l3h9coASiN4wKgTWnMGWRWSnqvz+WdzAxk1ctMNNdCNFnT7VEuX9iMRjbaG1efmJWY9VY2J+5IzQPqb8NmyNOyimM9vw9UrIgjPcsbKT/QTankzDjEcAo6iEt2HqzXvgcLe1AzU1chjE862ZJa/0zb5+CaRlK6ZJPDJr96ST0QBEp7Snni0Zu2qlr6SVmZyNAds84ul2ylncN3C0j5RgZn0sjK7x2vZC/Eu00INeCzZLNiTJY+W8IVECsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(366004)(396003)(39860400002)(16526019)(52116002)(66946007)(186003)(8676002)(966005)(4326008)(8936002)(53546011)(2616005)(31696002)(86362001)(54906003)(5660300002)(2906002)(31686004)(66556008)(6486002)(36756003)(478600001)(66476007)(316002)(110136005)(43740500002)(473944003)(414714003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: gF8fjHeFmqaHKiBBm0YGRAErRiqppgKW7jzbkkwx50B+QwiYfhpV1M5tmBTrXhKvI2ZTSVXySfjk2xFcJZq99qDxDSnSBDDg/S6F6TxNpscEiQxSjdHOetbraC6T5b253glTATFHRBXkzwPjb5tM3mHNy/DWTN+V/wKpenQuKK9BuLK+J0wzerD0+JoVXjLOVJ4cxJbAqFWeOkpw7wkxR+V33yCp0SefGPQ/MHgjfj3tUa9Iqnjs1dp7rLq1G8ALX3o3qdb/6n9lneFzCg6hPb/m6KxCuu09ZdEHP0lwH01Xm2dOc9jZxHS9sVSpzui0gp8gjjCO9dc/G5EBCpYgcpXmtG7jXTjbFb2H9NqWI/QFG+r9oNVPm3Z33k9ycpVb9bobi1xc/l7RlMUdQaUobOMV1b1fBfnty1S69HAcpRxHyJAowh4tt0LAvmvngbnwRHbqF5wGRhhod+M+aurvkJCxmWp8joAW7EFwfqG5GmVbBeWUYRXUGCQl1Ck39I9FAmOc7ccEfFeDt2oM/fQ2gA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb835bd-2196-493b-39e0-08d81860d400
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 17:05:42.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6uFiD4aaJKVZF8KScjIVS15jEkkJ3s8PfdWUlxRk0KwxrUALPo2E2VwIb9DABdhq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2999
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_11:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 mlxscore=0 impostorscore=0 cotscore=-2147483648 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1011 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240118
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/24/20 9:06 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Jun 24, 2020 at 12:05:50PM +0100, Lorenz Bauer escreveu:
>> Hi,
>>
>> If pahole -J is used on an ELF that has BTF info from clang, it
>> produces an invalid
>> output. This is because pahole rewrites the .BTF section (which
>> includes a new string
>> table) but it doesn't touch .BTF.ext at all.
>   
>> To demonstrate, on a recent check out of bpf-next:
>>      $ cp connect4_prog.o connect4_pahole.o
>>      $ pahole -J connect4_pahole.o
>>      $ llvm-objcopy-10 --dump-section .BTF=pahole-btf.bin
>> --dump-section .BTF.ext=pahole-btf-ext.bin connect4_pahole.o
>>      $ llvm-objcopy-10 --dump-section .BTF=btf.bin --dump-section
>> .BTF.ext=btf-ext.bin connect4_prog.o
>>      $ sha1sum *.bin
>>      1b5c7407dd9fd13f969931d32f6b864849e66a68  btf.bin
>>      4c43efcc86d3cd908ddc77c15fc4a35af38d842b  btf-ext.bin
>>      2a60767a3a037de66a8d963110601769fa0f198e  pahole-btf.bin
>>      4c43efcc86d3cd908ddc77c15fc4a35af38d842b  pahole-btf-ext.bin
>>
>> This problem crops up when compiling old kernels like 4.19 which have
>> an extra pahole
>> build step with clang-10.
> 
>   
>> I think a possible fix is to strip .BTF.ext if .BTF is rewritten.
> 
> Agreed.
> 
> Longer term pahole needs to generate the .BTF.ext from DWARF, but then,
> if clang is generating it already, why use pahole -J?
> 
> Does clang do deduplication for multi-object binaries?

No. It does not. clang did not do static linking for bpf objects 
currently but we may do it in the future...

> 
> Also its nice to see that the BTF generated ends up with the same
> sha1sum, cool :-)
>   
>> Best
>> Lorenz
>>
>> -- 
>> Lorenz Bauer  |  Systems Engineer
>> 6th Floor, County Hall/The Riverside Building, SE1 7PB, UK
>>
>> https://urldefense.proofpoint.com/v2/url?u=http-3A__www.cloudflare.com&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=DA8e1B5r073vIqRrFz7MRA&m=VBET_4Cak79EDDrdr9dfzHXXwBqdhb1fmqug2a7lpPc&s=9Wa1gFDt7uR6HK2w9FgzzLXJ2pMq8Ep0i9IXaaqUnb0&e=
> 
