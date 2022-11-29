Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC41F63C4FB
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 17:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiK2QVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 11:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiK2QVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 11:21:43 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87181BE9D
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 08:21:42 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGEweY005237;
        Tue, 29 Nov 2022 16:21:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gRZmyrGFTjnRILJjzTDg9r9wGgjUAjf3H0yNrN8eKkA=;
 b=hOu0QjZW6FyL/PPUNi1z4V8NsgT8ourA9W2VICVKV3iD4+oS5VRg1h8TirJxg0wsRlEB
 TRxSqYJ9mtaztkl/CiSUonMdAkqwnP4uzbOA2O09sW5B8O8uck4WkZWrQ4XI4w5y3OBj
 x+nVoC0hXe+mHh2iNnkZCxaNGq1ibJtWK0cerSw/Q+noQqZqRzsn4C7L670XcMJw3+OT
 bPLj0X8hl/XYyUXdPujxW/xs86NXUhFrVAa3hiXo6LFrJNKzmz8i3ENpT9GcYmtngE/i
 hHMp25SjiEUO8PP9KHnnWIw1ggXSsBSM8TrcaHp5jraQ9rLbfwRKs+XF+rTj/pHzk6Zn qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m39k2qcma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:21:30 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFhnec019449;
        Tue, 29 Nov 2022 16:21:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m398dppde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:21:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dV3xNC/pImeFbIVSG6RlYXdnzdSdu9Co/tc1BD/FxYKyUalLEo7kaj3Dat7MsyojAqTPFmWsYR6Ufo7xVeDnFzvyPPctDOg39XgiZ3wswQKqVTN8sNnshcwbIaRbHnf5QygUKeGAgsuLFa4ZgPKignMjk64YzDM20YllV0FdniwT6msaFY1X8vfK7ChCL+W/ePUNQfJUBeZToDVHjWR+P7IwBijU4M5DTajC1MtgMmOyTk9nd/a0kEw5dJ29xu84xljGLAxTASiMrhYPj2uHskfC1AzH3IU9nv91lVyP/URG22vzryYOL/LgJTIK5i+doOWnfJ1OSe01w6717+8VuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRZmyrGFTjnRILJjzTDg9r9wGgjUAjf3H0yNrN8eKkA=;
 b=A6/H0clwa5IzO4eknT+w7hPKTOVL2QnVxpzsBwC37XrYRFzoQQUtIUGm/pfEcOzvJ4nKkZTVWh6qibjPtQVDQmtQ/ou3RGQx4I+dFNByWXX/tknA1SHZdteq+RPu2T4G+CZrjYIi0UBU/KHDnp2v/ULhXl+zt4v2nAuRD7KBCo533fwpzwAVSxYtBMWrZXWLHNeMzpAqoXII0zF4D7QDqBdk/aqgS7jSOjd8+kYyWUEDHxgZur3MULBBrLe1KdS9ATyZMjAPya46tjzRP7JYHrPoEEJsvfWuvSZ7y6GjlZBuhzk5WUnnIZs+WNIdSQ92sue8Xo7xcZV8pp+ElStPLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRZmyrGFTjnRILJjzTDg9r9wGgjUAjf3H0yNrN8eKkA=;
 b=aYLLPNBckLH6ydLlAwYb1TKO6BnBmy6HxpJPFh/nNW1vEO3AJPpLGr1dd/GfW1UVoQYEH9C++ei6dkZ6QlHixlcG39Lh11WO6YzF3WSgeKoOeMTtGcqzakQhE/sGFxiYEGlvDbQfKlS39B4Gu9vXhTRejDi1L0OsYDqTpgb/Uh8=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6297.namprd10.prod.outlook.com (2603:10b6:303:1e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Tue, 29 Nov
 2022 16:21:27 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d44e:a833:13b5:4119%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:21:27 +0000
Subject: Re: Calling kfuncs in modules - BTF mismatch?
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Jiri Benc <jbenc@redhat.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
References: <87leoh372s.fsf@toke.dk>
 <CAJ0CqmWO-MsjL3i6pfATJ=JakbnTfQmwKmruz9zEM_H-sz1_uA@mail.gmail.com>
 <875yfiwx1g.fsf@toke.dk>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <08fa5e85-4d7b-4725-f340-bcb8525036f1@oracle.com>
Date:   Tue, 29 Nov 2022 16:21:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <875yfiwx1g.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB6PR0601CA0043.eurprd06.prod.outlook.com
 (2603:10a6:4:17::29) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: c5969ded-747c-41db-ef51-08dad225c44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyvbDmjGAv02LyWcPALqV44z3SJxh/ZbS9jYZ48vVA1RD57SnyEl91nyoO4xZRmFq8wzd7gCLZ/rGEzdz+Y5npxlZwq87sHGITloL2yKZDTYRpiWeps8+EpCJIRkQPq8Ea2DUSTcj7M3bP8IrS1icg97h0AvvoOduMjmAki4oT/D83r0UPkfX1IEOsLLFYiPG6uhVClwfgodImMrsdI072k38Vr4hJLIGK1Qw3vNKm22vkv5g/ThwYR9zEY705HkvcUqUEqYf2c+PaXwO3ixohZynYA21eCQTDjxeHoTWHS/ePWUdAdCeKJgoBOBhn+3HE2Ndaqat2X3tseJrp6LVqYwJKDXgCUO4blTpVu2HQXhmAMWjXBZ9J4gCnmN1onacyepn/4WlEVndqXqzJz0fkQrGeWtQY8bdkNssDDQG5pNbBfLe8tbTcJEwzhprk/FlHK6+dzgGpw2NhLvMgOMGxg6ZLvpm7ZMuL9AHsPvJ8jUT1MZyU9X6IakcJbmS+Xw7UxY5hARLRyOLU4UYTZiwU4whV7aEWzV2r3BUKp+uJf9IIEUaPvsFngsGMdNde1EgJMUR/jhiDjInBhhDkJVCkHOzMHXqcnaUY8PnwolvZ3aqJKrSYrCHX+nhXi1mHdW85Zng5SKSJf4XsfX1/YfNa7y1ld1XTe1R8iczRVIBNDldQITfGO6lxxmuULq+EPoHq2yYXcSxtim433hNq4k1jLpVgom9TRnM9rbYZxxQM4crBPicR8OBKHmABsLUBHX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(966005)(6486002)(31686004)(38100700002)(478600001)(66476007)(6512007)(66946007)(66556008)(6666004)(2906002)(8676002)(4326008)(83380400001)(66574015)(44832011)(5660300002)(53546011)(8936002)(54906003)(110136005)(36756003)(2616005)(186003)(316002)(41300700001)(86362001)(31696002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkFtQzZTR2xDM3ZYS3NYR2RsQ0tyOFNQQXBrV0Z2eDdhRUxzTjBpdjVuaElT?=
 =?utf-8?B?bmJoVm9MUS85c0lZd0xhKytGOW42OTcrcUswQVlsUTFrbUVXNHRvbGpOdHNr?=
 =?utf-8?B?S2RCSlRNSFRuVmdrZEtZVnZzM2kxT2gycnJNSU5wUEZUOGdBdUFMOGVIUHJa?=
 =?utf-8?B?N1JPWXJMKzA2bnN1bDlLMFkvYlpHS2xrSmtQejJLc2hTTG5xNndjSXo1ODRz?=
 =?utf-8?B?SHlYTHE3VWs2Z1dKR3N1Yld1TDJkQjl1OEpnSXBGY0hGb1BEQVUyNmJnWWpU?=
 =?utf-8?B?V1k2M1FxL21SRUY0dWpVU3hRSmhWc2hFZkxuRDdSNUtpaFRDQkpFVXBtVVBw?=
 =?utf-8?B?TkFrUldHR3FSWE5CVUFQWm9xbmt2R1NXNmpnRlFTYW13d0FSZTZkaEw4dmR1?=
 =?utf-8?B?ZURVTUhsQmxXTDJkYjJUWEdwUytiM3B3SkpJOXc3aU9YREJhT0ZrVUU1ZGxy?=
 =?utf-8?B?S0FjdVhoZkE2YzRsWG4xVDVHOEJEOXFUcjhJd25SK3p0K3cvV1VxUkJWakhZ?=
 =?utf-8?B?eGVITUxCRkw5V0svSTBtelNPNDJEOVN1Zk9Kb1RBWG1QS3E5QTUzSzIwZm5B?=
 =?utf-8?B?eXU5QUxBVkhuOFNPNjZXYVVSSDNNbGlxQTVBeExHL3NrVDR5Qlh0VHYyL1FH?=
 =?utf-8?B?OUVScXFTVzJDZThnR2svOTJRNlU4bUpDMW1ZTllFZEl1VFl4MUN4bFBpRGdT?=
 =?utf-8?B?Z2pIRzB2b0lpOGlLbi8rK1h2dkdlYmdrWlZUVC96bTIrcUZvYy9kaGxGMHJi?=
 =?utf-8?B?cmxGK2RMNW14RVloa2xjcUlmNjlZWThSMjhTVlNKeWVUMElTUXcydVYrNkgx?=
 =?utf-8?B?VjB0YnI4ZjN1SXRGeWsrdS9LeTZEc242MWltVlh3czhTM3hXTFlJblZCUU5F?=
 =?utf-8?B?OHNVWnB2Z21EbXBSWk10VncycFdFRytKSm1sUjFiUlRhdGw5bkRYa1ExcVR4?=
 =?utf-8?B?Y2ZKWlUyMEwzVUgrakxseG1DdjhYUVE0bGxzQkZoQnNpdVdxTWFNc2xISHRa?=
 =?utf-8?B?aHg2SzlhaE5maDV1TVFMOU1mV1l4ZUtXNkpNUjkvMk5qSGlFVnNpV2hrSTZI?=
 =?utf-8?B?bVJ4dmlEcnJUblZ6QllQdXdZeUhmQUV1aklEQ2hSTG9GUG5qeG0vTFo3K0Jz?=
 =?utf-8?B?c0lSazVwMllRZkM2TzFuWkVMOFdkck1EeXZOdXI2MVIwaGNMU1N2YVJYaGlP?=
 =?utf-8?B?WmdyOGtnRXhSdGx0bHdBSDJzbGpxQkZUdmNxR1Nad0Fzc0RObXcxOW1EeWM0?=
 =?utf-8?B?K2VsVGJXNjZueXlGV2Y1ZFdVTXloTnhvV0NiNGMyRENGS0labVUrOTZmd2cz?=
 =?utf-8?B?c0RPMTBxQldHTmk4ekphaWUyNUFtc3NaN292UTF6WFVvaEVsOTVQQk9ZWXlu?=
 =?utf-8?B?bVlxT2FDYkRHWSsyVk5kcUNjZGtGdFVOYzdLWUY3Vzg1Rkk2eUJOZEpodERQ?=
 =?utf-8?B?YVZ1YVRscDAyR1U3bTJJR2RKT1dWeDZqM1NuaEt0RElTSjI0dDFzbkV5eTZX?=
 =?utf-8?B?QUg0L2J4VW00Q3J5amVlU3l5Y2poRlJiZVJ2SDBCRThrdDVmTW5JTkZqa0Y1?=
 =?utf-8?B?OWlDT2lwRUJQRit2NnpyNy82Y0JxSER6b3lFNVc1OGdGQ2p6Y3M5ZFFhOWlY?=
 =?utf-8?B?Zit3RjdVSU16UFlKS1RydDZpK1pkK0dUMjd4d1VlMm5ueThoVGxxQXpKRExq?=
 =?utf-8?B?Ny9sSXZ5eUQ5dy9XUlZyZmVOc3FzQitkbkExL1FQRk50dG9sTFlkMWdrN2FQ?=
 =?utf-8?B?S1IySEVWQUFmRGFjMFdMYUJtNWRQR0l4ZXZVbGYxalQ2UEFYeWtOc3Q3dkdz?=
 =?utf-8?B?K1M1dGZ2bTF5dXhFQ2xndkUzQVdNd05VcXVXa3RlQ3FJc2RlWkJqMDQ3RTNv?=
 =?utf-8?B?MkE0ZkVTTEVnQ1dVYVhoRG1tbVREVEZmSFFNY3V6ejhaQzdud0w2dlZoR1Jr?=
 =?utf-8?B?Ry9oWFl0VVZBdEZsUVJGY25YaDdBb0NqWWxXOUdYNVhybThaM2U4SEpnV29h?=
 =?utf-8?B?WFBsSXFwWHp1dkc5QkNsMXJmdzk3VlU2N1RuSi8wVnlTVFdCMER4dUQwU2RP?=
 =?utf-8?B?Y2tObW11T042eVdZV2hyY3ZUaXBqMlZCTWZPUjdJZDlGZnM1YXQyQUF4UE5Q?=
 =?utf-8?B?SytUSFhUVHUwSXM5U0JaQ0kxTXgrYSs3SkU0TmxvSGoxK2s2YjdFdjVjcXgv?=
 =?utf-8?B?aGNlYzZQNlFZZGZTRUUwK01jME12SkN1VllHdk5Nc0E3Z24zcG9VclNrVCs0?=
 =?utf-8?B?WU9qWjBSTHZYUUxmd0VqMEFrSnV3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?N2MzdUJSejd3UXRMRUFmZ0Y5MmJUNG4xaWFUL2pjQkszd25HYnFIOU9WWWJ0?=
 =?utf-8?B?OHhoRlNUWGZZK3NWSkVKMlhBVEROZVJXL1c0ajZZZ0loMUVhOHdxT1JKWTY4?=
 =?utf-8?B?bFJldFVWTGwzZW5CNFFxRFU5RUhySytHbmRqdDltMFJxUUdialVWTHBFcVlF?=
 =?utf-8?B?ZnpwQXljNlQxMjNkRnR1d3VzZlp1QXVnZnVaU3p4MElyaVpmeHYvTXRJdzNm?=
 =?utf-8?B?cEp1bXM5RlFSL2s1bDZDZnkxdXNOUm1QQXo2SkJlbFU3d204Qm9kVk9RZFFs?=
 =?utf-8?B?VFRKU2VhNEMwRUxmYlVaeTBSMG16ZWxaV0ZPOHpvbXFCbUFKRE5YNWdXSW9I?=
 =?utf-8?B?ZDlPbytaWEJEODRoZVR2QmlqZG85NjlNbVNNV1dSajl2c2JncExTNzBYVHY0?=
 =?utf-8?B?ck9nMjhmNWxiUy9XaldPYWVwVUxjelh0c0s0NDR5eThBQTREd2FQMzlNdkZm?=
 =?utf-8?B?RnhoUllDTEU3S051anhBamlCOURteWxHajVFKzRKVUpnYVlkTHQ1b0FmQmdN?=
 =?utf-8?B?YkZaTkZOM0g1eW41ZExHczdJOENIS09xckx0Zkw3TFZaSjV5amhMbVVRclVz?=
 =?utf-8?B?aDFFTjd5alBwVXpEdUU2cGExaEYwdUZDK1JObEQ4U1VJOFFpbFk3bzhHRC9r?=
 =?utf-8?B?RXRUV04wQzBxNk5MWGUyS1ovN3FuN0dSZkNWbFpqR2RZUWNlbk05MDZUTjJl?=
 =?utf-8?B?NVF4cjdURUkrS1M5ZVVOcVRGM0dmNStsSXY2MnA2dFNzdWRMSVBvdU45OVNu?=
 =?utf-8?B?d3BoODVYQ1JpRXRaR05HTTZQc2pTN2xSWHFyNnBiSXZpNHVXbW10SWN4dGdC?=
 =?utf-8?B?dXh2cms3alo0QzVXdnZlK3B5NG0vaWQwai9XdmJobWRHNHczOFRESVFDSmpB?=
 =?utf-8?B?UldBYmk3RmhGY292cEpyN2JxS2R2bFRVMUYvV1JaR0R4bjgvcGhsZmp1NnNr?=
 =?utf-8?B?THBsTXF6QVlXYjAzczJ4Mk5LaE05UEw0K3JJUWF1dGEva0ZuMXpJTFB1ekpt?=
 =?utf-8?B?OXQwODNSc2k5ZEFBcnR0ZnhKQ1Z6QW8vNjBicWZDT1l2K01NbUcveVk3ZFFa?=
 =?utf-8?B?U3BRUHVhNmNPdEF1bzJNeUt4TGdiYUNFUVlUUDc1Q3V4a2ROYk92U2JLSFBV?=
 =?utf-8?B?c2pDR3N3TWpibEZHc3g0NitYTi9NanhTeUMyVHhHb3ZoOUtkRVIxSXE2U0xU?=
 =?utf-8?B?Qkhtdnd3U3NXY1I4WUc1S3lnV2ZuYjV5MEJwa3RwaEk4K2VUMHFFaEpYT2ZY?=
 =?utf-8?B?QnBUbnlkMHpIM2MzbXR0MmEvREdzTXkrc0xxOGoveXNjMStIZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5969ded-747c-41db-ef51-08dad225c44d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 16:21:27.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b23nVZAiD3pYoPHHeo872+5Ji1huZtHw+wxsBJ43QKqiZVVDO3+f7kT0HmYgUT35pcgMqh7knjgfaobO25rfzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6297
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_10,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290090
X-Proofpoint-GUID: JjcbGtFAskF5YD13x-PzT_sbBMW04B7H
X-Proofpoint-ORIG-GUID: JjcbGtFAskF5YD13x-PzT_sbBMW04B7H
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 13/11/2022 18:04, Toke Høiland-Jørgensen wrote:
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> writes:
> 
>>>
>>> Hi everyone
>>>
>>> There seems to be some issue with BTF mismatch when trying to run the
>>> bpf_ct_set_nat_info() kfunc from a module. I was under the impression
>>> that this is supposed to work, so is there some kind of BTF dedup issue
>>> here or something?
>>>
>>> Steps to reproduce:
>>>
>>> 1. Compile kernel with nf_conntrack built-in and run selftests;
>>>    './test_progs -a bpf_nf' works
>>>
>>> 2. Change the kernel config so nf_conntrack is build as a module
>>>
>>> 3. Start the test kernel and manually modprobe nf_conntrack and nf_nat
>>>
>>> 4. Run ./test_progs -a bpf_nf; this now fails with an error like:
>>>
>>> kernel function bpf_ct_set_nat_info args#0 expected pointer to STRUCT nf_conn___init but R1 has a pointer to STRUCT nf_conn___init
>>
>> This week Kumar and I took a look at this issue and we ended up
>> identifying a duplication of nf_conn___init structure. In particular:
>>
>> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
>> net/netfilter/nf_conntrack.ko format raw | grep nf_conn__
>> [110941] STRUCT 'nf_conn___init' size=248 vlen=1
>> [~/workspace/bpf-next]$ bpftool btf --base-btf vmlinux dump file
>> net/netfilter/nf_nat.ko format raw | grep nf_conn__
>> [107488] STRUCT 'nf_conn___init' size=248 vlen=1
>>
>> Is it the root cause of the problem?
> 
> It certainly seems to be related to it, at least. Amending the log
> message to include the BTF object IDs of the two versions shows that the
> register has a reference to nf_conn__init in nf_conntrack.ko, while the kernel
> expects it to point to nf_nat.ko.
> 
> Not sure what's the right fix for this? Should libbpf be smart enough to
> pull the kfunc arg ID from the same BTF ID as the function itself? Or
> should the kernel compare structs and allow things if they're identical?
> Andrii, WDYT?
> 

There were some dedup issues fixed recently in pahole
and libbpf; since dwarves libbpf hasn't been synced with
libbpf recently as far as I can see it won't have the fix 
for [1]; I suspect it may help with dedup-ing here. Would 
probably be worth trying rebuilding dwarves with a libbpf 
with [1] applied and seeing if the dedup issue goes away
before we go any further. If it fixes the issue, would it
be worth updating the libbpf that dwarves uses Arnaldo?
I saw some pretty large improvements in removing
redundant definitions.

Thanks!

Alan

https://lore.kernel.org/bpf/1666622309-22289-1-git-send-email-alan.maguire@oracle.com/


> -Toke
> 
