Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9067B419
	for <lists+bpf@lfdr.de>; Wed, 25 Jan 2023 15:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234873AbjAYOTR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 09:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjAYOTM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 09:19:12 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A3C561BF
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 06:19:09 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PDjYsB000562;
        Wed, 25 Jan 2023 14:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NzchbuxD8nx0ESgeu1NkiYtxfoeW3gYpAa84lCgr+f0=;
 b=nce9mJAgqWh4eJUijGgOj5ySt/reCWV7nsPbtd2zzcSQnKcpXSShP/0Dl+6sUhO+bgh1
 GVRmPOrVQ5pFGwJeXlFzVFuapQDNrV5WxYZ7dGvXaDEIGNKik5uwrcxVETfej07Tkino
 tudgRQOkpsq5tRNYxpfgn8dh1tKKBOTb68BQ/ZFfTpLq5nLzvpILPngajwGaEvSLTAZj
 v0MO3wIcst4LB9escAVISlwbXzFz0ig2HrdOJuUA5k8ZJf3SYABTzdKSS+3bCoFEi/wX
 H1CHZQxQVc9h85vwpdlJlV67pUDvCr/0VtNIMZg0Rg8SPYMuVIj79Tl1Ss3IEiXlXcaI NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n88ktywh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 14:18:27 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30PD0Y8j034213;
        Wed, 25 Jan 2023 14:18:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n86g6ju8h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jan 2023 14:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReEnCEzys6UX3Lg4ExuAuxUa7jsXT4/FjZyH28unaqIKVVBw3DE9e5HduqQMY3xvFWj1XMDw0r+YOzIVxgXPrivp9oyDY5+YITHIxpn1jGIPF75fIJPxtsrO8PkY59iVeKhJKYGta8Eet/yN19I6FkWfFls0RvO8M9FEoT+kUE42dEjSPxCrajPI3YMUXo+dSION5gYEPm7jBr8huv4IfKRRE65loInn82dNfv71/U7JPRh2qThoua0Lv2NwZvzimwA1hW/FSibiRdTuEs7gDLDfizckoHkry6bDcJhK7qD4TidjGJ/1iIQTUelqO2nP2E3B/tzhRU6KSQV/eFYpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzchbuxD8nx0ESgeu1NkiYtxfoeW3gYpAa84lCgr+f0=;
 b=gCHwcROa9kRfk2Qa0B4F7kH5caVMRFkvtnx6YbdVLQBBCzourET/YsXvS5DTVC8n2kNzum+7DKXpIT88j5nWyWpcT/hqt4PE8wdJdsCE0UBCETQKWHPI9o7f+P9Qvgs1IZR0rUAwT+D6dJeyxejVmB5FVCeDcqaN5zNyLaUZDx/YvCwD2LZqTAiNJgUmayyEuMrKZVcwdlo0boJQzzUtTdCVx3gnJg57ViP5OZO0SPcR891TBUxrGdbMIPEPQNenkuZRCSaQHerZ107EgkDbbuWxPr5slkOA2F1m6GJklu5i1TN21HlwqlojiGlM3gLUBhqolgWoaE5cj599az1irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzchbuxD8nx0ESgeu1NkiYtxfoeW3gYpAa84lCgr+f0=;
 b=Z5QmcDEqVFmZiRKtdRP8vJ9uVy6cKgA/5fo1IVWplQ4SqcFCyPlEt/roWdfCh4A/6fFnTeeJ7eoOLHwa0zJudK2mJDGgnJrWVP4ONhWPK/mU6v84zvCM8rly0aZUHB0aYhijESAg1gTXn7eZDou/6CZvgiJRc0OlAlbaJg4UzFM=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB7201.namprd10.prod.outlook.com (2603:10b6:8:f2::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6043.20; Wed, 25 Jan 2023 14:18:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%5]) with mapi id 15.20.6043.020; Wed, 25 Jan 2023
 14:18:23 +0000
Subject: Re: [PATCH dwarves 5/5] btf_encoder: skip BTF encoding of static
 functions with inconsistent prototypes
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     acme@kernel.org, yhs@fb.com, ast@kernel.org, timo@incline.eu,
        daniel@iogearbox.net, andrii@kernel.org, songliubraving@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org, sdf@google.com,
        haoluo@google.com, martin.lau@kernel.org, bpf@vger.kernel.org
References: <1674567931-26458-1-git-send-email-alan.maguire@oracle.com>
 <1674567931-26458-6-git-send-email-alan.maguire@oracle.com>
 <Y9Ew9iwd3Jg5vk9c@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <83e0d14b-b1e4-5fbe-2dbe-eae9b5068f7c@oracle.com>
Date:   Wed, 25 Jan 2023 14:18:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9Ew9iwd3Jg5vk9c@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:196::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad57f32-b3be-44db-b6d8-08dafedf047b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGHlEHWc6Wbzt9+2z3c/i1MceAbs6PsK7zJHv366/f/LASs5Km7XoQcEz2ZuLBQu36AqOjZKqSqEjQVjhv0DLaxCqBtVnPfxs2GlUEs5FD1iiPKqqtKvrOcCpmOaSNSJc8zeb85vKosxbIFSKdeiyvwhJCmh7srxorNp6znm1slaS1nb2IFS+fBBrEFxw8Gp9rhXhPgzScBAgwLEr9jdA/3ta6feoXMeZLNVPb6FNvIVKkGbAFFCD3OO83hS6q+LeWTmKttV7AKDkAtRnn4gcg9fkh59zrdOV1tJ2+KdEGl6JmCSHtntUBEA3IMr55OtrdO+CXYGoePZTf/wiecUD2dG/s1Ge07s9oOztbo2AvajsQSEr/DDAHDabvbm8yNIlh7iNFbfoai4jvYo/X2I0fSsCri3SLvXLocJwUGyqP9bcqrjtY3WedSYmKZwKqEok8glf6pPX4T+b08axHU+c2BqnpdsRWhVbqgWxrxW3hR9b9cMPojw5B8pznkQdUg/DGr7FL53uzZebqptM6CR8VmWwWSznHBzZjpG6cepfwvJX3VI4r2Kowsn9gNf9MsFUVTw69DVzZ2qNuLZIr+TDSlv/nZd7u2opxf23XlxVQsBFQImpAvqEP+2EGTTiYucBbwQpaVZiSBmcnFazbia/T7MDHpPXacJreLZEqw/xpet21I/dbyh9enBDIaZUiUawo6O2Jsi+kETYw9HvG4A0mwNG8visGuM9uzunpxAAWo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(316002)(38100700002)(41300700001)(44832011)(36756003)(2906002)(8936002)(5660300002)(7416002)(6916009)(4326008)(66556008)(8676002)(66476007)(66946007)(6666004)(31696002)(66899018)(2616005)(6486002)(478600001)(6506007)(53546011)(31686004)(186003)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzZvcUNXRDU3d2RpMWRaaGFFQ3VwcEduLzVOdDBHZmF6ejJ2aitlc29VWW1l?=
 =?utf-8?B?a04wMndtN0YxZUplcmJ2TXA4ckFJQVpTZnlCU3I4QTlTbEhna0FkV3dwU0hy?=
 =?utf-8?B?a3NaUGJYNUNzRXJwOUZGWk9EWDhqeHVhZFg5T0dFK2NrdVdNOSsvR2hjTVNv?=
 =?utf-8?B?MlBZa0J5enJDWGFDcDRoWktRUDF1c2pmTXBHS2Rlbk9hNjlFeDdvUVJOaG5u?=
 =?utf-8?B?RHdjbXBjV0orQklGNFpTNXVtYVR3aXZhTmZEU1NCdTVLbWhoN01YRHM1YlZD?=
 =?utf-8?B?UkY0SmtKdG9VOTdmdXZtT1dWbWpFbXQxKzBLRjdhRWRzN2h0cDY1ckttWGoz?=
 =?utf-8?B?VnQwMklZV2lIdXVpc2NTTCtwMGMvMG1hdTlRVnc3UDdVZzBkUzlGLzZaM25C?=
 =?utf-8?B?cU5VVGJjSlg1UFZWdk1RVis4cXMrVGpkbEhTYjNibVNOemZmbTM2bDd2VUI2?=
 =?utf-8?B?USt3OHcrQlM0SDF5REFGOXNXMHU0N25sSHIrSTZWSnJIZHplQ1VUalFnbUwy?=
 =?utf-8?B?QTd0NUNYanRJdWJhVUVta2gzYkRoS0JjTkErdks2V0VPWDlNMFJISncreWFW?=
 =?utf-8?B?UkJ2eVR4ejljamx0ZW5yTlc3elhwdjFzMEM2MkVMUlFleCtXSTkwdHFrOGNo?=
 =?utf-8?B?YWpYN293ZFgxRk9rYUpWZlZFY2N3WGVCdUtjQ3ZjZlAzRHZ6N2tGWmltd2k2?=
 =?utf-8?B?UnNvcEIzdDRhSkhCR1I0MFA1czJRVUY3R0Y4K1VnVlpoenZsZUg2YUFxN084?=
 =?utf-8?B?SjJxaXZMNXFMVE9GNjVYeVhOR2haUWIxcXRvZUZXU0ZHR0NZYVAxbGo5TFIr?=
 =?utf-8?B?L3lIeVdzREpuc0dmSERmbDJOeW9EY29rUElQTEVsT00ycEQ1YnUxUXdUdDFh?=
 =?utf-8?B?Y0xxc1Z3QjVuM2s0Y2xrdHJuVGVZZ1VwT0w1VkdkTENZVUVQbS85NFZTTGVv?=
 =?utf-8?B?MnhoNUllTU9sTlcxSG5zRHc0NEtQRVRpcE9RTXJXT2FnV2tJRnpRZFkrQ0o1?=
 =?utf-8?B?T0F5NnIrclJKRkxXR1ZxcXgzSnFKS2ZBOUpDeEw4aXYzK1pzT1pvZ3ltQWVn?=
 =?utf-8?B?U1FTM3RIYTlMSGxYTWdCT3NHTE5QTi8rbXQ4TmtBOG9oL1ZmRjgxbThtL1F1?=
 =?utf-8?B?OUc4TjdCUlNrdGtlK0Q1U3RTQXMyZkl1cVRkWmNVeDZYWCsrREQ3V0I1eUhI?=
 =?utf-8?B?ZjhWOXpvZXhyRnZ0aldwaDhBelRqQXZPV2VoVFBQc3ZUZ3NsSUhGanIvYWVx?=
 =?utf-8?B?dEV6TnJsTGN5Y0tkdzA4bEkrQ1kxWUFLZG91a3FiRFFBT20vSVFmc0VsSG1m?=
 =?utf-8?B?WU56K1VScUNpL3p6WlNhOWdaS21SMmZ6TE03a2xuVXZwRjNITmUwWlAwWXZy?=
 =?utf-8?B?d0lPc21Eb3BhRHNnSEEralFmc1pKR1A3TWhTM1I5dDRYelplOUJpL295Sk9M?=
 =?utf-8?B?bmo3WDRrTmM2ZUtLODFDMHEvZnAxTEFhREcxd3NBa0hFU29Ca0Mwa0VOMDl6?=
 =?utf-8?B?cWJ5NngvMitDcFRoWFZnOE1JTnBGT1BCMkRzVHkraXBJR2Z2MnVZU1NWREJo?=
 =?utf-8?B?bUpFT29KYlhDT05PeVdWc3pEdEFmWEhZZWwwZUlaMW1KdmQxam1xelgycFBv?=
 =?utf-8?B?alcydmVPUTdiS1ZVU0hSVnBiVXlxeGRydDJxQVljR1B5ZkQ2RGpSNkN2eWk0?=
 =?utf-8?B?QXF1eXhxeGtLbDdFektkcFY2d0cranl6R0R1YjBKSll0RnNQUXpFMnRWbDZt?=
 =?utf-8?B?WWtUaTRCaGg5ODNuSEJZQmZGR0RoaW12OGJLNnRuSDhueHhFcmJIRG00V0hK?=
 =?utf-8?B?bnRhOVBaT3gzMXEvdk9BaG1FaW85ZFQ4UkFQWSt1MERTSitSeFRHeW10ZXdq?=
 =?utf-8?B?dUZsbkZXWFNtWndUYWJkdlVNZU5SQkswbkRxOWtpUVdKVnk5SXFlYy9rRHQr?=
 =?utf-8?B?OEZuODcybFNONGZxSjRHUVB0aVVPUzdnd2cxYzA0N1FHM21pbWdnTTMwc2ww?=
 =?utf-8?B?SC9vdlUrb09IR25adkVTWGU2Mjk0VWp4L1M3c0U2aHZpV1lRYlozSEJRNVhD?=
 =?utf-8?B?YkVCdXhGMlVpM1lPQlpSTVhIVld3c3R3ditWR0xxQlU2b3ZETzhGQndxWXF2?=
 =?utf-8?B?Q2hJKzNIK1NLQmFsd3lPUDd0ZzRaYzArdnNtVTVBTVZBL2VLb2Rna1dQL3Fq?=
 =?utf-8?Q?9C7vI3HODPGFo9k+QgmtIdQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WFRwSGlGamZVZmpjN3VNTlZ3eUpTSSswZlJ5QVFDM3JpMFdDOUxuMk9rbEhW?=
 =?utf-8?B?UTJuV0JlaERQZXpjSjE1WGs0ZEJRbEN1T1RHRzFSZUFzM1NvMk9ySnVrdzNs?=
 =?utf-8?B?aFEyZ0M4b0swSTNRbDZBS2t3Q2VRZ0pxd1ZoR2k1QkdGWmJhUDlZejhvcGFL?=
 =?utf-8?B?TVV6bm5PaTN0cUxVSDhDUGRzcDh6SmxqMXppMmdNS01LOHc3QXFpUmVhYW9Z?=
 =?utf-8?B?REMxMXNpMk9SbDVpQUJTY2ROaWdXV0FneVpDWS9QbmxiMVl4Vk5UWDEvWFgv?=
 =?utf-8?B?aG9HdGxHUTBBM0hNbDIvc0JwcVJvRVpyeS9aTHYydjU4Yy9sTnhMK1E2L3l1?=
 =?utf-8?B?T2hlWGJXYXZnbDZFcW1ZMFJqSjVieFZGSlV0dVYrL1BqaENnaG5XY2NaOEh1?=
 =?utf-8?B?ZzE3UlE5dWp3QjRDa1ozcmloci9zS1hIb0RJN05SNktod2FkdVpuMEcrYmpJ?=
 =?utf-8?B?c0I5Y0dKN0xPM0ZVaEhNZXhzb0ZYaCtQVGFYUTlHbGcwMk5KUEh2VG9oNlc1?=
 =?utf-8?B?OTFua0xZbkg4R2FvaDBHWWRUbEVzbHk4aUg5RWpkVStDaVY3VEpINmZDdWFE?=
 =?utf-8?B?VnhTUFV1bnRPTndVd0k3OUx3bkFwNVZQckVzekdBQXlVcjVnVjM0Y0RVOVdu?=
 =?utf-8?B?STB2TTE5WEtRbE5VdFZKTGNtL2wxMFBkZ2hrQVlMTXJrVy91K3NySFp5OTJE?=
 =?utf-8?B?NHBxZUFreGYzYXl2Z01OTjAvd1pPU0oyNm1idjY3TmpIVXMxejdTUGVtZUlY?=
 =?utf-8?B?VHR0L2tualo2QXVnQU9jZ04rWHJwR1JGVXJ4Q1BQcnhyUDhtbjA4MjNRWHNO?=
 =?utf-8?B?WmdKZEJZTndzMmt6Nmo3T3htMXREby9qTUQ5SUhocEtudVhFT2wrblByc2Rq?=
 =?utf-8?B?WElidHpyNFJTb0tjdkkvbC80NVExaGFMWU91LzBOb1ZWRWxaZHBhLzdHSmc2?=
 =?utf-8?B?blE5MUlyMmRyeTVIaVlLSDBMWHVlN2h5cExHYmVDZExuSmxDekZmLzhEWnRZ?=
 =?utf-8?B?VGFaOUdpK3QyclgvOC9xVVR4cS9DTEZrRkc0TEtLOUprMHZUdUdEWXBDVGxE?=
 =?utf-8?B?dG1uU09JcVZpT0grMGQwelNoekhERTVTZDBPZlJxZE13NmxJN3JyYkxua3py?=
 =?utf-8?B?VWVQNVBFamIyNjE4S2NMWnhuZU9TZlVTT3R2QnUvcDdwUDJ4eUFmOUtURTNX?=
 =?utf-8?B?cjZDbUdMaFFTNE9BdVh2S2tKTkdhQTZTY0lVc3dzK0VBUFVTZXlHTHIwVHZq?=
 =?utf-8?B?YXJlcnFmazh3WGNZRjc0ZVV6cU9hZzBRRjBMZzdYNTZMbWNOdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad57f32-b3be-44db-b6d8-08dafedf047b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 14:18:23.7255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYiD6NVVz3PLzHhb31w/S5wZKYUB1bg3OwVQZbm36USHbsdZb0+a1hRrfqK93EUjROmpFH1euaNWVizr/AMlSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_08,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250128
X-Proofpoint-GUID: INDPT1bcIRBjZP4Iz-88N6MImd-YVV1w
X-Proofpoint-ORIG-GUID: INDPT1bcIRBjZP4Iz-88N6MImd-YVV1w
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 25/01/2023 13:39, Jiri Olsa wrote:
> On Tue, Jan 24, 2023 at 01:45:31PM +0000, Alan Maguire wrote:
> 
> SNIP
> 
>>  static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct function *fn)
>>  {
>> @@ -819,13 +837,51 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>  	}
>>  	/* If we find an existing entry, we want to merge observations
>>  	 * across both functions, checking that the "seen optimized-out
>> -	 * parameters" status is reflected in our tree entry.
>> +	 * parameters"/inconsistent proto status is reflected in tree entry.
>>  	 * If the entry is new, record encoder state required
>>  	 * to add the local function later (encoder + type_id_off)
>> -	 * such that we can add the function later.
>> +	 * such that we can add the function later.  Parameter names are
>> +	 * also stored in state to speed up multiple static function
>> +	 * comparisons.
>>  	 */
>>  	if (*nodep != fn) {
>> -		(*nodep)->proto.optimized_parms |= fn->proto.optimized_parms;
>> +		struct function *ofn = *nodep;
>> +
>> +		ofn->proto.optimized_parms |= fn->proto.optimized_parms;
>> +		/* compare parameters to see if signatures match */
>> +
>> +		if (ofn->proto.inconsistent_proto)
>> +			goto out;
>> +
>> +		if (ofn->proto.nr_parms != fn->proto.nr_parms) {
>> +			ofn->proto.inconsistent_proto = 1;
>> +			goto out;
>> +		}
>> +		if (ofn->proto.nr_parms > 0) {
>> +			struct btf_encoder_state *state = ofn->priv;
>> +			const char *parameter_names[BTF_ENCODER_MAX_PARAMETERS];
>> +			int i;
>> +
>> +			if (!state->got_parameter_names) {
>> +				parameter_names__get(&ofn->proto, BTF_ENCODER_MAX_PARAMETERS,
>> +						     state->parameter_names);
>> +				state->got_parameter_names = true;
>> +			}
>> +			parameter_names__get(&fn->proto, BTF_ENCODER_MAX_PARAMETERS,
>> +					     parameter_names);
>> +			for (i = 0; i < ofn->proto.nr_parms; i++) {
>> +				if (!state->parameter_names[i]) {
>> +					if (!parameter_names[i])
>> +						continue;
>> +				} else if (parameter_names[i]) {
>> +					if (strcmp(state->parameter_names[i],
>> +						   parameter_names[i]) == 0)
>> +						continue;
> 
> I guess we can't check type easily? tag has type field,
> but I'm not sure if we can get reasonable type info from that
>

Ideally we'd do that definitely; my worry is that we'd have to
provide a buffer for each parameter type, and representing some parameter
types can be quite complex (like function pointer parameters). 
The memory and computation overheads would likely be significant to compute
the exact parameter types I suspect, and this would need to be
done for > 3000 vmlinux functions which have multiple instances.

In practice, the simplistic approach does seem to work;
I'd suggest we stick with the simple approach for now and
see if we can improve on it over time.

Thanks!

Alan 
> jirka
> 
>> +				}
>> +				ofn->proto.inconsistent_proto = 1;
>> +				goto out;
>> +			}
>> +		}
>>  	} else {
>>  		struct btf_encoder_state *state = zalloc(sizeof(*state));
>>  
>> @@ -898,10 +954,12 @@ static void btf_encoder__add_saved_func(const void *nodep, const VISIT which,
>>  	/* we can safely free encoder state since we visit each node once */
>>  	free(fn->priv);
>>  	fn->priv = NULL;
>> -	if (fn->proto.optimized_parms) {
>> +	if (fn->proto.optimized_parms || fn->proto.inconsistent_proto) {
>>  		if (encoder->verbose)
>> -			printf("skipping addition of '%s' due to optimized-out parameters\n",
>> -			       function__name(fn));
>> +			printf("skipping addition of '%s' due to %s\n",
>> +			       function__name(fn),
>> +			       fn->proto.optimized_parms ? "optimized-out parameters" :
>> +							   "multiple inconsistent function prototypes");
>>  	} else {
>>  		btf_encoder__add_func(encoder, fn);
>>  	}
>> @@ -1775,6 +1833,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  		 */
>>  		if (fn->declaration)
>>  			continue;
>> +		if (!fn->external)
>> +			save = true;
>>  		if (!ftype__has_arg_names(&fn->proto))
>>  			continue;
>>  		if (encoder->functions.cnt) {
>> @@ -1790,7 +1850,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  			if (func) {
>>  				if (func->generated)
>>  					continue;
>> -				func->generated = true;
>> +				if (!save)
>> +					func->generated = true;
>>  			} else if (encoder->functions.suffix_cnt) {
>>  				/* falling back to name.isra.0 match if no exact
>>  				 * match is found; only bother if we found any
>> diff --git a/dwarves.h b/dwarves.h
>> index 1ad1b3b..9b80262 100644
>> --- a/dwarves.h
>> +++ b/dwarves.h
>> @@ -830,6 +830,7 @@ struct ftype {
>>  	uint16_t	 nr_parms;
>>  	uint8_t		 unspec_parms:1; /* just one bit is needed */
>>  	uint8_t		 optimized_parms:1;
>> +	uint8_t		 inconsistent_proto:1;
>>  };
>>  
>>  static inline struct ftype *tag__ftype(const struct tag *tag)
>> -- 
>> 1.8.3.1
>>
