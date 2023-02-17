Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE73C69ACDB
	for <lists+bpf@lfdr.de>; Fri, 17 Feb 2023 14:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBQNqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Feb 2023 08:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjBQNqK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Feb 2023 08:46:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A423497FA
        for <bpf@vger.kernel.org>; Fri, 17 Feb 2023 05:45:53 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31H7iLwJ009708;
        Fri, 17 Feb 2023 13:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GvmavUex+TcqLkmu0bmVOqKDIriHs8HU/LEW5AQbn4M=;
 b=gFNMwa8vCtikZMM2zWe1r9JllwIW3+estCGF1R7wBAlecKuMnBtrn52RI9Z+Nf1WwRSk
 XwXcrGrE18BOqvpTV/YB5vlpXyF6DpRypBda1Ro1xBrMzzawCXC84db1s2x5bqqvYhHe
 23YA6E/cIy4xj5RcvCKA5L9SiO30DKeAcZhzc5j6m+MN95YtPjmqS8lCzCCc86R5KJMo
 JvuPARUZ0uG/Qg7F8+nJyhS5hiCC5e3TUjVpu7/A54NAikrzrqODjmKY7+psAo6h2KXu
 sFLLdnHprIf5QrTqfCYoUDkY9LTQvFeKzLrEn4qDa0FKJy2cwz78k/wbLtLzheCJqpwm EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1xbdx5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 13:45:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31HCgaJS012163;
        Fri, 17 Feb 2023 13:45:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3np1fa43ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Feb 2023 13:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq0QMkpmFuoCCKDiMKUk1z8uz5i7mmkXFvUVs4Dcxx5k5JS1ND68kjgNaI4mwH1S5kLretuqNr46Zfa6cIFEcSfkRxVEpefkFjyL6IOimtW0z2WYv9wLhZ0V9KhwDdeI8iuD7rcuM1ULfLeLBUBR2TFZ0hYTVVMgy3q1RxhDHJlBBhb6LdPaBUs5vvVPQFpJzR/RC2viN3wEAsEVA+bonWiF6AzbEu63Ze3Ryk/Dc9q37FWtt6G6Q63eGxOl7LkU14pogkvLzZ7J1g3HtFQfUbHg4/cLWlxMd+y/AWmyAztdQaxM+zG171wzzAAQcXAwfJPWzWEmauvC8rTDs1lfiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GvmavUex+TcqLkmu0bmVOqKDIriHs8HU/LEW5AQbn4M=;
 b=XdgeqOdrbpWLgTeJ30WB+j8QQrDdgSbCCkD1w/ZsI3uNYf3U08VOET5UXJSHMECve+ETcgOnrhUqzZlE168HxVzKa/8gGbM63jN1OYI65L2udh5uytQpYE7nW3g//1V+H4Nh6AjRw2zHJjQTYz6s+zaHmwl4m3VxrIyriBSF9HQ590zje5uV4CJcfDPD444L2FBQUsJWGTeid/0d5qJSKZPXo60s+XdHot1/KWU5uTpKDQ0RMxSCXLD41CUma5nL2iiPfCmb0NjeK/Gg6ndxUFgRwfBuQ1nnZ3kcB+Gu6uycE3HMwCI3DBz3IcqcyQZ68Gu+lFzodjg9CPkdTwndpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GvmavUex+TcqLkmu0bmVOqKDIriHs8HU/LEW5AQbn4M=;
 b=U6DU0RpX/CjjrZkR/pPlZIXeP/P3YgaFgCDEMpuqhOn1+dWIaSWk4Yu5vwCdfAbdQC8cqtdapacmQ04vf1vQlZ5ncBYwGxiLPFcKrp12rpOnsxx23XHYhbZllTBwYKi1iiK3dxH+junEbnm2ZrGwacvAKsMABtktMuIRLkohgxI=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SJ0PR10MB5834.namprd10.prod.outlook.com (2603:10b6:a03:3ee::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 13:45:17 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%8]) with mapi id 15.20.6134.011; Fri, 17 Feb 2023
 13:45:17 +0000
Subject: Re: [PATCH bpf-next] bpf: add --skip_encoding_btf_inconsistent_proto,
 --btf_gen_optimized to pahole flags for v1.25
To:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <1675949331-27935-1-git-send-email-alan.maguire@oracle.com>
 <CAADnVQ+hfQ9LEmEFXneB7hm17NvRniXSShrHLaM-1BrguLjLQw@mail.gmail.com>
 <Y+t+P2OOpEZ7UemB@krava> <Y+u0NMmLGG3zJJUx@kernel.org>
 <Y+wHUlZpB4IeNyfp@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <6bf22f80-d693-cb4d-acc7-f09029315584@oracle.com>
Date:   Fri, 17 Feb 2023 13:45:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y+wHUlZpB4IeNyfp@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0269.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::17) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SJ0PR10MB5834:EE_
X-MS-Office365-Filtering-Correlation-Id: 54b25e1b-0dfd-4fe8-0917-08db10ed3469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdCf63oKUSklypRONPRKbyAwnAIBwj721bSRDextVMXTYy2pFfKDUMyJfSD707OcPqQ4SUckr1RQ8bXe2keYCJHi/oYvRBBmRS6Abk2d3q0kB1Bed9qq7SUgyrdChZxpck/FxqD+2WUq3C5snx2EUUwhmFVl+24ah1Nt2ESQF/4RsEr7IHAWujA6s5QZve8Bhn3qkpEdvdxjrUH21J3NJtV5eo4cAnnNBR0ZmhJ7HIyZYho/y/5QRli1xvm1n0M/1M+Zjlb7hj5FGr9efPkBvQf8qGqrlJXa0qLIFky+PIE6GkQf2DlW/vqAbKrG8t3J4hSY+oH9nCsxge+vNCB9eAAl3ItUPASuw0SEbUN1RTmurfRoBlPvbWI12zTzMq41ojVR99NpdFPLRE5+3Y3A+r0xUeSg/wyAryHYM08VBUVwCZcnUrI2L04UY5fdP6kH/AM76Nr3HehD/mKX7TsI1zRpO6bLYcnXg2Gua/szgEjgEfuWmgxhehjVQoAC/o2LKrR6OwAMAHVL8hr5jDYcHthpkdcSiE9tkQt2FmcUD7tBiUQPCRZS+bljuMu9cQ+DDTDaJcDXxdCIrlQhxMsoSPQOIqY3pi/Pr0dnyjeGqlAC1L0TXd46VXsDfj1hLaekmx0WZQvRXoAQCPMPr2zxPUsFQ5n1hqCm9qw55ZFuIdpZRPn77SXgtdDe3BhqIlVb02SXqEhvuKukixQF4fS0ocSzdY8tzNSG4XqMmQqI9Fg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(31686004)(44832011)(31696002)(2616005)(83380400001)(86362001)(2906002)(36756003)(478600001)(6486002)(966005)(6666004)(53546011)(6506007)(186003)(6512007)(66946007)(38100700002)(7416002)(30864003)(8936002)(5660300002)(4326008)(66476007)(8676002)(66556008)(41300700001)(316002)(54906003)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkZCdyswR1NuTzdpU3NUeGlqUVJYQURDM2dTaTFwQ2tmdXZMeHFtb2tjVmJP?=
 =?utf-8?B?VDFNRXZQMFVzSWQrUmp3d0pvTS9USExNblZzZVJVSXQzZTh4OTdQaVBGR20w?=
 =?utf-8?B?R3RFR0VCZHJTNHduWGJaL2xyVUhqc3lweTBtYnE5M2xzT3NncVRKaXlNa3lT?=
 =?utf-8?B?d0dIclc1ZjU5ZE9GMjNOblJPNmNtWmsyekRXRk9Pck55TWc0b05scEJwajEx?=
 =?utf-8?B?RnV3RTc4cFhlZGJtbWdSRGhhbHQwNU9hQzRaRUo5Q2x0Zk9vd1pvb3VBYlRH?=
 =?utf-8?B?bFNYMHU3TkdGWXd6Q2ppcE1IS0s1QXY5V0NvelFyd3hBOUFPL0RZdGFDS1Zl?=
 =?utf-8?B?MG96VCtRZ29mc01FMjBwSzhvdzl2Vm5BRkdLUzVaL0lzdWxKTGN3d2R2WUV1?=
 =?utf-8?B?RWxhcFVWaUNXTE1RdG9BQ3pkYjNEMlpsejM3MzUrWEdqbEhVN3B1emdQYTNH?=
 =?utf-8?B?WE9MSERNb2dhL1Q3bFhBKzVFMVVycVBIYkIzcXd0OTlXV1F4b2JhTVRLdTFH?=
 =?utf-8?B?QUtjRE9iaVFGZTVLMzFhY2pEYzVBS0UrazRMQzlMM1R3Y0dPQ0pTNmc3bDR6?=
 =?utf-8?B?Mm0wK25UN29mL00zU0tETE16VVdNZTNPdzhtbHBoOWpSb2FLL0hsTWtwOWxh?=
 =?utf-8?B?WEdUYUJQTmdlNmRkcWdtd0g5YzJCSHJpbmc0UlJ2ZGl3THkxVU1WL1EyTE9N?=
 =?utf-8?B?TmJiTlg2UmNsRnpCSkw1OFJDNXdkY1dLQytBK1FyTTlQMGxXWkd5ZEZJQlJC?=
 =?utf-8?B?QWtNWmo2UDYzQkZzekhpZ3hscHNzVTk0emtxVmlkczFKSU5FOEhNRFhzTS9w?=
 =?utf-8?B?VVZiL2RWTjZPT1BUcFlhdUlLandUV1hNeWFHT3JLM2YvZ0k1dnFHY2hQNDNr?=
 =?utf-8?B?R0NXRGNaL25maUxtQlNSRTVQelE2dXl2QnMrazBCUHZjZFZQbkVrUzlDd1Z5?=
 =?utf-8?B?QmdSMCtjTG5HbjRqbUJKelg3UFF1aXVualE1QVhJMmZtdzZYeGJGWitmOVUz?=
 =?utf-8?B?NXo3dlNOVHFOZS8rRE9iWWIzN0tqZlJ2WnhkakZ3dnNLR2NBcys1ZWJPWk55?=
 =?utf-8?B?YmNRcEFWRlhNYmpsN1NQV2Q3T01pNGRaWWVBREJsbWJnOUVuSExIb2QwS1B0?=
 =?utf-8?B?MEZNOGlrK3lybUJvdkU4dE15WjFneCtOUWRjWHo5aDArWHJRb2VrbGNhYWxq?=
 =?utf-8?B?Vk5OS0g0T1hKNGRTYjEwYjJnMkJqeWF3TDlNMEc5YlVhc0VOd0pHMk8yVUxQ?=
 =?utf-8?B?QmVkTjVGdlBKSWFJNTBHRDNwY0dxRVJaQjFaN2pWcFhOaVNwRlpTL09iSlZY?=
 =?utf-8?B?Z3lhYWI4cW5YSVhUUlhkdWdJSENuY1hEUzJEUE5EdXpRUTFpVkxtNWQ1d1Vs?=
 =?utf-8?B?aHBPdnVqQThTRXpjZTBMNWFodlJoQ25rL0REN0NjNWpIQmF4VWV2UmpVS0ky?=
 =?utf-8?B?Um51eFQ3d0NnVmFleUw0VjgzS2RoanVVbHBrZndYdEFvY2Z2TTdFR0Q5Rjl1?=
 =?utf-8?B?OVJvWCtmMjVuUG5odFF6S0FXSktqUXY5Nk93TlQzU1ljVUdxemNzVWJLMWZK?=
 =?utf-8?B?NEkycnpiL0F0SXlHQktncFMrTlRaRmRjSnFyc0NGbVd4bXl3ZlpxWktBdkpa?=
 =?utf-8?B?R2FrMjVBQTJJa0RGdFRramhjT25uMWdkQ2E4a2pYKzVxV3prWkk2SDZQSndX?=
 =?utf-8?B?QWFDZnFSa2l2Y3JmL29qME5DOER0MXovNm8rM0JrK21yQ0xndnMrdEdFdnNS?=
 =?utf-8?B?TWhRNzNpUGZnRmpVNGZWTldxUnZaQnBLWFJCaGFkaWdIZ3o4Mm1FS29zektZ?=
 =?utf-8?B?VkFZMzNTU2hEbWIyVHNsQS9OT0xnbnZ0d2lucVo0cFR6ZUtsbXZ0ZFhHU29N?=
 =?utf-8?B?TDRSOXRVVGVVZzRuSDMwWE9sMHo2bGtIUlNmdnFzRTcvUWN3anZId01FVitD?=
 =?utf-8?B?VG5JWlBZcDVvT1BTeVlXUVdiQmlPVGJ5dWhHUGxDMEhQQkVScEtEbkJlcisy?=
 =?utf-8?B?UFB2R1JvdmRIa2NvZ3pkTVBERTlLZ0xubXZKaGQxMmF4aEpYTDJUOWxzeDA4?=
 =?utf-8?B?RUVJWGdKK0JodGRSUmN3SWEvYWZ1Zm0wazI5RkZNK294cUppdk1YbERmRkRw?=
 =?utf-8?B?dHdPZHpQcTMxV1pKOFZPblVpVkIzRHI3b0FldUs3d1hZcHFvd0RaUXNYODNj?=
 =?utf-8?Q?Sn0PdP38A+iW2QSUDHzS1K0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Sk5UNjlxUVcrM3VrT2IzRWdEK3M2d01kQ04zb3poYmFVYThEY3F6N0d2WHZN?=
 =?utf-8?B?SVI3WmhkTGJGTXI2dW4rSGlqNFdpRE5FL1NQZWdaT0lIV0l3RjhGeHZlSnRV?=
 =?utf-8?B?NDlnY0xiSzRpS1dVNmZacXV4RkdlNHZqcHdQbzNwMG5GQ3ZNY2V3dTRac09k?=
 =?utf-8?B?bklQRGxLSmJVemdOcndLK0tVcWNVVXlRTEd5ZEExUUZ5Wk55S0plMlZTVDNS?=
 =?utf-8?B?NG9QeVhBdEtJNzVpdEtWajNoRmNhcFkxNCtwbkFFK1cwVDBoK0NadGFzQWVW?=
 =?utf-8?B?b2oxdStpbklpQlM4MFpHMmlReUpYclhSbzE4TGdyK0pCRmc0ZDRBdUNzaFNq?=
 =?utf-8?B?VHJGR3VwZHhVQ0hxM0dGdUNkQXVJSDBOYWJMMzdBT2NuLzlKRkVDVFkvLzJt?=
 =?utf-8?B?UXkzSTNOTW9yMGhOQ2lFdmE2Yyt3NGV5RDdvbDh0bFplc3M3aU52a3dOa1Ru?=
 =?utf-8?B?SXpwVlEzeEhzOFVPNGJUNUVzZHFHaGkxUWtwbExHSHN2T3E3bGRLOEtoQ1Bh?=
 =?utf-8?B?aEo0dCtUYU81YmxiaDJEalBWSHRMUXVVSElTU0x1dUtmc1lZMFBxWE1CRkdH?=
 =?utf-8?B?NWFTSFZNajVKSUhpNGRINnpIZGpsTlNWWkR0U01SbWhPL0ZoMlJiV3hid0tX?=
 =?utf-8?B?ejczRmNrRGJUcElvRXRiRCsyR0Z4MzRZVU44akV0RXpBQTcydWZ1b3VRRWVR?=
 =?utf-8?B?K09lWXFmSFJXd3FuRWJOemlkQzh6RmZ2UEpKTkx4ZGRrb1c2bGxjd2U2c2Ny?=
 =?utf-8?B?bE01VVRBbWExSFlFTWdHSmxzZlVtd3JxVjFzRTU2c2tCdHppY3RoY0ZTMW5p?=
 =?utf-8?B?UXI2QktPV0V6WW04QWN0VmFiUjhseHNleEFGMjV6eXNvNzdsZ0cwNkw2Ulcx?=
 =?utf-8?B?NG9TVi83NVFQNEVIR3RYN29FZFNINUx4SGpJYnJTenVIUEVLclRLSzU4M0ZF?=
 =?utf-8?B?MHQ2ZkNsRVEvNGMzbzN6Zm5WNkVEdDNWVmZwLzJnbjlST1hnU1k4alJ5VVJ6?=
 =?utf-8?B?OVBVbW5vcWxEYllrOEt2YUZBUFkyMGZFNlhWcVdQL3BJTU15ek5YQVU5NmNp?=
 =?utf-8?B?ZjR2aTNDMkU3R1diZ2Q2cEZDcHRab3lBN24zVUlBenBybnVkcFAxeTczQlRH?=
 =?utf-8?B?alZLMXNibWlsM2dXNnVYOVg3QWNzcmdvWFM4QUJlQlhuWFpyalFtRDYxa1RK?=
 =?utf-8?B?TXlrbTVXZ3VmUmVYaDNaZnVZNElLdkRRVDFIcGdKL0FyRmxlcFNsaFdqSVVP?=
 =?utf-8?Q?g+Phi7U8g2MbCab?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b25e1b-0dfd-4fe8-0917-08db10ed3469
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 13:45:17.7680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bz1RINt02SQkahILrDPPEQk2ZrOt5I+u8GqQ/xfAs9SuoTklSiIZM/E8m/tTeHBmkxbVTm8Cgs2yVY1fg/C8yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5834
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_08,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170124
X-Proofpoint-ORIG-GUID: ZeO81ua2Y25nPCL29dBXyUf0mhj1O1Go
X-Proofpoint-GUID: ZeO81ua2Y25nPCL29dBXyUf0mhj1O1Go
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 14/02/2023 22:12, Jiri Olsa wrote:
> On Tue, Feb 14, 2023 at 01:17:56PM -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Feb 14, 2023 at 01:27:43PM +0100, Jiri Olsa escreveu:
>>> On Mon, Feb 13, 2023 at 07:12:33PM -0800, Alexei Starovoitov wrote:
>>>> On Thu, Feb 9, 2023 at 5:29 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> v1.25 of pahole supports filtering out functions with multiple
>>>>> inconsistent function prototypes or optimized-out parameters
>>>>> from the BTF representation.  These present problems because
>>>>> there is no additional info in BTF saying which inconsistent
>>>>> prototype matches which function instance to help guide
>>>>> attachment, and functions with optimized-out parameters can
>>>>> lead to incorrect assumptions about register contents.
>>>>>
>>>>> So for now, filter out such functions while adding BTF
>>>>> representations for functions that have "."-suffixes
>>>>> (foo.isra.0) but not optimized-out parameters.
>>>>>
>>>>> This patch assumes changes in [1] land and pahole is bumped
>>>>> to v1.25.
>>>>>
>>>>> [1] https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
>>>>>
>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>>>>>
>>>>> ---
>>>>>  scripts/pahole-flags.sh | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
>>>>> index 1f1f1d3..728d551 100755
>>>>> --- a/scripts/pahole-flags.sh
>>>>> +++ b/scripts/pahole-flags.sh
>>>>> @@ -23,5 +23,8 @@ if [ "${pahole_ver}" -ge "124" ]; then
>>>>>         # see PAHOLE_HAS_LANG_EXCLUDE
>>>>>         extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
>>>>>  fi
>>>>> +if [ "${pahole_ver}" -ge "125" ]; then
>>>>> +       extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_inconsistent_proto --btf_gen_optimized"
>>>>> +fi
>>>>
>>>> We landed this too soon.
>>>> #229     tracing_struct:FAIL
>>>> is failing now.
>>>> since bpf_testmod.ko is missing a bunch of functions though they're global.
>>>>
>>>
>>> hum, didn't see this one failing.. I'll try that again
>>
>> /me too, redoing tests her, with gcc and clang, running selftests on a
>> system booted with a kernel built with pahole 1.25, etc.
> 
> ok, can't see that with gcc, but reproduced with clang 16
> 
> resolve_btfids complains because those functions are not in btf
> 
>   BTFIDS  vmlinux
> WARN: resolve_btfids: unresolved symbol tcp_reno_cong_avoid
> WARN: resolve_btfids: unresolved symbol should_failslab
> WARN: resolve_btfids: unresolved symbol should_fail_alloc_page
> WARN: resolve_btfids: unresolved symbol cubictcp_cong_avoid
> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_timestamp
> WARN: resolve_btfids: unresolved symbol bpf_xdp_metadata_rx_hash
> WARN: resolve_btfids: unresolved symbol bpf_task_kptr_get
> WARN: resolve_btfids: unresolved symbol bpf_task_acquire_not_zero
> WARN: resolve_btfids: unresolved symbol bpf_rdonly_cast
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_static_unused_arg
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_ref
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass_ctx
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass2
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_pass1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_pass1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail2
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_mem_len_fail1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_kptr_get
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail3
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail2
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_fail1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test_acquire
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test2
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_test1
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb_release
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_memb1_release
> WARN: resolve_btfids: unresolved symbol bpf_kfunc_call_int_mem_release
>   NM      System.map
>

Jiri kindly provided a clang-generated vmlinux, and I also managed to reproduce
issues by building the kernel with clang 17.

The first question is if we're detecting optimizations correctly. From
an initial look, I _think_ we are, in some cases at least.

For tcp_reno_cong_avoid(), the function signature is

__bpf_kfunc void tcp_reno_cong_avoid(struct sock *sk, u32 ack, u32 acked)

...but our handling of the DWARF generated spots that the "ack" parameter
has no location info; and looking at the source it is never used.  Here is 
the DWARF - note no location info for the second parameter ("ack"):

0x0891dab0:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff82031180)
                DW_AT_high_pc   (0xffffffff820311d8)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_call_all_calls    (true)
                DW_AT_name      ("tcp_reno_cong_avoid")
                DW_AT_decl_file ("/home/jolsa/kernel/linux-qemu/net/ipv4/tcp_cong.c")
                DW_AT_decl_line (446)
                DW_AT_prototyped        (true)
                DW_AT_external  (true)

0x0891dabe:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x7a) loclist = 0x00f50eb1:
                     [0xffffffff82031185, 0xffffffff8203119e): DW_OP_reg5 RDI
                     [0xffffffff8203119e, 0xffffffff820311cc): DW_OP_reg3 RBX
                     [0xffffffff820311cc, 0xffffffff820311d1): DW_OP_reg5 RDI
                     [0xffffffff820311d1, 0xffffffff820311d2): DW_OP_reg3 RBX
                     [0xffffffff820311d2, 0xffffffff820311d8): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
                  DW_AT_name    ("sk")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu/net/ipv4/tcp_cong.c")
                  DW_AT_decl_line       (446)
                  DW_AT_type    (0x08902c4d "sock *")

0x0891dac9:     DW_TAG_formal_parameter
                  DW_AT_name    ("ack")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu/net/ipv4/tcp_cong.c")
                  DW_AT_decl_line       (446)
                  DW_AT_type    (0x08902c3d "u32")

0x0891dad4:     DW_TAG_formal_parameter
                  DW_AT_location        (indexed (0x7b) loclist = 0x00f50eda:
                     [0xffffffff82031185, 0xffffffff820311bc): DW_OP_reg1 RDX
                     [0xffffffff820311bc, 0xffffffff820311c8): DW_OP_reg0 RAX
                     [0xffffffff820311c8, 0xffffffff820311d1): DW_OP_reg1 RDX)
                  DW_AT_name    ("acked")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu/net/ipv4/tcp_cong.c")
                  DW_AT_decl_line       (446)
                  DW_AT_type    (0x08902c3d "u32")

Disassembling we see the following:

(gdb) disassemble/s tcp_reno_cong_avoid
Dump of assembler code for function tcp_reno_cong_avoid:
net/ipv4/tcp_cong.c:
447	{
   0xffffffff82031180 <+0>:	nopl   0x0(%rax,%rax,1)
   0xffffffff82031185 <+5>:	push   %rbx
   0xffffffff82031186 <+6>:	mov    %rdi,%rbx

./include/net/tcp.h:
1305		if (tp->is_cwnd_limited)
   0xffffffff82031189 <+9>:	cmpb   $0x0,0x95f(%rdi)
   0xffffffff82031190 <+16>:	mov    0x9e4(%rdi),%eax
   0xffffffff82031196 <+22>:	mov    0x9e8(%rdi),%esi
   0xffffffff8203119c <+28>:	js     0xffffffff820311ae <tcp_reno_cong_avoid+46>

1238		return tcp_snd_cwnd(tp) < tp->snd_ssthresh;
   0xffffffff8203119e <+30>:	cmp    %eax,%esi

1306			return true;
1307	
1308		/* If in slow start, ensure cwnd grows to twice what was ACKed. */
1309		if (tcp_in_slow_start(tp))
   0xffffffff820311a0 <+32>:	jae    0xffffffff820311d1 <tcp_reno_cong_avoid+81>

1310			return tcp_snd_cwnd(tp) < 2 * tp->max_packets_out;
   0xffffffff820311a2 <+34>:	mov    0x9b4(%rbx),%ecx
   0xffffffff820311a8 <+40>:	add    %ecx,%ecx
   0xffffffff820311aa <+42>:	cmp    %ecx,%esi

net/ipv4/tcp_cong.c:
450		if (!tcp_is_cwnd_limited(sk))
   0xffffffff820311ac <+44>:	jae    0xffffffff820311d1 <tcp_reno_cong_avoid+81>

./include/net/tcp.h:
1238		return tcp_snd_cwnd(tp) < tp->snd_ssthresh;
   0xffffffff820311ae <+46>:	cmp    %eax,%esi

net/ipv4/tcp_cong.c:
454		if (tcp_in_slow_start(tp)) {
   0xffffffff820311b0 <+48>:	jae    0xffffffff820311c8 <tcp_reno_cong_avoid+72>

455			acked = tcp_slow_start(tp, acked);
   0xffffffff820311b2 <+50>:	mov    %rbx,%rdi
   0xffffffff820311b5 <+53>:	mov    %edx,%esi
   0xffffffff820311b7 <+55>:	call   0xffffffff82031080 <tcp_slow_start>

--Type <RET> for more, q to quit, c to continue without paging--
456			if (!acked)
   0xffffffff820311bc <+60>:	test   %eax,%eax
   0xffffffff820311be <+62>:	je     0xffffffff820311d1 <tcp_reno_cong_avoid+81>
   0xffffffff820311c0 <+64>:	mov    %eax,%edx

./include/net/tcp.h:
1227		return tp->snd_cwnd;
   0xffffffff820311c2 <+66>:	mov    0x9e8(%rbx),%esi

net/ipv4/tcp_cong.c:
460		tcp_cong_avoid_ai(tp, tcp_snd_cwnd(tp), acked);
   0xffffffff820311c8 <+72>:	mov    %rbx,%rdi
   0xffffffff820311cb <+75>:	pop    %rbx
   0xffffffff820311cc <+76>:	jmp    0xffffffff820310d0 <tcp_cong_avoid_ai>

461	}
   0xffffffff820311d1 <+81>:	pop    %rbx
   0xffffffff820311d2 <+82>:	cs jmp 0xffffffff8223c240 <__x86_return_thunk>
End of assembler dump.

From what I can see above - unless I'm misreading it - we see something
interesting here. Note that in preparing the call to tcp_cong_avoid_ai(),
we get the tcp_snd_cwnd() value into %esi, but nothing needs to be done with 
%rdx because it's already got the "acked" value in it. Now this is good
news, because if we're calling this kfunc - that only uses the first and
third parameters - preparing all three will not lead to any nasty surprises
(we just wasted a bit of time preparing the second unused parameter).
If this held true for all kfuncs it would mean that skipping representing
them in BTF due to optimized-out parameters would be the wrong answer.
The key thing to figure out is this - if we optimize out a parameter, will
the subsequent parameters that are not optimized out still use the registers
that they would be expected to if no optimization had happened? So if I 
optimize out the first parameter say, will the second parameter use the 
"right" register (%rsi on x86_64)? If that were guaranteed, we could relax
the cases where we skip BTF generation to the following:

1. cases where multiple inconsistent function prototypes for the same name
   exist.
2. cases where a function has multiple instances with different optimization
   states (optimized out parameter in one CU but not another). This is another
   instance of 1 really, and shouldn't be an issue for kfuncs.
3. cases where an optimized-out parameter has knock-on effects for the
   registers used to handle other unoptimized parameters such that assumptions
   we would make from the function signature are violated for non-optimized out
   parameters. So the parameter would be flagged as using an unexpected
   register, and that unexpected case would instead lead to skipping BTF
   encoding.

I can have a go at implementing the above in pahole and seeing how it effects
our list of functions.

Note though that what's good for kfuncs isn't necessarily good for tracing
accuracy; if assumptions I make about parameter presence are violated, I will
see strange trace results based upon reading the code, whereas if I am
preparing kfunc parameters, a bit of extra work is done preparing an unused
parameter, but no harm is done. For the tracing case, function annotations
flagging optimized-out parameters via BTF tags could help.

However, none of the above will help problematic cases like
bpf_xdp_metadata_rx_timestamp() or bpf_xdp_metadata_rx_hash(); 
again we see missing location info in their DWARF representations

0x07449011:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff81ec8c80)
                DW_AT_high_pc   (0xffffffff81ec8c90)
                DW_AT_frame_base        (DW_OP_reg7 RSP)
                DW_AT_call_all_calls    (true)
                DW_AT_name      ("bpf_xdp_metadata_rx_timestamp")
                DW_AT_decl_file ("/home/jolsa/kernel/linux-qemu/net/core/xdp.c")
                DW_AT_decl_line (725)
                DW_AT_prototyped        (true)
                DW_AT_type      (0x0742f1ae "int")
                DW_AT_external  (true)

0x07449023:     DW_TAG_formal_parameter
                  DW_AT_name    ("ctx")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu/net/core/xdp.c")
                  DW_AT_decl_line       (725)
                  DW_AT_type    (0x0743dff0 "const xdp_md *")

0x0744902d:     DW_TAG_formal_parameter
                  DW_AT_name    ("timestamp")
                  DW_AT_decl_file       ("/home/jolsa/kernel/linux-qemu/net/core/xdp.c")
                  DW_AT_decl_line       (725)
                  DW_AT_type    (0x0743217a "u64 *")


...due to the function just being a "return -EOPNOTSUPP;":

Dump of assembler code for function bpf_xdp_metadata_rx_timestamp:
   0xffffffff81ec8c80 <+0>:	nopl   0x0(%rax,%rax,1)
   0xffffffff81ec8c85 <+5>:	mov    $0xffffffa1,%eax
   0xffffffff81ec8c8a <+10>:	cs jmp 0xffffffff8223c240 <__x86_return_thunk>
End of assembler dump.

__bpf_kfunc int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx, u64 *timestamp)
{
        return -EOPNOTSUPP;
}

...and playing around with various attributes here does not seem to help.

should_failslab() has a similar story, I suspect because __should_failslab()
got optimized out due to CONFIG_FAILSLAB=n and we get

(gdb) disassemble/s should_failslab
Dump of assembler code for function should_failslab:
mm/slab_common.c:
1462	{
   0xffffffff81422490 <+0>:	nopl   0x0(%rax,%rax,1)

1463		if (__should_failslab(s, gfpflags))
1464			return -ENOMEM;
1465		return 0;
1466	}
   0xffffffff81422495 <+5>:	xor    %eax,%eax
   0xffffffff81422497 <+7>:	cs jmp 0xffffffff8223c240 <__x86_return_thunk>
End of assembler dump.

However, the caller of this function still prepares parameters as if
they were going to be used:

(gdb) disassemble slab_pre_alloc_hook
Dump of assembler code for function slab_pre_alloc_hook:
   0xffffffff813bc5b0 <+0>:	push   %rbp
   0xffffffff813bc5b1 <+1>:	mov    %rsp,%rbp
   0xffffffff813bc5b4 <+4>:	push   %r15
   0xffffffff813bc5b6 <+6>:	push   %r14
   0xffffffff813bc5b8 <+8>:	push   %r13
   0xffffffff813bc5ba <+10>:	push   %r12
   0xffffffff813bc5bc <+12>:	push   %rbx
   0xffffffff813bc5bd <+13>:	sub    $0x20,%rsp
   0xffffffff813bc5c1 <+17>:	mov    %r8d,%r15d
   0xffffffff813bc5c4 <+20>:	mov    %rcx,%r12
   0xffffffff813bc5c7 <+23>:	mov    %rdx,-0x48(%rbp)
   0xffffffff813bc5cb <+27>:	mov    %rsi,%rbx
   0xffffffff813bc5ce <+30>:	mov    %rdi,%r13
   0xffffffff813bc5d1 <+33>:	and    0x219ff00(%rip),%r15d        # 0xffffffff8355c4d8 <gfp_allowed_mask>
   0xffffffff813bc5d8 <+40>:	test   $0x400,%r15d
   0xffffffff813bc5df <+47>:	je     0xffffffff813bc5e6 <slab_pre_alloc_hook+54>
   0xffffffff813bc5e1 <+49>:	callq  0xffffffff81d27b68 <__SCT__might_resched>
   0xffffffff813bc5e6 <+54>:	mov    %r13,%rdi
   0xffffffff813bc5e9 <+57>:	mov    %r15d,%esi
   0xffffffff813bc5ec <+60>:	callq  0xffffffff81340a70 <should_failslab>

...so the function is still being called with the right register
values. This points to a conceptual flaw in the approach I was
taking - we cannot equate register _state_ on entry to a function
with register _use_ by that function. So from a DWARF perspective,
the fact that there is no location information does not necessarily
tell us the function is not _called_ with that parameter; rather it 
tells us it is not used within the body of the function.

This all combines to suggest that the only time we should be
definitive in rejecting a function for BTF encoding due to 
optimizations is when they interfere with the expectations we
have about _used_ parameter->register mappings. So concretely,
where the second parameter uses a register other than the
one the calling conventions dictate should be used by the 
second parameter say, or indeed does not use a register at
all. It is possible that we could be more definitive by examining
DWARF call site info, but there is none for some of the above
functions like should_failslab(), so that will not help here
as far as I can see.

Does this seem reasonable, or am I missing something here?
I'm worried we're going to end up playing whack-a-mole with
increasingly clever compiler optimizations, so my instinct
is that we need to be conservative in choosing when to skip
BTF encoding, only doing so when we are certain it will mislead
badly. I _think_ there is some justification to that based on
the above. What do you think?

Alan
