Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A6A62878D
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 18:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiKNRzU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 12:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237875AbiKNRzJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 12:55:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2D4E1F
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 09:55:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEHPkPu006565;
        Mon, 14 Nov 2022 17:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=T8hU3xlF6g8UdezYyizKKjs27TLW0GHVMCBMmy/qLm0=;
 b=0q5j1BOcTy2rnFcm6tpUOPBA1aqW1VTT6xsB2wnd8Y3YXpv0anKBDLAtykAoWUqZo+iy
 R4OzU8aEQ5ra7jcqgwcWeNUlua10XH/kVIAMJfntK2lQA8VL7ojKUubMaLWtWFDZNf8M
 qFL201dTLiN6qr0WszirZ3i9mzvf7pNU0Bto8mkCnnKInVK4NErrkviOiXacorVJIwsB
 +kBSbLZBT2Qz+0ArNVscO2Pnx6m09/m4dEt0+A7xXpaU5vJ8Mwkh+wk2C+PKvpcuKsng
 HCyO8hWeng47eqw3kerXA410xq5xhf7vrCcusBLJ+gv0R2ryc5YEZOijpfBrEc3giZfx Fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kut2d83ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:55:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEHiS7M031841;
        Mon, 14 Nov 2022 17:55:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xahj8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:55:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG0HnfdBwwPeB40v0JYHtE2aBWHUbGJuclJP2428wxRA2Bxl4i+WLwFqz0qw++hhdoSfLHx9weY+yBc7I2uNganMibbLNXycjgId4RAaYDa5l+aF77BVYbBCXkZ2gsnui9wkTsTq5VpnR5OZZjVaqXXkEkBjAfLUsSphrgwpRGR6jgH+E62TjCBG45mT6LS6GLFPP1UWsG0d3IrXrjXfrZFUyDGjRwKhtEKi69hsSuswPHpegLq/qovg+1jM53y8it6Ni6OTIrrNjNN6yBQdZwP21KHurQ4u5CHCgh9xOHw9KPwYWRRLFClyRgn3Pzntin54fqHwW6iIk+J7i2IL0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8hU3xlF6g8UdezYyizKKjs27TLW0GHVMCBMmy/qLm0=;
 b=D/OqMwOiFp77epo1CjOQpqZo1/5GbhVVeyFLF9BmvpiIoCzPQELtuN2qM79nqQKZUHcytqAxld6M90PP/hNNwLPyHdsdUstSyopoO6SeOKuntObmz/W2XB4QlFmEUJeAYFiHmKygTk2w2aPJC9NrlnbyZktV/fJJ3C2dOEpApzXrnzkZq2aCnzKO/ZzB1J81OKoAsAA8orhlVY06NaXVFrV0JpuZUnAzaniCSXKzVFD2WBgaX1V9s9N/NWqhFB+/ruAfmD5ze8jrfhCCF6PnR8HU0rTBUQgjZAXV/QvGT7oLZEhke4odrpqCeGjdC6etA8aBSx/4ssPxUNbC36d7aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8hU3xlF6g8UdezYyizKKjs27TLW0GHVMCBMmy/qLm0=;
 b=xBpIDrifzH0VVLrJVu7GjK6ixzjeL1FMefj/O+Mfre3rpBOEAHZHL2RyTzm3MGYhRVpq1RdGKsswkWWYuTrGysUyg/eD7NmFCzQOLobjBjsuIoyohDGXFBGJuCU6DAuVhhEu9YizK6w+4YSEeFZdT8K1cpFIKlSoH4wCXywW9SA=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5215.namprd10.prod.outlook.com (2603:10b6:5:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 17:54:59 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::5c74:6031:ddce:d5f0]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::5c74:6031:ddce:d5f0%8]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 17:54:59 +0000
Subject: Re: [PATCH] libbpf: Fix uninitialized warning in
 btf_dump_dump_type_data
To:     sdf@google.com, David Michael <fedora.dm0@gmail.com>
Cc:     andrii@kernel.org, bpf@vger.kernel.org
References: <87zgcu60hq.fsf@gmail.com> <Y3J5LMzdb9+FBCN8@google.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <48926637-92dc-0bdb-1bf8-a87d8c58a8ce@oracle.com>
Date:   Mon, 14 Nov 2022 17:54:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y3J5LMzdb9+FBCN8@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::11) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5215:EE_
X-MS-Office365-Filtering-Correlation-Id: 063e8306-f3ee-4bd7-a0ea-08dac66958e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /r2cBDMarXjE4Li8exPfJPw7wVEs0aja8UIYzeoclZVsRLUKARBbPPdzCi/IRsyl22ioDo0+uFuBk8K+JBnGnhEBjKSQKuyIGMCr37XY55Hsgm2bjzgGQV4j3P4f4ZBYseeVnbgiCtN0rdC9w2Ctu4JGFk48IVQCOZ9gcm7rumnk69EyU2jR9iFXPT6RcKh2m38UO/vqvtwOKsAx+nD/eg7eLPcDU1KrvR0TxHbRqzsZ4GdhWc+aaBen0zzsTUg78/IfhwmuQz7um0UIvHV3sg41OuBzhyBuFHx7+PjVKhUkVfS16hE4d1G1AG+1nYspsLBQZKQkifhP95TuU8J7BtbiRB14QchYFOEZYXeT85c6QxNEB0d98PIOPyLU0ZjDs9qCcz4n1J0jhL1UWgR28eDfitv0AUHjiJsvmReuixCUiGoN5Y3+n4VBb2BoNaIkJs1eCUo2XK84bCBUQKGkZKF2ZrWsNzAKH3Bg7ThEyR3ldXURsFq1XjFHak/h18KLpTQCfx1J9utm+ClURLxOPs9OM/YfRiQDDKMCKGS7sWVBPIz2Wfpf5+EdZHnlncmqDGvkS7Vc48rIU9nrHwy2qQzGka3IxJqEP9E8GbFDSBTofJ19qQaexdH8HNkNEJ6ujvqgtAYqvGBimgfEcC/M07UVl76CL4AgwwXVBSsM1TwR+LP7Fsp4xKjK2wqGbwsHZ0J9cHVaC/k+fmG3HuGH5PvNyX9BzV6A9PdyW2I625boU4RsNjNAMcAZ+BgkixCEZm5UL+RzNXXt+gN/xSEf78XoOjQ+ydk6ztwCyIpdfEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(31686004)(8936002)(5660300002)(66476007)(66556008)(8676002)(44832011)(41300700001)(66946007)(4326008)(316002)(6916009)(6486002)(36756003)(478600001)(31696002)(6512007)(6666004)(6506007)(53546011)(86362001)(2616005)(186003)(2906002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFBLS2Q3cDYweHFyQmkxVXM3cmNEemU2NnJxSzdWaDNXM3AyRlJxT1RVVkRV?=
 =?utf-8?B?aEtNc0h2YXF1WDl4dnVLWHNvcDg0L0FTN3QraEIxQ1JOaS8wbTd2MEdGejZG?=
 =?utf-8?B?cEsreXBUejZ5azRPcjNWcCtuYlU1T1pEUE1yY0dOck9NakFqdE5xaU9mU2tl?=
 =?utf-8?B?S2xCWHJTSEo4Sks0UytCaWVIN0lDQVJTb2tMWlhDN2xjZ3JPckZLSDJnNDZz?=
 =?utf-8?B?R1pKRlVhUEJaVllBZU5RSUdtV1hNMVBta2JqZmlYcG44cWlxVVJXcnlwL3hS?=
 =?utf-8?B?VWs5dWxDU2k3Q3NTYlF0SkdyakJLeWpNK3ErVmxsMldNcnhSSHhLQnJJTEMr?=
 =?utf-8?B?dERuS0F5RHQ2blZNdnI2WERPTDArNmlFa3JUc0dVYXJFa1FERVBJU0U2dzZn?=
 =?utf-8?B?QUdmcUMvOGdkM1N4aUZqWEdRMUF1UTVxaE5jRUJaOVlwejQ0NkdRVWY5QjZk?=
 =?utf-8?B?bDAwU3owaWYzOEEvSGlOalE2NWNIQVJzMk52MmttWE93Y3BaVnlSRDBZdU42?=
 =?utf-8?B?d1VmSHBoTVU5cGExSWFIcTh2bVRkL3FYNzduT1drTjR2UXc5d1dwK0xuUmE1?=
 =?utf-8?B?UC9WZklHZDJLTUU0QlUwSXBKcXBFQjR5NW96eUlQdy84QjdkOGtSc1FaLzRy?=
 =?utf-8?B?NklOVzVRUzcyYm5pSmlOSzFCejJiQi9DSGFGUGJxcU15UFptUnFkanROWnp1?=
 =?utf-8?B?Q01vdGJ2aUFzQ3NJQWVCYmh2M3JOcDRZeXllZExuNUc3SkRwcEJ4QmRtaWtM?=
 =?utf-8?B?UVN6ODhRVi83T29Nd3hlTFhYaExYRHQzRlpVOWtmdGkrVVNGVktrY2xabmdk?=
 =?utf-8?B?eE8wOHd3T09rU2g2SVZCUVExRi8vcHVTdGIxM0pZMXdQSjJ2azFiaHdhMjQ3?=
 =?utf-8?B?RUtZeVhOLzZiZzNNcWhNRzlCUXg1eFY0MVczZG4xMEpTSUxmSS9yK1E2cjN6?=
 =?utf-8?B?WkNrakMyN1JnYiswQTljampWay9JbXJRU1NzRXFJdEszNUxVU0FLWk9JaDNy?=
 =?utf-8?B?V2lwemx6S3p5OGFmM013YXdvcHZTbm9TblpNeUdQY0xUckN4QThUOFVWWkNC?=
 =?utf-8?B?Rkg5TThmQStLSWJuWGd3aXhBb3YvSElzbnRxd2pIM0xGNitIL052M2pxWVl1?=
 =?utf-8?B?Kzk1b0xZSjVWQ29yQTlacUNCbTFyUFVkaDNhVGNiVms5M2xqVlJGOWN5ZU5V?=
 =?utf-8?B?a2VZaGhtc1FwQlVNZUJOZmNFZ3NSc1hLaTc0N3ZIMkJKSlRWQUs3TmpqVVNS?=
 =?utf-8?B?T2o0MVk5Q0tYQzZBM1dXeGRpZW85QzBNbzd0VjNWUngvbkhQSjUzbURUMDVE?=
 =?utf-8?B?UGthT04rRnZQNDEwU3FPT0c4YURNazdLdDdWZG1sb2NNcmdLeEcrL1hEOFNQ?=
 =?utf-8?B?cnpid3k4U25QSlBrNkVzd2Zsd2g3OEZ2TC95WTE1czd4RWtCbHc1bW5VdDlL?=
 =?utf-8?B?Rm9QLytVVGpHSUFXRVBrV1llSjQweTM1QTJNK1NFYlJPMC9SZnhxR2pvUkJC?=
 =?utf-8?B?V1lEK0JzZjF4a0RYeXBSQ05sNlcyVGxOZXo4bmR2Q1YxTXc0NlFuZGJuSW5Z?=
 =?utf-8?B?cTNwQTdDczgvTlV6ZjQ1MThXOStXd2N5WlNEWHNhMFJmRGI3NmhJdHhyL2sz?=
 =?utf-8?B?S2ZjbTk3REw5dENFNG80ZzZ6cGxwcTJxOW5ydlE2SWMrYUw3QVJyczVRNXo2?=
 =?utf-8?B?alB0TU5PUVVlZUs3V2pVZDZoOGRPMVpkL2g0ekh5eW5scjNkT1R0d1FKWEFn?=
 =?utf-8?B?QkhRVFcyU1Zyb0hKMFI5RGY1KzkydG03amZXcGw0NitmQUdZUEVxblFQN2JP?=
 =?utf-8?B?WlEwYThGcXd0S2ZBM2lHTVdGTGVKMERzOW1jdzJrdTRYTFNlK2t2VkN1N1F1?=
 =?utf-8?B?bFpLS05jSzEweDZjMk55cHFhYjgzanpXc0JSeXdrZklpQ28vQVFHSEZETlRa?=
 =?utf-8?B?MTZYZXJEMlg0MnhNSHovaHM0N0JXdCtQd1k0RDlSUWJYRlp4U3ZsZW9pdnRo?=
 =?utf-8?B?MWd4bjV0WnVkbXhCQXB6ais1aU5LNFpuS0krYVNRVjFzTlF2Wlp5L0FRaWJX?=
 =?utf-8?B?QWo1aG5NK0gyWTN5S0lVamZpTEFWZm1GY3l1bTFPUDl1cC83Z2hzL0N4UmpU?=
 =?utf-8?B?M0FBamVZeG5Wc01Ga2syVndVbVR1eldXSW1LNkJ1SjlKNzcvSHdVd2VxYTUw?=
 =?utf-8?Q?BiWiV4LQWwr+VsB1X4MJZk0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wBiNN1dZDc65SSntQfZ24/pXdOPACefWZDDVksruogG2laof1VORZduwmr+nsWNW9aGxqYnv9NBj6/2ktgQU1hNPUqP118SuO+fliy+rLv9odzsIRWfgDbxG9w0HwY7eAUhngjCX4gAjtvf/RG4qxAX74UHxgzMjqvMjYSBw7QCESmzs/C2erJMyayAEXeILJaC8bVP+UIu2nBKoIakOt7QOZjOvW5I9HshuPfnCJkk9zuRzm+nByq3m/81DDgU+pJe8QElqM6fz5Pf1k1kfTs+i+fautBQmzKQW9m2pmX8GH93Eh1AwPJzOXLp5w6GGBadIT6smpxTq8UwnjEQru2TvlY8HDjgzigHFnxxbN0LIwmKAr/fCwhZmPJSqai7T6hIcIgvrc/f0PCuQB96E3qY11gSk5SccuHYahk7VgK8mYVxQohOV7dHg6d8t4ZWopPsdCZAVSxQVft1HJFvBZKNFbRLp9G15P7DO58M+/9dhb5Db4tNbN/sbAF/f/6V9GQhk5HGk52imHtUfZuKnDA90jGH53/fieQjn+Kb9FLSEro1aRZmzOo7C+vYB6fyeENzyV9wP4Dzz2zr3NlR7VLr1Pdf2W1GhiNurl8SpZTHs8/BLznEMzMAc2tDdwUOrNb7qjO5Qo/jVdl3CuWT79Mb+rF6dfXiHagBwJf32kWud/phLAQCFu9LUK2uvntKY5xTP/8VkGDK3S7K2GkxEYVJQpw/241/ZWQEfsjpjXC+F0W/Cv5GRhk8pMCqFxtVabhigOABkhCTHV60F8C2l+SB9DXJ2TCZsRoesHumPu9OrLvHyFa55gicltG1xVYkHHb7qz9PV8egEAseL0oiBgIc/CMJ4x3eQpue9Shp7xgw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 063e8306-f3ee-4bd7-a0ea-08dac66958e4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:54:59.3948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HSBdPcejwOtdI9fwDpj+rGgqDYcNRGJvadghTGeWSHkGb8bEQTFXcaOcYkykq/CL4AjbbZUU19x2DO717qiGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5215
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211140128
X-Proofpoint-GUID: 02IIEAlDUuss5xxbmf4YJU8FYnWDoG5D
X-Proofpoint-ORIG-GUID: 02IIEAlDUuss5xxbmf4YJU8FYnWDoG5D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 14/11/2022 17:21, sdf@google.com wrote:
> On 11/13, David Michael wrote:
>> GCC 11.3.0 fails to compile btf_dump.c due to the following error,
>> which seems to originate in btf_dump_struct_data where the returned
>> value would be uninitialized if btf_vlen returns zero.
> 
>> btf_dump.c: In function ‘btf_dump_dump_type_data’:
>> btf_dump.c:2363:12: error: ‘err’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
>>   2363 |         if (err < 0)
>>        |            ^
> 
>> Fixes: 43174f0d4597 ("libbpf: Silence uninitialized warning/error in btf_dump_dump_type_data")
> 
> Probably better to reference the original patch?
> Fixes: 920d16af9b42 ("libbpf: BTF dumper support for typed data")
> 
> Acked-by: Stanislav Fomichev <sdf@google.com>
>

Acked-by: Alan Maguire <alan.maguire@oracle.com>

Thanks for fixing!

>> Signed-off-by: David Michael <fedora.dm0@gmail.com>
>> ---
> 
>> Hi,
> 
>> I encountered this build failure when using Gentoo's hardened profile to
>> build sys-kernel/gentoo-kernel (at least some 5.19 and 6.0 versions).
>> The following patch fixes it.  Can this be applied?
> 
>> Thanks.
> 
>> David
> 
>>   tools/lib/bpf/btf_dump.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
>> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
>> index 12f7039e0..e9f849d82 100644
>> --- a/tools/lib/bpf/btf_dump.c
>> +++ b/tools/lib/bpf/btf_dump.c
>> @@ -1989,7 +1989,7 @@ static int btf_dump_struct_data(struct btf_dump *d,
>>   {
>>       const struct btf_member *m = btf_members(t);
>>       __u16 n = btf_vlen(t);
>> -    int i, err;
>> +    int i, err = 0;
> 
>>       /* note that we increment depth before calling btf_dump_print() below;
>>        * this is intentional.  btf_dump_data_newline() will not print a
>> -- 
>> 2.38.1
