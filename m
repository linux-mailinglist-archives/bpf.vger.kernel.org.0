Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9069C68FA7E
	for <lists+bpf@lfdr.de>; Wed,  8 Feb 2023 23:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjBHW63 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 17:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjBHW62 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 17:58:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2FF15CB5
        for <bpf@vger.kernel.org>; Wed,  8 Feb 2023 14:58:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KwuC1006621;
        Wed, 8 Feb 2023 22:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MNd1B2h1e+tKWti2spxJ79U1tndPQ98qLi3yrxCqkCM=;
 b=YebLkraG9cDxBQRvzIzkcqBPukTLmgaUMyOPIaI/zShTUxXXNp3mEDUwwuyEeY9o31Qx
 mJKm+Szn4ldIkQYJIFVnORf58AvBoOzX3CtrU2YpiGcpP9zzgX0lum1qReg2+1Si31J9
 AwH+eqTLrD1lsAEcLGXM/z4PqAKo03GjCgMiEoAhv9gJp7pacKazgM2VOU4JA/Kh6YL5
 bud0yyoxrdCm9B5Yksafmp1TBPOuhTiwE5TrsqA6vrCWl4eE7HBk2zKP68avc3ZUo7OE
 /NZPZBh1M+Wv1O+6qWHyKb2HW8Tkt+2YqSsnIbG3i8j7v+cOVGDmVQlrRdnoR2YMc546 XA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53hh91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 22:58:05 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318LXVgW031000;
        Wed, 8 Feb 2023 22:58:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbce9r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Feb 2023 22:58:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAbpipnB0WXl9h8iqK+D1NOwXIoe0h/HUqXAjI4cau5cXRBLt58aRR4MuTNkZjfzNWvSQ+6sQvgVffroJvzgNheVKW6xA+MmTB66MAJyKct7lZa5AXMfDJjPrEX9xw1XhkSk8/a9ITAB+sQ4h23jV1bdKu3cZVVdQLDBE512kwxnFQcfpcdJVdQBQzdhP7IS/Mj9gLFN7XKFyQ3SElRnkEWADBJWlTScE7FxqL8oAiDksZDLPLMPmFjK7ULLt9eDXf8McJKvSVG/na97pAl75w9q+RI0AK5P7WFatuCuDyylqeNzt6vYPEV6HA9O9zTRjcxA6vEBIyPBsbjXjGHF9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNd1B2h1e+tKWti2spxJ79U1tndPQ98qLi3yrxCqkCM=;
 b=DlYGTxqu3bf1KBnF25pZlT3M9AYDkVkhHruIy/UgYMD4fHB9wu4mnWqzeen5dGtD9N3dOsxLNSbqN6cOI1LuZTygn9bRsAtswdfOSjXFEP8gx9SXsn5EGxVc/BznGb6dPttKJuNL26yu5/mZAiIna14Obp+RDo/i+dPsecydl+1Q1XOPjK/Dq/8GNeSWEDj8Walcm7oz03oTgz85/Bstm2ZOELq60T0WYyhrDZA6ndQh7hkVMQSH7s41N30DqYyFr8aSXHEya/fIBkxOD9Ibl+OBaGzRHFhAm3Y6NYkLLTCBda+NLPLJtKH6n23j9VAGxsE/IYtwgWUWcW0P/XBPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNd1B2h1e+tKWti2spxJ79U1tndPQ98qLi3yrxCqkCM=;
 b=jjVQCxanZfCXaTI8O89AXfrFp8l6HTM29yc5K0N2u8xHnevK63zD6Ur0nMxDCPQlIgD0AuVjnoIkGuL1zkLEoXGaLDmIpnZWDLVvG3/cd+SZdJzqr+k0fdxnx+VA92Wv+F2cdcPWjw3IGUyQDtx/8WUb0XA029kCSEAiPCW1I88=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4777.namprd10.prod.outlook.com (2603:10b6:806:116::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.11; Wed, 8 Feb
 2023 22:57:58 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6086.017; Wed, 8 Feb 2023
 22:57:58 +0000
Subject: Re: [PATCH v3 dwarves 5/8] btf_encoder: Represent "."-suffixed
 functions (".isra.0") in BTF
To:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sinquersw@gmail.com, martin.lau@kernel.org,
        songliubraving@fb.com, sdf@google.com, timo@incline.eu, yhs@fb.com,
        bpf@vger.kernel.org
References: <1675790102-23037-1-git-send-email-alan.maguire@oracle.com>
 <1675790102-23037-6-git-send-email-alan.maguire@oracle.com>
 <Y+OhWAjPI5ngE/Jc@krava> <Y+O1Bvur0VnHJX6C@kernel.org>
 <Y+QLY1cZGAxq6sbW@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <14ab31da-0c9a-cf0d-63d9-7b77d73d2837@oracle.com>
Date:   Wed, 8 Feb 2023 22:57:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y+QLY1cZGAxq6sbW@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::16) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4777:EE_
X-MS-Office365-Filtering-Correlation-Id: 223e81cb-9a56-4dcb-33e2-08db0a27ec34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/qWSRDTSiQXM0JsumPF0kTAGUjzBeWmafvrXVyQnQ0tqsPtnxHn0hnvfEbJ1X3qOFRkuHxQZ0JH1qJ/SAp+nnCYhQWampEtiwKisTx9uqCr6LdHe3ksfgqo+nw1zWXblg9r3b2JpxUK/x8aI/DpSypEtwwZUAYJiRuLSg0MotakTQM6jVHlzMmtvvbSlxUo5RBIO9/8Lwd+NPPLQLbz1ZaubpRxlwzPFSjlizgYIHYE8WltSu1ac//Q6CneGZyIMLnLbLiS2kaU2PCPRLjKXfrX+t0xMdDOBvPG9PSGii08uIqS65Tyi28D/eRDjJvY2Ww0jX1Oaxfe3HA/QL2xx+Go5XebT2k7t3qjwnHcD+Rnyaa7I2NXWqjqqAVjJXmYaLHhLdGv2SoBk8kvccK0jA3sCNv1ylKWOVrUakeq7U5ij4VmoCCg+uhTBD1FXio4YMjAGz7RLi3JR9XwGaXyza/VMC8xBjSvgx6bxOVukpkXLYClOR3u7AibZZUbhxGIioCcGrLiVbpKkqy457mDWNbHdQoegYxrbkvbJFv4bhk2VRhrE1eZxbo9j8/83ggKPCCHDteljiIFXJ9Ewns4egkraaAGEM5ahXTdueLE/XMIiU1tR8h198jISp4235+fdxoEvEewOYyZKEwkLyVgbMEqCnsABj4kjh/TZxc/ignRIGWYaRqNj2/bhKp6VhMepS/Ghw5fJNgKj+azvfenujpaV8DnbnaJwt8sR9IlhPiLW1VvR/HD3ySJ04EAkvAGh9V1NdDvQ/WxJkpoErKgpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199018)(31686004)(36756003)(7416002)(5660300002)(44832011)(66946007)(66476007)(4326008)(66556008)(31696002)(86362001)(8676002)(8936002)(41300700001)(316002)(2906002)(83380400001)(38100700002)(110136005)(6666004)(2616005)(6506007)(53546011)(186003)(966005)(478600001)(6486002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NFeWhFd2hoU0V4cmxYNDRjVjA3Q2VlZWFrc2FaemNSY0hOWGhGbndzN0tq?=
 =?utf-8?B?QzVYSlVaWWNXTjJwTnpzTkhBNEtLZzhobkZJbUVSNHZOc3dSZ2l0N1RrcVBM?=
 =?utf-8?B?UEdOemdsSTNsQi9Held6MDV4OUpTWjFaU2ZyRmpCdFRuUjZScys2M1JVcXFR?=
 =?utf-8?B?cUJlakw0aHl6ak1ESkJkVmVCZTlmZjVwbHZTT1VHQjJOemlFczlTdVFGOHMz?=
 =?utf-8?B?T1ZVcERzU3NYZ2hQbmkyeXYyYUovWGk5cTd2MUlJM0hnZXdvY1daWWpBTFBi?=
 =?utf-8?B?YUVvL2VFSjNnZkcrdUdEVG1jZUVHMG5RRVV6YVdTL2oxcHo4YzNnN2VCWUU5?=
 =?utf-8?B?bmh3Y0QxQW54YlJkYXFibE1DcUFrNklJR2k2bmk1K3liOVl1OXhVa2JHVVJY?=
 =?utf-8?B?REtLbE1PU3p0Zi9vcXVsM3NpWFhsNGIxNWlnNzNuUExqWUIvN29wbm90RlRW?=
 =?utf-8?B?c0RlT05LWmpCWDBLVituL29wWDQ5cWpRZ2lJQkVCZTB2akg1RFFzWUNsKzk5?=
 =?utf-8?B?a2tacDVBMkN0QWpiNzg4cnZ3cnYzUjk0QVpHcWFGSGsxYkE2SHlnOU5pQStE?=
 =?utf-8?B?WlJnZlFNWDF3c051NElqOWpFQTdBSVNaZUU4Z1N1cWZ1cFZlQkRDOTlTanZS?=
 =?utf-8?B?WmliWGlvSVpEYlQreU9WWElXOUh3VGxFMWxHcisrUVZUaDZzaXpFRzd0bko3?=
 =?utf-8?B?b2UxZFYySVRTSS9KenViaFptK3k3R2xheFE1ZjNoZTN4enQ4NnRuWlFkNHow?=
 =?utf-8?B?YVQyaGRDOFFUc1ZwcEp6anl2TlVpUS90amJpNUhlOWxEV2pPVm0xZ3lLc0xR?=
 =?utf-8?B?Nk4rbmZpY3poSldwcFFMR1B3UnhWc09DYXZLcTRXODJrWFA3eXNFVXE3VUpT?=
 =?utf-8?B?eHQ2c1ZmTDVCZEsvYVR0eWxORTdCQ1lEMUVRMmJxNWJnWUdqeDkzWGVqNGt0?=
 =?utf-8?B?RExpTFd0OHhyclNva3dhcjk5clI4RTdmblhBTTh3RmFSekNVVk5hV0xrbU91?=
 =?utf-8?B?SFZ1WGVqa21YTVgvMHJVNjF4UDFBYVhwdnZGWlpUMzBCbi93WCtJY2NrOTFR?=
 =?utf-8?B?M2piSG1MUk1WcGhpQUllWW5mbVExWUtyQlNXNE00N1Z3bkhWQ01mcnc1dWpF?=
 =?utf-8?B?UEk0Y2JuaUZuMmZJbldZQ2xaMXFqUm5yZnNBUERVaDNKMThyb3hwQkVha2hi?=
 =?utf-8?B?a01sbkx5QTJmYW5UQy9DVlVaOFRUbnErSHVrUVo2QURqRTVUakhZQzhWYmlM?=
 =?utf-8?B?WTBGaFY3dVNTZUZ1WUxWa2VGVGFpa3JnSWNraDZBY3ZWenFkVUhEUEN6RGZC?=
 =?utf-8?B?eWZ3VUoxSHIzSVI3NGhSTXZzYmFxQUZQR1MyM1VVWVJyd0plN0tPc3lBSlQ0?=
 =?utf-8?B?WWZZV1NZZ2t3NUNsTW0rVEFFdHZHYURzb2duYVpjM0JBOWhmTlhTVk9QN2VK?=
 =?utf-8?B?N3Y4UWM2ZDdQY1IxWHl5Q2ZoNm1YNkFtQlZYbkV3Y2lKMExQQUI4Ly9neHJ5?=
 =?utf-8?B?OWNNUjlnNjJRM2lPdldHRVpOWFJMY2NtOGJIbVViMVlVM3BLS0U0djdSWVp3?=
 =?utf-8?B?NkhvRlpRZjhyL2JDWkQ0aFRjTkY5NWtvM3V2ZGM0YXhjaFd5MUh3ZmF0YnpZ?=
 =?utf-8?B?U2VXNGw3YmdQcmdheloxZmJKbEQzZlZrRXUwY0tlRHluYzZRalFNNnh3QUlE?=
 =?utf-8?B?di84NUhjVmxRbGdnK1F6VWR5UmdkZklZdVhxVjVWaThWL29iNGRuTUJsOWZS?=
 =?utf-8?B?TzdadFhmWi9vdkowYTg4R25EU1BDYUZOTVZLenlJQVFhN0VmSWw4VjhHRUhn?=
 =?utf-8?B?UFBEQzlmZkprN1NnR1R3NDkvNElPTWlDWlJOemxrdm14ZXprdFJyb2hUbHB2?=
 =?utf-8?B?OVdpM0dvNVhEUzkwamJTWmlreUZGUERZSEUwVHVibXllMzNCaFNEdkpGQkZE?=
 =?utf-8?B?eU5pYlQyMS9aNEI0R1A3L0VTemNqaWt3ZFJacEIzWWxtNDFsUTZPaWZBRW9H?=
 =?utf-8?B?MzdsdFFYeCszL1FTMDVoZm1RR0ZYTndOMjJsaVFVaEtOcHNqYTZ0WkJPMzVT?=
 =?utf-8?B?TFd4dnFYcWVGeG10RUhUQS9IVkQwbTBoRTRWQXBxYTEzMTVGYWFacG9Oem5v?=
 =?utf-8?B?alpjRlU1OG5oZHNQZnlQbHFpYkNWcWtsTGtJNEU2a1RpTkxjMUtrMWdOYWw1?=
 =?utf-8?Q?Pr160cmDkXYYw48VxAMswEY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MWh2VFVOMDE2dXlzdHBZWVZnQzZxdHdmbWNTUjFLNC9VNmsrQjN0UnB1VHYy?=
 =?utf-8?B?YjUrU1R0aVROZlFCcjlvZjUwR0dGRFhEaTJGVzRTZ0ZlYkxxK1psNHJTTUx5?=
 =?utf-8?B?S1NXbC9PdzhZa043ZmE3dnFMK1FJYzllcGg1UTVnZTFueDR6WkhoTnpUazF1?=
 =?utf-8?B?NW9aZHgyTjhjY0dEL29KSk1wK1ZRbEROQzRNa2JwYlJ5Ym1RZmRQN0JMNTAy?=
 =?utf-8?B?Z0VFSHB0QnNFQmppKzVQNE1DYU4zWWlNZ0dJWEVidXp4QmtuNFEyaXBYbmdP?=
 =?utf-8?B?bHNodmtMRGJTcmMybmRubTZIUi9wemxQN0MrbHl1S2Q4TkhMb2Vjbm95Wlgy?=
 =?utf-8?B?WkVKUUhMZ1BScHNOb1BIcFpONlhHVnJsbFNjTllSRGpSYXptSzZkVmdRaTZL?=
 =?utf-8?B?dWNJMTJvNTYwSzN4OTY0SHA0TFk4NERWNjg3ek9BWXd5SkdCS1YvQjFkenVX?=
 =?utf-8?B?UXNBb0ZTMzBlS0N5alZWczZzUkNEcmlROTBwVEtnRjMwYUFmUGJEQU1FRFM2?=
 =?utf-8?B?d2JYU3Vkd3dwbklVWkNxeisxZWw3NjVjODkwOFVKTGxwZDJJUUI4SCtEenNM?=
 =?utf-8?B?aFFBZmtjWVdQczRLeVRnS0xpZkc2VjRBSVh2UDFaOVdHZ3c1b0FkZmZXcDZU?=
 =?utf-8?B?N1VBWFpvNmxpVjNBUTB0bWgwN282ZEQyNm9DT2VoTCtISEI1NTZRUzNFbFZE?=
 =?utf-8?B?Zk84Nm8xR0RmekJsQVQ0QlQ3WE1JZmxsdmtxV29MM1VxTkk4YmEwRE15clVs?=
 =?utf-8?B?WEtkVGtZRE8yQUE0Zk9QU0dUQXFpVitiYVE0bzd0aGt1aERTMXAybmVpNTMx?=
 =?utf-8?B?VXJxL1VqSnQwYzlkaEZZN3ZuKzQyNVpGUThwdE5oNE5oa2FZdHdBVCthOS9u?=
 =?utf-8?B?dHVNd1Nab1dFb1V4aEFKL2JlbjEzaDMxVENCeHdSZy82ZDV3UGxrTTBxTm8v?=
 =?utf-8?B?S3U0VGU2WFJ5bXNDQUNGemdkOVpKRW9mZHhVcnF0NzlmMWt5SDBCaWZPeElK?=
 =?utf-8?B?cFUrS1lsSHRoWHJlR2JhL1VTVzE3VFlzMnJiaEdQZUtpdE12cVoxVndDMW1L?=
 =?utf-8?B?Y3F2RHBFcW0wSVE4OGtrZnRvMDRXWnU0VndIa2E3UTNiclZEQzVFdVVFWTNz?=
 =?utf-8?B?S1RXcFpiZ3lLdkYyMGoyYjlJNGRpZDk5R01OSUNJdUw5M284VUt3RVhoTEEx?=
 =?utf-8?B?a1FLbkhsS1ptNnFFNlVGRDlrd0Eydk51Q2NQQ21RRHJJRUQzRnRkSUMxNVBD?=
 =?utf-8?B?OXdPZTVkR0s5RHdJRjRzaVpINWRndEVHdXI3QnR5OU5xalltZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 223e81cb-9a56-4dcb-33e2-08db0a27ec34
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 22:57:58.8091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KutsaLBX+2RtNMScwgmAf7g8u4LDWKn35Q5A3jlVmEY8m4BLucxd65K8siwrGWtPJG4LpAoD+Ej1kT/9FX7Uyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4777
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_09,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302080195
X-Proofpoint-ORIG-GUID: 2iH-kH4sycmfEMbCrn9AydSb3-aftFWL
X-Proofpoint-GUID: 2iH-kH4sycmfEMbCrn9AydSb3-aftFWL
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/02/2023 20:51, Jiri Olsa wrote:
> On Wed, Feb 08, 2023 at 11:43:18AM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Wed, Feb 08, 2023 at 02:19:20PM +0100, Jiri Olsa escreveu:
>>> On Tue, Feb 07, 2023 at 05:14:59PM +0000, Alan Maguire wrote:
>>>
>>> SNIP
>>>
>>>> +
>>>>  /*
>>>>   * This corresponds to the same macro defined in
>>>>   * include/linux/kallsyms.h
>>>> @@ -818,6 +901,11 @@ static int functions_cmp(const void *_a, const void *_b)
>>>>  	const struct elf_function *a = _a;
>>>>  	const struct elf_function *b = _b;
>>>>  
>>>> +	/* if search key allows prefix match, verify target has matching
>>>> +	 * prefix len and prefix matches.
>>>> +	 */
>>>> +	if (a->prefixlen && a->prefixlen == b->prefixlen)
>>>> +		return strncmp(a->name, b->name, b->prefixlen);
>>>>  	return strcmp(a->name, b->name);
>>>>  }
>>>>  
>>>> @@ -850,14 +938,22 @@ static int btf_encoder__collect_function(struct btf_encoder *encoder, GElf_Sym *
>>>>  	}
>>>>  
>>>>  	encoder->functions.entries[encoder->functions.cnt].name = name;
>>>> +	if (strchr(name, '.')) {
>>>> +		const char *suffix = strchr(name, '.');
>>>> +
>>>> +		encoder->functions.suffix_cnt++;
>>>> +		encoder->functions.entries[encoder->functions.cnt].prefixlen = suffix - name;
>>>> +	}
>>>>  	encoder->functions.entries[encoder->functions.cnt].generated = false;
>>>> +	encoder->functions.entries[encoder->functions.cnt].function = NULL;
>>>
>>> should we zero functions.state in here? next patch adds other stuff
>>> like got_parameter_names and parameter_names in it, so looks like it
>>> could actually matter
>>
>> Probably, but that can come as a followup patch, right?
> 
> sure, if Alan is ok with that
> 

it's a great catch; I sent:

https://lore.kernel.org/bpf/1675896868-26339-1-git-send-email-alan.maguire@oracle.com/

...as a followup. Thanks!

> jirka
> 
>>
>> I've applied the patches, combining the patches documenting the two new
>> command line options with the patches where those options are
>> introduced.
>>
>> Testing everything now.
>>
>> Thanks,
>>
>> - Arnaldo
>>  
>>> jirka
>>>
>>>>  	encoder->functions.cnt++;
>>>>  	return 0;
>>>>  }
>>>>  
>>>> -static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder, const char *name)
>>>> +static struct elf_function *btf_encoder__find_function(const struct btf_encoder *encoder,
>>>> +						       const char *name, size_t prefixlen)
>>>>  {
>>>> -	struct elf_function key = { .name = name };
>>>> +	struct elf_function key = { .name = name, .prefixlen = prefixlen };
>>>>  
>>>
>>> SNIP
>>
>> -- 
>>
>> - Arnaldo
