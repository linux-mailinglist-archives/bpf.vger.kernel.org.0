Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D63B66C069
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 14:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbjAPN5u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 08:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjAPN5d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 08:57:33 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9DA20055;
        Mon, 16 Jan 2023 05:54:39 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30G8DxNm007563;
        Mon, 16 Jan 2023 13:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=5+uH1Rl0MN7c+5uXXT2xkHpgvDqZuYuMzYrjkEeIdyo=;
 b=upFQqRQ3xHw8nqn4tA5bzkVlkiEBrPOLfMOR8vW/excuL1+JNm2wEm7cjZnajZvuLroH
 syqHsh9GQyT/F/3+u1v/KU4Tg3G489ZDv6+HFJXqql1r6rZYUahWwdwp2F0BuRs5GdrV
 NIFW7SzkYynrI+BrAJrZEsD1UmJxs7GM2GvmqyiTzLP5o9NLpjUZy1Jd86wWigOGskL6
 zeK3eFqPvGFXTGka4UicXqqXCM0c2/BJRBa8H6ooEK0sTbUjO7q2tJ0hs7Kd838dsLcG
 FIjZ05qrma1IMR04/+2xln8V4qQu4qcHSQ1mlFH+5xOVL9fYmSP54IXamai5d6QmJQvL lA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3medat13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 13:54:10 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GDX66P040052;
        Mon, 16 Jan 2023 13:54:09 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rx3pbe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 13:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYSNi/VjMITllmpjLB1ZvVMVvDg2ZuZxB5zQOoNx+p7WuuBmofpRYIii/DWbR3seDePS9kjVsIR93AAuuoQNQo8d4ifKZDLLXti6YdarCD4eDiF8KLJ6pvaKdzf+g1R/+jEyeRl665anpT0OGU38UEiSu0dlPNy+u9Ugz/NDLbWY3RRgTrrjapr+Nd8tTqQ2wbngzMH74ULyy/YZfEGQF6sKVEJAZXRnPa/qBpd4PqwKhRxTPeDUlQjXTOJxtqnrn5xq09aEy3S3+Ydh4XyD5ivz+FI/y5VMTzfwMOT5Ohu2n5EUxrfd8dA1IBcB7b+xNd9pgq8wDMQ7xa8j1ujtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+uH1Rl0MN7c+5uXXT2xkHpgvDqZuYuMzYrjkEeIdyo=;
 b=FYmazeeEstoRjk0HojTbVsKUAXh9QAmGWRzMoVDY9ZS93mIADD/WagnTItIyw7GeOOSAIVk/rdSTBdk4ocIG337GIS3+pIhFPH4REfqUrCvSF4S0cqQXvMxeYIY758+/zy49p1XQrxPP5X0egsuWfc3x3Mdl7m3dhYE/3jONtxdXWv0eJntNZYO5g9975AWr5bkymvpgsUVYyPRt9v9HoAS+3OgIqudWKx1oNwLdlHRCdoXhgJRYWKGcAqGRxbPDAVGwApG8E/s3vKNqGCAT+5CmM494KY0PoGX7neqwCr9FxLXTXDuGd5v71TcZsGz/oqgXcnXjyU0U65tThn6Vog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+uH1Rl0MN7c+5uXXT2xkHpgvDqZuYuMzYrjkEeIdyo=;
 b=kV/e2u2EMHyDDK4Els0FT83k7uKYPxKNAhb331p65h8gikjJlYHq32dKuY/denv3RtO3EpD80rHf9m8gHbcuWXPhcJ5GXybsWHQwyy9K4i4eP6Q2y3nFG9n2lkzl7krxTAXcvcw9kXs0YOnxXbLlhitMkBQJY3Mun3tO8d3unTk=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH3PR10MB7436.namprd10.prod.outlook.com (2603:10b6:610:158::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.10; Mon, 16 Jan
 2023 13:54:07 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%6]) with mapi id 15.20.6002.013; Mon, 16 Jan 2023
 13:54:07 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix undeclared identifier build
 errors of test_bpf_nf.c
To:     Eduard Zingerman <eddyz87@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1673844908-11533-1-git-send-email-yangtiezhu@loongson.cn>
 <14e0f634f084d0f07e447638c490da60943507d6.camel@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <556dc633-e7fb-da8a-1fa9-757684edd3a4@oracle.com>
Date:   Mon, 16 Jan 2023 13:54:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <14e0f634f084d0f07e447638c490da60943507d6.camel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0025.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH3PR10MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: acb806ed-2096-4eb8-055f-08daf7c922e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SewhF9WD881+zl6StZj0xhXMoRh7bmg5uIpxzbjvXVMrsiMIC1f5RJEqCIWYBJfka2mFUCM0+4NBALv+UWUnkuNu6yghknwWuzrU9w+7rHCj0bzV0p+zFBEr8Vu2nCTd2lEhHVtvDJGR9Lzsq8kxtGq/XqmLcKSa0AJDYhAsnVP8tD1izDDV58r09YNOndRuAsMqBlUiLyF9e8WOa4yR5Z6u9pt9k6/moCP6tzzDttFMEdcksQ372GgZ+p1oeiZh8gLN4WIEB6f3naoy+F0AjAuUi0PawXGf1uWHPo4vlrmHqZEbka+YHNOOO/4+ZQNTVmY3UnoGwoYQPOtYD5SB53BJNeol53SRz6xP9mZsYihlBFIliCEykr6OPabNMQgKzyvuw+tVY/FkxqWo58Se6/C5tV9R2yFKdDcWVfwNJaJsK9vGYJXgAba3lCfH/Ad/Mk5L9CDA0kurXg9WB7/03pGYFY8ioVCmrSVhbR6wsm5jGJWXljNuFAGOiqv7FMlXzozoEygV4pAd0iJGfGWe4lSBUrg+4qiU4hLY/IwlN7S3fmZRUVhL8zqRVMQCnwUeC4ZYcb+evwZU0QeiWsFLL8rptiHEDmCy9Mx2XaOb8sRbfGPO0+eunyYIyx5pn9AnVxfvEsVwWqTfm+gR/iQcqV9eltKGpPMKwCoQ13capbjiYhinS9SJUbMUL9p0X0IDl8/zM8YbyU9uI8taiYsTPhirE0dP+giGNls8s9aVwaTleGKUpatymSJCu1J1WiYL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199015)(44832011)(38100700002)(8936002)(31696002)(4326008)(921005)(86362001)(5660300002)(7416002)(66476007)(66946007)(8676002)(2906002)(66556008)(41300700001)(6512007)(186003)(53546011)(6666004)(6506007)(2616005)(110136005)(478600001)(6486002)(316002)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU5XV3EyTGN0UnduSkIwRVhjNStjS0tQcmtXSUovVlJ5VVJTRGdlYTdjaHVW?=
 =?utf-8?B?VWphWTdWekd2T3g0M3pvMmF3WjZwN3JiNFZmUy9UNE1qeHVpZHpHWUdLb21l?=
 =?utf-8?B?L0pHZzV4ZmtmYjZDOU9xRE9MZWx6dVJUNkljcytxcUdqeVRIb0NWMTZuVmpk?=
 =?utf-8?B?OTdDdUVCcEVoczhyWmloak5UN0cwaHAzS1pYTUxDRTlxdXpxcENoWHBRbzhj?=
 =?utf-8?B?R1dLdkFIbUlueDRLUUVmdkVKS0JQcS8zRTJxZWZFYU4wemQzWDc1QVd3M2ZV?=
 =?utf-8?B?djUydFdCWmRTRzRPdkVNWGlKQkxqb1J0QllLOHYrMW5hSmdOVVA1SnBxc1ox?=
 =?utf-8?B?MWVXalBnc0lFNCtSWjFOcE1rTUFtWURQYmpSR29yOE5uaWJOMmpWSzdPanhx?=
 =?utf-8?B?M0E1dmt1Ni9GZnIySHNXVkp4UHdRbXRYRC9LYUhjbVVOZDVrdE5mMjlIYzI0?=
 =?utf-8?B?Y1BxYTJNdEd5cThOdldaN2xBbTFKQlVoNzgvMlprbnpQcHgraWdvRDlraGpG?=
 =?utf-8?B?cThlQW1pSUtadWZZSmVLcjlydVpMbkxGS1J0eW85d3QzSmtSZTdYV0VrMXlZ?=
 =?utf-8?B?c295ck9wa3VTaFUzWWsreW9NWDUyUjBOK2VXeEhGSWVFN2F6d0dDbXFoZldo?=
 =?utf-8?B?ZnF3QWhJOG56UXphSW9hMU4wTEJGRTZIV21NV1VXdkd1TFh6bGVhVDFUR3FO?=
 =?utf-8?B?QVBBZmJaY1ZBTGNob0RCaVNBSUZhUXV1enZzVlhhKzF3T0I1WHpZMmVYek1F?=
 =?utf-8?B?UU1lYVpzcG50aERrWkR3WjJ6SHcrcFA2b0d4RUNwQjJFMXZCRTgrcjgzbEdv?=
 =?utf-8?B?cEFRQnZuRVlLMVFjSWNmZElFRFdlNWNiME44SVJUUk5xbGNaVzJvWVVBYjNT?=
 =?utf-8?B?T3NuUzQ5WTdEK2dGY0huOEdXeEE0NFF6QXBUOGtpNTd4bDM2UHVKR0QrV0NK?=
 =?utf-8?B?b1ZZUVVIS3VmWjdKVzdaQ2VpMUNQeFF4UE95em45UkFQcU40QkRGcFNGRE54?=
 =?utf-8?B?ekc5aTloclAvendNQkFQcFVDR2xKTEF4YTdwcEtXb1VoNkIyUHJSWG5FWXAx?=
 =?utf-8?B?b3VsbjhJbHRob3YyeTRjM1p0NnJQUmFXSGFYdFV0Z3JHVGdISFhnUCtKS3FS?=
 =?utf-8?B?KzBaTmxFc3AvRXBJOTgraDR2UG9zREMwN2tkVDNkU1AyKzNyNTZTZUZSandW?=
 =?utf-8?B?R0x0NlgxczF6alRKdzVucHJYK0xENllJQVNwU3EyeHF6SDcwaTVFTlFrcWdz?=
 =?utf-8?B?M0p5Q0lLMkY5aTJJWTBFQ3hMNW1Qa1ZRYnpOUjJRQmtFa0pRVFlCUXVXRDJO?=
 =?utf-8?B?RDQrUkRMY0dYWFFFQ28vUzVrekdPUGJaMUFzemo3R1RremZ0cVkyNFQ3ODd0?=
 =?utf-8?B?KzZkYk9Hdi9EdEN4Sk1LWHIvbk1VdWw3UGZNa2VUOHVpVkJaTXhFZlhBL3F4?=
 =?utf-8?B?NVFsNFhjMDI2VjJGa0lwdzY0SXhJODhIRE9pTU9yOTd1MFAzWFBxWUVsWTcv?=
 =?utf-8?B?SXJXUzRuZjQ4MldjbDBBZEd0SzBlZnJnZHZFeGNkOTdmekZWMVdUMFlxYTF4?=
 =?utf-8?B?TUwwTzdWOTNxMmdDbDZLc01nSklCeXhWK3ZzKytMVHN6enZBekVCRThGNEhE?=
 =?utf-8?B?QS9qQnQ2UnhFNWpSQVFuNmRYckx5UVZjTm9YZVcrdm9ERnFOWENnVThRalBF?=
 =?utf-8?B?UjVPU0V0M245clUyL2tzSGNRV2NMZTFHVS9rcEk1N0Y4SnRnNlhPelpxb0Nu?=
 =?utf-8?B?S01YT0VFMlhGSFdoUXFsOU56MEtYYWNKRmdyYUlLc1NLK1l6VGJVaWx2MGcy?=
 =?utf-8?B?M0tGZVRQb3ZSaEJiaVZDc29HeGUzNEFJVStITkpuZVZmYVlPTGZuV3QrcWsw?=
 =?utf-8?B?ZXY2aTBIQ0t1S3p1eTYySkRnbGtyVFZ4aWVVOURtNnZNR3A1MXJLaTZoU09F?=
 =?utf-8?B?TzYwZndMc2p6c3FwdWZaTExjRVcyWjNmbVpOSHRUMGtiU1RteTJTbjVMalR2?=
 =?utf-8?B?L2I0V0ZPRWNod1RSa2FwZzV0dmhPSGZqeGpmeHRyZjUzanBrTEtJRFJTdU12?=
 =?utf-8?B?ZUI4dm1LZGJqUVRMcjZuZkJ2UXg0K1NEbWRkSjNVbGM1SFM3UXNGT1JOUDZQ?=
 =?utf-8?B?YndsYVdEL2VHSWFpQ1IvK2x5NnVhNjlzLzlVMEMrdmFxUVRIczZEWGVjZGZv?=
 =?utf-8?Q?f8vYPaFQK8IWzHFx8KDkSwU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?U3RkRGlOTFptR0dMS0pxeG9iYXNrY1N6Lzl0alhDdW5EOE40QkF5aFNrb1hC?=
 =?utf-8?B?NnZCcEVrbGd2RXUyc3lVM1VsdHpCTmVsc3MwbHVEOElPM0Y3eTcvcU9yQng0?=
 =?utf-8?B?ZzdOS0g4YVNoL2FIVWNFcTk0RmVtMGZhZW1VNVpHWk8zbVFPWEZGNWhHTTFh?=
 =?utf-8?B?NDhPOUV1OHVXQzVmK0RaTjJOWE4rSnFwT002Q09IMWM0OVdlYW94RWE3bkZE?=
 =?utf-8?B?WjdMcjdBUmNzVmN5SUdpWldVRnYvcFdzemlIc2lQZitiWFpqaXd0Q2d3R2xh?=
 =?utf-8?B?ODZ2SDRmNkppSjUxR0lCUXRocnpzQldNN3ArY1RBUVdWWjNROXZSWk93azgv?=
 =?utf-8?B?SmNKNGJTQVNuckZ4ZnBiRzJ1VENZZTNvV2EvOFQ2dTUvbHJRMXJ4amNzbHk4?=
 =?utf-8?B?WWhnWThQQVhwUWlLckZzc2t0dldVWTVTRGtINnVkQXlUZCtwZTFiRy8wejI0?=
 =?utf-8?B?UzJYN0tUeFB3akxwamdrdis0U1Jtc0RLOUxDNFA1VmQ3cjllNkhxNEJaTGNm?=
 =?utf-8?B?OUcvZWFXclY3T3lOYmwzQ2gvcXBIbDZVTStVM0I3MmtzZmdoeTd0ampoNzg2?=
 =?utf-8?B?NU1BaFBMTGJXZFBRb1k1d2RiV21mZFlqTy83cmxtTXdUNGFtWmdjdzNHdHFw?=
 =?utf-8?B?UjJJN08vdjdHVVg4VjZLVS9oQk4xclhoQmRweEVWOXVjaldNNytXS2h4OVEx?=
 =?utf-8?B?cEVNbmc0c1ZaY3FwelBxa2VqMmZGNDM0bEhyYkc0dmdUbDZ3Qmt6cDh5SmZU?=
 =?utf-8?B?MjRNUkdHWG1McjA2UFZnQVdtR3dhY1lUMDdoSWlYQ3pWaVV6N29RL2N1UUVE?=
 =?utf-8?B?TGh0djFhczlTNHk4elQzb3M1dkYvTStzeUpwZUhpM0lkdmdudEQxQTZocUlr?=
 =?utf-8?B?UlZteXdlWmRUSDVVZEZVcWpwRkpqclY0VDE0L1lFV0x6R3FGV3FRL3RvbFRG?=
 =?utf-8?B?c2RicU5OYWJoV0FURHcxRWtuazF4NVVmWVpaWnl6S01GUTdCZHNZNzFBY3Bo?=
 =?utf-8?B?cE10RmY4RVM5SnZKV2ZWbWNmMWRwRVlkQ1lDUDA4djh5QUhQMU41Y1RpamUz?=
 =?utf-8?B?Z09PN1R1UVArZFFvSm4wdVRTV2x5c3dHeGZ2aUdPaFhYQ2QxWStOek1CcmNC?=
 =?utf-8?B?SXRRbWJhMU52aVdobEh3RGU5STZOQjc3b3FvQnpONFltWTgwM3VGUm15MjNq?=
 =?utf-8?B?V2FQRXVsYTVJcGNzOVZYK1hiVWFISE9yeWVSbWxIZHV2SUMwUEFTempTYzYx?=
 =?utf-8?B?NUtVdjB6K0ZGRUxNOHVkdHgwM01kZUI2QWNsVzF6NHFtei90Zz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb806ed-2096-4eb8-055f-08daf7c922e3
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 13:54:07.4480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8l+bfCgg/A9NQQr39zoToY3xLu3bEICQJWd/nBsxF1cGKDcJPFoZO48YTwwd5F4aRnQRbWWQ0F2qJtFYRbsvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_11,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301160104
X-Proofpoint-ORIG-GUID: u20JuhNWnqhXIs9saRLE6zWK5qY-jq4m
X-Proofpoint-GUID: u20JuhNWnqhXIs9saRLE6zWK5qY-jq4m
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 16/01/2023 12:30, Eduard Zingerman wrote:
> On Mon, 2023-01-16 at 12:55 +0800, Tiezhu Yang wrote:
>> $ make -C tools/testing/selftests/bpf/
>>
>>   CLNG-BPF [test_maps] test_bpf_nf.bpf.o
>> progs/test_bpf_nf.c:160:42: error: use of undeclared identifier 'NF_NAT_MANIP_SRC'
>>                 bpf_ct_set_nat_info(ct, &saddr, sport, NF_NAT_MANIP_SRC);
>>                                                        ^
>> progs/test_bpf_nf.c:163:42: error: use of undeclared identifier 'NF_NAT_MANIP_DST'
>>                 bpf_ct_set_nat_info(ct, &daddr, dport, NF_NAT_MANIP_DST);
>>                                                        ^
>> 2 errors generated.
>>
>> Copy the definitions in include/net/netfilter/nf_nat.h to test_bpf_nf.c
>> to fix the above build errors.
>>
>> Fixes: b06b45e82b59 ("selftests/bpf: add tests for bpf_ct_set_nat_info kfunc")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  tools/testing/selftests/bpf/progs/test_bpf_nf.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_nf.c b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> index 227e85e..114f961 100644
>> --- a/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> +++ b/tools/testing/selftests/bpf/progs/test_bpf_nf.c
>> @@ -34,6 +34,11 @@ __be16 dport = 0;
>>  int test_exist_lookup = -ENOENT;
>>  u32 test_exist_lookup_mark = 0;
>>  
>> +enum nf_nat_manip_type {
>> +	NF_NAT_MANIP_SRC,
>> +	NF_NAT_MANIP_DST
>> +};
>> +
> 
> This is confusing, when I build the kernel/tests I get the declaration 
> the "enum nf_nat_manip_type" from the vmlinux.h (which is included from test_bpf_nf.c).
> Which means that this patch results in compilation error with my configuration.
> Is there a chance that your kernel is configured without some necessary netfilter
> configuration options? Have you tried this patch with BPF CI?
>

Yep; I suspect if CONFIG_NF_NAT=m , the required definitions won't make it
into vmlinux.h. The reference tools/testing/seftests/bpf/config has
CONFIG_NF_NAT=y so it is at least documented in the referenced config. 

I'd suggest going the route of 

commit aa67961f3243dfff26c47769f87b4d94b07ec71f
Author: Martin KaFai Lau <martin.lau@kernel.org>
Date:   Tue Dec 6 11:35:54 2022 -0800

    selftests/bpf: Allow building bpf tests with CONFIG_XFRM_INTERFACE=[m|n]
    
...and adding/using local definitons like:

enum nf_nat_manip_type_local {
	NF_NAT_MANIP_SRC_LOCAL,
	NF_NAT_MANIP_DST_LOCAL
};

...to avoid the name clash.


Alan
