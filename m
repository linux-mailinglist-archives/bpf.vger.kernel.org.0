Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE58B204207
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 22:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFVUfQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 16:35:16 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37842 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728361AbgFVUfQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 22 Jun 2020 16:35:16 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05MKUF2d015011;
        Mon, 22 Jun 2020 13:35:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=T9tBL5HNU6WLFVQy10eBCF2nbwY9FnfJpeOVpKw5riI=;
 b=L+Vkx9MwZ8ipenoEHR7tP35mlryKtlwKcQob3lpHebULJG+cSiBDTLSIMTKn0JUmm5xu
 Z97Cv3kIxc3pz48bCymnbiJQ9yntSgTdslyMTtkv5A++lWQ1Ta5phu51abTeKEg0ZeQx
 Ze9LWxiV8Hrsz1xOMTAZ8QNB8LvBmgRlDyg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 31sfykt6yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 22 Jun 2020 13:35:02 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 22 Jun 2020 13:35:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDCKD4oFcgFaC8i25y8zgjHg1ANbW/t3SygS2t3fTJXzc4os3LARTjOH7mdQg3lD/zbT+I7iHXf2Qv7VI95BWwLypzXkTrJD5Du1fhbf/6WaaCgwc1AHGeIfnrIMQrpiIXwVzXsLG+q6ObL9hna4FG1rux3wcluMEzHalj4k66YlR0fpK2reN6/TIXF1HmMPAGRGl5HS1kJMoSXEmSxEVAVgrxcSyK/pk1kxK/KjyrmnB4uE1jF6nlMYfW6DLn5hQwJYK2l2LyZzx3sv8Bo+Ot0b3kb1Qj38I2K01+rPpTpPBgw0YM7D/toZgzW5zoE9shWjb09u6GJrsyrIiIpVtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9tBL5HNU6WLFVQy10eBCF2nbwY9FnfJpeOVpKw5riI=;
 b=YZk2eGZd7HAPrcdG+eJ8CbEpd5RSKMq3U1Bfg8XSWXuyqCRAjtYAWxsY9xC3zQJpoGboowQGUFLVYomwfko8bscVTg2knkhhEz6AURXDPkLGIzqyo17nNdGxzxmoWw8itETHs2Dba7grujvjcPIiwd+BzR+YrgvCEU97wgFEB5edtbm5sLmRL2oqq2/InLHIndFYPKoBZpn1AKoG3SIwmHuNzmztH9kcVjdmwtNps76XaKyvPY96zCRFXJUM8Ei1E0nI/pXFfFvyDaRJ9SJSIf5m4PEKBCsquY2mDBrEc+0vuyDGw7JhKNvaMxK5ppg5PJiF0kpaQZJORBRnbaVKUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9tBL5HNU6WLFVQy10eBCF2nbwY9FnfJpeOVpKw5riI=;
 b=GOt8WmmMN3TqzCES/V0lSOaG+jjo85OOM5FBgZstK/JHqzBhZGIHy2FluqrhyUao8CAo6nUPDXJ6AWXvtReZUTBmL5mGi9pvdDtCZvY3RkOYz6Vft5GqO0JYrWWs4nrEnUAgnq0WhAE3IuPMmXJEousOpoUGQhMmj4pXu3XCQc4=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3192.namprd15.prod.outlook.com (2603:10b6:a03:10f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 20:35:00 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::4922:9927:5d6c:5301%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 20:35:00 +0000
Subject: Re: [PATCH bpf-next v2 00/15] implement bpf iterator for tcp and udp
 sockets
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
References: <20200621055459.2629116-1-yhs@fb.com>
 <20200622130804.62099862@kicinski-fedora-PC1C0HJN>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4c5ac28a-b273-2a50-7ba2-89a930d34b5f@fb.com>
Date:   Mon, 22 Jun 2020 13:34:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200622130804.62099862@kicinski-fedora-PC1C0HJN>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0078.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::19) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1718] (2620:10d:c090:400::5:f61b) by BYAPR07CA0078.namprd07.prod.outlook.com (2603:10b6:a03:12b::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 20:34:59 +0000
X-Originating-IP: [2620:10d:c090:400::5:f61b]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93d9214a-9d04-4dd7-b19c-08d816ebbc46
X-MS-TrafficTypeDiagnostic: BYAPR15MB3192:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB31920CE40952647D586CCA27D3970@BYAPR15MB3192.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NrCFU7OU/tmjujfywMdF7XOTNBLI4Dd4aReLABbHuqNXQg6/vhij0cRLmnaXx7tJlmKspPuMEp/lwHUDq7+MYlMG1E8HNePU2MQ6V/BWw4PgK/l0LoNxsuHV0ZiGd/H5IjKP8vjTQknR9aiQl0vbHqQZmjEKU0tZJRYWqhyH9cAClrYFvA5LOE+vbsjhVFSq3DuWiLgi7Yl35838nf0Wn2eXA81aq7Lot6OmqliJK79KRYrmyNBoEj0jCJzeJZ1VkqsJrvcliNJ0JEX4WBDHtI3wmnNcFIK98QIwCJ09eiIpVgiY1kFpXd2YRCDTCFKd7/FDf3srU1aFrGOIJe+2oRq9A8SCl2ATjqygSsh88H3SXe0EejrwEtnJtnienfFk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(136003)(366004)(39860400002)(396003)(376002)(54906003)(2906002)(66556008)(5660300002)(6916009)(66476007)(66946007)(31696002)(6486002)(4326008)(86362001)(8676002)(36756003)(316002)(16526019)(53546011)(52116002)(186003)(478600001)(31686004)(4744005)(8936002)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZsUYmfHk86p3MsW8ucANsR5hrBK9iBoqoxMq54V7JD987bnoGwNdQOPKLv+8/hndPTDBcCO2r3t6KzJD96zHbggDRvxSjbRnEXxjztPsXneOCLWLHlXY1rZvvUAPMutVLpfYjIoNQkk4HNHXISEXxYLCa6MfKFxuvRSbAu1XZ536W9n4mlZF9ROjArHUD52ErshDPQpOMcWifGAkViiGzt51g/Ylh3bCqwnDohu1adKzNMcvuq1GUKfethRF5MZmM47ltjduL+ljiTIlw+BU+paFCBV/nsdSK0yap/RaD+1TeUdD6YfnLTe4lu5Im/jsXRzY5NOIOnH8FTo1bxpd2GLaM9jFJXP8sqh9YaId1vwXHNsngf8TYJ3SmEryK7aSs2At7FHUYibqiOaoaINSLNQnBkDfGxLv9psunoqlDEu3vDMCkWNJxB7yOzr7rDSxD51BEjXTfsWObHp+vkGrRJTaooBfE522PYoSeqM6lwUg6jEtayipRpaqOYtC2zTyo9yRpST05hESXlSwMoZqjQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d9214a-9d04-4dd7-b19c-08d816ebbc46
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 20:35:00.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x1NsD8Ymg1vylKvZNjrul3uJRgUGLq7DPCBjNBY3TOvAa9rKkrMpI8OGAT88zOFD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3192
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-22_12:2020-06-22,2020-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 adultscore=0 cotscore=-2147483648 impostorscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=872 spamscore=0 bulkscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006220134
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/22/20 1:08 PM, Jakub Kicinski wrote:
> On Sat, 20 Jun 2020 22:54:59 -0700 Yonghong Song wrote:
>> Changelogs:
>>    v1 -> v2:
>>      - guard init_sock_cast_types() defination properly with CONFIG_NET (Martin)
>>      - reuse the btf_ids, computed for new helper argument, for return
>>        values (Martin)
>>      - using BTF_TYPE_EMIT to express intent of btf type generation (Andrii)
>>      - abstract out common net macros into bpf_tracing_net.h (Andrii)
> 
> netdev@ has not been CCed either on v1 or v2.
> Seems more than appropriate to do so.

Sorry about this. I forgot to include netdev. I will send out v3 shortly 
also cc'ing netdev.
