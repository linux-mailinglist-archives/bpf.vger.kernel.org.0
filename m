Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A27E6782AD
	for <lists+bpf@lfdr.de>; Mon, 23 Jan 2023 18:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjAWRO6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Jan 2023 12:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjAWRO5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Jan 2023 12:14:57 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCACE29E1D;
        Mon, 23 Jan 2023 09:14:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NGwwrB000802;
        Mon, 23 Jan 2023 17:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WS76emxgBhsJ21MqEX99dGTuecfbk38ZljTaNm8Q+p4=;
 b=KGcNuh+xu4ETWXeJdXM5Wy1HxiaW4ZRqI8KInxv4p+NQRmiQOI8Opb+BFpnBpQLijfKd
 o9MHjpZvkSp8vcmrEZzegdUi+hSF4Di5GMML8gCe3IYwgJy1hdsu1KAtYP1bSaw9QMOu
 J7pziNSjNef+4HMacBhD8CdxH4iqj44wAfevQ0CrOhOvHYOgBBdidN8liR1XIwNPzFsw
 ISrP1vopKO2kihDVbYXPJ4pYdfCPwxxYs8DvYRO28QmiHPoDX7XUIgIBEMiYlDYrHGmE
 C4lZtkzzkFU+3cZXjQ/mDrCeXDUugXL4MhAjQTtn1OBxUGYtFSg0IUMyZ2fSuQn1D8d5 NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n86u2uc07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 17:14:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30NG3KWk011713;
        Mon, 23 Jan 2023 17:14:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g3aeeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Jan 2023 17:14:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSwTzXpNGPaLUqW8Z9QOEwfkUF2tnMzjZcng58nlm46yVeL/ZgK+X+KtPzNnkXS5XRZRGNEkkbfyqPQTj13ZYEGjREegH8c0If/l1yKhCP6NAlWUnWSFR+FzCOY4JT/dwZaQdkfE3vBDGlb3/bvOUktpQSRlAYVaBCDFkT/YFNqkZEb3oku0E1DjQ9NtjmaveMdemQPJPho/stvlPREb/LRerAXaV2oG6Cj6L6CLxLIa2ighvfcrUYjyEwGHDohNt5e453cFWK8gDSjgwhjSzOqwnUgtjcfOp9HFGoEdROOzSKdUrjAz6DHs42HOQZIsSgnmpk/1IS8Faexnro1Ycw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WS76emxgBhsJ21MqEX99dGTuecfbk38ZljTaNm8Q+p4=;
 b=b9/fEQ7v0rUiPcN/qRAVxSwr1HWW8yJVqCljVlvZvvxhL4ZMOiRfMW+1nV6/eUiC/j4m6puMS1czt5DG2GUVU8Vhdwe5bHN6CWk1AdbpTfGTeTCa+ICdtsRKayj8GhAFT981R/cX3xrgf+FDTZp1f9UbLcCpuCsGX1JYbZ2xaP1ZdUin2o1qzaiLsu39nEaP2FSiFBQqsFQhS9R+UTkuZCi6nxy7Bd9mLC2c4vfb4tVqsDkTFsqW3ZmRrLrFH39tiY3p+0+c6e0BuCpDc2raJ8k/elJxYooxHs4TUl/9yRUo+bT+UgBLR+3l9yJmmY7bBtwF83OTlYwR7/yfXOJAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WS76emxgBhsJ21MqEX99dGTuecfbk38ZljTaNm8Q+p4=;
 b=KcsqfBoN27DKCPdnDq3eIuVsIXBWlF8jEORCucIJAyWw39yhCiN1ClgMDz+lx/QlVRSPj8k+Gq9t460QJGLDvZ3Yo/IKBUmNOePSC3wOHMGhOOEtFYC6JShbJnmJ6/LIKt+vCzNk84YuHpgvedG7H+jo7DOVeOC5++S+ROCWQxY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.14; Mon, 23 Jan
 2023 17:14:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6043.014; Mon, 23 Jan 2023
 17:14:07 +0000
Subject: Re: BTF, pahole and static functions (was Re: [PATCH] libbpf: resolve
 kernel function name optimization for kprobe)
To:     Yonghong Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <20230109094247.1464856-1-imagedong@tencent.com>
 <504cc35a-74a8-751a-5899-186d7a0aff87@meta.com>
 <CADxym3bRciuyM1nYCrbaAwSMRJQvgV=hJFSLeiu9jysejPaTQQ@mail.gmail.com>
 <6c14e7ad-3b6d-4f88-64b8-8e3968d2b2e6@meta.com>
 <6455133c-87a2-1a0f-7da4-f8b99f02fc95@oracle.com>
 <CAADnVQJRntdqa4uCHtTrQNAsgGS13DtNV-ue2wTdHQxiuLo_Yg@mail.gmail.com>
 <03e16727-7a0a-0e1e-e9b9-c947a64becb9@meta.com>
 <eaf64a4b-85ab-bb5a-5c33-d7cd80b034e7@meta.com>
 <7bfb49fb-99c1-163a-fb86-3e72369adbf6@oracle.com>
 <ac273c04-3066-dd63-934c-f62650c41f8f@meta.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <22f18176-8771-41a6-4677-7cc805a07350@oracle.com>
Date:   Mon, 23 Jan 2023 17:14:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <ac273c04-3066-dd63-934c-f62650c41f8f@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P193CA0003.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::8) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a974f9-da35-480e-7900-08dafd653c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lj4SfjOtFFWqcp+N57DRxWrGmeWxLv8DMsEia3QG4cNmTWgSIYkCfM0T0Pid9o74mQ0YPoSLhOhu26a2hGlGLoGwZXK9mSxbokXKt6toXjdfK2tQ63YPW4wUGHBeLWT1G11zEUZ3CUAeJJTBk1h4sRigzVLIzGgIaiL8C4tGwoJ417IUHoH4ifYUKesGUqlKHJw1NJqi/RlWDYfh7hFVipVWypdausfm4qgEvDI6kthjzH536bfczchzZNaiVrJDBemz313mQIAiA9jZgHOMYEjSsktxLu4OO7QHT/HGeFpu43AmvxjuWsMH5WkrX5bbh6zDsmOs45vVOYkYfBp6V3VTLmtIYR6epc7HSx7bgqx1DICohu0/A+WJ6D08NymYhN4I+FRl9HI7CTOd4bQyUMLglJWF8IseOUMnjdJh6ev8f3pPdecAftO5VGP5kmppVA9Uu8YYDtwqtmffrO70lUEf0dqxHzY7Asreb5OpinWBGCmm9PKwwLQcNycS4UVJLM2cJEXNb6krfZ0EZwxdw65XmoamejFvEGOxuSmTENaNLX1t7N9g1D38W0lhilCInfhKHydxPUBGhZiW0QAPGopcsedOcpmj66JLJDImiQvbCSQEFXHde2S29VRcbUiBWcXtVY5pPMg5e2R7fYjxwuueiZSi0gQiUqlL1bsFY+jYfE/OgZSN9ggfqIE8Pu6elYEHRQ3FdFN89u9X3XHKcEIrZA1P2fy+Kaeh5vbeoBLNgPDq5t8+kQLN9pAdqJ0c16w8go1eBpdZdmV+3U5i5MR7LGK4khQkQ4Q9vi7PfxnxdeRvqTnOcNuJMSzEs8+jrgq50MI7Uke54LRMLp6ndw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199015)(6506007)(966005)(66946007)(66476007)(6666004)(6512007)(478600001)(53546011)(66556008)(186003)(6486002)(66899015)(8676002)(41300700001)(5660300002)(2906002)(8936002)(7416002)(30864003)(4326008)(44832011)(38100700002)(83380400001)(36756003)(86362001)(316002)(31696002)(2616005)(54906003)(110136005)(31686004)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2U4dktQMEswbEhEVGNVNEQ0ZkJJVlBIZC9XenNtNFJSeXI3eitWWWYrY251?=
 =?utf-8?B?ZUFTY0UwTjRuV2M5NHlZbmhFU2dzdEJsR0s5S0lOR2JNc25VNTdEc3NBZ2pY?=
 =?utf-8?B?NzltcEhyOE9makYzZCs5MWozZVNKcDFmV2JaWE1Sb2l1K2dZNDNBS3hKVmxN?=
 =?utf-8?B?TXhoUk9FTlZWbnNzMWZoQ1pXdjZoL0w4TFJFT2lpb3BVcHJZWmVLRUp5dWpk?=
 =?utf-8?B?ZExWLy9QSVZhdlo5cjMrb3VRUFBUSTZNU0F4S1l6UHQxU0lteWJ5bU96dUxh?=
 =?utf-8?B?OGhyeWx0MFYvV0FCMGhFL1FXQ2V4TVdYNFBzN1VBcXl5QXdGOGJtakVJeDNV?=
 =?utf-8?B?U1ZzeVJyK3J0RGhDeHdNMG9WSXN5TEpRbE9DeG9qMDRhYktqQjh3Z1dybGt0?=
 =?utf-8?B?K1FWUGVERHM4bS9IbjhCTTFOL2g2RkxoVUhXS1VFNkxaVXVoRFBCb1NFU1hO?=
 =?utf-8?B?WldUb0Rlb05Ld0R3OXVGaHNzTXV0cElKODZCRUpLaHAyd1ZyckplKzkwdXRr?=
 =?utf-8?B?OWJlNTFrbkZuMW9SdzhweHVJVzhJcGQ3QTA2RFJQQ1JXeGlQR1ZsZVNDdUlw?=
 =?utf-8?B?bXZ4T3lwb0huRXdNK2JCMG1EVHN5akNlb3ppMHhmR1F4eDZyTDRlWDNqV0ZW?=
 =?utf-8?B?Q0FVcGtyamlUQ0luOGR3bkVMcVZCM1kxR2IyWGVTYTZsck1XVWJjSHlOdE5K?=
 =?utf-8?B?SEIvd25YVTNITS91Z2Z4YWVuOTdQT3dtWlV1aWNlUDAxUkE1ekg1cmRZbUlR?=
 =?utf-8?B?SS92L1BFNmNFZkNjaURteFdxRTJkQ2U1RElFaWtrd2tqR2JtVmlqSEwzWjRP?=
 =?utf-8?B?TkwxRDRUeU9IM0ZhanBFZ3Q1YWpnUDZqSDhKM0NjRlVqbk56TUpUQVFlclBZ?=
 =?utf-8?B?TlBsckVBRkxUYmwrOHd3TC9hZ0VmUjBRUjRpWmVjM1NtN29yeXp6ZWpndU00?=
 =?utf-8?B?NDlhVFlyVHNpaEUyczZRN2pZN0JWM2x4VFMwTlpJYmt5dnlxbzdVTm0wTnRt?=
 =?utf-8?B?NGF6KzYwWGhIb2ZoV2FCakNIQ2tTb2FOM1N2WkxCZ2NjZ0FvTk52THVPcm92?=
 =?utf-8?B?RDdsWVU1ZkFvZUswRS9vczFlREZrRi9SMEFSaDRDOW5HT0hJZkd1TE00ZUgv?=
 =?utf-8?B?b2ZqbGpRcFFnalVqRjdPSmwydjgzdmJCdGU2eFNUUWEweFdaakpqVG1Ja1lY?=
 =?utf-8?B?bm4wM2J5SDJjZC9jTmJweUtJcEZseTBSNTQxQTRRc3FlaXlDb1lJZExyb2Mr?=
 =?utf-8?B?Ui9IQ1U0NTN6WUlNemFpRnBjMWpRKzBNUDRHUllDQ0puTDRBQUs2Vk84L1lO?=
 =?utf-8?B?U1UrOTlURFFIdVZZSjZPTDFVL01MMU90NEsvTmxoN0NUL3NLTnZVMlpiQU5s?=
 =?utf-8?B?b0psKys2dVFYRVhWMkdlN3VYVVlVbHROaGxMU1Vscmh4V2lKTmJsOWg3cGJT?=
 =?utf-8?B?TVRFUWoyenFzQVVGREdhbklacjU3OUhmUG5ZZTE5aVJaSHN0MnZieHpvNkMw?=
 =?utf-8?B?Tml5V1NZNXpzVGNhdDQ4UUgyU3ZXN205YzJJV21kOEVBUVZ6cDU1TmxlZUlL?=
 =?utf-8?B?SE9TR0xwOEFyWjA1S2paYm9CVktZN3V2ZWdITWtreDZ4UlpyV296eFRxQ3lM?=
 =?utf-8?B?UittbVo2NTEyajk3ZXphem5uemo2Qkd0QzR6ZTZaUS91VUlPNkRUdnpySFc4?=
 =?utf-8?B?YUcxMVR2NVRMMkh2ZGhBUkhhbWdOb0krNXZqZE5OQ3MrM01MZ1krd256TnlM?=
 =?utf-8?B?Rmw5U292bWpkYnpxOG0xbnIvNG9wTEQzYjNISCtidXdYTDJwdHVqQVQvMTBm?=
 =?utf-8?B?MkR1NlB6YXA5L2cySGNBcEh1cjZEQWYwRy9sakd5aGhFRGRJS05NZnVOOGJI?=
 =?utf-8?B?ZXZtd2R4TUo0SzJOUjBsa0drMWUySHVJTndLZzZEdFdLNGNSNklCWGtQVEhx?=
 =?utf-8?B?a002QmNGMkphTWhaTC81dlNObnJPUHA4NjFiUkV6YUdwdmp4MkJDbG1BWkJw?=
 =?utf-8?B?VFNoeDZIZ29aTDNSVlB4cWlaOHRibzRydzB5N2VUd3lQRFE0UGFPUEpaZEhJ?=
 =?utf-8?B?b3JRcUU1R2N5c1ZPZVpIYTlhejVBR2JJMnhEd0lrWVNyT0ZPUnI0Z1pHKzFV?=
 =?utf-8?B?UDA2cGxNZ3Y3M29XNkY4OW16MnZXeEQ0MW5nVElKMVIyZUF6WEVSTWRRWDAy?=
 =?utf-8?Q?wyR/1r86sDSnd8vYHVNQ66E=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eDdCSzl1dW5mZWs1eGltQm1MRStWL0pWb2VsQkN0NGtlSkpGakNPbUxvMlhY?=
 =?utf-8?B?U1kweHg2OHNOS1ZtYi9CNHErSzhKNlczWXhlWWY3S2VkWGRtaFl0T215aUNO?=
 =?utf-8?B?UWh1SzhpV2RkM25JMkhVaS9HaVNOSEpNcjVHT3lLMGx2cFRBYzFmUlRIYnUw?=
 =?utf-8?B?Sll3eURXSXNLakNvczZqbXZjMlpLdkdiQnRjWm1HMWRNTEt6RzcxdHBDSFp6?=
 =?utf-8?B?VG44S25IdDhFeWgxVkJucEtFV21UTFMyUDA4dTJDTkZyMm9UNllpRUJic20r?=
 =?utf-8?B?YjJhR0xaeGZwMzlMYVk5aU1rS09RYkpkUVdLQmw1Sk5MQWVGNFlHcDRJM2ZT?=
 =?utf-8?B?cUFwTS8yTXV5VUh1SFpqblpBMXd0M1RFZ1QwTnZuWE80Vnczd3dZUEVVRzIx?=
 =?utf-8?B?SDBvM2RsamJ2UjNpVE5YWmVrWVAzSnlBMGVLbnlQMmV5MUh2VGhUbGZUaWVI?=
 =?utf-8?B?ZTUzaU1CWklFdVlmZk9pR0VwamxqekVneDRFdE5MelQyQktibGU3ZFVuQnlN?=
 =?utf-8?B?VUxaWkV4T0dPbExWWHBKM0NMLzZUWEthVnNCNHc4OEVnSDhmaUNHTURCNGVW?=
 =?utf-8?B?R250N0h6QnZ2Ti9weDdQb20xRno4aXFnU0MwWHQwS0dnOW5wK1JCMW9FRWpL?=
 =?utf-8?B?U1RvOUZjN0lCVUpYZGhyNEFIQ1JSbG1xNkd6cVZhRDFmS3IvZGZvY1pkTWtt?=
 =?utf-8?B?bTVOQVh1U0JrTmdWRXJNLzVxSlF0NlJKb2Y1OXY5OHJqbnQzWHlqeU9mZDFJ?=
 =?utf-8?B?VjlpV3VsQ1RzamI2UXVJZDJHZEp6Sm5GaUJBeEhGZjAxUDVCVWNma3E5Tjk2?=
 =?utf-8?B?aHZIWFpHUnJBRzVHbTlNSkFlbmtRa1RncnpFMzFZYitjSnhNS09SSVkrZFBU?=
 =?utf-8?B?Rnk0NEYzRFl5cEF4ajExMzArcU8rZFl5eW1aVVhaOTRrL1k1WUFPdEtrU3FP?=
 =?utf-8?B?Vkw1clpjTUoveUdWLzhIRnlTa1FnQkdvcE9ab3hLMnRZUkc5MEZiQmk2YVBT?=
 =?utf-8?B?SUNxckRmWFJQcC9qcitNd2RlVkhVTUE1anJMYTJrWTRlUlJYUmR5ZVgrTHds?=
 =?utf-8?B?bDZKM2tGSjIrVUdtUnNwY0FWSTQ3UEkreTk1dVZMTzZjTTdRL3dnRmkwNjBB?=
 =?utf-8?B?LzBpS0VNR0RWdjQ2cE9EcnlNSnVRdlhHZmYxVTN0M3ZkT29aR25GN2M3OUJ3?=
 =?utf-8?B?WFlZZmdySyt2YXVKdGZKT0ZCN1dvYjJtUm80bkNHUzVOTVRhNFcvdUQ1cjgy?=
 =?utf-8?B?QlFycVlvZWdzSEJQWlUwT3d4MGdMNlBTMVNMZGVFRHlpYUlkSEpJQkNyV2hE?=
 =?utf-8?Q?VxJ2XOeHcKW5Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a974f9-da35-480e-7900-08dafd653c67
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 17:14:07.7346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfnN32glLbnmvEjchOM3OOOk4wGsRLHnPph2rQ/iDaN4edOZ8HNRGP52umYIdE5sALF8s0rsyBoaxGbN5+esjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230165
X-Proofpoint-GUID: UXRxjwLLjODTT1nqbbjVONQsCrjUFxQT
X-Proofpoint-ORIG-GUID: UXRxjwLLjODTT1nqbbjVONQsCrjUFxQT
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21/01/2023 05:29, Yonghong Song wrote:
> 
> 
> On 1/20/23 5:20 AM, Alan Maguire wrote:
>> On 18/01/2023 18:15, Yonghong Song wrote:
>>>
>>>
>>> On 1/13/23 12:00 AM, Yonghong Song wrote:
>>>>
>>>>
>>>> On 1/12/23 1:07 PM, Alexei Starovoitov wrote:
>>>>> On Thu, Jan 12, 2023 at 2:20 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>> On 12/01/2023 07:23, Yonghong Song wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 1/9/23 7:11 PM, Menglong Dong wrote:
>>>>>>>> On Tue, Jan 10, 2023 at 4:29 AM Yonghong Song <yhs@meta.com> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 1/9/23 1:42 AM, menglong8.dong@gmail.com wrote:
>>>>>>>>>> From: Menglong Dong <imagedong@tencent.com>
>>>>>>>>>>
>>>>>>>>>> The function name in kernel may be changed by the compiler. For example,
>>>>>>>>>> the function 'ip_rcv_core' can be compiled to 'ip_rcv_core.isra.0'.
>>>>>>>>>>
>>>>>>>>>> This kind optimization can happen in any kernel function. Therefor, we
>>>>>>>>>> should conside this case.
>>>>>>>>>>
>>>>>>>>>> If we failed to attach kprobe with a '-ENOENT', then we can lookup the
>>>>>>>>>> kallsyms and check if there is a similar function end with '.xxx', and
>>>>>>>>>> retry.
>>>>>>>>>
>>>>>>>>> This might produce incorrect result, so this approach won't work
>>>>>>>>> for all .isra.0 cases. When a function name is changed from
>>>>>>>>> <func> to <func>.isra.<num>, it is possible that compiler may have
>>>>>>>>> make some changes to the arguments, e.g., removing one argument,
>>>>>>>>> chaning a semantics of argument, etc. if bpf program still
>>>>>>>>> uses the original function signature, the bpf program may
>>>>>>>>> produce unexpected result.
>>>>>>>>
>>>>>>>> Oops, I wasn't aware of this part. Can we make this function disabled
>>>>>>>> by default and offer an option to users to enable it? Such as:
>>>>>>>>
>>>>>>>>        bpf_object_adapt_sym(struct bpf_object *obj)
>>>>>>>>
>>>>>>>> In my case, kernel function rename is common, and I have to
>>>>>>>> check all functions and do such adaptation before attaching
>>>>>>>> my kprobe programs, which makes me can't use auto-attach.
>>>>>>>>
>>>>>>>> What's more, I haven't seen the arguments change so far, and
>>>>>>>> maybe it's not a common case?
>>>>>>>
>>>>>>> I don't have statistics, but it happens. In general, if you
>>>>>>> want to attach to a function like <foo>, but it has a variant
>>>>>>> <foo>.isra.<num>, you probably should check assembly code
>>>>>>> to ensure the parameter semantics not changed, and then
>>>>>>> you can attach to kprobe function <foo>.isra.<num>, which
>>>>>>> I assume current libbpf infrastructure should support it.
>>>>>>> After you investigate all these <foo>.isra.<num> functions
>>>>>>> and confirm their argument semantics won't change, you
>>>>>>> could use kprobe multi to do attachment.
>>>>>>>
>>>>>>
>>>>>> I crunched some numbers on this, and discovered out of ~1600
>>>>>> .isra/.constprop functions, 76 had a missing argument. The patch series
>>>>>> at [1] is a rough attempt to get pahole to spot these, and add
>>>>>> BTF entries for each, where the BTF representation reflects
>>>>>> reality by skipping optimized-out arguments. So for a function
>>>>>> like
>>>>>>
>>>>>> static int ip6_nh_lookup_table(struct net *net, struct fib6_config *cfg,
>>>>>>                                  const struct in6_addr *gw_addr, u32 tbid,
>>>>>>                                  int flags, struct fib6_result *res);
>>>>>>
>>>>>> Examining the BTF representation using pahole from [1], we see
>>>>>>
>>>>>> int ip6_nh_lookup_table.isra.0(struct net *net, struct fib6_config *cfg, struct in6_addr *gw_addr, u32 tbid, int flags);
>>>>>>
>>>>>> Comparing to the definition, we see the last parameter is missing,
>>>>>> i.e. the "struct fib6_result *" argument is missing. The calling pattern -
>>>>>> where the callers have a struct fib6_result on the stack and pass a pointer -
>>>>>> is reflected in late DWARF info which shows the argument is not actually
>>>>>> passed as a register, but can be expressed as an offset relative to the current
>>>>>> function stack (DW_OP_fbreg).
>>>>>>
>>>>>> This approach howvever introduces the problem that currently the kernel
>>>>>> doesn't  allow a "." in a function name. We can fix that, but any BTF encoding
>>>>>> that introduced optimized functions containing a  "." would have to be opt-in
>>>>>> via a pahole option, so we do not generate invalid vmlinux BTF for kernels
>>>>>> without that change.
>>>>>>
>>>>>> An alternative approach would be to simply encode .isra functions
>>>>>> in BTF without the .isra suffix (i.e. using "function_name" not
>>>>>> "function_name.isra"), only doing the BTF encoding if no arguments were
>>>>>> optimized out - i.e. if the function signature matches expectations.
>>>>>> The 76 functions with optimized-out parameters could simply be skipped.
>>>>>> To me that feels like the simpler approach - it avoids issues
>>>>>> with function name BTF encoding, and with that sort of model a
>>>>>> loose-matching kallsyms approach - like that described here - could be used
>>>>>> for kprobes and fentry/fexit. It also fits with the DWARF representation -
>>>>>> the .isra suffixes are not present in DWARF representations of the function,
>>>>>> only in the symbol table and kallsyms, so perhaps BTF should follow suit
>>>>>> and not add the suffixes. What do you think?
>>>>>
>>>>> Sounds like a great idea to me.
>>>>> Addresses this issue in a clean way.
>>>>
>>>> Yes, the second approach seems a reasonable approach. If the number
>>>> of parameters for the *actual* functions equals to the number
>>>> of parameters for the defined function (abstract_origin),
>>>> we can roughly assume the actual function signature matches
>>>> the prototype. Although it is theoretically possible that
>>>> compiler might change parameter types, e.g., from a
>>>> struct pointer (struct foo *p) to a int value (p->field1).
>>>> But this should be extremely rare and we need compiler emitting
>>>> additional dwarf data (might through btf_decl_tag) to discover
>>>> such cases.
>>>
>>
>> Thanks! I've prototyped a solution at [1].
>>
>> The key problem is pahole processing compilation units separately;
>> the issue is that for some functions, they have optimized out
>> parameters in some compilation units but not others (NF_HOOK()
>> does this for example).  It's a pain, especially as we want to
>> preserve parallel BTF encoding as much as possible, so the
>> best solution I could come up with was to save information on
>> functions that had a suffix match in a global encoder binary
>> tree.  Then, when we are collecting threads, they can be safely
>> added prior to BTF merging, since at that point we have
>> recorded if they have optimized-out parameters in any compilation
>> unit.  There may be a better way to handle this, but I think
>> we are stuck with comparing binary-wide to see if the
>> parameters are consistent.  The code is (I think) careful
>> to limit this to cases where "."-suffixed functions are found.
> 
> I agree that for this .isra.<num> issue and later static functions
> with different signature issue, global view is needed to make
> proper decision.
> 
>>
>> In testing this however, I think there is a wider issue with
>> BTF encoding of static functions which may require a similar global
>> comparison mechanism.  More below...
>>  
>>> I checked with some compiler guys at Meta. They confirmed that clang
>>> might have the same optimization (eliminating some function parameters
>>> for static functions), but clang won't change function linkage name.
>>> So that means, clang won't do static function cloning and it will
>>> only remove function parameters if this can be applied to all call sites.
>>>
>>
>> Great, that simplifies things a lot.
>>
>>> I checked the clang (clang16) build kernel with latest bpf-next
>>> and didn't find a single instance that a static function's parameter
>>> is removed.
>>>
>>
>> Excellent!
>>
>>> Also, current libbpf kprobe API supports to pass a function address
>>> to kernel. So user space can always do their own /proc/kallsyms search
>>> and find func address for either regular function or function
>>> with .isa.<num>/.constprop.<num> suffixes.
>>
>> Right; one way I've done this is to have a special "okprobe" section
>> name where we support matching with a "." suffix as well as with
>> the exact name. Might be worth adding that support to libbpf itself
>> if the above approach lands.
> 
> I am not sure about this. We should keep a good default to handle
> .isra functions as we discussed earlier. If user still wants
> to kprobe a .isra function which is filtered out by our default
> handling, user can use addr instead, in which case, user needs
> to check dwarf output and/or assembly to make sure they understand
> how many arguments are actually used and how they are used.

But if we ensure BTF only encodes consistent representations of
functions and spots optimized-out parameters, wouldn't the presence
in BTF of an .isra function provide a guarantee parameters are not 
optimized out? Note I'm not suggesting changing "kprobe/" or "fentry/"
semantics here, but rather having other dedicated SEC() prefixes to
support "try for foo, but fall back to foo.isra if attach to foo fails,
and we can find foo in BTF".

> 
>>
>> The bigger concern I have is in testing this I hit a problem which
>> at first looked like a parallel BTF encoding problem, but on
>> deeper analysis looks like a conceptual issue in how we handle
>> static functions.
>>
>> To demonstrate, generate vmlinux BTF twice, once with a single thread
>> and once with 2 threads.  We observe a different number of functions
>> that end up in BTF for the exact same object:
>>
>> $ LLVM_OBJCOPY=objcopy pahole -J -j1 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
>> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
>> 57596
>>
>> $ LLVM_OBJCOPY=objcopy pahole -J -j2 --btf_gen_floats --lang_exclude=rust .tmp_vmlinux.btf
>> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|wc -l
>> 57714
>>
>> So we see 118 more functions in the latter case. Why would this differ? If we sort
>> and strip out duplicates, we see that the cause is multiple copies of functions:
>>
>> $ bpftool btf dump file .tmp_vmlinux.btf |grep "FUNC "|awk '{print $3}'|sort|uniq|wc -l
>> 57596
>>
>> Once clue is that each encoder maintains a function table of ELF symbols, and
>> marks a symbol as generated if it has been added to BTF.  As the encoder
>> traverses CUs, it adds to the encoder symbol table.  In a single-threaded encoding,
>> we will see only one instance of a function in the final BTF because the first
>> match of the binary seach of the function list will be returned.  With multiple
>> BTF encoders however - each with its own internal representation of the symbol
>> table - there will be multiple instances of functions added to each individual
>> encoder's BTF fragment.  This is supposed to be okay because BTF deduplication
>> will handle merging these.
>>
>> However, this does not take into account the fact that the same function name
>> may live in different CUs as a static function with a different function signature.
>> Could this explain the extra functions?
> 
> Could be as you explained below. Also, the original behavior for static function with one thread seems wrong. User only find one static function
> definition in BTF and may assume it is the one user expected. But this may not be the case since other same-name static functions may be
> simply ignored.
> 

Right, I should have been clearer on this; the single-threaded case isn't
right either, it just picks the first instance of a function it finds.

>>
>> It seems to account for many of them. To take an example tcp_in_window()
>> has two representations:
>>
>> 122435] FUNC_PROTO '(anon)' ret_type_id=122409 vlen=7
>>          'ct' type_id=65074
>>          'dir' type_id=2170
>>          'index' type_id=6
>>          'skb' type_id=2012
>>          'dataoff' type_id=6
>>          'tcph' type_id=61910
>>          'hook_state' type_id=29004
>> [122436] FUNC 'tcp_in_window' type_id=122435 linkage=static
>>
>> [66683] FUNC_PROTO '(anon)' ret_type_id=372 vlen=4
>>          'seq' type_id=23
>>          'end_seq' type_id=23
>>          's_win' type_id=23
>>          'e_win' type_id=23
>> [66684] FUNC 'tcp_in_window' type_id=66683 linkage=static
>>
>> ...one from nf_conntrack_proto_tcp.c, the other from tcp_minisocks.c.
>>
>> This raises the conceptual problem - what do we do with such cases?
>>  From a code perspective, it's totally fine to have conflicting static
>> functions in different CUs, and one approach would be to retain multiple
>> conflicting function signatures; however this is not really useful as
>> there is no mapping from BTF function signature to site.  As a result
>> we have no way of knowing which signature applies to which function site.
>> So perhaps the best approach is to eliminate such inconsistent static
>> function descriptions? The actual amount is small, ~100 functions.
> 
> Removing these inconsistent static functions could be a simpler
> approach. 

I took that approach with

https://github.com/acmel/dwarves/commit/80eaecdb00b3d79becc2133b854593277093b115

Static functions with inconsistent prototypes are left out of
BTF encoding. Given that the numbers here are pretty low (around 
100 or so, not including .isra functions which have inconsistent 
prototypes due to optimizations), that seems to be the simplest
solution for now.

> To really resolve this issue, BTF needs to encode more
> information, e.g., DW_AT_low_pc, so this function can be related to a particular ksym. We could extend BTF somehow to encode this information.
> One possible is to utilize the btf_decl_tag. For same-name static
> functions, we could have
>     btf_decl_tag("static_func:name:<low_pc_1>") -> foo (first static func in btf)
>     btf_decl_tag("static_func:name:<low_pc_2>") -> foo (second static func in btf)
> We only need to do this for static functions which have same names.
> 
> In verifier, we could build the above relationship and establish
>    btf_id for first foo -> low_pc_1
>    btf_id for second foo -> low_pc_2
> so verifier can then find the correct ksym addr for a particular
> btf_id for 'foo'.
> 

It seems workable technically, but I wonder how much benefit it
provides? The absolute number of static functions with conflicting
prototypes is small (around 100), and the usability of the above
would be hard to get right. My suggestion would be that if we
can ensure that BTF encoding will not encode inconsistent static
function representations, we could potentially do something like
the following on attach:

- a BPF program specifies "fentry/foo"
- we find a representation of foo in BTF
- we notice that there are multiple instances of foo in kallsyms
- because we know BTF would not have encoded foo if these had
  inconsistent prototypes, we can safely attach to all those
  instances

This seems to provide the least surprise for the user; i.e.
I attached to a function, and my program fired when it ran. If
the function has inconsistent representations, it isn't present
in BTF so we cannot attach safely.

>>
>> Assuming that makes sense, the next question is how.  One approach
>> would be at BTF deduplication time, but we have seen cases in the
>> past where BTF did not fully deduplicate identical structures, and
>> in such cases, multiple copies of a function are present which
>> have multiple (but identical) parameter type descriptions. If this
>> happens, the danger in eliminating both is we might eliminate
>> critical kernel functions due to a type deduplication issue. One
>> way to avoid this would be a comparison of number of parameters
>> and (failing that) parameter names; such a comparison would not
>> be subject to issues with identical types leading to identical
>> function definitions. Not 100% foolproof, but would work in
>> nearly all cases I suspect.
>>
>> Another approach would be to re-use the mechanics introduced to
>> compare static functions to see if they have optimized-out
>> parameters to compare function signatures.  So static functions
>> paradoxically have to be stored in a global tree and compared
>> to weed out inconsistent duplicates.  Luckily, these comparisons
>> can be quite superficial; for the most part number of arguments
>> suffices.
> 
> If I understand correctly, for same-name static functions,
> we would like compare # of parameters
> first. If they are the same, we then compare parameter names.
> <name>.isra.<num> functions will compare against <name> func
> to ensure the number of parameters the same. I am not 100%
> sure what is the difference between the above two approaches.
> Only implementation difference, right?
> 

Right, the only question is when we eliminate the inconsistencies
(prior to BTF dedup or during it).

We need the mechanics for comparing static functions to handle the .isra
case, so I went with re-using that scheme to catch inconsistent static
functions in 

https://github.com/acmel/dwarves/commit/80eaecdb00b3d79becc2133b854593277093b115

Thanks!

Alan

>>
>> What do you think is the best way forward to solve this problem?
>> The optimization-handling code gives us a way to deal with this
>> by postponing addition of such functions until we can guarantee
>> consistency, and I've roughly prototyped a patch on top of [1]
>> that works, but I think first we need to figure out what to do
>> with such inconsistent static functions before determining how we
>> do it.  What do folks think?
>>
>> Alan
>>
>> [1] https://github.com/acmel/dwarves/compare/master...alan-maguire:dwarves:btf-optimized
